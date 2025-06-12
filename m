Return-Path: <linux-rdma+bounces-11237-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD128AD6913
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 09:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915D917E5A3
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 07:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B5E1EC01D;
	Thu, 12 Jun 2025 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KfiYdDv2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F058313C8E8;
	Thu, 12 Jun 2025 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713517; cv=fail; b=XvnoENH40UQogmklO5uTcXxo87oYfj4mxH2zkXA8dDzHN2ooh1ELoFkeHOPoT/9R+AJw5Rl3JGCBj1P7Flry0W+ciJhbq8J4b60/wEk3/74X53U24QGkeQw2udyj9ML9QGMJZ9dsPmEVYsv+sByLll9E56Y/uJ58jsWKaAsBNB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713517; c=relaxed/simple;
	bh=pehGVtMw6G2AejUQB66A/Q+33i+C6JCnAcPkYBQAjb4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lgCWCw+Elbr18DIMVkPmNw28E2Qsx82O2aKSfpRidtfmWRXkhW7Pn363fizaogCVGU8y+q3Y3z1aUxvpy5ryJem0kWadQAvxG5wkz4PcDr61E4uhEnhN2EsZKD2/L8jOK8Y4lASswTCTEAqfKd5t5VUkUXBueOdeL2xFAhGAs0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KfiYdDv2; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFG/P9IAF5/xFJLwx5LnUnfFp3uYFQW4Pd4dvSaIrWmfT+YGvKHGlG5+EoUfrKJvYdrTh1xoVMZMkpQSCAXFL/XjkwnbUGz5CQAzLOjfWKgGsqbElaQOldXUey6ckPMKwiaI/g7OVCxABEkq+z0o7h3nk/9r2424kIIME8K35C2HH2Y4Y/AscOM/SyYqc9NtyR2OkbC11+7xASjdnmbtt0ab/3To0WGOIfhophZXF7alyxf5dXxFAe8IWRY2NMszxa3N83MmKxnpIu5cnURPlcG7piKFlemXSnc+TiXu03pV2izjWZxmd9xLQY1BvPZR5OVw6VRiaqQb5ondRWsYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9xbWkq1+fwwF9FZO2QT1LnOqvFoWX2e5NYIVQX+NRk=;
 b=v+PrAKXkHatZ7ZaStF5t1OJlfAwPb2b67QtiGBpu+25abgST06HF6Q4wgM3xx54hieNalJfVbPNR9VgesfQGKO13eJSd+zyZxyBWT46xlE0mlzfNfKtSktf6vYLF9H6My4Sdgv8NoL2ePBDf3ZcQXugdYIYLNteSsJhBrAH2BD5i+alpqPu9Avo2i3/sdECv59KoDnnxh4z1NQP1ErtvaECSGvJB9znfhZCweIOIVeugwlCqnTrpxXntfaPYKoGKqopbK3Q3VAhasOa8/8IOQVdYQfN5Ckyc5t/ciCy8BXqN+5gv+nguhzzO9W228PRVasBa5QONrYNXVfGk01QvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9xbWkq1+fwwF9FZO2QT1LnOqvFoWX2e5NYIVQX+NRk=;
 b=KfiYdDv2Fb1Blzax3nhqyZY4vP7LwRG4jQAg7+uK8Qffz4UI3KI77zhs8LS7umejY+ZNpVdQrnbQci8Q7p6bX6PCp9EGsUTCDUqmA5zO7xX7Pl8BGcqQK5cSZ/vwav5GLAC0IAnL/ggFN5i+Iola6R7wS4KdUZYwNQOK7oDz+eImEuWM1xBDnswuUX7fH/pRCKJ84ww0JTnku8qFi4+qvE3ucDsCikhzzhq7nkIBPKscrBLgHmvcl8AgfAvAJVyb5cmaSNSe9ZoJlrBo0CNU4HxvtcgAlYy0jDTqm1eBU2yEE26q2bogHMA+nctaQiMMBy0iHWpbCbY+v38EHkspmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Thu, 12 Jun
 2025 07:31:51 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%3]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 07:31:50 +0000
Message-ID: <bdfe62f4-8b70-4284-b06d-e50ea6ae2d88@nvidia.com>
Date: Thu, 12 Jun 2025 10:31:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 7/9] net/mlx5e: Properly access RCU protected
 qdisc_sleeping variable
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, saeedm@nvidia.com, gal@nvidia.com,
 leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250610151514.1094735-1-mbloch@nvidia.com>
 <20250610151514.1094735-8-mbloch@nvidia.com>
 <20250611144013.300c79ea@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250611144013.300c79ea@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc3700c-8d30-4e3a-d842-08dda9833205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2xrdmMxSjd6MERwK2tkTDVseVNJZG1xeEgzZGVRQitBeTluQXkzUEt4Z0ZJ?=
 =?utf-8?B?aExWQlV0TlRKS08rQldubzZlc1N6TXA4L2pHMDhSeG40WWprMnFJTTRWVXVT?=
 =?utf-8?B?ZmhkUVJvRmtYVnBzMUYvcGJPMFFpS0JvTjdaamZaSG5DRlcyNThPNHo2YlNk?=
 =?utf-8?B?MWVNa2VLbUtxSWFIRHdkWFVyTWhGNWlQQ2pSTUlYYzNMbXlPbHB1YWNuWWx6?=
 =?utf-8?B?b1J5ZTZlNGpmRWtlZE1NTWxtN2lPNWNaOEhMaFFqZTRlUmZqaUc4UjVxb0JH?=
 =?utf-8?B?aTVZd1pTQ1hqVXUwenVXeHFqZXA1VCtWY0Q1ZHFrTW5Dck50RC83ZWxyakts?=
 =?utf-8?B?cG9IR0daYU5ieS8xem00VkJpWXZabHcwNGhGMGw2Tkl4c0tVOXJaRXBoNnJ4?=
 =?utf-8?B?UWtVckc4U1AvZXRYRmRzMVM5b1pzeUowUVZCblc2d2Z5RlhTYi9KSXVSNlox?=
 =?utf-8?B?aGQxVUJJeGhZM1RwQnRkTVhLTndIbXpyQ0FqSnB0VEhJbVdTMFdtdVJlNmdp?=
 =?utf-8?B?c01ZQ3kzSzVwdEhLOUV3NWNjRHhocTBxdGxKVU5LUmU3aEpPZjR3OUNmckVN?=
 =?utf-8?B?M1YvK0cvWlRqRnRYRlVkdkUwcDB3YTNTTEFYK2ZYbFhtRHJhbXZUMGRmUEZX?=
 =?utf-8?B?SVIvSFVvTnA1MzVVV3h5c3MzUWZzSE1QQWluWkpvVk9qemNNTnd6MG5UeGJu?=
 =?utf-8?B?VDhyVjJQampYZEYyc2E4Sm50YlJCSXJJQmplWWFKZEg0L043cFJwZEhpUVRB?=
 =?utf-8?B?THk3d3VnQ0tUZE53ZXduWE0rSzIvZVJWdmFKTVdQR2I0VEdac1A5NmFjaS9F?=
 =?utf-8?B?VzEvMUtMWXFKdC9HeUZBOHo4bzdxb3ExSTF4K210TGJVL1Mvb3hEeHYxQzlX?=
 =?utf-8?B?R2l1SHdLSFV4enl0YnBLY2tzNE4xcFJDM1JIcG9LQ05OWElDaFBTZjdBY0ZF?=
 =?utf-8?B?SzJvWTVJT0NWZzBhMmNiR2w3R2JndUkyWEpkZkw1bUdrdWdMUlh4eXZRVGNI?=
 =?utf-8?B?bG1nTUhsVWVNWEdBMHZ6cVZQSVpKMENkNk9SUkNXVElrVnNLa2Z4NVpjK1NQ?=
 =?utf-8?B?amJKODZCMkFvUk5WU1FCUFhheTVJSTAxS1QzSkxjQkJIbCt5UThib2NGQTFq?=
 =?utf-8?B?WTVvTlhYYmo1OE4xcGFxU1ZkS21CKzRqeTZFcEIzNURxb3NzOEs4dHM3M2hr?=
 =?utf-8?B?VUJFZk1FZ3p6Z2RzZVNFZnV0aVF5ZlJSYURVc2lPVFhtazk2MG1QRXVjdXl5?=
 =?utf-8?B?eEE4K0dqWU50cjgrUHNuOVc0d2MvblA3bStKVFhaWitsWU04SkF2cTJkRjd4?=
 =?utf-8?B?RXFSVzlBMG13a3FudlZia0Nia2w4R3h2N1JnM2grcEg1VjNVcENQdjl4MjlS?=
 =?utf-8?B?UlRaSHlOWmxOQnhuMGFyUmkyZmh0b1pXTVFzVVBINEM5cEdTUWE5eGdhN3Rm?=
 =?utf-8?B?dFY5SCtlRktCVlliZFBIdUszZ3Z5N2tUNm9BRUhacUtpUllvdzhRa2F4ckFB?=
 =?utf-8?B?cGc4RnRETDlGZWlxVzEyaDU2djUxMjVCT0xaamUxYURMK2s5ck12STRnTjAx?=
 =?utf-8?B?NlJTZXNXSVpKSG81KzZDWWsweHVMZlYxd08wWllVQlEwNCtjRTJqVUN0blhZ?=
 =?utf-8?B?WUZwVzRiVi9ybC9qWEtLU0xvazNEN2FSU20wYTY4RGZxV1R3Y3o3dFY0RmtH?=
 =?utf-8?B?cFdCcmVMZVNVdjZjVm5LQVdZc0FROExINUpQa1BOV2VSbXA1eXlPNSt1THF5?=
 =?utf-8?B?NURpVVdyVnc5cDlJaVAwRm9qREJ4dXFIWWR1R052SGgxb3JtUXNtYkk5Sy9K?=
 =?utf-8?B?YmdGRVk4Y2NmOUZUUENTK3dzQitrc3hVcUxNdk9DSVoyekNqWndRZVU2OGNU?=
 =?utf-8?B?VG1JaDZ3bjRIMFkrRTlEQ25DZTM1YVNHVVYrZlZGbjNSZnE0c0l1aDhKUG5M?=
 =?utf-8?Q?DNdiNJGCN44=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGJ5WlJzT25JdEFqd25GOHM5Y2RhN05kWU5wTm02cnJVRkhoOTNJV0pSNHla?=
 =?utf-8?B?V2VValZqemxWZ3doRzI2Z1ZHY0twY3hNZnFjdlJaRVB5NWI3OENkK0wzY0pH?=
 =?utf-8?B?amtDQ2VBVUZXYVpWRnNxNWxOemJwUzFQRk5ybmtEOW8vWFNIZFVtUWJaZjhQ?=
 =?utf-8?B?MkQ1NGpFUkcrUUhZaEErYlRIeHVUSzZYQmNQMnMyQnZuamRCNkcweWFnakY1?=
 =?utf-8?B?dzJhSGZucUZwOXFxMGpucTZXbkhMYXRXY0JpM0RGSkQyajBLY2IxaytuR0pT?=
 =?utf-8?B?c3krdkNJdXh1NzZhMWNybHdVZnp4Ry9zR3kvMU01VkhKYkhyOGtadEJEV0Mw?=
 =?utf-8?B?cVo2SENzVXdsZVIrVVZXblBiZUdzdUovd1BEeHZBalJMK1VKWjNmZm5pR3M3?=
 =?utf-8?B?cUVrU2ZlbTQ1TDIyd3RWTk02WnlTK3kyS052b0ZuL0lNSTg0VlNuVTg5ZWY1?=
 =?utf-8?B?SXFCVUFrNzZ6UXZyaEcwaWJEV2JUbGZweE1qV0tKOUFLM3QzSzVmeTZoaUo1?=
 =?utf-8?B?aTNyRlBhWmxrbFpiaCtnVy9oRTF1ZmxaejRQR1RRUDIvVUJvK0VmN3pMRlFx?=
 =?utf-8?B?WkJhdHBiRGZPem13M0labkh1SVBWMkhSM3d3QkdLVm5CYXdGT05nTDFSdUN4?=
 =?utf-8?B?aWRYdkcrK0ptZWFnTEtVNGFIY0V3amI5RnROcTk2Z3p2QVNZM2Q5NDVOclZv?=
 =?utf-8?B?dm5tc0lkTWx6bFZ2SllPWVZLR0M5SmlmUGczMk01T003K3BvOXhKUGc5YWpI?=
 =?utf-8?B?VDJtZ0NGeGdIQW15UjVLWjl0eXEwZ3NuNFpxbVQ3VXRxeGgwa081MWMvd3Z5?=
 =?utf-8?B?YzUzLzZWZFYzWG1walNYOGh2aDJHYVhHRUptRW44alQxMkN2SkNjWkdDeVNi?=
 =?utf-8?B?WmxtVG1RVk9VaDJSdTA0S0dHbFZLL3JjbDBJVmdNR3hPV0xGRExpNlp3NDU5?=
 =?utf-8?B?NHpKMVUzK21sdVJyb2NlY29mRmFGL0E3enpUTE1iZXBUbUpJeWwzSEdocEY1?=
 =?utf-8?B?T3NiU0ZLU0JrS04vWXpWZXhlMThQdlJYdWxFY0xDNEVRcythVmhtYWpZTFFE?=
 =?utf-8?B?WEJubGw1d1VsdVpmM2J2bTZ2dVJIUnVZN3BzT0ZITndqWWd0WGhPdlFhZmVF?=
 =?utf-8?B?S1IzdiszRXp4WlRGdmFlWGpQVStlNTcyUlVVTXJKQUN1SCt0VEdYemlRTmNz?=
 =?utf-8?B?c3Jrc1Q2eXpsZlgzcFlNZkttWHlIbS9HS0twS21mZGxwOXNJQVB1cWFIay9k?=
 =?utf-8?B?SEN6ZWR6Q1ZTNXhhMHpRaDc0K3ZYajlMSjZrU0ZhWTVTL1FPcmNoTm1Obi80?=
 =?utf-8?B?K2w1d29tRkdTNmRwaWdqUXowc3ZKV0k5VHJpdVU3Vk1rTlFweHF0UGZHeURq?=
 =?utf-8?B?SWNCekxJUGl1MlhuN2FldzBkWUxGbWZBcDh5V1VrNnpmMTR4TWkwVWh2N3FH?=
 =?utf-8?B?SEhhSlpNaWErQS9YTGhEZEttbnNyQjR0MFVwaWZiMDdMRHgzVUwvbzRwOGZh?=
 =?utf-8?B?Rjk5VjVZTi9lanNndVNabWlSTnJWK0dtU21wZmNEVVo1cktYK3J6dHQvZ0tW?=
 =?utf-8?B?a0REQnp4VGlYbXUxd2Y3aFNwcG5JS1l0Szd0aUFBZlUrOTRRREtZc2hNNm9S?=
 =?utf-8?B?NTQ3WGdhV0RhQ2ZFeWlBNlBPdWlYc0UwbG1YY0ZQL1dmQ0J1Q1pCWVV5Z3A1?=
 =?utf-8?B?b2Z1L1lNVmlwUjZjK1RxWUZmdnVBV1lyWnJYeHJ6S3BCc2xXUDZWd25OS1dr?=
 =?utf-8?B?VmVOdnZ6MzRxVEFYQU8rS0ZoYUN6VktNbjluMjU5dGZaLzVwWjgvM1N5VFhW?=
 =?utf-8?B?aEsxbGdORTRlcjVLK1pmSlY2TThvTlJ0a0k3SUNLaUNQV0w4cG9XRnIxMHY1?=
 =?utf-8?B?SVh6TXltbUYvSnRuZHBteTk1bmwxZVJLZnJwV0doU1dSOXFXMERWL1UxeFNn?=
 =?utf-8?B?dDlTY2syaTlBMkRsQjBVbWIxQlk0aFFRNkFKQjQxQTZ2WDc1NkhQTWNSTS9s?=
 =?utf-8?B?Wk81azZJdWJ1Ym9neXp4ZTFzRisrQXZzd0c1L3JmenpadVV3eWs3VGlVU0dl?=
 =?utf-8?B?TW93QWIxNmV6Uk9HK2hwcjJJMkZETkI4cU5jelhkWWhUTDhDN2xvQ2RkZ1RW?=
 =?utf-8?Q?pyd33Q3DMI93fm3fErkoLrXw1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc3700c-8d30-4e3a-d842-08dda9833205
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 07:31:50.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVVf7iGNsRUA7B3mNFO+d5bpduOlteL3N2UhhETyXNa572pr2PrnyN34U5E1OuJXSV1LdWMKtAJnb4Bagsttkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455



On 12/06/2025 0:40, Jakub Kicinski wrote:
> On Tue, 10 Jun 2025 18:15:12 +0300 Mark Bloch wrote:
>> qdisc_sleeping variable is declared as "struct Qdisc __rcu" and
>> as such needs proper annotation while accessing it.
>>
>> Without rtnl_dereference(), the following error is generated by smatch:
> 
> sparse ?

Right, just tested it myself, it's indeed with sparse.

> 
>>
>> drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:377:40: warning:
>>   incorrect type in initializer (different address spaces)
>> drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:377:40:    expected
>>   struct Qdisc *qdisc
>> drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:377:40:    got struct
>>   Qdisc [noderef] __rcu *qdisc_sleeping
>>
>> Fixes: 214baf22870c ("net/mlx5e: Support HTB offload")
> 
> I don't think this is a functional change? We don't treat silencing
> compiler warnings as fixes, not for sparse or W=1 warnings.

Well Eric's commit: d636fc5dd692c8f4e00ae6e0359c0eceeb5d9bdb
that added this annotation was because of a syzbot report.

Anyway, we don't mind pushing via net-next.

Mark


> 
>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/en/qos.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
>> index f0744a45db92..2f32111210f8 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
>> @@ -374,7 +374,9 @@ void mlx5e_reactivate_qos_sq(struct mlx5e_priv *priv, u16 qid, struct netdev_que
>>  void mlx5e_reset_qdisc(struct net_device *dev, u16 qid)
>>  {
>>  	struct netdev_queue *dev_queue = netdev_get_tx_queue(dev, qid);
>> -	struct Qdisc *qdisc = dev_queue->qdisc_sleeping;
>> +	struct Qdisc *qdisc;
>> +
>> +	qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
>>  
>>  	if (!qdisc)
> 
> nit: no new line between action and error check


