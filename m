Return-Path: <linux-rdma+bounces-5019-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631197D3D9
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 11:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C58A1F24781
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D6D13B580;
	Fri, 20 Sep 2024 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="axvEKtAg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CmLwxXgy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560FF1DFE8;
	Fri, 20 Sep 2024 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726825584; cv=fail; b=K+cNaNRwK1B69bo3z72VIEt3QleHV9SwZF/3U49+biBZxEOJJnKlTtUSnS/hALDkBrIBBwoNd1TywLPQKggrXxXWbvLNKJMUvjPNftKMPNXJSQWiGaorlpg4iidWKDZqhQgbX5bUKVnfziQGzTrO2luDLyvnUdSWb5Hqlmcvc+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726825584; c=relaxed/simple;
	bh=UPYpkVPVC5YCJZ1Uuq5l3RiZAf7nyXR/bpLLDyFiBVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BeLDE7BWDZfvNPDy2f2Zz12RomKsxqVS6drCgqMHzPaRgHLvmnYkCgvZzkSqN3Fq150LKm3nIfRiWe0/3V5w542LJB7YRa2Cv7X6/EkPyYKWdqMk9rCxc47RttWy6JzNSAI+NMum+LGyCrlz62cH2RidD4EJ/DQslViO6pMhcZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=axvEKtAg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CmLwxXgy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K7tZIZ031636;
	Fri, 20 Sep 2024 09:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=UPYpkVPVC5YCJZ1Uuq5l3RiZAf7nyXR/bpLLDyFiB
	Vo=; b=axvEKtAgqC5Vbk4B0it5cUYYo86tZlc0NtyhTrhEGBIwxnelQgIQtadTQ
	x+aePKSsTUF+nyPZ5UOnt/ZNlGklrsw2uPCNHASwCuOR0f8uRqi/+s4zP5Auua/N
	7RfO/HVrmo3TsYkhx/Z9XyKdkSfoqdtsXztUDu5olqzggvuBscSFD646uZm/FKHa
	s1ShXBAS32+mVvdOZ4E+hUGhEahZ6/JwSi6kLUqDa8ROX9wem91Sq49yXcHUEBTV
	kbNeG956Prnh9Zgma4vEswVpqX2lJNpU+CvbOqBwbia4FnH5XDPjC48NyY4tJQqq
	XDXkKB49fedLhR25aoFrchBqgq/vg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nspevr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 09:46:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48K8L0WR011097;
	Fri, 20 Sep 2024 09:46:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nybavs4m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 09:46:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpiF4C6M7WmDtHZYGPOassVj10Q7E4tZCT3871cSWDUUdCBUTzecj0X6zaqY7XiIzauWF/MEe72m2tLE0nFlpWKefoqhuKT3qV9JuorE5bDVHU6ZPIBibuIUsmMUH+E4jqgCch7NWdg5R8n1ryNm3+Ky7OmsiYZTvPh+3iJmW6Dua/uNRk2O4yH9JeEcKMjLOaTOCmSLA/Q/Y83YcLqjeV0KzrW8aWy94sEGYRm6mYErFXz4YdNsqYb8h5PH3rIiswMlVyFHNzE7IUTT4Lry4aaiRr4cuRjy/Fof/pcrGzsKlf4dp7eEQX+brmhP4yex/TCPIiqaG5gPK8+iTcKOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPYpkVPVC5YCJZ1Uuq5l3RiZAf7nyXR/bpLLDyFiBVo=;
 b=Yzo4lS0FugsSln3Due8rB6+CiaTb8i1TdhX7wE7YXAO0ZkYpkt5gq2cHp2LoGWJk0zVCCjspKy+Tdol1cS1dj1L/REyEFWaXb74q7dh4OeM91tt/WqvnrA7vtcENPN0oVo93yXwf9BRPFTYS3lP0ZgRvQDczDalcqx2m4/+5e6jDcJfMcudwK5h4sP0KZxmSz6UeJEq2kAXH+5rP4ZKuPQag7yQKW3TWIdT6FcHIGlludMDxL5Wx5ko8Am3M+zkz/92K/OsZVTQM69yQj94mkVEYe+R/5c5lZipjD0rH+Sabt5Dgn8EK2g/9oOJ5qvgF50Spwndm0H2kupwSfX6tUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPYpkVPVC5YCJZ1Uuq5l3RiZAf7nyXR/bpLLDyFiBVo=;
 b=CmLwxXgyHlLfPEJ3654NArsaasJMA25HhXXgHLhGjg4Tu3KXixMl4RL0H6hrilVqR4Tw+cyOXTv6i0+LUkemOyTD4NzW/qSTJn3/U6qn8n99b9euYmv+W1/T/YNXYF8kx889EI/f1CRbyDwR4flAELeOHnkIifTKl8/lUisrLew=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by IA1PR10MB6710.namprd10.prod.outlook.com (2603:10b6:208:419::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 09:46:07 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%4]) with mapi id 15.20.8005.006; Fri, 20 Sep 2024
 09:46:06 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Allison
 Henderson <allison.henderson@oracle.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        OFED mailing list
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>
Subject: Re: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
Thread-Topic: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
Thread-Index: AQHbCp7A0vkWwunDUUiiivGPdE4MvbJgbooA
Date: Fri, 20 Sep 2024 09:46:06 +0000
Message-ID: <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
 <Zuwyf0N_6E6Alx-H@infradead.org>
In-Reply-To: <Zuwyf0N_6E6Alx-H@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|IA1PR10MB6710:EE_
x-ms-office365-filtering-correlation-id: 76e06b29-1a8e-411f-4eec-08dcd9590ccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFpXYVVPY1NPSEZLUjdhWW5QbWdUbTJabGRRTmtrRnVtYnZCR3kySTBML2NQ?=
 =?utf-8?B?V000UHQzZkJLd0dDdWtLbjNITmNobzJRbnVIdDZkU0QreDZjSmRxZmIvVUY2?=
 =?utf-8?B?dHQ0UTJlbVk0TmtqQ1JjNHpBdkUwUWtKNzFDT095S1lYekxDWkJSZzByQzc5?=
 =?utf-8?B?NmNwSnVMZktkU0UyKzJUcVh3bW1IZkVFWkxsT1dVWDg1T0puVGpxaSsvdGVS?=
 =?utf-8?B?VENvN242NFZGNmNjSk5BR0VHOG9jRnVqN01sWjNZbmk3bGxHR3diN2Q2Slh4?=
 =?utf-8?B?MUdxaklwUTRzeTE5R3pueE0xV3E4Zkh6MzlDTGFIR0ZQTHhXVHA1cUpwelJz?=
 =?utf-8?B?U1U1VjZGczlpZnJ3b0RXTEh4TWFiQ2ZWVUR4QUxqTldMaTF5cWUwazNueU50?=
 =?utf-8?B?V3NQU0xaKzlYZFkrcnVQeTlJQzJLZGNWK1RyVlQ2aVZsUndpVnNJc1BjSk5W?=
 =?utf-8?B?NFJHY0Fhak1qWWx2MXRTcy9GaUVkcG81RlYyUm9uaEYwaUJYc20xQVFzNmhy?=
 =?utf-8?B?YnlLRnVBaURITEJWK0ZJeE00aVBsTmZScU9iTjdTUDV6TjVJaXZybUtGL0dm?=
 =?utf-8?B?S1VWdFVkUGg5WEpMR3hXKzNFRGo2WnJMT3Y5Sk1tKzZxUGwvakt2ZmplMWww?=
 =?utf-8?B?LzhYeEFIZER5dnYveHNzaXpzOUx3TG1zMDh4cGw3MVZUQ0NpY0N1aGtPZ2pO?=
 =?utf-8?B?dVpmNU02SlA0V1V6d0NMUFFjeTFEWHUzOW1qRFE3NGMxMmQ5aVJkK1ByQlI2?=
 =?utf-8?B?eUhRdWJFNTh6bUpyTTBjZEhZVHdYMngwRU0vcnlYT1JkUlBwSDdTMyt5ckRR?=
 =?utf-8?B?T1k0Qmx3VFZrT2h4UTUzTHZhZ1A5V1hTM0NWMzg2OXl1anY1UkJLM05KaExD?=
 =?utf-8?B?ckVOMERxSmg4eGdKaWdnaFlQS3FUZDFLdFFWM05WUmZqR2p3Q01MNTFLZEhE?=
 =?utf-8?B?T3dndTlyUnU5UStEcGpBc2hBTStrWXJPVUdmL1FPZDUrYStmVnhMNWZxY1U5?=
 =?utf-8?B?K1VPNUxCL2dDUzE2Y2lrZDB0SDNsRVU4WGJDUnFhSGFJak9RcEVvcUNqZjdR?=
 =?utf-8?B?NCt4dkwxUzZWUnZrTVl6R0huU2lwSTZaQmxheXlFeGpLWXREU0xIdE1Xd29n?=
 =?utf-8?B?T3l5SEFsblU1ZDdjK0Z0ck5mYmtIVjZYQVY5K3VZVys0L1ptS3JGL1VNQzV1?=
 =?utf-8?B?alJJSldldnBubWZhVmFUTFkxcjVHa003enhBejNzMU1ILzNndUl4aHliZzlH?=
 =?utf-8?B?OWVLZ212L1lyRUxkbFJ2Mzk1d3VnK2lpRnRuKzVhSmRSNTZ3dk5kbk5KMDZG?=
 =?utf-8?B?VTlqZjRPcWwzR0NaTlRSOVBRY0xrMjA1RmFkRXU5cUZUYW9wYTd2SzBQeHJY?=
 =?utf-8?B?RnhUQ2xLYzJUYXR5dWtLcUhjVDAxa2VwYXppTGZQQWtPZFA2aS9aRzdIRGIz?=
 =?utf-8?B?aEFJNmlaUVV3SGV0bnpibHRVMllLcGE2ODMzZUJ3d2wrb2thSC9mV2hvak5J?=
 =?utf-8?B?dGg4SWFIa2puenpjYVVYeDJ2c0FSdGMvODRzNmY5dSs0QU5yQW52WVdOSlFS?=
 =?utf-8?B?enVaMTRNWncxYlcrUTY0SVc3V3orZUUvRitXZ0VIMHlUSVlZRkwvSVl4SE5I?=
 =?utf-8?B?Yk9HTWJSYWRTOVhTbkJ0aTdXVVRFZTV0WjhIV0xjdUp5ZVlDYWdmemIvWVFF?=
 =?utf-8?B?ZUUveGdSRGJ0cFpSaG4rcDcvWXhqSyttaGJBdFRia29BMldwUjh2TFY3K3Qy?=
 =?utf-8?B?ZmIvdGEzMmlIbytvL0pqVllnRXhvdWl4Mzl0V0kxWW80K3oyV09ud3BsNFl6?=
 =?utf-8?B?d1RBS2JsTmhPWWt2cVJmZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RS9DRFVyMXJNcVJITTJOTUlyUWhhTWozYUJ4Uk84aGFlVjZSMFFxQlFodnBy?=
 =?utf-8?B?WEZQRmxnRVk1R2tsVi95OGlnZ01iRkJXbWFwUkpGbytVZ0cwcUphNVkzeGpQ?=
 =?utf-8?B?N3BuYzJ2TjMvelVCdjFrd0drOVQzZFZKNWR4b0g3SXZ5c01oV0ZMdlpMTWwv?=
 =?utf-8?B?UDllZ2RJQk5xTERrUy9DL0ZZM3IrZFBHcFVpQUdWYW1BSzlOSUc4V2F4RWNu?=
 =?utf-8?B?MjRQd091WUpEcGJSeU1ZMkx4TVVaZ3N4cnJUYjV6Q2lLck51cUN6MXBtdVpo?=
 =?utf-8?B?aml1RWFVZ3ZSemZBV0tRNFVtY0lwcFBkRnk2L3VkTG9tSUIxeFNoMVZHT1ZN?=
 =?utf-8?B?dFhiMVlldVZnT1Q0Q2pyQUNoYVUzYUlTL2c4ckFkcDdlcFFMSVdyOE1CRVF1?=
 =?utf-8?B?aGJGRG1jNW1mdlNBSU1Zb3dvdEhPSUc0WW5FZ3FQbDhhVzVGdGs5bFY4K1Bm?=
 =?utf-8?B?Wkc5U21UQmkvWnlnZUhFelF1UTQyd0RDRGY0VDJzYTV5c3RCUE5Ka1E3bGM3?=
 =?utf-8?B?ZHdGc3J0dFdmeGt0RXUzdGNhSGFLcVJydFNnWXdLbHB5cFFHZVB4d3Q4NDNz?=
 =?utf-8?B?S3VnWHMvMXU5QkhqN3IrZ2xzaWJXcXBEWXBQMFFCSG1zTldtRkM1aktRNGZ5?=
 =?utf-8?B?cWJwRmU5V0NmQ0dJSGJlcnMrTmFXUExhQTZxUGFHU2JUS3Y2aUhQOGhuRklK?=
 =?utf-8?B?ODJScVNsTkpjQ1FTaG50RWM2SHBTTUhyZnljYjFpRVAwVmhOemNDdUdoSmds?=
 =?utf-8?B?T2lybFpDRTNpMnI4YzdKaHNNcUtpaUpsTTErcXlaaFh1Tms3b2F1dDdxRTh1?=
 =?utf-8?B?N2lrMFV4ZHNKcW5MSStEejFvNS9FN2laRW5rZTFTT04wTTVnWHpyaDgrb1hs?=
 =?utf-8?B?d09ZeklXdFRqLzE5TGNEeWhnU1dEVXEwTEc3YzNub1B5YXVuOXc3bTQvcVVp?=
 =?utf-8?B?MlozUmxzdnU1U21XUUZzUVBEMWtSTWl4cXhTVml5NDFEak0xUERqWEJsd1RX?=
 =?utf-8?B?cTFCZy9HSmozSjRDZWlGM3VJY2ZYU1ZtaFQ3UnNGNHV2WkJPdS9uVTJORWpN?=
 =?utf-8?B?dFhwWndFdzFwU2hZdFlPUGtFWlN0RkUvd1hYb3g2aWZreWF3ZFpKKzZHZmNS?=
 =?utf-8?B?YldNNjBGTGY4MTFXdEdJdDJObXllbndGaG54MktWbXh5QUdQeUM1dTFEWlRW?=
 =?utf-8?B?SUFNUy9RMzdhWVJudU1NNnRDU095dUhUL0VIWjBrUDJOVCtEb3BVY0s4NVAr?=
 =?utf-8?B?L2VrS1MxRDN5YVpCdzVIVFJmRFdKa2FId2RqSnMzSWN4cWhXT1V0RUdSTWJE?=
 =?utf-8?B?UVBmTUswVmNlZzQyam80RG4rRmNQUmt3TGhSSkw2cHhMLzk4b24xZ254TEVl?=
 =?utf-8?B?eWx5V0MvckFZN2ZyWGxiVUpIM2dVcXc5em1JdEoxdDd0K0NzYldNMTBvbnhQ?=
 =?utf-8?B?VmFtQ2ZBK1FYRjFIOXh6dHFVVnNGV0I1TmdCRXFuMElWZW5MeFNkZFpROGJa?=
 =?utf-8?B?V1Exd0I5MkhadDJMTnJwQmpGdGkwVlVHb1dYU2lLU0lsbjRqdUNVVnJxVktJ?=
 =?utf-8?B?TXYyNVMwcEMxQklsNHU0WlJyZjgzQkhrN2JqeStMWndoeTlPdVY2UzhtWmk5?=
 =?utf-8?B?OGh4YzJQbWVKWTlPczQzV2tBMEtRSkx4bW5heitGc2d0cnhlRlNtQVY2SWVs?=
 =?utf-8?B?czhtWUZUamxBWEZoTEV5NmVwVWU0djhqdXhIV0MwbHhBbHd6cytxOFFoVFNs?=
 =?utf-8?B?UFpzUE5TNWl2L1NFODQ4V0Rvd1FtNzF2WC9MNnZGOWxRc2craFB1Z1RPekNI?=
 =?utf-8?B?byt3Qm1rNUd1WGZnOUpNWXYxemJqNTR1RWJuNHRGaGRtN3h4ZW56ak95aE13?=
 =?utf-8?B?Mis1cm04UUhIeFRRbGRnSVdkRjEyaEhQbnN6Yjd4V2phbUcvamppOUhuaXZs?=
 =?utf-8?B?YWZZeWpBRERuRFI1RXM1VWdPemJqeFNLUWpQSzloZnNNVjREa0E3ajBFZ2RC?=
 =?utf-8?B?UldBV3lKQWtvdGl2cjQ5Rlp3MTZHd3I5SVhjS0RVUDZpTnVGN0xhNmkvR3FF?=
 =?utf-8?B?YU1lbXhsM29nSk85N0NDeU9SVWxGR3owQW9ZNVd4SzVCbWMxVjlxQTJXcUFZ?=
 =?utf-8?B?Mkhxd2dQWFdBRVZlOUZlQnJxUjBuNFA0ZGczREg5T3MzRE1FYzFweVhZNUYz?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12A9D20CA58FB44DAF7A10DF647D879C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CxJs+rdrtq0ExlnWJqqpvtdxdDn04GaDtpPobXZLmnlYt3Nx+Gld3Sc4OlV7HaGuT/1eThrvcgvx2wIacfwwspcX70H2GH4YiVl80xXfvfdL29yx1+MtjV+aqH2ZAZxY25PLKok/wmgrZIkziFOFvdIgOk2JDQ/K+iIzBOWTMLMk/EIRxG2irxYWSsfBvsXcxr7x5MlQFZ0NOC+OpyVcIvNjHcFtW1jgfaDUVEtY3vdtgg4DsuBvtQr6u/rpLD3Jqz+szC+w9pqWxJpgW45m0G1Mwvakalq/8J0PMCT2pR4/35yOLZWY1M3T9J7S4NYwXBOUY/eI9XJBSEvROrRJpbHIzcyONhVvLAZ9mCMkuemkQDUZPGdxPD9piRITTyAp2IXNuy2Gao2otAJt5wtRFHZvEip7KzdXjBh/b72NYJ5VhBY78ySttlR9Sy4OeEQgWIhEWJdMru5sYLz3AJlQPqYXJRBt/nR5XIOLzjcw00/CfHnAvxAAIUVBC5JPlogAdVCuTZFWNUTQLTmU6lxofZKrZYbWg9hAms2KtAFsRZsAttq4QWkhc05jJWVS6f49qZ7v5gdcUhk30vQE43Rrbm9LRCaZz5S06Wh23bWd7b4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e06b29-1a8e-411f-4eec-08dcd9590ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 09:46:06.9114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3iWygsD2CYv96Nj5DNGqIZS+E6xhsTvsqCu9M9EedCElnwrtq3RVwY4notR7zo5ezyjhA78uhrPOZ/BOBbI+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_04,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=594 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409200069
X-Proofpoint-GUID: klJRCDyPmWvLXSKaH15jcO1NmcIZP8Dt
X-Proofpoint-ORIG-GUID: klJRCDyPmWvLXSKaH15jcO1NmcIZP8Dt

SGkgQ2hyaXN0b3BoLA0KDQo+IE9uIDE5IFNlcCAyMDI0LCBhdCAxNjoxNywgQ2hyaXN0b3BoIEhl
bGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgU2VwIDE4LCAy
MDI0IGF0IDEwOjM1OjUwQU0gKzAyMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IFRoZSBEeW5h
bWljIEludGVycnVwdCBNb2RlcmF0aW9uIG1lY2hhbmlzbSBjYW4gb25seSBiZSB1c2VkIGJ5IFVM
UHMNCj4+IHVzaW5nIGliX2FsbG9jX2NxKCkgYW5kIGZhbWlseS4gV2UgZXh0ZW5kIERJTSB0byBh
bHNvIGNvdmVyIGxlZ2FjeQ0KPj4gVUxQcyB1c2luZyBpYl9jcmVhdGVfY3EoKS4gVGhlIGxhc3Qg
Y29tbWl0IHRha2VzIGFkdmFudGFnZSBvZiB0aGlzIGVuZA0KPj4gdXNlcyBESU0gaW4gUkRTLg0K
PiANCj4gSSB3b3VsZCBtdWNoIHByZWZlciBpZiB5b3UgY291bGQgbW92ZSBSRFMgb2ZmIHRoYXQg
aG9ycmlibGUgQVBJIGZpbmFsbHkNCj4gaW5zdGVhZCBvZiBpbnZlc3RpbmcgbW9yZSBlZmZvcnQg
aW50byBpdCBhbmQgbWFraW5nIGl0IG1vcmUgY29tcGxpY2F0ZWQuDQoNCmliX2FsbG9jX2NxKCkg
YW5kIGZhbWlseSBkb2VzIG5vdCBzdXBwb3J0IGFybWluZyB0aGUgQ1Egd2l0aCB0aGUgSUJfQ1Ff
U09MSUNJVEVEIGZsYWcsIHdoaWNoIFJEUyB1c2VzLg0KDQoNClRoeHMsIEjDpWtvbg0KDQoNCg==

