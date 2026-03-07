Return-Path: <linux-rdma+bounces-17669-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eETFNzm7q2nEgAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17669-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 06:44:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DB522A54A
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 06:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 559F7301F688
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 05:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6B931D39F;
	Sat,  7 Mar 2026 05:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mMq9XEOW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bFEESabE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F33242D9;
	Sat,  7 Mar 2026 05:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772862262; cv=fail; b=Q+TuHgicgIxSq9ofeZwpZcFuiHfRJvNIqFdkPGb64aS4Srb+imkKDUXN1LYdKXrg1Jv6A/M3aWFJjkCTLZhhZP2mvub/41HSZROqcTiKDSoV/EhSSgDfUAU+5s2YHmvqmonEcrB6lqu7VQR5rqBkWqUAPn79I1AFPwV1ClYuXP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772862262; c=relaxed/simple;
	bh=mhhnxrSRfT6IP1Wa9VkgV3+4qTcvg8QCdE7IecNOWIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aCpy6YzkbDh3IMeRVv9hfFyLo8SYuK++UbyPZOTgo3pcOsJfa3tRlU8eILmhJ2M6J+f9z73EMtVX7fKh5l+wmSVv4TJ7SMZFmDkk/z3P7IbJladohgzE4eWDafYeUy3YHy1t/2vRH0n7MEGo1bhc4Sl/NNtpfSCsm6R0RwDo3zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mMq9XEOW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bFEESabE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6275cSPo1306222;
	Sat, 7 Mar 2026 05:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mSBnPhww1igK4/JxPsgm3hKQFBPkKpDHXoUKhSmIWbw=; b=
	mMq9XEOW2IUKD4MqDoHDixBPwFhi4JlfilvmpHEih0hKhY3faMYww8rYBnzorX6d
	OIWGrW/FFTjpXgRclCeZBcj9mrIxfnTI0mLGGmW4y8KWeyaJF+M+eHzoJ15Mkmhq
	0mv2+MVbN9XdScWJB6QqAxO6wjIeZBmOs6g+/v4b34Q7Rd8n6ir4jSR71wnRr1jo
	nEiEObCoFnLasGw7bHuB04UBMgHKNhX9xKtC7HyzX5ywtVVcBbZNB/ffJyq0mvH6
	MPgy8l7LCqv38rMTgTTFxuDMGTYMP7rS/zZ7BvigQu/cXDgSbpwSF1smCafYhCS/
	i1mmNzoYtw96YKaVQJ4pdQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cre1m0025-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Mar 2026 05:44:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6271XcXQ039564;
	Sat, 7 Mar 2026 05:44:06 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4craf6vf50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Mar 2026 05:44:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4nZnpG5tA04bvbzAcAuMcxS9Y11QpSJdZ/8sLhQ2fL1ci08Vug+8Rjy+8nt+1tS2He12AX7cKy2nMRUtko8PokSG68CK8tQUAe1nQk4+Kh4t3JEsahi0Ya2vceLl6tZ00OGDlvwHInGk8zM+mi8EDtK9dAx73xfiWK5zStOIOjn2MaBW56j2m6q/TzsdOwtbjIo1bZ8V5ya/hiSyXG+bNjWaDmDSm2kmWUjBqr3AZMEzdTt9SWy/YeAFpH1Bn5fUoJd7upOzinsE8oikCoxka7XDuaKYUHKlOQYqdAcYf4l9n8eaK/f59vm+g40Bh+xdmXM5D31CRp+MVJHl+0pOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSBnPhww1igK4/JxPsgm3hKQFBPkKpDHXoUKhSmIWbw=;
 b=fXMqUG60nYCPWTRM+H0S/SKpIt4YVDeu4HOgHzcvU0Xrqu0jHdYwkC1Q7pWw+G+I8CWcvfj2vggq+ieYtN8JPSbpgQRQqBVz2ZP1MOJp0Ce3AQWB9BeBo3ukW+OzVPk8AY4lI3rwEyOM8svKNwSSFhDQwoTOfzkP+ro6Cg+aK4SE4yDjf4CBaxO9cVzMOGfa0keA9gG5yH4EJERby9hCBMOh7edov1ezF2quPKNDUNAqPPK6hzwwsqiIxCFAY8YftlpOgQqru6k3j8iGpYnBkNW0EDd8SRr6ihgOVV4tkdIg4tVIj1SNREIpI6mOUF5eDYtoI3/w9NIX9bnaA3uA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSBnPhww1igK4/JxPsgm3hKQFBPkKpDHXoUKhSmIWbw=;
 b=bFEESabESihBIyMU8upW7KwLhF2+EUVmuFpBlVyshg/aLQoJLXYcRFUORDDrjxmd9li02Vv67r7SCcBtJi3yV4uVwVkbV6TiPEP9xLv5WWD6HuP7qAOp5ngXThCjiTfKFamEIxlXSylelhlwx39o3q95JVujDu1XH0OPtk3D7Ao=
Received: from CH3PR10MB7704.namprd10.prod.outlook.com (2603:10b6:610:1a9::8)
 by CY5PR10MB6048.namprd10.prod.outlook.com (2603:10b6:930:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Sat, 7 Mar
 2026 05:43:57 +0000
Received: from CH3PR10MB7704.namprd10.prod.outlook.com
 ([fe80::2a5a:b9d9:26b5:25e2]) by CH3PR10MB7704.namprd10.prod.outlook.com
 ([fe80::2a5a:b9d9:26b5:25e2%6]) with mapi id 15.20.9678.017; Sat, 7 Mar 2026
 05:43:57 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "leon@kernel.org"
	<leon@kernel.org>,
        "tariqt@nvidia.com" <tariqt@nvidia.com>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rama
 Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>,
        Anand Khoje <anand.a.khoje@oracle.com>
Subject: RE: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Thread-Topic: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Thread-Index:
 AQHcq/Jc3KuDnivfpU60Ol++d2Bny7WezmGAgAFbMpCAAH/ngIAA5tgwgACUnACAAG1AUA==
Date: Sat, 7 Mar 2026 05:43:56 +0000
Message-ID:
 <CH3PR10MB7704D1DF6471E59D47ECEB098C7BA@CH3PR10MB7704.namprd10.prod.outlook.com>
References: <20260304161704.910564-1-praveen.kannoju@oracle.com>
 <20260304201151.GI964116@ziepe.ca>
 <CH3PR10MB7704DD1E6B9A671796FC6B528C7DA@CH3PR10MB7704.namprd10.prod.outlook.com>
 <20260306003217.GB1687929@ziepe.ca>
 <CH3PR10MB7704ABC8F3909C60FFDFB1188C7AA@CH3PR10MB7704.namprd10.prod.outlook.com>
 <20260306231024.GF1687929@ziepe.ca>
In-Reply-To: <20260306231024.GF1687929@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-03-07T05:41:25.0000000Z;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7704:EE_|CY5PR10MB6048:EE_
x-ms-office365-filtering-correlation-id: e0f5a2aa-d52c-40a7-c5a5-08de7c0c866b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 7mXuNgmldGTIqL1JKs2xdHls3WpUlhCKS0NNAfJGC7A1vMJekgjFrrcSgUmOb0po/cVi+q4ApR7h3Qulnw3DKqfGnvLymiZ+daaMmkaEVzzbGdNTyc9SMz37oqtDg1gwbltG4+dPnZwjoS/DN8mYui7rXJVyB8MPraDGysY9zh5plilWm+WjyER2OS1m1zWIOCXduek5U6C0fo9U8jHn9jH6onNMKxQRVVp0kCd9P35YH97kpygvZue0TCVAcKEHCoFD1yvgu9t9V3UcrBVK00r4U4CqmBTCtnVQM0N7eFGUYPJA5Dz2ciuzIFTO21J2AnXg2S3d3ueWZ3HDcWaugboIp+NaQWUccHe3wLRkHewAOJeFNeQm5PCCJXP53ukImPbHosMMsa82JA+utZZjJ/uxQcUPTOTwY6q4HmpoUzAZP+UPKiGAaJZH7cIwmPV3s9rrffK7WfsLZ8GdM4GmwMaeH79HU1RWKPJROcoPSiEFxeUVHHFxTXVRqM/rjotbXBC3o3UoNFceXVdI0JW7MD7AC92kqsY1T2CzVE4K5i6k90GNavJ8qmUbVfdTSy8IoZqtuq5oRE33THuUSw1dWJR9HwXWZaPLg8TgEPTudZ1tuA7rDe5ihnaoeUOfNjg+TduoCsnTovorbXJOZaNIFxf2r+i1dJ2npC9oEwgBqdklhajUxUjmVFSpeXzF2CAd9k5i2dxblVlQ9/ZuNablG4QtNYuy7H316DgNe28zx/IBB5u3tSnGiP0eGTvn5zAlJ3YushC4o9xBsoR9UFs9OGD+yWoJVUX1ASl/MPICuOg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7704.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?aEdHU3pacWlZTGpPVHlHOUxOeGdaSlBYNUxlNE5xOVl2NnB4cmxqdkFNU0Rl?=
 =?utf-7?B?MmkrLWlxd2p1Z1hySHlDeEhMVFVjZW9lUFZLOHlsMSstRmlUTDF1Z1l2VSst?=
 =?utf-7?B?RWdYOHVzZkRuNWgrLUo1ZUQ0eFM0RnR2ajdLQjRSYVVkYnlGUUxicERGVWFF?=
 =?utf-7?B?L1Q1UlZscHVRdGRDUUhpV1hjTU5OTjkwMFU0d2U0bXh3NHpzUUFNT3R3ZEJP?=
 =?utf-7?B?WWF6NVFnd3FPYzFHcFdtOEthSWJmNG1IVGF3eE9MRXFBVzgzcEFyaFRSNHVS?=
 =?utf-7?B?WFdTKy11ZXlBUml2cUVMdnNOSExkQjdHMDZCRkdKeG9lS2ZRUzVGTUpsdUdw?=
 =?utf-7?B?WnpmRHNXaHZ5R2Z5VUJVUmNWdG5oMXRjRlErLXk0VGg4aVVxMC82ZlNyKy0=?=
 =?utf-7?B?YistRXVFTklScUI2Nnhva2ZkWlFyOHpXcy9WWVd1bmpiY3VnMWlLYzBYemNm?=
 =?utf-7?B?TGFISkpvRkhWL28rLTVadEdGZ0xpUmhDanBDZmpnd2xGYUJXTkFqR3d2OVNG?=
 =?utf-7?B?cUhvUVhucXZnWnNoZi9zTkpBNkxvTnhFUzM1dzA3SGgwcjU5MkRsSmpLQ3Fs?=
 =?utf-7?B?bE1wYVppSDhQQ1ljMXFjVystWWd6ODRxdExpc3pHL21WSVEvT3QxVDFURmRz?=
 =?utf-7?B?QkZ1ZzVwT0F4bExzTE5ueWt6OHNUM2FqKy1Hc0lFOG44UUd3dFF1SlYyeXlK?=
 =?utf-7?B?dUF2d210RDN4UGI1ekxPSkRlS1R5Zlk4V2ZWa2d1WGhwL0w4aC81SHRuM2NO?=
 =?utf-7?B?T1UyWkRXTE40ZDVQaW5iV2QxT0NJeW1BV05ER3RDdmE1SUdKWURjcEpvYmRs?=
 =?utf-7?B?L3JkZlpVZzhpZnVYNTRuQ2xWM216YS9kbHZCb0sxd2p0SHZJbE1DM1ptN1RW?=
 =?utf-7?B?YVR5TXBEalNlYlRBbVJaTlBnc0xtRGJER3VNTUwxSVlWKy1EVUlyOWF4TWJm?=
 =?utf-7?B?cGtabnRtNVVueEJjRjFyeGE4YWhjSTZETUNuaHhtb3MxRGMzc3lnRzVIWGF5?=
 =?utf-7?B?aDlFdWc3VHUxbUlQRTBzdHRGQm10d0luMWRYSk1XYjhHVW9pckZSWTE0QUxU?=
 =?utf-7?B?TVV0TjVJZG1XL3JkYnVYdXZiZ3pWUzJYSldFaHVqQ3BGV0tLQmhSeUV4WlFz?=
 =?utf-7?B?eDB4cjNtMjQ2dGpxcXpMNDBBSXN4SEI3U0lmRUhnR0JqUDZ0L01WZ0svME9Y?=
 =?utf-7?B?czFabUJDdjdDNjNpSUROMVl3ZDh0TFQrLUFHUVY3Z0J3WE54cGk3U05kQjdT?=
 =?utf-7?B?U01iRnVxc3JaTFJEMWJ6Tkw4V3J2R2pDa3VCVmp4dmdsWVd0bm54NmhNU1ZO?=
 =?utf-7?B?elFxSHJJcjBaZlhEaVdGSWtUenZ0NzlScS8xMHhhUkJCWWg2bDRIN1ByRzJq?=
 =?utf-7?B?bmo4bzYycER3WGNtT1RLVDk4TDZzbmI1N2FYTGZWeFRDSmVsSGwrLUw4d2xj?=
 =?utf-7?B?Y3hvKy1tV1Q4dENrRGRPVGEyZGNUQjRCaWljNGUzcndEdkJvdWpYdGpEKy1C?=
 =?utf-7?B?Zkc3WkE2VkxsQistcEowMG4rLWFpN2h2aDh1Mk01cnlXVGtXQUgwb3NySHF3?=
 =?utf-7?B?Tlk3ME9aTnBlNkI0bGpJNUdlZW45U3dHN0g4VjBBODJTbEl5RDhCdXRXTVZS?=
 =?utf-7?B?aThXRDN5UnBOU01ob0xaRGlwZmFWVGVIM1VkS00vMlZKU2pqKy1PSUcwU01s?=
 =?utf-7?B?OXdJTDR1SXJxRystN25BRjlDT0x3QTV4b25uY2RseTNvYnVKczVQNXN0S3R6?=
 =?utf-7?B?MldoYkpLQVRLN3JKN2lKZystS2YwWTAvRjRReVNVZVJ4Ky16ZGorLUppWGhB?=
 =?utf-7?B?elNoa292L3J5NFFNd2ZHZWV3b09NM0lBeXlMZlNiQUU4OUpodkVETXpHdC9D?=
 =?utf-7?B?NFI2QTEyZW1KYVJZWlg3NHF5ZHJ1ZystUllYR1dlZGFaOVZHSFB3OEhJN1Zo?=
 =?utf-7?B?ZkZJb2hndmtBS200UFJ0emQ1djA5WDR1N3IrLU8zVElEZXlPU1ZIM1JQNHM1?=
 =?utf-7?B?UDM1TW1MYk9MTjFna2xuTkphNS9KMUV1Tkc5ZystaVNJZUI1RUJBZEY2Slpl?=
 =?utf-7?B?N1lHZ2orLXF2VjJIWmhuY3doMUxwKy1pNk5NVCstVFh3WUlHblVGcVdoN2ww?=
 =?utf-7?B?U3hDR3lGZGZDRzJabVRKalFpbXltQ3UyM1krLXVCb1E2aEhDREhaZ3dUQ055?=
 =?utf-7?B?YmE0T0ZPcHFKZlllS0RlOG5ydHNJUklVSSstcTNudWdEbmI4U29YL0VLSGN1?=
 =?utf-7?B?cXF4aGYvVW8vQVVQQW54RHgzYUJPVko5ZGRpc1VWOVNqUGJQSlB1SDFYRndk?=
 =?utf-7?B?dncxSGU1VDVIeXJNcWhKU3dPc2lwb0R4d2padzVsMUNVV2JwQkJjM2FTQXNT?=
 =?utf-7?B?RXd1bGR6LzRTdndtUmpDRmxvYTRrVGQveU5nK0FEMEFQUS0=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	gAKdEy6Q/s3nVUIMwCtNxzCQlrV+zOX+GK9vI0TkT5hLChKg6PkFLce1s0qJxKYk4wTFCRF6crYqqDUwQtPPuuCcebqDGak9Cz7FU72Jp/EwUd+whJ1TKcM5UwrzHCaXkATA59MXBHiAIdh1Sb7uNC2IYiXu4Pv7F0KQfIfJCWdwx5LhATBewc7DdWFMbnJRYII/sbwYtEcGbx799pnrMRjM3UAHtYcB8F1SlOHiM4o0LR6f0sCvXWtn42FuCjRJtDUPIPGlGOYJYbNWP9D9LT0FCyYXkZaNvrkvjRFnWk19EVLyK/v7Bqbby75S457BmyhWdhzzu/jlCOAqZc0YSQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XBrqauk3pIhbOKX3JxG1jwBGAWqCrZuwhY5kOR+nKt5ZSfFwZBHVxP0hjOgdipmWCTbAcTj3UGjOxVFypfv5nG3fW9/AcHqrexR4yIGIwVVA8E268HlEjIaXqPDK3tNorT+/q7VXfjobyKn0eXasBSFWuuYPXJbBmR5jt2aRn7E1qmLo0AhpGn35BOyDVTJ/mB9KhNORtDKWnEgeoqqVqP/IYNM0yndVZfAFVp7ZKWOTDiMnAkvL+Z07Dnx32LYu3rK4nrr4zBuiUuPPXnqSyzvY6s3DL67cJpKi39JrDMPNwq1LjZpu/PgDV6c0PFVPAW1SgO4npv3SPM+spDtHh74u0GSoGkgIVQHRvRu94qO5eOR9zu8GuY7XsJp3t5/nq9MYLkW/m8skIvCbSnWbwjkY0T61g/6aJgP3jX2x71XniThOMl4GUDwj03X0+gFcaRvUOhkHwhQUIYTGjDMUuEcYUnP0nqIma+KcixIGh+ijPM6CY8owdGZpYQg4g94EBAJkTD/y7ImgSXlHKeNqB1FiZ4vrQpSgW3e6Fxhfzfhc7aSYXtb9a5xd31XcLD56w8nHb95jiwAyeYCJ0SZgW/EhY+SzR5oBqnZEYTapXQs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7704.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f5a2aa-d52c-40a7-c5a5-08de7c0c866b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2026 05:43:56.9658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yyHXm02Ky25SZNDMkfbLNu6Zwip5I9pMc9zmNUeZ2KPBefEZvj7hND/4JNNAuraW7Wmqo17NhnSXjhTS6YnhW3iQYmvV4G0XBOQO08S8OM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603070050
X-Authority-Analysis: v=2.4 cv=Xsf3+FF9 c=1 sm=1 tr=0 ts=69abbb27 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10 a=YU3QZWNX-B8A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=9jRdOu3wAAAA:8 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=Fofg-9D3AAAA:8 a=mQvHCebiAAAA:8 a=BXszkKfDAAAA:8 a=c1PdSmG1AAAA:8
 a=hggDf0hBAAAA:8 a=NSIbRwiEAAAA:8 a=XlRjxQ70AAAA:8 a=JhIueiDwKlaUrLTgxxkA:9
 a=avxi3fN6y70A:10 a=ZE6KLimJVUuLrTuGpvhn:22 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=Xbaoi9ZUBzzYp91LqZJF:22 a=wsrb8zZI_WQ3QAEBCXTy:22 a=duu7wrcty9prphiCz_fF:22
 a=4iM0TfZbaBQr0p37pvCp:22 a=7ilw6d6txcz0Yr6I31bG:22 a=ijqVwrIbDdJfMQQjsWiJ:22
 a=1uMOUU2w0DxzEe95gQqD:22
X-Proofpoint-GUID: sujwa7JJcQbtWvi-W0bBkYZrHD3AMHhK
X-Proofpoint-ORIG-GUID: sujwa7JJcQbtWvi-W0bBkYZrHD3AMHhK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA0OSBTYWx0ZWRfX/SZiqR9iHJHV
 npNSC5MCjsBdifTKh25r5V/n1x7UBEpZ4hw5uV0rVD8j/gypYn7keZP7mdO9yDsfw4zYMMnrKwH
 EjQlskjEXK2HZOQKGAiQGqxWrBrLAdmkdqqCYsa2QXZPD090DneGRcGTkbUH70O4FXYe98UyBAi
 vmyo7L9Y0IrMII4zF1zCljuGRW4iWK1gOzrJfMsQn1siIQi2zim4ddGciA7nO+T+dqoaomAXddP
 vxwYh7jAbyGhBhr69ArYxlfk4biUtQWpXrGcjkG1yWDGberwWFRRFhXjm6I1kmglE58MVxBfScB
 ZAeZqlpbxxpLnL6nfIC1KhPvsSwaccfHMugQATnYJ3tYM+KDjBCvSu9Gcem1pRLjv0VKENW/SV3
 kG9t7lNf6qjWZBSYr2I8fUupKvH9JZrKq4vEX7LqgoIlTQ90qCxVsDIBm9M44/BTnsuXDscyeGR
 N8LVFnaGNiwQmDBmVNw==
X-Rspamd-Queue-Id: 88DB522A54A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17669-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.979];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action


Confidential - Oracle Restricted +AFw-Including External Recipients



Confidential - Oracle Restricted +AFw-Including External Recipients
+AD4- -----Original Message-----
+AD4- From: Jason Gunthorpe +ADw-jgg+AEA-ziepe.ca+AD4-
+AD4- Sent: Saturday, March 7, 2026 4:40 AM
+AD4- To: Praveen Kannoju +ADw-praveen.kannoju+AEA-oracle.com+AD4-
+AD4- Cc: saeedm+AEA-nvidia.com+ADs- leon+AEA-kernel.org+ADs- tariqt+AEA-nv=
idia.com+ADs-
+AD4- mbloch+AEA-nvidia.com+ADs- andrew+-netdev+AEA-lunn.ch+ADs- davem+AEA-=
davemloft.net+ADs-
+AD4- edumazet+AEA-google.com+ADs- kuba+AEA-kernel.org+ADs- pabeni+AEA-redh=
at.com+ADs-
+AD4- netdev+AEA-vger.kernel.org+ADs- linux-rdma+AEA-vger.kernel.org+ADs- l=
inux-
+AD4- kernel+AEA-vger.kernel.org+ADs- Rama Nichanamatlu
+AD4- +ADw-rama.nichanamatlu+AEA-oracle.com+AD4AOw- Manjunath Patil
+AD4- +ADw-manjunath.b.patil+AEA-oracle.com+AD4AOw- Anand Khoje +ADw-anand.=
a.khoje+AEA-oracle.com+AD4-
+AD4- Subject: Re: +AFs-PATCH+AF0- net/mlx5: poll mlx5 eq during irq migrat=
ion
+AD4-
+AD4- On Fri, Mar 06, 2026 at 02:19:09PM +-0000, Praveen Kannoju wrote:
+AD4- +AD4-
+AD4- +AD4- +AD4- On Thu, Mar 05, 2026 at 05:08:52PM +-0000, Praveen Kannoj=
u wrote:
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4-    Regardless of the underlying causes, which may i=
nclude IRQ loss
+AD4- +AD4- +AD4- +AD4-    or EQ re-arming failure, the TX queue becomes st=
uck, and the
+AD4- +AD4- +AD4- +AD4-    timeout handler is only triggered once the queue=
 is declared
+AD4- +AD4- +AD4- +AD4-    full. In scenarios where only specialized packet=
s, such as
+AD4- +AD4- +AD4- +AD4-    heartbeat packets, are sent through the queue, i=
t takes
+AD4- +AD4- +AD4- +AD4-    significantly longer for the queue to fill and b=
e identified as
+AD4- +AD4- +AD4- +AD4-    stuck. A proven solution for this issue is polli=
ng the EQ
+AD4- +AD4- +AD4- +AD4-    immediately after the corresponding IRQ migratio=
n, which allows
+AD4- +AD4- +AD4- +AD4-    for earlier recovery and prevents the transmissi=
on queue from
+AD4- +AD4- +AD4- +AD4-    becoming stuck.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- I undersand all of this, but for upstreaming we want the =
root cause,
+AD4- +AD4- +AD4- not bodges like this.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- There is no reason to do what this patch does, the IRQ sy=
stem is not
+AD4- +AD4- +AD4- supposed to loose interrupts on migration, if that is hap=
pening on
+AD4- +AD4- +AD4- your systems it is a serious bug that must be root caused=
.
+AD4- +AD4-
+AD4- +AD4- Thank you, Jason.
+AD4- +AD4- We'll evaluate more on it.
+AD4-
+AD4- If this is in a VM running under qemu - qemu does Lots Of Stuff whene=
ver a
+AD4- MSI-X is changed and that stuff has been buggy before and resulted in=
 lost
+AD4- things.
+AD4-
+AD4- If it is bare metal, I'm shocked. Maybe an IOMMU driver bug in the in=
terrupt
+AD4- remapping?
+AD4-
+AD4- Jason


Hello Jason,

Yes, this is Qemu VM, on which we are having the issue.
In bare metal environment there is NO cpu scaling.
No issue seen on a bare metal so far. Maybe unlikely also.

We are having this issue as Qemu VM's go thru cpu scaling
based on business needs.

It had been very challenging to arrive at the cause.
we went thru many live debug sessions with Nvidia R+ACY-D team.
but we couldn't root cause. This tells why we eventually.
arrived at this mitigation as this issue is wide spread
and has been hurting many and many customers in cloud.

-
Praveen

