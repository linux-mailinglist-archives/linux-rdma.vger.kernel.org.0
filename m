Return-Path: <linux-rdma+bounces-198-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E5580367C
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 15:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E22D1C20ACF
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5D328DAD;
	Mon,  4 Dec 2023 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ay0U0EyN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882FC28DA7
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 14:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D96AC433C9;
	Mon,  4 Dec 2023 14:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701699892;
	bh=lQIIqL2wdZXrciPp+cezt3cQcrkR+8je2L8ls5BrqDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ay0U0EyNA+fLdFj/tl8A4T2d0kg+1CGshBUaBla4+FH0wGGyMdR6gaqK4PmnUKLJf
	 /0z1tpzD6y5JjsbSWV5+0Gu14nawZS5LnR3ZDB5bQZc7w51mMZRyOSeWu5atLqtfwh
	 zaSxJ7czgbYB+h8aRpA0QkXWSMeoHrynNXpS7xD12fLo2hbY+deFPAdVsyqQ9MhUza
	 xEvd2JKkyVp4veBmkiEFLcqfCGE9cM18TIlomprwD9urLmW3yB5q9YZDLDr3H1IJaG
	 JewcM+N49DTrsmM846LRiMvKnwXWCkD4JAv3MUIPoSehnkgfAL/94MvYerlFrR3+Km
	 qR2mavpcuamYA==
Date: Mon, 4 Dec 2023 16:24:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc 0/6] Bugfixes and improvements for hns RoCE
Message-ID: <20231204142447.GB5136@unreal>
References: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231129094434.134528-1-huangjunxian6@hisilicon.com>

On Wed, Nov 29, 2023 at 05:44:28PM +0800, Junxian Huang wrote:
> Here are several bugfixes and improvements for hns RoCE.
> 
> Chengchang Tang (4):
>   RDMA/hns: Rename the interrupts
>   RDMA/hns: Remove unnecessary checks for NULL in mtr_alloc_bufs()
>   RDMA/hns: Fix memory leak in free_mr_init()
>   RDMA/hns: Improve the readability of free mr uninit

1. The series doesn't apply.
➜  kernel git:(wip/leon-for-next) ~/src/b4/b4.sh shazam -l -s https://lore.kernel.org/all/20231129094434.134528-1-huangjunxian6@hisilicon.com -P 1-5
2. Please drop patch #6 as you are deleting the code which you added in
first patches without actual gain.

Thanks

> 
> Junxian Huang (2):
>   RDMA/hns: Response dmac to userspace
>   RDMA/hns: Add a max length of gid table
> 
>  drivers/infiniband/hw/hns/hns_roce_ah.c    |  7 ++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 87 +++++++++++++++-------
>  drivers/infiniband/hw/hns/hns_roce_mr.c    |  2 +-
>  include/uapi/rdma/hns-abi.h                |  5 ++
>  4 files changed, 73 insertions(+), 28 deletions(-)
> 
> --
> 2.30.0
> 
> 

