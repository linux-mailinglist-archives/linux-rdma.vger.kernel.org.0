Return-Path: <linux-rdma+bounces-5731-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F399BAE4A
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 09:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E34283252
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 08:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808E918BB93;
	Mon,  4 Nov 2024 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA+bIeoG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B3A18B488
	for <linux-rdma@vger.kernel.org>; Mon,  4 Nov 2024 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709553; cv=none; b=odVZwCEMXXHMBn77pM7kYX8zDUiue17KxcrgbIFRIDaaxrajK1wFLaM/44C0EWcGz8nLuv2PB+K0AIVLNelK9ZhnyTTD9tcoLohyV0ZW12JnR45iVO+zDIqyhSTZWbiIbw6QKPEpbDfwSPoBcipSjTv8C9ESvQuYdtf/ppeFXe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709553; c=relaxed/simple;
	bh=5vj/smWy9ezJQO/o0NP+cBUMABFhHtn2os2i688/u5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qdhvUTIwAu3yyulN5TzQJuH1P0eainP8Htqktwh98DUPiBo6po+yY/Gz/vTRkSrkMP4FhM/62pAKpG/a+hVPjjrMC3dQQARep0YRETAbBuO5p5Kj61v9bNmH/Y1aIy8JGxUt2w3fzTXWGriC0eNjOJNb5X2si4QytyB4LMqzR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA+bIeoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28559C4CECE;
	Mon,  4 Nov 2024 08:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730709552;
	bh=5vj/smWy9ezJQO/o0NP+cBUMABFhHtn2os2i688/u5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bA+bIeoGPyo5lRURhJdtx+GncbwyzSmWowzuy1bxwsPBmBlICTrAzCEH7a0NOwM2Z
	 eQLAdVQ9GBFcqWx/JbiMRuPhwTp9MrCLPWOp2+7yA1AbreHCLGNXPy+tV5uL1SIFK0
	 JGRpTlf1C2nZyogo+kmZoCw79A4bVJn7qYpVJ8bmw6MlyM5AMhEQT/dS7U9upzj2fO
	 GzLx6gbGEpp81oLsToybNMjcHMcY4g1iITujT52pZ5Z4qGZG/8+5t7EabMDHaQo5IB
	 S3+vbx8S8qxmrBdUTlvQYmMW7JEPZQo7oyk+/NIDfTxsLbTIHgt06QXvD1MLaKHZv1
	 XQuPOMfLC82cA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org, 
 Maher Sanalla <msanalla@nvidia.com>
In-Reply-To: <828d57444a0a41042556bb0a4394ecf2fcaed639.1730368052.git.leon@kernel.org>
References: <828d57444a0a41042556bb0a4394ecf2fcaed639.1730368052.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Support querying per-plane IB
 PortCounters
Message-Id: <173070954875.155146.17895904661598131177.b4-ty@kernel.org>
Date: Mon, 04 Nov 2024 03:39:08 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 31 Oct 2024 11:48:14 +0200, Leon Romanovsky wrote:
> On a SMI device, set requested plane_num when querying PPCNT register
> with the PortCounters Attribute group.
> 
> 

Applied, thanks!

[1/1] RDMA/mlx5: Support querying per-plane IB PortCounters
      https://git.kernel.org/rdma/rdma/c/af58db354865a4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


