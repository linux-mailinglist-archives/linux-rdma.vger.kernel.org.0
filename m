Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D761E5998A7
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Aug 2022 11:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347106AbiHSJJY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Aug 2022 05:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346826AbiHSJJW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Aug 2022 05:09:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B6EF0778
        for <linux-rdma@vger.kernel.org>; Fri, 19 Aug 2022 02:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTE7e3ofY66XEZGRT2VJ2I4cXAdS8LKJk2GnhbTM3FRFSXCURT4rR+VZzTHccgwP4Xkz6Wg46Of1XBD0qVPLKgDztbUh8XC3pyRyQ7OoAa57H5AlrdsQr+Zisdz7JOPqIBvYynh3xXDRXEckLSI4W+yCGCHhlgJZ33FjbWzeAVPMOYaIEq8z6D9iJ2kGTtEnZ/Pk6pJIAjlldjF0RXLrLFtC35bVCaU7aMhwaRRilXm90Q/4pxAoVRRAHsq2Cu/wLFBR3oKfZg3VUDvU/ljZLP7IZdA3Xi0iDDdnMGN4K5+S1QJ+LKEqnNhTiWEO+CQM7wi44eD7YCZcmv0dXDEPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/uioJjboGfz4wxnF24F73KntqwPuRK+1w1yeRPKsE0=;
 b=aEZypnmV7o2d/+p01o/AtdzWHE74NBL5Psy9nsO9c/dD7K7C4pS97kewnQ2Oq2OoyRNnUpjd9gmQ5k9O5aeUEoDwj4v1vFnYmv4byI2lyyGKQsEwBP+QJVW5gsc5wdzMVt3PXbImbkkdqQgSf73G06L0xc/PAUtCFy79zOW+iZTNy0KfjLqVx0hq+XhRvu99IZhodSqyjLyu3OS1nspn1rtHPIpPrtIhzU7TKIfFU2beXsK5Dez2Mj6RlGMUvpADY+sDpYuU7ayozTx/PSjc9d8mlRk+nbivBVhWbUjHEwRac5RH4JQPnNU8FrmIpHTCigM5tmjHlmjMVwv4u+lN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/uioJjboGfz4wxnF24F73KntqwPuRK+1w1yeRPKsE0=;
 b=UvqTRp09s7y3JbJQoVu0j7UBIiTyeXjSkhO9O9lnevSGS8Qqhl80p/4t4HyqiJz+Ohic8/SbUEB2lO8WUF9YvyV9DNwPygFThzT0hXme7UjQssGyoN98c5VSSOuu6oy6oSsmX3IDdXMS5r4Ohh/LZmRxucAlWY4Vpy9Bx3vbLa2TEUFQpGYgdPSL6fJF6Zv/fvyVWyOi42Na/2dlCXQSLOTzGe+IS4dHUKD9QT15sE0SjiXdqisOgPo08fZu4Zw+M4+/5tDt6up1FZjvjNpybJeXBUxJ7EJUXx+j/RnA/SGTBF/p87FPtZ/snZijbSqLjU7pdQOaJyxTxJBobfHZJQ==
Received: from BN8PR12CA0025.namprd12.prod.outlook.com (2603:10b6:408:60::38)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Fri, 19 Aug
 2022 09:09:17 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::d8) by BN8PR12CA0025.outlook.office365.com
 (2603:10b6:408:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19 via Frontend
 Transport; Fri, 19 Aug 2022 09:09:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5546.7 via Frontend Transport; Fri, 19 Aug 2022 09:09:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Fri, 19 Aug 2022 09:09:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 19 Aug 2022 02:09:15 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 19 Aug 2022 02:09:13 -0700
From:   Mark Zhang <markzhang@nvidia.com>
To:     <jgg@nvidia.com>, <dledford@redhat.com>, <leonro@nvidia.com>
CC:     <jiapeng.chong@linux.alibaba.com>, <cgel.zte@gmail.com>,
        <linux-rdma@vger.kernel.org>, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next 2/3] IB/cm: remove cm_id_priv->id.service_mask and service_mask parameter of cm_init_listen()
Date:   Fri, 19 Aug 2022 12:08:58 +0300
Message-ID: <20220819090859.957943-3-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220819090859.957943-1-markzhang@nvidia.com>
References: <20220819090859.957943-1-markzhang@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27cd99ce-c561-40a8-93ed-08da81c27e7a
X-MS-TrafficTypeDiagnostic: MW4PR12MB7119:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFeC9EziKsNuu6wrodv/tM+vuaAEkKLO5MwtCFxVRHmUvDXQ//eiulBaEOaRsA1dVFKirMq4joNSFyqWoeQGjL9JXgFqtONV987F8G9uNLODOpOr+I6Xb3IZNji3rawFnmqACENxi3+BE9NXDy9tl+XYgfg3hC0GwLugZ6PyL4VeyanmzG6nkej5K5VolKY8fhjpWZArcYrtWa0zRbXwKzWZ5fMirCRDxX0Xz02RStSluI9CloN/htsxaK+FHNEtrQb0XcJD+raBz7mw8xQH0Kg6RBAmUYFHFHcYS/2wRUC80f46pWcmM2fs4iJjI8vlL80y8Gy0dFG5uY8yBLv7ioeyNklFL1vlmnFUB2lvxS8BpAA8gmMWJEHEJYKdVULooZ+6KhQ5xWYLehB6Y1pwbiJGVbob69Uq5Zk5mPDs+bZpgMXv3CPYVLnEwFpzS52ecRLcS2X1JYnKTZE7A+vg7PvfHzhFLCmKzS+7hVdedqZlUOZ3CU8A3ZedFsPwHRs55wka54wwlHnbmXUuXdi7vpnguE0dSXpOINYGh6JpFxzbdWg9RLQ2IqjJvHjNKqvovGHhKx9eZqTJX+erhSzkHaGbbcXKgCwYeKzMScIsgMqBDAqH9JtnfnAPChSrj0+xEkNstfxP8ZCjq7wBbZNUWHMQEiDM5c1HkEvN61lVO01ZSvf/Mg8op+BLKwD6qwBWEP2LRLP4RJ97GiU0XWAFkYsgnuiFA3pa/Q67/UO1JYSeNZ8eBcIS49yFVAG4YCkUIeCuaKKB5esvhGXPaHihmGRMOxC6PoOyK3JNcJoPhfo=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(40470700004)(46966006)(36840700001)(26005)(356005)(82740400003)(6666004)(81166007)(7696005)(2906002)(41300700001)(426003)(336012)(83380400001)(186003)(47076005)(107886003)(1076003)(40480700001)(2616005)(36860700001)(82310400005)(8676002)(4326008)(478600001)(36756003)(316002)(54906003)(70206006)(70586007)(86362001)(40460700003)(110136005)(8936002)(6636002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 09:09:17.0228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cd99ce-c561-40a8-93ed-08da81c27e7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The service_mask is always ~cpu_to_be64(0), so the result is always
a NOP when it is &'d with a service_id. Remove it for simplicity.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
---
 drivers/infiniband/core/cm.c | 28 ++++++++--------------------
 include/rdma/ib_cm.h         |  1 -
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index b59f864b3d79..84bb10799467 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -617,7 +617,6 @@ static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
 	struct rb_node *parent = NULL;
 	struct cm_id_private *cur_cm_id_priv;
 	__be64 service_id = cm_id_priv->id.service_id;
-	__be64 service_mask = cm_id_priv->id.service_mask;
 	unsigned long flags;
 
 	spin_lock_irqsave(&cm.lock, flags);
@@ -625,8 +624,7 @@ static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
 		parent = *link;
 		cur_cm_id_priv = rb_entry(parent, struct cm_id_private,
 					  service_node);
-		if ((cur_cm_id_priv->id.service_mask & service_id) ==
-		    (service_mask & cur_cm_id_priv->id.service_id) &&
+		if ((service_id == cur_cm_id_priv->id.service_id) &&
 		    (cm_id_priv->id.device == cur_cm_id_priv->id.device)) {
 			/*
 			 * Sharing an ib_cm_id with different handlers is not
@@ -670,8 +668,7 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
 
 	while (node) {
 		cm_id_priv = rb_entry(node, struct cm_id_private, service_node);
-		if ((cm_id_priv->id.service_mask & service_id) ==
-		     cm_id_priv->id.service_id &&
+		if ((service_id == cm_id_priv->id.service_id) &&
 		    (cm_id_priv->id.device == device)) {
 			refcount_inc(&cm_id_priv->refcount);
 			return cm_id_priv;
@@ -1158,22 +1155,17 @@ void ib_destroy_cm_id(struct ib_cm_id *cm_id)
 }
 EXPORT_SYMBOL(ib_destroy_cm_id);
 
-static int cm_init_listen(struct cm_id_private *cm_id_priv, __be64 service_id,
-			  __be64 service_mask)
+static int cm_init_listen(struct cm_id_private *cm_id_priv, __be64 service_id)
 {
-	service_mask = service_mask ? service_mask : ~cpu_to_be64(0);
-	service_id &= service_mask;
 	if ((service_id & IB_SERVICE_ID_AGN_MASK) == IB_CM_ASSIGN_SERVICE_ID &&
 	    (service_id != IB_CM_ASSIGN_SERVICE_ID))
 		return -EINVAL;
 
-	if (service_id == IB_CM_ASSIGN_SERVICE_ID) {
+	if (service_id == IB_CM_ASSIGN_SERVICE_ID)
 		cm_id_priv->id.service_id = cpu_to_be64(cm.listen_service_id++);
-		cm_id_priv->id.service_mask = ~cpu_to_be64(0);
-	} else {
+	else
 		cm_id_priv->id.service_id = service_id;
-		cm_id_priv->id.service_mask = service_mask;
-	}
+
 	return 0;
 }
 
@@ -1199,7 +1191,7 @@ int ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id)
 		goto out;
 	}
 
-	ret = cm_init_listen(cm_id_priv, service_id, 0);
+	ret = cm_init_listen(cm_id_priv, service_id);
 	if (ret)
 		goto out;
 
@@ -1247,7 +1239,7 @@ struct ib_cm_id *ib_cm_insert_listen(struct ib_device *device,
 	if (IS_ERR(cm_id_priv))
 		return ERR_CAST(cm_id_priv);
 
-	err = cm_init_listen(cm_id_priv, service_id, 0);
+	err = cm_init_listen(cm_id_priv, service_id);
 	if (err) {
 		ib_destroy_cm_id(&cm_id_priv->id);
 		return ERR_PTR(err);
@@ -1518,7 +1510,6 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 		}
 	}
 	cm_id->service_id = param->service_id;
-	cm_id->service_mask = ~cpu_to_be64(0);
 	cm_id_priv->timeout_ms = cm_convert_to_ms(
 				    param->primary_path->packet_life_time) * 2 +
 				 cm_convert_to_ms(
@@ -2075,7 +2066,6 @@ static int cm_req_handler(struct cm_work *work)
 		cpu_to_be32(IBA_GET(CM_REQ_LOCAL_COMM_ID, req_msg));
 	cm_id_priv->id.service_id =
 		cpu_to_be64(IBA_GET(CM_REQ_SERVICE_ID, req_msg));
-	cm_id_priv->id.service_mask = ~cpu_to_be64(0);
 	cm_id_priv->tid = req_msg->hdr.tid;
 	cm_id_priv->timeout_ms = cm_convert_to_ms(
 		IBA_GET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg));
@@ -3482,7 +3472,6 @@ int ib_send_cm_sidr_req(struct ib_cm_id *cm_id,
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	cm_move_av_from_path(&cm_id_priv->av, &av);
 	cm_id->service_id = param->service_id;
-	cm_id->service_mask = ~cpu_to_be64(0);
 	cm_id_priv->timeout_ms = param->timeout_ms;
 	cm_id_priv->max_cm_retries = param->max_cm_retries;
 	if (cm_id->state != IB_CM_IDLE) {
@@ -3557,7 +3546,6 @@ static int cm_sidr_req_handler(struct cm_work *work)
 		cpu_to_be32(IBA_GET(CM_SIDR_REQ_REQUESTID, sidr_req_msg));
 	cm_id_priv->id.service_id =
 		cpu_to_be64(IBA_GET(CM_SIDR_REQ_SERVICEID, sidr_req_msg));
-	cm_id_priv->id.service_mask = ~cpu_to_be64(0);
 	cm_id_priv->tid = sidr_req_msg->hdr.tid;
 
 	wc = work->mad_recv_wc->wc;
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index fbf260c1b1df..8dae5847020a 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -294,7 +294,6 @@ struct ib_cm_id {
 	void			*context;
 	struct ib_device	*device;
 	__be64			service_id;
-	__be64			service_mask;
 	enum ib_cm_state	state;		/* internal CM/debug use */
 	enum ib_cm_lap_state	lap_state;	/* internal CM/debug use */
 	__be32			local_id;
-- 
2.26.3

