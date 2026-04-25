Return-Path: <linux-rdma+bounces-19546-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDQuDhjQ7Gl5cwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19546-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 16:30:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB7D4669C4
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 16:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6673300B9ED
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 14:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E85346E56;
	Sat, 25 Apr 2026 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="AioTn+Aj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010000.outbound.protection.outlook.com [52.101.84.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9494FFC0A;
	Sat, 25 Apr 2026 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777127441; cv=fail; b=C0CbU2xBRkS7A7TWThmNSoGchNNoBuRLMOWP6eJxlnjYclxY/r9G10DuLTdNrVuu7wVTmzgQYIKFJPg4TkNszS3aKypWtM+uDNqMkg2/76KolNlyvLCcqxtfpMjisDR23XiC3ANncAvCzndbMc5Ro7/7jlQXga4UTTn42Sc3OWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777127441; c=relaxed/simple;
	bh=Uex7qCVGtfg1gNz3TSZ+8yzxvnqE7mETemqIm8SOYCk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cP73YlkXMS+pT+N2be8D/eYbKTui3qgdzTjmNPTWRbS0Q7iG56hrRwTqci91LEWQPWP3xAqCCGm8XqqkDYbjsKeLr1ppBa+JbP9M0tlg2T+/xYu7/lc+WwaxIlLZxNpcCejDIBsDYtSl3Ux0escnA019LMDKDYmk9MIUxtHgb2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=AioTn+Aj; arc=fail smtp.client-ip=52.101.84.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dD/wn26ApgnGVEjVuIiIUoG0lL29dXmSZAHHZKktUZR2RZ4akyGP9FYbtFdeQJNko+0vI1wNOIG/ahiozFXv0yaUG4SrCZCN//jDjTYMc0gELvChftU1bI2PR04E4UaSDbd5KOtN6PszE0Bzf77C9RQxdOufAk4ZUArtIlJo/16ycvZop9e6D+HOm0aiXR/5uWIdzpF8KMWEv7VXctheALIDPGniHFYAEtXAYrvQ9RYdh1amHVP4PcLiY5qY3nW/mbvj2f+evD/j/3O2JVJQF4IS2z1vTBqEUuF2D08Z5g+FuEFiu1D+FRVxpUlRXFremrlIapLhRCuL3+krERvVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uex7qCVGtfg1gNz3TSZ+8yzxvnqE7mETemqIm8SOYCk=;
 b=Ok3FMTS3KXzME6QlX1zILEJNCDkEZEvaadZzYTYkmmZhG2aWHI4jjOYCZ7SsCr5CnrkyF/MewfZLABBKkOEXImtnvIVWPryTHZG2tMsaZd0TAV6ENWjSuIjR9sE7sHuYGuzOUTj59eeKWOOBTRfJ3e8tmxXnIrUH64UM0iro5pWxNV0tv4YGuN21eMQkCbKLeML6aKZxRaaN05GFKmIMbBBwnJU+j59oG20iZ+iA6lgGfmUar/5q7ptoAXntB4gSrlBamyPqCzPRjtT2QleuioD5diJP85thHJXuYyH2i5nX3oNSy9bvW7f5RJLQGRpO1xxytTHRWW5vQ1OhkTvwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uex7qCVGtfg1gNz3TSZ+8yzxvnqE7mETemqIm8SOYCk=;
 b=AioTn+Aj2VhCr/6YhpfpKR4XTNTeGhDCDrdxIuS5osYxctM+sUvY5WmSsbCKmITYxRfPzNkl3pjk5jgXEUS0y2xClm243p3pFHEXTUzMYf1D8usYHokfOAgsqL2BJRyNs8ufkVUbcJ6sIu1qoYZKL89d7VvMK3Q2tYFFdeuwNePDhcwjoTSj6MNHtsfb2QvVXOXPsMYI6gGjjz4MJ0IHnn/mDMeZ4g58PKapeHd7G7xqL7J+p6dhlfxwM14/iQbO5nXZwNN617i4Se062/eRyY1Z2BOWZKl5zlBcq9+SL+KLJUkoH50Ok8kQSqERLClLuIRuDKvCmumnytuPsUGu+A==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB9PR07MB9650.eurprd07.prod.outlook.com (2603:10a6:10:304::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 14:30:36 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%4]) with mapi id 15.20.9846.023; Sat, 25 Apr 2026
 14:30:36 +0000
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
Thread-Index: AQHczn6fixZMzywtaUOMMLkT8kFqvLXvkJ4AgABJjcA=
Date: Sat, 25 Apr 2026 14:30:36 +0000
Message-ID:
 <PAXPR07MB7984A31018E9B85DEC28B68CA3282@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
 <20260417152642.71674-4-chia-yu.chang@nokia-bell-labs.com>
 <6ae96ead-61b3-470a-a30b-3418350a45f0@huawei.com>
In-Reply-To: <6ae96ead-61b3-470a-a30b-3418350a45f0@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB9PR07MB9650:EE_
x-ms-office365-filtering-correlation-id: 2a77c3df-b100-46fe-62ff-08dea2d73735
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|921020|38070700021|56012099003;
x-microsoft-antispam-message-info:
 Fblh9wplsnANGVBPKh8OaB2E83Krlz3OobaHOBGBi89xNnqJoyMeSNEUuo60OH+F3OMAfChQSGiFw0VkdYoRfsFlyQYqXC+e/f1fF08GxiZp4DH+Diz2BYIPBV+1uAmMXCpgb/Yq1b/VaxDB7C4+FayX4eA3yki/2kteMQynRK1YWnms+FmYykR4mtwPJrbh/nLNknHOknJOXt3i+RaU0Dwsiv7RASRpCLA5Yn+78DKAnz0uOb/fEEMXv1exMjN/QpTUKt1M9mW/8Nf+L98OtSvJtsFoCvvuPivN2eaOMHnYmNXploPx48Jp5PnV6LtyHrSoxA5IFeUy/PLs9eFumpGnCl82mRmr9QEb+krY6oZSeAyEI64mTVBrM2EqZouQeKcKGDWPJrUP6Tgj/TP5bvvfz8mmkJCjqssczmnUJb6bhcs/W8rL58GoSF5hKygZJyNmr/wIXTrCixfvjbmAj1B7WCCoGgsZNiv5Kn2FOlG4/Z6Knaj1ZIoPfT3MpkWRv0qBqqbzkVa+pX+8uLo4xQswHnblUnp8qzWEgfhEPUm8a3NTvCNibSn6dCL/1J7qBWFz0dg15DZsKO6FpTnMI8miAUDQhe98BAGg0S7fG0gmCgbY8r/JPzDThEmjONxC5WWcwWkfEfE7EaY2kSi+mwIAqgbhytrw8GL/k61AtyRAU+48hJCz23ggCkFHD/dPvAAligoZoXQUqGhrTZg8xd92ifhQYVzxgUzfD48ME5Yexx+Bq6Sn+YeFFHPUIiOqtl5YOCFYr9Z7Ti860s0WjOGLiKVvjnx30T6+cPu5UT7s9F6I/biqaCcyl41F2d3w
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(921020)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXRxT295TDNsMWJ2SnNzVmdlUXY3SVB2SDVuUEZSR3kxckR2QzNNd0o2UnF3?=
 =?utf-8?B?UXdBbFZoR3NrdW5JUVd1V1JDUlhkRGdUNTZKTllleE9idjJYUEUyWno5eDM2?=
 =?utf-8?B?cTh2VStZYllxbHE5Z2ozRDRqejdpTGxkQXFXcU5NT1FqQXp3TTRkV3FoR3RJ?=
 =?utf-8?B?Kzk5M00zaDBZMExPb29EUFdYTGlpK0xKRnVveGkvRXhqdmkyQyt3eHp1bGNI?=
 =?utf-8?B?TzFIRzFjZzQrNG9FMUJtQngrK3hmVGozNGNqTUhBeHI3V2lZREttdFozcUkw?=
 =?utf-8?B?TjBTd1ZJcGxZRHUrcms1SkdXZ2c2bi9QZW90SlpCN0xWMHJEMXNOZWtuOGdx?=
 =?utf-8?B?em5SNkkxbTZnVkNFRXpaOVBiRzRkUldxVFZFWU1JSHZKTnNGWHBPN0F6VlRj?=
 =?utf-8?B?NVk5UHpJVHBWTER4R2NNY0JWUDkzYmdxOHhQZGF5ZWZReWVPNjlCM2FJQ054?=
 =?utf-8?B?anorY2YxMFA3b0doc3E2TmFaZFZGdU1EV0dwSm8rbjk0SGt3YnBwVVQ3RXJJ?=
 =?utf-8?B?QWh1UUQ3dmtyUE8rYmptL0Z1VzY1U2JhbmxKU2krMkpNaDVKRU9ueW1MbTVC?=
 =?utf-8?B?T2Myc3NEVkRSVHY3R3VHWEpBNUNZVVlaNjdTUmg3amVwZ2w2NkRiekg0Tk5l?=
 =?utf-8?B?VXB6K0Z3ckMxWFlzcDMxUUNuMkNBRmx4SlJCUmlHOURaOVBlbWJhdncwdDZI?=
 =?utf-8?B?YlBTUnBrNmd1REJmSWtiNnE3cG85Qk1SR1QzV1duSWU3U2hWMWVObVRMTzcv?=
 =?utf-8?B?T2Q2bWNmUzFHdXNUQ1kvRmh0YnZEekpJRjgyUEI0UEwxMFBKUHhUS1BoSXBO?=
 =?utf-8?B?YUJoaEl5SlVpZFZ3WXd6dk5DRWxhTmpGR2M1NkM5RjMzNUhwdE1HT1F2enNt?=
 =?utf-8?B?VWdRSzFMM3BJWmxOeGhZdnJHZHdzMkRqMHlYenNaYnRVSGlMMlZ4dTQvQmdo?=
 =?utf-8?B?YU11TkwxMW9lQlB3ZTZUWEFzanVTbHAzZEtQcVNob1hsRTlkb3RzMG9UaHJW?=
 =?utf-8?B?WjZlZzVmNG5MVHg1UFV5TkR5a2loZkgwOWZ2bGp0Ti9OMmlCVU1xNnJUZHRz?=
 =?utf-8?B?bmNvRFBxYlpkUUNUUmltdXNqV0VMa3MxeGJ4bjZubDlvRG5sZndxUWRsQWkz?=
 =?utf-8?B?WGUrcDYzc0NEaEpuT04rUzFxM3RPenY1d29GNEhnR3pUNTJRQk94WVBXUURW?=
 =?utf-8?B?N1dZTmZtaTNNamZHSlh6cWsyVFVZLzE2djlZTXhjTGp5QU81cTZBZWNOdVBp?=
 =?utf-8?B?K2RkZDk4NW51eGg4bFlEc1F4WHZPamduOXhkSWRTUFNGeVRERlM4TUtPdW5D?=
 =?utf-8?B?VXVhR0kreWpWK0Z3Uktjbm9pMUpVUC8xa0tBcmdrMGI3dXJUTkxxRGNoZ2ov?=
 =?utf-8?B?Y21wSjRmbEoyUURCY3k2UkdHVXZ5d2xYeTQ5L0YwbEdPSytYNkhKYTlWMnFK?=
 =?utf-8?B?MDg2d1dWcFdWTnJWbG1McE1HVHRVbHA4R1VsTFFzZkwyNXJlanlETEkxZTh1?=
 =?utf-8?B?ZmUzTUIvdFNSYmM3ZlFCcUNoV0RLQWZSRzhHTmhIRE9zQit2REplU2w4VjZl?=
 =?utf-8?B?MU5oVmgwQ3ZnOFg3K2ZUKzc1OEx2Q2NvVHcwUnQ5bk0zWHNSb3k5cE96YlpU?=
 =?utf-8?B?S0J0c25wS1pXQk9jMHl6R3hhVXpjUlZFeWo0QVZFY0N6MXF5RFA3Sk5aeVlh?=
 =?utf-8?B?U1BjVDRqTlN4cms0STRRQms5eWtxc3A3RDFTM2ljdC95dzlvd3M3ZVpBNlJh?=
 =?utf-8?B?MTJ3U2FUS0tUcVBGVDBZbUlnamRSQnNJMkk4NHQxRE1Iemc2d2I1Tk5xOVV6?=
 =?utf-8?B?YnlPSld2Sldqa3FJVDJlMmh2bEoybCtjTE55NGNpQUtaN0RQdTFDbzkrS2Q5?=
 =?utf-8?B?WmZKQklLbkdNMVlqNm9iNDVLR25ManlpenYvZGR6YW9xODQrSnVnMVp5ekdj?=
 =?utf-8?B?NnJLb0FCRGVBMmVCWHY5cldFNFJuK1R3V2RLUFVnUitXU1lRa0lzVlVidHZ3?=
 =?utf-8?B?WVN5a29JWHREOEtwVzIzS2ZqOXFHd3hXOUN0d0lIc2c1QlEvSjFOTHRQRmxM?=
 =?utf-8?B?UW80UlFma204djRZZTVwNnRkcmFiblNmYVFrOU1rVUVTajR4aWY5TlhaWGFw?=
 =?utf-8?B?ZHhKNXN4Mll5VHk4MmdxOENMOFJQT0lFUjZRdWQ4cExiRmM5RUViL0ZPTHhK?=
 =?utf-8?B?UmNZYmQ0YXhSZ0lLR25FUmthdUZJZWRiR3RaOVl4RkJvN3RCZnZpcUUwNnRr?=
 =?utf-8?B?MEhReXpwRHZGNEJtSjI2eWpVeXdwbFFGNWRSaFJJc2RtaFZPNWVJN2hxYzhL?=
 =?utf-8?B?aUl1SEZtK2s3L1V0bzZPellXMXdBK1Zkanp4Nm5Ka0xrZnlWcmFsTVI2a1Zh?=
 =?utf-8?Q?LPLG9UAF07tRO9QM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a77c3df-b100-46fe-62ff-08dea2d73735
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2026 14:30:36.0526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9nTHSDqRCU32iJy4KwMOZYevGZVKZMjkQ6YpKXgzppj/ry8te4tMzTqeKEH/TlhKJxvrunboILT1KV8lGeItBKH5/IqC9V4OQJVv5/4pn2ZfNxuVuIqo/cd87VDP1F9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9650
X-Rspamd-Queue-Id: 1CB7D4669C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-19546-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKaWppZSBTaGFvIDxzaGFvamlq
aWVAaHVhd2VpLmNvbT4gDQo+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCAyNSwgMjAyNiAxMTozNSBB
TQ0KPiBUbzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwt
bGFicy5jb20+OyBsaW55dW5zaGVuZ0BodWF3ZWkuY29tOyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7
IHBhcmF2QG52aWRpYS5jb207IGphc293YW5nQHJlZGhhdC5jb207IG1zdEByZWRoYXQuY29tOyBz
aGVuamlhbjE1QGh1YXdlaS5jb207IHNhbGlsLm1laHRhQGh1YXdlaS5jb207IHNhZWVkbUBudmlk
aWEuY29tOyB0YXJpcXRAbnZpZGlhLmNvbTsgbWJsb2NoQG52aWRpYS5jb207IGxlb25yb0Budmlk
aWEuY29tOyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9y
ZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwu
b3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgaG9ybXNAa2VybmVsLm9yZzsgaWpAa2VybmVsLm9yZzsg
bmNhcmR3ZWxsQGdvb2dsZS5jb207IEtvZW4gRGUgU2NoZXBwZXIgKE5va2lhKSA8a29lbi5kZV9z
Y2hlcHBlckBub2tpYS1iZWxsLWxhYnMuY29tPjsgZy53aGl0ZUBjYWJsZWxhYnMuY29tOyBpbmdl
bWFyLnMuam9oYW5zc29uQGVyaWNzc29uLmNvbTsgbWlyamEua3VlaGxld2luZEBlcmljc3Nvbi5j
b207IGNoZXNoaXJlQGFwcGxlLmNvbTsgcnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmluZ29vZEBj
b21jYXN0LmNvbTsgdmlkaGlfZ29lbEBhcHBsZS5jb20NCj4gQ2M6IHNoYW9qaWppZUBodWF3ZWku
Y29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgbmV0IDMvM10gbmV0OiBobnMzOiBmaXggQ1dS
IGhhbmRsaW5nIGluIGRyaXZlcnMgdG8gcHJlc2VydmUgQUNFIHNpZ25hbA0KPiANCj4gDQo+IG9u
IDIwMjYvNC8xNyAyMzoyNiwgY2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tIHdyb3Rl
Og0KPiA+IEZyb206IENoaWEtWXUgQ2hhbmcgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJz
LmNvbT4NCj4gPg0KPiA+IEN1cnJlbnRseSwgaG5zMyBSeCBwYXRocyB1c2UgU0tCX0dTT19UQ1Bf
RUNOIGZsYWcgd2hlbiBhIFRDUCBzZWdtZW50IA0KPiA+IHdpdGggdGhlIENXUiBmbGFnIHNldC4g
VGhpcyBpcyB3cm9uZyBiZWNhdXNlIFNLQl9HU09fVENQX0VDTiBpcyBvbmx5IA0KPiA+IHZhbGlk
IGZvciBSRkMzMTY4IEVDTiBvbiBUeCwgYW5kIHVzaW5nIGl0IG9uIFJ4IGFsbG93cyBSRkMzMTY4
IEVDTiANCj4gPiBvZmZsb2FkIHRvIGNsZWFyIHRoZSBDV1IgZmxhZy4gQXMgYSByZXN1bHQsIGlu
Y29taW5nIFRDUCBzZWdtZW50cyBsb3NlIA0KPiA+IHRoZWlyIEFDRSBzaWduYWwgaW50ZWdyaXR5
IHJlcXVpcmVkIGZvciBBY2NFQ04gKFJGQzk3NjgpLCBlc3BlY2lhbGx5IA0KPiA+IHdoZW4gdGhl
IHBhY2tldCBpcyBmb3J3YXJkZWQgYW5kIGxhdGVyIHJlLXNlZ21lbnRlZCBieSBHU08uDQo+ID4N
Cj4gPiBGaXggdGhpcyBieSBzZXR0aW5nIFNLQl9HU09fVENQX0FDQ0VDTiBmb3IgYW55IFJ4IHNl
Z21lbnQgd2l0aCB0aGUgQ1dSIA0KPiA+IGZsYWcgc2V0LiBTS0JfR1NPX1RDUF9BQ0NFQ04gZW5z
dXJlIHRoYXQgUkZDMzE2OCBFQ04gb2ZmbG9hZCB3aWxsIG5vdCANCj4gPiBjbGVhciB0aGUgQ1dS
IGZsYWcsIHRoZXJlZm9yZSBwcmVzZXJ2aW5nIHRoZSBBQ0Ugc2lnbmFsLg0KPiA+DQo+ID4gRml4
ZXM6IGQ0NzRkODhmODgyNjEgKCJuZXQ6IGhuczM6IGFkZCBobnMzX2dyb19jb21wbGV0ZSBmb3Ig
SFcgR1JPIA0KPiA+IHByb2Nlc3MiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IENoaWEtWXUgQ2hhbmcg
PGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZW5ldC5jIHwgMiArLQ0KPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaGlzaWxpY29uL2huczMvaG5zM19lbmV0
LmMgDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9oaXNpbGljb24vaG5zMy9obnMzX2VuZXQu
Yw0KPiA+IGluZGV4IGEzMjA2Yzk3OTIzZS4uZTFiMGRiYTU2MTgyIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZW5ldC5jDQo+ID4gKysr
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaGlzaWxpY29uL2huczMvaG5zM19lbmV0LmMNCj4gPiBA
QCAtMzkwNCw3ICszOTA0LDcgQEAgc3RhdGljIGludCBobnMzX2dyb19jb21wbGV0ZShzdHJ1Y3Qg
c2tfYnVmZiANCj4gPiAqc2tiLCB1MzIgbDIzNGluZm8pDQo+ID4gICANCj4gPiAgIAlza2Jfc2hp
bmZvKHNrYiktPmdzb19zZWdzID0gTkFQSV9HUk9fQ0Ioc2tiKS0+Y291bnQ7DQo+ID4gICAJaWYg
KHRoLT5jd3IpDQo+ID4gLQkJc2tiX3NoaW5mbyhza2IpLT5nc29fdHlwZSB8PSBTS0JfR1NPX1RD
UF9FQ047DQo+ID4gKwkJc2tiX3NoaW5mbyhza2IpLT5nc29fdHlwZSB8PSBTS0JfR1NPX1RDUF9B
Q0NFQ047DQo+ID4gICANCj4gPiAgIAlpZiAobDIzNGluZm8gJiBCSVQoSE5TM19SWERfR1JPX0ZJ
WElEX0IpKQ0KPiA+ICAgCQlza2Jfc2hpbmZvKHNrYiktPmdzb190eXBlIHw9IFNLQl9HU09fVENQ
X0ZJWEVESUQ7DQo+IA0KPiBJIGFncmVlIHdpdGggUGFvbG8ncyBwcmV2aW91cyBwb2ludDsNCj4g
Zm9yIGFscmVhZHkgcmVsZWFzZWQgaGFyZHdhcmUsIGl0IGlzIGluZGVlZCBub3Qgc3VpdGFibGUg
dG8gbW9kaWZ5IGl0Lg0KPiBEdXJpbmcgdGhlIGhhcmR3YXJlIGFnZ3JlZ2F0aW9uIHByb2Nlc3Ms
IHRoZSBBQ0Ugc2lnbmFsIG1heSBoYXZlIGFscmVhZHkgYmVlbiBsb3N0Lg0KPiANCj4gSmlqaWUg
U2hhbw0KDQpIaSBKaWppZSwNCg0KSSB3b3VsZCBkaXNhZ3JlZSB3aXRoIG5vdCBmaXhpbmcgb24g
cmVsZWFzZWQgaGFyZHdhcmUuIChEaWQgUGFvbG8gZXhwbGljaXQgbWVudGlvbiB0aGF0PykNClRo
ZSBBQ0NFQ04gcHJvdG9jb2wgaXMgYmFzZWQgb24gQUNFIHNpZ25hbCwgYW5kIGEgYnJva2VuIEFD
RSBzaWduYWwgbWlnaHQgYmUgZHVlIHRvIFNLQl9HU09fVENQX0VDTiBhdCB0aGUgUlggcGF0aC4N
CllvdSBjYW4gc2VlIHRoZSBleHBsaWNpdCBleHBsYW5hdGlvbnMgYW5kIGV4YW1wbGVzIGluIHRo
ZSBjb21taXQgbWVzc2FnZS4NClRoZXJlIGlzIGFscmVhZHkgYSBmaXggaW4gcGF0Y2ggNGU0Zjdj
ZWZiMTMwYWY2YWJhNmEzOTNiMmQxMzkzMGI0OTM5MGRmOSBmb3IgdGNwX2dyb19yZWNlaXZlKCkg
b2YgdGNwX29mZmxvYWQuYw0KDQpBbmQgSW4gdGhpcyBwYXRjaCBzZXJpZXMsIHdlIHdvdWxkIGxp
a2UgdG8gcHJvcG9zZSB0aGUgc2ltaWxhciBmaXggb24gaG5zMyBhbmQgbWx4NWUuDQpXaGlsZSBv
bmUgbWFpbiBpc3N1ZSBpcyB0byBjb25maXJtIGlzIGhvdyB0aGUgR1JPIGlzIGRvbmUgaW4gdGhl
IGNvcnJlc3BvbmRpbmcgSFctR1JPLg0KQW5kIGlmIHRoZSBkcml2ZXIgY2FuIGJlIHNhZmVseSBj
aGFuZ2VkIGZyb20gU0tCX0dTT19UQ1BfRUNOIHRvIFNLQl9HU09fVENQX0FDQ0VDTiwgdGhlbiB3
ZSBjYW4gZW5zdXJlIEVDTiBhbmQgQWNjRUNOIGNhbiBiZSBzdXBwb3J0ZWQgb3ZlciBleGlzdGlu
ZyBoYXJkd2FyZS4NCg0KVGhhbmtzIQ0KQ2hpYS1ZdQ0K

