Return-Path: <linux-rdma+bounces-9447-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B6CA89F00
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 15:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A623D7A6CB1
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 13:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7452973D8;
	Tue, 15 Apr 2025 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ducRbtTC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8952DFA4C
	for <linux-rdma@vger.kernel.org>; Tue, 15 Apr 2025 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744722574; cv=fail; b=dAdOZPHSbhjM0jKNE7njsOgOftZVo6afM+Me/FZS3RzRYr2j/35bVbVMx+QfyCurThTn0ctmF0HNdoMcAT4HKX8Iif7aIcdZyIxspD+UvjGbVyg8cGXSbi22y/+Yt1iJ3OZYcMbYZuS1jxiv27V5Sz2XT99fcyKcSN+i24nlHmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744722574; c=relaxed/simple;
	bh=O50vULDUzE6CW3S94U+73EhAwUA/HxDF6i9XuOm/ces=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a2K++DPnWwDfU9d/aGf90ha7zbceoIS79Pw7UfpxCdB4VdE9EEu3dY/odxFmN0IxP4lzfNJgQ36tCfHepHiBmKubQS/LZSLoPgHRmOPJBRaENsS//461S4PFW27MwkWpRRcHt/wUp+3onaUJQlIR8FE9O+5FcNWjqtwdG9gPPcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ducRbtTC; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F9tKE9012041;
	Tue, 15 Apr 2025 13:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O50vUL
	DUzE6CW3S94U+73EhAwUA/HxDF6i9XuOm/ces=; b=ducRbtTCetSXEh3XlBFcsu
	u3dRj3YRFZVjfG2CT6M5Da9E2/LsjZLqg6Q0/ujIOwKS6rcLYT1xX5yQ2O2YkEOr
	RGmYZX+hblQiNIL7gqPhQtb2ub8MMYOcuOzvSKIL1+bu5FYgpjQcwV/WMvanHBvZ
	j0v4hMiL4B54u5vcudQzsCqL5d94Y3zE4ahWk8FT/XlG7Cga9sO+fb1rK2+4bigu
	d2yFL7sgooKEuFJ/aRk31pK4c0SzaNUOsUd2gWqQdWZj5YbY4bOM0gvG9vkHw5dr
	3+x67ewMPJUzhQx3PMQ10lxDDRqOhR8XswMii/LyQqgZYj8ObEhg3iNESiypoSZQ
	==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461af53pvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 13:09:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6IwFHmfNjdLqEuDYC0cqtmkjJ6wsGXIHzckP/hLGpqY+lyQzHTnLXyqcdznZ9Y9OuqcbUzTdPvVLDXZXhk7mNC+fP935924TrceI81DO4scxzAqNFF6AWPjaqngc/LEDVTw1o+oj6rurqeDnTHfte7uNuD8w31EfVDCd+S2B8M/gEUlnbfe8An4YcyOPrkJE1DoP/kC9Ldv+EMAoZin2FKXZkY6wHNdUCHGpYVEWI8CLRkihhd49X14/6Z+etRTemZWH68Avcov+D2aXXUnTdwfpxqIvxVfe8nYcGmuhJ1kuU8WFaYgz2vYETUAbVjEbKzPGM4D0CqvJbBqnsV2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O50vULDUzE6CW3S94U+73EhAwUA/HxDF6i9XuOm/ces=;
 b=kCE6OvRSm9f5w/gyBL+COJ9ZhJJS0LKfhxM3WgbfI0gpGI1TYTQ+fsGrcZviDoZ7Xl9M9GbVzWwd2ZYiGYDrEyqY9szSWrhaQNOQX/8NGEZQS4nn69HZk/KK1fFvJ2fL7sVMh4vAUSBZx+mP/WNgLwNiHr7krzb+53CVceSjGAhZ4nvunC46aEumTa/mbbAqLlJaCGiXaoDSrF/tUfqpmjJuKXxVn6qks2yrSk9kVB7GjXKJQ3sUhYaaVElPeDYqOthcaUOc9AsoaICPIrbY+MeAuarSDfEF5KjsQJCAzjJby15S8YWhOsn3bWpqw6gQcGn1WWd5uU3mniGWNvbjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by SA1PR15MB4966.namprd15.prod.outlook.com (2603:10b6:806:1d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 13:09:15 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 13:09:15 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: Daniel Wagner <wagi@kernel.org>
Subject: RE: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Topic: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Index: AQHbrfdhJhGSraouF0ezotWmIGdrJbOksFww
Date: Tue, 15 Apr 2025 13:09:15 +0000
Message-ID:
 <BN8PR15MB2513CD2A5725F5A035AE905699B22@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
In-Reply-To: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|SA1PR15MB4966:EE_
x-ms-office365-filtering-correlation-id: 2fa2e539-eb4a-42ab-28cc-08dd7c1eb8fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmlaaVdabnFxTnBtaE5xeHhmbFNTMGFva3dNcXdld1dUcWE1UzAzayt0aFcr?=
 =?utf-8?B?c1VFZUFFNDRFcCtwbzlFR2ZoTTRaV2VYeDUvTHhCNGYzcnprTlhyUDUyT0tK?=
 =?utf-8?B?Y2xLSlpzUEJxcnpZM2NmQVdVVVZWUTgxcXhVMG9NaEpNNnZESWp3SzMyZC9K?=
 =?utf-8?B?UUtBSC9SUGpaYWwrWTJVU0RjaGNYTHliYWFzVzJDeDlZcWdIckNIM3pERWxM?=
 =?utf-8?B?N0NuWm9BVEVncVRSUlJGeVlyM0pZRnNxR2xOOEZtSDZrb1BCM2piSXVST0c2?=
 =?utf-8?B?WEdxb1dCck9hY1RQMmtMT3VrMmpvTERoamVzNUV6ZjZCUUtydEhORWNFdHYy?=
 =?utf-8?B?RFZKWXVLR3RFWjQ1bkowd2pDZXU1Z3QwRkxmaGVaeW5JQk9PWUJzWldmM0tC?=
 =?utf-8?B?Vmg2aVZZMHNlem16OGdxVm4xM3ZYcFhTSlpDWUpOcklZL0ZyNzNDYXJqKytH?=
 =?utf-8?B?K1NSM2EzUVArQjYxamZCZDlBNXM3cTFrUVZPZzNMcUpMckJiZ01RWXJvNzZn?=
 =?utf-8?B?VUt3YXRVRWtnU0U1S3FsUzlOei9rbGZYenY2WGJOSVZnQ0t0NSs4N1F3RFBj?=
 =?utf-8?B?dGtTcVdTSVpBY0RIUmhYVWd1SFhES3lhS1BOeU03ZEtRVGZwK0I4NzFYc21j?=
 =?utf-8?B?VmNXVzZoY0k5OVdXRlBOb240Wm1sNTJTODEvTHZsRmNpcE5MdXFNWnc4N0Fl?=
 =?utf-8?B?dWRKc3V4UzRjN25IeG9zOENrbk8xaStrM2dUWkh1WFJvQnFNZmtzUHNQRnZh?=
 =?utf-8?B?NTVEUE1mRFZGMk5PSzM5TXIyREFhVXhzSU1aQi9NRE1VWkF3eDRTa1J0cER3?=
 =?utf-8?B?YU5UMllMbHhicjZETHU4M0JhNXQybnJRdnRQRzUydUdqMmZBOWg2eENQNmUx?=
 =?utf-8?B?UnB5a3FQc1RSWUxZQ1AxR2V4a2NKVDVYMzkwbW90aU5KZTJ6SHk1WnE0NWdN?=
 =?utf-8?B?Z0FMNEpnTHBNMW1xcHB6Y2VJRTB2QkFIYnJYM3pUUGd0VVArL0d4SDRDa2M3?=
 =?utf-8?B?RTRqWDR1Zlo5R3crakpwbko1bmpCL2srK3hRb1krVnVTUlZab0pod0xZU1BH?=
 =?utf-8?B?THNidEs1MzBWdXJLclFnTGE3eTJTQklIaTE2aGtzZkNrSDREUEFHYjB6UEJT?=
 =?utf-8?B?WU9qWVVWNmlMczdxUUR0SlNSTTRVWVJvdmNaTi9hUmNVYjFteDJaL2twWWdh?=
 =?utf-8?B?bDVXSnVNcGlFQ255NS9sUG45NlRIdXN6WmwvWkRERDJWUG54V0srM3BTbVRR?=
 =?utf-8?B?N3VoR2ptK1dBSUhRam85TVJwSHYyVHdnd3NhWmZWLzNUUmV5aG9kek9NVXBU?=
 =?utf-8?B?TGdBLzQxejgrS3cvQUllTlNaTTN2RkFBNkZRY3Y3SkRsUnE0Mkt2dU9mUmcx?=
 =?utf-8?B?NmJhNWE1N1ZDcU9CZXF0MnREMW9TMFNXSks0NDZuY1BSbVJoSjZlSHRTVnZS?=
 =?utf-8?B?ZnAzeEd3MWsrM2E2Mi82K2lpZUREMFJZa2NxNVB0aUx2aGhOKzRmSC9adCtm?=
 =?utf-8?B?eTZqRHFISkhvdTZKclpSR3JROW00MEZvYnhWUDFlS0k4ZkRMcFVINTdQUE1z?=
 =?utf-8?B?RFJITnFwZWhwTlNYalRNblB1b3g5VGxBc1h0YndmNE4xYklNUHJCc3ArLzVp?=
 =?utf-8?B?UzJwVUdxcVJUZWs0WUZzU1NUR0QzTWNpNWNiVHliMjRnaHoweVF1TXdxdjUv?=
 =?utf-8?B?by96Q0J0dllDZ3VWS21TdklMVFJ3WmdaR3lOMitRR3JQR1BxTzNKc2d3alQ1?=
 =?utf-8?B?TjNvMFVkdEpVOEZsblR2NUk1ZU4zUkxWMVp3dmNHTmF1TUJHaDg1eTNGcTJt?=
 =?utf-8?B?OHY3dXZWTGVpcXpTWUhwQ1k5WWxCOGZDdExkS1lKN2lQdjB0UXdoYTM2UzlI?=
 =?utf-8?B?ZVE5UnAvU3U0ZWlleDlralp6R0tMbFRnNHc3SjJwV1FwRVF4QjlSSFFpWjFI?=
 =?utf-8?B?TzN3NWpUYkgxRGtwRkFDUjNydnphQkJ4RXpFYk1ybCszRnNJbkwzYkNkckNL?=
 =?utf-8?B?TTR1VXZ5ZHhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OCtIckx0MCt0MXF0ZEd0WTYzUzB0M1Jjb1oveUpqZm50ZTdZNzk5RXVHVThl?=
 =?utf-8?B?dC83aG9ydEtxQWZCTmxmZCtlOG1iZzM2aU5Cay9rRlk4M2F4cUsyQ0huQ2pQ?=
 =?utf-8?B?OGlLVFg3V3VmeTVtMGlKeENDejFDZnlCT0d2NkpuSng1VGpVTVE1dmxabUtH?=
 =?utf-8?B?TnI3ZTZTUWFsS2x2U1RHaVdzWEpuSEtZalp4cUdnVS9NQWhKOER4Ujd3Sy9q?=
 =?utf-8?B?NzNVSTlUd0lEWTMrTXQrRUxTbWpxSGltVHJQQnc1MHlCNlZBUTZMZ2EzSXps?=
 =?utf-8?B?VVlFUTlhRXJsblpKenl4VXM1ZURHK2EwMVI0Q3VBSUhTSkJlbElvUnhMaGti?=
 =?utf-8?B?ZHJnOC9mZmRFNmV2QXQwL0NoUU1ZKyttOWtLejU0MXcwOXFBcnNVWDcyM0k4?=
 =?utf-8?B?b1NvUjF6U2dkVVIvRzBObzRNVGNWSWdFdG53eElLUjFSOFBaUmRHR1J0M0pq?=
 =?utf-8?B?bEt4aW8zd0Q3VE9LZThrVjVhQllNL3VMZCtrNWxBaUdsQ1VPcXlFdzZLSk8z?=
 =?utf-8?B?Q1VqQ1k5YUUya0VKUEtWOGVVY3U2MWlqM09tYjc1YVNFSUtNTkhScitvdmZK?=
 =?utf-8?B?ZUFIVWJCQ3J5V2RHTEJDbHB1MkprYjIxNUFGWTk3amE0TElsOGx0MDhnNE43?=
 =?utf-8?B?aFVITyt2TWZ1MzFIRWNReTVzSUlYcDdDS1VWY2N0aUJuakpXZ2w0T2RQbVh3?=
 =?utf-8?B?ZXBBRXJ6WmZRbi9pd2RHSHFTejZMaG5CRm9ubDArWUlmSHl4Ulp0Z3hUL3A5?=
 =?utf-8?B?TUpTZjVETUs4WHZ1TmI3ekR5NUtlTlBtcEFrdmJlNzJ2UnRPMUY1RitVUTFq?=
 =?utf-8?B?RTNZNjA2YTl2NlhTNHd0TlY5bDE4YXFLUEhrQWMrV1FldEVwZm9YSUpVYU5T?=
 =?utf-8?B?akhIYit4N2VvK1NXZ2FhbnpwTkxUUFQ5b0RVNzVLUFgwY0JPYVZ6cUVkSmtV?=
 =?utf-8?B?ZnRXb0QrMHdOQXZ6NkkyQTBUSmVyWTNkR0xSb0lKVnJ5dERKYnpnOG16ZFZR?=
 =?utf-8?B?TXMvZzEraEJpRHRYemtMR3BQMWIrdG52dVo3MlVBZDZKcytHUnBBSGg3akhU?=
 =?utf-8?B?MEpTeXJVa0FoM1V0Q2tDWS9OaS83M0FKWFdyVk53VmoyZEp2SXAxcm9pbHFX?=
 =?utf-8?B?OVpTbS9kTFI4UVpHMWhFbkdSakpxUlBESFh1T0dXRjZaZG54NmJSa3h1enVm?=
 =?utf-8?B?dDljK0VYUFV4bi9acXFmY1VYZ2NEYlRRcVRSVEQzVEdZRXhkcTRIMHJBMEdv?=
 =?utf-8?B?dGx3UWUzUFMzalhhRWFaLzU4YlllWmYrWW5PWXd1MHdMSnJWVXY2UjVRRlZI?=
 =?utf-8?B?SlFZV1ZoYS9SbHBrcXF6NWp0NzRzZngvc3pGQWhVeU10UkcydlAxREdpcVM5?=
 =?utf-8?B?TmUzSHUzdTE5UGRkS1BheG04TitZT2toY2lDdEtBY1VCaXFWVy94U2h5Q0Rh?=
 =?utf-8?B?T2QvN3M0UFFhN3plVlhlQnREUk9Nc09VN3dQSy9iMzR4RFhDRmZzcmdhU3dr?=
 =?utf-8?B?aWl4U0RNNG9FTUZIUzVjZFVkbjZRNFIyOHIzR004amxwNVpQTXhXTDB4eWk1?=
 =?utf-8?B?MWtJZGsvTko1VVhuYjcxQkRmdzhtRUpQeW5WRk9HU2wrRXFFbmwzRS9OTHF1?=
 =?utf-8?B?Y0ZLcTJreXJNVGRoQ01icnhLdS91dFNwT2MyZnBlMFk2bnR5Q09HV0plSWV2?=
 =?utf-8?B?a3R6dGVlcjBIUUpBZjBFeDRaSHZpSXk3MlE5MGpNRVVNTXFYUmx5dXR4bEQ2?=
 =?utf-8?B?emNaRDJFWm54QVVRaFFiclV2K1hLa0d5ODZINEJ6N1NGdFlEWjhpK2hTY0Y0?=
 =?utf-8?B?Sk5yTDBTdTRBT2dZVkN4bE5naWVKWXQ5NXh5YWtBUlFxMEJrZFIvS3Q3d2Fa?=
 =?utf-8?B?TW9XTmdtZ0dsbUNqaTZZdlY0ZSs5QllQR2hXK2REbXFjUWpnajdWM016RDdl?=
 =?utf-8?B?bExHcnEzZWtQTEdTNk5nWE5uV2p2V1ZSOHZVUlFJZno4b1gyc1dNWnMzb0Zt?=
 =?utf-8?B?d0lCMmltWjRSM1RSMWVhMC9tS201TnYycXJXRUhqdFV0U0JaR3ZvbHdMSXJQ?=
 =?utf-8?B?ak9WQUJ2bGJWM2ZPSXRtSmYyNjlibkhqQjcvMUhJUHpvNzMxczVwSnhkRGhr?=
 =?utf-8?B?YmQrUlJjK0UwR1k5NjYraytJM2VRMjJDMC80NWwxSGhqbExmL3JvRUdmOGJi?=
 =?utf-8?Q?tt9OOvboHxe6FdbZ/0pAIQ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa2e539-eb4a-42ab-28cc-08dd7c1eb8fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 13:09:15.0863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpWMhk3R3Gu4/ASO6wPy7o84zD4egCIKt8Gx+oTxbpZdxkzr9OuSDcu3bk0xAc0bDJm5MxKz9O3algqQ3q1PVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4966
X-Proofpoint-ORIG-GUID: khMc-YaqIGlptJPnmRWWEGqQJHxm01kT
X-Proofpoint-GUID: khMc-YaqIGlptJPnmRWWEGqQJHxm01kT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150092

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGluaWNoaXJvIEthd2FzYWtp
IDxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDE1
LCAyMDI1IDE6MTMgUE0NCj4gVG86IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IERhbmllbCBXYWduZXIgPHdhZ2lAa2VybmVs
Lm9yZz4NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBbYnVnIHJlcG9ydF0gYmxrdGVzdHMgbnZtZS8w
NjEgaGFuZyB3aXRoIHJkbWEgdHJhbnNwb3J0DQo+IGFuZCBzaXcgZHJpdmVyDQo+IA0KPiBIZWxs
byBhbGwsDQo+IA0KPiBSZWNlbnRseSwgYSBuZXcgYmxrdGVzdHMgdGVzdCBjYXNlIG52bWUvMDYx
IHdhcyBpbnRyb2R1Y2VkLiBJdCBkb2VzICJ0ZXN0DQo+IGZhYnJpYw0KPiB0YXJnZXQgdGVhcmRv
d24gYW5kIHNldHVwIGR1cmluZyBJL08iLiBXaGVuIEkgcnVuIHRoaXMgdGVzdCBjYXNlIHJlcGVh
dGVkbHkNCj4gd2l0aA0KPiByZG1hIHRyYW5zcG9ydCBhbmQgc2l3IGRyaXZlciBvbiB0aGUga2Vy
bmVsIHY2LjE1LXJjMiwgS0FTQU4gc2xhYi11c2UtDQo+IGFmdGVyLWZyZWUNCj4gaGFwcGVucyBp
biBfX3B3cV9hY3RpdmF0ZV93b3JrKCkgWzFdLCBhbmQgdGhlbiB0aGUgdGVzdCBzeXN0ZW0gaGFu
Z3MuIFRoZQ0KPiBoYW5nDQo+IGlzIHJlY3JlYXRlZCBpbiBzdGFibGUgbWFubmVyLg0KPiANCj4g
SXQgbG9va3MgdGhlIG5ldyB0ZXN0IGNhc2UgcmV2ZWFsZWQgYSBoaWRkZW4gcHJvYmxlbS4gSSBv
YnNlcnZlZCB0aGUgc2FtZQ0KPiBoYW5nDQo+IHdpdGggYSBmZXcgb2xkZXIga2VybmVscyB2Ni4x
NCBhbmQgdjYuMTMuIFRoZW4gdGhlIHByb2JsZW0gaGFzIGJlZW4NCj4gZXhpc3RpbmcgZm9yDQo+
IGEgd2hpbGUuDQo+IA0KPiBBY3Rpb25zIGZvciBmaXggd2lsbCBiZSBhcHByZWNpYXRlZC4gSSdt
IHdpbGxpbmcgdG8gcnVuIHRlc3RzIHdpdGggZGVidWcNCj4gcGF0Y2hlcw0KPiBmb3IgZml4IGNh
bmRpZGF0ZSBwYXRjaGVzLg0KPiANCj4gDQoNCjxzbmlwPg0KDQoNCkhpIFNoaW5pY2hpcm8sDQoN
ClRoYXQgYXBwZWFycyB0byBiZSBhbiBpbnRlcmVzdGluZyBuZXcgdGVzdC4uISBJIGdldCBhbiBp
bW1lZGlhdGUNCidPb3BzJyB3aGVuIHRyeWluZyByeGUgYXMgYW4gYWx0ZXJuYXRpdmUgc29mdHdh
cmUgUkRNQSBkcml2ZXIuDQoNCkknbGwgbG9vayBpbnRvIHNpdy4gTm90IHN1cmUgSSBjYW4gZml4
IGl0IHRoZSBuZXh0IDIgd2Vla3Mgc2luY2UNCk9PTyB0cmF2ZWxpbmcsIGJ1dCB3aWxsIHRyeSB0
byBmaW5kIHNvbWUgdGltZS4NCg0KVGhhbmtzLCBCZXJuYXJkLg0KDQpIZXJlIGlzIHRoZSByeGUg
b29wczoNCg0KWyAgMTA2LjgyNjM0Nl0gcmRtYV9yeGU6IGxvYWRlZA0KWyAgMTA2LjgzMjE2NF0g
bG9vcDogbW9kdWxlIGxvYWRlZA0KWyAgMTA3LjA2Njg2OF0gcnVuIGJsa3Rlc3RzIG52bWUvMDYx
IGF0IDIwMjUtMDQtMTUgMTU6MDM6MDQNClsgIDEwNy4wODEyNzBdIGluZmluaWJhbmQgZW5vMV9y
eGU6IHNldCBhY3RpdmUNClsgIDEwNy4wODEyNzRdIGluZmluaWJhbmQgZW5vMV9yeGU6IGFkZGVk
IGVubzENClsgIDEwNy4wODk2ODNdIGluZmluaWJhbmQgZW5wNHMwZjRkMV9yeGU6IHNldCBhY3Rp
dmUNClsgIDEwNy4wODk2ODddIGluZmluaWJhbmQgZW5wNHMwZjRkMV9yeGU6IGFkZGVkIGVucDRz
MGY0ZDENClsgIDEwNy4yNjQ3NzBdIGxvb3AwOiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJv
bSAwIHRvIDIwOTcxNTINClsgIDEwNy4yNjczNzZdIG52bWV0OiBhZGRpbmcgbnNpZCAxIHRvIHN1
YnN5c3RlbSBibGt0ZXN0cy1zdWJzeXN0ZW0tMQ0KWyAgMTA3LjI3MTI3Nl0gbnZtZXRfcmRtYTog
ZW5hYmxpbmcgcG9ydCAwICgxMC4wLjAuMjo0NDIwKQ0KWyAgMTA3LjMxMjk1N10gQlVHOiBrZXJu
ZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDI4DQpb
ICAxMDcuMzEyOTczXSAjUEY6IHN1cGVydmlzb3IgcmVhZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUN
ClsgIDEwNy4zMTI5NzldICNQRjogZXJyb3JfY29kZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFn
ZQ0KWyAgMTA3LjMxMjk4Nl0gUEdEIDAgUDREIDAgDQpbICAxMDcuMzEyOTkyXSBPb3BzOiBPb3Bz
OiAwMDAwIFsjMV0gU01QIFBUSQ0KWyAgMTA3LjMxMjk5OV0gQ1BVOiAxIFVJRDogMCBQSUQ6IDEy
MyBDb21tOiBrd29ya2VyL3UzMjo0IE5vdCB0YWludGVkIDYuMTUuMC1yYzIgIzEgUFJFRU1QVCh1
bmRlZikgDQpbICAxMDcuMzEzMDA4XSBIYXJkd2FyZSBuYW1lOiBMRU5PVk8gMTBBNlMwNTYwMS9T
SEFSS0JBWSwgQklPUyBGQktURDhBVVMgMDkvMTcvMjAxOQ0KWyAgMTA3LjMxMzAxNl0gV29ya3F1
ZXVlOiByeGVfd3EgZG9fd29yayBbcmRtYV9yeGVdDQpbICAxMDcuMzEzMDMwXSBSSVA6IDAwMTA6
cnhlX21yX2NvcHkrMHg1OC8weDIzMCBbcmRtYV9yeGVdDQpbICAxMDcuMzEzMDQxXSBDb2RlOiA4
MyA3ZiA3YyAwNCA0OSA4OSBmNiA0OCA4OSBkMyA0MSA4OSBjZCAwZiA4NCBmOSAwMCAwMCAwMCA4
OSBjYSBlOCA2OCBmNyBmZiBmZiA4NSBjMCAwZiA4NSA5NSAwMSAwMCAwMCA0OSA4YiA4NCAyNCBm
MCAwMCAwMCAwMCA8ZjY+IDQwIDI4IDAyIDc0IDI4IDQ0IDhiIDQ1IGQ0IDQ0IDg5IGU5IDQ4IDg5
IGRhIDRjIDg5IGY2IDRjIDg5IGU3DQpbICAxMDcuMzEzMDU1XSBSU1A6IDAwMTg6ZmZmZmIwMGI0
MDQ2N2NjOCBFRkxBR1M6IDAwMDEwMjQ2DQpbICAxMDcuMzEzMDYyXSBSQVg6IDAwMDAwMDAwMDAw
MDAwMDAgUkJYOiBmZmZmOGY2NDQzNGY4MDRhIFJDWDogMDAwMDAwMDAwMDAwMDQwMA0KWyAgMTA3
LjMxMzA3MF0gUkRYOiAwMDAwMDAwMDAwMDAwNDAwIFJTSTogZmZmZjhmNjRiOGM5Y2MwMCBSREk6
IGZmZmY4ZjY0YmVmNzhhMDANClsgIDEwNy4zMTMwNzddIFJCUDogZmZmZmIwMGI0MDQ2N2QwMCBS
MDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiBmZmZmOGY2NDQwYjY4ZTAwDQpbICAxMDcuMzEzMDg0
XSBSMTA6IGZmZmZiMDBiNDA0NjdkNTAgUjExOiBmZmZmOGY2NDQwYjY4ZTAwIFIxMjogZmZmZjhm
NjRiZWY3OGEwMA0KWyAgMTA3LjMxMzA5MV0gUjEzOiAwMDAwMDAwMDAwMDAwNDAwIFIxNDogZmZm
ZjhmNjRiOGM5YzgwMCBSMTU6IGZmZmY4ZjY0NDcwZDEwMDANClsgIDEwNy4zMTMwOThdIEZTOiAg
MDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOGY2YjhkYzllMDAwKDAwMDApIGtubEdTOjAw
MDAwMDAwMDAwMDAwMDANClsgIDEwNy4zMTMxMDZdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAw
MCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNClsgIDEwNy4zMTMxMjldIENSMjogMDAwMDAwMDAwMDAw
MDAyOCBDUjM6IDAwMDAwMDA2OWQ4MWEwMDQgQ1I0OiAwMDAwMDAwMDAwMTcwNmYwDQpbICAxMDcu
MzEzMTQ4XSBDYWxsIFRyYWNlOg0KWyAgMTA3LjMxMzE2NF0gIDxUQVNLPg0KWyAgMTA3LjMxMzE3
MF0gIHJ4ZV9yZWNlaXZlcisweDEzMTAvMHgyNmQwIFtyZG1hX3J4ZV0NClsgIDEwNy4zMTMxODBd
ICBkb190YXNrKzB4NmIvMHgxZjAgW3JkbWFfcnhlXQ0KWyAgMTA3LjMxMzE4OV0gIGRvX3dvcmsr
MHhlLzB4MjAgW3JkbWFfcnhlXQ0KWyAgMTA3LjMxMzE5OF0gIHByb2Nlc3Nfb25lX3dvcmsrMHgx
YjMvMHg0MDANClsgIDEwNy4zMTMyMDZdICB3b3JrZXJfdGhyZWFkKzB4MjViLzB4MzcwDQpbICAx
MDcuMzEzMjEyXSAga3RocmVhZCsweDExNi8weDI0MA0KWyAgMTA3LjMxMzIxOF0gID8gX19wZnhf
d29ya2VyX3RocmVhZCsweDEwLzB4MTANClsgIDEwNy4zMTMyMjVdICA/IF9yYXdfc3Bpbl91bmxv
Y2tfaXJxKzB4MTcvMHg0MA0KWyAgMTA3LjMxMzIzM10gID8gX19wZnhfa3RocmVhZCsweDEwLzB4
MTANClsgIDEwNy4zMTMyMzldICByZXRfZnJvbV9mb3JrKzB4M2MvMHg2MA0KWyAgMTA3LjMxMzI0
Nl0gID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTANClsgIDEwNy4zMTMyNTNdICByZXRfZnJvbV9m
b3JrX2FzbSsweDFhLzB4MzANClsgIDEwNy4zMTMyNjBdICA8L1RBU0s+DQpbICAxMDcuMzEzMjYz
XSBNb2R1bGVzIGxpbmtlZCBpbjogbG9vcCByZG1hX3J4ZSBpcDZfdWRwX3R1bm5lbCB1ZHBfdHVu
bmVsIGliX3V2ZXJicyBudm1ldF9yZG1hIG52bWV0IG52bWVfcmRtYSBudm1lX2ZhYnJpY3MgcmRt
YV9jbSBpd19jbSBpYl9jbSBpYl9jb3JlIG52bWVfY29yZSBpcF9zZXQgbmZuZXRsaW5rIHN1bnJw
YyBpbnRlbF9yYXBsX21zciBzbmRfaGRhX2NvZGVjX3JlYWx0ZWsgaW50ZWxfcmFwbF9jb21tb24g
aVRDT193ZHQgc25kX2hkYV9jb2RlY19nZW5lcmljIGlUQ09fdmVuZG9yX3N1cHBvcnQgc25kX2hk
YV9jb2RlY19oZG1pIHg4Nl9wa2dfdGVtcF90aGVybWFsIHNuZF9oZGFfc2NvZGVjX2NvbXBvbmVu
dCBzbmRfaGRhX2ludGVsIGludGVsX3Bvd2VyY2xhbXAgY29yZXRlbXAgc25kX2ludGVsX2RzcGNm
ZyBzbmRfaGRhX2NvZGVjIHJhcGwgc25kX2h3ZGVwIGludGVsX2NzdGF0ZSBzbmRfaGRhX2NvcmUg
c25kX3BjbSBtZWlfbWUgaW50ZWxfdW5jb3JlIHNuZF90aW1lciBpMmNfaTgwMSBtZWkgaTJjX3Nt
YnVzIHNuZCBscGNfaWNoIHNvdW5kY29yZSB4ZnMgY3Npb3N0b3IgaTkxNSBkcm1fY2xpZW50X2xp
YiBpMmNfYWxnb19iaXQgZHJtX2J1ZGR5IHR0bSBkcm1fZGlzcGxheV9oZWxwZXIgZHJtX2ttc19o
ZWxwZXIgY3hnYjQgZTEwMDBlIHNjc2lfdHJhbnNwb3J0X2ZjIGRybSBwdHAgcHBzX2NvcmUgdmlk
ZW8gd21pIGZ1c2UNClsgIDEwNy4zMTMzNDFdIENSMjogMDAwMDAwMDAwMDAwMDAyOA0KWyAgMTA3
LjMxMzM0Nl0gLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tDQpbICAxMDcuMzEz
MzU0XSBSSVA6IDAwMTA6cnhlX21yX2NvcHkrMHg1OC8weDIzMCBbcmRtYV9yeGVdDQpbICAxMDcu
MzEzMzY2XSBDb2RlOiA4MyA3ZiA3YyAwNCA0OSA4OSBmNiA0OCA4OSBkMyA0MSA4OSBjZCAwZiA4
NCBmOSAwMCAwMCAwMCA4OSBjYSBlOCA2OCBmNyBmZiBmZiA4NSBjMCAwZiA4NSA5NSAwMSAwMCAw
MCA0OSA4YiA4NCAyNCBmMCAwMCAwMCAwMCA8ZjY+IDQwIDI4IDAyIDc0IDI4IDQ0IDhiIDQ1IGQ0
IDQ0IDg5IGU5IDQ4IDg5IGRhIDRjIDg5IGY2IDRjIDg5IGU3DQpbICAxMDcuMzEzMzgxXSBSU1A6
IDAwMTg6ZmZmZmIwMGI0MDQ2N2NjOCBFRkxBR1M6IDAwMDEwMjQ2DQpbICAxMDcuMzEzMzg4XSBS
QVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiBmZmZmOGY2NDQzNGY4MDRhIFJDWDogMDAwMDAwMDAw
MDAwMDQwMA0KWyAgMTA3LjMxMzM5Nl0gUkRYOiAwMDAwMDAwMDAwMDAwNDAwIFJTSTogZmZmZjhm
NjRiOGM5Y2MwMCBSREk6IGZmZmY4ZjY0YmVmNzhhMDANClsgIDEwNy4zMTM0MDNdIFJCUDogZmZm
ZmIwMGI0MDQ2N2QwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiBmZmZmOGY2NDQwYjY4ZTAw
DQpbICAxMDcuMzEzNDExXSBSMTA6IGZmZmZiMDBiNDA0NjdkNTAgUjExOiBmZmZmOGY2NDQwYjY4
ZTAwIFIxMjogZmZmZjhmNjRiZWY3OGEwMA0KWyAgMTA3LjMxMzQxOF0gUjEzOiAwMDAwMDAwMDAw
MDAwNDAwIFIxNDogZmZmZjhmNjRiOGM5YzgwMCBSMTU6IGZmZmY4ZjY0NDcwZDEwMDANClsgIDEw
Ny4zMTM0MjZdIEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOGY2YjhkYzllMDAw
KDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDANClsgIDEwNy4zMTM0MzRdIENTOiAgMDAxMCBE
UzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNClsgIDEwNy4zMTM0NDFdIENS
MjogMDAwMDAwMDAwMDAwMDAyOCBDUjM6IDAwMDAwMDA2OWQ4MWEwMDQgQ1I0OiAwMDAwMDAwMDAw
MTcwNmYwDQpbICAxMDcuMzEzNDQ5XSBub3RlOiBrd29ya2VyL3UzMjo0WzEyM10gZXhpdGVkIHdp
dGggaXJxcyBkaXNhYmxlZA0KDQo=

