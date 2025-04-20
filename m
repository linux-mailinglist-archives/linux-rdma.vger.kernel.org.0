Return-Path: <linux-rdma+bounces-9616-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55358A94831
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 17:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3413B3206
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 15:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ACE20AF9A;
	Sun, 20 Apr 2025 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXQBrGWr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839BB13FEE;
	Sun, 20 Apr 2025 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745162865; cv=none; b=ngK+enNIUU2QZ9GPkzCDID/683ZNHc7en7yO8aIYY6cZX/+hEq93gN0VHoVShuFDxWbSo3Eolfq99JNOzshiYNvPl5QKgohKaz7w2MnGNt3e76EvM20tkTei7LjZOWidv7WVEDo56Zo1BteK1Ea+KCosA0ofL8FDbiO6ISw9lyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745162865; c=relaxed/simple;
	bh=V55SXw4UhqFu8GRo/A6cgKYLUZbR15vYqzt2fLxWWic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QezF+elver3eEzdexQZTKOeQVZQh2AgQ5pN0vViLm8QrA0q1Re6JD4oR/fbMNRD+DePV7FnypSMDTNNexozliPlXk/jj8N2DwlxuRa7cxR5I7VROxKOyrza3t/NIl86WeG+wSkdgq16/60ZqxvkT1CENvqShwPw2JoP2AmnakcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXQBrGWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF53DC4CEE2;
	Sun, 20 Apr 2025 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745162865;
	bh=V55SXw4UhqFu8GRo/A6cgKYLUZbR15vYqzt2fLxWWic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uXQBrGWryYPpuqt9FSAI+EZPcUSTj5qXYqNHOtPQpTospMijmLmHcldBbKKoiP6aL
	 1apX68U7KZX973Hl5+OJlWfZApa5pENvIABsQWTM+sD49m1w3HpxdepmMbNPUczzs/
	 wjl/Xt0MKBmwAgy50Shl3NZ1yxzzsfkVy2E5kLh0InunRVQui9nc1vTrXzlCEBE4is
	 +7v1x5eNVSDSvNdyNEoLyS1Xz+bSScUfA7XKov2FQXpuagBcxuldGGdKgO7Q0XNwjQ
	 DQZmb0izpME7vrDkWqmCvuBAaTGtyAyIDqO7aScwr4ar7DnnOIdOf4u7LzqG4NShOW
	 97k8L7I3cfuAw==
From: Leon Romanovsky <leon@kernel.org>
To: yanjun.zhu@linux.dev, zyjzyj2000@gmail.com, jgg@ziepe.ca, 
 linux@treblig.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250419132725.199785-1-linux@treblig.org>
References: <20250419132725.199785-1-linux@treblig.org>
Subject: Re: [PATCH v2] RDMA/rxe: Remove unused rxe_run_task
Message-Id: <174516286248.722194.12727712261042812715.b4-ty@kernel.org>
Date: Sun, 20 Apr 2025 11:27:42 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sat, 19 Apr 2025 14:27:25 +0100, linux@treblig.org wrote:
> rxe_run_task() has been unused since 2024's
> commit 23bc06af547f ("RDMA/rxe: Don't call direct between tasks")
> 
> Remove it.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: Remove unused rxe_run_task
      https://git.kernel.org/rdma/rdma/c/d85080df12f33a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


