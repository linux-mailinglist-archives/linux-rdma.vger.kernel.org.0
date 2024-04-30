Return-Path: <linux-rdma+bounces-2168-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EEA8B792B
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 16:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84201F210CD
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 14:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E861527AC;
	Tue, 30 Apr 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSACFgJC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8D41527A8;
	Tue, 30 Apr 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486245; cv=none; b=dizTcLNXf+RtLwVD/uwLd9ZtMtFKp2WTwru1BhFxrWvWu/gmVwNuYsn8aThuWspVGJnb0uJupsiR++SWzQU/4fuPofI2SJ+TrwnHbVIX1BYuC9vtGcEW/CntVgTcSq0yxVEK7DU2/sJWgEMH40/Fc+dPTLj06ILX3YUPxgfnVxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486245; c=relaxed/simple;
	bh=DFmZGaD+ssIlT/B33ege35Nl6ftG7eXESOlm0ucRd2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBr1q76jqfm7q1ynBOcWKPhRsSITQx3U5sCUyht1NbEN5JCiIX4bOPrpynXll6H6ffDHdgyq1co58KF3R99a04I8SU6V1cZ0k5t5FE/wRDdDhsgk34D66JYenfttkpR3CcpQbKUTuGV79UywplM1XqkjpBzZCAmc93+p4RDgZEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSACFgJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C062BC4AF18;
	Tue, 30 Apr 2024 14:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714486244;
	bh=DFmZGaD+ssIlT/B33ege35Nl6ftG7eXESOlm0ucRd2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aSACFgJCQTsoJH/MwklGL5d7BwvIk3JQvTZDjrN0140y44hhz89HBuA3VIZDS5Mxc
	 DvBjVPJgfcsB6bdcfVi0ZplDPtKc3skOo1Dec3otryzUn8rV8jCHj+89IdFSloUjt1
	 sHkPEng63oLz266ELuP4YDqKvgbiW3B3Hdpb0T60+RTKVGrwjlgNhC2XuS2Sl8XO2k
	 JgyOWWhp5pax4oP4TpKTwY8Ht2lVvokqjd0bPcSDYzgQPuJ01PT2zcirBkFdeOxs8C
	 sJBB1Gup943xkk+kKygTScyvi8VN2IluNEmeThT0DZmRQBZ93b2vcCCD5n0JoxLg/M
	 e7ljDuWXHqRxA==
Date: Tue, 30 Apr 2024 17:10:39 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240430141039.GH100414@unreal>
References: <20240426085606.1801741-1-leitao@debian.org>
 <20240430125047.GE100414@unreal>
 <49973089-1e5e-48a2-9616-09cf8b8d5a7f@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49973089-1e5e-48a2-9616-09cf8b8d5a7f@cornelisnetworks.com>

On Tue, Apr 30, 2024 at 10:03:49AM -0400, Dennis Dalessandro wrote:
> On 4/30/24 8:50 AM, Leon Romanovsky wrote:
> > On Fri, Apr 26, 2024 at 01:56:05AM -0700, Breno Leitao wrote:
> >> Embedding net_device into structures prohibits the usage of flexible
> >> arrays in the net_device structure. For more details, see the discussion
> >> at [1].
> >>
> >> Un-embed the net_device from struct hfi1_netdev_rx by converting it
> >> into a pointer. Then use the leverage alloc_netdev() to allocate the
> >> net_device object at hfi1_alloc_rx().
> >>
> >> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> >>
> >> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> >> Signed-off-by: Breno Leitao <leitao@debian.org>
> >> ---
> >> Changelog
> >>
> >> v5:
> >> 	* Basically replaced the old alloc_netdev() by the new helper
> >> 	  alloc_netdev_dummy().
> >> v4:
> >> 	* Fix the changelog format
> >> v3:
> >> 	* Re-worded the comment, by removing the first paragraph.
> >> v2:
> >> 	* Free struct hfi1_netdev_rx allocation if alloc_netdev() fails
> >> 	* Pass zero as the private size for alloc_netdev().
> >> 	* Remove wrong reference for iwl in the comments
> >> ---
> >>
> >>  drivers/infiniband/hw/hfi1/netdev.h    | 2 +-
> >>  drivers/infiniband/hw/hfi1/netdev_rx.c | 9 +++++++--
> >>  2 files changed, 8 insertions(+), 3 deletions(-)
> > 
> > Dennis,
> > 
> > Do you plan to send anything to rdma-next which can potentially create
> > conflicts with netdev in this cycle?
> > 
> > If not, it will be safe to apply this patch directly to net-next.
> > 
> > Thanks
> 
> Nothing right now. Should be safe to sent to net-next.

Jakub, can you please take this patch?

> 
> FYI, since I talked about it publicly at the OFA Workshop recently. We will be
> starting the upstream of support for our new HW, soon.

Great, thanks

> 
> -Denny

