Return-Path: <linux-rdma+bounces-16602-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICodEb7HhGk45QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16602-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 17:39:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEC5F554C
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 17:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B63D305364B
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 16:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D53D43900B;
	Thu,  5 Feb 2026 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="L1XOmk1W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021085.outbound.protection.outlook.com [52.101.70.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA52C0F91;
	Thu,  5 Feb 2026 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309351; cv=fail; b=Gzi2vyZsuA0GM+yFN5cdjQMX2GrS0wJ/NOlgeSwLW3onvsseLnIY4aGjXBautT+c7oGdW0Fcno7wOM0eNc7ig2VCw9FuChpLLbzfD3aEQ7XKR9QrIklH+UzkTfqulm0jOdcW4sBl+zLkLMunQHKx0oDcXvj1nk31OMN+Rl5+AtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309351; c=relaxed/simple;
	bh=/2esXDXVzC+z7GEam8af+LyZWWXNNd9tEh2AjR3vjXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iVwnXddBSDmhQATBbcaAf5+Uy8xRG3F6OmnxKHhmL9twevba+bNpO0QTjduI8arqCygLfY73IK7OJwK04mZYaabHOXDmiXs0uz6JZo9HFGdJJNvm/reNs8oy9PXshTrQlVMVhmxMWe/OMsGhzHOe3KA8wRxwuvNe5XNd5xvl2v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=L1XOmk1W; arc=fail smtp.client-ip=52.101.70.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Muilo0GdVvfmFP/gSgfg7k0fCET3eSN58ZMgUESjPtiM6263LlnJmommnzfDh3bt8rcs/pM9tvwHwpusx/pKtUJz+aoaZoRHhAKPaTAk57WnuAFytyte5XGc8ST4CUgUd12mOOfBzuF8B2saEfhWEyxgMb0HxHuY1QP3HE5/fPHgA6EDy0nJgatYsrGCFbx/uQjlt5Dv5hoaCZIKmhbvJL2B2fwJtXKboUTPTD4Lklkk5PBaDm1DLd+0bQLVq/yknSmFfK+MWmzGKWZmWzlH8sIR5ul8vsJ/WUIOsMkOy5bO++ycXLeuHaep34I32wadldaJEqRFa1a+GDDvBBRHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2esXDXVzC+z7GEam8af+LyZWWXNNd9tEh2AjR3vjXk=;
 b=W2CBrQDZ5MXQVTkZ00ns/cEytJCMvf9X6wqkmPVfsAZMLWBDt+IrLP62iDmz2LQIFLASnS8AzN2OpIb8dU2WbNkDaSGZC4nvrp8S0JViErcxFPqE+93VaBRiulsTAoBQgkAx/rQMJU3yrwn3fVjU/P2scB9Z4GANWzweckHdlcCfQfMcWYdlNHlvhQRSe4A/2Q4E1pAD9/3Qw79C8yx4wuz6c2aUo4KFlgo2z9lkXhVBa3lXTtdcaMF5xgvZoEOzuHDyXahBa379Ovzw+5qpf3zjTxYux6kYl5tfS4rKzsyJJBMTQFY/G1bw8yvQEWBLpd+6edHeT8CjZyryHxlIvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2esXDXVzC+z7GEam8af+LyZWWXNNd9tEh2AjR3vjXk=;
 b=L1XOmk1WsYTBGx3hRI71ICaKL2pvDKPNfCxX3StTuxeLMIEHF1Behp+hucr4i6jv54EElefXYLkOZnKtH0r446NvO6ZAp17RFoLAetz3ivtj0nhdefq2Govi/PvyspQ3DWENiupcJ5IRXD2DYs1kZ+wVc5pazoq6Bo2VUHTYxVk=
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com (2603:10a6:10:5cb::5)
 by PA2PR83MB0666.EURPRD83.prod.outlook.com (2603:10a6:102:418::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.10; Thu, 5 Feb
 2026 16:35:44 +0000
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e]) by DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e%5]) with mapi id 15.20.9611.001; Thu, 5 Feb 2026
 16:35:44 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: Shiraz Saleem <shirazsaleem@microsoft.com>, Long Li
	<longli@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana_ib: return PD number to the
 user
Thread-Topic: [PATCH rdma-next v2 1/1] RDMA/mana_ib: return PD number to the
 user
Thread-Index: AQHclr15q2Widu2d/E2FyhONtHUXbg==
Date: Thu, 5 Feb 2026 16:35:44 +0000
Message-ID:
 <DU8PR83MB0975317E888CD5A6A58E2E26B499A@DU8PR83MB0975.EURPRD83.prod.outlook.com>
References: <20260205121354.925515-1-kotaranov@linux.microsoft.com>
 <20260205142212.GL2328995@ziepe.ca>
In-Reply-To: <20260205142212.GL2328995@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ec0a1a60-11f6-4a63-be31-97dccbc8e6d1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-05T16:15:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU8PR83MB0975:EE_|PA2PR83MB0666:EE_
x-ms-office365-filtering-correlation-id: 73252ba5-9f43-48a3-373e-08de64d49bef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1JiV0ZucDdYRkVnb1BpcWZ1Skd1cXIvN0dzazk5NjNpMzBHZ3hnbVd1bXB0?=
 =?utf-8?B?dWdLQVovRTZkMHJ5a2kxQWJLb2ZEcElKelBvUVRpTllWN0ZRbnozT2lnSXpi?=
 =?utf-8?B?UXVKbXoxL2lQK1NDR1dMV25RVmNLdFA2ZXMxS3hCZE91VlJhZGtrNVdBV3c3?=
 =?utf-8?B?ckw1U1UydWptWTN4VU8xN3V0dE5aWGJ0MytlSHliTmU4cE85WUdJS25EcVRi?=
 =?utf-8?B?ZVh6ZFJlMDhsUWs1VWViN1RQWEtjT2ljKzR6OXExVDNjeXpwVkpCcTV2ODh2?=
 =?utf-8?B?dUdlRTZrSlF3UUVUdTZRRjE5d2NFN1lYS0dYMFRack5iUjVlSzRsTHRpellZ?=
 =?utf-8?B?VUhLZ2QzTVJvNi80anI0dFU2RVJseEQvOUpiS1FaY1Zxb1dKbWUwSWhWc3Rj?=
 =?utf-8?B?WWllRkMwb2dRNDl0M0s5TUZKYWVlUU1tN2dEczByQit5SHFQblVZUEdKRjIx?=
 =?utf-8?B?ckY1czFNODM0UWMwNHcvY252amZ0K05XMUxuU0xNdG9LSmpyL1VSM0lwZFB4?=
 =?utf-8?B?RmtweTVpU0NqRHZJSGxyWHpRM284cXBMcm03cEIyalRQQi9Ra2ZwK1ZiWWFD?=
 =?utf-8?B?S1k3WTlxZkJ1aFA0MFZJTEtIenBFSlNXOERDc0lodkltY0cwN1ZvWFE2WHgv?=
 =?utf-8?B?elZPOVhhNThVbWRwVWN3WW5SaTQzRDZSa0xySm1WcTluQmhRRURiNy83R0dR?=
 =?utf-8?B?WHpLd2k2ZURsRDI4UU5aWFBpN2tKenhpRktOeFFlVWpWMDhHdjRYbHdSZEVG?=
 =?utf-8?B?U29qV3BuUXVDZm9wWGptekZBUERYWk02SHhCNjQ1Y3VMUDRla0R1VXkxbXIy?=
 =?utf-8?B?S3dRYkVySm1oN1N1aEVILzFUaXV1U1BNWFhPQUdqdWtoK1NYUHN5MmozN2xW?=
 =?utf-8?B?dVFsdW1XbkVXRHlUTUs4czlJaGJFYVVpc0RqaExxSXlCSnQ2RzB5dzUxWEh4?=
 =?utf-8?B?MFY2ZEdveXpNbHc4cGdCWGtuaWJiZzBNbURUZGNqdDF5bEtQY2ZtaVJ4eVAy?=
 =?utf-8?B?NHVjWU1iZ1k3OXRNT2xxcDZmR2tiU2R0ZjFUYVd3M05WY2xCUms3U3k2OFd4?=
 =?utf-8?B?aDZaODAzODd3VGZucDQ5ZU9MTlVaZGtkYUpLU2M1aFJueE9JbTBMOHdJS0dw?=
 =?utf-8?B?elp4YWxFR2ErMU9lb2ZneXlPVG96cEU2T0dsU1hzbEExRE1iR2o3S1ZzdFho?=
 =?utf-8?B?b3VlaDZPYnJkRThVMWNWWEk1dk5NOG9oTlpKWHhINm5EQ3pkaFJGMk85bFdX?=
 =?utf-8?B?VTJaYVZUb200Yk5pQUtaQkgyRFcvbTNXUFZoem5heVdkcjBNUDk1SDVpZFF1?=
 =?utf-8?B?ZWZFTkxTYUF1NW0yc1M1Q1BYbEZJYUQyQWhhckZkZ3BtZGRUTGU3Y2dNaE1o?=
 =?utf-8?B?Y2o3NVdyM1RJVXBrdTUwZTFqZzcwUDVuWnlXbXVJN29IdFdJUTZaS2MrVmtW?=
 =?utf-8?B?cTlsSlZUUjhNSFR3Uzk3VXROL1d3cmdyYTFiZmpxSTYyU29YZDR0dUF1dTRm?=
 =?utf-8?B?YTB5ZnB6Q2IxcE9aTXVlV3VUa0hKVFdCVE5DSFJMN0dpdEdlbjFuOG91dzZj?=
 =?utf-8?B?MjNVOWFlUEhEYXhVcWJDTmxyYnBGV3lwaDV4TlBOcVZzQVUvUi9teWh3RFdT?=
 =?utf-8?B?V3E4dmRaMjhPU3lRRXBaLzh4RzNFSmFGc3BzUjVYUExzZjhrQXIvYVhXT29p?=
 =?utf-8?B?QXRITk1JSGw5NjJyeTBaSlgzSkhDNGFaYnpodVMzU0UyWFUvZjJ5Y3FnbWxP?=
 =?utf-8?B?SVpUOVZFSUxQRDdkdHZDQTQ2VkJ5ZHprSFVDZW5kRzlkcW82RW9vTy9yOHZj?=
 =?utf-8?B?UGl0VTdSeUlBZ2haMmR2bFZ3MU9GRmdjc0FUY0RkcHh0bmlQajFoWlZrMUZP?=
 =?utf-8?B?SkxkWC9QbXBYeUU1QWRscWxMREdmRDdYQUtHMkVKaXZ5WGo1Lzdlbm83Wlo0?=
 =?utf-8?B?TENKcTRPSkowbi9hVEdJcmZHUGNwWTZkQU56OU1pbFFua05kWGFaUFpjU2Fx?=
 =?utf-8?B?ZXFvcnFybnJ3b2IzSXB2S1lYSjJOVURLTHpzZVo4Ui8xVjJPbzhnRUhnTFJN?=
 =?utf-8?B?OW5MM3R2enVla1lMbUNTenpqUTd2NVNhUEtvQk1henJjbDRKNmZyemJndXhl?=
 =?utf-8?B?QzBBbzRiT1Y3b3E4Q2d5WThyT3hOUU9vNzZaTVBTaEc2Tnc0ZXVBbnMxeWZB?=
 =?utf-8?Q?r0e6wsVYCwKkF2vIQR0gWno=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU8PR83MB0975.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0l4OVFsbWUyVVNqNlVPR2hqUGZDdTF3UzJ5RHRoQXlqeXB6WTJiNDkvdE03?=
 =?utf-8?B?VGJyZnZZZVgvaElzVFlVOWc1NzdVdTV0ZE9rNnNab1J3YXlsR1ZrTHJTQ2JK?=
 =?utf-8?B?a2I4QXJ5NndCRkwwOW9aQkNSeUgxOVd3dXZ5VlQ3cHVwTnBZUGs0OXZFNkpu?=
 =?utf-8?B?UjBvWjArWm93NWNiRWZ0M0kwRkl4SHp1aUt1YzZpdE5FejBkZkpGMXkwOEFJ?=
 =?utf-8?B?NlQ0R1VYZ01MTVRJajd2dk15UDJHVFBHVmt0WWViYVptUGlnRWM4cDU1R1ox?=
 =?utf-8?B?NEFZL1ZjNktEeTdDN095WW8zNXJFYUdoZ2U3K0lwOExaRW9za2NuZEk4TnN0?=
 =?utf-8?B?TnBYV0NUUVZ2TlU2Y0d0ZlRyemFYeFpWSUxkaEZqcGxneXBvWE40d2dXcmVq?=
 =?utf-8?B?b1hMaXMrYVNBOUwwQ2pLc2FZU01hODVlNkZrajlGZjR2NEJqWFBzelFXeS9j?=
 =?utf-8?B?aEdlM0RTclNtT1k2Uml3c3dHc3RqZ2FQcUFWaU5CNE5mTS9ybkFMekF1bnNX?=
 =?utf-8?B?Y0hlWWo0Sm14b0paUmRaenMzN25HaHQ3WG5BbnU1dXJNTS8rVTVtMmRwN1gv?=
 =?utf-8?B?VHBLa29hRm8zVlZzZ1pZK2ROS2VBUWdIbVhLdUF0Ti9Jdy9CbWdDVVQva3J4?=
 =?utf-8?B?WUIrV3YxNmtORXQ3U0QyUHFaVXF5aTN5OHUxbmtvbWpIR2JwL2tRd0VVeVJV?=
 =?utf-8?B?M21WNXducFM0dFZGNHVLMXBBbDdFYkR0SlhDY1lXRXF4a3FCN3A2QjM2SENv?=
 =?utf-8?B?RXdFcGtFeG5PeFlYOEtodFlGTG9rUmcwNWl1TDNEdjhGY0RkallmbUpaVnk5?=
 =?utf-8?B?U2lDVnZnTGZhZTBlOHVQdnY0RHBKMkx1UjByMFNWZFdrdStLaVJHZjIwU1A2?=
 =?utf-8?B?bjZhZU45U09oRUdCcUFPZk52NTg4WTUvSXg4b29zU0FybVorcUV0b08vUmI2?=
 =?utf-8?B?K0ZuLzNCV1F5T0RBZ0wzRmhtSlJsdHArNDljY0FMQmt5R3h2Y0hrU044V1Rs?=
 =?utf-8?B?OXhnWFA3M1A0LzhXc3pIbnZOeDZ4VFlYS2pLQ2h2WlVvTkZlM2pLejJDYWZK?=
 =?utf-8?B?ZG1HTmhEQ0R6NWdCRTVlZ1VhODlqMm5Pa0xTeFRRY05wTVVaU3pDNEwyTXQ4?=
 =?utf-8?B?UXM1TUN3U3FaVG5iekIrWS9kVGF5ZTJGOFA2SmtWU0poYXpkckhmMWpTN01t?=
 =?utf-8?B?a2swN0pKbm8xR25xZ09KSWZDZW52ellSV21udWZTUUh6VzRGbGJiWno2KzVQ?=
 =?utf-8?B?VWo3Tjl6c1h0TW8vZSsyc1JmYXNNdk56Tlp3b1BLK1RVNUlDT2tQRHNSTXlX?=
 =?utf-8?B?MzBRd3RqN2FFY0Uydkx4N01Ud1J3cHVjd1lUcnI4UXo2d0lQNXVzVmtxWjg0?=
 =?utf-8?B?a1grc3RzWFVPdHZvMDJtMGx5dmM5RnY1cENyelUvdVZIajJHNDBYdWM2YTBS?=
 =?utf-8?B?YWZnNUhrQXJhWnVsN0t0RXJpRmw2dFBzTkI4RTZtWFhram53Q2VkRVdEWTdR?=
 =?utf-8?B?WXFCQnIzbE9JakNwajFGd1M3ZUxYK3NnVXBlaVlsVS9KRnZxQU82dUE0MUdP?=
 =?utf-8?B?ZTlzVlEyQU5uLzNsMHNidHB6S0p4Z2hXQ2JObDIwZjVnSFhGSnhlL09wa3Ry?=
 =?utf-8?B?UG40bGRnVUwyc1VlaFJwZWhjQ3ZpbUNhb3cwQlFoZHdtTC9xQTU5aWJBaVBn?=
 =?utf-8?B?cmFSbTc3NXYzWWhOTkN6U2pUOHpVYStvdHExa21YRGFCc29HRnYzL0E1dEJl?=
 =?utf-8?B?U2lOQlV2ZFE3cExhZHZEa2s0N0dDektKNlhRQ09UY29vcjc1bFA2dTRPK0M5?=
 =?utf-8?B?T2ZIL2p5VFdkWTBpa21iQ0NJNEN0V3hob3QveWRwRkJmbDQ3eGhaVkJhWWZW?=
 =?utf-8?B?UWc0M28zaU9SaU10aDNxaE9PK0pjdXNvdVZ4ZEtFNWlYbUthNGYrWk0yMEhv?=
 =?utf-8?B?SzhSWVA3R2gzZnBHZGVBUk43MGVKK3ZaMk9WZktHcDd6TU8zZkx1c2NEQ0pX?=
 =?utf-8?B?OEE1VjhNMVFYNHl3SzlxUUFJNlpwMkFtbDVjMExXa1JjR3U1R0NtTmMvMTlV?=
 =?utf-8?B?aHh4YjJJcUtvWnNZaWU2cHNwMUhLMGhlbVlkUEh6V1IzUmgyTVRBWHNQR3I0?=
 =?utf-8?B?eEtpQTdidkU1SnVla2sxenVIdDQ2eVhvUnR6alJlTVZEOStNajlEOEF2RFVY?=
 =?utf-8?B?bktTS0tnWXFoQUs0VDlZdDRIeUhIMnZUQ1JldFZZUVJZWEVqaFE1VGdPekdh?=
 =?utf-8?B?MTFlS0pqL2lTT3VTL1lCeG1aMlpRPT0=?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU8PR83MB0975.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73252ba5-9f43-48a3-373e-08de64d49bef
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 16:35:44.5113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRGf8Uh+8Cc0sQzrL/hip9LAICyjMzV8IqD0NZ2S5OGFcs6lDwJgLPmhba3yqUVWiqa+Qar083dqydLqgUhHFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR83MB0666
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16602-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@microsoft.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACEC5F554C
X-Rspamd-Action: no action

DQo+IE9uIFRodSwgRmViIDA1LCAyMDI2IGF0IDA0OjEzOjU0QU0gLTA4MDAsIEtvbnN0YW50aW4g
VGFyYW5vdiB3cm90ZToNCj4gPiBGcm9tOiBLb25zdGFudGluIFRhcmFub3YgPGtvdGFyYW5vdkBt
aWNyb3NvZnQuY29tPg0KPiA+DQo+ID4gSW1wbGVtZW50IHJldHVybmluZyB0byB1c2Vyc3BhY2Ug
YXBwbGljYXRpb25zIFBETnMgb2YgY3JlYXRlZCBQRHMuDQo+ID4gVGhlIFBETiBpcyB1c2VkIGJ5
IGFwcGxpY2F0aW9ucyB0aGF0IGJ1aWxkIHdvcmsgcmVxdWVzdHMgb3V0c2lkZSBvZg0KPiA+IHRo
ZSByZG1hLWNvcmUgY29kZSBiYXNlLiBUaGUgUEROIGlzIHVzZWQgdG8gYnVpbGQgd29yayByZXF1
ZXN0cyB0aGF0DQo+ID4gcmVxdWlyZSBhZGRpdGlvbmFsIFBEIGlzb2xhdGlvbiBjaGVja3MuIFRo
ZSByZXF1ZXN0cyBjYW4gZml0IG9ubHkgMTYgYml0DQo+IFBETnMuDQo+ID4gQWxsb3cgdXNlcnMg
dG8gcmVxdWVzdCBzaG9ydCBQRE5zIHdoaWNoIGFyZSAxNiBiaXRzLg0KPiANCj4gV2hhdD8NCj4g
DQo+IFBETiBpcyBwcm90ZWN0ZWQgaW5mb3JtYXRpb24gaXQgc2hvdWxkIG5ldmVyIGJlIGdpdmVu
IHRvIHRoZSBIVyBkaXJlY3RseQ0KPiBmcm9tIHVzZXJzcGFjZS4NCj4gDQo+IEhvdyBjYW4gdGhp
cyBwb3NzaWJseSBiZSBzZWN1cmU/DQoNCkFzIGZhciBhcyBJIGtub3csIGl0IGlzIHNlY3VyZSBh
cyBjbGFzc2ljYWwgUEQgY2hlY2sgZm9yIFdRIGV4aXN0cyBhbmQgaXQgaXMganVzdCBzb21lDQph
ZGRpdGlvbmFsIHJlcXVpcmVtZW50IHRvIG1lbnRpb24gUEROIGluIGEgcmVxdWVzdC4gSSBhbSBu
b3QgdGhlIG9uZQ0Kd2hvIGNyZWF0ZWQgdGhpcyByZXF1aXJlbWVudCB0byBtZW50aW9uIFBETiBp
biB0aGUgcmVxdWVzdCwgYnV0IEkgZ290IGFuIGFzayB0bw0KZXhwb3NlIHRoYXQgc2luY2Ugc29t
ZSB2ZW5kb3JzIGRvIHRoYXQsIGFuZCB0aGVyZSB3ZXJlIG5vIHNlY3VyaXR5IGNvbmNlcm5zIA0K
KHNlZSBzdHJ1Y3QgbWx4NWR2X3BkIGZyb20gbWx4NWR2X2luaXRfb2JqKCkpLiBJdCBzZWVtcyBp
cyBub3QgYSBjb25jZXJuIHdoZW4NCnRoZSBQRE4gaXMgc2V0IGZyb20gdXNlci1zcGFjZSBpbnRv
IHRoZSBhZGRyZXNzIHZlY3RvciAoc2VlIGZpbGxfdWRfYXYoKSBmcm9tIGhucywNCm1seDRfY3Jl
YXRlX2FoKCkuIGFuZCBtdGhjYV9hbGxvY19hdigpKS4gQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCwg
dGhlIHVzZS1jYXNlDQphaW1lZCBoZXJlIGlzIHNpbWlsYXIgdG8gYWRkcmVzcyB2ZWN0b3JzLg0K
DQotIEtvbnN0YW50aW4NCg0KPiANCj4gSmFzb24NCg==

