Return-Path: <linux-rdma+bounces-11465-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E85FAE06BF
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 15:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CBB5A1A52
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D7B2264AF;
	Thu, 19 Jun 2025 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fRDp45rD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3978F4A;
	Thu, 19 Jun 2025 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338976; cv=fail; b=Ne0ppjCjnwXBsQs1Ri/zU3WjZOVLAQfcGHWXx2q/u3guP4OIeGL3P+A4CCfWuaaU2RsIwSSHCFvjAQRwzUPiy0Hfgb29nXn1K9GeeI8wt40EPMnHE5HQlsNJfouMw0vVl78OQG9oSYJMtcPYMgwVOufwD4jbAioURetk7GkNr0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338976; c=relaxed/simple;
	bh=DB20OsW1Y05ljuOL8dHdw80IHDnHvORC31kKSgYhclo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PJmFsWbOel1dHI4N2EzcfW4h/KUFmt6ylZ1oCr885w7VxDeQ9ZpfAvm1rtwVbbqQNjXQxOJO5sEtN9+KqlmI2JggPB00du5IDCVKkmYETZi3cArnx9vaWan3Hctq7kvpWGh6uRmA/5xjep7SzLa8/06T7JmGjCsZ4yLEpb0VrVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fRDp45rD; arc=fail smtp.client-ip=40.107.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpMZnLpVegxI28lB7ZNByc/GJshjQyla6HP89cUKf2HzwO82EEiW6R4GKfvU7llVY+UPtpjYJ/unL2iTpb2XGZPyZYJsGpDDkta+XOFKiHqvVCE2wwXf2crkEHw7g9XyauYTyjIeN1OKhdhtUNpCZUBRcUMCtLjtC4cLXEEY2cqr4oVUCyMmrhNGNS684RItClDO835NhR71RwZX8jO6f8ID0el+Sx/8zsqIRjZBVOoa78c4IF6TX+R1GvyRUr2y4/u4TonOw7WUQjuzHzDFg4hmYVAhtVjGolnVnEhn8bQjnfeHY2wOhFm5gNeGRPLyVYu+TBUZzUcDdCGtzARukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ySrkyyrAEEER/OsgZqcwZ2MJStWIyvNsXlKpQfsFF4=;
 b=xhgLLglQtFBfk7jg50gNiwxw5FUOkqItfKKQpbVrLjfVcp316z/fTdpuquyvO4T8lchUJV8SviJptrbJaKtnLjCNULAUkaGAUvzFfbQK2cFiLb3Li7IF1wJ0khOttXw92cfs+9qrJGSRKf3kfK7yuXeVPue3pYcJZbMFQUCYiFfHxgi3eTfDG+ayCTWY0t5LZ7p2DrhqUPW98J2P7iVGWuXV2TNMowzyG0KXFdwVKoPt1yipKxCMJ8rjAnO81IEaTAfp8SXdptLDQIW+X2PX9Ml8OVI5UDlXwNFCIZjULgg5JCdk9rGiY7kEjHCAxGpWSUk7bGtZCo9nCbjNwQqpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ySrkyyrAEEER/OsgZqcwZ2MJStWIyvNsXlKpQfsFF4=;
 b=fRDp45rD66yFycezEDk2EoyoU65t61AfnDmJorqD+xrsj7J76KGEhmY/i+jastpFWrEO8jvoJSsIvZ8lsOhNX99Cj1Sx8hierhTWZo9UQMXxxQNaJzuz9zJm04OPKXIWPd4jWIepWezZqjd7xa2DckuPoAgwtX/S3VSsFe3N9yIUkl7nIkb2mcdosZ8k0+aVjNwZP2vgvdDaxQWbg05542ei8GyO6BAqHb6TkEsbJtMBxsx498PIJ+S5kExvMrVuCWuyiY+F+MDxv8UHp4uErl7XfwkDaHdTLtjC9mPRTAp9OQisHNEUwwxxI8QJe6KfPiyjN9gpRFFTJ43HTRimxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 13:16:09 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%3]) with mapi id 15.20.8835.032; Thu, 19 Jun 2025
 13:16:08 +0000
Message-ID: <0e2fc876-133e-40c2-b41c-272c68b0e6dc@nvidia.com>
Date: Thu, 19 Jun 2025 16:16:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/8] net/mlx5: HWS, Track matcher sizes
 individually
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>
Cc: saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 Leon Romanovsky <leon@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yevgeny Kliteynik <kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>
References: <20250619115522.68469-1-mbloch@nvidia.com>
 <20250619115522.68469-7-mbloch@nvidia.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250619115522.68469-7-mbloch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0867db-1959-4c92-2e65-08ddaf33742c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVowNm5pM0NrbU9DOGRqeXBMTVE5bHRuTVZ0b0tYbzdzeUhUNHREbldMd3M2?=
 =?utf-8?B?M3RIazFmb216V3ZnTzV5WmxTdnhFZmhMNkVPYWNKUkpJc2EwOEx1NGxKKzFZ?=
 =?utf-8?B?VjFFaGhCc2xNeit3d0ZCN2paTFhHR2g1dkVWaGZOV05ob0J1RFJsakpqRkJJ?=
 =?utf-8?B?YThKdFhrREk5b1dwRVlEMWtDdU9zZThraWhnR3RtMVczcXJmSDBQMGJkU08r?=
 =?utf-8?B?bGNQTzJnMFRaZnRDM0JscmVOd2NFTkVSTU9JdkFnNFRYWEQwTWJDbU1VRW9P?=
 =?utf-8?B?NjdIaEV1dHNGVHB0TkNHaWpyK29NcllVK2FmQ2pUUWlNQlR1UmVrMEtlWUJz?=
 =?utf-8?B?RnFFTUNDRm4vWHlBdGNCY01SMm1VMzdvMDFmSkJaQ0lsOXdMRUxnN1hXK0hP?=
 =?utf-8?B?dUNUdmR5V3kvRURZd2pjNWdmSlh3R0NyWHd5YUFQZjN0M0tkZTJNUzRjdERE?=
 =?utf-8?B?ZU14N2tmZ0tpMkNOUW1Fc2NLZUM0NXlSejRQYkNkYU5jVGs3MmYweTV6K2JI?=
 =?utf-8?B?ckplMm42SElxZ1ZBdjdQMWdoTkZFVlRxZDFxc0JWR2duTEdpVVIvU1hnaXow?=
 =?utf-8?B?RWl0cmZ6ZFYyQ3BBLy9Zd1NIZVFYL0ViTEFWdGhCbW9oZkgzSC85NmZGNlo0?=
 =?utf-8?B?TkdRazE1Q2dPRXQ3UHpPdzllUmhhQXBvQmZURkt0Z05DUjRRbEtJZ0wzZS81?=
 =?utf-8?B?dE42Vnl1Y21MZlBrdTFWOW5pNFI2WXV6aWhBK25DUVlpbXU2MWRSSW9UMmZ2?=
 =?utf-8?B?ZnVGNkhFS0RCejVOTWYvYjJEaTM5VWZkOUQyQzNwTGcwVytvVHdSMmRrM29V?=
 =?utf-8?B?UHRTZVdwOUkzLzY3Yy92Yk9PbWpSZWZmS3h1VHN5M1BZN0FtL0FEa0N1T1Vl?=
 =?utf-8?B?b1VWRWIwUDZpeHFWZHZXNFp2Rm5Mc2FPM0xtWDNiR3gyQTVHWk9tWHlPU1Z4?=
 =?utf-8?B?OWluQnB1SW1CVXhXeitPbjBkYUFBSTZHMkRkKzNvenBIMCtESVpBc0ZwQmRs?=
 =?utf-8?B?TkxrK1gvNWhtWTgwaTFiWVZRdWJWZlluNWYycnBxTnhWbm1pS2FDV1dCVFY3?=
 =?utf-8?B?VkF1RjBaeWg5eEF3TDZKK1IrakpOODJwcnZmUldzZ3FSMVVLaHhIcm9SREh4?=
 =?utf-8?B?S3hHNFBRWGRGczJpSjVBUW11UXNPWVJQd0pOZnh6dEhXQmQ3SjdNd3VJZU5x?=
 =?utf-8?B?S056cWJoVFVXc2RZbDB6QjkzdGJNUVhsR1BQUEl3YVVnRU9JSFhTaEJDbW56?=
 =?utf-8?B?MXJSYlNydXpXVnQ3SGVNMWoyb2c2UHlLWTR5QVI1azZqRVNSOE9SeDZOMVVv?=
 =?utf-8?B?dW5pc0FDK01pTHNRcVpNZXFzVG9GNHNwTkpDRFBnVFgvazZ2V2FDSHZDcG9l?=
 =?utf-8?B?T1ZhWjVTY0J1L1ZYS0RTV3o2Uk94ZXUrNUVDV3ZvT3F3eUxWcGZJdk5UTVla?=
 =?utf-8?B?eUdnUkR3OUh6djdJQUcwOFRkLzRjUXI0RFJ0YmgzQ1lnMjc3cmlkeFN5c3Rs?=
 =?utf-8?B?ZktFU0F1cHBrbS9ILy9aSzVWamVzRExndGFvZ3hPejBHOEJhOHFZdGl6enhU?=
 =?utf-8?B?TDRuNDZOTzNnOWY1eXFvaS8vN3NlL3BvU2Q0VFpNNDB0emVqeEtIbWgyQ0Jn?=
 =?utf-8?B?VHFoN3F5YVpFT0o5R0ZEMnFnbXcxaXRpdjM0VER3MkhCVDh4Z2NZZmhjTzFu?=
 =?utf-8?B?dmllQ1c3OUtySjRkYktpYVgxejYxc2F4L1Y0Qld4Umg0MVpmQ0UvNjNRenVn?=
 =?utf-8?B?WDNrNDN4bEdXMmkwRUI5Mm1GSnA1SmllTTNLbHg2cEtIbWRTZmpQbmZ5NFlM?=
 =?utf-8?B?WlBqeVZBdlZMeHVLUkR1ME4wRjJUeU8zYTQrdElDbmhKcys4aG5Vd3NmRWRn?=
 =?utf-8?B?TGpPNjM3c1Q1ZUczZ09lMDgveThBOXYzM0F0U1lZVzFESXlhTEVDQlEyRUEz?=
 =?utf-8?Q?rJJAoMuJVUg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MThSck9ZR0t4MXEwRkoxMGkzOVdueFZLWFhkZFlsNWZUOTBIN3F1MnNXVUtD?=
 =?utf-8?B?a0puSzNFUk9qQjVSR0xRZnJoNkxhVHZZQ2VJVkVQbDBreVpLc3dtbThMQzZO?=
 =?utf-8?B?djhLTEFRRmhlMFcvL0JlcGlwYXU3UXlXTFBPV290R29sY3l6VUlpVytDYlFX?=
 =?utf-8?B?R3hQUHZOU2E3QVNsYUNGbzZ3UUJiZFJZd0NaclNkcFpXenBWeEpZWWlnaG5v?=
 =?utf-8?B?TzE1cHl3K01PZ0FNRUxtajBJZllwem5VZndGbHZYczh1RVRiTmhrOHE4RXox?=
 =?utf-8?B?bURtYTRtdlVIUzRYTmMzUmFNKzh4SlRNUE44WE16OUM4NTMvNEQ5czNQTU9M?=
 =?utf-8?B?UjRsd1dMcXBlRTF5ZUx5Nk1oa3dUVTc5ejNTSmIxcGtUQ2NUYU04bWxVRU9M?=
 =?utf-8?B?amRZWXh0bkZrR0t3VkhPVnhIa3pRRU9BNEVjOTl0dXVCdkxvTXpIeXcvS3N6?=
 =?utf-8?B?ekpBNmI2a3ZJV3o2azNidjNNeWNZRTBsZERLRitNcndQMmFzSG52V2FmelRt?=
 =?utf-8?B?SEFZVkUxNFgyOHJDU1M4Q2R4SUdCeTJkWUxRMGFqY1hpMkxmOEVjZUJtclVC?=
 =?utf-8?B?RjNmVEg3RS9RczdCS1RGL2tpTWNJSER0d2FjbVpoYWMzZml2dUFSTE40M0ZE?=
 =?utf-8?B?SXY3UWZXalFoUldEWTB1RTMwTmZrWVYwOFRIOUhaN2cwNWR2dmJySkxFQ04z?=
 =?utf-8?B?WHpUaWVJa0F5bXY4TksvUmFIVnNrb2VQMVRZVjliOTBLN1NBVnhtYXFFdjYr?=
 =?utf-8?B?MEcwaFRKLzJOM1JEbFBoQWhPRTExSDl2cWRpRldXZzJTQ3doN1c4WmVXNTd0?=
 =?utf-8?B?amVDV1pQdmtEMG1XM1cvcGVxS3F3VXYzdzdka0h4RjhDNXRqaUJQa0IwNllC?=
 =?utf-8?B?QnI2OFUwdGxWQ3haUnlib2J6VDdQS2pwaUJTUzJJYkw4ckkxVk9Vek5Qa0Ez?=
 =?utf-8?B?QTNSb0NyN0lTUGNublRDOTJoczlJRFZ5cDBuMy9vY3J0MUJOa2FPZnBvaGR3?=
 =?utf-8?B?S0taLzYxc0FOdGJ6Rm1MRXJMS3dOVmswd2d5SU1IYkpDaUJ1Y2RBQk1qUG9J?=
 =?utf-8?B?RTduWmhyYjdmWWFKZFlia3lJNXJhNHNhY0pKa2s2ZTJ5bnJoRVFzdTlVZ1ZH?=
 =?utf-8?B?anI0MmREOUM1azFaUGZlU3dTV29jcTFRQlAzWlJCV3NkTDJNaVhtbEdqeWZO?=
 =?utf-8?B?bXB4bklMcjBxRE14S3lPNmJEOFN1WVlOUWdYZGRLeG9aSk5UeS9uUy9HUzNX?=
 =?utf-8?B?aUpWbEQ5RTJiQ3NyREl2MlpvZlBnOGI5VkJyTmkwSlIvand2WkM1MWhHYnVF?=
 =?utf-8?B?V2xDWkoyZ2RieWlNZkYxc1NpQTNRSHozMG0vdW9iTW8yb2ZyUXlWQ2RWZ0Nn?=
 =?utf-8?B?Q3ZPdmlZaVFveWFiUXErUXY5Qk8rUkMxTTN3WG9tVWJvaFpXbEVGT1hKWG81?=
 =?utf-8?B?MGY2d1NLZUNndmpFazlRcnc0UmR0ekZZYURxakVmZld0d1RpNVBvNUFTL21Q?=
 =?utf-8?B?WHllZFZWbEtOcWJkeXQ0WHRJUFdGY3NxMGs4WitxNDFyOGhnQ0RrK3NnV0dq?=
 =?utf-8?B?M2RDV2JnVnNnQnA1dmxzYm5pQWpWZENMYlVzSlJiY2t1NnRmNEhQd2x1Wm0r?=
 =?utf-8?B?TnZDZmxyRCsrbVl0VXJWQU9saFNFUy9RNysvVGp0a0Q3Q3BySllJUE9jRTdr?=
 =?utf-8?B?ZHZkMXpJa3NHY24rWU9kWFlxUzVnVCtQc1BWMkZyOG9rUy9YcnordVdBWHFp?=
 =?utf-8?B?Yjk0dllqOGczRzRxYnFPT3RxRjdZZWpDN2tNQlp2S0hGb3pLU0lYRGtKK1lC?=
 =?utf-8?B?cUVlUndTOWhnbmx0VFdSaXdIdldQaVBpbk55NUwwekF4S2JUVWlTN3pyVHR4?=
 =?utf-8?B?KzZyWmxMeDVCekY0dWJzVGtMOWQ4aTdPdWtBV3hCczRZUno0dFlvU2Z0cXBn?=
 =?utf-8?B?NVFJZk9wektaUUZ5TllEYzVkdDc2Q2d3eHhxbGIvQ1NKOUIwaEtwZlpBNGJy?=
 =?utf-8?B?T2NZS2ZPN3E1OGltRVZaeHdmN250MVNYN0x5cmFQRTh2Y01aYUVyK2YrODVT?=
 =?utf-8?B?cUpTVFRoQjRIZ0tFK1ZhdzNIRmlYN0ZrMlZ0dGpnenoxTkhDU3pTc1RnbUhX?=
 =?utf-8?Q?H2HwR25ymdD+FIF5XupAk5l8d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0867db-1959-4c92-2e65-08ddaf33742c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:16:08.7443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGG6hLArl/0fafEYLsiY07aadgus5mBpShnl2VB2+pcdWmtUCJbqAkJoN/6LB44BGQFc/VozNt0XPQmGhPijvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344



On 19/06/2025 14:55, Mark Bloch wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Vlad wrote the patch, Yevgeny just pused it into our
internal review system, same goes for patch 5 in the series.
v2 will fix both patches.

Mark

> 
> Track and grow matcher sizes individually for RX and TX RTCs. This
> allows RX-only or TX-only use cases to effectively halve the device
> resources they use.
> 
> For testing we used a simple module that inserts 1M RX-only rules and
> measured the number of pages the device requests, and memory usage as
> reported by `free -h`.
> 
> 			Pages		Memory
> Before this patch:	300k		1.5GiB
> After this patch:	160k		900MiB
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  .../mellanox/mlx5/core/steering/hws/bwc.c     | 213 +++++++++++++-----
>  .../mellanox/mlx5/core/steering/hws/bwc.h     |  14 +-
>  2 files changed, 167 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> index 009641e6c874..0a7903cf75e8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> @@ -93,12 +93,11 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
>  
>  	hws_bwc_matcher_init_attr(bwc_matcher,
>  				  priority,
> -				  MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG,
> -				  MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG,
> +				  bwc_matcher->rx_size.size_log,
> +				  bwc_matcher->tx_size.size_log,
>  				  &attr);
>  
>  	bwc_matcher->priority = priority;
> -	bwc_matcher->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
>  
>  	bwc_matcher->size_of_at_array = MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM;
>  	bwc_matcher->at = kcalloc(bwc_matcher->size_of_at_array,
> @@ -150,6 +149,20 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
>  	return -EINVAL;
>  }
>  
> +static void
> +hws_bwc_matcher_init_size_rxtx(struct mlx5hws_bwc_matcher_size *size)
> +{
> +	size->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
> +	atomic_set(&size->num_of_rules, 0);
> +	atomic_set(&size->rehash_required, false);
> +}
> +
> +static void hws_bwc_matcher_init_size(struct mlx5hws_bwc_matcher *bwc_matcher)
> +{
> +	hws_bwc_matcher_init_size_rxtx(&bwc_matcher->rx_size);
> +	hws_bwc_matcher_init_size_rxtx(&bwc_matcher->tx_size);
> +}
> +
>  struct mlx5hws_bwc_matcher *
>  mlx5hws_bwc_matcher_create(struct mlx5hws_table *table,
>  			   u32 priority,
> @@ -170,8 +183,7 @@ mlx5hws_bwc_matcher_create(struct mlx5hws_table *table,
>  	if (!bwc_matcher)
>  		return NULL;
>  
> -	atomic_set(&bwc_matcher->num_of_rules, 0);
> -	atomic_set(&bwc_matcher->rehash_required, false);
> +	hws_bwc_matcher_init_size(bwc_matcher);
>  
>  	/* Check if the required match params can be all matched
>  	 * in single STE, otherwise complex matcher is needed.
> @@ -221,12 +233,13 @@ int mlx5hws_bwc_matcher_destroy_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
>  
>  int mlx5hws_bwc_matcher_destroy(struct mlx5hws_bwc_matcher *bwc_matcher)
>  {
> -	u32 num_of_rules = atomic_read(&bwc_matcher->num_of_rules);
> +	u32 rx_rules = atomic_read(&bwc_matcher->rx_size.num_of_rules);
> +	u32 tx_rules = atomic_read(&bwc_matcher->tx_size.num_of_rules);
>  
> -	if (num_of_rules)
> +	if (rx_rules || tx_rules)
>  		mlx5hws_err(bwc_matcher->matcher->tbl->ctx,
> -			    "BWC matcher destroy: matcher still has %d rules\n",
> -			    num_of_rules);
> +			    "BWC matcher destroy: matcher still has %u RX and %u TX rules\n",
> +			    rx_rules, tx_rules);
>  
>  	if (bwc_matcher->complex)
>  		mlx5hws_bwc_matcher_destroy_complex(bwc_matcher);
> @@ -386,6 +399,16 @@ hws_bwc_rule_destroy_hws_sync(struct mlx5hws_bwc_rule *bwc_rule,
>  	return 0;
>  }
>  
> +static void hws_bwc_rule_cnt_dec(struct mlx5hws_bwc_rule *bwc_rule)
> +{
> +	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
> +
> +	if (!bwc_rule->skip_rx)
> +		atomic_dec(&bwc_matcher->rx_size.num_of_rules);
> +	if (!bwc_rule->skip_tx)
> +		atomic_dec(&bwc_matcher->tx_size.num_of_rules);
> +}
> +
>  int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
>  {
>  	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
> @@ -402,7 +425,7 @@ int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
>  	mutex_lock(queue_lock);
>  
>  	ret = hws_bwc_rule_destroy_hws_sync(bwc_rule, &attr);
> -	atomic_dec(&bwc_matcher->num_of_rules);
> +	hws_bwc_rule_cnt_dec(bwc_rule);
>  	hws_bwc_rule_list_remove(bwc_rule);
>  
>  	mutex_unlock(queue_lock);
> @@ -489,25 +512,27 @@ hws_bwc_rule_update_sync(struct mlx5hws_bwc_rule *bwc_rule,
>  }
>  
>  static bool
> -hws_bwc_matcher_size_maxed_out(struct mlx5hws_bwc_matcher *bwc_matcher)
> +hws_bwc_matcher_size_maxed_out(struct mlx5hws_bwc_matcher *bwc_matcher,
> +			       struct mlx5hws_bwc_matcher_size *size)
>  {
>  	struct mlx5hws_cmd_query_caps *caps = bwc_matcher->matcher->tbl->ctx->caps;
>  
>  	/* check the match RTC size */
> -	return (bwc_matcher->size_log + MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH +
> +	return (size->size_log + MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH +
>  		MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP) >
>  	       (caps->ste_alloc_log_max - 1);
>  }
>  
>  static bool
>  hws_bwc_matcher_rehash_size_needed(struct mlx5hws_bwc_matcher *bwc_matcher,
> +				   struct mlx5hws_bwc_matcher_size *size,
>  				   u32 num_of_rules)
>  {
> -	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher)))
> +	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher, size)))
>  		return false;
>  
>  	if (unlikely((num_of_rules * 100 / MLX5HWS_BWC_MATCHER_REHASH_PERCENT_TH) >=
> -		     (1UL << bwc_matcher->size_log)))
> +		     (1UL << size->size_log)))
>  		return true;
>  
>  	return false;
> @@ -564,20 +589,21 @@ hws_bwc_matcher_extend_at(struct mlx5hws_bwc_matcher *bwc_matcher,
>  }
>  
>  static int
> -hws_bwc_matcher_extend_size(struct mlx5hws_bwc_matcher *bwc_matcher)
> +hws_bwc_matcher_extend_size(struct mlx5hws_bwc_matcher *bwc_matcher,
> +			    struct mlx5hws_bwc_matcher_size *size)
>  {
>  	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
>  	struct mlx5hws_cmd_query_caps *caps = ctx->caps;
>  
> -	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher))) {
> +	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher, size))) {
>  		mlx5hws_err(ctx, "Can't resize matcher: depth exceeds limit %d\n",
>  			    caps->rtc_log_depth_max);
>  		return -ENOMEM;
>  	}
>  
> -	bwc_matcher->size_log =
> -		min(bwc_matcher->size_log + MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP,
> -		    caps->ste_alloc_log_max - MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH);
> +	size->size_log = min(size->size_log + MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP,
> +			     caps->ste_alloc_log_max -
> +				     MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH);
>  
>  	return 0;
>  }
> @@ -697,8 +723,8 @@ static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
>  
>  	hws_bwc_matcher_init_attr(bwc_matcher,
>  				  bwc_matcher->priority,
> -				  bwc_matcher->size_log,
> -				  bwc_matcher->size_log,
> +				  bwc_matcher->rx_size.size_log,
> +				  bwc_matcher->tx_size.size_log,
>  				  &matcher_attr);
>  
>  	old_matcher = bwc_matcher->matcher;
> @@ -736,21 +762,39 @@ static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
>  static int
>  hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
>  {
> +	bool need_rx_rehash, need_tx_rehash;
>  	int ret;
>  
> -	/* If the current matcher size is already at its max size, we can't
> -	 * do the rehash. Skip it and try adding the rule again - perhaps
> -	 * there was some change.
> +	need_rx_rehash = atomic_read(&bwc_matcher->rx_size.rehash_required);
> +	need_tx_rehash = atomic_read(&bwc_matcher->tx_size.rehash_required);
> +
> +	/* It is possible that another rule has already performed rehash.
> +	 * Need to check again if we really need rehash.
>  	 */
> -	if (hws_bwc_matcher_size_maxed_out(bwc_matcher))
> +	if (!need_rx_rehash && !need_tx_rehash)
>  		return 0;
>  
> -	/* It is possible that other rule has already performed rehash.
> -	 * Need to check again if we really need rehash.
> +	/* If the current matcher RX/TX size is already at its max size,
> +	 * it can't be rehashed.
>  	 */
> -	if (!atomic_read(&bwc_matcher->rehash_required) &&
> -	    !hws_bwc_matcher_rehash_size_needed(bwc_matcher,
> -						atomic_read(&bwc_matcher->num_of_rules)))
> +	if (need_rx_rehash &&
> +	    hws_bwc_matcher_size_maxed_out(bwc_matcher,
> +					   &bwc_matcher->rx_size)) {
> +		atomic_set(&bwc_matcher->rx_size.rehash_required, false);
> +		need_rx_rehash = false;
> +	}
> +	if (need_tx_rehash &&
> +	    hws_bwc_matcher_size_maxed_out(bwc_matcher,
> +					   &bwc_matcher->tx_size)) {
> +		atomic_set(&bwc_matcher->tx_size.rehash_required, false);
> +		need_tx_rehash = false;
> +	}
> +
> +	/* If both RX and TX rehash flags are now off, it means that whatever
> +	 * we wanted to rehash is now at its max size - no rehash can be done.
> +	 * Return and try adding the rule again - perhaps there was some change.
> +	 */
> +	if (!need_rx_rehash && !need_tx_rehash)
>  		return 0;
>  
>  	/* Now we're done all the checking - do the rehash:
> @@ -759,12 +803,22 @@ hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
>  	 *  - move all the rules to the new matcher
>  	 *  - destroy the old matcher
>  	 */
> +	atomic_set(&bwc_matcher->rx_size.rehash_required, false);
> +	atomic_set(&bwc_matcher->tx_size.rehash_required, false);
>  
> -	atomic_set(&bwc_matcher->rehash_required, false);
> +	if (need_rx_rehash) {
> +		ret = hws_bwc_matcher_extend_size(bwc_matcher,
> +						  &bwc_matcher->rx_size);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	ret = hws_bwc_matcher_extend_size(bwc_matcher);
> -	if (ret)
> -		return ret;
> +	if (need_tx_rehash) {
> +		ret = hws_bwc_matcher_extend_size(bwc_matcher,
> +						  &bwc_matcher->tx_size);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	return hws_bwc_matcher_move(bwc_matcher);
>  }
> @@ -816,6 +870,62 @@ static int hws_bwc_rule_get_at_idx(struct mlx5hws_bwc_rule *bwc_rule,
>  	return at_idx;
>  }
>  
> +static void hws_bwc_rule_cnt_inc_rxtx(struct mlx5hws_bwc_rule *bwc_rule,
> +				      struct mlx5hws_bwc_matcher_size *size)
> +{
> +	u32 num_of_rules = atomic_inc_return(&size->num_of_rules);
> +
> +	if (unlikely(hws_bwc_matcher_rehash_size_needed(bwc_rule->bwc_matcher,
> +							size, num_of_rules)))
> +		atomic_set(&size->rehash_required, true);
> +}
> +
> +static void hws_bwc_rule_cnt_inc(struct mlx5hws_bwc_rule *bwc_rule)
> +{
> +	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
> +
> +	if (!bwc_rule->skip_rx)
> +		hws_bwc_rule_cnt_inc_rxtx(bwc_rule, &bwc_matcher->rx_size);
> +	if (!bwc_rule->skip_tx)
> +		hws_bwc_rule_cnt_inc_rxtx(bwc_rule, &bwc_matcher->tx_size);
> +}
> +
> +static int hws_bwc_rule_cnt_inc_with_rehash(struct mlx5hws_bwc_rule *bwc_rule,
> +					    u16 bwc_queue_idx)
> +{
> +	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
> +	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
> +	struct mutex *queue_lock; /* Protect the queue */
> +	int ret;
> +
> +	hws_bwc_rule_cnt_inc(bwc_rule);
> +
> +	if (!atomic_read(&bwc_matcher->rx_size.rehash_required) &&
> +	    !atomic_read(&bwc_matcher->tx_size.rehash_required))
> +		return 0;
> +
> +	queue_lock = hws_bwc_get_queue_lock(ctx, bwc_queue_idx);
> +	mutex_unlock(queue_lock);
> +
> +	hws_bwc_lock_all_queues(ctx);
> +	ret = hws_bwc_matcher_rehash_size(bwc_matcher);
> +	hws_bwc_unlock_all_queues(ctx);
> +
> +	mutex_lock(queue_lock);
> +
> +	if (likely(!ret))
> +		return 0;
> +
> +	/* Failed to rehash. Print a diagnostic and rollback the counters. */
> +	mlx5hws_err(ctx,
> +		    "BWC rule insertion: rehash to sizes [%d, %d] failed (%d)\n",
> +		    bwc_matcher->rx_size.size_log,
> +		    bwc_matcher->tx_size.size_log, ret);
> +	hws_bwc_rule_cnt_dec(bwc_rule);
> +
> +	return ret;
> +}
> +
>  int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
>  				   u32 *match_param,
>  				   struct mlx5hws_rule_action rule_actions[],
> @@ -826,7 +936,6 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
>  	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
>  	struct mlx5hws_rule_attr rule_attr;
>  	struct mutex *queue_lock; /* Protect the queue */
> -	u32 num_of_rules;
>  	int ret = 0;
>  	int at_idx;
>  
> @@ -844,26 +953,10 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
>  		return -EINVAL;
>  	}
>  
> -	/* check if number of rules require rehash */
> -	num_of_rules = atomic_inc_return(&bwc_matcher->num_of_rules);
> -
> -	if (unlikely(hws_bwc_matcher_rehash_size_needed(bwc_matcher, num_of_rules))) {
> +	ret = hws_bwc_rule_cnt_inc_with_rehash(bwc_rule, bwc_queue_idx);
> +	if (unlikely(ret)) {
>  		mutex_unlock(queue_lock);
> -
> -		hws_bwc_lock_all_queues(ctx);
> -		ret = hws_bwc_matcher_rehash_size(bwc_matcher);
> -		hws_bwc_unlock_all_queues(ctx);
> -
> -		if (ret) {
> -			mlx5hws_err(ctx, "BWC rule insertion: rehash size [%d -> %d] failed (%d)\n",
> -				    bwc_matcher->size_log - MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP,
> -				    bwc_matcher->size_log,
> -				    ret);
> -			atomic_dec(&bwc_matcher->num_of_rules);
> -			return ret;
> -		}
> -
> -		mutex_lock(queue_lock);
> +		return ret;
>  	}
>  
>  	ret = hws_bwc_rule_create_sync(bwc_rule,
> @@ -881,8 +974,11 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
>  	 * It could be because there was collision, or some other problem.
>  	 * Try rehash by size and insert rule again - last chance.
>  	 */
> +	if (!bwc_rule->skip_rx)
> +		atomic_set(&bwc_matcher->rx_size.rehash_required, true);
> +	if (!bwc_rule->skip_tx)
> +		atomic_set(&bwc_matcher->tx_size.rehash_required, true);
>  
> -	atomic_set(&bwc_matcher->rehash_required, true);
>  	mutex_unlock(queue_lock);
>  
>  	hws_bwc_lock_all_queues(ctx);
> @@ -891,7 +987,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
>  
>  	if (ret) {
>  		mlx5hws_err(ctx, "BWC rule insertion: rehash failed (%d)\n", ret);
> -		atomic_dec(&bwc_matcher->num_of_rules);
> +		hws_bwc_rule_cnt_dec(bwc_rule);
>  		return ret;
>  	}
>  
> @@ -907,7 +1003,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
>  	if (unlikely(ret)) {
>  		mutex_unlock(queue_lock);
>  		mlx5hws_err(ctx, "BWC rule insertion failed (%d)\n", ret);
> -		atomic_dec(&bwc_matcher->num_of_rules);
> +		hws_bwc_rule_cnt_dec(bwc_rule);
>  		return ret;
>  	}
>  
> @@ -937,6 +1033,9 @@ mlx5hws_bwc_rule_create(struct mlx5hws_bwc_matcher *bwc_matcher,
>  	if (unlikely(!bwc_rule))
>  		return NULL;
>  
> +	mlx5hws_rule_skip(bwc_matcher->matcher, flow_source,
> +			  &bwc_rule->skip_rx, &bwc_rule->skip_tx);
> +
>  	bwc_queue_idx = hws_bwc_gen_queue_idx(ctx);
>  
>  	if (bwc_matcher->complex)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
> index d21fc247a510..1e9de6b9222c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
> @@ -19,6 +19,13 @@
>  #define MLX5HWS_BWC_POLLING_TIMEOUT 60
>  
>  struct mlx5hws_bwc_matcher_complex_data;
> +
> +struct mlx5hws_bwc_matcher_size {
> +	u8 size_log;
> +	atomic_t num_of_rules;
> +	atomic_t rehash_required;
> +};
> +
>  struct mlx5hws_bwc_matcher {
>  	struct mlx5hws_matcher *matcher;
>  	struct mlx5hws_match_template *mt;
> @@ -27,10 +34,9 @@ struct mlx5hws_bwc_matcher {
>  	struct mlx5hws_bwc_matcher *complex_first_bwc_matcher;
>  	u8 num_of_at;
>  	u8 size_of_at_array;
> -	u8 size_log;
>  	u32 priority;
> -	atomic_t num_of_rules;
> -	atomic_t rehash_required;
> +	struct mlx5hws_bwc_matcher_size rx_size;
> +	struct mlx5hws_bwc_matcher_size tx_size;
>  	struct list_head *rules;
>  };
>  
> @@ -40,6 +46,8 @@ struct mlx5hws_bwc_rule {
>  	struct mlx5hws_bwc_rule *isolated_bwc_rule;
>  	struct mlx5hws_bwc_complex_rule_hash_node *complex_hash_node;
>  	u16 bwc_queue_idx;
> +	bool skip_rx;
> +	bool skip_tx;
>  	struct list_head list_node;
>  };
>  


