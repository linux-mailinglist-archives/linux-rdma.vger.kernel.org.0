Return-Path: <linux-rdma+bounces-2494-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052298C6697
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 14:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6403B1F22055
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 12:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D9127B45;
	Wed, 15 May 2024 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P7mc4APK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3578E82860;
	Wed, 15 May 2024 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777663; cv=none; b=IK7nyROKa1bvMmRA/YI0AUwa4EBuD8dSCpyIgwQiLC34kxrTVkQWokRBLhY7ZQb2OXxKTNHpmT3Xp/cpoR7IUbbDHZ+1ftF2j62B5NZaNFRHA6WPvvKWm52Yf2ux/QiikbTDbKc+8O5dOqiGQP3M+gHLQ74TXgwZ3fA1nYovEtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777663; c=relaxed/simple;
	bh=MIxN3WKFAODN7v/HXRR/ds7aPZze5HQV8ktUpU9r0F0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkE7+y7gnISfAPLmROeZ8pTjDUCFpb1E2nRKLs4k6tj2tw35e6LjNl3e/Fn8xpbb9MuYEXqrSzHWsSE6aFxlK/dDCJzOm5fD2SwelgkNrlJ3VQrbhqoxiXkvHTcmJUNpRIQtwiiT53kOETKTpT+iS2K3vOgRFHJme2JlRp68bEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P7mc4APK; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44F7nsbN023517;
	Wed, 15 May 2024 12:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=vu11EeMFysr0s0X80qX6ZZNyhjciJQ++IXjrRGklOts=;
 b=P7mc4APK1I6HcyPO6LgBCnhV+8uWWO8hALvsD6ANMfvT2zceJJ09V0sWu04q9gHgAXkz
 uiGIUdK3CbHlCTEK2v7P2EKG2kmmkQt9OtoejRs4gmMNXoZHwCywINDyLnVa9C0BHjV6
 2MChULgUIOabFDkccXM1Ei1V9zelAzPZ+nNAdgmT+8xVT2qz0OT1HQMb9qFBdN6a6+IU
 KcJRo8KdLVX2BC9TxBT3PMUqefUxxsawHCdgzn4T7JlMkFXT8t0mluhpkbCi1z4qvgZO
 HyWTSKf+324KFOSGF67F/Ctl3/gZZiPzLQdoirSDTeGSbXKIQIrYpabqohHr4MDEgPpL 0A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx34rwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 12:54:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44FCZeHJ038274;
	Wed, 15 May 2024 12:53:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y24pxgujk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 12:53:53 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44FCmlra038458;
	Wed, 15 May 2024 12:53:52 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y24pxgud9-2;
	Wed, 15 May 2024 12:53:52 +0000
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
Subject: [PATCH v2 1/6] workqueue: Inherit NOIO and NOFS alloc flags
Date: Wed, 15 May 2024 14:53:37 +0200
Message-Id: <20240515125342.1069999-2-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240515125342.1069999-1-haakon.bugge@oracle.com>
References: <20240515125342.1069999-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_06,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405150090
X-Proofpoint-GUID: MZWHxKg_o9YJ2gNopnjKutRdnNNRyYBR
X-Proofpoint-ORIG-GUID: MZWHxKg_o9YJ2gNopnjKutRdnNNRyYBR

For drivers/modules running inside a
memalloc_{noio,nofs}_{save,restore} region, if a work-queue is
created, we make sure work executed on the work-queue inherits the
same flag(s).

This in order to conditionally enable drivers to work aligned with
block I/O devices. This commit makes sure that any work queued later
on work-queues created during module initialization, when current's
flags has PF_MEMALLOC_{NOIO,NOFS} set, will inherit the same flags.

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
   parenthetic use of memalloc_noio_{save,restore} on all relevant
   entry points.

2. Make sure work-queues inherits current->flags
   wrt. PF_MEMALLOC_{NOIO,NOFS}, such that work executed on the
   work-queue inherits the same flag(s). That is what this commit
   contributes with.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

v1 -> v2:
   * Added missing hunk in alloc_workqueue()
---
 include/linux/workqueue.h |  2 ++
 kernel/workqueue.c        | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 158784dd189ab..09ecc692ffcae 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -398,6 +398,8 @@ enum wq_flags {
 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
+	__WQ_NOIO               = 1 << 19, /* internal: execute work with NOIO */
+	__WQ_NOFS               = 1 << 20, /* internal: execute work with NOFS */
 
 	/* BH wq only allows the following flags */
 	__WQ_BH_ALLOWS		= WQ_BH | WQ_HIGHPRI,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index d2dbe099286b9..8eb7562372ce2 100644
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
@@ -3172,6 +3173,10 @@ __acquires(&pool->lock)
 	unsigned long work_data;
 	int lockdep_start_depth, rcu_start_depth;
 	bool bh_draining = pool->flags & POOL_BH_DRAINING;
+	bool use_noio_allocs = pwq->wq->flags & __WQ_NOIO;
+	bool use_nofs_allocs = pwq->wq->flags & __WQ_NOFS;
+	unsigned long noio_flags;
+	unsigned long nofs_flags;
 #ifdef CONFIG_LOCKDEP
 	/*
 	 * It is permissible to free the struct work_struct from
@@ -3184,6 +3189,12 @@ __acquires(&pool->lock)
 
 	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
 #endif
+	/* Set inherited alloc flags */
+	if (use_noio_allocs)
+		noio_flags = memalloc_noio_save();
+	if (use_nofs_allocs)
+		nofs_flags = memalloc_nofs_save();
+
 	/* ensure we're on the correct CPU */
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
 		     raw_smp_processor_id() != pool->cpu);
@@ -3320,6 +3331,12 @@ __acquires(&pool->lock)
 
 	/* must be the last step, see the function comment */
 	pwq_dec_nr_in_flight(pwq, work_data);
+
+	/* Restore alloc flags */
+	if (use_nofs_allocs)
+		memalloc_nofs_restore(nofs_flags);
+	if (use_noio_allocs)
+		memalloc_noio_restore(noio_flags);
 }
 
 /**
@@ -5583,6 +5600,10 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	/* init wq */
 	wq->flags = flags;
+	if (current->flags & PF_MEMALLOC_NOIO)
+		wq->flags |= __WQ_NOIO;
+	if (current->flags & PF_MEMALLOC_NOFS)
+		wq->flags |= __WQ_NOFS;
 	wq->max_active = max_active;
 	wq->min_active = min(max_active, WQ_DFL_MIN_ACTIVE);
 	wq->saved_max_active = wq->max_active;
-- 
2.45.0


