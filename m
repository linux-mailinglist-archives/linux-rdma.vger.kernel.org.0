Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893D735788F
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 01:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhDGXcF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 19:32:05 -0400
Received: from mail-mw2nam12on2056.outbound.protection.outlook.com ([40.107.244.56]:9569
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbhDGXcE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Apr 2021 19:32:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvkU4tQ8Bk1zV22W25q8b3/0BwRipiz0wKxD7lBwy6zKdWIxR1h8sG9pRj3Lq9iI9SlarVMDxmGBgnzbCvWWUC96inazjtWeGEMYBweIhSI4mC0XgiUoS2uk6e0m8e+aP67Ip1LsXUOgFVMX8bQm+a1OMPw6/aZzpS4EWgWsS5imhgRziN5WNL/TYyHVpWa4SUVsWN1r9FFinf4e8jbMzrz46901iZkGLDXPDq/CL/cJ3KPCAQKu+qPTAdEEtevTyTHhP/hgNwNk3nAdtdImgfzJayOAk8A+V9Lv2x92izgC3TiAEAMNuth5EV32+zDeucHJ49fPvuiKoBZF/fn7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PT6wZFIQfAyPs0YX9ADKjbsaZ6B9hyZxt2mcf+wOS8=;
 b=JI0pMH19pIfZAWy7SuncmAYD3eGJoNUvUr/dCLNL08+O5qg4lkRdXS/wwIpLfFGlssYh0zPlEhsFER5BDhBj1HOv4brfHyWZITFyYXwQ7hb4eXuJFvJxQTrJJdaLHDPfKi92blzD7YDjUgGzUfWydMfik/VcagI3OpXeGXOsRj36ikeLp8PAYy61r4WLCgXXRNLonG7N4idvor12Dh7iMrlD8PlRxz/RcRJ9fW5kVU00r0ZB8b+LlJt/L8TtpM21JuaYM5AUeRxCZkwiTOES5lNp13bTMoeci4MelgkeeYKU0FGYAO+1qNZYIAWpDetPjj1UmI4VBxs0qosc2ysyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PT6wZFIQfAyPs0YX9ADKjbsaZ6B9hyZxt2mcf+wOS8=;
 b=ba2BDGB+HPdl4aLCZHaxCb4Olz8ctM7roW2mV+Wk367V+Ai8osNZWnDnj+K4+G9NpRk8Gqwx9suaM7vJFgQ1qGCSa8jyCS7AC6uRVJL+Q1qxC9FUxSp8nXRGEL5KxyXibhuUOUya8LqYfDSUZ/K1Lo578BBsNjy6kV1+TEQkdX9Gp/tTQJMJozP8RInQCDT0bJi4KQ+aV1xwzu9cn4s5t5aSoHZNGzosN821QJN38w9zhR2ErBy9bGUaeZ72lu0TlUXIPaKc+tuzUJlp1QNPhjj+2se4d/svDsXbzOGkg+ZDRpVKvDvT5s9iN1YKVr5U7XGTWDA0/SkTDeZVvwGjmA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1547.namprd12.prod.outlook.com (2603:10b6:4:c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32; Wed, 7 Apr 2021 23:31:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 23:31:53 +0000
Date:   Wed, 7 Apr 2021 20:31:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/core: Make the wc status prompt message
 clearer
Message-ID: <20210407233152.GB605674@nvidia.com>
References: <1617698772-13871-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617698772-13871-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR19CA0067.namprd19.prod.outlook.com
 (2603:10b6:208:19b::44) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR19CA0067.namprd19.prod.outlook.com (2603:10b6:208:19b::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 23:31:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUHeK-002XZp-1H; Wed, 07 Apr 2021 20:31:52 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 818b2653-8a2e-45db-a932-08d8fa1d5345
X-MS-TrafficTypeDiagnostic: DM5PR12MB1547:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1547D50554149D88F87CA1F5C2759@DM5PR12MB1547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRR0a2vUQx2+RXD8zONP8drN2Oj5qMUkTK2guu+ee8nOykgnbQB8OyWU33ew9IJwroVYACEjrUdPo+rf+zMyHPmsJ6tC3jUuzhe7UAO70V2j3bmROK8VXobsxRhYdEg/y3CAKfJPsLMCse/8TN0j8ys6HoTZNFStcYTeXdxlID4xlTerIQpaY5/opTjVPZKme3+bAm1w35jOX3nzs7ju43kHfZzr+Co4YPiv74oL0/oauHi5Vf8vw2/57FmJ9MYCwNJ8J8bum0O2hw4wQoFvUzdBpZJ77hKbtzt9zuXKcEKbYywj14mrniqmd02FZV8SK7pfA1SlA+pKvzlYeuVEKkB2n36vQkckASXr4VIsReZs5OiEm8H7TLREXO0uvToNEx13W9fQp1JZeKnKhFDBP98bdqTihaPpSYidGCM7Xv1XOXZFErA5YSsFHyTBFi+nMn67CRvqcy0QOqvX7SfLLxZIbIBg1MLDXh2ORXVIvPyJBYDZhePEzkBDPZ/5HZyt05qPM6u/pfOXXbgVo70Cup/vU/D9ZjoytJ6gqjYws1EbYv5lAfi9cMJfntx9VY7qVeXjw2UnNXfr9BZYKqeogN6bbtYzws2kQocNe700awOZyH+R6OW5bbo+pdCcoeRQdF0ICV94aVVr8fiKL4ywdEOWHY2CNZjE7oOcF2CNAtJJPNUKgzOwQy0lVlfelGwG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(26005)(83380400001)(9746002)(9786002)(1076003)(8936002)(66556008)(66946007)(66476007)(478600001)(86362001)(6916009)(4326008)(4744005)(186003)(5660300002)(8676002)(2616005)(15650500001)(2906002)(38100700001)(316002)(36756003)(33656002)(426003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6iur/BzIlUrXynsGyOq19biAkI3gzNoH2TybQNKo8K+wDjoWYYqdcE8dKU5m?=
 =?us-ascii?Q?1VjTnZ66aIzm7cURGqgfmmiV9qJG0yR+c564nPCUg/fa/NoJEvoE7C7d3Gks?=
 =?us-ascii?Q?WWy0tKsKJGgZULHAL3zK3mEjQYynFs/VVurdKYp69R6tpY2C52TRPb1T+2oJ?=
 =?us-ascii?Q?IBYpgvpAqAQHQLX/eIkH4L07f/eEWH3JaNaqTNSlsMgRAhVgiALoWUUjRGNF?=
 =?us-ascii?Q?sCojUq3vDg2mid+4c6CGposY7HiG+8r7ZImO5XVLTQ4OAPCGups5Z6DhN2dL?=
 =?us-ascii?Q?9TadXeeaxsR7lRcDanuvJm930ObnkGJV6fee4GfK6cO6xK/axktuvk2yM0u2?=
 =?us-ascii?Q?o8+7KlxtXuCwUJJFlNFW9lQM905SegTT/JhWaykrPmFlgNR+/w2zDAx7iaLc?=
 =?us-ascii?Q?SnFEP+5uQuBW+BnxHTuKIAgipSXn9Q7D3ZRMM+4b5XR8+1NlzUhcnAKHIKs4?=
 =?us-ascii?Q?cpJfSH7yBrMv0j9gpVxwrGpVNCOxaj0j2C5TWcKCcqGGt8163WZM0Bve73rV?=
 =?us-ascii?Q?TO+xxMefzBuG3OnqTQjOcoHZGSY8sdtzv0aUxx+z+hHnCR4eNXdzeKKk7bls?=
 =?us-ascii?Q?aNB+/SRz+fLZ/anBPYj/fSJmu5c8scPwChb6qrbJgj2F4iOLwyXZ3wlp6IfD?=
 =?us-ascii?Q?1+dAHHB30LPc+ETubynCa4VZQ9nUg3603iFbIFgjPyxz8aZHB7zM8kT4xE4g?=
 =?us-ascii?Q?fFBON6Ii6jFwaDwJHVfUYzVYexvvXwUmsrJqVU5ImyaMMZ8o7diZWFd+vQVs?=
 =?us-ascii?Q?SLlSPFUY9LWXypV9/83ZCdniEsfmShou6gnYO5kZ076qnjcCySiIZC5tqb3z?=
 =?us-ascii?Q?ysOOnhiekZgawt0QcH01JbF8BfZ8Z97rwCEavQxTgt4kDhwuMUlYVohsiP36?=
 =?us-ascii?Q?BprOH1me/sp0Yz2zt52f8+Y6Cc3hEWPeIHR5AMCKRX3L8/67zVQAv/Zonwb5?=
 =?us-ascii?Q?dh1JMuhWAFtnkPZnjiHvGRHP6OXGxgk/kDNAt1HMpuekwgtaHUcK0V0gL4MP?=
 =?us-ascii?Q?M6GJwNrcbeRMQ4jjARsIWkE26JG4nfFPSqEh+cDBzvHxq7oE807vrobjdER9?=
 =?us-ascii?Q?2nMXMrhn3l9ubSXaRJG6pGCKE0E0SK2jNJGe2LqYspvsJ0UIV8sCJvddA9D0?=
 =?us-ascii?Q?we1nAGxXKpG8Ug5Jw/QX8QP+P243VsmqvpbeO2dtI3LnWBkCWOYKowHrLOzO?=
 =?us-ascii?Q?EweO2lzQADW5xjFLcM5DdVBYgdWxyYKNR2zTsVxYN+X2EzwCoNwYSMh66/b0?=
 =?us-ascii?Q?5Qg0EMr1gf5h9NnqmQPTLY+vQu8shJQqtrVfrhC7LxlORRW+YneGNpmzXI/d?=
 =?us-ascii?Q?YmfYueQ6cyL1Ir3lhBmM90acPz1A/YyFHJ3NvC6L+Hmvjw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818b2653-8a2e-45db-a932-08d8fa1d5345
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 23:31:53.2893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YbYddHLoX59iu6GZ3xPk/nKMcR++a812443xPw8w/wox9bGdsQrwENDUqsQPMsX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1547
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 04:46:12PM +0800, Weihang Li wrote:
> From: Yixian Liu <liuyixian@huawei.com>
> 
> Local invalidate is also a kind of memory management operation, not only
> memory bind operation. Furthermore, as invalidate operations include local
> and remote, add prefix to the prompt message to make it clearer.
> 
> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/core/verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
