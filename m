Return-Path: <linux-rdma+bounces-7946-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947F9A3EDD7
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 09:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D99817F8FE
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 08:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B154C1FF7B4;
	Fri, 21 Feb 2025 08:03:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AA41F9F51;
	Fri, 21 Feb 2025 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125018; cv=fail; b=eOdNyhagEWo2NxzQ0om1PxMdG2yVCl+u0gljsq7W2lNDxpjhlVMAmjpwXhGHrSDq2Vb6e2soK7zpqUduEy0sAjyjhA60rJH8UEi9ilVEIGCN17W1RSaV/t47ojVAT/gVZzEGPVVoVBj2ixrs4U2rhymJY2gbkPgalwvVad7Q/hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125018; c=relaxed/simple;
	bh=qRyOwlBxp5RQ4Qym9LwVFI2FmLakw/ryHnDxmlHiskQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AZzOWkZjwTqDzIzMPrTZsS/nyW6fW+BtVtucAJFeFct7YUwa7CvGZ6TgUxZHjYqpMbdY97DYKb+601NqL1KObkBhKFjBqt9Iu2BdU1dbuZkbFNabfcemE2m623RyTr+2aB7B0Ps6WYMF+BtPcsY1byUp/cnpF/YhcE4+k4tJ9mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com; spf=pass smtp.mailfrom=mellanox.com; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mellanox.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqjgwJrc9zIlCdJatL0ZqjRiPCc7aCNLqj8h1laNnVY/dgNiMkFqxplkTEWmxkqgc9LOtxlPgZO2DYCTu6W+X4O/Ni0GuhsGOc8TbV6sIwDJlLkVi8XfX6RYxIf1IhftN1SUQHsKL4YpbYkbIs5wFWa2PO4Z4k6JF9KF08hzEH1XfwunJa+TNf+xvwe1xrb7od6XApJpgxbZD/finmKOMS8eFzDHsJsHg94hLXkY4mEokqBzx/jQDjDsAT5S6VYDbBl1OfXWWN4jI/jVA42y4aAIMB6O7EfOMKWAtiUBeuuj6xyKFoU25AKiV+yPNxejgOCXis7eCY1n0b8RtjydTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fed63e/pneZm+CSTinaclpNmfbiAvaKrhcFQ9JYwZUg=;
 b=eqaXt4Mi/Nwjmd24UnqPskV6o2c6gWbVv86sBOqyxUZbtG944trsODcCqDtv9uX+BKSNfJB/Ye9Ibifex3Tl8exHnOb/BMVeKdjKqbDO3dTOw0ZimLAQnuSfXzSUCT6Lgvx8CJNSLKeVOumIHjs52vkflFap3R94K4Yi4khe1q2RnXjFMdBncq9tvAbt4nkwq9XF6xXzkf4RWb+T1gszMEWY2xxr7yPh5yq77a435p68hMHZ1DXgGFm/4hjS/lX1AZzNNqA+wsUJ9+uaFykFdRPF8S0tr9vhGdPUdab+uax2GfnV/dRdn69X0a6uC8Lf+nrS+sR0qWhleEI+kFjD3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 08:03:33 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 08:03:33 +0000
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
Thread-Index: AQHbhAUwblJ6/3JzXkikuf/dEO2jkbNRFADQgAAVSoCAAADUwIAABdeAgAAzsuA=
Date: Fri, 21 Feb 2025 08:03:33 +0000
Message-ID:
 <CY8PR12MB7195D93F387845E0A7314C34DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250221020555.4090014-1-roman.gushchin@linux.dev>
 <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gF3UC7PvVxeRcq@google.com>
In-Reply-To: <Z7gF3UC7PvVxeRcq@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mellanox.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CY8PR12MB8299:EE_
x-ms-office365-filtering-correlation-id: f9d996d9-e464-40c1-a507-08dd524e3cc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cd/nXOjj+dDnQt7dmGvx/1TmrAdqVMaA0wV0GWvb1Q2SL5MnLoMT9zm9LZem?=
 =?us-ascii?Q?ih7gyofmMbXs3JrHFjYs36ZlxVMAl/yLCf2J0tdU5EQmn45inK9pqbdx7Tv7?=
 =?us-ascii?Q?iaDRbADdAA2KUtf8EwMdATlEmAkSOWRGNVdb2q4wAxTeUp67I+PtIQkti6CZ?=
 =?us-ascii?Q?4bQdNxf8NxrXrWsVlKfxRk0RV4XW8tN0vkFOhEPUU6I6S3JgzVdv9k5ZCRlr?=
 =?us-ascii?Q?60fep2NawV7lkIwhtRzGIa/IElkHMW2mCqyROY/9fmiCKLtXQ7Efo1hysPCj?=
 =?us-ascii?Q?wf0fBilL0yzi7GGVNJT6m8IPYLJaCrd8qNcYaeU4B2eGAy/eym/LwrlLpow8?=
 =?us-ascii?Q?oGXYiNsIdhgKUJjmtYepJZqe6SH7Zpy+oS3ZnL4iqksZOgNUJEC03ZedXw/M?=
 =?us-ascii?Q?7NOQsUbsP+JOzKyyTCtjwTt3H82T51lZj+Mrcz3MAO0iub/OyPQD2c5Laht3?=
 =?us-ascii?Q?mijI3yP+hWkwsGN2Ir0czgU4OHbHcMCLeAeJhNkuCNQRxYlKMrUMvaLc1EHj?=
 =?us-ascii?Q?x3cvtfSjwFqXrcA/YOYT/WIHim8XfwUGbXZA1lnZKQFHnmkf75X+Kr0bi5dj?=
 =?us-ascii?Q?d9tXcF7NiNIaggbEjl3sgxoIbw0iwQWsoO0SZSov9RCrz/iVOaycf7v68SAi?=
 =?us-ascii?Q?asqrqqqO7OfcIYGRWyPnfyiRgNuXCfXtpv+oa/b1U5Cn+2Sxb6h8vubPkvNA?=
 =?us-ascii?Q?2QtSMR5xKLPeGQXBZEizrpVHTNYd4ON8ZQ/SeF4nNlGPvqMuzt1nfnT7t1r5?=
 =?us-ascii?Q?fBQvMRO2SO1nncdJRsorWZuQ9U9MIrXI2rzBHPn8uJaeXbSvpJO5W6hF+syE?=
 =?us-ascii?Q?qMUkjsXNsKaPvbFITopdZK6R9nAdmJwlbST5gGDxfSEWtj3ShYkkoznekv2V?=
 =?us-ascii?Q?Pbi85k9B3jW9ndGb5Y8Qpzce+y10yYVqDcgDcA0bcAEpMKq8uZW3daPetdsA?=
 =?us-ascii?Q?sKCWBoCuo3LCVBgOCTodyXZbtsNmm9biUh6RJa/+dY7b2AFEUgcvh/Q7mmdv?=
 =?us-ascii?Q?8CDSraD3Y+2Wqa9AzZbeD0iYhsp5glbj/bImWfme+YNSnEK0nniaL0J8NYg7?=
 =?us-ascii?Q?E0TcryQg6PGpf8fyJe4fG18sMYvMoeM06NNT7RTOTbCBphN2Y3tkr4/6CYV2?=
 =?us-ascii?Q?RThy10XrBRyOqlOXNeGkird3DE85Fi17f7oGKzhj/NlYsiIPLC8Jgshc4vOF?=
 =?us-ascii?Q?XcQu7a8nLjhZ/mJMBMR5XeVxE2tePlaShAm4ZSZn9JfTs3uN9C81lo5O5oej?=
 =?us-ascii?Q?E8Rp8Tqn2JGkmUXdCZokkV3z1HTboY374Qtn6asFztBVuOm1j9Mx8uSoXD6a?=
 =?us-ascii?Q?xI62ZR32Vdhk/otHKtDNh+iBD9kxqfh0B0ObXUQkesLvIxq9uZlScnBc6Zuh?=
 =?us-ascii?Q?XbTHKMudSChBYs5gD6u1oyNrcrU/TxRtZ3EexqZmMfX1lSRj7RYo0Kg3FKRR?=
 =?us-ascii?Q?MqvppEsvTNGEouoPuP05dJUcoMlBqvPi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8KHLZNxxhp67x9nQXNvBioicXlZwOfd34SQ36TR6r+/yKIYNJyPOCEJg1Aln?=
 =?us-ascii?Q?3YvdrmtqfZvcN3r04cP15zxESEPvZngw45H6Or3y5QJAEjyIcKc3209SVoq0?=
 =?us-ascii?Q?u+Mu0K07rySpQiLiYSQdQaEQoCbsm17LYZRz5hK+11mSIQxRLdUCL7byte0M?=
 =?us-ascii?Q?F5QiY2aBfDwIQ4GJqLz1L/t6gjY+bZ4kqIXqs/Q9fIB9duwGKvWxobNBOXyY?=
 =?us-ascii?Q?Ty7m+W96TsoYmuFi7mYy3sqJ/yVI7KVbdZDtg15oM4juMHRObxWGKNqMtXD6?=
 =?us-ascii?Q?DJe5SWnP3X9pE2q4CDIsTzIqvzW5FshOUTfxm/h8o02cE/2JpArLHEyt2UmV?=
 =?us-ascii?Q?gG6hsrXeIZJEaxfWeyp5Qy/nkW0S/u26SfgaKLFU6y1xDQUadCoHib0i/FcO?=
 =?us-ascii?Q?vOUOgohS6ysizKpcuPalR5eP/tA3vvHlH+Quvvfmzlkc4kbwMMigDnuNOc9Z?=
 =?us-ascii?Q?Y+tI3ZYOydF6cXdDiXZzbX3lp+YDFgrDhnwOropekkjJiUbqoJ5sm5dfSvM7?=
 =?us-ascii?Q?vU5ZVuK98lS22YR/wP6ge5bjEWQ81FNBWBZ8FycBYYnE/FYM7cC8mU4WNiPB?=
 =?us-ascii?Q?HwSrXNiMNqPr1CKxKPHcaZvlRfDrIX6i7IP1IQXcVFTbO/i/NS/xmcpstE/5?=
 =?us-ascii?Q?P7rje+xmyQG7BvP9A2ejhJ6KeG2B8/DAQArYLcTowHbQysZjalB9/fAvThim?=
 =?us-ascii?Q?jDo/y98yXIQ5yFyQWiipLjmBSzt9mCGDZAg7+CO1f+3pyckg4whk6V8yPmEI?=
 =?us-ascii?Q?xZEq4Z/Dl0bawOYQ0XOC9txwk7GhTyTp+twiHZ+cuKjbKqRHYXgQ0YftvGUa?=
 =?us-ascii?Q?veUm6tpqCZlj1x5roNWgmzGTjqOMxTN01mGtA5HAR3c4jdEm6XmiHs2D/iiJ?=
 =?us-ascii?Q?OOAxSOKt32lMfDDW0faVU8yY+MpaNXPxprUO67Fg5Ng5WbAvRmMcTE8+uOil?=
 =?us-ascii?Q?LIQ2LBfgWP0nKT+NpXYyWOY0SOpX2dfuHyFqQ4lZ8cC9a26U13otkPvZT9gb?=
 =?us-ascii?Q?gu0KC3DAqYNvMrNuj2t7qsOedeDYHYBPZuJ1kbCI/kgqwXYvsSbagSQap0Sm?=
 =?us-ascii?Q?P+LuYpvltBdc+HPiH5oz+X7ypEqDroywTdRLMaeAOcC/JcSeYEtrcyCKHQhY?=
 =?us-ascii?Q?hMeTmCt9lqWqR6RPoAKIwbZ9v5Id3Z0D7PEr6WlpWECpjqbcbAvvclyYLNFA?=
 =?us-ascii?Q?GVz1UDly1AyekRBcSh4uFGYHzk8VT/2R6L9N1ZD9Ft7i4+85PCiuUK8Y7hY6?=
 =?us-ascii?Q?w7OIHCbDQeyxwAbG8W5rjrIpXVH5lq2GZOX1HM7hv+F0qI1kVYTjvMvqlFlH?=
 =?us-ascii?Q?9cNp4Pv3LvlJljFfy225vhgfnrU/u7btqp83qd0Gan1VzQ/ec8fHEIucALZ0?=
 =?us-ascii?Q?dpPkP3ihfaHlktN/x8Kw4i2CIoM/6F7nPWSd/f2oCKdgO1bvfBmu0P/c6M0Y?=
 =?us-ascii?Q?9dcHs7DA3oX32xwMhtI9JRc+F6GPIY95eq/2lNCm2csVYpsIHpGNeoeEyvCH?=
 =?us-ascii?Q?H1Qwzo5bsf2P4pHaHsvnr5g114g8a4yuyGs3mJu3n9p80ytcP5cGTPe9lc+z?=
 =?us-ascii?Q?27nKZRd/80g34gkYxsk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d996d9-e464-40c1-a507-08dd524e3cc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:03:33.6473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5HMJa2Cy0ZRfH5XK8jhFooxfQ108KzeuFOihK6QM8fpsC1d1VtrVbVPnfL/Wnsdh1hmeg8mNDwKdNkQvhWK6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299

> From: Roman Gushchin <roman.gushchin@linux.dev>
> Sent: Friday, February 21, 2025 10:20 AM
>=20
> On Fri, Feb 21, 2025 at 04:34:25AM +0000, Parav Pandit wrote:
> >
> > > From: Roman Gushchin <roman.gushchin@linux.dev>
> > > Sent: Friday, February 21, 2025 9:56 AM
> > >
> > > On Fri, Feb 21, 2025 at 03:14:16AM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Roman Gushchin <roman.gushchin@linux.dev>
> > > > > Sent: Friday, February 21, 2025 7:36 AM
> > > > >
> > > > > Commit 54747231150f ("RDMA: Introduce and use
> > > > > rdma_device_to_ibdev()") introduced rdma_device_to_ibdev()
> > > > > helper which has to be used to obtain an ib_device pointer from a
> device pointer.
> > > > >
> > > >
> > > > > hw_stat_device_show() and hw_stat_device_store() were missed.
> > > > >
> > > > > It causes a NULL pointer dereference panic on an attempt to read
> > > > > hw counters from a namespace, when the device structure is not
> > > > > embedded into the ib_device structure.
> > > > Do you mean net namespace other than default init_net?
> > > > Assuming the answer is yes, some question below.
> > > >
> > > > > In this case casting the device pointer into the ib_device
> > > > > pointer using container_of() is wrong.
> > > > > Instead, rdma_device_to_ibdev() should be used, which uses the
> > > > > back- reference (container_of(device, struct ib_core_device, dev)=
)-
> >owner.
> > > > >
> > > > > [42021.807566] BUG: kernel NULL pointer dereference, address:
> > > > > 0000000000000028 [42021.814463] #PF: supervisor read access in
> > > > > kernel mode [42021.819549] #PF: error_code(0x0000) - not-present
> > > > > page [42021.824636] PGD 0 P4D 0 [42021.827145] Oops: 0000 [#1]
> > > > > SMP PTI [42021.830598] CPU: 82 PID: 2843922 Comm: switchto-
> defaul Kdump:
> > > loaded
> > > > > Tainted: G S      W I        XXX
> > > > > [42021.841697] Hardware name: XXX [42021.849619] RIP:
> > > > > 0010:hw_stat_device_show+0x1e/0x40 [ib_core] [42021.855362]
> > > > > Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f
> > > > > 44 00 00 49 89 d0 4c 8b 5e 20 48 8b 8f b8 04 00 00 48 81 c7 f0
> > > > > fa ff ff <48> 8b
> > > > > 41 28 48 29 ce 48 83 c6 d0 48 c1 ee 04 69 d6 ab aa aa aa 48
> > > > > [42021.873931]
> > > > > RSP: 0018:ffff97fe90f03da0 EFLAGS: 00010287 [42021.879108] RAX:
> > > > > ffff9406988a8c60 RBX: ffff940e1072d438 RCX: 0000000000000000
> > > > > [42021.886169] RDX: ffff94085f1aa000 RSI: ffff93c6cbbdbcb0 RDI:
> > > > > ffff940c7517aef0 [42021.893230] RBP: ffff97fe90f03e70 R08:
> > > > > ffff94085f1aa000 R09: 0000000000000000 [42021.900294] R10:
> > > > > ffff94085f1aa000 R11: ffffffffc0775680 R12: ffffffff87ca2530
> > > > > [42021.907355]
> > > > > R13: ffff940651602840 R14: ffff93c6cbbdbcb0 R15:
> > > > > ffff94085f1aa000 [42021.914418] FS:  00007fda1a3b9700(0000)
> > > GS:ffff94453fb80000(0000)
> > > > > knlGS:0000000000000000 [42021.922423] CS:  0010 DS: 0000 ES:
> > > > > 0000
> > > CR0:
> > > > > 0000000080050033 [42021.928130] CR2: 0000000000000028 CR3:
> > > > > 00000042dcfb8003 CR4: 00000000003726f0 [42021.935194] DR0:
> > > > > 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> > > > > [42021.942257] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > > > > 0000000000000400 [42021.949324] Call Trace:
> > > > > [42021.951756]  <TASK>
> > > > > [42021.953842]  [<ffffffff86c58674>] ? show_regs+0x64/0x70
> > > > > [42021.959030] [<ffffffff86c58468>] ? __die+0x78/0xc0
> > > > > [42021.963874]
> > > [<ffffffff86c9ef75>] ?
> > > > > page_fault_oops+0x2b5/0x3b0 [42021.969749]  [<ffffffff87674b92>] =
?
> > > > > exc_page_fault+0x1a2/0x3c0 [42021.975549]  [<ffffffff87801326>] ?
> > > > > asm_exc_page_fault+0x26/0x30 [42021.981517]  [<ffffffffc0775680>]
> ?
> > > > > __pfx_show_hw_stats+0x10/0x10 [ib_core] [42021.988482]
> > > > > [<ffffffffc077564e>] ? hw_stat_device_show+0x1e/0x40 [ib_core]
> > > > > [42021.995438]  [<ffffffff86ac7f8e>] dev_attr_show+0x1e/0x50
> > > > > [42022.000803]  [<ffffffff86a3eeb1>] sysfs_kf_seq_show+0x81/0xe0
> > > > > [42022.006508]  [<ffffffff86a11134>] seq_read_iter+0xf4/0x410
> > > > > [42022.011954]  [<ffffffff869f4b2e>] vfs_read+0x16e/0x2f0
> > > > > [42022.017058] [<ffffffff869f50ee>] ksys_read+0x6e/0xe0
> > > > > [42022.022073]  [<ffffffff8766f1ca>]
> > > > > do_syscall_64+0x6a/0xa0 [42022.027441]  [<ffffffff8780013b>]
> > > > > entry_SYSCALL_64_after_hwframe+0x78/0xe2
> > > > >
> > > > > Fixes: 54747231150f ("RDMA: Introduce and use
> > > > > rdma_device_to_ibdev()")
> > > > Commit eb15c78b05bd9 eliminated hw_counters sysfs directory into
> > > > the
> > > net namespace.
> > > > I don't see it created in any other net ns other than init_net
> > > > with kernel
> > > 6.12+.
> > > >
> > > > I am puzzled. Can you please explain/share the reproduction steps
> > > > for
> > > generating above call trace?
> > >
> > > Hi Parav!
> > >
> > > This bug was spotted in the production on a small number of
> > > machines. They were running a 6.6-based kernel (with no changes
> > > around this code). I don't have a reproducer (and there is no simple
> > > way for me to reproduce the problem), but I've several core dumps
> > > and from inspecting them it was clear that a ib_device pointer
> > > obtained in hw_stat_device_show() was wrong. At the same time the
> > > ib_pointer obtained in the way rdma_device_to_ibdev() works was
> correct.
> > >
> > I just tried reproducing now on 6.12+ kernel manually.
>=20
> Can you, please, share your steps? Or try the 6.6 kernel?
>
$ rdma system show to display 'netns shared'.
$ ip netns add foo
$ ip netns exec foo bash
$ attempt to access the hw counters from the foo net namespace.

For the rdma devices following directory must not have "hw_counters" direct=
ory.

$ ls -l /sys/class/infiniband/<dev_name>/ports/1/

> > It appears impossible to reach flow to me as intended in the commit I l=
isted.
> > And the call trace shows opposite.
> > So please gather the information from the production system on
> reproducing it or configuration wise.
> > We still need to block the hw counters from net ns and will have to gen=
erate
> different fix if it was reached somehow.
>=20
> I'll try, but it'll take a lot of time - I'm very limited in terms of wha=
t I can do
> because it's a production workload.
>=20
The reproduction should be straightforward if its basic issue.

> So if you have any suggestions on where to look at or what to try, I'll
> appreciate it.
The output of below commands will provide some hint.
$ rdma system show
$ rdma dev show
$ ip netns show
$ mount | grep net
ls -l /run/netns or whichever directory where netns mounted from the output=
 of above command.

