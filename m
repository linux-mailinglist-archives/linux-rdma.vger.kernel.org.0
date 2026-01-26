Return-Path: <linux-rdma+bounces-16015-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC46E/lBd2mMdQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16015-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 11:29:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0377E86EC8
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 11:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A4153011C5F
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3450733065D;
	Mon, 26 Jan 2026 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxR15TY3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22980330330
	for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423332; cv=none; b=VSRSS2NKihdFJ0YMh3CX87ZUrQLK8xpQ6cx7CPzJ8pm0klmkXUmRjz/Xm07a4Czw17Cj1pC3gK7F/YMJnNqVX0cDAZD0l5S+AC5MHAXzLYois5KjlF4XrwMZO7z9+3vwTqEdZfGjg/xTZOS6XbTaptHbnAfyvm51ng36mkWMb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423332; c=relaxed/simple;
	bh=Mq4jhoQwiChk2fbSJkOenkl/50i+ECFFT+yZETA5cbY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG9g0KUj02SnYIiRjRCnZxGiCHGMAC+x+AfAlX4RBAm55afZWByf+l+qnImkGsjhc2VQrTq/kokeuQ0XaKld52Q3JUmXvDyPvRb3L/7Z4gkuufH4ucRfUMH4LyuhkbOOtTDmaneG6x7TsplZhSrA4yr7ZiUd/dWU5D2bfCqXnWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxR15TY3; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59dd22b9895so5108113e87.0
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 02:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769423329; x=1770028129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=auhtqvKNqSuy3B8gISIK2h86XPLcfd95W6hmGc7ctWo=;
        b=ZxR15TY381sdQAr7ox85tqd7OVr7m8CmarXwuhqN1oDLdoTqFXENoWv9cnF7LHJ+Nc
         lfh2Rek/CbjStFrNBqGB69iT+ngjbV2qZxJER9DNM2m12lRh6L5f/uDeoeT6ok7iovZU
         q6eYr06ipygPk62Nac/szrd5PsS9OkXI92Jn6hUvKTtbqu6goNK4Qlb54F80s0jXCVSG
         IONXBaQe55ANxUezmhTY8h88oMXNGZVo2J3KLexpgM6RUX3UZmiqvQXLLDFn0kkXLspz
         42SK8/OoUt6VKvNoCLjrtr3tGWsBbSfUflAKz2wGu0PcPijRw9r5xTBJmCmq8QIUHVRL
         c7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769423329; x=1770028129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auhtqvKNqSuy3B8gISIK2h86XPLcfd95W6hmGc7ctWo=;
        b=aBx9aJDknO2bQ4jZW5lpbucVGp0aYFhNopkW4hyV7VfzaxLc+R9GjIfqP4/MiEo5xx
         KEqiSWElHCNJOt0d7XC8dU8tSEXA7ZqEKWcBq/TfZpzcnLcuprpurUjci+kHNOE7Hd6D
         jztxKnQZ0QlzNEE39jeNVXjJ6cLFN9keE7YBb893oYVBnlSGG4ipr5zWUppk23Adsdfw
         63hR9lYWXXIX9MH05lZ7ul+LWXnlrGF6wGxchTp3KFgiGGtvhah6K7eJ+NsyLRAHlEXd
         JjreHn+NvZOt7XMW2/CW3FQPK0OqG4qP4CtQuMRIMHTvLE+JHyGf5YNLWsMbZKQMuMb0
         fynA==
X-Forwarded-Encrypted: i=1; AJvYcCWTfCN2fRI/NQOytT+tZ2b92kOYgQImOYRg6DHQopxipsoebufySbLQtaFPxserWnQFBjPAAL2cGS0x@vger.kernel.org
X-Gm-Message-State: AOJu0YyM57z44lBI9BB//HC4o+wicZFidqWFsDsS+AKScJjUi4lTedmO
	LAH6AvRrWwsdNPlnu5ziT5MT1UE3lUXE4WN9HZo5UoEpmJ/Hqod2fUZxmQsdnw==
X-Gm-Gg: AZuq6aITrXZtoEzCfbpQAQukglkbc925/twdAixjsE4J7QBAKX1v/KsuLvJRsjDEtoj
	xgqIDjRCJWR9gaA07AtvFHtw58+6BOiz21+qkXXWjDKW86CCYsbHwnYVXIqmFYYYy3Jn4xrSfn1
	t0mqobVKnaR5+xrpwTt107kvJm4nD72Gdokti9SS3dF1L7QSClAEO9pSk3HN0hJcnx6npY9pIvB
	eAC5NCzDTJtRwvFLruLwvYzyD0BbxO+0Zjj5heNugRWjYXnbTB+oyrbbh6MCnVxxcJXaXJutUp9
	U+X3JPBDTurtrjmYu0wJP++KSjeNKF5IL7cEGtPv/AXdBQyez20boJFNCfo0/FjxNMkEjfqspi1
	aqwJQ9VlFyblqVX3Q/zPY112xAVQtlS9piiE6ShdcNCVDtgHY/neIL9y6SckY5SM=
X-Received: by 2002:ac2:4bd6:0:b0:59d:f5ad:1267 with SMTP id 2adb3069b0e04-59df5ad12a3mr1093590e87.9.1769423328970;
        Mon, 26 Jan 2026 02:28:48 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de491f8b9sm2596674e87.68.2026.01.26.02.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:28:48 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 26 Jan 2026 11:28:46 +0100
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
Message-ID: <aXdB3lsm3w0fJT3Q@milan>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
 <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124145754.GA57116@j66a10360.sqa.eu95>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16015-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0377E86EC8
X-Rspamd-Action: no action

Hello, D. Wythe!

> > > On Fri, Jan 23, 2026 at 07:55:17PM +0100, Uladzislau Rezki wrote:
> > > > On Fri, Jan 23, 2026 at 04:23:48PM +0800, D. Wythe wrote:
> > > > > find_vm_area() provides a way to find the vm_struct associated with a
> > > > > virtual address. Export this symbol to modules so that modularized
> > > > > subsystems can perform lookups on vmalloc addresses.
> > > > > 
> > > > > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > > > > ---
> > > > >  mm/vmalloc.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > index ecbac900c35f..3eb9fe761c34 100644
> > > > > --- a/mm/vmalloc.c
> > > > > +++ b/mm/vmalloc.c
> > > > > @@ -3292,6 +3292,7 @@ struct vm_struct *find_vm_area(const void *addr)
> > > > >  
> > > > >  	return va->vm;
> > > > >  }
> > > > > +EXPORT_SYMBOL_GPL(find_vm_area);
> > > > >  
> > > > This is internal. We can not just export it.
> > > > 
> > > > --
> > > > Uladzislau Rezki
> > > 
> > > Hi Uladzislau,
> > > 
> > > Thank you for the feedback. I agree that we should avoid exposing
> > > internal implementation details like struct vm_struct to external
> > > subsystems.
> > > 
> > > Following Christoph's suggestion, I'm planning to encapsulate the page
> > > order lookup into a minimal helper instead:
> > > 
> > > unsigned int vmalloc_page_order(const void *addr){
> > > 	struct vm_struct *vm;
> > >  	vm = find_vm_area(addr);
> > > 	return vm ? vm->page_order : 0;
> > > }
> > > EXPORT_SYMBOL_GPL(vmalloc_page_order);
> > > 
> > > Does this approach look reasonable to you? It would keep the vm_struct
> > > layout private while satisfying the optimization needs of SMC.
> > > 
> > Could you please clarify why you need info about page_order? I have not
> > looked at your second patch.
> > 
> > Thanks!
> > 
> > --
> > Uladzislau Rezki
> 
> Hi Uladzislau,
> 
> This stems from optimizing memory registration in SMC-R. To provide the
> RDMA hardware with direct access to memory buffers, we must register
> them with the NIC. During this process, the hardware generates one MTT
> entry for each physically contiguous block. Since these hardware entries
> are a finite and scarce resource, and SMC currently defaults to a 4KB
> registration granularity, a single 2MB buffer consumes 512 entries. In
> high-concurrency scenarios, this inefficiency quickly exhausts NIC
> resources and becomes a major bottleneck for system scalability.
> 
> To address this, we intend to use vmalloc_huge(). When it successfully
> allocates high-order pages, the vmalloc area is backed by a sequence of
> physically contiguous chunks (e.g., 2MB each). If we know this
> page_order, we can register these larger physical blocks instead of
> individual 4KB pages, reducing MTT consumption from 512 entries down to
> 1 for every 2MB of memory (with page_order == 9).
> 
> However, the result of vmalloc_huge() is currently opaque to the caller.
> We cannot determine whether it successfully allocated huge pages or fell
> back to 4KB pages based solely on the returned pointer. Therefore, we
> need a helper function to query the actual page order, enabling SMC-R to
> adapt its registration logic to the underlying physical layout.
> 
> I hope this clarifies our design motivation!
> 
Appreciate for the explanation. Yes it clarifies an intention.

As for proposed patch above:

- A page_order is available if CONFIG_HAVE_ARCH_HUGE_VMALLOC is defined;
- It makes sense to get a node, grab a spin-lock and find VM, save
  page_order and release the lock.

You can have a look at the vmalloc_dump_obj(void *object) function.
We try-spinlock there whereas you need just spin-lock. But the idea
is the same.

--
Uladzislau Rezki

