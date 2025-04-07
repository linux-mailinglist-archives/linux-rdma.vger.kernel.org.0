Return-Path: <linux-rdma+bounces-9202-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AC8A7E95F
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682AA3AB6F7
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB5A201270;
	Mon,  7 Apr 2025 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M2hGFULZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCE921ABA3;
	Mon,  7 Apr 2025 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049207; cv=fail; b=CPvqqxfyYQNXUPfkwNwxE+y6UHGy7AwaaSmhnIgqFV+jALvNfxLk6dxEvNT3CoiiX4DuSFa+r96bZmVa4fGPutHkFpakL0OJMlIFHDJeBfPvA2Xhd/90yzguYlWSAQ53mmW6tSo+Z4zhLaQ1G2N9zFfIhYW6sKBeMDJbxqmZ8m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049207; c=relaxed/simple;
	bh=tgZW5xof6KZj/guGB8xK5XoEzMJcGFnWQKCq3KHXUcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mCxtuSqNfLr5DeeyPe04Js/KOKmhWObF8uOEm++lDe2V8KNGw5miwCEtFgBWPVIIfHTZiDPJbUE4SFnpWKN12DIJN2CvQDBi8xcVJKYfsgi2X1OMA7vZb2ud5csGFwIMavUhVMCobVMaIEsms8SQ1TwyMwpaThMDcPVP6CTkz2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M2hGFULZ; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpB2I6NZHbp7N3jb9A6rxmZzrrt200bEeiWMfmWVOXWnypYHaoYqAIhg45+aI7cAh0MXNJQ5Ptr3TSCsl2nkKiP8+yMDMLoK8klbnHGyRdVHBnq4zM+hCzpHKfGggwynncTfeaA/Qi1WLn0h0zCS4zSSoZX2hgqsWxUpHQYOF8YNgJ7rSt4HlPazc48H7sF0SOvv+2EKibgJS7+82iOMsHfqhGosAERYi05GLpIYkow6QEkkou8779UUoKJUCiMHvZu1xwXNasW0JAv+7d1tvLgb/mBBsAksy12t80tEgqjt/KmtnLwAC4e8XWbQ7JA7R9PTgL49SuBZUz/udI3lnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bv/VSvO0A/uHmy+f8cQ1LyV1x003bRiS4HcyM31PzqI=;
 b=nIeznmJV3aGPWMke8TqVlrZaqVJmbFh5Ww6CAmW9DglYS7P1lmdVMhPyJaESzd0YQx+cBzhTeXpgswMWvyf3nwOrQBu7pzbW1Fp4bJGTtEtZHZBLzIGGQ/lXApVOLgRhyoPcA0VFvvdgZDjfLQhMldkQUgIx0R+/TE3tHZKU70vqU34TQLbVHJsRomOf/Cru0eDyWl74yrr5+mbuciMm9pshsM2Jqxd7jaBNnBjIrApIU7mhecXLaBTvIJhdU5t1gHnSozIrl712AkTNT+/3kzmCtLX0YPjWgpczN2eE/aJj8TP1rv36QPQf7BEKd05TDku+89aNAUPXqd+RPpo6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv/VSvO0A/uHmy+f8cQ1LyV1x003bRiS4HcyM31PzqI=;
 b=M2hGFULZcKvPqxFoc728Nm1qh5MD6sLFnzZGNcjy0t1fImYhL5ZN9+0PDriYXCNpbYMOLMf3tA7eyrgBddAwx/2dE8zI1SGm5c5E0RV0IhcUrbslwplVoSdhOgXd7i++bTd0Ct8RAC4MCleeQh7H43sXo9fzzvnAWAR6b4Lyt1QXU7hlNV7vCNp0jj73Od7nWOQQR5tNIOn8Utb0osY6aa+3kZ75gF9r6PZg8BL3lREDMmXYfjrplYQO7Yub09UWPbmCgGSPdRalMUybWAQAZ5rVCFblUA5e3ctZ4SychUmYrKpwoxESadNbQDP7N3i720gSDVd5xX6N54QnWXtOqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 18:06:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 18:06:39 +0000
Date: Mon, 7 Apr 2025 15:06:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] RDMA/mlx5: convert timeouts to secs_to_jiffies()
Message-ID: <20250407180638.GA1759834@nvidia.com>
References: <20250219-rdma-secs-to-jiffies-v1-0-b506746561a9@linux.microsoft.com>
 <20250219-rdma-secs-to-jiffies-v1-2-b506746561a9@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-rdma-secs-to-jiffies-v1-2-b506746561a9@linux.microsoft.com>
X-ClientProxiedBy: BN9PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:408:fd::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7a98d3-eabc-4573-d8ee-08dd75fef1de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ssLW02WCgfIKDe3XQjJGebOl5okdeYH44lKsNKVNFJaKr6dHPHWgtckE+npb?=
 =?us-ascii?Q?1ULCOJmgEfFejcx9we+7Lc5Sv79rqsecmZK+kIg300USARLaVbvE2IW0Zi65?=
 =?us-ascii?Q?d+chlcqrIimao9PiUE8Ka1e39NHV/P8NU4XLexhlf+UlMlFrw0cwu6e9gujb?=
 =?us-ascii?Q?c63mrFkAQavitf/9qYGTNvjDJnu6VOI74k8sMv37qm2RCyZDD1UneAel21qa?=
 =?us-ascii?Q?JDff9WtP42UJX3D4JLhBkA8HP0jf/ZWlDZBAALeIdVW7BhEwFTlpBXHKoPwC?=
 =?us-ascii?Q?a2auoGwv7Yn4WxRCvCm8SLzvje8X0a7cUBHBXhEvyAF7Lw7+2Ses3MIIIL7w?=
 =?us-ascii?Q?HorqQsSkVNGw7CtULw4O1QGKcK8N7UU13yfkYkU4zsINwJleXzHXMMA+ux4b?=
 =?us-ascii?Q?6yrjZ2vXkcURiLVMtJzEAAB0jhOPXIjjKkrxDhNKcDGumGecKp/yhcCNMz5I?=
 =?us-ascii?Q?yW1M2aa+X5zRNeZ3R0UFSDoES0y0b8VsUim5Hrxx+GbjSI3AnJA4Ej3nGIh5?=
 =?us-ascii?Q?uBMHxkR2pxGlZPPA0dDLxQVvLZkNsPOgPf34MzRjwofgzfwXH10WuItt8Yho?=
 =?us-ascii?Q?n/UG0LTIs0byYXzPaIZH5Qw2R5FZhITPpCdObbULYRG4cQgCxdwEI1Yq/j+S?=
 =?us-ascii?Q?t6KC9cRcUUEHVUq6XoEmF3R62tfq9HHS6wG2fUI/rl0L7KEBXqWylCZQ9Og4?=
 =?us-ascii?Q?ww/lU0+ruLT//nM5/MxoT0J7A3C8/4sMYUnDzGghj0nwlZXjwhs7U4P1x0LV?=
 =?us-ascii?Q?665Rej3hDp+bU99IxedoNiHVAs4c2tCcoA+uV+AKqLEqAobkLPicl2UhiwtJ?=
 =?us-ascii?Q?QMNwEMADsYjZ+bOWvK/x+FM1BgIcKzkc509wp5+ZOtWrZu2iQBPFBpaAhuHC?=
 =?us-ascii?Q?tUL0SQM+fEUGJxlRoZ886biysU+fBoKjTPaBg7Fi6JpUOYcTLI26bBTzjOGT?=
 =?us-ascii?Q?A1XiqoZWB4seXuftee79kKXISFAkO+024Ojc0iA6HqpLi34LAtoec6XzHXiC?=
 =?us-ascii?Q?c1ZfRuXvrqXHOMApgCH+PupDPiVYsPDrYewLB3wzFQl1cXkLAZu5eIYxSX8C?=
 =?us-ascii?Q?CQs7RuOxliG+XLXIrRDn7tnxYdxaCjFdutXPfRGQRtRyDKkcShR3dKQq1Rus?=
 =?us-ascii?Q?G4icuqrErY/LMTTQK3NpYkYn5fxP1dpfiBgGyo6NVKy1VfDLjxX3BrvtN/rr?=
 =?us-ascii?Q?+1oL8P1bk0fr7rnqamYRM1Zl3XI3rXYj6E+ksTZP8CMPYS+E6IbTM1I6v0E8?=
 =?us-ascii?Q?WJfkY0iR950yGu8DmZ/EPcmNG2o3OQtsi+3ULe1OhZgqCwsYOruPBIy1FUwp?=
 =?us-ascii?Q?/Nf8nQ4w2HzW36dZicg0HqQ0En1LQYQpb6aXOmACgPFgSlESsUHT/tWV/tKc?=
 =?us-ascii?Q?dESP5yJ1RBhd9pRATzxBu8gfitto?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mpoh7q4JRAgqrxDVbeS3OLDwtE7Rd1q5V6dEoIlbDGP6drblgJ7sSEKcJ0qc?=
 =?us-ascii?Q?hTZVm5Q073gB6ihFyWZ6DJWMp+cPVAAVbnKCFx7hfsGOMCtfPUq2vr7jRt3m?=
 =?us-ascii?Q?kBaBQsEjcxEMbRyY3yLYhL6NTGnh01qYDe/PEpA8+xCGnL59rHhBQAo+ITTR?=
 =?us-ascii?Q?zscLX8BkhbiG66XcO7oiSySV+uv+w8Mq9X5rSKdYjht6N7M/Dfi/Uw7jAV2s?=
 =?us-ascii?Q?xASWjiRnULQLw5qF0ASWo+4iJ4MSj5WIV8Cg2VCTa/nn6kwR6U0IkcvLm0DP?=
 =?us-ascii?Q?kL7pz+9sneIgqlR7oSBmBIsS0EV/5VzPw8Nqc9pR280Xxz8PSRNBifs+4KbD?=
 =?us-ascii?Q?dUhZoHTz2wS0ah7okD86IknwrH1h1xweI/+Q6LVjmtomKcw+R2VFf62G8p3I?=
 =?us-ascii?Q?CGu7YDCcyD15mZi5iQ1gzLwWnn5Uf7QEitKxuL7t81pSfqFaTxF9sPkRvHit?=
 =?us-ascii?Q?vl67gWpNfr+wQHjpJhXHYIozNoRVpyEw167U18/L9extTfFTdI7eM4SKQm4C?=
 =?us-ascii?Q?C0hLCJLWOAa5kJIjmcRK9EBvfpTeEPNDlJEfqjlz/QdD66XwaQLW46wBEOKa?=
 =?us-ascii?Q?umQe9ivuQLXnZlEk9guV8JuQEdvqA2UCnRsrxnf/J4VWvabR2PeZ5LZfMYh5?=
 =?us-ascii?Q?i3OPZElQ6UfxtKJ0mJOGU2v/qwWOifGy5jFo5zY3uMX/64Td/s2ZGVl8RErf?=
 =?us-ascii?Q?fwGJbLGz0eYiyJp7cqLw8PGHF9ydsQL/CsD7wi/7fPE84j32Q9OO8JWaj9Qc?=
 =?us-ascii?Q?691k3TLDSyejogMSYAzYdrRNvl42e0lZmRJwy/5pFnJbkPtbf4ZJNwPMB+YP?=
 =?us-ascii?Q?noHcANkzKBwQ1QRC/XYjBzCzrmUdp+Z7OxrpGMQtc1QCTh6YiifhvsPLem1u?=
 =?us-ascii?Q?xizaQ48cYKhVZxojoZ5n7uEU2rlzSazNNxRsXBY+jhu3VZcQVSyLXhRlmSQI?=
 =?us-ascii?Q?0fDC7075SxkbRSqqIME4R5o+rOnq/C3ePAfEG5V7FLZNzE4FsOwWG1BxmM9L?=
 =?us-ascii?Q?vLg89hPC4vddgSo7ZUDni3S1M/2ijTngW26ujQ2KDqcD6wCeFF5PlT266O8E?=
 =?us-ascii?Q?eEnjxIBcaV/kQJs9nRbh5jTluOyZhfiUTwAGbE2wBAHpHrjer5DLCOSm8OU/?=
 =?us-ascii?Q?Jftxmn0iuHCoUEyLELwQndVS7za321d2cFrUwnFU2jM6hWnjxHKUpcEvEhF/?=
 =?us-ascii?Q?0g2TPDgOqWUSZbAl+edVwtopbivIX1V8Atu36MmHG0xBMsTHHB/s1oraE4rp?=
 =?us-ascii?Q?awy/Rd9P0UsZFqre+rfXYmbfRSJzf5VQJHjyoWf8MX3Hu40XSBOCdVyoM/A2?=
 =?us-ascii?Q?w6Ti8y3C84usG9n9hWyXcPUOXXxQ7PYxKCX9EsFDN/D41l9d2fwSxZbRVKTX?=
 =?us-ascii?Q?nBklP7wnlWT+2iNOd7Dh+XTBGdB/NGGfnnEZ/hqCHixm3Y37Pc0610wgOXl8?=
 =?us-ascii?Q?U4n1JkjGF7tffsm0on39G64agJgkO8qMuG8bUl7q0Jbl9KGG8sO+ZLGkhRyP?=
 =?us-ascii?Q?eV7ByQC58MUsELMEoU0A01TX1Z1hqBWayJmb4HYLWfD+5VE/gcVrN8TK6uvF?=
 =?us-ascii?Q?1nqwDZMaUAnrYz+yabr4/h+IoF8aTw6lW0G5I/1c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7a98d3-eabc-4573-d8ee-08dd75fef1de
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 18:06:39.9296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCOPaS1k0smy5SxQquTXQ81p7MVg9ej8dDAkeWhg8FA3tNJqKxX+Cx2tTSCQAMpQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

On Wed, Feb 19, 2025 at 09:36:40PM +0000, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@
> expression E;
> @@
> 
> -msecs_to_jiffies(E * 1000)
> +secs_to_jiffies(E)
> 
> -msecs_to_jiffies(E * MSEC_PER_SEC)
> +secs_to_jiffies(E)
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied just this patch, Ye's version of mlx4 is more complete.

Thanks
Jason

