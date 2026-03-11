Return-Path: <linux-rdma+bounces-17933-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAGXETP2sGmHpAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17933-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 05:57:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A81C125C16F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 05:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2A4530F6326
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 04:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706593164DC;
	Wed, 11 Mar 2026 04:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KsbYNmCW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YK0puymy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3573101D2;
	Wed, 11 Mar 2026 04:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773205035; cv=fail; b=UA0o/t1mEIm73X1MyUJZ4Y07aYovB+/ztKn3jT8MCw3F1S1cTwuXkHEKE7TWZ7VCdeX2Wbmv5T1nnZ7mqyDItvUg1tATL3J38UbVrVnW1/eIu7pa3lIfwX4t1rPrdWVBsGm+DcIZyG9s88jdQCDbMWTrNWq/PHITqBudvab644c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773205035; c=relaxed/simple;
	bh=m7eIlXkC71nM7ZKZY+tB1YA3vWThPJNthH2u3uGJPYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o5Z2hbqXR+QdE8Cm5dGDrAENltyK288nGqI9J5F7hG2gnWC5Vwrwf5emlYLda2+n9L6kQWEqhBpGa0JaraK8Cd0bKYFfhj4Tiw4eXlsmDomyGJYrmEqPie5RIGAb4u+IHLFwiiAN6lZZzofh8HM6PJPJnk+t+8l1+h0aXsd5YEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KsbYNmCW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YK0puymy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AInQ9B2773086;
	Wed, 11 Mar 2026 04:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=m7eIlXkC71nM7ZKZY+tB1YA3vWThPJNthH2u3uGJPYY=; b=
	KsbYNmCWZB3RE0LP3+t5A8fXrMq2eCVqw29dZVp+2rMXtskL50vNo4nokGJ2lZHm
	egidqtS57CmEQkb34i5PAymtIgJonzF6nsgA/NHEytoV7Vs9or54Jf963uX8SKvq
	wDLrfLbCFiXduA5fse1XfMhfefWljMVLp22z9gs9j6w/WxMIM+1EEKfcIFk0utDr
	LGn3SJbt+8YJmf3PJQ1EifG7OpQbHeEKwtoImC4JjcB2GZGbEqls4FnTsW6rC/QZ
	j1BfE0jnb/BLYp5R7y125hxD6/uUGjnwN/OmQYJKh5oHlZ6KsVfe3vO0Oea0dP25
	mqSdiQvKi/PsYIEJ9qA4NQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csjnuma83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 04:57:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62B45Dj8007619;
	Wed, 11 Mar 2026 04:57:06 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4crafb1344-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 04:57:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQtHCKAvFq/bEc4gjAjy6jFiCwdAI2eLPwuoaXL1W0EnARN9xK7jlAbiSdTHJX9IBYAHHe5+m4ax/WaeSAdQWPbigMSF6D04z42XsVdsga+idFN5zQUa0dsbsF+v+tABH6lwdIZnXlfzrpOjw2O1m890bKng0Rhet6x7a1/W7pqDcAgEN0TYgAJRs8Jj7pp11wqvqPbSUtcM0PTr6ANGewHLLHsQ4JzzGu5JKYHtz0Em6mX7FbrFc+PXucVTsRp1w89vEboCMBC5zqwGmnXw0xgqc+hI8c6wQDbUYPqf6QYEY9CLw3u92iyilq89fJETbA5xaP6HyYMI9h147FGpRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7eIlXkC71nM7ZKZY+tB1YA3vWThPJNthH2u3uGJPYY=;
 b=xxQ/9GiBqhaq69x1a+ZNS92vZyRN/QNFvMxDXc2tPGMc8wMwOBWGWuMOq+MNMFNgBQ5MXcMCwZYnP5QMGsRXrSUyBiZAF+zHQGL33oO/ic2dPuGu1IgqHMCDuG+UJ3a8DxKoJ1Ma3PYr7Mc84kq9DfY/SDXIVKLeOBTlypDAcgigcwS/IICtMRQjiit0cl2nRUC32kCvQTg0NiTckc+/5EuBr8Boj08gy2kFNzHOHhW/q6awbOy9KZK626kgIL4EwulcwdLsq8aItEkHkTABgyyNoxLVvOhBjYEUDwLve9Rn/8XcjPsESWUAjTbAsQPAhSUF5NZaqDE6n5L+AM+EfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7eIlXkC71nM7ZKZY+tB1YA3vWThPJNthH2u3uGJPYY=;
 b=YK0puymyf8S0Z56YP8yNiKWgCYR32wdzKxrR4XcbbiYzQEe+vU9v9CN8iurnufHz3LRkM4eoQGKotcEzgctyWBKqqUPd+QSxTENMccdAahzrewCo8sYWJ28ijfovHe8O16zl+SimU+ZlrNck0Q5irYV7iSwVuLPaiYyCyl7ciz8=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 CO1PR10MB4546.namprd10.prod.outlook.com (2603:10b6:303:6e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Wed, 11 Mar 2026 04:57:02 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%4]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 04:57:01 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>,
        "achender@kernel.org"
	<achender@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 0/3] selftests: rds: ksft cleanups
Thread-Topic: [PATCH net-next v1 0/3] selftests: rds: ksft cleanups
Thread-Index: AQHcrsCdBZVc2TAizU20xMXFWo9l3rWolhmAgAAzYAA=
Date: Wed, 11 Mar 2026 04:56:59 +0000
Message-ID: <7bc8d62f5f7e8e4a79ab5aa486d660854455a493.camel@oracle.com>
References: <20260308055835.1338257-1-achender@kernel.org>
	 <20260310185305.017976e4@kernel.org>
In-Reply-To: <20260310185305.017976e4@kernel.org>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|CO1PR10MB4546:EE_
x-ms-office365-filtering-correlation-id: b8d6c745-a8c8-48c0-86d1-08de7f2aa1a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 UMY1xJSkcWNySQa2TCWkLT9rakvNMP8F2U5iBPUcJoqxMk4zNB+Es7vQcNaHihrKpOJAVwNwNtQ/M63lA/ok3rOLWE8Gq+e+YbfSq6EAmCPF6QtFTfxxihFxg3hHAgYSVtd8ZhIBo+Fbk2TIN8jSvf8Tf4oSzRn6g7RCmQw+3WJykpMiuD9s1fBXEzHF8vpMIilH0SN8TT+EAH+IP/m/n82HH17p4TQMUZ/a6f7cIwx/RaOMkPyeWI09v0tNkb/m59mLLW54Q6S8d+iWv3IsIKgykuIouDRUDZ4MGogpdrwsSoQW/QeH0UgCV+k6dls1nLhVhYVx+L3gDG/6ZAZdhbvwsp6wgPpimuUB68/Y1NXraR/XOlGMVWvSBaOjMTUTwKO/KfNHqEEYQC2gQXM3RQcFROTp2+g54yxXYm6z4EVwUe4b0nCRJCgFb1mS/h5LORZXvScC/q4p3TVMfXC2mHKJ3Wzu3t+ZLdSwpTt6iPbMMHwPC+JNik3z3etFsGs4KRQX35v6iqJ0z0QCeaUY/wBn/jxnlwWhAatamLdTsDXwFQwn3NBLjiVAL64/eQDw4qafOwrDi6e19GQlrxqP19CROWkNPcW0BdmfSjoH5i/PnZC8BQC7KWdvu2fldT2suAL2Bzji8VvUn2FX1duaPbMId01q5rDpK1QnbpG9gHrc/3n/HVdDmhTK+jfw7gsyQwue2auvTyuBcK/X7neSJ8wJE8cFm0fr8z8RWxM1O8ti/pN50s9BX82O0b/Q8qP8NJcU2w21lmL6y8eS2Q0xCUK0nHYO6D1ZmojhbtFaLQQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnZNcUpCK0xYVTlQTVo5ZS9NQXZ5VUFzYWJwSjVvRVNZSTlzL2szbWt0bWZ2?=
 =?utf-8?B?dS81SzUxR2REUUtjdUNVOTkrOTBNTGtvcFFabTUrVitGNGpCeEVSaFduWVNt?=
 =?utf-8?B?WkJpNlZ5NURBWDFKVXpVOTZYejF3ZnlUdFNJUkNaZG53L3g2d0RtZUxJQjV1?=
 =?utf-8?B?cU54WFBtSnBnejMwWnlnTjQxTU5mdFhMZnJuekQrc1NGNkdRdSs2YnkzQmZO?=
 =?utf-8?B?L3U0OFRtMmo1Qy9neFNreTdqTTlwMlZKSTZpbUZGU1BmMlg5bnBDNUI1dEQ0?=
 =?utf-8?B?dWNGdXIyZXZsWVlXMUlRMmFpNXNFWHNBQzdFdDVUTXRsc1RLQTBESk9Tcm9X?=
 =?utf-8?B?V2lxeEp4UDJpbGQrTEE0a1pnSmdFL2Vpc0RVMllPaWpFaWQxMUhBcExsWjYw?=
 =?utf-8?B?a0lsenUrMEFuclJ6bmtMSHhvanFTNUJxS2k0Ui9LUDZkLzRObXJEaU1kamll?=
 =?utf-8?B?YmtROWw5VUtlMTBzSUxMaC9kYmErU3ZvTUFIQ2xyLzlqUzA1QnYvUmpjOUpL?=
 =?utf-8?B?cTVzTXp3UmRGckJwTmJuWlJqVEF2Q01kMFg3WUgwaEdhSWxaM1MrYi9mc0dv?=
 =?utf-8?B?SnZ2R3k4TEFKTStZeXA0MjZBSnlOZzNCVmJJUlh6UC9LT3ZZMjdVb0tXbEpZ?=
 =?utf-8?B?a2hXVFJmQjdJWmgzZkZyZFV3QlpCYTZLditrRHRnSkNIcForRml3bTRHNFdD?=
 =?utf-8?B?bDducE1CUC9qalg3d2NtRDhUSmVLMXplMW9VV0lsZWxTenJEcDZEcmZCS3FC?=
 =?utf-8?B?QzNaSFR2VmQ2Q2VPK1BQdEFTb0dVekdNSU9QdnRONEpQdU9WeXdueFVxaTBh?=
 =?utf-8?B?L0xKZk5PcVFxRkpWMnRBcE9BMXFxZ3MyNGdHbmlNMHhNL3pOOWcwNmpvNllF?=
 =?utf-8?B?RFN6clFIc3lVUEVDdzJHdzhnZ0t6WWxDZDZteVBwYTk3Ny9wVFFoallVenBY?=
 =?utf-8?B?V043aFF1WmNZcmJvdjhjeENoOXIwSDlVTG13aWRwakRmdjNUYWdSTWkwVDdF?=
 =?utf-8?B?b0V0ajV1aGNBZ3pzS2lVL3M2NzM4Z2VwcW9aSUY5SU5lK2MrbkJxREtiaW8y?=
 =?utf-8?B?YkFkUU12cjFHSm1CYlgrbVhiaW5iQ3RLcXJKdkE0N2tpSFVYMzJqUUJUOUlD?=
 =?utf-8?B?NkJWZTZsdGl6WTZVZ1FzYlErVmNVQ29nVUtLWHhUS2RWMkNBbFZYMk0rejhV?=
 =?utf-8?B?MTlmQnNad0FMdzFVMnZVRTZmS0pONWF3bnd6SE02UVlmekNoaXBFK1RKRnpC?=
 =?utf-8?B?Q0RMVnk4N21wQXNudTRtcWNVQVNYcC9GNkQ1bG9GWHZnY25BdkR1SURPbmZv?=
 =?utf-8?B?SHI1SC9wdHF4ZEtxZ3IxZ0NWV290TUpjRU12MUVGVWN1VUU2MUpsdThVMFZY?=
 =?utf-8?B?YmN0U3JDV21mN2dNWWtKMTJ1TlZieXVwcE0wOEcvbUtaZng1cGh3VXRtUW1Q?=
 =?utf-8?B?MVgyY3Y0Sm15MEZwLzIrdGJiWUJxTVJ2amkxK1BURUg3TTFnV2NaR3l4dVFB?=
 =?utf-8?B?VEd0ZXdjYzN2NkhSOFdtSUgxS29yd2UzZ0tpQ3RBbXgrOVVLNGdQL1BJcXd2?=
 =?utf-8?B?N3MwVkNhRlZ4OWRya1BMY3Z0b2hSY2ROUk44TkQ2ekJiS255cEEwV2dEYk1j?=
 =?utf-8?B?azMvV1NJSURtekI0c1VDWXJVU3dqNE9MK282MFRhOE4zSzhpSHlUelh3bEFR?=
 =?utf-8?B?Y3JhdEo5bzVUWGlNZEhKeEMrSmdBMUtuRW9QR1VkS3VCd0Yvdk1kT1g5MVJP?=
 =?utf-8?B?cVNOR2JLT2FpMlllUmZEWXFoeERhUUc0NnNzQVZMYWxKVUNkR3pVdXY4clg4?=
 =?utf-8?B?VWU1N1ViYkQ2UWZaOGZYRFJVaU9meW01MXRHaVNTcXZ0cHV6a2IvUERadnc5?=
 =?utf-8?B?amphaUN2cm00YmRYVll6V2hReUVSTDFITEZ0bWdkVFB1eklvY1kyWEV2U2E1?=
 =?utf-8?B?NVBDRTZ3cFFPWTVJOXZxSUtqbHJxZzI1WDZlQlZiT0lMWDFtYUpMQjFBZmp5?=
 =?utf-8?B?TG1sZC9LdG9CTGFBdERFK3hLMjhNRjhPbTN5S2xrZzc2b1dTd1NrdUJXQVNr?=
 =?utf-8?B?MGxvaG5EN3RDZVVGbVZPUzgxOHRXaVBHMUhOZHVCRi9ySEpOekw5NlZ0RDE5?=
 =?utf-8?B?Q29ERXZnNE9zVjlhdGdlUlFXVVhWaHRRbUZoNmxHeUFieE1mTXU2Zm9QeTFM?=
 =?utf-8?B?ZlB4UWlnNXdYa0tVRDIwWUgwaDVvVXRYWnJEejMycVZCb2owdlZnQXpIaE41?=
 =?utf-8?B?dEorYXE0VnRhcjNVdnM5aEpSV3Q4S0xhdksrUlBOY1o0aFMrZmN5czZHLzBs?=
 =?utf-8?B?ZWdsa01LaG10UEV6cWpudXRXZFpKYzFIWDRuT3dpdURobzVxOG1RaFJ4NExl?=
 =?utf-8?Q?u4idwewNCpYzfNIg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DFD29C741FA1B42BCE76C451E2905F3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Yd5/UCg3dLTAitHhlL2mQYGEwg7F1FnHW3h8AtpamO5YOlMJIQk7r8ErjfW82VaaLuxHHTKnevaiIwFSaBlVyNTv/Hc4fXI4pi6YXlJ8SbTtdUwu5fM06FTFO7kMmUBxvMEixdP+OzHTzgLR2qpg40/sFTYHeAtDOjN/HhO6exNcep1WfGrk0qlYyQ1lB//iru0NwaUl7KIvqNUu0aXazZGQ9ZZk9/wS4WuqCuhmIIm4F3cgES9idSUfeZwqUvhKJ1UFK4OMyc+wHy+WK5ejaoZeIP6N36nrUeszQK8NTPbyHP13pI30bC3zqeDcI2i/lO312HEknWnqx25OMzknfg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zWmGepWJB9ZOkFoAhl0Zr/57rrlWhpzKWCyLAdv8BC5yt3npKaxO6U2VIGxJMWVhBt8HiRGAY9/Hs74uEpzZsmtVRClJqvOsVMl9ccqTNYeApFsUBefotJVjAJvFv1zS+ImgjS3T0/68Rj/Al0rIO0WxRy7zPVsQ46TEVITZkUJyEyTAOh8bi3lca3QQg0h1+czptmy1FLWulSY35xIrTHFzeMiPMhQFFvCI6cKYopQm/HMX7aV9X43nPH2sA8sYBNOMO6oYfaDdJ5WHdixaQr6Wlk/VLi2EKD/dku5RncEogNPGaxQg93cj6aqvG7WiW2n+X0+Pv90GOdcBxpUrlUhgYV/8lLoA253Cxrj0OqoSxW5Aaj0zI6B2w3L9dOOGm4taBRIVkZ3V/YglZMEoYL1tMPsNAYHIvDwtCdESygeDiiEb8OogUtwMbVPtI18qqJhUgEuwbc7lijXu4jzGOnX+YXKkJp45OlaowF3ZhHgA/x6ooMUr7xcOWuISjGwiwTwli9VsM332OKq8mxsKGMaaonHRsZ3/+TH6U71/H4FbrVL+dqzzxtJRdoab4TMzQguHMYxd0A6V77bFzOWlBx+OIMGYpf8A5cX+FG4gqP0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d6c745-a8c8-48c0-86d1-08de7f2aa1a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 04:57:01.0686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iEMI2skjhVSyuk/Wf2poFGvo2oIkszEQBOCBIi8krklQRg4ezPMmo2Jy6KgMb8V/p4EgVYiNUA6/4ZhPyNQ4VkUwOGIcnCK/3Z55uJzTYiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4546
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110039
X-Proofpoint-GUID: 7gfzR38mfW5adhYUDKCrfxY1DLxCGWFN
X-Authority-Analysis: v=2.4 cv=c7WmgB9l c=1 sm=1 tr=0 ts=69b0f623 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22
 a=U53aWe5D5l7H_rtCx1gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzOSBTYWx0ZWRfX6mLrRntlLu0P
 WfrJelOSAcHLXrPyTxdHjLTu4bXvUVbqa7RDfbTcgMmX159cq+c/K/PILLOFNngGVOFRv4CJzjm
 O4+Ts+VJP+jncZ07PNAG5T5/jE9ciiZMu43vubyA1Z1ygJgBoAJZSXVZmVFPAWUw6bht48gGgEe
 aY9Luw3JVptfxBJxhlr9OMzcTZeReK3BY/ZlFzzsn0aVkwLj3moZvs6TKp3g2nkBHipISewV88/
 UncpzgE6kIy7ijJVmyuIuVL5otcNHLdbr2WdNo8bN/A1bMssHUEn1V+BM17e/7MoXolOs5AR6Jc
 Lx4XTktRwoo1IkVn3CUDb3LBY1tIPTRLk78j7Co2o4MQi9CcRvWDvB98QlT97HtScthYeg13kRC
 1FcIccPJbEB1a3eABUtURJpK0W31GsVRrvPsTJrN3/Lbx/YtCkRMtydirDf7yuN8AP4wkPjYpa2
 XcfbANQv3/dXtD54Q2Q==
X-Proofpoint-ORIG-GUID: 7gfzR38mfW5adhYUDKCrfxY1DLxCGWFN
X-Rspamd-Queue-Id: A81C125C16F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:dkim,oracle.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17933-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAzLTEwIGF0IDE4OjUzIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gU2F0LCAgNyBNYXIgMjAyNiAyMjo1ODozMiAtMDcwMCBBbGxpc29uIEhlbmRlcnNvbiB3
cm90ZToNCj4gPiBUaGlzIHNldCBhZGRyZXNzZXMgYSBmZXcgcmRzIHNlbGZ0ZXN0cyBjbGVhbiB1
cHMgYW5kIGJ1Z3MgZW5jb3VudGVyZWQNCj4gPiB3aGVuIHJ1bm5pbmcgaW4gdGhlIGtzZnQgZnJh
bWV3b3JrLiAgVGhlIGZpcnN0IHBhdGNoIGlzIGEgY2xlYW4gdXANCj4gPiBwYXRjaCB0aGF0IGFk
ZHJlc3NlcyBweWxpbnQgd2FybmluZ3MsIGJ1dCBvdGhlcndpc2Ugbm8gZnVuY3Rpb25hbA0KPiA+
IGNoYW5nZXMuICBUaGUgbmV4dCBwYXRjaCBtb3ZlcyB0aGUgdGVzdCB0aW1lIG91dCB0byBhIGtz
ZnQgc2V0dGluZ3MNCj4gPiBmaWxlIHNvIHRoYXQgdGhlIHRpbWUgb3V0IGlzIHNldCBhcHByb3By
aWF0ZWx5LiAgQW5kIGxhc3RseSB3ZSBmaXggYQ0KPiA+IHRjcGR1bXAgc2VnZmF1bHQgY2F1c2Vk
IGJ5IGRlcHJlY2F0ZWQgYSBvcy5mb3JrKCkgY2FsbC4NCj4gDQo+IExvb2tzIGdvb2QhIFNvIHRo
aXMgaXMgZW5vdWdoIHRvIG1ha2Uga3NmdCB3b3JrPyBPciBqdXN0IHRoZSBmaXJzdA0KPiBiYXRj
aCBvZiBvYnZpb3VzIGZpeGVzPyA6KQ0KDQpUaG9zZSB3ZXJlIGFsbCB0aGUga3NmdCBidWdzIEkg
ZW5jb3VudGVyZWQgb24gbXkgZW5kLiAgTGV0IG1lIGtub3cgaWYgeW91IHJ1biBpbnRvIGFueSB0
cm91YmxlIHdpdGggaXQuDQoNClRoYW5rIHlvdSENCkFsbGlzb24NCg0K

