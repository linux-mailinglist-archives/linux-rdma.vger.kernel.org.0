Return-Path: <linux-rdma+bounces-8044-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08997A42627
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 16:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A43174FB2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304A218BC36;
	Mon, 24 Feb 2025 15:16:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF651624F5;
	Mon, 24 Feb 2025 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410217; cv=fail; b=C1XyLjvpOXwk0ZTfn51nWKe/iB6EnPRgqBlFoO+sxLDiIhiygLSTY7WBIlwQmAXpM6uOyOK2MDp+7KHyylAXQK1SgNiqDKJh5c/LB0Ye1E08ORh7kBJZFjbGTpmyuw3b+58xbRgEYnC3v1BwbPrtTWqC0DyKzyVo0dai43CmB0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410217; c=relaxed/simple;
	bh=dJXmnOm3Tk/9CZWZUFWckBd55vXLQnLY8/NeO6atvv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NEkvi6EPvO1LaeYOvSNIukv3eLWQ0XMVzNXSNZL9K58hIggcEMfkXGQ4N8qvBsk8NctdTL30qYZ3eBlrHHJbgtZyWpvEwIh4keLpSGKBPDC3pc/qLXpg3e/tYm2umI29vr2sLNME3jCZ1tUFTd2Sz4pkpJ4Mphu8aVg8Ghrkqjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com; spf=pass smtp.mailfrom=mellanox.com; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mellanox.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsqW2Aesj1MoD6HpfghAqlx2dTiG1bV7fK0Zvj7Xjo/dY/Fu+VvIBloKxUzY3uw+u6wqSdmkYjCuKfwy+oKDYKK2BKBazIsWyoGfQ/Ih1rKLrBqlAxgxTi4lSt95PP9Km9n4c3NVgFGOdjoHnKsM0FMDhyBpUOGKyEGWOvocYF5kj17hqDSsdRO5TsPZs41iln1c2HbBnktHAasq5+6NryHzDgMH7QhauG5dHnGKg4VieQEDqCPuWlebzcWVGDKEHAAIZreZCeUdJLSAawq+GeTwAEVkCP3VoGgSqQav8io20vL/4TwwwrZLKoZU90WONAQTcBDbhIu/odfRAFw8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJiWK0q6ryBgQfdpy2Jm/vNzI0Voj7eixBs/SJVvfEg=;
 b=xyS6nLq0YEuOjcoq2V7ohZmuiczgVd25/kov4P2wzfKFo1nvZcib2as+ZbnZ4lAldrahyKejx+NNEaXbN7VItbmjIfKw01GmzroG9Yb7dNO2LYnEeykP31flTxrBBpwkH3WLPpbTk4iNzmtL41zcTR+gY9XFIU173frH56D02j+lep/ftjW1NgVJEpVVlIqpt4Lrxm3I9h+E4g66GyOt3A2vl7HWxdbIOZ5XVvg474wcrNF3YI9IFns5HIjRF4vQ3D2gJaTA0bFteedSebG0+TLOPZ3jgj8nbjgH3qP0cjNwHVgtPPAGPjXK670RoV+W9B66Ymk2lSOEAEq5AiiP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 15:16:48 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8466.013; Mon, 24 Feb 2025
 15:16:46 +0000
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
 AQHbhAUwblJ6/3JzXkikuf/dEO2jkbNRFADQgAAVSoCAAADUwIAA3iiAgAGcjmCAAu/hgIAAATRQ
Date: Mon, 24 Feb 2025 15:16:46 +0000
Message-ID:
 <CY8PR12MB7195E91917FD5329932FA3FCDCC02@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250221020555.4090014-1-roman.gushchin@linux.dev>
 <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250221174347.GA314593@nvidia.com>
 <CY8PR12MB7195A82F6CE17D9BDC674D72DCC62@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250224151127.GT50639@nvidia.com>
In-Reply-To: <20250224151127.GT50639@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mellanox.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CY5PR12MB6478:EE_
x-ms-office365-filtering-correlation-id: f4dd4011-d4f6-4bb1-a68b-08dd54e64131
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?czmVeMIeN1+anHjZOoHhpFfu1uxHShVyaZU5bgIB098fB/Zbk/7Ud1EPR0n8?=
 =?us-ascii?Q?AlgP3+J2a7frPK8po+0LWvZiVbOJc5XOxQEzkyk0Gp5hopsGYWmlDc3QPxmp?=
 =?us-ascii?Q?+VhpqTnoOhXgto9GWNcyp87OpFMstB5Sdp4H2CyRx0gmp38fNP047gCWMtu8?=
 =?us-ascii?Q?7CjBAPXGBSTACM6MdXo9A5V+XNVjBRZ00FTnQZ9cTJAEcOLQZWW62Qzi2Nda?=
 =?us-ascii?Q?5atO+WLSTge7+9rrgCC8QWn8/p4g1ad+sqtUL68SQVkdVtR6yc+9RateWNAm?=
 =?us-ascii?Q?i8t99Gsai2KyoGBTMgYrQukVyoqX3UGfA4rSDPI15BIWLou2PIep8iz7CIgz?=
 =?us-ascii?Q?NPfHLM9tbRMOwqP7j2lNrJHSJl92nNv0MdyDapXSwUwlbfrFODZPdr2gAfrK?=
 =?us-ascii?Q?nApjTV61hqlQWDRFkcNoHdoGFZDpAuji+F+4HqC10onTxomp2W569coHBnZk?=
 =?us-ascii?Q?WdtB0soqTVAMTyoZ1scXO6Xe7CL7K+VOjxwU3KGQvhOR0C4D+xa5pY+pj+Xc?=
 =?us-ascii?Q?09BSl8oic9hD1YXF3HoqtrauJQrljiEy0LFop+ukNxY3OLee3bW+kh/5lnw4?=
 =?us-ascii?Q?I+zfMoA8CzcvqdH+rPkCgd649aW7purJnY9hnYRtfsNse72okYysiUcddl3g?=
 =?us-ascii?Q?kilXGOxMdY0NXaS5Gx3yohjc1Vx6p3cuaKElYswJQAdn2S70vEG0J4090vV5?=
 =?us-ascii?Q?zK1/q3xB5c4D7ZxN9RylRNgxWngQLfE08uMG4yNjINhXJEXRdfBVIJG2fk9G?=
 =?us-ascii?Q?vYdkJd2WIGMzfLUMn52iKwfQoQf3NzR3hctkHnyzadtNhSqp3/NmNU/BIsIo?=
 =?us-ascii?Q?gdR2Xubg+LN6EpNccZQYUkR4p1kBqxzEejoGlydErFo84wewn7frg+qESQvd?=
 =?us-ascii?Q?cmfp9e1/9uZUb6WKhCNRtTGXkfuyPMMTuIkRVCZBV5MHCPyGQD0SvFqHA6+N?=
 =?us-ascii?Q?qN56YRHXeZtwfheTN5TZ/CRl/rr+4nj7RpMpQRBTjpNOkn8ybTlfqUqn4SCO?=
 =?us-ascii?Q?Gcxg/okwuXVJh2nHXqkUT0S1aUhAI/DOqtBSbAIR9lhz3kguozGDSFzOcJH2?=
 =?us-ascii?Q?6013qUnw7rJOx/BLP9g1a5A6zNeF7kuyUFG3t+fOOGK0KuTFqFgeGrOOqZI4?=
 =?us-ascii?Q?MwPJIvvpdUFDsO70uuCoxD7kM6DLc1/JAnIf/zsEFVh0HGF/t2Pek6X4UWfS?=
 =?us-ascii?Q?v85zVf6pIAKdpvd3OSWqnQLeCFElgD7lgR4ZArWcQK2twNc9mIqsn4i9GQ9a?=
 =?us-ascii?Q?fXSWv6xri+ZE20XzW8e/cXajoNI2pzlfeoI0SfgCV6j/9+fxAC+JaTGxJhPO?=
 =?us-ascii?Q?tnmk0KxLvGHh6ThX09x43UZ3N8VCWAShvdGOixBOgRcIDInaoRJQk24AC56U?=
 =?us-ascii?Q?M7A7T/xbbS9AQgj58TgTFHH0Dj+Uxhz/KI3nnJtdt+kntWeK2F15KGRxrFzx?=
 =?us-ascii?Q?I9u/N+X/q2rh4fMpbttPdB15waAil/DS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4Exl7TF2oQaDFogcILrCK/FdLYPckywb19oJrBy9JD6cNnSJRvBVybQ7rOSQ?=
 =?us-ascii?Q?ZSYbZFpvn+UVDf9Wx0vJF1B8ycUelAf2LCYYws8wj3hb8dCSdPsGv+uVdt0o?=
 =?us-ascii?Q?ZLONF3thwLcCKHSk/dxls+Lh8q8CXe5ArJOak8PffZNyn4LCXaxkNWIFflho?=
 =?us-ascii?Q?RlQTpMSz+uktbwMZkVM9565JSte3QSINxSlpKHyKGc6IgG0cV3HH21PFqFdG?=
 =?us-ascii?Q?+Hgue1OlmBINwtZ8vl3GyzYvZ+jJn0quczaNJzDKN10hOOUXA+L3+l0X31lB?=
 =?us-ascii?Q?BBnzNGbXbjwaeYlyiy1cU5bDtb/0XD1nLF/zR+tiHEADA22y8o1IDec2UlU6?=
 =?us-ascii?Q?dceEOhV8qyXtidKirl+96Sf1IPLw6pLx1JyC7vSQBdXUIOos8POHrA7b6GnD?=
 =?us-ascii?Q?1XDcBg7RofZiSvDebhtfMSgCUHywO4PCNNCUptLR2rKoepHXej4gNS/JJpW6?=
 =?us-ascii?Q?Lu0LA6q4nzIVYOr5PUoEu/LUrYV+PTabFCtXNmX7hWp9RhmI0WX88nAYxksh?=
 =?us-ascii?Q?3CkpfDM8i3zUlQXwI8ZKq0JaOZ9OipqxPkwvDfd1+8gCW/y1po2w/PrAf7Dv?=
 =?us-ascii?Q?HAYIHi+FYlo+e0gjrhOIhfIBP4mKlJDZ5JAI+L0mQwklmIOyB1GiblUlb5g5?=
 =?us-ascii?Q?EY3ooKvJjXhLpYW3wuE0nWWGkT4dA9c8FlPh9YvKhku4A1vk1VzTHNU5000t?=
 =?us-ascii?Q?XLqhbjowLZO7frouvCAS3q3fFo+EMTcA/HBHQR9jAtLIEYKimU8w5XRlnihc?=
 =?us-ascii?Q?OaRjVJRT+pP5X7vlcJR07UcZBt+KHQnSfXcmYwIRhnidc38cwayJ3M1pGRlW?=
 =?us-ascii?Q?jhkgaqy7iDay6GOC2nekzaX63dzWfkXuBhzEdbh3DxTWP67PVvZ7u5A+vpEq?=
 =?us-ascii?Q?GEPsu7T5FERitDVw+uYyaQVUyFv/dJktCwJKPR9kTbv7g68JQWK02kuHAgtM?=
 =?us-ascii?Q?Y6iiK5jknkL6vv8wF10kKZsd3hfH7mX3X3vvHyhsjMB15nuqWN/tQ5E/avEc?=
 =?us-ascii?Q?JUj/dK7twR+wuqCRxrDNAGZxsB4vItHOmnVOc3b31wjIXmqhUznkbHPyyhWY?=
 =?us-ascii?Q?DaFQI9HCXfhzJ4uQ7ZrqFOkb1plm4FjkEtTAGJ9fTbz/syOyBY2fH1N8rVmt?=
 =?us-ascii?Q?NGfaOJtlb1iGLkatNtAYIQAF78jAFZk0ppOSuKMw+tJ8/nGDdbRqK+BSaX6B?=
 =?us-ascii?Q?K/DtpGR8XGtQNUO6t0D/ec/05j+0cz4vHcWRAVOaTBdXq7L9fHVzUiDNHdH+?=
 =?us-ascii?Q?2+xD3GpgCFGPd+Iqh5lcc5Y0gQVbLIkONZPW58d9rU8zVSRIpw5lQQskYL8H?=
 =?us-ascii?Q?e4H+C1b9prqv63OoCqr+OmZXSEozve2nA1nFR4i4/9lxlNkAY8WMCz9ctpyn?=
 =?us-ascii?Q?GxTpT8/TZ8Sw4Fdnl//kymuq9QNKqyW/1LkgwwNn3TkP/QQQchqivqtT8017?=
 =?us-ascii?Q?7bstG3mMQLsbb8+SjqTlZtUhrmP8I5edWnZ2IXW3WdYRkDQ453Im3vaBEU4w?=
 =?us-ascii?Q?7VpIyTAd0LMSCtJleDNmldBFewg1VE9QxqzYwiUUd9R8QmZcLx1GObYIWVB3?=
 =?us-ascii?Q?BF9ZzlZrdSTY3u8nOj9/nM673miPkfi06SARi92zXubvj9ZT0cq/RNS5ECxN?=
 =?us-ascii?Q?qTm3SjXRJ5JQGwHuJw/4ppjou+5wbzgmQnRMG9bmYsNh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dd4011-d4f6-4bb1-a68b-08dd54e64131
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 15:16:46.9402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: om+XMzrCzXrWyGAE8s6bnB4pjLJDRPW9fPEJJvKYAu2z7MhpCtDjH0Vi8yqdJoJ+/qYUnsMnpmTP7Ft9RqhGYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478



> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, February 24, 2025 8:41 PM
>=20
> On Sat, Feb 22, 2025 at 06:34:21PM +0000, Parav Pandit wrote:
> > ib_setup_device_attrs() should be merged to ib_setup_port_attrs() by
> > renaming ib_setup_port_attrs() to be generic.  To utilize the group
> > initialization ib_setup_port_attrs() needs to move up before
> > device_add().
>=20
> It needs more than that, somehow you have to maintain two groups list or
> somehow remove the coredev->dev.groups assignment..
>=20
I was thinking that if both device and port attr setup is done in same func=
tion, there is knowledge of is_full_dev that can be used for device level h=
w_stats setup. (similar to how its done at port level).

> Jason

