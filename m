Return-Path: <linux-rdma+bounces-14128-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EB2C1C3E6
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 17:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E32C1A27134
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68962D063E;
	Wed, 29 Oct 2025 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HgcSs7r3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363021B81CA;
	Wed, 29 Oct 2025 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756351; cv=fail; b=TE/50yGN+/tQeg0UdMNSKe/Aapq9h/Ma7MSs/E+GMjpFWAwmeBqKOEgpAfVnTv3SohZZOA444J91NRV50JW/yfgbvud5cRPBhzuK1YqbR/ZFfON+b0EgQVuEN8o1URPHCg0hz99ZMlitfYHpFENZo8k/L6OsfUQXHFHO+ubSYWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756351; c=relaxed/simple;
	bh=hDQzf0286BKX8itxhNygQDCR+Ev+Z8UmmnICALCu5Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=juoEE6kOor6Z0zDxEN14no/cJeTSyPESdrC6q84NrYU9H2Ewz1HVaqSH2Un9Z7oVr76UlXqs8UDS6j1qZrKYNAdhSOpi4LwwnqLvAMlP3kJyuONE9euJjFbQPAKoskVY3/XB7hcXmdLdArNtOZwjhDzBPNGPIeVJQ4qZhVJocUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HgcSs7r3; arc=fail smtp.client-ip=52.101.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0OwaMbVu3dAMqrDrR+oINUH42k50mx40rbfTUNLryl1YKz4j825OC5ZftnsDwHLk5ERtxUcvOsYB8WbVVb9j/85nbLg6lFyPkGErvvQmc87egydFENx8SCu9VxF1+cQ11+vkcPRGgIrwx4REbsWX6ATDBPuIoSVCZzkspKelBOa7LBVXQINer2kQ0JU0rS2trOz3JUdAMULxiC1+DEr+ndsDHH/ONjZCZG7MuSQyIPMeJ4fnFNfoPMCITIJMbwKd6EseaQQAJxN54pog2fPgaw6XtrKGpr49I8KIms0lpumlv4cx/2PGriTsA3a+hUX1wwtE6cdRAyfpSG7Ks8nhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7aKJPymLns8hQakFTgEQRJQnpcPQP/DZCLKBJpIcu8=;
 b=Bp5ikJACatLyR18C1HgFgcIpL3tomIk9jHxdUNv6viMXiJSLD/9rKh8SYQl0paVkmeXJ3caL5UABjxOFGaJfIEeowFIvSJ5LS0qJUbyOKZDSg8G/LX6nAsr08R+s2IJl7fJWBow6Yc23Kj7k12Ohnu0FdV2W5Q2sEHhJiOMYLqRt4VwDekSHzGjoZu6DTz6wdsz63bKQS2fsZ0f2r8NTQUI/lWmCNT18wkBPo99wY4cInG/2tmBlUhirctSdrlGwjOqWuQb82MPzIgvRW3WLxSkjqwZINewMwbDl5DpyZEfjmQQjAke2ar0l5tOuanMr41rAyBrfK/dCSabax4TNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7aKJPymLns8hQakFTgEQRJQnpcPQP/DZCLKBJpIcu8=;
 b=HgcSs7r3exmWTc3mnzCuFWBQgCBAqlcqmL0M/Ep4jgU5dLOisHnLdfphd8cxC1e8fsiDbZAA6+AwOlqkcLIlk7hZXPqr/+yqMs7YkfSyWkvu4pT1Wj9CxC/J2Uyiiuk8UB02ZXh0ewfUr96fjexjjlW1Nglc2Dv1QiVvFSS2GAAsQaynosK4MrJALKwWz+q0DQ+X9EA8JKHIs1d7sPB1y7r96EiqljWtZE4R9K2sbogbjQU7P+45OaS4DfDcL39+B/aeOgC3Ri+mbmyLT9iRy7oyomtwuFgdaybiADBTCb1zI6Sh2wLaPIp0opwc4cP+EKN4UEqyakG78kcjAbPpcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DS2PR12MB9685.namprd12.prod.outlook.com (2603:10b6:8:27a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 16:45:42 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 16:45:42 +0000
Date: Wed, 29 Oct 2025 16:45:00 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net 2/3] net/mlx5e: SHAMPO, Fix skb size check for 64K
 pages
Message-ID: <nluliyurnbpf44vonqfcr37d5jlbv3avz75sqqnexonjhddztu@7bdewwkepieo>
References: <1761634039-999515-1-git-send-email-tariqt@nvidia.com>
 <1761634039-999515-3-git-send-email-tariqt@nvidia.com>
 <aQI30QptJw-xRGWQ@horms.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQI30QptJw-xRGWQ@horms.kernel.org>
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DS2PR12MB9685:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1325da-ca02-485f-5b18-08de170a9959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OkbzzpaaouylwpdaUc1u8XVpEQF4LbOxyEXKRs/JUUelLWcV90pSsXra4p71?=
 =?us-ascii?Q?W5DrfE0uC7JI9N2blt4U4kCejYdANh6SYPb1oo1k16We3DDC2fbuKpPsUtqm?=
 =?us-ascii?Q?yMiuSbkxbb4GBOjW4dM1zAQMBANtVhPOR3cG5iSDq+fRwI75UiRCaYQ+b6xd?=
 =?us-ascii?Q?HO6kAiqJNYjcucBq3dFMkN1yua5U4FJuLlIIVl/SPIPBCSdC1XqqJ8kMzbO8?=
 =?us-ascii?Q?zFRQWhlDGwRHiT+80ZDJhQ4lcPlkm9Zziz3llyn65SrIf3hy7SdujkNr1kax?=
 =?us-ascii?Q?n6teHptvQB7z23ztP/ghRh5ZT902xnpapeRAaFSyCwTTojFxe38kA6lOql8j?=
 =?us-ascii?Q?a09ZA4OAyK83Jlg96sD0bI58ySyDI4NShKiS/uR7r3S5nHf1UPe86wLAsk/7?=
 =?us-ascii?Q?s0tYiIGgVEX0MoDX/W0Tt1VW3XY6Wm5GBbM0VOj+zIir/IG2XWLz8O7tCkxF?=
 =?us-ascii?Q?/6xeorQDGBKdtq4JZFefMVaxLBmEAyT61frFFN+GJvqmRr+TSllvBSuneL1O?=
 =?us-ascii?Q?0+xnSSsVj0qVN9LFZWAHEZke+TgrrRq7WhfBPKtQTNe84bkxnSlQ86PSqdWi?=
 =?us-ascii?Q?hhaEuDS2QntH67qv+6Gi5Vq9hC/JTJtKI+Wq0xecW8n0jk6KQjTS9Otwdw+F?=
 =?us-ascii?Q?n8SDK7eoVez4SgzoVlrO26gqdXTJIRqxw1q8D63F7cEeW4jurV3aJ41LnJfT?=
 =?us-ascii?Q?JXxN4UoeSd+8FF4sjJP+XqpwU9ms51kISQquyjkJIexrgDuFBIgXIkZ7wdN1?=
 =?us-ascii?Q?D1bVfj4l/umnNqHPVyIzUehRhjMa+T4/f0CzycBlrTSHmRbifiz9d0dVCLtl?=
 =?us-ascii?Q?YO+sFvgvcFDFApOYSIKoPOw0CRbP2PChbE3gj0dcwbHHEMnEroghcXU47Bjh?=
 =?us-ascii?Q?pyzlZvM/7PB0sZhKjgFUV0+ts0yNN223vQrUwTrN6Dqxf/llb9aarRg06f2B?=
 =?us-ascii?Q?nwq67urJ5oGA2LzcboMfcnkHdrRrw0NHNReaLhCQyMaAM493fwN7aufxlVwe?=
 =?us-ascii?Q?BxeOz4KwiLuxqOBACVgp/kek7eX49QFXHGhDyy+5bVEvq2QJm9aWJwusWXum?=
 =?us-ascii?Q?Y/JeypMr08tLrepn4ro3vk7gNfISNlNMx7PC6XjsMU6x8bGISwiBIYoPnJPV?=
 =?us-ascii?Q?/OU1dX//fWD6GJ0T9YGzH5OhFhoIibtvUexeVm9ePTN7MS/ngpbxFomXC4Cx?=
 =?us-ascii?Q?uHs4ujmLprbzcAnHqDMEPd4gYqszC/Nw+IvB4c+K+nGtgG2EB66tt8bGyoa/?=
 =?us-ascii?Q?H2eq3XpncJx07hxs1uTVNc6dW4wWIlMOPK1KfsZe0vbvtkp2zsL/K2puxq5E?=
 =?us-ascii?Q?gSYlYqox6VNc5++2IPcOtqG9CD1/qZGjBH4P1wVLJRwyg05bq+cV3v2/2xKo?=
 =?us-ascii?Q?C7IxhYpfZ/dEJR7Y5g5GDoilkYjGuUgGUG83GJpx45nzMACKPLoLDNHRocPh?=
 =?us-ascii?Q?kKY/rHLn7L4Ti/CUXNgj1roNMCu7cPq0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6opNfUjd3tQBxo1rJBkEZiVQoBAr+vIQlTgw7nmsfy29+5r3YA1BJeBcHP1g?=
 =?us-ascii?Q?FAMAGNZFslr4cEu/oILtzQrGQWMBoGAaVw+APMqn1uySi4FATTw0s/nnfW7H?=
 =?us-ascii?Q?W40DaF3gEf1Lg+wi7VrigWOIdEAjzp1JMeGv9jl/kMTU9+vVYLjaita2cgVO?=
 =?us-ascii?Q?bxIIprCDwbuMicPZNe1eBwBpeW100dxklEoMOx17zD0I3zKT6kl1r8sVdB3q?=
 =?us-ascii?Q?pqiXwLpCl9CwwYbIKdS//Nn7qyAmn50XblSQxTsDUXr7wXRDRxI8BsYxvRjv?=
 =?us-ascii?Q?D7hsD2rb2oyj7Kvk+r5Y29xZD88soeoS+gZmgpieIuZvhXxdL7seIXbpzAYU?=
 =?us-ascii?Q?ohlkL2VCRUTk01bsjNw1xsx3ArD0DmSH7wyyf6WTNGi4knaTZXqcGRrCxLVj?=
 =?us-ascii?Q?Pol+gEIZKTQWhvU5dYhv+yg+V7oyd7jqjG/D28AryApcRrnP84f4PO9s4Uah?=
 =?us-ascii?Q?t5GwBNpoHxLw4MKwJy5jsQn63JSyGkQ9yEPD3TKd8g0NfrW8ONhgd9ucbOSN?=
 =?us-ascii?Q?PD2yA1GykuOdqbauzJ9N3XfKzQCaTol5IegAGi3ZGXW1spEdJ/WynNxFKifx?=
 =?us-ascii?Q?XSzx+ooXFv5vEgs9KphPiHWkEnyIJ9qSWobAowfGqQgTlEvw2MAJs3bRTHND?=
 =?us-ascii?Q?73ACKid0gixPZ7EdUcbiS+LSzlQZdNCWWSQiVVqjvVDWiqz+1XbM3CEd4or+?=
 =?us-ascii?Q?f+uTwUfq7HnPEdczgDKb9mcz3N4Ryt/bGsPvmcpvTjyw8mHwY7778KJvZJVV?=
 =?us-ascii?Q?NejVWwNgKKfA499qEtcPPRQkLaUAzLx5UmFWu18KMuZi3Dq8LCGly/gfcduk?=
 =?us-ascii?Q?u8oNPPELOJRkG8NA97Dk2fqRvDdRMicCwZh5S9D6Po1PcJ3zvCD1DP/EZDbG?=
 =?us-ascii?Q?9FHZl+IP1HG6bp/QEd3ZKNHTJneKuUAU6FkB+403V34MjqaJ/jhmkPvWiFMD?=
 =?us-ascii?Q?FiOaTlVLxD48ebLoO5nArMtMnon6w0lpcql0KKrLCeLH4BWoiIF2hk5DmwY1?=
 =?us-ascii?Q?LOugj2U3BEqHXva7kQFfApCIE8cZjw4OnhnIKaM/oUCNFrdFXZFaURlfHvcb?=
 =?us-ascii?Q?DHeYH8grBL8Wp6LLSKkLKTWWeN5Sjl7T6Ff04o/22Y9Raj86MVQZLI2+OnfJ?=
 =?us-ascii?Q?EoyrFDiYXOLq+tSoWBMYv8Ft/FUneTU1B+05xGf58mF0lIkWC5yMm8zCTnlY?=
 =?us-ascii?Q?+BnWDHd3A2RYG0WLNiTg1o4FTSLWzNCo1qdkXcQtcRHPeubyATpo51/BCqug?=
 =?us-ascii?Q?BIHl2NSIKUtPjAHUGX7gqX4ZnI87e76kgrOupSoaY9186MeNEGQWdJMS2iz+?=
 =?us-ascii?Q?FaT/OY1p3i5ry5XFTlUC+HO3ylH2aImri8CksHQc3WVo3d5uJcDnVERx7z3p?=
 =?us-ascii?Q?9ZgDQF/xlkGp/Q737UYuWfao0nw+zJTangIdmLbzmTqkpSZvWQcEF8M/f085?=
 =?us-ascii?Q?lG0jbknVE/5I/Q6QX+EIHlTZY1Qn6tWniQsogEjr9J+zuGD+aiZhNduYjf3o?=
 =?us-ascii?Q?rUtx3LlytEWUiMZJXygu6BHkfUsxjsOja1s+AveW7SuPS0trPdLsw0o4yCic?=
 =?us-ascii?Q?iBDy5r7mys5btUZC3ZavZDpcdpUu0lh6263NMZDO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1325da-ca02-485f-5b18-08de170a9959
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:45:42.4944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cf17+WvebHWwhTXNGYVz2dC9wloItNaWmS9fstGEnyr1Dz04gu8XZZc88icM0BShCF2kXCLnPYNKn2tEBrMItA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9685

On Wed, Oct 29, 2025 at 03:50:41PM +0000, Simon Horman wrote:
> On Tue, Oct 28, 2025 at 08:47:18AM +0200, Tariq Toukan wrote:
> > From: Dragos Tatulea <dtatulea@nvidia.com>
> > 
> > mlx5e_hw_gro_skb_has_enough_space() uses a formula to check if there is
> > enough space in the skb frags to store more data. This formula is
> > incorrect for 64K page sizes and it triggers early GRO session
> > termination because the first fragment will blow up beyond
> > GRO_LEGACY_MAX_SIZE.
> > 
> > This patch adds a special case for page sizes >= GRO_LEGACY_MAX_SIZE
> > (64K) which will uses the skb->data_len instead. Within this context,
> > this check will be safe from fragment overflow.
> 
> The above mentions skb->data_len, but the code uses skb->len.
>
Yep. Will fix on respin.

> Also, I think it would be worth describing why this is safe
> in this context.
>
Makes sense.

Thanks for the review Simon!

Thanks,
Dragos

