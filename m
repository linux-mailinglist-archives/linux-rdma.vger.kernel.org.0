Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076B1705BDA
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 02:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjEQALa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 May 2023 20:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjEQAL0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 May 2023 20:11:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665B459DA
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 17:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOuyxPPWWfgM+ArOh6T9KK3o5NAVMMcN5kr9o5oROCn47Dk57M20WAK8y9MEuyHlQQjCWmRieVu95qh/ybaaV6AYSdtkFyRHO/7TS2gzuJqtpfmdwMl16lbTvakfUJo5QClaGfQzUyjNdJoLUjxXLQV2114XDvPc+lDD2akTejzgMp0aFLBrGgXcEo79hjlRhHkKQHzlVE2JkMhYMEwNcoE/HXDGJuKSAyAhJNsQBWVwN4l749xbburWjNgBp0asZgBZKLbHmpwZit/g2cQClaWJRsctvp7BbaBZT5JqsuV6diT9eyTbdP7Nffq9rLWpPw/7VSrvPJk4ktA/fNG/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uexvIZDqW79enLZYJmmndgAbBURhOdqPTkMxAx9WAOU=;
 b=hUXOXOS6W6KwX6vkQGPyMcFfqDDGxsbVfAZCfr8CrO2GMaKqks6Ye3K6pI2zSDU9PNcGvSs+K94xhZvS7TZFwU6ULUJOa0bBdITDUfvlzbD3EaU8E3oKdBYD5gUHQy96q/5hvn2q0gzTvEO9OTXFck8IBEk7GwHU4oh+Srb3W05+e65i3OZsp45DzRatsDnjSkq+gUC9x1+tREzSv6hTieKWWvJWGKzzFVp8CaxpqpKSoqY6KPdmmxzm3wFdG2/p3FWCzS/XcDlVKCq9j57LdI299KKnciHZ7jrDWdPSCdZpa37J5CqHdBNqD3v26aQbD4A6jrMARvLzSG2RGguf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uexvIZDqW79enLZYJmmndgAbBURhOdqPTkMxAx9WAOU=;
 b=DGLuyb0mffia6Mj/FegIAaGiC/BcEvzzM/DYWKEysVT8ToAGKLNpKD/5ejTAbMRsdl9zoQ1VjlPsMSg914OcJNQLpFTnhFLND5H0ypc8cdhRW/7Ch7tj4oHLirRIuBJBHymhGOoRK83Am0QqwyxjxY9lB7Ro+y0Tl/j33GMWQS8g8TAbOSl6H5SWMsI1A/nVhtSJeatq4OCByeY+pt0R4CxOGzWKhufC7m5lKo0lH3sOHfOx6r2woL+/G3fd7C8VhH7GtaTokAst6o37jhtDyapeDosUo1qb1jqZDEwmdvNfmHFxs5eoVdxFPre6DrttGFFPI9FmkyzD8xGOTJGaiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 by CH2PR12MB4955.namprd12.prod.outlook.com (2603:10b6:610:68::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 00:11:21 +0000
Received: from MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::94b9:a372:438d:94a2]) by MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::94b9:a372:438d:94a2%7]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 00:11:20 +0000
Date:   Tue, 16 May 2023 21:11:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     dan.carpenter@linaro.org, leon@kernel.org, guoqing.jiang@linux.dev,
        zyjzyj2000@gmail.com, jhack@hpe.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix double free in rxe_qp.c
Message-ID: <ZGQbpzl0cGHMwGEX@nvidia.com>
References: <20230515201056.1591140-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515201056.1591140-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR22CA0023.namprd22.prod.outlook.com
 (2603:10b6:208:238::28) To MN0PR12MB5859.namprd12.prod.outlook.com
 (2603:10b6:208:37a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5859:EE_|CH2PR12MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 30387304-7585-449f-413f-08db566b3e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEB/RNOnZ8W6YtzODNYMK0e37rs/SYCO+yp1IOo0GtHK3Q6UK4E6QC2qtuTf9RY9plreHtGtmlN86Oax53AhLB9G9pzzipY08x+aDCyvBBB2QmU9NBXraVpCDJfZC9IUZ5OYKk37TTmZTUSXHkAm6WgFvJ0pSWpJv14ON9FUJUu3AA2DEJ+DwvrJjD9UpY+cNH6sPThhmm9vGp/UnVINgMzWoEK8GAReXgrN7qezeuVaACGEdtHlCH0avue+xcL8MoBMQ2XyjEnGWoizO3ctjgJwbcbuvenvQuQk3iMdbCVsU8/FBVRereiy5QuGT7cu5dIBEbHwNrJVz/NDh/CcrEuX33+mlD/5/tYKq4w3KoFd4u+1wsk30fYiJQ2M4FyH9/thgRnecOJpOzj8ORtasNKoirM87gcRAQX9XaG1NmGD3Oj+9hExG+/PBkTmtrerwUQjEo0KdiRo/amui+myOXwoV5qvLCWX180838k5j90ci3XfB9bV5fp6Rvu1j/nq2UE5FbgbBVpjJ2mTVahVCeCFXGof5bSajdIpCEr+8136u2H2lKGUEpKDRPUwKXwk3JoRQuoyv5wq1emkFFqY9iZx6gkt1m4/i/L6oeD+FLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5859.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(6916009)(4326008)(36756003)(2906002)(4744005)(8936002)(5660300002)(8676002)(41300700001)(86362001)(316002)(66476007)(66946007)(66556008)(478600001)(6486002)(26005)(6512007)(6506007)(83380400001)(966005)(186003)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f+0RF2C8WKQN8dV855Nxn52EZrLAMYJlLD2C7AVFpeW0/X0q65QR3UKoHnl3?=
 =?us-ascii?Q?cINniFYVcBIhRAjXxOOSiKeo4j1m5EOwIOo175sylok9cjS4EFbe1+SxBHjm?=
 =?us-ascii?Q?dhJ9Fl/iJGk13c8L/cfC3GTZekBaQBEF1FgdxE51LXcvu3lPVqaEyMl9s6jd?=
 =?us-ascii?Q?BL8Cp1O4HL0uaeLAtk0WBrORfCMF2csjY/Vw1RqWqV/qGozzr9llyQDmDHkU?=
 =?us-ascii?Q?LwzjKS/jDSGThW/5Y4eC/Ib+iNtfYcMC4WR8L6yCfknJZPlUVsQ9I0NSMkF+?=
 =?us-ascii?Q?wcdc1VCttatG8O86ExBqGiQ/8pxuOrjKbdkZUBT5s577JgcCz1gBGC3xATa/?=
 =?us-ascii?Q?EhCqgXqiAZONPLLwele5t9pSb5+rhjHyONhVVTAVnjkawLT6WUcd6mB/nVaQ?=
 =?us-ascii?Q?7ROOe4JKDVUgbyKH0/khtkxiPvgZsPX7dLLwSWpjLnXF3p3fY8Kl6TIBAvAY?=
 =?us-ascii?Q?rViGTmnYWLewevMGjcOlN6M8jbdt7dbeWcyfa/yR2g1TKjapqtCb/owV0MLe?=
 =?us-ascii?Q?kgi+EXewjqLlSLtLk5cJW6Awv3AxZHL8vFc/pr7d7NXp9uicTKh9oPU9lUUa?=
 =?us-ascii?Q?Hd24UQjbabac1VMYOmwpWIsGLmw3LxXR/eVESOdoE8bODNXvV56pJ9wFOuch?=
 =?us-ascii?Q?gmPzRJETO2ENxnbjxzO4CC5R/kWdtsdicDLv/iACCPy2uYgSNju4QXrXoxmz?=
 =?us-ascii?Q?YENBSugX7p2HU7vw8BqMQ0pf+cIL++B+Y7iPP0Dir4h1+RS3P/lw2uoJsaEA?=
 =?us-ascii?Q?k9zNwfUdjoeKUeEfSGmJLCpB37BL7O7Q2EUTE7vQ7aE5ou5jsmUpelGv3DWR?=
 =?us-ascii?Q?YyG+S7o5Is3xaKEC8wrMOgFcqMhhFkC7O1lQjY+VwbWWn7k52g8CVZTgNOyD?=
 =?us-ascii?Q?YgI5G3ioBQrAmrLcO/n64W3OZWQ9eHacBB+N1ho4QZJWHj1gL6KwOeSkAAYP?=
 =?us-ascii?Q?7aFaQGUcOd1rkI5jrWgKwBPNJw+zlwpzageYxEv7o8HfOu6t+4GnhTvizVR7?=
 =?us-ascii?Q?qpslR6Dns0BNaMmH6EmTFbcMJpRzhxEJt91mxuvcFPQsZNJ/FCWcPSJiTT9w?=
 =?us-ascii?Q?h0+MqgwoS/r1eDT0oPqaJOioauQYnKVQBVWuZ97pOrnuoTCaM0gzwEcJa89C?=
 =?us-ascii?Q?OTut65UQpEd5sucDu5EBNxYQnWIXKoS5xdBSX+NajzxgFnRtvGLI3v6Swc6l?=
 =?us-ascii?Q?10KomOQ7BTNWigPeJMwTraQQXuoWlVyIxp9bxjmlTZDrxligju/hlgLvQVwJ?=
 =?us-ascii?Q?WJ2YZGg6LJSQKYL/5iocTqC15YdQy8D1pMwNz4g0p+EBsELQz1X4pxiuHpMP?=
 =?us-ascii?Q?IxrNgf5biX+AB90xTPLZ09wHUfIHSQ3g3IQixifJWXdkbKKvNPJquI9zi6mh?=
 =?us-ascii?Q?PhQ+g8TgY80JUY8aoNwn+70bzEDoUdR83F02nMAoOkw3GCib0OaWoGeE0Jco?=
 =?us-ascii?Q?GHfkaC7p0mGQuWR6PYNhn1mbmhep/A1egbzAdxRXHNWkdyZKJRALLdwh+U6p?=
 =?us-ascii?Q?3w5I7Zkbp+TZEpnLkG7YUteG9eCOvfnRXeMAFfr745u7dAGKPE436B0NBrBe?=
 =?us-ascii?Q?9Gug6z69TbXdXGyfnKwRd5gOjECTw8Mdb00M+O2A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30387304-7585-449f-413f-08db566b3e0a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5859.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 00:11:20.6805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKZlEPKozRHQGesKhJPCK9xAlbnb++SJUpS40spCc7leDZgkdJc+Y5sxB2bNeDdB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4955
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

On Mon, May 15, 2023 at 03:10:57PM -0500, Bob Pearson wrote:
> A recent patch can cause a double spin_unlock_bh() in rxe_qp_to_attr()
> at line 715 in rxe_qp.c. This patch corrects that behavior.
> 
> A newer patch from Guoqing Jiang recommends replacing all spin_lock
> calls for qp->state_lock to spin_(un)lock_irqsave(restore)() since
> apparently the blktests test suite can call the kernel verbs APIs
> while in hard interrupt state. This patch needs to be applied first
> and Guoqing's patch modified to accommodate this small change.
> 
> Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-rdma/27773078-40ce-414f-8b97-781954da9f25@kili.mountain/
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
