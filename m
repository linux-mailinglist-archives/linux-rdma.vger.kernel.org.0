Return-Path: <linux-rdma+bounces-8654-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F244A5F486
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 13:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D34D1741C0
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 12:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45CF2676E4;
	Thu, 13 Mar 2025 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJ//xiQw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371E2673BA
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869047; cv=none; b=IQ41I39wsDRMw05+TmKGmWDk6/aOllNBgHGoQPgWimjEIxIKRRcjRILAtZpSmp+t7HnH5Ow8ACQKI6A8MgtMccts8ZwOzJp/6xkSYj3XXKKJgQpo4OdEu2+fPw2FPG8Hyh2RZozSyqKYGzQqEejlrewA4m1iHG6usrnArGybtlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869047; c=relaxed/simple;
	bh=5nTIgge2sJFSOn+qC1rOXYSkyRWINnYKixk8qRjN0iE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=psf/izBjlHw35FmKLtl6/b+3YmchIuz8sCxwrSbSVBqcVe9DfVH1ZHv7F4AAD8BpLuyf9rZXJTeRdu9zGFm+sY6nGNcKk1Mo9Ii2owi4qpYcD2ViSAz/eW6XfTzyN7oagCycloZRXOQcgPU1rGA7ZbxzpT4WPT+FE0gGHISK7b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJ//xiQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E37DC4CEDD;
	Thu, 13 Mar 2025 12:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869047;
	bh=5nTIgge2sJFSOn+qC1rOXYSkyRWINnYKixk8qRjN0iE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=DJ//xiQwI+y7pSLP7FmE8znVQAiZ/gGk2IBWwS98qiHSXZK2pfG1PqttHwa1fSHtr
	 FxFF43NQb29lxC+ZK/ZXweh3/p4TNRaSCCmrmMMPv8ixjyJClebNVvzwZSGmGGnkEW
	 eeCJcFw8LLIg7hoTkwqoGDkGcnt0vqm+y3EorEyj+flwz5CzSuIBwVDi7fDCn0uQMO
	 EgnW7uMivxX+v53zBjcvdwYWx55/GUEh6kF4xWUOP4fLI3aXV1tiB81mAMK1p8ZkKG
	 27VFyuEwC4+dsWaz2HtcKNK1+T7bD7R3ce5/tNVQB/r68E4oJLt8LnK8O78hcyU0T3
	 3MC+a5X2kAheQ==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com, 
 Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
In-Reply-To: <20250313064540.2619115-1-matsuda-daisuke@fujitsu.com>
References: <20250313064540.2619115-1-matsuda-daisuke@fujitsu.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix incorrect return value of
 rxe_odp_atomic_op()
Message-Id: <174186904340.533535.18399916764241406851.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 08:30:43 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 13 Mar 2025 15:45:40 +0900, Daisuke Matsuda wrote:
> rxe_mr_do_atomic_op() returns enum resp_states numbers, so the ODP
> counterpart must not return raw errno codes.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: Fix incorrect return value of rxe_odp_atomic_op()
      https://git.kernel.org/rdma/rdma/c/9e98eb80c518e1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


