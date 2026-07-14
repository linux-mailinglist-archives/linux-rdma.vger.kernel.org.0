Return-Path: <linux-rdma+bounces-23233-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UYb6AYW2VmrSAQEAu9opvQ
	(envelope-from <linux-rdma+bounces-23233-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 00:21:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE877592E0
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 00:21:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pcNipKXv;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23233-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23233-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 791FB302F59F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 22:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA48E42BC54;
	Tue, 14 Jul 2026 22:21:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516202931FE
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 22:21:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784067685; cv=none; b=lqfcjvCN4oC30Rx1oF+EnZzj9ZOSrkV4/ttX7farzTurrbUC9caYCyFErMsSzxT8GaOMhslM4Ir9G6ef5vYCy5OmvNzBvXo82UB3RldkjdUV88741d5lfMlSD2Cyt5A7Vglq1c1xt2Dt+d2NwePCZwxvlGaFpFatnkE6VkadSOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784067685; c=relaxed/simple;
	bh=baqF8AmnWKjBCJqEowFp8BuHg9T8XAks+xfH5wKSIy8=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=dR/7EVz2zKNI0WJeURyFpkdT/Ex7vJSpOvag/t1qiGid2jYhA1pgrBMPYFDiAYXaua2SHSdBplb5vnBFPrOL8SBq/N8vQkmten35Zvi9OIS/Stxn6RWonxcLQwu+XEUhfkUwREnnDSpxUD4GNhFpkpceWxzR0/34AUnvhhUBPHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pcNipKXv; arc=none smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848593533cbso2588928b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 15:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784067684; x=1784672484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vv0t/+7auxcbtGWpvakmJ0ritrqSQFOQmC0jKQCZU2I=;
        b=pcNipKXvX6w9m52Uie0ZbWhEqv7c2yWACBgxCRWNfzqvz9nfaVeNbcMDzMXhFb/mo8
         viXdEgN7YCmj4B+PlsqAPXPgL6c9hwqu19stFCd2QQX2oBCBCv1wVje+kLzzmT7QTHqS
         slNnVlFlUvvZdM4G9AaTgreOJTZJqI9pBz38oi7E5y/OC20YA30IcmDfnovmrqyW6dzf
         bdBvcO0WbU5k7YADa3EMRNUS9YHCXLSea6oMzVM7GSwKzURIX2P5EAQ5om9Gb1hcyYVU
         b+rnqY9B9iFiUeTwLiAtdbSva3mQScSJME3RjDSuLErWJ6/XSepBC7O/qO5WgTydfpVj
         TMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784067684; x=1784672484;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vv0t/+7auxcbtGWpvakmJ0ritrqSQFOQmC0jKQCZU2I=;
        b=gnOS5xTMovvzKnITSeMJ9LgR833lbspEeVn2Xs+2oxQZPhiWetnLj3WqnRCuDyZu+I
         aI4gq0F2aqZvl2h9w6HHIG7kHiblq4RVH1hWZqx4JsV7v3geA09N2mkszShVOgtxPGQ0
         574as/uTVGC9PC8t9DqOKtego/+ln+z1MlzzZvG/ivfv6gRHspmCEDtcGJldBSet+LDO
         rEVhkGwLACLdNPEXyWgqktdZHJrzDILtpR35PmhgrGv0d98Eov3xD/4Dc1ysFnHXP9uR
         W23oTzlu+9ghxUeLkRsH7xAeniP/Nay02WEEvtCY10/kwyLGmTloSGSR4LpZQHpbbxl3
         Mq7w==
X-Forwarded-Encrypted: i=1; AHgh+RqASvWg/Z00pDUWLmf7ZPhnJ9swBDJnl6PtwXl9x7hnEr3JvRYuN2lNFr4bYJdVSVXUG2viYcc8662Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxvgAuHVVm9Re7+6PPNAArqydKuo6oeStn6fd0rsph3xBdONCye
	HQsWEdDRZZLl95WnhwCES+iiCX5TD5i5pakomHc6La2b7uoDrx5WZmtu4rb5U3kc
X-Gm-Gg: AfdE7cmD3mmYvZIn80G5e9P/KJwF+4ZahWWEnqh+3cAdH/tCoONt2CStH3lVidWtqGf
	OBTlKsOeHG5g5vBGWAVVh16EYaU+aZzNCcEdk0A09OWGzXT2vv1GX5ifEc0FlkhiiUVz9g6L1Qo
	MU9hwZxDK/wdR8Inqt//75/cY9TRA78ZRjb+5NpBTNNozcFiSSOFC+ZMFMKUo1Z+oKKTbt1kkZU
	XitkXD/O0Do4nZuZb2vb1rp4moHUrly/S48DbszY1OCdRf1iaAiOquYjA8JhXLzkN3ubE7yqzWd
	PQlA14c+SHNdvzRB6iYlksQycT9jKZ0neHA3EJURkxRKRRcs2lblimu04Hoq7ifo+f0x60T6uNp
	10CDBqU08UEYHY3Ao8uyXuOVN1nyW/vYb9DIGw4usYnelKsMnR6Do/rLWWLdVssBEyN9cmnpsyi
	vNvQWla3PGewlHHsQUkPF/7cDbFZAUXSTsaAceOgXG3n0FOkLq7Ckien8bUFc=
X-Received: by 2002:a05:6a00:b4c:b0:848:6895:b763 with SMTP id d2e1a72fcca58-84a6735881cmr262012b3a.40.1784067683556;
        Tue, 14 Jul 2026 15:21:23 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3643cd6sm10622134a12.26.2026.07.14.15.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:21:23 -0700 (PDT)
Subject: [PATCH v2 0/4] mm/hmm: Clarify notifier retry state and scope HMM
 timeouts
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, jgg@ziepe.ca,
 kees@kernel.org, leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com,
 ljs@kernel.org, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Tue, 14 Jul 2026 15:21:21 -0700
Message-ID: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:jgg@ziepe.ca,m:kees@kernel.org,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:skinsburskii@gmail.com,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-23233-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FE877592E0

This small fixup series applies on top of:

  [PATCH v8 0/8] mm/hmm: Add mmap lock-drop support for userfaultfd-backed mappings

The first patch updates the HMM documentation example to make the
mmu_interval_read_retry() state explicit: callers should use the notifier and
notifier_seq stored in the same hmm_range that was passed to
hmm_range_fault_unlocked_timeout().

The remaining patches adjust nouveau, amdxdna, and drm_gpusvm users so the
timeout passed to hmm_range_fault_unlocked_timeout() is treated as a relative
HMM retry budget. These callers no longer keep an absolute deadline around
their outer driver retry loops or pass a computed remaining time into HMM.

This keeps the timeout scoped to HMM's internal mmu-notifier retry handling. If
HMM succeeds and the driver later observes an invalidation through
mmu_interval_read_retry(), the driver retries the operation with a fresh HMM
retry budget.

Changes in v2:
  - Kept the nouveau outer absolute timeout around the
    mmu_interval_read_retry() loop. hmm_range_fault_unlocked_timeout() only
    bounds HMM’s internal retries, while nouveau faults are handled from a GPU
    fault worker, so userspace fatal signals cannot break an endless stream of
    invalidations there.
  - Updated nouveau to use time_after_eq() before calling HMM, so the remaining
    timeout passed to hmm_range_fault_unlocked_timeout() is always positive and
    never 0, which would mean retry indefinitely.
  - Updated the nouveau fixup commit message to explain the worker-thread
    timeout issue and the time_after_eq() boundary behavior.
  - Fixed the amdxdna fixup commit message. It now describes
    aie2_populate_range() correctly instead of carrying stale nouveau prose,
    and notes that command submission still keeps its broader timeout while HMM
    gets a fresh relative retry budget.


---

Stanislav Kinsburskii (4):
      fixup! mm/hmm: add hmm_range_fault_unlocked_timeout() for mmap lock-drop support
      fixup! drm/nouveau: use hmm_range_fault_unlocked_timeout() for SVM faults
      fixup! accel/amdxdna: use hmm_range_fault_unlocked_timeout() for range population
      fixup! drm/gpusvm: use hmm_range_fault_unlocked_timeout() for range faults


 Documentation/mm/hmm.rst              |    5 +++--
 drivers/accel/amdxdna/aie2_ctx.c      |   12 ++++--------
 drivers/gpu/drm/drm_gpusvm.c          |   21 ++++++---------------
 drivers/gpu/drm/nouveau/nouveau_svm.c |   14 ++++++++++----
 4 files changed, 23 insertions(+), 29 deletions(-)


