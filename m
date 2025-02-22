Return-Path: <linux-rdma+bounces-8012-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F41A40B01
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 19:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DF43BFF01
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 18:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A36920E32B;
	Sat, 22 Feb 2025 18:36:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAC320D519;
	Sat, 22 Feb 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740249415; cv=fail; b=rKu3u4JsEwSpY9jm4AwLOS5PJTAIae6L21Puf0q3AHkjdWGS0ahzLK6jEw4ZFpEy9wvWVcfBpyydyNLZ9w9J5qktYaa+uoZ6vwsacb6B5ie9TWDwe6Ox5UaGhGevka79bsBzEAYtUD9BQuXA4hf7u9BXyAnVMLNlReKKOpK18Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740249415; c=relaxed/simple;
	bh=rtKGdATo+2Y+L7WEzwRSbl2PWezTCosJGkOElI5ln9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i3tZxjqfMX4sEYor2+pzKyQQUp9YQwe49RBZdzVZWfP1G23pLyaS4oJ5y0SnCrLgo+VTyOv+QUG5q4sy3hadQ0ivYgX8BO0aPUMUl/SUA0yXls5sEbbeBJmxmIdHDNODBHouuUm+FkpG6+PFhQyWyM6Tl03erPjO63oNx/diQAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com; spf=pass smtp.mailfrom=mellanox.com; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mellanox.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoZIEauqXfJn/LTI/tRjnI7+gelbn0FbRGQgGHdh0zVEkskp2OL5fN2AemUJhgcuB3KsygtCFL6zKaK7/4b55hqx5V4Qsv0AGQeU16Q5h0+6p7yS+fHC5z3leiX2pchIWyDXWpQhOtxIWHDk3YgIT8ExE0utQOKTyOnnTAkZdgDxv0E4WZ0cpq9U0c8kMmz5NyzbnD7i7IEhexIbIf4uPFmPS4I5ATwbJtpEHiit9iJY7PmM1sQfwF5hG3W2dWeaA4FaxgDjhdHjxYvXAmhJXCa0mekHp3Od1gXvF29tjQTk7cPRFUu8we8/a4vYsL0jwXi1jdNbI2uPQiPgP5umqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oePjd+8nK3qmFgsbo0LVr6K6U529pe5DjzWdGo1bgvw=;
 b=GdugMPi8Y5UnDrqexlJFnmOD8XLq9fI5bcQkbfKWWwgeAf/ylJjs8Trn7syL9gkcxZ+Ii7ffHEVKCOx2W0nBYogKHQ1RxPthCTiQB7WZqeP+39KpNtj0Ulcam/egaIt3dLuJnYw5Cj0DTN22mpg41oGShc8DisgPkCEdbPvt4tasYFDmk01C1AoaPxgD/fmJUXuFypYg4IDp8J35bwNlkxMXqgOlkMdkLej4soLa5rX97vz2vU3IZN50sJRoALWtE3eQmx1V47VIzraPUQGpOdM5TSd/da+stvkHKLJpgMSsbUj52uxjsu69odn9VABSgSJWlZyVBXm+1+rxBd2RRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 18:36:46 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8466.013; Sat, 22 Feb 2025
 18:36:46 +0000
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
Thread-Index:
 AQHbhAUwblJ6/3JzXkikuf/dEO2jkbNRFADQgAAVSoCAAADUwIAABdeAgAAzsuCAAMtigIABec/Q
Date: Sat, 22 Feb 2025 18:36:46 +0000
Message-ID:
 <CY8PR12MB7195D4AD9844C91313955AFCDCC62@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250221020555.4090014-1-roman.gushchin@linux.dev>
 <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gF3UC7PvVxeRcq@google.com>
 <CY8PR12MB7195D93F387845E0A7314C34DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7jb1z8WSllnFFyX@google.com>
In-Reply-To: <Z7jb1z8WSllnFFyX@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mellanox.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|MW5PR12MB5651:EE_
x-ms-office365-filtering-correlation-id: 0c6e427c-b61e-4f6b-9eee-08dd536fdc84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iAIU8iLGvgcWNi92YNuOgzFOQjakiOP3DLcDyokI4BwSm05SY2Yn0dZOCfjk?=
 =?us-ascii?Q?wU9KIOdV2VDOwwb0b+1/Xoq9m1IL41VU4cHjzh3HdmpOwmMQp+0PPgCeULgG?=
 =?us-ascii?Q?s/4b1yn7NBqLadcfNzzd5JIn41RRi9hDzUecoJTfKdTkzwoQUUYDMwaDvUlW?=
 =?us-ascii?Q?aaq272PJr6dfIWgIJNbcvlHBQNCaxEvbKp8VCqTUPmT8AnQEgr5dWwhChvAq?=
 =?us-ascii?Q?dRoJr3waX5aBaL2bxNy/AAlYgLQLnN0+fckcscVTaTnEvdFEv5zO/5NGDt3L?=
 =?us-ascii?Q?V//AoHsVSBju63oSH6Jb2n1QgDFifE7hJHxIJZtC8otb7FownAY42kEPxZBr?=
 =?us-ascii?Q?Arj8F//PeCsVJSrJwRFtnrNsAEl+lwGW5WQ4A1XliPweIcEbGAczZT48vkUP?=
 =?us-ascii?Q?j1KUC0+owwrCq7WybqXYjvm92H0FhB/WrlsH/aa9dhjBgCdxvlYuVxgLKal+?=
 =?us-ascii?Q?d3Ofe/+5JK+cAKaMlF/8kPSzF6ycbGbdo2VPc7LbMUZDg52yQQtL4fGHiXsK?=
 =?us-ascii?Q?TbH2l7rA5jnqrzPtSYgOuThUEvnjKx1tXUObxf3IKJ30NSAnY0a78HUE3yjN?=
 =?us-ascii?Q?QL8Xo3m/zcuMKPDG7ObkpuafzBwJVbsQcC/lgMDAwx/jq+KL5aJCPRZWRvpX?=
 =?us-ascii?Q?AXPaAY93YeM1wRqt6YpwELe65At9c5pmYc2m8TNwTao6H6pcosLqVt2Tn3HW?=
 =?us-ascii?Q?Ns9ksSfSL7ftUDzNiddw737zO7JPnJOdBKf87w7dEYhaDsvMVEirgdEDyeXx?=
 =?us-ascii?Q?fl/3KMjZ+Du4tcJLo9YXIwdikaqOhnSJXmBM6CH1jy+v39MBxxP44Snwv7bQ?=
 =?us-ascii?Q?qKnRuuNI6qhEUOLtYl/1gytEFO9071Xmv38BOhPtM7bXLut5AYTDtVSGz+Fk?=
 =?us-ascii?Q?b+jFMQu3zKLgvgvEX1XXk7+tm2IYLYV8Q6wNbBQHHQIMkTgOtNAZCm+Na7S8?=
 =?us-ascii?Q?jK3xQn9fvKDPqNmLpKS+pvwvXeyrWclBMf3B+FZ0NrjRjD+MzkZ8kFFCypOK?=
 =?us-ascii?Q?yPP6QY+Hc7vJeKWXQ8xtctlUMt6rMqEhpTjBuU1lV7j0dJFfQpFp3XJ0dRfH?=
 =?us-ascii?Q?8ccOFvCpZ1HNjPkaqTen2OeEXGKNBjiqXHDZLyLKpfl3pDQrD2gpa3PbH15f?=
 =?us-ascii?Q?SIZCTCs4kj0yHlT6sv5ZBcDIbSzHHd9jTf+q4jG4bW7YbgjDK6XRYoEp57vE?=
 =?us-ascii?Q?sxwfpK+4QrEcC2jbZGlD9MhAIwH9SsNokMG/T3PBg+KigcJckfCYF9EV6DHk?=
 =?us-ascii?Q?Z918YS80MjurrP9PkB23gmiyP6VNbMirGFU2MJaW2xMpIkIWy7Pmio63YnO+?=
 =?us-ascii?Q?kQUN9YyAcVQ4Dh+8vr/2jpCsgmDBX8uy/7U131Ypr1Mai3ak2FY84xmkvOKJ?=
 =?us-ascii?Q?uiHHAfmmD3bcnGic5+tlGQzHOxIRMXq3CLbfwv09yy56LZqesHfrnpJ9Slpf?=
 =?us-ascii?Q?NnDx3cwJZogYZXf9SuxkCsJNSBdyLfdD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wNU/aBlcaPiufReTiCPUgMft5vPIaN3/iLBehMcpLeRsyn27M6ZwdAm3A7o9?=
 =?us-ascii?Q?zKxklNXxqsm1c5n16XZTqfjCPhNZbasGjTv2JSiP0yR2VAngFzSg09qfxRVG?=
 =?us-ascii?Q?v+76GMayhjLoyCgxqylq9MmXw9ikcLnwDchCmEhcx4F0L8vvTzwaeXQ3Yctk?=
 =?us-ascii?Q?/aPRY67q6snW5qm8v+8GxPoH21V+fBCwHl67HY+I85E//UcxjvDp7/sdGyCd?=
 =?us-ascii?Q?dFhJz6tx+Siv4yGhgzwMVCtTZ9O1JzwDm8wVHb22ln/M1UCDzkkFkbzdU0nW?=
 =?us-ascii?Q?e+QmmSCsFaTk4VKdrsYG+momLQk8bskK1tJUK1YkxxfY+4GHYe3nhgMG6m14?=
 =?us-ascii?Q?J9aemrN8EzrnuHC+3csU+sOoF/End+9oo0kqVgFQ2m2xanqAVu5yKnJeTzC8?=
 =?us-ascii?Q?WH+AlTU4a7z0XACET5tCVbLV+cOxf/ktMXK10wF8TZm9a5b+pTDqX3PDoOjt?=
 =?us-ascii?Q?lOHpsXzb/gObH0Wdf5nPJfrvLVxK0oqxd5bSSiRIo7n4kfJO5zXt3DyA/V5Q?=
 =?us-ascii?Q?2+ztmO8EjkBjEsMTovATgSQ+98Qx2mbrLDuKBcJaUg/YzTChVhTv+STx4fYE?=
 =?us-ascii?Q?jPkkjhNB4eH3pWIIJDOBqXvBeyXLlJjeETwfsV8WDn0TQv8sfbBZfkkLHZrc?=
 =?us-ascii?Q?KtXoNEixhJnLYnOBsWv2PeMieLyeiNzEB2tbyFrA4gl6yju0ZRH+6hu3DGm9?=
 =?us-ascii?Q?6fG1VtvwbXjkVmnCWC7ZexmCK3B5h9RyTgcCyKTwPGhQrBgXJoCSeCFWF8NU?=
 =?us-ascii?Q?DDjYdWIt8uaka2u7oc4MLd7cBlGEvgpLgV3lwAfD7TrkYcNzolFRO2ghGemr?=
 =?us-ascii?Q?Yfto5kX6CELb6vPiprhEdm+JjGCE9eHWHmXsrW3/bOrJPZz0/ObVlm31Rt0L?=
 =?us-ascii?Q?lAFvuQp2SSd03VnXkSLHcX2R1t+ioNWVZNhG8WRmzNa6CM8RXiecEAkhaKbH?=
 =?us-ascii?Q?O5sS9pL63zRaYzJI6i+4IksPnvGY48JHcsj1jZey2/c6lc4DFEKUoNGHQ421?=
 =?us-ascii?Q?lcMuy113+crFyT/vZi3Fte8Kl8+lYG5BQvLBZzWkhHfL1K+FOp/tS4Fft9lI?=
 =?us-ascii?Q?GapprpcyzHaKJceqnqkBUWTlbLoNWDSiZBDx7Ec+Ko0uewKAk116/7cAnluY?=
 =?us-ascii?Q?cWySETDfQbYEgRFaVuvA2MAnV4NYi39MZPx4tkCOHj4KHWyYh5IY7sydzpu0?=
 =?us-ascii?Q?El0Nk61SyL+OqEB6rFuhgMkgxX9ASJWdmFERB0gpU8Q9FQdeRZmE4IwR6KhZ?=
 =?us-ascii?Q?IW6VD3tgdezF7+1N+ioBu35BdkUyQT73ZRLTTFH/y6DCrbXd/AaNf2JEF5td?=
 =?us-ascii?Q?wsXYiFAljPisngXaF8QdjCz/jc3I7O8buIXgXw53qnN8hgucbfM5pv3C+iJI?=
 =?us-ascii?Q?cvE87H0+8lOI83oA246lgdqMh87XCsfQFc89+QuNPOMA8aODlpCifTdyO8RQ?=
 =?us-ascii?Q?WsVQm4oNxr9Z5nDOjSBCLEn7pPmJ6pJKdCtRLlsZB0APevqOFoljngsYmsdy?=
 =?us-ascii?Q?IW+MgAMYpB9WXuqvp/O2+827816UJCXaclz9dFFrb4L76Tgv+RMLpuIFhyYD?=
 =?us-ascii?Q?k/jINCiBkJ0siiPkWHw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6e427c-b61e-4f6b-9eee-08dd536fdc84
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2025 18:36:46.2423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qtHYKJKe6ervrXbl+BozOUhon5j3QxmB6MJKvVBdkDMNhH3qQvFuO15Y/lPACGGlbZ2Dk2HqqdPvKZ5DA3sQ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651

Hi Roman,

> From: Roman Gushchin <roman.gushchin@linux.dev>
> Sent: Saturday, February 22, 2025 1:33 AM
>=20
> On Fri, Feb 21, 2025 at 08:03:33AM +0000, Parav Pandit wrote:
> > > From: Roman Gushchin <roman.gushchin@linux.dev>
> > > Sent: Friday, February 21, 2025 10:20 AM
> > >
> > > On Fri, Feb 21, 2025 at 04:34:25AM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Roman Gushchin <roman.gushchin@linux.dev>
> > > > > Sent: Friday, February 21, 2025 9:56 AM
> > > > >
> > > > > On Fri, Feb 21, 2025 at 03:14:16AM +0000, Parav Pandit wrote:
> > > > > >
> > > > > > > From: Roman Gushchin <roman.gushchin@linux.dev>
> > > > > > > Sent: Friday, February 21, 2025 7:36 AM
> > > > > > >
> > > > > > > Commit 54747231150f ("RDMA: Introduce and use
> > > > > > > rdma_device_to_ibdev()") introduced rdma_device_to_ibdev()
> > > > > > > helper which has to be used to obtain an ib_device pointer
> > > > > > > from a
> > > device pointer.
> > > > > > >
> > > > > >
> > > > > > > hw_stat_device_show() and hw_stat_device_store() were missed.
> > > > > > >
> > > > > > > It causes a NULL pointer dereference panic on an attempt to
> > > > > > > read hw counters from a namespace, when the device structure
> > > > > > > is not embedded into the ib_device structure.
> > > > > > Do you mean net namespace other than default init_net?
> > > > > > Assuming the answer is yes, some question below.
> > > > > >
> > > > > > > In this case casting the device pointer into the ib_device
> > > > > > > pointer using container_of() is wrong.
> > > > > > > Instead, rdma_device_to_ibdev() should be used, which uses
> > > > > > > the
> > > > > > > back- reference (container_of(device, struct ib_core_device,
> > > > > > > dev))-
> > > >owner.
> > > > > > >
> > > > > > > [42021.807566] BUG: kernel NULL pointer dereference, address:
> > > > > > > 0000000000000028 [42021.814463] #PF: supervisor read access
> > > > > > > in kernel mode [42021.819549] #PF: error_code(0x0000) -
> > > > > > > not-present page [42021.824636] PGD 0 P4D 0 [42021.827145]
> > > > > > > Oops: 0000 [#1] SMP PTI [42021.830598] CPU: 82 PID: 2843922
> > > > > > > Comm: switchto-
> > > defaul Kdump:
> > > > > loaded
> > > > > > > Tainted: G S      W I        XXX
> > > > > > > [42021.841697] Hardware name: XXX [42021.849619] RIP:
> > > > > > > 0010:hw_stat_device_show+0x1e/0x40 [ib_core] [42021.855362]
> > > > > > > Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f
> > > > > > > 44 00 00 49 89 d0 4c 8b 5e 20 48 8b 8f b8 04 00 00 48 81 c7
> > > > > > > f0 fa ff ff <48> 8b
> > > > > > > 41 28 48 29 ce 48 83 c6 d0 48 c1 ee 04 69 d6 ab aa aa aa 48
> > > > > > > [42021.873931]
> > > > > > > RSP: 0018:ffff97fe90f03da0 EFLAGS: 00010287 [42021.879108]
> RAX:
> > > > > > > ffff9406988a8c60 RBX: ffff940e1072d438 RCX: 0000000000000000
> > > > > > > [42021.886169] RDX: ffff94085f1aa000 RSI: ffff93c6cbbdbcb0 RD=
I:
> > > > > > > ffff940c7517aef0 [42021.893230] RBP: ffff97fe90f03e70 R08:
> > > > > > > ffff94085f1aa000 R09: 0000000000000000 [42021.900294] R10:
> > > > > > > ffff94085f1aa000 R11: ffffffffc0775680 R12: ffffffff87ca2530
> > > > > > > [42021.907355]
> > > > > > > R13: ffff940651602840 R14: ffff93c6cbbdbcb0 R15:
> > > > > > > ffff94085f1aa000 [42021.914418] FS:  00007fda1a3b9700(0000)
> > > > > GS:ffff94453fb80000(0000)
> > > > > > > knlGS:0000000000000000 [42021.922423] CS:  0010 DS: 0000 ES:
> > > > > > > 0000
> > > > > CR0:
> > > > > > > 0000000080050033 [42021.928130] CR2: 0000000000000028
> CR3:
> > > > > > > 00000042dcfb8003 CR4: 00000000003726f0 [42021.935194] DR0:
> > > > > > > 0000000000000000 DR1: 0000000000000000 DR2:
> > > 0000000000000000
> > > > > > > [42021.942257] DR3: 0000000000000000 DR6: 00000000fffe0ff0
> DR7:
> > > > > > > 0000000000000400 [42021.949324] Call Trace:
> > > > > > > [42021.951756]  <TASK>
> > > > > > > [42021.953842]  [<ffffffff86c58674>] ? show_regs+0x64/0x70
> > > > > > > [42021.959030] [<ffffffff86c58468>] ? __die+0x78/0xc0
> > > > > > > [42021.963874]
> > > > > [<ffffffff86c9ef75>] ?
> > > > > > > page_fault_oops+0x2b5/0x3b0 [42021.969749]
> [<ffffffff87674b92>] ?
> > > > > > > exc_page_fault+0x1a2/0x3c0 [42021.975549]  [<ffffffff87801326=
>]
> ?
> > > > > > > asm_exc_page_fault+0x26/0x30 [42021.981517]
> > > > > > > [<ffffffffc0775680>]
> > > ?
> > > > > > > __pfx_show_hw_stats+0x10/0x10 [ib_core] [42021.988482]
> > > > > > > [<ffffffffc077564e>] ? hw_stat_device_show+0x1e/0x40
> > > > > > > [ib_core] [42021.995438]  [<ffffffff86ac7f8e>]
> > > > > > > dev_attr_show+0x1e/0x50 [42022.000803]  [<ffffffff86a3eeb1>]
> > > > > > > sysfs_kf_seq_show+0x81/0xe0 [42022.006508]
> > > > > > > [<ffffffff86a11134>] seq_read_iter+0xf4/0x410 [42022.011954]
> > > > > > > [<ffffffff869f4b2e>] vfs_read+0x16e/0x2f0 [42022.017058]
> > > > > > > [<ffffffff869f50ee>] ksys_read+0x6e/0xe0 [42022.022073]
> > > > > > > [<ffffffff8766f1ca>]
> > > > > > > do_syscall_64+0x6a/0xa0 [42022.027441]  [<ffffffff8780013b>]
> > > > > > > entry_SYSCALL_64_after_hwframe+0x78/0xe2
> > > > > > >
> > > > > > > Fixes: 54747231150f ("RDMA: Introduce and use
> > > > > > > rdma_device_to_ibdev()")
> > > > > > Commit eb15c78b05bd9 eliminated hw_counters sysfs directory
> > > > > > into the
> > > > > net namespace.
> > > > > > I don't see it created in any other net ns other than init_net
> > > > > > with kernel
> > > > > 6.12+.
> > > > > >
> > > > > > I am puzzled. Can you please explain/share the reproduction
> > > > > > steps for
> > > > > generating above call trace?
> > > > >
> > > > > Hi Parav!
> > > > >
> > > > > This bug was spotted in the production on a small number of
> > > > > machines. They were running a 6.6-based kernel (with no changes
> > > > > around this code). I don't have a reproducer (and there is no
> > > > > simple way for me to reproduce the problem), but I've several
> > > > > core dumps and from inspecting them it was clear that a
> > > > > ib_device pointer obtained in hw_stat_device_show() was wrong.
> > > > > At the same time the ib_pointer obtained in the way
> > > > > rdma_device_to_ibdev() works was
> > > correct.
> > > > >
> > > > I just tried reproducing now on 6.12+ kernel manually.
> > >
> > > Can you, please, share your steps? Or try the 6.6 kernel?
> > >
> > $ rdma system show to display 'netns shared'.
> > $ ip netns add foo
> > $ ip netns exec foo bash
> > $ attempt to access the hw counters from the foo net namespace.
>=20
> Ok, it worked well. The following commands
>=20
>   $ ip netns add foo
>   $ ip netns exec foo bash
>   $ cat /sys/class/infiniband/mlx4_0/hw_counters/*
>=20
> cause a panic on a vanilla v6.12.9 without my changes and work perfectly =
fine
> with my patch.
>=20
I dig further and I see the issue. Its not the per port counter.
It's the per device counter which got broken by commit 467f432a521a2.
It introduced the device counter unintentionally in non init net.
And we need to fix that (instead of allowing it and opening more holes).
I replied with more details to Jason G in previous reply.
Please take a look.

> Thanks!

