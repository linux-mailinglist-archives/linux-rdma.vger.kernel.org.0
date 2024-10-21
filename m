Return-Path: <linux-rdma+bounces-5463-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154499A70C2
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2024 19:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4FA1C22A10
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2024 17:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCB11EB9FD;
	Mon, 21 Oct 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dKqBujcm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BA61C330C
	for <linux-rdma@vger.kernel.org>; Mon, 21 Oct 2024 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530878; cv=fail; b=XAGXjYl83WroqfQ3KzJ9AkE8ZZQ0XU9c5thy46qWE+GpjqD54cFuL2uKxxoId3wtOnILs17z8pOUEG7KOqiJt859kp03lxZaoCyeLzLpeNIjL2mMCd6AxzSagTEb6+KmQr85AhsESFl2fDZdSRI/hq6PEmiFMiPtK1bMv18o3pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530878; c=relaxed/simple;
	bh=+g2Xg+9XeS7YGsI8Ox2xT8V1CU5iISLyEMLnK856O/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dP0F7Pd5JxxAFMx2z34jnLzSRf/taAJozDYc6TPLUdCGzl/MKSOEtyPRxyxNtVxARvZHcL1JJP99O7Ed82vbszfQjbNwX65a9j+Xfo/kYJLiSY/sAJWn3JMBswGNiYsglE9DlTqdHV/pW16QPwWfjbrc+m6Ta3nV6sG3XVAJ1N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dKqBujcm; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z50yEu18Vd/sDWsO2N98yJkzNKp95nY2I9rXb9m7NcmhY/HhfIx59187vnP9wIjXaN45/yckvgSXDKHTK9gqZXbhpQg1N+DAkE403sJgEdKzllSEQjCjgNnqjKZz5jLOQBdWHNXbGli8Rtod0PGePH1gea3n7dAiU+8vtcCj64MEGGImy8aKSYP6pUjVYByVaFGE3TF6U/m/Th+/exPYS8qUa1f1GvcvBwuuOTsouh8uXXeIrkDeAmg9vTCgXNsETsdnapYv6BOS2sNrdP4yZMuvfGWACtiKtcQGTVjIToJWXazFee/dwk0BzTadQF+A2pM0r8RGvfvQQZYroN9lyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPy/0phujc/PpxRUygBDwqJfWiSrLGz1I0hWNuVIGP4=;
 b=YviBhJC/deuNRBQ5pVcoi2OiUbfhF8fIiIJjakylaiAPdH+JIMJlvR2amIMo0aOQ1dxZee+Gs1tMweiSt8uVJc0kkNCR7dE0wA7UOkAFGVY04jPJ7GXjcX1ZUpynbcGzfuh+Yn8VjTl9x2g5GVRQHXTGcsXkex/llrxu6km9ziYtREeWhc2vWjboaE6yMJ9qrL2AAYHwuITJvasBS7330S0uZyRYTT8/o0yem/e7dtG/btjsxznTqDXlcRVzg9lLPmQyyuXYKqkOVm7eeDGGBiq6arbThltbMZ5DasHaHoYFt2chnwVCDGz3cS1PkmMHqq4YLOxV5YY0E29uOtGZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPy/0phujc/PpxRUygBDwqJfWiSrLGz1I0hWNuVIGP4=;
 b=dKqBujcm0asKK2u0FnGAI4lmLlbBRGspu0rPONpC9dwgLddRKnV04yt+xGU7NIIwk/JmybdxIUDcXHK9VG1iHLK8p0XcacTA301lfiuYyn+KJOEupjppo5wbnMHUfbGBVmx0iOl7lgG/kXUYVxswxhFogWcuRzA1o74q7ZBsVZDmqtMNuBWXufor+2wBH4uYXYwCzvQDQ5YSmv/vmemcaW+3ptIB0VhPqqwvmLH5zM0ZYvtil/AJPqFGIAyOQMe6NGQZH7iiJhteLSRuggSwj2Ub7x7h94VoCmOQfmgqO6av00cnEyoUZVgoz1eMHM5qnIKpN6WRS6MMN3b6aDjj3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 17:14:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:14:31 +0000
Date: Mon, 21 Oct 2024 14:14:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev
Subject: Re: [PATCH for-next 0/2] RDMA/efa: Support QP service level
Message-ID: <20241021171430.GA61359@nvidia.com>
References: <20241015174242.3490-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015174242.3490-1-mrgolin@amazon.com>
X-ClientProxiedBy: BL1PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a60326-c525-444b-4291-08dcf1f3d3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7cpRh6f9h7HHG/V7KH6B83uirSWHq2eOLdmbIACRRfSeKrCQVnsWLdUe9tpR?=
 =?us-ascii?Q?YH/2lv+NrO+3n/oPDm+RHxG2e/1e4boMm//CGOvCxqOU17D/+NhCdRUzI7f8?=
 =?us-ascii?Q?R9y12iupTBadMeo9UkUFn7d8fnmKtsv8GY5z4YChzUhHLZjTMsvVqesonVbw?=
 =?us-ascii?Q?/w8o0T/n5657N292ANIBY7j+ImLq3S1SthZHpWZ/AWKSiLiC+9owL7KHt437?=
 =?us-ascii?Q?1NHrtiuXd1eSx/tTOrbEHlB+qkAHmvFLKdP3fP1cU3dz6/Sh6CvncskhdB21?=
 =?us-ascii?Q?jKzEP93P97kOMRLvK6vX72LzqOg6/0bv9aSocLHHrUtDzrpmzGxYry4vT7gK?=
 =?us-ascii?Q?4fdz11uMTip1Ut9lMdHS5YykMpSnZ6PJvg1cVlEKbQXsXaFsz3Z8So8DypPr?=
 =?us-ascii?Q?5mMp1OW5l9n1v41phFCQ779whXJgYYZE2AKUL/561Jw4T7Nmwr5jryAHEA3N?=
 =?us-ascii?Q?FtO9gM9ajivova/XulMi4jvU8pVIkknPt8MiAa/WCqdGGlkmJ83xMRUNpDTH?=
 =?us-ascii?Q?MvnilsS7PN1e6gynwKeuDcMLDIXdH7iEexpMTcWdVweBg1fWOy00PuvG3np2?=
 =?us-ascii?Q?mqbtcFCj3fg8vbRQeRO6kQfHrsxpjZpHd/Ift1ar4aLWE3NOyeGnixjcxp4J?=
 =?us-ascii?Q?WS2x2NUeuIBAaa8STlaf7nG4ygWMfypE89gpq35N72OrdLsvUv1Oosow+sQ9?=
 =?us-ascii?Q?qWytfszhq3xShCnyBoYVAgzT+1X5U/yaI4Q3WVfKW7uIUSFN/FDYru0U5Q8k?=
 =?us-ascii?Q?UZ0rPgClPnMYPCUpqJz+wOLm/H4HUKeYz5BHu9SkRfFgpg3WV0g0VBJfCyjO?=
 =?us-ascii?Q?BMgplk/J9hnXx0B/lA7lT39nrIel6angkj9RnL6XKpgUr77i2kRaKRHZVSQY?=
 =?us-ascii?Q?Ufb7tt9PVsdYrRJJgwuQAQmlhKV8g2rsLLwMx4y7DbIJSDzh4Nte1LryBTLG?=
 =?us-ascii?Q?M7jyG4lC8M9UlD80duBeIf/NZ3Mp4WP38yGq6nWEVj8p0c0M3Wof1tTGFBT+?=
 =?us-ascii?Q?V3fnShwfa1dfsArrN5EWM5hGdbKNQURUW1n2B/QRFIkvd08sZ1430A8HwQmh?=
 =?us-ascii?Q?DHnCkRWFwK4kT3Ty4s1yyT9aAoA8JcyBDkS0P4/1Lld6T5m1nnjIwZlHJrne?=
 =?us-ascii?Q?LW5DWD7JnDx0joaG1hCMM410/qeIXPkKGKHjpM3PJabEjx+Yue6bDEZ5VaIt?=
 =?us-ascii?Q?LZc/v5W8e/8WS1bkLIV9+dkav5yBzsYpa8CuueqG8j2UepvlEHG4kDgWXQXI?=
 =?us-ascii?Q?GT7xEW8Oouce6ZrYAtClskoeBQUzC6rry5u8gJipat/zShRgnFXQOw0t9vFg?=
 =?us-ascii?Q?+MnrTi7hqq4XMiEJyGbpCgU2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+qcBrXzCwRCG1psm3JZv4OucVEivtj+twe1y8Z9vHxvaAeCLQUbcOc6PkDG?=
 =?us-ascii?Q?OH3/HLLt7qcEs5xpL2d6R/1GknVH56CnLJt5TLg9i5/r2K/Z9WQOo8WtMdl2?=
 =?us-ascii?Q?b8GEOBY7hhi+DEDhceUZkgsPCUzcYFQpVmjRgnPvZXIFhfw1kt0yRTlLkt9d?=
 =?us-ascii?Q?Fyx8DsjvN9ZOwqSi0DKilI4jWw7YuRxjwTZYvYj1Z4AgEH0W1R2JuB+M2aW7?=
 =?us-ascii?Q?R+2/HZCzBVYlDH/FKj1KMTAqT0YzoGCwLOkIa5ULPK2hojXUTQ1dCgo8rNYy?=
 =?us-ascii?Q?vyumTv9j4WU6wKeiffFYK8G1F1aYm/Cr6tLu4o56eZ8E2xKmOhsDMPZnq8gM?=
 =?us-ascii?Q?EkBeov8/1XuMgTkylbCjxxaRhjVb8ZToCeuCsbTNjB+3OtN++KwVNjdgoOIK?=
 =?us-ascii?Q?waT+/F3XiiLTMahLwhoeEBlKMl7qaXIa5g/hGM+XYuxOvyg/8JFaLu221rV1?=
 =?us-ascii?Q?1oj9VhlL9cwfIYU5Ypa90hHXXSBZbVce3Ghf5pP1n5DZvqRQwFXVeY4LIvkK?=
 =?us-ascii?Q?AtDSCpJ2bqf+1WjUF0YA3CMJiq8/Mw7sH4kYLVxlTAvZ7D3pQMHGCZ+XstCF?=
 =?us-ascii?Q?7kQgMXF16YFl0+XTS+ku0XsdQC4Ee8Qv2i5FHtc+IK8usJJ8780KOnEyUTAO?=
 =?us-ascii?Q?4b6QjAHqEPgezkrs791sszHpv9jwHYYhjYLWrIcjFwJCv6wIh/qUTlqiBqD2?=
 =?us-ascii?Q?TbtFd6O1lQbwbXBjilGbJXlIBfM+01mswS1N3nunq09uJyzTGClxuzFir9Gg?=
 =?us-ascii?Q?ikBKedO4UeaIGfbAAWRXjp7DA/wr+g9dj/QBHFLoS8Qt1sB8M8BbJ9HPtkMs?=
 =?us-ascii?Q?jF7BYKYGvGA/Kp1ti5q0fGwMi+KeF+onwCA0cW0IFiZnvqpzPMLYWH7X8zPf?=
 =?us-ascii?Q?FAy9WW3wSMSaBcjlkcwTkDyRTS9ddl4J1ajGeuzKg5wCdZfztMaAQlvlLqPC?=
 =?us-ascii?Q?FaGIz6jRvJB860Y9XGkrhCfW3yCVBbVBJ5GTSqZK0t6diKPUNmkaJwYCI2EZ?=
 =?us-ascii?Q?mMHvRfKgHUJ3krv19/QW6egWgKAiIl4V3iHkp9ZNM5E0p4EX7QlPB8h1Fkw5?=
 =?us-ascii?Q?grRsj+rtS4nyqXbl3krMkNlbAnBy3//9l5753LCEFjYJFWU05X8y5WqN3awo?=
 =?us-ascii?Q?m4miboEDrJTD+hmaHUSq+DEUv8jfEm1BIVpqEkctVV+JQ7AvomRbCke95q6W?=
 =?us-ascii?Q?t16bm+8jZMAnX79GSOBlg34k6oZ0JA11mDKSu+XzwLFsXEHhDyHjHm0BrrFs?=
 =?us-ascii?Q?GqFHjeS6MoW7LVughs4uXakkPMnDATn4o9vAta+lkBp09bxbjKTW1m+OpeKI?=
 =?us-ascii?Q?Wd2YUrSkfk74n8Z5hPKqr/djhsuxVCQWribHL+XjxV1EL+vKKBmYwXbuWqdK?=
 =?us-ascii?Q?6HD12FleW1lJC7Mmsmhz4tmd5t58Fj/AJ3ilKf74AaRx+7IHgUaO4a/Nc8RJ?=
 =?us-ascii?Q?LJ6vBRTVyEBkwYt79Vpvovt28eo3/fmsQXsc01AjSgHgP6O4vOvbsyDmLfzN?=
 =?us-ascii?Q?NAJFmER6cOJ6wOkRLKX+FfJoc3zXKvy9oEjMfnpu+iYwRc8DJMoxQ4QTgMWF?=
 =?us-ascii?Q?MJs76yjibvU65oemSqLoscQf7WOUjiQivUj2IV6a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a60326-c525-444b-4291-08dcf1f3d3ce
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:14:31.4682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uez68TRoWpdNZXI5pDD6EVPGAiC8vu78QPgJOoPMB0P0qcqArleBH/7ch/ku+/A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935

On Tue, Oct 15, 2024 at 05:42:40PM +0000, Michael Margolin wrote:
> Align the device interface and add an option to pass QP service level
> from user to the device.
> 
> Michael Margolin (2):
>   RDMA/efa: Update device interface
>   RDMA/efa: Add option to set QP service level on create

Applied to for-next

Thanks,
Jason

