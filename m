Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1CA3A0C14
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 07:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhFIF5t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 01:57:49 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60978 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFIF5t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Jun 2021 01:57:49 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1595nOkJ011362;
        Wed, 9 Jun 2021 05:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=qjMVeE1eCJ+P1NUhrdIqmJkVDUySjmP9kHZUzXWyfjE=;
 b=W7CnX53cIDG/aNt34ZxozIOP7lHvw37jUsU019kAmlnoBxABQeY6uh70gA/HlCmz8QEl
 wHkc2mKybsWS80ppt+T+hoOvUTmW2QXVOt2TWkgngCNbl+Q5fQFWvIBlZltqb0RgkV9q
 YaFkZoSb/ZuiWKDCALN3b4VTxSTT1R6gbyesZJS4EfUS5v6A31sjMGD8TeUQSwojj4EC
 k1lMW6AhcyHDI/0ZOaz+SCxRb5KQFN2GPdkmT/Xnu6TLxuo2cRG57xtRzHWEgp0umhPU
 xpdxQQT9TiidJqBHYqZvHwrATskKJ5sMO/os31tRorXpXu8X951lYKLGsybxDDoMm/pt pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38yxscg1rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 05:55:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1595p4vu064511;
        Wed, 9 Jun 2021 05:55:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3020.oracle.com with ESMTP id 390k1rmrv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 05:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjkgIcnIxNiAHVmfcc4zh2v/SPjzblnqXPltBlJUVo2m9PljMjzl20PPvzQI0kAW2CDvx3aYkLBYuywthkw4SYQRH6Q4s3Y4T7lx0D9ziNa7PD0Yqq/6HHCZefcW0pPb++VUJo6D8kU6xdRtHIPKhPU9dh1kX8lyM1ISCWctULHw1xWI9QrrvawyAX8aNCdaBTSx8D2acMiDRkiiNtQs9agwh4MU1SP45DCu5V+RDNInBXgbuHwTTt41WUhWw/iJb+x1zrJWXvob+qNx/cR/XIYR+wRSnkuEGYjmZLkvOgq2TWqAzJ/P/ZIp5QbqO6MPjkDPNYQcVSWKs4T1gEMgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjMVeE1eCJ+P1NUhrdIqmJkVDUySjmP9kHZUzXWyfjE=;
 b=MPgNQlNqQz6ZUyXYTLRJC2T+Nvo2hQTQjyTb69A1iX6g90ksAMcOjLBKfIksHHLjK3xAsMPfePdvGi8Rpa8lPumsAeYFb5yMawb/xzAfKGZFdQKek3OmyardSkCFEQVidan5D3cxn6lQI0iO76h+YIIWos/drA+H6PgwKYFfWTB+Obj3+/0mLnoyM0w5T5QKoi9zF6kGm21OkomlEOOHXVOdAWLTbav+b5j5/2ldccI7UAqRRhHC9ySkzzDtzO8x78Sig0zocCO7nXHU7HYZONgIO+3h/kgx5EPDjaX3uNvQ4/QLoblsn/ZyvYkzwoPk59ESUVVDuw7lbE2JhtCnnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjMVeE1eCJ+P1NUhrdIqmJkVDUySjmP9kHZUzXWyfjE=;
 b=CmyK7Eavnc5AdGq1tFvDDyEamDNQeAWYM1Yxezr8xUNv9sBCyjfUs8KRnYWFNWHjhf7QqBgZ4RJN5Ig1nAbqz/DfQBtUm5XPAZg9VHXwUZ7/1qQB9Ju3SxfWpvjK5c9oy5iSoXnFlX/8SsuJ9kcBe9PEtaX3DzMfSwNADeGCfqM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM5PR1001MB2217.namprd10.prod.outlook.com (2603:10b6:4:2e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 9 Jun
 2021 05:55:47 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71%5]) with mapi id 15.20.4173.029; Wed, 9 Jun 2021
 05:55:47 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v3 0/3] IB/core: Obtaining subnet_prefix from cache in
Date:   Wed,  9 Jun 2021 11:25:31 +0530
Message-Id: <20210609055534.855-1-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [171.50.202.152]
X-ClientProxiedBy: TYAPR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:404:28::17) To DM5PR1001MB2091.namprd10.prod.outlook.com
 (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (171.50.202.152) by TYAPR01CA0029.jpnprd01.prod.outlook.com (2603:1096:404:28::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 05:55:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ac9f4f4-416d-4419-b8c1-08d92b0b39fa
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2217705476FF9B1A06A46440C5369@DM5PR1001MB2217.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGfUcqi8HekLOZHS5ghuBT9oXSVB+icscaGXiOSREJ6MIqZH2dvIrlTI6q6ZJvt/roH1B+jC8KxgGfI1JiiPQK37i5sU9wc8VIsAE5MJfddbfWEGsoSR5KO5Whe5WFw3PI7wpf+2KRbvb0qZRsd2vq8bdUR8yTSukbhf2Cr6ZZGSzyd8j20Xj7hwSePsPJNNSv8pQt2pxd8iXCJSI8R+s5HOUNJNu6rQUKxJCrRU0XDjCVatVa7N25jgwtJB4Toxms60OWovUMQBoEeLqfPOt36gjsqHDktxvfNu+vOtwpurEsTWbBvbvqOqBKCheNIOEW3FJXwapHq9EnzU0VDK3G5NWWX8Jn+ozuS9AIZQDhhcQ942WCXOL0bK4JVqqeycXBdGosF9yTumMKBL3AY26xWXWBKr/54vkfJgBl04LMJFQyHRWH9bvPuPU3hhcKpB1479Nx+Rj7iapZZ/yb7Q4zzz8LaFpGcuJa/QhnFTBM5SRZT0andoCeHNKwAwJTK/OfMtg8B7sJzQeZAnR4oL1qBuUGd+LdqW79owD0qt6/vrTtYPBV+gevJlisL0GlbkvoMkFLq4v3XH7juq3Rs6O9rUhyXHEUKCm0+fZbEXCg8pvXchI7DoY2uE12MbY5JllmUeA5ZG8HmY1AVuZslMSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(136003)(366004)(346002)(956004)(2616005)(26005)(6486002)(1076003)(2906002)(316002)(5660300002)(8936002)(186003)(38100700002)(6666004)(16526019)(66556008)(38350700002)(86362001)(103116003)(66476007)(52116002)(7696005)(478600001)(83380400001)(4326008)(8676002)(36756003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?woFOu0Gb1xJNKWR2FF+CABDOc3pLGUsXJRA3B4bqX0tnmkeUp4IZruxwgAAU?=
 =?us-ascii?Q?YT2iBEUZFhBTonDHRh6Az94y77PE5r29/5n+BOukoFCXEmYcX7xspXe39KhC?=
 =?us-ascii?Q?4uKDGE1HirEWDKh8yfXZfGeelB54puk6C7F5f88kGNywLbYA/a6lnMVN8XLU?=
 =?us-ascii?Q?4WB/YUq18OmgUgvHdrq+gSBPxKwl3Vhp6CgEjP8NZTwhHL2yFCtg7/S+0FBF?=
 =?us-ascii?Q?ZwifdgpTqaTfTrUX7IYL7oRKfi6kvlPW3kUZhMYaE3JLaV6/LWRcssUyZgW2?=
 =?us-ascii?Q?6oeScGoQZIw6E/DZZ+dY7ZIddw+k0mb7cd5Vjk7+VU6i81/QUlFsQ/i0soiX?=
 =?us-ascii?Q?K0FdjK9y0vJhxHLCBPy17ufBerNhUcs5etJdKdMayV3Ls45rfpR9fjyR66Or?=
 =?us-ascii?Q?/r1LNakn4SL/ULOnhVkYyy3xV27ygTpHxPonRhVTWN+jHohy4SWk+xFm1Qri?=
 =?us-ascii?Q?5InlfGYt9XlASdtJZdYRMTJMkbWTmdtJmHM3PJPEZV3Dntm5g4/SRFk0yg5K?=
 =?us-ascii?Q?73mQUSs686ZccQGxmvbx6j85WazKak5s5QZMLdNxWUePa+T6VJmxOlBVgVBD?=
 =?us-ascii?Q?FP/+27T8PhaKb5Iv5i1PJyVj0D/73PvRshKA2LFsjVUWaH6AeaXgt8/DbdTU?=
 =?us-ascii?Q?mi932x0vJl7gZe6J/uCleaBLzDX8ccx+DhZfwYvPlTbv2WvTBSDW6uzcX1Kl?=
 =?us-ascii?Q?UrV9gYYZDOkUkAjgIWR56lOOnuh1GziuFNKGN5nJoZ9Ux1KiiK3d7TSAOas6?=
 =?us-ascii?Q?2peNf1zH6fJXyPdw/I3iK0jR1wgk+ayyGRaZ3cl8iumEZSteBnxsigC9nQxL?=
 =?us-ascii?Q?Bw2ammlYFyybaPgZuobg7eYBZT4eTmD4rQCXyfyGshgiNEOccgmohwGZQVaO?=
 =?us-ascii?Q?5si7l6+OcH/gCN6N2Axs1lDmuQzFHSr97TxLxNWVtkUBdFLffA6/acifTwNl?=
 =?us-ascii?Q?xPpId0465JmzMyQ9VgXO3EKhOaUdpTB+6kQU8p8yZ5urqWfl1s6RrxuUkdxu?=
 =?us-ascii?Q?4B3lZZ8gvVYGrcOinZW5wkGDP8PXirLABpWKbcnOXgzdclZV+9u5zdtsbohk?=
 =?us-ascii?Q?2XuKoCYHu9W+VjsLW5sckc3huJPANMWo3m0Ir0d8A4qKPriQaKnl7izAJV0Q?=
 =?us-ascii?Q?ZskbOatINIVPC7Y+ugaDK5WF61C9a7gzznb7hX/PoDDzS55fxbnZ6DuiLGm4?=
 =?us-ascii?Q?jJC+6RuGEPHtVixEL15EsNsaP3YsQ84BbHqkZRN+xaQwQurtkDO9hqG8d58y?=
 =?us-ascii?Q?ZDFMGPNURFL1Zc2RGADTr1S/f02AF/KAmybtSghowka0NZFv4n6R6j3jjQCs?=
 =?us-ascii?Q?rHszpntyPSauyIjVYRPJTuke?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac9f4f4-416d-4419-b8c1-08d92b0b39fa
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 05:55:46.9541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krAzidR0sXUU2qw73xBtjjMilGNMA5vo9gLn+h/auIjMwclypnvQbAC4I39Tpswn96zS/ojpiCKJ/DQCE/pPg4iZF8KhGhqEmfrErO3bv3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2217
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090018
X-Proofpoint-ORIG-GUID: i4fSNbOS_Wod_bT2XWKWuE4Nhi5fElkD
X-Proofpoint-GUID: i4fSNbOS_Wod_bT2XWKWuE4Nhi5fElkD
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090018
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This v3 patch series is used to read the port_attribute subnet_prefix
from a valid cache entry instead of having to call
device->ops.query_gid() in Infiniband link-layer devices. This requires
addition of a flag used to check that the cache entry is initialized and
that a valid value is being read.

1. Removed the port validity check from ib_get_cached_subnet_prefix.
This check was not useful as the port_num is always valid.

2. Shuffled locks pkey_lost_lock and netdev_lock in struct ib_port_data.
This was done to add the 8 byte field flags used for checking the cache
entry validity. Output of pahole showed two 4-byte holes in the
structure ib_port_data after pkey_list_lock and netdev_lock. Moving
netdev_lock shaved off 8 bytes from the structure, which is used to add
the 8 byte field flags in patch 3.

3. Added flags to struct ib_port_data and enum ib_port_data_flags. These
are used to validate the status of cached subnet_prefix. This valid
cache entry of subnet_prefix is used in function __ib_query_port().
This allows the utilization of the cache entry and hence avoids a call
into device->ops.query_gid().

Anand Khoje (3):
  IB/core: Removed port validity check from ib_get_cached_subnet_prefix
  IB/core: Shuffle locks in ib_port_data to save memory
  IB/core: Obtain subnet_prefix from cache in IB devices.

 drivers/infiniband/core/cache.c     | 13 +++++++------
 drivers/infiniband/core/core_priv.h |  2 +-
 drivers/infiniband/core/device.c    | 22 +++++++++++++---------
 drivers/infiniband/core/security.c  |  7 ++-----
 include/rdma/ib_cache.h             |  6 ++++++
 include/rdma/ib_verbs.h             | 10 +++++++++-
 6 files changed, 38 insertions(+), 22 deletions(-)

-- 
2.27.0

