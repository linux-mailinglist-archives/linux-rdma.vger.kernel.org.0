Return-Path: <linux-rdma+bounces-23152-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7jJGHKkaVWr5jwAAu9opvQ
	(envelope-from <linux-rdma+bounces-23152-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:04:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C605F74DD87
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:04:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AkhOldmC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23152-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23152-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AD6E30E30D5
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6F4280018;
	Mon, 13 Jul 2026 17:01:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF9B27F017
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 17:01:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962088; cv=none; b=fqt8RUjfONHzU5SdnkR31nweYVM30sesWQQ5dXK6FamrJAg95jc8u+UgIxFR2rqhqUEvGagwNm+IUhrf+/UNpjSQ1bCREcb0Inzce3f2V3HfILdxTNDM0MlQlXsc4iklJVPbHUusvhz8MwztiX+oAvv7y4M4rG106UzNSkUuv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962088; c=relaxed/simple;
	bh=SqPTyIhNXXnGeYnJM9ztptY4dZp2tvlRUebzoP8AMpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNNz+qczczKgm0GL9VdrxZNckUT7hhtunFnvntPvE5N7PCLt2vGHSXiAMEWSw7UlZixn192YcjJL9vwtu3dmG/v8SMsgZv4YORrNgGn/sj35nWS6LhPvzYGnQ8Dae1tMJZxSxu9keUXqkeeIjo0ub+a25pi1DD05zcgMzTxNGwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkhOldmC; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ce9e39fccbso887925ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783962086; x=1784566886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R9LV+16tD32KS6yXCzCBkB0u2lL8SNr6pDg+a+HPC20=;
        b=AkhOldmCDDLl6AWrOAH2b4PKTeRjNceHNnP8hN2To4OzZo/dmzYg09EBRQ3/kR4/Xp
         TOYV6mNhKy2x/GMEqloSARoWonpxnlEzKaj/yZoJ0JzZlMyn8oyoGBQy5aUZrNHC+aui
         ReaybeVbyIieMUdbUBfF2G44VVLzOZ0gilHtNkFeGXG/KyCEvZHRZKbzyqUnDHP8O6d/
         Sfh0lzrb5T+VFSVQajjx2HY/kA5rh+DCPORYWO372r2nXBV9+rkzJTkxWBzfIasEeE5Z
         MZpSC10KcG8GTdXC0/Z39118LkAj5g0qDKa8anHxoLyqTYpCz1w+LNjoAFqNTrXFVUJz
         xrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783962086; x=1784566886;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9LV+16tD32KS6yXCzCBkB0u2lL8SNr6pDg+a+HPC20=;
        b=Z/gLzryn9VuCni1EJ21tgDjC7wgzg3qenYCiOWeYTny0JZpH9+uj+5WXpAwAuDdhoY
         rGQ63n3HCzqqgSqdDcRCRcgd8i8C8urZeaRHQkZfOaA3pFEeZBaMwy40vgrEsMmHcs+y
         pIM0+evp4he0yVa7npXGJixnfiYVCklPCqZ7pa5wSzniAA6apbwVUuSPmQbvWUAzcvrp
         VP+d0pbItL5KTxSkg7KpuO2uV44jsdPYXbTdys1wYvJL1heuWDdIBtI7VzzoAezcQfme
         HTpa5ivT+zJF+LPtLFvFDI1XR/uIRb1VKrFGTXsK1UeknSKlLWqHyUgd63pc/1s8AiwH
         Zbzg==
X-Forwarded-Encrypted: i=1; AHgh+Rr7cKcNvxp79OsUMetCbJX2+xMNxvnyGGEKh3SJuOwAFOtNvp7jQlqDX0JHIYXPRRGBRGLgVi38mAoj@vger.kernel.org
X-Gm-Message-State: AOJu0YygFWN5IPTtNPDJ9ttpwsMdYtoGbyIYeIsfEeKvvIfpXE7+vb53
	xhZEBW2IWIXuwNPEABsaUdQzSAcSEwTTY7phRVci50QKOEiGL2FCbPzY
X-Gm-Gg: AfdE7ckAI8eqroywe7+OecXXVSW8YxB97OhvHK+lmcTfwqBhXYoYSwZjLFH4axxZNPd
	Zv+uL23yYI68YWytX/3EjTWxEMFK+6bxX/llbAIvyrucbRHCun2z7bZ9WtXXJQfB51XsiqjuG3C
	IZHJ99XqknTp85SKD/l/27K9EpjTFBjh44nbrCRpipBWN79ThcaH/1YNUghA7SEDQ2FZuMZT2M+
	16u237rA1j+kRGNLUW6RfOtXLYuO661wHbXt6dyFdwDn41RbeLjJ4Z1gPFokbQhc9lj7+oE+P3c
	/DGzfvSXCrcK1QmkFFUWKA6smQe3s3M9nB8OGrHSq7jE1azJIHwNLSoJlh+mN8iILT0UDjwtXLs
	RJluzSC9cfu1/cFu0/n4c3v1HKkIrnvA47zwSgTrF4Pd3Nw0VE98f1dTC6JfVVbWXhHeXrje/+U
	XYRD7F/rrm8fBuClQhiaq+upj4iq4goYuxStyb3yAMktRi+mVDkZ3GNV4=
X-Received: by 2002:a17:902:e88a:b0:2ca:de3:15d7 with SMTP id d9443c01a7336-2ce8292bad0mr123460335ad.16.1783962085860;
        Mon, 13 Jul 2026 10:01:25 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm102224465ad.65.2026.07.13.10.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:01:22 -0700 (PDT)
Date: Mon, 13 Jul 2026 10:01:20 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
	corbet@lwn.net, dakr@kernel.org, david@kernel.org,
	decui@microsoft.com, haiyangz@microsoft.com, jgg@ziepe.ca,
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
Subject: Re: [PATCH v8 8/8] drm/gpusvm: Use
 hmm_range_fault_unlocked_timeout() for range faults
Message-ID: <alUZ4NQptiD9fRfz@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371883977.900500.2198446134676328631.stgit@skinsburskii>
 <alUSq0o7CC2Pnr+H@gsse-cloud1.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alUSq0o7CC2Pnr+H@gsse-cloud1.jf.intel.com>
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
	RCPT_COUNT_TWELVE(0.00)[40];
	TAGGED_FROM(0.00)[bounces-23152-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:matthew.brost@intel.com,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:jgg@ziepe.ca,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,microsoft.com,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de,kvack.org,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.freedesktop.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,skinsburskii:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C605F74DD87

On Mon, Jul 13, 2026 at 09:30:35AM -0700, Matthew Brost wrote:
> On Fri, Jul 10, 2026 at 02:27:19PM -0700, Stanislav Kinsburskii wrote:
> 
> Please send series like this to intel-xe@lists.freedesktop.org list too
> as this will trigger our CI which expercises the change paths changed in
> this series.
> 
> > Several GPU SVM paths take mmap_read_lock() only to call hmm_range_fault(),
> > then retry -EBUSY until HMM_RANGE_DEFAULT_TIMEOUT expires. Those paths use
> > MMU interval notifiers whose mm matches the mm that was locked for the HMM
> > fault.
> > 
> > Use hmm_range_fault_unlocked_timeout() for those faults and pass the
> > remaining retry budget to HMM. The helper owns mmap_lock acquisition and
> > refreshes range->notifier_seq internally for each retry, while GPU SVM
> > keeps its existing driver-lock validation with mmu_interval_read_retry()
> > after a successful fault.
> > 
> > Leave drm_gpusvm_check_pages() on hmm_range_fault() because that path is
> > called with the mmap lock already held by its caller.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/gpu/drm/drm_gpusvm.c |   52 ++++++------------------------------------
> >  1 file changed, 7 insertions(+), 45 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> > index 958cb605aedd..6b7a6eaebcd9 100644
> > --- a/drivers/gpu/drm/drm_gpusvm.c
> > +++ b/drivers/gpu/drm/drm_gpusvm.c
> > @@ -788,22 +788,8 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
> >  	hmm_range.hmm_pfns = pfns;
> >  
> >  retry:
> > -	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
> > -	mmap_read_lock(range->gpusvm->mm);
> > -
> > -	while (true) {
> > -		err = hmm_range_fault(&hmm_range);
> > -		if (err == -EBUSY) {
> > -			if (time_after(jiffies, timeout))
> > -				break;
> > -
> > -			hmm_range.notifier_seq =
> > -				mmu_interval_read_begin(notifier);
> > -			continue;
> > -		}
> > -		break;
> > -	}
> > -	mmap_read_unlock(range->gpusvm->mm);
> > +	err = hmm_range_fault_unlocked_timeout(&hmm_range,
> > +					       max(timeout - jiffies, 1L));
> >  	if (err)
> >  		goto err_free;
> >  
> > @@ -1439,21 +1425,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
> >  	}
> >  
> >  	hmm_range.hmm_pfns = pfns;
> > -	while (true) {
> > -		mmap_read_lock(mm);
> > -		err = hmm_range_fault(&hmm_range);
> > -		mmap_read_unlock(mm);
> > -
> > -		if (err == -EBUSY) {
> > -			if (time_after(jiffies, timeout))
> > -				break;
> > -
> > -			hmm_range.notifier_seq =
> > -				mmu_interval_read_begin(notifier);
> > -			continue;
> > -		}
> > -		break;
> > -	}
> > +	err = hmm_range_fault_unlocked_timeout(&hmm_range,
> > +				max_t(long, timeout - jiffies, 1));
> 
> Unaligned indentation.
> 
> So I'd write this like this to avoid weird wraps:
> 
> ctimeout = max_t(long, timeout - jiffies, 1));
> err = hmm_range_fault_unlocked_timeout(&hmm_range, ctimeout);
> 
> >  	mmput(mm);
> >  	if (err)
> >  		goto err_free;
> > @@ -1736,24 +1709,13 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
> >  		return -ENOMEM;
> >  
> >  	hmm_range.hmm_pfns = pfns;
> > -	while (!time_after(jiffies, timeout)) {
> > -		hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
> > -		if (time_after(jiffies, timeout)) {
> > -			err = -ETIME;
> > -			break;
> > -		}
> > -
> > -		mmap_read_lock(mm);
> > -		err = hmm_range_fault(&hmm_range);
> > -		mmap_read_unlock(mm);
> > -		if (err != -EBUSY)
> > -			break;
> > -	}
> > +	err = hmm_range_fault_unlocked_timeout(&hmm_range,
> > +				max_t(long, timeout - jiffies, 1));
> >  
> 
> Same here.
> 
> Nits, aside LGTM.
> 

Will change as requested and send to intel-xe@lists.freedesktop.org next time.

Thanks,
Stanislav

> Matt
> 
> >  	kvfree(pfns);
> >  	mmput(mm);
> >  
> > -	return err;
> > +	return err == -EBUSY ? -ETIME : err;
> >  }
> >  EXPORT_SYMBOL_GPL(drm_gpusvm_range_evict);
> >  
> > 
> > 

