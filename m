Return-Path: <linux-rdma+bounces-6712-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEEF9FB8BA
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 03:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D4216540E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 02:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D7A1B815;
	Tue, 24 Dec 2024 02:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rONW7FGu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CQ0vQSv/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95E618D;
	Tue, 24 Dec 2024 02:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735008491; cv=fail; b=GFUpCicszFS/v19NICWla2BGwUzQxc3Lh5zCaM93h9IZwhsD/lOkmbYB3sGXq8cZQRED8cpnI+82fWxzWdYAjYYWAKnGObkgtOpszFN491gRKUJO8OG5Jnvu7qdFkxUwbNGm9lnWDlmBDmi6t/TtWgysv61yqX7fhMUuEbXbJ5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735008491; c=relaxed/simple;
	bh=QPpoJYKgp84dmJmXq54YqNQB5F1+ddoN7EtH6nhFCdA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oFOcdB3hIAXgCt1tB23mKyW9+EYy5rQxdrV2pU0TJ9NEPDEkuScZEfXc1RiYKzyTbs/DRDnCQn3oCd3K7R8GhqBAgIU4Eg7FHrnSTNBx7Br9FJi7oDpdjd0O3sw5RJKE1UcMyLDHpeYEpbUewtEbdwX0v9qcGtcS7acEdj6SB+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rONW7FGu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CQ0vQSv/; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1735008489; x=1766544489;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QPpoJYKgp84dmJmXq54YqNQB5F1+ddoN7EtH6nhFCdA=;
  b=rONW7FGuOUy93N5NGyz/EVewL826SsGH8LLMZyhV4EPVKH277+P3V1QW
   5wkAnLVw9aRrZIq6yFqnjLMyz2cI8jOn4vYmJAXF/TenHCOg+2akRU3jQ
   /Vc35ftodJpvlsZG+kHJ3glAacY+rX1aQnBQvMFZxb6nFG2eYZpQV4ysy
   iECAJ4VHuyj4YcDb7olAVuCLhXBLjYdVfZv4skPeOSX8zy+nm4RFNKt61
   6tc1/xBe0T0aLOwwiwHu7QILzlWml/HJk6nAWz8i50sr/qSwjlZaIMud1
   o3UdEehttsVCge1bNeuquavQ7pCZ2ZuAFOH+ij2AUNg4Z3y1WDs28K9lZ
   Q==;
X-CSE-ConnectionGUID: kY3QUUVSSg+cF6/kqGVQ6w==
X-CSE-MsgGUID: CGXMQLa0RQyurMKEuwtHIw==
X-IronPort-AV: E=Sophos;i="6.12,258,1728921600"; 
   d="scan'208";a="35723316"
Received: from mail-mw2nam10lp2045.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.45])
  by ob1.hgst.iphmx.com with ESMTP; 24 Dec 2024 10:48:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtwbPHkSaCDx9TXW52wfYelqi2KCQ2pu/mGMOitIhBPLGFh1PQfQZUr7wxfBUc5C6M8GmlUEJZ6CWo2G6P4jpZfkXxxY8z1ft1A5Iy6jyHzftNAI/0ve3dBRjuG178XgTbs/U9KUJTH1TPu+4ryT+nba9bnf2KYU//enCuEZKXJwhYwxmgVq3ZIIxXwpToYGbZLvKTQviZ7OZjZETsM0olYVR+k91YZHpNrHTYyOYvRLfpZ3bYWyQ3KcFVqUvNUe1klmOAXcq+sYHn8AclvO7kwFz0awFoa9AusPLIOjFky2WIumr4EZSbNWVCZjlYciJhtwUpmnWXroOOG5W3w4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJqtjsvrWCEV9ZG9Uu6wPbYVPu/su/ve/pBgiSTbcYs=;
 b=nK0QqQENXYABegJ6Qo2ytbI3jW/oGTo/ami/tIWDtTBrUfT+71299UCPtXKgd80tr6+LK0EOe58MPNBklrOVDjWq7CkgoGh12VLrhv+Q4VOkjALHJ7+Mai0rBTLPHgUs4XH4DEMNdsXRvny/wxqPqq+3GTv+5TP31GRsQXxJdY8zNlnl7V4UpN5a6DWsGj1cX2m5XNF7SopBuG8AzN4jD+nYKtk2fXXzb8QWxirUQfzPN946cQdpWG7zk+0eUZxcs5x4tmvGaDzuzS7beCXFwQXZ0fDipKcxd3Yj7lmcVQWRJNpPxdVxYR0jmyvON+OSFt4My5al3NPyKsdj5PfuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJqtjsvrWCEV9ZG9Uu6wPbYVPu/su/ve/pBgiSTbcYs=;
 b=CQ0vQSv/2eZM5vNz4PF36L3vk2v9E2NNIeSGF1FmokAHktthhHMJ+QuNFRTCrCyhFv4i8EXsJJdctBq3BZhrWE+JWOAOsfLzDTzF5MpB18dGQWfXYCo6HvWCF8L1CS3sUnXPcP9fjXk3pBXAB88PGXuG2uqyGZ/hs7nX7Bzb0I8=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by MN2PR04MB6448.namprd04.prod.outlook.com (2603:10b6:208:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 02:47:55 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::2482:b157:963:ed48]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::2482:b157:963:ed48%6]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 02:47:49 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Jack Wang
	<jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Subject: Re: [PATCH blktests] tests/rnbd: Implement RNBD regression test
Thread-Topic: [PATCH blktests] tests/rnbd: Implement RNBD regression test
Thread-Index: AQHbVP3y1Ihm2pPBU0WGJTNb5qbU2LL0snIA
Date: Tue, 24 Dec 2024 02:47:49 +0000
Message-ID: <h6qdtbdkdrpsfyk5ebn5fyv7jltmhdrtwgmwdzekfsh752gcrf@ezqvln7wnnr5>
References: <20241223054535.295371-1-lizhijian@fujitsu.com>
In-Reply-To: <20241223054535.295371-1-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|MN2PR04MB6448:EE_
x-ms-office365-filtering-correlation-id: 3e90e651-f1e1-46b1-287a-08dd23c55b0e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?41P/CKiPhg1TcXqZNAlfjkIGEvKMBkBksVMGTTTnpfrGibgCVVN7JeBTZ1G1?=
 =?us-ascii?Q?fXKE6L9HfrsJx6lXAlsIjAYsRyaf9SYZDcz+gJMKFJc0FPEf3CB473mVd4u5?=
 =?us-ascii?Q?269g1xx5yMDdb/OdsSrggYZnWl2sD4c1j3Po0WPYvp1EQ6UxgNO0aOtTjWBx?=
 =?us-ascii?Q?SGjWHnx5ifAC8FcxhYymykk5e72slKyztFjlu8G86l5IPu1BNE2HHntpvUrr?=
 =?us-ascii?Q?fjkbPJfcsY6LE936TsMRdpEx+2QSuQP2K9aKCqAx2Zhjp/T0X6lirq1I8LHd?=
 =?us-ascii?Q?xy25FRUHPtpzYD+R1TVt0+f5eSvhpM1tLAm+9rv7IZcu7NGcVvCvO8e/o58X?=
 =?us-ascii?Q?sqGIqLuSRSywmxK+9zka7gsg3PPOXdmCJWNMKrptg/xywuW7iMfBYBla5Lv2?=
 =?us-ascii?Q?vhqiEiIgStfiPXyk3oCmLfVdsEJDUM5VEYyGVlIOiWbusGVLbbx+0eoHX8/b?=
 =?us-ascii?Q?3r2Yq/xFyHwb+duMktR5gzFcgm0ao0X+vdYd1Gz3hXpo8PrKoLWDVOqdA+2U?=
 =?us-ascii?Q?zw32M/Yr4iRgIugqEvrA07wv/aC2eYJlBuMiFF29BJkVhFckuL2nXbGn15SG?=
 =?us-ascii?Q?3EK/gQLXu6dBsLFkFLjrw8vHT5mIYqc9uqCuvcTgRsbk7Y4BI7diueAVpb8w?=
 =?us-ascii?Q?1Q4ZHNMnT1mR2PtZ9RjKWgsZtw860jRBFFAIo/FcdMQKexidkmmYuiFG6O9l?=
 =?us-ascii?Q?6//Dvc5g2nZO5s99N5t6ze1+M+OCXOi09ZzbTwp7/VQ+KcqOqbBXJkoqA5pc?=
 =?us-ascii?Q?UZqwFKPRSecxoytYyGlXRLvIMgNB9YRKnG6eKLeJZAW2gMJWSmEZAp0d1eTb?=
 =?us-ascii?Q?sKsQ1Y6G2AuJUOjUoGgjQKQXCuJmsWBaaY5C0IEIqa1Q6pkNpE3Zh79sC2Gu?=
 =?us-ascii?Q?HELuMOX+p4CL7J987AYqq4rw63lzEQL8Yu32vsBNorph2eIYUTeeUCPfIPN8?=
 =?us-ascii?Q?YoxZYCwM52WVOnUNvm1MHWPagEEHW2aoS4mjJhkFjIojPj5CAdPWZBqGDoi7?=
 =?us-ascii?Q?3n07SXdr0dOdRlmLaaxYld9aDT+yKbbveQrEvnKUWaK9Se0OrJTXXPyiB5XA?=
 =?us-ascii?Q?OIPZS7edKuiWgc0B/TF8Mn7CLFTbCbY6XIMeLURqKNhOwP2l04ps5eCJlYDA?=
 =?us-ascii?Q?K26C+bB0dd8XMBmaMgRFct115FjSH4xQA44hNg8HQ/E4ncA0de2TJy99yp+d?=
 =?us-ascii?Q?guVBM5trJm6DA9KPxnHMzUWg6Fb5QE8bV6KJfru0hxgcEV0Nzw6YyIXZaZhd?=
 =?us-ascii?Q?HEzCGGy2dwwv69nyafoclJKDV98c8t5PkciYQFQ/Z9RXqiAoyrZtk6GDnscX?=
 =?us-ascii?Q?46GEtEJgoXGegKIeonBk8r9FcFfUe3csYQdcGW+Lqi1wKveFForXCHZH/6NR?=
 =?us-ascii?Q?CWCo0noFdEj3GSvQRLP1swYru8y3M79LNVjQ5IYl0HPPX1FsHKIpCNbVT1Yu?=
 =?us-ascii?Q?YObNd0jy3d8bgttf3DED1zk2BN/0tjCZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W2Q3oF4soR8dG1hoeOXfjUQfIy25IfsNNQJ23fydNtpBIxE7DsqYDit6AdkI?=
 =?us-ascii?Q?LQu+x2Wt//PUNDmra/KA2tGoFzVRxk4HK4cTmEt3K/6gStkhwjlTeqvtyZ3j?=
 =?us-ascii?Q?flQNDFgifCFw/ZvDA6AnXnzriAwDdI6Oum75mEyHEQO+yfJ3Ie2aWgLRiubX?=
 =?us-ascii?Q?XnkhVnrOb/8r0SJz8BAq8X4wFWiLri1BmVYbZybz+waCrJBLIDjV2NtOT9rF?=
 =?us-ascii?Q?j3JWQaIuaDDwnBNzKuM+khOCkz7/YLwZBgwdWlq2vK4fNROwXKw4BJmasUy3?=
 =?us-ascii?Q?uSzeemtatPvQ1bqDcWz7/zR7qIPS3RtmVoUUbRSe597cP4FnW01Op2Kd46VD?=
 =?us-ascii?Q?+pQ4HlCsCwt5WdmfQlfotXFIHzul1CsbNpcgqbEJZBft951htNkwVyN7Ue+M?=
 =?us-ascii?Q?vl+mDk+jfk3e02wQ5CaBPMIUoDYADzEqbbElMv6/v87TBh70P3RocZpW9rCy?=
 =?us-ascii?Q?3I1NXLVSagtrPbekmMFTd48u81EihwEUH0Hxctv7dW3RfAVe6oHpPZw6OwOK?=
 =?us-ascii?Q?5uPzwxMimH/jJUlcfm+nVJR40R+kuUiJfoLBU+5bQA6JSB7R8zd4SGJlTsxv?=
 =?us-ascii?Q?9kmB4bQJnk72nBApTHkmLbHUarxT5e0gkoOJeSsRTp6H4ndNMIKlbKX3+DIK?=
 =?us-ascii?Q?bO1OBcDtOJSPKp0PJG5Dv8Dvr1mcMSpDYXVTyYhbOF/RG44JK3olGQIEltkG?=
 =?us-ascii?Q?B0GPA0gbqMlN9/8cyJDiq8eGPf2x20Xy13q5Gr3UCLwIRbGm1UNRkGPBfqEj?=
 =?us-ascii?Q?5BHgoGmDFtnriDyDkk70wn2VopDJNRcD87o3sQWQYYvf0dTg2WbXnEfTxN4d?=
 =?us-ascii?Q?r/uwScT3t+/zGC0yeeveVhMRlnv1sA/7/xL6IEByWGFmqsXbdSXwtCjeyI1E?=
 =?us-ascii?Q?bYZmCbjgI9WmSFjNQ1Niqc7Zm06I2CxE9jHkcoTEmOqmxSt2FfMwXnymW/43?=
 =?us-ascii?Q?I+cLY2GN80ZNMMKJOUjRZIequckR/fHNwLKbCOS23lM50+cIoa+mOlPQYEnx?=
 =?us-ascii?Q?aA8CJ0FEif2LHdFqtxMHJEma80l3JBJjt0DR27ZDibG6xbfCfqybg11G4G/d?=
 =?us-ascii?Q?2iPkPpZ4mWmj4BxsTbHnaFn/2n2P6M4RPY5GPuFisahYsjBloSIfjFzaADRf?=
 =?us-ascii?Q?v0v1Mvc2oU1RfIaLYbWyvNV0gAa+p49SVRpnElyFoO95+JDxfJa2PWcz7QVZ?=
 =?us-ascii?Q?6UHJQkTo9bEC5b/BwnjyAczuh3MxQgUWcrbBS8nCLMEm22Kez9Ftway1S4M4?=
 =?us-ascii?Q?wK6E9OJOW6J0I+/ZDM4FJWtkQLt4EOXP55cWbrATB8L5qx+uhTOpSq702jiv?=
 =?us-ascii?Q?vrEeKCcVGf+UMV7g2Qr0mHBz36ImH9NtGgrxNumFOG8KMY39b6nH+nq1bqzi?=
 =?us-ascii?Q?y/GN9jG3hjaJTfiTE+I0zHGr4jHbzeUrEZsR9PfXKKxvqts7KMCQoTqOLdon?=
 =?us-ascii?Q?Fskyr1x+n+fIsx3Y+UUXpSJ1PPXcHeGlGnFDSf97+Vpf4oK62gAkSogWWQu/?=
 =?us-ascii?Q?lvqHfqF7vQH4s3gJBf2Bx8qYfZp3i42LM4poiY4v347oeiBXeDAAXyE12jPJ?=
 =?us-ascii?Q?gCv4paxYVDVdH5qmGtFbpceGDa7VaSqfG2gyS4KVvswyzNF7UUC4K6bycfvb?=
 =?us-ascii?Q?FnkJZDI8/i4Ei0gfqhU74bI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FCE30E2CB207D449DAD037D251136F7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nsOKAf19czdS/w78NYlSSS91Bx/CrFK7HV7YWL+qNBI2OAN6nfdu9Oq5B2T3leFarOF7HJP/t0D/EfiRezc9ca3pHHzDh1cA7W3+3o1N1rUkK8rqXQax+XkeNTpoyBzd5zJCU1LMWEfql4/QVxOb4qsIEODRWjvcLsybSkxQEFEA50Mv4es2JQSunEZ0EeLjFsw2fhqvg8XNRe4dG/sXky0jCq12khjRIOVX+GmTGYnkNCfaifKp3K2LN4fErpvH4emVpoI5WXSsrjDbbcdn36q814X5YxlPb/WiAqmgfLZRXIXEKKphmf8z2fZUBo4L7vHz1CAAjY2aDL1i3PdGB9hE02vEryQQCXd+wQU0hKVXEtdMDPTGUyAdbGZzfczwVObUitjV5b/OgkKsE4NZ4DaIFDcV2Zuj6B8QB4R1Pecp7ucx50IpUdJpgVs8AJz0SW/e76laHfitx2q6AXmaQAtsdTpjybQsdGv9Wi97wED6p6kQ9J/geC1qvyqgReAPCObn9rmMpyQaCBbPSD5xbJJfOfu7tvggSDrwKg9T2r9mY96zXKsFIRh4Gefc9Sou5rCPjnIshN1qaE6iNgAvqQJzpxGiUep+sZYT+UUMzt5ulZfmH/V78WDAMFKe7PLj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e90e651-f1e1-46b1-287a-08dd23c55b0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2024 02:47:49.9158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ioDPOP+0Pm/Ja/QQ5t5Q+DCIAHTvdqqILjHVfXTX1XnIJ+QUwEJdzSO9VXAuxzETTokh6Oi+zQA/+btxlgCJPs2R8g+BF3V+dZqp5U+Z/ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6448

On Dec 23, 2024 / 13:45, Li Zhijian wrote:
> This test case has been in my possession for quite some time.
> I am upstreaming it now because it has once again detected a regression i=
n
> a recent kernel release [1].
>=20
> It's just stupid to connect and disconnect RNBD on localhost and expect
> no dmesg exceptions, with some attempts actually succeeding.
>=20
> Please note that currently, only RTRS over RXE is supported.
>=20
> [1] https://lore.kernel.org/linux-rdma/20241223025700.292536-1-lizhijian@=
fujitsu.com/

Hello Li, thank you for the patch. I ran the test case that this patch adds=
 with
the kernel v6.13-rc4 KASAN enabled. I observed "BUG: KASAN: slab-use-after-=
free
in __list_add_valid_or_report". I confirmed that your kernel patch avoids
the message. So, the new blktests test case catches a kernel BUG. Good.

Having said that, even with the kernel fix patch, still I observe the test
case failure in my QEMU test environment. The count j is almost always zero=
.
I once observed the count became 3, but it is far smaller than the criteria=
 10.
I guess test environment performance factors might affect the pass/fail res=
ults.
Do we really need to check the start/stop success ratio? I think the BUG ca=
n be
caught regardless of the check.

Also, please find my other reivew comments in line.

>=20
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Copy to the RDMA/rtrs guys:
>=20
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> ---
>  tests/rnbd/001     | 37 ++++++++++++++++++++++++++++
>  tests/rnbd/001.out |  2 ++
>  tests/rnbd/rc      | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
>  create mode 100755 tests/rnbd/001
>  create mode 100644 tests/rnbd/001.out
>  create mode 100644 tests/rnbd/rc
>=20
> diff --git a/tests/rnbd/001 b/tests/rnbd/001
> new file mode 100755
> index 000000000000..220468f0f5b4
> --- /dev/null
> +++ b/tests/rnbd/001
> @@ -0,0 +1,37 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright 2024, Fujitsu
> +#

I suggest to describe shortly here that this test can catch the kernel
regression, in same manner as the commit message.

> +. tests/rnbd/rc
> +
> +DESCRIPTION=3D"Start Stop RNBD"
> +CHECK_DMESG=3D1

Do you expect this test completes quickly (around 30 seconds)? If so,
I suggest to add QUICK=3D1 here.

> +
> +requires() {
> +	_have_rnbd

I suggest to add "_have_loop" here.

> +}
> +
> +test_start_stop()
> +{
> +	_setup_rnbd || return
> +
> +	local loop_dev i j
> +	loop_dev=3D"$(losetup -f)"
> +
> +	for ((i=3D0;i<100;i++))
> +	do
> +		_start_rnbd_client "${loop_dev}" &>/dev/null &&
> +		_stop_rnbd_client &>/dev/null && ((j++))
> +	done
> +
> +	# We expect at least 10% start/stop successfully
> +	if [[ $j -lt 10 ]]; then
> +		echo "Failed: $j/$i"
> +	fi
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +	test_start_stop
> +	echo "Test complete"
> +}
> diff --git a/tests/rnbd/001.out b/tests/rnbd/001.out
> new file mode 100644
> index 000000000000..c1f9980d0f7b
> --- /dev/null
> +++ b/tests/rnbd/001.out
> @@ -0,0 +1,2 @@
> +Running rnbd/001
> +Test complete
> diff --git a/tests/rnbd/rc b/tests/rnbd/rc
> new file mode 100644
> index 000000000000..143ba0b59f38
> --- /dev/null
> +++ b/tests/rnbd/rc
> @@ -0,0 +1,60 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright 2024, Fujitsu
> +#
> +# RNBD tests.
> +
> +. common/rc
> +. common/multipath-over-rdma
> +
> +_have_rnbd() {
> +	if [[ "$USE_RXE" !=3D 1 ]]; then
> +		SKIP_REASONS+=3D("Only USE_RXE=3D1 is supported")
> +		return 1
> +	fi
> +	_have_driver rdma_rxe || return
> +	_have_driver rnbd_server || return
> +	_have_driver rnbd_client
> +}
> +
> +_setup_rnbd() {
> +	modprobe -q rnbd_server
> +	modprobe -q rnbd_client
> +	start_soft_rdma

I was not able to find stop_soft_rdma() in this patch. It might be the bett=
er to
add _cleanup_rnbd() to call stop_soft_rdma().

> +	for i in $(rdma_network_interfaces)
> +	do
> +		ipv4_addr=3D$(get_ipv4_addr "$i")
> +		if [[ -n "${ipv4_addr}" ]]; then
> +			def_traddr=3D${ipv4_addr}
> +		fi
> +	done
> +}
> +
> +_start_rnbd_client() {
> +	local a b
> +	local blkdev=3D$1
> +	local before after
> +
> +	before=3D$(ls -d /sys/block/rnbd* 2>/dev/null)
> +	if ! echo "sessname=3Dblktest path=3Dip:$def_traddr device_path=3D$blkd=
ev" > /sys/devices/virtual/rnbd-client/ctl/map_device; then
> +		return 1
> +	fi
> +
> +	# Retrieve the newly added rnbd entry
> +	after=3D$(ls -d /sys/block/rnbd* 2>/dev/null)
> +	for a in $after
> +	do
> +		[[ -n "$before" ]] || break
> +
> +		for b in $before
> +		do
> +			[[ "$a" =3D "$b" ]] || break
> +		done
> +	done
> +
> +	rnbd_node=3D$a

Nit: this rnbd_node is a global variable. To clarify it, I suggest to use
capital letters for its name and declare it at the beginning of this script
file, like,

declare RNBD_NODE

> +}
> +
> +_stop_rnbd_client() {
> +	echo "normal" > "$rnbd_node"/rnbd/unmap_device
> +}
> --=20
> 2.47.0
> =

