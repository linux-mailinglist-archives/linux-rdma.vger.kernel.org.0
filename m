Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE3C250B2E
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 23:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgHXV4P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 17:56:15 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7938 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXV4O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 17:56:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4437070000>; Mon, 24 Aug 2020 14:54:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 14:56:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 24 Aug 2020 14:56:14 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 21:56:13 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 24 Aug 2020 21:56:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsrCuGBwSGDbkWETKT/Cbbua0tnh6xpfIY4OyT6UnpzW9vJ6cVDRSmG0s3L7CRf398TF0rXe8NvkktekiwPXPAPC6j7ZB0tGF4W648hFvUwtmRYJLpWIFUxqRYUFX9AzhJDmdBK+yht5nKX73yPMIjXh2VDSH0G8EWVV+JE6IzspycixwsNqFdeWObB3yxi/oPk37ljDz4xel/M5o5q8plXHYeSv49MC10AjPBvW5GkNYRONVjUuxG/mmpx3cfZBky3NOX2Ik0UQGiQu47mTu31l+gV4NYcXX1/ITlX3yv+/fUbP1VNTuTqc2pAVvqmN0n+8jwsqQtSSuJoCxe9Bdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClQ32pWGpPRhixBN9lq2v3zeFxVbpDV/TSA7DpbzTGI=;
 b=KS6mNTBnAYGYMdPfaspeazedMMuQU4lbequ9ydz/yV1cKgAWtIDqSmXr0pOK/narXt7hcHftbXgnyONN0Ng5rYkLBf0tEsIBVCi2aPzzFTRgW+qwcbC0hKhB+8/Rvo0JD6t657Go1FnTEOVvUp/oyYXrzCchLmD4nvTT1h2io+8yIzdgMvqoLmbfWMT9EeR1EB3d/E3/rHpiCCAHbCN5DDOXak5UrSIen3SjuozjLsOBrELUnSzkslr9wxBK7EGGS4yUYQwLPrR4JhDdP0FMPGrn9PqykaCX69Ke1p2UhEKZDpHjeEm7KTflJIY/8d5uWtRIW2i5+f73DScKg7oCEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 21:56:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 21:56:12 +0000
Date:   Mon, 24 Aug 2020 18:56:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] IB CM tracepoints
Message-ID: <20200824215611.GM1152540@nvidia.com>
References: <159767229823.2968.6482101365744305238.stgit@klimt.1015granger.net>
 <20200824174213.GA3256703@nvidia.com>
 <5C1EC1AC-8385-4E08-9C4A-97B04AF3763B@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5C1EC1AC-8385-4E08-9C4A-97B04AF3763B@oracle.com>
X-ClientProxiedBy: BL0PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:207:3c::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:207:3c::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 21:56:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAKRn-00E06c-4d; Mon, 24 Aug 2020 18:56:11 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19d9132a-1d47-498d-5535-08d848788453
X-MS-TrafficTypeDiagnostic: DM6PR12MB3305:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3305F789282CA52EA4B11542C2560@DM6PR12MB3305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKtPEeaH4av0DWJYVfmZo7UCneMPobql3u2jwysbLae6MZrhEq4Vy1IllIHwK4YTerv13g7f4/UYaASR6hDrvUiy3tdjitug8ABeVl3Hmou3HwVZ0LHhaVCy4nX71PFYyNkAxQghr/rLKe2xHzcXNNCsCCFm8YV+HO6RG8pg3QUyAZSZuWWlQPbnJOhNnzJn5czHEoTMJ9QNq2Pkc9fhX/DLCyDI1/4xw8NIiMk/JDgIaQ+qblVsJN8oB8UT9wBn/QPncm5KItWvArdCJ0QrWKwdaS7z6VAwPi1orX43odU7N2mlAYFHv6Tg+KQh09St
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(2616005)(8676002)(8936002)(426003)(6916009)(478600001)(66556008)(53546011)(66946007)(66476007)(5660300002)(9786002)(83380400001)(9746002)(36756003)(86362001)(1076003)(26005)(186003)(316002)(33656002)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VeZzGnFab1tg/Q1xoQ223zpyFl5FmWj1eneLDVqEi1ff65JXfA9XdCC8T1wPdN7TW8XlTnbi50Fdu5rZV6GC020H8hu/5zAqRsF2mj0ODewB91vPlrn/IFS9BfHzId6b+L5ApYIInN8N3WHl1LoAkQk9JjaK1o9kPA6OYw5rOlZZ+eGy3JYSXJWikQSPSvrSwgjxFw/wy8DpBfZXXugxx8JfauWncSxT1OPqSrPcy0ULXBTuap1AF8abi8Z5T/5TBXcAg9YDp1RcfqixAiZE/4lzvFHZLYL0oRWhe0t/DFeObKpX0GYO3WuezXYaDd0bL8LVhNZUNa/ZoJscCtDITwq0x53GhhtWdtQ9MUbd8kQai4QH+t0jNnj7EU62yrXEsTNRpMPmXkTONgBunD2si67RCBVFF2jcT+EpzQ3EfDv+64U+PNEF/fzGqPLURw14N99wK35BRV5c3kaKLgkVoQ6zTXymFtrH8hmcYP0dJQVtRcW1yhCgeW/ZZ6P8qAk7z4BgCKlv9bq21I05cWatcKZBK8kEWTtaOku+fhef14dEE33E2S7cRxjVAj1fGzHJ5W0M7ZEpkkb42fKVk88T1KDF/OCB0/1vi338P+bqKEIPjLc6MtCpKO7jc1O3JMOY5sceWzoai2nc0WoUieiIdQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d9132a-1d47-498d-5535-08d848788453
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 21:56:12.8872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMjAv4O3z0rZqnmL4quhdzNYbEsqu1Fz7ZEo8uwst9vJOeVXTzg9LE+Fxq9N/XXY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3305
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598306055; bh=ClQ32pWGpPRhixBN9lq2v3zeFxVbpDV/TSA7DpbzTGI=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=fjDfOu5j/aVzjCmZaNzPJrNiUTPu6VSRnBDpLY5FnGdooZ4d4bqNvSE1yOwqcdcFY
         Rn49OOoZyEukbS8erNKQnZr9iodf8AX4cQ0ZFh2pbko/7MHyVzR97Fky106ky6AS8W
         Z00LcxLa6WISB31RNAkYDqLCxUOAw2ihgV38w6gVwGpTJ4C3Jk6fGQKpyj5/x6i8YX
         X39o10/Tr5aQ2EM7SivHDUvdUHGHXuFnf6mzdnQ02y3WmpU2btsAfrN9VhtHOECygE
         lws0ERmc8GQU+aH/u+EqngOVH+U7XT7DTrsf2IoOTf1FyWHlw3b2Khjg2qcI3GQTG5
         sasg+goeXW6hg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 24, 2020 at 02:24:40PM -0400, Chuck Lever wrote:
> 
> 
> > On Aug 24, 2020, at 1:42 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Mon, Aug 17, 2020 at 09:53:05AM -0400, Chuck Lever wrote:
> >> Oracle has an interest in a common observability infrastructure in
> >> the RDMA core and ULPs. Introduce static tracepoints that can also
> >> be used as hooks for eBPF scripts, replacing infrastructure that
> >> is based on printk. This takes the same approach as tracepoints
> >> added recently in the RDMA CM.
> >> 
> >> Change since v2:
> >> * Rebase on v5.9-rc1
> >> 
> >> Changes since RFC:
> >> * Correct spelling of example tracepoint in patch description
> >> * Newer tool chains don't care for tracepoints with the same name
> >> in different subsystems
> >> * Display ib_cm_events, not ib_events
> > 
> > Doesn't compile:
> > 
> > In file included from drivers/infiniband/core/cm_trace.h:414,
> >                 from drivers/infiniband/core/cm_trace.c:15:
> > ./include/trace/define_trace.h:95:42: fatal error: ./cm_trace.h: No such file or directory
> >   95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >      |                                          ^
> > compilation terminated.
> 
> I am not able to reproduce this failure.
> 
> gcc (GCC) 10.1.1 20200507 (Red Hat 10.1.1-1)

Yep, using gcc 10 too

Start from a clean tree?
 
> What if you edit drivers/infiniband/core/cm_trace.h and
> change the definition of TRACE_INCLUDE_PATH from "." to
> "../../drivers/infiniband/core" ?

It works

It is because ./ is relative to include/trace/define_trace.h ?
 
Jason
