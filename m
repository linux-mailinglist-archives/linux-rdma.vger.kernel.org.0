Return-Path: <linux-rdma+bounces-3556-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA8F91AFE5
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 21:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B095EB20FEC
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 19:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E4219AD7B;
	Thu, 27 Jun 2024 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UVU09U+6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645833C9
	for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518139; cv=fail; b=tGITHVubiKncmbR1MXbYbCgMVSrn72CbbpHdlmZgZ+rInbxCJSy6pTKH85BgKbULsh2J3k+m6cXvn1+zjZ8hEx4n87EOB43MaSFL1FgGju4K36OF7xrW7T/GE7Y1hbUpGyI73WllxvF8mMKu7jZFgF0MXbYhWbHUuHeU5PyanQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518139; c=relaxed/simple;
	bh=v+XWHN4tGr86e3hqsI23CnPw0ZaVcfNczoTqlf7psNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SOpc+c4apTCJPCq1zfHK+kZLexYUziFZNQlQBwI+wL04C0QQIK32tXSBZj+pUYtL+O0gEVz5+H0aSGqojbql7VOyM6ihZYRehueZlWT3kxs2ayPTsCmQMvx2zrmiS4pBaUQBkPHqK2CUDMuO47fgN6Q4dzJmDTxfw8/IHS/rY4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UVU09U+6; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFz3z3/UMOCwvY9NcwoL7rCegC1OGdPqfn1GpJul5gwM9zIVMNEJg8CRAwX7+OMhrZN5WPK6eyJSfY6Ta0IdpQm12oIbvEUslFU1gbNYUKi1y7AazLVk0r58MWzS2W5ZrbycjkA4UYKc/mJPkVSK1x1Xd61oOFIBg9QYN7rUgKXOyYfqdkl7tMbuRoi5aIrwQrREoDWyZXPCLnNec1NawYId24qlpTMD+MIQJku/qz6SDUBxtEiOVrdp3ux7vTjyIdOe1WGLqeE1xpjnVsleowB3bIXQpxGxibMGkkEv8eq0SaMOIiy38EMQQ6SKTu2RkZyxQfri1ApTPAgFsHY19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzxGT4SwHTKIZxB2JLPbecXrnRvtZT+3CihrB+tOTw0=;
 b=iY/j2xkxU+CUXbiuNJHF9GRzeumjF6DEchFNW6/iF3T0YyodQrJjZ2uXF9uJdnTbXrySizYjv5Ov+M16ZXkLgeacEuOvrOXYgqNGrfz4/lnBcl6xNfqBj1gJNeInTbFjrXWNwFRlipiWnj6YrSGHYNgc0ql1+joC+JBrUUR2HSmOzhX4Llo+2+FK7kze4eMv/QlE62VGMuRVE91UCOGnFneEvJ9SBhrSAsMSYrvM7SIVen53r5cHvQpWKVtMWufuMLfi+AzLyYtR8pB3LenV7ZAMp6hqW30MfTQuZSrOd/u/jbcaIKmPakdLfss9urkJnGaZ3NJHQthoCYW1yVJsIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzxGT4SwHTKIZxB2JLPbecXrnRvtZT+3CihrB+tOTw0=;
 b=UVU09U+64kialMdDICtQFR6Hs1OwD0WIvUXRyO5EvN4KJhvMqyJ5iIMamJfcwiA7MKPr5m3QAZCYv4L5VB+agndhpdSVvwqiNVMP7p5C8z0GR0x4IP9dfcLa+43mMmqB00pb8toUcYFVtWcXCclUO7/f2DVQ/7K8V2WjeI0OutmHO4u3y/hUlg8Y/DkMEIwhHNozoVlFk8Igq6WSzDrOuV1Ge9Y4/E2i+HqNsYu4VyP+paOrDi+FNlqPNJsqTIv0EEu9n3I+JAwpWMqwQ0AfMOrpRjBFxu7bvYAMiPvPiZekU2cYl4a99wQQ37/dCridfU+3lngwXXSNjNZZHpPd/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 19:55:34 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7719.022; Thu, 27 Jun 2024
 19:55:32 +0000
Date: Thu, 27 Jun 2024 16:55:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update Maintainers for irdma driver
Message-ID: <20240627195530.GA51822@nvidia.com>
References: <20240627155304.219-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627155304.219-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: BL1PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:208:2be::15) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 164a3ca5-0a95-4e13-f9b2-08dc96e31a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/EAL+RM5ZZWaDMQKZmlWPLKx76+rTIgArNZ8j++hEXuaM87LGDrlis5KsF1U?=
 =?us-ascii?Q?GCY9WVKkruQsR8QkRiHK20kD6v4rwRkDr7oJ+Or2jNujRkrbIV89k/VbNnLv?=
 =?us-ascii?Q?W5M6j34i8ioHOHDO2CGLWzBdYQ3Pk2Wgmi3aImq0DTIJm1h8gCyCn2IpZsE9?=
 =?us-ascii?Q?j+1wL+yaYO5ppzRGZjJvW0fuhgxGWWLs94MXdw1pX13tg6izFXRwNbHDu0S3?=
 =?us-ascii?Q?iYonAQ3gcckg6fEBskqjZJPlVz4hCAQ/ZEcSk8s3Kds4f9yeA1EP7RzSH7BS?=
 =?us-ascii?Q?LQL/cLPUyMKdAUJZEsUMXd5Ez0HF/coR5AAeHfvteA9LLf2goAup4Oyi3inZ?=
 =?us-ascii?Q?jnJ7qnecvcjR6r+D2Wok3poSYy+AaSMqvlVieDuNOlBrOEzI1J2FNoTmOmrJ?=
 =?us-ascii?Q?Vm2CfERP2H4VhxcdUHbcym1gyrrPHyvZ+M/ZeflJraZNLEeSWCKwFy353Ikk?=
 =?us-ascii?Q?iHvr9HSgTxCVvBt664czg17vv5DRNkHzNkudv7pKVRhn5dxvUDtncVwoFfL3?=
 =?us-ascii?Q?8glAOuXr8q4NPBRkUTJ9DB15l84ATtyr4bO/HWs5sbU4Mp6KiHdlFAxzk50B?=
 =?us-ascii?Q?j+P2gNUb8dZ7s6NV/i7hOatpXMZA6RgAsHnu2E34M2HeRLpiWMQSCRlNWXCl?=
 =?us-ascii?Q?xEkMorND9LXjSmSrHGiWnzYTr5kf0xadoqicg6dW3M9WH+kQc9QaSnwM1hJE?=
 =?us-ascii?Q?kEHK5U3SEkHsWrCY84pNw/XHDGLUGnRsfVhvmNLZGGucKfohNBk/y1R6A2Q5?=
 =?us-ascii?Q?CWJYfd4ctg+Pn64PxjJ6kmrWyS9D1tdcMZCDwxlgJXiG7MYwpBSvQqZk1uMa?=
 =?us-ascii?Q?vuRe3tUOv8xw6qnSHI067T17l+jGBEbuMmw19OkYarJUEM+JoMHaUBaUoqs5?=
 =?us-ascii?Q?DPKphvKttzBCH3D4chopaz25ubSfugnqo2zH9y0rKpnFBJvFmra1HBP328UI?=
 =?us-ascii?Q?07dqMc0LVNMvAJ+SRoeDd8ds+YthPEEJP3v+DE0M62REDuGdYBGgKnVopHDs?=
 =?us-ascii?Q?O6il6Nyrt7xYKDReFUK0InxbY7SP4aGcreRaQgnAr8Jn9TGEGQtqvDTFbwAN?=
 =?us-ascii?Q?27sT3tRabI+jE8AFfVE2VgNGa5eY60LVKl6Ju39eGBZTvIuWxkr2B0BldDgL?=
 =?us-ascii?Q?FWtJQJAwb+2IQ9PL47keu+S+NMW5tFVB4VSkOWH7N4F+GQtvSqNG7tXPs4cy?=
 =?us-ascii?Q?QDPt3Vvr2tBSciPuIIpi3eDaPhTyFcBN/ErgQlSo6NYj/RNWszAjjkWh76F9?=
 =?us-ascii?Q?Iyb6aRGb5xXGmr41ESsbIJMzMdZZNq4zj8UhU5LzxNX+jUvEqNpvaE8ALfdK?=
 =?us-ascii?Q?z80nEL0nWqSO8HC11jY18qDf/O1cDGq1FJOxxYAncX0W1g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jDONQrhOyHJ8N8DB9rSdA97AdDmcVrqStMOgoLBr9zuq10KCLh6YSUCixzR3?=
 =?us-ascii?Q?Ce78WTyIUh4Yc3mhHRJFm/yb/Ie2b6nvboZH8bgkwnXnGZjcHz3IXSYFZNMN?=
 =?us-ascii?Q?fuTZsO1JuYRlY981ygNI+H4v2oHo/tKLIxnzicRM5IDBCC0dlNk/22MqLaH4?=
 =?us-ascii?Q?SslK3kNSPNaXzezV72Fk9aAZ/vd4C4oBFXnxGccwLZzD43BrzagCPvSoJmCE?=
 =?us-ascii?Q?Y14+1xeCsQe+IQvcDxnkoJASlXgcoqDsvmLGidpekxpt8JMIKeOrtmkazS+L?=
 =?us-ascii?Q?yOQ+4TfWXC8LPFIf+h1aJ0dgsdIYrgynIyBphNnXFZ7JlJk2ifbGVURtyRZv?=
 =?us-ascii?Q?Gal7bX9vmqUmaAd/fJ6LszrcdDFyfhSoSDYUyvJJSAJdcQ8nfEAkANnruXRS?=
 =?us-ascii?Q?bag/RBrGtNXik8NBQsKdLBtztzDCMoXhgJQIiqWMFTKmQHp/hySYGjtyS3pl?=
 =?us-ascii?Q?1i8gYhVdjceyJKRKwlZc/XooHavE7fQggB8i9BuocO8a9KWtGL7QnDB2T/Ls?=
 =?us-ascii?Q?SboHu8rhO43jBtyGnwM0XB9W7jJClDgwF5Z7P5ByHGZ+4HL2QH0MC3Jfv/zA?=
 =?us-ascii?Q?piz6Nb3KTASjbeEtGePj2r9SOIByxqceeFxm6NJAE4dBa2wKZXQT5r+J00gF?=
 =?us-ascii?Q?Rlr3UbVjnB9IZmLA/JpAz4RrwydNCa97IQA8i3ewWwh2VFIMucOw1bioTH8j?=
 =?us-ascii?Q?JzlW/b2BbzJe4NVGG/4C4Y0iwW0zaACopOvpCOnpOhjKXu/TM6EIhKO8xAxB?=
 =?us-ascii?Q?bN/LX23dyGz3zAYtgf1EVGfXqtEtHI9w6+rvt14gzwUbEja+WhSrKsZ/9n1E?=
 =?us-ascii?Q?sDDld6w9WvakiSqoFXReqNqHTuRyw2HZu0w6A3kPgtGQNrYnR5mHI0etOlOw?=
 =?us-ascii?Q?y+uoORC/tgDENPN+0ESk/3MQtCG3eUhz8tqvhTinZ32QrKQFq3w2IQAMyYiR?=
 =?us-ascii?Q?DG4pp/cBLCUIwRO0t2ZUkhuk0sQ67QLDaDmMsgLLt+A/rA6mwDAI3D8MZmcw?=
 =?us-ascii?Q?P305NDT8NC24yKI6vs9MD0B/vzSrEsOA3DbGM+gLYp7RxyhkwfsqUUQV8e2R?=
 =?us-ascii?Q?kETOE8ru+ZrX+17hw3flTLxWz8tjKcx4wBRJSXfUqABJty0p8Apm087BEsDl?=
 =?us-ascii?Q?+w+y0dDEi33R9JWOSkYj3Gvege7u8jXom/rtv8+jurwJog9Qsk2s1fgPEJjZ?=
 =?us-ascii?Q?hAjoO6ECLuW4j6sIAnf5QohHCfVZtcH2qYu5uh1LpNZ32XYwbZaJFGltefRy?=
 =?us-ascii?Q?mpNoyGSgymwnc6sj5zON4hGFbsiAlgEqp9BMoYzmZSvkqcTASD2LWZAdf0p3?=
 =?us-ascii?Q?5p4Txu3AHYSB6HdsbEjc5jE5kyhlscUnV+XbPaFbivAIx430TpMI0r4CQhqk?=
 =?us-ascii?Q?hgoIYrZHlSlCJwaotaB3ptIiy/ihg15Nb9Q8C3Vv9yBtBOBgfpzZV3To+UPL?=
 =?us-ascii?Q?f+q0Lj2rla3UpWwr3fgjIfJ2t2zOQGsTzYtjhm/Swt3up1o/vvjcCp2L7pO9?=
 =?us-ascii?Q?1Wap2yNlfUen1iGN3B2MtcOucBC9hWt8G+mGrjV9CD50tUBxwI6zXU27TYZQ?=
 =?us-ascii?Q?JTAl6I/UgzTGrmOz56DX5TW++HlbrLvZlM3NvVNE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164a3ca5-0a95-4e13-f9b2-08dc96e31a07
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 19:55:31.9396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrYOwyXt8CxhnSFjG1KRMTVioHjNkmq2Mf/dJGxa10AnPLX9HZQK1hOJsVI0wkAQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

On Thu, Jun 27, 2024 at 09:23:04PM +0530, Shiraz Saleem wrote:
> Remove Shiraz Saleem and add Tatyana Nikolova as co-maintainer
> for irdma driver.
> 
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Acked-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason

