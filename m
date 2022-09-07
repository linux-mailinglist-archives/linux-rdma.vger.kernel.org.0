Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21795B0345
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 13:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiIGLiv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 07:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiIGLit (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 07:38:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8431C912
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 04:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jv9mtP/8eJH5pibN1XQWjChWluxPE4mPrwoMOQ78RxqaJHdhatdWLx2eHE8yA2yf3WDXhpaMaBT+nw0EUt1tKWIl3Cill3pAmhwdckeJ0HCmI2vIHYvvCVMZuOJpjsITSuQMdJrLFbG9VP/4KF5hpQcNg4fBs23piU/zN5oCpfHqgM3IAQZ8q/ZDsjA4a7uE+IcLoLzQ8USX/bpaAvpUPjj+SEkLgNauixy/QO2IR/75Mgr/bg1YZ+WRf8bfhsegeBTuTcfODhWiiQUwjHvRHz7GN6ALM7h6zT+mkGveYuw159Awo3byCQ+xQuFPCiPRdLHDBadV15knEkKWNs1tKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggsIYY1IhuSLzdx0mu8FSMreucGyWZ93mnCMqOJH/qk=;
 b=HP7hBGCogjDCojCVV+GtcX/vBAIq72ig0yVF2k4AGijrdlAVgjepbLVHlRw4bSLfOM0HGSEhIS78Ec59pwgR+W/DRAVbac795hnqYyUVyVmuf5tVGlogUZGuTBY93g8qsffVxqj7qG0FDjks+TomS7Z3HOHwdHaSOGSklRTa7XtIxkYDY4gEBLd2+dbRlSCgpJxh9nwEu4q+OZBzndL+ajQq/QGbtkhj31Rx231WGYwVnbFHrpxzkeDb7QmjkvsfeWVIvTbo7xAlXcj6HdYR6BvJaVLqzI+JLDmhhTyQ/ytDq3cBB/oxLJnKXI74GCn0jrvTkUg4hWAtDFiVHXLosA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggsIYY1IhuSLzdx0mu8FSMreucGyWZ93mnCMqOJH/qk=;
 b=P3HzUNOafYdobGvF93EbLRMYVe9/AbAe8AUyaRmKoiNaf+fqKbKBXYAvnbmss3lAhZ8gYE2jh9P6hd7pmCLmH5hizb6NN3X4KO9I23dA9SdzknZenxeiKI7O/GuBQXdG8xKG4oK6M73AeWbS55Q++ar3mtAW4UUM9+OdUJg9M2QFC7xcrkjEoOOyJZ4RCDRVm2kARXxQkKhXiuy49P7UwTdkBnf4OyVTg68Mer4P8lngL2pdGezTZ9jSMhOgkh6rK2ly2wijVb2SRcGEsVW568SVmT8VMJ5nv7IOvKqT8lPy/dJKBqM7n3SmnDo0tDZeJyKQ29DeeK21MdOucBDPUg==
Received: from BN0PR04CA0192.namprd04.prod.outlook.com (2603:10b6:408:e9::17)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Wed, 7 Sep
 2022 11:38:45 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::9a) by BN0PR04CA0192.outlook.office365.com
 (2603:10b6:408:e9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 11:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 11:38:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 7 Sep
 2022 11:38:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 04:38:43 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Wed, 7 Sep
 2022 04:38:40 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC:     Patrisious Haddad <phaddad@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-nvme <linux-nvme@lists.infradead.org>,
        <linux-rdma@vger.kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH rdma-next 2/4] RDMA/core: Introduce ib_get_qp_err_syndrome function
Date:   Wed, 7 Sep 2022 14:37:58 +0300
Message-ID: <20220907113800.22182-3-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20220907113800.22182-1-phaddad@nvidia.com>
References: <20220907113800.22182-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT053:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 545ad267-1cea-40ab-3942-08da90c5859a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 769jzVMACV5V5mO0LWiOhy5QEgzLM7/OeKhjNao4ycmoybMjXUoDyzLjMHNoE6/9TvxZE92OGd0HLEIBfX67ZxjidS3O59wGw7aThaOAzc6KG4uXvAvCpT8fP5jj8GZoUyBu0PtmPPt9d6xNajVxuruQssPcPqVCN6gnd6XFPGvhJCexzKDsLgp1je8fawCCq5RqwzpMR3vBL5JfbRqEVbO/WjdP4g/xr8pn0BaKbL30WBPjRzpo+0im+Gt1QxEuozrobz4n7fWgIwJ9dzPzfmqacZ0Sraj8HUf3bgweZkt/xvHEpGPO/Y+CMxTMB2fO46efljlwTK/rfWOwvLi6ftjptPypDNKP54UiLHcji3rgHSGDJG085oUeBYbJPeOEUbm5QixW3q6ATITRaMbJl57yCKmMKVjjh2JqMpJXyk/KXxp8hz54Swh7s6t7ZTLl9z8wR0UoTtEyFRqJsXGJw5GrKIyms4TXD+97XQ/iH4z0Bnmw/P6iaFF8IFmofvIi8Ok/phKSDhjuELl/21RwAzHAZhoxX92rqY0AqmkzDqks5VIMVCl38E+hDcCi9nu3tvvcbHs1IP0mX2OswsHEBfca14BYFBhAJ/mJ2xkY9tnUONUcJAyEkx5JzKT5iX5KpWwGH2/eLRSGYdEnLl9I8yzAJE3Oz93SfZaAf6njkNjz6tkb0eeO45e1QCMnHPYOqfncLcNtqLzjg2sD/OvOeP9o5d7APrNz7DgB3rPhN/1q+m5P9HgUDMrU1LZoSD13xuYPFZX7Wfq0qqqq6kMN4xow46hP82MdFTsbF15Mo74=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(40470700004)(26005)(8676002)(86362001)(70206006)(54906003)(40460700003)(110136005)(36860700001)(82310400005)(5660300002)(83380400001)(70586007)(316002)(40480700001)(2616005)(478600001)(1076003)(7696005)(336012)(107886003)(81166007)(4326008)(82740400003)(8936002)(6666004)(186003)(36756003)(2906002)(47076005)(356005)(426003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 11:38:44.8749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 545ad267-1cea-40ab-3942-08da90c5859a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce ib_get_qp_err_syndrome function, which enables kernel
applications to query the reason the QP moved to error state.
Even in cases in which no CQE was generated.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c |  1 +
 drivers/infiniband/core/verbs.c  |  8 ++++++++
 include/rdma/ib_verbs.h          | 13 +++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index ae60c73babcc..8235b8fa1100 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2657,6 +2657,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, get_netdev);
 	SET_DEVICE_OP(dev_ops, get_numa_node);
 	SET_DEVICE_OP(dev_ops, get_port_immutable);
+	SET_DEVICE_OP(dev_ops, get_qp_err_syndrome);
 	SET_DEVICE_OP(dev_ops, get_vector_affinity);
 	SET_DEVICE_OP(dev_ops, get_vf_config);
 	SET_DEVICE_OP(dev_ops, get_vf_guid);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index e54b3f1b730e..ac20af8be33a 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1952,6 +1952,14 @@ int ib_query_qp(struct ib_qp *qp,
 }
 EXPORT_SYMBOL(ib_query_qp);
 
+int ib_get_qp_err_syndrome(struct ib_qp *qp, char *str)
+{
+	return qp->device->ops.get_qp_err_syndrome ?
+		qp->device->ops.get_qp_err_syndrome(qp->real_qp,
+						    str) : -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(ib_get_qp_err_syndrome);
+
 int ib_close_qp(struct ib_qp *qp)
 {
 	struct ib_qp *real_qp;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 975d6e9efbcb..9a94f2ef993c 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2465,6 +2465,7 @@ struct ib_device_ops {
 			 int qp_attr_mask, struct ib_udata *udata);
 	int (*query_qp)(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
 			int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr);
+	int (*get_qp_err_syndrome)(struct ib_qp *qp, char *str);
 	int (*destroy_qp)(struct ib_qp *qp, struct ib_udata *udata);
 	int (*create_cq)(struct ib_cq *cq, const struct ib_cq_init_attr *attr,
 			 struct ib_udata *udata);
@@ -3777,6 +3778,18 @@ int ib_query_qp(struct ib_qp *qp,
 		int qp_attr_mask,
 		struct ib_qp_init_attr *qp_init_attr);
 
+#define IB_ERR_SYNDROME_LENGTH 256
+
+/**
+ * ib_get_qp_err_syndrome - Returns a string that describes the reason
+ * the specified QP moved to error state.
+ * @qp : The QP to query.
+ * @str: The reason the qp moved to error state.
+ *
+ * NOTE: the user must pass a str with size of at least IB_ERR_SYNDROME_LENGTH
+ */
+int ib_get_qp_err_syndrome(struct ib_qp *qp, char *str);
+
 /**
  * ib_destroy_qp - Destroys the specified QP.
  * @qp: The QP to destroy.
-- 
2.18.1

