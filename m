Return-Path: <linux-rdma+bounces-2577-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728588CC280
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 15:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E119F1F243F9
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 13:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C22141995;
	Wed, 22 May 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wa+rZaRe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDC61411F8;
	Wed, 22 May 2024 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386112; cv=none; b=un1mAZN+q5netJ4+ONH0EPSQR22pI6le51r7SRmm01E5T0+y114QdDLt8z8IUaoMHJl1/sjule4tDzvS7YLZQX24SP88A5siSFrNOgGzbbw4JbQWEziKZ/K0qXHWzWKaCpLqt9nreTgCg3Uh3GFNjRktgOqqFtMKcrPVkpqW/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386112; c=relaxed/simple;
	bh=Fv4RgdofNF0g1JF1RNb7kP1z5vab40UP16jtAY2qMKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+fYvpcU2F56TPWHTuL4cqPtDgWMQQ/eo6RhYCgYuC3rlcCwB4CyBhgln1mpdiZ3k4YB7VJiPD1yVOKRKTZDxn+DYie/Pd6lG1c2Xq2eqKa6CTkkWDSqCCQMUrU/fTzavHomBjWz5cctx6scE3FUzgicshmPNsHTgUukuHSInek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wa+rZaRe; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCqd0G013793;
	Wed, 22 May 2024 13:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=cjEST1jMAgisAXPjhkC6jVf+PoUCWzwnDuoQDxOX6/o=;
 b=Wa+rZaReQlz/5ZMOaVX0p4JEkqiySf9/aqo3lRo3aY+Ei/FC255TnJ/HWlonXpNIDUSW
 pSR16H2Y+37pgifh3wjlaMzQff7xiL+koB7m/llJZUY9PAvXW/elZHByQTz9J5frk38m
 3Rnd+jLiL9s1Cx45yS0SWtJI6VNq3Fk9e1QbSwj4Ze6/9WxofOh1mAjoVmXVlqi7YEVS
 gbF3NN1ZRRF7YjsRU5+lN8meYdlgVvt7Rh81x8PeKSt7WdwS1fvCxVJir6E/LL0vUqJB
 LiBKk+IfWUFdMNlMnRzgJX7KtHD1W4HYiBE11L45L2oUo6CzLJT970SZg6dd94xTE5aI Cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mcdyt5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:54:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MDEjnA019603;
	Wed, 22 May 2024 13:54:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js98t0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:54:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MDsm2q016070;
	Wed, 22 May 2024 13:54:55 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js98su1-3;
	Wed, 22 May 2024 13:54:55 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rds-devel@oss.oracle.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Mark Zhang <markzhang@nvidia.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH v3 1/6] workqueue: Inherit per-process allocation flags
Date: Wed, 22 May 2024 15:54:34 +0200
Message-Id: <20240522135444.1685642-3-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240522135444.1685642-1-haakon.bugge@oracle.com>
References: <20240522135444.1685642-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_07,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405220093
X-Proofpoint-ORIG-GUID: QnE95IRACn-0412yPTR0rINuSd72tkji
X-Proofpoint-GUID: QnE95IRACn-0412yPTR0rINuSd72tkji

For drivers/modules running inside a memalloc_flags_{save,restore}
region, if a work-queue is created, we make sure work executed on the
work-queue inherits the same flag(s).

This in order to conditionally enable drivers to work aligned with
block I/O devices. This commit makes sure that any work queued later
on work-queues created during module initialization, when current's
flags has any of the PF_MEMALLOC* set, will inherit the same flags.

We do this in order to enable drivers to be used as a network block
I/O device. This in order to support XFS or other file-systems on top
of a raw block device which uses said drivers as the network transport
layer.

Under intense memory pressure, we get memory reclaims. Assume the
file-system reclaims memory, goes to the raw block device, which calls
into said drivers. Now, if regular GFP_KERNEL allocations in the
drivers require reclaims to be fulfilled, we end up in a circular
dependency.

We break this circular dependency by:

1. Force all allocations in the drivers to use GFP_NOIO, by means of a
   parenthetic use of memalloc_flags_{save,restore} on all relevant
   entry points, setting/clearing the PF_MEMALLOC_NOIO bit.

2. Make sure work-queues inherits current->flags
   wrt. PF_MEMALLOC_NOIO, such that work executed on the
   work-queue inherits the same flag(s). That is what this commit
   contributes with.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

v2 -> v3:
   * Add support for all PF_MEMALLOC* flags
   * Re-worded commit message

v1 -> v2:
   * Added missing hunk in alloc_workqueue()
---
 include/linux/workqueue.h |  9 ++++++
 kernel/workqueue.c        | 60 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index fb39938945365..f8c87f824272b 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -406,9 +406,18 @@ enum wq_flags {
 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
+	__WQ_MEMALLOC		= 1 << 19, /* internal: execute work with MEMALLOC */
+	__WQ_MEMALLOC_NOFS      = 1 << 20, /* internal: execute work with MEMALLOC_NOFS */
+	__WQ_MEMALLOC_NOIO      = 1 << 21, /* internal: execute work with MEMALLOC_NOIO */
+	__WQ_MEMALLOC_NORECLAIM = 1 << 22, /* internal: execute work with MEMALLOC_NORECLAIM */
+	__WQ_MEMALLOC_NOWARN    = 1 << 23, /* internal: execute work with MEMALLOC_NOWARN */
+	__WQ_MEMALLOC_PIN	= 1 << 24, /* internal: execute work with MEMALLOC_PIN */
 
 	/* BH wq only allows the following flags */
 	__WQ_BH_ALLOWS		= WQ_BH | WQ_HIGHPRI,
+
+	__WQ_PF_MEMALLOC_MASK	= PF_MEMALLOC | PF_MEMALLOC_NOFS | PF_MEMALLOC_NOIO |
+				  PF_MEMALLOC_NORECLAIM | PF_MEMALLOC_NOWARN | PF_MEMALLOC_PIN,
 };
 
 enum wq_consts {
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 003474c9a77d0..28ed6b9556e91 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -51,6 +51,7 @@
 #include <linux/uaccess.h>
 #include <linux/sched/isolation.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/mm.h>
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
 #include <linux/delay.h>
@@ -3113,6 +3114,28 @@ static bool manage_workers(struct worker *worker)
 	return true;
 }
 
+static unsigned int wq_build_memalloc_flags(struct pool_workqueue *pwq)
+{
+	unsigned int pf_flags = 0;
+
+#define BUILD_PF_FLAGS_FROM_WQ(name)			\
+	do {						\
+		if (pwq->wq->flags & __WQ_ ## name)	\
+			pf_flags |= PF_ ## name;	\
+	} while (0)
+
+	BUILD_PF_FLAGS_FROM_WQ(MEMALLOC);
+	BUILD_PF_FLAGS_FROM_WQ(MEMALLOC_NOFS);
+	BUILD_PF_FLAGS_FROM_WQ(MEMALLOC_NOIO);
+	BUILD_PF_FLAGS_FROM_WQ(MEMALLOC_NORECLAIM);
+	BUILD_PF_FLAGS_FROM_WQ(MEMALLOC_NOWARN);
+	BUILD_PF_FLAGS_FROM_WQ(MEMALLOC_PIN);
+
+#undef BUILD_PF_FLAGS_FROM_WQ
+
+	return pf_flags;
+}
+
 /**
  * process_one_work - process single work
  * @worker: self
@@ -3136,6 +3159,8 @@ __acquires(&pool->lock)
 	unsigned long work_data;
 	int lockdep_start_depth, rcu_start_depth;
 	bool bh_draining = pool->flags & POOL_BH_DRAINING;
+	unsigned int memalloc_flags = wq_build_memalloc_flags(pwq);
+	unsigned int memalloc_flags_old;
 #ifdef CONFIG_LOCKDEP
 	/*
 	 * It is permissible to free the struct work_struct from
@@ -3148,6 +3173,10 @@ __acquires(&pool->lock)
 
 	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
 #endif
+	/* Set inherited alloc flags */
+	if (memalloc_flags)
+		memalloc_flags_old = memalloc_flags_save(memalloc_flags);
+
 	/* ensure we're on the correct CPU */
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
 		     raw_smp_processor_id() != pool->cpu);
@@ -3284,6 +3313,10 @@ __acquires(&pool->lock)
 
 	/* must be the last step, see the function comment */
 	pwq_dec_nr_in_flight(pwq, work_data);
+
+	/* Restore alloc flags */
+	if (memalloc_flags)
+		memalloc_flags_restore(memalloc_flags_old);
 }
 
 /**
@@ -5637,6 +5670,30 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 	} while (activated);
 }
 
+/**
+ * wq_set_memalloc_flags - Test current->flags for PF_MEMALLOC_FOO_BAR
+ * flag bits and set the corresponding __WQ_MEMALLOC_FOO_BAR in the
+ * WQ's flags variable.
+ * @flags_ptr: Pointer to wq->flags
+ */
+static void wq_set_memalloc_flags(unsigned int *flags_ptr)
+{
+#define TEST_PF_SET_WQ(name)				\
+	do {						\
+		if (current->flags & PF_ ## name)	\
+			*flags_ptr |= __WQ_ ## name;	\
+	} while (0)
+
+	TEST_PF_SET_WQ(MEMALLOC);
+	TEST_PF_SET_WQ(MEMALLOC_NOFS);
+	TEST_PF_SET_WQ(MEMALLOC_NOIO);
+	TEST_PF_SET_WQ(MEMALLOC_NORECLAIM);
+	TEST_PF_SET_WQ(MEMALLOC_NOWARN);
+	TEST_PF_SET_WQ(MEMALLOC_PIN);
+
+#undef TEST_PF_SET_WQ
+}
+
 __printf(1, 4)
 struct workqueue_struct *alloc_workqueue(const char *fmt,
 					 unsigned int flags,
@@ -5695,6 +5752,9 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	/* init wq */
 	wq->flags = flags;
+	if (current->flags & __WQ_PF_MEMALLOC_MASK)
+		wq_set_memalloc_flags(&wq->flags);
+
 	wq->max_active = max_active;
 	wq->min_active = min(max_active, WQ_DFL_MIN_ACTIVE);
 	wq->saved_max_active = wq->max_active;
-- 
2.31.1


