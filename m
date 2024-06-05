Return-Path: <linux-rdma+bounces-2922-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3659F8FD9A5
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 00:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62344B21FBB
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 22:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7D215F3EC;
	Wed,  5 Jun 2024 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CFPDCumn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11020003.outbound.protection.outlook.com [40.93.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A8849657;
	Wed,  5 Jun 2024 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717625675; cv=fail; b=uh1l0qJOpc1Dg28PBMrtHtNNOzd9wjRnNtKb4G9Qub8XaTMBqwsth/esz645G2X5FPPLS8bhGpb8u9xM5V/y2tOBRuxgP0HTD9pGGMYZmz14D18Kc1dR39ap/65vvdgLHBNCRRKtFVl40g9y5Ix+bVBY0BQFtJlBjUikUIcPW6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717625675; c=relaxed/simple;
	bh=d2d7odKiTNK/kCMOjwD7484HZ1sSGXhF2bGClHQigC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TC3CfOAZpwacApXTWjHrHJOgLlGJgfleYSWvJ+aKiILikfSm2l+o5Mssg32OTLI9kyp9qMQXm8qfJW/YiZCzmNmxOK+KrkUhX7Ev2YE83Nbkqjazv6KLNWCMDC1VsvrYJbxgUC6rCyJEZgBFAo+F13o0ALL+YLqkBBdentjWZBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CFPDCumn; arc=fail smtp.client-ip=40.93.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtZktyVObB7tjP4vnGR0foEigEVf7Xoh+kTxUyZIzbRoX3BdjWuFvsLypCE/RWHve5lLqWdzwg677XFqD1FJT/qIACZIfwDyuCaCI6A2CH1kvDK/c1moOVBp4mP6Gm29/S+KdTgcm1jxTkFYLuVoZ07LA7hx1Gr6/WbhaKDZnI98W/CXheSwaL46r3dtdTeSpc7xJPX36s82s4F6cRuTmbzrYm11fAzL0Ybo7z7Xq/GcKegSCRluiOQHv8+Rtek867mPJArP5EqYYGuQArY2s7c5u5Cb/w8K0mmgd3ZPi1AtgxLpMDJBCoGzbXoO9yexUzR1YfG16u7umq1A5spysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2d7odKiTNK/kCMOjwD7484HZ1sSGXhF2bGClHQigC0=;
 b=FkLqoIqQAuyM1WGGexiNa2rWZ7B+oIcJK8IEyW7IHAV3sOauTxwMieVRxmMn0XC41hZvYA9EAPuPcQmHM0HuFUwkpyRWsWLE5kcP6q5K428Kf/n1SKV/aY3lhjyGkXzoZqdhn3mkYhZYsqOEGst0w0qWFiz8CIEB2a8OqNeNuDuWETHmY+dOgzBHCWDPvsHvJHBU/Ra+dsE+nJ/oQlQ6XFElLc89MjLKmtgZm3s0K2aXuXRPRd/ZLotmGB0T1NQy6b4ii1DBWY8HUXSmbnWy7aY8F8TwAbCMYBy3E4xCzlp7lprWb1PLEkjXivTxt8cExJgvo23KHPq3NJCDRynyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2d7odKiTNK/kCMOjwD7484HZ1sSGXhF2bGClHQigC0=;
 b=CFPDCumngAIOY402K8D9wp+0qMkrEXLqcGtGdwTHq+KKFfsLY3S9Fgms92jEWyxbwGznRffzbeI4LKu6kQ1tRPRqIRQD60ohczZFf+F763zCcLiZIx3CE66WdYnmKYbr7nPdBk0GbzNtgJ+ZdTJw+8i9TXYSNMwE5k+kfmOCQ2o=
Received: from PH7PR21MB3071.namprd21.prod.outlook.com (2603:10b6:510:1d0::12)
 by LV3PR21MB4119.namprd21.prod.outlook.com (2603:10b6:408:23a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.7; Wed, 5 Jun
 2024 22:14:30 +0000
Received: from PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a]) by PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a%3]) with mapi id 15.20.7677.001; Wed, 5 Jun 2024
 22:14:30 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] RDMA/mana_ib: ignore optional access flags for MRs
Thread-Topic: [PATCH v2 1/1] RDMA/mana_ib: ignore optional access flags for
 MRs
Thread-Index: AQHatyCjvLD7n88I1UuniHz014LJ9LG5u/Cw
Date: Wed, 5 Jun 2024 22:14:30 +0000
Message-ID:
 <PH7PR21MB307116D097353657259A7BB1CEF92@PH7PR21MB3071.namprd21.prod.outlook.com>
References: <1717575368-14879-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1717575368-14879-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fd62b7c4-c936-4e68-9d76-f103e3a31ac0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-05T22:09:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3071:EE_|LV3PR21MB4119:EE_
x-ms-office365-filtering-correlation-id: f11ae7a3-39fd-4acb-7ea4-08dc85acdf0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?b4+Ad/EzFbmMc/BniyAV0ueezFY4/D9C6syqw/uKXVdd/4v4+xAcS01iE6Zg?=
 =?us-ascii?Q?nceSgysiYt0/abvo8lu+APSktcFIARVl35O0evXAWNNDZrBlyymvbwoyMCXm?=
 =?us-ascii?Q?DwGVTmb8OSAIjDVBaMQ+k6Xq7RrSyR2eeoHn44hJ9pYXaYryw0d48riPaxgd?=
 =?us-ascii?Q?zVzQjkCfpMD0NOR0et9D5hkg/d1YUpnNnM7A8w8y02O0iLkVkEzmzrnUr4Mt?=
 =?us-ascii?Q?QmR30SyQPB91u4/ZJhptAn9upUDPsVbhT0/kcy3um77xqSg/uqEAgdLuowPw?=
 =?us-ascii?Q?g1iCup4qO3SsGqFnTVRa4IruYZZy7sWRMknnIB284xIRJRToVQFz15f8/UOq?=
 =?us-ascii?Q?G4jYZEzt0mnLS0xrDyC+jlvecgupvvPQANOJHF8/0uyMhyQ6q/qsq6mfWd0H?=
 =?us-ascii?Q?bs77ODRl6Iq3lhrkeTqI5hcebRkt8/a9MGkvg67SIJBlRKtn1ThdhXAqrgk0?=
 =?us-ascii?Q?LOt1+x1/zq8e0A/TutuM5mm3ttOhAS8X//I2YXktqOBskQEm/y4t0Xe2Yt1Y?=
 =?us-ascii?Q?j/X+s7soZNA9LYv4mVzKqF2iZz+GYmAt0LpWLx30f2e5zw5iQMB2PTNl489D?=
 =?us-ascii?Q?/UYNMqADvomOqJ5tO0FYwYZA4fA4HcwmmqzJYfXpPFDzbZS3Z46fLU6iP8/m?=
 =?us-ascii?Q?8bW9MZLkrU/txhEq8EjM/OKiRY27UkGmPt1VqfFpLYzABmQml9ZHUHuwCq72?=
 =?us-ascii?Q?xnhqd+nRh3EtjTCs+UTGcFAvbx80okbkTh3tpX48GCwc4lRohHlSIDvqgoTB?=
 =?us-ascii?Q?hIjesEg2mlNaSoN7f4GUTxcYnmBk4KcSR2zOOeJcBrJVwdFUYudFeBzMupN+?=
 =?us-ascii?Q?rvvApb9THbm6dvzQ+6FvSml4w/jTuOxKdK4OUNLYyO1NsEp0cg9ghxp9rWlH?=
 =?us-ascii?Q?X0ni8kdI3CdKpo2UFkAT6F0ZLJmXBW+GeNR1BtLSuucoqZWrKI1UnBdT7MVr?=
 =?us-ascii?Q?wj84CRd9Q2WsjvWFqlADmhkB+829D7BBhDfR5KIOvRGElVOU6IsKegaNs+2G?=
 =?us-ascii?Q?8l4xgRhRj8c9xJD3ibqeDSI8lS9xk8+g4AFOzDoSVM0eqHGtSGQb6x3GI3iY?=
 =?us-ascii?Q?/JC5xAh9y7rZidx79N0xioLv6dcrTO9vQpq72uIY0tl6yrbzQp9EeQTG5Ys6?=
 =?us-ascii?Q?nxSZMPQx6CQTirdL828farlkpV2YNOTQbRdaiFPgXdTZWvMLwYQh/Iy/1EUG?=
 =?us-ascii?Q?x9Vyl18OaSzzg+Sf2V1l0TFNWBUmkuzrAmsTpvzH9T8nMBN/yl+35kM+zH8i?=
 =?us-ascii?Q?3iR3NFNJX7HUDwdmSP4xhMxrtCcu6ivH7+nwWMxsbr8CMPT2Dut3Z11+ymYT?=
 =?us-ascii?Q?7SLJ7c47gUs/DSuWMXgWOwXEVgQt06L4Bx0PoF72D1tS5swCcTW3czDF64EH?=
 =?us-ascii?Q?GorLaTc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3071.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VsWifqERZljWnthTEuSMSuI97pRcC6fQYEGNrwBCiUrreeXrAV9AKc5YskQB?=
 =?us-ascii?Q?4SmFh4YcxF01rW5TB6UMGbKRVPjUQGdfFnC8fe+D5dAkx4GI9fuOobZ0XOMx?=
 =?us-ascii?Q?/oDDKDonLZ1BCACE62Da2brHQk8zYozRWx36QsN/oAm2h/a6gKxSMigOPqM8?=
 =?us-ascii?Q?tfnirAvdNvgBd2uCAzT0MCRp0at5GwdA/lEAyaAj39upGGW8Dz3jiC3YERFs?=
 =?us-ascii?Q?w1+/ZlBjHFjIlMZHrVs1dIzQo5Oa5EBblB5cqcI/LWmH73S2JWBfbVHNHzIG?=
 =?us-ascii?Q?wMSTPhZrILXxHQ1iMmRt3V7LHN7bMhleJJrpV35Iylal8AOVsBn7he3DXStz?=
 =?us-ascii?Q?urw9OY7IBt2EL0930bVbaUb426bpUr44TpUfSyuER50tfvC0KVv2etipgBSS?=
 =?us-ascii?Q?MwfK7nBjCE2Z6Pd9xkibf1eMmpG71qIJ2vkPrABXYJvAKnLpvMxTQmS5Y8bf?=
 =?us-ascii?Q?4fkd/j+lnmrf56ZX1hi+PB+7Gioe+UV/sUNb3uQMzBvBEc79ZytYFTSQEsL9?=
 =?us-ascii?Q?0fIyjIAwmaYYOq+WknVaUDJk3ou0I3RpCpudjyYjvaiM+HxdE+kr2n26/Jt/?=
 =?us-ascii?Q?HJ8K3ZyN3EJTZ3MDtY/+X8Ag0HBdHZFiyRpP7kcU0itincG1fZ4Bm81qSWCH?=
 =?us-ascii?Q?UU962pfHPRWoy65RFaalBJic3ujBqepHF+a8V7xiSc5wWrjExq/+bP1ySd4Z?=
 =?us-ascii?Q?Fj6Qmg8X56ZBjGdX+jJMNfjh0gIPEIobItQ1BeR8zy1CIS21+aXY39iBdPBO?=
 =?us-ascii?Q?uVbqxsKJgJAQRcBi1DUPZOWqJ98+qQIxgghV9cwcz9gfnWCOonaRZeYsCVRi?=
 =?us-ascii?Q?1OggpL6w3+qQFGIuWIs36ZAWuIxRiSDLEvhLRHPZal1OKMA6++059qG0dX0z?=
 =?us-ascii?Q?6jWmMmSnh+4U8n4X9ClQ/O/AcHoAflbrlsz4C9HJhF08fQ6lrgFAf7YZFN7U?=
 =?us-ascii?Q?NaWYsHJHDQ1+MOR9NffUKFyq0/RcNwcDO3xG8LHVwKiYpZXC/25QMvYNML9a?=
 =?us-ascii?Q?n8ZN08YdKCAZd4uHvRvJmz31EUv6ck4h6yOVJNzFlIQJXPM929tqI+lkN5iM?=
 =?us-ascii?Q?PzMTdUiU/s2nD0Ndou5yyl4hkVSXJq+CVF3eUKHtBbd6/BhBnigIuAjBan/Y?=
 =?us-ascii?Q?u02c/1YTihZTll999Jo3DuUqFHV0m7U/i0SZAVyJL5QKMFho6lm73Krv+j3z?=
 =?us-ascii?Q?2rJTceQebHto6GhIYS8F4Jw6an6/0vvZz6VzgiRkwTM9h7w2Ke9wDZnzrrqd?=
 =?us-ascii?Q?EldKKeMszMVBSyhu/gBTzQKy7D01ico0ewInZpUMDkmkbhd/15Koc+XHeQr4?=
 =?us-ascii?Q?YlzlrGmeEGQNrL32XM/tYRcoNuac910S59UFu0sNyM/LoPYJ12qYZzyvYfET?=
 =?us-ascii?Q?zoFDBQ4xOjrqa87im2I1syRix6serZFQgNp74QjiUVFxvjuuAIp68ttQ+J8T?=
 =?us-ascii?Q?06V8adNI+PMoON0NO4yuREv6uu1tE7/s5WNqpp69CSAvMneJ4lATIgYe80fV?=
 =?us-ascii?Q?pxQ5efo54o7ERNcurRcPLJsSRQrkKxFmViFFnugD7z00C+tJoJvbXmuzquhn?=
 =?us-ascii?Q?DVvv1G2ViaZ1HFn4jTVWR2jnAXLf+qP5JsQo2XYY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f11ae7a3-39fd-4acb-7ea4-08dc85acdf0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 22:14:30.2299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G344UVKMg08g2Okcz9OfPq+iK40AF2ZGpHTi3w5fSW3BYg+cg5OPxSwSLkoVFoWyHbxSuhjis/IINBTdcJdcUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR21MB4119

> Subject: [PATCH v2 1/1] RDMA/mana_ib: ignore optional access flags for MR=
s
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Ignore optional ib_access_flags when an MR is created.

Can you add details on why this is needed?

