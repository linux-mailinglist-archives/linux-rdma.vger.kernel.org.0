Return-Path: <linux-rdma+bounces-12393-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BC5B0DC03
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 15:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED5DAA8095
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 13:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8592E92C7;
	Tue, 22 Jul 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWpCDDLR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7692DC32B;
	Tue, 22 Jul 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192436; cv=none; b=Elo/0mqRCwHOPYpsJs24n+AlTrVShMPcIWZZrKalJE0z9Gz7xnbNsigX4/2usJL54c5OP4LvHdjNzKtFxLkn28gU8j7acNyGUK6O02lmNXXAw6tCoVnG9XrQ1QDP5CZMeJGqjZ3PrjQGWLPmOYttIFzzECiIK8JOW7J71WUBN/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192436; c=relaxed/simple;
	bh=sKOSzmoXKV5Kfr4cS4RUMoOpfNEeyYuAI8ozcq6VyA0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s3AD/qtquqLZfgQrdpy6OWw40H6dB2WNTwl5WhTK/J01nf8ajhH2GTrKZp1EpFfhBCH8Qv1AclIFOgkKEGPq+KJjk01hZrvJ0kIn7dsYkOB+8aFzJFkcJAq50/HUdUuprHWjZwJYXXOOdAhT3OyzZAMKLNvPSq1sNeT8nLaiIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWpCDDLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7999EC4CEF1;
	Tue, 22 Jul 2025 13:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753192436;
	bh=sKOSzmoXKV5Kfr4cS4RUMoOpfNEeyYuAI8ozcq6VyA0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uWpCDDLRO2Z0u6HJowBcQDf42JEFbzr/+a3lq1WpbbXQ2mb1Wjf542yL4+hKeTlCM
	 lNlJPhAn6m/JTj73UZl257EF9anQpLdqnX91uUCGLVvoPFaTuYFumyMfu4HCFw+HPJ
	 SZ6zEUdAOlrOZ0aWSIsNkX8p3O7MVYFJW19oTT3zkouthRC//1v1OorVc/AYTknXmf
	 eBrWEgJAB3TBVAdTrsDYhb9QGx2JwfHdTXri6yzNfoj4JBTac47dotKcNI5bsQPWFo
	 DUB0h9tDxk6R/JiODhWV58Vr0MCPx7zD/iNKanJs3Q7QuGehzvb10oAxc8jxOkathY
	 B0DhCyQ12RT8Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 Bernard Metzler <bmt@zurich.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Chengchang Tang <tangchengchang@huawei.com>, 
 Cheng Xu <chengyou@linux.alibaba.com>, 
 Christian Benvenuti <benve@cisco.com>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Edward Srouji <edwards@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Junxian Huang <huangjunxian6@hisilicon.com>, 
 Kai Shen <kaishen@linux.alibaba.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Konstantin Taranov <kotaranov@microsoft.com>, linux-pci@vger.kernel.org, 
 linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>, 
 Michael Margolin <mrgolin@amazon.com>, 
 Michal Kalderon <mkalderon@marvell.com>, Moshe Shemesh <moshe@nvidia.com>, 
 Mustafa Ismail <mustafa.ismail@intel.com>, 
 Nelson Escobar <neescoba@cisco.com>, netdev@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, Yishai Hadas <yishaih@nvidia.com>, 
 Zhu Yanjun <zyjzyj2000@gmail.com>
In-Reply-To: <cover.1752752567.git.leon@kernel.org>
References: <cover.1752752567.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next v2 0/8] RDMA support for DMA handle
Message-Id: <175319243278.1064286.6299486242708282132.b4-ty@kernel.org>
Date: Tue, 22 Jul 2025 09:53:52 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 17 Jul 2025 15:17:24 +0300, Leon Romanovsky wrote:
> Changelog:
> v2:
>  * Removed check of existence of function pointers in favour of uverbs macro.
> v1: https://lore.kernel.org/all/cover.1752388126.git.leon@kernel.org
>  * Added Bjorn's Acked-by on PCI patch.
>  * Changed title of first PCI patch.
>  * Changed hns and efa to count not-supported commands.
>  * Slightly changed protection of mlx5 SF parent_mdev access.
>  * Moved SIW debug print to be before dmah check.
> v0:https://lore.kernel.org/all/cover.1751907231.git.leon@kernel.org
> --------------------------------------------------------------------
> 
> [...]

Applied, thanks!

[1/8] PCI/TPH: Expose pcie_tph_get_st_table_size()
      https://git.kernel.org/rdma/rdma/c/723f8b98c6a538
[2/8] net/mlx5: Expose IFC bits for TPH
      https://git.kernel.org/rdma/rdma/c/b0409b4e14b651
[3/8] net/mlx5: Add support for device steering tag
      https://git.kernel.org/rdma/rdma/c/d3a2ef08a0ed60
[4/8] IB/core: Add UVERBS_METHOD_REG_MR on the MR object
      https://git.kernel.org/rdma/rdma/c/0c90560d0d66ea
[5/8] RDMA/core: Introduce a DMAH object and its alloc/free APIs
      https://git.kernel.org/rdma/rdma/c/9261a3b61acc20
[6/8] RDMA/mlx5: Add DMAH object support
      https://git.kernel.org/rdma/rdma/c/f8bfd61adf2957
[7/8] IB: Extend UVERBS_METHOD_REG_MR to get DMAH
      https://git.kernel.org/rdma/rdma/c/d0c4964d1fb1c0
[8/8] RDMA/mlx5: Add DMAH support for reg_user_mr/reg_user_dmabuf_mr
      https://git.kernel.org/rdma/rdma/c/ff2f4dcf7f645b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


