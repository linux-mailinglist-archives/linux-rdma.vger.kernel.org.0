Return-Path: <linux-rdma+bounces-23018-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jHIBKt81UWpeAwMAu9opvQ
	(envelope-from <linux-rdma+bounces-23018-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 20:11:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 983C473D41D
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 20:11:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=G+mmqZdc;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23018-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23018-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83DC5302DE0D
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 18:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1785A37C0F6;
	Fri, 10 Jul 2026 18:07:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D349E383C7B
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 18:07:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706858; cv=none; b=lfWQV1vSeV+kjrApv0qknojK7twrbSyePhT/CShgivNOK6fsRaxhalfFY6yQ+V8VsMdNgm0wi2j+BaFn06DCa2Fdshv6eujoTnp+k2sTWSC2UkJw9pEyhwpqmsZ8wKvDX0QM3QxzQXoSVrbGfLgBHkcftCbb9M+BMt64jZFZ6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706858; c=relaxed/simple;
	bh=O6OimzKD1xlS6Frl91Eg4/jvdk/NA4Un3exe+7jonxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qenJmDAk+LKRCPUKBdf+ssGvI7qfHtWbCvjjVWQNEzLt2gvUshJgqo0joCuQVQEn8eJ5IWnqVCDIEVKwBaS3dxvn9Z0Vm6yx0B/KhQ7FRWAFsLiPfYrs+BfwAfijXPsYjnKI2Dp0BNluEyIvJmu+wMliQbAm0lSYordSfiFOc4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+mmqZdc; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc6dd436c6so13124105ad.2
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783706847; x=1784311647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vK1yycrFvPnOHneU0oNi6DrjeWKqgXkTtqXMvxDGhZQ=;
        b=G+mmqZdcs0jO8PwuouqUz0af25DOsf8ysUuT6w/JdUZb+86uc/n1BimKSReR18OYbe
         9PkImlmJYekN/rctDqMv722YFQbGc2miKIz//KKcS18x756BAUG+70UV100zLJdYIdPe
         OS19SaJBHmrsHD0pqZdoubdYrky89nXRiGoTmYNmZCejXcRXuOtliw6+NG/7FtsTixdp
         gwRWecJb33MKp3I4QDqGw/46GM9u1GJnbpZ+Umbassa4Y0V+jH+xvonuYtWP4hCR7pOt
         2gU11ttWG8V0k/7ObjIPilGj4NEepzXluwL+HEfOqrzAKOp+iXkZIEXngdF/VkMaNtFM
         s5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783706847; x=1784311647;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vK1yycrFvPnOHneU0oNi6DrjeWKqgXkTtqXMvxDGhZQ=;
        b=KTuCn22ljCLSMYhc1axu5px2QiZKghsoHbdr95u0Ger4rb+YtReztpqTAMIy8LqNKO
         lfElDKBOd6BVObHx2PfiC/qxGYMct5VrkgQSh+QEUM+cKF5Sg5DEyEl7sqtR02BukBO1
         5gX+My+vEj+HA7f/oUwynEqQ4+plBbEHVzJOVmJ8cAzHPqOnVFoVzEk7vFSLNSu0UtwG
         9rG9mbbvn3/0CoPgafys+VQnT9bFAnljTRsKcar4dNThVQT4hLr7Mfdd7d3qaxDcQwpb
         3d2TVL4YAT6jo/WbBFQicLasHdROGHLl6Dw06DRwsTmB5eeR2sfalRfULAJlviplXLSc
         e5LA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8zJK9EbYPk+4eIjNkxNacv0tMKuHPW9ie6Nujue99+XX8wWMXTvoWy0xfpQuSIkUcsVQYut/+y3Kh@vger.kernel.org
X-Gm-Message-State: AOJu0YwNawC6tEcUCddmKbJx8hFq3VFLZjoAaiZmHbpi8wcEc7BO278P
	OxEJwrmu74qcqaA4bRCKCj9H+suDq53ZIK7symYhclHGu5jRyqH6AeYe
X-Gm-Gg: AfdE7cmfQ5YZsadvXlyjI9pUiqqcXzurIFi2Df1AQyJm2qS6JVCnSHLmvrWKo7aWd+7
	3ownXm9Qa0Id2M/rKmxt5U7m51an44EKBChICRUlCbgM+jmAa9abVbwtP5mbtrOIPi5ygrUGqoc
	0JJ8W+kGx5UIAv7FLVZ4VSzXJL9PfDVzwH6f8K6BxNcofjxZirBSQSS8c85BfXR5Twns/LEz1rL
	7gQaXh0mIlkEdzyCeiknjERIc5xDP3IreLc0/jhngJtX++sA36e5BZMmL1V4y6LrcGtX8UuMVBP
	cLLDoI9RnNHQn7EOPAJUN8fDP+Puf5wpemddbEa4YXptHUA30HKu4dnHLMD0oBApqt5+lpuwros
	d/rm3/FofHyCTTZeIARAGAHCjNO+DByysoM74AZOGuAhqZKI2DEXx3zocM/8s279++HZ0kpWrTj
	m8FzHhT/t0a8maTC6SkYXFGCQURLAtgr0S/qYUonwfvCYJ2LJ2rOXZMPw=
X-Received: by 2002:a17:903:2a88:b0:2c9:d8c6:1db8 with SMTP id d9443c01a7336-2ce9f284e45mr2337085ad.28.1783706847144;
        Fri, 10 Jul 2026 11:07:27 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf74cbsm63356135ad.18.2026.07.10.11.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:07:26 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:07:23 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <alE028DsCGeUwNh6@skinsburskii>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
 <20260710162749.GP118978@ziepe.ca>
 <20260710164743.GX118978@ziepe.ca>
 <alElv0EKjLQXMNK8@skinsburskii>
 <20260710180312.GD1803712@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710180312.GD1803712@ziepe.ca>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	TAGGED_FROM(0.00)[bounces-23018-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,microsoft.com,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de,kvack.org,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,skinsburskii:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 983C473D41D

On Fri, Jul 10, 2026 at 03:03:12PM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 10, 2026 at 10:02:55AM -0700, Stanislav Kinsburskii wrote:
> > The main customer for this new feature I have in mind is the MSHV driver
> > which backs VMs memory with HMM, requires userfaultfd support for
> > post-copy live migration and fast restore and it doesn't timeout.
> > 
> > I agree, that this current timeout value used by the other callers might
> > not be enough to repopulate the mappings with userfaultfd, but there
> > drivers would get -EFAULT for uderfaultfd-backed mappings without this
> > change anyway, so getting -EBUSY with the change instead doesn't look
> > like a significant change to the behaviour from my POV.
> 
> It sounds like it won't be reliable either then.
> 
> > > So, maybe the deadline should be resetting after every handled fault?
> > > ie the timeout really is only about the mmu notifier and we don't
> > > count the time spent handling faults or walking?
> >
> > The timeout was inherited from existing HMM users rather than introduced
> > as a new HMM policy. Some GPU drivers use HMM_RANGE_DEFAULT_TIMEOUT as a
> > budget for the whole range population operation, including HMM retries
> > and subsequent driver mapping work.
> 
> Yes, because we always had a timeout around the notifier because that
> scheme can sort of live lock. The timeout was to protect that only, ie
> limit the number of notifier retries.
> 
> Expanding the timeout to be outside what is bounded by the notifier
> retry is not right, and heavy stuff like mapping should be done after
> the hmm side succeeds and the notifiers concluded so they can rely on
> normal locking instead.
> 
> This is why I'm suggesting to reset the deadline as hmm makes forward
> progress, we really only want to bound the notifier retry loop not
> anything else.
> 

Sure, I'll modify accordingly.

Thanks,
Stanislav

> Jason

