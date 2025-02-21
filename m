Return-Path: <linux-rdma+bounces-7941-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1200A3EBDF
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 05:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FF0420FB5
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 04:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C1C1FBC97;
	Fri, 21 Feb 2025 04:34:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139581F427D;
	Fri, 21 Feb 2025 04:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112470; cv=fail; b=ZwAlSHZihXnhAM1hOhzrbtG3vDD0cfA71hQvIpj/hJo+8qxOvRlK2IDS6ghgtxuKO+sSWB345CT4P2UwSECgAFXCJJEoTHniYnuh33xsrzT87QW+aPhJH6FrpVhpD4YAaZw5qnhUsYtokS6dCAQqLnJObu0AF53b1lJwriVc2XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112470; c=relaxed/simple;
	bh=lrryNBebOlaoUt00ZAY7FXEq5QEGcrO90+MV+MuQpLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SETYBnaGDnPTmP0k2jpIN7x/vN7I6M0ohghF+RD4ME0hL/sG206KTV0z67I99ddDpkxT5u4SfBKLHbwwfNhZQ/rakmDchfj8zPcZnlxFugcneTt+5PGOqUsEdwwEPBydwcwjJrcZSfCoi1VIUMxc/faTxrTjxIG24+obViE9Fbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com; spf=pass smtp.mailfrom=mellanox.com; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mellanox.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3QbtFry3OOtdUo0tMzdb2UG2JdBU2/B8o2UieFFIKRL+OQwIgtgi+BPCCrO4ba6MTtf8QsNamqEM/3R6a+OdTb6Cvaue83vTePm7hBdzXMBlM341+oA/phvvg5PP5hFVYjB+F9oks7tFFbZxUppBErPybZDu31q9qdByWP6I9QzoBqStSIUSf5SnOO8KDJ72xBYrGbJiLep0Geo8jgOQnmEmK+uIcyxOVNk5eHLncqV5JJ4kA2uVVuaurtV3n/n91dZAj93USsau6ANRPx51WcLU3XK3DyG1h3v9dFRLNTPNEaZ16lR5U0xoZhqGIRXQAjsBZWWPeP7VDPZIzRFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raVqSNPBmnUlU7gxPzQX+zZ65/cNXuMYV6PhLK7NElg=;
 b=nwo8RklNSNqvZGkFcKmZ6X7mfI+AQLGzDGkNVaK1YXphoqj9PU6K9rtRkspTjzIk9rvwUrBUkhCCmXNrwI7VWlK927o3c2mroWZgs0mrQzWAKqM5/QV92cCDEWES+klQW1n6JANcEUj5zJszIfPl1l1uhtHEpFj05Rt0dC1/oivRiDXQwlPRH4uOVjlme3TDS8vAQGCteWI+A9P1CR4sa9GGuEsjQ0XnTeddeIFmx2E5NxpPfMlBghM1tIw0h218oQxO3YGbYk9AyztlIZmrs6TT+Xe4lVTOcPHZKc1u8Q7NBmxWryWMar6Y4YU8GUgd8tz7RMvRhNMI2gL2CXDRHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Fri, 21 Feb
 2025 04:34:25 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 04:34:25 +0000
From: Parav Pandit <parav@mellanox.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Maher
 Sanalla <msanalla@nvidia.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Thread-Topic: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Thread-Index: AQHbhAUwblJ6/3JzXkikuf/dEO2jkbNRFADQgAAVSoCAAADUwA==
Date: Fri, 21 Feb 2025 04:34:25 +0000
Message-ID:
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250221020555.4090014-1-roman.gushchin@linux.dev>
 <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gARTF0mpbOj7gN@google.com>
In-Reply-To: <Z7gARTF0mpbOj7gN@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mellanox.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH7PR12MB6977:EE_
x-ms-office365-filtering-correlation-id: 5bae5cc8-ece4-4fc1-4cde-08dd52310551
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XSdcjolOWPduO9nFt/sbuZ/MiHkY7yUe7wvJkCcVNvokzfT6wI7dH5/JXCFd?=
 =?us-ascii?Q?4+gbt1Odwck3gAcUJ9CZsp1KG0zDLQnyqsgksRuPxYWzS+5ox22iS6GEQoJc?=
 =?us-ascii?Q?6IM3rVZmJxt4v1yKrRSzv2LlRPi5msHHHTQqyJG9OvPTCBZB5uPLhfgV5K/F?=
 =?us-ascii?Q?/AuOMLhemQdw/CYYxMegyxdaXDMesF/a1NGVXeYQ3KHkzGvm4AmQo3D1YodQ?=
 =?us-ascii?Q?EFvP/L1WcSC/uSxhaqRDKTc3ek0Jona5SK2k9w4Ih1L/HifNaDBNDUJ4IGrh?=
 =?us-ascii?Q?oPQ39/rjJ0sMW/iCkFxZjOHg8e1jcTW2yiMFB4i2Jr7KmNaLwFwnotW5i0/b?=
 =?us-ascii?Q?bgjvlU252HoZURaRbcfk5tM5jHeSVZA6YUas3EFHkF1DMoRdL/y/e4FtF6dw?=
 =?us-ascii?Q?kL55CRLMRd/YfG9ZhwphedA+brTlzViW7nc7TF/H0Av6JdMPr7mpGqnAGvJO?=
 =?us-ascii?Q?2KylCS2uo/D1OxLU/N3VR3X0Xq/nUyhdbYk7fANad04eb09SEJUCCp4PVv56?=
 =?us-ascii?Q?eA3zT08iDzyl3nw8W4/YMRR84FUir/2tnQIbWfeZGktZAj4PjUx5gqf9sDOl?=
 =?us-ascii?Q?JWqv9kFbDgqLxAXSZ9UEVQc61jgs8zWUVkjn4cSKRCv6bRSNZMdZIZrinBpZ?=
 =?us-ascii?Q?EmaA6CGBmGfQnwtUDSTdz+NDwKvR3oIcnoB3Wb+R6X69iy054lLJsz+ayBX9?=
 =?us-ascii?Q?LI3xS/UDpUwnQrY4x4L/EZzBTsWhOuRvIKU7wQHkY74nBJUBIiMRmRxHbmNW?=
 =?us-ascii?Q?rP6U4OpVbgvQtg8PHNBAQLmLZp2CwbnSFB/5G/g+URdI9gXXQ1RMzNZvVisi?=
 =?us-ascii?Q?8l8zd5b8fh167nvWc5K8aNz2ATIcSH+sKu5er6SVYLE9kXfpjr8mAbqVCh0n?=
 =?us-ascii?Q?EM1D/FGS3IHUEYwfn6ATtncd6jyuGbB/rz6OMFq6KKFaAe8YZCdEvAIQaoKB?=
 =?us-ascii?Q?eze1hJjAhQbVmtd+USeYdkxR2JVIX8k+nhwVcfUuzWqgTDQo/UWGpJd+hzG7?=
 =?us-ascii?Q?/TjpmiQ9wUwRkUIsN4+tBJxod4mx/rJAaUHd1zO+sbDg4Dn9j1S9BlqU584T?=
 =?us-ascii?Q?eV/OHcOfXOcab5NN5Gfs9HGn7zHy86FsLqGoS/wMkenJk3V7vHeoPxffFKYm?=
 =?us-ascii?Q?jtb+4Gg9N0+tb2iMjs9MKzpNREeYp3Rs5Cx1zLo94sm/MMMD/KlcjpWU3tzz?=
 =?us-ascii?Q?eOESqq8xXrVFoPH9Y2SsuszTWzWfvTTPpS17+Jpd57YuKukwXyVWLIrD8OdA?=
 =?us-ascii?Q?fkj+TKwhVa3njT5/CPHG5qPRHQVv2sbjxjhGrz8XPInDjsdJgNfFSODjSZSd?=
 =?us-ascii?Q?LDVdpFjcqetm8XIJi+eX6I2CFrSqlIsa+OlI6gdMGDO5YFo4WRrSlGgVAGpm?=
 =?us-ascii?Q?bHnw65ZbYu0TOy/W61FxX0i4tSS7QEYIMsPERZnVw4c41jhfa9Ib0HiY8qvJ?=
 =?us-ascii?Q?aNqh2/RUrZWBElHr9Um/sxzUdF1ddZmH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/UHHxxcdW7blx1l+2STPI8vpwe4lDE3k0FXLh9e27G0S1nUCWJubcdrMg9on?=
 =?us-ascii?Q?h5XdeLblRFIVwDpdkV5wW98zRBHRCT0+DT8LmT+XidTmkmNQyz17CWib6N9g?=
 =?us-ascii?Q?CqjTpVGwJvCZgxBj9roaPMbpo0FkTg20cc3mecdJUwLLfkbYaOOvxw+h0nJF?=
 =?us-ascii?Q?AxUbmU+zpsIangPoDNFsh/RUytV8rWi5hfTLFbOwxtto1jWt91MkmRWMsa2d?=
 =?us-ascii?Q?BA2l6XZRHFNjCUlYvDvCkMw0JBj2OUq/E1FyjAjRDnzVGKeskhOg9mCzgpp1?=
 =?us-ascii?Q?zjoTHOeRbUd6m06IwTi116s29Omqs89fxJxsoKO9gM2bq2ugqoh/9xAco9pZ?=
 =?us-ascii?Q?IOTk74+iKIRajSSAmvbh9ITl2Pa5przLEaPbWJbSLpjFKnNkACl404Kd/H9M?=
 =?us-ascii?Q?EPRzgyErzTrJKQkHdSbjk5JRa6DgKrT9Htd2FZMM4mOP3Rnu9IpOzBylDdzt?=
 =?us-ascii?Q?5eXGBSPHRNkJ1653GhETGkH82m9HfWe1fNvgTvK56cqWQpnNR1JI+AeyZGQi?=
 =?us-ascii?Q?YCvcOIDi+W6wmw4cowWWB/wFZVgVTmqj7tMkUs6EF0Eql49mXL4d3nF2QMpl?=
 =?us-ascii?Q?xBq87zE0XvcevtbNv3nYs6W/DCBf14PZ3PbFM+hPC2ocGyNZbr5mttpY2N0R?=
 =?us-ascii?Q?4/MWJ+DIoTKeoqKWrBP4kw3fwsbu7sZuweM8r8l9vMmAjyxneZNDPZDJt3F2?=
 =?us-ascii?Q?U4RiL3Obe2Ask4GB+6lBmVlMOsJpCI4OWF0eGIVtg3J2GnDm5Be9RSsqFY+r?=
 =?us-ascii?Q?JKXf4wJQjVJ90CH9GnNEOqTkEYcFYNDy5cwKuQyCnfKLLALfqaZxDBG00biM?=
 =?us-ascii?Q?PWNlnTbhBs8ARBMYYBwmVR4QnXre2tKFJL/iIZnpDQBJs84nb4zaNs2KN78c?=
 =?us-ascii?Q?9KMNmAknjDp5wTYo5/al2omBG925siexKHHWNo8smKUtiO/1q2PL0QdjyhG8?=
 =?us-ascii?Q?46zANiEkI1+LwUQ0/d25iFn3OWOZBXWjZwtlj3HXIGA+3e2emY93oKS4p+ln?=
 =?us-ascii?Q?zrpdugNsBbkujc8Q2MDKB8h8vC+vg3Bz87rO/+EwACvHgnvLKX1JP27tfmXJ?=
 =?us-ascii?Q?/43jDYWYWQT9l/xcqzf1N572kVOgRdqOfy0BUZR6hxNEY2BLnqb5rXWqucgr?=
 =?us-ascii?Q?a0MpVAnIbuWL4f8pupel2uharcPbb2xpftfCJMBkoeu+q6BYoTp0h+WR2irI?=
 =?us-ascii?Q?yehQRYnT74qoRDdNqvTItqqaivlkw1Zy9xQEK1EnMuckosQhn7E9Z5wqjcH7?=
 =?us-ascii?Q?UByiUUOv5MlWlDpiIEMe8fUFAVccuHZZkhCZ7jEXkqyt2gAF+GlGb5j5Lix9?=
 =?us-ascii?Q?PXuikWq5cG62fT7JShQEGepiz2ko8/58BzV5+GgffirnVo3eAcOPe0RePmA2?=
 =?us-ascii?Q?drTdJipAaA7yYUHteEoy3l01Go4uhwwGVfAain6PY1aAE4XqWGHa0A97UkRq?=
 =?us-ascii?Q?2TEVGefgeW2MK7EWnnWatWOTgbeG38sXChkQbu4yy/Pq5KcmuqAZqstJjcVA?=
 =?us-ascii?Q?3iMEqA44kZkThi2fDxHMo3aTp9/E3Nmzkhs/2fCmJ+Pz7lYTKOxfalBoMQY7?=
 =?us-ascii?Q?dpkJv3EWqUTO2Ei4uMo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bae5cc8-ece4-4fc1-4cde-08dd52310551
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 04:34:25.2488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfOILEx/66nfYNNHmXmv//MPXwYX89jYA8SNMi55D9gTKk3YFNPEfJiWZV2z9FIkyKD0eKfp5ukTSHFqtw/QbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977


> From: Roman Gushchin <roman.gushchin@linux.dev>
> Sent: Friday, February 21, 2025 9:56 AM
>=20
> On Fri, Feb 21, 2025 at 03:14:16AM +0000, Parav Pandit wrote:
> >
> > > From: Roman Gushchin <roman.gushchin@linux.dev>
> > > Sent: Friday, February 21, 2025 7:36 AM
> > >
> > > Commit 54747231150f ("RDMA: Introduce and use
> > > rdma_device_to_ibdev()") introduced rdma_device_to_ibdev() helper
> > > which has to be used to obtain an ib_device pointer from a device poi=
nter.
> > >
> >
> > > hw_stat_device_show() and hw_stat_device_store() were missed.
> > >
> > > It causes a NULL pointer dereference panic on an attempt to read hw
> > > counters from a namespace, when the device structure is not embedded
> > > into the ib_device structure.
> > Do you mean net namespace other than default init_net?
> > Assuming the answer is yes, some question below.
> >
> > > In this case casting the device pointer into the ib_device pointer
> > > using container_of() is wrong.
> > > Instead, rdma_device_to_ibdev() should be used, which uses the back-
> > > reference (container_of(device, struct ib_core_device, dev))->owner.
> > >
> > > [42021.807566] BUG: kernel NULL pointer dereference, address:
> > > 0000000000000028 [42021.814463] #PF: supervisor read access in
> > > kernel mode [42021.819549] #PF: error_code(0x0000) - not-present
> > > page [42021.824636] PGD 0 P4D 0 [42021.827145] Oops: 0000 [#1] SMP
> > > PTI [42021.830598] CPU: 82 PID: 2843922 Comm: switchto-defaul Kdump:
> loaded
> > > Tainted: G S      W I        XXX
> > > [42021.841697] Hardware name: XXX
> > > [42021.849619] RIP: 0010:hw_stat_device_show+0x1e/0x40 [ib_core]
> > > [42021.855362] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
> > > 0f 1f
> > > 44 00 00 49 89 d0 4c 8b 5e 20 48 8b 8f b8 04 00 00 48 81 c7 f0 fa ff
> > > ff <48> 8b
> > > 41 28 48 29 ce 48 83 c6 d0 48 c1 ee 04 69 d6 ab aa aa aa 48
> > > [42021.873931]
> > > RSP: 0018:ffff97fe90f03da0 EFLAGS: 00010287 [42021.879108] RAX:
> > > ffff9406988a8c60 RBX: ffff940e1072d438 RCX: 0000000000000000
> > > [42021.886169] RDX: ffff94085f1aa000 RSI: ffff93c6cbbdbcb0 RDI:
> > > ffff940c7517aef0 [42021.893230] RBP: ffff97fe90f03e70 R08:
> > > ffff94085f1aa000 R09: 0000000000000000 [42021.900294] R10:
> > > ffff94085f1aa000 R11: ffffffffc0775680 R12: ffffffff87ca2530
> > > [42021.907355]
> > > R13: ffff940651602840 R14: ffff93c6cbbdbcb0 R15: ffff94085f1aa000
> > > [42021.914418] FS:  00007fda1a3b9700(0000)
> GS:ffff94453fb80000(0000)
> > > knlGS:0000000000000000 [42021.922423] CS:  0010 DS: 0000 ES: 0000
> CR0:
> > > 0000000080050033 [42021.928130] CR2: 0000000000000028 CR3:
> > > 00000042dcfb8003 CR4: 00000000003726f0 [42021.935194] DR0:
> > > 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [42021.942257] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > > 0000000000000400 [42021.949324] Call Trace:
> > > [42021.951756]  <TASK>
> > > [42021.953842]  [<ffffffff86c58674>] ? show_regs+0x64/0x70
> > > [42021.959030] [<ffffffff86c58468>] ? __die+0x78/0xc0 [42021.963874]
> [<ffffffff86c9ef75>] ?
> > > page_fault_oops+0x2b5/0x3b0 [42021.969749]  [<ffffffff87674b92>] ?
> > > exc_page_fault+0x1a2/0x3c0 [42021.975549]  [<ffffffff87801326>] ?
> > > asm_exc_page_fault+0x26/0x30 [42021.981517]  [<ffffffffc0775680>] ?
> > > __pfx_show_hw_stats+0x10/0x10 [ib_core] [42021.988482]
> > > [<ffffffffc077564e>] ? hw_stat_device_show+0x1e/0x40 [ib_core]
> > > [42021.995438]  [<ffffffff86ac7f8e>] dev_attr_show+0x1e/0x50
> > > [42022.000803]  [<ffffffff86a3eeb1>] sysfs_kf_seq_show+0x81/0xe0
> > > [42022.006508]  [<ffffffff86a11134>] seq_read_iter+0xf4/0x410
> > > [42022.011954]  [<ffffffff869f4b2e>] vfs_read+0x16e/0x2f0
> > > [42022.017058] [<ffffffff869f50ee>] ksys_read+0x6e/0xe0
> > > [42022.022073]  [<ffffffff8766f1ca>]
> > > do_syscall_64+0x6a/0xa0 [42022.027441]  [<ffffffff8780013b>]
> > > entry_SYSCALL_64_after_hwframe+0x78/0xe2
> > >
> > > Fixes: 54747231150f ("RDMA: Introduce and use
> > > rdma_device_to_ibdev()")
> > Commit eb15c78b05bd9 eliminated hw_counters sysfs directory into the
> net namespace.
> > I don't see it created in any other net ns other than init_net with ker=
nel
> 6.12+.
> >
> > I am puzzled. Can you please explain/share the reproduction steps for
> generating above call trace?
>=20
> Hi Parav!
>=20
> This bug was spotted in the production on a small number of machines. The=
y
> were running a 6.6-based kernel (with no changes around this code). I don=
't
> have a reproducer (and there is no simple way for me to reproduce the
> problem), but I've several core dumps and from inspecting them it was cle=
ar
> that a ib_device pointer obtained in hw_stat_device_show() was wrong. At
> the same time the ib_pointer obtained in the way rdma_device_to_ibdev()
> works was correct.
>=20
I just tried reproducing now on 6.12+ kernel manually.
It appears impossible to reach flow to me as intended in the commit I liste=
d.
And the call trace shows opposite.
So please gather the information from the production system on reproducing =
it or configuration wise.
We still need to block the hw counters from net ns and will have to generat=
e different fix if it was reached somehow.

