Return-Path: <linux-rdma+bounces-13700-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDF8BA70E1
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 15:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0BBA7A4ECC
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342F32DCF5B;
	Sun, 28 Sep 2025 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ioqjoEeP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2E231A24;
	Sun, 28 Sep 2025 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759065884; cv=fail; b=lOfUnAzH1mXrNaqQ5hwoz74cKmZwyiNEWZXuCfXHVubdZIgPDjym7oXbnpHkzo7MRVXTu1aO++187C4dJNg3oGvqvYtjiD4z4zdhZheOhh0bi7tQJiytfYcCxaZGsIbWKfeCZSNZqDNYE2xEEFNnDzmAg5UUvbCIitUfLCzrICU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759065884; c=relaxed/simple;
	bh=CbTzAyfj6CZdVRf/DCQ7dKKDogTfeBq2nZHe4TCJnrM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nvMgbTeV60u+h/nj8BbJQ1oPZOcwnliyvTsRqa2Cpw4v+hGzeR17DFPV1D4Qt03LHjsARS1YtoIqJ1Tg7rTS9XY/XPGFEekvm9c3uch0fZH58ATJPb9vdigr5LTq+qjVBmTMIrMXpdYmqFzn6FWtkXsW27aQoeWa0d8ERg0wWMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ioqjoEeP; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euH4fT/TT7VZ586LdezqE4nOCFuhCwQW+oS3FjpSoCDx2WWY1A2pM2vzQ50JoxHZZZMVEMqHtuGBu125YNb/6HjDE2GopQRQ1SVYlYKtwoH+z6/TozcEhyHpt5QxBx0mELoVxOTkaOXPoXYJkj7XgLNNddQeQ39xX0gIBUHsq6Dlo7Tl7EBV2zKrb6rGSqE+mDgM6SGOfH6pEV+OmWde7wPloaZv4YIlyHGxdBbtm8cp/efWuRhzOY9EGstQKKgCdk+zDuuXuVM5W7DH6wogncpzTMPiNsqoxFvMS+d0KgHncsSHKHxrXKHgoY+K00n/XXj2KBRp2Ny9kktSVjcRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5+TX8etU5TJOqfmE+I/cS84KM8ejv232Vdl5jbP4sw=;
 b=HXp8WPP1hk33kgumYi36llVIAAyL42T8oycUNflboDhdzd2/w5X5oSjF7VfYPThGcZMrk/iiDDTg4bmYYACZOj7KdTHM6BQRqDQX7fWJIcBHx0aofZTlVAsggyvD7GozFT4p4NStDvu1DgNBpJUN2FD/1ktzdA+ZL21U4Db5GF8Ra80WC/g0858bSw7br0L6o5te+27R6NwnxE9PA6ohDuH6of4ictRJtr739Q7eQZoF1AWOg/KKN9L4VJw+kmIPl+ElpHozMvUXs+81KVsS+TxL5Bvqfdf3MCqLHRaBNau3u0fsaxAtVqVcS8I3Gty0SfnOi7nD3eadoAQbrISxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5+TX8etU5TJOqfmE+I/cS84KM8ejv232Vdl5jbP4sw=;
 b=ioqjoEePhym922uDt+y6HzAWvBtqmZCN2XfJzA5r2q0impgciS34zARwzt8DdbXWNR8+03TDYuSKt/08Pu1quwYABETskNlR0DJ8NJZFCpiBDrebZxtSBQu4bn+6H0qDUOm1+oEgrda4sNBBeQqF0cKvv8nLziNafRcmEX+Pl9PO5PhAQ1KCOiAIjAhoq06uZ6KX0SO18OHymrRwVSr5nOHkCvv3s2X4ftNdRzbd3dIMJYnrUkMt3YxB3JpVbaoFtExTec7N+bRhCIRJTealMTNUto2ODxjTAOFf8JhOqb+47aejcqQGpMZ4cs7iH8LMyfgQ6DNmh8s/coSWMV/4Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Sun, 28 Sep
 2025 13:24:39 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9160.015; Sun, 28 Sep 2025
 13:24:38 +0000
Message-ID: <7d46a1d1-f205-4751-9f7d-6a219be04801@nvidia.com>
Date: Sun, 28 Sep 2025 16:24:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
To: Markus Elfring <Markus.Elfring@web.de>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
 <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
 <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
 <8b0034a7-f63b-4a98-a812-69b988dd3785@web.de>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <8b0034a7-f63b-4a98-a812-69b988dd3785@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|BY1PR12MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d5074a-5a0a-4f0a-6cca-08ddfe925fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0NkSFVncFpyT29pMms3UVRnVllXaEtkREllbnNHV29zZHhIVVI5UTh3UXVJ?=
 =?utf-8?B?U2M2SVNzTG1hbjRoQTg3N1c2cEl5SThxc05rOTA4bmVYb1lpRkdTMXV2MFd4?=
 =?utf-8?B?R3hOclFmVllKd0RrazdWamVMMFFnTnFBRTE0QjdZWUl0RXNKblJWTzJnbE81?=
 =?utf-8?B?SDVuQnhkaDdTajFVQkh3VmpqdmRqQW9jSk9SWnVXam5FTnRYekFjWmNkVU9r?=
 =?utf-8?B?SjJnREJMUlArMVNJdEZXWTJFaHdrRFA2QUxIV1dmVVFmaFRFejNMd1FkLzZW?=
 =?utf-8?B?aEpmeFlFVlV2TjI4Y2JDVGFZYkZNZ084TGtKN3lJSEdjV3JPWmNDb1JISnMr?=
 =?utf-8?B?MnhqYkN3dGZIQWdTMzBjdno2elNReXVZUzZFUnFaY2ZzSnZXSHJXTHF0Y0pQ?=
 =?utf-8?B?OEtQTzRJR3hMaFNBbE03ZS9iUkMzaFVWa003aWU4RDZDVHB5Y0w5TC9kZkY5?=
 =?utf-8?B?T2FKaGZzbE1kK0U2WlBtOG92ZFRkRTZBUEVkTlhvb0dwMllTN3hNVEdGWUtE?=
 =?utf-8?B?dElseEZPNkZ0ekpKRUQzMHVySHhaWmsvcEl0K25uQWhsZkJ1V3dEbmdLUHNX?=
 =?utf-8?B?Qys0SkIwSGhXc3U0dTBUSWRSRVBLNEJ5Vis2QXRyNmh6NzZ0ZGNITzY4eDdy?=
 =?utf-8?B?VEJpRTZOdnZqU2p3djlBVW0valJyUHlxdTdHZWU3b2lVZU9TdWZPMnpEME10?=
 =?utf-8?B?OVBTa2pVQWNydjc2K09Ta3R6VlNCb3RPdzBwc3lLWnBYeWxkUjFuUEhzUXFt?=
 =?utf-8?B?OVJBQ2dCNkx0Nlg2VDNVcFZvZ1RxV21TU3hGNGhxNGNjbTBQQjhwdEsvTGpD?=
 =?utf-8?B?c1M4UmxRbjZzVWRGTUZFUWF6RW5sNGdDR1BRN3VxK0o5SkdNeTRoSmgrRk5R?=
 =?utf-8?B?WjZsbWlJRFpUY0xXdG5aY3NVb3MvZ29LYk9lOGRLSkwreW5lc29VOWsyQjQ0?=
 =?utf-8?B?MGxJaDlUVnBCOHJ5YkVUWG1XZ2x2dHJKQVFWOTIrL3NUVVVQQW1KZWNWMTFO?=
 =?utf-8?B?dkZRRFU0QlU0MTlQM2FPZFpqQVBXc0x2WE5qcGp0ZEE4VGFXNXd5cUFlOW1m?=
 =?utf-8?B?V0pMditLUTVPVlkzNVhRU2I2R1lDek4yNWE0Y29lVmc4Q0VrK1FIVmdNNitl?=
 =?utf-8?B?WVhYM2x5RUVXV1RBcWVMZ2JocmRSZkhrajJlRDdWVkcyQnBraS9JdVJiRHRk?=
 =?utf-8?B?NjI1ZVA3MVB6WUNVemQxY2ZJTU5RV2VKdjRBekY0RWp4aW16L2ZkdnJBWldr?=
 =?utf-8?B?aXE3K2UrTmQvdzJ3Z2V5US9HQTFHTU9PellVMzVDSHIvZ3c0d3ZDaWgvYzJE?=
 =?utf-8?B?Rko1dXN6STR5elRZL2VWZ0xUOWpLNVhjWUFmWDZ2T2FMSm5Cb3J0aU9XckJx?=
 =?utf-8?B?cHo3Q0g5RnVpN1hFNHJuWHhKYzkzZThMQUs1TGtsNnA0ZDhOaGZIOEtzenVa?=
 =?utf-8?B?Ym1aZnVwSVpVak5IR2FBYk5mRjFrakI5V1MrM2ZtcFFuU3VrRm52Wk5jRk5w?=
 =?utf-8?B?WmtHcHV0U24wdWtzNjhSZGFGcThreFY4bjJkM1F5SkwxUDJCMTZ2aW5JUVlH?=
 =?utf-8?B?RDI2ZTJXOWNjVFIvajRTQTg5Yi9wOSthcDY0MG1HTWFIWGJteVRRcVIwdnVX?=
 =?utf-8?B?b1o5MExGeFA2TmQyRkhCMGxSb3NZenhIN2FZZXpZOStJeTFLaGEzUXdTNmNs?=
 =?utf-8?B?SUErZWNVb25QbVN6bG5IV3dmdVptWm9DajhLSDJ6NEY0YjgrS3UyRHNIKy9v?=
 =?utf-8?B?RVpuelY4RlNLZlY1aTdXYVRodVZXcWxjUXg4Nlh0OU1JQkdNQnFYcnY3dTd2?=
 =?utf-8?B?M2hsRzlFbnJ6QXF0R1pjL3VRUVRpaitueU5MaGxNeWJFenVXUXEwUjBZVEc3?=
 =?utf-8?B?bW9DMGNvU09EY3MwbDR0RmQva0hSR3ZVSUp5cEhvVXBYRHNxRVpyUzZlZDlo?=
 =?utf-8?B?b0NQRU1SK052WlNwNm1XVmFTL3h1ZHJ3Q2dPV0VkQjN0cTNwMFJIRjRPajM2?=
 =?utf-8?Q?WBfkQjd+MCv+5zKsM2rFVcM4EiIVMM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2xBRDFqMWM4R1B5RkNveWlFMG80dFBVc09YM2FJUkY5VWFmMkVtS3VoUXlq?=
 =?utf-8?B?NXdVWmJWYVk0T0pzak0vN2g2cjg3ZEdlUEk1eFFZMUNXd3ZobjNVNHV6dWtl?=
 =?utf-8?B?dGlhSlBrM1p6WXRCeFFxL2c1TjZSMStpSlcxMzhwYW1ubU1TbzBXTElNUTQ0?=
 =?utf-8?B?dWZHQjJOZmFSSUZBeTRQNHU2aDlMUDk1QjZiaTloM0hjTnM0QmI2ZGJzRlMz?=
 =?utf-8?B?OWFZMUptelRNU3hkOGZueWt4VVZQL3JJU1F4YVV0djhlN29nNFVxdnhYZDVE?=
 =?utf-8?B?NEVZa1VwbVFyMEJWM1NWTzZtL2lqekUyZlUxZmFUcGF6OHhzdGVnUU5JUklO?=
 =?utf-8?B?YXdKNDk4cHhRaUJkNGMvSmZENnV2Q3lNdlF0d292OTAvbkNYTjN0dTZKMDJ2?=
 =?utf-8?B?eWIyQ1JtcnIvbHkvQzVaVGpsR3lWSUZlMTYyTVRTWVFwa1pJMlNmV2hScko2?=
 =?utf-8?B?UWp1M293a3BrREtjVnF1M2IrRkpjT2FhSTl0czZLMGR4dUh4R1VPK2VIUVRx?=
 =?utf-8?B?eFgvVVE0SjMveVgrSDArU1JGNyt0OUgrWkNlR01UUVkzK0tUSnU1WGx2eXJS?=
 =?utf-8?B?cWpDNFZrVFBTaE5tNUhxUFF3SVZBTWVyM05zdkVYRG5Ubi8wdG02b1Q3NjV5?=
 =?utf-8?B?N05pZmsrMWcwRjJBQUlxK1NFV3hHWVdnYVNGS0hpa0k4UXZRQlE4RDU2NStL?=
 =?utf-8?B?bUhkYVNaVGt1TExpeXREZXcvamliSER1cko3L0I2RWFqVmd4NVc5aTNKeDN3?=
 =?utf-8?B?czMvNkFVMUo2V1JZYVhtdnpwWUxmczA4QW1JYnk2NjQyNTZHUU9qREpyZlIr?=
 =?utf-8?B?dlVHNTczc0oxR2VpcWJ1bDVJYTQvb2pCWVZUZGhOU0VqMmFkNHJvMnF1MzI3?=
 =?utf-8?B?VjRGSS9CWE5kNmNOREM0Ny9kQlpNcW5rdnVZcHpscjdsSDk4ZTVQTDF5UjBj?=
 =?utf-8?B?WmM0UDAzNTkrOUNCSlY5bzQ4dUlsK2d5U1p6RkRDa21uaU1jU1RQbTRacWpv?=
 =?utf-8?B?RmpaRWhSSXZMNXpuY3RVRlR5K21XRkFBQzZNTTRVNmZIYWFLUkwyNUl3alBE?=
 =?utf-8?B?OFRPNjd6MVhncHlOMUxWaHdNcldUbjYvZjY5eWFDNEtxeEdpb2FMVkxFYUNP?=
 =?utf-8?B?MFNLc3h2elZEV2tSbjdwY2lJVDRlZndqdzdFUWg0eFVyamtPSXFsZDRVSGY5?=
 =?utf-8?B?eFRyUHZCNlhYTm5QelN0L1RQQzVHK0xQbU5VSk9MNXMyVktaaVRETktHdEVE?=
 =?utf-8?B?SE9KaHRsekVYd25qV253WVJodDVLY3hhMDhtcStoVnJ3RnAvbW9nWlBMUDNw?=
 =?utf-8?B?aGxRRWpHdXNrYzU2VzU1WGRWVGJ0dDBHTUtDZWRXVjRid1FuYkNsc1F5YzdP?=
 =?utf-8?B?VnJJclJoS3k1ajAyZ3NwdlU1ck5Rd2c0eVRVay9TcStBRzRldFJwczBsUE5L?=
 =?utf-8?B?MXR4T25PdE55RXVPVm9mRW9wNllsSGVWNEFUdzFYdlJkeW9hQmg0aDFEdkZY?=
 =?utf-8?B?Y2xQR2IzNVdmQVk2OGpqS3drWC9LQy9sZlVQM0crazJKTVBHaVZyczZ4MC9J?=
 =?utf-8?B?anNpMklUbFpublpGTnR6ZSs4aVJUNFhMVmE1L2lkSXZpbEtRbjlvamErL2ZF?=
 =?utf-8?B?bTd4NzdqT0ZKZG5XaHVUWEJKdHh2MmFjUURIQ2RucFFvQ0djYS9BNnNlcVJJ?=
 =?utf-8?B?TUtGNnFWeWQrcWowNm9URW4vVkJBYmtPOTlLY3gwRENMSXVGakFsdDFDQ0FW?=
 =?utf-8?B?SEtDWVR1NDZEeXljRTBrYnpxRUM1R0lvNWxLSDk3RHJJMXFlaVRkOXRmNy9H?=
 =?utf-8?B?d0p2ck9GcGkrVUFadWExbUd2OElWbGNEa1A4ZC9YelpkQ05SWWxXVDVNbWQ1?=
 =?utf-8?B?OVA0NE4reWtGQ0RMclBvTVFBUzRGMGNPN2FpbXJwaGRZc01nd09MWmI1WC9R?=
 =?utf-8?B?LzBpUXhkdHg5c3p5MkFORTUrc0NLTUVDYWNGREp4M0c4TEN4dEZ6UG1qSklT?=
 =?utf-8?B?bkhIZE1BT09BRzhRY2NkdTBYdEEvanVhUDN6VjVWcGtKN0ZlWm1xSno3QWNU?=
 =?utf-8?B?eS8rM1pRNW00MC9WOUVMZVdrUzZobFJLR2lRREtrbC8vTnFQay9rNEN1dUJw?=
 =?utf-8?Q?M13RXFsCbWfTjkU7w9tSCteT3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d5074a-5a0a-4f0a-6cca-08ddfe925fd8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 13:24:38.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77APE3x/wCpDMWhfVtx4ZhLrz0L/m2kDaQorgr6I/HWmN5C6wAxTjb70cQvNaCpx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447

On 28/09/2025 15:00, Markus Elfring wrote:
>>>> +virtual context
>>>> +virtual org
>>>> +virtual report
>>>
>>> The restriction on the support for three operation modes will need further development considerations.
>>
>> I don't understand what you mean?
> 
> The development status might be unclear for the handling of a varying number of operation modes
> by coccicheck rules, isn't it?

I'm sorry, I still don't understand what you mean (the problem is likely
on my side).
Do you want me to change anything?

> 
> 
>> I did find "format list" in the documentation, but spatch fails when I
>> try to use it.
> 
> Which SmPL code variations did you try out?

Ended up with Julia's suggestion.

> 
> 
>>> Would it matter to restrict expressions to pointer expressions?
>>
>> I tried changing 'expression ptr;' -> 'expression *ptr;', but then it
>> didn't find anything. Am I doing it wrong?
> 
> Further software improvements can be reconsidered accordingly.
> 
> 
>>>> +@script:python depends on r && org@
>>>
>>> I guess that such an SmPL dependency specification can be simplified a bit.
>>
>> You mean drop the depends on r?
> 
> You may omit “r &&” (because the rule is referenced by an SmPL variable declaration),
> can't you?

Yes, thanks.

> 
> 
>>>> +p << r.p;
>>>> +@@
>>>> +coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
>>>
>>> I suggest to reconsider the implementation detail once more
>>> if the SmPL asterisk functionality fits really to the operation modes “org” and “report”.
>>>
>>> The operation mode “context” can usually work also without an extra position variable,
>>> can't it?
>>
>> Can you please explain?
> 
> Are you aware of data format requirements here?

Apparently not, I'll be glad to learn.

