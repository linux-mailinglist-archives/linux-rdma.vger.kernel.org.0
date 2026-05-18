Return-Path: <linux-rdma+bounces-20892-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM+HDHvbCmog8wQAu9opvQ
	(envelope-from <linux-rdma+bounces-20892-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:27:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4101569AE5
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95F5E3006F29
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBE03E559B;
	Mon, 18 May 2026 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pQC8ExfI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4041E2E414;
	Mon, 18 May 2026 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096441; cv=fail; b=u1jj+cAzsJ8RKXIkGbLa15n/nj7Tj0qxhWuJB7ckb7cmWKINH0wMLLJ78zFiXHXMkvUV9ozGtdktMNZ0FLeteEKVU566R954ZZm0SmdKd2inkOBad39QZAilzAceDyoRZNV8fvz+Eug2o0xFqmw2eXebbE78lHLI2sCWPEngznU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096441; c=relaxed/simple;
	bh=XL5ZJQBeP6IEQWOZHbMbMOS+yWOa46EPJn+jJP2wrxE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jy2UwjUkvdYiIXhV+UgDCu84mtWZnK1o6OpckRK5tKzdTdtIgFY0gY+12AW/6Z2dTvC22sh0ePO30wy5Mlc9bBD5NRhXpR5qWKxO5cFXC1RWE+Bbyr1OqAvLxP9tjueeNcb4N4x+aZpXB32wCEQ4utEvohngKjBRhyAgKlhvwJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pQC8ExfI; arc=fail smtp.client-ip=40.93.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8TGg3lRIOK8AI6/ovA8t7n9P2XVpDyYvJRJmRyZdkjKT7vmTZWJT51vcwdElZWL6n2jo7EQDwFilGtLk58iu9azAoq4AbFYK2wpokqpdQERry44YlQ+B8wOpjjKGLFQI+Qd6pA7rjdJOqiu1Dop/0WZn+sdyYFP/BfW7pxGqfKzlnTjPuze1H/Fh4frLTSNJm7DSX0DD3LK1o0OR911QNKxmrLJ94DZhIw43R5c/7zbjxA9smguC2aJdDqZun5U7ahU6FsqUnRgCU+P3U3qotyGmdS7ZuVGd7inSXa2kBZSWj67STZQNlFxW/bnJ3uboJ1Y2hBn0JsHsVeFKKEFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eln9jWWrp23MvBqdoUi/JlScrHM+H/sr3TLl+HE1VwE=;
 b=Uiz/lImazfoFiZNTM7pQzaI+iBKcW08C+pGuk5BP/dGIwli4OjR4MjSppaPiE4uHsXlotKhnRI+2+XDl9Mqq/O+tvCsO3q4p5UFwculGFi4ceKkk0TYi6Brw569weDOYAFQcaH7FEhDmAekSk5LYkyQ87h7ZWYTvYywZNCDKLa1IcTqUpcl/nJBsekH6xJs/Tg+XA28PQFS2X1+vsr1kQ+uKLUVgBljfupZ5gMFA9IIdU7qIsCxtXyS/Adnt/IIgXeocLrb8TgbNPi7JD7ZTSTlHqr0QArjGZef631c5wBUAHWNX+Ek0mlkrInV9eCEdVZ/tvAXEf2Iwvz8zqCahWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eln9jWWrp23MvBqdoUi/JlScrHM+H/sr3TLl+HE1VwE=;
 b=pQC8ExfI/eWP2NP+QhuBAi/DjFnxgIlQbw8bhQTEwUyL5QfDkCP/fsWnDA+yR2yLCJIP14j2H7bsO44g31FwYHwc53nfy2Omzi37r1DKHsJjrLM4qS+DzZ6lIUnCeeEGsfB/7/xzeGgLsizX9Yd0FNc0hLzffaMaOUPCOU2F/ZaVXI6dNRrUlTkxEsb9sd/xiL3kXSH2UKiAEgMEbf8bi1SKAdlPWDvQBs4lbWyMba6sQ2fkNBmmqoOKzwNhpUNZrBaYgHEd0VlZFYApK+BH0N+Ll9JyNKJXX3JJAdObB1kzOvftbjj83kxEnMdUOfAUXK9w/MyXsyOOPiM7DXTZ2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 09:27:15 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 09:27:15 +0000
Message-ID: <9c324e5b-24a0-40ef-bd00-fb305825d06e@nvidia.com>
Date: Mon, 18 May 2026 11:27:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net 2/3] net: mlx5e: fix CWR handling in drivers to
 preserve ACE signal
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "parav@nvidia.com" <parav@nvidia.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "shenjian15@huawei.com" <shenjian15@huawei.com>,
 "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
 "shaojijie@huawei.com" <shaojijie@huawei.com>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>,
 "tariqt@nvidia.com" <tariqt@nvidia.com>,
 "mbloch@nvidia.com" <mbloch@nvidia.com>,
 "leonro@nvidia.com" <leonro@nvidia.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@cablelabs.com" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 "cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at"
 <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
References: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
 <20260417152642.71674-3-chia-yu.chang@nokia-bell-labs.com>
 <69750ae3-3b0f-41c7-9731-6d49f5f6d319@redhat.com>
 <e5d03a71-cfcd-417b-a3b3-94dbd6600f9d@nvidia.com>
 <e6aa13f1-4284-4ae0-9dda-1a506e729156@redhat.com>
 <8b610e49-ff64-497e-8712-588b2228df02@nvidia.com>
 <PAXPR07MB79846075432AA7F7CAD67006A3032@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <PAXPR07MB79846075432AA7F7CAD67006A3032@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0357.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::18) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f63789-bdc5-416a-0a00-08deb4bfa663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|11063799003|4143699003|18002099003|56012099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	cYymQrXHDtIJSYSZLWDi8X/63f+diUjzQe/kaohN0iAP6XCht28q4GpPFSKhXt9zSy6CQwtH4LLMg+uk+H4/UpAbMCb3cqvkt0QamHznnpC2TflVIQQxkRuwOYLpdt5640sCYjjNcZl9PZGTbdzaTkRzFDUxlTnTdWEAOLrw/3xbiD97o+iYliXc/HdpTXkX1IfNdZocCal2S9lAxFgRzEibbStYQsZArpfAgc86iuUXmkQ5rcqFnig35MUFqyKoGu8+gu/VxALNlZ02pr+A1VR7+LW3qBKlcilYLRWwohRAFbmsZ3DXsaX7B3AVyX97/tzv4sJXI1pP4sexYznufLAKJUS8qeZAaoaJHC3TFbhthOYj0zTFG+KaGdSAPc+LjqC6FqrOM7VNd4cxNvgpyKzo8QS+bizyddrCX0qr76G6TCTncNrMJ87gAfl3nf33q+4rkJic8fdL/FV/7ICkcLdcQs1c19tVSWx2JVU1e3+apYaOV1/UfopjS7CjOIahkcV0HMYP6uYceH51GnGwOHJkE0WEDYzHvbwEtEttsFIKEtBgm6JNm/5jMZsCsOvdxuaJepoca7xOSZaw6Z51EwZpuSS1m4U4t9XD4VTGL87XUxG56UIDDpU79JLaSU4afP45guxIDMR4LLZ6ai1H5SQD50j1ytDLmSdOs32eqR3HasbrA8sc93kBG6bp8LVDr7z47/q3so5qJDIzq2lfzP7fMhETmA2w5PImwAJ5c+1oNnbqp1pTBjpERnanPERV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(11063799003)(4143699003)(18002099003)(56012099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUhuaHRocEFhQVFRM1BxRWlsMklsVUtkMGpnaisxVHp1M0YyNTVWVzdYblZs?=
 =?utf-8?B?VGJiWnVrcldQU0xGY1RhT3dFelpXdHdyN05SNWdCLzNheUZRR05iWm5lT01J?=
 =?utf-8?B?V1ZLYlFyeWhXUmJqdDUwZUREeldoRVBTVWxhNUVmdjhBWGM3MWJENFpqYW02?=
 =?utf-8?B?NjdyVHl3ZFlnUjBMRGhOTWswY01UNmJBYVo5V0tzU1NnMCtoRFliZndoa0ZX?=
 =?utf-8?B?anRQSmxtc2hsWk0vRk9CZWlFOTZ2bFMwYXl3VGYvNlQyQi93TVVaZU9UdmNh?=
 =?utf-8?B?M01LK0Z1aEU3cGxsbFAySFBpMG5JUUJjVm1XQ0hZajhLekJmV3lVMFNTclZI?=
 =?utf-8?B?cXhJaVpvN0hYd1FkakZFZUszbVJKeUhNVVJCV2F5YWxWVWFBb3BIbVVWdlg1?=
 =?utf-8?B?V2Zpb0d6UW1uN0R5blhUekduRjVlekZIb0NTS01YZ2krTExtcGladWRjMmdS?=
 =?utf-8?B?TEhaSmZOZGZ4OVUvV2JYWGQxbi81WFFEVEE3TDlRZ05GMEtHUW10MDg1UTYr?=
 =?utf-8?B?UFhXTTJLK1A1MkQ2bXZrNjlPUm1SdnBHRVhVeFZ3dVhCcXZheDE4MFlsaXRZ?=
 =?utf-8?B?N2NJcjh1bmRVVCtQbGcwa1MxMVdMRDdCVG1IRzdicVRzYWVYeWU2Qzg3Y3Z0?=
 =?utf-8?B?bWp4UytpY1Z6ZEY0TjFvMjlJYUJ6QWVPSDdHQm15MlRkeXY1allyZXdCRlRG?=
 =?utf-8?B?Sk82VFBzZjIzS3BYUXZaRXExVkY5T0xBMmZ1ckVRUW5GYk02bklmL3FOVnh6?=
 =?utf-8?B?MVB5aGtWdUpCZVVFV0NER1JRbXp2Y2RKMzBXVWxGWmQxTjE2dlM3OU9Yb083?=
 =?utf-8?B?SnRrVkpNa2VpNFppZU45YlV3SW1PWUlqNlpGM0YvQ0tTVU5sSktMTmN1ejUv?=
 =?utf-8?B?a0FMdHkrRDNtenZUbUE3L0VZa2pjczZyMWJSdUVHcG1kMjJ3My9meHlHcVVR?=
 =?utf-8?B?bUNURVBhUXF5OENkODhYcWpDRUhtZlBYM2xpSkRiQU12VUgyZzB3eU9nMURi?=
 =?utf-8?B?VHg1a0ZiYXBPRUgvUGV3R2o0bmdMTVlHczBuYWNIRVlZVmZxL28yU2VSWGFh?=
 =?utf-8?B?cW1UdXBISFNReW5nRVZ0VTRKM1pCUnI1TURGbkFmU29MV2tvQ0tZR3hBZWxn?=
 =?utf-8?B?bFZDaXN0dml4MnZkTXBCZGh4U294OWN3QUZ1bitXZS8vMTVULzJIMVZXRGNY?=
 =?utf-8?B?S0ZJM1VOWEdRQ0dnTk01aFgzenZYdHArbDdIczcrYkMydHlMTVlQQVlvWCtH?=
 =?utf-8?B?THNWa2J4NnJuRWg2UGNwc3pZeVdJd1hQNWNocEZBQ2x4SzV1Wm1TWGp0a3Vr?=
 =?utf-8?B?SEJieW1sR0dFaHZUWFIvZmRsMTh2QjZORXpNY1V1L2VmSHR1enhtWGRVc1gy?=
 =?utf-8?B?cm9sZUU2eGdDQ28xbEtVNFRPNGkwWmRBK1BDMjdJaENPdEl2NS83cmNxT0Z5?=
 =?utf-8?B?R0VsSEpoRkxCckN5SnI4SUJDb0Z5SXBvdTBWWDVmNXVJMlVFNDhla0IweFl3?=
 =?utf-8?B?OTR4eEpCbWZ3MFI4OTRDQXNxVEJpQS9ZV3lCZ1R6RTdLVlN4eUJyS1V4L01E?=
 =?utf-8?B?NUx3UFY4MFNVM1VJMzc2NE1KWENWNXZ6VDFyNlpQSzJhV0VWZkp0KzJDOUpJ?=
 =?utf-8?B?OG14U3VoRkZPaFVYWU56UkdYSFRuZlJkKzhQcjBTTk1ZeityUU9rTzE4cGcr?=
 =?utf-8?B?ODdYWjdtcWIvZS9ZTkpZVElVSHdncFpHYWJ4dFJ2TDg5T0x0bGdSQW1UM0c3?=
 =?utf-8?B?VkpUK2ExOURoV0NoNmlHTWw0WGxjOTdHTk1TNUxxZ2I4M0VyZnI2L0hneEpF?=
 =?utf-8?B?NHZkbG4vaTZpSE42cEMxN0tpT0s2Nnd2NzhqTSs5MnBxM2Y2THpwV3c1ZEhp?=
 =?utf-8?B?b0VDT2MrMjQxK0tzWE9MS1VRZUR2SGZtT21FQ1F1QUx6RHR4bUMxQkYvOGYr?=
 =?utf-8?B?bUE2cjZTL2pHNTQ5Yk5oS1BnVXZJcEJod3ZvQ2h4eGY3bGlaMGNFaEdaNVNR?=
 =?utf-8?B?WDBTZDZlRFV1SG5STGRpTDhnRStTNjNkbnBRSDAzS1huemhXeTNKM2VQMHpy?=
 =?utf-8?B?Q3lKWUIxengrVUdaUWQ0RzlYcGt3a3p4bVJFZ1BOMm1ac0NKUmlkVXRpWVdG?=
 =?utf-8?B?NFR5NCtBSDFyY0plLzlBRkl0clJuOVA5ZUlWZXRjMjUvM205R01ZNXhVRzNH?=
 =?utf-8?B?aU5UbmtMVDNqWWVrZkVVdHd5d3UwVG9lTXV5YlJpV1ZzcDlnaHUzYlhsc1F5?=
 =?utf-8?B?QVQ0TSs3RytiT0dVYVpTckFyVFBwZ1FTYy8wUHFxUWhnQ3NZb0hveGc5QmMx?=
 =?utf-8?B?OU00OFlTOWNvcmkrM1c5VEpPQldkTEw0SFJBZGlEUUhhSU5CUlJqdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f63789-bdc5-416a-0a00-08deb4bfa663
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:27:15.7788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rRgeRdLsNc5bCwI9eH+/rCuCf6KxThPU0XolsCQSkmh0ZaVlqTS3y9evim+e3W2Dx0izYVtn9MHLAmWD/zn8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
X-Rspamd-Queue-Id: A4101569AE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-20892-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,redhat.com,huawei.com,lunn.ch,nvidia.com,vger.kernel.org,davemloft.net,google.com,kernel.org,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 18.05.26 11:20, Chia-Yu Chang (Nokia) wrote:
>> -----Original Message-----
>> From: Dragos Tatulea <dtatulea@nvidia.com> 
>> Sent: Thursday, April 23, 2026 10:13 PM
>> To: Paolo Abeni <pabeni@redhat.com>; Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; linyunsheng@huawei.com; andrew+netdev@lunn.ch; parav@nvidia.com; jasowang@redhat.com; mst@redhat.com; shenjian15@huawei.com; salil.mehta@huawei.com; shaojijie@huawei.com; saeedm@nvidia.com; tariqt@nvidia.com; mbloch@nvidia.com; leonro@nvidia.com; linux-rdma@vger.kernel.org; netdev@vger.kernel.org; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; horms@kernel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
>> Subject: Re: [PATCH v4 net 2/3] net: mlx5e: fix CWR handling in drivers to preserve ACE signal
>>
>>
>> CAUTION: This is an external email. Please be very careful when clicking links or opening attachments. See the URL nok.it/ext for additional information.
>>
>>
>>
>> On 23.04.26 19:40, Paolo Abeni wrote:
>>> On 4/23/26 4:19 PM, Dragos Tatulea wrote:
>>>> On 23.04.26 09:30, Paolo Abeni wrote:
>>>> [...]
>>>>>> ---
>>>>>>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c 
>>>>>> b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>>>>> index 5b60aa47c75b..9b1c80079532 100644
>>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>>>>> @@ -1180,7 +1180,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
>>>>>>    skb->csum_offset = offsetof(struct tcphdr, check);
>>>>>>
>>>>>>    if (tcp->cwr)
>>>>>> -          skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
>>>>>> +          skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
>>>>>
>>>>> Here there is an open question for nVidia:
>>>>>
>>>> Sorry for missing this question in v3.
>>>>
>>>>> Is the above enough or will later segmentation lead to the wrong 
>>>>> results? I think/guess the firmware is (still) aggregating the wire 
>>>>> frames using the ECN schema, i.e. the first wire packet has CWR == 
>>>>> 1, the later CWR==0.
>>>>>
>>>> For mlx5 HW-GRO a packet with the CWR flag will flush the previous 
>>>> GRO session and will not start a GRO session for this packet 
>>>> (napi_gro_receive() will be called on this single segment skb).
>>>>
>>>> So this change won't impact the current GRO behavior from the mlx5 driver/hw side.
>>>
>>> OK, thanks!
>>>
>>> For my education: doesn't the above also means that mlx5 will never 
>>> build GSO packets with CWR set (and so the above statement should 
>>> never be reached)?
>>>
>> It does look like it... Thanks for pointing it out! Will be addressed in a patch.
>>
>> Thanks,
>> Dragos
> 
> Hi Paolo and Dragos,
> 
> First, sorry for my late reply and thanks for clarification.
> 
> The table below is to ensure my understanding of mlx5 is correct.
> 
> +===================+==========+===============+=================+
> |     Packet id     | CWR flag |   Flushing?   |     gso_type    |
> +===================+==========+===============+=================+
> |         0         |     0    |       0       |        0        |
> |        ...        |     0    |       0       |        0        |
> |       n - 1       |     0    |       1       |        0        |
> +-------------------+----------+---------------+-----------------+
> |         n         |     1    |       1       | SKB_GSO_TCP_ECN |
> |       n + 1       |     0    |       1       |        0        |
> +-------------------+----------+---------------+-----------------+
> |       n + 2       |     1    |       1       | SKB_GSO_TCP_ECN |
> |       n + 3       |     1    |       1       | SKB_GSO_TCP_ECN |
> +===================+==========+===============+=================+
> 
> Currently, mlx5 will flush GRO session and emit a single packet when the CWR flag is set on the RX.
> 
> So, this patch (changing gso_type from SKB_GSO_TCP_ECN to SKB_GSO_TCP_ACCECN) seems more for future-proof than a bug fix.
> 
> I will update the commit message to spcify that (or please suggest other changes needed).
>
Hi Chia-Yu,

Based on Paolo's comment, we have a pending patch that completely
removes the setting of the gso_type in the HW-GRO path.

Thanks,
Dragos

