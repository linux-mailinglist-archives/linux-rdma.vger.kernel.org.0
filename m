Return-Path: <linux-rdma+bounces-23042-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0edoGeqzUWpQHgMAu9opvQ
	(envelope-from <linux-rdma+bounces-23042-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 05:09:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D23740244
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 05:09:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=D3qaXtGK;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23042-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23042-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 590E2301B58E
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 03:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302CA2EC08C;
	Sat, 11 Jul 2026 03:09:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812E2E1746
	for <linux-rdma@vger.kernel.org>; Sat, 11 Jul 2026 03:09:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783739364; cv=none; b=gkUj1/wLDaC3ev0URbmUMEolNBYYTKVlM2tKzIEx3HYN0tgt2IVuIqwteEqkewYAHBmDp7RTZbEFAYzdLLFggkqsKPUC/vyFF8ANKnKns89nBl0DATJXPodYWxhMc6GP0N+qLU6gTQv1pULGL5W+ovDT5ERlDxLzps9BuXJ58P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783739364; c=relaxed/simple;
	bh=Talh9NFQCx452XKRUTeh7mUAoB/ijgfuASG+mTSXc/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYsSSdz5xlVPN78NlOVasOqqkz0tRA9wpMEEhRqNHftz7Iji/DHPgEpMDL+brcx/hoNQxPL/IW0jc/ptIWu4OTNee5jfpREpUYp/OFFCsfH8e6+VJXbI8BgiRi7ly39zBYrC4dil9irwYnrPqWmcpaB0nHQhRDNvXRv6P2bblms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3qaXtGK; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso957893a12.0
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 20:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783739362; x=1784344162; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KBT/pxhbpviyB1eK4ppjTwsrTkYiVk3Lhi/aEEh6q5s=;
        b=D3qaXtGKb2Xf/9+wr2HRFKL8jmCpHoxmOjnzBKRHFG4bHHCEScpCbA5LpnhM2eS11X
         nG9M0kPvxBXep+/0ZCyYpRgX9l/ZOilK8nOM71Vgq6QSmbYjtBkKLSTeFdNymLrs/NtM
         lHJqYdTRaEwaAkny4yNm2SHBIWlKx0LsU1YAI8HL2f/iW6YlZOXXXaHQBlQD9xfTOEEf
         qaGDiV+BqsVGAnDAlYreU+5w03vSy3s7iByMkQO+PHscZvMeT1dJQUSue75LORCHtvZb
         OMKMnwjruN3UimS/yQ0MnbqQtL/WsXfSgGLdVFnix7IQ8JsllW63eDEk3VrejGY7F/03
         vdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783739362; x=1784344162;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KBT/pxhbpviyB1eK4ppjTwsrTkYiVk3Lhi/aEEh6q5s=;
        b=m6464DD0rxcPdpZEwy5vpOxMIX+73+eaCFF9ZQQgSynzUz977/sEh+4a6MaMGOC/UI
         E2TUGHTzNP5m7aWyL/0BnWgw0hQxtj8LGvOeDGqd3yPCFWQMBgr6SMoBVHtlsQsAfGIP
         QgjQY7ihvpP/67NYw8U5ziW8AA3DhcJYg8ZGZiskEdcQrSTV3Oq/r/j1yUxnTlEP57d1
         42TcZQEHzLAiHsW2idBjz5WjCZxNWNP7Wnz/EfbI3fP/Lt0whze/8AohKZtNM4F6zizU
         HvzVVFr6pQ7N2j/Dcw7noEpXa5cWhVuOfR+W7Er4wHF1ZO5sn6JiimmGTLdu03mqc9cY
         nbMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqr66+bhYN3prX9ppKe39GTd1+lHQrR0ukyyRI6HrN19IQfI0doiTWIcUVd3JLvzg7Y7i6WcTydGq2x@vger.kernel.org
X-Gm-Message-State: AOJu0YybNzm/K+X/PR3vVwqRW7S6vNUnpS1HoDvxnvEhgoBdIpRxwzBJ
	1Vn68YqKmdSch8Lc9bkwXLz4btKzYfEUapV6NHCyjv5US66rmJvjXYzm
X-Gm-Gg: AfdE7cm5DovGcOwjaA/V0fYKoPuQGfDmLdFNy7r9ttk7OVTF9buf0xsPGPNONwJ8JXN
	g7dGUKUaUldU9WusNeuYacnJ5tgoDDeXuYrJhwNyMKrNj+4wkeKXppQyq77KfXw7W5wQZh9PN/l
	+SNSNxdowx1fraX7QXqZEayguSStcU2sQ98S5G6JEmG58NvoaUvyDQONAcjmXmYtWvXN2THOpzy
	w67iq6SszbOaAj3CgQQmnoSdamFZuQ743XnTWPyTwi/YVadsgKiDnd9KaV6FV6IxrHdnWI8DFEK
	j5p9pRKq7f01auCDBElYd7jmWAqjnR/DjGEfXjo49oPcftLaWY+jBZn5gIYSi6dcnHz6Y0xv0D1
	z4fVAgg5tb1rxsv+xw3nUbi0zcPwha/r6PAfEMZuh+8oAVAODWZG/VZY366kc8spNZc+FEUTgEZ
	LVnfYdmhwYPdJ3a2v9i9EAq2DwLzPRP/a5PgmLH/p6YvyOw7Lnd8LLa08=
X-Received: by 2002:a05:6a00:3404:b0:847:9151:3409 with SMTP id d2e1a72fcca58-84889797ad5mr1318139b3a.55.1783739362452;
        Fri, 10 Jul 2026 20:09:22 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm11140358b3a.53.2026.07.10.20.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 20:09:21 -0700 (PDT)
Date: Fri, 10 Jul 2026 20:09:18 -0700
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
Subject: Re: [PATCH v8 2/8] mm/hmm: add hmm_range_fault_unlocked_timeout()
 for mmap lock-drop support
Message-ID: <alGz3vywc6W5hvso@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371879503.900500.7148019929226548795.stgit@skinsburskii>
 <20260710151209.157d7c80b03dc56d73b5884a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710151209.157d7c80b03dc56d73b5884a@linux-foundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	TAGGED_FROM(0.00)[bounces-23042-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03D23740244

On Fri, Jul 10, 2026 at 03:12:09PM -0700, Andrew Morton wrote:
> On Fri, 10 Jul 2026 14:26:35 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > hmm_range_fault() requires the caller to hold the mmap read lock for the
> > duration of the call. This is incompatible with mappings whose fault
> > handler may release the mmap lock, notably userfaultfd-managed regions,
> > where handle_mm_fault() can return VM_FAULT_RETRY or VM_FAULT_COMPLETED
> > after dropping the lock. Drivers that need to populate device page tables
> > for such mappings have no way to do so today.
> > 
> > Add hmm_range_fault_unlocked_timeout() for callers that do not need to hold
> > mmap_lock across any work outside the HMM fault itself. The helper takes
> > mmap_read_lock_killable() internally, calls the common HMM fault
> > implementation, and releases the lock before returning if it is still held.
> > The timeout is specified in jiffies; passing 0 retries indefinitely, while
> > a non-zero timeout makes the helper return -EBUSY when the retry budget
> > expires.
> > 
> > When handle_mm_fault() drops mmap_lock, or when the range is invalidated,
> > hmm_range_fault_unlocked_timeout() refreshes range->notifier_seq and
> > retries the walk internally. If the lock was dropped, the retry deadline is
> > also restarted because a lock-dropping fault handler made progress.
> > Ordinary -EBUSY retries keep the existing deadline, preserving the caller's
> > timeout policy for repeated mmu-notifier invalidations.
> > 
> > The caller only needs to perform the usual post-success
> > mmu_interval_read_retry() check while holding its update lock before
> > consuming the pfns. If mmap_lock acquisition is interrupted or a fatal
> > signal is pending during retry handling, -EINTR is returned instead.
> > 
> > The common implementation conditionally sets FAULT_FLAG_ALLOW_RETRY and
> > FAULT_FLAG_KILLABLE only for hmm_range_fault_unlocked_timeout(). The
> > existing hmm_range_fault() path still passes no locked state, does not
> > allow handle_mm_fault() to drop mmap_lock, and remains a thin wrapper
> > preserving the existing API contract for current callers.
> > 
> > The previous refactor that moved page fault handling out of the page-table
> > walk callbacks is what makes this change small. Faults now run after
> > walk_page_range() has unwound, with only mmap_lock held, so dropping it
> > does not interact with the walker's pte spinlock or hugetlb_vma_lock.
> > Hugetlb regions therefore participate in the unlocked path uniformly with
> > PTE- and PMD-level mappings; no special case is required.
> > 
> > Documentation/mm/hmm.rst is updated with a description of the new API and
> > the recommended caller pattern.
> > 
> > ...
> >
> 
> A trivial thing:
> 
> > +int hmm_range_fault_unlocked_timeout(struct hmm_range *range,
> > +				     unsigned long timeout)
> > +{
> > +	struct mm_struct *mm = range->notifier->mm;
> > +	unsigned long deadline = 0;
> > +	bool locked = false;
> 
> This could be local to the do loop and it needn't be initialized.
> 

Unfortunately, it can’t, because its state is mutated in
hmm_range_fault_locked() and the resulting state needs to be preserved
across iterations of the loop as deadline reset depends on it.

Thanks,
Stanislav

> > +	int ret;
> > +
> > +	do {
> > +		if (fatal_signal_pending(current))
> > +			return -EINTR;
> > +
> > +		if (timeout) {
> > +			/*
> > +			 * If the previous fault dropped mmap_lock, then the fault
> > +			 * handler made progress. Restart the retry timeout in that
> > +			 * case, but keep the existing deadline for ordinary -EBUSY
> > +			 * retries.
> > +			 */
> > +			if (!locked)
> > +				deadline = jiffies + timeout;
> > +
> > +			if (time_after(jiffies, deadline))
> > +				return -EBUSY;
> > +		}
> > +
> > +		range->notifier_seq =
> > +			mmu_interval_read_begin(range->notifier);
> > +
> > +		ret = mmap_read_lock_killable(mm);
> > +		if (ret)
> > +			return ret;
> > +
> > +		locked = true;
> > +		ret = hmm_range_fault_locked(range, &locked);
> > +		if (locked)
> > +			mmap_read_unlock(mm);
> > +	} while (ret == -EBUSY);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(hmm_range_fault_unlocked_timeout);
> > +
> 

