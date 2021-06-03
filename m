Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3181D399B04
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 08:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhFCGwg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 02:52:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39346 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhFCGwg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Jun 2021 02:52:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1536irjs151974;
        Thu, 3 Jun 2021 06:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=V63sIKFdjmrcTFbvj/KozRZrymLzgW1D9E1HfERWKZE=;
 b=y0r+5IZNgIhLVdKE6Qffq26FKQI1I4vdp8OjIJp1+dGzOOGbEW1smHlYUz26A3w6PH2p
 kzjQYjgUdBQntQbYPSlfIEpsq2TefgmOAgU4LTtX1CuzaDfyY84b0PaCn8WKPpliehM5
 O7u2kJdUdm5xf45PRuzUG5x5fl+Y3cSpY0MRdODyDFPjVhEyeAOoW7w1xK5pe/dfjqKq
 TsWn/tA7m/DSBw3+5RxiR2h+BIvuIjx37LcKHY0wkEyVsMEhByu/EV37zGUqGIpqN5Pp
 SiCuoNiTlz5lxlGRPGC3XxWgMkILS2qXCkMBq0dwqrJwD0isEjqZFLfyY/mXsZiKC6c6 MQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38ud1sjdhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 06:50:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1536jUcI128113;
        Thu, 3 Jun 2021 06:50:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3020.oracle.com with ESMTP id 38udee2fkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 06:50:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggRde2RKcGfuQQtH3fVJ0gVjIL7CM+uzMDGgngmpRjVo7ZP3dXo8ap+EehKVf8CvZNWn6mwO3/H3gXFPY7Hipy2tD3RFsrMoH3NbyqJCZrja9hPwNOwQsx09grAToWSKm1LGBdV10izbp1m51Y7TtXZRBIJk29l/Lvd73Xp9TD8SDdbvJiwyksdaCSe8E7GggCtWUs662gfMU7+UVlhTeYderRtSiTM4wsVv2IR5CJc1oCx0hWdu/zXNTiCKzU+aYcjBLucHNL19gHU0fFak25E4gBHZMq0tpt9J1aX+O1AVvZno5iO2P9JlWh3p0x7keRSv3PWjTjybpqKOW98A/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V63sIKFdjmrcTFbvj/KozRZrymLzgW1D9E1HfERWKZE=;
 b=WGD3o3CbanRFe/Kxqwd1sKKd8Wr4tSYwhXZuwyoc34jFudUFF9vTBQlWLZLeCJhXzsDahvsuYzMZVCncj0yoEAA6Eb3sljyjuSZUMASgaUkFl4lTZSRAFOd5TEAESbTDCVBLAp9ArvGb7vb5dE3BiYAD2b25Hz95qi6Zmnif09TeekkpsBiDMXdwPcNkOEi8Gpkk3QrA0oPSusfCLLyKQZZ6IvhJ/PvEq4LBnrBIvqZncZybRugHawPPTYc4nTfdzzl4ANKllssILpd5lvEfANCVVa2OGth12SZBkvWIiR/sCCaopvuuOlRHvaVK1QjAdaEt/ljMS+RXWG65QZVu6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V63sIKFdjmrcTFbvj/KozRZrymLzgW1D9E1HfERWKZE=;
 b=o04xB/rek8Ez5bNdGl6C48h/6R8J7rnwk3LCkLoy1cHGnZNPQayVVmKDXyiAZwrkV1w9KFaQG4hakjpxaTypEDVFY+ymmdiQ+xEaTOjU41rvSNF6nmUDBPj/fTsI/XAzKCM1xUUAVZqFoYYrrEH9qxYOIq+e0YdytRn4QZ66mcA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM6PR10MB3979.namprd10.prod.outlook.com (2603:10b6:5:1f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 3 Jun
 2021 06:50:45 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::5c05:40f0:dbae:4c71%5]) with mapi id 15.20.4173.029; Thu, 3 Jun 2021
 06:50:45 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v2 2/3] IB/core: Shuffle locks in ib_port_data to save memory
Date:   Thu,  3 Jun 2021 12:20:23 +0530
Message-Id: <20210603065024.1051-3-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603065024.1051-1-anand.a.khoje@oracle.com>
References: <20210603065024.1051-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [103.127.23.88]
X-ClientProxiedBy: SG2PR06CA0205.apcprd06.prod.outlook.com
 (2603:1096:4:68::13) To DM5PR1001MB2091.namprd10.prod.outlook.com
 (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (103.127.23.88) by SG2PR06CA0205.apcprd06.prod.outlook.com (2603:1096:4:68::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Thu, 3 Jun 2021 06:50:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4fa37a3-d46d-4ab8-7ec6-08d9265be95a
X-MS-TrafficTypeDiagnostic: DM6PR10MB3979:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB3979ADBF2F3013C26EA9CA1EC53C9@DM6PR10MB3979.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7lKFcl+o1C/yHmiOGX5S/Tpyg6s6ipuhGHe32CDXs8YFvsHV/w/FMirMdjEgWML10ZvFMoTb8M+th+BwNDQ4sJGn5MrEaWGKsNkaB6zGebjUcPbSYY5JKtMc6/XkN+Si05/mV02QD8iFEBQp3fU3a/tUvZMQQagBS+WSZPBGwbrvYlDmYafIrS0/uYVpuep8/BUaBpuSpsFyfNk1XTZW8QdZv3M0THnxOIVzs8xweurajKuBQxJmJelZS5ZEUzgkrgtZpHX9I1eXSoSYYvshJsCzfB4o9panq5XW1FJGI6IojztN+LkPxITKfAB4Zolp2qz5ghYqo5iB9v0j5113Q0dYh6BX3ynmocKhEaXYFHSH63N70ErlVpWyGX/I5AWW3LsiR0ELXb1mu1otK311uZXVZmeaUQcIGGZVwKe7c1iGv9M1RDqpdvsH4ffreZdxS2k8rlJ7SGERK34M9KakeMRQeB2hxmsj+s7gZqwzsZCTmFmbEqAHaufhVOWL+9f+PKDUVdlYHMHZ6TXWC58hT98VZEy4VCmKquiWH6iSxjcuR7dE1H2PuW58OMzhPXWnlKpliMdRgYsVXYV6fxEmcAiB3PERXcOD9QxtQZk1/q+oymK2gUV6mvQ9UDXE/DGVwypvEMbbvrNqMY4ArD3oFV5qncxErVKQoQ1KX87XS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(346002)(366004)(66946007)(66556008)(66476007)(6666004)(6486002)(2616005)(7696005)(8676002)(86362001)(52116002)(5660300002)(1076003)(956004)(36756003)(38350700002)(4326008)(103116003)(38100700002)(186003)(478600001)(16526019)(2906002)(83380400001)(316002)(26005)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qvAuLkJSAZoe5qW8fRC1gsY6zlNwqw+gRJ9W953QQVbp41wM4pXce4Y0bKdl?=
 =?us-ascii?Q?6uDv8l2Tqs3fxUlFu+3R/FuX4LWp78iENE/63+LUhK63AlnAZkZmjkEw2hQb?=
 =?us-ascii?Q?eSyn6SgCbyP5U9DHuk8jDF9ipBGrULpIdMCSEiCcpkYVjdni52tRcISZGcST?=
 =?us-ascii?Q?L0jNMpPI2ov/4hLO2d2vr1Rc9Q/sMX6sJRPfYweykf4Jf6+gxqhV5et2oj2Y?=
 =?us-ascii?Q?2KzQK48R33UCNkeWQLdoOZkTNMWCRdbjo6BX8+6on7CBCLcVvJKWYHfh/Jmr?=
 =?us-ascii?Q?+1qu0NfWJXDSnOldEIfyd8yoWjobwEXAgTDDKA95lSnjBwYN1LDzHpYM9TQk?=
 =?us-ascii?Q?l6CJ9ONc8M1UeZYN5AA3EW2YQpa0s5pnNh8x8yMUUa+IIsBM7fZoxz4ogmLB?=
 =?us-ascii?Q?LpyaTHjf4F504FwtDyDra+NuVhrwNVBZ8SJbaZwsYSQmbokYHsnL5Iuurqkm?=
 =?us-ascii?Q?KJSwthMdwj3VXgMqTzAb+5h7Wtwz7Rn74ZLsWWFvxedq/ojeFzN+HHsc1tv3?=
 =?us-ascii?Q?HBwRHjrxWzb6Mvki8UKitGtWwCiMKouqPTyVlPe6Ja2LK5Sqaeg4HxzhtjxJ?=
 =?us-ascii?Q?UP6rmpRa+66GV8Z60CMtmBpPaHxAMTypYd26I7ce2pJgoCzy3Qks5rYy4mRi?=
 =?us-ascii?Q?NB6RoUTFb0pwYLj21LLnV0iSswOAfy8QkJRcrHihZ/ktmExvS7vqAKI0s+Gb?=
 =?us-ascii?Q?wQTFkLC2E5LsMKZHCGfLpJWn+D+vLcYrM67FLVlce3we43iu3A05Kcz209sh?=
 =?us-ascii?Q?wxkQKkofKWmZHBC//ricKKLPhzz19N7LIJXARKgwPN2y7h7aYrB5Fb+fe+v/?=
 =?us-ascii?Q?ylSKPP2hmOpETHe0VThS9L3fCJ+voAjCw1BRZ9diYSdhaNC2zc7Q5Cr2pOyr?=
 =?us-ascii?Q?L5YRa73mrFyw9sUA8h/ozsUNcJguLv3yRIHU4P1sxPS+B0M3oOVTYfELMFK5?=
 =?us-ascii?Q?jSMTwPlLo7WNb87uHP6g6XSegP3CkCx71SPLohEvUuWqjX/Jq3cVwl7LZEjV?=
 =?us-ascii?Q?sgTi7jRLwbtlsZ6oCa/cp31YrGHXRGCpm4s9Oh/cgKagRiOn7X8rgyiogRjC?=
 =?us-ascii?Q?pE004pjByP93O8lwU+zdei40QPckY1Hy2nHkDOI+YPVPq9MGyt3one/y2cBU?=
 =?us-ascii?Q?kp/d1tGfa/h9exDMeA+tOyw6UCfF2ogeNdBcTDKshavhp2g1VIM531KR5A+R?=
 =?us-ascii?Q?3lYnbsKUO7osygvAwQFmWY9MwmfcHQPCYEhczaYw/wTPTmyjKNndmYPjZ4YZ?=
 =?us-ascii?Q?YA9qrF/+ZJ/egvw1ufI7QhhPz66rlrdyh1YiE3Gzsu0e5IDCTlAu1h4WzCuX?=
 =?us-ascii?Q?ho/Psx2+Jg9tCYDUXU8sHD7w?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fa37a3-d46d-4ab8-7ec6-08d9265be95a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 06:50:45.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJsUlY4oTAuZzeqAIXbLzGOhU8u0ANNqOwB9Rw8gqe1M+yoVYbZdfieqK3pNkeLQe6LzdrpWHY+F4RgXpbl9vatY5wyIW/7e461n2ljOVNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3979
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106030045
X-Proofpoint-ORIG-GUID: O3x3kpvjKJctkfZPh1rJFVzk-ey3UCeD
X-Proofpoint-GUID: O3x3kpvjKJctkfZPh1rJFVzk-ey3UCeD
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030045
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

pahole shows two 4-byte holes in struct ib_port_data after
pkey_list_lock and netdev_lock respectively.

Shuffling the netdev_lock to be after pkey_list_lock, this 
shaves off eight bytes from the struct.

Suggested-by: Haakon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
---
 include/rdma/ib_verbs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7e2f369..41cbec5 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2175,11 +2175,13 @@ struct ib_port_data {
 	struct ib_port_immutable immutable;
 
 	spinlock_t pkey_list_lock;
+
+	spinlock_t netdev_lock;
+
 	struct list_head pkey_list;
 
 	struct ib_port_cache cache;
 
-	spinlock_t netdev_lock;
 	struct net_device __rcu *netdev;
 	struct hlist_node ndev_hash_link;
 	struct rdma_port_counter port_counter;
-- 
1.8.3.1

