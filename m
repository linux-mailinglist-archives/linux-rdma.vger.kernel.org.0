Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0D23B525A
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Jun 2021 08:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhF0Gun (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Jun 2021 02:50:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43392 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhF0Gum (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Jun 2021 02:50:42 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15R6lEsf011692;
        Sun, 27 Jun 2021 06:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=2srh9PUgpy12HO/Uz7j0XEiW5rSHxwCmQK/CQRLdD30=;
 b=x5/+CIRqEeUJkF7lv+zSyDRwuI009BQG9STWJYnFsrdQNCAi09PDpInZcnE9pyb7Nsqs
 hd6sYf9CgbDgW91V/EhwBLcnPAHral9EvaJYRizUJwPQt8GgvbyZOQ6PFwiDWBKPxFCr
 WVkdubm0qZvXu4QVvJzzOjQpsTNWX33eYqP3SVtfDNk1JOJBimFnRJSZFJYRC51Hluqh
 Vio6aW5FZbqdzLyxakSVGIojOqV+gDuRXCDn50iNpHOnhoazl39hgJTUiK0NglXf67Wy
 xDm/mMztAHUfARzTchxGqnuHNU3qV5AfH3SvbsPVllNI0x+65r/g36LYQcH/awbvZVPZ LQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39dtu0s46d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Jun 2021 06:48:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15R6jUG5091500;
        Sun, 27 Jun 2021 06:48:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3030.oracle.com with ESMTP id 39dsbte82r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Jun 2021 06:48:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+0WhUDZ356qiRwwPXkDDcV/pudj1TToIL8LUbCDrkU9m0gyB34zz7Br/7/dcY3E9GAoj77+2DEAx7PJ1Pn0xjoWvPb4xVyeJHrJtFy53xvFVi2rGjRAdMq80GZvpJPKELQ8IknDuPYE642hK9YXSYmNK2tLHfJB7Q/2Uk+1EO3QCJNTEQCfyQJ3uBjHejlt8A7LCw9M9jcy5u4pZCNZfrvqSDrVM1r7e6mDWMBz+RwWmQ/ZR5hBdFndpaKK1WJj7SdCNhqeY8tC/P8I1KOuB3EWwVWMk6sgUzVvmAuThisRlPUhpvEmlvL9ND4YaL3oT2q/Dd0OTVkEFY7GSpAXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2srh9PUgpy12HO/Uz7j0XEiW5rSHxwCmQK/CQRLdD30=;
 b=nuWKJVpJPOKsZsJtYDnWPMnh10GFDrb7e7ZIkeyrw5/mudYGjG4r7wa69tLHDYyQ5fzO9uAathTvGvRb/kYd8OupP2vwDFfNmynJ4uYkbv5OJBsj+pTQzKlXYeEz8QqrK+2DmntNb9AohoT78tB3eC8Pn20TQmWj0SmNIzCiy+IvvV/qyz88tgtJcHW8gxsjAYkTH0K/HxdTrp3Wcc1opligdShltiS79sT54/YItCo3qRy/B1ITmJkEXgRxK8uzWLBJUV8oSPyM/ywFmzfrb1BukuOUG3FD+8bB2s6M7ZorOdriFaA5Hu7jZpVU8RtwHs/J8k31xmc0ushVz2Ph8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2srh9PUgpy12HO/Uz7j0XEiW5rSHxwCmQK/CQRLdD30=;
 b=uRujNDyK58nca08F/m9l2y2pVmxiB+nhD5hLXs9AZHwt2vpb6MG5wfDXvui+uEon9er2BveyU4p0QOs4om82EyogkA3KSvIQmrjY2waGf1EeqgKdTbj46EN87by2g83xQEDAbX3GnQM64JXGHHgo+FmP/H2hufQw3JYcfs8wMCc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR10MB1704.namprd10.prod.outlook.com
 (2603:10b6:910:8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Sun, 27 Jun
 2021 06:48:12 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4%5]) with mapi id 15.20.4264.026; Sun, 27 Jun 2021
 06:48:12 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v6 for-next 0/2] IB/core: Obtaining subnet_prefix from cache in
Date:   Sun, 27 Jun 2021 12:17:51 +0530
Message-Id: <20210627064753.1012-1-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [49.36.45.114]
X-ClientProxiedBy: SG2PR01CA0109.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::13) To CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (49.36.45.114) by SG2PR01CA0109.apcprd01.prod.exchangelabs.com (2603:1096:4:40::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Sun, 27 Jun 2021 06:48:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2013dae9-0d1b-4176-cd35-08d939378800
X-MS-TrafficTypeDiagnostic: CY4PR10MB1704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB17046E434D4E56CC0796613FC5049@CY4PR10MB1704.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nei978wuXhIs054LercwqJmqhbPMairauHDkiXswC/Gl+OzMjl29BYbzyUXubXcYtr/90yPhoQ6V8ypghDLe6yHTyjxfCEhJw5w8dM0aDv2nJ3Cdi8npXGwYtZgqCkgIeygxEFm22k/kkhp7R3d40PBae89kQE4poiK06FilUM5RsB7thinAMUVSY9igSDdg2yfr2i4Pkt9F37xMZyxOj393ygEK3BgeD5Huk+C8GYzk+Zmi+nUuv2AqMDyBU8liOn8ZsRvjq2/hqrDF3tp0GA9L0pt+6LVlkSh2dhPe62n6BzRZrEqfqfXbX4YPHp2I74Yaxn49HDjXyRI9Pf0hA52qPdp7hxolmVGqRfOkOSphG5F0CwAWC/CNFqsHDEujxs61AF+oumVp044iPF2MDXfWBbq4c6LATPIvMBWUbbzYsnoW8KPCw4ig4p2fd+7rmC5uMB59FKV9IXN7uG3bEiL2p2CK1PP064C/Rw5L0OKnxE0hxtTWrEpFBRx27fW/cqLU+kzjgOPCSsgNQ1NBCT1fOJbty921wtATITrn/1xMcnQtnP3WzXE7QXWB6raT7DpkhtkkG0178b/IDmpdRdk6318AzX2Ji5H4rWJtnMU/PS1B9uAkqIYwBcXORbEOTHzHr9BjgjK6VWn4b4DWJzgvvIv/C/tMGRguK/gE1UKsTCXP9HszSl/vQNTmDtntGGRaoqLKigw35WdPVQFI2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(39860400002)(376002)(6666004)(2616005)(8676002)(36756003)(6486002)(16526019)(66946007)(103116003)(1076003)(478600001)(1006002)(4326008)(186003)(86362001)(956004)(2906002)(66476007)(66556008)(7696005)(8936002)(83380400001)(26005)(38350700002)(316002)(52116002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qqEegz9IBlNr50yyxvTI1ZT/XXPXV+muJcyEMefd4W2WH/HEPgimD/vfLKi6?=
 =?us-ascii?Q?rK2GK29eluTcA8WHoiNmarX9DVJWGYQzm4Bas+xJ/L1PFYpdqtQW1Yd2mSGA?=
 =?us-ascii?Q?N6RsrVFgA/GygYHjiNqkUcKsWOnks+2tA10cGlOfJFBo4+TNIxV8juvvbtJZ?=
 =?us-ascii?Q?Bts1Dmzu0Bcuuu3a93xTk6pjmKs9yCWycuev27IbjQbL3IgNU0d3uxBRk4C7?=
 =?us-ascii?Q?gGvKRiUnlzVy6/wBf/vWKSrLXbN6iZjW6ufOHP9em7N80FzY5yXJ1KLkmg2k?=
 =?us-ascii?Q?VQJSpbOiAgf5AedSXZ2ruWgbgLwjvH2Ook1VsVHbEY9dqnqYpKzUIeq58pP/?=
 =?us-ascii?Q?A7yqVs5IXLI+fy1IoIrri2wePUosmtx0xIeQYe0FGHqQzGm39BWVSHB/+8R0?=
 =?us-ascii?Q?G4UXGwdCXn7TltuBr5a4cX7iu2LSh2XSi3AsPsKGU6Z+WjEN54UK2Q0hrukf?=
 =?us-ascii?Q?/oZ00LRzD9Uq0cTc3rIM29doFqq/JcmYpWJTwVg8PLrGjUbUxcwRzI2RD/ot?=
 =?us-ascii?Q?+04Og+nh6unRN4ui6yowM+z0xRVe/aUcpmzTv1TFqS+/A2zGG8W5XWaPByx9?=
 =?us-ascii?Q?H1hyJhLsCVEZilOufKHBFUMIvXxdDdRtW6LL5am1JVh57O0bIdTciFfwO95c?=
 =?us-ascii?Q?E+jW+eBlkjeXv1WxyxYnmuFY4UbaBmCdAku36x6Hk5WyvKi4NCxB4m+Jgeqd?=
 =?us-ascii?Q?DjTzKtNY0TEVVZ2IgeiAK1amUCQ9IdWlw3WCP1PmP1qopU8ua57xnghcgIOC?=
 =?us-ascii?Q?1PohH1SWjyLC0fNqv5F6gvsv3cvCj/mKgayfrQNIBNkYD5QkPselLEug8ogR?=
 =?us-ascii?Q?BNf0TcNGok4h69Klyemet0caSXCxg0/R4EFpSRzvKkdOLo54NxuUU9j3nDR0?=
 =?us-ascii?Q?cFlQUjXTFk3YykfDZ1nf7X+GqVz78nriYeo6IOdffuHn4VneZ/F4+cDu6vBT?=
 =?us-ascii?Q?egn04S8AEGzep3kGswmTroWblQ0YYTOfO12WEA26hdH27lyq8ylTdkHwUq3/?=
 =?us-ascii?Q?xhSYSJDziL1Fq9pbOdcQUSkm7I8ABjK6ysECuspX0XnYH634WpmAbP7gXzzu?=
 =?us-ascii?Q?YEEM6rpxO4ZtC5r65gZCOZAoh9NiW0gM91iBXR0rssIV3Hj7A0vdYZ7g4KS8?=
 =?us-ascii?Q?Nz223X4pil8loiDsIN2hDEbNHfQxSbRzUmlkPH1XB14Vsg7fYFF1BvkancGd?=
 =?us-ascii?Q?BcGnyu5hu9rdI9KRBgd8RF1SzKvKB5uYNwHmjlVvWKBKCZs9c4CZA0FXbLmD?=
 =?us-ascii?Q?W3ba21roHJD95y6oVtbd0kI8SNstvBQom6BkKY5fGQmY8KEtrK8ULuVenVRG?=
 =?us-ascii?Q?ouQMhksIJ6b13bO/dsKnQ1+S?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2013dae9-0d1b-4176-cd35-08d939378800
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2021 06:48:12.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2a8JdU8zzMcNkW+hHbGhsfp8+aUDsuAHLynulzpVqNl3Xhk9rSBe5DeOf9UOqDHCcrgi0GxA3IVZGTYej3gf+cGf8E6XH9GZtY527HP+Das=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1704
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10027 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106270048
X-Proofpoint-GUID: 3kTHZtrLXII9h-LHStD6i_UzPC2j3JIX
X-Proofpoint-ORIG-GUID: 3kTHZtrLXII9h-LHStD6i_UzPC2j3JIX
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This v6 patch series is used to read the port_attribute subnet_prefix
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
---

 drivers/infiniband/core/cache.c  | 8 +++++---
 drivers/infiniband/core/device.c | 7 ++-----
 2 files changed, 7 insertions(+), 8 deletions(-)

-- 
1.8.3.1

