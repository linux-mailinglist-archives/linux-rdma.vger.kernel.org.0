Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8513A9330
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 08:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhFPGyt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 02:54:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17530 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231892AbhFPGys (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 02:54:48 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15G6ka7Z004162;
        Wed, 16 Jun 2021 06:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=gd4iU+T32qZFNfLTCNO0Wo6M5V838GsfMuhGfDxRamo=;
 b=Zk/R8MQG4syc8kmGeV9xNc7QU3F2/olspug/cO9ZKa5Ul0wIR/6ujwOomcODEN6DSTXj
 L0C+293EwZxhWlkbNR9+L7nrddPeJwc1k5UqDGY8ukk9+VyEVVt5vqFBUs+fyXmwNMZM
 NMbsp8n65317x8PXDIAH8t2to5SMbsWj2zMMFR2EI6H0dxVtzIqAZ6pq4Hh0/X3nIJgk
 8IqwlUiYI7cLUjSKaSIMyrkunzkY8ZQMTCecGTNV2dPk/mwuRvEFkLiaPpWNmzyZ6/gC
 iH3s8MXmbGK8nrVkbmde0V6l+78kecMmL+uZ6kfagwwglgc0WerVGpfxbMIBW+OvrQpC ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 395y1kt2f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 06:52:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15G6p2ZF089813;
        Wed, 16 Jun 2021 06:52:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3020.oracle.com with ESMTP id 396waseyw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 06:52:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfAM3w6DmG8Uv1U+EZig6S6Z5FbA+tz3jA697INeeYzq6EvXkwXz2PGqXM15aG2e04k9MGMqv6SV1Q7czMuvT7NpWGD8TlLJTb+p871CSMGl9He/KedrUNnUoV13kbkBmKNqp18dIM7CBp4yAiq158QqmZ6nY1tx5Dedo6ru3sP8hc2UvR1LOyiLzkev5B4aFr9+5yvpOzxkhtie/3HmMhCOY2/QfSm/kQYsRmUs+ehvZR/0Ap+0lNZdSLOgwcALMM4rZeXksz5XI30nr/zVwrD53PUyj9rkiCcWb26tsK2/So6PGhGTliZIj5zRoDfBPlr0/SpEWfHrijbehs90Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd4iU+T32qZFNfLTCNO0Wo6M5V838GsfMuhGfDxRamo=;
 b=L5bRhfs2xpaDOyTFfNOPVKLeECGjKft1Dc2bCweX2oOEXoNEREC1rDkDdFGghGd6nLg5DsiEJsR46/vrekkXx+SAe+2/lgBXrDVI6N+Y1dJ1swI+i0hm/T7IXGrp5qx37KtoFPNReIaUtcmuAj6qqQ6SaotZypEm9+rzY4FRSUw0r2/O2M9rzp5EKF0xfTi+eSIuNgjuxRRfgkONaoDWK7JchVZyREtcS28E0v7bofBjWoLK3cbPe+al+fgFxLwBawYYZU1e8/pPvNGOYQmkYOx7urlNXxpL8W6Ebxp6nbyVvVbeLCf9zO+VdApSFM1jiLMNK3Y2D9srATTKblqErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd4iU+T32qZFNfLTCNO0Wo6M5V838GsfMuhGfDxRamo=;
 b=a0RkB8uqcnk+VKqQBybLPG1dCBr6tpx2oV4FmOTbpAmDxZI6qgP21OcpgEcJU/1MLAeepOzY7kS5DQyFl2LxnuBMAEQ95VeIaduMQlet6aAAbLdnjgjtaonWbF54RhB9xuDE2iJxAoH8dtJTMiuINegESgI9qhGv5sE082fm+Fo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM5PR10MB2043.namprd10.prod.outlook.com (2603:10b6:3:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 06:52:37 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508%3]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 06:52:37 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v4 for-next 2/3] IB/core: Shuffle locks in ib_port_data to save memory
Date:   Wed, 16 Jun 2021 12:22:12 +0530
Message-Id: <20210616065213.987-3-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616065213.987-1-anand.a.khoje@oracle.com>
References: <20210616065213.987-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [182.70.80.33]
X-ClientProxiedBy: SG2PR03CA0139.apcprd03.prod.outlook.com
 (2603:1096:4:c8::12) To DM5PR1001MB2091.namprd10.prod.outlook.com
 (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (182.70.80.33) by SG2PR03CA0139.apcprd03.prod.outlook.com (2603:1096:4:c8::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 16 Jun 2021 06:52:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e72be15d-f6be-4a56-fb04-08d9309353b5
X-MS-TrafficTypeDiagnostic: DM5PR10MB2043:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB20434A7180370DD5EB66F54DC50F9@DM5PR10MB2043.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQ1tIqMCIttWPOfZTgaiCFS5jjelNy3yVEJnWN4s9FwrJKdv2+2hD2BI6HeS8MIqyoSBTUYPcsn1AJCn7VggF9f8rrvPfMmU9th4yGkF5Af7KoTgzcIXKhvNa2qVeMR5TuyQn/IEv7M87TrkvLo7226T3eEemVJHGURQ1oFTr0aG9mWMPPV5v3eSNhdeyQjrxPtkjp/OQtfH0FidKgEFaUDNnIJf/vzM6oC2JMbuCDU/4LL3+0UkCAjhF6nMQfqN4KYclQ3mN2i4qY7NfJp1eCgsSCiDUCqC7k6K4PNaymSa5tOr7L4VO1MSEL3shnZZHugPjWXxD/qF501GYloNulB7EHF6PSMLKJKc7IvmUE0IvMCtEKAi/fYd/w2GIrr7CxVkNJ5LDP+ibF8fyEzIkdRfQ/mnbD0owfsYhm+WrRCQA1u3kbRkB76iip05fhk4LOz7ebhS0S3DqLdGMSnMx49BGKgzh72ZAaj2DDln+jPgQbp1tW8kojD2LjbtWYxu5J6FJDZn36S9Ii3UnKyBSH3wc8HFK78RSq+cyVjB4Laqb9lFN4JjklsWI+1gDyRzed6Ccp32jdN3Fy3YEN4GthyKC1JBZ0C4KxL64Lu+0VITEJGHLS9Mj4+UNW3tH2/ugUBKyrLAYh2rYEbxYjnPs38LAsurxfV1cnKb/BYJZ1c4QwlTaN6k5dT48al6z10i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(346002)(39860400002)(6486002)(66476007)(316002)(7696005)(36756003)(52116002)(16526019)(186003)(5660300002)(66556008)(66946007)(8936002)(4326008)(1076003)(103116003)(38100700002)(83380400001)(2616005)(86362001)(8676002)(478600001)(26005)(956004)(2906002)(38350700002)(6666004)(120606002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sernfCPb6CeatDxbt3xSkzsLfYtBKoajWx7MAMmAZTZ3Qrm8nWCw6yVc4rPd?=
 =?us-ascii?Q?g4u0MhXMgsMtt7+vPkI6LKFfn0/BSzeIf2eABj05Hd9Bog334y+q3IxqokhA?=
 =?us-ascii?Q?b5Ot4w6N1lzcagFMBGEZDgnBQ8e+oMhwEC8lB2eLWmmThOUZoPEouMFIwegi?=
 =?us-ascii?Q?FDlbY3CePKCCcor/2A7U56j+qs09R+c8I4oABc2pUp90PvOucsBdgYBtfFO5?=
 =?us-ascii?Q?Rfd33Ixgam+DhqN8xsV+/uQLXXQPv0CBnNjSwuUWUPEwRswAOaumNhEg+odt?=
 =?us-ascii?Q?yK9mi/0RQ3dingBoGf1LkyoMOJpfCVOJ4dqTmTNmKf1H+XEcIU+rTPr8Asvn?=
 =?us-ascii?Q?mTl5nHyNebnSEjEdckpShGuFwzwKVC0Ky8EH91NvevWEvl9wDLm0Woj83hk8?=
 =?us-ascii?Q?z5Yd/L1AMWGZJxg3PIqgX+PmRj9aAxDPRkQ0WFHEfiG3SnnukWlej6DH6lg0?=
 =?us-ascii?Q?idfpDks1NyzC+dixFcSLRoKoh6PYa67fHc7cf1Cg4+C2CuBNJ5G+NqP+pgZU?=
 =?us-ascii?Q?OzIufjlvhOCHeqEqyIm3usfyTOC24BgjS6lyWNwgKnvhVx/S8u6CE1ABPu4r?=
 =?us-ascii?Q?pv+GKVNuN/u2VWAX1Y45b1RshKljIbMEYucU39oXTuNaTyjEx9tFYoZESd2E?=
 =?us-ascii?Q?n2Dul41gJtFlXCUtzh8LSWYxPBVg6n27qkCzdkJb4tr54mtnjlpMQIl7/s3j?=
 =?us-ascii?Q?QwgpGjxGCVjbxKCYRIVLmcKm6irXIGe6f2dse7gPirv7Gy3NnzSPk2sCkPHW?=
 =?us-ascii?Q?4ATvkm0FIxexyZ+cFgpCByIqWs0it4N41D5CweA0frocz5oaGKbztzlWkPra?=
 =?us-ascii?Q?UH/piCR4H4D5MuUQ5ywXW/cppoW2/3bh55zt7xBND/JbIx+1YQKcLoxmT8SZ?=
 =?us-ascii?Q?tBPZ95nAdNVlAZYFqI+YRpFHgHiGXCR0dTXbRM4UOj4w08ZADydAByTSBcCn?=
 =?us-ascii?Q?qIrW8Fo9BV9SZf1oIjhJADTb7FIKkpf7+2BCW0fCfDW+FJI7fwswcxVqAIiY?=
 =?us-ascii?Q?joNLQDegKj4J5nw4G4145eneVhGzzMCiCQN30se+vSv7Y1PkokfdA4DZG1Rs?=
 =?us-ascii?Q?luejy/rcEW480AHCDDpXNJH1JBsLgckALFx6j/Jf+pVdqyQNQ8Y5ZjmWwkjM?=
 =?us-ascii?Q?xNIslXNh4zyKGu3a76FGqs3kUkkV8g8aR4yOzQIKiA2+aZ8ahC15tI/c0kVt?=
 =?us-ascii?Q?n6lnyahnsN5RYhn+ZQ8k67nLZe/iPqJ75fF/qJNgRrBVUPUlscu9ZAqnYuUD?=
 =?us-ascii?Q?5qUDfmzjWrIzi8u54FbM2IfJJIkVhR4DV31GtokJ8qxuChxyt9mTGrg5kumi?=
 =?us-ascii?Q?3pRThXyBLTcYVVhkKGVzmEK/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72be15d-f6be-4a56-fb04-08d9309353b5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 06:52:37.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Xb6ZPFQ/cPuXHLRkRhR5SuRu4vvNmyAj3d2pG7FJPqiWctkFvbnd1U+k0KP3CCGljTM/h9Ye2NEUXHRf7pgZPyxKnJZNFFGodEKXW3lkm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2043
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160042
X-Proofpoint-ORIG-GUID: VA3c27X1F5OuMdRsmOYjTjDGAD3UI-X7
X-Proofpoint-GUID: VA3c27X1F5OuMdRsmOYjTjDGAD3UI-X7
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

pahole shows two 4-byte holes in struct ib_port_data after
pkey_list_lock and netdev_lock respectively.

Shuffling the netdev_lock to be after pkey_list_lock, this
shaves off eight bytes from the struct.

Suggested-by: Haakon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---

v1 -> v2:
    -   Split the v1 patch in 3 patches as per Leon's suggestion.
v2 -> v3:
    -   No changes.
v3 -> v4:
    -   No changes.

---
 include/rdma/ib_verbs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 05dbc21..c96d601 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2174,11 +2174,13 @@ struct ib_port_data {
 	struct ib_port_immutable immutable;
 
 	spinlock_t pkey_list_lock;
+
+	spinlock_t netdev_lock;
+
 	struct list_head pkey_list;
 
 	struct ib_port_cache cache;
 
-	spinlock_t netdev_lock;
 	struct net_device __rcu *netdev;
 	struct hlist_node ndev_hash_link;
 	struct rdma_port_counter port_counter;
-- 
1.8.3.1

