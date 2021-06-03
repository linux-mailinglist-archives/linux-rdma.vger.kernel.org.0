Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFC5399AFE
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFCGwb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 02:52:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34670 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhFCGw3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Jun 2021 02:52:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1536i4RE092791;
        Thu, 3 Jun 2021 06:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=djh/zkb7hMG3D2svjE+rzxjdNzhbNLe5JYhbteILrUQ=;
 b=Ux6rxRpalGWmEc+K46RFH3ObxdFDSQeRQve3j3ZanktZ3j84gnn8itR46rG2hP52JnyB
 54zsw2hqgQ0YJWKwv8/FeirAi+mp/3CCT0+CwqeM1zJVQEgjz8WhmhgpIWJoIxiiOlsE
 Z7qnxODhbsRgGOLEQSZVMEeDuDeRt23oIMV2j++HQWcPchLPn+aIm6HNYJZs9quyUWWP
 jcHD05SKV4pjSGCvUeke6CPMhCODxFhvmLzThKRS+egnP0UPnkzzAdHwoI+1+vv6tuZZ
 0TvIf4bPeTT8MeXzvuGEHm7koj4Kw+ro3BVDOmFYUdFY6Dqs7nUqzx6fMmiFjuKeAJJJ FA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38ue8pjd4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 06:50:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1536jTAH128066;
        Thu, 3 Jun 2021 06:50:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3020.oracle.com with ESMTP id 38udee2fbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 06:50:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+Ai9m2O1wLIzBhVxYIpo1sLrDA34M12yRL7c4nnep30lUAFZdg/BFTsI/HtUD3npXsSSLznS23DkxnJV9TrbZWixGM3sG/NhBuEUwtRu1Knv3p1lMk+0WKJ97iWuat3pCpdcJNRZ+DCmwwX5O5orT+3xqTqKlZlCko+QJjVHHhtM4k6QX9HP5tEYJKfA9X8GUbfGUwNbIrozgXqKXdlXFkP27Y3vApRUA0FkdiJAP9Ex9fdjV1BVsLgWGlAatThsxTk7EgxIRUwBdxFT5h1z068jxqfjDx2h5NmT9sO3Y+t4YJRBYyQuWM4OWqI90CNPdmJxp5CNBiDqy17TveCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djh/zkb7hMG3D2svjE+rzxjdNzhbNLe5JYhbteILrUQ=;
 b=IL113WSCbLIEDvmZUUI3P0f+HlVkWBJJl8Qjjgkb/LZKSfKHUp2vONDhG6uB2/1046R8h5AdTtFyEYrCH1UfQuD6hCfC/QSKT9FO2P2nWOzTyWs8fMYvZzOL0nA2uPt5zQE2Dmnjc6hGAvP9N7Lmv7DvG1K5YP6WcHu1a1UdwLvWUe4upedo8BeUIczfTKVOnseL7jdncZpO8VcvmAwzUHiQ1Ym//t1/XtNRQGo4WcG2a1vk7tI/DiKE8mmNpfEGGyVvxyFGSW6YzR7LJAwdTmYUF9sFXAfKQL5Z/nB+y1vM3epQtTwSDPL3tYdMQYBhJOk4k7H/d3e0HLH0zk4QQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djh/zkb7hMG3D2svjE+rzxjdNzhbNLe5JYhbteILrUQ=;
 b=mVgM1NUN6RzNfXdKfgQHTsYF1wIzUiCok2BBmz1D5vObzPse5c5H/IOkDlBCPbXzaUrMp8vz849qa2XjPKh+/LwcN8irUsITP+5Talro2ln3tN89GXe5YgC2iK0VDCxb2C7A+H5pdLJ9Q6hhM98qx8hd58bRWFmPWhLxWU7TV1E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM6PR10MB3979.namprd10.prod.outlook.com (2603:10b6:5:1f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 3 Jun
 2021 06:50:38 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71%5]) with mapi id 15.20.4173.029; Thu, 3 Jun 2021
 06:50:38 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v2 0/3] IB/core: Obtaining subnet_prefix from cache in IB devices. 
Date:   Thu,  3 Jun 2021 12:20:21 +0530
Message-Id: <20210603065024.1051-1-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [103.127.23.88]
X-ClientProxiedBy: SG2PR06CA0205.apcprd06.prod.outlook.com
 (2603:1096:4:68::13) To DM5PR1001MB2091.namprd10.prod.outlook.com
 (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (103.127.23.88) by SG2PR06CA0205.apcprd06.prod.outlook.com (2603:1096:4:68::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Thu, 3 Jun 2021 06:50:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d149e66-686a-40e4-33f0-08d9265be554
X-MS-TrafficTypeDiagnostic: DM6PR10MB3979:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB3979CC008618E1293FF9AE21C53C9@DM6PR10MB3979.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: axec1MIYWeIm8HoZrmLH1qx+2yZL+VZ8UiBg4ieBNFNNTP4vzYoY81VbdeVN2xk6o4v3jc58TcNcdYxlZUVacx7pAvD2cl172AovyEKh7HSEUOy70OtfqyMLwUoNQTQbwKyRtlZpfhhHWOpTZ96FQH4rfgLbmcuvenWRaAq0iJRueyPntMrhJ8nijGXSsXoQ0CWQ6BJt1vC1Ti2Az8ZekQp7NKCIjzh8PQLIxy38DypevNBFQn7excgRJIRr5j57/dwemfj1Ozmft177nl2P0xCIrjflATeuKEPxzbpCNGVuAFMJTrwjC3keFDhBxogpE0ZmJuQGUfl3WEFfShjo6bxPJvPOmt+pdet34CKGGH/K+1J1ZuRs87Bbt8EMspo2ub7LKo7p2wULmGswVKQBHyHOMcrr8dMx4s5she2cclcWVG/p2T6a1Tqy99hDZ/GHxBsbVMr02Y+8RpVm7GtGtv9fTCDLGQL8JBz/AjDOxzaOpKSRh6i6nff3z+fya53BXaTLNPm0F1FolIAsDOhr956xFiRzHPD57zL+H66fn22nbXZ1D5rhekKa//3KqDCAla9HqWXVA85/luvnkWvxKlQO0cIPmK73zDxavdf9XIaitSex12oUFZkuxxinRFOvElf6JxLDuazUGxrVeYTwoWn1FoAEcydGPHAw7HUHOus=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(346002)(366004)(66946007)(66556008)(66476007)(6666004)(6486002)(2616005)(7696005)(8676002)(4743002)(86362001)(52116002)(5660300002)(1076003)(956004)(36756003)(38350700002)(4326008)(103116003)(38100700002)(186003)(478600001)(16526019)(2906002)(83380400001)(316002)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?D1Crt4ZZcoJBJsa+1D46ezS1Th+F0+mOtdAvFhywNBQP0QdauGGRvA+xO0Vw?=
 =?us-ascii?Q?6IN07t/B0d8hW91UgoqfNlGZpCqg6CGfvLGhquM2tgTulF98qLO6fo+9aQ0T?=
 =?us-ascii?Q?IiXnnTK/B2VooVqlq4zvB/q//waFcl65VeiB8EhgzUnF5J2yAHM0PUq+ROL/?=
 =?us-ascii?Q?vWpxeCCaUZMGk5irIsCjK/xiu4O7VPxp/OMUZ/BiNa2Cz+Oq8u+ZwTSAjBlC?=
 =?us-ascii?Q?4HMDvb3nwYpF29taJF7Obn0wJbQkGJYZeYSgPDwFWYFyBB8xwBbvCodyNLRX?=
 =?us-ascii?Q?aBYUxakiE9OtqRnr78DpCjyB9B21XxrLjEnKfAIC4xqZHwp/n4PBiawU0+yz?=
 =?us-ascii?Q?cZKmed7XBPUZd4SabCQfAvtzaF7gBE9W2mlwyVZq9+P8seTKDFpwoGK+k2FX?=
 =?us-ascii?Q?82cITh0cgQZgpK+h3+QBE9EIczVXa/duAx0PLwKlHE076o+rSj2RD7V3zqui?=
 =?us-ascii?Q?shEZBZIo9Zwt5nXIvvB7Nog6xaMqyCmgYstxPQXDPhD7g0ALYxu0XKn2L6iE?=
 =?us-ascii?Q?UI/pkO5jZrj6S955BrBWYIInCctGFByjsiukquVglAt6teUyiFcOx44xz0Ur?=
 =?us-ascii?Q?5/RSceC3+4hiOPaCE9yAvIRDQBFtRcStIEKmcDWpIDOc72rn/mqUqx7HeD8X?=
 =?us-ascii?Q?uZwz5ZgSbZLhBvZZXQWhyTOq5vvMGZkqRSktigMVRQnpzZcj2taS16Z+GskF?=
 =?us-ascii?Q?uwo8IGIDCGN6L2HqxdmPMzB8GFQODCDDnsDqAvhPB7/+Y61Jl/Qz/uXCKhw/?=
 =?us-ascii?Q?CzTdP18WXrRpxndSVgk4cWYnV3LmAqtVxSqSJ2CCIiPyDqsl6/8kyf7ubeAd?=
 =?us-ascii?Q?Z/hawGcRTiLnG/GpWP131R228fNo9tzmKE8DAUZ8co6Epio1oTthSwbgkVOB?=
 =?us-ascii?Q?pYh6hPdbhqTV+KUEPOHB2Ue+HvDl9aTChq1/p2L/jPxQl/Rc1Wu4KgxEJjbO?=
 =?us-ascii?Q?3C85d4/5atY7cUCMZYIyuau1p7CHqNu8gjXgTmO2gPgnWJRKLNgItXX2nsAL?=
 =?us-ascii?Q?y9/uFwF4+qq9BwwJXMYb1Qy3wQ1u091MMEzm8XCVuzziP0IAnILCkEZ/BPGF?=
 =?us-ascii?Q?B601VY4XwtICXSTO1ziaw+tHgjv0QXATkGLLtBOvWTRAFEC79bTeTV/8KOIF?=
 =?us-ascii?Q?qUJIGUZUQ6Ph22H5GIdoOcpk7Jwgqk/tduVkga2CTymo2wMnNkZQL2SqRoXM?=
 =?us-ascii?Q?TBXTWCMIE25054ZUurHoxlVdYwifmskcl/Lz8u86g8Ocz9btrXUsyHH1Xt0H?=
 =?us-ascii?Q?7EZOb2UWs8XzBmR+hzoeVdlnwIZz2S585BnldGyEHgKVWAN8gXaT1+mSjwhc?=
 =?us-ascii?Q?R6UnW4FbrNY/GqbCj2VQS67C?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d149e66-686a-40e4-33f0-08d9265be554
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 06:50:38.3124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzbNLVr2i1NvS+nt6RFGBqxdDVRMBb9Rpc/GqLQCKjnv+SBqI/yAftYfPzYN0qRz3XcomQWAWPbQqB4gTz6n+dyEqIO+/VIxcb8xD98V8Ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3979
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106030045
X-Proofpoint-GUID: WFAj10PU3suXZsxRUOyEvWYR6WZBfCRv
X-Proofpoint-ORIG-GUID: WFAj10PU3suXZsxRUOyEvWYR6WZBfCRv
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106030045
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This v2 patch series is used to read the port_attribute subnet_prefix 
from a valid cache entry instead of having to call device->ops.query_gid()
in Infiniband link-layer devices. This requires addition of a flag used
to check that the cache entry is initialized and that a valid value
is being read.

1. Removed the port validity check from ib_get_cached_subnet_prefix.
This check was not useful as the port_num is always valid.

2. Shuffled locks pkey_lost_lock and netdev_lock in struct ib_port_data.
This was done to add the 8 byte field flags used for checking the cache
entry validity. Output of pahole showed two 4-byte holes in the structure
ib_port_data after pkey_list_lock and netdev_lock. Moving netdev_lock
shaved off 8 bytes from the structure, which is used to add the 8 byte
field flags in patch 3.

3. Added flags to struct ib_port_data and enum ib_port_data_flags. These
are used to validate the status of cached subnet_prefix. This valid
cache entry of subnet_prefix is used in function __ib_query_port().
This allows the utilization of the cache entry and hence avoids a call
into device->ops.query_gid().

Anand Khoje (3):
  Removed port validity check from ib_get_cached_subnet_prefix
  Shuffle locks in ib_port_data to save memory
  Obtain subnet_prefix from cache in IB devices

 drivers/infiniband/core/cache.c     | 14 ++++++++------
 drivers/infiniband/core/core_priv.h |  2 +-
 drivers/infiniband/core/device.c    | 23 ++++++++++++++---------
 drivers/infiniband/core/security.c  |  7 ++-----
 include/rdma/ib_cache.h             |  6 ++++++
 include/rdma/ib_verbs.h             | 10 +++++++++-
 6 files changed, 40 insertions(+), 22 deletions(-)

-- 
1.8.3.1

