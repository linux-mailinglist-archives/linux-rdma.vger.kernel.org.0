Return-Path: <linux-rdma+bounces-13160-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3334CB49156
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 16:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA649172E50
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 14:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FD130CD94;
	Mon,  8 Sep 2025 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AkZAzQ8j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E11530C63B;
	Mon,  8 Sep 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341583; cv=fail; b=rq901QV/Z2m993CarUwSiKaOnpyJ6iVhwSzql8pRnlF7EhlFicdnEOxQbNyrk81cVfjTmw08Tqh8YVTC6ycvfOSTQlFuAZuW3t4WzmL6VaOPOKOB3CJodDks4bKNtPU9kvlaAMDkKs5SwT+lqC/rhfvsRmzbeo0bOIlYS6H6W4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341583; c=relaxed/simple;
	bh=jtn3T58JXYZaLglUEz4i4JJaM6+9ijvd/4ch2hoT+yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m03vC56Ka2rW5JsSrLLdQlKCsmQzmP4mn9rJu0fOS/4jBOeD62IHLqlJMlKf+FRPn+ne0n6FKcP87UQqDdQcgqthLEIWtXUXHbDuuD8e1nDIatqt/NO7i9PI/+s3LLaOS6g79LTMBz9F83rc4SFEHevzyIEJ8saHgsNt7MTsXlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AkZAzQ8j; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvq90kNC0VCTWddM3aGqXQC6Z/uYtHjcz0ejLiDPOXVKpDFtvFHKu29zaB/vWNeckPzHQ7kkxooOTGuU1dtM/wireVuLtCiI7yTuVxmf3RZey6nPb0fZBm6c2BK96B6sowkJGUhfI7m73VpKomgJPiUZpKGlbBATZNNPGXV82RJ5g46FEyXyvNKevHMQwbg+Pe/ilI7SI/VJv1s0P+wxCRCka3WAA4ZE1Y1Sboj4H5Z0R3ClmaGzZzbmYDVQh2Ri70bRNG94ZUSZC6sR6B3zlq4xHeWLV2oe71TZzYrvQ0rkjPrE4anTBWgrQ0tmhhNllFs8jXQmEQ69IEjPR3qmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QOirKwxGfxbPohCBGfbG1iTtCQ2Kgspt47vll3rkeY=;
 b=JP5J5pikJ89oLj1PnIgcedZH/V1sbb5awUuE0hl6UKyeJ5iPYyM40my7UFnLxm4Cs1Iji2gG4WvzEhMJ6PJukpEW7Dyd22PVpbQKn3yco/A/JItEScOlGAZZU4r+6sOWgB94HQdAPlG7ML/dvi4EzVDw7mBxMKkrkA6iAgTNi3y2eAV9XWTszMkFXwmbuXgqECr8mN4nok/Y56Jk/kS3MxjoqQGOHFGPuS3tt2vp4cAQ5KWcY+A35gixgHVwzkE/QLKbh88bXxuVqnxAilN+dxeeeNp9xcbkOq3kuTINBzCb2Vez70wzwvvOTSFcbVOTh+t+tgWlJJqeRVbWlxCNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QOirKwxGfxbPohCBGfbG1iTtCQ2Kgspt47vll3rkeY=;
 b=AkZAzQ8j6CeJMET3Ee9mRJ4LAtyPe7NvinK2mAa5GpxOs60Svj0rtHXu+T/nWUa61zwIvFB6tr49jcPip/UEau9VCcrsZWKh/hevu+royPYQlcF3BUgsU8yX2weGuuxpnuL5omOpy8Irtlr11mBH0TvIoG2N/ADCvxkCvBVRXf4K4Mh4XukXzPGpBbONb0kZ7w8SbfO1dcsGf9UjRCZlHnUTbTjMpIBPeBJY2GOiACmvmbwIM0AiNpqAkIWvEY79bZUtI7fC/GN401pYyjjA/HUqLvnbMJZyNDcab8N6cqtXWIQ8ptbbsi4+vzgLkLX6pl8hT3pU6IRB4bMenDlQzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 14:26:16 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 14:26:16 +0000
Date: Mon, 8 Sep 2025 14:25:48 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mingrui Cui <mingruic@outlook.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	saeedm@nvidia.com, tariqt@nvidia.com
Subject: Re: [PATCH] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page size
Message-ID: <kv5syvra5hlvswecmzrbgne7ydmj6pf4dhzcoica3fdo6dina6@64w5pvo3lvbt>
References: <l3st5aik5jtsexq6yng5el5txeif4itbg35kl2ft32zhi3pmef@kn4x6bo4ws7s>
 <MN6PR16MB545062E2EBB54C553CE059CFB70CA@MN6PR16MB5450.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN6PR16MB545062E2EBB54C553CE059CFB70CA@MN6PR16MB5450.namprd16.prod.outlook.com>
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 703dca59-ad83-4942-998d-08ddeee3abb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P6WeNLsTiJ7Mesf1q8R2HFjtAJ4PfacCZbBiW+dnMfgCuAQSZH9V5goZ4RlV?=
 =?us-ascii?Q?vveRZbND1O7IHwGgi9xoIkpBhJ5zb8rQXmr7y3p12rxp4hkLK+OcIltxvDLD?=
 =?us-ascii?Q?FGTcrKH1TkNTNXFDS2M0bCxPvBM2hQxWBV6QtvbZiBD9YjVzXVB8q/cWC8yY?=
 =?us-ascii?Q?lMUHw4GNy8i736z5Ii0YFZDoZpvnlrCj2Axy3nKqCqaJp5b/nx6dRAD9nG0R?=
 =?us-ascii?Q?Om7lyoeRcHp3TpcwZJ5RLwYfMtRQ6DPWMTAaIqkzw/32AjDRSkIzEEWqS2bM?=
 =?us-ascii?Q?Xn1Rdcrjd2hsIDS8q0hMegRxhlTu1dNdbAj1ZpRPx9NiPdNuWxSS1cjwodYs?=
 =?us-ascii?Q?8QIubaoVyHPN6ILHZ8iZMNbYsgHbaGSXTA1bjwj4gRR520mdcOfWmV+TwmLg?=
 =?us-ascii?Q?200dcybPCxjXZVrMnrBWLrwak9i4wWhaed1bbNOO2SmGC0v7IyZrvoJEWM2y?=
 =?us-ascii?Q?MUFQBjLa+M9wQXap7fvFtM6f5seZTyz/eDDDgH6O4SbyA8+vfCouY8KLUPJ8?=
 =?us-ascii?Q?O7AboZ7qmDqexJUX/D4iCGLOS7x8Ge2d3B7hfJx/meWrenEDNNott0u1bIpA?=
 =?us-ascii?Q?UDGHxkp6pqxNf3T/opymbGXtW3caB+v4ArxjdqwubcIIp9Ly4yVBmwE9C6aO?=
 =?us-ascii?Q?hIREO6nhF8SjlZX8rXNeeYFpQ3qyEyKAP9SlqN8CWM/wGSso415gzaW/zu8O?=
 =?us-ascii?Q?fl4vuaMHJ4/rs+eJX7k6A/MaHB/+/S1+gih3RO4BYtGYrvWadVyZiXVShdzB?=
 =?us-ascii?Q?zOy9WPNw3wm5tcsXOY5UUxO9Kw973hY47/Midg9xW1s6inYADpIJvcLVOebU?=
 =?us-ascii?Q?X9eJOxsezoXPucVAzPgmHlgubxN8l9WhNUQdMF+Mz9PUkiZIKUUk4XRRqGj0?=
 =?us-ascii?Q?f2zQJKXnys7Cjt1Qm/EDjzgkby9r3yFXwoWRYfFtW7Y3ZeiiMSUyiJhPRYh0?=
 =?us-ascii?Q?hLUeaxz0DHJFROvDPcJxsd3iJjl0+g3JJ9HcMG7d2XK33U4JgoWOIIaZIj7t?=
 =?us-ascii?Q?EYkFxMN0KMucGR2hvEqMOLMcru8/Drh2JiMgRdAojEeNbzbYYisLbW2lwR9W?=
 =?us-ascii?Q?XgujU28btq3E7/7hYvVxjsASnGc9Pwl7Z/+wqVku3Pqt5cUOc+QcjWKIZNFR?=
 =?us-ascii?Q?WNn15LChDlMpjDdYSJ4dUoVOGuMzh4gNM8BkthtO+1dZK0hY+n1MkhMHL765?=
 =?us-ascii?Q?rU/pbl05BkfLZFF2yDbPtV85ZpCF/kkF+ypicNAo6buEm1neV7L7f1z1fe1f?=
 =?us-ascii?Q?gyvH2bWUWmFBTQU3R+MrmbttkI6bVxN6OoBsu1lrmWMLRHPqRiQBGnkM1G1j?=
 =?us-ascii?Q?BZXalvCigHDDNsoC2QzMkviVqMh3PmNnxXmtX9Typm5nfJDVUKLc13/lttxM?=
 =?us-ascii?Q?SmoC99mhpZkuMwDLrpuUFEF7HZ4psdG25RBJdt1qLx1eyuL0D1qxGJxkrvFK?=
 =?us-ascii?Q?Xvfb9iknF4E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l2p87ToOHhLPr55K9/cX8BiLAOJxRO9iMYNasw1pTJloqMth/gpnmBFVVcm8?=
 =?us-ascii?Q?o1LLibSNtSdckL8rs9s7bGZBWRqekJIGYQ5UEeFnA6FU7SNLuRqc1FfelVTs?=
 =?us-ascii?Q?VVtjfhiRvhvlhl+GnMpYI0ZN38eLldXJMOOv/jY09Q6V4lOk12fdrUroizk5?=
 =?us-ascii?Q?F5fYKiERGjzDhOVsDgkMmb+pHqGpz3kGXYRYsTNzYtxyAqbAWCBKPq5niKFo?=
 =?us-ascii?Q?6KBlkY/wOOHgsawaOcAzYyY7q+cHGAGQsC9sqUW7vCIiUNIUWxzofvqNyWMR?=
 =?us-ascii?Q?oquN1yxMZyYOdzxDiEwEwWoTK+Ukr3KJdyxVpm9VPFZGyX1s9hiXxlEpz2yE?=
 =?us-ascii?Q?yW3GqC6LJ/2olq7KolF2c8FbePk2n4iezo23JdgPQ9w5Uccd3PaoAeE5HABL?=
 =?us-ascii?Q?ehRRJfELe++jriXGN/CtoAqOSR7pDM6w8ueUFz86auidqbH+dxNW9op09exp?=
 =?us-ascii?Q?Dt7AAiKAjELHoT3AXG0I5YEib+JlaI67y1XNQ8VzB9OIaYgTito81vPQdtv6?=
 =?us-ascii?Q?fwFRzZu/rPp04Xjzrt44L1W/s78ttHB2D44hsPpcyqUf3F/9JACk2OpIpIwD?=
 =?us-ascii?Q?e6McJqFgEELVMKxX2nqlw+mgYF5NsyZmytJKmbUNk+8VieaK+27DexfLy67g?=
 =?us-ascii?Q?obWXMOD6zkuWm3LyllPRWlNgsfiKem5Ij4DrS6RWIf2Mbytu3N+cla+7x2L2?=
 =?us-ascii?Q?251sy+2/CWJLB5zU++RwSIxgLNA3zywO4Eqc1zJVZeY21/b64z8plO0lfhfj?=
 =?us-ascii?Q?cHUbz0LNPxuT4So571krVpmPTBu8df3Nkt8vwhgk1zrS3R8dVjD9ydz1gTwT?=
 =?us-ascii?Q?ExTp8jsH/WMebeZpuXAiEi192qG6ilgPFesToJVNgtsjE7m/7LaMDhk8f2ff?=
 =?us-ascii?Q?4LVgTaX4D5pzI0dW5/3DrcAsXPwKDPwgtAId/Bcmj2VomSZMvTU1ANwT3b4I?=
 =?us-ascii?Q?cpyj9CqZZqVfI5tggLJiSQ+NacAaSHWd1nC+2FW9MhtX3X3k56nyCQpzQinn?=
 =?us-ascii?Q?vF1DoBkqFBsjI4viHI2DdpcNXExzbl9g7XqVwGqqwbWYel8t/H6px547olOx?=
 =?us-ascii?Q?CmqnvGZ2YbUH9m5eBzj/mvbt8j1ge9J8Q186JyjJoDN7ubZvX2Ka9XZpCyJH?=
 =?us-ascii?Q?xOqrK3yOp1Wq3YLv1k/1h8CwRdcBEn+kxo4EpyTwExOgXX0txwa4lqvs4A47?=
 =?us-ascii?Q?NjsoCwnkjqr2Yxrwc/pFVxq+WiZXnXZGPZPrZ+5vz1z1zDCY0dsC6KGovM6w?=
 =?us-ascii?Q?IX/MQZAzLE7h6gPTZ/PbolZzN2PDwbaFJ+ajpjdr42k1ihw3WgTT4/qzkgKc?=
 =?us-ascii?Q?pFbyTc3Y5Ih85w2pMa40w7+vX0r+pSahNQb+owKGddjpBiiDi58MtqGGHwn7?=
 =?us-ascii?Q?S5qhTPwE5fj+6nce/k5lpgEDm7dvNAeT9wnMuQeNWXQf3fwUTvHiwskAGcNc?=
 =?us-ascii?Q?LcbiajYTohimqPCmlzp4EZkurR++C8AIpoDq3TNFvy/sOGaqLvkdrKx1sb5a?=
 =?us-ascii?Q?5MRt7Yu3Boej9wIldviQNqicJbMIDyRLieeNOvhUu6OmjAOvTkU0jCuBzMXj?=
 =?us-ascii?Q?9ZjAD6bJBEhrQVG3qM7H+QAgvP2pLdr68ZpIZkOG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703dca59-ad83-4942-998d-08ddeee3abb5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:26:16.5932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fw8AzZYE8OZXgtSJPW4Dn227oVP8klE+URyUIqMhPXfmWH1UYCBQ+Fpd6pM9QpbdG1dckIwQ+z1K3vYTk/O2aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174

On Mon, Sep 08, 2025 at 09:35:32PM +0800, Mingrui Cui wrote:
> > On Tue, Sep 02, 2025 at 09:00:16PM +0800, Mingrui Cui wrote:
> > > When page size is 4K, DEFAULT_FRAG_SIZE of 2048 ensures that with 3
> > > fragments per WQE, odd-indexed WQEs always share the same page with
> > > their subsequent WQE. However, this relationship does not hold for page
> > > sizes larger than 8K. In this case, wqe_index_mask cannot guarantee that
> > > newly allocated WQEs won't share the same page with old WQEs.
> > > 
> > > If the last WQE in a bulk processed by mlx5e_post_rx_wqes() shares a
> > > page with its subsequent WQE, allocating a page for that WQE will
> > > overwrite mlx5e_frag_page, preventing the original page from being
> > > recycled. When the next WQE is processed, the newly allocated page will
> > > be immediately recycled.
> > > 
> > > In the next round, if these two WQEs are handled in the same bulk,
> > > page_pool_defrag_page() will be called again on the page, causing
> > > pp_frag_count to become negative.
> > > 
> > > Fix this by making DEFAULT_FRAG_SIZE always equal to half of the page
> > > size.
> > >
> > Was there an actual encountered issue or is this a code clarity fix?
> > 
> > For 64K page size, linear mode will be used so the constant will not be
> > used for calculating the frag size.
> > 
> > Thanks,
> > Dragos
> 
> Yes, this was an actual issue we encountered that caused a kernel crash.
> 
> We found it on a server with a DEC-Alpha like processor, which uses 8KB page
> size and runs a custom-built kernel. When using a ConnectX-4 Lx MT27710
> (MCX4121A-ACA_Ax) NIC with the MTU set to 7657 or higher, the kernel would crash
> during heavy traffic (e.g., iperf test). Here's the kernel log:
> 
> WARNING: CPU: 9 PID: 0 at include/net/page_pool/helpers.h:130
> mlx5e_page_release_fragmented.isra.0+0xdc/0xf0 [mlx5_core]
> Modules linked in: ib_umad ib_ipoib ib_cm mlx5_ib ib_uverbs ib_core ipv6
> mlx5_core tls
> CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W          6.6.0 #23
>  walk_stackframe+0x0/0x190
>  show_stack+0x70/0x94
>  dump_stack_lvl+0x98/0xd8
>  dump_stack+0x2c/0x48
>  __warn+0x1c8/0x220
>  warn_slowpath_fmt+0x20c/0x230
>  mlx5e_page_release_fragmented.isra.0+0xdc/0xf0 [mlx5_core]
>  mlx5e_free_rx_wqes+0xcc/0x120 [mlx5_core]
>  mlx5e_post_rx_wqes+0x1f4/0x4e0 [mlx5_core]
>  mlx5e_napi_poll+0x1c0/0x8d0 [mlx5_core]
>  __napi_poll+0x58/0x2e0
>  net_rx_action+0x1a8/0x340
>  __do_softirq+0x2b8/0x480
>  irq_exit+0xd4/0x120
>  do_entInt+0x164/0x520
>  entInt+0x114/0x120
>  __idle_end+0x0/0x50
>  default_idle_call+0x64/0x150
>  do_idle+0x10c/0x240
>  cpu_startup_entry+0x70/0x80
>  smp_callin+0x354/0x410
>  __smp_callin+0x3c/0x40
> 
> Although this was on a custom kernel and processor, I believe this issue is
> generic to any system using an 8KB page size. Unfortunately, I don't have an
> Alpha server running a mainline kernel to verify this directly, and most
> mainstream architectures don't support 8KB page size.
>
Oh, I see. Thanks for the note. I had issues finding any arch that
supports 8K page size.

The information above would be useful in the commit message as well.

Also, you need a fixes tag for net patches. Probably this one:
Fixes: 069d11465a80 ("net/mlx5e: RX, Enhance legacy Receive Queue memory scheme")


Thanks,
Dragos


