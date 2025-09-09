Return-Path: <linux-rdma+bounces-13208-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743EEB4FFB8
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 16:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668C44E1FE6
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96C234F485;
	Tue,  9 Sep 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pGOaoNfX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BCW7X7U7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06CE34321F;
	Tue,  9 Sep 2025 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428908; cv=fail; b=I9jtUR5UWSuNYEdtAoDlm3ceweRAf4/kVvn840dZBfQ8L0L6FYpE4UJDiewyZ5P1hsoONGPAY6J4C6T7DLmrF1wNWFCgdvVvZ1wYl4PpgiTK9R8rK0faQokVXYBxtSLVkNNI+83a1hG/qZtykJCgNz4S0LLUhBzgGJBkYdUXfOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428908; c=relaxed/simple;
	bh=YFl8JjmravuB/rGKdYmezYso/SM/Yl7lL5BznwePXRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SXDAUbq4HRdFffBwZ5AUe9Oj4WrMT1H3R2ZCm4lZ/OUSB6Ruq9DdXIv41wHW5svyGTwiq9V8znu/nzw20mFD0ggB6gqQqBy5iT6/OKR4zPWWUYdTVbWkTCpDS/mT/8fcZEEe9yMjBU7S8bhP8GD1bxRQ8hcl+EebGmRdTwLKXV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pGOaoNfX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BCW7X7U7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589CPIJ7004045;
	Tue, 9 Sep 2025 14:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YFl8JjmravuB/rGKdYmezYso/SM/Yl7lL5BznwePXRI=; b=
	pGOaoNfXtIRj7uHVIudkQWw1hthY70m24mYSNOyrYgVKErF7MsJRW3T9HGuywO9M
	uZgubhSVDVDqJ6Y2XMMr2JqnkoEUSwAdJo2u1GXC4GT5yee8h2tXQP5x8e66IUp3
	TLzW7/ddVAftN75LGrVOwPUb71d9g93638YBcvHVoImDEa5vDNMOCSKrZ+kePA1f
	gHiuOUtAF2l1eXRRO/TQ7NwWbgW8EwoUkmoAv5C/q0msekmpSb5TYESFohda9aX+
	P/0lmlkVzeBCHFIJNsHTgYs86ZT3IiLScG6Rof/U3DzviNFqfVnXbowoJ3zsCZDj
	LrIT4eq7cSusQZKBzcymvg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1j8er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:41:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589DwhcN025921;
	Tue, 9 Sep 2025 14:41:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9qkfg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:41:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obne6oPRREZucC2JEivW2nPt/p6B5Zc3WUHmk9oIGvtfdC9nT70OZi6oyayhd+kqDZAB7US2k74Cz23togvI+7pKXkCx8IN1je+vHNWY4mTVhKwQMuB8wgu0nEuOeTWANg2NFCpmidmCcPyu/HgByxIdYFzcHkIptD2eCPcK8rAP/nTSR1Gja/MWpImoeCs0IHWa6f4vb5NpPZG89LOKWUpXeIxevi71OXbI1r+QQZYv/i9Xcn/7zf2wfrXrh6zc7koO6//2EnUOuxr3uRAW4WBSCanotZFa9norT2+U44r0nd9gcvjkY7EVDxkT0LsTrPFh0lRfO00T/sYAU8YFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFl8JjmravuB/rGKdYmezYso/SM/Yl7lL5BznwePXRI=;
 b=IA2N5qutYHLHMfg0afhsxmNR6+Xy+eOIWuBOFEOiNK2t1gDWfKNejgr0QLbEQfgW/t5Es0Z1jZ2U+0TtfYI8sQZpDcXV+o5vPyI054aGgWxB1gAPqeIPbkMEf45YI6hksqBGd34R7Krc2w7ZS6gmoXQusDgBCqvwxEKHS5X6ZIM4MQ1Qt178pj4SW7P+MRd3Vq7MHFT6KN7AO35nCXN8ZwD0RjpkgnM/0FFbvJTzZ1cQpyDfS4AosNCCw+PSLH3K4nmi252oRpWaY6A45/1oX41fBjjBEsFun41begMyMSh0kDYhBrNIup6f3hPPxwfqBFiP1BMZu8dXhW3p5yIO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFl8JjmravuB/rGKdYmezYso/SM/Yl7lL5BznwePXRI=;
 b=BCW7X7U7If7dDJ8cRvJPnACJugzEb6DtAMRNb+lcRc2EvWXMrNT0hXvGEUdsWa7QiCd34tE20uhFdxEPIxaXAMtBAlAwqZY2BH7rXOB0WLecMlZBKLeA6ejxvatw3W/ARd4Ykn6+1z3Cm1SERLdassJYP1egnTQyN0Ol9iL2v2o=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by BLAPR10MB4817.namprd10.prod.outlook.com (2603:10b6:208:321::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:41:34 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 14:41:34 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Allison Henderson <allison.henderson@oracle.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Simon Horman <horms@kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/2] rds: ib: Increment i_fastreg_wrs before bailing
 out
Thread-Topic: [PATCH net 1/2] rds: ib: Increment i_fastreg_wrs before bailing
 out
Thread-Index: AQHcHPA+wxtoMZiMdU6/mlOIqFvcjLSKtkWAgAA/ewA=
Date: Tue, 9 Sep 2025 14:41:34 +0000
Message-ID: <F55CDE99-B0F6-4C54-8ACD-24FA400AF17C@oracle.com>
References: <20250903163140.3864215-1-haakon.bugge@oracle.com>
 <d918e832-c2ef-4fc8-864f-407bbcf06073@redhat.com>
In-Reply-To: <d918e832-c2ef-4fc8-864f-407bbcf06073@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|BLAPR10MB4817:EE_
x-ms-office365-filtering-correlation-id: 15489115-f38c-46d1-2e9c-08ddefaef96c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1JYVDBzUGlRcytrUGE1UVZVeTJwSUFDMG9qRlJGQS9tcWdncTdTeXp1UUht?=
 =?utf-8?B?ak9UTXJOeVlGUHVDKzBJTHRMOGRsMTVISXFXK21zRVl4c3Avei9ZbnE2Mmg3?=
 =?utf-8?B?a0ZNVWxydXA0OGYxMHpKVnBNQ2JIWWhtMEFPMkVUSWlObmRzcnVYQ2FxczlF?=
 =?utf-8?B?VXV6QXBSc0t5OHBhMjR5ZnBxSG11UjRFa0hhVzlvbkxscG5zNVk3T3hLZytW?=
 =?utf-8?B?aldDbjNiay9XM0RvT3RTZ1oyQjR5RmZkWjI2cEVUWjBmZDBKdEZ4SStsbk1O?=
 =?utf-8?B?cXFFSWx4NTcyNWJBU1d0WXA2SnY0SjArTUdiRmgrU2Z6OUFCU0FpVFc3RUtL?=
 =?utf-8?B?bVJ6TFZvWDRheHB1Y1FUTkFBeWNneHRLcWdoYitaOHRsUVM5U3JxWUt5RTZy?=
 =?utf-8?B?T1pFclJKYWFiSUdicGs2RXhSYkdIZGxSekxHVXFEL3UwdXgxSHIycHpNZndp?=
 =?utf-8?B?bUlGdXF0UmcwdG9aT1RDTHVyeVB4cThiK25LT1Z0REZiaU1KSlRTaHNzY1M5?=
 =?utf-8?B?MnZrc0NHTDBQRHZ6S3BFeTFMQzZ6elozNGIvblAyN0xiY3R3bWtxQ2YrbjNG?=
 =?utf-8?B?QXdyWWRuODAxUXh4VDY2ODlrK1pVU1JTTlBObmNjT295N1J1ZUZka21IOEp3?=
 =?utf-8?B?REFhM205b2JoeDJlWWp2RGwxdnpCMDhpM0lQdkhabnpzTXZXclpXZnNmL0Vt?=
 =?utf-8?B?R3JZL01iaU5mUytKaUdrOVc3ZDZLZ05DaU5xN2lGOG9xalF4KytRSU52RVl2?=
 =?utf-8?B?WmRZZlJlaUtUOGJRZnFlUFRzS0dWK2J4cGlNekRIdUQ1MWQ1RHUwbzBQR0Rk?=
 =?utf-8?B?WjhmR0dna3ZySDE2TVcrcnNyTjJ4Q2hIeUFUL0tGRnBoUzkzVXBsMStRZUw0?=
 =?utf-8?B?aG1oVmY1OE5HczQ5eWNRcmM2SVJJVW1iZWpnS09nRmhxeUpCaHRoNzA2cWla?=
 =?utf-8?B?ZjAveExPRTNGOWZjQnBIa2ROaDRkOTJYdk9qK3FLTmVkdTFhbWIrUkxHQ0pz?=
 =?utf-8?B?cWhyRmExSnhvTTkzY2JHMitiRHpwWTFoNWNpaUtpVlRrL3hDSWRtSXd5TUhL?=
 =?utf-8?B?TWJTQ3RQakhvU2hWZ2dQTDd3SnJCbDlXcXhndWc3b3lTOENHOFc0MVVQQWov?=
 =?utf-8?B?YUZiNy9tUlBaaVBKT3ZzcXZVZzE0UVhVYW9iRGZMcUNONlVGbjRUckNHN0Nr?=
 =?utf-8?B?WXR0OFZ3RFNmMWNsOExVRURKOWZvNFkvbU1JTzFXNVhGYWpzdGJFR2Z0N2Iv?=
 =?utf-8?B?Um96L2N4VFBZbVFRWnFaWGl6SXZ2ejdCcVZreEZudTh6QXJPZnhqWWV1UUly?=
 =?utf-8?B?cEJNNGx5Sm5nNldheUp1RnJzSFlpU1ZpandMbnRndlgzMks1NTlkMlAyanpy?=
 =?utf-8?B?VllDdGo0NUdhbXpoL3h4VnBqeVBoTmlFYVNDc09ieHhMTE1ORjZyMDNXOXFm?=
 =?utf-8?B?QmNzWERMWnJRZ1NCYlNOSjg3MnNoSUFZMXdrSlhBZ3ZOSUZGQnRaRUUxQ3Ju?=
 =?utf-8?B?LzJBK2trSUc1MnVMalJZZ0tzQVNtU2dMclBXZjlHTEYvUWF0WEU2azRqOGZ1?=
 =?utf-8?B?ZFZUUjcweW5XNkR1T21yMHl2bFZFNFp6TjUyWUhHWElyNjYwQStPOEdmc0NB?=
 =?utf-8?B?SnRvd3gyditJRnROeVJ3VHQ2eXJtc1cwK1RIdzZ2NkthNEtOa21MVFVxTm5h?=
 =?utf-8?B?QUxmNUtJaHNQejA1ZHp1emkxQ2dLaWNKNU9uOFRLVlUzSENzM3RZT2Fnc1JY?=
 =?utf-8?B?cENHeEtGRUp6V09PdmJGTENLNTZ2dTJyYXpSMDNHODcvVS80RWliWDFCcklO?=
 =?utf-8?B?TndyOGNqUlN2RGhJdXYwekZIVFJlVGlIMm9xaTk3ajQrWEdqVmsyY01WczJ5?=
 =?utf-8?B?MU12aXFsZkNPZ01kOGhsSVhYWFJkSlNxR2pTdFcwRy9KVjhXRzlkRDlUSTFL?=
 =?utf-8?B?Z01FRDlOSHJvYThDV2FyY1ljQzViMGdFT0VPVi9rYlFyVC9zTXR2SUZXWXhu?=
 =?utf-8?Q?CaV9bsdLrAW/9HsOQvsHvZIoKfH48s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YngvYkpEZ0EvbXBvT284eXg5aWljVUdrMThuNWxoSzZ1MUJqSHZXanJqSlpG?=
 =?utf-8?B?MHFIWjRlRWxac3E5YzQwVEZOYUR1QjFqVnRSaEtnTWJCdll0ZjZHZ1lTbURH?=
 =?utf-8?B?TzRlR3MvNjlqeVpJaGM4OFZpZGkxVWF6YWFpZDhWSHlCME12bXNLTzB0aEFs?=
 =?utf-8?B?ZTIvL24xV2p4b1pJckFNdE5rTVFDdWlXcWdmdzVlbWQ5YWx0czZPRldHb0VF?=
 =?utf-8?B?M0N4L1V6UkJ6Um84ZnBrNCtzK0NIaHo3cEYwL29RNzRKbWJzZmlxQlhmQ0VG?=
 =?utf-8?B?aEY5YlFhcm9GSlZjTUxYMzN3QmpOMnhvdGgrbHlVN1RReEh3cGZxTW5YcjBV?=
 =?utf-8?B?dXVicGxEc1p0bDZ0MzljQWY1SUpob1F2NUF4bVhNVzFub1B0bHRPQVU4Ums1?=
 =?utf-8?B?dytuNEtGb0dEV1FnRzR4VWt4UHdyazljNyt0enlBallVL01XQ05NQVBsZHFr?=
 =?utf-8?B?aTNTbFR3Ky9iSmhmR0JMV0RjQWg5WnQ0TmZta1BEeDFhbjV4a3d0eTQrTXNt?=
 =?utf-8?B?Mk1BNjBUTWh2OGdBVjU3NEVodnpINGtVUUZHT3plU1FsWkttTURRTzFFRUJj?=
 =?utf-8?B?RTFCUWF3a2dWajBnM0I0ZFlRemltOXM5c3VXNk01VXNSeEs2UVpTWTVidlV6?=
 =?utf-8?B?V2Q4WUs0a3JlREZ5YXdBRXpiSEZVNUlWSkFjd0tSWkMrZDIxK2NyUDR2cUtL?=
 =?utf-8?B?b01wQ2FwOU42a1czYTNwMk5WVVo2bURKREowa0RQODJMbk5rbTRwbGFOUDhs?=
 =?utf-8?B?cTZ4aEtaaUI1R1VrZGxLSUxlTDltRWcyNFlYOTBudC9XcWxqVmd6YU9MRi9J?=
 =?utf-8?B?ZEdvbEMxNzQxYm1ITzZ6Sjc3cXpLYXBLOXVkN3hWRXA3N3c3ajlacXM2TkRF?=
 =?utf-8?B?S0piNExBWFNmN0RxOGUwQ2NIdnluYUtYTXE3NHhpRzhnRnNKVUhGTnUxcSt5?=
 =?utf-8?B?MTdaTU5maDg1TkNvL0lqN0syaDRRaXhreVU0ZHorWWNvYnFJYWNHWndzbWpv?=
 =?utf-8?B?enU3ZmRLbGswRys1c1FPbVNGVGJWbVpUZHZBSkloYXA1cHVYZ2VVeHVnNjJR?=
 =?utf-8?B?Zml5R21jdGxjY3kyUVhGNlVpS2lNRGJVeThaeHdUODAvZDBWTmRjYS9FT0ZU?=
 =?utf-8?B?WjZ3bS94K2ZKRkhld2NJTTRoUUJvb3B0bm9OVml0U1NGWWtOMnpqeVBXM0wx?=
 =?utf-8?B?a01pdU5GT1dMeWRZU0VLUnROKzNTL016TVJMNTFxeEFjWWQ5SUczalQ1VVo4?=
 =?utf-8?B?WmhTT3VVVmtrRWhrYkpIdjN0b3dEdnMwZUZGSXd3QzVtVE9mbG4yVWpwWmx2?=
 =?utf-8?B?a3pwOVJEL3Nad0pQblBjc2x3YnlXTXp2SzZBcE9tY0FJQm5kOHY2Z3pEK09k?=
 =?utf-8?B?alZCcnk1NnFNQTg2aHNDSU5ibjQwVWtQWlN3Y1BRd3FWZ1Q2NWVScHl2a2VP?=
 =?utf-8?B?dUM4aG93WUV2cTJFa0dyemNtSTNWV1F2eTM4OHNlSzZQS1dNbTlYd21CaHo3?=
 =?utf-8?B?Zm5UU24zdHBRZHBqK0JSZTBLKzhWWkpnNzJBY3p1Z0s5NW43bXFWTzlwVDhL?=
 =?utf-8?B?U3U0aTNITGdZc3dlZ1dJMmp0RGUvOHE5NjZ5VktoVTdnWndkL0FBN1lKbEZR?=
 =?utf-8?B?dUJIQjJoSXMzcW9qYmd6Um9zSjVHY2FNMmFzeERMYlYxUHdqTzBOUzBMSVpi?=
 =?utf-8?B?eEQ5a1B1ZXZjRXVPTWthNDRLNmtLU0tSTWwwUkRSeUdSV3ZZRFVBcmRkeFF0?=
 =?utf-8?B?ZUNzRy8zTWo4RlNqSnoyNmdwUjFhOERGSW14VE52V3VETmUxRUd3TEltNnJ4?=
 =?utf-8?B?WUJHZmxzUi91STRoRkx0bHYvTjlZejAzcWRiZ3Y1Tldaa2cyWWJRU3poSTlJ?=
 =?utf-8?B?SzZYYzB6akErZ01rOWFpSlB4MzJ3eE9EZENZeTVYQkdHbmRtcm8rS1Mzb2hp?=
 =?utf-8?B?bW82dDA1UFNTWktUdEUrc3pIMGpmZkZjVlUza0d5QzQ0NGZ4QTFnMGFHaFlS?=
 =?utf-8?B?VmxKOWhEQ01XZmlDZkkzK0pUYXg3R1hWMk5zTmprbjNmb1EvcDJBT01iaFlG?=
 =?utf-8?B?U2xPdmg3U0ZtZW1RNytnUVlqMmlreldpajJVNTFwb3hFMVFQQWdVWVpyQUFs?=
 =?utf-8?B?emNNQ2V6SkQ0NHQwRDhHeFFmbW1EN3R5SjVKUzdLUVRDcTQ0YnpSUHhVdkxk?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F9FC17BAE6E654C933C4D94E130DF82@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zpR0COD0uoOqLAPlo0+fn0uCUxtfXYZeUuhtf3PbwOAwOOkF2xsdwn8ZcwTUT93qUrLUh9cKLO1af5Ae9WUTrEjKKBLW+EW3jBkvXZjHSuwQdheFkNEG9yqmeHgP10EWZhKnlJNJMa0k57ARHGxbgTGQKMqSnSosR8J65RGv/fDugf844eWVPtcbC4FKp4mRlCbwXg56wgHsbCBkFVpqaE+M6arLU8gLEjdx2La/4Mb+B/MZi+nIW7VzKkl70BZHrwir1mIJacTumLVTlEiSBK0tp0F7TkKf0ZHYvggfTIVJT91apMPSjemHG/MjXWqJJNJKVJTEMi7WjLMM1sQPehn+TUYgzBsmUGP6jPSF/LehGXG1kbR7kfjwixAemdpOsyct1WfPSWeGP+iK51mM1aYyq83S7quf31qtXHQKQktqZ3U2murvwnjUHAzUHy4Ws9OnkoQVqSdWeZbuXxiw1FvV9HY4NIW7f4gE7adRL3bDId4Zr77/l1hGG/aPWQfqiJRabb4834bs0y4ui7qfRRUzQ0msqSlYF3QnEs3KxPnfOI9XA1X51ZSEEF12N89L+vDA5Md9cOaa1ZC1c8R86vEVIL5ywJpmB8B6jJTPiII=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15489115-f38c-46d1-2e9c-08ddefaef96c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 14:41:34.4361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: quqxTeKv3me7RD94U0U7ZyKrIAn23YEj3MIMaG9aoaR6RPqbp9fG6NHBlML8VA5fboyOvLu/CwYAVmzFp9EEZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090144
X-Proofpoint-ORIG-GUID: GI0N3NAaNxZwfsl6r4LPhF7tIPuapt1u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfXx3l3PaIpDBnx
 IWHhx4iZyyNZz8aLRug2Tmy30ihEno+O5cZotFHOJLQuw6hE1c8MI3O7w2PnqKvcCh/Mel+CSe/
 AfG/DmO53Ld8pkHrH8fm3D4KzD8IgRTFkPELJthtCmUvvaDK/od8fseHgxITT87YHol4v1dkWts
 VYzNHnj60OW6QsYQ57vDfnkH9RowtZsYXnjX6AZGEeC1QTM9FnQe1CeV89ZZSHoOQcLZxogfFlH
 4dvPHgX0UHUI7gWjRRrLyasGeHga1dbX4fSqbhwixpCSNekIPOj2OQOkF9mnZFf9K5ftdAS29vN
 lxkGPqXEDE+2P5HeoLICWQZADmjvqH6iwEuddyUyQRsCG8PXeAILMkjhItRKslVAoS+upIJV1MY
 L2wIrmq9t6Qw14Lb0/XZZZdexU5nZw==
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c03ca3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=8xZdOEQuHJmL9tO71YUA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13614
X-Proofpoint-GUID: GI0N3NAaNxZwfsl6r4LPhF7tIPuapt1u

DQoNCj4gT24gOSBTZXAgMjAyNSwgYXQgMTI6NTQsIFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0
LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiA5LzMvMjUgNjozMSBQTSwgSMOla29uIEJ1Z2dlIHdyb3Rl
Og0KPj4gV2UgbmVlZCB0byBpbmNyZW1lbnQgaV9mYXN0cmVnX3dycyBiZWZvcmUgd2UgYmFpbCBv
dXQgZnJvbQ0KPj4gcmRzX2liX3Bvc3RfcmVnX2ZybXIoKS4NCj4gDQo+IEVsYWJvcmF0aW5nIGEg
Yml0IG1vcmUgb24gdGhlIGB3aHlgIGNvdWxkIGhlbHAgdGhlIHJldmlldy4NCg0KWWVzLCBpdCdz
IGxlYW4uIExldCBtZSBleHBhbmQgb24gaXQuDQoNCj4+IEZpeGVzOiAxNjU5MTg1ZmI0ZDAgKCJS
RFM6IElCOiBTdXBwb3J0IEZhc3RyZWcgTVIgKEZSTVIpIG1lbW9yeSByZWdpc3RyYXRpb24gbW9k
ZSIpDQo+PiBGaXhlczogM2EyODg2Y2NhNzAzICgibmV0L3JkczogS2VlcCB0cmFjayBvZiBhbmQg
d2FpdCBmb3IgRlJXUiBzZWdtZW50cyBpbiB1c2UgdXBvbiBzaHV0ZG93biIpDQo+PiBTaWduZWQt
b2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPiANCj4gWy4u
Ll0NCj4gQEAgLTE3OCw5ICsxODEsMTEgQEAgc3RhdGljIGludCByZHNfaWJfcG9zdF9yZWdfZnJt
cihzdHJ1Y3QgcmRzX2liX21yICppYm1yKQ0KPj4gKiBiZWluZyBhY2Nlc3NlZCB3aGlsZSByZWdp
c3RyYXRpb24gaXMgc3RpbGwgcGVuZGluZy4NCj4+ICovDQo+PiB3YWl0X2V2ZW50KGZybXItPmZy
X3JlZ19kb25lLCAhZnJtci0+ZnJfcmVnKTsNCj4+IC0NCj4+IG91dDoNCj4+ICsgcmV0dXJuIHJl
dDsNCj4+IA0KPj4gK291dF9pbmM6DQo+PiArIGF0b21pY19pbmMoJmlibXItPmljLT5pX2Zhc3Ry
ZWdfd3JzKTsNCj4gDQo+IFRoZSBleGlzdGluZyBlcnJvciBwYXRoIG9uIGliX3Bvc3Rfc2VuZCgp
IGlzIGxlZnQgdW50b3VjaGVkLiBJIHRoaW5rIGl0DQo+IHdvdWxkIGJlIGNsZWFuZXIgYW5kIGxl
c3MgZXJyb3IgcHJvbmUgdG8gbGV0IGl0IHVzZSB0aGUgYWJvdmUgbGFiZWwsIHRvby4NCg0KSSBh
Z3JlZSwgb3Zlcmxvb2tlZCB0aGF0LiBJJ2xsIHNlbmQgYSB2MyB0b21vcnJvdy4NCg0KVGhhbmtz
IGZvciB0aGUgcmV2aWV3LCBIw6Vrb24NCg0KPiANCj4gL1ANCj4gDQoNCg==

