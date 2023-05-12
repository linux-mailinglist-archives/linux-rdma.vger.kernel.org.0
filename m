Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BF9701161
	for <lists+linux-rdma@lfdr.de>; Fri, 12 May 2023 23:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjELVdv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 May 2023 17:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbjELVdu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 May 2023 17:33:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00350E66
        for <linux-rdma@vger.kernel.org>; Fri, 12 May 2023 14:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYmukOJkmJ9brKqTX0HE0YhHKHuRLP9RDBfmhPKzXSqHdkeG3gtHjefF9HD6uQuxrIzTgo6o08KMQS/sUAjBCHsneK0IwhvsW+9ek6NVItodwSDAZuWdjOnJ8rl5zOY/vMDn76RGRE4OwNtIfxc1EnfgYjBCP0BsD32iTahRqH1J7eKcEMErWKEq7YiXnTT1nElBqWpACC2iIwtnaql9DxV9BSsidn8Njt6pE+Utdw5fP+BDOpSmunCdOjfklk6dqSSO+KGIUw2FtwNGgEJ7ewXbK2PZuZq/zXUxfl6c204F0YnP5lQTCgpVmgZrZzAPqmo0OPlM8uv8LJJ+INbAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/D5HdiQ4Wjbq0/V7K07vlh4sODJeGDiCjxd/MBvAgtE=;
 b=XQ3koaemV92THRPo0ZyqBtv1rO/hbU/CAYRxtLQBrJ8mjULCjYksGiv0/bMNcLm6Zr8YEjuTD84pwPd8iYP4MIjVJCeUDt+uj8JN4JwAUUmuwDDoDBVcPOg9vrdHMZv0Uy6cCsGlfuIOnj1+S/BqXV5hu6TtTbuI59NVpCALc8VOudbEP5TprLhmE6/pmY0wRvl0RGNImQZYBrRB+hoKvY4Ze7e8lqHl7mZlUUl0RlU10XsH9XciyCUG6mDjPUx+WgHglvh4p0R9vMlw5BGTeFa/QrQ5O6qeaPPhf2Pf8SnsNcFT7Cd1V2sXHwZBMMZP5i3IF7ysT8o+Npx1OdYeHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D5HdiQ4Wjbq0/V7K07vlh4sODJeGDiCjxd/MBvAgtE=;
 b=NNxHLbG+yvNe0nAErHsNs0Pf8xEexis8vUnnjx4XCLc5vD8TW4EBzdtnxpHFVEqdMQEMhogxvVXEuYr6XD0bMpoG24c6vM4MKeLP6mPrkLxyuUmG3UTa9ILItgjCNezgsH80YqWmPNJfO+enzxMLa4Ulwe7zRcq9bV2US5y2zHi8D2hXy5JMmX2QsoRFl2tieKTdgmSj2z0xwu0OfxQejYkU7Y5A3oEn3GB+/RZYcrHXGldG48sI1qseEIau7+Vude3Zj+eL8FXNRTv306BqEeDHMTtKGKtRd/mQX3FQJdecHB7ShFcW267a26zOZihEnzVmwKq3EV5Umi5Kqu89Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Fri, 12 May 2023 21:32:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Fri, 12 May 2023
 21:32:45 +0000
Date:   Fri, 12 May 2023 18:32:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haoyue Xu <xuhaoyue1@hisilicon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next] MAINTAINERS: Update maintainers of HiSilicon
 RoCE
Message-ID: <ZF6wejKnbwNzkvKd@nvidia.com>
References: <20230506070604.2982542-1-xuhaoyue1@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506070604.2982542-1-xuhaoyue1@hisilicon.com>
X-ClientProxiedBy: MW4PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:303:b5::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 071b921b-ba85-41e7-a8c0-08db53306ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7npRmcPf84aS0u+Gzq2WCDdgmy/+JiaNNfbX3sORcI54HL0uyRRKkrUM7mNOYJOTEcljhuXsLKk1plZGilPDW12+3eutfV87phmXAKaxZe9twSrDNEF1Lau/P7mWYXAt9Cnlrvx9Fug/lYXMSEVr1ZVqYR9zhcKLGjhcxPnb1mENP59HRzOfWJ/lGbO+BJ0hTFK9JXQyFv34Ge68xnYFe9+8bJL6vUnnmpRC4txr7u1kxXhXeyK7Vt0yVEyaNTL6ecIuKBhCQcbHypIHAAf3bEflPolpTdKVR54h2rz2InCgehqzMWWVFmX4On/JeQgpXVslng660bQm/TPZfqNhfSdvUZDorP5YFeds1Yjo1qw6KE+w2xuVtxJOzV+2OTw3QlD/7WRayHAuYJvi/s/ho+ZlH/5lK+y160u6nhSkI8XV41qwWG/3/Pkm6a4ccURxkDK9jkw41Ds3qKcsPOdtQY/NgTSlJ8Y5MAFs4oFpCpOilQdnype/0JQ47XYDxqpcKsbNqaNf4mY1bL52x++CkW5uMC0CJqKmda0vuOAz/8F4puacjUbL5NuqsY7SNEb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199021)(36756003)(6486002)(478600001)(2616005)(83380400001)(38100700002)(6666004)(6512007)(316002)(66556008)(66946007)(66476007)(26005)(86362001)(6916009)(6506007)(5660300002)(4326008)(8676002)(41300700001)(186003)(8936002)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uvpp8OFoct0VHPCBwyadEwXlxJLkK2OAEEwTXmog6CDnEMka6aaa78Za1X2s?=
 =?us-ascii?Q?syJIansMG0zti2GoIHciFHmpTzEmF0e0rVlsjn9uEMrHZlDo9yGGUMOUObUL?=
 =?us-ascii?Q?OV0lX/j83GI8tsiMOrQC1rpk66wJ1mbudc9GtFbpXO4waf8bo9FtIwvTD7ML?=
 =?us-ascii?Q?hG3g5kAnR/jxhyBli0PUiMEojAfNbOWgPcqInP3jNU/oceewXhDZ/iWC/8qt?=
 =?us-ascii?Q?RrCsnHIM1Sy05gygHZLe2D0Igsv39+wuY4SCKSyLuvRd/ZgGQDI47sn99xPx?=
 =?us-ascii?Q?JPWr0F7MANT8kEWgjrGB8mTZZXz/z19jakbTBIZHOsuW3RUvD4CNNAT3N+cz?=
 =?us-ascii?Q?qMxH+OzgrOxu2WCSnZh3iaFI99LDsroZl+a5OZ1/sStrsmYCW1wLMLH+kWEu?=
 =?us-ascii?Q?1zBZc2uJtlQZSiOojYlnb8s649hg0Jslqtvyaa9BBUDcHmGS/mhpbWfcYQpV?=
 =?us-ascii?Q?hFN9MRC5Gajd84evbGdmnpGUu6ZKg2eA9tAo4cVK8xuZsjDLLT0kLFNLj/4D?=
 =?us-ascii?Q?uQk4UAXd0o/JsdyAGfKEUx7es45fBqFXDC4W4Z3OyBiOaJTOU2iaEsiyZZOs?=
 =?us-ascii?Q?OL5WtKGhwaR7Axwr/kg1JduzV35oUZvSHmZOj8NnuSPBjd9bHOKQVrpK6hsV?=
 =?us-ascii?Q?sBLBIq8cAj9gHldDjF49f0sjvTWgSac+tJoNuZXZRCzGo5UI49iuPa5HirZG?=
 =?us-ascii?Q?IDeMywve1cL+2TtYI3CnHycjp/ITx9k8aPUY9qAr89bHsw4cDKFpV2vaTXGu?=
 =?us-ascii?Q?U25AEVwxoLp0SdN4hbnUY9h5VYpOoSWHVE2ptrxdwwq1oXrGSijAVGDL59Vm?=
 =?us-ascii?Q?Wfi9NfwnLmzjPOynf3dqebQiumcLQJ+qK7q7QDaqrqA1gPiyBieJxRUDJ1Bc?=
 =?us-ascii?Q?jihTf8Bu+TGMsDLJInlXC4lLSLp/Os9ocfd2pN7DFP/qnWD5QQyEZ2gQkuVZ?=
 =?us-ascii?Q?lFTtBHOI/RBTwuf3QcmKrwjkhUFsu4kTYt3TRLN88eJCjXQv1ybDWH3jEun6?=
 =?us-ascii?Q?R9ROFN2LQQhd6rp/QnKKcpTyifA/+qlC3RVv9ZiZZZT3ASytIHRaRo90OXUe?=
 =?us-ascii?Q?8aGBJkCTuCmdsB5KP0qNq/JBD04RTZf1EmVLcjyUaCjiql6+m51hEea3KuAD?=
 =?us-ascii?Q?IjoAREVThzYcoECM7be5qRTp8vviZcwS3mlZyCalHUctT+69QO+4D3lrxwVg?=
 =?us-ascii?Q?kCGHOtxB65bFGWLk7QCXJuqw79yebUGyq+Ega6vw5miPxYbmne4oYKQC5ziN?=
 =?us-ascii?Q?HLrMqg662CixZEodgpY8daEczA4i1F8YxDEJRB9wp/kjDK3Ijy/peo6y1Wc7?=
 =?us-ascii?Q?HXa3412eugWRZ2VvZ1khjpANTkYHn0DvkZDCULI0rEbuB7cA+5QeFKy8/P/o?=
 =?us-ascii?Q?ZmeJGBy5VDb9oWjIeJ4H9mk58NLTijadvP6KPsq4mUokBsywOQ05mxK7Aqxv?=
 =?us-ascii?Q?tLdfotDap9SOVam9+lVShDoNMwni1CnTOwET01Dt+Iy3zJkbE3xsy+MYto4K?=
 =?us-ascii?Q?9Qn5Hfly4Kt7UeGpzHmn8nC1eP18fm7uIPJUROAlc1wW8UmqsIEeiNvKafVu?=
 =?us-ascii?Q?QEMRcpcXmfxeekD1dUQORJ3nw8WiVVU4/ZDKBwXx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071b921b-ba85-41e7-a8c0-08db53306ca5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 21:32:45.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJV7xifeviD0lS2H7eXjRpLlQNwlXq/grczgl7Nzb7xA0L4ApfNgGhmxUoricPlE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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

On Sat, May 06, 2023 at 03:06:04PM +0800, Haoyue Xu wrote:
> Wenpeng has moved to other technical areas, and Junxian will
> take over his responsibilities in maintaining this module.
> 
> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
