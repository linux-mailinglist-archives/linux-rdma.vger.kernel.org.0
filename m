Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6A64ADE76
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 17:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349436AbiBHQlA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 11:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiBHQlA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 11:41:00 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF30C061576
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 08:40:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAfLw/kCEobE/ky92pC88aHQZZi5jszPdvvohRxHXAxmupJD7vky9mMC7pUh6fTTQ2itg1p84/u9Y+DkYRIDfmLGU+mNShevpV40+bMhskyZRtRn9nOx3L6NvcsJdiNKWVqSmZBTtXTWDo/OmsZuz7aEqAmguIiAJP5JlzeML+at0tCJ3Sjq4iZWBn4PHJ85qQHwhbhYLfeazSM3nFc8l58rh8gl0kZR3q+LEQ4l6DS0Ygomir6aJZEm9pnofj62CxCdNVjHctIisv3C/FkrXPJNxwi2Uh2qZMYAbkXY579xTiNXSY5Gy2xZiUY675S5vYqDtneGtF80C/J7E3H9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pnn66oniSzRZUO+pZloW+yu255eX7zkrDi0fPzCNXUY=;
 b=IDqjWmt5egPmWbAD2umE6seRfcL+2KDoWqsJOTs8/XCaDNPhn+Zs+RJL4E3mr+qX7gMifOOGzFrqqW23adJRQYyjbPzMYJTKLCqwypiN2hE839nUYftYb9V4UQE2TCpurwdCNA1wR0CR294fHbHUcyw2UETh4cGLssRbqrhzkFAUMcTVV4EAf9ff+XGYRCzbQfFJpBeNb8sFQPrHL5niZasSVq3Cp+cJTi7CIn3chfSSjrMEhFakGHR6TEIFs0rNRO7fAT8PqDxYxV1Ino0J5zuIqo4B2HqgHTJDPC4iW5WzzfjfTicjv45JZQvAiqYCm++hffyh1e8f3EtdMN3O7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pnn66oniSzRZUO+pZloW+yu255eX7zkrDi0fPzCNXUY=;
 b=Qbgsr7N10C7w9J+eR+XUNRQGhHpOE0znzK2vpODC//bz22FcV4GZKiKHjiOR1zms49iPy90S1GjoZ1Zrd0SD+kg7+YQ9xT4dOHGGpAm7WUUYGNP8lad3GgL7MXirJEFd6VgMjsFaoel6i7zkOdfxfMWNscwewhtToOblzqdIjR2w1ilg/AL8Ua3trEs1fM41xLiIPOlWm9z2XH+Zd2MWv3/+H3WZJi7u7SgOgoawJYzitp+3jkDBs1a+hYsdAW06gsqgxCoGco+vfSgangyCptRZHsC+pdyK75cocbV5nOAoqg4QZKzW8I2N3xtp/oLFnBYaif1LcIJEPDZtBQgfAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1483.namprd12.prod.outlook.com (2603:10b6:4:d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Tue, 8 Feb 2022 16:40:58 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 16:40:58 +0000
Date:   Tue, 8 Feb 2022 12:40:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev,
        rpearsonhpe@gmail.com
Subject: Re: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
Message-ID: <20220208164057.GA179927@nvidia.com>
References: <20211229034438.1854908-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229034438.1854908-1-yangx.jy@fujitsu.com>
X-ClientProxiedBy: MN2PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:208:fc::40) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1284f1d-573d-4b50-9091-08d9eb21c881
X-MS-TrafficTypeDiagnostic: DM5PR12MB1483:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1483179C48584A714637EB1EC22D9@DM5PR12MB1483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmgVxvq1gIT/4FjCUJjg85LLJSSsUgvGgrWxZQro8faO29U8SNgdPYZX6LwFOKK8IX8b8D+eSRau3hYAZpwdDU89f/h/b9GmuGaCyqcGXWcvG3n4N5wvm3Wq5Tcr1obRBNPcy9XNXgix8wY17zRhfu5A4B7QBqT3OvYzBp1HmS4QCOZNznsF/rNh/zZ5jI0RJlGSG1XVx48a5AejHesrBUzJzWfss9Bk2ojEIwgpG2N5qOUZrQMHqUBqmgj73sL/ts/ycOfF2McjuJ4KxcgXFtnG5aJDtlSM7bfXXO8rv9X1ndxoXdUTKBkB9TeKE8fsDnMCIk6t/0mSdwKgB8S7ZpZSlA8IlFU2BIOMnWj7ssfy7drfU+3SjBQxCkpBpeqBLEJNH80/JjIWa2U+ksSi0GVqoB4sKebWj4ljmsjchvRcorSEwBVnx2S2vpgYVNvl57d6gV9yEwQmL7wea6IfY66ygsPTBrqRTp0kVIO/YzEsFfBydG0+7rLpX6Y4QFeQWSwZr3361J2fwU6MfqcetYqPajAOCq1+G5NKKLeVhFl1Q51XD9nx2um2gHS+XoBYRIHjx8EMRr5lyymLSrrNqAGfCEL2cgXJItQUuYTq/ynFm+8L/My4XAaGNhtPSLrDMKMUKcZP6krW3G9OlZqeO0CLzlXcKZuxr/6COAGatRKETGMc9MBUBjtO/EgGYeOFkkbCbZvjV8LG/vEfGlRI9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(45080400002)(4744005)(2616005)(36756003)(1076003)(6506007)(83380400001)(6512007)(66476007)(66556008)(8676002)(8936002)(38100700002)(33656002)(316002)(6486002)(2906002)(508600001)(4326008)(66946007)(86362001)(5660300002)(6916009)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i0kfnBP00VzzEAF8gNaLEONImy135A9VJl6YwazieXLmACIelsNEc8xIAUSy?=
 =?us-ascii?Q?OksE1lkt+gDYRoKk8qmx1Rujyxp6eAHuWlAhljdrlPjYzWDBI5QR0VWJvVO5?=
 =?us-ascii?Q?zTZZwCtE2w3wEhckgI5lgxT+sYMpI/EED1CtiQNemzaJfeQoD7K6xZ2ZxoQ3?=
 =?us-ascii?Q?dia+gxaT5l4w1xFfAEuGMP6ajrfrkN+oDGoMUUYsSrpZcgIKMa23w4nzW4d0?=
 =?us-ascii?Q?abOe868TLMt6AcUv8EcdBNdkTIRhW0Tlw9NFm86q2cOc2U3sGy43WRaa28PZ?=
 =?us-ascii?Q?RKLveYldOkyiq9Zwxxiwevpx4wW8ncpe1iDRFbFqgmI7xMrN9ohc0wofpgaP?=
 =?us-ascii?Q?WMlTcfUaQEMNHYlNzy5zJuGt55X9GZMu5kUh9luH43hpOmzDcxqInwLEWdtm?=
 =?us-ascii?Q?iwJCrt9K1Zy0Jj+jsLiWsFNQlEuwZX7jyK/NyLtGEWifq525IebeChdE+q82?=
 =?us-ascii?Q?RvO7LBfZWCN6ALPWCCU9KG9PPTjqTZxA6YBZU6XEJGn42+8kI5ys90ArhJia?=
 =?us-ascii?Q?8GMtnuMLuOPsxeMeLyiy/awYFEQ0T2mIbOPdhZe3EaouJdQIvOaQmdSQ6u7y?=
 =?us-ascii?Q?AdpjYYMypGKDboLiwhyvoghF7A8yY2KFSScZqSMUxi11kAYFV7WyFPx/Fyae?=
 =?us-ascii?Q?NXJPbwLq2A2aI0z9CWaaP2IfP+M05ByNuW/IczsUdZ47rPtAOyMvjLAp68RK?=
 =?us-ascii?Q?bM7EdRyl9tkdJl07+eDBzOBRfXxyI/dG3WO9mwgJTjXzEcauZ/mqDwvgBDlB?=
 =?us-ascii?Q?MA7USzB/Dxh9uWDT9B18/kUj+Z3GwhzX66KCY9SFyL1QUbwzP/ZGQd70sYqh?=
 =?us-ascii?Q?WPX2nIRYSR0ARoXz+MwzoOkhG1SZQ3xm2h4P650t4/LR3xu4YlSqZl99w1Fy?=
 =?us-ascii?Q?2N+ri2+3wU61vJ+WBpK/F9AzOlHukw9ckZkRVewp/F6tdF/uISmqhQIgO429?=
 =?us-ascii?Q?FS716t7N7YztBJzli6DInh5rikK3NsnCQz/k5c9oDgvad87sl5jA38mVdj/H?=
 =?us-ascii?Q?+KM72ABu1YvPGHvZKuaCc1QdyWtXvcG2aoBVShnYPXxbh1lCvWrWQj9TRSL/?=
 =?us-ascii?Q?zDUdsSC0lCMhAD/AZ+QxWMyDnAQYWbOWHgC6lnaibbMH3jLFaBIhaUWUl0MR?=
 =?us-ascii?Q?t+UgTUoTR0xE+foflKGAJNaszkUNt48alTCBTQGk9lh8D0cWOlcbUDj5uge0?=
 =?us-ascii?Q?DpTswnrUj5JGQjNJxCZjvGK8qYbaOLAy3wddisdt4WgmSsOKD+zHVxueYton?=
 =?us-ascii?Q?m95Vp6rIWbMvWwgwP3vU812P+NLjyuJ1xA5qolFASV1MZ8u6UDgiLdSpXoSk?=
 =?us-ascii?Q?0V1N9HoBM0+O5zZqZZc6KNVJLv5oj8ewKmu64RShMcq6CewT97rtdOjA443f?=
 =?us-ascii?Q?5ySf/imN3A0GoV8R70VOQW+cfqB5Z0QmbPdAM1G9ttcSoW0QnLMadjhqK7uC?=
 =?us-ascii?Q?AyBoiEPgT/E6wMXPhs00DrVTRfiPVrkVHVdiqoqbQ0wJDPKVJ7zmYaS+KReX?=
 =?us-ascii?Q?enJec5xPRlnClkatIMshkkFSuKgQzOyBGeD/TegUtD8H84c74r8d5uwVaCmm?=
 =?us-ascii?Q?jQ+TMPCUeqDUEbH6XBw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1284f1d-573d-4b50-9091-08d9eb21c881
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 16:40:58.1737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJ1UAsJH/LTFtlnH3iJHxd1pdGNMbGGtAbQgVIFxnyM8MZpz3S5DubXi2hs35y6X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1483
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 29, 2021 at 11:44:38AM +0800, Xiao Yang wrote:
> It's wrong to check the last packet by RXE_COMP_MASK because the flag
> is to indicate if responder needs to generate a completion.
> 
> Fixes: 9fcd67d1772c ("IB/rxe: increment msn only when completing a request")
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
