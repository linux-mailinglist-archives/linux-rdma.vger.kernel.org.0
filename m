Return-Path: <linux-rdma+bounces-23224-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VrVjCD2XVmos+gAAu9opvQ
	(envelope-from <linux-rdma+bounces-23224-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 22:08:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F713758A1E
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 22:08:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=qmcxKVwz;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23224-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23224-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BFBC301424A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 20:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642603ED3B4;
	Tue, 14 Jul 2026 20:08:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126C35F60E;
	Tue, 14 Jul 2026 20:08:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059699; cv=fail; b=LCB+xD5saly0/IexJw9dT1x7wugd9TycdwrMVSF4jgAmJQZTeAa6LhJmB1SItbQnNSRwqHFW8FGluoZfRm767cNsCQLwmdPDPuPsE4yHO4H0Izq/GFqTbtEyHUJTV7DWt/uyho5rpNkX/p1KwhHUuYKJ3eDjhknMyeZXaKBvX1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059699; c=relaxed/simple;
	bh=UE3fw+kmrKK4hG0ftGlggsmjVIVEKfMx4Q70FckH4Fk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XS9fILSS201isOw3zLSiUa15wv0sUBCpZ1k9yDFms6YBVIDcPy5xHFeUo5x45Nw23k4vw9qXWwX5yd6uoT7jkK4/3l5Xs7QIBTWYodZwX1/ujuca/BuI9JMeK18V3DVODlTRkFayeZ3yE+YXgdoC/Z32rCIE9c+sQ54uqcEilj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qmcxKVwz; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+MquoTPW9giulEtygQ3pjmvieDQdbXuHBQzC4ck67G8knjwlxff0bQ6IfUurohu5cidKWiGPzx3w5/f8Uc1CJFYXbh3Adg6soA2nR9Ne41tm/v9q02gIaUi9MXIfmzfK9jOMCMuwdeAOPEVTQ2nUQXMfPVwW40VoYrlX2NwqUG5S1xb5C/IVGea4y5HlVqCneeHF8x6F6mJtfDmKgTqSUAwsYtHHY4nRRB5wo9F40U9+9CAbvDCq/Q+uajmiLrj4k6iGfczycp2akOLxyLuUkXuzOr2uHnmLktzgxGHIxa0Y8iZapf+tcVUPeNbxdjrxzuKf/P1HHuvLGUrDmsQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UE3fw+kmrKK4hG0ftGlggsmjVIVEKfMx4Q70FckH4Fk=;
 b=k315GgW/bKhBL+eyCifsZ/KyOMFxj+avceQ6euvDfYU9WhZ1xMc5BQCbEF5SBbZBdz9LN0CwpjgYYoMJ23Kc/bG+YDmgqbjT4WEMaeltc2hm6Xm3LYrvG167eeWac/nSj4KI0Ruj1GL0vn53wi75Xto8UFMbQnqGvxfiRLyGwqDqVJkatROHAYxYphTini9Tm69ERF1yLiaaf2IdPV5jB41wec4f94t54czbkY7qeR1E+XOBrYhWVkdqLlb0goECZTZ+onDkZXBs8ugX3O6ocFvbaU4lFNIRlTnJcCcaaZ0QQoT/6mRUgkc0KpM52ZH4q+UkVuqgql38FRbIuT03xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE3fw+kmrKK4hG0ftGlggsmjVIVEKfMx4Q70FckH4Fk=;
 b=qmcxKVwzur3InF2gOmXLyPdDh4iFGUBAxoEajIxVddl8e3g7R1BMv8fINMXLEX8CHanFbVh1v7Q0fWGT6ReSCJ0uGtUnS9sBt04jLnpulYZAY3aj1C9n+KIF3qCi68nieD8t7nB5Bsf6HQRQIJ4YFv0TJizHFf93H+QCElaSziTe64FdZHr7QbLm82SSipt007WXiTBlGGgTPudC5DIBnsOJL51GFNbd0cl99umWga6EsI3IA3g4jRDUD9UXJoWL9iBRGvRJWO8x9Uv4731tvsaoow3qwpe3xy5768QQOekbYVUWLDap8tLjuCqUj3QsSi9QW24R1uvWpEBFl2GyoQ==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by IA1PR12MB7520.namprd12.prod.outlook.com
 (2603:10b6:208:42f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Tue, 14 Jul
 2026 20:08:03 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 20:08:03 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "horms@kernel.org" <horms@kernel.org>
CC: Rahul Rameshbabu <rrameshbabu@nvidia.com>, Boris Pismenny
	<borisp@nvidia.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	Jianbo Liu <jianbol@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"leon@kernel.org" <leon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Raed Salem <raeds@nvidia.com>, Chris Mi
	<cmi@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"sdf.kernel@gmail.com" <sdf.kernel@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, Mark Bloch <mbloch@nvidia.com>, "sdf@fomichev.me"
	<sdf@fomichev.me>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"aleksandr.loktionov@intel.com" <aleksandr.loktionov@intel.com>, Gal Pressman
	<gal@nvidia.com>, Lama Kayal <lkayal@nvidia.com>, "jacob.e.keller@intel.com"
	<jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 15/15] net/mlx5e: psp: Report PSP dev
 registration errors
Thread-Topic: [PATCH net-next 15/15] net/mlx5e: psp: Report PSP dev
 registration errors
Thread-Index: AQHdDhJAnHPZpmslsk2Lm6vLlIKFc7ZtUSwAgAArmAA=
Date: Tue, 14 Jul 2026 20:08:03 +0000
Message-ID: <ac799bee802e02b17f5f27e227c84df396d1e1c3.camel@nvidia.com>
References: <20260707130858.969928-16-tariqt@nvidia.com>
	 <20260714173151.1863310-2-horms@kernel.org>
In-Reply-To: <20260714173151.1863310-2-horms@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|IA1PR12MB7520:EE_
x-ms-office365-filtering-correlation-id: f34ed954-6215-4b7f-c5df-08dee1e39c77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|18002099003|22082099003|4143699003|11063799006|5023799004|38070700021|56012099006|6133799003;
x-microsoft-antispam-message-info:
 nMwPAiTeIRGDji6+oiyLCEBtXJRZDJx4I9D096KXdZWD8C/2isGu/Q5pGFLyK27tFgRS26ybL8i9U/3DkAOw2BpB5uQM6DngpvPfb6YX8xHjfHBqp9H0ajq2+heQOJPkZY3colH1MZZsGWv9qs7uLEp96cbXW4l/NNqIjqA3whKQoxr9BLAD0XdnFVwuob1e4ytyoGKQT2MXnWu7AAzAf81rpDECOZ9iccVoqYiJ7tdiqjYezSTiMywMMpndRsrIfA1G0ZxKdT/HvG4c0Ek9cCrVMdj1KnEvDNIDoUp24LUMf3JXE0f16gECqxj/m4ryidTiZ0KcJrBkaPBM51MHut0JDE3HPnMXMf89Qh6UXOvCJTZGwSZWqtL0nmcH/8gM8Z94TLw0dBuY5c25b+sIlX6FHZH/0TpMnFTTZFiTNzwhxSCZiFzANtDDS3qtD8GZiADHdeFIQ3D0bnEq19rGILp18S+u+9Jd0km8ZQpT8WKPioX/uY/F3H2ZU81UC0T8qL9dzH1Ch6FEY4zfGRbJkBPVTIZtZwdeYH7TMrSTPpXYDNlRb/7FeAIQUL5j6+CWawlt/wKWsFBIs9Xkc+fIxamyFOYnxRdSJT5OHrNYRbWgW1e3GnGwodgHlA/RWkg0QFsYkJhCz67K/mbLBiIghkBy11M5HI8LPOHpiL29I8VihN457x4tocoxi2k1XrSzpDsM+98Jpzzl+LIbObohVsCLzbu/0FkE8loehs7R050=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(38070700021)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVhTZFpYTm9TYndrQnpjL2N4NlN1TG0rQlJ6NXRISGZxV3duZzNzczNQWWx0?=
 =?utf-8?B?Vmt1aHByVnF4c0F2cXBOUEI5d3lZOXFFTFNMdHB4UzIwUXJVZngwbCtaaFM2?=
 =?utf-8?B?N3Y3MnFZTTlFb0RreXgyVEZ6QXBKQW1UelVyYjlpN3BjNkR2UURKejJXci9n?=
 =?utf-8?B?WEsrQ0EraVJTYzVvc01lTWpRb05hQ1JtdHFQTGJCVlM5dzhySjFsR3B2Unp4?=
 =?utf-8?B?THVBZ2dMQlpJOHZRQ1dWTmdyazE1V0VsZUJzL0RubHlMUHMySGIvRUpwZVAv?=
 =?utf-8?B?dGg1K3Y4WE14d1lDeTl6VkZPVGxLeEpRS3FaREMzSkdpcFhKVURiWEJBNHNm?=
 =?utf-8?B?NGlmdU1uSU91c0djc0RjZFJodG5NNnVtenB5S2g1YnZkcWRBd3k5T1MxVVg0?=
 =?utf-8?B?MlNqTUhETmJYaTBFQmpScnI4REx4Q21NYUFUYytOcUNFNFIzWFY5MVBBV1J0?=
 =?utf-8?B?eTNRK1ozRyt6UXhaKzNsOXJ1MUFKcFpZd1lkeE4wUjlXWmNMVnF6TTQ0OW1l?=
 =?utf-8?B?cmhvdHJ3OXYweFp2VFJSTXJHWTBBTkNFV0c1ajlqUXY4WVZjZzNNZjZwdmdp?=
 =?utf-8?B?SGZqRk1seFlWRmF3djIrRlFjV3F3K3g4Ny9NYVRaSHFYQjIvb2QyaW1uZHZP?=
 =?utf-8?B?ZldIYzluUnNQY295ekxJQkJ3T3FpSnNzelV5UWRjQzhxU21CWDZnKzVmbnFO?=
 =?utf-8?B?TndYZFNMbloxWk5YOXZPNXVzYncxbzBWVXlaK0FFdlp5eGVDTEZ0RE14MEVn?=
 =?utf-8?B?dm1pZGxWRVBPQk9YeDZzMWowLzBMd0p5UlR3dXVEWVhrOFBCTDBOcTBjeTc0?=
 =?utf-8?B?S3Faa2IwV1NwZ0JJOVJZZ0R3bDhpdnRWSzFEMFpJc2ZhMnVXcVRkNGZUTXJ3?=
 =?utf-8?B?S1htSWZ0cSt4aW1HcFYrTEJWeG1kUFBpREJxRnNXMEprMWZRY05lbE43R2VQ?=
 =?utf-8?B?QzROVjJYOTFVTFd2eXV3UjE0d09HTTlEL2VaVVkySk5PMXU0ZzlGZzJCZlhp?=
 =?utf-8?B?LytYcHh4eWIwMTNZYWhKcHdLZFJRNnhlVkN4S1M3UTZGdnJhQkt1WWFSU2hD?=
 =?utf-8?B?Sm5CZFV1TElobVhvNnB6bDlzY1drYVVRcjk2RVpMWGhRRFFRNmtMdmVWWFRP?=
 =?utf-8?B?UjJHT1dXYWVSL0dLK2FDQUw4bHU0VXhnUFdRYjVBdnQ2RG9Bc1lUMGxjcXZh?=
 =?utf-8?B?ZHBuNkxkSWpYUHZadmlZdWJ0cU91Q3pBSWhvK0xwam5GR0Y5akhFU1JVcXVO?=
 =?utf-8?B?YVdZT0xDbk5zWEJkOThZSW9NT3cvREM2T0NRQnFEME1YNHBGZzFLUWpndjZW?=
 =?utf-8?B?cmJGUzh4K1hUWHRnRGgzeVRTbjg1QjZ0OXpIb1Fpd0xLcGpmdjYvY2k0b2h2?=
 =?utf-8?B?S2p5ZDVEZHBaTzBnY0Ixbk1sYXRUaWNHOGprVFRoWUlMdXlzQ1MyY05vNTBa?=
 =?utf-8?B?QWplNVRGSlE4bVBIMy9NOG4xSFdMNkczd1BvbTlWRFFQV3Vad2ZCNStWNkIz?=
 =?utf-8?B?enpwakQySkI2OG4zZlhKcXBsSmxlTmJnN0hQcEEwRy9aWXpJMFdXZ1MweERD?=
 =?utf-8?B?eG90NVNsQlcxc2hVSEdSSWhkQ1pseGt0YnpNdmZBbXZLdzRyMmNtZHNxR3Q4?=
 =?utf-8?B?U09GRHdWa1JRS2REUS9rOFJqQ3VpR3NNUnN1NVQycEZ5cTJ2cG9kY0hNcFNh?=
 =?utf-8?B?cHlFNFlnNjhOek5wanl5TmMzQnUrS3pIbWNLbHZ3amJXdFF2bGlQVXd5cnNT?=
 =?utf-8?B?Qjd1L3VnS1FzMTZBTmtSZ200RmFXc3FMWXRqWktobTVqTDZEd1pqT1lFTGZ6?=
 =?utf-8?B?ZmJnUERoemsyc3lUSnhzNjZZb0hwVFUyVmZCeUVwTXI1TWdzN3ZRdTV6UHdn?=
 =?utf-8?B?ZGZ1eDlRdG8vVUVhSFNickF3K05EclVLc3BTWHpHS0xoMVpoN2dZY2dpV29V?=
 =?utf-8?B?TFpvdWVxblZIN0VMb1E1RWczZXg4WFBoL1I2NnZMMGIvSHZJQWxZR1ZWeC85?=
 =?utf-8?B?VEZDemsyMk1BNWpZRkJhNU1id3JZVlFLTG1YMnhxNEpnSlIrL0lHQTVjSkhJ?=
 =?utf-8?B?MVlhRjZsNkRvWm9kUkNqM1hRUmtCbTZIYUZUOXk2UThScEtucWx6ajZQY3hY?=
 =?utf-8?B?VkkvUWF3Ui9yYXoydllrRWp6OHlLeFk4a1JzTFRKSy9oL3BTZ3c1S2IxZjlS?=
 =?utf-8?B?T2tlUncyL1hSZElRUmZtYkpTYmg0Wm4zbEd6cVBZWUZiSEF1T0EzMXViRkhy?=
 =?utf-8?B?TUcwUjN1RXB3Tkl6QUhweHVYZjluaUo2OGZmRDJDTUZ0c1R0Z2RpZmlkVTYz?=
 =?utf-8?B?OExHSlRIUUdMOVFjUUEvamxxUkRUNjEvVytsaFk4SVR0cnBZOWx3UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B023DB3B9FC8B479AFBEA9787D56859@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34ed954-6215-4b7f-c5df-08dee1e39c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 20:08:03.1842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NsH5mZ3y85E8NW+ry+LIZd/EkaMW709eaA3vY0KJ8iyDK7z2pMeUl8tfMNiEJtpg4PKubd1xAMpjOmVFOh8trg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.56 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23224-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,lunn.ch,davemloft.net,kernel.org,vger.kernel.org,redhat.com,google.com,fomichev.me,intel.com];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:horms@kernel.org,m:rrameshbabu@nvidia.com,m:borisp@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:andrew+netdev@lunn.ch,m:daniel.zahka@gmail.com,m:jianbol@nvidia.com,m:davem@davemloft.net,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:linux-rdma@vger.kernel.org,m:raeds@nvidia.com,m:cmi@nvidia.com,m:dtatulea@nvidia.com,m:sdf.kernel@gmail.com,m:kuba@kernel.org,m:mbloch@nvidia.com,m:sdf@fomichev.me,m:saeedm@nvidia.com,m:netdev@vger.kernel.org,m:aleksandr.loktionov@intel.com,m:gal@nvidia.com,m:lkayal@nvidia.com,m:jacob.e.keller@intel.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sashiko.dev:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:mid,nvidia.com:email,nvidia.com:replyto];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F713758A1E

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDE4OjMxICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IFRoaXMgaXMgYW4gQUktZ2VuZXJhdGVkIHJldmlldyBvZiB5b3VyIHBhdGNoLiBUaGUgaHVtYW4g
c2VuZGluZyB0aGlzDQo+IGVtYWlsIGhhcyBjb25zaWRlcmVkIHRoZSBBSSByZXZpZXcgdmFsaWQs
IG9yIGF0IGxlYXN0IHBsYXVzaWJsZS4NCj4gRnVsbCByZXZpZXcgYXQ6IGh0dHBzOi8vc2FzaGlr
by5kZXYNCj4gLS0tDQo+IC0tLSBQYXRjaCBbMTVdOiBbUEFUQ0ggbmV0LW5leHQgMTUvMTVdIG5l
dC9tbHg1ZTogcHNwOiBSZXBvcnQgUFNQIGRldg0KPiByZWdpc3RyYXRpb24gZXJyb3JzIC0tLQ0K
PiBjb21taXQgNzZhZmU3ZGU0ZDFlNzA4ZTdjMDFkMjY3ZWYxZmI5Y2Y5NDZkZTkzNw0KPiBBdXRo
b3I6IENvc21pbiBSYXRpdSA8Y3JhdGl1QG52aWRpYS5jb20+DQo+IA0KPiBuZXQvbWx4NWU6IHBz
cDogUmVwb3J0IFBTUCBkZXYgcmVnaXN0cmF0aW9uIGVycm9ycw0KPiANCj4gVGhpcyBjb21taXQg
dXBkYXRlcyBtbHg1ZV9wc3BfcmVnaXN0ZXIoKSB0byByZXR1cm4gYW4gZXJyb3IgY29kZQ0KPiBp
bnN0ZWFkDQo+IG9mIHZvaWQgd2hlbiBwc3BfZGV2X2NyZWF0ZSgpIGZhaWxzLiBUaGUgY2FsbGVy
LCBtbHg1ZV9uaWNfZW5hYmxlKCksDQo+IGlzDQo+IGFsc28gdXBkYXRlZCB0byBjaGVjayB0aGlz
IHJldHVybiB2YWx1ZSBhbmQgYWJvcnQgaWYgUFNQIHJlZ2lzdHJhdGlvbg0KPiBmYWlscy4NCj4g
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29y
ZS9lbl9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29y
ZS9lbl9tYWluLmMNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1
L2NvcmUvZW5fbWFpbi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gv
bWx4NS9jb3JlL2VuX21haW4uYw0KPiA+IEBAIC02MTk5LDcgKzYxOTksOSBAQCBzdGF0aWMgaW50
IG1seDVlX25pY19lbmFibGUoc3RydWN0IG1seDVlX3ByaXYNCj4gPiAqcHJpdikNCj4gPiDCoA0K
PiA+IMKgCW1seDVlX2ZzX2luaXRfbDJfYWRkcihwcml2LT5mcywgbmV0ZGV2KTsNCj4gPiDCoAlt
bHg1ZV9pcHNlY19pbml0KHByaXYpOw0KPiA+IC0JbWx4NWVfcHNwX3JlZ2lzdGVyKHByaXYpOw0K
PiA+ICsJZXJyID0gbWx4NWVfcHNwX3JlZ2lzdGVyKHByaXYpOw0KPiA+ICsJaWYgKGVycikNCj4g
PiArCQlnb3RvIG91dF9pcHNlY19jbGVhbnVwOw0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBD
b3VsZCBwcm9wYWdhdGluZyB0aGlzIGVycm9yIGNhdXNlIHRoZSBlbnRpcmUgbmV0d29yayBpbnRl
cmZhY2UgdG8NCj4gZmFpbCBpZg0KPiB0aGUgb3B0aW9uYWwgUFNQIG9mZmxvYWQgZmFpbHMgdG8g
cmVnaXN0ZXI/DQo+IA0KPiBJZiBwc3BfZGV2X2NyZWF0ZSgpIGZhaWxzIChlLmcuLCBkdWUgdG8g
bWVtb3J5IHByZXNzdXJlIG9yIElEDQo+IGV4aGF1c3Rpb24NCj4gaW4geGFfYWxsb2NfY3ljbGlj
KSwgbWx4NWVfbmljX2VuYWJsZSgpIHdpbGwgbm93IGFib3J0LCByZXN1bHRpbmcgaW4NCj4gYQ0K
PiBjb21wbGV0ZSBsb3NzIG9mIG5ldHdvcmtpbmcgY2FwYWJpbGl0eSBmb3IgdGhlIGRldmljZS4N
Cj4gDQo+IE5vdGljZSBob3cgdGhlIGNvZGUgaW1tZWRpYXRlbHkgZm9sbG93aW5nIHRoaXMgaGFu
ZGxlcyBNQUNzZWMNCj4gaW5pdGlhbGl6YXRpb24NCj4gZmFpbHVyZXMgYnkgbG9nZ2luZyB0aGUg
ZXJyb3IgYW5kIGFsbG93aW5nIHRoZSBOSUMgdG8gY29udGludWUNCj4gb3BlcmF0aW5nOg0KPiAN
Cj4gCWVyciA9IG1seDVlX21hY3NlY19pbml0KHByaXYpOw0KPiAJaWYgKGVycikNCj4gCQltbHg1
X2NvcmVfZXJyKG1kZXYsICJNQUNzZWMgaW5pdGlhbGl6YXRpb24gZmFpbGVkLA0KPiAlZFxuIiwg
ZXJyKTsNCj4gDQo+IFNob3VsZCBQU1AgcmVnaXN0cmF0aW9uIGZhaWx1cmUgZmFsbCBiYWNrIGdy
YWNlZnVsbHkgYW5kIGFsbG93IHRoZQ0KPiBjb3JlIE5JQw0KPiB0byBmdW5jdGlvbiB3aXRob3V0
IHRoZSBvZmZsb2FkLCBzaW1pbGFyIHRvIGhvdyBNQUNzZWMgaXMgaGFuZGxlZD8NCj4gDQo+ID4g
wqANCj4gPiDCoAllcnIgPSBtbHg1ZV9tYWNzZWNfaW5pdChwcml2KTsNCj4gPiDCoAlpZiAoZXJy
KQ0KPiA+IMKgCQltbHg1X2NvcmVfZXJyKG1kZXYsICJNQUNzZWMgaW5pdGlhbGl6YXRpb24gZmFp
bGVkLA0KPiA+ICVkXG4iLCBlcnIpOw0KDQpUaGlzIGlzIGFuIGludGVudGlvbmFsIGNoYW5nZSwg
YXMgZGlzY3Vzc2VkIGluIHRoaXMgdGhyZWFkIHdpdGggSmFrdWI6DQoNCmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL25ldGRldi8yMDI2MDQxNzA1MDIwMS4xOTIwNzAtMS10YXJpcXRAbnZpZGlhLmNv
bS90LyN1DQoNCldlIGNhcmVmdWxseSBjaG9zZSB0byBmYWlsIGRldmljZSBpbml0IG9uIHRoZSB2
ZXJ5IHVubGlrZWx5IGV2ZW50IFBTUA0KZGV2IGNyZWF0aW9uIGZhaWxzLg0KDQpDb3NtaW4uDQo=

