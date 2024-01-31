Return-Path: <linux-rdma+bounces-819-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23738436A0
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 07:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72AF11F28845
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 06:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957903EA8B;
	Wed, 31 Jan 2024 06:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UYLLxr4y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536863E494;
	Wed, 31 Jan 2024 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682308; cv=none; b=CN1PCShOgdBhLol+3otFjLx8xBA4rm0GYf3kX733gKIX9gptDlDvPLmRoI66/C08GXrS4oEDOTSZvPNwHPi8kP9PAwzrIrd8MIfJpc77uf/xY5EIMFnVweq4DlZx73v9jbuXqaO9C4yQIsskh+Vm/+A2V9pE+mCDgAXcCCkA6X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682308; c=relaxed/simple;
	bh=9UCuv+WNcckFk26p4BzpAmSuHoaQiHqhm7xYfqg+g9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AABDydTE0M6rMilyVPnG90hq2jSGa4CZQoLVm87js7HeetSUHgfhRwtsvJumTfOGwHwvqpTXwypkJAnioKxY7YAtQrZaW02gZfNqf1bB8L0ew9JEKxCz411CKHECKPD3mUO1zeCthJiylVgWpeg+y+YrH/Hyn/lcD1uwX1tDwv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UYLLxr4y; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UKwxjE003144;
	Wed, 31 Jan 2024 06:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=X8ixD3wpxtd7hiQ6h8HvIlzOgcT9/qe49cse5sVeDEI=;
 b=UYLLxr4ya9bUDREOKS5uy/LcOn96y+/araC7Ot5GTXHxE2rbuYpvzgv4QlvlvbJumpmG
 BQaexU469MlMDCqWp4n6+ca7uhOgk/Nm1EhYZVLQtdP41oKmtUqvzzEE4nXdRhMml4yM
 oYDBy77A4PUpl1iCBYjKdhMzDLr+S31AcaghIGpGHgmTekKm3UEkBYYqH4KExDC0zclX
 8MV6v60IOZKyPllxknQo3gzjgw60vSegemzk0iVQeecrX5YSrg1ckAGl2pbwuRD8cx/6
 eM4c7V9H6wEhSqj8wBl4NACvnMmyxPnUzJqduXvpUBFqICZey3bapm/zm1n2NJuqMryb LA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8egtm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 06:25:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40V51qdr035288;
	Wed, 31 Jan 2024 06:25:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9ebs3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 06:25:00 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40V6MZN2010633;
	Wed, 31 Jan 2024 06:25:00 GMT
Received: from brm-x62-14.us.oracle.com (brm-x62-14.us.oracle.com [10.80.150.231])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9ebs27-2;
	Wed, 31 Jan 2024 06:24:59 +0000
From: William Kucharski <william.kucharski@oracle.com>
To: Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 1/1] RDMA/srpt: Do not register event handler until srpt device is fully setup
Date: Tue, 30 Jan 2024 23:24:38 -0700
Message-Id: <20240131062438.869370-2-william.kucharski@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240131062438.869370-1-william.kucharski@oracle.com>
References: <20240131062438.869370-1-william.kucharski@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_02,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310047
X-Proofpoint-ORIG-GUID: KVGysevwWfL3EimAfKh48RbAqKKmX0zi
X-Proofpoint-GUID: KVGysevwWfL3EimAfKh48RbAqKKmX0zi

Upon rare occasions, KASAN reports a use-after-free Write
in srpt_refresh_port().

This seems to be because an event handler is registered before the
srpt device is fully setup and a race condition upon error may leave a
partially setup event handler in place.

Instead, only register the event handler after srpt device initialization
is complete.

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
2.43.0


