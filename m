Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B260B60D0A9
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 17:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiJYPc6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 11:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiJYPc5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 11:32:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD379E5ED2;
        Tue, 25 Oct 2022 08:32:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PFSpa9029749;
        Tue, 25 Oct 2022 15:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=6LLLPptVV2AOuwAuttO7LgIfD2Z5Wa+2uuxthlRvZBk=;
 b=LVdaxLtH3w9Ph3u5nKxflRGV6hqSr4KP99lHxWf6rT+w1RQX+a1gskAOqBDIdRIx8bY3
 eTfRrDhr9q90p+GoMv7V7AQcekKpvbzJoYq2F7JlQ1Z6lA44pW3DO4lVFEVL/RsCxPLb
 ykDj4U9Tpwmz2cf/31UOHkJlHPiuPMFHF7cgcvQ3s8+bwYPdvQqTlKO3BbVOaQlELaIx
 29WnKHwlw6H+i4ekvWNALChx2jlRN4mR0HS+MLN6joclV6pX5i4iCcmzHcmHz8v9DB54
 4xCzOpXMuyWpOq8KR1LOJMVJo1c34KytUbqU3HbUWpUMf9aCGa+tDOAI6Q4uI9+uQF1z cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc84t3v99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 15:32:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29PDYtM4039779;
        Tue, 25 Oct 2022 15:32:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6yas98a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 15:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwOw+frOCTbVPs3aY7uYyIGugqhz2g63foEeIqDgHj31z04AKEVwD8nvOpuOHJHH3rYTZdZBT7Ce3pab43ZS+Ig72ErDVxnOBpgnzhLnBIxPn+SVXZOX6i9EhUbm+5SqIt+Jdu+nJDOEqaRkcBzom7L1PnhRJZGB8nKt8oQzBahkONW9vJKHg9LjfouNRJ+4PzgF7sS2y49ZsLmVAzoyANFgiMfzJWw+49zzHOwcZq/31CLNm4yGhkbr523JGhq3KH9JiSu6Pk/2xVybRGvOj1bN39E2FSULBD6M7ux8dRteniUgMjuWNrEMB6TCGPqG+eomS+F8UEvHPwl6A4a9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LLLPptVV2AOuwAuttO7LgIfD2Z5Wa+2uuxthlRvZBk=;
 b=YyDFoN/6yjhZzQrCQr/dd8dV28X7l1+sc9ffu+5KikyzlqwVnyzlUjEudKEOf7Fj6Km9MerYz22kC5Jl7XQVb6z8ibW9wzch0NlahdJ/e/0Wfpx70J/zHCSB9zTrkNgG6l4QG7m+NrmffnORtBCYX7EzZkcr6ZOtrVT4B0HJnQJoA4Ws69v7lRQSHz36eS5zARg35nYU8+Rgk0rpTg7ZAH8XAzyUnCyZznRLHRjaNcjd+VWMK//guVYzctaYKlzzcvRUKkQiBclopxt+1sjWgQbWrtSAPQsyq5gTOGoNZZAVA0cK0iFO+JQGbcpxnDan4qdS+3FZ6uFomwnzk+HEbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LLLPptVV2AOuwAuttO7LgIfD2Z5Wa+2uuxthlRvZBk=;
 b=vhyfr96zUM+NEBoDwJBiFIWBr7H7AcadU0HMgmwGZYOhF/nI2WtAQXxVxu6EvUh9Z3JRL1RxCvZZ2VsSj+6FUuRg7nTRS7KCjmST4BY1rfCwamK1WgqCKy3TzNn29eHCRRZ/RMQx5YwI4UYkdSTTl39HCYhjoHoBvZCebL9MLwM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB4837.namprd10.prod.outlook.com
 (2603:10b6:408:116::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 15:32:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Tue, 25 Oct 2022
 15:32:42 +0000
Date:   Tue, 25 Oct 2022 18:32:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ram Amrani <Ram.Amrani@cavium.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/qedr: clean up work queue on failure in
 qedr_alloc_resources()
Message-ID: <Y1gBkDucQhhWj5YM@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0136.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|BN0PR10MB4837:EE_
X-MS-Office365-Filtering-Correlation-Id: 83530343-5c72-4410-44e9-08dab69e2825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTgU/PsYMcz+pp8S24CZ02NBUsOcRba2SahwzfzkKNrsl56Jg1UTPOuRxDJhjUBp1q/LTB4ZJcmixgxT8Pg7cWwXTCnPP9mYJuloN4tavZI/8rkuHHXuJuHmGbxrqzbLGuA80WavBeyFVpueL4v9B+hHqV3fmlKawlnTqAM/n7wTEy+mBRvJQmuueZaukmQ1HIrnO+rsb5Yz4qEikbmxjOQPpTKxnL8D1TJqq+3W9Zk/Jsw62zUqsvihFwoilzbKo4O/Ksk+8AVjN9799CmfGCPIZdn2GqIdqfAZb4afaLN/1DeLsK7KtZuFfMyHDpbBF8i/RlaxwnN6kYWJ6b5HwV6Vb2vsB/0M7ZLAG/2dnTlD5stvqaVuPIeLKyC+JjuGnwrovQ67ykv2yPxayxLCvBxHFz1m1ZAyngfxtWdaIq4GZ4cXy9KbgRBlAOZIxilPlobFJoOt88pIE423Se7+VgQDkY61IxVO6iZxUKD9dQN8W+HknpsHAY15xUF98qKQYJUuDX+0hMkSQsHQWLSnwUs1bBpUHOmDSu+mTxvt+C1emmrUuMdugv6EedRdn/qdyRKP53HxaVfPhYKbjUtD9K8F8NT8YUh2RG8mH/eFvBEzpE/2Pi1Y+YLVuwmg3cOEC9USYW9+6fWDqRF1Ob/7cQu0KnEiJrdEg/oV1kOCcxO/0e7BxTQGhX+8DJIkk4yOSVWWmNEUhlzcnjgeCc5fnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199015)(6486002)(478600001)(33716001)(6512007)(9686003)(6916009)(316002)(83380400001)(86362001)(38100700002)(54906003)(6506007)(66946007)(66556008)(4326008)(8676002)(6666004)(186003)(41300700001)(66476007)(26005)(2906002)(44832011)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Huju9k/63FBaOOYIgbAe9BXo120pidYzuYoT5n+WZBMUDMrHUXieDTGht5hR?=
 =?us-ascii?Q?FhsOB28if9/zvpZd2sbGdClHIKyeehJZN+2S5B5+PWsQWVlwcIBACUtnLDtm?=
 =?us-ascii?Q?+QUbIqQzesoh4JQa2q/oHzJVUB1sugVgeqMOCXqeuY0S9bnPBEfMNE9Vdwp+?=
 =?us-ascii?Q?9V25CBKJx6n9XnOP45IWmhI/DjDGTqsPp9+TE72VyL1B3wtKntC8CLVwiDeF?=
 =?us-ascii?Q?+aFoJ09YFqoPw4iKJURZCuJcGP8rwwvf05xfWzkPdaSLJ00/C2WZQ3gzoDY7?=
 =?us-ascii?Q?sQQsqtLyHWf28D+ZUM8O2hkYOKqdTWx6GBS4xaE+upaGadsh0IoZiadF5wqH?=
 =?us-ascii?Q?5ktmXceanXabDXfQayhmANhMskzWwhNrrSGEu5GGuyQkSwX26RtTDN3TRG/7?=
 =?us-ascii?Q?25uK+aqtcL40gWG9jeGLzL8FofzPgUlCNzFGqjDyAmiNmyUWJF98l4tMPdwi?=
 =?us-ascii?Q?Q8cWk5Aw5B362z/IBF4WM11vp+q6PoSj3tMlFRHvZVWzgP01p3RCnB5td1kP?=
 =?us-ascii?Q?K9UZmDUq6KSzk8f3SK2M6RkNwo+2tYgwOVnm2ld8SkvuvEPtGDMml7lgtJyM?=
 =?us-ascii?Q?jF9yjtMvDGKy28Fw9J1Y8xkDD+qPyg+c7ODcK0vGjkUYM4EWt9jKlrA1nDrv?=
 =?us-ascii?Q?5ruVb522DYjzGM5B7OnORBK9xa8tZW+eJifh36Qd81a010MB5fmbBh+lx1VU?=
 =?us-ascii?Q?B2oR1ICG+8/2IUDyZHjoBan4vyaU2fTfX2S57XWCIpKWTqSRzc/L1ZOfEGJf?=
 =?us-ascii?Q?et+0+6d603TtEUieMmPEpXYUuAdXdpCa2okvn9eglm0ANlj1J4yBSGhr1O4G?=
 =?us-ascii?Q?7wMvk3tOW1bbb1aS+Ame8xYchVtw9elOPOuk3wvQGmaLoxM96nB5GVvOfRbT?=
 =?us-ascii?Q?cHVePN5famVQrg1DGdqzVEuEto7ZvzSSMFRO7EhnxjWigqtALZDAiPO81Gd2?=
 =?us-ascii?Q?R2i3jk9QAofejmPoQORIMNJ4Uz2RrINIbdF4dAIwG77GHsgeLou/UbHRovyj?=
 =?us-ascii?Q?yaB6ILJPi+pRLXeavBvJZDEGb5J1C49MVDn7MS+2obCJyMdPjpFYZrsqMflK?=
 =?us-ascii?Q?l7WYi4tCUFU82YHSnmKqGUKVnyP8TVYG0XkmcC3Ig3Mm8a/+aPZZR4hyVuuG?=
 =?us-ascii?Q?WZw6i4GPm448+SyM+9C55UYyHC+BHRnIgEca3VtGJ6xfNUfL74p4aM84Tklc?=
 =?us-ascii?Q?8dy3mMAfPhPE1cccTIjWFf6ulQPycG8DNql5t0d2XnynDeER/O+b/9Jflk/9?=
 =?us-ascii?Q?a9Ce8HM2ArM9kWsxmhZv5a0iFeArLr9mu9HgRV3pXbfrEglQSYX6GWflptYN?=
 =?us-ascii?Q?itgt6lXqW2sECTh3IEwzrutci2WBrfh8ELLuKsqaFpABoMu3QqU1EqZqaGzR?=
 =?us-ascii?Q?YLkb+Ny8SfIUFxSv91ymXWLkJggeFeQD/3ZEa4PV70TXr97S5vCvw3bFe5Rj?=
 =?us-ascii?Q?yTihiuQlLKgu02LPOq9zl70d9FuvXA6aj65nrC3th8P61qLFARbUGaJ5TLVN?=
 =?us-ascii?Q?omo+x53gxY+bdA8hUOlnv9iZso2jqtFnIH8M1CQcItHjIkzf48vsSj124p2I?=
 =?us-ascii?Q?GbrxDwLgS48azIIz9NDuBHZJOH0v4WICPc5Zgd7gMA/MhVnqqsgp0plMn2Gd?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83530343-5c72-4410-44e9-08dab69e2825
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 15:32:42.5184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GH1nyJKhYcUmAxItVNlHV3IOsKzJBUoQe6jkXQF695kISh2YiAp2DkHdcL7qnvY7YrJ7Qp0lTdmO/kVVyTadD13cp4edxXijZrghUwFdm2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_09,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250089
X-Proofpoint-ORIG-GUID: IcjjnPF57yFeI8ilTtfvvcuX4-921wip
X-Proofpoint-GUID: IcjjnPF57yFeI8ilTtfvvcuX4-921wip
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a check for if create_singlethread_workqueue() fails and also destroy
the work queue on failure paths.

Fixes: e411e0587e0d ("RDMA/qedr: Add iWARP connection management functions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/hw/qedr/main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 5152f10d2e6d..ba0c3e4c07d8 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -344,6 +344,10 @@ static int qedr_alloc_resources(struct qedr_dev *dev)
 	if (IS_IWARP(dev)) {
 		xa_init(&dev->qps);
 		dev->iwarp_wq = create_singlethread_workqueue("qedr_iwarpq");
+		if (!dev->iwarp_wq) {
+			rc = -ENOMEM;
+			goto err1;
+		}
 	}
 
 	/* Allocate Status blocks for CNQ */
@@ -351,7 +355,7 @@ static int qedr_alloc_resources(struct qedr_dev *dev)
 				GFP_KERNEL);
 	if (!dev->sb_array) {
 		rc = -ENOMEM;
-		goto err1;
+		goto err_destroy_wq;
 	}
 
 	dev->cnq_array = kcalloc(dev->num_cnq,
@@ -402,6 +406,9 @@ static int qedr_alloc_resources(struct qedr_dev *dev)
 	kfree(dev->cnq_array);
 err2:
 	kfree(dev->sb_array);
+err_destroy_wq:
+	if (IS_IWARP(dev))
+		destroy_workqueue(dev->iwarp_wq);
 err1:
 	kfree(dev->sgid_tbl);
 	return rc;
-- 
2.35.1

