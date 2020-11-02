Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5ABE2A36D0
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 23:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKBWyz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 17:54:55 -0500
Received: from mail-eopbgr750042.outbound.protection.outlook.com ([40.107.75.42]:7350
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbgKBWyz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 17:54:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClG64Ry3xE+rxJijAXLI+W8oehhrM8/Po107LgnZTMUNMPnjgU9HBosP4ezE/Vec3Bcm+fXJY6a0D/jNcTb5brJ893VBDKS65m0VS6ymjExneoierrBxTIQCApK5DeB7kiLghdGjYjFVrm3FcLQfIMb8bZXBVlBqTWdwJpHZ+GEf2pz9csODNsT/fWaWIaTgQp1xlWZiUOBQeenQaaPZp2sJgPm45lH1Ak3cwv4ShIvmUz7VvXoTERRcJaALAIlwA2Qc1sfYlC0Gpd1gOSjBvUhnGCf5ZbQJeYJBtVEzbNM7MCjZznyTHuirJqfKmSVr/JkdcIsfjHAVPzckukQCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4mlU/Or0VWKthCpsaFPZNBD6MJX/UvzdJztGFk7CfE=;
 b=GpzAkXZrhon9Kp5jQF8C/eR6ZG6HyiuVLckxJk32Cg/ilRFZxXtpfHIWSHhKedRp9O9b/EiNGVSEEZPntGND1eBS6U0jv5zNd5ZZHEOUZujTCPlYRkYmaPzVyHWOdp6A7Ub7zPGLCi/qiKsqbyrtTt486VKoQFyHX2AxmEPC6WEDuXi4KaSAvECs4ZAM7S5JVZwsn4cxFBXALkdSyPSB4av8nVL+W5bhTJ0yblElBFPE0s2jGr7gLZ6rBWdCqTbcvnrCZi9QYHK36lLy5a2TEHC7u7/w4cJ0+/cnpk7hlXtcgBfGZ/ohqMCo5usBTdlzI/WT8tB0qribewEw0QqgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4mlU/Or0VWKthCpsaFPZNBD6MJX/UvzdJztGFk7CfE=;
 b=kDVASdyRNHHkULPqRXn4D/T0K9d1lthskJbnhCN4NRCOteH5G6dFA5fQ/sUgBtq3jByh1Rd/sqGetctvThcSeCBj9Ar0Y+F4WVrld1Gk0LrXRIvDAjJ1v3OFdNSozXQqL9GkqyFToMZiEEXvnMdlDvIaaDxamRXyXKI7GWL1Qww=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (2603:10b6:a03:1a::28)
 by BYAPR05MB4711.namprd05.prod.outlook.com (2603:10b6:a03:4f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.11; Mon, 2 Nov
 2020 22:54:48 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0%7]) with mapi id 15.20.3541.011; Mon, 2 Nov 2020
 22:54:48 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     jgg@mellanox.com, dledford@redhat.com, linux-rdma@vger.kernel.org
Cc:     Adit Ranadive <aditr@vmware.com>, pv-drivers@vmware.com
Subject: [PATCH v1 for-rc] RDMA/vmw_pvrdma: Fix the active_speed and phys_state value
Date:   Mon,  2 Nov 2020 22:54:37 +0000
Message-Id: <20201102225437.26557-1-aditr@vmware.com>
X-Mailer: git-send-email 2.18.1
Content-Type: text/plain
X-Originating-IP: [66.170.99.2]
X-ClientProxiedBy: SJ0PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:a03:338::17) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-build.eng.vmware.com (66.170.99.2) by SJ0PR03CA0162.namprd03.prod.outlook.com (2603:10b6:a03:338::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 2 Nov 2020 22:54:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03b4ed56-6d97-40ad-d984-08d87f824bad
X-MS-TrafficTypeDiagnostic: BYAPR05MB4711:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR05MB4711A562874EBC806F53B915C5100@BYAPR05MB4711.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsvrBo1DQl6DvG9qwkT55x65seBEX3ZCLtK8/7It821RtxRQEnTslKokdKQPyhiOctyH3NJ34rfHCuPyA1U2qCf+jG7UeJA5FnEoiZLogs9b8ALIMpQ/YBDwFTnKRMNUkw9CVgitr/FInIF1FwZzzZ1zzSOuc3Ima+NaxfqH6jPV6fo3JYmg2Og79vCKt5HHoT58D1NQUZt6Q523QL2APahVefmG92H7UJdurJwhuOHFY95hDcgekFEgWDgNK1S3mvln/JljwryfCLWt4z4K/+kY45e9+m2Zw1VWQgFO/nbXNMAGwV7po/sABY9kpKl24zDAapr3Z7odAJA2MxutVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5511.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(107886003)(4326008)(2906002)(52116002)(7696005)(186003)(478600001)(16526019)(6666004)(26005)(2616005)(86362001)(956004)(6486002)(8676002)(8936002)(1076003)(66946007)(5660300002)(316002)(66556008)(36756003)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: U107JmCJkfD9r5Q7FPxyEvTk0QsPRUQSpTLumIYO5lt4Y9WFT/zFOutcbZQF56Yxel20rIEKrdAZmV0SrGhdkN9CuGotvL5rzvbBrEvgIrK9Aq0XNkwitjQ2RFt4wfNBBELgB5FWaXEzt6pFYd1tTePer4HKyM8AVpciA6KyBwhW6AIy3L+paH/ZxcCvLfPRSBqviIp48w95AXt97v7CveFhq9sW96ejpJRw+frcZFBlgyVqdbfuLpB48ijnjCupGAv5mWrYZ6u1bSAUBlB8PGL3B6d5Xb0hcFQxjKZTODkuLxpl71XqOmJvWyg090+RpiLSYkLtxp40toyE/zSX4N/uepwbORwQGSa96g9Ee00/ittkEfPviauVuhZ+kqoI7FE+iC92e0/m5zv6xM/N46IAFnSD28+RDsPuhAV4u7jO+JEJ6Kag1jnWUz6DuR7MV+6fKKc9fI+ec42FfQwGv7EwfY0FZ4PMrDpM5ji66Zq4O5FIKv3Jgh1pMQqEK/f2T22zNmj2gu+RigLGBuqrv7eMExd6lycCHMaIQrK/KbJ/qiRC5wAOLZuBODUQxxTska/BkkCITLUCA2PVZD35DtX0VWlXyO2CFf4tuljWHAbsSygPuslQU3kPY5m2D+FmQ1E3xDCs6MphdlYeq7r4Rg==
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b4ed56-6d97-40ad-d984-08d87f824bad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5511.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 22:54:48.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JoDeGn5fIOC3UO37A83mWddYW7OFfxVsIoPlIPc216e6w50vfkFHS+LFx7oRQZPO6Uj0IEI8dEbXLXeMhcmlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4711
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The PVRDMA device still reports the active_speed in u8.
The pvrdma_port_attr structure is used by the device to report the
port attributes in the device API query port response structure -
pvrdma_cmd_query_port_resp - and shouldn't be changed.

Fixes: 376ceb31ff87 ("RDMA: Fix link active_speed size")
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Adit Ranadive <aditr@vmware.com>
---

Changelog:
 - v0->v1: Reverted the structure layout only as per Jason. Updated description.
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index f0e5ffba2d51..97ed8f952f6e 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -176,7 +176,7 @@ struct pvrdma_port_attr {
 	u8			subnet_timeout;
 	u8			init_type_reply;
 	u8			active_width;
-	u16			active_speed;
+	u8			active_speed;
 	u8			phys_state;
 	u8			reserved[2];
 };
-- 
2.18.1

