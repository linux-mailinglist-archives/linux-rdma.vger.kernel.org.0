Return-Path: <linux-rdma+bounces-20923-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GnAF6xAC2p5FAUAu9opvQ
	(envelope-from <linux-rdma+bounces-20923-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 18:39:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A835710AD
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 18:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADE36303AB5F
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA66948A2CE;
	Mon, 18 May 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iptSUplz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022084.outbound.protection.outlook.com [52.101.43.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132DC378821;
	Mon, 18 May 2026 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122185; cv=fail; b=L7hQZm0Aa42zXllIlyirTBnDhKD0/VugeW/U+uSQEKdmVAeO3Yk1X96hnf1VyT37fCvhgGiUa+zy6Q1eChJU9GNPmjgUs+oCgikYVfkV0mXLkED+X+zGo2BOtfva5+gL5jg/vQrZngXzj6nJvUU9466+CmoQzGDINzElQ0atjJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122185; c=relaxed/simple;
	bh=5Us1l5A570SGUGbM6tZWbdfm7iGr6Jd4imSkbCxgrrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Op+YRm9GugUGZao3nczaGj1kUFJqIPrcUkoAtQIeZV3kGPgGQs+xHegFhQHfPYH8Aj/xY9PNRyzwPE8HtvavrUg1LV5HQ5iouNwEDa6+JD83mHSWGH+aubzCXXJqrPPyox2pGGiiAj7CJQ5v1wXiWAyK7LUK744bGvB95j3HIic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=iptSUplz; arc=fail smtp.client-ip=52.101.43.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdtrMS4z9NDPe+NValltcMbM3TuhkkkAVgUkewx8uBuxLJQtPaMD1zdII0wPQ5PqMDSovwN/aLLri/UABDHUE9LpwCdZoepzcYUDPw+vYuW3pfBTkYHp8bks7O0Q47fuqUeKtOlr3Nh+N+3XvPsMUfGb92BP5mkKv3n8sEpRXB4HQgRveZb7oyNOvuruqxeOAwihIPOxId6c0D/61BClrK/RRwboMGOQdJ0VS3t/OKJLbxyaI9NQutC8HN0vcKmPD501JmxoGPbxmSzd6lSIG7eWxvK7cFuT57UFCk5lsYaPFemfCXkDNzVOdlfGyrj1UmEK8LLFZsT2sKNSbcjCQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOzmyW6uFj1WuH0M6UP2p3R6trBdw+8AxB9kvgtpATI=;
 b=I0r/RBfq5BeoFXgQMetCe822PFQV/TLf5eAKf5vmhSy85k+XPbskrLYa/Q90P9AGPPhfmqjJ03ksjVOo1HiinmQ00HyAV4EiGaSUohUQshnaujWAe7TFVnfzqQPCwiwlE9oL9jBAoKAg2OcE00xwNB7QuPeB9cfawZtWhlipLV7rCfEUQ/stc/JVdPhla+37HlLm6ylyfN6FHNR154fL4oI743Ig1aiI0ouj7lh7iu1HEuQqpCAKwpwFOAb4Qzx4MpJAjUDDN7SBzupO+x1QqyDT67bE7lZnmLD49jcNhIQ/44TrVBMO85aPamM9l+UufJxs1FMAXb3rPVWxHcBLyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOzmyW6uFj1WuH0M6UP2p3R6trBdw+8AxB9kvgtpATI=;
 b=iptSUplzTEFpm4hkv4AFb7Yve6EAfljIIM0EIjFoHq692dppAlQNemAlQ526GptBEjWFhdgUYCVEGWSg9FdrGUuVNoDBo7RdXF2cWA3icy09uy/44XRBolVhIYrff2/HTMQSw+aJjagRQi/NsDK3W1FRHJ4y7KDzeOXEYUzHYG8=
Received: from LV0PR21MB6596.namprd21.prod.outlook.com (2603:10b6:408:336::24)
 by LV0PR21MB5884.namprd21.prod.outlook.com (2603:10b6:408:320::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.13; Mon, 18 May
 2026 16:36:20 +0000
Received: from LV0PR21MB6596.namprd21.prod.outlook.com
 ([fe80::c93f:22eb:ff2a:202]) by LV0PR21MB6596.namprd21.prod.outlook.com
 ([fe80::c93f:22eb:ff2a:202%3]) with mapi id 15.21.0048.003; Mon, 18 May 2026
 16:36:20 +0000
From: Shiraz Saleem <shirazsaleem@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, "kotaranov@linux.microsoft.com"
	<kotaranov@linux.microsoft.com>, Dipayaan Roy <dipayanroy@microsoft.com>
CC: Konstantin Taranov <kotaranov@microsoft.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "edumazet@google.com" <edumazet@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<DECUI@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net v3] net/mana: Fix auxiliary device
 double-delete race
Thread-Topic: [EXTERNAL] Re: [PATCH net v3] net/mana: Fix auxiliary device
 double-delete race
Thread-Index: AQHc29IXUpkG+jMLx0myQSDviZ9PlLYAN6mAgBPS3rA=
Date: Mon, 18 May 2026 16:36:20 +0000
Message-ID:
 <LV0PR21MB6596EF5E9FF4066608251EBAC9032@LV0PR21MB6596.namprd21.prod.outlook.com>
References: <20260504142704.159035-1-kotaranov@linux.microsoft.com>
 <20260506012833.1607543-1-kuba@kernel.org>
In-Reply-To: <20260506012833.1607543-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3aedb691-bc9b-4f4a-8304-8dd1a2756efe;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-18T16:12:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR21MB6596:EE_|LV0PR21MB5884:EE_
x-ms-office365-filtering-correlation-id: 9f87d146-3444-4daf-7377-08deb4fb97a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|4143699003|11063799003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 EmsNlZh6Kwart9Aff1p1CMueS9XWuDmqcmw6IADI6TEB3uUUInC0RK164LnVw6EtAa3rOfA5Y+ZvyWgmZSq8UOTZ4nWfGbUHzuq/kesTj5RqfmonAVC+4pcvLuxY0aM3+ccAz6l+Bd11xrAoXTiWF+XBUMOBaqUDrjM7l3UlJFwGhcAs8cJe4t0V4kZDARawpPBDg4IpU9zhT5cV7GxSC2ynlaUDQOe749XMJq2SfEBqK++VVocUd6b7lEtcztkYqcYlBywrJONo4/Lz/lIOC5MzHGuBN0opaW0oQQtJKulbn06NHfq3c/IO0ufWMntomXMsO3oRDNeIiSPeCKKbg3mJXgMlo2pkYejHcSPY1nhG+KbmnNYUHQmuc9Y/qbU+UuwJ13z7PNozI8dtQvc0Z4r5SYLqR9PIDEn6e8fjjMyNHKGX7WUop4FDl6aPoETFIJo0BU7ghnY1YLJGZ5VR3P4aBY5gXbtV8+DuRRrLnWFwF0IylystdizQGKrTZcB87REq0J3o+2OZUCcMxVUZjnSMN4eSlLBALZ+0M5PEUROF6OyoEgDDJ3aW3ToiBohGM39ATqLtHjNfN8I3vRiLBstBF1Eij8v+TKqw04Gypbj/rdj2NIA/TOa6jcx7iej8mVzSdeq6suvzFtL28e545DWOrtkhwW+p960vFjWBC+1sqjv0VtLQ/J7o7VeBQiJOyvgghoVU+bg+79t9jN7EASZWKRWcc0Zb957kbgICIkBWNiWz012ynRNpu9veNJUe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR21MB6596.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(4143699003)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iayL2PYKy7QXzQH2NeDxQdi+ZALLP92TFj9G7aSxGxLaDj4uufh+GCjrdOtq?=
 =?us-ascii?Q?IZaAX90iDIqaAQeeUhBo7ShEYxubWFH7gxbgVocghl7EZnq+yuIKNeyYCKEy?=
 =?us-ascii?Q?FJkQkVgFmMo7XrsojUohATU150SgJDgc/wBlxUStc5bzLENNlLPxgcCvJVv4?=
 =?us-ascii?Q?nXLbHQF82HdcTx+haDUF6MfNgcmlCDsL0LmBI1WM7N32/CYMHAE4LneB+YqM?=
 =?us-ascii?Q?SuJK5dZHScuYZyv5xBMd/dVNn5f0BLxkBROlOCEHnNueR+yWdkZPVno3O/a+?=
 =?us-ascii?Q?4BtDcA9O2Z1eUF01uDbXhqiOrPEhx38OgWATiOHhVjNHJrIBYEPMeOjGaGiI?=
 =?us-ascii?Q?k70uWy7QHiOZl2i3wWyJsLdwrSmX+6LrK+affrB5295giCxGpSNCh+KPZrbk?=
 =?us-ascii?Q?pAPXGbS1noZk+X2SoYVWQ4d9KaGK19PG/J7SB9sQcL8uuZ3+n433wtyWUBu8?=
 =?us-ascii?Q?Htf8el6MBkb14gOOGdGQosDXZxBt5Gj9EO6p4E9w5K/4tR97iUhxc/xLLCXs?=
 =?us-ascii?Q?UL89ap6nX6dK4IGs+nXsKb5DIANxk/OEXDGC77pFSh0Jwa9RBzUsW6dq9xQV?=
 =?us-ascii?Q?pc90Kg5iLjX4OV2EiXQyIXcs2TD1iRKiJha9c//hMriss4F05Oo8kpfPLctl?=
 =?us-ascii?Q?olrGeLi/wkC0kUurf8Pkcy6dfgpWnjZjVWa5Uz3ro2wG7+cVPgH1NFdVp/lA?=
 =?us-ascii?Q?BAHTy8lfXj1f96k5+eLAB4CNM8ppIy5dow0iubDQkeD2EkbWpz9kNQaMHwti?=
 =?us-ascii?Q?dmnWwSySBWXaFz+ree7F6wtBFyzVH6bPBMFTdzt/zUnSIIKV9UkV7VPoX6cm?=
 =?us-ascii?Q?rrfd1/ndB1uOk/AZ65HICzh/Coqf4UygdY2BhEN5sT5E+7LH/ucaKh3IQp/v?=
 =?us-ascii?Q?7UigfDbWXgNYvt6FKq3S+GEaMf2GdVPQVPESe/8ULH3ayGVfsLA9iTB3CRd8?=
 =?us-ascii?Q?J8DihlK0Dm+EJ4yUIWA/R+BE1DOLXGso9HIdDbJfoNgwBX+pPAPGWSxvmroQ?=
 =?us-ascii?Q?Wkf0w6ueT6bgc/kbUMYMIL47brBWqCU9DrTsiP/Hujx84IgvZ6IAzkIJg9iO?=
 =?us-ascii?Q?ftcjfziQlh4ObRzBQ3t4FiIVz6hoXAO0MEserrvV8axH/hvFp8BY5ZisJcd+?=
 =?us-ascii?Q?yBiFEY81rngdD6k+0uflagNsDaataOm6hyBa/k4g7vgXDSVo8B0CFvxpddDc?=
 =?us-ascii?Q?QeD8/ca8QSJ1VFSkrfShz76BjPNixNBScPqsg4t5+hfPLRDlPak1k5d067mb?=
 =?us-ascii?Q?QsshQ/rcoPO1+i4xGTWSCLcch1NeFTw7Cd4arXHeMpBBYFtK5ZLKbWPE6P25?=
 =?us-ascii?Q?gQ2kyS82aWa+iIcJrGvCfWVs9S4xLUOv2e3uPTKuAe+RcKuRd6tRjo4/VKyL?=
 =?us-ascii?Q?j4QWPfDdyCXFpeioO3jYfux46rOG3JVkzotlSHOhbZEZgUjgyNr9Vl17lvVu?=
 =?us-ascii?Q?oKHRaZiDDfADjLLEx4ML9esln1Ky+8g6cFZW3F3sf7rnIopIqmLHGJ+edWhh?=
 =?us-ascii?Q?abd35RUxWospeB7tfSwY2y/x1Rm/uLNAZhQQ7WNPC/X0Rbey6/m9w/LITRGX?=
 =?us-ascii?Q?Eqnl8DW0Xj/EQFHCW8rc4MTA8cgaqnlhxtBtuzeILfYYxeb/rRgGcco3FKEL?=
 =?us-ascii?Q?5PL+kWy0JZW0aCaeOFvmoFPVLGv8SIE8Cgv5H3O2iFoRELo0UO7vfA8iu0Qd?=
 =?us-ascii?Q?KKzwnQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV0PR21MB6596.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f87d146-3444-4daf-7377-08deb4fb97a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 16:36:20.6997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4/j5xfHouZ3FL6xPcUD1b/9eF9gWyu55EF6Lb3rAgTUjSOC3Jw2KDrLBgmxWjlv29cBL5Z9X1kdSA24lQWMobPxSFwElQ5Zqtc4jc6Dsyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR21MB5884
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20923-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shirazsaleem@microsoft.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,LV0PR21MB6596.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: B8A835710AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Subject: [EXTERNAL] Re: [PATCH net v3] net/mana: Fix auxiliary device dou=
ble-
> delete race
>=20
> This is an AI-generated review of your patch. The human sending this emai=
l has
> considered the AI review valid, or at least plausible.
> ---
> net/mana: Fix auxiliary device double-delete race
>=20
> This commit modifies remove_adev() to use xchg() to atomically claim the
> auxiliary device pointer. This change is intended to prevent a double-fre=
e race
> between the PCI eject path and the service reset workqueue.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index a654b3699c4c5..dd4f4215ab434 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -3465,14 +3465,19 @@ static void adev_release(struct device *dev)
> >
> >  static void remove_adev(struct gdma_dev *gd)  {
> > -	struct auxiliary_device *adev =3D gd->adev;
> > -	int id =3D adev->id;
> > +	struct auxiliary_device *adev;
> > +	int id;
> > +
> > +	adev =3D xchg(&gd->adev, NULL);
> > +	if (!adev)
> > +		return;
>=20
> Does this xchg() operation act as an ad-hoc synchronization gate rather t=
han
> properly synchronizing the concurrent teardown paths?
>=20
> While using xchg() ensures the adev pointer itself is only freed once, th=
e rest of
> the teardown sequence appears to remain unprotected. If the PCI remove pa=
th
> and the service reset workqueue run concurrently, one thread might succes=
sfully
> claim and process the adev, causing the other thread to return early from
> remove_adev().
>=20
> However, the thread returning early will then continue its execution into=
 the rest
> of mana_remove() or mana_rdma_remove(). This could allow the first thread=
 to
> proceed and free critical structures:
>=20
> mana_remove() {
>     ...
>     remove_adev(gd);
>     ...
>     free_netdev(ndev);
>     ...
>     kfree(ac);
> }
>=20
> while the second thread concurrently iterates and accesses those same
> structures.
>=20
> Could this concurrent execution lead to a use-after-free on ndev or ac?
> Should the teardown sequence be synchronized using a proper lock, such as=
 the
> device lock, or by synchronously canceling the service work in the remove=
 path,
> instead of relying on an atomic operation?
>=20
> [ ... ]
> --
> pw-bot: cr

Agree with this feedback.

We need proper serialization between the teardown paths in the service work=
er and PCI eject worker, as there is other shared driver state at risk (gd-=
>driver_data (ac), ac->eqs, hwc->caller_ctx).

Dipayaan is working on properly synchronizing these paths, which should res=
olve this double device-delete bug as well. Konstantin, let's drop this pat=
ch in favor of that.

Shiraz

