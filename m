Return-Path: <linux-rdma+bounces-2499-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5D68C685A
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 16:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840B21C20DB8
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 14:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E055F13F43A;
	Wed, 15 May 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SdzzgI1B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n5z1uNBV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3D13F430;
	Wed, 15 May 2024 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715782360; cv=fail; b=ecAiLkjpN9jRJCJRClibRn69uihXCPD8GSXVx/4Dew2oNt21EjZHZaPss/8o6gJuxfiUwbZ7Dst+t151JmegTLlJgDooUv+Ok4IBd1IixRPRG3rtkOv9yLh3YDQEa58AKyRJd7iMUJXFD1Fo7+QWyQ1nUG8uj3cyfqi6Qe/059w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715782360; c=relaxed/simple;
	bh=3c1tVQPStS6iXrRnFKo6g7ui3YRFoanSA6zTXpYONsE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fQL5FBCf2LXo1tznv0HrEPksnaetlkN6Sp4kT6qSXVToPES70V3saQGK7GOeo15LSb/xpUgiW46j4UAFR4MoiMhJUc5R+X7f3KpbVgHIv/GxbvZ39NN5s0YXRe28FPH6zQzarG0aHj4BpvLQ0UbDyRSrFfQ5CT9muII9PUz5XzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SdzzgI1B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n5z1uNBV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44F7n3Tm019760;
	Wed, 15 May 2024 14:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3c1tVQPStS6iXrRnFKo6g7ui3YRFoanSA6zTXpYONsE=;
 b=SdzzgI1BllDv6eI+QkpBGiBAAyWRSibqgv+kqTTnKGNt4nfHB1XYsSdw3EpPVd826O8G
 00mvkEQAwk9MiAg179JuVGZ5jxY2dKTyqhf3WttJS2DJQ2WxVlG6WRA+hpAFtcl+Ofl6
 /ukmr0VJMKMXoG807PmB9lK+mYROz6XWjYZ45qLEzH1/oslTwgz7g/WsXZ2iAB2v4GlH
 IOC2ApfvJ9pHD9mwhxPLvyQsMyPCeYFJ5ChvZHB5dciUPgi9xRICBp5i4fOb+veSCG/d
 ieWxUpGc6PCxtxmx5DSGKLOIoAgEhOT1USTafpGY2PC0GeCgOvh+fN5Vrq0PCvB43d/k xQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3rh7dc8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 14:12:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44FCtXfi018751;
	Wed, 15 May 2024 14:12:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4940re-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 14:12:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IM6TWHTdBRPmVsNlumqDs0FIMnggC8oRPmVyR5Ei8ItNpa4wP/jwOpLbcrxuI4tJQfRHpXY351lBBnutuWCxPC9++SDJdGANst3akkEofWzlbNfLcScDYi9kE1f45j+kkeM9VeD7gA/ma/OuT+b7pE9Nx++A2XmnZ1UHg2DDVdgIKIye9e5gG1w44zcWtjXxUfJOL1HCH1XA5Qfv/ZIRxIIMJEL/a0bZTLxzBQ6Luk8SbOM4BsS7c7hwRa/YJXSIrTnfS6pmWNEUCgWrwqW2xPwlMHl3ote/DcTQacDw1rtNRRk7hx52QFGwieqK3QGLaDQ2QHblOiDEaVb4kBVBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3c1tVQPStS6iXrRnFKo6g7ui3YRFoanSA6zTXpYONsE=;
 b=euJudLfEE5EV/Syvag5xcUgHp87POcMHz+s+qeuW2Ac/QufDUu7xywriKVFFQY8brII+VppNeAbSQPpMqKY9kJi57j4PY8sNBoerigCYG6CX9dVo7uB/q7+v8Z1UG+l9CrjawAkBLbwnByv1C+lf6y/ORHyqjDJAjB5z0CDInDGMLnTdvla9Gt9WcAKP2eX0zsinc5TyuZcm4oYy7LjXGUqLqc00apJWj+JNYqsAnO5dlzjLbMYKhuKXdK7d22jFNggDNbhaUsWB+rP3kX+uRJtqqU/6KmoSMomZcnbvTKDRXaemfUWT/HnE//Rb+40cJo/7+SGB/im+MWmj/Dks0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3c1tVQPStS6iXrRnFKo6g7ui3YRFoanSA6zTXpYONsE=;
 b=n5z1uNBVhzu7OHj+3oJMQUjqxSkeqpLbTZfuG09urGplIp5p/LWpec1GxBMImtDCURUHGQmoJZyQkB5XaLZ+/2aRxRjwm2ilJJq1OsBrEjb8PJSVO0sjp9vkaxbgITmqvRq8tPqY6h7PeS+4hU9qM23ExVZ+LgjISxQnAzIlfxQ=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by DS7PR10MB5039.namprd10.prod.outlook.com (2603:10b6:5:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Wed, 15 May
 2024 14:11:59 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836%3]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 14:11:59 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Tejun Heo <tj@kernel.org>
CC: OFED mailing list <linux-rdma@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lai Jiangshan
	<jiangshanlai@gmail.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Mark Zhang
	<markzhang@nvidia.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Shiraz
 Saleem <shiraz.saleem@intel.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH 1/6] workqueue: Inherit NOIO and NOFS alloc flags
Thread-Topic: [PATCH 1/6] workqueue: Inherit NOIO and NOFS alloc flags
Thread-Index: AQHapTSrQvuhoNL+7ECbQrjKwsOry7GVYGQAgAFf7gCAADKNAIABZl0A
Date: Wed, 15 May 2024 14:11:59 +0000
Message-ID: <DD2C1016-9F92-4088-A239-BBA6063CCE41@oracle.com>
References: <20240513125346.764076-1-haakon.bugge@oracle.com>
 <20240513125346.764076-2-haakon.bugge@oracle.com>
 <ZkJEZuNRqIVUGcSn@slm.duckdns.org>
 <6E7B1E61-5BB1-47C0-ACA9-989EC0FD03B9@oracle.com>
 <ZkOWBjCO2zE14edD@slm.duckdns.org>
In-Reply-To: <ZkOWBjCO2zE14edD@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|DS7PR10MB5039:EE_
x-ms-office365-filtering-correlation-id: 043dbb6b-df5b-40bc-e74b-08dc74e8fc59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RVZSeWpmdmVvd1V0TFpzRmd6SlBNL1lLL0FmZlY2VG5tQldoTkVqUWxFNDFB?=
 =?utf-8?B?OGgvcDRwdWdiZ3hvcjBPZ3RFV1RNclk3aGRrVVUrVzhzdkZXdC91THBObkxU?=
 =?utf-8?B?QmxNd3E2SDFSVmxBZWZta1p4K1VyamdZSUkrKzVvSHMwSGJuZnloZk1hakc3?=
 =?utf-8?B?MEY0dmlIeG84bUI5RWdsenpKakh3aGFGU1QvQ3BlQzBYTzBEZ0tmNEczY0Va?=
 =?utf-8?B?ZHdOemNZWFV4VXY1Z0Z1bktCd1dXYm13NHpiTDJHbFRpcDR2RHZzNDNLZmkv?=
 =?utf-8?B?ejdJa2NPSFh5c1ZBTkVFU0NHQmVNTzNDc0l0b1ZLTjhTRE1aOFNxbXpCT25N?=
 =?utf-8?B?MGczbW1FY3dTYkEwTlZDcExVL3R5ZjZiaGN4RU1FeTR1cGp3dUFyMW54aWo0?=
 =?utf-8?B?VTZ0Zk5sUG5kWlpCaTNOMUpzaUVublFnd3BnL3N5QXM5U2NjZ0MxZVVFTkg5?=
 =?utf-8?B?SThKbWl3VDhGS0xvTE1BVE94eU5WeUNrZ0pGQ2w3cUhKb0YzNWR5dzVIUERt?=
 =?utf-8?B?b0l5UytwK0YyNUt6UGJ5QTRXcllXM0JlQ05INHFYWVp1TmNRbWpXcEpSNXp6?=
 =?utf-8?B?bVJPY0I5cnZTUUhoeEx4VlZNd01QTWlsejN2cWt3M1U1d2FKT1hjNVRScFVw?=
 =?utf-8?B?K1lJVUVkWHBqZ1NUdlJDUHNHQWxoMHEzT0lQTjB3YlBmVDR1N2F0UDBab215?=
 =?utf-8?B?WFZMbkRwa3ZNc3ZyUGNLenhBTFdZaExhK1UrcFBKTGVaVnhuQXAwVUxsYTEr?=
 =?utf-8?B?MHVKWHJ4aW1XOVVCVVI2dTl0TDJpSm1lQnZNcTVJMjhYdWFsTklRRk5Ia2cw?=
 =?utf-8?B?NG9jdnJ3S1c1TW5ZTHBCa1RKNVIzb1A0cGJORWpBYW5UOTRLZ3Vyd1NtMHYw?=
 =?utf-8?B?S3VnZ3FxSzhabTBYdGIzMWxPUTFqVVFqOWs4RTZKS1dLL0Uzb1ZDMGZpZ1dN?=
 =?utf-8?B?Mm1aT2hjdHc2cCtoTHVHemVqVmFtN2I0UlUxVDJHVWE0c3hDdTNzOHduTnhR?=
 =?utf-8?B?YXBoQkFvYXl0alJFNnVtemw2UFAwUDhaNUZ2aElhMWcrc2EyZmI2ZllRY2NR?=
 =?utf-8?B?aDdINDYxbzc2QkY5SkM4Tkc2WmU2cGdQckZQUFh6dk5wVEtuQkJQTXdQemRK?=
 =?utf-8?B?VkhKaXlzNjh3aVVOS0Nyek9xUTRJMFNnd1BlZGNwRFhESlB6YVpqMVM1Mm5Z?=
 =?utf-8?B?Rk9qKzk1S2ttcFNIRUlUc1M0a2NUZmlSRnZ1Sk05N01ZcDNmSVoyOEJKYVVQ?=
 =?utf-8?B?cnlON0ZYdE80dUcrSUNGdXNTRjNXUXZabVMxQko5Y0VUbkx2WVl5WE5xYlhH?=
 =?utf-8?B?R2JEVDVnZE5IQVF2LzJ0em5salE2SVc3b1M0QXRyTVpXS0dYcWlJNXJ5M2RD?=
 =?utf-8?B?U2gyVjNoWnNzVTZKN1BiR3UxYlppa0FtdXdUNEJ1ajkwZ1dJbnNLUmNNU0xn?=
 =?utf-8?B?ZDQ0Z20rRmJQUGFnWXZjNEV0VDZ6dy92R2t0bzRJaEFvRVUrNnNZWkdaWDVD?=
 =?utf-8?B?MEVudW0wRU1oejhpWVFrWkFSN0FzQUZHRHgweSt3dDU1Z1dIOUI4TEV6VDl6?=
 =?utf-8?B?NGFRaW5mZUpjb3p4Z0FGZTJ6aDN0dVBnazdnV1dnQzlZTUR4NDJBMVJCeXlY?=
 =?utf-8?B?RVM5SkZ4UHd6RDFMRzRiR2cxeWRGNGJ6dWpDSjFOSHhsRkVmYkJxNUVicmEr?=
 =?utf-8?B?bENnRkRwdlcxcjVVV2t5N1d4Tml3NTlpTkdVMW1MQlNrVmU0WHczdmtDZExJ?=
 =?utf-8?B?L0tNai9sMVJ3TW04RlNuOUErU0FScjVQUS84amFhRjBTSVJjTTY1cXlrTTJw?=
 =?utf-8?B?dzlvN1QvSlNlRCs3MFM4UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?S1ZrcURXTi9uMDNjWXo0TDJFVmRlNTZvZWNMeVJPUjA2eElHOHV6WHREMm9W?=
 =?utf-8?B?Y2gzU0phcW9oeW5HdFpmaWxEZC9hZUZwVzR5RDYrS3ZtazZSMjV5QkZCWkF3?=
 =?utf-8?B?Kzd5Y2YxKzVFNnFtU3d6YXVIZXFFa2xVVFl0THpKbnRqS29NdjJtdy95dysv?=
 =?utf-8?B?SUhlRGY5MDR5T2ZpTEV1U3A4M2ZNaFZCRzllYUpiQWsvenV3TmU5VFR0Zkhv?=
 =?utf-8?B?QVFsS2NETVVaYWpDZlR6ZUI1ellrZE5NdzJOYUVkcGZlb0NDTFhnYUlXQ1E3?=
 =?utf-8?B?V28vTC9TR0xjRklLR2N1VEt4K2FCUXFjMlFtWElISENaTk9OR3B6bXhwYitM?=
 =?utf-8?B?QW9CWmoyWjhON2pla0ExZGZxbERwc2lVMmgxT3JqeWZDdExNZTkwQWVXMzRq?=
 =?utf-8?B?dmVLTUZCZUZkMkRSRzZ1NW9seHA2dnZldG94Y3BabHdBTUcrV1lnN1ZFaXBC?=
 =?utf-8?B?WnlPZERNTHF3b2JEenBPS0ZDem1GSnBuRCt3aGI4V1U4Z2NIbDJqRzRwRkJK?=
 =?utf-8?B?c0VpOWpTalR1UExQU3RrVnJLYk1BRVFXNVVmb2VYbkFxT2JOeFdLRENmSThu?=
 =?utf-8?B?NUlGZ2xvNG0rQnZQY1hFK3k5S1EvbVV5SEUycjMvSEhoRkwvNlpHU0M0MW9O?=
 =?utf-8?B?VHBRNjNjSzlKMWV0cEQrRXF6Zmc5Mm9ZR0J2Q0U1d0d3OStlM0doZzcyVHRa?=
 =?utf-8?B?aDVTMlVlZ2pEN2NMYTBPQVpDYWFVd1h3WXJUblgwQkFJNDh5VFVHdHVRcjM5?=
 =?utf-8?B?eGJHSXZXd1hrUm4xT2hraGdXNi84QzJKdjduN0JEMk9DQmE3eUFRbnkxQUI0?=
 =?utf-8?B?ZTRvM2tyRXFxdWZOSWo4ZndudlU1SThFV25HWnBxYjNGU2xiUGRxV09ZMlE0?=
 =?utf-8?B?bG9kNjJUbmFrdW1jVHdiNktVbFF3bXFSYTZEckZhOWZ6MkxublBHZWdQZE0v?=
 =?utf-8?B?TThuUmE3b2U5Qm5DazNDbXNVNFo3ZXBKWnYwbzRESEgwS1c5dEQvSGtoOWRi?=
 =?utf-8?B?NVlxWmpXYm5WZ1hTMmY4V0dDS1F6YVdzd1BYM1FhcnB3SnpRT3JJQ1lDWnRz?=
 =?utf-8?B?WERwNUdrQStBczhhYm1WYXFCN2hSSG1rTHplNGdOZXJCcDZhRi8wL2FWYWY0?=
 =?utf-8?B?S091eXB5QUQyVktlRzFTL0pRS3d1cVFJUURGcmNBRzZ4dFZnb0lyQzdZZWpw?=
 =?utf-8?B?RGgwREt1TURqWHhNaW1ZUUsxbjdFV0RLYzdxVXBLdmtNKzhHS1FkSzlTVy9l?=
 =?utf-8?B?K0JYb1hrc3RhdTVEZDJscmNYeldIb1RtVjdYUkwwWmZwOGhmTUFML2FmNHBr?=
 =?utf-8?B?NHo2V2tOVis4TlZWbCtaaG8yUjNjWHNFN2tXT3NiSSthb3Z0WFVXV0lIb1A1?=
 =?utf-8?B?cXdncm1jeGdSTXZzRnlJY2hJN1lRV1dVaWlPYVNrRlE3dkxaTDlNb0dVTklz?=
 =?utf-8?B?STJXSTVwSWFTcjBURHBIRnBocE56RUZSK0dhK2FQaDlXT3ljenNpbzRUaFh6?=
 =?utf-8?B?aFcrd2FpMk9wNnNteGlGaHZrWW1GZEV1c3BjaXdFRWVrOGtVZTVOR2NhWG5V?=
 =?utf-8?B?alVxRUYxekFPQUVjWVpaZm1YanFWWVZSR2FoakdOdjFMYk5VN1lWcTZyNCtQ?=
 =?utf-8?B?Z09WWnhpVVJ1QlBzeUd1dlR1aWxwR2NBQnJpREpaWTdibi9SWUFCWnRhQXZq?=
 =?utf-8?B?T21XaDhkV1NRWlIxeG9TY2hhMEVkNE5mRmhpaWdvc1FyQjBJbzRocmpUVG52?=
 =?utf-8?B?L3JqVnlCcUlZNlpQbHJRQVFuY0Q1WmdwWDVzMmZsRUgxTDZVVXA3cG9oeitI?=
 =?utf-8?B?RmZmQjJWWGJqTjd0d042RE1tNGVLTFpaZkVNaEhKZWtzcVM0RTFYYzJwZXJ5?=
 =?utf-8?B?eEZJMWs2UnkzS0s5T0RnWnR3T2pibGZoZW11Y0Z4VXpURDhGM25GSDlja0Jp?=
 =?utf-8?B?YStHOW9lb2ZKVGU4UE0wa25DOUNZemoweEV4Wm9IRzZPL3loNHFTS3ZrQU9X?=
 =?utf-8?B?SjRoL2U5MnJheHcyZ2ZVNVhWams2RkFNeHhnWFFsZU9CVmNJUnF0REJzWElz?=
 =?utf-8?B?Z3RGaVBaQ1NCckx1NHp3WWdCYit5b3Z4Y0R4aUlsTlNIV3hjTXhjM2ttampa?=
 =?utf-8?B?enhOQnoyaUFjbkpUZGl0Q2V0Qk1BWXBWV1IwTk1UMzRSbVJjZzU2Qkx3L3Zw?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04B8872029FC03488E10F2C407F5BDF0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ty5I/IEj0Kj3M/KwLJk+6EjgfdbUwH6PVnmtQ36FCNWTgZMRyIXP+m3pqCfUQVLCWuZYXtwdY0oWR1XotLiyBp2jNy2aZAh1eQoq8xSINjzdt51NlKpNvwnGgoaNY77RdxS/bgWCQSdVRq3BDv1qfrO3/XNvT+NwoSmxc9rRIIEqOUPC7gCeHNBlvirHQU7r5dPbO30P/qAd1edPpKfoDH3GohOmFmvi9wHfV2eGTRbkuSYAnocGMvwQlnLWVyX3XZk39eNRMJqX1zCNb/M+/iD6wYTVxb+HcRo2NcrjmOO6rKArG+Zh4X6d9jH0at0FrvV+QyA/PkC0pcmhP0KQKCBsoBToXDcMb/qj7LWip9HwXNvEIkRCL+Hi+UTfCiaGF3Hdi70qOEou432QMxcDfA1PzmxAYtbSNO2xC8zOeUD3I+ewwxbfvhl4rEkFTMbKEUQKQs8ao3jJPUOsYoV8mWi03kpyOhGwJCbr9iUZsjdsy3Emae8wLPlv82CHstaCOjuX7Ca7AJRcGm6kt5hHdpQKJ9RuF3DzCd39UKj/RErOeo+40XimGeqRUEPloZ3oQ+jzN3P2Pp0RUYJYXU/9DxgUJ1QFGGuzKlmfG5/F/fc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043dbb6b-df5b-40bc-e74b-08dc74e8fc59
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 14:11:59.4473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPZ5OIG9arho+zy+HEzaVOIhBigQVeSIX3hPVA76yIq+c3LUUT1S1gh8uIgixaLl3MDeQgFlcQ7kGjJqRGVd/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=961 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405150099
X-Proofpoint-ORIG-GUID: kh5Lcew95toGppDewzrKGu1eY0xfLPUB
X-Proofpoint-GUID: kh5Lcew95toGppDewzrKGu1eY0xfLPUB

SGkgVGVqdW4sDQoNCg0KPiBPbiAxNCBNYXkgMjAyNCwgYXQgMTg6NDksIFRlanVuIEhlbyA8dGpA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBIZWxsbywNCj4gDQo+IE9uIFR1ZSwgTWF5IDE0LCAy
MDI0IGF0IDAxOjQ4OjI0UE0gKzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4gDQo+IEkgaGF2
ZW4ndCBzZWVuIHRoZSBjb2RlIHlldCwgc28gY2FuJ3QgdGVsbCBmb3Igc3VyZSBidXQgaWYgeW91
J3JlDQo+IGF1dG9tYXRpY2FsbHkgaW5oZXJ0aW5nIHRoZXNlIGZsYWdzIGZyb20gdGhlIHNjaGVk
dWxpbmcgc2l0ZSwgSSBkb24ndCB0aGluaw0KPiB0aGF0J3MgZ29ubmEgd29yay4gTm90ZSB0aGF0
IGdldHRpbmcgYSBkaWZmZXJlbnQsIG1vcmUgcGVybWlzc2l2ZSwNCj4gYWxsb2NhdGlvbiBjb250
ZXh0IGlzIG9uZSBvZiByZWFzb25zIHdoeSBvbmUgbWlnaHQgd2FudCB0byB1c2Ugd29ya3F1ZXVl
cywNCj4gc28gaXQnZCBoYXZlIHRvIGJlIGV4cGxpY2l0IHdoZXRoZXIgaXQncyBpbiB3b3JrcXVl
dWUgb3IgaW4gaXRzIHVzZXJzLg0KDQpJIHdhbnRlZCB0byBob2xkIG9mZiBzZW5kaW5nIHRoZSB2
MiBpZiBpdCBjYW1lIGluIG1vcmUgY29tbWVudHMsIGJ1dCBJIGhhdmUgc2VudCBpdCBub3cuDQoN
Cg0KVGh4cywgSMOla29uDQoNCg==

