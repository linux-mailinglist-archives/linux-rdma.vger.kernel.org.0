Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8734E9798
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Mar 2022 15:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241442AbiC1NLL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 09:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242974AbiC1NLI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 09:11:08 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1F71C131;
        Mon, 28 Mar 2022 06:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4M7c0njimMdgVC3AWTRLMksBxK5+bgTmaKc3z7VD6TeUvF280YtAzPiLMWsDYu9huVAk5lFs0+5cxZRf0/RLw2v+N4AH5pWn/01FafQ/ac0nPEKjQe2CKTYW5pG3UKjzcEUAI75lDwOV+j21402jz5x1y5WeDOl2OJ0egTSTLx/N1z7Z1yUtQ3PN9rWOj04WrvMUEzQ3Njpw6p3tIoEnBxP43E9KKHYYYOOzqq8qNnSpyYycT+b7SwAeirRkmUhlN/FX2i1jSi3FJPFoDfSopfHnuhjmWxo2SBHozbTSwHi/iMgX3Zd9aiUZ97QzCJyDen9HiPVBY+0jRQObxQkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVtRoPMwC5AQo48sZqltarz7jYrODdvcw0q1AntM8iU=;
 b=KP1gOVU7zuRFfJI59tkoXGlI/LHuVgob43ytCuXcv4V5xWqGWMCKRUUOoYEKzaqaw9vMIuhvhje4thjKpCUwfxaGKSeZp1w6EpmF7J4srQN2ZdKiXl2+3hNZ+oN/w/1Wqj2uJdmqYPVi23n348ZAPHcsBq1Xa6ONshnVotpfva1I1Z+U+fa2Nhzs3MeV573rZ+JAbXNRnuvnAgrcE4etwnLoGilQj/uqJTY0Is0XVYErxA5lImcWcXJkYhmL0dw1GKnqx4Wdro+lSzqKBACQ4gzhT1SE5jVpv4o27Gu6VrVyt3+TbFSJxgXkfNjocKDyaZ5uHZcFwHfsIKsOn4MxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVtRoPMwC5AQo48sZqltarz7jYrODdvcw0q1AntM8iU=;
 b=XWUXPtGW/mA5cvWMTi/zxh7XPOh5ghUmLdowYVajX80UENmyyR3cOS7WrZXYpk04Ls76tV9iPuEEDu2WWRFzcK7QUBrzh1hGpoWWHGenN6DldkeSSKSOA5oH6PqUloLjG4/bTpyCOL3ztDIhJTwRy5jcZj/PwDvcvxVOE/fpFeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by SG2PR06MB2553.apcprd06.prod.outlook.com (2603:1096:4:65::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 13:09:19 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::5aa:dfff:8ca7:ae33]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::5aa:dfff:8ca7:ae33%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 13:09:18 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        linux-rdma@vger.kernel.org (open list:INTEL ETHERNET PROTOCOL DRIVER
        FOR RDMA), linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH linux-next] RDMA: simplify if-if to if-else
Date:   Mon, 28 Mar 2022 21:08:59 +0800
Message-Id: <20220328130900.8539-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca5a1fb2-50f7-4330-b65a-08da10bc2aec
X-MS-TrafficTypeDiagnostic: SG2PR06MB2553:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB25536D7F0CCB3C2C58392F05C71D9@SG2PR06MB2553.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OmSO17Gordg4U4+2H137Jukli4VGyH2ZlkfksmVff+1eEbo+Ox8hGsnX374e9H57Rv4jJhCtzwAnynmvb8qXdUzCkFN3svWSIUhe443b+Hy+0MWKC0YNHDqXgxQFApU2CVgif9Et7HVoj7PjVZ1lM0NWcDVArl2nzin3/xP26o7E85UH1A3ypcgM74lr0PsqY5CicwlDSNhHQ33+DVJTMlxuydjIFpiim5bAhTs8lnttz303+zgUj5wVk23LNYUeUSpwccZZyV1eK9Pjj2SHV9dfkj3DB079kSAykVNZ6Ofipm2M7QaqeiZJI9+bBAsLMDbL6WvBOEzo+yPSX7SZ+Bc5Pv0fqSrcvHJ5RufOH3D51Nhch+URsMKNciiJjUvIPYJoKoKkuBfzsqjHLKdWcmk0oDtT4AKeRXDvnjHwQkG5KPd1jJVOS0ZLiE9nFTij8bHEAIwHck2iZGvnHWVj8wIq+Ab7Y/mWiI3sSTRe27AkHSdoHrtFZ8EKsvzsD8MbedYRCMV+nK7/VR0MWLAEe2rcZrg21fMpkilT9RQ7b82lQPlaJaWbN7vy8d3/f4u67vyvs47fmg/46VR+FnCysU32iOxjNhWHS9wSLzKugZWggORpCpOfn/bh37JGlI88PygIxWEVaIr6lorj/HrMPPjHQrzQ6tQyPTBHEeKWNKXn0U779mKFdrm05NMcMIcAdsTWryJp8dEmVLz9Z4hStg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(107886003)(86362001)(2616005)(26005)(110136005)(2906002)(38100700002)(508600001)(66476007)(186003)(52116002)(83380400001)(36756003)(316002)(5660300002)(1076003)(6512007)(8936002)(6506007)(6666004)(66556008)(8676002)(4326008)(38350700002)(6486002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ghF53bkHfPQTvI99TDOypxY8pxC1ULd8LqvLUa0qm9BX8FfQggLhURuxpO8M?=
 =?us-ascii?Q?Q1XicnA7y46+UkYFUse+0banUkSW2nE6o3c6JsLDlw3setmFYiFFeMo0Eft5?=
 =?us-ascii?Q?jNIMuW0j7tvkfYE133R5Fut/kopxzYnFXRKIsFlnVWg4WNmtR1A+h/LUilpX?=
 =?us-ascii?Q?JWGEI4wZZ0Yqvk+gUmp/6OeX+dHDhT9DNxCUhZhRqNNT3aafqdYlhdOqmTUe?=
 =?us-ascii?Q?35AgaOdUj7FM5k/Gq1Tkkqq3Y44sj5oE5xRJxGiB7ok6Y/Ox6PVxoWYxiU9M?=
 =?us-ascii?Q?p4/JJgSLv7r8CZyZtZFFIa3fwq1QDp1u8D+7mheXGQjcjEivhf5g/c3HyJIs?=
 =?us-ascii?Q?DdDtzNf1xuiRk4euUIFXS8SS0uuAVFj9n+tRHujZ6fK2TeFpWHpLbgmdSqMh?=
 =?us-ascii?Q?I6b0vKEpT/ddp8/RnjqcF60AqGEt/JQWlxGsLWkOFUr/omRFT/0tek77DcIF?=
 =?us-ascii?Q?NVJrwkZYROo9lX3HwKzvN9ckNssYMQv0zuhg/wdPPEX2wRmK8R+9yI/8Nwq9?=
 =?us-ascii?Q?7XHe4OIdQzYD9nsUIrj5NB7+HG60oAbCJqcXAccmddwJPfmUZWKa65Z14sgt?=
 =?us-ascii?Q?yv+6Ao39UU3YxBcJNUzkQ1EJjgdpPiaqLhvcfI+A2ioCHHD6AaJisiG9o0hv?=
 =?us-ascii?Q?MJg6AiVNwcKJMOBA/XQov2Whzotb5T0K6lN0bWrhGtJoBNGm7OHfFvCL5EJN?=
 =?us-ascii?Q?4jEYcnZ/I2Lt+ngIBfQSnNtPtfDtr7059Q/G2ixSp+msR2710wkuFrEDfMdo?=
 =?us-ascii?Q?pYzYtx9OQNVD+aIMlWTix5PWGoZj/KGutaMCaDM4eo5QYTPNpk6FbUXjZP/v?=
 =?us-ascii?Q?teGCSAbB6svwEquFUCIGZG0yCBPID4UanIHxO07DzR7veMaeD5xmlduGnEyW?=
 =?us-ascii?Q?ShfHxzkZGcB+n+vShS8ucJuX0ea8vCUE+K4ORvZ/CnMflMyrA2J/WXebTnhF?=
 =?us-ascii?Q?yIaZd66LqiJvklo4nSkadfnBEg4kCz2qA7DmbYcYcaiIpjVQh+KHNz5Fo4A/?=
 =?us-ascii?Q?IPR7wWkRjLkkozmk6C7+bgi3UmOTSUvxiUUCbUofVg98QuxHuXBUc2XUMzNm?=
 =?us-ascii?Q?f1TSgC28x3H5t2l8KHlwwTYQedAD/ReiqFTtNX31Z9H3t/1YH8HpBpe9sB0H?=
 =?us-ascii?Q?9dY0ji+ZDHqdNBw24HqgocV8hGWA6gWHY6GLdofvdpLDJdpbhgyEhjBsYbkg?=
 =?us-ascii?Q?tgodd9tL7iPUas0quHwnMCDb4J3LeEG0L63vxI6HUGT0Gfp5Ya/ja8Nu489e?=
 =?us-ascii?Q?biD5S7IVO+hFsI4GyY/3sBLabE9p7/xR9m0IikTx2DdnB6ODTNW9P1shwG4e?=
 =?us-ascii?Q?jtl7gxHcJozpICi8rXhswotUxLe6YHTjhg1+zkFOG1taLt1AsKUQ4e+XsXq/?=
 =?us-ascii?Q?hZMnmAQuffhwM2KmRh47qpZtInbWL1RHS6N5M3pHTT1r8Ip60Zx620okLYIp?=
 =?us-ascii?Q?F1SkVJXD2VKJwB/koa/rwQkWYwWZj2I/u/NeELzB9DozVJTRBZsc9wEXF4R1?=
 =?us-ascii?Q?k8ASuB6xpjBpgJeGNRGUoirLjLJuQ7hO0Iw9my6ydWmOtsHqjtB98drL1NFb?=
 =?us-ascii?Q?c4OPiyX/awDfSM9ImXc2xadhukHVuGJormD0O55Tl+fwTKSH1UGZjOqMf0lR?=
 =?us-ascii?Q?FUBjlkq9ygVEgvHsDdOkJBtIZJo09GcM8zFHsZiAH2rd+s42NH4kZX37ul9P?=
 =?us-ascii?Q?8gsBMTKWwGA/v0Q8z99PMMZoFzbTpzSwmNmFoj0tFEC6fx3zItNwg1ZMvgJr?=
 =?us-ascii?Q?eOK+jKKmfA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5a1fb2-50f7-4330-b65a-08da10bc2aec
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:09:18.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbwNeYVY0SYBLcOJbymaYyzNW0TSTJ+1+3X2IPSVsrTQnqcnboT8nNjYYWJry1M3eR0b3CF8YhNQJ511Mlc1pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2553
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

`if (!ret)` can be replaced with `else` for simplification.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/infiniband/hw/irdma/puda.c | 4 ++--
 drivers/infiniband/hw/mlx4/mcg.c   | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 397f3d070f90..ee91424eb94a 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -842,7 +842,7 @@ static void irdma_puda_free_qp(struct irdma_puda_rsrc *rsrc)
 		ibdev_dbg(to_ibdev(dev),
 			  "PUDA: error puda qp destroy wqe, status = %d\n",
 			  ret);
-	if (!ret) {
+	else {
 		ret = irdma_sc_poll_for_cqp_op_done(dev->cqp, IRDMA_CQP_OP_DESTROY_QP,
 						    &compl_info);
 		if (ret)
@@ -871,7 +871,7 @@ static void irdma_puda_free_cq(struct irdma_puda_rsrc *rsrc)
 	ret = irdma_sc_cq_destroy(&rsrc->cq, 0, true);
 	if (ret)
 		ibdev_dbg(to_ibdev(dev), "PUDA: error ieq cq destroy\n");
-	if (!ret) {
+	else {
 		ret = irdma_sc_poll_for_cqp_op_done(dev->cqp, IRDMA_CQP_OP_DESTROY_CQ,
 						    &compl_info);
 		if (ret)
diff --git a/drivers/infiniband/hw/mlx4/mcg.c b/drivers/infiniband/hw/mlx4/mcg.c
index 33f525b744f2..a8c8d432d0dc 100644
--- a/drivers/infiniband/hw/mlx4/mcg.c
+++ b/drivers/infiniband/hw/mlx4/mcg.c
@@ -304,9 +304,8 @@ static int send_leave_to_wire(struct mcast_group *group, u8 join_state)
 	ret = send_mad_to_wire(group->demux, (struct ib_mad *)&mad);
 	if (ret)
 		group->state = MCAST_IDLE;
-
 	/* set timeout handler */
-	if (!ret) {
+	else {
 		/* calls mlx4_ib_mcg_timeout_handler */
 		queue_delayed_work(group->demux->mcg_wq, &group->timeout_work,
 				msecs_to_jiffies(MAD_TIMEOUT_MS));
-- 
2.20.1

