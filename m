Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CD2585379
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Jul 2022 18:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiG2Qdm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Jul 2022 12:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiG2Qdl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Jul 2022 12:33:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEA362A45
        for <linux-rdma@vger.kernel.org>; Fri, 29 Jul 2022 09:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcFKyEsv0uj2zRwr273X9DpKcXn9PiX6fTVn6xttBhA92JidLkHZftSqoqQBaVDW7RCe3nZb/R7zrIxxLK4/IiVDXfL8MLX0W+onpQNV4GLwm3g1uWXOaPy2sX5KwK9DlB78Y9QL8pbP0kukv2zDqua9pCTRATC8Ra7Det4ACUsAfiGykgKsF+h0RdB8gu3WLVYS2o5JamN5XKsTQyfKCxmM/zfFbcdSTmZy9Fqg9nhknfBQXCHTVoXCIBR7+JBTFIiNOKDjPqvO2oMygTiy+G6GZMZnqnfDcuOUTvcxzlFf2g/hAGVf7SNt8tVSmpmhFxVLT2fE+FgseUMP3d8UbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuuw5ujF0NhNK3q0QPhp+jFlrJNAE8w9di+C+FPNw7U=;
 b=ZNcicpI27mMFj0FrX1TGGbfzKZeGh2juFvM0Xrw+Df+mogsPzu5rTOUZvSoSKSnqSIjjTMQcfa6E22cQMfX3tL32ufnoQKym82LprUNWgESvQmrWV4Um6Fiz1J66WyE1SBRRjAd7Oj/w9k7iPFuZ5Vb/1tM/pVVBBVUyqcWdVDyziXE5lLjL5VR1jLS5IVnfM+PHlGw/EZooHzF3d1A0GTNM7/3Gp2oJSERknGdTY+NT7lmFn9JkDN68cfeoAJh+v4e3CAxqQT1dFnzANNc/njwNTq6EGin6jL2sUJCyIe/GLMUyJV6slpbX2cBTzpnVS2/pgvHQaa6DmpT54FESIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuuw5ujF0NhNK3q0QPhp+jFlrJNAE8w9di+C+FPNw7U=;
 b=BV8MluUv0sEGp+4uMWDMfVKCziHFnjirJ9LGRck04KwNskvmb7D8sLQL3AzlO9HPiqIOwz7qUuS1CHLH5JP0Wk73A+y7t1N6Vq6Jq79VcEP4bGFnC7Zk66qBiHMEwN4y7PEMpLYSSRwZ0aRLT7yxJeYvqIF+DSaxK1McurYEWS/XA7/Fls5dUbOu3ciuFU0AlGAIfifXaLn00Zr2yhvbKZGh/TQt1vWyEVCihWsEDHVJPFGBf4gkX8DISlyCj4CfaT1+vly3UyzKWio7SG7d075nr07mtpOaamDZTa55dEWu0JjhTfaStY1VLLTaljk9O4NzyWMn5WFvgPp9gy4msQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Fri, 29 Jul
 2022 16:33:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.006; Fri, 29 Jul 2022
 16:33:38 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     Pavel Shamis <Pavel.Shamis@arm.com>
Subject: [PATCH] IB/mlx5: Call io_stop_wc() after writing to WC MMIO
Date:   Fri, 29 Jul 2022 13:33:38 -0300
Message-Id: <0-v1-c5dade92f363+11-mlx5_io_stop_wc_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:208:120::36) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c23205a-7e56-4306-de9b-08da71801755
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f43ifICqf2Kg9kXJEqrRruwUbqA4xMsm778fogO8Cm5+t095VNyNLS7zsvMz1nP4apt/G0FxVjhzn9MFBmq0vkiHvtk6akyJvtaDWxnlROaO+ig1D7r4EJT3tNDAkdxJhIgsIaApBvJcVZCgpAuYGw8dlkeKrj0s4NV0DtYvNnCJKYtv3vMDg9HPPD7dH9wogmhMgyAiBfEmj7ExWUG5EpyPbuz2Zsn1pIHfL6Hu85h79+x0gefrR3uH3FpVt4TnR442dIKTjRm24HU6S3Ar8eSm4jP+ZqdQDVdQZZlJc3Sia9iJuecsDakS2ylFO7j+tX9g5LoDJNDe1zvv+kEx70TFLH1Gu5obnq12s1p7XOPZzi34RxEvPv9fFKrBK/t6ym+zLXncEbDuN8AD8PGzyVkoRsutWEag1kmAJY0LJB9VAvyAUM9s1WNK16QjreJjVALZaQ9zTb7yBVEOqGUs+4jt2Mp+vfz0s94nAmNh7SRyZCYlaNZiRjABKUNj/Bxjzxxwd/N3HWSP0YZuJFHY52pdpF87Aoar6qKu26a361iNGiy26OZTRrtTXe3SKCT9lP3N+yV+vPt8IwlJg2mHc3N3ZqM8YxFCdBviRCSbnSMZtyW6AlBh7wjUDhd6A5AHtPiGjNjCV17rVWsFFulDnoOC696TcGHDmxymj2oz39HURg+UsGPd+euT0s1YT9SPXlAiaViGSTTo8NGGoq99cX38CSqs3jTxx1Ie7BG1ICh5KmuN5qfBuZgHKdIN+xlmtuwt11nKq9erlwFStWLTR5mGNHNhMuTBS82+sVOgn5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(6506007)(83380400001)(186003)(5660300002)(478600001)(41300700001)(6512007)(66556008)(6486002)(2616005)(8676002)(36756003)(4326008)(38100700002)(66946007)(66476007)(86362001)(26005)(2906002)(8936002)(316002)(4744005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9xkOlMG9pSIBcHhE+hNnLSDgniMf7/GP7W5unl3farGeS7tYCOazZyVz97uW?=
 =?us-ascii?Q?lKvgpQAPYrXiUceonQhubZTF7JH0Pt2fsBnTlNyxJrq/1506jdg0oE9x1p6G?=
 =?us-ascii?Q?CSd34RZfeDJpUAkmBbA9F+6LEbCwHKk0My4LaBNHcTuL+8n+gKLzRJm+N8xf?=
 =?us-ascii?Q?OHAPKo+hzYK/Sb5Y/1jVnYIgcp4LEhEpd4nnMUxQJ//oUQIqRHrgFJS+Hn2Z?=
 =?us-ascii?Q?ewYisA/TGknyMFzjCpmp3ytvEHz5mHojBwtPcVEW8njtsQ54pHDx7BQJQNrD?=
 =?us-ascii?Q?yi+GLfVO7yQGskC1pMNVQ+ufz/S6teYyMP6ak74h3P/PCuI8nf3V6Gb1UHQP?=
 =?us-ascii?Q?eTNj4vCK2Lrroz1y76pJHMFeDKHQxh7e6x5QIfj6ZAyS6jRfM+N2buCmt1A5?=
 =?us-ascii?Q?/ptWfotxsWCLq+WPhASWGbOATE6lBTlXSSRTwai6nAbl8r6EDEOsH/YMFIrg?=
 =?us-ascii?Q?TRYlZuzQHdyfqLBi1xAEvmT74hnksYf9yoKJpVWsxN0VAw2yvyIJocPsR7rr?=
 =?us-ascii?Q?t4g4Nam86GMWLlEpjW+IrwZGk8+6lPG1uqbQKTncFRfz5WLW3h3/VDJVMdqv?=
 =?us-ascii?Q?ukiJLBgvpcasato1Rjyf8lQXQdEpI3igJilsoLt/NfHdxK9XehJpV5M7A44l?=
 =?us-ascii?Q?hVVxn/dqeUM4Eo7xUSXrRk1d7hcheU/yEg1JcJdVqw+TObwzOgnqTgIasW9P?=
 =?us-ascii?Q?Vg6yW7i/J6s3ecKf05MJUMKklH6TDazgVtBMBlfUvHd24GHBeEjsg1js67HV?=
 =?us-ascii?Q?/IfUqpGFTc8fc41nV4zJ7wdhEErxurUwGzdOcq/otTwCBIIIAPihPBtAXXNQ?=
 =?us-ascii?Q?o8f9x/q8djVGvtT7WsT65830YabKqg1kFAcQcNMrah0kcIHIN+XWelQgI4/W?=
 =?us-ascii?Q?elroYmiOwPGRQLwiD3lfv45m2az5KCzFZAujHcd8p4t0w5hV62rGcwtN+Lnh?=
 =?us-ascii?Q?VFcFsGboQKPTNF8uzCXcNaMwI2YFQ8NzXOGXFpLpriXy/Pl/3dZnkQsi+R9N?=
 =?us-ascii?Q?fzpIs4RPFWKEDooegQJefu7SQBNvWGIR3okConcrVbowU7a86dovzgKPMJ5S?=
 =?us-ascii?Q?xWWJ5ezPDDhqN/ZMHoTr1u0NPGMSvejjC/rIm6ElD5WGsXlHjFCnHsZ/R8B6?=
 =?us-ascii?Q?tBnQ4bHR4HW+XyOb6+Lvfk3xdt9i067t+ec9KUFacdQSAqyS1YnKlcSM4/jb?=
 =?us-ascii?Q?4uayxtRt947NzvEVDP+9t+jNtt9Fpre4GY0uZejHdBQx3QV1cVS06S7WpFn/?=
 =?us-ascii?Q?8sg3W513JuwaUJheYkhH45xYEITeIytXBY1x4S3uG8G/4fFZ78qnzJyQavWy?=
 =?us-ascii?Q?wjP63SavfeK8xzQhhPg4oC1U9/CZcUcIR5y7TPww8Lf66r33EvFTSXkWwm9R?=
 =?us-ascii?Q?nwsxQuxkbVSBQsA7CptugmrxB4+J0UmT2pFRFdTPCSvLx0dR1fMLcrT6/Rzg?=
 =?us-ascii?Q?/wrGFrHHKtZ/Xw/iDR1BJCH+v9LzH1NbCiBGUiXpyngSigx8kncaOmPmXIuG?=
 =?us-ascii?Q?dNTF/MaaNU7PrJYzVCd+y7KgzLC82QEHAVBW4Pu/KI76x6tzLN3wLd56jnbO?=
 =?us-ascii?Q?RMok9YpsWx3I8erX7tHGli+bFTq8yJ2A8Yn140gl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c23205a-7e56-4306-de9b-08da71801755
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 16:33:38.8384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xj5TouDjAL8ewdMt1Ebf7W41vbnEYDCIx/MDrCuI1eAOF4iHF6NarEJwONpyY4yz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This new function is defined only on ARM and serves to guarantee a barrier
in the WC operation. The barrier means that another run of this loop will
not combine with the stores this loop created.

On x86 this is happening implicitly because of the spin_unlock().

Suggested-by: "Pavel Shamis" <Pavel.Shamis@arm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 6191aa833ac2b1..6b29e9ca323ea4 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -152,6 +152,7 @@ static int post_send_nop(struct mlx5_ib_dev *dev, struct ib_qp *ibqp, u64 wr_id,
 	for (i = 0; i < 8; i++)
 		mlx5_write64(&mmio_wqe[i * 2],
 			     bf->bfreg->map + bf->offset + i * 8);
+	io_stop_wc();
 
 	bf->offset ^= bf->buf_size;
 

base-commit: dd390cba54bbd74fb675a4ac0a78dc23a20d49e2
-- 
2.37.1

