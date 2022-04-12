Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95414FE391
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 16:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356487AbiDLOTU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 10:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbiDLOTT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 10:19:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C562E0AC
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs7t4IWrBYCWZcxllj6qDtITyojIFhLl3aSw/zB855gQSuDExHqv1fSRw8STkDzrHkwbwCpTI1fQbZOEObDaf5wwRY31CmJEIHp2GHbZHJqDV7UVg2fjL7UPwIEH0TbsiEqFbmsIHmDT5HyKzMhLlv48DipYCIjaCRB6mn8l5ZXdyNNmhYVqcDmeViccMpoIx4E98otpSWotLh4Q40S8bUsQPJT2VJjzy6/BxCyHnKetlSDeCmPQx6JsrTF3pK69YXTcL8tS4gd0ARnDIEDPNMbsKBhvAyaeDq0Z3daE6rx4BZhggP8dAnVKV2CnqaBi3WdLxfkKyLiZeUgCqlYYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjK1H4jyq/NHYVvd5D6XMyTswnJYSPpPJT6tujwpsew=;
 b=GORTB/JYNUvKUTBChrBUoNHqUk0IieNMsQSjjodyWY5zRfehjXx7ts4Xyj5t1Nrlt+6CgeER3k/UipyaHgONzd6eKkPT8tiXX7LpxELDp/sdO1bOT8TqhvNzJQGFg1pAc3PhhK+TG5h+5wTHXnYgodRufH+THEOz5Q4J80WetwA9stXGVa2ubA4D4DMhMxE+T5rRtUqgSjw92aNS0RIqyJKHhYBHnRYxrD5/ridbhww3nTxPYM12bjn/FpnFHj0/Xq0n4mATr+LKvwbtZ4QK2sQRzT+puKaaa9lkiOw8HA6xfpFuq6cILG8vRt7FDKPzclBQmcQN5RRIcXVfYTtS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjK1H4jyq/NHYVvd5D6XMyTswnJYSPpPJT6tujwpsew=;
 b=mXIPVCV9Rqyn8IOdkrCJuZC/F5FuFBrwwGStENIv5j0wcH6Tk0crbioM02Q/ph8RpUpwKk7SO+JVb4qsfA1iPNtnYpKUn7/MNrrspG4flUi3IdUuGZMBQXrmcjrU675E7XW9n+wLseaWfWxG0NkASoJWRbLq7Spz82buxK79xFuaQAcc3VOiUnMS2SyYMcavihHAXDZh5Mq9E86qJDZPKrp+EwJh+J4cOm2Fy2EMx9HHtHRJlw+59AouA8UD2SEBXRaR6UNkV4nd9UIZJXsHzU9B+VDXJcJYiAZIflSnTNn30roa7xd4phyxlTdzRGApmOdaZ74mdNB/brvVnz0Hew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by BN7PR12MB2611.namprd12.prod.outlook.com (2603:10b6:408:27::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 14:17:00 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c911:71b5:78e6:3a38]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c911:71b5:78e6:3a38%8]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 14:17:00 +0000
Date:   Tue, 12 Apr 2022 11:16:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     rpearsonhpe@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/rxe: Generate a completion for
 unsupported/invalid opcode
Message-ID: <20220412141659.GA206434@nvidia.com>
References: <20220410113513.27537-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410113513.27537-1-yangx.jy@fujitsu.com>
X-ClientProxiedBy: MN2PR20CA0051.namprd20.prod.outlook.com
 (2603:10b6:208:235::20) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c14289c1-310b-4df1-e2d0-08da1c8f1c2a
X-MS-TrafficTypeDiagnostic: BN7PR12MB2611:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2611255F2D13DCA45410B5DEC2ED9@BN7PR12MB2611.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /RL5BfZ0lMwbiPJNsnblRHmAFifxpYZ5WsYwhk8XJWyKZukP1A543m/KqWnpRRpc6ZVHMvRAiPqD6IiPwFLBN6OOrOef5N0xFcDc6vb8+rt8fy1t7GyNC4IlghgFFbVAoJXH78NC2YmDCnHhD7Lh+KWTKp0XpoFhkigpbCxhiZwFNCcSK6N0VQdp7o7RLEoWDm1BehZBPZdi1CdPKIK0NVZDu9SzSHwrpWwp/0nH17O87B9Q9e7woZKs3Cs45d1TtIZXjKT0rNv9Yg45+4iOyOcfvPUbcXEayrpQoodb4M/BbpGnENNSOXS77rIYUN6Ht8dxscN0lj3u2YSAGU0y0NM0eEr5GyGqH2xgxaGxmUa4kAOXK1aQWuEhhsgQy44Gl5kf/0WE466bSzEb8/gFG3e4+AJE7fl5Wpw5TsYR+H7eSVJ670pxPJKxCRMFJrg42ueIKwusWwOLmZKHi7yWw4xPAEKG3cP2EfW9dvz2x3XhE8iNvUoukGmLs+cCQKOYPZYpV+5QVojTFjrBcfzTOA1qBRRV9eL5+7Du+rWtyUe6CQVrKkYS/mTOKzhZ9+KfZYhbJ4FnoHSgFmMWEL81hgAifWfyCZYE0kWsfnEuVCpTwbUcB5Ea4hJineu/h6p3ogV+Qc5HtyrWajZwxJFVRuyFbQCe0Levu+9DSjyWzLpZ04ei3HGVwR2ZDdiM9+qqftM0AUPiKGyaLTP3gtBMgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(26005)(186003)(83380400001)(86362001)(8936002)(66946007)(36756003)(66476007)(4326008)(66556008)(8676002)(2616005)(4744005)(1076003)(38100700002)(6486002)(5660300002)(6512007)(508600001)(33656002)(316002)(6916009)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bOZbMdf7YYFRG1gKJXjr8EyXEFjkpmMWgh8w002Pgn4Or7KtuOGuKaDP5MUS?=
 =?us-ascii?Q?zim/+oAnwG3VcKzmUyMZ0IgcEow4iPerlel+28ZkjUOYoVJabwVt66zt0J7y?=
 =?us-ascii?Q?Fb9vDJYfqzIZInYiXZpAd34yTPn2bvrYBuX0u+OHDr4MOCQYTb7cWv6czLJf?=
 =?us-ascii?Q?kyxD23RRLaTMc39mUoCzg5r+rPezeel8GmdgQ9+BNuYfKJ8zf3p5h7bShoud?=
 =?us-ascii?Q?TQGP6Yu1aWT3OGs40UtnIyCHdHuD6zQsdEHfmZ1yZVjF9AtBzuFE65LXnYQ2?=
 =?us-ascii?Q?UVECn7XYZnsfF5guFpBOc0EOvRPPIODb0shbzWsaRm4/SBTNmJbGZsZ4vYDR?=
 =?us-ascii?Q?yM/V6u1nLvu3/hXSr3J/ZWQAjv9QY82NKu4Mgf/orbKTIiMlXh+tcZfyahMB?=
 =?us-ascii?Q?C5NTfK/+Ur9bESnX2P4dSzgvPWlAL5oASlf0piyTw7+5u6JAjEmvNDyvOxYR?=
 =?us-ascii?Q?EL8gd5U1uOM/MXSJHKXPRkv6X5FYuxIK9Np07r/UKuuxuQz4YnFJsw3+sUSK?=
 =?us-ascii?Q?JVvUWJptAEkV6n2nlmGA6otqTipj2ifcyAY/vO3SNPV+InFwR8RcC3+DdFxS?=
 =?us-ascii?Q?456xaFzntNjGHwjEj2vxvyQO0GYbr61z0XmcsDLvfjH6I/cShP00baV7JmpU?=
 =?us-ascii?Q?iZfipVaS/JgVuwOSQpsIJ0jwtFaMEogN3daAUBAgCSHtYL4uVKt06jq05cyk?=
 =?us-ascii?Q?SG+VHSbnoGSAc26x3jL3ez3jz2gXAXZUSEsoOAcfwZ/tdcWU+upB03vXUwH1?=
 =?us-ascii?Q?StZP+IpXF4WnPkVgOyQjVcMUuTEFnebjS+0+shklOzwUpXrwsZoUPPKYSf5F?=
 =?us-ascii?Q?AIW1vbENqFz/F4qDojR1OlPOV2pgv82LSlxA5dKeVdLLbTPkDqhl4CCczn8Z?=
 =?us-ascii?Q?QVeiJKWp4lhAQgmZ/0/LISgo4W/+BUiyuvex+laifue3OH5dAhDhLrsfsvYk?=
 =?us-ascii?Q?TEaXBe8VpCOyx4Q+O/5C11ocSgStxFnC4G4lpDY6UDTPvJhB1jVSLhUuan++?=
 =?us-ascii?Q?ZhcThOicIm+p6a3mA2RKIcMXfzWJqApCzje0mEfOWWZsOU2fT+9620u/DuoI?=
 =?us-ascii?Q?zpn4IzTclXfhSAYLXg+yZE/SZk49bZ5xzlQlZ3ynj+sAU2LPmLg8QFsfZFzy?=
 =?us-ascii?Q?cHVE6kSk3YPpZl1z3IRvA6Yk11Xtdhmm0ZBcdJuO8IHfDlyNe9ZhGlB5klzL?=
 =?us-ascii?Q?5JDeYD6H+AEUMHQa2qSNpyEeXAK7Z/8rE9PvKJH9E1PNJyi77zMGax8zmxC2?=
 =?us-ascii?Q?Ggy6Eroul8Xkz7ehZoeje1yZXP70zZbbX3HwcegaisdngQS5wlZk9OY116nG?=
 =?us-ascii?Q?YC9jJ8fNwZ9Z7HXbXB2GCqs12tLuJrXqU7F3ZvLFMciqa6nh4smmJ4D39G3t?=
 =?us-ascii?Q?kWj71kYZQynyXEoRMFxCUctMmr+VSvdmTPNpjAfKCRZZilk6O1iKj1AtNs1a?=
 =?us-ascii?Q?SfM7N7qUq8EIAwreU64R24tktHLCeMy5bZ1uqMSLvsvU4/Ym97vEpvCwO0on?=
 =?us-ascii?Q?tgTtIkVTvzPdv5ZYOAijJ0BB3wEgV0XvB5gwhWRMe5I+bEFXq7LjH4lpuxjP?=
 =?us-ascii?Q?1pp449++yRx4V7wKJYi0EOsff84VqDa0f46tbWrVgXPmATZI+dg/CC+y0Woe?=
 =?us-ascii?Q?COKrFBXb+TBvseCpiKFHzMN76XFV1zT0W8IIsXoYrU4W7IaAcTokAOs6pQ2b?=
 =?us-ascii?Q?YD9bJCIs0ABMWbbMbCxwy8qeq/wiU1T8Gyqrgk8yfDehetc1FgvXOUE+aTAd?=
 =?us-ascii?Q?04dO5V4E7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14289c1-310b-4df1-e2d0-08da1c8f1c2a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 14:17:00.7163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMjWIX0q0NebMO/qq4mZhYCnS2/oC+wq96DTYeP4KWXhojOFR6Y7xKghMpsrC4gX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2611
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 10, 2022 at 07:35:13PM +0800, Xiao Yang wrote:
> Current rxe_requester() doesn't generate a completion when processing an
> unsupported/invalid opcode. If rxe driver doesn't support a new opcode
> (e.g. RDMA Atomic Write) and RDMA library supports it, an application
> using the new opcode can reproduce this issue. Fix the issue by calling
> "goto err;".
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>  drivers/infiniband/sw/rxe/rxe_req.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
