Return-Path: <linux-rdma+bounces-20890-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KxDDZfaCmog8wQAu9opvQ
	(envelope-from <linux-rdma+bounces-20890-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:23:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE58569A12
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 680A7303C7EC
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2441E3E3C4A;
	Mon, 18 May 2026 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="LUAmicPV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5D3E51E7;
	Mon, 18 May 2026 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096018; cv=fail; b=ifIPQS3VsRJaACzMmU0ZjX71Z89NST6TFmNsgJFsE+Mhy+NH0WRcVFzTvwZ3JaEdxnOMvp9FIHnZ93TyqMjNFbjNi92H9Ap04dDANvoZKOCp7/6bVpQT528T6man/IX2Y5xYs+bxX21EqIDSN3wjcydxQsrEOd2e0XhjeJu37l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096018; c=relaxed/simple;
	bh=xO+hVbbpzm2THPRa8w/U6hLrY1iS6zUh9as1TWOwBCw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VUIqBa3EYGERO9ZdkyGrK5gA12uj3JxsC8uJzYr5TAWRwUvQAFfmzMXIBbafZLSfOC97hH/ID53rQo6O3/SdDNz9bKpunL3WxWs27sCiK7lHVWFx5za8ZcTjxFIzPemrugxhH0aqWcwntYQbXUDNYGHFlwwDTX1D+JhAILwuUVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=LUAmicPV; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfH2b1z54rPPscOZJmxi9ApqnLhrXwXrbQsfvPN0+GWeUZMGFicXBsO4/73FrYAibvWW6MsDImbZLvIeTgN4CnL+6DMARqfTseRCtmxeb44HCFLHJvyKum64bpL14IugvDpigCJQ66GMcIFsygmzPjfDakDrNtXhR6oiZrfKpxSHgvEusqheKUytR5KYiiXhgzh+s7py+jfIDF4lu1ZCSC+2o7A5TbZ8Bl6i9mgvGoty1zTKj7093kx3QEeYi/gGtySSdOet2j3vW86zhMpVKkKEdfdfqRTCkUn4Ksj9SRatWDEZZiBQQFVIebutDrLaVW0NMEBkyZtpJohbVLLmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xO+hVbbpzm2THPRa8w/U6hLrY1iS6zUh9as1TWOwBCw=;
 b=AU5Z6zaOlbdTgXKksajhoX5XOBJEhmR5OJ/eC2R98iTieTeHypRHjLuyN38QdkJFrfBmXDq9EFMaHwRmBg2zks3UKBZUUX0i+50XD8RiLOaEgQJcqXglYsJzzt5zBgRNp9C0qmpZgMxLJPQE530oVJzEimsZvXK740SfIMVDGKNT5wZ/z8gHT80+BeOraeT8MOtsjyXBDCa5T1Tf2haKqds5sl8ylDgcTjXWYxxQraiUrRF2RlSQCNNY+zo2iSFrVWIm/x1shY8o7KxNVJ2Tlp0rOeiRU20zGw+S5RFOtFA/Zq2kceZEHPKZeyIoUeHQPE4tv8O+Iqm93AZuJ0VRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xO+hVbbpzm2THPRa8w/U6hLrY1iS6zUh9as1TWOwBCw=;
 b=LUAmicPVh45VROQhZ1IA7dctSOHlgUBgJ21o1O6cgquN3To9aBNkmFpWFje4XZGw6yReUPEvAp/fTQOJZ4Ys+dNMPamxyKqod9kHgMnI3nDe+ZZM2nLJPG4DakVqrAKOgNwfDtsmWIDc4WUmrGpvgvKlCchHjFn/xezNb5jLdPqizNHDjQCqlL7vL/Am9MsHjXQsAeOzCcZotHGaE7mEBvnyCkVDXzZuA7BrF8oiGDgV2MGxweLiaq8olX+syby/DRvXIFg8p7eQCydEk44IfFaVghH55YTxL/vhvcTVbYL0nljcsh7v/OjaIKMOnqNldJTP9zsrZOFhib0GP3SBqA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DBBPR07MB7674.eurprd07.prod.outlook.com (2603:10a6:10:1e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Mon, 18 May
 2026 09:20:10 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 09:20:10 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
	"linyunsheng@huawei.com" <linyunsheng@huawei.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "parav@nvidia.com" <parav@nvidia.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>, "shenjian15@huawei.com" <shenjian15@huawei.com>,
	"salil.mehta@huawei.com" <salil.mehta@huawei.com>, "shaojijie@huawei.com"
	<shaojijie@huawei.com>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "mbloch@nvidia.com"
	<mbloch@nvidia.com>, "leonro@nvidia.com" <leonro@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v4 net 2/3] net: mlx5e: fix CWR handling in drivers to
 preserve ACE signal
Thread-Topic: [PATCH v4 net 2/3] net: mlx5e: fix CWR handling in drivers to
 preserve ACE signal
Thread-Index: AQHczn6f0twYI64FckqHOyx2gZ15hbXsSTaAgAByMYCAADgPAIAAKsaAgCZ/ksA=
Date: Mon, 18 May 2026 09:20:09 +0000
Message-ID:
 <PAXPR07MB79846075432AA7F7CAD67006A3032@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
 <20260417152642.71674-3-chia-yu.chang@nokia-bell-labs.com>
 <69750ae3-3b0f-41c7-9731-6d49f5f6d319@redhat.com>
 <e5d03a71-cfcd-417b-a3b3-94dbd6600f9d@nvidia.com>
 <e6aa13f1-4284-4ae0-9dda-1a506e729156@redhat.com>
 <8b610e49-ff64-497e-8712-588b2228df02@nvidia.com>
In-Reply-To: <8b610e49-ff64-497e-8712-588b2228df02@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DBBPR07MB7674:EE_
x-ms-office365-filtering-correlation-id: bf645fe1-6100-42dc-0867-08deb4bea8a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|11063799003|56012099003|38070700021|921020|22082099003|18002099003|3023799003|4143699003;
x-microsoft-antispam-message-info:
 NFJjfJRPEO4awm77W/Dn2qm/ouC3KnYdAUyfcMquehZbrRpEWBFHB0a9xm6z41qqcVdZdA02FDwa8vWw/ZFevW5tTYRkFLapmgth+eysRC6s3pmPjYD5m9zWWHXH2w23WkhcqgT56LSlx7XDU1o5jxhLeekrYaGEQIh17ezpToRodToRdI7Fdaa3O/r4N+MlfFQlCTZwSTNB4502wvoo0idWDyyRXAlCDvBjrjog8lQxUsUm8sHBz/Et1Y74pc4HUl8Y/BnjpA8JOaCPu159qSdYqVa8KYP5WHPxHApg25+nI165LfBR+p+nYbCT60lShltQpJW4W8i0XLa5HxzMsCBz/Q+b+6Bb2MvwU9chCemmi6z+2GTsZYGnZejP8yKIL/5lcbZqscts1R9cRMS2Bg0Iy8B9r23N1DipPu44232OW2Dz2FW3X9lCTnHP5VoJ1fazf3aufnnrR1NsuAIZmXpt3aDUxbK1nW7HzLs3vToeg6xAKqT6AVHKZYXfCVny+UrAz//12qTqJeiK2V+6H7Vuzw4oj4SbWyFdPhk/BREKL30N7ApcAUeqnIyMncSw3io1CEKnB07O0c/YDDNkASauHpd5oE+AzEYAJ+zIK3nFxeIx1U4PtN8XRv9ISsttJ0SjVhbFlsUr/nyYd++iVU+nCM0+nezxPyLmSX1P7Wa/Tz8aW0pPzAdAGy22yeGlFMNb8E/dLw9HnZHgKkZVqrCjVH7lfhSRaksiGLz/ml8gSC4O6pjrSBzifCKlb0nOQwLSaPI+pNOUWJU0xZDpDg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(11063799003)(56012099003)(38070700021)(921020)(22082099003)(18002099003)(3023799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUliQTU5Um12dzZ1YUZDNE9NRWY3ZnVKWFJNRmhmeUJnMCt5N1VyVWM3L1pE?=
 =?utf-8?B?bWNNdHdBT2Q4THBrNmJyWi9mb2xsSjBNOS9nRm5wTWZMSWZCUjhMUHBiai93?=
 =?utf-8?B?cmJ0N3VqMkNBcFJqZ2xmSDhwbDdjRnpoWHdSeGtpSlA4MDNHQ0dRdWtvRWxQ?=
 =?utf-8?B?c2tMYkE3RnZtNlo3V1kyUEd2d3hBNDRCVjd4UU5CWjBkajZPS21lZHRETEVE?=
 =?utf-8?B?a3dwdDVJV1hlQjRFNDdXY05wNnRUekc3bkljM0J0dTRaOXZ1UHUrSVRwUTVP?=
 =?utf-8?B?VHVpbjZLT29WRlJzQXVCUklYNU00Y1J0cUFFMS9Ba0UrYkxTK05hYTRNZC9n?=
 =?utf-8?B?YTFGeTJvVTRraXFlcXl4U1VnelVvQjVVOVc4cC8rR3lrdE5QV0RGQUVtdW5B?=
 =?utf-8?B?VXc1eHIwN2xnY0ZJeTZsM1hzd2g2clRiazVhbmJDUlEwTlJLL1AxamZDUzNC?=
 =?utf-8?B?ODNkaUp3M2lpTWdWbnFjYWVibVdKQjJsc2hmM1pRQm5DTTZteGowMExISzN2?=
 =?utf-8?B?RjlOVlp5dVdvNzVMVlQ1UWZPWmNJM1lYall4cTJPSmczaHZmMDBwQXJ0MXhx?=
 =?utf-8?B?RjNEUVR1N0VoeW9VWEsyZVZxMHl2Zlo3dnJhRXlxWHNxUTlya0pDYWh4Sytr?=
 =?utf-8?B?K0c2R3Q1RjBvUW1PTmdLVEVRM1hBeXBqTFNtU09EQWUzQk5QZVgwdTlsSVNT?=
 =?utf-8?B?U2o0cTdQRG1KeFF2UUdaT2ZYeVBXU3M3clpCMVBwNExIZDFuak4yY3NIVDcv?=
 =?utf-8?B?T0F0aFA1cUNEUUpDSGV4UTJBYW1CaHJyaHd6TXFNNGt1VUwzQ2UvUlVNRExx?=
 =?utf-8?B?WVVnQjNUMFJEQzM4cUtaVlI0SGhodnhMUERUM0ZYdEFnZitVMzl0alJ1WEZ2?=
 =?utf-8?B?TlVONG9SdGZWWTE1MzBtWitJZksvOW1vUWFvL0k1c0cyYisxc2Rwc3dZWDVk?=
 =?utf-8?B?V0FhKzhncnJaMzZCRHFGTkk4WjdpRW9BQzVvZTZac0pVSUR0T3laUjEvSVFu?=
 =?utf-8?B?MElPaUVKVHRRTmM0dW1MdDRVRW43TUlpb0FiSHBCcnhoV2lOWGNnNThhOXBl?=
 =?utf-8?B?ZFU1SHptaFczcG05b1Joby9xOC9GdTJyVHBaeGh4MmhBWEhyU0dnVFN3U1cz?=
 =?utf-8?B?dHpZWUQ1U3AvOHlVQk9KVU9NcEg5aCtMNTN4K3dQc1Y1aG54NEdEQkE1RTFk?=
 =?utf-8?B?RXpyYmZwWm5RcEZPMEhQcEptSTNQcmg2cUVPV2NLNnN0RkVOUVhmSnVGUjJG?=
 =?utf-8?B?M3dmMk05SjVWdjFrU3Rsb0JnZmdTVnJTT3kxdEJkSUkrNGFHSjk0SW40V00w?=
 =?utf-8?B?UG9OeHJTM1NDc2UyU1Z2QkJiUmVhTTFOUEw3dFlrZXpGWHBXZVF6Y3g4NUxt?=
 =?utf-8?B?dTNTSVBFS21yaVVjZVlKSmlkdkNsNEh5ZlJ3ZHlNSnNZaE9IMVlSamtnSURD?=
 =?utf-8?B?NmRnTXp3ZGNVMGwwNjh1TUdjYSs1N1pERVh3TlNaQ2d2WitIZlErTTBxMGJv?=
 =?utf-8?B?WkRvRldCSVpIeHJiTVBPeXo1ZEhSbkhLODdxcklrSk9aZUhCcGMwdU9sVmww?=
 =?utf-8?B?MERDaHV4Z1JrWmpHL0prOHUrOC90ODF3ZVA5OWxISzQ3OW1UWG53Qk0yQzEr?=
 =?utf-8?B?Z215RlJSMS80MjVhdmNSVm5xTlZDM3h3bk8wS2QvbzhpMHdiZFZDaUg1Vjg2?=
 =?utf-8?B?TEtiT3Y2TjhuenJ1bmtjdDJrbTlndk9VTjFidXVaNUZwd1BhTVhyQWF1ZDhG?=
 =?utf-8?B?VWw3YUNmV3F5Z1VBSkw0SFkrajNMS2xuckFIRzJ3T1JYcDJxZ1BOUWY5Z05F?=
 =?utf-8?B?MzRsMkxJdStZOW1uNktuSjFYV2dXd2FvZEs2SVRnbFlyZk9jdjJ2cVdtTDBW?=
 =?utf-8?B?UUhpanNWOHJhK1M3T25FNlFYL3dBbm1yOHN6T0luTGRrczNxZkNJVlM0bGpK?=
 =?utf-8?B?QnQyOVBIWTNYZlcydjVjc3RYS3llMXM2akpabGIvVkRKVGQyNGcwb21VUVQr?=
 =?utf-8?B?NHl1RlF3MWlxT2RTS3NiRUFhMCtObGtOWkpvcjkyMWRZRllSMjJvcityeS9p?=
 =?utf-8?B?L3FJbEFOT1NOS1ZjMytzMW9iRmx3SEV4MDFWL1NrY0hOMms5WjlOa3Jydmgz?=
 =?utf-8?B?cW1ieVJLdkxtaHNkcDFnOGhSV1hOcUl5MEhZdWxFOTZ0aWs0MzkzS000VElk?=
 =?utf-8?B?d05kNlpCaWY0NGtNS0hpSWtGSWFOQXp3TDBuV3k1Qkg3ZTVBZjRxMzhEeWFW?=
 =?utf-8?B?WmRDTlgvQU9sdThzbTVobFBGcG8rT3ZWbTVLRXJOa2lLZjFFWjJXdXBBUDJU?=
 =?utf-8?B?YlJOVDNPVUxPUC90TmpZVWtiZEJiVG45UjcwczNrRUc2WEFENUpNQlVlVXAr?=
 =?utf-8?Q?/IQLbh/4Jsi85C9U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf645fe1-6100-42dc-0867-08deb4bea8a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 09:20:09.9469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cguc+qFdmBKXsmtPR3PR6czGfmffuQs1Xv0DtB+Crg+rLFh+c/8dRvkl1sbmeeuGX6KFbGfxzXh3spQiiLhn7zEBxpFT1bnGr+Oedk/5LBeQ75jlPPNuZUwr3b1G3ECl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7674
X-Rspamd-Queue-Id: ABE58569A12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-20890-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,redhat.com,huawei.com,lunn.ch,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
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
	NEURAL_HAM(-0.00)[-0.995];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1
bGVhQG52aWRpYS5jb20+IA0KPlNlbnQ6IFRodXJzZGF5LCBBcHJpbCAyMywgMjAyNiAxMDoxMyBQ
TQ0KPlRvOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBDaGlhLVl1IENoYW5nIChO
b2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT47IGxpbnl1bnNoZW5nQGh1
YXdlaS5jb207IGFuZHJldytuZXRkZXZAbHVubi5jaDsgcGFyYXZAbnZpZGlhLmNvbTsgamFzb3dh
bmdAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207IHNoZW5qaWFuMTVAaHVhd2VpLmNvbTsgc2Fs
aWwubWVodGFAaHVhd2VpLmNvbTsgc2hhb2ppamllQGh1YXdlaS5jb207IHNhZWVkbUBudmlkaWEu
Y29tOyB0YXJpcXRAbnZpZGlhLmNvbTsgbWJsb2NoQG52aWRpYS5jb207IGxlb25yb0BudmlkaWEu
Y29tOyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3Jn
OyBob3Jtc0BrZXJuZWwub3JnOyBpakBrZXJuZWwub3JnOyBuY2FyZHdlbGxAZ29vZ2xlLmNvbTsg
S29lbiBEZSBTY2hlcHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFi
cy5jb20+OyBnLndoaXRlQGNhYmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hhbnNzb25AZXJpY3Nz
b24uY29tOyBtaXJqYS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmVAYXBwbGUuY29t
OyBycy5pZXRmQGdteC5hdDsgSmFzb25fTGl2aW5nb29kQGNvbWNhc3QuY29tOyB2aWRoaV9nb2Vs
QGFwcGxlLmNvbQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgbmV0IDIvM10gbmV0OiBtbHg1ZTog
Zml4IENXUiBoYW5kbGluZyBpbiBkcml2ZXJzIHRvIHByZXNlcnZlIEFDRSBzaWduYWwNCj4NCj4N
Cj5DQVVUSU9OOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJl
ZnVsIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gU2VlIHRoZSBV
Ukwgbm9rLml0L2V4dCBmb3IgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4NCj4NCj4NCj5PbiAy
My4wNC4yNiAxOTo0MCwgUGFvbG8gQWJlbmkgd3JvdGU6DQo+PiBPbiA0LzIzLzI2IDQ6MTkgUE0s
IERyYWdvcyBUYXR1bGVhIHdyb3RlOg0KPj4+IE9uIDIzLjA0LjI2IDA5OjMwLCBQYW9sbyBBYmVu
aSB3cm90ZToNCj4+PiBbLi4uXQ0KPj4+Pj4gLS0tDQo+Pj4+PiAgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX3J4LmMgfCA0ICsrLS0NCj4+Pj4+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fcnguYyAN
Cj4+Pj4+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX3J4LmMN
Cj4+Pj4+IGluZGV4IDViNjBhYTQ3Yzc1Yi4uOWIxYzgwMDc5NTMyIDEwMDY0NA0KPj4+Pj4gLS0t
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX3J4LmMNCj4+Pj4+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbl9yeC5jDQo+
Pj4+PiBAQCAtMTE4MCw3ICsxMTgwLDcgQEAgc3RhdGljIHZvaWQgbWx4NWVfc2hhbXBvX3VwZGF0
ZV9pcHY0X3RjcF9oZHIoc3RydWN0IG1seDVlX3JxICpycSwgc3RydWN0IGlwaGRyICoNCj4+Pj4+
ICAgIHNrYi0+Y3N1bV9vZmZzZXQgPSBvZmZzZXRvZihzdHJ1Y3QgdGNwaGRyLCBjaGVjayk7DQo+
Pj4+Pg0KPj4+Pj4gICAgaWYgKHRjcC0+Y3dyKQ0KPj4+Pj4gLSAgICAgICAgICBza2Jfc2hpbmZv
KHNrYiktPmdzb190eXBlIHw9IFNLQl9HU09fVENQX0VDTjsNCj4+Pj4+ICsgICAgICAgICAgc2ti
X3NoaW5mbyhza2IpLT5nc29fdHlwZSB8PSBTS0JfR1NPX1RDUF9BQ0NFQ047DQo+Pj4+DQo+Pj4+
IEhlcmUgdGhlcmUgaXMgYW4gb3BlbiBxdWVzdGlvbiBmb3IgblZpZGlhOg0KPj4+Pg0KPj4+IFNv
cnJ5IGZvciBtaXNzaW5nIHRoaXMgcXVlc3Rpb24gaW4gdjMuDQo+Pj4NCj4+Pj4gSXMgdGhlIGFi
b3ZlIGVub3VnaCBvciB3aWxsIGxhdGVyIHNlZ21lbnRhdGlvbiBsZWFkIHRvIHRoZSB3cm9uZyAN
Cj4+Pj4gcmVzdWx0cz8gSSB0aGluay9ndWVzcyB0aGUgZmlybXdhcmUgaXMgKHN0aWxsKSBhZ2dy
ZWdhdGluZyB0aGUgd2lyZSANCj4+Pj4gZnJhbWVzIHVzaW5nIHRoZSBFQ04gc2NoZW1hLCBpLmUu
IHRoZSBmaXJzdCB3aXJlIHBhY2tldCBoYXMgQ1dSID09IA0KPj4+PiAxLCB0aGUgbGF0ZXIgQ1dS
PT0wLg0KPj4+Pg0KPj4+IEZvciBtbHg1IEhXLUdSTyBhIHBhY2tldCB3aXRoIHRoZSBDV1IgZmxh
ZyB3aWxsIGZsdXNoIHRoZSBwcmV2aW91cyANCj4+PiBHUk8gc2Vzc2lvbiBhbmQgd2lsbCBub3Qg
c3RhcnQgYSBHUk8gc2Vzc2lvbiBmb3IgdGhpcyBwYWNrZXQgDQo+Pj4gKG5hcGlfZ3JvX3JlY2Vp
dmUoKSB3aWxsIGJlIGNhbGxlZCBvbiB0aGlzIHNpbmdsZSBzZWdtZW50IHNrYikuDQo+Pj4NCj4+
PiBTbyB0aGlzIGNoYW5nZSB3b24ndCBpbXBhY3QgdGhlIGN1cnJlbnQgR1JPIGJlaGF2aW9yIGZy
b20gdGhlIG1seDUgZHJpdmVyL2h3IHNpZGUuDQo+Pg0KPj4gT0ssIHRoYW5rcyENCj4+DQo+PiBG
b3IgbXkgZWR1Y2F0aW9uOiBkb2Vzbid0IHRoZSBhYm92ZSBhbHNvIG1lYW5zIHRoYXQgbWx4NSB3
aWxsIG5ldmVyIA0KPj4gYnVpbGQgR1NPIHBhY2tldHMgd2l0aCBDV1Igc2V0IChhbmQgc28gdGhl
IGFib3ZlIHN0YXRlbWVudCBzaG91bGQgDQo+PiBuZXZlciBiZSByZWFjaGVkKT8NCj4+DQo+SXQg
ZG9lcyBsb29rIGxpa2UgaXQuLi4gVGhhbmtzIGZvciBwb2ludGluZyBpdCBvdXQhIFdpbGwgYmUg
YWRkcmVzc2VkIGluIGEgcGF0Y2guDQo+DQo+VGhhbmtzLA0KPkRyYWdvcw0KDQpIaSBQYW9sbyBh
bmQgRHJhZ29zLA0KDQpGaXJzdCwgc29ycnkgZm9yIG15IGxhdGUgcmVwbHkgYW5kIHRoYW5rcyBm
b3IgY2xhcmlmaWNhdGlvbi4NCg0KVGhlIHRhYmxlIGJlbG93IGlzIHRvIGVuc3VyZSBteSB1bmRl
cnN0YW5kaW5nIG9mIG1seDUgaXMgY29ycmVjdC4NCg0KKz09PT09PT09PT09PT09PT09PT0rPT09
PT09PT09PSs9PT09PT09PT09PT09PT0rPT09PT09PT09PT09PT09PT0rDQp8ICAgICBQYWNrZXQg
aWQgICAgIHwgQ1dSIGZsYWcgfCAgIEZsdXNoaW5nPyAgIHwgICAgIGdzb190eXBlICAgIHwNCis9
PT09PT09PT09PT09PT09PT09Kz09PT09PT09PT0rPT09PT09PT09PT09PT09Kz09PT09PT09PT09
PT09PT09Kw0KfCAgICAgICAgIDAgICAgICAgICB8ICAgICAwICAgIHwgICAgICAgMCAgICAgICB8
ICAgICAgICAwICAgICAgICB8DQp8ICAgICAgICAuLi4gICAgICAgIHwgICAgIDAgICAgfCAgICAg
ICAwICAgICAgIHwgICAgICAgIDAgICAgICAgIHwNCnwgICAgICAgbiAtIDEgICAgICAgfCAgICAg
MCAgICB8ICAgICAgIDEgICAgICAgfCAgICAgICAgMCAgICAgICAgfA0KKy0tLS0tLS0tLS0tLS0t
LS0tLS0rLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0rDQp8ICAg
ICAgICAgbiAgICAgICAgIHwgICAgIDEgICAgfCAgICAgICAxICAgICAgIHwgU0tCX0dTT19UQ1Bf
RUNOIHwNCnwgICAgICAgbiArIDEgICAgICAgfCAgICAgMCAgICB8ICAgICAgIDEgICAgICAgfCAg
ICAgICAgMCAgICAgICAgfA0KKy0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLSstLS0tLS0t
LS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0rDQp8ICAgICAgIG4gKyAyICAgICAgIHwgICAgIDEg
ICAgfCAgICAgICAxICAgICAgIHwgU0tCX0dTT19UQ1BfRUNOIHwNCnwgICAgICAgbiArIDMgICAg
ICAgfCAgICAgMSAgICB8ICAgICAgIDEgICAgICAgfCBTS0JfR1NPX1RDUF9FQ04gfA0KKz09PT09
PT09PT09PT09PT09PT0rPT09PT09PT09PSs9PT09PT09PT09PT09PT0rPT09PT09PT09PT09PT09
PT0rDQoNCkN1cnJlbnRseSwgbWx4NSB3aWxsIGZsdXNoIEdSTyBzZXNzaW9uIGFuZCBlbWl0IGEg
c2luZ2xlIHBhY2tldCB3aGVuIHRoZSBDV1IgZmxhZyBpcyBzZXQgb24gdGhlIFJYLg0KDQpTbywg
dGhpcyBwYXRjaCAoY2hhbmdpbmcgZ3NvX3R5cGUgZnJvbSBTS0JfR1NPX1RDUF9FQ04gdG8gU0tC
X0dTT19UQ1BfQUNDRUNOKSBzZWVtcyBtb3JlIGZvciBmdXR1cmUtcHJvb2YgdGhhbiBhIGJ1ZyBm
aXguDQoNCkkgd2lsbCB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlIHRvIHNwY2lmeSB0aGF0IChv
ciBwbGVhc2Ugc3VnZ2VzdCBvdGhlciBjaGFuZ2VzIG5lZWRlZCkuDQoNClRoYW5rcyENCkNoaWEt
WXUNCg==

