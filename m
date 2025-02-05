Return-Path: <linux-rdma+bounces-7416-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2CBA284B4
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 07:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE256167236
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 06:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE823228386;
	Wed,  5 Feb 2025 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rZCR2GXu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B12227BB7;
	Wed,  5 Feb 2025 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738738596; cv=fail; b=s3IIeyU8PI/dW7g04l6QGJnuyUXX0tH4PFU5jgaLKdhOYd8n8Et+xC1qobPAMjOoTFvnc5iVVom+EV2n2M/rnTSWgzWTNydr3Sf2AaWOYRPFNDu9JnJuv3ovGb4DtDGMF1BPlMQCWx9b/Tpi3dk2V8eSejNhnsYfI5NrPHdC4DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738738596; c=relaxed/simple;
	bh=bZ10zQ13zlLHOfqZYF3+TzKCqqttnJw33uynfMplzow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DgdeBIp6AubWnOTijQGzsR2oPKht5bDrNuWxFSF0zf4qJjRMsmqq+InniwqpKbWxaN1fGA0+TiF76jzWOTDiE08+IJthTYnj40AlWCwMak1Nun3Xw+Zd1BH4YftLNS//aaXnQ1e51SZ088nTiUjmigRemRzu8Oj/uoVoTySygAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rZCR2GXu; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLssLUPvujOBGFqFWudBoQjC7/XZyUgZepL7uzYLuykwkaIHn1v9NuTZexWDDUcCX6OCkccUr4TAg82irD1Zfyg4w+TVVgqI5TTtGh/3X5L2EeL0Za6baEJe7Q3TrYjuth/wXNlZ/95jtg+jnZ18H+3NulUnNqH6sT31wlIZui5w7kWKWDvTpvrms/9y6Cc6RCRQ2+YGsX0+eBz6GVX9/9hqCbTM3nrqkQJD2VP7u0LccG5RThb9skU7YT/tRGi5bj9lrKMRVX4N9jvMBrfVM2wblmbhjiz4GnTnvCkw8+YWm/xywz5R6dQop1WWDJgRDmLje4Rm1gnt3lUfm9xxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITIZAKnqKb5IoFlG7iJ4VHNIZ6hY8WFMw+uR2v/lfsQ=;
 b=bayCCsJ1tr3RuNb9D/LZueaXk3eB9+LeERdjTf50dIjZxNrNGfYp1xkWNqWc8F/s4vRlAePVOwp8CNRsm3+/PSrdDmd/biTZ1gYSyjIwVA9UkxIoQaDKB43Xy0v/9nzusBu7r6Xxg5j+6zagfmzS/NFfswFFmRgAQkyStsQbx6i6/K4sC7oVyMljjinthY9LPT3Ikf5xsXel9i7wt6xQi57AYgCCU4+VQuC8jE3BarycBkNvZvm18ulAHABvw5PmSogD6a/F7sg9Cug2Mj//nXY2DqBG+Ttxl/0DznbDY7qNf4H9iEOzgnaktmVXc7gUyj0OjCuG78/We6i8XJLLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITIZAKnqKb5IoFlG7iJ4VHNIZ6hY8WFMw+uR2v/lfsQ=;
 b=rZCR2GXuiEEf6fLkBIzqQRA6S5ZN+E65ylOP9SuzJBNNZEXzH89hCsl5tGT3SUBAzfYs2HPYG7UW16ZQmsJvpsCeexzSK2LhnHrowzhQXiY/7QfDFZ0XWDZbjgnBCVIMpSZ4N9uujY9hrmCHZLvkV2SF/I2PfGLS+dNnhnGYsxL5AWCHt5Lfj49Z94jifwx41zng+1Ncc70Ue/lIbHrOkyqIkQU8w8h1uY9wez20f4Je8y6iScM4ctspXqCWtCbY1SL4kTDBCEzsRbL8Xn2+AWkUV85VRghZHKvo4+QgF1/VgtnMSoMRH0iwTc1WKtLJLqHPXnoYl+2m4cECB1Gt9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CH3PR12MB9314.namprd12.prod.outlook.com (2603:10b6:610:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 06:56:31 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 06:56:31 +0000
Message-ID: <e1bc347a-a705-4518-a826-3a90c4c61f9a@nvidia.com>
Date: Wed, 5 Feb 2025 08:56:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V5 07/11] devlink: Extend devlink rate API with
 traffic classes bandwidth management
To: Tariq Toukan <ttoukan.linux@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Carolina Jubran <cjubran@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, linux-rdma@vger.kernel.org,
 Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
 <20241204220931.254964-8-tariqt@nvidia.com>
 <20241206181056.3d323c0e@kernel.org>
 <89652b98-65a8-4a97-a2e2-6c36acf7c663@gmail.com>
 <20241209132734.2039dead@kernel.org>
 <1e886aaf-e1eb-4f1a-b7ef-f63b350a3320@nvidia.com>
 <20250120101447.1711b641@kernel.org>
 <a76be788-a0ae-456a-9450-686e03209e84@nvidia.com>
 <8dbc731c-2cff-4995-b579-badfc32584a1@nvidia.com>
 <20250122063037.1f0b794a@kernel.org>
 <0f3ac6e2-80be-4df2-9b4d-61433549cc2d@gmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <0f3ac6e2-80be-4df2-9b4d-61433549cc2d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CH3PR12MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a163265-ed68-429e-2392-08dd45b2382f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGFvV3FRdUQ4elBhcjE0NmQvenhJQ2grSTNCTFNibXBHQmlBdEd4bVR1MGZn?=
 =?utf-8?B?NHpxVEZ1bzZXdi9BamMyZVRiY3pYa2p2bkhVcDh3VjJmb2ZaTjNpOGdMdi9a?=
 =?utf-8?B?ZGVRYWFiN2piNWUyS0ZiZWMrSjJyWWZRUnA0eU93OFNxeEd0Qm5naytVamgr?=
 =?utf-8?B?TUJmeW51eE5ERTAyTEl4K1hrb3dJS0EveWdocHRWYytVY2JUTnBXMG5GT0VQ?=
 =?utf-8?B?V2psY1NhN3ZxZkVUUE15SU5QaVBVWWVkbXhiWXQ0cDNEaTZMOHpCamhNNWpF?=
 =?utf-8?B?a2hldGoxMGNOYUN3cWNGV0NIYlJMMmkvdVMxSWVpV0V2eEZCemhYYzRIYlU4?=
 =?utf-8?B?eStSSHFXRGhld1VqanVxd1UxQzVMR0FLSlNGK3A5TGRrM01wTDlUVHVCRDVi?=
 =?utf-8?B?VXlNQUxVNzVUZUN2aVBxcWlQZGVGVGc2cy9aMEIxd2twbk5OWnJ4NW9mNERj?=
 =?utf-8?B?cWRKOU1uR05rQi9iaDRQNS9hVU9WdEVQU1cvNlphUWx0bkJIU2ZXTmEwallz?=
 =?utf-8?B?SGoyNVNNTXVpS0F0UlR5VHhLVDhoVlB2Vk8wWC82SXJHUWJFYmFRMFFzZ1hX?=
 =?utf-8?B?WFpYL3p6SjV3bkUyMDYvdTQ4Wk5POG9xSk9kcGlETVFPa2JDbGNDUDMwODdl?=
 =?utf-8?B?U0lzRnRkRFZJc2oxRjBDR1AxOXdjWUhpUyt1U0haNzRBWTgybFhyYWh3L1Yr?=
 =?utf-8?B?bkt2QkhlaWNJNkdHci92RzlHVTAxbCtjcmJZbHVONlpOTHVSU0l5NC8rbW5Y?=
 =?utf-8?B?T0U0cVU3MWNmWCs2bERjQldPeGtXcEhvc2NNZkh1N05RZ0kzNlNLbWJuNytx?=
 =?utf-8?B?c0xKekxNbUttbnoyNC9Hb3pEbDFpM05teW9aWldNOU1aTGxCV1pFc2RZSWJB?=
 =?utf-8?B?N3RZbjJ1WHNveGV0Sk9WV1FEYkhSaFM4WVUzd3R3ZDJKVnl2NUtrZkQzRG9N?=
 =?utf-8?B?cDIxY2hJVEkzQ3psTUZCNTdFN1diTTgwQ1NSVUVWTHZvbUxwcm9seDA5bEJZ?=
 =?utf-8?B?cjN6Y2lpZUgvWTk5YVN4YWlCZFlsb2ZNUlI1cVhrQWxPc2twaW0ybjZmS0ty?=
 =?utf-8?B?aE5pNndSU0NhamZKVHJkbm1iRHZtSm5aZE5ucGYrSk9oV1FXNHJIWDZSQWJE?=
 =?utf-8?B?YW1ocHN5d3RYNEpBcWRROVRIUUl6UTI0UXgrRmhJTnFzOVVBQWdXNUlmY1l1?=
 =?utf-8?B?eWN4R3NkQ2hQNmFPNVNMVWF6aG8xbUlueVhOZ3NJZFlDckRHNHFzaHZabXl6?=
 =?utf-8?B?MDV3OEluNVVTZmpFNEFuRUZTanlNVGlmdDYyRjFZRHZOZkhhTHkxL1ZJUEJh?=
 =?utf-8?B?VFdZMFBpeGU1cTFuUWFQdU1USUNuNCtZcTNOeXhZaWY4dUgzRytOb2VEcEJO?=
 =?utf-8?B?VC9QTGQxQ0NtTmYzYys5MTF1ZEVCM3M2VnNLSTdMcjc0QzVjRllSNzhHZHpO?=
 =?utf-8?B?NE5ESUxMV0xKZWhnWEh4dFMxNEpFMmtmTGZkdnVRSjVZWE0xL0htOVJnSUtU?=
 =?utf-8?B?VDhNK25pR3JSVHlPTlVCSTkvd005NTlBM1lNNXBhbHB5dzV5OW01enkrU2Q4?=
 =?utf-8?B?VXhXVFU2cmRWZ3MwZHVhNGw4NHRYakxJcFp4ZXBNaGMvUmNwOWg4cWVzazBE?=
 =?utf-8?B?Y2kyZUNIZUZNbm5NSUpJSVVMSk9sNitXYVpUb2dxdFdDMkNiM0VlMVNpLzcw?=
 =?utf-8?B?bWRxVEFLOFRCTHpXRWlmZ2ZLMXYwOW56V3cvdUUwL2xFelNaV0lVaUFkdWpY?=
 =?utf-8?B?enJsanM3bTg1bmVCTStTVURONFc4SG1HYXk5NEV6eDFTOUNUeWgzTDc4bnhG?=
 =?utf-8?B?STRFZnBvRmwvZkNoQzZsRnArYzZoREZWRXpIaitkcFBma0EyVC9jdTJNUXpM?=
 =?utf-8?Q?TnNyCUcno5/ba?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzdORnV2SkxibWxZZkFTR0dRNXkrZk9aUXZMenZoM0gyaW9MUEw0T0FHQjYv?=
 =?utf-8?B?ZjN4Y0ZzeG9kZzFSQWEwZlFPTEhkbGpnaG9vRm1SL2ZQTERPWkxyM2ZoMFBn?=
 =?utf-8?B?YWNXUTRVb0g0MjRWdk8ybUUzK3Y5MWNXUlF4RHd2UlovV2RaRzBTVnlXd1hi?=
 =?utf-8?B?YXc1VUNSVVlja3dMMEx4N0p0SHhCQW9TL3V2YXFzWGJGb3hVYWVwRHI4cmRM?=
 =?utf-8?B?TGdIL3cyTlVJSmpKekVzK3IzTkxQenk2Sy85bzRlaWNqWk1wSHoxdmF1akRi?=
 =?utf-8?B?NWFuUDNya2hwdGNBTDl5citMNjlNWVlWMUxSOFdjZEdlK29BVks0NEo5VHRL?=
 =?utf-8?B?bWtGekk2b1RMdmhaUjYwc1FQV3NpNFlEZS9ta25WQVJ5TVJtaTc3WGV6Mldz?=
 =?utf-8?B?T0ttanVPMXJkb0tEWWROV0dBUnZZMzh6cHdLTVRNZW5uN3M3d1FhYlZwcUZO?=
 =?utf-8?B?aTFkM2NweG5OVzlOcW5mMUNQMFozN29sMGZRS1RSdjlCRGlQaHFWMUdzaTBu?=
 =?utf-8?B?dzVlcFkxcUM1UlVIT0d5WUNaS1BBOTJIZkY1R294VFJZUnpSSG5GbG1WSVU5?=
 =?utf-8?B?OUoyV2R4bHU5UmtlTzRqeGJ2TEEwWEtqSS9kb1lhOEFHbmllVkJISHhiWFBD?=
 =?utf-8?B?WVljMGNpMDR3dkkwclVYK080cGkzcmNUSW5SVytRZHFqWXpicG9xUFZ4OHhj?=
 =?utf-8?B?NHpJWU5LUm9VWWE3TzFjYzdwK0h0OXU5cUFjV05JTCtmZkE0b3doZnhNbk81?=
 =?utf-8?B?VFVJTitqZzlhTWpVL3U5WjgrTmhOd094cDZYMkxGeXQ2QnFUY0FpOVgwUTd1?=
 =?utf-8?B?N2xSVjM4YW8wQmdwRUlHNkdyZlZxa0ROUitqZUdMR2J0Vk1PLytxNVNxRzNV?=
 =?utf-8?B?NktuUUxJVVBqait4cmRGMmhJLzdNZDkvZUoyRGFqRDBWYzdRUDZ3MlpScUlj?=
 =?utf-8?B?bXhmNC8zd053NVYxdDAvdVZ3RGh2dDhuSjE5bDl3Z1Jmc0ZQTFV1NlJBaHpG?=
 =?utf-8?B?eXUrQTFtZHUwamxsZmpDdVlCM0V1dlprMXlvK0Z1eW5vMmI5TzU2QWNCZkxo?=
 =?utf-8?B?MFdzem5ESjlxL01GRmZtMHk1TVROb1dYQzAwcXFiWnFJTGUxK0Q5VEdNVzhE?=
 =?utf-8?B?Qkl2TFJ4QnRjYUYvZWx2eTdoMkdjOGZ6bzcrMFYwWWhJN1M1Z1hiT0JTNk4x?=
 =?utf-8?B?N3luZXZPakRQV3N4bDhPRUwyb1U2OG9lWHZnTW1YdFpBR01BY3FsMFJYdXZY?=
 =?utf-8?B?Z0pVZERTVnRlaVdlb0NnMHlrS1NvUkp1S1FUQVFlMjBqVjRFUFArb3R5bmJ1?=
 =?utf-8?B?aEcxb2ppazI3T3JZTWNNRzNtQ2ltSUh0UXZjaldwRGxHakdxbDJaZGdtRXcv?=
 =?utf-8?B?cXc0WTRYeWVPbjhocHptZXdHRlJWRks0am8wMUhqZVQzL2s3MWlzajM4Zzly?=
 =?utf-8?B?SnhISmtFNWY3L2UrVDVwa3IvWVNDVHhNMFIrWEcrRk1Fb1NHczRPN0NzRk9y?=
 =?utf-8?B?aVVkS1hrTFQzTHdXMmxBNHBhT0dZam9Uc0ZkSkQzZm5Ecy9KdnZaN1BVN3Jv?=
 =?utf-8?B?czBlRXVvQ0VOY2hYUGdmaXFNM3N6OW9pdXV3ckdzcHZoeW9kZGhENTRsVFlQ?=
 =?utf-8?B?VzNxY0xSYnAzZ3grdmtRU2tURFIwaGllbDJSdlJOOFUwRUpvVzR0ekVhbElt?=
 =?utf-8?B?VGw2NWRmRnd5NUYxY3Y2RVhTTkYrVmFINE9LM3JiZXRwMkZXTjIyYVFES1Ri?=
 =?utf-8?B?Vy9YWTZvd0txVkl6VFpLL2diNWYxVCtoMEVGNW9vdFBQQVRkTWtCNi8zbFJq?=
 =?utf-8?B?VmIvR1pjT0EwVjZrY0w0N0NndGVsMVZFbjNkU2JvbmFDOUM1VWJRdmhWazBT?=
 =?utf-8?B?UTBCeGc1MTdEeWJoUkt5MG54Q0JzemlqU1pGeExjb3lsbSt6VTRoZjdGVklt?=
 =?utf-8?B?aWpXMnd2VWJlU2NJTkFFcTNMczMvTWtqWUNMS2FzRy9YcGcreUxLWExRVjUy?=
 =?utf-8?B?TGhZaWplZ3lBUSsrQjR2TlZxdC9HU1JqRG56emppMFFxTXQ1L2ZHN1BMQWlS?=
 =?utf-8?B?QkdYY0lVVUJSV3RaVEh2T29COW5uSVlITHBmVVNGREtvL3JQdUI3QUpmejVy?=
 =?utf-8?Q?XqQigZWRDURILyCI6a+pjKH5U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a163265-ed68-429e-2392-08dd45b2382f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 06:56:31.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcDH8PAGhaRdAY4bla278o+f85JNa3YzdtWBTLC0r4pVLcV8FBddTrvqPhB8DQRD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9314

On 05/02/2025 8:22, Tariq Toukan wrote:
> 
> 
> On 22/01/2025 16:30, Jakub Kicinski wrote:
>> On Wed, 22 Jan 2025 14:48:55 +0200 Carolina Jubran wrote:
>>> Since this worked and the devlink patch now depends on it, would it be
>>> possible to include the top two patches
>>> https://github.com/kuba-moo/linux/tree/ynl-limits in the next submission
>>> of the devlink and mlx5 patches?
>>
>> I'll post the two patches right after the merge window.
>> They stand on their own, and we can keep your series short-ish.
> 
> Hi Jakub,
> 
> A kind reminder, as we have dependency on these.

They're submitted already:
https://lore.kernel.org/netdev/20250203215510.1288728-2-kuba@kernel.org/

