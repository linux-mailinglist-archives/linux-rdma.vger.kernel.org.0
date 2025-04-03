Return-Path: <linux-rdma+bounces-9130-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39797A799B5
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 03:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3ED23ADC2E
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 01:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5C83596D;
	Thu,  3 Apr 2025 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r+HZ2W5F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7587603F;
	Thu,  3 Apr 2025 01:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743643849; cv=fail; b=PKZ/6RKt14XkQabYDVaqye/yajTycS1jH9QJ4Dxuu2eVh17+bN9v2tYocSJ2gHJm1I1BxqnWBvn3PLk00FNUVqrxMOrVcAmY1Nog35LmYFxvfNNU3HbWOXZv/ZdDAda4MWES+wMhjUPbeaDCW16Wlzkw4J1n+UdSDKtnWX8gKsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743643849; c=relaxed/simple;
	bh=9c9t3HM3Ydwzy5CyDE/hWYD8N1d1/gVBrtCNWjkeb/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H+fUlcsFO1GLssHqmhA0QL/ALdpbC2XW+Vvkt0HWhr5qm00KHstqV0TwWJHTdogXG92RGt8dlBDSSiFGC/vDqjlTMf1A31dRgy8AOlMuNCmYZMPgwC9dQKjOusjsbuMvqEx+XzEpOXgzcvjedR2Nq5lbxWYu4/R5dx4/5M7gTFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r+HZ2W5F; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/eBofeLlj5+KxqVlsE+IqhSsU1hjgMRzbja+HAazH/WJ0LYOi7lyOYXNtjySlpdmU0k+/P2Wnxpoe5DSNgj3EpVdq/qVu0F3moKD7dAaSbvbC4FRY9hZIxXNjjWpSsefO3xwI3It0cLwvR+n2a3rsaZSlzdzOEoxfN1PSM3z2KOXUsXMiWu1uv1+h/1P5A4f1MwfQ8m0BiPLA4croJTYfzh/WMIt0N452ljQ/mLRjUgH7jWX3XXBpz6iKRJAekYZULN5OiWle0Wcvz8yn9ldNna01ZNESLcNHRKQXrC91jp+RvOfJUx4Xzyze3ujgecGv8tGJ/6amjVbYhgL9tStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55dj4Q+iCKdeaTaofD79EpqXBwwnffUdHiy+b9jpwss=;
 b=O2161hi68X/ms5f2ztDq2YlDK/LA6oNSbH41DBVnoB0BFn7bfBkiMv6EnUPa1czVLAp6cIOvPFsWMnE5q+8556fjHTRsqbHsg9FDSqEeRXQSsKuUzCr5+LFMzGW2RH6b8GwKSBeB58hhUXLtYmwYCnj5wsnFasRb+vag2ZgJJVM6rBcxtCd/RcHCFTgar464TYl2Cfl25M2jeMQbr7UTXxr3pwZhL37WfTKDOJrCClRNsOxPDs4fUts1WTKWmfaPXfqp/I3e17acMEQTa/r5NbGOObHFFctKo/kf1zOc+A5Ye2yIn5qLGpXFOW46+1nBasxARNpHYK3oruOw6MJeHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55dj4Q+iCKdeaTaofD79EpqXBwwnffUdHiy+b9jpwss=;
 b=r+HZ2W5FJn21eVVz1LQOavPcmfaN5TK5hGXdW+6/ibqX+0ATgsDLNWMJLGaGPGbhFq5j/tWT00WC2h7ElLO+9BsIo5QnvFzMnoSIrqUO/cl2JOUeYfPQg5kj7c98F5gOctvpiM6JYq8gbJiE1Z5PPjPqfa2avhPqsL1VFPYs+OukPVgfMWbKZx8JZcxgfxRimyW7IgevswDrrVv5/02F1jcD2iSg/hHmjbo+0ui3sX8Ib7RPugTH32Iiea3ikXRMeujLr5kn0XYIf1Ct+184UQEF8VZUpqURvpWSG/0t4qXuGmyUql9hzw2KJ4iYJBXVMtDs2x2YFihvGNNsYb8cmg==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Thu, 3 Apr
 2025 01:30:41 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%3]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 01:30:40 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Bernard Metzler <BMT@zurich.ibm.com>, Roland Dreier
	<roland@enfabrica.net>, Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "shrijeet@enfabrica.net"
	<shrijeet@enfabrica.net>, "alex.badea@keysight.com"
	<alex.badea@keysight.com>, "eric.davis@broadcom.com"
	<eric.davis@broadcom.com>, "rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "winston.liu@keysight.com"
	<winston.liu@keysight.com>, "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>, Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>, Dave Miller
	<davem@redhat.com>, "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
	"andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index:
 AQHbjuwVUw9AWIkXnUa8bbJSM0sPK7N6v4MAgAgXf4CAAAnsgIABEwYAgAAgrcCAAYj9gIAAAVBQgAARqYCAAABpoIABaOyAgAaJkiCAAUvLgIAAK6TwgABCwQCAAAaTYA==
Date: Thu, 3 Apr 2025 01:30:40 +0000
Message-ID:
 <DM6PR12MB43131BED0E6CD4B490903133BDAE2@DM6PR12MB4313.namprd12.prod.outlook.com>
References:
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+Qi+XxYizfhr06P@nvidia.com>
 <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+VSFRFG1gIbGsLQ@nvidia.com>
 <DM6PR12MB431332A6407547B225849F88BDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401130413.GB291154@nvidia.com>
 <DM6PR12MB43130D3131B760AF2A0C569ABDAC2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401193920.GD325917@nvidia.com>
In-Reply-To: <20250401193920.GD325917@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|PH7PR12MB5653:EE_
x-ms-office365-filtering-correlation-id: a5bdaada-6606-4c30-87e0-08dd724f2520
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Rf7e+jdkzmdL6klyNb8a098pGTIoph63Ri8NSw0IYRaSakmCDe+eO0znDSzM?=
 =?us-ascii?Q?bzU44MdjkTQRuwDhOoxs8Ua46QMj638dAdnuijvRuYsw86UjJrQcuejYeSEM?=
 =?us-ascii?Q?iFd4kLBgxJ4SMaM7ZAoYK8biqHzmvKhce2q8Jt0yK4TQH6MauNTEO1cmt542?=
 =?us-ascii?Q?WyguNOjdcE1UxqVYuexjdXqGd959+jSo7AcFljP84Y7NY5BS8FcjK4bgfQxM?=
 =?us-ascii?Q?HtcKooMDJOh11dwi8S04SlfOOtAIGyAcA5KWww4xwPIwqcdUUhY+ARa1QsjF?=
 =?us-ascii?Q?KWt6Tf2qTPfy+YHVRQILL07Y2bd2Q2AySUybJKZkGdQYhOgM/t/cF5ufv6Lw?=
 =?us-ascii?Q?k5/EqzFff/vPlPsEbwCLVYp1Lu44oRcgKuSHeiz8ueOpWcZzQr2uixjIr4AC?=
 =?us-ascii?Q?LxD4xuImNv7HwnMLki8XXG6oD6lG+EwrYGFBgZm66bqMV1Q4xtRU0OQzAbEN?=
 =?us-ascii?Q?AHZrRDE+e51GzlaBPsQcMnjeVvUH882rt4nL6aIe1kFErF3ipMFLC0e/srQQ?=
 =?us-ascii?Q?sWwTJHlmNvsTfB8AXbvwEv3FszC9zAjwzGkrMN9/RWLFpd/AinfOHhS+xGmh?=
 =?us-ascii?Q?mT0V0upK5LE9m/omz+z3OzqAIIeCv81qOspSl1aS7gOhBy0j8J3vPZ2Hl4Is?=
 =?us-ascii?Q?lPd+aVU/j3i4YtkOQHWnBjHRpux0v4xeMmoAAxB57DdrMKSDTYuQstHz8yR3?=
 =?us-ascii?Q?7PjZASXlB5nDERCf/Ro5C36vgWe1pOQzfzx7qpjBc+meccSb+z0Eg0CVSvDm?=
 =?us-ascii?Q?hqhkMOmtXadBg1+c8hjQyWr5mGS514H4/nQ+725fFECWLnErpTazv8cbwgOR?=
 =?us-ascii?Q?N+EOHfP3mGPbapP0JcPQFyeYiVDah1N16rgVyB5h2z5kJeGdak458/SDFSmS?=
 =?us-ascii?Q?GMcXakKO+jwzPd98jhSeQX+SlrqcLO7+dr+I6i1d4JyYyblbqcRijzpUZBzW?=
 =?us-ascii?Q?HeUwxBOAj0xhh8L2jgv6nxItvnVu1Or5ASUzdQIBhg19uXPWW66aQb4rl3fU?=
 =?us-ascii?Q?Tj0k3REqc9vIQaHAhwTwu1X0VNp+toZYyWCpsqln5wHax1wy1a3K6laR4cXG?=
 =?us-ascii?Q?IFW8trxCB3yO96w6DkRDoREahas5eDtC05J6HwfSuyPtlh+YSg1xEPUelAFl?=
 =?us-ascii?Q?uYw7pypT37ojK2U1CTI8ooCsv5pe5PbHMM6nlnQ5w/RLaHzxkidQ6IdUP9Kj?=
 =?us-ascii?Q?vVfi3R6KKRu9umFlNeE3/ZU5vlDdwpdDbudKIpLzCM1s8xpsYQnC675G+y4m?=
 =?us-ascii?Q?6FnvqV9NaAeKCndLGXUWrRjAAa6013l/8qAdi/xeQ1cBvieYZHEu5UMZvMWp?=
 =?us-ascii?Q?TT5rvwxNLgrdKNKFmkEwRK6QxSqOpIoKyHZRFfPgbAHH+enTxocqvyP6fmZ0?=
 =?us-ascii?Q?JZ9varqVKuiHB9t5+pc5e/4El0hFWrETp4jcFoQsvhzxf7nQbVFg5CmEL4d5?=
 =?us-ascii?Q?SluS+VZb6QrEy+rdWdvnyKUQY7ltqpve?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qonQzEs341rofNQtyT7yv8p4zGTU1pUdA9qi5MFh8mV/Y1044YOp5QrOzU6t?=
 =?us-ascii?Q?l+u8su03XEMBSqXxlnQydjblMJTDOL8qLUi1zWpqQKmAfWGPF6mbbrzJCLk0?=
 =?us-ascii?Q?BB67gG52UmQTX5gItumRBSpuuCRoUFMGjLA7fSG4AVl/7Z84wZEnYun41UTr?=
 =?us-ascii?Q?ewLHjDEbdV90oJwKeIKQKMEbmsH1Mu+jP9eDnyyDcNvfIFk1BEGsfE6/vnSu?=
 =?us-ascii?Q?8IhgxSqiSgpyS/yUkjM/A4CyTCsIMmfc9nV6vbaQs4SF01ybp4ADkOWdENLu?=
 =?us-ascii?Q?AHB3NZQ955zaZjV+t22rfoAmgQ8KnbXUf6TaIVnwQA9IEQKJ67vGi00W4nDZ?=
 =?us-ascii?Q?ZsCp8DNNGXSU4ZRmHNnUE0Eo0bZuCUgt12gh/WuPrb1YF+boQ19vdGxm3PPl?=
 =?us-ascii?Q?qZ0vf2sPGHZaU21hKJG46zKOXF5fgWioEcn4yCWj53Vuw8pYiT3FgH9OF5qH?=
 =?us-ascii?Q?wkuF11rowgbhx59E12kd3cn4kor0dJExAxgtTgpZn9EX6aMstSNcJp5qRonE?=
 =?us-ascii?Q?A2xX7rBdRmDfiyK5DP9bEsu0XN00thKgJUxtYNz1hVNFajf+THKSW24r/rER?=
 =?us-ascii?Q?oIxdX/lVyuctorhs79Y03gzpZhgTzT94rM3FDgt+Xvmg2RCG9y9VxEz25XWX?=
 =?us-ascii?Q?5Wk6WPR3FPoMqym0DzJVwhu1ZxyFZzSUh8uZ3nHrhKyA2JOdOleX46uz0vQH?=
 =?us-ascii?Q?Zj1m6Nh+kf92LED0bmGYcRoSVfECNVvY7hwDRLvQwSXkqoUq6Vfr3FTTsxWK?=
 =?us-ascii?Q?VpcB6aIlyAu3guGt7pDK4olsZFTQDglb5Hm0SV2YmUE1Q7FrFD2+AS8XLLxS?=
 =?us-ascii?Q?8ZDcMIFVf+7MXB33RCtwM/EJl8dKiFRZN8lFA7UVl02vb7MTIrdlOcVyJwfg?=
 =?us-ascii?Q?OKprrUFZm/CmUjVNCn6Xcw/edmOZiL81GShEkgkDSRCtf8RshQmfAIJJbYGK?=
 =?us-ascii?Q?7e33uA7UyRmFxUZgqhC2VR7MFpKcRQI+xgvTErKZxcbE4iRrJFODGEWi8SC5?=
 =?us-ascii?Q?timaYZMBEuMav4BLeAg5T3nr546dbioz4rjmhaQcsdXtbwnYbqWWpU/Z7PR5?=
 =?us-ascii?Q?fs4Q6lPYxSAvBHbL7dOVS5aD5bvA7ES5mGhEpf3bpw2ll1ajq1VwdY0x0e7C?=
 =?us-ascii?Q?Y14/0auWL1AYEe1cgcw6ktdRXKCIoKFeq+73vs6qtK8nSTTgH2yiZUJVs0Ob?=
 =?us-ascii?Q?XRUeprnIN6UKwnhL1HoHBNcDvxWKfxstXumgMqyFztra6QLgbXFErWWEawT/?=
 =?us-ascii?Q?gbWZXEOpXDJu1lYeeEihJZBWWbZQmsD9Q9ho5Z9eFgw0k6iWTU1UamFBX8rV?=
 =?us-ascii?Q?UlwpXggkiqawG0KbB4MJLNVkA+eznKg2jsYhOTI96Ji0xhTT4H+ZuBsYaoaI?=
 =?us-ascii?Q?UTiIFx5y2AGN0uVoja/u1Rhy6skrkbsV4RJYl99bAdyma7ocaQyrqqu5ZrdZ?=
 =?us-ascii?Q?cOuaLcA/7TFttljFHohEXksYjQRwG875WKmcBLtd+RWU69GBlrPYoIJ3QuX5?=
 =?us-ascii?Q?n7B/bPUGYK4fy917R9FxAb/CjdqQFT/60dutAayRkdYDowQ8/5NKIxeHrGrJ?=
 =?us-ascii?Q?SS40ioP1+U2lM3jqmV0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4313.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bdaada-6606-4c30-87e0-08dd724f2520
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 01:30:40.7067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BxlJlsDZmG7Yw+CIVXFa8jh5R1pws19vI2zDqx6ZZ/Ym/Z4hS3w2AdI3M2v2xYgml+9yoe62c+cF1Be/V6jN9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653

> On Tue, Apr 01, 2025 at 04:57:52PM +0000, Sean Hefty wrote:
> > > > Specifically, I want to *allow* separating the different functions
> > > > that a single PD provides into separate PDs.  The functions being
> > > > page mapping (registration), local (lkey) access, and remote (rkey)=
 access.
> > >
> > > That seems like quite a stretch for the PD.. Especially from a verbs
> > > perspective we do expect single PD and that is the entire security co=
ntext.
> >
> > From the viewpoint of a transport, the target QPN and incoming rkey
> > must align on some backing security object (let's call that the PD).
> > As a model, I view this as there needs to exist some {QPN, rkey, PD
> > ID} tuple with appropriate memory access permissions.
>=20
> Yes, but I'd say the IBTA modeling has the network headers select a PD an=
d
> then the PD limits what objects that packet can reach.

My claim is PD selection is made using the QPN and rkey.

For the model, QPN -> PD and rkey -> PD are deterministic, and both must se=
lect the same PD.  The SW model reflects this.  I think UEC can fit this mo=
del.

> I still think that is a good starting point, and if there is more fine gr=
ained
> limitations then I'd say each object has an additional ACL list about wha=
t
> subset of the network headers (already within the PD) that it can accept.

I'm unclear on the contents of the ACL, but I'm also unsure it's needed.

> > The change here is to expand that tuple to include a job id: {QPN, rkey=
, job
> ID, PD ID}.
>=20
> IB does QPN -> PD, if you do Job -> PD I think that would make sense. If =
the
> QP is providing additional restriction that would be a job for ACLs..

I believe job id -> PD works.  To enable job-secure MRs, I believe rkey -> =
job ID is needed and not properly captured by an ACL or QP setting.  Rkey -=
> job ID is optional, but deterministic.

To keep the model simple, all QPs under the same PD would belong to the sam=
e set of jobs.  If this makes sense to you, I can discuss in the UEC to see=
 if all the above work.

To summarize, the SW object model looks like:

create_pd(&pd)
create_qp(pd, &qp)
create_job(pd, &job)
reg_mr(pd, [job], access, &mr)
share_mr(mr, [job], access, &new_mr) -- get a new rkey

I include share_mr() for completeness, but I don't think it needs to be an =
explicit part of a common uABI.

A gap in this model relative to libfabric is supporting NICs which associat=
e MRs directly with QPs.  Similar to share_mr(), I believe it can be handle=
d directly by the NIC vendor and should not impact a common uABI.

> > I don't know that I can talk about the UEC spec,
>=20
> Right, it is too early to talk about UEC and Linux until people can freel=
y talk
> about what it actually needs.
>=20
> > I can envision a job manager creating, sharing, and possibly
> > controlling the PD-related resources.
>=20
> Really? Beyond Job, what would make sense? Addressing Handles?
>
> I wondering if addressing handles are really part of the job..

My thoughts were allocating and configuring the QPs.  Given the above model=
, this could include the job setup.  (I can also envision a process not hav=
ing the ability to create or modify QPs or jobs).

Addressing is probably a separate discussion, which I'm happy to defer defi=
ning for later.  IMO, it makes sense to share addressing among processes to=
 reduce the memory footprint.  This is best handled by the job manager popu=
lating some address table.  UEC has also publicly mentioned 'group keying' =
for security, which suggests attributes applied to a collection of addresse=
s related by job.  So, I think there will be uABI concerns here.

- Sean=20

