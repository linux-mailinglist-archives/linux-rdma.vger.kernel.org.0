Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C402260D19C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 18:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiJYQ1K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiJYQ1H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 12:27:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FD5169CD0
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 09:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neUjhw0wJEOh06n5puQ1io+lZFGKuyuAS7YF67SAlyzecYPZ/ZE7XvTZRyyToYKwF5oRAy01jkv2fHBQrIp1v9rWVWqy9v6E+wdcXLU4eFHMQfb/xUSqUxulxyBZ0xeXJlBbYaBAx/X+lT+pg+H4U0LnH+MsG87qPw/lki1SEj9jhT8ty/FMW6s82MRESqhANkoYolIh59IC/bibiyZY0vFPaQX2a0xcl2jksn1154dEJuG7/Y3Za2S6BIyt8x1ugR2X1zs/4FJROuLw6MSx+6qMmaE5EhAKWA6Vk3eiE8WVOTNz9M5SkU3YtRh3YRiOo2q578MejwSHbr3FeEDt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DKOtRONHkRK6ekp9gmXODI5cl9HzDKXOk93k3DWbv0=;
 b=D3nRRL5R28QplPYI1zTNhJ3X/z6TbL5iSixVlEqGUE1My5GfgAqydmIyyFUWL8DL1wEVJkDUubuPwAMdpt12OyvUNjG2qTcP55gQ/0KgurNYNNlDWsblZrUpxoJYM2y/kSnW03lur9kMj9Il9QEZzeO7XPYHQ5hn948tKDXwZyQnhAC3aa9ITXoN+bFldI7Ucs0pHanr7TQbHUg0eldoxZyqJ6fFECtNCtu52SmPp6Py8mGyJPmTD0F735EtnxROe7P76lLI69JxiRLhvp4IEhDQHR24wuB5m+XcBD219dvwFxZ7lQCa6Gdw6kMlR2J1rn9JB6cfU4IdQftwJltC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DKOtRONHkRK6ekp9gmXODI5cl9HzDKXOk93k3DWbv0=;
 b=bUjijagvDMQtzR899n6dNkYC1ZebVjuNl5UZTEaP0Bo6IMzSsAmhgnAX3oxPjq0hwX9B/5SYRNBCG5aEycQN5/GSwh9BWDYI4eWjZyZD3dFp2c1F1g2mtMnAdyvqKrGCnUzg9zwl/cKWjptzB75n0esVT8Z8mWA1FMDFsbzzWPbNr6Al+2f4k66ufxkXoffWLLwYgWLyGdKNdmZYl8gVxcdFx/gMow+oobjSZ1WZ8KgK1y/qefm+lNFKnk1oyZFhr3fT94QBC+Y+nslLyT5NpdJ9kbvrsovkh2JoJRdir7pKuhZr/7svgSEKwIEEBQTy5eTbYadTXxEwfMbUjc7VrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Tue, 25 Oct
 2022 16:27:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 16:27:04 +0000
Date:   Tue, 25 Oct 2022 13:27:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "haris.phnx@gmail.com" <haris.phnx@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v2 18/18] RDMA/rxe: Add parameters to control
 task type
Message-ID: <Y1gOV/RQH1o5LIGf@nvidia.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
 <20221021200118.2163-19-rpearsonhpe@gmail.com>
 <TYCPR01MB845563BB1E56CFB317D4409BE5319@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <Y1fF7UcaIcwJegvH@nvidia.com>
 <d38b66a8-220e-811b-1d90-d0fa4598c695@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d38b66a8-220e-811b-1d90-d0fa4598c695@gmail.com>
X-ClientProxiedBy: BL0PR0102CA0013.prod.exchangelabs.com
 (2603:10b6:207:18::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 708f8819-1a93-49b0-0a89-08dab6a5c056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8AGccSrus9woUZe8xIeKCkX+DJejZ7xCt8t4DxJkEmIay0fzZrukZNGc9kWyFi/9n5ij76Wzs8vs9QtlMEOZXDmvgmy+KxKr35peVdAXTTBqRs5So6zgkjpvrUV1SdzKdz2t5OSwUdlKDHZz1ElU/UBn75FzOWMB/IJOZyIDh5ErRp1xKofCDC9Pk1ZUuBI5BIzixPJKBINv6bpaFUWm3Gx5bzDeNUyuSKwIAlbYsJwgOwSbACHzoxEBT4pKkxeceQouBzCkvzheSKfkUd8vqdYnr0zqdmjudl/+psr/ow4DgYXSz1do/82xGmLGfWGoDb9LUPh/GWIfGWx/TkulSxW+WIQvCGb2e2qp5YAkGhaxD/IOlpqeCVQ7spoaU6AhNm+Ej55o6q6ck0qXaCw9+u3U9vfRbUYRsBvevW7urBRzOFMMYmdwyuKmbOQ3UMKjSdzO/pp2EP59ay6IEznvtxCUWfHZKVTeaWCGC8aZUXVRVH4o6GhnYB6T/SHsA4otXvsjDUTV9+hGsTD/kQ8oXcmienyKzkXozd8rurrA86kXafX2aRHSA+Uvyzfj2lZDNdh96idWzKosFnLXCM9WTCSCo9zfIZvcQj+iR68x1r9NDv+CYuF7RpITSHYEUirW3kazDhPNBlzidFEui5F55i/B9rGej7EvXNlnnaM1ASSlPsYT9pktKQxsW2uwaQQNP4myV5L288T50V6gU4TaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199015)(41300700001)(8676002)(38100700002)(316002)(6916009)(54906003)(4326008)(8936002)(66556008)(66946007)(5660300002)(66476007)(478600001)(2616005)(6512007)(26005)(53546011)(6506007)(186003)(83380400001)(86362001)(6486002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5uO41MXpqUoT9ObdxESNF9WFJzkUkqT16rgdn4w5FRm9SfPLLnQmyYFKJd6d?=
 =?us-ascii?Q?zexe1yXj/AYKARKzbMF4xMWtxXjD5V26QvnRfbe2XbZijStKL1P9xYiKM8j5?=
 =?us-ascii?Q?ZxhbCZKiQ3ZABoTO0D01BlTOJV7a/hLC2/ehLtGlQVlQzePl3ySm32I21KnU?=
 =?us-ascii?Q?f4a8haGtVtPcwPh3H8sGfShhVRxYZvNaYfddAswRVZrBTq1PW5h57N6bbVr5?=
 =?us-ascii?Q?jmQ6JlLzDZBlT4D9Rj4DOXdTQ6JEWDejqd2QC/x/K2juyX67vPzKSt8gaEfZ?=
 =?us-ascii?Q?HtCJiIm4I+mVW7MZM6OVPei9TUDtcF2hp2et6g+mVglMKto8HcGnb+/QFzAn?=
 =?us-ascii?Q?G0ZCjln+AxEWuksLpisQgH9p32+zBs98iN98xPjTGZDuLeu12eXRacNuFtCX?=
 =?us-ascii?Q?QhBTQIpmw/W/gwRj4zd43BTh3M4+roBcXZLo1GWTjzQ9XMMl2LaIa1C/sNTO?=
 =?us-ascii?Q?5MAw+dK35bZ20fBPUsPj7nyyDZRGKMJduidBFgkuVIVdTrs5Gyzff8N3s+In?=
 =?us-ascii?Q?ftgtXyYjmU0SjKiG5oJCsh2o+Xx+ehqNvbq1Vaq4SXVAGCgx7bNXdmHAHCqv?=
 =?us-ascii?Q?f3K3yE77Qr9zrYHnSOO5yEH0ccHBnr9UUndrgCA/VxWRhcbsEO7wy0UOx76e?=
 =?us-ascii?Q?W2kyzGAqemI6lulddrm4Q5YHHLLVowNCqMXB2aMjBaI8FfSXJtTHw0CN69tF?=
 =?us-ascii?Q?m6fYR4cc5EtODqyCpIez0KNUZW61ew8mmHcvn4FIi2kBidCb2TJOKKEq8ifo?=
 =?us-ascii?Q?RH4gIQsBy2WIdOdhIhDhGOHtiayDE8b5mx/vVy2AMqhaiS4AiGVspCQV36EJ?=
 =?us-ascii?Q?tCUSfPTIytlZh/RyK8osoCF20JT/3AV8YdkL52Pvgw0PHtqh+JUWrv0PdU0m?=
 =?us-ascii?Q?K4zeyFksD2kTSCq/MYeJIAYuhBS316CTM6dSjvzlRXmKHOi8zteN7cxFYSi0?=
 =?us-ascii?Q?iN7NuOksNAcpsZ0a+3t8enpMKn+P8kk8Clc7Wp8JE4YyKrU0dP9xEpA7oHJ0?=
 =?us-ascii?Q?Uzkiu7lQMprAQ6cigPmrmX98rvOBeIFWRBQ5yzHav0TOILQcBQtrYtcNNhal?=
 =?us-ascii?Q?XU833iN1+lrEclTIBlZHlmUe28zjpn3ypg62QekBIU3eI4Kh1pK6bQQvQU+1?=
 =?us-ascii?Q?heXuoaCLbXwtgEK0dYR3FfPlOkTR3bhy6prC8oybAPYOMipWOhRm6ZWpjHnT?=
 =?us-ascii?Q?AQ2YuTogP+Gxii//HC+YOgIpM14iPsYHQWmtuUnXN2X0sTZA0ldriYjvVJiD?=
 =?us-ascii?Q?6ldLCLQZ9GZcVjlTtV9I39t4BfVF98hBGJCig5FqxBV76n/NbyozEucBwOzd?=
 =?us-ascii?Q?hu3Lc6WZSHsLzAjvYy3lAGJ66Kue3KUdQbzFNQGXwxutdsoJoPi6fNDsKmy+?=
 =?us-ascii?Q?tg6t+TfwsWOxy9SDlmvXXeLhJNGRCU6I81zvrcGIqZ+jL2JWOW3FLrHv4Ikh?=
 =?us-ascii?Q?spfCNuNZF85rudGihZ7LUq9YZ3STkfx+GyePiwFs4HaYMcCH/4lMVA12SvPY?=
 =?us-ascii?Q?QqcexgxncxOOY4/clGLCFNdcadzrlGJp+GCVP3s4oMYsocZ5NQJYAKhrElke?=
 =?us-ascii?Q?H9DAiAzvi0BFAmcTIEY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708f8819-1a93-49b0-0a89-08dab6a5c056
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 16:27:04.0163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynlLY2rLT+Kh0x7+EcTc2G0UPlWqttVgVeYdUE/uRtwY5tKSTJJ5ItENJrnGFpmr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 25, 2022 at 09:31:25AM -0500, Bob Pearson wrote:
> On 10/25/22 06:18, Jason Gunthorpe wrote:
> > On Tue, Oct 25, 2022 at 09:35:01AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> >> On Sat, Oct 22, 2022 5:01 AM Bob Pearson:
> >>>
> >>> Add modparams to control the task types for req, comp, and resp
> >>> tasks.
> >>>
> >>> It is expected that the work queue version will take the place of
> >>> the tasklet version once this patch series is accepted and moved
> >>> upstream. However, for now it is convenient to keep the option of
> >>> easily switching between the versions to help benchmarking and
> >>> debugging.
> >>>
> >>> Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
> >>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >>> ---
> >>>  drivers/infiniband/sw/rxe/rxe_qp.c   | 6 +++---
> >>>  drivers/infiniband/sw/rxe/rxe_task.c | 8 ++++++++
> >>>  drivers/infiniband/sw/rxe/rxe_task.h | 4 ++++
> >>>  3 files changed, 15 insertions(+), 3 deletions(-)
> >>
> >> <...>
> >>
> >>> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> >>> index 9b8c9d28ee46..4568c4a05e85 100644
> >>> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> >>> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> >>> @@ -6,6 +6,14 @@
> >>>
> >>>  #include "rxe.h"
> >>>
> >>> +int rxe_req_task_type = RXE_TASK_TYPE_TASKLET;
> >>> +int rxe_comp_task_type = RXE_TASK_TYPE_TASKLET;
> >>> +int rxe_resp_task_type = RXE_TASK_TYPE_TASKLET;
> >>
> >> As the tasklet version is to be eliminated in near future, why
> >> don't we make the workqueue version default now?
> > 
> > Why don't we just get rid of the tasklet version right away?
> > 
> > Jason
> 
> What time zone are you in? I thought you were out west.
> 
> There are several users out there who use rxe as a dev tool for other subsystems.
> I don't want to make a big change that they can't control. By letting them decide
> if and when to move that is avoided. I could back out the modparam and just let
> people recompile but I'd end up putting it back in for our use because it is easier.

As long as it is functionally the same I'm not worried about
this. Small performance variations are not going to effect dev work.

> No matter what we decide to do here, there is a question I have about how to
> surface tuning parameters to users. Not everyone can just recompile to make changes.
> What is the preferred way to do this?

I don't know that we have much in this area pre-existing. Most of the
devices do not seem to have tuning?

sysfs and rdma netlink are the usual answers, but I don't know about
exposing rxe specific tunables in netlink..

Jason
