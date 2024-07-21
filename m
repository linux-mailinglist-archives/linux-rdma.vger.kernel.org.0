Return-Path: <linux-rdma+bounces-3915-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134CF938466
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 13:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B85AB2117F
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598FE148FF6;
	Sun, 21 Jul 2024 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="nIO6iD6d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE53256E;
	Sun, 21 Jul 2024 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721559784; cv=none; b=ESos1srnirc8lgYjQf4F1lfiuy7Fz9a2e9j+qXKGq1hMOUmKCnq3Ydy+KTTYKxWLCwXbR6HCzi6UeKSp8htOiOpYTryxfGqFTEsILMtVBGmuBpjxTVvdUN3SOaB3vHPqBwMDO//LIkEyZIWgCumD+x0yGd0e3XCpitCfiEeJNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721559784; c=relaxed/simple;
	bh=aE+4Y3rk5lvBIn+9B7Eaax582KLBcCMWawbNW2aGFxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXEgXv6Hi4Wg/WfSBdydeqDW5DOVEa4nReEGsEW0UFKE2dLohNCaVE5OpJx6YVNsttaywaVePHYMFzQUD4Yl1awia7bYpPPskZFrlJTF4/9Z5OZ4nwmiUwvyYoT3i5Wv+szekyDVmkHbXvo/DVCS6Xmw5eMxmaTqu9v3aMHqj6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=nIO6iD6d; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=v2XLy22itE69prZPuiPILVtM5w1lDlpkroWEoLrV9Wo=; b=nIO6iD6dPoKX1n7Z
	EcAITT6KI2emYWMDQMkOru1+99AXjGU/vz6b9h1ylC2GJ5cW6F2NHEgJzgJRiVEb1M7sR/eBOlZON
	8hoWD+ytY04LAMGrmqUYxmgJdPsITFsW6TBzlhI+mL9dPgqqZzqM4Z9v+siAZmM0mi2WkgVbcv0nC
	HWgG5DEj9q8NELisu3Vd1oQyvEO0/vi+CEElNo728r4xGI+SR9MasO9Q4AAmYts+s+Lyz5ModsHsG
	arDw2wV3+O5yddtonY9XW1x9N9Pci0fDbXAgJpYkI+p+2/oArooMLyKkCKAfN7coJltOk1kBc+62g
	z7iCwIJipwPS3Po3xA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sVUL3-00Cb4x-2J;
	Sun, 21 Jul 2024 11:02:49 +0000
Date: Sun, 21 Jul 2024 11:02:49 +0000
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
Message-ID: <Zpzq2cPc8rS-OUdW@gallifrey>
References: <20240531233307.302571-1-linux@treblig.org>
 <2442cae88ee4a5f7ba46bb0158735634fa82a305.camel@oracle.com>
 <ZpsEof3hxKGQBmqF@gallifrey>
 <20240721070557.GE1265781@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240721070557.GE1265781@unreal>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 11:01:20 up 73 days, 22:15,  1 user,  load average: 0.02, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Leon Romanovsky (leon@kernel.org) wrote:
> On Sat, Jul 20, 2024 at 12:28:17AM +0000, Dr. David Alan Gilbert wrote:
> > * Allison Henderson (allison.henderson@oracle.com) wrote:
> > > On Sat, 2024-06-01 at 00:33 +0100, linux@treblig.org wrote:
> > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > 
> > > > 'rds_ib_dereg_odp_mr' has been unused since the original
> > > > commit 2eafa1746f17 ("net/rds: Handle ODP mr
> > > > registration/unregistration").
> > > > 
> > > > Remove it.
> > > > 
> > > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > 
> > > This patch looks fine to me, the struct is indeed unused at this point.
> > > Thanks for the clean up!
> > > 
> > > Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
> > 
> > Hi,
> >   Does anyone know who might pick this one up - I don't think
> > it's in -next yet?
> 
> 1. We are in merge window and this patch is not a bug fix, so it should
>    wait until the next merge window.

Yeh I did wonder; it was posted and reviewed back at the start of June.

> 2. Title should be net/rds ... and not RDMA/rds ...

OK, I can easily fix that.

> 3. netdev is closed right now, so it should be resubmitted after next merge
>    window ends.

When you say 'resubmitted' - you mean reposted to the lists with the amended
title? Or what?

Dave

> Thanks
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

