Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3966915CB0B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 20:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBMTTU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 14:19:20 -0500
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:9888
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727076AbgBMTTU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Feb 2020 14:19:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO7len7TjLsVZ6VBcQNcxKHhmEfesNCPWBvXsKRt6Bm2n5t1qLTQXaOaExEbP2HOl7Sdn6J1D7tn9RPfiX5+eMjJPvTXh27y7dg66LzSl6nWFlw7S2XSAtcyvLoDGXuFTcDb1wEBHZFmgVgHYxgIdWSt1XaVnXe9uLSbRPKVKQ0ekU3CIO/Z0Na1yVagG2XlnAhkrKvbr2xGLKa0RjShYDiG9/QQbaHoh3Tj4AwPJhqHQW8XDpHLgx8fp7+Qpt3LSToZHPCmeolxUzfY3bYKM1QKtpurr1X0iFTmp/h1SYdPEYeOjidPEPGE0Wc6f9a2ttkU8+qzDcCczyMh7KvMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ltv+2mVpGK33q0MMlUlOukbDdvyePZUT0BtlHl1ur2I=;
 b=njqMAdTUEiT6IL/3Ta7fnXpwkdu0A81BEje41HYYJ3vhoaAFSaFlaGIq/Iaqt/HuwPfZQ1N2u6dCRSW8ypnpu86TH44Wr5md4QT+pDMWxagvAmXLFAg5bxP2RXd7K9GQ8anS/H8NX3TPCMSEnfo6OXZV7mVhKWQAzfq/g23aOoHgEHEyxqmhip3Qhynnxm+GpaMy7AuZKZXLYLDunc9cN0WZd23jfXYwQlT+vE02k4cvTDykReY2lMrE+do2OI3IqgvTID33LCKcYypP3+L/oQSPMaQyx2ggcugNq7rvYzej1L/byaMmC4x7OBxXpsZh6K2IcP6HlX04xAF36vNvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ltv+2mVpGK33q0MMlUlOukbDdvyePZUT0BtlHl1ur2I=;
 b=KnSfCnLroM7XmCeHr/UkO0eXwjaCdh46B23NDH3D7UEHGojUV73pmPZp85n2GN3SuCkSPI1855slpNtkgTY/l0UosGnvbcmRhVZVUww+1XCJ4CH+u8z6uRa7d/tqeMlWCK+DkmQUK7LpXeQ7r5UtUq+Fzk5BQ7Hp0x1xhtSr9jE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4813.eurprd05.prod.outlook.com (20.177.48.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 19:19:15 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2729.025; Thu, 13 Feb 2020
 19:19:15 +0000
Date:   Thu, 13 Feb 2020 15:19:11 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/core: Get rid of ib_create_qp_user
Message-ID: <20200213191911.GA9898@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:208:236::27) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:208:236::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.9 via Frontend Transport; Thu, 13 Feb 2020 19:19:15 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j2K11-0002fY-Vt     for linux-rdma@vger.kernel.org; Thu, 13 Feb 2020 15:19:11 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 04f36a73-85fb-45d6-c45e-08d7b0b99d6d
X-MS-TrafficTypeDiagnostic: VI1PR05MB4813:
X-Microsoft-Antispam-PRVS: <VI1PR05MB48138BD8F02737C3FF3C979BCF1A0@VI1PR05MB4813.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(189003)(199004)(66946007)(316002)(6916009)(5660300002)(66556008)(66476007)(1076003)(52116002)(2906002)(36756003)(9746002)(86362001)(9786002)(33656002)(81156014)(81166006)(8676002)(9686003)(8936002)(478600001)(26005)(186003)(26583001)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4813;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 44wHc8iS7fnoITFhPFhS8Cj/2QTuXVtZ8mYW7dqCCCaPFgsHW4nnJu77I0FzyqYNYHj6ZM9IdommSQpHqbdHjgwgpU+rvO8gsHgyeiLOMwKnZpESyj/CLIwb7akj/aS+JOG9oL7lxYwMImUb/4OmZ7iU2BJW6V2ptJ52vlQEldaU8+Lh0ffv5iVjrHkCqb5g9AJgYjIQTJL91zNbOLhYMWfPVwtvlXMakO95K9A6Y86Rjf9Qf+8rSjU94NM6L0ophVNxG1nj2IKcFvn+7+CdwNO8Ic4qdlaSiUuVz53nGBzy8rcR/1ycjNQd1W+e8NYk2rVDpWUd2BU51VuPx02/j0BqXAOwH0agw5mAWopoQLydfgl+dCvgDM9smedjUg78MC+6tQFEauwS4QMh6yQEf1GBzEZeWEAT5qAhT95lcTgRm6EecHYXq9+q5MChQxX/ZxbW10zL4j2/WC1PkaXR5K5u/g1wChL3XElwAs4EA2sCwYLg3iKsUofnDrUEGsfbBZOCCVZyxtZyl/2RrDRhag==
X-MS-Exchange-AntiSpam-MessageData: vFZ3adl62jVEsRc4UkvkKYg6WLhP+bpuSFM5Aj8XI4FSG1a1U9SKM2t7b6GgYXRwTc+KvXa98ddHJURhWEnVfHEeuQECDAHbIxp3iySWqWnbDwtqAG/dq3fMqAw/hRoaMXH5wRuLYQqlpdnwKMV5yQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f36a73-85fb-45d6-c45e-08d7b0b99d6d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 19:19:15.3798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSti1ESHWXPLkQT2bSSStqW2pKktxjo+p3pWprp3QQbZ68yjHRYM/uZTQ5736ypeT2EaMa5bwcL88qQnV8on3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4813
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This function accepts a udata but does nothing with it, and is never
passed a !NULL udata. Rename it to ib_create_qp which was the only
caller and remove the udata.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/verbs.c | 22 +++++++++++++++-------
 include/rdma/ib_verbs.h         | 31 ++-----------------------------
 2 files changed, 17 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 3ebae3b65c2821..13ff4c8bfe5ac7 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1127,8 +1127,7 @@ struct ib_qp *ib_open_qp(struct ib_xrcd *xrcd,
 EXPORT_SYMBOL(ib_open_qp);
 
 static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
-					struct ib_qp_init_attr *qp_init_attr,
-					struct ib_udata *udata)
+					struct ib_qp_init_attr *qp_init_attr)
 {
 	struct ib_qp *real_qp = qp;
 
@@ -1150,9 +1149,18 @@ static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
 	return qp;
 }
 
-struct ib_qp *ib_create_qp_user(struct ib_pd *pd,
-				struct ib_qp_init_attr *qp_init_attr,
-				struct ib_udata *udata)
+/**
+ * ib_create_qp - Creates a kernel QP associated with the specified protection
+ *   domain.
+ * @pd: The protection domain associated with the QP.
+ * @qp_init_attr: A list of initial attributes required to create the
+ *   QP.  If QP creation succeeds, then the attributes are updated to
+ *   the actual capabilities of the created QP.
+ *
+ * NOTE: for user qp use ib_create_qp_user with valid udata!
+ */
+struct ib_qp *ib_create_qp(struct ib_pd *pd,
+			   struct ib_qp_init_attr *qp_init_attr)
 {
 	struct ib_device *device = pd ? pd->device : qp_init_attr->xrcd->device;
 	struct ib_qp *qp;
@@ -1197,7 +1205,7 @@ struct ib_qp *ib_create_qp_user(struct ib_pd *pd,
 
 	if (qp_init_attr->qp_type == IB_QPT_XRC_TGT) {
 		struct ib_qp *xrc_qp =
-			create_xrc_qp_user(qp, qp_init_attr, udata);
+			create_xrc_qp_user(qp, qp_init_attr);
 
 		if (IS_ERR(xrc_qp)) {
 			ret = PTR_ERR(xrc_qp);
@@ -1253,7 +1261,7 @@ struct ib_qp *ib_create_qp_user(struct ib_pd *pd,
 	return ERR_PTR(ret);
 
 }
-EXPORT_SYMBOL(ib_create_qp_user);
+EXPORT_SYMBOL(ib_create_qp);
 
 static const struct {
 	int			valid;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 1f779fad3a1e4e..5f3a04ead9f593 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3627,35 +3627,8 @@ static inline int ib_post_srq_recv(struct ib_srq *srq,
 					      bad_recv_wr ? : &dummy);
 }
 
-/**
- * ib_create_qp_user - Creates a QP associated with the specified protection
- *   domain.
- * @pd: The protection domain associated with the QP.
- * @qp_init_attr: A list of initial attributes required to create the
- *   QP.  If QP creation succeeds, then the attributes are updated to
- *   the actual capabilities of the created QP.
- * @udata: Valid user data or NULL for kernel objects
- */
-struct ib_qp *ib_create_qp_user(struct ib_pd *pd,
-				struct ib_qp_init_attr *qp_init_attr,
-				struct ib_udata *udata);
-
-/**
- * ib_create_qp - Creates a kernel QP associated with the specified protection
- *   domain.
- * @pd: The protection domain associated with the QP.
- * @qp_init_attr: A list of initial attributes required to create the
- *   QP.  If QP creation succeeds, then the attributes are updated to
- *   the actual capabilities of the created QP.
- * @udata: Valid user data or NULL for kernel objects
- *
- * NOTE: for user qp use ib_create_qp_user with valid udata!
- */
-static inline struct ib_qp *ib_create_qp(struct ib_pd *pd,
-					 struct ib_qp_init_attr *qp_init_attr)
-{
-	return ib_create_qp_user(pd, qp_init_attr, NULL);
-}
+struct ib_qp *ib_create_qp(struct ib_pd *pd,
+			   struct ib_qp_init_attr *qp_init_attr);
 
 /**
  * ib_modify_qp_with_udata - Modifies the attributes for the specified QP.
-- 
2.25.0

