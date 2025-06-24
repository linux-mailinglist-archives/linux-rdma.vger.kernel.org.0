Return-Path: <linux-rdma+bounces-11567-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3800AE62D9
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 12:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB8C7AD90B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 10:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D428540E;
	Tue, 24 Jun 2025 10:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JNaSwz3N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EBE27A90F;
	Tue, 24 Jun 2025 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762073; cv=fail; b=piUoqkjz19WVhRtzAKdA+SOpQftbNxgz7EKvm1O8c8fZh5GFKqh7vN9dXL+8lCNPAVbrWVeKfqZvxCwphwK7kjmsLfxlztDLm1ig+zATNY5pkUfGuk7gJ2Zm2A+wyT4zaC+OPS4AuN8mffzOm6lEJugSxL5QCbrvRtqcD8FhAOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762073; c=relaxed/simple;
	bh=wGO+i/NMS6Vaip/SXnMdtauX6JnxPpgxX3SqL0zfGbY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Y1VHKfhA2WMAaVhnP+ZrX0dXcWjAmJ8c3rvyZI3EKUmu3QbolM9PBctho+7WKpa9LLzrKflm8Za0Pt2lz4U3sC4KMwFOW0oiywp52KzS9X9cuMy+JrlkFJPss9tVK2SNN5cPBK8TSxHqRuPWJZImiLpQa3UAyM8WUFTZJgumrH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JNaSwz3N; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NMd7G5028450;
	Tue, 24 Jun 2025 10:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wGO+i/
	NMS6Vaip/SXnMdtauX6JnxPpgxX3SqL0zfGbY=; b=JNaSwz3NHViGfMec4Jg6V7
	WtZacHgMAul3qLOgxFwNylWjB+Fw2pO8jXSrA4Fbd7//WfHbzNsxW2O6R/1SFGBV
	LrVx9LY2lq408VFaZ0aFCfh4qZWu6cdrSVBxbEvnixqjTgRmryW9u2CtTMiOT/1a
	d+w0efJzR2q4HYclEMvEkkApc+ihcdivQEfTKq++OuSxb/sfvt5DKA+KfMEHxhXH
	9VzZU6WtWotXUGBNB1MRFsuPib7nbMTXbav7hneXjX3VfV1fMnUCibo8iWCFUPan
	mb00Lvs+tP/xkug+V8Wl4cCC/+FcAXXtuQdOGKKqyd5N15XOZwMvSdPw/6801F0A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tr2m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 10:47:29 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55OAEWFZ029699;
	Tue, 24 Jun 2025 10:47:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tr2kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 10:47:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHdHIhH47sIVuwHmomsrBaKAuAylm5T6+DgKBdw1x3lI6hado/atdOcfycnPXtvfuphjENtNwTc1PxmewT/tA1i0Z5ls/CbmDKb1kYowFmrj7ehQvLUjPssTcNifLjxpussAwpQPMmC2g7HpZ+mtazhLGguO4jeD8+Iv3nn1NH/RJBAHHs19iboU/kxQukkeRn+5SwOfNqXL9kfJNFtO6Q6iXCzf4sk0kX67GA/zr31qsXcHfOtR477XbxJq0+pKLe5AX81tDi6IwTvrDEY21vieb3fUX01Mm6U5F4krC4y37kgBLgISYVgjDVwNMpjeWObiD3DiNqOS4g1B1R5B1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGO+i/NMS6Vaip/SXnMdtauX6JnxPpgxX3SqL0zfGbY=;
 b=xo982cJdQDNangEKjDIMUaNY+kedM8vSJRKwg9hX9ggOHom8OQcEOdSG+P0fxDgdpGj/YBbiSvZklYKQxgRay6T0RrNljSH11wCBNllfHxHfLMlTYwaowZjCLGvdnquGBSXb/ObI2O3DL6NGPJ1F5YsamI/bmSIEmqtDffa4RrYIqlVFNcrXzBsvV4tzpH/T6wE+jb+b3HEpSTfq8K0P0JWQ2ExfYf7bJW5WezH4eNUA6kLHlJSOFlMdZ24tjURfLQhEgLngPQ94mBhpAMvMo4wq7ggAMWMosCbF6R4u257ibxn2Q3iuy3v+dZglOXXx8yIQR5CsAeT98Im2i5Gssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by BY3PR15MB5060.namprd15.prod.outlook.com (2603:10b6:a03:3cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 10:47:26 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::4349:d5ca:1d09:1e40]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::4349:d5ca:1d09:1e40%6]) with mapi id 15.20.8857.025; Tue, 24 Jun 2025
 10:47:25 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Arnd Bergmann <arnd@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon
 Romanovsky <leon@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin
 Stitt <justinstitt@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Showrya M N <showrya@chelsio.com>, Eric Biggers <ebiggers@google.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Thread-Topic: [EXTERNAL] [PATCH] RDMA/siw: work around clang stack size
 warning
Thread-Index: AQHb4diSzFoLQeaGI0+Um+DQap2PNbQSJq3g
Date: Tue, 24 Jun 2025 10:47:25 +0000
Message-ID:
 <BN8PR15MB2513B863DCE33BF222FA6D1B9978A@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <20250620114332.4072051-1-arnd@kernel.org>
In-Reply-To: <20250620114332.4072051-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|BY3PR15MB5060:EE_
x-ms-office365-filtering-correlation-id: 88298226-dc2b-437d-5b5c-08ddb30c81ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXkzZkYvSm1nK3N4S0JubUsvWFVQUGZzeEhETWlXTWRsQ0NVaDFyY0U0dDFq?=
 =?utf-8?B?aHk3WHFWQm1NUXBuYzdaRDJZUHg3c3ROalZka1cwV1FybWtmUEpQbEgrM1Qy?=
 =?utf-8?B?ai9tZU1KcVhIU2JmREVWTHNHZXl6cFpvSmY4TjFPQXpaRGxmdlM3eVI1bDVt?=
 =?utf-8?B?YjQ3RkpoeHpLSjdveSt3bFVqSGxVc1BGd3llcUNoNk91V2E0MEdxcDFEOGFz?=
 =?utf-8?B?UTlFOEhId2syRWVRSkVJWSsyREt5ekJpNXZodVI1a3ZoYk1sb2NSL0JobE80?=
 =?utf-8?B?OHFTMThXaUsvSnpSdXl1RnVyNHc0Y1NzNWpjQ3ZBbk9uTVQwNENrVVdBMHpV?=
 =?utf-8?B?djlTMEo4VzBvZG5EQVVIcThXMGhhdXRXUFFocHZ1VG4vOXR2cVYzRHBEeFkv?=
 =?utf-8?B?aGdDdXhGMkFHcGQ1dVZrYnZINEZsaTdxRmtRVU1JTEhiUmswTmJlbW10WGdz?=
 =?utf-8?B?aFY1Z0dtWU1iT1BsS2lOSFlmWTRXT2ZJT0I1bnJZeDZJS3JmeGJ2KzBvdXJK?=
 =?utf-8?B?eEp2OW5zRXExNkRBOXZnN2JYVVc5dEVYazQ1WXNqamJTS3ozb3M5VlpmUU5q?=
 =?utf-8?B?TkQydEI1N2RTc3AyMTQzRVJNOXZtWXpqYUxjOWtDd0ZpOW9FY0dXQUR2QkxX?=
 =?utf-8?B?Rk4xc1kvSW4zRXZhYnBMNXA4Uit2TzhmVzdMbTgzdnYyY1ZSVSs4T0VzajhY?=
 =?utf-8?B?S0ZqUjhyZ1ExVm1kalZNcmtNai9nSEorQ2lhSll5Q3hnTjB0djBidmI2UGJY?=
 =?utf-8?B?UDVwRVFGRDk3ek1ab0VMVitUOXpZUXQ5RkVQaG5ZS3ljaW4zdG1lMDNMRlVs?=
 =?utf-8?B?WTlPM09mWk10UTZCK2cwUUwvOHNHQk1pM2JIN3FXcE5tYSt1NW1nY1gxU2xU?=
 =?utf-8?B?WWZUWFpUU3IrLzFMQ0J1ZnBXdDB2MmlLUXU2WUNpTnNsZlJ3Q2pTOXRwWTAx?=
 =?utf-8?B?VGkxaG1RVGM1RFpGYTVWaVE1aWpZWmFYbHc5WTIwL1REV0M5VWtWbFBNanhR?=
 =?utf-8?B?MzZFRkVwS2hHNmkydkNFT2dGMy85dmpRbkx1Zm5ES09KdE1CTzY4SzJJWURi?=
 =?utf-8?B?WXVUYUxETEliemV0WXRXL054SHQrSkw3ZlQ0azVWejB3bU9VNXB0U1dmWWlp?=
 =?utf-8?B?RUlNVGw4U08yTW94dUVvS2NvNUlOcU5SYi9Oc210M2Y2TFErald3RnhuYUdL?=
 =?utf-8?B?bzYvdHl3TC9uNGFpZ2RYU3YvTEdMbWlscDhTZU0wbmJtcThYaWFOVXcwUWdl?=
 =?utf-8?B?dFlCOEJMVXBScFhPQXpibVh6WVRFODJqNEVLQ0JKWmFic1VwZ0hua3hTQTVD?=
 =?utf-8?B?Ky9OS1gxbVNXZVNsUXIwUEc4dVdMU1dwamloWEpOTGVDVGJFR29aT3lRVnhB?=
 =?utf-8?B?T3pTRncrTXhzVnlGQkh5SndGRnhLL09MdXljMkVrSHl5NVRhUmUyblVDNC9r?=
 =?utf-8?B?UnErM1gwcEt2SUpxYlcyV1RBYWI0NGdqZjBhM0l3K01iRGV2TEh5TWI2dG5z?=
 =?utf-8?B?SXhBUGJEWnVvOXZ3RVZGa1ZVNURtWnB0WVBBckdMazJMc2NCa2hqcmNnRmZX?=
 =?utf-8?B?VUR6R3lXN1VqL0k1RG5XdDZ6UTVyTTBSWkpYbW9wNzRQa2ZWZXdsWENEcWJ2?=
 =?utf-8?B?Z3cvQnNqaHFxcVo4cFZMWlVWZDc1eG5LcE42STF1Vmh3dmFSSUdaUGxkWmhx?=
 =?utf-8?B?VEpTUWRxNEdyUlhpY2JMTkdCb3ZpMUZZYlRWem4rZjRJcGJxR1pZa2xxb3JJ?=
 =?utf-8?B?eHpzSVBZWXAyZEsvUzhJUUNzdVFmSTJZbmN3NG0ycTlWM3M0ckFsR2xVRExX?=
 =?utf-8?B?cCtla3J6ZFZqR0l3WE96R1JhdUxPM0tYdTZ2ZmRwQzB6c25tV2NzRHJCVWJz?=
 =?utf-8?B?Q0MvSWNaajRjMmZFRmpMVVVFTU5sSFpqdlpEaGVVcm9aVXNBVHVPSGV6NjQ4?=
 =?utf-8?B?WlV0dmJPTFg2Mnd4NWtDdUxOTFovNUFad2hQNVVpQldaSzEvUk9PaWxsaGcw?=
 =?utf-8?Q?HsMPObClJt2k5fB2IQbO7BFcYeyYmE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmFXUHBTb3RpWS92aVUxdXJMalJueUR6cHk5UFNHdC9EZTYrL3FYS0dxcHI2?=
 =?utf-8?B?YncrTGFjUEdZTVZ5aTN5cW5zM25ndFE2bDhCUEVRTmpPZjBtYnRNNDEwdzFG?=
 =?utf-8?B?UXFjTVc0VmFGVWF2bG9NWm9ueXZPamM1N1gzZUFYY0s4cWpkU2xUaW4razk3?=
 =?utf-8?B?U1lVSUZWNjM3QkZFQnZzWWhkRHNoSjB0b0tLWEF6NjkzYTV4OE9acFEwODBB?=
 =?utf-8?B?YzhOSHRQWUdiazNzdUpsQ2VoQU1RQWlJNVI3NUNpaTJJVmx0WEQ4eVBYc0xo?=
 =?utf-8?B?enU0WkRjR0xtcnJVRTdOclNFNndibmcxNlV6MVVMNm1Wbkd3TWsxalJtQjhO?=
 =?utf-8?B?VW1IWmcxaElYVmRyaVlubjR3T0ZiZTljMFEwK1ZaVWtYclZWNTRHUitFZU9C?=
 =?utf-8?B?Zngra1pDYkZBR09uV3hGdzFLRjZyRXJkS2dkbFowbmhCWG9OMm8vZmpKVmZD?=
 =?utf-8?B?b2diTnlVckFYc2Z2Snp1b2tBTkFrV3pwOG45SzZ0bzhBcjdnb1pHbko4UDZi?=
 =?utf-8?B?UC9IWE1IRzRvbU1vZTdhTnJCN3J2QkNxU003NVN2N0h5b3ZGc1QzYUxQR0p3?=
 =?utf-8?B?cEkwNWlKalYxK3huV3UyYlc2VFp2ZHFHbFg1Qit3d1RrYVNqVDVrYm1JaC9H?=
 =?utf-8?B?YmFhMktCbHFkTlp5Q3FDbWtaRUdaQVZVSUdGbWgvOTRKeEFrcTQwdXVVRy80?=
 =?utf-8?B?OUJmZEJQQ1hPZDVkVzFBZSs3V2Y3UzJqU3pCTXZJR0JrUW1Gd1NtZmlqV1Mz?=
 =?utf-8?B?K1d0VHU1aWJYSFBFVEFucTcxVitCdTZNNGJTTW0rczRuNDZFQ1dZY0NrSzVH?=
 =?utf-8?B?V1JXeFZjMFZxdk5DS2poZklTWHlNYWJsRWxyc1FsUWhSa0NPbHlCUEM2d1hR?=
 =?utf-8?B?Sklvd1ljRHN0L2kwR3k2ZkdZL2I2dkIrakdTazdZaG94QnkvaHgvY2lyMkFv?=
 =?utf-8?B?bXlrVk5hSDNDTjh0akpnbVFEQnZPSHU1RXczRVB2MG0xc0xVS1RHVDdiTmIx?=
 =?utf-8?B?K2tMeDFOVXVRaFJlUmFaSUZPOHZ6Mm1TZnExMXppWTk0NGV0ZnhHTzdLQ2hB?=
 =?utf-8?B?M2JYWVk5UldFNDJPS09MYmJUNEtiREIzWlF4YTVlSU5kelFPcEZ4MW5qUnVU?=
 =?utf-8?B?dmlIL1FpTTR5THBxelhudmZyZEpuMUhmUnFkWnJQb01mczRabFlCTVlTeXVk?=
 =?utf-8?B?UXYwWXFheCtLVkVibENoR1V3S3JhRWN3eG1YZGQ4UXVRcVBlSDNQMnBKS0NZ?=
 =?utf-8?B?V3kwQWlIbnR5L1A5MDhZby8rUkg0TkNPWGRTNmJPQVEweitncVMreitwb1NT?=
 =?utf-8?B?dXBFNEJUcTJDTXJ0TTFTU0ZlcHVRaWMrK2VseHdySlgxcjNNa3puVzdRanhP?=
 =?utf-8?B?SmhKYVFlbUtSZHZ0MmdCd3FPNTV3NzQ2YklMYUF1cVM1Q2NwTWluckFNNmYv?=
 =?utf-8?B?eGI2c3FZeExtenVOZ0VPRUtsU2E1YWdjNXV6S3YrREE5dWk4NktnU3dYcWlh?=
 =?utf-8?B?V2VScEhxUkVtK203ZGJ2Ymh2UnhlQ0NSc2pGQXJEMmNhVTJyVXNJa3h1K2hN?=
 =?utf-8?B?cS9UQUZDeklDSDE2STNNY2NzS3JzMVBjV25ITWpXbGJ0M09vcTkwVXBNTmdz?=
 =?utf-8?B?a1Fab3l0UWV4UEFNRW9ueTBJM3pVMTArSHFFeGZra3pVZ2NjWVF2QlpuaHlo?=
 =?utf-8?B?aG5Dd0VSZS8xMGJpMm4wRU1yTVo5TjR3UTAzTW9rWC9CMm1OODVNWWdQWGxX?=
 =?utf-8?B?dmd6VXhpbUNRbVRjTXJxL1RoSklsMDlxKzdDTlBXaWU5Umc5MVJIeXhuRU50?=
 =?utf-8?B?b3kxTnF5cnQ1eHpwRitJMTR6OTVUbzZrZjZMa0RWVFRldUdjZzVERURreDRo?=
 =?utf-8?B?YVNWS3ZxL0R6RElzN0lTRVlOMVhacEZycWxCTFZEL0Rid0Q5bm9rTWw0RUpi?=
 =?utf-8?B?NUd6TVh2N1o1dVFJdzlrbk90MVdkMkwvV1lJSzdTVk5Lamh1ZmVvMHQyaTg2?=
 =?utf-8?B?TnR4NnNRYnVvM3BxVDZPZGdaRTMxbEhkMGpRL3duOHI5NnhOY0JLQkdVeEJI?=
 =?utf-8?B?QlRxTlluclkwTUdhMWRhZXd1aWV0bng5N2ROZWYwYWNyeWprY0tTdzRDOXd2?=
 =?utf-8?B?cGk2a2FYNkNHSUQvZTd6RlBOZVhIb2NGZnNldWdkZ3B0SjR6Wm9OU09SbWs0?=
 =?utf-8?Q?abaYSmo9NM9VKums4nk8NF8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 88298226-dc2b-437d-5b5c-08ddb30c81ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 10:47:25.7344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJL7UXEqxw9CogaqwAUaBjIexatGNBYJnjQBIg3f7qLimWkrvssTN6RIBzWdAdrDPcnOpSLXrpmJLW91igy6PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5060
X-Proofpoint-ORIG-GUID: 3QE09vVNE-5px0YeohstI_9HFdAEoFLb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA4NyBTYWx0ZWRfX005Eds6U8VtW y+dsGzWKbKScq5fAhQxY7ZpAfHRSb3xTtPUXoFzU/S4+dMZY8ow97W6usKRaNH+d3F8+JO74t9D XFk+Y8WlWwBvTbKvwg/VFxkZs8tbOn00ENp79auGrWIjIQzmi9FJd2k24WEfGLbxMiGo0YG1iFU
 TWal28c47iZzGntFf/XoQC7yNya03/W5BDYgDViVTPI6YsDxh/41VGd0iqQbosT6TRXMtd66oVi vw4y7B5v4dhn7bcQwvASs0GGKOjx131LWDpOXUrdlduKlMIkV+1/tb6sZx5ayn98mNDC2vnk6SC 89xV7Qpbfg7N/Zs9KOovt9RCPeDKPIa6rLJvEbgDV5dpKsdxKY4lL6XBgz0huJwzY5P8kiMd8SW
 lSfBfoZzsz1YFHytCMFyZJukpvqjN8HVfRHbj6Q9T6KmJZKms735WCQx2NqsiwsNTBRUAVqQ
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=685a8241 cx=c_pps a=kfSuSaS5NlyHnrYV7DsYBg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=9jRdOu3wAAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=AGRr4plBAAAA:8 a=gGV8i3XfQ_SMCS_xEkwA:9 a=QEXdDO2ut3YA:10 a=ZE6KLimJVUuLrTuGpvhn:22 a=bOnWt3ThIoLzEnqt84vq:22
X-Proofpoint-GUID: X8Q4K7E2DzaIFOYOlhGXWJriLEwT4lPX
Subject: RE:  [PATCH] RDMA/siw: work around clang stack size warning
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240087

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8
YXJuZEBrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIEp1bmUgMjAsIDIwMjUgMTo0MyBQTQ0K
PiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBKYXNvbiBHdW50aG9y
cGUgPGpnZ0B6aWVwZS5jYT47DQo+IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPjsg
TmF0aGFuIENoYW5jZWxsb3IgPG5hdGhhbkBrZXJuZWwub3JnPg0KPiBDYzogQXJuZCBCZXJnbWFu
biA8YXJuZEBhcm5kYi5kZT47IE5pY2sgRGVzYXVsbmllcnMNCj4gPG5pY2suZGVzYXVsbmllcnMr
bGttbEBnbWFpbC5jb20+OyBCaWxsIFdlbmRsaW5nIDxtb3Jib0Bnb29nbGUuY29tPjsgSnVzdGlu
DQo+IFN0aXR0IDxqdXN0aW5zdGl0dEBnb29nbGUuY29tPjsgUG90bnVyaSBCaGFyYXQgVGVqYSA8
YmhhcmF0QGNoZWxzaW8uY29tPjsNCj4gU2hvd3J5YSBNIE4gPHNob3dyeWFAY2hlbHNpby5jb20+
OyBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGdvb2dsZS5jb20+Ow0KPiBsaW51eC1yZG1hQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGx2bUBsaXN0cy5s
aW51eC5kZXYNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBbUEFUQ0hdIFJETUEvc2l3OiB3b3JrIGFy
b3VuZCBjbGFuZyBzdGFjayBzaXplIHdhcm5pbmcNCj4gDQo+IEZyb206IEFybmQgQmVyZ21hbm4g
PGFybmRAYXJuZGIuZGU+DQo+IA0KPiBjbGFuZyBpbmxpbmVzIGEgbG90IG9mIGZ1bmN0aW9ucyBp
bnRvIHNpd19xcF9zcV9wcm9jZXNzKCksIHdpdGggdGhlDQo+IGFnZ3JlZ2F0ZSBzdGFjayBmcmFt
ZSBibG93aW5nIHRoZSB3YXJuaW5nIGxpbWl0IGluIHNvbWUgY29uZmlndXJhdGlvbnM6DQo+IA0K
PiBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jOjEwMTQ6NTogZXJyb3I6IHN0
YWNrIGZyYW1lIHNpemUNCj4gKDE1NDQpIGV4Y2VlZHMgbGltaXQgKDEyODApIGluICdzaXdfcXBf
c3FfcHJvY2VzcycgWy1XZXJyb3IsLVdmcmFtZS1sYXJnZXItDQo+IHRoYW5dDQo+IA0KPiBUaGUg
cmVhbCBwcm9ibGVtIGhlcmUgaXMgdGhlIGFycmF5IG9mIGt2ZWMgc3RydWN0dXJlcyBpbiBzaXdf
dHhfaGR0IHRoYXQNCj4gbWFrZXMgdXAgdGhlIG1ham9yaXR5IG9mIHRoZSBjb25zdW1lZCBzdGFj
ayBzcGFjZS4NCj4gDQo+IElkZWFsbHkgdGhlcmUgd291bGQgYmUgYSB3YXkgdG8gYXZvaWQgYWxs
b2NhdGluZyB0aGUgYXJyYXkgb24gdGhlDQo+IHN0YWNrLCBidXQgdGhhdCB3b3VsZCByZXF1aXJl
IGEgbGFyZ2VyIHJld29yay4gQWRkIGEgbm9pbmxpbmVfZm9yX3N0YWNrDQo+IGFubm90YXRpb24g
dG8gYXZvaWQgdGhlIHdhcm5pbmcgZm9yIG5vdywgYW5kIG1ha2UgY2xhbmcgYmVoYXZlIHRoZSBz
YW1lDQo+IHdheSBhcyBnY2MgaGVyZS4gVGhlIGNvbWJpbmVkIHN0YWNrIHVzYWdlIGlzIHN0aWxs
IHNpbWlsYXIsIGJ1dCBpcyBzcHJlYWQNCj4gb3ZlciBtdWx0aXBsZSBmdW5jdGlvbnMgbm93Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jIHwgMjIgKysrKysrKysr
KysrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfcXBfdHguYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4g
aW5kZXggNjQzMmJjZTdkMDgzLi4zYTA4ZjU3ZDIyMTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3Npdy9zaXdfcXBfdHguYw0KPiBAQCAtMjc3LDYgKzI3NywxNSBAQCBzdGF0aWMgaW50IHNp
d19xcF9wcmVwYXJlX3R4KHN0cnVjdCBzaXdfaXdhcnBfdHgNCj4gKmNfdHgpDQo+ICAJcmV0dXJu
IFBLVF9GUkFHTUVOVEVEOw0KPiAgfQ0KPiANCj4gK3N0YXRpYyBub2lubGluZV9mb3Jfc3RhY2sg
aW50DQo+ICtzaXdfc2VuZG1zZyhzdHJ1Y3Qgc29ja2V0ICpzb2NrLCB1bnNpZ25lZCBpbnQgbXNn
X2ZsYWdzLA0KPiArCSAgICBzdHJ1Y3Qga3ZlYyAqdmVjLCBzaXplX3QgbnVtLCBzaXplX3QgbGVu
KQ0KPiArew0KPiArCXN0cnVjdCBtc2doZHIgbXNnID0geyAubXNnX2ZsYWdzID0gbXNnX2ZsYWdz
IH07DQo+ICsNCj4gKwlyZXR1cm4ga2VybmVsX3NlbmRtc2coc29jaywgJm1zZywgdmVjLCBudW0s
IGxlbik7DQo+ICt9DQo+ICsNCj4gIC8qDQo+ICAgKiBTZW5kIG91dCBvbmUgY29tcGxldGUgY29u
dHJvbCB0eXBlIEZQRFUsIG9yIGhlYWRlciBvZiBGUERVIGNhcnJ5aW5nDQo+ICAgKiBkYXRhLiBV
c2VkIGZvciBmaXhlZCBzaXplZCBwYWNrZXRzIGxpa2UgUmVhZC5SZXF1ZXN0cyBvciB6ZXJvIGxl
bmd0aA0KPiBAQCAtMjg1LDEyICsyOTQsMTEgQEAgc3RhdGljIGludCBzaXdfcXBfcHJlcGFyZV90
eChzdHJ1Y3Qgc2l3X2l3YXJwX3R4DQo+ICpjX3R4KQ0KPiAgc3RhdGljIGludCBzaXdfdHhfY3Ry
bChzdHJ1Y3Qgc2l3X2l3YXJwX3R4ICpjX3R4LCBzdHJ1Y3Qgc29ja2V0ICpzLA0KPiAgCQkJICAg
ICAgaW50IGZsYWdzKQ0KPiAgew0KPiAtCXN0cnVjdCBtc2doZHIgbXNnID0geyAubXNnX2ZsYWdz
ID0gZmxhZ3MgfTsNCj4gIAlzdHJ1Y3Qga3ZlYyBpb3YgPSB7IC5pb3ZfYmFzZSA9DQo+ICAJCQkJ
ICAgIChjaGFyICopJmNfdHgtPnBrdC5jdHJsICsgY190eC0+Y3RybF9zZW50LA0KPiAgCQkJICAg
IC5pb3ZfbGVuID0gY190eC0+Y3RybF9sZW4gLSBjX3R4LT5jdHJsX3NlbnQgfTsNCj4gDQo+IC0J
aW50IHJ2ID0ga2VybmVsX3NlbmRtc2cocywgJm1zZywgJmlvdiwgMSwgaW92Lmlvdl9sZW4pOw0K
PiArCWludCBydiA9IHNpd19zZW5kbXNnKHMsIGZsYWdzLCAmaW92LCAxLCBpb3YuaW92X2xlbik7
DQo+IA0KPiAgCWlmIChydiA+PSAwKSB7DQo+ICAJCWNfdHgtPmN0cmxfc2VudCArPSBydjsNCj4g
QEAgLTQyNywxMyArNDM1LDEzIEBAIHN0YXRpYyB2b2lkIHNpd191bm1hcF9wYWdlcyhzdHJ1Y3Qg
a3ZlYyAqaW92LA0KPiB1bnNpZ25lZCBsb25nIGttYXBfbWFzaywgaW50IGxlbikNCj4gICAqIFdy
aXRlIG91dCBpb3YgcmVmZXJlbmNpbmcgaGRyLCBkYXRhIGFuZCB0cmFpbGVyIG9mIGN1cnJlbnQg
RlBEVS4NCj4gICAqIFVwZGF0ZSB0cmFuc21pdCBzdGF0ZSBkZXBlbmRlbnQgb24gd3JpdGUgcmV0
dXJuIHN0YXR1cw0KPiAgICovDQo+IC1zdGF0aWMgaW50IHNpd190eF9oZHQoc3RydWN0IHNpd19p
d2FycF90eCAqY190eCwgc3RydWN0IHNvY2tldCAqcykNCj4gK3N0YXRpYyBub2lubGluZV9mb3Jf
c3RhY2sgaW50IHNpd190eF9oZHQoc3RydWN0IHNpd19pd2FycF90eCAqY190eCwNCj4gKwkJCQkJ
IHN0cnVjdCBzb2NrZXQgKnMpDQo+ICB7DQo+ICAJc3RydWN0IHNpd193cWUgKndxZSA9ICZjX3R4
LT53cWVfYWN0aXZlOw0KPiAgCXN0cnVjdCBzaXdfc2dlICpzZ2UgPSAmd3FlLT5zcWUuc2dlW2Nf
dHgtPnNnZV9pZHhdOw0KPiAgCXN0cnVjdCBrdmVjIGlvdltNQVhfQVJSQVldOw0KPiAgCXN0cnVj
dCBwYWdlICpwYWdlX2FycmF5W01BWF9BUlJBWV07DQo+IC0Jc3RydWN0IG1zZ2hkciBtc2cgPSB7
IC5tc2dfZmxhZ3MgPSBNU0dfRE9OVFdBSVQgfCBNU0dfRU9SIH07DQo+IA0KPiAgCWludCBzZWcg
PSAwLCBkb19jcmMgPSBjX3R4LT5kb19jcmMsIGlzX2t2YSA9IDAsIHJ2Ow0KPiAgCXVuc2lnbmVk
IGludCBkYXRhX2xlbiA9IGNfdHgtPmJ5dGVzX3Vuc2VudCwgaGRyX2xlbiA9IDAsIHRybF9sZW4g
PSAwLA0KPiBAQCAtNTg2LDE0ICs1OTQsMTYgQEAgc3RhdGljIGludCBzaXdfdHhfaGR0KHN0cnVj
dCBzaXdfaXdhcnBfdHggKmNfdHgsDQo+IHN0cnVjdCBzb2NrZXQgKnMpDQo+ICAJCXJ2ID0gc2l3
XzBjb3B5X3R4KHMsIHBhZ2VfYXJyYXksICZ3cWUtPnNxZS5zZ2VbY190eC0+c2dlX2lkeF0sDQo+
ICAJCQkJICBjX3R4LT5zZ2Vfb2ZmLCBkYXRhX2xlbik7DQo+ICAJCWlmIChydiA9PSBkYXRhX2xl
bikgew0KPiAtCQkJcnYgPSBrZXJuZWxfc2VuZG1zZyhzLCAmbXNnLCAmaW92W3NlZ10sIDEsIHRy
bF9sZW4pOw0KPiArDQo+ICsJCQlydiA9IHNpd19zZW5kbXNnKHMsIE1TR19ET05UV0FJVCB8IE1T
R19FT1IsICZpb3Zbc2VnXSwNCj4gKwkJCQkJIDEsIHRybF9sZW4pOw0KPiAgCQkJaWYgKHJ2ID4g
MCkNCj4gIAkJCQlydiArPSBkYXRhX2xlbjsNCj4gIAkJCWVsc2UNCj4gIAkJCQlydiA9IGRhdGFf
bGVuOw0KPiAgCQl9DQo+ICAJfSBlbHNlIHsNCj4gLQkJcnYgPSBrZXJuZWxfc2VuZG1zZyhzLCAm
bXNnLCBpb3YsIHNlZyArIDEsDQo+ICsJCXJ2ID0gc2l3X3NlbmRtc2cocywgTVNHX0RPTlRXQUlU
IHwgTVNHX0VPUiwgaW92LCBzZWcgKyAxLA0KPiAgCQkJCSAgICBoZHJfbGVuICsgZGF0YV9sZW4g
KyB0cmxfbGVuKTsNCj4gIAkJc2l3X3VubWFwX3BhZ2VzKGlvdiwga21hcF9tYXNrLCBzZWcpOw0K
PiAgCX0NCj4gLS0NCj4gMi4zOS41DQoNCmxvb2tzIGdvb2QgYW5kIHdhcyB0ZXN0ZWQuDQoNCkFj
a2VkLWJ5OiBCZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCg==

