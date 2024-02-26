Return-Path: <linux-rdma+bounces-1131-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF14866BC7
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 09:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF6D9B20ECD
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059821C6A3;
	Mon, 26 Feb 2024 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWTIOILm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19A01C696;
	Mon, 26 Feb 2024 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934995; cv=none; b=sOysGwbiiizRfumIxfBjj+Ft5yHY1a+04vRqfftPjuDK/iEGtSkC4NwvBrYZ3Ar9iZ+BGUvfbeUlQ0pkpK4NMXn0zBGHFFUuw61ceo7kjpVqBlVx5Q75JwrJpgDAV5xZT/n+U4TFKw0XkXDNzj2QVAMvJsoSqEfq/zJYIqIfTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934995; c=relaxed/simple;
	bh=pdqidvyphX2sEaCa/hJiMTiJLzAIs4UAJrCEdSu9I2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmQZ/Tent9axW6bvRLoXWgCEwBnq6hq6PaljoJWhY0wys0wkfynkfVjRhMSJhi5uxSmPPb/PhRnk30id/gV+5pOQcCIjkEK2+l93OKVG5CQp/XGlJtHxGJN5/Ug2VfMIDtrEp2yilN/TpBcKQw9Sa6jd8sMRCPVZ7cPj7kKYqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWTIOILm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36EEC433C7;
	Mon, 26 Feb 2024 08:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708934995;
	bh=pdqidvyphX2sEaCa/hJiMTiJLzAIs4UAJrCEdSu9I2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWTIOILmPomUtp49MfnYQj4CXJKcfA0Qo2S8EQiVbXCD3m6JMouiCZOSwvXvQuQB1
	 WJqNFyK311LNEzUMQIvIw4snjD2Bpl4qBG8QMI3fPiQQASSLuPrW1P/RhvJIPht2v2
	 c6ZEOHPNuCcHvxS/q+m//EhdT3nOutHqzn9KPtcFpr04T5B45FmHSgrPOwb41zQ4hk
	 +5nJtZGslPUUv8Q2t5EeAnAKUWuR2IPTUQBSE9GHnjp6t2XNZMIZceDR4Xxwj9Hc+K
	 EisDQF3F6qsriG3rcFrDubGloXlSJYgztwW1sGkAtl3e0BJDqEwqt882lwJdDeF+W/
	 VFYmblvt6bayw==
Date: Mon, 26 Feb 2024 10:09:46 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for-next 2/2] RDMA/hns: Support userspace configuring
 congestion control algorithm with QP granularity
Message-ID: <20240226080946.GC1842804@unreal>
References: <20240208035038.94668-1-huangjunxian6@hisilicon.com>
 <20240208035038.94668-3-huangjunxian6@hisilicon.com>
 <20240221155248.GD13491@ziepe.ca>
 <26ea175c-fa31-720c-2ac3-41abcb4d398a@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ea175c-fa31-720c-2ac3-41abcb4d398a@hisilicon.com>

On Thu, Feb 22, 2024 at 03:06:20PM +0800, Junxian Huang wrote:
> 
> 
> On 2024/2/21 23:52, Jason Gunthorpe wrote:
> > On Thu, Feb 08, 2024 at 11:50:38AM +0800, Junxian Huang wrote:
> >> Support userspace configuring congestion control algorithm with
> >> QP granularity. If the algorithm is not specified in userspace,
> >> use the default one.
> >>
> >> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> >> ---
> >>  drivers/infiniband/hw/hns/hns_roce_device.h | 23 +++++--
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 14 +---
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  3 +-
> >>  drivers/infiniband/hw/hns/hns_roce_main.c   |  3 +
> >>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 71 +++++++++++++++++++++
> >>  include/uapi/rdma/hns-abi.h                 | 17 +++++
> >>  6 files changed, 112 insertions(+), 19 deletions(-)

<...>

> >> +
> >> +enum hns_roce_create_qp_comp_mask {
> >> +	HNS_ROCE_CREATE_QP_MASK_CONGEST_TYPE = 1 << 1,
> > 
> > Why 1<<1 not 1<<0?
> 
> This is to keep consistent with our internal ABI, there are some
> features not upstream yet.
> 

<...>

> >> @@ -114,6 +128,9 @@ struct hns_roce_ib_alloc_ucontext_resp {
> >>  	__u32	reserved;
> >>  	__u32	config;
> >>  	__u32	max_inline_data;
> >> +	__u8	reserved0;
> >> +	__u8	congest_type;
> > 
> > Why this layout?
> > > Jason
> 
> Same as the 1<<1 issue, to keep consistent with our internal ABI.

We are talking about upstream kernel UAPI, there is no internal ABI here.

Please fix it.

Thanks

> 
> Thanks,
> Junxian

