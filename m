Return-Path: <linux-rdma+bounces-23225-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F6suBHuYVmrY+gAAu9opvQ
	(envelope-from <linux-rdma+bounces-23225-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 22:13:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F47758A71
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 22:13:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=k6lFJE3e;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23225-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23225-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E5E930C38C9
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 20:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42855433048;
	Tue, 14 Jul 2026 20:13:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878E412BED
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 20:13:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784060009; cv=none; b=anC5cMytYljOL1ahSW+bZP0uUJafwaXDO8L9X/lqoNrq47+9MY29uH9of0QZh9Iy0VGyjPRczvtY84EjNJFnPQq5voKPS9STOyY+UyIkASZaa0jXJZcBiThYAgtRBsuYIu1BabGxOya6kCNynJwdfxnnOHe0Zb4AOKxoiLK9u/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784060009; c=relaxed/simple;
	bh=M3iXyfmpsqnLTOm4C9JQljZWWPFlOSzSAIkxUKB+CuM=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=ibwSjkTD9o1pSreV1fep05JK2quOtwBUQjy4nPgRYTOKWDaU+KMGAsUn0l1vHEazBr6Xxtg70Pc1mS7AAW9RFK2xzZ5NXoZoJjQ1dcs6cyijE932YAow4KYPC5UbOfV/aL5EwlPwowi9yJ8j0fAX0ojQsrJyAyEwMs5VseIMlGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6lFJE3e; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-848d21bbaffso3812768b3a.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784060006; x=1784664806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TgA5/ZNNqpom9Ojeo649tW4NqgfWq3ikZU/yXXQBBgI=;
        b=k6lFJE3eKj2hmZ3Yy4wyePNrZYKYIgZz5P/UI4UA4IKlS0oB/+8bq4IoSuCCLwsHuJ
         IvQtFLkaoFqtMUobJ805Gtn6+BUGYQGBpeb2Y9opKbcnf8j/VqD/DnsqnPHFsvHSX+wx
         zRVn0rE2MoUlWf9mAKT/c4YdzI2R/np9m3yAB8BtLfL0J5qt+1fd4JrwaP1xwUJGXewj
         oFbEKm350y+MYJ53a3oMAdOTEjfNhoTLIuUyB5N3z7wRAWQZ0ZX+C2WHEIaC5A4/hrAd
         En3W/kTVRnX/IOTcPCdHH0Pu11FyFyXpK7ruyXY5/bJMSEwwD/z9XKH/yPs6BpIUzQhQ
         Z3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784060006; x=1784664806;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TgA5/ZNNqpom9Ojeo649tW4NqgfWq3ikZU/yXXQBBgI=;
        b=rsm4qpb4i1pa6Y+da4JiJ10q82gwC2toCk0XtRmtLwuRMfGEdqTwlBHQpPID8W2Dwm
         gWqMfy/VH/SNqNjEUhyeoWeqsaYuLET5lKU9+nPH1aVaHNI3SLP4gCV7I3t5hOyLUayt
         wLSy49duGqMHWZUhXeAstnvVR0I2KrwUtH2UzaDKlBhGZuRrRfV6p8zWHPCOeI9UnfKr
         Cgj4xsdXA42HxaL6ErbmOCORmUPPDPp4tPc2HOE9tHoN+sRwd9e14bX0iJPzJvVliMlA
         THL479N+JX5wyZr4WUWnh2noTXhWba5upAeMJdlCOxaatPCT0WIbdCwvyKm50g4GjzCX
         NYww==
X-Forwarded-Encrypted: i=1; AHgh+RolQ2yWcVRiubI+RrU8sWqulgDH3o+3/uSA7Bt2czjxqdrflsHMtNQ3bX5ogAIQEO2sdgPPfrCFp7er@vger.kernel.org
X-Gm-Message-State: AOJu0YxPHz99DneOMLpeOpJu0suwkKBQ4md5vrS89Wx3+/BWuc7aVXM1
	ZobehVs8WSBL86NkwKuItLA4t0uhi6su37rCt9SgVaTKs3G62syJyQtx
X-Gm-Gg: AfdE7ckF04gJrO9jzj1L5j24S4b3eTHt/TdMsvgYnh8pTTKIqAUIphz5kWmHIkjNiEl
	FZC38YyQIE/2UrSg+b+5QT5OQ/9+j27YZmepLJYLa54tbZPrmBt3ILUqfILKTKwUeJvAxEoCTpC
	gFY/a2NDLDSo7xmpRVcos41422K/D5qr36rh6jh/AvSNs9sOv/MQ11JWkQjnMPrvkGphcdhBSDn
	HpLaIZQDo9MS3f/fVVp1m0ey9hCxzotRhZgZ8C1W07//XWlAbhpvn0/mfkCqkZkSDbkFywlwRUO
	SrhPJoAwIrFFBEqx+XxUFR+DfpFuYGWp4TVWuv5Yj0L0Uua4H6u5gF5z/6C4I4l0FH+ZWJ2rKHc
	VVyo6aiEweMPByh/5AjX1fJRUoodxLCJaGiWZh+3zP8HRejzaNwkK3baEXXcFKwzuV3FCBJXcmK
	whUXpjjRiij6+W2ldAw7EO5nifdLGHyMK3W+kRRlWIxnAy7pld1YQKlnBY2p1IoMJn29+Wkg==
X-Received: by 2002:a05:6a00:1f14:b0:845:e9e5:cdec with SMTP id d2e1a72fcca58-84a559bb7dfmr3412771b3a.62.1784060005776;
        Tue, 14 Jul 2026 13:13:25 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7dade0sm1998127b3a.46.2026.07.14.13.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:13:25 -0700 (PDT)
Subject: [PATCH 0/4] mm/hmm: Clarify notifier retry state and scope HMM
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
Date: Tue, 14 Jul 2026 13:13:23 -0700
Message-ID: <178405975214.1082778.5193079941156341151.stgit@skinsburskii>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-23225-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,skinsburskii:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55F47758A71

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

---

Stanislav Kinsburskii (4):
      fixup! mm/hmm: add hmm_range_fault_unlocked_timeout() for mmap lock-drop support
      fixup! drm/nouveau: use hmm_range_fault_unlocked_timeout() for SVM faults
      fixup! accel/amdxdna: use hmm_range_fault_unlocked_timeout() for range population
      fixup! drm/gpusvm: use hmm_range_fault_unlocked_timeout() for range faults


 Documentation/mm/hmm.rst              |    5 +++--
 drivers/accel/amdxdna/aie2_ctx.c      |   12 ++++--------
 drivers/gpu/drm/drm_gpusvm.c          |   21 ++++++---------------
 drivers/gpu/drm/nouveau/nouveau_svm.c |   30 ++++++++++--------------------
 4 files changed, 23 insertions(+), 45 deletions(-)


