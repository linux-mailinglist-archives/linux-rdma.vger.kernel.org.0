Return-Path: <linux-rdma+bounces-313-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9E08088E6
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 14:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA1728210A
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 13:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851EA3EA72;
	Thu,  7 Dec 2023 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCdmiMr/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A15D3D0D4
	for <linux-rdma@vger.kernel.org>; Thu,  7 Dec 2023 13:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39501C433C8;
	Thu,  7 Dec 2023 13:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701954576;
	bh=48aLS5I+TtNzeyW6P7Yexq+zuarJ1sJ5BXyuvMLL6Zw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KCdmiMr/0tb8P5XITPQcLvjetDTInc5Fb0xC9CcgdC9zNirWR5iZw08onnLnnJv+h
	 yjsCNSAXbqnlxGx18iIdvspyjHB/STA8dxNOjt2tEts7pNr8OwhQvjktCjnFLLSeIg
	 BHXGbDDeihIhsNLZDhAcYuhiTFHjGvwTlwsvun0EUXLb2x09lRjWVk9fOLbgamCefn
	 xQ7NR7IZE7nCrIfEDEAFi54AET26S4i2eakq3OfxKVtbLnBOD+EZPBO+Zue4fCzHRH
	 mqW/oBfTXbfTVHvzvAT8i0pztm+WFijYEgIBiC6xEt+m3ydOrHDtBlirpzexKsEKZh
	 J4MQJzB0NKmdw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc:
 linux-rdma@vger.kernel.org, linuxarm@huawei.com, linux-kernel@vger.kernel.org
In-Reply-To: <20231207114231.2872104-1-huangjunxian6@hisilicon.com>
References: <20231207114231.2872104-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v2 for-next 0/5] Bugfixes and improvements for hns RoCE
Message-Id: <170195457200.56392.17516506336430835094.b4-ty@kernel.org>
Date: Thu, 07 Dec 2023 15:09:32 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Thu, 07 Dec 2023 19:42:26 +0800, Junxian Huang wrote:
> Here are several bugfixes and improvements for hns RoCE.
> 
> v1 -> v2:
> * Change applying target from -rc to -next
> * Drop patch #6 in v1
> 
> Chengchang Tang (3):
>   RDMA/hns: Rename the interrupts
>   RDMA/hns: Remove unnecessary checks for NULL in mtr_alloc_bufs()
>   RDMA/hns: Fix memory leak in free_mr_init()
> 
> [...]

Applied, thanks!

[1/5] RDMA/hns: Rename the interrupts
      https://git.kernel.org/rdma/rdma/c/95f6b40082aaf3
[2/5] RDMA/hns: Response dmac to userspace
      https://git.kernel.org/rdma/rdma/c/d3f4020a213e1c
[3/5] RDMA/hns: Add a max length of gid table
      https://git.kernel.org/rdma/rdma/c/7243396aaf1238
[4/5] RDMA/hns: Remove unnecessary checks for NULL in mtr_alloc_bufs()
      https://git.kernel.org/rdma/rdma/c/f31683a5227b1a
[5/5] RDMA/hns: Fix memory leak in free_mr_init()
      https://git.kernel.org/rdma/rdma/c/288f535951aa81

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

