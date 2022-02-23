Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34F74C1C47
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 20:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiBWTcf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 14:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbiBWTce (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 14:32:34 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA89F48884
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 11:32:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwVWmrLaGFizJfV/O9O5r1e/qlAIumsjQxV4hs0uBM0N7GRKSPkIVSEKslz1RAvixBwLHr1MPXaMUJwc5sA7jIxP1umHVr2l1GtBWPI9fi2NEajrKAiZMDp6i0UGpAI4M7uZQvzDWJk/ngfZ8FikJY5Xik1okBKidrio3QQOOR4HsrDN8qlksOTIgt4jGzU/Wqg1/n/vgt04fUC09p4l0/30tB1dS6G3vq+gLRk37s108pZEpDoH1N9r62pLVS14gPW+UeZ0w3+N5oKNHrLExqWCxXB1Fc61o9PoV705FS28ziijXbRpp0G9DPOrpaVacoM7H5x7EGGQ9sPQHxxpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U97jPLoiUiJ10JS6y4u56pVaXi4HZJ5RwpTOvoK21qA=;
 b=QYtyiRILVT8rN3fM8JEzjSuX+HZO58jYQSeRNAV1hlGexU8mcc2/Iaqvdz1C1+M5gE+QXGuXNv0yIvllNm60DN5VloXNsS/4AbyVpXT7uT5Z139+oPzA6nFSjfVVMP4LXHVv6bdronrR3H8xa8fOObJ05JxAqTGRHjyP6EVJQ6byYFKYSoQORRU6MxxUg/TWuB6ENoDqjzesQSzx8i9xAfqtwRJrEByoIh4yfZmEEiPtuQM69+My0H4LJrQIPi+9HpySYvMq5Ng5TvNBzhSQTkAHJnWAkYUh0202ewnmPCvmTzeKlzzfdHOs/MJCyR0CdUMuRWQKMcBjioSwqwU6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U97jPLoiUiJ10JS6y4u56pVaXi4HZJ5RwpTOvoK21qA=;
 b=DEto8y2lHEfupL02OAnKw2nfPfJIuvCQjFczhupvk+bOWuWLqzrdHT7AHkyigD8hhtqnHquyKQCBMZg0PJycUGyUGOEAoQzasHQ7lzNHL2mhsh7Pcz3DEqD0gz52dGjQDA5sPBPyWEK7T02pHZdDrCWZZy49VrDJv/82ym/vF+y29a4qfUJ8bRLBcPE0Ml6z8xn4DRFd35OgQQ8kG4QIWyuMTGdAbn+zr8HG4Ss0jli2L2xtkw5PCDeJDNiWhbl6yP6L01xh6q5dNs+B47Jy98ZPBbux3BqpWCvlEIjoQpZaz4lI++uw3DvQV+rHoJCQhbF2H0FvXnu4s+IjCuEeNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Wed, 23 Feb
 2022 19:32:04 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 19:32:04 +0000
Date:   Wed, 23 Feb 2022 15:32:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH 1/1] RDMA/irdma: Make irdma_create_mg_ctx return a void
Message-ID: <20220223193202.GA419090@nvidia.com>
References: <20220217181938.3798530-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217181938.3798530-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: BL1PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d01f063a-7ed7-4584-8e1c-08d9f7032bb8
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB23790361D92322B20814F4F8C23C9@MW2PR12MB2379.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wt1BtrOoYQJIg+R0gWLYRD31HB2kc30QYOe3L83fyR1xtJoio2B4OArspZPrBmz6bfPzTivMCfUrMLJk/pJfjJ4nkOcBQFKfv4UZ0xRcgm+rA8TD7bQi6+bj85p/yBllVmr2K142DttIiVLNitEwM92gVo9EwOHWQpvTkjdPYJQBb4FehrsWIxQJ2qlCHq+UvZDVbBRN8ynQ2OU2nU02YgCYgPLWuz0DkALNYu20MCPZE3JN9AOmVUxcOUcvkikyAmpA/iH0DkxAHXvh6GlKkkm+DnxNqFs63Y/imsPsvLAhssLaj9KsKusbJImOxkgAvgGhE/xtUNGoPa7ms1HaHHXv6NoN2fQubmaQJ9MW9t2aqXgqqN8sdi10O8V2H+Vyf5+qiA56Yulk5vdwJcWeCbLdupdXqlDmY2Kf9H+2xLKBvspiXqNyJ5JEXQy5yVIPbS+JNJrX5bK+RKeM5FMHnRttSbH7ymbRieCpnlIw7X0J8L/o9sA9cIGJ6v0oJcBvgwUnGf0+M96Xfc9tX6s0IdZgrf3PqAc7nQ38BHpZwwxgJ4cf6mY6ZF+6bjnLChlDa7sWjE3eJPwjCp/TgGGhEc2SRMaS3v6WjeYunj72vAf9fwpuPf2G4uczojhZfwkzT++onOg8u+NMDNxsteX+UBR1NUPace2h13UnsvrK3GjuAXKEUdj+A0VqKmd/BunIo6y1146PJK7qqKN4juVs1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(508600001)(83380400001)(4744005)(6486002)(8936002)(2906002)(33656002)(5660300002)(8676002)(66476007)(6916009)(38100700002)(186003)(86362001)(66556008)(66946007)(26005)(316002)(36756003)(6512007)(4326008)(2616005)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pyp9UHwDks9MbPRwOX1agXRc1jcXGnqKazxc4b9Jeb3/6ethkmFYub4exj5P?=
 =?us-ascii?Q?LLaDz1rs9KkvP8hnPLhO0GvDews00BJC40JZM3hw4qav1LgXbFYOR5De35SG?=
 =?us-ascii?Q?x2ENcO2Vt5FRTjvE61SUpMPn8bUkf9pjNtXR+Cav0OTjVccKaaRd3Egpe215?=
 =?us-ascii?Q?Me+ii8NXU4/TLGJgF4AwUifjzSfSnhcP7sXxXERWV3LX3z047l/5DK66oRvr?=
 =?us-ascii?Q?nK04nEqtDbpJ0rOfmN8KLp6pv3VZqqnS4RZhpLgXMHB2Syo9OtL4qDLdiZ0/?=
 =?us-ascii?Q?+Uw8gDUq24AcMEoRZInxxoTOGGi1o0/oB5jrYa+a/CUQ/WlZmiOmIw/Pe+wz?=
 =?us-ascii?Q?l1JRyO5KtYiBBgtgj6Ci28hMAzD61XMxeMvWwx8zEl1XGF38XrSN/mzGZU+c?=
 =?us-ascii?Q?Qo2pYLTZAHw1cvKu9JtXnwAcSff+XfTqzFJUqTqeu/GKa+U8AlnKuy+9A97p?=
 =?us-ascii?Q?+tJrCxa/6EQWA24h+2jHHf8GxbdM/6MOgrXagRmOeUMTep5KxSAtT8/Ob+oD?=
 =?us-ascii?Q?KHtB16tp0N7rajUTHdZfQS6LbJzOjg2s2LGpVx+V/UDTh4uRep4z0+OLIPgH?=
 =?us-ascii?Q?pWJu71O0RSYW6K4KJPOW8NYn6jWZfZ9+L91nzpjKwPamXfHc2Z6p77fk9O59?=
 =?us-ascii?Q?Ef83t3dUZEfPTt9e9QW3oazj2DoIemt4V+WOhnwkuV3UbxFj3GtfjMYOYG+q?=
 =?us-ascii?Q?qvc+Uhfg6Z8YKHnGMrWvaou9Oe5GZGkTg4ZG8VPF/AkGDxacN8miHc6NSfxL?=
 =?us-ascii?Q?WyezKjSHjJ74RlCOIxQg4HxhOS60kR5TtALNzNLKc8UqSkN5yJJLq44EHgWm?=
 =?us-ascii?Q?NKbbujbmBXO21wqYNE0Q+B+aVAZDtZktkeAbZb9z47LUtF1FZNxiLjM3QQdy?=
 =?us-ascii?Q?Q6JTbR5ZAucfH4ujejju6BZlFQLRXas82ntXMMYUmItWALMWVzXgVIxBJyyy?=
 =?us-ascii?Q?4Tk/PUBqM4XX51NVCHUAnz+CfpmIgN6hNQY+iXm34uXrE3Lt5o/dDdhiHcAy?=
 =?us-ascii?Q?CuJedXrYNT/TshSHvJ8pf9EZzp6Ycg5qMdMHcWgK1yUNsHyYvSFCHXK9TFoY?=
 =?us-ascii?Q?gDaFgUAign7oCyWTERnK7AflHV2pD5XuvNNeKRKbOnHdZtVS4VKlUQxQDXah?=
 =?us-ascii?Q?+pQxEtqSQonZMqc6ChU+HjMKEdH2dvEU4M3OudQ7wueWIKWNRFK661H+b6Q+?=
 =?us-ascii?Q?DIOQznpmt9Okp6rnMGlE7N8xfpS1d/Sch1XFX8XHezaiQEbeLgWaKsxhHcI8?=
 =?us-ascii?Q?/NSZbK1RZChQQ+NJT5q0tiPLINl0SXPmCSRfgO+yq4ZAOp/4TjOyx75UWPzq?=
 =?us-ascii?Q?DYbpd4lUbFNRNsXnNfLQoaUo8gVfp3up+C4D/AHa1QOffC5vUfq0lzxoM6C4?=
 =?us-ascii?Q?S8poFXRqKUJoWMgdYdyVFNIGjV1TlB1B+guqta589Zt7NSk7vTj7bf5yGlDA?=
 =?us-ascii?Q?5GBda8NV8Iqx804CGchNOOZV/hv+KykJdV4OSpVnx1yWQiOABMpJBbUFTPB4?=
 =?us-ascii?Q?hZleLzKc9srflPVLvQCYp9QrD3fr+GjHLmhd6s5Lw8anjzezmboZPO4Q9r2k?=
 =?us-ascii?Q?1IldVjMAVxj4Q81EI9w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01f063a-7ed7-4584-8e1c-08d9f7032bb8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 19:32:04.1831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMI1f33iMfnETEauGbzrJoBZ6YR3rEW0C3ooTnjCwjRoWx/WPcer5v3rZX9cfgsp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2379
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 17, 2022 at 01:19:38PM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The function irdma_create_mg_ctx always returns 0,
> so make it void and delete the return value check.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/uda.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

This doesn't apply please rebase it to commit 2322d17abf0a
("RDMA/irdma: Remove excess error variables")

Jason
