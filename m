Return-Path: <linux-rdma+bounces-12867-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD613B30A9C
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 03:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5C91D00EC7
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 01:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FE61917CD;
	Fri, 22 Aug 2025 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kHpk4/UI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dk4wedFG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE920EB;
	Fri, 22 Aug 2025 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755824751; cv=fail; b=sjViKnnUYV06itSEekQ3xAKzUyQkCUL01i6pGqaY1pmc7s6LqF0fBwJEUK0V4PtKqXM3yHPNZr+6zlx8FMqJE8b/qCV2hmk9lFvJHN6aNAsrIp6u6qPm/ocIc7qwnZw3ShF2vE5RGufXqS9nYMP2Mjy2ft5g00BEX7tfw4vDnck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755824751; c=relaxed/simple;
	bh=hk2qW9y8gfurnETiYOPXgzilOyLtOiYzkuvlIdIp7yY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y6wY1ZQ/5vNyuMABBacg21VfUZ2KGE+ZRdn86h9GohrVMiEIin7+CW0e7OQ3G4r/z/ilL8UPTAaT+L3f8RvZ5oLiKN+62Y6mf+t63G4EGNWW3cmNjYmMb7+G835f7U6i2sqikceQgD5+GnyrH1V40/abngTeXOtBTDL7Kycz/Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kHpk4/UI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dk4wedFG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M0wUUo008196;
	Fri, 22 Aug 2025 01:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hk2qW9y8gfurnETiYOPXgzilOyLtOiYzkuvlIdIp7yY=; b=
	kHpk4/UIr0K6b3CRGC1wOmQvZq2qLzNF12Ij4UB1HApFC6OO2rHqxS3NF3H4F8WV
	MmMnMO/FbA2yiWyvxxBP6pD2auEwThqzegr0mYS2GrIO8TioQ0rYQMfWEI6m7ELT
	CVV1SOVpPTvmyRACyGz1vFvAg8WKvuBouTICznV8mWg6CGLWZwatve4HR0z1YEWz
	ciI/A/t/6ZZVyVBsjEtHlhqJDOguUxrA//QPaAgwOvYJgRd09qi94uob4EfLPiD3
	1607/Mw/tOCXBKfI5TdVJrpvnwPCm5ZAUjHd21lYjUL42hnG3XiNjk0u99PgOfEW
	B0J0m07ELKIQGpXoHxd/NA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0trvt95-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 01:05:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57M0bdTj030251;
	Fri, 22 Aug 2025 00:56:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my3w2t77-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 00:56:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOJAH2sPhClFz/6jj24PxsLu5SmnADP8rCGYlC7bQmzQddq4jXeo1WSwGQQPRjFyYn4FKTnBH+SOH+7q0Hhd73AsRD/H/zSNSf6ymJqm8agC5CEzxZ1wpmQscM+DJyaoqXbqf1v9xHejD4dpRwIyVB1YK0oHx2bKTjVFgoqtQFdOScX/c8BLgZmBXfKx5rvrh9Cduc5zv+GHNJQALj3r9Pljr0jRziN5rvKYOQkYUvGCvmwtzPdBQ8wn9FmAcpKMHPDvgvX4zj6b/Imv/2gy2CRh5QmYy6Cb0hl7mmJQkJU9cVSfrSrowMipcNb5dhyyytFGXhvK5QpbX3AAyk0eOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk2qW9y8gfurnETiYOPXgzilOyLtOiYzkuvlIdIp7yY=;
 b=EFvi7Hr+kqYH/eRWazywm5e61VPcWYUgOAsuKHAmBrLK7ns4VNHUFxq6TAi/zX5WKd7Si5Vt6gya+K+F2VuMD00xCL3ieI8U3tpIj4BSMEY/jMXgFvuN7El4YAmDi0fpbnJU5Hjkkmzq9/jaLS0gE3szXQC/2P57gUiSaZ3/Gm+/Vb90kzc9R1rdRc9AWJje3RLwgfaJGHzMPFdcdWeXvmwl4EJ5w2DLy0ppqQbsjOTJjWiy9x2hvG6EJsK2CR9hb1aZJXlyz5UDD1N2RLKdYOSip2vYYJiVbiBBfqne+E+HMpIevoB0RIIjawDkppQTIBsd5KTDlmKOlMK9RhenNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk2qW9y8gfurnETiYOPXgzilOyLtOiYzkuvlIdIp7yY=;
 b=dk4wedFGqLAiEDWNwxN3OB5KsZHiOzd7UYCzp/Vp6CWJmOKaaQZKK+7Dlsmygtyi1vEyagGPv3LM4UWHHFS2goA9vz/kT9nYjTo6v/lbCjyNaMasfufqN35gp83E7MKVEYa+Tr2lATMtMwyywzk+TkvxdpxgzkRDwXq4DlfEb6M=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 IA3PR10MB8613.namprd10.prod.outlook.com (2603:10b6:208:577::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.15; Fri, 22 Aug 2025 00:56:16 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%7]) with mapi id 15.20.9052.012; Fri, 22 Aug 2025
 00:56:16 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>,
        "ujwal.kundur@gmail.com"
	<ujwal.kundur@gmail.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/4] rds: Fix endianness annotation of jhash
 wrappers
Thread-Topic: [PATCH net-next v2 2/4] rds: Fix endianness annotation of jhash
 wrappers
Thread-Index: AQHcEfvNj5NFBJHZCU6LEDBua52ZqLRt2yYA
Date: Fri, 22 Aug 2025 00:56:16 +0000
Message-ID: <ef1242e4513f700795055cd50763576511e51920.camel@oracle.com>
References: <20250820175550.498-1-ujwal.kundur@gmail.com>
	 <20250820175550.498-3-ujwal.kundur@gmail.com>
In-Reply-To: <20250820175550.498-3-ujwal.kundur@gmail.com>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|IA3PR10MB8613:EE_
x-ms-office365-filtering-correlation-id: 4235d661-dac4-45e8-6f93-08dde116b310
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NHpTZDR0WE1iZHRHZjhzd0tpMEpSWnk5Z2RVOGZqMDdsT3ExTUp6Q0M0QTA2?=
 =?utf-8?B?TktFNHhtV043b2lSdWZzbDhWejZWekV4VTgxT1k4WklEV0ZpM2Y4aytPRXZI?=
 =?utf-8?B?ZVFHWml0SEJ1a2pObzdtdy8xNmR0Qks4eTI3LzhSejR0U0h5dkVGWXNnbGhY?=
 =?utf-8?B?NVI3dkJUT0VxTFRQWW5Wa3FWYzljM1RpY2FtMGZDQkt1L2EwdEg0M1hCc0Ev?=
 =?utf-8?B?K3lVOFBVUnJCdEJyQVRSQjJWaE12RHFXQnJjblRrUnkyZ1VOR3pzSXdIRm94?=
 =?utf-8?B?Y1VJbTRUVHpkYkdmMXhsZHVxQzljdkU2K25xUnpKcjdqZ2t5bGdpSzdNZ3FJ?=
 =?utf-8?B?cVU5a2hienordm1pRm93Sk9ob3VyYWhWRUxEWlhuZDRuREx3d01OZHBSY2NC?=
 =?utf-8?B?bTltQjJlTWVWZUo4UmQ5bUJONXYya1hJYUpXdjJJcWo0OW15WFpQd083YWxF?=
 =?utf-8?B?djZHaVFxL1ZPS2JtKzA0emd2YjkwVUY1eS9ZOEp0UjVGWEJjYVFLZlNSRnlq?=
 =?utf-8?B?NWh0eEZJZ1kycEtoNzdsM0E5a1RueldNU0hvSjZFM0t6MFRnWUY5WUtjQTAy?=
 =?utf-8?B?QW5EU1VIUi8yVmtaTzVraDUzR09EVUliQkRLSkRxNmNLanRFcHRuRGZZVmxC?=
 =?utf-8?B?dloxbWNOWkNlKzVzVTk5TC9mbmdET1JmcXh4eU1rbE4yQ1phd0dTdXFsQzVF?=
 =?utf-8?B?OWE3d2lSTThLNE1OQUZLQWIyQnFNV1g3c2VlMG9vZzFHR0R6UUF6ZUw0bE5D?=
 =?utf-8?B?V2RnZzZsN2ZQVnR6eTUyT0JMVDRMdlhxVnNJMmgwUGJkcjQ0SzE2UGNHRlF4?=
 =?utf-8?B?Y3Y1T0ZkUHB5QkJPdXVYSDFFcllrNmhlcGhPSzQrK2FETFc2VysxVjc4TUd4?=
 =?utf-8?B?VEFEc3NkV244cFRQWnBkU040MWNUbmJ0TzNvYm10NVhPVFNXbitrMURUL0xq?=
 =?utf-8?B?NGpIMTBDZVMvLzRtdUJGVHIwYmdDSDBkRTIzMkRkV0dVbXRBY2dWdzM1Tlgr?=
 =?utf-8?B?NmJrYURGY2hWYW1TRWV4dmZuK1NJNzAwQlBKenlYaUxKNWRCSGc2Y2t5QkJL?=
 =?utf-8?B?VU1nckpvRDhMNWNIN2E0Vm9ISHdjVUo1ckFYRG5zSGxDMTFxRWtTcUd0Y0s5?=
 =?utf-8?B?UWR0NjlZckw3NWxtd1pjeGNwWURaSTNtWGdXK0pjY05IWk53SzllWWdXSGVG?=
 =?utf-8?B?RmJXQnMwZzFrWHk5TFJFY2s0alNTWGx3U0RGQk9hclpxUFBLWmpHeG1LT2VS?=
 =?utf-8?B?ekRONEhBdDlsTk5rbmY2bzVOK1BFREtqT3VxOE5YYmJGM3RuaFBMQk5UeEJ5?=
 =?utf-8?B?Qzd5MmpKUjdwckpjWnhsVXJqSHAvQXMvS0todjZVV3ZjTG51bjZMV0RQNTVR?=
 =?utf-8?B?OEQvVCs3M1pZdkRPS0FzL2FLaVR3RitqV3FQQVovbFB1TGp6b3JsQ1FQdUhh?=
 =?utf-8?B?NmJFS1NJTHEwSXFJMmwxT0g1QVNSNEExb29xN1ZoZ09ZVnlod04zT1Z1aHFs?=
 =?utf-8?B?dG1PTUN0K2g0ajV5dFVRQy9MT1ErRHVZRzI5UG5PbUtXVkdDZjRwQ3QyNDBC?=
 =?utf-8?B?UFJmRDFMZ0NwM2JLK21LYWhHQjNHcUpBTS9BSndUNnVNWjNtYlZxQWJIazBs?=
 =?utf-8?B?TDNEUE5NUnJWeHlzVG0rT1NhZUhGWVZScDBIQjlYSXhUMytpQU50MVNLdmMz?=
 =?utf-8?B?K0taZTlTVFJoVE5uYUtaNEN4UXN6eDFyeTdUU2hJaUpuYWxhV25xbWhjMjFF?=
 =?utf-8?B?OVRha1RMU015SEw5cFdZdDdnNkdkWDBjcmhEOW1Fc2J5RFZqekRVVlVEYUY3?=
 =?utf-8?B?OUpOSVdzaDZ1ZldBSjh0VU1oRmJwcUs0RU9pN1p0V0pmWGYrTjNqY29sbTA3?=
 =?utf-8?B?K2YxQUdiVkZnbFNuWUk1L2dPTTAvR0NHbnhRMFJtWWQ0bXcyOEpOYkcyUFpP?=
 =?utf-8?B?Z1lJWGZHSkJxRklnMEVUWnJqRzFzMmhxRG8zcVQ3VDExTzV2UXp5TDdsNEVT?=
 =?utf-8?B?MTExUDFhR253PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUNEekJxZGtRcHl6dUY0dWswMzBPSmdCVGp0a1IrekpYbU9GRGJiNE9XMmNm?=
 =?utf-8?B?cS9MU2JwUWxvUi9mVC9YUU56cUJleTdlcTRMdzdmUWxaMDNRS1pFSTQ1MEto?=
 =?utf-8?B?bWFVSEdqbklnRktIOTIxU1p2cHBLREJNQ1VSZ0NlT0pZL1JZTVBBUEE1NlFQ?=
 =?utf-8?B?c1cyK1Z3blBwekNXcW1OQ3JhNzJhRmpUeTZ5TzJkWUZIRG4xSW8zZlg2Y2FD?=
 =?utf-8?B?ZlA0KzN1d0h6OEp2NDZqeXEwUUJDamluL2tuZGpaTmQwYS9NQnVoREJLKzhC?=
 =?utf-8?B?L083RkltbVZndi9zelphaHZxRXZYVXpVQXJJVlV6UkY5azlzTVFSMUduMkw1?=
 =?utf-8?B?czNKd1gwTWdTdkNuRG83WUpYd1d4UElTTTV3SzFBcWNlMzV4d1BsKzV6dWFv?=
 =?utf-8?B?akRvTHBxcjVGNjBNbDdORzYxd3hsd3ZndjM2cEl1b1QxTFBYWmFCWUw0ckh5?=
 =?utf-8?B?S2cwdEh3by90dm1mQkZpeUFJemI4QjBTUVBSMXdPNWVBb1hGa2VITVFiS0hK?=
 =?utf-8?B?NVpIVkowMDhOOGRMR2F5emQyUWFSWWJnaUxDT1dEcGd1UTdCeTYyc1Vsb2FM?=
 =?utf-8?B?MUcvSm1OYUlCV0lSUi9ValBmRFFveEZ1Um44Z1AxMndoaWRXUkdQd2s5anFz?=
 =?utf-8?B?T3RiTXBSRk1wS05pdkNFZ2JDUUs3TzZUTTRac0hRamNWLzNGekNucUZ6TjNn?=
 =?utf-8?B?aU5PRTBibDRXdWpkTkhwVEk2VER4Qm1zVHd1ek5YaEl3OEJqeFJldTRTYkFp?=
 =?utf-8?B?YkU5S1BlbUl4VjB2dTRyQkQzM3phbjJuejlWdVEza21yTUtYYW9DZ0dmQTlY?=
 =?utf-8?B?YjlnVGJQWEQ5QVlnSWRRT1FrN0dxR2RVYys0cGZ5bGVTZHlEMVJoR3Q0RFc2?=
 =?utf-8?B?cmg3aXdwSkkzcE1KUVBZKy9zZ2tpNUFabFltMmtBMlpyNVh5eGhVRWZiWUMv?=
 =?utf-8?B?VVZ3WmNVZWZsaE5LeTdvN2FtSnBKb2pjeDNHNkNnR01yd1h6UVowSzBPMjRI?=
 =?utf-8?B?TnZYZ1JLa0NsR29VeHN5RGx3VS9vK3FwejFpVFZVWnhtaGZjUWZsbmFyeEJK?=
 =?utf-8?B?RzlBcTJRUGtyUzd3aXdsM2ZUSDNxOVdtRU1tVWRWelZZWlE3Wi9TN3ZmSnYy?=
 =?utf-8?B?bUkxMkFUUHBiS0I4dGkyZDZYdnZFUVpSZldaN2JiTkdtbXk5a2FFUHNvZnZT?=
 =?utf-8?B?WWl5QjVybTlrWFVYU2xia3RjK2JXVWFZYXRTcVBZSnJWbCtWQ01XRU9wOXFr?=
 =?utf-8?B?LzZLaTlMTml5WEFxdU9xNjE3QkE4cjFlNkhNQ0gvRHViSW4ycXMwaXdmQ3Zz?=
 =?utf-8?B?d00wU3hYeDlmaU5lNjRWclNSWnpRcEZZcWF2eXdsSUR6QnhIb2diS1AyUjJR?=
 =?utf-8?B?QmhHZ1p1bHh6MmFjd2h1Q3h5TmJKUDdwUGNyOWk5UHNLcXdIRjlZWndZbUJ1?=
 =?utf-8?B?ZzRsYUVoRytjS0tYRmMzYjg3R2tCREs5RU5MdXRVa0xEUW8zWTcyWnplK3lT?=
 =?utf-8?B?ODNaM0l3YXNFaFBveC8vOUlwZ054bWNRM2FnaFhpbzAyZlcyNE56TGJPV3FH?=
 =?utf-8?B?VFMrbHMwMW1MVjc1YVdXZ09sQjV0RFA0c0MyWEZvaXZwL3pFUElVNU1IZFdL?=
 =?utf-8?B?dElvLzk4WUpEaVlkWkpMYjdTdXZ3aWxaUFlINWt2bWQwS1RaWm9JbjRickxM?=
 =?utf-8?B?OFBNM1V3SEVMRC9MYXEySFlwR2t6R1NEUlRTYmJSeHpYMWJQYys3Sy9KcXZk?=
 =?utf-8?B?MnRsbC9jL3MrZlJKeFJieDhDNWI2N0JHNzVLaWVlRi9DNmZ3ZWRLdERKZ2Vt?=
 =?utf-8?B?ZlNsRmJ2aFY1UUJKelN5N0ptWDNjQ2JHV05JYktpMFl1WURqZDM3bjk2ZVBx?=
 =?utf-8?B?VE1TSVd6amtDWFpVVFNBOUw1VXNlNnoybjBJME1XZGNUeDFwRkYzRXJpam1S?=
 =?utf-8?B?YUdENzBrN0VaMit2Rm5hdEQyaWN1MldoY2dMYUUwUWludUtPTjhtWnpSdGNX?=
 =?utf-8?B?dk5udythV3dqWHBUbTZMcWpnQmhKRmJlOFd2MldTYkZNSU1TblZlQkRyU2JS?=
 =?utf-8?B?ZHBFMGRkQWdXbDVxOFAvejh5Z1Y0clNkWG1kMk15V3NXam5yQmoyVStJZEU4?=
 =?utf-8?B?SDlzZU9xNzNmWUIvek4wTlptVVk2WTBDYjZHVEU4TU5OQzRPSVY1UThxY245?=
 =?utf-8?Q?M1Z9Yx8zfAOVAaVNuODHFXE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2339D732DE49864D8484253E43E47F01@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kInhvG5Zr+cVw2v+jCJHNAIxtGpI2lz6MMr9wV78SJ7+Nd45wcabaIo/Xv8q7lzTGZ0sKFZj4bZ84PF/MyJFz9I01TeTHNmNymnNZvGEpVbMWm9CY4KHgGCfY/ox5/1IZEvmZKJDhXy1mPaSxFgVq7zUYhKJus7P2AAP4r9HhAPcc/pInYllRFfI3YE84u5W6MhY6pjXsj1Wx7libmGl1+kQSqhIUOt3xoUNbJtXZABxVNdeFvx+Fo47G5ZKv/NkiMyJ1tt+njMdZ7hkya7FuZE16O/TKTvam66oa7BK/YhE8cagOMbCySr+d+0jTnPQmQinPlmfh/xWvTX8MevXoM2O6dtI0SjdplEnxae6HaMCMlIuQX5cKCV7j6gtXEf+qvOeefp12ylpF3B0n6Mf3fHY0KC3af41Z/2YJCPFlJYZMkzj1eV9kpcrcINWn9KkzaZ2z+/jxDCcea1tQ1Ea5PJDFAiiylHowFKTigfJQWogPhps49PitWS6mth1YGAfGyx6x+jZ0Uhx/jFOpdnu0noYHq38nSZHbJDL/LWBcPXBZGXsOHe3Q/jrfOXdmcm2elNs5AYamvjCiiS4Zg7gh/l9bSPZ/vBdpqlWAFoMUtQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4235d661-dac4-45e8-6f93-08dde116b310
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 00:56:16.6109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nw96mjLSW9Q36oTF3mduDpohNzOyvEd1Vp91yzJAn+/Do0+sG0/Yq2AXaJf5a1ZI9bEe/f559/SJw9qHYxOb8KzyxHmML4/yvC79sniym+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508220007
X-Proofpoint-ORIG-GUID: CJ-M70mTcdNmRgK9oynrgvgsveSMljHg
X-Proofpoint-GUID: CJ-M70mTcdNmRgK9oynrgvgsveSMljHg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX1kolrJVejS+5
 xgg7Vt5ojlRFdSpju0LcyGm+/YEfJlTMegLMv+O4xM0cB/WwBI4MmLSa1ii+RjbsM6LqT4M2kDY
 Ppns7S3OaosN8hSSkLNs8Byg6+keZszRdoROKRjYL4xjbJDzURpi9yAglKOyU/f8qtIVsZoNf+p
 pdj88gPeHU3DcOuVt0MsOmYrvXCy7Lb3ui0PnwLe31c78pXVe8+XbrUtsr/rnn7tFVSanYQrkYn
 yEhEtFMU3NBiKTACu0uwuKACYcNMd21NgLAbWGX0oXcda2oh1ulYzVH1NgKpKBc/K8EqEttJ6GH
 pRwxAkNu554l6SSnG/AZ7mbf0i+/9ZwIiPdWKP8r9h2zGVqpty2Bzg8YCIl64q/ricTIiBO8o+i
 5iGj2pg6vjq1bt2lVKwdCPSo/NRCNWJMuWAGdALcjBjhqJ6Cn24=
X-Authority-Analysis: v=2.4 cv=Qp4HHVyd c=1 sm=1 tr=0 ts=68a7c266 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=iHY_PqY_tJdd_LopGHAA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13600

T24gV2VkLCAyMDI1LTA4LTIwIGF0IDIzOjI1ICswNTMwLCBVandhbCBLdW5kdXIgd3JvdGU6DQo+
IF9faXB2Nl9hZGRyX2poYXNoICh3cmFwcGVyIGFyb3VuZCBqaGFzaDIoKSkgYW5kIF9faW5ldF9l
aGFzaGZuICh3cmFwcGVyDQo+IGFyb3VuZCBqaGFzaF8zd29yZHMoKSkgd29yayB3aXRoIHUzMiAo
aG9zdCBlbmRpYW4pIHZhbHVlcyBidXQgYWNjZXB0IGJpZw0KPiBlbmRpYW4gaW5wdXRzLiBEZWNs
YXJlIHRoZSBsb2NhbCB2YXJpYWJsZXMgYXMgYmlnIGVuZGlhbiB0byBhdm9pZA0KPiB1bm5lY2Vz
c2FyeSBjYXN0cy4NCj4gDQo+IEZsYWdnZWQgYnkgU3BhcnNlLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogVWp3YWwgS3VuZHVyIDx1andhbC5rdW5kdXJAZ21haWwuY29tPg0KVGhpcyBsb29rcyBvayBu
b3cuICBUaGFuayB5b3UhDQpSZXZpZXdlZC1ieTogQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24u
aGVuZGVyc29uQG9yYWNsZS5jb20+DQo+IC0tLQ0KPiAgbmV0L3Jkcy9jb25uZWN0aW9uLmMgfCA5
ICsrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvcmRzL2Nvbm5lY3Rpb24uYyBiL25ldC9yZHMv
Y29ubmVjdGlvbi5jDQo+IGluZGV4IGQ2MmY0ODZhYjI5Zi4uYmE2ZmI4NzY0N2FjIDEwMDY0NA0K
PiAtLS0gYS9uZXQvcmRzL2Nvbm5lY3Rpb24uYw0KPiArKysgYi9uZXQvcmRzL2Nvbm5lY3Rpb24u
Yw0KPiBAQCAtNTcsMTYgKzU3LDE3IEBAIHN0YXRpYyBzdHJ1Y3QgaGxpc3RfaGVhZCAqcmRzX2Nv
bm5fYnVja2V0KGNvbnN0IHN0cnVjdCBpbjZfYWRkciAqbGFkZHIsDQo+ICAJc3RhdGljIHUzMiBy
ZHM2X2hhc2hfc2VjcmV0IF9fcmVhZF9tb3N0bHk7DQo+ICAJc3RhdGljIHUzMiByZHNfaGFzaF9z
ZWNyZXQgX19yZWFkX21vc3RseTsNCj4gIA0KPiAtCXUzMiBsaGFzaCwgZmhhc2gsIGhhc2g7DQo+
ICsJdTMyIGhhc2g7DQo+ICsJX19iZTMyIGxoYXNoLCBmaGFzaDsNCj4gIA0KPiAgCW5ldF9nZXRf
cmFuZG9tX29uY2UoJnJkc19oYXNoX3NlY3JldCwgc2l6ZW9mKHJkc19oYXNoX3NlY3JldCkpOw0K
PiAgCW5ldF9nZXRfcmFuZG9tX29uY2UoJnJkczZfaGFzaF9zZWNyZXQsIHNpemVvZihyZHM2X2hh
c2hfc2VjcmV0KSk7DQo+ICANCj4gLQlsaGFzaCA9IChfX2ZvcmNlIHUzMilsYWRkci0+czZfYWRk
cjMyWzNdOw0KPiArCWxoYXNoID0gbGFkZHItPnM2X2FkZHIzMlszXTsNCj4gICNpZiBJU19FTkFC
TEVEKENPTkZJR19JUFY2KQ0KPiAtCWZoYXNoID0gX19pcHY2X2FkZHJfamhhc2goZmFkZHIsIHJk
czZfaGFzaF9zZWNyZXQpOw0KPiArCWZoYXNoID0gKF9fZm9yY2UgX19iZTMyKV9faXB2Nl9hZGRy
X2poYXNoKGZhZGRyLCByZHM2X2hhc2hfc2VjcmV0KTsNCj4gICNlbHNlDQo+IC0JZmhhc2ggPSAo
X19mb3JjZSB1MzIpZmFkZHItPnM2X2FkZHIzMlszXTsNCj4gKwlmaGFzaCA9IGZhZGRyLT5zNl9h
ZGRyMzJbM107DQo+ICAjZW5kaWYNCj4gIAloYXNoID0gX19pbmV0X2VoYXNoZm4obGhhc2gsIDAs
IGZoYXNoLCAwLCByZHNfaGFzaF9zZWNyZXQpOw0KPiAgDQoNCg==

