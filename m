Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A562390A26
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 22:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhEYUCe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 16:02:34 -0400
Received: from mail-bn1nam07on2058.outbound.protection.outlook.com ([40.107.212.58]:51654
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232742AbhEYUCb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 16:02:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUxRTbfh/aMi1/OPE8JhHSqxJ6vPOYkMUFVab9M9C3fRFGhKQ1hIclEOI3Ob3p9g9ffq7JAnwPV3vn4YmVggm0v3MlH5oEnoZ85iZWDtZmR1kgGhUyvVuZDzSBJHjTbhNcKBxdkJVR6xMXVRQwWmklbSBRozzzW7vFa2mppMAGEe/tLpZXIf+lAsMe99/AO9AeZ+jQlP1XgBg/HEqCNE9KbCg7KNex7foWlPZzTediB+EudFiKaIGOxg/YP0Vsd1OS+NfBUW1SRoEnSjQZ7unIeJryx6Qkptkzs9V3XzFUfEvpwP27VZQi/anJK9ajtsef+n9wepab5HFT3qPb97fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RpQ0PQGjS1VYnxmF4rrGoB8Y7jL6DQosbD9OGqPrYI=;
 b=lv9mGxWgnHnuEEYs7GjxXd5FljQCGC/y/+b3zzFF02Qe0MIZATYKoPmjoGlP5R01dHchNLog3oyDXvOhcJbZJMewlCoGxIySljYy4CYT9B2//QjkS6Ry5bw8/QSTnSMyTvuK41sZ0styD4QRldgucuAytE1liELtxLeIdH6hvyldm7YCeHbLKzrkxadAKyK1HGzXN9/ph4WcNaMEWzYzhli/e8rPwXy4xPh6RsYLSRXia29lvYKokWL4TTISxe4qKGUbNzj4L6B4O8X5FYwsaFJuAw4UImHDvskpgFNDOqOtDOiO4MUEOTqHgZbfYuWHw2lTivD2KQEhb3nmwuGP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RpQ0PQGjS1VYnxmF4rrGoB8Y7jL6DQosbD9OGqPrYI=;
 b=g6ttQ0JQKBYZy0cIil8NOjslanW4O2W76ugeVRUUQXvJMGyqfigcYfnpdhacOVF3XGrvnZInD1XKhbr42Q4SjwnnjZBMcLkCBHLTBxFgxB9eEhIZ4v3krpoJVJU8enL9GRRj13kMSBMxcIDj22G8PruIiht2Y0fbQJYzoYHy3Un7vx1qKcTC7pLnjHorTMJ7soH5cCknQFD4Sf3VQN9Mvr6yTkl1RXzsPbiDxME2oHd1ciTdgzIQq+rNPcDYs40wDUIm3U/b0gYB0+nE0fe4Sdc/6UiAX+U/j5CEfOebK7YmNNlFYX/pWk29qUIr3mtvYpfC1MdsYrOgB9g2MRGx5w==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 20:00:59 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 20:00:59 +0000
Date:   Tue, 25 May 2021 17:00:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markzhang@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next v3 8/8] IB/cm: Protect cm_dev, cm_ports and
 mad_agent with kref and lock
Message-ID: <20210525200057.GA3469742@nvidia.com>
References: <cover.1620720467.git.leonro@nvidia.com>
 <7ca9e316890a3755abadefdd7fe3fc1dc4a1e79f.1620720467.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ca9e316890a3755abadefdd7fe3fc1dc4a1e79f.1620720467.git.leonro@nvidia.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YTBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27 via Frontend Transport; Tue, 25 May 2021 20:00:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lldEX-00EZby-F3; Tue, 25 May 2021 17:00:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77ec2f33-f6ae-4a5b-9031-08d91fb7d0ad
X-MS-TrafficTypeDiagnostic: BL1PR12MB5350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB535022BB900B2CFCE4BC6375C2259@BL1PR12MB5350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:176;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7hH922b+GdAtx4rQpIcJcIPoNVOXLOUDb2ij/f4GOG/jLXdnEro2E+oNavSzdlP8bGAEoJTa6uQiWS016TeXd1PhGUXDvfLVR2Ms+ss3iz3E1n2cAIQxwwerRiLKUyDRbEVfalmgtUy2D4XbEVPr4ba1yj4N66KOYXEYSwCWFeHfKmL1Op7TtPFDsX6E2nbE1yinY6Cjluh2LpHO1klfC8KzKZcYx1eakYH9lAO9lwMfndmQOSfW1FHHiBbEl78WASqXqFZkIzXAW2kEWQMB33IfisfroIBJ88utRKt+mzzXA5TIzhJlqJeEWnvsI1em+Rg1qDh3ZrBaHAc7GxDj+0HnWOHmg7jKMZw28FwskmPO64herocEfMqtAEE/pcNi+lHncdP0tkqEq01gYMGLkcL49ZbYwTDlCahaZm8WXrpL/qx5jjwBY76ARkk8LLIAfMLOExDQX+7/1GWh4KHWmCymE1TgNgOi+7u2JZcrG+wZdi3T79loPkARzpTzlWn6WUIpF1wRt+CX0+0LZhEcKto9OBHYzmNTniQWASpVQSZqzsuS3rOIP0IuwCSucjRbMc+YZ5P96UHGkVF9HduWld2EiYhVoSjwjcRyF6tA3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(83380400001)(86362001)(54906003)(1076003)(2906002)(316002)(9786002)(9746002)(8676002)(36756003)(6916009)(33656002)(66946007)(66556008)(66476007)(4326008)(8936002)(478600001)(2616005)(426003)(38100700002)(26005)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S/aYyUR1IjNIbFNs1+OvrNyJvbIrqjzXrxM6z6jGWRE/UQ2yj58eU50ySSDN?=
 =?us-ascii?Q?Wqlx9PWiY+ceq1mueG0TQbr3er9cChrkgX5BpQvWaIz+3JZYqCoTWCEJoS9+?=
 =?us-ascii?Q?PhYaggSGfp+udjILfo2/mofBmO6nSBV+MY40XYllZefLbFCvkwqdVRDGDdPw?=
 =?us-ascii?Q?fVfCNgnwJXujwuMpHbXdotrPVXAB5YCnfyBnFMrNgwzu1zkosD9e5pNDlGrL?=
 =?us-ascii?Q?Q1P6i7XWok5XcdIUreAn2Gs0nYLUB+C9YX5jKMI0SjtxsHpnetzGC7YfDwTO?=
 =?us-ascii?Q?o9eK9QPRMgxCC1ANx4LU3Fks6muT/aVn613hW0RjhT2MNs1cRKUt6t9zM/6R?=
 =?us-ascii?Q?rU2APaRuhLk40/0jMuvI+chexPgfc4gIM/wt15+xL5aJj6AFs0x8yzAm0Jfm?=
 =?us-ascii?Q?VVfTPfKk3DnVQiUpAK6lO5skLwbcun/nmTOJ1r9vgBtPJDiMokfiAYWDE98E?=
 =?us-ascii?Q?Z0WcmVQUJNoGeYzg1YoLJBFSPKDi0ZHn5bjHz82h3584RPBPekoxxZOadPbR?=
 =?us-ascii?Q?L1fgqj9DE+kdMLzHEmDkt0SPIm1CIgf2x+z6RckbBQMKMt4cbKcjPeeGfYeS?=
 =?us-ascii?Q?Vipsejj5bIoMr8XVmufwhrq3+zpxMzmqK0TiCYgFnsNgbvRazY81tkJRjDMt?=
 =?us-ascii?Q?8Ud/3TraAAfrshhidlnwShZ6wZao/34zn1ggwhSwb6hglBS4CWhR9/879fBq?=
 =?us-ascii?Q?t7C0125DaivJ63u0H291KsIQjX47X+Sw1iRz4QmNd5syPg5BfuZiufzo92He?=
 =?us-ascii?Q?8PgboBVYc4L9bpnDPr7nhcOLi3bcNxuSlS5k+yzKCU9LyXAgnJhHLiYO9UuL?=
 =?us-ascii?Q?Jr+7dKLeNoMM67SAk8d3WyiH5phUsCcGtID6+kaeDyWMFC3rMNVKBxyRF3Sx?=
 =?us-ascii?Q?AHPnZO9kDAG27NM17HPhavFwtP1UJ3SdA1JOR1pe8Qg8w60sj3lV3PvcrwhX?=
 =?us-ascii?Q?s/LwJHkDArSW1sxYQr/+RubG2M5GqPdeIhSCWUxqcW6jLFe/mBDG7XZ+1LWw?=
 =?us-ascii?Q?NHVK9AwFA1SAIztLsNK6NYYvI0A4e9NSTuDEFQsOpa/qgYt3tbhFzKI2Hpk3?=
 =?us-ascii?Q?STkWHMbrXDnZsQGp0dK6J8uE4TJtnEkT9xAbq92WZstTzifoVQOMJqA3DGBo?=
 =?us-ascii?Q?QTgRCCtOv+8NXwmwLWvDm7EzpOjRhn9z+UOUx1ApSziowDJRfahJOrbqgnAw?=
 =?us-ascii?Q?+46HNg2rwj+10VZU83K1XM4yLNUAMeL6KByTkdvp3elgAEmM9zfJd8FVVG0H?=
 =?us-ascii?Q?hmcwbyNMFZWxF/gV3cQ7ici8At7z93T33YckAIPvYSsUWkcT4DTCtHlnowZK?=
 =?us-ascii?Q?xvJP6TGsXdwjO6ZB7M8WoqO7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ec2f33-f6ae-4a5b-9031-08d91fb7d0ad
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 20:00:59.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndD2vmd86twgJnIo7ludXHrD9gMeJpppBMp0l1ZU+b8dwcW9vNfwLIZsdzFUjIUe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 11, 2021 at 11:22:12AM +0300, Leon Romanovsky wrote:
> @@ -2139,6 +2197,8 @@ static int cm_req_handler(struct cm_work *work)
>  		sa_path_set_dmac(&work->path[0],
>  				 cm_id_priv->av.ah_attr.roce.dmac);
>  	work->path[0].hop_limit = grh->hop_limit;
> +
> +	cm_destroy_av(&cm_id_priv->av);
>  	ret = cm_init_av_by_path(&work->path[0], gid_attr, &cm_id_priv->av);
>  	if (ret) {
>  		int err;

Why add cm_destroy_av() here? The cm_id_priv was freshly created at
the top of this function and hasn't left the stack frame yet?

> @@ -4419,12 +4486,19 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
>  		 * after that we can call the unregister_mad_agent
>  		 */
>  		flush_workqueue(cm.wq);
> -		ib_unregister_mad_agent(port->mad_agent);
> +		/*
> +		 * The above ensures no call paths from the work are running,
> +		 * the remaining paths all take the unregistration lock

"unregistration lock" is "mad_agent_lock"

> +		 */
> +		spin_lock(&cm_dev->mad_agent_lock);
> +		port->mad_agent = NULL;
> +		spin_unlock(&cm_dev->mad_agent_lock);
> +		ib_unregister_mad_agent(mad_agent);
>  		cm_remove_port_fs(port);
> -		kfree(port);
>  	}
>  
> -	kfree(cm_dev);
> +	/* All touches can only be on call path from the work */

Not sure anymore what this comment means, the work was flushed? I
think it is saying all touches can only be on a place outside the
work.

Other than these little details it all looks OK

Jason
