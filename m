Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BC24C7222
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 18:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiB1RGj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 12:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiB1RGi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 12:06:38 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8DE57B0D
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 09:05:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giCbUrDtrxXmpwH43IIVYDWNaG8d2o9pjSD2j6TvlOGjFOjiFGqHhT3OhfIokSjnd6F8God4DZkz9nTuV9gUa9bruWdVKdsZ+fqOgQrnTa3RdabxUAEAB/JczNQJy55yvjIURPBJV0cqscvzURSmaCW6TAMkhSO3iZtajzT7Q5vBU8BZPnZJIZg0QQO4ur7SYPwf5qtAWw4vYHjvvejiPfJbZUNIAnkaC+cxQnm22B2UqTsMh1o+rsG0vRa9XIBfoG9eP1BFfPHM2x0Gf1+7yBG73+yTgFYuoGjSSD394nKB3Dw6Ff6nj7LS3CveLuz9BiiSEQl2thjBmbIvGdwXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdanzLg5/lwVgpDeYSHtR7BqOCeUSyaCgmW1yXbNX84=;
 b=NXc5bDSIX14LRy+WIAGlevo8phayfZS126sxSGUMI8S6gJSjQtMOwRK80cSIy2cBz7lHuowOXVBLZjRMTmmSP4q8rIb7pcPpOxYF1VyTsTBCn8q9Zy1vGJss0nEkuvACLFOPOH8Am+DOm21vDlFbxxufHJqxIudYrEU/sb5ccBP7vUDRDQ6GU3H7+k/qj/SGoEVQLZdSSbKBX5d3R70YFPUKXzxGEdzCypMggE7QoORh5nShld8cTNUg7Le+PX1OaI6y5DGuWcSvvhZMmTqp90T9I5TcuMgK3JZMOG6Q6TXeOj+FTxFRcDfRuoUE0pZHKZAsNk3W4+JxfwvIi9uhsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdanzLg5/lwVgpDeYSHtR7BqOCeUSyaCgmW1yXbNX84=;
 b=NI0z+VKK9slH6QD1xLF3b8mLm6liEiKbecVBPkZLZ/vlei0IRP0VsxYh2Un9TsXI8QtF+wza5TA0sFST3me1dKi+hAZr7UZFsJhzHJsH4oKhAIEiLeLzpNYu9pKL5wweYSyyUdP6lA3FlgQSG+EJmbxHvBUVLqRcQySL/nD2Y0ralABObpSz8bekf3QYMEB/23nKGkRfW2TcZDF8XDB+2JMm7ChMcbZ7JOa+O7JcK5yuSxQT6iutGNavJnNSWbmShg0XDPB7AY2TiIqYYAO9Z0Kr6G0+Y2O6UXDnIKkgm7SVERR+xBMHcBCmzVNGfCnIDD56GVTHCZliypuhVtBlcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3862.namprd12.prod.outlook.com (2603:10b6:610:21::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 17:05:56 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 17:05:56 +0000
Date:   Mon, 28 Feb 2022 13:05:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v10 06/11] RDMA/rxe: Add wait_for_completion to
 pool objects
Message-ID: <20220228170555.GK219866@nvidia.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
 <20220225195750.37802-7-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225195750.37802-7-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAPR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:208:329::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caebcc04-99c8-49c6-903c-08d9fadc9600
X-MS-TrafficTypeDiagnostic: CH2PR12MB3862:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB386289C46F05B6B8B02118F4C2019@CH2PR12MB3862.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4cuCdBfYoUvzuv3riwrBh4HsflK4aiLKpr34PCpPbZw+SJpiY68yBJgo8zPbltME05KWlxx6WpjNkx/g/nRjqnG33Qdm335ckiE2URgNTFohxb798Z3AN9hstKV/Ps9aVR5e8+y52c4lTVR1uit7SKfj9MKVTA18VQ7uFFhEn1RTp/xn4ljKWkbENQDifu0mdCFEfKQD6JmGKFT0eSJQHhXGnGJDxC9++i7vM6dOZwA75UsbHljiW7at1QPTBdgnCiyKBouywkJkWNj71KYl9fo2DPsebPiMo7+Eh1LsugqMqEQs0i7zWC5iFZ/YZJbYAE7fMSnDlyndg3ggLIz8OmyTilxvv1SYCDwJbleSq5rBhVrPJPSMFbtFerzVDVRmcggJx4Usd6DiSytWBdhtaiPEIkAJzKOu4n6j5TpwlduvjpEQh6JY33BHXqPQvCqbMJ3WYu/T/k6okHggrb5POL38QMN1b7SwiJ/g2DYB+OQwPiAdgG1T44gZ9vO7LMdXse5CwoW1WMFKf6ewUrShJoJ2qfc2QB9BgltpSLLoCdHhYS0dcDn/1wroDV9jkwE98bxmqP1nmx2zv0PFDCQ5s58ZtBg0sRr5aqnZBwirOgL9jSAfo2lFLmG0hbyDTcVGd2RuKVF8/mcFln+5vfXp9fJhbm3aE4ewCKxLWKtBMb5mHjvNLxG6uvDOYZIOSCLfR6OwN9xRpUaCsr/2rwdD8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(36756003)(6506007)(33656002)(316002)(5660300002)(4326008)(1076003)(26005)(86362001)(186003)(8936002)(2906002)(66946007)(66556008)(8676002)(2616005)(66476007)(38100700002)(6486002)(508600001)(6916009)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tx/lew7kGI0TAj8cgSOjgNJ4h35bSUCU0udLtd7Ap/CghPo5uNxEj3l3km+W?=
 =?us-ascii?Q?QmxjsEjwJymzxkM+GZ+lXoL4yuWfXdlkaVUMeNZR39T41ozyy5aIssvN1Psz?=
 =?us-ascii?Q?Di79zIsg3nSDX2IAHRrdXFsFWzam9dSUubefi0TRwXGud/dfcOc0VVOfOEqf?=
 =?us-ascii?Q?zIFDMoHz9vmTx/L4N/qwpYqQSRSZpgaQ9rxQO7NVZUdfXLrPbCo84ByP4Vhk?=
 =?us-ascii?Q?Ub0J4r7Xn72QVmKG8WOySB6u4SQWGP6a62EFIq2XpO9rAwOL/Hxk02nOJS4Y?=
 =?us-ascii?Q?TypdhEU3KhEPTpdQcyyZBKUsX4JkZEhQ/UanSCamKQwIbgNhAh0dj+HFGetU?=
 =?us-ascii?Q?nHu1z58cuu8PWymX5jJTJf1Ld0h7S26a3KXdgLjiH5JMpzh1Y/BJoDZ8YkMF?=
 =?us-ascii?Q?rMQ5ly9s+daUTCC7gc90dr8mAi2+21gz2Z7Nb6l7vL4eAreUySw5c+mP4vZs?=
 =?us-ascii?Q?qR9TbCWwjb1BVnHMMhO5meIQnJatA8srHQ1zCpEvz2WmIjnhCbg3AdMpCVvx?=
 =?us-ascii?Q?VEiAaXWgCTPXUH6fUy3b2FbYpvS9dlhLSP5aRZ8kXlHYYteEBdm3RiFhySUZ?=
 =?us-ascii?Q?RmiyJYtKB1Tc4IcbCA70F6VV7oKdDzxt3JdCGC7ZR4o+lHfm1cVfcN6ubBCH?=
 =?us-ascii?Q?8qP5MOPzqwny3KhU7qo6xwTRg2NxiabqgrIrOsYXYcnr3T2FmiHqB0etJ0pb?=
 =?us-ascii?Q?L6M6aHXbMw9mczZVBifWFgQdMTxDOVriSGs7To6HcudJqX9YTnAF6GQPW0Wz?=
 =?us-ascii?Q?NFPFnzN/vhfFBrr3VQ66txInWfCgdq+33f8llAAZhUozB23tt1ZjDLfelqfa?=
 =?us-ascii?Q?Z6sOnxBlOm7frQQPQCm+d97roHMh89QDzrgR2FVv6zs4BqSUpKoy+wkXOY5I?=
 =?us-ascii?Q?/OsE5ZWe/6F06Qu0i5c4dubCoVQRIuFb8vlPdtBHqW4JFEVShGVT5KMfbqlt?=
 =?us-ascii?Q?tLxcoD9S/pzfytUFfs0YkuGjUqa2Tq4TyepDlcqZf0APecsAJ/oAgnXzbSU8?=
 =?us-ascii?Q?Jlrs/BeHUNAMDubQVa5/NVXfovL58ylI6ut/sSJjJpgl2D+1Zk2+2qMrueOL?=
 =?us-ascii?Q?rQXLbPljO6z+x64puT8P+S1C/Oi3SV07oKDuZyAKzvjYEDelkhfJALGfC79u?=
 =?us-ascii?Q?6YTEAfNhhAyw7b9PU65p5Z1rjab1IOK9OMGTD3s4hiQJZRFYM3jbn0fuVR2X?=
 =?us-ascii?Q?jsKfHf1/LKeUFlY2WHC8FUclctypSNjXnfiP7hx6prNiWUZxMMRXT3gPWCRk?=
 =?us-ascii?Q?bgPUBKb6Bz7+tPZBznqgky1ewCpjZkfru4a3wjUjp+5N6bwWqgteHpLU1uh3?=
 =?us-ascii?Q?h1Lw+TaFJ8KA1JJkROUcQ2xiJggHNEKTI21yQ0yJ1+ddrpewE7k3t5NqFC/m?=
 =?us-ascii?Q?dPSaqmnDYP/jTdr6FZUZySE9afJyO0g7VxzG/H+/QtcRH91bE6yyK74jVQzm?=
 =?us-ascii?Q?alnP0rNp467HGSARNKS3XbF/rTBv4AkK0FpbweKkP1+klGq8rt93CTGn0WWQ?=
 =?us-ascii?Q?8JBagvKOBFJWgBgBg02zNd0S0sI+L+OLVu2YZMH80zPU0cEWXZbwa8yceUeD?=
 =?us-ascii?Q?Kt0JgADeZITUMnMi95M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caebcc04-99c8-49c6-903c-08d9fadc9600
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 17:05:56.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tj0ShMoIxhahtlcr8z3wVeHvMs+s8CCzL93GnPWeQ5sak9E9AtfpIgiRpD3j7Tsy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3862
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 25, 2022 at 01:57:46PM -0600, Bob Pearson wrote:
>  int __rxe_add_ref(struct rxe_pool_elem *elem)
> @@ -262,3 +258,36 @@ int __rxe_drop_ref(struct rxe_pool_elem *elem)
>  	return kref_put_lock_irqsave(&elem->ref_cnt, rxe_elem_release,
>  			&pool->xa.xa_lock);

Also can't touch the xa_lock to do stuff like this,

> +int __rxe_drop_wait(struct rxe_pool_elem *elem)

I think I would call this something else since it it basically unconditionally
frees the memory.

> +{
> +	struct rxe_pool *pool = elem->pool;
> +	static int timeout = RXE_POOL_TIMEOUT;
> +	int ret;
> +
> +	__rxe_drop_ref(elem);

> +	if (timeout) {
> +		ret = wait_for_completion_timeout(&elem->complete, timeout);
> +		if (!ret) {
> +			pr_warn("Timed out waiting for %s#%d\n",
> +				pool->name + 4, elem->index);

This is a WARN_ON event, kernel is broken, and you should leak the
memory rather than cause memory corruption.

> +			if (++pool->timeouts == RXE_MAX_POOL_TIMEOUTS) {
> +				timeout = 0;
> +				pr_warn("Reached max %s timeouts.\n",
> +					pool->name + 4);
> +			}

Why?

> +		}
> +	}
> +
> +	if (pool->cleanup)
> +		pool->cleanup(elem);
> +
> +	if (pool->flags & RXE_POOL_ALLOC)
> +		kfree(elem->obj);
> +
> +	atomic_dec(&pool->num_elem);
> +
> +	return ret;

And we return a failure code but freed the memory? This shouldn't fail

But the idea is right..

Jason
