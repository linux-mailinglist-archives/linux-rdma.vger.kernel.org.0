Return-Path: <linux-rdma+bounces-3914-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DC1938463
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 13:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F12281773
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD5A1607AB;
	Sun, 21 Jul 2024 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="VazwTYJ2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9D785C74;
	Sun, 21 Jul 2024 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721559605; cv=none; b=kl3YtGwMwGavMAxCbQ8hN+2p++N6sHPVrBTQGf1Mw9UVkjAGt0YVytbjlDM24mx8QLTRX7uxVbxy59QP1a4DVntCEB+nuBwmDe8hzrNauAG69U8bpQ9gCBUCh1aMLDNrTzkZib9dgNlWH1m8ZMAzgTGFu0/rSBFYOoA2q+9hsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721559605; c=relaxed/simple;
	bh=VrRkHqvenZT+b6MwBucXy0E0sVFAXGPNz8auvqwcrEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1u2CIDUDFG8AZQQJCC+9tfoItgooXALyqsHTYqEBVELP33z7GTRLhTWUPrQ7fVa2JZpI9NZg9pphW888SExlAKpANP38pZbzz3yhyMCFGf7NoXT5a5IYkxi3jNGuxwZMxKaAuhT58+knNslujz+3pFbdLOfU/nXqFabQ/H5284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=VazwTYJ2; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=nIMopPqJEvT/D1lesENfbHFMsf1K4gytKkpkw2FydhM=; b=VazwTYJ2jBTTXz0D
	JKwdZJzz+dQq/ChbsQsXDOrCey37kom46McCSpAm25zGdPf8fi8vwBL7XIyMyZ5d8SnOCvDT4iKnr
	TkrKShoyFqXPn1o6b2yMnIcEWtmyYDm98813Xrq3JV6AesXrKdDV2TQKC/tUbZfU3YtaiQ6qQ4rBH
	PVpzsAvKOpNVhZqP9nK29PfCuvMtcfDzkGDZZD8rtRE8o4wSl+XYw+BEz/TP2jai3E5tOh5djxhDj
	wP6CJUCea80BYrkiZ3ytpIPazt5dX5yTE9NcTYSCkiHWrzIc1L+kL6G8ILQL60MH6YfVG/tVJu7UR
	v2usoK6ud+QIMjIV+Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sVUI2-00Cb3Z-0n;
	Sun, 21 Jul 2024 10:59:42 +0000
Date: Sun, 21 Jul 2024 10:59:42 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rds: remove unused struct 'rds_ib_dereg_odp_mr'
Message-ID: <ZpzqHg_idtElXcw3@gallifrey>
References: <20240531233307.302571-1-linux@treblig.org>
 <8b5fd878-a952-4cca-87af-aa44319a4f86@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b5fd878-a952-4cca-87af-aa44319a4f86@linux.dev>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 10:58:59 up 73 days, 22:13,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Zhu Yanjun (yanjun.zhu@linux.dev) wrote:
> 在 2024/6/1 1:33, linux@treblig.org 写道:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'rds_ib_dereg_odp_mr' has been unused since the original
> > commit 2eafa1746f17 ("net/rds: Handle ODP mr
> > registration/unregistration").
> > 
> > Remove it.
> > 
> Need Fixes?
> 
> Fixes: 2eafa1746f17 ("net/rds: Handle ODP mr
> registration/unregistration")

I've not been using Fixes on these, because they
have no actual consequence - there's no need
for stable or downstream to pick them up, which is
what Fixes is often used for.

> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks,

Dave

> Zhu Yanjun
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >   net/rds/ib_rdma.c | 4 ----
> >   1 file changed, 4 deletions(-)
> > 
> > diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
> > index 8f070ee7e742..d1cfceeff133 100644
> > --- a/net/rds/ib_rdma.c
> > +++ b/net/rds/ib_rdma.c
> > @@ -40,10 +40,6 @@
> >   #include "rds.h"
> >   struct workqueue_struct *rds_ib_mr_wq;
> > -struct rds_ib_dereg_odp_mr {
> > -	struct work_struct work;
> > -	struct ib_mr *mr;
> > -};
> >   static void rds_ib_odp_mr_worker(struct work_struct *work);
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

