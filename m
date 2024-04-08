Return-Path: <linux-rdma+bounces-1851-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218C889C95D
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 18:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885C61F246A8
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 16:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC981422B9;
	Mon,  8 Apr 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WUEl22hE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB81422AF
	for <linux-rdma@vger.kernel.org>; Mon,  8 Apr 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592631; cv=fail; b=j7sF3ZTc777tkZ5zc9gNFUNmImz7C36L2oglx9Dq1FLDDMBjqHxfGKHaFKhC4AqqOyI87mddG+CJ+oR4e99WY10abJBdvFSe8hfPPtpMZDEVZAJ/XCGG+cOTTa3GrlOmRAWuUPz9RWgNgapOrc7cehUvLXuFGG41LjdM6HxC1mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592631; c=relaxed/simple;
	bh=fhamuwJ4Fj5i8Q8EAkDrLnZ5FJX8avFL0kYxNzVIV3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ob7vBIIBYLlulor6J/Y0JFlt3ZQPqWKJCh7x4qVrvmYBKGVxE4BitX4FXA2IvJkJL1OZnuEKqtdHNvwCB9NvactflocX15LIEwr649tnVdUtt6eDP0G2ZXQ/Xqh2ZqrEhkv8u1IuuXOA/4+ZWZ9y9yONd/nO8Xf2oViLy3z60Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WUEl22hE; arc=fail smtp.client-ip=40.107.220.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ck8vTMKqljkgSG1TBbJe5Kd168cwPEWBHlGVWj3hyX0W0k8+MMaeD7bhAGddWaWjSDJAUCpCyDygKn1Y1RNFCqLDc95QZSWImIB6i3OZIW/04jHgGm8tv2JFPD6HLE9U4Svind9RgTHA/8oa+xbu68ZO7pbn6VNIdOBOjkxBMeUqwa4zqVEfyig5w9UwLvtVfxSWX/Tiuo+QMjtRqq8hDJbUJnv2REKKLRKohFq8abrLJuq2Oukcy/uNVyIufZjxXHlK0YbFkYQawxmIlI5VHCMCFPRMpJPEBJsWht5Dx3JqlmC+ComJ1picDxu7ybMAFFQIQGCj6lRtySoQJXlUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFNhfqTuu0Z/ewcI0NtzdZqJjXYWl1XYNN2pN27ZWKs=;
 b=b/B0fATbiEuliWiJhsiI8dFec6YMtOv/IcTOFnjfgCjLD639wPZvcmJ9oVdWIoQ6HbKU9csJt3kZ3D84B2ANFQFZf0Q8NJdti54KupqxU0MoT5X2VHBvj9ZFZgXlUGAWUXc9CxUEOs49V8QfidVjSa0PWwrHpDtw5rWHhUzSR+jP3Z1weD4O43kRLIWskODA8nHV8RczaQH1iK+M51oy3nM7bEw/DrLr+GYpfe+LwUYwhNxohO1fnF9BX+EnBH+x1/Tqdm5KvqV6PUAAy5NsXzN0l9cl/syyXyJhOyzl/gj3i8sFFAETZOYw0SWphAGv+UhwbmvV9fI3c/tKL1Pe7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFNhfqTuu0Z/ewcI0NtzdZqJjXYWl1XYNN2pN27ZWKs=;
 b=WUEl22hEEZw5Ok/8dNXzMa4H4INNzHkgngV6cq5OHLng+KnOz0t5tLeVCLXZN5zu0Mbi11/b54mpOzN1sxbB3EqIwc0R5zQ63kIilOkAUzgFKAqWZRvrhuF+7361zzUyyjZHqJS2/WdIfwpg4kh1XwRzMY7gIEsrtpg2q5WdM9H7t6WY4LnUvP+c5o7V6J/HBs+9LTUrbNiBhBisMyHC03pKFO/bGA7hHZN1tsGmCI+dVk8C2vCQIdy/vnBS23pbQ6mnP45v2/Fz9pscliVn690cgvL+pod5IGK7fusW0QrttrqzaIXIvnVvUYSM7wT+DOC7i+thUtuTCKTjihz/kw==
Received: from SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 16:10:25 +0000
Received: from SN7PR12MB6840.namprd12.prod.outlook.com
 ([fe80::774:249f:3cef:6b5]) by SN7PR12MB6840.namprd12.prod.outlook.com
 ([fe80::774:249f:3cef:6b5%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 16:10:24 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Etienne AUJAMES <eaujames@ddn.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"leon@kernel.org" <leon@kernel.org>, Mark Zhang <markzhang@nvidia.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"Gael.DELBARY@cea.fr" <Gael.DELBARY@cea.fr>, "guillaume.courrier@cea.fr"
	<guillaume.courrier@cea.fr>
Subject: RE: [PATCH rdma-next] IB/cma: Define options to set CM timeouts and
 retries
Thread-Topic: [PATCH rdma-next] IB/cma: Define options to set CM timeouts and
 retries
Thread-Index: AQHahTm9kjRVWgKBFkKozoFiBcTBOLFehRsg
Date: Mon, 8 Apr 2024 16:10:24 +0000
Message-ID:
 <SN7PR12MB68403240EAB2777CB5D8AB5FBD002@SN7PR12MB6840.namprd12.prod.outlook.com>
References: <ZgxeQbxfKXHkUlQG@eaujamesDDN>
In-Reply-To: <ZgxeQbxfKXHkUlQG@eaujamesDDN>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6840:EE_|IA1PR12MB8309:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 is5aVpgYAG0d6MJgKdLjY+7zVk4+2P/5GfsvHX/1DF+HNFufKUHZcIPUSu1Hm11L+Rgp4blrHuwXJ3gbKYMpelm3l9sUkeugHXsk4NwHxtj9Psw1XJgrBjZe9TU+BmFTSN6WKJAMdoAoHE1GoG+NSnRPnniPr75Oi5NEHQPU1PRbX6TdmaHvYFubt0+dwShTvVfEsEQRSK/tlaUDVnk+CLoQM4g5XrmElOOYUIVd7Uj77do3BR8M072eua/wUkPt+tSDFJDNcObc1wY2OmuzVSqsIaEEXTU9dpVib5MzfNX33k2l0TnDU44qlOHgM6FTCHUQveC+lW62HHga4WVQ9O4VZKe8JdT5iEybqWWFIknSqeK/PYTyUuFMlnF7U9Pbjoy2X8nMPN3brFKZZteMqha93YWOLqzP9ZxFftrA11tIkhYYfn16dGoe2spnGxm/VkCiY6VT7T1+PWrDfd8chHswtVv+71RpvefufsfwkjgMZ0FUcNBYmTE5Mu9/kmxlsMMTxaqymVcKYtpbbdiCSYeqYbYmhegnw7RDL2dLq4uFyKToI3+/3AsXUbFSri6mI+HPoDDQXWo0ahZuRx1YMGgtV1NB/1eqKeQj3mCEW8ZQ9eO1M3+grEA0B+uUzzfWdZ4D56floyvpT+W61bQxtA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6840.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vLoM2MYjuOaXGhGJq4bSB9nR1jy7IgNFnUCFFpXk7pcAEVkx1vraTMNuyYUd?=
 =?us-ascii?Q?TF9c5jYadiV6ZZO4eFK1a9nRKQ9Np8scj/94+KKEq3X14gP2wMxco/GxSC9t?=
 =?us-ascii?Q?cHYhP+Sa+A7NgLHdCa2f3R3JvrXXNdIB7BlbR6OPEVX6vZRB09VzxEPrT8lN?=
 =?us-ascii?Q?Ht5Hsach6b/Jr6Yz7nbrSSliKyJD0RsB+qO82LKYqtBQ+fRVZEYufa17yRT+?=
 =?us-ascii?Q?CmZaYnYbI2iX9goTnHfy2768dey3w5y5qVPsnExi6zVHhfNJ6wYoSif9XE1H?=
 =?us-ascii?Q?TMITNDoq63O6gkiZxdSVSKIB5W7PPsDx2UWA2qdAKHBLKbEVoqzUM5TATn+e?=
 =?us-ascii?Q?qnIGXiRjFFMUQffv5Qf8IFT1ChSvVSbG8y6YirYfvzL9FeoR6O/2m2eskfJn?=
 =?us-ascii?Q?ax5ynYX7ZLzJoZ5Id2VReSvwUb+Rc6bLnmvIVASjVin/J5OiYniG6nnHH8MP?=
 =?us-ascii?Q?a1PHQcfKrxb78n/Crrq+Imar/8xWyvEPgbMk2hC/ERDKJ4Qu2Yenn7dM/g9v?=
 =?us-ascii?Q?t8W1QHIY+Q75osiIAF9tX6hiN6ydoKk5vxCuegLOO95NFPYxmYK9bSGLB1R3?=
 =?us-ascii?Q?uRALleuewkhyjfeIgQIAkJreXpOEF4fwFnzBX2boHIraBwk8rYsR5KSTiXq0?=
 =?us-ascii?Q?FReG27nN8HPii0q9F/D7EjMbPGjF3dyXOGYP0mVFujJyJu6X9Zxbz3MwaILK?=
 =?us-ascii?Q?TSu0FNAAQfplng6vNUNnP+aR9uTr9hXE6cFEtXlB6U5HlO5kN02P5rjBtyu5?=
 =?us-ascii?Q?Pi5u0Oh8HSWrxL+5rU4rJctFH+lJOCb+8z3hqnCZPQo6eSDg10oTO03wXu4W?=
 =?us-ascii?Q?aBRYL0jBw86q/1SkyvF8xJTH7EpXTGQCGWlxTh73hfiU1ZDl85MguXqnNypk?=
 =?us-ascii?Q?MCD2NOIrSOV0DmXrH5ZQSUotPzDEQrjn4FLK4xD+wGrrNyWIFqy+Iif6V5mq?=
 =?us-ascii?Q?++EV7FC24vVxZGJ9r7WG/sitmJImowFlHQ6R7XRcShwNATE6LmhdLdWbkD7B?=
 =?us-ascii?Q?ih1u1GemKN2icZGzn55q18yWU52e7HZnNUl9/O+j/MoJfYoHgOr82u40PVwd?=
 =?us-ascii?Q?2JCjbdjg8wA2cNPbTGo2nhH2+CcNMCrYBkKP0PZLFgUbSfsyRk2b9FZvMEMA?=
 =?us-ascii?Q?9eKyLb2Ex21qMSRWzvAC9n5saIHRvs84B4aUkHsFDK4nkzt3v4aPyuSfZonU?=
 =?us-ascii?Q?4HDQl++9IN+CiCyNfc6CpREPNpnT+NaZ58V6NX0G4gv9Rf9Vlj1wdwrMwley?=
 =?us-ascii?Q?WLoAanTj8mBVm24yFopYp35j3BFBnJDPXswzeVNMTx33xtMVRsvCJWxN76u9?=
 =?us-ascii?Q?WgYXvtc1yXEevc7Sjb7jfJ0pKW8ZFydvNbHwoFanN2w4LOhLRL1RTqxnE5la?=
 =?us-ascii?Q?pezZ4xhXEG32/Wm4IcWFxyV5n2S8P5X72XJAb0HbdUkYEIE1G3BE+Qj2teVD?=
 =?us-ascii?Q?0Ur7/DQfgsWqVp8qQ9+Cr7t0X7YnYeXaXCyTkqX4WsoAyX9+mPs40G0GJ1Oj?=
 =?us-ascii?Q?lf7TWipaHm6I7ynYD8z8n5RO7/M31/mN04uv0nxLoj7MksbxbquIXTXzhmaQ?=
 =?us-ascii?Q?2ZuCoVePClkhnxLIoLhJTiPd3cD1RMSx2zkS1bHVaHZiAMSRRDG3DeHXN05S?=
 =?us-ascii?Q?MQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892adf64-fd93-4150-4730-08dc57e66623
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 16:10:24.7247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OLYIB4Qt6aDF8qawnyPBzwhKSwFo4Wn3rXWrWIZZ4MJ25WhQCXVFCzNUg2s5vv34zbsZwZYLJbUxYf2L1UjokA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309

> Define new options in 'rdma_set_option' to override default CM retries ("=
Max
> CM retries") and timeouts ("Local CM Response Timeout" and "Remote CM
> Response Timeout").
>=20
> These options can be useful for RoCE networks (no SM) to decrease the ove=
rall
> connection timeout with an unreachable node (by default, it can take seve=
ral
> minutes).

I've been looking into this problem, plus related timeout issues myself:

1. Allow a client to timeout quicker when trying to connect to an unreachab=
le node.
2. Prevent a client from ignoring a CM response for an extended period.
   This forces the server to hold resources.
   Problem also occurs if the client node crashes after trying to connect.
3. Improve connection setup time when packets are lost.

I was thinking of aligning closer with the behavior of the TCP stack, plus =
a couple other adjustments.

a. Reduce the hard-coded CM retries from 15 down to 6.
b. Reduce the hard-coded CM response timeout from 20 (4s) to 18 (1s).
c. Switch CM MADs to use exponential backoff timeouts (1s, 2s, 4s, 8s, etc.=
 + random variation)
d. Selectively send MRA responses -- only in response to a REQ
e. Finally, add tunables to the above options for recovery purposes.

Most of the issues are common to RoCE and IB.  Changes a, b, & c are based =
on my system's TCP defaults, but my goal was to get timeouts down to about =
1 minute.  Change d should help address problem 2.

If the expectation is that most users will want to change the timeout/retry=
, which I think would be the case, then adjusting the defaults may avoid th=
e overhead of setting them on every cm_id.  The ability to set the values a=
s proposed can substitute for change e, but may require users update their =
librdamcm.

- Sean

