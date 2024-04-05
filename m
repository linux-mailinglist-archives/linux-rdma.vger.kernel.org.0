Return-Path: <linux-rdma+bounces-1803-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF2D89A294
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Apr 2024 18:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D341EB21964
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Apr 2024 16:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AF516C854;
	Fri,  5 Apr 2024 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZCF2az4c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2103.outbound.protection.outlook.com [40.107.236.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00675219E4;
	Fri,  5 Apr 2024 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334906; cv=fail; b=Op8njFR/KDqjAzAtWQrg0JpEv+7Mki396hXrIuwF6Drxx47YBQ9CZZ6oy4IUTreybkmA7/KuANkbCXSTOSRwhxVM5P6dQC2bnoZZDMhoLA4YX1Skxz4TE1tt3HXkgTAGET57Kxrry0Pnydty8hqKLYbzlzCL4LAyLr4doUfDg+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334906; c=relaxed/simple;
	bh=YV1rXjmvlMS6tpA03HbvC9EkhKUh9YYxNwYDzJ3wuHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jHkeg2QAzoWUtJfQ+FD0SQLItUhGh9Phdz/2uwl5Fd6ZGpUMpEkwTC3KJaGxemDm/sCy3iYBEbI/L2R0pTvqq3MnbeS+i2mfwf03x0UgI5Pptbd1W6cSGiAv3JtNr6u7S9ReTQtmLeXUDpBgjwOLx/JMlRO8e4FiZM0NoS5wXlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZCF2az4c; arc=fail smtp.client-ip=40.107.236.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZzD4CEgzzJMoMzKxndB3xKlPOXOVSDuj7V4rlLyf8GsEch6URGNbAwLYFzfMsGt6oo+GJCKYcG2UGrQ7YC+VityPvpz+fJ5kuD7QD5QqG1p5rshZsvu2dU3tuT/XWCUSxok+5oO31/v8+CTp3ZlEknclMp/f4Uk8NbxahLDbQiiAlP7rStiFaFJbDVgChKd4W/18DASxfR6qVaRXUsv/veYik2j92HOI14ddgBJTNHO/26WK5OlYAz3NUH+eQ0eoSP9WFw3u2Hp9IOglKweNKoTc9qV1UN4rSpaRJfqBsRXlhCAFjACwxU78X14tYC9v+mTn8ni+VDVd6WygzusuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G/7IE05HCMNlnsfLRvklBAeBTjSEMZ+wkk23wEnszQ=;
 b=OSQ5plRF/sObHbxgKJ6N8kI+7jbgIbwByA8Tpxj9cHFMlcz4QuxbOytxLSUoJq5Y9Mh6mlfUX+9qg/P/s1hTFFwhne+H6uIGOoxsPsFVjp2E/iyzJtJc9nZdv/P8hAhHb61+8KCgwT65k80IEoAuwnNDx31kvACjXTtuT3wOSWi0Ch7ztekVMvTQ8VRd/ejsRVNatxRY89We2lzbHxD1VEWaJDRPddH0w3Ughn3sYP4wBiu9FoK1n9cfGLQdqpM/MuiKkH0a7BY241xcIhSBTP/zrZuB7ruKq5MQ2GKZaO/db1COtXpVwv7vDcNPXfjM5dy3ncSCwiJcQTmyZBtxcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G/7IE05HCMNlnsfLRvklBAeBTjSEMZ+wkk23wEnszQ=;
 b=ZCF2az4cfFaD3BTSPM0x3+YNtzm3E7z7xBDJe7OzFmag6mbaPzpMVHMdJo43MLfudNNOcPR8u98wp8TJEzSsKc5RoTVmDEXHPcqao7yajjF/Z79YWSJju77Z+6eHBS875O4tEvwAVzlQFzoHDcIV2ns51lm71/T+ERBMdqqjiXghZXuTMytComIknQ+j29FhajSgqpiekp9MGLY6ok+cPjyrw2AD5M2V1FscnwGGBVZzG1+B5KNjx+jkGwQqdo8CkuIzv7ypVHsxXPX24OlUw+RO9jZ9TRWgTD+DU6kuL6D7JEmCU/qGw1/r9EpXgbN5ceujZKXIoH/vaMQi9YISWA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 16:35:00 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490%5]) with mapi id 15.20.7409.046; Fri, 5 Apr 2024
 16:35:00 +0000
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
Thread-Index: AQHahe5FgfZ7dsjCtEiNfhPRFPDDgLFY8/iAgAAIH+CAAL7zgIAAJJ/w
Date: Fri, 5 Apr 2024 16:34:59 +0000
Message-ID:
 <PH0PR12MB5481F01E3B241D87AD20E947DC032@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240403174133.37587-1-parav@nvidia.com>
	<20240403174133.37587-2-parav@nvidia.com>
	<20240404192107.667d0f8e@kernel.org>
	<PH0PR12MB5481D604B1BFE72B76D62D37DC032@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240405071337.3b9ced49@kernel.org>
In-Reply-To: <20240405071337.3b9ced49@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB5663:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +lbFWZHnGsmsl4C+ZAIwDn3H0yORh971X55cMmhW8i+PPSL09T46s6ojNcGJIjxyRR0dZAjP76n0uhut4odzEHdmDj0Kr7Cgjl0FFtN0mtoihUV+BM7DztuIxOerHTsY6GKrTXmTXUwjHG2jF6yG3nC/Spy1Z+3mySlM9z2TGEu6/5RKoaRpVR/+Si/z4cx8dhrGzniNGcEPOhU0BIRXOYenjcOTDOtpj75PG4GLr1dOvFZ/1L1lwqS+G8CGN1Z7hOm7sv0jHpUHbY+HloU2oDVu18q4pll3grUOGekWaV9fAsN8ChkQWYB0LnXOa5CjQ+X5zzxXA3j+UuZPKl5wqV7Gn7RGGUdbACxa207bIvckYOpdsWfT6GnSnqSPwjrydU4JPc8BxEOgmy//vlm/rRPfIwgiGASUF4NrYG1YpLeZn3pod8KTD7Cspq003rJlsjStK6kpHw5q7mOXLdPpmDogISDvM7OQ2np6ZAupaYLDOo9FVMwcc/tZbxyBRD3kxUlhoo8DNkD5Bkd7DDw1OrLr0WDRlD76KI2H8Z1Bx7fsnwSpZ9LU+WhoWzUAn4S+leA5dItg2GrdG77zqvj5zymQKkbNqAcMKGN9Sj9J9jxY3Cuk7kIu4QHJ74K+SrUAyMvpk+KxMe95wXd9AvEv/t270l3d77WZnxyRlKlD5XU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XTjJbHPwwIyik0h5WWPrG1km/vW6pkLGDSGwXoA9qTOiTeVKZ0CdiRRtC3Te?=
 =?us-ascii?Q?v4PkoH/KUCCdDVF5mpcZsgA50/NvqM3JB5g6ADm8OEA77WVyMBDiVLb8kmvi?=
 =?us-ascii?Q?f59C2Eb0L4gqeIV088AlNF2K4ceSyWVI7IP+AVkynTidAOhwLDlrNEdxEexy?=
 =?us-ascii?Q?se8gz31uZY04YnGBVYv9SaeufHRLhvZA0MImQYa69MmRd8G7OsIiBf97hi9W?=
 =?us-ascii?Q?jz5uum1gd9cnyr/TPM/95LWNUE+yxRH0ExWVZ2zygD1NBEmBRoWNuULW4oBR?=
 =?us-ascii?Q?mJWSh3zNwcpJNZ3o8KQncE48k9Q7usmlJd2ZK1XS28/K5qjR4medOqSrF4/P?=
 =?us-ascii?Q?rcN1Sn2WD18srrqQDPUdcFi1D0MffK/KEO+RKkTllo/1Ma3PC4UzzV5dUk3g?=
 =?us-ascii?Q?6g8OjnkmOSeDhydKrLpgIjRuzDS2Xt1CX0rXyGBcocI0E+VD/bLKzLWYP61l?=
 =?us-ascii?Q?IHvFEoGepunCqU3RzfB30/gkH2QeGSuGNSnB365QZv2ILsDk679t5VaWwarT?=
 =?us-ascii?Q?NqlW/8dX63gczaFqwENc0wLDzIzcmOXF3WPWIdBgYyyCnejr640THZN4T58S?=
 =?us-ascii?Q?D8koa6BbqJkqXdxI+HV69Hnb9JwQrLIcnnaVPVFsZmQKx5irZ3vh3DJQU3HZ?=
 =?us-ascii?Q?iKKMg2cKJMPgoSZqF6BqGFIP3ycJnmI4joB99CCre0AX1Ba+E5hIvKJyetRC?=
 =?us-ascii?Q?13ZKar2KsEJO38MeSxOG8QOHx/7A2qu7b+TcQ7JuftsY+gUnR614vSvurx9w?=
 =?us-ascii?Q?AcPHyugEHRKeQVCtRsOvutcLrw7LabBzWLnDZUHC3liK0i/K6n0cNlEFhcNx?=
 =?us-ascii?Q?T9EI8worKb8ce0Qgwkwc0MVocXAcTnb6lygATjOsuABP34G5dtXl+gkV12Po?=
 =?us-ascii?Q?kqNuC1SjbGWOsZl1Z0tOUtozm3F2i/M0y84yBF36qvsrkTsDRUW0LWXRYfMF?=
 =?us-ascii?Q?2p3/TTMk8iKsQpkG4fyzyrFOeI/nmIOy1rHn/tbknzVPZj/2u2MfS/UpxrH2?=
 =?us-ascii?Q?d6+hsYs+oI8m6fFnO/IFkk/BrW2rrCo2NtC+xJgQvghRumLMUt5z0dCcZlxb?=
 =?us-ascii?Q?VmsKsvtJIE5F5QHkJ7h6CDpoWqLDy9Un7419L97IMAj7kn+lvXuvMTxlz5dD?=
 =?us-ascii?Q?UXPpi4gdCtiTjlevW4ILqA2KSKcWM/eIxCopgOPeEG4y4cJ2B86I49tT6Weo?=
 =?us-ascii?Q?y4yUDDJdiqpqbsVqLbHbciwVTkHN3dBlm01mx25HiLVXm2ztzIrpOSsD2W7U?=
 =?us-ascii?Q?c4wtx19LN+XdRC5UBxmqjtZ/6w8JnftriczpnfxZRhnLYolzD7D2QrpLkqRm?=
 =?us-ascii?Q?ffcsHVKuzwLNb0UL3M1bfBecdu82HDzsMJkBdYfwdMz4BVmFo2KWTkRm8+x8?=
 =?us-ascii?Q?gdpKcQ1gKF2I1XOYiWaookFkbgFXgBKb0i3drAKeXC82EvXOY8WqgzPd1EXA?=
 =?us-ascii?Q?22g9a3iAZ8J12j+sLhwRbmMF7O8Dr6Mce57aT99sWoyEVZFOoE3h3DzmyyKy?=
 =?us-ascii?Q?pt5RqFkGiBibakrruWCZPujEdybh4kYLpNsUgT6y09Rcd/Kx2yZtt8yKP1Mw?=
 =?us-ascii?Q?10VJguoKB8oI5AC3olk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e84b90-e203-4056-cd42-08dc558e563f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 16:35:00.0201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1a9Ev+T73C1jp/YJbLrEcgEXasiv8iK0PYg7G6aX4d3Vxyr+mxzU7pPjdUugC8JfHMneFxmWDyXeZvWclBL29A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663



> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, April 5, 2024 7:44 PM
>=20
> On Fri, 5 Apr 2024 03:13:36 +0000 Parav Pandit wrote:
> > Netdev qps (txq, rxq pair) channels created are typically upto num cpus=
 by
> driver, provided it has enough IO event queues upto cpu count.
> >
> > Rdma qps are far more than netdev qps as multiple process uses them and
> they are per user space process resource.
> > Those applications use number of QPs based on number of cpus and
> number of event channels to deliver notifications to user space.
>=20
> Some other drivers (e.g. intel) support multiple queues per core in netde=
v.
> For mlx5 I think AF_XDP may be a good example (or used to be) where there
> may be more than one queue?
>
Yes, there may be multiple netdev queues which can be connected to a eq.
For example, as you described, mlx5 xdp, also mlx5 creates a multiple txq p=
er traffic class per channel which are linked to a single eq of the channel=
.
But still those txq are per channel AFAIK.
=20
> So I think the question still stands even for netdev.
> We should document whether number of EQs contains the number of Rx/Tx
> queues.
>=20
I believe number of txq, rxqs can be more than the number of EQs connecting=
 to same EQ.
Netdev channels have more accurate linkage to EQs, compared to raw txq/rxqs=
.

> > Driver uses the IRQs dynamically upto the PCI's limit based on supporte=
d IO
> event queues.
>=20
> Right but one IRQ <> one EQ? Typically / always?
Typically yes, one IRQ <> one EQ.
> SFs "share" the IRQs with PF IIRC, do they share EQs?
>
SFs do not share EQs. Yes, SFs have their own dedicated EQs.
You remember right, that they share IRQs.
=20
> > > The next patch says "maximum IO event queues which are typically
> > > used to derive the maximum and default number of net device channels"
> > > It may not be obvious to non-mlx5 experts, I think it needs to be
> > > better documented.
> > I will expand the documentation in .../networking/devlink/devlink-port.=
rst.
> >
> > I will add below change to the v4 that has David's comments also
> addressed.
> > Is this ok for you?
>=20
> Looks like a good start but I think a few more sentences describing the
> relation to other resources would be good.
>
I think EQs limited object that does not have more wider relation in the st=
ack.
Relation to IRQ is probably a good addition to do.
Along with below changes, will add the reference to IRQ too in v4.
=20
> > --- a/Documentation/networking/devlink/devlink-port.rst
> > +++ b/Documentation/networking/devlink/devlink-port.rst
> > @@ -304,6 +304,11 @@ When user sets maximum number of IO event
> queues
> > for a SF or  a VF, such function driver is limited to consume only
> > enforced  number of IO event queues.
> >
> > +IO event queues deliver events related to IO queues, including
> > +network device transmit and receive queues (txq and rxq) and RDMA
> Queue Pairs (QPs).
> > +For example, the number of netdevice channels and RDMA device
> > +completion vectors are derived from the function's IO event queues.

