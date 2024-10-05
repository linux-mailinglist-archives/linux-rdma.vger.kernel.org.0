Return-Path: <linux-rdma+bounces-5248-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 376FE9918E2
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Oct 2024 19:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B669A1F222BE
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Oct 2024 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CC015531A;
	Sat,  5 Oct 2024 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BqV2z3l1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E340825763
	for <linux-rdma@vger.kernel.org>; Sat,  5 Oct 2024 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728149660; cv=fail; b=GH+t20WNKpAJSzYJ1RUKnlFNb9TuysOg6kxSY0riQbdvDynP9u3HK1tph0TIFW14AyE1Jv7Rq+0xnK4EGBbMxMo7/9RHWhAzttAwK7DWCnOstWt2vbluN/fLsU9FFzOe1kAK5RAjRow7RduV9QfRRRzxmP/yLCp0EeVTiDhATcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728149660; c=relaxed/simple;
	bh=N6YARAGZAEX27NewRsxCFXtgUuIT4Ne7EaERN901/3M=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=EULTyu/+5akzlGKgl3SQADblfDA4T1vbJ9BPUy3FbEEjh+jKEufhSTreIUD1FPy5+p0k3Pr/OIp1PWerg/I/O14SIAQBWFBr5vxVanZAYT96iKsVHdmto2ICutpPi7FUgJ+VIdtWhs0g8iiP/BvYQsMrj1c0DvVi5qrnHnKxXC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BqV2z3l1; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 495HHW4P018141;
	Sat, 5 Oct 2024 17:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:date:message-id:references:in-reply-to:content-type
	:content-transfer-encoding:mime-version:subject; s=pp1; bh=N6YAR
	AGZAEX27NewRsxCFXtgUuIT4Ne7EaERN901/3M=; b=BqV2z3l10jrTOtZ8zeKeE
	O7+L/Iu9cktln/qrYPhqWsX/KLgx3V4UMK9H+q0SVpvnEmqr+0e7s+vjWAO5bMME
	8RyFXbuN6EkyiYryvNc2VrgfMtxry/4lhchMk1iQl/rEhBr7cyvjqikp/VjBkBlT
	6zqDV6xzJsA2pzfcenbE/eMipUSxksKKvEWcvPkje0YJyENyXEQlPBMK7rDDE9tP
	JDxuqxtCKtKDaErWNHSGKHYQciMW5mHTu1u9YQl3NFDRaCz6cXWYQbuZpHRULV7g
	Wg5IVwFqzMCKcozp8vA9Xp3KON8Xg49t8XWOtWyDbSRXemk5T+H25C+oWmlmyWXm
	g==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4239qgg1qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Oct 2024 17:34:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTZaF+dcMQYD2foAPZC5W7Jo45Pkr9InXrO35+0CkxgbZAFWfUtTC2gvL6O4j00AIvmMbtFz9wPlIZi7nmkQEY2LgkRww72DQTHqy/oHAqVMsZffPH26NGTjkhZRwK9HN7gc/PvvofjnXTYiDYoFU6pKAnGqBzskFAG7IclHHMQVvm86+SfB3bfIV463GNniO5dd6UVdJDVzucAiJ1AATKckAox8hFh6OT96nmCfVqACXopBewGgWT+eUmvmOOLHM2fqWR+efOIQ0VRdoLb/NzCq2KZto78HR6H6fWJ0PU4/mMWahckfyUinqsWOgYRFYn2n22Mm5cfCsrJI1ckNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fZMkbJmdPxi183ptjip5XhslLL1GH4YCLPbE/1Oe1Q=;
 b=hJLz3I6KrjcN8d3yLjwIYc6q6zEumEospck4BETQObxjoNJA+PtjAFxKEWiQvvN8AMhmsCaY0TwJlA6I4zu2UCZmAPnA03YUyvQEMmju3Q0POQg97c2RrH9qdY0Be77Uw9HjxL7pzZTWRn0WH+sNbFBPK5V/SuW4sFO7Ld06K0u+mOCfBhbhxX/zDnsUU0EMnsK5WJy+71OqJ1SZq1cYn+immt+EHmxswCOTRFk3aiqdRe242vf6Juth26I8jJ49USDP9DUV3QihwetbJXyBd02BcO277LyLXSlKRiUfdNSUybU3BU0YFdM5f0+qrtwuTMjCyyildNo0e3jWnHeOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by PH0PR15MB4976.namprd15.prod.outlook.com (2603:10b6:510:cb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Sat, 5 Oct
 2024 17:34:05 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%3]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 17:34:05 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [syzbot] [rdma?] possible deadlock in
 siw_create_listen (2)
Thread-Index: AQHbFnfvK92dX4ZDq0aBDLIk/5p0KLJ3XKGAgADgmKA=
Date: Sat, 5 Oct 2024 17:34:05 +0000
Message-ID:
 <BN8PR15MB2513CD9F025E8F8B4F28661099732@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <66f562e3.050a0220.211276.0074.GAE@google.com>
 <BN8PR15MB2513A03800D7E2AE03C63B0699722@BN8PR15MB2513.namprd15.prod.outlook.com>
 <20241005012037.GL2456194@ziepe.ca>
In-Reply-To: <20241005012037.GL2456194@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|PH0PR15MB4976:EE_
x-ms-office365-filtering-correlation-id: cc7472ca-f06a-4846-bfa2-08dce563e8d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WlZDV0FzQkJDaDN6Sk9sdFhXYkpQcjNac1dGOEpKcUx1dTBqVnRqbWZabGdX?=
 =?utf-8?B?N0EycnozZWFiQ1d5bGdIMGI4ZVB6N0dBVFlJNTIvZHUxSVQyZDZPcUVZbjNp?=
 =?utf-8?B?U3FQT1BwMllWK0VzWjk3MzZFcXYwZjUwSmxUUlhiMEx1QzV5Z043SFVabFZM?=
 =?utf-8?B?ZUlObzNMR3UxYjZ4MWx0ZzFXZWUyWHRmKzNGVHZqNGg0c2NxUCtuc29kOEFU?=
 =?utf-8?B?ZHl2aEFRQUxjK3o1MWl5Yk9iaWRiODRrTjJ1U3ZNYnd2aGVxT0tTWER6QWls?=
 =?utf-8?B?UTBydUdRWVdkc1B1cVAyYUYxVmk2clh4WTBaUXlVSEV3VjJBbXljT0w5VGlU?=
 =?utf-8?B?LzJ2ZVNmL25WNDQ5bUhlZWdRS0xzaE9SeW5VV2dsYXBDWEIzT01XN0ViNEgx?=
 =?utf-8?B?L2N0dHk5RTh2a1MvaE5aKzNzUHJBQmwxSXRRVlgycmZqaXd0dzlaVk1Vdktu?=
 =?utf-8?B?Sm1HR0lPMVpna3pEd1pSNUptR0xMU3VuN2lPVVZoWWYyZ290c1VZTi9WVE5i?=
 =?utf-8?B?MUhCZW9HeU5Md3BuNkJjeGt4SWM4ZldxMU9YTDdsWXlKL0JVUjFyMmxFRUdB?=
 =?utf-8?B?RGtxb0hiaGdtajdVMWpRUEw2WXRheDVWMk80TFpWaGxSdjBuTnhyQzh1MTBT?=
 =?utf-8?B?VDdERXI4QzRKLzdxajVYeXZpUnJOTXZvYW5lNVQ4dGFQNXErYzlJMTllcDR0?=
 =?utf-8?B?UERMRVpWM004dUp0NzQ2Y0NZMVU1RGpDN0ZvT014UWhFcmlhWGZRU0F5aDRN?=
 =?utf-8?B?anY5YUxHbFpUNy9odCttdG5mazFaSkZCUndMdlIrQ25hTmtLdXorSml1WEgr?=
 =?utf-8?B?UlNXOGhqTkp3Vy82eTFMRm94MmFQKzBDTStjdktEdHZINnBBYnpKUmcxSDRI?=
 =?utf-8?B?QkJjbXpwRGdnaDY3V2VVd0JEbzh1a09mcHBGVXArN1JQV2hQS3hqTnMvaVpr?=
 =?utf-8?B?WWVmM2xvNkYrVGg0L2c1bWFkM1NTTndPMWhZODh5MjM2emhTVUd0ODBROHQy?=
 =?utf-8?B?akdBY3QxR25BczZVTjJIR0lBZGNGT1lrMVFyS3ZwcVd1T2lnZ1hMcWxiUXRs?=
 =?utf-8?B?MzF0dDF4Zm9GZS84MzRkRFV3U21wTTh0VExoZ0x3UDllY2Y0bEFPSXk4U05W?=
 =?utf-8?B?bjBEUjk3d1RwTy9CbHZEZjNhTjgyL2JCOGZyNFNBZ0ZRSTU0aW45Z0k5b1Zl?=
 =?utf-8?B?MnhTekIxaThJMFlVU0lGY1pVZ1VRdVFtUTRJVTBJc0VwRmthc1BKN2xwaE9W?=
 =?utf-8?B?T0NEYml5WnZ0MTVxUEd4cmZrS3g3bTEvNjRyRGFkZU1BWVdwVDR2VnVzamYx?=
 =?utf-8?B?WjNRRjZZcW11ZGlJTUxWbWFBYWtWWDdGUFVZRThNMXdQdGk4UmlFRlEzeVgr?=
 =?utf-8?B?WWVoZVlZSXFHQzJ6STU1bFV6YUF3ZEpuY1ZqZ3lSS2MwVC96MTJRQ2JrZmtZ?=
 =?utf-8?B?S3RuYmRZTC9xUk5Wa1V5NWlnSXRKaFFldWNsU2xSOHNKZXZYc0hEWW9iZ3FF?=
 =?utf-8?B?RmtMRUM1RkxOdXEzN2gyQTlmTmQ5T0Zobm52cUoyY1V2dmI2dDZva2V4eUpE?=
 =?utf-8?B?Qmh5YlFFZkZUYTc0K2dkWEZpNDk2WC9mWHk0WFZXSEhveldzc3pyYXpoTVZI?=
 =?utf-8?B?VVVodloydGxMTDc1ekE3YUxrS1F4bGE4MlhrM0ZoQ1NvenNNMzdhL2dkUDhF?=
 =?utf-8?B?aEdVTEgrWExHOFB0UkoraDVRSUN6M2pDRk1uOEo4RU5ES2JQWEpwWnN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDR4Lys4RWd1a1c1YUhLWG9UUnd6WDFIUzdlVHpodHNOaEJ2M1dDKzl1UlEw?=
 =?utf-8?B?L2Y4OE9qTEtVV2xzLy91a0VRYWQ5Uk0veWc3cC9XWXNNakRCZUFhRzB5a1hk?=
 =?utf-8?B?U3lPMjBOMHFXMGpBU05uWXl2UWhrVXVNVnlRTXp2bjVNQ1A4Q1JwWjg3eHFQ?=
 =?utf-8?B?VVBQd0puWDBkVitvN0xHTW55R2xKdEk2MmVROHFJck9yUis1QkJSTk5IUGoz?=
 =?utf-8?B?VHdRd0c5bE0vcUVVRkVHU3d5QjNoYWIvclNQOG1lbFVSL040SDh5L0ZLM2xB?=
 =?utf-8?B?S0lRSDZwNjV4YjVpZlQzYWM1Z2NkcXdBbXFtVXRQYVJoZnYwYlFDVEd1b1pI?=
 =?utf-8?B?a2Y3bldXbTJ0UWdvc2g3TktwdnVQYm42RG1LYTJaTU9Obkx5UmRScXJCU2xN?=
 =?utf-8?B?c2pQWUZhRXBuMUdaTGU5K0VNVEVJam10endXaHNhQnZUdG1qNVBxWmg2cHpD?=
 =?utf-8?B?bG1ETXJ6dHEwMUpkQStxeHlmSEtnQk1iUEo2U0tqQXFLb0J5cXN3cnRzemdh?=
 =?utf-8?B?ckVjbDE5YTF0azROdjBLQlFZcUo2ZEJ5RVFIRXkxWEhnc0drY3NGQUdXdW9Y?=
 =?utf-8?B?Y2pVS09FdE1mRlJ1NnM2RlBsOUx3STNGTGg2L24vdHFSUEFETDFpaFNRN0dE?=
 =?utf-8?B?Y3h2MEJkRzYzN3RIaFl4WGRtemdUSnk5bFBNS1NIQU16OXlRNGEwMEhlVUxm?=
 =?utf-8?B?TitINmVVd2kzM0N1eGxsbXB0U091WFp0dFlZbnd2aWV4ck8reG5mR3pjM3g0?=
 =?utf-8?B?QzJJUEtBZWxSbnFhTlUyYU5ySUZwNml2WVhhRGJKT1M5TFltVjZGcUlOVTlx?=
 =?utf-8?B?dTg1N2VyaDlnd0FRMndjYWluTFdoazd4K1VQN2dtcndkYUJjYS81L1o1UjBu?=
 =?utf-8?B?dStkWHU2Q0tCcDNaekpoTGlxRXVKYU1SQ0xkbDIrRTIvNzBGSmtPRW9YTS93?=
 =?utf-8?B?WkxNQ3FtL3p4WjBqdG5kUFJmNFFJTnpTdHVCcUM3TkRiWXlIeVRvN2pERHRX?=
 =?utf-8?B?YXczYStvcVZZMytIcUdmUnJqM1VrZE5zU0ViMFgvd1VESEwwS0VKcGJ2Sm1K?=
 =?utf-8?B?aHBMRFAwaFRvVm1Wa0d5U3p5SG80a2FxWXhEcXRLVXNhY2FnNGEvaCtYMlk5?=
 =?utf-8?B?OWtSQVhDTjJVeUdDMmRKNGJWWlpyVnlYQ3hETEFRSUpQbDA5ZVVQSHdpeHQx?=
 =?utf-8?B?dUlXekc4ZnhwTVZXR3RJMHFDMExBZDNlNFY2K1AxNXhrcWpMcVQ3Nm5nNUxw?=
 =?utf-8?B?S0dGd0FtNnQzM293dzJZbHNkUzhUY2hWdFlEampBL2RJZ1FDOW1ibWRHRWtp?=
 =?utf-8?B?M3JVZEYvUUpjakZHUklGd2hjWEhtNnhQQkUxanBrdUZ3UUQ3dTBqenI1WkJZ?=
 =?utf-8?B?NDRyZlhKTTZ0ODJxUGlMalBwT2ZZQXQyT0k2SFRGcnFhd3VYUlVyQXkzTEJy?=
 =?utf-8?B?RStYc1FxTG95ZVJwTXdJQ2xTQzQ1T3c3cGRoTjJUaDlvZjdzSnF1OFNIc0Ru?=
 =?utf-8?B?VzhKeXZ4NGt6bGtCSENNRDF6bm9JZXpsR3RHamQ4V2FRM2dkS0JXT2d3N3JV?=
 =?utf-8?B?V1VkOTFkdk9hVFZjK2cxa3EvRDNNZml4NjhTL1diMXFWRDNnUjAwWkdsSXRY?=
 =?utf-8?B?YldWUjJDOXhmZFZRdzhCcVRzTUo3QmpUWlo2L0dQbytXN2QyMDZDNlVyTVEx?=
 =?utf-8?B?YTFpMGxiTFhUdzFKQjNxY2szcTZoakFQS1dpRkw5Qkh4TTBId3ZDTWVaWm5R?=
 =?utf-8?B?ZWoxQmFtbjhRK3ptMTl4QnlMSEE5OFluSkp2KzlxMzRvWnllWG5aOG9IeGhI?=
 =?utf-8?B?aWRDL0VyWjdlVTQwUWtmdWVGdU1XNWtXVlJtNGdpbEVJTUNlcGlaTFRtUXpl?=
 =?utf-8?B?UjNwNStiK094KzhHaWtxQXBtaGdCSEoxZUtYclhvTTcvWnNFVldhNjZaQlhY?=
 =?utf-8?B?d216WlluQWJJUjBwd1k2UFhOMFI4RWxUWE42cUtoMVNiWWdKZ3M3OUVuNEtO?=
 =?utf-8?B?ZlhpQ2Z5QjBzUUFQN2cxTTczdTlvSHpSSnlSdXJNcEc3WXdvQjRWN2MrUHVW?=
 =?utf-8?B?RXh0ZWpoUEVXZENiWGRvbFNDQUR3L0pWaFJqbTNUcThlQ20vTTFKbkxMSFFK?=
 =?utf-8?B?R2FQMnFkZFQvRkZ4SkJKRFVRcUsrSkdWelVLZXl4NmdqN3BUKzhWNXk5Zmdu?=
 =?utf-8?Q?9jorKVp4t1ZibNPoW+Boq4A=3D?=
Content-Type: text/plain; charset="utf-8"
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7472ca-f06a-4846-bfa2-08dce563e8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2024 17:34:05.0170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNBlijG/Ol6/FCtR+lS8VuTqyzmB5pztf3x9hiJOQU6wYwzKk0vytAsEnfs3oWmKb4Kkh1a27L9CIwchiHeGDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4976
X-Proofpoint-ORIG-GUID: W0STMMqm8oQNbtwS1u12PccChEq2vjzF
X-Proofpoint-GUID: W0STMMqm8oQNbtwS1u12PccChEq2vjzF
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [syzbot] [rdma?] possible deadlock in siw_create_listen (2)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_16,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410050127

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAemllcGUuY2E+DQo+IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDUsIDIwMjQgMzoyMSBB
TQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+DQo+IENjOiBsZW9u
QGtlcm5lbC5vcmc7IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRF
Uk5BTF0gUmU6IFtzeXpib3RdIFtyZG1hP10gcG9zc2libGUgZGVhZGxvY2sgaW4NCj4gc2l3X2Ny
ZWF0ZV9saXN0ZW4gKDIpDQo+IA0KPiBPbiBGcmksIE9jdCAwNCwgMjAyNCBhdCAwNDoxMDozMVBN
ICswMDAwLCBCZXJuYXJkIE1ldHpsZXIgd3JvdGU6DQo+IA0KPiA+IENvdWxkIG9uZSBwbGVhc2Ug
aGVscCBtZSB0byB1bmRlcnN0YW5kIHRoaXMgc2l0dWF0aW9uPw0KPiA+IGNtYS5jOjUzNTQNCj4g
Pg0KPiA+ICAgICAgICAgbXV0ZXhfbG9jaygmbG9jayk7DQo+ID4gICAgICAgICBsaXN0X2FkZF90
YWlsKCZjbWFfZGV2LT5saXN0LCAmZGV2X2xpc3QpOw0KPiA+ICAgICAgICAgbGlzdF9mb3JfZWFj
aF9lbnRyeShpZF9wcml2LCAmbGlzdGVuX2FueV9saXN0LCBsaXN0ZW5fYW55X2l0ZW0pIHsNCj4g
PiAgICAgICAgICAgICAgICAgcmV0ID0gY21hX2xpc3Rlbl9vbl9kZXYoaWRfcHJpdiwgY21hX2Rl
diwgJnRvX2Rlc3Ryb3kpOw0KPiA+ICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9saXN0ZW47DQo+ID4gICAgICAgICB9DQo+ID4g
ICAgICAgICBtdXRleF91bmxvY2soJmxvY2spOw0KPiA+DQo+ID4gc2l3X2NtLmM6MTc3Ng0KPiA+
IAlzb2NrX3NldF9yZXVzZWFkZHIocy0+c2spOw0KPiA+DQo+ID4gLi4ud2hpY2ggY2FsbHMgbG9j
a19zb2NrKHNrKSBvbiBhIGZlc2hseSBjcmVhdGVkIHNvY2tldC4NCj4gDQo+IEkgdGhpbmsgdGhp
cyBpcyBhIHNtYyBidWcsIGFuZCBsb2NrZGVwIGlzIGdldHRpbmcgY29uZnVzZWQgYWJvdXQgd2hh
dA0KPiB0byByZXBvcnQgZHVlIHRvIGFsbCB0aGUgZGlmZmVyZW50IGxvY2tzLg0KPiANCj4gc21j
X3NldHNvY2tvcHQoKSBldmVudHVhbGx5IGluIGlwX3NldHNvY2tvcHQoKSBkb2VzOg0KPiANCj4g
CW11dGV4X2xvY2soJnNtYy0+Y2xjc29ja19yZWxlYXNlX2xvY2spOw0KPiANCj4gCWlmIChuZWVk
c19ydG5sKQ0KPiAJCXJ0bmxfbG9jaygpOw0KPiAJc29ja29wdF9sb2NrX3NvY2soc2spOw0KPiAJ
bXV0ZXhfdW5sb2NrKCZzbWMtPmNsY3NvY2tfcmVsZWFzZV9sb2NrKTsNCj4gDQo+IA0KPiBzbWNf
c2VuZG1zZygpIGRvZXMNCj4gDQo+IAlsb2NrX3NvY2soc2spOw0KPiAJbXV0ZXhfbG9jaygmc21j
LT5jbGNzb2NrX3JlbGVhc2VfbG9jayk7DQo+IA0KPiBXaGljaCBpcyBjbGFzc2ljIGRlYWRsb2Nr
IGxvY2tpbmcuDQo+IA0KDQpUaGFuayB5b3UgZm9yIGhlbHBpbmcgdG8gY2xhcmlmeSB0aGlzLiBU
aGF0IHdvdWxkIG1ha2UgbXVjaCBtb3JlIHNlbnNlLg0KU28gYmxhbWluZw0KDQo+IHNpd19jcmVh
dGVfbGlzdGVuKzB4MTY0LzB4ZDcwIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmM6
MTc3Ng0KDQouLi4gaXNuJ3QgcXVpdGUgcmlnaHQuIEl0IGRvZXNuJ3QgZGVhbCB3aXRoIHRoZSBT
TUMgbG9jaywNCmJ1dCBsb2NrcyBhIGp1c3QgY3JlYXRlZCBzb2NrZXQgdmlhIA0KDQo+PiAtPiAj
MCAoc2tfbG9jay1BRl9JTkVUKXsrLisufS17MDowfToNCj4+ICAgICAgICBjaGVja19wcmV2X2Fk
ZCBrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6MzEzMyBbaW5saW5lXQ0KPj4gICAgICAgIGNoZWNr
X3ByZXZzX2FkZCBrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6MzI1MiBbaW5saW5lXQ0KPj4gICAg
ICAgIHZhbGlkYXRlX2NoYWluIGtlcm5lbC9sb2NraW5nL2xvY2tkZXAuYzozODY4IFtpbmxpbmVd
DQo+PiAgICAgICAgX19sb2NrX2FjcXVpcmUrMHgzM2Q4LzB4Nzc5YyBrZXJuZWwvbG9ja2luZy9s
b2NrZGVwLmM6NTE0Mg0KPj4gICAgICAgIGxvY2tfYWNxdWlyZSsweDI0MC8weDcyOCBrZXJuZWwv
bG9ja2luZy9sb2NrZGVwLmM6NTc1OQ0KPj4gICAgICAgIGxvY2tfc29ja19uZXN0ZWQgbmV0L2Nv
cmUvc29jay5jOjM1NDMgW2lubGluZV0NCj4+ICAgICAgICBsb2NrX3NvY2sgaW5jbHVkZS9uZXQv
c29jay5oOjE2MDcgW2lubGluZV0NCj4+ICAgICAgICBzb2NrX3NldF9yZXVzZWFkZHIrMHg1OC8w
eDE1NCBuZXQvY29yZS9zb2NrLmM6NzgyDQo+PiAgICAgICAgc2l3X2NyZWF0ZV9saXN0ZW4rMHgx
NjQvMHhkNzANCg0KPiBUaGF0IHRoZSBDTUEgZ2V0cyBpbnZvbHZlZCBoZXJlIHNlZW1zIGxpa2Ug
d3JvbmcgcmVwb3J0aW5nIGJlY2F1c2UNCj4gc3l6a2FsbGVyIHB1dCB0aG9zZSBsb2NrIGNoYWlu
cyBpbnRvIGl0Lg0KPiANCj4gSSBndWVzcyB0aGlzIGlzIGEgZHVwIG9mDQo+IA0KPiBJTlZBTElE
IFVSSSBSRU1PVkVEDQo+IDNBX19sb3JlLmtlcm5lbC5vcmdfbmV0ZGV2XzAwMDAwMDAwMDAwMDkz
MDc4ZjA2MjI1ODNlNmUtDQo+IDQwZ29vZ2xlLmNvbV9UXyZkPUR3SUJBZyZjPUJTRGljcUJRQkRq
REk5UmtWeVRjSFEmcj00eW5iNFNqXzRNVWNaWGJodm92RTR0WQ0KPiBTYnF4eU93ZFNpTGVkUDR5
TzU1ZyZtPUpwWC1EWC03MEtDaC05TXpERTRZdDB3T3RyTWowM2lXV3VrdF9BXzdxQjJ5Y20tDQo+
IEllYWNTQ1VVRFRRNU1TMjQtJnM9RFFjNzc2S0k4NjNIWF9zS29tN2tjaTR5a0lnWGRON3NrSU1W
YldTMUhqYyZlPQ0KPiANCj4gT3IgYXQgbGVhc3QgdGhhdCBzaG91bGQgYmUgZml4ZWQgYmVmb3Jl
IGxvb2tpbmcgYXQgdGhpcw0KPiANClNvdW5kcyByZWFzb25hYmxlLi4uDQoNClRoYW5rcyENCkJl
cm5hcmQuDQo=

