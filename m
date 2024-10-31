Return-Path: <linux-rdma+bounces-5643-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4549B72C3
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 04:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4A31C23D66
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 03:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FDA12E1D9;
	Thu, 31 Oct 2024 03:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fJ0TDmSe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FFD84E14;
	Thu, 31 Oct 2024 03:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730344470; cv=fail; b=qXMJj8gjPnec40ORhx8sxJc3YxyqwjHUmeRUq1wHPuFUbnXdkK5yWI1Zh47XP8L4R6lFXH06/0RF8MtAfi8682PCQbw1uMK6Q67xJaqAUX+mjcWd94+sHl3nYIn7rP+56mSHITLjiOlLiP2ZeYoM4fJFJ+tyh/0MBs7tQEljALw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730344470; c=relaxed/simple;
	bh=5Psc/UM7JKc1egducZZ3szZYLVuKUqgC5NALUUV3KCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ol4z+mxtkVhSmIE6a4PPYRgv5Z8NjyCtKcj81ejVq/pss8GVPvBx3hEtglBr6np5Q9Q8SKkzvguFMOs+gVQjG7CQNbxuTRnhvpnwcTEcDjV5tUYCAocICzp2S/QOFowjMbej6EDPlboD+/7xQkNb+xMFXhhVP89rkuQCb4eJ7hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fJ0TDmSe; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDUh6h62HIiqBIiZXcK4jtE97ByBkTDPFmVPcm7qMTlR91yzQ4PML21OFxhs2xnnofhc7GYCseJSPKBJLI1xRgQ8ce31N8kO+t+JM6/4OU0yTE4PytsE0VQAD+4ZR1dThXbtKcvthdxmhb5BItHH45xvysTcqGR9FUZoVpFr6HydheRsHLIyz1Zz/bJIT8NmW+zt2t0oe8Lityh5xl4OdQjsO6YQ6pxaLXAH7JXDNjmaVKT7axRV16xvtYylk/PCULTD9U0bp9KOEE7CdRxzT8D9rNQuakQOvT+N7qiyfkT2WX2caxvscUoeeRAiHdYCvUJMZjGDYC1gdfPq2W683Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Psc/UM7JKc1egducZZ3szZYLVuKUqgC5NALUUV3KCE=;
 b=Edv6bV8K1aRJYy5FBOV5rgUq7EQpGl7QbNADei0Mpi+IJ7kZxo7+C9TVuMeb5abspvtqs1I3zXcvVRhutESFTOqGVg7TPQQ6m1ZpzGtFc3FN0wkuoT6jpiHWCQ8wlzFpJ0DOLAxrlUvvu8yWSPxVR9mXF9z3JS6DA6eSwsiUlVBQB7OVNEu3QnfPhwL644IA7+eoCmTjjOrqBSLLZBg9PAfWTkXQ/PAuCikX1lQNWIL9OkHoz2aLZ8k95pRaAMAVmRZkJkYkbXRZzJePI01ZUMgNTK+/QWa6q6mb/ALVem6xDusdiAzu1MNDdqy9Y011wAUjloo6syCxzRScWxh8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Psc/UM7JKc1egducZZ3szZYLVuKUqgC5NALUUV3KCE=;
 b=fJ0TDmSeUD9Hdif++F4/SQoOU77FDG+N2Gs9aREDkHDZrXh10mlvx5cH83A4cDk3q/njKh4dXlqC9RWySIdK0uFrQI2dBTR6d8OqecTQoCnQih/fZQMncgtiDM0bNPzi8uT6grr50dEaeFvSGG7rZPCDXcZDYSkMZs4iWVhQqhlKtCAgmDYxZ+ZffxOLD54+uokFPYXvaDoBa/gHuDyO5uczjfoybpecQDL8jMCQbEuUS4BivAUCrO3Cga3klIkndCIXaeDU3Ir6i02ZmVMeR/v2j6SN3QK3xKH1QXjjH4zq0lWFhUa9oLz8I1BZd0b0bsV1xCuoeuch1Vd7wRb0Iw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 03:14:23 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 03:14:23 +0000
From: Parav Pandit <parav@nvidia.com>
To: Caleb Sander Mateos <csander@purestorage.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mlx5: only schedule EQ comp tasklet if necessary
Thread-Topic: [PATCH v2] mlx5: only schedule EQ comp tasklet if necessary
Thread-Index: AQHbKu4w+1dB68gvf0yqLGBjEm11EbKgL5Ug
Date: Thu, 31 Oct 2024 03:14:23 +0000
Message-ID:
 <CY8PR12MB7195C97EB164CD3A0E9A99F9DC552@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <CY8PR12MB7195672F740581A045ADBF8CDC542@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20241030170619.3126428-1-csander@purestorage.com>
In-Reply-To: <20241030170619.3126428-1-csander@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SJ0PR12MB8116:EE_
x-ms-office365-filtering-correlation-id: 3254cc1f-4737-4751-613f-08dcf95a1e8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UhfjhiE6x1BEzTUP+aMVzba9qvMseEZN3OrFzlz9bCCTy/PT7e0aOKnwiNdV?=
 =?us-ascii?Q?cRVIw9ZToE7+aJrIkqpeG3rMLJ2DmvzLtqM4AXZjxPgX+dCU9q0ZRvW6RNiD?=
 =?us-ascii?Q?Ejn8jN6j+vvTQs2UVjsL74GGXSPLw93amF8TduWvWfgoP5PRTeCRh8Y6IMkq?=
 =?us-ascii?Q?ABs5g5G5hdD1IeJw6Vi9DFzmJDBiKsYcNCf0vWA42NFsqa1nGQcBLMEctHiX?=
 =?us-ascii?Q?1EyacZHoV1/tAJo3S5QMc+HNdxy3MuVosApraFXBZo0hPJWqp7GOTAToC6/r?=
 =?us-ascii?Q?dagRq5o8pXpnhr11Lc3neDBMeki1VFhYk5L/wougbdcXSuGjoCSJPvargCMb?=
 =?us-ascii?Q?pADr/4dc0v1zPM5S/hPiFC3drCobBw5BKUepAxfgQtU/GECfg7KpMgc5CQ8S?=
 =?us-ascii?Q?oBNudRn2KMAg3ukh3HMArZvgnno4AEB3+2E6ceqzGhdbMjyzOaAQhPcgJGlD?=
 =?us-ascii?Q?TjklPblqplF6TIFvdhAsZOW3dKEX7xDrwNZwZJmnYDQwTfAPepOyAHvd3xeJ?=
 =?us-ascii?Q?kYIJEd/IjE2ylDC+P2+YjJvymo4zwOtDNj7arEjsoGO/9FIq2CF3p1hHR7GG?=
 =?us-ascii?Q?PargSkp839PaGy4f3UA1rhxicmx2SHLglmTeRQMsFChtzE3EAJrWfEwMchhR?=
 =?us-ascii?Q?icehUzQ0lcM1VgC2vV18m6eTNje+t1muUBqESzEomQqcSdi+klXUvqAEvsOI?=
 =?us-ascii?Q?4hApdtehfTXqnzZ3oRmarG2mxMM0/8sewPfGW9LNjVDvxGAGRW9GW+tyCA65?=
 =?us-ascii?Q?N5WFXc8pzuCLhdcFwdVEXHC1thLcRBB4/ql45LDU1omzIlKbHEca/7oreDfm?=
 =?us-ascii?Q?KHHYtkvhatjFweWhNIo7my0n8ZQQR59UzSYQ04qeBzzRQUP21114AGR5nW2t?=
 =?us-ascii?Q?9VHdiDpGDZEJrTuJZ42OROG2y6rVl8WY46wwWbyn0NLrZO+98bMxgVgEkiH3?=
 =?us-ascii?Q?qUnCJeNL30y68mKw5NN2XJEhVHDXu5IXM0jn9+QjGnD/KYvYfq1Lj7z7BPcC?=
 =?us-ascii?Q?t4hz0B/fEDk/1NQy6V+1OEtlrGrjMsX+B9u6FltFXdjhfblohhuBXQFczYVc?=
 =?us-ascii?Q?VRb3Gc9DauBZHZtE7wvom7o+ZYS1p5fA9/ZmsKrMnw9YqMpTgdl2zRrYXqdW?=
 =?us-ascii?Q?jHt98Qd2vRoNBrTZg9iQsKggDh1h1TbSkEaKOp448nJ0XpR0egeH0Dk/G5si?=
 =?us-ascii?Q?4atQx93TShRcWeqHibgcPMls41nxNCWEKzDidPpmQ3ANc3eIKOshVYvZBd7v?=
 =?us-ascii?Q?hNYmuN+QslAFsAii1LQ79W8PsM8ImE3yuWccNb9PJyweikGzUlH4vSigpRil?=
 =?us-ascii?Q?6XMQvL5QCCD9vTxoOXoEpW6ufkgvewXFE9WiUNcIHzyjdfW0wqaH+6b18EpW?=
 =?us-ascii?Q?nBM4l2c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6YG7y4CCQvjCk3M8dtZiQSGevSz6NvmCHrErgIiU2uEP+PDWVI1cMtKSAF+o?=
 =?us-ascii?Q?ZCKpwtJJOU7L+2oWZ8kifm+kHxDcKAIFV7CTsn+NybNxHTPcED1/GxBHquf7?=
 =?us-ascii?Q?YyAnT9Z3sYpiYwzYpL0dCqfI+dDXWOKkSNmzqeA0RH0vKKv82E8rTV2SQ7q5?=
 =?us-ascii?Q?fp6oziYDhxtJTezEASY7hUZ3eQW20DQ5Yl2nt9uHBKvlPvgGQYYVwJgojKcm?=
 =?us-ascii?Q?v5VNgtYUgUoGb9Cluj3fBtJ+wUu9AesSLlbriOPLexNrvvA79h9pGMpvuZYW?=
 =?us-ascii?Q?rSyRiSUs5SiG0rkJ4mspvIis3+j6Vf9ewBipjpUH/J5tVHGNOd/TCLO60fpw?=
 =?us-ascii?Q?pe+dh+QZjZbAiVNTwKOTYzAQVuiRMmgzxXij+1fuXT4gdtFuCa+elN9nKAI6?=
 =?us-ascii?Q?BlcOtSyAfe4gbBVzFO5WXSNK8b0tSYsnbT/Q4B1XX5tDn5QPRUIVKH2aTFPh?=
 =?us-ascii?Q?siUvzK8/kVJtZX6I3UWGexXMWv72IkksHzwsXQ4S4tdayhxwbb4DMWRhrMPZ?=
 =?us-ascii?Q?WbnTJqifBRg+sGq0KPhi0KFYydi/K1P1Hou8QqX6IO2Ts+LxiVXoxDOB3LOS?=
 =?us-ascii?Q?4LqIqNwUVg9FtleZ/GhwdsTmZWGzeutIr4k+cEdfZCOFbeCke+XCaVK06Ilt?=
 =?us-ascii?Q?JJw7dalpth9UQ6RPBYSTBbNYt2TJMiGJ/0/UrtbyxbzZWGxx8RhNXeGJjE7h?=
 =?us-ascii?Q?OVQ+DBvvAURXkff/fHxwAvfC+U7nMPQnESN79S0Nc3gZ48UDgWmxi/7k0+nc?=
 =?us-ascii?Q?1FzRKISfwDO+I0AezRWLeGZdV1uJq0VVQOjTgFaoGXhBF7mPNbmnIyaK8RIX?=
 =?us-ascii?Q?9sJ9iNg9znN+1DmWM9AFl9mU0SbHS4czTou0IIP1ACRtHePfskGwwpxmpq1R?=
 =?us-ascii?Q?a5i9VZck5RMyxdaZ572OaldKsSoNrzTpQBlt45Ez21ZC7Q7E4ktg+XAgyhUV?=
 =?us-ascii?Q?hI8EPJp2n2liRNaTgkO9vTIfdT01BP3TLveZVWotZlKGmy6oeix5sUeSPH+o?=
 =?us-ascii?Q?tenvd5fXmy+qTlmhQkEaxY55C6nKu1kOnlhWErQpBJyZlwJOswFLu5Vj+oio?=
 =?us-ascii?Q?3f3Xe+31yXmEGCl77NrKep29KPVzNASC9MmSAtHWFgpyYXN7Vj0YyylzO+hr?=
 =?us-ascii?Q?lIEQsRp8kN+HRWgCclZ/hR22DGXgyeFLarg2T2Al14Pr6XH/Ye6JDtE0dl8m?=
 =?us-ascii?Q?qxS0cNkPsFsMuhJgfWHktm/jg5eRGDK+hIte+KEPx3Q9Wn4pMXmWUPxKrwPV?=
 =?us-ascii?Q?eUiC8MCfH6CuxvKxN1nGfN4GTs36Ty6i7rVF9GTjhEHOlONGfwLYluaouotL?=
 =?us-ascii?Q?FE9KuX6d7W+hJzgggW+j4UlxjBu9uYQvFUOV8WczOResSU/OSAwzCrIrwENj?=
 =?us-ascii?Q?2vq8nJTi+7+AMcquSYXDUjbHa3ekgnIv23f2RZdXh7fxnCL6iEgt7XnqO5xc?=
 =?us-ascii?Q?DaP7ISM1kveG6qegZhAPCVJJaoAp4DcU2A/Qkq25g9cssF380cGOZaY2Zp7P?=
 =?us-ascii?Q?aULZZsMZJVchfIGKUC446/ezBMOO8Ltza8Dz/irn3HbI7RpuRG9uffeF5EdK?=
 =?us-ascii?Q?kJZhUPZ4pJwg9jrt4EI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3254cc1f-4737-4751-613f-08dcf95a1e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 03:14:23.4407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fS4w1uaWBydgVvQ+MGflE7QlUuaaPfhRsPIiXYqu4VP++QIAz6kw21iL9KIGp9j7LtdtDJrqlZCVwlBwNR2kLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116


> From: Caleb Sander Mateos <csander@purestorage.com>
> Sent: Wednesday, October 30, 2024 10:36 PM
> Subject: [PATCH v2] mlx5: only schedule EQ comp tasklet if necessary
>
I didn't pay attention to subject in the previous review.

It should be,

[PATCH net-next v2] mlx5/core: Schedule EQ comp tasklet only if necesary

=20


