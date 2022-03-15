Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A29A4DA65D
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 00:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346319AbiCOXq1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 19:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239050AbiCOXq0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 19:46:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717015C853
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 16:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkTI8HfVWMgORHsPnX8NNhvHPTIlNi6/N5VLKJ3vlDpGlz0fnX/qKDcbEPTg55OuToU4wDYMsn4yz6ahkPEuPIJHrpPCLsZ1Zh9ZITjgIO6b0w2hRiRlbeoqnJoC6c2aocHyO9Gt9kyrs3TTj9gYAFOzT3ISneGaSfoA4pgsZjAYhztHxtgUhoD/hy/6DLa7ito//x7BZ/Bv4WXk6TI2kZrE/Aog1DAbc6/QtcqL7e1xzPGzWC+8N3/afDDzfBkOjRoA8LXAPhwNhCYOjMXPtA8d9ICGN+kYT88PGd2Xk08FvfhhVgWHAI+D/YuW0Y2dVa/04aVQ8d896Ve+fXMHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI4uwNmJzmpBsgr+dcUidJA4laaaS+kPn3/HPb5Isi0=;
 b=JnetJuNYT2StN0ikt7TX7Cb9DbkekC8JMtP/dO7uRgVnwl7Z+l0k4AsRYFvMNafJM3rXEkPCIEXUm6GKhU7OOQGWxdSiB+7BUw1g6lm9oDEqvnKfDhvKGeQRGOTNvb4ZQzSpE6PaWKmvQCd/E9aGYAB/oveNiS9CKcDt3kPb2oIOu8QoByNFzSU/o+qLXirgwlJy7hUNzcCyktDxNgTaduork6oqHg7JbMH27T10K4+lKXnMFSPKJ3cbpSLVU9rRMlpnh23zbt7lpIzmKUJWHbVEE6rFrPwSm7BtsPwj041fdpu+LbBP7STGhlueDMGWbio+YYKKMsqrz92cJoZBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI4uwNmJzmpBsgr+dcUidJA4laaaS+kPn3/HPb5Isi0=;
 b=AdxDZZfkR95va7F1OHFbTe8FoPKfs7tDk99+I5zs9Y8/zqgXUMFQ/ZO70nakdEERYB1fvMvYJE9H8D78LTVpWxRqj9D65D0CUi23jXJQC7nUTfoFLi0zuRAaULtQxxXFCMM8UPx6Y06PJRHwe+jRuZGT74Ah94ZcMhe5hsQmcfM3p5pFAgDIXxxRx5TVLrn7nH8j5wz+iCDAhpf1fA7a6k62NRJfCOxDUqwWG2PlGu4DE52TQ/a3GlWudSGyAxaxvf4cx74Q0lmsml/NafZ3BLsJZlgGBQsZY6GPbtVfWS1oN8WW4C2O8P3BqBemzNum1ymdWrn/8PzC5AET47oa7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by BN8PR12MB2994.namprd12.prod.outlook.com (2603:10b6:408:42::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 23:45:11 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03%9]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 23:45:10 +0000
Date:   Tue, 15 Mar 2022 20:45:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v11 08/13] RDMA/rxe: Replace red-black trees by
 xarrays
Message-ID: <20220315234509.GU11336@nvidia.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
 <20220304000808.225811-9-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304000808.225811-9-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:208:160::25) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8de18867-e54f-490f-df73-08da06ddd7ea
X-MS-TrafficTypeDiagnostic: BN8PR12MB2994:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2994AE89E091055792E9E55EC2109@BN8PR12MB2994.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocOQ3XYI9CCCzZMZJHYKrfD5QdRWJuyBIuVo9+z6mZzlvoi0VZXioaYt3K8cqgtcCw2f0bDoDRRQj2+yfPBWsXCkqqy8izKeBrvJEYJCW0GyJSB7h8oQJeIZpZiBdSYxS3037/f1YBehY6m361o/rjwtnVdCeX/fB1jx9dCRQbWSuKAwl9FK7oPVfH9lyWYn1frMEloXDX82Whp8IK047gRz6NQNyOSmrLpmnaR2/oMu8zYY/iEtVo49m1xta35C2FednAi+TgZ1OHSrdLbdI+/BRNPrgp9nFmfUXTVFZiKunOwOQiN4MXRPTTJ2HA8fklQKbRKjL/5dp5jC3+g3u5spb69Jebl7RN9bLdpVxteHkFaaPV+gArALHUz5KFg7zsbig3rBQiEajDCavKo9nsCnocYNsJ/UuF6HAZIDJzB3dmV93omTTkO4w9oeN0ROEEmB8QMlyyQdTBKPwmrdGVpvm+OxdrxL380Lz7LqAvILHMShnoXZVJqwOBcfVEjOqk+7J2TxEAb8rQNisRbeuDe1t4vpAVqbemAjqQrLODull32dkBZtAecAsYXJuwNojgPfwkFQhEPiUIXVOjvGLkuXb2fpo2CJb+5M5c9wjnKvWQa26+mQArJNU6Jp80dXGf7GpB0cR0c8noqTZKdoyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6916009)(316002)(1076003)(36756003)(83380400001)(26005)(186003)(66556008)(66476007)(8936002)(4326008)(66946007)(8676002)(508600001)(6486002)(33656002)(6512007)(6506007)(2616005)(4744005)(38100700002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y8DI8kouMxoCS7HRozv9Ee65euPkff0G/oM/55Hr43lH3QA12yVTq/HvZat1?=
 =?us-ascii?Q?FjvAhbH4GFTRnmPEuujUTg4kk89uHkuBMpMemH+hoR/qkGHRhrMp0ABSHKv8?=
 =?us-ascii?Q?ZZs65XRhmNbTE0F+G03LMOIbSyaNp0WwDHnPDfJuBBaoVEz8TsdjMB9JzhRY?=
 =?us-ascii?Q?6cCNfpyBevgURYqICrAO8qTlEgT3TdBRZLxGNRxVz2iuN1ZYdUsZ5fDYP1hz?=
 =?us-ascii?Q?TvdLkuPS8R32XVeE7JRQeq66QpyqPywYiECcyvFW2HRgcZXLxVH3wogCqiB/?=
 =?us-ascii?Q?7rLbyyx7e9G7og5MeQv96tVrmdh/Ip/PUb7lIzc8YCqgrBJ//4QlN3HjVakG?=
 =?us-ascii?Q?XyJ9OUbaqzjWr66NqiGWHdh6RA6b91ojgcFjGe1GKmK4tZzsULPmyvJbAf2L?=
 =?us-ascii?Q?jQHQWHOsLS/LPJJEE2NKANdFHJ/UKdkctWn1Jq5pFxg9bJuqeGjnDP9eRCBS?=
 =?us-ascii?Q?KNBJSfJGRebnBDPv2MIZbLvGmhlrrUdvxk8+uRUyCykh4qjTxMZIUQexNudU?=
 =?us-ascii?Q?6KsAktRzIaxMhK3J1T5UdiZuxKpxh6tZ5tmWz3dR1MdEcOXXzg+bsX0dvbXH?=
 =?us-ascii?Q?Q8w1PrL1tjNfW2rYUPL3xkEDGNDDZzvdWBBRwtFIhUti/c+6GxCb+dCoEBf3?=
 =?us-ascii?Q?q/5t/Y24VBu2vGkzlf5tRqhbU4W2mmBWD8zJoDzZN8nJGj+wotmPplXam80U?=
 =?us-ascii?Q?Ja46U68tvYxZlA2sxdewKAu9jZswvzOttZcwb4WQs3ESKmQoAeLluccQHuJ2?=
 =?us-ascii?Q?p/yu7cHOyr6kzef0rKkeeAFQvPp/AUjgcGnSTp2cNPLVImeZ+Uo8tcGpiFLY?=
 =?us-ascii?Q?xiF9Uy7Wz2Q9Ozmec8Lrn+MWf1o6j8OWB9Vb63WzvjIYTyCM/Q0X4w2YA2Nx?=
 =?us-ascii?Q?qPzPSl5nHW/P0yRgqyLMMKvYXWFVdxwiyaCeJpe8nOU00opezZOb8trYuvpa?=
 =?us-ascii?Q?/G8OPS8CbN3cTBC+LPhi0tkY3TtUAgRSjB3erzuQS7gF/yGPnw2a3xmu3yY2?=
 =?us-ascii?Q?EmU7htfRCu0q9ptvI+X5w+MrdqywffQZ4NXuBwgX9MhBP/J+YrcuBZhZchZG?=
 =?us-ascii?Q?5b+NU+gHaaK39leon+jPIQwFERR89fhskbcvqWC3UEuKe2dFgODytEP0+YoT?=
 =?us-ascii?Q?ehOvkFwR0DWYfVr+I3rlTWL4XKwVU4Y8t66aJAMd0UU3cj5QMZlIUJc0ZqIq?=
 =?us-ascii?Q?pnwS8UwP7JQvxV63z8kPFV6MRqwXdkQBI8mCnLT3psSYEye+bFbtyz5QRsLy?=
 =?us-ascii?Q?eI3HqMOc3swPMBR/Ui2DUf6ZbMqQPHpHdbG1aNLtcvcV4euZNVylWUtT2bsq?=
 =?us-ascii?Q?Ly4o6LQSfofFr3nQIGb9GrftAt7QNmDYPr+416/6QLGGcisgOS3sYyCs+wVf?=
 =?us-ascii?Q?dEcT1/qrBPAikVPuA8obKnwGJW5kvqoAOQpjvkv4PZyn4bG7rBXS+92C4KPC?=
 =?us-ascii?Q?m0ui6bJGTFB5PcCseTobJFPfAo14ByMI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de18867-e54f-490f-df73-08da06ddd7ea
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 23:45:10.7941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkFdacmO1KCjZFQIbrYkNHrrgF7rbZXMVn/+k+f3eV2lBtIAIZo/0aFjyWga6C5T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2994
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 03, 2022 at 06:08:04PM -0600, Bob Pearson wrote:
>  void rxe_pool_cleanup(struct rxe_pool *pool)
>  {
>  	struct rxe_pool_elem *elem;
> +	struct xarray *xa = &pool->xa;
> +	unsigned long index = 0;
> +	unsigned long max = ULONG_MAX;
> +	unsigned int elem_count = 0;
> +	unsigned int obj_count = 0;
> +
> +	do {
> +		elem = xa_find(xa, &index, max, XA_PRESENT);
> +		if (elem) {
> +			elem_count++;
> +			xa_erase(xa, index);
> +			if (pool->flags & RXE_POOL_ALLOC) {
> +				kfree(elem->obj);
> +				obj_count++;
> +			}
>  		}
> +	} while (elem);
>  
> +	if (WARN_ON(elem_count || obj_count))
> +		pr_debug("Freed %d indices and %d objects from pool %s\n",
> +			elem_count, obj_count, pool->name);

Can this just be 

WARN_ON(!xa_empty(xa));

?

Freeing memory that is still in use upgrades a resource leak to a UAF
security bug, so that is usually not good.

Jason
