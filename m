Return-Path: <linux-rdma+bounces-12941-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C20BB37B28
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 09:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BCB6805AE
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 07:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED478313E2C;
	Wed, 27 Aug 2025 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DYmhWM/X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C342A313E04;
	Wed, 27 Aug 2025 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277938; cv=fail; b=tWvNuFV6I1qobhrBgeogzMH0iGf7OKnJaBO5mvNHQeFDO+7QXsfkBbGsoEXA1fjTdM6e67dEYCySMbF/NhvQ3OCcs1LCqZ5TuWRfuNrKLRFac9J8hChTHJr59ANWc/3nr2rSmXdNeUo1XuGeVlYBhb1VTjxRsFz1UG2T1df10lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277938; c=relaxed/simple;
	bh=ePa4JvADoy+25HlBCh2JlJIkirry3ibiYMITIajpFdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=brD5DHuB8DXNCkcYFXihGs/9fGVPuMtvjB7oNPeLQ6PrwDDnVbV6XBQzsufhNUZ+BHmNqoX/peBwzvsLHVsTLERxSE6RJ5uhFWLJHuY65H/RGt1A6zsk5xBPj6Nv+NpwO7Kelijw5EDw+I6XzxVaVkxBisKSJVVlK4kL+Y7nO1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DYmhWM/X; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGjjx6Ju9JtY5JaeZgGtW425Sa4PRFBut40wg4ibMi3jOHUB+v9DUEz7sIHVzve0+Zagoo1uDi0AQvU54cuyqI/Z3EjBavqrst6d06hQcd/HQ9KUu0GMrMJ70xfsGO+fsb+gmQ8oSlMZ7RDQli0TtSA+Utsmcp8mPd2jNlAztZg2jKCvVEysBWQVFuPY4FwruGoGFT/nkfjPLnNgb/Pxmr/tiRFSOaHm5u8WvCrEhAnEdqpFOHx/k/+kdnbEDlPpTbND+n60Pc+KX3BbqPlmKvZ2P8fapoUenQzX5SMKDVecdh87CayKbIUEYS6P3zG1CXOjMN+Fz0gHQNA4VIhqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2HE/cBri2lim7TZal3yTDnAtC6INdKNkWoTLcyGxG8=;
 b=LMVtkiCm3Pe3IkEfpN2KNlQ9pk2X6QPq69qPkFb2QAdOzQ1cbpsUVyCgn9hWkhKOpgMQ8jmKg5qM/9vPilSfzk6ON9rrLcpAqvnwZ8N4csWKc0Vpwdk40roIuJwtygMhsaDxvAdg5e83zf7F2R2YoiQPqvWOYrg0M34LXVeKdBMYTXfSI7xtT6+79YhZw3806lcelMZcGs8qn6ANCZor62xwh2jyxBYC21+IxywS5tp3Gb0fN7rvJ6hLmW7tIFHfDaEplrc1bxENlg4iMDFBj2VoJWwgggOvDSt8/FHonn7ysrZODdXv/385cpQOMVyzHpSiaWBnwwS9MWqOUuyqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2HE/cBri2lim7TZal3yTDnAtC6INdKNkWoTLcyGxG8=;
 b=DYmhWM/XUvHvIiAZ6rCq3/QwKLNcNQCMkjTk9IQMLPgfat2c0NQDK1ShLhvrh+XX8vCB20dE4zyVs1sXYrivZss84waOBd45KjMo66KTwO/TMF8Pwc6IOyim/MD7w3PZOMjI51PuKilH3pEjyPTxMTetzB8cRZ3+7zf6lBdmbgGuYnJZTTAWuZwEZadYj/HMKg4jrSvpcJNLDDiLvxJ+8WIE6+ulp3R2CkfzbVrejIpl3JsFix8B30SUCujcYqeGP1bjpdJxVTunHk02tFTjMIPQE7AiN6qYteRxPBTA6w+V6pYse9lNqzf5kBi1ClSHo6f9deFmlDgcBFdVaGYKkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.19; Wed, 27 Aug 2025 06:58:54 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:58:54 +0000
Date: Wed, 27 Aug 2025 06:58:42 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: cpaasch@openai.com, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Gal Pressman <gal@nvidia.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
Message-ID: <gib5r6oenfjj3j7bwkbwpcl7h2t4falraixzbjwhpalmr3fwlb@ggbyfacjvnlp>
References: <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-0-5527e9eb6efc@openai.com>
 <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-2-5527e9eb6efc@openai.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-2-5527e9eb6efc@openai.com>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: c53b896a-c80f-4c0e-c382-08dde5372f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MbMft6+RI5xolkMdqn+OLU8Us/dE3emuEJm5DtFJduHG97tXEQq1SxNv/m1S?=
 =?us-ascii?Q?DePW9AC0nUjXx8kMTRnawfPsIRUOkYrIZ3MpIdQGQqVGpsZI3ummCZAzAEpd?=
 =?us-ascii?Q?8mm3kkViP17AEAeHTdE8CmenVW8I2z0t1mKSxJJ76cKkYmKEBb6PVXzSGlMQ?=
 =?us-ascii?Q?mwgMhZjK/uVebbtOJi8O4ofP3NY8ReXVG6cYipdqzEk7veTYCoUNiW5g7Jvy?=
 =?us-ascii?Q?BMZrB3OnjOIKlATFKlRtaZx+gtC6RFlwldi7u3++aKYMHZgBftYJvhjGjj2A?=
 =?us-ascii?Q?lr+tf6I9Fu4DDw/udAEmJFOiJc0ED8G5PwsiZzyk6QWuAAnSECcD5y7RbMdI?=
 =?us-ascii?Q?AAf2EEG7JtNCp27iom4A6DTU6TpG9lUiLleW9HnKC/HN4OMWA5HhUk0LClHH?=
 =?us-ascii?Q?bFlkbZlIM8O7YY0JIZ5xc6lPU1g1KJkWbYnH3e5mFAnGJ8uA3zJzav9YWh+K?=
 =?us-ascii?Q?mABuvcx/os+y6B1b+bqe1xhOOmZPYEAmppWja03LqMT5UdcUyCLZUO5Qz6MP?=
 =?us-ascii?Q?Pi7EmosyUMNqRr7V93CoYbDXaYY3qoPmPIqnU2AoPi8IzRVF9/C9qRuPXkj7?=
 =?us-ascii?Q?bSOdCMqOBXyhmwx90F2jPhJejXSDVGeNL58eazZVPoIru0TPQcAUTOBFDnFl?=
 =?us-ascii?Q?XOVcrOr52M6FnPKlJ9mAsCKXvs6JsVg1Y4J1GKjXKPFNaXHMCcBDuKiwh6QR?=
 =?us-ascii?Q?neenfFcKc2oOhaFaw++JLKPITB2QuKlXbdoKQwH9FWQKWRzsIB/UEp1k7mh0?=
 =?us-ascii?Q?g0RAxh0D/RvOH5Fr26PxTn865ZBbImWNKooxbebaOmycaHwbgTXQyQAPib1m?=
 =?us-ascii?Q?+lFQiWlHU0xxh2eK74P2MYtqYvNz/YhlANQQRUqbFVUP79tpgijKMJDEhLSX?=
 =?us-ascii?Q?+i0bhz+uqSvy46WZ0vWp4qZw5Jle1cCba7uVNBB+DMfWxrNk2mjj5Ybqd3xC?=
 =?us-ascii?Q?MJZP5RR98lDb3V7tW14qLFJE9EFTOywYkhM3MQg7BqPdgjTdep9FJf+PYDiu?=
 =?us-ascii?Q?BF+165xCBn2G6GGI6L8pfyoaBOeSTSMmrRtNmkLEgL9OGsgExGSrqpfRWSyM?=
 =?us-ascii?Q?xQJ71Etsxg3Kw+E1/dxPiE0NEqhVJveE/43rdjBSZL/R3PIrTOkYDV/36xyT?=
 =?us-ascii?Q?YvOnyNLQPHaD2oh0hEEHTnm/Xh896SY8BP4uTzFFN910IROiF/aV/VIOzBEo?=
 =?us-ascii?Q?d8FSZ1f3GgX1VScxnCXDrqKqxVk2qwj5QpTGPTQW0pF5xMXv6Aar8tbZZCAB?=
 =?us-ascii?Q?iuzMTetMJPmnJ2050+eki9NUfy674OChPfF0SXaiabZQeMlyBqyQ6fhbm3yP?=
 =?us-ascii?Q?NVf8fOZSRL6I7fLWJuwb7tD2kxr1FgyyWArDi/COf7UC3Q3CtdUDag997FnB?=
 =?us-ascii?Q?UkPab3pdauizfRLw4DqMVY2xfgiTV8MEeyI0KG5o7kyhOc3o7+FnwUWwaHX1?=
 =?us-ascii?Q?RfXucA+Jx/eBJhcuFMFH7Cwrx5Wy7TeCcRklxDiMqYiH/RNnjatLcJI8bFQO?=
 =?us-ascii?Q?vANMaDLU/QW5BT0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pIwsDdI7vyTuhAf9AYh2CYuaQhtHftyWDpHAT/Vf2Do9NGzazlNRIdjBzaiz?=
 =?us-ascii?Q?nfYo+arlcCvRVDcVU/FqL+W1R0ZkfsfE5mvsp+d7N+Xo/ai2OMrC3EMKotl2?=
 =?us-ascii?Q?Ex14BZlwKm9p+gfw8vqXfg+GU8zeiCYPh6J2IQLDau3LuSRBy2xV6XFDqyAQ?=
 =?us-ascii?Q?nfvSjC8H5cKbgkPAJzB8Kw6X46MmHXG60bXf8MuEELQq0E9WtOiXB4f5i8MS?=
 =?us-ascii?Q?ChKCbaiNEU2YANNyEmzu3GicbGP/XM831Uj3z/0sz/oXtY3qKmJWfx6e4WNx?=
 =?us-ascii?Q?8uVfJNbn9eibDWFPQbU/p0W+VMwEcwoxg8M/6aqSQ+vw+s+EMCs9UnErlsLH?=
 =?us-ascii?Q?WTigL4quhfoRP/hln+ViZXRfFu+I4d0H4NI0N/rH7tnXiopqBclrPQ3tFsYc?=
 =?us-ascii?Q?ozdJ8y7SNn8td6tv+w0De9Vr+9RMZPHDvLA9k+ChpFeCUN1Q3YeyQ6o0bVtP?=
 =?us-ascii?Q?JYcDccI4LE/lyWie5Xs/thWn4pp6hAtBRwTt+lQ8thmIbbw1PUPPwbIHaS2b?=
 =?us-ascii?Q?jol+PVWqOgxaZ204D9RCZWv/LQVORb/H7Fh61WB+eMklI0oHAs1kR6q5tV4j?=
 =?us-ascii?Q?xBml2awCiZktKBzWvWr4k+CBeOkwX9Dm2MN3BqvS2Eicshy2VgXKCn4yLRAU?=
 =?us-ascii?Q?YMr3W9visk5bbxmE5dtJd7kqbv/J4nzDYre6RyIxnduS+atco53pFMIZ47qP?=
 =?us-ascii?Q?jSFqyohZj/VD8rA5JiFBN9UXFoOW9L8fYsntXRMfqAV4eawGl9z4udjbFuEi?=
 =?us-ascii?Q?s70Ut2rlfOL8lBj9eAMY3k4okAMu4YbKS8Girknez+gJQPnYKxkWEC/U2Cuk?=
 =?us-ascii?Q?TqCEIm2WeXkyusJ5gUkZ0dx+hcYjqpewGsVYg+o/3XxgbvUcqYjTBJCsv7Qq?=
 =?us-ascii?Q?pmRzBMCVkoV0byTJbCVudeMGYTD/TLXQEhJE/V/4R0HDOsC5tWDU8QM0Y7ux?=
 =?us-ascii?Q?2enhFgJdY+oUd3WLkWSlwvyFoDwtJtYfkldTJ9b7gkJTqY10we2SfNN3p33/?=
 =?us-ascii?Q?wFs/6188hHdzFLyOHqv/KLR13xLMZZimbqrz7UHfuRku90/Ywi1opSI7A3HP?=
 =?us-ascii?Q?5Js4bz+3IzYOixEu9xRvaOwe9SRYvcuGh9LuwnhGYJS8wlemCu4a2Hkq9Muh?=
 =?us-ascii?Q?r4tOW5Wnm6tXa6SmpK9qPhsXwCW8Z6IbneW8rrKJGhXTNKGqXr19M5kFmjbn?=
 =?us-ascii?Q?YWF4GB8RQ5/93pJgObwrULDFHnv+Z9rA7heusm3sMUzWlljEMPQSfMHe9hVG?=
 =?us-ascii?Q?C07MIVrHiAaJNL69Ph0reNTP/hgU+9sLixj/9vwaoG/vX2u7Txr7RXEf7Jrd?=
 =?us-ascii?Q?qeNg/B5i7ZE0fiIy2XL//Y8FNoekOxA+BLFX0dqL94c/+dVBNW/nsPKf8vMt?=
 =?us-ascii?Q?E1XlSAsjoSJcbbDVX1HiwtmJ0nZiq2VDzb++wFxJFNyeY4YuqBUyjDVHNYVU?=
 =?us-ascii?Q?IQRvqVkWfM22IF2Kst9IL8FRAW+FVngA5UwlG7BG+9jYZqoSFLviS8atFdnd?=
 =?us-ascii?Q?a8n4jqJrHi9Df5EJhZj4hwhOHGF4+Nn4wFxk8gtmpdXMoTayxrDUG4l8TF0S?=
 =?us-ascii?Q?7DRPupXnMMgD28OayYW0E2dBU1nax/h873FINBtl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53b896a-c80f-4c0e-c382-08dde5372f67
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:58:53.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhSC9D6OFVSVv9pFGg8AIHfyaWcNtunMFnsevBpC3ssbHb2U39ztc9wOHS/ky53a/DK0dgZuCBHUxX9C7AEzyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373

On Mon, Aug 25, 2025 at 08:47:13PM -0700, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> bytes from the page-pool to the skb's linear part. Those 256 bytes
> include part of the payload.
> 
> When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> (and skb->head_frag is not set), we end up aggregating packets in the
> frag_list.
> 
> This is of course not good when we are CPU-limited. Also causes a worse
> skb->len/truesize ratio,...
> 
> So, let's avoid copying parts of the payload to the linear part. The
> goal here is to err on the side of caution and prefer to copy too little
> instead of copying too much (because once it has been copied over, we
> trigger the above described behavior in skb_gro_receive).
> 
> So, we can do a rough estimate of the header-space by looking at
> cqe_l3/l4_hdr_type. This is now done in mlx5e_cqe_estimate_hdr_len().
> We always assume that TCP timestamps are present, as that's the most common
> use-case.
> 
> That header-len is then used in mlx5e_skb_from_cqe_mpwrq_nonlinear for
> the headlen (which defines what is being copied over). We still
> allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking stack
> needs to call pskb_may_pull() later on, we don't need to reallocate
> memory.
> 
> This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
> LRO enabled):
> 
> BEFORE:
> =======
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.01    32547.82
> 
> (netserver pinned to adjacent core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52531.67
> 
> AFTER:
> ======
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52896.06
> 
> (netserver pinned to adjacent core receiving interrupts)
>  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    85094.90
> 
> Additional tests across a larger range of parameters w/ and w/o LRO, w/
> and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
> TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
> better performance with this patch.
> 
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 49 ++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index b8c609d91d11bd315e8fb67f794a91bd37cd28c0..050f3efca34f3b8984c30f335ee43f487fef33ac 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1991,13 +1991,54 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
>  	} while (data_bcnt);
>  }
>  
> +static u16
> +mlx5e_cqe_estimate_hdr_len(const struct mlx5_cqe64 *cqe, u16 cqe_bcnt)
> +{
> +	u8 l3_type, l4_type;
> +	u16 hdr_len;
> +
> +	hdr_len = sizeof(struct ethhdr);
> +
> +	if (cqe_has_vlan(cqe))
> +		hdr_len += VLAN_HLEN;
> +
> +	l3_type = get_cqe_l3_hdr_type(cqe);
> +	if (l3_type == CQE_L3_HDR_TYPE_IPV4) {
> +		hdr_len += sizeof(struct iphdr);
> +	} else if (l3_type == CQE_L3_HDR_TYPE_IPV6) {
> +		hdr_len += sizeof(struct ipv6hdr);
> +	} else {
> +		hdr_len = MLX5E_RX_MAX_HEAD;
> +		goto out;
> +	}
> +
> +	l4_type = get_cqe_l4_hdr_type(cqe);
> +	if (l4_type == CQE_L4_HDR_TYPE_UDP) {
> +		hdr_len += sizeof(struct udphdr);
> +	} else if (l4_type & (CQE_L4_HDR_TYPE_TCP_NO_ACK |
> +			      CQE_L4_HDR_TYPE_TCP_ACK_NO_DATA |
> +			      CQE_L4_HDR_TYPE_TCP_ACK_AND_DATA)) {
> +		/* ACK_NO_ACK | ACK_NO_DATA | ACK_AND_DATA == 0x7, but
> +		 * the previous condition checks for _UDP which is 0x2.
> +		 *
> +		 * As we know that l4_type != 0x2, we can simply check
> +		 * if any of the bits of 0x7 is set.
> +		 */
> +		hdr_len += sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
> +	} else {
> +		hdr_len = MLX5E_RX_MAX_HEAD;
> +	}
> +
> +out:
> +	return min3(hdr_len, cqe_bcnt, MLX5E_RX_MAX_HEAD);
> +}
> +
>  static struct sk_buff *
>  mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
>  				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
>  				   u32 page_idx)
>  {
>  	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
> -	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
>  	struct mlx5e_frag_page *head_page = frag_page;
>  	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
>  	u32 frag_offset    = head_offset;
> @@ -2009,6 +2050,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  	u32 linear_frame_sz;
>  	u16 linear_data_len;
>  	u16 linear_hr;
> +	u16 headlen;
>  	void *va;
>  
>  	prog = rcu_dereference(rq->xdp_prog);
> @@ -2039,6 +2081,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  		net_prefetchw(va); /* xdp_frame data area */
>  		net_prefetchw(skb->data);
>  
> +		headlen = mlx5e_cqe_estimate_hdr_len(cqe, cqe_bcnt);
> +
>  		frag_offset += headlen;
>  		byte_cnt -= headlen;
>  		linear_hr = skb_headroom(skb);
> @@ -2115,6 +2159,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  				pagep->frags++;
>  			while (++pagep < frag_page);
>  		}
> +
> +		headlen = mlx5e_cqe_estimate_hdr_len(cqe, cqe_bcnt);
> +
You moved it even further down. Nice!

Patch LGTM. But I would like to wait for Tariq's input as well. He'll be
back next week.

Thanks,
Dragos

