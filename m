Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90B8520477
	for <lists+linux-rdma@lfdr.de>; Mon,  9 May 2022 20:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbiEIS1u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 May 2022 14:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbiEIS1t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 May 2022 14:27:49 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CDC13C347
        for <linux-rdma@vger.kernel.org>; Mon,  9 May 2022 11:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7ECZBIkCklqm+VExTtx7627ULq4S9n+vzI0hKyw9gnkemK54pYW70/+lTFYG2spx6dL1/BsMeIUHhk/I+1HzwtQ1/skQN6f//kvfw5AS5hEdzj+DEu9kB2bk5Oj5zJog3aKPpSnycMprdmZAAK10u7tGwGfY6cP0TOlHqzr/8RymBGUkmcZ3LUT0uh4g4ulToH2/yWkBxvWwsBRT4Xe8ADbW78SlRYSeT0RZZFFLFT0p+PIkJlfqm/pf40mNs+Hh0cVZVzjga7YSz1oHk57lyM/qkmQtQaLUS58qi3F36bMGyZFgeo3SkKz86/RFjMa/4nhPpzZn6nveiEoQ7WEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zw5iYTL5KntV/XVD80ax4T6AAPR1YtSUQhzEbR/4mY=;
 b=dm7Ro9ecMWB829oyMeRYe+AAHvQLE6bnFb+3yI8DYDERz02iwoIAR96DKBFr7AZsci8dsH2it7ttizERZNG6ZfYUDgI6UxktzCHpCqV8H/GpWksQd/qQW1dAjQ6pHC00LQjk3EYtgpndG8pHMcII26hk4oxwxOig/X1r5PTYZHuRgSFNV1jFmiRg4vSfLyESicAYfebKq6z02bybKmwFmN75cBUXsrEpDyrRMZUTpOhGWHmyZO8uv6kAxygjBJTnGP5fd2pOuC0laykAt2SEHpMuygT8dykxh7cqXSTTX4HzwXy8AgzY2KeNw0ya1anQ0+DAOAg6YskEuiAI/HZ8hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zw5iYTL5KntV/XVD80ax4T6AAPR1YtSUQhzEbR/4mY=;
 b=jtS44sw6pP5rBZcctxt8/GO6ZQcA6kurcNX6i3B4Isw+QwpifZB39DPQZFAgoOrxmjJb/3h0KidvjxytgzT8XXhNbjgXMWxzgPwFAb+l3ezlUTA/aAF92lqi7D2jywy/wTmshYi3wINMW03nd6iAWFCTLLx8WpAVIvZdUvBTj9vun2vywWBFVKr4ZwxONA6rgWBS092T88wJhOWmRTbNBis+C5gSGCObNrkZDX+CDX1DW8Tl/+MQqMFBTQdAjR3XvaZ6xYtM0lzycQB/ckFNKFhkYwPwgeFAGhrvA0QjiU4vDimG+gaWkhUounadEdCfSZkS+zsAjzc23/ACr1PuSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3284.namprd12.prod.outlook.com (2603:10b6:408:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 18:23:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 18:23:54 +0000
Date:   Mon, 9 May 2022 15:23:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v14 00/10] Fix race conditions in rxe_pool
Message-ID: <20220509182353.GA927104@nvidia.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421014042.26985-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 161696d1-83e1-46ad-2e16-08da31e912e4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3284:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB328472B8022F45F325EB9529C2C69@BN8PR12MB3284.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GRfJWcsbx3d+mduvmTWMFpwkyqS0Ltj7v/15aVw6Wu8ICuepXJXHPa+ham8u3KhGS94ksEBC9gNUEhKL6klxWKPRgfE0xYGRVmDbsCqnZL5Lv8KlPaLyI4f1+9A8P4gze3ONTf68LXLbScZO/yGtO+9QkgbbVTd1Jsw4TpNQFj3ARSIJfl4DVFlmrVZp2n52+q0FoluZpRFfHNwSS6l5zXcCztzi51j4uo5fxyA0BK2RhUacHnQC3lkKD+XbvIQ7+0HOJmqXvyjxUawmH0J9TIz6ZE4szB1BHt0WoMKsXq11DDJzRgInxEfyABKMsFn/nhclrS8vbFL02YPJYmjaXluaPiFL2SVOuVeLR21NQC00cA2rYRPpNR8xFUbtbhuKW3cvXwN3T7X7098x8JuTs8AAo85aAaPPrCUIecjLHIIZPFrPOaao/368pVZ9K6pmR7BZgGJfPwvzoY49T0QjgAvzTp9JfQJRei8vcqZGhWa8S0ETiwrQUbjpC2tkjCJXOp23XxEkr5/iWffDdTCzWlrQbR6r+Z50Pc2LHgUQ9IdSDOovaWjJf3NtsJMgryRSS3ZVzlrLHFtXxHNTdz2XRpHVcPU8hr6kNYjcyQeJlnHHrbeMPl2MCy62NyEc9n1OJHiPN98woGZ74mv/J1VUeoCypoM+7pvAiu5i2uw5n0k7zT9X+UcPE4/T/NXCt1EOLyeRqtzu9+U5mnkBS5U+Zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6486002)(26005)(6512007)(6506007)(186003)(86362001)(1076003)(2906002)(5660300002)(4744005)(2616005)(36756003)(83380400001)(4326008)(66476007)(66556008)(6916009)(8676002)(66946007)(38100700002)(8936002)(33656002)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R3ioJO7LfKGqdQaXOrohdTFZ7b++DQZ9AP37jn2ChJYLKU8w0NOePAKrml8q?=
 =?us-ascii?Q?7K+etHnEhLoE6c5DNIASjCZXlHGRu4B4ZS0UgoLD7M+3BKCO3XmhKSuNOQOc?=
 =?us-ascii?Q?btC9y4qGA2ybkpBiS1nuCrgDHVOWLqRN36/cbsm4xoeUy4hi1JBlDUgSLXSJ?=
 =?us-ascii?Q?EzyXX3EI9l4rkzZvPlMf/mfFHrzpPK/UR/IiC1NwR43LFLHt6M8v4v5bed0d?=
 =?us-ascii?Q?h1ADYRyMXzN3veg9VsyDhfpXcf6zwVviWWRxcGVyLyr81cqRm8CAEwF5wcZm?=
 =?us-ascii?Q?uQXjIy1Er3GFuwTn2VEqOFyL7MvE5L5f7kLYurES1JEdm5G7erhcpN3PI2Xv?=
 =?us-ascii?Q?m2MRRpYyrMzI0g2iBgZ797E2sgSePgHBisR5wLO/1RlDn8NsVMgZmWDdPNxj?=
 =?us-ascii?Q?/7bZLB3etoAYOlKX2mBUuaEm2Hro72aa5SxRUU3RNY9t2le7EQRo+TNLTqAW?=
 =?us-ascii?Q?U12nz2kir+jnyFhmhgewlIkbq2ymvHTyoxsIXHYTHKxycdsVCu4UddYKiEvj?=
 =?us-ascii?Q?0f2kaBDpW5fgzJED60SSs1RT7Mx+WhNVsTOwrDUEdh+I3u5L69r5WJXw8jyx?=
 =?us-ascii?Q?+Lv+ZEDHNSZMkmpwjW4P+11rJ6EutiC9ec+OZJHpCfAI/1Xkp3ql4BLTJ43R?=
 =?us-ascii?Q?R+Pq7OV/rmGjrIgmKw2BemseFwXdeJR21TlyQDi1Kc1P/aklmj3qm/lq+cJ5?=
 =?us-ascii?Q?rz7BIbuXB08h8OlMU+BZ35CqONH44emCpitKxH7HkAPLTi3tuw9JkUqHuljT?=
 =?us-ascii?Q?Zg4hmBbMUTxwdz1MKadDi4uYCrifnAxMUDcdGnf2U7QeZZ3UtPU2oE31mwFN?=
 =?us-ascii?Q?gteiySvZQKUFMCTYwq2FvnYTBnZMrAnxcJPhmAOflnSsRvivc6ZF/v0SQLCM?=
 =?us-ascii?Q?7d+Z3fBiLGpvRHxqOXwVcNLgLG4RePw4Kk1cbJ6TJTKsruhWw50NOdREauPx?=
 =?us-ascii?Q?0uLbAllvVJ2RrbqUFyD+xlpZ3v6YDwCSHqTUYgNYrLVGX7sZYLRUbYgCOmGC?=
 =?us-ascii?Q?qPlCjYt5kbJV5utvGkrrkZA7hEwZerwMtW9ufW4uUm/em9/YK54vGr8bZ9YZ?=
 =?us-ascii?Q?1JrvKkuZ5HDppNRvNKfOBTYQpTsTlioQUVIvlO+dyqhNnkoPYD+JNgrPRdJz?=
 =?us-ascii?Q?1oYq/n2g6szOqdXCdrYfrEgKImp1/DSC8XnuwOFtfsGTGUzVkMEsqNplmNa9?=
 =?us-ascii?Q?k1ArZWgb6Y0K58Izj4R3h+ErJWSuZ6LGybRepd79FJ1a6oz8oRbFZ5Q5Scme?=
 =?us-ascii?Q?kTVGXDbQODk2ppXgrpOjxyLuWtE3/r9pqOVb0r5q4wIA6lbqer8uCFjzhaq2?=
 =?us-ascii?Q?a6FC+DDHhIaZuWGzWoMlLHmf+tI4XlVUDF2hGcoWRC3bn0H2ev7AUqfEb5P7?=
 =?us-ascii?Q?DOYVhXlss3fuuRf6blVyb88lerDPL0baCmJ0W2OlsEnaeKLCo4v87DBPEDAC?=
 =?us-ascii?Q?p9NeeH8M3xpHHX3RXHb4wmWwAvrgIYVJRA/fmWfbJyZ9x1NnrrLRGtdozOt7?=
 =?us-ascii?Q?AiVfEGXmrlKDNO1pD8kgDARKDMRa8R8IHF/l6sZYPipMLyY/cltaDw4Y3hha?=
 =?us-ascii?Q?Qx6d05PrIaU74kKOpGtgCn1ZP5NSWCfItHYmkkGH01P2HXmGCahneKHuKVFb?=
 =?us-ascii?Q?eTaTTtUJGMrhEkhrbNQ8WE06muTIPO1ijOjfMvXnwlaRP5og+Ccx2wL40G9V?=
 =?us-ascii?Q?ylFAQ5b5dr0bEbGVm5ys+Cf5evh7xAsmR5FXPzUz3N96zMxhOCgvG4oncn8E?=
 =?us-ascii?Q?pOD0bU4edA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161696d1-83e1-46ad-2e16-08da31e912e4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 18:23:54.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhtFbCdpGon6CofITH7lY8UhHSJgOsf0hrbpcPeWAt/rea5qP+Q2O901IGu1SloM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3284
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 20, 2022 at 08:40:33PM -0500, Bob Pearson wrote:

> Bob Pearson (10):
>   RDMA/rxe: Remove IB_SRQ_INIT_MASK
>   RDMA/rxe: Add rxe_srq_cleanup()
>   RDMA/rxe: Check rxe_get() return value
>   RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()
>   RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()
>   RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()
>   RDMA/rxe: Enforce IBA C11-17

I took these patches with the small edits I noted

>   RDMA/rxe: Stop lookup of partially built objects
>   RDMA/rxe: Convert read side locking to rcu
>   RDMA/rxe: Cleanup rxe_pool.c

It seems OK, but we need to fix the AH problem at least in the destroy
path first - lets try to fix it in alloc as well?

Jason
