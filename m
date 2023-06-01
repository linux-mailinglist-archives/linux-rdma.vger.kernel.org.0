Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BC171F0D8
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 19:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjFARdX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 13:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjFARdW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 13:33:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D646136
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 10:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6MHRnsloEsgTE82crLL7wvdCsZmNlE0QWQyuDXcn4fhlFL9N0G+Exxqo0FNVxnGKI9aXBFk3PjWCRwkh9Sh36QMxc8ypEVD8VNyyQGZzZNbkvLTI1nbzD/QA7GWlHiNl8qnnsSzJcdusT8Xt2N/K+C47Rmz2qX2f+rpA5hGMTCk24r+D+J5g6hOC1pBYD5zRHSiqbIu95ebFRZKLsj0a2UqbFDz110LLu2JmtZdWySPp23Mt1FtkSVkirSQm2nxQBS8rRHPuK3f4fDIAi0qWJUkpxK5VE27XTbNr8FKms9JsSbPPm1VTBC7GHz7q+mnTK9LCFgqM4Mcu2MJp1jXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyYiGMe6UmEeZm8Q3mVk3+d03a+92XuxKrufj/k5eUQ=;
 b=gtChLTKKiIzmZdBNM+YPkR9ZPSty6/aQ+WJEOanDVUfALxQgQBYJ9PdeCKWgYle2YUUMU01qK36/mjNutPFzbJwQqaF4b7+U03XXB2a4Q42JoOI6WquU6mcXJxi4Xrm+tm1hVwOJkml0zBdev0djya/95HOnPJp4DjCUWkhYjfkJIGI8zo1PoIZmL527AYVFKXTrEHBTRJG3zB9OH+wC2nOYyQdCrZRM+xFeNC5tgrU1owj1GHUH85E55LX4TLlUApkd8Em/jbFMsgUHV0dXup6122FPIC3bbz07tl9H824DI9QI1520EXCaB2D004VesVaptS4sJxCguB5juruP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyYiGMe6UmEeZm8Q3mVk3+d03a+92XuxKrufj/k5eUQ=;
 b=FWtUmJlme6+qy8tAONDwSJeW0oUmTB62LaZlhc6SnokKf9xFw99rEPUXvbXy+aO7Xq01AsZl5E8BCVoSMR1xE+dUdNVLd9K7VivBt8LfXG0SA5h2F6VVqkyRZs5nCWdQAJuL9mPRqcB/WrzkF6BLux/oCrturZnKQy8CqzUGrYs/yx/aoF6xThBvBmYNpcRyWQmAf7ZelQ5EmEJMTVn3rDXOzTlIBbIMz044+a6nllUxznNJbNHB/l9NOrx9ObZenFR5MDyQiZeosSnGVqky2v6m0qb7DnjmGySr0GvTjOnevRsozq7sWR3oweiKrJGuwbYusAoCsMry1J+PfXqDtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Thu, 1 Jun
 2023 17:33:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 17:33:18 +0000
Date:   Thu, 1 Jun 2023 14:33:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, jhack@hpe.com
Subject: Re: [PATCH for-next] RDMA/rxe: Fix packet length checks
Message-ID: <ZHjWW/O9d2bAET4g@nvidia.com>
References: <20230517172242.1806340-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517172242.1806340-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: b2fd9730-3696-4a1f-c490-08db62c64987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75Hdj2mWQxvNavY06rsBjs4p2Pe52k/pNB7kRizlzHGWo7kXc5joD+MmXAvuIKsU0Avty4PFUEQ7jAzFhmr0KJ2vH8IzUAS58wMM2QwtkNsothtnxbX3uRILEwLiuchMCAvrg3s5BZlXC5FyJWs6rtZ8cjBSwNMCAfj82t0JfIMjHvx2kL7QvCfRyBpmpQ76b+lhQ1eiqv6imyzM14le02O97FDdd8IrxKCLDN8SufZ4EfbYdEDayW7/ZEdVpXlc/CiZ9LF7dkwu32R2sT0n3wVyTnELVsNYM/qI90ueTFI7M/ul4TfIYEoZ0+G/Flugb19G3E2JDDUPANiKeBlkPmBNkDWtV13/utjMP+i4E3/bzaEC6QCote7RH19Vc4tVZYt9ItD46ei8B8qr3+ne9rGIpeJYHvKZwbtMvL82wUkuu7JFc7K69o1LSmOAFmk0znHsjPRdeWKbBVOEK4dYJtVKAsryJthTearJ4YcaG4N/ed8LKRmw1vxumqIJkg2RYmUWWBCFXIJQrWJLwmJsEc6S/4yv20nD8up0as/2UOo7wbl0Am8nI7KKiFCyMx54
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(2616005)(36756003)(83380400001)(6486002)(6666004)(6506007)(6512007)(186003)(26005)(4744005)(2906002)(316002)(41300700001)(5660300002)(86362001)(66946007)(4326008)(6916009)(66556008)(66476007)(8936002)(8676002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L2KDEOicZcYfA6NSGpTHndBn2oIC6slkZxNcNmJiEz67ayRobh7USGzEv//S?=
 =?us-ascii?Q?Ru2OTsm3UIW43xgMIb0RiBo8l6UCyayTxkugwMcwMUls1dLnhL5gDOUe/F7h?=
 =?us-ascii?Q?ATRUq9kV1a6uVP8dAjajKkmviOBq4T0fOHlXzqylji3+QFVhZ8sVFKRbZrsN?=
 =?us-ascii?Q?04cHRE3wFl80+91vDVos1gqM60OBLtO8BWUdXUFpcIjpP9a3B67wjUvhP756?=
 =?us-ascii?Q?CYgzaZrchqhUMm4GgoUPjrXRDNOVczLD/rOFQ+33eyTrNeoN5X2Dhm4tQUhj?=
 =?us-ascii?Q?323XKwaCv0oLFp4QFwuS2It89rRlt44eBAMYMMLEhN469P7jUAv2HN2CtiQ4?=
 =?us-ascii?Q?J+xV0OsjBwVWsnYjq4YhzcNWSPYdAV9WmLtnEaYlR1bslCC866BHfJKO0Z+/?=
 =?us-ascii?Q?/lFmbFGSBpAA6hO+rO8O+3ZV2r+UUqPHOh9ovrHu9bypGPE7iNbt7I3Ub1cH?=
 =?us-ascii?Q?TqNoPP9Z2zVUTwusEfvpZ4IDx5X7MSKdCUqLqiQaz87nzMSboDreAbXorgE6?=
 =?us-ascii?Q?W+UuNI9k/6fDz/iKvDYbZP2ZHEld0y51hlIQLzYonGffIpyWcgexYMEJu9qn?=
 =?us-ascii?Q?M67+k7djYOLWXCrWxRqsQJj3seByUSjEhHzWeN899AXd60ixLCS1NCyeL+rp?=
 =?us-ascii?Q?YH2kYa9sCgAvNuPpVojqdyuKUzn4MhK4ANui1ehEcw4WNamSXpGnmRDF0gBL?=
 =?us-ascii?Q?+w6Ni6aMXwEk8itL4gms3gMmc0g6IEh9BPOPA9N2O0vOgpfweG2m17ros63o?=
 =?us-ascii?Q?RvwulVJ80/wNDQ4dJI42pbHZXzEbaPezYNENA31pfiq9k8c6rLCl2YXF3PXl?=
 =?us-ascii?Q?7qbwar6w+i6w/Pw27Vtyfc3++wuEq7AHJ8CMS+Rer9eRGN/xGbWCip+bN2Fw?=
 =?us-ascii?Q?+veE598XvXOpR67GGXaCHerc2d/XyEsJ42wI5DYLjqEg9znrkhMyLng6vIZX?=
 =?us-ascii?Q?PNS+M8sfCP+R2rMI1+16and2M/KsHii13nZECgL7inFRGFgOy8GxhSL/eN3r?=
 =?us-ascii?Q?ahpOFsY/06ezNOzk73bIE4q/vQdfAHDe0ZcMjXvtDPX7MZFJo09O4J7GMDOF?=
 =?us-ascii?Q?HEhIZbxNc3Cl6NjWjag7aA7FCT65lKXodRGeHPhZCtA9vTLra9Wu64PHPtun?=
 =?us-ascii?Q?nsZuQQkrrNCCIwmbTq55fQnkS6MWWz6n3rrnsRbgXoBGCAc8YBQ9g/Ox46Wb?=
 =?us-ascii?Q?Od50Fo0M2T1oqGdS70rS5odlYa06GKvrFmW9H4iSJShZkuOSXBlrXEU/2+eh?=
 =?us-ascii?Q?J8oxVZWKBeSlAZ4bBM2IF6yT/9VexUT2x1pBgNRxSqNF+IytR++Hd7vpCIFp?=
 =?us-ascii?Q?XHh8ZIhPP3yTm41hs1FEuPb+5Ktgw6+4KKTu6gz4HYYOP687dCux6yDVARl4?=
 =?us-ascii?Q?bWrirBqPcCmW5vnmRDc8KuhMtyv0IWFCTndlKV/5q03H0G2LdGL8bwwGanf0?=
 =?us-ascii?Q?EeWGIK1K7YjSgtBl218yfMm6EFWoz277aDHwQAbdST7A+NFZPudUlo8Dl/Fh?=
 =?us-ascii?Q?8cCtb0IRa8tIP/npzE1NccfpaL0au5bdBWGcnmD1euSyj4+dy3yb0QumAO8E?=
 =?us-ascii?Q?1vzzWwyqecuB6VCiXZEvvpKz0W6R55Kr/PfFY2UX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fd9730-3696-4a1f-c490-08db62c64987
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:33:18.1870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTTwPyVPvUsTFlsQ8ct2ZJy8rqFpZwSPAYfzdUXMrpdwWf/e+2+BnR1Ct8gyJ5zC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 17, 2023 at 12:22:42PM -0500, Bob Pearson wrote:
> In rxe_net.c a received packet, from udp or loopback, is passed
> to rxe_rcv() in rxe_recv.c as a udp packet. I.e. skb->data is
> pointing at the udp header. But rxe_rcv() makes length checks
> to verify the packet is long enough to hold the roce headers as
> if it were a roce packet. I.e. skb->data pointing at the bth
> header. A runt packet would appear to have 8 more bytes than it
> actually does which may lead to incorrect behavior.
> 
> This patch calls skb_pull() to adjust the skb to point at the
> bth header before calling rxe_rcv() which fixes this error.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied to for-rc, thanks

Jason
