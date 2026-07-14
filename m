Return-Path: <linux-rdma+bounces-23236-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mnU1E4y2VmrWAQEAu9opvQ
	(envelope-from <linux-rdma+bounces-23236-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 00:22:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9007592E9
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 00:22:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=e46TpYuY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23236-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23236-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED4F9303E9DB
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 22:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3ED40961C;
	Tue, 14 Jul 2026 22:21:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AAA35F615
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 22:21:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784067707; cv=none; b=B2wJs2tcC60F7G313SMggphE1/o35VGs7w8YIApMo9Hr/RXIXfyLfSnccJwSib/sRZSFsgW4LAOqiZ3/mvQDzPMTqeQy5KYHqnBsLli9vwi3kgG9gqXXMwlj1acqiXYhzcM1RYa6vcEutb+TBwDU+aZ2PMgADtb204W3NntMeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784067707; c=relaxed/simple;
	bh=A4Er1bYo7B9F/Fh0sK6T9CFPqwFBZai4b02cKx2Qk+I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Va7wz20Vt40NwLTCXf+qDwBEEvXp3viNNpJ7txiXpacwX4GHwluZgTvKOpEyr1uTj7+C619TjqZo0CmNkdhVK4zTug0TuMfwy2EDiXe/prGOT02uHhTc4IpfYpb/GX8kzYJa5Z8QVRJjrzZgVNIopTatAgrRHSlJkBXzcDaUg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e46TpYuY; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so4340210b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 15:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784067704; x=1784672504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=O6UyZtJMGWyTXwkf9Ut71gXKM+acqkuQS9WqdrHTITA=;
        b=e46TpYuYIxYIhKkASg9LCbTW93foWXhS3iWCTwgoxIytDClVqta+oJc+jdS0lX/WFS
         aonGRXYzGXEa1xyqv4TfG1T9EKB3KiZIgceQ7+LKrF867I5jExmtTGm6Fa/u4orDXx1L
         veodExEc+DzuNqsQkMlP9uvRJB+gjlzNWqVdxj9RhvAmgSRWEP3hqu3h9qZONko5J6oi
         bvN6K8c8dY+mqslrhZ7zmUn/4DZfz0+f0d0YRx2VRZrnmpzZC603qmtEUt/SN29UvHSB
         e++K3ZsNlcgBgRjqNEuR6Yec1BqkHDOIKo0nPEk6DuaCROAPG+ngUwRJc7EG0BL6p3Gy
         679w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784067704; x=1784672504;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O6UyZtJMGWyTXwkf9Ut71gXKM+acqkuQS9WqdrHTITA=;
        b=cpDEHgsLUbLz+B1FMcXiRCaXBCob6yHtr6Jni/yoRsbSSBo89XH2rcB78PSA7lQhT8
         C4bHEIi32y0FMnnv/LCD5UkY+LDiqBcF8hNR9+jrxN5O2ZXITWuOaAJLbe6Pt9MbKlpQ
         RRv/GDkuUav+br4CdoMHzHoUjYO6B7ppQHP20CR6+uQ0q0tdNrO0D4HQgusXxGDwDbju
         6HRI+lEqYefbHi1FBatJrpwmLUdkEAsIlEyWgr7nlDzIMPM4gPjQNOzN5YEDDCLFeI+c
         5Xu/f3GjYfn2ufXLRjt+rqfedyV1ojlL8nU0Hj3Zjkvp3f+gbfES8xxX/EeSlxwK/foi
         2ZGg==
X-Forwarded-Encrypted: i=1; AHgh+RoyMRpSXqYAbcAMuObe7457WkJkQc8n48MxXdFYKVvKEyRNgJg4nNH2hiM4g/sUUbslXQQqQoXHs2xT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1KzU7UsnRa+yjVkANo9usssFVGR2RdY+mXLPVo1JJ+QTRk7lD
	iRZA/9rgCKcqmTCXSM0x7ffEEDomnkH/W+vrULgI224o9TiOShKL3s/K
X-Gm-Gg: AfdE7ck4p256LC2/fY/0m61ShNiYnfRE2d5qxIdtj0/mP2d6uVqQuKkbsde4TMx9055
	Pm7Cw9m5q8osNUcw4X10wBJ3LT0XxVYVVrjd16901llevytJh1yVTii+/8vYP0p/Xx4AA0xXm5C
	Nemi3cH8wLRAPckyrX5BaB2l+1yKvuHXjoShqMe2tWHvvGA69fzhNF5BKheV7tyxKzQwu29DkjD
	tFfeJodmuMnAN6jzk1KOBz3fxj+KOHf7BN2uoi85ecT+cHUfyxWPLSSYL4GN1a9wkZXGVOFBO12
	s184UqwYVMdO/FrWmsNCBsvb6wE2VFFZTLgGNux2mRbsYPx6rBT9Y4v3M1q5cyy7T4bW/XB9jLP
	4R3MEJ1DGeXS/mXfKPW6fj5J1YxguZSMH96m2DujZovPoBuUViR3+0W3skaP29UvcT3ODMhneAc
	cHDZrzxDNZsjJpTjVVSb2I1L7c/J6kFYFB6wcJyLnTvK2mthzwCefskOT6ZzU=
X-Received: by 2002:a05:6a00:1819:b0:848:4742:90a6 with SMTP id d2e1a72fcca58-84a5140d4b5mr4845081b3a.15.1784067704431;
        Tue, 14 Jul 2026 15:21:44 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4ff2ea4csm2010807b3a.23.2026.07.14.15.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:21:44 -0700 (PDT)
Subject: [PATCH v2 3/4] fixup! accel/amdxdna: use
 hmm_range_fault_unlocked_timeout() for range population
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
Date: Tue, 14 Jul 2026 15:21:42 -0700
Message-ID: <178406770278.1106335.17232929459598625570.stgit@skinsburskii>
In-Reply-To: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
References: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:jgg@ziepe.ca,m:kees@kernel.org,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:skinsburskii@gmail.com,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-23236-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE9007592E9

aie2_populate_range() now uses hmm_range_fault_unlocked_timeout() to let
HMM own mmap_lock acquisition and retry handling while populating an
invalid user mapping. The timeout passed to that helper is a relative
HMM retry budget, not an absolute deadline.

Pass HMM_RANGE_DEFAULT_TIMEOUT directly to the HMM helper instead of
computing the remaining time from a local absolute deadline. The broader
command submission path still keeps its existing timeout around repeated
range population attempts, while each HMM fault attempt receives a fresh
retry budget for HMM's internal mmu-notifier retries.

Keep the existing driver-visible timeout errno by translating -EBUSY
from hmm_range_fault_unlocked_timeout() to -ETIME on return.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/accel/amdxdna/aie2_ctx.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 548ba4315554..21f2817751f9 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1037,7 +1037,7 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 	bool found;
 	int ret;
 
-	timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 again:
 	found = false;
 	down_write(&xdna->notifier_lock);
@@ -1062,13 +1062,9 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 		return -EFAULT;
 	}
 
-	ret = hmm_range_fault_unlocked_timeout(&mapp->range,
-			max_t(long, timeout - jiffies, 1));
-	if (ret) {
-		if (ret == -EBUSY)
-			ret = -ETIME;
+	ret = hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
+	if (ret)
 		goto put_mm;
-	}
 
 	down_write(&xdna->notifier_lock);
 	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
@@ -1086,7 +1082,7 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 put_mm:
 	amdxdna_umap_put(mapp);
 	mmput(mm);
-	return ret;
+	return ret == -EBUSY ? -ETIME : ret;
 }
 
 int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq)



