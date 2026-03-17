Return-Path: <linux-rdma+bounces-18273-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAH0MuCcuWmyLAIAu9opvQ
	(envelope-from <linux-rdma+bounces-18273-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 19:26:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5362B0EBF
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 19:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4510C3045923
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 18:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70D3EC2FD;
	Tue, 17 Mar 2026 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k/9y9ECq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kdx1GxIj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A863AB273;
	Tue, 17 Mar 2026 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773771987; cv=fail; b=la53LFhj+YsIx48+oW27kF/c80XdRy/ivuYIGLupOMp++dQgIuuhwPerixJz8wfaD95EzQ7PMcRXKwhGNc6B3UgbAF2AFko3DalcDWmcEZEjnixBRVrPDYPb+UO+lfkiY6APwKZVRU7MOnDPHMv7iOs9LI4kpL5MrZEVXeEIx/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773771987; c=relaxed/simple;
	bh=rUSHFiw3VxESGF3nOhMjJUqEcr2tg4kdW65UVWdRp3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ffRHRHrFseMk/IhdKj7PPP7Rhpq1CorD7QN+dfZClcKHh377sowCAYZaDaLb2yL2JzWh2LG030+TcfUrflVZ0HvW9xw6onKp90gpAsCHApxbipOseo4CpDJWg/3Q3bDs2sacX/n9KaMz7Xs0lXYNYN0AeqgaZjUB2QD7frGQi5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k/9y9ECq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kdx1GxIj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HElXEv1338917;
	Tue, 17 Mar 2026 18:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rUSHFiw3VxESGF3nOhMjJUqEcr2tg4kdW65UVWdRp3o=; b=
	k/9y9ECqc454SJV+JqP6QMVVeXPQoL+weA0X09WkSB/E/czJsv0i+ggCcHhTuuSn
	OFigfMyuMevrrATTrOl5nMXYvLBeycYOw5Vvmub10o4/HxDzxrmZ5wwdGHGF70rI
	6Qaz43BYzMrMbra7ktoPtS6AMq2+q+PN1T2PgA3typhcVGGbBi8O7CCnpVgpvtN/
	PTgkznQLj36K7PxCZDKMsnnn5Y+d4MlSv4mQNNB/vui+Tx4zktSxKuYH3OGe4d3R
	Iz2tMdOI4BBRS4/A3OMibxSV0cT1bJcyvU+K5ZQcvL8zgz6ENiGG7AGL2HLWd+mU
	6XzED6/tEs8bDSaIRr+FIA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx3b4pas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 18:26:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62HHdxd6014153;
	Tue, 17 Mar 2026 18:26:14 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4ah08d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 18:26:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eS37sP8wOHoVmhIEwDlu/F7B3pWJ5TcTHZXa0vWTkYJZe9hA+ud6etrJmFxeA0QkdZYdOQYS/FpqDWTJFeTSDbqf0+xKi70e3NP8b35nO3Vwnx58C0+B9hSErqTLYQbm5d5ITfEBr/suAdso7aQbrb0hAKhWVz4STFb4WtWtQVo9c7QFZTNBoU70xaBR6mgmeZDlsDP0ZoybJOklTsbQY7z7nLW7v/V5Guueqm56ogwgLqied+0zxIGaF8jamTKoE8coonRtcdnBiYTzBW1q72WnES0UOuL7+l946v9CTWSaH0eaVk6NT4FGp7zGQ6IKjtuptxyQr+2Lm3vHdynW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUSHFiw3VxESGF3nOhMjJUqEcr2tg4kdW65UVWdRp3o=;
 b=NI1GUm+KVoNiz1zo5LpPJX2gIwtN+740AZR0OFUSl92wpmLLdwnCGz8U0bTJ4sJfShwNM8VNlL8kv2ulrU9bBWecbivLUOncRppeJ44YwFfNJjUwfSjnzPPGmk76XYM8OM7qyQ7svziYvNyuJYUMsr8NM9ncIQh0v8x8S+sMVGqwfioHTt+6+wwJw9gK6XyzajQ1RJ55UO9AZ2I9M/YQadDM5toK7XVTP0Pt32QcDu9iMUsy7SR4mvm0iqjDQRFLvKW0vGUEe5LSLBzoE4bjDL/0hnzjyWZo+zpEfuwze8RCIHaM/iNYMwCNZCWNyXbmJZRXPH7IKzXncc87kxG5qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUSHFiw3VxESGF3nOhMjJUqEcr2tg4kdW65UVWdRp3o=;
 b=Kdx1GxIjxaxYozlb8wjsb1Va5F/KsdS5sM3/pQlwp9F8xR51gG0IqzKoB4RIo6IU33rmWvfaC2ilZPiA9NDA7t7SVD7eb6nm0cTQ97umJeB6s4byi97xzx+uFizD+e9K449UusD9wFCrZUwXkEFnto9VPFiKEPXTYb1QUxjV5Xk=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 SN7PR10MB6306.namprd10.prod.outlook.com (2603:10b6:806:272::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 18:26:10 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 18:26:10 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "achender@kernel.org" <achender@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "shuah@kernel.org" <shuah@kernel.org>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v1] selftest: rds: add
 tools/testing/selftests/net/rds/config
Thread-Topic: [PATCH net-next v1] selftest: rds: add
 tools/testing/selftests/net/rds/config
Thread-Index: AQHctaDatbWm6B16hkWSTSCqoeIRzbWyzOmAgAA+0YA=
Date: Tue, 17 Mar 2026 18:26:10 +0000
Message-ID: <d33e764e33b5a4c6464a692371afc41d4a01c15d.camel@oracle.com>
References: <20260316235848.2395654-1-achender@kernel.org>
	 <728fc0aa-4c07-4092-91bb-6b9f76c2f3eb@redhat.com>
In-Reply-To: <728fc0aa-4c07-4092-91bb-6b9f76c2f3eb@redhat.com>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|SN7PR10MB6306:EE_
x-ms-office365-filtering-correlation-id: 94fa7543-16b5-4fa2-54a5-08de8452a9d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|38070700021|13003099007;
x-microsoft-antispam-message-info:
 8IJYWMkobJx2dSp2TbylgmsbYKzwl/iaN99+ksfIP9veUFl5zGlyJzh2TXun+2VSaJrCle2cJSpUZ44f2kd4uDygsRgEnIzMc4pKdxxWr7b3BrZl4Lg6kBTksnln97Wmc9Zk0V0dsNVGQOvHmedifu6qy56S8u0oMy/GJ2wP594YrGsFELy5wJ5Glc7MOT0kPfMp8SNk3hvgF4h+/tJBkMoFHzyIlzg7d2u3EpwL0bKDpmQtHorsKBPjB3VTuYcjuOn/7mdJFMja5GCMCAeuIWSplYnK3Tz3flHaZZrnvmRXo/UmhvupdKLnUBb/0jX3Lt43Tx2WqcLFEjgJzPeMTUDDJVEDpfe0J7PtxTNgPqa1r1x5pwW12QpIf38Mh/de4AXM7viO5P9RJjpciu3cBZI8bOo5/+sXZfSY/Kzn7yg+YmHIia60OTC46PJoeVi3uKLYaMR48bFMoDEKObSXM5RLKJ/HH4JyY9kRSwtsBjHaSBUIQPxEg3mveWPBFztZ5e7PTWVFtLS+F6Cb3w09jPk0oGaeW5atj/bX4UVO6H/UlUnsnDqWfKbTSqK452LlSDbAj6phieayJcYWrV1dlolAQEIgKy6H1bIBa1cbo+jfVa441jU5+hiPX/WhGKhZuDuJcE3B1v2QwQAh2LT6aMq45yPpBFnhKBK2UNVMhypQs80jYy5tkEmaW7KKtzeTwWf7gwapr2H2bcZQ5nPbQYGBSkbuBP3pR1b4eWw76CrKQ63vgqg+nblqpLavDBnNJAIURrYSXDQ/Whq/eYQiK6+amzRP4kLKR62o7UPHj+c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1lyd1UyaTViY1Rzdm5UQXRuN2FFaUttWElHeDhmQXNlR0NrUWhMblMzdEpu?=
 =?utf-8?B?ZGRwT2FmcDlMYU1KVUxsanN4N3dFNTZpcitzcHJhZmc0TndlSTlzajA4d0dM?=
 =?utf-8?B?N0RuWGN5NGFEK1g0Si9mRThiTE0wZ3cyMUNselRMU3hRcGlsdFJ0clI5bUdC?=
 =?utf-8?B?dkwvNXBBa3ZjZCtPNVZRa2tXdWxxNFIxVFlLYVUxSjNvSVl3WXA0NjVUL3Js?=
 =?utf-8?B?clRvbldxSTZLSUZLeURUREJVN3BYUmxQMUdGeUxlclkxRVV2OVE4K2t5ZVBD?=
 =?utf-8?B?VjRjOU80NTRvR0x2aGRGNnk5ZXBMbmVGOXdybWFGbUYvQTVrZmpPd1d6Q3Ft?=
 =?utf-8?B?aTBaTzBtZ3Q1M1NOZG1OMjBTcVZmV0hkN0JESDBTQVRCbk1FM01Oa2w0RmZV?=
 =?utf-8?B?V1J5N2NVcldjU2hpVzY1U0FkSkh6MXNHNE1uUzVaUi8xdUlxMFFvSlNxdCtr?=
 =?utf-8?B?K0RCazJKU0JUNmxoUUkvckxjcHlJa2RzeGJ5bEgvMVlRc3ovcDd1aFh2bERo?=
 =?utf-8?B?MlBUSUdaSE5oMVVCMDZzYWdFSFFrOXRLWi9GWUc5cEZXaVZNYkphczNEWnZa?=
 =?utf-8?B?V2w1QkY0SXhnLzcyQm93aHhYOXVFVEo4eVF3eDY2aEJHYU1wQXJIRFdSZkFN?=
 =?utf-8?B?SkVpU0JYQytjUDR3ek5mc3k1bGV2VjZVTU1xS1E0M0F0OXB3UTFMWFZRNlpP?=
 =?utf-8?B?QjVUWDJmWlNJcCthQnZ5eDVBREt2UitBRWU3clAwU1R3U0krZld6TlRFZ2pp?=
 =?utf-8?B?STFlYTlmU3NYdUk5TFpqSGh6a1ZSaFpsWHFuS0tXd1FmaVFpNU1UQkN0NEZk?=
 =?utf-8?B?RkpmR3BhZ1FhTjhLcmZlVjJhVHV1OXpsSmdZZFM5SGU1NndGQ09mQnQwZ01p?=
 =?utf-8?B?ancrZ29OLzBTRXJlS2ViQ3lQcjl3TkxSeDNWTS9rblU4SGNDejRjRVFucXNi?=
 =?utf-8?B?THhNVG9YOFVmb1g0cEpuRFpzZHBqQmd6NURFcUxYanlzcTgxeXJpWEsvblhP?=
 =?utf-8?B?dTF5VXpkclQ5cGUzSWpJeXNBWnJmMnl2VEwxaDRnc2ZiNE5sRjh3MmhhR0k2?=
 =?utf-8?B?a1E5QVRLY1VSREs5d0tkckFMbmVNdVV3Z3ZTeDcxR2lDV2JESmVBVWNEY3dT?=
 =?utf-8?B?czd2elVmeXkvS05WcmdlTTFOanNVWFJNSnZPR0htam5JeVZtNzVndjVNWmQ4?=
 =?utf-8?B?bndQa05BLy84OVpqUEtGTVNPTjdPUG1nN0JCcWZGSTM5RlZ3QzNRaGMvZ3Jj?=
 =?utf-8?B?bVlnNHVlTyswM0NYWmlFbTZXb29LNlJRc09vVEhJaWpNNXNUOTR3bGM1TkIy?=
 =?utf-8?B?amFYQXFCcnJMUGVpMmc4eGtjVFFQK0g1aUIvTEFQenU5QWNDNzVQR3U5Ykph?=
 =?utf-8?B?cEFsZEc2NDM1WlRXTXJtNHV4UDY5QzVFTFJUUVduQU1WS0VuQnY2SWZKT0dU?=
 =?utf-8?B?YjB2TXBpMXl4TTR6VG1za2l2NEZXbWhXOW01aHoyWjhva08wM0x6b05jT0lK?=
 =?utf-8?B?bExBUTNLZnpJM0ZlSjNYaDBjMzZLU2hSWHZHR2l2ODJUbW5zSjZkQ1FqZFpw?=
 =?utf-8?B?ckpUYjl2QkdRN29TMzBiaFpCODROQ0xvam5kODhIKzdjUGVuVnB0MnBlVUF5?=
 =?utf-8?B?Q0pSTTljNVlXeTBMY2lLU0J3d251YzlLenBDcXNsTGd0c29tNGpPbnBpSFJx?=
 =?utf-8?B?dWlCaTgxSjNFNmdETVd2TjZSM0djMWNsa3hJdFRjVE5QbS9NRExWZW9Ud052?=
 =?utf-8?B?OE1UenNzT250YnAwUEJzV2VWZFVEcGR1amVaWXZmdGNuTXV4NVhyVG9wSCtJ?=
 =?utf-8?B?MDh3aU1sLzMxcDJlTnZSYWxKQmxyeGdvSktZL0VrUW53REZnT3ZWOXZwWkJn?=
 =?utf-8?B?WDBpMWNESUNVSm9aNW9wMFY4b1lBT2s0OEpVQjJlTGhFK2JRNUpNSXRsZ2c0?=
 =?utf-8?B?SGNMYllEazY2dk9Zc09hRVBHSDdIS3d3dlZTcHpPMXpFN091S2wwSHdXZTdk?=
 =?utf-8?B?dGY1WXpFUE9EOWI5SmlwVHAreGpTMXJSL2FVTlNaeGtjYVRFSkNrNUw3M3lT?=
 =?utf-8?B?ZVM3LzJUNTFhT1lxdlJJNW5UczZVWkhlalViMS8xUWNvK1ZSS3N2RDdxeHlq?=
 =?utf-8?B?Q3VrcmRmWVR0NTU3MDNPNXlLMFhtSXUzTFBOdEZMK0pwdy9RazgvQWtnR3hy?=
 =?utf-8?B?WUVnOHkra0F0MVlPd2pJTThYWlR6UE11Ymd3TEJoRHRUc0Q2OE5YdktWL2JR?=
 =?utf-8?B?SGgvU1lXMnp5S3RkaVZiSWxnTUxaQWp3TTF2UlgzaEQ5NHFvV2FxaDJwMU9t?=
 =?utf-8?B?dUQ3UkJjNjVxRHFGZUU4MjNJclAzaUc1cEV2MVY3MGdXNTJ2TkRlRHd5NzJ2?=
 =?utf-8?Q?0aabNRIrQgjeQU1c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CD884CABD8FE14BAB18D14C508A95F6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	V/0Ic+8qQiiIvDpprlcBqKJNnw1x1/BTm+q8SJ0XDKyCfYZAPq//PjKkDf22/NVY2fglYGS6EbBQjE5bgftvu1JtVYt8d15Ob7mIT+807BE+8lDxJfqFnAL+OWhXPsm0i6fCc3brtTJOo0wvwlU6TtaB5dlNjmUl2t2Evq3DYQ6PvCx3uL5m0w94hVYJy8tRdeZPgHAVRQ7+ISTbcENPkbP/9vaMUBIavh8Hq0G44McUFyWWKg0LZrFFmQZLiGzUftRF1r4Faqeo/Wbof2XJ+mS/EQgO1ECyxlJs/Yl6uytJ7YKjYUkb/QCKu53+njNKkkGa822yoNkVnRju+tAr+w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XxZieDWDDIkihnH0ybc06dCJA48KnepUaVBCy8KUzyrnHS0pZo4rJYqRAK4lw1gsGZdYz6OS8t7Zm6Sn7tLOpVc/6Ad4REJnWtQ5T+v4kL0JBEur+LK4F237iUT1b7I4kFOx1xk3gDyJ/krbBJrekyNTfv7PVrMuDrlAl/MHDC7dJQwm4XzI4xkWq1FSRRycePZa4uLFr7hKA8koNDJl2EvT2PL6VTwO0WAK8ORP1SWOv8gHrq3upbzUqCBcDmc9i/Ckt02IWxcGLJNbBUrTx299VuZ8bbyTHybxv/VG/t15rwO6Vc4iIfWC1EmPZyvLrbYoaHy+udZQt+hH4MEVT/EHMBW93jkhJu5EG5jjHiiKSklBpaM002jwupAjIZo6twTtWlaFcu7FFcVJVW6MPkaFbh5jUmrmwu3QPk/00GA3VIa3cxYFskzebbkqXMoNc5392zRN6l3K84UQUrQkolrlDlKP3Clk4DICFC5AefPIGtGPdcQXJ335WW9MyBlMYrSqrjTZKCa1nJr/RnTaz88+TxCulv6h+k//w6JhRH8qMNV8t7WoUnqcRtOM+bwhXTbzwepbtBYcUPGoTmVS4WvH7Y2oYpXGQyBw0h10A/Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fa7543-16b5-4fa2-54a5-08de8452a9d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 18:26:10.4027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McstVSyP6FWfvU0G/O4lfm/cZ/mUBZzZXRl24g2HmmZ1QR6pK33Tm1AzMFy7MIvR1XMgATmNpUnwBOrKlZhKUhDCI0fgChvhEBUO/7+cPXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603170162
X-Proofpoint-GUID: NqoolW2PASUL0EtA879EYkhk-zx7SKZf
X-Proofpoint-ORIG-GUID: NqoolW2PASUL0EtA879EYkhk-zx7SKZf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE2MiBTYWx0ZWRfX1+JsSAoQnx0I
 KTsxj+RA+sHuPkxl843QQHiFAA/LWnzWYMEnEZu3/rH/7mOYeqYUNDdQISmmZK/653Q9z/svLbw
 BSeq/6LpknGP/t5baRiDBlMY7+13QDGm8hTSqoOytzcd5DDTApQ6EWl0b1Hd3OizOGCQdMNkzxD
 uf+zJDPDU2Q5uGHco1Db0DLA4W7ffbDBhPhUwp+3lylJmmFOr/uiMoW3dIpJ2ohS3m4RI2/KaPi
 3mAQYnmROqnEG5BJ9Gr4iulI3OUnLgpdoOVkJZwskx5ynPOP51tBp2QC3LGd1a2buNrb4/McARI
 KinrRuY/FFbmnrPRBhxBBKqKi5Jzd2vqxzKDcKHQhz4Bx/z7KaM3KgsqGhk9X1mcCTqCQefWj6B
 Xukr+WS0aaAF/rzbed9w2OaGru+PugVR6mc3Dt7KUjj/nFAQBfTO+nRBy3fVk3QL0xA2MvK3ijc
 k/+Bf6NUvVa32xWYnfA==
X-Authority-Analysis: v=2.4 cv=IN4PywvG c=1 sm=1 tr=0 ts=69b99cc7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22
 a=VwQbUJbxAAAA:8 a=xRGNbGiRs8QRxRDMub4A:9 a=QEXdDO2ut3YA:10
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18273-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 8D5362B0EBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTAzLTE3IGF0IDE1OjQxICswMTAwLCBQYW9sbyBBYmVuaSB3cm90ZToNCj4g
T24gMy8xNy8yNiAxMjo1OCBBTSwgQWxsaXNvbiBIZW5kZXJzb24gd3JvdGU6DQo+ID4gVGhpcyBw
YXRjaCBhZGRzIGFuIHJkcyBzZWxmdGVzdCBjb25maWcuICANCj4gDQo+IFdoeT8gd2hhdCBpbXBy
b3ZlbWVudCBwcm9kdWNlcyBvciB3aGF0IGlzc3VlcyBkb2VzIHRoYXQgYWRkcmVzcz8NCg0KV2Un
dmUgYmVlbiB0cnlpbmcgdG8gZ2V0IHRoZSByZHMgc2VsZnRlc3QgdG8gd29yayBpbiB0aGUga3Nm
dCBDSSBydW50aW1lIGFuZCBpdCBuZWVkcyBhIHBlci10YXJnZXQgY29uZmlnIGZpbGUgdG8gYnVp
bGQNCmEgbWluaW1hbCBrZXJuZWwgd2l0aCB0aGUgcmlnaHQgb3B0aW9ucyBlbmFibGVkICANClto
dHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNjAzMTUxNzU1MTcuM2M4Y2NhOTJAa2Vy
bmVsLm9yZy9dKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDI2MDMxNTE3NTUxNy4z
YzhjY2E5MkBrZXJuZWwub3JnLykNCg0KSSBub3RpY2VkIGEgZmV3IG90aGVyIHNlbGZ0ZXN0cyBh
cHBlYXIgdG8gaGF2ZSB0aGVpciBvd24gY29uZmlncyBhcyB3ZWxsLiAgSSBjYW4gYWRkIGEgcXVp
Y2sgc3VtbWFyeSBvZiB0aGUgbmV3IGNvbmZpZ3MNCmlmIHlvdSBsaWtlPw0KDQo+IA0KPiA+IGRp
ZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcmRzL2NvbmZpZyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvY29uZmlnDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjEwM2Y5ZDk0MWQxMA0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcmRzL2NvbmZpZw0KPiA+
IEBAIC0wLDAgKzEsNSBAQA0KPiA+ICtDT05GSUdfUkRTPXkNCj4gPiArQ09ORklHX1JEU19UQ1A9
eQ0KPiA+ICtDT05GSUdfTkVUX05TPXkNCj4gPiArQ09ORklHX1ZFVEg9eQ0KPiA+ICtDT05GSUdf
TkVUX1NDSF9ORVRFTT15DQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L25ldC9yZHMvY29uZmlnLnNoIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9jb25m
aWcuc2gNCj4gPiBpbmRleCA3OTFjOGRiZTEwOTUuLjdjZjU2ZWU4ODgyZiAxMDA3NTUNCj4gPiAt
LS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcmRzL2NvbmZpZy5zaA0KPiA+ICsrKyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvY29uZmlnLnNoDQo+ID4gQEAgLTI0LDcg
KzI0LDcgQEAgd2hpbGUgZ2V0b3B0cyAiZyIgb3B0OyBkbw0KPiA+ICAgIGVzYWMNCj4gPiAgZG9u
ZQ0KPiA+ICANCj4gPiAtQ09ORl9GSUxFPSJ0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvY29u
ZmlnIg0KPiA+ICtDT05GX0ZJTEU9InRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvY29u
ZmlnIg0KPiA+ICANCj4gPiAgIyBubyBtb2R1bGVzDQo+ID4gIHNjcmlwdHMvY29uZmlnIC0tZmls
ZSAiJENPTkZfRklMRSIgLS1kaXNhYmxlIENPTkZJR19NT0RVTEVTDQo+IA0KPiBUaGlzIGxvb2tz
IHdyb25nPyE/IFRoZSBzY3JpcHQgaXMgZ29pbmcgdG8gdXBkYXRlIHRoZSBjb25maWcgZmlsZSB3
aGljaA0KPiBpcyB1bmRlciBnaXQgY29udHJvbC4gWW91IHByb2JhYmx5IHdhbnQgdG8gY29weSB0
aGUgZGVmYXVsdCBjb25maWcgaW4gYQ0KPiB0bXAgZmlsZSBmaWxlLCBlZGl0IHRoZSBsYXR0ZXIg
YW5kIGFkZCBpdCB0byAuZ2l0aWdub3JlIGFuZCBFWFRSQV9DTEVBTi4NCj4gDQo+IFRoZSBpc3N1
ZSBsb29rcyBwcmUtZXhpc3RlbnQsIGJ1dCBzaW5jZSB5b3UgYXJlIHRvdWNoaW5nIHRoaXMgcGFy
dC4uLg0KPiANCj4gL1ANCj4gDQo+IA0KU3VyZSwgc28gY29uZmlnLnNoIGlzbnQgYWN0dWFsbHkg
Y2FsbGVkIGJ5IGFueXRoaW5nIHdpdGhpbiB0aGUgc2VsZiB0ZXN0cyBvciB0ZXN0aW5nIGhhcm5l
c3MuICBJdCBtb3JlIGludGVuZGVkIHRvIGJlIGENCnN0YW5kIGFsb25lIHRvb2wgZm9yIHdoZW4g
ZGV2ZWxvcGVycyB3YW50IHRvIGVuYWJsZS9kaXNhYmxlIGdjb3YuICBJZiB5b3UgbGlrZSB3ZSBj
YW4gYWRqdXN0IHRoZSB0YXJnZXQgdG8gYQ0KcmRzL2NvbmZpZy5sb2NhbCBhbmQgY29weSByZHMv
Y29uZmlnIHRoZXJlLiAgDQoNCkNPTkZfRklMRT0idG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0
L3Jkcy9jb25maWcubG9jYWwiICANCmNwIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMv
Y29uZmlnICIkQ09ORl9GSUxFIg0KDQpBbHRlcm5hdGVseSB3ZSBjb3VsZCBzaW1wbHkgaGF2ZSB0
aGUgc2NyaXB0IGRlZmF1bHQgdG8gY29uZmlnLmxvY2FsLCBhbmQgYWRkIGEgcGFyYW1ldGVyIHRo
YXQgYWxsb3dzIHRoZSBjYWxsZXIgdG8NCnNwZWNpZnkgdGhlIGNvbmZpZyBwYXRoLiAgTGV0IG1l
IGtub3cgd2hhdCB5b3UgcHJlZmVyLg0KDQpJIG1heSBzcGxpdCBvZmYgdGhlIGNvbmZpZy5zaCBj
aGFuZ2VzIGludG8gYSBzZXBhcmF0ZSBwYXRjaCBzbyB0aGF0IEpha3ViIGNhbiBzdGFydCB1c2lu
ZyB0aGUgY29uZmlnIHRob3VnaC4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3cyEgIA0KQWxsaXNv
bg0KDQoNCg==

