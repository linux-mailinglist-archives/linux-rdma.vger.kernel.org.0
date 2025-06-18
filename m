Return-Path: <linux-rdma+bounces-11418-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35263ADE310
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 07:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADCA37A25BB
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 05:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FAC13B5B3;
	Wed, 18 Jun 2025 05:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YNxlc8IL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1447714F98
	for <linux-rdma@vger.kernel.org>; Wed, 18 Jun 2025 05:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750224787; cv=fail; b=BRB/K32De6Z73KPNKSFJ715zXNOpyZQJuy0bhSPLlfgRbTnEFyAefMGtPJFLjfNBWYm9UhxLK4snzcaHHfpARRgWI+7esV7Qu9Q2AJMqWKAGQFv7HzzpXLLs9axb8XvNnksk4gbqyuLuZDgW/067QNx8Z0iOA5xQDdhATqysXLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750224787; c=relaxed/simple;
	bh=NFb65rGP2BO57xdhRWrk/k+IG39SNyXJVjXjo7Hqpyk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F3m8oxiZ2IDOZ0efD0tg81CwMtik7qiZB8Hp0VZTMdl/rAEnxwoZOyXuhKqkL1xibsNzufFiIKiN9nsiR3/XW9xrofg9nVb0aLZ9ZW72puSJMEZ48jncJ0bZQrJl+juc+DhYua1dXQFNmWaZxI9oMjMhWQKUp915vnEfaeEmFms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YNxlc8IL; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NK0J2gUURYt6kaqEqICFlbjGFosVI5UNgjueREduVqjo9HN5dBAtE8AVX8NPXesJ7TZj/3/pnhh+4z6RgnjkQbP5BShUFYXNcb11Vebrpc3P5ULczazdpJ2o0A0Lr4E8Aw+rH8nTaKZx81bTnyTGvc2JohE1FANbfnh9FSNpa++7WiUSO9LoKvw47+2x/G0apehSIFFEzKiF6E5e/k09v1UwN/os6QijK6nHVPhFBJGHmzVHnAzVeZZr2g1dgMbuFIf058e4M9M1KrPUL57N6fJ5l/SeujoW6AR8A1s4xY8tXodVH7uBhvS7xleCgBoIk/ULeP6du5LAJr2V3dRlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ww2ki9EehwmhQ/2TGLgacxQo668wM756XPQeEBB1l9s=;
 b=QGplIqx+fqaT6tP6qZ5n4g6HJBfEPLv6olFwXH9EegjhR+NxVBjeqItuVZ6YnxnmzUDZoh7ufRpRKnkV3TmgQKCDRe4Ufd+WBQzRTA/QdeLiBMbuJaqU/C6qthm61JQMEWNRHgLm5ou4wU03QBP1choptvfTUJKup/Se+sTJa4aqW27JqA73wwhWsixxwFeiGdCmjmpz6CwqV0msi+WdANVwyy8eO2LEiL3bZs+GurCXJM9Gy+IBcJe7wth6nmYxLIkNRLoaavXRDrWi+A9CQ9dfEEHUHWaFWBrk82Uv4+RA47nTDQKYu74Z4wgbwM0TjRVj1+X7n6OO6l7PtbThGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ww2ki9EehwmhQ/2TGLgacxQo668wM756XPQeEBB1l9s=;
 b=YNxlc8ILnYtjgqUnHfmIURYPOT2e5ed0+BFSPei2z15TRoTU1jcs/5TlZC63Q1Mp5njd5dLEn92GJwDkAM/TzixdlVVRD0O6x9jh3zRPGVVdv1u+deHF3XNnzWWHY7TLrrKpYbXc4ehHTw2YsJaofWGgokrAVq/waI8X2aweNBBCek4FgCtHr7vKArISYrJYO8NXFfV7CVlVTUYUO1jllT6gYAghH/ZZsb8gj+h6hBQIEQHIPXEaJwoj6JKm9gYRsu8kRfvwmFnjFJt1k5hfof3wKB/qa/4Nf9PDJTdDJTTFJPA4GIqNHfeHi/viatist/tu4c2StReQrbFI8Mc32g==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 05:33:03 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8792.033; Wed, 18 Jun 2025
 05:33:03 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: "Eric W . Biederman" <ebiederm@xmission.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: RE: [PATCH rdma-next 2/7] RDMA/uverbs: Check CAP_NET_RAW in user
 namespace for QP create
Thread-Topic: [PATCH rdma-next 2/7] RDMA/uverbs: Check CAP_NET_RAW in user
 namespace for QP create
Thread-Index: AQHb32LfPGwSA3Z5jECsbQmr5u2NlrQHomyAgADDiqA=
Date: Wed, 18 Jun 2025 05:33:03 +0000
Message-ID:
 <CY8PR12MB71958E977F7C4FECB286BD48DC72A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <cover.1750148509.git.leon@kernel.org>
 <1845d577e9b09caad3af28474aa2498390587db3.1750148509.git.leon@kernel.org>
 <20250617175231.GZ1174925@nvidia.com>
In-Reply-To: <20250617175231.GZ1174925@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|LV8PR12MB9335:EE_
x-ms-office365-filtering-correlation-id: 3149304a-f107-48c7-cd0a-08ddae29989c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2DqzO6YApYxBFNIzty+Cr5jjU1FdukqKrVHgZOx9GE+xcNjcqjXeFoYuH9AJ?=
 =?us-ascii?Q?d0522rapIozZZB5Is2XRwsXiaZlIgKZfLiwoz/PbNGUHiOhS2I5YAHR1LFNV?=
 =?us-ascii?Q?WtCJ0Ax4x5zHdnZ9SXAiFsFJkQsvGU7CFJmrqzgUowC1JoQ4f5dscNZW7K1u?=
 =?us-ascii?Q?EvUOMJOfXgispom0uMeWzzqI0K6EspapQd4peqLO5QvD853BGeXVOh+Sbv5K?=
 =?us-ascii?Q?7sFGpynyfLEQST+/XX7X7nY0UPq+CLdN5WxKN7V3DKvvjudMBmFrptXLNO1I?=
 =?us-ascii?Q?RH3kn8WWyfv4xozuAxs/3OFXCkfLSxq1VPlRHjhFDu55yEfqDlOQsP+CT5Gf?=
 =?us-ascii?Q?asAK8TTtX6ngYmPyuhL/mS2NgOZJPt+Y8dCC8I18cWS46ol4Z/CZnBN2vU2O?=
 =?us-ascii?Q?aZDzhp2maQ5OvVRYookcOLtiuomt7wn+Hqvz8FoTM4u2JUNRcOj8beLx4jST?=
 =?us-ascii?Q?SFAfHxD/Hqr1AP5nyBwbrsdMoFUvkf+qnayxAvsQvK4uiWssGm9V8RPNXDIT?=
 =?us-ascii?Q?8uTIRlRC6Z0LIQC5P4YWRlxPPGAGjqT6ojTGlArbjA/M4yFi/KSF/q3e0fHJ?=
 =?us-ascii?Q?rw3LwXsBGh68krvJFJqkzQ6adqJi+w8N4e1GlUxQRC0g6OajUrePeF+r3OIX?=
 =?us-ascii?Q?R7juFvHnHbmXDv0pjCFvvlYFXWb8N8X/oHhJhmfGw1auwnwBE74Sqf+hR0X8?=
 =?us-ascii?Q?j/5dKXDS8X2/ScYEeQKa+n3YSfbjmW1/363pvvyDIxkWJIWK/vWewnrfZ79w?=
 =?us-ascii?Q?W5lVGbkj6ppn8lBqnXKH55qG8s7LEYv4rDjSV911GoigsPXoB/iuDde6p2ji?=
 =?us-ascii?Q?BpmFReKSHvfj4W8GzCA3rJ+Vh+4lC7aWSwXEIg8JO5gS/iIfMqvH4yLvrBfc?=
 =?us-ascii?Q?Za41XsNqT3HkgjobjpvEWySrh0/N3nw7+aJ2EHh4521A1x+PXKZH2vOZEyH2?=
 =?us-ascii?Q?rnhzwDvtHEXFJlaEYOrs0ocKzklxguQmeZ217RpFk49GiaMENTbu4je00EYN?=
 =?us-ascii?Q?6aXYhlJe1i7gvU/kZ/ruFwGiImXwbuuC62Fdywafm/056NINHK7c+yZUOmUU?=
 =?us-ascii?Q?O3MZ3OyfYdgXpxkXFb35AF9E885ZgxFFyCJe9vwjumx6rHdLhcwOhJZXg/Cr?=
 =?us-ascii?Q?3qOa9Af1o9YTVZBIvx11ODF9LJ0W48fp4ljFLSFSGVXgnPiXZ2MD6UrlUDVU?=
 =?us-ascii?Q?+8vBsXa2K6oOxH4A/UaNGnYu1XfbSqqcixmJrmVxfJAIKLLOMVUpNvM54Qax?=
 =?us-ascii?Q?pUjwxNJtFb/eY/rIMeoUmhTz7W+NkutnfdLy+yTl9v4X6Q361x7ZOIpJIpum?=
 =?us-ascii?Q?p4cO5XrlYq+wDz8KdEN3rHplMO2ri77yQNzPtVWenppeGQ8xFGp9u6pfRtLC?=
 =?us-ascii?Q?xfFG0j8dh3BJDRLyvOsGZw31ouFeRejDSCf6fwRZi81DQfPDi1A5F9ul5nzO?=
 =?us-ascii?Q?21HojfaijTQU28WLZVS+n8pN5qEI84Xe+lPA9LAoQozRb6iWuSuygw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/+xb1o+LHyow+hQpreJjMhmNNhj911gBqa6O/avDRYSbYBq9kGgsYcA1noNO?=
 =?us-ascii?Q?1K5zQdNKW2WEex+WvmOuM/98hJ0CuXFbexBLLanwZTMpX7ev4fyNxZ+dDEmG?=
 =?us-ascii?Q?nGfvippjV+wHWM//Nu/k2wPyvnzOGoPKyxxelEkJ46BEYfz9HZdaSuyi3Iv3?=
 =?us-ascii?Q?dPnLXd7SvTXQ7wtUj1p7QxeCi7khVJwQVWZCn87Cga/aCWwu0SU0hRtXi2pq?=
 =?us-ascii?Q?+bW3o6D0ESzhEigRdnVMrraSF0onF+c9iItGOay0OXAhcjjltYrkvwIgLs0T?=
 =?us-ascii?Q?Q2ZN2zhisKY28rh4ROUpMuJ8jQuqEFu7pwLP1jvePsDar9wOAMX9LmjyUXUQ?=
 =?us-ascii?Q?yecN+vZhSrbO0AzTyzk/3DywqI9FurvkTMvSBb2Wc8NSFD5WHkQUOFOpVi6I?=
 =?us-ascii?Q?yIfwLSk9RF3iCyOMb3Zf4qXn0lfD8weyzmKDPP6iu+yOMRkM5Wan2q7A13Hl?=
 =?us-ascii?Q?z6qErVE2HWhqlYHQGneN8o9PiM2zMBDzS7qn5kDnT04BIYR9sS4SjyZvQv/n?=
 =?us-ascii?Q?/lZKqVxUcqZj4QJYc4/bZ06m4/bnKy5iN4mQCJJEd5ZX7mrtI6fjV1VN8gyf?=
 =?us-ascii?Q?1hgkGxHwZcK40yuKhJheTV2vHXs9AfN2ToU8HafP7oZQgv7wFYQ/lfoz0/mt?=
 =?us-ascii?Q?aHHGJehtpMK6IK42Ow3N1B9PD7+zZJnA2bGcKPDt975ouChrPbTi712YAT2z?=
 =?us-ascii?Q?7H/fiqfHdV+TuagwjGrGCjMLIP/Pu+2w/yahl9NTQ9V1OH8lwgIH5boFXv7x?=
 =?us-ascii?Q?iXf5w+2w3XTFMF6KVG30yANa0oUviZH+u+BSufg8kaZsqmZ8MJx441o4U2Nq?=
 =?us-ascii?Q?m0Rwe46BQfVvVuN/bhta/V3li2cCrL1eQy6i3dPizyIaUWmz8hwqHabuTrJe?=
 =?us-ascii?Q?mCFcWh5BWOvvgWGkGgzUs5DoJM7EZ1GBZdlyeDg4VIAaDB1uSDR/cg8KWlyZ?=
 =?us-ascii?Q?hRb1JhEqAaNN+ctVVJYR39N5KftGbk6SLqnU5cv/NaaRfGg3Yd8nQPd/MAZ4?=
 =?us-ascii?Q?ag7V3npNSR+E+TR/XhMhdHt+WfxqqQIj2qH6rxvU+cwfPWo/4q/uNz6lfkSk?=
 =?us-ascii?Q?zLGECtncpYWeBGSCDlXoDgUHe10b+WNA0Alu4G3FxiYWxOvhgcjgP9HBU/QE?=
 =?us-ascii?Q?riFbaVuiI3Z+p2mXqBGyLO3QVaicZJmGzWkPInjbOQ81Dk1a098bg5yQi7K8?=
 =?us-ascii?Q?NexHgK/gcD9Iv3IiMkJs0HOAZlJjRljLPHTnUIVXXOR/pxa1dfdMC5qHRuH4?=
 =?us-ascii?Q?LxgoVDix2lBYBYaYnHwoASihM4kp1TyUF7I89fFuv9JQCGDOb1fvJiZBaTTY?=
 =?us-ascii?Q?cgUm65pn3H/kp8GTFzOuNtq6ZzINg3rgH3DYEwAbVOzXtl1ykcDKP9mS68Uk?=
 =?us-ascii?Q?B4CYGkkxWrr947Q/8PHMF0LP+UNY7KyNwn0Fqe2IQMaTOCOc6rarXANVlLRC?=
 =?us-ascii?Q?1bfHMlC3fFWLLJE0MoVuJCZwAmGy9MgjrpkB3Vx4ez6EEUZkCYbTfJJE1Vwx?=
 =?us-ascii?Q?eGT/EtuGV1d/GBizUTwoNxLvQwyE39o3wfiUOHYILZc5L5deqLLcsjdQ7bVo?=
 =?us-ascii?Q?2vRMM1oYT4IYYnUANiU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3149304a-f107-48c7-cd0a-08ddae29989c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 05:33:03.3734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58H6BUJy6GmLLVLwUPQEi/JUtctRkgVuDfcKOEyOuWJpmsEHmhvdu3u5K7N6jyI6SMDSKgonF77NyQ/zHKd8kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335


> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: 17 June 2025 23:23
>=20
> On Tue, Jun 17, 2025 at 11:35:46AM +0300, Leon Romanovsky wrote:
> > From: Parav Pandit <parav@nvidia.com>
> >
> > Currently, the capability check is done in the default init_user_ns
> > user namespace. When a process runs in a non default user namespace,
> > such check fails. Due to this when a process is running using podman,
> > it fails to create the QP.
> >
> > Since the RDMA device is a resource within a network namespace, use
> > the network namespace associated with the RDMA device to determine its
> > owning user namespace.
> >
> > Fixes: 2dee0e545894 ("IB/uverbs: Enable QP creation with a given
> > source QP number")
> > Fixes: 6d1e7ba241e9 ("IB/uverbs: Introduce create/destroy QP commands
> > over ioctl")
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/core/uverbs_cmd.c          | 11 +++++++----
> >  drivers/infiniband/core/uverbs_std_types_qp.c |  2 +-
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/uverbs_cmd.c
> > b/drivers/infiniband/core/uverbs_cmd.c
> > index 08a738a2a1ff..84f9bbc781d3 100644
> > --- a/drivers/infiniband/core/uverbs_cmd.c
> > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > @@ -1312,9 +1312,6 @@ static int create_qp(struct uverbs_attr_bundle
> > *attrs,
> >
> >  	switch (cmd->qp_type) {
> >  	case IB_QPT_RAW_PACKET:
> > -		if (!capable(CAP_NET_RAW))
> > -			return -EPERM;
> > -		break;
>=20
> I don't think we should do these code movements, I'm not sure we won't
> create a security problem by actually creating the object and then
> immediately destroying it.
>=20
> Add a rdma_uattrs_has_raw_cap() and call ib_uverbs_get_ucontext_file() to
> get the ->ib_device
>=20
Ok. Sending v1 with the suggested change.

> Jason

