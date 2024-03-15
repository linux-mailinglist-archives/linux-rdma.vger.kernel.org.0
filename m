Return-Path: <linux-rdma+bounces-1454-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F29287D23E
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 18:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628B51C21B9A
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368E74E1D1;
	Fri, 15 Mar 2024 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="T+Wcziiq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11022010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769A5FDD4;
	Fri, 15 Mar 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521664; cv=fail; b=MF9R3phhGQxuQcmXXmW8QrX95OQsivDGq8vlwFhlhZRk0soAuMJBpGHRCvRflatBFX4QPPIvzLEq77Misp14skCQC3IGundtVy4joWPdWeZlUkjnpjZ/xsSFDEDzBNCUu4KAo9272TM0Wqd0H5air/X5nmfsCJyIRMv6teh3ZCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521664; c=relaxed/simple;
	bh=t5/axPlJRGpvyD+eioWZz1365xw0Jl5lk1DZ9K7xd0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LSMziI2LpRtx4CiJ0FXMzr1g5tSuYeDLD9PaIR5iwsEtP8RIRHioSqJhMl82JMk5aFUtytT0MNlj+4czALUMpJjtfhYMAUgZXphfzag1xYXkG9CiD52Hubd/8Dm+SFfiWt5RtLQC83gcu9UIxLfgSB/dEkeJooHjVSGiPeaBqJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=T+Wcziiq; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTiPlmvYSx526A1fstw6TIY0jflCr4hkYpyflm49Klq+aW+rSAxPbXxssYKyB9f5ud3IwM1Hc6h9+DjlGQtVUhK4A3n+AIUwbR4kaxBD7JEJbeyFZjkTyIfZ5mO2fzONFDQ6hagbYzp1FtByXkROUW1ZibwsIhNpG+kiMg3XuuK5HdXYCfYFZyvlD0iwVjzwRbTYfwXLe1P81N7g4uv0Z+6SW9u1icLHV/bHrtc1hFZ8gc7ehWJTp10VFGW+qi8k55hNs0H2q1tq0AZ+wgjqQTY0sBpOucKcubQ4KypgAqQNNpowonbkjAtsRRmVybX5i/Lin4KdU3tZ5cVxj/121Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5/axPlJRGpvyD+eioWZz1365xw0Jl5lk1DZ9K7xd0o=;
 b=Tnr9lt5dL6OEhfNGgo2RAK+tZSLpB7DiQgoLDGAYqShVcTORo5PqYkai6Zfbl0qx3Kw4aQvFiOUXCziAdFTRGltFUlRy1I1JkkIK73uEdri2XpsqaUb9QX3inxyxF2YJI/XX9JU5OpgjM4O4WbLpzA7HCitn27sICUlQ+m/HVDOBqUj5q7d6OFUWacm6Vg7/Yz/5kbm5ThciUrH5tokS9DCwZDTgOBGOyqqr4I2nBTW+5CrPm6Ig8MG28sf9TJLYeWSQhlEiBGHtr+AAHOY2GpMC9ZrZZdNBDFweLvVyTYKC5QgfbsGww241Z7agMqJ367cWKyssQVb2epjtRhklHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5/axPlJRGpvyD+eioWZz1365xw0Jl5lk1DZ9K7xd0o=;
 b=T+WcziiqZXrZLKDe6HD3cCjhDw+Nr6prGqjanePEa8b+G2k/kLxHkPO+HCiqyW6/x+5Ce4KNIjnpxJZ+Mh7BgbmEgTJG/czZ8qkmD6tyMCDxIfAY7BDn3XHlhyMuqj3N38Hkobcvzr0Wp38bxv8UrnKkOQ7wu30BCZd770O6uAo=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by DM4PR21MB3178.namprd21.prod.outlook.com (2603:10b6:8:66::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.9; Fri, 15 Mar 2024 16:54:18 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7409.007; Fri, 15 Mar 2024
 16:54:18 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 2/4] RDMA:mana_ib: Use struct mana_ib_queue for
 CQs
Thread-Topic: [PATCH rdma-next 2/4] RDMA:mana_ib: Use struct mana_ib_queue for
 CQs
Thread-Index: AQHadUneZF8gcqrEJUCYhlOs4qgrNLE5CC0w
Date: Fri, 15 Mar 2024 16:54:18 +0000
Message-ID:
 <SJ1PR21MB3457F2E3512D82E3B8F9489ACE282@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1710336299-27344-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710336299-27344-3-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1710336299-27344-3-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=85361dbf-8bac-406c-8081-0a9614185459;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-15T16:53:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|DM4PR21MB3178:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bKk3vf04V50SslSstKuSK3HiFnt34c49aQ16vFidio4E7AfJHtYA2H+o6Zt4TQXvpKlukKu5q2aSsTLzkeHL+7iO0xgZi1gEq54W0FpWgan/dM+AXQqC3qhokG1mFk8wJ3lIlyU+kSCo4Yd1Lm6zuKrHiAzZp5WpZSY5ZtAWzpKJc2+xkQaD5I0hR9t8t1KgeDaVQNudEvvEOkUNgeajzNPKqX2/HHLYOKYwAEZSh6PJL/2OLTnsGAQZzur53a15YHeLInGIlcycFyk8oZR0/MlM2a/YcqE9qDFFm1KsAkYZ4dhveeWJsC+ogSqOuMi7pZb+GKEfeE8yFCL2VMbHIPW7R/JYcMoLlTE9SoU8ZE6Yb17QrA1UHJf0X+565fI00JtArHdOyOEbjeSuMxsDn8CHmWsS8V2mwl5SEug/tGoMbKle5kgWKJUGeuOmJezZlK85V7CQpc1BIQq/g6Q7agaT2JEfHNAydp9Y5Ixg/53D0ACRveIu1V+fxxuOM1vHrPXXiB0tfOfFgEE7zriX5lz3RDv2SCSN80/L/zPS7oIFRdNBhYWWIplXucYifCBawEwG/wQuAyvxGPxa9MRmU/kGLLXdViYFv43aH4MCjJk6oyNU+pPMqKEg7gsCGv08ARB/eDOe+hHHCtCwaUqlssyX5+29pzO2jw3gcJwLFOU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t3ygJVjWWA+X2noxSi1esJ6oPzQk9akcXVy/BkNc5WiFlGPfQWLzy0ivTS2X?=
 =?us-ascii?Q?GWG65gdr5a6TnS3qIhO8N+Of9AApBoYLU5568lEskpg7F8PRW+LtnHmIrgmP?=
 =?us-ascii?Q?e22eqNGj/zCPDvJqMyQWcNn8t1FQAlpK/t0fvYbe+I0/UKsSNIX8izB67zZg?=
 =?us-ascii?Q?KoWdQCLfE5IBWhpnuFeP3HLhOCh6gnISMVms3stVC6qa2kisUu/y2LWiCSRs?=
 =?us-ascii?Q?sahEH81ixM+/8s4B0siaXk8E463ISQSUb84/ZMu7DB4y3JPNaKSohVQUupHj?=
 =?us-ascii?Q?wmZYI810gdIecbDpB00VnnR20jHu+f+pTzrWn7qRT3f4t0/orB/wRZA7Qx9z?=
 =?us-ascii?Q?dqtH3VTrhFcDSLszv+emR+pRk61H23hEYOdIagtU4Nm2A7wTRQaM3hxEnk2X?=
 =?us-ascii?Q?N9+PFJC+gXNWGYkpCb7FoDKM8FEsqVlB7hmu8eirKQ1M5OT//iNThuRvoyNt?=
 =?us-ascii?Q?aoN+A5HSX2f22vuXP783pb0idcuXEkgSQyHJD5dmrYP2/ZEM9m5eeFDMNuWS?=
 =?us-ascii?Q?cLIJ8uaFwNDL9GqGqX+cL4BdHh09lz6GI0Ts273PgJ3KEyDfslO+dpi1Plpr?=
 =?us-ascii?Q?IT/HnLvbOtLTGUvzUrQD2+F4vBtnZr3tmIRHfthdCF23bisewYgMuu/8qwlN?=
 =?us-ascii?Q?Y3rrwQdTqZO/HYYjfgCfXdvabtyv2KcOnpdhlb7yIfsFUNqpj4C0fELl+9zO?=
 =?us-ascii?Q?wcNSttHthPkGg4habGxpv7h8FIHzLP9XHk3AYO4TRIavG4F585SCPFKm5JiV?=
 =?us-ascii?Q?xPxI2VMvDM4gnDmiLLq5CRqt8vO2chWk+MGUWguRRox2hGp+IMguDRvp9sRm?=
 =?us-ascii?Q?O5xt1bjkLifSjr4IL6z2eE3D+bdgF6UpqX3cqh+bKHpBQ9T8QMmXauS06f+B?=
 =?us-ascii?Q?G1KA8h1bGAAQ/Y0sLJvjLgkHusyXsGV8c+iWvD2leuojMNBXtmj/LdWXlO0N?=
 =?us-ascii?Q?c9FH/NjbCLwceOMTYRI0Bvsbv2eyUzOSMcqE8MZADTNxMg2zEB91cTSdp2SU?=
 =?us-ascii?Q?pWHQ1C0KCDSJ1b55EjmYGK8R6fin+/vLJRhrxUedXxQgwmPS+uY+WHwrjfNf?=
 =?us-ascii?Q?4sIO954rw0OHNnTckLEiuWJp8vTHmrWNetz6awBWJ6sok+yxW8w1P718aJBC?=
 =?us-ascii?Q?JprrzRwZmPH34ThrVmdAnBCWmbU/hHa667HCmD3JLX+RgMeLqVV1wDugYZfN?=
 =?us-ascii?Q?j9Oz7MX3xIKlZHGiupCxYzm9qz8EG7CDBro/mxKxr8oC/msrktLLdBibMyNI?=
 =?us-ascii?Q?3Uu04MdEcuCIR/WbWVlEjfkBnEbuzHvktbSQ5E9LPIv0l7gqZXKFFTWLC51X?=
 =?us-ascii?Q?vDtnK5JEc0JDKOZScNY2Jmf6fXBDb6P24S3Zko1YiVc4MAuqBdaEyiLGU2KT?=
 =?us-ascii?Q?CjOXvi5Kl59jj7XM62jxLdUiRjTX6xzuz+rqKWZ3k8JLI2Qxt1pwocl0TFkY?=
 =?us-ascii?Q?snntQotdbGzZh8AprjnSEVkrZ4aVCLhy6/0tYQsg4gG162mSVTPbG8OuA6BW?=
 =?us-ascii?Q?UpTTtQSnMkxTiua3EI9Pd8MJP5XjuyNm+pPTto3kiA4wJB/UbTXChKHCzMDG?=
 =?us-ascii?Q?pPPcHO4gMzEU+ZLZdu7Nzpt9sqXUiyForsTfrn5m?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f933e46c-1e28-491a-0ed7-08dc45108e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 16:54:18.7369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zp3hYjuPSgZ1rN8Xxg9tNHJ16ndk37AtY9NvU+FNwqYdt/nQRsQ1XjYvL0RB14wNrPIVEV6DtGndA1dyEmqd+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3178



> -----Original Message-----
> From: Konstantin Taranov <kotaranov@linux.microsoft.com>
> Sent: Wednesday, March 13, 2024 6:25 AM
> To: Konstantin Taranov <kotaranov@microsoft.com>;
> sharmaajay@microsoft.com; Long Li <longli@microsoft.com>; jgg@ziepe.ca;
> leon@kernel.org
> Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH rdma-next 2/4] RDMA:mana_ib: Use struct mana_ib_queue for
> CQs
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Use struct mana_ib_queue and its helpers for CQs
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>


