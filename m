Return-Path: <linux-rdma+bounces-23151-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h4ZhKq8ZVWrPjwAAu9opvQ
	(envelope-from <linux-rdma+bounces-23151-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:00:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0637C74DD0A
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:00:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QrLHGCek;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23151-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23151-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41A94303EC2E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591B943E9F9;
	Mon, 13 Jul 2026 16:59:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D365240BCB4
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 16:59:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961962; cv=none; b=qTvgqDx3y/J6iNZXBhs5B5o0q6aDSeedLACZ9cmlptFskqc6hiviVD7ZcCoLF08vVIHwIo0RlJ9FmlpwbVOoHaq7F05m4HiDoU+8K+H8NtMYwaP2dZyj8/DsxzGCdHGy7krx0A/BZKTVefJyJoRb4EWacEUB56RLoacj4QGwZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961962; c=relaxed/simple;
	bh=tdE4RavGGrmiiYMEe1QYFWztBn/Ajoszor6SkuOHfPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8uBakGYCcz7Q4i0nH78xSX2Q0fIZ+vV1ciw0OC9t7PM7qMKlnh/K7OuJktp5fAk2Xcn2sPunhWHbj7RuKW42t0tTi3T7BYhWXlNwf8jlzMhXHZsoWRlIcMVvUfrxvgbvDX/Ws3SKTHqMQ9IXY/qHuc54ph6OLcMMbY6JwUqXVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrLHGCek; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so2204807a12.2
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783961960; x=1784566760; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ntUweueTN5fRqaQOoy5Hqmcgc1LaFPt81cAcvUtqRRA=;
        b=QrLHGCektwMCrdobJqd/JDuo2MJ1s2EnbZ7n9iZZ4UdRHa/tT+ZFQNgLrxdXQpvdiH
         xicxLf4Tgi8y+YgBpi3X1ckRBNUkN0Ul1NtPmQubC1MCTfoyugYSSuceG+40aPM0akzg
         0HpLw19rY+GVB0POlt/JtTGQF8gr2fwSK73XpRF4LkpyY2eclKz+BEecdz3eHeCRMPcR
         oCDTgT0LBVMzx4LC10dy2/u3Qa5L6VWsSxyCB9Mz/SB7az87x5tFKi6BLj4bfsGdGEzY
         u2OO4/twwIy8ijVe26w6/rVhdOcUB4ZSJPI5o0ii9RI3SdzbugBhv5Ecf7eOb+EKjT6i
         sv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961960; x=1784566760;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ntUweueTN5fRqaQOoy5Hqmcgc1LaFPt81cAcvUtqRRA=;
        b=JngLGmu28nTvsolD2sivRYVuzO3pY/SZu6WWTwq6CTG6DRi/y7KloVKjAXod/f/q4S
         CSb9cLGnEZu4RTVidzJgQxaYw3QAkgvkzilRPsniPTkaqulVYt24t8vw0GdS2n4VygYm
         LVxQydkVns9FKRo1PKKyjjn89qD8GPiqCAV3zy+M/0udWtNGXThM9LANe8NPQIvIq9kP
         CF0kH6KFlSIHMOQwq+nkx6iQCEPuQlzBlZpz/F0NhAnc2c4mBk8yZMmEbcT1yxptWdIM
         xleLcyvqgW08G9dzkIvxkk36bXF1Qtvmbn9ZEg5L+PtOGX2yXOXJ5bykQmMkmxNh2WOg
         /Osw==
X-Forwarded-Encrypted: i=1; AHgh+RqPuRYgl+geRXEYOtaXWBqD8YVwLPmhkB3QC17sUYnCPA61BmL4lhhk7dZjCBLK+ThlXKVi8anpStFQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtSHPd3CqpMoEws4Oxp9ETyThA60MZlYIuZoDSBXikmZjx+D/
	Fk6BnQ4wXK7DCbj6WRcMbYCrDfsxy7ADiCTwbuNLkRS8OHCDGJV0oYTQ
X-Gm-Gg: AfdE7cmMjIxctL4Ok4JmYRD6cinJlfi2esq+k+tsqhXK6li2nCemSgSeRTlaCOjNwzy
	pNhSJDMJnbFyqdD106jz/J52wJk5wMikVa3uXuyHijIRH06PXsUbLrT/aYoG2Y+Cq8e/x1/9R0G
	LB65ZEuKT0W822fMyoHbGpmfbDacUHKC4FO/nrXVPGicoXJwkeklfK8kE20rfF0UBwPlPAEgT/C
	0TNdcMy2/AJZudAszH8dYr40cBt/95BC1wqOyfB/TVsRqcUIiqYk9tVhazlRGlHpdWj1BUJiYfM
	HEFwLyhpu6nIjJK4LQ1bW9BgG+ncWtH7iLOKjaK/CWuZbUMBwUGyLF6ingEkKJ5z1Hxhl7DxIyc
	9dSCVjz59UdU2UxRP+mdtQZ90GP1v/C5VIgSCG92ImvpfoTqMnymfKTgVZbLmhlXmQcoI3py8K9
	N73mPAZ/iB06naygJcyOngEEXdWjU0AktnXuuyZyoeFt2GOxXF8FYwZJ4=
X-Received: by 2002:a05:6a20:c907:b0:3bf:a1e5:ff62 with SMTP id adf61e73a8af0-3c110cdb078mr12110955637.47.1783961960162;
        Mon, 13 Jul 2026 09:59:20 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5afbc1208sm8643053a12.9.2026.07.13.09.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:59:19 -0700 (PDT)
Date: Mon, 13 Jul 2026 09:59:17 -0700
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
Subject: Re: [PATCH v8 5/8] drm/nouveau: Use
 hmm_range_fault_unlocked_timeout() for SVM faults
Message-ID: <alUZZYIPY-UkhpY4@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371881847.900500.8789369230260725500.stgit@skinsburskii>
 <20260710151222.ddb35eab9c81a8720491464a@linux-foundation.org>
 <alG1k3JsoywE2CBM@skinsburskii>
 <20260710224833.9caf2a0a9906f0515e326a45@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710224833.9caf2a0a9906f0515e326a45@linux-foundation.org>
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
	TAGGED_FROM(0.00)[bounces-23151-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 0637C74DD0A

On Fri, Jul 10, 2026 at 10:48:33PM -0700, Andrew Morton wrote:
> On Fri, 10 Jul 2026 20:16:35 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > On Fri, Jul 10, 2026 at 03:12:22PM -0700, Andrew Morton wrote:
> > > On Fri, 10 Jul 2026 14:26:58 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> > > 
> > > > @@ -683,15 +683,11 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
> > > >  			goto out;
> > > >  		}
> > > >  
> > > > -		range.notifier_seq = mmu_interval_read_begin(range.notifier);
> > > > -		mmap_read_lock(mm);
> > > > -		ret = hmm_range_fault(&range);
> > > > -		mmap_read_unlock(mm);
> > > > -		if (ret) {
> > > > -			if (ret == -EBUSY)
> > > > -				continue;
> > > > +		ret = hmm_range_fault_unlocked_timeout(&range,
> > > > +						       max(timeout - jiffies,
> > > > +							   1L));
> > > 
> > > "1UL" here?  I'd have expected min() to warn, as it likes to do.
> > 
> > I'm not sure... The "timeout - jiffies" can become negative.
> > Won't 1UL convert both of them to "UL" and thus make the comparison
> > overflow?
> 
> `timeout' and `jiffies' are both unsigned long.

Yeah, I’m sorry for the sloppy wording.

What I meant was: will "max(timeout - jiffies, 1UL)" correctly handle
the case where jiffies < timeout?

Thanks,
Stanislav

