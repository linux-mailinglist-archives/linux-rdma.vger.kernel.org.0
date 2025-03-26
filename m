Return-Path: <linux-rdma+bounces-8979-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E67BA71A3F
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 16:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27307167C53
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 15:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45661F2B8B;
	Wed, 26 Mar 2025 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="impbWJ+G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21801EFF98;
	Wed, 26 Mar 2025 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002946; cv=fail; b=NTIgQpqLl+MvBCCNTvd949Xl9bwSAfarR0ItZR//yNdDNmnfOogMbWe2NwPUaxX9gL1+S83PkWBU7HhyyNBcM7YKVMX0k2393Ihq8ZHWu0WM/GLi75Fy3Ai7bXssYwes9ouKadRSLlKQTdz+RdJc7aZ0ea2+ghUVx4EjujmHCPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002946; c=relaxed/simple;
	bh=oBq1Uo5SYGze1zITaxmRUr1emLQtnT2DFylcmUF/Gmg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lu3EoewubZYIredTjrxHCSXgdkR5ZSybJM60qH9SDGFtS4iB1n9mcSc0FrckpmukH/PMa+gNHYsGIP4VaQMUJ4ySKmbyM//nLNj96ZH49hR8JQ/dwuXD4AHpicMglBbl13kSPLaF6jKbAYkP1pwvkSvO38shvZYNdqMHCqLR3gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=impbWJ+G; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGWLvhozi+kBaxvrhAjwLYDDdeyhX3UpPNrW/4SkV7B/Ti7k8lEnrFgV6yUum610Ipr8gxSbLfkmRV8/1J6U6FENLUTDb1JUANnaeVtxDmQ019fsMshAEYIP+L6Rkf6ejIqX/w+Z9SBQ7Zx8tIbmoSZrEUJQpyWi0Ie9s8XDp2N2S0/ydjk1Mucgxtjuz723iiwRTnJwukJDBlGRYmm7TF8UCrM1chj/84o8BE/EggD7+Ekb1zCIjkEwJzwFLfDCFT8cMxCJbeE/KpiJ58OAmFEvm1RZbH9NGf27F3Z1r3x46OoEIxXwf8yvJDqvNzng/sNkbkZdBYTeVpzAvLp+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kJxocJkX6mofXGe0w5e0gIeVvQK3mdqtabvb2zZ9fQ=;
 b=Fm+1ymTGk8hYSRS6ENUb8qs8LVR7nQmmOBWO1kunKMsi71ijfmFH7ec0XnCcyovT80jNjvVGDhQdMsYavmiTa2xd5wjcbO3oosllINR55VKhT6Kf5W8QJUCouPF4iPxSed7qFJYJOVPBohPwMKPVzebsgbywlWlmePc344KPDqDG5G4YxHH5+LdmUtLnjNN8+6W/ZIKTta3Ilc8XsVXxUK3e2aSnoUQCNlpg+xfKMywe5Ei1Yi1z6aTIV88PtBWOOJWHofAGeYgEz/3dhsiUWt98EBnC1hpGd6O4/p2XtljHwQ2Ol5ad8gmuXG4ybzDX14RHfw5lVLIQvuatul5NRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kJxocJkX6mofXGe0w5e0gIeVvQK3mdqtabvb2zZ9fQ=;
 b=impbWJ+GvSJ0ePcqoM7AzJvYPGY4juLm5lvkBlinszZH1eUalsxaSRG7aEiTmIxsb0FLMQegzkQGzYPQZOk8CLBDj07ylZBv/ciLyfk4vN8Xa0mcxpQZG0e0xjJr4y3ndH9rQZl9YdFgcxiO6f9JUxKz0BAigOXDclHk7av0kBBe5tNphorU8Q14CtN7poUfvbgXAbq9a/yvlcWlwpB6wF0XCZuax2tJJ+2XbtLe61oSTvMxsa+9JnZmE5LUwZ2mUhoGRUyzV9Z0kKZzAGrWjRaN7wD0NxRE6shGTOP/kW3YbCBqEX6tqlfdbe+BT1aOLRGC5Vv09UuGKblw0IW09Q==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 15:29:01 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%3]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 15:29:01 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Bernard Metzler <BMT@zurich.ibm.com>, Roland Dreier
	<roland@enfabrica.net>, Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "shrijeet@enfabrica.net"
	<shrijeet@enfabrica.net>, "alex.badea@keysight.com"
	<alex.badea@keysight.com>, "eric.davis@broadcom.com"
	<eric.davis@broadcom.com>, "rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "winston.liu@keysight.com"
	<winston.liu@keysight.com>, "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>, Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>, Dave Miller
	<davem@redhat.com>, "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
	"andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index:
 AQHbjuwVUw9AWIkXnUa8bbJSM0sPK7N6v4MAgAgXf4CAAAnsgIABEwYAgAAgrcCAAYj9gIAAAVBQ
Date: Wed, 26 Mar 2025 15:29:01 +0000
Message-ID:
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
 <DM6PR12MB4313D576318921D47B3C61B5BDA42@DM6PR12MB4313.namprd12.prod.outlook.com>
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
In-Reply-To: <Z+QTD7ihtQSYI0bl@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|PH7PR12MB9222:EE_
x-ms-office365-filtering-correlation-id: 2c82c013-5d03-486d-a742-08dd6c7aef60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?O6hE+W7tx5XVnGoc+8j7YE+9gX9h3msSTWUx5Ux6OrBxBzo5ulk8rRyTYcUY?=
 =?us-ascii?Q?Ma3k0kg+cAZGgrEHGGvJZ3R7m+idJE+oUfJqhLbN0HW0j6nyRruGvUXtMmh1?=
 =?us-ascii?Q?A1Ptu5h25pU0ttukgahocDUrXjfZfcGJ79DeVxuu6js06LeIMXlRFqspCez9?=
 =?us-ascii?Q?gXc0wKUjrYlhZeepp5OZ57EjvD8hsxwG3VcPMyTbayiqnBGL9CimL2BdrVZp?=
 =?us-ascii?Q?wnVS2oKCtFzKP2l8fBOaa4tSxvZetW5sGkbCIX6Ob1ZBx4ROC4xszaciVWD3?=
 =?us-ascii?Q?Ygb+YzQTfIa5iKNdj0ljxJXrPpyHiGwmMCMTo3KpgfhDEz1yKmJ30S6m//Kf?=
 =?us-ascii?Q?M9AG3xfmX0lKtVewfsemKMAuEMBppnV/xZFUjW9t/eGGLWsF8nh41URqo+00?=
 =?us-ascii?Q?hnf35OWTTQJReQZK7/Rhf9iNUqSqNwBpIp8K2y+3v/ohwM1sKEQpX8e1apqR?=
 =?us-ascii?Q?cq2hOIAZcRRS3H1G66nB7WzNYu085oPacNEY/oPqGqafUzCa4ivgyTM2yyEn?=
 =?us-ascii?Q?t6ydVfh+Oz6BV31+vV2g4rOw2Wr/qlg7cc9rU9T7zVNfC21CBSCHoDBvO9Cp?=
 =?us-ascii?Q?qnrusqdrhi0s2fbR/McEG365tXgz6jLxhiMOORA/at6tq1C3+mb/Tlx5IkVZ?=
 =?us-ascii?Q?ISFwsye4vLc5uRuYT2dX+pNMHjLhhYZeeqeAdIFEUPAr9/r/wTdR/i70ubaT?=
 =?us-ascii?Q?QL3/6/t7saioHHDr9C3/XXrrce2gXJmW+eEdCTxXch0A9FTS5JLyLon90Tzb?=
 =?us-ascii?Q?RBWjEeQtnN8BkD6BGUBzIiLUTa+0PNqHB4qZh58xL41CILKuJDkzsxfEe1mR?=
 =?us-ascii?Q?CMNsi8Ezu5EZn+EspdCzhn/Zvp5Ddn3K7qE8OJ73zdr5vQfaR46hzqlaLZIr?=
 =?us-ascii?Q?pyIykuFEzeEvdzM0ZcwpZ5r10D0bvlJgfCnTGP39z3JF0Cz8NgEsLjQbnxch?=
 =?us-ascii?Q?QPydlDtDGdPeGjvdp+UuXwIWdf+1vHF31PD2VVXLl/je5qzCH6B88fsC4bX+?=
 =?us-ascii?Q?TvhuHkhqXwvR9I3q/XjCvYESTkH3IGa4vpLcOE6E4FDvCqDtfLUpC5L0G4SL?=
 =?us-ascii?Q?IY2kKOC3hSW4oimXPRxC3ESka2ByUZ2lC0TXL4ZoGG4UirELcGHNojgR0NNX?=
 =?us-ascii?Q?RLBmpu+sPQ8K7dZ849ygdjRJy4x47PumxQ/Mpxge4wK6zaZzbLr4B6cE5Udi?=
 =?us-ascii?Q?y+z4hSVWQfIuU6e4NbzOehT7a+/Ubg+LvrY9Y01r2AI7CQIcjVD5FhxBF1A/?=
 =?us-ascii?Q?/jvUyBYgc1o6mOp22tKD3PguSNPzdMb1AFUK7cfqxht+lcKNmZ51TqM4IV6Z?=
 =?us-ascii?Q?IJljjHKYZd2RxINHxTkNQHqmAwsJHw9tb2ArQ+t9eR/McMeEQq/XbIMbvbdB?=
 =?us-ascii?Q?/GoXKr3mSqntKiNrWRL5p77Ocs9b4BzU8cDbDSmt2aG05NKikWSbi4/b6u59?=
 =?us-ascii?Q?hxng2dKPUMMWaOwgQHPOW8ajmN8T4T1/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?80rlZyZXAkWr2qY8eX2PoviIPbhGYG2xSQRMiFDTpysbGg5LAA1frJTNbr/W?=
 =?us-ascii?Q?qEvlrFk83Qxb3qtIi+IEY/ytB/h2ZMcpXuSJPPTeebYhajUOIrM1eozMWPgf?=
 =?us-ascii?Q?bhtENTwuba0D7MypPm1aZ0SqC0z0f+pIXHhi4+zNRTUB9bw1j+ZZ9twW1AT9?=
 =?us-ascii?Q?VF370KYswJZk4c7vvImbc/sJ0gCX3zKDil+wIpOU7h9/U+s3b8mkP21h6BWv?=
 =?us-ascii?Q?OzgCy+nsh+D6PYAzoSc9KOoe62B+aLTKhZ2pyo8tNj2gdVzJQnchDgAUUBuW?=
 =?us-ascii?Q?QuGqKbxa9h9Z7fDBVFNFv2Euah93eNey7jw/mHH4SxGD+YSjlAvxh1HIQl0k?=
 =?us-ascii?Q?PYoeWwIVZod1PyhZmsF54IW7C7cHpRRyYX9vkVgwuO1zZKO8ZHYM7yLpdbuu?=
 =?us-ascii?Q?XkqieKud02XyTUIgbA5fcR8rWCmaixSWreke6TMP4U2i/U/F9e8PyZdr1I2V?=
 =?us-ascii?Q?fJFphY4kuwSWVkx2yL2GcUvQcLa6qTvBMVN9puZITQv68tJN50aLKekOi+Zo?=
 =?us-ascii?Q?7pEsPC4oW80snEC2zgcf4i40ZbU8KOqqQTf2WvX6buSX7Y/H13CurpJ89Vaz?=
 =?us-ascii?Q?+IG8PAwJ0k1xA8dqAIwSSvcZR/oUzNqgD6NzD4acYSy0wK3YfNpFapWXAW5J?=
 =?us-ascii?Q?+0dC+xTKcPRWHljjMdTv73SliIE2WbZ9i4/115T4SbTceb/4RA19HwOkubg3?=
 =?us-ascii?Q?zBVUa0qn6VDP3+hjBG6KxWGKJWx4h5td6qS8qlRqmEBaznLxkVdrFqjzQi/o?=
 =?us-ascii?Q?HRRn0p96dc6yMqGQ42pAyOPF2fhWw/fbgg7JarMTIyi9//Rk9dU38MZ8BD1m?=
 =?us-ascii?Q?BYhYiLqo6xhDBHgVBs8GeFUbVKFbOg2LbJ+gKQZdcD7yKpwyqxq6pYhNFuWP?=
 =?us-ascii?Q?h9yA2fkAifeidgvvz9LPsEWo71SkasNyswIMEU9Hz8ZtN1kv8r9h4ktYPPZO?=
 =?us-ascii?Q?WehdXKmO5bj+HESPxM00K/69mwced6ENi8kiTbgkJKYzKkWlfcRn7vTuSLjc?=
 =?us-ascii?Q?azvlx4oE8dihSO0xoy0QqL1EggrJYknRwE9TTwOJ3k9TpQ52q21xl8tn1N7T?=
 =?us-ascii?Q?muKbESBHSct+B/omvBZPEFTHR6vf6I4gpwzn8M6vUHUQ2UGrWVgoBxace2KI?=
 =?us-ascii?Q?+9wSxUB6V5BP4LEri3fwewPchQRQt2Mz4PR1xIyyWCCnmYY9L+DWAJe/xZ3U?=
 =?us-ascii?Q?17Zkz/7+uO2CDCI6kNijLEurjkvQtx+JGF2exICWkqrqd0EG3O54pMYIeShg?=
 =?us-ascii?Q?UHIFncg/n1HZ3NfYoJ0Vn61wp7Uq4i5cXq0UjH/ui02Yk3XcisSTxTHZuJF/?=
 =?us-ascii?Q?G6amnOFvDxPQQC5bvY+1qB8vVCbHlLWRowadddFzmzaYQePtpRGB6m1FBeES?=
 =?us-ascii?Q?CJuXaTlpCzjAfnOQztnIA9Mx4m1+1/4OxmYEmrTruzK9iMnkkHn6i4kBf7Lc?=
 =?us-ascii?Q?QJnd6xEGt/8yexotNLHBHoXHzdodJbFZsxSoqQrqGJROXFkX3DCDLgBYA9sQ?=
 =?us-ascii?Q?f1Vs9pG1osVB4okgdanj03iKRu4/r0AbiYO91cWxaEJSHe7QKeL3P4suTfif?=
 =?us-ascii?Q?9xvh6ZLs2b50CMQu6rg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4313.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c82c013-5d03-486d-a742-08dd6c7aef60
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 15:29:01.4221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZeXRorkgrKEUGeWLWOzUMh+qBMkcxObfPIPYuXlsWAHUJEpOpa3ubQjvpEq2pFQVZq3AgOxvFuDa9vKJvZu5Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222

> > > If I understand UEC's job semantics correctly, then the local scope
> > > of a job may span multiple local ports from multiple local devices.
> > > It would of course translate into device specific reservations.
> >
> > Agreed.  I should have said job id/address has a network address
> > scope.  For example, job 3 at 10.0.0.1 _may_ be a different logical
> > job than job 3 at 10.0.0.2.  Or they could also belong to the same
> > logical job.  Or the same logical job may use different job id values
> > for different network addresses.
> >
> > A device-centric model is more aligned with the RDMA stack.  IMO,
> > higher-level SW would then be responsible for configuring and managing
> > the logical job.  For example, maybe it needs to assign and configure
> > non-RDMA resources as well.  For that reason, I would push the logical
> > job management outside the kernel subsystem.
>=20
> Like I said already, I think Job needs to be a first class RDMA object th=
at is used
> by all transports that have job semantics.

How do you handle or expose device specific resource allocations or restric=
tions, which may be needed?  Should a kernel 'RDMA job manager' abstract de=
vice level resources?

Consider a situation where a MR or MW should only be accessible by a specif=
ic job.  When the MR is created, the device specific job resource may be ne=
eded.  Should drivers need to query the job manager to map some global obje=
ct to a device specific resource?

Other than this difference, I agree with the other points.

- Sean

