Return-Path: <linux-rdma+bounces-1558-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23F888B558
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 00:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FB81C3A0DD
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 23:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89193839FC;
	Mon, 25 Mar 2024 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NITTYHRu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2112.outbound.protection.outlook.com [40.107.7.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB4839F3;
	Mon, 25 Mar 2024 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409603; cv=fail; b=VGQaQFlrzjyKDwjDVLkk33fXKRDGAupsqx2EUHC2cik5noliFkxp06x3ppKG2DRPq4DewlccLjt/4wzGJXB6HLbSZKXuZZhBN3MjQq1s6AzcWFdK6RZYoL6RU7uBBpmJW/rjz1zXn9PWjCdw9lVzNQmL3IuhcL6R0YnSnT97COM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409603; c=relaxed/simple;
	bh=tBM+wOmmVQEQqhQ8YBqUIz+4j+i8CuXrCT8j49i6CAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IxKJWWdo8/SGtDHrr5T3ER9LgFvpeSo59I83RY5nsHfot/TIsoIdk+izcgTpnngi4vSz32Nc2Ri6a8uoRylmMRvlRol0U3QGSzSNi2UXmDzHGU6KzLIWoZfJb2jgAnmpLVH0AxwrlZZhc2Z5lLBCPgZ1OpeGGrvOnRBZqwnksNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NITTYHRu; arc=fail smtp.client-ip=40.107.7.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEU6VrQVZf/k/9BQRoM2mnm8D8EJMWKshJc1VKXLWVl3yRvVkJkeFCwXmdOq1kuFCK9nH3kv83S/DzRo+JWvZyC4ABChVcRmfuiVCURIlCMYec0ixlJyOhlaiy/ydoBpJJjygKzYcZK19BPXbCXy9hB0immMI5e48XdSKE7pw9zqeZ2VKvzXiYBQclyIx54/T6BDYBm3wVHheZvVg08H4541vXNQArmyzfhEmzo2QZeImzhi6NE3G8OrXsElvZJZ/6xLJeI5tjihCkxaZgTnOvdv1igplUnBUe3y6KzkrGmoeuMnC2G1H8UVKUV7QOTKKrmE1/pBfJymBfNX8LBAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBM+wOmmVQEQqhQ8YBqUIz+4j+i8CuXrCT8j49i6CAQ=;
 b=WnZ/nYD/ZzM0RG1s75yA/LfB73w0aKGO79SxvbsznxPPrCGHCwEu9ldya+MbLWxQn5yevqBtOVpNuCmOyIJURW7RQIaI/5VEHC2VKCWdlYJNUzDvyKr4Oy/TQVlJMo5ABXobrS7KdDJsa8T/RCt1vTHG+NI0Nurl4q7KnlZZoIR+xuK9aeQkweeqYTVNjzuWvrduK2IERbZoBnncvCRxDLaKw8jtRwUYtSSI+SOAWovUG7ELsDrImhHTKB3goJpbKh2+vyU2/Ub9pVAgp5qMqwC7NNIeEiCAizlmak8nkCZpnPjZ9Tmzpm/7XVjzviSPw4l/jgjCeNpj2E5i90nvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBM+wOmmVQEQqhQ8YBqUIz+4j+i8CuXrCT8j49i6CAQ=;
 b=NITTYHRuhF1DnAxCvij95kJVeApP9CtUnLFjircoEyR0mEEjbNjNNxjlsXFU6I4JPtdiBm7lC29zj4YXrdzah7SgjvkVD58tWGiwqr/VhMHDRdxou4ttvFB2BI01QdhOTF027l/8tT56QlqLfFGkFJMbfw70N4IYfXQ4j1IYl5k=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by GV1PR83MB0604.EURPRD83.prod.outlook.com (2603:10a6:150:164::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.19; Mon, 25 Mar
 2024 23:33:17 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572%6]) with mapi id 15.20.7430.021; Mon, 25 Mar 2024
 23:33:15 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 4/4] RDMA/mana_ib: Use struct mana_ib_queue
 for RAW QPs
Thread-Topic: [PATCH rdma-next v2 4/4] RDMA/mana_ib: Use struct mana_ib_queue
 for RAW QPs
Thread-Index: AQHaeh7y6nDPqyfnDUGtka/+kAc0x7FI5HkAgAAUIZCAAAPqgIAAKCjg
Date: Mon, 25 Mar 2024 23:33:15 +0000
Message-ID:
 <PAXPR83MB0557EC87F91A7AFD05C6C1F6B4362@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1710867613-4798-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710867613-4798-5-git-send-email-kotaranov@linux.microsoft.com>
 <SJ1PR21MB345735033DFA7CFF14B7BBD5CE362@SJ1PR21MB3457.namprd21.prod.outlook.com>
 <AS1PR83MB05435D612E76C1F4488FE99CB4362@AS1PR83MB0543.EURPRD83.prod.outlook.com>
 <SJ1PR21MB345727F29DD1E4608A335B43CE362@SJ1PR21MB3457.namprd21.prod.outlook.com>
In-Reply-To:
 <SJ1PR21MB345727F29DD1E4608A335B43CE362@SJ1PR21MB3457.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1de6e87c-a583-43bc-aa2c-c97facb0b9ad;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-25T19:38:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|GV1PR83MB0604:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Pd8wLfu4OUFeoH/gx6hsEBeNdYDJgRjk86Wp4LF29W6mGx7xo/3eJU0eg+wbK71cTFUU/ffyTtZ0WQ+/nnjgd3DibmlpBmdnkXprNaiiCNBncdDJe718aioo1brrsERty/TtZR+EMc+X1H2CC8UqjTMCrL/zZD4UV7cpiOgnGUELk56ZcAg6+Smu97eE0rnZLsTGtVjFnszFjSRJfV2Lq3lwniMRVT/2OsH9Dv8r5U+k/hqDrXBWgI+ar+CtB/23mCqH+E2fagwUdhSlYp2+nsN9vn/Rt412cbu/XbXbTJGo4Y5FYzGdbYoIZaJSp5K/E7hYvlkvGpMNlMOPN593vvY7mHFvibvgrlWkdzU8Rlb25sWtCWGx2SDNLE4bXWvL1ZMRg6om3SNrRbn8Su93yO+J6AzY2bb0PDMVgTAyKmwU7AETowcq4Q0uAJ+uilteZa9RLAoAyeiD2zCIfCVZAKpIdOVTnxUmQdoK2X4fg0Uz2U9cF5qRx628Y9Pbr9BCRmuDBHHYstYoMkg18K+AkBf3O1KxoO97cw4LZOWREOMqLiHEDr14pycjomTg9SG4NJWi5M9mG5k+96aOc1Rsjle0dURWV9IfFOgTVX2Z65cg+JuI9L8bn2iwCRGM6LfuBX5c8v9LZqUoUe/hiCeJ05Lan4JP1NczqwS1+69Tq2M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWllaEs4YndWOWYrQ3hjejl0c2hBdUR4aVdGTUN5UWdVTjVzaEFUeUZLcTMx?=
 =?utf-8?B?OFE5QVlPV1VrdTJSSjhBbytieG40Q3FwTFFQSEpyL3RPTEhkV3VNcWtkdFlr?=
 =?utf-8?B?YUN5ZXloR1Ftd2ZVZFEvWWNBbzMwTkJPa0hMa1JINUo4VjhzZ3JlS3V5K01N?=
 =?utf-8?B?SnpVYkI5VXdjK3hiWmoxNWVkR2dVT0w2STZOVkRZN3NYanZMeUZaN0V1elBi?=
 =?utf-8?B?ZTBENGxnR2F0d0ZxZ3Q2Wm9VdCswa1F4VkNoZ1J4NTA5V3c4MEFQdHdvdHVh?=
 =?utf-8?B?UmVtNEMzazI0VWVlZC9KL2x3MllKUXh2SFUvZjZnWTV3VFM0dnNOVlZoTEor?=
 =?utf-8?B?bGJsOUpGckRjYjB0N0R4WUpjTXJlNG5oTll6Zmd5ZVFxQTNIaEszKzM2Tk02?=
 =?utf-8?B?UjB5R3NjREpRekJEYklRK2JsVzVTRTV6ck0rSjdERmNSajlnZzd0bjlRRWpM?=
 =?utf-8?B?amVVVXBQbFZVTFd5aHVueDhnY1dXY3lDQWlvYnJvT0dhYThWZmswb29vZFZP?=
 =?utf-8?B?citOMDJ0YUdKZzJlL1M5VjlrOTRURStzRTVWc3dBekZCaktuV2lFRjVsNlV2?=
 =?utf-8?B?K2pQZW1Ga3FRUVhmaUFrYXRVQ2V1L2RUckM2aklOaWVZSHY5Sys1dDBmS01q?=
 =?utf-8?B?MFVBYzd4UUVKajlIbm11aTFMMmZXSVZSaU1LVm9aSlBGaTk2MjNEeU1COFFp?=
 =?utf-8?B?MVV4azJMRVJiV0lKZXlVcUZKY24xMmU1L1lJK1hUbzFiTjNnK2dGb0ZSV2J1?=
 =?utf-8?B?RWlBdGJjbkUySkQvWUx4YTVyclZYbE15V2N6SFNOSVJMcVNQNWVQaEo5QzVQ?=
 =?utf-8?B?bEd3MU1DQ3daODdKSWVhcjc2VW1SeVZmY3ZjNEhZNDVqQjhud2RjdVUvQWRV?=
 =?utf-8?B?UndPcHlpNVExUjhST0xHTWwzWCtmMXIxbkpYbHJ1MFVUZFF4c2dTNmdzWXRF?=
 =?utf-8?B?MWRmYzBUeWpmbGxMOWlreXJxMExHdWpCTGdZQkx1MGxMYjUxa0QxdEJUNVBr?=
 =?utf-8?B?Ni9QbWdQTFlzc0h4eXhVSTVubjdONkZrUnc5b09lYmFSVmEzZStIMnYyWGJw?=
 =?utf-8?B?dEFXNzEyVzRQV1p2ZUpXY09lRzdRMEdrZ3JXbnI2bzEyaDNBUm9CT1pnY0xV?=
 =?utf-8?B?d2tTRW1YN215RUtSNmpDbVZ6WVZJOTUyMW84RWhCOFU3enlQNTVXRGVVQzNC?=
 =?utf-8?B?V2R0VFoyakV2OG5HZno5eEhTekRpNFErSi8rUDZGa3VKS1NTZVFEQjZVYS80?=
 =?utf-8?B?VjJaN282bnluT20reFYrMURzVXBpNC84RE5vL1V5SlBLZUltNy9yMmhPcFRR?=
 =?utf-8?B?dFpjNXR4Zys0cDNibHppT25ZRHJ5V1JKNUNCcEpON0VOTGV6ODgwQ0JabFBh?=
 =?utf-8?B?dW44ck0yZmtOTkZVbzVKSjdneGtiNkI1NUNLNmJvV2l0NnJ5dXF6WEo5aW5E?=
 =?utf-8?B?R2t5SUwyMHJTb2pzUDdVcXIrYXpaRXVKNVdMQ2RlWEh5SU1wZUdFZ29ud2dl?=
 =?utf-8?B?bC94YnA3SDJTSGUyMEgydEJqeHdKb1pSNzh4YTVRMnEvYTl1d21tWFBZQ3NE?=
 =?utf-8?B?UnpNSXVVQ3RHVHVvVldCMFN1aFRodEZUVXB4NkxMZThhQmQxK05EVkpMdDBV?=
 =?utf-8?B?eW52QVZ6cWwzckh2REppZlhEM2hZUVp0dTViWUJpWk1FYkdUMGROTDU2aDJk?=
 =?utf-8?B?R2xEQnFpNUJmNjJHM2Z1VnBna0szRzZZNVZMaFhYSVp6a0srRDV2U3VEQmRM?=
 =?utf-8?B?WGJMZUkwbXM4bm5lNkVoaytRQTBCSEZJZ2RMU3dhYXNRaGl2SFBFU3NmcE1k?=
 =?utf-8?B?eWI4MDdaL3NERkNwLzhmekVMNnl1Nm1VSU1tOExBQk5PdVUxVkZlNFdCc2l5?=
 =?utf-8?B?aThqRzJjZEhzOEE3dGhSUUQ4ZXE5TnJkQVpMd2h1anVmdXJQM3U4eFNubVhq?=
 =?utf-8?B?TGk4MlJ5VHc5VlNEbFpXN1lsYkVUQWFXK2gvMklkZDdYOVdEV2FBc2E2ZFZJ?=
 =?utf-8?B?cHY1S0NCUGFiZm5IVUNOWm5SYktBQlhnallZKzVaTzRpSXd6ZG52RGZDNzdK?=
 =?utf-8?Q?Nwigxa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0557.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98e8387-016d-4057-fdca-08dc4d23f18e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 23:33:15.1549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kIXq7SWwrujW2U9Pijmbdz+AR2wTX9pe2C4y+su0oE5LfPAFWm+1AlyULnNHKQ25jv+6CX8TWgjYw+LkICTa6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0604

PiA+ID4gPiAgc3RydWN0IG1hbmFfaWJfcXAgew0KPiA+ID4gPiAgCXN0cnVjdCBpYl9xcCBpYnFw
Ow0KPiA+ID4gPg0KPiA+ID4gPiAtCS8qIFdvcmsgcXVldWUgaW5mbyAqLw0KPiA+ID4gPiAtCXN0
cnVjdCBpYl91bWVtICpzcV91bWVtOw0KPiA+ID4gPiAtCWludCBzcWU7DQo+ID4gPiA+IC0JdTY0
IHNxX2dkbWFfcmVnaW9uOw0KPiA+ID4gPiAtCXU2NCBzcV9pZDsNCj4gPiA+ID4gLQltYW5hX2hh
bmRsZV90IHR4X29iamVjdDsNCj4gPiA+ID4gKwlzdHJ1Y3QgbWFuYV9pYl9yYXdfc3Egc3E7DQo+
ID4gPg0KPiA+ID4gQXJlIHlvdSBwbGFubmluZyB0byBhZGQgYW5vdGhlciB0eXBlIG9mIHNxIGZv
ciBSQyBoZXJlPw0KPiA+ID4NCj4gPg0KPiA+IFRoZXJlIHdpbGwgYmUgbm8gbW9yZSBTUXMuIFRo
ZXJlIHdpbGwgYmUgcmNfcXAsIHVkX3FwLCB1Y19xcCwgd2hpY2ggaGF2ZQ0KPiBzZXZlcmFsDQo+
ID4gcXVldWVzIGluc2lkZS4NCj4gDQo+IEFyZSB5b3UgZ29pbmcgdG8gcHV0IHJjX3FwIGluc2lk
ZSBzdHJ1Y3QgbWFuYV9pYl9xcD8gT3IgaXMgaXQgYW5vdGhlciBzdHJ1Y3QNCj4gY29udGFpbmlu
ZyBtYW5hX2liX3FwPw0KDQpJdCB3aWxsIGJlIGxpa2UgdGhhdDogDQpzdHJ1Y3QgbWFuYV9pYl9x
cCB7DQpzdHJ1Y3QgaWJfcXAgaWJxcDsNCg0KdW5pb24geyANCnN0cnVjdCBtYW5hX2liX3Jhd19z
cSBzcTsNCnN0cnVjdCBtYW5hX2liX3JjX3FwIHJjX3FwOw0Kc3RydWN0IG1hbmFfaWJfdWRfcXAg
dWRfcXA7DQp9Ow0KfTsNCg==

