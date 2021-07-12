Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77983C5C1D
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 14:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhGLM3e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 08:29:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14048 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231749AbhGLM3e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Jul 2021 08:29:34 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CCNiNC007976;
        Mon, 12 Jul 2021 12:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=EUeN2FlUs0J/CHYtSHN6FlqiAG9uM09QpQ3NzijVt/s=;
 b=HTJsFkLkUxXpfgqf6VGKwV8wSnQU9Zqs/zIZY8I5oTc7mZkt7ix6YyvlME8cWMg+0hX0
 uty6clRNIDy/OQD3vU1pfM0aTUI/lxasVp5tVr1mS3mEnIfdIPdLzLt8S8Rw9SlJhN+v
 Zvp+NvYD0eOVWJhn7DR1DBZ7XySLpy8Z/Amf6/6rhaEDabpTljXWNr7TLOxtfNf25ciD
 GUFHW/aYP2/BwsocifHoczc3HIP7j20VTsgHTp5Nav82WwuUqt3mDhLVD/s7hkWTxhHw
 bxU7ys4WPn9kfUba3QL/EMZ8WVmYJq3qMQu+Go/JmgRAC4B3VXmYo0CRshXeATbVVtaE Jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39q2b2jjmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 12:26:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16CCKolP028519;
        Mon, 12 Jul 2021 12:26:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 39qnatuwsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 12:26:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCd0LeHGVKMCeXiEfE8Q91gWilnSBO6iIgCKO9+rVVVXNqkfPJhl/3vvhhJn6mLvYV8imx4kJzLdzGrZsLumxhNZyI1HdnjQEpjXB6Q2A3x2jZGK/zv0/ZLae6EHClEqq9xG02T9tDVm5wMg7PhBXNzbpPDjXnCHq9l+tawgfd6/DPotWOWcYObPaLIulIJRKXa21NuIRyaxwRi7M5K03IGi+1eH0zxvljCKUyQAsMDiUadPo3faMGxI+9Fv1/VruXaeIaVCQkeNq+ThWaV/t2ikTUK+opamj3vxqwh1sNKKbAdNaOGPTY7xQOFasUUzisvPCeYraLeyt8z9sjyWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUeN2FlUs0J/CHYtSHN6FlqiAG9uM09QpQ3NzijVt/s=;
 b=nzizbI9WzA34eZ8h7dWPUo8/vnzbhBwre25zbLDBrcHNH6lI6oyjHRCe9NLhb+5j7VJZCc/dh/M/eOSn71q38akyJaIBnHhL4QogW87U8vnJIlcbdF3IPejhTAd3VEFTP0wcNVrGHXkyYFEPwXfKp4j4nNRKZus5+On7bIDZUyvQGGlHGo4NP+58yWYS9mVkqU7ic562F6EJM/Ok2UuQHnW/TrrVX0aERt4U8a+VUFQf0RXUISybJpctXdeKVnI97oPhZ8gJlh0RNxis3wD+3omrjXSjlesESeBafssfZYWvLuOLc01/L/P1FPXktGxy5K0bUlMst9ARSbZLoK3M8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUeN2FlUs0J/CHYtSHN6FlqiAG9uM09QpQ3NzijVt/s=;
 b=ZhQFn/PM8lWPBIM1W4nGHIHwQWVBYzwSDL0ERbpzqVDS0/TmYWyhoDikwEUYO1dXO/f7UuApGhEcGMn4731FYuy+saem05v9HJU+UPTRWsgF2oLMRopwWkRpZjYqlq55EDp8vDpuVXg2Un6ReStQhYaMd2PLsx0jqXJmv9wM1mQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR1001MB2262.namprd10.prod.outlook.com
 (2603:10b6:910:42::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Mon, 12 Jul
 2021 12:26:40 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::9dcb:26d6:7408:b4d5]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::9dcb:26d6:7408:b4d5%6]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 12:26:40 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v8 for-next 0/3] IB/core: Obtaining subnet_prefix from cache in
Date:   Mon, 12 Jul 2021 17:56:22 +0530
Message-Id: <20210712122625.1147-1-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8015::10) To CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (122.170.228.204) by TYAP286CA0005.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8015::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Mon, 12 Jul 2021 12:26:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9513d70b-a323-4aad-b489-08d945304c92
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2262:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1001MB226290907A0E2D7488CF3913C5159@CY4PR1001MB2262.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKYeKprcoNY03DgihX9g8pLvTxpGAJDC4n2hR/PaaYLp+J4onFovJ7/u9wBACg0xkt6a55biW//GINK2bJljVno2edKT5D9AoKrQafxfu6JQBQlSnsolSOwq4QQI42rqrrVgdqUQUuh4GmFzRgxxymASduirf+hcKirHuVxOT6liBcSa1fDNEm3U9/M7s81G5UmGG7rUeWBzK4McjaCLfV8/HNyrJw1QgsFYkqLC9bdswMhSrzt54ezdiQxBphSWjz4vhL9eVewfSS3gZczuwLu5cyojEItrZhwGiFBt8WBsSa5G13Watg3lKzpIsDRWpgA/0xayWOqVVu1hBZagy8nakPN2qvECMoisuEYfw9kBklR0pxb75/CZCaepp/Qhe5z2SIlJBfY2Q1YN6t23JPTsMv0x75Ufx6THMJ+7z7xk4rYAKUPF5lu9YBUKjtjyT54/RJdPPHdQrzqrTsdxzs53TdTnH/LNlZV6CHPFomtycI8x2xOaewEDuqnrUOTrS0oAcpbhjxXhGnhcoqK03jIKeXtyMVs5Oc2MlgAVmrK9JdgBAjF4gQZOa4DTmiUXQu8dRIme6ZGxC1lAGb26vtIawz5lC+bPQcJKD39Bf0Y2v/J+Bekec9/h1JucM1Ls1ETRZiQR/2V+6BjfQxv4eiTqoe/bTLB8cr2kJKZJwRb8nF0AUoys29OGrLXP8LcuqZc74/DAU2fTM+byP3lllg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(38100700002)(38350700002)(5660300002)(83380400001)(66556008)(36756003)(6666004)(186003)(26005)(55236004)(52116002)(66476007)(478600001)(103116003)(1076003)(4326008)(956004)(2616005)(66946007)(8936002)(316002)(86362001)(8676002)(2906002)(7696005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gpsjuEqLTIRSL2hAi0qnfbrdMB5YvyzHA687PKcCrVzaC/UoOrb49LY7GLmQ?=
 =?us-ascii?Q?kqlxnQTdStghh0uJLyHRXVE3t6xxxvEpLLwq+qywpkuNK1+VjLQy4eR9qlG6?=
 =?us-ascii?Q?5agILbKOZjBa8PyemsYc3ZePL/H9DVYYcGL/kA8L1LWoeEL4o1tCq269TakK?=
 =?us-ascii?Q?Ke1fH3KZiZ6tJGJLA/MyYsmNoUTqp/V91MKI78qw6xGJeMvsC/r8rnd5s92w?=
 =?us-ascii?Q?KfPy9luWJLZN06lHNjlbSt5MOmZL9ayUszH4nFXnlfr7L2fpI6gBaOZk8Y+E?=
 =?us-ascii?Q?eyXKm8IDhwfOktDX8G029kVjYpTJViFbBcpsHRFg++rKwQjlNq82Nd4TNseu?=
 =?us-ascii?Q?yUxtTXqJax9eqSNMM8W3lRldbMS6bqwjc+GnAygfV9WAsH/e1thGwqe+zURg?=
 =?us-ascii?Q?oiAVq2D/Rbc33R4CfgOp8/bY1Br2RrhZ8TpPkYZP9Dv9IrrHx6KxgmgEyyBI?=
 =?us-ascii?Q?h2TYds7hXr8WWe/JP1gQ8uC0VN76/kzsyfn4/3rIE0wP/YtmZXNotMsUq3Oh?=
 =?us-ascii?Q?Auxjw/ubn34U6deBX91rkomlajqt2zU7o/G1zpN9lIQQ1e2Vn8z0273uhjTg?=
 =?us-ascii?Q?3RUceioqlkLtF1T/aYLJbFi7hZTjY2XafIhYrdDPZDBy3iAZqVNLr8ZCOFRm?=
 =?us-ascii?Q?ppESHSiOVI1HaTFh/nVQFP40TomhzwybE7Fd+MnoHenJcloyVz6ke52fUZog?=
 =?us-ascii?Q?wkpQTuS3iwbMSa57JaUpKD6jBxJGdVWsKDWqE6kZ0X2JXsLlljPw4NyqYk33?=
 =?us-ascii?Q?vUgT7O4T8IdacLpWnTWj7Vl13PtoZpF7wSR525W6FpxD98lsG/KW3lM5DiNG?=
 =?us-ascii?Q?Bad+VgwreQkllKQ5/7rz1z+3LHC6Ya/ypwCSC9j13uY0ifmWr84prbaQcr6b?=
 =?us-ascii?Q?5EC4U9NLaUAZEnLGVEi6c3VkDjBieKfGkZRv16iWlopls231y0QVtV/LbAMq?=
 =?us-ascii?Q?sEtKRcNIdR1hkOjrzNuwhlwKbPsS97hSvQNG87rWYJaKvDk0QOYEgslAn7LO?=
 =?us-ascii?Q?7gYlVPI2HKK9WEhy+EZ7F+U/eV81OuDLuQ1XROBEwoSqkolsXEAMaGtxgtiZ?=
 =?us-ascii?Q?mF/gocM0mVJRMoZPMqtif9Dgzv7CemZ2Rp51oTrIFoG4wcY/yKlNk+4qGwNN?=
 =?us-ascii?Q?+OGrpipsBQePLjYlCgtiBUVUs7t8MCjlKU/TQbi3QMRRFRKJlQ9x0zKLFUpt?=
 =?us-ascii?Q?6Tg5N0J9q2DUAnu+pZP1Tk00352x4Z+6ob6rzeKhFYflyJWmXGOunYRweEeZ?=
 =?us-ascii?Q?+T/K5uDImxA3dFUy15gq6R8L/pF7bPu4Y9cFQSo7Ny2iPAt0CBoVQXR/5AcT?=
 =?us-ascii?Q?ut6USpjQAQJek+VEwYo1PC6N?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9513d70b-a323-4aad-b489-08d945304c92
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 12:26:39.9922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmMLRvApYwUS2jMJcbGZ7Ud8DFbf4kx5IBP1dhOb2TvBTfbztzY82cH0+XTCvtVSx3aZV+rM9Tb4/XeRXay0N2RplBwaqiA4nhGQcSi47C4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2262
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10042 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107120097
X-Proofpoint-GUID: lGB2JsCjEByiNMz0c6IWmjHlDpCSPMVM
X-Proofpoint-ORIG-GUID: lGB2JsCjEByiNMz0c6IWmjHlDpCSPMVM
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This v8 of patch series is used to read the port_attribute subnet_prefix
from a valid cache entry instead of having to call
device->ops.query_gid() for Infiniband link-layer devices in
__ib_query_port().

In the event of a cache update, the value for subnet_prefix gets read
using device->ops.query_gid() in config_non_roce_gid_cache().

It also re-orders the initialization of lock cache_lock of struct ib_device
such that the lock is initialized before its first use in __ib_query_port()
during device initialization.

Anand Khoje (3):
  IB/core: Updating cache for subnet_prefix in
    config_non_roce_gid_cache()
  IB/core: Shifting initialization of device->cache_lock
  IB/core: Read subnet_prefix in ib_query_port via cache.

 drivers/infiniband/core/cache.c  | 10 +++++-----
 drivers/infiniband/core/device.c | 10 ++++------
 2 files changed, 9 insertions(+), 11 deletions(-)

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
    -   Reordering the initialization of cache_lock, as the previous
        version caused an access to uninitialized cache_lock.

v7 -> v8:
    -   Resending the v7 of the patch-set after rebasing on the new rc1.
        There has been no change in the patches between v7 and v8 as v7
        patches applied cleanly after rebasing to 5.14-rc1.
---

-- 
1.8.3.1

