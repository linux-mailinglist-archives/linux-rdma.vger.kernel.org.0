Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D00380A10
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 15:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhENNED (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 May 2021 09:04:03 -0400
Received: from mail-mw2nam08on2051.outbound.protection.outlook.com ([40.107.101.51]:3072
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbhENNEC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 May 2021 09:04:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRg30d0186v4vUJ3Eug008CLu/5QsEs2QWtf+rEfOTd532dLrOLP7rObrtENsVEJqOrFafkrOvDKD/h5+The7pO6SaqaBY+mumv5UYqM6qcHgKjvHkSSXiDjzPFwGxbY9G3Ui3MEd8cjvpchC95LvPTO1TOp8XGgLpBQjNV+3U1NU1kG4TN7RhecVtZN3vTELLzeOslSqTCVI/1wEMmdoqi8NvYRBq0BtA2/Ed64p8TnXQPgIo4BzOVQo6zw4gZ9roGE7pSny4hCueIY+GCqfRVxUrOW+SKn9nidIy83CLivCT4SAYI/yzsn/cKV4qyqgMDLqm4wJyLTScKgELGcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKV5yEgf7c1ZwT+cKyGz6uQZHpRwUcKUP6BQsRitoUg=;
 b=I49eXSnDyyG3sGIKbKs3y1iaW92gBzPZCfPaqmTy0x6bxdKC0fY6jo8d0RCxceeCtK1M4oU75U406CD4j/bnWeYyoMQOODQELGMpGRPiPWVw8eGTeGliXUyh/3M2yw/91tm3kyosv5D0pIovHaTKekAn5GZpyj2hjbRG2drR7a/oGaMJSs24nl9Xk4647z16Zs1bj/EUCfo0EuPXiuHjE57xylNPOME51ugfKJ6cDlUHCCjwq45+YwaguOMVbo1ebG8Wk7lnUB6QNR9PEmc6fXG2ifcAuV4bZZ2dRQzh+4wx2pudX94gysKH2UdBmuceJevpBNzTunBZ0f2S0j/U3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKV5yEgf7c1ZwT+cKyGz6uQZHpRwUcKUP6BQsRitoUg=;
 b=L6n6jRmW7euzBR1sD82OhyXoeWm0OtKJl9navW4voHrMTMi/hrbp8tfV2oJ591vnPimylfa5igu7Fa72+YEVO35Mc7b7aqJaRdigrgIYrGw/P4Ps7stAnt54iRZnOakpbwzI4Ha7AqIHkqc7SLkTOYnTr4aVnGL5O+12yyG/36cgANC1FqBcFAWoL+51syRhg4w/GXYtaUHRDkkXkJ1Nfux4iGJIDiyNpSNTb+poGqy+Q4DEm5ho5aVVJDI1O7emaQiApYEPliVuiT1tsAQXfn5DQ8sO+5Uq/JtYgBcKBFDEHSMnrERztSLyVXC+WHf0rJdiiRI2ay+EQp3EcLAuBg==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30; Fri, 14 May
 2021 13:02:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 13:02:49 +0000
Date:   Fri, 14 May 2021 10:02:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <20210514130247.GA1002214@nvidia.com>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <f72bb31b-ea93-f3c9-607f-a696eac27344@cornelisnetworks.com>
 <YJp589JwbqGvljew@unreal>
 <BYAPR01MB3816C9521A96A8BA773CF613F2529@BYAPR01MB3816.prod.exchangelabs.com>
 <YJvPDbV0VpFShidZ@unreal>
 <7e7c411b-572b-6080-e991-deb324e3d0e2@cornelisnetworks.com>
 <20210513191551.GT1002214@nvidia.com>
 <4237ab8a-a851-ecdf-ec41-4e798a2da156@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4237ab8a-a851-ecdf-ec41-4e798a2da156@cornelisnetworks.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:91::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:91::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Fri, 14 May 2021 13:02:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lhXSp-007PAW-8Q; Fri, 14 May 2021 10:02:47 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c06da7f2-e351-424f-fdf1-08d916d8932b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3306:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33065CC68649EB47FACC1DAFC2509@DM6PR12MB3306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qOBMk9kpa+vukmDSkj8ZObWRR/Z5/WgXDR2SB/HKoaSB52mkrD/N+O1/+4BpPkojOtoCHH4wbl5vFfnpOrIa6GTmm6cyjirldY2iy2z97bzrIBDBJY8LM6a+bDs7U4Kng0zpq3kr9PqvBk0h8OhmB7ALza9ArKL1iNKAUzH0n606dN+VRZiMxSSFP1LedJGiPA0SIskw64ZYzXG85splw1eSHazTzwurX/OCwITrXlk0u6dm5djpAp8D67dtG0lJOaKPZGqsP65v17hmr579FCfLOmwfCbuVHeQv5lrmrpQUW8f5baQD6JqKfkg048uLFnX3njYQKzuSqPXTOUbUaRJpweAZ9SKqU13VsOmiymSw4fI8t3KLQ0NHdWy3rD8HORkt8YI+wk0h2uwNjly9XUrjay+++5k0bk++QvzSfrY9Cqne5EIOy9mgRPl8QQfTxRgplrmHXzXb7x0Xo3kl+sTAyirh09KVMcGiGDAqjP26RirIy4G1/qc4atHvHSXzO3daL0bfC89rULyT2oevhiXH1IRzr2zaTNfY9VE3pC2V+pX0fGW9r69fCHKO1u2Vh9am6a5mWyfO0ppZGTT3BdRyIJSwYLwY5JKhArOli6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(8936002)(6916009)(4326008)(478600001)(54906003)(66946007)(66476007)(66556008)(36756003)(186003)(33656002)(316002)(426003)(86362001)(53546011)(1076003)(26005)(9746002)(5660300002)(8676002)(9786002)(38100700002)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?b0bHk1BenNCIRpY545nXWDPFwMT0OtWOxwzEsNcU0q3Ptdk95Y+MkGGbMpLo?=
 =?us-ascii?Q?BvhW+sli+tItBwpn7xgUSfxJYN8IFFtIZwdwSJSFqWrtS3Z1b/llBuVt5PBz?=
 =?us-ascii?Q?wcxuIxeamcVViOM8P+a5xqf2yVOjTTTdlnof6mD91AjComqfHEJno7vwgv4j?=
 =?us-ascii?Q?xQ/ePWPRJF9V7Fuh5pPckAtjzJ3co18EPh104VBf6FtwiZVf+Y0EvvnINMfM?=
 =?us-ascii?Q?fKTcChAXz/yVE1dWxUv1GmhJ232RkRgyK5gGqZG1DTvH/kcWuCQYq5ZQVmK3?=
 =?us-ascii?Q?EToc8Kc53MNR7o8DJwIqWAZyUHpOmzQ6X42KkMBnEr8ydUQhkoauL5KIRty8?=
 =?us-ascii?Q?7yemVG73a0wZDoJl1qeMJSrgcND6A952G78x7WUZtoqunIWyZ9XykLiigmKW?=
 =?us-ascii?Q?sDLsMG/iwdWdWIUEXM5eSQL0mj7iZnqdXULZXat1pWJPiv2SnnCsLpJOP70E?=
 =?us-ascii?Q?ZyA0gKl4Y4Vw6A69WdhIAfGL/ISSD1R9zk4Hfpx9xn6GJQinJs+F//rk1lCp?=
 =?us-ascii?Q?bVQfKLo4l6flq1kdT18zhqBPeEZQ3oQuk6p2mwzmVeSy1aLXJGCgvl2aJ7Q6?=
 =?us-ascii?Q?uycfHTym20VrV5uUReAyvlbUgrroI/sMvy3RrMZaNyXUX089GX3zX9fyea5B?=
 =?us-ascii?Q?UAMCDs2bPG9mODrg0w+8ca5hIASB+CMtt44LeFpTLchAXeDPTLEM65l57Mzr?=
 =?us-ascii?Q?16STybQocEtVM41/mL8XNHNUGG6PGA1AQfzE8Ukk4bSZfIv6+TDcNGchqojV?=
 =?us-ascii?Q?601IQYQIooKeOQ1evO1hHEUlNiWB8wsTprwrpKZS+WLCyaLcWv1RuMdwUswI?=
 =?us-ascii?Q?M4nV47YBOxgeYjKDshMRewTAcD3H3qQElm6Whp8n6RuMk3682A8hAzjp12BS?=
 =?us-ascii?Q?JnCDs/FQnFKB/HwXbjUL8hRSVlLnDEi4WClbYw76zRN8oJhsV5z5HWekPdb2?=
 =?us-ascii?Q?OrV0GCL6LgZkBlBZbvUTDWre9e5NDQmqNcmk5f1F4LtP35bMm2HfXp//Tc7h?=
 =?us-ascii?Q?aBHN/NgzhPgwIN4LPz4Wu/+SQukvjtTSASD0LOJ+yCpl50TIc2rPM5WEO2ya?=
 =?us-ascii?Q?O7IgTmzPBqFrrS84vsoofmklzqCxq6256duiCkFNX17jKFTQEzY0dsr/ET3w?=
 =?us-ascii?Q?70pH8yQCGVRezQ/nBDr2zAoOe2iVVfWykh/95yQX2z2AEusYikkgJWGQnFJw?=
 =?us-ascii?Q?PHB/q/PN8bYP7nhgDR49CQoum75SFbNqLUaFtYx4qTOAePWv5VBZsmmOKqWX?=
 =?us-ascii?Q?7RJ0cn1eJKwIJvJlF3PrTl+AlUzng4mJV0JuAgV+3OdYFJmQJXXnPkyrjwvO?=
 =?us-ascii?Q?X72clISLz1yrs1k5TzYSXiu0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06da7f2-e351-424f-fdf1-08d916d8932b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 13:02:49.1464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: va/VOR5AMgRrgkg9gsUG2BQslrWf8PUqiIFV6neyuu5DzVylg858nm0hpDmSL6x3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 13, 2021 at 03:31:48PM -0400, Dennis Dalessandro wrote:
> On 5/13/21 3:15 PM, Jason Gunthorpe wrote:
> > On Thu, May 13, 2021 at 03:03:43PM -0400, Dennis Dalessandro wrote:
> > > On 5/12/21 8:50 AM, Leon Romanovsky wrote:
> > > > On Wed, May 12, 2021 at 12:25:15PM +0000, Marciniszyn, Mike wrote:
> > > > > > > Thanks Leon, we'll get this put through our testing.
> > > > > > 
> > > > > > Thanks a lot.
> > > > > > 
> > > > > > > 
> > > > > 
> > > > > The patch as is passed all our functional testing.
> > > > 
> > > > Thanks Mike,
> > > > 
> > > > Can I ask you to perform a performance comparison between this patch and
> > > > the following?
> > > 
> > > We have years of performance data with the code the way it is. Please
> > > maintain the original functionality of the code when moving things into the
> > > core unless there is a compelling reason to change. That is not the case
> > > here.
> > 
> > Well, making the core do node allocations for metadata on every driver
> > is a pretty big thing to ask for with no data.
> 
> Can't you just make the call into the core take a flag for this? You are
> looking to make a change to key behavior without any clear reason that I can
> see for why it needs to be that way. If there is a good reason, please
> explain so we can understand.

The lifetime model of all this data is messed up, there are a bunch of
little bugs on the error paths, and we can't have a proper refcount
lifetime module when this code really wants to have it.

IMHO if hf1 has a performance need here it should chain a sub
allocation since promoting node awareness to the core code looks
not nice..

These are not supposed to be performance sensitive data structures,
they haven't even been organized for cache locality or anything.

> I would think the person authoring the patch should be responsible to prove
> their patch doesn't cause a regression.

I'm more interested in this argument as it applied to functional
regressions. Performance is always shifting around and a win for a
node specific allocation seems highly situational to me. I half wonder
if all the node allocation in this driver is just some copy and
paste.

Jason
