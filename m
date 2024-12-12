Return-Path: <linux-rdma+bounces-6476-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083D39EE834
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 15:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31659167727
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 14:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856D72153C8;
	Thu, 12 Dec 2024 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F0SM1i/1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244821504F
	for <linux-rdma@vger.kernel.org>; Thu, 12 Dec 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012218; cv=fail; b=EHGDPV+HIYHvdKW4008dCO/Ztf9I4xVkugH/TjeA/FzoyX4p/4bYkaAMFsJRivtrLGZlqhKE+Hn73TiwVG8u9g7fJ/rW7KIc+ZtgBCAcBKpV2Ar6manoilcWOW9NG10Zb2ONTbItaz0OF9qqvkNDhm0e5aUuVUNuqI3UkJnzs9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012218; c=relaxed/simple;
	bh=209aGXeFlqlUVQbT9P9j2C6cVEki5D4jfnot333hwkA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=cBc1fFUFgvhtEYIzRpKKoiM+suS/gJEcuwpX8K2II9HODvrBxyVaGqKpOMRDTWsV0vPQL39LddcYaxGglSGgau2S5Ww/ZBEBDhSZ9lWnlAa7AU1uHHY/OrcKuocSJfe4swPXYnOnyrrZqKfI5HGRAsYTiJ/VpQYhZVb9Jevy0Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F0SM1i/1; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7mtFQ004519
	for <linux-rdma@vger.kernel.org>; Thu, 12 Dec 2024 14:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AkjXiD
	vsLoCLivqWFdV+k3J8zZZU4xyQkgHZdIC/pdc=; b=F0SM1i/1w6c9+slMLfZSWV
	iRiRnaUCS8i0sX60Oa9g74/YOrNd/d0PA9J1PYGvXTmXUnQYA3pAb+51Q9ITDgMs
	O1ZpfCyFftQagIuar39iK2uBNU6YpqIcz0H07Lj7y4sCbxtXFXs14kcSAO25gEF1
	zQGu+yKq5wuVWGpdPR6RL5WtgFycevtyPchwoIhxNVWcbRGSIwaloBcXYaD63awc
	sPFaizUxsOcUHjKIa8RyiNMMzy/glSy+KixjJX14IopAsfl6hTtFHV9nLZj3SPLq
	0sR+OIkeW6vFfuiX6U22vBcs5ILeRzNfz+UEPn8S41IMGQnS2EY0SoR1/3ZaaFEg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xu9g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 12 Dec 2024 14:03:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BCE3XlU028295;
	Thu, 12 Dec 2024 14:03:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xu9fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 14:03:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8QSEOTqbi7DNHpZTMLw+5mkbA1pWQ84cUxBELleZPK80ueKk0V2W4MOptJ2s71AfIN7XxBqJCTlqEDzHT0P5WxgUS7OR9icNUZE4IYxR4wd1VgfO81G8rIsrcyTy3ZxdlFRxarLa8LDsEYnQvSNbUTqAD3tM7+VRNCG57va/XjIcsL7qQseUi/oKKxa/NdAVxNIHBAXLuknN9K9LqTGoxFmzNnAJyZcvd96PmnoD+u1zutaiStICO0JPCbusQ4Dz1WWDa4AzzJF9DQEIk1RgsaLLY4WNf76TZTzzDNqaIsrXw8eLAw4st9tFbPMo44FGpBVxwx2K2HimetpwQD8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uK6OkyVd/8O2EnXJzYTCODvY6DKIekc4B6Muqc+rYF8=;
 b=STAcvMtrqkWKjRXfjQ/9aIdtvIOLeoxfo5t7R9/mrWQSuIAQ9vGM3y7iWQYuPj6a924wPyDek8ETMi+77TMxM7Z9U3aElvpovMlx16+Yjs0nsYOxvFQGB67Ua0UqdxScmNfczul4OZN8T0wh2JcHKyIQIogrwyymlhb7RSKRdhI5niALWrDmRE+Wv+3GZqcfic8UpV+JJ68Tv3KOgHmCdu10Zmkx4mlZDzhPn98ozw/vQkVaOrJszmT6bfOHCTZC9tKPIlu+P0HnBnd2rCtv2KKK+pXtij50j930Sp+AwMOCDxmrcNDYWXdQYq1pZOMcyIQ6qQa9JErGfH5nwzCMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by DS7PR15MB6363.namprd15.prod.outlook.com (2603:10b6:8:d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 14:03:29 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 14:03:29 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] RDMA/siw: Remove direct link to
 net_device
Thread-Index:
 AQHbSwQv3cnSLCjGOEepm6Xze1BjgLLfkViAgAAKSlCAAD1ngIABTeiAgAF1vACAAAcSQA==
Date: Thu, 12 Dec 2024 14:03:29 +0000
Message-ID:
 <BN8PR15MB2513CC8F5EAD34C045D5142D993F2@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <20241210130351.406603-1-bmt@zurich.ibm.com>
 <20241210145627.GH1888283@ziepe.ca>
 <BN8PR15MB2513CA1868B484175CB61E88993D2@BN8PR15MB2513.namprd15.prod.outlook.com>
 <20241210191303.GF1245331@unreal>
 <BN8PR15MB2513A5425BB295C9A08C44EF993F2@BN8PR15MB2513.namprd15.prod.outlook.com>
 <2e49a984-62f4-4870-894c-d10a8aac8e86@linux.dev>
In-Reply-To: <2e49a984-62f4-4870-894c-d10a8aac8e86@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|DS7PR15MB6363:EE_
x-ms-office365-filtering-correlation-id: 8d4cbd7d-012a-4ec5-bed2-08dd1ab5c187
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHFSZmFoM0p3U0JDb2hjWUx5NitzMDg4WlhrNURLOTNLTGlHR01UZ2RPbFhX?=
 =?utf-8?B?cWM4T1lqQmo2QnJvQmc2d2x1aU4xOFRMdURMN1R5WWsxZXNrVXc3K2ozeXQv?=
 =?utf-8?B?MkFmNTVvZ2JNS2k4dFM4aFVIZ2x3Z1QvYnRnZDRtZ1UrcFNEdUYvdFIrczg4?=
 =?utf-8?B?cFd0OU9IL2REU2VQUlZYYVdaSHlaUzRIWHFJUjdic0FRWnN2cElEWjA4Z2FV?=
 =?utf-8?B?OGFUSjIyWXhFR3ZISzZXRjcwMzZzZFplWDd5QU1Vb1BIQmV5aHNOWlhPR3Jm?=
 =?utf-8?B?LzI5RW5mOXdseko1QS9SVUpSamxwbndIUzEweVY2YS9xdU5sY3ZYc3d2eVAx?=
 =?utf-8?B?TlY2SWtWWlFYQUpZNURFVWpIeDd2UlF6T1ZJZkRpTmlVVk95ZGxFekh4UEdj?=
 =?utf-8?B?OXdjaG9WdTdPUDFSOEJEdVdUNFZSc0hSbGhremR1SENwQ0pDVXp2VW5zRURi?=
 =?utf-8?B?aEwrdWNRaE5pMEdXL3JRTnY0QTdwN09vTmVEMTY2VTJtTFI4d1IxQjdqOXNH?=
 =?utf-8?B?THZXSjNmYnF5L2x3TXphYW1aOERRVDVWYXBuQ0s2bEdMNi95MUZwNmRqR2ZN?=
 =?utf-8?B?SUdVdGRFRGgvVVErbHYzaU83aEdyOG5YYkJaaU1QdVFQUTFmOGZncVhKWW9T?=
 =?utf-8?B?RTZXR3IvVkdaMGR4d2kwT0JMK1BlcXo5UmlEWFBHZUV2YUREMU45a2YwWWNH?=
 =?utf-8?B?bXdDa0VrV1kxeUEybUc4a085dTJLU0NoaHltK2hlbzFZMzhWaFRybEw0eElY?=
 =?utf-8?B?eUdTbHN0aXBVaEdjRkxqUjZaRHlZbWU4MmpYcVdrcUc4cXpkcFZIdEk5U0U5?=
 =?utf-8?B?bTJGanpLOVpsZVU4ZUVQYkFONVhoNFZTUkYyVlp4dXJOaDNSVjAzamdvMjRS?=
 =?utf-8?B?azlLSDhqbTlSenJ2M2U0cVF4Y05jT2JiUHg0SmNnUU92ZTFTR3JkUW5abmFt?=
 =?utf-8?B?V3h1dCs5Q0NiQ1dCVjlxNlVGNk90aEYxbjlXTURxVFZkSEZHYkhDZytsMHo5?=
 =?utf-8?B?Y3lFRDFOeml1cS9uV2s1Mk4zZzVNdU9KWnV1ZStzRm81WExKUWJKd1BHQkVY?=
 =?utf-8?B?Q0xEMWoxeWs0WEYyS2hValFXakx3NmZ0OEVoaWpuMXBZdWZzdldsWlBUdjNx?=
 =?utf-8?B?NWQ5QXhraEFVZlA4MFBBR3pUais2RDluVWpIS3RpdDI4WlhCRncyelBGaUtw?=
 =?utf-8?B?Vk1mTFI4Nk5JeE13a05aWElRVzU4T3JmK2hRVFhGbnZwRE40TEF5aDEwN0Mr?=
 =?utf-8?B?amZFSlpOaGJqOEhqNU5mT1NrdDBSbUxtT1AzdVpySTFxZ0o4aXB6eGVNTTZB?=
 =?utf-8?B?c1FqSzlLOE1ZejhqWWwzd2dONTRoMWJXb1NoM3ZFVjg4NzJBWEV4U0h6VjY5?=
 =?utf-8?B?UmZzU1RjRHpNMjlyUzFxN21uQUxidFNLc3lNWTRPMGNRV2pKRGZlbTFkeG1Q?=
 =?utf-8?B?S2NOZUpXa0h0b3VKMnlZTVVENkJYcmtDemxmNFE5MnplaUM3d3lPSSsxcWZD?=
 =?utf-8?B?eXZmVDZjQ0xjZnZnMytNeDVrdjZOVnhSWEt3WTBaVVZNZ2dabFhJdlJ2NXJP?=
 =?utf-8?B?dlBocVVCRldwQmZjbTMwcEIrRHBYeU1aS3NWeDlmWC9KdXhrWkdyUlcxV215?=
 =?utf-8?B?U2w0OCtMbnNVT2RYMzdSbjNZV0RWSVNCcWJGbll5K1hzaEx5YjQ1K3JDSVdD?=
 =?utf-8?B?QVc0dXBXSmxaRXZFVDBUMjIzckM4eDNpdzR3RzJ1b1BZYTduQ0xOZUx5czZC?=
 =?utf-8?B?dHN3R1VrSzZpbjF6RHVSRVg1dlRZalh3UmN1SFU1SG1EVDlBcHdZTkFmZDAy?=
 =?utf-8?Q?ZD2QTwvRlxTCRkIVwHd1DeOcE953RRfvYKHyQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkFQTWJOT1drV0xaMmJkbm1Ed3BsZzIzT2E5ODErbjEwdC9UUld2WUt3Y1NV?=
 =?utf-8?B?d29lRldaVkkzUHhvd1orYTFBMWQrdWQvZ2w5S2g3WnJGWEZ5c3dKczVPOTNB?=
 =?utf-8?B?VzhxbExpMThWNEEyK3U5MktRdDU0QzhqOWRPNmplU1NjS3lMLzdqVTgvU1BS?=
 =?utf-8?B?TFdvTDVWeUxWa1E3L2dvS2o0U2pXS0p5eG5ldlVNdUdYb1ZWTXdrQ0FpZUJ4?=
 =?utf-8?B?SHIrMnYwNW4xc0E5L3ZFc213OGs1ajlwRkkxSFBsVXJlZEhlSkwrNW00K1ND?=
 =?utf-8?B?UXIyNEFUMlVVY0dJTjZEU3g1ZnhvS2ZZRzhlZHFtRWErK20rK3JUblhDMzhh?=
 =?utf-8?B?dGVqVHIvMVpWVE9Xc0V0SVlTdjhrWmcyYm5XZE44OUpSM2VTNkxIVnBYTVpD?=
 =?utf-8?B?TDQwQTRaQTY4VDE1T2tCdGZQMXVFcVVLT1A0c2xtemRieE02UkxUUmpaN1NV?=
 =?utf-8?B?OGkxR2o0ZWtmYzYwNDc0TEY5NklSWUFKcDczZEhSaFFIOCt3OFkyTDdCN2Y2?=
 =?utf-8?B?bEV0c3RNZk5IdkJjQitCYld0cTVwQ044N1d0UEFHWmRqUnhEMVVtREp6R2JC?=
 =?utf-8?B?N1hKVktkdGlLZDBtN3VwZnRSK1dTbUhUdy9keUhDU085YUFSR1Y1alVMdW15?=
 =?utf-8?B?M3VYUFFIZE5xa3FzcEZ0SHM3b2tyM3dzcU9yY2N6THBrWmQzMmlCNGxRNW5X?=
 =?utf-8?B?azYwMHVkOXpRcXNJNStkUXFOZk5sUGtLOXhTUGRycDVLcU5Ob1Z6cHFYQngz?=
 =?utf-8?B?eG1SV2dLWUt2SmVRbk5RYlVDZWpQTE9FTnhQbVBLY05IMW9WaDN0R25VWTJn?=
 =?utf-8?B?VFlpa1dJTnpMQzVEL2JENXhrbk4vbm81UUswMFB6WjhrVCs3MlRRV3BFQ0Nu?=
 =?utf-8?B?RTE5bytFSENGYTVMYytUaTVFanlya3F2TE93L3lGQmQxWjV3UXpCR3BINU9O?=
 =?utf-8?B?V09mQURYMkF1TVdOZURCbE9VWFo0YUpoYzVTbXovWm82a2c1MURHYmd4NVBX?=
 =?utf-8?B?M2RJMXZtdnY4bjhlWlFBTjBJQTd1YXpEb2cvZDFIcjY5K3BaaXFIbE03Q0NZ?=
 =?utf-8?B?ekk4cDNXNGRPYWQ5cVJueXFVWUE3NTV4NklwdUcrVkVPam04Z0tTRUkrOEVU?=
 =?utf-8?B?NTd1ZkJNbXI2UFdGSGN2YzYrSUZpa2M5cEhwTWVucGkxN0l6elRSS3VrMFV6?=
 =?utf-8?B?clgybEN5aWJmc3VUUEhLSjY0OWMrMTNCQWJQYXZOcTBGNVEyd0tvVHRoSEUr?=
 =?utf-8?B?a1dmRzlVbm1LRjN0YWZETXdPUy9xTmV5Z0tJbXp3NkhwL2hjZVptayt5RkhH?=
 =?utf-8?B?VzRjbWpzNmxubDRqRm85eDFBK1U2R25KcC8xUHVDKzMwNkcwL1QvdWtTL1Q4?=
 =?utf-8?B?eVp1UUhpcU1xT0Y3N1JnSzc2UVFTc0pqWDNPUnZFbzNVWkgzSS90dUZYUEls?=
 =?utf-8?B?TkRFM09aWUkyVktVUytGblVkb1VwWHJZYU9IOVpZb0djQ3d3UFFEQ01rdmJS?=
 =?utf-8?B?cktoeEl6ejB4U3htTERRTXBlTUIxenNLbmdQZ01vSTV4NlY5TDZETE1GSUdy?=
 =?utf-8?B?dzZ6bnAvU21jV2h4bzFEaGJGVFFSWWZhK3Azb3ZOeVVLZ1ZEZ0NjeFJ5QnVa?=
 =?utf-8?B?K0dlZWNSRXZjcVI0cjJsaFlrbG9oTWc3NlN1WkZ1TkM3QWF6Zkw1RW4vNzlV?=
 =?utf-8?B?cHpKd0ZsZGNndFhPWHc1THh0ZUxPWWFtUjZTYUs3NXRPajZwejhPY2dHY1gx?=
 =?utf-8?B?K0JmblZKdTZTaUt0MWxGTUVLRVp6RUxmSXdoa1o1MS9kWitDWkgyaEU1ZnhR?=
 =?utf-8?B?cFBFamxNcVZTUExoZFliY0wrS2RoNE9DeEdCNDB3dm0zUmtwVEV0dkZpcHR6?=
 =?utf-8?B?aHgrQjg4cW53ZGZNNDZBMEFFV09mTzVQZi9uVXR1ZzNhYTQzbFpjbHI5RXhY?=
 =?utf-8?B?Nnc1RlRtTmk0T0lldmcybThaYjdyMjdEM1MrSXVXU0lVMFVabFhPVmNVNjhy?=
 =?utf-8?B?eHNtUTBPQTYzVHRSTWJML3k0VytvdlJ6UWRmdk1jdnZzclUvZ0NMaDhyeFFl?=
 =?utf-8?B?ZElOUVhSWHVadnJKd2h4NWVvZ2lEZ0laYytNOHZYU09ud3doRjRFWmNTM0FM?=
 =?utf-8?B?MnZuOVNXcUZhNlhZUDkvcWJkZzhWSHRsQzRUNlFTa2lxN0JpZ25xMVpHUFdN?=
 =?utf-8?Q?Xc1hK+Le6YRLky0mxtJ81hM=3D?=
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4cbd7d-012a-4ec5-bed2-08dd1ab5c187
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 14:03:29.4210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xdtH+xvZsHJ+C2U8K3FYUQMf5qCwSr/Xc/VNCfVOmTZHvgLF8n4YPqgXiVg5So2c7nfuDbNbvaKmI/f1LRWoJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR15MB6363
X-Proofpoint-GUID: 9qrB5g5y0kF6QJAapzNWKE8BwY9VKBq8
X-Proofpoint-ORIG-GUID: 9qrB5g5y0kF6QJAapzNWKE8BwY9VKBq8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH] RDMA/siw: Remove direct link to net_device
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=965 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=2 engine=8.19.0-2411120000 definitions=main-2412120101



> -----Original Message-----
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> Sent: Thursday, December 12, 2024 2:26 PM
> To: Bernard Metzler <BMT@zurich.ibm.com>; Leon Romanovsky <leon@kernel.or=
g>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>; linux-rdma@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Remove direct link to net_device
>=20
> =E5=9C=A8 2024/12/12 11:20, Bernard Metzler =E5=86=99=E9=81=93:
> >
> >
> >> -----Original Message-----
> >> From: Leon Romanovsky <leon@kernel.org>
> >> Sent: Tuesday, December 10, 2024 8:13 PM
> >> To: Bernard Metzler <BMT@zurich.ibm.com>
> >> Cc: Jason Gunthorpe <jgg@ziepe.ca>; linux-rdma@vger.kernel.org
> >> Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Remove direct link to
> net_device
> >>
> >> On Tue, Dec 10, 2024 at 05:08:51PM +0000, Bernard Metzler wrote:
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Jason Gunthorpe <jgg@ziepe.ca>
> >>>> Sent: Tuesday, December 10, 2024 3:56 PM
> >>>> To: Bernard Metzler <BMT@zurich.ibm.com>
> >>>> Cc: linux-rdma@vger.kernel.org; leon@kernel.org; linux-
> >>>> kernel@vger.kernel.org; netdev@vger.kernel.org; syzkaller-
> >>>> bugs@googlegroups.com; zyjzyj2000@gmail.com;
> >>>> syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
> >>>> Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Remove direct link to
> >> net_device
> >>>>
> >>>> On Tue, Dec 10, 2024 at 02:03:51PM +0100, Bernard Metzler wrote:
> >>>>> diff --git a/drivers/infiniband/sw/siw/siw.h
> >>>> b/drivers/infiniband/sw/siw/siw.h
> >>>>> index 86d4d6a2170e..c8f75527b513 100644
> >>>>> --- a/drivers/infiniband/sw/siw/siw.h
> >>>>> +++ b/drivers/infiniband/sw/siw/siw.h
> >>>>> @@ -69,16 +69,19 @@ struct siw_pd {
> >>>>>
> >>>>>   struct siw_device {
> >>>>>   	struct ib_device base_dev;
> >>>>> -	struct net_device *netdev;
> >>>>>   	struct siw_dev_cap attrs;
> >>>>>
> >>>>>   	u32 vendor_part_id;
> >>>>> +	struct {
> >>>>> +		int ifindex;
> >>>>
> >>>> ifindex is only stable so long as you are holding a reference on the
> >>>> netdev..
> >>>>> --- a/drivers/infiniband/sw/siw/siw_main.c
> >>>>> +++ b/drivers/infiniband/sw/siw/siw_main.c
> >>>>> @@ -287,7 +287,6 @@ static struct siw_device
> >> *siw_device_create(struct
> >>>> net_device *netdev)
> >>>>>   		return NULL;
> >>>>>
> >>>>>   	base_dev =3D &sdev->base_dev;
> >>>>> -	sdev->netdev =3D netdev;
> >>>>
> >>>> Like here needed to grab a reference before storing the pointer in t=
he
> >>>> sdev struct.
> >>>>
> >>>
> >>> This patch was supposed to remove siw's link to netdev. So no
> >>> reference to netdev would be needed. I did it under the
> >>> assumption siw can locally keep all needed information up to
> >>> date via netdev_event().
> >>> But it seems the netdev itself can change during the lifetime of
> >>> a siw device? With that ifindex would become wrong.
> >>>
> >>> If the netdev can change without the siw driver being informed,
> >>> holding a netdev pointer or reference seems useless.
> >>>
> >>> So it would be best to always use ib_device_get_netdev() to get
> >>> a valid netdev pointer, if current netdev info is needed by the
> >>> driver?
> >>
> >> Or call to dev_hold(netdev) in siw_device_create(). It will make sure
> >> that netdev is stable.
> >>
> >> Thanks
> >>
> >> BTW, Need to check, maybe IB/core layer already called to dev_hold.
> >>
> >
> > Yes, drivers are calling ib_device_set_netdev(ibdev, netdev, port)
> > during newlink(), which assigns the netdev to the ib_device's port
> > info. The ibdev takes a hold on the ports netdev and handles the
> > pointer assignment, clearing etc. appropriately. Unlinking is done
> > via ib_device_set_netdev(, NULL, ), or ib_unregister_device()
> > which unlinks and puts netdevs as well.
> >
> > Given we have an instance taking care of the netdev, it is
> > probably best to remove all direct netdev references from the
> > driver - just to avoid replicating all its complex handling.
> > So siw will use ib_device_get_netdev() whenever netdev info
> > is required. It comes with some extra overhead, but its's more
> > consistent.
> >
> > BTW: The rdma_link interface is asymmetric, lacking an unlink()
> > call. For using software only drivers it might be beneficial to
> > allow explicit unlinking a driver from a device. Any thoughts
> > on that?
>=20
> I agree with you. In the following link, I add del_link call. If you all
> agree, I can separate this patch from the patchset
> https%=20
> 3A__patchwork.kernel.org_project_linux-2Drdma_cover_20230624073927.707915-
> 2D1-2Dyanjun.zhu-
> 40intel.com_&d=3DDwIDaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZXbhvo=
vE4tYSbq
> xyOwdSiLedP4yO55g&m=3DZZJw4ol3n9SvffK8DJ1lwRkQXBPZ-qpbQp6X_oCD_cew0-
> 58ycdbtP0xYixv2ZHU&s=3D4VqxUZZs6UW1_XUZD01FoLNvoG1V-ETdi64KqLONDeI&e=3D .
>=20
>=20

Ah, nldev dellink is already there but no rdma_link_ops.dellink().
It just calls ib_unregister_device(), which is sufficient for siw,
but rxe want to do some extra work.

Thanks,
Bernard.

