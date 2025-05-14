Return-Path: <linux-rdma+bounces-10341-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98134AB6499
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 09:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F27017F6B2
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 07:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C85820468E;
	Wed, 14 May 2025 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dc4R0nYE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BF083A14;
	Wed, 14 May 2025 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208280; cv=fail; b=GJh4ctOej8gvxWcpWOmtY3WLrgvuVYSummgnIRdy2VoG6y40fWn+0fYm/nCrzW2tHwd6c1owe5XvOg7Tci2SsomMb19vyAeblBW/tdcsdA+2b2MduNMrE93NdrMG11e61WUeH+hEx6QwZDWSeKqRcbWrG32hXLzVXd3W8XJxPIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208280; c=relaxed/simple;
	bh=wsJ80zNCaJQU2bbeNGaaACY7a9pOtnKde7g92rTlQBw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sogsuCkmIBpCbUO7t0PnqJ0h0cfm6ZSaQeQ86A3BSNXcnGdG/qZBjf+k1vzOErywSihCe0nLx67SXCn3BlcKd0MFgwx8BzfAnqNI5rWBabDqpG5rdXJPhzy4zBwPkfSH9FBlIv6DHLI4RAvckfucQc8VcrblmuOd/V0BmWnfZNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dc4R0nYE; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfPYaj8w+d/HqvtXix3jJgJyx7QexplEcGatDJsWFjRSEG9SlbEOuv7FkFGBGXiqxFqNQdVXq4VvVhBbU6lU5NOQ7JG37ey2BVmstmgEXXoezuzFMKYLgrZVhT9RWMnBTzdBnmcsLRs9Ct5AlrAQDB71QueTThBfZlr+V9DYWFCGHYdVRKyZlBDpWCOnlP7MwUx1GvJwjCg9HYYf35TcDOC9EwjKOSfPB8FkZ0k3GUgBccDHT9aJstd2X6mPsk/3dHU0DbZk0jRi7m95Hq7f6RFSFW9ljpbviYRQQ8pOduLUf+tz8RKe3CDQ7UXyJ9yb8qcZVWLzf06EXA8qmmqGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/nMEArzsSAND3KKfhdb05aIQu67lRutlsRQF8E22GM=;
 b=jy6UEfr0xGE2SMxEnkoH5RjdtPF9h75hvRJTxCc2RjdT/R1KU+FGdtAo1Z4zttv1DHJyHyn9/lklOSoAnvebp/P/WuErezk2clq3WjRPPYzADJnTW+6gCoF5aCmbPHn07wXrZdPZxWz4+2Ywq/ZZnKURUbo9FjVWa3JPUVStXdCjqpfnqqnoPgs43+lwBpCaWrmSRmyyhh9dfav/65DhR3Ep8tFV1w5cMxC4+hLmDx0kxXu93cfzKavnGDBP5BNDgSjVxyXboPR0h7Mngbae8RmQdYsGkIZ6EBOfj5ucOkD2wi3/SR1gSPunMjqhrb3z8sb7jkhzP7t8LZDHhZTn7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/nMEArzsSAND3KKfhdb05aIQu67lRutlsRQF8E22GM=;
 b=Dc4R0nYEEvYHcdHXW/ZF6VvUalB+9UQKS4IlOnoeQeKlJb1nT9y1r0D5VGV7EqOhWi01w9rR+T6H8juJ/71bkUww+/hA9uJtTx2yaJByBG+5g1DXUqlsHxgl/ZyrHJAIZ1jP/p+EaRb7aSTz5Mmoy76bkY8OE07IXMxotOpRft+cVFtYr6mwLjRtZ875ZAXue5JFLgQZAvXGkFtazGLB7CJw8x9YJp0uEdkq0f3lQdIXEdcrB0pmyC556EwqOJOns9w1WEr63E9jEYE1xKIjUIU3coZQ0th6lH+meWKj2qJVj+2f6nZgiaoMnc8bZP4Pxa6zqbYRYGfxJ6s1oBOt5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 07:37:55 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:37:55 +0000
Message-ID: <7c66f89c-69f2-45bd-821d-6a1ee579d3c8@nvidia.com>
Date: Wed, 14 May 2025 10:37:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/mlx5: Use to_delayed_work()
To: Chen Ni <nichen@iscas.ac.cn>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250514072419.2707578-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250514072419.2707578-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To IA1PR12MB7541.namprd12.prod.outlook.com
 (2603:10b6:208:42f::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a055b5-b297-4a4b-1c20-08dd92ba3d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1hzL3JhV0ZIOGFOVU44NDZhcWRobEtPT3g1VitveGhwdmdWcHhVaGdZNGxF?=
 =?utf-8?B?MDVXVzltZ05MZ29vMDRVRHRUYml1MEVZZTZVcnZHZGRDVWtWWW11dmp1YTFy?=
 =?utf-8?B?ZDl6eHc2RENnbGQyTThWQUNoYUVUbHpKaEtrNnZDRStYdmEyQW5XQTcwUGFI?=
 =?utf-8?B?R2srZ3kvZy9tdkhEWVlBWDlmQllKNjR6K0krdTkzcG1rZVYrYjNJRVJIdVpI?=
 =?utf-8?B?ak83bDFzb3FwM21nRnhxS08yU2g3N0J3VnJCWVl3WEs4ZCtNU01tcWpEWTJF?=
 =?utf-8?B?bG1KamFLdkEvOVMyeVhoWjVSOG1Fd0ZvazE3OFhUV1dWUDRhWEt5VGg4eHZj?=
 =?utf-8?B?ZC81MmVLSW1BUUZKb2h3ZTFITjV1Y0hYQ3MrWnpzaUhma000VDNiZDBJVlJV?=
 =?utf-8?B?QXVvdWhuZVZuRmhCNEQ4d1ZpcHJJT1UzK3ZyYzFQTTdHOWFhT3cyQVJ0RWdZ?=
 =?utf-8?B?SUdiUVZXWDVqcGNOeUhRYXdadFZ2ZW1sU0RMOHdBdEJxNlZ5MmxpUDU3dXY5?=
 =?utf-8?B?OWNzQVRHQWVEaVZkSGQ4Y3c5NHJGeDZZRmo4MEZkUGY5VjIzTlZJRWxLYXNQ?=
 =?utf-8?B?WXhSSTk2VmVkMVgxd1RSWUlxSy9oVTRZazk3QTlSdWcrbmhtMEhneFZra1Rr?=
 =?utf-8?B?UEloaUFLcjZlelJCM3Z3MXJIOStwVHMyckU2WE5jMUtWRVRuUkF1KzZiZi9n?=
 =?utf-8?B?R2w4UjZ1UDUwYlZsRHJRcGprRUEvdXRWNHlGVUR3REZuK0lnN1pFQzZ4Mjlp?=
 =?utf-8?B?YVo1OVFnOTFjQ1VIU2RoWjY2eU45U0piS21YdW1RK3hTaUlqZGtxVWgzd09D?=
 =?utf-8?B?M2NSeGM0dlY4eUxhb3o5cWxFUHV6VG5jMnR0OUZiWC83S0lvWHFuTUdxL1pO?=
 =?utf-8?B?bFY4UmFyVGhaL0pKT2crRmNRRVlUcWJKL0t6d1B0YU5ua3lqZTYyRW50M3ZM?=
 =?utf-8?B?eVQvZTg2K2F0NlIxaitXM1J4c3RoU2ZGK0tJem16VXU5amt2Z1pocFRuNVlS?=
 =?utf-8?B?ZE9oNmg5d2pxWkxXRVZranlEdVRQcXcrM0pxRUFDeXpkUGR6Vk5qN3FZa3Zp?=
 =?utf-8?B?QXRJRHYweDIybnh6YWFGcjM1VGloeXJQUDljcjZyTSsxek9GWW5PTHlrVk8v?=
 =?utf-8?B?bWFJdEdydm1ibnVuTGlQNkpRSlhSclBKYzNQOEtmRUJFek01Vmo1NnB1Y3ph?=
 =?utf-8?B?S1BnOHQxSEtXL3p1UFhVQmY5MlhOeFllcnBkWG9LM0dLSGJQVHFub2w0SFph?=
 =?utf-8?B?VzdLYjBWNnprU0dtbEV2UWt5bFVaVFVEcHoyRmFkNjlDYk1YTGtOVXZWYkdi?=
 =?utf-8?B?cUtQeEp3dXdBS2ZJN0phZnlmMjhKeGRsenBFb1VnUGFUZTU1Y29sUFpOUTNT?=
 =?utf-8?B?UHovcE1ra2dvSjhvQjU4a0pCdVgybStzbEJYUVlxZ1I0VkJNejRsYWlEYmF2?=
 =?utf-8?B?VHE0Y0NEN09aTVJNSlpYK2dJeXFwOWVockN6MGVIclpSSitvZkc2TnY0VjhP?=
 =?utf-8?B?K2dxaDFySllrTjQyWjNXOHEyVmxhZHVxanoyclVCenZrODNHVENyZklqeWds?=
 =?utf-8?B?dU9LbThGekhBMVVkSyt5T2JmaVNNZlRuUHJ1ME1HcGsxVlNzNXY5QW90dkpz?=
 =?utf-8?B?b0l2NWZJRk9mS2RBM2pYNnM1SmhNUktmOHlwYTlZODlpb0EvL2Z2eW5UOGcy?=
 =?utf-8?B?M0VuMGlEZEUySzVtdVBlYXgwM0hRNjN5WlJWSXlpcWJmelJMTno5QWtSTFhW?=
 =?utf-8?B?Z2NMQXFjRVdFQmROM2FHU21iUktsRzc4Y3NuOHYwN2lhSTVORHpTd0dDc2Rv?=
 =?utf-8?B?Tm4wSnBhbFlUK2JPZUJTS0lmVDNtKzgzQXR5U2U2NEFvTUIzOXpwYXBWOEk0?=
 =?utf-8?B?TzI0YjVlQ1VwVmRESXIzeURYZjJNYUFCUjNpc1BlMk00Y1h3STM5RldTNWl5?=
 =?utf-8?Q?Y29F1FCUq8w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk5Ia1NTcFY1aFFoZFlJa2RTQ1FDS01QQkpvdGVsZ2hqN2MwZTRaa0xXS0d3?=
 =?utf-8?B?YkVFM0YwazRuaTRSSUJ5L1RtQThDdU9oc3dGSVE4eWhZZS9zdkJPa1FCaHN4?=
 =?utf-8?B?MlRuTFBRd2xJS0d4WTM4VzYvdU04NVR4eDdIMUJTSENwd0oyN2lOTG5CbEZl?=
 =?utf-8?B?ZDRLbk1zK3l3Zm0zUWo5Y2VpME1pcnBaRVpWVktNaGRNNUh5OE41NDhPU0Y5?=
 =?utf-8?B?c0JVRTk1M3l6VEE0S25Bc3VGR3RsOE9wOTFIbUd2UGFyckFJOXMxZGM0dHox?=
 =?utf-8?B?YXQvM1NJd2NURnMxdFhScWdWVEJGZ0QzR3V3dGE2NXpHYzZaRUtNUThHZnNm?=
 =?utf-8?B?RlgzSDVsTUkzaXRoL0lqU29uY2hzbmRKTktOSTEwYjhrMG5ydlJTbUhqZnVr?=
 =?utf-8?B?YnVYYzdnV1o0S3JkdUJtQTlJb1BONjIrSFZtNC9BTzd0NFVqNURxNFFJSUM0?=
 =?utf-8?B?VUNwM0pLcDhmdm5WWGtWMG9MbE5nZVpwNk0zdnkyU3VsWmlvd3ozUEZHUkho?=
 =?utf-8?B?K0pBUFpiRVE3Mi8yVWpXVnNNQXQyZDZCaTdOcjRaanB1U1Z1d3BzS21sLzY0?=
 =?utf-8?B?K2xLcEtBUXVaLzZ1a3pMZlZFR2cwNFEzM2dmbXk2Ynp4bW44U1p2Y29IMUZ0?=
 =?utf-8?B?c1lZTDJjYTNiTFZ0OWdEeVZXeFRIVFhHclNqTDRzK3I4RXhNSVk0YnNCWUVY?=
 =?utf-8?B?eXhWeWVPaXVwNDJpQjdQRHVOQk0wWFBEaWg4dWpDWldsbzlmQ2tNYmg0ckQr?=
 =?utf-8?B?bk9hRjFhYVR0WVdNMEhjcW5qVFBjQXJaN2NBRDNYZFd6aFN1dWFkQXhFcDFm?=
 =?utf-8?B?YU4wMkd5MzhYOVdVUEp3ZTJJazdFOTlFNGhnTmNLRWg3WEZ6S0tTdjNKZ3hs?=
 =?utf-8?B?aTFWVkYzOFh4Yzl6WmtZa3o0RDhOUHhzRis1NmY2b3J6UE1FTUNBYXBBWUwv?=
 =?utf-8?B?dTVabEdiOFpMVUNPRnJma21OSWtsdGtkMzYxUzRCelZBdXpqQjdaclZIeC93?=
 =?utf-8?B?T09MaDFEUFlhdGx6NWhtbUF2M3hqc3VyZVFIdXZHSHpzWnBtcFZuWlFRU1Nk?=
 =?utf-8?B?c1pPWEgzdEM2T1hQY2V4Um56UEEwWHk4T1lray90dC9XampRUVlVc2tzVytO?=
 =?utf-8?B?d0VvRHZtVHVWMEpQZzdwdjFiMVByc004T1lqVFQ4T2h6M2liK3c0aXdhNy83?=
 =?utf-8?B?REk5TGNEWVVWanV1d0tiQTludEFjUFJNQUxVdWNzdHd1YXJyZGpmd3pTT0I2?=
 =?utf-8?B?OTVsbmFlaDFUcStLTWFSL0pIUzIwV2R1WWZvd3VGcWY4Z05iWkpsZTJhV00w?=
 =?utf-8?B?K3A3Y2ExWDJCR2Nhc0hTZFhacGozNnRaLzJqdS9SQkY2bTJkOXh0ZzFKRk9x?=
 =?utf-8?B?K2V0c0tzQ2huZGRYc1RVZGlmTHRmazFKd3FMVXpEN1ROb1RZdWlLZVJSNTdP?=
 =?utf-8?B?VTY1bGZ6SjdtWnpRQlZKWW1qbUpsV2o4cFd6UXJHY1RKcDhBUXZBbkV2ZExh?=
 =?utf-8?B?QnowN210VWpucFh6b2J5RFJ1bGsycGFQNTREdE96ZXc4QVRYWVdlQ2hmempT?=
 =?utf-8?B?TThGSzlTMHBncEpZQktEbHJST3VvK3piSHlzVGxYR3dOZG9KbldpUk1TMHpn?=
 =?utf-8?B?QjA2U2t6L2FPVkg0S09hUnZzZmhxUlN5SmptT01lYmNPMXBOU0NBL2VCYUVo?=
 =?utf-8?B?cFVRMGp5azdJUjJRaW9HZWEwMWQyWWRsQWkvN29sT3NZemVuVVhGS1VFczh5?=
 =?utf-8?B?YmNXLzhOdWxyVUJ2bXFRU3dheHBaS3F1dENpRGY4MkpVVDZoNmFjdjZ2VnE1?=
 =?utf-8?B?aHBuYWRiMjFPL3N0Q0lQS3pMNEZTUi9YQjMxWXFzMytCOEpNMC80Z25WdktC?=
 =?utf-8?B?Ykk1MEhHNmpMSWJ3eXQxVnBBTklJSGNMYzhQR3YxdU5NRHk2OThLSEwxcGcy?=
 =?utf-8?B?M1ZYWDFDLzdNc0VQUFl1VHRUSzVYR1FYMGJqK0N1dk9pQXMvelZOcTBvSDF3?=
 =?utf-8?B?ZFR1amV5UFVhWXJnMEpLdUFEbFdPYWNVK0dlOWoxMnZlT0R5OGxkUG9NNHI0?=
 =?utf-8?B?SmZIbE1RZ3JHNEZmZ0hwMUVjcFBLSDA0L3RSVnB4bzRyS2ZkVk5OZG9PekFC?=
 =?utf-8?Q?w9wmhdTk6s3unKlgcVx67Pr2l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a055b5-b297-4a4b-1c20-08dd92ba3d32
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 07:37:55.0498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7d53CPi3TuAzRNHbGP/QOj6iYl1cAz8lZLWN+Koi3gVzsId5BwQb3GVuSchXebiUxZ8cqHsWcu+smXlfF4b8nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058



On 14/05/2025 10:24, Chen Ni wrote:
> Use to_delayed_work() instead of open-coding it.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Specify the target tree.
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> index e53dbdc0a7a1..b1aeea7c4a91 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> @@ -927,8 +927,7 @@ static void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool force
>  
>  static void cb_timeout_handler(struct work_struct *work)
>  {
> -	struct delayed_work *dwork = container_of(work, struct delayed_work,
> -						  work);
> +	struct delayed_work *dwork = to_delayed_work(work);
>  	struct mlx5_cmd_work_ent *ent = container_of(dwork,
>  						     struct mlx5_cmd_work_ent,
>  						     cb_timeout_work);

Acked-by: Mark Bloch <mbloch@nvidia.com>

