Return-Path: <linux-rdma+bounces-19998-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOeRHJ+h+WnR+QIAu9opvQ
	(envelope-from <linux-rdma+bounces-19998-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:51:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6354C848F
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C20D8303DFC3
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 07:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3F53EB801;
	Tue,  5 May 2026 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dBIomGZu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2683EDABB
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967260; cv=none; b=KGgRwbjhbJJ0oLJqNguaGsOi5Ryurb3UWH0vOtcqUlGnIrJsuPI309hwA1+Cesq/5C/wqD+Z8ystvBiULf2EFUgNAINVHzj/zNBanxMLbqt6QnddzuHCNPQmllwvOSl8GDBGCyLUZmUvljfUV/YshRdMSzxtyBkFoRoipItic30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967260; c=relaxed/simple;
	bh=geA4MryeU2UclNAxcHEVRqgPgmO+wktIdv8kuvyvZf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PavQ1GGe8aK/mr/H7FpZcuMBFZDcCqmsiTBsyiRxsxQcZfguJdXX8rOEm5rYJgHcThc7XV4GFnuq4756pRh/H5fRz0XBCu9vpHAmTQ+pRBpS4NL8x1tjYZSitfwasMxct4iuRC9wwqk6ptT0U+ohJWn0Uj97USKUO2oskTmW9Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dBIomGZu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so71485545e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 00:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777967254; x=1778572054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwGkBFHbFu/y+mgG9Lk/Gp6pcxDdG1DP37LAi3aazyM=;
        b=dBIomGZucrvWW6gQJ8qLmySlrzwzniprnKa09dq9Pp+WGv8FES9uq77gbIAIAhcs7R
         gRJPHKE/yPK1yS+C30drtYxVY6tflxBhZZtw6Nt5FDo2H/04sFMSDm2BSCx3LPobjThw
         6j682m4JOL2otnT02bEq/KQn3DyTd9m+SMxvAO1bP00pkNnyMLup7TjZ3GEp5Mvb38Bv
         ccK+Yzc54a4cpslcGN9GmhUm7vCkbzOJEYUfmvCYmokrirQyqycEHz6kq+4++TVdtrUA
         Ml++SdHAlIUDtA937tL+Ac5/n1CoasmJKInOjYBDmqpQZzNLesNhIhzgV72H/uyAXFn8
         97/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967254; x=1778572054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PwGkBFHbFu/y+mgG9Lk/Gp6pcxDdG1DP37LAi3aazyM=;
        b=dr5eIcTEzqGIbrrSkuWHCCLxrmd29FjxXzU8c39cwF0AORcLkcgowcJwZspKIgYqeR
         Ur25vL2OcvcSuGZaYc2MAgSshTv/zMAJfHVl5u+2lgG/Ula9HhwtOK/mp3OR4GDD+4wE
         i7plyC6mI/NSIr7gmX3Wl5osZzcMMD8Onf3yM4HTMQfatUZLp2ulJo1FcwOV8zWbkAX+
         tlow+bweksfXLC0HAqVV7+uUfd2xmOGVOnBYQHZBNeTeFBi3gNvMKr9lbJd4oCIA7jD9
         y0h11YjtkiC1vlc1VS5RT1YUWp3XJsRF+q/yXHZ4G6A0DC9DT2TPBjH+gA/IQsbDWPcx
         1RhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+A6ZvI8/geTFxvEoMXyZ2gOCBkHYhJzdO9c19CYcTM0XwsZNUf8EGxl0KnXsgzfK8moELzAO9RPOMU@vger.kernel.org
X-Gm-Message-State: AOJu0YyBEGlbipvgvj2DoPRF3oaPaLz5gdGnC5MmIJWiQ3hYmQep0Pgh
	ozizmXomhfP/wIt2fX4S5FMtejQHzUtGnbbfY6m+JcKzIXIK6bXA08aCjMJ0fR+8vIo=
X-Gm-Gg: AeBDietMwbeBoDPazxXlO1FlA3eyXgSSqgUihgvmjyaGnNZos3cxgY9PLmgmk1ziWwO
	q4S/pt6wATG243T3ioWxyfX+exzhNsdgNIX1ZFwM5I9bLgmt3ta8jLbtSi7dPbWsvfUqynsQY8T
	6CZs/a2ImIrsYU5Q1+V5MLgeb/uUeWjATn2u6GTrSJk8kqHWsGD9n3Itrg10KI4EizpidWK971B
	A/tVM/tyzYGF94bl+TOAaIheUiBbzzk5HAagnh11E2cvmlT3lC+W2CC8RQ/rqvqnAKa3YwjQgCo
	0JHMsWV6SIcNGme+d4e5yp7EBRFIfElVEdl59XGXiPMMXGWv513gmmMZG/zYjdtJz0i/puiTJ9j
	jPjTPa7CRAqEl1KMALXASa1Dr6iy1BpUWsg5KKCnTYJb3l4H0pMuDykgBanFbMTcVa5QZUCnIky
	ITWaT9JViTP1d9cvQcZkZBoSRZtVTK5/pGw5l4nVn01kDFF7tsc9u+tt7wdj1oMocidNrHzEOWa
	7+BZeR36WSiGjhtSvUSnh7hZ2rTMrLvIta1+TrAsoWm0A==
X-Received: by 2002:a05:600c:4f82:b0:488:e7e4:8425 with SMTP id 5b1f17b1804b1-48d18ce446bmr26865835e9.23.1777967253764;
        Tue, 05 May 2026 00:47:33 -0700 (PDT)
Received: from lb03189.fkb.profitbricks.net ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d186d97c4sm10617125e9.35.2026.05.05.00.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:47:33 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	axboe@kernel.dk,
	bvanassche@acm.org,
	hch@lst.de,
	jgg@ziepe.ca,
	leon@kernel.org,
	jinpu.wang@ionos.com,
	Md Haris Iqbal <haris.iqbal@ionos.com>,
	Jia Li <jia.li@ionos.com>
Subject: [PATCH 09/13] block/brmr: client: main functionality
Date: Tue,  5 May 2026 09:46:21 +0200
Message-ID: <20260505074644.195453-10-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505074644.195453-1-haris.iqbal@ionos.com>
References: <20260505074644.195453-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0E6354C848F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ionos.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19998-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ionos.com:email,ionos.com:dkim,ionos.com:mid]

Add the BRMR client implementation:

  brmr-clt.c		client core: gendisk and tag-set creation per
			pool, blk-mq queue_rq() submitting block IOs to
			the underlying RMR pool, queue limit setup
			(chunk size, write-zeroes, discard, write-cache
			and FUA features) and device tear-down.
  brmr-clt-reque.c	per-CPU requeue queues used to retry IOs
			temporarily blocked on RMR resource exhaustion.
  brmr-clt-stats.c	per-pool statistics counters (request size
			distribution, BLK_STS_RESOURCE returns).

These files are not compiled until the modules are wired into the
build in a later patch in this series.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jia Li <jia.li@ionos.com>
---
 drivers/block/brmr/brmr-clt-reque.c |  228 +++++
 drivers/block/brmr/brmr-clt-stats.c |  332 ++++++++
 drivers/block/brmr/brmr-clt.c       | 1222 +++++++++++++++++++++++++++
 3 files changed, 1782 insertions(+)
 create mode 100644 drivers/block/brmr/brmr-clt-reque.c
 create mode 100644 drivers/block/brmr/brmr-clt-stats.c
 create mode 100644 drivers/block/brmr/brmr-clt.c

diff --git a/drivers/block/brmr/brmr-clt-reque.c b/drivers/block/brmr/brmr-clt-reque.c
new file mode 100644
index 000000000000..252661486a0a
--- /dev/null
+++ b/drivers/block/brmr/brmr-clt-reque.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Block device over RMR (BRMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include <linux/module.h>
+#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+
+#include "brmr-clt.h"
+#include "rmr.h"
+#include "rmr-pool.h"
+
+MODULE_AUTHOR("The RMR and BRMR developers");
+MODULE_VERSION(BRMR_VER_STRING);
+MODULE_DESCRIPTION("BRMR Block Device using RMR cluster");
+MODULE_LICENSE("GPL");
+
+static inline void brmr_requeue(struct brmr_queue *q)
+{
+	if (WARN_ON(!q->hctx))
+		return;
+
+	/* We can come here from interrupt, thus async=true */
+	blk_mq_run_hw_queue(q->hctx, true);
+}
+
+/**
+ * requeue implementation as used by ibnbd
+ */
+
+void brmr_init_cpu_qlists(struct brmr_cpu_qlist __percpu *cpu_queues)
+{
+	unsigned int cpu;
+	struct brmr_cpu_qlist *cpu_q;
+
+	for_each_possible_cpu(cpu) {
+		cpu_q = per_cpu_ptr(cpu_queues, cpu);
+
+		cpu_q->cpu = cpu;
+		INIT_LIST_HEAD(&cpu_q->requeue_list);
+		spin_lock_init(&cpu_q->requeue_lock);
+	}
+}
+
+/**
+ * brmr_get_cpu_qlist() - finds a list with HW queues to be requeued
+ *
+ * Description:
+ *     Each CPU has a list of HW queues, which needs to be requeed.  If a list
+ *     is not empty - it is marked with a bit.  This function finds first
+ *     set bit in a bitmap and returns corresponding CPU list.
+ */
+static struct brmr_cpu_qlist *
+brmr_get_cpu_qlist(struct brmr_clt_pool *pool, int cpu)
+{
+	int bit;
+
+	/* First half */
+	bit = find_next_bit(pool->cpu_queues_bm, nr_cpu_ids, cpu);
+	if (bit < nr_cpu_ids) {
+		return per_cpu_ptr(pool->cpu_queues, bit);
+	} else if (cpu != 0) {
+		/* Second half */
+		bit = find_next_bit(pool->cpu_queues_bm, cpu, 0);
+		if (bit < cpu)
+			return per_cpu_ptr(pool->cpu_queues, bit);
+	}
+
+	return NULL;
+}
+
+static inline int nxt_cpu(int cpu)
+{
+	return (cpu + 1) % nr_cpu_ids;
+}
+
+/**
+ * brmr_requeue_if_needed() - requeue if CPU queue is marked as non empty
+ *
+ * Description:
+ *     Each CPU has it's own list of HW queues, which should be requeued.
+ *     Function finds such list with HW queues, takes a list lock, picks up
+ *     the first HW queue out of the list and requeues it.
+ *
+ * Return:
+ *     True if the queue was requeued, false otherwise.
+ *
+ * Context:
+ *     Does not matter.
+ */
+static inline bool brmr_requeue_if_needed(struct brmr_clt_pool *pool)
+{
+	struct brmr_queue *q = NULL;
+	struct brmr_cpu_qlist *cpu_q;
+	unsigned long flags;
+	int *cpup;
+
+	/*
+	 * To keep fairness and not to let other queues starve we always
+	 * try to wake up someone else in round-robin manner.  That of course
+	 * increases latency but queues always have a chance to be executed.
+	 */
+	cpup = get_cpu_ptr(pool->cpu_rr);
+	for (cpu_q = brmr_get_cpu_qlist(pool, nxt_cpu(*cpup)); cpu_q;
+	     cpu_q = brmr_get_cpu_qlist(pool, nxt_cpu(cpu_q->cpu))) {
+		if (!spin_trylock_irqsave(&cpu_q->requeue_lock, flags))
+			continue;
+		if (likely(test_bit(cpu_q->cpu, pool->cpu_queues_bm))) {
+			q = list_first_entry_or_null(&cpu_q->requeue_list,
+						     typeof(*q), requeue_list);
+			if (WARN_ON(!q))
+				goto clear_bit;
+			list_del_init(&q->requeue_list);
+			clear_bit_unlock(0, &q->in_list);
+
+			if (list_empty(&cpu_q->requeue_list)) {
+				/* Clear bit if nothing is left */
+clear_bit:
+				clear_bit(cpu_q->cpu, pool->cpu_queues_bm);
+			}
+		}
+		spin_unlock_irqrestore(&cpu_q->requeue_lock, flags);
+
+		if (q)
+			break;
+	}
+
+	/**
+	 * Saves the CPU that is going to be requeued on the per-cpu var. Just
+	 * incrementing it doesn't work because brmr_get_cpu_qlist() will
+	 * always return the first CPU with something on the queue list when the
+	 * value stored on the var is greater than the last CPU with something
+	 * on the list.
+	 */
+	if (cpu_q)
+		*cpup = cpu_q->cpu;
+	put_cpu_var(pool->cpu_rr);
+
+	if (q)
+		brmr_requeue(q);
+
+	return !!q;
+}
+
+/**
+ * brmr_requeue_requests() - requeue all queues left in the list if
+ *     brmr_clt_pool is idling (there are no requests in-flight).
+ *
+ * Description:
+ *     This function tries to rerun all stopped queues if there are no
+ *     requests in-flight anymore.  This function tries to solve an obvious
+ *     problem, when number of tags < than number of queues (hctx), which
+ *     are stopped and put to sleep.  If last tag, which has been just put,
+ *     does not wake up all left queues (hctxs), IO requests hang forever.
+ *
+ *     That can happen when all number of tags, say N, have been exhausted
+ *     from one CPU, and we have many block devices per session, say M.
+ *     Each block device has it's own queue (hctx) for each CPU, so eventually
+ *     we can put that number of queues (hctxs) to sleep: M x nr_cpu_ids.
+ *     If number of tags N < M x nr_cpu_ids finally we will get an IO hang.
+ *
+ *     To avoid this hang last caller of brmr_put_iu() (last caller is the
+ *     one who observes pool->busy == 0) must wake up all remaining queues.
+ *
+ * Context:
+ *     Called from msg_io_conf which in turn is a completion handler
+ *     that is called from interupt.
+ */
+void brmr_requeue_requests(struct brmr_clt_pool *pool)
+{
+	bool requeued;
+
+	do {
+		requeued = brmr_requeue_if_needed(pool);
+	} while (atomic_read(&pool->busy) == 0 && requeued);
+}
+
+bool brmr_add_to_requeue(struct brmr_clt_pool *pool, struct brmr_queue *q)
+{
+	struct brmr_cpu_qlist *cpu_q;
+	unsigned long flags;
+	bool added = true;
+	bool need_set;
+
+	cpu_q = get_cpu_ptr(pool->cpu_queues);
+	spin_lock_irqsave(&cpu_q->requeue_lock, flags);
+
+	if (likely(!test_and_set_bit_lock(0, &q->in_list))) {
+		if (WARN_ON(!list_empty(&q->requeue_list)))
+			goto unlock;
+
+		need_set = !test_bit(cpu_q->cpu, pool->cpu_queues_bm);
+		if (need_set) {
+			set_bit(cpu_q->cpu, pool->cpu_queues_bm);
+			/* Paired with brmr_put_iu(). Set a bit first
+			 * and then observe the busy counter.
+			 */
+			smp_mb__before_atomic();
+		}
+		if (likely(atomic_read(&pool->busy))) {
+			list_add_tail(&q->requeue_list, &cpu_q->requeue_list);
+		} else {
+			/* Very unlikely, but possible: busy counter was
+			 * observed as zero.  Drop all bits and return
+			 * false to restart the queue by ourselves.
+			 */
+			if (need_set)
+				clear_bit(cpu_q->cpu, pool->cpu_queues_bm);
+			clear_bit_unlock(0, &q->in_list);
+			added = false;
+		}
+	}
+unlock:
+	spin_unlock_irqrestore(&cpu_q->requeue_lock, flags);
+	put_cpu_ptr(pool->cpu_queues);
+
+	return added;
+}
+
diff --git a/drivers/block/brmr/brmr-clt-stats.c b/drivers/block/brmr/brmr-clt-stats.c
new file mode 100644
index 000000000000..de080fde779c
--- /dev/null
+++ b/drivers/block/brmr/brmr-clt-stats.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Block device over RMR (BRMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+//#include <linux/module.h>
+//#include <linux/blkdev.h>
+//#include <linux/hdreg.h>
+
+#include "brmr-clt.h"
+#include "rmr.h"
+#include "rmr-pool.h"
+
+
+int brmr_clt_init_stats(struct brmr_clt_stats *stats)
+{
+	stats->pcpu_stats = alloc_percpu(typeof(*stats->pcpu_stats));
+	if (unlikely(!stats->pcpu_stats))
+		return -ENOMEM;
+
+	return 0;
+}
+
+void brmr_clt_free_stats(struct brmr_clt_stats *stats)
+{
+	free_percpu(stats->pcpu_stats);
+}
+
+int brmr_clt_reset_submitted_req(struct brmr_clt_stats *stats, bool enable)
+{
+	struct brmr_stats_pcpu *s;
+	int cpu;
+
+	if (unlikely(!enable))
+		return -EINVAL;
+
+	for_each_possible_cpu(cpu) {
+		s = per_cpu_ptr(stats->pcpu_stats, cpu);
+		memset(&s->submitted_requests, 0,
+		       sizeof(s->submitted_requests));
+	}
+
+	return 0;
+}
+
+int brmr_clt_reset_req_sizes(struct brmr_clt_stats *stats, bool enable)
+{
+	struct brmr_stats_pcpu *s;
+	int cpu;
+
+	if (unlikely(!enable))
+		return -EINVAL;
+
+	for_each_possible_cpu(cpu) {
+		s = per_cpu_ptr(stats->pcpu_stats, cpu);
+		memset(&s->request_sizes, 0,
+		       sizeof(s->request_sizes));
+	}
+
+	return 0;
+}
+
+static void brmr_update_submitted_requests(struct brmr_stats_pcpu *s,
+					   size_t size, int split, int d)
+{
+	s->submitted_requests.dir[d].total_sectors += (size >> SECTOR_SHIFT);
+	if (split)
+		s->submitted_requests.dir[d].cnt_split++;
+	else
+		s->submitted_requests.dir[d].cnt_whole++;
+}
+
+#define MAX_LEN (128*1024)
+#define NUM_CLASSES 16
+#define CLASSIFY_SHIFT (ilog2(MAX_LEN)-ilog2(NUM_CLASSES))
+
+/**
+   classifies length linearly in 16 classes:
+
+   input length in bytes
+   
+   <    0x2000 (8K)
+   >=   0x2000 (8K)
+   >=   0x4000 (16K)
+   >=   0x6000 (24K)
+   >=   0x8000 (32K)
+   >=   0xa000 (40K)
+   >=   0xc000 (48K)
+   >=   0xe000 (56K)
+   >=  0x10000 (64K)
+   >=  0x12000 (72K)
+   >=  0x14000 (80K)
+   >=  0x16000 (88K)
+   >=  0x18000 (96K)
+   >=  0x1a000 (104K)
+   >=  0x1c000 (112K)
+   >=  0x1e000 (120K)
+
+   Maximum value is 128K-1.
+   However everything larger is classified as class 15 as well.
+*/
+static inline int classify(long length)
+{
+	return length < MAX_LEN ? (length >> CLASSIFY_SHIFT) : NUM_CLASSES-1;
+}
+
+static void brmr_update_request_sizes(struct brmr_stats_pcpu *s,
+				      size_t size, int split, int d)
+{
+	int size_class = classify(size);
+	switch (split) {
+	case 0:
+		s->request_sizes.dir[d].cnt_whole[size_class]++;
+		break;
+	case 1:
+		s->request_sizes.dir[d].cnt_left[size_class]++;
+		break;
+	case 2:
+		s->request_sizes.dir[d].cnt_right[size_class]++;
+		break;
+	default:
+		WARN_ONCE(true,"unexpected value for split");
+	}
+}
+
+void brmr_update_stats(struct brmr_clt_stats *stats, size_t size, int split, int d)
+{
+	struct brmr_stats_pcpu *s;
+
+	s = this_cpu_ptr(stats->pcpu_stats);
+
+	brmr_update_submitted_requests(s, size, split, d);
+	brmr_update_request_sizes(s, size, split, d);
+}
+
+ssize_t brmr_clt_stats_rq_to_str(struct brmr_clt_stats *stats, char *page, size_t len)
+{
+	struct brmr_stats_rq sum;
+	struct brmr_stats_rq *r;
+	int cpu; int d;
+
+	memset(&sum, 0, sizeof(sum));
+
+	for_each_possible_cpu(cpu) {
+		r = &per_cpu_ptr(stats->pcpu_stats, cpu)->submitted_requests;
+
+		for (d=READ; d<=WRITE; d++) {
+			sum.dir[d].cnt_whole      += r->dir[d].cnt_whole;
+			sum.dir[d].cnt_split      += r->dir[d].cnt_split;
+			sum.dir[d].total_sectors  += r->dir[d].total_sectors;
+		}
+	}
+
+	return scnprintf(page, len, "%llu %llu %llu %llu %llu %llu\n",
+			 sum.dir[READ].cnt_whole, sum.dir[READ].cnt_split,
+			 sum.dir[READ].total_sectors,
+			 sum.dir[WRITE].cnt_whole, sum.dir[WRITE].cnt_split,
+			 sum.dir[WRITE].total_sectors);
+}
+
+ssize_t brmr_clt_stats_sizes_to_str(struct brmr_clt_stats *stats, char *page, size_t len)
+{
+	struct brmr_stats_sizes *sum;
+	struct brmr_stats_sizes *per_cpu;
+	int cpu; int d; int i; int cnt = 0;
+
+	sum = kzalloc(sizeof(*sum), GFP_KERNEL);
+	if (unlikely(!sum))
+		return -ENOMEM;
+
+	for (i = 0; i < STATS_SIZES_NUM; i++) {
+		for_each_possible_cpu(cpu) {
+			per_cpu = &per_cpu_ptr(stats->pcpu_stats, cpu)
+				->request_sizes;
+
+			for (d=READ; d<=WRITE; d++) {
+				sum->dir[d].cnt_whole[i]
+					+= per_cpu->dir[d].cnt_whole[i];
+				sum->dir[d].cnt_left[i]
+					+= per_cpu->dir[d].cnt_left[i];
+				sum->dir[d].cnt_right[i]
+					+= per_cpu->dir[d].cnt_right[i];
+			}
+		}
+	}
+
+	cnt += scnprintf(page + cnt, len - cnt,
+		"         READ        "
+		"        whole                left               right               "
+		"\n");
+	if (len - cnt <= 0)
+		goto free_return;
+
+	cnt += scnprintf(page + cnt, len - cnt,
+			 "<=   8 Kbytes: %19llu %19llu %19llu\n",
+			 sum->dir[READ].cnt_whole[0],
+			 sum->dir[READ].cnt_left[0],
+			 sum->dir[READ].cnt_right[0]);
+
+	for (i = 1; i < STATS_SIZES_NUM; i++) {
+
+		cnt += scnprintf(page + cnt, len - cnt,
+				 ">  %3d Kbytes: %19llu %19llu %19llu\n",
+				 (i)<<3,
+				 sum->dir[READ].cnt_whole[i],
+				 sum->dir[READ].cnt_left[i],
+				 sum->dir[READ].cnt_right[i]);
+
+		if (len - cnt <= 0)
+			goto free_return;
+	}
+
+	cnt += scnprintf(page + cnt, len - cnt,
+		"\n        WRITE        "
+		"        whole                left               right               "
+		"\n");
+	if (len - cnt <= 0)
+		goto free_return;
+
+	cnt += scnprintf(page + cnt, len - cnt,
+			 "<=   8 Kbytes: %19llu %19llu %19llu\n",
+			 sum->dir[WRITE].cnt_whole[0],
+			 sum->dir[WRITE].cnt_left[0],
+			 sum->dir[WRITE].cnt_right[0]);
+
+	for (i = 1; i < STATS_SIZES_NUM; i++) {
+
+		cnt += scnprintf(page + cnt, len - cnt,
+				 ">  %3d Kbytes: %19llu %19llu %19llu\n",
+				 (i)<<3,
+				 sum->dir[WRITE].cnt_whole[i],
+				 sum->dir[WRITE].cnt_left[i],
+				 sum->dir[WRITE].cnt_right[i]);
+
+		if (len - cnt <= 0)
+			goto free_return;
+	}
+
+free_return:
+	kfree(sum);
+
+	return cnt;
+}
+
+int brmr_clt_reset_sts_resource(struct brmr_clt_stats *stats, bool enable)
+{
+	struct brmr_stats_pcpu *s;
+	int cpu;
+
+	if (unlikely(!enable))
+		return -EINVAL;
+
+	for_each_possible_cpu(cpu) {
+		s = per_cpu_ptr(stats->pcpu_stats, cpu);
+		memset(&s->sts_resource, 0,
+		       sizeof(s->sts_resource));
+	}
+
+	return 0;
+}
+
+void brmr_clt_update_sts_resource(struct brmr_clt_stats *stats, int which)
+{
+	struct brmr_stats_pcpu *s;
+
+	s = this_cpu_ptr(stats->pcpu_stats);
+	switch (which) {
+	case 0:
+		s->sts_resource.get_iu++;
+		break;
+	case 1:
+		s->sts_resource.get_iu2++;
+		break;
+	case 2:
+		s->sts_resource.clt_request1++;
+		break;
+	case 3:
+		s->sts_resource.clt_request++;
+		break;
+	default:
+		WARN_ONCE(true,"unexpected value for which");
+	}
+}
+
+ssize_t brmr_stats_sts_resource_to_str(
+	struct brmr_clt_stats *stats, char *page, size_t len)
+{
+	struct brmr_stats_sts_resource sum;
+	struct brmr_stats_sts_resource *r;
+	int cpu;
+
+	memset(&sum, 0, sizeof(sum));
+
+	for_each_possible_cpu(cpu) {
+		r = &per_cpu_ptr(stats->pcpu_stats, cpu)->sts_resource;
+
+		sum.get_iu       += r->get_iu;
+		sum.get_iu2      += r->get_iu2;
+		sum.clt_request1 += r->clt_request1;
+		sum.clt_request  += r->clt_request;
+	}
+
+	return scnprintf(page, len, "%llu %llu %llu %llu\n",
+			 sum.get_iu, sum.get_iu2,
+			 sum.clt_request1, sum.clt_request);
+}
+
+ssize_t brmr_stats_sts_resource_per_cpu_to_str(
+	struct brmr_clt_stats *stats, char *page, size_t len)
+{
+	struct brmr_stats_sts_resource *r;
+	int cpu; int cnt = 0;
+
+	for_each_possible_cpu(cpu) {
+		r = &per_cpu_ptr(stats->pcpu_stats, cpu)->sts_resource;
+
+		cnt += scnprintf(page+cnt, len, "%d %llu %llu %llu %llu\n",
+				 cpu, r->get_iu, r->get_iu2,
+				 r->clt_request1, r->clt_request);
+		if (len - cnt <= 0)
+			goto return_cnt;
+	}
+
+return_cnt:
+	return cnt;
+}
+
diff --git a/drivers/block/brmr/brmr-clt.c b/drivers/block/brmr/brmr-clt.c
new file mode 100644
index 000000000000..6f3d2dd2a9d9
--- /dev/null
+++ b/drivers/block/brmr/brmr-clt.c
@@ -0,0 +1,1222 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Block device over RMR (BRMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include <linux/module.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+#include <linux/uio.h>
+
+#include "brmr-clt.h"
+
+MODULE_AUTHOR("The RMR and BRMR developers");
+MODULE_VERSION(BRMR_VER_STRING);
+MODULE_DESCRIPTION("BRMR Block Device using RMR cluster");
+MODULE_LICENSE("GPL");
+
+/*
+ * Maximum number of partitions an instance can have.
+ * 6 bits = 64 minors = 63 partitions (one minor is used for the device itself)
+ */
+#define BRMR_PART_BITS		6
+
+static DEFINE_IDA(index_ida);
+static DEFINE_MUTEX(ida_lock);
+static DEFINE_MUTEX(brmr_device_lock);
+static LIST_HEAD(brmr_device_list);
+static int brmr_major;
+
+static int BRMR_DELAY_10ms   = 10;
+
+static int index_to_minor(int index)
+{
+	return index << BRMR_PART_BITS;
+}
+
+static int minor_to_index(int minor)
+{
+	return minor >> BRMR_PART_BITS;
+}
+
+static inline const char *rq_op_to_str(struct request *rq)
+{
+	switch (req_op(rq)) {
+	case REQ_OP_READ:
+		return "READ";
+	case REQ_OP_WRITE:
+		return "WRITE";
+	case REQ_OP_DISCARD:
+		return "DISCARD";
+	case REQ_OP_WRITE_ZEROES:
+		return "WRITE_ZEROES";
+	case REQ_OP_FLUSH:
+		return "FLUSH";
+	default:
+		return "UNKNOWN";
+	}
+	return "";
+}
+
+
+/* copy from blk.h */
+static inline bool biovec_phys_mergeable(struct request_queue *q,
+                struct bio_vec *vec1, struct bio_vec *vec2)
+{
+	unsigned long mask = queue_segment_boundary(q);
+	phys_addr_t addr1 = page_to_phys(vec1->bv_page) + vec1->bv_offset;
+	phys_addr_t addr2 = page_to_phys(vec2->bv_page) + vec2->bv_offset;
+
+	if (addr1 + vec1->bv_len != addr2)
+		return false;
+	// Comment out xen related code
+	/*
+	if (xen_domain() && !xen_biovec_phys_mergeable(vec1, vec2->bv_page))
+		return false;
+	*/
+	if ((addr1 | mask) != ((addr2 + vec2->bv_len - 1) | mask))
+		return false;
+	return true;
+}
+
+/* copy from blk_merge.c */
+static inline unsigned get_max_segment_size(const struct request_queue *q,
+                                            struct page *start_page,
+                                            unsigned long offset)
+{
+	unsigned long mask = queue_segment_boundary(q);
+
+	offset = mask & (page_to_phys(start_page) + offset);
+
+	/*
+	 * overflow may be triggered in case of zero page physical address
+	 * on 32bit arch, use queue's max segment size when that happens.
+	 */
+	return min_not_zero(mask - offset + 1,
+				(unsigned long)queue_max_segment_size(q));
+}
+
+static inline struct scatterlist *blk_next_sg(struct scatterlist **sg,
+                struct scatterlist *sglist)
+{
+        if (!*sg)
+                return sglist;
+
+        /*
+         * If the driver previously mapped a shorter list, we could see a
+         * termination bit prematurely unless it fully inits the sg table
+         * on each mapping. We KNOW that there must be more entries here
+         * or the driver would be buggy, so force clear the termination bit
+         * to avoid doing a full sg_init_table() in drivers for each command.
+         */
+        sg_unmark_end(*sg);
+        return sg_next(*sg);
+}
+
+/* only try to merge bvecs into one sg if they are from two bios */
+static inline bool
+__blk_segment_map_sg_merge(struct request_queue *q, struct bio_vec *bvec,
+                           struct bio_vec *bvprv, struct scatterlist **sg)
+{
+
+	int nbytes = bvec->bv_len;
+
+	if (!*sg)
+		return false;
+
+	if ((*sg)->length + nbytes > queue_max_segment_size(q))
+		return false;
+
+	if (!biovec_phys_mergeable(q, bvprv, bvec))
+		return false;
+
+	(*sg)->length += nbytes;
+
+	return true;
+}
+
+/*
+ * brmr_clt_get_iu() - Get an RMR I/O unit (iu)
+ *
+ * Description:
+ *	It gets an RMR I/O unit using rmr_clt_get_iu() and increments
+ *	the pool busy counter. It invokes rmr_clt_get_iu() with NO_WAIT
+ *	as brmr can requeue an I/O request.
+ *
+ *	Ref. brmr_add_to_requeue()
+ */
+static inline struct rmr_iu *brmr_clt_get_iu(struct brmr_clt_pool *pool, enum rmr_io_flags flag)
+{
+	struct rmr_iu *iu = rmr_clt_get_iu(pool->rmr, flag, NO_WAIT);
+	if (IS_ERR_OR_NULL(iu))
+		return iu;
+
+	atomic_inc(&pool->busy);
+
+	return iu;
+}
+
+/*
+ * brmr_clt_put_iu() - Put the RMR I/O unit (iu)
+ *
+ * Description:
+ *	It puts the RMR I/O unit using rmr_clt_put_iu() and decrements
+ *	the pool busy counter. It uses memory barrier to reflect the
+ *	busy counter.
+ *
+ *	Ref. brmr_add_to_requeue() and brmr_requeue_requests()
+ */
+static inline void brmr_clt_put_iu(struct brmr_clt_pool *pool, struct rmr_iu *iu)
+{
+	rmr_clt_put_iu(pool->rmr, iu);
+
+	atomic_dec(&pool->busy);
+	/*
+	 * Paired with brmr_add_to_requeue(). Decrement first
+	 * and then check queue bits.
+	 */
+	smp_mb__after_atomic();
+	brmr_requeue_requests(pool);
+}
+
+static void brmr_softirq_done_fn(struct request *rq)
+{
+	struct brmr_clt_iu *iu = blk_mq_rq_to_pdu(rq);
+	struct brmr_clt_dev *dev = iu->dev;
+
+	if (blk_rq_nr_phys_segments(rq))
+		sg_free_table_chained(&iu->sgt, BRMR_INLINE_SG_CNT);
+
+	brmr_clt_put_iu(dev->pool, iu->rmr_iu);
+	blk_mq_end_request(rq, iu->status);
+}
+
+static void brmr_request_conf(void *priv, int errno)
+{
+	struct brmr_clt_iu *iu = (struct brmr_clt_iu *)priv;
+	struct brmr_clt_dev *dev = iu->dev;
+	struct request *rq = iu->rq;
+
+	iu->status = (errno && errno != -ENOENT) ? BLK_STS_IOERR : BLK_STS_OK;
+
+	blk_mq_complete_request(rq);
+
+	if (errno == -ENOENT)
+		pr_debug("%s request for %s IGNORED err: %d\n",
+			 rq_op_to_str(rq), dev->gd->disk_name, errno);
+	else if (errno)
+		pr_err_ratelimited("%s request for %s failed with err: %d\n",
+				rq_op_to_str(rq), dev->gd->disk_name, errno);
+}
+
+static blk_status_t brmr_queue_rq(struct blk_mq_hw_ctx *hctx,
+				  const struct blk_mq_queue_data *bd)
+{
+	struct brmr_clt_dev *dev = bd->rq->q->disk->private_data;
+	struct brmr_clt_pool *pool = dev->pool;
+	struct brmr_clt_iu *iu = blk_mq_rq_to_pdu(bd->rq);
+	struct request *rq = bd->rq;
+	struct rmr_iu *rmr_iu;
+	unsigned int sg_cnt = 0;
+	size_t offset; size_t length;
+	enum rmr_io_flags flag;
+	unsigned short prio, seg;
+	int data_dir, err;
+	blk_status_t ret = BLK_STS_IOERR;
+
+	if (unlikely(dev->dev_state != DEV_STATE_READY))
+		return ret;
+
+	iu->rq = rq;
+	iu->dev = dev;
+
+	offset = blk_rq_pos(rq) << SECTOR_SHIFT;
+	length = blk_rq_bytes(rq);
+	flag = rq_to_rmr_flags(rq);
+	prio = req_get_ioprio(rq);
+	data_dir = rq_data_dir(rq);
+
+	rmr_iu = brmr_clt_get_iu(pool, flag);
+	if (unlikely(rmr_iu == NULL)) {
+		pr_debug("Got no tag to send a request to rmr_clt\n");
+
+		/* Increment statistic counter for it */
+		brmr_clt_update_sts_resource(&dev->stats, 0);
+
+		if (!brmr_add_to_requeue(pool, hctx->driver_data))
+			/*
+			 * TODO unlikely
+			 * Restarting queue with some delay is a stupid way
+			 * of handling resource contentions
+			 */
+			blk_mq_delay_run_hw_queue(hctx, BRMR_DELAY_10ms);
+
+		return BLK_STS_RESOURCE;
+	}
+	if (IS_ERR(rmr_iu)) {
+		pr_err("Error %pe when reserving resources for io in pool %s\n",
+		       rmr_iu, pool->rmr->poolname);
+		return BLK_STS_IOERR;
+	}
+	iu->rmr_iu = rmr_iu;
+
+	iu->sgt.sgl = iu->sgl;
+	seg = blk_rq_nr_phys_segments(rq);
+	if (seg) {
+		err = sg_alloc_table_chained(&iu->sgt, seg, iu->sgt.sgl, BRMR_INLINE_SG_CNT);
+		if (err) {
+			pr_err("sg_alloc_table_chained failed, ret=%x\n", err);
+			blk_mq_delay_run_hw_queue(hctx, BRMR_DELAY_10ms);
+			brmr_clt_put_iu(pool, rmr_iu);
+			return BLK_STS_RESOURCE;
+		}
+	}
+
+	/* We only support discards with single segment and write_zeroes request with no segment. */
+	/* See queue limits. */
+	if ((req_op(rq) != REQ_OP_DISCARD) && (req_op(rq) != REQ_OP_WRITE_ZEROES))
+		sg_cnt = blk_rq_map_sg(rq, iu->sgt.sgl);
+
+	blk_mq_start_request(rq);
+	brmr_update_stats(&dev->stats, length, 0, data_dir);
+
+	pr_debug("brmr %s request with flag %x offset %lu length %lu sg_cnt: %d\n",
+		 rq_op_to_str(rq), flag, offset, length, sg_cnt);
+
+	err = rmr_clt_request(pool->rmr, rmr_iu, offset, length, flag, prio,
+			      iu, brmr_request_conf, iu->sgt.sgl, sg_cnt);
+	if (likely(err == 0))
+		return BLK_STS_OK;
+
+	pr_err_ratelimited("sending %s request for %s failed with err: %d\n",
+			   rq_op_to_str(rq), dev->gd->disk_name, err);
+
+	if (unlikely(err == -EAGAIN || err == -ENOMEM)) {
+		pr_debug("Got resource error %d when sending a request to rmr_clt\n", err);
+
+		brmr_clt_update_sts_resource(&dev->stats, 3);
+		blk_mq_delay_run_hw_queue(hctx, BRMR_DELAY_10ms);
+
+		ret = BLK_STS_RESOURCE;
+	} else {
+		ret = BLK_STS_IOERR;
+	}
+
+	if (seg)
+		sg_free_table_chained(&iu->sgt, BRMR_INLINE_SG_CNT);
+
+	brmr_clt_put_iu(pool, rmr_iu);
+	return ret;
+}
+
+static struct blk_mq_ops brmr_mq_ops = {
+	.queue_rq	= brmr_queue_rq,
+	.complete	= brmr_softirq_done_fn,
+};
+
+static struct brmr_clt_pool *brmr_clt_create_pool(const char *poolname)
+{
+	struct brmr_clt_pool *pool;
+	int err;
+	struct rmr_attrs attrs;
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	pool->rmr = rmr_clt_open(pool, NULL, poolname);
+	if (IS_ERR_OR_NULL(pool->rmr)) {
+		err = PTR_ERR(pool->rmr);
+		goto free_pool;
+	}
+	err = rmr_clt_query(pool->rmr, &attrs);
+	if (unlikely(err))
+		goto close_rmr;
+
+	pool->queue_depth = attrs.queue_depth;
+	pool->max_io_size = attrs.max_io_size;
+	pool->chunk_size = attrs.chunk_size;
+	pool->max_segments = attrs.max_segments;
+
+	snprintf(pool->poolname, sizeof(pool->poolname), "%s", poolname);
+
+	/*
+	 * When opening a new pool, allocate mq tags for that pool - they are
+	 * going to be shared among all devices opened in that pool
+	 */
+	pool->tag_set.ops		= &brmr_mq_ops;
+	pool->tag_set.queue_depth	= pool->queue_depth;
+	pool->tag_set.numa_node		= NUMA_NO_NODE;
+	pool->tag_set.flags		= BLK_MQ_F_TAG_QUEUE_SHARED;
+	pool->tag_set.cmd_size		= sizeof(struct brmr_clt_iu) + BRMR_RDMA_SGL_SIZE;
+	pool->tag_set.nr_hw_queues	= num_online_cpus();
+
+	err = blk_mq_alloc_tag_set(&pool->tag_set);
+	if (unlikely(err))
+		goto close_rmr;
+
+	refcount_set(&pool->refcount, 1);
+
+	atomic_set(&pool->busy, 0);
+	bitmap_zero(pool->cpu_queues_bm, NR_CPUS);
+	pool->cpu_rr = alloc_percpu(int);
+	if (unlikely(!pool->cpu_rr)) {
+		pr_err("Failed to alloc percpu var (cpu_rr)\n");
+		err = -ENOMEM;
+		goto free_tag_set;
+	}
+	pool->cpu_queues = alloc_percpu(struct brmr_cpu_qlist);
+	if (unlikely(!pool->cpu_queues)) {
+		pr_err("Failed to alloc percpu var (cpu_queues)\n");
+		err = -ENOMEM;
+		goto free_cpu_rr;
+	}
+	brmr_init_cpu_qlists(pool->cpu_queues);
+	return pool;
+free_cpu_rr:
+	free_percpu(pool->cpu_rr);
+free_tag_set:
+	blk_mq_free_tag_set(&pool->tag_set);
+close_rmr:
+	rmr_clt_close(pool->rmr);
+free_pool:
+	kfree(pool);
+
+	return ERR_PTR(err);
+}
+
+static void brmr_clt_free_pool(struct brmr_clt_pool *pool)
+{
+	free_percpu(pool->cpu_queues);
+	pool->cpu_queues = NULL;
+	free_percpu(pool->cpu_rr);
+	pool->cpu_rr = NULL;
+	blk_mq_free_tag_set(&pool->tag_set);
+	rmr_clt_close(pool->rmr);
+	kfree(pool);
+}
+
+static void brmr_clt_put_pool(struct brmr_clt_pool *pool)
+{
+	if (refcount_dec_and_test(&pool->refcount))
+		brmr_clt_free_pool(pool);
+	else
+		rmr_clt_put_pool(pool->rmr);
+}
+
+static inline bool brmr_clt_get_dev(struct brmr_clt_dev *dev)
+{
+	return refcount_inc_not_zero(&dev->refcount);
+}
+
+void brmr_clt_put_dev(struct brmr_clt_dev *dev)
+{
+	might_sleep();
+
+	if (refcount_dec_and_test(&dev->refcount)) {
+
+		mutex_lock(&ida_lock);
+		ida_free(&index_ida, dev->idx);
+		mutex_unlock(&ida_lock);
+
+		kfree(dev->hw_queues);
+
+		brmr_clt_put_pool(dev->pool);
+
+		if (!list_empty(&dev->list)) {
+			mutex_lock(&brmr_device_lock);
+			list_del(&dev->list);
+			mutex_unlock(&brmr_device_lock);
+		}
+		kfree(dev);
+	}
+}
+
+static int brmr_open(struct gendisk *disk, blk_mode_t mode)
+{
+	struct brmr_clt_dev *dev = disk->private_data;
+
+	if (READ_ONCE(dev->dev_state) != DEV_STATE_READY)
+		return -EIO;
+
+	if (!brmr_clt_get_dev(dev))
+		return -EIO;
+
+	return 0;
+}
+
+static void brmr_release(struct gendisk *gen)
+{
+	struct brmr_clt_dev *dev = gen->private_data;
+
+	brmr_clt_put_dev(dev);
+}
+
+#if 0
+static int brmr_getgeo(struct block_device *block_device,
+		       struct hd_geometry *geo)
+{
+	struct brmr_clt_dev *dev = block_device->bd_disk->private_data;
+
+	geo->cylinders	= (dev->size_sect & ~0x3f) >> 6;	/* size/64 */
+	geo->heads	= 4;
+	geo->sectors	= 16;
+	geo->start	= 0;
+
+	return 0;
+}
+#endif
+
+static const struct block_device_operations brmr_ops = {
+	.owner		= THIS_MODULE,
+	.open		= brmr_open,
+	.release	= brmr_release,
+	/*.getgeo		= brmr_getgeo,*/
+};
+
+/**
+ * brmr_clt_init_cmd() - Initialize message command
+ *
+ * @msg:	command message where to init
+ */
+static void brmr_clt_init_cmd(struct brmr_msg_cmd *msg)
+{
+	memset(msg, 0, sizeof(*msg));
+
+	msg->hdr.type = cpu_to_le16(BRMR_MSG_CMD);
+	msg->hdr.__padding = 0;
+	msg->ver = BRMR_PROTO_VER_MAJOR;
+}
+
+/**
+ * brmr_cmd_conf() - Confirmation function for brmr command message
+ *
+ * @priv:	priv pointer to brmr command private data
+ * @errno:	error number passed from RMR.
+ *		See description of errno in RMR function.
+ *
+ * Description:
+ *	Command response for a map new command can fail on multiple levels.
+ *	If RMR fails to send the message to any or one of the nodes, that would reflect on the
+ *	errno. If the command fails on BRMR level, that would reflect on the rsp struct.
+ *	The error number will be used differently by different commands accordingly.
+ */
+static void brmr_clt_cmd_conf(void *priv, int errno)
+{
+	struct brmr_cmd_priv *cmd_priv = (struct brmr_cmd_priv *)priv;
+
+	switch (cmd_priv->cmd_type) {
+	case BRMR_CMD_MAP:
+		pr_info("%s: BRMR_CMD_MAP err=%d\n", __func__, errno);
+		cmd_priv->errno = errno;
+		break;
+	case BRMR_CMD_REMAP:
+		pr_info("%s: BRMR_CMD_REMAP err=%d\n", __func__, errno);
+		break;
+	case BRMR_CMD_UNMAP:
+		pr_info("%s: BRMR_CMD_UNMAP err=%d\n", __func__, errno);
+		/*
+		 * No processing needed here.
+		 */
+		break;
+	case BRMR_CMD_GET_PARAMS:
+		pr_info("%s: BRMR_CMD_GET_PARAMS err=%d\n", __func__, errno);
+		if (errno)
+			cmd_priv->errno = errno;
+		break;
+
+	default:
+		pr_err("%s: Unknown command type %d err=%d\n", __func__, cmd_priv->cmd_type, errno);
+	}
+
+	complete(&cmd_priv->complete_done);
+}
+
+/**
+ * brmr_clt_send_msg_cmd() - Sends command message to rmr pool
+ *
+ * @dev:		pointer to brmr device
+ * @msg:		msg struct to be sent
+ * @rsp_buf:		response buffer where the response of the storage side is stored
+ * @rsp_buf_len:	length of the response buffer
+ *
+ * Return:
+ *	Negative if failed to sent command
+ *	As handled by each command in brmr_clt_cmd_conf, if succeeded to send command
+ *
+ * Context:
+ *	Would block until response is received
+ */
+static int brmr_clt_send_msg_cmd(struct brmr_clt_dev *dev, struct brmr_msg_cmd *msg, void *rsp_buf,
+			     size_t rsp_buf_len)
+{
+	struct brmr_cmd_priv cmd_priv;
+	struct kvec vec;
+	int ret;
+
+	vec = (struct kvec) {
+		.iov_base = msg,
+		.iov_len  = sizeof(*msg)
+	};
+
+	cmd_priv.dev = dev;
+	cmd_priv.cmd_type = msg->cmd_type;
+	cmd_priv.rsp_buf = rsp_buf;
+	cmd_priv.rsp_buf_len = rsp_buf_len;
+	cmd_priv.errno = 0;
+	init_completion(&cmd_priv.complete_done);
+
+	ret = rmr_clt_cmd_with_rsp(dev->pool->rmr, brmr_clt_cmd_conf, &cmd_priv, &vec, 1, rsp_buf,
+				   rsp_buf_len, sizeof(struct brmr_msg_cmd_rsp));
+
+	if (!ret) {
+		wait_for_completion(&cmd_priv.complete_done);
+		ret = cmd_priv.errno;
+	}
+
+	return ret;
+}
+
+static struct brmr_clt_dev *brmr_alloc_and_init_dev(struct brmr_clt_pool *pool,
+						u64 size)
+{
+	struct brmr_clt_dev *dev;
+	struct brmr_queue *q;
+	struct blk_mq_hw_ctx *hctx;
+	int ret;
+	unsigned long i;
+
+	/*
+	 * alloc device structure
+	 */
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&dev->list);
+	dev->size_sect = size;
+	dev->pool = pool;
+	dev->dev_state = DEV_STATE_INIT;
+	dev->map_incomplete = false;
+	refcount_set(&dev->refcount, 1);
+
+	/*
+	 * Alloc a "queue" per cpu
+	 */
+	dev->hw_queues = kcalloc(nr_cpu_ids,
+				 sizeof(*dev->hw_queues), GFP_KERNEL);
+	if (unlikely(!dev->hw_queues)) {
+		ret = -ENOMEM;
+		goto free_dev;
+	}
+
+	/*
+	 * Get an id to be used in /dev/brmr<idx>
+	 */
+	mutex_lock(&ida_lock);
+	ret = ida_alloc_range(&index_ida, 0, minor_to_index(1 << MINORBITS) - 1,
+			      GFP_KERNEL);
+	mutex_unlock(&ida_lock);
+	if (ret < 0) {
+		pr_err("%s: ida_alloc_range() failed for pool %s, err: %d\n",
+		       __func__, pool->poolname, ret);
+		goto free_queues;
+	}
+	dev->idx = ret;
+
+	/*
+	 * Init mq queue
+	 */
+	dev->gd = blk_mq_alloc_disk(&pool->tag_set, NULL, dev);
+	if (IS_ERR(dev->gd)) {
+		ret = PTR_ERR(dev->gd);
+		pr_err("Failed to initialize mq: %pe\n", dev->queue);
+		goto remove_ida;
+	}
+	dev->queue = dev->gd->queue;
+
+	/*
+	 * Assign hardware contexts to our queues
+	 */
+	queue_for_each_hw_ctx(dev->queue, hctx, i) {
+		q = &dev->hw_queues[i];
+		INIT_LIST_HEAD(&q->requeue_list);
+		q->hctx = hctx;
+		hctx->driver_data = q;
+	}
+
+	return dev;
+
+remove_ida:
+	mutex_lock(&ida_lock);
+	ida_free(&index_ida, dev->idx);
+	mutex_unlock(&ida_lock);
+free_queues:
+	kfree(dev->hw_queues);
+free_dev:
+	kfree(dev);
+out:
+	return ERR_PTR(ret);
+}
+
+static int brmr_set_dev_params(struct brmr_clt_dev *dev)
+{
+	struct brmr_clt_pool *pool = dev->pool;
+	u32 chunk_size = brmr_pool_chunk_size(pool);
+	struct queue_limits lim;
+	int ret;
+
+	/* Aligns requests with the chunks in rmr client */
+	if (!is_power_of_2(chunk_size >> SECTOR_SHIFT)) {
+		pr_err("%u not a power of 2!\n", chunk_size);
+		return -EINVAL;
+	}
+
+	/*
+	 * Set request queue parameters via queue_limits API
+	 */
+	lim = queue_limits_start_update(dev->queue);
+	lim.logical_block_size = dev->logical_block_size;
+	lim.physical_block_size = dev->physical_block_size;
+	lim.max_segments = dev->max_segments;
+	lim.max_hw_sectors = dev->max_hw_sectors;
+	lim.max_write_zeroes_sectors = dev->max_write_zeroes_sectors;
+	lim.io_opt = brmr_pool_chunk_size(pool);
+	lim.chunk_sectors = chunk_size >> SECTOR_SHIFT;
+
+	/* however we don't support discards to */
+	/* discontiguous segments in one request */
+	lim.max_discard_segments = 1;
+	lim.max_hw_discard_sectors = dev->max_discard_sectors;
+	if (dev->secure_discard)
+		lim.max_secure_erase_sectors = dev->max_discard_sectors;
+
+	lim.discard_granularity = dev->discard_granularity;
+	lim.discard_alignment = dev->discard_alignment;
+
+	/* needed for ibtrs_map_sg_fr to work */
+	lim.virt_boundary_mask = SZ_4K - 1;
+
+	/* non-rotational device */
+	lim.features &= ~BLK_FEAT_ROTATIONAL;
+
+	if (dev->wc)
+		lim.features |= BLK_FEAT_WRITE_CACHE;
+	if (dev->fua)
+		lim.features |= BLK_FEAT_FUA;
+
+	ret = queue_limits_commit_update(dev->queue, &lim);
+	if (ret)
+		goto err;
+
+	blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, dev->queue);
+	blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, dev->queue);
+
+	ret = brmr_clt_init_stats(&dev->stats);
+	if (unlikely(ret))
+		goto err;
+
+	dev->gd->major = brmr_major;
+	dev->gd->minors = 1 << BRMR_PART_BITS;
+	dev->gd->first_minor = index_to_minor(dev->idx);
+	dev->gd->fops = &brmr_ops;
+	dev->gd->queue = dev->queue;
+	dev->gd->private_data = dev;
+	snprintf(dev->gd->disk_name, sizeof(dev->gd->disk_name),
+		 "brmr%d", dev->idx);
+	set_capacity(dev->gd, dev->size_sect);
+
+	return 0;
+
+err:
+	return ret;
+}
+
+/**
+ * brmr_get_remote_dev_params() - Gets device params from storage nodes
+ *
+ * @dev:		pointer to brmr device
+ *
+ * Description:
+ *	Does the following (sanity) checks
+ *	1) For an unmapped device, param get should succeed on all legs
+ *	2) There should not be a mixture of mapped and unmapped devices
+ *
+ *	In addition to above, it also does the following work
+ *	1) For a mapped device, read from a single leg is enough for success
+ *	2) For an unmapped device, it does validation checks for params for every leg
+ *
+ * Return:
+ *	Negative in case of failure
+ *	0 for success, and a non-mapped device is found
+ *	1 for success, and a mapped device is found
+ *
+ * Context:
+ *	Would block until response is received
+ */
+static int brmr_get_remote_dev_params(struct brmr_clt_dev *dev)
+{
+	struct brmr_clt_pool *pool = dev->pool;
+	struct brmr_msg_cmd msg;
+	struct brmr_msg_cmd_rsp *brmr_cmd_rsp;
+	void *rsp_buf;
+	size_t rsp_buf_len;
+	int err = 0, i;
+	bool partial_fail = false, mapped = false;
+
+	brmr_clt_init_cmd(&msg);
+	msg.cmd_type = BRMR_CMD_GET_PARAMS;
+
+	rsp_buf_len = sizeof(struct brmr_msg_cmd_rsp) * RMR_POOL_MAX_SESS;
+	rsp_buf = kzalloc(rsp_buf_len, GFP_KERNEL);
+	if (!rsp_buf)
+		return -ENOMEM;
+
+	err = brmr_clt_send_msg_cmd(dev, &msg, rsp_buf, rsp_buf_len);
+	if (err < 0) {
+		pr_err("%s: brmr_clt_send_msg_cmd failed with errno %d\n", __func__, err);
+		goto free_data;
+	} else if (err) {
+		/*
+		 * We cannot directly fail here, since we do not know if this is a map for a
+		 * newly created device, or for one which has gone through mapping before.
+		 *
+		 * For the former, any failure should end in the whole map process failing.
+		 * For the latter, a single read from a device with mapped state set should
+		 * be enough for us to go ahead and map.
+		 */
+		partial_fail = true;
+	}
+
+	/*
+	 * Lets do the sanity check first, because combining it with param checks makes the
+	 * entire loop harder to read
+	 */
+	for (i = 0; i < RMR_POOL_MAX_SESS; i++) {
+		struct brmr_cmd_get_params_rsp *get_params_rsp;
+
+		brmr_cmd_rsp = ((struct brmr_msg_cmd_rsp *)rsp_buf) + i;
+
+		/*
+		 * We do not need to worry about not seeing MAGIC.
+		 * This would happen for a non-working sessions, OR
+		 * for extra sessions in the end for which there are no legs in RMR (Don't care)
+		 *
+		 * For non-working sessions, we will be notified by RMR through the return value
+		 */
+		if (brmr_cmd_rsp->magic != BRMR_CMD_RSP_MAGIC)
+			continue;
+
+		/*
+		 * This is error returned by rmr-store.
+		 */
+		if (brmr_cmd_rsp->status)
+			partial_fail = true;
+
+		get_params_rsp = &brmr_cmd_rsp->get_params_rsp;
+
+		/*
+		 * If we find a mapped device, we save that info.
+		 */
+		if (get_params_rsp->mapped)
+			mapped = true;
+	}
+
+	/*
+	 * If there is no device mapped, it means that this is the first map after device creation
+	 * In such a case, we need all sessions to be up and running.
+	 */
+	if (mapped == false && partial_fail) {
+		pr_err("%s: Mapping first time, but got failure for some sessions\n", __func__);
+		err = -EINVAL;
+		goto free_data;
+	}
+
+	for (i = 0; i < RMR_POOL_MAX_SESS; i++) {
+		struct brmr_cmd_get_params_rsp *get_params_rsp;
+		struct brmr_blk_dev_params *rsp_dev_params;
+
+		brmr_cmd_rsp = ((struct brmr_msg_cmd_rsp *)rsp_buf) + i;
+
+		/*
+		 * We are tracking partial failures through the above loop, so
+		 * ignore it here.
+		 */
+		if (brmr_cmd_rsp->magic != BRMR_CMD_RSP_MAGIC ||
+		    brmr_cmd_rsp->status)
+			continue;
+
+		get_params_rsp = &brmr_cmd_rsp->get_params_rsp;
+
+		/*
+		 * We cheat a little, and do this sanity check here.
+		 *
+		 * If even a single device was mapped, and we have sessions with non-mapped
+		 * devices, it will be wrong to go forward with brmr map.
+		 */
+		if (mapped && !get_params_rsp->mapped) {
+			/*
+			 * This can only happen if a node went down and up.
+			 * And instead of re-adding a MAPPED device, a create was called
+			 * We cannot allow map this way, since this means discard could
+			 * have been skipped.
+			 */
+			pr_err("%s: Mixed combination of mapped+unmapped metadata found\n",
+			       __func__);
+			err = -EINVAL;
+			goto free_data;
+		}
+
+		/*
+		 * The device size_sect, which is the size provided by the user in the map
+		 * command, should be same as the mapped_size of every storage node's backend
+		 * device, which was provided during create_store.
+		 */
+		if (dev->size_sect != le64_to_cpu(get_params_rsp->mapped_size)) {
+			pr_err("%s: Mismatched mapped_size: (Provide) %llu != %llu (Remote)\n",
+			       __func__, dev->size_sect, le64_to_cpu(get_params_rsp->mapped_size));
+			err = -EINVAL;
+			goto free_data;
+		}
+
+		rsp_dev_params = &get_params_rsp->dev_params;
+
+		dev->max_write_zeroes_sectors = min_not_zero(
+						dev->max_write_zeroes_sectors,
+						le32_to_cpu(
+						rsp_dev_params->max_write_zeroes_sectors));
+		dev->max_discard_sectors = min_not_zero(brmr_pool_chunk_size(pool) >> SECTOR_SHIFT,
+						le32_to_cpu(rsp_dev_params->max_discard_sectors));
+		dev->physical_block_size = max_t(u16, dev->physical_block_size,
+						 le16_to_cpu(rsp_dev_params->physical_block_size));
+		dev->logical_block_size = max_t(u16, dev->logical_block_size,
+						le16_to_cpu(rsp_dev_params->logical_block_size));
+
+		dev->discard_granularity = dev->logical_block_size;
+		dev->discard_alignment = dev->logical_block_size;
+
+		/* secure_discard is actually true or false, but since we used
+		 * __le16 to transfer this value in msg, min_t should work fine here
+		 */
+		dev->secure_discard = min_t(u16, dev->secure_discard,
+					    le16_to_cpu(rsp_dev_params->secure_discard));
+
+		dev->cache_policy = rsp_dev_params->cache_policy;
+		dev->wc = !!(rsp_dev_params->cache_policy & BRMR_WRITEBACK);
+		dev->fua = !!(rsp_dev_params->cache_policy & BRMR_FUA);
+	}
+
+	/* max segments and max_hw_sectors we get from rtrs sessions values
+	 * stored in pool like in RNBD, not from bdev of the store side.
+	 */
+	dev->max_segments = pool->max_segments;
+	dev->max_hw_sectors = pool->max_io_size / SECTOR_SIZE;
+
+	/*
+	 * Return whether its a new map or an old one
+	 */
+	err = mapped;
+
+free_data:
+	kfree(rsp_buf);
+
+	return err;
+}
+
+/**
+ * brmr_clt_send_map_cmd() - Sends map command for a brmr device
+ *
+ * @dev:	pointer to brmr device
+ *
+ * Return:
+ *	Negative error value in case of failure
+ *	0 on success
+ *
+ * Context:
+ *	Would block until response is received
+ */
+static int brmr_clt_send_map_cmd(struct brmr_clt_dev *dev)
+{
+	struct brmr_clt_pool *pool = dev->pool;
+	struct brmr_msg_cmd msg;
+	struct brmr_blk_dev_params *dev_params = &(msg.map_new_cmd.dev_params);
+	void *rsp_buf;
+	size_t rsp_buf_len;
+	int err = 0;
+
+	brmr_clt_init_cmd(&msg);
+	msg.cmd_type = BRMR_CMD_MAP;
+
+	rsp_buf_len = sizeof(struct brmr_msg_cmd_rsp) * RMR_POOL_MAX_SESS;
+	rsp_buf = kzalloc(rsp_buf_len, GFP_KERNEL);
+	if (!rsp_buf)
+		return -ENOMEM;
+
+	msg.map_new_cmd.version = BRMR_CURRENT_HEADER_VERSION;
+	msg.map_new_cmd.mapped_size = dev->size_sect;
+
+	dev_params->max_hw_sectors = cpu_to_le32(dev->max_hw_sectors);
+	dev_params->max_write_zeroes_sectors = cpu_to_le32(dev->max_write_zeroes_sectors);
+	dev_params->max_discard_sectors = cpu_to_le32(dev->max_discard_sectors);
+	dev_params->discard_granularity = cpu_to_le32(dev->discard_granularity);
+	dev_params->discard_alignment = cpu_to_le32(dev->discard_alignment);
+	dev_params->physical_block_size = cpu_to_le16(dev->physical_block_size);
+	dev_params->logical_block_size = cpu_to_le16(dev->logical_block_size);
+	dev_params->max_segments = cpu_to_le16(dev->max_segments);
+	dev_params->secure_discard = cpu_to_le16(dev->secure_discard);
+	dev_params->cache_policy = dev->cache_policy;
+
+	err = brmr_clt_send_msg_cmd(dev, &msg, rsp_buf, rsp_buf_len);
+	if (err)
+		pr_err("Failed to send cmd msg BRMR_CMD_MAP in pool %s, err=%d\n",
+		       pool->poolname, err);
+
+	kfree(rsp_buf);
+	return err;
+}
+
+/*
+ * brmr_clt_send_unmap_cmd() - Send an unmap command to the server pool
+ *
+ * Sending may fail (e.g. no sessions connected). The failure is logged but
+ * not propagated — callers always continue with local cleanup regardless.
+ */
+static void brmr_clt_send_unmap_cmd(struct brmr_clt_dev *dev)
+{
+	struct brmr_msg_cmd msg;
+	void *rsp_buf;
+	size_t rsp_buf_len;
+	int ret;
+
+	brmr_clt_init_cmd(&msg);
+	msg.cmd_type = BRMR_CMD_UNMAP;
+
+	rsp_buf_len = sizeof(struct brmr_msg_cmd_rsp) * RMR_POOL_MAX_SESS;
+	rsp_buf = kzalloc(rsp_buf_len, GFP_KERNEL);
+	if (!rsp_buf) {
+		pr_err("Failed to alloc rsp_buf for unmap in pool %s\n",
+		       dev->pool->poolname);
+		return;
+	}
+
+	/*
+	 * Sending messages could fail. For example, there are no client pool sessions
+	 * connected to this pool. Unmap_dev still progresses and cleans up the device
+	 * states on the client side.
+	 */
+	ret = brmr_clt_send_msg_cmd(dev, &msg, rsp_buf, rsp_buf_len);
+	if (ret)
+		pr_err("Error %d when unmap device in pool %s\n",
+		       ret, dev->pool->poolname);
+
+	kfree(rsp_buf);
+}
+
+/**
+ * brmr_clt_map_device() - Maps brmr device through an rmr pool
+ *
+ * @id:	Id for the device
+ * @poolname:	rmr poolname which is to be used for mapping
+ * @size:	Size of the disk
+ *
+ * Description:
+ *	Opens rmr pool with pool name "poolname"
+ *	Allocated brmr device and initializes it
+ *	Maps brmr device using the rmr pool only if its not already mapped
+ *
+ * Return:
+ *	Pointer to allocated and mapped brmr device on success
+ *	Error pointer on failure
+ */
+struct brmr_clt_dev *brmr_clt_map_device(const char *poolname, u64 size)
+{
+	struct brmr_clt_pool *pool = NULL;
+	struct brmr_clt_dev *dev;
+	int ret, mapped;
+
+	/* Create brmr pool */
+	pool = brmr_clt_create_pool(poolname);
+	if (IS_ERR(pool)) {
+		ret = PTR_ERR(pool);
+		goto err_out;
+	}
+
+	/* Alloc device */
+	dev = brmr_alloc_and_init_dev(pool, size);
+	if (IS_ERR(dev)) {
+		pr_err("Error %pe allocating brmr device in pool %s\n",
+			dev, pool->poolname);
+		brmr_clt_put_pool(pool);
+		ret = PTR_ERR(dev);
+		goto err_out;
+	}
+
+	mapped = brmr_get_remote_dev_params(dev);
+	if (mapped < 0) {
+		pr_err("Failed to get remote devs block params in pool %s, err=%d\n",
+		       pool->poolname, mapped);
+		ret = mapped;
+		goto dest_dev;
+	}
+
+	/* Set device params */
+	ret = brmr_set_dev_params(dev);
+	if (unlikely(ret)) {
+		pr_err("Error %d brmr_set_dev_params in pool %s\n",
+		       ret, pool->poolname);
+		goto dest_dev;
+	}
+
+	/*
+	 * We send map command only if its a new map.
+	 * This must happen before add_disk() so the server is ready to serve
+	 * I/O by the time the kernel probes the partition table.
+	 */
+	if (!mapped) {
+		pr_info("%s: Sending map command through pool %s\n", __func__, pool->poolname);
+		ret = brmr_clt_send_map_cmd(dev);
+		if (ret) {
+			pr_err("Failed to send map cmd to pool %s, err=%d\n",
+			       pool->poolname, ret);
+			goto put_disk;
+		}
+	}
+
+	dev->dev_state = DEV_STATE_READY;
+
+	/*
+	 * Add gendisk
+	 */
+	ret = add_disk(dev->gd);
+	if (ret) {
+		pr_err("%s: add_disk failed with err %d\n", __func__, ret);
+		goto unmap_dev;
+	}
+
+	mutex_lock(&brmr_device_lock);
+	list_add(&dev->list, &brmr_device_list);
+	mutex_unlock(&brmr_device_lock);
+
+	return dev;
+
+unmap_dev:
+	dev->dev_state = DEV_STATE_INIT;
+	if (!mapped)
+		brmr_clt_send_unmap_cmd(dev);
+put_disk:
+	put_disk(dev->gd);
+	brmr_clt_free_stats(&dev->stats);
+dest_dev:
+	brmr_clt_put_dev(dev);
+err_out:
+	return ERR_PTR(ret);
+}
+
+static void destroy_gen_disk(struct brmr_clt_dev *dev)
+{
+	unsigned int memflags;
+
+	del_gendisk(dev->gd);
+	/*
+	 * Before marking queue as dying (blk_cleanup_queue() does that)
+	 * we have to be sure that everything in-flight has gone.
+	 * Blink with freeze/unfreeze.
+	 */
+	memflags = blk_mq_freeze_queue(dev->queue);
+	blk_mq_unfreeze_queue(dev->queue, memflags);
+	put_disk(dev->gd);
+}
+
+/**
+ * brmr_clt_close_device() - Closes a brmr device
+ *
+ * @dev:		pointer to brmr device to close
+ * @sysfs_self:	pointer to sysfs attribute
+ *
+ * Return:
+ *	0 in case of success
+ *	negative in case of failure
+ */
+int brmr_clt_close_device(struct brmr_clt_dev *dev,
+		      const struct attribute *sysfs_self)
+{
+	dev->dev_state = DEV_STATE_CLOSING;
+	destroy_gen_disk(dev);
+	brmr_clt_send_unmap_cmd(dev);
+	sysfs_remove_link(&dev->kobj, BRMR_LINK_NAME);
+
+	if (sysfs_self)
+		brmr_clt_destroy_dev_sysfs_files(dev, sysfs_self);
+
+	brmr_clt_free_stats(&dev->stats);
+	brmr_clt_put_dev(dev);
+
+	return 0;
+}
+
+struct brmr_clt_dev *find_and_get_device(const char *name)
+{
+	struct brmr_clt_dev *dev;
+
+	mutex_lock(&brmr_device_lock);
+	list_for_each_entry(dev, &brmr_device_list, list) {
+		if (strncasecmp(dev->pool->poolname, name, NAME_MAX))
+			continue;
+
+		if (brmr_clt_get_dev(dev)) {
+			mutex_unlock(&brmr_device_lock);
+			return dev;
+		}
+	}
+	mutex_unlock(&brmr_device_lock);
+
+	return NULL;
+}
+
+static int __init brmr_client_init(void)
+{
+	int err;
+
+	pr_info("Loading module %s, version %s\n",
+		KBUILD_MODNAME, BRMR_VER_STRING);
+
+	brmr_major = register_blkdev(brmr_major, "brmr");
+	if (brmr_major <= 0) {
+		pr_err("Failed to load module,"
+		       " block device registration failed\n");
+		err = -EBUSY;
+		goto out;
+	}
+
+	err = brmr_clt_create_sysfs_files();
+out:
+	return err;
+}
+
+static void __exit brmr_client_exit(void)
+{
+	struct brmr_clt_dev *dev, *tmp;
+
+	pr_info("Unloading module\n");
+
+	brmr_clt_destroy_sysfs_files();
+	unregister_blkdev(brmr_major, "brmr");
+
+	list_for_each_entry_safe(dev, tmp, &brmr_device_list, list) {
+		brmr_clt_close_device(dev, NULL);
+	}
+
+	ida_destroy(&index_ida);
+
+	pr_info("Module %s unloaded\n", KBUILD_MODNAME);
+}
+
+module_init(brmr_client_init);
+module_exit(brmr_client_exit);
-- 
2.43.0


