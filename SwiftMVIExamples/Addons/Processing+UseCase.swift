// Processing+UseCase.swift
// Copyright (c) 2022 Gabor Nagy
// Created by Gabor Nagy on 2022. 01. 25.

import Foundation
import SwiftMVI
import SwiftUseCase

public extension Processing {
    @discardableResult
    func run<U: SyncUseCase>(_ usecase: U) -> U.Result where U.Parameter == Void {
        return run(usecase, ())
    }

    @discardableResult
    func run<U: SyncUseCase>(_ usecase: U, _ parameters: U.Parameter) -> U.Result {
        usecase(parameters)
    }
}

public extension Processing {
    @discardableResult
    func run<U: SyncThrowingUseCase>(_ usecase: U) throws -> U.Result where U.Parameter == Void {
        return try run(usecase, ())
    }

    @discardableResult
    func run<U: SyncThrowingUseCase>(_ usecase: U, _ parameters: U.Parameter) throws -> U.Result {
        try usecase(parameters)
    }
}

public extension Processing {
    @discardableResult
    func run<U: AsyncUseCase>(_ usecase: U) async -> U.Result where  U.Parameter == Void {
        return await run(usecase, ())
    }

    @discardableResult
    func run<U: AsyncUseCase>(_ usecase: U, _ parameters: U.Parameter) async -> U.Result {
        await usecase(parameters)
    }
}

public extension Processing {
    @discardableResult
    func run<U: AsyncThrowingUseCase>(_ usecase: U) async throws -> U.Result where U.Parameter == Void {
        return try await run(usecase, ())
    }

    @discardableResult
    func run<U: AsyncThrowingUseCase>(_ usecase: U, _ parameters: U.Parameter) async throws -> U.Result {
        try await usecase(parameters)
    }
}
