Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76A7722D0C
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 18:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjFEQyt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 12:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjFEQyp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 12:54:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0F6EA
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 09:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REE5FfV8mw87974xCbi0W4pJVWad/QxqVZSY5AEGBB5TFmn+yjefRUnyg1DXHiElQ48cpIsakk0FzMSZQUesN9KgPtk4EeSm1Y7+z/1WZhCz8qbVm2QGBcyIUstfDZdE97QXqKhrDIg11WsYP9Oa5OJQXbQJM6JWFN6WWCGSdkCJuhoY/qHKLcfHqrBAjdXCS5BCkxqjliYDzoGJboTwUuIMx5tNgy1hV43wBBBcxROk6BbD9EPNZEVC3dVUyI0jFHikdD1vgQ9PmzRwBO3FRC0gGSnxVhYZ/oofvvchGHEQ3VjEuFdlNp0fXOHZhl/l9leLWb1QGOP6u9BphrRHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vn80Aps20TPYa7du4DBr5pKcn80gzSJVoz/Dk9hAZQ0=;
 b=a5ed1yGi6nMln6sACsUOUmohxS9jl5NETBK79ZUnxuPzkXZaHCMn8yF0XqcdiBEdjVUIX/1AT1OkLLK1GnXRjmFP3OZJLkD4ezWWauWAnqRMRRWZTnQDRH86ssgfgPGeekU2qX1DZJPGY8Q806FdTj+iIdksRs6aSwVtcwl2tXp6kB3AvoCnLvGBfh8L72sUqz1VCwA+6m4GORHr/oEqeodjqS5CZCw61bjY1dLZ43aUzENx3zpxAwnSS5Y87hbAbTO2zlUQ1oLKJE5/PggVG4MfXIJvai2H0lVoYTDYm2k8clBSDnsozM/iaKdK8xRwRWMOI0bs6lKzeMGk52HTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn80Aps20TPYa7du4DBr5pKcn80gzSJVoz/Dk9hAZQ0=;
 b=QezImWcpcW35cCe+jQN0L6NlmcGfsJTgufWLjLX80L8bW1AWU17U0d9S0OhIbhMqc6MQDViH+8rdrx/6/Ia6OXSqCxsbNkiUBqfQAfsIRh5ocD2duWD0IrF1POqmZn2eo/b6DeiKkS5nXP8I4KmvvmjsM73ao2IQJNvQqAAsWTeBCHpJ4taZoDFJZTzXYqtP/FR/1VUqlf25nqaa9wuw9UtQXCNnK6at73V/sOIm7HzJ/1sWIrhWFBxjHxQaBmT6po1ofospKHV6gACfFtQ0eUFF77Q0/hmO+cUz8E9znrnTMRwL5XS5sTy4wnBLr8NtRBIMnPzGL+kNp3sjJsIQlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6164.namprd12.prod.outlook.com (2603:10b6:208:3e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 16:54:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Mon, 5 Jun 2023
 16:54:41 +0000
Date:   Mon, 5 Jun 2023 13:54:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Michael Guralnik <michaelgur@nvidia.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-rc 06/10] RDMA/mlx5: Fix mkey cache possible
 deadlock on cleanup
Message-ID: <ZH4TTgqmYi0/A/bj@nvidia.com>
References: <cover.1685960567.git.leon@kernel.org>
 <babba5ce5a995ced9ea35133dbc938d2a19510d2.1685960567.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <babba5ce5a995ced9ea35133dbc938d2a19510d2.1685960567.git.leon@kernel.org>
X-ClientProxiedBy: BYAPR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:74::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f5e114-edad-4145-7a0c-08db65e58e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bC6Zvjm+IqBpmp2N3uNCCK8exhaPh/BlhN4wRaig0YJAlubldeptLfbLJWNeaF+PyJH4XMb9Dw4V4QluDaTjY+pqdRfS/Hl0Xl+DczwS4Hki0LpIIOADuH4BzygUszSZbMKflG7sA947IC/IS9USe52O98x4WizeqJBHJmOVfuN/tQWQGw6Ug9poRnGppWLqR2jB/zqnnMlP59z9eF9t0jUvQuRg8b5WgmaI53NQIqumWlIFWRsYCn2yBtvRXfLN05E46GQmLs+bbqOQav1sRP7STar++U+PR/pUtFUGZSohkYLs06QL71+/9UgcSDmH/edp+CdkSvA3zxRS24vNebKXgjSC5ef5+rODTiuQIV1DJosmCjp3r+oTSs9x9zNwfJF3vnLoJ7yMgjXKzh4aIlj9KwCo3NQxz9cbXNK7lJqgcggt97SsTdeeN+mzJ0tCPWzbA4rwAkGXJlbL6gv64W3r87v3S8JrN/5K+jHfuU9MVk+YG4wiF7Xr+eqAtZO5PrDEsMmq0fbJsMeaJ9xW0SQlx/s+hQI3EJ5uhalc/43ND8DtQVSWptIMU4ktRKhS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(107886003)(6512007)(6506007)(26005)(36756003)(83380400001)(86362001)(38100700002)(186003)(2616005)(41300700001)(54906003)(2906002)(4744005)(478600001)(66946007)(66476007)(66556008)(4326008)(8936002)(8676002)(6916009)(316002)(5660300002)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xunJjSGIA0tGMx/a87F9N4/X92Kg/uXHpre08OD74aLgtPXj4jYjTSgX1KqS?=
 =?us-ascii?Q?HObTAJxddWh7Koll0oQFwvgIW3lunhaNtE+dF1r5srNl866hkZTV7lUs6/Pp?=
 =?us-ascii?Q?GQTkW+WpwkUEFpTp34NjIYb851If9W7+L8dZZSV6FtRLaYewCi5An5pvhhPu?=
 =?us-ascii?Q?3XC/fB7JwJpKsOnPaAvCZt5jkXyNn25cQNAX33nWRFY58lIzA4iJAFGGQt2n?=
 =?us-ascii?Q?3A9SLCgXr5m0jxe/EAaOIDZBF1V7cC2rTMNCDtJAcvuIk6go01EJyA2SlEED?=
 =?us-ascii?Q?UBs8uwMKCpHCeJDCesVEnZly6UT0qPoha6/6A0CESt8/tZu5ncdWKqSY62Xh?=
 =?us-ascii?Q?5IWUKkMIjPjPrhTq6BAkuPVgxcEVsH+YDnYWOMFUvU4Wv3YhHcCUZcrnwaUB?=
 =?us-ascii?Q?62oq/X6FQ5YMU+zwFfZczE9RG/aIcZuFWkbdbr/LpCecMN3aCtKxZjgfAD+k?=
 =?us-ascii?Q?Oz12NvSQm4kTXwDIDMKP4RiM6ZBZxaVQDDUiiXNhcCkpWmsZjupztULRR4cG?=
 =?us-ascii?Q?RU1i+9segFTPk5OliYfWlDcIOhK0PaCfZcjrEKB9vuEZJhIeQ/muMZEokyQN?=
 =?us-ascii?Q?K9JbO95uUgm6jdpIoBhsnye3zqjQbce+EHa0q73/IDHWuZQimboU2bmLiNTA?=
 =?us-ascii?Q?kTSy2bkQ52qAkHMeJPLfPfjnpDCBsqKDRWPHdmE9D2gyoJ8dM+DEPfjeD3cV?=
 =?us-ascii?Q?lBBqPpgEp6Lr8SWX6n5md1EwEAsWQ6/RPHywNevRyf1yoNIXCABtufYK4Q62?=
 =?us-ascii?Q?Zebr81e+C7tBOr3ggxzsUbMJyDg+02rXUm7d4rOh2I48AwCotT25+UfappBG?=
 =?us-ascii?Q?MtjXow2L8yUEhMJGRIY1X+RvMRDo9rGruYY/a8InigV7ghmRln01t421+Aa2?=
 =?us-ascii?Q?RSKxxC1T9LhrO/ehs3h4k+AWeAGmn4YaXCEmMB4xxBLRrZLVrxOKGIA/yMzE?=
 =?us-ascii?Q?9QgEa/1b2FvryTFq2LVW2i5/xNlVjedc4TXUVNh3UZAG+6Lj2sk9hC7ByovW?=
 =?us-ascii?Q?fHxG4NqEYoC6S4k2AHRcpzDv9bYeMu8Lcv2E+lIEGJ8HuQ66AZYBkrYQPx2N?=
 =?us-ascii?Q?nAB9/iwOWJm6dNbuLeTb+qQAG9yA1dkUf7W/9O5jGWhdeBnLXA2xpXESe6/B?=
 =?us-ascii?Q?vWoprZg4MU4SkJmO7bwN/oD+nv6eP6gY76nDIm3A49llmAcHlyKFY7sVRqx3?=
 =?us-ascii?Q?cMhgAN49ThJpLM2yN4ZnIqPfFLFJkvrGg98Azljg/i0XuJXRqQ2kmqDPQIj4?=
 =?us-ascii?Q?7medkE54asUgGhhT1NaaC9WZ4928UsfxwELakzhH7QX5HCy/zXg4NI/j9TpR?=
 =?us-ascii?Q?zQLnQwAN1ZHjO8yxliQgAf15CWH8jOSJ/c5UFXn/SBQqk1MoKyWsuvwOlSsK?=
 =?us-ascii?Q?YXeMCgV4gwyh5DYF/wYYhT1QB03RWP6fYgAkBhdyGsKeUSZi7e9gT64CZ4tZ?=
 =?us-ascii?Q?XJBMnvzDyHu3mWPL3fe+D/9lmym9uLA9/DRO7sNBKK1d5BPYec/Kb+po7pum?=
 =?us-ascii?Q?/NcULuocyTVXtNFnLCPmcE/EPICD/TzWxw9r8X3TSvZR7opFzkqEU7o1deO5?=
 =?us-ascii?Q?CzzHadfjLLLwk8MR9sM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f5e114-edad-4145-7a0c-08db65e58e92
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 16:54:41.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMjG0xCXUIcFEnuzeGd7cKKpUfn1cQzGsJVq1zjw0Hm1XX9UCrtbEPDGnvW3Qvvh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6164
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 05, 2023 at 01:33:22PM +0300, Leon Romanovsky wrote:

> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 1ce48e485c5b..f113656e4027 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1033,7 +1033,15 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
>  		xa_lock_irq(&ent->mkeys);
>  		ent->disabled = true;
>  		xa_unlock_irq(&ent->mkeys);
> -		cancel_delayed_work_sync(&ent->dwork);
> +	}
> +
> +	/* Run the canceling of delayed works on the cache in a separate loop after
> +	 * disabling all entries to ensure someone_adding() will not try taking the
> +	 * rb_lock while flushing the workqueue.
> +	 */
> +	for (node = rb_first(root); node; node = rb_next(node)) {
> +		ent = rb_entry(node, struct mlx5_cache_ent, node);
> +		cancel_delayed_work(&ent->dwork);
>  	}
>
This goes on to kfree end, so this can't drop the sync.

Jason
