Return-Path: <linux-rdma+bounces-8530-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF5BA59813
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 15:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413D318882CC
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 14:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5171B22A1E4;
	Mon, 10 Mar 2025 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="neJmpw11"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B846170A11;
	Mon, 10 Mar 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618080; cv=fail; b=XblkC/Jc0sKBaw4/cpY+O6OK7yil16XE+pdo4jD2meZdTcTIzrNo/A9QH+gA7XgGWnuSIMM3teVvBhkLHGwRm6AfQ4RqunE1ipaPJrwrcTk8jYvqgFrMD3EgEGT56dGkzDXS6KmDnVBmsrSW4f+kX8U+1Jwu76W+MDPVbvZ4bto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618080; c=relaxed/simple;
	bh=YxJ+Va5nX78YWB7XVfKYKRRmSM/OFwFOeBfKh36Gg58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SJzT9Y44ghcA+fuTiTbG2vQo2D9XL8+eyTH6kHiW5Ail9BBjjDwfnVkdLO4TOHPCGgR5eQIZB2fAFTAQVhqmctuTlFnj6iBwd5VGxcvvjbOFvNRenefLxvLzTPBxAu+c1vEgQ04wlOonaJ5d3HPOlY0PChIfL2sBe77hGPFPIRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=neJmpw11; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUu55RPHqDL3I047gwLx8GRCWrcvmVjDW0S4DYRXM0BXaaVk3G50OeE4DfysTnigN2M6bZNO3sci+ffDgKL3IMuAf8jEaZRq4Q1r8qSCn4t2y1M467IhUGihi7T0MJEHsjCCCWxKD9bmK4YDAWkttpBCLf3sv6YvwGwExTIpQsWOp6oqW00BUZwhceYC6paap/7HSRa8Fmyz4RiE8bozIPo1aeLRp0zaeF0up4JvLDL6BLX2r1QXgNlxrTabFTyxrn5njQRjhFBrjFey2ELmy35YIQQ1oMMysajwkPsz1JSdqOQ25O9QAIdkcZqqdErGkp0ZZ/roaPzWs/pMXI3Wuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2K6GCA/8QtAnVPEHNWnDzVuRtLMCYTlP3RVMKE56Sw=;
 b=dyOOk+DIAwloEH3LIPBrTwjIu+HHYRqdgtXx23MLFZeua5Z1ntu5sdiyPAs+IUaJnu/rz2gi/M1CAbrLGCurR65bbVnw2dfJA1w9+fWteGCmciuAJ3negpUhpAf2I+sh5TnReMDqhPhgl/Jy9ziko+na26XPkG4M4cW9B9fzEzfpoJ3lw1tEzaxc1ptmnJx4SLttXNeycMJXYuJBta7wRJqZixW/DYxSVKldWSP+Mzk7a9MV7SLQBWYnDXzcCYcjQf5Sk+FUIQcHesO83iumaHBZ4uDh14M8v7kh1uUIel49i8HNloFxDk/DINx5SOV+r8g0/2jaH+2OCCP+57DlLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2K6GCA/8QtAnVPEHNWnDzVuRtLMCYTlP3RVMKE56Sw=;
 b=neJmpw11+muhcGh4DjmGq+OLiLDC94YkAEthIwHnG/Wxuwb4PHGYyZG98L1K2bdtPHQnL6Q55PYO6TvMBU2wy48sroyHxDQpAAVnktff0JwAbSf87dAEqrhv+NXuPkt8JGAchnT2mGMw+G7e/Nw+pSoJjAXAO6e90DfHeM/oKEJxx1FHUv0XZXCk57QfXnt9BvIOxXrPhC1TI7xN2AkEkPH8fKQUwUaIYCvAa988mwjKAFpDNXr+77pxhCCIJTeaTstH0eHKrW7XqWXl6YSe1U+Qsq+T3qmXckKJfAlHi/1HzdZ0OPK4DVLJTqA/fL93t/IYTVsg7Mo7TI1lPzWmRA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 14:47:54 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 14:47:53 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "ebiederm@xmission.com"
	<ebiederm@xmission.com>
Subject: RE: [PATCH] RDMA/uverbs: Fix CAP_NET_RAW check for flow create in
 user namespace
Thread-Topic: [PATCH] RDMA/uverbs: Fix CAP_NET_RAW check for flow create in
 user namespace
Thread-Index: AQHbkFTRRtO5IbAuVkaPsNDNMM816LNsYLUAgAATx0A=
Date: Mon, 10 Mar 2025 14:47:53 +0000
Message-ID:
 <CY8PR12MB71956080B3EDF49B2090E636DCD62@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250308180602.129663-1-parav@nvidia.com>
 <20250310133110.GA190312@mail.hallyn.com>
In-Reply-To: <20250310133110.GA190312@mail.hallyn.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SA0PR12MB4480:EE_
x-ms-office365-filtering-correlation-id: d605f3f3-1f62-445b-4c94-08dd5fe289fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jTdaN4lS2BO8o/+UVaHwC/NNJzYrllpHiNmrh4V+EXAMGbavVzxT+LSk89oZ?=
 =?us-ascii?Q?YYyU9hqPJsv1NRrieJ1zSCHHp0SvApsukP5TXNWiQCPhwIbeKHRe1oore0vX?=
 =?us-ascii?Q?iHL+E7xKWTJ2YseSkKux61sJgKGwxNEifv6VTDpqKKblEa0/Q0Nem72boX2K?=
 =?us-ascii?Q?9Q1LTicdRhBjnWOby8Mqg63vCuCclcB0zaVIZgWiLboK0lt2QxWqMG6g8slx?=
 =?us-ascii?Q?iuKQBhOYahT8r0nnZQKzJDDIE+tQ7HtGYFO6+tXFPTsrZiTSQZV7DAoLkf5m?=
 =?us-ascii?Q?E2XZUhQYr/vndNyykn+YECkwsL/FU+HRVDxUbFQg80h96mLWOBRAxB1af4Gk?=
 =?us-ascii?Q?DW7XaW4aSzVr7dvvSadmfzZb4qiAvGJM29TctUy/cujlc2Y7FcPmEcZVRl9+?=
 =?us-ascii?Q?gUXZwv9Pb0DWePIynrUlED+A2zqAUp8i87yvlyq8Yz12DBKuWRLTru/Uofnl?=
 =?us-ascii?Q?70e3wLxEzHcLWlAE/6EvxylZbbTNxduU2ZtzS2Yi2yKeZtPccpr+36wvZKkX?=
 =?us-ascii?Q?82tckrVeaYVJYr11Zu42zS21+ufTwXSzAcKaVgQaLiZCYhimaPxWxKs2f76X?=
 =?us-ascii?Q?RD9ZTt0FMD2yHuLnURNtFxZbD434qUlcQecFZPpyGzQi9J8jYA0o0dLtv+o/?=
 =?us-ascii?Q?DVNyeVQ5cfHfEW9uvR3X/cAMDz65SiwlO1XQqWH4uQbcwAfgWHB7ptQxYh6G?=
 =?us-ascii?Q?qaF+x4iLLnxjMt2CRc/Ho4w/ksTc9r8LN8/NDM6X+KYAoepnQDpJuUK3JumR?=
 =?us-ascii?Q?0RqS/HdGAdrCV3XFNGiaAB41m4wdm+tjWL5WuUFIFLT0dAgLR9doyn66ubtw?=
 =?us-ascii?Q?78syK9YCMyRekvkhbl5CkEoVUVLpJHPOr6EJvDGAC1hcEPlLSp/vWZMbJz1L?=
 =?us-ascii?Q?87iJbQuWLJk5dBnu4oyHt84+gxJFnE23EZaYN6+IrXCe1VNvBPNdEGpEt6TL?=
 =?us-ascii?Q?qBW5pAdtIv9ClLHXzgcreTvhNog/u4XrciApF0E3qBwju7ynw+TJOfXkWz5a?=
 =?us-ascii?Q?ULYrEghTDk6uSozFL80RjvjrYp5sElzAjD6pLCcD61BV5fh/AgL2tqAjLQcZ?=
 =?us-ascii?Q?tG1hXxIZ6fa+bBmsZUW1E+oRCreq5oydUsDFVjllXlj1Hz2CXj1/3MGkt6vX?=
 =?us-ascii?Q?qaUu03MD7984H5MGe7LZPle8Dgh6c3yAeVLJDgN7MGqFwDtMezoF3yz2nyff?=
 =?us-ascii?Q?UxlmQMktpBE2/+P/mfPXwvG8jDYxHcZvVazwpj22AVRLvyAVT27MzO1tJJOm?=
 =?us-ascii?Q?VMPlItDn9Gujq3ApBojq2AP7nnY9XR2Ui+LFIuPqeESsCfybbNA4ma+oiBtT?=
 =?us-ascii?Q?0OkaqqF9bJXJbBsGhYEWrUG9H95ZwB3mmxzxokYcA1pmWBoelV46K4zP1Nt1?=
 =?us-ascii?Q?hYtjsKxMr0x34pQiZGxtxGHcU9Wz6broaTyEQH2Hk4r6AbfyeLn+tzLmdA9w?=
 =?us-ascii?Q?jVjy167yFrCyI2Db2gQoNpkCj00fJkw0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Mz3aiiecsil8otE0u3ybdwZ5JIDNixW7Ng4ZrcMmCChpYFDcmZouz10mY+Fo?=
 =?us-ascii?Q?w7XBnpw1G3Ann36aHggj8rqJZ/zDoRSImFtvGfr2cyHAJ8f0LnXz5oClLzQr?=
 =?us-ascii?Q?4niWE+p/elWL8Mq8KWvAq+LwkO9fjhDXREWQWj4WfpdLTcAlxf2ZGa/ls33N?=
 =?us-ascii?Q?9mWesLOmu6GX/RyzMdYtUoSSP9VLcD/oTQ2atP/vQZTEHJkA69bdRF+uaN3g?=
 =?us-ascii?Q?An3mqwFltbVy/NFEXLtjwQNWmKPCwpJ3JTGs+xy+SxJUY8PnI3iklo3SHAtv?=
 =?us-ascii?Q?9m9dihNWfyg5wEeVoCSAf2eKJgw/TjsDMx8hBl49K/F/+xAxcS1KZwfCyEI0?=
 =?us-ascii?Q?gNBOhd6pKzep/uE1Dh08rXM82ZKBso+roKz2UZj+IGKyFmqoCAMQOVIxYkZQ?=
 =?us-ascii?Q?endqXgOeiyBSI4T42s/COqYH95EnXz2bDjkU00VsJhPhi9I5oET3yAGaLKbS?=
 =?us-ascii?Q?LP23MqaOJrLPFfBzuPwTWEY8QgtKPpZDV2z6L1PG2lSFBc1Ettay6wau4fbr?=
 =?us-ascii?Q?Kb3P0zd2se1SqBTsOJ8dY8JJLYNqAE5dv9Ju1iswLIX0NGBxoEUu4Xkpm3E2?=
 =?us-ascii?Q?nzIdA0hBwjNu8VXsUhkbalekIppbsL89Ws6EXhV/SCLl+SDHnSw6O/FZddSX?=
 =?us-ascii?Q?UFaSPpPfcF4gtR78ITzQnTVXzKFzFRVeKKZrZlPlL+9oW3bdDvDkfouKy0Vv?=
 =?us-ascii?Q?wvJ72HVyu1qHz3i7y7VFHR6vuiGOCFkAgzZxvvETSpayYtvAXgqW4yy3YwyY?=
 =?us-ascii?Q?77GmKxAXMFSj7+1Gt59C1+/pVZj4+wY8WVjr5/KP9a684aDf/UbLLI9VkyLv?=
 =?us-ascii?Q?fdsn223cJWqyND9VlFn3UHgr+WOUfQkqTFjlpXZH5RV4Bm6CWbGGFabViqDX?=
 =?us-ascii?Q?mA6NLn9rxAHfNrYwL0zn/tPu5RoBomNL6vjkr7Mh5MxdrO8LK+t3eWVEId0S?=
 =?us-ascii?Q?MnURgA5p2AbX53MPJ52+Bd7qQgC7Fe/j9UqPB7OyrFwlAZbLhTwtKEWe8h83?=
 =?us-ascii?Q?tq/Y31Y+KgRdiPgGmAL7rNeOyJH7C/WvHQ/Cw41/4d2EYKbNY7y5R5YnvN7w?=
 =?us-ascii?Q?Kd2e7vZPRct8SzWTdEEtq+jICooUQalXzBxBlSC7xBgGUZz97xVBMOhgluz4?=
 =?us-ascii?Q?zVpQoBBYmGIUbDoba0GWiS8S/UCiUIW26108jU1UrN3RXk2c9ejO98WC/UOu?=
 =?us-ascii?Q?IDD79+zAuYYN+mhx/VHu6IoPNZnlZQyBdrG7Ugr00BeXunuZ0wEIW4nhJK/J?=
 =?us-ascii?Q?kanJ/UC1RtzlFB7e6ZseW72LtAABJVYZbpcNpx8mgGUym0BCVq12ajXuBXLM?=
 =?us-ascii?Q?KmqCE/Ufv14zNfod7SU4Q8p483Ur1e9rhczPzlfArVWcVrRakiW6CBGOlxRA?=
 =?us-ascii?Q?xO6uu5PwIP2lHH4+INJ3o5uquY7OrWA2byXIPYz2cE4ADbeCZs1K9YE0SoN0?=
 =?us-ascii?Q?bymj4055TAMHkAkJXw6MFAr0uzjGxg6xhKYss2n42Cf727skVrP3Wul5pZWI?=
 =?us-ascii?Q?4AtU3gTKF0N7T2+g5dfZp5VrM4sJSXeJvzDz39ggrpjAV68xknZYBV/FX2EU?=
 =?us-ascii?Q?qscjD331LwI/bGPV8c/MabNcc0ehlBn5xaF7jcaD6FzSPjsw9fN9lM+wAgDO?=
 =?us-ascii?Q?zmPAMsZW01f2wLsKukb/ZSI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d605f3f3-1f62-445b-4c94-08dd5fe289fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 14:47:53.8766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anPaa0x6XPEOlM6cjo0o8nXvMZX6Sjcfa6cW6VSLluB37ByfkjXa9dQ4HwFtCZbD7fIuFZ86Rgn9yi9Z0rdUYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480

Hi,

> From: Serge E. Hallyn <serge@hallyn.com>
> Sent: Monday, March 10, 2025 7:01 PM
>=20
> On Sat, Mar 08, 2025 at 08:06:02PM +0200, Parav Pandit wrote:
> > A process running in a non-init user namespace possesses the
> > CAP_NET_RAW capability. However, the patch cited in the fixes tag
> > checks the capability in the default init user namespace.
> > Because of this, when the process was started by Podman in a
> > non-default user namespace, the flow creation failed.
> >
> > Fix this issue by checking the CAP_NET_RAW networking capability in
> > the owner user namespace that created the network namespace.
>=20
> Hi,
>=20
> you say
>=20
>  > Fix this issue by checking the CAP_NET_RAW networking capability  > in=
 the
> owner user namespace that created the network namespace.
>=20
> But in fact you are checking the CAP_NET_RAW against the user's network
> namespace. =20
I didn't understand your comment.
The fix takes the current process's network namespace by referring to curre=
nt->nsproxy->net_ns.
Each net ns has its owning user namespace who has created it.
So the patch is checking caps in the such user namespace.

Can you please elaborate?

> That is usually not the same thing, although it is possible that in
> this case it is.
>=20
> What is cmd.flow_id?  Is that guaranteed to represent something in the
> current process' network namespace? =20
The flow_id is namespaced in the rdma device. A network namespace can have =
multiple devices.
So it cannot be unique because an rdma device in different namespace may ha=
ve same flow_id.

> Or is it possible that a user without
> privilege in his user namespace could unshare userns+netns but then cause
> this fn to be called against a flow in the original network namespace?
>=20
It can do unshare user_ns+netns, but
I fail to see it can refer to the original (previous net_ns) in this call, =
because this call is always refers to current->nsproxy->net_us, which means=
 it operates on the latest net ns (after unshare).

> >
> > This change is similar to the following cited patches.
> >
> > commit 5e1fccc0bfac ("net: Allow userns root control of the core of
> > the network stack.") commit 52e804c6dfaa ("net: Allow userns root to
> > control ipv4") commit 59cd7377660a ("net: openvswitch: allow conntrack
> > in non-initial user namespace") commit 0a3deb11858a ("fs: Allow
> > listmount() in foreign mount namespace") commit dd7cb142f467 ("fs:
> > relax permissions for listmount()")
> >
> > Fixes: c938a616aadb ("IB/core: Add raw packet QP type")
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> >
> > ---
> > I would like to have feedback from the LSM experts to make sure this
> > fix is correct. Given the widespread usage of the capable() call, it
> > makes me wonder if the patch right.
> >
> > Secondly, I wasn't able to determine which primary namespace (such as
> > mount or IPC, etc.) to consider for the CAP_IPC_LOCK capability.
> > (not directly related to this patch, but as concept)
> > ---
> >  drivers/infiniband/core/uverbs_cmd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/core/uverbs_cmd.c
> > b/drivers/infiniband/core/uverbs_cmd.c
> > index 5ad14c39d48c..8d6615f390f5 100644
> > --- a/drivers/infiniband/core/uverbs_cmd.c
> > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > @@ -3198,7 +3198,7 @@ static int ib_uverbs_ex_create_flow(struct
> uverbs_attr_bundle *attrs)
> >  	if (cmd.comp_mask)
> >  		return -EINVAL;
> >
> > -	if (!capable(CAP_NET_RAW))
> > +	if (!ns_capable(current->nsproxy->net_ns->user_ns, CAP_NET_RAW))
> >  		return -EPERM;
> >
> >  	if (cmd.flow_attr.flags >=3D IB_FLOW_ATTR_FLAGS_RESERVED)
> > --
> > 2.26.2
> >

