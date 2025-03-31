Return-Path: <linux-rdma+bounces-9044-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19BFA76D9D
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 21:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381863A86A8
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 19:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDDB215047;
	Mon, 31 Mar 2025 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XbtLqEqF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0806173;
	Mon, 31 Mar 2025 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743450559; cv=fail; b=qiSlWaV23SGnpAblPzV3KPvHIbpEcdAjTWhORX7MTp7Iz6X595J7YWCGt1ldTy21D9ruc1ozitRPWQiSmgbwoHyiUEcHkIdfAdEPCIgV8EKww0btPaIuU4WOku9yz70Km4n+5ZKDj7YlvlC9alIXA0YOnB1Z+WZb1UFYp/2n4ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743450559; c=relaxed/simple;
	bh=5UuG92J2R81uVllmpP5uAoJYKbellZCh3HKQGwuXulc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eCw0/z8EecVUwn/Jx+3Kozvo7bVXpNcOU3/i/9XCqjNgL6CiW0MvcnQlD+b7phvkMrQB5iisdHxjU44nsZwRDW1EXaao0sQeYCvXyRJUNNuzj3IjZLXpA6YIi40o4EAZf5QcdLjops4eQBlTaEuzDrT6u/vIosV2tFipkpduhNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XbtLqEqF; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjB75mTgtoAOYXrlR5wCaXM32+b9MUUV4lCliDnD/vOhBYbvFakItNzKalSwgPL2Sgoe1J1uJTwCxTh1uaiMBHBIPH+leHdoVdiXZ7qnewmPAQQ8C6bBnDDLzCtnA118X/2DLN5X+KWqYQMAKTxHWIhVqO+gBv0P6wdcQXx1f9zsHTg/1FxsGW7V3hzalD03hE7AbB3MsGvDU4wLVLyq7DBMt9U5Zo92XdGLYOE/mJ8sRIIbQTRNBIE+iTI5B0Wrig4KzK7Tms9VAcGy7SZtfX3rK9noXKdUFZQif57Hwfo1NGXi1zY89ffbFI2jsNlEnJ67w994b8p/yJOFZcRCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UuG92J2R81uVllmpP5uAoJYKbellZCh3HKQGwuXulc=;
 b=e3uuViu+3Ne149y08o7ZXePCymq5Qu8EId9Uh0cZgL0VaambHP+YkdI8TDDyfkd6px+7c8pJPTImKge6aYbZXCkHR6KCd9JE6TuVs+Mf9MjB7b53FKo5/zNw8qVu6OCB9a6dbx5AlpjNASk7wBSUuQc66V271oN/ACh+Cxc56XYueqdws5hWUCQISs2Pg5RXNarxHSeZClQTsLfcGI69jYHiBiZDE+PB8pSCircs/Fj218GsbaoBh4ftvmPTzgeC65xvRxiwYGknoOkbiw71iu4wQbHgKI5slSiSbingXj/acPp3mNFLSA0MZVuoTmbF4OO+WKcAS/a4Gp6jlow4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UuG92J2R81uVllmpP5uAoJYKbellZCh3HKQGwuXulc=;
 b=XbtLqEqFlS4V2AIncASrPqffojegHm/qxfYQhAfBuFgR0RQ7RMayAgFz4DTzjgQlGS9huc5PicWAya8jlTTR/he5zeVmcusTjFXQoNJb2h/F56lao6r3/YRH6vV146XKDRVT0W1tSTmd+PxU9lN7Tj8tzevW7ELzoqBtBBBBvcu+VTmsZFQ2TYX81hi7IFUZJIONwZ5IgnAmpv0nV2IYM06a0FPBZVZ9eWl7IUZNVNDLh2OdxNbAPdyI5sGtWobk9vBqxTMCUzuJTPwo1bw3DQ4MJD9eO7/xXuIAz5OjM1ZTXzFMIh0MxSXpJ/3o2Oasy9Y4MF5aQPoPF9TD3EBPeg==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 19:49:12 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%3]) with mapi id 15.20.8534.045; Mon, 31 Mar 2025
 19:49:12 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Jason Gunthorpe <jgg@nvidia.com>
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
 AQHbjuwVUw9AWIkXnUa8bbJSM0sPK7N6v4MAgAgXf4CAAAnsgIABEwYAgAAgrcCAAYj9gIAAAVBQgAARqYCAAABpoIABaOyAgAF/vICABS/6MA==
Date: Mon, 31 Mar 2025 19:49:12 +0000
Message-ID:
 <DM6PR12MB43137DCF20A1428F7E67F82BBDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
 <DM6PR12MB4313D576318921D47B3C61B5BDA42@DM6PR12MB4313.namprd12.prod.outlook.com>
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+Qi+XxYizfhr06P@nvidia.com>
 <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+VSFRFG1gIbGsLQ@nvidia.com>
 <a7f22729-d76d-4e90-8457-6844f18929eb@huawei.com>
In-Reply-To: <a7f22729-d76d-4e90-8457-6844f18929eb@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|SJ0PR12MB6856:EE_
x-ms-office365-filtering-correlation-id: da5d1df2-e404-4e56-04fd-08dd708d1c23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aHlVWG0veHpudmsxNE83d2M3RXZOd05oQlVxYmxLTGFKSTczQ21rTmpsZWdJ?=
 =?utf-8?B?NU8xUmdaM2VpaXIzZmxjdkRJaFZUd09aYXZEMnZmNlFBNU9mMjNSZldiVXJO?=
 =?utf-8?B?aTBobURZWlhvbEZkQ0JRRUpQekhCNjRxanhVSzd3ZVRrNnlDRklKRENXeUxm?=
 =?utf-8?B?SndlUmE4SFcrU3FSQnY2Q2FqUXk2Yzl0S1ZYZ0NLbzhCckc1ZWZLSXA1Z2c3?=
 =?utf-8?B?K2luWTVQVy94NURLTDhBY0VaNjBPK3gyMnRkdTU5c2NyWlhBK2dOdnVocmg4?=
 =?utf-8?B?alZYTE5aZWY5cnBKNmVQK0tJN0pXV2IzUEdZUEtnQTV4VjhUQnI3aEFGVE40?=
 =?utf-8?B?cEFyRkVzNkFBdUtkZUZZVTRBYi9UbHQyc3dqL2FFekk2SmhCTm42VUNmY1g2?=
 =?utf-8?B?dnJMVnY1dEgwZDZtek1VSnNWUWljWkJXNmZmQ0NjMGJKVWxYMHY2V0FURGZF?=
 =?utf-8?B?M2g3QzU3LzVJRUV1b3hPV0p4K1ZaM1Q5V1RvUVJrYlR3STJOQmQzQUZURmhD?=
 =?utf-8?B?REdKTnFFVThpMUVUNGpvcWtXc0ZQNU9UcWxGK0hIZmVxamV0eXdRRHB5SElT?=
 =?utf-8?B?WGMzZk1lMkJOOE1oOG1mZFhuV0lPTHBURXIveVNyVVJiTzJiaFpaOHExOVdN?=
 =?utf-8?B?eXpoeGRHTnBmT2NoWm04cDlVM0Y5N3V4RCtiQ1hJakR1OTZ1SU5QZXJpVkhN?=
 =?utf-8?B?cElTbVQ4T1ZWTHFNQTV4QU80ZEtrSGZiZ01pZzFnUExKcEpZQzF0RndNZXlr?=
 =?utf-8?B?WnJQSWRuMXhiTmFHcVB6ZTI2RG1weDU2UEJ0QVRZUW1NSmNtRWtBcGNCVVNL?=
 =?utf-8?B?OE9zUURiNzZQejhNVzFScURXVGtCaTdvTUNQVGhKcFlMVzZVMEdUUzJINEdI?=
 =?utf-8?B?NkhWVm5DRVRNalQ3Zktnd2pkcmhzb1ExSGxRNlVLTVUwMkcvWmpQb1JCSW0y?=
 =?utf-8?B?ZU9QWjZEVGsxQ0ZkTHQ0c2p0SmFxSkZvN09PUDBKc0tYbnhSYUE0L1JzUGRa?=
 =?utf-8?B?Y09LVE5LRU4rVThPQTFxYkl0YTB0dHp3QURReHVkVXhTSjVHWG5meXk4Tkwx?=
 =?utf-8?B?bHhHcmpac2QvYTFsQStiLzRKMFkwdzZpS2ZYcDRxdzN2cXQwOStSS3V3MEhu?=
 =?utf-8?B?YUQ1NEdySkg2M25XWURYWHdJYm9zVndXRXoyWUdYZzVuRnJ0bFNyRThlUEEy?=
 =?utf-8?B?Wm5UYkZZV1pXc0lidi9YR1ZMTncrbis1VUdmTHhjQW1tNllBcElkSkpXVks2?=
 =?utf-8?B?QXJkME91b240dU9WMktVTy9FZEVvMWxXSi9uelBnYUVOSTcvdGZQNDFRcU40?=
 =?utf-8?B?ZThwUCtHSjVYdVd4LzNkS3U5LzNrbGhCeVhtdmRUcjQxcnZTS0NHbVBObTNR?=
 =?utf-8?B?dDFxSVZZRVMvSTU0YzdlNVliOXQ5eUl1d2FZUElnRittcVluMDJ5aHFjVEJi?=
 =?utf-8?B?bjkyd0lwanhHYkhkWkhua0NtMkZSSE5WLzhuZmtjdm1CdkFWdWVwcEZxREFM?=
 =?utf-8?B?b01mSHM4SUlnUWsyWkFVU2tOM2huRjdIWEh3Mi9oUFpKUlQ4VWRMdWdRK01R?=
 =?utf-8?B?cUIzK0VKamRST0NXMnhHcHo4aDdqRHA2NTlVa2UzN28zZEFveEF3SFFzYmpr?=
 =?utf-8?B?S0pwUDZlQmxkbEg4dVVKUXZGTUJMVFNacnFMS2tEc3lpOUt1bjk4Qk54NVBK?=
 =?utf-8?B?Qk03MG1adWk1Y2hYQnpxdVpiWm85cW5SUGdJTm1sNXJuckd1dllIOVp1bFFT?=
 =?utf-8?B?MExjUDNtL3RjRHdRRTg4WDllU0wvRjU5ZzJUMXpBcW00K042UVRqaDJ5U2h1?=
 =?utf-8?B?ZWx6UkVMdVlZMzNXZVJTQi90UFJudEF4WFRKY1k1TFhLMkFXOUk5MGFlNXYw?=
 =?utf-8?B?aThxZW5IWDc4UDk4UTdVV3oyd2xMR0VMbXVxV056Y0NQUVhaclFJalE1UjA3?=
 =?utf-8?Q?cTm1yMMMqmSc4pW/43JFwcJE17ib0UhW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2tvSzQ5VllWaDlJUUFzbm9uSUlGQUV0RUNkOW9oU1EvVzRGSGdOandWUW1P?=
 =?utf-8?B?bnpsYzk0cFpwdVhzOGFTamc2MVdpTFJRNHYzRnlJS2M5emw4QlpzN2VsVHVL?=
 =?utf-8?B?QlUrVUhnQUZjMVNYUmkxL3NZNDIwMitOT2lmc09SVHJIZWZ0RXdEd3gzUWtM?=
 =?utf-8?B?TmRWRk5aTUYvWjc2VFVQTktDYWN1YXFGYUpqdlU4Z2ROVnZ5OVVNSlhtVnR2?=
 =?utf-8?B?SGs5cDJCMzYzNWErNkZuUmFHMk5qbzl4N1M0SzBEbGh2RlVpbXVPbTQ3RW9x?=
 =?utf-8?B?SGRDMHY5M1N0a0k3TzloSExNUTVieE1sSmdKYWFWOG9wQVBvRjdxcFdYbTY3?=
 =?utf-8?B?YWJXZFRZZFg3V3hwMXpCMVd4MDlqVlIzekE5aDk3bm5LZ21BcWM5VGU0dHJy?=
 =?utf-8?B?bXBxTUVIK0IwWHVhUW41OTdjY2x1SnA5WTZJUkttTnprSW51U0lOM2pBU01V?=
 =?utf-8?B?OE4xOGVML1JkNUdjWHhQcDRPcERCVTBHSnRGeDgwU1N1T0hKNXl5QjlRMC9O?=
 =?utf-8?B?bHhHMkRyU3UyanUrTG5qNnRGZjJjaFV3bC9KTXVvaW16ZjdyakR1b3JCVXdt?=
 =?utf-8?B?OGNaUEtaUkRVY3hYT252bGh5Q2Nid2FHS1dYOVZpOHhGRzlBNUh5b3RicXcy?=
 =?utf-8?B?eDRrMSt1MWcxZEE0VDRBN0FkNlNFQmNmRUJ2d1BJbm9mY2I0Tlh0VDNCY2l6?=
 =?utf-8?B?M1MrQnN2K3A4Yyt6QmJaeGpvS1ZNY1RSYStaVHBUYnZvcTRFeEYzRnM1VXQz?=
 =?utf-8?B?TEY2bGhMVXlkc0JhcGc0SjhPZ1o1MUZkZHNrdzRuLzhEazN3Y283OE14QlNH?=
 =?utf-8?B?dUl0dWM5OVVsRktaRGNCaWFPNitrUUg2R0d2UnFtd2pQVlNJcFBSMkZyajFz?=
 =?utf-8?B?MXRxd0o4RmMxcDhQU0gxdzhEN2hVYW8rd1U3VmhIWCtLWFYzcngySWFGN2N2?=
 =?utf-8?B?U3E2M1JOTENUSytqUWlEdHlZdmdNM05HM3FBN2RNVks5N2JJaG9nYzZUb3dy?=
 =?utf-8?B?M3l3MWFiU2o4YTAwQzZGVnp1czRFNG85OWVpN0N0UDQ1V3RQQ3VWbU9lcDRY?=
 =?utf-8?B?MUlEVjJEY3RNUExEaG5ScGVJcmhJZzNOWGJrZy9LVlFXUWJKWk5zbE5OeDh1?=
 =?utf-8?B?aXFHdTFNbFNCRzVaTVRuL0xDQVgxcTc1c00ybmRNalZPc0NhLzdMRkFNRkxU?=
 =?utf-8?B?RWZDemN5Q0NTNDZpMU90RmxIUkNWRUFMMVg3elZBbFBaUUVMTTFOZEhaNUVP?=
 =?utf-8?B?ejZyZVlPTXZWVjFuK1RqWFA5WUJERzkzTnBka0crYm9TaE9xNUNscWg4YzIx?=
 =?utf-8?B?ZXNxc0RlNHFlczNKajVuQzRlOUZUdVc1MUlhZ2pqSk1Tc1JENmJYQlgzNlMx?=
 =?utf-8?B?VlJLaHNXbUhPNmN0c1RyRFQ1djF2R2xGaldsWFVmTS9GaVZzTklFYmhBVVBu?=
 =?utf-8?B?eitnVTc0dmZMamFna2ZyZTJERTcvZElwdTV4WW5jL3RrWU0xSUFJa2NNS0k0?=
 =?utf-8?B?dnFFSGhmSEN3UU43ejNrNXF5YnlRdlFWdnFKTG5BWGZKdUluTDFnemRyczVT?=
 =?utf-8?B?TVlYYTVOSldGRkRrWFZZa3BaektVQ2pxQ3dDWjdaWFdQcUNGRUhjRGhQRjYw?=
 =?utf-8?B?T0NYT2xveG9ZMGRzaG5UWmo3M0NNckMrY2w4RFNNWkFwTTB4S1JYeUZhS2h6?=
 =?utf-8?B?V2t0eVlGOUt2dkgvNmJjRHZoejRqN3FPNlhaMHA4aDliSGpZUWZiTWUxWVdx?=
 =?utf-8?B?QzYvZVZjZmlWSzE4U09jL0JtNDBjV0NPV2h4b2E0bmdFcExyZEQ5QjlrZDFz?=
 =?utf-8?B?RzlReDVyU3NrUGV2SFVGTmZobU5kVXFxTktnOHQ0QzloUVZWOGlUblNrNWQ5?=
 =?utf-8?B?a0txaEFJKzVwQnZPMHVHOFpuc1dpTzE5TmhWOVBDeXlUWkdJY0VBU0hodXVI?=
 =?utf-8?B?WHlkWjFkVHJuUFZpcC9sakUwcUE1SmpPaGxnMkkwRS9UVjRxcHdOcEhmV3h6?=
 =?utf-8?B?ZnNzdTQ2N25qaUdldGN3aTVvTnJUWU0yVzJobUVyRzQrUGVjZXNLSkVpZFdJ?=
 =?utf-8?B?Kyt5MTljZzRoQ0V4d0dyaFNIUUxCWEJDZ3hQdldlSEg4Tkt4SUVQT2pwcGxl?=
 =?utf-8?Q?JDEI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4313.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5d1df2-e404-4e56-04fd-08dd708d1c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 19:49:12.0831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d6dLicM1+vxbaUIF24WtHeO2rV96fIRndexfavRszi6oLSdn/ED24YAtxG8V/e3Wfm8AFTnhK71fJjdmoEl6wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856

PiBUaHJvdWdoIHJlYWRpbmcgdGhpcyBwYXRjaHNldCwgaXQgc2VlbXMgdGhlIHNlbWFudGljcyBv
ZiAnam9iJyBmb3IgVUVDIGlzIGFib3V0DQo+IGhvdyB0byBpZGVudGlmeSBhIFBEQyhQYWNrZXQg
RGVsaXZlcnkgQ29udGV4dCkgaW5zdGFuY2UsIHdoaWNoIGlzIHNwZWNpZmllZCBieQ0KPiBzcmMg
ZmVwX2FkZHJlc3MvcGRjX2lkIGFuZCBkc3QgZmVwX2FkZHJlc3MvcGRjX2lkIGFzIHRoZXJlIHNl
ZW1zIHRvIGJlIG1vcmUNCj4gdGhhbiBvbmUgUERDIGluc3RhbmNlIGJldHdlZW4gdHdvIG5vZGVz
LCBzbyB0aGUgJ2pvYicgaXMgcmVhbGx5IGFib3V0DQo+IGdyb3VwaW5nIHByb2Nlc3NlcyBmcm9t
IHRoZSBzYW1lICdqb2InIHRvIHVzZSB0aGUgc2FtZSBQREMgaW5zdGFuY2UgYW5kDQo+IHByZXZl
bnRpbmcgcHJvY2Vzc2VzIGZyb20gZGlmZmVyZW50ICdqb2InIGZyb20gdXNpbmcgdGhlIHNhbWUg
UERDIGluc3RhbmNlPw0KDQpVRUMgdGFyZ2V0cyBIUEMgYW5kIEFJIHdvcmtsb2Fkcywgc28gdGhl
IGNvbmNlcHQgb2YgYSBqb2IgaW4gdGhpcyBkaXNjdXNzaW9uIHJlcHJlc2VudHMgYSBwYXJhbGxl
bCBhcHBsaWNhdGlvbi4gIEkuZS4gYSBncm91cCBvZiBwcm9jZXNzZXMgYWNyb3NzIG11bHRpcGxl
IG5vZGVzIGNvbW11bmljYXRpbmcuDQoNCi0gU2Vhbg0K

