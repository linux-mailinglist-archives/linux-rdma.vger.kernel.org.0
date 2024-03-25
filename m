Return-Path: <linux-rdma+bounces-1546-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2932B88B2BE
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 22:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23386B21C9C
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 19:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC91C1B977;
	Mon, 25 Mar 2024 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LYwArgXt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11021007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2799412B77;
	Mon, 25 Mar 2024 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395407; cv=fail; b=gHeJK24RTiGHhED4nRBvvJrgMBjNJQn0Oi355YKekdxHpBSa9Ze8vNM8kTCQnW7+prGusmLKkLhnY5BrxoYCv2xIe7z9Y6s2rTTfWBcfHck8QpJdBNclQxzlPXwAEpDJ9v4tkb87ZHUN9nb41g4TJTTVYGQKbroTUTo6Hup11aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395407; c=relaxed/simple;
	bh=IDX7y5ltMJNF3VMHRA75IGDCc9Z0R0sbogPMr5lDdmE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XFI9EUnHCdhS99fUw6EKfCmEiN10iUeb+Iy0mv7WjkQ0FTdHyR8Pe9l28ThbwgWTY275lenqIfEgb45mIaWbdgPgmNarItJDWqJaIlDhRIddb801SuKypoT0WrW9e0xT7ooWfDw6zl0O33zddGJgUUWzptjj8aQGT8ZMgF1U5kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=LYwArgXt; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIMGFoadm9mjNjFbniyTIyJgIWEz8ktNty/SvBeS0e35YehnLFYDwr4GlFpCaYmyxYG/uyXdK7wlptcJKlMg63UDNOxvnBOC6msdkBIeA42p86t0Z27kPGztW2uaZTQzwqBcfoD0c6x5VV6clGJbxprcTJc4GdPbH2ZlhOd4j67DTxFbVeBRYs4KZwUoNJda/cZviPPUoSQeOWOSPGYN/bgg3+yZ0qzs0nRYIy/JDvqX82THgu/oyfwDDYoyPuN0RvnglwOLqOOMFLG5cP8TpPQetRvRTv6jdse9GC/dpt1Keov4ThRGUCFvXCnH3C6h3GtbmMYLSNq2VRM332Sbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDX7y5ltMJNF3VMHRA75IGDCc9Z0R0sbogPMr5lDdmE=;
 b=B9kRgzmhkRbYFU1pXx9xlucUoDSwJYBKYwUog+ITUvKpDrw0jfWs4RNIhg7YaWRpzIqrpnBCGlbq2TbgdSwED5hixUJxofNn4vbK5UjnQPUbo1ppeCzxKEoOzjnI9G/2qIso/HP0J0lCppl3a2ZnwBJh88pVkV2hxaeEUgiyKFPfXnalknHKKVkL2m1sIx9c56xhQfTWa+4V2et0GhN9wjkhYwuXnDQ54/TZcgSNXQIGIuHTdQgjrKfP63PxGYN5twv41rPyQXrtM/TAZ7OH7bT8Z2dskwYMN9k7WYaI7oAoxkvdPbOmg19pqAWV5Wnv6T4Ptf7p7dVqWR+R51NsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDX7y5ltMJNF3VMHRA75IGDCc9Z0R0sbogPMr5lDdmE=;
 b=LYwArgXtWbFxXGKkiF3yex+nlgB16Nd+95VWQ2soeHCZUY2fskT+BKK4pJr4xA4Wo+zCvqphd+H0vilpCHaumbpkEcN/4/HOO10NedL5+HFPuRsNtO3ACuDGQD5G0H3KEPDFXRK/1rcq15BGu69uwDJOVl/aHKl1pJYO9bBW4ng=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by BYAPR21MB1319.namprd21.prod.outlook.com (2603:10b6:a03:115::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.20; Mon, 25 Mar
 2024 19:36:43 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7430.017; Mon, 25 Mar 2024
 19:36:43 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 2/4] RDMA/mana_ib: Use struct mana_ib_queue
 for CQs
Thread-Topic: [PATCH rdma-next v2 2/4] RDMA/mana_ib: Use struct mana_ib_queue
 for CQs
Thread-Index: AQHaeh7zb32b4iJKUE2j9JNirdOBsLFI4zag
Date: Mon, 25 Mar 2024 19:36:42 +0000
Message-ID:
 <SJ1PR21MB34579225BF6ADC5ECC03175DCE362@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1710867613-4798-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710867613-4798-3-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1710867613-4798-3-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=234c7bca-3f87-4e73-8cd2-4917623835e4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-25T19:36:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|BYAPR21MB1319:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YgGOe6GefYEP1Mr3X8qOMiIP7Ndrz2LWsPoLAnqpKJijS4/V1W68QCYpoLEQzjlE2u4enc0LaJkPRkqjQoDTp1xNuIzRT+LkWAQD8LonEhqk64teiSKcoqaNnoeuCQ0YCphwU4eKV4mCLgICs2lNtsslUVSGBwpJjjEzLVr39zbMSq4MuNruRBHfrw+PHabrTDtTUP8GxaoYpk1HpYOh3NcZqRfXkazMOO08ZQqC21rdG66TsBcXZSFl/meH1la38vyJewo+DLm1QgTWV8efXNarLtil6KYA1EdFqEsKLFXUE6NEtrDo3TismfDHd2Zt52VBVNrJ/7CehVKTtEm/EE9kW6BBSbCcpiL0x0pjSklhTOAQGHGyjDxxqkH9a3GY6X4MVwPQuL1GgxBzPVc/3Gabcx9MtsOkzt31AjiJblosCjQt25QLMMs1+xZybC5AjcZMTdAO23cOgh6fOMLOx6rKuLAEGORCNJMvkRqDqBu2CkyAGOclIwsNOr4H3n9sthbzwMiWLErX0V+kv8C8PazZsGcmGvAfaelEUurwMBV0SSHEKGZLcHY4c9Y6QPm8JtE1J2/g1eHPbBc9m3c1ogSSub19wAyfQg5QkVfIYPWhmwC1mzYPJFBCJ+CdE2lopFofri9DdF8DakSDpGWOLHwAx301aHTXqFf/936r6Ks=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GJe1UzaW81GqJeLetkIoI3KE2Gq2C3pxpcolwePz1B4+0UvLDKS9+0l6NhDV?=
 =?us-ascii?Q?XeprbiCG40c6e/fsrbV2QMLa9jgzppvtByS/lfoCpQwFXjQ1xeHgfI14/zwm?=
 =?us-ascii?Q?T2TPpf5vGoT2kP7N5/XmXZ70gd8Z23B7v/WL49k+415ziPRwtqXSB13FK0dU?=
 =?us-ascii?Q?ZYsHH5tVuXptVTgPAnJ7V3KBvQ9/2HHm5RkVQRvED5kfV6jNXCho1TVdTKkC?=
 =?us-ascii?Q?hwmUkGYUfiqe083btR+XCnJgcm0FBTamv9CFpyEf55n5rk1rnmAbCXn/hB24?=
 =?us-ascii?Q?ObyMTpSiEUqO6u61eoN9SjqZyK+Cb4PkbYRn24xh+iIFAnK9p4ch4T+Fucx+?=
 =?us-ascii?Q?GvDx7f0HaMv+lVBlrJGUmvZKF4RMcZNhI/eYuuoax1UeWrWGX5aKHTMTW0u1?=
 =?us-ascii?Q?IEgLtWVc6nDIf7+a3k3WbTA7GU4ZcuOjvF0VvVkPiOcY1+haf9atQ1+1EnYd?=
 =?us-ascii?Q?AUap0uQJ+cQWBeDpJmX9JaFXDMAAy3vPzhdn8QKydcbWiuuX1OSBnrLwN5g0?=
 =?us-ascii?Q?TffWB+TSn3MNUAu2WGHPUo5qWjE76SuCdpFJ7ftrHRmG0sDDqFhPpGjtw+Zx?=
 =?us-ascii?Q?dyXjV9Wi5duDSLrhE5piMvrFkalU/sHM9QjcoQCpFqOwsIo6K5sPpOZmMJaE?=
 =?us-ascii?Q?iyS3SYwxYIVyyFj/fUS6DFNDk02QcmSPC++2LUQwTZT2KjNmaR0LPGMlP5ck?=
 =?us-ascii?Q?6OlEb8quThBzFnzoqLwG2F+8oasEe/rWaQ7bN7K8i7WdWGY1VwS/c2j8Q6Gx?=
 =?us-ascii?Q?pLuA3797GsxNb2tIaPWZrnbTeyR3nvpodM6XCfapOmJhgyAqH/07pm6h/rnN?=
 =?us-ascii?Q?AHA9PpuDXPv9PctSN8Nf+gjaLMN5FyvY3BvU/fQjS+q1DnT0Ggwq9i4wtueY?=
 =?us-ascii?Q?dJw6QQO9ajeCo7A4bKdPa5or32kE8CP4E5hQIs9PYeV0O+zhwAavE20JxjSU?=
 =?us-ascii?Q?2Q0iebUec/1N1jPHVs8/6juLUZq9BjWMv5w7r6zIdSoNz7z8rUaofKOM+iuP?=
 =?us-ascii?Q?p8LPPi/ykyrNwjY+H9yUGsoIks82UZ5XJSF8vK44AZDYj2vGD2Oko6E50RLY?=
 =?us-ascii?Q?o/8JBKpAkdLltkmSFfB95i0587DAX2Zsbo7tKEZyr2AmQLYwBP8/Jpdf/OZs?=
 =?us-ascii?Q?SSR6ZKXmOI+2qKt5VfjfxvSlCUeF7ixnjNdSVSWubf5wPO03m+oH7TOE1ZgK?=
 =?us-ascii?Q?mwk7Eq7UBWs6QdrwfHRy6DUggmvdYQ1N6eZth4Tp3OrSNsEqTjht+Gwu2J2g?=
 =?us-ascii?Q?yXZmFf9AHT1VmA20gxB0D3NH3cKt1mpWF2gmNEtPtkHOMamvHoAn/EKcCJ7P?=
 =?us-ascii?Q?0YuBPF8+oV+hifgirhYIGV2cvlJlKuy+iU96UUX/BO2BN6iDCUaVVldrNlK/?=
 =?us-ascii?Q?2D6BxuYC1+7kOlnGnTEcFSBGTIOT+YvQrXRGfiKKKWw+G9Fdj2/TK6FJAHW7?=
 =?us-ascii?Q?R6vbnmzMkjpIfjQdd9382jiC4tzzgBTGfSHLZvKz9BkIqAXdTNGFp6/bclRT?=
 =?us-ascii?Q?N12kOVHFLFLIDpiGvdkw7sEgRjlKbaOLzuV5SyDBVgBJAn4r4zOa1sTvpHD/?=
 =?us-ascii?Q?Da5iZo/rOTF/b5sQlnBEamN/tar1fvA3T9A8kKYT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3497a4-c5b0-41e7-0788-08dc4d02e666
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 19:36:42.9990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J1trepGyx0ZJ9W37Fbr8MsC67Qi31lfRxkC8VTtgeVtcBmAfKyUadQX+Cl9MGieVas/HeJCc3tVfj7ykynMgSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1319

> Subject: [PATCH rdma-next v2 2/4] RDMA/mana_ib: Use struct mana_ib_queue
> for CQs
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Use struct mana_ib_queue and its helpers for CQs
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>


