Return-Path: <linux-rdma+bounces-18034-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGvGK8QAsmkvHwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18034-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 00:54:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C0F26B7AA
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 00:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D8D930500FB
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 23:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAE0399000;
	Wed, 11 Mar 2026 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jd0WRJSt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023090.outbound.protection.outlook.com [40.93.196.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0002E388E4C;
	Wed, 11 Mar 2026 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773273281; cv=fail; b=FqVpVaqPRm99GD83gZV5KC09QH2/Lc+/jYTGUyCPhicX/9Qml5E8RY6knx1Gkk7gj489SUluDCDPezsWOU3WuwOJJ7eFytWbQM/y06T4yU+3ntE+5LLsAIo9zSBrrUFsV/PgrHefxp//RgYgIuOmNKObT0+uH5EJ5lcMx0vg6LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773273281; c=relaxed/simple;
	bh=Joh4h1GDsN0dCZHZuo5GoA0t1oXp4DL3KF8q+ugYkLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qBMe6UAtgsbriHN1m/NJlmnLw8rLPd3pV0JigUFZoykxTBathhhVGqIjAheX+Ic77z1eCJ6YDZFoXy4Gfr0FJ3iKczbUqBXMD5Vjb7Rh0CN59LrtBfrCS3sW6cHep4q+NAwQcfPuwuDrVlgei2KvTMIAe1+uoHCT+B6b8D0XYno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jd0WRJSt; arc=fail smtp.client-ip=40.93.196.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfNdJ3+L6rNLnjiBhfR/6COSJuReroEDSU9IKycpvL2edul/FuTQ8/lnI94OJsyrdPh2/yNjAl89j5Rwn4h8hXbwf5WlsX3CVx4kDGxGJyv3iqlxe4TEJSIQtOsjKELV/eAMxpT5Z1aumVHWs4tdo6JB5XFqfHTq3wTgqKb7cG41i5aZ5stdop1hPNO9s1Gr4runib42kDrM0Q4fSHgKC57ydBSxAIx1LE6iGJv4zyyPshYElAMDYtG/WcXqA3veF/jL3MM5gUXB4bIay5H1rY7+DZtAY9jpj1o1He8q8w0HZCWHkyn8ffPeTycvaKBtgtfRR6274LpZDIa4uQGY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbvdUsD101TmfZ2O9LgbbFr41SkTh5tP8rSmVV/uLjU=;
 b=Src2EFyrPGn84jZhAIlsRClZCHCkkPQjH4hEjz+6m9aURKXBLgS4oamZNgKhF/QQY3H80KBT0YmM3X/wLy1fkyaOLvXsUBBaOyZvkYtYTA5wZoj1g3gA1dKVqorVQryl3GS03bUyWSDfKXN/r19i3ZTjOU8oV+cRdavGgXWqV2dxCz6S3PDNHZiG2K866GKBvQ2wAPrh4/KfWtm9J4F9JDz1DhlYqewijQvx8Sh48QL0v21Z6HVhawkneQGkXQt2Qh1s+FgvaQB0M1R+lRr2XYV2nvytBO2O/fUm/1uZv7Uui8oQPSrSNhwQj1jWPgleXKJcoI9VQa5oYrsRaey/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbvdUsD101TmfZ2O9LgbbFr41SkTh5tP8rSmVV/uLjU=;
 b=jd0WRJSteBWJhLPbxUBfhpD8NGMsXBPPzC+fr0PBhHbN0XpYBFgIEcdNAGvLbPL+FFyBqB3Vxo4gWvgBJepNMVG/2+hW0ftXGDysrQj3Xq6pCfvCYrYVdt4mTNubvoTSyuixBUniQxr8T/kGJQYckdEFVUe0TXi1txttpwVT518=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5699.namprd21.prod.outlook.com (2603:10b6:806:493::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 23:54:25 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9723.004; Wed, 11 Mar 2026
 23:54:40 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: memory windows
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: memory windows
Thread-Index: AQHcrVgZ+HECMa8qF0a53+MlthcSmrWqCMcA
Date: Wed, 11 Mar 2026 23:54:40 +0000
Message-ID:
 <SA1PR21MB6683E87970548B3DEA225225CE47A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260306105758.508579-1-kotaranov@linux.microsoft.com>
In-Reply-To: <20260306105758.508579-1-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=70055629-99cf-4e26-9ea9-cb815316d98c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-11T23:49:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5699:EE_
x-ms-office365-filtering-correlation-id: 29e95a14-da34-42b9-306f-08de7fc98f60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003|7053199007;
x-microsoft-antispam-message-info:
 wCzBP0FHix0MrzeQDxNsVPUfR97IAHJi1sOvElsNEqFaKlG9HUENjwL++w++mt9gvYP6RUuCSaCxofzY5i7cluj3eeo5QweIT2y0Dq4sxI5SwqExJxynK5ETNy3Mt1IKtdubx4KUEVeIsnpXg6ccd6EOVrU7iYB6mkwBZnsG5QxzsAi2ktpj8gsWnwOnKLXEHWGRxHEj9Csz5H/Vp8HgZnx6oevrken5rOQuM8ZOV/LlUSy8w/OkgYkJ/gXJw8rMBnotomd5mjxMG8Wib40/EsprUgKDVj7n5YyfxuIm16NpM8rWV7SlAH3pj3KEFk1gqLLRVXsaSD9nnrMQFWTXNMSlUyt1TsB5VKvXNPQ3fFjHGK63UVwZRlycL8e79Q+IswhV/bsTy/2Bqf9aZd1I3QPs14Knj+F9KnUOHx/kmdUwtRQIIQD27aywI+0UC4NfrOlGrklCHT30WA9p7vkPEnMD04HAlMBYAjaIuyHYss0c8p52MgGH6xnwiPZUJiAtoTzU6JnLQw0Knprf3J92wQXQwwAoOZOOXPIx3cNavXcWVKnlKnmUWkZrG+25t75bmVbIn1VCnjKCYQU5epUZpIV6MDEtLXWGV71HtJYlDafEYR6pmta1icyQWg8puKh3MDl3VMIkLDqUH1oBcUhNwC4z6TZ1EQMTs7WFhzKPdl6tYOgdeYuFVTz+8G2QF9Sr2wySqu2OzueUVjwFzJdBHg5GvYj4Uo6D35/HYLiUwPGlrqFY8QvW8g9WrXKbf5jkMZl0xMxQBCdLJnzg5pFoNnjZaqsLKSKMCzFeHRQAEWQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MFrVyXkLRu8DNDcPZyU8owpTa77fK1nfh4eH8LnsXEtWov9MU/OuslfEFs7z?=
 =?us-ascii?Q?z0ljsApVYZqM5a7h6PxeqO+dd7CUp6eYLoSnpjGXcMqhf80nXyuPNSTBzeyB?=
 =?us-ascii?Q?i0TNyta+U2sT/jSvABAPNHtVSLSAGwh9ruA8LvBiuJtoRwqQT/bbds4YE3bb?=
 =?us-ascii?Q?JcwC9EGqz/1b5BmYLQEgMYmvxdhM8IgJDLFz1T9bIZUAkjjGjRUretj8Bd1Z?=
 =?us-ascii?Q?fbH1PpOGMIpMVOOZG1vxHSwJkwFQIT/4LuHgs3DEHlny5NwQqikkRFx++Son?=
 =?us-ascii?Q?5+u5c4EgyKsLqlXaiNn9aEsO5x5jtPgsp7moNUYg5DDUJPhye39msrM7kO0C?=
 =?us-ascii?Q?79S3HOg0VDgpziC4ZOPZEvmZb7JuaL5Ivo6QvtaCFC1eL54g+VIl8/hIKKI6?=
 =?us-ascii?Q?2ymkYVUU6i9bK4pwYrXbuP2tTOD7xKhoj2oFINSheXxWncG9/yjyxci5Y13O?=
 =?us-ascii?Q?L0rZ01645+TBCz0XOmSaWCQvUNGlQGSRCI18hqccCKkMKy59GMVlUh0s02Lr?=
 =?us-ascii?Q?pi7Td8MGGL/9GvlqtfA+IDpHjH64W9fkXzvkEjYw8Sl176+/ruU1fHdy+otY?=
 =?us-ascii?Q?Vgr8GF746ljfhtZW/tMAdH4EYohVqF8LdBKARO7HOjXP7IJXU+jRqWvUGOep?=
 =?us-ascii?Q?1GYy/BGOKqecbpX+Bd28hyGWclSp/ZuwM9VWyrT2kbnwjZ5iQjpXV2QE8BfY?=
 =?us-ascii?Q?2mcHJhztbdOIGPKyMMu35Z8EWebjtog73jK+TSUWIk2P6Z8KdNbLRkAHHlDp?=
 =?us-ascii?Q?3xfdhfehcOi3rcnamg5uMbTTPKYhbDigzzRxLcNDCUN77fQxBAOW4D9JoQMD?=
 =?us-ascii?Q?F/sdpcA34jMeeK539z2gOsFaRAvcnfWuDAqdzorraR7XljF1gVllpXy09LwJ?=
 =?us-ascii?Q?aiZzfXGUZeEr7L7vAnlXIVHxmT9bD+yLtNT4zKcl31dlyfCUPEYbkSd4m445?=
 =?us-ascii?Q?AM8UU1vbL3x+ILrsbLC6xu52eKIp37CzWcvksMk/0eerm2wXozZ3Y6KcEN46?=
 =?us-ascii?Q?Hzl0A7u4RK/khr3gS7VDgaa6DcvFQ1pNfgBh+68QBSpxAOhnaHnvpkQSZw8t?=
 =?us-ascii?Q?lhzzXMQXwQcFSxVNVfx5UBErnB0XNw2sal0aVWZE4iTLFUIDUVJPEWNRzGRM?=
 =?us-ascii?Q?hyeyUtorQg5lVNLYZfUeA78U3D0q3fC7nfM2ebBgkP5RnIak9Way6TLOKiL6?=
 =?us-ascii?Q?RywpvcDtEzwGaFF+wN5+nQVEary2wnPWBQ5Drkqg/N5tHtpUr8vm1QS58GxA?=
 =?us-ascii?Q?C97HcC3pNuk63SBSALUJu6/5BjVNOlU+9zKit6i/yVQz3VFYc9yM92rytSfa?=
 =?us-ascii?Q?ajfV0C243gKlBBdKfa1eQw4UdyVlibcthaoo9TZR4VmEb3wBPbUBtV2pFoBG?=
 =?us-ascii?Q?+uVQWBleqi/088JidM8pVT1a7hU98lSb19k6XNbQurJBwL37XWMQsgCWzJKr?=
 =?us-ascii?Q?xmr7A1M4ZcoEVtljMJitQz3c0mIk1LgZdL47//sI8pgXQ2LDHPzAk0G+DTL6?=
 =?us-ascii?Q?QFpKFjbLCVanmLskvY3YMWaVFxHHKLp2IvZEYoJcGEWj25C+UATuB7ps/hqn?=
 =?us-ascii?Q?0uz7ABivr24WVM+3+itamdN3Zs5l7AGb3f7T/xDMcQZsryS1OFWLjbKX9Uju?=
 =?us-ascii?Q?33GiWt9dN547QfNsOQvGm9AYozhg5y8VPDva38JsLTb05HF2DeZOPA1mhpQd?=
 =?us-ascii?Q?PnGzkOeRJ5cQkk9b+qytSU5q5A0GnVYjKvYb0gc6hLCKVpMn?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e95a14-da34-42b9-306f-08de7fc98f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 23:54:40.3713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zdrn3KtYt2lO0J1WTBpgvQZQglMjdmSybJ68EuA7Vw2GGelCr5HzgwIWN4GCGDivNhKVUZM6+DPLQ+y9KUOnRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5699
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18034-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:email]
X-Rspamd-Queue-Id: 05C0F26B7AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Konstantin Taranov <kotaranov@linux.microsoft.com>
> Sent: Friday, March 6, 2026 2:58 AM
> To: Konstantin Taranov <kotaranov@microsoft.com>; Shiraz Saleem
> <shirazsaleem@microsoft.com>; Long Li <longli@microsoft.com>; jgg@ziepe.c=
a;
> leon@kernel.org
> Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: memory windows
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Implement .alloc_mw() and .dealloc_mw() for mana device.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
> As I see that Jason's rdma_uapi is not in the next yet. I will make a pat=
ch adding
> his helpers (e.g., ib_is_udata_in_empty() for mw) with all other api call=
s.
>  drivers/infiniband/hw/mana/device.c  |  3 ++
> drivers/infiniband/hw/mana/mana_ib.h |  8 ++++
>  drivers/infiniband/hw/mana/mr.c      | 57 +++++++++++++++++++++++++++-
>  include/net/mana/gdma.h              |  5 +++
>  4 files changed, 72 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index ccc2279ca..9811570ab 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -17,6 +17,7 @@ static const struct ib_device_ops mana_ib_dev_ops =3D {
>  	.uverbs_abi_ver =3D MANA_IB_UVERBS_ABI_VERSION,
>=20
>  	.add_gid =3D mana_ib_gd_add_gid,
> +	.alloc_mw =3D mana_ib_alloc_mw,
>  	.alloc_pd =3D mana_ib_alloc_pd,
>  	.alloc_ucontext =3D mana_ib_alloc_ucontext,
>  	.create_ah =3D mana_ib_create_ah,
> @@ -24,6 +25,7 @@ static const struct ib_device_ops mana_ib_dev_ops =3D {
>  	.create_qp =3D mana_ib_create_qp,
>  	.create_rwq_ind_table =3D mana_ib_create_rwq_ind_table,
>  	.create_wq =3D mana_ib_create_wq,
> +	.dealloc_mw =3D mana_ib_dealloc_mw,
>  	.dealloc_pd =3D mana_ib_dealloc_pd,
>  	.dealloc_ucontext =3D mana_ib_dealloc_ucontext,
>  	.del_gid =3D mana_ib_gd_del_gid,
> @@ -53,6 +55,7 @@ static const struct ib_device_ops mana_ib_dev_ops =3D {
>=20
>  	INIT_RDMA_OBJ_SIZE(ib_ah, mana_ib_ah, ibah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, mana_ib_cq, ibcq),
> +	INIT_RDMA_OBJ_SIZE(ib_mw, mana_ib_mw, ibmw),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, mana_ib_pd, ibpd),
>  	INIT_RDMA_OBJ_SIZE(ib_qp, mana_ib_qp, ibqp),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, mana_ib_ucontext, ibucontext), diff -
> -git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index a7c8c0fd7..c9c94e86a 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -125,6 +125,11 @@ struct mana_ib_ah {
>  	dma_addr_t dma_handle;
>  };
>=20
> +struct mana_ib_mw {
> +	struct ib_mw ibmw;
> +	mana_handle_t mw_handle;
> +};
> +
>  struct mana_ib_mr {
>  	struct ib_mr ibmr;
>  	struct ib_umem *umem;
> @@ -736,6 +741,9 @@ void mana_drain_gsi_sqs(struct mana_ib_dev *mdev);
> int mana_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc=
);  int
> mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
>=20
> +int mana_ib_alloc_mw(struct ib_mw *mw, struct ib_udata *udata); int
> +mana_ib_dealloc_mw(struct ib_mw *mw);
> +
>  struct ib_mr *mana_ib_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start, =
u64
> length,
>  					 u64 iova, int fd, int mr_access_flags,
>  					 struct ib_dmah *dmah,
> diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana=
/mr.c
> index 9613b225d..2a8b35751 100644
> --- a/drivers/infiniband/hw/mana/mr.c
> +++ b/drivers/infiniband/hw/mana/mr.c
> @@ -6,7 +6,7 @@
>  #include "mana_ib.h"
>=20
>  #define VALID_MR_FLAGS (IB_ACCESS_LOCAL_WRITE |
> IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ |\
> -			IB_ACCESS_REMOTE_ATOMIC | IB_ZERO_BASED)
> +			IB_ACCESS_REMOTE_ATOMIC | IB_ACCESS_MW_BIND
> | IB_ZERO_BASED)
>=20
>  #define VALID_DMA_MR_FLAGS (IB_ACCESS_LOCAL_WRITE)
>=20
> @@ -27,6 +27,9 @@ mana_ib_verbs_to_gdma_access_flags(int access_flags)
>  	if (access_flags & IB_ACCESS_REMOTE_ATOMIC)
>  		flags |=3D GDMA_ACCESS_FLAG_REMOTE_ATOMIC;
>=20
> +	if (access_flags & IB_ACCESS_MW_BIND)
> +		flags |=3D GDMA_ACCESS_FLAG_BIND_MW;
> +
>  	return flags;
>  }
>=20
> @@ -304,6 +307,58 @@ struct ib_mr *mana_ib_get_dma_mr(struct ib_pd
> *ibpd, int access_flags)
>  	return ERR_PTR(err);
>  }
>=20
> +static int mana_ib_gd_create_mw(struct mana_ib_dev *dev, struct
> +mana_ib_pd *pd, struct ib_mw *ibmw) {
> +	struct mana_ib_mw *mw =3D container_of(ibmw, struct mana_ib_mw,
> ibmw);
> +	struct gdma_context *gc =3D mdev_to_gc(dev);
> +	struct gdma_create_mr_response resp =3D {};
> +	struct gdma_create_mr_request req =3D {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req),
> sizeof(resp));
> +	req.pd_handle =3D pd->pd_handle;
> +
> +	switch (mw->ibmw.type) {
> +	case IB_MW_TYPE_1:
> +		req.mr_type =3D GDMA_MR_TYPE_MW1;
> +		break;
> +	case IB_MW_TYPE_2:
> +		req.mr_type =3D GDMA_MR_TYPE_MW2;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp=
);
> +	if (err || resp.hdr.status) {
> +		if (!err)
> +			err =3D -EPROTO;
> +
> +		return err;
> +	}
> +
> +	mw->ibmw.rkey =3D resp.rkey;
> +	mw->mw_handle =3D resp.mr_handle;
> +
> +	return 0;
> +}
> +
> +int mana_ib_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata) {
> +	struct mana_ib_dev *mdev =3D container_of(ibmw->device, struct
> mana_ib_dev, ib_dev);
> +	struct mana_ib_pd *pd =3D container_of(ibmw->pd, struct mana_ib_pd,
> +ibpd);
> +
> +	return mana_ib_gd_create_mw(mdev, pd, ibmw); }
> +
> +int mana_ib_dealloc_mw(struct ib_mw *ibmw) {
> +	struct mana_ib_dev *dev =3D container_of(ibmw->device, struct
> mana_ib_dev, ib_dev);
> +	struct mana_ib_mw *mw =3D container_of(ibmw, struct mana_ib_mw,
> ibmw);
> +
> +	return mana_ib_gd_destroy_mr(dev, mw->mw_handle); }
> +
>  int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)  {
>  	struct mana_ib_mr *mr =3D container_of(ibmr, struct mana_ib_mr, ibmr);
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h index
> 766f4fb25..948f62bb8 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -778,6 +778,7 @@ enum gdma_mr_access_flags {
>  	GDMA_ACCESS_FLAG_REMOTE_READ =3D BIT_ULL(2),
>  	GDMA_ACCESS_FLAG_REMOTE_WRITE =3D BIT_ULL(3),
>  	GDMA_ACCESS_FLAG_REMOTE_ATOMIC =3D BIT_ULL(4),
> +	GDMA_ACCESS_FLAG_BIND_MW =3D BIT_ULL(5),
>  };
>=20
>  /* GDMA_CREATE_DMA_REGION */
> @@ -870,6 +871,10 @@ enum gdma_mr_type {
>  	GDMA_MR_TYPE_ZBVA =3D 4,
>  	/* Device address MRs */
>  	GDMA_MR_TYPE_DM =3D 5,
> +	/* Device address MRs */

It seems a copy/paste for the wrong comment

> +	GDMA_MR_TYPE_MW1 =3D 6,
> +	/* Device address MRs */
> +	GDMA_MR_TYPE_MW2 =3D 7,
>  };
>=20
>  struct gdma_create_mr_params {
> --
> 2.43.0

Also, there is a mw_count in struct mana_ib_adapter_caps, should we do sani=
ty check on it?

