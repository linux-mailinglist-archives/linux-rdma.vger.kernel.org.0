Return-Path: <linux-rdma+bounces-5182-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1883498D3F7
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 15:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA9C282ED9
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 13:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CE41D0140;
	Wed,  2 Oct 2024 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ax4FTk2Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FA219750B
	for <linux-rdma@vger.kernel.org>; Wed,  2 Oct 2024 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874273; cv=fail; b=S8mg7gEszSPF93CsYPg/H8S4gZD02YS7eTUritUcCRqNXfGg88pTU2ivYxnxT8lrKG6ITxGFPaBZVTQYY9uLOowCUdTrQlNg9Y0Gx7WeY//aEFDoz4fzdut0fgVZg+weTok01aLK8+vIWzvGurjU3E8+uvfC/StsBMB5r9rpj4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874273; c=relaxed/simple;
	bh=FFLG9WAsCzZx+4sT5KcFV3DtWMP7g6n8PezDd3MfQe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OSDW+rj1G3KZa9iBdnquKCajQIrneNeACwDejxrFLqxG95EkN2sd0I7kTcKMDw+MdVh3xdwLO6N7DUAjdphSLpeKrsv75EkzlhDTZlwEYN6fJiApHspsHcWu1sWmsw/QsBlhUykPxHA/+7H55+qoSYdFCbTMErnw63dmjaSnY98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ax4FTk2Y; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvmmgZR6cp6lkpP3E+UQUW4Qo9vRsli4ut5EfZzNQrTQS61ylV6rT2zJ1XNHlbuVXdR9+lL3Ih3qWRfY3GDUUExfSZ2gC9vdBIfHOT0MaOHSOwVzhtjS22OLEhceqQd4G7fietkO3cKXFfhxfCgegY5qAlH3F60B+VRIb0Z2u+Bc93541l81vycbb000AnqE8yXIc51ERoKf65xE8Z4Ov48/DV6RFnncSWnJS7R53jOay1spYpBXc0BVS1J/ezYOBMUQSQbnQR/Dn9L6G0jPA6Fg3Mx5gk9tusVQqGBXC3Rg7SyPZ+BL+I/fEysC3BPLwKDJ0M3vibiWkM0xgSK2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gClRHW5VF2zysH+5OWd3kR7qcM0n+FckGMc8NlpM+WU=;
 b=jy3X8kABnl+u1+0vZXnPP4IPAhbpfs7lYGNIqMHVZs9VBCiw7bruJgYZozOabFYifS4Vg3ES9pTnFkn6RGfwBMfL8IgBGkAMV+YmCzKLnsOgH5gyXw/JquF0uTb3HWXHXZo2OeoLl4dYgIu+6TqurNlNF1Fnwv8VFqtL+ViYUOMH/Xe8rCFJYpJXAURjKa5/7xV4nxr8DDFbF85NHAe0Ha9mxSAJPMyAmQB5Y+Pl6739bP0w2Q3/HALyK7yiCIowyQeU8EYA/fLQ73+C4fm7ENpLJXUijhvl+DdHfcmoGXjtGbpNqsOU4qQ5LtEEFMqVdz26EO4vHp9e/+dHRIArVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gClRHW5VF2zysH+5OWd3kR7qcM0n+FckGMc8NlpM+WU=;
 b=ax4FTk2YUzjzLJf/2SGNVokI1ewVMjP3Fbe1e1HY67+D6EYae/FxWWK1v1pTdP4g3+io8uJmKogEW5ysSvlc3YpclnLaAu0o/q0rCm1OTMGHeiLRWLiOWyTD9yeWpfPH3xa3ww8HUe+9GvUpwc/IICTbgiGl5Oij3nrmbZeBh7za9bhrjveOpZQu8qPMzlo9gP2AXOzeYOMW1E9b72wuIrTy1NqjunJecrRcf9NwYxvVOM5+/7t/zh+L5e6EkI6b/0zaB/7a4MLf3NrZfAvcOA/u8hSxD6ig45wpTyWqLLwt70qIVwcSBIoe1JjsY+5anXHhO/qflFddALCc65Mvbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 13:04:29 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 13:04:29 +0000
Date: Wed, 2 Oct 2024 10:04:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	kernel test robot <lkp@intel.com>,
	Yehuda Yitschak <yehuday@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH] RDMA/efa: Fix node guid compiler warning
Message-ID: <20241002130427.GQ1365916@nvidia.com>
References: <20240924121603.16006-1-mrgolin@amazon.com>
 <20240924180030.GM9417@nvidia.com>
 <7aa4bf5b-17aa-474a-b6c5-c4b0600f30a3@amazon.com>
 <0aa53dd7-7650-4d53-b942-00903e41dd9e@amazon.com>
 <20240926145423.GB9417@nvidia.com>
 <08cf6d96-02f0-4974-ac69-b9a5184bfb20@amazon.com>
 <20240926223400.GS9417@nvidia.com>
 <e9f442c6-cf22-4772-9aee-e2e36f4d2029@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9f442c6-cf22-4772-9aee-e2e36f4d2029@amazon.com>
X-ClientProxiedBy: MN2PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:208:23d::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7149a4-4d9a-4479-4f60-08dce2e2bfd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I4qKzIUs6EQWBMXUEB456FYzmuvrIXUcI+iRp7rJqJutwv67vxsqyKtu7hmP?=
 =?us-ascii?Q?TR0vw6FdUYJ9iHQ5HOnTwrPs0YD67t8S8Qsp5h2Guh00Y+g3K9j2kpg/CpKZ?=
 =?us-ascii?Q?OA5L0E+U1uAH3E15BH1xieGAo4nPo9Fh5/Bg344M8uAfpZ7SEvfKJrH2wAqD?=
 =?us-ascii?Q?tBwsf36+jeFzolEMkg0UFbdIthfsGkZpWE4xDmWW4mKeHSMziYVXXKE9uUVn?=
 =?us-ascii?Q?8tRG2Lxlg2gkSG2b8jRgZWM2/nzCs18HZBR7L0cG6U+Ohcxkp5JgAYntseG9?=
 =?us-ascii?Q?t3SUBHi3aIKVzgeMWiD9BUwR+9Pn7yxhFQzAGZzt3GbxAIgOq0Wuh65OfmQI?=
 =?us-ascii?Q?6DrmUFm+0zn2MfyNOYBjjYBupTyWRiZJN2Ac1hnlZGAsYEV3UrqdBO7u2G1q?=
 =?us-ascii?Q?KUE07uAICh/bJeGAv4Au0TBnWhAd80aaTi0zgRUbH6y5SJRGw93pQX9Rn7+8?=
 =?us-ascii?Q?zJ22vrDtWqmTRWYC3LBZwxWuH53BHJVGGEhbXY5qa0c+u+BwXUdKCXDBd88J?=
 =?us-ascii?Q?uQvJiRSkEbyFtsj/iq3Bo+A/TRpR++G3PSvHYog7qL6/BCF2od1oEQgn/W6S?=
 =?us-ascii?Q?So5yRTDudzap/AH+1YJ7cUWm4WjDnM5YbRt0SB9UeNk+pbzuEQkWIIBssaAS?=
 =?us-ascii?Q?Baa7jHQgkw6P/5ceiJU1KoZrkB6HLOlBx21qj1GDrx6yystVjTUhjS27xM+H?=
 =?us-ascii?Q?W1Ju9+pRLpWpJzXq1VkMqfLtUQl/UzDpKZOxggS2UfJ/ISIDJM64EfKp7fjY?=
 =?us-ascii?Q?3bJeK0fc/HO8XsRBdnjSp6vGDISvbyvzM12VT9ROn2e3BBVH1iNqzx7PD1dT?=
 =?us-ascii?Q?+kLN1l5QCQFNukxFjUctYx9OU1HXQPbd8AAZjOS4cQVLc+elhzXzGOf2YFmm?=
 =?us-ascii?Q?nEF1HQYg+3l77dL0vByn5FIabsO8Ft0YHTyXgcaKgpdSQOGuNz0Zd/mqyjfX?=
 =?us-ascii?Q?u7NuwDNWrh4ipBTq0DTY1QF9mOZS2Yi20Z7Ufv4OPI/PecHOXBGeqQJ9FX+Z?=
 =?us-ascii?Q?vNmtXKisQpcFkVqBhjMQlfWgoID9mfmq8odJaiq0IrYvdXk+fpRkHB1ZT4qn?=
 =?us-ascii?Q?gKNUgfXT5EoUScuss0k5zAjZxpv2Ik7eKA6RfThuGyLiDlwcXqzBNWDIa9bI?=
 =?us-ascii?Q?UfQbBfhq9RemDVCOgI8qa9l1RrSF5dHu/DKfh21RABaorHjCRcRN/5R77mrf?=
 =?us-ascii?Q?vh2BPWrpykfXXKxZXmTiJQfgRbQzjXGjHhcl3d4dvRW1q/baWUS2eZnA5rlJ?=
 =?us-ascii?Q?ApO10lGN2AbGX929PnypxfToaNDDMZp8ipHI6R1E5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mnDxDCIf2cTYinivmQUB5Zi5AEFKdTdMUYaZeba87O4XG1XSVkJsTi6905Yb?=
 =?us-ascii?Q?cS1BK/BDhR1V73sZT66zB/xZ7S+FaRf9JEXM+zEcRg5FWegmefHPTe2WKcMA?=
 =?us-ascii?Q?zNg1osxxhYKOhcpz8rP+uFrBQB7rIDPzPPk4P8m1YP0SgufHnxKT6qopmEvQ?=
 =?us-ascii?Q?7d/BCrZpJ8L+PUZMA2vAf7cHW7THV1Cf3tGElnTOLZC+Zvlzi7PDYsvqz/ff?=
 =?us-ascii?Q?7CZA0rylWV+tySL7CA+NIc6cOoBXevSFAR1knW3M/un8eqD0r5DDNWcYxYg2?=
 =?us-ascii?Q?n7xgVmonlak29i12yoKYmUiPHsaV616YPyTuGCrJN5BDTyxYmr0/Mkr0voXm?=
 =?us-ascii?Q?nB7UvAaPcTp7el9wU0C1MHgq44LnPJ4xjE6v5xpeMDJ2m3TKIs3ipT8b3ngs?=
 =?us-ascii?Q?S4SOTVZUZ440Bdv204EpobO+vPoFDKwaBhvHpLSt/lwzwJjupESrZOpjwB2d?=
 =?us-ascii?Q?UrTjC4Ryu+ftwMaEO6SmwSkAEaHX3l4UE3hmEQ2L18s/dreNXZeRGr4HPHTv?=
 =?us-ascii?Q?T630C+mom1r5vLjKMCG2zXIpVZbDVNgS+EXiy/CITPn1J64O1fA6uTJzfY/P?=
 =?us-ascii?Q?jAv2hcPXpyfUjxJxbcacvUKM10TWN6uYM9HQ5krO1lJobUyoiSMTy4Wb2WG4?=
 =?us-ascii?Q?qllDj7a20BxD5Yq9jo72i5xZq4LHXYjQ2U1DeIz5uCpK+zHI0KWv2HfFSkx2?=
 =?us-ascii?Q?Pb4TacvLsbsyxYfJc0bnspJnFnddFbKeUzYYIkw/I4CJEi7M2LeNCPj6JUgF?=
 =?us-ascii?Q?muvetUw61402C+YQMfQL2oaLf97nvSHOLotR6gUDfAQb2/HDTzdSZ0jvbNus?=
 =?us-ascii?Q?nc5La5k9/tIJEpNhNzYzgQmMQHTgG3UTN2iBNwr3kc8VkCBm+yHBnWc9MsTU?=
 =?us-ascii?Q?KIwwyFlO8OM54u/YZ0YfYDiUTe0w7VmCixAK4jRXBUQpjMS1uO4r5gRaxjgX?=
 =?us-ascii?Q?tvq0xwtaLx2EphyLB1ljUgn9KBUViKrAwyHNzu7RE0kygWwSmB1jKgVMbvHs?=
 =?us-ascii?Q?HlyJM5ngh9pD04LBmrgw1Ce1FO9jAFbI5+FKqgjsdyoaxefyUJZcalJl3DXL?=
 =?us-ascii?Q?jB1kIHJmLel2GIpcFtchQYhLoXG0RfBnbSamkZeVAx9qc3HlKXeQbncwcei8?=
 =?us-ascii?Q?aChH/zfZa7E6VbQmtwd3Ews9EJajRvGs+FFDIatNAY+YIhFkOu4m9039Rc3k?=
 =?us-ascii?Q?z5qY3KmAUnXcrW2J5kL6KXCiGBakcI12yHF8GxwQtGMpVkmpE5zu3syiEJZ7?=
 =?us-ascii?Q?VPYQdS50p9y7R4D2p12idaRRROSUeZYHXSPLjngJfjcK4wPR98W5YFBbBQVV?=
 =?us-ascii?Q?/nMr8MR2ghVLSOvWeb4QvkpRBw5v4rqCfPfj9NCKBthgSQL7uDxZ+0vY8sbY?=
 =?us-ascii?Q?7/+spqvVdJ8DiiKLcQoZFVabBKZWGv5K9mrTB4mcjMHnCHB5za0m6pG22wPH?=
 =?us-ascii?Q?oxz4/2hkH2QKJwy706bXlWB14KDKd8xxy4fdOx3HTOAmPvcowNCfu1r1DuDo?=
 =?us-ascii?Q?E3Hh0gqWsGk8neXM8SzlR3jmhwzzPujgVF+Qt6uIqheyQgYfZG/duD/Qje7J?=
 =?us-ascii?Q?pkj9RWu7n3lkKOuGmNc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7149a4-4d9a-4479-4f60-08dce2e2bfd3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 13:04:28.9916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEeF3fBSlWy0YRvj3jg1j0aG+tQ0A/LI8d5peRrdjRzkdRlTBRuHg9F0OcbY/AIO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535

On Wed, Oct 02, 2024 at 03:30:30PM +0300, Margolin, Michael wrote:

> > > > > Actually that's wrong, the device always sets guid in BE order so no
> > > > > swap is needed in the driver in any case.

> > > > They you just mark it as _be64 in the struct and there is no reason
> > > > for the __force ?
> > > > 
> > > That's probably the most correct way but I prefer to avoid introducing
> > > kernel specific types in a shared interface file.
> > ?
> > 
> > what is a "shared interface file" ?
> > 
> > That doesn't sound like a linux thing
> 
> Nothing particularly related to linux, just a common practice of having the
> same interface on both sides (driver and device in this case).

Well, you still have to use correct types in the linux headers and
work that out somehow

Jason

