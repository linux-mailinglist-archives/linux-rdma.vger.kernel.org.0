Return-Path: <linux-rdma+bounces-6393-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F398D9EB776
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 18:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335D9164981
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6C7234997;
	Tue, 10 Dec 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JdU2Zrjm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B95C23498B
	for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850539; cv=fail; b=I9abXc1X89dybzYuwnJ35mWl4+1KS2+nNuh8uFPqfEmLTp2tDXSDJ2ozDicxTPlFsXkRayQRM8rsG77+s1v9J7ujio9n/yUxZ1AB0OlvXaDaUucxBaMx7Oc0m6hwrtPPacmhPxd3+MWic6M01INbmiU+H3zY5wSTyThFc0V5PMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850539; c=relaxed/simple;
	bh=WBFPXOk2rOJCCtEPizacRcQbBLIwin1qGli6PNZi2z4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=lBX66soTixyOi+J9UQeopX7dcOVpmanRL8+zg2W4/SC7UNQnjUdGHvThePRb/A2WH2XfjpuiT5kejUeDzt8ZGhvd1zWblJMuqzNpkrPuoN45WE1+YYgLLtY0E2FoqSHavH3/ASO7sJj9m6pltCAJ+LUsyBeEbW/ati52NIkPXmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JdU2Zrjm; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BADrZ9t025878;
	Tue, 10 Dec 2024 17:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WBFPXO
	k2rOJCCtEPizacRcQbBLIwin1qGli6PNZi2z4=; b=JdU2ZrjmyUir/lx8vaZ7KP
	lVtvJvnrPGUDgOxR9pALcY1zFF9agQP5Nh+tzWuUh013hlzTSldCYv1DVWMfs73i
	13/JP+ilGDtLChotWBVwwguN2sOqlL+ko6+hAgq8Qet9OqeBsXqtR+1pWUmOIteF
	YfWPhVXeKy+3LVlGbP/L8CdHtcJ9eVZ+0Bts8x5Eiw6ZzriDRUon+D1l7XK/2/Bn
	+Wgx2KRKBRdhNLwn3A47QQZWHkuIAVVBJEh4631c0jNK76chNTYrFKNYQeP45WWM
	6zurjUPAmJsxGwGRlBNdBw2A1NpzEb+aLTeqPiHbMV2GE7PKZX2uaXTVrF9OVOIA
	==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq7pnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 17:08:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0r0vffrJvPCoT8PFG9SK24wdpVY/9tjn5C6WTeZiTCMHmxUV+blHw1K5FqQ8k+Oet4J3AcfIkFuYNg186DE7Mzi9AH4vjp5gwPWrkkc3dDhMGWpEB93WndUS5M+RK1DcZxsgrw+kv/3hcO+YHwEkq9eN2F+jwk3l2IXF6bkJNEv73lh1/el53RoW4nGN4vRlczTREGV5236U2SF0uTYEE7ff4k2CxuQzErPsvNwRm+pL3qPNyThcu0TmVG0GD6cPfWhhdx1hjKp6/8CE9uikC3iGR7Wm2YCmcWn/o19lusDSzE+QeAZLXLvNVIZB0M9B1PjRhaFDy7IIzSBXw+gsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBFPXOk2rOJCCtEPizacRcQbBLIwin1qGli6PNZi2z4=;
 b=PvrLCxr/roRFkruyolNWLBSR/GcQ7y86LnWrESScBVSUxIFFYzPwMUYFd1g8+VNNlB+s5KoJh8YrCZmFkRkOY1OxfHViwqJhCii8jT/Ogy+wDtRdiiLAI9Auv4yqlhnYJ9rNDj+yDHJ+2iJkaEpwX/9ki1TULNW5mzKKjwYYA5P1vikBWU0YcxB9fzCpqBFEQowewWSEow6l7tjlorXe2FQ11X5YxlKpfqunkkLnBhjeVZnQCFoYUfMNX5MmTgT+QSeJFBTOxaPuCjVFzUINCYJGefUEmcqoS7Mg5ZdfHnpecqRxyqrQ5gWTc14Eij65m+JBwHlICHEUwU2TQwTQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by MW4PR15MB5158.namprd15.prod.outlook.com (2603:10b6:303:185::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 17:08:52 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 17:08:51 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] RDMA/siw: Remove direct link to
 net_device
Thread-Index: AQHbSwQv3cnSLCjGOEepm6Xze1BjgLLfkViAgAAKSlA=
Date: Tue, 10 Dec 2024 17:08:51 +0000
Message-ID:
 <BN8PR15MB2513CA1868B484175CB61E88993D2@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <20241210130351.406603-1-bmt@zurich.ibm.com>
 <20241210145627.GH1888283@ziepe.ca>
In-Reply-To: <20241210145627.GH1888283@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|MW4PR15MB5158:EE_
x-ms-office365-filtering-correlation-id: d0814036-f91b-4997-114a-08dd193d51bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlR2UlNPSXZiWHg0a2VmWk5EZDVaWFpmWGppQ1Ftdmx1M3RHcmliVVh3bGFw?=
 =?utf-8?B?RmtKTzNrbG1ab0VPVFRUN1VXSDRDWkJhdXZES1hBN3VPMlQzVmlNT1NuUGtQ?=
 =?utf-8?B?aDhkL2hLaFZIRE1tTW51aHYvdlpLL1dYZnh3NlNydlphVUxLcTdOZ1AvK2kv?=
 =?utf-8?B?anl1MmgwZVJ0cW9CaStDWEZUTTVTY1Uvb1NQR3JMZnp3MTl4TTg4YWV2UzhR?=
 =?utf-8?B?dm81dm01SkFVQjk3U0lwbFI0alpTWlFjVGNSUW44eit6MW5Id2YxMjR2clZo?=
 =?utf-8?B?R2sxV0hQamRwZU52SlZUSXdqVHV0emsyemhJelk0UjdJeFZ5dzRtQVRldTh0?=
 =?utf-8?B?d3RhU1RnR215SUdtM3JjUmhtL2RaRjVRNFplRVBGZWVpN3JSYWpVNG9NL1oz?=
 =?utf-8?B?R0EvYU9HU3VvT2NUUXNRQVlpMStvUnZWWFRXV2VXUy9pMmpqOWM5Vjc1TUMz?=
 =?utf-8?B?b09nRG5TZjNpaXpYQUR2OWF0bzZHZUNqY3B3bVdjWGs5QXBGd2I1UWx5WGFO?=
 =?utf-8?B?WWZEcVVFdENIOENFSG5KOUQ0bFNaU3k4TGx5Q2tZV3dLcXp4QXpFUHA5VjVv?=
 =?utf-8?B?eG4raW9VZ3VnUGtFeDZoT1YyYUViV3pzdlNESVp5YXJqYUN6bmhNMERwNElq?=
 =?utf-8?B?M29pbUN4LzFiZUsxbkQzczhQTVRaeURSamMwQi91c21lc1BIME1YdkF0SnRT?=
 =?utf-8?B?Q3FhTlV0S3lVUVZmeUIzT09VQzdGTE5wRlgraUFUZkswOEQ4K09oV3V0QmRI?=
 =?utf-8?B?TFpDekVZdjBBcDhwVUhhWTlzU0dGYy9aZ0w3bEk2NjJSdWFPU1dQcFc3T2FK?=
 =?utf-8?B?czAxUmRDWFlSSHVCbU1RWXB1WjBtc1VxT01UL0JLZHRNSDdqbmVuaVVyRGRD?=
 =?utf-8?B?MUF5bWQ4VGJabFlXeVZldW1wK1FDakNjbGU5ZnBNTnlvUGZIR1dDMTA1NGFS?=
 =?utf-8?B?ZnBvcjhqQjl2UnNkSWtYTDVNOGtVUnRnZkVxS1pLY2lyOWt4dXhwVlFnMWVY?=
 =?utf-8?B?UGlaU1p3NUVmWVFiUU5DV1Y5bFBPUWtDSXFaUjl6TURkL2JVZWtNY1ZZeC85?=
 =?utf-8?B?Nm9jZm1YYWpUZEU3U0p4SDJRbFkvM3pZTlRUMUdtL2YycFVhTmJwSTZCanZW?=
 =?utf-8?B?bnpVaW9nZXM5RFZhQXIzRUNoTlRuREJOcHJjbDFMNlIvOHQzcTJuVjZLSUJo?=
 =?utf-8?B?d0RMQjltaTZGS0wyUHdVR01BQ05JZWJteXlVbGVOK0R3ZkgyVHVtUVBJem5k?=
 =?utf-8?B?K05qYUlmZDNwQWI5NksrbnoycUkyUHlxNEw4SktGK1ArWE94MUZWUWdHQ1B2?=
 =?utf-8?B?Q1kySzZTVGVWSkVlbFZDM3hzWHFpY3Y4N1hTZ0g0ZFpocGF3VFdkYlJyNmtW?=
 =?utf-8?B?akxuWnlacnNKWWJMRW5Gb2E1bjdnU1Q3N3hPcFFCRDNoUzJuZ0grMXBxaHhr?=
 =?utf-8?B?cEZuWFd5VTdYcUxFZFA2THRoVjQwU0F5SndlbXNoZkp4Mk8rWjVQd3gzZ2o4?=
 =?utf-8?B?akVjRExjckhYYnJxN01uVFZZSlg5TC93bFcwR1V4YklFV0pCMk9PNi9QYk9x?=
 =?utf-8?B?TnlhaWVpb21HdlE0LzhVR20yWmVaM3lPYi8rS2JHczNqZEhKVmFZWnpuYktC?=
 =?utf-8?B?ZWt0cE5ucG5rVmV4alRkTysyN0pLUWViYU84bjNTUTBVK2FzbHRRY0FZSVUw?=
 =?utf-8?B?STB1ZkFDRWFaYitOK2J6a0YwZTZGOWJsUWM0dHczZXEwOXBEeWl0SXVYZ0Z3?=
 =?utf-8?B?S2pEam54ZUw0L1p0MnVUK1M5bEpHNzQ5Q2xJNy82dE14MFFPaGQxK3BJSCtP?=
 =?utf-8?B?ZGhDOWNSUXBVV2RnbmE0QzBXTU1NZHUzMVZjeHFlT3pWUUxac1JORGRWSG4z?=
 =?utf-8?B?bEhBanVMZi9SK1U1OE9xejY4UTFYMFJrTlZwTzdqLy9Wd3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2FucjEvaXBDZHRCa296eTJSS3k4OS9udUdiZG81N0NSaHQ2akVmRnpqVmJH?=
 =?utf-8?B?Y0lwdUl0UHFXUUtCc0hvM0xaYlU2eTM1WXJOM3IxdE5rOHU4WTR5amVaSUJ3?=
 =?utf-8?B?SlpkMHJxY1ZHT1dKYkZySG1nYmtVTUdOWHRsZ2FRanl1U3B3R3o1aGdFK2RU?=
 =?utf-8?B?Wi9EM0x5YXRUanpwSVpBUTh5dzVUMEtHSllWTGVaUEpYQ29mQ2pjS0F3cm9I?=
 =?utf-8?B?V0VuZmIzL0pDTGpQajNnWDlUbjhsa1VGemRRYXV1bitZRStLemdoL2l0MGJW?=
 =?utf-8?B?V09objN2cnpKNmloMUNJbDUra0Yxd1daY1J1eUZzMHYzSHhjb2ljM0l5VFJM?=
 =?utf-8?B?WjNpNm52d1BKcmg2cm9RZ3dJclJDaHNab2l4NHRydVJGZTVjcTk2QUlLVTBp?=
 =?utf-8?B?NWUvRFhUVG9pTk15dUE3d0ZBT2pVTGJSdEYxRUxyZlBYRjNzZExBYWNtUVgr?=
 =?utf-8?B?OTlwOW1DdHpURXFaeFBJUWVucHd1U1owNmw1dTN1VTkzaEFsR2VpcnBSekFu?=
 =?utf-8?B?aHNUUnVtaFdVemVRY21oM3NETTh5RHFLbHlTeFkvdlpLNzdZUGx6bUhOb1BY?=
 =?utf-8?B?N0JCY1NLSEZLL20yS2owU2Z1TWtQOTJmdFVrR3J1S0NvSjhCNTJNUFFTeFNC?=
 =?utf-8?B?eGRET2U3ZDAvV0I0cXljVDRSTTh4TThlSkZsSHRzVXFRdWpDUEpzOVJQSDhU?=
 =?utf-8?B?OGZUWGxMZjZYd0NIU2dpaWdoNUhpOTNEdThRaHJOQWJQV0lna2xpTUg2UUZZ?=
 =?utf-8?B?VUlOSGdDUVVhbWJKMkpDdFpGVnRLUHpCUE1WeFdvM0RwUzd3WjNtNEJiSHlu?=
 =?utf-8?B?U0ExQ1VyRHErN1liM0JWTEFDby8zL2UzRWFlRy95Q2lLcDYwMkhZQWNVVHpR?=
 =?utf-8?B?OGFqaytWUFRseGJ5SzdCSy9uQVpPZEJYU0RnMmowZGZIQkJFMUE2aEJidjJ4?=
 =?utf-8?B?YjFYK1k0UndNM2N5QkozdVdkRnFoUzBMcXkvcjdLWnVWUTFSQVplSFgvZklJ?=
 =?utf-8?B?SUN0WEcxS2NyUG5YdVBHbzd4K3NOT2diMlBnZmhiMkJOKzRGYVpTYUIrd3Bl?=
 =?utf-8?B?SlAzNUZqSzRYS1RvN2ZxTnNMK2xtZjlvamNzTkh3b0VZQkNIU05ISklBVkFR?=
 =?utf-8?B?bjRFMnlsQmNtYWZ6N1JoMWxWK2Rtd0tCWEx5N3dlNHY0VGNZaGIzWFJ3SUdu?=
 =?utf-8?B?T0NqYUdNOHNiMGxhWkxhbkU0dXdIZVByNkI3RmhDNFNNZ2RzTUxuQy9XWW1K?=
 =?utf-8?B?M3JhNWYza3dsVFIwUVhXODM4ZWErRTNYaDFaWndIL3lDYjRZZWVCTTV4K2Zq?=
 =?utf-8?B?VDFHQmRWem9TemJMbnlEcHdJYjMxZEtoMWFacXFmdC9UWjlmUjBhdWRwWFJS?=
 =?utf-8?B?N3pPck5UTlAvUk5IbDYrZ2dTQWhNVmo4L1owaTNzYU5ndnJEdkRHV2FVeGtL?=
 =?utf-8?B?TUJtcURUbDBJeEpmQ3NjSFJNYTNoNm9mZHJESmtXUmIvTFBENkg5SXBkL2gx?=
 =?utf-8?B?SEF2QS9hV0hWN3NrNnVlcGU0MDVTOGJ6aTNaak1YTkxmNGtmTW9mWUpnN1Nn?=
 =?utf-8?B?M1JxbFpoajRjQ09KRmRJbWxDNUNmZEtxREkzZkJuNXFwWDJMVkllUWxyc1Q3?=
 =?utf-8?B?RGh1OHc1ZlhtUzN6Yi8vcTZDdzloWlRPbDQxRi9pTi90dElCTzVXY2JJY2dT?=
 =?utf-8?B?TENraDUyYzdYZG1nMjBYYmp5S0VubC8yWWluTXQrSklQR3pvU1pGd3VyTmRz?=
 =?utf-8?B?aHVBNXFlNExLdEtVRWZqL1kwaFlST08vQTlkVlZKdmZzamNNR2NqL2RuMGU0?=
 =?utf-8?B?eGpCQTZWTXZwelF2ZGNxdVZTU09qcVNuNHhxNEZPS3Y1MFVJWkVIYjBJeDkv?=
 =?utf-8?B?bGhiRzFSeTBtRm5UaHY5azByWWt2RnQ5MmlDMytlVm9iOFFsZTNTVVRuMU9W?=
 =?utf-8?B?S3BEL1NNbVBxckQzclh2b3hqSnRhQkQzWUdzR0cvWjNJS2NLM0g2SzhkWGR2?=
 =?utf-8?B?Q3dpY1JBQnVteFdBeTAzdnhZOVpHZEVrVXV4emM2cnEyb2Z1a1VqdG53UHdT?=
 =?utf-8?B?elF3NklPUXh4TWMxSFVWNUptM2xhelJicHhiRWdlK1lDNk5NOXpUdVhVcTBo?=
 =?utf-8?B?YXBOak1IY05Rb0htT1VHN0tVQys3dDg2QnZJUFBLRFZySXM2bDNFYUEwTUVZ?=
 =?utf-8?Q?0F6jH42nGypMysfF7IsFf2E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d0814036-f91b-4997-114a-08dd193d51bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 17:08:51.1197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +tEMrNV1sRIX9rfJq4g+W6b1pSlXkIzjJcLtdZG5JRp1N9HDWpeyxCVxBJeQIIVKQPCec/HE51NbayldefFEyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5158
X-Proofpoint-ORIG-GUID: AHtd8VN7kQLo9a-2EiP2lqCsn_N6kLVW
X-Proofpoint-GUID: AHtd8VN7kQLo9a-2EiP2lqCsn_N6kLVW
Subject: RE: [PATCH] RDMA/siw: Remove direct link to net_device
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100126

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAemllcGUuY2E+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDEwLCAyMDI0IDM6NTYg
UE0NCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzogbGlu
dXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxlb25Aa2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IHN5emthbGxlci0NCj4g
YnVnc0Bnb29nbGVncm91cHMuY29tOyB6eWp6eWoyMDAwQGdtYWlsLmNvbTsNCj4gc3l6Ym90KzRi
ODc0ODk0MTBiNGVmZDE4MWJmQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gU3ViamVjdDog
W0VYVEVSTkFMXSBSZTogW1BBVENIXSBSRE1BL3NpdzogUmVtb3ZlIGRpcmVjdCBsaW5rIHRvIG5l
dF9kZXZpY2UNCj4gDQo+IE9uIFR1ZSwgRGVjIDEwLCAyMDI0IGF0IDAyOjAzOjUxUE0gKzAxMDAs
IEJlcm5hcmQgTWV0emxlciB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3Npdy9zaXcuaA0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3LmgNCj4g
PiBpbmRleCA4NmQ0ZDZhMjE3MGUuLmM4Zjc1NTI3YjUxMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5oDQo+ID4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3Npdy9zaXcuaA0KPiA+IEBAIC02OSwxNiArNjksMTkgQEAgc3RydWN0IHNpd19wZCB7DQo+
ID4NCj4gPiAgc3RydWN0IHNpd19kZXZpY2Ugew0KPiA+ICAJc3RydWN0IGliX2RldmljZSBiYXNl
X2RldjsNCj4gPiAtCXN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXY7DQo+ID4gIAlzdHJ1Y3Qgc2l3
X2Rldl9jYXAgYXR0cnM7DQo+ID4NCj4gPiAgCXUzMiB2ZW5kb3JfcGFydF9pZDsNCj4gPiArCXN0
cnVjdCB7DQo+ID4gKwkJaW50IGlmaW5kZXg7DQo+IA0KPiBpZmluZGV4IGlzIG9ubHkgc3RhYmxl
IHNvIGxvbmcgYXMgeW91IGFyZSBob2xkaW5nIGEgcmVmZXJlbmNlIG9uIHRoZQ0KPiBuZXRkZXYu
Lg0KPiA+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYw0KPiA+ICsr
KyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYw0KPiA+IEBAIC0yODcsNyAr
Mjg3LDYgQEAgc3RhdGljIHN0cnVjdCBzaXdfZGV2aWNlICpzaXdfZGV2aWNlX2NyZWF0ZShzdHJ1
Y3QNCj4gbmV0X2RldmljZSAqbmV0ZGV2KQ0KPiA+ICAJCXJldHVybiBOVUxMOw0KPiA+DQo+ID4g
IAliYXNlX2RldiA9ICZzZGV2LT5iYXNlX2RldjsNCj4gPiAtCXNkZXYtPm5ldGRldiA9IG5ldGRl
djsNCj4gDQo+IExpa2UgaGVyZSBuZWVkZWQgdG8gZ3JhYiBhIHJlZmVyZW5jZSBiZWZvcmUgc3Rv
cmluZyB0aGUgcG9pbnRlciBpbiB0aGUNCj4gc2RldiBzdHJ1Y3QuDQo+IA0KDQpUaGlzIHBhdGNo
IHdhcyBzdXBwb3NlZCB0byByZW1vdmUgc2l3J3MgbGluayB0byBuZXRkZXYuIFNvIG5vDQpyZWZl
cmVuY2UgdG8gbmV0ZGV2IHdvdWxkIGJlIG5lZWRlZC4gSSBkaWQgaXQgdW5kZXIgdGhlDQphc3N1
bXB0aW9uIHNpdyBjYW4gbG9jYWxseSBrZWVwIGFsbCBuZWVkZWQgaW5mb3JtYXRpb24gdXAgdG8N
CmRhdGUgdmlhIG5ldGRldl9ldmVudCgpLg0KQnV0IGl0IHNlZW1zIHRoZSBuZXRkZXYgaXRzZWxm
IGNhbiBjaGFuZ2UgZHVyaW5nIHRoZSBsaWZldGltZSBvZg0KYSBzaXcgZGV2aWNlPyBXaXRoIHRo
YXQgaWZpbmRleCB3b3VsZCBiZWNvbWUgd3JvbmcuDQoNCklmIHRoZSBuZXRkZXYgY2FuIGNoYW5n
ZSB3aXRob3V0IHRoZSBzaXcgZHJpdmVyIGJlaW5nIGluZm9ybWVkLA0KaG9sZGluZyBhIG5ldGRl
diBwb2ludGVyIG9yIHJlZmVyZW5jZSBzZWVtcyB1c2VsZXNzLg0KIA0KU28gaXQgd291bGQgYmUg
YmVzdCB0byBhbHdheXMgdXNlIGliX2RldmljZV9nZXRfbmV0ZGV2KCkgdG8gZ2V0DQphIHZhbGlk
IG5ldGRldiBwb2ludGVyLCBpZiBjdXJyZW50IG5ldGRldiBpbmZvIGlzIG5lZWRlZCBieSB0aGUN
CmRyaXZlcj8NCg0KSSBqdXN0IHdhbnRlZCB0byBhdm9pZCB0aGUgY29zdGx5IGliX2RldmljZV9n
ZXRfbmV0ZGV2KCkgY2FsbA0KZHVyaW5nIHF1ZXJ5X3FwKCksIHF1ZXJ5X3BvcnQoKSBhbmQgbGlz
dGVuKCkuDQoNClRoYW5rIHlvdSENCkJlcm5hcmQuDQoNCg==

