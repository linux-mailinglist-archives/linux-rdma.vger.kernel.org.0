Return-Path: <linux-rdma+bounces-4650-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF07965447
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 02:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146EB1F26696
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 00:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98394A1D;
	Fri, 30 Aug 2024 00:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ztxu7AyZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020138.outbound.protection.outlook.com [40.93.198.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48EB2F2C;
	Fri, 30 Aug 2024 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724979273; cv=fail; b=DgTk0zkNjrTzuK4FBTPy/vtfux0IwI0l0DP1YjEeAgy63QgWLj3lEun4EwtZFRdGR8gEkVrsUYeVqhh2PprZjlVgFfkAp85cbRthUHXXp9gL/bzIZCtaUB5oD9b9dFY9q4C6PAwE071mGP7B+B+AU8CkbAnJFw6SQRefwZDZuw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724979273; c=relaxed/simple;
	bh=9Rbo9fFYOy+K7aeSbwl5ouS6GPRfurwczZD+Dlwl9mU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9Gw3FIkIzkEpOL0i/boeyZxmOxX7QiGpeWX46KuAcKF3RMHWM68tyrtuJaNLoCQ5XWPfcDNm4+M3qnymomUM1hmO6qjhRxXutgtXO2sx1TMgZmc931e6p3NJ5U53xeZizbKAtlYqFCy/FY/PDWfkSVAoKkILl2VykG4luST65M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Ztxu7AyZ; arc=fail smtp.client-ip=40.93.198.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZIype7OYffCHdeqYdIQSq3aZeTZlrVUNTIEK+Oh4f+Ot8OM9WD0K4FrwR4kvo46hiLFcQuPlbXnTAOqnUNPhBHTo/lzAwHooYbYC6OogBUhTpN0xYa8/NZfTw9a165WJAXzsygWjUAr0Izi2PZV3TpLdIQMTQcoNb2AOV+JQ6xsgv1MikqIbIihBdC7OGiz6ZJdE0I4vD1ccrfW/OcDZad/VFTgZd399RfjIU/5I6LDMBha98X58MbamREQ9/8Z3Y42Fx3ivY9ieU5M6Dhag9o/cF8aR/M9byEwHQCujYlP8zLPDOS1UYEHYTns7mVUalPuTrWDXFTRi2oc98rn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4duIRjhePu6lshiWhFAQaWn0URV3eCTfk8Qc1tVEcos=;
 b=JqOCLpeBHs9npL8PqSv/MsQMV6GJN2Kv+X/989+bUe6tK7IfWQBk2X0tsE1sTuvhJkqAmVPDofmciboeLLXOkF+f4cLp6LSJNT3+ivdEkhYby/er1rdQbiHeXszZ0ocwJyKdALc8N3GxH+z0OjgPKPY1AnbzQSYpX7KHir4OrVRh2yQUEu1DNV05in66JlV+CQUa8QAdICdW8XX3KgpC5TVm/G53/vAuAVtZnT9GoyyXPk5MwKQBT22H2zkRXDWtrMUsmHiXHD6rrXcd8gHHuUF1Tm5/e5B7emREF7YGeUmsDfzlRy24nNtJldFw8lYLwmA6Qkz+t7KoqarSX9XAnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4duIRjhePu6lshiWhFAQaWn0URV3eCTfk8Qc1tVEcos=;
 b=Ztxu7AyZ3hjpf4PPNkHus494UtPdGEqCnqVQeapNDE24qmCZwxGE81pIHjsJM5nWcYBxglpWxZcJ6SMhp/OrYZZyj5i8iCo3LWD4iDs3JM9G/n4+vnNJ7SIhzjAtvrugrgtho+NLRU8UmEkTZ57x9gdvY4cZ3VlMlE3t6YThBmo=
Received: from PH0PR21MB4456.namprd21.prod.outlook.com (2603:10b6:510:337::12)
 by DM4PR21MB3368.namprd21.prod.outlook.com (2603:10b6:8:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Fri, 30 Aug
 2024 00:54:29 +0000
Received: from PH0PR21MB4456.namprd21.prod.outlook.com
 ([fe80::3a57:1b5a:a61f:eb1c]) by PH0PR21MB4456.namprd21.prod.outlook.com
 ([fe80::3a57:1b5a:a61f:eb1c%5]) with mapi id 15.20.7918.006; Fri, 30 Aug 2024
 00:54:28 +0000
From: Long Li <longli@microsoft.com>
To: Simon Horman <horms@kernel.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Ajay
 Sharma <sharmaajay@microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net] RDMA/mana_ib: use the correct page size for mapping
 user-mode doorbell page
Thread-Topic: [PATCH net] RDMA/mana_ib: use the correct page size for mapping
 user-mode doorbell page
Thread-Index: AQHa+YW/VdZQzbSNHEiBiZGYidNv2rI+Qr4AgAC4XwA=
Date: Fri, 30 Aug 2024 00:54:28 +0000
Message-ID:
 <PH0PR21MB44566F4DC8EA85CBDC754A14CE972@PH0PR21MB4456.namprd21.prod.outlook.com>
References: <1724875569-12912-1-git-send-email-longli@linuxonhyperv.com>
 <1724875569-12912-2-git-send-email-longli@linuxonhyperv.com>
 <20240829135358.GA2923441@kernel.org>
In-Reply-To: <20240829135358.GA2923441@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bfc07475-e179-443c-bbcb-880729782c97;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-30T00:53:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR21MB4456:EE_|DM4PR21MB3368:EE_
x-ms-office365-filtering-correlation-id: 73def5e8-d619-491b-b1c4-08dcc88e4d3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IOFaVktsqlx5ZoYWxvoasjW9fJPTCkxuH410n3Vf7Q/TjoeC20v3bUguzh7u?=
 =?us-ascii?Q?Usj86tJO+oH9nmiGvnLkaa4C3SpYLmeC5ZqLXqU4Nhh4Dws7leZT7EC7Iub8?=
 =?us-ascii?Q?Gr1b7JWyBa66aRcYTRkTSjDyogER84/pYa4fcqcxnxBct+4EpjsG82tQax6f?=
 =?us-ascii?Q?jEn1DLJmbDHKwNN4yYCquL/nWzcGCzzv78V30tKXvMB7Ql0DtecPxGdEMYTM?=
 =?us-ascii?Q?zDjW/fApeHEjNBEb+/tYpARryB7fh/6E6lxrEw9rgJxs5QkHXxFsJjc//lju?=
 =?us-ascii?Q?6mXZwxyeUFY9DOCy58jOqGI0i67JcNaeM80KzlwrnZ3sCJRmFdVufSxTNX4d?=
 =?us-ascii?Q?8LX+fUrGuxMCfP9Qusb3IJJMI8of9ibhqRpeLysBxXSEDGfe/4mlfUW5gpwK?=
 =?us-ascii?Q?HZYbJ+zFgXWkphP2dAaoTDk4E5m5ClVfMrprrG3NeKRSaFhD4qpQupFuA7Wo?=
 =?us-ascii?Q?E8nEc6aFME9QxFgopwf5CwsIRqkDdBlj4n4QjLF4+hIj2tim0HDF9dSUlyZw?=
 =?us-ascii?Q?FrO0MiBinTZJyrfyhQGI5XDuiGFi3usowdBjAeOJjpuaWSS/2ldAmqUxNpH3?=
 =?us-ascii?Q?ai9vYB9rvNhLCBSnzerzdyLi8jMje7eI1oKMnLlbU/gliUnydmb5I6usqn0r?=
 =?us-ascii?Q?9B+eeJvAJoe5C2f1azFIbIY5FFltjFiuqUJ0UB2B/CM/iqHczS99Y0oda0XS?=
 =?us-ascii?Q?fQ8SkzUSikdkv4RXB9sNtOCxUm/0Jx1Nz6620gp5lUCrcy0UvwYk871PtQgd?=
 =?us-ascii?Q?a5cq1Sd0aIJi4NUTgHAVR82F8hu6HuxETumzxe/16gH46CbSxbP1nP6tx3Yh?=
 =?us-ascii?Q?G/FtgyePonVOHQVY+J9yy2zyXFarjjSx7D/TVrSEnhaEa5/DUl71qkL1bFEG?=
 =?us-ascii?Q?GAbERYTpIRPT93qDn2ZaHaEODVg1HOhlPPB/sv+5qXSrW/pA5dfkVU3EGwUQ?=
 =?us-ascii?Q?MKa4V87UxYDq2jZsOzTsQR3nIEI9u5FKt5c5s0tqDW1pEu/bn4R4aziIoQwm?=
 =?us-ascii?Q?9Zgp7N/UbtSwdQCrhbAd5UIdxDiGTqvfkS/6y1D+ZX3l4DKVGMP36gEB2OB6?=
 =?us-ascii?Q?VronVy/8MrOzzY13vbTBymYTeUcfKzUkKiBSi4/r0GlWqwVNSw0wJumrNUzt?=
 =?us-ascii?Q?RJU/5P68Fub1Y/suSVnQj99Hs2mrO4eLIPdidNV5RywgSmTwDwjpNlKBT4EC?=
 =?us-ascii?Q?n06Brrg0a2ohaFMDzFUegZTmNymAzrr0p+e5h30LL3mYzf5HkH4oCLDgUJLi?=
 =?us-ascii?Q?axcN5d+LzZOEYaNcGixaf/0blHy7EcCYs6nJHuUKuQFVkE8t7bfKYdOCp4x+?=
 =?us-ascii?Q?Ok+L0rTC3WPN7Y+Y2txV6ony6TerrrNS6ThnUxX+afdj+iVIJgsdJubsQjAO?=
 =?us-ascii?Q?FIrHvs/4Meoilhqr5qCAO30twUXZtFG0V4DR/6y3kgZpx+hxrg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB4456.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?luWj4nf1jeBUqaLUEMXhATe4iX2JmFQ2y082VGDennzA5gnI19HFjIEvUS48?=
 =?us-ascii?Q?ZOK8zJ44j/loTDAYbZBKdsX5NhL378BFzB1I1TMqnOGjDPDR3BhB8M0q4F5F?=
 =?us-ascii?Q?hKH0tXgaWrPUJOcJd6hw4HchrMEVCqTW8JpeurE75voAxxJYsZPA46+XfPsE?=
 =?us-ascii?Q?P2YMW2x8GSgNN36XNR4z12e/r8rCmPdOJTmUEMv8glMh9ADVw+Qi6zGnufH6?=
 =?us-ascii?Q?QB91TDHZiyJlH4UXtBcbS+ilEi3rSakGdegQhlid+5MuwVz+HZt+n6bx2zgF?=
 =?us-ascii?Q?frree8SHoZoMX1SuhB5BoyKn9nkkn4TnzJPiB8P6vvMK5T+EZhEGzO4vbwXF?=
 =?us-ascii?Q?AteShBXrxtr+pVOlxvWN53hzbIpPEQ80GUxm/iFTycKqPmvmfhFJlBtomSbH?=
 =?us-ascii?Q?yrszDd+A08kux7Wlv2POv3hkJDxN6JFwUJljRGX+0tb/L3B6oHJuRlJ8i23e?=
 =?us-ascii?Q?AwJ6ojqFOnTGS0wpo845fCO/pS1whWmXSxiASN6kUIsPXU84sun3mu4PimH1?=
 =?us-ascii?Q?qyyKDmKMKaBGGPWTMUeY8lH4x+5l4FQs9rq3iKb3Hf6O/p5FobII+dH8pVRq?=
 =?us-ascii?Q?/0TT5roR6zsD5AazoDrrhkpPcTtkUylp41KbTzA+KQxnMQ+yapU6jCE/xh/k?=
 =?us-ascii?Q?cY3aEzyHG74DiSivjpWwhAnBeVHiCW512O22zs5k15uDmHUnc3ZNvQOQJkMg?=
 =?us-ascii?Q?U6tUj3VKis1taA+hGDKDBcM/DJPTvVEkcR7dcRw4CvxukrEpslhqf1FjVbQu?=
 =?us-ascii?Q?HviKw/JnMLhLyQ7OSHaIwamF2OLwUG2+0RQmrZRtW9jX87Mviym8UMhE9GF4?=
 =?us-ascii?Q?X9d0x+Piofz1TJ236XLWlY/NsaXEKNT7oiZi/BYhtejsHEwIIf2zgTfLB/UR?=
 =?us-ascii?Q?DwbT+6qe2MEoM7Vayjr7BcWasuCARPkDEYAJPx+zve91pGUbr6h9Vq62cyZf?=
 =?us-ascii?Q?u/zSLUiQQ4ANFXJ1FPNuyapYKyX2JktCqvN7MOPXIcqCCvXF8/rg+11fneT1?=
 =?us-ascii?Q?x3y5F7wF6Z0KmEszahJdHNhWa4emrALMSRtFT79782mKT/4uNIjHLx+Pxg0q?=
 =?us-ascii?Q?uWbocRZgQ26zrMF7u4Z23iIfonDg1Z3AsxBUuwGlHhipThGKf8x86Gsf0cjw?=
 =?us-ascii?Q?yi2ansTjnhZqghUTavTFJY8odllazI6axPedp9UksYUrE9atn4Myw8ObcmRR?=
 =?us-ascii?Q?2M+dl43lWTv0rF8IbNl7OjugMfn5rNyhjGTgQMfE/x8NHxC9TZEPc66SpUTZ?=
 =?us-ascii?Q?vZsOGD20fX3tyj9UkaHgLHTkeBPPgrVIZ2r8Jgoq/m4o0JCA++O+4I9D7VZ+?=
 =?us-ascii?Q?I7bHfOLZxLcaLH9Gr/+BaeBx0pBcKTwl6n7u0BYLshXrN5f9vkilxZa2wfS6?=
 =?us-ascii?Q?gcdKxShWG1blMc3letJy57OqoUgAWR9Kp0HdY5kZojB+I4IluVq8hKJ42z+9?=
 =?us-ascii?Q?Ie8XxBqM0YoB3M0s2/7uIKe7LEqt7/BNEIZ4bEwz7mEIccVyPeh5yjCG+SFT?=
 =?us-ascii?Q?fUkPG3Tv5Wx7kKzH2HolRhgz+MYBc0q8/Lt7uunGEJNDxjZJKuWndgYMSqF+?=
 =?us-ascii?Q?GVbPp7HtYssPFoW6tJFTViTkM8Fsa/tBW6cmEXru?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB4456.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73def5e8-d619-491b-b1c4-08dcc88e4d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 00:54:28.6217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WSeHt4K+iyECAsdp6GHKFf+XpoSXOxrMaHfdMdFYtJ6xFNYttW96nHimgDv8iNzjNcKch7E6TGu5UIdknbmGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3368

> Subject: Re: [PATCH net] RDMA/mana_ib: use the correct page size for
> mapping user-mode doorbell page
>=20
> On Wed, Aug 28, 2024 at 01:06:09PM -0700, longli@linuxonhyperv.com
> wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > When mapping doorbell page from user-mode, the driver should use the
> > system page size as the doorbell is allocated via mmap() from user-mode=
.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure
> > Network Adapter")
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/infiniband/hw/mana/main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mana/main.c
> > b/drivers/infiniband/hw/mana/main.c
> > index f68f54aea820..b26c4ebec2e0 100644
> > --- a/drivers/infiniband/hw/mana/main.c
> > +++ b/drivers/infiniband/hw/mana/main.c
> > @@ -511,13 +511,13 @@ int mana_ib_mmap(struct ib_ucontext
> *ibcontext, struct vm_area_struct *vma)
> >  	      PAGE_SHIFT;
> >  	prot =3D pgprot_writecombine(vma->vm_page_prot);
> >
> > -	ret =3D rdma_user_mmap_io(ibcontext, vma, pfn, gc->db_page_size,
> prot,
> > +	ret =3D rdma_user_mmap_io(ibcontext, vma, pfn, PAGE_SIZE, prot,
> >  				NULL);
> >  	if (ret)
> >  		ibdev_dbg(ibdev, "can't rdma_user_mmap_io ret %d\n", ret);
> >  	else
> >  		ibdev_dbg(ibdev, "mapped I/O pfn 0x%llx page_size %u,
> ret %d\n",
> > -			  pfn, gc->db_page_size, ret);
> > +			  pfn, PAGE_SIZE, ret);
>=20
> This is not a full review, but according to both clang-18 and gcc-14, thi=
s patch
> should also update the format specifier from %u to %lu.

Thank you. Will send v2 to fix it.

Long

