Return-Path: <linux-rdma+bounces-6601-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6109F4DE0
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 15:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66BA16FFBB
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 14:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098121F63C6;
	Tue, 17 Dec 2024 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4kpEBsO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B544D1F4E3D;
	Tue, 17 Dec 2024 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445999; cv=none; b=RhGzppAOd6cSZiPNyHpoMtYTiHfSqbDHt+4NO0L0PRLqyT4WsYnu0TV8a5spMHlB0OhsBfsppNu7AH+PTIDqn3ovCEmobPxsDfJ7wizNz5wtzsCEopxFE14LDzTmYbNVrNrcEV7UqknjfLClwhrpa0gu37TTZqru2E6mAgvtwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445999; c=relaxed/simple;
	bh=PDwXOO3+Fr11L4z8efx2z/FjDlxsLzh4w4zld1r+Ql8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hMp+HtBHUOuwvAuQC35hnXNVnviqlVi7WFtel8729WryCcoQvA1wDrjYDtk7ahzjLWp9zanUx3iFo7oZX6G8YbhfDF+qmwVjzPVifSOaOvl6wScl7pe4dhk+bIj3IX3ii0baQ3ErWfhu6ixlnWIoaU4S66FNeQk+dljEntKWaoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4kpEBsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3E1C4CED4;
	Tue, 17 Dec 2024 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734445999;
	bh=PDwXOO3+Fr11L4z8efx2z/FjDlxsLzh4w4zld1r+Ql8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=G4kpEBsOnr22gq45BpH+OZnghY8GVLRPtH1jOS88Ht1eSETPjud1VLTj6jpBVEGja
	 C1YNYcuMRaidE5s7de7k4cRs5Gq1TwJi2QwJqKkzZ1GkjO+J37xk5JTa/rWZfrRjNq
	 A3uK5oyMGPJKSIh//LftP6E9l10eiiCblzShE2wEBT7ouJuIf9Uck2Bt53Xn7IkCU7
	 TEe30dg82Ww6QsQIN636gtyWiHADGU0361HraX35O9NlLXtfMYrBPV7zNsQcpPoBfH
	 ZBxSAfW/jRbl7m4bxvf3UNW1sHWJkPGTTP2HSum2qPACFubzT7d6gZHHvcWcU39b+n
	 dAttGQ8NRIrqw==
From: Leon Romanovsky <leon@kernel.org>
To: dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca, 
 linux@treblig.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241216211914.745111-1-linux@treblig.org>
References: <20241216211914.745111-1-linux@treblig.org>
Subject: Re: [PATCH] IB/hfi1: Remove unused hfi1_format_hwerrors
Message-Id: <173444599565.281955.1289295602203698100.b4-ty@kernel.org>
Date: Tue, 17 Dec 2024 09:33:15 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 16 Dec 2024 21:19:14 +0000, linux@treblig.org wrote:
> hfi1_format_hwerrors() was added in 2015 by
> commit 7724105686e7 ("IB/hfi1: add driver files")
> but never used.
> 
> Remove it.
> 
> 
> [...]

Applied, thanks!

[1/1] IB/hfi1: Remove unused hfi1_format_hwerrors
      https://git.kernel.org/rdma/rdma/c/2dab32d1c79c4f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


