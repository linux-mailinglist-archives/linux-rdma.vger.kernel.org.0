Return-Path: <linux-rdma+bounces-19458-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DiQD7a252mu/wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19458-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 19:41:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D235C43E145
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 19:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B26D303FDD6
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E23831B823;
	Tue, 21 Apr 2026 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VbOKhZWc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67031E830;
	Tue, 21 Apr 2026 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792879; cv=fail; b=Es1Fmie0/Dmg013siUNkOSuwfAf3TtSB4pQD3JAbkIjkJVbo7li9iQZDxcHIcoc0gEqimzxjCcEBjNmqVfsIt9zm7I3cQ8AUBU9hjkAAJKLrkv8gS2+zR9IKd/qbFj6m3EE9yEQRifL1s/J18u3hpinVi7CN98B4Fz7pxlVX6o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792879; c=relaxed/simple;
	bh=Eigufy2pgb0Z8hbWF4kmOC7gKJjslPgDsC4IEuXEiog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L17leIAIMPzJAVVCRd5qDIqEI+ZUaSmkaYE4jM6b+yVD8BkFPbnztfZjp+rDku5Yvan4w9Eeb6cqayVKeQc8f1wckddE87OYmVBFE3Gcz5jsVpcMKq9nuHgtr0Tfc2Ut0lCkp0upqvlKaBJ1dGo5wG6+02pgSgcr1SQyZoELbvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VbOKhZWc; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECo+85ZXTS8PgJ1zqjGO4FI51SSf9ovzP9GuHy2AmI/JNF/4KPQsyyHAO+Xc+TY64VdHMR/N3Uv547unQwaZxaKtg3iTDe14k84VA34YL+3piogIm0mY2CDWPuoc6kXKtk1qEbfkI7p1LdOTFdJbTaKD6HtSrlhgd+9N+uKRQ65CYsqlxmHIsHoQNaqphvynEcdkpy9udyQDDa2QiOhSM5LZiGHoe4vr0AJ1G0OPnxjjvfw1kVaBFTxhe1SWbgB7iEZn+1r5y4hlFaFmAC8qrYxnjTZ44hnqT/fIRhjWAcU8pCYmAl5B6iw0e56x64zGYsRVdbzHF4hLyRCF6BprPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eigufy2pgb0Z8hbWF4kmOC7gKJjslPgDsC4IEuXEiog=;
 b=tKcmUh1DdnuXtbN4eB4+Rwn4MB9gggdSBHyoudOgq6Z0IlXfpSmpsi2e3NSqCMUzfAe7AWOcawKj4t6o+/Y2XyRjTvZLsnFw8rGT/f6icopIY7mGr2wgzbBjGp1mZSg0fjEVbGcjBw/mWQ9S5m3rtQmA81Y8zqJapgvucixSS6+yVG2AmYt6QIYx7NYBIzn9t+ufJjPtV8Bw1ehATqa6JwYj3amHZoXyHwKABHMQtq7LS0FZ89kUraKLMfxJEYXoFRdb+Ib8drWp++DHwHSjlBKbRbXnIeXqaTCnsWFsMVXETLVob0mnTNunI9L/Alz8Kl2IT1rTKCyR3zmATG2imA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eigufy2pgb0Z8hbWF4kmOC7gKJjslPgDsC4IEuXEiog=;
 b=VbOKhZWcLCrF7CSqvzez0FJl4bRG1TXWeriEeRWhJTO26TcKvYxkPUpPZYUjA25OKWzcFQsHxfOCXP0IyYuGfBN5xiOODW4A9GKyuvF8neK3xzqXNAh5cN4Lmw3ZAP+sL0bTRmjQ+HtgoJ+Po+ehtDnyK9AXR5spDDHs/ek6ht5IdIlQGNxvQ4cR/nERUQ68kD6sz5mumiKGp8xPLoS+LX7Xqu/M/HXykLgMWyfbrr/rQv7RbXx2BugzDd/0uOksLDHH1oMrIjH/WvTr26s/sQIS3iJ2xycuZYxJu0AnMNhN0ypkW6FTv2qOY2oGvlwfKzCSGbHc2pAtp4sITMWYDg==
Received: from CH1PPF189669351.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::608) by DS0PR12MB8788.namprd12.prod.outlook.com
 (2603:10b6:8:14f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 17:34:32 +0000
Received: from CH1PPF189669351.namprd12.prod.outlook.com
 ([fe80::61d1:eea7:9eaf:f448]) by CH1PPF189669351.namprd12.prod.outlook.com
 ([fe80::61d1:eea7:9eaf:f448%8]) with mapi id 15.20.9846.007; Tue, 21 Apr 2026
 17:34:32 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: Boris Pismenny <borisp@nvidia.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "leon@kernel.org"
	<leon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Raed Salem <raeds@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "kees@kernel.org" <kees@kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Tariq Toukan
	<tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: Re: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Thread-Topic: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Thread-Index:
 AQHczieNmLFIHpbrDUuqFWyBz+NLKrXlMUIAgAKT6wCAAG9bgIABRBKAgAAgroCAAAIjAIAAChOAgAAoZoA=
Date: Tue, 21 Apr 2026 17:34:32 +0000
Message-ID: <6d96452f67d5b58578f67f97f750101abd4af9f6.camel@nvidia.com>
References: <20260417050201.192070-2-tariqt@nvidia.com>
	 <20260418190848.204170-1-kuba@kernel.org>
	 <d7e2d46769e120a16ce12d345c51a47349733828.camel@nvidia.com>
	 <20260420100917.1e4be22a@kernel.org>
	 <f327ce67e69c27ed971f4ed38f46381cd2f97ec7.camel@nvidia.com>
	 <20260421072609.4b15e7b9@kernel.org>
	 <3ca1bee450608d37cd0f9199ebc44c52c084cb08.camel@nvidia.com>
	 <20260421080951.570e6e49@kernel.org>
In-Reply-To: <20260421080951.570e6e49@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH1PPF189669351:EE_|DS0PR12MB8788:EE_
x-ms-office365-filtering-correlation-id: cfd64a39-1b27-44cb-f37f-08de9fcc3fa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info:
 nk0gtwGIGlqO9F48xlGxVuJmz5paXP1jfcKaYnaxlnI8VAFlcTF97YXtjuUYJ+kcuAmX2xjpKMj0tgk5YMVHO1BfK/qSs4qNhOFDXW+csuXNxGKeqRFteJcsPGCi3hHwVUB8460VkvhHbUonjKkVz6MMiB9HTfgjotiiyPwEanXNkxfnDFpvJ50jYD4MRDju22OINcYQgaU0JERWaYxbpp6g73oKBUWZgIr0yHG5RKQMu4hbqO3gP5Nf5x2QH7SPt8o2YcrEjnOHcs2m0RofbcaOikwulfhXQ8M9euObaFxKXCpJq2Z8VcsZBwJ0umfNdm/Trev1BE8cbhPfVUS7LheNpGiqQnjYzTXCg0duAdF0vtZ7FEAENjC8XeLPZT09/LjtBUbyr/0VyOETQIVhoT8PUAen4Yc2cg1jHeVKjC8eRdc4utxPL+gx2QeH1wjplj0DBrMUQwhEq+UAMyA40Hl45Jx+xkpwE+o2spIRfos8tpnVSCjLEDj1IAaArep3A0omyfTY7HmpB24P2fm2TkAfBBsfLtE1nJlq581fgxb9Y8G99RVcFgc8GLNQyzQEN4Q1rO/Sjcsld3TYq/Ex2yuW/u2pLOfGNOk32LOyQzYLa/dKKzaSFYMedE2RSZIJ6Or7wszbubnnwSW1OIPH0X8JKcbtMaYrbmQqAPEf3tK956HMbD5mB4E+6fvN/S+nmnfScRBge2mms8LcW1vkR47VSolLH74vVM+S9IyvdL7/RgKnj7Y6E+cmgZfdNJ35ooZo8PlmUeN3bwX5bDnFUMR/RZTzv+1y1PNVXtiI2aQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPF189669351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWVESU91QzM2ZTJHTkxEYVplTmExS1JlbElTSjh3Y0hPdDRBMXdaMHBqZ090?=
 =?utf-8?B?NHVGMlNJTmdGQ3pZQlovM3crV2M1Nzd3cXYySFV0cHpLY1RmOERCTk5wZjl5?=
 =?utf-8?B?TG44Z3ZsdG5McmJxcmFkVkxNbjhmODNHNXlybmZyeTVwcHcxemxnK09LYUU3?=
 =?utf-8?B?c21qQzZuSUlVTkdNL2w5S2xoNXVEMGVsY3dtbUxlL1F5ZFowRXpWMzRQZXkv?=
 =?utf-8?B?U0ZxMjlHWEZXckN2Y1Fxbktka1JPYStVRjRWTytVM3BzOTk5QWt2ZGxVc3BW?=
 =?utf-8?B?MnYyaTBVTzZmVTFoa3VDL2ZQdVkwWEN4U1NYbDlQSngyaCs1L2gxYisyamRp?=
 =?utf-8?B?dWtFaWVmdVhHOUNldmpRcnkyMHZXUkhQRCtoSDZnckhEd1FIZ25WWHZLSmdS?=
 =?utf-8?B?MzMxbmpMT3I2MmZHck5sc2d6UVpUWVlHY1BoZ3pXd0lvVm01aEFpcmQ3UGth?=
 =?utf-8?B?RFBuRWtyT2M1WER2dy9xTDRVY1cyNThYS1VETXV1aWw3RzlYMjIzdDdSak1K?=
 =?utf-8?B?RHcwTkJuZURrMUtZcmVRY1BEd2FUNUhDUE5kSzQxL2VNVUdFQjBMMVorbXhE?=
 =?utf-8?B?U1A0ejlKemZoWVluYllJOFNqSHA1WkhsRWVzWEhCN3NydnRSVm14cWV4SVc4?=
 =?utf-8?B?VmJGWGpBNlJuT3JDK3dTMDl1QzNHa3lUdFQyN2JFdjV4aG12UkF4VW0waDF3?=
 =?utf-8?B?MnFHTUdVcmJhQ2RxVTRRYkpqTk9ZVThkakZyK0lBSTFpZDJGZmU5LzVBQW5k?=
 =?utf-8?B?ZmxENllXY2FWUDJZNXJ1ZkpDdExocHdmdklmOExsZDRSU05qS2ZrRmRaSFM2?=
 =?utf-8?B?cVVZc1Y1b2hCWXcra2tTNS9TdDZ1T21aR1NkMFRpaHJYQ2NZWlNWeWg4a1Uz?=
 =?utf-8?B?M3hxa1BzaW1EbEVsOTFEdUk0dkQyQXBpNkxXbnpIdVJaaGJjQnZkOERYdHpp?=
 =?utf-8?B?VTlFOUk3dGhaM0FITzhwNmc3VWJNdHJMZ2JRL3Z2L3N1M2xGV1Z3bjMrUVIy?=
 =?utf-8?B?Mm5GNmNBbXFzVEF5TmFyRUtNZzhkc0s5SVZEZTdEbysrUkx3dFZrQks2Y1Zp?=
 =?utf-8?B?QUhRQTVWaEY1VDhGcDhaTmZxZjZnSWxvb0JDbHlhNmU4T2VJUXREUmM2M2tF?=
 =?utf-8?B?RnB4WEt4WlU4L0pIeXVFRStEVU9acERFK05ZZ1pIMVo3UUgxQ2o4cFNpWTZT?=
 =?utf-8?B?eXhuSHFlTHdxVlJ6TFFZazBEZTRpZlk2MTA2UTlpYmt3SkdYT25aWGN5V2lj?=
 =?utf-8?B?UXFNUnM1Q3NBNS9FZ2p6R2tCbkhZUi9zZTV3MFVRZ3Y2RlkyUWxPNU4vUHpS?=
 =?utf-8?B?NmdycndGVkVvOE1OQWpRU0gyMStDUzZjcGMvQkNGcUM0RGFXSjQrSmlHWXhM?=
 =?utf-8?B?YmtERTRVTFBMWnJaZnpuWEtnV25LSitEMk5ncVFFbXpqOG5QSG5mYWhaVWVj?=
 =?utf-8?B?cmFHam4yZktpZkpLSHVFNGZNSTZjUUdNMkZidXlGTWROSEt4b0Nvc3FNeTJm?=
 =?utf-8?B?ekExbktLdFJ3Tkl2MlJQZXhnR0RxNjRsdTlkSVFxWGVsa1hVN0VHVzBFZzNZ?=
 =?utf-8?B?SzRpVk43c215SFFlRVZHNzFYMEF0ODRPaUIybnlKanY5NE1MWGhSM1FRNVZI?=
 =?utf-8?B?QVp1OTB0bDAxc1EraytlN084SVBhRkhBMXNaQnFXV1podXRGWWVQUFAycDNQ?=
 =?utf-8?B?K2k1VkFwOE5BcVpqY1lHZ3h5T1VBOW1ZUHR4N0VQbE1IU3U4K2dXRGpsbFNW?=
 =?utf-8?B?cm0vcHJkNEt1RmVFRXZvek9BUlk3aXZReFFiZWNVazE4eEtJZ1hLYmxyUnBM?=
 =?utf-8?B?U3FEV0lNanB0dVZzUTJGUDJmMVhyd1FxWHpNbVVwSDZWZTBEU0RQM2lNdHFK?=
 =?utf-8?B?NWZPMlZRYXhWOE9nK2dmTmdubStpMUNwdkJuT1NFNTR1ZE9lTGpoN2k0bXdX?=
 =?utf-8?B?YmhxYi92bGxlbWwreE9sTXRkbHRUTCt2Yk5WaG55MFZSa0hsQm8zNGJaZy96?=
 =?utf-8?B?VzlOR1JUVzRlTGtzTUwxMVp3NGdMRE0xdkE1ZEdVbDR4OFJGeFFmaXVMcU5O?=
 =?utf-8?B?YzRGdmtBeUkxSXp1Qm1PbjE1bmxZZFdZS0dneHNkWnVsdUxIU0c4ak5sOFJH?=
 =?utf-8?B?Wm9YYWZxV1k1MjlweWdZOEJUb0FSZzkrTlRhTC94N3dDcllHWlYwdmpIdjhn?=
 =?utf-8?B?VnRaOXhqSjM2UTN6QVZCL0dTdi85M2VrWXNaQW9kOTFCczQzUjZvdjZWeDZF?=
 =?utf-8?B?UDIzNVIrZjBJeHJSZVlGMTlENFZhUTZrdTdZN2Z2V01sTUFHT1IxTmpzVklF?=
 =?utf-8?B?bkFoK0J5dE5ZNVBQc2JFY1pUZHdYZ0RKRUxoN3R0TVY5QlVxdlh2UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4E37326EC1EAC41BF57B55DCFD47A12@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH1PPF189669351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd64a39-1b27-44cb-f37f-08de9fcc3fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 17:34:32.1765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvQYSzRjkMOd2yCFQvEth/cUoSXVM8wAZdtRddYW3nAUWSuONV2ndRcMvCnAE/tFu3CYHaRTBYXkUH2GWII7hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,lunn.ch,davemloft.net,kernel.org,vger.kernel.org,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19458-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:replyto,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: D235C43E145
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTA0LTIxIGF0IDA4OjA5IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVHVlLCAyMSBBcHIgMjAyNiAxNDozMzo1MSArMDAwMCBDb3NtaW4gUmF0aXUgd3JvdGU6
DQo+ID4gPiA+IHByaXYtPnBzcCBhbmQgc3RlZXJpbmcgYXQgdGhlIHRpbWUgb2YgbWx4NWVfcHNw
X3JlZ2lzdGVyKCkgaXMNCj4gPiA+ID4gaW5lcnQNCj4gPiA+ID4gd2l0aG91dCB0aGUgUFNQIGRl
dmljZS4gQ2xlYW5pbmcgaXQgb24gcHNwX2Rldl9jcmVhdGUoKSBmYWlsdXJlDQo+ID4gPiA+IHdv
dWxkDQo+ID4gPiA+IGJlIHdlaXJkLCBpdCdzIGNsZWFuZWQgdXAgYW55d2F5IG9uIG5ldGRldiB0
ZWFyZG93bi4gVGhlIGZhY3QNCj4gPiA+ID4gdGhhdA0KPiA+ID4gPiBvbmx5DQo+ID4gPiA+IG1l
bW9yeSBhbGxvY2F0aW9ucyBjYW4gZmFpbCBpbnNpZGUgcHNwX2Rldl9jcmVhdGUoKSBpcw0KPiA+
ID4gPiBpcnJlbGV2YW50DQo+ID4gPiA+IGhlcmUuDQo+ID4gPiA+IHBzcF9kZXZfY3JlYXRlKCkg
ZmFpbGluZyBzaG91bGRuJ3QgYnJpbmcgZG93biB0aGUgd2hvbGUNCj4gPiA+ID4gbmV0ZGV2aWNl
LA0KPiA+ID4gPiBzbw0KPiA+ID4gPiBsb2dnaW5nIGEgbWVzc2FnZSBhbmQgY29udGludWluZyBp
cyBvayAod2hpY2ggaXMgd2hhdCBpcyBhbHNvDQo+ID4gPiA+IGRvbmUNCj4gPiA+ID4gZm9yDQo+
ID4gPiA+IG1hY3NlYyBhbmQga3RscykuwqAgDQo+ID4gPiANCj4gPiA+IFRoaXMgaXMgYSBtaXNn
dWlkZWQgY2FyZ28gY3VsdC4gT3Igc29tZXRoaW5nIG1vdGl2YXRlZCBieSBPT1QNCj4gPiA+IGNv
bXBhdGliaWxpdHkuIEFsZXggRCBzb21ldGltZXMgdHJpZXMgdG8gZG8gdGhlIHNhbWUgdGhpbmcg
d2l0aA0KPiA+ID4gTWV0YQ0KPiA+ID4gZHJpdmVycy4gSSBkb24ndCBnZXQgaXQuIE9mIGNvdXJz
ZSB3ZSB3YW50IHRoZSBkZXZpY2UgdG8gYmUNCj4gPiA+IG9wZXJhdGlvbmFsDQo+ID4gPiBpZiBz
b21lICpkZXZpY2UqIGluaXQgZmFpbHMuIFRoZSBjb21wYXRpYmlsaXR5IG1hdHJpeCB3aXRoIGFs
bA0KPiA+ID4gZGV2aWNlDQo+ID4gPiBnZW5lcmF0aW9ucyBhbmQgZncgdmVyc2lvbnMgY291bGQg
anVzdGlmeSB0aGF0LiBCdXQgY29udGludWluZw0KPiA+ID4gaW5pdA0KPiA+ID4gd2hlbiBhIHNp
bmdsZS1wYWdlIGttYWxsb2MgZmFpbGVkIGlzIHB1cmUgc2lsbGluZXNzLsKgIA0KPiA+IA0KPiA+
IEkgYW0gbm90IHN1cmUgYWJvdXQgdGhlIHdpZGVyIGNvbnRleHQsIGJ1dCBmcm9tIHRoZSBQT1Yg
b2YgdGhlDQo+ID4gZHJpdmVyLA0KPiA+IGl0J3MgY2FsbGluZyAkdGhpbmcgZnJvbSB0aGUga2Vy
bmVsIHdoaWNoIGNhbiBmYWlsIGFuZCBpdCBuZWVkcyB0bw0KPiA+IGRvDQo+ID4gc29tZXRoaW5n
IGFib3V0IGl0LCBlaXRoZXIgZmFpbCB0aGUgZW50aXJlIG5ldGRldiBicmluZ3VwIG9yIGFjY2Vw
dA0KPiA+IHRoYXQgJHRoaW5nIHdvbid0IGJlIGZ1bmN0aW9uYWwgYW5kIGNvbnRpbnVlIHdpdGhv
dXQgaXQuIFRoZSBkcml2ZXINCj4gPiBzaG91bGRuJ3QgbmVlZCB0byBrbm93IHdoYXQgJHRoaW5n
IGRvZXMgaW5zaWRlIGFuZCBob3cgaXQgY2FuIGZhaWwsDQo+ID4gd2hpY2ggY2FuIGNoYW5nZSBv
dmVyIHRpbWUuIFRvZGF5IGl0J3MgYSBrbWFsbG9jKCksIHRvbW9ycm93IGl0IG1heQ0KPiA+IGJl
DQo+ID4gc29tZXRoaW5nIGVsc2UuDQo+IA0KPiBMaWtlIHdoYXQ/DQoNClRoZSBpbm5lciB3b3Jr
aW5ncyBvZiAkdGhpbmcgYXJlbid0IGFuZCBzaG91bGRuJ3QgYmUgcmVsZXZhbnQsIG5vPw0KTWF5
YmUgdG9tb3Jyb3cgdGhlIGtlcm5lbCB3aWxsIGxhenktaW5pdCBzb21lIFRDUCBzaGVuYW5pZ2Fu
cyBmb3IgdGhlDQpmaXJzdCBQU1AgZGV2aWNlIGJlaW5nIGluaXRpYWxpemVkIG9yIHdoYXRldmVy
LCBvciBtYXliZSBzb21lIG90aGVyDQptb3ZpbmcgcGFydHMgaW5zaWRlIGNhbiBmYWlsLiBJdCdz
IGFuIGFic3RyYWN0aW9uLCB3aHkgbWFrZSBpdA0KdW5uZWNlc3NhcmlseSBsZWFreSBmb3IgdGhl
IHB1cnBvc2Ugb2Ygd3JpdGluZyBkcml2ZXIgY29kZT8NCg0KPiANCj4gPiBJdCBkb2Vzbid0IGFu
ZCBzaG91bGRuJ3QgbWF0dGVyIGZvciB0aGUgbG9jYWwgZGVjaXNpb24NCj4gPiB0byBjb250aW51
ZSBvciBub3Qgd2l0aG91dCAkdGhpbmcgd29ya2luZy4NCj4gPiANCj4gPiBJc24ndCB0aGlzIHJl
YXNvbmFibGU/DQo+IA0KPiBObywgdGhlIG5vcm1hbCB0aGluZyB0byBkbyBpcyB0byBwcm9wYWdh
dGUgZXJyb3JzLg0KPiBJZiB5b3Ugd2FudCB0byBkaXZlcmdlIGZyb20gdGhhdCBfeW91XyBzaG91
bGQgaGF2ZSBhIHJlYXNvbiwNCj4gYSBiZXR0ZXIgcmVhc29uIHRoYW4gYSB2YWd1ZSAia2VybmVs
IGNhbiBmYWlsIi4NCj4gSSdkIHByZWZlciBmb3IgdGhlIGRyaXZlciB0byBmYWlsIGluIGFuIG9i
dmlvdXMgd2F5Lg0KPiBXaGljaCB3aWxsIGJlIGltbWVkaWF0ZWx5IHNwb3R0ZWQgYnkgdGhlIG9w
ZXJhdG9yLCBub3QgMiB3ZWVrcw0KPiBsYXRlciB3aGVuIDEwJSBvZiB0aGUgZmxlZXQgaXMgdXBn
cmFkZWQgYWxyZWFkeS4NCj4gVGhlIG9ubHkgZXhjZXB0aW9uIEknZCBtYWtlIGlzIHRvIGtlZXAg
ZGV2bGluayByZWdpc3RlcmVkIGluDQo+IGNhc2UgdGhlIGZpeCBpcyB0byBmbGFzaCBhIGRpZmZl
cmVudCBGVy4NCg0KSW4gdGhpcyBjYXNlLCBQU1Agbm90IHdvcmtpbmcgd291bGQgYmUgc3BvdHRl
ZCBvbiB0aGUgbmV4dCBQU1AgZGV2LWdldA0Kb3Agd2hpY2ggcHJvZHVjZXMgemlsY2ggaW5zdGVh
ZCBvZiB3b3JraW5nIGRldmljZXMuDQoNCkJ1dCBJIHVuZGVyc3RhbmQgd2hhdCB5b3Ugd2FudC4g
WW91J2QgbGlrZSB0aGUgbmV0ZGV2aWNlIHRvIGVpdGhlciBiZQ0KZnVsbHkgaW5pdGlhbGl6ZWQg
d2l0aCBhbGwgc3VwcG9ydGVkK2NvbmZpZ3VyZWQgcHJvdG9jb2xzIG9yIGZhaWwgdGhlDQpvcGVu
IG9wZXJhdGlvbi4gTm8gaW50ZXJtZWRpYXRlL3BhcnRpYWwgc3RhdGVzLiBUaGlzIGlzIGEgbm9u
LXRyaXZpYWwNCnJlZmFjdG9yIGZvciBtbHg1LCBiZWNhdXNlIG1seDVfbmljX2VuYWJsZSgpIHJl
dHVybnMgbm90aGluZy4NClJlZmFjdG9yaW5nIHNlZW1zIHBvc3NpYmxlIHRob3VnaCwgaXRzIG9u
bHkgY2FsbGVyIGlzDQptbHg1ZV9hdHRhY2hfbmV0ZGV2KCksIHdoaWNoIHJldHVybnMgZXJyb3Jz
LiBJdCdzIGNlcnRhaW5seSBub3QNCnNvbWV0aGluZyB0aGF0IHNob3VsZCBiZSBkb25lIGZvciBh
IG5ldCBmaXggdGhvdWdoLg0KDQpJIGhhdmUgYSBzZXJpZXMgcGVuZGluZyBmb3IgbmV0LW5leHQg
d2hlcmUgdGhlIFBTUCBjb25maWd1cmF0aW9uIGlzDQpob29rZWQgdG8gbWx4NWVfcHNwX3NldF9j
b25maWcoKS4gSSB3aWxsIGxvb2sgaW50byBpbXBsZW1lbnRpbmcgd2hhdA0KeW91IHByb3Bvc2Ug
dGhlcmUgYW5kIHByb3BhZ2F0ZSBlcnJvcnMuDQoNCk1lYW53aGlsZSwgZG8geW91IHdhbnQgdG8g
dGFrZSB0aGVzZSBmaXhlcyAoMSBhbmQgMikgb3IgbWF5YmUganVzdCAyDQpmb3IgbmV0IG9yIG5v
dD8NCg0KQ29zbWluLg0K

