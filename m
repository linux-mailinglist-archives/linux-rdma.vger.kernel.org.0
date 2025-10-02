Return-Path: <linux-rdma+bounces-13764-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A922BB3A6D
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Oct 2025 12:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3B87AE052
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Oct 2025 10:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B1430AAB6;
	Thu,  2 Oct 2025 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Obrl8ptV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pZ1Lrkdk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28EB15853B;
	Thu,  2 Oct 2025 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401428; cv=fail; b=cS8YUXwmoXIiyLAbAvwb699WuLeDKhgd2J9RxMabgVQaTwx5LXlGvJxufO+faF+yIwJnKXnFkmk59EN2rXCPyLY8YE70H8uRBzfmCeFecTVoHvDF+hxGm8rBMQTVEqv48NFJqCdQzdhPIEuNbo70KRjbfhDj7nUW+ma8+LWUV/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401428; c=relaxed/simple;
	bh=s80U5LTZ6qDkbAzYh/y3DY5o+e5rKp3thULSY48U8TA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iHIuHeD6+SZN0C8xejN5bV4HzEWfOHm7cHYk0dIuvWiQ0QLDGnc4wNZIsYWTYAJH4p/pf35av8uEJBgdEDyJE0phw8I8VZ1Qx0fTH28ha5Uh5XTrPtBEZcdPC73tYGI097tNiX/pdWALmtqqtu6RMGAbXfKI20sALZaHYAiq/DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Obrl8ptV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=pZ1Lrkdk; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759401427; x=1790937427;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=s80U5LTZ6qDkbAzYh/y3DY5o+e5rKp3thULSY48U8TA=;
  b=Obrl8ptVaGtqySkBP3avAwVrEwMYiWqiqh8r1Urt0O3D+Qrs1QsLVBw+
   vfgfc0ohhuhD8shqVp6hMqka8HD3tm32fnNAvNOFJqRDnopYMc4yyLxyS
   EDT3PVSdvY/28rIFXKfHTx8BQ80HZl/x7lotMaJ1grFXZL8CZjEdFW3Sw
   ++GtIf4+C+c3lpMxJLuGH53Ao8EwNvhblWt3/M2m2/WqR8DxqJ7nyBbbZ
   ygGTDhM7nxeEdH6k3jv6pWDh+hwkQNF3MJPB/JUfRPHI7JVTs+dhqTY0L
   gwI1UbfVdumtm+9AYQ9zq9l2t5Z5lUJiURoIVb29kSNnUnrOTHiahu/MS
   g==;
X-CSE-ConnectionGUID: 6wkCgTLhQFiL2z5hs5sAgg==
X-CSE-MsgGUID: saYYymFJSN2n8gr5X6cXEw==
X-IronPort-AV: E=Sophos;i="6.18,309,1751212800"; 
   d="scan'208";a="133397430"
Received: from mail-westus3azon11010030.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.30])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2025 18:35:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WblT7nkA8hHppd+DQMZeg3lKVxbCo7XJA4IV+QzK9dR07mJYxycCojboqtCeJ7oXGjk+z9xoZhdGjofrF+sXYdCagcXVpqSA1bRnCAYJJXVUR8MFWs/CddI8L8zbC8pyeZOwRHpEldCEknBMLz2xPoHYsEzF/JrkedrkDhpga8eJzmfgQn5poQvH87YtWXcnsjx/g/PekLN1yru5S4GURBhJSSmHj7idAEBeCCTQi4rgbly5+f44QKaYlvwGDlK0WvZ55CBi9qCdNj33S9U0RArteADbfaifFBEcQz6vdFO2lSqR+lDGIhPyHAISODYxaSPybRjQcTA8R/blj9tSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+yHyYcD1rrw2scbG1qw/RLvcwbyrezccZYBQfF9ffQ=;
 b=H+zCr7vCwuTSIrmXE1QjNFizQElmKqS1qhh1tbAtiTDRnoZ6tAu2a1MqwMbGn0uQ0I8t9SudCyZjw2OyRBI+NQRVoCmLR+dTWk3LqgcC4AzsxY4GbdiK7cC0GjR0e8Nl6eIMzTvctjcpQ9Siy5JbyBY6fOMY3agZJRONEJaCMXn8Yu1BnC4PSuJKh67FGmgH/klAsvhB1myPMdVfGk+/f/xJai68rf5ZE1HOvg083pZYoXTCI/G46JLSIcgocS937Q3ZwEhPpCzP7vZKR+dPZKTkxLbpMQqbpmgSI+xIT7LTZcJK2TOMRL7Jd79lgcInT55RduBNQjdMRsMrdVkZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+yHyYcD1rrw2scbG1qw/RLvcwbyrezccZYBQfF9ffQ=;
 b=pZ1Lrkdkq+a/q+Qkq0hLo7MCsTLAJTq3gcrtzWEP0A8Wc1EPvlOxHF1EXx6Ef7566g2ExDfo9z3lNIVfiEdfbpyICFRftQoPJ3l2uSNUqSBz2gIz3qSnL+AGyFyce0nYb/0vCPjYP7ORDePkSIhrCcau/GclF4WdMdr+4TE3K1k=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SN7PR04MB8695.namprd04.prod.outlook.com (2603:10b6:806:2e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 10:35:49 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 10:35:49 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.17 kernel
Thread-Topic: blktests failures with v6.17 kernel
Thread-Index: AQHcM4hR6D1/zZvLAUuRCA1aJnLzmA==
Date: Thu, 2 Oct 2025 10:35:48 +0000
Message-ID: <3bbujxlhhzxufnihiyhssmknscdcqt7igyvzbhwf3sxdgbruma@kw5cf6u5npan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SN7PR04MB8695:EE_
x-ms-office365-filtering-correlation-id: 3e44fc3f-392b-4386-6b9f-08de019f7415
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?upFu4k908JF855xAqy6bLfk4fkc6Fbb8IV0+7IifhsWDhJhgTAXrBPbkb+No?=
 =?us-ascii?Q?0DZotfPnxLWbenqvzZ7EwOdElIECB87vNITvctQO4BTNWgbz8e8JVIGjo4dK?=
 =?us-ascii?Q?chnSkayMQ5joEYxTc2THT842LFeehmOy9w2Jd0PmObAtj4rWXa9AeBojEfnE?=
 =?us-ascii?Q?ih4sLn6xezf8qkGETGbK+1Rfq+l4+RHK21GFfJZgghIlXphESZ+2Ada6DWC+?=
 =?us-ascii?Q?u8oWV3DyFjbXcuIZeQ3szcGKyCCSLV7px1bNN/atZd3bG+f7qorkvmJi21JD?=
 =?us-ascii?Q?VAcfQxv7UavS5GMFARkmYi8gBRcgXZCMO+3Ptg2WHgj2wV/h+rYyFmXQ283n?=
 =?us-ascii?Q?y7FNQf2wN74UUZcdGcfvErzNACgHYlLGR1ks98v6eRfTxO8/0LWDNcR2mDaY?=
 =?us-ascii?Q?umUQX69j12mhBPDQaneuzWl4PIafhs7ZK8yC/3Xp5DQKXWLBfGnVYzcTvNCG?=
 =?us-ascii?Q?W+zqQlvx4njPNlWSYpRjrA5WZBEw22KUaf94xPTjIuQ8PYO9o2/iYQG7OBXa?=
 =?us-ascii?Q?8bKPVWD6RJuipJSpm2YjNo6Nv7HiK6Z3ozJsYr8Exuo3gMINEjES+dSQoKiT?=
 =?us-ascii?Q?k6VKMqgq5++thYaXShvFuze91EpDZ8RQ5rq74KlfodykPr5LAUThuhOAfusW?=
 =?us-ascii?Q?mOZdTuRdcfnMIc+9QzCJhwwbKsTX+35LMd5q4T0PtEsNvBJMp8ibHTo0SUry?=
 =?us-ascii?Q?fKvMHhKWD9hhUX7bkgmJUSQeL4c/823BV4LVLG3ExfgqEjd9Cm6xtKnKMU+5?=
 =?us-ascii?Q?xTkM1EYvW43L9BIaV1OEDzeDPZfIdeSnu0/YypajcqEpG6hjPSKVmy4qMiIc?=
 =?us-ascii?Q?BfWvz468WfnpYpK9whLenoO08raEHsjoswF0RgimHMBclBAo9s4+SjqSeD1z?=
 =?us-ascii?Q?aboaR1jAP35GQZ+h4aKRUNfpWdvbKFx2eWg+krtpqDti5FzMSM7WLLZiek92?=
 =?us-ascii?Q?lL1kxP26b3wbMt/i/64VrhhXci3lUTlhDVslBZ5Iy7Dy6TwP6yP0A9DRwExE?=
 =?us-ascii?Q?LpP0qtT/+bwSlMSNTZd9ft0u38p8oGnON3LqnC2p0HMCVT4l4tLDGlTfhXrM?=
 =?us-ascii?Q?yprAOhsIHd5xr6+E5qlRYkGN7uUApytl0PGrw8vqjuUsUtr/HEFWvWU6KYhc?=
 =?us-ascii?Q?aORDB6xzpaReoB0Aj9n9kcQdtbXhrOn9qGYGr1VZn9gb34EBUmJvfgsoAZXH?=
 =?us-ascii?Q?J1voxvybgMxslsibOuu8xx20ru5HMClrr08+J1ZcVId7szp+ER6XXPFAy84C?=
 =?us-ascii?Q?iHDjXPxd8hUlj+ecBFzQt/ckuLDi4nzCYO1p5Dnup5RHil3a8XHyzegiX2VM?=
 =?us-ascii?Q?mqYo7+gCSr5yveQn/4fmHicEqv4hy53v1uPqeLUGwRBCRf0/6rB1BGYlROTL?=
 =?us-ascii?Q?n/H5/Je5YemI2vmcRgYHJ4xxbbXRSXOKjHmXzq9X3yd3+r2pazhWxv/kTmBr?=
 =?us-ascii?Q?CaKFk4z9bMr76XRaWivD49aAwB00dvcuPKQj/wP00moXwrHJlaiyxezcVXH+?=
 =?us-ascii?Q?Ti8NdU70wbnKyIveVOrwGCXCzKA9GNbZAG2CzSuHIXouzlF4GBhdmpVf9w?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X6dxkyHr3OTZLDU1urc2H4ROmQroPdXCwpfoYeFSAocmz+NDaCYKlti4KPHG?=
 =?us-ascii?Q?ng4SgyvfNrT8fjsfsEfySvHK4NBYOl7wShqAhtwlEBxvzrX0Z5FF5a8Tos8k?=
 =?us-ascii?Q?NoviJxnHJBvM04fePpaP9pTy2oaVcAy/+lnqxKuH/WI+j3GN6pKTfwIAnR9c?=
 =?us-ascii?Q?xdH5Mz/xWYcvC8HwqBZ44FDHOqkja6gALNE4YVvaUcLFDk8SMeTDA82jVJHJ?=
 =?us-ascii?Q?pAm9ASSqKkfxgmq0wiYlNrEGoJEFpq7Z8H9PN6zz/FGevphhCJudUJXXKgpR?=
 =?us-ascii?Q?QH6VR2/Rns/up3Q7m+42luWoLW0bdd5U8cTUAGv1SSGhtNwu6GESX8Nat68g?=
 =?us-ascii?Q?/cHvVKWLNGEchRtNJ2AT1WZg0oemVDHSJiKMehhSyhCehgW1XHgMaD/Uuu2s?=
 =?us-ascii?Q?0dOXTTF2pJhukp9qLWR7NfcX5qrrZh5JNW2WT+p/0NBDjW4N1XXroV18aSQw?=
 =?us-ascii?Q?H3v/kFqLQiP1+KLr23CrxJ9UeLNjKiTQBm8DAxpVdgM8LP1SODDhnL5EA8IS?=
 =?us-ascii?Q?LvMjXaA4i2etr/oSFQbPuGD5StErSov124YSgXW91q8Y3RAxRPbkNSNmpyjn?=
 =?us-ascii?Q?5lMSQBQmZHp1GaXyb7qC/2pnIBht4kLC+bINQ0RoCeqU2IKk8D7IUiauJKMp?=
 =?us-ascii?Q?vm73EB0WZ3IF7wbqMcv2LTZT+/YoXNB/MquwmbPNVarSMiZxg+baQIoyDjGd?=
 =?us-ascii?Q?j7kycxCS4ZKObJz/uFhdsagJnb62sQJkMnIFQmxG7b3C9XZpu8KjLB1jkPPp?=
 =?us-ascii?Q?/GS9RiBNlFsmMT2ZbPU/qcn19PmZp5Qt63nopuM0ZgXj7YfTY9R7ZwSL67Jm?=
 =?us-ascii?Q?BaGBSwyFat6bWlza1h3rxaKSIQ6BZvTtJONb4gmr/57MHZcCeWg9xKMF89pH?=
 =?us-ascii?Q?SqG70OUd82qdGepXOUkS0DjJmg3G9B6reOA6RTlsVwIavVfM2nLiAWv3jodu?=
 =?us-ascii?Q?bUVLnPhHlif330EsEC2ZI+wmwjGnz1EZWNfhNRCQm3X4Hy5ZQoUOoisAXvzS?=
 =?us-ascii?Q?hHL4KtOA9U8jphh2CMVZfDdB2GipYoaXMAj8Tr62L9HqZHwSwYr1tvowp7yR?=
 =?us-ascii?Q?Bs4ZnKWj7pDOFszaTfSQoUq8hr5ljK6AL6AesTkHftExoUBfTstqY4ikXgOU?=
 =?us-ascii?Q?+1G2/c3fXgvf5mJtlCcvukKWMF4K3SpC8knRA3rCLKXf2Fp1Cak0dZFM6w1i?=
 =?us-ascii?Q?byn98+ycZ+cYPriQuPeHs98oZyBWfWMtFfkq0zsaADykunl1XSvgdV3rhtjF?=
 =?us-ascii?Q?wgPX8MmS2mz89rV48Ev6efW/IB9izkIpzYP7PqOhpOxbY69vrQGcdLNt+V10?=
 =?us-ascii?Q?Qeiu6BxXi0D5+vNGJf4qFaI0bTgOt1im/cQET7u8FCVOfXm2xxWM4suY2OJq?=
 =?us-ascii?Q?1oi8yuV4R4C4wIXEA6EdUxNyhAictfXvaXwO8Zo4RS6yaMjpEjRMVza9kJMz?=
 =?us-ascii?Q?LjumuZLq8ItvxpUPHwk4C7pF07JAPAWTFXH0pP2olyRV0pvvFQnY9wK4hc8q?=
 =?us-ascii?Q?L0xwT4v/321Ztc4PfVJ2B0yX3uU12RljN/DPBuZa3SxTOWhgpNu9su/fZLpk?=
 =?us-ascii?Q?MPoRoX4NPg7fUe5+qs54lE175GWLiKhumKFvhzxuqv5PtS8r+8sV8Bv0zGlU?=
 =?us-ascii?Q?qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <661A47128F7D1B41AAEE707B99BD8F3D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wOya/+sEgh9FaWw1WKSTJ8dvnevxXf/vsv4LeOrZuns04mYXC/VdQQwVLWEWn/hQJNX2ABwJwyGW/+Q6ro+Xha9tjDmt3MbIp4+dhzFFTNwyLbAeXSmDCEzCURoWDQg27W+NF9j7kvMKFxaSegOuU6L6ehEA36AciVvO5x1bWth2CLslhAXqEw4TIQGxQ/05HbQrhOjFWYgd4QH9mRm83yOeWFXw/YgP040HwsInKWjM2O3G2cFBmeGAcIREUy8OjmgZUEDzjryF1O5c2er0JfOuuQpiDVSgoCjqyw2eSoF5bbl6Drx9nxWwo15+Xj9TSgOU+mqH++HRhm+qkHMa6Z9re0Tpg+082eEabtTS68C8bSGm6GIGEd9DDN09YuZ+vHvdSAsAj2ZRWOLBuJHjdOomKE9yuzb338ebZgPdxAT544a3vAYq8bDCqlNjJ+DoGn448GjCKxg55Wmhzaz/4eqEZHx8E5w+J+nQNhlL5AcQeTZqz+F6b701ILpYfF7ilGCHsJdZpPPUdZVMdtJwKybOxuq9oWmlAPpBtB40k+sHQvw+euPB5+1M3PCE/Urjz6PVSD78lYAaYpO8LqWL1yUYr5Zr12Zp3NhTkeV5rsE9YRFXWiIGhtCsYSMRFfVu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e44fc3f-392b-4386-6b9f-08de019f7415
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 10:35:49.1608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IaB+cWCujmDkikYZ8/3yhwN4dr9Htc6F3m/Cv/m4+Dopq/aLFbRVrmSKSY4w03X2F5yyiBEc2X5Bsa8QkHygpURDqdfNDVj6QGGSFbNC57g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8695

Hi all,

I ran the latest blktests (git hash: 8c610b5bd81b) with the v6.17 kernel. I
observed 3 failures listed below. Comparing with the previous report with t=
he
v6.17-rc1 kernel [1], no new failure was found.

[1] https://lore.kernel.org/linux-block/suhzith2uj75uiprq4m3cglvr7qwm3d7gi4=
tmjeohlxl6fcmv3@zu6zym6nmvun/


List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: nvme/005,063 (tcp transport)
#2: nvme/041 (fc transport)
#3: nvme/061 (fc transport)


Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: nvme/005,063 (tcp transport)

    The test case nvme/063 fails for tcp transport due to the lockdep WARN
    related to the three locks q->q_usage_counter, q->elevator_lock and
    set->srcu. Refer to the report for the v6.16-rc1 kernel [2].

    [2] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7w=
j3ua4e5vpihoamwg3ui@fq42f5q5t5ic/

    I also noticed when I enable the kernel config NVME_MULTIPATH, the same
    lockdep WARN is observed with nvme/005 [3].

#2: nvme/041 (fc transport)

    The test case nvme/041 fails for fc transport. Refer to the report for =
the
    v6.12 kernel [4].

    [4] https://lore.kernel.org/linux-nvme/6crydkodszx5vq4ieox3jjpwkxtu7mhb=
ohypy24awlo5w7f4k6@to3dcng24rd4/

#3: nvme/061 (fc transport)

    The test case nvme/061 sometimes fails for fc transport due to a WARN a=
nd
    the refcount message "refcount_t: underflow; use-after-free." Refer to =
the
    report for the v6.15 kernel [5]. Daniel provided a fix for this failure=
 [6],
    which will be included in the v6.18-rc1 kernel.

    [5] https://lore.kernel.org/linux-block/2xsfqvnntjx5iiir7wghhebmnugmpfl=
uv6ef22mghojgk6gilr@mvjscqxroqqk/
    [6] https://lore.kernel.org/linux-nvme/20250902-fix-nvmet-fc-v3-2-1ae1e=
cb798d8@kernel.org/

[3]

[   49.880160] [   T1102] run blktests nvme/005 at 2025-10-02 15:52:41
[   49.955684] [   T1486] loop0: detected capacity change from 0 to 2097152
[   49.973977] [   T1489] nvmet: adding nsid 1 to subsystem blktests-subsys=
tem-1
[   50.000216] [   T1493] nvmet_tcp: enabling port 0 (10.0.2.15:4420)
[   50.094320] [    T113] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349.
[   50.101675] [   T1500] nvme nvme5: creating 4 I/O queues.
[   50.105800] [   T1500] nvme nvme5: mapped 4/0/0 default/read/poll queues=
.
[   50.109259] [   T1500] nvme nvme5: new ctrl: NQN "blktests-subsystem-1",=
 addr 10.0.2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7=
f-4856-b0b3-51e60b8de349
[   50.424485] [    T169] nvmet: Created nvm controller 2 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349.
[   50.430147] [    T462] nvme nvme5: creating 4 I/O queues.
[   50.448180] [    T462] nvme nvme5: mapped 4/0/0 default/read/poll queues=
.
[   50.500881] [   T1548] nvme nvme5: Removing ctrl: NQN "blktests-subsyste=
m-1"

[   50.536145] [   T1548] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   50.537233] [   T1548] WARNING: possible circular locking dependency det=
ected
[   50.538374] [   T1548] 6.17.0 #367 Not tainted
[   50.539332] [   T1548] -------------------------------------------------=
-----
[   50.540471] [   T1548] nvme/1548 is trying to acquire lock:
[   50.541497] [   T1548] ffff888104f45f90 (set->srcu){.+.+}-{0:0}, at: __s=
ynchronize_srcu+0x21/0x240
[   50.542804] [   T1548]=20
                          but task is already holding lock:
[   50.544410] [   T1548] ffff88813b235e38 (&q->elevator_lock){+.+.}-{4:4},=
 at: elevator_change+0x12c/0x510
[   50.545719] [   T1548]=20
                          which lock already depends on the new lock.

[   50.548023] [   T1548]=20
                          the existing dependency chain (in reverse order) =
is:
[   50.549707] [   T1548]=20
                          -> #4 (&q->elevator_lock){+.+.}-{4:4}:
[   50.551288] [   T1548]        __mutex_lock+0x1b2/0x1c30
[   50.552175] [   T1548]        elevator_change+0x12c/0x510
[   50.553072] [   T1548]        elv_iosched_store+0x271/0x2e0
[   50.553968] [   T1548]        queue_attr_store+0x235/0x360
[   50.554843] [   T1548]        kernfs_fop_write_iter+0x3d6/0x5e0
[   50.555732] [   T1548]        vfs_write+0x523/0xf80
[   50.556547] [   T1548]        ksys_write+0xfb/0x200
[   50.557386] [   T1548]        do_syscall_64+0x94/0x400
[   50.558238] [   T1548]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   50.559171] [   T1548]=20
                          -> #3 (&q->q_usage_counter(io)){++++}-{0:0}:
[   50.560670] [   T1548]        blk_alloc_queue+0x5bf/0x710
[   50.561469] [   T1548]        blk_mq_alloc_queue+0x13f/0x250
[   50.562326] [   T1548]        scsi_alloc_sdev+0x843/0xc60
[   50.563160] [   T1548]        scsi_probe_and_add_lun+0x473/0xbc0
[   50.564013] [   T1548]        __scsi_add_device+0x1be/0x1f0
[   50.564828] [   T1548]        ata_scsi_scan_host+0x139/0x3a0
[   50.565632] [   T1548]        async_run_entry_fn+0x93/0x540
[   50.566451] [   T1548]        process_one_work+0x868/0x14b0
[   50.567279] [   T1548]        worker_thread+0x5ee/0xfd0
[   50.568059] [   T1548]        kthread+0x3af/0x770
[   50.568796] [   T1548]        ret_from_fork+0x3e5/0x510
[   50.569562] [   T1548]        ret_from_fork_asm+0x1a/0x30
[   50.570337] [   T1548]=20
                          -> #2 (fs_reclaim){+.+.}-{0:0}:
[   50.571673] [   T1548]        fs_reclaim_acquire+0xd5/0x120
[   50.572407] [   T1548]        kmem_cache_alloc_node_noprof+0x55/0x430
[   50.573254] [   T1548]        __alloc_skb+0x1e9/0x2e0
[   50.573972] [   T1548]        tcp_send_active_reset+0x81/0x750
[   50.574690] [   T1548]        tcp_disconnect+0x1430/0x1c70
[   50.575342] [   T1548]        __tcp_close+0x74b/0xe50
[   50.576061] [   T1548]        tcp_close+0x1f/0xb0
[   50.576727] [   T1548]        inet_release+0x100/0x230
[   50.577355] [   T1548]        __sock_release+0xb0/0x270
[   50.578075] [   T1548]        sock_close+0x14/0x20
[   50.578731] [   T1548]        __fput+0x36e/0xac0
[   50.579311] [   T1548]        delayed_fput+0x6a/0x90
[   50.580001] [   T1548]        process_one_work+0x868/0x14b0
[   50.580704] [   T1548]        worker_thread+0x5ee/0xfd0
[   50.581323] [   T1548]        kthread+0x3af/0x770
[   50.581980] [   T1548]        ret_from_fork+0x3e5/0x510
[   50.582602] [   T1548]        ret_from_fork_asm+0x1a/0x30
[   50.583245] [   T1548]=20
                          -> #1 (sk_lock-AF_INET-NVME){+.+.}-{0:0}:
[   50.584369] [   T1548]        lock_sock_nested+0x32/0xf0
[   50.585061] [   T1548]        tcp_sendmsg+0x1c/0x50
[   50.585697] [   T1548]        sock_sendmsg+0x2ef/0x410
[   50.586281] [   T1548]        nvme_tcp_try_send_cmd_pdu+0x57f/0xbc0 [nvm=
e_tcp]
[   50.587101] [   T1548]        nvme_tcp_try_send+0x1b3/0x9c0 [nvme_tcp]
[   50.587847] [   T1548]        nvme_tcp_queue_rq+0xf77/0x1970 [nvme_tcp]
[   50.588564] [   T1548]        blk_mq_dispatch_rq_list+0x39b/0x21d0
[   50.589271] [   T1548]        __blk_mq_sched_dispatch_requests+0x1dd/0x1=
4f0
[   50.590076] [   T1548]        blk_mq_sched_dispatch_requests+0xa8/0x150
[   50.590823] [   T1548]        blk_mq_run_hw_queue+0x1c9/0x520
[   50.591460] [   T1548]        blk_execute_rq+0x166/0x380
[   50.592118] [   T1548]        __nvme_submit_sync_cmd+0x104/0x320 [nvme_c=
ore]
[   50.592930] [   T1548]        nvmf_connect_io_queue+0x1c6/0x2f0 [nvme_fa=
brics]
[   50.593731] [   T1548]        nvme_tcp_start_queue+0x813/0xbd0 [nvme_tcp=
]
[   50.594449] [   T1548]        nvme_tcp_setup_ctrl.cold+0x6fb/0xcbf [nvme=
_tcp]
[   50.595274] [   T1548]        nvme_tcp_create_ctrl+0x835/0xb90 [nvme_tcp=
]
[   50.596079] [   T1548]        nvmf_dev_write+0x3e3/0x800 [nvme_fabrics]
[   50.596846] [   T1548]        vfs_write+0x1cc/0xf80
[   50.597426] [   T1548]        ksys_write+0xfb/0x200
[   50.598095] [   T1548]        do_syscall_64+0x94/0x400
[   50.598750] [   T1548]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   50.599445] [   T1548]=20
                          -> #0 (set->srcu){.+.+}-{0:0}:
[   50.600512] [   T1548]        __lock_acquire+0x14a7/0x2290
[   50.601213] [   T1548]        lock_sync+0xb8/0x120
[   50.601854] [   T1548]        __synchronize_srcu+0xa0/0x240
[   50.602486] [   T1548]        elevator_switch+0x2c4/0x660
[   50.603193] [   T1548]        elevator_change+0x2de/0x510
[   50.603876] [   T1548]        elevator_set_none+0xa0/0xf0
[   50.604496] [   T1548]        blk_unregister_queue+0x13f/0x2b0
[   50.605258] [   T1548]        __del_gendisk+0x263/0x9e0
[   50.605926] [   T1548]        del_gendisk+0x102/0x190
[   50.606524] [   T1548]        nvme_ns_remove+0x32a/0x900 [nvme_core]
[   50.607296] [   T1548]        nvme_remove_namespaces+0x263/0x3b0 [nvme_c=
ore]
[   50.608129] [   T1548]        nvme_do_delete_ctrl+0xf5/0x160 [nvme_core]
[   50.608916] [   T1548]        nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_c=
ore]
[   50.609721] [   T1548]        nvme_sysfs_delete+0x96/0xc0 [nvme_core]
[   50.610433] [   T1548]        kernfs_fop_write_iter+0x3d6/0x5e0
[   50.611186] [   T1548]        vfs_write+0x523/0xf80
[   50.611839] [   T1548]        ksys_write+0xfb/0x200
[   50.612431] [   T1548]        do_syscall_64+0x94/0x400
[   50.613125] [   T1548]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   50.613891] [   T1548]=20
                          other info that might help us debug this:

[   50.615475] [   T1548] Chain exists of:
                            set->srcu --> &q->q_usage_counter(io) --> &q->e=
levator_lock

[   50.617333] [   T1548]  Possible unsafe locking scenario:

[   50.618497] [   T1548]        CPU0                    CPU1
[   50.619230] [   T1548]        ----                    ----
[   50.619921] [   T1548]   lock(&q->elevator_lock);
[   50.620510] [   T1548]                                lock(&q->q_usage_c=
ounter(io));
[   50.621353] [   T1548]                                lock(&q->elevator_=
lock);
[   50.622196] [   T1548]   sync(set->srcu);
[   50.622763] [   T1548]=20
                           *** DEADLOCK ***

[   50.624172] [   T1548] 5 locks held by nvme/1548:
[   50.624809] [   T1548]  #0: ffff88813163c428 (sb_writers#4){.+.+}-{0:0},=
 at: ksys_write+0xfb/0x200
[   50.625783] [   T1548]  #1: ffff88813a344488 (&of->mutex#2){+.+.}-{4:4},=
 at: kernfs_fop_write_iter+0x257/0x5e0
[   50.626823] [   T1548]  #2: ffff88814fbf9698 (kn->active#138){++++}-{0:0=
}, at: sysfs_remove_file_self+0x61/0xb0
[   50.627887] [   T1548]  #3: ffff888108600190 (&set->update_nr_hwq_lock){=
++++}-{4:4}, at: del_gendisk+0xfa/0x190
[   50.628938] [   T1548]  #4: ffff88813b235e38 (&q->elevator_lock){+.+.}-{=
4:4}, at: elevator_change+0x12c/0x510
[   50.630026] [   T1548]=20
                          stack backtrace:
[   50.631053] [   T1548] CPU: 3 UID: 0 PID: 1548 Comm: nvme Not tainted 6.=
17.0 #367 PREEMPT(voluntary)=20
[   50.631056] [   T1548] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-4.fc42 04/01/2014
[   50.631060] [   T1548] Call Trace:
[   50.631061] [   T1548]  <TASK>
[   50.631063] [   T1548]  dump_stack_lvl+0x6a/0x90
[   50.631067] [   T1548]  print_circular_bug.cold+0x185/0x1d0
[   50.631071] [   T1548]  check_noncircular+0x14a/0x170
[   50.631076] [   T1548]  __lock_acquire+0x14a7/0x2290
[   50.631078] [   T1548]  ? save_trace+0x53/0x360
[   50.631082] [   T1548]  lock_sync+0xb8/0x120
[   50.631083] [   T1548]  ? __synchronize_srcu+0x21/0x240
[   50.631086] [   T1548]  ? __synchronize_srcu+0x21/0x240
[   50.631088] [   T1548]  __synchronize_srcu+0xa0/0x240
[   50.631090] [   T1548]  ? __pfx___synchronize_srcu+0x10/0x10
[   50.631094] [   T1548]  ? kvm_clock_get_cycles+0x14/0x30
[   50.631097] [   T1548]  ? ktime_get_mono_fast_ns+0x82/0x380
[   50.631099] [   T1548]  ? lockdep_hardirqs_on_prepare+0xce/0x1b0
[   50.631102] [   T1548]  elevator_switch+0x2c4/0x660
[   50.631106] [   T1548]  elevator_change+0x2de/0x510
[   50.631109] [   T1548]  elevator_set_none+0xa0/0xf0
[   50.631112] [   T1548]  ? __pfx_elevator_set_none+0x10/0x10
[   50.631114] [   T1548]  ? kernfs_put.part.0+0x12d/0x480
[   50.631117] [   T1548]  ? kobject_put+0x5a/0x4a0
[   50.631120] [   T1548]  blk_unregister_queue+0x13f/0x2b0
[   50.631123] [   T1548]  __del_gendisk+0x263/0x9e0
[   50.631126] [   T1548]  ? down_read+0x13b/0x480
[   50.631129] [   T1548]  ? __pfx___del_gendisk+0x10/0x10
[   50.631130] [   T1548]  ? __pfx_down_read+0x10/0x10
[   50.631133] [   T1548]  ? up_write+0x1c8/0x520
[   50.631136] [   T1548]  del_gendisk+0x102/0x190
[   50.631138] [   T1548]  nvme_ns_remove+0x32a/0x900 [nvme_core]
[   50.631158] [   T1548]  nvme_remove_namespaces+0x263/0x3b0 [nvme_core]
[   50.631178] [   T1548]  ? __pfx_nvme_remove_namespaces+0x10/0x10 [nvme_c=
ore]
[   50.631197] [   T1548]  nvme_do_delete_ctrl+0xf5/0x160 [nvme_core]
[   50.631216] [   T1548]  nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[   50.631235] [   T1548]  nvme_sysfs_delete+0x96/0xc0 [nvme_core]
[   50.631254] [   T1548]  ? __pfx_sysfs_kf_write+0x10/0x10
[   50.631256] [   T1548]  kernfs_fop_write_iter+0x3d6/0x5e0
[   50.631259] [   T1548]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   50.631261] [   T1548]  vfs_write+0x523/0xf80
[   50.631264] [   T1548]  ? __pfx_vfs_write+0x10/0x10
[   50.631266] [   T1548]  ? fput_close_sync+0xda/0x1b0
[   50.631269] [   T1548]  ? do_raw_spin_unlock+0x55/0x230
[   50.631272] [   T1548]  ? lockdep_hardirqs_on+0x88/0x130
[   50.631274] [   T1548]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   50.631276] [   T1548]  ? do_syscall_64+0x180/0x400
[   50.631279] [   T1548]  ksys_write+0xfb/0x200
[   50.631281] [   T1548]  ? __pfx_ksys_write+0x10/0x10
[   50.631283] [   T1548]  ? ksys_read+0xfb/0x200
[   50.631285] [   T1548]  ? __pfx_ksys_read+0x10/0x10
[   50.631288] [   T1548]  do_syscall_64+0x94/0x400
[   50.631290] [   T1548]  ? lockdep_hardirqs_on+0x88/0x130
[   50.631292] [   T1548]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   50.631293] [   T1548]  ? do_syscall_64+0x180/0x400
[   50.631295] [   T1548]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   50.631296] [   T1548]  ? do_syscall_64+0x180/0x400
[   50.631299] [   T1548]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   50.631301] [   T1548] RIP: 0033:0x7fd435ff877e
[   50.631304] [   T1548] Code: 4d 89 d8 e8 d4 bc 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   50.631308] [   T1548] RSP: 002b:00007fffcb25ded0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   50.631313] [   T1548] RAX: ffffffffffffffda RBX: 00007fd4361c28e0 RCX: =
00007fd435ff877e
[   50.631314] [   T1548] RDX: 0000000000000001 RSI: 00007fd4361c28e0 RDI: =
0000000000000003
[   50.631316] [   T1548] RBP: 00007fffcb25dee0 R08: 0000000000000000 R09: =
0000000000000000
[   50.631317] [   T1548] R10: 0000000000000000 R11: 0000000000000202 R12: =
000000003d3687f0
[   50.631318] [   T1548] R13: 000000003d36a510 R14: 000000003d368610 R15: =
0000000000000000
[   50.631322] [   T1548]  </TASK>=

