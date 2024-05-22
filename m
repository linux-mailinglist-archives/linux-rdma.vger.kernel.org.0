Return-Path: <linux-rdma+bounces-2566-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913C58CB9CE
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 05:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 133FAB20F5E
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 03:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B805757E5;
	Wed, 22 May 2024 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C6ufm12+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3989C59164;
	Wed, 22 May 2024 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716348787; cv=none; b=oA6FFUjRkiURa2BEtkKnpZ94/S+oHr8gJJnsBcEran90+F/QoaSGg2WXlxzPQxyZGSOHM/CPqBxCXKia6b3ncjnSeRd1/1A+UJm1eh/vL9KWwb4uOt35qPyZY05Y0s7hvn8XuHYwgDfMAq3c4/VWESp27LcLDgVJYjrrwPbVhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716348787; c=relaxed/simple;
	bh=iuuZJXrFrNKqeeoRTHs82WCLhFbK1VJJiwtPlqfft7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9I9c3Q2g//Zgstf5J7/g7Ip8XKiitngMGKSL90GS9OM/M8uLaqRV8TDBhokCqMqaXBDIs3W+zltP/PAu7CaEzUv7cMaJnZ6Kv5nZ7595PDc1pk8g1HfJInkRX8H3/TAjl147ecx5DMRtN9eohb9ucc33+JbX7TVjH4r93Ccso8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C6ufm12+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LJi8lG025719;
	Wed, 22 May 2024 03:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=WXPQXG3ga8mm2ljb+JMmK7k5okNCYKOKStlDO844RHc=;
 b=C6ufm12+pROTeAsLmzp35q1lVe26N9VgV48KjcCSBLBfOymqIPnKDIeZER/kColLbyD4
 bKR0qiGPZVJigjmCwD0kSdPAM8ZWaObvDseVp9/ub3hUZqrBNYEUP3OSvB20+UFCfgGZ
 4oCGPWy1/l4aS4lP2n2dqojeWJEZz/IKApYx6EfW9JdAOwLrvEsEGe1tdgO9sOS2vElY
 8xDMx02J8XhuMGmCf4An0moFRb/mBnuucc23z2L3Eu2KYYvqXoO+vgKMrsGTaoyQCqqJ
 /wTw91sfHL2fn+R6dThdNl0dyf4BxroLQNAqlYFEfWLrw9Gw+aja5aW3aH4Zd1NjwUwB Xg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k466sgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 03:33:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44M1mWu3038361;
	Wed, 22 May 2024 03:33:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsem89u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 03:33:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44M3Txaj038463;
	Wed, 22 May 2024 03:33:02 GMT
Received: from aakhoje-ol.in.oracle.com (dhcp-10-76-55-136.vpn.oracle.com [10.76.55.136])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6jsem88e-2;
	Wed, 22 May 2024 03:33:02 +0000
From: Anand Khoje <anand.a.khoje@oracle.com>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: anand.a.khoje@oracle.com, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com
Subject: [PATCH 1/1] RDMA/mlx5: Release CPU for other processes in mlx5_free_cmd_msg()
Date: Wed, 22 May 2024 09:02:56 +0530
Message-Id: <20240522033256.11960-2-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240522033256.11960-1-anand.a.khoje@oracle.com>
References: <20240522033256.11960-1-anand.a.khoje@oracle.com>
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
 definitions=2024-05-22_01,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220024
X-Proofpoint-ORIG-GUID: PMZWDmO3h572zzxDYir1mFSCitkE0IfX
X-Proofpoint-GUID: PMZWDmO3h572zzxDYir1mFSCitkE0IfX

In non FLR context, at times CX-5 requests release of ~8 million device pages.
This needs humongous number of cmd mailboxes, which to be released once
the pages are reclaimed. Release of humongous number of cmd mailboxes
consuming cpu time running into many secs, with non preemptable kernels
is leading to critical process starving on that cpu’s RQ. To alleviate
this, this patch relinquishes cpu periodically but conditionally.

Orabug: 36275016

Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 9c21bce..9fbf25d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1336,16 +1336,23 @@ static struct mlx5_cmd_msg *mlx5_alloc_cmd_msg(struct mlx5_core_dev *dev,
 	return ERR_PTR(err);
 }
 
+#define RESCHED_MSEC 2
 static void mlx5_free_cmd_msg(struct mlx5_core_dev *dev,
 			      struct mlx5_cmd_msg *msg)
 {
 	struct mlx5_cmd_mailbox *head = msg->next;
 	struct mlx5_cmd_mailbox *next;
+	unsigned long start_time = jiffies;
 
 	while (head) {
 		next = head->next;
 		free_cmd_box(dev, head);
 		head = next;
+		if (time_after(jiffies, start_time + msecs_to_jiffies(RESCHED_MSEC))) {
+			mlx5_core_warn_rl(dev, "Spent more than %d msecs, yielding CPU\n", RESCHED_MSEC);
+			cond_resched();
+			start_time = jiffies;
+		}
 	}
 	kfree(msg);
 }
-- 
1.8.3.1


