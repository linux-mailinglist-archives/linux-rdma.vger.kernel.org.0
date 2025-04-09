Return-Path: <linux-rdma+bounces-9283-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12583A81A2A
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 02:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FC842857D
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 00:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6CF126BF7;
	Wed,  9 Apr 2025 00:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lQU/GOxg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pWQ5Qy2A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF19078F3B;
	Wed,  9 Apr 2025 00:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744160094; cv=fail; b=tnjSTHrc77IGCd/5KHGHgcaNVaG6EourmbQQuUXC7ir2p+pomuEEpY58bMY8JdzLxvNRQteQdFh3HKObbkVBCCUpfEGwWxsTWxxkY33Wy8RN/F9vn+XdUvWy1fzUP0lmYDW8uhYSf6Th83MUYIzFPOFxZjdgyD83zH4mnE4KRFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744160094; c=relaxed/simple;
	bh=fcXC4/LiLBedoK3jjpmg405SZ3bzOQiAgFRHz+fNYr4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BwDvMy145TB3JciR/iQqnqJRfdjBNQnjpNmYGx9lTm6VxVNa/xR8iicIfDGtX6zcjeehNB9uAQpuio87UQF5UdUXd+Z1SsaWpPmvWrFKUeQZ6CL3p+wO+OEvAkCBi073p9HGJXC09aRDPrjJWLuXGsvIp4c1bSKXIet/wvyQEyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lQU/GOxg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pWQ5Qy2A; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538L9mdg022946;
	Wed, 9 Apr 2025 00:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fcXC4/LiLBedoK3jjpmg405SZ3bzOQiAgFRHz+fNYr4=; b=
	lQU/GOxgVsd2+xHwKgYvLty+8jL6wr2WUJQ/wSuol0lNTzaFcXPK6AqailVGybmB
	m5/fpcEuC0RJr66w+d+gj0u2i8ggikAB8fHN5FdSpYcwlLKcgMTI1JgY+ROeBGr/
	/smIRkgk0Z6Ff0JWNPNrH5N6P1KaUd8cPZ4zZ6AJQ5cg3rw0fSwE4p7irox7VxOP
	aUHu48xg4zKFX3AAdfDOfKeNVBUUIE/igBUtrpQeuJiNspthTbgOKQwOxBndXlXF
	3YlnaxFTW1yja4qfQVWvz3zpizmTKZTx8ETdREaAzZ+hq64cHdWUEK31n1pVlnYP
	rqUGTPvTGa75yA/29iRqDg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tv4sx31e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 00:54:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5390awhb022238;
	Wed, 9 Apr 2025 00:54:42 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013075.outbound.protection.outlook.com [40.93.1.75])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyattm2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 00:54:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzwLMexm6mqa0NjZWu8Y2eOiH+vpixuF7EqxWlwVgq2lCA7vTvD8ApMpxwYkEtd+Xjzm5kKC8I811RsNtoXM0eJfGueVWvvJvUM2hfSAcUcnPzhFx/bkZpEdZjXEpdhXkxke8erZTzqEa2Hx5/eIHnVWchnWeqMv6BXtHu13hHAqAPW4F9ru+G75TB1SKK/QnhB/WnAIWJ4E0vA8OXWr+xvrPhLUcmc56M1HKQiakLz3E/O2XjE1yjo3RQ6N9/jGl8KRMu2zvz1TWxJC2shQW/57iXkGG6rQS5SF33DT8Kyl6BWA7gpCc1WQtSfU5mXL+XK7kB06afH+APRVUfusNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcXC4/LiLBedoK3jjpmg405SZ3bzOQiAgFRHz+fNYr4=;
 b=nUedKdHFckZSw3uEDwEWyUvr8f/5RgPy2XVvxT3no47DfOU5eWzKUBDyAyKwU1e1bcBreBzYyydiiyIw4obdb3gujwOoqLVMg6eQY8cB1KakgiNSCA8JF6UTx1lRVKvS0sFXUjgu9QS1r++DyoApWOH20e+5H9W9+RyWvyDwYHytalhHhAmc/CYVNQFZab045Fb/d5B5e6Bz6Je+r6WhQvNGJ+v7+z1KOE7SwL41txLGAlsKUr77mAHfRTRrZbgGtH5YnuogPbxykSq6K7V2s1qdSXHeAWc2QGQkcwXbdUow2he86oirY3wExls0nrLTgPOofcV0B3fQBfkZOceoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcXC4/LiLBedoK3jjpmg405SZ3bzOQiAgFRHz+fNYr4=;
 b=pWQ5Qy2AQ2EYezdObBZDAKLAQdmOqaDv5rAzWPyDjbnKoW+4lgSk3+d5gHA2ZL9sScC/5wktLC755OVEdwrsPRQYiOAop7xFuApt/rq2NbNqlYrf8cKBO/8hTFeMVIUbTD+qMr0e3wE7OmShQzUj9noOZAhL9GXl8a0MYPacbKg=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CY8PR10MB6610.namprd10.prod.outlook.com (2603:10b6:930:56::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 00:54:40 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 00:54:40 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "jgg@nvidia.com" <jgg@nvidia.com>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] rds: rely on IB/core to determine if device is
 ODP capable
Thread-Topic: [PATCH net-next] rds: rely on IB/core to determine if device is
 ODP capable
Thread-Index: AQHbqHYafWAy8/ulgEeCHU4H0uxDN7OZsTAAgAAC9YCAAAEfAIAAbeoAgABf0wA=
Date: Wed, 9 Apr 2025 00:54:39 +0000
Message-ID: <94c8e113c11ec18c5e9330d7f2175a4469518e44.camel@oracle.com>
References:
 <bfc8ffb7ea207ed90c777a4f61a8afe1badef212.1744109826.git.leonro@nvidia.com>
	 <20250408122338.GA1778492@nvidia.com> <20250408123413.GA199604@unreal>
	 <20250408123814.GC1778492@nvidia.com> <20250408191138.GF199604@unreal>
In-Reply-To: <20250408191138.GF199604@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHOBBMB
 CgA4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAme1o
 KoACgkQyD6kYDBH6bO6PQv/S0JX125/DVO+mI3GXj00Bsbb5XD+tPUwo7qtMfSg5X80mG6GKao9hL
 ZP22dNlYdQJidNRoVew3pYLKLFcsm1qbiLHBbNVSynGaJuLDbC5sqfsGDmSBrLznefRW+XcKfyvCC
 sG2/fomT4Dnc+8n2XkDYN40ptOTy5/HyVHZzC9aocoXKVGegPwhnz70la3oZfzCKR3tY2Pt368xyx
 jbUOCHx41RHNGBKDyqmzcOKKxK2y8S69k1X+Cx/z+647qaTgEZjGCNvVfQj+DpIef/w6x+y3DoACY
 CfI3lEyFKX6yOy/enjqRXnqz7IXXjVJrLlDvIAApEm0yT25dTIjOegvr0H6y3wJqz10jbjmIKkHRX
 oltd2lIXs2VL419qFAgYIItuBFQ3XpKKMvnO45Nbey1zXF8upDw0s9r9rNDykG7Am2LDUi7CQtKeq
 p9Hjoueq8wWOsPDIzZ5LeRanH/UNYEzYt+MilFukg9btNGoxDCo9rwipAHMx6VGgNER6bVDER
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|CY8PR10MB6610:EE_
x-ms-office365-filtering-correlation-id: 12c638b3-6423-44ba-797e-08dd77011bc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NWh3ZGpCeHc2anpLQ0JMNHlZemc0dzh0OUx5MVZUM1dUSXRwOFdRSVIveWYw?=
 =?utf-8?B?V0o5L1cvOXBvRnBPMGp3YnUyeWk0TmNUUGtiZ01pSWc3VE82cHBVZFcvZ3ZU?=
 =?utf-8?B?Z2RLK2RFVTlaY3lMZ282dHZkSkowU0Y1R0J4MmU4a0ZPbHU0cEtTbERMSnBo?=
 =?utf-8?B?UXFad1ZrMXIrSEhYb0tnMUdCM0o1S0wrdDVTZ3JGS2I5Q28rdmttUHBXamVB?=
 =?utf-8?B?a1JuQ0JqRE5LRHdMdUhEZ25GTVpGRGJON25wby9jU0EvcURGbU1sRWNPQVVi?=
 =?utf-8?B?M3dBWVQyMDk2clhhRGoxVEEycDBuMUx1SmdiK2laQk9iODRZY3FVUXliWndB?=
 =?utf-8?B?K1NaQ0lBaXBaS3NtRlQ0ay9WYUJXcnVrUTc5T0s4ZDh1UzlYaWY5bkkrQlB0?=
 =?utf-8?B?NmRNQ09ZbU5yUmllMFZYeW5odUxzbmo4UTBHK2VDYzZlVnFVeXp0MVRkV1Ew?=
 =?utf-8?B?VEdyTFJYVmhPbVFuWFRaNmhGcVo1NGxZYTlHcHNQc3k1S1NOMHo3WFdJNTdx?=
 =?utf-8?B?dHh6Y2Zza3djRGhPMDhRSS9HSmlCakgvSnhHOVhaemxzb3k0RG41M1F3M3BQ?=
 =?utf-8?B?ckJoTlNsa0w1TzhUWDh4SVpabytWWHB2K1JydGc1WjdYTlNiZ1U4T0N4dlA0?=
 =?utf-8?B?c3ZnM2tTc0wzbTk5TzNmMDByY2FEQjRmQ1ZGRkZ3dUJ1L05RSklCSktQT2RI?=
 =?utf-8?B?bWNDS0hkcEVYVDRPTXFEZUxVSi9BOGJreGt1K2FqNWJrMm5VTnVUZG40NHVk?=
 =?utf-8?B?SUVxQ2R5YjkvcW4vSHd5TXRYNEhYL2QyeGdBUmxwMlZGTVF1MjJIem1KWlov?=
 =?utf-8?B?SHFGenhLaEd5SkIxNi9zelN6YS9XRnhTeG1jaEQzeGpnOVRNWmtDZUpQdTZ6?=
 =?utf-8?B?b1ZHSUFPWS9QU2JOTCtrU2tvTm82Y2ZlL3JVdmp1MVg1eGlFeGxXVkJ5M2du?=
 =?utf-8?B?akgvaEI4V1FFVUhlZHFuWnUxS2cwNkRkYWY4Q2NtUmxPVFJlV3NNNG5WdFJz?=
 =?utf-8?B?bzBTeFNsbzJ5NVBCbGtuWGtmZ1FwU1pSUER4R3oyU1QrMm5VMnBNQlZDaTAr?=
 =?utf-8?B?b29DbjRuQklYd0Jsdnd4QVdub21ZTnRJSWt5VEkxMmRoT0lHOFc2ekJ6eFdn?=
 =?utf-8?B?d3RTNUxRbWtQZjNrVkNsMkJnQ1d2MzFTQnllSExubDJyWm9kaTduL3lTbzVF?=
 =?utf-8?B?SnRTbG5FNEhkbmlJcVI0czVGdE1LY2ZRTmZFNGFUMnNqbnVOWk80MlZhbHhC?=
 =?utf-8?B?TGdLZTUyNG5IR0tqR29hRFE4cU55b0JWOEJ3QzArM1pEb2lVV0dXZHlZUm1I?=
 =?utf-8?B?MUZUOXp2VGgvVG5LeVNBL1JTNDFsUkVnc2g3TEMrakNSRUFNRjhtZ1NDQVF2?=
 =?utf-8?B?MmFRMUEyaDdKQUZoMGFLbmdvNHVISytQcWNIWVgzV1c0QTRkeDhjMm5ua1lM?=
 =?utf-8?B?S0treVNYUHh1L3MwSjh6MjdmTUNzbUtvazRQU25Yc3BCamhVRlNtOEkyZnlh?=
 =?utf-8?B?dHozak5iYkVjVHBIQ21yaDhTK1lxOGkxZXpnSnQ2elBkamJTZnFrNXZiTkRs?=
 =?utf-8?B?ZjRrenJRcCs0V3V3RHhLKzFWZU04dm1CVjhZeG96ZmdickhYZVE4M3UrSmRk?=
 =?utf-8?B?TCt1c29takZTb3NqVDQzNjdONTFaSUY2VGYvRnZwa0FmSVZock9raFg0Rk1G?=
 =?utf-8?B?MXVRZm02b0xmM1VmdDFJZEduck80ZmhVWWk2Umw5N1JSSGp3ZW5hWVBtZ2hM?=
 =?utf-8?B?M0tVeHd4cUptRUdTN2RnZGVTQzViSmFhT3JtbjNxSnR0d05KOHhiRE9pb0pW?=
 =?utf-8?B?ellIYnBVRDFaVjYvaWVZVnQ5M21ieXQyNHJDa3BBR3VWNVBoRjhDQWFIVDhN?=
 =?utf-8?B?MTUzalhoYmtKbTcwVGQ2RzlhalBXRm1rRlEzOFFJZWw5eWFPOUY3N2lobWIz?=
 =?utf-8?Q?vwvRJaQiky7Xank5e6igWHnaXhjJnxVR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHJNMlVBZ0pwTGNlRzJ1UlFTRkYxZS9VMFpudVNtODU1ckdqT0NkQ2hkdEZN?=
 =?utf-8?B?TS83eXMxMXU1bWpHOXhWUUF6cVR3TDJLOGJrRTlYQmVkS01VZDZ1Q2dmR2Vp?=
 =?utf-8?B?bTVwbitZT2R4K0Z0QXVXYUV3UWFDdGt6TVFXV0J1bVAxc3JrZzRBUS9od3Ba?=
 =?utf-8?B?NjZFNlVNNXlMSGwvb2xUYTZHUHlJdGl3VVkzSXljQmRyU2lodSsxSUIwL2NR?=
 =?utf-8?B?ZWJ5VGk2VU5EU2dWekx1VG83TitvOXFBODJDSWM1NmducTV2VERYWE1XRDBs?=
 =?utf-8?B?dVduQ253eFE0VEloZDc3NUdERjh0VDVnS05RaWQ3ZkNEMFM4eEFUelJVMFkz?=
 =?utf-8?B?Y0pqUnpNSUhMTHAyN2M5UTBFeHFCTjYwNy9DSUovSFBONkQvUGhSWG1BV0Jo?=
 =?utf-8?B?SUFtVGRWQ0VXdG9HTGtISjN0b0FlTmRlTnM5U2E3Y29sWnV6QU1xZ2lNdHB3?=
 =?utf-8?B?T2JDaHVjNDVKRVBBUWNmUndBQTFzdnB0U2ZGREZxMXliZElyeVVydmRYcW1t?=
 =?utf-8?B?UnpMZkFmVUtDOTZPRi9abGoyeG1ZWFJnTnhjVmxVZ3BVVC90WkRCc2RtTGtu?=
 =?utf-8?B?eUVxNDFVci9hZEtKRUxxc3dQOHFxMXF2Q1VITm12ckQ2VmhVN2hITXo5NUVq?=
 =?utf-8?B?Zk9hRXdjSm93S2NGTUZSQjB5RUIra1JpdTlFOXRrT05RbiswNkxmSUU2WEla?=
 =?utf-8?B?QmIzL1VHbHpvUHlxVCt1T3B6aUhtNTVQbk9keVJQWHIrVW0wazZNV0ZOQ0RQ?=
 =?utf-8?B?NXMrSHQ5b1RYY0dldWQxdFFsb2dFQlliMTJDem1FREpWVE1CVUtsVFFUOVZQ?=
 =?utf-8?B?ZVBUVzV1R1QyVkp3eU1naHFNQ2ptM3c2WGlZUXh5dWFkQmpsbWtpbTA5anVp?=
 =?utf-8?B?anFkNDJMeE0zUTU5VGp5c1E2QUE1VWw2VzAzVkFaMjNaYlJTUVltVFA5bHRG?=
 =?utf-8?B?dVpoeHFlWVRTZ2JCeXNlbk81Ky9nT0N6ektCV3pPaTNObE9XaU0rY2tWOTc4?=
 =?utf-8?B?My9WNkxCSnBJTVpNdy81cUZiV2ZoWG9iNUdPWGVZbUE1Ui9UL3ByK0Vna0I3?=
 =?utf-8?B?cTlCT2NXNU1ESmFaQXY1OG9ObVplNmxBZG9pTWY1bS9pTW1nam1tM0ZzYVQ4?=
 =?utf-8?B?SVZ1c0hqeUNKSWloNysrQVNrUTAvZ2VEeXFQT0pLaHBVWGxQQmY1MVNGNlgz?=
 =?utf-8?B?M0ZqT2xpZ3h4UXBIUnNRamF1N2IwT29aQjg0UlpINk1RTHR0MzlMSzVBcldU?=
 =?utf-8?B?b2JRVnVkM3kyNTVzT2hMNG90eXZLL1F5Mm1TQmVwZ20wSmNSSW5JU0JJWE9H?=
 =?utf-8?B?UTJyK3JLc1pndWVTZ2lWdlZsajFzWFNxUUQ1dlRnMXBUWXllbkRKUlYvOE5O?=
 =?utf-8?B?R0hPTVlHZUNjRDZkelcrYk91OG9qaU1rTi9BQkZVSzBNQS9DYjNDZUorSWhn?=
 =?utf-8?B?TU4xYzdhY3pIeG9QVTg0dDhVSHRHU2VZRGI1dlFHdXdRVG5qWWJVbEE3bjY4?=
 =?utf-8?B?Sm94cVRnWW9KVTJrcEZsWTMvZ2hDV3FyVEY3a09SR3hrRVc4YmxHTVNMOHI5?=
 =?utf-8?B?Y1hRM1ZpWloyaENZaUhHNkxtVTFneUVBOFdlMEtCK0JwbTNWZUhOS08yQlli?=
 =?utf-8?B?WEY0V3Vmc0pQSkcyYTluNmgxSGpDMGw5ZkJ3bkhHVnl0SE1XS2RkWDRBZkdE?=
 =?utf-8?B?TlZDb0JITFJsZ3ZxMUViL01ydFVHZnBYQ1M0ZldITklYREgycFZRUE45cGts?=
 =?utf-8?B?cHYxZmVZRlRabFNaWXB3K0d0Y1lKMHFQN05zQnBmNWxXOExlSTJxL0w2eVNK?=
 =?utf-8?B?Kzg1S0dZdFlSQkI3dWlGOEZPSGh3a3d4Y1NqWEI4Q1RwNnJ5aGJJdE52dGND?=
 =?utf-8?B?VkdhK2ZnaUlBekUwRWZtZ3RqR1A3WDJGK0JpTEFuR3lCNFBrTmhQeWFva1ht?=
 =?utf-8?B?dzBRUTRoejBJWVh5ZzBoY2tNalRHSWFuZzJnYmthMW53UTBLRFRJUFdRVkhZ?=
 =?utf-8?B?d25HSHJQNlUzZEdKbWtOTVF4U0RJQnNtcDQvNEpUZ2g5TlB1MkxCaUlFMVBR?=
 =?utf-8?B?R1hTZ0ptdVNCdTFmbmEzMmhEdi8rblVmaVlGcGRvV3ppY1BLWUJVSmZqRmIx?=
 =?utf-8?B?a0N1ZTlodmhzL3BJRVg5QU44bS9kUHMvY012d2tLWFZZS0JVWlk0a1VlUm81?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6DB74790CEA3D429F7AD58BD247FA2B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wr4ovJ8X8+l/QSLu07A5G44RG5EnKTFW0F6qSf51oBAITPCSzHflW3/RHZf4FRAWbMmvmxW3h69lMkEyQjfC5u6q9ACYGBguw7QyYq/raKkpj6eoDpuSGyzvx14D51BwFEP5SxGn/Og8xGt05ZimFIyfiqOYaOIfWBTi6AjkeyA0/tYztvo2sr/OisCJy9yVV9dsFkwTbC6AV1r2Mp+bstRQD9Xi5CzUBJDj+yNSZbnfU3VtTM4BqSWyyu04NO72w3u9J5SNLlLXc7k5cD0A7MCPs9DXJfqQaxUeKRwTHufviSjWoPsoHWl2sAoTb+LauEdMXajh/ul55TUT6dB9jfFVwDGI5p7c6z/ANVLuStKp2eS12+wHLK9dzyuyGSHt127H4+qIIB8X2gVro+7zLMRlYl9ZvqFXDBIJZi88269Z5kuOM1ILo8h0aDECuN2Jg2Pj6LAsDUQAC0BdT0JggdrbtM8nulKRlPTmvEChRMnVoIlh5nU3DshBB9MEAdv1s2I1QOfZGXl9ZNWJJwML7nsqr9wxvA/CIcPHhGGJW/g7U91TkTI83Gff3buoyjTNQJKanGNUs8xzT8oIOi6L9/Z8qKxCDeP9TBrbXUB4ze8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c638b3-6423-44ba-797e-08dd77011bc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 00:54:40.0616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l72BFppaaTF6zhDQ2gtEAKIMuSAbo5YkQ4P/bgY2wyGxzLRUjkZV38smsAtvtA3bzkFJK73FtgCuq2hAtmow7NPyt5Ar/K6uAJKb948O/CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_09,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504090002
X-Proofpoint-ORIG-GUID: wowWWESWACXEZGskRaUv5wreZheNU9Ss
X-Proofpoint-GUID: wowWWESWACXEZGskRaUv5wreZheNU9Ss

T24gVHVlLCAyMDI1LTA0LTA4IGF0IDIyOjExICswMzAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6
DQo+IE9uIFR1ZSwgQXByIDA4LCAyMDI1IGF0IDA5OjM4OjE0QU0gLTAzMDAsIEphc29uIEd1bnRo
b3JwZSB3cm90ZToNCj4gPiBPbiBUdWUsIEFwciAwOCwgMjAyNSBhdCAwMzozNDoxM1BNICswMzAw
LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIEFwciAwOCwgMjAyNSBhdCAw
OToyMzozOEFNIC0wMzAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwg
QXByIDA4LCAyMDI1IGF0IDAyOjA0OjU1UE0gKzAzMDAsIExlb24gUm9tYW5vdnNreSB3cm90ZToN
Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbmV0L3Jkcy9pYi5jIGIvbmV0L3Jkcy9pYi5jDQo+ID4g
PiA+ID4gaW5kZXggOTgyNmZlN2Y5ZDAwLi5jNjJhYTJmZjQ5NjMgMTAwNjQ0DQo+ID4gPiA+ID4g
LS0tIGEvbmV0L3Jkcy9pYi5jDQo+ID4gPiA+ID4gKysrIGIvbmV0L3Jkcy9pYi5jDQo+ID4gPiA+
ID4gQEAgLTE1MywxNCArMTUzLDYgQEAgc3RhdGljIGludCByZHNfaWJfYWRkX29uZShzdHJ1Y3Qg
aWJfZGV2aWNlICpkZXZpY2UpDQo+ID4gPiA+ID4gIAlyZHNfaWJkZXYtPm1heF93cnMgPSBkZXZp
Y2UtPmF0dHJzLm1heF9xcF93cjsNCj4gPiA+ID4gPiAgCXJkc19pYmRldi0+bWF4X3NnZSA9IG1p
bihkZXZpY2UtPmF0dHJzLm1heF9zZW5kX3NnZSwgUkRTX0lCX01BWF9TR0UpOw0KPiA+ID4gPiA+
ICANCj4gPiA+ID4gPiAtCXJkc19pYmRldi0+b2RwX2NhcGFibGUgPQ0KPiA+ID4gPiA+IC0JCSEh
KGRldmljZS0+YXR0cnMua2VybmVsX2NhcF9mbGFncyAmDQo+ID4gPiA+ID4gLQkJICAgSUJLX09O
X0RFTUFORF9QQUdJTkcpICYmDQo+ID4gPiA+ID4gLQkJISEoZGV2aWNlLT5hdHRycy5vZHBfY2Fw
cy5wZXJfdHJhbnNwb3J0X2NhcHMucmNfb2RwX2NhcHMgJg0KPiA+ID4gPiA+IC0JCSAgIElCX09E
UF9TVVBQT1JUX1dSSVRFKSAmJg0KPiA+ID4gPiA+IC0JCSEhKGRldmljZS0+YXR0cnMub2RwX2Nh
cHMucGVyX3RyYW5zcG9ydF9jYXBzLnJjX29kcF9jYXBzICYNCj4gPiA+ID4gPiAtCQkgICBJQl9P
RFBfU1VQUE9SVF9SRUFEKTsNCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgcGF0Y2ggc2VlbXMgdG8g
ZHJvcCB0aGUgY2hlY2sgZm9yIFdSSVRFIGFuZCBSRUFEIHN1cHBvcnQgb24gdGhlDQo+ID4gPiA+
IE9EUC4NCj4gPiA+IA0KPiA+ID4gUmlnaHQsIGFuZCB0aGV5IGFyZSBwYXJ0IG9mIElCS19PTl9E
RU1BTkRfUEFHSU5HIHN1cHBvcnQuIEFsbCBPRFANCj4gPiA+IHByb3ZpZGVycyBzdXBwb3J0IGJv
dGggSUJfT0RQX1NVUFBPUlRfV1JJVEUgYW5kIElCX09EUF9TVVBQT1JUX1JFQUQuDQo+ID4gDQo+
ID4gV2hlcmU/IG1seDUgcmVhZHMgdGhpcyBmcm9tIEZXIGFuZCBJIGRvbid0IHNlZSBhbnl0aGlu
ZyBibG9ja2luZw0KPiA+IElCS19PTl9ERU1BTkRfUEFHSU5HIGlmIHRoZSBGVyBpcyB3ZWlyZC4N
Cj4gDQo+IEFzIHRoZSBvbmUgd2hvIGFkZGVkIGl0LCBJIGNhbiBhc3N1cmUgeW91IHRoYXQgd2Ug
YWRkZWQgdGhlc2UgY2hlY2tzIG5vdA0KPiBiZWNhdXNlIG9mIHdlaXJkIEZXLCBidXQgYmVjYXVz
ZSB0aGVzZSBjYXBzIGV4aXN0ZWQuDQpIaSBMZW9uLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaC4g
IElzIHRoZXJlIGEgY29tbWl0IGlkIGZvciB0aGUgRlcgY2hlY2tzIHdlIGNhbiBzZWU/ICBNYXli
ZSB3ZSBjYW4ganVzdCBhZGQgYSBsaXR0bGUgbW9yZSBkZXRhaWwgdG8NCnRoZSBjb21taXQgZGVz
Y3JpcHRpb24gdG8gbWFrZSBjbGVhciB3aGVyZSB0aGV5IGFyZSBhbmQgd2hhdCB0aGV5J3JlIGNo
ZWNraW5nIGZvci4gIFRoYW5rIHlvdSENCg0KQWxsaXNvbg0KDQo+IA0KPiBSRFMgY2FsbHMgdG8g
aWJfcmVnX3VzZXJfbXIoKSB3aXRoIHRoZSBmb2xsb3dpbmcgYWNjZXNzX2ZsYWdzLg0KPiANCj4g
ICA1NjQgICAgICAgICAgICAgICAgIGludCBhY2Nlc3NfZmxhZ3MgPQ0KPiAgIDU2NSAgICAgICAg
ICAgICAgICAgICAgICAgICAoSUJfQUNDRVNTX0xPQ0FMX1dSSVRFIHwgSUJfQUNDRVNTX1JFTU9U
RV9SRUFEIHwNCj4gICA1NjYgICAgICAgICAgICAgICAgICAgICAgICAgIElCX0FDQ0VTU19SRU1P
VEVfV1JJVEUgfCBJQl9BQ0NFU1NfUkVNT1RFX0FUT01JQyB8DQo+ICAgNTY3ICAgICAgICAgICAg
ICAgICAgICAgICAgICBJQl9BQ0NFU1NfT05fREVNQU5EKTsNCj4gICA8Li4uPg0KPiAgIDU3NQ0K
PiAgIDU3NiAgICAgICAgICAgICAgICAgaWJfbXIgPSBpYl9yZWdfdXNlcl9tcihyZHNfaWJkZXYt
PnBkLCBzdGFydCwgbGVuZ3RoLCB2aXJ0X2FkZHIsDQo+ICAgNTc3ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGFjY2Vzc19mbGFncyk7DQo+IA0KPiBJZiBmb3Igc29tZSBy
ZWFzb24gT0RQIGRvZXNuJ3Qgc3VwcG9ydCBXUklURSBhbmQvb3IgUkVBRCwgaWJfcmVnX3VzZXJf
bXIoKSB3aWxsIHJldHVybiBhbiBlcnJvciBmcm9tIEZXLA0KPiANCj4gVGhhbmtzDQo+IA0KPiAN
Cj4gPiANCj4gPiBKYXNvbg0KDQo=

