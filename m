Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17A23B804B
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 11:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhF3JtM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Jun 2021 05:49:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52310 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234017AbhF3JtL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Jun 2021 05:49:11 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15U9kKFf020202;
        Wed, 30 Jun 2021 09:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=h686Og7nWQgIy2F8Ldwi3r/IKqxjRlyyk0G5ijPDQc4=;
 b=ofNyg0XRC6Jd1DLjMtZ+RFa7IIQEWl0HJ2iuxpb+U8HaY1yTrVU0ywa/vpUnjSfOwNNO
 6E5Se5DslKYCaNsifChRKNTO7OtxYvnrcCYOqn48zAPKSz/ELYPdMHj9j2TQbfoOfjuu
 T8ubB0eIZgPZcH6J53NPrOn6xs6mYlF4CkSbRO/RLJgF5ibpEqZa3lZ2baen2t468sMD
 Bwq+VeaQ062Jz/CReTAJuq/mcLM3t+xsfzwAhl7QCIKM+wBhbYmdPyrmw5lw1kg+4BG+
 iicKQHb4MSFO/X7qNmkQA7iSR2nKEiZyaFuH1oBapEXjVgc4NslLU6g5AWVWk66B518r qA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gjrwgeuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 09:46:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15U9k2tP039504;
        Wed, 30 Jun 2021 09:46:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3020.oracle.com with ESMTP id 39ee0wvps6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 09:46:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mw5t6OmHA1ACa/xE3TWPfkkk5HOu7wcqBvnVOYrWCu58IHLmn5qFsBktPuSN9fU70vVsnMSkYMTlwM19lbxLVnuVemohoPE58EEMBpMUh+Z9imieuorJbxY+l1t0lc+olARNSllNMrXSVt6FGTt0EHojtRJO6N6TaA4tHy9uNpANVL29yqKlVXyqFdzwUKz07cYBbiI+sapAPzXIbkXiBuw8KALuRfvBLAyvg2CGaWiE6lO+L9RIA4vReh4fZMtESSd0f5JVI4wCpAzxKwZMQZy8rQI3N2MfKJVG3/ZgAbeMhlZSkntSu4+TjHV9DMu2dFn20eHSSoFgKE3JMtw0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h686Og7nWQgIy2F8Ldwi3r/IKqxjRlyyk0G5ijPDQc4=;
 b=Enj1CSLCNT74vaHxD70dyYC+Y+pAzQ8EaAocZxVH41NChuhl/74qeCvkWaQ3xT3rY9Qx8RF7Z/+Xj8v6rEW1C5U5xixDT87y6Hq2M674SNchjnU5xQhPqJffDoQYV2GApvwBDo6d5TCn6Im7gcbJV4z8y0jGTA8QD4lvcIhOr7qRFeJ++6+Lw+YIRoq8rqbebGL0nUyNFqczOFjZOIXt/R3fuwkDJ9Mo1LLD4bzZHofNz6HDTgb3iGQlNd6U1H6oWLgPcrxNsZvOeNk9Uazv2COGCxrUxPU14ZdWsOw0OXXUATrn4x4yCbR5kvJEMFiStaGcGJ/J2d8kmjL3Gm0khQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h686Og7nWQgIy2F8Ldwi3r/IKqxjRlyyk0G5ijPDQc4=;
 b=QOeG5sCf8HORmTUankMJ+I5DCvAnPuLXdLy6itEsrcfbyBncmHLFweOqvzPU/EhLMpTqxgJUknHc2JRGlVdrDobhJy+YQp0dsidPyS8gwOpgtw7mZzsAhA9/d/h9SBpQaOsEWKH2OiwqKicxyqQEOE4apZabacyCsKgEW3jbPXs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR10MB1557.namprd10.prod.outlook.com
 (2603:10b6:903:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Wed, 30 Jun
 2021 09:46:37 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4%5]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 09:46:37 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v7 for-next 2/3] IB/core: Shifting initialization of device->cache_lock.
Date:   Wed, 30 Jun 2021 15:16:14 +0530
Message-Id: <20210630094615.808-3-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630094615.808-1-anand.a.khoje@oracle.com>
References: <20210630094615.808-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [49.36.45.114]
X-ClientProxiedBy: TYAPR01CA0007.jpnprd01.prod.outlook.com (2603:1096:404::19)
 To CY4PR1001MB2086.namprd10.prod.outlook.com (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (49.36.45.114) by TYAPR01CA0007.jpnprd01.prod.outlook.com (2603:1096:404::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 09:46:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 203465ce-2058-4a73-e06a-08d93babf422
X-MS-TrafficTypeDiagnostic: CY4PR10MB1557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB155711D1660D92C3F6152FE6C5019@CY4PR10MB1557.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zoKM41vpEG0nWLaDH/XXUIlwmZDkvyaXKtDxOFRmNRFiOVq6Pj8Pb0+zu0e96rLwVTDytDXX4EtjegCsxpDZP6RFrA+lV/yDB9RGEI0mtoj3jK9ASmdGGREkl9nLjfrUJPV8DruzTZDKDTGbWQWnamPDlsoslHoA/cPOsr8oJpmhwZRfTKJnsydXai3urxWGE2rC2qdRD1IwF6htvtMlcLD4Zzi7HevCfjIqNvqr0u1RqI6dOxMx5eASrNRQQ/sYfV7J06kHvtMuzou3V4dETwNA8F/CxXMq5kWpYyT8Y8ADX6WtM5t9S1ug+wi6C4J8xZJFgWsVdrGXB/0lDi+PRi5aZ5GXYDzfLkOreUmOT3JKS9YJcnsPVKUoGg+O3agsCvdVUWgjqwVQ9VRQFURn7P846qgT4KklNRgTiigLQUtpuFsw42gducWF4+5wZNSGIClFFiOrslSPEQr1GM9iHnb4wx8KD/qYrS4S09tCHATh2O8ZETsHN+nBxBYG/0/NBGXVYkL7w7AXeRBrVTDvBawEMv43qbvepOB2AyxAPIYGOK6FpiXBSMVGf6ygnC+zEaS5ry9tgQxMKBNCTF+Le1YMUU+k3bfmKIGTRbaxboYiMEEV4B7J/5DM7dBU2ejVSnm2KYal0kwILRAnOYti6nCO1Ne88VME+sYIy2xWwEPgqB3om3yZosT5P6Y1NllbVVv0ZvPYWVd6c6EC0bsdyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(66946007)(66556008)(66476007)(1076003)(16526019)(186003)(1006002)(6486002)(6666004)(36756003)(83380400001)(26005)(8936002)(8676002)(52116002)(478600001)(38100700002)(38350700002)(5660300002)(103116003)(2906002)(4326008)(86362001)(956004)(2616005)(7696005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eJZfMdLpMgYkuJs5vjH/v5HX/gtb/4XuWO2aQWt/t2gVR0PhN2EJXoUiMS5Y?=
 =?us-ascii?Q?02D9uRHjnJiFBm5/M9XtqU99i5kktPCre3XeAhcIYRp1logkPN4K+wTIBxnP?=
 =?us-ascii?Q?ifNpH6xZhfQcdeZ3/A2SjU7yMSt3bQJ6f3cxMEGs3g0+w7vjOatrT3hyxZTV?=
 =?us-ascii?Q?FsKoemPBFkExXs83oJefNdtWjadj9oeV7B/RMwW56wxgcNjU9Gcx3J2N2qD8?=
 =?us-ascii?Q?2k8yMdjZNstxhNMt4tSydRomMelRKpz6AsNG4YAUy5x4GbNeVoK9dlPCEx07?=
 =?us-ascii?Q?7GrtsqSporTkc58oViu5CmpQ5aUTuG4SVgcQG3bzuq+ErrvwjTwERQNFCQ5l?=
 =?us-ascii?Q?5vnS6vUTu5Z0Us54iSaunrVUp4qiGW0X7LJ+501Wx1HX5Fu8iXCTqGpyZI99?=
 =?us-ascii?Q?gXTelH4WUChUTkAucuaamB8CS87i3TB5oS0kqXza16MQFThuAJyLIYjfDUWJ?=
 =?us-ascii?Q?ZPQTT9mW3cTbDJJtyBsM5thWAQMXNj+l9SpFIi/0OAj+R1v7/gtnM7tK41Ij?=
 =?us-ascii?Q?e+X32pxkCUlCgK07FTD8c/eQzNkpJsPF0bhP+QchkoXNEUAlVP1400vuPnvn?=
 =?us-ascii?Q?70qprfIAbAjDaAroiSxRUujb1FGZfmChb6jA++Hf4hUuyCD/wRQUPmfMnsk8?=
 =?us-ascii?Q?Tb/BetkbO8efwSopJRViddtbdgvtKV44Vxjl5GtNkfgLi7qwr+RbRWGxMdk7?=
 =?us-ascii?Q?ClrCPDKlqidsZK49TvlmCZH1otF0jWATDYfhVVUghqEr4Awbd3oAEqxfVo2C?=
 =?us-ascii?Q?RB7YAKrnN2l1VP+jh2vZEt7MQc8Wp6l5PwRf0dSdyw6HatqgqzyFazywBrAt?=
 =?us-ascii?Q?JK4nXcCKzzfspXS5D1Sr4tVk9O2irkdwxWNeDc1K8dXYl1DkTCNkthW/6IHj?=
 =?us-ascii?Q?0Tp+7ISFtlCdjCQLRcKBHTnTmns62hVsj7KnMWcxqpFqhcVFJiTdaibL6X5o?=
 =?us-ascii?Q?zewv4wLr4AsTQlDo0j2M7dddFdDphRJhTMZVJWfyj4d8/uY/qD/3akfGJdKk?=
 =?us-ascii?Q?Ap5NEvS77zDeXjM/MXQycJqXJI3EctPd+os/cR7OjYpaLfGTpDCotvhwPFLB?=
 =?us-ascii?Q?Q4UHm5z1nwQfr7cgA4DQhEhpR0nbGYcpAQWJrfvDS66LhtfTDXyIul0mYyqD?=
 =?us-ascii?Q?pn2kTfITFyUvtKViTw92QwuLtOpZCWIeR6MZM2i1n1AQwuv42zTAtZvEqarP?=
 =?us-ascii?Q?MgtooqMtp7IwSCjz6tamQAxMcVIHH+Iyc2c5RApk446CRqFEt3CXHiRYne8Y?=
 =?us-ascii?Q?MsNCgLddH/CRS3uD+paB5MNxMWNJTO9KSF1edvU5KVmIIUmCA2rKoMhcZpqX?=
 =?us-ascii?Q?VsIE9AzHHZUBLVmlmUacfD4J?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203465ce-2058-4a73-e06a-08d93babf422
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 09:46:37.5376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcmF63CJWMn3NdMXTmnM/9cFRD5D2IcoFvBkpp99FPAkZI3QvEeOL0FCok7QjN/QPWB33QDWBnhuYvOO7RYW5j3XInzPbZaHGt8PYOh2JmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1557
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10030 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106300063
X-Proofpoint-ORIG-GUID: Pq4LlqN6mSkcWFDqdxhtS5UXL3wJ8n0o
X-Proofpoint-GUID: Pq4LlqN6mSkcWFDqdxhtS5UXL3wJ8n0o
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

