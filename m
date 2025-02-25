Return-Path: <linux-rdma+bounces-8055-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AACA3A4342B
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 05:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC47168AF4
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 04:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71FA1422A8;
	Tue, 25 Feb 2025 04:34:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB73D6D;
	Tue, 25 Feb 2025 04:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740458056; cv=fail; b=HPNfpg7kgIi7NstAgniJ4irdYjux9clAW0lgiFkDN+H9iLNAckzpgjxOVANbqPY7iBLJ1nCXswxdk0WybBxpaqH/LQnY+lAXw3fphxyFOt5q2XppJlehZa/KSOMNik1IGj9ZGYLY+EPEinuLSJkYIrC7C2iNWTU0x2vhy48blNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740458056; c=relaxed/simple;
	bh=E9JRApQAE/cnXcu3pOpznBt7QX4A3o2XFnt9MBgA4pU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jp86QjfkjtUKAnhec1Y9rV8N82kTE8XvTuuyVrrX86Gqqa4ODf4gKTzevZmBpt0qAEzc1uARnQcs7ZoixRSvg/rZY5q/Y+KrR5+1uCwIogTD+trEBesBj96W/gorQU7bTidU66T510hKlO9OISWNaVzAdntZzeJkkuj9+OVJN+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com; spf=pass smtp.mailfrom=mellanox.com; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mellanox.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuA5w2oNQzcmM8D79k/2360wahmN7aHsIXy5txzUrKYgWEgTi/xvODUJ16inHrAM0YCWxkLj83mNt7MVqKEqshvxW6rWmS4OnQTEY7WPCJyeKxPseW4AF7isYyFasIQTDBSZNycysPsKGeZpYqleBxBQrZyfi/u0uxDoLA4bZBExx2xlYeA1pa/c8lqdinvxGoU5i2275FRC/rPQJBDjbJUYbfn+Zv9TsIuOrsZVeolh3lHcmo00+2O87JKuJZIi0/Jg7h3jbZStCsmlxdg8nY3fauEFJq9zhujLR9kxobvTaGwLKnx2RkEuEk3paEPyjNd+bTnSjOpzXm9FxCsAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hzl7+eNvtwykiLpLG25UrOYf93SZyTFp8mr1YKtyUZA=;
 b=Y9SyLt6ze/Q8gmFrinji7729WXtxrUHFXpiKHbq/wPnN7htNjQtNdlZmec3AMTQBNohcVYXRfWKY3ZS01oW+LUuwFCFJZ3CEIsgRTYCbHDaBRfgXPW4ztRMV5JzVZ6eJ7rhzOW3wfMVeD8xTq+cVH0hbeHqmK92vQff/9ymWXBux6pbfOrWquWFQIFERVbGkLgpp5aFqh952dvQBmHDQ19TO6bsHl035EhC+taKpeEd56m6mXkSZBGG+jtzUDk271hZgIJREAyzigL60eO5Kwj4mWbNd5Qnt41Yj4bIRmiWkU7A+AacWEFJ0N19xb/bDkqSTURYJLpi+1hxc73B4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 04:34:11 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8466.013; Tue, 25 Feb 2025
 04:34:11 +0000
From: Parav Pandit <parav@mellanox.com>
To: Roman Gushchin <roman.gushchin@linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>
CC: Leon Romanovsky <leon@kernel.org>, Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Thread-Topic: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Thread-Index:
 AQHbhAUwblJ6/3JzXkikuf/dEO2jkbNRFADQgAAVSoCAAADUwIAA3iiAgAGcjmCAAu/hgIAAATRQgACH/oCAAAIeAIAARoUAgAAOJQA=
Date: Tue, 25 Feb 2025 04:34:11 +0000
Message-ID:
 <CY8PR12MB71952D004721897B816B1385DCC32@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250221020555.4090014-1-roman.gushchin@linux.dev>
 <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250221174347.GA314593@nvidia.com>
 <CY8PR12MB7195A82F6CE17D9BDC674D72DCC62@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250224151127.GT50639@nvidia.com>
 <CY8PR12MB7195E91917FD5329932FA3FCDCC02@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7z_NcGWIr3_Dxtt@google.com> <20250224233004.GD520155@nvidia.com>
 <Z708JNt6-vPIuDBm@google.com>
In-Reply-To: <Z708JNt6-vPIuDBm@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mellanox.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SA1PR12MB7294:EE_
x-ms-office365-filtering-correlation-id: fc9b381e-b62d-4036-e146-08dd5555a6ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ut1nD1aJp1Pq5GRLEuPlBVtrAPuBQFDbaAbsuAT5OZLAZWJWB8fmYD+JOF1b?=
 =?us-ascii?Q?8cAs2JymtljM24AvejDRw6DRzcw511VnDGDq2M4UCqrbjroyze1q0eVZm+YM?=
 =?us-ascii?Q?MOgBQIyWzcaCNCqPKiKQKAl5najcbfrozTZCjHG4Eea/i+ZzuvjXb9oC4GQi?=
 =?us-ascii?Q?uPhQOmvwudwCxZo0lE2VSK+vU6AmKejQWJ1cuHwNpenx8YnnBIrKZxDrPU1T?=
 =?us-ascii?Q?fY0gXETGdLrJ8pK9+XO83DMBR9ZMi2yCdQmJvha95PlMAeZHfrceMWtdkQhg?=
 =?us-ascii?Q?IM5aTNNcQz15gvdT25deRvlUnnC67oIy077ADWN+OlICvyHNAsYhSoX+H6Qx?=
 =?us-ascii?Q?5zmXK69ya1FvsB94ZSpvg+h3CyW29DaI9tHDxjzZ9u/2l4Y9ZUZVojho+voP?=
 =?us-ascii?Q?5SZ+UNkpnK4LJMU85gtTgpmAuoHGsvj5I5VwurDkcHginPySwhFHHX3KQt9+?=
 =?us-ascii?Q?AnSOvIJrZq/dkkZFvlm7w7vvIw/B5LmJt1Gq8Px4fikRjXMzBd++VGS+8QBE?=
 =?us-ascii?Q?2tCtWpOvfRONkiR9naScXvDr/TwwLhEIfvJoFGuWCn9FLZ7tqUDZmuvEaDvy?=
 =?us-ascii?Q?FUXjr4HAwY7M/c6s8VkrmcUY1Sx2NeShkOZg4UIjRcvPuM4kSyU+HI4w5Mme?=
 =?us-ascii?Q?wF10I8Imt8Ka99TwB52JQ3K7Yw0k7A92XIwmCdkD2ODb6GKVrgKVlZs1OxCE?=
 =?us-ascii?Q?zfJIHiXhpd8iNucs83KpN8BsLUlUb0mjgwjuDBuXHPfw/5Rrx8L1lqwv3vSe?=
 =?us-ascii?Q?7t5edYcp2V2QqO1h7YXH1XJpFYPlm/tRdhl482LQ0qSJb7bmulorT2b0Ufx9?=
 =?us-ascii?Q?Fs5r2e7quZZSQJWAl8WFT5HyxNOsR8RJyE8XDe20aY8dJkcfIzbER8aL4AWc?=
 =?us-ascii?Q?Sot+cGH0u4G8J7cUWIqPbNXtRgVU8WHtxUOqY/u6lOY8EhOO34fOhW2e6/DZ?=
 =?us-ascii?Q?y537RnWIX96mhp+qxLSq9Ki6xz4jyQZymgmoDxV87ihygEIb8Xbj3f0bXFlY?=
 =?us-ascii?Q?VqeUKGKGAMGlsO3WdwUwBqqy60cwpbAT5SexDTbfQHGuy4bCxEr7YyfUpyEN?=
 =?us-ascii?Q?sXFxsLHSyJxdVvIvOU3Fl76zt1k8B4I4CGRIJfSmsBU4RMrTz0VqNbbKS89U?=
 =?us-ascii?Q?T8NTQVS4Ev0FREAiloADEpoPFMMtvQTpQtikDF9GDN0w6d08suY2T99TpGm6?=
 =?us-ascii?Q?8cHZ04RLd9U6Bf2OzGpA4Q0rS0lK7TOcocvAZFW4Zmcpkuz0IBsS4W7+NWas?=
 =?us-ascii?Q?IH0LAUh/A7+0RmUbvjWmYpz16v5Rv7sn+hJsHK2CJTOpW+1Jool6EJ3i8aQQ?=
 =?us-ascii?Q?gQ8W60N++hfDLIlK5Dk7rzBxSTpIxnp+ZttJkxJMahqX6x6OZULN2mJ+RAtQ?=
 =?us-ascii?Q?ML/EU8yjTE0t60e3gjg///O1bLRKzy4rTcdeqidKfMPvQ8l2xnFOGCjIkvCu?=
 =?us-ascii?Q?Xn7agtzZRl5HtX93jCMs2ae1uhT6cGhI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+7ReZRfX1/dHe2sSyTN3+t73XXyZMO0/PmTy4FyK773EQS343Try1yjJeTWU?=
 =?us-ascii?Q?dnAH/iTPq3G0AnDx4shhkG6mpA2NHleKjCYyou7idDU1TxiH+aZyNDLy+fME?=
 =?us-ascii?Q?ycYK+FCCK3wGMqpQoF7k/B5Q3BFFqz2HYHhDzWpdRW990g7OVJg3PAy1kBsi?=
 =?us-ascii?Q?RnBpeWof9lzIV5M5MFKMYas0Aai2l2ecvImrKE8ZIJJRlP57uvPEDXL4ZPBg?=
 =?us-ascii?Q?B1WiJ9M3591TnhgwsolPCEzCvoMOygZonx9Se65J7HolI1CcOhkYjESzVv4z?=
 =?us-ascii?Q?kGnfzDKxGNec05AnLrKquvPHbSFbH3Vxu8KvdGqkkRUmEpUo4G6g/kNl8neH?=
 =?us-ascii?Q?8rGuGONE4RBwG9fryNECZzOSQgAPbFJVXkTMqQQOmp/nxj55/let+YfAX5YD?=
 =?us-ascii?Q?gqM+mt/RswZhIyxEFR3Ex4y8f46vI/uUBTj+9WKMRJD/2Jq6R9F8SHh6wE6H?=
 =?us-ascii?Q?pKAoaBX/SXQCV/x5ipKOZoC1+cFzBiIMe/kJ7SI7FGJOflkqYwUWEA5rzk4E?=
 =?us-ascii?Q?5xC5I9TXtGt68N50V86TxRw6RVcT5aP6/8RxaDQRlV6Ve6215iKKDOJ+dN9r?=
 =?us-ascii?Q?VS2jVSta8wkaMEXz6uiKCYEUXwu45fm8p5OKzuH7YybzvOTo4bz62T46ixIO?=
 =?us-ascii?Q?UX6UgS7WDzE/AZ4yj78z3116bIucAKJrDNOiToTac/5GXuP+C9REe+E7fheG?=
 =?us-ascii?Q?ZXO64hUh8lqfeZpat8lbixOIPrZAQmYH22dZiKXB//6+nfQhsI8LJbVZ6RX2?=
 =?us-ascii?Q?jHVpFNvWSpXQ/EDTaqykrOxWcr65I34I6sH8YFR+enzDx4M6qVUXOID8qFNU?=
 =?us-ascii?Q?7qSGcAYYmFRB9UD4ATTKhK2nBGA1cnDO5j6ZjF2kCpwJro39JaN51BWT40ti?=
 =?us-ascii?Q?KgJkRIf7ihgAChUN25Ls9eCEOlwRu6ojxRBPkUUPaTi+5AXwCchzkLUooeoo?=
 =?us-ascii?Q?ipRar2rTfmge+H2uCAa6TWB2JLUxs4CqL8J87AC6BQgFI2mxTSBEkpG+HpVH?=
 =?us-ascii?Q?pJGepUumXPTI77zbD/rWL+cFOl5mzVeNn3SxOSlCSGYz+0GjxasfHU+uOr8A?=
 =?us-ascii?Q?EBm2FOqwbQmxujW8qFbY/kyLTdJQTr1xew4frIJJeDkJ7rEKJYKSYgYfwnTV?=
 =?us-ascii?Q?a+MATlEVB2PionYU3XP0YdDY1X6RjPzxDl0LxsD+edcH2/0uFFX87LM+qOuR?=
 =?us-ascii?Q?iHiO8/z83N/ND/UT86qL+1DqUvopYogeAw2He3DZoFT1glYNnB8TFkIrs6BL?=
 =?us-ascii?Q?I2lKDWCZKhq1Mj6cmfFl3cgRiV917l3AxjS8ha+iw8wmFPNpu6MTnhFO/3bv?=
 =?us-ascii?Q?CcMlIMWhoPwyZrWQ4q9Zktjre3dunNL2pd3i3yfSHJaewXBnFy4STqpUXOAc?=
 =?us-ascii?Q?Ik/BU4qjHRGCwDdCWLDO9AYnT+aUOG+NsraluKGYyn/MhAe7pdSmpVu+FBaG?=
 =?us-ascii?Q?kEyt6287immhHjihkScnRifjB57laCtzBFgNcTgcmU809+vFMGMz0J6H5DdG?=
 =?us-ascii?Q?VeQirhTJl8cdXXtnnDYNTuYYahwjq/idk3KV3IlTKyU3lDqYUljKXH6NqFdz?=
 =?us-ascii?Q?HY9IlxHPi2ou4l2HLRVSoAFkY36ckGxE+vyi8JlK35DQbkb49L4DcGLqXNo/?=
 =?us-ascii?Q?dtW0JHjeGxluJo+TlgOZV30JQMGAk1qgMz1vA/yXey1D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mellanox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9b381e-b62d-4036-e146-08dd5555a6ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 04:34:11.5193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WBzE1Ntnk7nbN2lc79d48iFapGqoNGieocG74d0YTlqk5pYHw10Qr2SMZY9Qh7mW3xuHpEpg2GpRjlmGTI1Fvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294



> From: Roman Gushchin <roman.gushchin@linux.dev>
> Sent: Tuesday, February 25, 2025 9:12 AM
>=20
> On Mon, Feb 24, 2025 at 07:30:04PM -0400, Jason Gunthorpe wrote:
> > On Mon, Feb 24, 2025 at 11:22:29PM +0000, Roman Gushchin wrote:
> > > On Mon, Feb 24, 2025 at 03:16:46PM +0000, Parav Pandit wrote:
> > > >
> > > >
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Monday, February 24, 2025 8:41 PM
> > > > >
> > > > > On Sat, Feb 22, 2025 at 06:34:21PM +0000, Parav Pandit wrote:
> > > > > > ib_setup_device_attrs() should be merged to
> > > > > > ib_setup_port_attrs() by renaming ib_setup_port_attrs() to be
> > > > > > generic.  To utilize the group initialization
> > > > > > ib_setup_port_attrs() needs to move up before device_add().
> > > > >
> > > > > It needs more than that, somehow you have to maintain two groups
> > > > > list or somehow remove the coredev->dev.groups assignment..
> > > > >
> > > > I was thinking that if both device and port attr setup is done in
> > > > same function, there is knowledge of is_full_dev that can be used
> > > > for device level hw_stats setup. (similar to how its done at port
> > > > level).
> > >
> > > Given that there is a bit of discussion on how to move forward with
> > > this, can we please merge the trivial fix in the mean time? (Just
> > > sent out v2 with the fixed commit log).
> >
> > Well, the issue now is the ABI break
> >
> > If the right answer is to remove the sysfs entirely then it doesn't
> > make sense to make it work in the stable and LTS kernels since that
> > would create users. Currently it is fully broken so there are no
> > users. Can we say that so certainly after it is fixed?
>=20
> It's a good point.
>=20
> Ok, then we need something like this (obviously, coded more nicely):
>=20
Yes, this is my suggestion too in little more detail at [1].

[1] https://lore.kernel.org/linux-rdma/20250224233109.GE520155@nvidia.com/T=
/#m43a5974cad17566080eeb64c6d5327aad4f0a852

> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index 0ded91f056f3..6998907fc779 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -956,6 +956,7 @@ static int add_one_compat_dev(struct ib_device
> *device,
>         ret =3D device_add(&cdev->dev);
>         if (ret)
>                 goto add_err;
> +       device->groups[2] =3D NULL;
>         ret =3D ib_setup_port_attrs(cdev);
>         if (ret)
>                 goto port_err;

