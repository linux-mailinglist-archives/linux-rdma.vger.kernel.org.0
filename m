Return-Path: <linux-rdma+bounces-2972-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 044E08FFA0F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 04:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6D31F249DD
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 02:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942A612B82;
	Fri,  7 Jun 2024 02:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SYu4T3Yl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020002.outbound.protection.outlook.com [52.101.193.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C48DDD9;
	Fri,  7 Jun 2024 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717728327; cv=fail; b=rlIhRjaPQag+WcNLUkGLkE9YN9rJs2MZsC7C2S+tzZYj8LSUtwyFqfbuqgNheO+dlZq/CYxC+pVg/5p1LsI4kqLyJih5cUuqmpPi8nXYJjsOmiHwNlTmLll3bo1m4slbewErMU4IdlrBYM4LJHL/VohhKzBaPfgpLCHvqoK2zDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717728327; c=relaxed/simple;
	bh=3ji9RkEY5ev1vB2a3Z3XOiGFccjBh9KjDBV07l9iyC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aAJg4H0WAnev2EcG4XsT25sK7ZdTErJrpo4tCXW9Tg9SA1ZaAoRMJfzJRqpJXcVmGDpkrdhvlMTH/qqx05sGcTdHQ0AIMlWaAEpFfQ6cjNjsBh8tK1HhWpZuFZCmxAYLaHkv0WS//W5ajtP33tMTL0x8e/JqFxeux7vlRVBLm10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SYu4T3Yl; arc=fail smtp.client-ip=52.101.193.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5o1MXr9/OEShvg31BzXEcFecmXDNWJlCaJZh7wfyiQqUEcdX50uoNKlBiLU8ipfLii50agOvoFhQSR8xD9P6avhptPgnrhUcl+Aw3xvsHAz9psvfvkTR8psYB7/kHdebGbN0nHSy9CQkwj+tKOvoGFu+XZmUnulDTgLPV5dUTUWfVXsgfGDlnstRE5e/lmWRF0zps5OwDAUV0xFcwz7FKv/H4HvM4hVZgQNTW/2drtsmkt3m1Ftp45H74U87x8oVRvOhO2nzd3vAjs1wFHY+W6veji5anUrUv19PO094cY6X/jVdxywkh/VPahed7xUHEsWgUhIrTEGneDyM9ZPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb8V+x6RWGhNugxzYz12yJj1wMoLmsVHQIoqXa/QM60=;
 b=mVTrJGQKdbDkjz6zn/V8sylZI/jXLARO9iFoyokIjvujH9LGwiFtAt3ZK+UIESygQAjFl1MmNvOWnqoizj4xJE2X3DJMgRmAo+Z/aP3VSid3+ek8VhbGLmFtWU3uz0vecEne1D24o3vQZkQcSa+DLkerNbmHLPQgacV13q2jB/Y9Zv89SamFRhZee4jihapNUUbaAl4ALSzRrM783uFIkip3r1GKc3xs7zgUK8vLKRak5GLPLXKlIb4vcSbzw5sDBcUgELzDtDbUjfIu2hVg1+NrUauV7BeyArqaVr/BNFd5pHHObzJhqtlFSYSGIdZpICyY4c05CPb4htpbx0hmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb8V+x6RWGhNugxzYz12yJj1wMoLmsVHQIoqXa/QM60=;
 b=SYu4T3YlNCTZVYaV0JpqL++igEgGu5cCJ2SqbsNzgSqyjTxlndQKamAffQalEoeWI2uq5ROQRQxDgknNYFDFJawLL/wUknph4TJKKtaGJ25aHk8P0Mi4qyEpDpKA3QIg+TH42fyvucQqKzOutkBKvewOJMwWpH3jL57qd5UwEMc=
Received: from PH7PR21MB3071.namprd21.prod.outlook.com (2603:10b6:510:1d0::12)
 by MN2PR21MB1520.namprd21.prod.outlook.com (2603:10b6:208:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.7; Fri, 7 Jun
 2024 02:45:21 +0000
Received: from PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a]) by PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a%3]) with mapi id 15.20.7677.001; Fri, 7 Jun 2024
 02:45:19 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Thread-Index: AQHatnNn3cy/Ic0fek2xJdoL70MjcrG5wS7ggACu0oCAASrhEA==
Date: Fri, 7 Jun 2024 02:45:19 +0000
Message-ID:
 <PH7PR21MB30716CC511AAC603DF1FEDE2CEFB2@PH7PR21MB3071.namprd21.prod.outlook.com>
References: <1717500963-1108-1-git-send-email-kotaranov@linux.microsoft.com>
 <PH7PR21MB307195C7DD870A5716E1CA92CEF92@PH7PR21MB3071.namprd21.prod.outlook.com>
 <PAXPR83MB0559360D3C2E3D0B02E9C059B4FA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
In-Reply-To:
 <PAXPR83MB0559360D3C2E3D0B02E9C059B4FA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7b9f9122-27a4-4ad5-b04b-3479404d893d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-05T22:23:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3071:EE_|MN2PR21MB1520:EE_
x-ms-office365-filtering-correlation-id: 825a2630-76c8-4fdd-5b60-08dc869bdedf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OcWQ8hLriAi38EO70blTcGalF1jUM5WHJzAl92/IG/y0cCCLpldgLIGn5Os4?=
 =?us-ascii?Q?PkowyqGVIzX5dWNi/RRKWfP1HNSWVaXoom4wAom42QtPEtxX7yPIkYt4Yfbe?=
 =?us-ascii?Q?4tEOuYyP51SvjIAMwk1xSfJ62EMrPZjUOy9KX5PuSik52+10Hqv4HFc/46as?=
 =?us-ascii?Q?W1mgYEW4cjhl3AVv3s2qxFREe4Hjp9fm/B31CnzGm9WPuCrZBe6tyxwhkZSK?=
 =?us-ascii?Q?xUay/dWq6334nJiGh79dJVDdzZbSmOwHvh5c9TBZzhWUJDvLwvfHUc8aLtzt?=
 =?us-ascii?Q?qiaKgCuhp+Ow+6L+wxuqTdEAkFETTjs7NtGEVF0jtFaJX/DJZg6X67z4AuaL?=
 =?us-ascii?Q?6i6b29naUygip7XSJk3N+n2QPvHeXXbFdWxXVaYUev9B2mZQ7SZHQREo1u6S?=
 =?us-ascii?Q?HWJIwRonwF6FGa0kJ5hE2dqgg9svka/l8+3c2wlw76+iedez0bnq8Ow3VO3m?=
 =?us-ascii?Q?6iMK2ctVm1+JjCE4j2bMn13qEm/DTlvVivV3u7daqW2ONtXvv2LehuYRHYOi?=
 =?us-ascii?Q?ZdjUxbAEzftcEYddXOvxADgDmI6Cqu+K0BhGyZK24sjpBUMQDhVStTAVqlRl?=
 =?us-ascii?Q?rgntSValeq3HAeSmaTlO1LwtY8JjWDSZvqqGhDh2xOy/hdotkHeD3KZvO7kj?=
 =?us-ascii?Q?rL3cLPgnZxaGpEu8Lht2U6/SF2MJvTcT81SMi8ee0IqOgn2XuQmoaFw/4HrB?=
 =?us-ascii?Q?fMZKVPepmqFK3R/FN8B3fKMVz+kQlmP99U7okPfE0993H1bc/Gx8+X/w7L27?=
 =?us-ascii?Q?NYzF5SYKMOptBnXYvsQVsrz76t3wCVFAQryqjUPwGLr6ITur/8fKXBZl+KmF?=
 =?us-ascii?Q?iflAMiZcHuNfcDvb0V/ZLoNIJ4M+yPdUye8jX84jnDyrwDyRVU1oG7s6Zzo0?=
 =?us-ascii?Q?ZexIs13cjYGyI9AxvF/PApeLTOwWFuzFHizfcLsyuC1UzZdJen3yPhbNMpPa?=
 =?us-ascii?Q?7GquGui/LezbKfhJyKt/yLCYb/X9rYoLC2Kh184/xe9xm9hcV5bP9lrxKjxv?=
 =?us-ascii?Q?8ZSRF8cmRZLfcndki6PUlxFYuunYyhJHrAD9Kcf6J0qYNXyf74tKyaEtrCxk?=
 =?us-ascii?Q?u6R/NeDqhkxxAtHhdQ2UEAelN9+Cy7W8nSdDtEhxhcOaQWZ1YWGk+t/Lua5T?=
 =?us-ascii?Q?m//Kmia7MGf+q3VJFjMvEJuSewNP+r7hNL4Ls7fuzMx2EOxQno9j56DNxAqu?=
 =?us-ascii?Q?lZGYOibWje81SPUGXWjHYc736OMI1cxBD8M1fekF4dqEJOoQPIfo1/zkMHWh?=
 =?us-ascii?Q?EtMpxL1Q20wGNwJA9IhJI4PZ2eyVg5HI800QcsbUGb6G/jYKzYitrosaBFXh?=
 =?us-ascii?Q?eUTdDrFDu8uO/lPcDkgOGsoiepBZ341gSbF6Wm3/hRZL5AY1ImuMR1DT2Te0?=
 =?us-ascii?Q?1WeQrbI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3071.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s0xJlwvmK1xmvqW78Mq0QbP8LRIKn798kd5pEzS1eDs7yjZoOSZqWoxlMb7B?=
 =?us-ascii?Q?lrYa0KVeVg3+Rm/Dzba7iwJxZSGIOHt63LqQjkZ4TB5eiXv6G7XoFO7L9Z7q?=
 =?us-ascii?Q?MiRlSl0MgJxP3O+op3ADxLZ4f5uxKQJ7sOGsH2Hf8ycHV5XaZ9bylbbe27b5?=
 =?us-ascii?Q?HT7O6APIpRZeBsjQWT6SE+IFB6PzGWf8ZwdXvHWt1wUgO6UB5CjM3qVapCkX?=
 =?us-ascii?Q?GcvJfyzZ3uorDBHzC07MBB4BTvaqOEmauwEmyA7xfATpI0MrGOogE1CsIjBG?=
 =?us-ascii?Q?AtJopK0YYxxujnPa63G9+TFvBL7zOl9Wl9+yMfwrJ1QgFZS8PYJJxJQD2VrM?=
 =?us-ascii?Q?ac3TqTXWeuusQWusq66lcBryN/UEqqsSfWfGIb2vJSBC+iAoeSw7bfQ72fuU?=
 =?us-ascii?Q?u3UGEE525XNypaUc45usmaRTE4C7AxTTdlAAGf+upm0VwoA19/VFhVnlNSog?=
 =?us-ascii?Q?zdUpWeEYSuWSUPujuVQ86+mNPgLUJy+FgasEOc+AHnQapwsxVXmG4XKznp/i?=
 =?us-ascii?Q?ekfL6T6YdM8gFFr12IliyGGmfsj8iyyQ8xAeV8mkT301VHVAhnfa6UuZNa2z?=
 =?us-ascii?Q?DHj50E+xnsHqwO36QA/BFNXv7ul1bllebylu+N6SYv8pMoQn0bqlbdVcJ+ho?=
 =?us-ascii?Q?f8NIr9fnvgVoh8JCQiJDt9/ayPC3oHi6fRUhqsOpPUtSietE45tntnBtaGwQ?=
 =?us-ascii?Q?CASwHp618kqCV6Z4tTQFLS+xmbR0iMQrR97UVTQc+j5O3qAqx30J+LG7u8UQ?=
 =?us-ascii?Q?QmcgSAgvrrSLCWO7ffWRbH12oybqXr9J0qpMtnc+HuAEgsRQngO1EMTilhS5?=
 =?us-ascii?Q?7vTzzirRChuFYaYUjd5NoTsIsHS0Jyga5bkPho2sz8pmtq2O62NfLvBoSJh2?=
 =?us-ascii?Q?gYXO9clggbR6ZeE3ZNvSJEywQRzaqvzgWHn08RTpm63WXUKl/ZskOnVYc1Qd?=
 =?us-ascii?Q?1Mf/6ByPCVrRYCrqymCDTBBTSAteE/8iSPMAR/BrRojkEOXcBVSfnkJLJiqA?=
 =?us-ascii?Q?s66lUp0Y2F2B1AFbAF0oGMIfHmkosHm+yhfAYnYcOGwcaxRJM1zn7b3ef1SE?=
 =?us-ascii?Q?ckogCSUOT41M4Y+N/rS6gGQVxg7QRjq82OXP4RmjyzIuZ88Oj+cW1U8HCQ+k?=
 =?us-ascii?Q?sHqkzdNpQxfez3NqzWHFEABVxS0zoWH6jycGorZfJqTAzCdtVyGyx0TV/5Ta?=
 =?us-ascii?Q?80YMYe/58ECxW0gBnsEcV2SyhtFBz22C+Kc+1wTO41Lxvm/GuQcKZ3XfDsq/?=
 =?us-ascii?Q?DusJBZDOKZMf60whWuxiDGhMU8GoiZHaPI20DDkQKWTeCbovay8/9fRi3EE1?=
 =?us-ascii?Q?AUlnniD5KtF88nvKl5SIl3OzgH8I481l9iphbBtUyAEGcB2TE3Zm3XM5tCHV?=
 =?us-ascii?Q?Fpc60+lnhHZWecU4miPRdC+9troD22/43l2K+f39z47Dy5oPCKKnpA3e6plU?=
 =?us-ascii?Q?oVbdp/nd8IE01K9L/JAvteTAI0wXnFQ9RO+vXIEXmiPwIJubT/C0w9ZCvza2?=
 =?us-ascii?Q?pDqnCcV546CvFoAjXkKwIU47q5nECq2S3EAqVRQIv/zvXM5JRGnbKDmpXZBg?=
 =?us-ascii?Q?W4B5IsLrqR6DpnWoMrf/PiNLQF/5Tf6bT/xJgUUk?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3071.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825a2630-76c8-4fdd-5b60-08dc869bdedf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 02:45:19.6592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juNtBGZ2WB6aJv7jEcUg6ZBDrYevark3hQWYdmIOVjsopPB6G0g59qnnU2lIA20C/v84M+sHcMdn7Ws0gFp5PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1520

> > Strange logic. Why not do:
> > if (!refcount_dec_and_test(&qp->refcount))
> > 	wait_for_completion(&qp->free);
> >
>=20
> It might work, but the logic will be even stranger and it will prevent so=
me
> debugging.
> With the proposed change, qp->free may not be completed even though the
> counter is 0.

Why this is a problem? mana_ib_destroy_rc_qp() is the only one waiting on i=
t?

> As a result, the change makes an incorrect state to be an expected state,=
 thereby
> making bugs with that side effect undetectable.
> E.g., we have a bug "use after free" and then we try to trace whether qp =
was in
> use.

I don't get it. Can you explain why?

> Plus, it is a good practice deinit everything that was inited. With the p=
roposed
> change it is violated.

You shouldn't call wait_for_completion if it's not needed. This is not a "d=
einit".

