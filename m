Return-Path: <linux-rdma+bounces-13645-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F99FB9EE85
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 13:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBAB17AB896
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 11:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8653B2F7ABD;
	Thu, 25 Sep 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WwuYItAE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FEeCn3PP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2EC2F7AA6;
	Thu, 25 Sep 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799807; cv=fail; b=Qu81O6wUXiNrWUcqC9zY1UsUqMliw6wpYQvioTPoPPv3KSejLhbdXMWsD/J4WQgU/t5Gqg6m6ZUAcQPZ7dGJ3d3G2Yya3IV+xAzvfScZlEgvssczqQ3NI6AgOw32tgL7JCsM90JlO8FaydgwZ5sCgK8oXKU+8Or6LRiRNQv0aEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799807; c=relaxed/simple;
	bh=c7IS/q2f/MpPl9wAZS0KrYXT3kNaqNvF/P9sm3Sq3Us=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FHXY81N1vVnggg8WFx6eY7PECX9M5zUP8MHWCM2cWWQKimWtv+tFlu3iq8AhTKqrD3VxKJYXaArLDN6EaoOZhtbG5m5nDuvYGhbaVM6KLks7SxLDe8Jt2lchNe4JLSsl1HZED1HJU1itEf7FnfLh2KHTQ8Bj9O6naJPnUZ4+j7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WwuYItAE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FEeCn3PP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAtfRR026240;
	Thu, 25 Sep 2025 11:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=c7IS/q2f/MpPl9wAZS0KrYXT3kNaqNvF/P9sm3Sq3Us=; b=
	WwuYItAErWR/L2PkPhQcrsK8/vVlBbt8JTqBLbinoJeEiDmS5fM/0Ppsph2X0YyS
	Hu9cnI57dekGukEMavg6y94stl8RdlJOMph5YAIjKfZXTsiS+Vnly9DEHsA+SBbs
	J4rsNtnMb9uH5Vk111dfDRG4T5X7/MdkmCjxvAIWJ8rq97MsB1ZP6SX1tsVx0xsk
	GfI//xuZaPnH18aTHoEEMR8qdp+x5ua2pRIN3LxNp1PvPjiJSpPcmMZEuxuFbES/
	1fXVJ+QpgXGEk9pQoJEY7FxR88f3JYF3bq4viCd9/oGGcRQeEML3iueYg4v34KdN
	imig7i8Vl+nEuTCzbPzc+g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499kvu1q3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 11:29:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAig5E030381;
	Thu, 25 Sep 2025 11:29:52 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jqb4rme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 11:29:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjQ4lagPuTXKvL6z+SNEvwgCKrUdSEbH8cGEnj5kZWVdBHmA8btIsakxJJ08GyVU645Fw1xFU89P2BGLiRa+coAh8MGzv1z676dY1hSe5OkBHx+erNmLbBBfT8n9Mlh5gDDW3en40pUjps+rknuNLdZ/gtt48Mgr0EEpIDK7Y3sPOyhsdBzVGC5lQYh84Hi516xtO+sYAoGrovG2JH++YLFEHADGk7/13h3HXDZbGYNtOBoSEOu7qQ1pniXvSe9Ie71SbAsATZbWfzCBd4tso5Tx8AnWh5xrUGzMzwbWx7CRzTWJhljt3sxyXiC7fTM+ztzMLpoRRAGXKPmW3ImTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7IS/q2f/MpPl9wAZS0KrYXT3kNaqNvF/P9sm3Sq3Us=;
 b=Xu4CU4iw5MLzLLgL3qaWKD1xonhMeGf46NlF/Pmkr5A0/aKNwApk/GXqLE9ysmcYDC3lLZ440wsS5C7/9aAITLEuFPR4Kcy75AcIIcpmLpA/OCts0aN2CE0W+SOvrVDYWQ7hzXZxpIYjFTCSxPUQgrDFqlzc90BP0hnERRCA5O1qGBZTnl21Q0zCE+0ho5stVyfCy3VhkMZjpXKLkOOtIsnYbP2jSSECBFg6uNcce+JoakwxZKvn0O3l45RwynDLn9zAB/uFZHF4deu7hXrf9N/l0jD3fu72L81HHnuCStUGP9nxFWnwH1ea+3usLjIj6VdRsluyy5ABP/payzysSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7IS/q2f/MpPl9wAZS0KrYXT3kNaqNvF/P9sm3Sq3Us=;
 b=FEeCn3PP7P/LHoY7rjG2pEXXh5hfRBIfZKhro0tQOdIkc6RyLnoPxweGeHDgAjlX4/e4fZQLUp+anF9tFLGmcKKaNtizRo2sGU3OFYgi9zokO90246TR4sMxKItpjuxxGuB33709pKryI0YxyNeQu/XZhRRr0zTcrXIYx3LeiOQ=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by CY8PR10MB6465.namprd10.prod.outlook.com (2603:10b6:930:63::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 11:29:49 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%3]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 11:29:49 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Jacob Moroni <jmoroni@google.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Sean
 Hefty <shefty@nvidia.com>,
        Vlad Dumitrescu <vdumitrescu@nvidia.com>,
        Or
 Har-Toov <ohartoov@nvidia.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>,
        OFED mailing list
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Thread-Topic: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Thread-Index: AQHcI8zHdy1KL4KXCkyexoudDHS8M7SV4d4AgAAFLICADfC2AA==
Date: Thu, 25 Sep 2025 11:29:49 +0000
Message-ID: <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
References: <20250912100525.531102-1-haakon.bugge@oracle.com>
 <20250916141812.GP882933@ziepe.ca>
 <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
In-Reply-To:
 <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|CY8PR10MB6465:EE_
x-ms-office365-filtering-correlation-id: 34bcd44a-bc7e-4823-26a5-08ddfc26d676
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0drRmY4elRudjhDTDRuaGRFTUYwbGZmNUpIT1BnVCt5M3ZwclE0dFhIY1VJ?=
 =?utf-8?B?V2Zha1NjWlFQT1lKTUlnbmxkVHRWVHhvbmM5QXQwVlBHdXJLVXBhMm1YMmhQ?=
 =?utf-8?B?emdZcGJJaGdXZnBEOWFVZU1zbTFTMzVKcWNoTnVXYkUvcmd2b1lYUXZ5WmEw?=
 =?utf-8?B?SDBiV204cEp5SnlvbEtwQVVqTEhIZ1RtY0VRNy9ZMHBDb2had0JqU3F5ZTdK?=
 =?utf-8?B?bkNlc0RRR3MrMnJ1aGc3M1lLcEtXN05LRXJBUGZZQ2ptZ25FZ0MrWjNBSW1m?=
 =?utf-8?B?ZFdSK1N5WjgwZmc5SUV4NDV0c1BMUytNTVBFdEV3L3Evd3FWQUlxbENjSnVG?=
 =?utf-8?B?cGEwSE8zWExTQUxJUkxoSnQyU1FVaTBBVjFaNGZJQW53TERneFZINHhjaVht?=
 =?utf-8?B?NFJrdWlDTVo2eEF0ZzdoQUpyeElTWHh1S0lSVVBEM21EbVMwNXlOQnA1azBn?=
 =?utf-8?B?ZkVUdkxoeDVvZno3Qks2a2FSQlA1bXJETnpjTEpWOWRORGhhTkhuY3pTSjEx?=
 =?utf-8?B?OHIxNkJQVnB2T1c3YWtIQU1RbkxGeEJDeEFQYkI3VHdvS1AxVGI2Z1J3T1JC?=
 =?utf-8?B?ZGJNeW9MSkx2cEUzTFhGWTZicEF6N0ZzN21qMFl2YXpaSnh1RnJsQW5MWFZ6?=
 =?utf-8?B?dG5HMVIraWZpaHJVWWc4cHZhM1Fhc3dCZXRCdThJbjdoWVRTdFdhbWgzb3Ux?=
 =?utf-8?B?WHFZbDlPWHJDY3N5VzdLVExCeWsrWUF0MTJYdG5KTnRUa1Z0M00waDBZUkJ4?=
 =?utf-8?B?cDlMRXRnSi9rMTFNT2RLK2JlWVFwUDAzSGxPVHYyN3RaamVsZENkQjZ4cVl0?=
 =?utf-8?B?NXhrazNna2VYbVowZjFmejhVUjA5cyswYWpsSzlFYUdPQkhuYUVBRkNreUsv?=
 =?utf-8?B?dkdFcGR1QzRmNXFPQzVOMkNzalNsN2lPU29OUEVoN3ZIeXpyMDcrR2g5S1Nt?=
 =?utf-8?B?NHM1QTJlSE9vUWUraHFBa3dxMm1naVdZTDlKTnBQVjJPdVBoV2Y3SHRNV3or?=
 =?utf-8?B?RlRvMnJpaVJLRXJKdnNGTUNjMkVXUk9MaXlhdFhWYVJwek0zUHBOTTR0M0sx?=
 =?utf-8?B?b3lIb1lWeHlkTkM4dmJqVnkzU2NNMzlEVzc2bW1Rb2NTY0tEMjkxU3BKWWVU?=
 =?utf-8?B?bVpoQmQyeUtBb04wdmRQVUYzRzRvOW52WDVEcEUrWk43L1owTVJSKzFjVkNm?=
 =?utf-8?B?ZHZsUXNoR2hxekVOOTI3Y1ZzczMwNDVvdUUrdG9rVE5rY1k3WnM5SlRQRVBU?=
 =?utf-8?B?RXdtQitrRVN5RG05aHY3MkhnMFlyOWpSTHU3Slk3SzBuT3lta0RCQW9rSUZF?=
 =?utf-8?B?VEtVT3B3bThTQWZHQ1paVU5VWjlLMWJoY1F3N2JDdUREMEFCZjQyZ0ZpM1Ju?=
 =?utf-8?B?R016YnhlQ1FBK0tWMG53aHFSUFBiQWxXMFBaUWZPUzZTMlFaOGM4SXdsSkRs?=
 =?utf-8?B?SjBIL2l6SmgrWXg3S3BBTXZiK3ZhNFR0NEJRT0pQbU1PUDBnSjU0WE92dlF2?=
 =?utf-8?B?dll2YlF0MzJGQXhaREp5WVdOQkNIemNqWW00aFlrVHFwcEppRUorR0RwaXhL?=
 =?utf-8?B?S0ZESk56UE5TbWdrV2lYQVJCTWRxWm9BZGJFcUtwZG5xL0RnOFN2K3ZoTXlB?=
 =?utf-8?B?MVR1TEp2SWNzajM2d3N3RWdhMVBRcTdnd3ppdUhIRWpRNENEbmVQc1FNbVgz?=
 =?utf-8?B?bGx4Uys3YllYbnhVakowVVJzRzk2MnR5YmRlRjVlZ1VkTzdBOGlJZGRQVER1?=
 =?utf-8?B?UzVZaDZBaWVRa2RYeTdZUmp4SDhHUXBZeVlHNm1RMXE5OVJ5ZTNZcnhrem1X?=
 =?utf-8?B?K1RPdVVDRHdSY3I2TFA2NndVeFRRamJXaDBVdFROOWdRZWhSZUJZRk9LY2pO?=
 =?utf-8?B?aWV0WDBhYXhjMWNVRUcvMkZaMWlWLytxMGlOWTBlTjFSSVVTVk1SWlphVW1s?=
 =?utf-8?B?V1ZVOHVjUzhITnl4Lys0cm1jalhKMDFMazZXMGZIc3RaU0lYSFozSW1USVVx?=
 =?utf-8?Q?adBDPT2BzcwrSK3SDOOxXrK8aqSU0s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWkvS2REQUQrMHJJdWtwN3VBQlZHWXZsL25XV3RoSkROSXBVVkRwUVdHcFdN?=
 =?utf-8?B?d3FNeUpDRlg4aUZMUHBKbVBxMnNjNUh4bHFZam1FRk5adUJCUENmSE94VjJz?=
 =?utf-8?B?R0VibFlSdVRsMnpyQ3Jxd3dDdzNST2ZrYXRhVzEyMlNJTkRkUU1mOEJndzZo?=
 =?utf-8?B?VzRrbUlvNlRndW9XaXY5aVpqZlM1SFB5aXpjQWZFeFQrdnF4NG40MHpaQm9u?=
 =?utf-8?B?R1NjcGNySXZ2TmNFR3BQMjZJRVM5REYzZ05tQUpkZ1lIbHd6c1VSTGJxaU05?=
 =?utf-8?B?S1hFTUxweUhaQURQenkxeWkwVVA1ZUdsYm5DMDhEYmhwVyt3WVg5c0VRNFFr?=
 =?utf-8?B?Njc5WEQwVm1xY25heFk1eWh3aFBiTUI2eWJIU2RnU21iRXQ4MVZPSHAxUnl0?=
 =?utf-8?B?WkQ2OC9mK0JweXkzSUIzNVhGK2FsR2k0azlFL1ZFZm1sb3YxSUtHRHBRMW9z?=
 =?utf-8?B?RmdQdnNZWUhnMW1rMTRxWnV3VzhNMjdaZ1VJZGhMRkh4ODE4SUdrSG5MdElZ?=
 =?utf-8?B?MDdkTjlWRWhZQjBpUlovVmt0ME8xaE51Vk50S20yRXNEYU5TZ3M3T3FaaWlz?=
 =?utf-8?B?bWZBbkNYbTdUYnAvWGc3bllydGtSaU5tdzdTRzhMMzVaZEFNRDAwQVA3NmpT?=
 =?utf-8?B?Q1lnRjdIZHBnOE1kV0IrV1doVkhsVDBFajQ4S2MyNXNmNGJHekY5UlVvWWJ5?=
 =?utf-8?B?d3grRE5oUmxGTVBjWTVrNE1WQ1FERDEwYWthRG9ZSndzVTdKaW5FaG1YbGUv?=
 =?utf-8?B?MFA5aStzTURzOWhhemRCNXNYYUJ1VXpyWURxV3E0L2lvYXZrRjcxYVJwSWFx?=
 =?utf-8?B?MlBkd1dBc2ZCK3V4OXBnZ3ZQaHNCVysxMDBvVndIa1pINjVZVjIwVjJXL1dG?=
 =?utf-8?B?dDRUR3BaamQxUHZVQkZIR05UdURjNHFCdVdmSUJBQkpiSFZ0eGtzcVJ6K1JN?=
 =?utf-8?B?VnBWUWV2cE82WGRaRk8wVVdPYWtqeTRFSnZScXBWbzFaVjkwbk13UkhoTnFS?=
 =?utf-8?B?V09HdmFOZ2tPTEpBN1hmRWxlaUFsK2ZhTXgrU0JCbURoL3NINzhQMW5YUUdo?=
 =?utf-8?B?ejB6ZEY5UnB3Tks1bmRpdUUxU0tMUDNSTjhQbVJHUElNejNOTXQ5c2toT01G?=
 =?utf-8?B?ZWRIeEczRFN4Y2h1bEVacnpSM1plYllFaGxYSjZEVlBRZFJ4S0pVV3RNRGkw?=
 =?utf-8?B?Yzg0RldQUzFMU3VoU1NrTG8zZGZPRndzVnE5LzcxaGlZd2ZwQVQwYkczWlRk?=
 =?utf-8?B?NXFNRm5EV3gyeVFLWTIvY0JVeUwxQUo1R3E2ZWduYUhjZ21PbTJqNS91RXQ1?=
 =?utf-8?B?S2V3Sm51ckxOODZmMzcyRmo1Wjc4bE13UWxZSkNpSzF0K3ptRTV3dDJYdVFY?=
 =?utf-8?B?WkwwZUNIc3poVVdERFA5TDJEek5wZ2pyTXBQOG1JNzZQNkJXYXl6Q3NYS0xa?=
 =?utf-8?B?bHNNV2V5WkVYMGc2N3hISnBmNGVISGR6OFcwalNvVWZoV0FtdmZIUFdsYUd5?=
 =?utf-8?B?NW1oYmVLWWk2ZmdUSkxnVXI1a1BQeUZiam40Szl2NEFnM1FCTzF4SlpYNFA0?=
 =?utf-8?B?eXpiSmxvV3RXNm4zNFNSblJjN0plSWlKcFU2VnVkR3RmWEQ0UzdFTTJ5eEpo?=
 =?utf-8?B?SmFIdFhOYkhmcEY4aDBCeDVhTUZlM1kwY0lIcXFnVUlIZzlzaWhVSTZ0cy96?=
 =?utf-8?B?ZXZJaDZ0T0hQQ29PdjVubW5NQUFrbTFndndkV2Z2YjNlZnpVdGc4THo0T2Rp?=
 =?utf-8?B?UTdYM3dMUVNmWk56SGdkTUhITVZ1YXNpUWg3bk02WC9kUFBteUlOZDkvYWtX?=
 =?utf-8?B?OTlsaURhUHRvNWEzb200ZGJ2NkdZenJhUzFWTEp6K0pEY0FpWVNjWGJEb3Bw?=
 =?utf-8?B?OGJidTFiMkZ4YTg2YnRyUURHbGRBczd3WENmKzdLY1BLVGRWMHlEYzcvYURo?=
 =?utf-8?B?Wk42cWllclNYQ0RxWXhsMmxlb1VmZEd4NXlSVllwZytxZ2JkT2ZCcEFNaU5F?=
 =?utf-8?B?UHFQRGZudStGZ1A3K3ZFRmVnL3U4c3l0b3FoYmZxb1p6NjJjb1Y0aUNINmJW?=
 =?utf-8?B?aDBXNmt6TGcrNk9OeXE3M2JPb2FQMUdUSTZNOHM0dnBIQUs3bHBPbmNDczFH?=
 =?utf-8?B?OEFGYmJjOWJFeXRFUTM3U3hNK0ZybUxTSlYxQysyVFNUVWtNNjY0N0pXL3ds?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65CC9AA3E6128242B0E436BC56431602@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hwOnilCyNBiF3jgQGZ+x3R3jF+QyfdxUqmtE7TyjfqIMlu1m7piFPxpZfbZBU6655P6pJJIvRbSkv1gV7axvGBJgpfDiR4pNNjaWg/HycpZkFCxF5E3qn3FUz2LpDL8wuvkce09Pps8oy6oMGWdX1bi7GLkWmNGARNWApq+gM6XJjJ7aAN2N+eAIBWhb1ESm2Z5g4hYdtT3GRaC36h8mJOqSbZov4O4ymLXW/z+1ThExGwJNar642YsgTVgH88/oY53U2WMsrZYeJEiNyJEXbSe17/I+O9kRrhvivartlohd4lLs7y/zs3Bvuy72GoJJ3fEHNa5pTXRoaCHjuX5rMqPmx6dJGxWuS38DYDZ0ugzs91ZkvHhsQgd3k/YXN5FtN1y5rW0LOERvZS9/ehi8aMuXKRXhRikjMKhRP4F7Yyz4X6xRMY+0KcgaOZaRx+sgw+xnVA540XkC0Gc047+1n15m50N52F/YJghcDrUFJoWcmh3MehsZUn/tm1BlcLzN+eh1sVVm7U3w95+TvrNOm7dfnB/dB/0rKJyPb/Y0NP3bNKJeSCM38Vab04XMBzn0IEejMudpx+wxTAPgG3pGmlC6HhU6BiIoEfcQ16jdcXg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bcd44a-bc7e-4823-26a5-08ddfc26d676
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 11:29:49.3112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFPk+eXsAgGytDuesQHqtT+WowEBjI9Ub4yfdrqDy/W5xpq5da4iIe1msmhRFpwJ10gjj39+3Qs45MqfHg+3IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=977 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX3xqitPE2vKYW
 iRFw0nLsjA7OU8+i+IOQaV1q6onmoa4YZeRoTLFK2TFaBuWnGdsSgNPi7AbbiRxvErionMfTU2W
 l6Tf27URjNV1ulI3+sT4j5wI4GkQpWbHCYimCxxzOe9VBCD2WbbHV/qiGA9gQ2To4O23lvfH8Dm
 Q/BmTlq9QVKzyddYDBTUoUodTVef7c/BLwKC3H+icjrr53KMS87wSF16lCcA8e/SWaDURUu4XsE
 kw2WXZ0TRolOYgL+FYRVtpAwviVkFAT9HXrM55z81CifPxgUsuOnnrr+aVunYHeunAqV5pXELcf
 bQTr9QOq7HXWqyd/chsTczYELEMHqwNJqUeaGprzjXPI8QrUakWer6jEdhZBEO4aAIm85lYNIch
 EwES4Xbt
X-Authority-Analysis: v=2.4 cv=UPPdHDfy c=1 sm=1 tr=0 ts=68d527b1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=1XWaLZrsAAAA:8 a=vZ8Edy66b02TGOUE5e8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VDAcCCTb9-W8QXecFWVYYQUyFu5Xf0-h
X-Proofpoint-ORIG-GUID: VDAcCCTb9-W8QXecFWVYYQUyFu5Xf0-h

SGkgSmFzb24gYW5kIEpha2UsDQoNCg0KPiBPbiAxNiBTZXAgMjAyNSwgYXQgMTY6MzYsIEphY29i
IE1vcm9uaSA8am1vcm9uaUBnb29nbGUuY29tPiB3cm90ZToNCj4gDQo+IERvZXMgdGhpcyBoYXBw
ZW4gd2hlbiB0aGVyZSBpcyBhIG1pc3Npbmcgc2VuZCBjb21wbGV0aW9uPw0KPiANCj4gQXNraW5n
IGJlY2F1c2UgSSByZW1lbWJlciB0cmlnZ2VyaW5nIHRoaXMgaWYgYSBkZXZpY2UgZW5jb3VudGVy
cyBhbg0KPiB1bnJlY292ZXJhYmxlDQo+IGVycm9yL1ZGIHJlc2V0IHdoaWxlIHVuZGVyIGhlYXZ5
IFJETUEtQ00gYWN0aXZpdHkgKGxpa2UgYSBsYXJnZSBzY2FsZQ0KPiBNUEkgd2lyZS11cCkuDQo+
IA0KPiBJIGFzc3VtZWQgaXQgd2FzIGJlY2F1c2UgUkRNQS1DTSB3YXMgd2FpdGluZyBmb3IgVFgg
Y29tcGxldGlvbnMgdGhhdA0KPiB3b3VsZCBuZXZlciBhcnJpdmUuDQo+IA0KPiBPZiBjb3Vyc2Us
IHRoZSB1bnJlY292ZXJhYmxlIGVycm9yL1ZGIHJlc2V0IHdpdGhvdXQgZ2VuZXJhdGluZyBmbHVz
aA0KPiBjb21wbGV0aW9ucyB3YXMgdGhlIHJlYWwNCj4gYnVnIGluIG15IGNhc2UuDQoNCg0KSSBj
b25jdXIuIEkgbG9va2VkIGFoZWFkIG9mIHRoZSBmaXJzdCBpbmNpZGVudCwgYnV0IGRpZG4ndCBz
ZWUgYW55IG9ic2N1cmUgbWx4NSBkcml2ZXIgbWVzc2FnZXMuIEJ1dCBsb29raW5nIGluLWJldHdl
ZW4sIEkgc2F3Og0KDQprZXJuZWw6IG1seDVfY29yZSAwMDAwOjEzOjAxLjEgZW5zNGYxNjogVFgg
dGltZW91dCBkZXRlY3RlZA0Ka2VybmVsOiBjbV9kZXN0cm95X2lkX3dhaXRfdGltZW91dDogY21f
aWQ9MDAwMDAwMDA1NjRhN2EzMSB0aW1lZCBvdXQuIHN0YXRlIDIgLT4gMCwgcmVmY250PTINCmtl
cm5lbDogbWx4NV9jb3JlIDAwMDA6MTM6MDEuMSBlbnM0ZjE2OiBUWCB0aW1lb3V0IG9uIHF1ZXVl
OiAxMiwgU1E6IDB4MTRmMmEsIENROiAweDE3MzksIFNRIENvbnM6IDB4MCBTUSBQcm9kOiAweDNj
NSwgdXNlY3Mgc2luY2UgbGFzdCB0cmFuczogMzAyMjQwMDANCmtlcm5lbDogY21fZGVzdHJveV9p
ZF93YWl0X3RpbWVvdXQ6IGNtX2lkPTAwMDAwMDAwYjgyMWRjZGEgdGltZWQgb3V0LiBzdGF0ZSAy
IC0+IDAsIHJlZmNudD0xDQprZXJuZWw6IGNtX2Rlc3Ryb3lfaWRfd2FpdF90aW1lb3V0OiBjbV9p
ZD0wMDAwMDAwMGVkZjE3MGZhIHRpbWVkIG91dC4gc3RhdGUgMiAtPiAwLCByZWZjbnQ9MQ0Ka2Vy
bmVsOiBtbHg1X2NvcmUgMDAwMDoxMzowMS4xIGVuczRmMTY6IEVRIDB4MTQ6IENvbnMgPSAweDQ0
NDY3MCwgaXJxbiA9IDB4MjhjDQoNCk5vdCBpbiBjbG9zZSBwcm94aW1pdHkgaW4gdGltZSwgYnV0
IGEgNiBkaWdpdHMgYW1vdW50IG9mIG1lc3NhZ2VzIHdlcmUgc3VwcHJlc3NlZCBkdWUgdG8gdGhl
IGZsb29kaW5nLg0KDQpNeSB0YWtlIGlzIHRoYXQgdGhlIHRpbWVvdXQgc2hvdWxkIGJlIG1vbm90
b25pYyBpbmNyZWFzaW5nIGZyb20gdGhlIGRyaXZlciB0byBSRE1BX0NNIChhbmQgdG8gdGhlIFVM
UHMpLiBUaGV5IGFyZSBub3QsIGFzIHRoZSBtbHg1ZV9idWlsZF9uaWNfbmV0ZGV2KCkgZnVuY3Rp
b25zIHNldHMgdGhlIG5kZXRkZXYncyB3YXRjaGRvZ190aW1lbyB0byAxNSBzZWNvbmRzLCB3aGVy
ZWFzIHRoZSB0aW1lb3V0IHZhbHVlIGNhbGxpbmcgY21fZGVzdHJveV9pZF93YWl0X3RpbWVvdXQo
KSBpcyAxMCBzZWNvbmRzLg0KDQpTbywgdGhlIG1pdGlnYXRpb24gYnkgZGV0ZWN0aW5nIGEgVFgg
dGltZW91dCBmcm9tIG5ldGRldiBoYXMgbm90IGtpY2tlZCBpbiB3aGVuIGNtX2Rlc3Ryb3lfaWRf
d2FpdF90aW1lb3V0KCkgaXMgY2FsbGVkLg0KDQoNClRoeHMsIEjDpWtvbg0KDQoNCg0KDQoNCg0K

