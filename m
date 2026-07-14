Return-Path: <linux-rdma+bounces-23229-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qZs3OomYVmrq+gAAu9opvQ
	(envelope-from <linux-rdma+bounces-23229-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 22:14:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65171758A8E
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 22:14:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pC1DnLXs;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23229-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23229-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64978303E20E
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 20:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F9963B9;
	Tue, 14 Jul 2026 20:13:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B9412BED
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 20:13:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784060037; cv=none; b=DRbWGKAK8ZXsIMwyTSNw9WDZiPU4Lk+49nNHcGopzcGJ2jrBA1QMU4/srJtiTp09xQEfEj0BiHIiqssUaUMLzg+h+/Nye1iQxAfBaDY/z9i2OWBljuVMq5qrbtn7X5FLEsucaqL1MMnQmg4F8Bb0X4DB9NhP0l/mKOPuQq+qZTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784060037; c=relaxed/simple;
	bh=Q8uBbE9XdPRVXQaZ0ExTI42TK7zcMOJJhXBlrcrT8a4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/fKc7b+iPy1wTr/L8gVCHtY4+eZWftM/D9FMnCGsIwV9IOqKTidt6Vqh8JovCQzwNCyqocK0HIOfIhSxG7VWy7AlnWv0s8YlfMEjnbkH+8YZg5C4zro7Y5QDK6B/ta+AtfcVKck+iH5HNG2T36syKzC9FBt/8k19+1EYtufMiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pC1DnLXs; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceab75934dso40739555ad.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 13:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784060035; x=1784664835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EUZJ2b06rpE59kyPt/lRc7T/ATHNB4Peeih6JEYSOE8=;
        b=pC1DnLXsM9pmrYwdczi94TaLLqpfQzcoJ8YoVM1oFGZFe07rDd/ZCswe0khlgNZrJ1
         bnZTQhA9whkBaPIDABjABX27M3zaGGfUO76Dkj5z00rDODdddWT6Euq7TCJeurqS0iI3
         +eHgc2AwQ67JCkvEgbI1biks0xb/SD55hvZpvaIsGXP9UULODby2vYd0uE/y1WHYsLXo
         KP8oZnUlz/rrrGvauR7PVCczqYe+AYH80h0j9wQGrBsbXdSvplOqRnTqBfpFTMMQNRpz
         1jD00Q96/vaw21V2zPNgvEJegojwXZXA6TOPslb58rOSvT4N87aKlLO+AFVZUacP7NV4
         RIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784060035; x=1784664835;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EUZJ2b06rpE59kyPt/lRc7T/ATHNB4Peeih6JEYSOE8=;
        b=R+p8vSz9F3sqqh7SIztRKQCxIFraJ5q5aJokfocX50sY50e1gVNt4i3onzk0s8QH6o
         all0z2JQ4aVP1X8jZbWYczp8CBXXTg3QHQA1mEQknuE6ID/bV4N9eJ0mVI+2S9VnQ8EE
         jA0X8pCaQ/Z4mCMQaGSFwfkrN1Wxco0PpP+vGLWzDDQCj9otAbXSZE626SJvYNSbSpx2
         9lHq9ZL0TpXpJ5PGCpcZNRwELFDJaVJU75fhUnjNpf5alXM28gAtzS4J/yiSwfJq16kQ
         ZL5XCVohgwCxDGtCf59zvGbLijJ1h+tbAXCj77oKw+TWNgUSxkHtlUFYSKWvBbdiNjkX
         qNmQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBUcHMav3DIzy5UfTtINaqJ7hE2NVnkPGw375ByG+y3PmklnLm05jnQBMrZa2nmWhyNc6JJHMZ0zGM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx3STxy9kLR5dZbqRURIL108E/TMrZmpI54SHeinWyDx4EkGGT
	HY54W165CSqP5bUR1LpsGiVwVDqTHVVyOFpF/jD25HkcRKPQcoDU6R1u
X-Gm-Gg: AfdE7cnZdOMlOo36DyAeBjMydWGdHIE6oqZeQeOhDIBOfdNfvRoelLgshstwJOvY1XR
	GH+6BprM/2d0Y+M6wgXLe9aYhrqHBaJx2sXpAHmm9zrkeKNisBFO4GmtFEoKHB1YqlQStDxGr8J
	CFs53N0w0cZRsBs4RNryWbuKV9Rd0kZVQtq69PIctPFOb5pB4+T27zl8E3o/t7VO6KQ9LohFi1p
	h7RlOrbQWFdQneQQ2U72O1ViWt9Uuy21zazaUmORakuI2Hhxj63ne9hRDmUCferBYtlxwzFCEes
	UexWthr0eyqb3g2damjeWqf54RnQWda/IrXj8spYs2pdJ4jH+9d7zpvyhpDj9ZTnHj4Q7tZlASM
	7lmtT8u/AmK4WYrPpnI0SObyvUkTCByK0nxNLMLHAJpvBMtC+nee4xZJUOB+rRfybHU/MKXObu+
	1WrORSxN+2gGiIn7WFIyi/kllypooONXORpUoL+47UJJ1BzRas/hlEdUu6E/MZtVeJLRliww==
X-Received: by 2002:a17:902:fc8f:b0:2c9:97a8:afe5 with SMTP id d9443c01a7336-2ce9f27e6dbmr139524545ad.40.1784060035193;
        Tue, 14 Jul 2026 13:13:55 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb877sm120937885ad.14.2026.07.14.13.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:13:54 -0700 (PDT)
Subject: [PATCH 4/4] fixup! drm/gpusvm: use hmm_range_fault_unlocked_timeout()
 for range faults
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
Date: Tue, 14 Jul 2026 13:13:53 -0700
Message-ID: <178406003318.1082778.16211328573488321338.stgit@skinsburskii>
In-Reply-To: <178405975214.1082778.5193079941156341151.stgit@skinsburskii>
References: <178405975214.1082778.5193079941156341151.stgit@skinsburskii>
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
	TAGGED_FROM(0.00)[bounces-23229-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65171758A8E

The timeout passed to hmm_range_fault_unlocked_timeout() is a relative
retry budget for HMM's internal mmu-notifier retry loop. drm_gpusvm was
still keeping an absolute deadline around the outer driver retry logic
and passing the remaining time into HMM.

Pass HMM_RANGE_DEFAULT_TIMEOUT directly to
hmm_range_fault_unlocked_timeout() on each HMM fault attempt instead.
If HMM succeeds but the later drm_gpusvm-side mmu_interval_read_retry()
check observes an invalidation, retry with a fresh HMM retry budget.

This keeps the timeout focused on repeated notifier retries inside HMM,
while avoiding an outer deadline that also accounts unrelated driver-side
work after HMM has made progress.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/gpu/drm/drm_gpusvm.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index b8f2dd9982f5..76e8a0028c7f 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -852,8 +852,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
 		.end = end,
 		.dev_private_owner = dev_private_owner,
 	};
-	unsigned long timeout =
-		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	unsigned long timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 	enum drm_gpusvm_scan_result state = DRM_GPUSVM_SCAN_UNPOPULATED, new_state;
 	unsigned long *pfns;
 	unsigned long npages = npages_in_range(start, end);
@@ -867,8 +866,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
 	hmm_range.hmm_pfns = pfns;
 
 retry:
-	err = hmm_range_fault_unlocked_timeout(&hmm_range,
-					       max(timeout - jiffies, 1L));
+	err = hmm_range_fault_unlocked_timeout(&hmm_range, timeout);
 	if (err)
 		goto err_free;
 
@@ -1459,8 +1457,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		.dev_private_owner = ctx->device_private_page_owner,
 	};
 	void *zdd;
-	unsigned long timeout =
-		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	unsigned long timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 	unsigned long i, j;
 	unsigned long npages = npages_in_range(pages_start, pages_end);
 	unsigned long num_dma_mapped;
@@ -1478,9 +1475,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		return -EINVAL;
 
 retry:
-	if (time_after(jiffies, timeout))
-		return -EBUSY;
-
 	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
 	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
 		goto set_seqno;
@@ -1495,8 +1489,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	}
 
 	hmm_range.hmm_pfns = pfns;
-	err = hmm_range_fault_unlocked_timeout(&hmm_range,
-				max_t(long, timeout - jiffies, 1));
+	err = hmm_range_fault_unlocked_timeout(&hmm_range, timeout);
 	mmput(mm);
 	if (err)
 		goto err_free;
@@ -1718,8 +1711,7 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
 		.end = drm_gpusvm_range_end(range),
 		.dev_private_owner = NULL,
 	};
-	unsigned long timeout =
-		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	unsigned long timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 	unsigned long *pfns;
 	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
 					       drm_gpusvm_range_end(range));
@@ -1734,8 +1726,7 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
 		return -ENOMEM;
 
 	hmm_range.hmm_pfns = pfns;
-	err = hmm_range_fault_unlocked_timeout(&hmm_range,
-				max_t(long, timeout - jiffies, 1));
+	err = hmm_range_fault_unlocked_timeout(&hmm_range, timeout);
 
 	kvfree(pfns);
 	mmput(mm);



