Return-Path: <linux-rdma+bounces-17142-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA/aD36anmnXWQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17142-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 07:45:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C92192767
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 07:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E431130200CD
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 06:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8108E2BDC03;
	Wed, 25 Feb 2026 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zd3yFqej";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NKFM8ePN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E942874FF;
	Wed, 25 Feb 2026 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772001912; cv=fail; b=q7C2ynYl+actFH2+YnjZEygzvdZP1dU02s059R328SFBimC8prGypPxL/bv1XbMew5uLO7e/0ppN4xc6FcHkpPdv3T2sp1sPKg10FE/PDPaE3MqKJx+WDITUq+sHYBTwkczBi4Er9JnEgvcIHS+vjLDr8XdU+6A+F1W5okQjns0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772001912; c=relaxed/simple;
	bh=PCoEm55uVguuD69lOozct1mb/n4CvSdYtwiGf51CD5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ovHlY8MmIUuHHvrj49danjqlXYlNRvD0VA0mzLHQUGmw+EmaG3Ikk52YC8sZ53OLmeTkzolnEt2NOpU5JdsIkPmkFneGFB7TZHZ3Gw0pAfWyGJAXPUWYwLHXGhDBIKvhosPC4G4A6zmAiCab//yPJ6WtXCD/QyxNaLty2I0uC8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zd3yFqej; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NKFM8ePN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OIu6ct369450;
	Wed, 25 Feb 2026 06:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PCoEm55uVguuD69lOozct1mb/n4CvSdYtwiGf51CD5I=; b=
	Zd3yFqejxzncwYeAk/JlRyormqN7n4DAbOr808bM78dJPjnlG1wwXWq8rmhGA4gW
	XiPUPUfe5IOWw1Hckb0dBkYVj2ZQyU3exyJaeg5TBkJ+i9b3fHE0r6DpDxbQK5hG
	5XWQQPfMJF7tfxfyMgryqoJfxOs2aZpd1/O38KcfcwQNep6dwRLN23nR6HFVvAFJ
	1fkGORj1we9oJ39/m2/tTPmz4f+k4MQw3lwmrB2FfFhmhXiACxJvkrbGUtEeXCml
	GK68BUav1CTiOz1nSQiAbW8otX7RPueFh66qpVpZyhRGZL3EBAcd0VMSYCIRGozi
	KOGo4FR8PUAMyrM9MFoUhw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5whbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 06:45:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61P5i24D012455;
	Wed, 25 Feb 2026 06:45:01 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35ey35e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 06:45:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnJlVHzZeRkT1yjIVPi9vtNZLwT6mXTQLPHcEHCg50CrVOeXc+y7IG0s3A294EYPCXRVcMytSLOkjxxDyVezkq7gITKFSN+zQUOuw3tBfW9xp9vrc77NFuVT6r9LzXRb+KRz0iSdM72uMgGlhlZSYIe5gnESjyGiU9ca7hWEuJ1NiE9BQmnkgsaW0xIPzkG4T6dU0pcLk0uHH0XUfvcYJr/Cg3E1uPI3UW444JaOjlbTt8QmX9a8hO8In3sy4nlX61X9vpqK2RWLJRypsBfxDROsN6KxlpUnXXHUly8aFQpdkEET0IINR/JQXxAnhr8nxZg4KOp4JmTjtAUkuadwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCoEm55uVguuD69lOozct1mb/n4CvSdYtwiGf51CD5I=;
 b=Dz4AEFq8gQMmpPXrSdlsLUmrtexIrFtUZNGDpXNJXuwXZxUTZURaRTMEreNTlBDtQN0wMqmz9qkRiuS4sG+w3PV8WDtAbzldaKU+sUZzh9XvE0CIEBZ8/sA7vmBeepDZtA+exwx1MXdIhHqrIqzigBoajVWatM3GRI/m0rgGJzA8dgMe2LBge9RpwlFp7rtsU6rmRczhOlyyukRcEt9ekXPrGedJXcNvWRgrMYYd3HaHnIrRaLoM+MThXHiwu80ZEYw53U65hTZ2Cv85Iq+1Bs5oyENEX/pQGxJ1FjMjt/74kSl8QLFDOwJ0BonWMnaL2R//+k9z53dRbWfIM5mJfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCoEm55uVguuD69lOozct1mb/n4CvSdYtwiGf51CD5I=;
 b=NKFM8ePNnYoqlFlcNQnBWGqA+75cSeARxN0icZ2liCGB58Co3opZ8Ry1pPMuEFNfU4hCLgtLJXNLqK0EKJouMC91ennREnAUcZSdCZTk0uuNYOA2nlkQ8XJuO81Xr35IqBFNGBNCT6xDf+VmNtxGOn7MYEn37raSuKKmhYAMBcg=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 BN0PR10MB4838.namprd10.prod.outlook.com (2603:10b6:408:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 06:44:58 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 06:44:58 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>,
        "achender@kernel.org"
	<achender@kernel.org>
CC: "pabeni@redhat.com" <pabeni@redhat.com>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [net-next,v5,1/2] net/rds: Refactor __rds_conn_create for
 blocking transport cleanup
Thread-Topic: [net-next,v5,1/2] net/rds: Refactor __rds_conn_create for
 blocking transport cleanup
Thread-Index: AQHcpajttnHTAsUkVUqUEhjx38RvIrWS+S8A
Date: Wed, 25 Feb 2026 06:44:57 +0000
Message-ID: <8d2d61150cc4f8ba6729bb4786a28817aad2c15d.camel@oracle.com>
References: <20260223221918.2750209-2-achender@kernel.org>
	 <20260224161607.143920-1-horms@kernel.org>
In-Reply-To: <20260224161607.143920-1-horms@kernel.org>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|BN0PR10MB4838:EE_
x-ms-office365-filtering-correlation-id: 7dc5947d-80df-4f05-e79f-08de7439646c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWlMb3RaTndySFAyYldxRVc4d3BlNVphTFg2dnBCamlLcUJjSFBrK0tMK1lU?=
 =?utf-8?B?d2RIdFJFYXZWZUFCM2E1d042R25qK1dCbUQrc0hmSE5RV1BNdEtRUWdqaVR3?=
 =?utf-8?B?cHZhQ2lYTDY3cFplMkk4dlk1OTd4cU0rdi9ZbXlHTnErMGdTZDhmMEkrYmpx?=
 =?utf-8?B?Qmh3TXU2MmRVN2hKQlhQLy9tNDZpY2lmOXNoVHpYQTNNUE9JZ2VnTjRhdFh1?=
 =?utf-8?B?ZTdpMFk3RjR5YnBlR28xaGdzenU3RDNzYXAzek0xZ0Z0MFNPeGJLMG1wS2hl?=
 =?utf-8?B?a2g3blo0d1o1bVlzNmoxZ2lSUm1NSHlnL1M5Y0xMUGZmanA1eE1CeWd6THNz?=
 =?utf-8?B?OXNmVW9KeUw2dnJld29sRy9PRnV0WGFyUFFIUXoxSVhIOGJCNWQ2aWZnMzNR?=
 =?utf-8?B?RGd5M1MvSXAvS05KcElOTHhyQlFTcWhuOHZQRkpDeG5keTNQaTQwdGpRZWdW?=
 =?utf-8?B?YkxnTWtxcVRrVmhZSDRjeU9FU29pZ1p4Tll1Sk9lTjVjR3N0MXpKTXhvdVE0?=
 =?utf-8?B?Yk1zL1BiMzJ1dEF3eGZRTUxtekllbG5WREl4OUJTY1RVTmxnam9rQmdndDBO?=
 =?utf-8?B?WXZZTGRmMzBlc1hmbDgrd3VJN0hzZmxYOG5mQ2t6TUR2Q0RMektoMEQ2R0pR?=
 =?utf-8?B?ajdVQlNKcXJ5cVAraUJ4Y0ZTeldmRS81bGJPMzZDbENyc1ZCK20vVWEzVTlZ?=
 =?utf-8?B?SHBwc25ZUG1hY29jbVhwZEl3Y09CRk51Wm5BZDBqQ3F3TzZVY2VxM3VDNkRq?=
 =?utf-8?B?Zk1KUUl5MzVNVnRWVFV3WE5LK0lRYWVoaVp5bEtnSFFUMHloTjJia2RyR0RG?=
 =?utf-8?B?MklCc05lbExrL2lvNFV1MEgrTEhIUUxlQmVJNWNqOUUwVzFsVVdVL3RvcVZr?=
 =?utf-8?B?Tkd4STR3K0pBemJ6M2dNb0xHR0RncmZITGFqNjhZU1crMDFRZmRXYytSVlVF?=
 =?utf-8?B?bHFBanA2WHlSSUUxM281OUo1RG5wME0wS1hhMHN2VExOZks5dm9XS3VGUnp2?=
 =?utf-8?B?SThOUXp3ZW42WTdrUUU2U2FuMHhiNGw2aGxBZ0krakNIekZLcFhuWEVuQlo3?=
 =?utf-8?B?ZkpHT2VHaVNQTGcvSmZJdTcraTBnQXhDWFFldDlqbFluVDdiUXNuMUtWeVVz?=
 =?utf-8?B?SlNFR1ZWTzI3Q3FGTlpsRHNUT0ptbGRrSDV4OTRxUVFheERUVGZiYmUyQWx1?=
 =?utf-8?B?UlZDaVBiV1hrYytxNkx5QUkwdHVYNWo4T2lxdmFhNk9UN3BTdXhzUzF6ejJp?=
 =?utf-8?B?NGhkRUR0UCt0TTczeVlVdWwzZHdUblZ4U2JuOEs0SEFkVWNJblcwbC9lV1NJ?=
 =?utf-8?B?ckNPRU9jREtoc24xYUFkeC8ySTZSMXEwditWbkZ5UXdHanlmWklBaW12WTEr?=
 =?utf-8?B?UUVmZG5GWTZHcnBGV08xaGFYZkcvdkx0b09Hc0I4REtDUUVCY3ZuMkgxeUJr?=
 =?utf-8?B?QVJLZ2NqYmNXWFZIYmxGRHd1SFR3bnJRSm96azdxTUlDeGVjMFJWU0FiTWx0?=
 =?utf-8?B?R09ZZDFrWVpQZEpVUytlTnVxRlNuMGxFb0o4eGdTZWlSai9HRlB3Wi9MNEpi?=
 =?utf-8?B?NEUraXlReU1OeUFlaFJFZjJ0MEZsSm4zMVk3MDJ4Z0JJQVlxNlByN3QxSGRl?=
 =?utf-8?B?amlCZmN5WUN3Q0JQVkV0MVN4UzFPYUVnM0JweUF0OURMQU9HVjYxWlVMaXNN?=
 =?utf-8?B?ZnNhSHUrL1IxRC82ODJLNXNtWC9BOEhuVWVtcDBLeHJ5YkVsRTB5bUUrOWhP?=
 =?utf-8?B?eVNaMUJUL012dEE1dHZFRDlycDJ0TUljckhxK3MrMHZxOHhad2psc2NYSjRE?=
 =?utf-8?B?K0RZZVRhZHJoUk5uM1FjVkliWXBIZndZV1VXMW1WdGl2UFJJeGdEaC9uS0pM?=
 =?utf-8?B?eXNFaVFpdnlRM00wa0hlQ2NnTGhxS0ZRWUtoWlF0SzczWHUzN0pTZGhpVUIw?=
 =?utf-8?B?bXZZejlmN3lLUUV3Y0dwTVp2a3NGcGZUdEx2ZktLcEZjVWFlMXB3Um1wUkpU?=
 =?utf-8?B?bUhWeEhoWmU1NmdXUXppb1FzOWo2RFV3SndsWmQzRWdnblhndmxHNXVkOG9v?=
 =?utf-8?B?cmc4WlgxNS91bjlpVzlScWF4QkFTcm5vb1gwS0JMYVp0YXVDdEZCSzY2MTRa?=
 =?utf-8?Q?cvrSVqhoyqgFCRNcC3peiuDiH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFdHSm1waTM5V3NFaHkyTUN6QkVMVzg3Y0VWTk9SM3djU3BYaS9paUpiQ1Y1?=
 =?utf-8?B?N2kzT3JzSTFBWFlqWTczeVVzdWU5M3NTYkpPT3N4OWIybEVacldONFArckY2?=
 =?utf-8?B?NXZXeWVUK25ZYmpnZTF3cG5rQzNDeTlPOGtpMXA0RUFqcVJ3MWNpMVE5OWVo?=
 =?utf-8?B?dzNYbllVSzRqQ21KUkR3aG9LWVhaQVdZR29ERlhCak5kSlArODhBeENvRzBJ?=
 =?utf-8?B?TEdCaVFZU3dGZkY2d21ESERCN29ZR0gxS1pMaWxDMmZtS1hBMjNZS0ZQcEtN?=
 =?utf-8?B?M3JxT0xXSktBaGY5eWlneXB5bkgrNTFpNVEyUFZvUVZ4TVB6YnAvRGFiVmtQ?=
 =?utf-8?B?d055dnRGeEczNEhxZzVsRlgxSXArWG9BRVFwcmFSekl6d0gxRTJ5cXBjUXFp?=
 =?utf-8?B?dFFDRFp1NTF4NWZzZjVqdlVmZzZYTmM2M1FGWGZUK1d6dFNUVEpxdFNmYnow?=
 =?utf-8?B?QU5udHIrRFFYVHRyaHQrTlplQnBzdjRiU0pTeHBnNE1FVjVyWlN5ZjI3ekgx?=
 =?utf-8?B?MVMzY3BwNDMza1hjVk9UbENJZ1JMSGVMb0MrbkczRFZTdVhPT1RJbzZnMlla?=
 =?utf-8?B?by82T2Irc0RRc2U4TTlpS0VFRFZUZFlMRUw2THBvbUdRUWxZb1JBM3ZhNnZy?=
 =?utf-8?B?SUlXUWVzYUVIS3ZiVE1VYllYZjQ4VGwzcjErRXp5S2cxMnpjeS9obDJTK3F0?=
 =?utf-8?B?VmFqLytRQ1h1TElvNXMxSTVCSC9kU2lwQ09DNVBVRHpiTVBDUno0TDRlc2tN?=
 =?utf-8?B?YytuVFR2MGxYVTZnYy93TzJ2NVdTOGQzd2VveTc2R0lsUlE5RGtmd2Rpd1F4?=
 =?utf-8?B?dDhwWlFwOXhlc2NFcC9NQUk3T3YwSDBmQzMyMDFrRlU4aU5iL3hNbEpUTzhE?=
 =?utf-8?B?RnFZcnN2QjNldWwrWklXRllydk5tajc4SmdxYW9pdlRrVU1KUnJaWVhIaWtk?=
 =?utf-8?B?a1RYdHF6d0JyUnpoZ2tyWGwvUXIzMkJnanZxNnZkcnNoM29hVVIxSVpVS2lM?=
 =?utf-8?B?TW8vQkt5T2JKK1MrMHV1SVdsWUdQMkcwZGN0RDc5TzY3Y1ZvV0hpZFl3dU1r?=
 =?utf-8?B?TFlUU29YOTNXWlFJN2VjWkdoNUJYWjBvTjBkU2FjSGtES2dGK05DVU5nVnJ3?=
 =?utf-8?B?YzZPaS83WDNNOS96MWtXYlpJdkJVRC9MbXJxcmNGa0ZNcnVieGdVbHRLaUNw?=
 =?utf-8?B?dXZCV3NtZnhmNTJxc1pleGpBT0czWUEvTlNkS1QrOXVWNG5Wai9WYW9WcTBV?=
 =?utf-8?B?TUI1V3JWMW41WkdLVFRzM0svNlNlRnR3dVdFeXpjcERhRlJtUkZDNUJFSGYv?=
 =?utf-8?B?YmJrTXJZb2RhL0w1MnVjNitwT0xzTVBlNytqODNaRGlSUGpOb1R6YTU2bmhz?=
 =?utf-8?B?d0ZDdGlPY3Y1alZNSnpVN0Ryc21HTUVoT1Fqd1hTNnNYaUhXVFhuY1QwcGxy?=
 =?utf-8?B?ZXFiUWtFclIwamxRVUZJUEt3dnNXR0VNUkpKMGFxT2RUcWIwaTRDYjA4akEz?=
 =?utf-8?B?RWdjRUREUTZaOXovVVRPeW90YXdrUmJzL2lNanA0M1h3WGozQllzRkFBYWJl?=
 =?utf-8?B?dElzTVBOTmlPb2xIMUxHclg1RE1wRXNjcG83NEV4Snl5dVlrV0N0TUZGaWw4?=
 =?utf-8?B?UWxzYzRyUjhudDFZTzZFWm1KSm5EcnNScGVIODBybU5LQXE2RUgvU3pCc0RJ?=
 =?utf-8?B?ZTNuclpHbWQzcWY3QkIwbFloZDk3NDBid3JvUFlValdUTDFmV1l6RkE3N3dF?=
 =?utf-8?B?STc4UWZTcUVIQ05ZaFZIVmpORXBJTEpwUDlrcVZZZExTVzBES2s3aVB0dGU1?=
 =?utf-8?B?Ym9VYW9xeEl5Nm1Lc1hkWCtUc2l5M3F5a21iTnhISC9pY05kdW5xaDh1V0xw?=
 =?utf-8?B?cEZ3bVhlU1A3RXFsWFV1SHdsanV3SDVRZnVYTlp1WE5qZ0hLYmZLYUsvMm9N?=
 =?utf-8?B?b28xclUzQmVKV0dOSGs5T2NLMXJvYXdKOTdteVhhbE9BeEtIaG9RMFdqNk5K?=
 =?utf-8?B?clVIZm1RSjI3YUp6Y0wrYnczSlREam1KY2dDV2FxVG1GeFdyMFU2R09tK2Y3?=
 =?utf-8?B?eDBjdkFaZDRZL0RyVDlJZHMwdU84RFBJWWJNTUxEZjcrbmpITW9aUmV3RXh1?=
 =?utf-8?B?UzAwSkdrSnFXQXlCUzBFZmE2T2NZbWtSSnlLWG9iVkRQeDR1c1Y0UmRodDRM?=
 =?utf-8?B?dDhpM3NaUStnQWlpRDRpV29kOTJzbXFqRTcrdnZRNERtYnVibXBtMnEyN3NT?=
 =?utf-8?B?Tjd0YjNjc05rcFhVa2RZVjMrWFN5Q3E4WThLd0IrM3B3MHc3T05oZHhxV2Fa?=
 =?utf-8?B?emRnY2FVSVF1VFJCZmR3YjNMSHZxSVJWZkVCTFRXQ1FMYmhhR0JQZjVURWJT?=
 =?utf-8?Q?/90+n+c4+/YkkK1A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFA2D4C47AC6D04F92C1B25A0E9F2F8C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nT+/+ColPJgT1LvYElSuckXHe0jeoxViWFwJypSvTaOjqHyvylsBPGt/t39jijh+oUzlZSGqzyJL1TP27UadcqhXo38PoR20ws3DpH49ZKClpwUM+0WEeNJPslRPr4G6nYdV7duSTq4IVUjWhFuVCnswV1C3HaKOzX02E1qnaAzF0r0jWgDcE67O3ebUTTDbJg4yUIievWfLNQWLCj5DZtg3N4avi8L4N1AMsk1pZy/092m/sJy1H929J3kGTP8sQssu2KtY4TSF0CyRLi5mAhcIeN4hsO3gDCmih72DLEqJKGJca26WXU4R4X15Ue5Ote5kJucNAuNAYl7IJ5m0vu/8tRzNj5spQUrrJYVj/EF0aVTdg8FqMgaZhsr0TY8MuzFUHHrKCVCPq4L0H7TGJ7PahRz41VLu5+OZ4HKQtHFyoZuh6YTWuyW0PcH/Cj4kQ7FFfGZIHX8WjBBGDT1cOu/ieOazl3RgrvSNSLMqD1el+q/STNb7MVHnwOqozg3EgLMORzqsz1SfwrUO9x99YexUUyCeeqosdAwr3NsG8mtSjc2+DRnFsqwU/n6su8tEl4AI5FsoOOffQYxF5qYGiS7LQJJnsuneWUcQj/hhMKM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc5947d-80df-4f05-e79f-08de7439646c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 06:44:57.9900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TKcm+pZ678BMW4hPAG6mz+q4vodF/QBFDCkpkyyjkykjD/s3A+tLiQILxk63jtgBfEwUpIzKIPGNht5k5JbZEcfNmvKiUJ51KY7zm+lNoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602250064
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA2NCBTYWx0ZWRfX2W+Xwftoz8sK
 hoJ0OEwT06UYoqxyFeQqjSbpV8wUObVqF3TAdicOa1jI/hmlx7USOYs26JN2CSWwBxnEb4eun7x
 9sE/37+VgCBuER1v+E591DhwhAXXvvA0QgodzxI+/M+J9RZAlpT7nxl+iW3PdEvj9sq9Re0exjw
 YwjMELx0SDS1ZsvAt67U6CcG9mlVFdjWtQ77aSXh8HIDYPAUmQv8h4P5ASg7etDe4+CC67RAQ6Y
 +3GC00pM6oLM+7Hx1NGkcSGmQZAMcWAHJ94YhNT1x/rhB8Bv0BzpmPfo8JoEqEjQJjc9mNUftTM
 6Bn6uhCN9dOoVEAJbQrxLBSF5ji2dVNnJHriZk4usWD4tvk4/8rButDwCkVwGXSJ3fAriQYZ97M
 i5Q4FKb3WraDd2uOfdp+glYGxM8XQpKftKxwKdfRShUqIiMWK9bBVt4cWiBnfeC/G2KS5Q5EYSN
 coVxJd3jfKK1UY4r7wxIUqPgTHyCFzfBWLY2UAHU=
X-Proofpoint-GUID: RtUC-9FWYLfDUrY_QgIb6KfOjtJhdPwp
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=699e9a6e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=9R54UkLUAAAA:8 a=-ibLmwfWAAAA:8 a=ih1SD_9SIUHq3fPH0EoA:9 a=QEXdDO2ut3YA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=A6MkUVyZPcTV1i89ro0M:22 cc=ntf awl=host:13810
X-Proofpoint-ORIG-GUID: RtUC-9FWYLfDUrY_QgIb6KfOjtJhdPwp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,urldefense.com:url,oracle.onmicrosoft.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17142-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 65C92192767
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTI0IGF0IDE2OjE2ICswMDAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IFRoaXMgaXMgYW4gQUktZ2VuZXJhdGVkIHJldmlldyBvZiB5b3VyIHBhdGNoLiBUaGUgaHVtYW4g
c2VuZGluZyB0aGlzDQo+IGVtYWlsIGhhcyBjb25zaWRlcmVkIHRoZSBBSSByZXZpZXcgdmFsaWQs
IG9yIGF0IGxlYXN0IHBsYXVzaWJsZS4NCj4gDQo+IEZvciBsb2NhbCByZXByb2R1Y3Rpb24gc3Rl
cHMgc2VlIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL25ldGRldi1haS5ib3Rz
LmxpbnV4LmRldi9haS1sb2NhbC5odG1sX187ISFBQ1dWNU45TTJSVjk5aFEhS2k5cEs2S0ZBT2dt
Y2JkQkJEQTZsRzdkWE1fN3NKaUJBY3AyYVJTZURpOGJSRzlBQ0phamZpTGRLLVlnTnZYeU9QcXJK
cEM1eTdrOWZxNmh1UzgkIA0KPiAtLS0NCj4gbmV0L3JkczogUmVmYWN0b3IgX19yZHNfY29ubl9j
cmVhdGUgZm9yIGJsb2NraW5nIHRyYW5zcG9ydCBjbGVhbnVwDQo+IA0KPiBUaGUgbmV4dCBwYXRj
aCB3aWxsIGRlbGVnYXRlIGZhbm91dCBvcGVyYXRpb25zIHRvIGEgYmFja2dyb3VuZCB3b3JrZXIs
DQo+IHdoaWNoIGFkZHMgY2FuY2VsX3dvcmtfc3luYygpIHRvIHJkc190Y3BfY29ubl9mcmVlKCku
IFRoaXMgaXMgY2FsbGVkDQo+IGR1cmluZyBhIGNvbm5lY3Rpb24gY2xlYW51cCBhbmQgcmVxdWly
ZXMgYW4gb3BlcmF0aW9ucyB0byBiZSBibG9ja2luZy4NCj4gSG93ZXZlciwgdGhlIGVycm9yIHBh
dGggb2YgX19yZHNfY29ubl9jcmVhdGUoKSBjdXJyZW50bHkgY2FsbHMNCj4gdHJhbnMtPmNvbm5f
ZnJlZSgpIHdoaWxlIGhvbGRpbmcgcmRzX2Nvbm5fbG9jayAoc3BpbmxvY2spIGFuZA0KPiByY3Vf
cmVhZF9sb2NrLCB3aGljaCBjcmVhdGVzIGFuIGF0b21pYyBjb250ZXh0IHdoZXJlIGNhbmNlbF93
b3JrX3N5bmMoKQ0KPiBjYW5ub3Qgc2xlZXAuDQo+IA0KPiBMaW5rOiBodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9jaS5zeXpib3Qub3JnL3Nlcmllcy8xYTVlZjE4MC1jMDJjLTQw
MWQtOWRmNy02NzBiMTg1NzBhNTVfXzshIUFDV1Y1TjlNMlJWOTloUSFLaTlwSzZLRkFPZ21jYmRC
QkRBNmxHN2RYTV83c0ppQkFjcDJhUlNlRGk4YlJHOUFDSmFqZmlMZEstWWdOdlh5T1BxckpwQzV5
N2s5bm9EdDIwdyQgDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9uZXQvcmRzL2Nvbm5lY3Rpb24uYyBi
L25ldC9yZHMvY29ubmVjdGlvbi5jDQo+ID4gLS0tIGEvbmV0L3Jkcy9jb25uZWN0aW9uLmMNCj4g
PiArKysgYi9uZXQvcmRzL2Nvbm5lY3Rpb24uYw0KPiA+IEBAIC0xNzAsNiArMTcwLDcgQEAgc3Rh
dGljIHN0cnVjdCByZHNfY29ubmVjdGlvbiAqX19yZHNfY29ubl9jcmVhdGUoc3RydWN0IG5ldCAq
bmV0LA0KPiA+ICAJc3RydWN0IGhsaXN0X2hlYWQgKmhlYWQgPSByZHNfY29ubl9idWNrZXQobGFk
ZHIsIGZhZGRyKTsNCj4gPiAgCXN0cnVjdCByZHNfdHJhbnNwb3J0ICpsb29wX3RyYW5zOw0KPiA+
ICAJc3RydWN0IHJkc19jb25uX3BhdGggKmZyZWVfY3AgPSBOVUxMOw0KPiA+ICsJc3RydWN0IHJk
c190cmFuc3BvcnQgKmZyZWVfdHJhbnMgPSBOVUxMOw0KPiA+ICAJdW5zaWduZWQgbG9uZyBmbGFn
czsNCj4gPiAgCWludCByZXQsIGk7DQo+ID4gIAlpbnQgbnBhdGhzID0gKHRyYW5zLT50X21wX2Nh
cGFibGUgPyBSRFNfTVBBVEhfV09SS0VSUyA6IDEpOw0KPiA+IEBAIC0zMDUsNyArMzA2LDcgQEAN
Cj4gPiAgCWlmIChwYXJlbnQpIHsNCj4gPiAgCQkvKiBDcmVhdGluZyBwYXNzaXZlIGNvbm4gKi8N
Cj4gPiAgCQlpZiAocGFyZW50LT5jX3Bhc3NpdmUpIHsNCj4gPiAtCQkJdHJhbnMtPmNvbm5fZnJl
ZShjb25uLT5jX3BhdGhbMF0uY3BfdHJhbnNwb3J0X2RhdGEpOw0KPiA+ICsJCQlmcmVlX3RyYW5z
ID0gdHJhbnM7DQo+ID4gIAkJCWZyZWVfY3AgPSBjb25uLT5jX3BhdGg7DQo+ID4gIAkJCWttZW1f
Y2FjaGVfZnJlZShyZHNfY29ubl9zbGFiLCBjb25uKTsNCj4gPiAgCQkJY29ubiA9IHBhcmVudC0+
Y19wYXNzaXZlOw0KPiANCj4gWyAuLi4gXQ0KPiANCj4gPiBAQCAtMzIxLDE4ICszMjIsNyBAQA0K
PiA+ICAJCWZvdW5kID0gcmRzX2Nvbm5fbG9va3VwKG5ldCwgaGVhZCwgbGFkZHIsIGZhZGRyLCB0
cmFucywNCj4gPiAgCQkJCQl0b3MsIGRldl9pZik7DQo+ID4gIAkJaWYgKGZvdW5kKSB7DQo+ID4g
LQkJCXN0cnVjdCByZHNfY29ubl9wYXRoICpjcDsNCj4gPiAtCQkJaW50IGk7DQo+ID4gLQ0KPiA+
IC0JCQlmb3IgKGkgPSAwOyBpIDwgbnBhdGhzOyBpKyspIHsNCj4gPiAtCQkJCWNwID0gJmNvbm4t
PmNfcGF0aFtpXTsNCj4gPiAtCQkJCS8qIFRoZSAtPmNvbm5fYWxsb2MgaW52b2NhdGlvbiBtYXkg
aGF2ZQ0KPiA+IC0JCQkJICogYWxsb2NhdGVkIHJlc291cmNlIGZvciBhbGwgcGF0aHMsIHNvIGFs
bA0KPiA+IC0JCQkJICogb2YgdGhlbSBtYXkgaGF2ZSB0byBiZSBmcmVlZCBoZXJlLg0KPiA+IC0J
CQkJICovDQo+ID4gLQkJCQlpZiAoY3AtPmNwX3RyYW5zcG9ydF9kYXRhKQ0KPiA+IC0JCQkJCXRy
YW5zLT5jb25uX2ZyZWUoY3AtPmNwX3RyYW5zcG9ydF9kYXRhKTsNCj4gPiAtCQkJfQ0KPiA+ICsJ
CQlmcmVlX3RyYW5zID0gdHJhbnM7DQo+ID4gIAkJCWZyZWVfY3AgPSBjb25uLT5jX3BhdGg7DQo+
ID4gIAkJCWttZW1fY2FjaGVfZnJlZShyZHNfY29ubl9zbGFiLCBjb25uKTsNCj4gPiAgCQkJY29u
biA9IGZvdW5kOw0KPiANCj4gRG9lcyB0aGlzIGNyZWF0ZSBhIHVzZS1hZnRlci1mcmVlIGluIG90
aGVyIHRocmVhZHMgdGhhdCBpdGVyYXRlIHRoZQ0KPiB0cmFuc3BvcnQgbGlzdD8NCj4gDQo+IExv
b2tpbmcgYXQgdGhlIHJhY2UtbG9zcyBwYXRoIHdoZW4gcmRzX2Nvbm5fbG9va3VwKCkgZmluZHMg
YW4gZXhpc3RpbmcNCj4gY29ubmVjdGlvbiwgdGhlIG9sZCBjb2RlIGNhbGxlZCB0cmFucy0+Y29u
bl9mcmVlKCkgYmVmb3JlDQo+IGttZW1fY2FjaGVfZnJlZShjb25uKS4gTm93IHRoZSBwYXRjaCBk
ZWZlcnMgY29ubl9mcmVlKCkgdG8gYWZ0ZXINCj4gbG9ja3MgYXJlIHJlbGVhc2VkIGF0IHRoZSBv
dXQ6IGxhYmVsLCBidXQga21lbV9jYWNoZV9mcmVlKGNvbm4pIHN0aWxsDQo+IGV4ZWN1dGVzIGlu
c2lkZSB0aGUgY3JpdGljYWwgc2VjdGlvbiAobGluZSAzMjcgYWZ0ZXIgdGhpcyBjaGFuZ2UpLg0K
PiANCj4gVGhpcyBjcmVhdGVzIGEgd2luZG93IHdoZXJlIHJkc190Y3BfY29ubmVjdGlvbiBvYmpl
Y3RzIHJlbWFpbiBvbg0KPiByZHNfdGNwX2Nvbm5fbGlzdCB3aXRoIHRjLT50X2NwYXRoLT5jcF9j
b25uIHBvaW50aW5nIHRvIHRoZQ0KPiBhbHJlYWR5LWZyZWVkIGNvbm4gb2JqZWN0Lg0KPiANCj4g
VGhlIHRpbWVsaW5lIHdvdWxkIGJlOg0KPiANCj4gQ1BVIDAgKF9fcmRzX2Nvbm5fY3JlYXRlIHJh
Y2UtbG9zcykNCj4gICBzcGluX2xvY2tfaXJxc2F2ZSgmcmRzX2Nvbm5fbG9jaykNCj4gICBmb3Vu
ZCA9IHJkc19jb25uX2xvb2t1cCgpICAvLyBmaW5kcyBleGlzdGluZyBjb25uDQo+ICAgZnJlZV90
cmFucyA9IHRyYW5zDQo+ICAgZnJlZV9jcCA9IGNvbm4tPmNfcGF0aA0KPiAgIGttZW1fY2FjaGVf
ZnJlZShyZHNfY29ubl9zbGFiLCBjb25uKSAgLy8gY29ubiBmcmVlZA0KPiAgIGNvbm4gPSBmb3Vu
ZA0KPiAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnJkc19jb25uX2xvY2spDQo+ICAgcmN1X3Jl
YWRfdW5sb2NrKCkNCj4gICAvLyAuLi4gbGF0ZXIgYXQgb3V0OiBsYWJlbA0KPiAgIGZyZWVfdHJh
bnMtPmNvbm5fZnJlZSguLi4pICAvLyByZW1vdmVzIHRjIGZyb20gbGlzdCwgYnV0IHRvbyBsYXRl
DQo+IA0KPiBDUFUgMSAocmRzX3RjcF9raWxsX3NvY2spDQo+ICAgc3Bpbl9sb2NrX2lycSgmcmRz
X3RjcF9jb25uX2xvY2spDQo+ICAgbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHRjLCBfdGMsICZy
ZHNfdGNwX2Nvbm5fbGlzdCwgdF90Y3Bfbm9kZSkNCj4gICAgIGNfbmV0ID0gcmVhZF9wbmV0KCZ0
Yy0+dF9jcGF0aC0+Y3BfY29ubi0+Y19uZXQpICAvLyBVQUYgaGVyZSENCj4gDQo+IFRoZSBjb21t
aXQgbWVzc2FnZSBzdGF0ZXMgImNvbm5lY3Rpb25zIHRoYXQgJ2xvc2UnIHRoZSByYWNlIGFyZSBz
YWZlIHRvDQo+IGNsZWFuIHVwIG91dHNpZGUgdGhlIGNyaXRpY2FsIHNlY3Rpb24gc2luY2UgdGhl
eSB3ZXJlIG5ldmVyIGFkZGVkIHRvDQo+IHRoZSBoYXNodGFibGUsIGFuZCB0aGVyZWZvcmUgYXJl
IGluYWNjZXNzaWJsZSB0byBvdGhlciB0aHJlYWRzLiINCj4gDQo+IEhvd2V2ZXIsIHdoaWxlIHRo
ZSByZHNfY29ubmVjdGlvbiB3YXMgbmV2ZXIgYWRkZWQgdG8gdGhlIFJEUyBoYXNodGFibGUsDQo+
IHRoZSB0cmFuc3BvcnQgZGF0YSAodGMpIFdBUyBhZGRlZCB0byByZHNfdGNwX2Nvbm5fbGlzdCBk
dXJpbmcNCj4gcmRzX3RjcF9jb25uX2FsbG9jKCkuIExvb2tpbmcgYXQgdGhhdCBmdW5jdGlvbiBp
biBuZXQvcmRzL3RjcC5jOg0KPiANCj4gcmRzX3RjcF9jb25uX2FsbG9jKCkgew0KPiAgICAgLy8g
Li4uIGFsbG9jYXRlIHRjIHN0cnVjdHVyZXMgLi4uDQo+ICAgICBzcGluX2xvY2tfaXJxKCZyZHNf
dGNwX2Nvbm5fbG9jayk7DQo+ICAgICBmb3IgKGkgPSAwOyBpIDwgUkRTX01QQVRIX1dPUktFUlM7
IGkrKykgew0KPiAgICAgICAgIHRjID0gY29ubi0+Y19wYXRoW2ldLmNwX3RyYW5zcG9ydF9kYXRh
Ow0KPiAgICAgICAgIHRjLT50X3RjcF9ub2RlX2RldGFjaGVkID0gZmFsc2U7DQo+ICAgICAgICAg
bGlzdF9hZGRfdGFpbCgmdGMtPnRfdGNwX25vZGUsICZyZHNfdGNwX2Nvbm5fbGlzdCk7DQo+ICAg
ICB9DQo+ICAgICBzcGluX3VubG9ja19pcnEoJnJkc190Y3BfY29ubl9sb2NrKTsNCj4gfQ0KPiAN
Cj4gU28gdGhlIHRjIG9iamVjdHMgYXJlIGFjY2Vzc2libGUgdG8gb3RoZXIgdGhyZWFkcyB2aWEg
dGhlIHRyYW5zcG9ydA0KPiBsaXN0LCBldmVuIHRob3VnaCB0aGUgY29ubiBpdHNlbGYgbmV2ZXIg
bWFkZSBpdCBpbnRvIHRoZSBSRFMgaGFzaHRhYmxlLg0KPiANCj4gRnVuY3Rpb25zIHRoYXQgaXRl
cmF0ZSByZHNfdGNwX2Nvbm5fbGlzdCBpbmNsdWRlOg0KPiAtIHJkc190Y3Bfa2lsbF9zb2NrKCkg
YXQgbmV0L3Jkcy90Y3AuYzo2MTANCj4gLSByZHNfdGNwX2Rlc3Ryb3lfY29ubnMoKQ0KPiAtIHJk
c190Y3Bfc3lzY3RsX3Jlc2V0KCkNCj4gDQo+IEFsbCBvZiB0aGVzZSBkZXJlZmVyZW5jZSB0Yy0+
dF9jcGF0aC0+Y3BfY29ubiBkdXJpbmcgaXRlcmF0aW9uLg0KPiANCj4gSW4gdGhlIG9sZCBjb2Rl
LCBjb25uX2ZyZWUoKSByYW4gQkVGT1JFIGttZW1fY2FjaGVfZnJlZShjb25uKSwgc28gdGhlIHRj
DQo+IHdhcyByZW1vdmVkIGZyb20gdGhlIGxpc3QgYmVmb3JlIGNvbm4gd2FzIGZyZWVkLiBObyBV
QUYgd2luZG93IGV4aXN0ZWQuDQo+IA0KPiBDb3VsZCB0aGUga21lbV9jYWNoZV9mcmVlKHJkc19j
b25uX3NsYWIsIGNvbm4pIGJlIG1vdmVkIHRvIGFmdGVyDQo+IGNvbm5fZnJlZSgpIGF0IHRoZSBv
dXQ6IGxhYmVsLCBvciBzaG91bGQgY29ubl9mcmVlKCkgYmUgY2FsbGVkIGJlZm9yZQ0KPiBrbWVt
X2NhY2hlX2ZyZWUoKSBpbnNpZGUgdGhlIGNyaXRpY2FsIHNlY3Rpb24gZm9yIHRoZSByYWNlLWxv
c3MgcGF0aHM/DQpJIHRoaW5rIGl0IHByb2JhYmx5IG5lZWRzIHRvIGdvIGFmdGVyIHRoZSB0aGUg
b3V0IGxhYmVsLiAgV2lsbCB1cGRhdGUuICBUaGFuayB5b3UhDQoNCkFsbGlzb24NCg0KPiANCj4g
PiBAQCAtMzQ5LDkgKzMzOSwyMyBAQA0KPiA+IA0KPiA+ICBvdXQ6DQo+ID4gIAlpZiAoZnJlZV9j
cCkgew0KPiA+IC0JCWZvciAoaSA9IDA7IGkgPCBucGF0aHM7IGkrKykNCj4gPiArCQlmb3IgKGkg
PSAwOyBpIDwgbnBhdGhzOyBpKyspIHsNCj4gPiArCQkJLyoNCj4gPiArCQkJICogVGhlIHRyYW5z
LT5jb25uX2FsbG9jIGNhbGwgbWF5IGhhdmUgYWxsb2NhdGVkDQo+ID4gKwkJCSAqIHJlc291cmNl
cyBmb3IgdGhlIGNwIHBhdGhzLCB3aGljaCB3aWxsIG5lZWQgdG8NCj4gPiArCQkJICogYmUgZnJl
ZWQgYmVmb3JlIGZyZWVpbmcgY3AgaXRzZWxmLiAgV2UgZG8gdGhpcyBoZXJlDQo+ID4gKwkJCSAq
IGFmdGVyIHRoZSBvdXQ6IGxhYmVsIHNvIGl0IHJ1bnMgb3V0c2lkZSB0aGUNCj4gPiArCQkJICog
cmRzX2Nvbm5fbG9jayBzcGlubG9jayBhbmQgcmN1X3JlYWRfbG9jayBzZWN0aW9uLA0KPiA+ICsJ
CQkgKiBzaW5jZSBib3RoIGRlc3Ryb3lfd29ya3F1ZXVlKCkgYW5kIGNvbm5fZnJlZSBjYW4NCj4g
PiArCQkJICogYmxvY2suIFRoZSBsb2NhbCBmcmVlX3RyYW5zIHBvaW50ZXIgaXMgb25seSBzZXQg
aW4NCj4gPiArCQkJICogdGhlIHJhY2UtbG9zcyBwYXRocyB3aGVyZSBjb25uX2FsbG9jKCkgc3Vj
Y2VlZGVkLg0KPiA+ICsJCQkgKi8NCj4gPiArCQkJaWYgKGZyZWVfdHJhbnMgJiYgZnJlZV9jcFtp
XS5jcF90cmFuc3BvcnRfZGF0YSkNCj4gPiArCQkJCWZyZWVfdHJhbnMtPmNvbm5fZnJlZQ0KPiA+
ICsJCQkJCShmcmVlX2NwW2ldLmNwX3RyYW5zcG9ydF9kYXRhKTsNCj4gPiAgCQkJaWYgKGZyZWVf
Y3BbaV0uY3Bfd3EgIT0gcmRzX3dxKQ0KPiA+ICAJCQkJZGVzdHJveV93b3JrcXVldWUoZnJlZV9j
cFtpXS5jcF93cSk7DQo+ID4gKwkJfQ0KPiA+ICAJCWtmcmVlKGZyZWVfY3ApOw0KPiA+ICAJfQ0K

