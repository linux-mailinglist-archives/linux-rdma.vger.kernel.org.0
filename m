Return-Path: <linux-rdma+bounces-8991-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF1AA72061
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 22:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136F53B9076
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 21:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C70125D8FB;
	Wed, 26 Mar 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HcYSJE3C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GnPDVc3k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376A253337;
	Wed, 26 Mar 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023147; cv=fail; b=J13e1Ac3mEhy6d4SSBVX00plkf1WMX7xuBikA68E2+RO1LC9SjsNm24qHRX6j4D+g2rUBTX0z/PYHRABJTrL5p5DYcd9OiixeuUvcdOINjPMEqxKLW9v+rUeLZuUEiBhyTr+THj0pmFVZymLm75MknGwgwp8p2YVPDCJ4qbKYO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023147; c=relaxed/simple;
	bh=s35wT3dtfPnQnoVUEEhHU0gIkQPxcv4nisb73EPxWJw=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=nObST2+m9c0BfeCXpNDAVhmBphudgoQqfU0HTz6wyKRqycG//76uaYF9hK5AGhK9IwwBvyUzNTAsXOJKaeFdXwvRo//+Krn9xKp6ccx/PqX5FHvXQ9ujX/wFvQZLCB0wpVCWBfQAOY9Gt2M+X38FJmKpTorj03SeN6g5R62n/qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HcYSJE3C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GnPDVc3k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QK0YlU024435;
	Wed, 26 Mar 2025 21:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=rR8JlxxJ5o7jwKPc
	VaVHba53lqJb48LpP4jr3hRrG0w=; b=HcYSJE3CMVVYPtMmgV1WI78C251DNnAf
	1JIKTaQZfCmtS2z5n5v3ACJ9RR3LrDYYo2TwBFtqYheQRq3V6OkejbrsovorCySi
	OkN+6zFNbOBIyGvjGaXim/YOZZQZtNsbZLCv3MnSJS4MWLpXO75JJt7vkzz0OW/f
	1xgB9K3lGDC3/jEejUyNUNvKdljibFUsXt4A7/XcC/Nk1IticA0mYHY44QwLhS6C
	6xFMeS48FzcutiW5AjeQswAePmHxWZAAvT/FmzLbe67yt+AqiTuchluySrVl58D+
	ZF56zHHgPttiV/wmpC1yTj/eKodMD1/ZwutZdsckv9OELQgAA0svRg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn7dtk7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 21:05:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52QJv667008219;
	Wed, 26 Mar 2025 21:05:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6w6dqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 21:05:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWCCOSR6Pcz4zM/1kQFlqkx7XZxTBQ8Ne5BxgvUNXAObjOW+yAwUHSh/Q7yV5KiW16MLSAvvKdc6UJe1zi1IsZttR+ZC9h8Xp+JzisFWUNRsqdgqzauQeSs2roip9aCANc2w/7BWHDcvjByBestIPMIbAQNt+LriYJewz4eTYFnE2SZWNjlTledymXA7+SRx14bUbS8iQnvlBkoPDGBQUv3RnHjCaMYhbWJBVGK+HIY83s6xbznCjMakogQ9UTv50OBeaHWcFmRsyUnTmgeTCcfA5hFAIBv/NBhTsW2xNP/C7ps9sJXAP7OJlY8Hz/km4JKQKnXMvb8EgLqEPhxMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR8JlxxJ5o7jwKPcVaVHba53lqJb48LpP4jr3hRrG0w=;
 b=pDyod2xY+hs2Kn28f+jsp7FoEjkj12GRaXklbxTLK0T5lORU340Vk7Px0O6ZWMSmyZyKnqbZXTRz6C8jQg8bsPdM+y+Q4mC2JeJKCp960d85xl0GyzYgeHEAFN/AyMAtUZ9yOjWXI4vFq29JI7deBOuDH6LIhMQBf3tLltNtLjExIVX17GJhwqdK2zd2PDjbc1d2xlfFG4TMK0OjbBnTRT8auFf1khmXHfGDlLHu3Pc7kUSxmPNME48r4ShQnSA7ePgaJKx3LXhV/cOtgq4EzlRo7wp9T1PLeYQTVWC2QGYMD1KszRbHRuP0wwXQ9ssBmntX7wmnn+50+Q+8w2DIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR8JlxxJ5o7jwKPcVaVHba53lqJb48LpP4jr3hRrG0w=;
 b=GnPDVc3k2e5nhpGmjqNB7fh9l4NPkf153WAunipq5fkOtpSWfxU+KNO5sihKaLQmM3tjyEMVmbdd+unDODjjkVK+ncJ3lwR8M06NBjTvll345jkq2DISha2gUofuWmd9/1sHvXFO34Yywq2DD/YtRo3tJP/srXMIzuDZsWbC7Eg=
Received: from SJ2PR10MB6962.namprd10.prod.outlook.com (2603:10b6:a03:4d1::13)
 by MN6PR10MB7441.namprd10.prod.outlook.com (2603:10b6:208:474::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 21:05:36 +0000
Received: from SJ2PR10MB6962.namprd10.prod.outlook.com
 ([fe80::c588:aef6:a2e5:9ccb]) by SJ2PR10MB6962.namprd10.prod.outlook.com
 ([fe80::c588:aef6:a2e5:9ccb%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 21:05:36 +0000
Message-ID: <bf0082f9-5b25-4593-92c6-d130aa8ba439@oracle.com>
Date: Wed, 26 Mar 2025 14:05:32 -0700
User-Agent: Mozilla Thunderbird
From: Sharath Srinivasan <sharath.srinivasan@oracle.com>
Subject: [PATCH v2] RDMA/cma: Fix workqueue crash in cma_netevent_work_handler
To: leon@kernel.org, jgg@ziepe.ca, phaddad@nvidia.com, markzhang@nvidia.com
Content-Language: en-US
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, haakon.bugge@oracle.com,
        aron.silverton@oracle.com, sharath.srinivasan@oracle.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0073.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::14) To SJ2PR10MB6962.namprd10.prod.outlook.com
 (2603:10b6:a03:4d1::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB6962:EE_|MN6PR10MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 392275b0-a2b6-4d58-96e6-08dd6ca9f4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajdlZFcwZXZUM2FuZTV3YWFzcVo0OWpLS002OVlHbXZmOWN3MWhwK2pOb1Z5?=
 =?utf-8?B?TDhBMGJGc1hxQUFiQ2NjaFhEQlBhcE1oVktuWTBaLzkwaEpOcGdaL3d6SXVB?=
 =?utf-8?B?Qk9tTkZDYjRCekxMVlNROXVpanQyc1h0MVY5K3M3R3dvNTAyUE9YdERJZGRP?=
 =?utf-8?B?dndJV2NsdnhpVkNqQ0o0U2pxRm1tQlJoSUlOUlc2Rmtmd1RqMkpZSFdrMlBP?=
 =?utf-8?B?MlkrQmsyUmR3dExUaitCMXBZa1dRNzczY1pDOGhHS3lhTktnNUQrQkhFaWcx?=
 =?utf-8?B?Wm1zd0JxWVBPSVFQNzlVeVZ4SzRZNFljeE9jWHlRUDdPUTNsN2tvT2t6ekU0?=
 =?utf-8?B?NTFYQ1EwUStrTWJYcnJBei8veTR5UkxFRnV4Z2YxMHlCbEYvUGZwekNUNDcx?=
 =?utf-8?B?RDdQSm55dmpvNTFmOUZVYUkyTTVsOUZyemhoM1ZLTHRJdFAzdUd0UGd4K041?=
 =?utf-8?B?S245UUFTRCtoRWRjZUdPQmFxRFR0aEg5SUFHLzB4eHIrZXNwNVArY01xclRh?=
 =?utf-8?B?Mk45bmUzaFp2R2VkYUwwQm1LaVRxNGZWOXlRZUxLS3grOG1sbEM3c2IvK2Rm?=
 =?utf-8?B?a3dYV0REREttczh1L1FTVTFCOVFxKzlSUjdMb3NkakwrTWVveUxxVmhtVDJV?=
 =?utf-8?B?ZmgzcndDbE1ncm5kTGJ4VDV3U0NuTlIxaTcwbW02S3RCRG81L0thSEtlYVFi?=
 =?utf-8?B?Zkg1cGFhTmtmdXBVVmVtZTVNaWkyUndqb1NzbWFLNmt0V0NVTklWOFZmeEN0?=
 =?utf-8?B?aHRvVFQyU1FRbUdSSTdDTU1SU3JSQ3hCU2FEQ2VkVkFKZDExMCtRQzE5cGdY?=
 =?utf-8?B?OFc1Y2RabGI3SFlPSXk1OFFpaXFNUDBReDBZRFJqK1FQVWJ2eGt4VTJYMzhy?=
 =?utf-8?B?ZFRJNHlvaWNRbWxpS3hOSmJ4RnY5TktZWlh5WklwR1IvYzdjeTIyTEk1b0Fr?=
 =?utf-8?B?MjBjMVdZeUpiYnJ4VnZHNWpHMWI4bjEveEFEdVVkaFU4K2szM0lKNkVMS1p6?=
 =?utf-8?B?emhLa3N0RWpwR3MxOFBSS0EvZ2liWnJFSnJ4dHF6ODA3MWFqU01qLzBrTkU4?=
 =?utf-8?B?Y3VSSXlJdWRvcWkxQi9NVzg1c0NuTFl1eVBUKy82aEpFSzMwV0lBVzhubmxH?=
 =?utf-8?B?bXAwWnhKclkyUmpwa1N6a2hWRDY0VUtsQmh1UG9ENXkxbTAyZVV0bU4vUURJ?=
 =?utf-8?B?NTFrS1lPdkFic3FsSGRYODZyRXJJSCtVL21hKzNySzFuYitUaFpadHpXNHZm?=
 =?utf-8?B?ZFc4aGs2U0FUYzM0aUh1TjRxTy8zK1RFNmIvWGxHUE5pbmptN2VCdURWWEFy?=
 =?utf-8?B?b3JWYjZUOFhjZmFidXRvaHpMK1VmL0ZRY0lEVTdYZTVJdUFKdHJRVEpNTU82?=
 =?utf-8?B?Q2srK3ZCYlp0Z1VLK1gzYkRHOE5WYzZGVzIzZlRxeVNPOGxhdGxZZ1RqMkM5?=
 =?utf-8?B?MCtHREx4MjkwLzA5SGtHM2RzMGF0VURWc1JNNEY2SjNhQ3BJcloxM0NOSTc3?=
 =?utf-8?B?MmhDNnBMRW1TKzhLZXNKWTdCRXJQUnR1YkNJQ1hXQXU4R3cwekFqQ0FDMlhC?=
 =?utf-8?B?RlZnT2ZhMDI5dk0zUFB5RGJRMk1UNnJJckFrZnRCbzQ2cEdhOG9nVDliTzA4?=
 =?utf-8?B?dnJsV1ZDOEgvUUR1bVREdzhjNk51TDV6QkpEQlZhSlpzcTc2d0ZYaG9aMTRL?=
 =?utf-8?B?UDhYQ0ExOWVmTDc1elQzdWtyeTJzRWtiL1RzcVF1OTBHZ0ErUFdaOC9memp1?=
 =?utf-8?B?UzFvVFB1d08xNEVzSUFjemlCWW9CSHhrY3JNYURtWDNGTTVneVZlYkw1OGEr?=
 =?utf-8?B?VTdWUnZzRkZkcmZPaXlibHlaOUZObS90VzBNRENYNk9RcmtWUDV1bFJyTUJJ?=
 =?utf-8?Q?AY1Ep0QbLenHY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB6962.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUp1ZHp1RGV1NlhydytBSk9xdXNvM3BlUHd3NmRvcko0Y1oxSzRqaG11UEl3?=
 =?utf-8?B?YlJla01CN3RwMnY4UnI2TU5YYnorMEswcDJ3R3lkeEwxcHJNRjFXZmFEd2pS?=
 =?utf-8?B?OEJJU1lWRUlqN3A3Vjk2UzYwWnFGYm02ZDN4Y2M4czRic1JxRlR1ZWE5eVRL?=
 =?utf-8?B?djNRVnFRNzZOcFA1eTN2TGVyNTMzY3BqR2lLOXJBNk5IVC9WeEFCRVY1YlRI?=
 =?utf-8?B?bW5OcDhlRWNISzNOOFo4WjE0M3Q5aDZTamNVaFhySFYwMEVTaVBCWGt2K0Fy?=
 =?utf-8?B?MkFjS0hObDFKVDNBSGI1UFJrdWdOclFLbzdYV3lPc1ByRzlHVXZqNWNhaUFT?=
 =?utf-8?B?cURzdU1xdVdvbHkvVWVUT1A0YnB0cEx3WUZRMkpxNmFpQ2NmTVVXZlFqNk5y?=
 =?utf-8?B?WkorY2hRUFdpQ2Fxcm53bk5TOU5TbXNic2pibmJ5Z0JMZ25JZzJOZkFvdWdt?=
 =?utf-8?B?cUxsK2ozMXB5OTAxaDdUR2JQcmszODRPTTFXRmRLWXRqQmk5MVdKYlB5eUlp?=
 =?utf-8?B?NTZqSS9QdkUxRVY2eDhBVm1QY0xoUkZIOFBQcTQ2SGRGbVpZeGxHMms3Y1ZF?=
 =?utf-8?B?UjNRUWZYVmVvbFR1R29PQy9jZXlOd2hZU3R5dUh5SHVpQVZYakNJTEZScnNU?=
 =?utf-8?B?OWZRTVNSWjhiS252N2RISFQyVTNRdHJIZldjQWNSTjhxTk1pNzQ0QnZPcHl5?=
 =?utf-8?B?UUVkN084R2FlOTRvbDZ0cEhyN2x0T3M5eHZtV0Z0N3drVVliNVcxaXJLTE53?=
 =?utf-8?B?MkV5cGpGUVNyWVdSSE5mQkpDNnhqNm1hRXhTN1R4U3E0anZjTTUyV1dLUkxT?=
 =?utf-8?B?QU9mOTFXOGJkcDZ5WTYwSjltUjdxeG9VSVFTUktNemFzTTZmUng4b09RUmtk?=
 =?utf-8?B?SEN4YlYrK2kvanFiWEROSGVYVjN5TXRDRnRwSDR1ck9lVll3WGpmWGFmRnZF?=
 =?utf-8?B?Ny8zcnNXK0JQeDVabnZSR2lZdmQzNnpTSi9TbnZtc0JhSGE3dG8yZnlsY2Jv?=
 =?utf-8?B?R3UrRXpyNnc2clN2eE9FSDdYeUVmSDNhRWxkNXdJbEN4NUZ1OWw3Wk4zNTMv?=
 =?utf-8?B?VGw5bkNGRTJFR3Z1cVh0VkhOYTlZRXg5SXk1d2hYeW5jRitvUmNaVWhrbFdS?=
 =?utf-8?B?M2U4bUNOazdLVGVVYXAxaGVtWml3YzBTWks3TE1Yd1R1NEtKQ09FWHJjS1Bq?=
 =?utf-8?B?TEdGdTR1VE1jeU1PcWUrNHVDT2xYQXRGY1E2UUNwem5OKy8zQmtnQ1ZlNk9l?=
 =?utf-8?B?dTVoMTVnTXNhekIzTmJFRDNENUpMNnZSTkhkczVaSWNxaUNpd1lwZURLNyt2?=
 =?utf-8?B?RlgzUVpCemhFanZXR1ZGaDlST1VEVmZ2TE9CWkpxQlVZTXpML3BDbGF2Vld1?=
 =?utf-8?B?bTBGanRXcVU1b1o1bGZubzNQZ2Uya2pZK05tUDl6MDFDRUFrQ1dIa0xNVFhB?=
 =?utf-8?B?ZHp6VkltWUEyR1RwcHFNbFE2cWFzcjFoakM2OTdWMjNvQWhSV1loazErL04z?=
 =?utf-8?B?TU5NcTVtOXB4WHVTU1RpZDQ0d3ZuakpDdElHOEE5eU5KOTFkZDJ4T2dpRU81?=
 =?utf-8?B?RjhzTmJpZzZIMXlQWEtHTWcxem9nbnJWa01nTTVkQjRXYysrMkhoSUc0Tm83?=
 =?utf-8?B?Q0haWHpVZWQxY2s3aWxaZXRIbWZHSWw5MCtDL1d5Q001bGtnL0hlWHVFdDBL?=
 =?utf-8?B?SXUyN1hZakVPblFqbzFkTE5uUG03Sy90eFBvM3g3SWptQ3JyZGVkV25GSHR6?=
 =?utf-8?B?Y3RYMXFIY0l0dlR3RVh3RXpDc1RGbUFKOVJsZmpMRFBWZjJGUnQ1TnNWdlJP?=
 =?utf-8?B?YTVGaGtUM1ZpcHJmVXZFSS9qRkJYRXFsREFOSDVyQnRmQjRkRFNoOER5S29z?=
 =?utf-8?B?UTB5RlRYRmFzb2J1NFBhdHFLTzlBMXNVRjQ5WklVSWVnWnJIelFiVDJhQkxV?=
 =?utf-8?B?Nndzc01obUNIaGdJWWJNdGZGSXZYN3Z6ODNrc2c5bkpIRzBZMG45RkQ5dllF?=
 =?utf-8?B?U2JxTFZJY1Zzcmd5MU5vSjFEYm9vMWZ2cWV4VElnZmRjR0J4Z2F5WWE5eFgw?=
 =?utf-8?B?V1dDTmFvUTZYWm5weEtFdk95dDBSVGQwS0RiOVl6NS9ldFd0SGxTWG1TVkZS?=
 =?utf-8?B?TVBCb0VndE5UNFZlUDFGOXBUZHAxSXdZODFRUkYvZE10RlUrV09Pc3c0bXJq?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JiuOWt4+wUgYnhXc4nXe06ksXPuHbZ+Xp0oapldJ8TkanbSRpgF0GmGzo4pa6qBe45s9+Hv4Sj1ZQJSPqpP4LmDusvOL0dk2LspWwOWmPkEoBkCVXqXq/jGeFx2IsWqjtJXMv9rvlnm/OYnGq63o+9W1QR6Es6EJeK/fE9TldYk/eR75JBMUcf9pcwjZFigE9ZdCYHKC+vNrGJDoyuUX+MCjlN+0+lzkFnh2biu34Uwzhp+G7NR8tsmxYQGXwHrX0HbVgEPMG3Rsy+D+YF+wl8bQ4AUPTemsPJMLApokLAcWxwfSrbPCkJyoGuvziMFnl7jVNMyH/EZ1eGUuSjfIP3Od6ni0IdDPqqvUa+r0CtDY5z9dbeLjpmSDKPwu2BaGXvpfsz7OZrE+1cp6zOCOwAgPjFrvVRgwJ6+qh57/GvvdX7fug/dD317PJsnLr3SZco/01iz71+1AzW3xQRJ6l/miyjpaxNIeLtSv5TjPD3rVSNTr2Y/QqtCw2dBHHxSA9ZtBmBTYzbkalj5PfppckBoXhgF4NdzQRQntXNY1WAqOsCAr3o/0vuP6TXgNV8zHgdCdWMe1YjTL6NLLz2cWavDZW/Pu+HRUHMAUgxuzGpA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392275b0-a2b6-4d58-96e6-08dd6ca9f4ae
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB6962.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 21:05:36.7967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6lnV+unJ1ex7gwo/FR87OwUnekj8TJuHIavaKH8J101stJE3K4bw8GPozwFK3k2Pl2WqIarkwq+AMtn7DBZA0m8L8xLs782f7veksNfnTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7441
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260129
X-Proofpoint-GUID: KPNdSYA_nC3c6C_T9rbuEOb7SPXZPnHk
X-Proofpoint-ORIG-GUID: KPNdSYA_nC3c6C_T9rbuEOb7SPXZPnHk

struct rdma_cm_id has member "struct work_struct net_work"
that is reused for enqueuing cma_netevent_work_handler()s
onto cma_wq.

Below crash[1] can occur if more than one call to
cma_netevent_callback() occurs in quick succession,
which further enqueues cma_netevent_work_handler()s for the
same rdma_cm_id, overwriting any previously queued work-item(s)
that was just scheduled to run i.e. there is no guarantee
the queued work item may run between two successive calls
to cma_netevent_callback() and the 2nd INIT_WORK would overwrite
the 1st work item (for the same rdma_cm_id), despite grabbing
id_table_lock during enqueue.

Also drgn analysis [2] indicates the work item was likely overwritten.

Fix this by moving the INIT_WORK() to __rdma_create_id(),
so that it doesn't race with any existing queue_work() or
its worker thread.

[1] Trimmed crash stack:
=============================================
BUG: kernel NULL pointer dereference, address: 0000000000000008
kworker/u256:6 ... 6.12.0-0...
Workqueue:  cma_netevent_work_handler [rdma_cm] (rdma_cm)
RIP: 0010:process_one_work+0xba/0x31a
Call Trace:
 worker_thread+0x266/0x3a0
 kthread+0xcf/0x100
 ret_from_fork+0x31/0x50
 ret_from_fork_asm+0x1a/0x30
=============================================

[2] drgn crash analysis:

>>> trace = prog.crashed_thread().stack_trace()
>>> trace
(0)  crash_setup_regs (./arch/x86/include/asm/kexec.h:111:15)
(1)  __crash_kexec (kernel/crash_core.c:122:4)
(2)  panic (kernel/panic.c:399:3)
(3)  oops_end (arch/x86/kernel/dumpstack.c:382:3)
...
(8)  process_one_work (kernel/workqueue.c:3168:2)
(9)  process_scheduled_works (kernel/workqueue.c:3310:3)
(10) worker_thread (kernel/workqueue.c:3391:4)
(11) kthread (kernel/kthread.c:389:9)

Line workqueue.c:3168 for this kernel version is in process_one_work():
3168	strscpy(worker->desc, pwq->wq->name, WORKER_DESC_LEN);

>>> trace[8]["work"]
*(struct work_struct *)0xffff92577d0a21d8 = {
	.data = (atomic_long_t){
		.counter = (s64)536870912,    <=== Note
	},
	.entry = (struct list_head){
		.next = (struct list_head *)0xffff924d075924c0,
		.prev = (struct list_head *)0xffff924d075924c0,
	},
	.func = (work_func_t)cma_netevent_work_handler+0x0 = 0xffffffffc2cec280,
}

Suspicion is that pwq is NULL:
>>> trace[8]["pwq"]
(struct pool_workqueue *)<absent>

In process_one_work(), pwq is assigned from:
struct pool_workqueue *pwq = get_work_pwq(work);

and get_work_pwq() is:
static struct pool_workqueue *get_work_pwq(struct work_struct *work)
{
 	unsigned long data = atomic_long_read(&work->data);

 	if (data & WORK_STRUCT_PWQ)
 		return work_struct_pwq(data);
 	else
 		return NULL;
}

WORK_STRUCT_PWQ is 0x4:
>>> print(repr(prog['WORK_STRUCT_PWQ']))
Object(prog, 'enum work_flags', value=4)

But work->data is 536870912 which is 0x20000000.
So, get_work_pwq() returns NULL and we crash in process_one_work():
3168	strscpy(worker->desc, pwq->wq->name, WORKER_DESC_LEN);
=============================================

Fixes: 925d046e7e52 ("RDMA/core: Add a netevent notifier to cma")
Cc: stable@vger.kernel.org
Co-developed-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Sharath Srinivasan <sharath.srinivasan@oracle.com>
---
v1->v2 cc:stable@vger.kernel.org
---
 drivers/infiniband/core/cma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 91db10515d74..176d0b3e4488 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -72,6 +72,8 @@ static const char * const cma_events[] = {
 static void cma_iboe_set_mgid(struct sockaddr *addr, union ib_gid *mgid,
 			      enum ib_gid_type gid_type);
 
+static void cma_netevent_work_handler(struct work_struct *_work);
+
 const char *__attribute_const__ rdma_event_msg(enum rdma_cm_event_type event)
 {
 	size_t index = event;
@@ -1033,6 +1035,7 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
 	get_random_bytes(&id_priv->seq_num, sizeof id_priv->seq_num);
 	id_priv->id.route.addr.dev_addr.net = get_net(net);
 	id_priv->seq_num &= 0x00ffffff;
+	INIT_WORK(&id_priv->id.net_work, cma_netevent_work_handler);
 
 	rdma_restrack_new(&id_priv->res, RDMA_RESTRACK_CM_ID);
 	if (parent)
@@ -5227,7 +5230,6 @@ static int cma_netevent_callback(struct notifier_block *self,
 		if (!memcmp(current_id->id.route.addr.dev_addr.dst_dev_addr,
 			   neigh->ha, ETH_ALEN))
 			continue;
-		INIT_WORK(&current_id->id.net_work, cma_netevent_work_handler);
 		cma_id_get(current_id);
 		queue_work(cma_wq, &current_id->id.net_work);
 	}
-- 
2.39.5 (Apple Git-154)


