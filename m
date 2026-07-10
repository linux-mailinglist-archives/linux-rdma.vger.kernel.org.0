Return-Path: <linux-rdma+bounces-23004-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y1RjKHoeUWpj/gIAu9opvQ
	(envelope-from <linux-rdma+bounces-23004-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 18:31:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA00D73C993
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 18:31:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=C9B0DUBQ;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23004-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23004-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27DC3300B046
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B14435EE3;
	Fri, 10 Jul 2026 16:31:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C83F413E
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 16:31:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701102; cv=none; b=ryNic+6RBWvU5LNlWtLv830GCqn1iuhMJJgGB327MZOMsaUpqT34ngxFNAExxdR2Az9s84p2IrB6f0zKP+xIDWYsgCA5PCOntYuEtVU+QqD4/L4LVOUc9P2xQgiJHoxpGwIdzon0TGjOuVGbvdgLT1X1+kWaLXDMNb2qtR8bnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701102; c=relaxed/simple;
	bh=Sbx8vXWqQQ/M0W9UlsuLQM8Ua5Q1vedFs+JL66TJWSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByIwuXx0jlB2OK1R69A8FlZ8TsfL6E0qRuuwmNqnyNsp58rPK1XJdr2cPlAavXVdOWHpOyNh89k0eHhpdtUoysyoKyFOZQhTyvCBdNJ81V+MAB2mbzJqo+ZM2/8s+deM+koBRp2ijk4SS4AeZNDbdpK6UMiZZyaQQ6bSpY94oqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C9B0DUBQ; arc=none smtp.client-ip=209.85.219.46
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ee88fce476so11973776d6.0
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783701099; x=1784305899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ihr9TBqVvOWsgDH+NpkUYsK2K2fCkLkiaNuX2IHUYwY=;
        b=C9B0DUBQrFvmPqU9NSXU7hegpl7ojs8/mhmMnr9+I8B5xI9cbJN4vquMR+TKjoSRbe
         hRVqntMatUOMVwQ77aec0J9Doya+aG8IZxs5XirF5Ku3Ah35eFZG0l4ACmfIwbWBJMhX
         oVNossKW2Twv3Vh/obtosrQ/pXr9DDd7KelvhktBuY09jEM5IGYcXMOnzEoGs6Q/7Jdj
         K7AUzEdbaXOvsXR0zmLhfvAaQjl+FLj+w+DzYga35xmOl5qsbr94OSq0jOzS2tfeoYeK
         6EJs8zXW2Mz1qdRSBb4NWbEFf6BK3WwdCTjumyD2SidvzWStaTThJnCiasO0muhiqMZ2
         k0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701099; x=1784305899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihr9TBqVvOWsgDH+NpkUYsK2K2fCkLkiaNuX2IHUYwY=;
        b=m3BashNdkdmTIO9KOER0/BbWdH/tbeE/D8t2aCthLle5BX8k8llQOI/d8hsBkos0aV
         HzNBUPPFS25vIu2VtgNNwogTP9zqR8ZlGmY67ndh9x95TaAyD3oKgqnc2j8PDjyAwBpF
         2vW9hHKaZWRasBq2rkCj/yirIbHulckg+Z4Ar7rINGtS4R16ttFnavpPLQRK07gcYvst
         WHvCMobqJ2zlCHrtTf/UTKri6E/xQvUfRu77pmDRndfTZfTfhmarbTeoWA2KvBIobPQd
         qhcUojpseJ3QUKfQQnbrqfLW3xfYIZsq/ceCC7p4uL6A1s3wYp4W1v5d0lcBiBc1PlQZ
         u58g==
X-Forwarded-Encrypted: i=1; AHgh+RrM7xFrbNOPgvl493iUBBBlCP3AGGNfcYBM2eLABmzAFOy8j5XDgLZkKPhB4kyBN9b8bJaeZIxx9ePD@vger.kernel.org
X-Gm-Message-State: AOJu0YwWOCo8ZNpZ3Uwkf14I5RxGgakDZKv4YXcBUKuFYd2djCxbFvI2
	xRq72J3eDErayMLC9kxWeHcwIXP71U2+nSPmuQAcl41iRflvltnEAaMNLL78CuDJXlA=
X-Gm-Gg: AfdE7cmavqC7i9JTxsiq6HabTWT1d2ft9NZidxm0jS0jvtR8FtrDi5SxcMcpAV1mtHc
	HORKGjK3XcAahu+yvpUkrbTLKUs7G5oi0bWtXyf2DRc8+brZpxC3E52f1cGojccBBcuUkrOp1//
	zhwVLsH24LF8Fkj8nuseeIBPTZkAZNm2/LxOjMBCRBG+mpQ5y25lDMUOPYQASu0/gjO9laYhDdG
	yxysDfBB6fJES0E/TXYRpGhF+1A3bP+vEWaxnzCkyMZU0x44veY1vmhr1eUCYZI/34QOhcHPDhI
	t7FyiG9csLi63ZVlRpSgNfCYG6lj0KeOOZahrvkBTCM1UfAYqs5yp13PZykIw4SMunoQThQN7pg
	IWMsXiUTauqiPhC6sQCthnrRnviu/gpjymI3XVKKt3ZUKI1IFyNPemdj3n37KQJyCyJAvW00=
X-Received: by 2002:a05:6214:4710:b0:903:12c9:cba6 with SMTP id 6a1803df08f44-90312c9dcb8mr32500716d6.47.1783701099176;
        Fri, 10 Jul 2026 09:31:39 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4cd1sm44753226d6.16.2026.07.10.09.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:31:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiE8X-00000007Xks-3Vyo;
	Fri, 10 Jul 2026 13:31:37 -0300
Date: Fri, 10 Jul 2026 13:31:37 -0300
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
Subject: Re: [PATCH v7 1/8] mm/hmm: move page fault handling out of walk
 callbacks
Message-ID: <20260710163137.GQ118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345361483.660027.16455119612963295072.stgit@skinsburskii>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345361483.660027.16455119612963295072.stgit@skinsburskii>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skinsburskii@gmail.com,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23004-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA00D73C993

On Tue, Jul 07, 2026 at 12:46:54PM -0700, Stanislav Kinsburskii wrote:
> hmm_range_fault() currently triggers page faults from inside the page-table
> walk callbacks: hmm_vma_walk_pmd(), hmm_vma_walk_pud(),
> hmm_vma_walk_hugetlb_entry() and the pte-level helper all call
> hmm_vma_fault(), which in turn calls handle_mm_fault() while the walker
> still holds nested locks.  The pte spinlock is dropped explicitly by each
> caller, and the hugetlb path manually drops and retakes
> hugetlb_vma_lock_read around the fault to dodge a deadlock against the walk
> framework's unconditional unlock.
> 
> This layering does not extend cleanly to fault handlers that may release
> mmap_lock (VM_FAULT_RETRY, VM_FAULT_COMPLETED). If the lock is dropped
> while walk_page_range() is mid-traversal, the VMA can be freed before the
> walk framework's matching hugetlb_vma_unlock_read(), turning that unlock
> into a use-after-free.
> 
> Split the responsibilities the way get_user_pages() does. Walk callbacks
> become inspect-only: when they detect a range that needs to be faulted in,
> they record it in struct hmm_vma_walk and return a private sentinel
> (HMM_FAULT_PENDING). The outer loop in hmm_range_fault() then drops out of
> walk_page_range(), invokes a new helper hmm_do_fault() that calls
> handle_mm_fault() with only mmap_lock held, and restarts the walk so the
> now-present entries are collected into hmm_pfns.
> 
> No functional change for existing callers. As a side effect the hugetlb
> callback no longer needs the hugetlb_vma_{un}lock_read dance, and every
> fault-path exit from the callbacks now releases the pte spinlock on a
> single, common path. This refactor is also a precursor for adding an
> unlockable variant of hmm_range_fault() in a follow-up patch.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  mm/hmm.c |  118 +++++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 75 insertions(+), 43 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

