Return-Path: <linux-rdma+bounces-286-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B928E80725C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 15:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697CB1F2142F
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 14:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152F73EA66;
	Wed,  6 Dec 2023 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAyPGFsc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB731374D2
	for <linux-rdma@vger.kernel.org>; Wed,  6 Dec 2023 14:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA92C433C7;
	Wed,  6 Dec 2023 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701872825;
	bh=gZmkfp/8EvEecsWevDjlZmPAEEatR59FqduEUvnfoxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OAyPGFsc/VqFh/b5manPEhp5W+bdj0jUtVNddzkQWhQqvBRorF2zU2aKDujv8tBuV
	 zBSURisuX7LzEUSOtHCkLE07gNwnFC1RLKZJTyIPI2BEr7z6ykzzc413hN/gghBdGj
	 faLJGSUX1lAo4iMETiD5K8f1Sp3Up+ZeEuK5ava7fG59Am3cP45xw49U8BLolYUWX6
	 G29JgTlwQ7LHBlHqagvfCkYYPcTqVCrurabrGrlyeX9Vd8tCYfl+lwAMWGp7y/aDiv
	 LwXWCv/RMjYhyADqyZmKfGnbJe/igUASfg6KhudqZmkoz2mpIlDbA5LTQeq63ncJZP
	 Jq2/sIaxl9XaA==
Date: Wed, 6 Dec 2023 16:27:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc 0/6] Bugfixes and improvements for hns RoCE
Message-ID: <20231206142700.GA18960@unreal>
References: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
 <20231204142447.GB5136@unreal>
 <d8a453b1-c77d-71b3-72cc-eaac51ef8cb8@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8a453b1-c77d-71b3-72cc-eaac51ef8cb8@hisilicon.com>

On Tue, Dec 05, 2023 at 10:05:46AM +0800, Junxian Huang wrote:
> 
> 
> On 2023/12/4 22:24, Leon Romanovsky wrote:
> > On Wed, Nov 29, 2023 at 05:44:28PM +0800, Junxian Huang wrote:
> >> Here are several bugfixes and improvements for hns RoCE.
> >>
> >> Chengchang Tang (4):
> >>   RDMA/hns: Rename the interrupts
> >>   RDMA/hns: Remove unnecessary checks for NULL in mtr_alloc_bufs()
> >>   RDMA/hns: Fix memory leak in free_mr_init()
> >>   RDMA/hns: Improve the readability of free mr uninit
> > 
> > 1. The series doesn't apply.
> > ➜  kernel git:(wip/leon-for-next) ~/src/b4/b4.sh shazam -l -s https://lore.kernel.org/all/20231129094434.134528-1-huangjunxian6@hisilicon.com -P 1-5
> 
> Is this series going to be applied to -next?

Yes, I planned to apply them to -next, they don't really important Fixes for -rc4.

> 
> > 2. Please drop patch #6 as you are deleting the code which you added in
> > first patches without actual gain.
> 
> Is it better to drop it directly or merge it with the previous patch?

Please drop.

> 
> Thanks,
> Junxian
> 
> > 
> > Thanks
> > 
> >>
> >> Junxian Huang (2):
> >>   RDMA/hns: Response dmac to userspace
> >>   RDMA/hns: Add a max length of gid table
> >>
> >>  drivers/infiniband/hw/hns/hns_roce_ah.c    |  7 ++
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 87 +++++++++++++++-------
> >>  drivers/infiniband/hw/hns/hns_roce_mr.c    |  2 +-
> >>  include/uapi/rdma/hns-abi.h                |  5 ++
> >>  4 files changed, 73 insertions(+), 28 deletions(-)
> >>
> >> --
> >> 2.30.0
> >>
> >>
> > 

