Return-Path: <linux-rdma+bounces-9491-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9B6A90AE8
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 20:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DC518925F7
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 18:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2899D21ABA5;
	Wed, 16 Apr 2025 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RreElHEs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021101.outbound.protection.outlook.com [40.93.194.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A402153E0;
	Wed, 16 Apr 2025 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826967; cv=fail; b=JFiym7nS4s4kEejiIJCPA8/XCWy3X09Ynqomw3YABaXlrWQWWY0SZmT4LXYv105mPJS4ZFFLF9ppMah7sOIrIYYVB2NWqQ3zMMKWqM6ei4aY6y46gtiIUMRE0sFP8uBLNgnH/7M+rn5g91tgEgDfSFx3OaFFU44qEtXrW0Iq2Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826967; c=relaxed/simple;
	bh=JvprXk0BXzwuGOjNKsPs+uRrI5kt5XdO3qoFN1cpCPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ScXItcGJAMccyWLccRfnmYyFJ0ZQnMMnGph/u33G6p7qqrV+O06WJU8qcOaGv0sYKGkhVCMTtWKJhANHM6Th/lLXjDsY9vQpxjEWiEHtKEZFrnEoGcrRbhJb0nhWufMnbaeswB9nrR2bpVpP5wmMH9v33ZgwZzVCqtzzalBpThY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=RreElHEs; arc=fail smtp.client-ip=40.93.194.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcIzGbQx2WKt+WUQ28Hz1B1kF+OGeTgEuTn331OjyhzL02e3w5CaadwW4RiwYPpCKHXuFZsa8SYbnG5U/FozvnuVkxbLKfiOz0e2AbUEYA2cAn/9UH73IZsrhCLi+FbckvGslQ+lKUoJfStZ6HCPkTuWU6zrp3tumVCj36C+YEN26qJ04I9JMM3d24bouCtu9JaCG3mPIJrmW/Ody0GKXomlRnzT/t1t2hkT2NJY5W48Kio+bYkhOL1X88SY8hEXDM4GQ98r18LX28YFVsxqUuORv4Y701pA70ZUipZ2urUqSem5Z8JwySjjmpVrT+tRkoEkNf5d0lvJuck4IHm/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoMgX6Ds5PgLmnyxrld6Pp4mepkO3DrlV34Wz22LUow=;
 b=xf96NKrf+gZ4clxqiqjN57bz4eVFGwJhXEH5CYYjAFe/hmZY+Nfjfd0pFcWomhl/8dFkTV7sJbmSje1sDauHeEhQgVSRuRFPYGZCt3z+no4eAg9PBYW4YZAEFAAqGVdyKxtxW6770hHEo5d0Ll8GC3LmjOEuYsU7/x6vJ/qxhxYOJuHC12u9XJ/zIouqq5NMYDwI58ANw3fek4rcvv5ozb9XmSuJ//Nc+mrJo2aJHy246XqauC3uneHYftw6NZYvmXc+Xvh8gIuVAc3CgBXdSO8tn5btUHVUMJHEY6ikSI0n8RwgQrSQHfVJV3Dscb8NibRP2ljQRh05oRbZGinKQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoMgX6Ds5PgLmnyxrld6Pp4mepkO3DrlV34Wz22LUow=;
 b=RreElHEsMqR1TkCwSH64VWlnnrSSfg+1vgHgTxYXFIjXQf00PlScjxLdcq7hhZaqt+E4Kcbc+M+x1N4OHatSDpgL275ubKUHtk4zrtfSF2Lxkcj5YbYnhV9jwd2iH87Crj/QOZcD+CZ4O+v+9VdHHCFRT6NNFTMUJWcZJRZVO64=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SN3PEPF00013D7C.namprd21.prod.outlook.com (2603:10b6:82c:400:0:4:0:a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.7; Wed, 16 Apr
 2025 18:09:23 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%6]) with mapi id 15.20.8655.012; Wed, 16 Apr 2025
 18:09:23 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 2/3] RDMA/mana_ib: support of the zero based
 MRs
Thread-Topic: [PATCH rdma-next v2 2/3] RDMA/mana_ib: support of the zero based
 MRs
Thread-Index: AQHbrRuyNQ7ShGqnLk6Y3C5tFZyz9rOmmvdQ
Date: Wed, 16 Apr 2025 18:09:23 +0000
Message-ID:
 <SA6PR21MB423135C01F96E70C7357DDA7CEBD2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1744621234-26114-1-git-send-email-kotaranov@linux.microsoft.com>
 <1744621234-26114-3-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1744621234-26114-3-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bfc05aae-39bd-4d3b-88c6-4a231418ff6a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-16T18:08:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SN3PEPF00013D7C:EE_
x-ms-office365-filtering-correlation-id: eca4df69-9b08-403c-e00d-08dd7d11d14e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mhVtNYHs6Cl8Lv3OW7ViSvVrUJEOGB0CGs8MaGMypuEzCDBiy9NkKf2zZtTK?=
 =?us-ascii?Q?apCAzmhbgBXI61uh7LL57LmoDnahuCJegxEWJNsQhm6rIHZqE26xioqw+LyE?=
 =?us-ascii?Q?abK5cTQTja+eF2pXtYkIlI4jSPCT2/XuIvI6Arni++rHIRe2qMzEFDPhmVXU?=
 =?us-ascii?Q?pUWkSs3I+RWniW9jugOXXl+tlM1n6MVl2ziLjrNOd4o5OQ9K6xFpj5gav4tO?=
 =?us-ascii?Q?PmqGtDsqIjxoPQwoIWVbZLvzs1XhH/kRY1UzsEwMvN5O+5eQWt3kTRG9xC25?=
 =?us-ascii?Q?YYUBRxIUqfJTW+HVL7ZWc83/AAmhN/yYccqih5pyYJazxMcF/NW9SV1yFKlL?=
 =?us-ascii?Q?gJN13nQg7SZYqJLEKdwmM4xLHuDnEk0ysIgy4Wdo9x+9IZja9cd65yP0g0af?=
 =?us-ascii?Q?YX9qpDIjHxo1lY3AQkPKweHFLnfe1Q4tix5x1fia81w2tJM8NzApBbxupk39?=
 =?us-ascii?Q?jOuWMA7+/dZGOdpFhGz8rblCn5gaQHx+zKUsKsCVC1NC2NDGK2MLON3rr4ss?=
 =?us-ascii?Q?c4ToLaFAvOFrzkIpKXQhLTGQPJfMsGde2gAzxG7zxLrw6U5L7NxJ0K1g8uj2?=
 =?us-ascii?Q?0nv2LtSYrfZuHfvE2RqLMNFNg8Gydz7m5U7q6l2O8B9G1yYbLCvmLjATDk2f?=
 =?us-ascii?Q?I7xqRerwFeP42hsJI5FSMo6kzu5rzfAw8X4SRJ3jPMLL3uLsWihrsYxsqz24?=
 =?us-ascii?Q?jgbxOaO2Ko+iqtTgfF4Uw9EAVDD9nWM61y45FTYBfCJIILkzpwi5gBzMiPUC?=
 =?us-ascii?Q?1JoYFbIkBb4MQ3IcUZoxat8THDAvbRq0cZI4NWmiSXKc58iRzYGMvwR1AHAE?=
 =?us-ascii?Q?WGEZH/ie/R+9nqeBu2zxrIiS4Axx22mKQSH5tTK0yWgF3wT35bfdmcB7EEVv?=
 =?us-ascii?Q?j9u3cPJ9VB1DunB0xlbCl4d0HYhRyhMASboPqtzpYTl4stAFtriBUlXGXXoK?=
 =?us-ascii?Q?FQylpvFhObKVPLvtKVknHUWC+blpWFCiuYka08JSMMVZ1zeEGtoNhI6OJn8U?=
 =?us-ascii?Q?tiAD1lz2wRc/Db6k/XEpCqXUQjX2lifyPDQO2tBWmvNgH65sTRlIlZIWN/UE?=
 =?us-ascii?Q?i0AW9ZP2zyxy3prBXEB6lhLtbiANEEYbxYUvZRGMHGllNEbqyZXpT7RebtnG?=
 =?us-ascii?Q?zGfoMbeaDEnKGliV7rhvneeGbXh8h5YW+mU1TYMT4IMgrAAm0K4U/4PEGJJk?=
 =?us-ascii?Q?GGumr4FwXzjytbCf1oE+/NCAZdOcAk3mpp4t3xCz/TXyIHwocleTzQYd1bBX?=
 =?us-ascii?Q?+UOkbpkbI/Fb74PLYr1F/+KeYiD5ksbrsUNl9l3KeAhqdEs4L5a4CBN3/aya?=
 =?us-ascii?Q?uTQrS9q4SqvNKrOskX0Tl91Dd+fX/iBp6u2FXs2x5URvf81IDljE6ZDIt34V?=
 =?us-ascii?Q?OMHVvmaqxDU7zKwZXhaXZrC4fC+IxsqEE3/T8CZ6xlXedZsEN5kOwyw6mIYY?=
 =?us-ascii?Q?AaYm4JDGXij5einMp29j8tMmMEWB2pbg0HQyJxM37D4P54aOrsLEgsZyECEv?=
 =?us-ascii?Q?T8DBe0Ok1UXVj5o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O7wajTN1kee/7m04zv0IRecW0SeT8YI6QLYn/UiNoqdZT6LudWtH4SX1Suq3?=
 =?us-ascii?Q?B85OvG86HO883IAabdU3MzIn+26ybWBg/WKnGsLnKKG3TfLH2NsSw5LdAq0j?=
 =?us-ascii?Q?AopkaHkKiDVxYsYB145IiZ9HshMyh3FvXSPLSxFCA5mgEVpNk6EH9Ft86iPG?=
 =?us-ascii?Q?cNTuJwSQ7+ixJ3zfnTz1D3ln+s9tz4XqvIg5RieFkMQq43Hloc7gu0g5BNXY?=
 =?us-ascii?Q?fqrSf/KO/4rze75iwEQtbi2jCxPHvf8WobbA4twGS6GFTzja2/MkSadG+w83?=
 =?us-ascii?Q?pJ7I33vEvnSZwktgtBYQ+MX2ATP1raUltxOLQ1hEMEr6wMVR/lUdctuEMd0q?=
 =?us-ascii?Q?EBzrjdJ206ZLsqpt3H0On3F7b26ApPWGd/b/XM++jP04aLFqQalq4fbmQd23?=
 =?us-ascii?Q?mtbw9ipQORiRENHgwlvRwe/886bvLNuPzOBLuQu4Xe2jLyht90LiK1/5zZcu?=
 =?us-ascii?Q?LA1Mn7Nwutn7crcBVoVNiB6K5xc6y33v4mCYfvhBm+EKq6nnWbp5ZdU5FjW+?=
 =?us-ascii?Q?vyHYXHSgRxK+ko9IwTb+wsxrLBJF7oih0LtoTQekbm7RvY1EMo29WNgB8hK1?=
 =?us-ascii?Q?JsWzUpwE89CpycpufNEZIyxeexWDmN8ZBL6h6Ovsi1xL+WrlNlaHhNy16aPl?=
 =?us-ascii?Q?tYzDZbmfnMQeFpHZDJaYu2MetWXgDwWfKscNkCCuIp9uo6oOaDnxRa8nR5hM?=
 =?us-ascii?Q?Dzr7qcAvzriFg7LGsdbGuSsbThZpjg6IOpdsglRVMymVa4/Cjmsrl7pOfYeE?=
 =?us-ascii?Q?yHNngnzd1lFnZokOe9A96RrJ79mtYQzh5LC9UwxRcTBDLfxcdyKZy/yANgPq?=
 =?us-ascii?Q?zPIoB1cPA3nBZKrlgOqwpU5RhKDCLsdM1qEJE4k2SBhAIQ+/jId2+gwN+ppF?=
 =?us-ascii?Q?OVmKjnnUUL05NevtqHpq/12njbkDr80S5hjLIUnyYHYGG31f9beZtpxW5Kc2?=
 =?us-ascii?Q?SR896CLOQTKPwT7L0ITecCwxBi7IlRB0qwQMUzx/2kxgw2T4jRagslKbn1vE?=
 =?us-ascii?Q?Ci/C0rg/8rzwzLPplToipkm2rdZKSXUGrm16J7UXnORlp/XNJtGB70okjm3R?=
 =?us-ascii?Q?tLWkds7ExUeDObQjylUhgIYuLcgzW6JHYu+RbcR8O2v9dI3TkpWsx9/Ndwj/?=
 =?us-ascii?Q?YBazVT3gH1Sl5qQGp3FFNGzUXB8b6MV1u4lP7WWYS3N6+mgkXix1mjbnNGp8?=
 =?us-ascii?Q?tucB3cUtiYI2ahKtrrN7qzErMoQS6PmjLiA/6dtWq6uL21U5ppm8a9hjX8yS?=
 =?us-ascii?Q?/Cq1VGvD7dCfpy9VWLuZpISiaBz/CQlHzPTWMbsmB+cUrRDTWzxE45sZEuXs?=
 =?us-ascii?Q?bFvgkvzERxJ2hMxTKtSIFBvPqc9u9ZmZtGkzVbiMowKc9n/kHRO8OIBlP06p?=
 =?us-ascii?Q?TAE+3pCoZ7UmlPSJ/gvJpWnolRkoqUaeVD0VBlwF9QLR0DJuGgMkzQA7sISR?=
 =?us-ascii?Q?EjgHn1hPHleGj+jmrguFWB3DxybBzXBXq1PahY839V2ww6wPZGQjEwm72u26?=
 =?us-ascii?Q?B7P7h9U3iXsnDKTPdLxDzyqP9enm0ULjNlOsh+8HBfeEglAb0aZKDGvmX7xv?=
 =?us-ascii?Q?gK2s28Z5zbreSAmFj4aOXioePJaYo5UauXKbgJXm?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca4df69-9b08-403c-e00d-08dd7d11d14e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 18:09:23.5513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzKaYMFNAmjiudwfNcZF+SGFyOo73mtdkFEJj1DbPorUEgDA1pwRk+t0z82Oa+fDORStVqzbzVedlehVIW/jcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN3PEPF00013D7C

> Subject: [PATCH rdma-next v2 2/3] RDMA/mana_ib: support of the zero based
> MRs
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Add IB_ZERO_BASED to the valid flags and use the corresponding MR creatio=
n
> request for the zero based memory.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/mr.c | 24 +++++++++++++++++-------
>  include/net/mana/gdma.h         | 11 ++++++++++-
>  2 files changed, 27 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana=
/mr.c
> index e4a9f53..6d974d0 100644
> --- a/drivers/infiniband/hw/mana/mr.c
> +++ b/drivers/infiniband/hw/mana/mr.c
> @@ -6,7 +6,7 @@
>  #include "mana_ib.h"
>=20
>  #define VALID_MR_FLAGS (IB_ACCESS_LOCAL_WRITE |
> IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ |\
> -			IB_ACCESS_REMOTE_ATOMIC)
> +			IB_ACCESS_REMOTE_ATOMIC | IB_ZERO_BASED)
>=20
>  #define VALID_DMA_MR_FLAGS (IB_ACCESS_LOCAL_WRITE)
>=20
> @@ -51,7 +51,10 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev
> *dev, struct mana_ib_mr *mr,
>  		req.gva.virtual_address =3D mr_params->gva.virtual_address;
>  		req.gva.access_flags =3D mr_params->gva.access_flags;
>  		break;
> -
> +	case GDMA_MR_TYPE_ZBVA:
> +		req.zbva.dma_region_handle =3D mr_params-
> >zbva.dma_region_handle;
> +		req.zbva.access_flags =3D mr_params->zbva.access_flags;
> +		break;
>  	default:
>  		ibdev_dbg(&dev->ib_dev,
>  			  "invalid param (GDMA_MR_TYPE) passed, type %d\n",
> @@ -147,11 +150,18 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd
> *ibpd, u64 start, u64 length,
>  		  dma_region_handle);
>=20
>  	mr_params.pd_handle =3D pd->pd_handle;
> -	mr_params.mr_type =3D GDMA_MR_TYPE_GVA;
> -	mr_params.gva.dma_region_handle =3D dma_region_handle;
> -	mr_params.gva.virtual_address =3D iova;
> -	mr_params.gva.access_flags =3D
> -		mana_ib_verbs_to_gdma_access_flags(access_flags);
> +	if (access_flags & IB_ZERO_BASED) {
> +		mr_params.mr_type =3D GDMA_MR_TYPE_ZBVA;
> +		mr_params.zbva.dma_region_handle =3D dma_region_handle;
> +		mr_params.zbva.access_flags =3D
> +			mana_ib_verbs_to_gdma_access_flags(access_flags);
> +	} else {
> +		mr_params.mr_type =3D GDMA_MR_TYPE_GVA;
> +		mr_params.gva.dma_region_handle =3D dma_region_handle;
> +		mr_params.gva.virtual_address =3D iova;
> +		mr_params.gva.access_flags =3D
> +			mana_ib_verbs_to_gdma_access_flags(access_flags);
> +	}
>=20
>  	err =3D mana_ib_gd_create_mr(dev, mr, &mr_params);
>  	if (err)
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h index
> 50ffbc4..3db506d 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -812,6 +812,8 @@ enum gdma_mr_type {
>  	 * address that is set up in the MST
>  	 */
>  	GDMA_MR_TYPE_GVA =3D 2,
> +	/* Guest zero-based address MRs */
> +	GDMA_MR_TYPE_ZBVA =3D 4,
>  };
>=20
>  struct gdma_create_mr_params {
> @@ -823,6 +825,10 @@ struct gdma_create_mr_params {
>  			u64 virtual_address;
>  			enum gdma_mr_access_flags access_flags;
>  		} gva;
> +		struct {
> +			u64 dma_region_handle;
> +			enum gdma_mr_access_flags access_flags;
> +		} zbva;
>  	};
>  };
>=20
> @@ -838,7 +844,10 @@ struct gdma_create_mr_request {
>  			u64 virtual_address;
>  			enum gdma_mr_access_flags access_flags;
>  		} gva;
> -
> +		struct {
> +			u64 dma_region_handle;
> +			enum gdma_mr_access_flags access_flags;
> +		} zbva;
>  	};
>  	u32 reserved_2;
>  };/* HW DATA */
> --
> 2.43.0


