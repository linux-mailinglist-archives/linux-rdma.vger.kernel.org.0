Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F2533820C
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 01:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCLAIH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 19:08:07 -0500
Received: from mail-mw2nam10on2081.outbound.protection.outlook.com ([40.107.94.81]:24032
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229470AbhCLAHm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 19:07:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5qLjaLlb5RKUbE2FuoYL81UAj1K75JNcMphMBfwpruQs+Bd5PhCLOnpYh8X5jgX2a7StlJEyqTmJ7TQucD/DScRzxhfuRudvrURB7AIyWkfq6JF2SUvCipZ958VYQqG/8oOC9RwU/8f9mmeYwc0h1aPDIp+il4AvStshR8rolxzeNmWVV+kg9piYBaCNJLs7vMz6u0kOizSxOvAJugmJ4wUDV7JMGwuQvckTHYkFKcAnEmAC71AQh4iyGDF0YYmcZP6mkVapM7RcU9G7Dv1jLv6nBuXnYgM9nI9aZWCHTPNemFlRZibEk0H25e3e+FoDbHI6GAeA//yillOBj1tVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNlkNrumjnqaPQT71TYvRqI9HPM1B0vpFMxrTgXyqxg=;
 b=WndbEKGYn3IzhyFjWcMlKM8ofVrWpf827MEmSrvzjsLUyk1mnt9mF0BwQNN4bdjWE5toJoDE9TXEPR7Zl3WHDwWahLhgW0/m1LbjdCS8Ns5eAqlOVtc+TWztSuAtEV632T7EoEpWlR23rpP99Q0q3WSl4cAW2Pg6VippLkgCplY3SRwR2jc7XrXguO4sZ35Isx5Gl+FRf44pXHWMyO4fx1AOmVeAAvZXgIJ0CMlaOizh4P2z2P7d6yjPBO4SygLypvaM2RDZpG8n1Ihq1LQRPTO+hTvGM4WhPX0DpDzSig0vIOex67doX18Dc0l//v3gmeD6cTOTyst5du/gspV2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNlkNrumjnqaPQT71TYvRqI9HPM1B0vpFMxrTgXyqxg=;
 b=oSDgKburp8gjlqIX1cFuSpUKF1qy5qtk58rHsFbEgKtBrQFz90E5R48CpHnBGejBX3bB1QaT0jRXNBUQqsoQu5J7XMjr66vULI5PoHizgKE+UKcEan+SnFWckVYrOpjiwRq7gGpqrX03GAjNwzylkQD6tZgJnK9FFZbHKz0VzxyFPigXOI7gPSLpWH7MDIKH5l8EpvwZUc6GFMQpIbp/vHJ5UObBCl+g3QU0yrJL/TJC3j0cDnBPTOdxPJvrBQWu6nROt8haWYkG1foBgoxjKsIQQDir+uu8ogfph+QiB4qfhlVA1mCNAO8FMUpToIyH/8G9e9jBrAH/GSr6y9XHKw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Fri, 12 Mar
 2021 00:07:41 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3912.028; Fri, 12 Mar 2021
 00:07:41 +0000
Date:   Thu, 11 Mar 2021 20:07:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next 2/3] RDMA/mlx5: Create ODP EQ only when ODP MR
 is created
Message-ID: <20210312000739.GA2773739@nvidia.com>
References: <20210304124517.1100608-1-leon@kernel.org>
 <20210304124517.1100608-3-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304124517.1100608-3-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:208:134::46) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR16CA0033.namprd16.prod.outlook.com (2603:10b6:208:134::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 00:07:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKVL9-00BdaW-Jl; Thu, 11 Mar 2021 20:07:39 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e95c3f5-e4d1-4ed7-86e9-08d8e4eada60
X-MS-TrafficTypeDiagnostic: BYAPR12MB3205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB32054D65EB175D8D3003B6B7C26F9@BYAPR12MB3205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKMapIh3OTVsQsConowEXFS70A1CJ+etAVptU0xtp7UYMoA09Etg2c+PCXa30GbedR/7SyK8hTqO6hZzk51BPFAq3uzHKeCa0QAo/VkUKWo41eyHxHLyGZsVCOdQBPcZYYYxnItyaCX8CMIdp2Z1FM3YVcbMB7FWIBGe18gjbciK92RRuroCqGw3emDRnFwuR8gaD+VwHC6WlguZFznx+5NRhLkMerBLKNa5V44LzDGy2aZ8ptf0Z0nSyWJb+TGEI03UnlQAhmYql6Th4o7ovJMCCMCWQUNVDgCSO7nzroFL7YRF836IXw9dvCSfc9YMd3aPPWSa5iD1kyNiqcVic1ujn/LbyBmKyqUBb2L5ZFK9LlOiXQD8QNtiZzNOZJuTBSJoqP91pEHJ5kxg320wuaPrtxZn/xs/WbnM2cE48Zsx+n70PWiSY+jnsB/B7716LhmOqJWrlzGmAdgr9CY9FnlzKClVC/DofMd26tyyIe0to4RB7BnYvOi+tBTJrAlojzIjTLAKUyqKb5icB+zXbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(6916009)(86362001)(4326008)(107886003)(9786002)(9746002)(2906002)(33656002)(8936002)(8676002)(26005)(186003)(2616005)(478600001)(83380400001)(426003)(316002)(4744005)(36756003)(54906003)(1076003)(66556008)(66476007)(66946007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4+YH2HdQLsT9ZE+bsdhDEEGBReIWN5uwYHBrJ4LyhMwhr9uyKY+tvJoshCvN?=
 =?us-ascii?Q?W6VtG7cu1oCy/I9mob9aCnVBVSsRO7zUVxviK5kzfci9XRZ7i6fFWwHJ/Zm7?=
 =?us-ascii?Q?5r0PoeXupZyXNSAb3/+IefkmiRjP+W3GXliJgDASE+1baeQFo+W2DMALi6fa?=
 =?us-ascii?Q?sf2NcUaz+eMsfky7h3XWcSXctPqcqdwBCk5jc5YNgcWuMa1HGu79jfmRLqYj?=
 =?us-ascii?Q?SDiivbs32xSZuTSGAj4hnNAnudl+zTvtm/yPXvRx80M+4Mz+pneL6unuvRDZ?=
 =?us-ascii?Q?WZOnLMUcPjfQ77dwVrX8y8DS3palCHmsV25yo0zU0k+ra2/tKarTU6pgq2/n?=
 =?us-ascii?Q?WxhW4irimCLnx1j+ERxwZdROGX3ZEQQM1d2aFofJ5vDeBNGsuKAqVjIBSJEU?=
 =?us-ascii?Q?Wr0NZfYW+naZ/54xqepTjt1hmGk45LxH6PoXkGxn0/gmIVJ7Bj1TOLNtbkR6?=
 =?us-ascii?Q?onf4Dxl9+Cjzne8GOKW0/N7BMcFZF+1n6U1isu+GcnwJhAh0RC7JUpTtwCYv?=
 =?us-ascii?Q?wqvZPBYWqRSLnBbby92QcccDI57KgJ6SSMLQ9coa6WfJlKi6ogO5zuNWHftM?=
 =?us-ascii?Q?RSj83ow/3Pa/b7VyB9CcCceyJhYcuy72geEXieZVwSBApALw91hjCWCLCPax?=
 =?us-ascii?Q?OqtkZUBTmqtJdq7nMZckXxk4lmb34zwu4N8RXdYHosRBVc58W4GQPw3kdSPP?=
 =?us-ascii?Q?fFQGCRqh/AKVmub+dWW3XV6DWm878yFxqwQPvwvPoliwSq3EqBpPjDMJDZ4e?=
 =?us-ascii?Q?xtj1RpNyoB2GLUBN8xf5sPz/Vfy7E9z/WE+PBzEn5uh4BmEOZW7n8Pz9hawi?=
 =?us-ascii?Q?a4X65qXwEfXvWESgROvIA+kbzaeTxJguDaxnP4DSADsilEfPvzyE6tUl/syQ?=
 =?us-ascii?Q?9ApnXoB+0CZEjdwyjK67HUo8WmAwTfju9w6PQ/AIcAZ7nwQghFgICr0i2Br8?=
 =?us-ascii?Q?wdpWtLPnaa5/cghe8Q5XBB581wRDnh03BfXT4X5QC1jQvyLjPiNTqJirVNqO?=
 =?us-ascii?Q?Tud/WJnhSGNFhAADV6KF8qNB4suXNc9naPTfIEPq8MguXLyM8O7bfzx9YHY+?=
 =?us-ascii?Q?LTZsNwclXPRN5QMDahlhZRr0LT7OVxja22tY10NsGsE3H0Ld/u7tC5ftMGQN?=
 =?us-ascii?Q?EPovpHGDA9Ro2KLLy1BqGNRtiPJXZIpaTp26t55vtWQbQxLsQRZgZ4DOW+rk?=
 =?us-ascii?Q?o0Yy4HB6Hd9eZGgElxAbXlpl6j/OleUkGX3bscY1cEggz24tm32HejaGqa5K?=
 =?us-ascii?Q?6U1SFTNAU9A5tjbldHbncrGoonnValCbqZs7rPUiVY0s7GFjR5l2xeVvbYLE?=
 =?us-ascii?Q?k6DImTVdHyt5jaQAEwrgcDemeo4dVGg64DU20lQM+6qV8A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e95c3f5-e4d1-4ed7-86e9-08d8e4eada60
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 00:07:41.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DdCkvNpA/g6Je2mEgckeI656qHgmKZ0MzfZExEuWdeZ/B3IvmIPBiRsMfYCKP1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3205
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 04, 2021 at 02:45:16PM +0200, Leon Romanovsky wrote:
> -static int
> -mlx5_ib_create_pf_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
> +int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
>  {
>  	struct mlx5_eq_param param = {};
> -	int err;
> +	int err = 0;
>  
> +	if (eq->core)
> +		return 0;
> +
> +	mutex_lock(&dev->odp_eq_mutex);

The above if is locked wrong.

Jason
