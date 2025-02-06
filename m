Return-Path: <linux-rdma+bounces-7478-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B1AA2A370
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 09:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20991889287
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 08:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30775225786;
	Thu,  6 Feb 2025 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH+Ih29t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C45225772
	for <linux-rdma@vger.kernel.org>; Thu,  6 Feb 2025 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831458; cv=none; b=d11VJc1FmYSV10KqMEySAQOkZWbp7MTPRvwrzjM+acy18Rre93OD3cENrbW643lUKTLO4NJBl9Z9wxsokDntjuC7dIV6ZChQ+p+Dam5k9njS0DAQHO2JwCv3BhnF4sY/SM741X6m/CUUM5U8nZiYOdEd2jydfvv8gUjrlem/QCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831458; c=relaxed/simple;
	bh=qKAS6yY7D1Rd5GO+rDTtwhiXsMaMte5Qyo0pbC++r0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lbRJ5TnePoce3M/2RFgEDhJlwPNJreYEdClIYurVbG7B7M1XbTT2bicyyagKrXN6ZjiJZFywWIPmGSCWvS7+buzFUrmgYyfxOQp2oRf6ruY/LwZpDVUQNK67I4pu72HjP7UGQq2tVNhWc6pItX0RGA+1FuMe6IwOMRfUyrOYWtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH+Ih29t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28DAC4CEDD;
	Thu,  6 Feb 2025 08:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738831457;
	bh=qKAS6yY7D1Rd5GO+rDTtwhiXsMaMte5Qyo0pbC++r0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VH+Ih29tFOFrAtXDAlU8ePh3r3NwmJHHpG5+s/rnRx4zsGvDQJMQXWChJ+MBcV1oE
	 kkz9jO+NCXf7MM27WDe1MAvpVnHp6spW3r3vHrhpwTIW0oAP73Ang99SvxMFO/1eMW
	 iPa4HB/PZ0vy3uC/IwhrGqvQyOfgBcw1qnSovSU/33VNFCMDrFtKfvezXWiGEJ3nVT
	 MFtpTOwIrDZZBH3FWGjiMVHMIU40z3r7Kb25v6Vz+N1u2Ty9Q10zxbR6U8HM+ZyNSu
	 01Y37VXNLVS08WHI7jSp9674pK5U/+yZ4Ht8AcI04rNCSL770j8hM7KTSTkHtSGnp2
	 +9mFl/zAkE10w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org
In-Reply-To: <2039c22cfc3df02378747ba4d623a558b53fc263.1738587076.git.leon@kernel.org>
References: <2039c22cfc3df02378747ba4d623a558b53fc263.1738587076.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix a WARN during dereg_mr for DM
 type
Message-Id: <173883145427.837391.1619837017878277233.b4-ty@kernel.org>
Date: Thu, 06 Feb 2025 03:44:14 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 03 Feb 2025 14:51:43 +0200, Leon Romanovsky wrote:
> Memory regions (MR) of type DM (device memory) do not have an associated
> umem.
> 
> In the __mlx5_ib_dereg_mr() -> mlx5_free_priv_descs() flow, the code
> incorrectly takes the wrong branch, attempting to call
> dma_unmap_single() on a DMA address that is not mapped.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Fix a WARN during dereg_mr for DM type
      https://git.kernel.org/rdma/rdma/c/abc7b3f1f056d6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


