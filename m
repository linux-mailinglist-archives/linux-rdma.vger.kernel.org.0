Return-Path: <linux-rdma+bounces-12225-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F81B080CE
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 01:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7F64A2F95
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 23:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68842C327E;
	Wed, 16 Jul 2025 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qj3UplHr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2024.outbound.protection.outlook.com [40.92.21.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9F33FE7
	for <linux-rdma@vger.kernel.org>; Wed, 16 Jul 2025 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752707084; cv=fail; b=pZnfl76TRemqVWPMPgbL6v6upxQKs8e9QWUQj5iZGScCvYdaqxptwBwblPmmWTeVCuTJhKSn5IHMkStzODVD4GTmUdUZ58gXft45sL88asfqgy55DtuD0Tuwm97n+Ex4qEpwIkHFZIqo+toCA6Ny4vHwEpzQ02+qNS65A57BC0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752707084; c=relaxed/simple;
	bh=4X2zSaDBKNrEZYSm7ywxaysEIW/1CSyWwIYiiQumWFg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kweWL/7y0A87tyBqGoZmkKHi0/leoMmh5yG9IgiixE3to0WswYgO0ILe63FvlpKVpyY/183OyX8Lg7uADPT4p3ONkJbmevAYVh1/tntUedeh0+YiQUkVJCIH1jgcP1mb8xjS1U7NIe221KmMPQQVsejNPcJtiu5CWBnyGXe/CLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qj3UplHr; arc=fail smtp.client-ip=40.92.21.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUHXynHow+FGgw+Rxw3//3BxvMhWRJfIUmAgW4mECKJSZL313m7g811RVgYZi1GgCcIBfe4ObwZ8j36B6EIpma8fc0+CkrBsw0cv1iQIomTPAZ5bGv9ovpXQiTmDX91AZJXDGgTSwwb5P0rmJkZKupVDPPYjd2p1r4R4ZNrTlwqCDpImBWLFeWh6N+/8Ycc77UwIJzvrevXlq57iFZ5N3zDW0Wrd+NilOdqP+PtUp4YKtIT0x8Thi9gtOQrpPgR9R0ZoqUkGMCPVgYCqP/gk/qiPGnvTnv7ZbS0gHZEpVQOEAIvSdqmXw/jzdcltukUnQm14WpXF1wEIgED1njbXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4X2zSaDBKNrEZYSm7ywxaysEIW/1CSyWwIYiiQumWFg=;
 b=FFZdy9p659wPnE/HUQuDJ2uGPrKNicFMy7YFFJNg6+VCm06beoJD8jekH4htWORtGxP/4H+lIff1ujO1zs73Lu7nG/1bDdGfX6mn9353b1/NSAPLmjLThzq6bG/OWTDpzz3hXuz3uUXFcNpzSpZY9s1xyocUp/7H7VHYfpqQ3OxCPb/g3+awItETwV8bRA+0arzT48iDja0QXhDMTBQomn3TTaBCmui7LR8IMUEBy5s8gC7uG3LvOBCX8zYsn+pAeKbgBFRHNMJrJQ+sTOYkSn93I9ft4axgUN0WrdTu/MkkLRyHfiwVCpE3IeopEYd5MKjpV/IdeZLX1CfVvz0rAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4X2zSaDBKNrEZYSm7ywxaysEIW/1CSyWwIYiiQumWFg=;
 b=qj3UplHrNxfTCtfjm0Vtox5OYeNFpy08tdivfx5WfsvCUz2KqwWqWqny7Rgzo6dHh80EmY98zV26QTBAJpYXX/2DJrLMqGgv4D3Cm52yfQHjGv2oovCZuAcckyS9kX26wS4OajhE3IChX+EYSdH0fdb3JDQDGN7aq+0xbkWubwuOwxG15aLLRMATnat9BP2iegzL6NchpqzXYqyPM/sOS9L9wjT2ZVkLEJDjSnjTZyetnXv7jgoEHmjymEe0qvGzIAwrOUJorX5OnlhwZ3g/qY0oqSI1+togLNao47NOwWyCLUgIsqHWMeMfUWaWL+rzMb7NjFbFanO3KaU4ogY9KA==
Received: from PH7PR04MB8924.namprd04.prod.outlook.com (2603:10b6:510:2f8::6)
 by CO1PR04MB9580.namprd04.prod.outlook.com (2603:10b6:303:26e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 16 Jul
 2025 23:04:39 +0000
Received: from PH7PR04MB8924.namprd04.prod.outlook.com
 ([fe80::9f76:763d:22ce:b166]) by PH7PR04MB8924.namprd04.prod.outlook.com
 ([fe80::9f76:763d:22ce:b166%2]) with mapi id 15.20.8922.037; Wed, 16 Jul 2025
 23:04:39 +0000
From: Brenda Wilson <brenda.prospecttechconnect@outlook.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Build Stronger Sales Campaigns with Verified Data from GSX 2025
Thread-Topic: Build Stronger Sales Campaigns with Verified Data from GSX 2025
Thread-Index: Adv1DPj5S9EsERUnSJSVkmvSaVGDiw==
Disposition-Notification-To: Brenda Wilson
	<brenda.prospecttechconnect@outlook.com>
Date: Wed, 16 Jul 2025 23:04:39 +0000
Message-ID:
 <PH7PR04MB89241CCB972F5D832806E48F9456A@PH7PR04MB8924.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8924:EE_|CO1PR04MB9580:EE_
x-ms-office365-filtering-correlation-id: 2e077f7f-484a-487d-4862-08ddc4bd2450
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|15080799012|39105399003|440099028|40105399003|51005399003|3412199025|19111999003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QipGlm6h3NfasUwr5SCIgfH6UEtqjghvwaLjciZHL0p1xZVjjdiz9Cdrzt?=
 =?iso-8859-1?Q?50iVH5SKx4ZBPt2mzB97YkhguVfqbdUf4fRrCD/ezTbSlIfqceWj1Z2CyW?=
 =?iso-8859-1?Q?U+glep5wpYvOUZ7vuZcB3nxKPMwnxhtAN+PhXcomto4whtwbnh0nzFXyv1?=
 =?iso-8859-1?Q?S58CdwoEW5lj2SeueKmHfdNHXibV/biTh/6IE2FRDA969bH+VaiMMIT4da?=
 =?iso-8859-1?Q?QoIFR1Kk6CbWpRLDYZF5WM8qkR628kaEgczYQwlYK1+xadgJqiopmQkL7Q?=
 =?iso-8859-1?Q?id2bufeXfSM41UraSEsU1dsZcsgGIjpbJdvOI/+65UlwftUt3M2N9AbBZ8?=
 =?iso-8859-1?Q?xd/E+mhb5AQcegooWUCV0zLgnFwV4lf1LrudmFQEYGGvrC06ijNC+WRRBS?=
 =?iso-8859-1?Q?IUP53lmg3gp1S/kS8yU6eak4jCMOlJMZzyvWCdVdkDWLfWNnWx29sS6eCj?=
 =?iso-8859-1?Q?FSX+ADPc/ZIAHfm0Gkb47GZd7CXihipUwwOudje6GZwOkfvepCuzgLSFFX?=
 =?iso-8859-1?Q?Q0USLQpUGOxZnE1PwaG7o7S74GBErNILVGp9IieZpPnozW2b4qrV7glUuU?=
 =?iso-8859-1?Q?2vZ4r2IaxOx2zyF8I7eF6PNZbfJukMd2vA1u/NzTUoXWjA9cGuiY/AAojm?=
 =?iso-8859-1?Q?ulScrtC63uHDUzhybic4JbGyWY2HLHTNO+Upciw6WfHWawdPj3C4E4BIgO?=
 =?iso-8859-1?Q?ClFD7ZP/Q9UheCVoItCb9eSzn0x6U9fDybzF5q/Z3boif4dX1feFGy9057?=
 =?iso-8859-1?Q?/owvgCT/cobKF7if4I2EKC6AtauLo+XybaIqprURuuXZX6Px5e+/lM7Uzz?=
 =?iso-8859-1?Q?vP7HCQ3RRwQ1v3J0B9uI9+zBeBlHPanYq4u+XXtyR12WmedX+94rg9aqXP?=
 =?iso-8859-1?Q?QEfP2VjMd30Q0g6UOfzqtHjKnkaEw/toyQU+ry/RA2Pc0Rn868p1CCWfWc?=
 =?iso-8859-1?Q?f2KfyRAz/73BkakTALaqQuJnx9zbNgu38WQXUq9ixmVazOOe4YQdqPn87C?=
 =?iso-8859-1?Q?OvkvKl6O5yWx/t34+V2AbDrhjN3N2ns7jrbQSWepfXnBuEMWepf+GX8BY6?=
 =?iso-8859-1?Q?aCACixcpy41w18Z+SPjbsLI3ypwMk3bkSyygo2e+baPVp1sKWrxw1uD3Hq?=
 =?iso-8859-1?Q?Ro8sOEk6of/+5i3AQgFT+Msff7uvfwM+GYBhXWLqzqN2qBHoTit4/Ik1zj?=
 =?iso-8859-1?Q?XU3ZVzdVBiOfFA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CMtE6a9ZdRq45XC5LyB67ZRS0iW1EA6OdTzc4nRRIosFFZIEQdKPU8EdfD?=
 =?iso-8859-1?Q?IHAL5nu7PQ4WHsQo3p+lOdjMUCasMnHqU4pXes31tY1+oeLgFgcEqWPMU9?=
 =?iso-8859-1?Q?NcOasF9/aemMsBp505nxye8+CgTAa2Zu/3i99q/RBZR0XO7guUNm6zduo/?=
 =?iso-8859-1?Q?3lKfjAk8qW324RXAPogwU3Yq7WYiowpWoa9SzVXsP0o1bFTEli1QJaRO3u?=
 =?iso-8859-1?Q?BrVyISi2N1/fO1XfKJipxuh3nI1KkjQCryipYxVtkZasefxF/P+DElT86l?=
 =?iso-8859-1?Q?R2jh5pk9B8xLtOQKNa46klzbpVaoNjvqdpJIEUDEsF2/5JP5v6IZ5Nog/D?=
 =?iso-8859-1?Q?rRm89xwsaunwv3mRDCcxtsQLTGue2pn4BVcAq3wHG93An4KjJtfLg5f9dB?=
 =?iso-8859-1?Q?isUXHSJDt3hi2QWlmM8F8MRLsGhaYlBL6KPpzRzEmsPnzn+yWTr2QZ0x5u?=
 =?iso-8859-1?Q?b7v57+nCPgg3ZhV0tJ5A6clBQRrl/RnE/OKXAkaD9P1aSH5ek/3aAN+VwR?=
 =?iso-8859-1?Q?PWb+Mi0qZDQIrW1SHt9O2DPoKX+YV24yk7Yj9NTPumnfZoqxHWiyVn1LOn?=
 =?iso-8859-1?Q?A+BveBw30QIGhZkrm2k1fN4ERbqTOarYFHIDGiu+gRtAIiHdmee4gStmxV?=
 =?iso-8859-1?Q?z66HOqshgahtm+ErYEqeziq3FwBLZV6rzoY8+g9tQies0j/xVViNsfLDA/?=
 =?iso-8859-1?Q?UeE+Lnix0a6+F351K5DA2Pn+U7uEX4pKQY42I/5foGi3WV9CLfEIpVWDEu?=
 =?iso-8859-1?Q?NgodZ1IVDRJ/N5tVsZCnSWsqLPqeUl9xUUIuSJPFSwwhAbNfJ1QH+M3TP8?=
 =?iso-8859-1?Q?qpKBBf8sAnBYAuZ4GxT5V3SoiF1agL9QCU5atlod0OVzQudln5lu4B0Cvj?=
 =?iso-8859-1?Q?jiS1YJVZU2/vn3WG9WSaF+1tWeamEUckZ2wxNXn67Mp0wPjBy5JQYa6Ab3?=
 =?iso-8859-1?Q?y5FsLqq6xJannJKBbbfqB+pi3g2E63Au1jZIIhdVcBauKFPkLLk42rjjNn?=
 =?iso-8859-1?Q?JwFUcDsu3roJuqXg5jxfqwLWiE94wnmM2qwwoZu0UNNzbIT6Ll/36YQowp?=
 =?iso-8859-1?Q?g6LaBy033VVGgZqm1kn7yYf23h+RVtMIudbCuu3je31ngM3vbNsLbKockn?=
 =?iso-8859-1?Q?rTmQVV6Rn93VDs/N/KmWRXVGwjaLCCXKC15oWy72cGMxHS4caZRSZa0MM0?=
 =?iso-8859-1?Q?ax3WsPzZJj6qlDD2DC0sXsB+VQFzQqcxy2svbEia+92JGa9Q4M5bmJRldr?=
 =?iso-8859-1?Q?akEmT/TLb5NxVSpezRL/JXoeyacMdTqsceaEJS7eIua09gZ8U9rEnHOZcs?=
 =?iso-8859-1?Q?Ej6ZXxbimDCvEQ2S2njcOS7sQefqIThvlLbUXM6CGZ3tFV9TBH1kriux8W?=
 =?iso-8859-1?Q?12NnMkJa8w9UJ1GZNS6cSBX6da7+DYpA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8924.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e077f7f-484a-487d-4862-08ddc4bd2450
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 23:04:39.3394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB9580

Hi ,=20
=A0
Are you interested in obtaining the GSX 2025 attendees list?=20
=A0
Expo Name: =A0Global Security Exchange (GSX) 2025=20
Total Number of records: 17,000 records=20
List includes: Company Name, Contact Name, Job Title, Mailing Address, Phon=
e, Emails, etc.=20
=A0
Do you want to proceed with buying these leads? I can send you the pricing =
details.=20
=A0
Can't wait for your reply=20
=A0
Regards
Brenda
Marketing Manager
Prospect Tech Connect.,
=A0
Please reply with REMOVE if you don't wish to receive further emails

