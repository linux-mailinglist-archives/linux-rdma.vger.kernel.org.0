Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB6B412963
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Sep 2021 01:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbhITX1A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Sep 2021 19:27:00 -0400
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com ([40.107.93.53]:3456
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239693AbhITXY7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Sep 2021 19:24:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNaFjjwvtupNFwSGw4jHr94OlC2wBvyXFmbmZTTE7cLKfwbfnNLfRntnXGBycgqfpAN4akoKrArR/k72KEcQ0EflLT1bwBccLwAdUd8tADOe8+u3NmEw6Xf4eZcMGByxn/Tk4av2Dms5QMOeCibmBDWY9BR6CKuCEoMxMvH05WkeDj4mQ5+9z6ZPLAX7ipbCevFM4g0YPKf1uacuHKZKMk0126VQlUlVLupqyhYnb8rhdD/6qzT61klFfxOHXFOqIuC+LGqW/PMrxy2cu333P1HMfw+deLuEQs4HAHn/9siqTt3DCUyy0/n14zu4I4e2WZRvReNGsdyfr0KqqAHilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=j4/ViMWq8QdosVYz7psnc15RJw8LEodVlz9q/7RZL24=;
 b=i4KdffsFTBjLr3DpT82WCddM1zFknOu1tlmIn8RS+TpamdKaJyknxJo4PmvpXlNOLS3f1U6cX5jJ1P2CkpfJrZDDS1YdU9I6bE4hesT2V+ycb2fl9Kwo51jipnNOECxyCt/pS9f+KMWKT1kX1Wz94Hzcte+nmsZd3dKV9WG/5Aag3ymQBFjsnHtJfdpSrRuoeHCzOPzmvpD2eMXxqPbDRyGNc9sWVGUVJHKwfSp/8WSt+qW3f0tURBU9TGbodXfczYYmBgJkfaluVV10rR5D5v7nI8tibjaYfgrWzwJWze1DycHE0yKJxsij7zVEHyQ/HLNnwOmEy98/3k042lPD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4/ViMWq8QdosVYz7psnc15RJw8LEodVlz9q/7RZL24=;
 b=Q3Ceanfq/dBDz0qNHg+TJtGb9SG8K4ofvcwTIw4PjkMbYRHlFpuRxOaO2wnQhfGwRlkVM2IdOtoTA1+0HB+HngnUhJmNJOEssrBA2dSWonX4RQNaK/w123Sj131UoGXYe6jruRhNJjAre/drG8ctKrCIN3C54ETrxiz+yIcZTysJvwZ9ZDtnOIXn4K7MpBUhwxGl4bMN5j4auiI8T1X+QgnSHyfxPLQF+n1iWILKdnaroDdbuP4w6KDjaGVMzJwKPn9zswFrIRm7CRKkBtgulE5G2sR9Lgs85OtmcAneTof/1ep048BSQMVMV8RqH/FpXo01wrepVgFGCvssErpCsw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 23:23:31 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 23:23:31 +0000
Date:   Mon, 20 Sep 2021 20:23:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Message-ID: <20210920232330.GH327412@nvidia.com>
References: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
 <20210823161116.GO1721383@nvidia.com>
 <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210902154003.GW1721383@nvidia.com>
 <DM6PR11MB4692517FBBC9AFD046990DCDCBA09@DM6PR11MB4692.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4692517FBBC9AFD046990DCDCBA09@DM6PR11MB4692.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0087.namprd02.prod.outlook.com
 (2603:10b6:208:51::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0087.namprd02.prod.outlook.com (2603:10b6:208:51::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 23:23:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mSSdG-0037f1-6i; Mon, 20 Sep 2021 20:23:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7b3bde9-1764-4f0a-4953-08d97c8da894
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52064B82AF64462D7AC68738C2A09@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ciJvtWF67lRiorAw7e0iC63/K0qw3AkCF8of0HfnYZwZ1CLY+aM6al7RJeyhv7T4bbHJSW2zn9diAkxSg7GQUC9d9lqD9ne/cinFWpqz4wXe711hKoOzdfVe14eqNqF3fm53Q0CzGdrtX6eA9D2Vzc6MdcCearm3IG3e4P3LUPsVBz5oBRscJOxKrzE6eK+UmP6STVGur7Jw+0s5o/rChVsV1IGydB33bGjxQsZpkAeSt3alRcWfN8+4coX5xKSIzOd4qlVyw/h9z1lpo4QQPqOHdW8Qo/Z4pSuzbBsS8K02szkLnuSbyGrhBqlTZjupiCqziE8wVr+cLnw012lldqSiOHWSEhYfklyaftpZ8LtcB3D+TPExTGQ2bs9qdaYaAOl299ybasvKWryH+Le/VfFDnZ/CXmr4bbU5OHWoCV0RqJa8RH08F98dg47Jhv+78/wamIyUpcWu0uARsNRFWjtsq9hm8P807Rs7g5GpjPYq5jAunF0rq4ZQkNeaSSisy5lkOjblsgRWaOvw3EkUoSgQSDOWHpiVI5m9pJzkNvNWonDAX6mkTkSCyUptO9iSwQ4MYyFxyp6DeByYEIxOs3r0fkJmkbFUaM9mpUL7qaWyEY1Zd/17g+dRP1qI718Gyr2SrQfL36x4mFdQArctN1InMTHFmghUvcF1JJTtn8G8ReW3t1+iOED/Uq33ypdQE8l2HBfD26FoRhUKYPoUMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(508600001)(66556008)(54906003)(8676002)(186003)(26005)(8936002)(53546011)(1076003)(33656002)(4326008)(9786002)(9746002)(2906002)(86362001)(6916009)(5660300002)(36756003)(38100700002)(2616005)(426003)(83380400001)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AjgzlPqPwS+CdfVHDgabBflhjgr1y6IuQHWcTirPgM/ung+qpRWLWK9iVf1I?=
 =?us-ascii?Q?kAL+/mvfcpGt2z+CWPf1VSErtkiKaBUcBYvaDqbQxbjBJZJy9nbGsxkzng+g?=
 =?us-ascii?Q?NAJGWrjEeNr3y6C3+7vHxgmxSlCMpowbSrcZvAg2QpPB6HlUr9Axzv5yHa/4?=
 =?us-ascii?Q?82BXSiFkFIER95A/tPpiT+Ry56yevXJf9ZShnrQb2w8au6kVEq3w92zwz/6C?=
 =?us-ascii?Q?F/l2f2JKmOU5yWLyOeiRXNMNO80hMh3tl48k6XRSRG0f2hq+Y0BTLlh5zswU?=
 =?us-ascii?Q?AnhSpyzmvW+UaG6tZ35VqgagYhB8fum3+Xhk3+P0Lzf9ZVX2b5Thx+KxUUws?=
 =?us-ascii?Q?K2SompArEBFL+q1tBCqlsc+aoguEUK44T4lnZaTtwqVmhd+CTup/jkjpoH4F?=
 =?us-ascii?Q?C4BYQ8qW1l2dj6BoDamDf3A5SE1NqoA6OVwMqj9CghudmX+sEfmAaf2TGcpp?=
 =?us-ascii?Q?iHIS28lIMFWnoOa25a+u9LxrzAC2AUknPwb8Lmv6lA5HJnur5Bk90xxIcdw9?=
 =?us-ascii?Q?aUt3CcWc1aFYpRNNXJwRF+ZCZGJloa/mgczKY3q6/UeSN9hQoadkCpeattNV?=
 =?us-ascii?Q?uFyKYD6rlFNTcnWrCrWXsBpAPFCS+NzxdEA5l6b3lHT7p+JjEfMStsa5sfvG?=
 =?us-ascii?Q?zkNYSHNBpUZhf3kbS3TxYWEZW8Rrwvx2bjknMocF+JQ1Tp4yk6LNgZpXgiHd?=
 =?us-ascii?Q?DqB6I+n9ii84s2R2LLG/LkLWcwpH8uO5Hj+xF9AB8ZKiJNgb1FkdmKJVSfFN?=
 =?us-ascii?Q?IBjhT0zhpM3ueSC1ysOhr7iN0Qu8gb/4pYCGMqcIsjJcN3r5TB5EaR7imlt8?=
 =?us-ascii?Q?lPQFw+pcF+Kga+r3LN1erfPxRh4gK4EJxlXAYK2dyr1ihidrQYmQgogEllP+?=
 =?us-ascii?Q?eNU0l1X8MvUL56pRBclC1WHGx4lj7rZtI/V4KjgbLEo/dWh0xyLY1caL7TPC?=
 =?us-ascii?Q?i/x2434x62FhVkMt0Ny5l0SzglhpXnb+PjRsY41Q+UlSNMm9caxoQsKpVfPw?=
 =?us-ascii?Q?GynvdGqCElz9GXDF6KXbpf3X14OmjFgEyA2rDQLeqVK4XFPkuC4slqidzAfe?=
 =?us-ascii?Q?5rTXaensci9TYdZRwY6lQJvpkhqFtNrshhU4L/Px7o5RhCVuWqP2LOIG7l+H?=
 =?us-ascii?Q?gdgVq2d8dK12TvxzjHbAXGzNU7LHqAMvPd2PBCpJ0n0SnY0sq8GhxcPWn82l?=
 =?us-ascii?Q?+afPC0FK2T8WKzdJf3ssjxKSGyKy6M6s5tfC66DzxhJ+6S/7vZJ46diddYJZ?=
 =?us-ascii?Q?yguH2+RNSAznRO8V/WN/x61ZDRF2hVOBBYf2Jpe61iYLNWArBEFwgtpeS55P?=
 =?us-ascii?Q?aSD0hi0aPKvKBx2Dl/VRpd8a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b3bde9-1764-4f0a-4953-08d97c8da894
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 23:23:31.1841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcBbeQJ89408XDvmTBfp0ixRIAMJzzFqfcQCOqdWpxNr4K7aq/zYQ2QWavbDxMiV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 20, 2021 at 07:41:21PM +0000, Nikolova, Tatyana E wrote:
> 
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, September 2, 2021 10:40 AM
> > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> > Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
> > rules
> > 
> > On Thu, Sep 02, 2021 at 03:29:43PM +0000, Nikolova, Tatyana E wrote:
> > > > Given that ice is both iwarp and roce, is there some better way to
> > > > detect this? Doesn't the aux device encode it?
> > >
> > > Hi Jason,
> > >
> > > We tried a few experiments without success. The auxiliary devices
> > > alias with our driver and not ice, so maybe this is the reason?
> > >
> > > Here is an example of what we tried.
> > >
> > > udevadm info
> > > /sys/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > > P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > > E: DEVPATH=/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > > E: DRIVER=irdma
> > > E: MODALIAS=auxiliary:ice.roce
> > > E: SUBSYSTEM=auxiliary
> > >
> > > udevadm info /sys/bus/auxiliary/devices/ice.roce.0
> > > P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > > E: DEVPATH=/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > > E: DRIVER=irdma
> > > E: MODALIAS=auxiliary:ice.roce
> > > E: SUBSYSTEM=auxiliary
> > >
> > > Given the udevadm output, we put the following line in the udev rdma-
> > description.rules:
> > >
> > > SUBSYSTEMS=="auxiliary",
> > DEVPATH=="*/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0/*",
> > ENV{ID_RDMA_ROCE}="1"
> > 
> > What is the SUBSYSTEM=="infiniband" device like?
> > 
> > This seems like the right direction, you need to wrangle udev though..
> > 
> 
> Hi Jason,
> 
> After more research and given the udevadm output, we revised the irdma udev rule to make it work. Could you please review the patch bellow?
> 
> diff --git a/kernel-boot/rdma-description.rules b/kernel-boot/rdma-description.rules
> index 48a7cede..09deb451 100644
> +++ b/kernel-boot/rdma-description.rules
> @@ -1,7 +1,7 @@
>  # This is a version of net-description.rules for /sys/class/infiniband devices
>  
>  ACTION=="remove", GOTO="rdma_description_end"
> -SUBSYSTEM!="infiniband", GOTO="rdma_description_end"
> +SUBSYSTEM!="infiniband", GOTO="rdma_infiniband_end"
>  
>  # NOTE: DRIVERS searches up the sysfs path to find the driver that is bound to  # the PCI/etc device that the RDMA device is linked to. This is not the kernel @@ -40,4 +40,9 @@ DEVPATH=="*/infiniband/rxe*", ATTR{parent}=="*", ENV{ID_RDMA_ROCE}="1"
>  SUBSYSTEMS=="pci", ENV{ID_BUS}="pci", ENV{ID_VENDOR_ID}="$attr{vendor}", ENV{ID_MODEL_ID}="$attr{device}"
>  SUBSYSTEMS=="pci", IMPORT{builtin}="hwdb --subsystem=pci"
>  
> +LABEL="rdma_infiniband_end"
> +
> +SUBSYSTEM!="auxiliary", GOTO="rdma_description_end"
> +KERNEL=="ice.iwarp.?", ENV{ID_RDMA_IWARP}="1" 
> +KERNEL=="ice.roce.?", ENV{ID_RDMA_ROCE}="1"
>  LABEL="rdma_description_end"

This doesn't seem right, the ID_* must be applied to an infiniband
device or the other stuff doesn't that consumes this won't work right.

What does the udev debugging say about these ID tags?

The SUBSYSTEMS=="" is the right approach, as shown above for the other
metadata. If you are having trobule I'm wondering if there is some
kind of kernel problem creating the wrong sysfs?

Jason
