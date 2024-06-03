Return-Path: <linux-rdma+bounces-2788-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644678D868D
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 17:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC121C21786
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B688E13665F;
	Mon,  3 Jun 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mODQunLm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA6133402;
	Mon,  3 Jun 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430017; cv=fail; b=HIffqtkftXIxu959F8x/LyClm4N2PfXCBHppIdfB7B2rbJwg/PN+PEIeeahnqmuhhxVKzyjYXAiNUGuI4SRtqK29H8apL0cbJXGS/rpWTnpyyHzIchPsDTn5CXvAaExYwS0QJmA99riK0gcqcppH4+QumwiNmC1A7VwxIEovykM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430017; c=relaxed/simple;
	bh=+Vi1KBi99rNxg/TKg8LScQXDjcceCkSkrRh+oKMAv9M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q9ssIXeKx/OjwcivtGVZ/EiDp9XUdxajSSKHm+DtYh6JgWHJfT/ksAgFYz2wR6erKnhTlBHMqRCQ+rYonrEQwxuFs5nBzOOfL4AZSAuyk9P1hgtusCUs0DRl7GeznUZ3JyJm/kEvZCAfUfwusbSmTnWx6cbtXOpuhYAkuNX47Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mODQunLm; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5e6qdeZ1+nZ++Xlpm2HoQ1s6TXyyLtVT+DReNcx3c1Xo5tgbFHTH86zBYcC9AFYk/TE+vbtvngudygmsI7u7Te7cS6rbDNFWhx/rRWhuPolLbWG+AT3RQ2Vjn2fprwmzufHR43rHLpOPlIzp/uCVqd7CMopBjZTQBEX8F/lMyw4XjTsIureUU11scWH85EFfy8+3+k8T0UfzfggR1wiZga28a9ltvMsPJHYP93hPmFX8ON48RW3nUhYXZyhRJNiMwZzkk9GEbBC5A02V72Gjxpgmghvz/hBZ8xl9I6zHzwAPO1/Z4wGveRWOoA8zqzsD/HJEhaZEHUdkPC/RI2BJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PoRBwJRGjwazZeU52c3cnDx1zbCEoS1+WhAeczf29Y=;
 b=aJ0NVkJK944yxNF3PcoxpxvhEwojH+TnRINSv5HntMDfeUuAa39BxQL/c45SCvs+n+W8mZqAC1UFdff46hmT1BT/TaSZRURu3hzJL4qhrv1NvDm38eilgpG3IRtvUrT7lOirWt/XoZkEUhPubIEsyFCnwTFdUqEP+y43c4HG7Iqub49Cqn/RPu9aFWxdLEg7LVR7YCFl5FwfCIO8bfJB56Wu0T4XPtOcKPgzRIZmSoiQX1+GZH78/WvTVp5cujm0kFA4xS9nMPAzeJV+F+5R+VJmj/4Mia581c8QFsMhiNOC9aUQyk3J8YU4e3zxR1AuGFUzy+8Mqfmg4UalKrqbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PoRBwJRGjwazZeU52c3cnDx1zbCEoS1+WhAeczf29Y=;
 b=mODQunLmukeQ3X/zEETO5ZZbpqkVpz2ZqHXaxFLGEHstJL76JLxBzfC+iLM5dCTOXI3lCPjb9eDSTEYqgRVBtGO5g4GEI1CuXGNbAIQOfDc94r0fp8OneOO1H4LXo6Lg3Mym3eoHJqjXAT4TwwtfzW5OACWk7dLVZb6hxenoEk1uDekcFxVtMOPmPXu14saTBwMES/aOvOb09g4UQKkEJZuDJEX2fPymmk/kA7TeV6vXOuM9o1NXNHGeJt8J/r4D2sTv8qyz/+Da3uc5t8YTBzARMVv2WI4c5PPSNBKyKiXNhf/hsaYBzxwmXzUjVxRqJpezM3CDpJN2M4wgUlLfgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 15:53:27 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:53:27 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 0/8] Introduce fwctl subystem
Date: Mon,  3 Jun 2024 12:53:16 -0300
Message-ID: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::7) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 7867b3dc-0d15-4a91-a0bf-08dc83e54e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|366007|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m4VRA5xU+TED8ZZDe3gfij03h6QekD0cM81dbjKWoDwuDa5f5HHh6Wq+swuA?=
 =?us-ascii?Q?Uu0kJDiWlyFmV9cjK3KUf9tcyoVIIuIsFYeEdtu4BXJRUWq1b7jO4RsDkOKl?=
 =?us-ascii?Q?kTrSoJt4WbkRZ/LsLhlHNj6dVNXEnBeo2zqz1RaoQRxHXWdTIdDCTOEr/SYx?=
 =?us-ascii?Q?HaW/zQ+A0I+2BICx81Oi+8gExfaX3fQ+e9oAQLVQI1+PScwN3UoZobjhduej?=
 =?us-ascii?Q?+bRRJIn5xkWFgucbO8AymJt9lo2chjh0i70ttcSlqFG+EGR+Bh2c9/lNnfGS?=
 =?us-ascii?Q?tunWrGZJoWoImcnRpOORxDJd9GUpYd15VpXga253E2tOryyVGeCfuwMvulxK?=
 =?us-ascii?Q?OQZjJ45jVljenpkVolRWBtDyHqAJsLdSdj/Ek+2b50PFR3yR6j/hyodrfmEk?=
 =?us-ascii?Q?orgdhQP4Wg/blYukB1oaRWO/YoimZAp8hMpvAQGgvc0uhsurP802XStTJUv3?=
 =?us-ascii?Q?cwZSO44sH4uGLkWbzyJ63Ql0q/Bc1ff71ZelYehfFJ0m3iK4G9DeTJB3A/jo?=
 =?us-ascii?Q?5Qs2sr+bPDCLIlVVAG5tjWEFT2iJrq0RMfQG81+my2IKTaBtMefi9Z7xpa3X?=
 =?us-ascii?Q?lTcwLtkGMX9sJa/yJ3H/LuGdgxEdR9jkP1NNcuFNPAK/7mH+aCvJ99+wlmQu?=
 =?us-ascii?Q?kbEzX106RPMXAFzFEgMM6ETep3DEdV5u2Dwy81SlcH7YLvLIZsTptGGfrFhD?=
 =?us-ascii?Q?nIe63TvbGGb/qHo3dHrXImrwH4MP/9bSa8fC274zBzkwjbZg7YbQNRLsLhyw?=
 =?us-ascii?Q?ZF+95J/g76M6xyWi4AAi28qfcDmuJgfQ4MmXKaiif6tlc0w95cXPtBQICsRr?=
 =?us-ascii?Q?9jrdawXvolhoiPjDcBnS+UhoJta3p28krWCVgzZZVL+cnETDWo8y7AHqw33f?=
 =?us-ascii?Q?uM9JfXZqb3J5XdyHd83aY01lsmPt0mNe9rsW3/b4lmLklNNuuOzi3XvSTwdE?=
 =?us-ascii?Q?lakdvOIElxaR2BwXvY+aXCPSPbV7d31m3rI7jrfM4/aRzBEO9OHMxYWnEyx8?=
 =?us-ascii?Q?VZziPrXy68pbkn/CsGwWExiNUSRgEHP1tykR6H+ALcj6FXGLT2xcg/gl/CdW?=
 =?us-ascii?Q?ySbJQcAH3X5dy4Tz6DynE2jJrR+NEjzHZ+9a7+KxiUBj8vpziAv4HzGkptdQ?=
 =?us-ascii?Q?iBd4iENOIQa6yMBpZkm9jC90FAJ9CT3/N7DRO/uSuEYRbU2uQRHv/7n8oQOS?=
 =?us-ascii?Q?O8OtkhzoGs+qajBbYM1m3iu3CPQmEW0s7+SJzU1MroHiF4e9/mGMgOyN7PoI?=
 =?us-ascii?Q?e3braNoSIKfB2fJi0fT0B8liu/oYir/Gvu/dihaFy9S0Y6M3390p1e55kWxl?=
 =?us-ascii?Q?BR8suD4qbMhZrXLtdzB+gwNLGC5hKD2kn07kNcSGLtitNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X7ivfvyn0IPTe0vwJoCFa5fIBcssX9eatyJd9n2ypMTnQoFbj5F/sL7RMPmr?=
 =?us-ascii?Q?GKSFB5h8viMYdpcGgcqqxkHDQCBHj2asq83pbdvzHTIJk1JjKM4kWXiBtid5?=
 =?us-ascii?Q?ESc6huUOQRJu2ZnUy650a332mLwkTfEx6rfBbu+5HZCV/BcJn+MRk3nDdaD+?=
 =?us-ascii?Q?opMt+vW6q/pVbobU1rC1oAgOOgaw7094Fc9teiTQWNiDIKB/sfJ//mBxdXZg?=
 =?us-ascii?Q?QeF7qJNjt4hX7b4JQAwzKjvEg4qSH3u7v9SmTuN0YCjqOnW+Pgqe0Di8rKvj?=
 =?us-ascii?Q?AWn+xyBPpnCYTMB/lKqVLrQHD6wQQuiX4aXoFkb06x5AVNiYPXrL1/gFNPVY?=
 =?us-ascii?Q?ebtOahmzGG9Xy4qU4FAYSU+h02WR0OhvKuRtMOH4C81NYa+yNn/giRipOOgt?=
 =?us-ascii?Q?kAN5MvEDMC3hESamp9jqsgBiZ16gtd6Zn7FEXXzUtfczPy10N+tEoBvWmM6a?=
 =?us-ascii?Q?AqNNuj/C9ENagYYAWxDc2hxi3jp3YkjWnDEim54WxYZOZXwJ+7txy0USqxj/?=
 =?us-ascii?Q?JMdlHq4WogPPQ1WjaYT9YthHNx09esO1SxVpdL3mkdLYhaSfus063nAKTlMG?=
 =?us-ascii?Q?Hr30fRYmD1HrglrUDC2GIweYcigD4J0zoL5KzhPsXXsNf3fg748Rmgg19Wof?=
 =?us-ascii?Q?RvRlB8szl8AqVrsbCw5HaG51IccOBWNaC19Oh/38YJkTH4DXNnX5dHHVr1P3?=
 =?us-ascii?Q?/dI3djqttNDA8H8Mi48ddXh/HL1D5Bf9t1cIQFGNYF1eY34RytwOSAEedJUl?=
 =?us-ascii?Q?xf7H12aldHPKW4B6S/NiTDlZTi8k5XOnVtiOunzEadRBLpE/3LTutF5aFi2n?=
 =?us-ascii?Q?FQXLE4R1V6dsz3TeeXBiSqbm1E28Wi0+gm+2auXdZfHaRUi18KnDsKKfTTSd?=
 =?us-ascii?Q?ZFuZhoaxe6A9IMsLHQz2aYMhXRi0eI9EoOqjG1vJPe7c5Posa9jD9erVejjZ?=
 =?us-ascii?Q?kZk+7M4JMJ2VfCC5gKsxqNyPNadHfMtoMUI1QZTklEDJtAIvuHaZ4g081/TP?=
 =?us-ascii?Q?Sv/k2GaS+r32mInDF6dad3yNYPYs7T/QGgx/a5BM/S+sKQVnBjdX5b8QOqh+?=
 =?us-ascii?Q?HNkSCQdcFrDCUCFd/2fWbq1RbBC3Vmp7cNJtO3tcgvTc8yT5yxT5N3JOUaP7?=
 =?us-ascii?Q?uYJz5T8W5v/PHzdsD7qJFiIy+B0Xy9nAXM8Wb2+9cp1m6Lxzw30hpEEbBoT2?=
 =?us-ascii?Q?s/Bk36ITga0WAHNd/p9MGNRrVg3CLyHzLjQcPz4RMT/H/btFsysafVQFgrYK?=
 =?us-ascii?Q?6E/d9gTXfqQBv6MO3nnSpxPmZ6DMdClOuGIwNmtt2QRxg9Oaj4kT4q+g/3Py?=
 =?us-ascii?Q?ce86GB65ooRu3w7ps6EY6Gg/BETyfR6KCYNAHI+B+tDyqtd6LP71ZnR7PHlO?=
 =?us-ascii?Q?/RtkJSI6E2K0Gkiy3RcswjfokbnPC6F/RUQiygxoVQENwdVEWNgiEDMSVsT7?=
 =?us-ascii?Q?XqL12q1ZwAWLjPEwJWv514jvO7quzAu8TnNgVM4IwiRQH+leUJdG7Sjplz+Y?=
 =?us-ascii?Q?Nkk3eppYziuIA3tbghqnj4QfCi+rj7iafI8JlCxRurzjoG2030fI2XVT9ETx?=
 =?us-ascii?Q?TdQX9gGRwf7KL9ezpKraRc/m3ROf4RBzpXxtDBWJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7867b3dc-0d15-4a91-a0bf-08dc83e54e25
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:53:26.5343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eu5b4dwTNM1JFZyseaUGPXA+s+k1qh1dNsLrmlyZz6ixot+zx20b+v2ASbBaN5x2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

fwctl is a new subsystem intended to bring some common rules and order to
the growing pattern of exposing a secure FW interface directly to
userspace. Unlike existing places like RDMA/DRM/VFIO/uacce that are
exposing a device for datapath operations fwctl is focused on debugging,
configuration and provisioning of the device. It will not have the
necessary features like interrupt delivery to support a datapath.

This concept is similar to the long standing practice in the "HW" RAID
space of having a device specific misc device to manager the RAID
controller FW. fwctl generalizes this notion of a companion debug and
management interface that goes along with a dataplane implemented in an
appropriate subsystem.

The need for this has reached a critical point as many users are moving to
run lockdown enabled kernels. Several existing devices have had long
standing tooling for management that relied on /sys/../resource0 or PCI
config space access which is not permitted in lockdown. A major point of
fwctl is to define and document the rules that a device must follow to
expose a lockdown compatible RPC.

Based on some discussion fwctl splits the RPCs into four categories

	FWCTL_RPC_CONFIGURATION
	FWCTL_RPC_DEBUG_READ_ONLY
	FWCTL_RPC_DEBUG_WRITE
	FWCTL_RPC_DEBUG_WRITE_FULL

Where the latter two trigger a new TAINT_FWCTL, and the final one requires
CAP_SYS_RAWIO - excluding it from lockdown. The device driver and its FW
would be responsible to restrict RPCs to the requested security scope,
while the core code handles the tainting and CAP checks.

For details see the final patch which introduces the documentation.

This series incorporates a version of the mlx5ctl interface previously
proposed:
  https://lore.kernel.org/r/20240207072435.14182-1-saeed@kernel.org/

For this series the memory registration mechanism was removed, but I
expect it will come back.

This series comes with mlx5 as a driver implementation, and I have soft
commitments for at least three more drivers.

There have been two LWN articles written discussing various aspects of
this proposal:

 https://lwn.net/Articles/955001/
 https://lwn.net/Articles/969383/

Several have expressed general support for this concept:

 Broadcom Networking - https://lore.kernel.org/r/Zf2n02q0GevGdS-Z@C02YVCJELVCG
 Christoph Hellwig - https://lore.kernel.org/r/Zcx53N8lQjkpEu94@infradead.org/
 Enfabrica - https://lore.kernel.org/r/9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org/
 NVIDIA Networking
 Oracle Linux - https://lore.kernel.org/r/6lakj6lxlxhdgrewodvj3xh6sxn3d36t5dab6najzyti2navx3@wrge7cyfk6nq

Work is ongoing for a robust multi-device open source userspace, currently
the mlx5ctl_user that was posted by Saeed has been updated to use fwctl.

  https://github.com/saeedtx/mlx5ctl.git
  https://github.com/jgunthorpe/mlx5ctl.git

This is on github: https://github.com/jgunthorpe/linux/commits/fwctl

Jason Gunthorpe (6):
  fwctl: Add basic structure for a class subsystem with a cdev
  fwctl: Basic ioctl dispatch for the character device
  fwctl: FWCTL_INFO to return basic information about the device
  taint: Add TAINT_FWCTL
  fwctl: FWCTL_RPC to execute a Remote Procedure Call to device firmware
  fwctl: Add documentation

Saeed Mahameed (2):
  fwctl/mlx5: Support for communicating with mlx5 fw
  mlx5: Create an auxiliary device for fwctl_mlx5

 Documentation/admin-guide/tainted-kernels.rst |   5 +
 Documentation/userspace-api/fwctl.rst         | 269 ++++++++++++
 Documentation/userspace-api/index.rst         |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |  16 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/fwctl/Kconfig                         |  23 +
 drivers/fwctl/Makefile                        |   5 +
 drivers/fwctl/main.c                          | 411 ++++++++++++++++++
 drivers/fwctl/mlx5/Makefile                   |   4 +
 drivers/fwctl/mlx5/main.c                     | 333 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/dev.c |   8 +
 include/linux/fwctl.h                         | 112 +++++
 include/linux/panic.h                         |   3 +-
 include/uapi/fwctl/fwctl.h                    | 137 ++++++
 include/uapi/fwctl/mlx5.h                     |  36 ++
 kernel/panic.c                                |   1 +
 18 files changed, 1367 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/userspace-api/fwctl.rst
 create mode 100644 drivers/fwctl/Kconfig
 create mode 100644 drivers/fwctl/Makefile
 create mode 100644 drivers/fwctl/main.c
 create mode 100644 drivers/fwctl/mlx5/Makefile
 create mode 100644 drivers/fwctl/mlx5/main.c
 create mode 100644 include/linux/fwctl.h
 create mode 100644 include/uapi/fwctl/fwctl.h
 create mode 100644 include/uapi/fwctl/mlx5.h


base-commit: c3f38fa61af77b49866b006939479069cd451173
-- 
2.45.2


