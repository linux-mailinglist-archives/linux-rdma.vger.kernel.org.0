Return-Path: <linux-rdma+bounces-9923-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF97AA08BA
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Apr 2025 12:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4163AF7F1
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Apr 2025 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A375C2BE7C3;
	Tue, 29 Apr 2025 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hRC5dfJk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB13A1922C0;
	Tue, 29 Apr 2025 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745923187; cv=fail; b=kuDFC4BlE8Z7KYFpCUO2XYsIYUQcUUjzi2z7YCktqC14FSXhgkEE/dM942edJDzhEZ0rDfzGE4v/FueoXi9ru25RoUuFehtDmAl/m+lVRIRdCdAhA3Bo4eIGSXb+yl1IiUi+Ev8OXC7DuquH6kcmuE/Qaye7YkdJ8dredUZVgUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745923187; c=relaxed/simple;
	bh=YhvBGN6iecmixBuUNbC25+jLkfdzkABrZklyDziILeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tb+eQa1cOWAP8mFS8DhHkQXrZSwfSTTgFdQa4sq0JlU50K5cfVFvDLztCLOCNCcLD7oXcJd+FH8poqQsThaYhdVDs4bsg6GDU5s+zCDI/gJuWiXS6r2CZR2uFrEBbMLojT9PjkeP+ghmhdu/hqWI42h3LK5KI1PH23hAv1nf+BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hRC5dfJk; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9ySIOxdf2W1aOWIczcSVXBN85T4ITXFikg1VCoAaKa5CUnBxm/5ettpyo68dPJfaAaW4++zpLrvCV7rRjbtnGgCIhppCz13MCj0XYUg5+4XJLWHdoT9N00AFEr5pzrau6xMp4fQKabbRWP6jBskA+WXrGPvsEx0AiPiw7btMjUWjUWcB4wG1l0aO0uAO8wsCg0IrfXgkeyry+pZ8tKv8ODKgsU08rq5y8JQO8BASeR3gPbhx3Pa106liVrff2W6IY87epzLVq3MKkuWuaCeYBeh2ci5uKT7q/nisq0XKDqmS9pvP+ptusnT7LZTjUYCK5ZWPUFVfPRC2GD7LBXHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ApayPQakyfHezqiv9R6aVDIzMQqd9ms1vZO3fxD5YE=;
 b=jQ/sQ5Vmp86XBpbNNiGIqRN05YhKfIC+DRC55X+A0KHyahfRZlw3/eSDkFlg/Q3hqOL2udwe57n2fL57BELWYHf1K7dUY+Mf4YVL0HSGt9SEjSaRM/1C3Ac9qSoyFA9gy48cPso/8Hvz8ZKfkO8aMT4sUiJcU5EyM8gs00+NteYuG/8mC6Tbxte45Mq0wuq19bdXLFDJTtfjrhigQ0fnISQsPD3DaFwfOOK3AH1Z1W3BWh8WvoZoUY63D2Ju72s5Va+KDtWwk36ou3ZuHqVwXzTY/O/hSSla6lf3kNHhNhmUvtkn4ycjzN6A53Qu77tumpDxviZ0xoBPZiNoSJ4VLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ApayPQakyfHezqiv9R6aVDIzMQqd9ms1vZO3fxD5YE=;
 b=hRC5dfJkA9Cz7LTzbUAOMiTtVp0/XHZGqnibuYf2CdA7bQ7Pn2qbhNbLgqmdtGKyKEuVvyXJt14foZ6KcH9YNyczH0dD5T/W7AbiZgzvTCJKBjQJEHLXHvtO6QIZA1ZGffS+HNlA9YpUvTlQjEsF0mn1aFqBlcLaBwmqDTvbmTBvbbvkcw6uadFyQKHSVTt2UJ6OlLl2+OpzyiX4HSFa5Z1Z41gZVQFzh83lzE8xfXPMMFR2iqjrlfvNyrJWZWwPqlETSUVkRbYCNS5MCQpW/h70vfNtmgoHDSuVUfaoQkAe2nSVntn3SjkiDcpAwOnrVbmo8/VfWJQoCI+ecQ8diQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.32; Tue, 29 Apr
 2025 10:39:40 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 10:39:40 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>, Jason Gunthorpe
	<jgg@nvidia.com>
CC: "Serge E. Hallyn" <serge@hallyn.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAZ+iMAgACAGGCAACPuAIAAA3qQgABFyACAAUU9AIAAB8qAgAAxbYCAAAUbgIABS0ZQgAAqToCAABIpe4AAAEUAgAAOzYCAAQq5sIAAXSeAgAF369CAAA4KAIAACQIAgAAGW4CAABMnHIAADWkAgAAUtxWAABDagIAEnY+TgAEi6ZA=
Date: Tue, 29 Apr 2025 10:39:39 +0000
Message-ID:
 <CY8PR12MB7195855B870B5D00EACFDC79DC802@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250423164545.GM1648741@nvidia.com>
	<CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250424141347.GS1648741@nvidia.com>
	<CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250425132930.GB1804142@nvidia.com>
	<20250425140144.GB610516@mail.hallyn.com>
	<20250425142429.GC1804142@nvidia.com>
	<87h62ci7ec.fsf@email.froward.int.ebiederm.org>
	<20250425162102.GA2012301@nvidia.com>
	<875xisf8ma.fsf@email.froward.int.ebiederm.org>
	<20250425183529.GB2012301@nvidia.com>
 <87tt68cj64.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87tt68cj64.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CH3PR12MB7716:EE_
x-ms-office365-filtering-correlation-id: 0f1f1e0c-0248-4ce9-0f2c-08dd870a2515
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?i5DlA/CwDzYvR1/SBe3wzfScZZTy1ht1Tt30bWCnauI0qok+jxsR2G3VrOz3?=
 =?us-ascii?Q?TiaZJImaTTm+u/vivayHnLzPPxUNc7nfWpM8+iwtYARjAuQ6wuSpNwPApblv?=
 =?us-ascii?Q?VD+QBwvYgyUPRLSgWB3PH7+qxT1bPqghaAO/LfhRJSFoq06pFsWdaxplapHn?=
 =?us-ascii?Q?3axzE/2BVW7AfxuimEQp5bm1wBpp2XVcFUMvHZQDZzjjA22YF28D5I/i3vPj?=
 =?us-ascii?Q?TkRQsPNVFBZJZXR347O+TGDS7T3DJAN/2r/8i8sKurc/WS6/+b+rmOGIyzv4?=
 =?us-ascii?Q?CLcNwJuU3H6iu7fI7ExZkfQp2hMdG0eZuy9KFiKYuCyDPHf4XjnrNvGMMVGx?=
 =?us-ascii?Q?GgGjqo69etkcrlbGqo7CfmM64PJ+Am/xy3zPSzjIJ9SkNsDR/AvxkyjEG7za?=
 =?us-ascii?Q?dBGrcDc825ixke5Ppz2bzUOLDD5uZcsnw0WFNPXk9jfeiYpfX1wFL0gjqVuM?=
 =?us-ascii?Q?fuBPlNpZQ2qN9SZb0OGq8VS/o2MNvf4RSK59dGuluEZ8WVIyPmg6XcHKJbEr?=
 =?us-ascii?Q?Jne9tKOycLCHe0iYYysnaZUlPtBTtSA5QIN4CuF0KEePzd7jxcFEOhjPfgQq?=
 =?us-ascii?Q?MGkZ4/KUR+wCGol2M9Q9Fniyta/NmqtUV7WolcPOIzkrRc4vT7OI7wrlEtaR?=
 =?us-ascii?Q?rddksyc1eXca4rVKxiMtCBeqKHCTXMOqJ+yx5U2W5ec9+rOAtDJ1dvnWJm26?=
 =?us-ascii?Q?0YycAZxNHK3aaXL2cV3Muw0G8D38oH9Cd/BZm1oRKPkAQGcPlgFgeh4i+9/r?=
 =?us-ascii?Q?EbWIZjoxvZX1j4cLf9h1rsEda+aMP/NA2W0kaW1jjlSnP/qmyVVKzp2MWrnC?=
 =?us-ascii?Q?NVuPEH7QAQdTG64I9KsLRfKDew4DLsQ5Q2OJPnxCWxBAoJOomCk5JL7UDUlh?=
 =?us-ascii?Q?BQT2sfMM2ODWr+gqHbHnBVOFVa7ieC/CTP3o0kJv2QneB1Vv0vv2WEHflJbG?=
 =?us-ascii?Q?9Jrob1U0rR7wNgRIZ7UhhAe5p4sTaizIjlGhXA9E5/xRC5UjvnRhtGoKTeV6?=
 =?us-ascii?Q?DFjf4GzttgG+ETARGRPuznd5gdS6oJXXEyPUjjstlbkW6OyDLpejLvEtK9pz?=
 =?us-ascii?Q?6LXzWKjN8qQGHLC78/5RZBAxfjw4t1/RpYxkuVXKP0IeXzefp39O5nV7HDT3?=
 =?us-ascii?Q?pAh0lEpaj+eoX9+xWCpxFMLUsV6eO/2jyxZFs1lpcUtP7nLEzmErzsm+MPPN?=
 =?us-ascii?Q?RiOWirb6uyC3w2VygnGcExbrgvhDtIcz+G5kqMaex4H7ZgnIAlABZZawArKu?=
 =?us-ascii?Q?XsHk/ZnwgCbWxUp0C6BB+tOoKltSb7XiX/IxT0QWO/9HuqQoWGxzsXOhMFXf?=
 =?us-ascii?Q?tMHQsAauwU2ScEcBnB38+jhmnx2r6hKLXLHaI43fqwAGBWgbEZJ4GTEVnJEQ?=
 =?us-ascii?Q?xnFOMJDoFU2k9Ex2He9iB5X9nP8Yzk0n2LvOg7Ma86VsKqe2h8VzFmCb/0XT?=
 =?us-ascii?Q?DKcxV1XCzz5vvv8t/N+OtRIMENaS7w5qAnMWpydW35DG9hJCiaWjkqWv+ypX?=
 =?us-ascii?Q?TeuXO62zVV0PKXw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BJsZZFGfaxCC09CSc1Z7Ez1aaW5GpmTx85Rpvt6cB7OUzNa0sJwDe9yZT5YL?=
 =?us-ascii?Q?X2mX3SFBTwZLL7ZkXtxMpqNyu73NA4a4Kmrh54e4RhG3pmLdaJasWMzhuUNF?=
 =?us-ascii?Q?tj1E5rEdZoj7I97yNL56itY9UJzAlA2Rl7+iBnF3d9BORAeNWjopGU5WbzxP?=
 =?us-ascii?Q?JLhsCi4DdPL5UiXNinL1maT/4aekWfsDauw1DOObozKFi2HwVVX5ld1MRQLG?=
 =?us-ascii?Q?ajbXjVKk5eKz2jqORyooWHd13J8gxTFK3MyB47PLh19RyjwvlQHD+OkWMn+x?=
 =?us-ascii?Q?4Dwjpm7AlEASMkFj+lFSM/kYe5t3mf41FNQwqMgSOqE3lpYpwFmyZxQSaAu7?=
 =?us-ascii?Q?PyuBeGpeZDUBMBnvXUIt+T9TSJoNmjAxjQY328NCXtSUqiqA9PUMmvMQILEc?=
 =?us-ascii?Q?skxlfGf+5DsKnVQVdHDi8SLd7yyxZWPFlLb+yHCrhuX+YsTiQXgDZCCtWhvQ?=
 =?us-ascii?Q?CX3iLBZtKklWQQYaEnlM1gEinjgnUD1rvHl+uFhd3201P9JK37jvlHmOcf58?=
 =?us-ascii?Q?MoKoAkY7VeOVxzjj4wKFqZUOvoY4ui81I2LC3NkDIu8P5tYC5R7OXigMiZWI?=
 =?us-ascii?Q?zFXzVMWbtDy143sS1OmRbGM+3Sbz9Jz/TUhwbBLxR8Ku0Xnc2Vvprt6kpwxv?=
 =?us-ascii?Q?tHEWymcH6GHSUWy9AKV1SKzwqQt1YgNOugpzeKDcbYPjHjNhZ2kh1p88P7xa?=
 =?us-ascii?Q?WXC970G1PO2xrMADZQjRRJs3zNErB0rtrMwB1QU/BuWKPZ/JsZbLn/MM40Rd?=
 =?us-ascii?Q?FjHtmoZMrLnLqjxCZ2TXySjdH6P09KH22LyKQyKJ+I87iz4x3BRc6azeCmYR?=
 =?us-ascii?Q?fYFF/PRjrtfWrjn/Ykuw8vKJW6LHXKKsFVKhDaibrKLaTALLFBlmEwP3dijf?=
 =?us-ascii?Q?JQeh85+oZny53fKfa9tUcY8Oj3O02ail9SAfqv7hs0pR/oYk3FcFuhNd6G8S?=
 =?us-ascii?Q?f3P2u1nTg80ShHh75vGaVZtQaQ+ZzW1wcB+wq2GTpJgW7wrXYEIlfSmXi92f?=
 =?us-ascii?Q?9uphFOI8uHcJe4Oxv374sosdipD/Ai3794gtZzJ9/UFgfHzKek+QAHbhSy9e?=
 =?us-ascii?Q?v4zeNnFRS//iU1Ho4JgwTJopnlibJI+/KC1QaOER/r69yaLi4qADnTJZtqFe?=
 =?us-ascii?Q?YyFmedITbD82v88n7Tqd1Pan7meDa+hgIUPxCoLftQ6pZDER6Jb85lsHAnvq?=
 =?us-ascii?Q?hUu/LOe4mGpGNREY9jIAp7GYL1Lws+LS1nTJvHtqDrW6opLLAELOzbEHl455?=
 =?us-ascii?Q?/P58RbHuqSQevdJmeAXXUw9hekLf6P1RYm3hsmWF8EnlnxDPmxb+EFg97wVX?=
 =?us-ascii?Q?/hDgNOmheiIh1h9ZZmFEscyt8sXkftW7THeO/1a9Hf5UhtzomN7DsMba+zBX?=
 =?us-ascii?Q?EOtJPDL3o6XwDGmpj1Nw58hkcWtDBQRtFg+R8e68ltatMJnofw4YAZYCKqA/?=
 =?us-ascii?Q?vRfcaeu7gn91Blpe+vQs1k8xU5lzUFPcMSEIQwnAt96P/m0anMEqkkkAZPA5?=
 =?us-ascii?Q?M+4Dg2Bvysnz3Qd2ifGGWiiMZot6DW9f2M0zhvebGqsOR93RyUqs3MC1kknc?=
 =?us-ascii?Q?Gfg9ISNl0/lw5ccCM8g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1f1e0c-0248-4ce9-0f2c-08dd870a2515
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 10:39:39.7622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vVSMuBpW/QraBORZGBgJGJ3wtYANSyVYVnw6C6uZUcIrbu4nXZceSA1FtXPRfEDxI1dXCpq8tD1LfdwouG+GaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716


> From: Eric W. Biederman <ebiederm@xmission.com>
> Sent: Monday, April 28, 2025 10:34 PM

[..]
> > I said "user_ns of the netns"?  Credentials of the process is
> > something else?
>=20
> Exactly the credentials of the a process are not:
> 	current->nsproxy->net_ns->user_ns;  /* Not this */
>=20
> The credentials of a process are:
> 	current->cred;  /* This */
>=20
> With current->cred->user_ns the current processes user namespace.
>=20
I am confused with your above response.
In response [1], you described that net ns is the resource,
hence resource's user namespace is considered.
And your response [1] also aligns to existing code of [2] and many similar =
conversions done by your commit 276996fda0f33.

[1] https://lore.kernel.org/linux-rdma/87ikmnd3j6.fsf@email.froward.int.ebi=
ederm.org/T/#me5983d8248de0ff9670644c57d71009debaedd6f
[2] https://elixir.bootlin.com/linux/v6.14.3/source/net/ipv4/af_inet.c#L314

So in infiniband, when I replace existing capable() with ns_capable(),=20
shouldn't I use current->nsproxy->net_ns->user_ns following [1] and [2], be=
cause for infiniband too, the resource is net namespace.


