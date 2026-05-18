Return-Path: <linux-rdma+bounces-20891-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPpgOqbaCmoA8wQAu9opvQ
	(envelope-from <linux-rdma+bounces-20891-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:23:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D607569A20
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4B3E301E203
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039CD3E5561;
	Mon, 18 May 2026 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="kN3ZL0Ui"
X-Original-To: linux-rdma@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36F3890EF;
	Mon, 18 May 2026 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096037; cv=fail; b=sM1hN22VfaMnwJHQ2k0JWSgJio2cq3e8lDTvqXj4MosC2hY3YIf56j3+fPQGvADDWR6T2mWB0rWM6V5Zt7cV47JRzTX/t57kLf87Zr7a2nCKWkUZEKwyHWTPLPBIvQfndn8rkdfT0L0AZS6gQitN9C2iJIlovM5wDZghd89uMGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096037; c=relaxed/simple;
	bh=95jwJIQ6MjPrBaI96NjkQJk05/1JGbdtUh66mTYkWkA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bhlf4WMr/wpC0YbYz8zUI6tfT5+IPlSr7YKhVewDOkviePhH2kNZ3gNrI8hcdyFB9Q7rJRsT0AhuvvTccFB5cwDy2ZlVrDegsaztxQwnNFE/TATwlWu8oPOkiYSHjFELHtQGzFrG25Cz7pi5dkNFo620kWfdfP1sv9xSb1tvJGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=kN3ZL0Ui; arc=fail smtp.client-ip=52.101.70.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddAhjyyANQETGJvaexPYg4CzidTzWkiJLoxj/r3K+ETQKOSYFIbWJj8FHOUEFPVVm9/vM569YDoZmpzZPp0BHOmfvGJXD+yaG8UMv62/POVw1O+Q8c4hGjq1aklP0cykeGQOd5kNhHDmhTsOtIZOJ+b6/7G17awaOihcCPKQUdZoPcencDB6CFTfceRRYAAMPowiXtyRNBtoxJh56lE35sjc3PbOs0yg/psq1zwJwqMKSpnIQzymdAuz6sds5hxLGkR/0Z/QjvHV/kOEAFwOT22xw/wdU3UmrOkvHgCZHgBeeMTiyI10zPcVGEpao3hcVMIDppMTKREK7NlcFDY0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95jwJIQ6MjPrBaI96NjkQJk05/1JGbdtUh66mTYkWkA=;
 b=M7kdH9Ck1mdHiBHoz+URNqYi3Owzkxrjr02pJ9PlrfBDE+6RDUsW/JrYSQEHlK2CVjDwMEPLW7Rb2Q6qIqQRGbFEtHzlEZiS2D9ALROdpOYBD+QTYhLwkQUaQB840FeznV/WBvooM17JQk674YC02xrxBwBOT1ml2+BQB4u+Fpsv/rnH02hpwNvayCPXVYqEUwE/502Jk6ZB2oELqcSL3z8DZw/ery71oOzKfBmuLMcPXAZDXklYnli3VbaQ2BYn2yoHPFFs6gfpttF2eBQQxR8aQCgrfcDhCgtpu5z3jTpCVzL3Wgebg3ehqTp7FbSG7KXuMIqsG9GMI7d0hBnJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95jwJIQ6MjPrBaI96NjkQJk05/1JGbdtUh66mTYkWkA=;
 b=kN3ZL0Uif6MRqTjW83YH9uF+YS/cuICu1NLiGasuOMzHK1LVhoUOTB8bzXYXrezIMBjhorr3fJ33XgNUcKxf8H+hRqjysMWxH3rqekwOepCj2UF7vCEiMb6tiOmDRJwk0jXmeI7edADKiulGCkyZWIZlJ+VwABbXogmRdK8n7kJYNwOa9G1rYNetnREkGbSnk4A9Oa0LgEvJ3Lu0+HnZTa221cfyWcmshbfiGLsV30qpSpkaMAEKBQl/FLHIXeaikKOLa/xoOUZNhAENVZWIIYFNASKXziLOgGK+0js3McAUYtTSaxtq9j4cskMldVG0UFYk7zlcGnlOlS/NwSyJRw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DBBPR07MB7674.eurprd07.prod.outlook.com (2603:10a6:10:1e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Mon, 18 May
 2026 09:20:32 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 09:20:32 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Jijie Shao <shaojijie@huawei.com>, "linyunsheng@huawei.com"
	<linyunsheng@huawei.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"parav@nvidia.com" <parav@nvidia.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
	"shenjian15@huawei.com" <shenjian15@huawei.com>, "salil.mehta@huawei.com"
	<salil.mehta@huawei.com>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "mbloch@nvidia.com"
	<mbloch@nvidia.com>, "leonro@nvidia.com" <leonro@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v4 net 3/3] net: hns3: fix CWR handling in drivers to
 preserve ACE signal
Thread-Topic: [PATCH v4 net 3/3] net: hns3: fix CWR handling in drivers to
 preserve ACE signal
Thread-Index: AQHczn6fixZMzywtaUOMMLkT8kFqvLXvkJ4AgABJjcCAFEK0gIAPlT7w
Date: Mon, 18 May 2026 09:20:32 +0000
Message-ID:
 <PAXPR07MB7984D1D909BB284B7CE1EA69A3032@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
 <20260417152642.71674-4-chia-yu.chang@nokia-bell-labs.com>
 <6ae96ead-61b3-470a-a30b-3418350a45f0@huawei.com>
 <PAXPR07MB7984A31018E9B85DEC28B68CA3282@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <47530dd8-cba6-4282-ae80-4cabd52b08bc@huawei.com>
In-Reply-To: <47530dd8-cba6-4282-ae80-4cabd52b08bc@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DBBPR07MB7674:EE_
x-ms-office365-filtering-correlation-id: 66319f0a-b339-40cb-a826-08deb4beb5d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|11063799003|56012099003|38070700021|921020|22082099003|18002099003|3023799003|4143699003;
x-microsoft-antispam-message-info:
 9WzrDEAjlEjen9yH1+g3XgRbnDMzKpjl2FxsMOM3plOPPbZKUIcBsQSUs5oaOLWQUPAAZfPZ7jwjAGgOyZHRfEUhYlBg9Ac+PROS+6GyFv9wtj2c6+jz6pqT+HVTo/rj3z/bBiN7ioanimAZrRAdPf4uo0fri3MECr2dxcx19stQViKtrCrHsFCGTWqrR9wNPSFFHWQPO5+i0iFgejAsEG5Rco/ZYelWi/83XjThVI8RcJgmE0QB4PKh7qJmGii+0NZ8yNxlgidLuBNaUvjAw4x2OyPKmidUF9UD9ekE7eMBS/jO6dpNASV/x83GrYof+USKnhDNjP0W046zBH79/0wj9v++1zHLshFViMs4QAdCsC0d7di9lmArNrF0/7HAxWr0ou64VZcH/2tPso2SF2pyX6eK7VuAmFUC7WHqlUuldIfZaIN2G5rbG7CEuiWeXwXIZ+McXtsRh+3t6RJaFFLc9xTDnGF8zlvcHhk3LgHyEkDhmjvtUxkBwsUHi7HBMHD/jTmgF6BtZEf99qGr7DZo0u5UDNvnU040nysB8+RqzeCeBc650LuZy8qenKJwLFCG3faMwj9lW4f9EG8cVTDPvFncn904Lgc9s/19gTVTQhvx5S9i/nwHHrnG9HCFVD+4SDqbcp0ythvm8FWXdElhkTaYJb0Q0ZEoNybdKfMI6T5mGqsH0asMHtHuxiVHPJJiJUQAIzAHnWZj898/StiPFHW2+MZP+FgMvgGm7cNgcQx1cC+MiaWKi2gBNH5H0m66mADQvfjEvh9T5YPfng==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(11063799003)(56012099003)(38070700021)(921020)(22082099003)(18002099003)(3023799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWZkMkJRZVVwMm93WXB1RTFYckhjT05qWmgzSEdmZTllem1YK21UblhOS0wx?=
 =?utf-8?B?VHVaOElYVUJVUGJvaXVrUGtXbExwZnl1c2g4ZlpyenB6Vm1jNytRSHpuNVQ5?=
 =?utf-8?B?M2FkcEV4QkpKUE1RT0UzTlZvN3dFRE53cnFwTzFMQTBBOVcxdll4cmhXQ1l0?=
 =?utf-8?B?UWJORlljb2Y4ZzdWN1UrTC9sWE9LNjhUZkgxY3JrcWlhWlppN2gvSFRscmNU?=
 =?utf-8?B?TzVRdzJrNXpOQ2gvWVFSb240Tmc4aHVwU2RSQlRMY3lFVHE4RlZEdTQ3cjBZ?=
 =?utf-8?B?d1lWYldPaFJuWUV3enk0OHVsblR0Z3E4V0xiTWkxRGRURUlhQ0F6ekdlbmZT?=
 =?utf-8?B?ZnVISkZCMFZoTnpoTjUyY2h5Wm5hakRUdEUrSENmYzJnWURDcnRYMWpCNis2?=
 =?utf-8?B?UGtTZzN3aEs4M2c2MFAvNmQvc0theUlPNHpPNjQ2Z25aZlhGQitMNzgyYVRk?=
 =?utf-8?B?RjRMbG5VREIxc1JVSXNYRUhPb08vYnYwbzZCT1JXS1o4V0JzTmNRaXVJMDkx?=
 =?utf-8?B?cXB6d0s5OHl6NXBaTHM1cFJjWGNGTjJxNm9sYk1Wbk5xQ1RpL2VLMDVLWEhL?=
 =?utf-8?B?d21BRm1oWnRlWDR1WHFhVTBNN1RsZjVlV2I0N01jM0dIUFZWQytpVmU3Qlph?=
 =?utf-8?B?YWdacXU1ZDBTT3owTXc4OFQrT0ZqYW9lM24xWUk5QXdnU01EMXp6Ykdmelkr?=
 =?utf-8?B?bjZDU0RjbHFYaFA1YXZoMlVabk5ycTJYM3hzSGhNU2xiTVpUYllMZU0wYTFS?=
 =?utf-8?B?QTNnT0NJSHV3WnFJYkVObm54ejJmYnBzQWxSdE5uK3FsV3hxcS93MUkvcDVK?=
 =?utf-8?B?NmJVQ2l1SlFEdlJsR1JRN011cDNLUDkvWjlSbjhnZkVkL1c4WVFXdEFrUnQ0?=
 =?utf-8?B?WEFFWng0NklISTJHV3dHSEwrNWExOUU3ZUhRTnIzalB3TTFLaDYxVHlIU0pV?=
 =?utf-8?B?T1FLUjFmVFZWRGZmQnA2cEpheElVeDNjTTZKTjFvOFR3U0gzT3B1cUYzQ3Ra?=
 =?utf-8?B?VDBVZ3dzbGwxUmp3dXJrL2NIODFTT3JZeHdqdEo1ODJHSnRKNWxLelVDb3Zi?=
 =?utf-8?B?RkZEeGUvdk52LzZLaGtuVnl3SGs0NTFVMnpjT3FDazB0ZFM4RVA3eDRYeEpW?=
 =?utf-8?B?RVQzUkJPbkwrd1V5ekd1LzBTbkN4OVcwa1Nmb0tMUG9QNDFpSnl4N0RTY1FD?=
 =?utf-8?B?SDU5T2NwemtlTCtuaTFCa1hZY2U1SkF6THk2TTZ4UlFLU1p4cTBCVEtwQVpQ?=
 =?utf-8?B?WWticWhBaWExTnRxSlpHNktmU2JWSklxMXI1MVk5MkFiSEY4Y0QzbGFVakpF?=
 =?utf-8?B?UHI4V294eHdiYi84Z0NHaEVaSCt4cWhqTm1DSlVjdSt5bkc5OFlteWEvdjh2?=
 =?utf-8?B?YTNzUXpiMEpiUzd5RHpQSXJwK2lqUG5lRThtUHlQV3BnWTU2QzIwWGxROUww?=
 =?utf-8?B?NUlXTy9uME41dnJDZ1BVSTV6d2R0cE1yUFgyKzZUWXZQb1pYeFlNZzFOdjBa?=
 =?utf-8?B?YnV2ellKZXlqZFFUU0kvT0wrdlVsUS8yZ1NUS3VmZ1NhTU55SStOSHkvOUVO?=
 =?utf-8?B?aWtvZmdXdG4zaDRWdDFnVk1mWTNaeDh4WlZmYURsaFl4aU1WZ1oxeSsvYzlq?=
 =?utf-8?B?K2hkU0lEMStHVnVyQlMwTXEyM3paWmxCNGFSREcwRlZyNXdSdzROdm1xdFQw?=
 =?utf-8?B?UXRsV2FmZjhiQ2w3bGJyblFDY2hVMndqcmU5Z0Uzb1hiU0dwSDhwVnE3TmVh?=
 =?utf-8?B?QmNqRE1QRXJJOCt4aWY5bHpIQWZiRVJ1RWZVZzQxT09KczNsdm1aOEYxSFFP?=
 =?utf-8?B?WkN2TERkN2lUL1c2d2NDWlRWN3ViVXU3NnBFYjY2N2l6NjQ1bnVkU3ZGZVU1?=
 =?utf-8?B?TzNhOC93bVcxNjVFaEpCWWhGcy85TmczQURCNTgyWGc5NVp1T1owYmg0Z2Q5?=
 =?utf-8?B?OTFHaE1ITjErQ2Z1T1NuUlZyZnZXUURQaVlwbmFxeHo3d3VySmtUY3lEcGhB?=
 =?utf-8?B?TUExUGJlZTBSUDl0N1ZWeFRJK2VzVFJnaDE5d3VRbXZBbHAyTkJsV2hqcUdy?=
 =?utf-8?B?NHExN0lOUlBmNnkvR1E0dkE3ODNtTWc2VXlERUo5OXZIakZYZm5YeFVXdzY4?=
 =?utf-8?B?Qi9xOVVHa1BoWUt6VjNwZTVvTEg0RGd1bS9oYldZUXVkN2ZhRSsvaEE3NWt4?=
 =?utf-8?B?YmhmdSs0cElEOVdGajhJK3lzVmZTWHlSTHB3cWd2ZFUwdjJWZWZOYnRlL1lV?=
 =?utf-8?B?SGR4R2R0MHZ3M1ZXdkcvSk9taHBBR2MxUEJWS0lmK1RZVUNuemxKQk1OVnlN?=
 =?utf-8?B?dWJxV3l0bk82VWRka0F0VXVySFNlVzlSUG1kaCtFN29MYjBxTTFhaWZWaHMr?=
 =?utf-8?Q?g5uKPxd01Ti45SMs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66319f0a-b339-40cb-a826-08deb4beb5d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 09:20:32.0439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2POVm9n5X8/I+7I7yu/qRR7kUL8OhWraIAa/jg2Iyd+GMuT1FR6gzb8hqq+LNjWNoCYdgE8TEowEjNpfVigtli8vf7SL6XUZmbn9HM/hvwYTbi7tJ8SsjbGobtQ79rw/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7674
X-Rspamd-Queue-Id: 8D607569A20
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-20891-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSmlqaWUgU2hhbyA8c2hhb2ppamll
QGh1YXdlaS5jb20+IA0KPlNlbnQ6IEZyaWRheSwgTWF5IDgsIDIwMjYgMToyMiBQTQ0KPlRvOiBD
aGlhLVl1IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT47
IGxpbnl1bnNoZW5nQGh1YXdlaS5jb207IGFuZHJldytuZXRkZXZAbHVubi5jaDsgcGFyYXZAbnZp
ZGlhLmNvbTsgamFzb3dhbmdAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207IHNoZW5qaWFuMTVA
aHVhd2VpLmNvbTsgc2FsaWwubWVodGFAaHVhd2VpLmNvbTsgc2FlZWRtQG52aWRpYS5jb207IHRh
cmlxdEBudmlkaWEuY29tOyBtYmxvY2hAbnZpZGlhLmNvbTsgbGVvbnJvQG52aWRpYS5jb207IGxp
bnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZlbUBk
YXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBhYmVu
aUByZWRoYXQuY29tOyBob3Jtc0BrZXJuZWwub3JnOyBpakBrZXJuZWwub3JnOyBuY2FyZHdlbGxA
Z29vZ2xlLmNvbTsgS29lbiBEZSBTY2hlcHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5v
a2lhLWJlbGwtbGFicy5jb20+OyBnLndoaXRlQGNhYmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hh
bnNzb25AZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hp
cmVAYXBwbGUuY29tOyBycy5pZXRmQGdteC5hdDsgSmFzb25fTGl2aW5nb29kQGNvbWNhc3QuY29t
OyB2aWRoaV9nb2VsQGFwcGxlLmNvbQ0KPkNjOiBzaGFvamlqaWVAaHVhd2VpLmNvbQ0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjQgbmV0IDMvM10gbmV0OiBobnMzOiBmaXggQ1dSIGhhbmRsaW5nIGlu
IGRyaXZlcnMgdG8gcHJlc2VydmUgQUNFIHNpZ25hbA0KPg0KPg0KPm9uIDIwMjYvNC8yNSAyMjoz
MCwgQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIHdyb3RlOg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+Pj4gRnJvbTogSmlqaWUgU2hhbyA8c2hhb2ppamllQGh1YXdlaS5jb20+DQo+Pj4g
U2VudDogU2F0dXJkYXksIEFwcmlsIDI1LCAyMDI2IDExOjM1IEFNDQo+Pj4gVG86IENoaWEtWXUg
Q2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPjsgDQo+Pj4g
bGlueXVuc2hlbmdAaHVhd2VpLmNvbTsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBwYXJhdkBudmlk
aWEuY29tOyANCj4+PiBqYXNvd2FuZ0ByZWRoYXQuY29tOyBtc3RAcmVkaGF0LmNvbTsgc2hlbmpp
YW4xNUBodWF3ZWkuY29tOyANCj4+PiBzYWxpbC5tZWh0YUBodWF3ZWkuY29tOyBzYWVlZG1AbnZp
ZGlhLmNvbTsgdGFyaXF0QG52aWRpYS5jb207IA0KPj4+IG1ibG9jaEBudmlkaWEuY29tOyBsZW9u
cm9AbnZpZGlhLmNvbTsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IA0KPj4+IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207
IA0KPj4+IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGhvcm1zQGtlcm5lbC5v
cmc7IGlqQGtlcm5lbC5vcmc7IA0KPj4+IG5jYXJkd2VsbEBnb29nbGUuY29tOyBLb2VuIERlIFNj
aGVwcGVyIChOb2tpYSkgDQo+Pj4gPGtvZW4uZGVfc2NoZXBwZXJAbm9raWEtYmVsbC1sYWJzLmNv
bT47IGcud2hpdGVAY2FibGVsYWJzLmNvbTsgDQo+Pj4gaW5nZW1hci5zLmpvaGFuc3NvbkBlcmlj
c3Nvbi5jb207IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24uY29tOyANCj4+PiBjaGVzaGlyZUBh
cHBsZS5jb207IHJzLmlldGZAZ214LmF0OyBKYXNvbl9MaXZpbmdvb2RAY29tY2FzdC5jb207IA0K
Pj4+IHZpZGhpX2dvZWxAYXBwbGUuY29tDQo+Pj4gQ2M6IHNoYW9qaWppZUBodWF3ZWkuY29tDQo+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCBuZXQgMy8zXSBuZXQ6IGhuczM6IGZpeCBDV1IgaGFu
ZGxpbmcgaW4gDQo+Pj4gZHJpdmVycyB0byBwcmVzZXJ2ZSBBQ0Ugc2lnbmFsDQo+Pj4NCj4+Pg0K
Pj4+IG9uIDIwMjYvNC8xNyAyMzoyNiwgY2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29t
IHdyb3RlOg0KPj4+PiBGcm9tOiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJl
bGwtbGFicy5jb20+DQo+Pj4+DQo+Pj4+IEN1cnJlbnRseSwgaG5zMyBSeCBwYXRocyB1c2UgU0tC
X0dTT19UQ1BfRUNOIGZsYWcgd2hlbiBhIFRDUCBzZWdtZW50IA0KPj4+PiB3aXRoIHRoZSBDV1Ig
ZmxhZyBzZXQuIFRoaXMgaXMgd3JvbmcgYmVjYXVzZSBTS0JfR1NPX1RDUF9FQ04gaXMgb25seSAN
Cj4+Pj4gdmFsaWQgZm9yIFJGQzMxNjggRUNOIG9uIFR4LCBhbmQgdXNpbmcgaXQgb24gUnggYWxs
b3dzIFJGQzMxNjggRUNOIA0KPj4+PiBvZmZsb2FkIHRvIGNsZWFyIHRoZSBDV1IgZmxhZy4gQXMg
YSByZXN1bHQsIGluY29taW5nIFRDUCBzZWdtZW50cyANCj4+Pj4gbG9zZSB0aGVpciBBQ0Ugc2ln
bmFsIGludGVncml0eSByZXF1aXJlZCBmb3IgQWNjRUNOIChSRkM5NzY4KSwgDQo+Pj4+IGVzcGVj
aWFsbHkgd2hlbiB0aGUgcGFja2V0IGlzIGZvcndhcmRlZCBhbmQgbGF0ZXIgcmUtc2VnbWVudGVk
IGJ5IEdTTy4NCj4+Pj4NCj4+Pj4gRml4IHRoaXMgYnkgc2V0dGluZyBTS0JfR1NPX1RDUF9BQ0NF
Q04gZm9yIGFueSBSeCBzZWdtZW50IHdpdGggdGhlIA0KPj4+PiBDV1IgZmxhZyBzZXQuIFNLQl9H
U09fVENQX0FDQ0VDTiBlbnN1cmUgdGhhdCBSRkMzMTY4IEVDTiBvZmZsb2FkIA0KPj4+PiB3aWxs
IG5vdCBjbGVhciB0aGUgQ1dSIGZsYWcsIHRoZXJlZm9yZSBwcmVzZXJ2aW5nIHRoZSBBQ0Ugc2ln
bmFsLg0KPj4+Pg0KPj4+PiBGaXhlczogZDQ3NGQ4OGY4ODI2MSAoIm5ldDogaG5zMzogYWRkIGhu
czNfZ3JvX2NvbXBsZXRlIGZvciBIVyBHUk8NCj4+Pj4gcHJvY2VzcyIpDQo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IENoaWEtWXUgQ2hhbmcgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4N
Cj4+Pj4gLS0tDQo+Pj4+ICAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2hu
czNfZW5ldC5jIHwgMiArLQ0KPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2hpc2lsaWNvbi9obnMzL2huczNfZW5ldC5jDQo+Pj4+IGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaGlzaWxpY29uL2huczMvaG5zM19lbmV0LmMNCj4+Pj4gaW5kZXggYTMyMDZjOTc5MjNlLi5l
MWIwZGJhNTYxODIgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2hpc2ls
aWNvbi9obnMzL2huczNfZW5ldC5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2hp
c2lsaWNvbi9obnMzL2huczNfZW5ldC5jDQo+Pj4+IEBAIC0zOTA0LDcgKzM5MDQsNyBAQCBzdGF0
aWMgaW50IGhuczNfZ3JvX2NvbXBsZXRlKHN0cnVjdCBza19idWZmIA0KPj4+PiAqc2tiLCB1MzIg
bDIzNGluZm8pDQo+Pj4+ICAgIA0KPj4+PiAgICAJc2tiX3NoaW5mbyhza2IpLT5nc29fc2VncyA9
IE5BUElfR1JPX0NCKHNrYiktPmNvdW50Ow0KPj4+PiAgICAJaWYgKHRoLT5jd3IpDQo+Pj4+IC0J
CXNrYl9zaGluZm8oc2tiKS0+Z3NvX3R5cGUgfD0gU0tCX0dTT19UQ1BfRUNOOw0KPj4+PiArCQlz
a2Jfc2hpbmZvKHNrYiktPmdzb190eXBlIHw9IFNLQl9HU09fVENQX0FDQ0VDTjsNCj4+Pj4gICAg
DQo+Pj4+ICAgIAlpZiAobDIzNGluZm8gJiBCSVQoSE5TM19SWERfR1JPX0ZJWElEX0IpKQ0KPj4+
PiAgICAJCXNrYl9zaGluZm8oc2tiKS0+Z3NvX3R5cGUgfD0gU0tCX0dTT19UQ1BfRklYRURJRDsN
Cj4+PiBJIGFncmVlIHdpdGggUGFvbG8ncyBwcmV2aW91cyBwb2ludDsNCj4+PiBmb3IgYWxyZWFk
eSByZWxlYXNlZCBoYXJkd2FyZSwgaXQgaXMgaW5kZWVkIG5vdCBzdWl0YWJsZSB0byBtb2RpZnkg
aXQuDQo+Pj4gRHVyaW5nIHRoZSBoYXJkd2FyZSBhZ2dyZWdhdGlvbiBwcm9jZXNzLCB0aGUgQUNF
IHNpZ25hbCBtYXkgaGF2ZSBhbHJlYWR5IGJlZW4gbG9zdC4NCj4+Pg0KPj4+IEppamllIFNoYW8N
Cj4+IEhpIEppamllLA0KPj4NCj4+IEkgd291bGQgZGlzYWdyZWUgd2l0aCBub3QgZml4aW5nIG9u
IHJlbGVhc2VkIGhhcmR3YXJlLiAoRGlkIFBhb2xvIA0KPj4gZXhwbGljaXQgbWVudGlvbiB0aGF0
PykgVGhlIEFDQ0VDTiBwcm90b2NvbCBpcyBiYXNlZCBvbiBBQ0Ugc2lnbmFsLCBhbmQgYSBicm9r
ZW4gQUNFIHNpZ25hbCBtaWdodCBiZSBkdWUgdG8gU0tCX0dTT19UQ1BfRUNOIGF0IHRoZSBSWCBw
YXRoLg0KPj4gWW91IGNhbiBzZWUgdGhlIGV4cGxpY2l0IGV4cGxhbmF0aW9ucyBhbmQgZXhhbXBs
ZXMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KPj4gVGhlcmUgaXMgYWxyZWFkeSBhIGZpeCBpbiBw
YXRjaCANCj4+IDRlNGY3Y2VmYjEzMGFmNmFiYTZhMzkzYjJkMTM5MzBiNDkzOTBkZjkgZm9yIHRj
cF9ncm9fcmVjZWl2ZSgpIG9mIA0KPj4gdGNwX29mZmxvYWQuYw0KPj4NCj4+IEFuZCBJbiB0aGlz
IHBhdGNoIHNlcmllcywgd2Ugd291bGQgbGlrZSB0byBwcm9wb3NlIHRoZSBzaW1pbGFyIGZpeCBv
biBobnMzIGFuZCBtbHg1ZS4NCj4+IFdoaWxlIG9uZSBtYWluIGlzc3VlIGlzIHRvIGNvbmZpcm0g
aXMgaG93IHRoZSBHUk8gaXMgZG9uZSBpbiB0aGUgY29ycmVzcG9uZGluZyBIVy1HUk8uDQo+PiBB
bmQgaWYgdGhlIGRyaXZlciBjYW4gYmUgc2FmZWx5IGNoYW5nZWQgZnJvbSBTS0JfR1NPX1RDUF9F
Q04gdG8gU0tCX0dTT19UQ1BfQUNDRUNOLCB0aGVuIHdlIGNhbiBlbnN1cmUgRUNOIGFuZCBBY2NF
Q04gY2FuIGJlIHN1cHBvcnRlZCBvdmVyIGV4aXN0aW5nIGhhcmR3YXJlLg0KPg0KPlNvcnJ5IGZv
ciB0aGUgbGF0ZSByZXBseS4NCj4NCj5JdCBpcyBjb25maXJtZWQgdGhhdCBBQ0NfRUNOIGlzIG5v
dCBzdXBwb3J0ZWQuDQo+SFctR1JPIHdpbGwgc2V0IHRoZSBUT1MgZmllbGQgdG8gMC4NCj4NCj5K
aWppZSBTaGFvDQoNCkhpIEppamllLA0KDQpUaGFua3MgZm9yIHRoZSByZXBseS4NCg0KWW91IHNh
aWQgdGhhdCBIVy1HUk8gd2lsbCBzZXQgdGhlIFRPUyBmaWVsZCB0byAwLCB0aGlzIHdpbGwgYnJl
YWsgYm90aCBSRkMzMTY4IEVDTiBhbmQgQWNjRUNOLg0KDQpUaGVuLCBobnMzIGRyaXZlciBzaGFs
bCBub3QgdHJ5IHRvIHNldCBTS0JfR1NPX1RDUF9FQ04sIGFzIGl0IGRvZXMgbm90IHN1cHBvcnQg
YW55IEVDTiBtZWNoYW5pc20/DQoNClBsZWFzZSBjb3JyZWN0IG1lIGlmIEknbSB3cm9uZy4NCg0K
QmVzdCByZWdhcmRzLA0KQ2hpYS1ZdQ0K

