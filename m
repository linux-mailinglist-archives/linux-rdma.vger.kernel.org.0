Return-Path: <linux-rdma+bounces-4161-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD57944C14
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 15:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E991F23336
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 13:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6561A57E9;
	Thu,  1 Aug 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MkOiqaoa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6543B1A38E3;
	Thu,  1 Aug 2024 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517117; cv=fail; b=rBGQW1ah3u11Cuu0nayekfaibhNp4lbhXkUvkyGNzpeR4By9UXcL1JZsGuYVA9xXtYQty1ht8TsQPCPuzbBYJ/g6lll3zx5TlnwQynHhtrM+itByqBXXMIq7dzFV1PFmVpJ44AKqaKLWfYK+ORkhJKjFpCWlFOC22qk1GSlZX+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517117; c=relaxed/simple;
	bh=TEhoxw8IIsCeFZMS7ZXaifQovBedkIQcaLyLvdMfZMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B0WtO3exf60IwWo5qgK3iozqAn1pwtPZMK3yGxWFiOb+E7DrrHlXXEpbb0lUeY1XangGCAWQRJv6eh6jZkcfqEHMWrzoDU5wzvGWjxQFsj4Gr8+/iF7gACF3FukeDn6cc57jvG+uQPttZr3YR/gfyRTNBZpjDKT1HjZeIFw0xz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MkOiqaoa; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUV3YbeqIlWqI9ox9D7WZtESVXEVWdiTaNl35D+vxw7MmOyWRn1h8aY++kz9n0gxOei1fgSeZjdG08G/nswvjoh+bXL79fyJIQk6ZeDEn3XplNPYHDI8mJt4AltWYLoive9mcM/dnJQYDNXzJBdfxkG8RPRziY5QSfp33GyGcmJSVvSzweMNEK+qj6rkq/RJWVrQEsO+VXM/I6D+hc8YF7Tq2nbH/mAy+v4O19d8yKrQQd+YEZWwkWXGRK4MPcZIOHN0Sy9ro3EGS1lVskfIAf5jVyoTwQANnF+lgt3Buf6ZZ4AXlDjrFVw3SwPA3RcEu3IRoeCQhLRjC4y644T8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqq1TwCJ+IQo3FbHlAqgmKiVErWuvxtZN66wJWQxmsI=;
 b=MdL9IxEmAdyw83/KyaB9pGd7RKnFyjSVYBGwZeoIHtQsas5olmtP5DfhRoZeE85CqlGemQkBH+8m3f/DNQ0zq5hbi5dQpVO5wEzuiFOMhdstJpzRug5v35lMQaomcCcKBfJRWQTnBI74U/ekEUtIZW2KpITGe3pnphZBTgkMxYcfhxNRjzNIbtNjzb6wh9AzE9WWoUiOUEm1U5jgPPEk4JtXPmPmajxb3b0JkUytRbjkqvQeXRIneH9Wsfn2yZcIPhM/Ozea1Rgk8sIM3aBSHVkxxb/dIHn9VpyOIhVQAW4i0+U63LFw+hiKQdlrPB5LScopVm6KuuegfpZzemLfOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqq1TwCJ+IQo3FbHlAqgmKiVErWuvxtZN66wJWQxmsI=;
 b=MkOiqaoa6pL1W6u8zLM6LWY7tz++3eBxOyWntl4yiJYgDTQU3tOdaCkZUAdPksWBTK8QqkN5arOZyKCeRxSFBAb+3g9VdNRUsAvuKxsQAfVuyVDRD7eqLzrsmTax8vlvupV5Ce49t2zPBoTaTkTr61MXmtA2EkkeZb+bXZVzBhSvWYit5D/96Lj9rhqRa9rannESJGK9fCZeLt+LT13rSgB16bJsXD/HfSVTyZPX+QmQ+A21VnZKoDA1zUusJfLN2OYQp8GeND4YTFlwiGZqMAR4XI+0dub5iDrOjEC1KzjpYoOMuZTSj/1j4BX3XpNeqvO/HiNEFlhauxoB9AlZeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 12:58:30 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 12:58:30 +0000
Date: Thu, 1 Aug 2024 09:58:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 5/8] fwctl: FWCTL_RPC to execute a Remote Procedure
 Call to device firmware
Message-ID: <20240801125829.GA2809814@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <5-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <20240730080038.GA4209@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730080038.GA4209@unreal>
X-ClientProxiedBy: MN2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:23a::27) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 56265f5a-2c59-431f-863b-08dcb229a49c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9w7Dq9dcOmqUmy1IP7gSh4KvU3LF0UMIP9Zguf2Q7rgjVZmUZQQiPELe4OGB?=
 =?us-ascii?Q?Nxnq71BmbnVomXCsfls+l6mCdJDDIFGEdWh46a2aWFLxVOEpqed8kp5RHEN1?=
 =?us-ascii?Q?HMkPun2aXIgu27vC7/lChidx/O6/8hUPu5zIz9RvHHqvjtbgW+lC5dmiPPU7?=
 =?us-ascii?Q?MWuNzOZ/Tzx266r/0lRFY3O4ggTiT+9HKw4kqoB6atHnQ8Wlfgdur8QnDng/?=
 =?us-ascii?Q?k1yUfMVpyGCJQQSPe7AS79lDcGNu/aKvrJOqP3h+kISTwdM6OI14k/LuSOvU?=
 =?us-ascii?Q?q//6z7rbojuf1JKSDP3cIkTLORk0jsFn0AHZw8AbohfMQVejXWX5/XZai7QB?=
 =?us-ascii?Q?oUtFpTcHrsIspaWriOewd/IWa+7dqf+4XNDckFtOCST9LqJwy7hmfMfLGhYH?=
 =?us-ascii?Q?P0zuaz5YNdRb5koS+XkSxWgYXrvrcLgZqHo5tLtqDcOZATqC3zERjBsTSB1M?=
 =?us-ascii?Q?iE5+PAiW35LxJtKhl83VAX/qgh+c6TKQWcVkLQ4mYIBMyszFylui+14E88ZI?=
 =?us-ascii?Q?VFrr2RuSsCO10q/mXYqHU51WouMPrquZ65uB47+tU+ck67SGWUWXGT712CyR?=
 =?us-ascii?Q?ko3h12cSkYYtNw48jJezUEcgtbpORkXDi1U1XRmRR8PjwMICYCxhx0MMTqKp?=
 =?us-ascii?Q?/YClgNXZelP6CIQOajAP1RkCBHHfKTAmpPkkd4S/3MMYpClja2iuB7TuB+3g?=
 =?us-ascii?Q?w8kRw63Q6YQdmwnSzwL7WuFtypB6LNzKgkTg43n2G4n8IIqapilpaDur7OL5?=
 =?us-ascii?Q?vzGF4LOH57KqOiJAMjvcdDNHdobhu7cPLaLnATuxrRlmj6E2I/szq8TdqrBt?=
 =?us-ascii?Q?zjO7FPrVEPXw5Gh53PmeMTi3A8r8+bTE/hlPSSJSsZktaqt3Ey+vcq9JKulE?=
 =?us-ascii?Q?V013V5pU70c8N2Dd+JuCENwRe9NXHlFOhY4O3rqZkZkseBZxaXU5/+ovPQ+E?=
 =?us-ascii?Q?GB8UF6ywXPpekJgy0LaAMP6OQz0wHRCO4jOaYIDLUIZPpE3jmEnkeqN+lPnj?=
 =?us-ascii?Q?n25zru8fxflzukVXRfcxGSbO9tyAC9aVn4Xj/YRyXAonnkrT5cE+/YZUzVPM?=
 =?us-ascii?Q?iwn68rMtxFN352ZdiKIJoKTH2XsWTTS47sMH4U5kmj3o63Lt1IFcbQLObZrR?=
 =?us-ascii?Q?P0tjgWCuRAnWaoOAL5qRc1neNtMfKq39AhTf63htSvFiXmEpPlywoZx4AeEq?=
 =?us-ascii?Q?3HiWdmWUAI6Zt/BG0j/nT5r1ZzbEjGvbrS9zSdpCtxAEdzwKzFNGJ05IGpbb?=
 =?us-ascii?Q?rpnh0HNubiz7zO9oPqq21LY3Sra4dPdWJn66QKWxpTf91CSlwSoAPtkabQLX?=
 =?us-ascii?Q?oxirbHRSJOKMxr2CGXlmp6kon5VHZfFljlueCtmef9VVHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gccwsDWb3Oka8MRSEo+yS9yg6T3eWoympFxaVF3YGVGjZXmeEHNTvZmoXiIp?=
 =?us-ascii?Q?3/6OKDesEkEkt9ecIbiRYTo6HlAvC0mhNMPMHN1WZ9b7o4ZNCBJMoElLTMEB?=
 =?us-ascii?Q?VX/sDi4VDIkFpqOG7VoPMXwj1MpaNLGUtkI5aBvCniqiP8lfDcCzbEdcYBWN?=
 =?us-ascii?Q?g/kkl4VRCf/w7HwaTt/ueuuQUQzqG8+jBkRjdFVBZ26L5qWvIcHFYNI5nRbc?=
 =?us-ascii?Q?QWlxgk5rZT0/NcvT3TPQ7g1mwhqxwF02qtpANOINVMqH2iOODmsRbv+f8+ZS?=
 =?us-ascii?Q?2tmiqH4b9hxZzGiQGQ4OAL6SO1xtj8Z1HtA0RNUpKVA+gW9MmMiZQ7fbt9vA?=
 =?us-ascii?Q?LupDsoB6yubbkQdQKums6j7SCFPceEO+VTN8a2FhYKqHh+pIBxhCD+xlIdNw?=
 =?us-ascii?Q?E+BS5EufBiNGR3weCKkg1mhXirYStHERoFRuibFVOS+P9NZdMP4LWcbO53P7?=
 =?us-ascii?Q?vz2F4GgUpPWEaoleEkKnkCk4k6iFHEgX3Jd2sUwQrGhQlVTAFbsFzx0dAtdN?=
 =?us-ascii?Q?aNQHO4nifqbznqjycQ2V6IS5FnBfvNED6CSfpXPIiuioG1K3oabwORDT8gI7?=
 =?us-ascii?Q?zCDfmoGOvbh2Vrg0R981z+o8agGb4edOGlKqN9z8ZEJZn+oEOACz0iV+lRuj?=
 =?us-ascii?Q?upWzuuXjNqw1krZ3sFPluhCJSysCVtD4eI4VbAG8jFD0KSDpjxRT8Ba8HcWF?=
 =?us-ascii?Q?4rfDyiGeVpwTw7whCEqfesgafd5FWA5JnGvvKUK7J3onTYSMyXwSIIYrhc2A?=
 =?us-ascii?Q?15gVtAEg0nnuU01MEjep8+ccDD0zQ4exIGwNoAzj6kZBWWTc7ES8iMrXNFKk?=
 =?us-ascii?Q?vU2NAVr65Y77phAwLLQDrNUCKuGrt4W67OiKBCups/oKPMbB8hcA7IittzQ9?=
 =?us-ascii?Q?fiGdrqeX7pNtkxfqLz6qMtsGSJML6KOZAd2pDh6F5/8RG1BqrhyaBTAV/nKz?=
 =?us-ascii?Q?vtajfLRmKI/dse2iN76Rj6UAsIseumQHpfsB/bjnRRBJYbDb0oD5QoF7tzH2?=
 =?us-ascii?Q?yFAxcK58LIy0cJDII39rmFYlusKCJLKVS2aF3bvclU04dgDJ8DjsIgNvwQxy?=
 =?us-ascii?Q?kRoOlcNG72oibKE9tFxYKroK2HS/MfI19s+PXZ1WfUCEa5h3CiUy4FHzwULr?=
 =?us-ascii?Q?Dw+eBQ9dT3/gqMarV5hgeRnqh51ZCuBtBipadfyvUo1mswH2s+N6Z1Ko+l8u?=
 =?us-ascii?Q?xUwtkJ4wtK2mpXmmoUfQ++oqAL3LXUJFgDKlTdC1aypH+yIY9okBrv+DDQx2?=
 =?us-ascii?Q?WkGPZdIuFwRX4srhHtwk4hnLg7ZX2TfEuOGB+/ivlnXUJtbdjZTwnkeaqv6e?=
 =?us-ascii?Q?qcolCCGDpbBKckkpkKS2SX8EVLOxXbIixFSb0BFaQ7rsubgRgwpowRbGFalz?=
 =?us-ascii?Q?6i9anj/uZqRJsPzSMftyIrTSSZZySAJ1zqCpJNOt4GDoAb0Rzw3h12kjWtfz?=
 =?us-ascii?Q?UVcmYKEDPmTsFjVm43bbSx72H2mFmZD3VROJV0zEo8y5CXtrjtZWgxC2eWN3?=
 =?us-ascii?Q?b1SmK+/0SgbwCskKbELTmsNlZ2us7vCstRRv79bQcqnjTEufesObUGH6t8+4?=
 =?us-ascii?Q?z6UqdKEQkHkgAvb9jcNuGU03yz67X71hTjK6EmCX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56265f5a-2c59-431f-863b-08dcb229a49c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 12:58:30.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6d5KIZQlHcnKfWR2SaZS/mWMARDHaAopUV8GXz3EUfzuxrkfTd8JzH/YKXDriPA2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259

On Tue, Jul 30, 2024 at 11:00:38AM +0300, Leon Romanovsky wrote:
> > +
> > +	void *inbuf __free(kvfree) =
> > +		kvzalloc(cmd->in_len, GFP_KERNEL | GFP_KERNEL_ACCOUNT);
> 
> 
> <...>
> 
> > +	out_len = cmd->out_len;
> > +	void *outbuf __free(kvfree_errptr) = fwctl->ops->fw_rpc(
> > +		ucmd->uctx, cmd->scope, inbuf, cmd->in_len, &out_len);
> 
> I was under impression that declaration of variables in C should be at the beginning
> of block. Was it changed for the kernel?

Yes, the compiler check blocking variables in the body was disabled to
allow cleanup.h

Jonathan said this is the agreed coding style to use for this

Jason

