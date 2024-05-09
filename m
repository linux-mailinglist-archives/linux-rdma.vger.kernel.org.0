Return-Path: <linux-rdma+bounces-2379-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC66A8C17FE
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 22:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A0D2837E6
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 20:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5D57FBBE;
	Thu,  9 May 2024 20:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s+80X008"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0263211;
	Thu,  9 May 2024 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715288299; cv=fail; b=HSwpS1s1/Py1aolmCJmJIHrJkpVWp86I073tUm6wy1ZpjWQDmkDF7mnWKNseAYcSlyTuS3ImC1AWElzOeR8+f6eRDE19b+GrAQkjT5rCa91TWBJCcXCnTnLAn7K7DfIGsQTvOh/cFLkAR49g/E2T07pYHneOeAKHuaRLWQH1YaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715288299; c=relaxed/simple;
	bh=RXzQSM0VvplM+j/yYYy0tL/rsy3L/OD4dUYOZxJurr8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=PGGJwuAgyX4/vakEohrwLXU4hIsOacSDNjTbuF6WlddAGOCLzex2hwocnVOlNvdDKVodUsc9BRKJ9IkI9+yghqEgQaGA+CharIZsMAGLDBC8CiMN5yg6FyKfU7EO8uEr3rh87JgEUQ0C4Hvy/gW78KjroRsDo5Mxe7+HrJ4Vuuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s+80X008; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFZ14FiVZ8WgtpO1R8qJmOx6PpAk2iZx7hTXVpe8H/ib4ccIeFgdIY3d98D08XXTB1ua1QOSM+muiuQBzW60YUgB6cd/fT1m7jnO+YfHM0C4nh01rYsb2VOxxOYi84aWekDZa/+1j+TiZJE0UbPNPs6abEHiCbxFwjEC9U9dsWH6EMIwq7c2dDJtSDJXy+NBRdNgQgZN7ADIzaifmvkG9INPRLLEwpQ376LpF1U4TwKaaKZ/VpKL9eGbF5ppfvnK035WXFnKPEv50Rky95Mk5du2iJ9jKHukyY0DtEYOufJI1jzG708zp3+xi4NdMsdLmNickTcvIakxBLVP8+423w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCTJ7R+QlG7B3LzKqs/bhyGTzMon8D5NuIMl+FBzwH4=;
 b=kr9oIQDNHckbLNtMJ+b1h+aWsTziiLyBk43EFwwOX3zuEO+t8tj8+fenaYDAjF5WJQOmbQMqIrRBeclQpa8u6xqDMJmpoJXZhgfeirMNePCqinT15rj6X54JlPcPew1m4Qv2OlYaI/OabUNvMw/VJz+pZNdZD17Fzhd0q3mQlqSzXe0ovSofNWXfr6RPG0FtQPWb52iIN4gjz2PTWjCJnPhidzHOG+ToEYx8aAxTdkW+9g8t/vMNoKJQA7eFoHITUC3tKQ2nXzMNL6KHgMPqQEZZX9qbO3RySfk1A+7wQbalQ74kra2N+7XC0ITkHEKp/wR1Xf5TwZG4BEyQMNGDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCTJ7R+QlG7B3LzKqs/bhyGTzMon8D5NuIMl+FBzwH4=;
 b=s+80X008suqJqvKlzo+Nvfq/d0uOfaU/iv7UG5oRMoqJZHRVVcmcAcjuxeVaIr9Dl7APJciEd+Rkn9S7UIY3Bc01HKPmm0Coax5kdf3q1GRzv+0Ms1xsVlhMd7hgNwBeEroCbSQmLLyv/5E0fgnUB44bmFuen1+nXTG1wswBNMlrKpkZju+oad2kXO6RnPxPW0IIIsXbwofbOVZI6ImHlKNstf5yJXwa9y0dpqcpxARHNDM/LiFZ5/6DYSXBjWmrg/E5H8JZC5+G/35phtFqAZD1XplLEepyiwLcXwXiYOTbNUEx26y0BscaJ8ySGKHCX0qvsDrDCTq/ryG+N1YDFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.47; Thu, 9 May 2024 20:58:12 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::80b6:af9b:3a9a:9309]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::80b6:af9b:3a9a:9309%7]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 20:58:10 +0000
References: <fa2d39cf-b0df-4674-979d-b775d5077bce@deltatee.com>
 <20240509174204.GV4718@ziepe.ca>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Logan Gunthorpe <logang@deltatee.com>, Martin Oliveira
 <Martin.Oliveira@eideticom.com>, Christoph Hellwig <hch@lst.de>, Dan
 Williams <dan.j.williams@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: P2PDMA in Userspace RDMA
Date: Thu, 09 May 2024 13:48:31 -0700
In-reply-to: <20240509174204.GV4718@ziepe.ca>
Message-ID: <87cypuvh2i.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0066.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee3c650-0993-42c2-1f45-08dc706abbe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yAxgoPdvrF4FBhmboPpBKGb+wZIhY07Z7vcTVM4JaX5svkCThyDrw7DCoMRe?=
 =?us-ascii?Q?g6Gql/btsbOQf5/wLb1PwCUzyhekeCll7StQB9xX646dh2mo6kCKqBCpdd2G?=
 =?us-ascii?Q?d6SToqbO7Lm3zvMXhOu/EgTy/o9Gl/7tMxt/XX3VRv7di+RKARIqnnU3fdGL?=
 =?us-ascii?Q?KSbg7whQfOXGj8MP4M5v8hqsaFyCclXbOCAIHiJXIKsUadsF1LVJt4VaYLrK?=
 =?us-ascii?Q?GcX0dhEj9KTbIhX/bHhnSkbKuG5ckQKner9Jioe5p+pE/r7md1ElbpGQldBh?=
 =?us-ascii?Q?oWtCY7X+z84r1ih0DH+r0AWUJ7erV1DtzyGUunGRkHO0v+vxpZzjbp/JIujp?=
 =?us-ascii?Q?chu96vd16tB0lj6ABhIV2VhhgQr5ERsqEi9JK6FHNS+0RLaoXAGuDSxPUTHC?=
 =?us-ascii?Q?ascqpSoAHpXK+ZE9yYK9HbVP+PEYWCso/DZGEtFq66mNZf6lFbqjLp0SIzdP?=
 =?us-ascii?Q?3upTM/a3TQKhyqpGVla9FhEgG1Qsxl9D1U6QXjDFywoTSZJrbwyOadL8cpXD?=
 =?us-ascii?Q?80+le9WiI/aIj8Lf5yNI7VQzOSHwxFF7OtutIWy9d/Fmj9Q/RTeRLv495OXo?=
 =?us-ascii?Q?SKZ2O++iwfyVJQLleyGhrzaxja2cg0IROvho9BNxfkfeqTFroU4x5J9uapYB?=
 =?us-ascii?Q?sRFnCP5RvgCWtqHCS9QHVkc/0y7pmjDWmX2ZPL7JY0+dSkTIc8IYWMXE1Gbx?=
 =?us-ascii?Q?41G3jRcApLX2eY2RaIpWhvQLF/kFDpKX7im58HBcpCA6az30YAVpXwRCP8Rp?=
 =?us-ascii?Q?kAucapwWk3PQUdCySHbNwxvjWORxYkpm+n20hGBUzPZBFTE6OC9EqLHjXUsQ?=
 =?us-ascii?Q?GzIF0thbEw++VEVlkM0vpoQ0F6KF1i6Nnq5C4aiXH/sw1Y1FN5QFBzf2G0xu?=
 =?us-ascii?Q?jOetjo/Lp1QCsHSZxncoWR5ZxASZ+EfmQA42JznwKy5dOWUxhl7qus+/GHYb?=
 =?us-ascii?Q?JQ0XRuNG3CaC9Xrx5r81XTLoXR7vOubXRVGLy4xklvIQm1oBIzae2smSy+3A?=
 =?us-ascii?Q?C854khBewyI3z11AZ34Tix1XWXWsM+IlXbhcBwsSu0nXBO1DdHeryN/rP9Q2?=
 =?us-ascii?Q?mJmfp1esVacTMNtNGFi5qky2jfPqBpbMvYkoAVsPNl8SRWuAbhqAocLzsrdG?=
 =?us-ascii?Q?4Zki84cboCsNIwsgTZe+Iz0qK7u8B0i6DsprI6qSSdS0LtYNf0Bb8SptQ2XJ?=
 =?us-ascii?Q?LKYv1SSkS4/dRQ1n2spqV0S+5o/O6tYV8I7RmgJ4DiNRG4iJ/rS0MCEAi35S?=
 =?us-ascii?Q?WpLotZjxdd2jiOsNoe2/GWUzbAKGLLOFQ90KUo27IQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MnMmbHkPzFwhjZ2KMi6sAO35Xbl8JQJRkSg0WBOclBSTua6lRXq5bxrvfIXk?=
 =?us-ascii?Q?vmzOhAQgKO9FqMJs4GCs2NUyKRNzLnekOfA6BI4h2Gz44msLSsZ1ggBv+HC+?=
 =?us-ascii?Q?hVdkM4ULqkMjZ5HX+Pi5Byw0U+MkdBNVcpEA0mIYFDRcKqPuUappUBURkGCP?=
 =?us-ascii?Q?pJN1UHYKgpXT6AVWoWh9kpGERCVXgOH1XhD7iyXedDuUbGWmy0GOVwfjV3GP?=
 =?us-ascii?Q?Qq+pigVb8UBPAPqLtHa6OHrOmDAYKuwhECUpFjwrXCPXNG5EiYb1WEhmQHWC?=
 =?us-ascii?Q?WMlH2Q67Xnq82vnyctUfPOT8uKQZNJqcCbDIEgjQIMOI63cEXTgol8Hb5XAh?=
 =?us-ascii?Q?LJnRZvtMc9Hjt/3SoIxbcsfbC+hNJL4DZ168dRVqHl77FuNY08g6B4cXzPsl?=
 =?us-ascii?Q?8bh24bTT2XK/Xr5QcO9ERuz1lyd+d8+31yQDUs/YXxO8EEu5rhMm6wG/yk0h?=
 =?us-ascii?Q?uArJkhyhW0vTYfb3QxITDOeDG2rOnh1PJE3nN1webgXRp1UAsW82vudoQB30?=
 =?us-ascii?Q?bxom2qSJd2jm8LeuwktYztteBV5oiUea3X32CSn+vlVWzK30YDNGYfDnKzHp?=
 =?us-ascii?Q?3qJmt2ZhqFnve7/2ZW7QApdIxHFwykm/CCxdwSCL9rq1uHpenUs+UCrsGjJU?=
 =?us-ascii?Q?gx42RGBj5rqrGulUeOe+6Mzy853q0zK/1q7i4eBxJ68QU3IZ3JZuB/Ex6OzM?=
 =?us-ascii?Q?/aUDPo9Vo8yv/cX0mlbsyPAt1xnaqd59RPJvpdE3/JIC8DyHDN2mvhIDh6bq?=
 =?us-ascii?Q?mGQnFUZxz9EZeqpEqQhoEoKHihrQcvp/GBUGk9VTZ8xUtT6Ttqfg8KrMwTdr?=
 =?us-ascii?Q?MCNJ68Jfa5CMZAF5XycaXFDZyv1OGSM/h7E7vrl0E/Qq9Rakjzjd/DEcsqJ1?=
 =?us-ascii?Q?hhB/I8lvSdYY0KknzwQTVqGcL32/TOZbrAKhlRD487huCUfmq1LFyicKF0Do?=
 =?us-ascii?Q?MSqCDJW8rN9d6oeG/ljv9YYYROeo/Ttrls36os2saDXTYspmFzCQc7n+ujGJ?=
 =?us-ascii?Q?vWkKBGZBoc4vpCrgV+W22bTTS0CCR9lgPUwbkyCtoweSq9yJPiOG+1XWwY8r?=
 =?us-ascii?Q?om4Xp1IRvnH6wShDdyvwh6zgfBRDHdYaflCQVv8eEn0TjylSDiOkEBuy3q6h?=
 =?us-ascii?Q?cN/eqc9rbzEc2ffWr65g7SX27HPAwHzY8TNirOjn/TKMiM6KVlLSpihQVyIn?=
 =?us-ascii?Q?x4ctZ2h0LhD9iLAXtuLQdKYUGCbBUqfMc6dG9pcMv3G59EicSUH2HVyT78fY?=
 =?us-ascii?Q?BfjXn/BiqeDLlOYqfzfB4hj6SbjYtiy0EIKT44HJJsph5D0K5xkSYQVO8dw/?=
 =?us-ascii?Q?T0yox23yWiZXhhLiu3LKaqkD7iLGRdIweAxNCIxIJAJQ4dZ5hosgyXM5adhW?=
 =?us-ascii?Q?FDBKm5uw/sDaR/rAjC+o+5V4utekCkmVIGRqObL3Jzrj1tSirWIO5CTIz2fa?=
 =?us-ascii?Q?zy219FysG1JIc9HiOg05yD5vWEMnwCLgI+/Dr5asjJblvBfZaYmfH8x1Y5E8?=
 =?us-ascii?Q?UiuSPg5oaSleVC+sZT5PucDiUMVlUcEvfVzOFNA8dCqeP6Z/OI+npW/FnYLv?=
 =?us-ascii?Q?F9LXbOKarsBFBfhi9iSZd7JsTlg91UFobxAlOWnb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee3c650-0993-42c2-1f45-08dc706abbe9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 20:58:10.6060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ybgJm0wThpGbkCHBtKHrueOCZwwVGfdVKWJcv44DtqBERYiXU6T8Tn/ZTK5mrBuJ+T//bDW09uX1WeMWlyo1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007


Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Thu, May 09, 2024 at 11:31:33AM -0600, Logan Gunthorpe wrote:
>> Hi Jason,
>> 
>> We've become interested again in enabling P2PDMA transactions with
>> userspace RDMA and the NVMe CMBs we are already exporting to userspace
>> from our previous work.
>> 
>> Enabling FOLL_PCI_P2PDMA in ib_umem_get is almost a trivial change, but
>> there are two issues holding us back.
>> 
>> The biggest issue is that we disallowed FOLL_LONGTERM with
>> FOLL_PCI_P2PDMA out of concern that P2PDMA had the same problem as
>> fs-dax.
>
> Yeah, it was not a great outcome of that issue.

I recently came across this trying to do something similar with io_uring
to mapped P2PDMA pages for testing purposes. I commented out the
FOLL_PCI_P2PDMA check but it hung/stalled during process teardown so
there might be something there.

>> See [1] to review the discussion from 2 years ago. However, in
>> trying to understand the problem again, I'm not sure that concern was
>> valid. In P2PDMA, unmap_mapping_range() is strictly only called on
>> driver unbind when everything is getting torn down[2]. The next thing
>> that happens immediately after the unmap is the tear down of the pgmap
>> which drops the elevated reference on the pages and waits for all page's
>> reference counts to go back to zero. This will effectively wait until
>> all longterm pins involving the memory have been released. This can
>> cause a hang on unbind but, in your words, its "annoying not critical".
>
> Yes
>
> But you are looking at the code as it is right now, and stuff has been
> quitely fixed with the pgmap refcount area since. I think it is
> probably good now. IIRC it was pushed over the finish line when the
> ZONE_DEVICE/PRIVATE pages were converted to have normal reference
> counting.

But P2P DMA pages are still in the off-by-one reference counting
scheme. My RFR series[1] (aims) to fix that, although the pgmap
refcounting scheme needs a closer look because I think doing the page
refcounting properly allows some cleanups there.

[1] - https://lore.kernel.org/linux-mm/cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com/

> If p2p is following the new ZONE_DEVICE scheme then it should be fine.
>
> It would be good to read over Alistair's latest series fixing up fsdax
> refcounts to see if anything pops out as problematic specifically with
> the P2P case.
>
> Otherwise a careful check through is probably all that is needed.
>
>> The other issue we hit when enabling this feature is the check for
>> vma_needs_dirty_tracking() in writable_file_mapping_allowed() during the
>> gup flow. This hits because the p2pdma code is using the common
>> sysfs/kernfs infrastructure to create the VMA which installs a
>> page_mkwrite operator()[4] to change the file update time on write. 
>
> Ah.
>
>> I don't think this feature really makes any sense for the P2PDMA
>> sysfs file which is really operating as an allocator in userspace --
>> the time on the file does not really need to reflect the last write
>> of some process that wrote to memory allocated using it. 
>
> Right, you shouldn't have mkwrite for these pages.
>
> Jason


