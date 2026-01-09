Return-Path: <linux-rdma+bounces-15409-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 128AAD0B6A3
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 17:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDAD330056CF
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 16:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D32310636;
	Fri,  9 Jan 2026 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r2xovaS4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Du9m4Aw7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1E523B604;
	Fri,  9 Jan 2026 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977777; cv=fail; b=EtUS2M75CuwLYdK75ry9g4NmPBsKq3PeSWO25524w3zcFJbTd1jC/MtxVdWb5ppJ2SYXD5gcvrJ8exqgusOJva7I5/tctGdCV9Ew6fehUQku3jDIe3ztndYJaZSpHAJkXQucKF6riGJhIEOra/MEwu4DKSOVWHJahsi1SGAl5YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977777; c=relaxed/simple;
	bh=9fx6/SdFCsbMI5V6/BQLsyjyioPYHqHN5GkrGWUYgzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fU4hAFGfp8p5/+obNr3nev1kwM5Tfw170tZwljAmZ/G4QWD03FJg1fvdupJoVoGs1nXwjgIOexg4MopC5SVFapGqJ0VSabtMmIZGGXYX+8R9Od1Y2KO13iP8m9Kx88/yzHoAXy2qn8yXaRE7XcHZ+qiryyFvzY9BgAZ72vReI8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r2xovaS4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Du9m4Aw7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609GfoXp3405050;
	Fri, 9 Jan 2026 16:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9fx6/SdFCsbMI5V6/BQLsyjyioPYHqHN5GkrGWUYgzs=; b=
	r2xovaS4rU3dzRHFLC0wsDS+uCAihv95jEbOHayhGvtOWA708OlAKSMmWm8s2BNE
	CuL1XRd4B4u7jcU0no0c///VJX1bdaSYHnKaOOa2wZerBjqiisj9MhPXP9lEQStY
	Z6xobcv72ouRM+STjG4KCTv4uwiEuf4QhvM0boaH6+mVJChUaAM6taiS/OwFkoRl
	Mo7A0mDbHjwOHv3iHB4TAB5AVOLftJKxCAnBW3bFeU/tqrQ8tiAgYYmR2iaccaLP
	rBOhJARLhOvsRPdkFdVsOA1NBSrwxe+xy0X4Z4elgCAVmMRpEM2Njv0IVEPwNTYx
	2kGaCC2qCO2uj96ulrZX+A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bk5dvg0qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 16:56:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 609G02GA015533;
	Fri, 9 Jan 2026 16:56:09 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besjcap0d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 16:56:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnhWP5yofIm/mvtH/YRK+jBNZQjaZBA+H/3CjTr20wUWMaIStTkfxT+IXpnCP7+sLGzdDuxSts78IthL+34ySZl1QN9tXeWLN9EbVU44FBEbXMhjmm9L8XYDZdIui33id/nqFLlLVlPtQBjMKs1yZ1wTKenS3SbN8i8LOueM65DuXmTpFTYQwAr//wAWEuMG+mBUWDzazYtsMWFejMGwWZui3UsQSPexqRniY1/SBIUk8YQ9o3OSc8QB3StUGBQkV4hnX4PO3OVn45OFasDEu1jZ5Ke3VX0FQ8zCPQ/Rj1AbGa+7/xHfgPVDNxoCD/azpZ/gGB/Y3kpoUR4ihmsJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fx6/SdFCsbMI5V6/BQLsyjyioPYHqHN5GkrGWUYgzs=;
 b=sfakfzfbShrN2fuJ8Jr/VSLXyFv1THbr8AYfc4lGwNERWw04dB0daHe2KNQoZZdwDWd06MHdXgOI7hzVXQsKfQqsv/Gamm/qx9cw+pa33fC5TFNAkFu9/vQaaA+wTq5RSSnsLi8OzcXoxR+Yh7KzWhp917Dx7wrSYMI/9AUXgxcq8Q3+fI0qBFHNy+Dj4B4l7HnQDDP3XRDfa0Sbjeb1trU4H7IER7yDBQyIbEIhwqPzJEpIhq7t8SWHdE7LvEdnO9GHQGYhnbxMAV8gOZFFQf6EOvN2CegkAk0AF2OnzEILbSALNItRTTKzs2r68ySMPmqh3qhku0tcBaB/YdKuaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fx6/SdFCsbMI5V6/BQLsyjyioPYHqHN5GkrGWUYgzs=;
 b=Du9m4Aw7g48m1PsWRerhadlIVDXmO6eXpI45LHqisyYQZn8cnXs8VTbZj+MMHysbNTkgp0Q8tS/5qOhlqwctaWPu2lhfytm8VXfpPVWHqVR9mjUdKJcYi8WOQZhGxiZOOYbRaykm7PDscqwCQDherKafGWSQPUL39LeTN0Z4BG0=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 SJ2PR10MB7705.namprd10.prod.outlook.com (2603:10b6:a03:57b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 16:56:04 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 16:56:04 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>,
        "achender@kernel.org"
	<achender@kernel.org>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [net-next,v4,1/2] net/rds: Add per cp work queue
Thread-Topic: [net-next,v4,1/2] net/rds: Add per cp work queue
Thread-Index: AQHcgRLse8TglmPblECynfAr3gEKubVKD4KA
Date: Fri, 9 Jan 2026 16:56:03 +0000
Message-ID: <714a7ee54ec045b7abfca411f613d4e77410c85b.camel@oracle.com>
References: <20260105223532.167452-2-achender@kernel.org>
	 <20260109025143.2854604-1-kuba@kernel.org>
In-Reply-To: <20260109025143.2854604-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHUBBMB
 CgA+AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAmiSe
 HYFCQkpljAACgkQyD6kYDBH6bOHnAv8C3/OEAAJtZcvJ7OVhwzq0Qq60hWPXFBf5dCEtPxiXTJQHk
 SDl0ShPJ6LW1WzRSnaPl/qVSAqM1/xDxRe6xk0gpSsSPc27pcMryJ5NHPZF8lfDY80bYcGvi1rIdy
 KD0/HUmh6+ccB6FVBtWTYuA5PAlVOvwvo3uJ6aQiGPwcGO48jZnIBth96uqLIyOF+UFBvpDj6qbfF
 WlJ8ejX8lmC7XiY8ZKYZOFfI7BRTQxrmsJS2M+3kRTmGgsb6bbPhaIVNn68Su6/JSE85BvuJshZT0
 BmNdWOwui6NbXrHgyee0brVKbngCfE4+RZIzleoydbHP2GnBtaF2okhnUWS/pNKsOYBa3k8IXdygc
 CbiXmjs3fIf+8HIm0Vzmgjbi5auS4d+tB+8M22/HWdxmdAB0sHUFMtC8weYpVxvnpGAsPvy166nR5
 YpVdigugCZkaObALjkJzNXGcC4fuHcqZ2LVHh9FsjyQaemcj8Y6jlm4xUXgyiz7hkTNsWJZDUz5kV
 axLm
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|SJ2PR10MB7705:EE_
x-ms-office365-filtering-correlation-id: 6c04c0af-1c42-48e5-c1aa-08de4f9ff9a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHNmcllvQzJaK2IwaS9hYlNXOGpmZWdoV05CcDJqdWViSm1nWE9kU0wxcEtw?=
 =?utf-8?B?YWJ2UC8ya0JhMmFZYWZvcGlFUEhqbkJURm02Q2gydEFmd1hpNUpqUGxBdnBY?=
 =?utf-8?B?TTFkMFlWcjhrODQ4a0dKbkdYS1QrdzBBeGQ1NmtQMm9pQUpzWmRsZWpWNVVO?=
 =?utf-8?B?YnFVSThqUkIwOHM5MUZSZ2lLTHJVRkdiKzZRMWJ0M2piTXNiV2lLV0t0ZzhD?=
 =?utf-8?B?ekRmdEpRRi96eHE3ZVpxZzV1T2pWUXpYZFNQY1RWTUNPOVgxNUdtSlhrL3FN?=
 =?utf-8?B?aUJ2VE1XcnFQYUh3MzZDLzhySWNyQ0tYZGw4aWh3VGZjMGZvemc0MHU1aVhk?=
 =?utf-8?B?YXZEdzMyMFE1Q0NMNlp1dVFuT0diM2lJYk93VzFCcFBSOEFrMWtMcUNTYzJR?=
 =?utf-8?B?U08vbUFFMXVjbGRsdHZ2NlR2K25OcXNSRGUyNFlSdDZRM1JJdjc4bHIzME4y?=
 =?utf-8?B?V2VmTEIyZ2FTR0RoSXJzUm1VekxQejlNbEp4am1TVk5ZWmlkajRST1RsYnZN?=
 =?utf-8?B?TTNUZzIwczYvMHZmMmg1aE9LbnVkVHgxL1dmRkpnOUdFN1BSWVBScm8zRmRl?=
 =?utf-8?B?b0dseFVYdmNFL3I2OFRNd0t4OGRkcWRHQklsWmhrQ0NtaUFsNnBWWi9DK3Bq?=
 =?utf-8?B?VWtTVlA2eHJHTnRYMkZyUzFONVcvRVh0OU83YlJlV2RXT2x1ZzdibTEvKzFK?=
 =?utf-8?B?YlF4QXZwSThTNmI5NVZZK3dPTm9NZWJKYnVvdlNScXllQzN4VWdKamY5SkNE?=
 =?utf-8?B?K09vN25NR0VoMjVxa1lDU3BmNjBWRzB5SmpWeTlKNlNMM0xXZzdtc2pOckpp?=
 =?utf-8?B?YnZhekR1a3JrblFOb05rOEhjYitmTmtTRTBsZEM4Z2lGT1JQNm5qVTF0NUdw?=
 =?utf-8?B?T2tKbUZQd3pmVEhZUGZmU2ZxUC9URkpQV3BMZzVXM1ZVd1g3eFZTUS9rTnZW?=
 =?utf-8?B?WVhnSTJTM1FLQTBMY1A1M1E1eVVQWVN2RVM1RzZCd2xzWnBlRnRZNXlDV2FY?=
 =?utf-8?B?WHdXZFhPTVl5end4dzFHMnBGblFXTUJ4OGdlWWhBdjNSNytxTlpWc1NlWG9m?=
 =?utf-8?B?b3RnLzkyT2MxYjhPa1RqU0xzR2J3MjZJbjJxVDRIVzNUdHNYV0pmdHNtMlRQ?=
 =?utf-8?B?TWtBQ1dGNFV4MTJvR2xieHpTN3RDK0VraXU3RXFFSmE1ZkxYY3o3REwwQWVq?=
 =?utf-8?B?UEg1OFBmRVZrUjluN1V0MzFZd1lVUWYwV3NHTkJIaVRFbjhiVTJCdENaZXpO?=
 =?utf-8?B?bmJIVHA1Z3ZiQ3lVMU8rVGh0S2R3QVJjOGJ1cDdERldoWng5RER2TFVrZXpU?=
 =?utf-8?B?b2hYbmxiOTlHRTVsSG9aRTFxa2RGaDhTQVIxMWduM015aUxGei8zYnUyb056?=
 =?utf-8?B?RHVDZENMMjh3VFpCd3hUclpueDZOVlR0NFRXSWk4TUVwZlBaazFFUXdIQ3Ix?=
 =?utf-8?B?VUhiSHFtMUNxa3lUK2hCZlRlSzdZSHZqd1RiMWc0YkduSUg1Q0dCQlNFUDNR?=
 =?utf-8?B?K00vNFNubmhwREZOY2RJaFR5V2VHa0k5V3IyWktzOFVlajFMd2lYL2V1WlZt?=
 =?utf-8?B?TlV1TWJId2JiTWEzZ1M5VDd4Mk14VjJlOWdOK3pQS0pnYmszUDZmZjcwSkor?=
 =?utf-8?B?L3k0NW91OHVYTGl6bU1Jcm11Sy80Y3hFT1lXbXMyR2lzcUpEaXV5NkNmWEF0?=
 =?utf-8?B?LzM3azRWVnNhRFVEWWpoS2R4NG1RbnVWdUhJM2VWNVAyd1RzQ3hONyt5ZGsz?=
 =?utf-8?B?WHpCRFNrVmlvT25nYzR3bGczcUJGbEg2Y1hCTFFweWU3M3VGenBtWGo5NW91?=
 =?utf-8?B?LzdMdHBZRkNrZkJSVmhKdU5ndy95SGdnb05mblBQd3VXSGNzZXA5WW5Wc3Bq?=
 =?utf-8?B?MEZpWnlpM3pEMkhpVHJvaiszZkJTVFBsb0FwUlIwTGwxaWRuUCtWZlZGQ2Zi?=
 =?utf-8?B?K0trLzRoazN0RXF2TllVRmJmNXRMTVVGaWZYVnIwaVNkZnJoNHE3ckp2bjBx?=
 =?utf-8?B?amIvT3BWWkQ1Q3hFQkxaZ0dMSG5NYVNTMUtVTnVjQ2djckFSa1NaMVc5eVJH?=
 =?utf-8?Q?3Rak59?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnpWR2I2MGpPdEs4bGZhbUIwMjBOWEoxM1lTNG1XbmRMeG5sSDZ1MVM5cCsx?=
 =?utf-8?B?aGI1RVFkMi9EUG1CbUV0dTBFK2VKVVlEaVFNY1RGL3ZRRWJTdG1velZBam9T?=
 =?utf-8?B?OFVWeDVyand4ZWpiWFY5ZTdUbGJDU012cEdFZTBlKzh4ZHNJbjc1ejlQdUdi?=
 =?utf-8?B?MDR4TEp0Z2hvc29DQkNLN0QzSkhvc2d0byt5TmYxeVFtVmpjb2E1MEZKZm5X?=
 =?utf-8?B?WDlTOUpmZ0ZvNVp2dHB5SFpTYlAvd0VYZlVob1EyWGU5anZLU3ZVRCs2ak9t?=
 =?utf-8?B?UzZjdUFXRWV2VFp4bGJ6dWtZTURVbUhZWkdUNkh6TXZESHdBaTBqemRvb0sv?=
 =?utf-8?B?QjVWYkt5c3R3K1l0dzllQUMrUjFPKzk3eGc5NCtqbnVIZzFZVGxBaW1wVnk0?=
 =?utf-8?B?TkhHMy9nelZabFdIWlNFMHg1NEtjZTVlZHo5OWdVZmFJWkFQSHNiMnROc25X?=
 =?utf-8?B?Z09MUUFBTEloaEVDVlM0T09SSTVuTDhCNzJSUklaTGFvUVFKWHRvK0pGcUZ5?=
 =?utf-8?B?RDhxekJXclM0UndlT3NVVnVDVk1iM1dVc01PVktObmI4YVdJQ3IwekM5Rjkv?=
 =?utf-8?B?ZGo0MVVMcHBWS2ZUWEdPNG5BRHpWbmtuUUlKRXBNYi9wcFpCTTBpRWR0dlBz?=
 =?utf-8?B?UW9DQ2YvLzhvanBUU2dDWmUrN2E1Z1E2WjVkZmJhR0NnanJSVDhHTDJ3TFEy?=
 =?utf-8?B?VCtqNTNFc3BsRUNOeVJFcmpHWHl6ZWhkNFFTWlJkWDNIZTFjNTArV0M5N0pR?=
 =?utf-8?B?TlNId2tDRzd0UzlMTlE2UHFpcjl0YTVGK0NVSWRIZXd5bFh3SHZXVnhrZ29o?=
 =?utf-8?B?OTR6alU1c1hwSGxBWFhocDJnUlNCNnF5WWZNUm1HdFJqTml4MkJJMlYrWmRm?=
 =?utf-8?B?MEdId0VWU0RteW9JcHVhL1E5WGVTWlBzZjE2WHhRSFFZOXhOdUlETGZRMGx5?=
 =?utf-8?B?NC9kdzVtNWp0L1lSOUtJZWhCMVlnUy9Dc2ltQ2pqZHl1eTR3TUcwREJGbFZW?=
 =?utf-8?B?eVVIQ1BDaitkbFpJRTgvck90M2ZZb1pmUjJrbWhlSGc0Z1pMd0gzaDd1UFJY?=
 =?utf-8?B?NHB2T0ZxTjc1am93WDBrN3hZVUtCcE9FQUVVMVNVZWttZnBkZE9oNFV2Yjc3?=
 =?utf-8?B?MmthRkZ4T1BNd1M0eE5xekEzUXZYbGU2cEZuTHprN0pzN0V5Ym9OSE9YSXBP?=
 =?utf-8?B?OWJyQ2paSWFtZ0QvdlNkMEZmSHBoTW1ma0ltMEJuS1dwMFJyWVNWZnJpYVNE?=
 =?utf-8?B?V1AvWjJFSit3eE0yNjJHckdjM1phSVczS1dqZVBjdUVGbHdNZkxUU1VjYkRB?=
 =?utf-8?B?aXN3bkJJYlBJQVNOL1pkd2JzbUpyUXFWNlkwdlorRVNlczFLY3BDMU9aZEpC?=
 =?utf-8?B?Q2N1Qm5IUEFKUUNrMVpiTVo1M2wvL2U0N3lJUytKclp1ZkVRZGxXR2k5eDBa?=
 =?utf-8?B?SUQ3cFJoUTEvcHVURHIyS1hCbTFJdytyRHVSdzU5d3hvTWsrcERQVytqak4v?=
 =?utf-8?B?a0hVSWZFN01TVExvWGtlY2poY0tjbXdLbUdwOVpmK3YyaFMzWEdOSXBnYmUz?=
 =?utf-8?B?bGlhYWluL0dBQnJqYzNSZjk2c3dqeWRRWUVWM1FkR1NKNW9oNml3ZE8xbUhU?=
 =?utf-8?B?NmVtekJTNGw0UXptdnZiR1VZZ2pYZVhpSXkzV0RmcWRVM0dlc1VHbUhzd1NH?=
 =?utf-8?B?R1NiSzJOY1hTeUNQenpuNVI0ZlYxQzVqK1l3L21jTnROanhvWFk4TjdjRkU5?=
 =?utf-8?B?K0VLc2pKQmhZNWVnREFhQk1FSThwT1E2anNucXdjS0xoUlpXUElvUGp2alEx?=
 =?utf-8?B?RVlRRE02R3ZsSSt3dmFZSlFWNjk5VzVOc2VwcHNkTEFhZ1dlOGdGdzN0bllo?=
 =?utf-8?B?ZCtIOHJ1TWk1bHNKSVFNRWhDYlEwUk01Q1JjdGY3QjU1ei9La01WdXRUbHdh?=
 =?utf-8?B?a21Wd0NNRDY1endHVUllVVRuYVBNd2taMFhoaDQxTXViR0h1cXRoMWpQMTFy?=
 =?utf-8?B?VFcvakROeGprN2VaNVJXL1kwemRmTFlCWEhsek14eFIvaWVqOFN4REpSUkI0?=
 =?utf-8?B?NXkwL0pSd1lDcklMc3JGTlF2ZEdLdG1xVjVzTlRGUDIrRURYSml4b0EwSC9p?=
 =?utf-8?B?dGpScHFBT3pYdHB0a0hicjAyakl5TXY0QjNGNnB2dCswcU9TakV4U0FDRkUw?=
 =?utf-8?B?bUNwbXdxN3I0SmtJRER6c2doZlJHeU5lZDJTUno4VEZlRVh3QUdJZTZwSHdV?=
 =?utf-8?B?ampkbzRzS2o1MEg4NFpLUUNjeW9oTmxsSnc2d0tvREFUcEZvM01TRUQ5eFRa?=
 =?utf-8?B?ZlVTR1gyQmliUGNpVHpTc1psU2FucEllR0x2NXFsOXFUM0N2TUtENUY5SWVU?=
 =?utf-8?Q?RjiH28CHj6wkp7+0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C425936048826440BF7FF0D963D5D6D9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gnrCRC1CarRiIDYT+mqot/M+swjUZeP8t1x5kGM4UT4X+xuYt082fV9x5ppXSHpp6hqbtEbobtANintkeSK8WsCl4A39wSkYBSwywo8zwgNShB/NF8AxFGmHT5Ie192LGUb2JaFcsS320nB+GnlpiF4LHqKwnBohaFtcTwvtkd97u+nXegpdeY+zvK3b+miGI9TvoGwXzRDIaiixZLw/xj0JroPAblNMZiip7T2Dd7/9HfImxvBiAtiAGmzf6y2k16F1i45otP79NqF/LSEzlMVZaCArEdg/r0hdPHcjiRl2GnoTF8edXH39uHcByD23N+Vidl8WJ7L2YuSBGSI109XASDMQ8iKTy4pxecDm5SWViIacJwnQ+l3VP4F5S5maEDu4xQC7cUBqVrY0Fb2fhKt3PbaW7YMGkYT+UpXSAWAgf0b6iuQF++nEnwygPCnby3uUvfdIqVhd7IxpeJzqoWWJQ2jPbkjcjF7WeBphzefLDnJCllw9cSE4O0L4ITIIS0Vj8zlaBuLhX+TjIiVczwnRvznnUKFv3No0w23ecVo8JKcGB9CL0sXXb/awY85sNimmPP9iKetQ5Ndgy2GGqYFXAliSDnPV2sQEOtcEZoo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c04c0af-1c42-48e5-c1aa-08de4f9ff9a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 16:56:03.8984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LfYnGeVEPKN8AQoxy/9RdXEqsPq1g2MEhrytO/PDCdxH3c/f7SeATYASpUzLSmn6mjwJepKJ40srCgyjJhN0Bkei7sstgqCDlvoZ+8Ycjy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_05,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601090128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEyOCBTYWx0ZWRfX+eH5xAkYcHgu
 Q4kMQMX3Td8mcNUYP99WD4otoOkfsxO7bE1siqMOU/D7V8J+YnxKZnmNDWYRK2Tp3Za3Af4gOzt
 wuN9Urzrrtr4DnpBGdwZ1HEQKBQRyBz83qhqHae0DTJpgle+kOIpd79Bd5Vr62t0FOIX6aIaEWV
 7BiwWpbMb1C9+jIVYrYrHVpf687iDKj6dSEtrop08SaJL0URL2H03VmvCnzbX1EcQ+G8ZuSX4kc
 qjQfnihWosCyZiJhatQAnGrfoe8x0PcS7VW+eiebozFUDpeIlIiRNxjY8pir4UY4GzxKmwfLQco
 X4BQnrhcvNTMFd7wCkt8kwpfQCNPmmKIBC7Av4Kjg7ihCszuYvqhe0OPTKGUeurroGjYhMq4G4z
 ShSrGTHnTM6UV4FhlwAMnIsEPt3i/OY05HU4Wu7B20ZOr3JeeN0oPQdOakBNTUUGlk4SGbg6pN+
 c374HIaNDXMP8dYZSzQ==
X-Authority-Analysis: v=2.4 cv=J62nLQnS c=1 sm=1 tr=0 ts=6961332a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9R54UkLUAAAA:8 a=yPCof4ZbAAAA:8
 a=MfPjsXya_v3dR3Q5A4wA:9 a=QEXdDO2ut3YA:10 a=16MAPSKLCI0A:10
 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: HCMS3_4kfqu4RVdnO0qtiF1DUTJJ_QVG
X-Proofpoint-ORIG-GUID: HCMS3_4kfqu4RVdnO0qtiF1DUTJJ_QVG

T24gVGh1LCAyMDI2LTAxLTA4IGF0IDE4OjUxIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gVGhpcyBpcyBhbiBhdXRvbWF0ZWQgQUktZ2VuZXJhdGVkIHJldmlldyBvZiB5b3VyIHBhdGNo
Lg0KPiANCj4gRm9yIGxvY2FsIHJlcHJvZHVjdGlvbiBzdGVwcyBzZWUgaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHBzOi8vbmV0ZGV2LWFpLmJvdHMubGludXguZGV2L2FpLWxvY2FsLmh0
bWxfXzshIUFDV1Y1TjlNMlJWOTloUSFKYjRJd2lRTGx3U0pGbHF2UkNpN1k1NHBFSVNFUUtYeVBp
QnRZWGVNNzRtYk9oQkl3S1V1UGdvNlJEV2ZmLThKcUpGdFZMOXQ3WF9QSml5NnZ3JCANCj4gDQo+
IA0KSGkgSmFrdWIsDQoNClllcywgSSBzYXcgdGhlIEFJIHJlc3BvbnNlIG9uIHBhdGNod29yayB5
ZXN0ZXJkYXkgYW5kIGFtIHdvcmtpbmcgb24gYW4gdXBkYXRlIGFscmVhZHkuICBUaGFua3MgZm9y
IHRoZSByZXByb2R1Y2VyIGxpbmssDQpJJ2xsIHNlZSBpZiBJIGNhbiB3b3JrIG91dCBhbnkgbW9y
ZSBBSSBncmlwZXMuDQoNClRoYW5rIHlvdSENCkFsbGlzb24NCg0KPiAtLS0NCj4gY29tbWl0IDBk
MGI3NDg1MmQxMWM4MmFjN2Q5MWM3MmIzM2M1ZGNjYjc1OTM0YzUNCj4gQXV0aG9yOiBBbGxpc29u
IEhlbmRlcnNvbiA8YWxsaXNvbi5oZW5kZXJzb25Ab3JhY2xlLmNvbT4NCj4gDQo+ICAgICBuZXQv
cmRzOiBBZGQgcGVyIGNwIHdvcmsgcXVldWUNCj4gDQo+IFRoaXMgcGF0Y2ggYWRkcyBjcF93cSB0
byBzdHJ1Y3QgcmRzX2Nvbm5fcGF0aCBhbmQgc3Vic3RpdHV0ZXMgcmRzX3dxIHdpdGgNCj4gY3At
PmNwX3dxIHRocm91Z2hvdXQgdGhlIFJEUyBjb2RlYmFzZSB0byBlbmFibGUgcGVyLWNvbm5lY3Rp
b24gd29ya3F1ZXVlDQo+IG1hbmFnZW1lbnQuDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9uZXQvcmRz
L2liX3NlbmQuYyBiL25ldC9yZHMvaWJfc2VuZC5jDQo+ID4gaW5kZXggNDE5MGI5MGZmM2IxLi5l
MzViYmI2ZmZiNjggMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L3Jkcy9pYl9zZW5kLmMNCj4gPiArKysg
Yi9uZXQvcmRzL2liX3NlbmQuYw0KPiA+IEBAIC00MTksNyArNDE5LDcgQEAgdm9pZCByZHNfaWJf
c2VuZF9hZGRfY3JlZGl0cyhzdHJ1Y3QgcmRzX2Nvbm5lY3Rpb24gKmNvbm4sIHVuc2lnbmVkIGlu
dCBjcmVkaXRzKQ0KPiA+IA0KPiA+ICAJYXRvbWljX2FkZChJQl9TRVRfU0VORF9DUkVESVRTKGNy
ZWRpdHMpLCAmaWMtPmlfY3JlZGl0cyk7DQo+ID4gIAlpZiAodGVzdF9hbmRfY2xlYXJfYml0KFJE
U19MTF9TRU5EX0ZVTEwsICZjb25uLT5jX2ZsYWdzKSkNCj4gPiAtCQlxdWV1ZV9kZWxheWVkX3dv
cmsocmRzX3dxLCAmY29ubi0+Y19zZW5kX3csIDApOw0KPiA+ICsJCXF1ZXVlX2RlbGF5ZWRfd29y
ayhjb25uLT5jX3BhdGgtPmNwX3dxLCAmY29ubi0+Y19zZW5kX3csIDApOw0KPiA+IA0KPiA+ICAJ
V0FSTl9PTihJQl9HRVRfU0VORF9DUkVESVRTKGNyZWRpdHMpID49IDE2Mzg0KTsNCj4gDQo+IFRo
aXMgc3Vic3RpdHV0aW9uIGluIHJkc19pYl9zZW5kX2FkZF9jcmVkaXRzKCkgbG9va3MgY29ycmVj
dCwgYnV0IHdhcyB0aGUNCj4gc2ltaWxhciBjYWxsIHNpdGUgaW4gcmRzX2liX3NlbmRfY3FlX2hh
bmRsZXIoKSBpbiB0aGUgc2FtZSBmaWxlDQo+IGludGVudGlvbmFsbHkgbGVmdCB1bmNoYW5nZWQ/
IFRoYXQgZnVuY3Rpb24gc3RpbGwgdXNlczoNCj4gDQo+ICAgICBxdWV1ZV9kZWxheWVkX3dvcmso
cmRzX3dxLCAmY29ubi0+Y19zZW5kX3csIDApOw0KPiANCj4gQm90aCBmdW5jdGlvbnMgaGF2ZSBh
Y2Nlc3MgdG8gY29ubi0+Y19wYXRoLT5jcF93cSwgc28gdGhlIGluY29uc2lzdGVuY3kNCj4gc2Vl
bXMgdW5pbnRlbnRpb25hbC4gSWYgc29tZSBjYWxsIHNpdGVzIHNob3VsZCByZW1haW4gb24gdGhl
IGdsb2JhbCByZHNfd3ENCj4gd2hpbGUgb3RoZXJzIHVzZSB0aGUgcGVyLWNvbm5lY3Rpb24gd29y
a3F1ZXVlLCBpdCB3b3VsZCBoZWxwIHRvIHVuZGVyc3RhbmQNCj4gdGhlIHJlYXNvbmluZy4NCj4g
DQo+IFNpbWlsYXJseSwgcmRzX2NvbmdfcXVldWVfdXBkYXRlcygpIGluIG5ldC9yZHMvY29uZy5j
IHN0aWxsIHVzZXM6DQo+IA0KPiAgICAgcXVldWVfZGVsYXllZF93b3JrKHJkc193cSwgJmNwLT5j
cF9zZW5kX3csIDApOw0KPiANCj4gZXZlbiB0aG91Z2ggaXQgYWxyZWFkeSBoYXMgY3AgYXZhaWxh
YmxlLiBTaG91bGQgdGhpcyBhbHNvIGJlIHVwZGF0ZWQgdG8NCj4gdXNlIGNwLT5jcF93cSBmb3Ig
Y29uc2lzdGVuY3kgd2l0aCB0aGUgb3RoZXIgc3Vic3RpdHV0aW9ucz8NCg==

