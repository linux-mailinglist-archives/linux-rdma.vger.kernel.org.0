Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7CF3B8047
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 11:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbhF3JtJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Jun 2021 05:49:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45730 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233849AbhF3JtI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Jun 2021 05:49:08 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15U9astq024337;
        Wed, 30 Jun 2021 09:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=3mzXGcE2iLE5VXuf2wNvnK4jCbT1mkvKBFNAwR3bmi0=;
 b=dFIETfx43PtvbUIZE/xXeUd3jStqpo7OmrHOLR6c4bd4ahJPB2HpQWFw62vG661jbIzB
 QMR8Zhjq/IxJmGPyEMdex/z+MF5I34EAmhPL5hsOf3+yDrOpOV/8JowbKgxc4A4cjD0Y
 +EDVGC3yPFH+PdbdNMBI0xyRYbnvmrbLmmQMo6wHNwotOgSDRga0zU8S7ISoW7Z9rJ48
 F5YWHjv02GHrm9YKg35ng+B8DJbaAvdI5PI9OdaAA7RSWtoWdkld3J8DvAjCmx+stuTv
 ncaXh8w3Fnf4AJxyx31JRPs26ED1VJ93Dq27Mk9Moxn1x+DQL3ckafOUX3su6aEx9Lws SQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gguq0kp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 09:46:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15U9jgAY137326;
        Wed, 30 Jun 2021 09:46:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3030.oracle.com with ESMTP id 39dsc10gmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 09:46:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJaw0yM0VwKGjapHnBuMrzCiDWx9CwWj6AqGkgbH+8RRL3FYnAbXDluxXilTgTwFSNniZrIB2ua+7o+upq71lQezr7aqwF9wYmRjnn9KQ0d38BUfqYZzbRfO90b1FK6xxHUhAt0kf8OnPKGGpWcTquN1pu9aFTiGbOmdlRGGIJAhkbEI1tVs4lae4VdyESCE8TRUDm/amBIR3oCK0TiRma/Tr2eMpeXfsRvB88I1kTNV7pSEW3ZBkErHeeEFfzy/NzDH8IMSR6EbLChd31hdpQXFDnJYdoD6nRhoAO8rPPxvXhspeusGaGdSMcoBOk6Xly5k9C6ERnNSu3261qWEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mzXGcE2iLE5VXuf2wNvnK4jCbT1mkvKBFNAwR3bmi0=;
 b=iyNb6RdUFWq17e3ZWN7lhz5/vACI0KiHHad05P1xr0ZA4C2OXUcUPnIVjw89il6W00f6WtiSxYuWbcpf278plc/NScdxk4QMbfsbohxKA/X2xvE9iJGNWwab+xvLuZGt+CpIfUQP/O7i8Ow+b0mqLYDCRTYUEDwF1cpDaHeBciEJKx25rzJfRacPSwMNV3T4RTa4pM5449zDTy5HVrTWGX8ZjEBni4jrhcHlymZ2tYR6UssF8z8ov24G3nh0phVM0NPmQjme2vkkn1uwX2XaHlVb9SPhWGb9t6J6gU0xvI9I0y1AYSQN9LtgVNTc0JASJhNg7xxHwRU/FYNgS8wD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mzXGcE2iLE5VXuf2wNvnK4jCbT1mkvKBFNAwR3bmi0=;
 b=TTrCA09cf9JPFrhM4Ab7OrW6ZG6K8u3DlvfpsiR3l/vDYmq/BlOhG2vynbIB3rA2UCo4G6phdTL4mkAu8FRvhxUdJArKHcuZdYf9VwgZBponPyKNRqCDmCtjrOZ97h71Cvx6WikR8/TfQBBt1sd+AqvKTmcdXi5Bf2s9IZv5Lks=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR10MB1557.namprd10.prod.outlook.com
 (2603:10b6:903:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Wed, 30 Jun
 2021 09:46:31 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4%5]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 09:46:31 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v7 for-next 0/3] IB/core: Obtaining subnet_prefix from cache in
Date:   Wed, 30 Jun 2021 15:16:12 +0530
Message-Id: <20210630094615.808-1-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [49.36.45.114]
X-ClientProxiedBy: TYAPR01CA0007.jpnprd01.prod.outlook.com (2603:1096:404::19)
 To CY4PR1001MB2086.namprd10.prod.outlook.com (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (49.36.45.114) by TYAPR01CA0007.jpnprd01.prod.outlook.com (2603:1096:404::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 09:46:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 240328a2-d87e-4a6e-e4b9-08d93babf059
X-MS-TrafficTypeDiagnostic: CY4PR10MB1557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB15570F4B3986B8D044C128EDC5019@CY4PR10MB1557.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +vu75K7Rvb3E/7fMwcXw2h4tUN2mgMWlThoJmOqgkp+EisxPvpc0nETtv8PMXQZY8B/hH6pxYiNZGF9Cqok0piQ8lL3CWPCAxsJVlSLvIqRba8tMweMXqrGnH8ZNuY6Hs4safp8asl1o6KfjWBnBjcaQ5Kkmm6Bbmo94LAIsAlsBKX61zr9IlNt3Ip3kTA9oy7vKbuDZn+K1Fn6k3bFrOPJTBKqjDKRq0z5NuwkOP+/KB9SvsxqhlH5luKarmZZLbhBY1sbDh0YrpI4ylJgfToNHJ5Z/xdPRTuobAZgeiX8e5KCITyrQXfmhiKaUSgXpjxHbCQo+fWRYM+ChtyMy3z1hhN1KctGiQK3qzZkZPXQij/GnKZOByDDulgr3RE3IS3JLGt72K89tZ0Qoyl4Ac+CGSiq4acDrvJjhbD7Vrd3TRDOABtBRj1ES+NopwrJr4sifFrnQ8GbesBXLfaCJ6Ab1GN1gB1R+zn57UVoWxYdUIVh/uNE+TiTKcGD+z5eAmiWbtR3B0tAA3JaKu2aRVxGXeEGDrlWHbJiD5g5AF5/URz1Rgg7+EdFXJoLsrgyd3GelMs0EHCV6XjXtDIzFUAieOadNzSPFJi/foMUquViFCSHniE6hsdv0MaIJIuyssnJaRLEdK9//3aCyEnwELhugF0Omw+fqDjlFRUCsVZ5h1kSXFNbJkopsvJLM1j+Mp9e180nX8gPZiC+ViFGcOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(66946007)(66556008)(66476007)(1076003)(16526019)(186003)(1006002)(6486002)(6666004)(36756003)(83380400001)(26005)(8936002)(8676002)(52116002)(478600001)(38100700002)(38350700002)(5660300002)(103116003)(2906002)(4326008)(86362001)(956004)(2616005)(7696005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MgVpq6WokhQ3ZBilFlmhAt3FkDLL2Uyv/nEJbT3z4HRyJPdUwLptYoZtSL3o?=
 =?us-ascii?Q?xXvGZJhRSXbBRa6wOsD1WSINmWhOEAKyqhudw1kawS8BwjfAxjBumqXYnHlb?=
 =?us-ascii?Q?05LB0W9V4OLW97BbzGIouj44oIT3ZmcAjb8IeRpMbMYrnJywLas5KFUc3A2S?=
 =?us-ascii?Q?UVAo5bJCASvffFcWVbaJMoSq1srca+S7lomUbRwbgB1EqA1j3RmLPjdHDllI?=
 =?us-ascii?Q?q3+xOXnzPzr9ecKzGFQ3OcFabOWLPuXxXzLolcahYIuIcgTzoYqttWIrhJdX?=
 =?us-ascii?Q?cc3szyjwbSKBsZqDm5QYXF/sxNJZupn3aMWQNVNz6Ox3cKudSSL8JWTuKhI1?=
 =?us-ascii?Q?sKns7r6Kriy1ma0aVvmG6L8f+qucKobxs/sauqlgQvn57+sFKneSfA5j3uS+?=
 =?us-ascii?Q?uasyetV/DyQ007XfK49eKcMzxJ+NiGHldfcMmoMGAu63MqGyHkIIOHN/pFgO?=
 =?us-ascii?Q?CihWNd9/U27W+djBU5c6zoIyPl25b/+PXXDRgnZBGBec/elZhGpabBfNoQUL?=
 =?us-ascii?Q?Af+136+T078GHEom0GTFX8T2E/lcikD4AXNXCD95vRrHaQ2ENl/7DZV5AiI5?=
 =?us-ascii?Q?FVtOrU35UXmpG/1VZFQMHR3VhAJAN1I9J8PMZy6kfFZ2NWgfJEqUERJOEX78?=
 =?us-ascii?Q?TgyUpTOg26eZBqBytzOxJdscGCa/2mMlEnFqj3vk85vX1lgoPVZn4LsoxVEy?=
 =?us-ascii?Q?gjvWpT9rbGzyDb8+44TMb+ltq8iaf+zzLPaTg62/XkgrQYgVU2s+KvA9Wsi2?=
 =?us-ascii?Q?e/ukPFVwZacyLbNq+FMa/f7DxzC4tCsNjNUGvzNxKlcu4VIXZsPhmWZQmuJ+?=
 =?us-ascii?Q?T7Fnxjr+mvUliLMYuYfidg2q6W6GdlBLckf4jVpdXPZGIJmblMBqIMbuImva?=
 =?us-ascii?Q?CBghHTH3l8cUbNbiPTMCKCtHlCsU3vcoOmF3OdX4/b4jxvc1e/oclgdEf1fR?=
 =?us-ascii?Q?gM49nBPvwsO6KTykYaSGkhxhtenYLjqdEhSBRHYEODW23401xpnJN6YIVhsw?=
 =?us-ascii?Q?mSsNvtvv+LroCZ9zA761cQc6tgysIu/aZG3gA1Tgw5pLmvVQGLV5KnpL73SE?=
 =?us-ascii?Q?9socjsE1QbCSR+6Yg3W15yuv5b6vtTRx7g+cDFC3hWFukZhucInbsLjlXDda?=
 =?us-ascii?Q?pHVYgpNPtnjXcnYb8VUfWVU/3JErvi7ofd0wx/Z1F6+TT1tKPvTpsYgE0ngi?=
 =?us-ascii?Q?ll7hmwb7tISjbRtGRLNEwNa/SO0uoE8WeS719bhndWlnVgyofPiDXWcF27e7?=
 =?us-ascii?Q?xaGrHe2Hr8S/9h9GLlvnUpvIOBJi7X2ywXv4urOQQEdV/wLiLCFDmvJgC9Ur?=
 =?us-ascii?Q?ytbyQX7rgW8raXaEHrjKqbeF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240328a2-d87e-4a6e-e4b9-08d93babf059
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 09:46:31.2972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52Bp1b9YFCmvaRVyObvuIbFwTakXUh2cregpKHgEsHztQ8Hx26mN/TmPDovcOFTbr0QDYTwMk+v9WFgpgeYk66XPhCKW4W+r4OmQL28t/gA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1557
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10030 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300063
X-Proofpoint-ORIG-GUID: sMtgz8HyuMrbLBZJblIyFFAh7mNiciIS
X-Proofpoint-GUID: sMtgz8HyuMrbLBZJblIyFFAh7mNiciIS
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This v7 of patch series is used to read the port_attribute subnet_prefix
from a valid cache entry instead of having to call
device->ops.query_gid() for Infiniband link-layer devices in
__ib_query_port().

In the event of a cache update, the value for subnet_prefix gets read
using device->ops.query_gid() in config_non_roce_gid_cache().

Anand Khoje (3):
  IB/core: Updating cache for subnet_prefix in
    config_non_roce_gid_cache()
  IB/core: Shifting initialization of device->cache_lock.
  IB/core: Read subnet_prefix in ib_query_port via cache.
---
v1 -> v2:
    -   Split the v1 patch in 3 patches as per Leon's suggestion.

v2 -> v3:
    -   Added changes as per Mark Zhang's suggestion of clearing
        flags in git_table_cleanup_one().
v3 -> v4:
    -   Removed the enum ib_port_data_flags and 8 byte flags from
        struct ib_port_data, and the set_bit()/clear_bit() API
        used to update this flag as that was not necessary.
        Done to keep the code simple.
    -   Added code to read subnet_prefix from updated GID cache in the
        event of cache update. Prior to this change, ib_cache_update
        was reading the value for subnet_prefix via ib_query_port(),
        due to this patch, we ended up reading a stale cached value of
        subnet_prefix.
v4 -> v5:
    -   Removed the code to reset cache_is_initialised bit from cleanup
        as per Leon's suggestion.
    -   Removed ib_cache_is_initialised() function.

v5 -> v6:
    -   Added changes as per Jason's suggestion of updating subnet_prefix
        in config_non_roce_gid_cache() and removing the flag
        cache_is_initialized in __ib_query_port().

v6 -> v7:
    -	Reordering the initialization of cache_lock, as the previous
	version caused an access to uninitialized cache_lock.
---

 drivers/infiniband/core/cache.c  | 10 +++++-----
 drivers/infiniband/core/device.c | 10 ++++------
 2 files changed, 9 insertions(+), 11 deletions(-)

-- 
1.8.3.1

