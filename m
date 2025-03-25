Return-Path: <linux-rdma+bounces-8947-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF93A7079A
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 18:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75CC169748
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A12825F983;
	Tue, 25 Mar 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qJaCXJ4S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBA11A23B0;
	Tue, 25 Mar 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922163; cv=fail; b=LTUn1nQ16YKzzulqOYiIzYnwIWNsgK7coZipmX/dPuEb+x6vXtmi+b50WbYQca+8PVoLOTlZ6NZn8Jjsnxv1gXM1SfoVZM7PbnPcPrRpxYn1SLJXYDPFhhlBAEZE5oMTTCdq9DIHKxFNBxtWpHn4Qk1YhfDp91BSjhzvC7A+Wmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922163; c=relaxed/simple;
	bh=2DAZNnlYqDebDfhokREktkXfVfCdyeSH4b12DMXLUD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JlRWAYylkgFw1/DmFD6cgCTJC7FiAs6OfDq4yjWgllEEqQIfZJy2iuFsqOfia5nEX7Tx7zJ9bklNpAMHetuJbIyBxwEzEsE7mE+kK7U+ztP4te+5yO7JdT2ups3SEAGMwPY7WMKhZ2pHjTkGPTcqwnqxlVdHkoXL0JFk0YW7VCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qJaCXJ4S; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9DhcHCHrNP0MgHDLyp4ZGH39PrvcrjdlCL0j6xmjZs+MNe8ssjGA+/vf4HGo9T4DejeX35areICvJOVpSHT6JYgEYxC9tJCI220CyNvuAwTU3bCWfL5MJPQsYzk/OSZ1gb8GDZeuiYfFihUYu47x+ec/R+dunngqPD+Ey5k3qibGOnVp/Lp4PE/8M+l73J78elA0n2bsB+x0tTCkwGut5HrwXTnCbi14VhdaXrxS7WBKrrBvqOyNhDGDEVw/wLvLjcfoiwWuqHDrjp4KcN8hpNww+f/ZxCiivTKz+XoRASzM0EQfO3H9EYpn6mdL2vhzo6B8SY21aItu/wko9j/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DAZNnlYqDebDfhokREktkXfVfCdyeSH4b12DMXLUD8=;
 b=nm451zcEAr5KOrdaxAQeMNbuAioUQYBaIsoQGX+BtVYc7yNKHM4L2esH+1RJ2+J1/E2Tq3sCXmCGYr82wccQ1IumiFjPH+bEGqrdKBO1ehqBe5wsPrTcgwrTt//awq3NY0vnqH+00gce2QDSfymxMkMCXrs8CO0fMlLEaBh6X179ZPDhDWRXHVm8e3rGz+z34PkF/jaYHUme/JzPPq1p9bBDZ9aYPrbfHCbSFgCse5eGzgvDtZRS64o21EM46CQYCRrbCzEYFfj3c+mn2zMs+9A4HNWvRaMVlKgcjHZy8yAIMQ7ScmyYPI1PRx8E/WajWQUwrP5W1gwxknkVf1T2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DAZNnlYqDebDfhokREktkXfVfCdyeSH4b12DMXLUD8=;
 b=qJaCXJ4SOBL1znr890r6oRgRiDWktydhptI4ANXf0z0IW+17XHbyZMpLlHTrMax9ofk5MZT1Xr4DL5SJb1gjP2sBTCcceQVr3h1qUfQIVPTHjyRhHZKmJw2D7jcDiyC/31ABou6DvP/Y0UOMWOlMTBIXHh7+Xfvuc0N8mO8MXAmUbivV2iOQ4a/J8iscNRZY0dGT6qzHydyRPzlX4l55JsiZNEzzvpb6qWnflpNR2Ra9flY8AmKaykXLqQ5lgEiV+DACwQPcEzMtolcx3qrAFnO2WjlmGw1JSbCWsCd08aoCvlZMwVkqui8ILQ2Unza0YK44xHPaXxu2mH77LU6btg==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 17:02:38 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 17:02:38 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Bernard Metzler <BMT@zurich.ibm.com>, Roland Dreier
	<roland@enfabrica.net>, Jason Gunthorpe <jgg@nvidia.com>
CC: Nikolay Aleksandrov <nikolay@enfabrica.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
	"alex.badea@keysight.com" <alex.badea@keysight.com>,
	"eric.davis@broadcom.com" <eric.davis@broadcom.com>, "rip.sohan@amd.com"
	<rip.sohan@amd.com>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"winston.liu@keysight.com" <winston.liu@keysight.com>,
	"dan.mihailescu@keysight.com" <dan.mihailescu@keysight.com>, Kamal Heib
	<kheib@redhat.com>, "parth.v.parikh@keysight.com"
	<parth.v.parikh@keysight.com>, Dave Miller <davem@redhat.com>,
	"ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
	"andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index: AQHbjuwVUw9AWIkXnUa8bbJSM0sPK7N6v4MAgAgXf4CAAAnsgIABEwYAgAAgrcA=
Date: Tue, 25 Mar 2025 17:02:37 +0000
Message-ID:
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
 <DM6PR12MB4313D576318921D47B3C61B5BDA42@DM6PR12MB4313.namprd12.prod.outlook.com>
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
In-Reply-To:
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|SA1PR12MB6893:EE_
x-ms-office365-filtering-correlation-id: fc845033-f4df-459a-f703-08dd6bbed8b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bEZPRDRXMEtQZkFsUm0rcWlnOFQwUE5abUhmeFVjUWpWNG5jYmlzK2pZM0V2?=
 =?utf-8?B?Y3NHWjF4dC9BUHlrM0poK2JuRUQ5ZHRQbHh3TmlxTFg0N0lvdFJtV2dSRTFO?=
 =?utf-8?B?Q2E1eFNtTTFsYjhpaXVNeW5Ub0NCcE5PZzZXZ0QwRG5aaXRrRmxjU1VYbEM0?=
 =?utf-8?B?RENodjUreExNZG1hb0lmaS9LOTBJMUpxY0JjUG9BdDljRW5EWitacjl6TjlD?=
 =?utf-8?B?NStZMHQxNXhOditBd3dIL0ZzaXhEUWRhMVdyUTdDdzJIL3pGdmJMK2JLckF4?=
 =?utf-8?B?K01BQ2hYb3BRMmR4dXFGV1JvejNUeWl1YXZ3aHRkY3lieGYwTWVUdFBLRm1X?=
 =?utf-8?B?YklyaFVNTnp6aHhZZm5QakNuSnJoYVA1NXFMaFp4SjROa0JhRkVTT0tMNEp5?=
 =?utf-8?B?V0FoTHVPK0pzUFZVOFl4UHUxOFBoOWdDYUN3QlhtZG9Za0pVdWlDZTdmSUF2?=
 =?utf-8?B?OXBTMHdvODRwRXpkMmVxN3NvWlkxQTZVWWFUbFJsMkwvRks4bG93VG8zUy8z?=
 =?utf-8?B?RTRXZldyZXFJOUJEa3FGQTlkWVlKZTBSdFRVZ2FtRXBvdTdNbjFjTnpuZlVT?=
 =?utf-8?B?SnY4c3BicGxQem01M014d2tLRzk5OW1MK1prSzUyNGs0a1RWSDArWkdiQmJu?=
 =?utf-8?B?eDhiaCt0RldUSS94N1R6SCtBSnZkclNxVEJGWndCMWJ2a3Y5YmFTMWtzcUli?=
 =?utf-8?B?bDN4UHdLRkVNWGVJQmhmV3ZrdGQ4QXJJL0VHYWN2dm9aY0FsMUJ5SWZHSmxy?=
 =?utf-8?B?Nk1KVkE2aDdJbjQ3Nmg2a1IwTC9IWEx0Yk9hcHo0b2hzTFFZaGpJYlJyZU1T?=
 =?utf-8?B?SWxxbUJ4eCs5Z0tEZzdWV1VRV042MG5qUlNzNzRqNGwxRVoxK3JQR3YzZVh5?=
 =?utf-8?B?VkJ2NEZZZ05MSHhIQ3I2bHNXVFl6SG5JZ3U3TmIwZitIMUU3UEFFcWcyNHl5?=
 =?utf-8?B?QUNIMkN5T3VUYUlHbENDeFA5VnBLVmY3THdVbUg0VE9sRjdzcnBJYXJHMWh3?=
 =?utf-8?B?cStVMisrSTR0Snl0WWYxWUREb1pPS0FLZ0djZlZZcUQ3SXBISTFHbTJRUjZr?=
 =?utf-8?B?bmJYUVduMFJ6OXNoQXBvbDczTk1VRllueUxHY1Fydk50SUZIY3V0eTMzYm1K?=
 =?utf-8?B?N0cxVVRVZndyT20ydnNPam5OVkxjWExUQlZBSk5qNGR2dE11YVFsMTZ3azlW?=
 =?utf-8?B?dCtIV1E5WnBNTXd4d3pXY3NaNHlvUnJoSzRWZnhGZ281blBwTVlHRUJvOGt0?=
 =?utf-8?B?QmJ1bUg0eEwrVTB2QUpORWcvQ3locFM5dTVhU005Z2todytlMHFlRVpzU2Rk?=
 =?utf-8?B?MEs2MUlWYWFRaGtmall3OHFKcjRHalNURGFLZXFTVFFmYmtMNk5TL2Q1THBy?=
 =?utf-8?B?R0JLVjd5cGIwcFZmMGhMejhGT2NUQm1EUHkwcWFiRWtkSWpwUGhyK1Y1SUts?=
 =?utf-8?B?MGh1MThxQUhuVVZyeXBDZU83L3pkMzJiekh1TXUvWVVVUGxTWTFBRHVkQ3VB?=
 =?utf-8?B?UEdwNW5hVHhnaXFHQTBaNVJYcTRROG1lRDg0TFh3WjdJMUdSb1FtbDUxeHFT?=
 =?utf-8?B?cElvUmg3OFE2WGdRQjE4U21WYnd6VmJna0JZVWJGdjV4d3hKVWJKc2M5eDZ2?=
 =?utf-8?B?eHdxTkJFcWZjZkNpd2ZDZHNGK21wRDRLcnRyM1RkL3BNc3haL2NqdFlwMHZP?=
 =?utf-8?B?MW1QbjFuVUxDZzdzdFpQR2k5UTI0blBTcTd0T3dTVkUrZnNORmRvK1Flc1VZ?=
 =?utf-8?B?ZG5pb3F1YVlDeGJsNjdUVkR5YTR2N3ByaUZxZ3llQjlFVjh1OG9TWktTZXl1?=
 =?utf-8?B?RHUzV3VKbFNZTVhwak5FUWdCbmp6RDVVU3hRSGxtMVFtQ2lPSUpvYUduNnpW?=
 =?utf-8?B?QkNwUDhPUWRJSnhnanNJTkU4Rk1tQS9aUWs1Y05LMHdrYm5WemZOcmNPQzJ6?=
 =?utf-8?Q?XN6M2SDGwL6sOIZVHJi607NIvejleSkw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDJBZ0F6bkpoN0lVVm8vZkZmTzBTVk1kTkxPL0hxaFYwYWNUYno5TlZNNDEr?=
 =?utf-8?B?MWlUdWtvUEdSYngyNGozM0FKK1piUlJhTnIrRXNZT1RTR0lWOGlPKytVcmZo?=
 =?utf-8?B?d2gweWEyY1lRN3R3Sk9NUmdBTDlaOFdKUTZEWkdGOGhEM20rcm9Idk1vSDNY?=
 =?utf-8?B?azAvWWl0VDFaUDQrK1IxNit4M1YycUpnd0R3L0Q3dTF3NFU1TTN1NzlTUDl1?=
 =?utf-8?B?ZGN0MDU4SUU0YlBUd0VQWVB5MFZYd0g5bVpaNHgyTlArL1pyeWsyeGliZFc3?=
 =?utf-8?B?ZWp3NEd6QmFHNmtuVGNvdENVa2lzVXlUaFFMUTBoUTcvYmJ5RlgvMHRzOW0y?=
 =?utf-8?B?YWpRMVB6ZXgyMFhadFVrbk1NRnhLYmMraU1sZDBaNEpoVlJKQ21kOFdKaUVz?=
 =?utf-8?B?a3FmMTFyM0QwQVhTZjVnbW9PRHkvVU5KZVgvdWQwNW1TZ0RMVzlIc0pwZk5j?=
 =?utf-8?B?SUprbk4raDhKQnB1M3lmWHB0TFU4MUJPTjZOTFVGcUJwaHpvS1A2V3ZTS0p3?=
 =?utf-8?B?NHVJTGFtYWp3Y3lLVms0NFZLSGU2SFFHK3RZY2VqbEM2cEJDYnVya21GWjdk?=
 =?utf-8?B?aG1tRVgvVlg3V0JhVmFhQnhaWTZoSkJGMmo5SitJNWo5NUFLYjdpeDlTZG43?=
 =?utf-8?B?bXBpbVdkS1R4ejRRNVgyWGl4WGtOREY5MGtrYXpYV296OEIvKzI2cHg5MUhF?=
 =?utf-8?B?dzQrbmdlNWdMaUxmWXNEbGNJbW8ycFFIYTNLMmIwQmRLODFsa09ZallKMXpI?=
 =?utf-8?B?ZlFPb0hGUnFFOG9YUzFzVE95eUZUS2dIV0VkRUZZT3R6emV0VVNubXZST0lu?=
 =?utf-8?B?OFNMVWx4UkZwUDlWUTVmK1ZRU2d1Nk41YklNVU5IbG0wd0EzRGQ2azlFWWtX?=
 =?utf-8?B?WXJCWE96MFdHQmRiWCtJVzFJUTYrRHMwVG1oSnF4WFcrcnV2ZG93OVBRYlZG?=
 =?utf-8?B?ZXJrdEJTTDdERmIwdlhaalRZSlRmVnBiU2xEdlh1USs5QXZmREk0eng0T2dt?=
 =?utf-8?B?TGNQaUY1Z1UrL3B0eFcrRWRpRi9Sbm5qWnNGRy9qRkpZS3I5NERTQkpuV2pW?=
 =?utf-8?B?UDJMcTlHOVR0cUJpcWVZVFU0MktZTFNMSlFrK2V5bEE2RWQ5cTlPRzZOeURM?=
 =?utf-8?B?enloSHVjWXVkRFZWTW1VenlKbGlaZjVSRld0dVRZMWhZTUJjUlVQbUFDQjg3?=
 =?utf-8?B?VTl5bElyRGpTcncvb3hLTnJqWnNnMkF3UzZQekhDaGo3UkZhSGpPaEQ5QlRR?=
 =?utf-8?B?VTRQY0xpZ1c2ZGxVT1BmLzA3dXVnT2t4TGUvS05VUCt6Sk04VjRRd0F6SCtp?=
 =?utf-8?B?RDBpMTVNR3ViNDVzbkRVN0dMNUU3cm1YT3hDWFJ1Z0NhU2VzZUo5c2xjWDhV?=
 =?utf-8?B?azNwbjZYMXAvY0djd3JqanlaWlF4dTI0cWJVQjdkOEpTUk1ZdXdNRXhyS3Qx?=
 =?utf-8?B?SzUyZnJZSjhpcG80Yy9BRTJScGk3QWVaRTdmSXZDbGM5RENsTVRLc052ZmJB?=
 =?utf-8?B?MEpVY1k5STUreXJxK2RucWRHc09JSDZ2SWlOUk0vQUlZN3prQklzNEtObTBk?=
 =?utf-8?B?ZEdVemRVbFZpdWxkQVBjU1cyeFkrRTJWZ0VGUzZYbkExc056NiszdDc1Wm1G?=
 =?utf-8?B?WXJNYkxoVjhhclNEOEVjdm95OERuN2k2K285OURlRlVHR1lRSEtzeWJ0aDhi?=
 =?utf-8?B?eGwwQ2VtKzRMRTd5MEtOQytLK3RvV1E1OWl1eC9tdmpxRWFZNWtVTDZHblVr?=
 =?utf-8?B?VE01MHBJWHNWTmpZS2V2a2Rtb1V0bG0wL296VDdsN1huNGdQOE4xYjFqV2dE?=
 =?utf-8?B?bnJKR3NydDlkbFdjdEJ3ZHpVbHhHSDNoZEJsVjdMOE8ydERQTGRVVUVHMjI1?=
 =?utf-8?B?VlpvTHlnYkhuM20xcGNIZjFnMEREZENFVVAwSzZ0WnIybmQwMTFYemY4SFNi?=
 =?utf-8?B?cFMxaFZwSXQxNExSNUZGTDJiKzVjbG5Wam1MMkhXV2VOOUo2YUxKUFo3azFr?=
 =?utf-8?B?bzVFK0d3dVdsWWFURXFQQVRSTG45UXM5WmE1eWZVY3l0ZUU2OE53c0YzNFRW?=
 =?utf-8?B?NVRYVUlsREZYLzE4WUZHWG5HcHdCaENjV0hKb0hsLzZaL29zUHFhdW4rMTB1?=
 =?utf-8?Q?bfOc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc845033-f4df-459a-f703-08dd6bbed8b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 17:02:37.9946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EeqNWAJd+KWZ2VGL5hO4wDXSlMvqLb8Ors3Ruk/HNST9YObBAMOb0ECh+TUAWdtghZ1KR53Gg88aUOCjQ4Cqiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

PiA+IEkgdmlldyBhIGpvYiBhcyBzY29wZWQgYnkgYSBuZXR3b3JrIGFkZHJlc3MsIHZlcnN1cyBh
IHN5c3RlbSBnbG9iYWwgb2JqZWN0Lg0KPiA+IFNvLCBJIHdhcyBsb29raW5nIGF0IGEgcGVyIGRl
dmljZSBzY29wZSwgdGhvdWdoIEkgZ3Vlc3MgYSBwZXIgcG9ydA0KPiA+IChzaW1pbGFyIHRvIGEg
cGtleSkgaXMgYWxzbyBwb3NzaWJsZS4gIE15IHJlYXNvbmluZyB3YXMgdGhhdCBhIGRldmljZQ0K
PiA+IF9tYXlfIG5lZWQgdG8gYWxsb2NhdGUgc29tZSBwZXIgam9iIHJlc291cmNlLiAgUGVyIGRl
dmljZSBqb2Igb2JqZWN0cw0KPiA+IGNvdWxkIGJlIGNvbmZpZ3VyZWQgdG8gaGF2ZSB0aGUgc2Ft
ZSAnam9iIGFkZHJlc3MnLCBmb3IgYW4gaW5kaXJlY3QgYXNzb2NpYXRpb24uDQo+ID4NCj4gDQo+
IElmIEkgdW5kZXJzdGFuZCBVRUMncyBqb2Igc2VtYW50aWNzIGNvcnJlY3RseSwgdGhlbiB0aGUg
bG9jYWwgc2NvcGUgb2YgYSBqb2IgbWF5DQo+IHNwYW4gbXVsdGlwbGUgbG9jYWwgcG9ydHMgZnJv
bSBtdWx0aXBsZSBsb2NhbCBkZXZpY2VzLg0KPiBJdCB3b3VsZCBvZiBjb3Vyc2UgdHJhbnNsYXRl
IGludG8gZGV2aWNlIHNwZWNpZmljIHJlc2VydmF0aW9ucy4NCg0KQWdyZWVkLiAgSSBzaG91bGQg
aGF2ZSBzYWlkIGpvYiBpZC9hZGRyZXNzIGhhcyBhIG5ldHdvcmsgYWRkcmVzcyBzY29wZS4gIEZv
ciBleGFtcGxlLCBqb2IgMyBhdCAxMC4wLjAuMSBfbWF5XyBiZSBhIGRpZmZlcmVudCBsb2dpY2Fs
IGpvYiB0aGFuIGpvYiAzIGF0IDEwLjAuMC4yLiAgT3IgdGhleSBjb3VsZCBhbHNvIGJlbG9uZyB0
byB0aGUgc2FtZSBsb2dpY2FsIGpvYi4gIE9yIHRoZSBzYW1lIGxvZ2ljYWwgam9iIG1heSB1c2Ug
ZGlmZmVyZW50IGpvYiBpZCB2YWx1ZXMgZm9yIGRpZmZlcmVudCBuZXR3b3JrIGFkZHJlc3Nlcy4N
Cg0KQSBkZXZpY2UtY2VudHJpYyBtb2RlbCBpcyBtb3JlIGFsaWduZWQgd2l0aCB0aGUgUkRNQSBz
dGFjay4gIElNTywgaGlnaGVyLWxldmVsIFNXIHdvdWxkIHRoZW4gYmUgcmVzcG9uc2libGUgZm9y
IGNvbmZpZ3VyaW5nIGFuZCBtYW5hZ2luZyB0aGUgbG9naWNhbCBqb2IuICBGb3IgZXhhbXBsZSwg
bWF5YmUgaXQgbmVlZHMgdG8gYXNzaWduIGFuZCBjb25maWd1cmUgbm9uLVJETUEgcmVzb3VyY2Vz
IGFzIHdlbGwuICBGb3IgdGhhdCByZWFzb24sIEkgd291bGQgcHVzaCB0aGUgbG9naWNhbCBqb2Ig
bWFuYWdlbWVudCBvdXRzaWRlIHRoZSBrZXJuZWwgc3Vic3lzdGVtLg0KDQotIFNlYW4NCg==

