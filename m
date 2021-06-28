Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4695E3B5B40
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jun 2021 11:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhF1JcJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 05:32:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35626 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232152AbhF1JcI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Jun 2021 05:32:08 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S9LOF7007220;
        Mon, 28 Jun 2021 09:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=xWujnTjlCIgqLpVUAR/BRSfu4oVroJURAvG5aPbKYZo=;
 b=OzMnN3TxuVSaGXfD+KrGwWsI0xBUXSFObkXy8WZD7zZRb6inkUHzPZ9gPv4VS3A0Rg1l
 TLSn+TWMt6zKDxH7uRd0ue2HKZAqV3gMXwBitf9dRrUIjqotHR5UqZmFHViK7ronWPa2
 GGLcvPvDw+yUCStfn3LWP22pK7uQbhc93sxRmlUijlOB6tBTal+Tr6vxQaX3EtrhLHSS
 tAizJ6se1cvwxezt0SDpDn6/2H5yS3EyVPkc7Gz4GO+nj2dJKORhp4bek47baHjGcQuE
 CpeLaDhviN+OirVdclh2V3IwGuqqoJC1jq2+CwIp5yg/nHRrN9qwiLJT8qrZGFe99y+u Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39esfks6n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 09:29:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15S9Latd135097;
        Mon, 28 Jun 2021 09:29:39 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by userp3030.oracle.com with ESMTP id 39dsbv47p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 09:29:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N20y0G/03wRAsmSddNOSuMJ1g/dq/P7rs6It8i5ZE4n+h4PvbLC0bLbD/s73e1jXQ0Gq+tpTTtJ+D169ZKvBD9UIYt1sQAnYfuGyhW+X/hwSZNB0/Wi6BL6z2uPGBxkQSz7W1fAfiK2R654Be+KJay6CEzhcLOqU3k7CrS2ssH/qBfZWJCFOrF9tqNCufP+pAzbgZRdV+M7rngFKS80cygqulYjuLK0mhDK1TNXiHfl7dedT4DwjcO/qJeX1/TjghxBsn5uWrNliioldbA1k7SKO6SribJTGP3bPWUMIDorUPrk9YNLV5tGcAMLhD5HR8TPwQZ01tb7H1Jj5XBGJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWujnTjlCIgqLpVUAR/BRSfu4oVroJURAvG5aPbKYZo=;
 b=mhsP/62tbxTNFzHK5VOOXWuHevF9TPNAdXACzQWITyIDgImoPfg9QTZ1qNfCUjlU9y5+SWex4LG1PAaPlSFIbEB5C3DFyTHPPeQn1WFTX0i8XNvpJdd/Y7F08/7mJhK1TsP1y4UVBeGH7tzKrX+Qh8l9/eIj7EW/sii2wE4xeGBtvHuXVKb6Ccqw1m/DaM8Spl3388JoXHZo7/7V+uhfpsSuIl4i7YnaG187wkAoZo3l0wMgGm+SH+NFyV83dtc/dbVuy1d+DrHwuBPnobeaDtUf6jCWPlvxARV5uJjQVW6c9Wd1QAi6qIbU153zgzyJcYntHRN6uvXttHbGPjPDDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWujnTjlCIgqLpVUAR/BRSfu4oVroJURAvG5aPbKYZo=;
 b=np4tbZ7sqVN1f5NXdhlnOFX0VbR9RgGHXzbjEiEF2iX6h+JK80dF2nTaljYpq+n1yp0xXjQaiuJJEAe/HsaHKjCv3O9shGCAbeib28uADVuXYQYjHOBypnilDOZYS3ga6XMX/RDn6sfKW6I5Qt1d7CUOqbv5zkNu5NVTBT69LnI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR10MB1607.namprd10.prod.outlook.com
 (2603:10b6:910:e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Mon, 28 Jun
 2021 09:29:36 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 09:29:36 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v7 for-next 0/2] IB/core: Obtaining subnet_prefix from cache in
Date:   Mon, 28 Jun 2021 14:59:18 +0530
Message-Id: <20210628092920.1088-1-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [49.36.45.114]
X-ClientProxiedBy: TY2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:404:42::23) To CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (49.36.45.114) by TY2PR06CA0011.apcprd06.prod.outlook.com (2603:1096:404:42::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 09:29:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d7bcd7a-5794-497b-6fa3-08d93a173ecc
X-MS-TrafficTypeDiagnostic: CY4PR10MB1607:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1607D7454D2892E3451BE73BC5039@CY4PR10MB1607.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SydTR5z5C3l0WxlcZq1ceurB8Dy/FdlhI+zrE6cIS6wD7CMoLRcdFCLRkXW6idL6SqJ2SxNhJQZg/U8eg7bx1CholPMcSxEedNY3TFWBvrTWqVdxCDRGFzAMJ4nyLe8VECIhbmukXkcfRrJXytg/HdGItBqNdE8rvV64P44bvTYfqSDM2dBah8tQao/M1Q7rADnPpkwHqfcpbYyxmvn71rNa4POGh+SzeKwV7VtdrZ/dp90hliKLdnGIPixOxERFy3kgmIOsFNz7M8QedPmCcIZjTLWg0Ar69pyYAOUp88kQXAOODV6XWWee7H4eHRE98nDy/oL7jCQ6SOkouxpsNmp3QdkNggTDLg9EwDPRrN25Qy+xcZNrskpANqYwUQGheiV68nWblWUj0pXkkTRSvEcgrYk5RmGuKy8+Yh3lYA+zjfoIXMbecMc1KZvfgBQlPoNxva2Xq9HwcwP/IMPJpTMgv++2i+D7f6ivnlSA/fh97UWb+PGoU+L0OR43ceAdV21MnqRfwj7zgY78TiILWXw2K2YdigmpMqhVheCKgKihfqlMIZ+7nBnkrWVaRYP5ryH/AxJpXdGA84hF54YeL96jfbK0LjQre72zP2s1ZLObAAqooSF9ODxhpnF/PbrY9J7yEWnvbdSi/VJj5x8P5IsEZDTWGVGIdoLsjS1lplOvdlmzCfjReD43fmmA3dLltmxR3X9/NRq7OzeYFJvBIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(366004)(136003)(6486002)(8676002)(956004)(36756003)(2616005)(4326008)(7696005)(103116003)(478600001)(8936002)(5660300002)(2906002)(26005)(52116002)(83380400001)(1076003)(66946007)(186003)(16526019)(66556008)(66476007)(86362001)(38350700002)(6666004)(316002)(1006002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lFYniFCMP7bOLnWwVa2KHPeprQ4etvTC0Z7GGdOPZtBpXV1HIlTXD4mxTLa5?=
 =?us-ascii?Q?2m9kEnvItQhsvvxm8ELkdQp9Gv6zrvAslRWqt2EzdYsUHwVpxM7K+BGjZpY6?=
 =?us-ascii?Q?fQzuLSUDsjvTnHA0Wg8rDSaAPBuOETLDIMiUmxWVlbZ+aItEUahd/rsNOX4b?=
 =?us-ascii?Q?YEbO8QHo8Aoi9yjagsDIrEcPOSVnKtZeOu35IIQJlU4Vlkv2oWiVrkuRU/tp?=
 =?us-ascii?Q?zkQbO5o8zJrsVciXNB324D549iaO8otKv6u3qIRR8yxKzRL3xkIGWe4l/smV?=
 =?us-ascii?Q?8Hc4tCafQPLz+9vpbBfr9kJs1HeD4bgDW6j0C9BNwr2FmhNRAoJ2D4UaWd1Q?=
 =?us-ascii?Q?XqLntmy2l3JHfU1/8ezF3JHdpVat7/DMBxMTepIXYUwYRY5AYsVIYSqyt1GI?=
 =?us-ascii?Q?m1y9dWfReHzWgW9tOj0gWWGPZmceJZOits4UPgw/nCX81QHkIPh/tc+8ikhb?=
 =?us-ascii?Q?TU7tsn2/YP1sLkVfxvUu5o2s5yhP0gpuyVqjR/QN29TKiNg4QjBwoGxIL1XJ?=
 =?us-ascii?Q?rJWpgYGpxhm1Q1lmxQaJBDT/LjwyRLPgV6b57jEh9xLr8S7DxIkQ17OXNn8d?=
 =?us-ascii?Q?RQj1Aqf5WuVmfrhbOiHoiVuUADwMPnHpM9ceiMHVE3TI77w8cGHSTPqWmxr+?=
 =?us-ascii?Q?/rYqK+xHXTgAWYCbf78YC311FiTiNODnS1igfGfKCpzDr+Rbn6++g9y+dKZg?=
 =?us-ascii?Q?K3TRMRvihTDIDvW1gIHhadk2C9YtHs2eJCRjHO3ijmixMDtzIKmSq7KqkNZa?=
 =?us-ascii?Q?MBHUTQcKFL5BwyDvWDKBIzL9pSDCd2uObULqB34difyVfyDb7UgLsijgPCFo?=
 =?us-ascii?Q?nJnC7zvYIToNhizkTiYzOZORUslGsb/CXXkx/d/mOzsYCr635COnr9kkopXo?=
 =?us-ascii?Q?p45sS8yo3w22dmmfHJfI0m7CtpBjA1vANphg+wkfCgvlspLo32GhL8ipVlBS?=
 =?us-ascii?Q?OuOjiY3ZMjFW8S+D41J+6JLe5FKP5R1uSfeSGHaogNKYvGTLZTH3iPiIyHb2?=
 =?us-ascii?Q?GRy9KmNvb4n3ypKb0K8J6A8/vkVFx+GntmwtYLSF61JSRHg8Zlo7bPHmY+Mq?=
 =?us-ascii?Q?rkVG4qjpTiPtqpVyPxxKRtdzWjjBHO8Ho0fkthadTNHEvS7PPQ2fTZSoLq9w?=
 =?us-ascii?Q?XhcrQSdvg99AWn1X1iMLcwluMYItgop1ggyQY7HMT8i5VBhg/1/KkCFOmq+E?=
 =?us-ascii?Q?MAY0yyQ/P5VkhBcvaPdv0967fRoKFGnCexVS3IIMS/VkorbYm7EBh8Kb4rdN?=
 =?us-ascii?Q?0+HV9zjl0aYopX30MN1CW9fv826zlzld3PvBNO2Ggz4xttJjluFYx9V2CXSI?=
 =?us-ascii?Q?YBX/gyTmEkLh60pb77YkZol/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7bcd7a-5794-497b-6fa3-08d93a173ecc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 09:29:36.6197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFwEFTzJVzbtUMEcRsrQ6LDsXHHeKcI6wYTm1rCzkBKMxkWGnNlaUV0lW5Eb4LsD9HYNvNqawPF+E6AIABibKr4F87hGYyxSVm5fbycy18s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1607
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10028 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280065
X-Proofpoint-ORIG-GUID: vOTgs1kq6-Jd_TyYIShNaWU52SUGa4Ij
X-Proofpoint-GUID: vOTgs1kq6-Jd_TyYIShNaWU52SUGa4Ij
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This v7 of patch series is used to read the port_attribute subnet_prefix
from a valid cache entry instead of having to call
device->ops.query_gid() for Infiniband link-layer devices in
__ib_query_port().

In the event of a cache update, the value for subnet_prefix gets read
using device->ops.query_gid() in config_non_roce_gid_cache().

Anand Khoje (2):
  IB/core: Updating cache for subnet_prefix in
    config_non_roce_gid_cache()
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
    -   Added the flag cache_is_initialized back as removing the check
	from __ib_query_port() resulted in access of cache_lock before
	it was initialized.
---

Anand Khoje (2):
  IB/core: Updating cache for subnet_prefix in
    config_non_roce_gid_cache()
  IB/core: Read subnet_prefix in ib_query_port via cache.

 drivers/infiniband/core/cache.c  | 9 ++++++---
 drivers/infiniband/core/device.c | 9 +++++++++
 include/rdma/ib_verbs.h          | 1 +
 3 files changed, 16 insertions(+), 3 deletions(-)

-- 
1.8.3.1

