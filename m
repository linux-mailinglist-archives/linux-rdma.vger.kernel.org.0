Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E4649FC82
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 16:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiA1PMF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 10:12:05 -0500
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com ([40.107.92.44]:17523
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231818AbiA1PME (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 10:12:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fz0hEsTHutY9vYEphzD37rkvlCAG3+i/KvFp4VJxeeB+Lc0jCejGSaO4qcs9qiTTbR52NjWRXfV8DDNPWMkgbgIZiPA9V9tbpv0pXfMVJjcJz/GWvLVcaRww/r70V19vzhTCYWdgDwYslIP/vHf6ao6N5DNLbhyagF9WB7ZY8AGDOenIKr0hB/OHCtazYOeiY06//iESbhvyZhYeRRU2qS6bOyI3lzlaNkO9Rer8HRfVYhOHYu+rrGA/sO8YQQmTwv1rm01r4Bls3O+61KCC3yngEM9wxLH+E8DBGsibDFa5FcQRC87nrF4zY/DFZRNVsJwAZTfGw9h9QiNq38n2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93ihQfmt+6Zj1k8HE6g8ntPoba92UlAJ0CRT+eUX6JM=;
 b=T4sPtKSTTTuPLdzl4Tz+iaysDkIzoTzhB5XW34fnXgqOYEZEdta9d+vizDOOxHrl3G7O6fBwWWO85shqiqWiRR9sfgDJv8fJePaMhTRU4CYHi+FhmarP5kakysMKMEmNOLOiZ/kwbsufFXzMLnyKUSQqeDBBh2GU+H05yxNxInENUO2hF74FNTorpGgk7mwKYILC/RGyWAfjSTUTV/WkI3n6+EsT4oON940uLJ5ul6c3V9PL6Uyvn9z7m/RQK2Ig42f02noUlBB1mc1dMofo7JlHVsNIGOxhO+DGEm+hWoKJuX+RnaRGlf6iuddOSvH+62dod/5CD+TKlvXnKRfjog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93ihQfmt+6Zj1k8HE6g8ntPoba92UlAJ0CRT+eUX6JM=;
 b=erh/ZAIkycJip4IwSI5oX62yFBywWkny0qX89f3Suw1BGwQB8GeDf5Np4BPZN7Z105aR8MRyjsmhZTUwTnX3sfeffpxphFlo+5FAZ0rvMnN86k53HsJOIP23SQgdU0VAsrXuHGLNYAaeylaskXIUPwboMe46w7tBa+exvHJ5zhf63HPVx71jkkmcU5P6N8PoDI4hMiZq/JpPWQJfYiXxAnjA++pwU2AIu8v8AWcFHs6odm+VEtoHuukgAKwplEZxqlCv7cRxh3TMrVpTR4lKaDJi38yr2Pj+O2nCMdJs5zzNpX6LpMr+feNwmc24leDQqXnsZ/JvrK2DLprM7En1Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR1201MB0215.namprd12.prod.outlook.com (2603:10b6:910:1d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Fri, 28 Jan
 2022 15:12:02 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 15:12:01 +0000
Date:   Fri, 28 Jan 2022 11:12:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     mike.marciniszyn@cornelisnetworks.com
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 0/4] AIP panic and hardening fixes
Message-ID: <20220128151200.GA1833098@nvidia.com>
References: <1642287756-182313-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642287756-182313-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
X-ClientProxiedBy: BL1PR13CA0387.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afe95261-e802-4290-75ff-08d9e270893f
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0215:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02157511343724AD150B9316C2229@CY4PR1201MB0215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wme3Io7om5rw5IS3WYO1I7Uncx20s53DTKiTvUPEzvbVe4Pb3xD0E/Ymq8e4QOnJDAzjQ4p5ULiorSlHLSibM2o8J0l8QVF/G988BiIleKleGRDyxi/PqA8UU6gZaCFDHBx2r6gVCo/+Lvm+S3zvdn2pVSgxydlBwJnbDFRK5ziRjFqYhlCMSmnSA92+gZMWDjK8CuhIhkR1jLu4RnoE4o05Xte7h1KVJkyKWirtwbcqXlhSy1opilctZ6w/VB1JlkYaCOumls49neC5OpbSiuiK3xpE0zHnNlVgjO7hHSyzsd2LwpC5C84eEL6yvMpQuc/Pg2fvSTHMHOnhOMVpa8mhyNhMD5lV7ljWhD4GDkDluda6wgIop9TdSWG+CW3C7pPX4y4q3dWjwRjmMVUFu3pnk6Yf6hnVwTcdf3NbSt41M3IxIbCUI3L5hQgHAMjxyl+mUeubbQ5FC0opOrrOkuZyl5Md4izAUXWJDaY+J4UtPgGDX9PCYHBihFFyjfonkb+A71jTD6kCKCjnTOqWU+eObx0NgisLW2l3MJjSYbUmqLka+4pxaJ9TBVyCO8/hACkx6xMvKk+r2Ggy+HbyVJ4q9eBTDznuzsF+0kIlZQHbhJ+CZHLcZxGFfHJAbfMgyTFPXn349H0saTHB77G87g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(83380400001)(33656002)(5660300002)(38100700002)(6506007)(66946007)(8676002)(6916009)(66556008)(508600001)(4744005)(6486002)(6512007)(2906002)(8936002)(26005)(186003)(4326008)(66476007)(86362001)(316002)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8ItNRo0An7dUoj0EvyMsavCpJ7ULPOj6Yjhp8d974vK679xTJMbRxEdIi6B?=
 =?us-ascii?Q?qa8RglL9KXljSzOpm6KT70DWzvwec+DMq6ypCwbGbnED9VrYKhnAEiMDV0+D?=
 =?us-ascii?Q?bgm56FqvjTdtIbR17yRZWtQhX41nmTjFn0QPgw1uYEAGGWyNP8JGaCXIFqGQ?=
 =?us-ascii?Q?urRb0iJ+uXpMa7aC7CctKgu13Rj4TEu2K4ccII/3GoXwm2z7FBkFQWEpqrUR?=
 =?us-ascii?Q?or066Ni59bu+BE7siAJ+zGM5S7C6pvKPf9hxMaNGxeOzQvXUlsyKhDWFNNRj?=
 =?us-ascii?Q?OpZWGl+d1c4R+5njYxP6i7oc2X55A7U30kjQusXigA68+9nwMrKVY4kFqcv+?=
 =?us-ascii?Q?s9dHnqOoykjzHjc+KpFOzHAw1jsikIWRE5vS/4bsdqFPB3eIl68w0jTM0CLm?=
 =?us-ascii?Q?vwSdt5HEW+l49+B16jLt3Z43cUFtSUTdS3ZXY6aIa70tlQipf/08CpQ6sZ7k?=
 =?us-ascii?Q?NN7feKau9T+mBX+4astbvdjsBtwXbyxOW7pkaM66x0lNSRQxqEPVpvNhwV0F?=
 =?us-ascii?Q?lEYo9r+OlSb6EaVG4AM05hnLmKW3zDFtbM2u8HfLnFzce9jL75Sh1/emFeUm?=
 =?us-ascii?Q?zV5ahRODq0QlD2xDz0UCbew4CGA7OVEwo2XzTMvJqTs/Djozbh/kZ4RpG4VS?=
 =?us-ascii?Q?Au9DLxkdSKqNbKUUcj/nBsF9E3kaWmZMndDGbdFeC1y6FAYfLvPKxgqCSp93?=
 =?us-ascii?Q?MKUzn+AuhBoPdODgMZEIxmwQ47XikG8+p+5OnErGIkK5NLGqz7PHgRsaecbi?=
 =?us-ascii?Q?TiW//w8o6AgDbnSnOTF7nnnDemWrYMMvvCFBKeMyZMitQXaLygRBOWtrOrnH?=
 =?us-ascii?Q?hxbDs3SO44eVwjhkINlJN8kmNlL/Lt7dxzj9Pynnf80UDjumJ+5ptFWTVVUR?=
 =?us-ascii?Q?qcSEe3w199k4HhtKBPkf2yWJr2YpEeX8SNNZxijjEUE/9xefKkpqBpdJPAaK?=
 =?us-ascii?Q?V60NowUnQR5kUAAdpfikqM6BYdjGY9UyTRSIaHH1KmZ52yAwprlUGhbNw9L0?=
 =?us-ascii?Q?3eokk0wknXHfZsAX7BJ2WtqMnYldN+mR6Zl6tFm9v9J3rtFyyox9OdfaTgrU?=
 =?us-ascii?Q?QGwtL5jUVMDljhtMitfhU5f/Qk/3VsnzgamRE7E0442cgFjJ01h1xFjqgf5h?=
 =?us-ascii?Q?Yj+2fbRXkhk4MuwjKBkuA/sBG7pbVMif0h4o7uQ5nXqY/O+pdg+oGB82LNDp?=
 =?us-ascii?Q?SoJLL6jd+BWBbpYeZjBB20sbF2plRC0ngaYCrnjKtnTlKEkbAlwIWI418t+S?=
 =?us-ascii?Q?8wtinyaDjQogC0rSy6OJlN3xRi5W9qrRvldEuCqZFWaWEm6gDUidB0TJStBV?=
 =?us-ascii?Q?A+6dLtxQEz4yAQnsqdjxMofbUmoZmmbjNvgYfTc9a9BobxskDvPZyHYHm0zL?=
 =?us-ascii?Q?0htQ8dTbq3onCmnUYovubS2bxLsN0YmF0ozVU30NYaCbU64a74qo6fXdpA2g?=
 =?us-ascii?Q?NdhRczcOhmNwffinNv/zMi+Q2OEHJoKb9SmDw82QqNYC7oYPd2doUrK4hTLb?=
 =?us-ascii?Q?cFuyOfccFtKPVc6EyMWNc3aZcmcFC1qifTqWWNsx3JLtXhPp9U/3ZP29eRhV?=
 =?us-ascii?Q?NgKZUEsj/b/UVFt5+/4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe95261-e802-4290-75ff-08d9e270893f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 15:12:01.8831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWelH1RceEDWYTdZ1RyW5dyjpEcVVjyTrOyhoYaHrw67eK9K0YIjSOjTTTmHtOPx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0215
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 15, 2022 at 06:02:32PM -0500, mike.marciniszyn@cornelisnetworks.com wrote:
> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> 
> The first three patches fix serious stablity issues associated
> with increasing the send_queue_size as relayed by ipoib.
> 
> The last fixes adds a missing alloc failure test in allocating
> the per cpu stats structure.
> 
> Mike Marciniszyn (4):
>   IB/hfi1: Fix panic with larger ipoib send_queue_size
>   IB/hfi1: Fix alloc failure with larger txqueuelen
>   IB/hfi1: Fix AIP early init panic
>   IB/hfi1: Fix tstats alloc and dealloc

Applied to for-rc, thanks

Jason
