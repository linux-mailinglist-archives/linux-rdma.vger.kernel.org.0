Return-Path: <linux-rdma+bounces-15942-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAv5Fa2jdGkH8QAAu9opvQ
	(envelope-from <linux-rdma+bounces-15942-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jan 2026 11:49:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A3D7D4E6
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jan 2026 11:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0333300CE75
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jan 2026 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4942D0C84;
	Sat, 24 Jan 2026 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO9W6wBq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271AE28488F
	for <linux-rdma@vger.kernel.org>; Sat, 24 Jan 2026 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769251746; cv=none; b=JFSuSy6YAbSYjp2RSxtXXtxsV9nNTQW3SreH5hnWkr2K/ZXcq1kA06PQgShnNqTd3q+tTPwDjDOQgAHRBi+HsQ6GogsQtVjMwpIs/ZZedWMz+1wJtsZ2u1znFh9NpXbKdmUAZKqfC6N7MGUzLKJVypkfjCjGhQm0wx0M4HeFdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769251746; c=relaxed/simple;
	bh=5by/krL4LkgSMMT5g0Z2p396tLopyd3gucFBw6XyILI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWw/XDVb1sk/YRjuLvZqgAZTa4b1/2iwyHDcUe1xvz+VYO3QQCtIDWCuVjKvCW36jVM/eRXLWsbLoNYMEqr4SxIzruTAnbsvqzxGcIgFeP1ZrpFuqo9j1cZd1ihjYF6OQ2rvLTBIsNozdC6m1RpyPGvkVqDgU/Lf8q/U9gAWs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO9W6wBq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-385c23b88e8so31705021fa.3
        for <linux-rdma@vger.kernel.org>; Sat, 24 Jan 2026 02:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769251742; x=1769856542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PcVibjw4mjDgQQhM+5ORM6LTnO2Adlw+9ruZjnxFQfI=;
        b=FO9W6wBqZnSzLyHl8bLgqcXLeB2FBCw24iZhkVp5h+SIGMt89cbwlFtHNkhArvBFiF
         XK/fhtxdAdaO3glXzpLZvG3n++FXitqL6vu0xkEj2YjmiIV01pYVXDjvNuN644Rzr1o4
         5E9LuVu+IOdip/IUdYD896GXIrqvZylYfLsehs6oibk0Z3CeadfJF17LrAMv8seFIVvT
         qBGFuw5oihSouhAzTCAa98kN9Ea6PCLdSr/hCo2jvZcIxs7dLgJZu/NtEpuhB7Li/Oq7
         WMC46BcuKsZCeWvbu0DxqfVdWnCmZEi4KlRTtk8zVHbcRUmNSMTyA/jmgW3XjhxV2CVI
         sQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769251742; x=1769856542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcVibjw4mjDgQQhM+5ORM6LTnO2Adlw+9ruZjnxFQfI=;
        b=R4tWLPuz94pjCXeJq6WSEXNHDDJcqAC5v8SLmUSAmYl0Yil2IWx0LPkQ/guG/DAzZX
         b3kC9mpbBaw8Tr1t8slPIyKT7wTdRx697tuWEQfQmiS4sCSMZrcarNh+pnHlwQGpoO/T
         dLCMc0ddzdM9SkK+4NX46IckwxURbNZSMtBf8w7Brqkq76G7SdwhbU1SSt0bYkS9gdIc
         rH8gGnnLflv3z1jIHcDeVQyiegTu8YpVU8z1GgtXb47NtwLiIUaATlcXQ3df1fZ3Eg6m
         vQQ12xPu6bHQ9uCFcCZFzAOa/2l39jWYcK+TQQItOB20CeptA/LWcKlYsoul00EbYb0P
         +b0A==
X-Forwarded-Encrypted: i=1; AJvYcCUOVTX2xmztOGkSUpv/6dhSMZYq+Y45Xbb9gc0i7Wj2FfILC4FhSRTYyszOjHqvLC3ahINxSkVZUpNr@vger.kernel.org
X-Gm-Message-State: AOJu0YwNRsRf+lj8H+mv6gwAk45rK512HtPaO+hjX3WgxIpJDJaR1/7G
	SrFlUo5PAR6Tm1rtuNwYsLLz7D87UgvS4W0U1dmqhBmj7qkDOqrLM9Kt
X-Gm-Gg: AZuq6aIFaBvh6ugArYu03hG2o5FsFMJzWFI+eOuDgtIVk5zRz7b5c2d6EONf9AKo/8v
	duM9JN2r3UU6PuISrzzDd6oLaRLHXlove9zGEbmrLbj1raSGnRegssxYbm14pL+uH+vReTw3jvJ
	ALCeCXNPj5MRK6UOpkcJvamRwexznBVYbvryl80jv71Lmo54LW1Tq3HsxDtP2QK9Mo/zuxC2fB0
	RP7GQCmP15i78rUkSBs9dTxngyfsp96p7JX5OcYZ3FXijx4JV5svhJVTZgZMr/l2Tq1wKj0RbCJ
	ifvZoVxQ/+LCb/M1uot0R/k97Cx+7UDreA/36LY20pRiGYxr1tvq/lFbd43UncfDagAiY1RchCw
	K2HK/PL2CWE2Kyv+TrywbxG1I4M0cqrYy8wvVewKciyvpwZ5xmLw=
X-Received: by 2002:a05:651c:1a0c:b0:385:c21f:37e3 with SMTP id 38308e7fff4ca-385e1b715dcmr15798421fa.19.1769251741385;
        Sat, 24 Jan 2026 02:49:01 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385da1ab6acsm11193501fa.40.2026.01.24.02.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 02:49:00 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sat, 24 Jan 2026 11:48:59 +0100
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <aXSjm1DXm6yP62tD@pc636>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
 <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124093505.GA98529@j66a10360.sqa.eu95>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15942-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,linux-foundation.org,linux.alibaba.com,google.com,kernel.org,redhat.com,linux.ibm.com,vger.kernel.org,kvack.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[urezki@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: C4A3D7D4E6
X-Rspamd-Action: no action

Hello, D. Wythe!

> On Fri, Jan 23, 2026 at 07:55:17PM +0100, Uladzislau Rezki wrote:
> > On Fri, Jan 23, 2026 at 04:23:48PM +0800, D. Wythe wrote:
> > > find_vm_area() provides a way to find the vm_struct associated with a
> > > virtual address. Export this symbol to modules so that modularized
> > > subsystems can perform lookups on vmalloc addresses.
> > > 
> > > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > > ---
> > >  mm/vmalloc.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index ecbac900c35f..3eb9fe761c34 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3292,6 +3292,7 @@ struct vm_struct *find_vm_area(const void *addr)
> > >  
> > >  	return va->vm;
> > >  }
> > > +EXPORT_SYMBOL_GPL(find_vm_area);
> > >  
> > This is internal. We can not just export it.
> > 
> > --
> > Uladzislau Rezki
> 
> Hi Uladzislau,
> 
> Thank you for the feedback. I agree that we should avoid exposing
> internal implementation details like struct vm_struct to external
> subsystems.
> 
> Following Christoph's suggestion, I'm planning to encapsulate the page
> order lookup into a minimal helper instead:
> 
> unsigned int vmalloc_page_order(const void *addr){
> 	struct vm_struct *vm;
>  	vm = find_vm_area(addr);
> 	return vm ? vm->page_order : 0;
> }
> EXPORT_SYMBOL_GPL(vmalloc_page_order);
> 
> Does this approach look reasonable to you? It would keep the vm_struct
> layout private while satisfying the optimization needs of SMC.
> 
Could you please clarify why you need info about page_order? I have not
looked at your second patch.

Thanks!

--
Uladzislau Rezki

