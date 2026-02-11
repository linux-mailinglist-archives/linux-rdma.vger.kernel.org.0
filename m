Return-Path: <linux-rdma+bounces-16766-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCfyITiujGl/sAAAu9opvQ
	(envelope-from <linux-rdma+bounces-16766-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 17:28:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E21361261A6
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 17:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C585300F9F6
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3555033F39E;
	Wed, 11 Feb 2026 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DGtuI1b7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4042223324;
	Wed, 11 Feb 2026 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827301; cv=fail; b=QwT8NMk6lAjUhSpUBTq9alXo/7o/IR7cpq48xPOg6Wy+SWgmkV2iMoiSKnuewitnNzfmQUxF5qbYYRVZKMJLEtWsbd5DNzbGp2ruCHl9WauYku83eLPBpJYanzopJ6SI1GHIALK6WrYLfNOgT4Sd75RxSntYulBrQXKVzWQfa7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827301; c=relaxed/simple;
	bh=y0y1IblXVUASRBH1AlXr7ycB++czFdUsM5JfzGqIWdc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tOT+aUbmim64MAh5VrKF7gb3sKae4RoMYJnidqjCQVMNG/mMJKRz2LWMCqx4shKXdIYVV518vUzP+ugI3iocR8nKFxbMxmj1x+yvhZ4ls+F0AAEJLV53d/SYU+CFvlU3wG38D7VJMRKW3vr4/845LvsaAouxGNVBThdkmvOLooU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DGtuI1b7; arc=fail smtp.client-ip=40.107.209.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzi1xOAri2qTFswhMql5AZbG0xhXQo1bNjQIFG4tFCkeiaen8TmzTdIFX0oim2owbcKHsdRBEKLOKQ+WHSuWpCl7DYj4+m0BmIbbR7zDBNvKBsTqJiATMZAZDRc2N68w9s0O7UZF1FQLJksKn4nz8EGTNHJ3uYTsYPCmLIKi9bw5NcRSt3TfiY+Kk4v/szVAWR6VLk8mYBHoGsnxzHsUMKQ/CfpHNm3BeSciIPzOS5my8uH8hQ9PgcZH2zpTcWSgt7RczOlpKxoxYuXeP8vB+I2AYU8c1Hvmp8Iqe9zbtjIFnrZAaxVV/GrU2RpNuVGBbYVkwBkuyR17E4tVVFtFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0y1IblXVUASRBH1AlXr7ycB++czFdUsM5JfzGqIWdc=;
 b=JGZ23aywWgjGcIZrM2IJlhW4BhRaCSqtbmA13Oqukhwjatujc/mxE67hv0T/sf6CC6lwFes/akVqrZRfhGzmDbc8cQAXzBOXmxXZUpEz1xENThqKij5ZuLj4iPDvYUZkFs239DOPDgVH8itYtqllzC7A9uld40Lx+F+nYSvCbPyUwRLZXZsbSkWGrMoIcHeBSOoY0141ZTG8vXkPeAskLYB3f5Nb7ySg3hNn8YAxxZg6N4IPzS9oLg25eGpZXdHBFxNbXJQGgZbcdPlizvqzBsjvQme2Mv1o1shEuOJBbU/vgp3dqZufYP8KA9zmDQ7hfUorxdZYQzY4KTqaSajUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0y1IblXVUASRBH1AlXr7ycB++czFdUsM5JfzGqIWdc=;
 b=DGtuI1b7MdH46prdnE/EOKBICBkAAQzXAF+3Ycs2zDgV5WwGrlQ/X9072EvuXRpHvW6GmsWaEL3lHXm8RUquhIJYWCTIfkF6TygJ9juyDn48pKLGBPZhoFLcHHEZqJGAqUYk1nnY9aa9s994gLDcXjhgXF7iLjApQGaEptX71YNf8e3ke9Q2p87RPRnMcd87B93ZB4bv1eQvISdIhwoQDbKZyv10qL9dPaOCcejhaD2JySEOC4G3z1QPvQmZypKkHZcsYxM8nMw1RrPm0pRjB+z5DvHLiZCHbaM+wHkWufYf8VboU/fUV/6KUsYRuHD6fxEaEw6K0DUQHVsFfFT+Rw==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by CH2PR12MB4279.namprd12.prod.outlook.com
 (2603:10b6:610:af::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 16:28:14 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::8e88:51e7:15c9:25fd]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::8e88:51e7:15c9:25fd%6]) with mapi id 15.20.9587.013; Wed, 11 Feb 2026
 16:28:14 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "leon@kernel.org"
	<leon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "pabeni@redhat.com" <pabeni@redhat.com>, Jiri Pirko
	<jiri@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, "horms@kernel.org" <horms@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, "krzk@kernel.org"
	<krzk@kernel.org>
Subject: Re: [PATCH net-next V7 07/14] devlink: Add parent dev to devlink API
Thread-Topic: [PATCH net-next V7 07/14] devlink: Add parent dev to devlink API
Thread-Index: AQHckEk1EtX0RVdGw063saWAUYQpRbVwYrmAgA1jhgA=
Date: Wed, 11 Feb 2026 16:28:14 +0000
Message-ID: <9d3d4e49cec85473619eb5166f01168a6ae3fd85.camel@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
	 <20260128112544.1661250-8-tariqt@nvidia.com>
	 <20260202200035.742f9500@kernel.org>
In-Reply-To: <20260202200035.742f9500@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|CH2PR12MB4279:EE_
x-ms-office365-filtering-correlation-id: 889f26b2-9f2d-47a9-d97d-08de698a8e1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUMrcEdHWjZTZDN2UWxuK2JNSzhnVlVUOC9IL1BxVXp3OURFV3JKS2hxWE9T?=
 =?utf-8?B?RUF3RGRJUDVLTUJuL2t5RCs5eStHdVRrRStyYW1YcEtiR0Rta0xxUHVOY3NE?=
 =?utf-8?B?ZmU4Y1JKb1Y1ejhHRHRMSDV4cUtiMnBkdS9HYWRFRjczNjBUcUxDdWsvc2Ny?=
 =?utf-8?B?d2JYRkI2OHBuMHdrSnAwTFIrbmpVbGs3cDUwWE1TelAveWlQUVNPR1lBOFFm?=
 =?utf-8?B?d05LT1FuSG9DeXFDZHhEVjROcy9pK1ZwWkx2U01NMHBWbmU0a1NmTmV2ZTJ3?=
 =?utf-8?B?WXlwcS9wdWNmZklQTUlHRFR5R0IxVGQ2ejQxN21VMENSRkVxek1vT2Y0SjZS?=
 =?utf-8?B?UHhCMjMrOUZsQXNEN0VmYlNaQVpwL1FWbG9ZN3FERHdSOGR1MkViYVFQOEIw?=
 =?utf-8?B?UTZRZEtUWG41Y3dkM2phbHBVSjlKVzN2ZWpFSXVCOFFBVE9IUDJnOG95eW10?=
 =?utf-8?B?N3drKzNJSXA3MS9aOXJmRGZONDdhZVQ4TE1EUUtybzE4MWNhcWZubTBUSCtX?=
 =?utf-8?B?V1FBbzlqSUo3akk5cnp0RnBtb29DblplZ3Iyc01kUmJLR3g5SEMxTEplTVYz?=
 =?utf-8?B?OStxQTJsLzV4Rm5WWDQ5eU9xL24yTmVCVGFGK3IrNVNnZ1Vtb282NExQcU5m?=
 =?utf-8?B?dVBGWlVnZkliUWpxRzNtaEovU0V3VWFRK0g5bUdMQjRXRWxoNnFxcjVWdEQ3?=
 =?utf-8?B?cmFlcGFCNDBUSSt1czVxVGlVNXpSUVNKT1ZyYXkvaVpzYUIvWlV6SGpCUDZS?=
 =?utf-8?B?M0JXUW5PbnlXblhzdU56NEUvend0d3hRKy9Pd2lsNWNWMndXbDloSFZ3c0NI?=
 =?utf-8?B?dWtZUnM1S1lMWHoxU0lzQW5oMkhBOFRnTzROT2c4bW5xWVR0MTgycUd1V3d0?=
 =?utf-8?B?YjlESXNLSWE0UFVhc2RxUStEYWFVZTBnOExTNTlvbGg1VEdORGNRckxRckdh?=
 =?utf-8?B?K05kVGNMQUxWSHZYOXZaUVBOUGZJTE9pL1BKT1lKZzdrcjNlMDRDNUNFZlNh?=
 =?utf-8?B?KzM1ZUxwd21KMm1RTWw0WjdhK3ZlUWZKUjZsOXhhNk1RQnJYRElBWDl4Z3VE?=
 =?utf-8?B?Nm9BMC9hdXozRHlScXVRbmpVdlhvRGpwTC9TQUJaUHE1eUh4a2cxTGhEOTRJ?=
 =?utf-8?B?bXl3T0tFTU9Sc3UvZkcvalZ4R0JXazNFQmtwU3hiSUt2NU5CTmtnUDI1STNP?=
 =?utf-8?B?bjZGcmFCWkQxbjVtOVJtRkVJbVpVQ2Zjd0xtODhuT2ZzM1pxQjJOUTg3Nis3?=
 =?utf-8?B?MTVtY1NuUEszV1lVTXBSb25MQWpVRHFDa0VNVWxoRTJLY1R4dyszVU84dHJ1?=
 =?utf-8?B?TU1hN1UwSWRNMEZhTmw4TjZjbkxYMTlsOGM5anlZK0FPVXRxQmJMcXhhUVB1?=
 =?utf-8?B?UU16ZE5jaEM1bU1nSkIxWjZ2T2tvTy84SzArVWRpcnB1UkNVWVpkazAxMWVE?=
 =?utf-8?B?SFdJSmlOMm44cU1hTmhKclQ3QUx0Z0lCV21uZVJuRk9UZk1DL2tIRHN6Kzh2?=
 =?utf-8?B?YWQzc3RSNzl0aG1NQ1ZPMG5IbDdueDFBYzFzc2pmeWd4bjJWWGxsRG96dnU3?=
 =?utf-8?B?MzByYWkzM3JHZ0dmREVFUWJTZTk0UTZQY0xwcWt0QlhJaWU0MGF0ZUZzckQx?=
 =?utf-8?B?SjcxYU9pSWZhRmlPak1CTU53d1hKdDdkdWNxa3dLRHhOaHJWckw1OFZVeHZH?=
 =?utf-8?B?aU5HWXo0ajRSTU9hNXMzTnlFTjJ2WFZnUDJXRk5TeGl4NUZjSzR1Z0ZSVXd4?=
 =?utf-8?B?ekNnb2p4T0h3SWdZNGErZklyS1NuelF1RTlDQ3cybkdGbGpGdXRDaDQzSXlz?=
 =?utf-8?B?K01DRlRjbFNsUElXYjJHclh4dHMwNWZCbkx0Y2VtWFpIaEJFQzJrYmlxd2tt?=
 =?utf-8?B?MUEzWDEwQlJDcVFaN1VvLzBzVm9UbW15eXNXUG5KTW1sMmx0UE5sZkc3MjB5?=
 =?utf-8?B?bWxoMnlMZHJGQStUZGJCOTJlcHB1OFRaRDJESUkwb1VQQnFZNFZzaWUvaUx2?=
 =?utf-8?B?bkRIL1dpQk5nOTdtY1RVSlFxN1kvM3V3dTduMHVNb0UrRGticXhZcEt6dC9S?=
 =?utf-8?B?Z2QxZ0hFakFLTCt4dU9lNzlOaWV0c1V1NHRxZGlRaDBBMjVNNGZiTGw1Qlgw?=
 =?utf-8?B?SlY0RFFmWVFldHFaR1VuemRHYzJYcjc0QVR1WXloUFBsb1l4VTZ1b1B4NC9H?=
 =?utf-8?Q?svBHZSW2nuNDVuQoSWLUjmM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0VtWlp0VXRBbnhjVitQbVNJaDBhOTVjV1JKM1ZnVlN0WDRpT0hWdUNLNUc2?=
 =?utf-8?B?a3dQMitnTGR0am5ZeUFsbHdKZytOdktZMFlkVzBSMHFTdUJ4cTh4cGFBMEx2?=
 =?utf-8?B?bTY4Zjl3b0ZCUEN4QzZXdUtXMHNKU2xmSmpYZC8wT0U2N0tMVjVERHMySmFX?=
 =?utf-8?B?dU1MTXNMazhXMW9UZWh4UDcwS0xXK1NQQWxFenlqYWozRzlNeE9iWVgyMU5O?=
 =?utf-8?B?RUtobUJQTFZnWXRwZklDN3FiN0hzVklaaldwRS94Tk9pMEJXUTU2ckZHMUtj?=
 =?utf-8?B?WWFRNWh0T1RaNFFuN0lGTUxJVnBSUnhzQkNsejBsbGI0RnM3eUM5blNQUGdY?=
 =?utf-8?B?dktOdEg5Z3hmdmZTWnZoUk1xaGV6ZXplamp6b0RXU1R1TnJRZEl4YXBWOWpu?=
 =?utf-8?B?bWdETnFHcTFsbUdENGNxNzljT2ZCaXJKaFQxQlRML0wrOWhwU2ZjZGN4ekMw?=
 =?utf-8?B?YlUvMlVxNmk5S3M0ajlEQnJtdlJTZXBCbDJ5NlRsdE0xditmMnVsdlFmd2Rs?=
 =?utf-8?B?T2FoUjVUVDhyTG5PMGFuN2NlTlAxNXJzbHYrLytVZEVpQ2JXNUQ3TnBiQjJw?=
 =?utf-8?B?S3h1K0NJdDNyZ1hjLzBDM3RlNDdVR2VBbkxlS2lFMTlCREpBWndkTHAxRTZG?=
 =?utf-8?B?WEo3YXpYcDZyOU1BSkdmVG5ZWUZ0SWdFUnQ5VWhGVDBHd3BibFhzYkdTU25w?=
 =?utf-8?B?M3kvdFJSbDB4QWhhVHc0VmRKcDNVY2JST05yWWhya1F1SXh6OEtxVjFNSStR?=
 =?utf-8?B?dWd5aVo2SDlwQkhxc3VKVG9MaGZUWG12Q3VmL3RrNnFzOUI1Wm80R1JhV2Jl?=
 =?utf-8?B?dFJOSjAraXlMZ204ZU80OFkvQ0VraENHcHBUOE1YOGJrdmZEVHdVTjUwQ1g4?=
 =?utf-8?B?OHlPRUhLN2ZCT2g0OE12ZG1hNTFWWHF3R0NqVzJrWUswVEtUUFdBM3ZMNyty?=
 =?utf-8?B?TEdjOWs2NDUraDdVdXdSaFVaMXFqK29VWEg0b2JENHhGN082T2ozZEdYK0tz?=
 =?utf-8?B?Q3lZVnlhd2UxS3BJOFI3SjA5clFIcGpvM0djRDhDMi9wT1ZpNm14NVNmS0hz?=
 =?utf-8?B?YWpGOXZXUHJ6RUhBTVk2Z2pWa0xxQnU5aTdSMmIwYndBSXl2dkRBT0JrbDh2?=
 =?utf-8?B?TWQ3TUhxTmx4UTJJaVp6SVBlZ1BzeVdkYlNzL1VjTW9maWlzQStDcFBDNmp6?=
 =?utf-8?B?RGZCc2tsS05jSHEwN29ESE9Sd1RBenk0MlJQcUI1MjdpeVhnOGlwZVNlMVRO?=
 =?utf-8?B?NVQrL29HZ24vVmd0QTVMNDlISGlZZ0xuMzJFUklrK2Nzb3lJMXU4eTlReGts?=
 =?utf-8?B?UWJDeHVYajhiWTVMYnBvRWhvMjlLWExza2EwQUFqOS9IN2ZIVG5KaUluaU1v?=
 =?utf-8?B?am43WmhzTklHU294WFdJK09sMFFhSDN6YkxhRlUvMXZMeXhQS0YyRnhoZE1W?=
 =?utf-8?B?YXdWcEJZMXlHVktNSG1KNFRyV3Fsc3NzTkFTTjVBekk2ZHM1QUhNMnpHeFFS?=
 =?utf-8?B?VlhyclFCY3F5RE12S0poWWtJV1hEVHdIWlR0Nk8zRWhiVC91cktQelNjVTJp?=
 =?utf-8?B?STUxU3MyRk1telhJMWRsVHJBZVZ1RkU4a2NpUVNvN1E1UGZ6U3h5aW0rYUkz?=
 =?utf-8?B?UDdBZ1JOSVI2WFZOanJrd3JCWFd5SFVGV1ZQRVk3WjljV3JYcUhUVmpzOTN0?=
 =?utf-8?B?SFRwb1FtQjYwMFA2V21HVXJxN21aOTNBTUJ6SzJhUHIwMm5KbzY2TzBLeVBn?=
 =?utf-8?B?eWlmTmt3czduQVVGVUQ5OUZXV2xTSEc5aUJoYWpGNlZJZTRGSmpNUzdwM2Rw?=
 =?utf-8?B?RXZEdUFaOEowQWFSRm1DdTJYbGtDRjQzc3I4b2RIbjVMOUFrYnVhd05sdGtE?=
 =?utf-8?B?ajc2SmFaRVd0bnUvQmI4ZG5rNWFyV25ON2J6b2oweFNDc1hPaCtRR1RFNWxC?=
 =?utf-8?B?emRwMmh4c1RhWXN3OWV5YjlPdzRpQVNWSHlYdUg1RDJBbER4M3AzUU5JdWVT?=
 =?utf-8?B?bWlRU2pKbVNZNWJVM09FNUFvS21wV3RTd1RTTm9TakNwc0trRWkzcVFzUzRB?=
 =?utf-8?B?dGw4ZHkyQ2FkdHRqakROc1V1dHl3NFlhK1pIV21ibFg3RXJZTmFqSG5teGdv?=
 =?utf-8?B?SUdOQWxycG15NEpJNktmZnBOY3RvTmcreXdVQ3FJWmN3NDJrQW1xdGMrdE5x?=
 =?utf-8?B?VmxpUGtNcVNiNlpOK2VSbHloa2VDQ0M1Mk1rQW9xbFpKOTU0Uk5nSFhOaUE3?=
 =?utf-8?B?U3kzMmRmUU9pUzNNTEVLUkdOS1VFUnNBUE1pNklSWVhXL2ZnTzJGM01naW9Q?=
 =?utf-8?B?dEE4bHlQTGo3SGQ2YzRtVGVUMzRTaHk1MmZYaENENU5CQjNXMUFJZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C7082663EA17D459120DB7A63A88786@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 889f26b2-9f2d-47a9-d97d-08de698a8e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 16:28:14.3328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /EO0+ng1N3Y/iWxjDFSOtGAnL1e19cMP0mBD9qm1DcotS1/zKI0iiTIWoL8nK9XrcUeo0xLxWqCGtbVS8CsjSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16766-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[lwn.net,lunn.ch,gmail.com,davemloft.net,kernel.org,vger.kernel.org,google.com,resnulli.us,redhat.com,nvidia.com,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: E21361261A6
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAyLTAyIGF0IDIwOjAwIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gPiArCQlpbmZvLT51c2VyX3B0clsxXSA9IHBhcmVudF9kZXZsaW5rOw0KPiANCj4gTGV0J3Mg
Y29udmVydCBkZXZsaW5rIHRvIHVzZSBwcm9wZXIgb3ZlcmxheSBzdHJ1Y3Qgb3ZlciBpbmZvLT5j
YiA/DQo+IFRoZSB1c2VyX3B0ciBhcnJheSBvbmx5IGhhcyB0d28gZW50cmllcyBzbyBkZXZsaW5r
IHN0dWZmcyBhbGwgdGhlDQo+IGV4dHJhIHBvaW50ZXJzIGludG8gdGhlIHNlY29uZCBzbG90LiBC
dXQgdGhlIGNiIGlzIG11Y2ggbGFyZ2VyIC0gNDhCDQo+IHNvIHdlIGNhbiBlYXNpbHkgZ2l2ZSBl
YWNoIG9mIHRoZXNlIHZhbHVlcyBhIGRlZGljYXRlZCBwb2ludGVyLg0KDQpJIGFzc3VtZSB5b3Ug
YXJlIHJlZmVycmluZyB0byBpbmZvLT5jdHgsIGFkZGVkIGJ5IFBhb2xvIGFzIHBhcnQgb2YgdGhl
DQpuZXRzaGFwZXIgc2VyaWVzLiBJZiB0aGF0J3MgdGhlIGNhc2UsIHN1cmUsIEknbGwgY29udmVy
dCBkZXZsaW5rIHRvDQp0aGF0IGFzIHBhcnQgb2YgdGhlIG5leHQgdmVyc2lvbiBvZiB0aGlzIHNl
cmllcy4NCg0KPiANCj4gPiArCQkvKiBEcm9wIHRoZSBwYXJlbnQgZGV2bGluayBsb2NrIGJ1dCBk
b24ndCByZWxlYXNlDQo+ID4gdGhlIHJlZmVyZW5jZS4NCj4gPiArCQkgKiBUaGlzIHdpbGwga2Vl
cCBpdCBhbGl2ZSB1bnRpbCB0aGUgZW5kIG9mIHRoZQ0KPiA+IHJlcXVlc3QuDQo+ID4gKwkJICov
DQo+IA0KPiBUbyBiZSBjbGVhciAtLSBkZXZsaW5rIGluc3RhbmNlcyBkbyBub3QgYmVoYXZlIGxp
a2UgbmV0ZGV2IGluc3RhbmNlcy4NCj4gbmV0ZGV2IGluc3RhbmNlcyBwcmV2ZW50IHVucmVnaXN0
cmF0aW9uIG9mIHRoZSBuZXRkZXYuDQo+IGRldmxpbmsgcmVmcyBhcmUgbm9ybWFsIHJlZnMsIHRo
ZXkganVzdCBrZWVwIHRoZSBtZW1vcnkgYXJvdW5kLg0KPiBJZiBtZW1vcnkgc2VydmVzIG1lLi4N
Cg0KSWYgbm8gcmVmZXJlbmNlIGlzIGhlbGQsIGEgY29uY3VycmVudCB1c2VyIG9wIGNvdWxkIHJl
bGVhc2UgdGhlIHBhcmVudA0KZGV2bGluayBpbnN0YW5jZSBhbHRvZ2V0aGVyLCBhbmQgZnJlZSBp
dHMgbWVtb3J5LCB0aGF0J3MgdGhlIHJlYXNvbiBmb3INCmtlZXBpbmcgYSByZWYgYWxpdmUgZm9y
IHRoZSBkdXJhdGlvbiBvZiB0aGlzIHJlcXVlc3QuDQoNCkNvc21pbi4NCg==

