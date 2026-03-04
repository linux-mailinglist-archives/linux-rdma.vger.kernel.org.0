Return-Path: <linux-rdma+bounces-17453-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMxzKumep2nTigAAu9opvQ
	(envelope-from <linux-rdma+bounces-17453-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 03:54:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 566FC1FA181
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 03:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FF4930DE19F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 02:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119813537C7;
	Wed,  4 Mar 2026 02:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UAHaDdiv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jwMusHr6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF8F3264D0;
	Wed,  4 Mar 2026 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772592645; cv=fail; b=JN4+virJVht43Ko3fJk4AjwqBryVHpuQ2h5gQBvXz/xshYpQGHRyZgR+4Zk8Zbc0StQJrvIsnHwsJ8dLHmk78iaTt7V/IrcyME0xQj5VnkPJ29D+zAtAcHa1178MvCI7vTwCnbWZI6/P75HaocsSpCv7KuRLsDU90XaXgl9C+iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772592645; c=relaxed/simple;
	bh=ZQyOjtJGfJF3QqKRw4BamZxsDucsCScRPh0RQIeF0as=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kgWSIFib0xt07gP4ouGqEqtBltuFVHnS68dZl43fYq942B6/Gv5Fw7AF0/pptA+8Oo53CQNbNx6Vv3+T8WkGaP3MAS104z2IZpvtbNT/G5AJvTQCD0TYyIDdmQOPSoyZ9rKF1NjXOuLn/ZoALXXrQ5uWj/UHe7fgVgeDdYoqF4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UAHaDdiv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jwMusHr6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6242eLDT3062169;
	Wed, 4 Mar 2026 02:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZQyOjtJGfJF3QqKRw4BamZxsDucsCScRPh0RQIeF0as=; b=
	UAHaDdivB9Bz3Javzz3pWLtTydJwFQGJAR3bB/9x3NuGwBZ7H+9qW7j8DV5oEe5O
	UiMA/lgNozQWdUlYGXaYqjK+/iU5TMtM9IeoTAoAVhRRUb1ivpQjvG3Lb+ijlxT6
	n/X1Y+QANk+gZljyREAcG2i0aBfXJKPZIXXMxbWaW8BzDMBwAK48mvy5RnAZL6KI
	zb0ucKrvv3vZAhQmEseDreh7HfBPeEO2qXG1xNlL9k1Q1xrONy+HLO6S54CopZM+
	Pc3mG5XGzFs2/RklzGjfBVWJjWHdb4ZrE2vEL9iKE9B4Lg6tieeH3Kpuo7D87r3h
	spH+gyxppghdI67Z1VrrWQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cpc5mr05g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 02:50:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6241Bj5A001629;
	Wed, 4 Mar 2026 02:50:37 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptffn1a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 02:50:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUMO0GyxFLvXaxJ0jbo1ykM4ezqf7rKyV6na8qTz769UmUWdkJCknOZDIjydqHc13C9u8PO+QwdYniKECmrT2+hpoDZN4HESjs44tiJJIdd5enKI8m4b/PZvKJQdffwn1oy2a0fpHPcIpk737HWDUCrRpCKIby2ZVWQw/52sqTpYOIm8J5ZIO+IlhUWvqozJZOe+3Dq4pKaFl4kHqwUTQeU5t3IA0mQi2Jjx9+2TCdGtU1f0wTM7MMOo9s8BpJKFKFsf3TAKrQOjFcsQQsyW1UjwVGkUq5VYs3EAd9/TOt3NA9GkVHzUvirkECNYFx5LUayyFVdRdGolWsD7k0TMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQyOjtJGfJF3QqKRw4BamZxsDucsCScRPh0RQIeF0as=;
 b=xmCG4HzYmZ200ZeHdoALUQTDNdp1ISZvL/3i6wuRy6bkmq+YznaOq/AZZTDbj9B3HZymQdSmp9luydSawLjB2zVJGHjVsg+WMGvaT1Q6jEAGzfmpFqWnSDHKL90xk06Gz86qXmyEHYdnUL9vZKZ6Cjkq5Nns2KaS6+PO1ONjX8jmslpxlFYgAPNCy8kYFXbqNWgU+rs/DJdaNulvvt9swOnw058PlPBeFL4GRRfOHcjbobZHOHX0kizjfVcavHlGBln7209wIJ6ASdwXD34JAKgsSbQ5/MBUpI0dezNfBF3tLfKnMyL7RJ6neuyaqdGwlB/kTPwhgPgklW9g0/D16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQyOjtJGfJF3QqKRw4BamZxsDucsCScRPh0RQIeF0as=;
 b=jwMusHr6VbI8v1oX9w8pZ1z52vWpq2JMvtDq3R8xjaCjJDeTZrMSTgC2pNnTQxv5D/+S88bTLAl0PYBpw+O5ErRlvP5DkR8iJrYWc3WQFD5TZAT+r6UPmO/pCmNgw6l61U7h8RCXBN/jxYX+alLYiZU4Ozmy58Qs7J0yFuxVosw=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 MN2PR10MB4318.namprd10.prod.outlook.com (2603:10b6:208:1d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 02:50:35 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 02:50:35 +0000
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
Subject: Re: [PATCH net-next v1 0/2] selftests: rds: refactor and expand rds
 selftests test
Thread-Topic: [PATCH net-next v1 0/2] selftests: rds: refactor and expand rds
 selftests test
Thread-Index: AQHcqgkqJFrpuvIOsk+fHUE6JV74GrWcB0cAgAGn/YA=
Date: Wed, 4 Mar 2026 02:50:34 +0000
Message-ID: <18aa553886ee12855c28d9498b12d2fdaeee9b3c.camel@oracle.com>
References: <20260302055518.301620-1-achender@kernel.org>
	 <20260302173302.4d1634be@kernel.org>
In-Reply-To: <20260302173302.4d1634be@kernel.org>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|MN2PR10MB4318:EE_
x-ms-office365-filtering-correlation-id: 04434f1d-58eb-4bae-20e1-08de7998cf34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 lPM6or3HuVzYLoW3Hs3/6T24EQ1SlHDg0Y/KYNhgn8UGLvrbMgX7W7YNQ/E57wO4FlP5OsYlfVCmQe63U4DHipRT/8DcsI0BWTiUHGrJAvSCz6GUafNYL+gaQHmj0kuUvlK+FCBjNOHjJCls3NQPjt2tZIR+OLk36vMmG8ik4Tt3KkyzwVw3dnCKpucQgk3ZoZpIQiS+TCF3kex2qGbWDXDQQJs1n4HJd219swEfPVdVCAQYcJevViZZpzUji6r5D6ZnKdip1iys3i4vwf8CfuyJgdOo3P7gkA9b7STLScVzBH/vgHvz3UE1R+NBBfVxEiODbnu7ocRD86Vn9eUyayRVZ5dwjjVBP0L5XA0SfMiKiKY049/P2Sj+2KkHn2WGkX6tuXpM6eEhNSAZk0zRwUUFNYQ1LfpUQCiOaN81NApZ1MTCbeZNqDf7r6OFb6lGrXn/4n/eJapltF+uQdQSvALMmqnevpc27d3NWqkBoYH79UY9/9aaX7l9OONapfu2xXdSMvZTlULZb1fZr0zFS52YaAcqe86lbk+QYXot7cTsLoDDkC0UaA8oRuT9SF182EeBRlzr6ap88sSJjSs4dLKM0kUZm8FXTbh+sUypANAUx5F4ZlE5sMfPv06ETFBqaG8DVD7sgcgMWeuXvsa1G3Y5JdrziLr5rZPs3uXXCx+zL0ZkU9qGnMb0U20kHPBfXLmBM3bfGWRSnPZX4yVDDiQet1vxO1iNqc7nKaAfeImENdNtFAH9QCgJQnIJNpctAa+1AZZ3kwnUGdp3WNYNx8/76oUE62zdgMc4muUcMCY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWZ0anBSeU5rOWpxMUFNMVluZzJlNDMrZ1ZYbUsrNmMvTUk0bFBCYmRCNjdE?=
 =?utf-8?B?b3d6ZHdTS1NHOGgyaHQ3cG5wUGJyVHVNZDNUUy9pek5JQVhUdXRTWk5VdTkx?=
 =?utf-8?B?Q2Y5bnU0bkpaOFpueDVZRlhEdFAwNVVvaVRkekZyYVJjZllYejQxczRjc0Y1?=
 =?utf-8?B?VllrNlYydTRJMVJyREphL29jcE5zdDJsdW9TYzRVYzZFRStzc2NFWTVYeG9T?=
 =?utf-8?B?eHkwQzJPK0djRmRJRmxCNnVQUnY0ZlRYVDEraGpOTGhnY2Z2N3RVNHErY0Fj?=
 =?utf-8?B?enRhUTZyd1BxbW5zWU9pOE1JNWpXYVFCMlp0M3VaZUxnK2w2dzFoalg4bmxK?=
 =?utf-8?B?QW5BKzlmVWVUZGUrVVhwMVlBbUJzY2F6dTlwRjcyb3VZTW93Ri84c0haWDI3?=
 =?utf-8?B?QjZFOUhka3FkelRmdEd2bXpQK2RFZWwxTkNnMzBLcGhSbW5HNmsrblZoV2Yv?=
 =?utf-8?B?S2JITWFPMXpxaVlLeU1JKy9FclM4YzNIMEVtY1lYL1dOM2JzYVV3Tk1pRVRP?=
 =?utf-8?B?REVSNzV2VXQxL1ZUbFVpQll0ZkJIa2RDMlcveXRJcFAyZmtTYWMrVHhVN3ov?=
 =?utf-8?B?V2VqUStoTEZpaVdvVXBxaW1JTWtEbnJaUU95WGZlRFM0Z2ZyNVB1UXZDNGZE?=
 =?utf-8?B?bW9ZdXVBc3I3SzY2dXl5Mk5xc05XZE1jUGw1amJqZkpRbDEveURCWU50a3d4?=
 =?utf-8?B?M1JNVC9UYVUrbmFIT2JNT1JETFB0a0JTaEl0YklvckxFSE5DaUovTlVtZzZD?=
 =?utf-8?B?T0VTWFZzaStza3NEUTI5RzJ6ajFzY1N1NlZlS2tqbjJ5dThrV2krbnZXdk8z?=
 =?utf-8?B?RTVUeW12VzkyWVY2Zy9JU0NUQzlVd1pnb1F6cEJaMmc4aHp5U3pNRHhzbzBt?=
 =?utf-8?B?enNONUJKU1NsQ2J3NGYwWERnaE83UjVaWmFLelpnWm9GZlhObUxiTkZtcXlT?=
 =?utf-8?B?MjFZMmhJWTZYMVFldGpYcjJ6T1cxK2I0RTgrK1dpUmxXU3htcHNpcDlROGt5?=
 =?utf-8?B?c0J1cllqYkFZUHljK00wYzBEZ0x6MTRZQnNPNDZwMW5RejNCTDdHWmU0MDNj?=
 =?utf-8?B?d0VSaXZkMjBFczh3dlYrMU1Dd2dyU1N3bEZKc2JKcXFhbWExaEpyMHlTQVll?=
 =?utf-8?B?Lzl0aU9mVEF4NUtYMWFxeG01VWpBZUVOL3BrZ0tWNWpyMnpiVlc5TmppSVhN?=
 =?utf-8?B?RlR0eUxZdWF5RGltcG5tM3dWTFAwUHRaUm5XZWt6bEw1SU5zM0pRby92aCtq?=
 =?utf-8?B?V2dvcy9HNXIremw4MUpKV25FV2FmQmxldlpOeXFaK0E0SUxWR3ExbVc2TE1W?=
 =?utf-8?B?MTZBb3JTUzNTRER1K21mTEo4aWNJclpJa3dNdkIxZWhJQmRoazNXbU02SGxN?=
 =?utf-8?B?WWhncHByZXkzMTE4dDkyQUFTeEthTEVtZ0ViYVN0ekllMkpJWmYxaWtZZ0Zq?=
 =?utf-8?B?eUVqeXJmMnFNM0NnKzYzS2o3d2NnSlBuNERzdGJ0WXl1bFE0VzdFUHpibUdJ?=
 =?utf-8?B?b0RsNnZjWkJETHQ5RXRvdFJReFlIZnNKeEZvNURnVEFmR0JZYi9FVWsrdVZ0?=
 =?utf-8?B?WGtUWU1Fa0I1ditzY0ZFdEp5SForWjRuWVBIbTUvT0RTbmpXeklzSUNneURU?=
 =?utf-8?B?WVMvOXBWTFdWa3ZDWlBORml2Q0s1bEJSRDNSYU8rajU2U0ViWHZmcWk0VEZ4?=
 =?utf-8?B?YlpXVm9TekpDNlJpcFVuSHdOVDZkNkZUQkExTktndXlyQVRmOE1iWXkyNjJJ?=
 =?utf-8?B?MmdqL25TUEVVb2NneENjSWVocHJLOVFVd3h3eVliQ2plR0piT2ZOMVd5WDI2?=
 =?utf-8?B?ZzMxaXA1bFlFV1czRFQxSENRSXRFMlIyaEdWTGhTd3JWM1JBRDNOcHkrRzhy?=
 =?utf-8?B?T0lhcTUrdFg3aVJYdzFLSnd2dHA2amxXWVI0MTc4aFpVVUU4Y0V1dVVWL0du?=
 =?utf-8?B?MDhrcFM4TE5UNUxWSzNnU1A0cFhjNVZFa1NRS2tXTnl3QUNWM1JCcHRRWmd3?=
 =?utf-8?B?WUxPaTg2RzJhaTBMUXZhSkdTLy9ERmtDaUNjbTZxWXdjc05IcG5IdTdaRFVH?=
 =?utf-8?B?OTRDL3N3VDk4bE1qdDA5ekh0ejNlWmsrVXIxZUdMeUkwUGo1R0tISGlySzVw?=
 =?utf-8?B?VVhtU01CcklWUDRhVHl0TWlRWDZpeTlkcDU3YVJPa1dwWmIyUG9QU3Z1Vk1q?=
 =?utf-8?B?MnZsSTlZYkgxMVBuUWRIRmtkdXl6YmJwNWxBMFA5UUJzaUxyMXRHb3NFQlZz?=
 =?utf-8?B?MVFzdHY1YVJBZGs0Z3cvaFVqREp0ZEt3UVpCQytjdG9vN0tTU0NsOUVqZmU5?=
 =?utf-8?B?NnhsVElIKzNUZjVHK2J0cmMyV2JCamo3Y3lVM2o5dENnVjJBNm56elY0SlZ4?=
 =?utf-8?Q?rIuyIQCgL9A0LFkc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86ECB151E95CF0448A0A0EE0FA7AEF1D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bGlRMmYutioQeMHwdXFczI6jEZqNjDjPmSTG5t/uT3NbWRuHQz9LRMKYLwC44oplcRf/EC0X50oJcecIowvfAxhYw9cxGoeBcE6wpWnW4ibA3dI9ZTuXzr5JZeyEgXYq7CWIZtLrFlMvbFwKVMLZLwzEnokUh5toc55EShi9FRv+SCaixyu3ga9PdHlZGBJ2iyoyStqtNV66N2sJadl4tvHUkgimJdaGrOQwIV4/q8oZCNM0uvqs3jNbHLkNLFxRUYeRpuX7VgFV8jHmNclxfuppnBtOm55FNRkYy/Po830y7/xfu2LfLKsQKWRJoCHBBJuzd+97UDlIGBVgS7A+TjVg6ewsmdCkopYTZCIzO8jrk3xjguYXlbYrRPgYV2SUkt8gf5TRMsPpCUjOssUBz0J4+xzmkPPzHFdpuRNg+6Ol+IoPEYoSeyRGlb8PFgEyPWJ28rPqeqOK+9jOKGWP5oHVLDX893G77N7msWazge2d9cgRliOgVpNt5BKfG2DSj95MHhZLwDsApm8QbIx24+YQcbgf1nbv7IGsvn8V0E0hlWkgPhHgNZ+ze7C+w7qUXSHms7jxgdJ1Fn7QYlKgenm1nbcIbWrvpl/mn3dMWaA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04434f1d-58eb-4bae-20e1-08de7998cf34
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 02:50:35.1435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKF8XEcatMxde8jZIuzYjHeKvYJoZjiXY9A5QPTuHHL2W05mceAQNizzZawhKrRslm+WK+/e1XvzZy9AlCP/Pf7b+1qSalTr0c3GdJa3aEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=853 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603040023
X-Authority-Analysis: v=2.4 cv=LdkxKzfi c=1 sm=1 tr=0 ts=69a79dfe b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22
 a=fJ7VkCwFWcPrM31MVlcA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13812
X-Proofpoint-ORIG-GUID: Crfoe-c4q2LwkP89aNmwlJ-NV0fXJjEv
X-Proofpoint-GUID: Crfoe-c4q2LwkP89aNmwlJ-NV0fXJjEv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAyMyBTYWx0ZWRfXz5tfr+0n9nhw
 SJXZJ+p9RYxKXS3mnP3jJPpPJND4+bZWBWJZcuZAgeq7Dxe6k33a+xZQ5GxYo5s2aVHGJl878fi
 Y6cOzgLMnujaCrHtbI8GorDUyzQLE4LEXduZaAhvO4/rxjMj6R3mTlIouCQ9Y9VYIRrYI5kS4gs
 M3SGheQdemcLC7iBg2Sou6fiBGcHunwfTIkDpGnz/pWVP4RAYwak33DTBP22QCuAYuFIJNW7G3u
 Ffk1vSWV1UDwbQNZUyknjuzbtB0dJWBEwEyvgJX14yfYrNnM7TIMv5+/3bEDQ8jgXdOJoTwaHYP
 J8bk7pw2axtUswVqLOey1daF19cOMMWO8w5zibppmrA3fbZlI3y60DHqrXXdMBZbdoU1PhVLYny
 RQ5kpikW1LuZe2JKaiczFzGY9GlTEAHf8Tt9U0ZfqkiAX4OS3MzZWOKgqlTSYdGyuK+VPMv0rZN
 vWvOzCGWGGNK66Dv9l49F/w5bsMZIEh/uD9xuucQ=
X-Rspamd-Queue-Id: 566FC1FA181
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[rds_basic.py:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.onmicrosoft.com:dkim,oracle.com:dkim,oracle.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17453-lists,linux-rdma=lfdr.de];
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

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDE3OjMzIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gU3VuLCAgMSBNYXIgMjAyNiAyMjo1NToxNiAtMDcwMCBBbGxpc29uIEhlbmRlcnNvbiB3
cm90ZToNCj4gPiBUaGlzIHNlcmllcyBhaW1zIHRvIGltcHJvdmUgdGhlIGN1cnJlbnQgcmRzIHNl
bGZ0ZXN0cy4gIFRoZSBmaXJzdCBwYXRjaA0KPiA+IHJlZmFjdG9ycyB0aGUgZXhpc3RpbmcgdGVz
dC5weSBzdWNoIHRoYXQgdGhlIG5ldHdvcmtpbmcgc2V0IHVwIGNhbiBiZQ0KPiA+IHJldXNlZCBh
cyBnZW5lcmFsIHB1cnBvc2UgaW5mcmFzdHJ1Y3R1cmUgZm9yIG90aGVyIHRlc3RzLiAgVGhlIGV4
aXN0aW5nDQo+ID4gc2VuZCBhbmQgcmVjZWl2ZSBjb2RlIGlzIGhvaXN0ZWQgaW50byBhIHNlcGFy
YXRlIHJkc19iYXNpYy5weS4gIFRoZSBuZXh0DQo+ID4gcGF0Y2ggYWRkcyBhIG5ldyByZHNfc3Ry
ZXNzLnB5IHRoYXQgZXhlcmNpc2VzIFJEUyB2aWEgdGhlIGV4dGVybmFsDQo+ID4gcmRzLXN0cmVz
cyB0b29sIGZyb20gdGhlIHJkcy10b29scyBwYWNrYWdlIGlmIGl0IGlzIGF2YWlsYWJsZSBvbiB0
aGUgaG9zdC4NCj4gPiBXZSBhZGQgdHdvIG5ldyBmbGFncyB0byB0ZXN0LnB5LCAtYiBhbmQgLXMg
dG8gc2VsZWN0IHJkc19iYXNpYyBvcg0KPiA+IHJkc19zdHJlc3MgcmVzcGVjdGl2ZWx5LiAgVGhl
IGludGVudCBpcyB0byBtYWtlIHRoZSBSRFMgc2VsZnRlc3RzIG1vcmUNCj4gPiBtb2R1bGFyIGFu
ZCBleHRlbnNpYmxlLiAgTGV0IG1lIGtub3cgd2hhdCB5b3UgYWxsIHRoaW5rLg0KPiA+IA0KPiA+
IFF1ZXN0aW9ucywgY29tbWVudHMsIHN1Z2dlc3Rpb25zIGFwcHJlY2lhdGVkIQ0KPiANCj4gSURL
IEFsbGlzb24uIEkgdHJpZWQgdG8gaW50ZWdyYXRlIHRoZSByZW1haW5pbmcgdGVzdHMgd2l0aCBO
ZXRkZXYgQ0kNCj4gdGhpcyB3ZWVrZW5kLiBUaGUgdHdvIGdyb3VwcyBvZiBuZXR3b3JraW5nIHRl
c3RzIHdoaWNoIGNhbid0IGJlIHJ1bg0KPiBsaWtlIGFsbCB0aGUgb3RoZXIgc2VsZnRlc3RzIGFy
ZSB2c29jayBhbmQgUkRTLiBJIGdldCB2c29jayBiZWluZw0KPiBkaWZmZXJlbnQuIHZzb2NrIGlz
IHVzZWQgdG8gY29tbXVuaWNhdGUgYmV0d2VlbiBWTXMgYW5kIGhvc3QsIHNldHRpbmcNCj4gdXAg
dGhlIHZtcyB3aXRoIHRoZSBsb2NhbGx5IGJ1aWx0IGtlcm5lbCBtYWtlcyBpdCBkaWZmZXJlbnQu
DQo+IA0KPiBCdXQgSSdtIG5vdCBleGFjdGx5IHN1cmUgd2hhdCBtYWtlcyBSRFMgZGlmZmVyZW50
LiBXb3VsZCB5b3UgbWluZA0KPiBleHBsYWluaW5nIHRoZSBjaGFsbGVuZ2VzIHdpdGggZml0dGlu
ZyBSRFMgaW50byB0aGUga3NmdCBmcmFtZXdvcms/DQoNCkhpIEpha3ViLA0KDQpJIGRpZG50IGtu
b3cgaXQgd2FzIGNhdXNpbmcgeW91IGdyaWVmLCBidXQgSSBhbSBoYXBweSB0byB3b3JrIHdpdGgg
eW91IHRvIGFkYXB0IGl0LiAgUkRTIGlzIGEgbGl0dGxlIHVuaXF1ZSBpbiB0aGF0IHRoZQ0KbmV0
d29yayB0b3BvbG9neSBkZWZpbmVzIHRoZSB1bmRlcmx5aW5nIHRyYW5zcG9ydCBpdCB1c2VzLiAg
SWYgeW91IHdlcmUgdG8gcnVuIGl0IHdpdGgganVzdCBhIHBhaXIgb2YgdmV0aCBpbnRlcmZhY2Vz
IG9uDQphIHNpbmdsZSBob3N0IG9yIHZtLCB0aGVuIHlvdSB3aWxsIG9ubHkgYmUgdXNpbmcgdGhl
IGxvb3AgYmFjayB0cmFuc3BvcnQgaW4gcmRzLmtvLiAgSW4gb3JkZXIgdG8gZ2V0IGl0IHRvIGxv
YWQgYW5kIHRlc3QNCnJkc190Y3Aua28sIHdlIG5lZWQgdGhlIGVuZHBvaW50cyB0byBiZSBpbiBz
ZXBhcmF0ZSBuZXR3b3JrIG5hbWVzcGFjZXMgc28gdGhhdCB0aGUgZGVzdGluYXRpb24gSVAgaXNu
J3Qgc2VlbiBhcyBsb2NhbC4gDQpTbyB0aGUgdGVzdCBjYXNlIGRvZXMgdGhpcyBieSBmb3JraW5n
IHNlcnZlci9jbGllbnQgcHJvY2Vzc2VzIGFjcm9zcyBuYW1lIHNwYWNlcy4gIFRoZXJlIHJlYWxs
eSBpc250IGEgcnVzaCBvbiB0aGlzDQpzZXJpZXMsIHNvIGlmIHlvdSB0aGluayB3ZSBzaG91bGQg
ZG8gc29tZSByZWZhY3RvcmluZy9jbGVhbnVwIGZvciBrc2Z0IGZpcnN0IHRoYXQgaXMgZmluZS4g
IExldCBtZSBrbm93IHlvdXIgdGhvdWdodHMuDQoNClRoYW5rcywNCkFsbGlzb24NCg0K

