Return-Path: <linux-rdma+bounces-17237-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF6NBkeHoGlSkgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17237-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 18:47:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B181ACD38
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 18:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFBE63469782
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 17:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512053290A8;
	Thu, 26 Feb 2026 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SLVbkbb4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZXRS0dQT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D9368956;
	Thu, 26 Feb 2026 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125602; cv=fail; b=NXJtByJzYhVnwz/RWj8kYEAP/eOP0QewW2Q5qpcSt0GVowwBaAsoRl22gIKVY4N8QCXhLvXn0saeMztSopHQ8/Rq09pXbkMMR9Bw69cJbbAw1H4t4eh/5memqdKv9UUXgrzzZjm52sRM5jJT/aZmV4+zv4tcOt9fYF5vqEFKgjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125602; c=relaxed/simple;
	bh=u5l221CdoV7Y7Pl2eAZ3h9lxdn1vJqinfsm39LZFY54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WRA0hKq2lNiGy9y08wjO7yLOH+zLHBnjXAuod/4ngWK4T84CDiIX0/vn0gEmMnzwz9JpRzib6APrN2IXttRmWo8XQSWgn41G9tMuiM3qsrHu9GlFwdK5jIH4RmCNb03jdH2nFSwff0pICw8szLeZA9XiQQA333EgQi++0ubC8s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SLVbkbb4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZXRS0dQT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDNKi0561431;
	Thu, 26 Feb 2026 17:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=u5l221CdoV7Y7Pl2eAZ3h9lxdn1vJqinfsm39LZFY54=; b=
	SLVbkbb4uBCgOBBx1mwsv1Z2Hm3Fzswi/rKBrXKedeu1iXcM61ksUbfxeizeqknn
	/mEO4gwgU066+Rc/S8iJQwzSlyx3Eb8sLsVLM1uOdlTiYUlMqWyGCLBngNqNPZhd
	3msZpUHAuFZcRHAMDp1jQAU8hPbKVP68yo51V4OAuV64mHz6DDI0exjGjycHF4Bh
	5qYbafbt+78JfuTUO3UkNwDHnGJ4YY0qaW4zTT0/NIXTTmg4Q5AB9fRW0q2/Mn3e
	FC5nFVqpmURLVflZMf743OOAJvqPPMV+qNPnCjRvxePKeDRGTHe11xficZ93FxPY
	0OuHxjo6KJJQgJUY5P3ypA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgjfs14x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 17:06:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61QFc44d038465;
	Thu, 26 Feb 2026 17:06:32 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35pyyey-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 17:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pafOclOav8FW/K7/jtyf2hjMuPi4A4h4uxskb7OSq/MuqHYb0rrPcFvNeg+sE8w0Ax+A9m+R/7sqUdtraHo75abfBmjdAdW3cyxZsuoKivcPdef06RrCDp3aicsep6P5qan1POQXGZDkE0ed/0opQIpC/aaDxOD9OqE9JNuz8QbYzyKXJbit3Tnff+hRFveJoedV4M6mOTJqesFw9fAexqbK/2EZuY5Ws64eHqJZtgP62q4mb4UHwvZgn3C/v7ZPrQuvBiKaY+OQLX9gzV0QwD6Z3CfLmGO8HQ7R3Gy68XGU/VBhVdQGCq64XTSqmhvog6yQSXQvUGzN9VbLilRQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5l221CdoV7Y7Pl2eAZ3h9lxdn1vJqinfsm39LZFY54=;
 b=yZdM8pcJZmPEogHodC4sTrbIY0LxF+hqBYBpXaMSsG+3VSrtONL1pjY1jSIiLZ9PBweLZxmWr2i4U7aCAsbR1z0rAAHKC4XVQP0/Cqg2+0ZVSvOAlxyd8XNeDcEc+VXTjGm21fr8whCE3uqhlEFIUTduvhhY8Q0993WgVjP4zjskOz+7L0b8OpN6Ug783N6TyOivd3p+53UedKKGvMr5T4sTsjaoToccqRB+hoCdIhAW7K3vFC6BSYuESpJ8vrxOegHewOVrJcOec7hW9TaTmX4cxy0IXGMfU6122CLnw6/rktj8cHWv0IbnmX39xyuZvNKc62QqClHPiwgGYcr+ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5l221CdoV7Y7Pl2eAZ3h9lxdn1vJqinfsm39LZFY54=;
 b=ZXRS0dQTpdtGtKH9KqybhHMFNMxdS7teLgv7oJCTT8vahh+wgPWUo8+qgOq1jT5FfYbpz7hxzb7yH0Xgw+XRVUFb873LXGwVeYIRCtE9gZPmgycCG+WcA4K7KcjWdryivLUD2NFkWdn0K3Kdyqb9e0Gr9KepZozX9u9/4Zg7QRE=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 IA1PR10MB6122.namprd10.prod.outlook.com (2603:10b6:208:3aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 17:06:28 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 17:06:27 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "fmancera@suse.de" <fmancera@suse.de>,
        "achender@kernel.org"
	<achender@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 2/2] net/rds: Delegate fan-out to a background
 worker
Thread-Topic: [PATCH net-next v5 2/2] net/rds: Delegate fan-out to a
 background worker
Thread-Index: AQHcpRJ6U2nLWfOlkkakyuabSy6z2rWTntaAgAGbgAA=
Date: Thu, 26 Feb 2026 17:06:27 +0000
Message-ID: <5b6c7c163adb6b7e500503e27383975ffe3dfde3.camel@oracle.com>
References: <20260223221918.2750209-1-achender@kernel.org>
	 <20260223221918.2750209-3-achender@kernel.org>
	 <7604bbac-f0d4-4143-bb08-261042ad89a7@suse.de>
In-Reply-To: <7604bbac-f0d4-4143-bb08-261042ad89a7@suse.de>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|IA1PR10MB6122:EE_
x-ms-office365-filtering-correlation-id: c0714a17-00b9-4a2c-cbc3-08de7559615b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 K5jTdYDYt6FBFRAqJUj5eLCi6bUF8190WrHiy1mhYSzSZ5G6ZUnFhUdbZVXqYdHGlHPzKXp7SG0DKQZ03w3ib+0kpVYTnmNtWsuNtdng4mQ/0l6oczFj8YNaE/Oyh4b5BLdd2guDW7rfLTMiX4fZ4boFRz0bbI+4QLkYMh2b0cVzWkQcvruwsj5K9jk3rbfvs9yu8LjeHE7jkguUq2E0GCIAvqp3GaDqZO/h8vrThCF5zB0yg72iTEn0UPAFOno9lhUbmn/X8ne7O7CdfPVPSpoMHY2QDjrDYMU4MHXdh0XLt1Jyz41sFlZ838ytdCuj3FMN4MIxB9MR8t9IkkOiYiJecjFo1EH6k935l4bc0FYwbgd4/HRXUcnd7f7XNwUhvdhViCp+Nnp6stB+wyyCvscB9ACSACsywIxW/HNtB37qjjZFzSkwnxd0WoYhmrX1wDrqO6qH7C6l8s/XC68eG4i7YwSWknC4S0R9NmjfrNhyERXVSYyNJ6dbon9vA4vtEm4bCSHCcQEiJKsPc/D1QznHwFo0tA24iVj9bIGUsg6GqgNorGgEc68k6T+REDTwaUGdwvISMil+T9btzjNZYYNw5E5egMucYntJHOTsjSl62K97itZZiW2it9dSdSgPXakUCXS0gFE4RAfxy6bGMJMyMJGVaBMku3a/DbVGY25QMHZBNEVV/5z9D9NpswgoonopQBYq+z6JRYqGAkNHFb8jqSgPFlvE5Opc7T9J6TP01E3hkU2dCuJv0Av9pgXhVLxfWEKOvbsyzweRTA9JfWLBESkMF3sWElq59OuUOTk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTdGZ0JiYTJEVlc3V2RzWUVvL1ptUmVKMVRhR0dWNnQvaWFNbVZHaDhOdmNS?=
 =?utf-8?B?QnRDVCtKQkJ1SEQyV1Bla0drMlliYytLNGFKRDBsQ0FqVmdGWnpweUQ3ZERY?=
 =?utf-8?B?d3pTdGdqN2MzV0ZOSDNzNGRPaDBoSHRoaUZScmd3UGZpSTZVRmY3ZE9VWGRZ?=
 =?utf-8?B?OVp4UFRRRlF6MTB4YWp0aFZEZUFzQmNRZlhDL2Y5Y2pwN042Q2RtUThTVi83?=
 =?utf-8?B?R2VXd2xvV21zY2JydzdlZmRmbk4yTjN3cnpmc0VXT2lrZ05VV2VzUDBzUksw?=
 =?utf-8?B?RnIvS0MwTmFOL1lRTTJNY0swdzJ1blRQVGFMaUZFVUU2ZjdRVHIzaWdMMlRE?=
 =?utf-8?B?QXdwU05vcXQ4L2RndHZlcEhWSDluSU8yWXRINDZKZHRxSUtOMFJsbFNJbXhI?=
 =?utf-8?B?MTdqOS9LMDd1aUZnRG5aNDNqTmIra0lCZlgrUzdSK2daaFFkbVdHNnFKQnB2?=
 =?utf-8?B?NDhSU3g1aTlTMWo4QzNjRzAwWlZUa2YyeWJqZ0duNkxVRHZ5RExKNVM3WlF1?=
 =?utf-8?B?dHVFUmlRdGZjZW44Z2gzakVvY0Z0SnhtWE1mbUF2YlN2cjB6bjlrUldlcWhH?=
 =?utf-8?B?alNNKzdvRHA3SStJcHZrc1dkWHppc0tvUlg3YmM3eGVRR010OWNubml3aVNn?=
 =?utf-8?B?Y3ZxWjB3czE1NGE2QmFDd1hlVG15MytBWWV6cW5YN3pJV3BTWjJWY2ZNR1Qx?=
 =?utf-8?B?VmxHS251eGV1YjNYbVR1UVJoRmo2V2lERityTmJHRVo3Z1N3TlRGSGE2NlVj?=
 =?utf-8?B?SEx3ejRSVGhOU2NSTlVRbmlzVXYrQnhYZ2tYV21SQzVTVThib2dUaXdpQWdW?=
 =?utf-8?B?S0tZaE4rTW52K3BycG5aKy94eUhubVIySlYyWjNoSys3Y0VtMExiTU1mZDFE?=
 =?utf-8?B?Y1liS0ppa2ltTG4rZjkvU3BaTDNRbjJLT3RSOTFXMEtQSzVWUnlkOVMrZFps?=
 =?utf-8?B?NmJtTng2SjBCUEJrMy93YnM2eGtZdlZIa1NxUmt6VWs4SVM4WDluZ2NQZ3ky?=
 =?utf-8?B?VG0xeXl5Y2t3eVJrT0xrUVdHbWRHaXpZa1k0NXBucFBHQ0ExU3FpWVNSQjJC?=
 =?utf-8?B?dnczRVBpZ2ozNDFXb3ludGtCVlVjc1B4akdPMWtsMENNVEI4MlZOU0s3Wmxn?=
 =?utf-8?B?YjRBekxKK2NmZlo1ZUQ3NW5uM3orZnlzaXhvQ3RYVytVODZTdjkwNnVlbHRJ?=
 =?utf-8?B?eVBZRUVYNVlIRHg0cDdsMGVpMmo3Z2JjWVMyOVBXTjhES1A4RDFyWTNnUXV5?=
 =?utf-8?B?elFVMjNHYTBvaWJzTWxHOU1mOGlLR2srTHJ0THZ6NlN5N1p0dmFwdm91T2Qw?=
 =?utf-8?B?V0FjNXNwa0dIVStpMGRrWTQwNm13aG1CdG85TUhOZk1zVUczSXNRcDMrS25l?=
 =?utf-8?B?Tzcyb0ZQaHZTY2YzbE1paDk1ZE9XVHhjR0szR0dsN0JHS3d3aEljRDJWTUpq?=
 =?utf-8?B?TXNFOXdjTVQ3dUdldTNuUlc4bW1wbkV0ZFhqdUtsNDJYUVNZa0RIcGtTVEtP?=
 =?utf-8?B?YTUxRW00S3lhZE55SVFuRXBadkR6N09MYjZZZHY3T2xvWEFEU013UkJHLzdO?=
 =?utf-8?B?VFRWMzMvQnNwUjdQWkVSc2xmRElwZzdKT2pCSkFCY0xrb2g3UWY1T25YSlND?=
 =?utf-8?B?ZWYveE9zRmtreTFtS01RSnBBSVFWYkYyd3dkZ2dvNXNmOGJCcWNhZnIzWXVY?=
 =?utf-8?B?aXN5bGVLaDMvUkpGdCtVVVBnWHlOdWJxWjdEaFpzejJWYjBoalY4S041WmxX?=
 =?utf-8?B?UDNHdC9LUmRDb3M4bWhLS0VBZWxJREFUQ3B6UEw2Z2pPYXRpTG8zWDRNWjhL?=
 =?utf-8?B?cUtyTzRvd2pDUXZUSnpDWmY3dXBwOWlETXZGRnVSN3daZjNqNVBPZkRsQUVK?=
 =?utf-8?B?MjlnK0FPc0xyVzRNa01KcTkvMFI0dHlZM2llVldqOUErdzJkc2xaNUwwM2dQ?=
 =?utf-8?B?WGJtZkdaSis3VjB0QzVtSmNZZkhqanNianhjaEhyOUtZV1J5K1c3TnhRU21J?=
 =?utf-8?B?eFpZckthRVZwYldFK1VlcDZyZ1djOTNDaVlMV281MFI1TUVka0hIWVRvck0x?=
 =?utf-8?B?L2FGRUJuejJ2TTdCOUpPeU1MdlVPNCt5YWhUZ3JkRXFIWlBpcTFuQkZLTytN?=
 =?utf-8?B?ZExQbE10Qk15ajF0ZVBDVVB4WmNuNWtZcERwZUhITnFPQnVpa0FmSjNxZVFB?=
 =?utf-8?B?bWlBajluN2VBY0NRSVhIcksyelh3MzlLbjhCVi9ydkQ5TDNTNG52UUE0cEN0?=
 =?utf-8?B?c0QrNVdRLzhWZDFDTSs5cG50NUtpOVpaQkxZMlc2Z002YUwzNTE2RE5kR2pk?=
 =?utf-8?B?Yk9JRVNmUkFSRlhRSmtraTNhaVQxNm5MYTdOSVRHc280clZYZW81QjA0V0ky?=
 =?utf-8?Q?adwud3Vii6cL6FLI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8831B03BEC1CB24F8BBB841442420CA7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HB6c6au7dTm+KwYGRgYA5njVo1z5zkbczWiXEFDRyntkC8jIOX5BtGTXq6bM3q7d6nw/TAdrHCSNe9IoEJ0o6zCQwdG/Vzouj6NU2JAQGNFjxFrWxv2fUf9l2G+sJZk1NZoy21iC91HQcLJNBgnRdUf8r4mdOB4PA+xvDJS4soYZojefRq2tFVayRI5DoJdwj46Axj8/HQJRZ4OMVvZMMYD30QaN2hn8xAIqrDM00Wq4F8pBNSqibKPZ2eJ0G3zhm3B9Uh2GDQ5GqeU1YFshNNW4lj1Jg60k+tm/NgoGfBf5ycxxehHZVJHVwF/wPD81Ul+nmkFhwJUvguxZwMFowOtoPJuFwkEIWzB8NgnVWLyqPMt2VPB7F+1mjY3VchZ4z5NSBSw/PTCmGIIiB+/S0/BSqT2uTnLeQq6yzd8qPo4hjwgrmnM1BGfWl/hSDYkNsfuPT4krsImedJJJ8H2zHkJ3ooAUjfPAHn9YbBQy0T5H+9lb7Pyoutcsa2/FLKuSRpMM6o8rwxwQB1fGxeFNa0F45+0LNHqslgp3+eA21kmOuEjspd9yEo30aHIuVlXITVoQlDHqb0ivt65SPFvWYfYdc0YCroyMILDNcXD5qS8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0714a17-00b9-4a2c-cbc3-08de7559615b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 17:06:27.8931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BU5YA1M8XzyWsinFxHa5uGOXe8e2akqEzPRKN7m6IywVdjaE89MTnmWbvnkQkf7lriejVi/ChoTViViCxmCEyKZyZSjzqXiwP/IS9axaIGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260154
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE1NCBTYWx0ZWRfX5jDozmMnGonJ
 uds2iTDnGjHzLdkXtjf11G0Z0U80wdvpqozTqHLLyCHO2UgmxD8s6ce8PBUsmLwnrpsV5d3zOND
 Bd3cp58Q+z4mJwoHHUVA7UNE1YSfzCjkYwIg6+cTOuPNBOQ9i43IWZMRRShYyCIOOr0dw6z88Al
 lwU5KvvOsElt3mbJDyA0nwqNMzOuweOJy7AVapdA9Obaa9yVNhWxIWc/0M5Ezz1CG6Zihasa0lx
 J2AlxX3dywN6CJCEdje4R6WIp4g55KvI9v3lTM2FMR6qr1w7+gA57vkgJAiKtzSS+SB0Mt26xzF
 FGR5/IXNAYLoq3CdaGA/Lyh3OJjoNkJz1TByIcSiSpIa9qMPATTLKvXFfjafXSlxhJ9D78+zRSB
 4d1qiRg3p4Eu5Zper7mQnIBxtLyTQ+WAmxetW0FoZzJ2zA+3MeDXQVkZRW3TvGZtZK9g8O7sJbe
 BgMImnbBxSJb+qwyByi92cDzn4GkgLUJwyUhimFA=
X-Proofpoint-ORIG-GUID: Akm09Q9ZeXMlqqPgVBfkX2N18ANQQNYQ
X-Proofpoint-GUID: Akm09Q9ZeXMlqqPgVBfkX2N18ANQQNYQ
X-Authority-Analysis: v=2.4 cv=L/oQguT8 c=1 sm=1 tr=0 ts=69a07d98 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=6DKjHE80dL3irKdDfasA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12261
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:mid,oracle.com:dkim,oracle.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17237-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 84B181ACD38
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTI1IGF0IDE3OjMzICswMTAwLCBGZXJuYW5kbyBGZXJuYW5kZXogTWFu
Y2VyYSB3cm90ZToNCj4gT24gMi8yMy8yNiAxMToxOSBQTSwgQWxsaXNvbiBIZW5kZXJzb24gd3Jv
dGU6DQo+ID4gRnJvbTogR2VyZCBSYXVzY2ggPGdlcmQucmF1c2NoQG9yYWNsZS5jb20+DQo+ID4g
DQo+ID4gRGVsZWdhdGUgZmFuLW91dCB0byBhIGJhY2tncm91bmQgd29ya2VyIGluIG9yZGVyIHRv
IGFsbG93DQo+ID4ga2VybmVsX2dldHBlZXJuYW1lKCkgdG8gYWNxdWlyZSBhIGxvY2sgb24gdGhl
IHNvY2tldC4NCj4gPiANCj4gPiBUaGlzIGhhcyBiZWNvbWUgbmVjZXNzYXJ5IHNpbmNlIHRoZSBp
bnRyb2R1Y3Rpb24gb2YNCj4gPiBjb21taXQgIjlkZmM2ODVlMDI2MmQgKCJpbmV0OiByZW1vdmUg
cmFjZXMgaW4gaW5ldHs2fV9nZXRuYW1lKCkiKQ0KPiA+IA0KPiA+IFRoZSBzb2NrZXQgaXMgYWxy
ZWFkeSBsb2NrZWQgaW4gdGhlIGNvbnRleHQgdGhhdA0KPiA+ICJrZXJuZWxfZ2V0cGVlcm5hbWUi
IHVzZWQgdG8gZ2V0IGNhbGxlZCBieSBlaXRoZXINCj4gPiByZHNfdGNwX3JlY3ZfcGF0aCIgb3Ig
InRjcF92ezQsNn1fcmN2IiwNCj4gPiBhbmQgdGhlcmVmb3JlIGNhdXNpbmcgYSBkZWFkbG9jay4N
Cj4gPiANCj4gPiBMdWNraWx5LCB0aGUgZmFuLW91dCBuZWVkIG5vdCBoYXBwZW4gaW4tY29udGV4
dCBub3IgZmFzdCwNCj4gPiBzbyB3ZSBjYW4gZWFzaWx5IGp1c3QgZG8gdGhlIHNhbWUgaW4gYSBi
YWNrZ3JvdW5kIHdvcmtlci4NCj4gPiANCj4gPiBBbHNvLCB3aGlsZSB3ZSdyZSBkb2luZyB0aGlz
LCB3ZSBnZXQgcmlkIG9mIHRoZSB1bnVzZWQNCj4gPiBzdHJ1Y3QgbWVtYmVycyAidF9jb25uX3ci
LCAidF9zZW5kX3ciLCAidF9kb3duX3ciICYgInRfcmVjdl93Ii4NCj4gPiANCj4gPiBUaGUgZmFu
LW91dCB3b3JrIGFuZCB0aGUgc2h1dGRvd24gd29ya2VyIChjcF9kb3duX3cpIGFyZSBib3RoDQo+
ID4gcXVldWVkIG9uIHRoZSBzYW1lIG9yZGVyZWQgd29ya3F1ZXVlIChjcDAtPmNwX3dxKSwgc28g
dGhleQ0KPiA+IGNhbm5vdCBleGVjdXRlIGNvbmN1cnJlbnRseS4gIFdlIG9ubHkgbmVlZCBjYW5j
ZWxfd29ya19zeW5jKCkNCj4gPiBpbiByZHNfdGNwX2Nvbm5fZnJlZSgpIGFuZCByZHNfdGNwX2Nv
bm5fcGF0aF9jb25uZWN0KCkgYmVjYXVzZQ0KPiA+IHRob3NlIHJ1biBmcm9tIG91dHNpZGUgdGhl
IG9yZGVyZWQgd29ya3F1ZXVlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEdlcmQgUmF1c2No
IDxnZXJkLnJhdXNjaEBvcmFjbGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsbGlzb24gSGVu
ZGVyc29uIDxhY2hlbmRlckBrZXJuZWwub3JnPg0KPiA+IC0tLQ0KPiA+ICAgbmV0L3Jkcy90Y3Au
YyAgICAgICAgIHwgIDMgKysrDQo+ID4gICBuZXQvcmRzL3RjcC5oICAgICAgICAgfCAgNyArKy0t
LS0NCj4gPiAgIG5ldC9yZHMvdGNwX2Nvbm5lY3QuYyB8ICAyICsrDQo+ID4gICBuZXQvcmRzL3Rj
cF9saXN0ZW4uYyAgfCA1NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tDQo+ID4gICA0IGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiANCj4gSXNuJ3QgdGhpcyBjaGFuZ2Uga2luZCBvZiBkYW5nZXJvdXMgc2lu
Y2UgMDIxZmQwZjg3MDA0ICgibmV0L3JkczogZml4IA0KPiByZWN1cnNpdmUgbG9jayBpbiByZHNf
dGNwX2Nvbm5fc2xvdHNfYXZhaWxhYmxlIikgWzFdPy4gV2h5IGlzIA0KPiBrZXJuZWxfZ2V0cGVl
cm5hbWUoKSBuZWVkZWQgYXMgb25seSB0aGUgcGVlciBzb3VyY2UgcG9ydCBpcyByZXF1aXJlZCBm
b3IgDQo+IHRoZSBvcGVyYXRpb24/DQoNClRoYW5rcyBmb3IgdGhlIGNhdGNoLiAgWW91J3JlIHJp
Z2h0LCBJIG1pc3NlZCB0aGF0IHlvdXIgZml4IHdvdWxkIGRpc3BsYWNlIGJvdGggcGF0Y2hlcy4g
IEkgd2lsbCBkcm9wIHRoaXMgc2VyaWVzIGZvcg0Kbm93LiAgVGhhbmsgeW91IQ0KDQpBbGxpc29u
DQoNCj4gDQo+IFRoYW5rcywNCj4gRmVybmFuZG8uDQoNCg==

