Return-Path: <linux-rdma+bounces-13641-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375F6B9E9FB
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 12:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75344C6E88
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C2F2EB5CE;
	Thu, 25 Sep 2025 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yb8Mlm0x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8802EA74B;
	Thu, 25 Sep 2025 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795951; cv=fail; b=Bk/itSc2ugcSazeTBsbxJg4PyXSqsfMduyj7uhUmh6YeyiRQRMXW30jfR38hQTT10+tklmLv+F4yqiRr5WS5YtEg761uNzy2HwjNrr85YMcHpR/ThL59q3PZTdStlXGhZSDllnzB//J78eecusD67wG+M9WGGbRTuGtfBzVDj2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795951; c=relaxed/simple;
	bh=OLshA3rgxiyIrd5eb/8oZUCxM/xB7XoOdnrhP9R02AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vB3f8fk1VvM/5Gr70s80nnrWcRuUCxMpfmobSNd9qc7uH79qPWBVTpI8H7Z5/TAOSqFT19ZLCESzKbos2B6eQCZFZbOTLDpDYJ8l+F+3M+q0svQ+LDFRIN7hZILMulqFKQnLVF23TGcAme2/1b4Gv2rgyIe72fCjRL7nRllyNOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yb8Mlm0x; arc=fail smtp.client-ip=40.107.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvS9JhKF6Xy90rpm76FNxobxJQpDUbRnGze4OjjSuGz7g9THsFPPGwa7c0eg7ys1uo0uEAME4ssaY2UBm7aPJXOd6Wpi1g1vaoXm4up2tfeqs8YkON5kwuIXoJaa8ksHFTzFMPZ3g5PrMeTV91Cb7x2nNdzH5jdPZF5kHzYTHJBrWaiyJTocsmhPCoxWJ1MXK/9RIu2qQ4zNGB7KNuimjD7WOa/oRSuEtfUfqa57+WTbJbLP1HLDJJEsQEemh86JVBYtF80libRpLgTm9FlpXS5JlrxchyIXgV+giircO6H5Dw414nSGfv0bPsvvw1fkXBooSsg7ADx872njLMR/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNaN/64XuxVMTOJgh2Fq+XDV7mUD8ui1Vand1w7vwuY=;
 b=G1Rq38Edm3kOcPjKWrH+njaSNlg0C8bRgaV8QEUHhpYq2HnwDwfBL0jj9i2TX/Wyu1H4CnA5ktDKDYXqOYQMvQW5Am2CFknIR3TvYLV4L+yjhZJ5DcDvX/C6nYuHp4XMuPBUbWg7VoyziX6bF/qYGUdbUQvyUv0eV3+LkPVyWzNTzfmaJl93ns5adCwKzRg25AEyAXp5Mh149cljRHh2qq1+ILtPGTzgJGzvnbILzmwVmDhswpf+mTSg+oudjB37k0WW23SVtzx5+o7CpLPS1LJqSxUJ/cgDXXTuo16xMmiprfK+e8IXneqlJeK9nZ8mu06kwFpgMWhVfl+5zopP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNaN/64XuxVMTOJgh2Fq+XDV7mUD8ui1Vand1w7vwuY=;
 b=Yb8Mlm0xu66U6P3m/NkqOl8tCqQjOvWHW8c9PIC7f3TDNfA4sZvD4q+BrE52AMWGeAV31XNNr+dcXiF8wYnO6bh2nI0HAE7LgeaYEwUNuAPc5F6NpuWax3fX7h9LXOJ5PZ9NbSB/rCvt9+IH7zQnTD2aa8OMoPrLTP6Zj9RKz3LsLs4NJLpMj9fA4qFAMowVASago7OpYgdxUdxa4A2RC7681RwRBywm6x2VXY+/KuNH2jYppPSmWid6Nuxtr0CBaDml1TCWZDA2fi+hd4QY2Z41X+MQrhTo00OrjZ36jhprJ9/PgTcGhAcb/aC4T9av4XymCgiFT92JnWMI6Mgv0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.20; Thu, 25 Sep 2025 10:25:46 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 10:25:46 +0000
Date: Thu, 25 Sep 2025 10:25:40 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5e: Clamp page_pool size to max
Message-ID: <wjdkpgpgsoe2igbf7w5padgrbjbog6srktov37unmfouuwn6ox@its3txxslpe6>
References: <1758532715-820422-1-git-send-email-tariqt@nvidia.com>
 <1758532715-820422-3-git-send-email-tariqt@nvidia.com>
 <20250923072356.7e6c234f@kernel.org>
 <a5m5pobrmlrilms7q6latcmakhuectxma7j3u6jjnamcvwsrdb@3jxnbm2lo55s>
 <20250923082310.2316e34d@kernel.org>
 <20250923172305.0b0a235c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923172305.0b0a235c@kernel.org>
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DM4PR12MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: db2fbd37-47fa-45f4-3b83-08ddfc1de3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y/RyIFH6gf+GYF4cwrHy4OvXFOhjeuCtq2dOzA8QTiNPBRpZVWoNv4Jr2e/6?=
 =?us-ascii?Q?Z94xbilLa+evl6AZn8A3YdnDohB/a2sgVtAbTflitchqaCc6FBVP9J/TgLvL?=
 =?us-ascii?Q?N/X71gRllhP1Hfyqvt9UvrND0bzRn++D+iTl7QTsBht8c7QIIoWfSq3Xk30w?=
 =?us-ascii?Q?sih4QdfiZqdhUeGtyv2Pmfy+CXm+aPDXC5/aL/moPnmdYYom9Sp4LRVO0EwV?=
 =?us-ascii?Q?ysAq40dtKGUd0u54GWtxLQN4yF5d5US68aJbuGKJO6P8qbPmEIDuDgy/WaSu?=
 =?us-ascii?Q?+mpx7e1el7Sq+ncx80LscEp2/kdQRrbdt+i81cpZZP2ujbJf6LlAjxwM3+Cn?=
 =?us-ascii?Q?9MFS6mJoVuvxwPWmKRM26tR9zjwQiCo6Y10tu+LHpp96s2PrR+8IzDjlQEA/?=
 =?us-ascii?Q?ENUX8Rxz/6/4yCWHzrp8KY/zK4kJL/rYyV54bMR5r9R8Eg7cyd8m2Q9vaV9d?=
 =?us-ascii?Q?7iWMuySKGbVonzLwQFQD7w1zauPT/EmBSUBliLFXuDd4vD5WWvrO+YJ4jQ5E?=
 =?us-ascii?Q?ta7qC1/hHfGJ14RkvFXDJjsJYIptVDHyQNL1RUgD4Oa6VRyquJsmIYZmm24S?=
 =?us-ascii?Q?PzXx/681Jroh6mkkhlnIMNO1B74lR7iHX3TEiTuuFrW6hfLvjgsHuljVLCVA?=
 =?us-ascii?Q?1EoPP+QfX0FnujpT/J6EgZQjDTq86+9/s3yLWDwfCD63mxW3ahqTciOlsgNs?=
 =?us-ascii?Q?r4G4QHLfDtt0WCH9PkgmzCxB9R6BqdK41JrWxtaTw2ekfy1rwIhS4Xf/6yqx?=
 =?us-ascii?Q?LZQdUUGIeKNOca9TBal1+/q/ewd7hds/jyedYyWmDftiDJGGlQP+IfPigAZr?=
 =?us-ascii?Q?z6H0SIEWK6qGNShplRNgeyTh+fhuM9l4Izn5Wc+8cicXnICjIuoOXYpzz9/H?=
 =?us-ascii?Q?inaBqxuDnSj2f2/dDhpJUCMJhBxpxShZiNPh6QuObTtIt0ORYKSFHrfxms+Y?=
 =?us-ascii?Q?9odcizVWPS8idvOcJdk5bdAS4St8uN3bPgA0SlbPQcILq2E++MD/xlJFPKkV?=
 =?us-ascii?Q?e/NX1axbL5SIaG7ls2+ZyhDCxXg0wyd9JmJpD+zz6CwSquHYRk6oxdYPv/wV?=
 =?us-ascii?Q?VigSYuqICrokCKMt6wmjpb9sAmcUaPw8PNiZj7/fPXDtby4CQkJBpxFg+B5P?=
 =?us-ascii?Q?7Ug5B8qkaayGljbJ7tGXf6YDdV+5GXPAoN39KQCbpi3yyMaTMKIItk85Pcz+?=
 =?us-ascii?Q?9OvBzDWF/mIuzEM2S8ovjNPkjXRfiET17f5esUViGe8EL1m0YF5oNSB6R1Tk?=
 =?us-ascii?Q?//KxtLafuIIe4HMv7jmj3HP27MvV8y4ha7wSQO6DXHtljzftnxL8ZG5tOsiq?=
 =?us-ascii?Q?9cgY1qIojsHeEDBMyr9gJepMIIo0r0rZIg/azW755RNeHljdS9MnWCNFq6BA?=
 =?us-ascii?Q?6xrSmRaQpxlsYuVgU0B1pwGnSul9Dmf+rI36JqbRtlJ5lDu0J0Hu2vaGh1h6?=
 =?us-ascii?Q?Aj96LonYNvE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CU4SILFJh76Ikhmcdw/2OeaPCikI9I6OhHfanFWJSXORUqMfArfhG1qzyBDr?=
 =?us-ascii?Q?NZBpN1Of02M1vLJctrwnTdb2wV91lFuWNvc9Co7mpXGf/jTBblUD0MEgHglG?=
 =?us-ascii?Q?EId1z5RPPxu44SqKsPHILj35Ss1l/6qgnY1fs/0n33ECzN68dTU4C6ecfRqU?=
 =?us-ascii?Q?c+b/uWTmB5DW3rrvs1X0y6iv2gxvqVGJQxcQGmWWktf7/1RJquEydFlAhbDA?=
 =?us-ascii?Q?SGY6eXAOYe1nJL6UuXzYB+eaHtP3tFIRf9gPpxuVKqt1lmlzKewi7jC7N/DD?=
 =?us-ascii?Q?UhS6n/dmcU34GrxoVei1NvJo7j3iRce31viVu9hk2F0EvmSVuz7En2/dtjyT?=
 =?us-ascii?Q?0b8yMrKnN1aXgHnZOOT2hVZnwfbVCEhVpouoyeeSi7txrWn13ToQ9Haxytl3?=
 =?us-ascii?Q?ycIM8MwZ4bEtwuwKWHj2E1ojC7mkuwRwXwkPpwyuTKtUlRRHAoe5nAxn06J3?=
 =?us-ascii?Q?XiUeBGIaDxOfNOPzwHX7RSEja16F7itJzF3kreZV04YPfOXtIdjPuK495051?=
 =?us-ascii?Q?yLWkP+kywXn2xN835jweR55G6xTIg7WKJpQtXQPoeppytGdcJ8z1fCgRG6DD?=
 =?us-ascii?Q?NK9TABrGyo6W8yMH8hkWHXBCDa44bJZdDIV1r2+OA2eTL4bEzCJcHgPg2z6Z?=
 =?us-ascii?Q?FYc5rs3Buenhk0zLC1tpg/mOsOsS6/Cy9CduMeSctINdE+XO+prng3TxHWm2?=
 =?us-ascii?Q?5kdsObpL+nAWMcR91ULFse21F4ft0pkP+Pz0QRGK5oA5XLlLH4w5NCpqiIZc?=
 =?us-ascii?Q?YAKcf20YXq5gyTQxMMjA+sBH5GUX84tyn7cKSJu9aSOdWZHndJGtLP0JsYUP?=
 =?us-ascii?Q?7E3qXNHLkYfkEm9BXjxqwbNwFp6Q8MHJDhqWy1g1DMCBsY3EYKKB27Zhzoh1?=
 =?us-ascii?Q?jsR4qqzSYoUBStjB2YPupnxYdslr2rCRgK771cLzG4RGFLGN8qvZg6nuHFH4?=
 =?us-ascii?Q?bmAbS0Nsm4WOxV4QTo5AGx/bDduZ/yDnDhvVoZmTVMXUEg2zDk/1e+PiVGO2?=
 =?us-ascii?Q?3UBBaHJjOAUuNBzlKsvnf9wxHMzL70BfcIfvFqQ/sDIyiB3CTA9Fiy6X7BB0?=
 =?us-ascii?Q?ncxMshkTejgmVurJC2l2osYRMD48h7qKZY+yfCSN59Mixo6tllclrTyUy9Dg?=
 =?us-ascii?Q?aj2R5VRFhyq8htpsQ/I3F7vl/Td7jQDLfqdsrC5vDEeLfl5mKc7d+a7km12w?=
 =?us-ascii?Q?dEUR+sK45H8SDor6AElTCupafFSU6cZe2m8NmxK2BgnwvBfGvfN2yP5cw9np?=
 =?us-ascii?Q?hx1p3+nxZauSpOtW4lYlQABFTwfzQiasta1k2zVYeQHjeVlVMBDXDzvMVeDF?=
 =?us-ascii?Q?RFoYM/A1gYhrm8EcNIENWKXB9T7fpPv+Fn1ZkboYTtQdQrnCiOdZlBmoIl6F?=
 =?us-ascii?Q?vcr8cC+ZXesN9aJJdGKNP7oi0S71LV4EilvGzxkX1mDJAS/buEeMMmhPN5Tc?=
 =?us-ascii?Q?sAFR+4Qma52Rr6zeImEs0fIBzGBuv746tyUbhnPetUB1SwpF+DZmfFIZy13v?=
 =?us-ascii?Q?UpaoJ4NX9eZspainO3H24PBaQ4mVLSXRC83ciw4y+hPwq26BpR5qx2ZrB8fK?=
 =?us-ascii?Q?IeqQVJQ/YbnLfCYwCvM+ASk80ylqbTKiWXYmFxBl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2fbd37-47fa-45f4-3b83-08ddfc1de3c5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 10:25:46.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MglEnwXg+iLnyGsiFvhb90YAnlYZUc41BC3GinfgvlMCnUq+oO6I6rsaNQhhLBnXyBqlkjPwi1iZbeC4rifEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892

On Tue, Sep 23, 2025 at 05:23:05PM -0700, Jakub Kicinski wrote:
> On Tue, 23 Sep 2025 08:23:10 -0700 Jakub Kicinski wrote:
> > On Tue, 23 Sep 2025 15:12:33 +0000 Dragos Tatulea wrote:
> > > On Tue, Sep 23, 2025 at 07:23:56AM -0700, Jakub Kicinski wrote:  
> > > > Please do some testing. A PP cache of 32k is just silly, you should
> > > > probably use a smaller limit.    
> > > You mean clamping the pool_size to a certain limit so that the page_pool
> > > ring size doesn't cover a full RQ when the RQ ring size is too large?  
> > 
> > Yes, 8k ring will take milliseconds to drain. We don't really need
> > milliseconds of page cache. By the time the driver processed the full
> > ring we must have gone thru 128 NAPI cycles, and the application
> > most likely already stated freeing the pages.
> > 
> > If my math is right at 80Gbps per ring and 9k MTU it takes more than a
> > 1usec to receive a frame. So 8msec to just _receive_ a full ring worth
> > of data. At Meta we mostly use large rings to cover up scheduler and
> > IRQ masking latency.
> 
> On second thought, let's just clamp it to 16k in the core and remove
> the error. Clearly the expectations of the API are too intricate,
> most drivers just use ring size as the cache size.
Makes sense. For my peace of mind I want to do some packet rate tests
to see that there is no perf difference and compare the page_pool stats.

Should the page_pool should print a warning when it clamps?

Also, checking for size > 32K and clamping to 16K looks a bit weird...
Should the limit be lowered to 16K alltogether?

Thanks,
Dragos

