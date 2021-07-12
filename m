Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18B83C5C20
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 14:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhGLM3k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 08:29:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22386 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231749AbhGLM3j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Jul 2021 08:29:39 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CCNWFk002693;
        Mon, 12 Jul 2021 12:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=h686Og7nWQgIy2F8Ldwi3r/IKqxjRlyyk0G5ijPDQc4=;
 b=Z5Lf2T7XeyaI09CcvmHrub48Ljw+cYSwP1I4vkpRaTsKXNRGm3mc+fyOBf3GkDFmUomU
 l7swtFvy4I6K2S3t8fJ4kXBryTuEeMJsxh4QdMHaK+J3PmtKWu3ZrXNkQXZ0ATezXLZi
 NvZLinEZ+nrXdGyCBMsdnwqZD7HmEZTE+wUm3P5xfvbDwdoCChy18MnE46koquPOywtk
 K/P18V37d3QZftdG8B82KW7ljxdwaxGeurYv+NPIc8qnIa1nvBkmhXgBbcP/LY+UONnH
 0wSTCitjLYZy05TlH/uYCWlQGD3tnVzQfHDvqI0napUdxd2MmVSC6Y7X1ERrnUcdwwfG Fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39q35s2hve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 12:26:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16CCKmJV134677;
        Mon, 12 Jul 2021 12:26:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 39qycrhjsa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 12:26:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZAAZWUt85vdiRUk+diKU/JWpnwNM90WoAd22z64N3nDVAZP/3xS2NrqJn2LLxjWtqxFsVPK/gwsJtdF2QLDXiHK1Yku5q6b3+fRu8EBl323fwcijJ5aBFErcoAh8a8b1/erqRXnEU/fXF9aufG8Ll8XujnEq5CSq18O6zVwIUVSBk+Go7/jmM+7TNST0dnIgWaJZm5YIWnAuqj2ih3D3BXXW7v4VKJ+RMfCm9RfpDRfsf58SjyTClYKhRmS1GinuN5pnOo81R87+EEh38zE1JRfzDnMY9A4RR7I6+SIvVquZJIxipgCgssuxM/sLuDYHOcFHq1fCispnRQV+TY68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h686Og7nWQgIy2F8Ldwi3r/IKqxjRlyyk0G5ijPDQc4=;
 b=O4H3qRhSMIhReRPEksEBhvnO9hdXWVS1DmGfkrLmSvB+toAljSKOUJmnYHkCn+x4UuAyKuhmbb2rNYzxIfH3WNWjurF6LgHw2rbGPjl1VA406F99J4a8WsZ3ntIMk4TBSBI7T4Zfw+FXtFYzpKLS3ISlBJbkuffVhXFmCIjEM4AkH0qKrAOJLzDHqf7d7xh6iWCCxCyKT2j2gZ2XKPBOH2PUgXnyFdrPpRX9wMDIqDb1Q014G70p2/g27O8BMLospdAea4mZaaRC3cwCtpIdGuHXAj+jTvG5Z3X3IO8BuqVewxZ/LL+2SPlili7uZdaj6pt2I+lZBjqf49oj78dvPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h686Og7nWQgIy2F8Ldwi3r/IKqxjRlyyk0G5ijPDQc4=;
 b=Kcnjxphyg3f32CiJD+sUDZsvNXpqlstSLoKgP7Vg4WNojaUOnjqV3Gqo6bupYWye5gByCgqLAz7eP/82DvF2KBWOeYaekXD1giM5lYUQRZtb/AdA4mr5xKHjGqoZK2iSKwOKVx3VHHb2xTyyntno2qD4GNiG+JMxpeHQFcTGgTI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR1001MB2309.namprd10.prod.outlook.com
 (2603:10b6:910:3f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Mon, 12 Jul
 2021 12:26:45 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::9dcb:26d6:7408:b4d5]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::9dcb:26d6:7408:b4d5%6]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 12:26:45 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v8 for-next 2/3] IB/core: Shifting initialization of device->cache_lock
Date:   Mon, 12 Jul 2021 17:56:24 +0530
Message-Id: <20210712122625.1147-3-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712122625.1147-1-anand.a.khoje@oracle.com>
References: <20210712122625.1147-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8015::10) To CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (122.170.228.204) by TYAP286CA0005.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8015::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Mon, 12 Jul 2021 12:26:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aebda85-b98a-4679-f4ba-08d94530502b
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2309C51DB0D05CE87838C2F9C5159@CY4PR1001MB2309.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vtfyKFfsI5DKDykDLARljsE421/hILQwsOFCQ+c4YU1g5ScIW+sKKMhfAc2SCYcDCDlgm4CARp2KZJnv2VpPr6oDifRBDwcJCdPmZ15AeW7nGyixLbisQnjvZoYkBvB7hM5lxHtg2KOJh+v3cwvR4Ju1Qmx8PMPz7Vk6ssEemUI7l0+htqJw/nl+xJl6PeoJ/UWbLvIIlgZxSgWchAcRGkbGqzCwQayEBHwjNaD/vIQ7nRXcHZsJcAu6YKyRh2qrcADLhn2CiNaktGonaqUfzl6/04f0/e+onZgR5F0QtFMyx1x8MyVY/HnUF4Me1XzVsFM47B6Nf3508XivGTlkCuz1/Q5g+zBwIA3M87VtoJioC5esTjXajZ1Hu7OmHSljITx7N0EWbrUSvdKXi0+uAZTFIiZ3YnKXbnfJCniey+BD/zX/dskS5aklypeSN72/oOiJrGv5cWZQWxfB931dhtAPJ5N2aIKHuXkqiOP7o8G8cb7YoG6O5/X1lB215thHT4pd6/ybSH9/CxavLeFkK3BpdGujeRwKGRR/MXlBPKG8pVQFq6O/nFH2MX6vJn0tdX0Sl5QP8u9VN/bsoHgpmuhZpVGJC4yTNVDCYtJm65oacotPfQ3jYoQcOCLmrur3Jd6jXbNN+ZLIQxefxdRQ1MOxVzAlvCmLWIdXvBMuAQlgeepadzvT8ExFQLji/4KRa4sMDCVztHhQ5xodAA64A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39860400002)(376002)(346002)(6666004)(2906002)(36756003)(2616005)(66946007)(66556008)(1076003)(66476007)(86362001)(38350700002)(4326008)(6486002)(83380400001)(316002)(956004)(55236004)(186003)(38100700002)(8676002)(103116003)(7696005)(52116002)(478600001)(8936002)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J7GBPuiBzYwrqLjwyFbX2hEnSd6JrjDP7qD64yBXiVhyBgZt3Ar6Hgkcfo0s?=
 =?us-ascii?Q?KZc1Vmew87b/Qu8ZsCMwFvZ8aphkulkrX/mnH8h3k1Eekk5VJxCAJKv1Yb8Y?=
 =?us-ascii?Q?AXU06ueg/dzqAB3WNoUH8qeMrsm+O0+P5z81hZ8d5O4smRI9IbIcX1JBiaa2?=
 =?us-ascii?Q?93SZy87tQRMoe1x83rWmk/YWaMKUEj+uSsud8hnCd8RhxoUYFhm6cYT+BaHS?=
 =?us-ascii?Q?ygoi8zBuS1w18K5mk5fb/XX7Gmtt1g+mw3ZqVXyPReZP+CYtx3LGocrVjUaJ?=
 =?us-ascii?Q?h+Q4NpH950N2gg23OQD1zjo0D7zkIQptT6lKrWDEldL8yKG1RmK6zvRW90Bn?=
 =?us-ascii?Q?eUJCVzv09cGFbj4deD6nRjtUKq5keb+dfF9dViHOT3l6+cj+KIh/lSCmbCC7?=
 =?us-ascii?Q?yOz960TykVw+QHNiSkWa7u3a238VB7/zbSSI7Few514dWcTEMLs8YXM0OJQu?=
 =?us-ascii?Q?xRavIiIEUU0tDbYqYU2ou5lcmsYcNwQ+Pk41t7bIXUTYBsWkVXW0pJ/qIP+G?=
 =?us-ascii?Q?BH4zT+6IiX8flqJ9vh+EtfJ/YsKvVEjD1swNkoXOMjYoH5QyXbJWlUeg3mo0?=
 =?us-ascii?Q?29OGwDX8JoH/9ZxjWxSZX+nTEb2XOdlORP1I6OLS9ZzO8kE/v8kkysbj2OOy?=
 =?us-ascii?Q?UIHuatageV6xmcb4gLMXuiCbBLHWUZhoCcciCiNlxyWG7QrsAREewqxPN/Mj?=
 =?us-ascii?Q?rUf2N6yw8aBZlTnfdqunV1BJNyLHhbar25S+xPYjvpnc2PdWfzqvUOMqa/m2?=
 =?us-ascii?Q?pPW9Z7oRs62WbhK6HPjrSPhIeadT6flZZ5bsO/QFokNRJsZ4LWCDCJ/37Lbm?=
 =?us-ascii?Q?W+jiQvv94Yw48CP8z+6PeRT8ckEfZbAFna6jy0uj1Qk3C7i77YOw1kVkKhKT?=
 =?us-ascii?Q?NwFsy+Tz95ZLWOmRiNV6NfJpBVQStMYamDt+m8tPYnYiUqmuOzxuGQ359nm/?=
 =?us-ascii?Q?NwlWI6S/NyoZnkuF9BCSskKeR79ge9i5h+N34yKBb9hn/wtLPjoEmIjXB/H/?=
 =?us-ascii?Q?Z3GGno6tr9JXyHwL3etjakk2fMJJ/mlHlncBNfQjYbyyQnEgEmvO9BBvxsD6?=
 =?us-ascii?Q?lKK0SqtvU0KnCfe1fxkkH07XhNH5RMUkpNv5K8b/J88rkU7LSTQXuqc3V6ke?=
 =?us-ascii?Q?sFVBz8Mbv7afh2PNVLvnvpPHScT/8338puCD4PCmbpMjmF1nMoJZnELjizCj?=
 =?us-ascii?Q?4xX8OqkPtKImkKWv4erOCVvJjgrxs8mm+gAd1KoURS2jbCWaXsF6HUIdBbbF?=
 =?us-ascii?Q?ORheJEmN7E3//IVJxGyUBtw9W+0yuDsOhajuZbHaYz+ge/GQ5ZDe55a6BxX4?=
 =?us-ascii?Q?iSEmQPDdAEZj8XavMrNHDjqp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aebda85-b98a-4679-f4ba-08d94530502b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 12:26:45.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMgZVb2uPkqgvIcDRACg5CUGIrFxvt5A9MZ/XLVSm/hw3vBxFyDOwR/gKt1jDu8hKLJYnBbUL//sz+biZe/r61srAUCdqfwdmkhGh5L/B98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2309
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10042 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120097
X-Proofpoint-GUID: f9_f27Ticqkoiony8KGMuZWGIH7MHp9W
X-Proofpoint-ORIG-GUID: f9_f27Ticqkoiony8KGMuZWGIH7MHp9W
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The lock cache_lock of struct ib_device is initialized in function
ib_cache_setup_one(). This is much later than the device initialization
in _ib_alloc_device().

This change shifts initialization of cache_lock in _ib_alloc_device().

Suggested-by: Haakon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
---
 drivers/infiniband/core/cache.c  | 2 --
 drivers/infiniband/core/device.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 929399e..0c98dd3 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1621,8 +1621,6 @@ int ib_cache_setup_one(struct ib_device *device)
 	u32 p;
 	int err;
 
-	rwlock_init(&device->cache_lock);
-
 	err = gid_table_setup_one(device);
 	if (err)
 		return err;
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index fa20b18..ba0ad72 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -607,6 +607,8 @@ struct ib_device *_ib_alloc_device(size_t size)
 	for (i = 0; i < ARRAY_SIZE(device->cq_pools); i++)
 		INIT_LIST_HEAD(&device->cq_pools[i]);
 
+	rwlock_init(&device->cache_lock);
+
 	device->uverbs_cmd_mask =
 		BIT_ULL(IB_USER_VERBS_CMD_ALLOC_MW) |
 		BIT_ULL(IB_USER_VERBS_CMD_ALLOC_PD) |
-- 
1.8.3.1

