Return-Path: <linux-rdma+bounces-11902-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20F7AF9977
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 19:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839304A34CE
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9EC291894;
	Fri,  4 Jul 2025 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUJFqm+v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3832E3715;
	Fri,  4 Jul 2025 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751648892; cv=none; b=I1uBn7cfuioUthqsyf1JXy68B0l2D7SbVbVlRRnGFhGZC8KCZK4IbcEZnBvdetDikaN9Grn2ct5AFq4kkN+i0+qMsEOvidTX3ALf4rjMfl0UsNQrJEKj8AmflNAsbwsfN05mRvuZN2VhR/S2X+Wtqing/X6EdEZtpGi7Tcj3A4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751648892; c=relaxed/simple;
	bh=0ITybG1gGZl6YRP0Mrv2Tjbb16ysrUlCnsvanObbjyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obGYnFJeZb8BmNwrkDi5XgO+FC7+ovJmezOLHhxQULYFuAOsiTErqzqy4Z51pN93h4VFaOQn1uWRhZ8Fi/Lke47lyBJrYZfF/1joDEieFcKeMNMozlKTZ4TLtj/qc+kkCDYCkwJFlR1albSohVT53697gJYCaBifNz92GzNzWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUJFqm+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F009C4CEE3;
	Fri,  4 Jul 2025 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751648891;
	bh=0ITybG1gGZl6YRP0Mrv2Tjbb16ysrUlCnsvanObbjyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUJFqm+vZebVfuVTFodwOJdFbLcDHvjUiHb6U8VPBJNXuVSI0SAzi7WPBVBJ/QUxD
	 wdW1EdtPE4lrE41uwEZYe35M4Hfs8t2E0vAukVMR9+nRp2KWYsqmW97it0sbFMffhL
	 tTHxZ2sOkmWUcfANOs14bH5GUsC+c1BuXgvx6QW/7KfWzV2Swetf9qkLpCcuGyZZjF
	 1BSy1RyuXklQV/vmmij7Z8bOUfCS5s21QNdqWcHVouVd4rZHysgcgAAV7TaBnzk8MX
	 AoaPKknZindFH4YpIfyc4cKIYA2yZIgwiWHimSm34MmK3GKplCSrYwwpNmVp0msITf
	 Lhw+r94qHv1Gw==
Date: Fri, 4 Jul 2025 20:08:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, shannon.nelson@amd.com,
	brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	andrew+netdev@lunn.ch, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Boyer <andrew.boyer@amd.com>
Subject: Re: [PATCH v3 10/14] RDMA/ionic: Register device ops for control path
Message-ID: <20250704170807.GO6278@unreal>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-11-abhijit.gangurde@amd.com>
 <20250701103844.GB118736@unreal>
 <20250702131803.GB904431@ziepe.ca>
 <20250702180007.GK6278@unreal>
 <bb0ac425-2f01-b8c7-2fd7-4ecf9e9ef8b1@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb0ac425-2f01-b8c7-2fd7-4ecf9e9ef8b1@amd.com>

On Thu, Jul 03, 2025 at 12:49:30PM +0530, Abhijit Gangurde wrote:
> 
> On 7/2/25 23:30, Leon Romanovsky wrote:
> > On Wed, Jul 02, 2025 at 10:18:03AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jul 01, 2025 at 01:38:44PM +0300, Leon Romanovsky wrote:
> > > > > +static void ionic_flush_qs(struct ionic_ibdev *dev)
> > > > > +{
> > > > > +	struct ionic_qp *qp, *qp_tmp;
> > > > > +	struct ionic_cq *cq, *cq_tmp;
> > > > > +	LIST_HEAD(flush_list);
> > > > > +	unsigned long index;
> > > > > +
> > > > > +	/* Flush qp send and recv */
> > > > > +	rcu_read_lock();
> > > > > +	xa_for_each(&dev->qp_tbl, index, qp) {
> > > > > +		kref_get(&qp->qp_kref);
> > > > > +		list_add_tail(&qp->ibkill_flush_ent, &flush_list);
> > > > > +	}
> > > > > +	rcu_read_unlock();
> > > > Same question as for CQ. What does RCU lock protect here?
> > > It should protect the kref_get against free of qp. The qp memory must
> > > be RCU freed.
> > I'm not sure that this was intension here. Let's wait for an answer from the author.
> 
> As Jason mentioned, It was intended to protect the kref_get against free of
> cq and qp
> in the destroy path.

How is it possible? IB/core is supposed to protect from accessing verbs
resources post their release/destroy.

After you answered what RCU is protecting, I don't see why you would
have custom kref over QP/CQ/e.t.c objects.

Thanks

