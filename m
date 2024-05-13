Return-Path: <linux-rdma+bounces-2445-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5AA8C3C4C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 09:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55A528142D
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 07:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF052146D53;
	Mon, 13 May 2024 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="alJxhvsX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2137.outbound.protection.outlook.com [40.107.241.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABD8146D51;
	Mon, 13 May 2024 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586410; cv=fail; b=Juut9AuEUZwvyUgvHcw5UkJ+D57MvfJa5swGEagrym/g+IN1Gud5nmmW6O658TmixspSs4GrSWxDnhILY1w+a3LxtnjtDxvIxWoTSQ31rppwiFc8tjsRZK0Z6JsZd3a8eY7/w1Bma/JwL3T26kJrzdSaNg0v70bqxJKQWm+epKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586410; c=relaxed/simple;
	bh=wEuBeAHnbexMkwsHCD1mPEJUSDysJ9v4/E16gTsmuEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tGT7+TZ+WrakUvyroaM8zmVRqFU2/86dMVz976gp5B3scxb3OPoBhUvVTM7gdiWBapjrPNtxfllgrbND6b6BNnHrM99xLxcN1hbC50IJig7Pb58orWmuOMuWJ2i+yI0qXGwS8iFNkCYY1cgG7bYsT5OJAtXERPgPb3ZSRNAnVd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=alJxhvsX; arc=fail smtp.client-ip=40.107.241.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQDjlWJjbkAqt4ri4fnQHg/3O4RL4lzu/BDTAmOiNh0ml1T8e4HpmUC3cSaOBCec4fgJNZx/p5IevRl+wj6UUe/53DF3mGuntHmQGc1259L2qlf1eqrjRvxz3BM8lwpjJ/P3vnguvqHtU/ak54qJ/IYdEyrDOOw4GZm4wJQ8lOkKn//wgkwJXPEz9rCGO+EpvVbCcWFesUZG9tvL0Mu5tB2Ij16oqSc1skNeKXJXx25DAL4AVwQLl1q2Z7qTLiiX0CT1wU1Dv5XUL6Z0w+p4e0KtCvjBmIFw9tjSlrbiVoM3JWFVYtb5d2+hewdILlXTMTq2bRaScf403y1WceeDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEuBeAHnbexMkwsHCD1mPEJUSDysJ9v4/E16gTsmuEo=;
 b=VX7Yr5FAgKCysUG65EGV/jLBQpoog1zSeJN9fHmVVmWxk8/a9HcJbZA8RNmCn0pOYvvNp6yerqT2QhWhUQDdm4fEwCosaAlsSif26TMo0JLinba67dEU3FdWPh5r8iH5MzhQTaCRNp5b6c0c+vLj21OKRbcDYsdvwWIVAlYBoc9Ek17Hf0Ml7VC+x+zkCOzRaqU88uVo5viQZAVzHCj7iXA2wk6qkr2EVQCOP7SsHAYKGzI3suXEVWQYtmR/e/pzNxRdMnr9tH+SLds4YepWo/aRfDGx7oOVyeTkEIcuHMkjnG36TDpwlyrTc3Ft02jMAScNUIj8xNwuQpOhj6DytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEuBeAHnbexMkwsHCD1mPEJUSDysJ9v4/E16gTsmuEo=;
 b=alJxhvsXgioA1M0QxrdTMTmR28Z4gxtjweUf+ddVynp9Z7OJkS70feqBNrD4ie7NnHXO0tLPxhn+AJZoF5xgzsdWQ438fsEC3vRkp22Lz8kt1qYGNJop76j9HGl1wFgwYhiE1wxhMxlmgZiaAEEMG9siLyBSAH5hViVo2NCtTZQ=
Received: from GV1PR83MB0729.EURPRD83.prod.outlook.com (2603:10a6:150:207::7)
 by GVXPR83MB0630.EURPRD83.prod.outlook.com (2603:10a6:150:154::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.4; Mon, 13 May
 2024 07:46:44 +0000
Received: from GV1PR83MB0729.EURPRD83.prod.outlook.com
 ([fe80::9757:8b92:5f0b:cebc]) by GV1PR83MB0729.EURPRD83.prod.outlook.com
 ([fe80::9757:8b92:5f0b:cebc%7]) with mapi id 15.20.7587.015; Mon, 13 May 2024
 07:46:44 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 0/3] RDMA/mana_ib: Add support of RC QPs
Thread-Topic: [PATCH rdma-next 0/3] RDMA/mana_ib: Add support of RC QPs
Thread-Index: AQHapQmzsS8jizPY0UW6+pmcDbpn7w==
Date: Mon, 13 May 2024 07:46:43 +0000
Message-ID:
 <GV1PR83MB07297A24A089A29DC70692A0B4E22@GV1PR83MB0729.EURPRD83.prod.outlook.com>
References: <1715075595-24470-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240512093553.GA11697@unreal>
In-Reply-To: <20240512093553.GA11697@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=91d82818-7170-4f82-be64-8c67dae538b8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-13T07:44:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR83MB0729:EE_|GVXPR83MB0630:EE_
x-ms-office365-filtering-correlation-id: 7431a8ab-caef-48c4-da98-08dc7320d590
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?bXcreFhjZEt0elppdjRqc0ZMWldIQkJwTk5vTEZ2aVczN2E5ZG1VdnRIbkNT?=
 =?utf-8?B?TXpZQVYxdVJQTFlZNVA2NWk3M1J5ZFZ6S291UVFMQmtaSHVNWnpHbktTMmpo?=
 =?utf-8?B?ODg3ajRmWmtWYWROOWdzM2lqQmNZUVpNeWY4bHNCQ0JBeGJOQzBiRTRWL2JF?=
 =?utf-8?B?NGdrdTVzWTQzZEVuQ3BCYkJkK0NTY0hBcjFmSk9ZT1RkejBLRjFHRHJScjVh?=
 =?utf-8?B?K295Z3BmWmFzemEwaVFxcEpFQzBUWGt6VVlNK3kyYmVKYW9mL1dWMkxoSG5I?=
 =?utf-8?B?dGhMYWpWTVJtTjFCaGJXbER3UkJpeVZ6ZTJRMkgrU1dFR3pXNndWVDVFaC90?=
 =?utf-8?B?bWFvYzlEU2hmS3hieEFUOEpkUGo2ckcwNDk3WloxZ1hVWnJleEsvTGFrc0NL?=
 =?utf-8?B?VjhSZ0dDTC9FV3lqM0oxVWYxQ2MzaFJRVHVjbTNGZTdlTmtkc1JGRndsNWpI?=
 =?utf-8?B?bVdFWEhaTTg1b2h5TnF3TmJpOElIdmJZZVNOdGE4MFdWT2VSUXlMSTEybHN2?=
 =?utf-8?B?eVorU0RRazJXUFJSc0ZLZjc2YXR3d0hKNHhEYkpQMjlrcjBMa0xUSzNRNGxP?=
 =?utf-8?B?b1JkcUpKek5KdURiUXpsZVY4a3E2T1d2UjBuZ2xmVGFrNzQxVjl0Wm50N2Vy?=
 =?utf-8?B?KytiakF5em5XMytRRXZTZDdqRVZSZWlXYkZRZGY0SGxnaThHVXp1Wk1TZGo1?=
 =?utf-8?B?clZMcXI3U01EZkxabjVENlU4c05tR0M3QWdsQXdyYm9pZm96eDJHRGgxV1dk?=
 =?utf-8?B?YXBNenVFVHl4WURVTU9acWRwSUR1b1ZuTGpkMFBMb2NXUVdWenV0SWJvcjgx?=
 =?utf-8?B?SFllOVVTQmo4L0g0Y2NmY0dLcjZKcng4SEZ6Yy9zWk1ZWnRNK0kzRWk0NHNv?=
 =?utf-8?B?MENuMTY4ZHhGZEJHNlNVUjVxakhQQ3pGaktBNitramVxN1huWmU5TmMrSkJP?=
 =?utf-8?B?ZG91K0JTTXlmdDdXN3FNWHJYclhYcUFqSTFwT2N4UFBNdmVCTEdNYkVoNHM2?=
 =?utf-8?B?UGFkNHpJRTZUQ0JMK3B4bG5DT2lvU3llbEp3QytLajY5ODRxZ0ZPUmRsenEy?=
 =?utf-8?B?Vm4vMis2Ump5OUo3aktCMzBXTzg3RnBhSGNFcTVaczF6RzVsTmtIa3VuOHFM?=
 =?utf-8?B?SVFwUGdzVGprdVBma1gwU0ZhWTJJeEwrWGJQTS9YSk43WUdlSkNOYjYrMXFT?=
 =?utf-8?B?VVk5VUgyQlA5cDZMbmFmN2ZjYmZUOEpaalNYNjBkWEtlcGtpd04rZ244YTNy?=
 =?utf-8?B?RWZ6SkMvdldkVUNkZTg1NUtrWDlLVzBCc2xzR013UEVoWWs5R1dZMmNtRWZZ?=
 =?utf-8?B?NHlaWDJ2aVJGTTdVWE1ZVURSaGRUME5kSnArQU8zN2xzdHVBa3ZEMWdoNFVX?=
 =?utf-8?B?VDN5MklGNEp0RGpZVmhZT2RXYXdwZUJlMjd4SW45S2d0TmdwRGpTOHM0eExE?=
 =?utf-8?B?N1RyeUFma1JpM2dSeVpLWmZyVWhXT3NEUmRHRnFodFVhQTFrRk95bXYvbGVv?=
 =?utf-8?B?Zno3cndVT2R4VjdBWG9oYTFLWVhDKzVVMjd0Y0pzK3NKNExyZWZ5VVQxRk9V?=
 =?utf-8?B?Q0pSNWVZdGFvdGc1S1VOTm53R1Qvb2d2dWM0Q2pkcWUrbG5DWWZWeW9QcnZ0?=
 =?utf-8?B?YURDTmJqS29xTHJ5a3JzUTlFcGxPc3hRRk1tTmtHZGs3VzhrcXpoQjdXNUM0?=
 =?utf-8?B?Tkt6UmtNRTQ5YlpHWVI2SjJSS3RqajBGY3preHJBUkhHNHY1QW5oTXFnWGlI?=
 =?utf-8?B?a0FadUowdWxaNjM5bkF2SW92ZXZveUVDY1E5VjFPZ2RXZnFUa0FCOXdQcG0v?=
 =?utf-8?B?MEtucTN5YzZiUGNKMXZQZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR83MB0729.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVlGaFkxSUYyYmw2UkFMN2F1aU02ejUwM3ZzcXhHNkpyZTd6c2hsb3MvcnNz?=
 =?utf-8?B?MHpSOUw4Z1FxWGVQS01GMWpLM1dtYXhWaGVEc2F2NW9DYUoxUWNLeVhBaVZk?=
 =?utf-8?B?L3lJMUdxRjN0V3FVUWY2NlVCM0I3K01henV4cVpSRzN4NkpEU3BnVU00SG5y?=
 =?utf-8?B?Zy9rUS9OQlBFZzR1OUpOS3hPZ3VHWWsrMDI5QWlveXpxeFhEa2ttL3Z3eHR4?=
 =?utf-8?B?VjZQNEJjN1J3VndnQTFIUkNQSUVuZnpvZnUxbno4V1VTaUYybktmanJQZ29k?=
 =?utf-8?B?OVlBdFZlSEZqSE9pbDZ6ODgvSW1hdy8zelp5aE1DLzY2RFF3dTNmMGN3eCtG?=
 =?utf-8?B?MjQ5M29BMW4wVkk2Yjk5R2h6eUljNlB5anZZWlhHWjNRenh5SVcyYmVZclRW?=
 =?utf-8?B?dndaNngwN3J5Z2FzdmhRTkR6QmlySXJ0RldCSW9xSnJhU1p0QTJQbmY4WkVO?=
 =?utf-8?B?Y1p3b3FGclF6Umd4R1QzcDlha05JT25aUHc2b0NyZEhENGZxcm44bFJ3VEtq?=
 =?utf-8?B?c1hSRm5iRFRNT2lXVnRFc2JKa1hMeklsVlcyY2g4dWNZVjA5WGd0TzFoUkYx?=
 =?utf-8?B?aGRxRnhjb01COEdxOXFQQUVNTmUrZ0hNM0w1V2VDVnZlVmJFNThpdzVlL3Jx?=
 =?utf-8?B?YWl4U0x2ajZOYVhwM0xYcXVibTVSSWdYQ1B4bjJINFFNQ3dKRS8zaCt2Qllp?=
 =?utf-8?B?WHVHaDM1TlFhQko5RlFtZFlnOU1hOEFQT1pQTERTamtmVXRiU0o4Y1YrSVU1?=
 =?utf-8?B?eEI1b0NQNjluenYzOTQ3QmhYVEZHZ0c3Vkx0Q0VFZ3g1dW9NNHc4Wkd1dXpp?=
 =?utf-8?B?bzJleWt6SUVpaTlCR0t6aHJYd0hlSEpSaFhZbG5FSTBvamlmZFZtV0prUkFP?=
 =?utf-8?B?RlRKNEgxRUtOMm9rR2lMVS9zR0dwQnJKMGtoOVZ1enBaMXlMSCthRDM3Rm5u?=
 =?utf-8?B?MGxuQThnREZXT1N2QVp5aUI0cjBhaTFmN3NEd01EeWdJZDJmMG1idE1DeGlu?=
 =?utf-8?B?RkZVSnJHVDVwbmpiejNSU3ZDTGhXM2xkeFA4ajExR0dvMlJzcVRkZHJkUEpF?=
 =?utf-8?B?YjZrVU1ibTEwVlBEOVo0M1VHcTZSY2VRSDhnbWxSSmZEQThVWXRVa1FEL0ZG?=
 =?utf-8?B?eGlpa1hwbGp2cDR3bjBIaVFNelJOY3lULzJJWUU5SXE0Wm5NaFNZbVl3WTEv?=
 =?utf-8?B?bDNIbkthNGJMdmJBS1ZOVkwza2J3aXlkWURnUWdWSG5ESVlPb0lDS2w1ZUlS?=
 =?utf-8?B?Z1loWFJTTHd3eStBZ1NDa203Qm44UzNzRUt5SUxSUHJ1ZXRDWG5INEV4SUJO?=
 =?utf-8?B?MUw1MnZ3b3hkQWdrcVZ1UTM2YjVNVUVidVQ1My9SZXd4MVEyemovWWF3NHd3?=
 =?utf-8?B?VmhubzBkdThiTWo0TEhsOFZzaGUxbzJsMkwxVGExV1lKRkxKZW15WDNHQXds?=
 =?utf-8?B?cjhjQ0M0cVdTM3RnZG9BVjlCVVJ1ZCtKY3JFajNYOVl3c1lHMWMrUGY0V01Y?=
 =?utf-8?B?azhzYlhtRFdURitBVnJTcHdkWlRCT2RyVVp2MUlHaFZBejV3QURucUJ4TkdK?=
 =?utf-8?B?TnNBVXd5YngrMjFHOG1UTjZsV1dvbHlLZm8za0tQQWdMaHd3QUhnNmhoNklT?=
 =?utf-8?B?dGxmYnhzMEE0UEVKWUtiVXBXMEVkeHozQ3BoemFtMjZRWDNtTzljRmFvT1By?=
 =?utf-8?B?NGQwZFpsakpQWmcrWGFGU1YyRjdGa3dPM2hoUEtnbnlaQUl2am5PdFQ1dUN3?=
 =?utf-8?B?TitwVEFweUs1UFpYaXE2Q1k4Q2pnWjc5dnphc3ZyV3lob2txOXg4MTBrQmlE?=
 =?utf-8?B?N2V4K05NNFYvaWNEaytzeko5UE1IWFVLcENLSldqK2dab0FMZ2ZMRDNGYUkw?=
 =?utf-8?B?Z1RUSko4QStSaDIrOWNaRjdGS25lUjMvN2J1YkVlWVNzK21qNStKVTlrbFp2?=
 =?utf-8?B?SGxIMklROFl5TExzZ3k2ZEMyQ0RySnM0OEZWei9mamw1MXcyendQd1plU1JB?=
 =?utf-8?B?NWtyV0xwNVkyaXdSMnRySzZtN0d2NW1Nb3N1eFpLUEt1VmszKzgvVnZlalE2?=
 =?utf-8?Q?qn0mdB?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV1PR83MB0729.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7431a8ab-caef-48c4-da98-08dc7320d590
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 07:46:43.8600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: htk3miodnoe4keVSIjQXB/iVOoLesRso3KzHuQS+THoINosoDWuPSmGaBuxD9rie/QciM1lg8Idwgma0VkpFMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0630

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMZW9uIFJvbWFub3Zza3kgPGxl
b25Aa2VybmVsLm9yZz4NCj4gU2VudDogU3VuZGF5LCAxMiBNYXkgMjAyNCAxMTozNg0KPiBUbzog
S29uc3RhbnRpbiBUYXJhbm92IDxrb3RhcmFub3ZAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gQ2M6
IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5jb20+Ow0KPiBzaGFybWFh
amF5QG1pY3Jvc29mdC5jb207IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPjsgamdnQHpp
ZXBlLmNhOw0KPiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggcmRtYS1uZXh0IDAv
M10gUkRNQS9tYW5hX2liOiBBZGQNCj4gc3VwcG9ydCBvZiBSQyBRUHMNCj4gDQo+IE9uIFR1ZSwg
TWF5IDA3LCAyMDI0IGF0IDAyOjUzOjEyQU0gLTA3MDAsIEtvbnN0YW50aW4gVGFyYW5vdiB3cm90
ZToNCj4gPiBGcm9tOiBLb25zdGFudGluIFRhcmFub3YgPGtvdGFyYW5vdkBtaWNyb3NvZnQuY29t
Pg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgZW5hYmxlcyBjcmVhdGlvbiBhbmQgZGVzdHJ1
Y3Rpb24gb2YgUkMgUVBzLg0KPiA+IFRoZSBSQyBRUCBjYW4gYmUgdHJhbnNpdGlvbmVkIHRvIFJU
UyBhbmQgYmUgdXNlZCBieSByZG1hLWNvcmUuDQo+ID4NCj4gPiBMYXRlciBJIHdpbGwgc3VibWl0
IHJkbWEtY29yZSBwYXRjaGVzIHdpdGggZnVsbHkgd29ya2luZyBSQyBRUHMuDQo+IA0KPiBEaWQg
aXQgaGFwcGVuPw0KPiANCj4gSSB3YW50IHRvIHJlbWluZCB0aGF0IHdlIGFyZSBub3QgbWVyZ2lu
ZyBVQVBJIGNoYW5nZXMgd2l0aG91dCByZWxldmFudA0KPiB1c2Vyc3BhY2UgcGFydC4NCg0KU29y
cnksIEkgbWlzc2VkIHRoaXMgcmVxdWlyZW1lbnQuIFRoYW5rcyBmb3IgaW5mb3JtaW5nIQ0KSSB3
aWxsIHN1Ym1pdCBpdCB3aXRoaW4gbmV4dCAyIGRheXMuDQoNCktvbnN0YW50aW4NCg0KPiANCj4g
VGhhbmtzDQo+IA0KPiA+DQo+ID4gS29uc3RhbnRpbiBUYXJhbm92ICgzKToNCj4gPiAgIFJETUEv
bWFuYV9pYjogQ3JlYXRlIGFuZCBkZXN0cm95IFJDIFFQDQo+ID4gICBSRE1BL21hbmFfaWI6IElt
cGxlbWVudCB1YXBpIHRvIGNyZWF0ZSBhbmQgZGVzdHJveSBSQyBRUA0KPiA+ICAgUkRNQS9tYW5h
X2liOiBNb2RpZnkgUVAgc3RhdGUNCj4gPg0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFu
YS9tYWluLmMgICAgfCAgNTkgKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcv
bWFuYS9tYW5hX2liLmggfCAgOTkgKysrKysrKysrKysrKysrLQ0KPiA+ICBkcml2ZXJzL2luZmlu
aWJhbmQvaHcvbWFuYS9xcC5jICAgICAgfCAxNjUNCj4gKysrKysrKysrKysrKysrKysrKysrKysr
KystDQo+ID4gIGluY2x1ZGUvdWFwaS9yZG1hL21hbmEtYWJpLmggICAgICAgICB8ICAgOSArKw0K
PiA+ICA0IGZpbGVzIGNoYW5nZWQsIDMyOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gLS0NCj4gPiAyLjQzLjANCj4gPg0KDQo=

