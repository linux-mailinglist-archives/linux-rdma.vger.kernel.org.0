Return-Path: <linux-rdma+bounces-13088-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B44BB43E91
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 16:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 518167AFE88
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF903054D6;
	Thu,  4 Sep 2025 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GhqjeK/f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QVEpCqWz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9D51DE894;
	Thu,  4 Sep 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995738; cv=fail; b=TSgosxW5oqJald4nFsbXobezDS7xt3zPhqrc/usEd42oRCUUksJQhF9aAntsiaMmjUxrPTBDYmonG159UXVByyaCLiC8wy6F+MHDP5fHgle/vHrt3EQduzttYUAzjuoru8W8CdKT5r5cusW9kjGrWTqlIa6RXVviuQ2Ww94iRaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995738; c=relaxed/simple;
	bh=TXBPLalIrUz8ljJSyoIJA0sRAMHWdmlBALpy52abyN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SgI4sQaxPgQomDPklOBVNa766jhJ7TbKlHFeULbbysdpj3cO3oaK0YtspUc+q7P0FXRduyGYQ2TOmbHPbwbLgV2PUIIXj+cYKUzIrDahi4cIFkMtOLhi8uukwsQZNHsCi7DHF0g+6nl9GKyelN0befzBQo3ns6OTL4Bf6e3UJQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GhqjeK/f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QVEpCqWz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584DOqiV028622;
	Thu, 4 Sep 2025 14:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TXBPLalIrUz8ljJSyoIJA0sRAMHWdmlBALpy52abyN4=; b=
	GhqjeK/fByXeeya+I1cv9FGBNTTUK71vtml+xWHdAi332s7kq9EfldTC+t/RMwX/
	QdAEaI2PFmTGHYDCmbh0yQb1njxEAIBWfEFUGUA6k8DCqY+svpjnVIUtVvGnr21o
	1SR0Xzk0qmaTkPy+rOcNN0xxon0H9/rHLM8I3u9MWhzN56SV/bbYbdZ+/ZooztQg
	zqHYL5ndy/Zk2PhcNUaBT6IQ+222NfwO87MU6p8zucf8Z02YMKGnMhnbRObkfcZG
	STJa8be22gpQdl2wg4qkVEjLs79ryms9XkZSe0HMVbW1oC4N6gUN8mll0AxPGyKF
	uEixgxirxkqjYoc3VqRMtw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ybmh04pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 14:22:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584D8q8v015793;
	Thu, 4 Sep 2025 14:22:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01qwb93-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 14:22:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNr/MhkZgNWpPHyTYZ85cw+VVBPqPLlvMVgI32EIiWKZzHh/aVfzGEjsuYUQ9/uCdLmRSQQma6MC4ujtte6jLb88jSeZAUPLc6iq9J8Q1z3Mf8UJiPk3+LLZIPQPWaWQM9N3rRMZT3hijG8xvpDjwlmx8IgEkyVGBI3dnox9chQkoaRp24JzOw07ePV49hnZ3JufnTrIQ9b+UiOc6xWn0tUMVVimxDhXK0lfbzU5Uj8i2WmRkzNn/WL6u5qB5NW4haKxQ4NcmIHi7CirlMHIUPf9qwRrplG/qMxt5RwShuAcIdJleCNdL8XqnxmFE5FY9vjSM9fqiXkCn/JLGQzbkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXBPLalIrUz8ljJSyoIJA0sRAMHWdmlBALpy52abyN4=;
 b=Gd34V746+2YCVSvRfnQjzjoRskgqawTU/i3dYQLS6FKaJguJBZT+Uwl9ese32jazXaQ2Bb5/6MBRYsc9wCSPjBtvWb4T+fSFCNYmU99WDgzD6pSY9D1DXWxnRvSmX45A8RoCo6GXXqXErQTG1wvbtuwreNQT5N1vB0bCqOHHT/fiiK6QYWSbrZZGF3MoqQ4DqqzAAA4dQjHDgO0BTql+MUPH8GKstXcbVAEs10ApLMXAkXEDtulkltS/ddSnWL2GDd7S5uoRjqsr+eqVMr4maX/QV7gcz/uetYFaHqI5NqIlHaAU4pt0dwokVqnbGg/J/hvkD9AXF/LO2BXA8H6Wug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXBPLalIrUz8ljJSyoIJA0sRAMHWdmlBALpy52abyN4=;
 b=QVEpCqWzu5Sd3xcPAAsIch/cU9ilMTxycevvyW0puB10GAWIRNDMY5u/NzSvBgaodKeC/fHwaBvS6MphYGKBmuPbkhmcYqY9fBUAMT2667yqzlqC3sQsK0LWfeWxmGVUmHttoEgGeswZH/a68a9hgfBiJIjUPQMa7EYiaiLgKJY=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by MN6PR10MB7441.namprd10.prod.outlook.com (2603:10b6:208:474::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:22:02 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%3]) with mapi id 15.20.9094.018; Thu, 4 Sep 2025
 14:22:02 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Allison Henderson <allison.henderson@oracle.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        OFED mailing list
	<linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] rds: ib: Remove unused extern definition
Thread-Topic: [PATCH net v2] rds: ib: Remove unused extern definition
Thread-Index: AQHcHZKW5A3LEybM1UKHpvfH2FOi4bSDC98AgAAHgAA=
Date: Thu, 4 Sep 2025 14:22:02 +0000
Message-ID: <44A12092-5DA9-4A3C-ACBC-FF1AACB03BD3@oracle.com>
References: <20250904115345.3940851-1-haakon.bugge@oracle.com>
 <20250904065502.13d94569@kernel.org>
In-Reply-To: <20250904065502.13d94569@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|MN6PR10MB7441:EE_
x-ms-office365-filtering-correlation-id: a6643f4e-f629-4dcb-7f1d-08ddebbe6ad4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SE1CQWFGQmJWSmVORWdQakxjV2FMVWRNak9Ic2JKM04vYmQ0L0d2TXN2bW0v?=
 =?utf-8?B?Nll5MkdWUWxjRjJZb0drSGNZL2IrTFoxVHpKbVJqZkVDTEMvN2VEWnc2bEJh?=
 =?utf-8?B?MFFoY2djMi9YR09pekc2TE5FTUJ4WUJuR29HTFMrTEV5ek10V2Rxem9GUy9J?=
 =?utf-8?B?SzFDSiswQUI4SDJqSGh2VXVMS1QzVTJUQ09tdmhXUHVqYWNCTUlRZ3lnNTA3?=
 =?utf-8?B?WGhhT0F4eTlaU0ZRUnQvdVVqZXJLV3BxK1YvbUNhUVJPS2JESDc4Uys2OWN5?=
 =?utf-8?B?WjFDNHorMnNrOTVFZmMzS0lWK1FuTUpEMnVFemN6WFB0OUR4TnovdHd6YVAr?=
 =?utf-8?B?ZTdVNENUMlBXcTkwcS9sVVFqUlJRNmlOSWx4QURBTks2VCt2WWZ0WlNEQUly?=
 =?utf-8?B?Zk1BZndzQjVRWWh6dXBMOFhGZG9oVHV6UE1VM2RYSHJEZ01sVWdRSXhjNUNV?=
 =?utf-8?B?b08xVytVQWlTa1hyRFFnLzRhWXV4RlZzdHBmQnNiR0s0UkRiWjZjb256Qno5?=
 =?utf-8?B?ejNmL1JjSzAwZTE1WTRHS3FFM3pnYktrZ1FFTStFU3ZENnNXbkFocEt3YmRT?=
 =?utf-8?B?Lzh4MlBJSE0zNG85L2U5cUNmRXUySEJkUXZnbHdYdkZFTzEwUzZqYWIybzJE?=
 =?utf-8?B?cldyc0JEVFJKYjdPUkNsRlIwanFna1g3RVZaVEtrL090Q0VZdW91UTArUWg5?=
 =?utf-8?B?ODV0T0tmd0ZmdW5uNi9rZWlGaEpqSlpWdXFWSWxCay96MWRXdU1XbVdKVWQ1?=
 =?utf-8?B?aDlsWm4yUXlncC9kdGYzaC94ZlBhcTVORDR4Z3ZGZ0F1Y3Z0VWdEWUgwOFlo?=
 =?utf-8?B?S1d4QnJHMU1OWWlOb09Od2xDbG5sTkE5aWxUTlRnL2kwTWs2UzN2N1cwZ1hM?=
 =?utf-8?B?c2lNaUluKzVjOVBmQXFWNE9VWVFmbnFoWGJnRll3a3pscnR2MnBXMi9MZ2lr?=
 =?utf-8?B?Zi9EbXlmaG1PeVhTNFBCUHVPZ0RpZnQyWEx2anpEc0phSjhpcHJlM3N2L0Q1?=
 =?utf-8?B?TjhMMTMxWlRQYUM3bkVXbE05ekV3TGdUa1gzbmtUSHpTdmNCODJYdU1xUU0w?=
 =?utf-8?B?d25BMTFqVjBXUzhsYmRIWnd0cm9SbitoZFdHT0ZXRlYwQUoyR0E4b3N3MDYv?=
 =?utf-8?B?MmI2OVlXbytRbENvSzh4Q1V3ZTYwOFBUZmpEZ2lwVjF2QjcvWlVNbGlSRzg4?=
 =?utf-8?B?VGQxejg3eWFvOC9udWxoMzB6ZER6T1dsME5GLzBWdXQ0Y1JkUFhqdkRxNmY3?=
 =?utf-8?B?QnVXY2tmYnVXcVQ3cjFtWkI3elRIbWU5dHhtT0VCZVdDcTBTYjZ3YTVYRXpC?=
 =?utf-8?B?bzI0MC9xbENVOFZQZlN4cWxIQlp1MXY3OUxXNXdRcTNhSkRXZVByK243QlVj?=
 =?utf-8?B?MjBlRFNBU0taaEE0cFJxK3U4NmE0U1E2TWNiRkJTMEpGbG9QcnVYaytBVjU2?=
 =?utf-8?B?MFhPN0M3L21Da2JUbDN3TDQ5RTJnNCtickloVERGRmNENjhMOWdHejVZWVR4?=
 =?utf-8?B?b1hpaGlqblFKWms4K0hGU1JPdnQrVHkzR3RpN2cxWDlyZlE0T2Ixb0NiVUM3?=
 =?utf-8?B?RnhSV3Q0UlpOSGFhK1EvQyt4S0hYVUtlbkRocUFOMGxxL3BZTDkyRzcza1Ji?=
 =?utf-8?B?UFFCUXN0ZnR3ektGU1dOK0Jyc0NDQmQ0NGw0MnkrVTY0eHZGTjZSSWhWN0lN?=
 =?utf-8?B?M0dPSjhBa0RGS2xSVWdIcFU3MHU5ZUpJYnJsbllMTDVzMlVXVlNJMTc1bEFL?=
 =?utf-8?B?REtxT0ZMeCtHM2w1RnpoRE9KbjMrbmNSVnZmZnRteFZMQTJoaFloM3EweEVk?=
 =?utf-8?B?QnZUTUNLZFBsMUk5dHNybTBaV2JXVDBQQ0xLVU5HSDV1NjU1M29GM0dhd3ho?=
 =?utf-8?B?Z1plTU1TVjJNK1JyN3Y1cWhma1Q2d0RMRW1uUVdLVmFKcVFJMXBkZEVka1pP?=
 =?utf-8?Q?krJw2t7kanw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXhrOUlldlhQMHBka3BNUzU4K3BpM2szVWI5M1g2ZFdya1FPbCt6bFJTSkhw?=
 =?utf-8?B?REtncWxuMlBHSUNEUDhXeEcrNnhUZGR5OHpFVUFpc3MvaWw1SmxueGpKNVBr?=
 =?utf-8?B?WS9OeTBuQktGZHFFR2VBc1RxNkx6TTR1Q1dJSEF1T2t4S1l2YlR5bXlZUnFq?=
 =?utf-8?B?V0JQeS9rMnY0alEvTGExVEIxSk5FUEtuZGJLUC9ReGkzTkVpQ3JNSmpnZFFn?=
 =?utf-8?B?NW9YNjc2OXBDYnZEaHNNTm5MelhCR096L2x6U1l6eGZSUFYyazhyK1YxK1RF?=
 =?utf-8?B?bmt0eUNMVlZnd2Nka1EvK1RYZzc3djhQVFBPem02Ulp3VU5RUDA5T0F1Y0hh?=
 =?utf-8?B?UVNjZGdEdHNIbjN6NEMxOUJ3U3ovQ2dkUDF6Qk1od3hEV3VucjRSdGlFOVNN?=
 =?utf-8?B?TVJZcEp3Y0lEL2psRUxWMS9CYytIL1hwR2hDSkp2YXp4bnRvZllYdGIvd1dz?=
 =?utf-8?B?RjZsNzRRYUU3SHBLQjdYSU54enVXemdva1hoYit6SGk0aDJJWUhaVnlGRmlI?=
 =?utf-8?B?OHVCRFU3NkJJZ0FJYlV1TTBNNnJzM0wrTzJLaytQQitkMmN6dzJrMS93Zklh?=
 =?utf-8?B?dkwza1ZUYnJZbDVkRjZCS2dpUDFubjdtbytURW1IUWVsV3ZKNExvb1F5VGxP?=
 =?utf-8?B?RGdIWUN4UWtENzA1TjRxUkFJNmdteG05WVFmdG1keWRSMzcvRE9COTh4NkJX?=
 =?utf-8?B?UnBzVnRYdUR6R3NCVjN1YlBwUFlEcmZpeGtNSE9XMWFMbm9HMlFLL3J0bzNk?=
 =?utf-8?B?aVVoaGhRT1VLVG5DZ2hncmo2eGJNbGw0NytHNFFJMXI2aXFpSEIyb1c1YVpD?=
 =?utf-8?B?WVR1a0o1REtDVWlSRUZSRDcwaXVKQjJXdjhLbFNPWFBIVkVpYWQ2UVJ3dFEv?=
 =?utf-8?B?L1NheHFBdjhRRWxKSmxDcHJ0VWt4a3VMOS80L2llaXRzdGtEaXZNbGJhc2pS?=
 =?utf-8?B?SkJubmgzSXhybG9zallNMlFFdjBKS3FkRStBcG53dmR0Q1R5aXEzNk1xZStp?=
 =?utf-8?B?OTE5RzVQQlAzYVpBTTVwVklBajVZSWkrNTdaRG5oOTgybjhSRGY5dTU4S0tV?=
 =?utf-8?B?b1lRQ25BSmxNcGtRR1ZoVXdnMisxcVZ0Szd3Qi9kcjc5VXZVbWtnZjFtbGNN?=
 =?utf-8?B?QjdMZTQzamg3a01iMjF5L1ExNkYyVXpPNVZKSlpqWnpYMXFrbGJpazZ0TStH?=
 =?utf-8?B?U3FIM2M1QThvaTlyaGVMVE9GL2U2djVndms0K1p0UlZWeFdjR1Nsb3ZqQlg2?=
 =?utf-8?B?MHNXcWVCc2xNdm1RTXlpYjl1ekNQQ1EwTDJWRFZPU0gyTHNXdG5heGgxZ0d3?=
 =?utf-8?B?UjRVQnhpNGs3MUlnRlJDSE5Qb0VQOFBxMjdRK1Noek5IeFZhZElub3AzOVhH?=
 =?utf-8?B?M0FkVitGN3hjVjAwUktMby9KNElXNVp0a0V4UDIwZWUwdUpPVTE4cEQ2bXQw?=
 =?utf-8?B?YjVwZFI3TXUydEV4WmVZQkIySEZWZUdjcE5yZWlWb0Y0eUh5Sjk1TGp1cWZ1?=
 =?utf-8?B?UE16akpnZ0FhRzFramUvNnV4WllGQ1ZBN04vVWx6REJPSFpoWGx3cEVUUlp2?=
 =?utf-8?B?TDlPaFdYem9QZFNRMDJFQ1RCNHhBMmd5aGxrY3ZNelZCNzAyUHB4WksweDcw?=
 =?utf-8?B?S05wZllFREpnVTdITmxQalJSeDJZOEtUK0kvYlNXeUFBKzFHNW1Vdnd6OFhW?=
 =?utf-8?B?ZlVySFR4eWIrMythSW5Ib0UwbEEzUkVadnB2L203UWp3dFRUTHphMGhKUW9y?=
 =?utf-8?B?eTYzNlFCczJzOWlyM3BmZW1kcGIvQWN0Q2pOQkVFODJiS2QvQ1lQbGZoNTFE?=
 =?utf-8?B?TnFpWlN2MzliUjNYeCttb0dlSG9SKzdqcWtRakJuZVkzU3hEMzNSaWRIS3hx?=
 =?utf-8?B?ekFWdEZiREJrQm5BYTlhV0pTdVYzN2l4dEtEWkVmak9Sa1lFUmlJRVJhaXpL?=
 =?utf-8?B?SnVXdzIvQ3JPckNyQkRUcThJem1NYUE5TnJ0K2tIcHd4QmkwRVdDQ2l4c0pC?=
 =?utf-8?B?UUpjTlFlU1RDS1hYTDlibnhDWlJyOHRkbWhjRFFweFZmVFFCa1VEVTVrbGor?=
 =?utf-8?B?VnhNSExnQ0NJNGxCRWJ3Q21nd3haWUNielkxeHgrOU4wMm1DV3dTZUJDVXdL?=
 =?utf-8?B?MWdKNHNWQXZSdWluTDhnaC80UXhSL1kvSzZWUlI4WXg3YzI5YkJmUEhqMFhj?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32AA9648B2CFFF4DB4A6A99CE834AEF9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QO09rBCNzfpId6dljCr1RNLTZyfdIXKS9iafUjcvs7mN2ONhNsbR2xt/dgocn2NJx9qRIYjOoV864f1R2EPmn8PZM/iyBrE0gAiLuPr9L6RSbYnQQPYzyNy6iOPWz2oZR8LB8x4a9npT61cXxPp01l0/R8hbErJUBc5nxLI5uly1BFzQzeOAE6XWW6NOsg+rfEkLaaNZOGp9Mv31+7YvGImX8+7h4NjvTNrpZpoTeFHAmkRzluiSf+X2URiBmPFfuLjqqarGFObRZ06tJ8mN61ZGsgkbFV7J28wPRhLIgg57qZ6mi5dJBnxet1CoG83RPD6qcyVbuktj6u20xYMymAmNFZo+tY29jbZkHclEnwus+nS1W9GOsFP/USU7SSyT8e633Yl7L2roHunufwymR8qPDTkxSk6V44r10gDMS35nunrwYtC0kVZJGnKAWdlahtP1VeGAWcTpEaMvqaBNSrFR8GsipdHL6ZAiQJqj4IhM5WF2cGWlUAr5PYJEHzyqHIDOKc4mhxkjFEGOiF/Tgo2eUydLYCtBL1FdSdoiEerNR0vghI8o2AmI+GH9OowPmfcsFlJzWsuBcPFfp/VftrAW91Fz+IYYAe+b/LMaP8s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6643f4e-f629-4dcb-7f1d-08ddebbe6ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 14:22:02.5016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DA+lt0AOWcQ6evSmGXqLH2vDIuoXR09Z58DVQrpg6q2QYl+n8P6Qt1vEm7Nxoh44yl+NdPw8dBrdWZlxIBxeWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7441
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509040141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDEzMiBTYWx0ZWRfX4CXoD+tjk+Wz
 GlsjPXpj9rbZx1l2xlJK7CplJTVZxDdsx4F36vupoLdK1HcWBi7dZyt0AfBD3dblnfbbKEHYNfw
 lLo/d5SRZHH4jd89fLECNc5BruoS3MKNza0R37NtVcEbcrKIo1ZgP7H7GS285Z0lQYFS2h3Tmrl
 lftY0nGIAECbP8e7L2N2B4iIVPPyfPi+bMtS3lFk6NABusmkHW4u1nuJbm15PiLaFACKVQudF3J
 2dmVOHcWPM8CH4KTDU9U9GIfXJqqIbdsPwHGOVZlGvm2dx+ihXec/VqRAdM8ugdao7DwVrGP41/
 BFpBVzV92w9Xw3pmJjLM3veWNHxoG+Tvad6Mzhph4LxRD9wqum2B5SI/4qg1FeCLOzEOFeDrqDX
 axG55aR+
X-Authority-Analysis: v=2.4 cv=Z8PsHGRA c=1 sm=1 tr=0 ts=68b9a090 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=0K9fifQBhJzngSciMCEA:9 a=QEXdDO2ut3YA:10 a=D0TqAXdIGyEA:10
 a=xa8LZTUigIcA:10
X-Proofpoint-GUID: rAeEiBqWrsfGgiOC-9CowmMslTOHuP3R
X-Proofpoint-ORIG-GUID: rAeEiBqWrsfGgiOC-9CowmMslTOHuP3R

SGkgSmFrdWIsDQoNCg0KPiBPbiA0IFNlcCAyMDI1LCBhdCAxNTo1NSwgSmFrdWIgS2ljaW5za2kg
PGt1YmFAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsICA0IFNlcCAyMDI1IDEzOjUz
OjQzICswMjAwIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IEZpeGVzOiAyY2IyOTEyZDY1NjMgKCJS
RFM6IElCOiBhZGQgRmFzdHJlZyBNUiAoRlJNUikgZGV0ZWN0aW9uIHN1cHBvcnQiKQ0KPj4gQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gDQo+IEZpeGVzOiBhbmQgY2M6IHN0YWJsZSBpcyBm
b3IgYnVnIGZpeGVzIHdoaWNoIHdlIGNhcmUgYWJvdXQgc28gZGVlcGx5IHdlDQo+IHdhbnQgdGhl
bSBiYWNrcG9ydGVkIEFTQVAuIFdoeSBkbyB5b3UgdGhpbmsgcmVtb3ZpbmcgYW4gdW51c2VkDQo+
IGRlY2xhcmF0aW9uIHF1YWxpZmllcyBhcyBzdWNoIDpcDQoNClNvcnJ5IGlmIEkgaGF2ZSBtaXMt
aW50ZXJwcmV0ZWQgdGhlIGNvbGxhdGVyYWwuIEZyb20gWzFdLCBJIHF1b3RlOg0KDQoiQSBGaXhl
czogdGFnIGluZGljYXRlcyB0aGF0IHRoZSBwYXRjaCBmaXhlcyBhbiBpc3N1ZSBpbiBhIHByZXZp
b3VzIGNvbW1pdC4iIEFzIHN1Y2gsIGl0IGlzIGFuICJpc3N1ZSIgYW5kIEkgcmVmZXJlbmNlIHRo
ZSBvZmZlbmRpbmcgY29tbWl0Lg0KDQpBcyB0byAiQ2M6IHN0YWJsZSIsIHlvdSdyZSBxdWl0ZSBy
aWdodC4gTXkgYmFkLiBZb3Ugd2FudCBhIHYzIG9yIGFyZSB5b3UgKGFuZCBzdGFibGUpIGFibGUg
dG8gaGFuZGxlIGl0Pw0KDQoNCg0KVGh4cywgSMOla29uDQoNCg0KDQoNClsxXSBodHRwczovL3d3
dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5o
dG1sI3VzaW5nLXJlcG9ydGVkLWJ5LXRlc3RlZC1ieS1yZXZpZXdlZC1ieS1zdWdnZXN0ZWQtYnkt
YW5kLWZpeGVz

