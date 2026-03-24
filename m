Return-Path: <linux-rdma+bounces-18557-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DMALXgxwmk+aAQAu9opvQ
	(envelope-from <linux-rdma+bounces-18557-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 07:38:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1184D303341
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 07:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EB423166C35
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 06:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F883B777F;
	Tue, 24 Mar 2026 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B+ZuFIXd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nnw7604U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908643B7753;
	Tue, 24 Mar 2026 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333763; cv=fail; b=FPOPa0Fw3W35LsnSwvV1La3Fz/A8XJ1suu0bULiwOfID23JI+0vIwsheA1zmQ266Rmlyy5jxc2om8vJlXUn41Ebwzr2BXVWnSDaLcA1pnwXgZPgGMPgJJDBVaHrvS/EHmbAt4hXIKnnssUIRSeK8AddP7kLvK/h9Ni8o23PLiPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333763; c=relaxed/simple;
	bh=FvG9u0Dk6z9wWRViQuf1kh1IjA4ipCY/gYTS4hhEeBI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jg7CM1+qHkbZAjV+OG9Hbb3zvbYy7021v4t9OdjXoBTVlonHW9f7vkcAO/FuyOb2wR7gv9gCcMbTGouy/QrD4uen1en3FwhP6NO3TI5jI6bLl/ZL5TgFayYE3pLnInJ9AcS6jIbamkflyaOyIZ6ODeevpjVbXC3xG0RD8TbNDFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B+ZuFIXd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nnw7604U; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NKucvl029236;
	Tue, 24 Mar 2026 06:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FvG9u0Dk6z9wWRViQuf1kh1IjA4ipCY/gYTS4hhEeBI=; b=
	B+ZuFIXdYtDvgxwB0l4n9X4yOsFGXtfroYbfJrhfKBVk4uQEhsGNcfP8ICVlAQxM
	veqSQT+lUhb8JLwSQAdczja9sXFrg3VyPB1qGQhXICt4eUxCsjHcjysi/YQugThl
	dqqa85iD0zC0+kThzQPg53KVt3D6UPa/iuQiUJmiwB1gMr8r1FFxVgmDvhcOrnV9
	GG8Q2SuJR4mtNSn3K2VYH7s6tOK6cLSpbdyj4V7RPX+X6n/2743E9sQjwkoFdLpu
	cI7Yx6J7Ixx6v5TgqSm62/CYd2TXL6kmbxw/VqxD3Db0U0qfaVP1HqfwbEvIubX0
	BmObgO+Pd7uuoBL6yP/m9Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kja3mya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 06:29:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62O5cM3h022271;
	Tue, 24 Mar 2026 06:29:15 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d26xp3qst-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 06:29:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfov40jDcNvDJ4lElutqJv3iHWWi9YzPI/6NnLMvRRtP7NNEiZU6K1aRXyu0hLTaXthoUu//Cz9CUjj4JblKQ/Y09amvkzSiZwGuFhrgRXmtVaBs4ryKua+RdPaI3twzs/JvCOIgJhyjcsFPKVe32oOsSXh5+MMY+YjyRk66phcN+ENbyy2R5Pn5ckZSLQJcuQcyYThNhGws69lK9Ibp8kivQcf2+kWTyxIx1tP0aywzQSejGKPLkkraMOq6mHafsi191M9Zz/Yx7SuUg0+yVPzTYxMSJL0gZ917avusH/mzT4nCYklTO4EsyUP9UFgbw3KWVVWrQnlm4dZ8zBZggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvG9u0Dk6z9wWRViQuf1kh1IjA4ipCY/gYTS4hhEeBI=;
 b=Npna1+PN9b6Ex1u7YCvqC9KPi2k2GhKcX6HCNrEW0JmzK22GrW7vTrEEBA73N/N6AAs25GBe1jup/wVrVdxNY4ZVl2MKS/l+2mpTx+Y89bIYIV+keYCjXpFTkwmOmNt/gFweWZ6h4ez2LDnRyWd8knxODz+h8aNgTQZYhPBtuQxleiG4Df9gkL08ta73tuyNsXaO9qvTRPFdJSqDZYgKIcdbzZr67XPhL6uAhqkPpOcxTFLloB5ZCsMGjlOqeni/0iIyJ1ro+CFzjQMIXurUvK7/jEh6SL6e9W7ftCZt34/HDyBfo3jq/lNSxx3eoaVDuuMGSjzgt0+LAIQ9A8hCYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvG9u0Dk6z9wWRViQuf1kh1IjA4ipCY/gYTS4hhEeBI=;
 b=nnw7604Uklgwy7UsmWZsO362/WByfaBlaPxs/46KcFWEcSbY0zYZ9jSLCbZEUfz2+a0MqIURo8GsFd8Msle5coF+mSojuOW8aj8wU9nQwQ+95JtCvbbA7xHUADpH5lT/1orYqhCPLuB113+AlhPuc967AVi1v9p54oq2pQxQhzo=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 LV0PR10MB997614.namprd10.prod.outlook.com (2603:10b6:408:33d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 06:29:00 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 06:29:00 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>,
        "achender@kernel.org"
	<achender@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "shuah@kernel.org"
	<shuah@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] selftests: rds: add
 tools/testing/selftests/net/rds/config
Thread-Topic: [PATCH net-next v3 1/2] selftests: rds: add
 tools/testing/selftests/net/rds/config
Thread-Index: AQHcuCClxt02HCsUgEuztAtTUNxiWLW8/ukAgAA/0wA=
Date: Tue, 24 Mar 2026 06:29:00 +0000
Message-ID: <2a43d16bf6f79856fd9c0153141dd92b38ddfea8.camel@oracle.com>
References: <20260320041834.2761069-1-achender@kernel.org>
	 <20260320041834.2761069-2-achender@kernel.org>
	 <20260323194032.4127ac92@kernel.org>
In-Reply-To: <20260323194032.4127ac92@kernel.org>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|LV0PR10MB997614:EE_
x-ms-office365-filtering-correlation-id: 3d447653-ef89-40b3-aa7a-08de896ea2ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 jeLWG3zNbbFiX1H9UEnPMr2v22T/jso6xCenZTLaBSeRBNyBb3NmgGt9n+hRCTvNuqyVgb+9p1H08sWEntQFeLgawm7bXwpT9Nqon86IeJ8uH82Be9gudEW9PDJ7RDHXAoaAC8hSXtpq1Wh+Zsb1kY1W9wojEmPJCSGDk8QNReMnUr9PNDMVx3iDQs2XLy8XWjLR70Octxot/e81tASC95u4doPW8BB1NuksM0tj4fNyv/1zrz4MI+v76BJhjszT7kT3NeOZ7KBvy9//dgLb0RADNRF7xUbZx9OJv7EJRTPJAemLlagDJmehzgF2DVfd3Nm6qdmWCMY5eshgV6oOBnbnQ7mrDageaXVjUsVsJ/COaGF0EErVuTaVYP9PNfcFuIkO+CJtKYXJzeI0QkXeBPMDdt1kHc3sSEBaSEbDKIDj6L+iM/G3cifw8RiUPnAkh2+rIeg46ELWhIqwtJK/tA+VqgmRBwEujwQZV8CXgcKalw+ILGBwNvF2SfWxfxgyUPUxyeAkkZQwy8FdZc1ek4MFuhCzF4VP5bR5UnB/Ex/7doyrGcnAB57LbJNcnRjrqJp7d3cHMHRMICg6Wb4y6pQptEAIh/6mXOU4X9IyJbfxlg8FYRW0+XKD/hHxNYONfmYN2nKxeQTb3e5jCMbmI1l2HYxixRuQ2d9QS4nVrFijIiDwq/ilxLQSof140n/yBA5zuV6wyvzlsBzV7QRlr4cHLfmkqHHEZIGm01z8PjI0dVFTc7kFiN26SDU3YJ5pp0rVEp0pskBBDIbbsJH4WPrQkB2k3VN7sz5ovhQVgIE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnYyT1BOQ2UvYTRaQXArb1BEWTJ5Y1BVRyswMzlJRlI4V2kvdUt3aml2YXMr?=
 =?utf-8?B?cVNSY2FxZGE2c244VE1ObVNrZFloaGwrTkpkQXEyeDIxZnNEbm8wT2xDNXBS?=
 =?utf-8?B?eEM0dE5XUFhUMDh0c2xENnRSVjYyaTRXSDZEeU1JQjBHZHBxSjRaQ1ozVk5E?=
 =?utf-8?B?NWUydTJDMm0wV2VKV3ptbDNlQ3NlbzBOZy9pZmx2WklMWXJidVFYNlJqK2hx?=
 =?utf-8?B?OW03WkRpNDMrL0hKenJ2OGdSZUdISGQ1aE1ZNWRIbmV0RHVzWHRzS3hRV1lU?=
 =?utf-8?B?SDk3UWNaaWpzaUJiaDFKbE1Sb2tFTkJxTGFRMm5xbVN3ZFQvVGkzWmFqdVo2?=
 =?utf-8?B?MEtVYWJZbk05MFU5SGxFNmFxM1N0Q3ZXYjBpcFlzVG5kNDdtL3Naa3B5d2ky?=
 =?utf-8?B?dEtZcHVQYmI5SWNqN3Z6RUM5b09Gc3YzbVBpbUlYUEJGcy9DdlRkMm9aRzNU?=
 =?utf-8?B?WGVMaHdMS3Z2R3Z1NVhSK0RKdFZNSGx6ckVrNnhSMnExR0RZVUpFby9jYW50?=
 =?utf-8?B?MWtvRmxjMW83b2xLcEx1bHZ1MTg3UU1zSU0yeTI3dDJkM29wUjRTcCtsMzVM?=
 =?utf-8?B?cUZFbGtoSGRUYkJIZTc5QTJRaVdnUk1Jem4vaHdJMXZSZ0M3M0krQ0ZHdE1H?=
 =?utf-8?B?YkhBaFk0TFRSKzNaK1dLQWgrRXpUejc0eGdvRVJFalBIQkhUVXpOR2RrbEJU?=
 =?utf-8?B?cGpxaUwxSDRVWG4vQWRCeVZRT3lDWUR1d2xvdEV2UEpyN0RsWklaWWY1bERw?=
 =?utf-8?B?VHFPR3JrQ0VCajhMQVZ1dkkrZ0hueElZODdxUHMwU3grZTRCQVZpaE1HRTNL?=
 =?utf-8?B?Y2JIMUFrbkFZOUNIdFRHWUlua3loMFZyS0Z3QVFzcTNyTzMrMWhTZ05acHhl?=
 =?utf-8?B?MXVvYmRxWlpSUGlnMUtKbXBkM3ZMMVI5ZnpXMW1ZdmJGZVFZYm5LYjVJMDJD?=
 =?utf-8?B?dGtxdkJKbFNBbHNYbDJpMjk3czYyYm1mTkloNllNaEVRS0JhTHJtdnNQbWpP?=
 =?utf-8?B?RkVZMk5ScjJZWTNPV25tMEJ5TU9IWnJxamdRTWhKNmJoeVZBMU9xSVl1TkFE?=
 =?utf-8?B?YUtRQkxXSG1aUzFSRnZHaHdsYUtueWhwcEdEajdmNG54eG9JYVY2YS9PbkZh?=
 =?utf-8?B?UllFVlVPd0JCTEVPdllpZDFTYTJiZHFQaDczQStOQ1FLWWxjRm5xcS9mZjNa?=
 =?utf-8?B?cXB4dTd6ajJYSzhrN0JVa0xnQjE3RHRYZ0dhTzBscHA4WmdYUVR6dnpTSDZl?=
 =?utf-8?B?QjdHQ090ZkhtMjhoK0FHK3lzSGRPRW10OGV0WXRhOUhDSmdadHpHSGJ0SGNO?=
 =?utf-8?B?OTdFemFlaHZFZ1FseS9Tc2dQV2JjSXh3d1ZIemsxRlZFTmlabWxPV1lMcjdI?=
 =?utf-8?B?RWQraWdoZC9qbHJOYVFncUlYdUhRTXNsRzczTk5DdFdnMk92OTNhTG55aDcv?=
 =?utf-8?B?NklSV255anZIbUFjUlVQakV3dm9LZEEzVnFqQ2VNb0tVWVFGSHVHcXVFQllv?=
 =?utf-8?B?YnJkYnpvbkdSdCt2c0VrY3l2NW5YZ0ZXZTVWYTV6WGxrc1FGcy9JWWk4czNU?=
 =?utf-8?B?YlNhbmNPckxRV2pnVUpzV21LT1BOenE2cDZqMmlKZDRNWkg3djZpSEhNQk1M?=
 =?utf-8?B?N0xzV2EzNDhGWU5RRGZpU0RvTVVqTWZxSGlKdTJxUHlPRE5acWdrZEtVSU9j?=
 =?utf-8?B?R3o3YVFkTXFCaU1CbTZyY3BQZldNR1lScTE5L3JDeUp5dWZVUzdGOW16ZGZC?=
 =?utf-8?B?MVJmTExPdUhHU3J3Uit5MTE3Z3BmQy84ck9YWGtXZkg3eDdjUFNqcS8wUFBY?=
 =?utf-8?B?Q2RzbVRTVU4zcXZpRWcwUzEyNmNKNGRrMVJYZTY2N1pBcXNhUXlOTEdJUjkr?=
 =?utf-8?B?N0kwY0xoSWxHbVY3QkRwRGhVMFZmbm85Q0dSN1RDTlIzOHZ5MjhzdFhNL1Ju?=
 =?utf-8?B?WkZ6QkMrNXpvUE14VHhTYVVJVzhEaGNtUngzanNyd1hVUU9xOWN0MEZRYUlK?=
 =?utf-8?B?ODFnczRITENUU3l2MHdLRjJpQ3dJeXdPSlBEaHBnb2x6TFhpd3JxY1Z4U3Ry?=
 =?utf-8?B?bkpqSWVQK29WSms1SEx5L25aaUowbk16RWRDaEhqUWc4OWVYb0NFci90ZXZJ?=
 =?utf-8?B?SXl5em9wMTNoa3MyNTdaZ2dWcnJodWxiUlJGVU9sRTJ6L2ZvWlJBVWNjZHBS?=
 =?utf-8?B?QWxTa0pUQ24yQkt2MkU2cllLOHkxNkpqaEpnQ1hmQjFhNUVydi92eDdnRlFN?=
 =?utf-8?B?Ynpmdm9NWHNtVW8wZmRIZklNMVJRV291NUU4WUVCYkgvOG8yRW12c0crZUYv?=
 =?utf-8?B?c0ZuV0pzWjRuTHNHTmJhZ3A5cXBJektvdk8zeG93aE50VHZLdGpjOUNpOUpK?=
 =?utf-8?Q?0otMVVEMwPUTy3Uc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D38EE80DA5EC994BAA18E66F62BA3C1D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	NO3R7kc+kuuokDPjjMxeDXm7wjmWzdIhn1/weQDX59ujDzvngbWfrT9q5gdshvEAWY6gCmsd1g02kHsuEa6jz9D66nLworfkHmpM9y/Hf+KiWa0tV6cYWOfGIWg5XGH1C9Pmx6jHXCqVubGb2S8RxOG2jdTjHENeQXbEhsy5uQ4zyL/sgABnB/hREPpmRmi+RP9iHeLWz2nzqJVNv708Rox8mB0iEMyQQOKx7eI6TvDr9jzADSvZYLypdIRyQfTXp2ZY4PEa6AuLhTkPVDbIrh/ovY6BF2obdYDmdCOpZ4oj6BcZirJMnzTFoS3K5uhx6E7IFZAg/p+mrrcfuwNyPQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nfTLhIk8lN3QzdW2kY7dBaUNYxl51aj9QVLPkQlBomzFfiTLGGF9RsWfbrUvAA4muOfoMsvhdvNC7UvT6wDz2ZpEKw7/gYG0JIQa7gs/2CDUu4xSHUN1+CbBLckuM+DiacaBF+7tlWQNOQxhGD29oj/1esaASPd96rW9qawPjTz4734BnKFDqvIuatPX9NE5sjOVSdJKaptqHtqblFvmsOoEn6Tr69tITeH3imxWrGwcFABn0qwrArTw2EUXnMQ0SBg9mASUNye6puhrfGsMhuHTFidvwBtrHoOIbNmozt5ZyWOulsrtk0MVNsqCSMoPj/hOo2NkZAsjX0sFMgHzSsJSIZ7zo1dHLVgjfC9TLrrsgn8ATAla9ufoOn0R3bVAhC6NlIJJgVQBxKO838vZRuiUomkC1jP1x9138+muX9mGBSMSzIPlf4N4RHNogufkj8Zobx8R/VTUPVvSWBKK3S2BZKuM47ynGmvSQSsp9n5QNU87qCfR6kqhQHsldcSQaGkGn3J0YfMG0paDgQZtvbCi8baiYw6rH1mTT96Hqbl3Tk+IAuFIuYKWaKnjunRkWe3OUAPqEd1RN+v/zW3XuZMDXwXYD8mjOxmPZg9ca/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d447653-ef89-40b3-aa7a-08de896ea2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 06:29:00.5569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNCMO7dr1sYtmvNRav6Y+cBBPS0MyZPSFcQbbJ91fbBepJVQfzrXjPpQxSH5lhGl7g+oM2ODWsTsTtcPE+XtoBBPmt54ip/ANyga++pD5Bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240051
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA1MSBTYWx0ZWRfX7A+SpHuRHQgj
 9VnsZKYAhvITTvOMqpGjOrbWYRKFJXgG4Ye/8HHn556O3cnls4tDG5x+WnPjzJeyXd4gIjeDwjx
 m1mUncW3CRRjDYhK0igsO9CWLxyk9txjw51auHqw7waP0lBpfM/kn0waKIhTzuv+1eXX97PoVG5
 vs5wSFX+OJnHbMR6NzjRWQI+8J8gDn1vj6HmjqgqG4aDGugntyoTtwzcUjZTD18rrl+35bGQKod
 F/cbaDH4zJ2DOTvIr1wqqCjBKQDbSFByCIoDByMWsy1wR3yGFZFnJcUP3/rKqiqcIa4UidzN0ZE
 hoEYbiOKkSoepISMepE0ptfMwIPNhfU2vGmN0otc6n5ehOAFlzcOmEVFeYgvC4RePP35anvUyhr
 qep+BY1LyAkEV86yLNWHAvHtopZksNdvc6u0Y97z7VIsGA+DuDRVJF9O0JALCeWwlI2i15TmueR
 iWf/h1I66zjWSUMmoOfCuW/9gMMdvqecxmslLrF4=
X-Proofpoint-GUID: 8mgMjalXuqdjxKu1CGLpmOr0MzwurRAt
X-Authority-Analysis: v=2.4 cv=TPdIilla c=1 sm=1 tr=0 ts=69c22f3b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22
 a=sFRaxhzu6ggmEGxsuSQA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12273
X-Proofpoint-ORIG-GUID: 8mgMjalXuqdjxKu1CGLpmOr0MzwurRAt
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,include.sh:url,oracle.com:dkim,oracle.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18557-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 1184D303341
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCAyMDI2LTAzLTIzIGF0IDE5OjQwIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVGh1LCAxOSBNYXIgMjAyNiAyMToxODozMyAtMDcwMCBBbGxpc29uIEhlbmRlcnNvbiB3
cm90ZToNCj4gPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcmRzL01ha2VmaWxl
DQo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9NYWtlZmlsZQ0KPiA+
IEBAIC02LDYgKzYsNyBAQCBhbGw6DQo+ID4gIFRFU1RfUFJPR1MgOj0gcnVuLnNoDQo+ID4gIA0K
PiA+ICBURVNUX0ZJTEVTIDo9IFwNCj4gPiArCWNvbmZpZyBcDQo+ID4gIAlpbmNsdWRlLnNoIFwN
Cj4gPiAgCXNldHRpbmdzIFwNCj4gPiAgCXRlc3QucHkgXA0KPiANCj4gSSBkb24ndCBiZWxpZXZl
IHRoaXMgY2h1bmsgaXMgbmVjZXNzYXJ5LCBvbmx5IGZpbGVzIHdoaWNoIHRoZSB0ZXN0cw0KPiB0
aGVtc2VsdmVzIG5lZWQgdG8gX3J1bl8gbmVlZCB0byBiZSBsaXN0ZWQuDQo+IA0KPiBJIGRyb3Bw
ZWQgdGhpcyBjaHVuayB3aGVuIGFwcGx5aW5nLCB0aGFua3MhDQoNClRoYW5rIHlvdSEgIExldCBt
ZSBrbm93IGlmIHlvdSBydW4gaW50byBhbnkgb3RoZXIgaXNzdWVzLg0KDQpBbGxpc29uDQoNCg==

