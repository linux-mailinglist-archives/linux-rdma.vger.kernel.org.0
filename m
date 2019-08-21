Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC7297CB1
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfHUOXx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:23:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39964 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbfHUOXx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:23:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENUbS086665;
        Wed, 21 Aug 2019 14:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=hxQ7v0ZAlsn4Kc8VCMu3kQCTjzQEaIaEBjFcEOYAzw0=;
 b=aNxfrev1CpgoxMg2mS3J/HwG1HP30JFCtg4+m8VpXSKKfPVyH0/Xu5EYvEp0OgUJTjXu
 Mhoy7z3uBxWCJ50SaVDPlAdZYarWaEa8Ktgw3AKTI/akXpGvggp4tvsoLQavKczs8EZX
 mATHZyrO8mmxO3bFWMqSq4oNhUpK3cb1EgQh3A3Ma1jDiCihQ6YadELTegcs+8FyLHgd
 ZrHbGszTg6NOzUNJiXS7ux8Gz7NV6+oCKdENUL7x2wcBh4AdGYvlf3SQggq1J+b0616c
 nuYlSxvHC4cMV6cEDTfrKqgEyq2RVuUFEZvcjdt/KDjUlJ2Wj10/MMo03pkCKiFG0dLB Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2uea7qwxq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:23:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEMqa6017052;
        Wed, 21 Aug 2019 14:23:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2uh2q4jwr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:23:27 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7LEMRE4014977;
        Wed, 21 Aug 2019 14:22:28 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:22:27 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        monis@mellanox.com, parav@mellanox.com, danielj@mellanox.com,
        kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, shamir.rabinovitch@oracle.com,
        johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        jgg@mellanox.com, linux-rdma@vger.kernel.org
Cc:     Shamir Rabinovitch <srabinov7@gmail.com>
Subject: [PATCH v1 08/24] IB/verbs: Prototype of HW object clone callback
Date:   Wed, 21 Aug 2019 17:21:09 +0300
Message-Id: <20190821142125.5706-9-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821142125.5706-1-yuval.shaia@oracle.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210158
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>

Define prototype for clone callback. The clone callback is used
by the driver layer to supply the uverbs a way to clone IB HW
object driver data to rdma-core user space provider. The clone
callback is used when new IB HW object is created and every time
it is imported to some ib_ucontext. Drivers that wish to enable
share of some IB HW object (ib_pd, ib_mr, etc..) must supply valid
clone callback for that type.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 include/rdma/ib_verbs.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7e69866fc419..542b3cb2d943 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2265,6 +2265,18 @@ struct iw_cm_conn_param;
 
 #define DECLARE_RDMA_OBJ_SIZE(ib_struct) size_t size_##ib_struct
 
+/*
+ * Prototype for IB HW object clone callback
+ *
+ * Define prototype for clone callback. The clone callback is used
+ * by the driver layer to supply the uverbs a way to clone IB HW
+ * object driver data to rdma-core user space provider. The clone
+ * callback is used when new IB HW object is created and every time
+ * it is imported to some ib_ucontext.
+ */
+#define clone_callback(ib_type)		\
+	int (*clone_##ib_type)(struct ib_udata *udata, struct ib_type *obj)
+
 /**
  * struct ib_device_ops - InfiniBand device operations
  * This structure defines all the InfiniBand device operations, providers will
@@ -2575,6 +2587,9 @@ struct ib_device_ops {
 	 */
 	int (*counter_update_stats)(struct rdma_counter *counter);
 
+	/* Object sharing callbacks */
+	clone_callback(ib_pd);
+
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
@@ -2582,6 +2597,17 @@ struct ib_device_ops {
 	DECLARE_RDMA_OBJ_SIZE(ib_ucontext);
 };
 
+/* Implementation of trivial clone callback */
+#define trivial_clone_callback(ib_type)					\
+static inline int trivial_clone_##ib_type(struct ib_udata *udata,	\
+					  struct ib_type *obj)		\
+{									\
+	return 0;							\
+}
+
+/* Shared IB HW object support */
+trivial_clone_callback(ib_pd);
+
 struct ib_core_device {
 	/* device must be the first element in structure until,
 	 * union of ib_core_device and device exists in ib_device.
-- 
2.20.1

