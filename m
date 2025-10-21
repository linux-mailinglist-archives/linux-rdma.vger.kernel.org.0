Return-Path: <linux-rdma+bounces-13961-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CFBBF7501
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 17:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEDD4076FE
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E867342CBB;
	Tue, 21 Oct 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jxTUGxk8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2432F2910;
	Tue, 21 Oct 2025 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060349; cv=fail; b=ltaYSne+jsEZaZ7p7ett1qrCXa4sNDZ+6F1wzpfrtAuql4bQiJ1KkDIKJyvOD1PaqsK3PZJqYG/yW9VOnh67vlejBscOohba0UDGoQKmk5bBZGdf8TCUJkS4IM9H5eorhLzqjz2ocgBTZ6zGm3mKgjOs9lqH+/eDq+L0M9ps0j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060349; c=relaxed/simple;
	bh=HNytdCplZvCxv4vjEiPZ7oNBxjDPJs7aEU7LCynv1ZA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iK8fYR3ZcEvojplVsiGN8kOfYzWi5HWr/WnNXzUP2xjVAtBKtjX3t5wNNR9M3r7ru+AtEiFSXY5VIgFU68CjU61/L3zPuIIscSpb7Ov4sfF4RfzoYmf8qKAChnPSBPrZTePcSjpL9qheniJXtgeyC5fdz3lIkuVChJ06FlePUlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jxTUGxk8; arc=fail smtp.client-ip=52.101.57.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVxTM+O5MhrwR0IJ5/aYfadI3JVLoIBh0E5Fahk05g+rMbe0nhtdUKckYYNLQH1cntMffwuYKcEYvsOy5pAX2Cdm909r/QqZleQvH+UXJpuXP8Bm/83Hwutc7o+dUzlYonZrjV3X/32tCa9ya2i22siwTjvi1vQWrPqMGgogOsDmyu9KE7tXezHK5HGZ6/Z2BhlE3WjTAihRsqgbEAbS6jSZ87Lssyk0jG7H2PIE5XmPMG15IAuKD3eImKVtifV6QTDjuDZHA5fEzdakTv8BMWxw6wGxrbUefTvGfUXRJo1+o0MPs5KCpiW/TN9HveAixcYXPDSrr/GDBgBMMfIQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7V03fRlwEp6YVMd9bLJal0oYSjsc6ULuqI/xiBYhoo=;
 b=NPbSrIqprMzrTA8v8s3lJuoFiy+v0EmHaXdB4dMrg/yOBHeI36U4CucHydUCz+zQY0ed2Gs2shZ+OTCfsE3eyqFHHrtkMpYBYtjOZJNqswPQaV8lZD0wXBD/aCWVLQnfFVNNLlT9kM3x9a8Zf9qfhqJJiawf+bf/KBJCXN430pGgiAgkyiBmMIz9JbxNDmcQCD5Qi1+fXLSO6NQUKCN5PbkTNP+bbog6QWmp0e3x0ozmmgS4dGENSa3shi4dXE1UeXqGqd4ySrjXjQfeG0yL+eLgaOSlcH7QVHfJdg9Ex9S4vg1X8PkseiJwz0K3ZXIosaZe2k4Wvpmnu8oL0Zitkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7V03fRlwEp6YVMd9bLJal0oYSjsc6ULuqI/xiBYhoo=;
 b=jxTUGxk8qNqO/YN5K5psvwDpcofVw1QchXKC1/P710oVutsEfP4h1MOfDz0JPrxWYHw9UsSvYCavH7RiHMRuLhJ3T6Mx2ny4X2lGhQPendu24tYIN/SANngbLC6vbVfsLKAQRQ3RE5qBsnTPkqYosSBwS8X7FdLeHjuMusXS5a9sFi4ZtT0blcHg6617FajkKpJ1BPDKLbMaE5LEg6rx2PPJvFqgedc+mN+HQNy54av1aDbKiy/9aQlAZyFqRNDYi/mLWKXyE8XOdeMl3Qrx3oEh0wqSHEwryc0LGJRXg/Bfvui6Jc0Y2ge//SjP2+5I75/DPaGBQ/vw1+YeKftwDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ2PR12MB8805.namprd12.prod.outlook.com (2603:10b6:a03:4d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 15:25:43 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%4]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 15:25:43 +0000
Message-ID: <8186f892-4753-4059-b396-6895c38cc07a@nvidia.com>
Date: Tue, 21 Oct 2025 18:25:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 3/3] net/mlx5e: kTLS, Cancel RX async resync
 request in error flows
To: Sabrina Dubroca <sd@queasysnail.net>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>
References: <1760943954-909301-1-git-send-email-tariqt@nvidia.com>
 <1760943954-909301-4-git-send-email-tariqt@nvidia.com>
 <aPeev-zbATKMq1pY@krikkit>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <aPeev-zbATKMq1pY@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|SJ2PR12MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: 38405408-a8c8-48bb-787d-08de10b6196d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlhVMDFzb0ZTVlNRVHc2Q2dkUkhIL3E5TGFBY1JTVXVJQmptd0JldVd3UTAw?=
 =?utf-8?B?Qkk5WW1iZklOWEJXTFFnNE9wQ21XSzBPaGhhZkkxcDVkcERWZXBOQjVVNUMx?=
 =?utf-8?B?UFdlR21VdXNhUGYxc0wzTXBGWDA3USs5YjdSMGxhUlF1TnFaVGhoNzJydHZC?=
 =?utf-8?B?UGtIcUN2MjIvaUNvdWk3MklhZDBsQThKS1JHMzJ0empxR1hKbzdIZFpPN2x0?=
 =?utf-8?B?S2x2SGVKMVlxM0ZPTGlTRkd5RHZ3bVdlbDVHOFJqZFhPaHFvVmRxeWpOSEkz?=
 =?utf-8?B?QWNiUkVnMHNGVlk2d3pnNmFrTEN2MDY0T2RFQ2kydE9LVmZDMllDMEdqaktS?=
 =?utf-8?B?R3RMdllPUkNYWGxzbUhQaGM3SXBzSmtTVElNZ2pwbVFuSVlkN1JCbU5RenNy?=
 =?utf-8?B?Ri9YL0xFbEZLSFhCaUdoN0o3VDZ5YmNLWjFvN0kyaTkyYjBQNVV1bUdtbmpu?=
 =?utf-8?B?TTJRdXFYWVJyNXFScFgxQXFPZEZtNmdwR0JSNHZKZFA0MGdtQzlmNG5RNW1G?=
 =?utf-8?B?WnFPUmx1WkYyb3VDWGo0STBmVzBwSGduS0wydmJkOU84REs2NFlMWHc1cDRI?=
 =?utf-8?B?ZEFxRlV2bUczR0x1MmUzUXR3RkFTeG1TSVJFcWIxL1RFUm1NWkdLanF0Q05h?=
 =?utf-8?B?c3ZlZWMzQXFDOXlBU2gvY01PazRVZHlyQjljYjBoV21VNFZHN1UwVkFTNVpG?=
 =?utf-8?B?K3dZcVNMNHZpM0NMb3A0elJtUEJRWnVldHBVanVXbVVJSzUvWkpmc283NUVa?=
 =?utf-8?B?ZWxteTFGbS9RbFhBMWpnTXB2alRkcVdIR2cwM2N6SEtDaFNidzZXZUpCcVFx?=
 =?utf-8?B?alBkeWMxNUdUUi84VHUyOFk2NWJHU1l4TkdPYlh6OFVibFpKM3hMTmN2U2lu?=
 =?utf-8?B?R0ZoUGw4WjZOR0wvYVg3SUFycGwzUGxKeHNLZStSL2VkVmJOazNUTklHVDky?=
 =?utf-8?B?Y04xMU9yV0tHcElBUlVhZG9WZnZQbVZEbzl3TXczdHpjcnBuMjhqN3UxNTFI?=
 =?utf-8?B?TWZmdUJuS0VxM290eVlUL1hOajRVcS8yY081S0NjMEJJOWlrUW0rYkgvM2JH?=
 =?utf-8?B?REhLMFNjSnJreEZJbkN0NENSbDU4NTJXRTJKNUhXMlgzM1VtV1RLUXczL0ZB?=
 =?utf-8?B?S1FCWTAxdjhQREZzWDR4REkweG0zcXNhUnN5S0xlU2xDSkJKRW9hckZSZ2xS?=
 =?utf-8?B?Zlk0ZmttWWVmQUJxSWthbU5DQWdxS21IRHAyTWZSZE9vNWJuSGlnWjVrZ0JD?=
 =?utf-8?B?MzNiOTc1YVFnVFJ0ZlNUSHNGYmxyYUVZN2hjdzByK2xWNFROa1VZUnNPMU1j?=
 =?utf-8?B?YS85ZHVaZkpXTzZTb0pwM2JUUG5ZcGNzUGo0azRMNmF4QzNBOWhSMzkzTzJs?=
 =?utf-8?B?WUpOa29NOXRyRFhSeWg5L2hidFNrMXhVbXlXcTZ6Nno3dzJUMGRDTUdYaXRT?=
 =?utf-8?B?dG9iY2NQTmNFeWxlZ2V3WTJ5K2dLTHdKU1NMVndtMTkzNzY1VFFWSnJLOHl2?=
 =?utf-8?B?c2VoSjBGVW1uUnY1aGk0cVNURHdXejFFWlhwaFFjUW15YnI2VXdmaVJXZWo4?=
 =?utf-8?B?RllBWVBtMkh6V3BHck5lM2F5NjQrQytBd3VDbnUwelkrd2RwbmM1Y0dZNjZG?=
 =?utf-8?B?MnZNQjNxU1p4UnA4Wmo4R0lCRldBSTRkVTdXUU5MeWJPZlhoS2pOQmxHYmlK?=
 =?utf-8?B?M1JFdkVUN2VmWEloWC84WmV4Y1JVVCtQeUhBVlg1N3FLQ2tRYlFxR0FUb0NJ?=
 =?utf-8?B?ak5YUDNwcTJPZXMrRzN0QUtWeEZJQmcveE1kQXlRQmhzRXVSb0FvQUZQWU1k?=
 =?utf-8?B?T1Vybkh6a3BaVG9SV2kwcnNzcUtHNktlMEdSbys3ZUFTYTFkNVZtL3Rqc05B?=
 =?utf-8?B?OERLQUhaQzVLQ3IyWkJLdHBSNmJGbVIwRTdjb29HbkdnSk9scVlJVW5SREE4?=
 =?utf-8?Q?R5yFMAzSmnkEsi2hK5LuSQ2M9fM1Ew/u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WktBaEdzRlBhai9QMXZOUjIzeUxObVJNNlRrQjJMcGRsOXViT1k1eGVIZmFi?=
 =?utf-8?B?VFY1S3hLMFFETExsL29hVjZMeXlqRHZDVHVIV2pwdFR6dXRSc01nOUZOWlRa?=
 =?utf-8?B?MXBEVU95TXJlR1JyeEMzNG91QXRhNHdNSVA4aWpnbnlBV3UvcFFFSUlKeEJW?=
 =?utf-8?B?V1hJUnVJQjBPM1Q3ODIwYTZJRGZFdXN5K2wyZFBPN1htRFV1Q2NrQU1Kb0dV?=
 =?utf-8?B?RzVJK2ZpYTYvTGdUK3J2VjBSaDhISVR0RnFZQkFuc0FZRTl0OTdFMnNLdHRT?=
 =?utf-8?B?UUVlWDBzL3k2VkF3Q0VQeWVwSG1lVGRteUVEOEwrYUkvbWRSVHhhVHozSVNn?=
 =?utf-8?B?ZDZ4em5WSWY3emlYcnBMUk0xbmpkOURyNmtORmc5d0pKWWxTU0RtWVBGSjBL?=
 =?utf-8?B?UTNQbFRFNDBUanBSaFZ3Y0txVEd5ZTZsWHNhVm5TUU1XWWRxclBKM1FsZ0ky?=
 =?utf-8?B?ZU14aUtTZ0V5amRQazc3U0hSRHlkLysrTlRVK0N6Qnh5M0hiTHdqQkpVeGV5?=
 =?utf-8?B?Z09qTUZweGlxdGNKZWZUaWFSd3dPUFBGRkIwenppTVdlRkJaWWUxcEVQTFA5?=
 =?utf-8?B?NW5sYTBIRnA1YTJadDRDMWJJaFpmT2h3NHVxelBIaGJ5bFFXMjRSckFYZ0Z0?=
 =?utf-8?B?TUFzb2Z0bFFhSy90YjFNVW5zYUtsUEo0U1pSQWxpbnFnSzA2cFF1NzViUkVr?=
 =?utf-8?B?aTJ1dUE3a1QvOHZQeEFpdkl3eElrcmZQVGhzZ3cyclFGV080OUllczB1VXl1?=
 =?utf-8?B?a1R5bzlCVjUranRiN1pnYk9HcU84bFJ3TkhaY09UUVg4eUFEcWIwOTlOVWJ0?=
 =?utf-8?B?dHRKZ2lFYVRkUnBXcXpTM09GUnpLYlZ0L2lpWmttaUd2RTEyZVo0ODhUVnpX?=
 =?utf-8?B?YWY5YzJqOWpWYXVSMzREaFhLaVM0TXNKVzczSzNhblNoM0JUVVdGY1llWlVs?=
 =?utf-8?B?SFZ1VngzYUFadzJjc3dtcDhoZnQvS1R6RHpJY3hQRzlJNDFQSklxOEFyNFdm?=
 =?utf-8?B?QldETGNOYWpCcU9TUGZVbnRYMVR3VEZlbGZJUGg3Y1hXZEVDOUFYZU5nV0tW?=
 =?utf-8?B?VVZKd3ZXc2h3U0VDRDMyeDF1a21xR09VNHhqUUl6UGtmOVhWQUdzeGlPazVN?=
 =?utf-8?B?dGVkQ0pHenljNlNUQTdrWTZWWGhTRGRFaVZpQmpUSWl6Z0o1Nm0zZjNvMGRH?=
 =?utf-8?B?YTBqU1ZQM3Y5SWxGMUoyNzI4TTJrWjZoUTg4VUUrTzV3YUxBdi9WandmSmMx?=
 =?utf-8?B?VkRwbFF0Y0hHN3Nhei9VMVFJT0FTYWJVMEJ6TGdnSHdXZ00xWm5BTTFBQTh6?=
 =?utf-8?B?cDdvdkNVZ0FsT1FzclZEbFN2MkxUeEtlUU9JYndQVmhnR0dJaVc4UUFCTGhh?=
 =?utf-8?B?Z3JKYmdtWWN5UCtHczA3SmQ0TjlETUtnUnl4NXI0cEcvVlFsQTZrNUdHMWpY?=
 =?utf-8?B?OWZzT3IrbkNrelRWWWhrZmRpNHZuUFhRV0taUitMUjRtb0h4eCt1NVh1R2lm?=
 =?utf-8?B?REtkaWtBUlp2RnRVL3o1TTYxdnFac0kxa09UczM0YTl4bm1DaTJGVHhqZEkw?=
 =?utf-8?B?N0duSVMwMDhrZCt6dlo5ZHJ4Y1VSNU4rVWNGRUphcGpCZ0tyQjFncnIySTQ0?=
 =?utf-8?B?anU0MHNOaUtqc2h3cWkzdDc3RzBvanlESzdMT3ljMURHTWhZTFlRdjhRTG40?=
 =?utf-8?B?ZDV1UFNzakpyaEhFMFlMUzFyM2IzVFk0eDYxTTVucWFDb0ZmM2RlaUZNQThI?=
 =?utf-8?B?KzJaTkgrOVFvUkFRbUtua2FzRnQzV2gvSEFDWFVSNGQ1WmpmamhjWlRjOHpC?=
 =?utf-8?B?aUpaMXQ3azhQa0xvbyszcXErbTR1em1jeExWUmVrdmthWnlvRmE0OUpCcWUy?=
 =?utf-8?B?cEdHbXZtMEI2R1p3Z0VpcWpNMmRoNzNxMFVldzNxM1AzTngxbHczVXJSaUt6?=
 =?utf-8?B?Q1VMa1JXdHZjTE5JaUozVXZUdldpZlJpeHZqVnk2ZEFOZFFjRGc1TXVVZkw3?=
 =?utf-8?B?UjA2Mnk5bjR3N3JSTkZTMUU1ekd6djVtbGJnb0E0bmRPZzF0RXZMS1BJU05H?=
 =?utf-8?B?TEh0QmZRV1cySnZ0UWZReHQvdE8yeW5XN1ArNER0MlpaNFNtMWhKSlAwV3pF?=
 =?utf-8?Q?OVjjvz886E3jsqCFA6patbdY+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38405408-a8c8-48bb-787d-08de10b6196d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 15:25:43.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrnXiEok1i9jUU/5OADB7VUXpAlxj80UTASqeWuRkCe+mRgJX0mL8gReMjt2sa/DixJNUh7UfKsPxAWZLS9HYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8805



On 21/10/2025 17:54, Sabrina Dubroca wrote:
> 2025-10-20, 10:05:54 +0300, Tariq Toukan wrote:
>> From: Shahar Shitrit <shshitrit@nvidia.com>
>>
>> When device loses track of TLS records, it attempts to resync by
>> monitoring records and requests an asynchronous resynchronization
>> from software for this TLS connection.
>>
>> The TLS module handles such device RX resync requests by logging record
>> headers and comparing them with the record tcp_sn when provided by the
>> device. It also increments rcd_delta to track how far the current
>> record tcp_sn is from the tcp_sn of the original resync request.
>> If the device later responds with a matching tcp_sn, the TLS module
>> approves the tcp_sn for resync.
>>
>> However, the device response may be delayed or never arrive,
>> particularly due to traffic-related issues such as packet drops or
>> reordering. In such cases, the TLS module remains unaware that resync
>> will not complete, and continues performing unnecessary work by logging
>> headers and incrementing rcd_delta, which can eventually exceed the
>> threshold and trigger a WARN(). For example, this was observed when the
>> device got out of tracking, causing
>> mlx5e_ktls_handle_get_psv_completion() to fail and ultimately leading
>> to the rcd_delta warning.
>>
>> To address this, call tls_offload_rx_resync_async_request_cancel()
>> to cancel the resync request and stop resync tracking in such error
>> cases. Also, increment the tls_resync_req_skip counter to track these
>> cancellations.
>>
>> Fixes: 0419d8c9d8f8 ("net/mlx5e: kTLS, Add kTLS RX resync support")
>> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>  .../mellanox/mlx5/core/en_accel/ktls_rx.c     | 33 ++++++++++++++++---
>>  .../mellanox/mlx5/core/en_accel/ktls_txrx.h   |  4 +++
>>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +++
>>  3 files changed, 37 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
>> index 5fbc92269585..ae325c471e7f 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
>> @@ -339,14 +339,19 @@ static void resync_handle_work(struct work_struct *work)
>>  
>>  	if (unlikely(test_bit(MLX5E_PRIV_RX_FLAG_DELETING, priv_rx->flags))) {
>>  		mlx5e_ktls_priv_rx_put(priv_rx);
>> +		priv_rx->rq_stats->tls_resync_req_skip++;
>> +		tls_offload_rx_resync_async_request_cancel(&resync->core);
>>  		return;
>>  	}
>>  
>>  	c = resync->priv->channels.c[priv_rx->rxq];
>>  	sq = &c->async_icosq;
>>  
>> -	if (resync_post_get_progress_params(sq, priv_rx))
>> +	if (resync_post_get_progress_params(sq, priv_rx)) {
>> +		priv_rx->rq_stats->tls_resync_req_skip++;
> 
> There's already a tls_resync_req_skip++ at the end of
> resync_post_get_progress_params() just before returning an error, so I
> don't think this one is needed? (or keep this one and remove the one
> in resync_post_get_progress_params, so that tls_resync_req_skip++ and
> _cancel() are together like in the rest of the patch)
> 
> Other than that, I don't understand much about the resync handling in
> the driver and how the various bits fit together, but the patch looks
> consistent.

Right, thank you. Will fix>
>> +		tls_offload_rx_resync_async_request_cancel(&resync->core);
>>  		mlx5e_ktls_priv_rx_put(priv_rx);
>> +	}
>>  }
> 



