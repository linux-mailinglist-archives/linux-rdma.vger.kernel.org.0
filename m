Return-Path: <linux-rdma+bounces-3906-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B629375B7
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jul 2024 11:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955981C216ED
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jul 2024 09:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4F0768FD;
	Fri, 19 Jul 2024 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OgsHuxxE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oW+hMVds"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79D79FE;
	Fri, 19 Jul 2024 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381600; cv=fail; b=aOHfsAm5A7DPaxJAClMWfzLtzbiWYqjmZlEvX56ddzhsNHCGhJmc/d02DWWR/SKNjfPbhvIfb1J/G8Nd875qI6zuemhnRVp40BGF7qXpZmK3STYBcIdyERE6TtZJ/bC7ABUpG0mWKk1MlM4RaOffq2t/arE2xYD3d5c9yFFWCDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381600; c=relaxed/simple;
	bh=G6ievQObbkqPK7e28iPA7bvv+r1anZIFTMfzYDaRdWI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VWCvK4WeD8iMUUzS0TJNN/rNqSxEhZ/KX9ewFmGRosZSI8u4dkUB/kdbLMH3h7+lBhaEgE4E7Joip3/l4RCcpAjw+4+jNYMgdpt8ScgFmThwW41dnte+O97eiptbqdWMvkNQeWHgN2hSCE/9JUxpOChKR9IFKo38lCZoVtMp/zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OgsHuxxE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oW+hMVds; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1721381599; x=1752917599;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=G6ievQObbkqPK7e28iPA7bvv+r1anZIFTMfzYDaRdWI=;
  b=OgsHuxxEILMXXpytFkZUTo+kJY76jJkDJrY7eqgICUuHicWPmb0fm9o7
   gckgA4opNX9KqNb5KErQt3qVavTfQ05cy+jFECC/ZZn4HlROk+F8Wj8N3
   0Rso5OKNOUWWMFYdg2DOtdRPUuqvMm5Zun/va9ahvuf0Y+l5ZLLREayKT
   c+nqpJcuyUTfTDqAokQUGyueIGXEWF6YMwEv71/sMkWeW7bI867Rkwzqc
   mGcLl5BOWjWspNZrkA9ISB3qKLsWUgWSBWcgMQOGpf6KKItLEgt92sk21
   TJyefelRrZCsrpgZjcVIQBjKOvddrUzLWUOv/IMTwV3VryEK/ibujy72U
   Q==;
X-CSE-ConnectionGUID: 1dJd6ix3TeGuSs2ICIYHHQ==
X-CSE-MsgGUID: vC5zAJ4xTISAN660hug2YA==
X-IronPort-AV: E=Sophos;i="6.09,220,1716220800"; 
   d="scan'208";a="21629116"
Received: from mail-westcentralusazlp17010004.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.4])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2024 17:33:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KILEzHlVooq/y1Y6Zx4PkmUW1Yg/XZ6vV7aCWIu8XMu9lHpqjNTx2/fSnuKdXJQ7UuJ6IIFVMo4ytazs1u0ZaqUSqU3DHvN/yAPTDiNedimHpZaxdD724lH28E4GKJfC17LdxL8yv5B6IP3UclYz5lFFtsqwdKu6mbPO59r8bg3CfHjH9h/niBTSiVCERza1bEEnecptW91KfSr1r7cUbUhuAubEwRZRH/Mw6fTTpFI1/0oh0yxdLEUoi7OJLDrTcyFnuGUAg0U/5vG2UjoRQhb7z0BfesW0aUw9wbDz+h/q7mgNMUSsy7/JCjCOfAz7QvWNDv2QamB0b3fJ9k4vqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQWN6R5EcoQfutP5uxMBVHqUB20UaRctEI0NVfIMVYQ=;
 b=E75nZKoViXwXO1yXQNxWJjAmQ0kIwRm+JT/OHuk7xM+EMy7RjsRK8L67jCskfEYWlVG4oBKiebAIazNvYeiS3reQXEkswycibiMpFlnXUE/mAavp/aqhKN3CIuGDu7pQSO4Gzhb9CbCrrewJ0MhSkBiDkWz5EBVhYfob1vp9iGo/hnW1C5+Crqsb0hK47XVge+5Jh+eOmxu/TpoNY6V6Ylsn3qINS2AlW+oHRk8jqWzlkMMnu/Myw+W5Xl9woWi0SHkBBa4p1L7oXLffcI6afZ5yEGLJfu8MVJWsB4aF9zMGg0MSSBMpDJRsWRZeTiIe8MFauK1m0kl2tMeM/G2CFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQWN6R5EcoQfutP5uxMBVHqUB20UaRctEI0NVfIMVYQ=;
 b=oW+hMVdsnmy/NCvCXttuJDJpzZ2utA7/wyaM2XaduC591NC9iRsiPvOjip4HWZsZdTAmMTTziOdAheJCDdT5shY7QzIiNMvgxswEt5Gocil06kiT9kP6HoQZaBauj8as29zcpcXuKPdD7LESezu7JHm0tTIj6rBd3So+qoSCWKM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6841.namprd04.prod.outlook.com (2603:10b6:5:24e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.19; Fri, 19 Jul 2024 09:33:15 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 09:33:15 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.10 kernel
Thread-Topic: blktests failures with v6.10 kernel
Thread-Index: AQHa2b6u81gLoFHGtUWzQozUi9A0xw==
Date: Fri, 19 Jul 2024 09:33:15 +0000
Message-ID: <ym5pkn7dam4vb7zmeegba4hq2avkvirjyojo4aaveseag2xyvw@j5auxpxbdkpf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6841:EE_
x-ms-office365-filtering-correlation-id: 765dbb3d-9037-461a-3bab-08dca7d5d0f7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lNBYk1HbldusiDLg4VOvpiLqsC7avOSsyxjUPr4Hyuu9RPf1C96n2189I5Ek?=
 =?us-ascii?Q?bhaXsDnHBh4qDen1tjUdyjbyasTBFRpdbq21DjBDhPv6ApN8noyY1CcrDufD?=
 =?us-ascii?Q?xWrLX4XBr1gLw6m5zkzGHypyDgLmMakNcOgXs5+Ai1MoHZtIyGaOGWRRBP3x?=
 =?us-ascii?Q?1uCnYM439KEWJ7S0tO13v7omHnmVzSzue0eJQFbPanJFVt+ZihOEWkui4J+s?=
 =?us-ascii?Q?tASAlzm5xoMABxEV0uKmetL36HOaWt9f4NzeORk1URueEZm3VrgIV8ymTY+B?=
 =?us-ascii?Q?7DaTciqZSvDfQl8yXkMocxmnGW9tQiMRp9Fr2oQ3M2bAnavn0ElaN4QJFi+5?=
 =?us-ascii?Q?5VhuIxsgyubBu6ztUy5YRi/IhE/O5eOqNdK29JT0e3oY89FRXnMyOZDoczpq?=
 =?us-ascii?Q?fm5UmpG2Ngt0rudE89AEGx1iVjNTMly/Tvx0X+eQKpp0f0NYjFz4vHodKkrN?=
 =?us-ascii?Q?UNV3tig6RBYh6B27TOZ456MLeTz1Dc5RbXtGWwRcWWsA/lRlB6xJbPVdvmpQ?=
 =?us-ascii?Q?vlgO5msYGrHFhS0hdGB+eAdIwxO2LtSNOMqIaKW/wLJ2ex/PGPzvUOJhvuO3?=
 =?us-ascii?Q?1GH9GaWalGAw9IbKzfIllECzrBGCjVCPfL0D2+rwx7xOy8QJmCeK8qLrV4B+?=
 =?us-ascii?Q?7pg48W7TCKdHQKuEOsZwJmhm/9wxjziSF5cRyx/bNGB6s9QaUis6kOdHfLT+?=
 =?us-ascii?Q?e+C7kkRln4QizyfskK1Q4OTu/AlTPB49PEAKKPMu8EaCLbRvkjpX4bUCwgK4?=
 =?us-ascii?Q?cyJ6FtHeR7XDQz2Rn/PFQhQWGt0micSjTW/mWXbysmCczcY7kKZ7gXFb/3yc?=
 =?us-ascii?Q?V1RCIJQ1N1MjlPYxmSeUUAJs3VQHN0iHnrIL6PPma9wSIKFzoBKIDIpSlX8J?=
 =?us-ascii?Q?RWT0G20ooEz3EofGjkksakrO5C0Z5V1Em3j1t/s6xlT5r3aPdwutpLvlNKn2?=
 =?us-ascii?Q?aBSC5cT5e5/8HIzWA4MvMBc4/Pm7Wd97jyU1Fs8kkXkq4oT3d18JOUPhwON7?=
 =?us-ascii?Q?KcD8leOyGbTFrj6JswLyOfpmYdEIAVt/dFUz5LPTe9TyNImpLBY02E7WAIaU?=
 =?us-ascii?Q?4BURjD8ziyQIY8hIlejJyf5dMvWusuyYSRJg6z+ymfa61S2VGOkmHYo7U1fn?=
 =?us-ascii?Q?L81axn0tt0x7X4RVkbgZ24merPT1pr3IzNzDQ4Oz2ECYRFC4bNyNWwdAal/b?=
 =?us-ascii?Q?Wyaq/CxUE44FxRrCTDJap7VpbwVOtvdXs+4owWXFj1xwwkhAe1eydgsuKE4/?=
 =?us-ascii?Q?JU6CffTyBW4x9e/DUZfzP2YVTF1evnqkTMcmcr4L3aVGoMi/mKyx0LlfHOWH?=
 =?us-ascii?Q?GTBNp2lFDaky9vEqPpu3z+PHITvq2W5fP7cnKKLrBze7iVhZlvRGpbS1E96X?=
 =?us-ascii?Q?NW9bXhM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1Au40feG+lcmXvMSH+VuHVDjCfp/sNTLa77q7BEeQF9imFLqDsMk2NUswPeo?=
 =?us-ascii?Q?FpxpduwbVC0YOYvHgr5KM2p6aJ3rmAxmWiecP3+04XkmeUVs0SXaWGUXI8py?=
 =?us-ascii?Q?W8X0jKmgVfy2O8abD2KO7XX0Q9WNh3is7pMgE+VfaPGMQ9QKhQB6a5Y+tgEV?=
 =?us-ascii?Q?jlfXBmXy8SuMU9SjUzzUk6THYmv9rfNgHUR1bfd0AALOOqPBxYGzy3J5NDWf?=
 =?us-ascii?Q?HZ62C15hcZVF2S6xnffTagn7q3yz9RsIsEFNupozX3nCwyrFPUJj56Pe+2D+?=
 =?us-ascii?Q?Be/Q6qrNrA958yP/P3gO0FQjPMbSxWcurVSFy6Liwr8BgOwsLx2ftWaZNJjw?=
 =?us-ascii?Q?bX6fnnZp47GZl6oi+5DCqJIO8psZchbHQQTqsANGAQ27sJ1cUphtqdKaw51l?=
 =?us-ascii?Q?TqxqITEkIxe/SHjghXDGt/DdnDlE2rwzoiNRD1OLTN35tnb2AbFHOjaTBqaB?=
 =?us-ascii?Q?brE3atVfEaveXMNOROVw4dXG3+eMp4oz/hkIqW8QEJ1hWsc7a2S3lPrU6KvI?=
 =?us-ascii?Q?SE1jB7n/fofpUvzhmdKZXj5cYyCjo6BF8Jl1W3htJ/tK7UmoVry4WqoS8cwx?=
 =?us-ascii?Q?sybIic8Ej5kSw2gOXTcSdWsZrXkNnBHDHezBmm/y9xcGHQqaYj6Uk9v/gCdE?=
 =?us-ascii?Q?Nd+LeJFnP+pLIASbLxhIjEvhQ4lNKpzwn80a9SogTw5ocPSUAgt9UK1gioPk?=
 =?us-ascii?Q?MX1QTWZlnK1zACmysyvMFaom5xBh1nSAxUYa+sgmlDb9ab9+mL7n5Aqdiy3Y?=
 =?us-ascii?Q?pIPGCFinNN0T9RMq47rv6eUvRjF9qs/4cl5m40Bcf/lnJLjEbvqe4+9aeG0P?=
 =?us-ascii?Q?81G1EeEGnN34IYbIua0zjlufDxd1IgQJd9o2hqVVtrG23UsiNoEK3U+aL5LQ?=
 =?us-ascii?Q?3NJHunBtrmaibftZF923LF7Bj0duODb23emuXmjskA4KZcMckp1T8TP0CTdA?=
 =?us-ascii?Q?r8UUSF7Al4/tVd00YNjq4X4Xf2HE4nQ6+Q/g/CMhultxgXyFEP3Q9JdsXXjL?=
 =?us-ascii?Q?bD9N0d84gGuzEyx1pPhMxiTBNcZy7BZ29U8MO2rCxbvDqiEbH4ry8ExG5MgU?=
 =?us-ascii?Q?JHcZQqtSmtMEEYRzhmo59TDSgOoPMvthTxxk+0yjYTrl7nwk3etGiH/nmJkl?=
 =?us-ascii?Q?zWpaw8bkmydK3mduv/DwylrsCSCPITWkzd9erNSbUfCCmaIMDuNM9olFanwS?=
 =?us-ascii?Q?CaciEjO9ZeEjMtQbaAP2AsO3JXVUiV7G/DGhZ/INOI3xwOjgAzz83WgTngGq?=
 =?us-ascii?Q?TsAn6CZXXoY9KVC7LfMXObrhu3jJUCULzzg83xKyufBXw5jlwlSdFMvz4u01?=
 =?us-ascii?Q?y/YfJt3d0a4C7bC8uOlBZTuwKnC2iAy6czFKTlJw9g+o4LHte/5eqhECc0aY?=
 =?us-ascii?Q?E1SAqlM9HNsHevcqoBM2Od5gEOWJ8H2A7ngvPoaBZIlE5qKHotzqtha2cA3d?=
 =?us-ascii?Q?yAsvt/XA7+hY8fTZNoUX+5htLgz7UE/tvJcjGgOBWztRJ034SCdkwFG1UiR7?=
 =?us-ascii?Q?si7H2yBb2IsOEL5uXImv6Ybm3fuluXNSGp8MbHFq0PCvDefkuDAmvZs5XApW?=
 =?us-ascii?Q?IV1izv/ER+pOBN4Z/PHkpwq2djPB74fnBc3kIj10CDp4emJHQLmiZU+HwX8L?=
 =?us-ascii?Q?w6jyepuUkw1A9HU4WBmjiwc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8FFE3524C97F841B3B0C72C082C873D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W+ycuH4uXWh128yiDhWXDJud0HoPr0qSFOu11DJs69vGnaOxyCF+u3YOVXvdNnkC3yVR0LFKFjlc/mr3nm5PXiYSvA4yaeW/aUyZhqji6IUk4yXk50+MaS7Je+Mv05d0TXFhpAoxGIyRCi57YfaozSY8SeJrRcay36WXfgxP+SEwwUMiIuLSSqAKUbUsucu9VZeREMZKvrc1amXY1lS1HevzaYkP7uwbvFv7MMe3Ibrum63vs7Mq0KznFNxFj4Mrt5phByY5dMknLyc0OR4Nd5QaidYZECaFaEXdj0Yim1Frlm2vydPSd5imRz2SoNqp2mXpK+gkCjzj8rlBs2ElbrO8McesjfrzT9E4ocoJiB2MzvvbVvhxgv6WI0+NB1jPjw9WM8MvMpTZTG3/s0wZA3AXX5gRUUyxZmbOhbda+v6ZItH72X9DtOJnExemw/vRC9SObPL2v8VeFfW58Qwn8g2gFiMtJB3lPg+UITwJKTftSyDIZGZx/+IquGpsoMKbKV36ZL8riSu30pqppzLKJqtkf6/4NEBHtekosevEz9FSWudft8d1LFo6sLpExNod/VwYwauezY5FEtmmcoTodKW1OJqKB2XluE1xNa43iQfIBffLNVFf80ogMCsocDf0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765dbb3d-9037-461a-3bab-08dca7d5d0f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 09:33:15.5067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpA7N5t1mZ16PwZS9NhppBEGVL4I1gnoCEvu69ZcrrO16cyPX0SER/ZWNdYoa9diKTzdN6dbUQKZw4tjRfrhs5GCevT7xvampNrxkh+P/O4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6841

Hi all,

I ran the latest blktests (git hash: f79783b44a5b) with the v6.10 kernel. A=
lso I
checked the CKI project run results. In total, four failures were observed,=
 as
listed below.

The nvme/050 failure observed with the kernel v6.10-rc1 [1] was fixed and n=
o
longer observed. Good.

[1] https://lore.kernel.org/linux-block/wnucs5oboi4flje5yvtea7puvn6zzztcnlr=
fz3lpzlwgblrxgw@7wvqdzioejgl

List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: nvme/041 (fc transport)
#2: dm/002
#3: srp/002 (siw driver)
#4: nbd/001,002 (CKI failure)

Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: nvme/041 (fc transport)

   With the trtype=3Dfc configuration, nvme/041 fails:

  nvme/041 (Create authenticated connections)                  [failed]
      runtime  2.677s  ...  4.823s
      --- tests/nvme/041.out      2023-11-29 12:57:17.206898664 +0900
      +++ /home/shin/Blktests/blktests/results/nodev/nvme/041.out.bad     2=
024-03-19 14:50:56.399101323 +0900
      @@ -2,5 +2,5 @@
       Test unauthenticated connection (should fail)
       disconnected 0 controller(s)
       Test authenticated connection
      -disconnected 1 controller(s)
      +disconnected 0 controller(s)
       Test complete

   nvme/044 had same failure symptom until the kernel v6.9. A solution was
   suggested and discussed in Feb/2024 [2].

   [2] https://lore.kernel.org/linux-nvme/20240221132404.6311-1-dwagner@sus=
e.de/

#2: dm/002

   When udev accesses the test target dm-dust device, "dmsetup remove" by t=
he
   test case fails. A fix patch for blktests is posted [3].

   [3] https://lore.kernel.org/linux-block/20240719042318.265227-1-shinichi=
ro.kawasaki@wdc.com/

#3: srp/002 (siw driver)

   During the fix confirmation work of srp/002 hang with rxe driver, KASAN =
slab-
   use-after-free was observed with siw driver [4]. Bart identified the res=
ource
   freed under use (thanks!). His kernel fix patch is queued for v6.11-rc1 =
[5].

   [4] https://lore.kernel.org/linux-rdma/5prftateosuvgmosryes4lakptbxccwtx=
7yajoicjhudt7gyvp@w3f6nqdvurir/
   [5] https://lore.kernel.org/linux-rdma/20240605145117.397751-6-bvanassch=
e@acm.org/

#4: nbd/001,002

   The CKI project reported that nbd/001 and nbd/002 fail occasionally. The
   failure cause was the race between nbd-server port readiness and nbd-cli=
ent
   connect. A fix patch for blktests is posted [6].

   [6] https://lore.kernel.org/linux-block/20240719050726.265769-1-shinichi=
ro.kawasaki@wdc.com/=

