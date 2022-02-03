Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221AC4A8B54
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Feb 2022 19:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353281AbiBCSPh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Feb 2022 13:15:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19636 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229634AbiBCSPa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Feb 2022 13:15:30 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213HTA3B011595;
        Thu, 3 Feb 2022 18:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=DJ0KnQekhAxbOw1HuX5oG9S3cG/NfzDZ3/RaxE3Wwp0=;
 b=kDuFGuEN7lFPXzjLK4lmogZxi+F3Me4GZN5STr/P1JnW6QMD8BZHYa3R2nyjhQqFCPQN
 2em4+SP2qkb2Cum2Yl1FOD1+bHnJBsQX9p8O4i9kwgVsKeT6JcZs/CJ382XzmZ/I0sQO
 KTPYt5oAE7RqckS2cuTh84M8IOGT+KNDWZB14YniPaUAB4q2iCNgCQnF6q7c30xVLMCO
 9rq4Z0FeiwsG263QX0fXiGmiJrbjTdq33JskT4h0ZdFNLiJ3uwm/Ut0JkpYMybt42z7v
 5tyC4JQ6Q/wAI6bViT4Ad/5mcIFmrFjxjk9o/C5oNrO2O6KR3X9EyUjb0uPNSPYqqkas qQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0het8kag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 18:15:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213IBVKK180969;
        Thu, 3 Feb 2022 18:15:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3030.oracle.com with ESMTP id 3dvtq5s5ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 18:15:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSfDvEiiaAhn+TZxIeAhUFZKVgpY7ptG0gmqz1EnX/CFxQ2UdI9F4qR2NqO/4EG4SCeoayyF39xbZz8ytt7cXu8mFskl5EWVRjj79OPhSeEFDqE/z5a+PA8iILhb0eGcOeFCMMA7fuZzSdBpCmPkFrDFOLvH52Jyo7VbxjmN+tc5Hk0LGIxGGy/2Cxlk6TGFoQBLP06hChQrGV+eL4Lp4bM3TFAgBwHsdo8+U6riB1NZP+681RDy93gG4TLQtSielOByeW2BHPizz+3Pif8dXN1iXlgPO1Hwp8h1YIGmLu2rPs6qfSqsZKR4s0h39rXJiYH0IM91I5sfjfAcuZ3soQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJ0KnQekhAxbOw1HuX5oG9S3cG/NfzDZ3/RaxE3Wwp0=;
 b=SxNRJgBIf202MfzUP55A9KjV15tCYzABDdo6jQEHdihUrv9yLCaJzYwAGTeHSS95H30wLxJvNL3+O5RWQ1R0lxYmAAPioxhDi8brvxRBOd9gAoxcauhPOm7QJw4pmtUuZ6GrpRdgUtioOwF16X2m9LfjbAEk22orHTeERPJn0WsVRAkXjpXqHcvNxzSXl/ParssDvCPgQPwN/vBuIQsMDy8FYKe1m1ozdrOnv2uk/S2MqLGtmoykJYteXLrkCSf7sMWkCTf87uNuFgFIp5/xr8cS/iaXPbJGFpHDyCFoCQn9djEBiltKuMFqAdB9if+cJSjUDQuoqBXtyPUZ+tp9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ0KnQekhAxbOw1HuX5oG9S3cG/NfzDZ3/RaxE3Wwp0=;
 b=fFm25mVqNRawAPumSAEp8AqYTHyCTS3srNsQacabLJhmCP3liwue4khtleQBTrWQAMC8qFjh7WSpayjXhxfOuDXnjNL6AubZKTaQHXj8N7xekf3noCu7mg7MH/8j8ueR3eqw2RJU3z32ch4GtaHRFFhVzb1V1j2HxQZZPJsQt5w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4094.namprd10.prod.outlook.com
 (2603:10b6:208:11e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 3 Feb
 2022 18:15:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Thu, 3 Feb 2022
 18:15:12 +0000
Date:   Thu, 3 Feb 2022 21:14:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Haimin Zhang <tcs.kernel@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Dasaratharaman Chandramouli 
        <dasaratharaman.chandramouli@intel.com>,
        linux-rdma@vger.kernel.org, security@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH] RDMA/ucma: fix a kernel-infoleak in ucma_init_qp_attr()
Message-ID: <20220203180936.GA28699@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0057.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edfc8fb3-35d0-402e-be92-08d9e7411e8f
X-MS-TrafficTypeDiagnostic: MN2PR10MB4094:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB409411BCB7967A93119E8E4E8E289@MN2PR10MB4094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8vo3jNFwv16LkTNKrHGAiajn0u0Z5uvObnx7hjJuRaO1azdXohAytcAKLHEnozlkGKPqOIMbZ9kn06+xNxlBBXYiPlhPVOdUp4JwC35Amp8kZZ+eWnZxR232Jdl90gXnW7IzuhGy7QCMv4/H4jSaa6zZ63jXLIS88gf+NbaSN0Z8u/bm+k1NFJ1TVRQPJOr0peKc9fkM7XeloT11iGi6hMHm+7WMTzD0KHnXuPY+6d7oEb9zY2oxi9b/w2YnY/57TTppc2W5aJJqTri2UFsbmcfvVEQ7M0CbW7OUWfH6Tsn2RHKd7O3eoUhe28KfNAwBkYitpgSW5paIlsO+CGyP6FuV8LNRTrs/sjZEBGZb+k7Ti7pLjLJS4fhvZhqRBQgw/58hhpoEhJ+VZ+Ctkc48+EFecD6/V3ZERVmnCeIkPFOgi+CO+Wj+eQ+CO5XjX9Wj5SEZvUeFZAaplS0XEkKsYBZMR5X7GuguY/NOZPQQidQOS/PjizBYQEe+Ly4tTtg2EGacNphiHnVvlW2SeK9r2KBga9L7TIiUg8styrcLffTYSniKVbJhBkoeX2RVD6SOiS88HaW5gny/VUaz+7oT0C0Uaqr6S2qM32zRBIrrtlHpItWSV1BxTzzMNIofqI0P/IPAYGfyjaRVTQvsRb3oHwYqi6S35GS+IPqUmK/wTypfUYYwMmmGnJyzTociSYbCaApksgnHchrdpuQxMR64Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(8676002)(66556008)(33656002)(4326008)(7416002)(8936002)(5660300002)(6666004)(66476007)(38100700002)(38350700002)(508600001)(6486002)(52116002)(26005)(316002)(83380400001)(110136005)(44832011)(6506007)(2906002)(86362001)(1076003)(186003)(33716001)(6512007)(9686003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+7UrisyrWJGsudzRwkC2BNRY7u6Qi3mNfohVKH4ypbWzPYaClEF5QqJ9FXjP?=
 =?us-ascii?Q?w6nnQriJ8FR2Yq2lv3kRjAMhlstwy1Bt3CFRkwU/EV5K49LC0rSoXkfTVeVm?=
 =?us-ascii?Q?385/Pvca49sHIQMohmQXuKTDyHOfQ25plXpeyl9ozNtweQ8hHKqH5Jp8Lq4t?=
 =?us-ascii?Q?UOoexPYDEuP4fvFSO5KnkgVjXf3nfiJPWDGfRIdAOEg3pw9hjW3OP0zXDJf1?=
 =?us-ascii?Q?+pBTcNDtrkWKcmsRsx7g1L0mam8vRwCdiSCoPRxKHnsGwODfnjri+/qmP1UK?=
 =?us-ascii?Q?RghMWDnUCx4Y/4wAkZoEkgKfd3+HJjQZUtFldNYDJeDgVQuk1cMNG4l8gK09?=
 =?us-ascii?Q?Dt1kUd7pSkROp01gqYJMQHSoeTNmwdFFm8L4fV4CfZ91O8lb+7lGfQEGsrFl?=
 =?us-ascii?Q?GTlszDA72UCDsiLyRkb1rSFWWc5L5fH0iC8QosnHzlIdmYg3O/UCfy8rvDDe?=
 =?us-ascii?Q?8KEPLmPSB2RqwM6J9kNp/h5ix6qYyypwCF4CThqsSZA+3E5S2zZ7/8a7szVi?=
 =?us-ascii?Q?OoldbCNNn80JWXEgd5stm6wPL62ueqV7HufU5VxtMqJ14rVUiYsHQFmozha6?=
 =?us-ascii?Q?jEeP4g9YlwOGbr7GUMq4Tu4zNPBjGijTNpUBlhs7X0fOk+guq7r7TuiyawFx?=
 =?us-ascii?Q?rfzpc7GsObue6Un8BFlbzEyWJNqP2XGhp25FRAKQliq+eGUBB3B7j5kXTf8J?=
 =?us-ascii?Q?4Wh9bBBVdIDm42YNWuFsv30gHI+Dng7n0Psh2OmtSlhFqoWUh4svhc71h8O8?=
 =?us-ascii?Q?U7sj/LHmBo0umLeTrnpgxAVfoDUJooh8PEU3xq2iPPT9qB/TRu5nD6j2gFnT?=
 =?us-ascii?Q?sN4r1kWyNyETuPsUrKmBeob7Lvg7ON6HqAfZxI1Gepaoi1u3mAXvmhsc9+cX?=
 =?us-ascii?Q?I4Khxuvy7Wzk9zCxD/VciYKnNpGRAeVKNUKmSV5KdIkIeTmvsrddv6o6zOYb?=
 =?us-ascii?Q?AtwWIVg8bLsfTJxwz5qKvmoFqhAKld/5VrxAPCmNIEX3lIbIucOYojJowzis?=
 =?us-ascii?Q?c4LdzThrhygK8nK7vO8V/WVKfBDa2acwqy3xivCL/K1O4AJcJiWtUadwfaAv?=
 =?us-ascii?Q?sfEi1DyIbxdlh8w3vpaSiizd/n6Lijkhr500VxQ3ts58Jxo+zIZ+IKXs+OId?=
 =?us-ascii?Q?81qgP1QH/vlbEKy1KlGjtLiy71LautW5cKhQqDuEp7uTqZPKpy+FavwJf2IS?=
 =?us-ascii?Q?KJVvuEt1bzWwufKObm2P9lnaKtr9ritTHY223qVadw5gIB8Be1NKb3kqpkxj?=
 =?us-ascii?Q?uiJ0tMhkNeekALycRqjE0GYQeBY2XJ1/3Yccg8j41TYtt+1mLOtZvYnT3c28?=
 =?us-ascii?Q?txeKlF8Y71XPbRj27q68Q9qztuUJXIULQnSprjL9+0GNhpep8X8carm2+est?=
 =?us-ascii?Q?HofdWIv8HSL1CfXdkp1lhJyUm+S6j+uccBejOTj8b/l3oK/ybWv1KWDr6L8o?=
 =?us-ascii?Q?dvPlGxT622BL8lxAt5FQAyzxLiZSsUdNq4/iHlgvzh6ug0ipAbqN1jNNpU2Y?=
 =?us-ascii?Q?/MHRZKrsvQe+HRUKWN+79bx9WdE1Pind6kg3Sbv0CN2qtkQ4AFPUYm7KKoYW?=
 =?us-ascii?Q?2VxYJRNzyTuaTGj2rT7YDcR2YOY6RpWDfEhvZmZwdjakYdQwb0jz77/6BtJH?=
 =?us-ascii?Q?6pe8lykG3u7UXlVrI48Ecn6DIMGbKN/oY0nNMn0PcQm0xeezw+ukh1MIlmUN?=
 =?us-ascii?Q?OsSrnA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfc8fb3-35d0-402e-be92-08d9e7411e8f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 18:15:12.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2+aslJsJ2zZfYCp5mKmTdVvxIjrTO4BsxLfSaciNrYBYsa0xz8dsm38H88GaC0Ewu/BjrJRAZU08Lc8/cdW2JWgpCvH5slA4dDSzsAoWCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4094
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030111
X-Proofpoint-ORIG-GUID: jiDR5KBPTnBaR-nQSNmGA-gntR4SRQlW
X-Proofpoint-GUID: jiDR5KBPTnBaR-nQSNmGA-gntR4SRQlW
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Haimin Zhang <tcs.kernel@gmail.com>

The ib_copy_ah_attr_to_user() function only initializes "resp.grh" if
the "resp.is_global" flag is set.  Unfortunately, this data is copied to
the user and copying uninitialized stack data to the user is an
information leak.  Zero out the whole struct to be safe.

Fixes: 4ba66093bdc6 ("IB/core: Check for global flag when using ah_attr")
Reported-by: TCS Robot <tcs_robot@tencent.com>
Signed-off-by: Haimin Zhang <tcs.kernel@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Resending through the regular lists.

I added parentheses around the sizeof to make checkpatch happy.
s/sizeof resp/sizeof(resp)/.

 drivers/infiniband/core/ucma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 9d6ac9dff39a..91485f13d842 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1232,7 +1232,7 @@ static ssize_t ucma_init_qp_attr(struct ucma_file *file,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	resp.qp_attr_mask = 0;
+	memset(&resp, 0, sizeof(resp));
 	memset(&qp_attr, 0, sizeof qp_attr);
 	qp_attr.qp_state = cmd.qp_state;
 	mutex_lock(&ctx->mutex);
-- 
2.20.1

