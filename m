Return-Path: <linux-rdma+bounces-12075-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3543CB02EE5
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 08:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F56118976BB
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 06:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FABE1A5B8C;
	Sun, 13 Jul 2025 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMN5H3W5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20101C13B;
	Sun, 13 Jul 2025 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752388079; cv=none; b=XnrZF7mA84f1ECr11lqZu79miRB9dGZ9NnB4V/T1gpe/mUw5dRXFwZHygIrRARvw7xZiQdv9O+/QOIw60iGle2V95pxJSQs2Abr/pcQZdq+5Lh5/vkb4XPyPHGElDMnHVUIWkugN6OkZ4DrxIA4hzRSe3DXccp2LeLpt6u4RP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752388079; c=relaxed/simple;
	bh=qF+yqTT0HCWnjzsAyIFmpCxLqFDSF1VJG0Ed4wgYZqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aa3S/WYwETVzAS8akurmaHFWfftRYItbPSk0Tg1AEFUV3ewgwYhfxIZaF7Nj5xt5WMggFtJAX4YiVfYEXlopjGmMITiCB2HyjVNQqvpK2nxfeo0dvlUGa5SlEn23Cpc+D1BztBLLMeeo0Lr4hPKjVnYqIFAM5/7YbY2mieBkacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMN5H3W5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEBFC4CEE3;
	Sun, 13 Jul 2025 06:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752388078;
	bh=qF+yqTT0HCWnjzsAyIFmpCxLqFDSF1VJG0Ed4wgYZqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMN5H3W5iWCKvfUgKGA2ygFP5hshzZTL6YS+w1uosKChce7z7evpEkCPdo73fIXYd
	 Rh5XAGNCD/poP+d08lY2zZZEywbNv2pErfxtqsnL0T+ciagerbkMRv0/ajgACfBQnP
	 sKzJHzQlH2Wu+Cq/Z11SAu3TO7dRT6w/quvZaZswMIRMQPsI29AKZOJLwTMm4QUG9C
	 qd6e0D6xEFySOLXYKknRgT+WzUykjzmeuX475ig4ofZEUU2we07sC05FAfgjie84Gp
	 c+g2CGGFNIJ3LgHE/ad+UKCO41rENHdSP1plW1d0YdCL8FnlM7n6YCY6LAPUiw9DrM
	 B9lDHn94B0n+g==
Date: Sun, 13 Jul 2025 09:27:53 +0300
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
Message-ID: <20250713062753.GA5882@unreal>
References: <20250701103844.GB118736@unreal>
 <20250702131803.GB904431@ziepe.ca>
 <20250702180007.GK6278@unreal>
 <bb0ac425-2f01-b8c7-2fd7-4ecf9e9ef8b1@amd.com>
 <20250704170807.GO6278@unreal>
 <15b773a4-424b-4aa9-2aa4-457fbbee8ec7@amd.com>
 <20250707072137.GU6278@unreal>
 <1a7190d4-f3ef-744c-4e46-8cb255dee6cf@amd.com>
 <20250707164609.GA592765@unreal>
 <76a68f62-1f73-cc81-0f5b-48a6982a54c7@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76a68f62-1f73-cc81-0f5b-48a6982a54c7@amd.com>

On Tue, Jul 08, 2025 at 03:35:52PM +0530, Abhijit Gangurde wrote:
> 
> On 7/7/25 22:16, Leon Romanovsky wrote:
> > On Mon, Jul 07, 2025 at 08:26:20PM +0530, Abhijit Gangurde wrote:
> > > On 7/7/25 12:51, Leon Romanovsky wrote:
> > > > On Mon, Jul 07, 2025 at 10:57:13AM +0530, Abhijit Gangurde wrote:
> > > > > On 7/4/25 22:38, Leon Romanovsky wrote:
> > > > > > On Thu, Jul 03, 2025 at 12:49:30PM +0530, Abhijit Gangurde wrote:
> > > > > > > On 7/2/25 23:30, Leon Romanovsky wrote:
> > > > > > > > On Wed, Jul 02, 2025 at 10:18:03AM -0300, Jason Gunthorpe wrote:
> > > > > > > > > On Tue, Jul 01, 2025 at 01:38:44PM +0300, Leon Romanovsky wrote:
> > > > > > > > > > > +static void ionic_flush_qs(struct ionic_ibdev *dev)
> > > > > > > > > > > +{
> > > > > > > > > > > +	struct ionic_qp *qp, *qp_tmp;
> > > > > > > > > > > +	struct ionic_cq *cq, *cq_tmp;
> > > > > > > > > > > +	LIST_HEAD(flush_list);
> > > > > > > > > > > +	unsigned long index;
> > > > > > > > > > > +
> > > > > > > > > > > +	/* Flush qp send and recv */
> > > > > > > > > > > +	rcu_read_lock();
> > > > > > > > > > > +	xa_for_each(&dev->qp_tbl, index, qp) {
> > > > > > > > > > > +		kref_get(&qp->qp_kref);
> > > > > > > > > > > +		list_add_tail(&qp->ibkill_flush_ent, &flush_list);
> > > > > > > > > > > +	}
> > > > > > > > > > > +	rcu_read_unlock();
> > > > > > > > > > Same question as for CQ. What does RCU lock protect here?
> > > > > > > > > It should protect the kref_get against free of qp. The qp memory must
> > > > > > > > > be RCU freed.
> > > > > > > > I'm not sure that this was intension here. Let's wait for an answer from the author.
> > > > > > > As Jason mentioned, It was intended to protect the kref_get against free of
> > > > > > > cq and qp
> > > > > > > in the destroy path.
> > > > > > How is it possible? IB/core is supposed to protect from accessing verbs
> > > > > > resources post their release/destroy.
> > > > > > 
> > > > > > After you answered what RCU is protecting, I don't see why you would
> > > > > > have custom kref over QP/CQ/e.t.c objects.
> > > > > > 
> > > > > > Thanks
> > > > > The RCU protected kref here is making sure that all the hw events are
> > > > > processed before destroy callback returns. Similarly, when driver is
> > > > > going for ib_unregister_device, it is draining the pending WRs and events.
> > > > I asked why do you have kref in first place? When ib_unregister_device
> > > > is called all "pending MR" already supposed to be destroyed.
> > > > 
> > > > Thansk
> > > The custom kref on QP/CQ object is holding the completion for the destroy
> > > callback.
> > > If any pending async hw events are being processed, destroy would wait on
> > > this completion
> > > before it returns.
> > Please see how other drivers avoid such situation. There is no need in
> > custom kref.
> > 
> > Thanks
> 
> As per your suggestion, I looked some of the other RDMA drivers. While many
> are using locks, that approach would negate the lockless lookup we gain from
> the xarray.
> The MANA RDMA driver, for instance, uses a similar refcount and completion
> mechanism to handle asynchronous events.

Let's do what all other drivers do, please. I prefer simplest solution
and objects that can potentially be around after verbs objects were
cleaned doesn't sound right.

Thanks

> 
> Thanks
> 
> 

