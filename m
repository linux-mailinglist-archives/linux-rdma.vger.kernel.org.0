Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427F9425CB9
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 21:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241180AbhJGT73 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Oct 2021 15:59:29 -0400
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:55265
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240974AbhJGT72 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 Oct 2021 15:59:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWH8q/aj9h5flk8zkTvCe6T7AxSExlX9vtBSNFzeLF9Vn+IiY9nsd+D/3YPIHrIVnMZYQJ90poGNCmMdIH+HAEAEfUn1eYYMYpxXdFFp6CkJKVfN/LMQ1u39NsdO1r/DeDT65Y2rcCsUEr9kiZ3spTLmCUSo8a0QsdQ1xZT34jbukQf4WL7Go2cyD88z7UWH0D/VP5Iq0nr3yMySQnVYFAyL1IWKnVQ7F05F62w6r7F4QhbKiTNs210308+glcFvxBTObaOsVHAAIybQ8dlsCB9cXAFXzLiTTVrMZPOzFygprM/m++Fs4+tGbBHSXe0n6DZDblILf07lbsgie3htJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4TBoDBLv74hntnv+FAjcXDRNNh74OR1YxgxaLLwyco=;
 b=k5m4UoU/Dk681B5y/czkDrujuBYS9TUHOJWLjaCq0Ol45k7Q1Sq9q8BfGhcwoi42N6xp/sAGlZsVjxI7wGNbxs2V3E+dqym7gcZmMThRv9G09x9uTlg0EuTJ3gDkO8ksL2zGqDPhL09AJpOIuSvOlKkawtxi/xxW8ciS/updpyZ1o/I/Eya/emPi6F0lOIIq4Lyc0HACNoA2zwggGDU54ppHo3G7PQ9Dyf6ZNQn0Oe4aFfMRpB9m8QQrn8rx8Uvg9rMqkyTlbjRykHUGAZVDgQwXkNYBlRMF8WLJXCjxJdF5YyBz/1VBtWrtUbzGtP8OT9rCRwZB2v77DKiI6DarDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4TBoDBLv74hntnv+FAjcXDRNNh74OR1YxgxaLLwyco=;
 b=t37K6nSSrZX3EscmpWmyo1KzSp2drodZLCrTQjyHbGXmlqjDVTAB6vzeepmlmgLQ+Gm/53dwbDXdngUy1QbQuGpDY8nL/BdTNj+8aDUeedbIBsrrsAITQxus5+XXQf579cYYET+Fa6lrVpPPaKeHdf8jTqysJpoby/b69MgcZGG1wnwixKmpJ4I0wIf1ds8t6c7UYdtlCSot+oRQqcwDcCuUOa92QZ/fws2dDBF6WFc2VmpIPL3yznt0RMaNqEwXadZBgGHS+ioB7R71QCgwssNcOyDDYUOxaoitp2A9SIpQ5hWKTShZGsgCkl1NQ0O+uMRaeFHnNdkz+Y5Mzg+vhQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Thu, 7 Oct
 2021 19:57:32 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 19:57:32 +0000
Date:   Thu, 7 Oct 2021 16:57:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Rao Shoaib <Rao.Shoaib@oracle.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v5 0/6] Replace AV by AH in UD sends
Message-ID: <20211007195731.GO2744544@nvidia.com>
References: <20211006015815.28350-1-rpearsonhpe@gmail.com>
 <20211006193714.GA2760599@nvidia.com>
 <8fb347bb-81b2-2ba6-a97c-16a5db86541d@gmail.com>
 <20211006224906.GE2744544@nvidia.com>
 <086698cc-9e50-49be-aea8-7a4426f2e502@gmail.com>
 <20211007190543.GM2744544@nvidia.com>
 <5e8ff897-ca98-4dcc-a731-2bf150011fe9@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e8ff897-ca98-4dcc-a731-2bf150011fe9@gmail.com>
X-ClientProxiedBy: MN2PR11CA0010.namprd11.prod.outlook.com
 (2603:10b6:208:23b::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR11CA0010.namprd11.prod.outlook.com (2603:10b6:208:23b::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Thu, 7 Oct 2021 19:57:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mYZWF-00CI3j-90; Thu, 07 Oct 2021 16:57:31 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 030489c7-e7dd-43bc-38f6-08d989ccb352
X-MS-TrafficTypeDiagnostic: BL1PR12MB5271:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52715D70344B0338137851C1C2B19@BL1PR12MB5271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ryk9esHmZzO8RB9GemNto3ML9DJoUWF0oHSeoIXuc3EQJorrbFksKRkljtu7otuhGm4V0hM4hoAomhPJzpyjKR98rsCuA5Z/t3cx9ROAs0McGYP8Nv3oYygnHFH4viU7l4l/+/R3DKH3yjAX75RZB2a7cNiEkgIn0Z7No2NhhK5DpHCbOMNSn8oqdiI4ZX+HdsuQExlPSjekpQ66FqOMj3NsDj9o9YSz36PIR9DXVK9DAFMcuybPxcsZdJQhyIkPVo8s1DukC4//XzpoTlJr0MWlcVJOWwuLgXwEeHYGNo+UN8+jp/x4EfQ5yeeVX3l0ZDEqy46w5XWJ/5S5mdhOCWNvFNR5Ue6CKhMX0OYR/SnD4qqi0fYDSu/9XgrGMSW6lx71FAEf7xgoxAYuuNig3alRGwYWT/AyN/4Ey1MSlIxtf/nDNSoESF8Na6tNZpQvJfqxT7kP1VtY0UpzTEGhzb6uvyC6272acq1p50xi10pIuQ3piiq8K3tkScDW8DMu/kVNUPPdD7UzyISVP9Ru9NskwW1oabhe3JNfIe/n1YgfI/GYQzfhjnXNavVtayW8yBVhOZiHEaC+CE4/UA5B8wmBkRYC44oEszGVgcwmNQre/eW9D9mAaHK0bwRePclQZr6rOsiajyGlCvWAIzbQ9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(9746002)(33656002)(6916009)(1076003)(2906002)(5660300002)(54906003)(86362001)(66556008)(66476007)(8936002)(66946007)(316002)(38100700002)(426003)(186003)(2616005)(36756003)(8676002)(26005)(9786002)(53546011)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2aMf7fcnAjb4BejCIHUZLFPhq21EmivYNiQlvKl5qmHXuT+cyre1RPmAcfs6?=
 =?us-ascii?Q?0kZ+a9fhEPINto4eL0S5aJdXXT1xRqVcnrDw7kbw+6oeos1DNTHdeFDVykHe?=
 =?us-ascii?Q?XwyYnEihCrRvMAuwgdYuVKxFkqFd3GCaOoexlYPwfb8cD0E8/ggukuqaMbOh?=
 =?us-ascii?Q?PRpEFp9xBGKW5p/G6QY3DELf9SeKkR+0NQ4hLrXS+t7CCQl4LxXiUy04oXRP?=
 =?us-ascii?Q?AQD61gomwPKAIpd01OhPP2swdY6MV975wnAVBTxVOgvD4H8zK0U+SsHf3woW?=
 =?us-ascii?Q?Mk5QIVeJDsok5u/5E4mtBdS+M4ZTGXOsYgmPFLKs0WURnIS16AgWnJoz4yEy?=
 =?us-ascii?Q?J0E95hW7MDDDnEcZ/NQju55UWe/GnmBK2ys1XirDQcAyLylFH2UId6KTXTU4?=
 =?us-ascii?Q?pDmcSX9jhjF1/BnfVRr++ngQRj6Muumunn+WEZnG3BIKOspt863k2CISytaf?=
 =?us-ascii?Q?XflGh3889WAa6IyQ9IB7toxLf25CGt5l2gSOo8zhESkAq7hoxx8Nv6EnqaPc?=
 =?us-ascii?Q?Yn6nss9ThmKjtkxSSfK2tlcFg3qlPFW1UezLaGG71V/sUDA9DbjHPRkFMc9F?=
 =?us-ascii?Q?ysLtiLoxTMX+BVPyEMq5uqQLsIFEvWj4JnsujIe69tscvoxMsQNGsYrSQewb?=
 =?us-ascii?Q?DXTbBFFV5eAqgE1mIzQr+mnRNGAX96JpSs1myHFdFHpcYP3/aGmpKh9tAVqp?=
 =?us-ascii?Q?OB5EQ+M02gc0Qydl2XvdxmDFBRQPqskT2w2o6ZKeXy9dlhXZVT0i1H+lNprX?=
 =?us-ascii?Q?nFm+pCSNaHwDXy2jOCC4uw3+6V2Thf4Yne6j5V8zpNHGDF6Ai5vWdd6j6Njf?=
 =?us-ascii?Q?mX2eaZRp+tOt0832c1PDJWVK8iGvGL5/0VvSKpR9z7OTNPYIRFJDaLfIOp5e?=
 =?us-ascii?Q?IsiXt+1vDoN8vwaWyM6pJwh8y0P37SvxbYjVrz4NP5pufttidzV1Cuxq1D55?=
 =?us-ascii?Q?A2T0KZKe0zgde4EAdbVPGof6m2bFW+7E3A7VDBlssWq02GGnHm50nLNJzDd1?=
 =?us-ascii?Q?6VIb4uX3aErJPrC/QSPW/LWO3pH31OAPQSKThf0ZRavj50Iga+rDFQG7a9a9?=
 =?us-ascii?Q?3NZ9oOhtxqqxulQQLhZolG3BAS7iCKYIYM80e59yiEKTt+uNF99U63ZywX+t?=
 =?us-ascii?Q?zuaBOi83wi/rZ4VR03EYOszWpog2/Oc4q73B8b6eloPETbI4ZtZCn0NrdUd4?=
 =?us-ascii?Q?2Y4FvehcxUjbH5a5Jb54ItGQOwlNJ1xZfyPRUVqWNmriayKtU3ncLSF4Cj0/?=
 =?us-ascii?Q?9r8GVkzrkH26B7P6RMQ4RC2DBa7BPODjidX2IXOfhzUliGs7lPVtch77Cfp3?=
 =?us-ascii?Q?I8ZcMi8wu0XpXyWvX84d5sSez30WUNgoTgCfpy2d3dLa9A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030489c7-e7dd-43bc-38f6-08d989ccb352
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 19:57:32.5873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVgzB4xIQal+ZE1uP5Z0ccDRSLokB8lpoKGnf2pxNrW9qBAoSt8tCof7UXvzztDm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 07, 2021 at 02:51:11PM -0500, Bob Pearson wrote:
> On 10/7/21 2:05 PM, Jason Gunthorpe wrote:
> > On Thu, Oct 07, 2021 at 01:53:27PM -0500, Bob Pearson wrote:
> > 
> >> On looking, Rao's patch is not in for-next. Last one was
> >> January. Which branch are you looking at?
> > 
> > Oh, it is still in the wip branch, try now
> > 
> > Jason
> > 
> 
> I see the issue. Rao is asking for 2^20 objects max by default which will
> require 128KiB of memory in the index reservation bit mask for each of them.
> There are 4 indexed objects QP by qpn, SRQ by srqn, MR by rkey and MW by rkey.
> That's 512KiB of memory which seems excessive to me for many use cases where the
> number of objects is fairly small.
> 
> The bit mask is used to allocate and free the indices and there is also a red black
> tree that is used to look up objects by their index (or key if they use keys instead.)
> 
> If there is a usual way to address these kinds of issues in Linux maybe we should
> consider that.

Use an allocating xarray

But for these AV patches just fix the merge conflict to something sane
and go ahead

Jason
