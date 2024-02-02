Return-Path: <linux-rdma+bounces-863-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134DC846BAB
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 10:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AB51C26F89
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 09:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1124977650;
	Fri,  2 Feb 2024 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="giqW65Tt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18EA605DB;
	Fri,  2 Feb 2024 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865372; cv=none; b=bucqx/RDWSpY9FjeS/A4lx8FsVjiMfV3TAr6FSYJa31qQqTGVwdwVOAsR+SCmaIJIT7pFCAojg+pGDvhMIWJXwETrkGSpo46jKsc4OP4ysgDB2HuiRoFrU8Jf08kX/jBpKWK7VP2trDC1N4qxu6JMJbYy8IGAOWuoBxhQePWJ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865372; c=relaxed/simple;
	bh=jupD0jZ+G5XPKvqrDMiFv55S/1T9122VpUTg6FgOS4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l7WxU0rAF0GYjqBKLYSHps+GZ8MrDQ4AOEsNC3EyYViZGmARtU+Q247gr48wtnm7wTsG6JVXu5/jdGnOzsvV9rtwF1KQHco+e7m8a7FZctk3IcIbNHW1CxKWVufAWyP0eWEtdeZlFaN9BGASR7S77k8Ht4tYq224nygU42sG7ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=giqW65Tt; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4128TqlG019825;
	Fri, 2 Feb 2024 09:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=0s58srxMlt0tFYwCA04+jek/EjXJpoI5doi8EjmkYNI=;
 b=giqW65TtJnR5Ae5X4x1EaI+SxsTlfKGd+ikMqVHSB7e788P8YCwEddhuTI3Az89uSaQc
 Znr+op6exf/jf+/Cz2hqFChoNhp/fnvvX62AUJlTblVpJpWrvY9i4dB/U+Zvl5iK7g7w
 3VwDGgKlntZPA8EM7o0bFZMxgD6zxa0V53TmMNwkxidORji3W98u0+jPoxRiEJbMBMuQ
 2+0wOQcFJA6IHtozkRTjcHB28vVmE3FOQr4bfpHlJMU1d9X9Zk6ZAmGXd+OKKMvPS9pe
 PqXnpesupj0goNb6UNZ/uf42Pp/s3S20kXpfghMekTsknnBNIOwTuFx4quxljtjRDPFc yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrcq5rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 09:16:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4128flO4005480;
	Fri, 2 Feb 2024 09:16:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9hnqjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 09:16:06 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4129G2Gd000955;
	Fri, 2 Feb 2024 09:16:05 GMT
Received: from brm-x62-14.us.oracle.com (brm-x62-14.us.oracle.com [10.80.150.231])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9hnqd6-2;
	Fri, 02 Feb 2024 09:16:05 +0000
From: William Kucharski <william.kucharski@oracle.com>
To: Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v2 1/1] RDMA/srpt: Do not register event handler until srpt device is fully setup
Date: Fri,  2 Feb 2024 02:15:49 -0700
Message-Id: <20240202091549.991784-2-william.kucharski@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240202091549.991784-1-william.kucharski@oracle.com>
References: <20240202091549.991784-1-william.kucharski@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_03,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020067
X-Proofpoint-ORIG-GUID: f2XL1vAKbQmIDLtQxFHQjSy_dACsKSkF
X-Proofpoint-GUID: f2XL1vAKbQmIDLtQxFHQjSy_dACsKSkF

Upon rare occasions, KASAN reports a use-after-free Write
in srpt_refresh_port().

This seems to be because an event handler is registered before the
srpt device is fully setup and a race condition upon error may leave a
partially setup event handler in place.

Instead, only register the event handler after srpt device initialization
is complete.

Fixes: dcc9881e6767 ("RDMA/(core, ulp): Convert register/unregister event handler to be void")
Signed-off-by: William Kucharski <william.kucharski@oracle.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 58f70cfec45a..d35f021f154b 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -3204,7 +3204,6 @@ static int srpt_add_one(struct ib_device *device)
 
 	INIT_IB_EVENT_HANDLER(&sdev->event_handler, sdev->device,
 			      srpt_event_handler);
-	ib_register_event_handler(&sdev->event_handler);
 
 	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
 		sport = &sdev->port[i - 1];
@@ -3227,6 +3226,7 @@ static int srpt_add_one(struct ib_device *device)
 		}
 	}
 
+	ib_register_event_handler(&sdev->event_handler);
 	spin_lock(&srpt_dev_lock);
 	list_add_tail(&sdev->list, &srpt_dev_list);
 	spin_unlock(&srpt_dev_lock);
@@ -3237,7 +3237,6 @@ static int srpt_add_one(struct ib_device *device)
 
 err_port:
 	srpt_unregister_mad_agent(sdev, i);
-	ib_unregister_event_handler(&sdev->event_handler);
 err_cm:
 	if (sdev->cm_id)
 		ib_destroy_cm_id(sdev->cm_id);
-- 
2.39.3


