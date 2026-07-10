Return-Path: <linux-rdma+bounces-23006-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3KIrNp4gUWq8/gIAu9opvQ
	(envelope-from <linux-rdma+bounces-23006-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 18:41:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C2A73CA4B
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 18:41:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=V44Ncneu;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23006-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23006-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3C9F300980B
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA7343B3E6;
	Fri, 10 Jul 2026 16:39:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6AD43801B
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 16:39:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701552; cv=none; b=Ge5hHrORaPZNDnU+MT0RbElclWWCCZK8VkFZhPPlZnPJ95MSXioiWeN4Hpotk6lHdxyohamGeFUnfQDcyIu9UN+CZC7oaxJkRfoXJ6pucxP8ZTM0WF1BQrU/xfGaAnf38MEH6U7p3+qTuOzu0I7zctw6qz2yerAPHLc1/hp9rgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701552; c=relaxed/simple;
	bh=PXWpFGDjo49ebvD3J1EZhbbcBn9lhFalPM090sNNP24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGkCADlIOyJQfweJHlM8sdbLvjRiUt39Ml/34h76SvE6MayoyFKN5WUy+F9cjI4dII84kqXktZXGEa5YHZGnQ1iET4GGCtlwquJIODzGzBJ2r3NxsjbJNBZyIXMqWyoCsTRiPLRGdWkOGYIEAoU5CtLL/Vsa0y3bBxtHQrVv49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=V44Ncneu; arc=none smtp.client-ip=209.85.222.172
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e4fd65b2bso56709885a.0
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783701549; x=1784306349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pz9Az2A5A+eQsiowkEP3oUH5xkba/HyvmJjmLQ4f6yE=;
        b=V44NcneuBmSKEBchN78CSp+SaMfBLy1//YCpr9I1tT1XRDcFXG5+tSyEJHEeaYeVfz
         NIrEue9qNfNKDSL2SyQc22uCFfZIccdEKlzTvZiVjxSs7yW8ymKPTbjh3h5fCx8J6VRE
         ruw7a7Zb4wsfuusky6aj8N5Zh51FpvSSoGJh81s9qefwupZ1P5l5cIhrHg0UWBRhHCZF
         uNQncP6VKhKSu8y8EbYfIk2ibfq5mUb/raxQxKixeDH/8G6mZA13O+UEHcgJY563IsTS
         5NsI1Y3ojGWLdbyGmeRkfxWy2e+I5uI8lgN5cqIFUUap3X2wvZlttOnhG3/sjVeBLu5G
         WuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701549; x=1784306349;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pz9Az2A5A+eQsiowkEP3oUH5xkba/HyvmJjmLQ4f6yE=;
        b=AVoNdPfYcC448vpk8FeeS2hOA87c6N3Oygubu4Ig2d7GGiwNkxm3dwsX7sgUuIPnWe
         YVCGYN2M/vIO7X+ZMAovGcMmqQd8b10jQevOiZTnUUjQjgSveZWmFpkvILLr/mu0CFsW
         O/aenyqxT8bGNMhsJc6pq2YSi1zz0jBVpAU8H5LJEoH29NGXvegohSMvGG16/WKEjC1r
         5M12Pwaf0ESzSDeVqW2SSSRDTNQHP0PYeFhEHSs+64XMsxZ7WUgRkgvj56oyiexZEnw7
         xQEYi5ae/+2wxFrBiYx1+cPl08NAt1vMLZdbYCQ8l00dO1PoiRmmxL7JU0qNin50HBD3
         O1DA==
X-Forwarded-Encrypted: i=1; AHgh+RoYuFMOH4draQoIoPgp5/PkqLCNYp8p5lXEQpwcZa4S86NpgTLTr++ci9C5gFugkBb6HuslYVSjr0WR@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZHw1/o44QoYoB4RCpFlocBaEyTwCQPLUvEmTcRAvhCh+zfym
	ZjgtoIF89vJm98u9hOB0lyT93fu/Qq2UD5mNlwSevReytNIQzg9gER4FlbVJMlq0JV8=
X-Gm-Gg: AfdE7cnGYAXmOFPFQ3wtOrzqVUUR68JOE5Fj/qOggZyGOxafH0bcGi4i8w51bbORgW/
	WztcMGeB3L+KP/rMAbFHsGFay+d7R1Gf7yNKREFxZoKHL3bcRwtMC5Sqpdt8oUdHBWwZLNy8e9A
	D33+eIytXYZKUkwMEI/vkeNhRcmvhKVm3FfUmRG4yPLSXi0xc0RiuUBNUWr4mcpuOxFDQompP6T
	yr7/3DY4QWVvGeNaZ3PRFD4GpaT0u+sRxktPDEASCOuvTgwAVwq8CarIr7YWCpMz1E1FuDSA+BJ
	lx0szY14F4e/I9Ub+7M+tbfDs+FBV3ayRiE3m/ia66+lvXecR2hWo2UmZ1tJC3TjRoYNzkGF929
	gJQAeMeQ3llo0W0j4/BINtESAHM0Vm5kJKWYGAs8d0R54sqGvuTyaddYtUobT
X-Received: by 2002:a05:620a:2842:b0:92e:44eb:1e7a with SMTP id af79cd13be357-92ecf5f0e37mr1356630085a.29.1783701549520;
        Fri, 10 Jul 2026 09:39:09 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5bcb074sm235123285a.21.2026.07.10.09.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:39:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiEFo-00000007YRj-1Qzt;
	Fri, 10 Jul 2026 13:39:08 -0300
Date: Fri, 10 Jul 2026 13:39:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
	corbet@lwn.net, dakr@kernel.org, david@kernel.org,
	decui@microsoft.com, haiyangz@microsoft.com, kees@kernel.org,
	kys@microsoft.com, leon@kernel.org, liam@infradead.org,
	lizhi.hou@amd.com, ljs@kernel.org, longli@microsoft.com,
	lyude@redhat.com, maarten.lankhorst@linux.intel.com,
	mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
	nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
	rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
	skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
	vbabka@kernel.org, wei.liu@kernel.org,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 4/8] mshv: Use hmm_range_fault_unlocked_timeout() for
 region faults
Message-ID: <20260710163908.GS118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345363584.660027.14063544694872741718.stgit@skinsburskii>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345363584.660027.14063544694872741718.stgit@skinsburskii>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skinsburskii@gmail.com,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23006-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,microsoft.com,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4C2A73CA4B

On Tue, Jul 07, 2026 at 12:47:15PM -0700, Stanislav Kinsburskii wrote:
> MSHV currently faults movable memory regions by taking mmap_read_lock()
> around hmm_range_fault(). That prevents the fault path from handling VMAs
> whose fault handlers need to drop mmap_lock, such as userfaultfd-backed
> mappings.
> 
> Use hmm_range_fault_unlocked_timeout() instead. Passing a timeout of 0
> preserves MSHV's existing unbounded retry behavior while letting the HMM
> helper own mmap_lock acquisition and refresh range->notifier_seq internally
> before walking the range. After the fault succeeds, MSHV still takes
> mreg_mutex and checks mmu_interval_read_retry() before installing the pages
> into the region, so the existing invalidation synchronization is preserved.
> 
> Fold the small fault-and-lock helper into mshv_region_range_fault(), since
> the remaining retry path is just the standard "fault, take the driver lock,
> check the interval notifier sequence" pattern.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  drivers/hv/mshv_regions.c |   54 ++++++++-------------------------------------
>  1 file changed, 10 insertions(+), 44 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

