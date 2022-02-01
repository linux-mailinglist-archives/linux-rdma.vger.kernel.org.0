Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CED64A5E17
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Feb 2022 15:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiBAOS7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Feb 2022 09:18:59 -0500
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com ([40.107.244.61]:63456
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239002AbiBAOS7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Feb 2022 09:18:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fik+IBNj6RIR5GENyRbSb47iK4rvjkFrCR9NwGmzO6ofrvgCotgQoHDx6yffBUFeYtYQQ6hgqN30X+9YYKPiNW/gjiZjfROdX+z0RczpQM51fKUZPeRv9Y4uN287tytRqEVyrnGGTm0GLZXFzLBtCVnenJSQ0G7HoqSWSPLcUkGcL1KOb9VeaiHJ/XvEUJHHa8NZxoVyvO/7kw2pwsYtNKLFFqVGSEo7cIrFTWEJBvIZXs5IklvN7+5T7BRyMhZY4F8WGm3FLXIwTKqPlMGrGXUBlFbyBxsrI8VDD/yeBxQ2mX5+yufC903Ky26yNlp+hPagIz61pSqA/CNzc7mvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5R3qBbaUNwsbpP4V8949O80UXLNpJCielT3N2vk/YQ=;
 b=JLgGRj5VpdHehuH/QzG+UO3nSpI6rQrMgU+A+y2NJQE5tn23LAOoTaDZKfnLIjtCAG6vGF80YCrb3MNUoyrB061+x5lQzvRVMgFEhiDLlAisGKY3bwlrb3nu0Wd9LBRtWHCdRyzJea7duIQrNC4LCyG5U3uTdGR7Pl+RLwjvAOaD+MLL3poaTGzcHnSH0IHGR25LWxKhlHOJ5/WQJRzx7wEqCishuR7yqXbOR+Kh5LTW4VS2jaye9QHdtHYo8an6gdATc44HIZpew+koAy5Ms/uFu105SHvOm5Stqq/gXYV3yzFN/VwETQ+VdCiEbY8kPLRYhc92CwaTvunj90RT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5R3qBbaUNwsbpP4V8949O80UXLNpJCielT3N2vk/YQ=;
 b=mV7VUnVOu1Jo/AeBpVxWGmdlETblKW8kvO2FEEiNT2vz7AIWyLZDBt6FwqiA9zrC7Q1Y9i09zBUTtOJntdPpviSwe5jBxTAxoyYEaHe3wUAemxdZT8extZFJnKgHIevO3hi944VnRB/ibvg5Im2KzXst6g+Er7DUC7cs9eJQZTwFcpxZJ9rF/Fe5xeX0Rxkth6Eb4l0jaOFya1gqcUP3niUbSsdsmqFnb2bg84p5rgpnJrdwhWaQMiaGgTYsxIjkbAWZ54txpy6r/tJR3/th+wQlhrA7s5xeQtAAvmLOtWyDrs8rvA7bVK7Dby1+WAHePB6NpPKOIxY1EG6II8K6HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR1201MB2506.namprd12.prod.outlook.com (2603:10b6:3:e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Tue, 1 Feb
 2022 14:18:57 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 14:18:57 +0000
Date:   Tue, 1 Feb 2022 10:18:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org,
        jared.holzman@excelero.com
Subject: Re: [PATCH] RDMA/siw: Fix broken RDMA Read Fence/Resume logic.
Message-ID: <20220201141855.GA2426447@nvidia.com>
References: <20220130170815.1940-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130170815.1940-1-bmt@zurich.ibm.com>
X-ClientProxiedBy: MN2PR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::40) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f985ee77-c121-4c67-3b91-08d9e58dc88f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2506:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25066108F9129286F27021B7C2269@DM5PR1201MB2506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAmQ8sXn7h2edpY5pirL4YOZNFwAOtBsvpGDS5jG+9GLEn5hpgDEQfi9EyKHG+FkD8xEvyRtpold6e/x5t0OplD8EGWIPRjnHpLmGwxEEkpnKRqF1X0N7+tMaAvWVtvQBbvQKdOmuoIghiWM4wt16DrxWaWV5hzQ7kdvRIE9tF6PRp+zWFrJYd5hSIGZuxMiazYpPPLCEJemmd2vOHFGu8SROot6e6VAFsqUEe+nX3k17Jdh/85BnbpYlbcwCYXG+WuNh8wCqKFVcxw7EeLU/tSWpOl5Iert2FDa+U8LXQeU2+UZ5DbL1DwdXRLdhuLDmWAIHgxOQBMbYFqxzqTBIhbJvTatNnf4fLHelrh3gCuojgVDdzKQN7uWoBohKrckk09f7VrP9phOV2ngu3DjIag6isQqdc86UTy8qZ9cDD9TlSfOFPuT2PEIsh/m3APdlXewQq6SUKYw9eP8wLsVJwYURZT7vDhhlQP8Dy48q6+vYNZH47JTxYby7MANKtOynhoWYrt8w5ZX+uakMQeIpR+Tia7BN45iPXyR3njz7m1LPd59qqGGOvKozfj+BUdUwoTqCNF7Ld0xtOof6dB7IebyJ0E/UQEYM35X3uoXHJyElGYP+GKyV6p9kjg70J7S6Myr9yrzxN+/4xoFv7suog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(8676002)(33656002)(66946007)(4326008)(6512007)(66476007)(86362001)(6506007)(66556008)(83380400001)(1076003)(38100700002)(508600001)(6916009)(2616005)(186003)(6486002)(36756003)(5660300002)(4744005)(26005)(316002)(2906002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F2qJd4t18ahAfO4Tk5y7b0rTnCx8rQ2lSDPhjQYFMM7orvAXSMYam/EVoMJX?=
 =?us-ascii?Q?acfEnlu9tQvmqi/Gc/olipfT3OTYDHVVEfPRA+KYIn0zAyKZkD0Mza8YHCmM?=
 =?us-ascii?Q?HSGJC+eFKOLU2W/gSrzwWgphqdL61f8vMR8xGL+NkOWcPCU3/kFFPndNQ6jc?=
 =?us-ascii?Q?zWhe8gOQUq+er5nhckvULrL4pDOSkiJx/1HO86QjR6G1w62qkTsk6gfpQxFz?=
 =?us-ascii?Q?laKZHgwQiwMd9g5jWn6lKoj5t+2N+/71t1krdjwLfa7etX5B0auVH5FnKRCO?=
 =?us-ascii?Q?YWMVPSt/Lr9SkZ4+SCGgBjaRaR5rxV9dfVssMaAA0Ja2ouiXMoErwpcuwg/J?=
 =?us-ascii?Q?Z6av6kZDpT02hCXH+g3J0hQQc4DdZBRIDKLbvIAoLAsnPOG+5+OSyFjFGtv9?=
 =?us-ascii?Q?z+OfqbFg8UaAqhXyM663ZW/MYLkn1M2Am4Tr0TopwHwaGUzRDQQqoiPbs4HN?=
 =?us-ascii?Q?2dD+wW5LN8evdPdZUj1Hgurg7YHOaF1V51Qx+byfIkt0qbYB/XDnJci8wlzM?=
 =?us-ascii?Q?JLIsxSwAWI0oLmikYiJf7TOCujVFYQBIPc7dnKs8SjUgECpyUJd4cF98Itot?=
 =?us-ascii?Q?RzWgBFFTkNaimbxeIPlz6jCPJM26PDb0W9y406tpQczXmo7WKspEGdprdvxX?=
 =?us-ascii?Q?LjFMks23ILJtQ1cl6qfhAOqBxIHU+Hb5Gnuzb9HqB3LQoQnWBT2YcMiGvoNe?=
 =?us-ascii?Q?FIPkm1XKs4990VZczrRQDFnRwJo9LbfJs8kcrR68QL49tNR8KEFnGTVAxWq7?=
 =?us-ascii?Q?1M4+rroZmieZzBnTghzcsO2KcNicPx6orUDKUPU9U53KGBSLqyuzFB1Ost/z?=
 =?us-ascii?Q?V0tubHiKyxdWelsnXWJNB92TKUG74JO76DevIvpBK72yUYbKPa+h/cOIdFut?=
 =?us-ascii?Q?qV7oba6zWggyru/7PsE9LfdHZxB9ca4u/TAaLExxg9FVd15m0i7yyW0zyzmh?=
 =?us-ascii?Q?j92QwAXGn1f9fiDvDnINMRwXAC9NVpfIVl6iiZugP2RLY7ZAP6eogtenGFsc?=
 =?us-ascii?Q?XpEGnjHl+VbSIEC8WycptgiD4aqaY7ukMmPViIIAJLbQczNzV4gd/OyMOJKe?=
 =?us-ascii?Q?63tga01HxOFf8yyzJfkxrUJkEyu8eqVBqdLElaMX931dn1W3/n+P0TJOhDWx?=
 =?us-ascii?Q?AMdbvMPV3R6PHEzA5d/g9XnfuFHgld1bT4vjkEodjXtaXIirCbenNH+8uNn0?=
 =?us-ascii?Q?dSgdQivq2s+I8MFPb2JhGc9XjwpYizCK7aQqEazjR6osfZ+pVKdbO6eGhyFy?=
 =?us-ascii?Q?UXlYV8oZCFVieVdC4RpZ1ky4GWN1GGG0DIpS5IaqLsABWFpbEYX329Xneaf2?=
 =?us-ascii?Q?u9MqE0EFoV7nuZ/7C0e3JEB1uoYDBStnS3nFWwmnKE4aOOYCS59us1ANCaAU?=
 =?us-ascii?Q?xnR1cFw1I6OrLZl5gi7vSI0WEbA7CnINhYzW5x3DBAWCmIFgTeuJ7341c1Ba?=
 =?us-ascii?Q?rgDOLZNxYdmzni5OVaDYV2IhA80mGt2tJdQtLKXPEGNjFhFcFAopF2w7d914?=
 =?us-ascii?Q?IW3qcnxPY69kOPfJJjvVoMo3TCyaQF5qZcjnbvCtlG6kpZ6Q+lVK1aekYY67?=
 =?us-ascii?Q?j9RPG+K4uAjFzhBK21g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f985ee77-c121-4c67-3b91-08d9e58dc88f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 14:18:56.9646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5CyVY/61+IKeaBTPpA3czDi2O+z6e/7pXAHTC/S95J1DMs9WGcrhuc2v+y9Jgj7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2506
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 30, 2022 at 06:08:15PM +0100, Bernard Metzler wrote:
> Code unconditionally resumed fenced SQ processing after next RDMA
> Read completion, even if other RDMA Read responses are still
> outstanding, or ORQ is full. Also adds comments for better readability
> of fence processing, and removes orq_get_tail() helper, which is not
> needed anymore.
> 
> Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
> Fixes: a531975279f3 ("rdma/siw: main include file")
> Reported-by: Jared Holzman <jared.holzman@excelero.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw.h       |  7 +------
>  drivers/infiniband/sw/siw/siw_qp_rx.c | 20 +++++++++++---------
>  2 files changed, 12 insertions(+), 15 deletions(-)

Applied to for-rc, thanks

Jason
