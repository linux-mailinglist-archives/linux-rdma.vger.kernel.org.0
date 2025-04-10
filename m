Return-Path: <linux-rdma+bounces-9318-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C02A837EF
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 06:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7621B6340D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 04:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4F51F0996;
	Thu, 10 Apr 2025 04:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JoTWOPLA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c1YJ/IeE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8774259C;
	Thu, 10 Apr 2025 04:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744260086; cv=fail; b=XrnbFszh59OBgIA2cOU5ngBi6bFf1QrPTSkHRctu/xHO9EW9ANjTkWddATKEMMagGyDkQH0kcky1Q2s/RxEGnp5GG/sWYqglP6G05cNrCnOrDj8zAngnIJI1S1Dpl/+g6mGkURWXHSD4WmLcspT14OmGgczLgUWECuvf4bKlYGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744260086; c=relaxed/simple;
	bh=wonjitdhhw3v9Xaxv94Mdx/p41OxwfoqWu5ogn/1kdU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cgHYO3NEaNxBrYlRAeWianf0zIkFn4b7CP/UmwQQG5bYMnED53/Pz8in2F6pGMnphALfSEndYjRES6DvStTiBWzO6IgEBYXoHU66TC6Veu5QV3PFjLZph7SryedE1o4x3NUfLe2K+L1dzC9ws2pJfA3wWLp8fFsWFeC6yv/vD1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JoTWOPLA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=c1YJ/IeE; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744260083; x=1775796083;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=wonjitdhhw3v9Xaxv94Mdx/p41OxwfoqWu5ogn/1kdU=;
  b=JoTWOPLANYolGS4mvMQQX8qbqRUcrDEI7MUERli3DqQ9YlUnrodlLo7K
   m5ajJjBdBqZbKA0CmYhGz9vAbuvqqweTxzTU7JgG69F3vnc9JZPbe0BDd
   8NqOOBiwQJMIVfHF8l7HwHB8rPKbJhdrJdabgU7jlWmCoQictjQ7HOEHD
   w3FGji1ROpx179rBifPENXKIkKKcT/SwHAHBEkiFiG2qez0aCEoIYzyM0
   QFAyR/5IPktEz4NRyCZf/qhPWe0be+GvMW7ms6rRH6qJC8nEQ9PxUmV+X
   /CHu5WZgRjx3eJsaxcShtCA20l5RUYLBB6Hei9gGHh07L69cLiEd4MRq1
   w==;
X-CSE-ConnectionGUID: w8PELyjVTrqIHpxqw+vybg==
X-CSE-MsgGUID: +z2mwVHQSImWUlDDBbMYyg==
X-IronPort-AV: E=Sophos;i="6.15,202,1739808000"; 
   d="scan'208";a="80669379"
Received: from mail-westusazlp17013077.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.77])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2025 12:41:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5EDJrWrJ4c/J3kLmSn982zDhyYaCh5sn6/xwRRFMizIo6zHlMlKKQWaCkXllvWXObrpNXTTD9Pg58IWn14geqFx7LdJ1Lk7Dm9T/wMJn24OhorP0OmzSlxNa/dyKHaJj3fbosdt3K5ga4m9bDj6i+D4V8uiCmL9rvPw4tjH5GfL18fXjfYh6ANo+KGMHzfc6bwyu/rMht7Aeb7xS4VrcTWVsRHAtyCTKkL2/nQ9yONcynw8MyOmS4lxCFYcqcbCaLQXxUbASaZgXkdyP7Doc1xbAvY4TRxQRebO8OodAG+kHGDjwlKfmSPquLpUrgT5b9p2qFZcke+kombbWtVZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp/JAECn46wtWVynC0R4A6eitPrN7A9o6agpMTY5v4s=;
 b=PB59bp6GG9EJz0ruRCDFgAYYF7VBWudA9n/qWUHY/YOD1TfCxdtmfmVJwn2QPgwwjs0y9/8kzJbrIVyEXGkCr3oDCbYWwySPj8tC7oyi224hniCrq2ep5Q3vv4J7U0QTp7LGKvlhFWSr+ku7GBPeXKwCk5s+OhnSxMqgybpLFXW2TEUr6pKpRP7mmQzOjVXkqb5B7gRXwdZk31DhvAnlvZQPVzEfsRUNOzADDblb8w4Zdgb3/9bIWp4YRqkQo6Nu/F3x7BA/Atc5Kria1q9KstQgaVvPxVF20GeJlOGtnjyER61Il8k5fnQYEJg5f3VPbyuLglTApOWxEuKaDxHb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp/JAECn46wtWVynC0R4A6eitPrN7A9o6agpMTY5v4s=;
 b=c1YJ/IeEwXjv25jJntjkbYzOfXwMMtfrCHB9XI4BolBS5kj2ByEgKF/S1U1UUDuUMw0H3RjHNMBFObK75H481e+J39U+n1JMQJ0ShQB74dffHeyYklkyMQuxnoafPQrRWN3stxPzeC7PetVFukrvt7ejII/rzXLhaarulEaAp7I=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DS2PR04MB9776.namprd04.prod.outlook.com (2603:10b6:8:275::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.23; Thu, 10 Apr 2025 04:41:20 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 04:41:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.15-rc1 kernel
Thread-Topic: blktests failures with v6.15-rc1 kernel
Thread-Index: AQHbqdLNx46/9kL6qUut2HcGp4Qzkw==
Date: Thu, 10 Apr 2025 04:41:20 +0000
Message-ID: <x2gnkogq46h66r2fctksnu4yu4wpndkopawbsudq6vqbcgjszu@fjrowpmrran5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DS2PR04MB9776:EE_
x-ms-office365-filtering-correlation-id: d5e630b0-dd72-4216-4124-08dd77e9f072
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yMKZUCIrreElmGRJfnKaCTkZZea3LTQqYCxFUtM2Oz12i1Zka87uUXByG/F4?=
 =?us-ascii?Q?PXpAZ2XMKfMDXfOplfL1oIIWK29TAWzoTOouLtVO53o0gMm4zfiNl+wuEcie?=
 =?us-ascii?Q?hMuEnldmbZ6X2V/Oc1JvOIeWaeQ77zRqU3b4WNg6iL5jx2f/dGP3mj2Akbc5?=
 =?us-ascii?Q?h+4/HaLmWEjDuJix9OYnt28AyzrHofXY/INUmitYxTuhIHq4y0O7Mtwht3ty?=
 =?us-ascii?Q?Vyu7up0BdboGuw4rtAX62j7ZlVFReXU+sDP6p4nXwZIc4LSne1DnxPFwJVLU?=
 =?us-ascii?Q?6AHhFEU9UEPhlTJ0jf0HagCMxb1Ftj0AuYiLOJp6NmH6Jz5NLy9+tpaJtylX?=
 =?us-ascii?Q?QI585j+u+/aPqkJMF6N1p15H1rXFd2JUIM6CbTtU1pWfeqyJNzD2D/vPCQiN?=
 =?us-ascii?Q?UUkysNuPtvcyKg2tsZ+8O7sxJ2odf20j+1Lm4KwTiMXxSxKmPHaIUb7tIwTb?=
 =?us-ascii?Q?x0JoA8JTeuI2aFuUiSgzwrMwjKVbJspqyu1Ijp1lIjKG541l3isigoOCLznZ?=
 =?us-ascii?Q?24QxkKNNk8dSZJjXquUobGkXeiydxpclYQWJlXFOVeO5ShEYOhqaU03Uz+on?=
 =?us-ascii?Q?nejkwhqrGGiuveHge4k8LObANO9hzyEuW3e//mnU4xCpV1JBP14rId0WQ1sB?=
 =?us-ascii?Q?uEtXdCSZ+Fkh5kSxgQ8bg4ukXNkKCe3m6ojyVqwBrnB8uWZVEjiymA1QN6qj?=
 =?us-ascii?Q?/tj0Qlvc25Hq3pofYss5Xo1qXWsYsZe82LHpd60PmrIi98hJbgqrHhf/n2l0?=
 =?us-ascii?Q?uLDM3lUA2Emzd/X+I7u+U7k8Xf9tkBbOhEW2exX1v2MBH8g77f2WKO5inwH6?=
 =?us-ascii?Q?ooDQpF0MmGwHkTkoJp/Nv4TgmZqEWR3bbYpWR37UONhsbYPfyv09tyJusHxJ?=
 =?us-ascii?Q?HJ7mLxgW5gtzAtWZZpZmzB8NVxovdxugD2AEc1/jktf17hevrFN72n8DH9RG?=
 =?us-ascii?Q?ieXu6hz9wVN2lg/0pAHG4PkUKRHCwb57hHkuZr6vYwz2r4Bl2MoenEYr9eJ9?=
 =?us-ascii?Q?3aC4W+W8hMqHirKAavduDcobo6j2Qw0hxcRUgCpjKDPCafQR27ntBddYUSlp?=
 =?us-ascii?Q?BzC9pv78EODEERFp15Mn85lidLgC0/Tu5/PFBLP4f5hINU9Fo2DAWt660sLs?=
 =?us-ascii?Q?0h6KWjaI/hXyMrAP7mgVccuDYZoSIAWns2Y2RU7/RPe9TWr9Ufankikl2iMh?=
 =?us-ascii?Q?rmQcIO2Lez8PlYskoNV0l4BVK17S/Kq3nL5vcEM8DyVNwrg0NbWh1nrg7o1h?=
 =?us-ascii?Q?B2TBe5W4pqHjeHP8RWPoD69/1U6vZGkTmH3pUrKrqOeZG86zBJKPNtlPuf+z?=
 =?us-ascii?Q?lHrnfe4EjEjLJOpKrAmW+bjASJSv8tbAWk1Xq1S7Bm0UKEDOfzA3JbFy2X9U?=
 =?us-ascii?Q?K2o7rsWwUY2/f7g2zchfFDr1QCGpT1DpP6wW8uvMXroOHv7alFC7kSnN5eKp?=
 =?us-ascii?Q?EobkF3iQyXsZDtXn6OtgFoCEWShkfUMN8H/24U0TSodilOke0k4G7pl7M5wX?=
 =?us-ascii?Q?xnos6DM0FEkZenc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9eBG1TATDbsXL2jbERvS6EJ1O94rPYrMuUgfHM9r6yRYE8T2PdUQNoWt1N52?=
 =?us-ascii?Q?Om75QHooFWnzmdhccd4XBY5QZ6W1nd193B5e8AIgIrNE/5yYXNZMOt/UikWQ?=
 =?us-ascii?Q?QKMRetBdLx5zpBK4ly+9KuuZkQ/TpKFt34Wdpt86ahdmy/pzFA1ORICtlEi+?=
 =?us-ascii?Q?ArKZnP/6eAzA+4NyjCFkHjO4hDBOPrMEZKWTVA9dVSFI44Jp9IZwUC1H0GdF?=
 =?us-ascii?Q?D+FjuplxEcbnrGchrOGPTv8nP9/hdRbbqNNSZWwl4ZCnXwYpRc4rAVVmmGal?=
 =?us-ascii?Q?WH4V20DooeQOPgU1GWbnH0ZKjzM9Gjk3NSWtyijVUrVXsABXXNAbusUvATfc?=
 =?us-ascii?Q?Mhg2lQtsmDBtOvqnkLi86iMaE4i24+md0WPwbHobBkXWHcEGJJRuHE3JF/Xc?=
 =?us-ascii?Q?YWTcsGJAtlQsGiJmWBlQ9BpB4yDwoBG8roNmUdSle6HFUEKjkH1ZwBKYqNk4?=
 =?us-ascii?Q?1VOqO4L1UVqE+ALZsZm7KQ76ibA8gUNE+fBS5jRGFGDuIjN1kgiEgvhS0K9y?=
 =?us-ascii?Q?wZrwLED5nzcKVAEictwMPagfC6PH6ggw2ax1a0l7OWIAik3QmeO6l0bJ5lyl?=
 =?us-ascii?Q?NDYvlitzmzDa1YQ0L3qpxyICaGV/PvFyYWKGkucf8uroCHIybBMKhv5i+U+d?=
 =?us-ascii?Q?114sLxlG8a0HdDbbW3t94mUg6vUMHw4zyNkFK0OtJMe2gs6VlAby5ej9qa6F?=
 =?us-ascii?Q?umMlaehYKujzu2URMAUpbhjP4q6117OCTQyBYk8fu1CybMBeUg1Xj9pAFBM2?=
 =?us-ascii?Q?Mzn0GSz925mjIqEgl/nG33kYRt+dMDOLsyjxtU5noHH2Y7RppTXSkJ0QnhiN?=
 =?us-ascii?Q?P7tvXdam8iX6LtFNwUhb83wac4uT2XbeSTqORElAFHtiLTiOG6UrfA6H8gmB?=
 =?us-ascii?Q?Rb+1rnq5t2XrrkuGJfk1wt3GbOuqXYKJpHPOsQ173ZiAzss2+T5kxtudI/tC?=
 =?us-ascii?Q?DJmJ0oDLGMZPSd0qQJR1OfRdqTA/GRkG2XO43QXf+uJo7Tvtv7bSIMeVyWoW?=
 =?us-ascii?Q?PBExMJDzS1R6nrQWcMG27ECpBegxHEMGEFee+bUFNGuSj3zwB4kFuVQzaNBl?=
 =?us-ascii?Q?0XVdkamxd0OsmywrX/EfuEP5bStivDOpqN7ZcyqPbQ2/ucNRS3FXVtqD5D9f?=
 =?us-ascii?Q?S4CYhZ5w/Q+GUIJzz+H1yHVa5JTq7z7ykgTV4VIES58H1BdRf6BKqOc5uuR4?=
 =?us-ascii?Q?4/ZBNNLNnhEwVQkZA1i1LkirVjgJO9kiwK0iLmf4pMvvQrbGDZwv908D4MVQ?=
 =?us-ascii?Q?jvzLUvXyxoWhI9U0UjeuQLpZtDOjn/J5/X75BGjncy+/rIwSXq99uHFf736S?=
 =?us-ascii?Q?KUsHA+bIk1ID5dO/Bd/J7TOFE+pCw9mpySSePil4u/eV/ZdyDzPmFikSXuH8?=
 =?us-ascii?Q?tCjbxcdAyU0jkS9eroBqP2Ky15ZGgno8tdXiG2UO6oluTtuRQPVXl+ndswer?=
 =?us-ascii?Q?w5ekz/OxrrLT3SnUmxmJNDatColljf63YFzJcHelZapwbDVxfUuCLy9JM0bx?=
 =?us-ascii?Q?S7H/D8mqFGcjf9WAECdaPg1OJrIre+e9OCHJgn/UbR457svTuzGj068xgd3G?=
 =?us-ascii?Q?cJ7Ck1m44GL9tnQSry1aI5igTmOQnFkKHDCS60YG/h/NSmCQfqCNRQrlCzB4?=
 =?us-ascii?Q?VskadnA9/PM7Tn6WzHP5urs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24718B8AE8231A448A19A6DF8466CF61@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fIqSt24lLw8jdm52HqTSPM0q8yAUbJHLZQbdKa4iz1rnlOeDlRXbtkkwmt9xqDaqIALc+nRVVYhXjiVlK+EJF8Hrgx3k2VOtl0IKNAcqWysfmH4X4PruE0zqXgytgQF6jWW3TbyFGrXFUmhmkOS34fcGbj7xSDPB8M48UsBj0jyCfYSsrXB6ARKNib62JF/Mxs0QeF4l+kH3lAbNADstQm0A8Y757+k64HLq9nJlcg3nN1gMC293p56tpaPshfXG95r1NVy5ar1cqglxrTA64EkAcW2qYND7AsQpJTfRDZN8t44kQ5cWboisOhA8WGsWKGKn2Isgb9oe8bRRNXrpYkYuUhrP5HFCpQ9AH9wywBFezvUtmH3maKSWql7Bplc4zG8WLap8Tp9pxLF+93/y7vRDAYaGrAPgjcxk4RdFue9IqXj0D9D6ran25y/A5R4R/9PL+AXPuGQ/86eHi1It7rregcrAo2tOwkeTCt7VBczgvMmua6vLT+9wyyJGEnvwhEvViJgK7QCLB1L8QhBsjL6rw3eOkMqNkgKHBxcpFYZfcw3ngKxyVYDIKCVgD1jUj9ff8d1O5IO6dXhJ0dU08lAp+eBxQZNR9o1NFVW1yRsZtPnwYy21UoHkgrFQf28H
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e630b0-dd72-4216-4124-08dd77e9f072
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 04:41:20.1238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6CYhk4SRbXeJ3vtEtKMREMEX3OcOl5oDSBpXzZJz+gRtX7YwDn8R5yCb37382jlB1qXYE8iDCehAuEDIcI0BeocI8oDIncWSdOxK1lF2MtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR04MB9776

Hi all,

I ran the latest blktests (git hash: 9a9a365f389f) with the v6.15-rc1 kerne=
l. I
observed 4 failures listed below. Comparing with the previous report with t=
he
v6.14-rc1 kernel [1], 3 failures are no longer observed (block/002, nvme/05=
8 and
zbd/009), and 2 new failures are observed (rxe driver hang, q_usage_counter=
 WARN
during system boot).

[1] https://lore.kernel.org/linux-block/uyijd3ufbrfbiyyaajvhyhdyytssubekvym=
zgyiqjqmkh33cmi@ksqjpewsqlvw/

List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: rxe driver test hangs (new: nvme rdma transport, rnbd, srp)
#2: nvme/037 (fc transport)
#3: nvme/041 (fc transport)
#4: q_usage_counter WARN during system boot (new)


Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: rxe driver test hangs (new: nvme rdma transport, rnbd, srp)

    When use_rxe=3D1 is set in blktests config, blktests runs trigger null =
pointer
    dereferences and hang at test cases which use rdma transport. The hang =
is
    observed at nvme, rnbd and srp test groups.

    Li Zhijian provided the fix patch (thanks!) [2], and it is already appl=
ied
    for v6.15-rcX releases.

    [2] https://lore.kernel.org/linux-rdma/20250402032657.1762800-1-lizhiji=
an@fujitsu.com/

#2: nvme/037 (fc transport)
#3: nvme/041 (fc transport)

    These two test cases fail for fc transport. Refer to the report for v6.=
12
    kernel [3].

    [3] https://lore.kernel.org/linux-nvme/6crydkodszx5vq4ieox3jjpwkxtu7mhb=
ohypy24awlo5w7f4k6@to3dcng24rd4/

#4: q_usage_counter WARN during system boot (new)

    To be precise, this is not a blktests failure, but I found it on my tes=
t
    systems for blktests. During the system boot process, a lockdep WARN wa=
s
    reported which is relevant to q_usage_counter [4]. I think this needs
    further debug.

[4]

Apr 10 10:24:19 testnode2 kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Apr 10 10:24:19 testnode2 kernel: WARNING: possible circular locking depend=
ency detected
Apr 10 10:24:19 testnode2 kernel: 6.15.0-rc1+ #22 Not tainted
Apr 10 10:24:19 testnode2 kernel: -----------------------------------------=
-------------
Apr 10 10:24:19 testnode2 kernel: (udev-worker)/556 is trying to acquire lo=
ck:
Apr 10 10:24:19 testnode2 kernel: ffff8881241bb698 (&q->elevator_lock){+.+.=
}-{4:4}, at: elv_iosched_store+0x178/0x4d0
Apr 10 10:24:19 testnode2 kernel:=20
                                  but task is already holding lock:
Apr 10 10:24:19 testnode2 kernel: ffff8881241bb168 (&q->q_usage_counter(io)=
#12){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0xe/0x20
Apr 10 10:24:19 testnode2 kernel:=20
                                  which lock already depends on the new loc=
k.
Apr 10 10:24:19 testnode2 kernel:=20
                                  the existing dependency chain (in reverse=
 order) is:
Apr 10 10:24:19 testnode2 kernel:=20
                                  -> #2 (&q->q_usage_counter(io)#12){++++}-=
{0:0}:
Apr 10 10:24:19 testnode2 kernel:        blk_alloc_queue+0x5bc/0x700
Apr 10 10:24:19 testnode2 kernel:        blk_mq_alloc_queue+0x14e/0x230
Apr 10 10:24:19 testnode2 kernel:        scsi_alloc_sdev+0x848/0xc70
Apr 10 10:24:19 testnode2 kernel:        scsi_probe_and_add_lun+0x475/0xb60
Apr 10 10:24:19 testnode2 kernel:        __scsi_scan_target+0x18d/0x3b0
Apr 10 10:24:19 testnode2 kernel:        scsi_scan_channel+0xfa/0x1a0
Apr 10 10:24:19 testnode2 kernel:        scsi_scan_host_selected+0x1f8/0x2b=
0
Apr 10 10:24:19 testnode2 kernel:        scsi_scan_host+0x2e2/0x3a0
Apr 10 10:24:19 testnode2 kernel:        sym2_probe.cold+0xd7f/0xddc [sym53=
c8xx]
Apr 10 10:24:19 testnode2 kernel:        local_pci_probe+0xdb/0x180
Apr 10 10:24:19 testnode2 kernel:        pci_device_probe+0x588/0x7d0
Apr 10 10:24:19 testnode2 kernel:        really_probe+0x1e3/0x8a0
Apr 10 10:24:19 testnode2 kernel:        __driver_probe_device+0x18c/0x370
Apr 10 10:24:19 testnode2 kernel:        driver_probe_device+0x4a/0x120
Apr 10 10:24:19 testnode2 kernel:        __driver_attach+0x190/0x4a0
Apr 10 10:24:19 testnode2 kernel:        bus_for_each_dev+0x104/0x180
Apr 10 10:24:19 testnode2 kernel:        bus_add_driver+0x29d/0x4d0
Apr 10 10:24:19 testnode2 kernel:        driver_register+0x1a1/0x350
Apr 10 10:24:19 testnode2 kernel:        vsock_loopback_send_pkt+0xd4/0x120=
 [vsock_loopback]
Apr 10 10:24:19 testnode2 kernel:        do_one_initcall+0xd1/0x450
Apr 10 10:24:19 testnode2 kernel:        do_init_module+0x238/0x740
Apr 10 10:24:19 testnode2 kernel:        load_module+0x52a3/0x73b0
Apr 10 10:24:19 testnode2 kernel:        init_module_from_file+0xe5/0x150
Apr 10 10:24:19 testnode2 kernel:        idempotent_init_module+0x22d/0x770
Apr 10 10:24:19 testnode2 kernel:        __x64_sys_finit_module+0xbe/0x140
Apr 10 10:24:19 testnode2 kernel:        do_syscall_64+0x93/0x190
Apr 10 10:24:19 testnode2 kernel:        entry_SYSCALL_64_after_hwframe+0x7=
6/0x7e
Apr 10 10:24:19 testnode2 kernel:=20
                                  -> #1 (fs_reclaim){+.+.}-{0:0}:
Apr 10 10:24:19 testnode2 kernel:        fs_reclaim_acquire+0xc5/0x100
Apr 10 10:24:19 testnode2 kernel:        kmem_cache_alloc_noprof+0x4d/0x430
Apr 10 10:24:19 testnode2 kernel:        __kernfs_new_node+0xcb/0x750
Apr 10 10:24:19 testnode2 kernel:        kernfs_new_node+0xeb/0x1b0
Apr 10 10:24:19 testnode2 kernel:        kernfs_create_dir_ns+0x27/0x140
Apr 10 10:24:19 testnode2 kernel:        sysfs_create_dir_ns+0x12c/0x270
Apr 10 10:24:19 testnode2 kernel:        kobject_add_internal+0x272/0x800
Apr 10 10:24:19 testnode2 kernel:        kobject_add+0x131/0x1a0
Apr 10 10:24:19 testnode2 kernel:        elv_register_queue+0xb7/0x220
Apr 10 10:24:19 testnode2 kernel:        blk_register_queue+0x31a/0x470
Apr 10 10:24:19 testnode2 kernel:        add_disk_fwnode+0x712/0x10a0
Apr 10 10:24:19 testnode2 kernel:        sd_probe+0x94e/0xf30
Apr 10 10:24:19 testnode2 kernel:        really_probe+0x1e3/0x8a0
Apr 10 10:24:19 testnode2 kernel:        __driver_probe_device+0x18c/0x370
Apr 10 10:24:19 testnode2 kernel:        driver_probe_device+0x4a/0x120
Apr 10 10:24:19 testnode2 kernel:        __device_attach_driver+0x15e/0x270
Apr 10 10:24:19 testnode2 kernel:        bus_for_each_drv+0x113/0x1a0
Apr 10 10:24:19 testnode2 kernel:        __device_attach_async_helper+0x19a=
/0x240
Apr 10 10:24:19 testnode2 kernel: zram0: detected capacity change from 0 to=
 16777216
Apr 10 10:24:19 testnode2 kernel:        async_run_entry_fn+0x96/0x4f0
Apr 10 10:24:19 testnode2 kernel:        process_one_work+0x84f/0x1460
Apr 10 10:24:19 testnode2 kernel:        worker_thread+0x5ef/0xfd0
Apr 10 10:24:19 testnode2 kernel:        kthread+0x3b0/0x770
Apr 10 10:24:19 testnode2 kernel:        ret_from_fork+0x30/0x70
Apr 10 10:24:19 testnode2 kernel:        ret_from_fork_asm+0x1a/0x30
Apr 10 10:24:19 testnode2 kernel:=20
                                  -> #0 (&q->elevator_lock){+.+.}-{4:4}:
Apr 10 10:24:19 testnode2 kernel:        __lock_acquire+0x1405/0x2210
Apr 10 10:24:19 testnode2 kernel:        lock_acquire+0x170/0x310
Apr 10 10:24:19 testnode2 kernel:        __mutex_lock+0x1a9/0x1a40
Apr 10 10:24:19 testnode2 kernel:        elv_iosched_store+0x178/0x4d0
Apr 10 10:24:19 testnode2 kernel:        queue_attr_store+0x236/0x2f0
Apr 10 10:24:19 testnode2 kernel:        kernfs_fop_write_iter+0x39f/0x5a0
Apr 10 10:24:19 testnode2 kernel:        vfs_write+0x5f7/0xe90
Apr 10 10:24:19 testnode2 kernel:        ksys_write+0xf5/0x1c0
Apr 10 10:24:19 testnode2 kernel:        do_syscall_64+0x93/0x190
Apr 10 10:24:19 testnode2 kernel:        entry_SYSCALL_64_after_hwframe+0x7=
6/0x7e
Apr 10 10:24:19 testnode2 kernel:=20
                                  other info that might help us debug this:
Apr 10 10:24:19 testnode2 kernel: Chain exists of:
                                    &q->elevator_lock --> fs_reclaim --> &q=
->q_usage_counter(io)#12
Apr 10 10:24:19 testnode2 kernel:  Possible unsafe locking scenario:
Apr 10 10:24:19 testnode2 kernel:        CPU0                    CPU1
Apr 10 10:24:19 testnode2 kernel:        ----                    ----
Apr 10 10:24:19 testnode2 kernel:   lock(&q->q_usage_counter(io)#12);
Apr 10 10:24:19 testnode2 kernel:                                lock(fs_re=
claim);
Apr 10 10:24:19 testnode2 kernel:                                lock(&q->q=
_usage_counter(io)#12);
Apr 10 10:24:19 testnode2 kernel:   lock(&q->elevator_lock);
Apr 10 10:24:19 testnode2 kernel:=20
                                   *** DEADLOCK ***
Apr 10 10:24:19 testnode2 kernel: 5 locks held by (udev-worker)/556:
Apr 10 10:24:19 testnode2 kernel:  #0: ffff888120de0420 (sb_writers#4){.+.+=
}-{0:0}, at: ksys_write+0xf5/0x1c0
Apr 10 10:24:19 testnode2 kernel:  #1: ffff888130a62c88 (&of->mutex#2){+.+.=
}-{4:4}, at: kernfs_fop_write_iter+0x25c/0x5a0
Apr 10 10:24:19 testnode2 kernel:  #2: ffff88812d38ec38 (kn->active#72){.+.=
+}-{0:0}, at: kernfs_fop_write_iter+0x27f/0x5a0
Apr 10 10:24:19 testnode2 kernel:  #3: ffff8881241bb168 (&q->q_usage_counte=
r(io)#12){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0xe/0x20
Apr 10 10:24:19 testnode2 kernel:  #4: ffff8881241bb1a0 (&q->q_usage_counte=
r(queue)#5){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0xe/0x20
Apr 10 10:24:19 testnode2 kernel:=20
                                  stack backtrace:
Apr 10 10:24:19 testnode2 kernel: CPU: 0 UID: 0 PID: 556 Comm: (udev-worker=
) Not tainted 6.15.0-rc1+ #22 PREEMPT(voluntary)=20
Apr 10 10:24:19 testnode2 kernel: Hardware name: QEMU Standard PC (i440FX +=
 PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
Apr 10 10:24:19 testnode2 kernel: Call Trace:
Apr 10 10:24:19 testnode2 kernel:  <TASK>
Apr 10 10:24:19 testnode2 kernel:  dump_stack_lvl+0x6a/0x90
Apr 10 10:24:19 testnode2 kernel:  print_circular_bug.cold+0x178/0x1be
Apr 10 10:24:19 testnode2 kernel:  check_noncircular+0x146/0x160
Apr 10 10:24:19 testnode2 kernel:  __lock_acquire+0x1405/0x2210
Apr 10 10:24:19 testnode2 kernel:  lock_acquire+0x170/0x310
Apr 10 10:24:19 testnode2 kernel:  ? elv_iosched_store+0x178/0x4d0
Apr 10 10:24:19 testnode2 kernel:  ? __pfx___might_resched+0x10/0x10
Apr 10 10:24:19 testnode2 kernel:  __mutex_lock+0x1a9/0x1a40
Apr 10 10:24:19 testnode2 kernel:  ? elv_iosched_store+0x178/0x4d0
Apr 10 10:24:19 testnode2 kernel:  ? elv_iosched_store+0x178/0x4d0
Apr 10 10:24:19 testnode2 kernel:  ? mark_held_locks+0x40/0x70
Apr 10 10:24:19 testnode2 kernel:  ? _raw_spin_unlock_irqrestore+0x4c/0x60
Apr 10 10:24:19 testnode2 kernel:  ? __pfx___mutex_lock+0x10/0x10
Apr 10 10:24:19 testnode2 kernel:  ? _raw_spin_unlock_irqrestore+0x35/0x60
Apr 10 10:24:19 testnode2 kernel:  ? blk_mq_freeze_queue_wait+0x15a/0x170
Apr 10 10:24:19 testnode2 kernel:  ? __pfx_autoremove_wake_function+0x10/0x=
10
Apr 10 10:24:19 testnode2 kernel:  ? elv_iosched_store+0x178/0x4d0
Apr 10 10:24:19 testnode2 kernel:  elv_iosched_store+0x178/0x4d0
Apr 10 10:24:19 testnode2 kernel:  ? lock_acquire+0x170/0x310
Apr 10 10:24:19 testnode2 kernel:  ? __pfx_elv_iosched_store+0x10/0x10
Apr 10 10:24:19 testnode2 kernel:  ? __pfx___might_resched+0x10/0x10
Apr 10 10:24:19 testnode2 kernel:  ? __pfx_sysfs_kf_write+0x10/0x10
Apr 10 10:24:19 testnode2 kernel:  queue_attr_store+0x236/0x2f0
Apr 10 10:24:19 testnode2 kernel:  ? __pfx_queue_attr_store+0x10/0x10
Apr 10 10:24:19 testnode2 kernel:  ? find_held_lock+0x2b/0x80
Apr 10 10:24:19 testnode2 kernel:  ? sysfs_file_kobj+0xb3/0x1c0
Apr 10 10:24:19 testnode2 kernel:  ? sysfs_file_kobj+0xb3/0x1c0
Apr 10 10:24:19 testnode2 kernel:  ? lock_release+0x17d/0x2c0
Apr 10 10:24:19 testnode2 kernel:  ? lock_is_held_type+0xd5/0x130
Apr 10 10:24:19 testnode2 kernel:  ? __pfx_sysfs_kf_write+0x10/0x10
Apr 10 10:24:19 testnode2 kernel:  ? sysfs_file_kobj+0xbd/0x1c0
Apr 10 10:24:19 testnode2 kernel:  ? __pfx_sysfs_kf_write+0x10/0x10
Apr 10 10:24:19 testnode2 kernel:  kernfs_fop_write_iter+0x39f/0x5a0
Apr 10 10:24:19 testnode2 kernel:  vfs_write+0x5f7/0xe90
Apr 10 10:24:19 testnode2 kernel:  ? seqcount_lockdep_reader_access.constpr=
op.0+0x82/0x90
Apr 10 10:24:19 testnode2 kernel:  ? __pfx_vfs_write+0x10/0x10
Apr 10 10:24:19 testnode2 kernel:  ? __lock_acquire+0x45d/0x2210
Apr 10 10:24:19 testnode2 kernel:  ? find_held_lock+0x2b/0x80
Apr 10 10:24:19 testnode2 kernel:  ? ktime_get_coarse_real_ts64+0x3d/0xd0
Apr 10 10:24:19 testnode2 kernel:  ? ktime_get_coarse_real_ts64+0x3d/0xd0
Apr 10 10:24:19 testnode2 kernel:  ksys_write+0xf5/0x1c0
Apr 10 10:24:19 testnode2 kernel:  ? __pfx_ksys_write+0x10/0x10
Apr 10 10:24:19 testnode2 kernel:  ? ktime_get_coarse_real_ts64+0x3d/0xd0
Apr 10 10:24:19 testnode2 kernel:  do_syscall_64+0x93/0x190
Apr 10 10:24:19 testnode2 kernel:  ? __pfx___might_resched+0x10/0x10
Apr 10 10:24:19 testnode2 kernel:  ? find_held_lock+0x2b/0x80
Apr 10 10:24:19 testnode2 kernel:  ? __might_fault+0x99/0x120
Apr 10 10:24:19 testnode2 kernel:  ? __might_fault+0x99/0x120
Apr 10 10:24:19 testnode2 kernel:  ? lock_release+0x17d/0x2c0
Apr 10 10:24:19 testnode2 kernel:  ? rcu_is_watching+0x11/0xb0
Apr 10 10:24:19 testnode2 kernel:  ? __rseq_handle_notify_resume+0x3f7/0xc0=
0
Apr 10 10:24:19 testnode2 kernel:  ? __pfx___rseq_handle_notify_resume+0x10=
/0x10
Apr 10 10:24:19 testnode2 kernel:  ? __pfx_blkcg_maybe_throttle_current+0x1=
0/0x10
Apr 10 10:24:19 testnode2 kernel:  ? __pfx___x64_sys_openat+0x10/0x10
Apr 10 10:24:19 testnode2 kernel:  ? syscall_exit_to_user_mode+0x8e/0x280
Apr 10 10:24:19 testnode2 kernel:  ? rcu_is_watching+0x11/0xb0
Apr 10 10:24:19 testnode2 kernel:  ? do_syscall_64+0x9f/0x190
Apr 10 10:24:19 testnode2 kernel:  ? lockdep_hardirqs_on+0x78/0x100
Apr 10 10:24:19 testnode2 kernel:  ? do_syscall_64+0x9f/0x190
Apr 10 10:24:19 testnode2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Apr 10 10:24:19 testnode2 kernel: RIP: 0033:0x7f8784cf4f44
Apr 10 10:24:19 testnode2 kernel: Code: c7 00 16 00 00 00 b8 ff ff ff ff c3=
 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 85 91 10 00 00 74 13 b8 01=
 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec =
20 48 89
Apr 10 10:24:19 testnode2 kernel: RSP: 002b:00007fffc374d1a8 EFLAGS: 000002=
02 ORIG_RAX: 0000000000000001
Apr 10 10:24:19 testnode2 kernel: RAX: ffffffffffffffda RBX: 00000000000000=
03 RCX: 00007f8784cf4f44
Apr 10 10:24:19 testnode2 kernel: RDX: 0000000000000003 RSI: 00007fffc374d4=
b0 RDI: 000000000000001b
Apr 10 10:24:19 testnode2 kernel: RBP: 00007fffc374d1d0 R08: 00007f8784df51=
c8 R09: 00007fffc374d280
Apr 10 10:24:19 testnode2 kernel: R10: 0000000000000000 R11: 00000000000002=
02 R12: 0000000000000003
Apr 10 10:24:19 testnode2 kernel: R13: 00007fffc374d4b0 R14: 000055941522b5=
80 R15: 00007f8784df4e80
Apr 10 10:24:19 testnode2 kernel:  </TASK>=

