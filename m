Return-Path: <linux-rdma+bounces-4803-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F80296F4FB
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 15:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C131F25891
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 13:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E286C1CDA26;
	Fri,  6 Sep 2024 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A/5Ma1HS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5731CB330;
	Fri,  6 Sep 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627787; cv=fail; b=sDDQRN/WfR5N5CY/8cSurT3N3V0Aiv3bYnkhSCzxl+/PigL88fwhxRL7PXzW27oUDxlkYaSz+r70SAMVgpiXm1A7cmkpKrBwcZ827GJTYRU77yViS5JLm1gbDuhC/oIj2FeOLyP8rIqY0926W1xQLftuiWulzZWIhC9zO3cGrV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627787; c=relaxed/simple;
	bh=+/3Bqafy7RPobHN2ERLpIBV2Z8qpl5jykbEOXaVDKIw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=iAcpqPmR3OCpD+3HsxOHJDTeOuoTL8Gh5NpuRhPfsouAPDtEScw8EVdcvodJDQgGitkADap1ppETdhJkS80+bHQ8NpfJSpw3+iqE7WX3OvQ73p78pgB2/NYxrEe6m8OP5JojJrJCvcmpcRfMeRnaLvBHyzifvqD7QC0NdKLshRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A/5Ma1HS; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4866GX6g013470;
	Fri, 6 Sep 2024 13:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:date:message-id:references:in-reply-to:content-type
	:content-transfer-encoding:mime-version:subject; s=pp1; bh=+/3Bq
	afy7RPobHN2ERLpIBV2Z8qpl5jykbEOXaVDKIw=; b=A/5Ma1HS9b54CzLwe9Psh
	0XlTLFArJshL0CdU8+8g/vGukoyPtQtUEFhNc+1WTmeITHowa02cFE2pifHcIk36
	2V0PNI9tduiHHidW4KNGUSzzwWZ6jJb4Jyg+7U6gmRZ2a8S+nOJzKyFyhBE3+OWf
	WUkg3XEZHHYi4vmJKD1oocvbMTVL6wuZlcszXT+bCFwwyLjXciaa4AGeYyhv2F70
	zzdp0w4H+I2b1LBNTJyi+nVyo9sGSs2H7V59T4VzL6/RC/XyaoP+xOzUyhyIQpJR
	oMfJ2qE4vbByTtSjoaBjvGfPJiBCH5zeQv3I5st27HklFmRp55sCyHjLnys9b7hr
	g==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41fj2a45vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 13:02:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxA1XpRxyQx9LMTJs7twKYJJxSlNtd8nEkWf1ZPsxs6OKBx6AZ3Jopu/LXc1nKh8df1OCd8sSSu6zJrf9Q9dELNy5ag2w9EpAsLYmZ5KMOKet37ZyRFA+rPeonkobJ977khoWCD6p0k+KlrLqaGfMhQKGI+cedUDnQqDcDdFF/DdHDU0yZStvpMNxP0BQN+6gOrkplOy/mrU9klIs/jtUMz9YG2IA4krv4IsIJxHDWM4fjCelgm6mg/JHtoixd7vXjxZmHPw+Q/qL19ss1vV9h4FVjD5DVIuIbdQPy7Z5zpzcy7/1WqcLD0uTwQtKUbdRCRUy+I9/dErAVWr2cfz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2xTy0bXpIJe0MwQt1JPa9gQZaEB5zhtMXwDceJmalw=;
 b=CIaKsQl9IUyjPVNHfz+zOr3B1NQAfbZbeV3fynf95+kidC/mY/GmiXjnsmK4al9+JxcVL7LzeFcqo9RvoNF1Z71Z4QiWBSp9YhgSFvlmQUp/3sMFKbZrdP6jbvhnMUH4Cgwa4opfiDZCZxx00S5skQpQ0VQXEkD1+fcEaX5dQNlou6tMpSEI+6MLMDCM6LahbfeTW+06y45wQtqMQbIQEHlU5FPYoI9VYQJ/apD3Hor86ZL8gYKgcbnxqrqCB3r7xoW2msN5kowJifjcM8siSDwWTt9Sz/jCcEoUNdNViQsQhHCsnu4+N6UxFcZ2eh5btvls32XhuNCXQnStyTbN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by SJ0PR15MB4407.namprd15.prod.outlook.com (2603:10b6:a03:370::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 13:02:37 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 13:02:34 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Edward Srouji <edwards@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>,
        Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Leon Romanovsky <leonro@nvidia.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 0/2] Introduce mlx5 data direct
 placement (DDP)
Thread-Index: AQHa/pAYj9Ti3XDtLE2jpj7jDARLKLJHS20AgAA5ewCAAZrLgIABnA3g
Date: Fri, 6 Sep 2024 13:02:34 +0000
Message-ID:
 <BN8PR15MB251386C0530C14E035394B64999E2@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <cover.1725362773.git.leon@kernel.org>
 <829ac3ed-a338-4589-a76d-77bb165f0608@linux.dev>
 <f0e05a6d-6f9c-4351-af7a-7227fb3998be@nvidia.com>
 <aaf9263b-931e-4b1d-8aea-1218faec2802@linux.dev>
 <09db1552-db97-4e82-9517-3b67c4b33feb@nvidia.com>
In-Reply-To: <09db1552-db97-4e82-9517-3b67c4b33feb@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|SJ0PR15MB4407:EE_
x-ms-office365-filtering-correlation-id: 8f391fb5-e187-4e58-ad71-08dcce742cef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2tXRW5aZmgrS0ZpWVZPTVpJUTR5U0tiTWp6eVhITU5IZ0pFRWNKZ3F2MXd0?=
 =?utf-8?B?L2hVTEF3bkEyNDZpY25TUzBvZ3ZRUG1DSitKalRuYkNxYlRwY2paOVBjd1Vm?=
 =?utf-8?B?RCtNSktFTEhzZlN4TzR5NWVXeVZNS2pYWWU4MUxMSlhvYjJvNUV0TzhYdW1a?=
 =?utf-8?B?dDdUYWE1Tk5BQnJtVnpXQWp5czQ2MEc0OG9taTFLN0pXVWQ3SlZUb0RMb0cy?=
 =?utf-8?B?Z3JJTERUN3AxMnEvdDMxbnI3N0ZDN3NXUVE3LzVmaVRDVDg0cFJZS2Q3SUxm?=
 =?utf-8?B?VU9CdE5lSDRLejRsKzhRWE5pbi8wSzFkcE1meXEzMWZ2SFU0bU5HMk5nYmdp?=
 =?utf-8?B?ZUlMekdFRzZObTJnbE8yYktSaGk5TFRHK0EwOGpSbi94R29TWU9TNGtYSEZR?=
 =?utf-8?B?Qi9TME1pbFBPOTlOcWh5emJ5Z1UrK09qZTJ5TUE3emFJbWh3RDI3Z1pJdHU2?=
 =?utf-8?B?TWo3VTB1QUQ4QlhGaFdHSWdLL21hVG1nc0g1WUdPVmRpTW5XMFF0Zk5hZ1JM?=
 =?utf-8?B?M2xKY1QzM0EvVGluVUVhZlNtTDYrR1Jpb0FOMS96VUw4Wk9oK2Jvckhxa1NE?=
 =?utf-8?B?YWdoK29qSW94Wlhhcm1pTzVOMG1pbkhnWitSNE5qbENCbFZMdlo0Y1lmbE1w?=
 =?utf-8?B?U1phSmg0SS9iV1ZFL3phSERJeEw3WmpmUDNvdVY2eEdVOG13Qm9lOUFrbzV5?=
 =?utf-8?B?YlU3WDVrQnVkcW9ybUJ4VmhTS21SQVBxTGRaT0RZU3J6ZXU0SUozVmhCMlE4?=
 =?utf-8?B?ZXdWTnVYNlpITTZLbGUrdmJMdk1HcXJzTGNLVkRWc1h3amx4ZzFJclQ3bjY1?=
 =?utf-8?B?N0RlU2VhdHVlVmhhUVF2dzF0R3BRVG9lb24vV2xCNTBLVzF1VmRkWFhxYVBz?=
 =?utf-8?B?bHlERXVYZUQrSDNNVjRsSmtxMXJFYTJmL0k0anhkdG5hWTAwbVhCeHpYVWdq?=
 =?utf-8?B?Y0J6U09QSmZtakxRZG1JVmNoV0FJN2YrL2JPNjBFRUdFSlNwYzkrL1BNaDhY?=
 =?utf-8?B?MHlWUVoyMFdyRnV4U3JkY1E3M3FOYWhrSVhEYWh6OWdMSHg5NXFMYjhGby93?=
 =?utf-8?B?djdOYkR4bWNnRUMyRGg2NzVEa3V5OEZId0JOSE9uRitWMDZ1VVRvQWk3bW44?=
 =?utf-8?B?d1Npdi85b0ZBbEtiaHVHWlpDaGZMR0dvQ0JJYVRjUGdLVTlEYUJqMGNCZGdD?=
 =?utf-8?B?UmlMbkxHTC9vVTczMkFlNGNwMVBkOFYzajd5TzQ2aE8wWE9PVHJocnlBODZp?=
 =?utf-8?B?cndLdXI3emlXdVdWWmIvLzRXT1hNK1ZhZHJPUXRlU3JqUThUR0ZPQ1d1dzQ4?=
 =?utf-8?B?elY5YWUyczlhYllEeWdlVU84MHBnVjYxS3gzVXVIRHI0OFMraHBTS1BzM2Nr?=
 =?utf-8?B?VzF1SkZLTXZCREdQVkFHaDdiZDhMN2lYSkVXaWExWWI1Y0wxR0Jvbks2R0Ux?=
 =?utf-8?B?SElIVTh1OUpIMHJaVG5DSVJZWUtmaERxckx6MHpiTkJaYW5OcGpaLzcwRWww?=
 =?utf-8?B?TWkvYlo1S05IQmplaVdDbDlpdkE1eHVHYVk5Z2U5N3RsN2s3Z1ZsbUJrU2VS?=
 =?utf-8?B?M1prRlNMWTBoVFJoTUZNcDFPdjUrc25VYytCbVg4eDFFVGFVaEc5cG4rbkpH?=
 =?utf-8?B?cHp1d3FQbnVVa205NXJWbllWQzNWc2tqajl3dy9MdVVmTWhTNm9nc1RORDF0?=
 =?utf-8?B?dkp4cFRUdTlJcFE1Z0hlZGNhQ0hubE12YzVUa096b2dkcExIenZwalJjS1Nh?=
 =?utf-8?B?bXZaMXgzTHFFQndJK0NVQWFmZ3ZObHVnSjRPUWFWTUMyWG1Qcy9hUkRYRmNZ?=
 =?utf-8?Q?+P8LhR813UiJ4hxa5A5na02gDaSsp6VRApfDU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ly9FUDViaWJiTVR5V3NUbm9vUHNmWGdreDVGcXNYc2hmekZ2ZUtUVUpUZjE2?=
 =?utf-8?B?aUdDSE5xcXZzc3hOMjVaSUxlWk95YWNTS05VY2I0QlNYNjRYMlpiRWJ1dENH?=
 =?utf-8?B?OUJuSGFSTjhneXlkMlJKUXJtN0NlUDMyQTZDZnFjRU9wN3pBSnRPaXc1ekNZ?=
 =?utf-8?B?VGtENXl2RGZjME9nMjVWcVFXSktneE11LzJWLzQ4S25wSVIxbTZKak4wRml0?=
 =?utf-8?B?ZVlwdktQYXlOcVZEVmRiZ2dpaU1Bbi9Gbnl2Q2l0MkZLZzdUWSsyZDFjZTMz?=
 =?utf-8?B?NDF4WHRIU3hIY2lLM29NNzc1Z0d2d2J4dmtqVXpWS09WcWVNUXdBUCthcCsv?=
 =?utf-8?B?VjVmWEN0U3JmbndjRXkrcFpLdUhlL2o3UEdwYVNwWEEvWWV5MGRSQVpuTjZE?=
 =?utf-8?B?cVA1RWNScG1WMWQ4QkZPbTZ3c1djTERMenhtMllNdkZmYnlVbk5kOVJNNmRt?=
 =?utf-8?B?ZDVTN29IdmIrbllBR2YvUFhRTVRPcktRTEhESit4RGxjQTFsVGo5ZGJKb1l0?=
 =?utf-8?B?ZG02S2NYazhMZVFkb0podENFdXZ4eDFxT2MwUEE4UVVEMXh6eFFYYkRYK0hj?=
 =?utf-8?B?RytiT0E3WTZaNVFWcXdpTSt6aU51endodUh5MTlNdER3QUgvVDIwbC90cW5t?=
 =?utf-8?B?cktsT1FBNHdHZmJvSCtCOUVmaS9NSmFwWTFkRjM0bTlwRVlKVGJkTkFmYlgx?=
 =?utf-8?B?aFFlS29zRlRhT085dXFHWWxUdlJFOGN1dXJZQ3BjemZTb3oxRWJkT2FVSXov?=
 =?utf-8?B?dTU3eC9wbTcxU2diandNMWdmb3VIU1BlMXZOQ0ZWeWZlRUpvT0lYYzkxMmlV?=
 =?utf-8?B?OUZUWDg5UWFiZFNrSVVpanRpTnI2VGNYYlhvNW9SUENWN01pTzk4aTBZVDE0?=
 =?utf-8?B?QmZLVS9Sdi9FRUxqTWlpNnBhdUtNMGlneXNyZ2xnRThWV09ZUlYwZlZsbDRZ?=
 =?utf-8?B?dmFyQ1hzOStQYnFKYjBPTFV4d3RrUG9yOW5DTXE2K2JUeTZyS0Z2ZjlOUnpE?=
 =?utf-8?B?MlBCaGVSc0pOeDl3NmIxSjdMT0RET3oxLzAvNzJwSTdxWUx6N0pUV09tN1Ja?=
 =?utf-8?B?TGZjY0NlTVo1Wm1sRjBCRDd1K0R0Q01kL1UxdVYreGRSN3d6bVBpY3JFcnFs?=
 =?utf-8?B?c2dpUjcxK1VXeGNQTERCdTduR2x5aktnTkEwbEdZQ0diOXVLRElkZ1ZzNmpt?=
 =?utf-8?B?R2tiR2p5K1UrN2ZnTGg0em02R3lQU2NOZDkwakprUjJ1K3pGQUtXTkNVTUJi?=
 =?utf-8?B?bUVWZEVFLzNRSGdTME1PcjErZlZ2SXVWa0JjNzJKTlBydTgwclN4WlhmT3RQ?=
 =?utf-8?B?WXhMeEdNUXpkNU9GcTkydjRUTEEydEtoS1UwS3FxdnBrQkljVzRzTEtOMHVG?=
 =?utf-8?B?emplT3lKTytSaGtLR2t3U2MxQkFGTGQ5OGR5enNBTjNDcVh4Zkp0bTdNQXV6?=
 =?utf-8?B?WHQrOTk0bS9pR3NaUUF0eVZKRm5za0x0bGVwZHhLT1NPTjRWZVpWUTh3a043?=
 =?utf-8?B?MG10L3NTWTlsWWNCYm5ud0FmdTRvdHZsMFBUR1Y0WlEyQjJsOVBacktrelVw?=
 =?utf-8?B?N0FyVklHczdXYU5rc2p5VEM2Nk9Rc3FvVVFPZ1ZLVGlZSG1YTXZYUG5FblhX?=
 =?utf-8?B?NW9vSFdhUzRvV3A3VkV4UGdNWG9jTDZHaHpGb1ZsODFOd1lRdDNwTnAzZmtB?=
 =?utf-8?B?aDcvMDlDTEl6dnlqUmZ2WXFkS3RTeTh4NGNDK0o5aXd3dUwyUGM2dUp2WFZE?=
 =?utf-8?B?ZFJ0Nll5WkZrNDJoQU92N0RvWVNjZm9ienlYNmNiQmQ2OGtWSHZ0UERJUzZI?=
 =?utf-8?B?bzEwU041dWhlNDZFSUF6NytVSHJVWVAzV3JIKzA1WUVWaTE2YWs1U3E0VGVs?=
 =?utf-8?B?OTkwNDduVlBKdVVCNUpJN21pUlpibk9QWWtVeHdPejIrYXUrNzJSVDhidThw?=
 =?utf-8?B?UkZjN0FiYnZZR3JMTTNMS1YvcWVJZVEzTnhBS2g2ZEpxT1lxUVUzajM1Ulhm?=
 =?utf-8?B?TThuV0tZeS9hcWswS2xQZVdrYkwrd0lUOWtEQi9yK1R6Ui9HRytpZUhXd0lx?=
 =?utf-8?B?U2RZS0NObUwvVDZDdHA0b0phNG0rWlBJRGQ4cDZZaitZSjlBWHg5YnROY1Jh?=
 =?utf-8?B?VDhEbFpkaXQ2Nk1KRlFlcVFYMStpUldoS0kvSUhkQSs4TkRCOVlpVDhEbUM1?=
 =?utf-8?Q?hQHjhMAsIz9H7OPIKKWf8jA=3D?=
Content-Type: text/plain; charset="utf-8"
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f391fb5-e187-4e58-ad71-08dcce742cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 13:02:34.4967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0EmmZdws6FawSo5HTCDAY9GoFW//eAOuEPb2DsKtMbLD+jVndoJblItB3U0C7mpQ4kED7TgzxDd5GUVS9bYBJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4407
X-Proofpoint-GUID: v5ODRv6rTR4T8yD8NPNbgEl67mIb3yUT
X-Proofpoint-ORIG-GUID: v5ODRv6rTR4T8yD8NPNbgEl67mIb3yUT
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH rdma-next 0/2] Introduce mlx5 data direct placement (DDP)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_02,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=786 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060096

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRWR3YXJkIFNyb3VqaSA8
ZWR3YXJkc0BudmlkaWEuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDUsIDIwMjQg
MjoyMyBQTQ0KPiBUbzogWmh1IFlhbmp1biA8eWFuanVuLnpodUBsaW51eC5kZXY+OyBMZW9uIFJv
bWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz47DQo+IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRp
YS5jb20+DQo+IENjOiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0BudmlkaWEuY29tPjsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IFNhZWVkIE1haGFtZWVkDQo+IDxzYWVlZG1AbnZpZGlhLmNv
bT47IFRhcmlxIFRvdWthbiA8dGFyaXF0QG52aWRpYS5jb20+OyBZaXNoYWkgSGFkYXMNCj4gPHlp
c2hhaWhAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIIHJkbWEt
bmV4dCAwLzJdIEludHJvZHVjZSBtbHg1IGRhdGEgZGlyZWN0DQo+IHBsYWNlbWVudCAoRERQKQ0K
PiANCj4gDQo+IE9uIDkvNC8yMDI0IDI6NTMgUE0sIFpodSBZYW5qdW4gd3JvdGU6DQo+ID4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4g
Pg0KPiA+DQo+ID4g5ZyoIDIwMjQvOS80IDE2OjI3LCBFZHdhcmQgU3JvdWppIOWGmemBkzoNCj4g
Pj4NCj4gPj4gT24gOS80LzIwMjQgOTowMiBBTSwgWmh1IFlhbmp1biB3cm90ZToNCj4gPj4+IEV4
dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+
ID4+Pg0KPiA+Pj4NCj4gPj4+IOWcqCAyMDI0LzkvMyAxOTozNywgTGVvbiBSb21hbm92c2t5IOWG
memBkzoNCj4gPj4+PiBGcm9tOiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0BudmlkaWEuY29tPg0K
PiA+Pj4+DQo+ID4+Pj4gSGksDQo+ID4+Pj4NCj4gPj4+PiBUaGlzIHNlcmllcyBmcm9tIEVkd2Fy
ZCBpbnRyb2R1Y2VzIG1seDUgZGF0YSBkaXJlY3QgcGxhY2VtZW50IChERFApDQo+ID4+Pj4gZmVh
dHVyZS4NCj4gPj4+Pg0KPiA+Pj4+IFRoaXMgZmVhdHVyZSBhbGxvd3MgV1JzIG9uIHRoZSByZWNl
aXZlciBzaWRlIG9mIHRoZSBRUCB0byBiZSBjb25zdW1lZA0KPiA+Pj4+IG91dCBvZiBvcmRlciwg
cGVybWl0dGluZyB0aGUgc2VuZGVyIHNpZGUgdG8gdHJhbnNtaXQgbWVzc2FnZXMgd2l0aG91dA0K
PiA+Pj4+IGd1YXJhbnRlZWluZyBhcnJpdmFsIG9yZGVyIG9uIHRoZSByZWNlaXZlciBzaWRlLg0K
PiA+Pj4+DQo+ID4+Pj4gV2hlbiBlbmFibGVkLCB0aGUgY29tcGxldGlvbiBvcmRlcmluZyBvZiBX
UnMgcmVtYWlucyBpbi1vcmRlciwNCj4gPj4+PiByZWdhcmRsZXNzIG9mIHRoZSBSZWNlaXZlIFdS
cyBjb25zdW1wdGlvbiBvcmRlci4NCj4gPj4+Pg0KPiA+Pj4+IFJETUEgUmVhZCBhbmQgUkRNQSBB
dG9taWMgb3BlcmF0aW9ucyBvbiB0aGUgcmVzcG9uZGVyIHNpZGUgY29udGludWUgdG8NCj4gPj4+
PiBiZSBleGVjdXRlZCBpbi1vcmRlciwgd2hpbGUgdGhlIG9yZGVyaW5nIG9mIGRhdGEgcGxhY2Vt
ZW50IGZvciBSRE1BDQo+ID4+Pj4gV3JpdGUgYW5kIFNlbmQgb3BlcmF0aW9ucyBpcyBub3QgZ3Vh
cmFudGVlZC4NCj4gPj4+DQo+ID4+PiBJdCBpcyBhbiBpbnRlcmVzdGluZyBmZWF0dXJlLiBJZiBJ
IGdvdCB0aGlzIGZlYXR1cmUgY29ycmVjdGx5LCB0aGlzDQo+ID4+PiBmZWF0dXJlIHBlcm1pdHMg
dGhlIHVzZXIgY29uc3VtZXMgdGhlIGRhdGEgb3V0IG9mIG9yZGVyIHdoZW4gUkRNQSBXcml0ZQ0K
PiA+Pj4gYW5kIFNlbmQgb3BlcmF0aW9ucy4gQnV0IGl0cyBjb21wbGV0aW9uZyBvcmRlcmluZyBp
cyBzdGlsbCBpbiBvcmRlci4NCj4gPj4+DQo+ID4+IENvcnJlY3QuDQo+ID4+PiBBbnkgc2NlbmFy
aW8gdGhhdCB0aGlzIGZlYXR1cmUgY2FuIGJlIGFwcGxpZWQgYW5kIHdoYXQgYmVuZWZpdHMgd2ls
bCBiZQ0KPiA+Pj4gZ290IGZyb20gdGhpcyBmZWF0dXJlPw0KPiA+Pj4NCj4gPj4+IEkgYW0ganVz
dCBjdXJpb3VzIGFib3V0IHRoaXMuIE5vcm1hbGx5IHRoZSB1c2VycyB3aWxsIGNvbnN1bWUgdGhl
IGRhdGENCj4gPj4+IGluIG9yZGVyLiBJbiB3aGF0IHNjZW5hcmlvLCB0aGUgdXNlciB3aWxsIGNv
bnN1bWUgdGhlIGRhdGEgb3V0IG9mDQo+ID4+PiBvcmRlcj8NCj4gPj4+DQo+ID4+IE9uZSBvZiB0
aGUgbWFpbiBiZW5lZml0cyBvZiB0aGlzIGZlYXR1cmUgaXMgYWNoaWV2aW5nIGhpZ2hlciBiYW5k
d2lkdGgNCj4gPj4gKEJXKSBieSBhbGxvd2luZw0KPiA+PiByZXNwb25kZXJzIHRvIHJlY2VpdmUg
cGFja2V0cyBvdXQgb2Ygb3JkZXIgKE9PTykuDQo+ID4+DQo+ID4+IEZvciBleGFtcGxlLCB0aGlz
IGNhbiBiZSB1dGlsaXplZCBpbiBkZXZpY2VzIHRoYXQgc3VwcG9ydCBtdWx0aS1wbGFuZQ0KPiA+
PiBmdW5jdGlvbmFsaXR5LA0KPiA+PiBhcyBpbnRyb2R1Y2VkIGluIHRoZSAiTXVsdGktcGxhbmUg
c3VwcG9ydCBmb3IgbWx4NSIgc2VyaWVzIFsxXS4gV2hlbg0KPiA+PiBtbHg1IG11bHRpLXBsYW5l
DQo+ID4+IGlzIHN1cHBvcnRlZCwgYSBzaW5nbGUgbG9naWNhbCBtbHg1IHBvcnQgYWdncmVnYXRl
cyBtdWx0aXBsZSBwaHlzaWNhbA0KPiA+PiBwbGFuZSBwb3J0cy4NCj4gPj4gSW4gdGhpcyBzY2Vu
YXJpbywgdGhlIHJlcXVlc3RlciBjYW4gInNwcmF5IiBwYWNrZXRzIGFjcm9zcyB0aGUNCj4gPj4g
bXVsdGlwbGUgcGh5c2ljYWwNCj4gPj4gcGxhbmUgcG9ydHMgd2l0aG91dCBndWFyYW50ZWVpbmcg
cGFja2V0IG9yZGVyLCBlaXRoZXIgb24gdGhlIHdpcmUgb3INCj4gPj4gb24gdGhlIHJlY2VpdmVy
DQo+ID4+IChyZXNwb25kZXIpIHNpZGUuDQo+ID4+DQo+ID4+IFdpdGggdGhpcyBhcHByb2FjaCwg
bm8gYmFycmllcnMgb3IgZmVuY2VzIGFyZSByZXF1aXJlZCB0byBlbnN1cmUNCj4gPj4gaW4tb3Jk
ZXIgcGFja2V0DQo+ID4+IHJlY2VwdGlvbiwgd2hpY2ggb3B0aW1pemVzIHRoZSBkYXRhIHBhdGgg
Zm9yIHBlcmZvcm1hbmNlLiBUaGlzIGNhbg0KPiA+PiByZXN1bHQgaW4gYmV0dGVyDQo+ID4+IEJX
LCB0aGVvcmV0aWNhbGx5IGFjaGlldmluZyBsaW5lLXJhdGUgcGVyZm9ybWFuY2UgZXF1aXZhbGVu
dCB0byB0aGUNCj4gPj4gc3VtIG9mDQo+ID4+IHRoZSBtYXhpbXVtIEJXIG9mIGFsbCBwaHlzaWNh
bCBwbGFuZSBwb3J0cywgd2l0aCBvbmx5IG9uZSBRUC4NCj4gPg0KPiA+IFRoYW5rcyBhIGxvdCBm
b3IgeW91ciBxdWljayByZXBseS4gV2l0aG91dCBlbnN1cmluZyBpbi1vcmRlciBwYWNrZXQNCj4g
PiByZWNlcHRpb24sIHRoaXMgZG9lcyBvcHRpbWl6ZSB0aGUgZGF0YSBwYXRoIGZvciBwZXJmb3Jt
YW5jZS4NCj4gPg0KPiA+IEkgYWdyZWUgd2l0aCB5b3UuDQo+ID4NCj4gPiBCdXQgaG93IGRvZXMg
dGhlIHJlY2VpdmVyIGdldCB0aGUgY29ycmVjdCBwYWNrZXRzIGZyb20gdGhlIG91dC1vZi1vcmRl
cg0KPiA+IHBhY2tldHMgZWZmaWNpZW50bHk/DQo+ID4NCj4gPiBUaGUgbWV0aG9kIGlzIGltcGxl
bWVudGVkIGluIFNvZnR3YXJlIG9yIEhhcmR3YXJlPw0KPiANCj4gDQo+IFRoZSBwYWNrZXRzIGhh
dmUgbmV3IGZpZWxkIHRoYXQgaXMgdXNlZCBieSB0aGUgSFcgdG8gdW5kZXJzdGFuZCB0aGUNCj4g
Y29ycmVjdCBtZXNzYWdlIG9yZGVyIChzaW1pbGFyIHRvIFBTTikuDQo+IA0KSW50ZXJlc3Rpbmcg
ZmVhdHVyZSEgUmVtaW5kcyBtZSBzb21laG93IG9uIGlXYXJwIFJETUEgd2l0aCBpdHMNCkREUCBz
dWItbGF5ZXIg8J+YiQ0KQnV0IGNhbiB0aGF0IGV4dHJhIGZpZWxkIGJlIGNvbXBsaWFudCB3aXRo
IHRoZSBzdGFuZGFyZGl6ZWQgd2lyZQ0KcHJvdG9jb2w/DQoNClRoYW5rcywNCkJlcm5hcmQuDQoN
Cj4gT25jZSB0aGUgcGFja2V0cyBhcnJpdmUgT09PIHRvIHRoZSByZWNlaXZlciBzaWRlLCB0aGUg
ZGF0YSBpcyBzY2F0dGVyZWQNCj4gZGlyZWN0bHkgKGhlbmNlIHRoZSBERFAgLSAiRGlyZWN0IERh
dGEgUGxhY2VtZW50IiBuYW1lKSBieSB0aGUgSFcuDQo+IA0KPiBTbyB0aGUgZWZmaWNpZW5jeSBp
cyBhY2hpZXZlZCBieSB0aGUgSFcsIGFzIGl0IGFsc28gc2F2ZXMgdGhlIHJlcXVpcmVkDQo+IGNv
bnRleHQgYW5kIG1ldGFkYXRhIHNvIGl0IGNhbiBkZWxpdmVyIHRoZSBjb3JyZWN0IGNvbXBsZXRp
b24gdG8gdGhlDQo+IHVzZXIgKGluLW9yZGVyKSBvbmNlIHdlIGhhdmUgc29tZSBXUUVzIHRoYXQg
Y2FuIGJlIGNvbnNpZGVyZWQgYW4NCj4gImluLW9yZGVyIHdpbmRvdyIgYW5kIGJlIGRlbGl2ZXJl
ZCB0byB0aGUgdXNlci4NCj4gDQo+IFRoZSBTVy9BcHBsaWNhdGlvbnMgbWF5IHJlY2VpdmUgT09P
IFdSX0lEcyB0aG91Z2ggKGJlY2F1c2UgdGhlIGZpcnN0IENRRQ0KPiBtYXkgaGF2ZSBjb25zdW1l
ZCBSZWN2IFdRRSBvZiBhbnkgaW5kZXggb24gdGhlIHJlY2VpdmVyIHNpZGUpLCBhbmQgaXQncw0K
PiB0aGVpciByZXNwb25zaWJpbGl0eSB0byBoYW5kbGUgaXQgZnJvbSB0aGlzIHBvaW50LCBpZiBp
dCdzIHJlcXVpcmVkLg0KPiANCj4gPg0KPiA+IEkgYW0ganVzdCBpbnRlcmVzdGVkIGluIHRoaXMg
ZmVhdHVyZSBhbmQgd2FudCB0byBrbm93IG1vcmUgYWJvdXQgdGhpcy4NCj4gPg0KPiA+IFRoYW5r
cywNCj4gPg0KPiA+IFpodSBZYW5qdW4NCj4gPg0KPiA+Pg0KPiA+PiBbMV0gSU5WQUxJRCBVUkkg
UkVNT1ZFRA0KPiAzQV9fbG9yZS5rZXJuZWwub3JnX2xrbWxfY292ZXIuMTcxODU1MzkwMS5naXQu
bGVvbi0NCj4gNDBrZXJuZWwub3JnXyZkPUR3SURhUSZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEm
cj00eW5iNFNqXzRNVWNaWGJodm92RTR0WVNiDQo+IHF4eU93ZFNpTGVkUDR5TzU1ZyZtPXY3bXN0
Y1lMb2dhNEVkX2xhU0dwcWp1UWJuU2NnSENpZmx3bUE0VHp2WGdpOXg2NHFHWUI0Qw0KPiBaR0Zy
eFF2aVFGJnM9YS00ZEcxYnZ6TDNkUHNMc0NTa3ViZEhnXzllREtISXQtckVHUWRhWHZnVSZlPQ0K
PiA+Pj4gVGhhbmtzLA0KPiA+Pj4gWmh1IFlhbmp1bg0KPiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+IFRo
YW5rcw0KPiA+Pj4+DQo+ID4+Pj4gRWR3YXJkIFNyb3VqaSAoMik6DQo+ID4+Pj4gwqDCoCBuZXQv
bWx4NTogSW50cm9kdWNlIGRhdGEgcGxhY2VtZW50IG9yZGVyaW5nIGJpdHMNCj4gPj4+PiDCoMKg
IFJETUEvbWx4NTogU3VwcG9ydCBPT08gUlggV1FFIGNvbnN1bXB0aW9uDQo+ID4+Pj4NCj4gPj4+
PiDCoCBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9tYWluLmPCoMKgwqAgfMKgIDggKysrKysN
Cj4gPj4+PiDCoCBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9tbHg1X2liLmggfMKgIDEgKw0K
PiA+Pj4+IMKgIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg1L3FwLmPCoMKgwqDCoMKgIHwgNTEN
Cj4gPj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4+Pj4gwqAgaW5jbHVkZS9s
aW51eC9tbHg1L21seDVfaWZjLmjCoMKgwqDCoMKgwqDCoCB8IDI0ICsrKysrKysrKy0tLS0NCj4g
Pj4+PiDCoCBpbmNsdWRlL3VhcGkvcmRtYS9tbHg1LWFiaS5owqDCoMKgwqDCoMKgwqDCoCB8wqAg
NSArKysNCj4gPj4+PiDCoCA1IGZpbGVzIGNoYW5nZWQsIDc4IGluc2VydGlvbnMoKyksIDExIGRl
bGV0aW9ucygtKQ0KPiA+Pj4+DQo+ID4+Pg0KPiA+IC0tDQo+ID4gQmVzdCBSZWdhcmRzLA0KPiA+
IFlhbmp1bi5aaHUNCj4gPg0KDQo=

