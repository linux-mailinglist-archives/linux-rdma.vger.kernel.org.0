Return-Path: <linux-rdma+bounces-1312-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00F4874C9E
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 11:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261D81F22A78
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 10:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB5585280;
	Thu,  7 Mar 2024 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SBvlAS4x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390425FDD5;
	Thu,  7 Mar 2024 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808258; cv=fail; b=AHDsuIqtbE7xBBa98rIPQHtkcuxJWm5OWGENlAma5E8gId5HAIqtb2iwSd83Oe8g96UWG2jZl06xxYikOzJKbRLlEC/Sc1RcQHyyLG6FYXfG2psKf+AOodjthqfx123oUrPI4Ep2h4yjhNFErQa2AsCxOwaET2zDStwcht+K8fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808258; c=relaxed/simple;
	bh=6U9ZzonVd13bGwVuCVbSPTXeLSavxq+trn2sxW5StrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o9pEjrolzf2E01yFCJ3y9/fsmXk0xYJ1x2TY51WsU8lhpWh41xJ0rv4SC04tQ27PvtRJrHbBHa4zgmWq5t7YiGsMAJLS9KFw5w23MVBbMyAvka+nuo+fKHZT5mwk9yWNcw8+lpbz7z6/OR+xtKBKxWt8Had+mPX7Mjitidrs+HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SBvlAS4x; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGquoB+p9n2dfgB0W/lMbYo2u8USlMKhP6fhC093MC6rrPxvPLny7VxmM8v2eEfg0kTY+n3HucaISh/67ve/0eXERegbhZX2N+/F4CzgaWFGmT8tOTUypvUPNPWi2yfmidGFG+8kwJn2nRuW8OgNjlQMQVrJutNoKmFBDLlOJXxVSpQo8ucbaGptlipYfznUbbG+wziNrR0Jg1DuwotTg/bbfDagVLYQPZYvQrZ7jY29e9mNFlbg1MtOCFFh/6S7jYA/JIPoyZx8crGvsvzGsjoXO+hYp5caSr/P8hWvLgjXSE0J2Ti6LRZVmV+TYntLVkqW9CXaK8ViLSrBYIacEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6U9ZzonVd13bGwVuCVbSPTXeLSavxq+trn2sxW5StrE=;
 b=gwiKlTo08qr1/f7r0/t2p+8mvYw1L6HM3qcUcodeHGaE9/JZmH7+PZBCIKovrY5nZzKbP29dI0l1Zfy664a78CaiTaeBWgJyaHRuSbEWoXq6vMIdUiAv0pk0BwoKTR0T5AbKN5x5iKQ3wXIexva2qMIBytmtZX8a9hScRPZ5KG0MY+dBecKQLZmt/osu5ma1Mh6sJymvJe2HiY5qftYNqna5pM+IT50luzpQmHDCeCknn/109GZlEDVPngwkq1346nG9ibopoQUvOSbbq1B9vW1ToTNGAppQW5JKRAMwbhaBY32t1D1WBkhSE/i9fnCb84qw4ICUMXbYMp5C4t//gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U9ZzonVd13bGwVuCVbSPTXeLSavxq+trn2sxW5StrE=;
 b=SBvlAS4xXBC/j9Md9pcY5Ft28sQ5qyvNFhjQ7syNxqB1lgf5FEJkCSE0ECiE8RziyH2AmTSGs7k6YvZwvoWUmMNvVD2JslrNQM5WzUsGE4XSEg6Y2/vvnvFOXoxUdzC2ADX0V8AQ3WYYg8C0AGLqxLTEhBaXJb4BX93Q+Oc/wEnOSQ3maSEL+w2REGa6HEL1D9ogH/1KS7ECc7II8kbfMOBb4wtxIuAEr0TVmDH3CSiJMOKQVdIgWzvAVPX0CKKTl4nFABphjnhPCPQh2YxC1sRg1W6+IIcgrB9QWF7aSK58pWvhMKC/aKlLrwZZLnDpYRuyrbW9pVNf5kQfVwvG3g==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 10:44:11 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::bfce:51e5:6c7b:98ae]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::bfce:51e5:6c7b:98ae%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 10:44:11 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"almasrymina@google.com" <almasrymina@google.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
	<tariqt@nvidia.com>, "mlindner@marvell.com" <mlindner@marvell.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, Boris Pismenny <borisp@nvidia.com>
Subject: Re: [RFC PATCH net-next v1 1/2] net: mirror skb frag ref/unref
 helpers
Thread-Topic: [RFC PATCH net-next v1 1/2] net: mirror skb frag ref/unref
 helpers
Thread-Index: AQHacCJUfw1voxLzM0CcfOPmYMBDZbEsGICA
Date: Thu, 7 Mar 2024 10:44:11 +0000
Message-ID: <19fbfb6315cdbf9efd15ebf489114a4c1df8f8c0.camel@nvidia.com>
References: <20240306235922.282781-1-almasrymina@google.com>
	 <20240306235922.282781-2-almasrymina@google.com>
In-Reply-To: <20240306235922.282781-2-almasrymina@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|BY5PR12MB4180:EE_
x-ms-office365-filtering-correlation-id: 11dc8ec0-24de-4c83-e452-08dc3e938680
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7Oj2OnSipSjeu1c4d/0WpqWgcHDCxDvoxvqRTBg9ghNA7KHqjs/LEKsy6gjtc7uiHNwNG3WijA1BN0IWTywZlwoTZwSfr//ADGsglCrecsXveWhFAIN9Tege0lVpSZbWoVxwwHww391BIbh1BhZ7+Bs38b9WIWybP2WAvbugM4qook3ovA7G04XQCAuoPp2onxjGkj+36pU1oBmf9ecOxDGlO3o1QWmShn4WWu5caqc4oUZ3DE/9wxi7xQ6dkyPaklegy/jU5ouWVpEjgOcyPZ7SVp0GLaSeFmg3qsrwZVIQwP0aSF4gAsZttdigOtbIClHquuisnQZZ8gj6BljIIIpulpU6k5lO504MPXLasMKEuhm8QsmHfHP9PjBDWPXTaT/lzhMpJhdKM4yaDzth45fDVxUbfC+zxV6Y9LBCeGex+izJFBYeA9sUZVVOwBwPZ/3MVVHVBQ2a+oqeMlA3JG7xs279eeGvs07RXWF12clqKzcepE4o9H7odIgtRd1H2U4QnLW/aFQO6jZwjbQq/dFCvI49Y1Db9nU5ssc9h16vYQohhKJEO6cIDtRjfCXBN+H6SYevG5RhRip2kO1ku8v7z7+cS5z9HHwOZS8LaBvKZjv/kxtl+TZVSjlE0Th9YOpe8Xfo7LWINjQ4NbFX2t6hP0FIU6bBamhfbcyybVPaK4V1Wh17TBF6LsZ4fTJ9TTnPT0Y+kvOZVVnlLeCs4rdQxCy3sMWYMC4Itt4YlBI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWZZRWZlcE9kalpYK0JGdzQ0RzUrVTJaeVBGdXFxUmx2YmU3VGdQMUE1R3JG?=
 =?utf-8?B?VGlxWkxXelFtbnlKYklJQmw0S01vT1lNZkhxTEVMSnZXOW5nTVVoeUxkMzZG?=
 =?utf-8?B?M05HSXg0U2UzbEtFK2pyTFZEZnZlWXFOa0FrSFYrdXpmbnlqUkZKQkZObTRh?=
 =?utf-8?B?UlZIUHdSU1JSVlV0OWc5M21wcVdDdXpzblhtZE5PSmJKaERqaEhlSWZqM0ZE?=
 =?utf-8?B?UVpsMXVJYnd0cXI3OUtyMW10NGZTS1lFLzVPTkVoNmVkRXlnWFYrT1Q5SkxE?=
 =?utf-8?B?ZjZscmd6ZE9DSUw4S2plMTZyNVJjR2dOazdTYjduZlA3OXltSEVNRzFncW1N?=
 =?utf-8?B?YlpOL2VlakJFUHZGS3JxcURwUS9XRlRQWUZBL3AwQmUzZ3BVa2hESWN4YjA4?=
 =?utf-8?B?K3A3UWNkQ0UvQUMwS1g4NWh0QzM5RXZRWmZNYzgxZjZTMFNKMzNFUy8vSU9M?=
 =?utf-8?B?M1A0TWNhNlJiWjc3ZFRzWDFicklHVTV1cjVPQ3dweVB0NlRFdmluMERteVkr?=
 =?utf-8?B?ZlVkdXpmblZJa3lOUXVhQ3RFajZFMCtYcll4NEJpcnh6eXlVcVpRb29USTF2?=
 =?utf-8?B?bEpPSTBMWjB2Z0h0cXYySVFYNVpZU3lQdHFIbElpUW4vbmJPeWVhUzhZaCs1?=
 =?utf-8?B?dFVITElrYkZkKzRxZURlbnd2ajRMRklsNk1CREVIY1FzQlE5MVpYN3JraXpt?=
 =?utf-8?B?SHBFb0Vja3k4NDVlK2ZYbTV1Q1MwWllLK213SFVPQm9xYkNGSmF0VkgrTnNS?=
 =?utf-8?B?WVpuTjJ0Rnl0YjByS0lGcXZ1b2E0WDBRNFFYL3JSUy96QVduM3V6dUNua08v?=
 =?utf-8?B?SGI0RVBGR2hlSFdzZnlBOVJJY1BDaGM2dElBUTRRTXFTbzlmMTdyZ3NNRVF3?=
 =?utf-8?B?NzU4UkQybGp3a3hRaFBuVlN3VG1ZUnpnMjRzTGI3WURLZ1k1QTZiZUFCTG5Q?=
 =?utf-8?B?Wm5ucWxiOUpjd2c2TmVwaDE3WTgvTjI5L091SUVQUFlWaXdkcmo2amhWaVlL?=
 =?utf-8?B?SXhzdjFUOGk3ekVERThhV0NmOFVWblYwd3FLZy90eDRGMktadzFJSUEzZENj?=
 =?utf-8?B?OUlMTy9CN3NHdUhWcFhTTk56N2pibG5SQ2lCbUtZOW03ZGJFaWF2cFBzSng4?=
 =?utf-8?B?VkEzdnlHb1dZR1QvZW4yWW9ybFFTejFtY3o1K3hCN1JKbUdLR0UvbGtnV1ND?=
 =?utf-8?B?dklqWHEyb1RWQmhDNW9Bc0U0S3NmeDhGRldpeDBuNXRHQ292WUpROTNrMEJi?=
 =?utf-8?B?RDd1dFRKNHUrbU9lbDAvNFU0MzliTEZoZHJheVhBZk5vZ0V6ekV2c0NvNXNO?=
 =?utf-8?B?Q2lhdlM1T2taclUzSU9RNUtoMXJ4NENIVS9KUm5OVTNkMEltNE56K29OMjcv?=
 =?utf-8?B?UW9xMERNQ0JrRGc1cU54ZGwzcTR1MXg4Vk11ZWdUU0JnUzNKV0Fsa2htelc2?=
 =?utf-8?B?N1ZEL3BEaEFpUjNPSXVjQ3VvSStuWSs5bDUwZlh4SEJOcDZiV0FwT1lxcU1X?=
 =?utf-8?B?dzAwZFRycVNlUXNBZjdnY04xZzlZQzZUVFB5L1pwbTVRbFNoayswM3BxWktz?=
 =?utf-8?B?ZEFyc2ZxUkpwa0RJazN2cjFtZm1mOUxsUWxZaXBVL1BHclNvb05YckEyK25x?=
 =?utf-8?B?c3ZCZGhmeTRTTUFDbVc4WHFpV0V2a0trN1laZUJ0RGtVYS8yR3U0U21QYUNi?=
 =?utf-8?B?ejZYK0xSV0hvMjhHcWpQYUMvMllIbmpYb28vNUV5Yjl0c2U2bGJlQ0RTOHJ4?=
 =?utf-8?B?QzJmamxjcnh3c2RVN3dDZSsrVlFFR1lzL2ZNQ2JHS0I4R1NyQnlFdC9wQjZM?=
 =?utf-8?B?aXcvT2VEZ1Nib3FiQVZmWnJZbnJiYWhUbGRpUGJSZS90YjJwbWwyVjZWeG1T?=
 =?utf-8?B?RjF2MHVocW5oM1NkZ3JmR1kzVXZLVE9NMjRqaWtmWFRXU3J2Wm9KVTJuanZW?=
 =?utf-8?B?czBENXhPRmpOWkZmOTJlTmlYZmcwMzd5OFRSTHdqZzJQYTV6RGRhdzQwcmRj?=
 =?utf-8?B?enc3NTRmNllxRm1TV0xTcUdkVHA3UVFvM0lvN0VuRkhBMmF6SzBFRnRaaG80?=
 =?utf-8?B?TWZkdFpTbUdNWllpVC9scEZLRGhXRUV3aEk0SjRoSXN0N3ROK1daUFErVWRs?=
 =?utf-8?B?OGcyeWlJY1dMVDRqVG1VQzhWS0Z0WVE5RkpYcTBGUzd3dEFPQldtb0NZRGIr?=
 =?utf-8?Q?LeAD1XXQibKwHB+Wdn0XiWODdm/O5wzUY5FhxOsirvHc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FB094C5A5C34D479E16E21D0B442C89@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dc8ec0-24de-4c83-e452-08dc3e938680
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 10:44:11.7225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6R8i6e4xj2su9FZwqkcjlSTphScr/aZ7OkCdjSbh+Wx/jFs3FyVVaPlZ0SV8TaSr5IPPrzCYJHSr7MMhvfQMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180

T24gV2VkLCAyMDI0LTAzLTA2IGF0IDE1OjU5IC0wODAwLCBNaW5hIEFsbWFzcnkgd3JvdGU6DQo+
IFJlZmFjdG9yIHNvbWUgb2YgdGhlIHNrYiBmcmFnIHJlZi91bnJlZiBoZWxwZXJzIGZvciBpbXBy
b3ZlZCBjbGFyaXR5Lg0KPiANCj4gSW1wbGVtZW50IG5hcGlfcHBfZ2V0X3BhZ2UoKSB0byBiZSB0
aGUgbWlycm9yIGNvdW50ZXJwYXJ0IG9mDQo+IG5hcGlfcHBfcHV0X3BhZ2UoKS4NCj4gDQo+IElt
cGxlbWVudCBuYXBpX2ZyYWdfcmVmKCkgdG8gYmUgdGhlIG1pcnJvciBjb3VudGVycGFydCBvZg0K
PiBuYXBpX2ZyYWdfdW5yZWYoKS4NCj4gDQo+IEltcHJvdmUgX19za2JfZnJhZ19yZWYoKSB0byBi
ZWNvbWUgYSBtaXJyb3IgY291bnRlcnBhcnQgb2YNCj4gX19za2JfZnJhZ191bnJlZigpLiBQcmV2
aW91c2x5IHVucmVmIGNvdWxkIGhhbmRsZSBwcCAmIG5vbi1wcCBwYWdlcywNCj4gd2hpbGUgdGhl
IHJlZiBjb3VsZCBvbmx5IGhhbmRsZSBub24tcHAgcGFnZXMuIE5vdyBib3RoIHRoZSByZWYgJiB1
bnJlZg0KPiBoZWxwZXJzIGNhbiBjb3JyZWN0bHkgaGFuZGxlIGJvdGggcHAgJiBub24tcHAgcGFn
ZXMuDQo+IA0KPiBOb3cgdGhhdCBfX3NrYl9mcmFnX3JlZigpIGNhbiBoYW5kbGUgYm90aCBwcCAm
IG5vbi1wcCBwYWdlcywgcmVtb3ZlDQo+IHNrYl9wcF9mcmFnX3JlZigpLCBhbmQgdXNlIF9fc2ti
X2ZyYWdfcmVmKCkgaW5zdGVhZC4gIFRoaXMgbGV0cyB1cw0KPiByZW1vdmUgcHAgc3BlY2lmaWMg
aGFuZGxpbmcgZnJvbSBza2JfdHJ5X2NvYWxlc2NlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWlu
YSBBbG1hc3J5IDxhbG1hc3J5bWluYUBnb29nbGUuY29tPg0KPiANCj4gLS0tDQo+ICBpbmNsdWRl
L2xpbnV4L3NrYnVmZi5oIHwgMjQgKysrKysrKysrKysrKysrLS0tDQo+ICBuZXQvY29yZS9za2J1
ZmYuYyAgICAgIHwgNTYgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDQxIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2tidWZmLmggYi9pbmNsdWRlL2xpbnV4
L3NrYnVmZi5oDQo+IGluZGV4IGQ1NzdlMGJlZTE4ZC4uNTEzMTZiMGUyMGJjIDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc2tidWZm
LmgNCj4gQEAgLTM0NzcsMTUgKzM0NzcsMzEgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgcGFnZSAq
c2tiX2ZyYWdfcGFnZShjb25zdCBza2JfZnJhZ190ICpmcmFnKQ0KPiAgCXJldHVybiBuZXRtZW1f
dG9fcGFnZShmcmFnLT5uZXRtZW0pOw0KPiAgfQ0KPiAgDQo+ICtib29sIG5hcGlfcHBfZ2V0X3Bh
Z2Uoc3RydWN0IHBhZ2UgKnBhZ2UpOw0KPiArDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgbmFwaV9m
cmFnX3JlZihza2JfZnJhZ190ICpmcmFnLCBib29sIHJlY3ljbGUpDQo+ICt7DQo+ICsjaWZkZWYg
Q09ORklHX1BBR0VfUE9PTA0KPiArCXN0cnVjdCBwYWdlICpwYWdlID0gc2tiX2ZyYWdfcGFnZShm
cmFnKTsNCj4gKw0KTW92ZSBhc3NpZ25tZW50IG91dCBvZiBpZmRlZi4NCg0KPiArCWlmIChyZWN5
Y2xlICYmIG5hcGlfcHBfZ2V0X3BhZ2UocGFnZSkpDQo+ICsJCXJldHVybjsNCj4gKyNlbmRpZg0K
PiArCWdldF9wYWdlKHBhZ2UpOw0KPiArfQ0KPiArDQo+ICAvKioNCj4gICAqIF9fc2tiX2ZyYWdf
cmVmIC0gdGFrZSBhbiBhZGRpdGlvbiByZWZlcmVuY2Ugb24gYSBwYWdlZCBmcmFnbWVudC4NCj4g
ICAqIEBmcmFnOiB0aGUgcGFnZWQgZnJhZ21lbnQNCj4gKyAqIEByZWN5Y2xlOiBza2ItPnBwX3Jl
Y3ljbGUgcGFyYW0gb2YgdGhlIHBhcmVudCBza2IuDQo+ICAgKg0KPiAtICogVGFrZXMgYW4gYWRk
aXRpb25hbCByZWZlcmVuY2Ugb24gdGhlIHBhZ2VkIGZyYWdtZW50IEBmcmFnLg0KPiArICogVGFr
ZXMgYW4gYWRkaXRpb25hbCByZWZlcmVuY2Ugb24gdGhlIHBhZ2VkIGZyYWdtZW50IEBmcmFnLiBP
YnRhaW5zIHRoZQ0KPiArICogY29ycmVjdCByZWZlcmVuY2UgY291bnQgZGVwZW5kaW5nIG9uIHdo
ZXRoZXIgc2tiLT5wcF9yZWN5Y2xlIGlzIHNldCBhbmQNCj4gKyAqIHdoZXRoZXIgdGhlIGZyYWcg
aXMgYSBwYWdlIHBvb2wgZnJhZy4NCj4gICAqLw0KPiAtc3RhdGljIGlubGluZSB2b2lkIF9fc2ti
X2ZyYWdfcmVmKHNrYl9mcmFnX3QgKmZyYWcpDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgX19za2Jf
ZnJhZ19yZWYoc2tiX2ZyYWdfdCAqZnJhZywgYm9vbCByZWN5Y2xlKQ0KPiAgew0KPiAtCWdldF9w
YWdlKHNrYl9mcmFnX3BhZ2UoZnJhZykpOw0KPiArCW5hcGlfZnJhZ19yZWYoZnJhZywgcmVjeWNs
ZSk7DQo+ICB9DQo+ICANCj4gIC8qKg0KPiBAQCAtMzQ5Nyw3ICszNTEzLDcgQEAgc3RhdGljIGlu
bGluZSB2b2lkIF9fc2tiX2ZyYWdfcmVmKHNrYl9mcmFnX3QgKmZyYWcpDQo+ICAgKi8NCj4gIHN0
YXRpYyBpbmxpbmUgdm9pZCBza2JfZnJhZ19yZWYoc3RydWN0IHNrX2J1ZmYgKnNrYiwgaW50IGYp
DQo+ICB7DQo+IC0JX19za2JfZnJhZ19yZWYoJnNrYl9zaGluZm8oc2tiKS0+ZnJhZ3NbZl0pOw0K
PiArCV9fc2tiX2ZyYWdfcmVmKCZza2Jfc2hpbmZvKHNrYiktPmZyYWdzW2ZdLCBza2ItPnBwX3Jl
Y3ljbGUpOw0KPiAgfQ0KPiAgDQo+ICBpbnQgc2tiX3BwX2Nvd19kYXRhKHN0cnVjdCBwYWdlX3Bv
b2wgKnBvb2wsIHN0cnVjdCBza19idWZmICoqcHNrYiwNCj4gZGlmZiAtLWdpdCBhL25ldC9jb3Jl
L3NrYnVmZi5jIGIvbmV0L2NvcmUvc2tidWZmLmMNCj4gaW5kZXggMWY5MThlNjAyYmM0Li42ZDIz
NGZhYTlkOWUgMTAwNjQ0DQo+IC0tLSBhL25ldC9jb3JlL3NrYnVmZi5jDQo+ICsrKyBiL25ldC9j
b3JlL3NrYnVmZi5jDQo+IEBAIC0xMDA2LDYgKzEwMDYsMjEgQEAgaW50IHNrYl9jb3dfZGF0YV9m
b3JfeGRwKHN0cnVjdCBwYWdlX3Bvb2wgKnBvb2wsIHN0cnVjdCBza19idWZmICoqcHNrYiwNCj4g
IEVYUE9SVF9TWU1CT0woc2tiX2Nvd19kYXRhX2Zvcl94ZHApOw0KPiAgDQo+ICAjaWYgSVNfRU5B
QkxFRChDT05GSUdfUEFHRV9QT09MKQ0KPiArYm9vbCBuYXBpX3BwX2dldF9wYWdlKHN0cnVjdCBw
YWdlICpwYWdlKQ0KPiArew0KPiArDQo+ICsJc3RydWN0IHBhZ2UgKmhlYWRfcGFnZTsNCj4gKw0K
PiArCWhlYWRfcGFnZSA9IGNvbXBvdW5kX2hlYWQocGFnZSk7DQo+ICsNCj4gKwlpZiAoIWlzX3Bw
X3BhZ2UocGFnZSkpDQo+ICsJCXJldHVybiBmYWxzZTsNCj4gKw0KPiArCXBhZ2VfcG9vbF9yZWZf
cGFnZShoZWFkX3BhZ2UpOw0KPiArCXJldHVybiB0cnVlOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJP
TChuYXBpX3BwX2dldF9wYWdlKTsNCj4gKw0KPiAgYm9vbCBuYXBpX3BwX3B1dF9wYWdlKHN0cnVj
dCBwYWdlICpwYWdlLCBib29sIG5hcGlfc2FmZSkNCj4gIHsNCj4gIAlib29sIGFsbG93X2RpcmVj
dCA9IGZhbHNlOw0KPiBAQCAtMTA1OCwzNyArMTA3Myw2IEBAIHN0YXRpYyBib29sIHNrYl9wcF9y
ZWN5Y2xlKHN0cnVjdCBza19idWZmICpza2IsIHZvaWQgKmRhdGEsIGJvb2wgbmFwaV9zYWZlKQ0K
PiAgCXJldHVybiBuYXBpX3BwX3B1dF9wYWdlKHZpcnRfdG9fcGFnZShkYXRhKSwgbmFwaV9zYWZl
KTsNCj4gIH0NCj4gIA0KPiAtLyoqDQo+IC0gKiBza2JfcHBfZnJhZ19yZWYoKSAtIEluY3JlYXNl
IGZyYWdtZW50IHJlZmVyZW5jZXMgb2YgYSBwYWdlIHBvb2wgYXdhcmUgc2tiDQo+IC0gKiBAc2ti
OglwYWdlIHBvb2wgYXdhcmUgc2tiDQo+IC0gKg0KPiAtICogSW5jcmVhc2UgdGhlIGZyYWdtZW50
IHJlZmVyZW5jZSBjb3VudCAocHBfcmVmX2NvdW50KSBvZiBhIHNrYi4gVGhpcyBpcw0KPiAtICog
aW50ZW5kZWQgdG8gZ2FpbiBmcmFnbWVudCByZWZlcmVuY2VzIG9ubHkgZm9yIHBhZ2UgcG9vbCBh
d2FyZSBza2JzLA0KPiAtICogaS5lLiB3aGVuIHNrYi0+cHBfcmVjeWNsZSBpcyB0cnVlLCBhbmQg
bm90IGZvciBmcmFnbWVudHMgaW4gYQ0KPiAtICogbm9uLXBwLXJlY3ljbGluZyBza2IuIEl0IGhh
cyBhIGZhbGxiYWNrIHRvIGluY3JlYXNlIHJlZmVyZW5jZXMgb24gbm9ybWFsDQo+IC0gKiBwYWdl
cywgYXMgcGFnZSBwb29sIGF3YXJlIHNrYnMgbWF5IGFsc28gaGF2ZSBub3JtYWwgcGFnZSBmcmFn
bWVudHMuDQo+IC0gKi8NCj4gLXN0YXRpYyBpbnQgc2tiX3BwX2ZyYWdfcmVmKHN0cnVjdCBza19i
dWZmICpza2IpDQo+IC17DQo+IC0Jc3RydWN0IHNrYl9zaGFyZWRfaW5mbyAqc2hpbmZvOw0KPiAt
CXN0cnVjdCBwYWdlICpoZWFkX3BhZ2U7DQo+IC0JaW50IGk7DQo+IC0NCj4gLQlpZiAoIXNrYi0+
cHBfcmVjeWNsZSkNCj4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+IC0NCj4gLQlzaGluZm8gPSBza2Jf
c2hpbmZvKHNrYik7DQo+IC0NCj4gLQlmb3IgKGkgPSAwOyBpIDwgc2hpbmZvLT5ucl9mcmFnczsg
aSsrKSB7DQo+IC0JCWhlYWRfcGFnZSA9IGNvbXBvdW5kX2hlYWQoc2tiX2ZyYWdfcGFnZSgmc2hp
bmZvLT5mcmFnc1tpXSkpOw0KPiAtCQlpZiAobGlrZWx5KGlzX3BwX3BhZ2UoaGVhZF9wYWdlKSkp
DQo+IC0JCQlwYWdlX3Bvb2xfcmVmX3BhZ2UoaGVhZF9wYWdlKTsNCj4gLQkJZWxzZQ0KPiAtCQkJ
cGFnZV9yZWZfaW5jKGhlYWRfcGFnZSk7DQo+IC0JfQ0KPiAtCXJldHVybiAwOw0KPiAtfQ0KPiAt
DQo+ICBzdGF0aWMgdm9pZCBza2Jfa2ZyZWVfaGVhZCh2b2lkICpoZWFkLCB1bnNpZ25lZCBpbnQg
ZW5kX29mZnNldCkNCj4gIHsNCj4gIAlpZiAoZW5kX29mZnNldCA9PSBTS0JfU01BTExfSEVBRF9I
RUFEUk9PTSkNCj4gQEAgLTQxOTksNyArNDE4Myw3IEBAIGludCBza2Jfc2hpZnQoc3RydWN0IHNr
X2J1ZmYgKnRndCwgc3RydWN0IHNrX2J1ZmYgKnNrYiwgaW50IHNoaWZ0bGVuKQ0KPiAgCQkJdG8r
KzsNCj4gIA0KPiAgCQl9IGVsc2Ugew0KPiAtCQkJX19za2JfZnJhZ19yZWYoZnJhZ2Zyb20pOw0K
PiArCQkJX19za2JfZnJhZ19yZWYoZnJhZ2Zyb20sIHNrYi0+cHBfcmVjeWNsZSk7DQo+ICAJCQlz
a2JfZnJhZ19wYWdlX2NvcHkoZnJhZ3RvLCBmcmFnZnJvbSk7DQo+ICAJCQlza2JfZnJhZ19vZmZf
Y29weShmcmFndG8sIGZyYWdmcm9tKTsNCj4gIAkJCXNrYl9mcmFnX3NpemVfc2V0KGZyYWd0bywg
dG9kbyk7DQo+IEBAIC00ODQ5LDcgKzQ4MzMsNyBAQCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiX3NlZ21l
bnQoc3RydWN0IHNrX2J1ZmYgKmhlYWRfc2tiLA0KPiAgCQkJfQ0KPiAgDQo+ICAJCQkqbnNrYl9m
cmFnID0gKGkgPCAwKSA/IHNrYl9oZWFkX2ZyYWdfdG9fcGFnZV9kZXNjKGZyYWdfc2tiKSA6ICpm
cmFnOw0KPiAtCQkJX19za2JfZnJhZ19yZWYobnNrYl9mcmFnKTsNCj4gKwkJCV9fc2tiX2ZyYWdf
cmVmKG5za2JfZnJhZywgbnNrYi0+cHBfcmVjeWNsZSk7DQo+ICAJCQlzaXplID0gc2tiX2ZyYWdf
c2l6ZShuc2tiX2ZyYWcpOw0KPiAgDQo+ICAJCQlpZiAocG9zIDwgb2Zmc2V0KSB7DQo+IEBAIC01
OTgwLDEwICs1OTY0LDggQEAgYm9vbCBza2JfdHJ5X2NvYWxlc2NlKHN0cnVjdCBza19idWZmICp0
bywgc3RydWN0IHNrX2J1ZmYgKmZyb20sDQo+ICAJLyogaWYgdGhlIHNrYiBpcyBub3QgY2xvbmVk
IHRoaXMgZG9lcyBub3RoaW5nDQo+ICAJICogc2luY2Ugd2Ugc2V0IG5yX2ZyYWdzIHRvIDAuDQo+
ICAJICovDQo+IC0JaWYgKHNrYl9wcF9mcmFnX3JlZihmcm9tKSkgew0KPiAtCQlmb3IgKGkgPSAw
OyBpIDwgZnJvbV9zaGluZm8tPm5yX2ZyYWdzOyBpKyspDQo+IC0JCQlfX3NrYl9mcmFnX3JlZigm
ZnJvbV9zaGluZm8tPmZyYWdzW2ldKTsNCj4gLQl9DQo+ICsJZm9yIChpID0gMDsgaSA8IGZyb21f
c2hpbmZvLT5ucl9mcmFnczsgaSsrKQ0KPiArCQlfX3NrYl9mcmFnX3JlZigmZnJvbV9zaGluZm8t
PmZyYWdzW2ldLCBmcm9tLT5wcF9yZWN5Y2xlKTsNCj4gIA0KPiAgCXRvLT50cnVlc2l6ZSArPSBk
ZWx0YTsNCj4gIAl0by0+bGVuICs9IGxlbjsNCg0K

