Return-Path: <linux-rdma+bounces-8067-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B192A43BE2
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 11:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB7D7A3A33
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 10:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1F4260A58;
	Tue, 25 Feb 2025 10:39:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580233981;
	Tue, 25 Feb 2025 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479940; cv=fail; b=t9WdBPsUol0SUwAwc/8gGiRFrMGQIo8R1IONeg5irIlkQ8JDjWRyWtptF5I+4bnBtc3tsMjl4gviLV25cSMd9lmobV3Be+TwVW5WNnUcgiu/BOgXpdgVnJTc+W2BtDmjeViFXDsVOR4kcHV2KvSRkZwV9O93KYh4H1lnb3r07Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479940; c=relaxed/simple;
	bh=8z2M0eZQPRUZ4Lk6o3yzeiHlulYB/A0EsZ1E1r+jER8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aC5LgIvdTbLCusLHKMHxg6ayDEhU0r+1HC6P9m5Pq5sKgchL+eu2F/6M9alBdNqfYY5r5VJ51jZ7ou8OfIZIrMdM7+AAovRKI9G5ldpFrMDP0JYrHig6k53shZv4js4teVgpSPbQ7dWq2QxA6ze3vbCkAJH4B1a2v4W/5MI1Z1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com; spf=pass smtp.mailfrom=mellanox.com; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mellanox.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFjgL4iH/aMDEg8Ah7wLPDv/DysRenQjtAu6BIagXvVi9J+36YkIJiFlwdSZUak/D62bnYMaVHLTELpLWxCcqA2fbmyA3Yj0b1XZfEvV9OmTbaPaTIZ7pih5B/Grqt9+E2EInYtpMaS5hu1mm9PBU0H5D3ITgTOtfmPpU9wRc3wptdiejMT5zXqINoi1DzmY60ZdPHr8mlj/pOczaLhRLbj9vNyiDK/zSPDvq5v5Reen85w8On23DeVEZj/IqpyAEyJHgpmn2UVqRtcGGHc5YlpuCA/9dAyN+GwHrztbADDmIhtKRvkZTWHb9g4yW/l1A9D60ehVwLw4BzX0FzLXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGPkQ5GCAxm6/m+K5d6nZDpmhuOSi818ra4fN0UW14Y=;
 b=DFZEb2TmID6/2ZrTsdy/cZPkSy4kY81VEYF3zKuksG/vb5Gx0A+4qN73UHmmd7AwUZhnJsxBm1sBAyVktYSBQH6ylPNC0ii8+I/NFIbii4DgL2grC6XMDMzqzWyxLuZGrx+FFP2P4Sp4CLofGe/w7DADC3f60tnEQ9V3DxLGiYw/Ky0XDs/AFGgdfRBsDN7ddXxc7GcBJJqIjL2lAUNRJifBlO/8VEVCriggdQVP3YXXbdg4vrBP1hLvVNReyPm103ySUpylTLOb5jyucVMEXayVHfnOlqwQ08SCn+zUVKLUgYYKuZJV5DZg3WTG3ivmK0cju8U9PyxifuuKhfFMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 10:38:54 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8466.013; Tue, 25 Feb 2025
 10:38:54 +0000
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
Thread-Index:
 AQHbhAUwblJ6/3JzXkikuf/dEO2jkbNRFADQgAAVSoCAAADUwIAA3iiAgAGcjmCAAu/hgIAAATRQgACKaoCAALnXIA==
Date: Tue, 25 Feb 2025 10:38:54 +0000
Message-ID:
 <CY8PR12MB71956705526935FB62E79BC1DCC32@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250221020555.4090014-1-roman.gushchin@linux.dev>
 <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250221174347.GA314593@nvidia.com>
 <CY8PR12MB7195A82F6CE17D9BDC674D72DCC62@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250224151127.GT50639@nvidia.com>
 <CY8PR12MB7195E91917FD5329932FA3FCDCC02@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250224233109.GE520155@nvidia.com>
In-Reply-To: <20250224233109.GE520155@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mellanox.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS7PR12MB6143:EE_
x-ms-office365-filtering-correlation-id: 848032ed-1133-4af4-249e-08dd558899ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AKts7XIOsVch0IrdAf2LELPnsJW4p9crWqAbfJEbdK2FC3VXcA1rihdMEqvm?=
 =?us-ascii?Q?zBPtGEuO1K3K1+f2tMZ/udhZ53Es0WH0KgtHvrJt0fYa47Z7yZga/P/eUmMK?=
 =?us-ascii?Q?SVG3O87HbOFkmik6hkgEZGSaJvZ2Qy5s0nlzLpQURd4AvaEG2RgqSPUVZen4?=
 =?us-ascii?Q?s7Ldf23FZ9ZrDlX7DZ8ZonYV8yUegskjyWw5BIUPNNifGoKegEIG3cy5sXe+?=
 =?us-ascii?Q?fhqjUi38kPE0Au/eHzgz+JRW8/4yEODd5XjST5SnWIp39VUg32IJC3FkYWv+?=
 =?us-ascii?Q?S7sfZf3UPtzWEp+I8C0gffbH8XNPafzsT2RwYfbrxtC3ZcrUA5RT9ap4SYr6?=
 =?us-ascii?Q?fdd3le+wIvQyWq8RyQwOkiVKiA2EmfNdS0KgBYR/2Xz6aFYHAyQD44qoB3g2?=
 =?us-ascii?Q?jq2lhZ4jmrzU0RN5SoYLYc1eXBwpkOOwS0O2LfClocZQxxW6E9gd67qH2kg7?=
 =?us-ascii?Q?9J2K5k2Lqf2N2K7pppmqpDIJq6QRjp3xvgUSxEoYHY7t0yOSHCqO8rQnQpW4?=
 =?us-ascii?Q?YWTZWC2TfhfAVWg+EUOv8rbKvQj+lL6uev312K/V5WiHFAyDVMtSguyTxRfM?=
 =?us-ascii?Q?rzM9nCIqS9/NIB4mBFkGG+ZPyAvPqyA7fclVlrFmz2QmoR6OcfpybMnHlb5a?=
 =?us-ascii?Q?BMMrJn2rsniokvGemqgPNEAnSLpr/jdPWh62hawArzOa2+qXExvjfCu8uij/?=
 =?us-ascii?Q?shgV4sNE15fGN5Hbrj55ixg3LvsqY4IQ/xQJINnd4kEinAEEy+Y1BB4TzP3U?=
 =?us-ascii?Q?27XsOKj9QtTIubj2m9m+9RYFQX4FSjgxuWV/GeRQLBAYWm5g0H7c8nMe21FC?=
 =?us-ascii?Q?At5m8i8baCb68yJK5nAVkv3wMVUQWKcDsU2as8fI4Ka0S+4663gwc+OfCp2S?=
 =?us-ascii?Q?nese70ReS9sOq92al/H6LFaldlkX9bCg2nG10BfYPiQgUrsV+Q3IdXxOTdPb?=
 =?us-ascii?Q?grLdt+Md99kS/jhOIg3bAzMhSs3+ueL6ZOJxyo3zQ7+6MPY1fbVdleRzj21t?=
 =?us-ascii?Q?aw53av8Su2CHVhpy7d/Zs1/risHx5h4n8CNHV5/hh170MRrSYXb0deP9Op9q?=
 =?us-ascii?Q?WCaTwaLzxqgQ8YmXwa/HRx8nTMtS2/gPFu+LDlkwixEBXI5KZU0Okh04EgPv?=
 =?us-ascii?Q?8lJCBALmhA+Ca8xDGlX/ihRETGYz3kKUC0wCOxYQpSYsJ5lsWSKp6DXRmKG3?=
 =?us-ascii?Q?mSogoU/cE4+qtY36FETQSpDKE9U/TBHSPBY2ay0BVF9ry0EWrLsfLYPdhYEs?=
 =?us-ascii?Q?/rjedEFRZ6shvHCxI7IYI0+msENdZz9czSKfyi+H0MJKuPa9j7d9qkKlGKys?=
 =?us-ascii?Q?Z+7D3im3CN5r8dEortsibbwJCNSi8np5uW56EULPpX1NCuSHzqLbUnNdMu9N?=
 =?us-ascii?Q?xO8+bHiFXP0tYUivbxj+66dJhlo3yo38pX7DXQOVks24N6JjvCSaayLa/xKj?=
 =?us-ascii?Q?Uo7oOTJJjI77j2hwyswvu6Of4U9j5G1h?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FtPTPkTLrDAOKgRtzaTX8Q0WIdgKBbWqao9gO5hln04NLaBLN7xXyHmFvsE6?=
 =?us-ascii?Q?uo3M2xPWzaqgQaTyp1O46FqIs6CxuRwmbEG18Ec0erjN5NhskIQ/VgdVWOsx?=
 =?us-ascii?Q?AzKLe1WOY0onTxcuu8vFVyBY/Qxb76aOAd5SLF5XLbkPn/XJobEnQoUQYk/o?=
 =?us-ascii?Q?NSqXY/CFPfuKSYloSl6/rKpymK28/9wV4iItmq296BE7j2J+nm1qxlTdHUwV?=
 =?us-ascii?Q?PSMY60cyT0JRyRRtKN1FVWLOqFHWPn4WLw1FCFFcwSHByjCFk6HtQPt5EBcV?=
 =?us-ascii?Q?Z4un0iNurgWyy4ofJN2/bJtF9OjoRiAWZmuG8tgbD+IjxOxGSDfMvySUEFxP?=
 =?us-ascii?Q?rvtdyU5QKcgirXCZY9+PnS5/dHL3mgeNfLFMro53vhd9V4SaZsZCEiW3Dz1b?=
 =?us-ascii?Q?aAMJCwtlXMxPmpI03CbktS3dz74baWpH9a8wR8+zsGbP08bXmhDU2aqBLrcM?=
 =?us-ascii?Q?OivflQ6qoobbR7RBkINcI/aofx10GDdYtU10vxuOsqvMVrtIQYJuKvLtzzGx?=
 =?us-ascii?Q?0XozejW1Md4qw4FiMQSSP7RmtLFHgxrFkFRz0eM7ybJl/wPYxrKAWPMexr4A?=
 =?us-ascii?Q?zipXEk9PUPvWbleJAIThhzdTo2S1lH2z8ddS+rcE2e09H0lamOy+0Pogs1Nj?=
 =?us-ascii?Q?jYRd+D5ilSLz51uiHnf9VWeVKsJZCa0hxwMKPaBqmr7EU/zkXUoMNGPFDIew?=
 =?us-ascii?Q?nTDpJ7eSWiXOwovrxbo7pyGXf/wCglpCUtVybBwuJjPq+pWedvLfF8YXCWEd?=
 =?us-ascii?Q?jICIlN3KMDo2v/n6BRk+9OhcMX1WBOOU7YI+cLjLbQAVv+mJjwQvninjQ0sS?=
 =?us-ascii?Q?fvoVnf0PBAAVlqTUJwKhGLWpkadg9tGLuziQGZiiB7yF8/m6tyOg4fz/2OJj?=
 =?us-ascii?Q?PEbTAhkroePpL2BoAVvaPukW2IZwg8Say919n+3a2MRTckiJ03qTlZ8mKZbc?=
 =?us-ascii?Q?D5lKsFtJndN8mMhStiPoGXBEQY/FPjs1UK1vquW2q+2lNBD5OFXAGfEoYZQ7?=
 =?us-ascii?Q?yNE2wAedLtrKRSKhFkd5LjfGhXkRkwmT7TJxKdw+0UzUL9B0DSNHy7lyO2c+?=
 =?us-ascii?Q?hjLH4xaWr/5Qzx3B9yIm+K998iDFxq+dizJ5hw3f6jG3qv/a21wCfcZ2Ov9d?=
 =?us-ascii?Q?+9m9wJqW1WWPwzfdMRFxxzhFwmatPGdKHEOPvKs62kmETS+BHCFB8uLzL6Dt?=
 =?us-ascii?Q?UIuaFndTgHsq/s+yI0V8yUfiebzdmOvjBKscNgs0idpLCrMPEY0IEdFMBWHI?=
 =?us-ascii?Q?7m7RJPKp2SFkrGgT9owQGfyHiHY3iQZLoLTP+CfdrV2PrA8882MTctsmNsAs?=
 =?us-ascii?Q?3juzW87NIj3o3A/Q7orBalSKHsf9kojWpurTUbbtZ3vW5O+wShdRQUKInFuY?=
 =?us-ascii?Q?eSXRP9gZv7lTqun2vG9QSWzx5i+DT8diNSHr+vuEX8aqsbhSezC1cdHG85xT?=
 =?us-ascii?Q?OK26yWTRDM4daWcUwo4Vas39N6+BvO6PKxxBtypMVDUmwCP0SiMU0w6a+5Ac?=
 =?us-ascii?Q?9Zo5j/KNuuI+f0dJo+DPCbER2rATWE46Dq1jnkA1zTMG0wFYvy0jMpOH+Fe6?=
 =?us-ascii?Q?lLYT7vRsBD5U7j1JQs/eP8x/Nvw3mkQtbbP5fQAh50so1wo0AYu5irOtVgPk?=
 =?us-ascii?Q?EdZRQ91ozZKSL8LOVpgkGw8KTt50vn+Jk21TMIvKxPOr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 848032ed-1133-4af4-249e-08dd558899ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 10:38:54.2575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKr4a7bcOZDDw3PzY66vak1HJpoWG8z70TC6l7c4dKHv1UbYLycVkhdS9F4JyLXJzEW+Qfq0poS8ZISsjN6J/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143


> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, February 25, 2025 5:01 AM
>=20
> On Mon, Feb 24, 2025 at 03:16:46PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Monday, February 24, 2025 8:41 PM
> > >
> > > On Sat, Feb 22, 2025 at 06:34:21PM +0000, Parav Pandit wrote:
> > > > ib_setup_device_attrs() should be merged to ib_setup_port_attrs()
> > > > by renaming ib_setup_port_attrs() to be generic.  To utilize the
> > > > group initialization ib_setup_port_attrs() needs to move up before
> > > > device_add().
> > >
> > > It needs more than that, somehow you have to maintain two groups
> > > list or somehow remove the coredev->dev.groups assignment..
> > >
> > I was thinking that if both device and port attr setup is done in same
> > function, there is knowledge of is_full_dev that can be used for
> > device level hw_stats setup. (similar to how its done at port level).
>=20
> Again the issue is the group list, so long as we are setting up attribute=
s
> through the copied group list the whole thing doesn't work.
>=20
> The group list is used to avoid startup races with udev, so this is a bit=
 complex
>=20
Yes, I was suggesting initializing the group early as done today, if we can=
 move the rest of the port sysfs also at same place.
If that is complex, we need to write the ugly code to store the group index=
 to blind copy of group in the compat devices.
> Jason

