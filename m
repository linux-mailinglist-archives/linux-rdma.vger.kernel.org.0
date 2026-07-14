Return-Path: <linux-rdma+bounces-23228-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sJbKDuiYVmo5+wAAu9opvQ
	(envelope-from <linux-rdma+bounces-23228-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 22:15:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC0F758ACC
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 22:15:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=moJRbPeZ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23228-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23228-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D76FD30CBC4F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 20:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A78941D65E;
	Tue, 14 Jul 2026 20:13:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5D141A91C
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 20:13:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784060030; cv=none; b=KKLTq5LcOorFR8MbwHvVcJdIQ6UwGAr3LHSMlB64GHz70D752vwvN/cbDY4biUYEr8LsvZ7KIGMC9v4iHWvfd0zTuqE8F0VVhKk1Hus8kinhMuZ+wi2MCKlbGE5g3S8R8i4BILTUbWjLmCuY2BK/zSc8PmIwStVNBdomcljtgoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784060030; c=relaxed/simple;
	bh=KZcIzmwaCHsF/oXSa3XD2VjZoWtXc+ZOgaxQjm2rE1U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIGSi77qjyQZ+J1AJDwHVTj8MgfUo1GNjYWG3I8WsVTdosbwbcPRpVlIYlz/vwI591rVtXMAZXOw+hu3OgLXlqWGWqZQgZK99pp91amLPjGMU4Zw66G210RYyM/0xj1mNIfvKSjzJlJgvk76Yg3wyObjUX9PQ5od8CL1IHjHebc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moJRbPeZ; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caed617615so52427925ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784060028; x=1784664828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=d214MLGyf83e1Jqi9SjyzgCBFipAoJ9SSnt0shamnDY=;
        b=moJRbPeZuuK1Zw0TeuRKOD3VC8HH+vbDw+XXRp8EIO8IAmiEie6jLlw2Il59iQp8RF
         DI8Cl2cFdiAbpqZmxa1COwfJBrwoyHuoA58QmPU88atgYnNjGzzYc2MjKQU8J51sYnOE
         T+3vAA7ZXoyqATGjwydpsKsp3u+TW5zbkUw6UG2QEdx8I83RoeLjIzyyFKY/4zsC3VtT
         VOXHa8woFd8+2vJPda/Vkr3y9LPlgfr1EUJQgBlaSJtFuly2vr5nYvIMqrFMa7yeANFT
         1cVr3tNV9UiTMU0W6rHNxokp7odK63/MbgUeljSlQBqn/thl8wx0zCoriz7iTJNtNK7m
         GcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784060028; x=1784664828;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d214MLGyf83e1Jqi9SjyzgCBFipAoJ9SSnt0shamnDY=;
        b=DeMsuAB74b1MqGh6b4is+5elL9K28Zh16WJQyvaykxdi0NK2tTRw/VJHuz86sQGyIZ
         WmGG9+6+nWxEJgk6B3E14YEECdEStJTUkFA5iliceAgCoT2l5XGPZAzhMlccteAXYPv0
         Mv+USKEnDM3jNwsIlVCsejePld9hGfPRyJ3KKRbInMGlQsUyh5wZv32hcdA1Sk/OnaDe
         8FyI0CsgetVXt0JABwyWARWBftl3Q4jA+hpVNgNFUvOG3QxCTa4YebloItJErqKwCSo+
         zRrlzIecANrqo1ftdnQZGbexiZUvh3uqYOgxA2LlY/MFMBP7YPjQwJ938J6cEh4O2r5W
         QzKQ==
X-Forwarded-Encrypted: i=1; AHgh+RpycW48+VM6xMCM2X/PyyNrvtdJhe0kAex9ye5HWL7vgSm8jioigRikLhS9mOn1LBu1j3ZlJXR8OOda@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3didMEI7003ui+Rt7oK0DLI+PUlpcimgEoxWmDkUBj8uGauEp
	vqsXH8KDel3E9VLDBBpLSFkegG2JWEsCSIU4xC287SIEivPMK7OzmeYP
X-Gm-Gg: AfdE7clGf9DzQYmaaNVSMgdltLfsn6SdskcOrNwGSd/qFD/oJiCwhO/m/ykURP5ynv5
	tnzo4RsT/7lZfypsoYVQ+fFInAlUzHadLrdNAbZTJEsfQlWmk8VkGBJouii9AFYzVU+FY/RR/5B
	s5+ROvLejld76iXrbdTG2j8EM0sVQZywmMAcED592+1zwqurI/jfgGfDQfk9dSdQe8VuC2E5cX8
	CYanxFQwdqtMYglUyVQVnAxxnjhh9cge6caEMZ57eSZSa2aECKNrYVS3y7PDX1jE3Kvr2MDTX22
	teoS4wIwnMhHFm86owj3EX29hvBrcfasCIfw8nvLjfMakLDKvcpyvha1upQurUKEVB+2tk+DJ1T
	PTSaY+zNat7bZ1TH1MmxY9ItBDA5EgINy+rkG/NYDnVR1s8UyVMZ/7ZUcaBHkbAFhNm8K47Wevg
	IQkCxAyOG/abmRnAckOl/56wU3boQ2raNlX845J9uWHHgIrsm9f1UCEPqv1xo=
X-Received: by 2002:a17:902:d591:b0:2ca:c68:c554 with SMTP id d9443c01a7336-2ce9f15d1f6mr140607525ad.38.1784060028032;
        Tue, 14 Jul 2026 13:13:48 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d45csm120844995ad.62.2026.07.14.13.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:13:47 -0700 (PDT)
Subject: [PATCH 3/4] fixup! accel/amdxdna: use
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
Date: Tue, 14 Jul 2026 13:13:46 -0700
Message-ID: <178406002613.1082778.11295976907808029605.stgit@skinsburskii>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:jgg@ziepe.ca,m:kees@kernel.org,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:skinsburskii@gmail.com,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-23228-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 7EC0F758ACC

nouveau_range_fault() now uses hmm_range_fault_unlocked_timeout() for
the HMM fault path. The timeout passed to that helper is meant to bound
HMM's internal mmu-notifier retry loop, not the whole nouveau retry loop
around mmu_interval_read_retry().

Pass the full relative HMM_RANGE_DEFAULT_TIMEOUT value to
hmm_range_fault_unlocked_timeout() on each attempt, and retry from the
nouveau-side mmu_interval_read_retry() check with a fresh HMM retry
budget. This lets HMM continue when it has made progress, while still
preserving a timeout for repeated notifier invalidation retries inside
one HMM fault attempt.

This also removes the open-coded absolute deadline and remaining-time
calculation from nouveau_range_fault().

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



