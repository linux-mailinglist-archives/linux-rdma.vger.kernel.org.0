Return-Path: <linux-rdma+bounces-1157-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE23386A09C
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 21:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D4BB22ADE
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E86814A095;
	Tue, 27 Feb 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DNbAUla7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307AD149E13;
	Tue, 27 Feb 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709064034; cv=none; b=TblhL8vZfarfxaNHXaulPCydRjpIfc9I4WZZYzLGunZjQMRlGDKEBU2psz03GEmt7cS6YGk115Kl74v/YDr3HZO6OV6aMjp4E9gSQWx1mmV5GdHyCf0XAnmY1dlBPQNEKZqZOW/t/bE0/DA0f0r85srNtnrZ9NGw6b6ZTL/nzpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709064034; c=relaxed/simple;
	bh=qN5L2PGsTQDXHqMBD1e0lPG74QqIglLLcjIiJj0SYpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VYilfSy9C83lsepvnVcmCcXNR9EiFoE+aejFVF/YNf0hzX9vAReG4r0v+7tM7phE3gCo9Z5ufP63qKzb5A23VbpCbuo2VEi+nDExnjRC+DjFlxICpuNRbSxTucNGrXCo3daNmNoK4Vah0U3cqZu0tUFoQIBcGMitSPVftzjUBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DNbAUla7; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41RFYXq3007452;
	Tue, 27 Feb 2024 20:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=y6O98lHszAGPvBLwNIUE/BqlQQTZxbNIpPnzH6KjfQo=;
 b=DNbAUla7t50OPjccyBAKSK3of9X8aSP6Ef3WWXtrklUP7TYm9vYWxDSdZ9rFTn58DrYG
 Ows+UOoMJdpCZcGAFYwfeJBO1B8zyl4XZKcBY8Dxbc5OXhb/zhm1fQ9mpMXw2qnNi0xc
 +sYU/ZcGlDvkoPa35XnJR5nzVHKt0sm4k+GxEYS2mfBXYltAFukDt8ofQOQeollHy4Uq
 PtViNSACv4v+qccDWYJauNWVMHs/okLzKk6pFxoNEza/ZTIShhoyOlfKlUy0+IbRiY/F
 9pG/9jYTZjii0F4neQvdiTArGJGOFpHcVkIh/XwrlT2Bvp62vEi2aqeXo6tN6qolueL9 5Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90v88et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 20:00:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41RJpvXn022324;
	Tue, 27 Feb 2024 20:00:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w80t82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 20:00:26 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41RJo1MX036408;
	Tue, 27 Feb 2024 20:00:25 GMT
Received: from mbpatil.us.oracle.com (mbpatil.us.oracle.com [10.211.44.53])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3wf6w80t76-1;
	Tue, 27 Feb 2024 20:00:25 +0000
From: Manjunath Patil <manjunath.b.patil@oracle.com>
To: dledford@redhat.com, jgg@ziepe.ca
Cc: manjunath.b.patil@oracle.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, rama.nichanamatlu@oracle.com
Subject: [PATCH RFC] RDMA/cm: add timeout to cm_destroy_id wait
Date: Tue, 27 Feb 2024 12:00:17 -0800
Message-Id: <20240227200017.308719-1-manjunath.b.patil@oracle.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_07,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270155
X-Proofpoint-GUID: _JW5GF8p2fQTKM1jVIloorocTAordXkc
X-Proofpoint-ORIG-GUID: _JW5GF8p2fQTKM1jVIloorocTAordXkc

Add timeout to cm_destroy_id, so that userspace can trigger any data
collection that would help in analyzing the cause of delay in destroying
the cm_id.

New noinline function helps dtrace/ebpf programs to hook on to it.
Existing functionality isn't changed except triggering a probe-able new
function at every timeout interval.

We have seen cases where CM messages stuck with MAD layer (either due to
software bug or faulty HCA), leading to cm_id getting stuck in the
following call stack. This patch helps in resolving such issues faster.

kernel: ... INFO: task XXXX:56778 blocked for more than 120 seconds.
...
	Call Trace:
	__schedule+0x2bc/0x895
	schedule+0x36/0x7c
	schedule_timeout+0x1f6/0x31f
 	? __slab_free+0x19c/0x2ba
	wait_for_completion+0x12b/0x18a
	? wake_up_q+0x80/0x73
	cm_destroy_id+0x345/0x610 [ib_cm]
	ib_destroy_cm_id+0x10/0x20 [ib_cm]
	rdma_destroy_id+0xa8/0x300 [rdma_cm]
	ucma_destroy_id+0x13e/0x190 [rdma_ucm]
	ucma_write+0xe0/0x160 [rdma_ucm]
	__vfs_write+0x3a/0x16d
	vfs_write+0xb2/0x1a1
	? syscall_trace_enter+0x1ce/0x2b8
	SyS_write+0x5c/0xd3
	do_syscall_64+0x79/0x1b9
	entry_SYSCALL_64_after_hwframe+0x16d/0x0

Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
---
 drivers/infiniband/core/cm.c | 38 +++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index ff58058aeadc..03f7b80efa77 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -34,6 +34,20 @@ MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("InfiniBand CM");
 MODULE_LICENSE("Dual BSD/GPL");
 
+static unsigned long cm_destroy_id_wait_timeout_sec = 10;
+
+static struct ctl_table_header *cm_ctl_table_header;
+static struct ctl_table cm_ctl_table[] = {
+	{
+		.procname	= "destroy_id_wait_timeout_sec",
+		.data		= &cm_destroy_id_wait_timeout_sec,
+		.maxlen		= sizeof(cm_destroy_id_wait_timeout_sec),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+	{ }
+};
+
 static const char * const ibcm_rej_reason_strs[] = {
 	[IB_CM_REJ_NO_QP]			= "no QP",
 	[IB_CM_REJ_NO_EEC]			= "no EEC",
@@ -1025,10 +1039,20 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
 	}
 }
 
+static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id)
+{
+	struct cm_id_private *cm_id_priv;
+
+	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
+	pr_err("%s: cm_id=%p timed out. state=%d refcnt=%d\n", __func__,
+	       cm_id, cm_id->state, refcount_read(&cm_id_priv->refcount));
+}
+
 static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 {
 	struct cm_id_private *cm_id_priv;
 	struct cm_work *work;
+	int ret;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 	spin_lock_irq(&cm_id_priv->lock);
@@ -1135,7 +1159,14 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 
 	xa_erase(&cm.local_id_table, cm_local_id(cm_id->local_id));
 	cm_deref_id(cm_id_priv);
-	wait_for_completion(&cm_id_priv->comp);
+	do {
+		ret = wait_for_completion_timeout(&cm_id_priv->comp,
+						  msecs_to_jiffies(
+				cm_destroy_id_wait_timeout_sec * 1000));
+		if (!ret) /* timeout happened */
+			cm_destroy_id_wait_timeout(cm_id);
+	} while (!ret);
+
 	while ((work = cm_dequeue_work(cm_id_priv)) != NULL)
 		cm_free_work(work);
 
@@ -4505,6 +4536,10 @@ static int __init ib_cm_init(void)
 	ret = ib_register_client(&cm_client);
 	if (ret)
 		goto error3;
+	cm_ctl_table_header = register_net_sysctl(&init_net,
+						  "net/ib_cm", cm_ctl_table);
+	if (!cm_ctl_table_header)
+		pr_warn("ib_cm: couldn't register sysctl path, using default values\n");
 
 	return 0;
 error3:
@@ -4522,6 +4557,7 @@ static void __exit ib_cm_cleanup(void)
 		cancel_delayed_work(&timewait_info->work.work);
 	spin_unlock_irq(&cm.lock);
 
+	unregister_net_sysctl_table(cm_ctl_table_header);
 	ib_unregister_client(&cm_client);
 	destroy_workqueue(cm.wq);
 
-- 
2.31.1


