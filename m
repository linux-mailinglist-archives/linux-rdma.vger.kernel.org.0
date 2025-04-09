Return-Path: <linux-rdma+bounces-9303-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA61A82BC7
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 18:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBC3462E25
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 15:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9ED26A0A9;
	Wed,  9 Apr 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kFD6k5mw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ADA265CC6;
	Wed,  9 Apr 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214190; cv=fail; b=aXkDmEop3z7UqqJAp5Fcmi0ANTS75nQQeWymbekRAZfVWCNcnU0Ye4Zeaf0jr1idkjbeLclet/y+83YNanEIBflhMewhzUxQvlw7ehN3eg61AKtcoS/NbC9ikq47Gvo8u8HKNbLVsFBfqb5kAOzzmJDd3wc73HuJOhhri8Unn9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214190; c=relaxed/simple;
	bh=eotrPZJNQ12OE99cMf9YEZVtPj2oc4C3D6lLcHga8/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t6YnfwUkddkiqdsDgjbE0rNqewuvdkCKRDzQBowEKsjTDcxEsUF39dQjtjt2sNV+Jfq5b6lgBx0WkmXMse1YlxSQ6lPIZG4aN9o1n8LOk2x9gRR9INj9pUZjoCWTteDuPe92d/6xr/mvUIOOg6vYkiVRPDgxz14/WH1DV6FjIt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kFD6k5mw; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVo2wd5bXTh3MF7PdKphkgp8qyGDWtY0cubqLsx1J1hPRaLerWCNUSZ4f0IJUsZ963Fmlh2mtTvd2EoPPYS4XhD4LRSTmSnes58nfG+LgXnNI9tsjFrUhpZ9tr/WJ6Xg3foo/RLsguXXQgeXGE5vc2OFNoEX/o113FabyeodOwdcMWR3qr7jfjjtZTafKusIkZx+TC5/UX132Yar1df2tVfWJ5XllDvlEbbIzx4+NaphJjuKgTns76xuHR+lMOINCLM6fcn3kJroimeUeeY4qH4GLLtNLcwItwzE3+ok+uL0bOi24jztir+B7jRqXXZxBfDSZeYU8f7Q6d60ScFivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5NaR+rZ5vs1pJjQJnQx9+pD4pQkGHf60vCq61Hwqyc=;
 b=gjavMbvy42wa/vVYhplj9bdEyaZH+PjqaNPqyTz6t0OidhdpDvsXDdkZlYYUFNYsW7WskhdsB4O9Wgxhz4M5m8CWdW2Md25KgopCvPa47xS90Q9Su4NUNDilqRsHh7/t7031htBeTQROzhT6YLSQxzN1vBzDmOvqZa8YY6/wLUdMG/yTUT7X9XyNsN3xLGQWIaSfR+Okn0RKynGOE4xPojUBA+XtBevXT3vAszvvbMfWBn1xNWIMc5fSyKPKrRbFz0c/nz9emsnH+4BaY2XvqMF0t4tolM6HfoH5CVyfpAY3izQpV3TM6tVIJKbzBxSVe2Q9zwQqvJOq0r1mx2BtLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5NaR+rZ5vs1pJjQJnQx9+pD4pQkGHf60vCq61Hwqyc=;
 b=kFD6k5mw4r2mL/+6WiLqZJIkyETK5gDMoK7cH8yDg1FWLD96JHVPnHBFYHzXpyJUtRco6NuTarocAAgPpuP5dTwRJdib6GF4pWIwJOHy7YNDhiQKakORkCOaR59k/EWweeflgG3rkW6sb2vXobIfCR/6SPQ/tk81LCssDEjugldS0RgwK+RIGndbVfCs/xh7RcpEaAjtTepntBDHbxExO3hQsgj65CaZ3ERaoBI35t+HwAmPGlxztAY/MeY71i9JzTl5Rd1yj5416B8e94S+Qpd+vrKzhmDAZfoseK/4X5YofNge20JjwWbpPMXSLAjJTZHZMpyDImhBQyoqY489Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3953.namprd12.prod.outlook.com (2603:10b6:a03:194::22)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 15:56:26 +0000
Received: from BY5PR12MB3953.namprd12.prod.outlook.com
 ([fe80::308:2250:764d:ed8f]) by BY5PR12MB3953.namprd12.prod.outlook.com
 ([fe80::308:2250:764d:ed8f%7]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 15:56:25 +0000
Message-ID: <8358f9a8-3a39-4e85-b2fe-5298da3d36cf@nvidia.com>
Date: Wed, 9 Apr 2025 17:56:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/12] net/mlx5: HWS, Fix matcher action template
 attach
To: Michal Kubiak <michal.kubiak@intel.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-2-git-send-email-tariqt@nvidia.com>
 <Z/aQZzRYWkSLV1r/@localhost.localdomain>
Content-Language: en-US
From: Vlad Dogaru <vdogaru@nvidia.com>
In-Reply-To: <Z/aQZzRYWkSLV1r/@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To BY5PR12MB3953.namprd12.prod.outlook.com
 (2603:10b6:a03:194::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3953:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 941c0c01-8e0f-4a1b-33e8-08dd777f1516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REdNOHlZY2t2aVZUZXhwWTNiSWZFV2MvTUJQNzkveWxNNVA5bHJKRWxpMDZO?=
 =?utf-8?B?a0o3aHBYOG9FODAzZkxJV3N5dXJvSlJld3pzNkhWbDAxbkJuUnRlQ0xyVEhp?=
 =?utf-8?B?aTRMMGI3Qk9Dak9SSkg1aTAwcHNMTXB1WkRNY3F1S21SUHBaRS96RHV0bWVX?=
 =?utf-8?B?clJONzBaQ25KK0FCT1EvMEpCU3JNeHU5S1YrRVcyUmlTNEkvVUM4cCtoUGM3?=
 =?utf-8?B?SzJ2aC9HMWR3WXoxbS9EdXFVRXBGUy9YejN5UjUvME94cG5nUE1DeXd2Nnhx?=
 =?utf-8?B?WFJEY3N0QVErYnBGV29jVGE5MkVwMHlDWmtJdlNDbzBnS1RBTGFlRm1qbEM4?=
 =?utf-8?B?dWgrQmVGWTJpb1JaVjM0ZVpvbyszbE5Zdlo2TkxsbWNjZ2xUVDFRNUIrczY4?=
 =?utf-8?B?OVZ1NkkvNjBMaFo3Ulg0OURvQTZrK2tLOHRzN0hYQnhaeGZWd3VpYzFFV2ty?=
 =?utf-8?B?UmZXRGgwa2ZFYWVhejZwK0UzZHhUQXp6UWtpOWE5dkNxVXBVVXR6bFo4SGJx?=
 =?utf-8?B?UVFnMld6YU1rRzdmcUhIM3R2dVNWeE14MGRjK2FCVXdkTzhDVDR1NFl6Mk5x?=
 =?utf-8?B?RG1MbUROUE04dzRDY3lSTUNFcis1S011OXAyTnJ3T0syTGdoM1BPTkhxNVdR?=
 =?utf-8?B?Qml5Z3RIS1Z1cExnY3gxbXErU29OeS9XQ1B1UjJEbzlsNUpGWUxMUDRxK2xB?=
 =?utf-8?B?VHVUUVpQaXNkK0Q3LzdpL0xaSy9JWXY3aGN6SEJIYWlCRFVTVEU2QVVoZkgz?=
 =?utf-8?B?dzBzclcxMTJHdG9lejZheGJzVWYydzZXSGJ3R1EyWkd5WmhSSHhYNmxMN1g5?=
 =?utf-8?B?eXdhUTJQbUthRlZQZGZzckpzLzhxN1BrT292Tm90Z0grWlhrTDRpYVBnc0pT?=
 =?utf-8?B?U0NpMlZobGdqcVR6YnV4RXN3SzRmdDZYVGlzWjAzMnR5VUc5YUpUaWdJRTUw?=
 =?utf-8?B?S0ZyRlI2MFRCNFpaREptNnRxT0Z1WWRBaTFjUEVrV3lYbDlKcC9McENzN2hN?=
 =?utf-8?B?emsrekNCODY1L1NiemJsQTFvc2ZSbk9kdFhwcW1wdzJLSzc2aGIzUU8zU3Jx?=
 =?utf-8?B?L0ZreDJ6U3hQRldEdlN0VGJIU3hWYTlRTzRlbGRxTEpzM0QyT0hRUkZ6Z0U5?=
 =?utf-8?B?MFhXMTZWNlN3N050WW05d2orM1ByVVJ2Rm8xVENZT1EzZWZYam11R3NxN0h2?=
 =?utf-8?B?L2VFaWdNclRiZWJrcXRUdWdPbFkzSE1uVlhPcXdrOUFqL3VGMjZoaWVGcUNi?=
 =?utf-8?B?bE1zaFl5ZWRoUXJVbVh4NzNab2VYeWlXaVllWDZYOStJaVhFTyszNzFwQ1NW?=
 =?utf-8?B?Nlh2RGJWUGtWazc0YXNnY2pxODZnVTkzUjdwaVlDejNWcTE4eWtXbGI4R1Fn?=
 =?utf-8?B?RVNXSnF2UEdnMVlYWE5sMEFFc3lCTDZEOTlPeU0wcU5RUitDMi83YkM1eExD?=
 =?utf-8?B?ays2dFRiM01KNUhvOTlCUTNHY2pNZTlGbVhzM0toc0tFa3RWc1l1YXpTaVVh?=
 =?utf-8?B?K2hMT0dnTGp1ZTlYWHVmaDFoSXRsb2czTXcwMUFSSnFhblVMRGpkMmlFaDg3?=
 =?utf-8?B?VDV1bDRtQ2pzQnhIYlRLM1RvVUtuek9XSitDL0xHOVpSTGh3MkhWUnB1UXkw?=
 =?utf-8?B?eDU0RldWc2s2RDZEZ01ocDdjaW0yZGZiREYvdVp3cVJNZllJb2EzMUNaTDlQ?=
 =?utf-8?B?Y1pZc25Tam1uNFR2RGEydU95N09pM2FWSFMwSVdFVFlzODN5UzFGbk5LbjVz?=
 =?utf-8?B?a3AreE5IcHIxOVJ5WEUzaFRKYmhYN0dRMjB5OXdDMUNxaXZXZHY2cXIyRnFt?=
 =?utf-8?B?NG5CWFB1bEFSM1JGRWlrZTNaWjUzcjlUL3ZxK0FwOXp0VGlDaVVHSU1OSUIz?=
 =?utf-8?B?eW1kTEtiQVUvWFlsWVNseUZGNUVrWTJuczM1ei9HdmZpVXRGYnR0VStKQ21W?=
 =?utf-8?Q?jUXkZXx6yAM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzJaaTBDdTQrVS82UUVHdEYzZlhub0ppNHNZb1Z2ZGdId3FuQ0VpYW9zOU5k?=
 =?utf-8?B?NndESjYvQ3liVC9EaTMxMTlaa09kUUtJVThUZThITGpQQWo1NXVLNGFGaTRs?=
 =?utf-8?B?V09jOXduN0o2bVNTUkdxM3lRa3ZGdjBabVNJYStHVUp1RUNvVnlRWE54djJZ?=
 =?utf-8?B?RFFmZHRMMUdaN1o0Y01BSEJuUUVBbnIyWkNEMVRZaWpNVDd1UmczcWw4WlE4?=
 =?utf-8?B?MVQ3TTFNaVljQnp2S0oveDZ2ZTh4eWlJSGJmZjFKd1JQOFpvOWQ3L01sMHBY?=
 =?utf-8?B?OElwMXNPYTBIaExwWkp1ekxldEk5a3RvaEllNUdHL1NYK3BzMldZOHErc3di?=
 =?utf-8?B?Q3ovV0tkRWdhVEJrazg0dGpUaHpxRmwvNTFiLzlnbUc0ZWViQVNmajBJRVpO?=
 =?utf-8?B?anBlb2MzU0F4QmVGd1Y0Z09LYStpS0haUDkveTh6d2ZZVG5xaUhxY3pveGFC?=
 =?utf-8?B?SHhlOWFGc3ZrY2VtMUcxWnhXcktMelJvVGtUSVZHeFBCQ2FlZmgxQ0g1R0hD?=
 =?utf-8?B?RTJUREUxWXFTRkRYdE5KTmxab1dBK1lOZFhGY2FQOVEvLzNGaTNxclQyNy90?=
 =?utf-8?B?ZFg3THZ4U0R1Z1NnRk01WWxxVHB6UkxDV2Riekk0WVZ3WlFESmpRNmhoN0li?=
 =?utf-8?B?bE91WkRuYUNOdmNUM1Q3RkZyZGdEenN1YWNXVUFHK2lKK2VydUxLdmk4ZHkz?=
 =?utf-8?B?NlltM3hjc0h2S1R1TmloQVowWmwzOHc5Rmp4eTdkRU16TzIxaWZSVThMOWJv?=
 =?utf-8?B?YzU2VUhTWUs3ODhBbjhzU2ZKY3FoQVRPOGhQVEdRVkxsZEk1T2grbDk4endy?=
 =?utf-8?B?YTNGajNIUGZvbXlSMkJJRUVmekVSSTlnZVIxbFNGczUyNSt1WCt3TmNxbTZ5?=
 =?utf-8?B?ZWh2Wm80UlVvNm9LZTBwSTVHM3RNbzdRUFZvOEpOemtzRWtGQTkyaS8yYnQ1?=
 =?utf-8?B?YlloeGNJZ0sxcXh4T0hxN1lmM3pmemJpMFF5MGczaGhnMUFFNnZpRmxRM3N4?=
 =?utf-8?B?NWVjRTlrUHAyV2R0UzRya3hHdDZWWStyazB1UmJGeGVnTDdVT0kxd0dFcWRu?=
 =?utf-8?B?eDFPVC9iVFRKOGMyVHdHWWxOVldkSjQ0bXFKTk4vTjk4MWhRQTJtS21iK3VB?=
 =?utf-8?B?ejNOUENJeUdVaEo5QXNOTm80cFFpc0w3bjNvZitDWmlHdW5kbVdMa20rUWJY?=
 =?utf-8?B?dGxydnpla0pUZlN3TXdKY1FpVm9JcTVxcFV3d0h4aDdsVVJjWkp5dDcxcVFZ?=
 =?utf-8?B?dnRCUkw1NWxqWjNwQ0dsV2txMlNab1YvVzFwaCtycEtpLy9aRDZUckxDblls?=
 =?utf-8?B?WFdYYjU5RS8yWkZScnptRUpnL3A5SUFiWHJwMEJYSk54TU0wZ1UyMVkrQ0JE?=
 =?utf-8?B?RTBGZU5kTGx4U25zdVRiY0R5c3QxelN5VWZOVmF6VVZ2U3NGT2pLR0dFR1JU?=
 =?utf-8?B?VzVHcExrenhaMUlFZlFCSERrTHBTejgxYkgyUHBjcDc1a2NZbUtUeXNYdWhq?=
 =?utf-8?B?SG5NTGZKTUlwK0Uya01RK3o4Q3FWbnVYVnFIcDAvSTJuMWVkV3h1TnEzbUhK?=
 =?utf-8?B?aitqYm5PeTYwVUEzdTVlbUxYVUozaFdxR1NXdzh5a01ndStIUlV0c3RBUkpY?=
 =?utf-8?B?Q1dxcnJLaU9BU0ZlcFFJUXd6d1lDa3I0bDl4V2tyMGtiOU5YaUluQjFUZ1Ft?=
 =?utf-8?B?aTlpbWhYZzhpcmpJUllWMkpWcmwzaVlXK29vcWVqL2FxM1kzdzJXdjlxS1Fn?=
 =?utf-8?B?T0pKbXB6VGpqOUFDdWVoeVVQNUVqaTBNNmZyS0xhY2dwbVZWejlBRk5ISTQy?=
 =?utf-8?B?ZzJFUzRINU4wTmorK1VBaEFDVWZQR0NTV2lwMldmbEs2d3MwV1ZCZWRsbHZF?=
 =?utf-8?B?T0RLZHZ0eWpmcG1jMUtPaGQ2YmZEL1RwSk0yTVhmclIrSEZQUDQ1ZW5YTkN5?=
 =?utf-8?B?aFZqckI1Uzd4dVlJa3NSWkFWN2xaMCtDRTJrSnQ5QjYwVTJmTURRTUlHWTJU?=
 =?utf-8?B?WGtuMEJqb09RaDlVbHdlUFYwQjdzcVhEenNmeCtXVDZqZWo4dFhkcUViZjZ2?=
 =?utf-8?B?U09WN08vc2lJZXc5ZnRRZm9pKzN3d1hWc2s1SkxqamFzMnIwSVBtZGtCaXgz?=
 =?utf-8?B?bXhxYm9Od0JqaGRuVFRSUkErUWQ2dkxsZVBjMG14ZHFPbGZVdTdwZU93dWdK?=
 =?utf-8?Q?gwSXHYWeJzwdKDDNdGBy+s4aViVgT6iXeshsOJ+yb52o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941c0c01-8e0f-4a1b-33e8-08dd777f1516
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:56:25.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNR3+l2D0KBKxLLDHKreOk6hYKQJw2LDcAe8bOYokrNtkIOtXGmFmSSLJ2+h0ryYE0+tyx/tOKi3i78WBcGTsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084

On 4/9/25 17:21, Michal Kubiak wrote:
> On Tue, Apr 08, 2025 at 05:00:45PM +0300, Tariq Toukan wrote:
>> From: Vlad Dogaru <vdogaru@nvidia.com>
>>
>> The procedure of attaching an action template to an existing matcher had
>> a few issues:
>>
>> 1. Attaching accidentally overran the `at` array in bwc_matcher, which
>>     would result in memory corruption. This bug wasn't triggered, but it
>>     is possible to trigger it by attaching action templates beyond the
>>     initial buffer size of 8. Fix this by converting to a dynamically
>>     sized buffer and reallocating if needed.
>>
>> 2. Similarly, the `at` array inside the native matcher was never
>>     reallocated. Fix this the same as above.
>>
>> 3. The bwc layer treated any error in action template attach as a signal
>>     that the matcher should be rehashed to account for a larger number of
>>     action STEs. In reality, there are other unrelated errors that can
>>     arise and they should be propagated upstack. Fix this by adding a
>>     `need_rehash` output parameter that's orthogonal to error codes.
>>
>> Fixes: 2111bb970c78 ("net/mlx5: HWS, added backward-compatible API handling")
>> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
>> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
>> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> 
> In general the patch looks OK to me.
> Just one request for clarification inline.

Thank you for reviewing.

>> ---
>>   .../mellanox/mlx5/core/steering/hws/bwc.c     | 55 ++++++++++++++++---
>>   .../mellanox/mlx5/core/steering/hws/bwc.h     |  9 ++-
>>   .../mellanox/mlx5/core/steering/hws/matcher.c | 48 +++++++++++++---
>>   .../mellanox/mlx5/core/steering/hws/matcher.h |  4 ++
>>   .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  5 +-
>>   5 files changed, 97 insertions(+), 24 deletions(-)
>>
> 
> [...]
> 
>> @@ -520,6 +529,23 @@ hws_bwc_matcher_extend_at(struct mlx5hws_bwc_matcher *bwc_matcher,
>>   			  struct mlx5hws_rule_action rule_actions[])
>>   {
>>   	enum mlx5hws_action_type action_types[MLX5HWS_BWC_MAX_ACTS];
>> +	void *p;
>> +
>> +	if (unlikely(bwc_matcher->num_of_at >= bwc_matcher->size_of_at_array)) {
>> +		if (bwc_matcher->size_of_at_array >= MLX5HWS_MATCHER_MAX_AT)
>> +			return -ENOMEM;
>> +		bwc_matcher->size_of_at_array *= 2;
> 
> Is it possible that `num_of_at` is even greater than twice `size_of_array`?
> If so, shouldn't you calculate how many multiplications by 2 you need to
> do?

We only extend the array by one template at a time, immediately after 
this check, so this can't happen.

Cheers,
Vlad

