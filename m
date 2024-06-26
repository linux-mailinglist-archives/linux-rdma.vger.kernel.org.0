Return-Path: <linux-rdma+bounces-3528-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5AE91860A
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 17:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3E52B228FB
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C5C18C346;
	Wed, 26 Jun 2024 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m+eiMpUh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A5416CD12
	for <linux-rdma@vger.kernel.org>; Wed, 26 Jun 2024 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416322; cv=fail; b=cDAbEVJoBJOJF4ltUYjWIRfZcxd377LhbGXlyI9P95p6WUzR0DcNCmYffH1Pxxd5fgxho3a+FFLDQ/GAd5ZWe/MF/kgO3WicMVr68V8zzAVXKHznFs8BafXGca7nxRCq/sestd7coC/ZW7BdvhSiyXtzBNWOlvlbiVognx1ZNcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416322; c=relaxed/simple;
	bh=U1hACZ++r8QkiG0ieO6v5/z6qBVjS8CbEW5Ee2wGsEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KL3u/x8Xq9pTTj6cseY9jvdqHBaPwU1AuR95o9cFwzxQK+nbNPKLjKCFts7zK9K1BEWwkW7dkMTTGuOMGx6Z6o2EfoKS11eLr9IhVZxr61x5/P2WHbQInkfgcQbXwBoijMRLF0og7Vn1f+7VplGJgW/Lx9qrUU2MgKsZAWGzL0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m+eiMpUh; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL7QnRo20dlGPvSsuCk6JPdpX5WcOTZ4HKN4JXOJOY5rU6AGviCumKFGI8ojkVRaOfW67qFbFN3kd/ZwhjMEgdglI78ZKX/deU9YRMkLq6In9wvF2WuKY2jsYZjAkGXaTcdm+M8I4Surrjc+ZiLHFFKM9bBp2pq0tq3962Fr6zOVI1lZnBMZJT2zk6pxD1qFCP6CmGU3Zgm6UsRvY9oKaDpqoOHjY+3kRkQfCnJHPd+EWLIduUhmfd9ovE9kCLbh0Y8Pst25BmCcHQoUHfIdAID2EXUok4VsZ7vahJ9xpfKRB3r1NfX/2V9l3gtW1cFv5ClR8wNbb8DtoVLtBXyXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1hACZ++r8QkiG0ieO6v5/z6qBVjS8CbEW5Ee2wGsEE=;
 b=DnG6s+T5ORobIsagwRQ0UWAEm1lHcwWBByAe7WpnftYw2kvGK+SxEq/BgnpLy9xA0htaIw7hkKRDRHv9zjNzPGtcwlKf/qTHBaWRdy2W2klIn4HspLk2Utxe8sVnAQgcHdafSmDeACcR6RP6B9f19aekxDdyj74ra4BDutJMgkzg1Q7NuvsckWEVFYMpjD7ZQNjunqk77MNRWyD7cwTt8+p7v6uQDN2uSc4Eq794JX2wgFrKFfTgBBS0czaXwKqOISdyYbPxuqU6ldM3/wVutx21DuvPOg2JhEfw0+nQq0LGvxn+T3AlcvK9FI92DQUFpV4s9+6F7qoPMXDbVZHr5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1hACZ++r8QkiG0ieO6v5/z6qBVjS8CbEW5Ee2wGsEE=;
 b=m+eiMpUhyes5aKcEKtGTrKxsNlZo7s/vLvbf+b40+z7vTRWJ7c6XqYuNzvgUj35YhedxIn3Tf35u+139zMiu60mDARpd+Ey6h+zLSpQDSFjYo/QP2UphAZki2jQzV4cyIYcedIQxlquy/tx3axMhJbSFqbypnVqgoz0xzLkoN9A+VoVYVOrUfc+jem04iu+/cc2dY5l+mricd4TwHXzWFD7UC/P5fVbm9JZ5DQnCCwHMqYb99rg/QGIdqQxFO/QIh8RewS/yiYd3VMrminzbuqqONb8mYovU+pezDjUzreoI8/G+4ypzZNZN64ge8w/7JymladEOXZd6F7lF2rwtNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 15:38:36 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 15:38:35 +0000
Date: Wed, 26 Jun 2024 12:38:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next 5/5] RDMA/efa: Align private func names to a
 single convention
Message-ID: <20240626153834.GA3233164@nvidia.com>
References: <20240624160918.27060-1-mrgolin@amazon.com>
 <20240624160918.27060-6-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624160918.27060-6-mrgolin@amazon.com>
X-ClientProxiedBy: BLAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:208:335::23) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b0c42b-1913-4a7c-d396-08dc95f60aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vn05uXEcSptka7WPBsaSFu0xHarbsfuVnb1l7i67e6z5s/0cA8GIuqHhbjeK?=
 =?us-ascii?Q?h/il9/xzRDQ3YZXyDUenXS2Bh9q5Us1I5iQSt22KvgogAQwh17Oi2zbfRAAR?=
 =?us-ascii?Q?K+P12HcVN1sqZpdiPvx7Od6lN5idhLIfoLNE7EDJG3GA3lNC+cFLxgZZHKWj?=
 =?us-ascii?Q?hV6+FrHlJsceR22TbFHFnr6hOOHl4s4CuQ8XQq6ZUEC92U6o5c0PlJlRi0C8?=
 =?us-ascii?Q?KGXVhA5+Q6p2FMTwyzxD5PEtIHQgKiJGBHX9ko/gZzpnhVdB5nN1PQ+7buVS?=
 =?us-ascii?Q?tPt3sledKaBMzaZLqVxtn1hzYfkS3hcZFXZEojsNdI0cQUzin+R6glZrmWZH?=
 =?us-ascii?Q?Alf46C98HcbwjiP2KIS8x26zXRNMBeYG4DA1lgNvUqkB7Wkhef2WokqC0tAF?=
 =?us-ascii?Q?F8E8/5Icis9+WDrx8St44y5ZKd+0hw81zKfV6YheIUW5VVVjzzfYqyseq1Sm?=
 =?us-ascii?Q?letX/12fcfjwX9WFn2zjRFIEaSd7LBLYDjhT0Vqfd1Vzcw3PK3ZZuNmVl5ac?=
 =?us-ascii?Q?LkCSFzPdGnrdzWjRDin0m0/S0LITvkD5B+z0Bet5/q1DA+OIuARAPAaPysB/?=
 =?us-ascii?Q?LMHUXUcAXEBKHC7fnoeTC6Lsp1QEyHP1lqKSsws+USdF/3cwpbyRQA0Ueo9Y?=
 =?us-ascii?Q?kPiEqf4kQ9uIAMJqbOSghrTymByrtcUJNUzJrz/rhqD0Gmkn0EOkb3y9bDva?=
 =?us-ascii?Q?A/Ofc0ohbr3PQWUwQmt/DnIzXwXmBUl1DHvQkcSkQ5zYpgFTwB9dA+mem7uw?=
 =?us-ascii?Q?hlYvWZi+lCmXooanNRs34rLUz/RUR8WZ5IfTGbP2C78KP2ON0O4YAZ8W2V6u?=
 =?us-ascii?Q?jq8M1GGWRBenw+dVje2NOX5RnhfESUDxRN1lD9K2W3HJJwdumF6OGzHq98Cg?=
 =?us-ascii?Q?GV1J/CUf1lu0M21wtcbCCwmt6Ge/2s+1G/4MD7DrEetuYtv6Y5b8GfF2WRQy?=
 =?us-ascii?Q?5kHCCXtpF/Fpe/cv+Pp2TQOF+wT5/wgEK84SyZtk58A2OwVBH1HNxW7g8Z3q?=
 =?us-ascii?Q?TwTq3YpdkGPfRAMxdlmW67my+UB0ltpZMwmJO4Jj7BZFUUBuYcenGoKsU9XM?=
 =?us-ascii?Q?i7ygoa+rNNcNzIE6U+ZkNTzVpe7DMzSQp5t9MHs5RiQv/9v9z4eM5boKfgnf?=
 =?us-ascii?Q?jFknrAbjbSE7DWpfP0RmYjAZS8fOtjdY5XcGLKO+4ovTi8xOx/VojvX/2Sr8?=
 =?us-ascii?Q?PTgyUNPx0IZtFh0nGfWnb1c36PlzFDrDiDM2JPEmd2TB01jWncxYzCgAAhhU?=
 =?us-ascii?Q?BqFftIL7wVLGvtb5ixH9XN6mDgJ/TJm+2YyxHM4sSQaEpm51ZHwvLxre1NY2?=
 =?us-ascii?Q?ggbcnvX4QinrCIEJ5rboPMx+IPJWqgQUUdskeLKUrU6ulg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4B5vyKZoKUkGleSkoJtRSZyfVkROZZigB1R5i8B0bDRYhVr1FGVRxEITEi2k?=
 =?us-ascii?Q?tF7LY9mv8el9gSxfuXoem3xE0BrDCB9o/CWSYpoKdgW6ydlTheH7oZ8cGXXG?=
 =?us-ascii?Q?4j+Vd7bRAuRe8MFzqbF1rcp/VZucXtCYCTQYpTczo8RbkU5uEmXmD3/MePFh?=
 =?us-ascii?Q?ZK3mUa1Ab9Gs/l/Zmhkw0o1QXXKqW735KcF//0jB9eSFo+WEucOwIrFo3W9Z?=
 =?us-ascii?Q?IPVoCDIMkuU4wPgWZDRMvpPsl3RD/yf/2AVCINgh2aKtUBtEUmYXjb6LFbhz?=
 =?us-ascii?Q?WglPkJaPsSU6TnaL3oSum+Tw8j74Tpj6mkCQwTY9/fVhN/tt5rLR3koxQiL+?=
 =?us-ascii?Q?c+PQDr7Mza8Je+G3a9729SIeUGlbVI5blcenVvVdUtol4vCVqrhbQNbz4vzq?=
 =?us-ascii?Q?ie4cCXeWI1Kprh12Y9s3qHsTX5KSuvcro23cgIj8RbRUq8gGIz/GLvJs4Ayu?=
 =?us-ascii?Q?dGhgRMvPKxGuma2D3Dj6Oy9SbAdxHZwgkWsCdoOyveFGt+xqzW05C9i4/smZ?=
 =?us-ascii?Q?YL2FAnkG0F8peqQRNBwKvv4WqsTsTDNn9pIex+GotI2ucoLAuw2gpi0nCgj6?=
 =?us-ascii?Q?k//ae3XAoXJOycwinoKbUsRVWht9Xw2ueK6NvwsnRzaZ8POWy4Mmfkpf8EwO?=
 =?us-ascii?Q?Zp8InFsnWGACzUIWoUX8r0SQHtbeWt4jaIVyyB+mg01jMQAbpgh7CpVGOLwf?=
 =?us-ascii?Q?fSARX0Q9XlZbhF769YzQUpfGhr51v24SiOVwXrqtGBuWNwCBVN30ELWBMJVI?=
 =?us-ascii?Q?U64NZlvHbGzQXo+hAVtlVxWOypZhoGz7OcBsfUNyL09/VVm6S0Q2OAxHWsqN?=
 =?us-ascii?Q?BCH8PHcq2WZJVC0KALlji1lWrCh4aTXMIjcz6S0GhUNKO4V7Z1YhXpKs/4YJ?=
 =?us-ascii?Q?7LSMLzHpvPpR7GqSVdFMHLRaO0cHeObthEjXyQ/7cPfHtylf8x6Kr9Oz062E?=
 =?us-ascii?Q?pjT1/42pY5kuDDA+hb37quCitgvq0NCbkPEMYSk5Z7VsgqkwweZMCyD459Vb?=
 =?us-ascii?Q?l4hdGZ2ZzNalE+XDw6MGwTwB8UcBA8Pzx+CiSzUWBH2zZPcEQCqlceG3fSrE?=
 =?us-ascii?Q?VJaaARRUPsHquaNQxB3k6bGgzmJ0jlU6eASKnAY8ystH/3mPwYiJ8J3bO375?=
 =?us-ascii?Q?XFhQawZ/y5/nf1Ec9gd3lNg8SK9XCQvC1RNmSZ7nIXtb+B7do4OXtxSxQU0+?=
 =?us-ascii?Q?BJP8RpB2K5lRiHqlyTVmML3ATZ6InOoBodrwHTDIAH778Uj7MZfuaCFgrQ9N?=
 =?us-ascii?Q?/kBTz900D3rR22gxux9geyNKdOqeyG7Vl0gAnQj7fGY4TJbFZ8tkwdeo/KaQ?=
 =?us-ascii?Q?Y7Li/tfnantWRN13XGOANJlsM8CqxqFrfxEI7WM/4eMrUqeEtMlDVP3bjW1g?=
 =?us-ascii?Q?749WNRkZ8wcgeYL1c/JcI1kIh7/6FvX+uJJt5nAZJ8GGbsqI4scnzb9zkvB0?=
 =?us-ascii?Q?gXxKZ4u47tQCSi8fVKFXMZJ9PPfBRwHmsv1asEHRrfsnR8/dx5UO/ueeuQgP?=
 =?us-ascii?Q?8LXFvn4v/dcIU0i+/aOY8+0BLeEetKSJymjB5TVvY2B9P5W/x4h8wiGnLQ7z?=
 =?us-ascii?Q?Upjp9BhXvV7bj5dPj12J/sanqGE/4++M6DWNuDGp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b0c42b-1913-4a7c-d396-08dc95f60aa9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 15:38:35.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uW639L+FfDac2MNtUdXXqqRQBygYHXJyaAtnpqzJAerBygmS9mz72ehH03U5Phih
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419

On Mon, Jun 24, 2024 at 04:09:18PM +0000, Michael Margolin wrote:
> Name functions that aren't exposed outside of a file with '_' prefix and
> make sure that all verbs ops' implementations are named according to the
> op name with an additional 'efa_' prefix.

That isn't the kernel convention, please don't use _ like this

Jason

