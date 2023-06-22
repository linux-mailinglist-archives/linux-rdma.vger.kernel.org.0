Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFC273A484
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jun 2023 17:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjFVPNc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jun 2023 11:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjFVPNZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jun 2023 11:13:25 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24C1E4B
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jun 2023 08:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsQfsmVWOYHmTPZ9dbJ0pLMbLfE4N77G6ybTTPzof9qkwL/uhmWkXI9igOVQb678ScyiCu6R5afiykNHhYOObI0Oqr7jNgsiJDb1ZFsPGovJFifc42RLpAxlH2K5XKVx6DBFDZif5ukqyubvZ6K6oqKqDPdNsHTJbf2JgOPow9CHCAPcpKVtNUj9+tC/TdAD3ovh5dZf3mGNS5gltvX6aE31vY7IV/7wCIBxZUBrm7g8sly3josJdzjEahAbySSuMn8iLi/PKJb+4SzdBJMF5tbinRS0tFrSb9JO+yKTDN106LiGywOUVxpsem6hVdRJI6eUZpMBPR/M2CQTl2NRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24hdMaPqD52/+XW1tUaGhcGcQ/gg0XqIhEw7W7DL/2w=;
 b=IHajc9n3tem3/cIZLA5fL8TbRf8XqAp6lpB63QnV5ScTxz9lXTt7QPAzTtTIgYJRC+L084ZK/toPoMvy7UxInuFk8yF1sjy2Gaeez10yN6ao5ExJpRC7I32h1ni9E660qfzsIaMT278b6SHHBBlF3gCn8OcXylyHIVDJY0p0iEeW8IcDSnjkyl829736SJQMPPh5oPvEBQ+AD35RjoTbWTSOOjfcwwkmU0HrEtXZ4UwQRkpmjcHx2v7ou0tTechlKx0cY51Q0Dsni05yvylBp5hLDeY94+H/cjCk0Fv6MCkc6vRkYWCaB6045sz82QEL+mNdU3cYX0aywjh6pnBNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24hdMaPqD52/+XW1tUaGhcGcQ/gg0XqIhEw7W7DL/2w=;
 b=FP6my6uk8LScMUz9j9eEUcGi2f3dXpNPvp0ndp5ef5Pdhx9lkSGefUv9TZLIipMRT7jxh5RbizIywpHK2EtENLGN5pvfoN+6N66qKcVlgZdK32tvkkjNwvZgigLvjej/wVYaGXykykYC04R+gNj+WNsEBlCiqzhK8oSoaSSHc5C3cFNKDpQ/E7P3KshFWP7zzp9YLMPN2hYfNol96eoJoXRXGZKOrReKESvNFbtTmngqhjahSyFxrXSiZ7duVDI2q5+OJACFvJ6yLg/SfFRKDGMSglrt+tk2lKU7D5yCykTWl0GTDwi1mJ12TlEdQ2g6PuP8fsx0Wfgs7Y0A4a9ZAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 15:13:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 15:13:09 +0000
Date:   Thu, 22 Jun 2023 12:13:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever <cel@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        tom@talpey.com, BMT@zurich.ibm.com
Subject: Re: [PATCH v3 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
Message-ID: <ZJRlATrJxBtpMb5L@nvidia.com>
References: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
 <168675125998.2279.7297073638926155456.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168675125998.2279.7297073638926155456.stgit@manet.1015granger.net>
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 962e1060-c4a8-44a9-254f-08db73332ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XrQ+TYT69wpt0mccJFMEhydEIaBA5bXp5iRVvcS2SVXBCdkROWT7cLQ4L9oTHGc4Adf6VbEGBoVOZ3e9tqKdrEqcZ7ewqsKsucFqaUsV9HzRit1UbNSmRQm9cLGit5W6wn083F2GFfOSqIdL+yrg22ehvDz96xU0EF8G0duSXb80QhXoZWobk6ivwHKKk0Arg+Dq4vU6JdyWFvp31h50zR42O0qf1ZQtvXVwKKX/59cEHFw2Z3v6jcg8zq5WjyFRHiOJnK4TTteIcXXDwYNsmNJL4+ShdjY37En5u0KMduLxxBGelBt49ARt0pLTVOxE+fcKcGsbXT5WSEk7KyU/bzESGIwmd9wnCKHIgOeioCMySg15YqRR0uQX/iPO2yE3LNVfKAyNyzJ7jZ301DHsp2FwIv5/UsUKvfUFNckduVrfY7k7kftq1JygnfpqKsw/XwuUOQaJWX8vHevQsWLB7fbM3Xu15BNFlNZ7oB3ieTS863ZDMXKgMVNhHm0+3NHWbyoI2KdRzo+s6IjVLTIZ0HW0tt0ZPcrl1+ZdtVLJELQW5/2mCx2yNjdnIgZ+Y5zJf6ONy2wNDWgHaduOHGLMeYOG19JXb/LEl7jVHoibOb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(6512007)(4326008)(6666004)(26005)(186003)(36756003)(2906002)(86362001)(2616005)(316002)(8936002)(66946007)(6916009)(66476007)(66556008)(5660300002)(478600001)(6486002)(6506007)(83380400001)(41300700001)(8676002)(38100700002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3c+DorQ3FH/sUo7Pmu/OenpRC15Adz448a0OzK/bvc9mWYyLGhHuXnlP3rA+?=
 =?us-ascii?Q?gDS1bxyT1Kj7lP544oEJwWl6UnZ9PfaAMaPKELyZvZDaRYfTDEOhLwyHPxiV?=
 =?us-ascii?Q?8ozsd1JJsZgi2UZGywOMhIFBjVnlbuCSNRkf4/EWiTkv/Fc5djnz3NJRnMEj?=
 =?us-ascii?Q?GziozAqQvPr20JyJBU5UTYIwnhAM0DP2TwLMNZtdS0SPnZTxErH9AUZ96JS2?=
 =?us-ascii?Q?XSLgnVO3AADJ/BAJprQ/651VvglN30xmv4kPaENlIa4jSPrPAFAaQaPw4T1J?=
 =?us-ascii?Q?vrn0zLSRdnVEk6oOaJEg6BowRAJ7A7Pg02ADpq6uD4/UE3W4Ew1+RlRkaJMK?=
 =?us-ascii?Q?Z+fElt1S5c7a2ArO19Ytpzj/5i9IlZ6OdGl4AJqQGkwyNzKTVlQFZEkOLtSx?=
 =?us-ascii?Q?aA692YpNWlW4FqwgyVn8W7qYl7wIXLkSP+TFbotJAGcGSj9t28bcTThUY92B?=
 =?us-ascii?Q?+FK/0BfOEHfYtwWLMRt4Li1rrkPE6dPHIJ03JN5ie0u5Btk5Bg4Im/3PiVcR?=
 =?us-ascii?Q?RBDoX9tsmpTivWwy9Ol3x9CdKNltABU+/O7IPtK2MI/ZZKhswL+rYuR+YwXa?=
 =?us-ascii?Q?uEBmKWUcqN8ZvlsyyZG73PseykAl2G/CkP1fkmDdrqvfvKxYBhbWwf9YK13D?=
 =?us-ascii?Q?cGmjl3L5qBzRtOEv3Jygpo8ffQrXjoE5wgMZPyli9BhcyIbsBdiaRQYgP8WZ?=
 =?us-ascii?Q?G0ohpfwhOr15Afa63Hd/wfCXN5NI2LRoBgKKXHNGxQFUoEN2vvsm/QlXsIpC?=
 =?us-ascii?Q?TVzFsxo2IE//DzkBGzjXpwY4ezF1ew8k/Tvpgq0IEqW3Bt6HrLoNZ0Wo7V4U?=
 =?us-ascii?Q?UX/YckPDasZvrnyzqBNG26f2yYrs+L+mLMkotkkMJxX/STbjoKn98FOCJaBQ?=
 =?us-ascii?Q?JTVtc5tLOoehDFlJCtphGeu/84idJKIwLu06tq9TBSZIt485EBVL+V7WVyac?=
 =?us-ascii?Q?rqzDMw7sz81yS27CU/MuB1uo+OyMHRyrmu31gPdiOM/SGYgWaatl3D16DZyf?=
 =?us-ascii?Q?BWm4Ow680Ag/bdNssIUFq3VdM5teuXpE/+sFMwQ70gy/VuNMkRyHXrpCXKIe?=
 =?us-ascii?Q?HEZfrGp/R7wqcmVwJ2LVu6R3KI5YrVjBXP5o5kn+QJUCG8tWuhoUgdKQHGRB?=
 =?us-ascii?Q?Do8s9K+Xdmgh1IzJHXo9ovSUol+zMnuPmg2LBkctDS79e/QYseSLrcIOz4bR?=
 =?us-ascii?Q?A1CH1rXTvU0e++C1vZI3XsVlf9Jb3O7YqAb9jetK8nm4z0d8vwZjrWdEQlU7?=
 =?us-ascii?Q?KX9pwTdhwd9aINmQ84F5etqFYx498bt16Gmi/15jdrM2B3eJTmvZTFKPBaGL?=
 =?us-ascii?Q?rxy91RV4WHB6gKCkX9tRulUxA+gxkQaNLXRMcwjL4ty/dUYkBIWPjrZ7eGk+?=
 =?us-ascii?Q?ybPCBMknGL/lFbgBwVJyldA9m/5g0e4mRTc5nRw2jFT2xnbILT8lD96keRzH?=
 =?us-ascii?Q?QpPpiQ7zhpT0oVOjT4l0Pk2AsgqcZC0zCCZWqu4OVm0wjSsCwjrAFPBEVC2I?=
 =?us-ascii?Q?uTWjPmF0VOHQwX8XlFUVG0HQ/uC9DPLLTHUpFZDQtriZNDChZ3rAH8h0MAyO?=
 =?us-ascii?Q?MLMo6P1s5WoJrbP3yJk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962e1060-c4a8-44a9-254f-08db73332ff5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:13:08.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2bd/ux8L3eAsjN5sSJ0XlyKKDoOBfOn+BFfvToIfBZxue8ZuL6pVOu0b55xLvKf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 14, 2023 at 10:00:59AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> We would like to enable the use of siw on top of a VPN that is
> constructed and managed via a tun device. That hasn't worked up
> until now because ARPHRD_NONE devices (such as tun devices) have
> no GID for the RDMA/core to look up.
> 
> But it turns out that the egress device has already been picked for
> us -- no GID is necessary. addr_handler() just has to do the right
> thing with it.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  drivers/infiniband/core/cma.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index a1756ed1faa1..50b8da2c4720 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -700,6 +700,19 @@ cma_validate_port(struct ib_device *device, u32 port,
>  	if ((dev_type != ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port))
>  		goto out;
>  
> +	if (rdma_protocol_iwarp(device, port)) {
> +		sgid_attr = rdma_get_gid_attr(device, port, 0);
> +		if (IS_ERR(sgid_attr))
> +			goto out;
> +
> +		/* XXX: I don't think this is RCU-safe, but does it need to be? */

Maybe for subtle reasons related to iwarp it is safe, but it should
make a lockdep splat since you are not holding rcu?

Remove the comment and do a rcu_lock/unlock around this and the deref

Jason
