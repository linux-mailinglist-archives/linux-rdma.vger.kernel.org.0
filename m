Return-Path: <linux-rdma+bounces-15882-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOJwHAcLcmmOagAAu9opvQ
	(envelope-from <linux-rdma+bounces-15882-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 12:33:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE9E660EC
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 12:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7AB254B97B
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 11:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3120E429834;
	Thu, 22 Jan 2026 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LSSUrKDv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1EC423A93;
	Thu, 22 Jan 2026 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080415; cv=fail; b=msReQKJkXkoeD8nbDt48bydKc0uwwupBnIj/dAE9lE98jOkA+evXeTfKh7g00fdPgqE61qMmmL1M9h23MBZCd6GbKdIKWJzeNMMaKXhei4kpAn98HsHVe5u+gGBbk+ihhtG2kHZ9PegfaWGhQYrb8xL6yMazQyhK6MD3bgwt8fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080415; c=relaxed/simple;
	bh=cOu5Ne3UjXo7tdVxuTk+fJzjnL/FN1CkhfdpuQO83lA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nkUl+dwF+LeH/8PiRzrsw/Nsga4rpDADONJeEHN05qYXBgo0jf6YR6eoF7id4EyFO5uU5C02bPPqenv5063FimorO7Ctyx/DyYahPy9Yow/04vf8TCSD/DYGUfBhzusDvAZvNWgxPAiMTuMnrZyC8ycnUh26yEtDcUdS5c4eqQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LSSUrKDv; arc=fail smtp.client-ip=40.93.198.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aX20Gypas5A1JokUWOBjOFc2Q2bAu4QTVxcJss5a9GRjHapqSXsmTF1jQ60YA5wMUbBPmz5zev8XdBD9h1P5FhTsh6NxnylrxuvGJCTUM6iRrlx027dpz8sUBINMKGv8jXXmwk+RE5qZGwTwF+wXefhPzfaUlx8Cf6FeN/Hyu/pXVUU8rj3sBOUcuZnQVGB6c5utkNgfxdPHdpY5SgNnQm7DPAf0r/PQ3mTPJGmXQVogCD5yUBWpcKhQuMltX58WUzVpY8A/N49m99WiD/c47VaOn1p73BBdaVq0oX9neTIM/yuZguSqStjRrBxWHE1TSpK69BgyUNcnbzhU9BUkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOu5Ne3UjXo7tdVxuTk+fJzjnL/FN1CkhfdpuQO83lA=;
 b=OxatU2OYvfjRbkkdCLOPdPrMIcqdH6aeS3ak4wUTpX3FeDkwHn8vOMN6shCBSC6IexPO7ZxI7PC3klM1/Ano0/xLJOWPvDFupXdb1XnJuQgsL1JWYstNEvJVWjFtN4ikk0zLMzHydJEdJY8txcnExQjdk/I6WdIhJIKX67fv6px2yuq8h0xnJdhe+WVp5Qw+1mzuj3dxR4hGKupH4KiPpcyKlN/9U/tuCj9s/rHFHeG1GsfA1YxW2X32/vUstNI0+0AEheKcECF5UzAue7LsrFnTN/NIAs7S53V8ug32UDS7zvG4vmY0ilQNM9K8vIr+n/W+Z37XN2p6FvPkpaSqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOu5Ne3UjXo7tdVxuTk+fJzjnL/FN1CkhfdpuQO83lA=;
 b=LSSUrKDvM2p81Qz6E6O9p3NLP3k+wPkyjNOlajxYxH3YplrnNx6D6zpgBlEKZKzZAHvSuP0+SXr4zuftp23oIMWxiOFLvsE6kxl4+9PU0dyKSlFjAAVjAnGlRX+pMM8vp4FK7e3S0qLWrQexdgJ+ZQaTWekOYw8NK6cRKQ+ekgrqdviFr2j680KIzeEGINRSysH0/aM8Yke3URUMT/rIsyFq7ynHNJFATyRybMV2YPDEWedxWvekA02kjnaLEs2yYVm28SGiqv8ORjj5rhSCRnbCqQsBRSbsm8RoyuZ/Eol0kOdc8xW8I6plwhhn4eyXGKoHRAhfsayoZMW82QCdlg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by PH7PR12MB8053.namprd12.prod.outlook.com
 (2603:10b6:510:279::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 11:13:30 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83%6]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 11:13:29 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "krzk@kernel.org" <krzk@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, Jiri Pirko
	<jiri@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, "horms@kernel.org"
	<horms@kernel.org>, Mark Bloch <mbloch@nvidia.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V5 10/15] net/mlx5: Add a shared devlink instance
 for PFs on same chip
Thread-Topic: [PATCH net-next V5 10/15] net/mlx5: Add a shared devlink
 instance for PFs on same chip
Thread-Index: AQHcieK4l5GyCiUfzEm9RdjYX7TakLVd0YyAgAA68AA=
Date: Thu, 22 Jan 2026 11:13:29 +0000
Message-ID: <77465165fc53b31b13ca7ba6c25137622847872a.camel@nvidia.com>
References: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
	 <1768895878-1637182-11-git-send-email-tariqt@nvidia.com>
	 <e645d5e7-2f5f-4f38-b8e5-056f0cba46ce@kernel.org>
In-Reply-To: <e645d5e7-2f5f-4f38-b8e5-056f0cba46ce@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|PH7PR12MB8053:EE_
x-ms-office365-filtering-correlation-id: 0847003d-905f-4456-4e08-08de59a7459c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1VGTTgrdGc1MS9LaEZhUGRJSXNNKzRoMnc4eDRHb28vY0FqTXdhVTRidUVW?=
 =?utf-8?B?MWRLQzJtOTl0UTBsaXdUSFN3b1FBZTV6cnF1SllXeERkRXNnQ041RHkyRlox?=
 =?utf-8?B?QzlVM0J3elowbENvYU05aE4rYVlrem1EUkN4ZXFnNWVuTFVUR1NTYzdZUTRK?=
 =?utf-8?B?dDRTV2tTTEdrdW90RnVMSXB3QTc5cDF4OEtuYTc5V1FWZUtZL3dUNW54RTZZ?=
 =?utf-8?B?Ykd1c1ZhRlB1QWFRZkEyN1EzYnVXT1NQZjNzT1F5eGdSa0ZVb3lqVW9hT2JW?=
 =?utf-8?B?U09FaTZKWXJCcndocWx5cjJrNlJPczgvaWE5anBXRENhVlBjMDFFTjNtcmN0?=
 =?utf-8?B?N3VVM012N2daVU1KYUdwYUxnMkNzTlJKVG82Y1h1eEFFU2liSlhkVmFWZmN1?=
 =?utf-8?B?YzZWWml2MWZIcjZSSWlNUE9iM21JZFQxTXhWaHhPREkybjh1bDFiL09CQ0VW?=
 =?utf-8?B?MUpEWE5xOElVcko5OURJcTFsS1B4Y05nREtmbW9XY05EbU9PbGxPdldQamZy?=
 =?utf-8?B?UzRiSlN2KzYwT1hjS0VjOUFMeWNJVU40NW1td0I1ZzFDaFRhaGRka3pXakQ3?=
 =?utf-8?B?QlZSemZFWFpSckpsZkIxUlJXUDZQNy96bTdWWGxLNm51S3IvYUFnYzVab3Ax?=
 =?utf-8?B?bzc5cHVzYzBwR2luQWN4TnI0Qjk2QS9JQVZmVm9wT2FaUDQxZFZnL25YZ1Z4?=
 =?utf-8?B?SzgxOUx6NFR3SVZqV2xxYzZUSjlGNW5YVnBGTndvWHhndUdsZldjcldkaVRC?=
 =?utf-8?B?Y2wrRndnYU1rc0NHbTh6aVdrRkY0S1BPaGY1bTBHT2J5S29CeXpYb0ZHdExC?=
 =?utf-8?B?dlF1UUM0emFWNjFOTjh0VG5BRlBjUU5sNzJGRldjclA0V21kMVNsMnhPS3c0?=
 =?utf-8?B?Mk41cGhLdWFaMUtGaXpUa05mU09xbE9VMXhNZFNvMVFJZmhzTkordlgyZmt2?=
 =?utf-8?B?cyttU0dpSUo2LzJOcDNTdEwzOHZ1dGpRMEhobWRUSGhCS1MvalpUTXN6SmRQ?=
 =?utf-8?B?RzcwVEpFTWVjOWRyZVAwNUJQeGdJckVyUU9FbHZOOGw5UStyc1d4OVJOWnFp?=
 =?utf-8?B?dVI3eGQ0R3VRRG1TbS9uTkl2ODY3Z0lhTWxzN2dlTWlIbGlvTEZUMVVXLzZs?=
 =?utf-8?B?TW9qT0F5U3RYOWE4cGQyb0EwU1pqQXlhVFVQTERoVVU4ZGZjNkxDZUtBQ0Zq?=
 =?utf-8?B?cnNjL0w0dW02VEhDRUdVSFp1TjRORzVDeFhqZEx2NTFqc1BhYitBaVUyOWND?=
 =?utf-8?B?QmZVK2FXU2V2QnFSMmdPbTJINE51bS9Ed2ROQVVpY3B2bzdxVjFLejJ4QnZ0?=
 =?utf-8?B?VVlsYlNZWTgydnlhZEFJSndNeVBEOFE1Wm1iMVlTTTZEdVlpZEUybzI5VUJn?=
 =?utf-8?B?TEtTSTd2N2xZWGxFTDQ1SGs1ZklxakgzTU54R3V4UG5BU2Y0U0g1amwwRC9p?=
 =?utf-8?B?QXBrOC8ydy9oVUplUE9yM0FaNVYvSjlRUVlzYVlyS2xYeGU2WWpTT1pnVTE0?=
 =?utf-8?B?cmhiRFFBQTNFL3BNZUhvZTF1SEcwUjJZQ0lSaWk2SURiRkJHRjErdkxBNXgz?=
 =?utf-8?B?d2h4Uk9uUW9nZEJUQ1dXYzVaWDVMU2FxVUVOLzJhMG43YnY2Z2NOcytzdDZE?=
 =?utf-8?B?cVJsNE5DYTBtZTlRVUFuRmtGeFc3bFdna1JmY2UxMVhjVVNCTTJRV3dDb1Fj?=
 =?utf-8?B?NXYyNGROMnJPci9XVnhvR0hYbmZibHFjaTB2SGdzOW1vY1p0cDVWZEFQQk9H?=
 =?utf-8?B?ZUNhY0wxZ1k2MGlidXZxdnd0anpPMk5IT28rZkUzQllVeXhSSklxc0NiK1NY?=
 =?utf-8?B?dFVkbGxxYUdydVZud1RhbVZMMkh6c1ZZZDdnaWdUVzFkZDlJdkZMcVd4Qkp6?=
 =?utf-8?B?Q3VJT1B4ODlQZmNaVTdNSWdSVzlvNkNqSGtEekg1NDkwc2E1T0dpQ0grWnAr?=
 =?utf-8?B?MEFnRmIrb3ljYnJGUGJ5UjY5WEw1L3RYeVBTbVhLejNlejV3R1Fab0pQaTN0?=
 =?utf-8?B?TnprTHlyYWxHUkdJbDhoNjU5cGJQUlV1REpnNlFwYTVtQXdtcVRVZXhXbUYw?=
 =?utf-8?B?YjJaR2pzc2tqN090c05TMnhZSlc4MEZmZU8wY0QvVkdmaE42SEhuSW5TSGh6?=
 =?utf-8?B?b3lrSkRNTmNZamJhbUhhWmJ4VTdqdGd4NkxSQjNWTzNWL0RJNDJtTFdLZWZo?=
 =?utf-8?Q?ecjupoCN7n2dMHlEfMOCdzQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1V3UzlDdENnTmViTTNRclVYTzhyS1BYNnpJdmQyTzJXbVRXZnFiVHlwblVr?=
 =?utf-8?B?dy9LOWdteE4vanpVcUQzQnRsa2RyRGJvVjBMTEJTVHAraFU5dkRqMHNZaElB?=
 =?utf-8?B?aFRxd0t5Y0J3MmU4ZGEyVTRDdWlUUFh0enBuelBIRmpmc1pFT2gwcHJKV2RN?=
 =?utf-8?B?b0lveG1oMGE2NzJaOEwzV01kOExRc01EUTl2WHZKaGFldzRqMzN6bTVZM0o1?=
 =?utf-8?B?azVKYVVyZmhUTmtkZTNqcDVjZEM5Ly9RTVF2VlQzMzAzblJjL0FkcEw1SVJ0?=
 =?utf-8?B?OVE5WHVxMStmUzd5WUhDbFJkMEZxTTJucE9rdzlDMkFKK1F5R0o4TTRIYllU?=
 =?utf-8?B?YWlWZ0FIUko5UG1rTEtXamJDSzRRaVpXSTNka2dSd1J4UVVPSXFDbS9BREM0?=
 =?utf-8?B?NjJ1NTlrY1dWN2tnOExrVHdWYUYzVHFsdFE0c1Bhd2ozamtSMjVvVGd3REZU?=
 =?utf-8?B?SkY0UmVuRXlIVlRZS1NVd1ZRSGYyUko5dktTMWxjd1g2U1Z2b3RvZ3RKNVUr?=
 =?utf-8?B?U1IyK0dRWEFqZk1XV0JTU1NwcHhjSllUZjFNbFh0eTBSc1hITTdsNVNzNXpY?=
 =?utf-8?B?eGxpaCtKNFZlZGFyd01xbmtvUnl0K01WN3Y5a2ZpMUNMN2NtVHU0Z1hDRjdY?=
 =?utf-8?B?OENGN1pXc0YrZWJyZU5iTDVHSVhSdDFURHRSZ3RjbWt2NlpiZlgxZVkzVjR0?=
 =?utf-8?B?bEg1dDJ5K2o2UUtwRENWOTFGTjdvblhZVE9mNVd4bkUxNDlzMWZYNnhsM015?=
 =?utf-8?B?Z2lSMVhmblgwK2pNODJTTXhWYzhWQWNCVjRlYndzczR3YnNRWWJ1UTdxUURu?=
 =?utf-8?B?WGlKbmhucGJlc3h3VVV1Z1JGNEVZZlVyTm8wRHhYeVhESkQ4WUJnUWhQZUE0?=
 =?utf-8?B?RzMyZUJrSDZHVkxYdlg5MjdOZjR4Q2VoUmdHUnNwU0c1eWhBT3pOYyttblpu?=
 =?utf-8?B?TE1VR1ZrNkdQWHgwMlhxK1NFbERJMTQ3TFExR2FpTjlmaHNlQTF4cVVVdkRL?=
 =?utf-8?B?b2pIR09DTHdMUVFwTStJQWcvRXNFRkFES3lLN1I4dWdIVjRPb0NnanpHNjJa?=
 =?utf-8?B?S04wb1FQQWYveUE3U2NScmlIOUxrRE8wbDg2NDNndkUvT0FsSEk2bm1LZGJo?=
 =?utf-8?B?MU5zOFIxV2pmazRWUTBkUEFSWEFUSFcyWURva201UWJWSWFkL09vZ1VpY1A5?=
 =?utf-8?B?U256YXU3QW55aUlIcWRQSWtwUDNVMlNhUi9xcUpaWkY1cHVCUGVva0hJS2w2?=
 =?utf-8?B?dzduWFlSdnBVcFN5QXQvVy9SeExQWGxSSkRxTGR1MnJWWk5FSG1sQkNEc3JL?=
 =?utf-8?B?RjN4NHpzNFQ5c0lCa3NRamVsNzBtUFVxVHBpWFUwTFFDZDJrZmhGR3lRbXJm?=
 =?utf-8?B?aGQ2ZHVuaWVka2t5QlhKaDVMV2JaOW5RdnpRVGlDdzNEMkxFNGxTZ3hoQU9n?=
 =?utf-8?B?VDRETjU1K0liZ3lsN0lBdVJaNkc1ZkFwcURHOG5WUCsvRkhIYksybUIvNmM0?=
 =?utf-8?B?cHowck91cUsybE45SDdvc1ROZ0ZUU2xtdWxNY2V0b0NVSEtxMEV5ZHdDSnBh?=
 =?utf-8?B?RUR2cUlJZjduR0hWeEpLNjFTMWR6VkpReW9vY3l0SmcyTzlRMDhHaUlGcitm?=
 =?utf-8?B?eUNiaGE2bkJpT2hJMGtTb2xvSnJjNDJDRkl3MFBKQVd1LzEwd1I2NHB4K2dD?=
 =?utf-8?B?UGUxaFozZWJoVWJtL0xBS1RobUtnUFdWdUM4Zmo1VjBGMVpKQ01qTk5oS2g5?=
 =?utf-8?B?OXZwUFFURy9ta1R3Y0xZdkZmeUFncDZCY0RZeHc4MVBVdjNnbUJ3a3RwV3JJ?=
 =?utf-8?B?VTR6alRIbTJxTmlGY0krRXc1S3FkUGtkOWs4SWUwWHdNWEVQMGY3ajhmbFNk?=
 =?utf-8?B?K3VKc2w4dVM4eEY5akQ4eHY0Nm9TZ1V1Z0wweWJsaklHdDEzczFabmpYTnEw?=
 =?utf-8?B?RkxxV3ZBS0hsSTIwWDBpTnNqbC8wZm9jaG01ZXJMcHBVUGlkODdzZldHb0Er?=
 =?utf-8?B?a01zK0hhd25nR1c3UHJURHhVdklCaUFVNmpQTnVIWXppVTZ0QmMwa0dyUUIw?=
 =?utf-8?B?NDdVaG5Tait1bXNuK3FNRm9QVDduR1V0Qk5nalBacE5QbmJIR2p3bnQyNTYz?=
 =?utf-8?B?SVRqU1hCK0o3QWhEbXkrR1VYSHpFM1N2SXhTSGJRcS9JWGZaUkpZcmIyRmhu?=
 =?utf-8?B?d0dGWGRlaXA3MXZsQXJBZTF1bFpzbWJabXRsSGFiZ3h5UVBCbWNHN2tFTHly?=
 =?utf-8?B?VjcwL3lHMHlhWWsvNGR0VGRuZlNwZnFwUHZUZnZ0U1BtY2lTRlAwU3QzanFv?=
 =?utf-8?B?STVnZXgwSHZSbDljZE51S0NjUEVndWVCOFBNd21WZERLR05sa3NOQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <540ABD4A75F0A34A989148F4ED696E45@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0847003d-905f-4456-4e08-08de59a7459c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 11:13:29.4901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7+HwxIorUWDT7xHmG6OrE1omgQa4Qt/ORJ9dBMYtQEUlZmHXiA++Tk0tdxBDh97E0tfEMXwSxmsuUApd0s9iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15882-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,nvidia.com:mid,nvidia.com:replyto];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lwn.net,vger.kernel.org,gmail.com,kernel.org,infradead.org,nvidia.com,resnulli.us];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 3BE9E660EC
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAxLTIyIGF0IDA4OjQyICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAyMC8wMS8yMDI2IDA4OjU3LCBUYXJpcSBUb3VrYW4gd3JvdGU6DQo+ID4gKw0K
PiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGRldmxpbmtfb3BzIG1seDVfc2hkX29wcyA9IHsNCj4g
PiArfTsNCj4gPiArDQo+ID4gK2ludCBtbHg1X3NoZF9pbml0KHN0cnVjdCBtbHg1X2NvcmVfZGV2
ICpkZXYpDQo+ID4gK3sNCj4gPiArCXU4ICp2cGRfZGF0YSBfX2ZyZWUoa2ZyZWUpID0gTlVMTDsN
Cj4gDQo+IFNvIHlvdSBqdXN0IGlnbm9yZSBwZW9wbGUncyBjb21tZW50cy4gV2hhdCBpcyB0aGUg
cG9pbnQgb2YgcmV2aWV3DQo+IHRoZW4/DQo+IA0KPiBQbGVhc2UgcmVzcG9uZCB0byByZXZpZXcg
YW5kIGRvIG5vdCBzZW5kIHRoZSBzYW1lIGJ1Z2d5IG9yIHdyb25nDQo+IGNvZGUuDQoNCkFwb2xv
Z2llcywgaXQgd2FzIGFuIG92ZXJzaWdodC4gSSB0aG91Z2h0IEppcmkgZml4ZWQgdGhpcyBwYXJ0
IGFuZA0KZGlkbid0IHRoaW5rIHRvIGxvb2sgYXQgdGhpcyBwYXJ0aWN1bGFyIGJpdC4gSSBldmVu
IGFkZGVkIGEgKGZhbHNlKQ0Kc3RhdGVtZW50IGluIHRoZSBjb3ZlciBsZXR0ZXIgYWJvdXQgdGhp
cy4NCg0KV2lsbCBfX3JlYWxseV9fIGZpeCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpDb3NtaW4u
DQo=

