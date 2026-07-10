Return-Path: <linux-rdma+bounces-23012-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yT6uDDInUWp8AAMAu9opvQ
	(envelope-from <linux-rdma+bounces-23012-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 19:09:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF7073CEC2
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 19:09:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=gAjYMLAi;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23012-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23012-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5EBD3060D16
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E5536F8F1;
	Fri, 10 Jul 2026 16:47:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B06F43E483
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 16:47:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702076; cv=none; b=NnHkiLi5lvAZURWQBFqSY2lYaS0U0dUkxDXEsdqMhDZWQ5jHJixnA8Gm5uSB/CNpc3UDl2jcc61UWZtqqrZsNmuYsBrVodCRJPTYl73H9Q3dwpZFQ5HfJarmfFKTRd40Hf4xpV0uO543nhyeixEeupNQztDtg7AHELX48gPbN7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702076; c=relaxed/simple;
	bh=5mY/LNzOoYWIQwJjGaIbGESQyPbUXU5+u9YysOMf/yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wul1Qw8TPrm6fIOAUOeRtdwyRiF5duVa3hgcnjJxo2CcpK7L2HPRb6uf3s8CLNtYCSkNpYtB5jrwiSYjO4iOXurL6ciG3RcGmaQid9X0M3m6mZkMuloR/kW0PZHKMQHw+t63YsWKpf6XCo7x19OAuke/yT9yPn0WP0MxwBSquJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gAjYMLAi; arc=none smtp.client-ip=209.85.222.175
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9204711e831so93971085a.2
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783702070; x=1784306870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ldYpDeT5zs3T98XMfsT8ni9uE73SXe2oYxwTATvCf1s=;
        b=gAjYMLAi6cspR6STclWeUWQf2vF2kBVUByPzsKQyEj96wDx+Rg+xnLW/UHVsBM0pFE
         ruFVkjP/ya5w6E/9K712aLLeXb6ZfoP2fRdjNSAXNuklF4LpWrFu6ql5F4sbWdYa1E03
         zgBjaM1dpk1/ZDMHFMP1AU1G26LjlYhDUPuOV0vmpjT+pVRG+ncYD9zFLCJJpJ16Xycs
         gpNtyILCuw6hn3ufC8MR44gT2gBA9BaGEIX83Swu7Fjyo4aFg1J5CDNsSRbgSLkDtgiB
         TXOze/8iiEv9/C6qGHU9a6SZ65R/talaoTpRrPIlE49lzVm1FcUwNpMmwVaVIUFjym9q
         Sf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783702070; x=1784306870;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ldYpDeT5zs3T98XMfsT8ni9uE73SXe2oYxwTATvCf1s=;
        b=rRRK/MV1UYWg1u7sC4yoE2oUA3SAppLSuNSdvyVCqP5N50qwUTlJmC1Hky5achEbZ3
         lw9w3piiRvj1kP49XfO1pGxIXhQxP7kWP9TftcImDuV6lCz6tAgNBTjoLiif+UR0LuFZ
         kW4bEO/IYpJf0hUDepDjQWdMkf2ybu8AS1iygFXPbtFpCAdCJSiUcP0WAeiisuAYu0xL
         8+6yZ2Kb0UVXstNJzwFpEcvPAnn87NwYiuFlk3zFceVnat+dBsfMFppD+bfbC26JG93I
         QurWC8lX56opV+L4I9XPFJUcqQ41URuIC4CANVTqNoSD4keaGLMBS+Im0hyeaxy3hwd7
         XfLw==
X-Forwarded-Encrypted: i=1; AHgh+Rqys80pUewyB//Xzf1AVY4uj5Bd+PG7pXtxwclLlIbZ2soUf2Znld0sXqqtS+3uBhDfrj2JjVkgWQ9b@vger.kernel.org
X-Gm-Message-State: AOJu0YyRf7RvmuZoUzPp1207/ut4N4E9KWMtdPXaR2oEkcHYUC0v/Yfn
	Cg/pt3W4BmppsDtIfoe/PRYOJG0F0GMuS5baTUKUBAgG4IxGfiyDAfWgt2LyxgYkJlo=
X-Gm-Gg: AfdE7cnJnd2G1X0vDqnr3fflc6w5gPENo/hRXSi8h9MNv/4RWw09AHEnUPQ3qdRYIhB
	/8BkSAfZCZMJwx703yjsvQEwfvG9CWEoLSYUZ54MXKqJbJv76xuo3v7DHrQA6r1FY+/9BhgfkfI
	LAvF4lp6beEHxBKCKQR2G3tVECslwYzoLPFc8l0Ck28lfhEJyocxId4XON8FkSLQMEhZMOlCoMF
	VdWw0Qyx8sWe7UKbeaX5bh91tGJVBOq8Epp0YYYLly+t9K6sc14dEJBzklagHHTvXv1dY9akKzy
	c8njuyZOJa+G1WwirPST/qWVtl0XhzPTMfBuXnkCoUlqFhc5fBnfUpK0fejuPIksJp1S7VBobBW
	HnK0+ZGYwe0il39dU39DQOZi7MnnVk27Pta6601yyeRuNIHFxTI/iAX+BHBDt
X-Received: by 2002:a05:620a:4044:b0:92a:3ceb:9cf1 with SMTP id af79cd13be357-92ecf68b839mr1385461685a.37.1783702065110;
        Fri, 10 Jul 2026 09:47:45 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd5bbac2asm45778726d6.21.2026.07.10.09.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:47:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiEO7-00000007ZDn-3hnt;
	Fri, 10 Jul 2026 13:47:43 -0300
Date: Fri, 10 Jul 2026 13:47:43 -0300
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
Message-ID: <20260710164743.GX118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
 <20260710162749.GP118978@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710162749.GP118978@ziepe.ca>
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
	TAGGED_FROM(0.00)[bounces-23012-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBF7073CEC2

On Fri, Jul 10, 2026 at 01:27:49PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 07, 2026 at 12:47:01PM -0700, Stanislav Kinsburskii wrote:
> 
> > +int hmm_range_fault_unlocked_timeout(struct hmm_range *range,
> > +				     unsigned long timeout)
> > +{
> > +	struct mm_struct *mm = range->notifier->mm;
> > +	unsigned long deadline = 0;
> > +	int locked, ret;
> > +
> > +	if (timeout)
> > +		deadline = jiffies + timeout;
> > +
> > +	do {
> > +		if (fatal_signal_pending(current))
> > +			return -EINTR;
> > +
> > +		if (timeout && time_after(jiffies, deadline))
> > +			return -EBUSY;
> 
> I really dislike there is a timeout here, HMM is supposed to be more
> deterministic. GUP doesn't have a timeout, what is this about?

It looks like you've moved the timeout processing related to the mmnu
notifier sequence from the callers into this helper. I'm fine with
that, but maybe add some comments that this timeout is helping
implement the mmu notifiers, and we do expect that the HMM part will
not timeout.

Though it is a little hard to see how your stated purpose of enabling
userfaultfd is going to work, aren't you pretty much guarenteed to hit
a timeout if the userfaultfd process is adversly scheduled? That's
going to end up broken.

So, maybe the deadline should be resetting after every handled fault?
ie the timeout really is only about the mmu notifier and we don't
count the time spent handling faults or walking?

Jason

