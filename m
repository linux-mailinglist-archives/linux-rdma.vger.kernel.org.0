Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4573AA048
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 17:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhFPPsI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 11:48:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18772 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235594AbhFPPrk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 11:47:40 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GFfgaW015112;
        Wed, 16 Jun 2021 15:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ssFooo72YoVoCyeergCkKlci8KXUlqIQYVaIm+TulKU=;
 b=zeR1bOebGjPr5jngLbwt0vhA9EF5lUbIgvtuNpz0hJo5LTwNmQrcV3vge/GxjZj/6afk
 vUbjmBBa8ByDbNFJ2YyRfzOVp8ZGZs9nIKkIl6mT6/6mjKGQP7aCTUUQP+WH4EE03tUl
 MColDgkBJluoo/S7qGTm9WNReToOhxNNXg/cmoYj0VI7+LFqEFEe5RZqgkH/L8aeP+I8
 0d3OCY8cD5gbBEWtbpZq6GMXd4TH8BoJzJQlGE7ezyKQvMTSgOvFkr0HcjuVvff1BC3X
 2sqO/0/0P+xOh0v2/dAtGhOzWcGVVHLzmXBAiSubmDJ2B6aKZfLkcaD6RgL1TcQAnZC4 vA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 397jnqr85n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 15:45:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15GFertD093764;
        Wed, 16 Jun 2021 15:45:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3030.oracle.com with ESMTP id 396wap10gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 15:45:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=of7yzmn3GyrKX0DAKiKfGVuZvtAPuARVW5xn00CoOEeTbt0hkykF6NnFrKOedeIeNDdo0brx7yl2gHrXUq5axJgC7cbAs+DhU6ncYGLhvkxqdpmhNCZrvZ6/64ODbJb3NOmjjhJA/9wS5bzGpmvEb6+M8HpOxx2bFKIy+xaEFTA2PB60+jRNNG0F+LBbpa1UBy4pzeps55f06tOSlBD2x6Yep6+4Xu5WKlZc40hAWVFdwNqMi6C25/nHQfez7+EiJm7oEUJ6FbvQbeqwCiaJhOoJ2CeFX1rSAD8vFKUwX68s3EasBB8eamdGgXMW2v1UyLWgfazrgWVrSTK82okWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssFooo72YoVoCyeergCkKlci8KXUlqIQYVaIm+TulKU=;
 b=WXIkHkIvG57wN4OEHoA17OSBVJyISsgRxXp/jNVlRr4r539ZVYF3Q+ICGk88GTFxFLK7HH7P7hmXqgWOCYS8yRtrD/FuWsLwebWTHh7RyfoSmF85Nsh+3zgyqC9s1a/tRQmv47VbS/jHWNKRd4Tf/SSCznNKu5F4lgvTx9l7mIe/n+oEgHgcKzJinG/rrOnNaltRBdbBEdsmAUcxILMMTFg37laN6fHydB+HijnHSdgggRN7iHTpc/LwKabbY7yyBxCG9LIMiAMFRoGJhUt/431T2wDB8+34ZwvZhVK2K+xAKQWySjG+15ylTcolTRH9gLr2/YFOjMb+cBZJWk2DlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssFooo72YoVoCyeergCkKlci8KXUlqIQYVaIm+TulKU=;
 b=RueXKlmxq5xb7kr08Uor9/uQsDGFtp320ozw/LYOKVPYingaoTX8r+ZRoXW90UXxtRVrShLwEuckhVdQNVD+UAAOq/wISx6nwpw8lvmSCvMP0W3zekHzeGGlKKb4XQ6O5ylU0sgViz2L9uEEJmm4+OwauyEBfO+66aPgP3yx96U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM6PR10MB3754.namprd10.prod.outlook.com (2603:10b6:5:1f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 15:45:27 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508%3]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 15:45:27 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v5 for-next 0/3] IB/core: Obtaining subnet_prefix from cache in
Date:   Wed, 16 Jun 2021 21:15:06 +0530
Message-Id: <20210616154509.1047-1-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [182.70.80.33]
X-ClientProxiedBy: SG2PR06CA0129.apcprd06.prod.outlook.com
 (2603:1096:1:1d::31) To DM5PR1001MB2091.namprd10.prod.outlook.com
 (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (182.70.80.33) by SG2PR06CA0129.apcprd06.prod.outlook.com (2603:1096:1:1d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 15:45:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e58c72a2-0cf6-49a7-9f16-08d930ddc310
X-MS-TrafficTypeDiagnostic: DM6PR10MB3754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB3754410AB0D86D4E0F694153C50F9@DM6PR10MB3754.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GE3ZrPg7HqOSvvaCUkJxNiiXlFecSQzBhWH+WmfaiIjB0QiTWSV+PXgkG7bTezi9sVQXUMVUzuiR11FK/jdPBQuhq3Blgn7S5jx2Aa11OvCte479De9LkxenVkGpypzh0b+7n+N9+elADP4lIKw5tOT1zcOjYOm6czmAuawlyMxdy+ao/3d80EkOvwdgnUCRyXl27YttXJxsE1eybbnAGpt3MdhwPQD8dXYmmQp7rsI7QmROdPml0Dje3ZZWXG1UGxvg5i0UBEcKSqucyaaS4k5cWRmF8m5C+TBHsY7VKvP/X5b3VtzqIqaFkc3OcgapQk+nfv2Tx1hSFZG45rcF5PdrgsUC6YHecn8JBwpZXcgDLyjpqHKlGiiYHC09dWkCIBFib7jPJENW19d+DlIwK3qR+TfRRAVoR0iQfO+VONIiRrhrQ9OpbEJHFNS5NZbW/1Z6cgs+K6IU38i01c0Y0q5Ikj8BEdDS/MTPGgpcbgijaillL3qjhqD8XgF0R3A5TlwlQjQ1Sa714cTHE7+TvEE46eUYfCAOibnt+GVZtFMZCY38w7w1lDgsY3aSgn9UQ1EmyNwbPIlWJ6/R8sHmEdnmWBpNzzH6YArADKRqnNTwwbcy0AtitnpQynEp86YtnVcJd4M35z1+wQCshXqvHxZd4Pk/uSpXWEvZVx4pmWYzFWydz84Ev77hX4e4rdU2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(366004)(136003)(396003)(2906002)(38350700002)(86362001)(6486002)(38100700002)(8676002)(186003)(26005)(66556008)(316002)(6666004)(5660300002)(16526019)(4326008)(2616005)(103116003)(1076003)(52116002)(956004)(7696005)(66946007)(478600001)(83380400001)(8936002)(36756003)(66476007)(120606002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +33BSh4UfsMFku4rLh018hzoEOeZ02z2ad4Q8isC8ovUbMvajzNzEBxdx9SA3PibwqYgs0Bid9aLQJYpGuvU6JaFUr4vgzyzeicoaT1PBwuHXJmKNlnVKaUR0MX8N6Ro1xo2QEX5AtU7SlETxKlxw282dm1vOAgt5VZJKZs0uf+kknB6HdjzM3gKPVByJyjZUlb2P7KicVSpRy8VfxCEDzUgUnn+URlGqb8hYAaS2y/OQuj8BhR17CtkKJV7nYLCpUxqnc0ZrLEydFMMjQP8Ec+mNaeJOgAAEzgXwILvGLE+MMJlAE8tRtDLTNZ4pnIbBDzA0NwYsuTGICzM54CBu5o9LMO6/wwLyOhYC6TyGBo1ts91eXh6QDY9BsPyypykpRm4rc07mmcxVAoCkxZv/S9QF4gsX9Z+3b+20nhlAz1nhOi5cEKf8NvMRIgDBRUmvZ/2Wk/O3VQ3ZzOjnVIQQJVodJiO/0Fh6TvXRbcsUbfmMxIhs9ZN5WwqqxDomlszP49Ec60YHWq5xF1Sm0j77qwA2LP7vBZu+sn8arg/IINxx/IomqJJoAgABL+DgOIY0OLfWsYxjC7GE18qGUf6RPYlXgqJAhSv8nMkd2Zv3a+BuCbIlibgXOdXEE3mihhWFTgtvl51qW5huk5OaRR8mEXkRKbhcqaFmngwTlogoPLHv1/VCu94YMq7R8csUu4DAROgTTrudyYY5eJWVKsO+5dwu6aWMvy2Ui9IG61qyX4lJHyPHrpoNvul7OMR/O2I
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58c72a2-0cf6-49a7-9f16-08d930ddc310
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 15:45:27.1376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Gvm5v6/lHbH61Q2stRwEWXxu5IAWbla4aTC9MrgRqRK1Um8VepJKtWFpXPaKUiRmxgs9ya6yesBAz+0vJby9SFFJCBa5v1XdYccre7kWgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3754
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160090
X-Proofpoint-GUID: NwKWXWpJvWaBCP1CzBrVY1KmxjQoqKCR
X-Proofpoint-ORIG-GUID: NwKWXWpJvWaBCP1CzBrVY1KmxjQoqKCR
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This v5 patch series is used to read the port_attribute subnet_prefix
from a valid cache entry instead of having to call
device->ops.query_gid() in Infiniband link-layer devices. This requires
addition of a flag used to check that the cache entry is initialized and
that a valid value is being read.

1. Removed the port validity check from ib_get_cached_subnet_prefix.
This check was not useful as the port_num is always valid.

2. Shuffled locks pkey_lost_lock and netdev_lock in struct ib_port_data.
This was done as output of pahole showed two 4-byte holes in the
structure ib_port_data after pkey_list_lock and netdev_lock. Moving
netdev_lock shaved off 8 bytes from the structure.

3. Added a flag to struct ib_port_data. This is used to validate the
status of cached subnet_prefix. This valid cache entry of subnet_prefix
is used in function __ib_query_port().
This allows the utilization of the cache entry and hence avoids a call
into device->ops.query_gid(). We also ensure that in the event of a
cache update, the value for subnet_prefix gets read from the newly updated
GID cache and not via ib_query_port(), so that we do not end up reading a
stale cache value.

Anand Khoje (3):
  IB/core: Removed port validity check from ib_get_cached_subnet_prefix
  IB/core: Shuffle locks in ib_port_data to save memory
  IB/core: Obtain subnet_prefix from cache in IB devices

 drivers/infiniband/core/cache.c     | 21 +++++++++++++--------
 drivers/infiniband/core/core_priv.h |  2 +-
 drivers/infiniband/core/device.c    | 20 +++++++++++---------
 drivers/infiniband/core/security.c  |  7 ++-----
 include/rdma/ib_cache.h             |  1 -
 include/rdma/ib_verbs.h             |  5 ++++-
 6 files changed, 31 insertions(+), 25 deletions(-)

-- 
1.8.3.1

