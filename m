Return-Path: <linux-rdma+bounces-4089-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 166BB940000
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 23:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7802EB22408
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 21:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6EC18A950;
	Mon, 29 Jul 2024 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ZQJbEUTu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62618189F2D;
	Mon, 29 Jul 2024 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286924; cv=none; b=sKOGbbLCzaNuyHpyN2fMkNBj2iSzKbr52sg+b19q1EjNIGjRapr7ahhrCy9fuoEowsb6UCXhOzfgqGMI7TBhJSRGW2pb1eamJhoOhmLbc0pkiq5mbSNRfC2/Po4g8v85ZwbaStjrQa1hZDje3p5s9NuXAPyi186iT5a2jSDgBBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286924; c=relaxed/simple;
	bh=+7jHqirdONcFsWG/pxxPpHc4Slm93QjFxtahlPzxPkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwjEVMXkBhlo35BdAYHWffw0Vqz2/XCIZ9XYQryPBIcvNXd07Wgzc1+kVTNTFjA5+31BYGIpR5fNo/JaLghb3xLk7jld7H/ow/x9nHDNilQa9ceznIqKjH2g4GuKRCjm6pJD7W+KsKhQ/O9I+AUowmABRJHP9lR46WyjXji7Puk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ZQJbEUTu; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=4dxhcrA/g8UsSiMMb/cPgIiHlcYwa1q+BRzVuW8gQg8=; b=ZQJbEUTuLQuMwM8s
	sVz0fL+gRqU1oDeB5hYyW/Ur+CKgpHnT8ylRp5MRV18gEbftqmaFJB0nX+XMXNomRebhF6c6qtsoQ
	wUyCZEc3xx+ZO/eStLS+dvfJnpByZX02YdlbPlzOubzfeilr+yKKv7wl3Kj+RqX0sN4fHexn8s0YU
	We1M1OI8eHMpT7gFCuLYlqDLXYabpUeixhSM/QUWAU9HOHTAnVlsyOpH6txMkyAigxRxzYFO8PUGm
	lpPinSfQ+M4GGa8zWzuH2uFVkbFsWegMFV1Q9SyTK/B79bvhzCEdw/y8/ku0DWaqkrDeXyDcbbVve
	zCnLrLM24oJuKFAQmA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sYXV6-00DsTi-0M;
	Mon, 29 Jul 2024 21:01:48 +0000
Date: Mon, 29 Jul 2024 21:01:48 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Allison Henderson <allison.henderson@oracle.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rds: remove unused struct 'rds_ib_dereg_odp_mr'
Message-ID: <ZqgDPCdmOg3GsREf@gallifrey>
References: <20240531233307.302571-1-linux@treblig.org>
 <2442cae88ee4a5f7ba46bb0158735634fa82a305.camel@oracle.com>
 <ZpsEof3hxKGQBmqF@gallifrey>
 <20240721070557.GE1265781@unreal>
 <Zpzq2cPc8rS-OUdW@gallifrey>
 <20240721120620.GF1265781@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240721120620.GF1265781@unreal>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 21:01:25 up 82 days,  8:15,  1 user,  load average: 0.32, 0.11, 0.02
User-Agent: Mutt/2.2.12 (2023-09-09)

* Leon Romanovsky (leon@kernel.org) wrote:
> On Sun, Jul 21, 2024 at 11:02:49AM +0000, Dr. David Alan Gilbert wrote:
> > * Leon Romanovsky (leon@kernel.org) wrote:
> > > On Sat, Jul 20, 2024 at 12:28:17AM +0000, Dr. David Alan Gilbert wrote:
> > > > * Allison Henderson (allison.henderson@oracle.com) wrote:
> > > > > On Sat, 2024-06-01 at 00:33 +0100, linux@treblig.org wrote:
> > > > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > > > 
> > > > > > 'rds_ib_dereg_odp_mr' has been unused since the original
> > > > > > commit 2eafa1746f17 ("net/rds: Handle ODP mr
> > > > > > registration/unregistration").
> > > > > > 
> > > > > > Remove it.
> > > > > > 
> > > > > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > > > 
> > > > > This patch looks fine to me, the struct is indeed unused at this point.
> > > > > Thanks for the clean up!
> > > > > 
> > > > > Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
> > > > 
> > > > Hi,
> > > >   Does anyone know who might pick this one up - I don't think
> > > > it's in -next yet?
> > > 
> > > 1. We are in merge window and this patch is not a bug fix, so it should
> > >    wait until the next merge window.
> > 
> > Yeh I did wonder; it was posted and reviewed back at the start of June.
> > 
> > > 2. Title should be net/rds ... and not RDMA/rds ...
> > 
> > OK, I can easily fix that.
> > 
> > > 3. netdev is closed right now, so it should be resubmitted after next merge
> > >    window ends.
> > 
> > When you say 'resubmitted' - you mean reposted to the lists with the amended
> > title? Or what?
> 
> Yes, reposted to the netdev@ ML with the correct title.

OK, reposted as
Message-ID: 20240729210114.48522-1-linux@treblig.org

Dave

> Thanks
> 
> > 
> > Dave
> > 
> > > Thanks
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

