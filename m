Return-Path: <linux-rdma+bounces-6582-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FA39F4B48
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 13:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C51F1887E84
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 12:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05221F37D9;
	Tue, 17 Dec 2024 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UbBfDg5n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9A41F238D;
	Tue, 17 Dec 2024 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439991; cv=fail; b=Ai0d5CFkFA3S5Pt2L2waz6EObJTH1pvS2XkJHKHvH4nzc/7GPpyWp4ukBIJp+GmLsp9VO5Sntvl8jKZWD67WGh5RRA9yOFv0rG4z1USzmgkC3wbZ0Bzx1UKm4GgX1DIMVWC8ILeS0Uq5LqPDWFf8rHIV1setI4PAu5m/1MzYJSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439991; c=relaxed/simple;
	bh=PlenLvkT894SSmnQAzSl9EM5ZIDPr3KAkJw/fdtILHQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=guEB7XdSqrtVj6qLXIRzwpL9e7T1oJB+ONLfb9UDfxyxCTACEu3ENQ4IMLe5oWew4b8WBkq19vb9ub0tcwsBUko+ZUgRycvJwfrzp7PSIuuHUkKVd98JFLaSHhiZpI/ukk0/fyMCZa1MAqM22YkStu6gNbJ5T6W2DZ4N4xPzHB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UbBfDg5n; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fc90/JY3ivVivOQ/rMnjiqpb6U2saa694yCStcZqtDxlK4SuKIYX0d8M6PYd5LlTHiS3th+Bx17kACY5pmQOHUd512/UrkwkKMy3N3gTaIOiEbKLLs7GwbsCN3oWh11ItwS5eV7xbd4LdGFpCNsmrsD7SxNJCmo7TC3nyYNhfQw+DolPWJ0OLGtLb6YMyZgxAr6FMq9kZjrzCjAWghDHHhOObaf4my13ptOSXTY8mLpVN5wIk/4/BmzePOBkUg3qUfIKc8YqIVuahO1F3Q3s36BYS/SBo6Yfxe8cdV4IS9TQkSrhyzpY6Ki9t6+Wm0DyB54L6CzBO8RlxLO/qi07DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXoiY1GUZB1lrpnZ5aOqvFMlsSvo6lgU2WcFVhA+Mgs=;
 b=T3FOMqz5i8yhSDaw1GH2mwqd2rz8ReHmP4ZLdg6gLqUn83A7AhUHzYNWCw1itjk/2muXG9E06SO8lNB/Aq1uelkvBdFScsug1SL1XKblWIvN677VN1bL8eoXYQbFbnuJvFoqNX04yhj0j0dn1HKup4wxbShSk4YObwAuQByZY/hkIytId/vGgeT/gldCGFzazkkmuPkj837925SdpMSbdwPUMHcRbhWC9kU5cYA5xmjkxVfauFSKsTgzfxZgyTbozlyzhe0myW6ioLhZWY68dm+RCf1Yd6pmn/6eUCukCc9TDAYCvHZtPAai0Qk0XQA0IwlVyqhoK5AS4fCBoUGO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXoiY1GUZB1lrpnZ5aOqvFMlsSvo6lgU2WcFVhA+Mgs=;
 b=UbBfDg5ndfsxm8NkC2fOwEPwmepM6vS6XkPb2QlviDNPc1jUj+RgQwg1HqHMUiIuELYdA6+T/aOFMyzSI7ArQQrFJpDx7Pp476X9L0vBBw6NweMQwvFDSQTbY+lmQ3wM8xgTHOp18akxsNDB07XWlLiRFMp4wbV1zYhicGuVmh2qxtIytCsdH5xlNu7ovBBEwR0fB3EUwvFDlzqmQzrTjuT7NljDy+c/jd+iOOjhqP/w0VkPI0XntQWMCZrW3hBTWfXPmZ+b49LIhowCiauPrIB0Hu863IdcdOl60iA2+NgupXbRDuZDewhx/6IeJOGZbAXZ3DBVYNOhxkePd0Cseg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.21; Tue, 17 Dec 2024 12:53:06 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%7]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 12:53:06 +0000
Message-ID: <624f1c54-8bfe-4031-9614-79c4998a8d78@nvidia.com>
Date: Tue, 17 Dec 2024 14:52:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/12] net/mlx5: LAG, Refactor lag logic
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 rongwei liu <rongweil@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, linux-rdma@vger.kernel.org
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-3-tariqt@nvidia.com>
 <93a38917-954c-48bb-a637-011533649ed1@intel.com>
 <981b2b0f-9c35-4968-a5e8-dd0d36ebec05@nvidia.com>
 <abfe7b20-61d7-4b5f-908c-170697429900@intel.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <abfe7b20-61d7-4b5f-908c-170697429900@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::32) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1ce9a5-56f8-4fe5-a1b9-08dd1e99c02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDZ2bWVKWnI5dEVLSEd4YWJtNTdMOWRrNUFMZEc0Lzc0MVpPV3ZQWm9rTytM?=
 =?utf-8?B?TGx2VXU5Qk5JNm5MTWdkc0tOU3JSYUdsZ1VSSW9tdEFKNTIwUmwzZ1Z6Sk1B?=
 =?utf-8?B?eXdTeWJBekVRNU81UVdNbDlxZEo3TG5UMzYweEZrKzRtRjN1cUNCM3RCUk44?=
 =?utf-8?B?Z1hQeU5FQWw3dFV0YmozQ1FFMzhiYmthaFA3Y051SmpWZWhYLzN6a2UxNkk2?=
 =?utf-8?B?emZ0NHFxU1VnSHhVNFl5bGdFSEs5RTlDUmVLUm14VWVyYUZTd0lLaUZlN253?=
 =?utf-8?B?Ym93eHR2KzNrTkppSVlJVnZLZWJFR2dEeEMxU2xpYThMd3hYa2xQdUY0Qldl?=
 =?utf-8?B?T08zUkU5VTBuYmVJQWJtTUVad1ZDQVg4SmYzcCtMSlRHa3N5S3FLcXVwQ3hJ?=
 =?utf-8?B?VzNjUTFvbTUrRENnYUFyWEY2T2VKOFkxaDArUExuM1BKb0h2Ryt1dVQ2T2V3?=
 =?utf-8?B?Z2ErckNOM2FPSk5Dcy8wVmtCcHJ5OFBESzdXWTdJeW1BVkh5eWI0NDBFZnZY?=
 =?utf-8?B?dEZPSk5RNFdtSnFzU1gzalRVTEE0QWhuSDNiZjlFSzQ4ZWxONmU3MGpRR094?=
 =?utf-8?B?emJYK3lFOE9LTVVTRHNwMmlDL3YxVFMxUVpvQVNiY2RZR3FkaHY4WUU4WVA2?=
 =?utf-8?B?eGFlV2hCcEtPcDM4cDJmS3JtYVV6UzZLeGRIUDUxY3FMUE1yYTN3U2FLTDdv?=
 =?utf-8?B?bGRySlo5TCtla0l0QkJ6cmtOdjI5a3VJenkwbEdJY2tqN1BDOHZZVkhkT2FR?=
 =?utf-8?B?QU8vOWExdlY4bFpoWFVQUWV1bnlGSW1RLzBTWnRoZ3VFQnVJM2svOExLRHY2?=
 =?utf-8?B?UGRYZzZjcXNXTUR6TStCRWVYWjZCYy9PUit4YkpFSUdWQ0RvaUNxVG5yb2ln?=
 =?utf-8?B?cjVFODd4YnlqTm1paEhmdFM5S1ByZW9ySTJ3ZEwySWNJMjQzLytPN2xZQnlk?=
 =?utf-8?B?b1pST3ZyU0pFU1JTMjN0U1NZUktPNE1uUFE1NmR4dlhvSkZXSU5EVURVRHE4?=
 =?utf-8?B?Z2dPRHdPZG81R1NoYzBydXY0bXJoMk0xeWJQamhtWlBhL2tOOVdNWWdaaXVK?=
 =?utf-8?B?VzNOclBrcEZpZXVJeVIrRzZ0ZFNzZkszdVlzM1ZML1E5MW9rcVVmNFE2VStH?=
 =?utf-8?B?bWluNVhVWTFuT0FDY2kvRzZ2MTNtQ0hBUU5qV2ZYZWsrUjhkTy82bVF2QUZu?=
 =?utf-8?B?QVJGeCt4L1JMTzcva0UxN255aWVXWnRSU3ZiRHJjSkFZK2hFL01ENmZ4eC9R?=
 =?utf-8?B?RUFqRm9XdUQ0cVRJNnd3U1dya3IzdVdIZU5qU3hIR0MydEplaTFSTkxyb2l0?=
 =?utf-8?B?ZXgyNy92ZExSMElRa1lqU3FUQjFqUE93Y3ByKzA3U2NVbVJMNEQrelJmbUJF?=
 =?utf-8?B?anU1aTE4b2Z5S0VSWHZ5em5DSWx5RDhLbStvNEg1NHNxQ2pLQTh6MTN2YXFH?=
 =?utf-8?B?cGtqTXIzazlsUmZoUEJpQUhaRjNaajdFMEtBOU5uRnE2K1RvaGhqRi9VU3BF?=
 =?utf-8?B?V2xNVDV5bTk0d2U1dnl5MHcwZWpocXBpM3JQWE1zTzRGZ0RydXZqWFpESGRi?=
 =?utf-8?B?aEY0SmJxdTVIejNjM25xdjdSRElva09mZTAzK0pES3FIc21IY2l3cHpVQ0Zm?=
 =?utf-8?B?cHR1aVpRdFpnNFQvenBrY2N6Vm5xTjg4aXBwSmZPWVRiejN3eG80Q3EzZFlo?=
 =?utf-8?B?Tk9yejIzdjBwR2ttcTZrdDc1TERRZjArZjNlYkk3SmlySUQrNnRFVDVVdENi?=
 =?utf-8?B?d0ZQWnN5MjRySjVrU2ZkNVRqQVRkNHNuVWUrTGxTRDN4YmF2dEwxajRzYjRy?=
 =?utf-8?B?VFcvSjFUOFhPS1lMa1pKMTR3NEMzMXllTU5EY2RYb1lYN2lBVER1bGpsd2dL?=
 =?utf-8?Q?q473Ns57SfeW6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEx6b0oreU5lSlN4bk9OMktMeVJPelVCM0VhREQ5eUNkWitKak5zYVBmekhZ?=
 =?utf-8?B?ajYyMm1xTmRNVjg0cUozYmM5T292azNCT24zMG4va1BhVW5KcEI4cGdxRVM0?=
 =?utf-8?B?dUFHdTB4QStDWUJKaXJhMlVIaEpzd3BBNjZMMi9HUlZQbGNxUDZ4TWw1SHJu?=
 =?utf-8?B?TVBPL0hVV1AzUnZuandndE1weVNvVjg0eURVbU8zVEhXcG9JZ2ZJNEFXbkt1?=
 =?utf-8?B?bVRSWExMZXUrLzJMWVl5aHgxUTBOWUZDN21HNmY2Ynl5ODdFVjN1T1VUNkcy?=
 =?utf-8?B?L3NjUEFXTG1QdTJqUE84NDh4MHVlMXRiTExSODcrVnF0VWtHaGxmaXIyMVox?=
 =?utf-8?B?aDlId1BJRVlqY2dQeEhvMmdlY0tlbWNjL2VGWGFhcHhQTFpmQWF1cDJCVytU?=
 =?utf-8?B?MFgzTGpzNTgzTzBPYS9GNUFXb3p1aFV2NUVMTEQrYjRNbEpXWHVKRTVNNGpr?=
 =?utf-8?B?UldVN3RNWDJhSzFXc0cxOGlKL3ZRbi9jV240aTN6Q1BZb3crTkNPRTFCK2F3?=
 =?utf-8?B?NHQ1UTQyN1Y1LzNFQ0VNTUVaaG9uLzlBL3J0MmJKZ2hneitoblpiSGNsaE1m?=
 =?utf-8?B?aGV0aFpkM0dlaUIxS3ltVmNYWXNUbFAxMHBWM1kvWjF0bUhvd2tVc2Q1S3Vp?=
 =?utf-8?B?OWJTOW10UXhNVkhEak5QZ1BmVU5uNXVGNHhMR293elN4OW1GNEJsdk5OaHVW?=
 =?utf-8?B?VXlkbmRmWENGQ015OWZycGhZOHprbnNpMjB6L0lNOTRkSEtNSEF1Y1NqM2FR?=
 =?utf-8?B?WmJYVkJac3lDdnBzNXFzTlMyZjkwckRDTElScUVyNUVMMmY5NUVBeGs4QVU2?=
 =?utf-8?B?d2VvY1FlU0dEbzZsOUZhMEU5VkpiMGNtK3I0b1JrZ1I5TG9HMXpWaVRUSzBD?=
 =?utf-8?B?VVJLUFYzZ1BTcVdibXM4QUlPU0xoMFNQc3VQSTFRZEcvN2ROSDFvRWdGSVRt?=
 =?utf-8?B?MVRsek9nSS8yeGJmd2I1ZjZKOFFGWndRczZZemRzYTNGVk1RVE9yME1RN3hJ?=
 =?utf-8?B?ck43L2VzWFh6Vmw5c0dydTY1RXU5MUZwcGpBaWYydkdhQ0hrTldtVG5JdGZp?=
 =?utf-8?B?TGNSUERHVlpiREZZeE9HZnpTZTVWN3Nkdy9lbWRuZDZ3VDk5bGlDUkxXdmt0?=
 =?utf-8?B?OXhXN1ZEUFpwVllYbnAvZzBwYk94TGhHN20rZHRhR2c3NUpiTmtkMjJsN0lm?=
 =?utf-8?B?b1U2OUtVdUdsTmRkS1dCcTdwbUF1U29UeUk3TkpHcHNlOGc0TWVIM1h1QUhn?=
 =?utf-8?B?dHZNcWh3WXN2cmNiRlNjaXNQbldteEhWOENWaGVkN2EwcW91QWVzS2cxYlJ0?=
 =?utf-8?B?UnZTYTluTjBLOWNqRWYzcmwrZmorYUZwcmxJVWNraStkNGlGUWRKUkcwZGZK?=
 =?utf-8?B?MHlTUEpEaHFtbkdrTmtOcllMR0RpbURETWdzbmU1K1VBNEJjRFVaWVJEN1cv?=
 =?utf-8?B?REJtNkF3Uk5KcytCeCs5YTNaaHU0UXJOS2w5NnR6S2dGeXlwSjBCNG5YaHlJ?=
 =?utf-8?B?NU5UTGpudGFML2E0MkxydGtIbUZ5VEg2YThjM0l5bzFFTms3aWpNUmgwTk5a?=
 =?utf-8?B?eGhpeHZJWE0za3BPc1NscXg2VTVDT3JHbVVwR2VjQkFtT1FFcDg4dVVBSUtw?=
 =?utf-8?B?SlNVWFlqYW5OZ1lxckJpTkxsVllIVFlxQVhxYWRIMWs5dlVINDQxRzlOT1Y3?=
 =?utf-8?B?YVF4SENyYWtIUFJ2bmxmSnJkT0lmMDgxc04rYUx5eE1RVGVTTWdON09OV25I?=
 =?utf-8?B?ZndDVmZMTnAxYitxUjFVbTBFdHR2QktSc25QSytNSTVIeWwyWEZpT1BVOUlL?=
 =?utf-8?B?b2VZVzAzMndNRnJxaCtVUDNGVkNaOVQ3Wmt2UG5TSU8yeE5BVll1N1hGdlox?=
 =?utf-8?B?VzRRd1NJOHRVbW9XQkVuWGp6OWx5TTlMOWRuNmFETjRwVUQvQ25PZHA2WWlv?=
 =?utf-8?B?eUgzSDVNM2llaEFXTzFBSGRNYjh5c0NQcVFXTm5TOXU3YmZHRlV6bXRHM0pV?=
 =?utf-8?B?TnVDYUIvdkdKS1czVGxvRjlld1IvVmdNeVNBYmxqRXQ5am5OSXNXU0wrVS9B?=
 =?utf-8?B?VFY1aVJrWER0VGU2bTFoSmNKbnliRC90OEJXR1JEMm1pZTRkRmNiUUQzVmp6?=
 =?utf-8?Q?fJ9lxPur8CAGxDiU6oMJGje/b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1ce9a5-56f8-4fe5-a1b9-08dd1e99c02b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 12:53:06.1027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YP4EZ3sWpABuVEiBZtEMBW9g6sLHON1zNF4WfMfmMDu4RJdLNUoTpgJfBqIhDRhq2c2J/6EeKsZLpsOnasiX8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741



On 17/12/2024 13:32, Alexander Lobakin wrote:
> From: Rongwei Liu <rongweil@nvidia.com>
> Date: Tue, 17 Dec 2024 13:44:07 +0800
> 
>>
>>
>> On 2024/12/17 01:55, Alexander Lobakin wrote:
>>> From: Tariq Toukan <tariqt@nvidia.com>
>>> Date: Wed, 11 Dec 2024 15:42:13 +0200
>>>
>>>> From: Rongwei Liu <rongweil@nvidia.com>
>>>>
>>>> Wrap the lag pf access into two new macros:
>>>> 1. ldev_for_each()
>>>> 2. ldev_for_each_reverse()
>>>> The maximum number of lag ports and the index to `natvie_port_num`
>>>> mapping will be handled by the two new macros.
>>>> Users shouldn't use the for loop anymore.
>>>
>>> [...]
>>>
>>>> @@ -1417,6 +1398,26 @@ void mlx5_lag_add_netdev(struct mlx5_core_dev *dev,
>>>>  	mlx5_queue_bond_work(ldev, 0);
>>>>  }
>>>>  
>>>> +int get_pre_ldev_func(struct mlx5_lag *ldev, int start_idx, int end_idx)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = start_idx; i >= end_idx; i--)
>>>> +		if (ldev->pf[i].dev)
>>>> +			return i;
>>>> +	return -1;
>>>> +}
>>>> +
>>>> +int get_next_ldev_func(struct mlx5_lag *ldev, int start_idx)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = start_idx; i < MLX5_MAX_PORTS; i++)
>>>> +		if (ldev->pf[i].dev)
>>>> +			return i;
>>>> +	return MLX5_MAX_PORTS;
>>>> +}
>>>
>>> Why aren't these two prefixed with mlx5?
>>> We can have. No mlx5 prefix aligns with "ldev_for_each/ldev_for_each_reverse()", simple, short and meaningful.
> 
> All drivers must have its symbols prefixed, otherwise there might be
> name conflicts at anytime and also it's not clear where a definition
> comes from if it's not prefixed.
> 

However, those aren't exported symbols, they are used exclusively by the mlx5 lag code.
I don't see any added value in prefixing internal functions with mlx5 unless it adds
context to the logic.
Here it's very clear we are going over the members that are stored inside the ldev struct.

Mark

>>>> +
>>>>  bool mlx5_lag_is_roce(struct mlx5_core_dev *dev)
>>>>  {
>>>>  	struct mlx5_lag *ldev;
>>>
>>> [...]
>>>
>>>>  
>>>> +#define ldev_for_each(i, start_index, ldev) \
>>>> +	for (int tmp = start_index; tmp = get_next_ldev_func(ldev, tmp), \
>>>> +	     i = tmp, tmp < MLX5_MAX_PORTS; tmp++)
>>>> +
>>>> +#define ldev_for_each_reverse(i, start_index, end_index, ldev)      \
>>>> +	for (int tmp = start_index, tmp1 = end_index; \
>>>> +	     tmp = get_pre_ldev_func(ldev, tmp, tmp1), \
>>>> +	     i = tmp, tmp >= tmp1; tmp--)
>>>
>>> Same?
>> Reverse is used to the error handling. Add end index is more convenient.
>> Of course, we can remove the end_index. 
>> But all the logic need to add:
>> 	if (i < end_index)
>> 		break;
>> If no strong comments, I would like to keep as now.
> 
> By "same?" I meant that there two are also not prefixed with mlx5_, the
> same as the two above.
> 
> Thanks,
> Olek


