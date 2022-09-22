Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541B15E60D9
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 13:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiIVLWz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 07:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIVLWy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 07:22:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BA7E05F0;
        Thu, 22 Sep 2022 04:22:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MAO70S026592;
        Thu, 22 Sep 2022 11:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=+69ltgFrchjGCPxrFyHmerm9YTD6bYtb3B8pkQdHjWA=;
 b=oQMfKnwckUNHJ5NSizJ/hzKamMY2gM6Gxd1QeFMVpHnmSKADofElEfmZMuhRyrJjrHww
 KW7d6ehkfN0wykgdwN99dYGJPeyc35YQLhzDwV98y+cZlO9/S7S/yndvPNYwYjk7+bXT
 kEZE5ruIW66oHTyX2Ajk58iR8FfORXirNrmrJ5gU7Ql7wyfP5Vl+HCTho3H8BqGX5hsL
 /Hs9HmJPGmhayI7jvjblinyAucJWaHBQFuSiffWbcPY9i6bWMwv6jD5aqm6wEmRSzzAn
 gDIktab7G0B40OlFrl7tBYlFqiit38EQjbEHRdJh8bzrXBL2eMRh0QLfSsZuQh45Uw2R hQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6stnfvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 11:22:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28MBKvOx015100;
        Thu, 22 Sep 2022 11:22:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39fwx3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 11:22:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm8iQyXh4a8Tbmo4qYZ94WTGBZdu4Axg4+9smDWTZGQpU+68RdUcOqQdk2Gf8TFKPXo4vybZnBGOJGE186NDm5yzXdg35nX7PgS829LO54l4TQ+C0gSn9xVEZICH7kZHl84gp2M576Ot72aRT9A6tlLmaHOE+FAXCv/ZdSkN7Bbc9X8r5Wyjrk26w018uof/m7m1ZP1Wettd7oy7a9tyIHHpWdD89LmC7TwmTH0nwygJ4RhCEEOlWScbQkBePrVF/GL8giYV2RqGvAo8wAHFpeXAbP96b55eNNWTY4s2jm96A8vhFSp0QF/Eiznf9mgxYTaffpJIO2bVUEH8Qazm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+69ltgFrchjGCPxrFyHmerm9YTD6bYtb3B8pkQdHjWA=;
 b=NZrvkCo3+SjwSVbGj5oVH06fHKZSQkwQUcehQRTsdorLzUEwPXDsxBfWHZImwiLDXaQdwYZBAaRQU9fLE2kbWZX8THtHixD5Nnt4heAQKazMfKukPsr9BCNQehiVnEFUgKpCUUgFbrjjoAMzfHY1jOy4+fLzBVwTA5p3o/lhWkH0aB7BHumMFLm87GvXbKVkN2scFZT9wmnwzLy2yXfxJBR0eX4G5gutMc1ThxRFTAV8J+aXTOy+HBevkrjrdzJx3Az6k3/mR4p+bKVBEOzF084mzUHHHs2CEeyUdQj/bbiiHMpIAd06KHYD4ZY0+brMNClTKWSqm8KP9l+NfxpVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+69ltgFrchjGCPxrFyHmerm9YTD6bYtb3B8pkQdHjWA=;
 b=BqpRVVpHCMOpXuc3uOEjVoEJUAOMADuaa+Vex98OphroHyUYb2VG7ntvTkdrT/Lkbsg9/l4EGMoR0y9048f2+PAAX5FM2+4GTvtRaigdPZLEGmBXQNnnKeM78p+rTCbhCAkb28ksr+xbCR3tFx3sSzm2EMrg1wCZ9ZCUMWAb87w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB6347.namprd10.prod.outlook.com
 (2603:10b6:303:1eb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 22 Sep
 2022 11:22:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 11:22:41 +0000
Date:   Thu, 22 Sep 2022 14:22:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>,
        Yajun Deng <yajun.deng@linux.dev>,
        Maor Gottlieb <maorg@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/core: Clean up a variable name in ib_create_srq_user()
Message-ID: <YyxFe3Pm0uzRuBkQ@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0069.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|MW4PR10MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 35540e23-9175-4e57-7d8f-08da9c8cc383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QiR5NIeWDJx3otyh+Pw+LxFZJiWUDc5j9iclro/xumfSBJspgOgBtUYpNZUgeapqffEzFjtLnNRfSyZsYugpMS66qi61DBvpc4tCl8/moqoRtkhg9vFrBUFByuW0e5/ITiE47QEShtlbpqfoxUNHxe/YRxm71h2oKMx0NnuoSJfF9oDMv3/rNtnNW/M/xWDPzmm/rWwoPSyXcqh8WYKhNFITaCNPiqMgt3DlwWkAFYyIP+Dwv2HN4Pel1U0DRtDYuOJbs0EFYwJr9sPsn3NiHAn+i9X1uz5l4UHvhbvL4geX5b/6M89E6ImbWwdtVtrExIwXbdnBFTyA9Yy/zfL3T9DwGDfcBJW0gzOdqORmIpL4V+v3TIFYgbEHSgHcX5y4NKeVPNDjHQ1ygJKuFksGDDd9DcrKssWpuL3FZVLtQTPo7pGVUdU0SdTRs9r24jbmM6ErZT+fuTEOpwoA0Qz1MCIbWPrCFlDc+V/WJmoa9CLmnaV0D0Jbcwu98hXjogg9yxd1CVSMfkeGrwAbJUHcbU5bI9KzKnmw4GotJ+dhJPRT23/ijcZuIJ9GmMC5v5EDlsHfYIfmnSIqji1gqbyFBpXZK1RAVS3w/j2kUXj9gxIVMOfBuFPJAMjhDKpWvFwnrHgwT8MTzVlsD9XvrgSEgmIeP+dVMLTt7+Avn9xb1bCM7FxDQg9jZza+k9qDyBgR/aAUJA/3eEnOWNi/0mMCPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199015)(86362001)(44832011)(4744005)(5660300002)(2906002)(8676002)(54906003)(26005)(316002)(33716001)(6916009)(38100700002)(8936002)(41300700001)(66476007)(66556008)(4326008)(6512007)(66946007)(478600001)(6666004)(6506007)(186003)(83380400001)(6486002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?COMPhar2x6gSfY4XHO0oW8iG205KQOjyUyYWi5o296oLA0OWHlj48HVBfW0C?=
 =?us-ascii?Q?hTgWAHYlyzmlwCtKSHpj4fBoujXDmin3FJu/SOBrTS/8pCvVYnWWZFHdVY7G?=
 =?us-ascii?Q?uX6HtaLFIDygBi/af+SUy3Pe2UMUJz9TtdqYDvOrA+JJPAYRVkgkDgEn0qJt?=
 =?us-ascii?Q?nwj49mOVVhzr0HsoZY+TsRStevCZQEbh+MPAKzwnJLhOTzgZk5l348Y80taL?=
 =?us-ascii?Q?j7iYB68NS1KsmEDNlJtbMpb6R6QocidYZat3xquttiLYlleJhvxO/hz7I6Pr?=
 =?us-ascii?Q?YBdZJLzV/ajKTRFbwEdXwWp0zgKoF5Kq4Nl/xc6G188ZP3bWCS3FVYSoIqFw?=
 =?us-ascii?Q?92IliKfBV7o1FQyiwly17VtxpajbaeTTNDfMqyzp2oDxG0/xKDBk67PZgpD9?=
 =?us-ascii?Q?oXEGJtzfOPAUYIekjjr6dMjRoOxMKDlJUq+03u6IVdpVzruxYzTuMCG97Te9?=
 =?us-ascii?Q?bDXFGDV6tUgb6Zj0GFMdyWXE9qc8LmFKHtE7PIpcN7xr5YP7e8N1TQATpk3k?=
 =?us-ascii?Q?M1bNOOPC5qOIHnYI+9ilwJPptP5wMadl89Z7kdPQEyB9aKycMBKdd5GudJhi?=
 =?us-ascii?Q?SSx5b3M45+rGbldUgjZEVrB4SKIxCdnM59iq10QYQZXvY6a38d7JWLfAKCes?=
 =?us-ascii?Q?KNCegT7qc+HqeMb4DJDSvRpkrHlyS3hdAY4fvaOsNwYTcDIN91pnwlQi+JhB?=
 =?us-ascii?Q?30oNH7X9i/8H8s6ZN5xhaObEGJHwMjF6YDkwhQ8hglaAFz6kEqHAKYy6O0Pg?=
 =?us-ascii?Q?e3G9zpwGiCqFWIuHEqrO1f/lLNOUQ+kVgas2Y9b7aGAKgMIt1XMquw7X3cQj?=
 =?us-ascii?Q?wEyfRmqHcb7pg2nvaRLvLRC6iSbIRbHxa+Nf8jwZdORlYjW4OYh5Dxv000lY?=
 =?us-ascii?Q?eAAMh1tFzgXdwOWvMa99WzhJhAzmqAZQxpFL6we8rOT3hqk86KYXOsaEOdWR?=
 =?us-ascii?Q?pQE/k/HKct2YLwKGFmH5bq/v7Ka5iBowMsMP3CeA1oJPLAZfJlf99RneSpA/?=
 =?us-ascii?Q?+6rnseD8PnHT0VXq7LI0n/+DgSpGk0MjRMZ67jfAhTzMshXLYRTRJZa0nmbo?=
 =?us-ascii?Q?xaIvWSGcUgSBF0A4Us9fbnoMppfpN2Y+keWAcAJAEt23BfpIak2O7o+zpG67?=
 =?us-ascii?Q?0+sJXe3sb6830VBW1QBB4eUv8eIEpiJhLGecpbMU09PztmqOYgOE+nmx8nA3?=
 =?us-ascii?Q?Qr8wPJniOV47NM5lnPHu2N3huteYpe3BknRNHgZY4NAzvlCq7VENcxhO0Sat?=
 =?us-ascii?Q?U6MQmJSjRAMTC6M+UX4nE/Lhl2hW/K2TnXWF7FeDDHm8H0pUf675J0Aca7HI?=
 =?us-ascii?Q?7UcjTb31W5NXKfnDoV8d5/4aPGrGadeAejiP4I4iT6z608LpnREW0gcWGPxS?=
 =?us-ascii?Q?gx5SFUnPI6LIL3CxcgDJOaJf30kBek5lbnGnfAUNL4SoM17toe4hU7LAnPz+?=
 =?us-ascii?Q?zxN64Kchy+ZtoOp+FquugZRynRVeZyh6ZrKhuK2T/TodcUfgPeXSoOKcb1Pw?=
 =?us-ascii?Q?2sOWrXJjFY/O52O3nz8aHYpf3bSaygsW0m168Xdpimcs0rmQwEwQZ+V7s6oF?=
 =?us-ascii?Q?bK9C906a482GhdLkqhs0h/17c0xTpjJ6S4KaMuDEZd2UAmaG1Z4dAkgGnwTX?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35540e23-9175-4e57-7d8f-08da9c8cc383
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 11:22:41.7125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MM2SkcSwCVombm0KBna5I7NX4xL4xROVxrfZmWdC0fU4adrv0FHtGCgpVx5Nd9spGdJ0Z4MkJV4YL8IsyWtYQ+yulekRhPua3h11p+gfeVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_07,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209220075
X-Proofpoint-GUID: eQ06WOFik7of3hvfZvw1F_2_2pd6-U7g
X-Proofpoint-ORIG-GUID: eQ06WOFik7of3hvfZvw1F_2_2pd6-U7g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

"&srq->pd->usecnt" and "&pd->usecnt" are different names for the same
reference count.  Use "&pd->usecnt" consistently for both the increment
and decrement.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/core/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index e54b3f1b730e..e36368a4728d 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1038,7 +1038,7 @@ struct ib_srq *ib_create_srq_user(struct ib_pd *pd,
 	ret = pd->device->ops.create_srq(srq, srq_init_attr, udata);
 	if (ret) {
 		rdma_restrack_put(&srq->res);
-		atomic_dec(&srq->pd->usecnt);
+		atomic_dec(&pd->usecnt);
 		if (srq->srq_type == IB_SRQT_XRC && srq->ext.xrc.xrcd)
 			atomic_dec(&srq->ext.xrc.xrcd->usecnt);
 		if (ib_srq_has_cq(srq->srq_type))
-- 
2.35.1

