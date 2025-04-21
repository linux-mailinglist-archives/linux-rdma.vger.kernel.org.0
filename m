Return-Path: <linux-rdma+bounces-9632-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5336A94FCF
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 13:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5A4168C96
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 11:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA67F25FA1D;
	Mon, 21 Apr 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ohe0aM9v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226523D81;
	Mon, 21 Apr 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233503; cv=fail; b=uStxkB8m+Jv62EYgk/d/x1f/sGHfKOrTL3pZVp3GxotM4HhBNFNNZo/087BftOw5lnTcv0cicx1djQ24fYyehHONbmkIMGSfub+CxuvBoDfvsi4qQq6stRFIiJPGzrulwpkiULAdnWBKQQUK5g3cU+JDR7w4ra3HKJcQgUouCxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233503; c=relaxed/simple;
	bh=0cI4F4BKHCGDKpw7dZ+aPen6Y+YHh/tpbCdd19rxitA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=baay7fO5Q8lhljmz+tXzqxb5LvB4s+FxXDXg7DJ4nwXu7dR7FabHMoZ3M/kZdRBxxtd/7RXGiN6caE3bWlWKVbr0FXPQFCfRUB+oJeHFQyS2Ctpw5TU+1AQKinQNZF2bb/5VIf7BbGoqVPXewJ0jhEBkZIgNejI50/+ht1Kxby0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ohe0aM9v; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvZYnPDKwO+VQjMJL27EjJLAe3DitIiM2/Q5eQ3ZpwkEtZDAULdBLSI2IxyZMZX9OLWVNPqn2TFIXP5CdNZG5lbR6Gyl+/rSQygVcU4yM1GikivhTPQRAo/sLU2QT4GH/iqfZoHgMBqjInXBE/qzAaZN10oC/wPEXh5SjIwbCYJrp/4K8kqLR02/xvG0jlkLNuZU+QpFxy+bFV128Dl1hs83wS1qN2LXHg/W/W/ZicoakkPXZlIZ9CSA9x59OBKWujggWTkAz9hp4M8YviRTELsV+6I3KdTbq/KttNOh9zIxwIP0KIK/Ah/HYnVz8iCU8k1EV/9ZSBt+d5S5tYUkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkrCvyQc8WSPi4ZP8eB/jh2irW1sQyy7fHT8wBXiFjc=;
 b=HgJCVVg8h2oSwOYPyDKxzo9/ClgOlfb0xmAfOCC/WDNG1wOlOP1pBq3TN+S4NSIsGwQD3yXCX4xjL0dJk5C4VW3EfDC+fN2+RSusjpGFDZB4aKSZtBb2QPMNYZTx77E8K9OoXGzTbs+vBTEzcmnb0woaWT6CkFICZ8Sr7yRpr8Tgh3c+MIKqR0B3T1IGpaHg6LldcZuIK7q3XyVBl66hoNzc9yYljBKhE8yIAjzH91OIcClPowx52XwQlDOMkEp8AENWlK/irHZtq9gXzpBGitAarx0OYJcT3Cy0GWDV1AJLDpNeS+2priJlXNktl7mlG8TZc6nxlSAQ8GstAS44dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkrCvyQc8WSPi4ZP8eB/jh2irW1sQyy7fHT8wBXiFjc=;
 b=ohe0aM9vvB2dPegr2Bs+PkTLkUK2BVIJpSb56fzAr94dYkfKDQQXM4/XCtupqWrtC8ofDus1o+WeEr4iLw2xMMnsA1UoQ5pjd1AQ2ux8IZ26CVZWMQtfgPiszW5SXt1JpcIVbiPjED2LYoDuBnVjJptBw7mF6xlBXvcvuOqRrU54AJ3oRBLGtdHsveGsAMo5IVN1yimzHNcwhAqxy+/ImWdH6qvexM5M0BEn396B3Oaw2JvdylzO1v8Z9nS5mgXxXjrhOBpLuWlPxLpCvMKKicmKM1JSgYzhohyOHtvZRP7eGz9ITMl8MmDaO2UeZgmv+mVwh2VyXV5Y4ZJBY/t4uQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SJ5PPFEB07C8E34.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 11:04:57 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 11:04:57 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "Eric W. Biederman"
	<ebiederm@xmission.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAZ+iMAgACAGGA=
Date: Mon, 21 Apr 2025 11:04:57 +0000
Message-ID:
 <CY8PR12MB7195E4A0C6E019F10222B543DCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250313050832.113030-1-parav@nvidia.com>
 <20250317193148.GU9311@nvidia.com>
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421031320.GA579226@mail.hallyn.com>
In-Reply-To: <20250421031320.GA579226@mail.hallyn.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SJ5PPFEB07C8E34:EE_
x-ms-office365-filtering-correlation-id: 45781f7d-0a62-4f6b-3600-08dd80c45a48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Lbff0eHz25IoVtDLKcnm5/YsZECvToWUE1TRMcSZpwYEZlfRoIIu8rtWM6oo?=
 =?us-ascii?Q?AY8zT24YkXpvfXkobYAOjjeQ+YaNSRoNyyGUfGApVomfqnBgQvrfGAFqpi7r?=
 =?us-ascii?Q?83eeqVmwjUu1Z1A2Dyueb/z+J5nG9SVRyPF6gS3G8KLyxOWIbkPFzpUF9GAj?=
 =?us-ascii?Q?VG8bPsrGSKMbOzwmLAIOSqgEBqKHCEQiz7XLIf+SQ/FeGah6lCOTZ1oKgfPK?=
 =?us-ascii?Q?vMoN+VhWAPs/iDzGmOQFgB89qrCh+giYlGykMasm9x/+T/FJ6aFFEQe1a4Yk?=
 =?us-ascii?Q?nwmJvz6JrQgjLvZhR4SfoL9FAlaR/MzCzMe6AU3LCJg/O0KWo1jvGTpHNRcH?=
 =?us-ascii?Q?/EUpqfgrP0tm5sthnLJupjntWU1/o+n/Z6vF2GRyNm5RpYxr0XF/tUYku2jr?=
 =?us-ascii?Q?ToLCMWIY0tC2xiD0kmqh+G5lee+kZBjxuQ0mwLcKiQ1GxEGs2Icw7GpIhAaI?=
 =?us-ascii?Q?dt5HGNyoi+ZjsXGaB0oVgIcKZmB60sBcLcGDjDDLle0Bersm8pa4wYN9X0PL?=
 =?us-ascii?Q?se5TALQcvu6dpgevWBkkz57MEKIBFwk77AmNyO6CNUp1+kRe6yQyx9FzrIu1?=
 =?us-ascii?Q?8KJTQg5bfjdtr/8EHmHmZU8YzSL/qBsWwAgdTon817hDTI65lZrkhaqpWnEW?=
 =?us-ascii?Q?koY9wBd1RK5ny7tcPuTx6uPXJwMDyoCUQqZbNkJ9LadpA13VQR5yZ7fndHDU?=
 =?us-ascii?Q?phFEtk3qVPN0ruLYUweQJZ3cGgBeKuQyOo99BOoDW7LYC3x5w+KYLFG8GS0M?=
 =?us-ascii?Q?q1DqJpVY2rgaDZOVwDcHNlgPJLuOGP1QYtiWq24fspEKGg9QI0dkluQ5WwGv?=
 =?us-ascii?Q?obeJSn0RZtXp+5cbXYrAKa62yVDjJetycSXNBRIblOq3a5ydfGCc5p+/JoOi?=
 =?us-ascii?Q?kAE8+y+UyXMFGeTOMd6Sb3RjbmJMhWukt/EUxdl1WPaxPR+YpUE4EdAnKWgu?=
 =?us-ascii?Q?qtJ1ajCHmURoLo9XQgGIXRzZXdKA9rLZwNcY+998W0rZv+njDHxQGK34g0Lm?=
 =?us-ascii?Q?AMkZbiOjXPTVhl1z87faWCPuNsumscI1srQC1An7hKurjBj+BK9ywqtU+s8s?=
 =?us-ascii?Q?VY6Fdmoedg+3pc9BHR5xZhsqNMj5R/D/DfxGGbxO9g1SD8Hx17zJJdFz/cZd?=
 =?us-ascii?Q?AK4Mky4l3smRm1maS9aYBw/+NnaLazIcOs1jyPfVWP9iowfR9cdi3jqTpZ4e?=
 =?us-ascii?Q?3eP2vPUD7tz3J2bcaMU4CnyOqe4fehL6hChuPvMHZVSzGJr6GMLQKiD8KbLr?=
 =?us-ascii?Q?aG4XeQU4uE2S4udJSors1bVBO5mDLR/KMuAC5t6gJQRyB29mDJaU6P1arlAC?=
 =?us-ascii?Q?Ec2cN4tEvUARq7bhWwtrK4CBhFXsznzt2+MzuUQ1KiC7WMTUewVsRnKzNAYg?=
 =?us-ascii?Q?BGw+ibmIClWhev/fGfO+355rFiS1h7LH5YW4bPuF+prKnJteAnW6OEQDJLZq?=
 =?us-ascii?Q?ISx9pl3gAVS8uK5007WEbWtFMZSRbb47QcCzhyxyheb3QOFXZiJ/OXTphT7d?=
 =?us-ascii?Q?mMMF4ahXNFofB44=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TOUnfS0xVldPG9OcoPL7o1IngNaTmnLA7uWMMvnFelSBZ1uiUDlML/Bb5s9y?=
 =?us-ascii?Q?MiIQWIuV/oFDUnBwzKND2v/AUQ9sPUAXufx4vdJFDFc4yh4hDHBuRktg1Y1G?=
 =?us-ascii?Q?Xo/mj/jthGJc2ov9Ad+ogArov/ucN2WasYjrrJS0mt/VPwxBThb8O67GI6cD?=
 =?us-ascii?Q?vaRytk0ldRZurRoBhNcBoXH3awvKe9PRYYdXLXK6Vs2sG2OJQ3kF16UAtAqL?=
 =?us-ascii?Q?4TegWK/4HezdLted29ehaND7PP9ez1De3QnKbXr3EIED9dNo/K4Sc5mFvj0r?=
 =?us-ascii?Q?3mxwvKSUAAgg9uuErTzUmwc0tAijBKz3YIMzg9KvqTUWy5iVNCWW6ltCds2A?=
 =?us-ascii?Q?MjFoYgSOTqdjwzhi21UBEXN1nO9r5OfylbgD3UJoYmeADWNShRk++1JF/N/D?=
 =?us-ascii?Q?LJWDBMg/pgadihAgxBjYXu46CXCrPELeYO3XSRogKnjfUWw9cd5QelGYnp4s?=
 =?us-ascii?Q?Wp9tMNLIkmst/WH9DW2EwlSitFV5caX0sk6AhWkV/iEr8INBuH/sS/V7vG0r?=
 =?us-ascii?Q?9p2N3P8NJDvEWH0fc7FoFNpjZPLRHqk3LZ/nNeflmEW2r5SQa426qrno0Efk?=
 =?us-ascii?Q?3Z1LiyH8ostU3gn8rwleghYRbaz+OQDEdm7gdcO6iiaaowrgNV/uifHV94sU?=
 =?us-ascii?Q?RbAjOnxYsPGTNYhJsadkoiE+xlMswS803iVk45UNIz5jydy7kZebbnyL5clI?=
 =?us-ascii?Q?HgU0yVnHEb2W8c5f1OTEGNUBSgJnzQCaCRZ/BNssG1NbP9Pq0nRKa7rzolDD?=
 =?us-ascii?Q?oXczOH3oxU1W/lp946Vn+L82/CUFmr8DUL6/3+yyIyJ2+qzbbfXEiVvzAHvf?=
 =?us-ascii?Q?w0dky2N8wOtV/gg089+NLjcXahmRk4N7IwCTb3lqk/aX1+AgswDmCkJ1vZQA?=
 =?us-ascii?Q?Si61KGdBL9nUzy/guwCAY7b7JZ7RQfgGqQmXS59fDj0Q8SStmDV9lV+/cLzi?=
 =?us-ascii?Q?hXCCcCQ0sMYbBZ35tUjW0qtR1oTF6IVbtnq7qMElCq2atE76btbGi2PtyQpP?=
 =?us-ascii?Q?OGXgSRk1tQ4ibKVa7NiJqxdp0InCKRgLh5zLodcl1V4VUtzw4SFB7rRQmc0x?=
 =?us-ascii?Q?jh64L2HF2Mbohpg+GhsMD7HOAfTAGZoKCR7FzsK4FjMd7e8pmKj5tAT7f8Iq?=
 =?us-ascii?Q?0Ek/4L51fu/dYkZIAmxhDb+gb/XWswYht14nXY1/7N4JJ/Xy3zzxtnZO15+c?=
 =?us-ascii?Q?jrqbL5p9dS+R4F2xwadzsL7Mf+WLHwo4Gb68WScu9JyS9+49tqBzu6e856tQ?=
 =?us-ascii?Q?SB6o2QLkF4ca5HsvVDrYpt7eQshwhD1RjBRxXNirCQNYr5hHZCMZSKNGVunf?=
 =?us-ascii?Q?aoX0ZepkKsOFowZ132vf59Iq9eYBfGaA8Puttc69aJN9vgf4jilf+Ru2Vu2P?=
 =?us-ascii?Q?fn4o/UVY6vnOL59R22260lkUuuF0CuY4wH/suXi+N9CLK+5xVqzcVmG9bKZj?=
 =?us-ascii?Q?HZ57dcilrCKng4qSJ3lqbEFCNpd8f3w6XoBlX3gupmxVNo8FiSvnlNlS0Lyc?=
 =?us-ascii?Q?cL7Mrf4scB5lgF28W2OyGYfCpX5VRaZ8S7QOXqVQ40Abcr3aBZFNXZnPhLXt?=
 =?us-ascii?Q?vOWv/EpKAEQDkgTPzTo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45781f7d-0a62-4f6b-3600-08dd80c45a48
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 11:04:57.2604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOsHDPTCpOSOyd8kXNabrgYdD+Xk3/x+8I3r1lC3lz55UCHsJAy8tPeeXBgKMpm4Qk5Yp8XHiVFPFLwBzJqMbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEB07C8E34


> From: Serge E. Hallyn <serge@hallyn.com>
> Sent: Monday, April 21, 2025 8:43 AM
>=20
> On Fri, Apr 04, 2025 at 02:53:30PM +0000, Parav Pandit wrote:
> > Hi Eric, Jason,
>=20
> Hi,
>=20
> I'm jumping back up the thread as I think this email best details the thi=
ngs I'm
> confused about :)  Three questions below in two different stanzas.
>=20
> > To summarize,
> >
> > 1. A process can open an RDMA resource (such as a raw QP, raw flow
> > entry, or similar 'raw' resource) through the fd using ioctl(), if it h=
as the
> appropriate capability, which in this case is CAP_NET_RAW.
>=20
> Why does it need CAP_NET_RAW to create the resource, if the resource won'=
t
> be usable by a process without CAP_NET_RAW later anyway? =20
Once the resource is created, and the fd is shared (like a raw socket fd), =
it will be usable by a process without CAP_NET_RAW.
Is that a concern? If yes, how is it solved for raw socket fd? It appears t=
o me that it is not.

> Is that legacy
> for the read/write (vs ioctl) case? =20
No.

> Or is it to limit the number of opened
> resources?  Or some other reason?
>=20
The resource enables to do raw operation, hence the capability check of the=
 process for having NET_RAW cap.

> Is the resource which is created tied to the net namespce of the process
> which created it?
The resource is tied to the process. So if rdma device on which the resourc=
e is created, if rdma device net ns changes, then this resource will be des=
troyed.
The resource is associated with the process. Therefore, if the RDMA device =
on which the resource was created changes its network namespace, all the re=
sources will be destroyed for the process.

>=20
> > This is similar to a process that opens a raw socket.
> >
> > 2. Given that RDMA uses ioctl() for resource creation, there isn't a
> > security concern surrounding the read()/write() system calls.
> >
> > 3. If process A, which does not have CAP_NET_RAW, passes the opened fd
> > to another privileged process B, which has CAP_NET_RAW, process B can
> open the raw RDMA resource.
> > This is still within the kernel-defined security boundary, similar to a=
 raw
> socket.
> >
> > 4. If process A, which has the CAP_NET_RAW capability, passes the file
> descriptor to Process B, which does not have CAP_NET_RAW, Process B will
> not be able to open the raw RDMA resource.
> >
> > Do we agree on this Eric?
> >
> > Assuming yes, to extend this, further,
> >
> > 5. the process's capability check should be done in the right user
> namespace.
> > (instead of current in default user ns).
> > The right user namespace is the one which created the net namespace.
>=20
> "the one which created THE net namespace" - which net namespace?   The
> one in which the process which created the resource belonged, or the one =
in
> which the current process (calling ioctl) belongs?
When the ioctl() is invoked for resource creation, this process has its net=
 namespace.
And this net ns has owner user ns.

In my understanding, the capability check is for the process's capability f=
or a specific resource _type_.
And have nothing to do with the individual resource itself.

A sane flow in my view is,
a. create user namespace
b. create net namespace
c. move rdma device to net namespace done in #b
d. launch a process in user_ns of #a and net ns of #b and let it operate th=
e device from there.

If the process after step #d, creates new net ns, or new user ns, any new i=
octl() for resource creation, will check caps against the latest net/user n=
s.

>=20
> > This is because rdma networking resources are governed by the net
> namespace.
> >
> > Above #5 aligns with the example from existing kernel doc snippet below=
 [1]
> and few kernel examples of [2].
> >
> > For example, suppose that a process attempts to change
> >        the hostname (sethostname(2)), a resource governed by the UTS
> >        namespace.  In this case, the kernel will determine which user
> >        namespace owns the process's UTS namespace, and check whether th=
e
> >        process has the required capability (CAP_SYS_ADMIN) in that user
> >        namespace.
> >
> > [1] https://man7.org/linux/man-pages/man7/user_namespaces.7.html
> >
> > [2] examples snippet that follows above guidance of #5.
> >
> > File: drivers/infiniband/core/device.c
> > Function: ib_device_set_netns_put()
> > For net namespace:
> >
> >          if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
> >                  ret =3D -EPERM;
> >                  goto ns_err;
> >          }
> >
> > File: fs/namespace.c
> > For mount namespace:
> >         if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
> >                 goto out;
> >         if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
> >                 goto out;
> >
> > For uts ns:
> >  static int utsns_install(struct nsset *nsset, struct ns_common *new)
> > {
> >          struct nsproxy *nsproxy =3D nsset->nsproxy;
> >          struct uts_namespace *ns =3D to_uts_ns(new);
> >
> >          if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
> >              !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
> >                  return -EPERM;
> >
> > For net ns:
> > File: net/core/dev_ioctl.c
> >          case SIOCSHWTSTAMP:
> >                  if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> >                          return -EPERM;
> >                  fallthrough;
> >
> > static int do_arpt_get_ctl(struct sock *sk, int cmd, void __user
> > *user, int *len) {
> >          int ret;
> >
> >          if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
> >                  return -EPERM;

