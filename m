Return-Path: <linux-rdma+bounces-23017-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QXY/DewzUWrmAgMAu9opvQ
	(envelope-from <linux-rdma+bounces-23017-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 20:03:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C178573D2D7
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 20:03:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=XwYTQHDC;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23017-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23017-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1FCD30160F4
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBFC25B09D;
	Fri, 10 Jul 2026 18:03:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324443290A5
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 18:03:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706596; cv=none; b=T+BCNUOsx2DLDvFhmRvZKfdDnihW96n4k8iA/xUUH6tP6G42926UE1+DeyYNBqtOc05HDhS9YIbXXUpkrTzHQQfrUPXfpKISIFZbjSuTBs6iqiG9fljDtUJbNQB/l0iw2ujJV8Y1sQXs8sv/1lPyJlWYCPPhJ3X3wfxKsZpmHXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706596; c=relaxed/simple;
	bh=JK0Z967O7a8Bl55D2zvwLZqTqZpUiSqVWqaZiixu9aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyYLlmjAaBDrKu08alk1IUO6un6ucG0FHcCtAJjoylW54+fimuUjbUa0DK942xhbkAd7F4DwblbOIKwqspiWurBtJTJZyIwLN3Nsz14E/2SjNQ8/H41SMS199azMp+pjFYgB0dgViBTz2f1OVVhx0+gkFu1PwYz45hvT6JDe3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XwYTQHDC; arc=none smtp.client-ip=209.85.160.169
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c21495722so5848361cf.3
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 11:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783706594; x=1784311394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pchhQjIZYIsHA+IyTP+kMOXOCiYK49mahPv3eolm7bw=;
        b=XwYTQHDCXEb07KED5ajRKK6taRPykEMNgPlbxgCoJ4mfSIU0+sBiMJHRZvdL3kDHT8
         WQDYq82uKGVSKALSD9uEckizEuWQ2DNoYU63JJ+9rkYmF4JV6xkEWtvhkBJBR7bOI8Ve
         hdLqNf/imepRfwD/zhfXO415m1vIlJmlKR/Q8WaW2vExCXpBIfva58QADaj8xAfogDMx
         Nmes74qpwPyzJV1r7mdIV8ROCQq1aSF4UabkGgEs/994EN5u8W9eaU4JK49IMLDDM9Hd
         JAnfM7tOFwVTmMx0vJEgkpnMbRCPvl8dHdpcEhdItpTA+2L8Ss1sw4xDaMYfAX6TCA09
         Bg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783706594; x=1784311394;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pchhQjIZYIsHA+IyTP+kMOXOCiYK49mahPv3eolm7bw=;
        b=S1hGv5BDyZ7O4iAPyfw4U9w/Z2Aye60Qp2w104mNxrWDWgBZKuzKFcOuw+yn+xFHpr
         ZBuT0bdbpQqHTcc91fZThLDreu5lWk6jrMeboM39SjXZIDJt08i3VGV3bdZUW0zS02q6
         BmgFY3wIdFQbT7+A/aWYxJtx5LLt+CT1ZmbDLaxkO+0YK49gwuToFqi9BEEpNxUzHERx
         5ZrNAkGodX7kYLB/ynWLkTtgyea9b6ib2NueWBIzcBIx4Gg6rParsq8Ec/zSWvK0Gni0
         wuOuuEHcoMCSYrN1t4FIPNun4JGoywKe49zQ8V/LU4y/4LJU6PoIDW45Zde+TzrubV03
         D39Q==
X-Forwarded-Encrypted: i=1; AHgh+RoqqyRw9fs1PcNJno3uJt43+4YrDbS5QHlOzfnGa5ywvId3PHmL3JyIzcP/FE5jns489HArSJAD+1OO@vger.kernel.org
X-Gm-Message-State: AOJu0YxkqnuHdDN4fvTooKaJ8+OB1x1PoE1CHlVVbTqiX38x/u1HqyxY
	EME4ERxhEBEXnwz6Q5DQM1mdwnFWl6RmTs1u2w+drKd7kat9XooZrJw6YmrPZzVnA7E=
X-Gm-Gg: AfdE7claXEP5nyNj2o4c0M4qdBKo4+Hat5Ia+inVJ+vNQbsWCzNYULJ5rP6n/aB4sZF
	Sgzn0wauxed55BHZSQo9WXjg74soYt0fs/7Yqn6SPiaBOkFH9G5/4tPKjvDWkXhVz8xK4L5adFF
	Tlyjbq3ElB532ojmrmOS2pwAKspkJ4Iho3sH+X8gBzmJKBGgb/cZLDltCBS4Yg7Zxe5HHXq28L6
	KUVYiUWTgVUjUmSjzVHLTt+ZLCH01pw78eZy2HAdO+lQ9WaojFQfDPc+6qMV6a3enfdnvql2C1Y
	yJgfJPg82KQ5iDjGw1j9Z/p9hYmpjydd9yFH1ed009hBqn/NJszYk7sRDK9Rf4wFXCE+NaZTEXn
	Zq3IepV7gur2gHFMD7IPlb5rlc2CUMvsbyxI7fiRmlDREV9GyPbC3ea5AXowS
X-Received: by 2002:ac8:7e8c:0:b0:51c:7b13:62fa with SMTP id d75a77b69052e-51c8b438c0dmr129494461cf.80.1783706594020;
        Fri, 10 Jul 2026 11:03:14 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1fd2bsm47060696d6.27.2026.07.10.11.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:03:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiFZA-00000007fhc-13JV;
	Fri, 10 Jul 2026 15:03:12 -0300
Date: Fri, 10 Jul 2026 15:03:12 -0300
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
Subject: Re: [PATCH v7 2/8] mm/hmm: add hmm_range_fault_unlocked_timeout()
 for mmap lock-drop support
Message-ID: <20260710180312.GD1803712@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
 <20260710162749.GP118978@ziepe.ca>
 <20260710164743.GX118978@ziepe.ca>
 <alElv0EKjLQXMNK8@skinsburskii>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alElv0EKjLQXMNK8@skinsburskii>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skinsburskii@gmail.com,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23017-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C178573D2D7

On Fri, Jul 10, 2026 at 10:02:55AM -0700, Stanislav Kinsburskii wrote:
> The main customer for this new feature I have in mind is the MSHV driver
> which backs VMs memory with HMM, requires userfaultfd support for
> post-copy live migration and fast restore and it doesn't timeout.
> 
> I agree, that this current timeout value used by the other callers might
> not be enough to repopulate the mappings with userfaultfd, but there
> drivers would get -EFAULT for uderfaultfd-backed mappings without this
> change anyway, so getting -EBUSY with the change instead doesn't look
> like a significant change to the behaviour from my POV.

It sounds like it won't be reliable either then.

> > So, maybe the deadline should be resetting after every handled fault?
> > ie the timeout really is only about the mmu notifier and we don't
> > count the time spent handling faults or walking?
>
> The timeout was inherited from existing HMM users rather than introduced
> as a new HMM policy. Some GPU drivers use HMM_RANGE_DEFAULT_TIMEOUT as a
> budget for the whole range population operation, including HMM retries
> and subsequent driver mapping work.

Yes, because we always had a timeout around the notifier because that
scheme can sort of live lock. The timeout was to protect that only, ie
limit the number of notifier retries.

Expanding the timeout to be outside what is bounded by the notifier
retry is not right, and heavy stuff like mapping should be done after
the hmm side succeeds and the notifiers concluded so they can rely on
normal locking instead.

This is why I'm suggesting to reset the deadline as hmm makes forward
progress, we really only want to bound the notifier retry loop not
anything else.

Jason

