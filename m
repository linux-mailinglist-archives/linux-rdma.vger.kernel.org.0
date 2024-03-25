Return-Path: <linux-rdma+bounces-1545-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D597588B00A
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 20:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A381C380FF
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 19:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE7C1946C;
	Mon, 25 Mar 2024 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WFsJ+B1R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11022010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0982B14AB8;
	Mon, 25 Mar 2024 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395269; cv=fail; b=WFGXEAc+aFk3cdZPZtIOsBJpiOK8psxfBGXrrOPpMf7EgZIG3MEPUuxWwDoz0QEz6OeNXqdNCtyHq2gPT78UCZLWfPqAjvmpsncL7cvGTDvGOTUUZzYM5E6eL9KRO30QoU64HnxaQoE8TPH8hzvD7ZnPQqzj1/3Of0uiqDLxJKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395269; c=relaxed/simple;
	bh=NaYjyiCONTzDIHstYXGXBeLkWzTDg2NZhaLGx4RjRss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8cfgj8lI/6Fus4pOZ8yL2D/Z9S2HQXsYa8hXrHr1o62DjnawovZ8HqI3rRyP16GxTZALUY7deK9+4PtLlrQcJwUKBOVbnK57fZq2e50A5jUQ4ByszGCYyUwK3SC17tEUMWKhTeGgfP9PNp4LSfuknZIRmTkaOa6RFcwnZ8Mpp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=WFsJ+B1R; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEYiGoJzW2q3NbQ21BkH+dd1YSKpRdV7rlQS9AkXHQ6Mf/1wknYR9kI2IXgmvVCHc8oWsaL7WBDA1id7w/ZzFudaQiIkPF6NUz0hrIagDpvnITNpWeiGKD9cCV/Kf0xZk+tHXZ/VATD6XIsm8xdWNdLPZEPRh1WFK4IuFrlrnudWd/a115vnTVC/0/rcI4R+5pG3B+3urM2pOpKU0L7Wa0/AizXICAn9RaE1A61nX+QScmndMgJfSIRPrguVdvOGYedHpN9lrO3cKatpFN9y5RJxeLMPdMTYR13OiOIhH/azfLNcwJX9Jn2MdftsYqkCqMY5bV3thdNmw2O/jOhwFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaYjyiCONTzDIHstYXGXBeLkWzTDg2NZhaLGx4RjRss=;
 b=gU/N/axfPwqUDOjYNuAnBRw9FYPi39a6ewi0dKGOLi/LQY5i7wxWT5FCMACwXmt3zduGZ/aQHHU3hBg31ErdzYWT0LklCxCiEIpop7KtTBWHU+Q9zfP4IvHjOMyyx7z5Tc8Pdp3g/MxlaUIg6fElOYzutEhDJawCsL19jcyz7gRyi0Wrrw5UHHzM0GnIDk1e7llXW5eU2AiEMTIcJJlBLtsC5vGibZV/LaRWCqfrbj7an+lt+xBrE9GokueKGNpO2aIViSniUZl8AwrS9/bLf4wxp6K/pBq+JPl3me06aYgS2n6SvslLft5tTuqs7OmRhd4+ikEtw0R5Maqkxaa1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaYjyiCONTzDIHstYXGXBeLkWzTDg2NZhaLGx4RjRss=;
 b=WFsJ+B1R09EIZTaCqKw0qLGjN6FqsFtfkO2RCozFDQ5H/m5NLEizFBbhTHldpTV3JodB0jZPXnrVfFw7VLeyV3gWBtXxOE33qNXbnacCvNzU9zeRCIlQ2FVwqAmgcLefLZw3ouuX0k8FOOAd+PRc6bqTHi2G8Se5OeOT5COjNdU=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by MN0PR21MB3363.namprd21.prod.outlook.com (2603:10b6:208:383::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.18; Mon, 25 Mar
 2024 19:34:24 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7430.017; Mon, 25 Mar 2024
 19:34:24 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 1/4] RDMA/mana_ib: Introduce helpers to
 create and destroy mana queues
Thread-Topic: [PATCH rdma-next v2 1/4] RDMA/mana_ib: Introduce helpers to
 create and destroy mana queues
Thread-Index: AQHaeh7yCoDHua5tr0OcwydT6xn2i7FI4o6Q
Date: Mon, 25 Mar 2024 19:34:24 +0000
Message-ID:
 <SJ1PR21MB345774E6B3687F5FEE2A6F72CE362@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1710867613-4798-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710867613-4798-2-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1710867613-4798-2-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dff51812-d9f1-4b40-aa9b-425143517523;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-25T19:34:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|MN0PR21MB3363:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 X9i6nHAE2OjtaosesZOfhF5ML7d7ps4E78gvFPgW+NUGPC1DbQqm+bJMGiC0rowt8AxKi1MiZYDq1mF80b/56fiR0IJ9sV4LyevUsQ8sprtVGgZukR5GcXji0nzn5BW3JgWo+WTf83giF/uvAaQ2ja3tNxYgvdRXHdSHpJsU9k4S9dfBcWmh5DBV18TejtPIPIPO7u73ZmMZIP8oy+8ovyoMaIuhJsnWrCH64XTjd+Muno0jDwX4IWPdpGqBGx0hjQ0sWi7u8jtwWTKPzz0vMTHKzXHF1BaHH6h5zLZqWfUGf/Iu10n8ooHJ3zrWX12KQvBT09vqOoz/7kguCfQgwmgkPm5E7O9MtbAWBa5Tnf6xbWWAgfVCIIbYFO7xXuhtV663fkeUr/LFyt5SkZmFTrbiI8bfX7tZ+lt7CiMONQmZ60NxprCWmXVSssB1t2sDsZ/OlWK0/EICVNNaRvCFkgoRT9lMBIIXg9Qnb7ToukWPLVfTDMR5MNEbkOKtBwI/D1lXI+6DlXM2E4VHczfItskKtzYFv3evC9M0Ms/lcRh6RrjrjvWSGT2Fe7jcTRtf0eJ6a4MQdjeQWgsske1bi4R6D3ej4QMjfalzloWm6wvzQ2fxz5Wtfw27G44NITioVXwjJRUjGfmPcZLQPKdSHMuZSBM6Vrx2daGMTJVn+Ks=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i3HqG8umVIiA9iEvv5s78kfzSm2rGP+X8Ld1nWS8ZbEneDR/wk0qUNvhr0e/?=
 =?us-ascii?Q?KiKZZvUBdmsvvC86l+9DjcjhW0bXx8yzfdpzc0Pr40Gi3H0fak3ub0az4ouE?=
 =?us-ascii?Q?u+3MiMRdwXCUwB3IRKX4zrd8w9/a17ggTBvT6U01WQB+QqEWL4Xd83bTc7Mb?=
 =?us-ascii?Q?Ub8IplGOlw4QE4Sb/OLB7QHpZOhg49TscsbadmYckztZsPLUE35S0XlYMV5R?=
 =?us-ascii?Q?C8BJrlHzXDPDVJp3i82eVdRZEPgzvdWbcFZaU5U14cTF8s4e/4LJX0Vz8+Tl?=
 =?us-ascii?Q?nKWbhlaGuG/ZV2PvhTCFlXppdRsykwV0Sgmn3WD8p802vW2VXOYwJNPjokvu?=
 =?us-ascii?Q?1IXHwXwNct7rgyjFeRcZI/ee6RuZT8pf5O2X2GFIwgwXR2KgYzRE3L+SNKjC?=
 =?us-ascii?Q?yIMI7GOg1AV/SzShcmdCfz3Dn8BKwryVNlWQYfdBJcCYPeeD5dRTcQCX6P+c?=
 =?us-ascii?Q?QtKb5yC1rx0Wb0IaMK+CtYLEH3pQtjzQrjZ0tEp0XG8eSqpP+3mjuAsHbSez?=
 =?us-ascii?Q?vVWBAkw6qUt3fV7LgE+7NqTfrq1sBK1SUw0gaB/Otd+Ta3N3iTMNP0VHs3Tg?=
 =?us-ascii?Q?0Xf5C6CblwD2FYzfMFLYQAxXgMaXnAtzFMPYM3v/RXYPuRvHhtVMqFQmp2T0?=
 =?us-ascii?Q?p6VhyZmJUtYtK0NWUcAqhqBUz2STkDlet4W6V1TBM+mBGvFon2c6lvTRlPpj?=
 =?us-ascii?Q?/1S412uN/yD5IDb8eqceLzkDX06TuBrKN1BzBDRNsDSnfjkSvTG/OdcdO+PX?=
 =?us-ascii?Q?Tvoyi+pQrVIPVDnBNF62x9h9Ax+aXFQ0U2N/asOhDftqC+NNwR2tENixtcno?=
 =?us-ascii?Q?cnQDZth2Mot+oDd3tGEorLiaj7I5zgtCyVbKytwx1FprhPEKKTBJExzqtW5u?=
 =?us-ascii?Q?Ihh1lrJgvRgB/8zyI+sz/n4agakRzJ5GQXIiKO+xF9OU+FasGK9xP3KCVGR8?=
 =?us-ascii?Q?tWEVrb65NtMxvmqi35TjQoOoua6Cli02NYZQoHIVBDC44ttjmL0/9EGXS1iV?=
 =?us-ascii?Q?qWj4sSmlceE3QS7C/cJrlclayaR1SDLPFA8QVbapYMGUPsjLp8Ac3MJEavBP?=
 =?us-ascii?Q?2wQv2GXsO5kkVMPGzAZoM9BNA8j+iu4Qmto1pqU5VBP8S91o/1YQdQi0Mf+D?=
 =?us-ascii?Q?WtPoXCOMT9iXLtl91IBima+KVWjAFuYT90D95ErdeVK/Ad4yGAUra7dZj5nL?=
 =?us-ascii?Q?QIqh+r9K47i4DJTOV7uBW/FV9FHQ9cUjlzLbBBjBSzarGPicHvDfllK5+xF4?=
 =?us-ascii?Q?FmZeZThO+GNfBUQ5PCQ7+ExjIiuDmkUS7nYzL1wQ6euzhZiPIPKtbu89docx?=
 =?us-ascii?Q?fkZHzGBnq7B5isEtm5RDkHnDw44PmhCLrkP1GE8TUFaPv0rXPGVSKvAA0LJK?=
 =?us-ascii?Q?aLpH2y3tgS1cZHdxhrGyRLCZs+gQSnNYMUecP/BwtIthj6cfs8LQLQEyZqbP?=
 =?us-ascii?Q?PlkgvYHdHp/JXMlQsypQ0KqcGQG4lkIGIK41xtkM6bhp6fx1xM+q3eDdVtF2?=
 =?us-ascii?Q?iEVqBeM6fJhdjsflak+Wj750NSYdfO3/jqHX4x/ACT7sHrn7+ebLNllqcW71?=
 =?us-ascii?Q?ct5SefONXZkL9NRsIbEM9JiQL7JQCJMJixjfK1O9?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3fa3bf-d923-4ec9-594b-08dc4d0293e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 19:34:24.5848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rQCNcZqD8aTtY2kHjuID4BzgoITMZcAgkmZt+D2KmEaeqRcuCP8TYtJJeAnESE6X24yzlcHY2idGNTVmUo9xww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3363

> Subject: [PATCH rdma-next v2 1/4] RDMA/mana_ib: Introduce helpers to crea=
te
> and destroy mana queues
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Intoduce helpers to work with mana ib queues (struct mana_ib_queue).
> A queue always consists of umem, gdma_region, and id.
> A queue can become a WQ or a CQ.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>


