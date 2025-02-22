Return-Path: <linux-rdma+bounces-8011-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC190A40AFF
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 19:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526D6189BB5B
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 18:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D21020A5E2;
	Sat, 22 Feb 2025 18:34:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96A2F3B;
	Sat, 22 Feb 2025 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740249271; cv=fail; b=He1dl+tO8nAC7mAAwDulFTcLeVzlNH/dgds9tVcFVJIXO6ZIr18b74xbOlThOrzHnmGQ8vEskI3bOXA+nK8t55P1WwlPO+i8XlyQwVAgA4zimj9OEqFGAHmWD5rdqNjlR3ISViIQAM3w3JiglcqcpaCt12p+CSoi8jSIT8+r7Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740249271; c=relaxed/simple;
	bh=UyzGAqXI0orCEO42NbTS1ewgG/qXgwBvxbcL0Dd8bkU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ALGK9QHNdR5VZ0kikayrqe4SVUq2i/4OSEhIWy9Q0O0MNiD88K5TbXoM1WHdkn/3UjV+9pVxwY9RjPoAbHXXWiHn8UDCyQBsIe51SfXp8GvcXADHVbJhA+1QaybRFoMgvzy+JvingV14UsX6EePbXoI0WNnfEEacqsUqL3f5I2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com; spf=pass smtp.mailfrom=mellanox.com; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mellanox.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVKqA3RTyCaDVH9lMkNZBZc48YmyGDYCgSI+Mm8df/7lsiiKQBuPabYfsALnZVzD+/0yYcGwlwXXqVb7mbX4uE4bpThfLsDdnfs1nSTxoTrz/oWtegryu1bFyA9ZkDT6VWbWyhV4iF/Hj6ew/lde3xKXq+chJD33ljC3i1pG6p/V4EK65Ql0GfXeKhBlUE3CZCgbniwXRSgJdI/NpcvPw5nOG6y5H4GeLxi2dOQhHlUgc8aRdKJEpe3bpB6B2P0663QRuOVT2Ib5EyJbyT1Fk2qRO0ot68vpulaEewTkSW0Fba5xlivebAOv8mGlXtNthH7ZkHe1Fr3ZlQG8bf5OuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcxtZsHqwm9UgdKHPDIhhcs2LjCztjCivl9n+qKxEyU=;
 b=SmM/IhIpa9u9+p00fLt6EPUAuELjMEvhXu4rv1dUBVUwife+NyoEqMTogqNAyUfadwUKTowglxNvSlO0WV0kyVrUF7okktdmqKIVy4KeMK6wtdmhLE3nXEmvVxkmJW+FanYZYize8Q+mt8Ah4pJLcWSWF3bMFgtrNVYXaxpUlEv8q5OWVeMLMR/uM7J797bqJ9FnUQloVvYPETJZYJHZScCeI3svLbJlB7SAc7x54J7xsdwPJzT1rfWHGm70yM/8d3tC2+Ve5IZtK3pd1juNIEz5THO6c4dIVC1kPIRiv7nzmNBv3LQSPvPRLOIc5LFs3+dLs7YFQqSbc3F6gHz+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 18:34:21 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8466.013; Sat, 22 Feb 2025
 18:34:21 +0000
From: Parav Pandit <parav@mellanox.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Roman Gushchin <roman.gushchin@linux.dev>, Leon Romanovsky
	<leon@kernel.org>, Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Thread-Topic: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Thread-Index: AQHbhAUwblJ6/3JzXkikuf/dEO2jkbNRFADQgAAVSoCAAADUwIAA3iiAgAGcjmA=
Date: Sat, 22 Feb 2025 18:34:21 +0000
Message-ID:
 <CY8PR12MB7195A82F6CE17D9BDC674D72DCC62@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250221020555.4090014-1-roman.gushchin@linux.dev>
 <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250221174347.GA314593@nvidia.com>
In-Reply-To: <20250221174347.GA314593@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mellanox.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|MW5PR12MB5651:EE_
x-ms-office365-filtering-correlation-id: 14749594-cbce-4704-1bb3-08dd536f8642
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oQcGMkdeMPveNGMRozlsn76wI2rzyeOT11IVFkf46T4WTCfRGdL19dBWUIbv?=
 =?us-ascii?Q?6voq1ccQl3FOx4IR18gGF0IDzY7vAm9kGYlJpUGOkHI+ZSwnkhHpy8d+3zV4?=
 =?us-ascii?Q?GssxDHvfqJhql5ri15nAASHBNJFAnq+1wjreQfVK0tnHMp6aEGJ92hoOaFEO?=
 =?us-ascii?Q?AHN1slfXIl3rWIZsHi1j6b5hL3p8JJwJmurb1QuUHiw5wHc8snueVwWGMcL8?=
 =?us-ascii?Q?b99T+GsOeZ3oYhUqiCCh8yRAd7d6muOEuiFaHjn2pmgpdEoq+FW7t1Uk+irL?=
 =?us-ascii?Q?iHGn/CRXUP70nYQXGalZKfa2BdLC9QiF98rE7g1DpWXGJyWBkfYYV7WF1VwL?=
 =?us-ascii?Q?5p6zfeYV6uOy7T8FVlN4XBz1qLCNFbZsol5J9GlOgptEslcowLDGsoH+q2Ci?=
 =?us-ascii?Q?oRgq0uwqqWMkx3P+3Nl5DViFZ2s9C7GTMxNvwY/FCZReTxJ6xcyXPyHK99lR?=
 =?us-ascii?Q?D7NzxEe4rBRvpSbanHdfWdeadE6huY7+aTS/Pe03zj0d2GCggiVMrDJCHWTY?=
 =?us-ascii?Q?wiBETIfObQJV8TGGCre3WlSDFTftPpDWueVL3yqGRvYe6klwA9JyR55vc8sC?=
 =?us-ascii?Q?l363gKstb86kKdnIYpURJI1Xe1OjxOrdoTjSLS+xasYylBV+zyix8t+EgkW7?=
 =?us-ascii?Q?bjNt2fkzrNUa1vBv6+d/2AkBCr2NwXWNHJrZQDKnBtso0ziCf+zIBIiz5f+E?=
 =?us-ascii?Q?hpDOVo7gf0laDSm3epyhtiG693+9cZhEKbLQXxYv3BqySc1q32Nycg0oLrSs?=
 =?us-ascii?Q?5/BzET/PQqwnBFXWbxO7DClTu7KdnT7xik5OAIeFcyptWF12lII8OZlzmfh+?=
 =?us-ascii?Q?qV/X5+CsvfQa4GLKWC+vZ+e1OGb+BXLimI1yi5YLwRl30qB7yZJnOxQwr8H9?=
 =?us-ascii?Q?S9w8zJfKDiff+23Q7ivv19A+AIR6s4B/eKOPSbIfRAGfUW9QFzatpzwZGFKD?=
 =?us-ascii?Q?8/2H5miOuecQQHDJj3JedDOW4nfSxteeXpfRhXLPjT7lmT5E+j7NKPMLtVFd?=
 =?us-ascii?Q?Ql2Ufqch3fypEjjWdoqd6M2X0dmcCqmUaPjwwK6XGF662bPAkhscN4PiYQQw?=
 =?us-ascii?Q?8dlPQqKD3r2Q7/5eVdA0kX9Wxx8WKLdgCiXOBfafQb56qA04uTqCYyogkFsN?=
 =?us-ascii?Q?P50RaOZQP0OwfzCr7qCT9ZcgvWPoXvx/7+7Bm5ErmHCOnPqQsZUGjghV0xen?=
 =?us-ascii?Q?DVS1ji1v1lHIxw63ssSuG6LOP6rEmaMyOFy6PbRLps6ahg/UxVfc/k9JfX5E?=
 =?us-ascii?Q?aFSmFCvq87q/JoVayiF2P3idItr0oK5Czjqa+pIea5qklNwsWrjFCQOa7ft6?=
 =?us-ascii?Q?0gZ8GtoTHyg4U5dNZrYDsRlhpwv84pa/hYGQ3mjm2/vvpgXMyOvGHPeUd/wO?=
 =?us-ascii?Q?93yLKot96gxmRFuktyv9sFnlxLpQpNXgNtVsagWGVSxAhJQADS67qvn6O0Qv?=
 =?us-ascii?Q?jJrIpxyIHaB8or2AO5mj+vlj1e9cYzas?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Jgau0yqL3v2J9sARQbDgC5Vaf4ppKqUrQZohtTwFBWl90WCxXLPVNHufGI2t?=
 =?us-ascii?Q?rQnErQ5jzNI+KvFHiDHqviglfkytff+w7lrkSpPc8vIOCja7AI6q9DRAvzkE?=
 =?us-ascii?Q?qCUj4U/Dd+J/SxhrIXE9cfNvFx+kgifLrsD5gMOSJyK00F0L3WpDWYh8xCAC?=
 =?us-ascii?Q?2rZ55Il17evaId9eEeAeeRt0TjZFFsnXEgjoE1E0jFOj3SDfk8FIL5JppE7z?=
 =?us-ascii?Q?++e+WXrGM/xRN6A4cW/y+qv4pxjBXOI5ir+C9bxyv44A5javv9sfKgLL1jPX?=
 =?us-ascii?Q?y7l2Ave+XA1M0RBzNnuVLPPKP9hiBF2e9T+rAmTUnLJxLT1ukWDcWJhqXOmp?=
 =?us-ascii?Q?xsfkTVYzRrHI7wmqRpUmUGvjjcr0kJ3Mhjdow9mmLMKONFOf8djae42C6BYT?=
 =?us-ascii?Q?FrhC9ppE4XkYRObektfmdMxtydb3XyWkkgvBEeK+R84dSuJ0qqYPsbv63dk+?=
 =?us-ascii?Q?vdMnTPPfZrkPwnWlX7s66rnSI/1tQF2Hojwcr8JcIpcGeH/Q1dQXSDuWzTMB?=
 =?us-ascii?Q?Mv2sYFASVFSc7nLqtoR7c4me6sv9E3uObH7TgoX8UQgZamM1JwOIbl8ll228?=
 =?us-ascii?Q?Qx4J4+9o/lWr0QjnALX7y9wEmoef2FdqWotX3Y1PSsK9UwBa+nTXLBOT2+4m?=
 =?us-ascii?Q?UYHONa4VgTe5CR//0WzqZ8YyfAm3QirZJ4kF80fQTR+fpZUo+7HEQSlw5Q29?=
 =?us-ascii?Q?Ui3XeLWU1BypoKTjBKzWl/WGpFFNMG4h7yiH1hmGTdqTNAC3oPw7VIVwK/qM?=
 =?us-ascii?Q?UfZUccKIVh2DKUWVRZ4+QtGvtREyaLtd8RLbGUzDAkYpll/kd1q6qFmXrdCK?=
 =?us-ascii?Q?zoEnrN25q8ZZx45pCBf3mO9eaNQfeJrxBoQ5benbyQylRPgFozCfHlkB98mY?=
 =?us-ascii?Q?onujM3l1bQKsN5SGwInXOrXdYzX+rjDSaSWT77HrSfIIXsAjrqGVUTLzbyln?=
 =?us-ascii?Q?fatgkNOFY43Ndz+xs/afTaGnewMebobZSMz8X6F4Oy01mHx9rsWUC5qd5KGY?=
 =?us-ascii?Q?FKX8NocF7nhr5nltLLY/cY2jL196vdeqJr5zeAgtNSnQeo9yZu+l+bOaezRw?=
 =?us-ascii?Q?A5hEYiyuptgy4wiby5v/0MHqvpGNKbo698x2GhpYrrM5w6lBaLtPfA7/NtO1?=
 =?us-ascii?Q?hru6KsO5aiBuB+itJnEh9SXOk3rkNz6MjZU4dCMcPN9GALrumVYSSIPp0aTx?=
 =?us-ascii?Q?MKpGKEnyUK2CBW0C/5aC3R8hBouS0ogEneJs+jjO9vlWXCbGBf0hYtmmofBI?=
 =?us-ascii?Q?13BfiGIDHX/8Mvtj4AAN6XrH0CfyG2YdpQIi8qcXrI1yv4LgWFxgcOBDWnWl?=
 =?us-ascii?Q?H0q+SwNJfE4XnRW2YfiS3+BK1aNf1UyQrocWbrQvEsEdf7+llx94cHKDGSmA?=
 =?us-ascii?Q?dtmVFDjf2MsGjG4fCYjbmf6gdj68OTsxLoebwWN4pAe3c1aafQzOzLebeKiv?=
 =?us-ascii?Q?mtlG3aFS/zT+CJXkBVvbIJ3ytVOFnW3NgY12hPjzvPpoxs3GIua6XTqxX9CN?=
 =?us-ascii?Q?sLgRrIRbVE6FJplHP9oWBhk9oq3QGDy7T6/3xc5h+qExPaq96IpXQBScM1rA?=
 =?us-ascii?Q?u+h3Yh0AcvV/UYxLPAU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14749594-cbce-4704-1bb3-08dd536f8642
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2025 18:34:21.5051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/WqOp6UXeOuuncRpzFUcY4BXpcee3QzhMaPdl3UaVujnkPEcC3tL7g+Jo1heOMHL/p5Ugg2NxA4pV0HqcdvfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651



> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, February 21, 2025 11:14 PM
>=20
> On Fri, Feb 21, 2025 at 04:34:25AM +0000, Parav Pandit wrote:
>=20
> > I just tried reproducing now on 6.12+ kernel manually.
> > It appears impossible to reach flow to me as intended in the commit I
> > listed.
>=20
> It looks to me like this:
>=20
> static void rdma_init_coredev(struct ib_core_device *coredev,
> 			      struct ib_device *dev, struct net *net) {
> 	coredev->dev.groups =3D dev->groups;
>                    ^^^^^^^^^^^^^^^^^^^^^
>=20
> Copies the sysfs groups from the normal ib_dev which includes the hw_* st=
uff
> to the per-NS device?
>
I dig deeper.
Yes, the source commit was not what Roman listed.
The source is commit b7066b32a14fd.
=20
> Everything in that groups list must use rdma_device_to_ibdev()
>=20
> int ib_setup_device_attrs(struct ib_device *ibdev) { [..]
> 		attr->attr.show =3D hw_stat_device_show;
> 		attr->show =3D show_hw_stats;
> 		data->group.attrs[pos] =3D &attr->attr.attr; [..]
> 			ibdev->groups[i] =3D &data->group;
>=20
> Which means the sysfs reported here is in that list?
>=20
> Maybe this was misses when the sysfs was shut off?
>=20
The original commit eb15c78b05bd9 and others, never introduced device level=
 counters in the net ns in shared mode.
Commit eb15c78b05bd9 by design didn't introduce device global port level an=
d device level counters in non init net ns as it may lead to unwanted side =
talk via counters and to avoid RW lifespan file.

And we should continue that way to not take up more burden to maintain the =
counters in shared mode for non init net.

Roman's crash report validates that device level counters are never used in=
 non init net.

So suggest, lets fix it rather than adding the proposed change which opens =
the doors.

ib_setup_device_attrs() should be merged to ib_setup_port_attrs() by renami=
ng ib_setup_port_attrs() to be generic.
To utilize the group initialization ib_setup_port_attrs() needs to move up =
before device_add().

Roman,
Will you please modify the fix to avoid hw_stats exposure in non init net u=
sing above proposal?
Please let me know in case if you need my help to revise the patch.

> Jason

