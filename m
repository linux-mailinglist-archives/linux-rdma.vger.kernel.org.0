Return-Path: <linux-rdma+bounces-1043-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8731F859F30
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Feb 2024 10:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05A31F23858
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Feb 2024 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B299F225AE;
	Mon, 19 Feb 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oCQ4utOz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D707A2377A;
	Mon, 19 Feb 2024 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333548; cv=fail; b=TW6KX3thpLD9VcyEgvJ7uG5F5fcK0CXPLEdJP/imjlX22dSikCSM67c6M7RgUOk8t75FxFResZveX8IBO943k6C4bxvFriqZjCyanXPdtH4LhGygS2TXsTnVGSy3xvBSLv/ktfzkfwQUbMUPKW/HLX3Dlqz42Rhh5w8KGVeXsvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333548; c=relaxed/simple;
	bh=4OFREhUG0z1L2DGd3jQ2lC2vpYGgvlayTgkS+FLJfrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CaWMswelmvFcqS6Rc9F3A4o8tPdmqhGrl7vqrfafpak9OejFZdk9MRpJml1V3jD5v7BRBR7PJtm3T4LpCK9jNzNPKyVZnYLTyki5Ro+F8E57zQ7JGnmPIAqGTqzOQ+wuKBcyaYD/y54AEqoNFGrUMQr+fdI3tl4ofD3Y33NbwQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oCQ4utOz; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAQfRFBI2Lkp5V3VJXCIlyLy8uu2Vl2aU0h1R6j4A7KolUkjguGP5+cIBLx9TpoLm46UkL/sDSy6qbf1MGfggkyusU3ots/YSWef4EvABDuvlZuvKVKfHFpqpJou5vsSMu0o0m9ZbXgRNoJ2YKXGfcU8aUrnCcrruwvH5BQtGsdPqYEqSre23z9zXALdF3ljHC0c5115cqqgZMLrXRVb5uLVbBZ74DV0o3Tw98RGvCEt5d9Z0AA6vwO2cOIKiArOAQtfhwaW0dzqUKwPNWI0kZJbsTmuZc2e320sK+1dR7nFaaZolNUR6alvUXhNr7ozh3nNPP9h0p34zjxoNlsGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OFREhUG0z1L2DGd3jQ2lC2vpYGgvlayTgkS+FLJfrQ=;
 b=B5rMeA9VphFrwvERLI0Ey26TEcm6LUBOFkzsZ0Rqf/+G4cyn9/OQjXz4RxceKZk/QwC6GJ1HHgWRoAXejHSRe705IZ4y3MogMzav2JuPXu9HXO7m4S6s2nKFVnB+klxaLxguPck7o5U+MDd8MxnSAYzVijQUeGBYJyOJeNqEPsKClict8UQP41HYSwCfxWNmB6jh3n3DSJykBeedY/vTEoLBr74Kv94CP3dn3uC4OQoJiwaNWlLijz6y4KOwT++94/4Rpr94SwbORTFNOHy0I3Ugu007RvxFf6RqrXJfqvtfGMvkLjjnaFQeY2UzQF/O9TdPtViezLfzcCZPLGqaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OFREhUG0z1L2DGd3jQ2lC2vpYGgvlayTgkS+FLJfrQ=;
 b=oCQ4utOzy+wsktnjuaGLCuKR2BQxFGnVvsjbMYYbmblPcTB1RdV87uq7UGcG38RNqq/X4TpKOuB9edvKuJDkqvxUsOpAQBu5tN9RztnSvek9w4mI86Vz4G4b7gvt85uFunriDywjxm4UpAwXobx1rf0T94eMRdPj58F/lSkqsR/kQckkJf0zoxIKjGHNkFOwhVMf9Mw3+fa35jU/DhOOZyzqLR7thHuqVRHr8kyi3fqbgJerD+bitcVHQAypUXONqMPweDuJATn8QQvQUfdgwseJQwIUr6+gPl46nP/ynbpnpvIzlBwFNkOACAoMi9QIx5EHCkMtq7TKHfX06pmGZA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 09:05:44 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::662e:ebb3:14cf:80d5]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::662e:ebb3:14cf:80d5%4]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 09:05:44 +0000
From: Hamdan Agbariya <hamdani@nvidia.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Arnd Bergmann <arnd@arndb.de>, Arnd
 Bergmann <arnd@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Alex Vesker
	<valex@nvidia.com>, Netdev <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net/mlx5: fix possible stack overflows
Thread-Topic: [PATCH] net/mlx5: fix possible stack overflows
Thread-Index: AQHaXmSoQ29XHPodFE67RmhAIyJFTrEKjE0AgACBtQCAARd4AIAFQUbQ
Date: Mon, 19 Feb 2024 09:05:44 +0000
Message-ID:
 <DM6PR12MB45168A0957212864D8D53B80CE512@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240213100848.458819-1-arnd@kernel.org>
 <84874528-daea-424d-af63-b9b86835fae6@linux.dev>
 <2ebe5a36-ce81-4d26-a12b-7affbd65c5e3@app.fastmail.com>
 <11f40993-ec02-48b7-aec5-13ff7cddf665@linux.dev>
In-Reply-To: <11f40993-ec02-48b7-aec5-13ff7cddf665@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|DM6PR12MB4386:EE_
x-ms-office365-filtering-correlation-id: e74d6b96-8459-498a-da7a-08dc3129f46a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +uQnIJGpzi8akC3AvZACP+JAWdvQSfi1GVqN+gUt5Mdb1/9AaWIme2MHldmiSoUbdjKvrCYhtIvH/bHSZcz1gjYDzVceJ18LdCg+e6t7JAFq23E/KH1tnfexTwyUUy6VsHOfVwWwZlijVWSOK3gJ7ugllxD1MtNeZWJgEOXvJVZ5BT7KhTpY6l7MxIAHLo6+T2L5fX4sWkFDL3wFzcuVB1XnT3thvB97kP5ayWf7GiPbDiynAXR913m7B9E3GZxCk7l0VDZVXjZARUzyvmvjadYWxwQlvdzFhvGRhFZehXokA9oMmeVktOwWNgBy3OTRCkFYiouKnGlWsZOMg1FtAXQYwZDym0mq6qWFq5kU7dzmOljXV+3INEDsyP7baXpMSxjBEIflXk8E+y2TXLL++gjthqzUTLy1F499NCuY0Hp0kHVw3s+hDHRrZ5pKPVexDRTxm8643MwbbQS0mLmLZuSvSz6aG6A2EbvKgMWRi4pMyJwb91C3Hff1JxdMDcMlEZehHwt6T22l6TsDGP6GyxCQEedmyGC2vXmE1xGVEGkSruFDJW297fdJXqBOd5eHxGTHyJxOuIqT3uMtktYaIXkxncf8U5LM3pZ2HBbHFosEUiGBww118UWkFLJacAEV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8676002)(38070700009)(26005)(52536014)(41300700001)(64756008)(66446008)(66476007)(66556008)(4326008)(316002)(66946007)(76116006)(8936002)(478600001)(9686003)(71200400001)(6506007)(7696005)(54906003)(110136005)(33656002)(122000001)(38100700002)(86362001)(2906002)(7416002)(5660300002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkJiKzVnTCt4aVYvTGhUbmNoSU5iWVRHUTJVNmtabi93QW9YQWN2TmVUaW1V?=
 =?utf-8?B?Njh3c3JBZmV2VVY3VFRmSWRDcFVrMjliU3RFakFkeXpJaW9XUmJldXE5aEt6?=
 =?utf-8?B?RCs0am4ySm40SkZTcllCR21ENDNGZmJnU0NlMFRlZEZBT2E5eVZjNEVJQmZQ?=
 =?utf-8?B?U0NvUXplWXJqdGxRb2w0RHYwRXRpYUl0a0IvTmJvS3hHRjE0T25PUGtzTWd0?=
 =?utf-8?B?STZLcnVJOW8zTi9TdWFNNE0zMk1EN2lXT0Z4T1hZNFFsd0hadThicnQyVExQ?=
 =?utf-8?B?Z01NRzFTQ21JSWIxbmlQbVk0WHhjbmJKdkhsWXc4UnJneHJ0RStvU1F3NVF1?=
 =?utf-8?B?RW02aXo2ZTBuZ09BTHFlSU9scitaQlpEZ1hpdnBDcGN6MkZpSTNFeWFqWVJo?=
 =?utf-8?B?SFdockZBTWlVRklUTDNxWFlhakFXMkhNSTlnT3Y0T0dydGRHQU1EYWhjd2ZY?=
 =?utf-8?B?Wk5vYk9Vdmt2VFQ3RUwvZElXUWptUmdTZHNDZGV5cGJpY2U3ckRURHFPRTFK?=
 =?utf-8?B?OTVKUVJvZTdWblJHclVib1gwbnQxZHV2RFRnUm93U3FUcG9uVElMN2h6V2xy?=
 =?utf-8?B?aVZsQ2VscFJqRW8valNUQ3pKb1ZLUDJQQ0lmYWhZOUxVZTkrUWYrMnlOQUdx?=
 =?utf-8?B?OHZHL1RUa1dMYUJOMllOdGFkVFFKYmFvbVUzN29vRnpRcWlLdXMxclNLWWVi?=
 =?utf-8?B?WURnTkdOY2VqemY3aUNJUkRsQWc4bEF2cGtZdzd4dERxNEFIeER3dExZbXNh?=
 =?utf-8?B?VVdqRjloNlMxYndSWnZwQk94UzhvNkVoZzRHTVNuVXR4alZFcEM3UUlYS0dz?=
 =?utf-8?B?SVpoZEtzd1V0SGhMck5qZ3RCZzJVMERIb0lmcFRubGszaGZ2M3htSnJQejhB?=
 =?utf-8?B?YlBKYkFPejlsbTJOeHUvaGZocXBHMEU2TFRNNDUyWG5DYjBOV0hoemNYa0VT?=
 =?utf-8?B?UUo1ZDlTL2k3bEtSaHNYVzR1WTJ2NkNtMm9XRllVUHlwdUpvUmNmUk1XZnZX?=
 =?utf-8?B?dVdpOENQTCttTkxlcmdIcGU1elBCc2dhVlhLckt5cDQ4YnZPN0JyMnR6NytH?=
 =?utf-8?B?L2JKczEzK1ZxeURHd1hTRkZod0l0bTVEUU5QcHpURkowZ1VYdjd6ZEw1Rnhv?=
 =?utf-8?B?U1o3Nk4rQmEzejFwd05JOHo2dTgxSmZtQmQzeEV1bEhYb2VuelVNa2l1ZUh5?=
 =?utf-8?B?TlIyNDgxb0UxSjhxU2N0OE81Rmw3ZWVEZzJLZHFvRVVkNHRSRHJRVzYxVHlG?=
 =?utf-8?B?ODZJbmszcTRjQXBTYzdiaDdocmR1Rkphd2cyRU1WZ2xSbFJoQWljYVNFdWl5?=
 =?utf-8?B?RFFyVHZZV0Z1TE5ucUhCSkVZU3J6cHk5bWcrS085cm4yc1kybkdQT0FrOS9k?=
 =?utf-8?B?QzBOS3ZoRW1rRkRoSGg1QzBOUFJQbElTem90NjNJT05icmd6WE1YVFpkS1VL?=
 =?utf-8?B?TjVwZGFIVGVod09XMjhxa3FsWVdabkRiMnNySTNvNE1DcHdPa0FabmJpTjB1?=
 =?utf-8?B?SnpUNFNiQVRpTTBFamFkbTJDYUJwNkdWMjY5MUhWVmxYOUg0b3lCREhVdng2?=
 =?utf-8?B?dHQwTmsrTXRtRUdCM3lJaFh3Q2huczNFWlBrdDk1cDI0ZjVtWmxqaFJ2Z2RO?=
 =?utf-8?B?NDMvUnlkYjhCQ09FODU1TzFhYitVSUNHa0YveEhJQ1RMOXRrdXNRRmowZVov?=
 =?utf-8?B?amhwNmxUQVVuV1ZKczh3SzA5Mk94aWtjdUxjcDZUMkQyWHllcW0vRXFXclBP?=
 =?utf-8?B?SC9Ib1JEdDZINksrOEk3a1FSbS9UNTB1ZTJMdzBUdHBzTHNaS3Yyc21nQU55?=
 =?utf-8?B?N3pKZWNOTmdaTUwvSTMxVHVxeGg4S0xWNWExZERZbWk3V29xY1ZHSi9IZHNy?=
 =?utf-8?B?YnprMzUzNFY5NmxqRThQVXppM0RwVHlVNUQ5QmcwTkN6ZU0xODV5Q09BSG5s?=
 =?utf-8?B?a0xnRWpldHZlYjJFeW02Sy9zUGxseGt6Rzd4MzRlZDhqakdYaXNmWmdsNG5J?=
 =?utf-8?B?WlhGbEFEODYyTTh5bDFzdlkvWU4zTWhZdDNlUUR0dE96aWhTR0Y1Y2ljNEg5?=
 =?utf-8?B?Q29EWCtIM2xVdkRhYkJJSWlxTE5rUzB5Um5TNWlyV0ZlZzBJaEs2MXpPL2Jo?=
 =?utf-8?Q?UIrvu8/K6Fe8A0Ks8KAr0+4az?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74d6b96-8459-498a-da7a-08dc3129f46a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 09:05:44.3574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0QEmtg/pj9qhduDRlWUURkp0QHE7enocRjXW8d6Q6rzlxIOzabsI1wTwNCFkXRsODfj+DDo9mPZUnRae0IrPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386

PiDlnKggMjAyNC8yLzE1IDE2OjAzLCBBcm5kIEJlcmdtYW5uIOWGmemBkzoNCj4gPiBPbiBUaHUs
IEZlYiAxNSwgMjAyNCwgYXQgMDE6MTgsIFpodSBZYW5qdW4gd3JvdGU6DQo+ID4+IOWcqCAyMDI0
LzIvMTMgMTg6MDgsIEFybmQgQmVyZ21hbm4g5YaZ6YGTOg0KPiA+Pj4gICAgc3RhdGljIGludA0K
PiA+Pj4gLWRyX2R1bXBfcnVsZV9yeF90eChzdHJ1Y3Qgc2VxX2ZpbGUgKmZpbGUsIHN0cnVjdCBt
bHg1ZHJfcnVsZV9yeF90eA0KPiA+Pj4gKnJ1bGVfcnhfdHgsDQo+ID4+PiArZHJfZHVtcF9ydWxl
X3J4X3R4KHN0cnVjdCBzZXFfZmlsZSAqZmlsZSwgY2hhciAqYnVmZiwNCj4gPj4+ICsgICAgICAg
ICAgICAgIHN0cnVjdCBtbHg1ZHJfcnVsZV9yeF90eCAqcnVsZV9yeF90eCwNCj4gPj4+ICAgICAg
ICAgICAgICAgIGJvb2wgaXNfcngsIGNvbnN0IHU2NCBydWxlX2lkLCB1OCBmb3JtYXRfdmVyKQ0K
PiA+Pj4gICAgew0KPiA+Pj4gICAgIHN0cnVjdCBtbHg1ZHJfc3RlICpzdGVfYXJyW0RSX1JVTEVf
TUFYX1NURVMgKw0KPiA+Pj4gRFJfQUNUSU9OX01BWF9TVEVTXTsgQEAgLTUzMyw3ICs1MzIsNyBA
QA0KPiBkcl9kdW1wX3J1bGVfcnhfdHgoc3RydWN0IHNlcV9maWxlICpmaWxlLCBzdHJ1Y3QgbWx4
NWRyX3J1bGVfcnhfdHgNCj4gKnJ1bGVfcnhfdHgsDQo+ID4+PiAgICAgICAgICAgICByZXR1cm4g
MDsNCj4gPj4+DQo+ID4+PiAgICAgd2hpbGUgKGktLSkgew0KPiA+Pj4gLSAgICAgICAgICAgcmV0
ID0gZHJfZHVtcF9ydWxlX21lbShmaWxlLCBzdGVfYXJyW2ldLCBpc19yeCwgcnVsZV9pZCwNCj4g
Pj4gQmVmb3JlIGJ1ZmYgaXMgcmV1c2VkLCBJIGFtIG5vdCBzdXJlIHdoZXRoZXIgYnVmZiBzaG91
bGQgYmUgZmlyc3RseQ0KPiA+PiB6ZXJvZWQgb3Igbm90Lg0KPiA+IEkgZG9uJ3Qgc2VlIHdoeSBp
dCB3b3VsZCwgYnV0IGlmIHlvdSB3YW50IHRvIHplcm8gaXQsIHRoYXQgd291bGQgYmUgYQ0KPiA+
IHNlcGFyYXRlIHBhdGNoIHRoYXQgaXMgYWxyZWFkeSBuZWVkZWQgb24gdGhlIGV4aXN0aW5nIGNv
ZGUsIHdoaWNoDQo+ID4gbmV2ZXIgemVyb2VzIGl0cyBidWZmZXJzLg0KPiANCj4gU3VyZS4gSSBh
Z3JlZSB3aXRoIHlvdS4gSW4gdGhlIGV4aXN0aW5nIGNvZGUsIHRoZSBidWZmZXJzIGFyZSBub3Qg
emVyb2VkLg0KPiANCj4gQnV0IHRvIGEgYnVmZmVyIHdoaWNoIGlzIHVzZWQgZm9yIHNldmVyYWwg
dGltZXMsIGl0IGlzIGdvb2QgdG8gemVybyBpdCBiZWZvcmUgaXQgaXMNCj4gdXNlZCBhZ2Fpbi4N
Cj4gDQo+IENhbiB5b3UgYWRkIGEgbmV3IGNvbW1pdCB3aXRoIHRoZSBmb2xsb3dpbmc/DQo+IA0K
PiAxKS4gWmVybyB0aGUgYnVmZmVycyBpbiB0aGUgZXhpc3RpbmcgY29kZQ0KPiANCg0KTm8gbmVl
ZCB0byB6ZXJvIHRoZSBidWZmZXJzLCBhcyBpdCBkb2VzIG5vdCBoYXZlIGFueSBuZWNlc3NpdHkg
YW5kIGl0IHdpbGwgb25seSBhZmZlY3QgcGVyZm9ybWFuY2UuDQpUaGFua3MsDQpIYW1kYW4NCg0K
DQoNCg0KPiAyKS4gQWRkIHRoZSB6ZXJvIGZ1bmN0aW9uYWxpdHkgdG8geW91ciBwYXRjaA0KPiAN
Cj4gIEZyb20gbXkgcGVyc3BlY3RpdmUsIGl0IGlzIGdvb2QgdG8gdGhlIHdob2xlIGNvbW1pdC4N
Cj4gDQo+IFBsZWFzZSBKYXNvbiBhbmQgTGVvbiBjb21tZW50IG9uIHRoaXMuDQo+IA0KPiBUaGFu
a3MsDQo+IA0KPiBaaHUgWWFuanVuDQo+IA0KPiA+DQo+ID4gICAgICBBcm5kDQo=

