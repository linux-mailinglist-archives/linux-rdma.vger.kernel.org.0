Return-Path: <linux-rdma+bounces-4214-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0B7948FF5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2024 15:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7651F21B08
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2024 13:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72391C9EB2;
	Tue,  6 Aug 2024 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UqmSg6hk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B643D1C579A;
	Tue,  6 Aug 2024 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949459; cv=fail; b=NvcYZ+tuV8qoiwuA1qJbCPecuM9n9Pq4Nx9n1XCB3oc3GaupDO+76peWJ0X/jeCjRohN3OstatZpMbWcXo27UGheLcUPUNBdDOFILpm1TDwKnbiPX0A5SPYqWzFntzz449RxjAR3jbhkovi8KX6Yytgvu4URuBPKXIbyRyq0Vz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949459; c=relaxed/simple;
	bh=4NwJ6iMZ26ZL7KVRP6n4Ga7UfglbIhX3wfemYnXQQeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LZVZ2laV+pBY7j0JXURTRKtlMvRECbVmr7N2nrEev5fDTnIq+nJHXUF8fWwwZ2P+/Bwa5Vg9k6gBXNnSLRkghsweuuErH0tVkX/jzpMvTyVke3f0xWPRoTBw3Iuspvjnja4ZLIJQLhO2uVvS8Gh2lHRDDquEduIDKYVNa4Sx9/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UqmSg6hk; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChuX1MtXzQZamivEJg8csYvawhfy1wDDMD/DAscfAmGfSudLeLVzeS/fmmosXFeasIZ5mnze1q6/kyB6qwYg55v2qRD9KR+yquoXaTdnTBbaQna0ibaMm+Xz5Kydvv3FTDWVrY10qjxD2rZMsn1ZvMwYBAXUe0UlLEG298jfYN5GSKSBN4YR38RAzVI5dKFSvek9RXY8i74aRqdAm+WwRnTCf7FV0xQC2h21MlpQmMIEVgNh3bmL4E57qEPXYuQemzx1GBInW9eJ5KzFoErlAdu7CcviCP44JO7GSlKBR54Q5WSwCP3CnoNWO2MWy147Tl34XxWezbzMFGt+kQ4Y5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeAILLEXsuFkR5RFTweH9JM769K2hu2iLrf5COpKZ/E=;
 b=aRkJFaQnOL5ugkr8yskFO+O3rAUe7VywmNwoK1Claqfz1OUlUUpq2cigG+S4xOUbDxID4pMGWQf9DOscZzINtOhgHJIvY8R8c+gb2dS65VJj5/8floma7o+gf1+Gs83VDAtgeBM7/TJelRbyTUjOv2b9oHaCAuhaYcnvFH8YJmoKcN6rZA3M3M6e7FqQCCzkXP2TRxO3bcQKuhXeljiNuk8uPArOD8npMlM3Nqq5kwGPkkxm31CyTVAstB4p/wE0JaoRFbX500vA+y+U1CDfRVC5D77M+tGgxKPYDpOTqYhFD1inEsgFzvfeqzDNATyUiuTSQYHI1Z4VdoqeWyUYxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeAILLEXsuFkR5RFTweH9JM769K2hu2iLrf5COpKZ/E=;
 b=UqmSg6hkmvVJRhSlYhBAk2R6t3OqmnwTBtJzUUljOBBKJqPPYlcLcnghKxZWip3Kdk8cFSmzf+79IiN+axg3O81nWAM02+G9dWzVrRU8yXFyVYAIcPhWsx5GlTTktcKVJw9RXrouiKg0SZyaTS8Voyp0u8f2mBYh4MAu291zLHO6daLEaKuPQ7Scowj8O0HBdiSXzMBgyXQtaPWngp7cH1TuLrOPIYrXNVxxkOqftqBGssmrCzz05ywIaSYy/scLP9mhXYJ+hjDVW+ONSWMTWFblhdoX2kBt7+N9vlPrSFE3BSXvumwBKSt43mvaIe4mVNRGqY24J86RfN8+P6Fchg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 13:04:12 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 13:04:11 +0000
Date: Tue, 6 Aug 2024 10:04:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	shiju.jose@huawei.com, Borislav Petkov <bp@alien8.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240806130410.GK478300@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240729134512.0000487f@Huawei.com>
 <20240729154203.GF3371438@nvidia.com>
 <66a81996d4154_2142c29464@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZqiSfC5--4q2UFGk@phenom.ffwll.local>
 <20240801142223.GM3371438@nvidia.com>
 <ZrHNTBJV5aybQrum@phenom.ffwll.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrHNTBJV5aybQrum@phenom.ffwll.local>
X-ClientProxiedBy: MN2PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:208:236::13) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 81aee6a3-2275-45c0-f022-08dcb6184409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cw2KgHKLYWvDEcf+cfC2/6sk5m3DVFtK7fU1AKtszg0cUey3zxDlZR9rtGsZ?=
 =?us-ascii?Q?QrUsB6VjBk04Qwo/9RJi6g3sLiY4cW1JKw+yUR/cDt/dDD/RkeIU7vTHqE0C?=
 =?us-ascii?Q?zAvdMUJhU6j+8KwOy0wYkiEO+OItN/FsdYb7q6plutNf9Nkk3iZjGgnkpdvu?=
 =?us-ascii?Q?xXCJyWEnfYRuXVLFAr1dIMmITnXN2ZYSRJ/oQjLKMSQd+SaBlurhKfJSQY95?=
 =?us-ascii?Q?Mf8CNO04LU4AZxcUS2rUkXMN/d74VW3aiAYnSnf/MLFdBkzBTxp1p7sdOh1G?=
 =?us-ascii?Q?Po1tOvjXYlsVTNW6hiWy9ir7rkAa9kdynQF2uOCvCqjiwpKThn+8s0lh9onI?=
 =?us-ascii?Q?CPqyHZw5W1s3IAQe0vKgbVn2pmhhyeE2vslgThIiYJEsbqN2lIwFOP+ygkXy?=
 =?us-ascii?Q?hXEQ9C22xnYmzUuRkYPXiRNZDfkQ+LCyEnON/i0k5pxFaNpz/kLReUla5fn6?=
 =?us-ascii?Q?r00M4l6F0AI6mkNqUOWNV7JWdmNU1CuVxPNHTf6dbNXCiVgSqXNIZue0CoAp?=
 =?us-ascii?Q?co+ZAm+tJq81NAVAOcAGbX8DMiEHV+6j+0nD70r6wifFJLnoktV7umrMR3FD?=
 =?us-ascii?Q?FIIP5PaN4O3dtF642ffL2AmYukYV2aZwum9nuIVJxmWJj1lEi9as/pAHWT2H?=
 =?us-ascii?Q?I7OCCFzxTqyJEVDkkilCfbQ2pr5yVsg+z++A5Kv26zRZivFgAbLyijAUFtTe?=
 =?us-ascii?Q?HyUGWSsM0V6PxFkMMYVJs/xAy2KlmzlMDFX4+51p7ZWcm9loybpGX0y7QORQ?=
 =?us-ascii?Q?4jGtiIhTx/0LE5bZ/IbMKwKlO24WiRPTwsjlWlXhP8BsNCR9H3FH8Oaa0tXH?=
 =?us-ascii?Q?FlQhFZpPG741FThkzN0qO2OQpWo4UpnvZiW8pKGd0xzuUd420NzeAcWm3EcV?=
 =?us-ascii?Q?Rczuh5ZhieJ5wBpxCZRgSUok/f3ZOoZhgTd5l9Ves4bLkqt+SQSbhJGROwnP?=
 =?us-ascii?Q?rOMqh2AabmBpqnXrtpuGt5qPwYfO+gAPFIlxNpxwztuEmafvnate0n7hWzkx?=
 =?us-ascii?Q?bOaq4rtt5fyrLXi6loxJ8HY3U9PHT8b5vA6sDRESJddm3Bl+qVW6jQ+Wvy+0?=
 =?us-ascii?Q?BfXqXVFkLvw1eqIoXWwEFeTYQobS5HEfrBw2ajNfJk7NvXRRK2tl+n0w55/L?=
 =?us-ascii?Q?GAAtKN5e7qbyM82Xn37hMeRCs2ipOUAwEwd+TsZCFVNWSmPFNiDlWdb+3zVZ?=
 =?us-ascii?Q?hy28upVrcuUmNruPYJNVWF+58n/1OpCAZWsc1JGjVJASWKI07OpSZOB4Y9pj?=
 =?us-ascii?Q?Wv2TnbWb+eGFxwJ0tT67qyBD44iSmTEYImW/hrlcIeyr66HAbigAKJkzVlTH?=
 =?us-ascii?Q?LdPJVlTmbDZv0r8cstP39GJjljc19M+sgbOWyLOJ6Cjz2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U7lhZhDeykY8zSnK1BrlnfILWg3xRmfToXEZ56B2RiI5+vrLqfHmCFV5NgyQ?=
 =?us-ascii?Q?BdQFEtuGKf3VeBr9veRZSg0xOAr4YdJQ1r9juaQO713oUByeoVcRG+R3xmnp?=
 =?us-ascii?Q?KSrMwjT75pi9IVpY6AMCtaP8zdxMxe623XpkIHcUMOz98C/IfAuTD2vRIBzT?=
 =?us-ascii?Q?1YD2IkhVaqVDGbOx19nJX4XweL+nJDbPkk88dPzCpLfAuz/um5sf6DW8LDW7?=
 =?us-ascii?Q?Q0FPTYJy33UsBjTeHKG/e62AQ6u+svXMyw4Nqi7km/6wYvi7I/pmYcbCe3bt?=
 =?us-ascii?Q?js+ulhIv68oi4goRHahFtARoHf8GBSWCd6RQP7mM5lhCh0OIDVDYA+343LDq?=
 =?us-ascii?Q?kJINsV9jncbMs1fSaBAOVRgdSEETQynLu9TBEx339P3wMubgyHyFk54w1Gjc?=
 =?us-ascii?Q?N8YxDjkm/eWhcDCMxbFXjrnLUVjcwSRRc23m6VOwPv8YDvIGYHzTEhszAbdM?=
 =?us-ascii?Q?HUkZ/wa0eDpY37y7onk4UFqLDYXJ7Y4tKjSA0E4OZnfdxba/UXDOmA4nd3Ws?=
 =?us-ascii?Q?dlJ6nP1TJNxqaNZR/RuSFqcWJXdWroitHLLpe5TC4YHpZn4imbdJiRsh8cQr?=
 =?us-ascii?Q?oRCZwf8FKDgCONDwC8d6raOc4FGb4TgoC8hQIKb9k+pl5+6A7uz/sjlrA+5s?=
 =?us-ascii?Q?iaSWdlBvNoPMEpUmq+ZO4QkQHZW0dt6oCrTigmBlOB5z6Od5YI1NHH3qEyHt?=
 =?us-ascii?Q?i8HgsHaCeXFSVu8yS90Jn9ylc9V7n/ax/GsZe3LZb3nZH56s+NBlxraMb1R5?=
 =?us-ascii?Q?MQ3y/yYc+bEHhJWverCh0rIfGgJZpEUl5CDre02nfLtsbYs0WTJM8maxhhZ1?=
 =?us-ascii?Q?ndhIEggQAFzAChFw6iWsG6tPxY7G1cKXkjAIaf4pQ4pEU60IH02JCjiScDHJ?=
 =?us-ascii?Q?+YjNuva84tz1BZKBbVtQsImfis0YWqd1bsR6jL4swh45yAXfb7VuZFJAzC2j?=
 =?us-ascii?Q?zQF+rwyMhwTwfGbtgu+pVj13Dp038Xjko9hK8G5OFtjGsHlqXvCjEKhmofxM?=
 =?us-ascii?Q?8ytNcuSP3vyJFD0WZDIwVlemx1P3OqrGxL3/CAtlw2fVXTteR10weyGQOt5b?=
 =?us-ascii?Q?w+czdWxu7kw3r5rIvY3TPfBgBvX5kyA2PpmDTXhb7nWS2dy/p4CfA3k5cDn3?=
 =?us-ascii?Q?pIlolpni6qfRf7QYBQp/tt+wTRhu4GgYsSkQk7KJbZMDsvkG8dJ4+dXQXbVc?=
 =?us-ascii?Q?UIDzQW+brkWrvOa0KPGRVawsbKVSwnSZVn1kjF/dbJcruC3FzKmbu2viJ3Ua?=
 =?us-ascii?Q?8oS0M4z22U43aAga+2Ik1AMGWPPJb5TO5YKV1+VfVDQItFxm6Bhl8qSL+y7t?=
 =?us-ascii?Q?0//7pCL9BjJGLO/nCBYeimHRDNwGGur6rw+Ib51Pqfg8Ru56jcenjsRSoV5Z?=
 =?us-ascii?Q?gDZLBuC37oD0BMUrYdZBkaaXp/6Qy9hfaaqrLmnK+dSG8bRn9TQv8RI/5a6G?=
 =?us-ascii?Q?j19aJnYz0khVo39s3hj0b7aEFAKuOz+CRWszHNgb6h7DvjA5hiTwOLDbUXjm?=
 =?us-ascii?Q?A5drvNNbmziLnO82U3Cp6lnRvqnbGWgVA2zcQhLPlocoWUNivJ2aRgV07Bzw?=
 =?us-ascii?Q?Sy0Q1y+syzEGBNe05mg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81aee6a3-2275-45c0-f022-08dcb6184409
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:04:11.8532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ING/F3IdbJbHXPqrb8ZyO/dZG5kuruUamavGoeZFtAZXlmoXQoCTtaKphruBf57W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333

On Tue, Aug 06, 2024 at 09:14:20AM +0200, Daniel Vetter wrote:
> On Thu, Aug 01, 2024 at 11:22:23AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 30, 2024 at 09:13:00AM +0200, Daniel Vetter wrote:
> > > I think a solid consensus on the topics above would be really useful for
> > > gpu/accel too. We're still busy with more pressing community/ecosystem
> > > building needs, but gpu fw has become rather complex and it's not
> > > stopping. And there's random other devices attached too nowadays, so fwctl
> > > makes a ton of sense.
> > 
> > Yeah, I'm pretty sure GPU is going to need fwctl too, the GPU's are
> > going to have the same issues as NIC does. I see people are already
> > struggling with topics like how to get debug traces out of the GPU FW.
> > 
> > > But for me the more important stuff would be some clear guidelines like
> > > what should be in other more across-devices subsystems like edac (or other
> > > ras features), what should be in functional subsystems like netdev, rdma,
> > > gpu/accel, ... whatever else, and what should be exposed through some
> > > special purpose subsystems like hwmon.
> > 
> > In my mind the most important part is that fwctl is not exclusive, the
> > FW interface and things being manipulated must be sharable or blocked
> > from fwctl. We should never get in a situation where a fwctl
> > implementation becomes a reason we cannot have a functional subsystem
> > interface.
> 
> Hm still not clear to me how you want to achive that, but I guess best
> I'll jump over to the fwctl thread and ask about those details
> there.

I'm looking at it from the perspective of mlx5 which has deep
multi-user support in the FW. There is almost nothing in the interface
that is "global" and would become a problem. Everything else can, and
often already is, reasonably be shared.

I think that would have to be the baseline for what you could expose
here.

Like with the memory scrubbing example. It would be fine if fwctl can
read any related counters concurrently with the EDAC driver reading
the same counters. But fwctl shouldn't clear counters or program a
single global scrubber unit.

This limitation has to be baked into the FW/driver on the fwctl side
to undertsand and block these things.

Jason

