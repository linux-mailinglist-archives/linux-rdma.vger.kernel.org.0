Return-Path: <linux-rdma+bounces-23045-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n3tHBmG2UWpTHwMAu9opvQ
	(envelope-from <linux-rdma+bounces-23045-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 05:20:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A31D37402D0
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 05:20:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hktlFisp;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23045-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23045-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD1F730238E0
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 03:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B57C23BCEE;
	Sat, 11 Jul 2026 03:19:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06921A3166
	for <linux-rdma@vger.kernel.org>; Sat, 11 Jul 2026 03:19:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783739994; cv=none; b=s3qphWAKDxybpMie8MiQ4WbwueeV7NRPRp4Tf0XYZS5pxw13y06RDpX6a0ibHyk4w9KThZaNqlM0d7Qx08Wmz7FIo9uPx6HNaURwyhq1EAU9xgAYj9jjkJSj9rzpnxcpHdxULD65bbrhK5ZsEgceA/dNRN0LP5CMXM+4fg/Rsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783739994; c=relaxed/simple;
	bh=71lARMM3Jl3NDTlQGAGPMbgSLaP7ywZLy2GYTYoKFog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET2V/dHmexihTuAUBCBGgZY44qdqTZdKmaKHzG5+VJPtwXTmfWTcu5m904kICzx6MMK9hOAgwYKR7X5O/ukU1xSd7yr7ZEw/P/izDI6CCOb7P4McDmfLZDq2KDp46jrn60WrIaeQdqfLQyVQ/ZtRy1bcsuKkI9F853Jhj5xcBNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hktlFisp; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caea3f742bso16886765ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 20:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783739992; x=1784344792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CYTaMzfdKXyQ96IWRR1Bd78qVpBo65z/nucHslKEHMk=;
        b=hktlFispw0ReXJzK3IozV1fiAPHm0k4cHxos2ESjizWBwpRk1ilHYB2tUM36yXdal2
         kyQy3mO/55/PA3qVY7Dy7f+3SsgSoXzZh89BMiKIqHYVppaZsJCXXaPGmK9A2UtkWgWI
         Bvt642gB4jDf5qKAOHQwKDNU3jLqpoLsWxDH8/tjglYys0krxL+70yU98SIvqib43iX0
         mJpDvfusI/Yq2RE7Qa+OlYXtjwsXXCy6Y9K2oegdE5y43FJUzt3MKyLyRr3DQ1e1m3B8
         bzVrqIfyLc4p1Vff13B1EbA0nlkyyZ76GGNEarjltbHIZqFHwkTiGYZECad3gxHoIgdB
         BrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783739992; x=1784344792;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CYTaMzfdKXyQ96IWRR1Bd78qVpBo65z/nucHslKEHMk=;
        b=b3bA+dErjsR9chzjPmuP3L4cnNbjJ+efUTJqhnufRjIrXnaD8fOSNT1445WOlWLiOB
         vnzNeUeDXnJDNSKaTSP7muCFdYyD1HBMQpoIbo9HMv4h1XQ0IXbGleCcWZAvGZ+FFCPZ
         youSQ023FtMv0jWc8e2d55RPzR6xZ3ReJfyqQeHcnMi9ZfCLrXKamBvpby2Ic89SkT3E
         V6nrZmlCg/Dg6Bym8j/00dTRRgmcVkik+S/lAwixUOi6zLtLkA46sX9wOOPmsqf+ZC7s
         F1Q1q1+/MM85p+QilYOBUVAm/chb3xphUXzEeU969/6BcgEgG2Yzxv1eMDIeplsCzz0O
         AnhQ==
X-Forwarded-Encrypted: i=1; AHgh+RrM6T7hbk0eGfRD9u2iSykzdcghmu3uJypIEHaTLQGkBeELx1V7/8LEPOgVeeXeSPKhm0/CFAA8WmRF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1czaeo2C12ojclYnNfLyGqSVKnHYHnvUFuE3EdMrmjqwo73DR
	25xwCcnJ+RvFBJ7yDbf2ZHg5U6tYfX+uvqh0nT8JmUI3nbVKa3nGtcAP
X-Gm-Gg: AfdE7ck4JL4Z2xc+SSuL5O31Y3sc3eCm9ko+3agSYNjGoxsgAfQ2Xg2yOhKGICnJly3
	D6SGYASR4Gy1VOdzd2yY3Etb575AeY5BJWacaghTIu0SGvQnMxKb0rQwUOH26XXSbMEszpK+ESu
	HCAQ2FZTZ6lhuIC0NCVfx4EA39gQkNxLgYwuIXQv5U3y77TfbgtyE2de+epn8Y+oS3Fj4vPY+rC
	hk4sWzIlwbwQ+fzWX2SRNOZmcdR8KWp8Ba/WtgsQLoB6t9I4NpP3rjQIc2HROyM39WXhFCyAHrp
	pFyqLzkrCDKnm9taMZ9ij96A1CHSOZ2k8kniueI8Tj05ng4USezqb1dySo+bnhECK3LR86PzERE
	zkkXZQjylw0TqDA7ujCxHNGTsxulMpk0d+LOT8fsL3Rb7ntC/vE+zHYODcpye7vDLqXbtjpyqg8
	PfuXprbEgfn92Ozft6wfjErNTzTlgUZS1AGajaLNf0EB1gAvHuH5N0+Ag=
X-Received: by 2002:a17:902:d2ca:b0:2c9:97a8:8c1b with SMTP id d9443c01a7336-2ce9f2948camr16114365ad.46.1783739992132;
        Fri, 10 Jul 2026 20:19:52 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bdddsm67571165ad.77.2026.07.10.20.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 20:19:51 -0700 (PDT)
Date: Fri, 10 Jul 2026 20:19:42 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, corbet@lwn.net,
	dakr@kernel.org, david@kernel.org, decui@microsoft.com,
	haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org,
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
Subject: Re: [PATCH v8 7/8] accel/amdxdna: Use
 hmm_range_fault_unlocked_timeout() for range population
Message-ID: <alG2TldWdL8Ez8Dq@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371883276.900500.12789147320642521200.stgit@skinsburskii>
 <20260710151228.ca22e127b93ec5c6d591fb5f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710151228.ca22e127b93ec5c6d591fb5f@linux-foundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	TAGGED_FROM(0.00)[bounces-23045-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:jgg@ziepe.ca,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ee.iitb.ac.in,lwn.net,kernel.org,microsoft.com,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de,kvack.org,vger.kernel.org];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A31D37402D0

On Fri, Jul 10, 2026 at 03:12:28PM -0700, Andrew Morton wrote:
> On Fri, 10 Jul 2026 14:27:12 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > --- a/drivers/accel/amdxdna/aie2_ctx.c
> > +++ b/drivers/accel/amdxdna/aie2_ctx.c
> > @@ -1061,22 +1061,11 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
> >  		return -EFAULT;
> >  	}
> >  
> > -	mapp->range.notifier_seq = mmu_interval_read_begin(&mapp->notifier);
> > -	mmap_read_lock(mm);
> > -	ret = hmm_range_fault(&mapp->range);
> > -	mmap_read_unlock(mm);
> > +	ret = hmm_range_fault_unlocked_timeout(&mapp->range,
> > +			max_t(long, timeout - jiffies, 1));
> 
> max(timeout - jiffies, 1UL)?

"ma" for sure, thank you.
I have the same quesitong here: will "max(timeout - jiffies, 1UL)"
handle negative "timeout - jiffies" values correctly?

Thanks,
Stanislav

