Return-Path: <linux-rdma+bounces-12063-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 375D4B029D2
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Jul 2025 09:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DEA4A78C9
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Jul 2025 07:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FFA221D94;
	Sat, 12 Jul 2025 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VIRSVJ8B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729C1C695;
	Sat, 12 Jul 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752306967; cv=fail; b=LuAyQ70TZiZYNiR4duIVpYPw7Og6OqDlZdzkd74yEM5jV16Sv30ReYTHjx7agkFLz8l+GbJbrKf0TZt1zLVwTYddDk3dSW1fi7m+tDhKHMREj3zTU7wXMjFRzy7Om+oXlpgrqmup3P8pwGYSWOaVn+QMIgUoKXLgPyil+uNwEDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752306967; c=relaxed/simple;
	bh=eWiHsHfEsCTYuzM2lmsg+10nnEoWWkKGSPdqO+k+kK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W9LzQcsa59ZhoVMzdHAWWNzOjs/J0w5hXtjmlnn98yJn+jjG0uIXDRw0oArEVsuaC3DtpHz4GnzpQzGeAh6m8soD9VZX3e5AfNcxDzUSIoKZuOb7rLM9dR9SgSp1rHoqRBSqO8zUptGKl/9XXNcs1sFl8ERWY633lF6U+eYJJvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VIRSVJ8B; arc=fail smtp.client-ip=40.107.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfv3QvNgLAIDxK+sSmDAKCd6F4MUhZ8G4hUZq62EBktsfEvEzfb49OP2C58QhFa4PWCjNQTH68NozJS68eePHbiwb5tjE8rjJOlUH/uzh5oGoVaPsAM/P26ikfg4XnpmfwfFw52R07PMiGpz52dlqXWg3fcgVNlZGMUkmGVoKiqlgiJcixqEBv96PBnqG7Z1e7z0yABM5QnLOGTpnYJi5DD+GdAtcVN7P/vMtCFv2ESYUMVEE/M91cO028bz+jlPn5l4atQaZS6Eq6XB1Hu/CclbEEhUjXMr15I1sJJgXrp3Lj0PJh4I7cf0tRiSELYxFKMidwfO+Ppzy1gBmuyYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlEvC/+clwkgbTDWxqzPoBi50+qDcL4Resegd6hsYms=;
 b=BFaT4z57kwxSudMj2Npb9kE8Eo/bVQPrpN3VYwC7z83jAypATjDZ9YWMdeCdJYgzv8QWbSVP9zs8fnYpLPWt7g4uBy7QkyonFHgnuXt+UyBKgzEJhdlTO7R8TxS7Me+g6YZNy2L4z0wXbpgkFg8O+8bRdOADCnJo4M8ClxP60aC9JYD7idHT8ilDp0AtkGxAGo3JNyhWXIrd2Z6Ji4y1ZCFcZcUuWpbpddV4uziinIHLqsIG7kJwHTt6eIf7bbPXxwmmzUSOF6GQrts66vJX3sylLCdy0CZmaS0czH/0OqZ0WqjFwFMHV4ECQJNkd6hROBMY1fAAd9+bHV8y0SERPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlEvC/+clwkgbTDWxqzPoBi50+qDcL4Resegd6hsYms=;
 b=VIRSVJ8Bx9dvug1/VuMVpqnZeWtQoA/f6uPxIFFdYNR4w/VqN/Avcz2hrF6yci0pIWCudzoF1mhmwxTn1XFTNV8kl8eVKzH4AUsJNyReu28WGyML/yxE1enVK6W45AHHYkHtmbDe/OgbTPoEEL5IYaqdRCtPPuSTd2XS0mnnefnEhflvHw+nmzRdlfdIRMh38uWcmNUuufP17GakiULUAAe5qR7F8H6xt/Os5GLkC4fne60GqdzCR0Zof14U7snCBzL9hPhhCYPZ1NK9H3KEK5FjGNhOVkgcRlllb2BtjY+eBfDubZne1twdABp7FqmPOodwOR72nvkWclYm8txkqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Sat, 12 Jul
 2025 07:56:00 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.8901.024; Sat, 12 Jul 2025
 07:56:00 +0000
Date: Sat, 12 Jul 2025 07:55:27 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 2/3] net/mlx5e: Add device PCIe congestion
 ethtool stats
Message-ID: <nqfa765k7djsxh7w5hecuzt6r4hakbyocrp5wtqv63jyrjv3z2@qdar7f2osjcj>
References: <1752130292-22249-1-git-send-email-tariqt@nvidia.com>
 <1752130292-22249-3-git-send-email-tariqt@nvidia.com>
 <20250711162504.2c0b365d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711162504.2c0b365d@kernel.org>
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: a0753349-172e-4c9c-8f74-08ddc1198af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BjSkdJXWLQvVccNfWnBsFVLgTY8tk0UfXZ5ryJ8tRSru1k6B1Wel9rWKJiZU?=
 =?us-ascii?Q?JFM+CyDHMTJTeewwztJTa1v2hFcZWCxIeii39ObNvoPly9FLioWJtIKgByFp?=
 =?us-ascii?Q?wRVMTymczckZN5ETJxBeR0vyfYE41JAgbV06aglFD2FTA1nFNIjzHKlbd3Z9?=
 =?us-ascii?Q?Pwlv3mb4keYIOsouqxCotVwDuyb7RhMrseg4EWgC/OxXYB7wcZKKBP4pOde4?=
 =?us-ascii?Q?fm69EnQo0EOCNyuQ4gCw6nVnEP8QcoHXcGJaXT2C1SHhg4xMTZU1OiuSzoG6?=
 =?us-ascii?Q?jU9g/Dttp/GBIY3st6MRz9+N0N8WD09vMx+NmWkdPp82p/HiCVE+N8xKKr6Y?=
 =?us-ascii?Q?bgkF7Xi1q4ozm9k/WxHn9By1U3dWmkXnQ4YzJiV+zb+BbYDO1J73au30mCYv?=
 =?us-ascii?Q?Dd0SXmHE3BFJ9xfJEy8NBT6REp+y2TQ1ztf2h7rAvtjD5+ymGDlpW0CCDfTC?=
 =?us-ascii?Q?ynLeYX0i1CAHwaxX36ZqV2cfgkYzi6YDTcIqDENkK57jWBfaFm/5J4UYjgM3?=
 =?us-ascii?Q?+ik/7fp5yW1tkE89p/KlF6u9OmS5UMi0Uw2h7enFba2nnSnY9ZQ73hcpGjvh?=
 =?us-ascii?Q?RweS1k84UROrhBmTKTL3xj1ERvROgqo6BGLciL7X/espUzvE1P5Nn4SfXHhy?=
 =?us-ascii?Q?kX9U5hi32pU+3KnPpzsvAoEARmOGAfPVR6NIJHpbCF7A/CN4MgOsSDNTiQRI?=
 =?us-ascii?Q?XLzH9sNInkYwTOIcYkneodfp1DhVTIS5cNVBFr+QZXdxPULodsUNxIFL5bwW?=
 =?us-ascii?Q?u4RFI9zwR6pQu/V+5ng7wXBtAZ77smZKS5hcQJtQQ2kHy8srh9bBoXSs0Ks+?=
 =?us-ascii?Q?3LuB4TMYI3OkRbpJzv6STjvxxb4WPyOMsIt1GHhaHn0AXXpQZJow50VMUAmf?=
 =?us-ascii?Q?eOFFZxXiZK+EOUr5ApJ/es3nSst6UBrTJl7ASXCCTLOgWZm09NtVsM1H0Hc6?=
 =?us-ascii?Q?emVRAl2YkgEt1q5RgbTTSRQ2xNjvTwK4d2zxs/kw/78wmmAzX+N5XJBYpWif?=
 =?us-ascii?Q?4oKLBZgp8jz+B91ZW08CJzF/uVFT1l3tjUpwtYUxHGmE0JVIdXepLEaBV7TV?=
 =?us-ascii?Q?NoeoPO2GNA6cEHJDrK7loZVUAJ1I150UqM6K6/cDpxgmaE4P0pHqf7hBMc/y?=
 =?us-ascii?Q?99zcMU6QxgFhXnGOqwAUFlUomo5wJceRUvcB9D+GD/wDAfdr998QS/x9MWTU?=
 =?us-ascii?Q?U2Cf8dY5giIafNPzppNT4AHKB64bciO5gI7rd6jd0j14S63+6Sef+GOox1Yc?=
 =?us-ascii?Q?IAIFs3++Re/wV5kjWXFY3AwZ7Ck4ZENnqch1MjFh728v+AcvjWL+Bxnky/Z+?=
 =?us-ascii?Q?YBIJwA7I2wj1iWJpTxb1qzfAkQxPVU4P83f2nWhoxoi3LQLOGMp0l8VltNqC?=
 =?us-ascii?Q?WRpl90/iHsCETR45cYokg81iquSSW/OvDaHhi8YocwIdv/Gx8SmMSK21F9UY?=
 =?us-ascii?Q?mrVwcT+olVU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b3n+Taa2+EK93dv6yXU2Onopan2JR/Dw5RV1Vy1KVMx7f02tomyMdyHw5/Zp?=
 =?us-ascii?Q?7B5P4vHRtb7/GjG36GSRVDYTD2NjQ0Bnqq0jN3SGsEfe2Ga/hHouonJjOMCx?=
 =?us-ascii?Q?yAC7G02MTZqa7KKZHH9Y3w1GkqcztVE3UTJtIzyF/jWbeo+e2pnvILXclCtc?=
 =?us-ascii?Q?wiZbPUu5eRskhILkfkupqAmB/4lDzKwtAyCyElFI1w9cCZsdfaQ5AoZOAqJq?=
 =?us-ascii?Q?wCq5ifT+3F3PF7llnTGlcz2NUkJ8r04HOhD5Z0EY/Ji62CS7suAAq6ysKUZY?=
 =?us-ascii?Q?a35spwCzjdZhwsm3hIBFrC0unc/ZGAM9m/cmle6zH/zVoyTHXGa1gio0uzis?=
 =?us-ascii?Q?fbdpK5RDVhbVCu5cNNHVFtBudA367XvJjhX9KbPkDBUIH71UNcXRQ3jPLq7Q?=
 =?us-ascii?Q?bRS/o3M6cOxpc2il+IuSACZLniQbX9WcitqlmVJIRyIvwWdPvCGr0aXhrlni?=
 =?us-ascii?Q?FEpWnYl2cPeJ9W6DagP/YOVdVX8cgCjD/JaTDduaeZLQXvQL6jbP6V8n1bBQ?=
 =?us-ascii?Q?ca3i4uV9bef+hdT+E2UpuU0nsZHS1vkeTnX8cYNLy/tUuDJlq/yZE7Cho6e6?=
 =?us-ascii?Q?2dEjVXxq2k6/TuLapCvBKVfr/yW58cmVYKlzL9tx9DDK6uVn8AqdCivOWza5?=
 =?us-ascii?Q?smkmUhtsrfeWW5A0y8gOsw4L9wFsTdIbO8fUDqK+1T/1C6knSs85MaZMOCoO?=
 =?us-ascii?Q?PTGa2+115uMxHAgJ1bDwFGeDOB4y4icnGSvHGpaUH8Tmfi78t54m1piWQxOG?=
 =?us-ascii?Q?gMx82ljksepHnTGlBjHaLPKftstkd9KNh7lFvtvah7Hv6aWsIeazaJwwpeZa?=
 =?us-ascii?Q?1Rf3qwi3rM4aaPOxHbeXdORg96AOGGSMoQJRrAtmWzvDzuLGsGv0NI/ZDxzL?=
 =?us-ascii?Q?t1ydFNwqFS4uYckF1HkQOqNrRdrt3HX7stnbgQ3Oc4RQ/8rXPs7JKPe+BxEP?=
 =?us-ascii?Q?Eg/3Cu/aoWXtDTO4lCVJpWGJ7DJfZtAjzz5YGM5xsFSe+Gu0k/uywFhkwjs2?=
 =?us-ascii?Q?vKfujBZIFs/4OwshJZk720HznJ7b2V3tFT86zl4Lo/gfigE89w39KvVMizpT?=
 =?us-ascii?Q?8dYeey72WQd6vF9QeGgHb5qs5fjZjWV3nQqplfcIEnRvmyEzPSeziJ12Qt+X?=
 =?us-ascii?Q?sq+YkH3BFwBx8pP4+9VSxr8rIwQ8vnneLw1XPK3xWpTdsRzhriXoeBw39/xn?=
 =?us-ascii?Q?4CUdpjxS/wxsPG8rNCj5jUjM65Irxil7t+JELu8CQXIvW4GOg3Hyj5LxtAzE?=
 =?us-ascii?Q?WvFFVPK+XfVMMG7UmN+QOxntI+aK+cKTzZIdFf20RSXD8w7dJy0bkQ2Blcds?=
 =?us-ascii?Q?8EADDxkOY2kQ0bcYALFZ6aBO6rG46+Ci0WUqsEXe+zF77JBPYGa7IeADRMKV?=
 =?us-ascii?Q?4+CxSfOBsStxxbeil6xrKAsl5cDTGg37QrCEMYM8IbYqUn2F+H4EcY/hA6jz?=
 =?us-ascii?Q?sv1x0px4wDoJU+ch6NJ542Pj154/lfvUaI4BZKr9TNI/pIzPeZkSq7ZuLAUB?=
 =?us-ascii?Q?4tg43Nib8fOzwf8Za8BRd3DyrTBpgw4HyBNcin/enLwqn+8sk5PkxuLYri0B?=
 =?us-ascii?Q?9XJh2McYpYEjr4/Z12/01WoeXxxfweVOEIQU1lID?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0753349-172e-4c9c-8f74-08ddc1198af4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 07:56:00.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6D950JVmkvXRwf5lNF1bfEyYyAofSemoy8XRSUEKdFk2Xh4ETjWBQwTJl0YjLe7eL8XxAfvoAsFfEIeIgS/sWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221

On Fri, Jul 11, 2025 at 04:25:04PM -0700, Jakub Kicinski wrote:
> On Thu, 10 Jul 2025 09:51:31 +0300 Tariq Toukan wrote:
> > +   * - `pci_bw_inbound_high`
> > +     - The number of times the device crossed the high inbound pcie bandwidth
> > +       threshold. To be compared to pci_bw_inbound_low to check if the device
> > +       is in a congested state.
> > +       If pci_bw_inbound_high == pci_bw_inbound_low then the device is not congested.
> > +       If pci_bw_inbound_high > pci_bw_inbound_low then the device is congested.
> > +     - Tnformative
> 
> The metrics make sense, but utilization has to be averaged over some
> period of time to be meaningful. Can you shad any light on what the
> measurement period or algorithm is?
>
The measurement period in FW is 200 ms.

> > +	changes = cong_event->state ^ new_cong_state;
> > +	if (!changes)
> > +		return;
> 
> no risk of the high / low events coming so quickly we'll miss both?
Yes it is possible and it is fine because short bursts are not counted. The
counters are for sustained high PCI BW usage.

> Should there be a counter for "mis-firing" of that sort?
> You'd be surprised how long the scheduling latency for a kernel worker
> can be on a busy server :(
>
The event is just a notification to read the state from FW. If the
read is issued later and the state has not changed then it will not be
considered.

Thanks,
Dragos

