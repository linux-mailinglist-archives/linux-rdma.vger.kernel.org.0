Return-Path: <linux-rdma+bounces-19178-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ju1OAni12kVUQgAu9opvQ
	(envelope-from <linux-rdma+bounces-19178-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 19:29:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A5A3CE221
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 19:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBD62301D32E
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81343B2FC0;
	Thu,  9 Apr 2026 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cxr/h/AT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D17D346E71
	for <linux-rdma@vger.kernel.org>; Thu,  9 Apr 2026 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755778; cv=fail; b=Kt30AaZ+3KpKBCJfCaWN4LvdEZUwijgPZEJRv33on0A6WTDwP+iG1HR7wZRg8OLW/WZdxCUKbh/oyzmJOiBq6H1W8ES8xTH80bjb8Em3LvVkETI2KrNncOCSN//Ye0WfsAtvUEgQExC04RyPFaLGup25cXs741v7oAPgCzPe3YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755778; c=relaxed/simple;
	bh=8vedTAPnb+HVFpUKn9aLpAHhlwwn9zkzhMOnYXJpqpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eavLUFgTnv+iD3KoZuBrjS+poa6L/BFamTGmTqMtllu3fW8D3XycwCt1TTtU+QQ1yUFP5PAChbx74nMGc8CGTbHzazKrRUtOT8r7H92bnqqRgWKgPONgp+XXo3QQXn5RtBhglyu0YMDNYlAb1Aurfw1Lcbc+Xi+rSfALx415cpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cxr/h/AT; arc=fail smtp.client-ip=40.93.196.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hr7h9oSNMdoiGAbAuYFMvRM4ik68NvT2/AbMput3QnIXmhPFAEYMjdcRQB1Fy8/6DKGO49RF3LxNbUJkcDP3B9bv9V5e/BlbLuWu73B4sJwH50ETFqClKuX+suS7ohwmIRvCGZeezYEM44chVLetieMO4kGakNPe2jBuwWCPY45vid23b5fdPJF8HXDl1Fj9tHfUQwJ6CyDr4Xo+W99MGgIoVw46Tm4RRCuZ3w6qKlV1YTuB2smewtZaNrUXn3ArURCnMbGsu+nt+a9R7FmTwYeoD+MFTegXecnmmAzlwmN7rpw/MGkfJfdZRZCpOMlIcgK4r56q+GkIhx8uIijubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E52aRjdNXaz327mEQOVhemy3h/wRolaniyFWszP9dek=;
 b=CqOa8g+dh1/CyURDr9GDS4BuOt40pM9DKZsT5CVcp98YUBW08RW/88C0wWsE8+2GzUmu0dYOg/t9lnodqV6nmKpAu53UGdRQMCP7Swkt0bKRpjRfJeB1KJKsInTd4c3/VzVAc4dGgKD3cWSpgDtS9InbHbQMh8MTCK9ogMUvIYw7+GInBRZ4B6mfmd+bx1U8V+IBADZGO0cJoPAzhpCyoMmWcjgBQewMhWiCk0dkmKKM/boDYoeY6JzeBSlSSsQGrxugr/LLUxMElW6wrkKLze9nRkK+jCLVh7f9GRpzU+VGRqOUwB6U9RmySwYljx57AaJEdFdJmNTMaonyHFAK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E52aRjdNXaz327mEQOVhemy3h/wRolaniyFWszP9dek=;
 b=Cxr/h/AT4TjIRhblF9GySIkxkRFiDiRO30YCFzBbe+bZ0+3x8lXIP+Z/ejPd+8Dq3ZzVKYcm+jdEp7iA/XmuCCEXm+tw/nruOq4AyHapTMGqmmOJLBgbpIZghYX/ipgfQIRy1KuZNcG8F6/nEpkPLodMbSEW7SvHPiDD/c4b9R/h/V+lc4I1KUT+mJ1QjPPwZ3b8JVbvbB9BbhFI1Bmgw5LViiXSHJIAKWMqwXskJt3ml/SkqUAcNbmxGheWdjdwErBEKZ9eh+zpdDrF+P5kV/s5jwBQetNKIuCDl8YnLtpu/n7DOELMFOSyMGtyUdMSOSXVQv5DuggsWr88LCKqSg==
Received: from CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 17:29:28 +0000
Received: from CH8PR12MB9741.namprd12.prod.outlook.com
 ([fe80::43a6:8d0:7081:65d7]) by CH8PR12MB9741.namprd12.prod.outlook.com
 ([fe80::43a6:8d0:7081:65d7%4]) with mapi id 15.20.9769.015; Thu, 9 Apr 2026
 17:29:28 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Michael Margolin <mrgolin@amazon.com>
CC: "leon@kernel.org" <leon@kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "sleybo@amazon.com" <sleybo@amazon.com>,
	"matua@amazon.com" <matua@amazon.com>, "gal.pressman@linux.dev"
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
Subject: RE: [PATCH for-next 1/4] RDMA/core: Add Completion Counters support
Thread-Topic: [PATCH for-next 1/4] RDMA/core: Add Completion Counters support
Thread-Index: AQHcxoXIlexf2vrne0qPvD6VDq3DZ7XTpX+AgANBVICAAAPdgIAADTVg
Date: Thu, 9 Apr 2026 17:29:28 +0000
Message-ID:
 <CH8PR12MB97416FB899448DE69BF3082EBD582@CH8PR12MB9741.namprd12.prod.outlook.com>
References: <20260407115424.13359-1-mrgolin@amazon.com>
 <20260407115424.13359-2-mrgolin@amazon.com>
 <20260407141731.GC3357077@nvidia.com>
 <20260409160007.GA24340@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260409161357.GL3357077@nvidia.com>
In-Reply-To: <20260409161357.GL3357077@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH8PR12MB9741:EE_|PH0PR12MB7094:EE_
x-ms-office365-filtering-correlation-id: b206f267-52f9-4211-26d7-08de965d8dbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 vd5EzY3/dbEpoqu5qE21k213N5JekL9ql8Fh1S/5h3NUNclxM2bCpANbISqUFbuF1IK/0l6P/IWHg0+t4HarPywhwbhF813x/qKk+v7ZR0+sM7GJC9IvdZnxBW11afSUPAL+zLkt9RPGuHWR9ZwSbfprU8jlTI6NCQs4EyLQJ8Xp9eUKf7Mwvq8s6An84FXWi49ivl8EAWNvewia0Ei2CEpfmnc8zWXXyj57vsxcZiWoY9byPHCuaj6u3YZ9VUWTpYp4dtS3b7tmC/H7Ipy5WEgkjEUMN3m554e7LsLmdX9ncc0tc99wy461gt4oYhIt2z6USpP0urTGCNr+O725CHSW3z4KJX0fu16kpohOueUXlHG1CTp1xXuGW1LbjCHoeEkM+GHftZYTNQSArb2xYDy9KAzbjsb3kFFN2zTYB07NV8tD3dPOUCrGT0nLwDvw1ZyQZrowYAPp/abuDe+sMe5w+XVOhwTpRWxX9pjvJlaNVyjTFBKpT7QURysq7b6iooWyZz4GGngz2KrGe4Y1K5xOKxuhe79Z97WwSwg1Yis9EJhNQ8GovURiPBl6l1XB9JH1P+++gaNx/ToecccJ1vM6hzMPkzMYceW5JEHOt5qhIXOYrEg73xeZpKk2cd60JNAlQZG/4lufYkKBfZIO2ETsEDMz4+gf0SrezIOOsEadDw0HDrlWvV4OWJwBZlMtrosJ1oGv7xWbCMEZ9HEvod1F+BQcf2x2r2lMr58ZvR4vYAbSrX883UNzQnC1D4ErXGLevSd6OvAGEKKzoEqesFYaY/1IFUzPa1W8tAwee5E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9741.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?12+1t/92cMmWLaekpS0eJHhKae2b7LhgiZ96fXfkrZ8ssb7gR8EX2tUsTwvq?=
 =?us-ascii?Q?C5zIXOYBM0YJGBKnWR2DtdAK8CFZTGJYeE2zeKJVgP+F8XSG0IfxHP+hUTTP?=
 =?us-ascii?Q?ByJAlrBE0y39Zcyko9v5cxlkkZ/ta7K4kooTYo4Vpoc7e7tec5+PvbkMJXVo?=
 =?us-ascii?Q?YqT8gbhpqBruy1tVEw5ClDHo7V5RKzj3DVC1+C/P8gq7sh5U6VaJyskQ86zc?=
 =?us-ascii?Q?RLiKsjY0YTc3tAVqclptcgmZoz31YcSaHqi5QQXHBHUt9a5UfHhgUrd80buN?=
 =?us-ascii?Q?wSJ98+V+TiRktd1AFLh9U4U+u7pFJ4TQFKzFTUOq2aXXFlbsW7O8bQo4Mebs?=
 =?us-ascii?Q?JxvpWNvY8U4KthYdaBURI4CEmFmhPlyyNEkx/rvp/TZ3wPzp1EQZ0UBK4lQD?=
 =?us-ascii?Q?7Vn5NKWHkwyP9/YgI6c1u+EyxwpgHOCUuO0DX/GNENoIUTJ5TknoeZoS2llb?=
 =?us-ascii?Q?MfsrsnR03VxgknuNBMwOTtuOIDuFo7dxsU7PeWDIBXk8CDf3Ti12MxkodukO?=
 =?us-ascii?Q?ozEdFt3Ai+UsErO+UsZda5KLo93GSO22QrMs/eQcGHkhCA16NqVHP9xevg0y?=
 =?us-ascii?Q?w5TElPoGc8LheflSKzXcu/lv1SLAj7+YsbXNsPIJd43ueWv3kcL5SK0M5Qub?=
 =?us-ascii?Q?03lpYgUJi6NFwKEyLF/3XA0/tKuH8ryxtsL25UkIhsG1j/Io4CcveQErd2He?=
 =?us-ascii?Q?WQZ3k1HfY7+U9DnSQsbE7WIdwn2+b5oATGwEapUE1rKeP7VJJED4fYzqbAAr?=
 =?us-ascii?Q?5jR5H+qlauHD6taicNGVvjw4VEOzzcb5tdbOGC7Cv7lIVyplDIDnAlP0RJ66?=
 =?us-ascii?Q?vaMn2RfcnriVB+y4NCeYimjQ/+IdYP7fIHm8JpL+14NcGvwN2E3i3Y5eJrbZ?=
 =?us-ascii?Q?v7g9k2Ho9LVTfjDIiQ0t+NUtucUqe2sgxpy2WAKIKrjMUZe6DtjUFcBirtGe?=
 =?us-ascii?Q?5+ntrB0BRd0+cunTntnC8tXGSaMk+JCB6YIbaVmV6ftWb0HuDOA7xo6fj6Yq?=
 =?us-ascii?Q?+kLC/Gu8/bSdnHRDU4fP0wK2OtMewmMb+6tq5q/ijH3wGLGD+7zE+zT9nQbw?=
 =?us-ascii?Q?hQEj3wgjnToSufyJsU0glWAmJJ2TyJdP0CCVnEJNac5nLsFCZW+5UMAGwUM1?=
 =?us-ascii?Q?SABPMDNBJsPNpZCECt4r8U+a0pFo88WSORiOIzXFq/oNOvg1sIz1BbXuGrtY?=
 =?us-ascii?Q?KJb+tCVEcv5BGO17K6M8YrkqW3jEaQW1e//6uuSwKaKC6ubDXZLcc2pZcgM7?=
 =?us-ascii?Q?et4Q1htLGAdLj5i5oDmrd6TIKl6EzaTC8L5xOcZviN5s58gNXEgGraIKBB6C?=
 =?us-ascii?Q?e8mvXzBsibrPdkz9QadQeV9VGfeWeZcUAlUvqJoFg9gLwYExeO3rIC1J6Iq6?=
 =?us-ascii?Q?7hH6oEp7gGMsWGLoee3vjJefOOw/oPnH9vvGaKkmB1/hjQWxcnyGneEjoy5i?=
 =?us-ascii?Q?UaW4mo3iUklW+o39uSgWt2Iu6gJfkAaOBwuqyduL8UfVBSvZkqP2P9FjC35S?=
 =?us-ascii?Q?fpb/sjP2DIe3SrRhEsVXDCArF5B+W6xOV9JzKk0UrelvxNsDytq5oEf3FZMq?=
 =?us-ascii?Q?6hTryTvXXn8e3ZiQhGJF84TYjKswtTPCYxiAvF+v6O8aTGc9QfwidWmgcVbn?=
 =?us-ascii?Q?vsbCbUkhn5RrcbKGb6aBtGr9sDq3cCtrr4WNWJGX1VjvmmbGa4oYcwtgUUXr?=
 =?us-ascii?Q?bejxCg0kOOxmGwgbV6j+2Pa/AY9WP/4zngOcbc7ymtI6/ef4LEsQ7zOXKiHI?=
 =?us-ascii?Q?G+UIKL2BRQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b206f267-52f9-4211-26d7-08de965d8dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 17:29:28.6966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6j/BryEr3V4dq+OKQ3X05oIY+ZaHm8c46z2Jsna2eOFGc4H4aZBYP49cetU6e7sRy1maeEa+/JwOk1rS3MwVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19178-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shefty@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 58A5A3CE221
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > EFA actually has a single counter object type that can count all
> > events as you suggest here, but I chose to define a single container
> > for success and error completion counts in core for three main reasons:
> >
> > 1. Consistency with userspace - we usually have a 1:1 mapping between
> >    rdma-core and kernel objects.
>=20
> Well here we would have two kernel objects right?
>=20
> > 2. Although the UE spec does not define HW interfaces, it does couple
> >    success and error counting.
>=20
> It's just counting, it seem slike the api is you get a counter and when c=
ertain
> events happen it counts. You get to pick what incrs that counter.
>=20
> > 3. A single object for success and error completions gives more freedom
> >    to device implementations. For instance, it allows optimizing device
> >    HW resources by implementing the error counter in a less performant
> >    way.
>=20
> This can be done anyhow by choosing fast/slow counters based on the reque=
sted
> bits to count. If userspace requests an error only counter it can be rout=
ed
> properly.

Portals and libfabric define success and error counters as a single entity.

The two counters have the same binding requirements, in that they count the=
 same event (e.g. target of RDMA write).  One is simply incremented in case=
 the operation fails.  I very conceptually think of how a WR will generate =
an error CQE even if the WR would not write a CQE in the success case.  Err=
ors require special handling, but they aren't written to a separate CQ.

I view this as an implementation option.  One vendor may implement independ=
ent counters, which software can then piece together.  However, another imp=
lementation may have a tight coupling.  This is the CXI libfabric implement=
ation:

			cmdq =3D cxi_cntr->domain->trig_cmdq;

			/* Use CQ to set a specific counter value */
			cmd.ct =3D cxi_cntr->ct->ctn;
			if (err) {
				cmd.set_ct_failure =3D 1;
				cmd.ct_failure =3D value;
			} else {
				cmd.set_ct_success =3D 1;
				cmd.ct_success =3D value;
			}

			ret =3D cxi_cq_emit_ct(cmdq->dev_cmdq, C_CMD_CT_SET,
					     &cmd);

It's hard for me to be certain, but it looks like CXI has a single HW objec=
t (cxi_cntr->ct->ctn) for both counters.

- Sean

