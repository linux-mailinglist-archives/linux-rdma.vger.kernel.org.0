Return-Path: <linux-rdma+bounces-12865-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31248B30A86
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 02:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AE0165DCB
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 00:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BAE1547EE;
	Fri, 22 Aug 2025 00:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Te5fIORN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WnQC0dBs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B1347C7;
	Fri, 22 Aug 2025 00:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755824183; cv=fail; b=bIm7mIMBjeZVblIDeHm5Natjo/d+doVaI2ZfgxChQwp0gU3fa4gdXxBR8J6sqy87HvPIKQc5qO86pKFzgRYKHuSjFGQmEd5MUiA69bN79MMobrz0slf6DV006zkYoB2rR/2ohLNVWUe9OXHxq5Zf6EYHbeZ3eSdIKhq56LgyMQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755824183; c=relaxed/simple;
	bh=+V/CCYipvrxo7d0GkACTty63+VB4yNUSXOMHWoLVoeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fdAfiHZfvpFm+YWBZSWdg2cRfTvwbNOAJX0RcW2xuV7L+LQLqyIhQkRiYATO+R1Y4x0qDKIK6uggGAd8KygSVnlsaEeGMC75jYRCyKahXc/92S7Prvg9XY6XTDUiMgIKnpR0M+YuuGloGTiMwOr1riGp6Ta2sBPssmNLfFhVB70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Te5fIORN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WnQC0dBs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LNYvtl000993;
	Fri, 22 Aug 2025 00:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+V/CCYipvrxo7d0GkACTty63+VB4yNUSXOMHWoLVoeE=; b=
	Te5fIORNLM5D7cTCZoaJ0xAyvY283LHRejkO1SN1XLIXCzXz72Tse2KvLpFy/U0f
	oEehg7Wvuda8VthvKL+hvBF2Xm2nnX9h4im5CzcwV4i3B1oJ+pvFZxY9kUOIAF4U
	D37lRnJzlMqZnLDeCyF6xJcyJ4Mzoarn/oXR/AA4whCYtaIJSsgsoS/tKWSdrMDI
	wHjzE1bmrKM79gXX2R7S1HBJVtOxCBYYaH0GSTSpqMNO6fPfWnQgUQ9b5c/Jv/Gy
	ysP1ce2yZzNWHrszdTozpUbHAw28Pdpx6CHkVmXVnv2n21pMzfBq9zGlmFzzgySy
	EhMpZKmbgrmkneT49HWCVA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48pa268c2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 00:56:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LMKBpj025359;
	Fri, 22 Aug 2025 00:56:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my43aj0t-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 00:56:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldbysu0mq0LjrylhOwgPtQ2hOdoPQOzYGfNqP8TELR56NesOeJfNHhYjP0f0jweU+xI+GZA1VZhdPbzz90X7OVAoYt3OVgKwD3w1Xi3CEYIprBeuZCiF0WYZcHdbU5DwYJtmckOD+xCZ7RpOwZCmXuiJbB5xJikLGBkIDAXw7a5aUnCtq1drI9bjTeqnZN3kknCG1XaAfnt8u2jFjSkv+IYpOZOYGODb9NcJMk4crQ9ABqNjApYEGQVgKURLTWynFgl1MQvz/3F6jasuX1PREHVki/g6n0jKZtSRfTEIItmo3Kb7z4iZ28NUVl+2cy7y2ufvkhceo48ANxomV1IpnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V/CCYipvrxo7d0GkACTty63+VB4yNUSXOMHWoLVoeE=;
 b=SGlFuMQrgZRT92oRKEvbi4OFFF13Wxxx2CBYqnAOFpmd2CAMWkBeJWhwoF4v4jCrZxKi/fTv6B0Xf6xQgvPMvVAaN438TV3v1nZ3xMrp4JD9vaJesv514jyY2/AU+w7SNRCrbavPnYg9AhqUleSXnSirD25OOvTmFKsT8iZbW7AFLY36bvagi1wrTrUPgtCpm3fpKjOj1tzdluI+whs5Ae/y6WnqdXyqVPDx/xunjrb7zR/R7naFELmhMtmIUXFBG4tVVePOsCxqr8oDAoZTOkZzhAyoTeimM5h5m7yxe7xpboT87LGlvy8fSFFadl3gOg3LLGijAyX5DlRh7ooS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V/CCYipvrxo7d0GkACTty63+VB4yNUSXOMHWoLVoeE=;
 b=WnQC0dBsStR+d8sHR5wZ2e1nBryuBUqpAwZa1xK2qPm6xbGJuse0ehzx66CR7myXByABLMHUZRBh1f3TcuK5ZGCOGiLW0xh0ZXm7C1culQSG4yNE82SVTdx9lZ3zIeNr8vqKJ70vAay/McW2tWyFJAl0Lcys0sNJVmZQzuHP3y8=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 IA3PR10MB8613.namprd10.prod.outlook.com (2603:10b6:208:577::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.15; Fri, 22 Aug 2025 00:56:03 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%7]) with mapi id 15.20.9052.012; Fri, 22 Aug 2025
 00:56:03 +0000
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
Subject: Re: [PATCH net-next v2 1/4] rds: Replace POLLERR with EPOLLERR
Thread-Topic: [PATCH net-next v2 1/4] rds: Replace POLLERR with EPOLLERR
Thread-Index: AQHcEfvLmQ0kbvuJkkGL/xb/bh8oCLRt2xUA
Date: Fri, 22 Aug 2025 00:56:02 +0000
Message-ID: <424b341fb66d22edb1fee7f295d281e112979985.camel@oracle.com>
References: <20250820175550.498-1-ujwal.kundur@gmail.com>
	 <20250820175550.498-2-ujwal.kundur@gmail.com>
In-Reply-To: <20250820175550.498-2-ujwal.kundur@gmail.com>
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
x-ms-office365-filtering-correlation-id: aecf6545-aa57-42cf-d739-08dde116ab06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MU01ZjNpNkJJZEh2NkVKcVR1Q1R2WnFYNHhxY0pkZmxiK1JGejBhZFBtb1N1?=
 =?utf-8?B?QjVkbHJBQUFpL0JoK1VQNS92UjJYOWZwbi9zQ0lwZldwdU84MXlPMFhLVWE2?=
 =?utf-8?B?Vlh2MUxBWS9YbkkwcFNMaDVKdStKV1YyQTZDSk9PTllpWkt6TVg2ZTYybmhS?=
 =?utf-8?B?MVYzcFdScXQvby9aYTJjWWRXSjNJUTlpOElQL1ZoaFFqbUhoWTFyZzNJUjlS?=
 =?utf-8?B?MDJ2ZFU1ZkdFMnkwZFFYTTI3T0hzTWNCRmZTdmM0SGY1dXEreEgwNHZTMkFa?=
 =?utf-8?B?L2h3bXJUODdscVB6ajhxOVVJeWNYL0p2Z2JUcE53NGpJcXBCS005dFQwZ3Jh?=
 =?utf-8?B?QVErbHE5R0psU2gyYm5BRkZlS0hZelRUcXAvS0R0TjJhR0tsYkJKQWhPMDNM?=
 =?utf-8?B?TmhnOTNkQnd5NmVUMEh4a3B2KzBqRDZYR2NVV1JGZjdqRFJZaWtuSDJmRTlR?=
 =?utf-8?B?YzlZTU9PMURib0I5M0NUVE14TEppVjBKQlZrdjZKUGhXNWFKejF6T1lCTVpB?=
 =?utf-8?B?QzFFb2M2aXU3NHBwWXQxSDBaSnhBaytBMXYzTkFIOTFXeFRjL3JBS1U4QUdE?=
 =?utf-8?B?WGxWRWV0Y2hETmJGeFFUdCtkU1c5Tkp3Y1R1S0tFcnJhTXpEaTJXL29lbWlZ?=
 =?utf-8?B?YktwT3N6VVIzYm1XanAyYmhVdForUkticXAydzlPWjg0TnZFdkhaZ0hRQks3?=
 =?utf-8?B?SlBjYkZnV1VGQnlsc3lhOVdmNll5cUZId3h0cHRtSnY3SWlDMFJ6OHBXalpu?=
 =?utf-8?B?TUVrVVZ5SGh4UHA5SDBzb0NXQU5vVjBvS28yYlViSC9kSUJRKzJId3NhSXBU?=
 =?utf-8?B?MTZoNTExZUdma0RCU29rTTR6UWt1anhLd3VNa09uQ0JkdjBIazVxRytYeXV5?=
 =?utf-8?B?WTFnd0ppbUdpSTVGenAwWXJXTlpaVy9qMFpucVJYK2dNLzRhaGhKcHFRUzN3?=
 =?utf-8?B?OVJYL1FRS0FGUGtQem9MM2hXaE1zS0lWZlp0Q3VVQjRwUHl2dHd6VFdoaUc3?=
 =?utf-8?B?bzMva0VzZkZ0SGdmOWdKeXhOQmE1Q1dIZXRRTDE3QjNGb2phZU9FTFpCcjd6?=
 =?utf-8?B?aUxvNkZUU0lDUU9mUlZUSTJLM1hWT1VjQzg0Z1pHaFZVNHlYbnJ0bEtDQ282?=
 =?utf-8?B?QmR1V2lOclFWTk5NeUFWQWxpWUFzVEFJVU5vcUxlcUVmaHdsMnFESmQ1VGVq?=
 =?utf-8?B?QVQ2cDVidkNQOXZsN0grbSt2cENqcWVMM0JkQ2g2eWo2U0hmc3RQRGVrU1h4?=
 =?utf-8?B?Zk05WXMxUW10c2dwd1d0b3VadFJ6MjFuT2V3d1ZWQlpoSUN6T3F0dzJyZW5h?=
 =?utf-8?B?S1JTeFV6RVVEcXk0OTh1bm9KVzF3OG9OZU5XZUdPbFlXSkNaSTJaelBZQ012?=
 =?utf-8?B?aXh5OSszMzRDM0tiVGk4cWJEYjVtbDJxUGtzUmFETElPK28ycmt2QWFFdDRC?=
 =?utf-8?B?b0tRbDlYRG5WQWtxck5ic3lUa0E4L3ljY0dnQWtBclUyWDEvMi9oM2NQdFBD?=
 =?utf-8?B?VUU3bnVwZGtTUkJKQWF5ZlpLVEJaTm5vOTE0ekFNKzQ5QTgzWXZ5YXJ0c215?=
 =?utf-8?B?V2ZBWkYzVkZVVjhwY1RMNm9wQktWWDczc3pudWZFUEtjWlp0MG9pMlVlZ2V0?=
 =?utf-8?B?Y0pHVENTK2JVNWI1VVdndUdsM0ZCN0phenRGeXBKVWlNaDRpSGVxakNxUzRL?=
 =?utf-8?B?WTlKdVNaNFFSMVRCb1ZEbFRHT01nSkNMNkdZditHZFpDL2tFeW5kNE8xcFFj?=
 =?utf-8?B?Z1RzREJqS1BzOHlBRHFiVkVrR3hvR3lHcWw3L2pEMFZCdUpTQkVYT3VERE1v?=
 =?utf-8?B?c2EyQTYzVE4xTFVMZmJWUldqRTZybFo0bDcwTHFCWUdEaVJCZ1RxUG9uQUdD?=
 =?utf-8?B?a0pZYStZT2hBSEg0SXcySkhRZVdEK1JvT0E1UUlxZjFhTS93VVUwN0wxeHpF?=
 =?utf-8?B?MjJIcHZ2TVlZZmhnaGxCZXBUcmJUQytieUkvZWNSOTE2NUxOQmRwM1pzUkU1?=
 =?utf-8?B?ZXc5bzhPVVJ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0pKMmREVlpxcG9EMUlnM0dmNW9MVmZVcjAwNW9VaGh2VGdRaW0ybThFeWoy?=
 =?utf-8?B?bFZ4SGhhYjNrYU0xVFlHRzBKTWtmT3hmY0IzRm92NUVrc2FIRDhPZWk5S0th?=
 =?utf-8?B?VkM2VFkxTXBVWnBvRG1tc242TVRLODYzYm02bm9nMG1JeGFUa01nQm41d0xi?=
 =?utf-8?B?SDRTQzIxaTFnSFJ6ZG4yTjlxM2hJUDZaODNLOEI3Q1Q1YjVGSHFRenpaZlNn?=
 =?utf-8?B?TnlGblJOS1B2L1puRVBiQ1BHTkMzQU15UlRwTjJhS1hFaEJiRVdzRmJDWGVr?=
 =?utf-8?B?czYvalJVd205MUt4aWp2VVZGYWN1d2d6VjgwM2trZHVxL05HVDRleDZ1K1hk?=
 =?utf-8?B?RXZUUDBaVEZpcG1KOU9WMXhFOVRwbVNhd3ZOazEvdmU5V3NJU2VqenlmMXUv?=
 =?utf-8?B?Um9yT3RmQkZiVlMxb3VjeE1wOVJhcUYrN1RhTzlHZHh1TlVhUitvQ1BTa3hF?=
 =?utf-8?B?SUVPdFFzU0d0WmRJR2o4MWIzTXJxcTRza1JXZHN3Q0NOVUxaVEJnbkpEVE5y?=
 =?utf-8?B?TW5ReVJ6YmVPU1hSeFBkemZKOStHRzUwYysrZVpoUlVMVVNWaDNVTC9RNGFI?=
 =?utf-8?B?c2p2Z2szdDdYN2lDUVNsYkVpWGd3Yy9HZVB3TmoyMTFYb050d1Z6S2twa1Zj?=
 =?utf-8?B?bEt1eWZ4OUR5K1VhNzIyV1BzcDVlSE9zS0ZMZ3E5dndaQ3BpSmY0Y295WmR6?=
 =?utf-8?B?YUsxanVrQlRqdFZnNXo4aVRtNlV4WUN5MHNJRjJvWDB6dWpheHpkWUQ1OVFS?=
 =?utf-8?B?WXlhcDladldWalJ5TVV5RFRJcTlrMlJ6RzA2RXFzWGh2Tk5JZFh0OXM2bS81?=
 =?utf-8?B?M1d5TUJwMjkrejY4Y2wySFVmMnY1RWMrTFBLWlBTRDQvMEUrbnVPWUlzSnVK?=
 =?utf-8?B?bTZaekpyc0s5dVR3NkptZXZPaGV2SWZ3c1BjdEVZVWNZa2hQelJ2NU5sbmdi?=
 =?utf-8?B?VG9vVzlVQlBoVzV2bVl0QVljL3dZU2JrUkVrUmlIN05yRE9HckNGSHNZZTY4?=
 =?utf-8?B?ZGx2dXlMaEdPeVpPRFV0SDczeXZIb2V6dys1VUYwNTJGdHJkcjhWOVA4V04r?=
 =?utf-8?B?SEVsb25lb3pTK05aOFJVbkdFeEJTVjBpanJmQjFFQzVRcjZ1L1ZsaC92YTVj?=
 =?utf-8?B?cjJFN3llMFVZcVVNUzJpMkJHTGQzSGwwYTA3QlEvT1l5UFBRUmYwUnF0ZGZY?=
 =?utf-8?B?N1lwTmJPVjZzeEkyaldBdjZteVo5ZHNMUVdtRkEwQmppM1B6T0NhTmdDZGtq?=
 =?utf-8?B?K1FrWlhzWHU3MFdlajU4L0tBTUlaU2oremVsT3gxQTBFQVpwNm5JdnVOZ1pv?=
 =?utf-8?B?d3NkSDlKVjBtM2ZranR6VDFsUXpXZ3gySXdQUEMwYWxLOGkxUmNyaGxJVHBN?=
 =?utf-8?B?VVNVRXQ2dU42WENDaWVjRUp5QXpUb0dpaEY0V0VHVTk0ZmZYcWxNcWUrNmt6?=
 =?utf-8?B?NDA1SkdoellLc3gyTndJN1dDa3I5K3ZIN0hoZHZrRHVDZi9FWStKbDJ1YnNn?=
 =?utf-8?B?UlNJVGh4d1lwditma1pCRmpHRitGWm1kMm9HNEdqTWN1Vno0WSt4QmVkbkNo?=
 =?utf-8?B?YUh3OTVaUFppVUtJVnhkNDFkYzBZck83NkRxK1NrNXZDd0RvZzRSR2pCaHkv?=
 =?utf-8?B?TU41OVlqY1huYWxaZjd0MTJueHF5R2FSQVpJMHNZODBnKzJzMDNzZXM4aGpi?=
 =?utf-8?B?Ky9ETGxjcVgrSXUzR25rU1RQdWIxdTlXKzhUYm1qNldqQ25CdWk5dnBOUDRX?=
 =?utf-8?B?MlZWRExuN1F2VFkzQWtJZUVKdkJKOGlHU3RYNFhQalVIYitkM1dRRVZEd0pY?=
 =?utf-8?B?T25VL0dxaVNDTkM1OVQwQTNWREpnbStrQk82emRReitCN25GZUdSblNyakVt?=
 =?utf-8?B?MVhrM1V6cXNmaWNhaWEwcGFHdk5CcGMxU2RmNSt0N2lvbXhPK042OHNOMCta?=
 =?utf-8?B?SUlBck14NlVrbTJhL2NxNzIydzMrL1hVTlpLMWtCWTNKcUw1M2J6MXluTE9j?=
 =?utf-8?B?ZFdWbzZZOGdUYmpheE9Ib0QxWHR1cDNCdEIzN3FaYkJuWHh4Mk9qMHNWOEVK?=
 =?utf-8?B?SER6L1U0bWh3TU9NUllHb2dFVysvd2tRRE42MTdCZlNVaEJJcnZSbmV5b29D?=
 =?utf-8?B?K3pmT1pmNlFubkFCMHRqbmY4QU1VTzFNTVpQYWltN1Y5amQ2SVVBS2ZJZUdi?=
 =?utf-8?Q?u+pxJFgiEj0WsuoisLkxecc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C873A2E4D2EFD24C9CAB2AA66721EB7D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9xuUbZguNpltw1OsNTm79TmIoKUE0QnAHiasI6H4ADy6kyNHcoMuKjVJ2T/yz80+y5dGWEhb9z4qlMYEqzOo49cz4Ej8T3KEL5mSLzssas5BGlgd1pbvOY4DD4YrEg46dXow+I5yIspVb19f/eXwB6X6sHBgaDnIMk2byuqAyNNUrLehl00dKn4bBKEbdn4Nyxirs9SQbcHciSY+EdZYHkxiwJb0nyVLjjnPkKvmCHiZCzkj4Pmtwbiw6tvJamS4vDH1A8rSEm/0vMjNqJZK3l2GXVKfZpdvGkxWLi/HeLOu9IyI5qbAYGRT1N38qyo5KARdUp6VfTbKeD+uDZNItaafFaXp/3u9iSnVHiR7bEgQczTinJo8mkOdnhH8Z/AZw8JxGv/NcRZosWYTQ1cLlUD5znViAxjIHR3Q6HxeDAB36PG7IVPgrLFRRPjkxMme9gOm2n4g52FNImxtnOKlc4BMudz4PkxyXTulsLDaO7o13sMF+QLA9OKimzNf8NUnXIkTP2y6e70n7li0v+uznyjLj6Jy1APaaxE/X6PHaus9R9KeB5gDu2ALl21GZwv5dL1RGSkLEx0fiiAt0fn55cqmBc4tYCluz6tTjDtgfOk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecf6545-aa57-42cf-d739-08dde116ab06
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 00:56:03.1012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVcmRuH80jE3EtEg2BBjOKhtSgjO5VVFhvesQCHze9woJqPfQoVb1DG/i0KMMXBqic/3lvMxh2I30BMtnKi9PgrpRwfzbXyMtQCrQ/vlzNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508220007
X-Authority-Analysis: v=2.4 cv=ZPiOWX7b c=1 sm=1 tr=0 ts=68a7c028 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=hcloS6lWBdT-QdR2iSAA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12070
X-Proofpoint-GUID: Yand4k7Ws62pL_Qz86jXyxqBnKh-7Jyy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDE2OCBTYWx0ZWRfX0C79ZF4mDZjO
 FA0D+u0JFOTynWxPTFN5DF34YdYgdQ67Ul2h3Xe480SDRuu+vpmcUWAwWuNvyxXVQI8YuUyMghH
 ULzrHvPTxBTdOKdHZKKtVJ5JF7EeqemjwjC2nMRqDL1OBKTCcDDwk3MEKgn6MBKuez71MS/25w0
 O00sNrxrByqIT+kJOXekigI4J7yGwEakhAyipBBFMfKlaS2VibLyJJ4pOHswEySU38qItGaJy0H
 WwyDCLTuBmKJq5VaxM5zunht1bdAHBXFoQ8oHd8J83maBlkXwevsaPe2N3MIADbhDkOXUnP9nYU
 NyRbY+fKCJm6VC/BabjyU4opwZJAUBwvJLvJnfJjLvbdmTShUstE0s8NiytsaHjs0Ts/E1rx5Vn
 +yksPBIKsn04qJ9QmdPW5KmdibvCWzf+FsWBn/yFUmeB2fTILYY=
X-Proofpoint-ORIG-GUID: Yand4k7Ws62pL_Qz86jXyxqBnKh-7Jyy

T24gV2VkLCAyMDI1LTA4LTIwIGF0IDIzOjI1ICswNTMwLCBVandhbCBLdW5kdXIgd3JvdGU6DQo+
IEJvdGggY29uc3RhbnRzIGFyZSAxPDwzLCBidXQgRVBPTExFUlIgdXNlcyB0aGUgY29ycmVjdCBh
bm5vdGF0aW9ucy4NCj4gDQo+IEZsYWdnZWQgYnkgU3BhcnNlLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogVWp3YWwgS3VuZHVyIDx1andhbC5rdW5kdXJAZ21haWwuY29tPg0KPiAtLS0NCj4gIG5ldC9y
ZHMvYWZfcmRzLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvcmRzL2FmX3Jkcy5jIGIvbmV0L3Jk
cy9hZl9yZHMuYw0KPiBpbmRleCAwODZhMTMxNzBlMDkuLjRhNzIxN2ZiZWFiNiAxMDA2NDQNCj4g
LS0tIGEvbmV0L3Jkcy9hZl9yZHMuYw0KPiArKysgYi9uZXQvcmRzL2FmX3Jkcy5jDQo+IEBAIC0y
NDIsNyArMjQyLDcgQEAgc3RhdGljIF9fcG9sbF90IHJkc19wb2xsKHN0cnVjdCBmaWxlICpmaWxl
LCBzdHJ1Y3Qgc29ja2V0ICpzb2NrLA0KPiAgCWlmIChycy0+cnNfc25kX2J5dGVzIDwgcmRzX3Nr
X3NuZGJ1ZihycykpDQo+ICAJCW1hc2sgfD0gKEVQT0xMT1VUIHwgRVBPTExXUk5PUk0pOw0KPiAg
CWlmIChzay0+c2tfZXJyIHx8ICFza2JfcXVldWVfZW1wdHkoJnNrLT5za19lcnJvcl9xdWV1ZSkp
DQo+IC0JCW1hc2sgfD0gUE9MTEVSUjsNCj4gKwkJbWFzayB8PSBFUE9MTEVSUjsNCj4gIAlyZWFk
X3VubG9ja19pcnFyZXN0b3JlKCZycy0+cnNfcmVjdl9sb2NrLCBmbGFncyk7DQo+ICANCj4gIAkv
KiBjbGVhciBzdGF0ZSBhbnkgdGltZSB3ZSB3YWtlIGEgc2Vlbi1jb25nZXN0ZWQgc29ja2V0ICov
DQoNClRoaXMgbG9va3MgYmV0dGVyLiAgVGhhbmsgeW91IGZvciB0aGUgY2xlYW4gdXAhDQpSZXZp
ZXdlZC1ieTogQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+
DQoNCg==

