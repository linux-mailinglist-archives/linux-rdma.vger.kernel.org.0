Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BDB357837
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 01:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhDGXFE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 19:05:04 -0400
Received: from mail-mw2nam10on2060.outbound.protection.outlook.com ([40.107.94.60]:64544
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229712AbhDGXFE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Apr 2021 19:05:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLvmuS8EzZpSd+tovvhJC/yySfCTBWIhmHjJjCBaez4vwV/OE7CMja6htd/0JBR5k2XHmk0Av8GmCScJulTo2HOmDso3UFlwlCESc11mYo/Xqs/N3vN0BZvDRFXHIBk1RNsP6+QW9136KS8hZebIZVqcaCacroYFzjlMf19fBI5s9LVW0zqaAFrIzJLvISZeIeYxMYj/lzbMIcYTYCJwsrkRk5W4iflacMJGuQa+SThzy4tO3slqIG/tcpGuJ2cOB33bFDDm9KzV9SBSbhBc5zh1dUTSdSvY65TlntHSovm9hHFf3WbPPKIgP4wMVMLWRE9tRQswc8yT2Tk16DVQaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVuhpVJJdIufa7mEC0vVm+UYXreofNwezysZd+wlJnI=;
 b=mcAJb7NCCwTUNKm+AfMSohpD1zIPQYSfNGreYelPlIojawPDH7ub3EPk1GleSn2kR9icTrcO4mht0iNZaia4fYxcNykyLn4MsWR6bXnsm504Ggiv94+T5huvH6t+Wg0Yb6FPKak1hh3vLLDvMMEzrvkgCafmxRZxnQjy9lIt9vkCjAwO0hpsLhz5OXK5+R7wDwebPARVTEnVizcPfE3K2l90tLJGXTgRdwEVGfdZya3h1OpKbbaqGnSJoFJwdtc6PNeYlF8KFgZ0i+CsTsLVu8C5yL+MzdeMxUN985yB0pumEBq3Zp4v13YBooC7QpU+rwyBa7H9/mWazOlg0Vuujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVuhpVJJdIufa7mEC0vVm+UYXreofNwezysZd+wlJnI=;
 b=VQkb9pVGeFdEjkfGeBF63GMaFWZE7FUb3tMoFgG70pGpzpRUGCb1U2NN5ObGPzheh7YEH+d2lfnlbe7h3s23TvujMbpaeP2lqSUq6S9IcQnYdEuZUJ1qxz4qAhXgCBc/dJ3xkuXpIpio2zjn023PWkBPL6V2Pz9r8HkNRifPJrbhA8Voh+ll1vd7nNG9wOvGQYhpzgGJ1CvdInz8MwrEqBbLMf+q5KCuitChh63u2nmT4rTx3bOHlrJUlYHIoKEi4brZlpB2WhSsGbr6xNVtR/ljvdyLwe0TeakW+zQMwOixwXuvnSv1B04wczTOpWeBM9WH4hjPjhCeA8n1XgFWrQ==
Authentication-Results: chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0108.namprd12.prod.outlook.com (2603:10b6:4:58::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Wed, 7 Apr
 2021 23:04:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 23:04:53 +0000
Date:   Wed, 7 Apr 2021 20:04:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] RDMA/cxgb4: check for ipv6 address properly while
 destroying listener
Message-ID: <20210407230452.GB575861@nvidia.com>
References: <20210331135715.30072-1-bharat@chelsio.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331135715.30072-1-bharat@chelsio.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR14CA0017.namprd14.prod.outlook.com
 (2603:10b6:208:23e::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR14CA0017.namprd14.prod.outlook.com (2603:10b6:208:23e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Wed, 7 Apr 2021 23:04:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUHEC-002PqO-5M; Wed, 07 Apr 2021 20:04:52 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1579fe03-323c-44a6-1687-08d8fa198dba
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0108:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01087D559F6B7DE3579E809DC2759@DM5PR1201MB0108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dIuBXTuYjfbMiGH7jlP3XLghtKdy6byFws0izuo/6soaww4mRvM7eiN7BrVFqKZNYIDUyEkQvInsOm3ryPE9XANGtUzwLlK/YbA2G7IOrbt/0QwScacs7B1T9zfew9zWgNS72IeUxxeLLyrjax+ywZstXl1hFY5AqJCG/b58AHbFxlu+e46HnlxgPPO97L+NPnfbrxq18reze2Lt88edC1Kii97ef6UvRfb+ulwvW/fr4mjOwS147dpahwySpyz8RaoM65ZtvVJwnnWXYxLgh0MD7+8C+V/8H4Y5Fo/uFO/vnF7c90wsdVZKNf6DRly1wQxacLbbcm7t7in26lWnhoTv/aP4Bh04mTUYKggW8sp9dvJFPPc/98XwORqZ75RbUNRBQYfM3tnbOZWodT1VSCUPLfcsJf1n6dZi2a8ULJDVfRb8PQheFcRBjDIuu3b/FEgUKnhLDSMJI8ekN8J1S4PmR97uVQl+Lc09ClUKudW2FQ947UtuQPjqaShkZgtF/t4IpB96bN7MXc536czTBGvQo7J6xRMPJuPCMMQTBARkwwP3WGzXzadqVPXd3BVTFL92OyfNhGFaJ2UFjxlYKZj0SRmm/Ow+VABgD9SLlevbKeobOZYKVbqf2yF2VztVWatSU4/xv0BabVp32gXFkHqksI+rAlt0DOi+NOLwMcbr0gc4rxkbS/kVGZlVftbe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(2906002)(4744005)(4326008)(2616005)(5660300002)(36756003)(26005)(83380400001)(6916009)(66476007)(316002)(1076003)(478600001)(86362001)(186003)(9746002)(8676002)(38100700001)(66946007)(33656002)(66556008)(9786002)(426003)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vOtUjx+52+3oVXk8HiVW6CSMDDmd6j6IbRtdyxrDvmJNY59g1c5ycLOpk+LF?=
 =?us-ascii?Q?nKNfUAWOl7Su0WEyj6S/8UgLTXdPk8vYzmmwb4h1wPDuoJk9uPLfaIdfoCfs?=
 =?us-ascii?Q?EGfM5PX19b1CLW0UjZJkyTtvw4Prd117SFFc6T0Xl5muD09qLQcaJZxi0iHs?=
 =?us-ascii?Q?mnUq0XyAKPZT1nMzS/GBHaTmxxBAJjm+CLaBWxj7J7InAp8XRipHvba9Fdtn?=
 =?us-ascii?Q?8NkyE5CijwQyYEQkzizDSPcwRcvy8OYfbd5C8RVCSmaYSlfOW4TY1hTFAyX/?=
 =?us-ascii?Q?fphZn7M1zyu7QlCwtYRj/A0ZyZzakxR16sEnLPIKWIm2YXjTn5IY7wP4EIIc?=
 =?us-ascii?Q?0BbdqK4eIpUrFPtNGo/4ZW5vGTpqDYYMwuqu7PYZYu5SmIuwXk8Cd1fy/Yeb?=
 =?us-ascii?Q?OgXZqIBZ8tEo5EIFzYoEtNIf2AQPKZMnP5RF5tUcohh8QXvsXP4poUPwp61T?=
 =?us-ascii?Q?QvBjOSRP4aXst0/oi1febn7DbB1onOKHAfHNrF4+Dm2ZDIr08z65wiDsbQ9f?=
 =?us-ascii?Q?MyPngxeQrfuSu1sXOq+8EeAXRdk0sr0IzH2Mu3XBFjjNbekHNpv8c7CJUgYq?=
 =?us-ascii?Q?xSI1Mi5yGe6Nu+i2mPNKw0glyZiy2byj09xpK0NPRZnwy/44BP7NsGo4Hk/6?=
 =?us-ascii?Q?1vh6znNWq3XNm9wYIHuz1P+Pnil9VWrWBy9OVHNQ3hmaKebeuEG1Q1nFLBhi?=
 =?us-ascii?Q?9f4z1/urYRPdVwVAKIZ9aeixfkFRrH2hUeHTJTphqLsiZTBJGxjVEmOqqt+L?=
 =?us-ascii?Q?QDgKcxs/ZhLUBWB9yl90WJT2iQ8tf9YysPsUrvv+W0zaC3EulPb9n+RlGC3f?=
 =?us-ascii?Q?lqw0NsPbw/31tUUn2hAh0DDvKN3dF/W6KSj9llTVBr1n5Kd+UIWLCGOGhLAW?=
 =?us-ascii?Q?GOYx2BTlNVYD1hURVi9QQO1NXQtL8735MswO/C0Y783U8arYL5bRiKkbNA4g?=
 =?us-ascii?Q?vpj2oHSDTxHHJ65yoX1H/h8LLuOyros7JH3apk5wgtDaIFo0DBWGNtVQ48La?=
 =?us-ascii?Q?KtXzLuXYhKqM61oMnMiBUviYV8oi56sxbXcQVReGtUz0VJx9xnbUiSPg4V2a?=
 =?us-ascii?Q?MHB/XwzcDpNkt4wb5BIWzXKwdIogO38qyO3rDwDNneJrCvAOPQjya2Em9Hhr?=
 =?us-ascii?Q?XNS8rHRDOVOnImjfzxQJ9RwvhNcqj+lcK4J7NB1vviflOXSrGmFl3mexijiZ?=
 =?us-ascii?Q?el21ecoINvWTbR7SGUC9OgFCCdsPFlGPU51EdtMttviOu/RUAUZJmemSD4rP?=
 =?us-ascii?Q?R/Izw818SKuPwMG/D/0yKdySLnUqFyi8FjnBzwzOpYqOtDHOigQ3+7LJiFXv?=
 =?us-ascii?Q?rtYYvo+7S6wmh0OomyQ3bemRt9CstS2SIev4ed9WjjrMeg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1579fe03-323c-44a6-1687-08d8fa198dba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 23:04:53.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSXIxn6F6Hkr5HqBAjEukrUv5sSpP/l3OWe6Dng7bRhbS8v87wKhb2CLnHy8gN+D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0108
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 31, 2021 at 07:27:15PM +0530, Potnuri Bharat Teja wrote:
> ipv6 bit is wrongly set by commit '3408be145a5d' which causes fatal adapter
> lookup engine errors for ipv4 connections while destroying listener.
> Current patch properly checks the local address for ipv6 and fixes the
> blunder introduced by commit '3408be145a5d'.
> 
> Fixes: 3408be145a5d ("RDMA/cxgb4: Fix adapter LE hash errors while destroying ipv6 listening server")
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
