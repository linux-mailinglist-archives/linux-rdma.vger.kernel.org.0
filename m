Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2431599881
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Aug 2022 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347308AbiHSJJR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Aug 2022 05:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347640AbiHSJJQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Aug 2022 05:09:16 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F36BF0756
        for <linux-rdma@vger.kernel.org>; Fri, 19 Aug 2022 02:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgRjyBQLCh2GRziJ01Xe+N6EPmzsYDYt5+H55U7K1fDKMgrT4JQcRO3lqx3J6IK8Ho1scEtxcUsLlP8qvh2Sfv7zFJfMTMOhVqOYaVvmISqeP9+9uFLUipo7vBvQkByagl2IPplO/kecMtJuOw/r2+DIUT21Qy3SxR5oV6vPtYuIA2MuNIFsHF68NUcplFsZYRgSr9YfPoztExoxGIPV5X1HuCvqFgyZLBL1eCWPe4/L/ho2jrQ/G0LKoChj8y4zQEbsJ62dGyUeuALdGUbaOVbi/cEljZ2HGCg3uXQ4jfKDD24jxlJY8X+oDVUjXIb//gmPbG3QrIb4N0ztk9BwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJmShWW/r1zay2gBN2sUk9k12Pcq0hU5rvC4aF8i+r4=;
 b=PXZIlJKzUhb8BvaYVQKbQEjwzCXWU6qcIM9fyf9zDVb5TXLKPBOhsqP0/+jwH+SKBCe0yagL1xboXZ1MrSyRnoCXJHq25ea9RNYrRbi1ALZ7tXqDZl/LFBTGryEqkBnsEcs/+RQXV4by05V0ymD2VH8msurL9l2mpbUNPybQ8CPYmGbVFJYh5s0k/Zdk0dZzfCQ4mg7YuyQmL2zA/vpS/wadLdHZgvFmRnQ68NOz2VSL7SSTSToiz7j5s5pn9wYumQjP1Sm7JcFEgqU0WMmSm4PXvtI8mWt4EBoz6FXcpr1d4r2I8OOlkr6pfrT1sjmuv8A0Efi81XWHxMx0EkzOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJmShWW/r1zay2gBN2sUk9k12Pcq0hU5rvC4aF8i+r4=;
 b=n1GiOyxQDgRJIG11Ve4DDotoEsv2quvHTMaz6xzkD8BnMkULstsZsgQR/batxSzIvh31KVlewsIgH9jzl3bEmSYQT4t7v9WnJPg3xgF9ZNJ4mmnHyW1OlOUmnZPoxNtqLzvSvWCLvuW6mRLv/E+DmDwHPozq4FKcMg1MJQigR9NFvBeUt3hsB54dePhOB3cH5Q5LexW9Rg/ZoR2nTph2GsdlN7VZlCzvVMq+iStwRdhJjDihz4MtL/AFvExgcOTA/nMzf8BibrbLoYy+AwfHlzakPyE//OevnBSIFpXKdQ6+Pd/HSkcbKvGRobMQucN/efXb0hKuPSa+55ChY7B5sg==
Received: from DM6PR06CA0099.namprd06.prod.outlook.com (2603:10b6:5:336::32)
 by CH2PR12MB5017.namprd12.prod.outlook.com (2603:10b6:610:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 09:09:12 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::3) by DM6PR06CA0099.outlook.office365.com
 (2603:10b6:5:336::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16 via Frontend
 Transport; Fri, 19 Aug 2022 09:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5546.7 via Frontend Transport; Fri, 19 Aug 2022 09:09:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Fri, 19 Aug 2022 09:09:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 19 Aug 2022 02:09:10 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 19 Aug 2022 02:09:08 -0700
From:   Mark Zhang <markzhang@nvidia.com>
To:     <jgg@nvidia.com>, <dledford@redhat.com>, <leonro@nvidia.com>
CC:     <jiapeng.chong@linux.alibaba.com>, <cgel.zte@gmail.com>,
        <linux-rdma@vger.kernel.org>, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next 0/3] IB/cm refactors
Date:   Fri, 19 Aug 2022 12:08:56 +0300
Message-ID: <20220819090859.957943-1-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc7a82da-b60e-40f9-2fa9-08da81c27b6b
X-MS-TrafficTypeDiagnostic: CH2PR12MB5017:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOD0dx+cBVmXoUzwvQ997m1fRqjifd8EVmMIBctkfvAcAhI2kuBc4u6guJzI6Ll+eERaapLlvRALZLFeZwT9p0rYbNZUhe1syfLN7E+QGN08RLzP037gEpTvAgv6yv+y3Ni44wu9qHr4gm6hfQiI8yHJmA4/JxrgbdRNwJfXmdqoHGK2mVouCNQQS9Lxz7PDdtqsqraGNHenuCIHhQyvgzL/jT/peQwFuCRZgvHgJGfm0LkownW9K8vFafxtaajzXguGxQvTHJQ30hkitMxTvGyWYHF6C2hOIsvX/Yaa4atMo/OSJ7lKLUblxuPdstaBaIyuQkQ0d4uvyW6M7DpBbgVcx0RDuW9KtmfmQsBFJRLVeSMTfEbQH1ZGwq8yfA2eznRNHEXMDFM1YAFEUtJtHfpcctbHXa3uUecpvDtV+Njc1Djik/lLE32Vw0mxv0Nz1QDM/GA6KeBC2qyiUGFd56yfGWv5nSTpfXfMNuYgvWzPqyMcB/0qb6rpeZbadlI1W5RrHz8Gk8pz5isZSk8TrFPyLOxY4GxbFNXC0Zh6PvKh7Y9vcYqSn76fQ0UXRwtnEk6/UPj2Ahe6gLKwiNEDyUe3Xryp0ELxeYjdemecQ/qH13zKytkPfZBoG4knLoltD8bZ5nKALWPC82VfTZWdAnXHPVKDztNkhKDfHirwe4TDKdfCjlnSFF28GBAQD3cmrw1SX+GYWn9pVj5MtPxsN83m3zkRwHhlEfTZaokZ3U+tTfSITVtEN+ZPu9yjygjv26Zbhb3Fe31ZmVVpQEg/NXjiALf7k/bjDlXWx2L/NpUM7OY+NZulI/8sium1Hd9uWdGLzDy/8xvdOVtb7Q+2Duy78FA98YDJPZgZrqA3CXr4DYuHuHgy9omwjhDvUTj0
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(36840700001)(40470700004)(5660300002)(6666004)(478600001)(86362001)(7696005)(6636002)(41300700001)(40460700003)(110136005)(54906003)(966005)(8936002)(4744005)(70586007)(316002)(83380400001)(70206006)(2616005)(107886003)(36756003)(47076005)(186003)(1076003)(426003)(82310400005)(356005)(26005)(4326008)(336012)(36860700001)(8676002)(82740400003)(40480700001)(2906002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 09:09:11.9200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7a82da-b60e-40f9-2fa9-08da81c27b6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5017
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

This series provides 2 IB/cm refactors:
- The first 2 patches remove the usage of service_mask, as it is
  always -1 so it doesn't help;
- The third one refines cm_insert_listen() and cm_find_listen().

Link: https://lore.kernel.org/lkml/20220624201733.GA284068@nvidia.com/t/

Thanks.

Mark Zhang (3):
  IB/cm: Remove the service_mask parameter from ib_cm_listen()
  IB/cm: remove cm_id_priv->id.service_mask and service_mask parameter
    of cm_init_listen()
  IB/cm: Refactor cm_insert_listen() and cm_find_listen()

 drivers/infiniband/core/cm.c            | 65 +++++++++----------------
 drivers/infiniband/ulp/ipoib/ipoib_cm.c |  4 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c   |  2 +-
 include/rdma/ib_cm.h                    |  8 +--
 4 files changed, 26 insertions(+), 53 deletions(-)

-- 
2.26.3

