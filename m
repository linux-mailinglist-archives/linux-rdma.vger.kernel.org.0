Return-Path: <linux-rdma+bounces-18426-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHr8LNa5vGnQ2QIAu9opvQ
	(envelope-from <linux-rdma+bounces-18426-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 04:07:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD9A2D554B
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 04:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 908DE306177F
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 03:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88FD2DFA2F;
	Fri, 20 Mar 2026 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JxEEPvzz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xjAQvuiR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB32620DE;
	Fri, 20 Mar 2026 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976018; cv=fail; b=kHBzPQh8rG1vy6pjFBmsq74SbJ8OfGjHzLpMpwJSBkGBbxxZv4Er8H+0zuHIVOoB9iFMGdS2EVMkkdFGS+tdANOlnP1sjjYIoulcoDDg+TJYhYWZn/eOlLss72lEFG2b2hLizIQEwzuEvxLJIKbRT9bsU9R68IKVgqFfAHdPBbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976018; c=relaxed/simple;
	bh=GhCxwDd+6JtHOdkbCE6qMFqQl+fFoWflki5ltxqyGdY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pFMpqm7I/oitBuOcESDSH661wzvyBbnI8SWSeyHuIIn4j01zsGCZjA2MYmU5JqG35wRO2eKQ+K52cQT2IrwmkiCRcCb8gg7LRmfLG+UGXAigXoMsw5EHchKNv/OHIadZT2s17UuhwgRQFdTGjXEQv4VRUvFrpSgmPTrKy12Jd94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JxEEPvzz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xjAQvuiR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JGFAoK1776835;
	Fri, 20 Mar 2026 03:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GhCxwDd+6JtHOdkbCE6qMFqQl+fFoWflki5ltxqyGdY=; b=
	JxEEPvzzBlaGqxEqmwcpOwaYThYSRXKS2fA1lIVyL/D9QyOEBoAXg9YIjtbAj4I6
	52BMOutT6shf5DGsYh9J6FVvSkymJpOOiCMSOqWZFZFv5Vge/ygGewWTZx06Bfos
	YYo/QfSDLnqdnBqr9ZKEUWvMcQQYJ2NEXYJvsz7xdq8RxGxMMAPr9jZVkpETZCDA
	w01srJYvL06RPf8D8BVWOPi4BYqiwR/6GlU9/z/IhdqTF5JpFGueQPqNfKCNJl0S
	PN0e2BG3MJMkGOaW2efONm+kULu/WRh9JELnOKOy1PSLAbUXbDToK7zt/RMWFBox
	ZQ2wYN7rkQGhCEcNyaawrg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8h1nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 03:06:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62K0iJGI002827;
	Fri, 20 Mar 2026 03:06:47 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4qyc9e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 03:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWUSIJxA59n5ZxKT73I4ukgDDSeeHbvEa7K0NvLpPfIdwpidLJYV4gCRg13pL8+MVqlQOZSzC7noG3mzgX47KoiWXBItnhhBBkoKeaL06CY+f7J0dAlhDfX62Yr3ZMqo4cpZ46vU00azUSyZLgqQ9O4Neo9plWJcrhhLKjK7YT1pKcKsYoUskAuoxyKH1409Ev3S6PKMKGXxWcCtMMKHrHE9im1spxcP2Qi0wk404XBgHu3xbv4nPOHcNp7Sd1mRGHXG0F6OBCcnRvsHJBkkNtWOoVbnmhu2K9W01RCx3ysW9GSN3Nr4Xk5FuaQ9nxiSWiKosbjDFnrNWKDIW5CrZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhCxwDd+6JtHOdkbCE6qMFqQl+fFoWflki5ltxqyGdY=;
 b=y5WJeyvvyzQPe/Tln0hZUqE/D/DyTjBOjpQ3NKNrbMMCbb/Q9+V3GEihym5jM8WJQUqv1UvITVezhus8ts9XMSy0RK+mWbgrbsUicmKm4qDhgdnYHY7LDogfETKTdAiTz98mh8en/ad4rR5BkaE8UwxV/d7ffNk7052Wq09Utb81pIoFaux/8cxMsmLL//ZHCbdLt2WpYb3rFxGQeGlpZ9160pQP6arBfFQcRJwN4miPGbxPRYUefpFHlF7ZK0rEAwrSxsV8THVd7Ae0pIIGGTpqqzNHNHb+m3NyjQsY6nqzPSkqNnPVlbDSXteoPKCAlFXoVp6q4pfqYjgjsodkwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhCxwDd+6JtHOdkbCE6qMFqQl+fFoWflki5ltxqyGdY=;
 b=xjAQvuiReMUfBaQldaTftLH6NwippnM06sbh1dt7+4hzieCRmvDZh2Q396YPWRLfwLQMle/HV9druYcVYKsXboeVOVrTpiWX7HIpwc1fkEw98S1Hz0a4LeNQyGZYbbshZmGfXmDYP1YDx+pOi2W+CBVn6D7LZ07tub4Tt1ECvNY=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 03:06:44 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%4]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 03:06:44 +0000
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
Subject: Re: [PATCH net-next v2 1/2] selftests: rds: add
 tools/testing/selftests/net/rds/config
Thread-Topic: [PATCH net-next v2 1/2] selftests: rds: add
 tools/testing/selftests/net/rds/config
Thread-Index: AQHctznRZjNzMH2BdEuqpCXO+bkzqrW2iQaAgAAAQQCAADVtgA==
Date: Fri, 20 Mar 2026 03:06:44 +0000
Message-ID: <ea7b92b1b33831a3de57a4551fe227cba7f8d010.camel@oracle.com>
References: <20260319004618.2577324-1-achender@kernel.org>
	 <20260319004618.2577324-2-achender@kernel.org>
	 <20260319165435.4468160f@kernel.org> <20260319165530.0472ab6f@kernel.org>
In-Reply-To: <20260319165530.0472ab6f@kernel.org>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|PH7PR10MB7056:EE_
x-ms-office365-filtering-correlation-id: 001b6b3c-a545-4869-f215-08de862db76f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 4y+NJkIf9gEv651LU76Xf9hhUNqUHfDdIKkpyK9LAoEj8JMTSZeeZFh5VZ5CMNs+GAdS40RgdDSOt/fKOK8RnL4vIkVOCUPBc8Lc0GF2v+sJ+N4q31i6eDcZTGG8gowdfb+FsOTR/2tFW7S7lDdhHkv+nZinqwdzwIjNifSOxGI3lHtIu1KVypfuzG2SUgDPvLuAFBbPVX990cE9Vg+Hm1j28jhYMGwpEpuu1O71a2NMi4G0fDLg2Kqjtb6HKwIUG4Ug3xvyNN9SZw8j+kQAId/YfLvytC7tY0UDgQKh7CAglkjjpeoXs7WcgCiPn9fSg1l39pC75EcW3c2cuhknjP1KIxuck/UTBq03r4C5ygr8ErIqsSu0oevzatAIleoz6t6P0yRWyR9F9a/F3mzdsr7xxrZwgFdg6+xWazMzV0s/W4XXzZhFEmGwexzo89raTE/DEKlzIc8dnbFi4wTrJ7TQ4TjpicyQ7A3fCxab6Y5uoCvQK0EXxS78dZojesVJsQcRgHV80OBXBX7M5PoP4hmQ5G3VXPVLMJdrg0OTLFitt+dI8lxXiaKfpnMj4Wu8A3g8R7nvTHmuOdZmUxGCQ23r84DdF1C6hLHtYcZoAqdQBrO0V3/0sKbOv+xF6ysUudE1/YZhb1eD+mT7kPt3Qfr/Y3UTRw0OO61Fm7GVnFLFM2plP+eoXKhaZD/EB4VsaUFTNJihPzQmqQKtrf0cSAiyj/eXcX8e9fifhggmUA0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TTB6dGZnOHBXcmVaV3ZLOWpwK2NRY0FiRFJwQWQ4Wng1aTIyQnA5Wk96b0U5?=
 =?utf-8?B?MW9jRFcxSzdkQmZRVWp0MFl5R0JBK0U0VHB0anppc2FTV3hKTmdmZ2REb0tZ?=
 =?utf-8?B?VEFMN3J5WXY0SS9WNTdod3pzWmNiR3h3dW9yc2dtS3FDbnI4aGttemRhbnVs?=
 =?utf-8?B?OXNqSkZ4T2FDSHZZckY1M2hOWUFvc09FQXNPRXdJR3JNYnI1SmdkZS92b0g3?=
 =?utf-8?B?UUMrdk5hRjJRQkI2WCswS2IvZjlvNWkwSTFlYVE3K2p5RlJWQWo2T2dlRGtp?=
 =?utf-8?B?L09UZzRCR3g5QjFTYUpjNFdnQVJkQ2tzM0lGaFlTNTU3a1hoTVdrTzU3TlhB?=
 =?utf-8?B?eFdBSm5pN1VTQkdCVVJ1RHJKY25JVUxGeHdyekZOck13bU5GRFBOWVlSZzc5?=
 =?utf-8?B?bDdNNGVMaHpoZkM4bjBKQzc2ejhjRTFmbytOUjJjQ09Ga2xvdGhLK1RZWUtX?=
 =?utf-8?B?NmsrcE05M3FHV05YcytFMjN0dVBSay9ieFp4bnYzUnZ0RG81ZTNKc2diVnQw?=
 =?utf-8?B?M1c5SUM4QUJoMDRRWHFlUGVZYnRVakk0WFM0M2dYSllVZ045RFk2NjZ3UEU1?=
 =?utf-8?B?VSs4NWhiVWV0dFBrMFBKMWVTK0gxWWVXajR1c2hCSDE5R2RnY3BGWkU2Njg3?=
 =?utf-8?B?cVZLQVdIa1ZvZS90OU9ya1B2dUZzTUVtWVNuT3hQRWlFMHdZNkhSSmZxbmQy?=
 =?utf-8?B?aDZkTVlVaE4vc3BlL0d6OUpJTnRzSitFQmhBaXQ3c25jNHZaQnYvcm80R1lE?=
 =?utf-8?B?c2dZOEJWckVPYk1ybVdTSmNmcTd6eExISFQyMnJZcXFGV3IxMm9VaGJaa2RT?=
 =?utf-8?B?QVAvVnBRNzl2UE1MNHNqdGF1Z3hTY0NlWGZzT0YreGdJZTloUXVqNHIrQU1s?=
 =?utf-8?B?TjVxVzkyUWNiYzVQWjJCSktKQUk5YVJFZGE1OEIwNFhSMnBwMHhkYUVuYlZV?=
 =?utf-8?B?NlJ3QmZqWnNLSHlYR0VWMG9oektZWG9zdDJJRC9HaEVRQktXbS9yZGxLZnMw?=
 =?utf-8?B?eUt4c2F5Nk55YjBuVmJNaUJRTGRPRXdlSVBZbDMyakFidEpLVmladC9XRlhB?=
 =?utf-8?B?NkxZbGZkNS8vdlJ5SHZIYVZPdDk0UTlLSEtUdHlaZTJZVFV2OFpET2xRSWNm?=
 =?utf-8?B?NzVwMUV5aStYTGc4Umd1blNROWdkbXJCejdlQkhRRUM0RThiN3k3ZDJMY3dU?=
 =?utf-8?B?YzI5QnJGMWUzWm1nM0wzU28zb1NTOWpZQ2p1Yit5VXRTd0xXUFNWd1BGSHhE?=
 =?utf-8?B?djZyUTErbWI3K2dqMmxuaG1iSnVCUG5IbEtoRjZFcFlyUUhtZFdxOXNvMkIv?=
 =?utf-8?B?bnlGU3M5ZUhFWmRML3FzWkw3V09oMnprZUs1c2lqYU50TFhyZCsxSkdYQ3ov?=
 =?utf-8?B?WkpqY2lqQU5NSnVYSlNtcnhLVFM0bnRTZlJoLytzQ1YveStDY0liS3ExMUlp?=
 =?utf-8?B?clhwTDVWTW9aZGZEa3VUL1AxSTNybXJrWDMyaTNWSi80YzFyNzdHTVlybUMv?=
 =?utf-8?B?dmJaWU9XWGNlbm1DTVR6TlFJWnNMa2szbXF3b3lScGZYdWlXam4vWEhPREIv?=
 =?utf-8?B?QlJVS2Npb2NMYTcrcHpuczJ4dDRpQVBYUitWVmw2YmF0VTg3TzlIdlp6WDUz?=
 =?utf-8?B?VzlKQ2NuZUoySXRxclprNjBxUHpiZFBvWERvQ1A3VEJRUXh3Yk5nVThsQncw?=
 =?utf-8?B?WC9idy9YUFFDSkx3eWJGR1BMWU15aUxvd1d0d0Q5dVVOc3JCRS9NMlExYmcr?=
 =?utf-8?B?WndlcUIxUnlHUHcyczRlVWowTk1ORWZIUVd3WlEvek9Hdm1nb2IxOGU5em9M?=
 =?utf-8?B?dFpQZmZxNk5BWXJLdGpBTlZGOUVNUEZGTWZVek9TMVZsYlh4NlAxM050NWZa?=
 =?utf-8?B?eWNnYVI2RWZHT0ZKMFhJYlkzY1BqQmkrN0xkS28xKzFxUWhGeHMxdFpEYStM?=
 =?utf-8?B?bVdIOGFkTStEaUZCdnEwd29rNVh0NHlTYlVxUU1xYnQ5TkNCYVRGbnNJc29D?=
 =?utf-8?B?UkhmSDZxYXdFdEl3SE96YzZJUWg3QnJlOXhHZ2VOTnlkUExLQm5DMFNyQVlq?=
 =?utf-8?B?aWUwc0VmcmUrNmYzRXVRMkFYSzI4VXJuTlFzUlpaZVVVSklKeTE0YTk4U0pw?=
 =?utf-8?B?MjdqTzZQUExXb095RWhRUEc3ZVBxMW9veDBLd3p6cEhuRmRuU0gwQjltak9I?=
 =?utf-8?B?aE9aL01EaGVGcFhRNlNOeSt4UmNkUjZ1ZHBDQnVSQ3ZZVkN3dVVtM0o2RnAv?=
 =?utf-8?B?VzVTSnFCNTErbkVhRUN5R2l1YVUwNVpzRzR2Sy9PcmNhOGxRMFRLYUUvS2N1?=
 =?utf-8?B?QTJhZnBiYlJLcjFuRWZXQzJENFZxR2N1RzNmOTdUWEZaWUNmVnFBY3pnVzFv?=
 =?utf-8?Q?YsnYIupi3Ok5YRBY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97C9F68F47313749A60349BA215C7D3E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	IaSCHUHdKvPegiUjvcV/AMmTLEFmKpiEExPUjbL495T4AT3xmkVUvAqqXrqU/DCd3mXm0m1OnrR+VkuctRS/i/zR5jRl3Jqu98VFYOgsYByW5me04iSbZQ2zd/tYjPldw6SL+yOBBYeVq+xLE3NjmtqqwAQaEHye3Gi9Tk/xllXzI+WCpxsS/OFIRp3pg9WNOQz8cGxvG1y5kyfyV2HQLMlxPYp/K7yAGDBxmKAXtjniHUMlP45XFwAEWS0QfmlNu32QYZMr+xzkyIJM2HaSs0oCLOe7z957dVLOz//qP0yyVIyCf6meYkZGrx/p992B4Js6iGTJUnL+ts63C34/Uw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I3VSRTXFWgCg5RCJHGOA9poj2bNOz/696jdpRM8HLMvXR/+gOMaOxjNUcoI3L0ispFmkdt2OEJfyCSyahe2UqzxhIa7Ip8gUxlikztqGFHRMZgY8W+7h3RADt7jIR1qAdIwzcKFavqj1LKIrRvTpKsPFnxXNG5CJX+c2Wqx/7PUOFayKdE0SW88CcycCfTvcYoEWgHtFGXEJbV0rIIEXwBaqmJflq55aT++BNTvmlF7khL1ucZaeHMsdIEM6sLXD+yOg1lHhHxvOT+wpnVHNQGdwC5WDsuLaJlOhBtTSW8VYu8Xa0LYMDcyJ+r/eoaJISaVuzp/+NhCqBE3h9cGqoumsXmuw59uuICbONWV1GsNAbTw+tfvcUDpNGwkMs06vZ9U1B3spAXOaZ9Q0mhQxOYU5XSx6xZkCfNMNelLjR9wI3FZmhdbM2wzfL6BZAF8wp6GAKgxp9DX0mieuAWK5axeoV6L0vLs+yd9X2ZJXkN/xQecKTps8lwyFDyL/lMdcBdjpGXIdofvageqdn9Pzr/9D9iPQeBW+IwombIGFjKGb8J+mT6748QTz2gXi2oEA5AfG2iAlydaHS+IXfmfajvoTKx/4Lp+8kPrQzZhB+go=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001b6b3c-a545-4869-f215-08de862db76f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 03:06:44.1263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QZ1s00vbG2eQbT3xEbMSHZrLhwPDAttN7PQick4tplIXVV2GuEacMO8ShlJsrFlNWo1rvyWqchCjGDjfKopLuSO28+aBsKH98fpdi5qmr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603200021
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDAyMSBTYWx0ZWRfX+WIQTO0AwepN
 gk0132IafGj8lF0GpZPzjaNjn7SyBbV3FYXzhyoEmbAXiEt/MiRT1jKENqfdZElV2Z4Gi7M/OW4
 qO0vHdACDwy5lDHcpI/LTylDLa2TGtQZxjokzBqCdqae+55QUugYHsZkVvXZayTt20HhF+oKwWi
 2ayI1X+s9Z0219DGwoj0M8giBHomqeAmYbDFDz1sRO6e9J+ymPr1dazNfPQS2omsPKwCxI0DSfI
 +aGZelFfkje2fL02WAind50ljjLs+LTnUn244bdaTUex0oBx6u7OY5qbCzD2HSxFf8yS0KT2P1g
 UEq3Q1hJIPdEcrClGBhIPrzJ2GUETj5dY9wP5IjXoaKgWa8g6oS0vXNH5Fd2RzRjxT+SqAekzcr
 R/R1bDOyDeBxtn4AbL0uIU9ExMvuiqZISYOfQ3YKhdTXPl/q10AWri1rC1BkfXsZbAvVBq2g9BM
 Qg5GSamlIooKUgf2+CraBp8jkAa/8jZG8Rd2BJqQ=
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69bcb9c8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22
 a=NEAV23lmAAAA:8 a=0Y59Sbm4WvLNCnl5CAgA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12272
X-Proofpoint-GUID: g-xklylS9OGg1SWwJaHz9fd_8YNVHk7Y
X-Proofpoint-ORIG-GUID: g-xklylS9OGg1SWwJaHz9fd_8YNVHk7Y
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,config.sh:url,oracle.com:dkim,oracle.com:mid,urldefense.com:url];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18426-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5FD9A2D554B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTAzLTE5IGF0IDE2OjU1IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVGh1LCAxOSBNYXIgMjAyNiAxNjo1NDozNSAtMDcwMCBKYWt1YiBLaWNpbnNraSB3cm90
ZToNCj4gPiBDb250ZW50cyBvZiBib3RoIHRoZXNlIGZpbGVzIG5lZWQgdG8gYmUgc29ydGVkIGFj
Y29yZGluZyB0byB0aGUgd2hpbXMNCj4gPiBvZiB0aGVzZSBzY3JpcHRzOg0KPiA+IHNlbGZ0ZXN0
czogcmRzOiBhZGQgY29uZmlnIGZpbGUgYW5kIGNvbmZpZy5zaCAtYyBvcHRpb24gDQo+IA0KPiBw
YXN0ZSBmYWlsLCBJIG1lYW50IHRoaXM6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwczovL2dpdGh1Yi5jb20vbGludXgtbmV0ZGV2L25pcGEvdHJlZS9tYWluL3Rlc3RzL3BhdGNo
L2NoZWNrX3NlbGZ0ZXN0X187ISFBQ1dWNU45TTJSVjk5aFEhTTNqWnp1djNCREJDdXpfWVZ5cmty
eTFrZmR2Ui1lcVIwejZSbnZRMW1hdU1iZlpzaU5VZ3FHYk1aWFA5czhCdkRxQURKQTdPU2FXZGRs
TzRYQSQgDQogDQpPaywgSSB3aWxsIHRha2UgYSBsb29rIGF0IHRob3NlLiAgVGhhbmsgeW91IQ0K
DQpBbGxpc29uDQo=

