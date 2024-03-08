Return-Path: <linux-rdma+bounces-1331-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050B2875BA1
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Mar 2024 01:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5788BB21B26
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Mar 2024 00:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C84F21353;
	Fri,  8 Mar 2024 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cS2E3nzt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1588F21105;
	Fri,  8 Mar 2024 00:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709859361; cv=none; b=L39FmmQ9mMsy3k7Fih6FPc5dwJNWCgonXwVL8jzOgyjmct/+p3GMRZNdXLl9gbk4AHvX8bJbOloETYtneHF/2mwqBY/Oqzt0LD/lsSmxwJ8w7SuX1YKF6kFLzWtsN/5lXjL1daj2nCJlpulKj6wM3gLFdqg4cczFBLTH2ECC7fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709859361; c=relaxed/simple;
	bh=EoD/N7fyy6v3G07GLxBqUhJ65YYXjv4B0t9Gs9DK9KY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YxNNsie4jOfjb6jxBLTXRFNnVuQ7DTqjyBh/Ll4/5Zdl33L+maejn2t1Q0AD990uTyejUaiWSNrf3P0FRC/+TiSmrPQr5nYdk3MyKMWRT22FfFfscqE5Y9hgByoSxdAji2c22NE9aXk54tpIFAncwJgYA/UigFBgBc19DMz/INA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cS2E3nzt; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427JiHs3019537;
	Fri, 8 Mar 2024 00:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=iJqdbRpjEP9Anm7UG3DB2OPgXYyaZ6u1AAaa+B1m9xQ=;
 b=cS2E3nzto7hWNLCpjAajLTrBRTl+urpmQvDdVXCMYXmgJoEDykOx0PCnCqGq6pvSAq/O
 TOGnUCoQqelVk5gudH5w/WVDj8fY+f8XDZwjPBvus4gr+vCc9AozECGhmwJJEuvz8M2c
 FmZcmuviv+fj4zR0FHTNA7O6WVMFWnvbS997qm5M92nFqRlB4SqY+5Lv7KDofV57K2ta
 hpt6BcVjT8sNCFzVt9PxJvHL7bG40LQz8jVDM7QpA2I7B+nEr13iI7YgjDA0ugUNQCOz
 SXSXVcZ5c8H1G6qboU8AvBmpjgADyg1Du6HbIQSpHdAhmgkmt5K3/TQDFK0GJXUIEKB1 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1cmtk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 00:55:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42804JE4027502;
	Fri, 8 Mar 2024 00:55:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjchx1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 00:55:55 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4280tt2U031590;
	Fri, 8 Mar 2024 00:55:55 GMT
Received: from mbpatil.us.oracle.com (mbpatil.us.oracle.com [10.211.44.53])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3wktjchx18-1;
	Fri, 08 Mar 2024 00:55:55 +0000
From: Manjunath Patil <manjunath.b.patil@oracle.com>
To: dledford@redhat.com, jgg@ziepe.ca
Cc: manjunath.b.patil@oracle.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, rama.nichanamatlu@oracle.com
Subject: [PATCH] RDMA/cm: add timeout to cm_destroy_id wait
Date: Thu,  7 Mar 2024 16:55:53 -0800
Message-Id: <20240308005553.440065-1-manjunath.b.patil@oracle.com>
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
 definitions=2024-03-07_18,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080005
X-Proofpoint-ORIG-GUID: c3XN_BC7ZM1TM6zc6QL0zHRQN2hSfuV7
X-Proofpoint-GUID: c3XN_BC7ZM1TM6zc6QL0zHRQN2hSfuV7

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

Orabug: 36280065

Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
---
 drivers/infiniband/core/cm.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index ff58058aeadc..00a16b08c7e2 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -34,6 +34,7 @@ MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("InfiniBand CM");
 MODULE_LICENSE("Dual BSD/GPL");
 
+static unsigned long cm_destroy_id_wait_timeout_sec = 10;
 static const char * const ibcm_rej_reason_strs[] = {
 	[IB_CM_REJ_NO_QP]			= "no QP",
 	[IB_CM_REJ_NO_EEC]			= "no EEC",
@@ -1025,10 +1026,20 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
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
@@ -1135,7 +1146,14 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 
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
 
-- 
2.31.1


