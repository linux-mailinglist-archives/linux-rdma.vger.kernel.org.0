Return-Path: <linux-rdma+bounces-23025-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8ddGLoRlUWrNDwMAu9opvQ
	(envelope-from <linux-rdma+bounces-23025-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 23:35:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EEB73EFDD
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 23:35:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ba7UuVa+;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23025-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23025-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C2DF3045C81
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 21:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232343BFE59;
	Fri, 10 Jul 2026 21:27:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA83B777F
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 21:27:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718822; cv=none; b=NNL6kYUF1/oDFb2rxGkETanKx6yOhHHbjtwapzCNmJSrjXu4qPW936G4UOIx8fNvmkiAl5JilyWzrrwgdDEiYY/zSdkRje4PbEQJnEyuXsIt/pFqT/ShKGMp/2RgvUZo8FagCBsVxy8aexKfgcnz4MmUmfz8oj5hw1BCTD6Z8P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718822; c=relaxed/simple;
	bh=oLJSKeCx7nGCL58ICDoU/1+ilBudUYNfbCfVls0zVKM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erCpQsajdGqYO1D1oWe1LR6sCEVVwZgALAg18a+OixC+GYVGdbeOTkbhxfnV4ceptzVZhRfbwg29AX2uMx4b+EU5lpBBHGjDTcdR0rmz6ZbNaEy2q+TA0G8yA6ldUt5AzcrpazqjnDe7ahyYllW/OyO2VBHeNT/2G628BGcgbrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba7UuVa+; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8484a0b998fso2034719b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 14:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783718821; x=1784323621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=i81Mvoxwiz31acM23+HpM6LiopJwdOVnXlQ0p0m7OMc=;
        b=ba7UuVa+shzeXiuPbfIfB9GNaimyLY+aaJQs1V/AfART1SAYnwC05hG3fJSB4zEAY5
         Mp6DpLSz6dcfovvJCW02nGUWjWMqMfKR8WZCdLGpdVCZmrFzDtxEEV/IrLQubfWCHXLM
         GbWkTPuSqIcNXWWcUCP35u9sUBZD+BfSEBpx84eUuJS0txs3mw+Yar4YvIQOf0I+8D68
         GVkWroYoz7DqW7ETsBUHS6PEtmLBHHhp2o4YujhYBDKDV+PCp9hVutWg9A6alTITfMcX
         jhM28s7vJCz4Ll1UUG/0IHb/iVNyczMejjsKintfCJXKf4CCt71Ba1i+Vlxkr/nAxLRl
         CEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718821; x=1784323621;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i81Mvoxwiz31acM23+HpM6LiopJwdOVnXlQ0p0m7OMc=;
        b=sAZTLvnTrrFbWGzwQB3DmFOVrWe4EEpnGYumtI9kIlahuiDkfsMunOcLV7WerfPlgu
         8hdSevK8+F1SaIrkoPL8hjVJAAaCL7ND1FgFZeis8vd1RPmWvO1CmWuA4byD81DgTBmH
         bOacMTfXWqSZaT+flSSXWtDfFC+L+yLcjJ7vERhOd5vifvY2/Zqv+k0q5/f47Ws6U/lp
         0GTGX1fHVjQAhoucZlYUMCMLb/1soi+0RICYi6E5EoOtjVn0nJqXEQCeZetvs2/H3sNm
         7sH85usZ3DOOZVd3KLyKrmziITcIEz44hGfXJLvZdytW16KBKo5vf9FUE3UJppC3KXCF
         ybJg==
X-Forwarded-Encrypted: i=1; AHgh+RpyeIlgQA3cC+WftbKGM/vnPWQG+XfUBRjQbqc1vLYa7tUUdulgjDjavCaAJc7C1rz9TsWUes2+TYy8@vger.kernel.org
X-Gm-Message-State: AOJu0YwYFUj29Cq6HyVknvfxZ/GkbkFZm/rSdkpayFMqFWWnP2wGIGoO
	lW1xtngeM67RUb+MyUhPgm0gCDbPTDmDdPoeQ1Dl3vzCZ49JtGbU0tnk
X-Gm-Gg: AfdE7cn7JkBvn1/Ik//+hbjjN+TS089rSjmzblnlXORkLampFPg9C+ETsyyx0YmB9O1
	Q59UET+pESCXDfHzFhoqDNLkgwxUr1GI9beMYNXByDlTlzyIbuOUydOjuafxmMepm8j9BAe5KrA
	mU5/WHiEDO+JOeDEgVjKtItVR9OTRmRgqbtq1VcT7Ll8pbZq+T2irP1Rci6LFjshRYT4hoZmojR
	TpyMFoiQ2qaUH3JKmL2zilUEti89aLI0zztwufHnaauKhH3k6LxnTSIkU8VTPPQ6WitHXKN9OBo
	umESCB3IXeHBxoqK0hedEntJaCSIKtf0tnsw29pKG86zlrF9gkGjzAGxQljewkcD8CD3EFi19Kh
	qrQmEwrqOIO6HWk/5ggZJm8IKV21QJnd4rmaIVUUINTX2ajNbJ9+PZvZhFiem3Okl7oJ+BcRZne
	lZagHNdIvFyDqq0YHeDlCzDCcO4j6wVoNqroHhDe9gcYUvPUbAvW1A8zWnVd0r0z7aX0QmXg==
X-Received: by 2002:a05:6a00:a0e:b0:847:7f38:27ad with SMTP id d2e1a72fcca58-8488975299emr661948b3a.53.1783718820769;
        Fri, 10 Jul 2026 14:27:00 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8482b333d4fsm6649821b3a.54.2026.07.10.14.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:27:00 -0700 (PDT)
Subject: [PATCH v8 5/8] drm/nouveau: Use hmm_range_fault_unlocked_timeout()
 for SVM faults
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org, kys@microsoft.com,
 leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org, wei.liu@kernel.org,
 skinsburskii@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Fri, 10 Jul 2026 14:26:58 -0700
Message-ID: <178371881847.900500.8789369230260725500.stgit@skinsburskii>
In-Reply-To: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
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
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23025-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,microsoft.com,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORGED_RECIPIENTS(0.00)[m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:jgg@ziepe.ca,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:skinsburskii@gmail.com,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii:mid,vger.kernel.org:from_smtp,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24EEB73EFDD

nouveau_range_fault() takes mmap_read_lock() only to call
hmm_range_fault(). It also keeps a single HMM_RANGE_DEFAULT_TIMEOUT
deadline across both HMM -EBUSY retries and post-fault
mmu_interval_read_retry() retries.

Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
the mmap lock and refreshes range->notifier_seq for its internal retries.
Nouveau keeps its existing absolute deadline in the outer loop and passes
the remaining jiffies to the helper for each fault attempt, so retries
caused by mmu_interval_read_retry() do not reset the overall retry budget.

Nouveau still validates the interval notifier sequence while holding
svmm->mutex before programming the GPU mapping.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index dcc92131488e..4cfb6eb7c771 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -683,15 +683,11 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
 			goto out;
 		}
 
-		range.notifier_seq = mmu_interval_read_begin(range.notifier);
-		mmap_read_lock(mm);
-		ret = hmm_range_fault(&range);
-		mmap_read_unlock(mm);
-		if (ret) {
-			if (ret == -EBUSY)
-				continue;
+		ret = hmm_range_fault_unlocked_timeout(&range,
+						       max(timeout - jiffies,
+							   1L));
+		if (ret)
 			goto out;
-		}
 
 		mutex_lock(&svmm->mutex);
 		if (mmu_interval_read_retry(range.notifier,



