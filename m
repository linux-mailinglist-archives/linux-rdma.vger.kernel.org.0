Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAB15EAF4F
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Sep 2022 20:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiIZSL6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 14:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIZSLj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 14:11:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2246344
        for <linux-rdma@vger.kernel.org>; Mon, 26 Sep 2022 10:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ivjj3SO/YGmIpHrVNqX3YEC2cM9eDFiwRujSwH8xqxp/BHTQTxbyhqUzJLnodtyUPOShUsA2WaOJCwPNvKyyPS5lTFhThHhM/XnSun2ETBFFz0iwciAOLICKrl5kgrXozoNkFCk2sUaaGrP1jq183wDvyTJXJd10nRqdmC8Yveu9uYe5Yd5GdnK7yf0m+kH80RBNAvOwftjLtCaUc3+U3O5yBgK6okBFiU8lvg4ns+a4izYCsCO13H5QNK/U2DKDCufOSTMnFJeSIBGCx0uBCy/1GAbJrLDYhDX7RjFy7bHamExJobPip89Bdz1QrsLJeuhg1I4+zjeDusQXS9yMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+xZm30NZSJKiHahz8iD2pLWhTFRd46SNfWWxRdgnAA=;
 b=mtYxSpd+dAtqor7zvzNPAA0RgnszUDRZTrA50gpFO5EzpmtYQ8wNWEGSrlSyasj6FVFQqLWupNxEsVhAjnZtLSEXFogiann201ifvH+JG1+n9GIlCPoonpidj4qGp5ayVonRQ1N4lKsuXYyfSOgiHztKydE8kgQEummdZMx5h+Vk0QYFOYbHLE4w9KLOMrH7Y9iVF0pj5CP7wq3Kn7j8kjaz6NS10pUisiWmdZSyWtBTmk6kujvUN52Bm4WGH5CGb5M82TaM+ua2x8SfvhNvPFjJAeD990N1qdML0Vecoid9hxW+Temb3tdddWrMNg1FDLrdp5CFEYQs2wSOYTfy5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+xZm30NZSJKiHahz8iD2pLWhTFRd46SNfWWxRdgnAA=;
 b=SSVPBuQjbJYy1lEAGxYSwvIV9QPm6CMDhdxROKBQybHDl+T2odRzjhU/ubbBQFD/sNOMCPUhGrmwtLuJnit4Vl0SPsxSFDb4hc4piYgSh+g5nsnyrJOBOJlNcH+jbcvP/BCr1P1lErXTJ7cbkPxEpIkux0dhQwPmQsjcr0jgQtActM5HS51OHP4yyOkIobVx2dtO2q5YiwR3tSqsH3yDnRU2o7Prx2+5Txbwxop3g5CI9Hk90d6g2NPC1sKaNrOvhejn1Uu9lLxKZ4Mp5DAN2ivZpxwqsCHPOPhkzTFNQB8ujawFrKQiiJtVPySswDyk+VE1YV8M2E2ls5zFmfNHnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 17:58:13 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 17:58:13 +0000
Date:   Mon, 26 Sep 2022 14:58:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/2] providers/rxe: Implement the xrc transport protocol
Message-ID: <YzHoNKWzf4avKUhZ@nvidia.com>
References: <20220917031536.21354-1-rpearsonhpe@gmail.com>
 <20220917031536.21354-3-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917031536.21354-3-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0372.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 09604c65-9bf3-4bf2-b49b-08da9fe8ae7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXOiCVLiDmvi++Dho5wzzr2K0xa4aLcn9ApwOan0dojYaHvXfncwXCOFsMS7oU7Qugi5nphToDgYJZRtXrYXx95xYwyzIXa1BJCMlThXR9DleIUTRp7iuhNScj9zMDAc0T4texbXG9t1BwaBwwalUf8zqAbDI0VZFWNmm8dztwiWK32M0fw73XlpIZEArJhP11vB2WF4AjyjnVXzQUXWGn8gb8QTWjIwW1pf0SFUDf9vE8rW+gXHvk9JW0qMn3aFGG8Q/paDk/t05grA0+pofwjuy3ubCVIyYoWvpl0y32cQBjZacKQrklg8GOrwzzg/YB9a0LIO1m2W5lNfGaD2PMSeczrglChJIplkssUqCUsOrrQA6ZJFPE6TPCrSv0Tn5BblCdPJf3qfJz60/umkQHD/1wtROJ3nsgU9PZ8lTqUs6VvqHk1gJ7FFGgWcsvPevGxYFodsDgtD5C1CR71cx0ulVI2cUgmI9Clwu2z6AqjQBOc/MVH8DTb5RrEDc+L/IO1G7DKPEfslaERbzY8PGdzZ2SVZoNwGgzsKcZTHXrZPASq6pccleYm7rUKW4eUStr+/K3ZZxzj9uhftRyLJSBYBQORPX1eGEZhhdYjbg6of2YXqITH1x2q+dK7MKknBo2USKbrNHUAK9GcTfaP3kvzLi96kfa/bgBr3HjxYovL8Y+1AIN1pO2w4M5oNqx/Yftfc8O/WPcvbZpDPm23k0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199015)(6506007)(26005)(86362001)(2906002)(6512007)(8936002)(66946007)(5660300002)(4744005)(66556008)(66476007)(8676002)(41300700001)(4326008)(6486002)(6916009)(316002)(478600001)(36756003)(38100700002)(83380400001)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?62uVOkrguGiRjHWipuu7CUgB5vcY2adfhv3t9rEFRu7EQ0tlB8xs0rkjgjrr?=
 =?us-ascii?Q?uCIs0jMU6VLI0zgbA1pEW6TXnoYEf2HLX60z2ook/yTOjBYD85maHp6uWv6Y?=
 =?us-ascii?Q?GiP1LxA+Du+JeSJ+rA0XLl836gHc2hmVB6VAkN/kBi4VtY1V0hhqkSx4zhON?=
 =?us-ascii?Q?zOmCAzZ85aHwbQ/XvhVwMUV6rAOcGtoK9eLiTUs8dgvOOiGE42VmWBorZbvC?=
 =?us-ascii?Q?mQH39cFJ6pTFNi5vKXBL7JamhS7pJ4JhckvKxGDXVj1FNgtgU/+eTj7QK1BU?=
 =?us-ascii?Q?y84pXyV4s+gMpquP4rB6v0nQg9Fa6Rlo+1r6vYwo2QKNPPpl5xBAnNhp9Xqi?=
 =?us-ascii?Q?FPvJw1YZU11Hs+aCJeNtlinXRqyIpQ4tIbswB2x9d90VwhT1nNWgsZ4m1rF2?=
 =?us-ascii?Q?GAd5Vuj8e9Qb/e7oNAPt+Yfm2bQ1ujvz8Yl0Rn82AiQpgKMWuCFZEkQdfiCw?=
 =?us-ascii?Q?IFx8H+JOulSW8i5DeYSmc6e5ro53LiUMo6YPR6ANgsX78/F1FakRaSHbrAbw?=
 =?us-ascii?Q?yarvCnzexeXrDLLjs62ozw1WMjsbbxNvboL5g7r5662fPqBT8Uahkjv7hvtI?=
 =?us-ascii?Q?8esJV/rbQn3PPOjBJwtiGAumxzHBuZ+GeztQDbPGexXZB5OTyDM45JeZ9rBK?=
 =?us-ascii?Q?iTAr4TxinKxzLy/IQu97dheNCyQg+M5A64spanZxMzefyN5SKtNfcwPmpB6C?=
 =?us-ascii?Q?YWRq4tl25FSCOZQqZ0jDDuwxS94ovxEZQbcYqGrjA1YP5QH0LBXUJbQTFfgm?=
 =?us-ascii?Q?G5RiSrPdwo3gq3p0ZhikJj9c+7peIl/BuNbbZ3Q7bcnxY4IExnRpfjCrFA1Q?=
 =?us-ascii?Q?hU2M7P/Qyw6gY+mtWJQf9i77Dj7uOD82BC+2GQaJMrnrrryR7LjOev4uAeb/?=
 =?us-ascii?Q?B1odV45tuNa5pCyIB7mhWQ6/6LGyCuOGiHMdPwAd43d+iQxKkcRa91sM3PVf?=
 =?us-ascii?Q?vVvkc352OwgfnXCI5VCjV7p0sKkxn4Gehl6ENpBznr6wvcS02m1hf5bPq3yj?=
 =?us-ascii?Q?zaIS92t9rAJSIUMoAjhmBj8TIAj+GX7XRdz5orrVl0t5E+Kpr9B3ix2n+Hds?=
 =?us-ascii?Q?Bw3aD1GSRKT3vLuwfqMh5xZJbzGIvfTu0BSVO8ktsi7/yaJow8C+mUgHlgx5?=
 =?us-ascii?Q?ZpF0BZhv/3wJbRndz+8x6wIKX1Gmp1H59vIN6TT7wlRLjfg7CcMm9vASKyKv?=
 =?us-ascii?Q?4gTRTDD0/OGoR5jIpLHnANAqr2Q0NnfEvXi13FMljVnNmhUUEuF+yvvyE5mu?=
 =?us-ascii?Q?o78tHptCfGNr7cv7AFguulZUkAtiadpa63npoEsO5RyhBIgON8dZ7anRuArs?=
 =?us-ascii?Q?/qP7uEp7n6+I746wJzRH7m4HbE01o9zhNk7hQs1g0dlOiYiK+YRSrnQwuDmA?=
 =?us-ascii?Q?L4W1dfzjsv91LJ9xp3VsfYbvLXtpBg7zmqeki7n7eCfZDHtFE2w5w2ZtrYht?=
 =?us-ascii?Q?JnH9truM4uXaRLazqhagm3wI3LkB4Dlo0aKkMdTDtZbhexE+NI5/r1XTKFK2?=
 =?us-ascii?Q?VrwYfl1NzElD/cAKKF35HAWey7IbY1jjiwktAx7QAwfZa/WmsM8HzNyLRgAu?=
 =?us-ascii?Q?w9ObYjkgKPbebBVPVi4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09604c65-9bf3-4bf2-b49b-08da9fe8ae7e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 17:58:13.7134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jh6t6mf1k5eE7EizZTw0B4D1HXJVq7WGkhOb8ZrRbXE6O0g+8OVT1AmIzwKVwheN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 16, 2022 at 10:15:37PM -0500, Bob Pearson wrote:
> Make changes to implement the xrc transport protocol.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  providers/rxe/rxe-abi.h |   2 +
>  providers/rxe/rxe.c     | 387 ++++++++++++++++++++++++++++------------
>  providers/rxe/rxe.h     |  21 ++-
>  3 files changed, 290 insertions(+), 120 deletions(-)

Please send as a PR to rdma-core

Jason
