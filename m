Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1F485D4B
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 01:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343858AbiAFAjZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 19:39:25 -0500
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:36065
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343879AbiAFAjY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 19:39:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agiSXfIqxkqD8irOgMI9RQgaNv52gcXWR6j+3WzSavLOZ8In/WD/8kVIvkY1ZAiT0sIEvugg92yL4Plc9GZxY5F9YfF20rSnx8Z+mfHxnJD0z19/YE9bWwM4UEScCJUh/0PesIXdF7o/dJjX/32ziDqyJPxRcyjqH/1MHBrNZi1o99ybnbeF0QBehi002rieYkNCe9NeNHqBacLU0qDWFrV15sMTl1iHZOIQyLIGUQcH/zjlDhGE+WlDr6nF6a5kBxzeLr1bnJknzFgCp/X/h/YkAlvRP/xHK8PGpbsFXV4IvBspwfGPUeg5remdgzmGiBGNmho9NjnOCgLG0QIq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZsNVQLIyLhWEWD8B5a8J2+Q23YBuLW9JMV7VmXwSIo=;
 b=Zp21DZMKQ5Q+BK+mA/QNdH0iptNpr/qwouQ4XAfnXIpAoX2MoYOT9mC9C4qI1NYibXEEbB0Zdkyi1r2hsSAab8c3xzhkbPRtD4299iQp6ht6grbg4XtM4jFziEP5j7t/L5/BznMIHXe/6JFzoKlycU/bUf/DqORdTvER/XdOfynPmd3wFlJY7j8LNryOV19Nd1sncqeQnOD/LGJ2QyIwpJF3JSk6MKhD7r9GuYbr3OrnFS+0JbF5LGAC8kVEWzJbeDx16OlvdDz7SS5PoDy60kFmRvDvNAXCDiNhq/B3ssurCyC/aOiyab23Gv8aoNpb6JoayvL/9rkenKvSKOjXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZsNVQLIyLhWEWD8B5a8J2+Q23YBuLW9JMV7VmXwSIo=;
 b=bUdMWeyns4FPF5Ip9xoygM63xfLFolugvhyAvj00krmT9FEVRCPZjsR2UYrQXhP159sV65mTFX6xIQGyTmNSWkwPIg+Sa5UC1kSeuHELuyR5BiyGbiOvR3nisUka1lPMkkcAPYaIfSxsJ516gxcCTuXbF4LIwAtfODBJONetIxqlfoeaWRMzAbtp2+8gjrRZuz3qCITnYKECL6bdNLDIK5lsDJ4qxevEBNeyFI6BdfBcz39PBows74DArKc2mRs1OMHjLrNWbMtTsGTzERUogBlZhUI6+0BJdCxBdfaewEAc0YuPSqcJzcidYqAlvAnOL5VqW4a/1aC+Fw9ghoCwXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 00:39:23 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 00:39:23 +0000
Date:   Wed, 5 Jan 2022 20:39:20 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, sagi@grimberg.me, oren@nvidia.com,
        israelr@nvidia.com, sergeygo@nvidia.com
Subject: Re: [PATCH 0/6] iSER fixes and cleanups for kernel-5.17
Message-ID: <20220106003920.GA2913115@nvidia.com>
References: <20211215135721.3662-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215135721.3662-1-mgurtovoy@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0230.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91d23d3d-89ce-44be-898b-08d9d0acfc01
X-MS-TrafficTypeDiagnostic: BL0PR12MB5539:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55399A24932B50FE7BBFCD3EC24C9@BL0PR12MB5539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L7MShLK87LiJwfv3abFiav8BDIKjHWt8oIfMHprHVn2VLWk7qKJbn4DR1FXFtk87blbkGXAT7VH5U6/N9DZvIChVqyMiJpIp2b4UeMSSUB6ELbPxbCKHjMP4ObBuxNyAc9mTBkksIy+H5VGZrSbUR2j8u9zxiHmaDsvFnUsauBopnwgQYwU9jMx++jL6BNweuqKen2AgKySqwLdvGErii97KWmJXX47k+eAiA9j2huU0/eJGRDzeZ79RtEYM24qHE70yQVi9tDCxqHpC4eSAja5+LC0aJgT1jdQfVpxK7euUZAPyo9EJHMVMa8d7MUefnYUe0QltBSiTQhlU4S+Xt6Nh3kh9PbkIfuxd+c8YsPRsOQ3HZnA+gplzQwRPvldwgHK1FEUi2Ps3kMocM6t1wDCAXRTz7bRXZ7d2eCwab12wXK+A5BNMEsXX1JdaLZ0jJ1H/2cFwgME/LfUHhs7iPhMFPMKFxNMwgvVo39yxJx4ir8pfTaLOAtk8rmhiM/yWE3PGl601Gb1DFihK59/Lut9iW9fvGZsuOt3LKR9AjYBuDZzbujSuIph5Etxuw9o1l2gb6CY7HAZ0kEGoD3ZQ03j5bi1dolDtnR8WOmBVpA++zV3hYnyyRuBLyEPUu7AIXr967IsMVrp929zrN+HGjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(2616005)(6486002)(2906002)(1076003)(86362001)(66946007)(6512007)(66476007)(66556008)(36756003)(6636002)(5660300002)(107886003)(508600001)(186003)(38100700002)(33656002)(4326008)(8676002)(6506007)(37006003)(83380400001)(8936002)(6862004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XsRhWaIbQVsLCoonlRlRN3HGlZ9IED9tUbR4Za+/La2ygc81bJlebdQi4/Vy?=
 =?us-ascii?Q?woeff/B/+Gc52v1zL4sN/NdOHLUwHYiIIQ1/aHYS5jhYjXjrZVSb1+qMlCPq?=
 =?us-ascii?Q?N2bSG9BYwHYYJ7sd2giPxB7iJSmKLfDYzG6Ddj3OqXlEM+FFS9GAqxGKxx6B?=
 =?us-ascii?Q?W3l/9NjFLtJuo9IET6JqcAIt/edf/B6/9c++c9TlAENmtwpWIngbtnwKUBjD?=
 =?us-ascii?Q?rHZ2mpjER2gdAur4+EaqNmOCgMUMA728QzI1w6Tr5TnUKz2nf1FuPyQzLwzF?=
 =?us-ascii?Q?WJmC3DgY88vVr1uAvafH2l8yLSDiOvKrkUr3os34o44NP2pokkJbRt+rhCSj?=
 =?us-ascii?Q?kzVrcg6F5EPkohHW4+23LoDi5oz1Tz8Zwl5HE5hDPKJQIUYh+4ab6I3JnmDm?=
 =?us-ascii?Q?Kaxx/riYTcZvjpJLogC9ugzHDh9YHuUj6TV444ZKRMZYm5m99vzOY4RMhuiO?=
 =?us-ascii?Q?2VIPEVJiHnptZTBXbg+HpvLPuVSXzMU6pmFGvOVANhrDWuJU2inmcHi8Tcxv?=
 =?us-ascii?Q?WvhTWiD1BotNGnmLuPoRMuqWA2QlmVc5UseSfMDjr7cMFPiilvs/QFcWJErg?=
 =?us-ascii?Q?iqG4J3Cl0o5s6w3aLtflSldLJ0/NRKgGxug4eL47WzQd2gOQqThMnmoY4qlr?=
 =?us-ascii?Q?hHx2zMz5ffsRnTLLYOJXjpomNe0afdAvj8YlpIAAZWqK5/9wB48t3xiPFzt8?=
 =?us-ascii?Q?Uxhbh0tB7w5dvqzJbd4BMSgAfNDr7IXaZr5aYYJimq4Q1sFRLvQLVWi5sR/L?=
 =?us-ascii?Q?yD3+Jy/WJJAHwLdFEj8DpcXYrZya/VCUZMwbtfQX+ixUl5+dbmTsWi8ggBnU?=
 =?us-ascii?Q?Gy0klDvk4FnXYT+huUfCGENbs3+dNZCn/Cd7o0xRnpkTJ/fKR0lT40WzCXbi?=
 =?us-ascii?Q?JkCyahIdnRqhBLNuNfGtFn7k16TOaMvJXit4RjFx4yp62jpEM6BRZ7Dxqo5b?=
 =?us-ascii?Q?rjH+YGD+Tg1HSplrBjKukVBjae9IzJ6Hfa5s9sdIj2KkTNp/pGWK1tCPLom2?=
 =?us-ascii?Q?gsee+lvzdvU5PNQ89dhmzYDARXZxLUNybf5u5KHjmMCxqgUj7TyPinDMi5aE?=
 =?us-ascii?Q?yVfZngdOZdJSeNxKc2+gzc9lDmVeh/ZxJOjddaT2ctqlwS4lTaCjxjuG9EYr?=
 =?us-ascii?Q?Tij6HMzdWu1z6NTg2qkS/WCdhch4Iu7RmJHgE04m2GRGrImJSVFxmWM7JCm8?=
 =?us-ascii?Q?VL6Ndxct+/In3q3M00OtDngBpHuRmG+3ubbW2sDofRcc628V8qASXkafhIGN?=
 =?us-ascii?Q?If3jdicb7iPfstIzUmAXxQUEpiWIPSmQLu2ayGZ8MhP1dkK7B4iXvrLgG6m3?=
 =?us-ascii?Q?r9fsnQ5iEDz/FttE+EyEjPmEdhLhxmtutyNuBGWjg9ITJ8Vf8jcMRSzlLGSm?=
 =?us-ascii?Q?hiUWZELj5Rwt+P3joPNrq7BZfRm3apYHRcT5jgii2XcYP8hGn43u9g6QoZSm?=
 =?us-ascii?Q?lz4QKQh+VyPB+k9G3Y2UK1Im6kFlFjuaU70oFwhwEa7BIoKRQUvUFETA/7dx?=
 =?us-ascii?Q?EkQ9OOzKuZiK0idyQazWjhJo75YjilebGV7xPEUy4lC6x/jM4RgI68xGZuyz?=
 =?us-ascii?Q?Uf+MTsBQ65wrIk9tsiQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d23d3d-89ce-44be-898b-08d9d0acfc01
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 00:39:23.3215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4vILkQwPNDr0uPKeV7NMF0ttfXSlv8Dbg/wLhm7i0tcws6bDikrG+nnokma3IoV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 15, 2021 at 03:57:15PM +0200, Max Gurtovoy wrote:
> Hi Jason and Sagi,
> This series is the first fixes and cleanups for iSER intiator that we
> aim for kernel-5.17 edition.
> 
> It starts with removing deprecated module parameter from ib_iser driver
> (patch 1/6).
> 
> The series continues with a patch (SergeyG) that fixes RNR messages sent
> to the target HCA since there are not enough credits/space in the receive
> queue (patch 2/6).
> 
> Patch 3/6 is a simple renaming patch.
> 
> Patch 4/6 is a preparation patch to eventually guarantee that the HCA
> will never perform an access violation when retrying a send operation
> (same as done in NVMe-oF).
> 
> Patches 5/6 and 6/6 are some cleanups and coding style fixes to help
> maintaining the driver.
> 
> Max Gurtovoy (5):
>   IB/iser: remove deprecated pi_guard module param
>   IB/iser: rename ib_ret local variable
>   IB/iser: don't suppress send completions
>   IB/iser: remove un-needed casting to/from void pointer
>   IB/iser: align coding style accross driver
> 
> Sergey Gorenko (1):
>   IB/iser: fix RNR errors

Applied to for-next, thanks

Jason
