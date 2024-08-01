Return-Path: <linux-rdma+bounces-4167-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9140B944DDE
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 16:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E4A1C2195F
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 14:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273791A4880;
	Thu,  1 Aug 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HSsLEtSw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDE716DECD;
	Thu,  1 Aug 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522149; cv=fail; b=HRJcMrmpMBjKNmtI/ct9WcCx955nxDlMS3DHY6wGe39ZWyPm16F6jSFw5lkY4ze56Uylje5K/Vj8byinLhRNxIQnKKH0AUIeyH0xHr7MAmeGl7szXwGWrZrJfcBCkekuYKCPyvep4vY1rFVMfRFgLD89bsTbn7+y5MZbaoyQyMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522149; c=relaxed/simple;
	bh=a1K+g1l5IsDM/asTCS8RYyBoTJnEqM1T34a7BVNCGxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O8G2BDPoUPVzgY2R8Kma0zzhwPa1zQHh7mFLtrRGB9mpEIjmDXRB0UJ5TbViVVPk7wDa+g5MIRShfdemlvFb71PUaHnIXYIgwId7asxhD2CGfgVaxoyY+H3ngWoBquXFUR1UO/ZBmEXWBXrIWFCMR6qVVL+yu11laqEwSlWE/08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HSsLEtSw; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+Zq/T1jsRupUBe/nXVhd9O7Df+olEDpF+gXb4dy/ugsdmE5KyVOhQwMj/Y8z7jKHC/PPXTsSAr1CYND2Ot6QgtVO01tO9TBlNaxlyX0gwlzsK1L4YpcMqNcYvdahxGZJw000ZJgNnSW5u5ES1hCXv8JtosvVwZAAVQdWgaB3YyFqlWjVLZCkq6ApzDwBYD0MgLO/W3jd6PwpU6R7ZGzu3T0XdlOQQS32yMd4xJgHAZvxaG0pcLcuh2zfduFOhEd3Z3F61ZXJCjFRqs59wQX6iYfz2J6BHZZ2SKvHrM4rDaaWHVUELriyvFfI97E13DD4PAGCQ1s66+4yaG3fsImYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1K+g1l5IsDM/asTCS8RYyBoTJnEqM1T34a7BVNCGxk=;
 b=T9DY4Hc5V6zp+y+oCc7pyCzdwf7EZ2uuHojXJ0SqY/gmhZq94Lxv2Ac4JERFaUT7mJJr1CPNUbS2n6sNX7mOFutXe3Qu9CUVp1Gcm4AZSe99vLoGbmqDPEHvhPPNli90VfVF2dpUqiED+64ErYttwCA6g1YCpFyludJuFJ3+41QzjnDSI0Y84ILY1+Ib4I6FcdlNlh4AaoWbkDECQGWgAZv0b3EnX1S/DbDOeHkJgT0SNyeJgRUzNQgES9SdhHQl4fuxkVAheVHquivEIUG3VlFEsN3d2ypLQU4a7vgGJjALCJq8bxzs23v3pDNr/ewZ87RQJzvUCq0BCyc//VUqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1K+g1l5IsDM/asTCS8RYyBoTJnEqM1T34a7BVNCGxk=;
 b=HSsLEtSw06sIT2PQcnGbI1vtooLSbWVcRlycdueXPa/vJCWd2u72kwrs3KSr71UopKMu9Aja3fd8LhPuHZD1SpWO+n01eF3Cr0Ik8Un+0HzohhYTcfmgFkYv8xzmsUjiNaPEVr1Mih9G0fWoN2a9W2zvZLh+zAXupp5XAoSML5Sm6lyF81k9qmqA3JFkvrGAvDgOYxRqvMmKdldy1Y0c/yGefnvs6te4dHyePwNSM6mOS45xTRKG5cZhIpsBtrc2nbNIZcdiV9eW8fKa5qzpjUDtONQUWCR5udmyKFfoAsYKiLi1g+iTL5MqdkEvl+ulm+F2WB02aqmvQeAok3SauA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 14:22:24 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 14:22:24 +0000
Date: Thu, 1 Aug 2024 11:22:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	shiju.jose@huawei.com, Borislav Petkov <bp@alien8.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240801142223.GM3371438@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240729134512.0000487f@Huawei.com>
 <20240729154203.GF3371438@nvidia.com>
 <66a81996d4154_2142c29464@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZqiSfC5--4q2UFGk@phenom.ffwll.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqiSfC5--4q2UFGk@phenom.ffwll.local>
X-ClientProxiedBy: MN2PR19CA0066.namprd19.prod.outlook.com
 (2603:10b6:208:19b::43) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd7df13-0770-4ecd-f365-08dcb2355d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qYkTs3X2T6aOw1Gfxn/BzJxeCBTI7pFOxCGvabfZm2AtwVbq/oB75UYgYgWK?=
 =?us-ascii?Q?b0QeZYPABISuXjbcfxiTts+xa1P6OyMHAXMRPMZ7725yzn77cPgKipWPK7uC?=
 =?us-ascii?Q?9tv9cx+0flpkTqOe67KUDZPtlsaD83boHs8dtn62t91GOK2e0Lbj+4Bw+rqN?=
 =?us-ascii?Q?YlqSh+4pKGX83TLUZeKFYhrSeuNkckKjH9716s9CNkWNSZ18U8mgKtk/PHxF?=
 =?us-ascii?Q?MThwqF2ZauU8iIVcW0q9K7MG3D0QT1bWEwSbMDwVhbrvOTTQfiXqGexGrsAk?=
 =?us-ascii?Q?aOwI359sv9Nm9DahKpXmpVXEkP9RtRzWfjv0l/Bhat64L3Y+D8V6vPP858Rc?=
 =?us-ascii?Q?Gor9XQ+cyUvEAmk09mP80em3ztrBOexzdKVeKyG+ZlFmvc840GGYvgXH2ewt?=
 =?us-ascii?Q?6tMNvb+tbPUDnnM5TQXcQ76QXeDGzLsibRTlx3j5XyoKXNsa1892SUlApLO1?=
 =?us-ascii?Q?C+0axCJcKreo/i0jlzaq8Cn0n+/YiWXXJ1RZjyZz7hBDmuuaywbTIF0PlrEk?=
 =?us-ascii?Q?5OLkISgWXvzEYUaPr0UVF611AXIAs6yWmGuI6BxM7LNA/j7ODcSCSzbG0C7F?=
 =?us-ascii?Q?j3ZhWtJ8CRYemjLxYvBhCn+sMIxRJOyEQrF8OqBpJx7xoUTpJN5Lhk/IW8j9?=
 =?us-ascii?Q?leppTjg5U7TuRxZph3eSLkbqLP1z6m8aH9Wx+lDPJGU/FBONuTOeGEZsH5Vu?=
 =?us-ascii?Q?uuwoejwxHIYeqWD8keTJIjv6WxtBZG5HKeBnNVhxrrcZyHkLKtiT9oGzu3ND?=
 =?us-ascii?Q?8f3Lf/qlBG+UWDHJXfwgGIKT0dNAsmWiOfNKXm+XJNNcR8ikp8tjfRWaUmem?=
 =?us-ascii?Q?WO5D81M/WqBy7KJoMT4x14YnId/GN0oD/H+5nTvNYmdjkVrWNF/GutMi2uWJ?=
 =?us-ascii?Q?FxALLqa/rHi5vgaidmtHkZkB1S/l25gPB58LDebKT6mqrvEaw7KSsPokgj9U?=
 =?us-ascii?Q?57EQ4lXQ043bHAWtdZ3tqE/GTK1zrCAC6EKxk9elY+6PGHwWW/Vv6DWibMEg?=
 =?us-ascii?Q?epMhL0BX7vAjA8rNuU++i59KxXW85wXYmBvI8Xy4jCuyihgJLD1/IycqKXPr?=
 =?us-ascii?Q?rybpNwF1HXlReJXJjnGJJbHqI4Bl/j0baksUNYv/zDK1fR49Ada+YnoJc5qr?=
 =?us-ascii?Q?dGsItC7pu2IE6o1W7WXtVH5Pk6dtAxACuJVhMyQsdwxPMWdLplsLbto1bqB6?=
 =?us-ascii?Q?0LbJcGRSq65+4mg7u/plKU09AdD9QuW7B4MacimWHYe2g35VBEne1oQQvFad?=
 =?us-ascii?Q?bXqvRfJmpE47Vl1rxtiBsQcmTbQNg7O7imj43aypAyOnXocS9l54XDwtvHnD?=
 =?us-ascii?Q?fW0VEoNDj1CK4xO2rRC87JrvV0mYTHRidWa75JhP4O29gg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MPZZdW6eRj8xTN9oBzEse/kVkJAdNE2GQbhSoVA3AW+41sqFK8sQU2wzzmcY?=
 =?us-ascii?Q?LYa/D3M/Hox5ZxRFGcCWFZK3inzNGoZvuC+5dkakcu19vzv2r2Qu8lUQkpd4?=
 =?us-ascii?Q?IojtpdpiN7fFjwSzqg1T3CgpSr1BIVcicEoeeW4it4sdS9D3JoL3a2cM1nq2?=
 =?us-ascii?Q?0DOsfu81t9aWybcHy1XYAKlheXbnhCLnrK9mny+lZfB9YQ4gLDwNQwGdXLAs?=
 =?us-ascii?Q?SDWsw8P9zEwoZse7eMqzwc7t/HdOjkGVWJQm96dASr7M6azz1AqA4pzxoghh?=
 =?us-ascii?Q?xwHGnUmSk8Mhgk6vNIbxIUUzWhkYfSiojrIwbsz2R1bc98JhsD/mqFZal3QV?=
 =?us-ascii?Q?sNGZaPeiG3yzJoZ+RGlcg/ePUnycYxo7ZiWOUnGhklB+XqII/EdlZVw/O/Uf?=
 =?us-ascii?Q?zGKh7aENMqXyIgpS0havMHgeoPPsP49yvzqiMlOmvQ27wNVBlhso6peaIqu8?=
 =?us-ascii?Q?4VsydKn2ftW8RJ6LWYbs6i9eKV4zAWoJzRXUym8eqjD3ApDZRG43U3fos+qs?=
 =?us-ascii?Q?0tnL9EWn44qhrhlGl+YQ8rdaemT6jTJCWaopNNc7AsI0Csj0kFOQhPqK4ntJ?=
 =?us-ascii?Q?ESGpp5Mpkj5yJEcM8dVGKaomzG4ISvFdNqGn9YRl5E5UVVcDdMg8dnaQwRAF?=
 =?us-ascii?Q?brGG+MHz0bOems0SWseDVxdpTDPvHe8m+UZF9ZHInuzcFmpCXN12Z9AKkVDD?=
 =?us-ascii?Q?MnYSSoCjg0a6ahP3sXhRlhxt98f+PEC5/wsIMdjt6Qhg6AHp/SgSvl+5Tghz?=
 =?us-ascii?Q?/0TBRP2BmvokcprMj5Kxwtxe8WWDaeLkJIFHbdjst08UTbjOt/uWn8waeQaW?=
 =?us-ascii?Q?eNo6A9L0oXBccEEjNJYsC553rbVpXNSiOmCI/o13djidciaQPYzhqn5WJj+6?=
 =?us-ascii?Q?p/iJadL2F8YvMh5Vxzx6ZXLKlpw95qE/Qdt7/9JdoxjLS3GMHvhpAGMWwGt7?=
 =?us-ascii?Q?H73q0qwfyCjp/cfEhDIn+vhY1RTrzkjVF6KNIcwF3OCpjjUIp/cEyfeyfh7o?=
 =?us-ascii?Q?uIbjzskDts2PEZwsdE+QeGcxprv4xl55XUZdk0gB01plQnbwu5gl84NRd0CE?=
 =?us-ascii?Q?Nn7NuJACQTQIjvEpAvg46AwS0Tpsttp/XJQbe6CH5FUjgXa0fhFfTmVqEetj?=
 =?us-ascii?Q?nMHDYdMZghFriuvfkoX0PsNQTs/rNu36HOd36t2fU3EcrWhpP3qfzX7BxqjV?=
 =?us-ascii?Q?L46D17eQTgEgKv5J4lc7IpOMYjYs5jVCbwzTIKzhjEX4azqgXXlBcdGo2ql6?=
 =?us-ascii?Q?Ze2aT9JxBT/BupalwsRAtoiyvAWAypzaGdWmlo0V3d46IsmIXpE1u72GQMOL?=
 =?us-ascii?Q?gYQhm3DuJS53mORrH4uDvCefha77Z3Tm2f9rXQghMeY/lMr4V6HduDwesTWL?=
 =?us-ascii?Q?kvQBYvXraKAJI1cMe6oD0zMVGlITBL0K9bfKuvko5J6qpPN6HDyBc1aDI/6H?=
 =?us-ascii?Q?zId1xETXGWHmSMhCZFNlM+aHib4yvmLC620iuojVXnWcGM1cDriZ3kcYtXYt?=
 =?us-ascii?Q?WrYR6B0+RUntwdVAMgIfJxKsH98PuAq0bYr17AWOk/j6zO90S/vaWyQ7dbER?=
 =?us-ascii?Q?HBcSfqsYepxLZ0+2KbR32N0nbwv/VR162qcjKM0O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd7df13-0770-4ecd-f365-08dcb2355d1c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 14:22:24.6147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XPRrPn+cfGZPLcqYBW8umYlbsLkUBS8cN7W5T38am4IxJfWvLaz3HqvOh2eGXT4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470

On Tue, Jul 30, 2024 at 09:13:00AM +0200, Daniel Vetter wrote:
> I think a solid consensus on the topics above would be really useful for
> gpu/accel too. We're still busy with more pressing community/ecosystem
> building needs, but gpu fw has become rather complex and it's not
> stopping. And there's random other devices attached too nowadays, so fwctl
> makes a ton of sense.

Yeah, I'm pretty sure GPU is going to need fwctl too, the GPU's are
going to have the same issues as NIC does. I see people are already
struggling with topics like how to get debug traces out of the GPU FW.

> But for me the more important stuff would be some clear guidelines like
> what should be in other more across-devices subsystems like edac (or other
> ras features), what should be in functional subsystems like netdev, rdma,
> gpu/accel, ... whatever else, and what should be exposed through some
> special purpose subsystems like hwmon.

In my mind the most important part is that fwctl is not exclusive, the
FW interface and things being manipulated must be sharable or blocked
from fwctl. We should never get in a situation where a fwctl
implementation becomes a reason we cannot have a functional subsystem
interface.

> We've got plenty of experience in enforcing such a community contract with
> vendors, but the hard part is creating a clear and ideally concise
> documentation page I can just point vendors at as the ground truth.

Well, I tried with the documentation in the fwctl patch series..

https://lore.kernel.org/linux-rdma/6-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com/

Jason

