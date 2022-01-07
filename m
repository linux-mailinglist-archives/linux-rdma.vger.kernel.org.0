Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4DC487790
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 13:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiAGMWt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 07:22:49 -0500
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com ([40.107.243.56]:40202
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230022AbiAGMWs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 07:22:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvxRDpon07+/qR3mu3t/o54HbK/grgwERbbQXeBMDxx+AFenq5PiCTYlE/V31gAwEg0EH4LqEHwRavxm6ORAf2xB2dGmdBtf5BvHL/qiRgtCtEydF0ap9JE5YgRuap0BJCN1GBo45hgzFWXSWabno6jOaH6HyqI+seuzIB3TNtIgQJ4sJs631bvhgpR3pd75nb/MKu2P+4N+wEb1qEOmMd4eKxDWFPGBTOgf9yDO4sOjtf44oxupp6nzZ8GLJVma+c7r0eYJhqeo84EQEPYSKcVFds44gbes44r8YNqoowO2AdRDlr/iSb/VZPSzvCnM5B5LZRnxKgkfHYBrA9hmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jk9yFTN4SREK//NqyS2rJq6sAfd03edphVJHWojVUdk=;
 b=BuSFznK8Ot8ELcylbvgs/UPL1BJouRKBBd9HT9ZuZuzy5NsBj9fAJr67nnljCQ+TVghwbE3LeR45k4+q1f5L7aaIamAHJzl3ArY9TZTKmQHhwUe8ENbFSEviPqQpDoAtJFvsCG3JNkxHhQDhM1aTswHXe9Inu0yoy4UP1yMDI160OHDpu6vTFaOR1WkbFtxXyZb798j0xoq4GAtSZweIfPXHNORzqUFnH0e0fJYmsLoahjP63QRRDOhyajHYpAKbuTSMcjgt5dXYsXOJkx9SdlwHUuJweTUKh9sVg46Dg3xT+JU4SNKAo/bgC12dd60UuX9jcWR0jI4vZ/NDZQzgRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk9yFTN4SREK//NqyS2rJq6sAfd03edphVJHWojVUdk=;
 b=a7LKV37kCEUViht4IkHyvvJpolY5Im5dCWLU7qPoCsJZ5am1Za+sne5lTEmkxBXT9HLmmL+oiOlDcOyHzhRf766VGC/fENpIIA69VVyXsMvLL1fqk3A9T/umcHmWj4g3VBGPn9tHJBCLo8y2krEl6O8EEJuCdLSHk4gVY6XnQgNz92ns5bQVt1UWR86Y6eCQepcLnCpE3CucxDlioSHesAp0xYfR3nsmy7Nak+whYUNqKtivmKrOrkV1jcTjWVqfJx85dvVQSx0AFcJm/X30M1HM32nEba+UxgZXUXugvN9wvYDEqhXlimUEHqztqX1oKQMhYZ6d9iM/2YVXA4s67w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 12:22:47 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 12:22:47 +0000
Date:   Fri, 7 Jan 2022 08:22:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Tom Talpey <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Message-ID: <20220107122244.GR2328285@nvidia.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <20211230121423.1919550-3-yangx.jy@fujitsu.com>
 <b5860ad7-5d5a-76ba-a18e-da90e8652b08@talpey.com>
 <20220105235354.GV2328285@nvidia.com>
 <61D6C9F9.10808@fujitsu.com>
 <20220106130038.GB2328285@nvidia.com>
 <61D7A23B.40905@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61D7A23B.40905@fujitsu.com>
X-ClientProxiedBy: CH2PR20CA0026.namprd20.prod.outlook.com
 (2603:10b6:610:58::36) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6f23917-aa65-438c-75fc-08d9d1d869eb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5046:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5046E8707BCF37647E900290C24D9@BL1PR12MB5046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91OlCQH96BpBFSFJTLpWtmb8KIqX3hzQHBXqvYw+VoZRMt9jz4rWQ2nlNARlthvjLxXhhTP1rV++foQH07HDik2ysaeFIXvLdzdpzBHqsct9d6Rg5wopYk+/CGJ5pCbbSpu3YXdbHLmlOVXszYnp/b9xLZGQxHzl7Faj3DRNdKxAKuV4WOYHtJdw4uXoSS8Wur7nxorhXmP+QXKvMRL3y9kTaF522o3MeIdfgVNP77GM0WCzbtlMxlOLYo2ljStX8wiH+dX24xtpVimx294ZEa0bylY4zcGSiYsJejCFBfwCIIl/jic69ipfx+9y6K30TSppU+OiKYKaFpDYSZM01E9AngD3R/JjoUZ1LPSqjb1YasQ6u7nYYMisirIfVjmMyaktOgaOlixSnHw5CLmx8FHHnqjaKkDQb99nufsv3/8Jhf3Y8pdL8WXqFdD3k+Xqtcn0/QftKe9TKl1+dz9NYfaw8zZOPU6wejRHW2/Xfzle/NdEL3LLk6jMbGM0LWLTzVMzSAQgAbIrp3AYBfqlry0roX4gkr94yPS7m0Sx2FpmWX4zY7nUfJadsCpHDfJzEkedlnYUUCFrKgn6CgDoZwxZ5OLYJ6eh5k4DZq375A4cC3V/8Y3QeuLUBsfk9fKLSuZHbEfrA92VLkaz57Q6xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(8676002)(53546011)(6506007)(6666004)(508600001)(2616005)(2906002)(4326008)(54906003)(6916009)(8936002)(316002)(36756003)(6486002)(186003)(66476007)(26005)(66946007)(66556008)(38100700002)(1076003)(5660300002)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pU+0F7k0LaWPwDTafZJAqsd8UkUh9MsAELdgW54jFdQTrYS2k6ocxNl71bWG?=
 =?us-ascii?Q?0BvR9AlJSX7reOQXVgb/JP81zETldl6oLnrS5T6NIUPqmu1cgC8ynwaAz3TG?=
 =?us-ascii?Q?YZjTJjwfG86RqT0mb5rL9yducYo1ZfKh1dy0DVlGUXcnxZvr4JyHM08iSPyT?=
 =?us-ascii?Q?ORKnWqdNVV+LVOi4GCl6zDTYxGV/KXY6VUcquFxHYSq0iJOb93s28+lMnVEW?=
 =?us-ascii?Q?vqOBfMRNpF2s2Y9Yn9djL7rNTug/MjpgF2GFoTwrpzmHhOSdcSI+Q/6pbvPV?=
 =?us-ascii?Q?KyEweKu+V7w8u9pj7TVgF2+TGvfTwOIID9fHUKp9hWyq7uhM3xxoVViM2d2s?=
 =?us-ascii?Q?MK4lGSP+VML+gozyhyH4luyuUdaQdQJTciEVnlKCniqFg/O5aOKBcd9Og22G?=
 =?us-ascii?Q?PGLwXefUWhqsNurlymngjWQSkgqvtCxcr4WrBCAZ/veNz1xclRzxIh6783MW?=
 =?us-ascii?Q?3f6TFDsSRVah46Aq8mhgfpO8b6ozMBT1d6nZkebxX6zGRYmSSBc7OhgJVDWv?=
 =?us-ascii?Q?XjPKwx0wz33v1LspTzA1nQhN85VTqOEbd3MC+1D35LwE3Lhpdc8KDvHZeqrG?=
 =?us-ascii?Q?uqCV2awvNyM3IV8ARR9bgxVCYeq+GWm0YGE0t7dgAxe/EWCgpsXIhbsnPnOH?=
 =?us-ascii?Q?1GEgI/rQ0JCp+niCPqk78pgMqpZBUqj5Yzbi91v3R/l7Nny09leA2o8ajbcW?=
 =?us-ascii?Q?C9umEcFOMVkOFkFItHvHKo32f499OPC/MKv5KdO1lRQ+qm8kYIjmmp/12cLW?=
 =?us-ascii?Q?9fGuxOj+QRN9S3YvtMoGYjYePvkUAOgRjCxtC3Kr/ElUOP80SGoMujmQPf5t?=
 =?us-ascii?Q?ZjQq69EA+GFPxTkrFFS3vqqjh1heHKylBOlGDvv74c9yA4XTcrI+9vttOKPF?=
 =?us-ascii?Q?q7SrjiftxzH7Sk+gnWEfCgnFJo86kjvXOWUKBGuHbhlUiP1IOjODHopawRRC?=
 =?us-ascii?Q?DYLtqemqgkZ2jFV2rZ6Ub2t1uoKUJorhf1Dlo8XZrJM5/1Mv29UwpRwpXnHX?=
 =?us-ascii?Q?nxCpLnn7bodCXjz264yUwrsVe2WHCtPRQHqWxQEtr48xs3PSKOTvskXBXUzb?=
 =?us-ascii?Q?XLC0pE4SMUNVRDpz5hMpHQSwucnjH+ge9dWiVayTawuFxq47kDPRHoF+lxrd?=
 =?us-ascii?Q?gTWT9KIOHNxIEUDx26IDtDAwI5wEVG5v2vFlcM6fSZ9yjiz0r3ZZyKkhJOL0?=
 =?us-ascii?Q?xslsmAT6ebqAuUBO9v5cHz2+bKHxFE1MRLoH36a0a6Fn1E9LnaJRxvOZBTsW?=
 =?us-ascii?Q?FW0TcGfUXObeSlBrd5k5TJDemoo+2o9Y2Z3IoSDq3vM64oExvBRymWvMrGUK?=
 =?us-ascii?Q?Gehnyd3RBrJVT64s8boKWUb27GwHlNWT9M/2o0K5eLAmNMHwgoCMlOQFwa93?=
 =?us-ascii?Q?TRXnf6GNehDQKAkyFOUQpvDtY5d3A8+9XrG4SvInb66uEJjwkPDpEuBL9IRU?=
 =?us-ascii?Q?Ecpf7O/uyS5StySqC++UEniSDb/Xigr1DljSGs09BYoO8Cf5dxVxEX/KQDHH?=
 =?us-ascii?Q?RKMCjBpoYQ6yhWUEVJ9pW+dTSPOdzb+QKz1CCsnYUCAgwSJI/0FC2kFNtNOr?=
 =?us-ascii?Q?jRon0xeXratJh4eTg9o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f23917-aa65-438c-75fc-08d9d1d869eb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 12:22:47.2003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Myb2RtCsPlTiMO6f9xK0ufWut/JWq+POOZNFrcWjwURF5uQ/FtKu4PGG8BynEQoY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 07, 2022 at 02:15:25AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/1/6 21:00, Jason Gunthorpe wrote:
> > On Thu, Jan 06, 2022 at 10:52:47AM +0000, yangx.jy@fujitsu.com wrote:
> >> On 2022/1/6 7:53, Jason Gunthorpe wrote:
> >>> On Thu, Dec 30, 2021 at 04:39:01PM -0500, Tom Talpey wrote:
> >>>
> >>>> Because RXE is a software provider, I believe the most natural approach
> >>>> here is to use an atomic64_set(dst, *src).
> >>> A smp_store_release() is most likely sufficient.
> >> Hi Jason, Tom
> >>
> >> Is smp_store_mb() better here? It calls WRITE_ONCE + smb_mb/barrier().
> >> I think the semantics of 'atomic write' is to do atomic write and make
> >> the 8-byte data reach the memory.
> > No, it is not 'data reach memory' it is a 'release' in that if the CPU
> > later does an 'acquire' on the written data it is guarenteed to see
> > all the preceeding writes.
> Hi Jason, Tom
> 
> Sorry for the wrong statement. I mean that the semantics of 'atomic 
> write' is to write an 8-byte value atomically and make the 8-byte value 
> visible for all CPUs.
> 'smp_store_release' makes all the preceding writes visible for all CPUs 
> before doing an atomic write. I think this guarantee should be done by 
> the preceding 'flush'.

That isn't what the spec says by my reading, and it would be a useless
primitive to allow the ATOMIC WRITE to become visible before any data
it might be guarding.

> 'smp_store_mb' does an atomic write and then makes the atomic write 
> visible for all CPUs. Subsequent 'flush' is only used to make the atomic 
> write persistent.

persistent is a different subject.

Jason
