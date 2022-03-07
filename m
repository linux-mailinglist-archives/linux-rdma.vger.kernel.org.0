Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525CF4CFF59
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Mar 2022 13:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbiCGNAm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Mar 2022 08:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbiCGNAl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Mar 2022 08:00:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D806AA7E;
        Mon,  7 Mar 2022 04:59:47 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 227Bk9JC009193;
        Mon, 7 Mar 2022 12:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=8aPW4lJ62V4nAg10vUN1nFHaXFKAxEKkEckS6kJuvfA=;
 b=Ht3LXlXHh7+Q7kNdW+je1bIrnpXrf2f5wiGDwdKBgopQffwtveNMvMECP8E6iRsOqR8a
 RlOrDkjiHZddRvF5jlaLZksDcx3PZ78OVy67slT9aoi7S0rkpUcck67TpqeG5FXuWFLa
 2T4rODj9O/apglI94ulfMMCeJwM+1FYPPkuS4Oyt/NHQJSBBF9BK67GwRvwTTnTXYsIq
 4krMgQlcE+CKZPBSlxDjr+wBK0fZv8mr3KSABNPnYbraPqRLIceRhLNIWAfh+zpP0ciR
 Ddyv7ZhryVafuuG3oy4Jvl8Kx+POiEgr/e2QeCXME96HYE7x8Tg5F5XJxT8Q3TLO7mJS cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxf0ksrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 12:59:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 227CuIOt123094;
        Mon, 7 Mar 2022 12:59:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3030.oracle.com with ESMTP id 3ekvytghgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 12:59:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ynu7bUztwLdIf9BUAWt1s+noIrxaGwNR6AxMKGF+qlpYFNAovG1Pziw7YUKZzf6UnFYYGrd88ymXMLegkOujRGy47snIcWjyxer/SIG2UhyK8Vw/nhXUBDyXEHAyP+pOKLAgz2ma1XAfqiP49VbXV8tpyIpR+Nf2+03JxLQOn6s3lLpS2Ek3uVkNqwpZNu3aegGUsjRZL12xz0p0ZCVaHMbl6cSuZwhB/JT7jFagYIr2Emxpozy+P6hCBatkDsakz3jHMpmdCRDl2vpcgXq41++L8Aj4tq8dZxns08EfXTtvehJK14SW1gA+WroLKAX0B6sF0x1mJumugWuwJawwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aPW4lJ62V4nAg10vUN1nFHaXFKAxEKkEckS6kJuvfA=;
 b=Sh92DK5MW2QkXoBm/6EjJSLzMMROu51SPFHQVygFX0qi71ATqvF5xXizainGOc60aFn+Ul7rWBgWRGIsb8Wf+BfsAYUqL3wzFfuRqeUIGZpktXtNSkkJn3uCP8C5VH05IyUxGEMv/fjnQJimtHo01eV65NtZQCBnPP0mPs82/ligl7DJqfvEvzqIBMiP7a2taaXK06N9Ie7JcbPk0uNGskQ2bd8HZSl8cb1qf1rJ44ne7lWtFKahFHuWNX6J/UgRb07cqWSzT7w76EqKksDrVBV47PPsL5oJwT5OP6pUIsN9zDlZZGSWsJHhhGOb7KCpY/OzDFSR4AVltSqYaauXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aPW4lJ62V4nAg10vUN1nFHaXFKAxEKkEckS6kJuvfA=;
 b=BRPtFrlvK7/eoXTmdMdoIK/XFi/0JnFeOiodO0k8JvacdDMQf0/4lXFAR5tyzezpMkvMVwfODr1xdMqgAMyyREsSMtwS4p7Na8hKZn549eSSktvth9bcRkvyGUzRYvz7qsnkSu7mhpSL07fNsvuoPzeUWUbcxJ19vRu002561e8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3367.namprd10.prod.outlook.com
 (2603:10b6:a03:15d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Mon, 7 Mar
 2022 12:59:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 12:59:42 +0000
Date:   Mon, 7 Mar 2022 15:59:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mustafa Ismail <mustafa.ismail@intel.com>
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/irdma: prevent some integer underflows
Message-ID: <20220307125928.GE16710@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0134.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36d0c56e-5428-4160-8b30-08da003a58a2
X-MS-TrafficTypeDiagnostic: BYAPR10MB3367:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB33673B22E289572239F6CD208E089@BYAPR10MB3367.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZ4rNm3AFhz4XlDXko0hcZcZ8cFAlRRE+dCJ7JEtS0EWaJdnVujP9AxE1P+Jq2HQmjGH2dfMb33l0HK6R+hcVE2S9pJybwVFNLm0SiyM6X+6Du7G9OQQIReUezx0SJVm5CqKFyiOTtlKxtxqojOJKHqfzuAi+EbYM95nda174KFdAipAumuxAIaGD72caq/uuKDh+uPnkmxtl864HQJjdeCfwpo86d36i2vEYtmXxsSvGNZATkKBuw0G+bopROlqiIu9hAR+GfEI7tc3nWAXyk5k+t3690y65HB7/tmJ0Bq57FRxi0nEocduOjyuzlrhpi3/RPGtvjyU5woQ5OUSR2t3iVxh3Q/eAYF+TlRjBu4ijulv39CoTpH4bh3yoL9/NtPXvazNo8KIanPndke8+DH42R7R+h/dDdhshqZ6dNeAhP/W2GTo/ZB48JUZTwaMBQG27luH2ocpfnzszvHj3afguTrgzuL9DSmVa7VYIbJdd9KEH+cQpZjZmYmSDNH3+E6lNF+K5hP5dZPq3iwMxekHjG7eWtoppS+n4/LzIefh0dEIv6nWtLTyTYXZI2PhEL0dyBJlURuyzH7/ifrhbDRFSPUfcGIRWXkzLkTknwDygMvFhvkvXJpXIpadlkiMqXIDrqvljubNiCI0yN+c1vEHRewCeo7CA3tASqN8ytMXWdyd+LsHMEEF0U4Ic0qBllVXnhHqhbxLN34eW4cJcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(66556008)(66476007)(6486002)(6506007)(8676002)(4326008)(6666004)(52116002)(66946007)(8936002)(508600001)(54906003)(316002)(6916009)(33716001)(86362001)(6512007)(38100700002)(38350700002)(186003)(9686003)(1076003)(26005)(2906002)(33656002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0bsJBl/JSbZeA/e+2X30VOIDsQrel2+XliiQI1gTOMM5XQ/9JyRzUVR7uw1f?=
 =?us-ascii?Q?+Rk4ShxRsRBQTAAi+bOH9DU2VizBDDKjNcfJ2aJGxsG/VSN5h0dd6BmZx6fK?=
 =?us-ascii?Q?F3vUm55NwYORG4ofagbuC2CQvlUYIQyKFeJxaaa3F4mtOXPb+GvxEyANP8br?=
 =?us-ascii?Q?o/Kqd1mhOV5W0CB2On1MOoLZKWQasHnEaplHT6Q+dmZtWuaAyQ8Q1cG1RMWy?=
 =?us-ascii?Q?pWY21PLoVRyzxu0blbKV3S6xPB5iGMFv9sdX6jK1oBVCyCDSgHVirQq9rJCn?=
 =?us-ascii?Q?WVHWJqxiZMEu/8/PpDY1mUyqbY/zvSvh19wsDXvZSduAmxxOjh2mS35W3kOP?=
 =?us-ascii?Q?RwQFH3Wgmtl6qZiMwSkDWhTrVmhRDwL7Y937VLwnjmmb4IWh1gegVH6oV9nD?=
 =?us-ascii?Q?YYqK2hbVBsY6p8aKG3m6sXR5h20hrcAqcEjykwLk3Zy21ZAonCWW+4+6y5bH?=
 =?us-ascii?Q?D5dfC5F9zbXZFq8W9ZeoIXX/fGoE0D+FwhWoqBwqVYpdAminIaFtP9+HV6gB?=
 =?us-ascii?Q?Kf7yCnZXExI5svd2r8z+TCQPc0Yknmzk4hr8Ntzyv5He1UFcifizAgqwky7x?=
 =?us-ascii?Q?OlSesw1E0LRqEsA/lZl5xbJh5zGMJboYeIdtlh3k2Avw9KKTJ8OryxpaRqCm?=
 =?us-ascii?Q?wpwDsu+pkFkZGXeUPK8lkNdlkasZ3QylHYBbQ5BMIM8YYbyGqlfl1F+0DqBh?=
 =?us-ascii?Q?9gLj4HWJROh/OJABcKpg7QzKPw95LcHxg6SHSEl3NRfjz0bmyZM5ZIEljpqK?=
 =?us-ascii?Q?uejnMjMmgSpcuUH3rdG0KNU7cgu5FvspJ9fjAL2SOViEE5I7XZitajklKvJ/?=
 =?us-ascii?Q?m8ZaZAVFVqMQpc1ZONamqMnV4P/p5rXHe+lzf2vmM79ALQasBZzTPkq1MF2b?=
 =?us-ascii?Q?go67JKfvelnprLAABtveHVFYnkQHBzICd+ZaLXHp35SLFeKy72O14ECuaKe/?=
 =?us-ascii?Q?YI/lT7Fb9Zz6de9fbvkp+P4/QOsZwT+12HkrFVVBBh3dmRdWYdhwQeF7eJh4?=
 =?us-ascii?Q?EPsF9pfZ82UWNFih21L0bVjdGfxRxd51M6CMsJFt6TfUkQM8mQcMU8pKJNIT?=
 =?us-ascii?Q?9Y9HK/u4eOFNE9/lqTRXrq2biroMg04sL4jogcLOFCAH2wns51jvXP9idDfN?=
 =?us-ascii?Q?LM/7R0KRytBJmSMcVWeBvA+uuixwx5J6XvdctmWTenv83X4QJbW14JtKUkEf?=
 =?us-ascii?Q?aOmgzQdv2DXzzkeXU9fZIJDiDBsdXAmOGIvZQ4zmtC20OPdJ5fiBMxXgZOFs?=
 =?us-ascii?Q?BwMk2Fc3xXs1yrDdDCE+QvyMxJ+H1JH3l/KdrWcszP7uPAH01mPHPqpZql21?=
 =?us-ascii?Q?P8FE/4fA+1uDFmQW+rLWDVHY+Gb/JtbXSuslhyJA3wiY18PvAJO53u8tshzr?=
 =?us-ascii?Q?ejUmOWfmmxe74zZxgHDnFCseMt04y4B3DOOfC8U3zPbgOlyKs8uCHQzTWXY+?=
 =?us-ascii?Q?fwpxul1vRy7N0xg/49xvWpV+OUN8FnfmnSRkBmaQhCryRP8J/x5Rv+QVQJFE?=
 =?us-ascii?Q?yBXR9QARfse0JVtSu8oFy1HKGa0nvP8uLU8RTxDiKIWqZjgOZfgbem5JNb4j?=
 =?us-ascii?Q?M2W837ize8DcbDU34DZRYuFESqMFLXMzhMynpWa9mQ1RjHoZrvleWBL7AqxJ?=
 =?us-ascii?Q?oeHOojHeQpEx7YnpHYRkVmqld3UumEaH7MNYahy+4MiNN7vJRIamtk6xnYUb?=
 =?us-ascii?Q?29KBsQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d0c56e-5428-4160-8b30-08da003a58a2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 12:59:42.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWgJ6V0Az2am62TxHe/4TcmxX47AD+oUKWxJYYEzMFIRXoHqqY12z/CyNCEJxSEsyB9zRc7Ixi1an7cVSOzbtaToBypoHkZzMH6IUAKaEyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3367
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10278 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070075
X-Proofpoint-ORIG-GUID: dox72w2_TxQfMrddLvAvNRE3XP8RQAP4
X-Proofpoint-GUID: dox72w2_TxQfMrddLvAvNRE3XP8RQAP4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

My static checker complains that:

    drivers/infiniband/hw/irdma/ctrl.c:3605 irdma_sc_ceq_init()
    warn: can subtract underflow 'info->dev->hmc_fpm_misc.max_ceqs'?

It appears that "info->dev->hmc_fpm_misc.max_ceqs" comes from the
firmware in irdma_sc_parse_fpm_query_buf() so, yes, there is a chance
that it could be zero.  Even if we trust the firmware, it's easy enough
to change the condition just as a hardenning measure.

Fixes: 3f49d6842569 ("RDMA/irdma: Implement HW Admin Queue OPs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/hw/irdma/ctrl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 01cf75e9fd48..58c0e181ca2b 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -454,7 +454,7 @@ int irdma_sc_qp_create(struct irdma_sc_qp *qp, struct irdma_create_qp_info *info
 
 	cqp = qp->dev->cqp;
 	if (qp->qp_uk.qp_id < cqp->dev->hw_attrs.min_hw_qp_id ||
-	    qp->qp_uk.qp_id > (cqp->dev->hmc_info->hmc_obj[IRDMA_HMC_IW_QP].max_cnt - 1))
+	    qp->qp_uk.qp_id >= cqp->dev->hmc_info->hmc_obj[IRDMA_HMC_IW_QP].max_cnt)
 		return -EINVAL;
 
 	wqe = irdma_sc_cqp_get_next_send_wqe(cqp, scratch);
@@ -2504,10 +2504,10 @@ static int irdma_sc_cq_create(struct irdma_sc_cq *cq, u64 scratch,
 	int ret_code = 0;
 
 	cqp = cq->dev->cqp;
-	if (cq->cq_uk.cq_id > (cqp->dev->hmc_info->hmc_obj[IRDMA_HMC_IW_CQ].max_cnt - 1))
+	if (cq->cq_uk.cq_id >= cqp->dev->hmc_info->hmc_obj[IRDMA_HMC_IW_CQ].max_cnt)
 		return -EINVAL;
 
-	if (cq->ceq_id > (cq->dev->hmc_fpm_misc.max_ceqs - 1))
+	if (cq->ceq_id >= cq->dev->hmc_fpm_misc.max_ceqs)
 		return -EINVAL;
 
 	ceq = cq->dev->ceq[cq->ceq_id];
@@ -3602,7 +3602,7 @@ int irdma_sc_ceq_init(struct irdma_sc_ceq *ceq,
 	    info->elem_cnt > info->dev->hw_attrs.max_hw_ceq_size)
 		return -EINVAL;
 
-	if (info->ceq_id > (info->dev->hmc_fpm_misc.max_ceqs - 1))
+	if (info->ceq_id >= info->dev->hmc_fpm_misc.max_ceqs)
 		return -EINVAL;
 	pble_obj_cnt = info->dev->hmc_info->hmc_obj[IRDMA_HMC_IW_PBLE].cnt;
 
@@ -4148,7 +4148,7 @@ int irdma_sc_ccq_init(struct irdma_sc_cq *cq, struct irdma_ccq_init_info *info)
 	    info->num_elem > info->dev->hw_attrs.uk_attrs.max_hw_cq_size)
 		return -EINVAL;
 
-	if (info->ceq_id > (info->dev->hmc_fpm_misc.max_ceqs - 1))
+	if (info->ceq_id >= info->dev->hmc_fpm_misc.max_ceqs)
 		return -EINVAL;
 
 	pble_obj_cnt = info->dev->hmc_info->hmc_obj[IRDMA_HMC_IW_PBLE].cnt;
-- 
2.20.1

