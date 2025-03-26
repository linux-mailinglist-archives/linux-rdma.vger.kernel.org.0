Return-Path: <linux-rdma+bounces-8984-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3315A71D5D
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 18:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79707A744E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766D5219A90;
	Wed, 26 Mar 2025 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pvsq/YEl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AAF1F3BAE;
	Wed, 26 Mar 2025 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010797; cv=fail; b=iy9YSZD6J9DssMZidOmMNEnjVrPCjgF26janwr5E9UCcM/KTe/k85Pwqzw2dB/LHkEJS2COHspzGMpcrWqZBCDfBLJZlS/pTQZN0AQK2FbrD1V5bguV0uUkLglSs/TvyzVkw4pvGXP2Fh20u3HPqLnsQwWu+tTQ/iU7sfn/lqYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010797; c=relaxed/simple;
	bh=MX15MGDvHG8ahA+dSZ0fpXwLRBeN/d0gD87VZfhGGHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fkvRXwExKWg2ad1KtSKn8ISOAg79zemkGMu7W2QIKJZfAZ3SOsbsM10m0Oa3J40izU9iG3v33QvALvAMXNi68vhFshS1mD9DDSEJYfXQ47+E+BYhBN5XnVtkctxgOsSGc6fQGIypul1ykV2v0JtrXw3OW8VT3Oc2nkhYq+X8qrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pvsq/YEl; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b06Ji6epF3gw3BvJ3ZmPxToqf9iZAYsL3kObKbKD2U6soCbduXKmMJ7cgAgAG+6zdFcOrIPbyXuoZZtcY8ideNjkH6lR7cyA3sUk62deXJyTtO7P2keI6e1Z2xNuRAz7IeKvts5AYlXW2rdHcYDx/pj2luIHe2LkI3nPhdTKmV/uZhjOA9RwxIq22AT6hrI53HRPgk8XcLvked1OK+zLz9WFGmjeGlnZhSBDNr/dDOuGyzD1adeJTZnLChExR1IuWo/32K2uaDpUkYHxumhtDow8x1o2tXO6Me00UEJmJEyyozZF82rC5tFDXhpLTKfbqWmC4SGVU706q9qgqSXN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDyLeXuyeqLR5eoWI8UgHWGpGPvgqSxLh5H1BevvWWw=;
 b=XesHx0DCO+gzjO5J6J7TACav0Xla18F9wlChfbBDRm/7vBuopqtr3Ym0xvT0Q5Msw3gsp7k5k9ep86h3M+8zyQTncu1OVc6ZiwX2O84WVojDj+x6eLRWUytJ2AfilOkEdN7pyxJlutFg+z07pEfgUZUyoVYop+enowlsEZ8ajsTF81e86RP1sDhG51aIi3Xrwp2sA10JOV7noED2er0GnIo4jBeF2y7JS5ef7QN73pgeb/h13AteH9iLNGjsTqyFFA0xTLy1pxalthpTcNgX76XKWzufB4AkDdGx4lOFr+RKDHcUV9Vcq5x3/KJG11WfwlyY0yiBSrtQ3V10T/IFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDyLeXuyeqLR5eoWI8UgHWGpGPvgqSxLh5H1BevvWWw=;
 b=pvsq/YEl539LraA3UK1XlDitIR/lbPzH01lkBgSZOp1lfvueV+rEeE4XJerKYS0pm8eJatBwQWyK5Wlub0OpJI0tUcj1Gcvmj2aQxRx0lvHNH7PRAaj22fpczwbe4pCpGCuzP9zwrw6/WR1CGSTiPIT0DFrsbIsXHlz8L1psd81NonaBLGH8dNdAdtNjqNxK2K8MzAWLYJZdtDECJN5Iggg7gjOd73MYfsi3vwk8n5uTf8XsdtV8XrUPicNjNXMBie1pKsGHdQH0AfhKupgnqsYWKFrbvLBekGgj1kc5gNa/UWPFqtXZyJdRNbSuavhgwn5n82kR6mYhoG6LVVw3/A==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 17:39:53 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%3]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 17:39:53 +0000
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
 AQHbjuwVUw9AWIkXnUa8bbJSM0sPK7N6v4MAgAgXf4CAAAnsgIABEwYAgAAgrcCAAYj9gIAAAVBQgAARqYCAAABpoA==
Date: Wed, 26 Mar 2025 17:39:52 +0000
Message-ID:
 <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
 <DM6PR12MB4313D576318921D47B3C61B5BDA42@DM6PR12MB4313.namprd12.prod.outlook.com>
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+Qi+XxYizfhr06P@nvidia.com>
In-Reply-To: <Z+Qi+XxYizfhr06P@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|DM4PR12MB8572:EE_
x-ms-office365-filtering-correlation-id: fa087aa7-5f38-4f21-f3b2-08dd6c8d3740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?f5btL7iXWVm8NZKhD+x6pLiqrrzZVoUIsrX69OaiwddXx9FU8I4eSt5O/sai?=
 =?us-ascii?Q?mEb8oDJRnPDbUf0BXBsPJ+oVAoYUFuKCgSdf/jCCT6dzv0KlxLgX6OSt2xZ9?=
 =?us-ascii?Q?+l19Ze4pfn0xBWNwl0kDxAZIV91OjS0oAkE2ZvgjIMUvFrObiWLDqogSlesT?=
 =?us-ascii?Q?DH68FV19Pv2Kf1oFkSl0wIgcdBMzOqNG91S205TMDRHShWOZiVHqwxJtm+Do?=
 =?us-ascii?Q?jF8HcOJKTUcKCJdCJFnh2L482dnCEslhYWQpUiHCEHquAXoEwkR1r130XSKn?=
 =?us-ascii?Q?hTflpnb+1iGZqn8nJHfrcIq5/ZWkufm+cK13ekNMqDyU3R3EA2W22ek/bWvH?=
 =?us-ascii?Q?1ihXjYzXNJTwYeP3J9oOo7kVg7S9NXDdorflzZRD3J3AWyqYW3BPwp+vetXE?=
 =?us-ascii?Q?9a2qjByA5aSD6innNN/9T5HALQJHKgE4DCCUDkGsJz2Zwo/JAnrvv5lPUEK/?=
 =?us-ascii?Q?joC9j6bQLzHTsV8u8v/xm3kyM62PamXpi/xXYdSAOPmAJTHr1UQ8M9wVuoau?=
 =?us-ascii?Q?i9DV7ZcraoS87quBj72jtPNXFHg5Dm07RskI7RXrwmUojt8NKcZTWVTyID2I?=
 =?us-ascii?Q?tH9D+ID+RZSqWwY5DEpKkhmU+jutipzg1IoOSBDNDmN4DgbqHkFc4TaVyai6?=
 =?us-ascii?Q?35p2KIqsRZmcncTo2u6nrupphDJibkOoFtfser57QXq9XRW6w/gl0SLXB0n+?=
 =?us-ascii?Q?S4hS8lrQToG5IeHvY/P8vIpX+3vgW4tcmoaFIga4B9oqpGk6yQlSPivaiWOA?=
 =?us-ascii?Q?+VdOBaSX/8hs9iSkcgwdqs6zGvkgYCztCV2KMQsj/lNQ46WaDc4Zyfltz1p7?=
 =?us-ascii?Q?KyLZZ3kx3AXoqXSMq27vo5NL76AUvkBxuHTkeQG6JQoNSIi1q9g/dYLQGmEv?=
 =?us-ascii?Q?hI7DwDrDeehyQTZQGf6R1lb1raIoLQIKfJg4FDROItUWD/jc7vSCuInjwlky?=
 =?us-ascii?Q?jPobV3BUqnTJjT01JcK9JBqWtd/GiMx8jKjREK6GlUxc55Jq9vWwgbYpHR5s?=
 =?us-ascii?Q?V+66rTYAabxehGYPxO6W7arhPHoYPNC5hNOWQSUHPSBMey37NjHNDO4r9Wba?=
 =?us-ascii?Q?DKWxbUYbfDlULKNzjrAn6jnAw6Eff3wJVynX5JCcWMFo66exRcrDxChWKTin?=
 =?us-ascii?Q?LeuLa05/evbO+qIMQV3JB23C5Ylb5FqyKEV13lXVWbnGQrCs0MeiuzogG/EQ?=
 =?us-ascii?Q?E0rFDYhOz9DIt1dgJZJeO1QfhnNsn8TDNyZNnBzTfciAP2/rF5zlDwN0hkbB?=
 =?us-ascii?Q?I1fGNXgVIaoCFOtTUbZEsaFGrSxJaVRMnCduMYo/6Q803FPW2QvFEQhXvN31?=
 =?us-ascii?Q?3xAEXyyAsIWCiZx3ms3or8D+7FVJmxaIZSAEiPgenp/UCvHVyPNjdktYBn+9?=
 =?us-ascii?Q?VYq+VV19VRxf8ptF/7BMSJVHbmNKpPCUsi5z9NJxCmd0a+brGz/rlfvRIn04?=
 =?us-ascii?Q?b98Fr6wTPCiNcZab8TCaO8LgUbH7JwPW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FVDpwMOpTO/pdSpNbzSbAeSdVTgOuMnEqounFU2WrUrF3a1vnMXov+egPuab?=
 =?us-ascii?Q?5lf/BobndGEkPe6e678Dv1RFUtpWUS3KqRlAQXf5nfyUamIkcIjwE6IfNoIe?=
 =?us-ascii?Q?of+jgCLh8+UiFw5XwzDI2LXQ90ZyfgHdu81XDnm6RqP1DZVmXAdmaTqc3bPV?=
 =?us-ascii?Q?NWZ1GOQ8Gvi98TtEdHUGYNeD6Y59EQ8treOqDWLLJSqnZ4QiuZ7jWzN1VPmf?=
 =?us-ascii?Q?7rx1JjMvwv7ZciJyetT7eWhSzYPIHNkImsYJrrBkj1y5wnvQQH01KYjAag8k?=
 =?us-ascii?Q?bbroWCtw0TsYgR9Ng2UDbfcKo33pRoOCsVsB4hBA18CTBbIUOV5J3Nk0kZY/?=
 =?us-ascii?Q?uqbnbmmH0OPzsa3tqaFQS+yz6WuMwNHwVn4eYuuq30aFt5aCBKoiTe43EhIi?=
 =?us-ascii?Q?GNk6NfgbS5cbetw0Vu4GY54mFVcomW4dGPacbGtm2Yh1unTkjazcxKfo9uzR?=
 =?us-ascii?Q?bnr9hy3Pw5Hc92tlB8JH75C6M4yWUtQhS9Eu/04+fbNcMsG3ZFAaYewlxMt9?=
 =?us-ascii?Q?hzpJcQAWQmlnzhXAQ+2TWdicCmfrtP5qqBILyM8Yt08mavU0fXNekP7cH+af?=
 =?us-ascii?Q?8/t8sg6EnoxF0G7705rTml/WJzhMdyM4cRrXBmfn3DO82dottOEHrU3jhqOj?=
 =?us-ascii?Q?veTQVBTd0gIcvf+R4LkP4vr+HrfHOJCZBuyboOd8Bjp532WDmS1btWLC805N?=
 =?us-ascii?Q?IwCebi+mdeBEfp2Pxa9h+5U01shLCkQ4eZUKakd7HUk/O6K42kQ7uzcPDSWG?=
 =?us-ascii?Q?7FdqtQYVW0ui1dlUEAiN7zlJn7mdTDpy/3g58mpdI3IlRbv8+xxuKFhNjr+h?=
 =?us-ascii?Q?rEFLLQpPk9PAsEPpxkN40AtO+0xIKsiIOkl2nCEVO8CZCb61wqNxuinyMqZq?=
 =?us-ascii?Q?0cUl0TxaeoJVgw6MsWfpar3/nntpOgeDvX64SjEcc2ChPgahXy7/apDfdpi0?=
 =?us-ascii?Q?wNDp9OvfnSedCGjEoJBbIFv5rpeIPWYSYGZb4eJfK3kKYbmXhadPW7cR1BPN?=
 =?us-ascii?Q?TJ5xEysmV/zISb78C7S8h2TQKFAFNjX1qjTEGHyqaQl6GGgusWW7blQdWoAv?=
 =?us-ascii?Q?VNcmV6STbKephbKoRb++FFfMHf95wGwiYj3Z22wSF2c4HUQ9I5oUo30dHFui?=
 =?us-ascii?Q?7kTDNgx8WBR/ZrGBnfK54wshZX2CmklHrUXTw1l1tI8ldmvPhRv28MNXZHYi?=
 =?us-ascii?Q?1CxDDIWUlHfxl4TlRmWdr1zU2DSZC3IEqm4Q4GdClkAMBBodzeKWtUampHTu?=
 =?us-ascii?Q?KB3AN3kb3DwYHFhoHikkjX7ZYOxhoiVSC3jImA9tytEGmnSRXl+EI4yuJ+/i?=
 =?us-ascii?Q?0WnOnzLTBXGqe4OsIYf5zcD8yqPHR098q/95XeLrqOc6TDuHtZefxEDZ2EmG?=
 =?us-ascii?Q?K1tJPh6Llxlv1C1RohUv2w5wtRRq47zPkAundbFjk7ecp2+nPeKovyrEdddi?=
 =?us-ascii?Q?xHR0nj16nPVmwSS6x7Yy7arZSTtxxOR6x3IJWddoWj/Efzz08VnSaUk1mwdS?=
 =?us-ascii?Q?K7n5e3OCsmw3KrbVToAFirfyOnL8CcgQ1Rs/Tl8S10SNWENZ8muI6aPdmGam?=
 =?us-ascii?Q?8C/q23+25AbuQ/RvZCk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa087aa7-5f38-4f21-f3b2-08dd6c8d3740
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 17:39:52.9256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dB7s/foIdnDQWROP2m90jVnnBuaJlnIMZhVb+NDpynwsbJdHngvtaxGi+1e1q/uTGtSeC2kILA/KL+9n/OggYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572

> > > Like I said already, I think Job needs to be a first class RDMA
> > > object that is used by all transports that have job semantics.
> >
> > How do you handle or expose device specific resource allocations or
> > restrictions, which may be needed?  Should a kernel 'RDMA job manager'
> > abstract device level resources?
> >
> > Consider a situation where a MR or MW should only be accessible by a
> > specific job.  When the MR is created, the device specific job
> > resource may be needed.  Should drivers need to query the job manager
> > to map some global object to a device specific resource?
>=20
> I imagine for cases like that the job would be linked to the PD and then =
MR ->
> PD -> Job.
>=20
> The kernel side would create any HW object for the job when the PD is cre=
ated
> for a specific HW device.
>=20
> The PD security semantic for the MR would be a little bit different in th=
at the
> PD is more like a shared PD.

The PD is a problem, as it's not a transport function.  It's a hardware imp=
lementation component; one which may NOT exist for a UEC NIC.  (I know ther=
e are NICs which do not implement PDs and have secure RDMA transfers.)  I h=
ave a proposal to rework/redefine PDs to support a more general model, whic=
h I think will work for NICs that need a PD and ones that don't.  It can su=
pport MR -> PD -> Job, but I considered the PD -> job relationship as 1 to =
many.  I can't immediately think of a reason why a 1:1 'job-based PD' would=
n't work in theory.

It's challenging in that a UET endpoint (QP) may communicate with multiple =
jobs, and a MR may be accessible by a single job, all jobs, or only a few.

Basically, the RDMA PD model forces a HW implementation.  Some, but not all=
, NICs will implement this.  But in general, there's not a clean {PD, QP, M=
R, job} relationship.

- Sean

