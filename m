Return-Path: <linux-rdma+bounces-13069-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218AFB42748
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 18:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827D73AFC1C
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 16:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E432C3126D1;
	Wed,  3 Sep 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RHGYzBuP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VYDXUJLY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10F830DD12;
	Wed,  3 Sep 2025 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918275; cv=fail; b=U+MArCe9eBpEbcLhoGLP4hcuS6Yyxw03XDrVogDrmWCypXSZXfmM4bMwiQzkGxfLh6Oh1rpvLcCjA4ZkQd8bSWEPDtiwrsek029wvNZByq1NtYAMGzXPk/ScV1nK/+OJYv+hm2gwqZCO4lN+PHr8kQBqX242ACWQi33UmZ/xPkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918275; c=relaxed/simple;
	bh=k3OR6UnCtY+PoEDIp8NfUxxar2dmTzfWmkq3H+bj0D0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=StytppQH0D9dayjyjcXD57fv+OQETKX3OWZh8TMx7fzkmX06Ooi4IY90QQy4ytn2Tu+9tjMP7R/thQGgY8c/2cr/0bD4KAZEB9zGhuTril84TaZ3OC/0cD2zlngBJDte2WJf3Ebe4GTGabW/coP3uOmxr6gL9SgmDga+4wwWUR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RHGYzBuP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VYDXUJLY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839NhBc018594;
	Wed, 3 Sep 2025 16:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=k3OR6UnCtY+PoEDIp8NfUxxar2dmTzfWmkq3H+bj0D0=; b=
	RHGYzBuPIIa1KNsxMb51E4meajdNlrK2BRI9Auv4ekE/oYUkL/E4YInA1mYJmzul
	t7J4xUth6C7OLkTrDV7AxdBEcNYAbNmcCNX8bgI+UfQdI7Sr5AJswZis/SP4oSvD
	IlN8YjEvDuseq7/3tEkZ7WiyI6+yWIf6zAfpcePjsRvZW3QKcIZn+QTHYyKUz1Kk
	o7qtjzOphRKmn2N1V4XqZhcmxDbBfJlEwC1v7G0DJ5/iW1hl7Abp2o7YVzE1uuIN
	sBDUe2bSbajwXJ8WwQehQrLVFYO/ipm/LF7mLrC0iaviF6xE/FTjVhcJE9wFujVq
	TtuyMT1wOwkDSphc8xTphw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmbesk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 16:51:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583FGhH4036213;
	Wed, 3 Sep 2025 16:51:05 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqraj4gy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 16:51:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/LgqQaWhsusocpNHgnf7wABr0iFvyF47Dh7Z33fSVnz98nLBG96tEy5R8Ktar9QpCepB0auzr3ZB7ArvYCvZPstTrauLI+B1gVi4FVOXGSe090iKXjGqXlIiWH0l2rZRISKWrNPz0b1RUQvgMUESG64YEFH1ns1yNULjP3RqW/cY7Cd8vJ7mXMjVfESwlndKva+1hWhKtxQGJF+NoEA5zrDCAj76Qv8xzWEVjEt9Hcd0iQXPrCUDd9iP8mZ3YT5hSNjgglBqKEyjOPlbtz194ZABBTwSFtAafRlT/A6heeOxbxzBHw028oL81SHpfPOau1f+NLQ2NtcKIkXXA3aEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3OR6UnCtY+PoEDIp8NfUxxar2dmTzfWmkq3H+bj0D0=;
 b=e/7UZKgR9lEhkpcU2k+VudOty8iGLjRT77XOeVCVpv7vE7y5cWeZNNHkU9ckyf7jO2pJgwFrnAL1ou5dKHqxow9ALX/l6+DvusgvHZOTeL7/Nkexf5kFMYsJ2q+SXVx67t4dPpA0nNcGUxme7bp8ObHksborYpwKy4U2TaKnq3hE6CB9LtgJaL+iTcYgQnYhO0TjuvuWJu5jrskVgYWTdE0e4+Txip7YBW6eQndMvMjGn84ZjuGFnDf0T6nREYHNwDP4avlzX29yaF7UMXyzcfvr7iwUg+50lUTIRTeX6cdqodCdNnTPS7LvWvYUEetnWRk9DuHHC3mFC8JDurJCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3OR6UnCtY+PoEDIp8NfUxxar2dmTzfWmkq3H+bj0D0=;
 b=VYDXUJLY2koTxD9IazTOXABnhy/BSn8CyzCx2QbDzPN/lLXPrJJ6wNV7J3iV4hLCbOv3SKN4NpAdC8E8mNtERhRXMiYHWdOxRDCHeAXrnX2KymEtaQvS3cDYsP68dWulG9kRFWmzm+rxSv9ior3lRAs84FCY2Jd+m6iTcoRuRWY=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 16:51:01 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%3]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 16:51:01 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Allison Henderson <allison.henderson@oracle.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        OFED mailing list
	<linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] rds: ib: Remove unused extern definition
Thread-Topic: [PATCH net 2/2] rds: ib: Remove unused extern definition
Thread-Index: AQHcHPBAKx16lQseiUKv300PntFYdbSBqFuAgAADk4A=
Date: Wed, 3 Sep 2025 16:51:01 +0000
Message-ID: <1D680271-B2DF-4CAB-A91D-4577CA6861E8@oracle.com>
References: <20250903163140.3864215-1-haakon.bugge@oracle.com>
 <20250903163140.3864215-2-haakon.bugge@oracle.com>
 <2025090340-rejoicing-kleenex-c29d@gregkh>
In-Reply-To: <2025090340-rejoicing-kleenex-c29d@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|CO1PR10MB4561:EE_
x-ms-office365-filtering-correlation-id: 4001725f-9dd9-4082-1251-08ddeb0a1083
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXFyd0F1UFRFb09UamZLZmtSaXpaaGw4T25iODJVU2NuWEVhRS9vWVFiNzky?=
 =?utf-8?B?UGZWTFh3NVFSNjdQVmdrSVZpYVdzZGo3czFaS2J3dk9yOWlSeFBnRWZndW5k?=
 =?utf-8?B?TXYrYlRuL1NXNjZ3UzRocVhReFdwencvZTRRRzJuNHp4WlhHMHBmVmY0dmlE?=
 =?utf-8?B?Y2tscHdQTkZsd1ROWk9YR0NSRlJ0YWV2VDBpZHhYeHd4MWUrQjZrdjR5NGgr?=
 =?utf-8?B?bDEzQmo4ejByaXVRMUhVUUlNempzVnorRGVCNHREQ2grK2Y4bUhOQWFoTXpq?=
 =?utf-8?B?OUFaUGxOdEd5ejJDeDY3ajRWcCt5QVdhY252REtNTDBJL3BtOEp2ZnJOU252?=
 =?utf-8?B?ODIzaDR5TXBtcmFIY01kaDZYRjhWYnRwRENyVkxWanFUaUR2SDJicUE3Uldr?=
 =?utf-8?B?UnA1T0V6Y2FkM3BDM3FoaG9ka2lseitGRFpaTUZYSFdVMnZQd0RaVHJLMVpZ?=
 =?utf-8?B?Zm5PZG1Sc2tTRDhZSm1jSURUWklhMFpQMXo2TmZFMUg3VmNIbVZzWk5saHE0?=
 =?utf-8?B?QUxkVVZvcVlnMVB2QUcvdU9JZlROdzdFQkJJM3Z6eGtMNnFOSm1OWldKaXpq?=
 =?utf-8?B?clBWczdjTnJQcWVjSHRUUzdYbXNYekN0NmNGNDljNWFMdzJnSjQ2dUNZSWEr?=
 =?utf-8?B?eW43QndqbjVlTjJCdGtlZndhOWJYbHc1aE1MQjhzS0kvT3dKMTNaNjlQdlhV?=
 =?utf-8?B?YlRSRGNPQXdEVitYelRLVDRldy9QZ05EdEh1T3dsbWl6ZXhOTXR0SHo2TGh2?=
 =?utf-8?B?QWxjZjFJa2dnblE5MUE4M2lvdkhKcjJHUTBNTlBkakNBNWMrZ09FY0xsN2s3?=
 =?utf-8?B?Qld3MzQzZ3lXVFFvZkFGTlVQYnpQNndkS3oxeHhVeGZOekRYQWtQNmx5N3dZ?=
 =?utf-8?B?L21zUmNEcEZHb0VPY2kwR2RQeTQ0SEl1cjZPaHVxTG1Da0dyVXB3ZmMrQ2Mz?=
 =?utf-8?B?bkY1eHUyT2N3NjdPVFBoK2pLR2hlZ0EwZ3JvWFhkZnFCVGtpZzdQWmNlTzl4?=
 =?utf-8?B?Qm1DT0xpZFpXaWd5U0RxSnVjZ1IxR0g3dDJFTFJUVTJad1BsaTFmSVplcktI?=
 =?utf-8?B?d2VhNVFjRlpwNEZNQkJhS3hVMXMwWFI1UEg3R290d3dqM3IzWHRybExXM3g2?=
 =?utf-8?B?dFpjcnpvbDFFcWZVWk1EWGprUisrM0dKR0c2L0d6OE5ZYmwwbW1PK3lZVlQx?=
 =?utf-8?B?R1NERWtmZm9idytDZlBpb1VNN0tUd2R1OUp4eWJYczN6aUZIWjkrcnQ2NDhw?=
 =?utf-8?B?aHZ0SmpZT0JHTlduMnRBYk53VnFrc0UrS2RQMzNYVzBhWEtXeGROdzZLQ2tI?=
 =?utf-8?B?a2NiUTBMajY3THRVZSs5VVI3bGsyYzVmNmJZL0JsUmNKUUVBaXVIdDNZclgr?=
 =?utf-8?B?cEgwSU04dy92WE5VSEhUZEk3blNLQmNIcXprYVJ5dkJEaWFRMmVrWmVGUW9G?=
 =?utf-8?B?cTc4Q3pqc0w4VE5OdGRMN2lROWIvZkMwaXdHRzRBSzNCZ0poa2xkdThIam5C?=
 =?utf-8?B?NjVlQnFiMk9QTDBmK2c4NlJPV3k5aXZMV0s0cVdXYmp0aUdqMUdpVWxMY2F0?=
 =?utf-8?B?d2R4eGhFNkdKRWZjbm5YbTFhb25zRjVjTTZFbEUwU2piRldHK1hqVGhOc0U5?=
 =?utf-8?B?NGFLMkhFMmwwYkpBTXRkWnBHMU9SWG5zN2ZyTkN5NXBZejYxU0l6MHczTTBj?=
 =?utf-8?B?ZTVkdzJ1Y1o1cS8ya1FQMHdOcS8ralF1ZXljaWJZUFRKZVNrQmszYXlGNDlS?=
 =?utf-8?B?cUsrcUYzTTNlVEk2OVh4RWlhTWI1TzhCcEJqNUVPYm1hZUo0N2l0N0tWNm84?=
 =?utf-8?B?WjlRUjRRb2xFZndYSUIyZUFiWFAyRDYzbC9RL0RuV2liQkJSam1OeFBJL2Jp?=
 =?utf-8?B?Qm5YOTNOL1JqMUZBWGEybzBpQ2w3YXN5OG1HbUw2Q3ZoYU1UVDBSelhkL2wy?=
 =?utf-8?B?bnhvdENmUmY3SjhzWmFnbWwvbHNBVGpGZTh4ckkwbHU5N2FZYzdxS3hCWlB5?=
 =?utf-8?B?bFRRR0xxaFZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkxNd0JjL0FWcjhCMHlSUllZMmRtdDRpM2g0akhBZGtNN0hnS1Ivb2tpV08x?=
 =?utf-8?B?R3hTd2xCbGNCNTk5L2pBUlZWRWJ5QWhld25mMW13OTd1SVRuMUFYWFYxZHpX?=
 =?utf-8?B?VWRiM2MydWQ3MzhQMXdrZHBPU0tHLzZ5bzFKYnRoVWJsL0xuOWdLWXNzeFRl?=
 =?utf-8?B?ckEyRGExcm8zTmc2cmU1V045dTVHZmE1YUpCUGU0bzA5Nm5pU0dCRDQ1YlI5?=
 =?utf-8?B?WXBFaWZGS056c0l0NjlFU2lIdUpVVlYvRHZwaStqZ3VSbytremlZWUJRMEc4?=
 =?utf-8?B?eHliVnFuNXpSWkxqZUZROTg1N3I3VzdOUXQwQ1NjOENMK1NyYVpiVzRCZ2VR?=
 =?utf-8?B?WjNQWWlweGY0ZG55UklmRGJZZ09Gc2Nscm9wZ3VwQkNKa2NWVmtmeko5SFNl?=
 =?utf-8?B?YVBDM1Z4T0VvZXBHeVREakVtMTUwU0tobWFzZ0o0d2lvSjkrcTZZb3JPeXo0?=
 =?utf-8?B?S3AvSTY4TXRTU1ZyY2pjc1hZcFZFQTJUeWdkL2x4SHdScWVIa2xyREFxY3Uv?=
 =?utf-8?B?UFNKRlBDeWNpZEVueEZSNWpvZUpzSkxGL1FHK0UwM3Bkb1diMXJacitHcDJI?=
 =?utf-8?B?OUtBSWNEZjYxUlFMN21FUnJrQ3ZUZ3VyUnMzZXFPZ0lCQWVHMndZaFVWaVdu?=
 =?utf-8?B?OXI5c05oT0M0WUMxcFpuSmlicXovL0EzeC9FNWpUWEFIQVg2V2Rxcm51UW5m?=
 =?utf-8?B?SE4yUzZMMlFnR2d6WnBkVjJpaysvUUdLREkvK0R0c1d2Z3E0TnJrVFA5Zi9x?=
 =?utf-8?B?UnBNaUNOZzlLWDU1S1FtVWV1NFV4WUF2WG5UM1RhMTdLbmhHTkFQTTUrTEQ4?=
 =?utf-8?B?eGxJY1grbm0yNHV4RU5yZkZKQjJ2a3hPeVNZcW1OemdIbCt0QTBpenYrRU40?=
 =?utf-8?B?STlHRW9mRGNpVjA2dXVYbGpQRFJOVlRmckhSYlMva20zdFJHbUtRWm16WTND?=
 =?utf-8?B?b0RzKzdlS2YyNjhtRUQvOERlcnZKNFJveGs3eXZucXJBTXRza0RDSCtXMFhR?=
 =?utf-8?B?ZDZubzg4UGc4OG9OaXlEV3R3TklMbFpNcDVNV3UvMVNmekREdjBFQzVaWHVo?=
 =?utf-8?B?RU96VVNYNHZ4cjc0MlVudnh3V1RnNHVJb1UybStxbnNxMUcyV0pGSGdmRDls?=
 =?utf-8?B?S3o5R3loMkg2eVNvR0FqN0paeFB0MXFWSjN3MkVtekk1aEE4ZFhicTdFNHBK?=
 =?utf-8?B?QmNyZlBTbkdSbkJnLzM0TzM2VWY0OCtyRDdiQW9rYnREOVo5LzVuSDVHTi9x?=
 =?utf-8?B?UGZBZTdjdW5ZOTI4T1RSalIyZjB2N1prZXpsNTVFTkhjWTg5Q3VJMnZ6MmNV?=
 =?utf-8?B?Mmh2eVZma1g4WDFtSU1CQnZoZ1VyUXBCQVVZOHBXQ2sxWDJPQmtxMW5yMllE?=
 =?utf-8?B?SDFrcE5CNXA0bExtVERydEliQ05MRTlJWXpGZElPV3V4WUg1ZEs2S2x0OFVo?=
 =?utf-8?B?Yk43V3MvZmZGNTRxQW1WdE5yeEQ3cmZWdFlaNTJuNk83S05BVUZ3SU00dFpL?=
 =?utf-8?B?eGVlUXRXM1ZLK3AxVytyZXh2MVVQVGo5VU85YUZNbmUrT0NYN1BHNEsvZmdp?=
 =?utf-8?B?VnZhc2F2cy9vRTFBUk9RZ29TR0FzR3lHN3Y2dUdvRWRHeC9ZZis0RmVoNStn?=
 =?utf-8?B?T3VOaWFDSlpjUFVmTkFCMUplM0lpeHVvU0JWaldDa3NBZE9ZQlQ2UzVmWXJL?=
 =?utf-8?B?bXlYOXhUUm1iK3hnYTF1dXZoc1lFVVltcDBmbk9waURrNU5FN3ZtT0dlRVNG?=
 =?utf-8?B?RjFQaDQvMVI4a2FIOGFWZkVpSStMbVFsR3JtVGxiekxGQk5IWGFYcDhGYUZp?=
 =?utf-8?B?MDBEalpDNGEybEFTZG5rZ2NtTEhJNGFoUXpMNnBzZWg1Qm15QkhzdHEySGxB?=
 =?utf-8?B?RU05dmNuNStzN0FrM1RjeTNVYllsd3VuVTRjbnBkZGppU2I3STRaR1IrM3Zs?=
 =?utf-8?B?Qml4alVDbk5LaXAzbW9yQkZ5ckhXc0hOYXZPUklKWmcwY3Q4ZThIcDlVMnB1?=
 =?utf-8?B?NHR1a25IUWdDZGJKaGRjVy9LdXYxV1ZlSTIzZkwwNW9HL3FwaXFOa2IrdDNG?=
 =?utf-8?B?Z3R5bGZsL2NHWXJNY1JUQnEweUJkcnppZk5ja2Vwa1VhRmUrKzV2dTVoVjNz?=
 =?utf-8?B?dkVVc05NWVB5TFRXRG9TNUdZcVBXTXpBalliVytGblF1RTIzeG15bEVPZTVT?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D0701CC21AA4F46ABEFCF30E2F210D9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8Bpmmisl+mWGJ07TYSMdMwHj/aP9yx4g1z5nKPhF+KDCOfLaHzp8Ub+a8twBKrZpLUKle2s7FyjRgFwUN4sbbTFqY2SmDExqaDRrmw9wa38zTFDmRmmu7+e+z+46saYqxucZBpJGpZp+8PFDH13YUOoVLClblqTrUQ4EvzLc4SVEEaF10nvRGATvqY0kr+PGHa7E/+EPj3lZt6Kno5OCK32SZRdJNU68vBSUWhusEOd8X0J1Pc+2Xd6mQ6u9wxI5exEJYibqztnzNBGIwOrT/uUnM6rtpNQRFVbK9DTcq3kmC4oFDXXsjEdkiKHN94nGS093/HtCUXgsoJeZ6PACIsQ/pAORbLwBLm82W6E/Z/G5n2QFZO0mTUqwAYYmqcpouPAHofV7Q0phEUOqxkyIdGy4ENI/F/3y7+zxOGHiEjrRLTCyqCcjGcEmjWJuJ9TzzwcJMHApDRqUW2i71NyJ7RiqNGG9qgqgCANVRZzfSsjFtTEaPusNxoUHHaDxordurzWRsXEi5vWPgw1oiFWiNhMnrbERwJixSgooQfNWoUd9Imi6ukoqYiCgfrvxI5acnvNgen5LYNEwRCqhmovGmb6mYH1jQD52PTf1FgNgZkQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4001725f-9dd9-4082-1251-08ddeb0a1083
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 16:51:01.5102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H17NomDXdpboaI05LECzsGFNkpUZU62xJEr38QJQLCApuv1TzfC6DZGFreGOPfjHqLou2RDKfThx7K2fg9o7xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030169
X-Proofpoint-ORIG-GUID: xVtbZF8DLuuChxJVlgnjLxXpt4KOesvo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXwz53jWnV8IfD
 6yG5hc9/6LP8WRg0u6oqJxjy3od5Emu4MMeQCNc9uYo0NNNfwNGgvzRYpxqmMZx5ysSqfyFxiSz
 Ukw4apR3u/kS8hXBqG7JV3Vd0dCiZdK/dGPm8UMvWraQ18wUoVWXK8g0OAZVPKh/170xYY1wGpz
 PUJXGkf3E+AXERIdEcYK6hpT+WHVHzJQJorP9fcZiG/gnCMKdJWatEeSxstf42Eq0ELspADDWtu
 ZiUIHAcb0H1Knsvh/zGfS8ybAKW4CybS4r0TC1+R3TJ1RuiKAT5Fh2UjcUmLl2MPnVRyXREfUEd
 n1gFysfrNU0C360uUxJnrPfudlSpgOBJ5zJYAuRHq4Ts0m3s969WB3nXdhOr3gS42IMHq9MzI3b
 3RHUnpft
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b871fa b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8 a=BPLE6-sF1qDbAtsRWQ8A:9 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: xVtbZF8DLuuChxJVlgnjLxXpt4KOesvo

DQoNCj4gT24gMyBTZXAgMjAyNSwgYXQgMTg6MzgsIEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgU2VwIDAzLCAyMDI1IGF0IDA2OjMxOjM3
UE0gKzAyMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IEZpeGVzOiAyY2IyOTEyZDY1NjMgKCJS
RFM6IElCOiBhZGQgRmFzdHJlZyBNUiAoRlJNUikgZGV0ZWN0aW9uIHN1cHBvcnQiKQ0KPj4gU2ln
bmVkLW9mZi1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4+IC0t
LQ0KPj4gbmV0L3Jkcy9pYl9tci5oIHwgMSAtDQo+PiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlv
bigtKQ0KPiANCj4gSSBrbm93IEkgY2FuJ3QgdGFrZSBwYXRjaGVzIHdpdGhvdXQgYW55IGNoYW5n
ZWxvZyB0ZXh0LCBidXQgbWF5YmUgb3RoZXINCj4gbWFpbnRhaW5lciBhcmUgbW9yZSBsYXggOikN
Cg0KWW91IG1lYW4gdGhlIGVtcHR5IGNvbW1pdCBtZXNzYWdlPyBEaWQgcGFzcyBjaGVja3BhdGNo
LnBsIC0tc3RyaWN0IHRob3VnaC4NCg0KDQpUaHhzLCBIw6Vrb24NCg0K

