Return-Path: <linux-rdma+bounces-3910-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622C2937E80
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jul 2024 02:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949681C214CA
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jul 2024 00:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E685A1C27;
	Sat, 20 Jul 2024 00:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="IEau3GTE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798424404;
	Sat, 20 Jul 2024 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721435314; cv=none; b=DQiA2EVMAiIXU5lJZibg0lDIlIqHcmL0bapiKobObw4cl51jJXTbJ7pKXNh4ykT8ygDND+1rvea0MJ11c34/hTmwyY6wcxowD0EYVvk16QCtj0X2LF0bHXWy5pAv9FRLnTz5W/kUJ/GeKGHvtz2aZ8PXah4EAIu7Yrft8x68E+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721435314; c=relaxed/simple;
	bh=Eul2CBV4qWWvrz4hc9g9QRwccvT28YsfWm7eoLJzhCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMfsjei8jtHDAL8BwvoK7YDTV19vsS76tpep7bpUx2KHSTnTIZCQkyMjKW76sA9l2BNSsbpwyDZ6B+sRilONUt8qo60qf8hTKhzT6+2kSXzH+fPzrcqCgYwsNW3L68JFwxZN38dFcVRT7x8ZP3zSmt11g9BcyHBNW3WynAVpFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=IEau3GTE; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=VGildi8JKxn7CDz0glPmQSzXJV50SAWGnGDt2jhS1L0=; b=IEau3GTEdY9ViYZz
	DLYX84kE5Xg3dD7A2fvFcbr7BkqgSa0YTdBx7hyXNWQyo0s1Dj+p94n6RtH0ihDLyeRYoR6jrnyfC
	fBmJX0qHf+H81kLzUypELPjea5EMO3wAVNPsmSKsC6u2RQl+7bPpMiMiU3/vEgFbQo309f2EkD5QF
	eaJWaBuaO5qo/DG9kNYnSyc00X1MT/eOSh53zhkYW6uiik/04S0l5AHDMB1+lRNqG+Ofjs+EJ5vMy
	jO1IlIhRHcqUPwpLdHo2X3zar6N4ncCWA2fP6S7Nit4QtPRtblP1TlYybmSSxs2taO/uIbN4I8gll
	e/mrVe08G/+RW/iGPw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sUxxR-00CVvw-0j;
	Sat, 20 Jul 2024 00:28:17 +0000
Date: Sat, 20 Jul 2024 00:28:17 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "edumazet@google.com" <edumazet@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rds: remove unused struct 'rds_ib_dereg_odp_mr'
Message-ID: <ZpsEof3hxKGQBmqF@gallifrey>
References: <20240531233307.302571-1-linux@treblig.org>
 <2442cae88ee4a5f7ba46bb0158735634fa82a305.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2442cae88ee4a5f7ba46bb0158735634fa82a305.camel@oracle.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 00:27:42 up 72 days, 11:41,  1 user,  load average: 0.08, 0.02, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* Allison Henderson (allison.henderson@oracle.com) wrote:
> On Sat, 2024-06-01 at 00:33 +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'rds_ib_dereg_odp_mr' has been unused since the original
> > commit 2eafa1746f17 ("net/rds: Handle ODP mr
> > registration/unregistration").
> > 
> > Remove it.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> This patch looks fine to me, the struct is indeed unused at this point.
> Thanks for the clean up!
> 
> Reviewed-by: Allison Henderson <allison.henderson@oracle.com>

Hi,
  Does anyone know who might pick this one up - I don't think
it's in -next yet?

Dave

> > ---
> >  net/rds/ib_rdma.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
> > index 8f070ee7e742..d1cfceeff133 100644
> > --- a/net/rds/ib_rdma.c
> > +++ b/net/rds/ib_rdma.c
> > @@ -40,10 +40,6 @@
> >  #include "rds.h"
> >  
> >  struct workqueue_struct *rds_ib_mr_wq;
> > -struct rds_ib_dereg_odp_mr {
> > -       struct work_struct work;
> > -       struct ib_mr *mr;
> > -};
> >  
> >  static void rds_ib_odp_mr_worker(struct work_struct *work);
> >  
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

