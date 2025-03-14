Return-Path: <linux-rdma+bounces-8705-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75250A61424
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 15:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80A53B7AB9
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98361201023;
	Fri, 14 Mar 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LrPi2lMH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D41990BA
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964027; cv=fail; b=HCq/yOT41043vqvJcWA4/rLZIOUIpXrs+NH8z8GOs5LkPYWH+I55Wq30Nw0KOm577YukpDxkJcdYrOSdp2lUvWlSfJIxljDZtNvkyEgZvPo+cid8QiG2338G+wlfIknC7KX7W3t/gITDEnDo1k2v+mqvXbeYbSI8uUp3XjQNQdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964027; c=relaxed/simple;
	bh=etMKheXZ9YsLce85gXFLIzK7woUdA1FUp6eaDU/B68M=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=qBNG6ym91hHxmyw0kNlk0aqNwCKf1JMIjNklJJ//PC3dDGCGQomDv4U14vTAD414DfWYF7f0NuFw+UkSH7N+vane4QXbJyLvAgB1e/MiEKckhhCLxHJWZHrr+pztn8sX6gWlB/SDxsj7Qt3aN5d//25CVZ1r0/A03RHolRQ4+fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LrPi2lMH; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E9OEfA032102
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 14:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LrFVzY
	0bt+w1kXROr9ASj8QclqPYAyExI6sJ4zxUl3g=; b=LrPi2lMHp92BOXijTMhW+4
	NEahtSY78+3uDszSXCMULe0HCaCWbnbPuIC/jTgUGWkzaV3BGowtqGwhJBYqZnMv
	umikSSJECim/dg7yQ8+S4gUWvTu0yIhcaharMmnx2B8Bo/v5Wfu7hibNXCqQYwav
	F9jU9xVri0mYkyx/EIabDVLfdpni1V7s0H/c0wi+p1qrTIzEsGzI/Rs7iOVa9yzb
	Tw9MjuF8nuoo1BmktIPFdJET7LJrwqtjpWe9HLjibMk13jrM/oUppvfHf7tq8Bzm
	OAZED0jxIcoc8CCSf0c7Q0hZCHzfpLEf89Ru3ZTcqPZswrbpdGWoI3vutlnEXZBg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hpvca4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 14:53:43 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52EET7YH020331
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 14:53:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hpvc9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:53:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jj6x7wcZLPQoHP49gVyZ8z0qJzW64OgM5j4SY5sKjYyfdMQF4MzNAOCeyK0pip665XWcLmApgV6XjU8S3kcTMov/83MAvchUhxYcH7h1a0GGhvS+K1opNdh6+u+Nvf1+PPTjnjafCNAOl//35j9miheRTaeU0hTI4c5LNnNFW/IG65chL1d5oqp4RsWv2s7Hf5iHPKmNjdesNPrzYpb/e6ida6pa8vb8W75BwsSyr9Zy/USzSBMdzKW4Q0kVKVW46GTKFc9HnPwYNz5Y/g3JfW4GOJWRfYbCv7z4OBUDBO4QREPix6zNJyVysPCXphjbpcr5ra/vofyccizgP4XgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPMsypMXYd/D3xtmctfbwoLDvcy7nEg7uUZYbWG45RM=;
 b=M0G1oq5WfKMmIvVIBZ4TbjYSNxNJYM8N+oFhFHtfwhxE26/yJAudihODbc+8AhA5RVfWoP4727jr0I3jN5D0DokHhnwzGWod/16ZGD1dYeImrn+aIIjKluKNsE+AUt6F+AOBLr+3v2KGXPcsX1E2svwgvDbpfSqA9yDz6yfSBk5nuU0Mv9M/oJ2ZPuCMIOj4ICqWILV0sYRw7I+NwnM0KMP51xJcaoVh1QEMduoqDMG60JWsr8KmMBgpNg27Qv+rj+Cxo8NvAJct0fdotu9cqZXXiK67XvreODYNbGpNzAo96wr8R1lh6i9ElDBxuFLAj18rFDFA3tWpfLN4Aa0yvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.29; Fri, 14 Mar
 2025 14:53:40 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%4]) with mapi id 15.20.8534.028; Fri, 14 Mar 2025
 14:53:40 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Leon Romanovsky <leon@kernel.org>,
        Nikolay Aleksandrov
	<nikolay@enfabrica.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
        "alex.badea@keysight.com"
	<alex.badea@keysight.com>,
        "eric.davis@broadcom.com"
	<eric.davis@broadcom.com>,
        "rip.sohan@amd.com" <rip.sohan@amd.com>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "roland@enfabrica.net"
	<roland@enfabrica.net>,
        "winston.liu@keysight.com"
	<winston.liu@keysight.com>,
        "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>,
        Kamal Heib <kheib@redhat.com>,
        "parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
        Dave Miller
	<davem@redhat.com>,
        "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
        "andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>,
        "welch@hpe.com" <welch@hpe.com>,
        "rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
        "kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jason Gunthorpe
	<jgg@nvidia.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 00/13] Ultra Ethernet driver
 introduction
Thread-Index: AQHbkFp5nOXFrAlqh0uJWTdfFW8PJLNvRMOAgAAeh4CAAC+3AIAADhuAgALy8bA=
Date: Fri, 14 Mar 2025 14:53:40 +0000
Message-ID:
 <BN8PR15MB25133D6B2BC61C81408D6FE899D22@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal>
 <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal>
In-Reply-To: <20250312151037.GE1322339@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|DM6PR15MB4039:EE_
x-ms-office365-filtering-correlation-id: a4218697-d031-4ffa-23a2-08dd6308022e
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d05pRlRDQkwvV0NPNU5zc3RNbmpSd2ZqNm41T1EzNHdIeVlCWXdGaXR4UXNk?=
 =?utf-8?B?ckJTaC9Xa09GSWQrWkhCV21qTjc0ODhuemtMSXdmcUNXZ0RVaXRRWDFhZW0y?=
 =?utf-8?B?c1diYXQ2QTladjlWMjBpclpUVTNlS2xDRDNzT0N1QkovS2xEdUNYZzRFNGRC?=
 =?utf-8?B?TlQwc0VTYWd0S0J2K3BUZGs5ZzVDUkRGWlVsNmJxdjJxN3NGZzVLa2hUeGRN?=
 =?utf-8?B?VVdsQzRHWVN3c2ZZYkM3NlpQeWNsVElBK2doNHpPREVVcEd2bE43RXZaUUlM?=
 =?utf-8?B?SVFyYnBkN1BDRVJDckQwYjdSYlR6Um9Pc3ZycFZsVkY2dU5ubWJScHlvY0lV?=
 =?utf-8?B?bXkzUHA5ZmpZVnh3M2xpaDVCTTYxTFJmMkFWY1VzeWM4SEVRbTd0blhHK0cz?=
 =?utf-8?B?YncvQWs1cjlLWGJFNkZEdS9lNmprdTU3am83bjREYml2SGlMeFhVbnE5WGwx?=
 =?utf-8?B?YzF1ZHpncld3MVVyWUtPS3ZFc1ptZjNxbXQ1bmg4bzV5Z0RXaEdYRDhZNlRY?=
 =?utf-8?B?ZU93bFlMeWIxTDh4WVMrNXBQNTZabjRpYkVmY3liTm5pVFZpeFhnUUtjSTdH?=
 =?utf-8?B?ZEc5QnhCVjNFRUVtTFk0QzlMQmtyV1VNaGl1eFdEVFR5MHhIcmd1d0ZWOHJK?=
 =?utf-8?B?UUxZSkZPMUdabnVwejVPbzlSOEJkKzJlWmdTMlI4ekNST0ZNVHRoazdxRmNa?=
 =?utf-8?B?eFdpZk0vdE5YY21zUVg2MmFpNm1OVW9UQStBS050ZU04aUlsazJsQTJxNG1D?=
 =?utf-8?B?K2s5RWcwbk00SmpKS2xxdnpiZGhXOFpSL3lBL0RJWFVrYkhsMzJHSk0yQ2VH?=
 =?utf-8?B?YTdvWGhsdlRIUFVhYlFBbG5YY1k0TzVOSmpTNlhXU1RvRVJMVXkvdzlDYjU1?=
 =?utf-8?B?RUN3SDQybmk3NXNHbFhTRDMwazU5VE90SnNoK3pCcDVjVHFCTzV1V2hVNTN2?=
 =?utf-8?B?N1NxcEUvQ2ZsbTZEUDJZUkZFY1BxYmVLcTFTTDdoOGFhcXJBVisyNUpYWEpr?=
 =?utf-8?B?bWVMVVVsNEhTZEMxMytSUmNUM1J5MUNMSTVBYVhQNEV1TklkbVJpQllRSHNq?=
 =?utf-8?B?Tkt3Ylp5aU5YajdVK05OVysrNEI5L0pyUlJ2czltMFdaOGl0YnV3eDgrVTQz?=
 =?utf-8?B?ZFFZYlF5R0ZxakV3TjNDd1YrNlo1WE55RSs2UWxGUVlPL0FBd1duWFRYM0gr?=
 =?utf-8?B?cFVqaXpIWkVIZUpuWnk3SEdoMnk2bGpyRy9LdGl4dG5TUXBYY2RkcHkxRkJM?=
 =?utf-8?B?V0l3VEl1SGg2cjc1V3ovY2gxQ1dvN2FnNzcyK0VpYjB0K0NXQUFMcHVKNGpE?=
 =?utf-8?B?dGJtclZEL2w0V0gzcDBZdE1ieXJTTkU1cWM2ejFDS2syODMwK0g1TDlCMFFU?=
 =?utf-8?B?K0s2K2E5aGJNTEtxdGZQbXhvamYweTNTQlBodm1qbng3ajBzdlpCeUpRQzNQ?=
 =?utf-8?B?WXlpcVNEMGw1aHVJKytSakZRYzYyNklkbUtLVlp2TVlFbll5ZFRIa1hSeHVx?=
 =?utf-8?B?b1JKMElLU0dub2pQM3lFTUdPTEtHSng3UDBlNDNrMkV0Q1k3Tm5YbVhsZWM0?=
 =?utf-8?B?VGZ1VHZya0pUbU43SWJSQWJkVlJlUmlCNnBlRmdQQ3NGaGU1N0QxRVZpT0RK?=
 =?utf-8?B?c0pFUXBDdEF6Q1czQ3lCVmdVckRCSmNHNnBmWFlMZ2UxVFB3YURxQkV1aXZt?=
 =?utf-8?B?eTlXUGZDV2wvZFpVK2hxRkZvdlVncFpvT2Z5UjU0L0VrQlZzNHhIWnJHZzMr?=
 =?utf-8?B?SDR1SXh2V2I1ZjdMNnZWamlLelpWNmV0V2N2T2NxY2U4UFNvT3BRRHZQWEMx?=
 =?utf-8?B?NHEvZWkvd2N0TDl5b1A5VXNlR2swakhYWnU5a2RBblpqS3pTeHk3eTNiS0JS?=
 =?utf-8?B?SXdMaWs3NXlZbFloQjZZVHpESEZEQ1hnRVBKM25SS0w0UGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODZoMkQyTnJZaTJCck4zdW1KOVZkT3lQd3dYTEgxeVN0ZFN6YTJXQVljTTZO?=
 =?utf-8?B?Ri9zN1JiS05Xd2NvSS84NmZKbjdHZUJmYnJLSm1XemdGWStsclBXaTQzK2hD?=
 =?utf-8?B?WWJ1Ym9zYjhWeDhMazNEbXcxY2xIaFNNQ0FCRWg5STBGOXlPWG55cXVWR2tI?=
 =?utf-8?B?REliTzZuangvSGhpMXdoMHdvWTRTWmNPZFVaZDlHSG82SWVLaWp0WmdRMTE0?=
 =?utf-8?B?bnFQNkZtVnpSOGdrSkFQcUJVVXZOTG9EUWVnZ0plT2xEdEJza1kxY2NrN1d1?=
 =?utf-8?B?bUtJVTVrQXZJSCtpdUltN2FBdVNpSnBxUHNPbTA3b0MxbWw2eHRkRU1ud2RL?=
 =?utf-8?B?Q0JmTGZPRlI0Smh0Uko2MjVhcFZ4eUtWQTN2TmJsQkl6M0xyRjFiakNRaFhL?=
 =?utf-8?B?aStkQ0lXcWNVWVZMTy9SSzV4NG96UzR6Zk1wQ2FzN0pGWVNHbXVUY241T2ps?=
 =?utf-8?B?VGdIV25tcWlTdjBOQjZoR2U3alpZWHNJQ3Z1bC9wUThNT0x5VzB4L1k4ZEg4?=
 =?utf-8?B?N3VOYzZCL1RzeWhLUEYySWJFcHZuR0NBNVBvZUNmUUdLaGtHYnlXWmZYTVh2?=
 =?utf-8?B?SktHWHB3NFFraS9sdjMzKzl6LzFwN0Q5U0NwTlJuY01FNExLKzR2WHVzbEJ5?=
 =?utf-8?B?R1FYckhkSzM0NDlFNjl1M29zVlgyL1o4NVUyRlk3eGx4TVNGelpORnJxTkdB?=
 =?utf-8?B?UzdhTVJJdllOZ1QwVi9DOEM1UjlGVWlaTlFlc21CQzE1amJ6UExxL3ZaM3cz?=
 =?utf-8?B?eGJZUEZYZVFSajVUcWlGeXJ0N2JTRFRXQXdQOS93VGtmenArSDVTLzk2aUs2?=
 =?utf-8?B?c1JnVHBvRVM1SXZSUmh0WlBiN3RaZ3pwalZJRHlUMlJBZGFoS2NPWmxyNmtH?=
 =?utf-8?B?NU5DbmhiaGJ4ZHVMYjVtSEZKNTROQzI5dmtGVWRjc1dNbTZnVXlvemlqYkhk?=
 =?utf-8?B?dGNIL3Nsa29pS25MVnM0V0ZPNGdVR2JEYzJnOG0zelM4QW9OZ3lJS2hTbmVT?=
 =?utf-8?B?TmJJTDdiNTZZVXREaFZSZDlOYy9ITHFnVnNRS3ZSNSsxNzM2cTRnU2R6NjYx?=
 =?utf-8?B?VHdtWlNQbm9tdDdOSHVQZFJiNDRydFVSVWV3VEcwNnNsam8wMUR4Zk9mVzN5?=
 =?utf-8?B?V08wOVVTOC9hSnI2RURReFc0QTJ0NWROWlVLcHhJaU5nQXVXTlpHcklLeE9y?=
 =?utf-8?B?QjdzZ0lXbHZjeng2U3ZXK3RQSGszMzdsaU8wM0N2WkpnS0dRVmF0WVdGMW9j?=
 =?utf-8?B?SFB2SzdJbTZkcUIzMVNRSDNmQkFxV2lDZ0lHMVNiZFllQXBzek1EUVV3NmYv?=
 =?utf-8?B?cm9BQ0FQVUwvN2pvUHZ1UTh1S1RrYkh0WDVhRkRvS0VpWlc0dnUyWklXVFRF?=
 =?utf-8?B?aVh0ZFozeVcvL0RxcFY3WjhlUDRGY3pzT2ZjSXE2RDU3VVhxaGsvL1JQaEp4?=
 =?utf-8?B?SGFpK2h2d2w4MWNhK3JGRDY3UFZGYm1FL3ppV1JRejN3cldjcWRUOTc5RWlk?=
 =?utf-8?B?NEZOZzExUmlXUG9QRzFzRnlwRU8yNEIvb2hWVEIxbjlYTEwxRERZYnRxVnJJ?=
 =?utf-8?B?UFpDb3RZYUhqRlBUeUdRNnFseXkwU29CZTh6b2tYdkx6L2xtd3lYWDBITytJ?=
 =?utf-8?B?aHpabjdIUzFibjJ5RFhzZWwwbWRjVFZiNzE1a0JBUVl5S1Foc1VhRUltN3Ft?=
 =?utf-8?B?M3ErWStsQWhKKzdoRW01dktxWHFtZmtCL1hkRVEvbHI2ZTFKbDQ2d0IydnJU?=
 =?utf-8?B?dWMvUCtLSTcwR2MvQ2dYZDJ4UzFRWjA5VXZqVkY5N3ZWV0hCbGpZSXh0c2N3?=
 =?utf-8?B?ejF4andrWGNYdmlsSVZBSkRML3o0b0hXdm5mM3VGWmRCQ25NYis3MCs1MkZV?=
 =?utf-8?B?ejdwTHMzczJ5djRmcXBaSGRxRG03YVFlVjQxQmFmVm04aXJ2dG00aWFzL1hF?=
 =?utf-8?B?dFU3cUU5WENoemNtYzBDdG5ZR1lWRzdQRGpBODFtem1FUkZMTXk4dzM2TjZ0?=
 =?utf-8?B?TVBnTENaZlpsUVM4eE1TT2tMUFlFZ0srcDhFZDF4bTNQNzRZbnRQMWR1SGJX?=
 =?utf-8?B?UHlPTHFLSXMxNThyQng0WDlIdFBMNmREWHMrdjY4VVcvS05VY2lFTENXUlJY?=
 =?utf-8?B?dFNzd3RoaGZKQnFFdjZ1UUVvUDRCdmVlVFJtOHRzTXIzOGh6bWkwaDZsUHlz?=
 =?utf-8?Q?VB0CB+W20PmLK3etXetdI4k=3D?=
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4218697-d031-4ffa-23a2-08dd6308022e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 14:53:40.3837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvsubrE2ONJMl2z2cAfLiSXmtl+Ft6lfJ1UzV2ybAl9m3Zqs6cikIOwPnmvpU5gapLYp1XliPfAbXA+cfb5hbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4039
X-Proofpoint-GUID: GTQF8aATWeu513eV5qq5kYa6KPoDnU9A
X-Proofpoint-ORIG-GUID: GTQF8aATWeu513eV5qq5kYa6KPoDnU9A
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=2
 engine=8.19.0-2502280000 definitions=main-2503140114



> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Wednesday, March 12, 2025 4:11 PM
> To: Nikolay Aleksandrov <nikolay@enfabrica.net>
> Cc: netdev@vger.kernel.org; shrijeet@enfabrica.net;
> alex.badea@keysight.com; eric.davis@broadcom.com; rip.sohan@amd.com;
> dsahern@kernel.org; Bernard Metzler <BMT@zurich.ibm.com>;
> roland@enfabrica.net; winston.liu@keysight.com;
> dan.mihailescu@keysight.com; Kamal Heib <kheib@redhat.com>;
> parth.v.parikh@keysight.com; Dave Miller <davem@redhat.com>;
> ian.ziemba@hpe.com; andrew.tauferner@cornelisnetworks.com; welch@hpe.com;
> rakhahari.bhunia@keysight.com; kingshuk.mandal@keysight.com; linux-
> rdma@vger.kernel.org; kuba@kernel.org; Paolo Abeni <pabeni@redhat.com>;
> Jason Gunthorpe <jgg@nvidia.com>
> Subject: [EXTERNAL] Re: [RFC PATCH 00/13] Ultra Ethernet driver
> introduction
>=20
> On Wed, Mar 12, 2025 at 04:20:08PM +0200, Nikolay Aleksandrov wrote:
> > On 3/12/25 1:29 PM, Leon Romanovsky wrote:
> > > On Wed, Mar 12, 2025 at 11:40:05AM +0200, Nikolay Aleksandrov wrote:
> > >> On 3/8/25 8:46 PM, Leon Romanovsky wrote:
> > >>> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
> > [snip]
> > >> Also we have the ephemeral PDC connections>> that come and go as
> > needed. There more such objects coming with more
> > >> state, configuration and lifecycle management. That is why we added a
> > >> separate netlink family to cleanly manage them without trying to fit
> > >> a square peg in a round hole so to speak.
> > >
> > > Yeah, I saw that you are planning to use netlink to manage objects,
> > > which is very questionable. It is slow, unreliable, requires sockets,
> > > needs more parsing logic e.t.c
> > >
> > > To avoid all this overhead, RDMA uses netlink-like ioctl calls, which
> > > fits better for object configurations.
> > >
> > > Thanks
> >
> > We'd definitely like to keep using netlink for control path object
> > management. Also please note we're talking about genetlink family. It is
> > fast and reliable enough for us, very easily extensible,
> > has a nice precise object definition with policies to enforce various
> > limitations, has extensive tooling (e.g. ynl), communication can be
> > monitored in realtime for debugging (e.g. nlmon), has a nice human
> > readable error reporting, gives the ability to easily dump large object
> > groups with filters applied, YAML family definitions and so on.
> > Having sockets or parsing are not issues.
>=20
> Of course it is issue as netlink relies on Netlink sockets, which means
> that you constantly move your configuration data instead of doing
> standard to whole linux kernel pattern of allocating configuration
> structs in user-space and just providing pointer to that through ioctl
> call.
>=20
> However, this discussion is premature and as an intro it is worth to
> read this cover letter for how object management is done in RDMA
> subsystem.
>=20
> https://lore.kernel.org/linux%=20
> 2Drdma_1501765627-2D104860-2D1-2Dgit-2Dsend-2Demail-2Dmatanb-
> 40mellanox.com_&d=3DDwIBAg&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZXb=
hvovE4tY
> SbqxyOwdSiLedP4yO55g&m=3DU78K-khiLd-
> LLkbuNRzBStNppsXFTXdM7br052fwal1mzxpaOcOSQXCnguAK8t3g&s=3DU9dQl07fp-
> e9380xjR94fW-UGixoMsoxr5HfXKYggLk&e=3D
>=20
Nice old stuff. Often history teaches us something. =F0=9F=98=89

I assume the correct way forward is to first clarify the
structure of all user-visible objects that need to be
created/controlled/destroyed, and to route them through
this interface. Some will require extensions to given objects,
some may be new, some will be as-is. rdma_netlink will probably
be the right interface to look at for job control.

Best,
Bernard.


> Thanks
>=20
> >
> > Cheers,
> >  Nik
> >
> >

