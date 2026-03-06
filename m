Return-Path: <linux-rdma+bounces-17575-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHE7OdKFqmkhTAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17575-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 08:44:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 909A721C975
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 08:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 617BE3019F28
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 07:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4656C37754B;
	Fri,  6 Mar 2026 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TtQGIG+z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GqPpX19W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A18C3750D7;
	Fri,  6 Mar 2026 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772783051; cv=fail; b=GQJlbEYfiKTn4yP+aKlo/+1Hy/sUjhRuD8u301thol+KBHTOrp1ncH3xhcF70aSAMezZM/NO3QxQBs25gLAip+Hs9gJJMwEHh0vmGewOTtxcOxafaZPsVvNHJybZCA0yZ71dSNbI9hsdhyqL771CDeEIcSNHyNEKHgU2d56TVss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772783051; c=relaxed/simple;
	bh=8g/6dCQ26LJMTxqbCZ6u7mnbJMtckyFZiURp9CP97ZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QDlu0bXM9fULBlUWIwij3qQEfmogEnHtmoAwbxdxCtCrQM8ljl3goXnQQ6FwKI4MjFw5XeYl7bNWEqfwTPGGjrOsa/1wDad6/D/HSvbRau8zkkouPhmkJTwptR3R8f1g8J6Mw8/fbbQgwUnC/NwqpkpakpwwnGSDKMVhFmQyYyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TtQGIG+z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GqPpX19W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6267FJd84153954;
	Fri, 6 Mar 2026 07:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8g/6dCQ26LJMTxqbCZ6u7mnbJMtckyFZiURp9CP97ZI=; b=
	TtQGIG+zJ5AaDQFSCQp4/+6QqPByB4z391YETlbiphAUW+dJeZc8gRohigjOmxVz
	Rs6iuNLzYgOjzyRUmWLPOMJEmbgTSZ3DEkHnLlwtktm3R95xndnIPW0/x6YjKNOz
	a7iIoLvybRrnSDGvwoQB7I8v8aImXZrebq+WXYLVKwWg/kdQaeby1Nzy+oIdA76p
	FY97LugUlBnneAJ6H5MU4N5CNDLdzLio8X85zF5qdix7GRGzWWmCRkmF4TNZzwH3
	mOsySs6wVGMyElMxd3pNYVIudHFdRKkn4l0dIfDN19GUOaXpaWKdQaNlVi8BvMbl
	VzEDXpopemS1Upx5uupopQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqtcfg12b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 07:44:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6266F1rL021507;
	Fri, 6 Mar 2026 07:44:01 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpte3bxd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 07:44:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCk7Xt8eu1uQmEFR9RpG5Dl3LVyKKPB63HGTBhyTflhUojD38AnOIbnp065KuSbBrKcMhlPWT6A7AtOI3PcSo2Xb/FXRNcQNEBN8GskrhavfoahL+nHIHCvYck+RwaQV/EBxG/RVfqsGMHViBUSR9M5y/6VQ138sD5xTGjHGc/vMAxCkOrKetbxKZOUokrOphZdHciIWGBxSefOQ8mFrS8SkGnO2bRykGydv2crRoLbaU6gWZro5YTj+VZzEDeCJdwcJXpFxxkuH0EvAddkI6vuidLxdiXqnpEOfbKxqQwcmjYoFBWwl1Y1ebvMGn67cKEstLvlceVGIM2oJ5PfrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8g/6dCQ26LJMTxqbCZ6u7mnbJMtckyFZiURp9CP97ZI=;
 b=XsVyDmJpdZAObYqjzoWVbcjLqSSmF7h2Xx5SQBCmMj2wM3zhDgV8x2iWVg6Ql15MzjLFMEA+E6vcFUU2UFCTrWwJsCNYnqoxFYdZl6Rpmuw0aMXoc3DT9GISul2LdkTKB46f6yYWtC5EWjV76VdhPnRZGONbFJ3jOB1+jYpzpCmurPdYAxeBLIcznpFB9C1gnF7IypkUGo3pwaFx5iKXOhtcioW3WfGbdfTBGrUAm16/rzZW9IhI3KBnT1AVNCi7/y1IOi1G6L0Cy+6zawJYe7Ivium/twweoKorPpXVHhNCVOAlRMVY+Puar4I4fymCiVsv5jNFvwfdnXvbDB/Lqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g/6dCQ26LJMTxqbCZ6u7mnbJMtckyFZiURp9CP97ZI=;
 b=GqPpX19WCUfSGBHY6wOeaVsRm0/8l9iYz2+WfY1p5KY7GgvkPPBLdSrMbS87zYNXaDOgBJToVIT8XltxcSVsVpcsSRKVcU7yEkRt/mcgUpTV1eyk9tkVrEX6/ziD91m+fwewul4f+nD7utEGOw3s7N9Dp8iJionaPQAfXmBeOr4=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 IA3PR10MB8137.namprd10.prod.outlook.com (2603:10b6:208:513::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.19; Fri, 6 Mar 2026 07:43:57 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%4]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 07:43:57 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "achender@kernel.org" <achender@kernel.org>
Subject: Re: [PATCH net-next v1 0/2] selftests: rds: refactor and expand rds
 selftests test
Thread-Topic: [PATCH net-next v1 0/2] selftests: rds: refactor and expand rds
 selftests test
Thread-Index: AQHcqgkqJFrpuvIOsk+fHUE6JV74GrWcB0cAgAGn/YCAAQcYAIACb4mA
Date: Fri, 6 Mar 2026 07:43:56 +0000
Message-ID: <a2184a82a5fccc0b7bee91858ff4b3d0d37054ab.camel@oracle.com>
References: <20260302055518.301620-1-achender@kernel.org>
	 <20260302173302.4d1634be@kernel.org>
	 <18aa553886ee12855c28d9498b12d2fdaeee9b3c.camel@oracle.com>
	 <20260304103212.2e7a58ba@kernel.org>
In-Reply-To: <20260304103212.2e7a58ba@kernel.org>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|IA3PR10MB8137:EE_
x-ms-office365-filtering-correlation-id: 4fd0f89d-2d17-4747-d549-08de7b541fc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 6eftT7gX/4Delb/oDpgtqIZGkEtEqaVi9syRJcY3h4Th3SWIIYLZc6akEN5dKkHpqueaNrQE/O3r/YHCQxYZ6+D3C7tFgMlI8w/y8G4BFD7Sg+mZV8Ay2IrLvnh2G9aQPmB1wMN/VBzDG+1/sns9UcbJEF0afhbRisOXFdmpgAFzsl9yWN51qyVtnf7ZOyiNvN9qjNXid/C79SPUi7ZA/2yN8Hiy3XGSFTmhHUtdjV0xGdDqUHmv7qqfXeX+Z+Hleipz5kgYpwCpuc7KNK/GhfAj0ptHrhjGI2njdQmnRGXNowdKkpyjXX9YmkxjnLjRhYhcjwvbVC3dAjmJxszwFxhU3TBlYZOtHUa1juT5/F4Wlo2kQ2EQk5eBKqKjzuQAPjaNDIPMeaaDaaY1dYT8HHnvRy4IaI+KGWvK2al7o6MCUFTaJNBzG8vUG6v0GEuhUltkG0Xr/CXY3C1UlfLoGjdNeq6hHgT67DiJlOIkip+uB6bYm2JeCz+a6tJX+c1B63seLaFQFRrZWs/D/qezwM1Ol18djfecpl+QgZQmipjsnBraTbH2x3RVrgdVnUDgqgb3CjoBcqLZYDq4b7DDfN6+A3PKbxrUW7iXgMSnsaAu7DSe5+enq0i8V/+XPtHdzxjq3btypqNcrUmQB7q8a/GoqzgDNRnqPd20BUHUH7z5GKYnq1NaxciJiQ6XupYoFBAQDPMaiirpBEQtWrYvgIo1urPx0UsqLqqiXR0IcoWh26w+EOJmrn3BrW0SunJyhlxvLJgHkWxeU3MRoGppxMYg+Reh4awwvO7bjUe8QMc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TUQ4ODdvZy9qbStWTm8vdE0rUDg0dXFaVVhISlVnbCs3UmI2cmN1c3pYclk0?=
 =?utf-8?B?dXdkQys5NUh1WGxLMHZXa3dSbTBhUEFqT1ZwUE5LUjBHL2RHYlZ3VnlTeWcz?=
 =?utf-8?B?aXFiZ0gwTnJtM0RwNWxobEVGNFEyZkZmRUhRc3h2eldWbkx5dFFjRGwwaDhD?=
 =?utf-8?B?Sjk4MEI0WnA3azBFMmxOZlp5Ty9INW9XNVRBQ1ZveEFESlBHMTljRlRaRWdm?=
 =?utf-8?B?MWtsaFpGN1JrUEYzZ0gycURGWjl5L0M4dk5obU5UbmxJU3BUcmthT29aMG01?=
 =?utf-8?B?d0d6ZWxvREhBYWd0ZC94ZkRJT2wzYmtHNDlVQUZQWjY4endLYTNFNnhGS3V5?=
 =?utf-8?B?dm1KRHI0b3l4anBybTBtOXkvK2RBMVJZMEw2azE1V3hWZnhQbVl6VW9jeWdW?=
 =?utf-8?B?cjRtWnZMald5ZEtDU2JiaHRRQ2lQK3RIOFB4WS9hR3N0VVk5Z3VHR0dHTXhi?=
 =?utf-8?B?bDN2UG5LS0EwSDd3UjZINExOVU1DcHFVZ3psOW9qeXFsUTJsdlNPbzlidVFr?=
 =?utf-8?B?VmlMczZGaldnVjVTSUVuOHZCTk1iL3prSlRRUDl4eHRPbXpPR1doSzB6ZHp1?=
 =?utf-8?B?SG1DN0o3em1UQndFWml0aWU3VUtQd1Yyam05V3NPQ2JFZzhjS2J3czEzeDMy?=
 =?utf-8?B?NkZQNEVLNzVDc2xNM1BrQm1PaDVGY2t1N3pXdktpaDMwNzMyMGlXV1dCUlcz?=
 =?utf-8?B?NWdNcnd0Y09CRzBJaFlXMjNxejVkWlVFTlhnaDBIVW1WR1NZT1FrNlJ0amtt?=
 =?utf-8?B?Z3J6elRYMkhtQUVUUWxDYmFvYlVMRnJtYkNGaWtUazMxUzBSYVFKOUl0YVJO?=
 =?utf-8?B?WjVwUkRNMHdtOUZmaHNXK0ZoRmczcHQ1N25pbU1UclozaC9OUVUzV2dLMncv?=
 =?utf-8?B?NEt2NDFlbUtwanBHZVRRMkpNQUtpTmJjZm1FM1F2RGlEQVJBelRiaXhTU0Y2?=
 =?utf-8?B?dmZsZ0tndzIySk0vVHJlUzk3S2dMaDdmZFo4L3U3T3l0Y2tubTZqSlRGOXJh?=
 =?utf-8?B?aWdIVzZ4SDU3UDRlamM4QUIyckxHQ2prT0VseDJhRGxFbFN2QURlczU4Kzh1?=
 =?utf-8?B?TzF0TzhNZ0EwYlBsQ2tkeWllR1Y4VkpxUzB2K3hPdW1QMXFlZlBNMDN5TmNn?=
 =?utf-8?B?Wk51SmpsUFlHOUlFbnd3VStOcFFpOUFOOTdkNnM0aks3MHEvQ08rUzR0UzBl?=
 =?utf-8?B?dDRJWWR3T2VTeTBXbFRzVTZ2Uk51VmV0TnhZS1orcS9PMW1iWTlycDVvSVZG?=
 =?utf-8?B?TFZNK2czaE4xR1Z6VFljRUk3TGtPVVpuVWpEeHFOd3dKTHhPc1lVeDQvcWtC?=
 =?utf-8?B?REFWWUFENEJ3MFhPMk9vc2h0WnY1bHFTd3VPYzdiazJPYmQ4NHVGbDhHdWVZ?=
 =?utf-8?B?VUxhZCtkcU5aVlVqeVZwb2ZSZjVYOHlLZStFUFlrYlJmazdkektjUlNqc3pv?=
 =?utf-8?B?cWFLMWRkL25PYzVRaUt6TGF2WGVEZ1R6TTk4cWZDaFhXbU1icWhXcTZhQlVJ?=
 =?utf-8?B?dFhIcnpNR1ZJZjUwc3VyZXdib0huTHVIdWxXNFRYN2hWSVhKNkh4VGNMMjJU?=
 =?utf-8?B?QUx4TkZ1bW5RT2JkbjlOUmVIdUpIYW8vSDR2REJjb2lPcmNwZFNuWnNWTVJF?=
 =?utf-8?B?RXU1K2xvQmNzNGhtN0Z0UCtCbVBNYytkMHUya0pUMVdDSkZEd3Q5K3J5R0hv?=
 =?utf-8?B?UjFST0NKbGZnb3cyYnVEM2ZCRW5EWVBLUlY3T1B2aFl4TFFUQkd0OGM2bUhK?=
 =?utf-8?B?M2J1ODJIY0E5ZjZTSHA5UGRrK3BLcW9uaXVtdEswb1FtSVQ5YlY1L0s4SVhj?=
 =?utf-8?B?UjJuRTdpcFMyb0w2cS9aZkdOUGV3QTQ3Wi9vdkY4dGZOZzFtdmU1WDY3aldE?=
 =?utf-8?B?NzlQdkpzd1VzS3VCYkpqZzM1UnV3dnZma2lBTzR0NTJqa1k0dkgvby9teUF4?=
 =?utf-8?B?V3lVcE1PRlZ0N2VKQTgreWp0M1h3allUOVdtcUZhbEJ3MVhZN3g4UzRyNjJ2?=
 =?utf-8?B?NVU5T2R2dGlaM2Y1emNJZWgzYzVmeFVOMm1OZnduSHQrNjdjQmRUeDY0UWVS?=
 =?utf-8?B?R0pFS20wNzlIamtITDdIUVFiQnhlNGIrelNRRklWV2svdkcwRHpVSVU0RGFL?=
 =?utf-8?B?b1RSczdlMDdhU2QwRTExTndFQXhRaVZRc0lVd3lYaUlqQWlOenFQSFZkd0Iw?=
 =?utf-8?B?WkhxSlhCeWdBdm9YeUI4QWkrM0l0RTVlbUZUK3VVNWk3RlhTVGY1Zk9SZ1Ur?=
 =?utf-8?B?M3NsUGNNU3JTYWJJdy9sWW1IdnRXMjVta21MU0pzNERwR2tJMTdDNGpjTDkv?=
 =?utf-8?B?VmhKYkQxcGpXNGZaYy9JcWNaV0pKdXBlNTR5VWdTYlNTVVdDM0t4YzVxOHdm?=
 =?utf-8?Q?bQgsiLNXzpVAhrvA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F94D56595F6824AB1E0249A79C14AB1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mk15QRKNOLxomn9CriBfYhZD4oY8HqciDQAvZhQcfNDcsTDSIhpKcGWCi6sOtCy2o+Zu78VSVsUfVNPSs8dA4eJ9Mk3emYbz6m6t0bRgiL+XfZIY0H3pGeu2dxwTZ22307R7uYyozyuMopz16C+WdBSu0LRwhUnIWgkz4A5hEpSUnvv0N540+KFnZ9+U5RHj9Y/457Ba4fcdafd9PAOKWOOyrj7WbzKFcPDihYARLY6K3M0IT98HSDEMJEh/rEjm3/fNlzh2dA9+rruzxUAdCArTfCzfJS3Ng/mVXrhvQbQ2tzUPw5X9D3Pd3v9qwydSsMcb3x4cO9jyYyjInRQfuA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ctdRGsabJM8jie2AH2Ac1BKDMzbMp0wx+9lJuZrNNeOuHJjkf37VL67oPknb3hwpBXX+oA4zYVpcjaIx0aVPWSJQ349VfQI2I1+biAXEPEa9IJsZ/uxMehprglZEnBvB/vetiZhTH/s9lhvH6pcxQJsUu9mE8nEsiMdsLO3BXnCte4QNUrfcyxj/uMq0N0eBtmwG3g3Qg4Vo0RtUX9hMIk6LfVhr1tHjw+ERP0AlbVDD0eLS82lp0DmiGrUH8UyPUdOYEWigozC5J6MIfjFwkNpuOZkDGPbtMfoXBGD+uZVygma3E0X1HG5V2YXiF1V9KGBo9FhQm2EwvJ/NH+lO3PpZD8UmMo3D1PI5o+Emt6fpuyrwPbl3tTG0NnZGoT0nhlNZM+GtECduCnqAC4dVAjvECH5YRzpoKAKu+zoRse2DENOveILwoeO9V+wEnStfIEk6jXcp5YhCn1Cmpiwe5pdFTI3wDal0R2apCANga9QreL9O//YTZx5FQtVAxARXcTmnkkxtbfmTvSXf/ADEBSXaPmo48pNvX9G76x1LKCs9zXeQV7K+00JNAY18bK3BMbyGrjBg4YNuFJpGPUzUoGrT4yb9WOFD33jmPHuMcj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd0f89d-2d17-4747-d549-08de7b541fc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 07:43:57.2746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W76V3cWw0kEZ77d4Ir8vMAg+fdtAAcgp/erDKS1U4xnW0cqOa/CoJ1fL9MkpCKVl02Rl0OjkSSNhIzVoe0nYiodW8yO/fTl61Z7iOdbT1DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603060072
X-Proofpoint-ORIG-GUID: ecijnbs38NCiFrW9b5GeVFc5wpc2mfzs
X-Authority-Analysis: v=2.4 cv=P7Y3RyAu c=1 sm=1 tr=0 ts=69aa85c2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22
 a=zGJJCzKXiVuII2EnNsAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3MiBTYWx0ZWRfX2o20NHGs5in9
 OGtk7XS7RTQ7dCwhucsxnMMh7sfh3MPLy2mkOO9vN30+NxJ0At+epDJt+i3tg5aD0JrANQ0kjfO
 r/6yfH7hV4lfZQ9MNujPt47yF1QywSfpb9U5nR/tQrkJ+p5xRFUG0qQWnPUBMTgLmMaOQHrwU8m
 wFntBbr4eNQUkepvUARn4TIHd7I5yzquCDEVJD6IbRYBJTD49t4La0p3RccwmSDCtOMDZs++C+W
 Ov3YIspEb46l6SIjxu2mSoUAke0wmYeAZtYbN5XLlojbOT4fsmz8kq/uW8IKxdY710799nQNRvL
 F3N5axCMTBBqDOoh7IyDRtn5d9XFA4cZbKnY7+i1aE7RJWFyBq4YuDcdHLNrgJap/uCg5A2XCz4
 zDeoGEFB8utqGbPYV1yGCwy2S7kYeQ31Iwu7CNhCEN3lc9cgOElda8XDdYA9STZToTzMVBDMZkk
 W9yxUMdlUvgbJu4OlTA==
X-Proofpoint-GUID: ecijnbs38NCiFrW9b5GeVFc5wpc2mfzs
X-Rspamd-Queue-Id: 909A721C975
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:dkim,oracle.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17575-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

T24gV2VkLCAyMDI2LTAzLTA0IGF0IDEwOjMyIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCA0IE1hciAyMDI2IDAyOjUwOjM0ICswMDAwIEFsbGlzb24gSGVuZGVyc29uIHdy
b3RlOg0KPiA+IEkgZGlkbnQga25vdyBpdCB3YXMgY2F1c2luZyB5b3UgZ3JpZWYsIGJ1dCBJIGFt
IGhhcHB5IHRvIHdvcmsgd2l0aA0KPiA+IHlvdSB0byBhZGFwdCBpdC4gIFJEUyBpcyBhIGxpdHRs
ZSB1bmlxdWUgaW4gdGhhdCB0aGUgbmV0d29yayB0b3BvbG9neQ0KPiA+IGRlZmluZXMgdGhlIHVu
ZGVybHlpbmcgdHJhbnNwb3J0IGl0IHVzZXMuICBJZiB5b3Ugd2VyZSB0byBydW4gaXQgd2l0aA0K
PiA+IGp1c3QgYSBwYWlyIG9mIHZldGggaW50ZXJmYWNlcyBvbiBhIHNpbmdsZSBob3N0IG9yIHZt
LCB0aGVuIHlvdSB3aWxsDQo+ID4gb25seSBiZSB1c2luZyB0aGUgbG9vcCBiYWNrIHRyYW5zcG9y
dCBpbiByZHMua28uICBJbiBvcmRlciB0byBnZXQgaXQNCj4gPiB0byBsb2FkIGFuZCB0ZXN0IHJk
c190Y3Aua28sIHdlIG5lZWQgdGhlIGVuZHBvaW50cyB0byBiZSBpbiBzZXBhcmF0ZQ0KPiA+IG5l
dHdvcmsgbmFtZXNwYWNlcyBzbyB0aGF0IHRoZSBkZXN0aW5hdGlvbiBJUCBpc24ndCBzZWVuIGFz
IGxvY2FsLiBTbw0KPiA+IHRoZSB0ZXN0IGNhc2UgZG9lcyB0aGlzIGJ5IGZvcmtpbmcgc2VydmVy
L2NsaWVudCBwcm9jZXNzZXMgYWNyb3NzDQo+ID4gbmFtZSBzcGFjZXMuICBUaGVyZSByZWFsbHkg
aXNudCBhIHJ1c2ggb24gdGhpcyBzZXJpZXMsIHNvIGlmIHlvdQ0KPiA+IHRoaW5rIHdlIHNob3Vs
ZCBkbyBzb21lIHJlZmFjdG9yaW5nL2NsZWFudXAgZm9yIGtzZnQgZmlyc3QgdGhhdCBpcw0KPiA+
IGZpbmUuICBMZXQgbWUga25vdyB5b3VyIHRob3VnaHRzLg0KPiANCj4gSUlVQyB0aGUgbmVlZCB0
byBzZXQgdXAgYSB2ZXRoICsgMiBuYW1lIHNwYWNlcyB0b3BvbG9neSBpcyB2ZXJ5IGNvbW1vbi4N
Cj4gV2UgaGF2ZSBiYXNoICJsaWJyYXJpZXMiIC8gaGVscGVycyBpbiB2YXJpb3VzIGxpYi5zaCBm
aWxlcyB0byBkbyBpdC4NCj4gUHl0aG9uIGxpYnMgYWxzbyBoYXZlIHNvbWUgc3VwcG9ydCAodGhv
IHRoZSBkZWZhdWx0IGxpbmtpbmcgdGhlcmUgaXMNCj4gYnkgcGFpcmluZyB0d28gbmV0ZGV2c2lt
IGRldmljZXMpLg0KPiANCj4gV2VsbCwgbWF5YmUgdG8gYmUgY2xlYXIgSSBzaG91bGQgc2F5IHRo
YXQgd2UgX2V2ZW5fIGhhdmUgc3VwcG9ydCBpbg0KPiBsaWJyYXJpZXMgZm9yIHRoaXMuIE5vdCBy
ZWFsbHkgc3Ryb25nbHkgb3Bwb3NlZCB0byB5b3Ugcm9sbGluZyB5b3VyIG93bg0KPiB3YXkgb2Yg
c2V0dGluZyB1cCB0aGUgbmFtZXNwYWNlcyBhdCB0aGlzIHBvaW50LiBJIHByaW1hcmlseSBjYXJl
IGFib3V0DQo+IHVzIGJlaW5nIGFibGUgdG8gZXhlY3V0ZSBhbGwgeW91ciB0ZXN0cyBpbiBvdXIg
Q0ksIHdpdGggc3RhbmRhcmQga3NmdA0KPiBjb21tYW5kcy4gTWF5YmUgSSBkaWQgc29tZXRoaW5n
IHdyb25nIGJ1dA0KPiANCj4gIG1ha2UgLUMgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMgVEFSR0VU
Uz1uZXQvcmRzIHJ1bl90ZXN0cw0KPiANCj4gZGlkIG5vdCB3b3JrIGZvciBtZS4NCg0KU3VyZSwg
bGV0cyBnZXQgdGhpcyBmaXhlZCBmaXJzdCB0aGVuLiAgVXN1YWxseSB3aGVuIEkgcnVuIHRoZSB0
ZXN0LCBJIGp1c3QgcnVuIHRoZSBvbmUgcmRzIHRlc3QgZGlyZWN0bHkgbGlrZSB0aGlzOg0KDQp2
bmcgLS1idWlsZCAgLS1jb25maWcgLmNvbmZpZzsgdm5nIC12IC0tcndkaXIgLi8gLS1ydW4gLiAt
LXVzZXIgcm9vdCAtLWNwdXMgMTYgLS0gImV4cG9ydA0KUFlUSE9OUEFUSD10b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9uZXQvOyB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcmRzL3J1bi5zaCIg
Mj4mMSB8IHRlZSBvdXRmaWxlLnR4dDsNCg0KSSBiZWxpZXZlIHRoZSB3YXkgeW91IHJ1biBpdCB3
b3VsZCBoYXZlIGl0IHJ1biBkaXJlY3RseSBvbiB0aGUgaG9zdCB0aG91Z2guICBXaGljaCBjYW4g
d29yayBidXQgaXQgd291bGQgaGF2ZSB0byBiZQ0KYnVpbHQgYW5kIGNvbmZpZ3VyZWQgY29ycmVj
dGx5IGZvciByZHMuIEFsc28gSSB0aGluayB3aGVuIHJ1biBpdCB0aHJvdWdoIG1ha2UgcnVuX3Rl
c3RzLCBrc2Z0IG1heSBoYXZlIG90aGVyIGxpYg0KaW5jbHVkZXMgdGhhdCBnZXQgaW5oZXJpdGVk
IGJ5IHRoZSBjaGlsZCBwcm9jZXNzZXMgd2hpY2ggY2FuIGFmZmVjdCBob3cgdGhleSBydW4uICBC
dXQgSSdkIGxpa2UgdG8gc2VlIHlvdXIgb3V0cHV0IHRvDQpjb25maXJtLiBDb3VsZCB5b3UgaW5j
bHVkZSB0aGUgb3V0cHV0IHlvdSBhcmUgc2VlaW5nPyAgVGhlbiBJJ2xsIHNlZSBpZiBJIGNhbiBy
ZWNyZWF0ZSBhbmQgYWRkcmVzcyB3aGF0IHlvdSdyZSBzZWVpbmcgb24NCm15IGVuZC4gDQoNClRo
YW5rIHlvdSENCkFsbGlzb24NCg0K

