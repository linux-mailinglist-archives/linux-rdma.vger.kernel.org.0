Return-Path: <linux-rdma+bounces-5069-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D160D984880
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1421F2386B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA151AB50C;
	Tue, 24 Sep 2024 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P0zTpY1x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="plnh1U9P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A71CFB6;
	Tue, 24 Sep 2024 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191248; cv=fail; b=G6c/0PfMmLyotNDqNBsD78eC/a/HFBxT4plx45KYAbREc/iF1nihHhzGzhSj2xoM+VV1MBh6s0W1+l92JZQHhWKJo4Cct//GwmIA3GFJefE9jTal89LGCRkAMNSVimPjh+6936m5j1nQg36WJNsfCJDtLg8gZII+ZYx8226cALE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191248; c=relaxed/simple;
	bh=Zz7d6YRoqJH2bOsOzRDaD9tqHluzSfg567N4D4YYD4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bt4vUH9nq7mbVvUiWu+MlMRDJmk6sTmyMffn6w665r2tDnwOZtNw6ZfhNos9Byu0AOkJhuxS7T4A7ycs5u75iGhz5KytD8PXt05xKnHct+nIkFkAfdH9ur04jxEcjf5XKEpc/946vOBYfapnoNUFoDwb5euthRoR/ygL3OfaqHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P0zTpY1x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=plnh1U9P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEQV9N008264;
	Tue, 24 Sep 2024 15:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=Zz7d6YRoqJH2bOsOzRDaD9tqHluzSfg567N4D4YYD
	4A=; b=P0zTpY1x1VPttlw8OHEh02VBGOzZpv3PTdY5s4xkSrSyNlw4Ho25X6247
	6wEewplQ0EJhrpRCdvin8e1RItpBhI9x7O497dirfyjnnS99NE1cpSpPEF3IPjgC
	bZXx3k2s4TB092czrHXWKlricPfNEmJOohHsalmrW5yU7C0M4O8F8oX3/vNORzkR
	97U5cdAhCRg11Al+7OAObyjCf9UeH7tYhijwyyZk8vBPNKHT/IXPsd35t1RHEt6n
	7EgECphUgY+/7p0zQu3Awb2T3VdDwGD745k4hQOsnzNIZRF5ZjslvffeArg7KqwJ
	1faPjK6XyuvXevlTcz7smpvRDqULA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41snrt58ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:20:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEELYF038073;
	Tue, 24 Sep 2024 15:20:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41tkc5y9pk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixKApy64cLM0EI0FRImAhgM35O4he0M6ffdwdpQChz3LIYuH+b/fOtFxFaszMI8ToUYgsowLmEZhA0SGrWv3h7k2c4Wo5pG1CDsmfd75d/pD75RyaFOFUGeCI7JU3qsOM/Bgk1f8qUESLpd8HG/PKKJDnbdcLeh3QEvwqC1lTVNqAGjxseesM+suRuf0MBENNGDEjPCDrNynXcTjoCJMGCBDEDyZA1KJlJ8BNPGknK1xEQjVDpKMwoA/g1ZQ8RFGy1t+BPIAnb6ybAYxFlevH+VbQ0bgcK0oT5L/65kNqA5iX5PMLndZmnt7mcebc8kl0lfhvfD1n5rEb7YPwL+Wyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zz7d6YRoqJH2bOsOzRDaD9tqHluzSfg567N4D4YYD4A=;
 b=LkOvkZj/6MjKA+6s4y+I4Av8HuyBDD1pWf06Ezv4+tR0H/2Ii/+c4V8YauOLJ2UZx8g7kJbtpwJUGevJF8r5G+dK6Too00y+zxwhWus8s3VvE7NEIThPR7l9TH+1Qlrk3RKUxhC4Ik/DP0xByWYIveL44XvCsQDyiuPt94yo2SacrCB87+YJS9qN1hkJgH8mHS/pyfJj5EJLGV3ZvT7UaK3Xtjn3qlO0hNvKoIS801BE3mE73FgaVwXg3oWUeo20ded6IwzQ6fg/+8ziioPXhN4ECaPVYA1DJpzNgj8X0qFEaTiv7Ncr3gasXUqCRSq4qjvybMToRH96HbmVNnP0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zz7d6YRoqJH2bOsOzRDaD9tqHluzSfg567N4D4YYD4A=;
 b=plnh1U9P6O4VMsVYNn7d5VjJqXTKUMd1G63UjgTZTfoB9IXkF+Eg9IVcj8h5JGyN6l/cXSsHHII9qlXFIgatSHd+uiJv9XaxCb+4aAcW4a8PrBHPxVH8cdSnmDIraNzE+CkklplA6L5182ph2U+UovAcmh3xnlr3gxUGAmkHz1Q=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by DS7PR10MB7347.namprd10.prod.outlook.com (2603:10b6:8:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Tue, 24 Sep
 2024 15:20:18 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%7]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 15:20:17 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: Haakon Bugge <haakon.bugge@oracle.com>,
        "hch@infradead.org"
	<hch@infradead.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "leon@kernel.org"
	<leon@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
Thread-Topic: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
Thread-Index:
 AQHbCaXJ3Cq7ZepJVUSrsm1BJgCzmLJfKg2AgAFGegCAAESCAIAF1uuAgAAg0QCAAGpzAA==
Date: Tue, 24 Sep 2024 15:20:17 +0000
Message-ID: <822817aae9a7ac8732917645da3045ae4d72c081.camel@oracle.com>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
	 <Zuwyf0N_6E6Alx-H@infradead.org>
	 <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
	 <Zu191hsvJmvBlJ4J@infradead.org> <ZvJj3butL8FYeXpi@infradead.org>
	 <3B6A8BD9-76C0-464E-847D-615C93BBDCB9@oracle.com>
In-Reply-To: <3B6A8BD9-76C0-464E-847D-615C93BBDCB9@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|DS7PR10MB7347:EE_
x-ms-office365-filtering-correlation-id: be190924-f167-4820-f2e6-08dcdcac65ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bHZiY1Fnb2UyZit4Q3dWU2Q2YTkxRGl3and0S2JtWlJpVzZZMFhjTHBURHFY?=
 =?utf-8?B?dGtycnI1VS9sUUtyY0ZiNUp5OUlkYlJtbTRYRDVWaFU3MS8vb2lQdk5VY2J0?=
 =?utf-8?B?WDdvRFRaSXNyU2hyOFhHRDVITmRxV1hnNFZuemZtR2FreHBjQ1cya2lCSDZO?=
 =?utf-8?B?NGVNaHpXcjVMck1nRmkvT1k3YUIvVEpWczhFcVBleHpCTDcrNzhrTXNzUjFx?=
 =?utf-8?B?bHA1WTZwM3VwZFhBQm9BNjNDQ0NXcGp2eWdoWU40QmcrSlNyMnIwVzhVSGhm?=
 =?utf-8?B?OGxHb3JaeHk5ZEVUcXhUZlZ6eFJNMTR5WFd2UTNRd2FTZ2J1eXk1c1ZUTXVF?=
 =?utf-8?B?dFVkbXhDY001T1BCbHpYbGZGVWpyaUNBWU9FQVp4UUV3c2hkVHRWbG9ISFZW?=
 =?utf-8?B?bi9VaEl4N1U5TjRCaXNMRmFSbHppZG0yQ0s2Qk1tbWhhSis2VGxialliOURv?=
 =?utf-8?B?ZlIySG9DNm5sQ3grTUJhWVpwL2ttVTNtWTB3Qy82VEhiR2ZzYmVuT240dUZ1?=
 =?utf-8?B?S0ljWW9BZ0hDVmJscXpJVnZ2eXhaMnR2dEN4cm52VzJ3bUZqTWVpMDJLL3JQ?=
 =?utf-8?B?akk1Tm9EeHZZUnhNcXRvSUF2THRMUnR6djhwWVZoeFFSemFKL0MwSGV5eU9s?=
 =?utf-8?B?aXdrYWduSDlaaERPWXNsc3VnU28rQlhUbjg5UjBtRDZOOVBQKyt2UHo5UmFV?=
 =?utf-8?B?VWRlZ2lwcVN0bzJQcVVMUDNOVlFqVFlWZVk1UW1ySUVUalVNZFJscUgzWmxL?=
 =?utf-8?B?YlZXclZTUjdqTjJMRUQwVVdBNVJ6NVFiU0wyUmprYjhKODY0bm5YSWJoZ2VN?=
 =?utf-8?B?QWJGVFVpWVVPelBIYnE3UWVMUWJKTi91cmFYRzJQVkNxK1IvK0NjWnpxelE4?=
 =?utf-8?B?YVhjYmVHOU1iYW4yRHVrRXo3YklNSm9zVmJvMVRwMklITkNlZTZrZUE1NUEv?=
 =?utf-8?B?TWFzMjB6WWF3ZGhEOUtnZEFyRzdRZ1lVNFArOXo0cUhVSDEzL3FzYzRYcStw?=
 =?utf-8?B?Q2VESm0vRzlyRHJWSmgyQ3ZXd3VLNXdUL25qcnA0ZWgzc2kzL1BPTnJRZTht?=
 =?utf-8?B?dFRteUlQbTI0bFdFN0tSc2g3Zjc0MDdDNkxDSklMQUkyaU5XNHN6ZEg0VmN4?=
 =?utf-8?B?MVp0NzJFOHZ3RVFPcjdrU2ZtVzFwZ1I5TzZUd2pvS3VXZUVHRGM2Mkpya3JT?=
 =?utf-8?B?L2NvVlFNTlFGc1p2VUN0ZE04ajJBT3JXdnBvRHZqb2oxQ1Y4NTc5T29iaEZF?=
 =?utf-8?B?ZWp0YnJBeFZSVi9JamZGQzFHMjJOWldOTGhuWlYvNU5WN2JOa05GaWt5Tk1z?=
 =?utf-8?B?VmdkRFIwYU5yVXBCeFNyRzRBYXFwS2RHUC90RVFxd1V6SFVieVR6YTRvZmNG?=
 =?utf-8?B?N29yTUhYMklvT0JkRTFCR2MwVGxFWmFncGxYQ3UxdWpjNDQvMFpDTjQ5MlVV?=
 =?utf-8?B?bmRrVXk4ZXk3QVBDQ3VqdWdGb0crQTJrU3VKeDVuVTJRc2k5ZXpScVRmV2FD?=
 =?utf-8?B?azgvSWUxUlJmY1hrVktKUEhoWlMxellBQjdEaitYUDY1Wlh3eEtWWUtqZ1Ar?=
 =?utf-8?B?NTg4V1YrZ2hqNnVMYjBxMVVRTlFpOEI2a0hueXZPSzJDMHh1ZlErWlgwbHpU?=
 =?utf-8?B?K0tQdlBRdlRsd3JyOUNtSGhaVmxZTFQyc3VKcSt0anF1WTFuN3IwTGxZVjFP?=
 =?utf-8?B?RHowTzVobS9RaDYvb1VmbVF3VGNFQnhRQTNJQTN5cTg4VEJnenhTMEdmczBv?=
 =?utf-8?B?dU95eUdNVExuTzZKczRMTlhqNzVlRnp6VytLcGd2Y0I3cHhraWc0TXBZdFZD?=
 =?utf-8?B?dDVVNDI4d2VBbXV0dmx4Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFZtcGlqcm1ZSHUrVlBTeWpxUUQvZkRCUmlOamwzMjc5YVlrTGN6NS94Z2I1?=
 =?utf-8?B?VkZWMVM4Y094d2o0RGtQUHNFVitiVDVYY2w3T3M5eWxydDgxSVBaK21xTCtw?=
 =?utf-8?B?NGpKS3ZyeHlxa0x1V3ZyZGlYY0cyZHNiMmNLL3NhNkxEeFZOVGhVajhubFkx?=
 =?utf-8?B?U21HZWtXN1JSanNoYUlDOE5HVGE0c1Z6bE5zQ2NDYXV4dm5wMmN3V204Y0Rw?=
 =?utf-8?B?WCtlZG1sU1VaRTUxTEhzY1B3WW5QOHVXSUZOaXdHTElPNTFUbkltcXZJcmoz?=
 =?utf-8?B?NWFiTm82MDZ0eFFybkV1L1l3WFZEbWUvamRsMXNLdDh0MFc2NFFXaVdHcUtH?=
 =?utf-8?B?UUpEd08rR01zVEdSZWNZMlN1eC8yMkRUcVIrcHV3TVNJSThhaEdadDhIWDVa?=
 =?utf-8?B?VjdQSXVNSS9xODRYd3Z0Q0tXNnVHYm52ajErdm9iUHNEK1Z2QW42ODk5NWxN?=
 =?utf-8?B?Tys0ZVd0MTdUTkhMUCtDS0kvb2s1NVJ6bDhYWkU4c2ZBRUovZWRKamRMS0VC?=
 =?utf-8?B?Rkc3Q2xCUDBwREkzMjJRZ1c5WnR0ZmVRbVRMSEFLU1RxeldOakpGTmZIdUtY?=
 =?utf-8?B?dXZEaVgrK0ZWWUUyeGJHQ1lrN21pZFJpdnNsTVA0cDJlUGtzNktzRzNkMlFm?=
 =?utf-8?B?ZWxGdEZvWFRTWEdCdFlNQW5VSEp4VmRzb3F0RExGTUp3azdKTlBGOWc0eWFJ?=
 =?utf-8?B?Ym5HRVREbS8yaUJYcVlnaDFYSURLSVZtcEhGRGpNMTJJQjRjdDZIcUxrVWZ0?=
 =?utf-8?B?TDZuVXdoRUJUSGJac01NYUdqc0lMOHJVbGQrM1A2cHBsQ084R1MyQzY1ZU95?=
 =?utf-8?B?TUxRZ0lFTGhxMEFRNXVWODNNemx4T0N5TnQ4N2drTzlUMjIvaVB2Q3UvV09o?=
 =?utf-8?B?NnVMM3REa2pyRTYxczJ4S3k4YW1WdmplSXArOTk2bmVMSGpPT0k4WlI3aWtG?=
 =?utf-8?B?Y1FvbnBFVEl2V214ZDUvcmxLV1dBd3NOZHhSYnBGODZ3M0daekFYYUk3RHFo?=
 =?utf-8?B?TmxqMDNzUWV1OHBQZkRQbDhXR2tGUExqUXl0U2VKcmNVMEl0UWhqYWN1b0Jw?=
 =?utf-8?B?VW8yYXZQRm5Ddy9KbndwVG1wTDdtclZCS2hKSml1QWhsSjhGNTlLOWtMeXhR?=
 =?utf-8?B?QzVlT0lRcXhTT1dZdkxrZzNNSFJoUkFLM0t0aUVYRldlUzNkZ3RraStGRnY2?=
 =?utf-8?B?UVB2eXhvdllJM3lFSHMvNGxCUmM4SkhNbFFSNUVGUGhUNjZwbTFSY0kweHd6?=
 =?utf-8?B?NEIwekpQZy9rcy9IcGhWNTNhT1NjTVdhWDJKWUszMjhmZ2creHFzYU53VjJ5?=
 =?utf-8?B?RDc1RFk4eUtqN296dmVGTnZTYkNWNlVtVXpOWmZnRHJRcWVPTlhRdEszMk1u?=
 =?utf-8?B?QkRxU3lrYWtvakJON0hqelBaRE9IdzRxK0grMHk2amhwbDE4TGRSTGJKcDhv?=
 =?utf-8?B?eVpQbFlMMGlLbjNkUkF6SHpWalRhR2VwZmFNbEhvblVUMURUTkJRZllUWlVG?=
 =?utf-8?B?TWZjYU1GYlJLRStwcVJiRkxMWTA3VGhKTE0rOGNkT3pzMk54YmJzY0IwSkly?=
 =?utf-8?B?eThFK2ZHZVlQMHM3dlRWTkZKUWFlVGo3TTgyZHR1MUxyRisraXNoQVFBbmFJ?=
 =?utf-8?B?aDJKeEEwdnppTVM4YVhrNE5sYnpjZDZPMXIwaE1qYVNaclBUSml1YWN4YVJG?=
 =?utf-8?B?RmpabU0zUWREcFNiL1lRTitYckVNZC95RGM3UThneEtCK0E2S0RrYTBQMGxj?=
 =?utf-8?B?OWwxUm54WmJhcFRvUXNLRXl5Z3pUR0RqTUVyUFlpdG5xN3RQMEMvZzdMZnNq?=
 =?utf-8?B?RUFDYytEQ0ErSVUzYnltVE91TTRmYWEvSHR2UERWRlR3U042c0RxZFVUL0xL?=
 =?utf-8?B?U095ZHhMd3ZuY3dFM2t5MHRNNkowT25SS2xtMGZZYVN2cTRYejRLcll0NUcw?=
 =?utf-8?B?OGhoenlUN3pFQUdpMGRyUlZtazNWbVBmTHFtVEFYSGs4ZWJDeTEyMStKNjhB?=
 =?utf-8?B?bFoxM3daT0Q0eFJwdW1aSE1iZTFBVEF3S3pyUS9qQXI2L3o2em90UEtEcnRU?=
 =?utf-8?B?MVg4WlZmaFEybjhsM01aZGU3T3lKSGJEN0FaTDJTcjZqM3ExcmRJNjhTeUh5?=
 =?utf-8?B?V1RUME1CZVBjR3J2SEkvTGhFTmQzS3ZLTldyazhxRjhGV1BqVzZzaGkwdW9G?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAAFCC51283FBA41B26706E6083F1BF0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vDzLGoXsVgU2mCvKqyvYTaWp35KeE/c67h8syosCJ9bWXG/1ePr2gat9JD1ezbWYf6X+fAkprSuBUwiblG1AUTDs0tAUBFGKfZ4GiTVeoowPwdzbF5oqNSerexoSMwnKSyNZPUHnihcaUoJeXwug6DNfe1xCFV0pbGUSCeenfH9g1cPlksBjKsvHfUFSv7IF+2aZKDmC/BPyqThwMrDqLx21GcvSD5gfU+KGkACNgjHYamIp+wpvReejjVazB6tnytiPet8HJg1voR63TxsnLqpdIXwyaIL7OdfqIUIQ1pTXkDkvARwUZA8tybM/VzNM+JnxmT9cHP3gitSR/lxD0Ukv7hB4kwBejiY/f+0GiENdKRkktSc1V2yCB5uCFDY+pmzawS/gLD4nw4XREam28St/Ktw/0NIWFAiRrm3xh/+RhIiIBUJiCHi+MsTYhZ8mCdKho2MNMr8uPZ3TYd8yl0QGF7BBwjVbSyk+VrEk2r2yFKy4BRF6MDmoKY9Vi13PIzSlXqjfcLxtrcTxm1REEMMNsubcZry/6yP61yQBlucyXR0hzHqhrJb1CNZISS3+CeNwD5n5A3qpHMr8TkroLV8NaYo6sRZz/JUz7xtDF1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be190924-f167-4820-f2e6-08dcdcac65ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 15:20:17.8926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbT09AJOsdRUOo0IxZh+LG1oVcPbBsqZrtfFY64ebZI2vXdZUMTHEGxM61glZxaSi+Qb081Lw+MU65to3cOPgVAd1vuwZ4jEwkYHWNAcuDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240109
X-Proofpoint-GUID: 2GAXTKhPhAHjvNhwQY5tkrGn8qbzuSZL
X-Proofpoint-ORIG-GUID: 2GAXTKhPhAHjvNhwQY5tkrGn8qbzuSZL

T24gVHVlLCAyMDI0LTA5LTI0IGF0IDA4OjU5ICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+
IA0KPiANCj4gPiBPbiAyNCBTZXAgMjAyNCwgYXQgMDk6MDEsIENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAaW5mcmFkZWFkLm9yZz4NCj4gPiB3cm90ZToNCj4gPiANCj4gPiBPbiBGcmksIFNlcCAyMCwg
MjAyNCBhdCAwNjo1MToxOEFNIC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gPiA+
IE9uIEZyaSwgU2VwIDIwLCAyMDI0IGF0IDA5OjQ2OjA2QU0gKzAwMDAsIEhhYWtvbiBCdWdnZSB3
cm90ZToNCj4gPiA+ID4gPiBJIHdvdWxkIG11Y2ggcHJlZmVyIGlmIHlvdSBjb3VsZCBtb3ZlIFJE
UyBvZmYgdGhhdCBob3JyaWJsZQ0KPiA+ID4gPiA+IEFQSSBmaW5hbGx5DQo+ID4gPiA+ID4gaW5z
dGVhZCBvZiBpbnZlc3RpbmcgbW9yZSBlZmZvcnQgaW50byBpdCBhbmQgbWFraW5nIGl0IG1vcmUN
Cj4gPiA+ID4gPiBjb21wbGljYXRlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IGliX2FsbG9jX2NxKCkg
YW5kIGZhbWlseSBkb2VzIG5vdCBzdXBwb3J0IGFybWluZyB0aGUgQ1Egd2l0aA0KPiA+ID4gPiB0
aGUgSUJfQ1FfU09MSUNJVEVEIGZsYWcsIHdoaWNoIFJEUyB1c2VzLg0KPiA+ID4gDQo+ID4gPiBU
aGVuIHdvcmsgb24gc3VwcG9ydGluZyBpdC7CoCBSRFMgYW5kIFNNQyBhcmUgdGhlIG9ubHkgdXNl
cnMsIHNvDQo+ID4gPiBvbmUNCj4gPiA+IG9mIHRoZSBtYWludGFpbmVycyBuZWVkcyB0byBkcml2
ZSBpdC4NCj4gPiANCj4gPiBJIHRvb2sgYSBxdWljayBsb29rIGF0IHdoYXQgaXQgd291bGQgdGFr
ZSwgYW5kIGFkZGluZw0KPiA+IElCX0NRX1NPTElDSVRFRA0KPiA+IHN1cHBvcnQgdG8gdGhlIGNx
IEFQSSBsb29rcyBwcmV0dHkgdHJpdmlhbCwgeW91J2xsIGp1c3QgbmVlZCB0bw0KPiA+IHBhc3MN
Cj4gPiBpdCB0byBpYl9jcV9wb29sX2dldCBieSBhZGRpbmcgYSBuZXcgYXJndW1lbnQgYW5kIHRo
ZSBwYXNzIGl0DQo+ID4gZG93biB0byBfX2liX2FsbG9jX2NxLsKgIFNvIHllcywgcGxlYXNlIGdl
dCBzdGFydGVkIGF0IG1vdmluZyBSRFMNCj4gPiBvdXQNCj4gPiBvZiB0aGUgc3RvbmUgYWdlLg0K
PiANCj4gQWdyZWUuIEknbGwgd29yayBvbiB0aGF0LiBJIGFtIGFsc28gaW5jbGluZWQgdG8gaW1w
cm92ZSBpdCBieSBoYXZpbmcNCj4gZGVzaWduYXRlZCBDUFVzIHdoZXJlIHRoZSB3b3JrZXIgdGhy
ZWFkcyBwb2xsaW5nIHRoZSBDUXMgZXhlY3V0ZSwgYXMNCj4gdGhhdCBvZnRlbiBpbXByb3ZlcyBj
YWNoZSBoaXQgcmF0ZXMuIEJ1dCB0aGF0IHdpbGwgY29tZSBhcyBhbm90aGVyDQo+IGNvbW1pdC4N
Cj4gDQo+IA0KPiBUaHhzLCBIw6Vrb24NCj4gDQoNCk9rLCBzb3VuZHMgbGlrZSBhIGdvb2QgcGxh
biB0aGVuLiAgVGhhbmtzIGZvciB3b3JraW5nIG9uIHRoaXMgSGFha29uIQ0KDQpBbGxpc29uDQoN
Cg==

