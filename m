Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8579B4F9BEB
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiDHRp0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 13:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbiDHRpY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 13:45:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A7B27FC7
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 10:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=na64TFSTTXFMDwar4GpgKeYP16MR6CdU4U8aK8di64u5Am9Pm37KxeVTkDo5MSq9PoZ9h6BxoPpJMC1VnjfVumx6nA1iVreBfbALt6p4+PHWc+DVvX+uZIAzb/tHFiCrSstPFC9Pp57PzDVPd/9D2NKarvi4g8chjxF0iYkzyPKC4EeHAbEquVElEZX6TB++SUdCHEwPQXnKoxjLN2dVrFOiR/HTNX21AEzBR1uUoafT6qLmpbw9QApLDI/AleGgEm7EK5gMkGwpb4Vcj7GRC0f2J1MmFs+qh+HZKKV+WYxYxbA7KOHoxU7nqHxrKCJPv9PGnPsAN627bZ4rZ0uYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha32CPnkAkbZYdSC+jSxjl+YfPrRbQKIV9YSXI5Dpb8=;
 b=AENbueOzna15qWEWAc0AZZdBDnvf6/8kv2VMhLZLIsRxbJQb37S6N7Xq5YffBE5124R0W0SvA3bjcA7PRgp455c8wtNyJOfY2lsrhDb6/0hQgENDmuly/twK/BvRN0LM2rg0j77MzzPVTxx4n/RCOhgdqHfnkqrL9KsnY/caLhvv87XKwYAKZ2iik+YFMLiq6/zowzgxWsIADgf042yFCg9Ne3vbkXREQyJHSSrWintkvqdFvV+HaEfcgUH+jNemgJlIqy8+LKKp4EmhZM411RBaE3e83E6fXLJHK2eUt88JP7L0xXRS2wOUIwtXMNwbjj08l1LaDg3VAnhKtwfwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha32CPnkAkbZYdSC+jSxjl+YfPrRbQKIV9YSXI5Dpb8=;
 b=Ex68Tx+BQQaPA5PCdmq9YFsNBb1zhkJLdHAlmkUaLyvE+YQ1e1pcDdYuKkaBKAKspmUBNn4nTfOrDz7C6mWKKVT/vp/2b8Quo9VG7x2dhOMsfdPGC59buoodDutiRt/D7AOBZa/Rqbru3vR1bBAdyyGmQgitu7hjNd0fMFyx5XVQ3UTstgI8mCdOYgWX9ogHvqo6pG902ZHxlfCOLFvRxn/sqxj0h7QFYmyZ7o2dRs+HsAJBIbzNvmtJFSWcnaoU3wMITWQqwSBZQymTlMeJmI6nkXjOHi25DabMz3upsQio11hOSIn/N1LTZmZcVKAJDIN+nJfWInlzn2Vq0/Utdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3055.namprd12.prod.outlook.com (2603:10b6:208:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 17:43:19 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 17:43:19 +0000
Date:   Fri, 8 Apr 2022 14:43:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Fwd: [PATCH for-next] RDMA/rxe: Remove reliable datagram support
Message-ID: <20220408174317.GD3644319@nvidia.com>
References: <20220407190522.19326-1-rpearsonhpe@gmail.com>
 <cce0f07d-25fc-5880-69e7-001d951750b7@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce0f07d-25fc-5880-69e7-001d951750b7@gmail.com>
X-ClientProxiedBy: MN2PR19CA0061.namprd19.prod.outlook.com
 (2603:10b6:208:19b::38) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0b0a831-2e34-4335-82fe-08da198744b4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3055:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3055D6089EB97CF18F05CEDFC2E99@MN2PR12MB3055.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SPkFWGPSgF027flIathpHJvolSmPtc/G3uTEyS5L7Gw2T987+dD6vJr9uYvaPwz6Zm9GN7J58EpfrsDNmw3JTlBwEjv79N//2rC6QwnMG//gsHML/jY4CKPrF1XyKWTQnOBoGHy0jbjIRvfjfeFNPODz33N1rEm8sWltP1i8/Qf9yw5Z3llEYafk8VmXnFnGh3o1dD1YLSCYHFQpg3xcacroP23X4VdS37OTl2E5fF8zszpw1Ou+9RyclJO5dVesWQagmnlM5bUwEWKqqNzNBRt2cjVZYU7x5f+7AqJyK6IobP7jb3IjHZrEyPyGj558mVvD/P/SWl19Y9V66ZbMiWbvzpVAnewxjrO5yLrRVhV3gz8Sj1jP3ErDsm6YW9P2yELyrWs5j6NWvcdqsGndyaRLYoya4t9E36EFPloD6sZXzkcIiHcWYP1mmKYrbfekN2/uJXRNdgKGKYia86fQQ/5bAW5FPkHQ/+Xf9RToai6p3GkRiTyheJN6vKx1sdm2GOMVlFC53f1s4zRxsMtKtV5ogygO5azYkUkTV48eCrTzkC4zwfLSK6qGiIPIDUugDnT2HGirR4EQ4qBgKmrAKZdAQ+OSASpTONZPErgKWSckQs4ip0NnUsx55h4RYTL7OyoyJMQievJQsD4eIuzHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(508600001)(2906002)(6916009)(36756003)(8676002)(66476007)(86362001)(6506007)(6512007)(6486002)(316002)(66946007)(4326008)(26005)(33656002)(2616005)(186003)(83380400001)(1076003)(5660300002)(8936002)(4744005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YQDpuCaoQQwDXLem6jH8Pc/4Ukvb9xluVVGxN/5aMHYMqqMy0KAnm1hK1k4m?=
 =?us-ascii?Q?DG+iR+g6awZqg41pvHL1dDsQoQoCS0gmS9Qw6A9NtCxjZpAl5gyM4A5cG6oJ?=
 =?us-ascii?Q?ZTPxbI1CsIYVOASuL6iD4d9EdsFCHwMsiM2Kv78LTe1Go2rVaf/nyY5WCLYd?=
 =?us-ascii?Q?mqk3IOQHcMgkOQdvNcCORm1m1U3DnAszwYfkGcEvaviV3yYVts3K9OTotAXZ?=
 =?us-ascii?Q?rrlSBlD20ix2tiCoKvd4MPOIQvDu5fxivjdpP47oPS6s4i8b53zImkPViIfG?=
 =?us-ascii?Q?eXkl8XIvyf8tymMnFkeOdoMqFrMO5iFxk8tP2k3+aBFMlbS3paZPpIZJ824Y?=
 =?us-ascii?Q?pOftEUPm24uNKCYuC7zDOob7la9wPncKLs5RXNKGdT6nCsVjugfZHlcs2Ywh?=
 =?us-ascii?Q?kY1c/8ISIj/DXCU38S7X+QP6y+Mt0i4RV9Jl0Nd59L2H8ubYZsDouQVF3h63?=
 =?us-ascii?Q?taRA0Ew0VbC03/tHidhNujtAn859Pp3AuP/to1ReOYY7S8q0NE0KbHADjkzy?=
 =?us-ascii?Q?emefWftpQsmhguT3fabn7dYXRRTr00iufBehz43m0pdY/MHLF9XhnPIQJq9O?=
 =?us-ascii?Q?frznp+sgBi5Qp7o0b9j4sHgNCtrzIK257QST1lDrmh4g1oY/cZvWbx25RshE?=
 =?us-ascii?Q?SLVIbShm42wuoVYQD0Jl1j7XJqbS9fx2ryup21HYh9h9AFWDw+RI7kHBaL18?=
 =?us-ascii?Q?ARt5sy7ZPuHwqtiSDkrdRNKklN3J5rKstmHqLwsyFtV5UShdmVOxMdE0B6FH?=
 =?us-ascii?Q?iDCeAXtID7F5C+AVdUaHLGDaqnH3+imqjZDNWgW9FkL9miiqKno8+z6kWKzr?=
 =?us-ascii?Q?thq7zz7DdfVIG9nMEp3Lk2NxR2OjhysIZ1a4QaTUL/8th5XnU7BWRg5P5mq7?=
 =?us-ascii?Q?bGC6X0j23bDl/Rnf2+AOpgsytaYK8stWmRaNPm3v/CFG4Dik+xLfx563ACRF?=
 =?us-ascii?Q?53q4MrTYJDuP9BHkV9KweogH0Z05Y+iP1fwHG2ybAPPwLM7N6cTSXofl9JKo?=
 =?us-ascii?Q?waPJ1kYQIQIw2RlnAw/2ZLNFmote8LQpVrUgd0ipQl+wugF/Ds1MZme0jOjy?=
 =?us-ascii?Q?UjSwCKMKtwqMBCp0Vgc/sHSjzx3rGeumCkk6ONe3MDT1vXUnhjf/hdaOTyGT?=
 =?us-ascii?Q?2HVZ5a4jnmxLV0/O6+zf72weTi6BPyQCxa7st4lqsyxAzuxO7xCppk3mpNmk?=
 =?us-ascii?Q?I4UsP5g38i4a58RAvIoWflR2btIbJUmIuIV6414wUIK8IuK39EoOZfFkFHi4?=
 =?us-ascii?Q?UhWRHzsroxseK/7jDLc8FfZYU31rYMjt5+3Y/36MHQw5FmOgOaaRrqU6V3AY?=
 =?us-ascii?Q?cfL4AXxKSIjQTKkOMpRCesij1xpNCUhsawg3+El8+vdeWUFzoOWPIt0id8ue?=
 =?us-ascii?Q?IvplC4h1+r+qma7H36jYNalk0xbOZuR/sy4zVmzkKFMfcEFE6X4WGAWz+b+2?=
 =?us-ascii?Q?vJgW1MCfkcOhBj8dSjPLMHNq0C1im0reY18EzNbijCV52F200LrWa++6w8ZH?=
 =?us-ascii?Q?xwAjc7xh4xPH0scQcE6FNxOF4qOImSOw8J8IF7RIVJVrN32cQlox6lqmVDq0?=
 =?us-ascii?Q?dpyKdayzW9FTIxZnPkhZQyOvZ2O2TWmvv38Bz0qSqQeb4lUQ15ezhC8vQCjQ?=
 =?us-ascii?Q?UEJuRkNLUjImX8c4h8AdtCuWaGcpsABZB27y22bc+mVokCcu3hSQYbCcEFTD?=
 =?us-ascii?Q?BmAo6kfXlWN2qO11GTT3QdhX6EEV4x29yIt5FX3q7QNFW6AkUjIcuzaLTMnO?=
 =?us-ascii?Q?MJqcefrDTg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b0a831-2e34-4335-82fe-08da198744b4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:43:19.2493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjVpkitVywlcIZWm3Mi+ue0dV+rEalMSMw7YRdpy+rSyKDV/A3Uf8TAPHP+Ojixj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3055
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 07, 2022 at 04:04:45PM -0500, Bob Pearson wrote:
> The rdma_rxe driver does not actually support the reliable datagram transport
> but contains two references to RD opcodes in driver code.
> This commit removes these references to RD transport opcodes which
> are never used.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c  | 3 +--
>  drivers/infiniband/sw/rxe/rxe_resp.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
