Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1997E3A932B
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFPGyn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 02:54:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11676 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230515AbhFPGyn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 02:54:43 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15G6kL62005728;
        Wed, 16 Jun 2021 06:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=L5RL5IquEqMfGhXspMQ8CadbIB45ldhmK3mBd+/+prw=;
 b=AhGqIWiEJWwGIHwUl0k6MMlLbdj5TQxf5FrKEoSTQa9NTz6bO96CX/A9Mc73MOahqdDz
 JI9tbROOzswWsUuPT+zG+qgucXI9HH8Dnz6Fxt7bBMtTeMWABaBHw0py5tmoXqnX02e+
 BJ4GDG+2WZCOJpBSfmlBOVG1+0Z1GLexufpBQNywtFuZqfuZ7Xk9QK8o9pyXpMvQFW7B
 npRHQWKrsRBrfg++JuiryQg0wjLav2m9jQWdh0EFVmds1YqWGKtV8voHnPpGbp5rwGgA
 sjuCsBA8kyLjpxliaxi4rWkidD0AobUf2JD1mxyuujiJlYbeOixeeaPAGWuh3yoSDoTD sA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 395x06j0vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 06:52:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15G6oqtJ013680;
        Wed, 16 Jun 2021 06:52:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3030.oracle.com with ESMTP id 396wanfaq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 06:52:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYmp+8rNHhgm3YrGMibbgLaHlehAIb07RhmXgeNOzwx+RGhXB0/ydrNonlKZ6klL+BjmTDIjN9oikYp+i36IF8K7cPtVbRCMc49wgKDaAyH+0xPRw3X2KiJBwsVPrfoZhskbk3KLPhJ53qTrDNtAiYHB3S/7YEkukudU7JFzkzHxvg4OqeFDaETagQKX6CJZ0V4klg4xTnfV8Po48xLHNf+dqz/o75FYzBSjeRdBBh02PXGQ/xynaiJQ7IupDMD2YsoXGZ/fyw+JUkff6UYz4W63xz3h4A6Rt9SepyZlrYudj+OUGGqjBiL/Z48iTUtqyRCDZO/QE89c1nMKqsFkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5RL5IquEqMfGhXspMQ8CadbIB45ldhmK3mBd+/+prw=;
 b=fce7G8iNPlYRe/3kiDqZDr3dWx9l3BfsaSqx5oztK8nBweO1zgulM76C9BLF8dCkGKxeVKx5YCpCOEOMbxOfVpbrtvJjffUxN/uS4fq9N51cobYhyI60W0qX3n1Ap60iPBulcLOtZvgq/Y8qESSlYE+kDnO5uCd4CA1xZS0MekVPCk2SSa/KJKqh28Z9wS91b3lHikv4w1MK5BymvUvy2/oSUwxLHPD14D/omo6Jp8vQi8KE5QxsXGIsAW3o7Y5OybjFj198393gEToKQztmfvWwb7nq1DJYR1OKdv2nsuX5lYobI1099d5QBfKpuyh7UM8lIdQbQov9boAOTAUXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5RL5IquEqMfGhXspMQ8CadbIB45ldhmK3mBd+/+prw=;
 b=OtDQafa3HO6e0e/hajF3R0dRQOAXTxlfMqZz57suiuJJaPli+JPieTpMPz5cgN8C24BaCcJWYz5xH2iZJ7gpaR5arD6dsexwrOpERh4OevA6zTcEeMMdksxzogxleDxPbxacj6UNWWossladbWb+PsWmfurilr/zC5fay4HUdJw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM5PR10MB2043.namprd10.prod.outlook.com (2603:10b6:3:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 06:52:31 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508%3]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 06:52:31 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v4 for-next 0/3] IB/core: Obtaining subnet_prefix from cache in
Date:   Wed, 16 Jun 2021 12:22:10 +0530
Message-Id: <20210616065213.987-1-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [182.70.80.33]
X-ClientProxiedBy: SG2PR03CA0139.apcprd03.prod.outlook.com
 (2603:1096:4:c8::12) To DM5PR1001MB2091.namprd10.prod.outlook.com
 (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (182.70.80.33) by SG2PR03CA0139.apcprd03.prod.outlook.com (2603:1096:4:c8::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 16 Jun 2021 06:52:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 931900f5-de86-45e0-f477-08d930935036
X-MS-TrafficTypeDiagnostic: DM5PR10MB2043:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB2043F26826B86EE9608DD410C50F9@DM5PR10MB2043.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUqQ5KQ2TH5svih+P+0wDBoqHfytHcSJUHpxDOLk03qgVhhM9anvb55LfGdvU1AuaU74CAQrTPRm5GzxwhPwDxGl68RR24Z8TQPpVymTLjN9TLoxshEXPkoTf2fH3qkNRQO8m1Hc+XyGx6j9H4UMHdplTJXnr902hqpk8eUmuiiyG3JBac6qh1iFkS/uFPBSPap1is142IUtDi+GRWN98BFs1E5XsIUYPjZOSDP2GKYSMQ3BpMyASc7Ln3fPAZ7FNH6bGZGf4X9XKY3rDvj5W/ZJkWmireeZgjFCzN6z1GRs11KsqpUuwfZcht0W5SDgvsWWPQfTcJF+fC/Y6GID6wn2Fi4cjL9plCsr/d7HpHAySdyfOlu32U5IEEcGvd2cZqkNQ+bQT1Hb5VtTw2Pe3rZ+YTFm2pZY1bIfsp4jlOOcRJsgnciqccwbS36YhkqeF35qDECNBSRrajsrpR7IaXIUGEofIkAqFGM5MEQaG2l8vxzplV8SioxRr3nvEeJjtyf+qsqbPxeajX16E1H3Vl3O7R3/uEEm3t6fzWo9NOD3MnyjH8KcILyTEWhkGChj5/T178b+q7xgVae2BiviqbuFpay60w6/Tj2WYHb3j4fJi2klzv9+awjxLefdX4oewNk/JP8JVNfn1qcSo0z7Bug4zlqIsRJop6vPU6PGSKb52nD1GjuKXBOQAhBEkIKN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(346002)(39860400002)(6486002)(66476007)(316002)(7696005)(36756003)(52116002)(16526019)(186003)(5660300002)(66556008)(66946007)(8936002)(4326008)(1076003)(103116003)(38100700002)(83380400001)(2616005)(86362001)(8676002)(478600001)(26005)(956004)(2906002)(38350700002)(6666004)(120606002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6mwksN7Q7WP4DBNyrEZDSUI3sflRZP5BR8rdaTdQtdVYrrgkglDYLw77eekK?=
 =?us-ascii?Q?ivhjXg2py/UzA5Pi7yBXP7ID/IHFM7sYYTSOinpS83567HsZ1anMHV18rTKl?=
 =?us-ascii?Q?31EdBitwps3nOxNHUBcWCgSMAsRMkmJf4zctRAjPv0bl7Kwf6txPeoh4pyd2?=
 =?us-ascii?Q?rBaQBdTjX54badq2j23vBYvpR9qM+NbBpBoR6/9OhGis8kSmoDZNkHFZmGsg?=
 =?us-ascii?Q?vejJ4gyhX4oKA/o367ICRsH/VJacGdEuZM+IHi6Hor7EZmLU5P94iy/QCbw7?=
 =?us-ascii?Q?Eag2Mljd/3Aa8V+2Kl9h8aAxOcSEAsb/+4aFKkniNlbq0OBA8Mot7T5K+1jy?=
 =?us-ascii?Q?HSzG1YDtfstRi0KXRHhTw1jP//0eWRPimKMnmZafCvlQXWcoDfNoJmvvi8Jy?=
 =?us-ascii?Q?PFzVFmIyXfbNfeE1LJU2CdYvHGjXTrtc9bpcKwT9wFL0esAeQU0HB1qu6oEk?=
 =?us-ascii?Q?rZakIEm3GUq1MhB1gl+5Yk5Mg5ti+rIL8c5VzTzKb2TIPrOtpQSWaUoztOmO?=
 =?us-ascii?Q?SO1q2+TdW3kLoADzdAYInJtDKTcwjfoZkBacp2gG8KR0ohQLd37f0hGndns6?=
 =?us-ascii?Q?95ZeHq+teZ0IjgMuR/TRc5oTDOpYPLOlsAc3MeFTrQrsyUOkwAcJJxGDGCsi?=
 =?us-ascii?Q?Va0rrv5qWKjvRW0DbE0nf2B6rqgo/yIDlZ6rc1DJkKKNUyMIj8rFSLHJ+vNy?=
 =?us-ascii?Q?HPs2o6V4yeuO+8IqfZnwAeHsD0cHWJr6zQHbzzGyhLsrywOLIlQ4QGVL0M/O?=
 =?us-ascii?Q?SjWOWZlIge6hPZ4ZieYoOlFUBUb7iaOKE/DsCk7POkf9qYwIqRra8s9fQGY/?=
 =?us-ascii?Q?ykVCNKPp8DQhHcmobFQneWaO38MQ3OkIJf7WaHkGQqFyiP1pDAK/3jDQG1ku?=
 =?us-ascii?Q?WzRi9N1kmebDiCrs95CO6WsL+Drw3sLyioKgXkgERpMDgsplwqsHUJrutm5i?=
 =?us-ascii?Q?+dgQtGgADqBKQVZY31De+B+f3Y3EmFxTrG4pvJRG3Vggx0ACF1w/BZThNEdp?=
 =?us-ascii?Q?fcRse7TLRNCuT8e7YTRFNUYyfvd0L6jzJjaXmByBhUmb7l3XgcEgP0iHqN6i?=
 =?us-ascii?Q?cqVIBhgIcCCOl4sRxU1KfqVa6WAdmhtJu41m8aKfVtaSRCEi0zqW4QZgpMeI?=
 =?us-ascii?Q?MJSJlWIUJzNQbMKAjcUWdaR1AWuRFSJkZ78Jhu59mpPTIQE1RK5wwnHtX4qp?=
 =?us-ascii?Q?deJrQLH+8lwFGB8gYufcBzfrKwiDTd3loNPMR/4iuP5FmUVmc8QXzKeDyJPV?=
 =?us-ascii?Q?So14RrYC7WSk1XL0t3apGxZzBFROF6IFq/9Tb3aZlDJ/PwBroJgHGyHCvL0D?=
 =?us-ascii?Q?v+DX/zO8evPKoa74bsdBZf5P?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931900f5-de86-45e0-f477-08d930935036
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 06:52:31.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+JnK3Pxhw0GyprOZrwGf3pSTwq56YnR6efLD+YhckrUqbwyqj6cLVUnkGtZUr50EMfwvjxVbg/O1RAEDNWb43y2yzR1A94wkioInSVGVWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2043
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160042
X-Proofpoint-ORIG-GUID: OUgEuEmVLdwtxPyiXrL0jnVHS0voalWd
X-Proofpoint-GUID: OUgEuEmVLdwtxPyiXrL0jnVHS0voalWd
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This v4 patch series is used to read the port_attribute subnet_prefix
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

 drivers/infiniband/core/cache.c     | 25 ++++++++++++++++---------
 drivers/infiniband/core/core_priv.h |  2 +-
 drivers/infiniband/core/device.c    | 20 +++++++++++---------
 drivers/infiniband/core/security.c  |  7 ++-----
 include/rdma/ib_cache.h             |  5 +++++
 include/rdma/ib_verbs.h             |  6 +++++-
 6 files changed, 40 insertions(+), 25 deletions(-)

-- 
1.8.3.1

