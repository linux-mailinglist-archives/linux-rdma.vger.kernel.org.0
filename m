Return-Path: <linux-rdma+bounces-5239-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D44879913BC
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Oct 2024 03:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1BA2847BB
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Oct 2024 01:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E438D5223;
	Sat,  5 Oct 2024 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YIkmZcNY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB65182
	for <linux-rdma@vger.kernel.org>; Sat,  5 Oct 2024 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728091242; cv=none; b=t1DDPBBZVaqDRx1aUOYbtKy+SmvZZaJOoVwdJA5NgH7q0U0YDZvedjO3tb3G5AfmOn+LX72oLppRRTfHmJ/DhK6A00pzXG8O1QDDfygI6w/BxoQSnEEtThCHaMeIuh+YVGcGsSnGSvDjDatUaIDrRR8pakvD+ETnjL/RruQlmq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728091242; c=relaxed/simple;
	bh=aXfYpPT44p2gsKLBih7tvlB4umsQ9vSnIk0mnmbQ1Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JObu7inG1xgFxv6eVfx2rLKcnWlu7yi1sfYV7WivkDwBbhfNu0M9bwT1uh4iAnKQ+Fyvfbi4Zc4IOD0N6qmAJbaOc6Bs4oon+oBQ4Tb3vCzkjgslyjvPSq4WydxJGg3fTsW/GtoW7WrEuOVlBUpYgM4fyw44JYXIBMLDQzaZu/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YIkmZcNY; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4583083d05eso20697801cf.3
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2024 18:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728091239; x=1728696039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jf4b89c9+MBa1ujlAJmxbgzVmzt/81zYphoDSWe2Ndo=;
        b=YIkmZcNYKzH1jyACMrkc2V19kCIy7FKpuVYyZj5tzTYWROTGW5ObA5YRbdMhKlUA03
         FeVsN6DbrMiggri4SylG3rmg0/NyIgvncyaX1sZq34r3lv+GumDGk9a2eQfRde/sxlif
         Jm5v6P+ucZ3QS+6/IzoUZ2bxSY0l+vHE8CBhNhXY2MTINnQRBD9AmZnER8ZdftruoFNI
         2+AFdxU0LI/ldv1yM3bHox7tN455mQCD/M/QSP3bJAMa/p1s/rCGgD1r7GSFEZlYsovn
         ynAdfC6BPZPx9emlTa1vWK4ofX0Pqocf3wnNt7BH/yZj6FRFZXv1G6EY0U1UhZ/fIRHK
         W1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728091239; x=1728696039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jf4b89c9+MBa1ujlAJmxbgzVmzt/81zYphoDSWe2Ndo=;
        b=NEb4M3NilCrUDVm1irR3vo0G1acobTwqnXO/4XJ8OZXqVlfgXlnp/miV22tHpukDJf
         CsygmTAmPoLXzesBs/41J+qDlo57nT8gANtp5l8XWoYgv4HSK0kpxuEBKfLcfeaxH+E1
         SzuGkXDvo+N0IBojRlyxPowSQOFFed7VpelE0mQqQYr/UHEbzNCqhPzWVkujRFjybh15
         f3mwDCjN1zYvJ8dqfaavq9N7a5bF93ohVjjKQ24KNlD6lPeGasAZ0e0/PYtiPNrVHGpB
         vG6yNCQvj/rPxchF83KYKyIfyPX3NfabVWQFXTwgiqBpOv+cLuYifJi5yIr3bbsHbOS4
         TYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOrg9nxfpYkC0FnfvoAsyohyMW75xWG+Ot3gVAAZupsihA5BMTHK2U2qJ44Ru0uhtpbTF4+pjxK7So@vger.kernel.org
X-Gm-Message-State: AOJu0YxAanbK7xH48WsGM90MMtM4RCruPPC2/PawcIDFD+tNnDNFJfdK
	7/YYAvYfC1cVxqcJbV0k2LNoCQxq7lyibFK+EY0TP0Ix0b15W5szKoli5OsUgvmn1Sr2YPQRPfE
	X
X-Google-Smtp-Source: AGHT+IEp9UoJh8EX/a2sc2//ORUKH6F8Oz3nOO6iQ7jYZV8AleUCXytjYil1t7eB4WoTL3CbapdR/g==
X-Received: by 2002:a05:622a:20e:b0:458:203e:937d with SMTP id d75a77b69052e-45d9ba2ba98mr71160281cf.4.1728091239420;
        Fri, 04 Oct 2024 18:20:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da763fdafsm4063061cf.81.2024.10.04.18.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 18:20:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1swtTJ-00EjnX-El;
	Fri, 04 Oct 2024 22:20:37 -0300
Date: Fri, 4 Oct 2024 22:20:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [syzbot] [rdma?] possible deadlock in siw_create_listen (2)
Message-ID: <20241005012037.GL2456194@ziepe.ca>
References: <66f562e3.050a0220.211276.0074.GAE@google.com>
 <BN8PR15MB2513A03800D7E2AE03C63B0699722@BN8PR15MB2513.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR15MB2513A03800D7E2AE03C63B0699722@BN8PR15MB2513.namprd15.prod.outlook.com>

On Fri, Oct 04, 2024 at 04:10:31PM +0000, Bernard Metzler wrote:

> Could one please help me to understand this situation?
> cma.c:5354
> 
>         mutex_lock(&lock);
>         list_add_tail(&cma_dev->list, &dev_list);
>         list_for_each_entry(id_priv, &listen_any_list, listen_any_item) {
>                 ret = cma_listen_on_dev(id_priv, cma_dev, &to_destroy);
>                 if (ret)
>                         goto free_listen;
>         }               
>         mutex_unlock(&lock);
> 
> siw_cm.c:1776
> 	sock_set_reuseaddr(s->sk);
>
> ...which calls lock_sock(sk) on a feshly created socket.

I think this is a smc bug, and lockdep is getting confused about what
to report due to all the different locks.

smc_setsockopt() eventually in ip_setsockopt() does:

	mutex_lock(&smc->clcsock_release_lock);

	if (needs_rtnl)
		rtnl_lock();
	sockopt_lock_sock(sk);
	mutex_unlock(&smc->clcsock_release_lock);


smc_sendmsg() does

	lock_sock(sk);
	mutex_lock(&smc->clcsock_release_lock);

Which is classic deadlock locking.

That the CMA gets involved here seems like wrong reporting because
syzkaller put those lock chains into it.

I guess this is a dup of 

https://lore.kernel.org/netdev/00000000000093078f0622583e6e@google.com/T/

Or at least that should be fixed before looking at this

Jason

