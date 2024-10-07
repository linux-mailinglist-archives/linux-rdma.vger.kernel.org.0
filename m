Return-Path: <linux-rdma+bounces-5275-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB6A9933A7
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 18:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CCB7B2280A
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB25C1DB554;
	Mon,  7 Oct 2024 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hYbPK+Ns"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6226CEEC9;
	Mon,  7 Oct 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319492; cv=none; b=FqAYaTyD6hIORR3daUsHWkPANK6gIpqJlsltq+hFp+ywxuu82q4XhfS++VjUsI1nQimHbfLxJm/Fq/iMAHk0ZCyyJHb6u/soLbLEjo+CqMVrb6UOiz+I5fBf1fpmKeFLTqw6qgP3SlsiyO8jg1m990ItekBNNo1ypIsdE1nRB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319492; c=relaxed/simple;
	bh=qo+lRIrIcMATiKB5QISMShBr/SAaVCBqqAz5k3tOlwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIFqSJ8KBAAVh+3r/QHB6ZxxgcnCzzM0yLPz0IvIA7nakzOQ9QVCDKm8H+B5DcHs8eBbs6AfVRbFdOKb87or+/x48jpXNU97odBHKwhlDv91w6BPI4GqKXwzJH3r80w0HwydJb2DGi+zjZFGu57WgmZLbfKrwHgt4KgxEa+4CwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hYbPK+Ns; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=HR1BmZHGzS4RP28S+kacXbadFiwX7WPNJTbohofprFs=; b=hYbPK+Nsl70phnpk
	6eMYAxtvyLxToefuejlUGBf0ICg8zKdXGpwEQgjVnRq+LqfI1hBQAKovARKbLxcEUhDIJ1BbYwWRK
	tXvVDcYKzln3RH8mJpDX+Y0I2uXXqYBR0/KQBEKJecuxWES0mGHTDDve7HB10crmNJYU8fHfejiAA
	tLzVP/ZfiltBbFGXWPUYVT8wHZl8Eh4xxGs9QP7rK24sAtabhjMjWP58h78Q0u0yqGz3wGkEVlk4Y
	PwQO3VfsABGcCifQSYO2CXWaLlfbdCdK2OQr2nSnLI2z2nJoRDT16wL2F2pstbMXcMShcNU1QFw84
	9z+TuKR+GTHfG4utTQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sxqqh-009WQb-1x;
	Mon, 07 Oct 2024 16:44:43 +0000
Date: Mon, 7 Oct 2024 16:44:43 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: maorg@nvidia.com, bharat@chelsio.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: of c4iw_fill_res_qp_entry
Message-ID: <ZwQP-xESyiBDlyro@gallifrey>
References: <Zv_4qAxuC0dLmgXP@gallifrey>
 <20241006140558.GF4116@unreal>
 <ZwKehJ34PzNN6FQx@gallifrey>
 <20241007160534.GA25819@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241007160534.GA25819@unreal>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:44:20 up 152 days,  3:58,  1 user,  load average: 0.07, 0.03,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Leon Romanovsky (leon@kernel.org) wrote:
> On Sun, Oct 06, 2024 at 02:28:20PM +0000, Dr. David Alan Gilbert wrote:
> > * Leon Romanovsky (leon@kernel.org) wrote:
> > > On Fri, Oct 04, 2024 at 02:16:08PM +0000, Dr. David Alan Gilbert wrote:
> > > > Hi,
> > > >   One of my scripts noticed that c4iw_fill_res_qp_entry is not called
> > > > anywhere; It came from:
> > > > 
> > > > commit 5cc34116ccec60032dbaa92768f41e95ce2d8ec7
> > > > Author: Maor Gottlieb <maorg@mellanox.com>
> > > > Date:   Tue Jun 23 14:30:38 2020 +0300
> > > > 
> > > >     RDMA: Add dedicated QP resource tracker function
> > > >     
> > > > I was going to send a patch to deadcode it, but is it really a bug and
> > > > it should be assigned in c4iw_dev_ops in cxgb4/provider.c ?
> > > > 
> > > > (Note I know nothing about the innards of your driver, I'm just spotting
> > > > the unused function).
> > 
> > Thanks for the reply,
> > 
> > > It is a bug, something like that should be done.
> > 
> > Ah good I spotted; out of curiosity, what would be the symptom?
> 
> User will run "rdma resource show qp -d" and won't get any vendor
> specific information.

Oh OK, not terrible.

> > 
> > I don't have the hardware to test this, can I suggest that you send that patch?
> 
> Sure, will do.

Thanks!

Dave

> > 
> > Dave
> > 
> > > diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
> > > index 10a4c738b59f..e059f92d90fd 100644
> > > --- a/drivers/infiniband/hw/cxgb4/provider.c
> > > +++ b/drivers/infiniband/hw/cxgb4/provider.c
> > > @@ -473,6 +473,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
> > >         .fill_res_cq_entry = c4iw_fill_res_cq_entry,
> > >         .fill_res_cm_id_entry = c4iw_fill_res_cm_id_entry,
> > >         .fill_res_mr_entry = c4iw_fill_res_mr_entry,
> > > +       .fill_res_qp_entry = c4iw_fill_res_qp_entry,
> > >         .get_dev_fw_str = get_dev_fw_str,
> > >         .get_dma_mr = c4iw_get_dma_mr,
> > >         .get_hw_stats = c4iw_get_mib,
> > > (END)
> > > 
> > > 
> > > > 
> > > > Thoughts?
> > > > 
> > > > Dave
> > > > -- 
> > > >  -----Open up your eyes, open up your mind, open up your code -------   
> > > > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> > > > \        dave @ treblig.org |                               | In Hex /
> > > >  \ _________________________|_____ http://www.treblig.org   |_______/
> > > > 
> > > 
> > -- 
> >  -----Open up your eyes, open up your mind, open up your code -------   
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> > \        dave @ treblig.org |                               | In Hex /
> >  \ _________________________|_____ http://www.treblig.org   |_______/
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

