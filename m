Return-Path: <linux-rdma+bounces-10119-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA33AAE25A
	for <lists+linux-rdma@lfdr.de>; Wed,  7 May 2025 16:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6047BC759
	for <lists+linux-rdma@lfdr.de>; Wed,  7 May 2025 14:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17662B9CD;
	Wed,  7 May 2025 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pt0+NKv4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763B28A72F;
	Wed,  7 May 2025 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626697; cv=fail; b=eBQ8AaJ+8Hd4xaty+kcPz9hixjQIONkw2cB90gWCDhZPwoPq0WFWvuJrfhJo+TGCgTxVePRW5T10rYkNRj7ez+/sD7lBa0bFwciGSq0jMrwA3YpHkPLPqKU5z/BjLexSDh2fLskOHSAvtCKoLCnKgSKj2Hvbr+f71uhcpsCaWag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626697; c=relaxed/simple;
	bh=ZIzQ5ydMKEoDiDP36v72p5Q4IJI9Wnys15PXncb6yVo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=o5Hx1jV5I1oEmBZKeTDz+w1WegGSbqd9PaQsZOEV5JNdHRPkclShmlrwAptBudBNWxJ78Dc8DmeJdcj456qgDTYktMsPxXCqMSNv/oIg1iAnJlZQ/dyrvKWiNtL0isy/IdKlCDUjVYpglXUXswokOhH2bvvRA8kLq8iYSqDCBf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pt0+NKv4; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547BJHZA016852;
	Wed, 7 May 2025 14:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZIzQ5y
	dMKEoDiDP36v72p5Q4IJI9Wnys15PXncb6yVo=; b=pt0+NKv4Z6awS478ohB+Tt
	eCEcJuIj7kcgjNLuuTfNn41kTkw1QfZUCj2JEd+0ewieNlP+Hdtws1vQoci0Kj6J
	mJYN6GUD1iWBdY04G5dNCixGq0j7WaJwrGCpQJUCuLuiT9mXYFMQPTPqn9D9/6co
	obQMKzeqMV9qtdhZ9tzwPucruMkOMpQb/gyFVvxBAGQvyDXvNdQHQRNEgHzVW7C9
	MIeOnNQt4g5E1dkDsdPzVFWQvuUTcQDC9KDbFbRjck8Fh+5DR2NEMepxNOadUAON
	+pG3rIt80LqtKJv1W8eUDa2cUesGOuxxy4//HRg6kyVNLL+WQq1mJTn8UPKBvG4w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fvd0kgps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 14:04:45 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 547DTrPl026583;
	Wed, 7 May 2025 14:04:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fvd0kgpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 14:04:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4q302S6QQOUKCs/P/32aag/cI30P6a0PY6IISbujbTAbofkE7zPMg2GKSUGFOEu53IzIJjsJLSpWvrqOYOnqmwBnxSPa8KbC+9xqkIfUyykTr8yJSnUXfA218a+64KbWJmzXAHGpJ0Fm0sCrlnwwtvOBSARWu/0lQe3s4UGHeAsLLMEPGJk4k7qL5SbY9WtXJrOBm2EYc5HoMZdQaP+1FpZZa184mj/xhKTLDDu4tr+54ZwyxNjwXCGH1JC1pKYa6ZXkGLTDwuYudH4CuI3N2MzQEZjOV2Ty3CERXJn3/j0Py8iAWAhvY0zmOcfur0IHXAxWoRPI0Bd1MiBizO61w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIzQ5ydMKEoDiDP36v72p5Q4IJI9Wnys15PXncb6yVo=;
 b=BTMi6ncr+L2xSVZGwndVI3cjl7xxSxmfRFMZggOi2B+KhqP46X1GVtV4IkbpofMzStf2aF8ug3FCywVVAzZGqQvS4qIpOOfpSPB0MNVlqrzsWuy3MXPI5/aK9X9sPFXzV5lpLiuAhNtwsKeSNr+gTgSei8vR4hCdcAfTvJEqy+f1/PjePwhFQgoC25E8sxFOreKrow+s4xbxfAYw3GXOWHDy0x6M1pEFiamCBj+n7JzOzC/SaayZvsXbbtuuItJe0bOhQOM6LGvvshI1v2ptilX4V45RY7Do0BTP8GN07tAa1TbVjvTqaX0fxH2ZvFBZk1H71AB/dI7kM2WkPH2+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0SPRMB0005.namprd15.prod.outlook.com (2603:10b6:806:152::20)
 by DM4PR15MB5332.namprd15.prod.outlook.com (2603:10b6:8:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 14:04:36 +0000
Received: from SA0SPRMB0005.namprd15.prod.outlook.com
 ([fe80::2572:f04:ba6b:3dd]) by SA0SPRMB0005.namprd15.prod.outlook.com
 ([fe80::2572:f04:ba6b:3dd%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 14:04:36 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Colin Ian King <colin.i.king@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH][next] RDMA/siw: replace redundant ternary
 operator with just rv
Thread-Index: AQHbv1KUy7MDdQo0Z0+4/6nswOirerPHMujQ
Date: Wed, 7 May 2025 14:04:36 +0000
Message-ID:
 <SA0SPRMB00053E316F50D2A70B37E3A89988A@SA0SPRMB0005.namprd15.prod.outlook.com>
References: <20250507131834.253823-1-colin.i.king@gmail.com>
In-Reply-To: <20250507131834.253823-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0SPRMB0005:EE_|DM4PR15MB5332:EE_
x-ms-office365-filtering-correlation-id: 7bc2298c-65d1-4694-76b9-08dd8d7019e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWdaQTFESkpBcVR2ekJoczFVSm1qQVJYdWl6RFQyYjFnYlhlZDRaUUdlc0Nh?=
 =?utf-8?B?c1V3KzNMaWc0M3J1d2ppbE9QVmE4MW4xQUhicTRlT1V5OE1MUUNna1U4ckx0?=
 =?utf-8?B?Vk4wa3N2OFpjOUhtbFFHSkFNZks5WWgxMG55NDduTU0xUHFCVHBTRzZaMmVx?=
 =?utf-8?B?ZE5wbWdRSFJRMzRIUmMyS1BNRmIvb0duQTFPVmFIaHU2amtZUzczc1lCNkU3?=
 =?utf-8?B?OTlPSzByV1lRU2JjdDlXeDJvRDNpQ2F2RXowUzJkTXRNd0F2TDBzRm9IR2xL?=
 =?utf-8?B?WTBTVkxwanpIdmxva0Y4MVpzbTREN0U4cTVhVEdIV0tnYlJ5MHJISHpoRk4z?=
 =?utf-8?B?RmRxcU5mdkpzU0NEa2NjOTE4dHVMZXpQS1hKZHZrMXJNdUY2WUR4aDlxcHhi?=
 =?utf-8?B?bDd4MjhKVHdndGJZSmVGVlRMWC9jV1l6MjdPYXJJa3o0QTNTc2F4YisxSHJK?=
 =?utf-8?B?VTF6RWVyQ3NSY0tyanVpaTdWbnArYlc0azV2N2RPbU9HTE9MTUxPQS9vWDRs?=
 =?utf-8?B?c1lUTWxtem4vYWh6Tll1b2EweUxpWk1YWDhIZEEzbHVTWlRvdnViUXNFbUtD?=
 =?utf-8?B?c1F6Ti9ZZkZIZ2Q1MlNTdGlwbXBiNWNwSmdyN1IzN2g4T0xmdjgxaEJUNWJw?=
 =?utf-8?B?bDZPMWwvc0VzdjlMR0hEb0w2eWZaNmdhSForOWZmeXFkOHJScDBoZS9qMVow?=
 =?utf-8?B?Z29RdkJYRjRqUkh6N05pNVIxMUtZb3N6dEVDZHR6OXY4dTcydndGNjg4dXpD?=
 =?utf-8?B?M0dGTHE4VVMwa1RpaVozemVGUWpFUkRnUlI1cTZlbnp2L002a1R5aDZHdFhJ?=
 =?utf-8?B?TTltamZFQXZuY05yMnRJcnFlcmx2clY0YWUrNkFvc0ovSGViVHFSVm5GYU1z?=
 =?utf-8?B?OU83UTNDV3VoWVc4Q0JUNURMVHhyRVVnR0U5RHBiclp0YzIxY1BKNzAyaVgz?=
 =?utf-8?B?YlVnUTdIWDBNWmdZaDNsSlRnbGxacmZwcmRxUnBKMFdZQkZMRURuN1djSXk1?=
 =?utf-8?B?eUcxY1k1WTNoVXBRaG40aE9hTE1HUWRWY0RHNTdYR3MyS1ZJWjhPcHE1eXA0?=
 =?utf-8?B?OHA1bUlxaEtIeDNmdmRaQjRDRWQ2TmJqRlVxRkQrN0JrT1ZuRFVKZmszVHNq?=
 =?utf-8?B?dXhsVk1yRzh1RVJKNmF5aURyalAwcVo5aEg1aHU2U0ZTQUkyMm1LbWtpa1ZK?=
 =?utf-8?B?WlgzMDVIZ1VWT2wwNmhWbDB4OW5PUm1XWFRSSExrYmRDV0h6MEpleHdPWmRl?=
 =?utf-8?B?c3pLcWVXWVpva09UZnh1b3RMSXhOdkphclF2bmxkYzlxRWFudkNEKzM3dmU5?=
 =?utf-8?B?VDdQT1ArL2V3TjNKYzUvc0lrWTFqaE5zMXYzaHFyNHZUNG1NY2dGekg0K0cw?=
 =?utf-8?B?eW5yYThsWjlMb09rbnNSQ0tNSlRzMGU2ZlgzaDVRMGNVNG95ZXZKL2pEd3Az?=
 =?utf-8?B?dlp2WkRBZnVHTnhmaTQyNXdoSzhlTlNiUkV6R05qQXJZMlFYNDVPaVVxVnVZ?=
 =?utf-8?B?d2UvRXRmT1QrdEZlSmY2c2pxM3ZiUEh6Qk5FY0svRnhtMnFkRCtDYjdOREcx?=
 =?utf-8?B?UVE2Z0c3bFJ3SzlFT2kvQ3RDbWNiTzdKcFdVVlVucFM1ZHlNQi8xbGt6dEZI?=
 =?utf-8?B?b1VyVzBtY0xTbkFOdmszZFRMNkRZZUZKQ3grUTlIWmNaelNmRUJkcjVPalNw?=
 =?utf-8?B?YkY0MzFNOUZsZXJpbTUvcFo0QUlRM0ZaS3l0WmUvR0xCQzl1ajFucHpNUThO?=
 =?utf-8?B?aVVDNUxiclhFQThTaTZtYlozazBzQXFNVWZWRmtpTDBMb3hVb3owTHl5Uk9R?=
 =?utf-8?B?QjdXdzVFWk1Ka3M2RHlMNkpKbVNuWngyY0xicG1UQUNCL2I0U1NFNGJDUDFi?=
 =?utf-8?B?UWNka0FtK2thUDVzTzNKK0VPLzlUSS8rU1pSNTkrVWk1SmlVK1QxUHdFWlZu?=
 =?utf-8?B?V1dzMFRDcjhqeUYweUdwbG1UWEk5RUZpcWpFWVBWdTdFUHA1VytqRy92ZHYw?=
 =?utf-8?B?QkhEcnZDSU1BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0SPRMB0005.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUk4R0theFRHdk9ZSWNMMWFPRnZjbEdGa2xEbFNJSFUrdkMvWVpnQWVTL2ZN?=
 =?utf-8?B?OFN4V0hoV0RnNVBLaU9sN1JwODBZSnZRbmxkbXdNY2ppVEkrKzZraUdiK0d4?=
 =?utf-8?B?VFRRdXVWZEtEeVVrUmRCdUpUOTFJNmZENEtWZ1RDUEw1NkYyMVh4YUg5Vk0r?=
 =?utf-8?B?bW9sNW1PQ3JCblpiUVB2L2czdzZrbTVjaURLOW1ab3dhQkNBa2NodlNLMjd4?=
 =?utf-8?B?VlltRi8wRlVhRmpwRXdGblAzeHhXdjZ0QWpuZFRPYWt0TnU4QTJGeFdIM3l4?=
 =?utf-8?B?VjF1UXNjM2RLT3VaMkxhbThsYlhwSFRpQ3hKS0ZLajI1Q3BsOHBDbWYxa1lW?=
 =?utf-8?B?M0c5U2dFU0FlMnhVVWtWM2dhUWtBVXJLVkRhT0lweHlIZE9SMXpySnRTeE1m?=
 =?utf-8?B?c01TcGtiZjNuUmh0Y3JVZFJLZWFCeUNuQXpPWmpXNXVSVXowb245Q1I2UEs3?=
 =?utf-8?B?alZkYjJDb21Xd1ExaEVyMHRWSlc1ZC9MZlJHbXI2ZCtLMUFhQ0xPY3dWQUZv?=
 =?utf-8?B?dThxTzlpOERJeGlyeUh2SjMrcjVFL1dXaEpvMmpKODErM21NTVJLeU9KbW1i?=
 =?utf-8?B?SERiVnhXNkx4cHh1bjhMYk9LSFVzWm5SVDZwNDVvVklQMEVpRmtPOUY3RHNn?=
 =?utf-8?B?YUdPSlgvMHBJK0ZNR2pzZzFhRXVTVloxK3Nrb2M5T1lyR1FXTmxWUmpISVdN?=
 =?utf-8?B?eGUvWFlpODJNejFSZUZqM3VQQU9QOGdwMVBjbVJMSkFWTzdYNlMrd2thRDBS?=
 =?utf-8?B?THJHRW1uYkFuVUVQa2hINklQaGo4V3duSVRUYjNoQTN2NnJuVS9CTENBZStH?=
 =?utf-8?B?dEdOdXpKVWdhaVhFUmpYUHFWRFlKbzhGUE85alpFNHhMSDFBblM1YktGbk9y?=
 =?utf-8?B?cXJaN0FEeEJwa21YbUs5Tk9GT0hRZzJ6bDBsNW9rRUw0SW01YTYvc0hyUzNB?=
 =?utf-8?B?dUVySU90enpnSXFYTGdOUUtTdXRTeHBxVWRJcXpCWlk0cnZmdmhSMG05cllT?=
 =?utf-8?B?dTBYZS9Hd0tLdjFvdmtaa0xpTjkrQjl6aFlKNDdxUlJQeS85Q2pYMS9mLys0?=
 =?utf-8?B?dUZMK2ozaStEQVJERHp6bWg0cHBTU0JCbUZlM01BeHp3bnBmS0J6Q280amdZ?=
 =?utf-8?B?WUt0ZlN3dEFqVmpkR2NMUGlZT0JFQVRabGFONk1tWmVPWWNuZ0ZxMzlhNnVV?=
 =?utf-8?B?bllXb2l6Y1hDWWZVR1BxVGZXZ1AxMWFyMkVpamgzbUV6UFNsajE5SVMxODFy?=
 =?utf-8?B?OTIwd29abkFlSDFLQ0VtNFY0M3dKOXNMZmNaTjVGT1RHZWhUMnBUY2FRbmdi?=
 =?utf-8?B?WmdyWGR3MUlCT1ZhcGF1U3BwOWdFNjhiN2tVVnYvWDRzTkRvVkViTU9Da1ps?=
 =?utf-8?B?c3RrSHhKMmk2dWxpdXlzb0lIRGplRithNlRWQ2hQaW4wZHprbjlXZ3Z6RVNG?=
 =?utf-8?B?VlhnVFBrVmZ2N1NpRUZHdjRjbDkxMHBTZFo5cEQzdjRQVjhXSnNSSVNPRmpL?=
 =?utf-8?B?V3NuTGx5MDlDQzdzckN0UDFKSUpxak10bXJEYWVPWUZDc0REM203NGVaaUYy?=
 =?utf-8?B?UGFlb2lPaVhleGYzdHh2alVoRWxxa095cUNkTEtQcXpPNnYzV0xEWFZ5dEF0?=
 =?utf-8?B?Ym9xeVlPYzFXRGZQOTNmLzNjckJUTHI2dTQ2OU5tWXEycGkwQ2d6REdJRTFo?=
 =?utf-8?B?NTAyT2p5eE1kNkhDenN5M082N1VKYmsvdlhVVC9sbk53SnNnOVk1NEp0bjB0?=
 =?utf-8?B?V2IvVjNpVWl4bjBrc0RGUlNEdzd2Sy9ELzE1MXJIWE4wVjNGazdxZjhSMmNp?=
 =?utf-8?B?b2QxV1Q3dll1VWx5K1FhTXFKM01xald5L1F1Ly83SUV6cUM5TUREdEFSNWI1?=
 =?utf-8?B?cHdhNTgvQkNEd3QzM3dCVUNFT28rQzZwS3ZKNGxZQ3N2RVRuNmtIUUlMejRV?=
 =?utf-8?B?a0NlUTF6V2h0b29lcXBieDdFdjlBYy9PdUNTd1pCNTg4clljNjd5M2RPYnZB?=
 =?utf-8?B?SE9PTTQwOXRCT29CWllaM2tQb1o3eWpZUTJQcUk4ZkM5QUxuU1ZRMlN2YnBD?=
 =?utf-8?B?TzRsMk9PMnhvRmVSUVVjQld2dm54V1J3aGw2L21HSTNnM1BtVDhnL09jSUhT?=
 =?utf-8?B?bGZxS240UGI3dDVRNVRxNzdEQy9GeUk3S3dwRXBMeW50c01FbTdQYkRhSUlZ?=
 =?utf-8?Q?s+ngGOma8ICjen01k4Gep4E=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA0SPRMB0005.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc2298c-65d1-4694-76b9-08dd8d7019e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 14:04:36.6460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NzUn2KAPRVuNNlZiRcUjDnq3h5EL/bkAFMrYTxo6p8K2BoSLvPpvqTigxZQuvYg/JpEXnxiI5ImFoBkrl8OoBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5332
X-Proofpoint-ORIG-GUID: DGNGSikK66HpeGeC2y7DZe7OrMUK7Mv6
X-Proofpoint-GUID: uTIMwJrmwH-fuDcAIcgrd00-sH19L8ly
X-Authority-Analysis: v=2.4 cv=LYc86ifi c=1 sm=1 tr=0 ts=681b687d cx=c_pps a=kqCqMoaEgQjRYYKBKtAp1Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=9jRdOu3wAAAA:8 a=VwQbUJbxAAAA:8 a=ifObz0Iw-NjshAcJb3YA:9 a=QEXdDO2ut3YA:10 a=ZE6KLimJVUuLrTuGpvhn:22 a=t8gNky6DTScCJD9b48VS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEyOCBTYWx0ZWRfXy0EinV2gQy/V QWM12grViDTvlHAGsPkuM7TUY+iCXGMiozpvAJ69m0xf/GotJSq7cqWc4fANvF2FxIkoQNb8mX/ t8J2VQ46Va3vWi6DrZ7Ojq+h/ZGYvTOsqV0DRXuQRmhwA2t9hbtW/8B1PW6YufSuHLu5K6d/saZ
 Rxy40IdM1wLH/40tvVcl7u2u9WWOCtrkdmvrfO1giGrIAyeO63P+hmtK40HO7MQftla8BQNK08y xEvlnLyK8tTkIy2mDpRspUFailGuiw/OS8xJD8uNl+inIQM/h5hzil8cRi4OFzZ4MHBeWVZljlG NYYltsXG/Ajr74rGoLjwyFqd05IOISloKcHReTMLQqfx1Yx4FYObuMmsRZ+wYbBOmFpsqoU3SUm
 yj211rryIOp9ESDSbyqy6LI3OIEO2g+DvWml9rZ9YaJySRVqzFCuM8zIl7iIj+IOb8HoLfIH
Subject: RE:  [PATCH][next] RDMA/siw: replace redundant ternary operator with just
 rv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_04,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070128

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29saW4gSWFuIEtpbmcg
PGNvbGluLmkua2luZ0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDcsIDIwMjUg
MzoxOSBQTQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBKYXNv
biBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT47DQo+IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJu
ZWwub3JnPjsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGtlcm5lbC1qYW5pdG9y
c0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogW0VYVEVSTkFMXSBbUEFUQ0hdW25leHRdIFJETUEvc2l3OiByZXBsYWNlIHJlZHVuZGFudCB0
ZXJuYXJ5DQo+IG9wZXJhdG9yIHdpdGgganVzdCBydg0KPiANCj4gVGhlIHVzZSBvZiB0aGUgdGVy
bmFyeSBvcGVyYXRvciBvbiBydiBpcyByZWR1bmRhbnQsIHJ2IGlzDQo+IGVpdGhlciB0aGUgaW5p
dGlhbGl6ZWQgdmFsdWUgb2YgMCBvciBhIG5lZ2F0aXZlIGVycm9yIHJldHVybg0KPiBjb2RlLCBz
byBpdCBjYW4gbmV2ZXIgYmUgZ3JlYXRlciB0aGFuIHplcm8sIGFuZCBoZW5jZSB0aGUNCj4gemVy
byBhc3NpZ25tZW50IGluIHRlcm5hcnkgb3BlcmF0b3IgaXMgcmVkdW5kYW50LiBKdXN0IHJldHVy
bg0KPiBydiBpbnN0ZWFkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNv
bGluLmkua2luZ0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Np
dy9zaXdfdmVyYnMuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9z
aXcvc2l3X3ZlcmJzLmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5j
DQo+IGluZGV4IDdjZTAwMzVjNTRmYS4uMmIyYTdiOGU5M2IwIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMNCj4gQEAgLTExMDIsNyArMTEwMiw3IEBAIGludCBzaXdf
cG9zdF9yZWNlaXZlKHN0cnVjdCBpYl9xcCAqYmFzZV9xcCwgY29uc3QNCj4gc3RydWN0IGliX3Jl
Y3Zfd3IgKndyLA0KPiAgCQlzaXdfZGJnX3FwKHFwLCAiZXJyb3IgJWRcbiIsIHJ2KTsNCj4gIAkJ
KmJhZF93ciA9IHdyOw0KPiAgCX0NCj4gLQlyZXR1cm4gcnYgPiAwID8gMCA6IHJ2Ow0KPiArCXJl
dHVybiBydjsNCj4gIH0NCj4gDQo+ICBpbnQgc2l3X2Rlc3Ryb3lfY3Eoc3RydWN0IGliX2NxICpi
YXNlX2NxLCBzdHJ1Y3QgaWJfdWRhdGEgKnVkYXRhKQ0KPiAtLQ0KPiAyLjQ5LjANCg0KVGhhbmtz
IENvbGluLCBtYWtlcyBzZW5zZS4NCg0KQWNrZWQtYnk6IEJlcm5hcmQgTWV0emxlciA8Ym10QHp1
cmljaC5pYm0uY29tPiANCg==

