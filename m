Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7A849224A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 10:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345430AbiARJLg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 04:11:36 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39972 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345360AbiARJL2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 04:11:28 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20I8P786028953;
        Tue, 18 Jan 2022 09:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=zVUJXXfOtMkVWdivOT4Mkei0AxFWxUiLzwDV75dWg4g=;
 b=uizEnZit2EE7q7z2tJPhgf12Q9n0gigAaoVRxmZjbaQBcTD5wGihHzRQeUWL9QLOysJ0
 igwECXcHkFeo0aSNcU57XwnYptsVRd1WeryLkAziXO8TUETmNGFYMUQVpm1OrpQKu/PR
 ECEuII8rLyDO/vjtd+XV9k2LUJC5Y3eUMQGVjlUugNgjBNBZDfNdmrXuawzvJ2/UA2ia
 zUkfPLAyKs4EnDKX9mgXrK6+3M0+y74ctZgsTFUr9LecE8aZh57ASfLJT2+Lj4/aqQIm
 EyIpovBWkpncNpfIXeV8NxaSn8+1Mb7p6hYIa9IWyTdrSxNY8ozv4A+Oxlsz9ygDdtV8 yA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc52samu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 09:11:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20I9AOLF036080;
        Tue, 18 Jan 2022 09:11:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by aserp3020.oracle.com with ESMTP id 3dkp33wta9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 09:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaBtkRhdf5JC7QbHIgctZE0pP4sB3/3N6WqSjFpFKim4uJj2Zx0nlHc8wAYuBsJiPsjZTzymzoIL6uK+df2V1vWuQQPJ2tT24CvZTENpbY6XbyRn+hoquH4N9UfSjygnnV5ADxltmBOKZq39zcSEM2Vi43fn1tTdcxu2R19innLq0rMyY4km9gRQ2MxG2qXD7U1W4iQ8mTIX6bo2cw2bdhiVkuienqs3MfC351JLHKzZQIkPRL2kaY7mID1feWqeZasaT4s4qiKGZIzDnbDBFLS61gdQbEK7IVoXYPT3zdwxOmG+0Zm7RHRNTQqe2S3pWCGMDBvT1PeU896OaPs+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVUJXXfOtMkVWdivOT4Mkei0AxFWxUiLzwDV75dWg4g=;
 b=UtqlfSm8uj9dxCPO5sWPXr5OaXr3odR/LdX8tnqYbM90xZ2vPF5uJDJ/KsXDUlBRPb/OsxH8BF7vkCyzwt9LieSibMczOpohWSHNijFozLwwbU+wtb7vF9yuLwqQIGzNGIRGGYkP0/YD2XCVqaT7vebTqhW4is4oYZZehxCYosrTr+H5rlRH1gAiow3DQDd4CF9QXUV88PflUQNiDCxFzEr3b3t6SJnWoJ8eV4S9o7jlDOlqAsGHiB3nRMt6FIRqzPtZektN367YFjtkgVKH72Q6prrV0h2qk9dqhrUFn+0WnevXj62HC1IWxsxL5iHcBfzgKjFDjrriNAxnBDuchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVUJXXfOtMkVWdivOT4Mkei0AxFWxUiLzwDV75dWg4g=;
 b=kC5LTy4WjTt07uyxMyQKz/jfb3VO82MMHqQVe956qA+viIAgmv33CUP3cimjrZUJHaMarHHcW83Mf02y4WMZk0ODdXco5b3UiQzaZgYkEozsfvOZYi5pMq6avjFxJ+XiaIL4ziY1aK1Eiwja/vCuO3YLwuU8N3SXGCyhavOBHVk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5891.namprd10.prod.outlook.com
 (2603:10b6:a03:3ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 09:11:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 09:11:15 +0000
Date:   Tue, 18 Jan 2022 12:11:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leonro@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Gal Pressman <galpress@amazon.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/siw: fix refcounting leak in siw_create_qp()
Message-ID: <20220118091104.GA11671@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0088.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45ee8f6c-c3d8-43be-fb3a-08d9da627aad
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5891:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5891269BFB8716480DC463058E589@SJ0PR10MB5891.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rm70NvPJqHrtjuFih9LV06P/AlQPstZl27mmoRsdsYX0yMRW8awLW46fVOiqArD0wTODNGhGvuOUB0SUm0sRmmjmS3z/aQKMLb+qMYzD2k8TfTwXszZPDHPBZoigWbaP3a8ah3EAyN3F09eIzgW4pFqll+gTd6qXP5gKjrsl1jQEQqoTRuR4nqBvpTyYRlF7MhzwhsrYDr8Na2XWnNBdJ39quxMoK+yY5ktm4/+pZGJb+MnuF62/XZNWYQqWUE98QwhSaWMuuarrZDaANPBFtd9r7/CLoQN1JWQ/gBiLo5VdwKo7xqd6DTKStm4bTzzs5DfdC2m4+ZdlWsaxXpRniUSsxpZYPsvyxhPHaxt0OsvP4N1mY1RZgksR+hoy9HfCm4T00a4QpOJH0BpespPBu/vQWrU5PWFrbNLe1x5lmmTLSyGRZvhbqL478T8N2Wd6pSQt33eNqwQw3b6db3rBx841VaQaRaEkwoHWJVIdw36lpFzMpLEgGHOfpL3KivwybLDbnfQY9dwjz9/4OimmbCzO7EkSSfVudtoq6gG28tSRhCsQ2d/lGMI1vRXC9LLfoXc12qRRL55cypameUXCb+geWfxEzPzEv2iW4HIBCOIxLYs+qIDzT2bS/h8DnUtpvlrx0gPprl96FXUC0eWGguRV5NTklawm5sNKOcz2TO4n3HUN+JEZQY9IdOfdN0qZs3xawmPVLOoboH9YfJEg7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(83380400001)(4326008)(26005)(110136005)(508600001)(316002)(186003)(54906003)(52116002)(86362001)(6506007)(9686003)(44832011)(6512007)(2906002)(6486002)(5660300002)(8936002)(33656002)(38100700002)(38350700002)(1076003)(66476007)(6666004)(66556008)(33716001)(66946007)(4744005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SQYDiGhJpa8BOof2DELV2pQT4l5+dc+eBC2hA+aouiDjCB9Y5z8ePZ6/YGn0?=
 =?us-ascii?Q?SeolnEhHchHCwka54W7HZ1pQq1f5lqL5bg95RHPPVs4eRhWfcJgEP+K99xfj?=
 =?us-ascii?Q?YNzxRjJozWIfgY5kZirXzR+rTL4PKVXW8OM+1npogz4TaYyFxoONLGg/oMK0?=
 =?us-ascii?Q?6cPbOv20lOXh+mzotDMon57ld0UCqzRk8lAcocL5HtzQXPDq7Z/anuwieUn7?=
 =?us-ascii?Q?zPv/JWsvsqyVNM7AK26hTFbYqgLcTmB5Clxgvz7+CJYjz8nMEo3+V8C1vJef?=
 =?us-ascii?Q?U9SSL9npY8m2zIHpk2HTJ1OXt4Z8qaKJQsenQhgnQwejM+h9AmD5hajcZyf3?=
 =?us-ascii?Q?bojjSev7i+BKiNHeR0W1v0L1hRQ3/4NuoJKZJiPomzi1rzqLKIl2fhUk6FPE?=
 =?us-ascii?Q?OZ3kXBFHxPmly/qad7pptPc3xiWxilfw5cCN4zHzIZvMCL8vwbKEd7Wy+eDf?=
 =?us-ascii?Q?EmOHL11DFdoPx8AOsE3R1Vl0eg+vDlqnw3IwkdcqpQsrjpjXlDBgxc9bAj2G?=
 =?us-ascii?Q?ZRyH44L6wlyfOTbfVLb7hbxRMHuOMn+qTQwZKfHxeL5M9DNn6O3B3MbW7DiI?=
 =?us-ascii?Q?O8vkY1NLgo8CMGTM3cpEm/99+Y++5m2zZbRNnwV8NKZtlPwFfCdAoXhlalF2?=
 =?us-ascii?Q?3FK2+e7xERaEbkdrUIBlgOzzHO0NNtw3pmdLGHlJ0uOwRqFX/gFSDqpV2GM2?=
 =?us-ascii?Q?hN3Hq7fE1R34j3ZkSvbRrlftkmdLSP8u61u2ppcytdScPpr19RN7TUWFpWfL?=
 =?us-ascii?Q?8nIK0Y3vBatA2VdAmNiOlQRpiMCUc6h8K8U98cTc8MImMvhinqjGC5MbjRyz?=
 =?us-ascii?Q?vTXdewSS1zLVstpb7ETWyn7TBjreeyiJoyiRjofLATMIem6jAeDiMNK1cj6J?=
 =?us-ascii?Q?cM9QRFzqO5HPj1LnKbrdJFfSMmMItmhoqvbp5TUdIgn7MB/yEa5L7aI83Ein?=
 =?us-ascii?Q?RmKnfm7H/xjEZLWpmjWprQQgdAxSZNeVmrj1q8zFWC0FwNBMEJA22bpPOLAa?=
 =?us-ascii?Q?SjM9CVehMzYYYQFqmUsysAwM35ZPiMFPu5Pltzb2NMkRlJFdvWHzon377sY1?=
 =?us-ascii?Q?w/KcwM4G+zfGwmCp3IGfs1VAfhlwu1EO8mCQrEIfO/5/6VBlXn8JJPlhOZyh?=
 =?us-ascii?Q?/wOdzVnhxqTXP8nsRqAPENstQvhWekGdhFETTF9OuoPdUDbHGRxG8+xUBJ5C?=
 =?us-ascii?Q?EgzTIDgkDDItyIgEzKd4d6vKcpz83QED+MhZbESBZhhk0VEr3duC40+LUt+u?=
 =?us-ascii?Q?xIpXURzliIc6HUtn39DSVUVktJtI34sNfNj0RYysCJxK2l5u4UAoatD/V4RN?=
 =?us-ascii?Q?5/AqwMy6tr73IVblZ7uRHcSukjKKCvUpt8fIL9uYAVATRBDO4wCU4h/jU/TF?=
 =?us-ascii?Q?6BTalQ8ISnK2pmNXEyOLsAjJAx7V/Px0mpYd6lutRw7CbicmGH/g1yqmY2w3?=
 =?us-ascii?Q?XMi1Q+NZ/2sIVq/5wH40ypbPY34op0hUVdEcl0QMMGQia6xbVZW9x99N2vXi?=
 =?us-ascii?Q?+1Iac5LczBHeEkVSKejlwXCtKYqblGnyXsSjmwLqQPoJtJ+3Irge1t9RP0Uh?=
 =?us-ascii?Q?GMVl9+TOiBNxsINBgetvEMJyhODuNY/JmW53hx5gArb5XOXma/rOaJx0NyWl?=
 =?us-ascii?Q?ZAKRuudCtmHSWqiyyOIq1e2VPLgUreGy1KaGEsujHStXb8px4bF9kDjg52EF?=
 =?us-ascii?Q?EpAAAg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ee8f6c-c3d8-43be-fb3a-08d9da627aad
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 09:11:15.1227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPBSvEw9Pympz8qsIjgB/X4aOSjhOKo0ErjPV0fMmTfWolwJOvZmAvIOHjaa3vuN1Qojg70UZFV7F5VWQadAmOJK4rA3We3E/jkBwk7v0uU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5891
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180056
X-Proofpoint-GUID: pefOtBVSCNRfmD6EUVkGmKnYRrGJj8Lg
X-Proofpoint-ORIG-GUID: pefOtBVSCNRfmD6EUVkGmKnYRrGJj8Lg
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The atomic_inc() needs to be paired with an atomic_dec() on the error
path.

Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index a3dd2cb6d5c9..54ef367b074a 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -313,7 +313,8 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 
 	if (atomic_inc_return(&sdev->num_qp) > SIW_MAX_QP) {
 		siw_dbg(base_dev, "too many QP's\n");
-		return -ENOMEM;
+		rv = -ENOMEM;
+		goto err_atomic;
 	}
 	if (attrs->qp_type != IB_QPT_RC) {
 		siw_dbg(base_dev, "only RC QP's supported\n");
-- 
2.20.1

