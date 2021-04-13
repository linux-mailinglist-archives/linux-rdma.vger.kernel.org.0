Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E0635E763
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 22:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346420AbhDMUDd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 16:03:33 -0400
Received: from mail-eopbgr700085.outbound.protection.outlook.com ([40.107.70.85]:15904
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230244AbhDMUDc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 16:03:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLOxjYs2nuxQ/KOKJNdraVwqioT/krPafVcVRda7x6B6v0xL/UYPeZCvBd4yyrCSdFzeA/3Uvcu/T8mMQZSRC1gnrr6Mu0m+R1ibiRzHsqOmzw1x0xaclf8nY3xsBUghyzQ+QmH4jsKFnENXvBxXu4JqdjnrX6VvyiFtJCTnoK2EtSfPaPNOa3Dy7whLHrhOjNiSkMxsIMaxmU2nNdLls1K8Bj1kLo0ycroL3Ld31D3r246LvBONHuQfcWV09aeYc9GdaAIR7w12xqICD8OTXwLmB8gH2JrK81Bu2CJY06FRkBx35LQheTz4KXRgBhyAQDD9ggHHDn0sGDbA9MbFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5iWcycAb9f2YGfffQHWJxtwQH1onkPX7vgo9Uj3yLY=;
 b=FpQlHjIn8/DTv1xLjzZAF3ljNwmYeab7Z10t9hYmj7L/D5VvK0AV3RqkXYZxxmilu/eAeQ1TatIS4BsgqEgmcz4Tsk4iSh8uqgGyDd/a1lkIlcNIbIFepOy4d+0oMBNHCbqsBNcT5Zc1b8j9Mo1KwBiOiZSrqpjzDF9yD8HTsYDaHZSwPo3XNjaHDldRCNE5zm8KNEUhthU6OV2PRlOg9mt4/rabnQzB0Tmk1yS55DGyImjoEGam3pgX7iKe4ibJDhdDzWPkAkAVCLQ0VcfcV+5CayWl4vMZnLmFcpYgFpNpVq3AOatBUUgLMUfjPJXEw5dZnc8fZVzEIywhF9Or2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5iWcycAb9f2YGfffQHWJxtwQH1onkPX7vgo9Uj3yLY=;
 b=Q1rCKnDF7zzaEGl4EfI/E2l5V4JdoCtpyzQvNAu4w7OLVC76Hp4eh8IOegl7A7ag0P3KHPOcJtQw51I8y/PYBRuphvTt1kFHrfLM4N9Xhh5WHWu1x+OT61x6LG0IfnD11tLwWA2VkyORVGP8j5Pqh4cYnHMRzfXCj7N28W7ahXrLGHfdYsys0M+TL+BbSsi4Jzknx0ITFNr8T2hHOhE1klYQ6/jppQz7+ghQl8/x2BfhyGUL7+N5Bx66BiRChGolFid7UfWrnmdpGPG8NyeEymC8mCgHvwV35RfG9weCEw5s0Cgfw2zMudHyCf0Rs6GqERBxokGOIOLWEW2hdHwQTw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1145.namprd12.prod.outlook.com (2603:10b6:3:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 20:03:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 20:03:11 +0000
Date:   Tue, 13 Apr 2021 17:03:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Mark Bloch <mbloch@nvidia.com>,
        linux-api@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next v2] RDMA/mlx5: Expose private query port
Message-ID: <20210413200309.GA1350353@nvidia.com>
References: <20210401085004.577338-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401085004.577338-1-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR01CA0012.prod.exchangelabs.com (2603:10b6:208:10c::25)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR01CA0012.prod.exchangelabs.com (2603:10b6:208:10c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 13 Apr 2021 20:03:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lWPFd-005fJa-43; Tue, 13 Apr 2021 17:03:09 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5f12642-2186-4921-ca6d-08d8feb729d7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11450CEAE6006572CF28CE18C24F9@DM5PR12MB1145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59H7GibHEMJHcEbosfzSbT15ESAQXiWOKIB1ExJv3X4cZKSfx6PRup4MbuKt7qCGLfPhpcIUGqEqcoKl+kDz3gPgAuZq7Vem0oNPpUdGdL89LhGEHBRO5mqw/iSkhBBXm4tK5aQEaJtt+Yuwpttl78cyufgy5x164+n1xNqbNmEVvNF2UJDxsDIg+L9+or7kw8zvsyJOEalvcAtRbxQJWG7/ulptgimKiZsnuqVbWeYKY5YbhOHWcCrs7ofM4BTEZmC2U6ikDoE/5uFqGUzPvW0lGISENqquv3ZXNEHco4WDsAAAxvkucDXZoInZS5QpiwSVJ8Nh8jbfpiRk0lWgBzWJO9Gv+fPKkHZ7TMT+qEFfNtSKNVHPPWwa7ynJVVcpaP2sQRIpF6rrT/stqGowoaUxrVizg++nvNT+ocmK/B32BVAyvQngQyBkveb9siPsigBDR3xIynm9Qd5S7q7P8xVLiUKAM8FX1/ydAoGD7SRBV8Qj2kMWhUVl3wtTkJCedqmR6EOxFsa6CUZWXAXZfF6BEAWVI0RqxsppHQm1H12rgSoKdxe9aEhnJpUfQI8Xr4sYph0v5VZ9+lsXUt6dqWxGp1R8C3IrQjPQcvIUdzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(346002)(136003)(396003)(376002)(66946007)(107886003)(2616005)(186003)(8676002)(316002)(9746002)(33656002)(38100700002)(66556008)(54906003)(86362001)(426003)(26005)(4326008)(5660300002)(66476007)(478600001)(1076003)(9786002)(6916009)(8936002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?obkgwyopKHdtahu+gg3gmnzQvWGHdQSX52wrp3Ve4F2BZZn51QnUopeyZtL/?=
 =?us-ascii?Q?L8IBGql0SXzzlL1iqH/gAH1smUkMtFmFWQxIh4DlfsbJCkcbe/nLplBH35xL?=
 =?us-ascii?Q?+PB91vbqprtfJ3+DPQ+AfdiFyzY4GAQ9GRooftdYhnWN0+IyAuHPvMO/XB3m?=
 =?us-ascii?Q?RMu////h8oEqDaz+UDmhggfzEicvtTdjV4OEYFG1cSPKxG/qXGr2QPiw86gU?=
 =?us-ascii?Q?5IEJZm8VJj4ULacZN9mIFd3i/4lZwPjYK9asSyFJ/2MSGhfBbOMIHNGJQDFB?=
 =?us-ascii?Q?Qx1JYzrmwLrdnXf6B+CXtblvAMpKPKGnjhTphcM09eYH1bYok0sp/pvpyPw3?=
 =?us-ascii?Q?Lr+AzBuwVLt98HEeZ32lU9OOEJmd+ANX04VrCJ2vpEujZuoPU28kMXgXxYoM?=
 =?us-ascii?Q?lsMXSHVsM+Q2xMGKK6x0/AqfFXdlp0LynhkJDX70JMjka/pNROi1dUSuzrN1?=
 =?us-ascii?Q?gO+WseCW3NesmMzMfFzHupjk62zuOmg2y1bXavB65USuTkvq1YkxF1CUYLDw?=
 =?us-ascii?Q?dvNu9D4KXBcr5iXCuqPXJYKEVI22TyRB0VEj8dNtSyu7bZ3ORHwodSpFTSaa?=
 =?us-ascii?Q?wH9dBidn26oDJyKBcWGwAKBEUNZhdVlfjeD5FYvZ1AtkqWAO9G1xb45IMsWq?=
 =?us-ascii?Q?YgM9NgLrSfPNlPBgRxx08AUBnr+LGzrXmhI7mdk2j2FK15or/5oX1qfiWpAb?=
 =?us-ascii?Q?ghQCEQ6ox8+UucAy04Jcj23W4QdLBmLKT+xj5j1a+hX4JQcgJ+dr4LQs4ACp?=
 =?us-ascii?Q?i0erSO1KSXFajR5l2HWEbrClsKwpobjTc4Y5SPUw2Mh/5V7RPLreVkO6SUAV?=
 =?us-ascii?Q?E+/kVykNDTzn1jBLYrKLSgbT0G2/YUMxA12YFHn0ooDZEd51EeISjxnbTVvG?=
 =?us-ascii?Q?KLvlaP8out5Uz9zYI1qc/hi1i+myg8kTY6Tdi/WPiroKiryF2Y1u7y0LkdhP?=
 =?us-ascii?Q?JjheIvmHGCGFs1r/VI1kz288l9mQSuHQvIhNsLrwQRDJ2/QvhaFIJGKntt3z?=
 =?us-ascii?Q?lpgbbC0F/F0enlDjEj3Hg5+FnP7qGUFiLy47b1gyHK2BcOgB/cdp7rE0JSnZ?=
 =?us-ascii?Q?6H3Z/pBcCbKuEIZla8f92dcCHdje0oSpFvYFTFs0DhuPSJS954KZNKYTxjlR?=
 =?us-ascii?Q?GOGhG+dJOGCMWI/1EQL8jvbCAfX1xNXIOe//PdE3eXyU+4HZzB+QMb8ZVSxb?=
 =?us-ascii?Q?+iWhpidUTyl8NFTB41o8NLSQfdJDv6loiHBkIgsPsJHsKbv33xYM0KLDn6Gt?=
 =?us-ascii?Q?MCUYBm3EAruFuei450rHfEMFWbkBsp6lQUNHV1gtiqfuhEnq8I6BqNAwzbI6?=
 =?us-ascii?Q?eVHUcLst4yMpOD9UY5S/jg2jJbPYccyoXmEidea+aS6+wg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f12642-2186-4921-ca6d-08d8feb729d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 20:03:10.8772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9R7EmMY3ljxVPzFcYahXXzSdrExEYGc+1BCLFdYdo8q4vjwjV7P2rIFTdKgZeB2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 01, 2021 at 11:50:04AM +0300, Leon Romanovsky wrote:

> +static int UVERBS_HANDLER(MLX5_IB_METHOD_QUERY_PORT)(
> +	struct uverbs_attr_bundle *attrs)
> +{
> +	struct mlx5_ib_uapi_query_port *info;
> +	struct mlx5_ib_ucontext *c;
> +	struct mlx5_ib_dev *dev;
> +	u32 port_num;
> +	int ret;
> +
> +	if (uverbs_copy_from(&port_num, attrs,
> +			     MLX5_IB_ATTR_QUERY_PORT_PORT_NUM))
> +		return -EFAULT;
> +
> +	c = to_mucontext(ib_uverbs_get_ucontext(attrs));
> +	if (IS_ERR(c))
> +		return PTR_ERR(c);
> +	dev = to_mdev(c->ibucontext.device);
> +
> +	if (!rdma_is_port_valid(&dev->ib_dev, port_num))
> +		return -EINVAL;
> +
> +	info = uverbs_zalloc(attrs, sizeof(*info));
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);

This allocation is not needed, info is small enough to be on the stack

> +
> +	if (mlx5_eswitch_mode(dev->mdev) == MLX5_ESWITCH_OFFLOADS) {
> +		ret = fill_switchdev_info(dev, port_num, info);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return uverbs_copy_to(attrs, MLX5_IB_ATTR_QUERY_PORT, info,
> +			      sizeof(*info));

This should be 

uverbs_copy_to_struct_or_zero()

Jason
