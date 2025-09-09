Return-Path: <linux-rdma+bounces-13204-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2030B4FC06
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 15:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1B6344483
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43D4321F23;
	Tue,  9 Sep 2025 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wh4UdWOA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FDOu3hWK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05857334392;
	Tue,  9 Sep 2025 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423141; cv=fail; b=KcFwBVR/raPghUPiFFRx3E9gVtLbMCGATjC00qFLhfVUlxhK8s6wQniwyoTagpp+VcJqo5KVg9ViQepljNGebDiXDs8Kt0a717D+tp06t00uHN9KfeasM9LkTTMPEAdyG9pAqvkonimjOBWv/DKUPBA/2KYQHeeE9YlDAThC1f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423141; c=relaxed/simple;
	bh=hmotD/1y4gCAd5gTIm2/TpVf6O4t1s6SVuqHr9CZF+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e4lVtzqgur4m9PDtBO+HuPW4daS+4bpuZqrlS9krOndQZ8rrm3F9n0ppoxEnxvWLqI/87yrGKGzZrYTk4rzFv+Od8X+8m26rfyWAMaY/9mUFVSEu1Vo3KwjeK4cczh+ROiRGvVSmiSsSOTJoO15ZMOVdbEw+e+otgeQm7zW9bZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wh4UdWOA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FDOu3hWK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589CPI37004157;
	Tue, 9 Sep 2025 13:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hmotD/1y4gCAd5gTIm2/TpVf6O4t1s6SVuqHr9CZF+Y=; b=
	Wh4UdWOAI2Ym9np2rTfMqQMbfmJmoNzBFl+xjnLZmjw5RQRt8xWH5dI7+RZccx3Z
	1pJ4KpEHli1dg2JXf2TQdhqL9wvztFHZ7w8KQMICx9PxwVRY4k5Z5srwZoq6XL1e
	KsQavSJ2+rFk4CbQ1sJlOpXXd9UIImz9I9CGHW3VE2XyGwWzDTh5u8CeuB9ATVjG
	Jte/BEA8qkiAUmDZxUjDjxHixqWIJAlZs3JDsMiMJGUhuztZXF8bVG/ysx2P9rCT
	RjE/vwq7xDmMJUYnzsiE2M7IpfrZaRwfHvn80XpNWrpXg9Aqe9X2AF6oj2sdqqem
	w9wr3JjtQvEjIRVLa83LwQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1j0p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 13:05:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589BoHa5030651;
	Tue, 9 Sep 2025 13:05:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9jd8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 13:05:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOclmJeKtLk4SrtVamo3ECUe7l1aTzRpKDuP7A3V+Tdzp0OKFd/v4cS3ajrJQiV37N1JKFYbHevX2Mc/BBU1QRA5jzka4C2e2bs4hF8RgpGasBJqEX2q6WJBvfUpjjilSQxPUGIj/0RRT8qAYpw1Hgfv63C/sg9Yr0w8miSlHtAhjOI4hRFvk0nJId7vHEJU/ZP4YhX0iO0zqn52lEqHd2eHjyX8036PrP6nZw3SeXDhvhBcDfNmxyd+ModJbCAhW8kyh5u4eCYLKWV7mr2ks2eYUpSv2a+rzmiJWkyix6n6UjGqVruzuypRJLv9zLcj0IoGCLZ7EGxRcc5ZolHC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmotD/1y4gCAd5gTIm2/TpVf6O4t1s6SVuqHr9CZF+Y=;
 b=y1eq59bfXAXTmd5yMtIMxhoSyfNC22nTyP6EKWiTu0lJ3b0kchEGSTpWK3PRl5hb7C84UhGC8RIOSMKoRqC6PZJxfhIF34Z2YKjdPiiGuClpkZzkus/4YZteZk1UGF2YHlmAJFGNQRcUaUsc6YMCndxqLH59HwlGLysvcKuHiYDrxs3Sibw8caLxxYgfMcDdE2+lWKg39mJCfGOJdli39LqZu9O6p24Mrmb7202ZK4V6X+HzEd6809r67I0p/Ywp+Y9YpWqNJ7tx8D6Gxy1p1bZQaful10YAPI6npz6/5JEQdbnrxG7q3E1aUPafoYw0IcnWvfWYZcB/c/UiSdsKHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmotD/1y4gCAd5gTIm2/TpVf6O4t1s6SVuqHr9CZF+Y=;
 b=FDOu3hWKiuDL3Eu1chrSx5t3imT+w9NJ+ObRVZQYRPIbmbEbXys2sEYAdPHJ7DAhRVhgj7tMVHqiNy5BTO+Oc0ITf59H9qswZEhUemw/sBRECE+6FsB6ozDZD40k9YNwqREJNzVUFgcijNZ3hAzgvZ4dcPGMMnFs0YW9DTkMwK0=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by MW5PR10MB5827.namprd10.prod.outlook.com (2603:10b6:303:19c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 13:05:02 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:05:02 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Mark Bloch <mbloch@nvidia.com>
CC: Parav Pandit <parav@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon
 Romanovsky <leon@kernel.org>,
        Chiara Meiohas <cmeiohas@nvidia.com>,
        Michael
 Guralnik <michaelgur@nvidia.com>,
        Yuyu Li <liyuyu6@huawei.com>, Patrisious
 Haddad <phaddad@nvidia.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>, Yishai Hadas
	<yishaih@nvidia.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        Wang
 Liang <wangliang74@huawei.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        OFED
 mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/core: Fix socket leak in
 rdma_dev_init_net
Thread-Topic: [PATCH rdma-next 1/1] RDMA/core: Fix socket leak in
 rdma_dev_init_net
Thread-Index: AQHcC45MTdbHfTMOIEuspojz6H8197RfCJqAgAAWz4CAK94igA==
Date: Tue, 9 Sep 2025 13:05:02 +0000
Message-ID: <D196808D-3216-4C82-819D-B9549ED14586@oracle.com>
References: <20250812133743.1788579-1-haakon.bugge@oracle.com>
 <CY8PR12MB719547A39C4B93FFA6FF40EEDC2BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <13cc74e7-4a18-45e6-b511-940f9ed56a2b@nvidia.com>
In-Reply-To: <13cc74e7-4a18-45e6-b511-940f9ed56a2b@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|MW5PR10MB5827:EE_
x-ms-office365-filtering-correlation-id: 69d54fb3-c9d2-46e4-e99f-08ddefa17d07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUd6T2NWM25uR1NpMjJkWHZWZFJtWEZsSVN4WGNvb1BZaVRia0NzbWlleldl?=
 =?utf-8?B?QUxEV2J2OHM0YVZiTTcxbExGQXdoNUptS3VFeE04RTlTa2luMDd2TkFYZjZM?=
 =?utf-8?B?V1ZTaWtkWVlCWllYekNMSng3Q3NFNlFHZWszWmY3c241ZVJUZnJsY0FyVEZX?=
 =?utf-8?B?aStUc25GdjV1UEY0dVhFZnRLWXFmY0RkUkRjcStLbnFLTjcxRGl0OFNOZWZ0?=
 =?utf-8?B?a0EvUldsWXZ6enZFaEk1TXFnTDQyZ2FGc1RiSEpsMUpJeUVBbUJMNFc0SlI0?=
 =?utf-8?B?ejBaSnIwNm05U05DVWptMjFIcWdYNEpPbXIzU2UxdjMvR01LckVTZEVqQ0ln?=
 =?utf-8?B?aEpnNzJ1ZGp2czFnRlBjM1d2WW1pU2w5dG54U0dsZlRjT0szaVFQSHNCS1ZE?=
 =?utf-8?B?Mk1aaXprRmxWZU1EUTlXN1diQUxFNm4xTWVMNGFCVFRtOWpnNHZsU3RUZ3dj?=
 =?utf-8?B?ZGhEbXNzT0h4c3pPUkhqd05WV2QvZjBYd3JmTzREdEJFbTc0cjAwY0dSMldZ?=
 =?utf-8?B?TkhjRW5nbHJGRFFIc1FyS1FNdUM4OE9Ca3FGQmhzTUlHSllpM2xzNnB5cEVa?=
 =?utf-8?B?TGQ0SGQ3ZTlZM1dUd01nbnJva1ptbzN5dUVrNExwSmFRc3ByS3dqY1FxUDAr?=
 =?utf-8?B?SXZ0VGhaZ1hCSnFEVjBxZ0h1eUxkQXJhaHErdmpMYUJqaTJvai9HZjIxY0h4?=
 =?utf-8?B?ay9MOUIrbndSSEJnUGd2WFlrQzNpMkdWUFBsWXNRSGJpLzNoU1RDc29oOFdm?=
 =?utf-8?B?WHRIU0dLZndGcW1jclBLT3FFaW9zREtnVnpDa0R0VTc4Nm5seDNTWENvdzBs?=
 =?utf-8?B?R3J4L3JJS09HREpzRUcrNjdqWmFxYlVLbnIzRGNERUx6VWk0V1dnbUk2K04v?=
 =?utf-8?B?d0txeGVXT2lyV0lZTy9VaGRvM25Db3VEWFd6akRkdUE0OWs2ZTFsWGhJVjNS?=
 =?utf-8?B?MUl2aURDcjFHakJobUN6Wnlqa25QY1NUejhMMEpDTkQ0RHdpVW56aFZZY3hp?=
 =?utf-8?B?R1BFdWlPY0tkY3R2N2JHVzl5NnFsZ25FR25MU3pCLzRudGs5MkFpQm10NThT?=
 =?utf-8?B?alBwYnlQWmhtQUV1cTVXbVk3N3R2UERoOTRjL0tyK0Q2anlGN2ZPa1ZRajZF?=
 =?utf-8?B?VmpGRUNKaE54K3FBR1VxZWRHT084bjVIWlgyMjhxVXdhTEo5TS9qY1gyWmx2?=
 =?utf-8?B?cXVOb1RRQWZ5dUNBTU1EcG42MmllTDExTklCZjN3cjBub2NqOUZBMUYwdzFt?=
 =?utf-8?B?OVAyY292NjRlc05IQkNVLzhaMFZhbFJtQ1hvamIzN1d3eXh3aXRDUURyNDNr?=
 =?utf-8?B?VGxtT0lDMnM2V015d2tZU2JJWnJlVURKNmxTTnhvU3V6dEpYcmhYYW1Icld0?=
 =?utf-8?B?Z1lHb1dKK2MwL2JmL3BwK0w3aGxaT0RGVERuVWZqcUQ4SGRWRGZZbEF0aHVT?=
 =?utf-8?B?TzVNcXVEVWRpeTlaWis0WVEwTUVPeDIydHVjU3ZoVkFoUEpBU2pRR0JjZUJk?=
 =?utf-8?B?aXczai9vUFV4VWNBaEFrckI5R2ZLSWZZUEIxN0lIWHdJUmdxOHNTUmR4eEJH?=
 =?utf-8?B?WDRBeEorSXdYcWtUUVJLVnNaSEgxWWwzdGxNRXBHN2xwK3A3bTNERFNaZ281?=
 =?utf-8?B?bjJCbncwaS9sWHlLajYrZGVYWFdnayswdFM5MU9MOTlKQ0ZRQmRUSWgvcm9v?=
 =?utf-8?B?ZnRaYlZpTUt6Nk1jNXlmZzMrbXhnc0pwQW1TTlpkak44RythT28zWFl1MXJO?=
 =?utf-8?B?UEhJS2RDTFdjNDVtWHhkNHFJL2FNNDhuTmJoNFFTS2I4eDJZMDRrd01UaVAx?=
 =?utf-8?B?bXZHQUtXSWpGMDZkbTBFN3FvaVdGTXVEMVNzM3ozODgwOURFL1NaRURtNVBi?=
 =?utf-8?B?SG5zUWJKTEpCL2d3UWFuZjVHV2Y1RCtkeFU2dWU1eW05bFNabktpQ1F0cG4r?=
 =?utf-8?B?d2lEL1k4dFZrRmtTT2ZFQUx6YnhxSmt3NnhyaUkzR2NtZ2hHYk5hTU9Ya1Fh?=
 =?utf-8?Q?rhcGA5z2nY9t0qQPeJ+7Zb3jdWA5xc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTNRclRwWFd4ODZFRlFCNCtyK0xGcGFOUVFSZWwyRHJKRUJyaXJRWlJqeEFn?=
 =?utf-8?B?VldVQWJyTmt2UVBiQmx6QkdHU2hNTVgyYS9sSnBmY2dycUJzTEFhTVFZQXp6?=
 =?utf-8?B?azB6VnpNVE5idzl5aTA0aVUxcXgxakFHSXROempveGM2ai9VZXVON1BHZnFK?=
 =?utf-8?B?QWJ5VTQyWXRQS0dXa2pjVjc5NjNmdDZnZ1YyaWpGNEtOZXJiejVxcHZrcXY4?=
 =?utf-8?B?WXhvbm5GOTFmM0Z6TXdSZittZXlxT1pSRFJDTnc4Mk1DZFFEM1ZvRVJVbWJ4?=
 =?utf-8?B?ak1ZVDFHV3c2TVlpNkp1RERtZFZpMCt2VUUwbFd1L00zN0NyZThDU1dCOTM2?=
 =?utf-8?B?RnRsQUo5ZEF1SHRhYjNkOVBPQ2ZJZG1JVldRL0RaOHlUcEd5VFphN0tITldD?=
 =?utf-8?B?eWFUOG1Xb0R0Z05Oa2xPamtFazJWcUtoam5YeTdFeWptcGRaSzVhN0xUdlNS?=
 =?utf-8?B?cmdadEEvZjFjYW5wK3ZUWUJDVjhuWGsrUHlSTTNJalFncUpwUlRISjE5cDkw?=
 =?utf-8?B?eEVxbCtaWkk4bXRkWEcxQXFxUjFwK0hhTHR6NTZzaWduQkU0a2hERFFDeSt5?=
 =?utf-8?B?NWlHSWVrRGRnQm1hTUwxQ1dlM29Na2RHYzdicXVPdEpna2l3RUszR0p5SFhh?=
 =?utf-8?B?R2hTbjkxRGQralk5ODhkOXU5T2ZPcEpTMXJqWDhFVjJ4YnNOK2VQUUN2dHNR?=
 =?utf-8?B?SWgrd1hvbTg1cmpUWXhMSXg3MzdCeUd3ZnFudENYL3k1TGFUVFNIUnNtRkp5?=
 =?utf-8?B?UXFTUGhEQm1XQXZZbUxUYUE3YXprdENBWmVQN3JTRkhib0d4eW0vclppL0pD?=
 =?utf-8?B?TFZ6aUNIaVByM1pReHpvMmJEL2ppSFc3dG1VUytOdTQ1OGFoVFVUTVd3N3RR?=
 =?utf-8?B?dGhONlJYYVB0WnZSRCtwVXlyZ1pQVW5POFBXdmhHM0kzclJkMnFITlBuZDZI?=
 =?utf-8?B?b2xpRHlFZzZRWjA1RTVER2tEelNlMUZTVmRwcWpibFEweXBCcUdxTzlyS0Q3?=
 =?utf-8?B?L3U3TW02a0RNL3JQTzRWc0ZWSng4UHdqQUh0N0xBNmRSTE9PVFo1a3h6NDYw?=
 =?utf-8?B?amRSbTZBQ3AzbGVsU2JRdVM4bC9KQXVLamxpemtEbHRYMHhIcTRoTTgzQjBm?=
 =?utf-8?B?M1ZJbXpmUldJRWRJWHIzSTZrdHdoNkVMVG55K0cxM3liaGI1Sk4xNWl6QXpx?=
 =?utf-8?B?enpQTnZ6ODV5TDdJNVpvbWNpb3N6cDduQ1drMHdWSytvcHc1NlRZQXRBYnJl?=
 =?utf-8?B?UTZ0WW5iOEtLVmxRckZ4N2drQlJDL0p3TlR6OC9ZamRrdmhId2krL3Vvak1t?=
 =?utf-8?B?eDdqRzExak93cWF4RnV3OFJGc3MyeFkrVTZCMVZnT2xGMEV1M1R2TW1adWsr?=
 =?utf-8?B?NDJxbmZmZGJzUVJmR1ZTSjgweVRGcFliV0dPMWdVems1Z3BUam4vcjNRZmQ0?=
 =?utf-8?B?bkNFRXFjb1dRa2EySWsxSGtkU0hWYWJmTDhLQmxJcDBLMXA5QktSUEhPRita?=
 =?utf-8?B?RjVXY0dMRVBQTko5amcvck5uc0xpclo1VTlFcEx6eEVhQ3VBWlZFRjlraHpr?=
 =?utf-8?B?V3hVS0Y2K2xDQ3VKa2hqOG43OHNCakloekdFYzMzNzYxM3MrQVBKRG5GSnM1?=
 =?utf-8?B?ZlYrREhIc0M2a2ROS3U5OFJnelRoVEEzUTd3RXppR3c3eHYydS91aDVrV0ZH?=
 =?utf-8?B?cXB6ekVLdzRBMzB0Y3REc2hPb1Z1QWNpSDFYNWN6Mk4vcnhITVdlNzMzYWQ2?=
 =?utf-8?B?SXQxd1lmMnE3bVVQalJvVU43aTFHbGRyZCtVZTFWWWlDMTlyVmg3Sy9DZWRK?=
 =?utf-8?B?MWRxa2VwL3VSNEJMODdwL0kvcXZlWUdQdzlWbmNOTXZHOWUrMnd2aE8wd3Qw?=
 =?utf-8?B?OEhLdXZTcks3M2tzWnVKZVp0T2hZcHRBd0VibDB2d1B2KzNoUDR0c21iNlhT?=
 =?utf-8?B?TDZubEdFbS9qTXBQNk1WTjlkUlpCWmxpOTBWTWlFeUI3VnA2K3VxMm9CM2VF?=
 =?utf-8?B?amVTOUd0M1ZkbUlxbjBhS1dGdy9LREt4TVI2R3MwZ211cXBGU2x1dnJRNHFD?=
 =?utf-8?B?cjF5Wm95ZEs4cU54d1RFdlY4MWNGYSt6OHBDTUlJR29OTFVsSjVSaFFQK0FQ?=
 =?utf-8?B?cHNxZEd6N2pwRHZPdXVFZy96c0p1dU53NUpkM1dKTWkzYS8xZjhaczI4dnJq?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA005FEFEB2222489E1B57E73B655B02@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TKq19hlHEFnU2ZBc/5WJl4L/OXQ+DFZhB4iBeCQWWfBthmtrT7VjmGdk1MGa2rN8+sXDTr8gkZD9Fml89RU52/r3NkBKNUDDMm0NSBsVEdw2z0OMIPyckAPvevAAdc0JKlOZQdW4fn3nBlnZSIc1MpYYOMzO3wgbBOrV6moAeJoiwCa35pRah+40UJ4iTEToXd4g/h69Kk2i0DR3giW+oZayaECMLMpp8XCjPmoKetSV5f1AXdc09JeP/MyQexw9fuxz6mAE1F0vRXMBGiT0bhRWbLUWfQYsIWLQEtZNdYpeRlSwuHnZOhqAWIje3ESuJoYoODOPIhzc//CRsezypl2aLJXOL80u3uw3DyDRbGrPRG8ayKFuRklvwlC/Q8JiP8cBDaGFVIX7FA/EZ9zhu5K9Z5AYFn/DTRhEo50iWFJRbpnz8gcwRg2G5fOeyYHRrjUiMREsPA1clWDFZpJFKWRmU46vz/BSNVdaplq7i4xovOklCHyOYZNFc1QVjOMEOpdF1bpWrGldU2/XUj4h4a0HaZzai4wtDok8yBdevsJs/2O/S1NYrzBEiYx2twbnuHUCf5/0Ncfvg9McwuRJIPRJJVWXTVx1RO5hwH1m3IY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d54fb3-c9d2-46e4-e99f-08ddefa17d07
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 13:05:02.2579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRmyBvxBggjzD1Vw/GFMoSF7HPFav8iY/trPIsDWMJkaFBPEO34+LmITl2PXX0ytgAGYvEJ0BwewVgjRuRhHBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509090129
X-Proofpoint-ORIG-GUID: s_zNZJ7Z7XEVfPyrsKOflc7R8dcyQe2P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfXzXliQnTWP47T
 j/NLaXywq64G08cgxIPHUlIhbts5EVzI25VfN0xUQ3wFjGVN8MDUHGE5wcF+DxZOuEwG6iHPwKo
 NJSYbtRZdJ5sp+Zr/BTwRwBF9xO02jb8c9YMy30qNpjrVdDJKSkAyjptxCuP/rxTqR8MFv2DUa5
 J6nQBWRIJhfffKNi3vpZDP1FxIb0dUdxPRosIW05XFzExKatK5i1acVdpPQTzBK2ynXX9U9pLZN
 LbCDHwEdRFLmTMytg8cc6JlI+hmhBF37ehTcCmc9GqfGq5A4PIfZymK+qOQaA22s1vUoF8ruM97
 4h0dLsceyqIgd+ieIlAw716/OXkhXElqRdMcY9OvOKWZnHuOP9ju7Aajnz1MtGwf+IfKBpAnkrl
 mJ/ywwer
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c02604 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=gpDvhT54eWJrgjU5GRcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: s_zNZJ7Z7XEVfPyrsKOflc7R8dcyQe2P

DQoNCj4gT24gMTIgQXVnIDIwMjUsIGF0IDE3OjEwLCBNYXJrIEJsb2NoIDxtYmxvY2hAbnZpZGlh
LmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+IE9uIDEyLzA4LzIwMjUgMTY6NDksIFBhcmF2IFBh
bmRpdCB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gRnJvbTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVn
Z2VAb3JhY2xlLmNvbT4NCj4+PiBTZW50OiAxMiBBdWd1c3QgMjAyNSAwNzowOCBQTQ0KPj4+IA0K
Pj4+IElmIHJkbWFfZGV2X2luaXRfbmV0KCkgaGFzIGFuIGVhcmx5IHJldHVybiBiZWNhdXNlIHRo
ZSBzdXBwbGllZCBuZXQgaXMgdGhlDQo+Pj4gZGVmYXVsdCBpbml0X25ldCwgd2UgbmVlZCB0byBj
YWxsIHJkbWFfbmxfbmV0X2V4aXQoKSBiZWZvcmUgcmV0dXJuaW5nLg0KPj4+IA0KPj4gTm90IHJl
YWxseS4NCj4+IFdlIHN0aWxsIG5lZWQgdG8gY3JlYXRlIHRoZSBuZXRsaW5rIHNvY2tldCBzbyB0
aGF0IHJkbWEgY29tbWFuZHMgY2FuIGJlIG9wZXJhdGlvbmFsIGluIGluaXRfbmV0Lg0KPj4gDQo+
PiBIb3dldmVyLCB0aGVyZSBpcyBhIGJ1ZyBpbiBpbmNvcnJlY3RseSBjbGVhbmluZyB1cCB0aGUg
aW5pdF9uZXQgZHVyaW5nIGliX2NvcmUgZHJpdmVyIHVubG9hZCBmbG93Lg0KPj4gDQo+PiBJIHJl
dmlld2VkIGEgZml4IGludGVybmFsbHkgZnJvbSBNYXJrIEJsb2NoIGZvciBpdC4NCj4+IEl0IHNo
b3VsZCBiZSBwb3N0ZWQgYW55dGltZSBzb29uIGZyb20gTGVvbidzIHF1ZXVlLg0KPj4gDQo+PiBN
YXJrLA0KPj4gQ2FuIHlvdSBwbGVhc2UgY29tbWVudCBvbiBwbGFuIHRvIHBvc3QgdGhlIGZpeCB0
byByZG1hLXJjPw0KPiANCj4gTGVvbiBpcyByZXZpZXdpbmcgaXQgbm93LCBvbmNlIGhl4oCZcyBm
aW5pc2hlZCwgaGXigJlsbCBzZW5kIGl0Lg0KDQpJIGFtIGhhcHB5IHRvIHJldmlldyBpdCAob3Ig
bWF5IGJlIEkgbWlzc2VkIGl0PykuDQoNCg0KVGh4cywgSMOla29uDQoNCg0KPiANCj4gTWFyaw0K
PiANCj4+IA0KPj4gDQo+Pj4gRml4ZXM6IDRlMGY3YjkwNzA3MiAoIlJETUEvY29yZTogSW1wbGVt
ZW50IGNvbXBhdCBkZXZpY2Uvc3lzZnMgdHJlZSBpbiBuZXQNCj4+PiBuYW1lc3BhY2UiKQ0KPj4+
IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+Pj4gU2lnbmVkLW9mZi1ieTogSMOla29uIEJ1
Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4+PiAtLS0NCj4+PiBkcml2ZXJzL2luZmlu
aWJhbmQvY29yZS9kZXZpY2UuYyB8IDQgKysrLQ0KPj4+IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
bmZpbmliYW5kL2NvcmUvZGV2aWNlLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9kZXZpY2Uu
Yw0KPj4+IGluZGV4IDMxNDVjYjM0YTFkMjAuLmVjNTY0MmU3MGM1ZGIgMTAwNjQ0DQo+Pj4gLS0t
IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvZGV2aWNlLmMNCj4+PiArKysgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvY29yZS9kZXZpY2UuYw0KPj4+IEBAIC0xMjAzLDggKzEyMDMsMTAgQEAgc3RhdGlj
IF9fbmV0X2luaXQgaW50IHJkbWFfZGV2X2luaXRfbmV0KHN0cnVjdCBuZXQNCj4+PiAqbmV0KQ0K
Pj4+IHJldHVybiByZXQ7DQo+Pj4gDQo+Pj4gLyogTm8gbmVlZCB0byBjcmVhdGUgYW55IGNvbXBh
dCBkZXZpY2VzIGluIGRlZmF1bHQgaW5pdF9uZXQuICovDQo+Pj4gLSBpZiAobmV0X2VxKG5ldCwg
JmluaXRfbmV0KSkNCj4+PiArIGlmIChuZXRfZXEobmV0LCAmaW5pdF9uZXQpKSB7DQo+Pj4gKyBy
ZG1hX25sX25ldF9leGl0KHJuZXQpOw0KPj4+IHJldHVybiAwOw0KPj4+ICsgfQ0KPj4+IA0KPj4+
IHJldCA9IHhhX2FsbG9jKCZyZG1hX25ldHMsICZybmV0LT5pZCwgcm5ldCwgeGFfbGltaXRfMzJi
LA0KPj4+IEdGUF9LRVJORUwpOw0KPj4+IGlmIChyZXQpIHsNCj4+PiAtLQ0KPj4+IDIuNDMuNQ0K
DQoNCg==

