Return-Path: <linux-rdma+bounces-12812-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C20ADB2AF9D
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Aug 2025 19:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B872A22ED
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Aug 2025 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812A26E70E;
	Mon, 18 Aug 2025 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NIDwNKkR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482932773E7;
	Mon, 18 Aug 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538827; cv=fail; b=uqOX5VUS2hIxlwqhVYKEIQghGsmOHJ4e/a7WLdqJiw8pbkro7+Lc218pyt8LMG8aK4gfC5ZHu0bhIrBW/MS8S70fChEqjNwZu4O/8S48OvUcmhrbrMEIcVr1UrdNmpHsiPuNn5lV7ml7+1monLbAtp5YCB1vYzKxn2DoqlezP+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538827; c=relaxed/simple;
	bh=O6fM+Yr9JeyWDg+pNuEJtn1R9YeCmUh4apVEOq731o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q23b+LwCqQnb1MGr9mxzBKQ0zHdzXM1pShJCVX8DmMxiTGCWOgxIkl/gfAQH6uz/ewBpZnMrfKHzxXvDEwsWZ/GkPmou1kGeVpyuszmPM/2lGZ7esx9QcYHn4AEquacx8ls8hSeEBt8CG+HopLs6pCNK9gkK3QyFIkOVCLpJirM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NIDwNKkR; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+ffLh6kK9f7p6tRmdxKkfgAcJwS3jg1elKkbDeY2yy6C3Uu1A5c3p9FLN7tNcedukEgoptOrGMMlsfKP6kWNFm1sYs4i6D8umGvEDFU3dn5ZGQSurPbbiBB/T4LAl4cP01KZotdASngOJHJkrslujWDEGxXKuu5qeoXSSQIVyNnZuPo8k5JpSwmybtS9zyQxCzw8xG2K8cQzYQ64IS22OLev9bNWwSD55cDqrUe8YYcrMGtf09IVVgh72Glii0jGjBs6tCTTsk9/4EQDB2y5+hTA+5jHuZZGaKXbZlyTPXgkrVvdEBggCMfQhG7AUKtUStbKSpw225hwTY7T9QOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PJSxBLCy0mvmpTNIFi3rUp+D7UEIxGH8wW4Y7jAEAM=;
 b=boz4zkHX0j00jKy/HDS1jtxdujwpk7p/YoGzeZypzD8ucpdSJdFkYwiunN81rQQhjF+Cce6VYhsYsAjPfGiDoopUxMasE4rX3H1hvqv5V4N5ZnnoKx2vDmIwa2HD+xJu4lYIhyZn6uJ+Wrof/veY7qMCfynCzdnd1E7Lo2SOda9VrbppXFdY948vvK6iY7tKsgRkssJtn1/bO4OHRu+sic3CnMsdkRvSUI3KyUJxqeGrGU32gnLZ6umwV2z6EiODPuDa5vcdeWoTJnpD+Ny5/0riTmJL1fov3MMO160+O2Ruflin3I+yanyGy5AqKEdWNMKJZ8OzTtDe6dFCf0EDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PJSxBLCy0mvmpTNIFi3rUp+D7UEIxGH8wW4Y7jAEAM=;
 b=NIDwNKkRUdTnyCR5xUgV5/ExGu6VGg4VcyGqwpzpVkoduSgty7JSoxhfZ2lZfYzazTMkOxGL93uVTt2iW0mdIy3K9knpUbj973nc+PGWM/ADXwVkvaetOQZcN7Yxsij5zYGTqP3ioX1apzHX7Fo9EyEX8TGivsyo7GO9U+Bq5oHLaoCLa14LllwzS7LG/4ayqPXF+kOkUJHk3xFIVyqw9PiuNOdrgKpXR1RvAA+CdVoKLtrM8nWT1nKYQB68Y767oJJvNqizAL7u7vSDsQZpYv+5PFCgtx/RAuM3/Xz9Q3wbAaoNTLHNhL6G/W2SRLdLz2CQaZEHAos8mnSihP0GXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 17:40:22 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 17:40:20 +0000
Date: Mon, 18 Aug 2025 17:40:09 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mina Almasry <almasrymina@google.com>
Cc: asml.silence@gmail.com, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, cratiu@nvidia.com, 
	parav@nvidia.com, Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v3 4/7] net/mlx5e: add op for getting netdev DMA
 device
Message-ID: <jvbtvbmgqspgfc7q2bprtdtigrhdsrjqf3un2wvxnbydngyc7r@y2sgbxgqkdyi>
References: <20250815110401.2254214-2-dtatulea@nvidia.com>
 <20250815110401.2254214-6-dtatulea@nvidia.com>
 <CAHS8izO327v1ZXnpqiyBRyO1ntgycVBG9ZLGMdCv4tg_5wBWng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izO327v1ZXnpqiyBRyO1ntgycVBG9ZLGMdCv4tg_5wBWng@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9a6b88-3eea-423f-6381-08ddde7e4d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tld6UnNLbDhNbUZzTlFRSWxBV3hmUnVETy9aV0h2VW1EYmMwVExnVjNLODRH?=
 =?utf-8?B?S2tIYy9xYUhGK1dQdWtIQXBpVHNFVW50QUFyNGdnRU1tTjhTbVQ3UFIzaXhu?=
 =?utf-8?B?UkFMVmdrOWhYd08zVngzbDh0UllVcVNuSXhtbUk1QWtGZVIybEh2Zjl6aE1o?=
 =?utf-8?B?NCtxZ2JWa2Uzb09Xb1M4T3VVekFBZGllL3VKKythRHBDYnFHaDNkbmdOMDdD?=
 =?utf-8?B?RkVHWXRycWUzSm5wT3hDbVFxTTVnNnJWRkYvT0toeGo2WWRQeU9OZHF6TkZv?=
 =?utf-8?B?bTB2S1JZQmFHTkNwSVJTcmo1MFFzSVFQUCttRkZyZ2pScUJvMDR5Y2diRTho?=
 =?utf-8?B?QWVvam1QTmRPVldXTXNEejM4RmtpOUtKNktIVWNLQkh5akJUSGJDekp6c21X?=
 =?utf-8?B?Z21zTzlQU1dqb0lpVkU3R3NMYWZEU0RFVzFZTmkzUkc5bERuT1d1YzBkdTJY?=
 =?utf-8?B?U1g2MWNiTjZVZWlmRUM1Q2RhTEQ1aGRFTFR2K3REVUo0RGwrU2FEaWFpWVFJ?=
 =?utf-8?B?KzZtM1FGVW9mUmFGODR3a211dG0vOTZKVm8vbUJhVjVqVUErNXdRUjdyY2p0?=
 =?utf-8?B?dmdRWWZKL0tnR01TdnFwUUZINWlNcW5oN09obW9BNjIxRHgrZFlJSFJPdlZ0?=
 =?utf-8?B?ZWlpeXdXaytiSlZJL0pmcG9hcjNsU0R0djB1b2dIU2g1bENGNmxJSklHS1pk?=
 =?utf-8?B?TzR5a2ZPM3pGeGxsMFZmcHc1bFNQalNOTUN2NEpVQ1MvQ3NiSklZMGhvdS9M?=
 =?utf-8?B?WXVDazkvYW45c2dEQmJlL0h2MFlzL3pCdUI5WlVkSk0rRS9FWmNaanBiMTZh?=
 =?utf-8?B?S0VZbVV3QkhVNmJqRHJXWEQ5YjgvN29HM1hGREtpQ05la0hTd2xaSnR1SlRi?=
 =?utf-8?B?ckpwMEQ5aTdyRnRRWTZBcnFVYlJnNDlnYlhBREFNSWc5ZjAwK2ZzZWphclFh?=
 =?utf-8?B?NERDQWt0SVBJZ3BVK1VPYi9rcjZXYzhHWjB0cXZmVjlUMUMxcWNNZE5JaXhl?=
 =?utf-8?B?MkpkTXBKMWVPOGIvK0Yrb0x6WVVIQ0xhUWdvTGlicUx6aS8vcy9OU3ZZQ3NM?=
 =?utf-8?B?a0tYRjN4K0FGUGhWdWhLYncvUkhLSEhmSHp1M1BrT2R1WEVkZTQ0SGdsY0hv?=
 =?utf-8?B?TS8vNThKR3EzM2VIWi9TaW4zTmtEZWZSaVZ4MG9HWm4ydkxOZS9kajlJSWEy?=
 =?utf-8?B?UThwWGF6SnBTdmV2ekRYdVBSWkNDTHpSL3EwOTl5cWpsTldENVFrcHl3bFFR?=
 =?utf-8?B?amx2bzVFVVdVNlllZlJZbnc1cDVscGF2UEM0ZG5jNUFJRW83SFlsVHpuaW9Y?=
 =?utf-8?B?TGFqTGhHVFJ6YVFadnNQM2dQdVZlbEVxN3hLMHBCMWg3YUd6eVo1WVZUSG9i?=
 =?utf-8?B?TnlRUUlybUxOVk5nQU1qQWpudjRCZkpzUFd4ck54MjJyOG8yQzJKR3F5bkJX?=
 =?utf-8?B?MVlmL2NIUHpLZUYrdDI5elNPRys4ZjMvS0RmcEp1M1NuN1pRQjhxanUxcEt6?=
 =?utf-8?B?Z0lBdVZHcUpyZTdKQWVYNDJKVUY0dzVtVWJXZXlUS1Z1QkR2OThOSk9SblE0?=
 =?utf-8?B?TXEyKzNHTmNCbEJVTXdZUU5FM2hwMHVnWHdkYS9GYkNLekxnUmxubm82UktM?=
 =?utf-8?B?ZE93SlJ5UnA3aVcrb2N2RENwSlpmU1lPaVNnOTVZa0tBUEx2MWFvS0lLQ256?=
 =?utf-8?B?aHZrVHR3UWQxdEgrNTlhTHRHcitlQTljNlc2T09BMldKQ3NWVnZtNm1TODE4?=
 =?utf-8?B?YVJJTnl2bFE4QUNmeXdObFZrZklFcUMyVHZYdEVzbFcrdWVVMWN2a1Nua2hq?=
 =?utf-8?B?SHd3d1M4eURXQUcvN3JiMi9SNUtsTzJaSEZ6N0ZxMjY4ZGhXVHpYZDJnbXE3?=
 =?utf-8?B?WmZjV0tudng5UVFmUnQxdnR6Y0J4ZUpKVzhvQzZxbGZ3RkF3Q2NiZUVVd1Ax?=
 =?utf-8?Q?NwelD6GFXEE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0MyMHE1bFQ2K01ha1JrYXQzaSsxSWhiSFVNSzZBVkRlYUluWE9DMzV6UlVK?=
 =?utf-8?B?WXc1aHA5TFN3SnVDU05qdyttZ056VUNyR2c2OVNXdlVpbjdNQ2VaSDc2bGdS?=
 =?utf-8?B?RWUzZWovVVFDMkpFRjZ2MldPeWJ4MUxWcnhNT0w3TEZReEROTGpTL1VyWDMy?=
 =?utf-8?B?SW50QUNMZFMrc0d2amtja1hxdEsvK3JwMmVJcmkwNTRnb3ljLzR6dmdHTy8r?=
 =?utf-8?B?M0lSSGJpUVVPNGFTblF0UHFaYm5SaFo5R01IMmJ4bFJQbFVTcVJTMENRVEdm?=
 =?utf-8?B?ZmVRbWFuV3VsKzVjL05pTS9KV0hxaUdQOFpVak5UaXNCejhVUkdBT1hHQ1Ry?=
 =?utf-8?B?eXhuejBpMVYzZUVSL1k0UEs0WFpKUmFYdGsvUWRtQkk1N3BraHA0bFA1cUlI?=
 =?utf-8?B?aG54MFd1OXdkd0JxRXNLZVZUTlJudENEUkRxS1BITUdGd2JIb1hmeVVmalZH?=
 =?utf-8?B?aXU2QTI5ck00bEtDNWVocUFEUDVDQUNUeGk4SWVQQVQxNGNKNkJUSzNGeTZi?=
 =?utf-8?B?d3lHMTJhak1sdlZNSnEvUXFIWjI4QUFndlNXQnBCVXMranpVU2xvWi90cmpH?=
 =?utf-8?B?UVZSRUZiR0xGZEZDbmNxOWxBTU1aYlNtNkd4QVd3Qm1jY0Q0NnF5QjVFYlBn?=
 =?utf-8?B?eExpZFFpOGtESmp2T2tObHU4NGZhRU5TeWFuUTNNZ2JIWmxwZnI0c3ArNTE1?=
 =?utf-8?B?c3p3L0tlb1JjZVZLSXNIRTJ4WXFRS3kxd0ZnWkxDeTJtSkswbWlseG1GemQx?=
 =?utf-8?B?R3ZyZ3B0cUFjL3J4WVdWYm9CSFgzZHhaNkE5b0NZaXQ0SkRoUGQzUm9KbFhm?=
 =?utf-8?B?ZzRrOEJJMytJMHRyd0cyYWZHNUoxdDdpeUIwcHE4UUpRWExrWWpQdGhJQnJM?=
 =?utf-8?B?Y3BVNmdoUlBnMlIrdVpOZDcxbklJVjd3dzcwaXpkdTVMOXhKdWcwNHNTRlI5?=
 =?utf-8?B?OGR6OGdRckJkOTFpdGtsNTlKTkpOZkduWlg0RmZLMG5jbUlDcDJaTFhtMmtj?=
 =?utf-8?B?WnR3U1hQVmJlTlJKcERDeG1jbndFRkN2enBDdjJnZWRHOVdib0YxU0RoNlFS?=
 =?utf-8?B?ZE9FQlExa1I0MVdJL0JXN1RRWDByWi8rZUhDbkxXNXhCMnR1M1lDMHI5dW5T?=
 =?utf-8?B?Z3huOHp3SWVGc3krYVd6QitZSnNBdHk4enVEY3NBKzVSVnJSQWNpelVJWDV0?=
 =?utf-8?B?YUNFazJjb2hzSldOa1hpd2UwQWtOT1hsb3VseEdlT2ZTMkpjZ045YXYrR3lw?=
 =?utf-8?B?SkIwUUt3MndiSjNGK2dXa2tGcitQOHd1N2hGWU4yL3ZqMklqUkxEeGs0eTdC?=
 =?utf-8?B?dkdzV2JXTE0wdm80c0RiTTZSL3BpaWVaMTZSWmpnWnZMbUFlM3k3UU5kbEgy?=
 =?utf-8?B?eUNEc3dOZzc2WVBKS09yNkFlakNJQTh0eis4Ni9VdGU0eGM3c1JIbmtoMk4x?=
 =?utf-8?B?TzBtd0Nxb01uZHFNeFdHRzVxVjladFZCZE9vN01IRUVCUHY0Y093elpOSThT?=
 =?utf-8?B?ejE3bHJ3MEMxMkQ1M1BsYVNMaWdmQng1aWlpYXpBM0kyMWNhZm1KZjlyNTk4?=
 =?utf-8?B?U3NVQVRIWjRVdkRYZkIxK0hvNk01WUNDRGFyOTljaCtrd1VheHJzWU9HVnA4?=
 =?utf-8?B?czB4TUVTOHFnaEZvZ1JBZy9EUkZhWmJaY00rbmJVSDl1b2xzNUd0ZHN4VmJp?=
 =?utf-8?B?TzZMTGF0SGhCZXFXcjJGazAvSXRCRHFjYW14clloZlVLUkMrRFRVUnd3ZUF4?=
 =?utf-8?B?b0tiWGxjQWxkdnR4dEd3YlpkQXEweXFVOFdxK0ZDREdjSVNsbnZkUkx5Qm5G?=
 =?utf-8?B?ZmZQZXhsYlhYVEhnaE1neEtvZFJVY0Z4K1Z4aW9rcTJqeXJTSTRxNnlKTCtw?=
 =?utf-8?B?NEFWM2x6NlA0WXJkd3A1NWMwVysrbGxLcGlIMXk5S3VsTjh6bHlUS1h2elBi?=
 =?utf-8?B?UDgrdk5ZQWlGZDNJTXVqVjN0MmNGcEI3ZUdIN3duQmQzbjZmTzUxaUdGdmJD?=
 =?utf-8?B?RzNEaGg4emZKMG5xY0pDbnl5OVFsSTI5ZHpWVXFFUk93OUtoWU1IeEZxT2ps?=
 =?utf-8?B?WmtnOXl5VUJLbFdmUVVPSjZYeXVYQzFISWVDUHZoSlpScFJDc2ZJendiWTVy?=
 =?utf-8?Q?3lWUgSag4/dT4Vi+xJ2Pj0z1c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9a6b88-3eea-423f-6381-08ddde7e4d8d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 17:40:20.7472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/xE0SlYKlByoyCzWdsqsUKO3zLknsNgD6qsBn/BtzC6fpIHAXwBrk2BKV06xh7J3a/Ik11wiTVH529u0wZC3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409

On Fri, Aug 15, 2025 at 10:37:15AM -0700, Mina Almasry wrote:
> On Fri, Aug 15, 2025 at 4:07 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> > For zero-copy (devmem, io_uring), the netdev DMA device used
> > is the parent device of the net device. However that is not
> > always accurate for mlx5 devices:
> > - SFs: The parent device is an auxdev.
> > - Multi-PF netdevs: The DMA device should be determined by
> >   the queue.
> >
> > This change implements the DMA device queue API that returns the DMA
> > device appropriately for all cases.
> >
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > ---
> >  .../net/ethernet/mellanox/mlx5/core/en_main.c | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > index 21bb88c5d3dc..0e48065a46eb 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > @@ -5625,12 +5625,36 @@ static int mlx5e_queue_start(struct net_device *dev, void *newq,
> >         return 0;
> >  }
> >
> > +static struct device *mlx5e_queue_get_dma_dev(struct net_device *dev,
> > +                                             int queue_index)
> > +{
> > +       struct mlx5e_priv *priv = netdev_priv(dev);
> > +       struct mlx5e_channels *channels;
> > +       struct device *pdev = NULL;
> > +       struct mlx5e_channel *ch;
> > +
> > +       channels = &priv->channels;
> > +
> > +       mutex_lock(&priv->state_lock);
> > +
> > +       if (queue_index >= channels->num)
> > +               goto out;
> > +
> > +       ch = channels->c[queue_index];
> > +       pdev = ch->pdev;
> 
> This code assumes priv is initialized, and probably that the device is
> up/running/registered. At first I thought that was fine, but now that
> I look at the code more closely, netdev_nl_bind_rx_doit checks if the
> device is present but doesn't seem to check that the device is
> registered.
> 
> I wonder if we should have a generic check in netdev_nl_bind_rx_doit
> for NETDEV_REGISTERED, and if not, does this code handle unregistered
> netdev correctly (like netdev_priv and priv->channels are valid even
> for unregistered mlx5 devices)?
>
netdev_get_by_index_lock() returns non-NULL only when the device is in
state NETDEV_REGISTERED or NETREG_UNINITIALIZED. So I think  that this
check should suffice.

Thanks,
Dragos

