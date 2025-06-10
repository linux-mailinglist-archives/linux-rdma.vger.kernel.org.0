Return-Path: <linux-rdma+bounces-11171-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BB2AD440A
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 22:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595707A610D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9ED265CD0;
	Tue, 10 Jun 2025 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="agE4F5PK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GBD+dfFm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE5B23506D;
	Tue, 10 Jun 2025 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749588120; cv=fail; b=fgIgQWNbouAIcJK8XSjW04hLGh0LJpUvSYAXQh4ET6PiSTYobAdI1hXHm6JKYyAdT/rm1J5w2MciV14WWZl3WPHCJn1AK76yujzxdm8+vXiEYFrGL0/MJF8sUfD7KmlYn9ER3CRwYz8NBxDzoFf8L39pfhEM3dfLLuXHRt/tpjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749588120; c=relaxed/simple;
	bh=wrWRJeIO1vrJyX9hR802vNBFFwAgYodQePeYQswgHj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HvS6/rduzPNUIZ+p+loyE6U5Y0M1nQmyOl0R1+cv94rvrSzpKixhWvF3/kgus1WZpX+bb0AapQTJj1LJ2yOgBQr6p7oP0Gi8zdJfutCcBKogBsNPL2z2GFqSUNbvwr7OBbTWAafwD6VGx38GP0X/CzfnS8/fsV0JmbzERB7r9og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=agE4F5PK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GBD+dfFm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AK6gT0015443;
	Tue, 10 Jun 2025 20:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=iy1q8+SK9wJVQlP0AF
	fYE+xI/1y9Pc0ExZ0rWplYR/c=; b=agE4F5PK4lkzGuQI1pwag7P9d/q6IS4jpb
	NyoEfclPSbqAIrKMBXxoegE9/uWI9ZfpXziTtyd/xhMfKx5QX93rnl2RwaxVSTKF
	Otc1hvtp9Kk9qJLucYvN3qCZjL28zw4ooJa8wddEf7qh4Sm6h9VD6ZD1a4MAnds3
	io85Sb+rGK+v6U81rhhFi+Ud0lSVrWsC/R6RZGoJBoCm89K+oT22Ywb9uiqYPxeV
	7ZkwYR6D8xcXOIb7dpFrVoICLtSgyJvGAj1eeqSqkvV/YMZU/5pj5aVFoMZGM1WV
	xO+2GiL/A6eiL/Hh8uRKE0DgSuMANoYHC0qokacPkrXDxz7dM/Xg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xjvexr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 20:41:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIskQG007593;
	Tue, 10 Jun 2025 20:41:54 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv90jj2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 20:41:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmYoB+x9Xgf/3g48u7+uFWFBCBge5zzJm6bsu35bcRwmL6qhnXt71FkOgSs/X39m/w25C0r3wB5uG2L1MdgSzPmdmlIDVBH+Y/Vw4kbrPWhjFK3cVVWXqVZlrtJfOV29DhmpZuHsfBdyLWa5q0gmXWdUJotUCg0g6inlkoSEmmK4NYIOHv7R9RM49pDGwDxMeQ6T81s5WCBNiU+vwbXV0iaMSeoU0/vQuyE2ROyZpzwYugheLj/bbCtnNt0T4MV/Rkjn8AF2z00bThswdbvGg4MBjckUS9g1F9fSLFyima8PbVbFMFLV0zPPKAt4QrMokqQ2vah6h/ey1wlMIyVXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iy1q8+SK9wJVQlP0AFfYE+xI/1y9Pc0ExZ0rWplYR/c=;
 b=QlDtyWOWivBgqrb0I0hp5zKrdlUkR5Ss9Monu/yoJ7Fxo/I1o+k88mFNC7JQYINllaVR3OjcUKijNYhFxlk5pBbgF3gWSjxl0QKNTrMdnmJ0JjgDv5MpmdWGKA/CciM4jLDdQhj+OmPXui6ehtD/3/rTVAaRrxCgWlADmMSFTHPBKW+gfUUbSJEFO0yDZRS2V6hUVrDVwT3VcJe8Mgz1bHD8MGFwonjzNPfzlWxpwZqkzOzIN90odir08u1ttJJAzPeVsq/M9XdgVzCeyzVufbE6mzVJNqk/4lldqczP/y7Ch936ZjHhC/F15dSx1Bk1gQU/44BwVJ87rHxItPZOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iy1q8+SK9wJVQlP0AFfYE+xI/1y9Pc0ExZ0rWplYR/c=;
 b=GBD+dfFmPI7lKLtgJb2dton4aDVL9lZG1xu8hLYfAJQdtcFP9Yk0+Qdb+1RQvEWtdTkYhj9skz8/Ncdjv25sMnr/gRH42AGvopVlm7Fdt0mrugOi0L3HQ6pOif+xahKMxMBq0g2SYLdiVf67J3GEj3PPa5iOdXemJ0Ho0G8puq4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB5947.namprd10.prod.outlook.com (2603:10b6:208:3d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 20:41:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 20:41:50 +0000
Date: Tue, 10 Jun 2025 16:41:31 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [PATCH RFC v1] rds: Expose feature parameters via sysfs and ELF
 note
Message-ID: <aEiYNk7JjdOnK-5M@char.us.oracle.com>
References: <20250610191144.422161-1-konrad.wilk@oracle.com>
 <20250610191144.422161-2-konrad.wilk@oracle.com>
 <4531f0f8-db0e-4a94-82a3-f1f8fccea865@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4531f0f8-db0e-4a94-82a3-f1f8fccea865@lunn.ch>
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5cbbc6-224e-4b52-eec3-08dda85f39f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+w21+/mxQTHMt3utYmpxQ80oYTQi7c/npfjItkDJj8A4w7IzyO0BUIwPDosE?=
 =?us-ascii?Q?3T/TdLIzYRLiHk9l19wu0zXdMLlvVBsPiwdZa6867AgywfFGfVvNipRH0yLm?=
 =?us-ascii?Q?1gG11wvgg1ioJKGGNHFp+N7gY7RB+lC02So91Zov7MEe6so+/Fx06/Er6maw?=
 =?us-ascii?Q?AycoKl/dYK+Bm4Tpg6vEMxxw+yMfJzfXdiab4kNQkJWj7dPykIpb3nm6P8xl?=
 =?us-ascii?Q?TDj9qYGyTGkZPRfveOEK3UZkLCYLESlnELn7uHisGBTOvvq4IgLYQnQIa/D9?=
 =?us-ascii?Q?I3iRGdMemOTx9JIpyeCn70a0fe52x/dmDM7k5jKW3vYhupdXgYZ9z6qnhoTc?=
 =?us-ascii?Q?H2M5MElVRd+ZoSThrqIB++XljwzP9PDeFOFdoaGx0yxzc8aKAFJiWa/M6zzD?=
 =?us-ascii?Q?hlN0KcZTlvtMHDRLKJvIwBbKjdr0PLfJtasll4MzRluL31HIr7iJTQrCUZQE?=
 =?us-ascii?Q?MZa80iTISO/4HyvesU3n/DTd8E5LdFB5IyddoZ6KB8rFYFWF51FRn4+kUxPt?=
 =?us-ascii?Q?h0RpQDq/BRFk1+nPc8gtodgdvaiyL/6DA8rZW8O8+f80bckKmEvn1WtXi/85?=
 =?us-ascii?Q?bf4mHYayRWLmTMa8AL8LgNaQ+R8H49Cku6BWDfJIL9Tkzn62ItYIq0RvsWWG?=
 =?us-ascii?Q?r9u2CNncELsx49QDoDXxSmAE5ScSw3JYhvLWD+kLcckbFjmN6omuUf+rpqq8?=
 =?us-ascii?Q?ffN583ZH5CSaohEjqVCJQN2Ia+TGZ/1Uflj0Cf51miRoSHhFGMyxlVAl66DZ?=
 =?us-ascii?Q?k8XZAfFi5gj+D3EhC9wDEggX5UrOTmYd/GfPfZS13XKFd5NJzJeN0HKmD4DM?=
 =?us-ascii?Q?ls5HLxNOkTNNSEfq2ZvqJ7Oad699TG0Bu3nt5daf7YMEgj3FvWgXdjmrfrUf?=
 =?us-ascii?Q?eTSGzi0G5shcu9wqxXyhYjyLeXk5QUKPJoURPBNEcOcfmZx50eQI6o+7pC01?=
 =?us-ascii?Q?PgNT7hMkNrKJdDeknum3EaWkyV6uMC2mwscgpNiFj4ppIEz5mBtGNfXVQHX0?=
 =?us-ascii?Q?G4XJXYlJXlMRmNYOUIAfJ2VqNZwr4qIQxTLZ/i4FprWMjkbIwf4DVxpAMOIJ?=
 =?us-ascii?Q?o6nT9uTN21cNW4/Fu2PNkPaD98yAkFOFCs2Jd1TmP+MccCcvr10OGEYDxAHd?=
 =?us-ascii?Q?09AoYlG8NTbQZHWf9/89V0mVmOXBwkwqlN2bpO5dXv3powmuIGrb9gOSCwEX?=
 =?us-ascii?Q?DQ7hTKsj/peOYgAue22Rn1qjvbmIaMCPyS0oNn+xjGo00jm5d7O8UT2mKL3b?=
 =?us-ascii?Q?4+goPeka1sOAQsfiOwcjH5FbFGCCP351Uw/ZXfIMUlSWNJ/xiOXJYnmlOnUq?=
 =?us-ascii?Q?CR6D9EMaV8Qm5/p3WfczXjmrZ9pgHFbmhuS5W845GKYWIVoXgnawzQz0XNyU?=
 =?us-ascii?Q?1+m1MbmBnnV/qH2+tlWFqFueJbEmAX/rbPv49DXbDy7hHP/22BxTHFE5kKK2?=
 =?us-ascii?Q?UCOj46tddj0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kui8wsEJF39d/y7eCIWsd1u4WEwyC89ksjbDB3RemOpzfKwwwwB1R6touf2I?=
 =?us-ascii?Q?eEXmcEeTgVOByniFDpielh9806JZtCmGjRqOl76qcTc9yJhzlgAA4qVm0Wxj?=
 =?us-ascii?Q?uYia9N9iC56vOntz9/hVS45tqyR3e9sI7Ma6ePtUWsZVYKvs+5NkICTOXyYo?=
 =?us-ascii?Q?xqflPBOtVrFrbeYzIsJsbT+1JQZCWC0nwir0HW+6ZJQeKcEFKMZjbLOWrsvb?=
 =?us-ascii?Q?ey96J+IxxniR4slALW/0GwRrbqHp2KrXkL+Vigm8UBH9F4xiOfFRYmFUsxOK?=
 =?us-ascii?Q?DE6iVkK2JRWJUKGECoeBrIdFoyPwIyyze5WS+siHe1fV7RmOSwJxhkSHluqb?=
 =?us-ascii?Q?hZVb1a/v+4lL7Pq7xx1yjPvRTR4fn2WdInwpjtHkMXDa16Bhyh6f0svsHVYu?=
 =?us-ascii?Q?CRvkclmfX/nyCa6O3uBWsSc/bTRFRiyBhov2k5K4DiR1/d/JV9lxj7eVvO5J?=
 =?us-ascii?Q?NqaJ44sdjf6FfvX509jJx+RQd3c/FhiOZtE4slxRo8sjoSp9n5sVZQ+jk0am?=
 =?us-ascii?Q?1GBlTHGot9GORFvzwZSz3FlkLUgfL1x/QhXBvDD7xqgiCcUrO1BCY90lVcXp?=
 =?us-ascii?Q?yvHVbb1Xr3uZOczOsqqfuK3DmRivSDOhACm7ktaoRLvXb/MozU8QZL5RzcW5?=
 =?us-ascii?Q?ekP/B5vLy9zo5LK0shpv0QPDDYBYA4kx+AlFqOEgqVdGl6ZmqUV35ADzmFA/?=
 =?us-ascii?Q?ftIs9VcQJUsd2uO62RdEiqse7fuLztRB4hX1ADNnmCkaepZgrS+YBvB/OP0B?=
 =?us-ascii?Q?RHsBrrLvR0IIib7aDKxjuIeSzPsQ2sMGms6/pvybIAMYu3r0Pdh/B98rfkYo?=
 =?us-ascii?Q?tvRCt85+uM7fqeR4NK5Szqw5yWL3uPUVJq0ggkuHneGU1c9xvAeItyhQIl23?=
 =?us-ascii?Q?YGflDOmytfMkFuLbBMlSbnaD6j1+3q17v7TmNnDd/CjfqvO1wu2arfkS1W0Y?=
 =?us-ascii?Q?OFIpR2yyrGvcKl3MKBlrivDB2gz3DUKdtM7c3/H8MZ83HBsow4+bluoI0sw4?=
 =?us-ascii?Q?g2fGFeHz6y+NEUsQGe4PUKqlEseYCQ1pIjVkpHZXRPrrynOMXTnlFgS44+Ti?=
 =?us-ascii?Q?orClUUt7uH2ojTIESbhECeL1Yu3jGRECN1tcRLR6HxR7dYy71UaCAWw/ikYN?=
 =?us-ascii?Q?xkHdm9rMRtfB13S1sJh9QaHOIkTIgZsI976+lnQ4yXHueVnkPlTJ7wLxFCDi?=
 =?us-ascii?Q?q+Nj1XI7ow/7ULUdPIKur53O5j3elYCM1g11xQherr+Zi116CVqwfyUhPzl0?=
 =?us-ascii?Q?hG30XggR7SKWWOz9rguHh1Va/bq1uvmxAHMdZbE5wL3JUVrg1k2/Iy+n+0WJ?=
 =?us-ascii?Q?SYHZe5ZXZcXBbNHaF1O9LqOJ3aE10Ag2dHDMO+oVwQDt+jhBpQo2zFsW+dF1?=
 =?us-ascii?Q?O2duxlgPAnWtt40IpHYuIYUgxhjgEe8f3yGsgVOxupmbUrMRVeH8YUfU/UgG?=
 =?us-ascii?Q?XgzkyY8sKxmvNwUDqDxQW0r+PRGfCed8FybHUETAIoildC7ep73lhMtlDtor?=
 =?us-ascii?Q?W4offVCV/WY7OpEixPUDd/dOTjh95luZK+MhnhCdQKWNUcyjcS5DEdddhx34?=
 =?us-ascii?Q?6g9pMC4fVEm5tO2FYGRBfTP5UsP+n9ieGQeW8WjDTmBaNgMa568A7ZQqEIJC?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dKVu+q2R3oW+YPFY1ZZUnlvQyK8aH+Q3bqfx9yOUCbSvbkn1qp2O0gt0aRjjK+Sbk36mBqhYr0KcPPO4bsAHQfbbIEFRjkc9L5f53UeP36rL0Z+8ZBM9+201d4HB9ky95bDQRhPZt2w+mDCMtvr9cr8L5H2PuVTi0sM8v/RdT2m+/FyiX8ekdOaiDTTLUqN4CFgfT8mcl4H/MBZ6Arb+DvMd1FPTNwboCX+HQsgLNZtUAhvFH0oaruq4ZbV0DG7s9Fn0Nz4W5N51uJ05wqovGJeJkhsFteBqZX8B49gcKWnWT209B4BBr5dd3bGGsLa0fmDUBHuTj8LFjFSBWobWiSg1rNPc71beRRmEcYkW7Qfv34LT4W7H9xCuDcXB29lu5CQb/Qy7UhBEWOwaGFpVXNDAZUeOlzQTUQfWYARi5R26iDe4OHFfidnVkOpUplmoYcNyeG9PFqjoRdGxk214lNE/3+0UhRtorU5qfbIbAcrvyo5vunWtYb4eF2FkfRwm4qU0kRD1AwYTPXJ3lR/Ribp5j5dn26IYwT/f4D0C/Ek+o+F1b5bCGjp1vo27KicmHehpkz0pymDly5oJVGd5flkkCIQp+MBXU8Yt7vwnCok=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5cbbc6-224e-4b52-eec3-08dda85f39f3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 20:41:50.5806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHAq5AqV5CfdxFQ//EybNXG1sR6ShmK2HGCyRyZRcEszrURR5xur0ZwmZ9qDXameEZbmgfr2GDP1UDvfLxAqZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506100168
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=68489893 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Ka2GAwTlAmM56ESRa94A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE2OCBTYWx0ZWRfX6fVNT4SJK4Kz 5QiUUJCU8Q779hZ/AUYIi5i9bGmtOU3S30cXDedc5d/R7xVYNl3sKVRAcb+c4x/mmyfHy5x8dUb qegCjLvGTckGmaQK26HPXRsBC7iexgB7m61efSorrwcIt/hPGOH3f19FM+9Cc5Oa4ve56Fw4ONH
 T1RaVCnBf518mJ4Rkhls54+G+6L3tcqdXdzVRmWSzPNlog9RpE0fNvhVMPWYS9y5xUXWCmwpLef Ebb67LuStSZOhGdvGjrtddbwvLunL6YRisRUmfv76UU1Fy9iXgys9MQqYDlKv78S5Q4aeFzu0LK p3UR7r7oe9E6q8GOzmez/9mh3ZRs/6iX48vGzLfSqHGaH+tH/9kZtvlVu/UnEoD9XVRhxODVUpI
 tFnzhpErJFnaNOjWQ1rI87/f3cEXqo8kQfzoMBdlpw13gaY34tK384BL6pKMMZjw9qYCLfWr
X-Proofpoint-ORIG-GUID: D-Zyo21A5QqW2e7YGpE_z6OnY_byaQjw
X-Proofpoint-GUID: D-Zyo21A5QqW2e7YGpE_z6OnY_byaQjw

On Tue, Jun 10, 2025 at 10:30:27PM +0200, Andrew Lunn wrote:
> > +What:		/sys/module/rds/parameters/rds_ioctl_set_tos
> > +Date:		Jun 2025
> > +Contact:	rds-devel@oss.oracle.com
> > +Description:
> > +		The RDS driver supports the mechanism to set on a socket
> > +		the Quality of Service.
> > +
> > +		The returned value is the socket ioctl number and this is read-only.
> 
> From this, can i imply that the IOCTL number has changed sometime in
> the past? That would be an ABI break, which is not good.

Not that I am aware of. But this is more of putting all of the different
exposed ABIs that exist in the driver instead of listing specific ones.

> 
> More likely, none of the IOCTL numbers have changed. All you need to
> know is if the file exists or not. So i would makes the files the same

Right..
> as /dev/null.

Not sure I follow. Make them the same a /dev/null? Meaning link them to
/dev/null when the module is loaded?
> 
> Also, these are not actually parameters to the module, so putting them
> in parameters seems confusing at best.

Right, that is the one part I was not sure about - another approach was
to create a new sysfs tree. But it would be more code as we have to
register all of that during initialization, while the module_param does it
very nicely.

> 
> I doubt this is the first time this problem has been addressed in the
> kernel. Maybe look at:
> 
> $ find /sys -name "*features*"
> /sys/kernel/security/apparmor/features
> /sys/kernel/cgroup/features
> 
> and see if you can copy/paste ideas/code from there. And also ask them
> if this was a good idea, or they say not don't do that, it was a bad
> idea, just call the IOCTL and test for ENOIOCTLCMD.

Good thinking - let me dig in that and also CC the authors of those to
get their feedback.

Thank you!
> 
> 	Andrew

