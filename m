Return-Path: <linux-rdma+bounces-4076-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4499293F9C3
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 17:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A0E1C22062
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F56215A851;
	Mon, 29 Jul 2024 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c+XhZblx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934FD13BC3F;
	Mon, 29 Jul 2024 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267730; cv=fail; b=GirhpVBzUN04ew9hBxQtKEibUNcTfxIuoWJubpr24payFHKF6rDwMgoYAjCwwS5lR0HrFszajEvwNUiFrMv2qEObhY2rWmRIji3y0HavkRp9NfF1+5KjIHSqpOnFgiNJszD6LJpaezQ09PCjI6emc3kN+G/I80q6tR2raNBLHmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267730; c=relaxed/simple;
	bh=9K2Xy/do747evYimmfkm9wivvCRMTFqBym4gK6xYD0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LI1nRBI5DmcDmKKPx4bbR97e0eFsg9k8/If/oV7RV3818mju3RUS+QaFjuN80xcnd45/DNWiaVWg2VGQz6q0cAiHykJEqFQ4mQ6QO7pRzccxN6SBe5gCu7MpNBFMdMRyt4nU00w5RFwu0HNFRJhgM710jZOTc/96VOFFIzE5Eoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c+XhZblx; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZKf1ASEFErxZeWydIg6wiHY70smb1u6BxcKRJT3kDbzIuQPzLQcGSL/uwhOSwGb2utOHAWIaarI1vI0ZCD0/F/zWL8cmPkXpn83qxw8yghUViH4lr+O7Orc038miZGmVgYW8UlzROZRTXO2rUG2gFGoSbzLfbFGsWY6edZqeNqNlD8iawFUOvX2hItXbEsIORnKzedrrsE2ur76V4bkmQdy2bLXnTDJXP7s96sIP26yg+/xSIe8SMjC+2II4XW7LRWPtNswdc2D0b9dFmRFmI1ZHCJtEFGZRcSEuAgw3vamcVV3YR0uQIK9/MTV9KWOYy4irizVtX+ZayMY0HOreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se0Jo+Ov7xOU5ZmpT8P5MXqichTMePoHgvSK9S+cpzM=;
 b=e3fLMrEhYv7EUdjXEkS77xEN+OHX/qopKSdffmSntKrH8VLTa6b7epaeqDpwcveY7PnYhhg2rzUFqLmJWsj+jNVXLu+MRfEyhJijdMH3rBYfHXt+VB4YpbjNt6HkEV8BjEtEDo4XyvHHyasJYn1GU5dKiuDqXKZa2oHe6nvnvobBjN4ormWneICSxNn7S3qHymZi2U8HBNsrcZo/rUSMK8fv1WUsy1MW+N1V0nCKs5elYIqFRVktQ7CJyLiLFZHe7iElpTNLVwpCPcll9PKHi9QNXrLeF6nf7Uu2SvkMewMCyOGnTyBaghGlboaStchPNkbakwLHOrVj6MN9My8B3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se0Jo+Ov7xOU5ZmpT8P5MXqichTMePoHgvSK9S+cpzM=;
 b=c+XhZblxXjWZV/5aJrSniG92r83lssHDluYe4HQaRQx/hRZDbtjfAuwMN3RP5yldOaLQ7gRzuItn6dQFCqdVXMOVmEOQiB+/GxE6izjB17PVJFM+/H8Onl0joVDM6qBXFuKdH3v47kMlzaars1REABE4SLF0VoFVrbF4sCW9dhb3GFKCY3oo3NdLrmbwE2aB1o/iA5aUg6LA5NESRQDQtjdU+PftINq0nzyLYmdk0WFVsO/OWUiiMCaNJLWt2mYddmZLA79kcjTgr5Gv6xZCFXX6pL8z7298nwUKC4F3eHnr9iKGteH7oZpXcOtEZgSTMVj1v4IWj61Qu2OmuJa4OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 15:42:05 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 15:42:04 +0000
Date: Mon, 29 Jul 2024 12:42:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, shiju.jose@huawei.com,
	Borislav Petkov <bp@alien8.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240729154203.GF3371438@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240729134512.0000487f@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729134512.0000487f@Huawei.com>
X-ClientProxiedBy: BL1PR13CA0358.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::33) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 2416e8d9-d071-4c06-3cd4-08dcafe4ff1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PVVt83/O4WbYSS+AM5Yxobd1hRQpWSjRAK0y78CUR6fEFNf8uEuLB2SQWKKo?=
 =?us-ascii?Q?bEUIYAizUkcikTqshz7RnJr9Jo1W8+OOqO/P2kRunseJe9d7ScgNT5EJuDyk?=
 =?us-ascii?Q?8359AyFERnCDqnG6iPkk2h6jgF2/DC5kyCWUnbYfbgLjVv/AfMkAxFF+9f98?=
 =?us-ascii?Q?bvNuqr+IKGNJRfWaX+zDQaB0qtqbvwC0WYsiic5/JsVllnjpuczzTGZnDSv1?=
 =?us-ascii?Q?uNSj/Jc4Z4vz09taGfRdoJIIfnQ2FlMXcFZl9bsSlxWBW3XDRhNahUjV1sbc?=
 =?us-ascii?Q?5e7sE28ik/l/KBkfcbNmS/kva3/YYSsfXtrpKMI9YHSIwCTOwor9IOw2uP/i?=
 =?us-ascii?Q?BtSoDIWbH02ixM5evuHf2R0ij/9p7Ird9pt1LMBQfSf8NzNwkRlSi8Fzwgkb?=
 =?us-ascii?Q?xaQr2oJAQRmR5SiK8BdivAnTDUAp20DbrSEjxyjjmnQ9QvG50BQchlwGZQux?=
 =?us-ascii?Q?CIRmBa7mAfQoay3ksy97PX4AuWBmAl/0Zp/ouH0CHi6PBgmQANh1YFMTolUq?=
 =?us-ascii?Q?pyERBSazz0glJ6UUgUcRWAWSeaMS9vbF77IDFWsAI7TqBGzxwwWKnkl/FV7b?=
 =?us-ascii?Q?EJ8RSBaK9quCjSr2TOX8567N9GEYtR4w4ARmWhirzAPW5Vgkx/BoVIkdS62U?=
 =?us-ascii?Q?Hk9OI/v+qOtjpX+3dCtpuE0BSgz8bsd0hU87AXxQQUoDCU8IXRKdJZUXU93j?=
 =?us-ascii?Q?h0wI9zF7wcZQOFHvxqxN9wlfZf16k3Et+CLsboeO3mKsRvWJfg0X3Gv8aifE?=
 =?us-ascii?Q?VzHBYcJdRF108iUm+pBJ2HNI+b9ln/44/j0tUQ41lfIDsHAKaZU1scNqea7W?=
 =?us-ascii?Q?i++1CSS9mFICwF4I6yybwYyR3pv8R1/lvJtaQmcSwB+ffiUuD0gTYnCaDsZ+?=
 =?us-ascii?Q?xrJ1AhAL40kXigKZIWWhRAFD2Y2NzJREBntv8Z7QnQxpRDxPFkPj9X+O7SA5?=
 =?us-ascii?Q?jvrfX86uOtg0Gsxg7rQeGu5lAYeEf5w9J6ITR9AG3rFldWfINfIKBUet9bof?=
 =?us-ascii?Q?gg9+oMCkB+vxlLxRrFbSMrREnLmj7qWXdzcfuBA77+oSMEimew7f0PTE7iBN?=
 =?us-ascii?Q?9uw6fVnN15BuZMNTSWn9IDaRLmzCqcTgXRDCIKuwFUY3k7kbs+3P+IHR5bG3?=
 =?us-ascii?Q?A3a9C3mvQdZPknMMsF6wWmO9UATcwFNbbyTKMqFqUwaxmciypHJHcMAOvv8h?=
 =?us-ascii?Q?4n6S30Snk4oVjgpEPD57sfnf96snIwBWlgE6TsJh0z46HN4ByQ4WqDvlx+T0?=
 =?us-ascii?Q?tq+PGFV+M6oYA7R0s72LjqmB++Hsf+M+vjJT54jpz3FIW7sk3gON4Q1nW3TX?=
 =?us-ascii?Q?czMEjtMYSTx4QHj7slLroTRnumw6zeQ7bXle8cf6/fF0wA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oq8xwThVkRYOOSnN5hKZv7KSK5px/NVMbsdaIdPDs/nxyJFNEYw2mxObWqMX?=
 =?us-ascii?Q?NhDTRiIjQvUU5A/GHY3uMlSuoo/w6tiGWfS9aMxKJz/ui/0GERd/neqK6HxT?=
 =?us-ascii?Q?ktVr3YR7j1tvn/92fqpiWKP8D+HmcGdSsbVOxGndq9k+mae74a3bPPTr//yI?=
 =?us-ascii?Q?oF2CoW/HdBK/lbOsitl+wqJTIJ1fBWfAfLNleVcfY9iOqmWyL+4LxdYT6UcY?=
 =?us-ascii?Q?RYnfgJ25yk3rRm1TrSxO1skUXa8tnKb6g/FD01aDSJGe+JTSOBR87wFP+Yuf?=
 =?us-ascii?Q?UXRMiLIyMwxfE6jID0riZULIkZY7MY+MoWhb+H+C26t6E7G1YbgYeln7AiZg?=
 =?us-ascii?Q?IA4j1MWCN1gceCPhyYVrvhIoCUqNVX6e+3AsS5x0mzCGQ+EjdG1uQk2B1B92?=
 =?us-ascii?Q?PkmgLyb/Hv1FJ+OGw96UN65Fj4BKhHecbHwzwryMbHcs8quGO1txNmCVW0/Q?=
 =?us-ascii?Q?uSdTHBfpYinY23QzJ46PmxQmTyxHgLpXnCcFolEwT2v9k/EiTxEkaaoJxwmy?=
 =?us-ascii?Q?xDrw1EoOfBP9HHXOPeeoaJLkE6dLuDGGz7njJBwadmkeYujdm61Nv17iMTEb?=
 =?us-ascii?Q?JSo7X04w5u48hIA3AIT5Y3viCvD1txkD55jnNgb9rvxJDmmfMDj9E0tmIxkV?=
 =?us-ascii?Q?UjLwcs84VJWgmwFbV9+SSUo/JGWoHEpz4QHjmqQEbmJNTs/f+JzLx4sjnhUi?=
 =?us-ascii?Q?86hqt6/87gwQM9JYJeZiUbvVlziheXX7npRxDwskrAzhCv2CqiaZV/3NIJGt?=
 =?us-ascii?Q?XIq0am3AmxLYlcK7qpTtHojunvZDHnJq4pSr90irLAe8/LGsyaypgDOM2ffi?=
 =?us-ascii?Q?wzkcmoVz03swKxf/MB99us5TZtjU8D2vEeUo+fegnBoR4qVmtfCM4cdUcEyi?=
 =?us-ascii?Q?sVgBJsAv1PoygFY+ilS6KCYzz0p8kw1IhlkNp1JkDFCyOjUnkY4O62ssHlCs?=
 =?us-ascii?Q?MO1Q7y6TF7uLsM61B4/MWqXvJkB2N/qf6zM112jXQz872NadH/bTkLSckCcR?=
 =?us-ascii?Q?R8EiYN00WZBd+rin4onq0ZU+e6gevwuRJuvkE4E1Ou7BPP2SaECwNqTL4TZY?=
 =?us-ascii?Q?fgaPOTCcSlXFpE1uMk3U94Hbm3nuJ+FJx32jdM7wgTkQyL9OgfmG9Ui5U24s?=
 =?us-ascii?Q?8/JuyAxPqPkmw/fbxHNVHQ/VeiiG9G4B54h8OdxlUY9GAdkFDADqUXOXbZk4?=
 =?us-ascii?Q?AqC2lFEb3En0M1Y3k+TjtddF+QWgrgvZZUEfLIAvcQrwFi0sDGwg77R7sCJN?=
 =?us-ascii?Q?SGMiw6RpRthquvYnLRgmR1oHZkjuAQOXb/mkc6K+w41oKg/kLETfI3m6ovlr?=
 =?us-ascii?Q?vykOXryS/i6zykMOk3WtqKlF/dBZcVscrbit5DHnvcvjsOzsMmKeEvp8kxk3?=
 =?us-ascii?Q?1calq/zvdDFEbzX10tgrOAbGi/Zmezklvka+rBMzNY8ZkufkqezA2uosGX66?=
 =?us-ascii?Q?Lpw15rQ2fmm2Ka1x2vjg/MXy3u27VrIMo60ULvbjpnM1sUVxinZzHSMmqKGK?=
 =?us-ascii?Q?/fYoIRyriaqTLJw4TBsA1BpIvEQw33nuOc2WAUiDvcJyK3dP7/VdB18uvHHh?=
 =?us-ascii?Q?iuZUxDByQxeCeMJ7EejVuyl+W4oXYFW6ZIh3zBcP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2416e8d9-d071-4c06-3cd4-08dcafe4ff1a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 15:42:04.9022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MotPXMJdURPIVgBwgMYEFMzsNq0j+NBYGt2rw4EiiFXntO7keIyNGQDt0isxhxAV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215

On Mon, Jul 29, 2024 at 01:45:12PM +0100, Jonathan Cameron wrote:

> If we expose that particular Feature via Set Feature we may run into
> future problems.  It is probably possible to make the driver stateless
> so any interference from a userspace program using fwctl is not fatal
> - in this case userspace code should probably be safe to state changes
> anyway. We know about this clash today, so could easily block fwctl
> from exposing this feature, but it is illustrative of a wider problem.

> We will get some decisions about what should be exposed via fwctl wrong
> in the long term, even if they are correct at time of initial decision.
> So how do we cope with that?
> 
> 1) Make no guarantees on ABI for taint causing operations.
>    So we can block this FWCTL in a kernel if EDAC / ras control is in place
>    for the same feature.  I'm fine with this but it's not obviously
>    a correct thing to do!

Maybe, I think that is a bit suboptimal.

> 2) Allow the footgun. Keep the fwctl interface and harden the other kernel
>    support against state changes that result. If userspace code breaks,
>    then tough luck.  (Another form of ABI break, perhaps comprehended by
>    existing proposed FWCTL rules).

This one is certainly closer to being in line with the fwctl doc as
written, but I'd say fwctl should be unable to hijack a scrubber block
from the kernel in the first place.

> 3) We are stuck for ever with not supporting anything via other interfaces
>    that would break if fwctl was in use.  Ouch.

Definately not this option.

> Note that I think this only matters for the Set path as Get side shouldn't
> have side effects and is fine to expose without synchronization with
> a clear statement that values read are a snapshot only.

Yes, that makes sense.

> We could say it can only be used for features we have 'opted' in +
> vendor defined features, but I'm not sure that helps.  If a vendor
> defines a feature for generation A, and does what we want them to by
> proposing a spec addition they use in generation B, we would want a
> path to single upstream interface for both generations.  So I don't
> think restricting this to particular classes of command helps us.

My expectation for fwctl was that it would own things that are
reasonably sharable by the kernel and userspace.

As an example, instead of a turning on a feature dynamically at run
time, you'd want to instead tell the FW that on next reboot that
feature will be forced on.

Another take would be things that are clearly contained to fwctl
multi-instance features where fwctl gets its own private thing that
cannot disturb the kernel.

I'm really not familiar with cxl to give any comment here - but
dynamically control the single global scrubber unit seems like a poor
fit to me.

Jason

