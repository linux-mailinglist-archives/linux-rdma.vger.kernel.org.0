Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C45532D60
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 17:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbiEXPYT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 11:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiEXPYS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 11:24:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444A94C789;
        Tue, 24 May 2022 08:24:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OFJ4iY018983;
        Tue, 24 May 2022 15:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=BJGCquWD6Md0GPQ9hCjYJg6cP+eJpZ/rSkl60p2mwU8=;
 b=n0eRiQp+7875yrLh+ZX5yLQY7WosMvQnF0epjosn9iRGl5FieQOGJkf1xf4MyPhkYeeN
 tYyYGpSz0BG2xqwKEDbIc29WInKY8cv1LFXpicGpoRpq0dSly6BVe1+6dXjVwludszDv
 4qeyMcseFrqzj4NMKurymD1uyBj4Y8QnKLSAF2iSMGcrqYAfQjLP1BxtB0+6Z8kon30U
 r3GG5NgahCdHHHhd9alYgtANEGhiaY8QxiQ8Y2cIdYyKmUtFrKLNfcEdluQC2sczK+Vk
 G9LeBf5iP4LBOBuVemnEVpL4gfhm1EM/g5jLJ7wu7f3+SRE+yGd+mm9GVz3oe46Z509J PQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pp06rr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 15:24:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24OFG7CI027302;
        Tue, 24 May 2022 15:24:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph2t413-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 15:24:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AygWGZtSktUuU3drI7CRxHR++920W7YFmxiHJvBsIBRBpEW4yYkmvBuM9hA6oJ9T0yw9DFdSwTv79GRB41i+pNTHOBLv0+VJal4Ny75JY+e+ecZfQVwY8fgAfTu8qA6l+QsQS4Bl4PWxgHv1qKXZa38qQhsLdAza3KhDbprhxHb4Gx5+1w/knXRJbXh5+jtZp1cOHgGLACe7b7evjgheinxvAXtEWYgntbkH7naF6wpPBjOSEeAeugJ9Tdgl/Fix0Jnz3XkxMtfHIdlSGtRQ4fiY9jvgrtFcwgetuCh80CYc0ucu7CwD9VTi6N7xrXyus+k61qUylt6CqrZOPfEx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJGCquWD6Md0GPQ9hCjYJg6cP+eJpZ/rSkl60p2mwU8=;
 b=V+As6Fw8nhqPPrDi4qo5Nh9yuBbFQfIJk6+WQljBP4Dhj5/j76teZL9mQaWHpzQuQytgl39SI9aPajr0dYUkzRkEtqqOyflBRiNC+zRWuFSsGoqBHVSoJeLQScTHgrgo8wkGmzU3WC9qcpLzkeFeLhMwYVA34Y7wZrNRTiQqltr1f368kE9Bd8Qw4wkLWQFIOEpdquVKagg1XcF4wJwGGRgTSUcwFQYz8xuzEhs6FqcFTr7VzjgkQEhnFEzsVy0LaxzrjvrNF5Xa+itKpXriONMvnpJgG2EitSCloO/QIkQQ3GuleEOmDYHHoDOwpwnEr96ii6HR3U2pkCO2t3WxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJGCquWD6Md0GPQ9hCjYJg6cP+eJpZ/rSkl60p2mwU8=;
 b=BsKkWq6UMnvFZoATaZeVknsZimxeK7qeZshlKUGLU4NZm3MrxD2+MzvfbC+ygJ4tZ/5bhZnhioiUODXpOZ7rJQtpyDab3tb8Fm//o/vjlD1hy5lW1pu44wa047EU9GT0ryd8A4sA8ToUtX/Hm7M3zQgtvzzKykUCrRrS+tvwrPM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3732.namprd10.prod.outlook.com
 (2603:10b6:408:be::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 15:24:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 15:24:04 +0000
Date:   Tue, 24 May 2022 18:23:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mustafa Ismail <mustafa.ismail@intel.com>
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/irdma: Initialize struct members in irdma_reg_user_mr()
Message-ID: <Yoz4iXtRJ8jw6IeD@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0082.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 447bf14e-9a1f-4bec-d665-08da3d996fbd
X-MS-TrafficTypeDiagnostic: BN8PR10MB3732:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3732B67875A0D3C6F972F8A48ED79@BN8PR10MB3732.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVZhWTjNsLEKg8M0gLfwoHpthqC7aYL7NIxe6iRftHUpt1FdNDWKuH6gIpbRts3q+gDUzNYyr3haRbh2ibqD8EKMsCGZX8TTJYWJ8EDuTAmzYC4hl1Ntl7E8810gyhR08PQR9g6RbzNZQ+t/BFQCJBEaI6dcv4HQDMv7cetjA2UjYkMEfOkvJwmdE6Ac8fdNRmPSAJZiUvkiwOsfsunjHDhFhn9mffg3QEc6js5Owdz2T6aQNXMss/hxTvNawodY9MKpoR0msX+tGqtz3SIE2dpQ+Ecvh/fWpeu7gMynnOT1jo2lzgeom+j8dNHbFrkOVLnqar0vLHxpgYkNVoAXHYzs/g4cmDuwY/UiPWR3K40U3z6vfQdVCHjyLJYA9mHj+//0ZPDJg8TW4e632YwWrQ9PFViTKgpVzphkGoE0I8ADr/D7NQ+ijq4nyJp8T8VdmYWp/Z4Iy0nmL7EhhYvKjF1JtR7tpf6dfpumuR1QhezlcEpIn2rxHUXKbEVbP8yGT+w7wr/2sG7QzBRgiUFaCZ0XgHJR4hwTRzkGkmXj2XmzDt6Mi4nk1/VyaZWze+hHsPQA+9rFVXrjhYFIepPniGC+f5lvnGhWWrP7UPj5NqrYX95Yk+RX8E8ef1HZoDhUpJrpyLPNjQa3AIilLoGcMZLhFoTmWy0UvJH5BNY0E3ClkJ4dCi6fFP0mxRnkGGBPsWM2r5TZYOLymVc1XJ4KRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(2906002)(33716001)(54906003)(38350700002)(508600001)(316002)(52116002)(38100700002)(6506007)(6666004)(44832011)(86362001)(66476007)(66946007)(4326008)(83380400001)(8676002)(66556008)(5660300002)(186003)(6486002)(8936002)(6512007)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CLnztRynWWamoIk+Cq1qEzKC4i/KobQ/QyCUImwaH+WwjxqT3qrD9xkuWtby?=
 =?us-ascii?Q?8TexmuMzIrD8WRGmzECXXUME+OYSs5KhJDrGXhdbgOLbB4aSeCrljbPwFfrj?=
 =?us-ascii?Q?pUxUmpj1bZmsvcgVv9MACTT+tSScgTxP+iwO9Wz+qqPasBvrUH+G/KMyu7Q1?=
 =?us-ascii?Q?h9O6Oihb9uBozy8qRuA/jjAczOyd3hetpBAc7gYPLImtUXH1BqfamAv4IAhZ?=
 =?us-ascii?Q?5UFgI1bCw/ncODNyNyVMw7jUg+8tYxr+MJE64ZRtnC/NugUF/qWM/sGkQ71E?=
 =?us-ascii?Q?6A0gWIMJaiJCDXzfRBH275zfmOYGAo5C9x2dCN8Ons2Z+klcbs5U8tdbFVwN?=
 =?us-ascii?Q?p9mFqDs6NmgMB65d5T78RZmlLhl1ch7pIFROpcjfEyTPg/XSSQ4MU75w7nhK?=
 =?us-ascii?Q?lQ9ThNyoJgKsGxU+EoCzkkhfiLup9wnHfDNREVBAJWPDqS2Pb5LvlVHbceAZ?=
 =?us-ascii?Q?xbAyM56Tj6sggqhIaZGe5la+fMlkwAxnN3TdCSEFYi1XKUDWKBkkttzOxRrc?=
 =?us-ascii?Q?Zju4VM2dZUbZdPIyhV0xpdYQYYSFQ6coLFwB8RHgqlSbm5QArEpiIazKDUGe?=
 =?us-ascii?Q?2jc8kRfqG1h0NzXtLjELPpWTWt5ZoZns0NY/ZzfOnMA/eDdDIHZYQkeP8aCc?=
 =?us-ascii?Q?SR1HPsFLPnWqsBcuSXCLz2JfjjWz8OFCGDf2XdjKdPtCLLm+AQA324Cl0xiB?=
 =?us-ascii?Q?2K7Y+3bGycdJZxN2LjxPC5IMgZpEzWpXsCTGZ7sBdmbUwIUO3hw7gFUtLIR4?=
 =?us-ascii?Q?Th1JxohlRpLhFspYJsm0Vi11XqU9mDdUpe0BlYUfMytPQFl9cWsoFHWDEiNy?=
 =?us-ascii?Q?Fbd01rasDgLXKFaVzPVg8JdGNbNXcUnLSd2Vqz5d8Ykmu/qFQa7A++0Ey8q7?=
 =?us-ascii?Q?67ZTb06bW6FZ6NebicS8JK05zjqbI9PbEzepKSNb46ULOlUgZHcSHbTuCUa3?=
 =?us-ascii?Q?pPsLB9Mcv/gPfabEW/u0d914J6tWsFL5/SjpaLe8ZLTgZapzXLBoviTiu+HS?=
 =?us-ascii?Q?np/mPrOiyjfXtvEduhpoyGDqFb5CNKTL0roep4dbb4N1ZfxM96maQHRgBDoC?=
 =?us-ascii?Q?JkwpqSc/MEM862ixuXD5dNBeIk4vete/jSrLSA6iljNE3bltZSMDo3WXK8tX?=
 =?us-ascii?Q?PR1a8h6OIEXoo5zYbOJAqTl0T/4xwcUg5mBl5F3FQ8zLiQgMQtD5DwAKEZR/?=
 =?us-ascii?Q?CB0pdr8FcMupD3Lrc2+UgQaytcCMp4Su3xZ34SApDqupHuyzmx2rDT327DKu?=
 =?us-ascii?Q?SCwA81oJYV1lmnJD/nZ7hyCU0UDsidYwrFSshgBjqGZIoPMaPVwsRDvpWpLb?=
 =?us-ascii?Q?ZrBHxBCt4IkfN1udaP0zK1xfr5iLT6XBbw4uFJU6mDRdv00Boctydt7AouqM?=
 =?us-ascii?Q?LnUYDlZSoZgFIhCWi6HUkV6cpsuMyvsE0HLPtIQWZXFj4TBEAz+O37aIcd+o?=
 =?us-ascii?Q?EgMzxCaZBJIpw9v20kT6GkhhE7NrN5zUAH7YgTfi3d2Au9qTu7N86CeoSW0u?=
 =?us-ascii?Q?/q7cIZois2gG01joA9XYObe1JwYevlTyAo0NVXFW72ebunt6Vtw/5XVoZ+Dq?=
 =?us-ascii?Q?eKW+hTlr8QTHKi2X4fQAIp8a1kKhRCmHq3fi2DfjNuj46wkQT2VxU9qZN0cs?=
 =?us-ascii?Q?zV6Yypklg22yfP1tPhxARhU1V0k5NKCUeOGVKbNrtaGd+lV0/0nKyMqpRCEi?=
 =?us-ascii?Q?sfqxJbMKD0Cp4E6Ig8zx/oSsQZKabQsKASd+hus8ebEEwbO674tpw2v+2p+7?=
 =?us-ascii?Q?vQernnzw0wsJQiyKiZ7qCQwYt7j4RlI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447bf14e-9a1f-4bec-d665-08da3d996fbd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:24:04.4099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwmOQ2L/1+BNQtm7qlOjk2TSopGP2OOzkkwFpj94yRQVuJqSmzFmyR6zdaUxFlP0VZTiehFcbO75nJQbFeoEOeqAchl5yXBwHiNywU81QiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3732
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-24_05:2022-05-23,2022-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205240079
X-Proofpoint-ORIG-GUID: 0ti8KhtoU3GFA9aISrZu5dAaximnIJh9
X-Proofpoint-GUID: 0ti8KhtoU3GFA9aISrZu5dAaximnIJh9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The ib_copy_from_udata() function does not always initialize the whole
struct.  It depends on the value of udata->inlen.  So initialize it to
zero at the start.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
What I know is that RDMA takes fast paths very seriously.

This is probably a fast path so you may want to implement a different
solution.  If you want to do something else then, just feel free to do
that and give me a Reported-by tag.

That business about you guys trying to explain what you want me to type
and then I wait for a day and resend but I misunderstood something so
I have to redo it again.  You all are very dear to my heart, but what a
headache!  None of us need a long back an forth over trivial stuff like
this.  It's just easier for everyone if people write their own patches.
It takes five minutes instead of three days or whatever.

 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index c4412ece5a6d..8f4a6b7ebcce 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2741,7 +2741,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	struct irdma_pbl *iwpbl;
 	struct irdma_mr *iwmr;
 	struct ib_umem *region;
-	struct irdma_mem_reg_req req;
+	struct irdma_mem_reg_req req = {};
 	u32 total, stag = 0;
 	u8 shadow_pgcnt = 1;
 	bool use_pbles = false;
-- 
2.35.1

