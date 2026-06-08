Return-Path: <linux-rdma+bounces-21977-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ecUpIBLmJmqgmgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21977-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 17:56:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9568658665
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 17:56:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=eL7FMaHl;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21977-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21977-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 797CD37B8596
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 15:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E73FE356;
	Mon,  8 Jun 2026 15:26:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013060.outbound.protection.outlook.com [40.93.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F553FDBEE
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jun 2026 15:26:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932393; cv=fail; b=GORop3JJQDpTH6gS0BhZ82jzEm2nvINW/MlRF0rfcnFnT1k2C8+lozvKzxmfK8iX/79PzIkiQ9RG2h5H6jWwa5UlogR9Kzv6vdWTwt+IntrRLyNmLggMT/Z0zmU/uBsENBqG6N2IR4E3GBh/2uI1w1CG3is9wt75tdR4ER03//w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932393; c=relaxed/simple;
	bh=nGNPc0BbDdCWjapg+NPX9mn/rEVgZnT2McOtBvyLuT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=onimY+M36h9yQ+yC+pmUgCbulsJUlLmf8oHYtq5XG2whcVvc7DDUsErQBbMBVrFqnBu/folSGku/uZjugQTIwc8EFhD1T/hw0l11qXorB1N8QDMvt2CzZ9QzvE8si0+8ztFoY3GkV5NuD1fEsjdvmkTgRVS2XGFE9wCfS+FV9tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eL7FMaHl; arc=fail smtp.client-ip=40.93.201.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrZD+dZv6loNcxkCNOjyS3m0r7xVKvGDzjnIPD8eqsDkDIgIOSkECSNyikJvJHR0Bm8xzGlc9G2ZJrW0Mm9Da4MACrmAy62mXx4eQ7V6Ft6MyeoHyHt6Zn+VRNpgWRfrkwGCyUrJhKWfM2MFapWoQ7hUqvGoAfGaAztuZQ4LBVaPDHkjXYzgdq2xNClNNySIB1WOjCpjaAWppZFH00maTlRvAIwUdPe6I3JSrn3sjqKRgBiIfgFk7FNw9zDahKc/0GUrDLrwhXWb3RM86x3HT/fos6Wn3SBzYdRfXTNhDYqhvOrLD3BQtOKMvyJtmlNWU1ptNT+qFNje/HoB/vD9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwpodWGSslEjiJqxgIq6a7oOr0lC4MfpJnhe3Iz34HI=;
 b=n7p9GdjRgGIpvjF+tf4beqstrFMmBGFXWWf33//KTA5rnm8o5pn9MvZzT9F4XvqLRc+FKXJr5x+gdbmN7uwdN88sawUH9nZQCprAQiBSbIB6e5xSObAaFO2IOXUC/aSA9TH64okfymOBmM/G5x6xkFaPWVZzSvWBP4GZSbCaNws6f4eiz2+jbNkgOe035akNhGxgUa2ciph6Wz2SJA1r7rbgs6mS2fXx2JY3DFpdVEQw29omtyjJoATpw0dL8cOPW6eI/Sa3CgO/9/Angc6+ZsgH3w1Ck7nYmPuNDQNoDtrCN9R8h09SPw7+z1H+3AhkkDs4mTdOEhkHG/jsWlf1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwpodWGSslEjiJqxgIq6a7oOr0lC4MfpJnhe3Iz34HI=;
 b=eL7FMaHlVGEnhPXShUC17+ZvdGwBXfODeeCbBbfg3QWWxoSSe3qr+bbS99r/e3jOit7n2yJp/x3X/qIF1YbUnaRESu69IO1RGZiaMQ41y86Ef+UQbx6Pa3ehMScfgoIZHDw3T0KidRj7az/9boSb5OImyYJvSFtRL8cLeERshMZDwqE8yM8E9z186jAOdyu1UVOpPDBhQo8O4TI+C93bs0rz2GlwaOX647YAKGYFopHiPZnzFzaem4UFgtpRud4z3FPdYS35g8n7ZEk6qylN16syTtouiUcNvGJpXWcnfvS10nmEgxBdWKld/sl0H5mqoO2imocJYqrSAHA/rjoBJQ==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 15:26:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 15:26:23 +0000
Date: Mon, 8 Jun 2026 12:26:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: tom sela <tomsela@amazon.com>
Cc: mrgolin@amazon.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-rc] RDMA/efa: Propagate destroy AH error
Message-ID: <20260608152622.GM1962447@nvidia.com>
References: <20260526073334.24905-1-tomsela@amazon.com>
 <20260602002223.GA644685@nvidia.com>
 <20260608145738.GA43925@dev-dsk-tomsela-1c-ce9cc34e.eu-west-1.amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608145738.GA43925@dev-dsk-tomsela-1c-ce9cc34e.eu-west-1.amazon.com>
X-ClientProxiedBy: YT3PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 29fce22e-d037-4152-8695-08dec5724c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Rm/ShfwhAX3zKbQy7GjiljJvm46nv0QYBYj5JdUItwtLWvtPEBocnP9MbwX36S3eOAJ/9jmvO45Za0IoKLpG7H6Al/slhZFNnhraM5w8N7kPN91dSgjvVwElzuKXY1RjHK1FTpXgamIMERfUITEaRjIFKg5cWehjfY9MlbwTa3/8d2SRS1wGUFIm1bhr57ROtJEAe96mDGjT0euHTur9iyj75LjMUgHhp4eWHIFw7J+pOUyCrkCzkB31pCzesBN5wm0rJEm66uRZ/6M8EYDoohUDphQvRqchfdBRgUkVhezO0/+ssP9XWIrlO4zB400YjUfShiBlX9Ppfvlqi4hrWAvJ2W6FpDUxQmZZ1AvR2Gr5FRHJiBrgJpvcxR3NY1K0HHzrm8rDVmzYXohxVG49IT6XKuGlOwNwXqF2ikYYLRfSss84YDgcl/vSCUgJPkFJvPJdpcRwOUmenzFnU9FE14n0NLcZOBh88LVK+m2WWAPzh/q+/pnj0SSeZqqSjSiv5zGkWcaboIJw9RaFKVs0TVeHbWZlYKsrAfAYQpKb0JWoBrQ5dBb5Z9Vr6Q0L16kNb3nc94ZsMqsEgWcwwGiZOhTWDBPt7zFDUOWYcZvz9RdX/oAMTudrMxfXvP4vzgTwa19RlXhQn+DT1so4bJOaGTo9QKVreIed+0wfz7HU+BosIbGfSysC2SkhQILunfob
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mO78Hr1KCoU5ug6UbOCwXFGeX3RL4ONIP98npy67b6/Ti9QwxMBvzkGh6cMB?=
 =?us-ascii?Q?pMICHka7S/FR2u5+DVMhdXpZEKQHFqgMKayyCWd4rZSnHlc2ifgo7msjZTg5?=
 =?us-ascii?Q?ccGtTCuz3PyxoMz6O9s3b+8J9swZ+p824+wWIQcBCyWIv7bGnHGDfgMGyHFn?=
 =?us-ascii?Q?jvJaKjIYZTGMkIk7ZDXpyEt0pBOsJC+bInR/tefjeK+srFl5c+wTf8ZSH4kN?=
 =?us-ascii?Q?pI5yZHm647Ui+oPnB3ngoQosJ7fJ2f857Y8pJyHf3VId/BSAxIVlAnWX1oe4?=
 =?us-ascii?Q?fCIntLmptMraArZMrzsSsgBbUcwQzj4gkogSWeeHmu3GNtCbM9VYW/7JR//7?=
 =?us-ascii?Q?ych5GGOBTKX+aW3EZjWxPOEpc6uvXCoclHd/0BBNm+KC8jsMo3EbXHwl3EhZ?=
 =?us-ascii?Q?pVGMQul8XtarYFlbllEX/egC9pl0ByS/dxqwqRIFCZeFeBG8u9VCo02TXl9L?=
 =?us-ascii?Q?t6NsqvfS2V5UmmY1Cvb6EnFRn17bCMxBT5TTAHAmr5Y4RUCSxEYMwU+RMr42?=
 =?us-ascii?Q?adw5YnCvR5Njhco/J42gUFjUAa6LAKpU26WKKbxaXkxBWcnSFyUBKeXWGGUd?=
 =?us-ascii?Q?A7TcHsqiC1PNNxN3wwKFmxcG3SVyVIzjeBhPkhJSMIhToDqKB+BlbwunkPnN?=
 =?us-ascii?Q?awxZ+/OpA1JMNLo0GHnz0hJdcebPndQnIW45HLOMSunrivpZflH7WB1px6cH?=
 =?us-ascii?Q?tKrPF7gHqi0m5blK0mMrKH90wca81IVmW+j8FPop7nWlViStI5d32ZpM7kdn?=
 =?us-ascii?Q?y71r0Oqvxlqc+10WXDZq+wn0AblB05cC5MT0g/+H+1Sim3FastyHlYZUpfqH?=
 =?us-ascii?Q?0dVYvkKeeSf4O84RVEbYm2uwgNqHZMQroBG8KtO8dPJfeEHsL/+imYCPks4k?=
 =?us-ascii?Q?+UDk+4klKJlanboDDBmRzf8GKkTP+QyWkh/pwC10m1L2Ut+hbeNPovzMkGt0?=
 =?us-ascii?Q?xz/wCOAucSRSnZ+XwGrBiDSUN+fWrWMnpRkuJ/dGzr2jKQNG/n654AgLryfg?=
 =?us-ascii?Q?ADdZByxsdY+H9Y4AIcGY6XsaIqwBvBbXDLvx/D926qiVI17xoMmXV+WXJh1s?=
 =?us-ascii?Q?kFkle0fgTB7bsYNkbzNpB5SwNtLfa8EIFU2FAJadfve934OxGazMfSkZI5lg?=
 =?us-ascii?Q?JuHkhK3AgDXiuga4q7rT2Fozizw1byspazpz3ULkVXZ5qbWvdoi/W3Bj5f7B?=
 =?us-ascii?Q?U4dJy3oAKAUcH3dFn8lhbkzbs1/HV56GBm24Yu8kGhLm1F8AzoXaoGFNyT2B?=
 =?us-ascii?Q?PUqY8kt7PdyzY++moRqCMjftsSD8/umwGS7j5kqXhRsKZeeEKvmvyPXYo5d9?=
 =?us-ascii?Q?DjwlbP5XAcDAELsqzH1N+RVooILs9l6xqcxqsMKpoiPy+72LhaSqxifTSiP5?=
 =?us-ascii?Q?Z6GQVqnIvbP7te0pTlq4UC1XkNmnd8aZm+NtTMzLYAelR0EYg052pngSFH2r?=
 =?us-ascii?Q?X3zoTHDfVapiQHYRIIiREjkaCm/ZzMqyZafjHO26kQ70/g0qeMtDG+SXzkqm?=
 =?us-ascii?Q?deSl21Ft2J1t4yzKpX/TD8HUNJ2XlsfOJg4ex7LQPJZDFCUswS07sPh+TbZ8?=
 =?us-ascii?Q?l7PxgkrskPDmrCnQ6PiZhj9eBo9yzsdbo8S0N+v2NvA8EquO2etIM5qrHVSS?=
 =?us-ascii?Q?9SUHpldjB0hEl1V6Mgm9gLmiMYsswHkrYTc5TFoXlCxGvBruT8jZqfduqwMS?=
 =?us-ascii?Q?XkCHX7n47kLDPNN/STQolin4z4o/EnjC36S4VC0zHnp0Qu/N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fce22e-d037-4152-8695-08dec5724c60
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 15:26:23.3041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lB9VZ3gstttR90BWdO+ic6lkvxbLAEidxLnSZRQui6vUSwUAtjiT91MI6hlsIM3v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21977-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tomsela@amazon.com,m:mrgolin@amazon.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9568658665

On Mon, Jun 08, 2026 at 02:57:38PM +0000, tom sela wrote:
> On Mon, Jun 01, 2026 at 09:22:23PM -0300, Jason Gunthorpe wrote:
> > On Tue, May 26, 2026 at 07:33:34AM +0000, Tom Sela wrote:
> > > AH destruction currently always returns success, ignoring any error
> > > from the device. Propagate the actual device error so the caller can
> > > handle failures appropriately.
> > 
> > Callers don't handle failures. Drivers are not permitted to fail
> > destroy, if they do it probably will trigger a WARN_ON.
> > 
> > You can make some of an argument to allow failing destroy for user
> > objects only, but not like this in general for kernel objects.
> > 
> > If your FW fails destroying a kernel object then the device is busted,
> > you should reset it and succeed to destroy the kernel object anyhow.
> > 
> > Jason
> 
> 
> This code is for user objects only. When destroy is called for a
> user object, the core code handles the failure gracefully and can
> retry cleanup at a later stage.
> 
> Currently we don't have a code path where destroy_ah actually fails
> in device, but we'd like the error propagation in place for
> completeness so that if a future FW change can return a transient
> error, we handle it correctly rather than silently ignoring it.
> 
> Would you prefer we explicitly guard this with a check for
> ibah->uobject (i.e., only propagate the error when it's a user
> object).

Do you ever plan to support kverbs on efa?

It is still not Ok to propogae all failures even on uobjects, you will
still trigger a WARN_ON eventually.. It has to succeed under the retry
logic.

Jason

