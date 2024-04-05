Return-Path: <linux-rdma+bounces-1796-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C049B8993AC
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Apr 2024 05:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010331C224B6
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Apr 2024 03:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8D11862C;
	Fri,  5 Apr 2024 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JcnWs9WK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2121.outbound.protection.outlook.com [40.107.223.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0118E01;
	Fri,  5 Apr 2024 03:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286825; cv=fail; b=Vh4HZrWIeCWNmjUxp++emcJKcPbr1oBgrTtSbE05nOedcMxNh2VVSFIOTdAUm01lZ1Wyo73zhWXtUfxq1rwQR01EPaPnZkptkPj73RmfNgTAoeiBUMch+I5nPZ0ALJ/QiG/fbndcdTdL3KXK4IndBjIuu45o+BK1LvkqOCBbfrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286825; c=relaxed/simple;
	bh=3X+g4hTWV34v19rOqQtP7wmTW4lcSqgUtfGOf4iTXho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=okk9JQ8xigopAibHnNjgq0n1B4Kupp2H3DRY3YyOlyghb6EAqGJgDrXYIU1hzT09gkdAGG7rOZchYhtgwZBbqqcqyQy5iKtBw1hCoeDvau7sPeEeRvHCFzDmm/uvWzHMm+ox/SrRQdATcD85fONrm1d7Wbx0qvris+l/vwcMwvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JcnWs9WK; arc=fail smtp.client-ip=40.107.223.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py92vQ9vJWSXapDP89AexCPLUFjPwWJkWF1dUdCLn5dEPPOQjQetGNfJtBPwFBpx3lZQkSD8B3JHsF+lZQhO7PAXmqUWRA0XBTaFmpXrogunm1yRcFyWYlUPhee9ZGt8DunLVCweHSHTH7PAFKbCkGsUJenrwr1Ij7tLlWrPjpX+5u2xnZcSCyZJdJCP2eaN3xgwzF9usu72lE3eFdJFGifHEOlTkIjaM8WnLCTqGIuTI0+WpXLTazUt0NZL+wgxFPUbgXQtnjOKcGwLeekfftgrnQTZlHZz6xJvKx///zkUMg8fYACYTlKGOMs73W3fWuyYv1qO4YrbgLQ7DPhEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3X+g4hTWV34v19rOqQtP7wmTW4lcSqgUtfGOf4iTXho=;
 b=C3etcj7PYMj0WUPyWq75juZInkUG2/AvHB9zetbw8b2SZAQBMRLDxqie9C8l4+0aTKvZNLEZoYjUlXf6D10wb/QZ2v/XCYAXLyhh7+OKwl6CnYaCa9qdQdyLCVC7W11QKlzFyvxTtElXjnNEm2cbvQ5Fl1rYk4Bmzr51tFBfZTBJyGYvHNOwO0mHiPeu7JT4X6qkt2LZ9a+hp9TI8MyFTrojxTJv26KVXisxBJVHq5fN+y6fyFwv/lnRKrzB/dcSmCvnntR7H5BzFYYoUjn6V6pH9zHhGzL4VVGSCOBe1fKYkUYeAKI1HwVMGXGFDbXGgSq1Bp6PIryBUOQAzDddGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3X+g4hTWV34v19rOqQtP7wmTW4lcSqgUtfGOf4iTXho=;
 b=JcnWs9WK0bCMsELnG1X+YaXXSg0HvzHCUUEJDx1Y8ac2TQ7lwO2E0aEQ0fj7iTUxc5JV+NmjuNX7D9Ie7MTXVcPyYjFC6B6spmoFIJwNe5YpZ1M0T53nvRThP+97CSHa2yWbpPsErLq9CaslbRYX11ZnjLUlNztzXvGV3ANgED7uAA6mKrw8XMv+i8uv7K1eoQkpwM65WdKbeFTNRHl4XkuDDA7kqMjdvzBdXs9WgcjR9hkww3lytLtZ7GEabyk907gtsY9s9+QERBrv6Fb0o1umfrrZm66urC/2EXoosn/AVjA5gok1qJDLQSSHntYwosnWxUfffp7zWbeHEChjEA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 03:13:40 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490%5]) with mapi id 15.20.7409.046; Fri, 5 Apr 2024
 03:13:36 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>,
	Saeed Mahameed <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, Shay Drori <shayd@nvidia.com>, Dan
 Jurgens <danielj@nvidia.com>, Dima Chumak <dchumak@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Jiri Pirko
	<jiri@nvidia.com>
Subject: RE: [net-next v3 1/2] devlink: Support setting max_io_eqs
Thread-Topic: [net-next v3 1/2] devlink: Support setting max_io_eqs
Thread-Index: AQHahe5FgfZ7dsjCtEiNfhPRFPDDgLFY8/iAgAAIH+A=
Date: Fri, 5 Apr 2024 03:13:36 +0000
Message-ID:
 <PH0PR12MB5481D604B1BFE72B76D62D37DC032@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240403174133.37587-1-parav@nvidia.com>
	<20240403174133.37587-2-parav@nvidia.com>
 <20240404192107.667d0f8e@kernel.org>
In-Reply-To: <20240404192107.667d0f8e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN2PR12MB4239:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5tcX7W4IWDj6N7CLMJbAxaej7zbHPDIA848eM+rvMWchrUeTKv8W6ek3qqtxxdKZnAl0ZlhBL/oa0HvlpjSrOl7ynZtKGSFQYTNbpo+PliqPM/G9QS1itgXkP6cQy4EmZJ8nWa56dVbnAsWopeUL3geE3nwYBDf/xsZbUCVQqgHmGwhux1V3YiOZBd6lGR/dyCRf1ZddVUZHKbjfduV7ouyoOqXILarSGGATrWjzOGy7Ik1aJLFi+Boq8FIoO7T2YqhMG+cNnUbPec6DbnkK/b60uAVIzxKQUnghOyEKr6Zf7Ce1AsBXz+3Ed+K/nr6etCT+HZ0j3hLz6Zm7lPf1zGAyld+EHElZXjJdMyCy/7eK0y9bcITTKEUCkY01D7RrUXcnS+tR6OEhdGj0MnUW4XKIDWMoQPCkS1tLGwt/GAMfBQHEEC8zAzx+hc89cWCVnW0JqqNAd7bHT8+bW2G87MofXePFETO82tvWataHsiTgp8A6nJ2miTTTCcRxK/k+TDi4p+ZDvInHShqXF4aoWreCro7elONU8+IFt1lZOx9O03CFy3szyBgLGVjCFq+0pbRb6tQaLrZ4PRhibns92nE1JmXIy5N/Jg4NJ9LaX01+LPgzB3/2m/kJ0UNqbvMvwzhG+8QHB44Bw8QysVZ4KV/nZWtLxrZmxSWh0+3u+EQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lW5hPci9HWW7EDLoI/oX0sGzyaRH0X/d9RjZZetlDbD6bKWzyiUMVJ6XpdYn?=
 =?us-ascii?Q?/ad5xyl9skvBfNsnJLvhqEWgXYeHJ7jeiLRI+mcDBNLYkZYRYIpJSqqIMD6c?=
 =?us-ascii?Q?oifUl5yJFPj/872bGqLh8D0ekM/y35TDizkkPZyx0I6TJ8ZWhq2esBFCXj/U?=
 =?us-ascii?Q?8rQGvRXkMUUwaXfWJLQCmJ5Uza7jKMy+QgsnAnarY8slfvkvanTzAaV6RUre?=
 =?us-ascii?Q?V3vUe6MgV703RC1feq1UULNaf1z8aF11o5S7nzIt5GRnREGIzOIjwHdIfk5M?=
 =?us-ascii?Q?cOciOM0QSn9qoLVzcGoEDFzwbxyfvB+CnzafZV6PvOun6P9B53niPF585ve3?=
 =?us-ascii?Q?d3M/Bh+FpfQJs4Fw+bPMYK8Q+KGNsLeUO1AOng1SaSn4KFO8KF4hPoxk086O?=
 =?us-ascii?Q?9Ji+51SrcwzD7r7j3yuaRAw/2VenQ320w/hqxLjBbhvstkTGR2icHqF0hETv?=
 =?us-ascii?Q?szX/MoyII69Z859E2gZBmHfA+6wjVCJA7+8XAd4TukwjEY/GGLYvz8ZU8Fmb?=
 =?us-ascii?Q?1Lc20mBESE9XPrYRgWrao4D1nDBRcM5Qiz88V7a6OEv8iA8xPMrWA7ubAarK?=
 =?us-ascii?Q?SwJ335cCYrFGpQNDGxjIu996k6fWQEhnbnf5gii6uhYeZdH90cwNj89Y/tHQ?=
 =?us-ascii?Q?pXl2sz1sqwuwqssTm8gVWDdum6SqzXBhtGDth2F5xVJcvdrZiSftlutJN1lc?=
 =?us-ascii?Q?iRGVXyLb3YeFPinjGeb29Xs/mVwQFKxJjqGGlwkm6PYsHbkMQX7gYzaBWAYe?=
 =?us-ascii?Q?XmWTOScOAZn6EEIlqxkGol5X554bg5cXJW+Xh7AhS/VMNxtJAuC+ekaWy+2f?=
 =?us-ascii?Q?EW5s4PrxEWZtE/wTXCi3vyI6SqBYopA7jokQo3cwIZJAFt5EE18wXVO9f5UL?=
 =?us-ascii?Q?jbPCO2kBj7Plji4iARTc2lTtkJJKzTrUB2Y+3sMd74zYkJ1CeLipBENbZ1SJ?=
 =?us-ascii?Q?zXBHSaeJxLUxuBPiyrE5zJrzGyItyVTJi1pCKXjHhekMRxpw3YXOWX6+tfjE?=
 =?us-ascii?Q?pZkZqsZTHM3uTFQ/bMidhnel/0lLElHAkVDk6wsIVpGpQzyjg9jYNuwMvDVO?=
 =?us-ascii?Q?/uJrMvgEUk5/Fw+5W8REypPtHT4cW0vsTX78EqkWqYQu9fbapI0LzYRQyVkD?=
 =?us-ascii?Q?saBKSnjrRIex9goTEEdpsRxZ9H0ixRkGggvVSsCKRtc1MzXUGNchT2prJLO8?=
 =?us-ascii?Q?2i+GjpKzs60ZbRjnixQ7tVdR6QYATFKGYFv4Mj3Wv9Dr7D+vG71bsjmjJ8E8?=
 =?us-ascii?Q?ensUfYM+8RIZ40/HsFrbt8gO3M3nINfppQXEQZZ5hYGGTegK4sVPSY4ZEEdC?=
 =?us-ascii?Q?EEq157kdVoH+Mcvbrg5BcVXDl5RIvvNTPY96e084hql+SOMq/RFKJpuqxQK+?=
 =?us-ascii?Q?8hL/kAa50DnPyDKr+kcp2y3Iy+yz4hqQaDzSIUpa44jrVjINTY5wXEL6V6K/?=
 =?us-ascii?Q?P/WSwieATM8Fe9Rm5Os/hWLr4s0FKDCY7oddfIN9PTU5hpV1aCHVe7EFJyiU?=
 =?us-ascii?Q?7+AQZiW1iuJGwnRSl9i3NE64GubeTQBinUbP/CFaNHbVS2bYQEIhXohR2rX3?=
 =?us-ascii?Q?KDUDYYaMteItNYnc5k4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380a694f-d294-4ae7-ebb7-08dc551e6218
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 03:13:36.2458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UZmEeZQ6Ym2qMLGDFLsO+l+bqBLLdgzpyXCAkDijrMQtrOZ9fPaVbC+IbmflLHKLeelGCwgJDpX+kOef6c+vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239

Hi Jakub,

> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, April 5, 2024 7:51 AM
>=20
> On Wed, 3 Apr 2024 20:41:32 +0300 Parav Pandit wrote:
> > Many devices send event notifications for the IO queues, such as tx
> > and rx queues, through event queues.
> >
> > Enable a privileged owner, such as a hypervisor PF, to set the number
> > of IO event queues for the VF and SF during the provisioning stage.
>=20
> What's the relationship between EQ and queue pairs and IRQs?

Netdev qps (txq, rxq pair) channels created are typically upto num cpus by =
driver, provided it has enough IO event queues upto cpu count.

Rdma qps are far more than netdev qps as multiple process uses them and the=
y are per user space process resource.
Those applications use number of QPs based on number of cpus and number of =
event channels to deliver notifications to user space.

Driver uses the IRQs dynamically upto the PCI's limit based on supported IO=
 event queues.

> The next patch says "maximum IO event queues which are typically used to
> derive the maximum and default number of net device channels"
> It may not be obvious to non-mlx5 experts, I think it needs to be better
> documented.
I will expand the documentation in .../networking/devlink/devlink-port.rst.

I will add below change to the v4 that has David's comments also addressed.
Is this ok for you?

--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -304,6 +304,11 @@ When user sets maximum number of IO event queues for a=
 SF or
 a VF, such function driver is limited to consume only enforced
 number of IO event queues.

+IO event queues deliver events related to IO queues, including network
+device transmit and receive queues (txq and rxq) and RDMA Queue Pairs (QPs=
).
+For example, the number of netdevice channels and RDMA device completion
+vectors are derived from the function's IO event queues.
+

