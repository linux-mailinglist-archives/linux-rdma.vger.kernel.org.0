Return-Path: <linux-rdma+bounces-23135-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qeUDAbD9VGoRigAAu9opvQ
	(envelope-from <linux-rdma+bounces-23135-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:01:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E551574CB6B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:01:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=iXXu18NO;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23135-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23135-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44AF0310B60B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 14:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09223437452;
	Mon, 13 Jul 2026 14:55:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B8B43803A
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 14:55:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954507; cv=none; b=kUznrRyad006toL0ErNlH5GXuvOx/7fscTT3qCYOvmvTvnju7uWg/ZXE4hgfUhbu4gQPG3JumwMBEmc61dnj4OzGrNcVOX5Ck2pufv64wRb2KEFNI2vlIHQSKtgYI3vHjH84ff8Fc9I2jmsFl5fbmpKvvH9HgLqnO1Vnv4bPrfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954507; c=relaxed/simple;
	bh=GEh+g1NiW3mR99aSYCyQ33wt1J/GHPQy/vLk28L6OPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnK65rEOL9FGmUMlkCesVi1B1XJxWz7PXoLfBmcWNVHEN6Jv2x61HaOE72sYA9xHo/2zjJSnpXI7WgTA/McUbhtAysdgU4r9MCIyq/XJSQje5Ep9uh/BqVp9I38Htr8BVcanNeRqBqx9eClj7QvtpVOkjeDamMiU/z5QZqdYIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iXXu18NO; arc=none smtp.client-ip=209.85.160.179
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0c45c580so26154731cf.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783954505; x=1784559305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IZhqR4JgKFkSLvdz8vThCe3gL1K7igiBUDMCwA8QSjs=;
        b=iXXu18NOzE/K64fJi0fS7XlUycQSsVxXqPVr+DHylcaFLj1ZBGlqbiKaNjYo6pMNIm
         fSiRCUq6RCQAbt++t9n05E9YILRvIwfGpADmIjWHjg4w9C8rhQ2bV4ZbFCsGOJc2Gi9h
         q0ipGuVIBlXhdX5gvz/3Y3NfqBQ95zhUsKtWVIxTviWCAqHMhe+FlLmMacP5a1uSsAxy
         XCa5CdP+NztGm+lo2TBbweNAKDuzXp3OW20FggC18NySuIIp9GsP7Fts37KEB8YucUz/
         RTJmsqpTBastICdMJa+TDHNa8B0sYSLIawq1pS+VlCcHU8CgR0mFrSEaR9qVNe95TjcZ
         BA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783954505; x=1784559305;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IZhqR4JgKFkSLvdz8vThCe3gL1K7igiBUDMCwA8QSjs=;
        b=cbZwv2idKbY6sXRIJ3uGETHb7epAua0st2TD9E6NXTasSIJ/H0vQXzAtdSSkICCjpU
         7lLiC/mZ0ENQgM0SVgkAB/KmxCsgrd1bLSiONcVeGUQRt2WgWPHQLv5eUgU6Sk9BZO8g
         /AhsnAergHAepeE8jgXY7EuzUt4P3OyWdJX/t0HttHDxGEcCOxICQwTNN5lR8risZ2dA
         Dnj2kR5em3is6lvN2qDYCNgJ+fv+AkPRhkYm6ILwtvn21tPWkeo4aMWVv04sKyNtZF9W
         QugZufSuF3XNeXQp1pJbWwUXM+PyhkIblHA1HYJKepqYsQomsovNAUsgh1NMI50tG754
         sQMg==
X-Forwarded-Encrypted: i=1; AHgh+RpP6jImb//mwRu4exkwVEbeZY0K3WOyN4W6OxUf6FoDGecNRvUN9CTeGlqUeHuTpd6pwb/jNPLe+l56@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Kvm9CMm7K3tZAFV2dVmzWzZy1GlVhG+h65x+1FkNQTx7JehF
	oCUv+wafp9t4YvpwIiQQb6nBEeNhpnRxCmWpfxgjxEzDGYRoiOr2MorCpb2Oz6w2be0=
X-Gm-Gg: AfdE7ck9qFyWygGEeSHS6/MqSDI/xvyJ/9nTT6NIIcfa0j46K5lbonByWJktFyKt9+c
	6C02L3JYfOuLOk8jB2lZBefPlrPKIXyPMeBfvZ7wEIKi4wH2Nf7cnc1pbNoLpjadEA2sMfKADFR
	AsFG6m9ARJUyFWdUKyh95+OtKUFz2lAa2Xp2eAtK9U2Lg4rSLxwbWmLlJ7PzcXSLbDHH2nXbA65
	51khMZBIcWD3fByew7bgoc0mAJv1ti3TbuOVYH0EBFjEEkL75aaqmhc6CEb39XUPEaJL1eqcYva
	NaFBsVUu5rAZ9OKit3yylr5mzJ+bYj4YvEAyaOE1NBXAXsOTt7OuegLIn1YcknwUYzVf6efot1m
	dXKFBC36cS+bh09ChgRLQeotoFxi1/8gXEH35g3sw7O6jqWMJQNpqnRCFc6NxT3dmDamIG+4=
X-Received: by 2002:a05:622a:1911:b0:51c:504:2ef7 with SMTP id d75a77b69052e-51cbf305510mr90471451cf.67.1783954504822;
        Mon, 13 Jul 2026 07:55:04 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6d574sm84876451cf.3.2026.07.13.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:55:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjI3j-0000000DQQj-2xH1;
	Mon, 13 Jul 2026 11:55:03 -0300
Date: Mon, 13 Jul 2026 11:55:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stanislav Kinsburskii <skinsburskii@gmail.com>, airlied@gmail.com,
	akhilesh@ee.iitb.ac.in, corbet@lwn.net, dakr@kernel.org,
	david@kernel.org, decui@microsoft.com, haiyangz@microsoft.com,
	kees@kernel.org, kys@microsoft.com, leon@kernel.org,
	liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
	longli@microsoft.com, lyude@redhat.com,
	maarten.lankhorst@linux.intel.com, mamin506@gmail.com,
	mhocko@suse.com, mripard@kernel.org, nouveau@lists.freedesktop.org,
	ogabbay@kernel.org, oleg@redhat.com, rppt@kernel.org,
	shuah@kernel.org, simona@ffwll.ch, skhan@linuxfoundation.org,
	surenb@google.com, tzimmermann@suse.de, vbabka@kernel.org,
	wei.liu@kernel.org, dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 4/8] mshv: Use hmm_range_fault_unlocked_timeout() for
 region faults
Message-ID: <20260713145503.GC3133966@ziepe.ca>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371881034.900500.5214601525971121683.stgit@skinsburskii>
 <20260710151216.0397a6f9ac5c7b4ccd274cc1@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710151216.0397a6f9ac5c7b4ccd274cc1@linux-foundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23135-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:skinsburskii@gmail.com,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[gmail.com,ee.iitb.ac.in,lwn.net,kernel.org,microsoft.com,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E551574CB6B

On Fri, Jul 10, 2026 at 03:12:16PM -0700, Andrew Morton wrote:
> > +	mutex_lock(&region->mreg_mutex);
> > +
> > +	if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
> > +		mutex_unlock(&region->mreg_mutex);
> > +		cond_resched();
> > +		goto again;
> > +	}
> > +
> 
> If the calling process has realtime scheduling policy and either a)
> we're uniprocessor or b) this process and the holder of
> interval_sub->invalidate_seq are both pinned to the same CPU then
> cond_resched() won't do anything, and this might be an infinite loop?

I think hmm and kvm have had this issue for a long time? I don't see
anything in the mmu notifier locking scheme that would alleviate it at
least

So.. In terms of this series I'd leave it, it is no worse than before?

Jason

