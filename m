Return-Path: <linux-rdma+bounces-7931-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474ACA3EB23
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 04:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81A13BF056
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 03:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C9C1DACB1;
	Fri, 21 Feb 2025 03:14:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC281C174A;
	Fri, 21 Feb 2025 03:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740107662; cv=fail; b=FZL900EKirA8T9kVUU3bqm4O+dkN+OynVt6nvwUO4T+h4JE1uS4ciEIqCA4VLpfru5NdV7n1iaDO5+qXZj+u/mN1rlrA6FVBUUrIaT0AQ/ALEyCcZ+97Cn9EgTFoDzx5dJWCJs8UVamxexDtns434wVk5TX+9H9x+7K2fMKZv3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740107662; c=relaxed/simple;
	bh=PmS1k6ZxD5eS2lPQN7gL/A9RIcGot1NQ4PSSQ/DXTl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Up8jwDSZ5mVbAhqMjAEkGWvG7b2YuhdhSyGiLx+XvzKx+cg3QjznnNGi01FWhCqPuR8wdeHHI7DQLfBUxufoQzMF4XsGCXZwNEhLVlE+jSxckzEBDZpOcx+/DGvvMSewSbuHeFfRnsrsdE97PBj2PSLbaNYzuBW6pkQOe5ddpOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com; spf=pass smtp.mailfrom=mellanox.com; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mellanox.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k93FumZEJtegNfcvM/uNXj1DyKxJd0PnCgiSM9rHcVNLDJEX2FnTnY76PmcvYUyIH+le/Mx4giaWBte5nQCiFv9K7IftXf9GMKLrbi2Ed+ydJUaoGmtbY7aOkgiQkYQJrPIfoXLZsK0k0Z8H1dL3cDq1gtWM7aJ4nRSCVbFwRLOzCJCvb8sR+W12SF80hxuIyAUUgdw6dV81rpbWLVXKKoWl/hatc3Np0Iuei16QsM5Z50EpDNJEEQbyfgWI3Ks7iyxXvEqzn8bbTSzEQO6fMp9vJvIDpTPDDOs4Ap1yIioA9NJAEk5GWxNgaKrTBFzMcXN7ghl8ztvoWt76swIDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvdutA7c/zKkp+duy3vDeuNdWeFOwbJfQGIrRpRfUnI=;
 b=MK9eD9O1qo08G4Htg5UtKAzIpCs59sKlpyFk/5NW/ucZYLDwMtB1ILJ5R5FiVafxpjUrmxCBpjz9Kvzvi2s9mihZMooItvFDcfa34kKjF87VQEzVI9uzwXW6MtQxrYEk4e+ImFPU2DSL3Sm5JHQbOf6l34KrreuwmRZpc+bOCbK9ox64pnyBJiQc2Hu6QkZfUAAOJ+blMYDPr6giD5Gf2HgMyPUHEkthqiZ/1coxmhcthkRrGKYJfQif0hbFkKh76zxgk0H3/qcFwWFTJGwsrdxyBxc70ljILx17QkzlBg+rCxc+LJjxhUxy0aGpITfXSQoLXSjyChD5eDWvTB/C5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 03:14:17 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 03:14:16 +0000
From: Parav Pandit <parav@mellanox.com>
To: Roman Gushchin <roman.gushchin@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Thread-Topic: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Thread-Index: AQHbhAUwblJ6/3JzXkikuf/dEO2jkbNRFADQ
Date: Fri, 21 Feb 2025 03:14:16 +0000
Message-ID:
 <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250221020555.4090014-1-roman.gushchin@linux.dev>
In-Reply-To: <20250221020555.4090014-1-roman.gushchin@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mellanox.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS0PR12MB7771:EE_
x-ms-office365-filtering-correlation-id: bc2b693e-0a8b-4712-eeda-08dd5225d348
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?r0x1LGcUS5hOlcSkFK8WURzm9Iw1Uc0H/+UdEU+RZmAZ3w0CMeqoNhV+mnOB?=
 =?us-ascii?Q?DxSm4cRXclHmfPmA33C9+R9R1ChmkYBTOSSxFvZ34J13ogs9fLCHY8Af1Ah9?=
 =?us-ascii?Q?unOpogAb5IBrurP1BNxYHv6qnbHgO1oga7tZsZlD1nRSskbXgVXcqN8ChfYk?=
 =?us-ascii?Q?SKNHk9kux8LxgMRE56OthgSr+xxEHHuoSnii7azkrUZ4v0f8o8jc8JtMg4X2?=
 =?us-ascii?Q?fZzAxP8o/u7GWXSz2ZEd6xMawranzR1O6uNoBSO6SPG+qyiAohNzMP/P7/mK?=
 =?us-ascii?Q?Oqhvz7/fjzqJi4XDKuzN6GadqbgWmq30NA9jbqC6ct/gN/HDGdQkkkogSTRu?=
 =?us-ascii?Q?8RMu/qNtqH3W3mLP24alQwNQR/Ds2bm5TFCOCrXa2gsiXpDzBLms/kTMVhfJ?=
 =?us-ascii?Q?bxrk7k1RBagm34vkPIp+QNSNbdb9K7vl6HTSD4CAc/RsGDiNte0U0oGjfMfp?=
 =?us-ascii?Q?YUHuuqfmzfaXN0ZI8n5IhBFnDlJQBX+5gsIJ2DFMkOWaBQG7vnkAXT6pJm3p?=
 =?us-ascii?Q?T0MB5Dm3+HVCUDoyAIc4yT/sGPeO68lMxH+PzDeo5bDdlVjaTuhms4p90PQo?=
 =?us-ascii?Q?qLHVObhUSBOOLufYmZslYYWf+hKjgP+aHFnWzr9KBPGxijb096llHOyhCEzO?=
 =?us-ascii?Q?wfGgvPtMcS+ICqwer1z57s729ZxTyZPRBY7c62jHYUMwEhSAqEuMNKjNZK1M?=
 =?us-ascii?Q?Ljam4WUhfQZGVMCq2NvHtocpZKLDdFV3WMnDPcJqCs4lvRYJk0Hbd3cCRP4n?=
 =?us-ascii?Q?d3jRyeBMTFQlyE4pOdHliRxziW4xK5VXef9CCv5BEkyohFBDxJHTipxs9lwM?=
 =?us-ascii?Q?m0cV1UNDMp5SL1rHEQbOlvsScE88Zpfrg4bHrF1jQRR1dqDNTZCPXmJ4DYDd?=
 =?us-ascii?Q?aXnb49wzbLKtVG6+1V6HKyCbZkmEQmH6Lgmz+OxFzKnm7NvTTE4n6RpbAqUL?=
 =?us-ascii?Q?+RJlcKHGLUCFYTnqLajSeFiRX7OFzyfVXwlK00we2c54+HRad/K8Irqp7lPO?=
 =?us-ascii?Q?IJjyMxXA5W6e5dMlyrqmQQVlBZ/raG7aA1tmu7qAEp5/GN3wUFgXHiSEhv9s?=
 =?us-ascii?Q?kCGkNt+9O81gRNWPiheTX0Bgk7wfHnvxGtysUW5xs5SmpyA1QfHWNpXC6XgC?=
 =?us-ascii?Q?jmUkDkktXdIz8xwj4UbxOn5ORuImTgQaLHaBKTrYM2CJvOZDAv3HwdCX56uY?=
 =?us-ascii?Q?a54zXDIb5xi0/SR1kiIxhBymPyYt2h6wdNA05gPfIarUcVZC/dOKGTOsXp8/?=
 =?us-ascii?Q?ORRgvspHXd4uS97xUf5sPQ5VT+E3PVOVy9iRbYsa/it4k/W4mB1p2cwRBJt4?=
 =?us-ascii?Q?rDDtulN6zEb68o5PlQEmdlhGH4nXls4bz6SskQebISuewaMczfxikTm8ua0N?=
 =?us-ascii?Q?okxgFy3erm+DzAaViURNagaNgr4KVVveqd10KNuk0Ahy8+Wib8oRfk+CiaM2?=
 =?us-ascii?Q?5ksYTx+R1IKsq6EZos0/F9rpk8d6ULyE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zWVfLfyof2zwQR0/UtSPUXtcOVzb8ILspYs+aBZ65Nz37X6ANaoiD5ncsxc4?=
 =?us-ascii?Q?l99PqQ2bxO/ed+ERBg7g/7O22zJG/GQL63sm7ANpRTiTTbtkViY7EZqSgHa3?=
 =?us-ascii?Q?IO5Y2i80ldZZJm7zMzQjiC0Rya+P/0xfMTz9iBNlIA+XJ0+GOg/Y+NmFBaG6?=
 =?us-ascii?Q?ecNWD0ztlReBlcrr5/PxAfkcvnm4r5R/LRwMlr8yyq7IgKIAtR3p40oQGdAK?=
 =?us-ascii?Q?cqiy9OP28odu9b5wbsU0BC4/RkMIu02tyco8AaQA95um99rGwArD+q5aXvkF?=
 =?us-ascii?Q?oSk+ipiFDRT7zisQ2FPm4crdTEYcL9rpxW3EYAgczcrmd0EGvs+34zWxLBWn?=
 =?us-ascii?Q?rmk5dsIC/2iNTL+wwSk2Fba+41a7xvb/fC9d2DjHYz2oj0sIozKVbeOECuU8?=
 =?us-ascii?Q?kT3kaYmnu8APLav1OYtmdBHf906uQ4dB4D+rQry3+kDV3ru0nMjYBZ8qEYSt?=
 =?us-ascii?Q?049i94cMKYonrHWnYd3sTA9cE6ma0FI2x1BfDhJEYzl8hMpKGzPvICfkckdr?=
 =?us-ascii?Q?o6hJzQuXJZufRQ2681jAV+OgqvmNrcYLl1ysAWlcB/NwvstyCBHulU7a5FUN?=
 =?us-ascii?Q?yp0HOUoOD5OTJ0peQVeqr/wVTxR2tl9w/5lsD20MQlwVW4U6AvKLV3r6pfdp?=
 =?us-ascii?Q?kC7dDaqoqNneAPwr/MP+k5RW8QLO5hX0SlVxaRm1br/bypqsrlU9ifBv9UsU?=
 =?us-ascii?Q?Xjp2LUU8qh4qZAvewaiKM2o+iE8FbwVjoiVvNdL5gMNSxOP/t9NIqyimtAeu?=
 =?us-ascii?Q?Pv76TYnrfbpKMpHOjayX/zRd3q/eboCUNPWYzqMxfpJWfPz7FEOvj9wJpPtC?=
 =?us-ascii?Q?m58GtVyQ3k/achb4jJqNiApI6Rkv7Vou9EeUWZwQe8DoH0R1gS9JvQkZDy6k?=
 =?us-ascii?Q?oHz5DmpX9tZ7IN1B5X1koa5tJXfY5Z+4hhgNOQFnsHanqXhY1/SDU7JupqOk?=
 =?us-ascii?Q?qm3Lb6fT7ZlF7jc2rBMdiDfuNdW3+atfr4GoebhPCNZwIp4i33+HvMBLtbx3?=
 =?us-ascii?Q?uMQcAE2719iz3OFV1mldb71sjLJDtyRoR0HIoINttds7evieBV4wB6/A4SdS?=
 =?us-ascii?Q?FTZqc1BmpHLQBVUkZkN3keMl2bjF6kRPoojHJ4Id4vWqWzL+KOvjsYNwU9le?=
 =?us-ascii?Q?wqKYvXFxjUSB3Vd/2gikkzNlv9Mp1UzWIDTxTLKpROabg9mYHHjSJ9N7sNH3?=
 =?us-ascii?Q?RYWpB16bnG42AqrFRkq6pE2XqXirNC1W8jL3qle1H/f5T3fXWxYcTLvzufFH?=
 =?us-ascii?Q?oT7KYs5oVYYEx1GVjabWYNfumcyJV/69Dfh5ORhEa7fogfuvHwuq2J2VH1Kp?=
 =?us-ascii?Q?SkF5wt8X0BdfHiRW6Cvc4wBU/yvkWNdoW2Xi4A8Tm8C/q7zAE5CXgHMZ7Weh?=
 =?us-ascii?Q?s4rARXoSArHIxLnzMVsvvT4JwPKnrim1Eir+cCNq0jVMOiAig/Yw/GdPHyYo?=
 =?us-ascii?Q?buEzPCcILzjjPRoU1Qzx03Uc6HPK0EuX9oFXt1KEQ03ynOFu/TXeIryoQ8EB?=
 =?us-ascii?Q?xyexvK5HkwOi9yPE8kSG0IkOP9kmE8pAuTCjKtpabvwbhjvnhV1s92IjfM+S?=
 =?us-ascii?Q?AnQANU6atbwdR5X1Zok=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2b693e-0a8b-4712-eeda-08dd5225d348
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 03:14:16.8500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odQxMR1H0rtKoGLNvxTMGbOht6Y3A+/NXVLavl+v1mtOa1W+DOPqXOLlnI7RmS12U0eD1AhFQadbKlmlhkmZ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771


> From: Roman Gushchin <roman.gushchin@linux.dev>
> Sent: Friday, February 21, 2025 7:36 AM
>=20
> Commit 54747231150f ("RDMA: Introduce and use rdma_device_to_ibdev()")
> introduced rdma_device_to_ibdev() helper which has to be used to obtain a=
n
> ib_device pointer from a device pointer.
>
=20
> hw_stat_device_show() and hw_stat_device_store() were missed.
>=20
> It causes a NULL pointer dereference panic on an attempt to read hw count=
ers
> from a namespace, when the device structure is not embedded into the
> ib_device structure.=20
Do you mean net namespace other than default init_net?
Assuming the answer is yes, some question below.

> In this case casting the device pointer into the ib_device
> pointer using container_of() is wrong.
> Instead, rdma_device_to_ibdev() should be used, which uses the back-
> reference (container_of(device, struct ib_core_device, dev))->owner.
>=20
> [42021.807566] BUG: kernel NULL pointer dereference, address:
> 0000000000000028 [42021.814463] #PF: supervisor read access in kernel
> mode [42021.819549] #PF: error_code(0x0000) - not-present page
> [42021.824636] PGD 0 P4D 0 [42021.827145] Oops: 0000 [#1] SMP PTI
> [42021.830598] CPU: 82 PID: 2843922 Comm: switchto-defaul Kdump: loaded
> Tainted: G S      W I        XXX
> [42021.841697] Hardware name: XXX
> [42021.849619] RIP: 0010:hw_stat_device_show+0x1e/0x40 [ib_core]
> [42021.855362] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1=
f
> 44 00 00 49 89 d0 4c 8b 5e 20 48 8b 8f b8 04 00 00 48 81 c7 f0 fa ff ff <=
48> 8b
> 41 28 48 29 ce 48 83 c6 d0 48 c1 ee 04 69 d6 ab aa aa aa 48 [42021.873931=
]
> RSP: 0018:ffff97fe90f03da0 EFLAGS: 00010287 [42021.879108] RAX:
> ffff9406988a8c60 RBX: ffff940e1072d438 RCX: 0000000000000000
> [42021.886169] RDX: ffff94085f1aa000 RSI: ffff93c6cbbdbcb0 RDI:
> ffff940c7517aef0 [42021.893230] RBP: ffff97fe90f03e70 R08:
> ffff94085f1aa000 R09: 0000000000000000 [42021.900294] R10:
> ffff94085f1aa000 R11: ffffffffc0775680 R12: ffffffff87ca2530 [42021.90735=
5]
> R13: ffff940651602840 R14: ffff93c6cbbdbcb0 R15: ffff94085f1aa000
> [42021.914418] FS:  00007fda1a3b9700(0000) GS:ffff94453fb80000(0000)
> knlGS:0000000000000000 [42021.922423] CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033 [42021.928130] CR2: 0000000000000028 CR3:
> 00000042dcfb8003 CR4: 00000000003726f0 [42021.935194] DR0:
> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [42021.942257] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400 [42021.949324] Call Trace:
> [42021.951756]  <TASK>
> [42021.953842]  [<ffffffff86c58674>] ? show_regs+0x64/0x70 [42021.959030]
> [<ffffffff86c58468>] ? __die+0x78/0xc0 [42021.963874]  [<ffffffff86c9ef75=
>] ?
> page_fault_oops+0x2b5/0x3b0 [42021.969749]  [<ffffffff87674b92>] ?
> exc_page_fault+0x1a2/0x3c0 [42021.975549]  [<ffffffff87801326>] ?
> asm_exc_page_fault+0x26/0x30 [42021.981517]  [<ffffffffc0775680>] ?
> __pfx_show_hw_stats+0x10/0x10 [ib_core] [42021.988482]
> [<ffffffffc077564e>] ? hw_stat_device_show+0x1e/0x40 [ib_core]
> [42021.995438]  [<ffffffff86ac7f8e>] dev_attr_show+0x1e/0x50
> [42022.000803]  [<ffffffff86a3eeb1>] sysfs_kf_seq_show+0x81/0xe0
> [42022.006508]  [<ffffffff86a11134>] seq_read_iter+0xf4/0x410
> [42022.011954]  [<ffffffff869f4b2e>] vfs_read+0x16e/0x2f0 [42022.017058]
> [<ffffffff869f50ee>] ksys_read+0x6e/0xe0 [42022.022073]  [<ffffffff8766f1=
ca>]
> do_syscall_64+0x6a/0xa0 [42022.027441]  [<ffffffff8780013b>]
> entry_SYSCALL_64_after_hwframe+0x78/0xe2
>=20
> Fixes: 54747231150f ("RDMA: Introduce and use rdma_device_to_ibdev()")
Commit eb15c78b05bd9 eliminated hw_counters sysfs directory into the net na=
mespace.
I don't see it created in any other net ns other than init_net with kernel =
6.12+.

I am puzzled. Can you please explain/share the reproduction steps for gener=
ating above call trace?
=20
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Maher Sanalla <msanalla@nvidia.com>
> Cc: Parav Pandit <parav@mellanox.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/infiniband/core/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sy=
sfs.c
> index 7491328ca5e6..0be77b8abeae 100644
> --- a/drivers/infiniband/core/sysfs.c
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -148,7 +148,7 @@ static ssize_t hw_stat_device_show(struct device
> *dev,  {
>  	struct hw_stats_device_attribute *stat_attr =3D
>  		container_of(attr, struct hw_stats_device_attribute, attr);
> -	struct ib_device *ibdev =3D container_of(dev, struct ib_device, dev);
> +	struct ib_device *ibdev =3D rdma_device_to_ibdev(dev);
>=20
>  	return stat_attr->show(ibdev, ibdev->hw_stats_data->stats,
>  			       stat_attr - ibdev->hw_stats_data->attrs, 0, buf);
> @@ -160,7 +160,7 @@ static ssize_t hw_stat_device_store(struct device
> *dev,  {
>  	struct hw_stats_device_attribute *stat_attr =3D
>  		container_of(attr, struct hw_stats_device_attribute, attr);
> -	struct ib_device *ibdev =3D container_of(dev, struct ib_device, dev);
> +	struct ib_device *ibdev =3D rdma_device_to_ibdev(dev);
>=20
>  	return stat_attr->store(ibdev, ibdev->hw_stats_data->stats,
>  				stat_attr - ibdev->hw_stats_data->attrs, 0,
> buf,
> --
> 2.48.1.601.g30ceb7b040-goog


