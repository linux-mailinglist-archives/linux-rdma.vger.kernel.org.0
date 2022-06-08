Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6265430EA
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jun 2022 14:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiFHM4s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 08:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbiFHM4s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 08:56:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F7B17EC08
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 05:56:46 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2589Jlik005933;
        Wed, 8 Jun 2022 12:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=WSE3h/whfVTs+S3zBRZX17+p6X8Ul2bh3/G5ZdB18iw=;
 b=BA3kTm7C4TMmyqyFKrky6JzDIK3DC/6hLJliMBSVzxM7kVUGbkvFOpLdUAiwzN2z9EcB
 cthtNZAlH7o9lh0C4CXAggKEBFwvhISpq1Tf7AEJsyUM3Ds3eQaclD0WB+4sfFTmk0nM
 JtzkM5rutwB9fVGiTR2h5Vl8wviCcnHuD5turxTzNgLkYRxUXmvCHXD7wBnQKQL7qk42
 ZdZ1XLA3ptwqvXoWt308+YkDtwVJTOLmKKBlbg4OokLNaO/4iLJU+6nKBxPFeStceJd2
 XGSRAFdn1FWnoUHaumw2/NDYBznLmXit88l4v+Tjf6V9KgQFFKaMh/XyxKADljxJr+Qd 0A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghexedtg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 12:56:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 258CuMGZ023905;
        Wed, 8 Jun 2022 12:56:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu41dgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 12:56:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIPEW7XRcXId6XbtnRQYws/SXUMyeNejlCAtMhWJjX45s9wTw/oz5HpBI/UNH7+66gL79jTNP8GkOnpyb7royfVgl2wcSeZGByVxixnb44OmTKc4YqxDjjyuS9/9t4jjrA54AeH4UnW8TCelapE7f0PG97W+5BbDRc9PErtDlDdsTPrCEpodQJV+SExZLN/qN4w3XA318GlLtXx8hGHMJqFR7BWmVy0dDBJJRX9lfgnwRqTTcpXajSBBLPc+vDADddheKRfnOqzPWet6s01GD0y89gs/lfsFM8FD7/A3e++p8xwSHqG3a4hdDRfuUP6UrE5/uk8HltceU2OA2ZYOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSE3h/whfVTs+S3zBRZX17+p6X8Ul2bh3/G5ZdB18iw=;
 b=gd95j9wo4FhwpvdaSNcflItgarrVa64xJV41naJZImt8iBUwF8eSx/a25IhhPAsZ9lsAXZ36Q6KpeWvH/oQMN5gkyF5iIcPanxA+r95YPAOaVzy+K2plidD+qXDEHQMrXl4VC0gPKkmpbwgKZrvhdzrcxQFz72now161EQhGcNes/0C+CP8H1IKE6DF/XGV6k8pyLNvtpG4STrOhRJL0yJbn5aX1CtF5TtfjEr6babb9Xs1NtqP3LJ3br7EWQ1M8p+L/raFWESX3ghiJ6r8fjQQmGQ5Vp9ejMx6NEgyWfmru5Y3vspvJdSGkUf5APZLiUj7CxF7SmOgiIea+ChBt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSE3h/whfVTs+S3zBRZX17+p6X8Ul2bh3/G5ZdB18iw=;
 b=q9tF4TTnT0q8qlOBe3wLkGYiPUZ4RWxbPqvSe4ATelA+/yPq9JZ1dyYe0/HJ9hyAwhpQor0kOXuvpggkIibfxoikj7ywo2u1v/biOx4gtlvW07hpZQqswgoKN29SnEN3YBFhmDBbcID2MciNI8ssRhxr/m/RPdIlwCcWs2hGFoc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB2029.namprd10.prod.outlook.com
 (2603:10b6:300:10c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Wed, 8 Jun
 2022 12:56:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 12:56:39 +0000
Date:   Wed, 8 Jun 2022 15:56:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     chengyou@linux.alibaba.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/erdma: Add verbs implementation
Message-ID: <YqCcf36CtN3IwXpo@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0149.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1367935-99f3-4940-c281-08da494e5418
X-MS-TrafficTypeDiagnostic: MWHPR10MB2029:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB2029783190BC680DBDBBB1898EA49@MWHPR10MB2029.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uWY9cWX3xY0LnnJP/4q3FdfPgfH1hKUhXNA+RtoWBaSxys4TvR8KsJFDc946n/W4J63LQYMRqiRkikpgmoOi1cOAlrYxHWfRsP5XihH0q8bC6TF0F0tbEbPc9LeJ/EqCkB4vMvesXsnL2TzNQRl0HlMTOJaKlGRoTUID+8xto9F+CeiJqj9kNecFsYl2yeUFIVmXF1ijjNE8Hz4EG5uaeNYnPfhemQmOMEuyWzF0E4BxDlgkG/ecpmeofZdhEGYLor5TN1NmIZqgDH6vUZXYKWkprOW6vcylcXgeineVIfpxvUNcLcuGkr7JlHpVN/fOUzi7A4tUk6eYRsLJDk2Te0jn+jfX/q/Sv26mdB0YDaAJzEWyFBbQHgX72ICFGRjsuzaq+byukIYnowym3O6fMjk5mgrJa5VM4mqevwipBWAa4AEYURcUMoz1TbraO/mS1x2S2ODr84Sacu5ASD7XZ2CPX+x7iWnYoY41kCuS/+hbYwlyExO31mCU9Ip8fRWKKUKXCif/hyjIIvcJciOsTuXrqqNmqNQVVCpD5cHWg5c3ljW0KLzAPTDiaaRCv2t0hF8c2iKLuXq0BxQCHVOaFvc7AdHWxRUkqKNSBxifCm9ZFmOIxCIhFG3w2b68VclXqhFpssfja60rtphJwazcRGT/hjfamCozsyr+f9H5w/jteNNEZZEfg1YaMBpIdYxjUk4Nl4Sws23ysbhvwI838w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(66476007)(66946007)(66556008)(6506007)(8676002)(4326008)(5660300002)(8936002)(186003)(33716001)(83380400001)(6666004)(9686003)(2906002)(6512007)(26005)(44832011)(316002)(6486002)(86362001)(38100700002)(6916009)(508600001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k5Oa43qbsaBwjZ+zAA/b+HUp/pSIOl2OEMmCP0CjSS0Avnc5nY4B0ZjkOJJz?=
 =?us-ascii?Q?eNvAkofrfYYwZxZWKRN4MTybk0OerMFiwNbUGf8/hDfiOFXfwmbAas//PWqb?=
 =?us-ascii?Q?Nl1hHH4zaft97uBltdHsUB+IrKu8b0yu0j7SIhr7uk5lhigI0Z0423iPDit+?=
 =?us-ascii?Q?qYtOTSJ3A3EeRCO+soPAScOPbUCO52kuOnguiQp3Fu1U+u05TEAuaiopJxmM?=
 =?us-ascii?Q?axAM7GJxJ72xJrgBMKrWDs37H3d2WyBwBiI9HxGKiunJ9xGy2ByMab6URN//?=
 =?us-ascii?Q?FJGfrYv1rNR0wiBgfEvU3npbIbwDMV/zp6+Ss0uLYZKZ0/V3OsidZD6pUVpY?=
 =?us-ascii?Q?a9t7/ZjB52FptHyuNX+sqO3Lbd9MNdlGnpDok2oYoyfyCOCjSFE1YWd5hqUf?=
 =?us-ascii?Q?fEyvIJ+OLGYwi41e0FXFVdxFco6v01DcrnMsJaInp36J+IDehOcElVXmaATR?=
 =?us-ascii?Q?+tT6QZCHjYqCvkwLTTHvEIfv0qlnU6V6XC3IOZWEjmiSsJLWnCxOYgNcev4R?=
 =?us-ascii?Q?GIuVX+j/QVzjCpYBtppe8vTLnb1C97kFdcU/CzkW8IVLdGZ7WuBVl5f4FY6b?=
 =?us-ascii?Q?2FVVXxntrDtG2w+Opfb3MOVD6dOTeS6j4RSn8yLsdQ4YFYBW56hAeybcNfU/?=
 =?us-ascii?Q?QWmS8stHUVahoJFkEqjisxLa+fTqIe63YY1nPJo9PQqu89DOFaCCuH3CYYVi?=
 =?us-ascii?Q?4ZL8IZUBimPRxwJ36eO2ZjpHSaOLgVON+W92i1EYJmmYps2ce1GaYYIgKLMT?=
 =?us-ascii?Q?TRz6zMbqH+U6l1u/n+jDfAlnbjwqSLoRxNNNj6eiCFxAQzKkNaI7SyUMFtHW?=
 =?us-ascii?Q?VFx20PK3QWfME/hV90XyzVt1dgvBSkhnaZzeibQoAU16z5cUiocmTy1fdwdE?=
 =?us-ascii?Q?tO70uJzrV6GRQ80LEiXZtOuJPQuaHev/tUE5OmWATnPxEQude5AypON+V9qD?=
 =?us-ascii?Q?3PZVod3WAeHdbGBFW77ietITzpOOUFbSCfX/EWZMMASGnMcQJ+7EYeiisU9G?=
 =?us-ascii?Q?hk15uUNlhmy4hop/nTXeSzMCmTj5watTrtqG+LHUcXukyYYibPk/Dlndpczw?=
 =?us-ascii?Q?XHp3Yd5o7E9kiX2SRhKwc2SClGMVt6PG9X8XaIVdh80GFwq1N+wmboucIQt2?=
 =?us-ascii?Q?nE92JAQtU6jdxVyscZzc+W5h7uUbdbWBgTsZ7yBTCJkcAQn/4YUhVs+ycFpt?=
 =?us-ascii?Q?nd1sqWsmtlT+hjadj70hskPsKIu455kjyFHmzoXpYzXTrIVzsOFEpXzkjQoQ?=
 =?us-ascii?Q?9bKSZlU6XWlbfynCgXiSt58kQuHSCm4zAT5p01+hY1RadkuLxHjNSSPx11W3?=
 =?us-ascii?Q?P+4oYivims1PFZeZvm2hk1JAB6SDEaUaGAHGof4NeQHmkablUqM8fiMu3bWw?=
 =?us-ascii?Q?hVymn0ccn7xsr89YsXRcX2O9s7Ffyb2UuOGCt099dxAfgfsuXrGHp1Uxu1a9?=
 =?us-ascii?Q?qNCbJE29RYeIGa/ozgZQPeOSMBK22ezQcMnGFMPvhRJbdgadkgPLkjuO6ZcB?=
 =?us-ascii?Q?S4MaIDpq3ChRFzI9m0qLo/tLVhaj5sI3cv0GL1Cfo5kiX7n2BPiEkD4yr5z4?=
 =?us-ascii?Q?AA6c8Hk9jPhH6+CQJ36llRMLK882VVQUYdrWb+QEjyq61sksBtYbOCcMuGuJ?=
 =?us-ascii?Q?6nrP2e2dhgQT7iDKi9gGJgWnmP04YKnUStiVd22/hTrg1KsOckW7lmBcX0S/?=
 =?us-ascii?Q?0xjyOgC3xY+oUIOEJyFCtd6aTYYCS7+ft2naDXUo4afF4iQ8FGaxk/QHSY3Q?=
 =?us-ascii?Q?77QFkLyKkJdIa32hZCwZKwX9mmBF2yc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1367935-99f3-4940-c281-08da494e5418
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 12:56:39.6969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVvsbqoum+AKfAPboMzPVJh5BTaolZKrT9dU40kRAXiMtFMy1Mz40vQMvqd7yDv9y2bB5X8px/lCm7NKmLG6vagPPNiHEF5yjxdP1oVs1oQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2029
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-08_04:2022-06-07,2022-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=976
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206080056
X-Proofpoint-GUID: rHroG-7SGNqCJArj7UczqI9L8ws3buQd
X-Proofpoint-ORIG-GUID: rHroG-7SGNqCJArj7UczqI9L8ws3buQd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Cheng Xu,

The patch c4612e83c14b: "RDMA/erdma: Add verbs implementation" from
May 23, 2022, leads to the following Smatch static checker warning:

	drivers/infiniband/hw/erdma/erdma_verbs.c:111 create_qp_cmd()
	error: uninitialized symbol 'resp0'.

drivers/infiniband/hw/erdma/erdma_verbs.c
    100                 req.sq_buf_addr = user_qp->sq_mtt.mtt_entry[0];
    101                 req.rq_buf_addr = user_qp->rq_mtt.mtt_entry[0];
    102 
    103                 req.sq_db_info_dma_addr = user_qp->sq_db_info_dma_addr;
    104                 req.rq_db_info_dma_addr = user_qp->rq_db_info_dma_addr;
    105         }
    106 
    107         err = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), &resp0,
    108                                   &resp1);

The erdma_post_cmd_wait() function does not initialize erdma_post_cmd_wait()
on the error paths.

Also it returns comp_wait->comp_status which is a u8.  I guess that's
some kind of custom error code.  Mixing kernel and custom error codes
is dangerous.  I think it's a bug in this case.

    109 
    110         qp->attrs.cookie =
--> 111                 FIELD_GET(ERDMA_CMDQ_CREATE_QP_RESP_COOKIE_MASK, resp0);
    112 
    113         return err;
    114 }

regards,
dan carpenter
