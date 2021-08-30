Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FD63FB65D
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Aug 2021 14:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbhH3MtT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Aug 2021 08:49:19 -0400
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com ([40.107.237.86]:19297
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234622AbhH3MtT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Aug 2021 08:49:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdnrRHQrmQZdCqqz8rPZ42+lcmmgHZZP8rqFT1YIPLiYDVDtmyySh75Ji4IGcEN2hLFnKLAQmv8dO/lbF8x30RaQojn1VxuAhCiLhNcpxlzAHiRdPzvYe8IjZPpii+zvS2lvA9FIt6oFsPCyX36NTVNLo/jJatk26jF0gqFeKHvhy7x8ra99uGerDZd42rW0C/UktmpafqrQe5Q2DxyNnQYqtCbaTUfVdJFGfO87XwAdyw5Ukr/DeTXslPeUbs+Kv38Snx0vz1SzyBeUWztm031STuN63blSCfJgKWiY+i33MjMaL4aEdUYBjdc5jyiWBugEHqANRBfJuoVUl+IKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8B+sPJfdxcQXkDX/NTqw/Jrz3nFpz0eXYkQ26WxUBA=;
 b=OeyLkQvFcTdBsAcKD7RNyfurORxOy7Ta2zg/jX3UrlHyn/G21v/YyvQitSHs18F2rysVxc19LTYZDZlVWBluOkx1Nvf5Z2LrY2cMKpEICpzVUPzoqjfxcnFASG0fRmttTun1xU+9gcZEqj5WdP7XmVLus7QhiK8IPIEpyjNklA8pst4YFu+M7HKqq2+hRpq9QBdjfVREuwkGyoQLKO/9ouH33i/8RPvSnsDnEB/dzr/8RnBFU02JxzPkdHLtcxBhbhiZQbxdb1QqsGifJkXGwu6FDZhXXnUqqA1YBLuPuyvGc+9QedKOm4hmBVerNBU3c0GIA76bflvejr+JDRRlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8B+sPJfdxcQXkDX/NTqw/Jrz3nFpz0eXYkQ26WxUBA=;
 b=NuWjqyKuH0mihkuYq50RA28c/2pHUk9LPykvz0MQWsQHs1/AjbYwj+mxaVmEPxG4SaCagjg2D2Y1ugYE50iYh5PfU5YC2dUFfTGjySnwf0kEia//yQejwwzx5SLSrNIpaETRMPgxNmE3lyvNtdPKcGgL3AnL1itk9qy5wHlKrYtRHRBufdpu1KEdTL7jY+TENRj2tDxcJUS9xNP/PS+kqIGG3diGB1wZLHfhuLRx9pmTDIpQj92I+wdh4i6S81k0/oZG6KdtUZpJhMlOwUIJUj5aoJoN9q/skZ7U9so7DrWZ0p94swJ8LqcI48IAUeYzECRNiW9PGAofttRfEbFDbQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Mon, 30 Aug
 2021 12:48:23 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 12:48:23 +0000
Date:   Mon, 30 Aug 2021 09:48:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Lior Nahmanson <liorna@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Meir Lichtinger <meirl@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Relax DCS QP creation checks
Message-ID: <20210830124822.GA1675935@nvidia.com>
References: <3e7b3363fd73686176cc584295e86832a7cf99b2.1630320354.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e7b3363fd73686176cc584295e86832a7cf99b2.1630320354.git.leonro@nvidia.com>
X-ClientProxiedBy: MN2PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:208:e8::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR20CA0001.namprd20.prod.outlook.com (2603:10b6:208:e8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Mon, 30 Aug 2021 12:48:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mKgi6-0071zq-30; Mon, 30 Aug 2021 09:48:22 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1c2f834-abd4-4a65-055e-08d96bb473b1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53519204B0CD9FFA80D5DD59C2CB9@BL1PR12MB5351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCUQbXHtJS7SR3PEQV3DxROPQtiPPLDZTTVsRDjSYWDpdJ1optjfw9Xv5w7xnlnH7XhoVB3pdQwb/VrxE2IAAowpxUzrcSU9RU5emlZ1wzvXdbyWAbj/lXBwXrYOI1zdMpsCtt/DDBo2AYqz82PoNIFdKmnqwIYE764XcwgsaavLKSrBse24obeNBsWdcznYbTH1u6u1nXOfaTmmayt2dMKYL2GwT68zG7mSYi5c2EJw86tcXajggRdkHocRc7tc8sBSgxAPSl7EUnbOIa+cBC3L0Y3rgCPld/t9pahVzC54Ck9Azyhm67t4yhBqe7NGa8DJYy4pU9tWTAj0E4ZF/9aMCxzON3pGcBpitxewZ1c+Y+fsgf0pEn5oe59kZjtceLVq/6yiZ7Ff98haYNDOUZjd/QbJJb27+P0Xf982qIXSr1lAe7i18w4xGNHFEl9Zbglst4sotBt55FiQBXuOJa1T/01Q7D2gBj1gOqoKB8/CbPOhdK+QC+2jQubn2HRXK+Z3cjr65o3spNfnYwismWH7gzsS1HzETghfoPsKgsQAxjLHpk9ms3Nf0PinAX9sBoI431SsiywNNa48S4sxjXd6C7WKbaw+Otibr6wJx+hGF/lvvj3tlG9zqNYtD5hcLGaicfr4uiO4m3/c82KXNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(186003)(478600001)(4744005)(2616005)(2906002)(5660300002)(107886003)(9746002)(66556008)(8676002)(86362001)(8936002)(6916009)(1076003)(4326008)(9786002)(26005)(33656002)(54906003)(66476007)(83380400001)(36756003)(66946007)(38100700002)(316002)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yfCBk1tHeQ55zEHlGD7Abbadmz9pBNG8KAEqk8GSsjWA8tHxaz0FA8gDCDv/?=
 =?us-ascii?Q?4kqCKF8wVIWiTJ1GsSWCATX4upiooYnJZ5Bc6QgFnZSDAFalG1hWivNOSkFD?=
 =?us-ascii?Q?nJ7GfMZn0bQK+X62y/ovB6D/1YfBX/RFHaEtdIEGT2c7O9mLTjGkcon152jx?=
 =?us-ascii?Q?CQXcjcuYFGsbMzJpxa8vQ+LsoThg1Dnw9zIvkRrQksu0Gveezc1MdhGxQsoC?=
 =?us-ascii?Q?lq82TCnL+i/xUisALkhQmun0uB5Ot6v8eOEsGCDCGLy1PE6fRjlx3Tbn+IR5?=
 =?us-ascii?Q?DIfMp1QKh9MQuenlKoXm4rHnRsftwQwVC3FLOntHMefKcWzaSymwGkG1wH+q?=
 =?us-ascii?Q?ZVzTjFAWFJTfAZhAGxuC/XzDQ3UyqS6Gr7IMb+M4bNQ8KGBr4X7uERJsSHBz?=
 =?us-ascii?Q?gQdpKlXqVSjLFsBnKMoAaCeHwADgt9xmQQiiq93KJKaDbbsBDyqM9GmowxLF?=
 =?us-ascii?Q?64Kw2RyK4RqUVWVAUQ44AOinJijwtaGVEVvjTFGcT2FGs2ZJJKVDbsnfiY/q?=
 =?us-ascii?Q?pWfJfiv/x0TkizUWaJuSU8h+fD37vggo48ad+LOvy9w6WdMhjFOz7ThTBLQP?=
 =?us-ascii?Q?gVASXfO4BnnrLoqqMgyaqJBOK6ALPT1w2qBKriW8LB5HfC7psK/CKfBXlYdF?=
 =?us-ascii?Q?qI5+Dw0pUBly8SPLy7QtM9zCOdbI8rnJvPzdIut937lPXVETWCniOonjpsM1?=
 =?us-ascii?Q?sJE/V8efVzVf2lgboTMhXnATHSQcz0TruFV+7LysrL7b4lhtyRKXMpYvBc3R?=
 =?us-ascii?Q?+Mzr0T1S2kerUoHgvShoFnV2V4f+DR8KUGMFRFXU6sZgcoFp8GOdRS2AdOuu?=
 =?us-ascii?Q?C90S99wK4hrpDqGN7PilRUWEZ9xhCm/FJoXGtA4m5RaRicp+0n+2qc5FVdbp?=
 =?us-ascii?Q?XXmQkEfN79OIsVtoh6pAwvgBlbsSt3LOKe35oY+pmXgB7+aJfSA4FyPSDWCV?=
 =?us-ascii?Q?IXgzdLsB3Xm7FscUk4h87Dc0blyNxjSvJWxl23IW+K8Kr4UO+w8veBUHMDaZ?=
 =?us-ascii?Q?VKMBL7rfgV5Meby21+YHM8IgYPL5mTWwlCmKh4xZWclcaNmWU46Q8Zr1ReUS?=
 =?us-ascii?Q?WgF0gVFwHfVcV5qvyH/T+mdHbPHDyrCbniwBEQ9sum8a3oFrsv4EI+PMp8Ra?=
 =?us-ascii?Q?PEaKnmTVxKw8/Yq87gOlfwmj9zg8cE+//OKGjajNrgybcDvQlXSU/ffxf5mF?=
 =?us-ascii?Q?3wGm8xw1uV7KL5wGsLed027DwUPTOEQgfmhWVIxuOynT43xK4wiU3eLgMICG?=
 =?us-ascii?Q?7r3XFw4658tfEn2oyyN02yB34QblKH3gxx/CUZ2oK/yv5+by71lB221EaOtX?=
 =?us-ascii?Q?VTM0iB24HIWBpUCRvrSQOuyG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c2f834-abd4-4a65-055e-08d96bb473b1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 12:48:23.0405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xCYvJDDQNNo6WPoNjXWDOeJNRWsNIqJDyg45ZVf6pALj+YJ8KKYPB59YRJFbLUu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 30, 2021 at 01:48:49PM +0300, Leon Romanovsky wrote:
> From: Lior Nahmanson <liorna@nvidia.com>
> 
> In order to create DCS QPs, we don't need to rely on both
> log_max_dci_stream_channels and log_max_dci_errored_streams capabilities.
> 
> Fixes: 11656f593a86 ("RDMA/mlx5: Add DCS offload support")
> Signed-off-by: Lior Nahmanson <liorna@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Jason,
> 
> Please add this patch in the upcoming PR for the feature that was
> accepted in this cycle.
> 
> Thanks
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
