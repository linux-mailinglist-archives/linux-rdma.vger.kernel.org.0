Return-Path: <linux-rdma+bounces-5598-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E05EF9B49DE
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2024 13:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89817B22B8E
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2024 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C011DE3C5;
	Tue, 29 Oct 2024 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlH+Wiqz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D51DFCB;
	Tue, 29 Oct 2024 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205636; cv=none; b=QF6tIKdTVWB/NlO8f6wDUos1zkWC4NrCkpz7G5B+vTGFAs6pnlDPEzA2s0Ba6CT74dsxynjUSfVXuYzDHGksMNGyU2ejHRak1/HlHNSq1J0P0EciYo+dZlIGeAIS3w6dMgNASdvqKSdzT2LIox9CCmBPwL9nTAwPwKXJnsSE1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205636; c=relaxed/simple;
	bh=hQdcMiZXOmIZ6uy22XdYpabrr2KqjzFhY5BE1nQH2e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jh7Iw0MXM3NACyQg1VttO2l2J00WtPhAgygolJN17wQPQRU6y0Z6yZJG+QablzfxFAJ14Rlsh0ZDG2tWB4TjwGNjCiZsRr9Vt5mT/VDiVPFY/2nWebPItsja4OTvDhRzMg0fTtczi/gO4hIke9zzb/79J69zV99xmbaFvA+5wXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlH+Wiqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F20EC4CECD;
	Tue, 29 Oct 2024 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730205634;
	bh=hQdcMiZXOmIZ6uy22XdYpabrr2KqjzFhY5BE1nQH2e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlH+Wiqzb7pCBZXL1wzK+fiOnlgpY+P3BngqA7okGadKKR1eHxOA8BaNCyH5UsVMg
	 FhUa2HW2vVQCRCwlYjQ1U096Ae4uHTrUP1PdwabF0lYEefSZHCzonyCI4gurQsV13T
	 hsrm//umoLUOx0361MYrAAq9HjE2yHe9UEwafDyj+THx+mVg1NgXDMbhoOCwkxD8F2
	 2FxNUNjuAcR91XMxmCpukqDGgL3FEqWuHy8YkVurLhqTUP4bjDSJGlRYFr/s+E+vwu
	 Yb/i+FQRcSuV0vmY8y0DiHjnOM8hxwq5lL2D56MujZNwyhPnF21QxfPePmsmN+jJHJ
	 sbC56RFR36WJA==
Date: Tue, 29 Oct 2024 14:40:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 9/9] RDMA/hns: Fix different dgids mapping to
 the same dip_idx
Message-ID: <20241029124029.GM1615717@unreal>
References: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
 <20240906093444.3571619-10-huangjunxian6@hisilicon.com>
 <20240910131205.GB4026@unreal>
 <cd7ae683-c9b9-cb1c-c5fc-739d66c303ec@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd7ae683-c9b9-cb1c-c5fc-739d66c303ec@hisilicon.com>

On Thu, Oct 17, 2024 at 09:21:45PM +0800, Junxian Huang wrote:
> 
> 
> On 2024/9/10 21:12, Leon Romanovsky wrote:
> > On Fri, Sep 06, 2024 at 05:34:44PM +0800, Junxian Huang wrote:
> >> From: Feng Fang <fangfeng4@huawei.com>
> >>
> >> DIP algorithm requires a one-to-one mapping between dgid and dip_idx.
> >> Currently a queue 'spare_idx' is used to store QPN of QPs that use
> >> DIP algorithm. For a new dgid, use a QPN from spare_idx as dip_idx.
> >> This method lacks a mechanism for deduplicating QPN, which may result
> >> in different dgids sharing the same dip_idx and break the one-to-one
> >> mapping requirement.
> >>
> >> This patch replaces spare_idx with two new bitmaps: qpn_bitmap to record
> >> QPN that is not being used as dip_idx, and dip_idx_map to record QPN
> >> that is being used. Besides, introduce a reference count of a dip_idx
> >> to indicate the number of QPs that using this dip_idx. When creating
> >> a DIP QP, if it has a new dgid, set the corresponding bit in dip_idx_map,
> >> otherwise add 1 to the reference count of the reused dip_idx and set bit
> >> in qpn_bitmap. When destroying a DIP QP, decrement the reference count
> >> by 1. If it becomes 0, set bit in qpn_bitmap and clear bit in dip_idx_map.
> >>
> >> Fixes: eb653eda1e91 ("RDMA/hns: Bugfix for incorrect association between dip_idx and dgid")
> >> Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
> >> Signed-off-by: Feng Fang <fangfeng4@huawei.com>
> >> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> >> ---
> >>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 +--
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 58 ++++++++++++++++++---
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  1 +
> >>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 16 ++++--
> >>  4 files changed, 67 insertions(+), 14 deletions(-)
> > 
> > It is strange implementation, double bitmap and refcount looks like
> > open-coding of some basic coding patterns. Let's wait with applying it
> > for now.
> > 
> 
> Hi Leon, it's been a while since this patch was sent. Is it okay to be applied?

Not in this implementation. I think that xarray + tag will give you what
you are looking without the need to open-code it.

Thanks

> 
> Regarding your question about the double bitmaps, that's because we have 3 states
> to track:
> 1) the context hasn't been created
> 2) the context has been created but not used as dip_ctx
> 3) the context is being used as dip_ctx.
> 
> Junxian
> 
> > Thanks
> > 
> 

