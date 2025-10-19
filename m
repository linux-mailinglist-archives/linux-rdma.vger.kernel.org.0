Return-Path: <linux-rdma+bounces-13937-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DACBBEE463
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 14:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 628324E386C
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 12:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B662E54DE;
	Sun, 19 Oct 2025 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgrzxIld"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E612BE02D;
	Sun, 19 Oct 2025 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760875599; cv=none; b=RteeuxdRsFnIfIzwbOKHidd77jXVHYC2AmGsaIbN9S2/hz29V7ws+lLkR5nKjwcMwkhFOM4Zad1rkc2kM/7a4hKD40qsK22Ln3r6Y+sL+YG385GiUzyCHGAWBeHE2JF4StXrY6rNKCuiZB8Sy/LXtKpiGQq8IW2WGGe41DXttNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760875599; c=relaxed/simple;
	bh=jwTIPas7lC/lJexiriofL65Tjg4nkG6c33oxdib635g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mrSyPbBABPFuS3GgFAtITQCDikU0hAyh5XBVAAaeu2JiPKO/foGFbCPmLcslS/7qphgCv+vRWSFi9hMyRpTDszCXw5f3KRnpf9NdRQENIUsuJw2Tby/UFkvrIe8Svo7fiXkokAa1+bzkFfSzXvS5FgQesEHYABeB7NOcfypYT5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgrzxIld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9A0C4CEE7;
	Sun, 19 Oct 2025 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760875598;
	bh=jwTIPas7lC/lJexiriofL65Tjg4nkG6c33oxdib635g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dgrzxIldJDEKuCL8vvDMjQw9td6O8ceJbJJBRY1OuuWP4tqkIpI/HhX7TXdLOSDTE
	 Ocvefi24xNKrlWjWdQT5MpmKe+0K/eGm/TA9q1EXbstC7SgctSSXPef1rGGSG0fUnc
	 r+15BkRO2dvVifKiEMgQMyXEMV37KDwcg4XvSNBahBqVk7990MVsas2xGpp5jlmKpZ
	 e5KEMRML9+hdiQ08g2PM2XtmOQIL92s1rjeBmcOejo/HkMZFU5wG7SruP09cUUy+/1
	 v6udRpkG/QxDDRkNbKzHlrvEdQs2KYLPC0Cb7bU0h67Jzl94Ua3NZ98bgpbpZPj/Ro
	 CfWcxvKPvHaTg==
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-rdma@vger.kernel.org, Colin Ian King <coking@nvidia.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251014120343.2528608-1-coking@nvidia.com>
References: <20251014120343.2528608-1-coking@nvidia.com>
Subject: Re: [PATCH] RDMA/rxe: remove redundant assignment to variable
 page_offset
Message-Id: <176087559546.151380.14260477175096572642.b4-ty@kernel.org>
Date: Sun, 19 Oct 2025 08:06:35 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Tue, 14 Oct 2025 13:03:43 +0100, Colin Ian King wrote:
> The variable page_offset is being assigned a value at the start of
> a loop and being redundantly zero'd at the end of the loop, there
> is no code that reads the zero'd value. The assignment is redundant
> and can be removed.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: remove redundant assignment to variable page_offset
      https://git.kernel.org/rdma/rdma/c/1511efaca032ed

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


