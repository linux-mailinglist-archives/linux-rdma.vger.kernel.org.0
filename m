Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E96B3B804D
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 11:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhF3JtU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Jun 2021 05:49:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51248 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234095AbhF3JtQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Jun 2021 05:49:16 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15U9kXch025724;
        Wed, 30 Jun 2021 09:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=nPL9GAXtRlfciMoN/+AWdGirYzSQ3Lj5Ad3nP/ubmeA=;
 b=rPBo+7igBEfEpirzVUXw6FkHtprJ1TU9AXjyVabaIGNI6DmnWLaXuAoil4QbGO7rUfgu
 qAYuNbDlDFybiEIqpO5dTjVrWcKTshenDcIzn7fAKt9NgNpsncUeTCusml5km/4xrw95
 H5KYHhWpwpnCx9GkNS7sLkaVnAPxErF7I1BkzlqHWjMraoaU4+qWVDxnFKlZnr0l0ZKW
 z/VVh0Wnoa3X9GEksNkCU93bhUIhaeettU99Bo0Y+QU5C+XvVfkRIEugjOTFdUCwAoYO
 uvKHhtZ0X51DoHqOa2jWjpHzH6/7i+X3c1v5i9n+mZtFhXPdKzNmfMQihXLgL/4MLzKV VA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gb2t11tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 09:46:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15U9jgNK137336;
        Wed, 30 Jun 2021 09:46:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 39dsc10gys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 09:46:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAAVoKHnc+FoMhkO/TqbVsm1UEbebUX3JKGjiN5k7cUi4WH97uzs7IOfSK77cjtxg9rdVGf1SsG3JHpaT+wZRXBpEYDLhP85dJ5gnPs5PNgoLm0vwdYFA4EzhxuXI11mqnz0VKrdBwSR7WvybaXBQWb0H9FDQXBYEC5qkgIRprn8YtyQdRtwgvA+vTUjlbaNFXxHmCzXvOkbesaMn/pa9ayS/2EevwHKikJ2qg82iRyDyKGsrztrcvs/akRrzkowkPu8epjegtajDVGSi6pxo+HpLn4sefDoqSe8nptumpFdAfVM5gBvycPPDCFhPcPS18bSVmjVhcDILFBNKAwZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPL9GAXtRlfciMoN/+AWdGirYzSQ3Lj5Ad3nP/ubmeA=;
 b=evSe5JfQOo8VDczZLBYsUvFLBOrwCZ+fbaVf2J3m6YrplDE9Bz4CNbo7FQfkHKk3xEho+yV8GEhTZ6V4XDQVe+tKWu8jDNC97YApJBMh0UhAckd/J3pmGeH4z2apY9EhxlCj2kpVARkdFE73TkUhp84WfgoUdVGCKLT7/RCU9s+OO1TMXF5NpkkZpvEMFwth6gjyw+/VdQ6dSPbRYMRJ0miz38jln6ScEw8jWsXxD7RoIyIUUe+L4R03Fgnx7YorWGw5IlIv5XeBQYt+nLoA6Bwj3dSGfVZ2Z4SGsWpTkp0sLVgZ5Au7vTtv7HLgR4O8t2tSqImVxZw/8UkDYlcHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPL9GAXtRlfciMoN/+AWdGirYzSQ3Lj5Ad3nP/ubmeA=;
 b=aZbFaSzrr/Pvnm395Rc2LbIKgg1ZMSp+uuziK5cdotuqa3OXEq1kUJNodUHWy+IX3pnsUkUo9v/eCZEB8ZPFZaqcGYFLJr55y+80Pp6RwOTxKIUmIxkD0fI+ryN0ySf1fCH2VGfpPXdOS7war2CzaVAQFKg7r/FvCoCWKkYIcTs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR10MB1557.namprd10.prod.outlook.com
 (2603:10b6:903:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Wed, 30 Jun
 2021 09:46:40 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4%5]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 09:46:40 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v7 for-next 3/3] IB/core: Read subnet_prefix in ib_query_port via cache.
Date:   Wed, 30 Jun 2021 15:16:15 +0530
Message-Id: <20210630094615.808-4-anand.a.khoje@oracle.com>
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
Received: from AAKHOJE-T480.in.oracle.com (49.36.45.114) by TYAPR01CA0007.jpnprd01.prod.outlook.com (2603:1096:404::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 09:46:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1042402b-5502-4a4c-c738-08d93babf5fb
X-MS-TrafficTypeDiagnostic: CY4PR10MB1557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB15572D12D269020A090F7D32C5019@CY4PR10MB1557.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5D0y+IvSz85q1kzvSKOu3IH3666gIE44d1pgk7XD7SR3i80VSvh4boFtc5qUga4I/N5MTtBniHbWI66ZmkDbDoehKZv4mvX4fOagSBZpnJGF0bTWRvc9G4dU4R14hKXMl4dCgelENELOC/aXdY0h0Y20HqxT+6mOpc985VNrSD+BYbn6Bbpbl3UHGjP4zo43knMvIWlwRtqs11l7Utz/3EcooRfLrFLoGjcJy34T1OyWaWU2JMe1TrRU8OS8Wk2reIJAPYZ0lTp9fiDsVuYY/jrolC0bMfb9w3hBe2++P8x3hZ3cwMIE/LUvpwkG3rzJ2q0wExyFxwW2LPv9O3to7kTpTF9Vv5LQ96WHBWCVkwS6rI/ia/LLG2CBAz5eIUz3GPzDOkUBkkNGHFfMszXn3wUSZvMyXgW7D0o9Iuhgt+1or6M7djpgBa0xq5RgdCNMC8wUACXJQp51QiZGKspycT4T4jCEIQSP3dcCNOgCsDwz2kUbnIhvRFnOLF1SCpXDFBoc7yXAK7RtreC1TxBbzvpxNpneMn1H4KtvgysBCQuovCoan42aw68pmNqBARILKrZXDJJ9pZ7oYfdvNV2zkP4/3PiimL6vUkdXPheT33JHlNGwIGqdzOuo+n8pvwvK9F6yicGlQMisNnMLWsXPfPj5HdSTNcV0PscSzfrsev1X/3ZMYeSa1vWg2sLf4x7vPqEOWF+AkGPWoLPjpLamPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(66946007)(66556008)(66476007)(1076003)(16526019)(186003)(1006002)(6486002)(6666004)(36756003)(83380400001)(26005)(8936002)(8676002)(52116002)(478600001)(38100700002)(38350700002)(5660300002)(103116003)(2906002)(4326008)(86362001)(956004)(2616005)(7696005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NvILkm9jncy+iSQ2fC0PnESyZl3qfE6cLRp8ff3a5Fp6O7rhIEVk2WOc8Wq+?=
 =?us-ascii?Q?yKuhqgvMzeAdFM5PRMee5fn1IGA+Z9y3ZKgwgZ21xhO0otpsnlhN/E9mw0DR?=
 =?us-ascii?Q?BcHLvTz/E1SX2smvZ/+f527M84XRlINkFVbwtu4yulbqi/LOzRB5esP6bZUq?=
 =?us-ascii?Q?hhn/MxZDQ+Vq4tWUz/eqIHfS+YKekY+b3btL8JSkICfWT9JrlOLVDBN9lk5j?=
 =?us-ascii?Q?CsaMAxdBSX3lu+/g0s3MVhI+l53hEvWR4UBfqVn/0jRSSF3WWdVGcLf4W95f?=
 =?us-ascii?Q?+DBaGUUDSbKZ/Uo8/MLfrT8EyHb1mR/p85DSXlWfVlFYWAXhYnn4iBG5FSnT?=
 =?us-ascii?Q?xM1YT8t22RMm3grL/eEU7rvs/QHNzC3Pt1v8dZN4MGEJoN4v9VTfcLj7N/2d?=
 =?us-ascii?Q?bvIJkchGu7ydcgrb3XJwEkq8dKRVE1QAKnxwxF+jkltx8A1ZIwANGnB+sT0Q?=
 =?us-ascii?Q?uAaf2Q5+mzL7/ho5SulXVvcBM3ywkgTNiwNObSG/T8+9WCQE1wb/HsItUcvQ?=
 =?us-ascii?Q?S/GBFz0DAHXq3q4uj/OuLohdPVSO3HR/wxaynq2RtG08a0E6buz/9BuPkwR1?=
 =?us-ascii?Q?hJajrG+Ld+hH7DvZKXHXPRy9AcdbXEySEd7xSN7QUx1lToF8lQvLVBCgLyq9?=
 =?us-ascii?Q?mvWjdHP99hJ51uc63yequS7g4SeA2WuP1eJxQrem6nUmmGM4S7pyesFN7cco?=
 =?us-ascii?Q?LJV8EYcVymUGcOGFQvzaaxwY0D65DODdWz0sYCqP242FN7EzrRxz25zBSPLc?=
 =?us-ascii?Q?T0vL4/0pJIkpzuulWicJ8HA4TXmU6Bbvz7oPlQId1o8KKNlwAdkveYLrqFbv?=
 =?us-ascii?Q?OHEb24CFSVZgYJyIz9NIH0uACdxI+AzahdBAdBJ9CxFQg5rfNaWf8AXyRv/n?=
 =?us-ascii?Q?t/ewNMz2soQR1Y/AZ3iv5yjQyVPvG4Iwbg//VX5Br8Rb0VlYYQQSh13gBAw+?=
 =?us-ascii?Q?Afn8GMmsIVfYA3Iy157XQXQpxb7cVO6RQlD7LAwvuUULVxx0+wdF2WMHGRai?=
 =?us-ascii?Q?lj42y2+h2nO9xFBKl0pbb8t96l2JcPel5sAOdOTIaCMb54ueXSpEx1Bz1mRr?=
 =?us-ascii?Q?Yav8pgi90vV7Ota/X64nCaw/k9vq+yAqcgDT75ElXU2ZXl6YDDKQEH2gfD/J?=
 =?us-ascii?Q?KnIxUfsp7dIRRnHjhZ5fD4khhRrmWgo0XwGmYzeakClMNopOcWinH3A8RxVM?=
 =?us-ascii?Q?XGsiiUGWkoYnXJsc4m7XJ3LpsFqAbElt4PaSmCsZ6dNwBFkzDgjZERjLWt0F?=
 =?us-ascii?Q?gGTTIweA5TH4RjBQgEhvUTHiXGCSqht5DBYBtB1vgKS/6PVkoT2CeXM2pVVZ?=
 =?us-ascii?Q?Lg1J/JnQMht/R8RHdK2/9Enk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1042402b-5502-4a4c-c738-08d93babf5fb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 09:46:40.6118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bA7ZNLEWNX/aP2z5/YnWqmPC6grspkG9bUHdX6uzl1RMgJ2O1jc5+HT+hv4/Svwq699rgEckEyOkz2P4aPSPiA0uPkmufRkj3dJ4bE084U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1557
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10030 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300063
X-Proofpoint-GUID: kijO3yl_-Ilh4LQvGkNF2yU7VfEG7uEV
X-Proofpoint-ORIG-GUID: kijO3yl_-Ilh4LQvGkNF2yU7VfEG7uEV
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ib_query_port() calls device->ops.query_port() to get the port
attributes. The method of querying is device driver specific.
The same function calls device->ops.query_gid() to get the GID and
extract the subnet_prefix (gid_prefix).

The GID and subnet_prefix are stored in a cache. But they do not get
read from the cache if the device is an Infiniband device. The
following change takes advantage of the cached subnet_prefix.
Testing with RDBMS has shown a significant improvement in performance
with this change.

Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/device.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index ba0ad72..9056f48 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2052,7 +2052,6 @@ static int __ib_query_port(struct ib_device *device,
 			   u32 port_num,
 			   struct ib_port_attr *port_attr)
 {
-	union ib_gid gid = {};
 	int err;
 
 	memset(port_attr, 0, sizeof(*port_attr));
@@ -2065,11 +2064,8 @@ static int __ib_query_port(struct ib_device *device,
 	    IB_LINK_LAYER_INFINIBAND)
 		return 0;
 
-	err = device->ops.query_gid(device, port_num, 0, &gid);
-	if (err)
-		return err;
-
-	port_attr->subnet_prefix = be64_to_cpu(gid.global.subnet_prefix);
+	ib_get_cached_subnet_prefix(device, port_num,
+				    &port_attr->subnet_prefix);
 	return 0;
 }
 
-- 
1.8.3.1

