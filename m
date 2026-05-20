Return-Path: <linux-rdma+bounces-21059-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOPUKpvkDWpz4gUAu9opvQ
	(envelope-from <linux-rdma+bounces-21059-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 18:43:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 149945924F0
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 18:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FD1A321341A
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 15:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1674E3264EA;
	Wed, 20 May 2026 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laOD+KBs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418D330B529
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292043; cv=none; b=qsRHcvqmZYaEo+ddyv8EQCKOVEoeqFdRjflBLf7noMq1nBDG09zSI0i8FJlSgfD34HOu3l5b6EHeztVwg9KqEf9i+pyVsmbvRFRLtUcWDHzVdnyqwAFIadcUUH5VGJAB3wYlTSJ+3x/f2WZ6GaPohw4mGQCxQjFcurpUJviM6eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292043; c=relaxed/simple;
	bh=/qBHlQUH0EWQ0nV7VPwajE+a+zB+kJLU/RQ4QphprPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8BvmMwQtWineQTjYQ79gXjwtMYe2epHNotDEPCfSsQtMQtyzVFOYYNbMdlKT3q6aCcQPF791fvhZ1zh88WZk2InR+6WfDSgk9V7vSxdKysNiQi0v4oqRzI16oYVwMUpt48BveIAGAYJENxVKW/sf2w/Jsr7onD47Hd7MUSOZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laOD+KBs; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9116861f004so1164023185a.3
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292041; x=1779896841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9E8Z4P+2CqRGClc1by3kV59mWAyA9/b2lfXQSp7x+w=;
        b=laOD+KBszjtQhcuMJR51d5BRJx5ooqT5L4L4wV418wx+VlypO0x7uGdQF+uYMyyMIP
         dIMJYGXf4+gSw82pVHU8ZLyvvDZLXfIUKAVwcdTT1GUn2Uajy7doma4j1w1e0ARwySFl
         k3iJf9N8N+izclFDm/jP8VZgLcTIPEyEkd/FkQo6/Gre8DXwuGc9IdpbcKpNLka1n4Gw
         BnoLIQU1zGKJWZprAbjRWIclzRsxDAgIQVKMGEFMnARi8oyKDUje4z3M/4+5p9RprFeZ
         MA/OKaEUK6kFGNZWC0svWH8KZ0CCAm50WkYkYWDBt9y1WQ4cvT+XX3nZvwNPPMaYDRrr
         Jixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292041; x=1779896841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V9E8Z4P+2CqRGClc1by3kV59mWAyA9/b2lfXQSp7x+w=;
        b=c1TaW18XrDvap8L/jMclS3OuIHMHStw7AzcxsslEfKD9ahI3i1nAYKmhz1eaD4DwXV
         0ZpxnhleJak6HKhFWao622+M2mjwc3vf6gn5vCNOaVpk5IHd+UeHXmLcUmZqbJzrroQW
         4L/KsuyfUZ47y3s7lruZu+oerqIf+2CIhSkbEtPDeEnF/tS80JUzeTDT1ydQgKSGJlDO
         gaq6zW2qL3MmeHLVcMsHOHZWTg70gs6HGwIxou7p42rLB0E7xG6EhouuGo87C/xdM6Wb
         DyGP3rEzmcX723/ERyYHkSDbKYKJ4WdowFb7Ou5zcKyXPNNSvAmrbFW5CzUmyNXhHPh4
         OpKg==
X-Gm-Message-State: AOJu0YyieLddusWHOOVpIzdeU3JJTYD6Fd3SbRmt+B0BBPO0eSaJFlRB
	kJCL2Jo92Ih2MthIdSqZGLBYCf+A2OIIYPMs2jEIGcFJ8K6qa/26V+n2
X-Gm-Gg: Acq92OGEHHcOJPesvz1h7gYDWStCu7OCa5vTTR5B941KFT8L5IkBEZieOGM7sW1sXne
	4iS4HI1xYL8q2uBXoWIcEF9Y3vCCqsro0zxBp+6cOHEuYPq3wSqPVbkdF0g0fj12lTsCHvGveFL
	mM/frY1XFxzRMtT5SfXTeBUenFKzO5ACnYgVoMXdgN2ZyTpKczMRSsXJqtBW8Wu4CBxo4S/ofYL
	HP+3wvBPsgenzaZIerCIhVqQfDy9b/nhm+fuMVvPH/QbcMXjtNNjhrCbikhmavfmlupH0EKJo3T
	M7Bvw0gs3/C1lDnTf5XgDo/RBm4Q+mUaQp6Ri7UC4GYJGmZQDVRLKrn6GDNVJJZK0oqrVufgsMb
	LV0pd6V07yYEtlZfCWFYuRbloQiXN0JXXT5Exz4YLGOi5NWpkpL9WQl4auRND/Olfub/J+gmw5a
	adV2L+xuA6HD/NjGkEmKJ0+0jEoUWA5o0B0rpyvkQSmiQnEGd7clZGXVanuwYE8AnmVw3LzdKAf
	gNued3MD5FtAv3AWMtz
X-Received: by 2002:a05:620a:2890:b0:911:449d:98c0 with SMTP id af79cd13be357-911cdd435cdmr3621704885a.7.1779292040928;
        Wed, 20 May 2026 08:47:20 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3618fe0bsm124812016d6.25.2026.05.20.08.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:47:20 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Bob Pearson <rpearsonhpe@gmail.com>,
	Sean Hefty <shefty@nvidia.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2] IB/mad: cap RMPP reassembly window size
Date: Wed, 20 May 2026 11:47:15 -0400
Message-ID: <20260520154715.1457495-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518212336.337104-1-michael.bommarito@gmail.com>
References: <20260518212336.337104-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-21059-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 149945924F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

find_seg_location() inserts reordered RMPP DATA segments into a
per-transaction list by walking that list in reverse. The walk runs
under rmpp_recv->lock in the MAD receive worker, so a large receive
window makes a reversed RMPP burst expensive.

The receive window comes from recv_queue.max_active. With the default
recv_queue_size of 512, the window is 64. Larger tuned queues can raise
the window to 1024, turning one reordered transaction into repeated
long list walks and keeping the target port's MAD worker busy for
milliseconds.

Cap the RMPP window at 64, matching the current default. This keeps
existing behavior for default configurations and prevents larger receive
queues from increasing the worst-case insertion walk.

Fixes: fa619a77046b ("[PATCH] IB: Add RMPP implementation")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Impact: a fabric peer that can send QP1 GMP RMPP DATA segments can keep
the targeted port's MAD worker busy with reordered RMPP bursts, delaying
other MAD processing on that port.

I tested this on v7.1-rc2 under x86_64 QEMU/KVM with rxe and raw RoCEv2
packets carrying descending RMPP segment numbers. With
recv_queue_size=8192, the unpatched kernel spent at least 1.5 ms per
F=1024 burst in the insertion walk; the patched kernel dropped the same
run to about 0.28 ms because segments outside the capped window are
rejected before the list grows. A normal in-window F=32 RMPP exchange
still completed; there are no in-tree selftests for QP1 GMP RMPP
reassembly in tools/testing/selftests/drivers/net/rdma.

Changes in v2:
- Rewrite the commit message in shorter, plain language.
- Trim the code comment to the local reason for the cap.

 drivers/infiniband/core/mad_rmpp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
index 17c4c52a19e4c..0db645eb2e29b 100644
--- a/drivers/infiniband/core/mad_rmpp.c
+++ b/drivers/infiniband/core/mad_rmpp.c
@@ -391,9 +391,18 @@ static inline struct ib_mad_recv_buf *get_next_seg(struct list_head *rmpp_list,
 	return container_of(seg->list.next, struct ib_mad_recv_buf, list);
 }
 
+/*
+ * find_seg_location() is linear in the number of queued segments.
+ * Keep the RMPP window at the default size so a larger receive queue
+ * does not also enlarge the reordered DATA insertion walk.
+ */
+#define IB_MAD_RMPP_MAX_WINDOW 64
+
 static inline int window_size(struct ib_mad_agent_private *agent)
 {
-	return max(agent->qp_info->recv_queue.max_active >> 3, 1);
+	int wsize = agent->qp_info->recv_queue.max_active >> 3;
+
+	return clamp(wsize, 1, IB_MAD_RMPP_MAX_WINDOW);
 }
 
 static struct ib_mad_recv_buf *find_seg_location(struct list_head *rmpp_list,
-- 
2.53.0

