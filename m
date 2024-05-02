Return-Path: <linux-rdma+bounces-2213-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CF58B9F35
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 19:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BE91C21E8B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E4616D327;
	Thu,  2 May 2024 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Y4W5bhh/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11024023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AEA1E89C;
	Thu,  2 May 2024 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669541; cv=fail; b=Al5kdJEkHnA4kJDoCCXLCZsDWmeCLdYQ6Ye5cZqnYIVef8XLZ/Y85NBT861FW83WRVyOiLD7PPxn6TeXhrBT4H0hdpW/QP56TY8dYOkmdskCvV/DG8LBB1aFKSmgHyojvdOgkkVEy6KG9srERTD2/8/CG/7aJuBD7DqQgXRTEO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669541; c=relaxed/simple;
	bh=nvt6hslJVaU8PwrBoNOYRkH8NkE7dNifLSGX4lSsidw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EwbNX4iz3xl/hOtzs0jVDbsFc/tDQ0bdhe2xoi+kWKkJB+Ma8dipbFV5Mhu2EJvhptT+fc7h4aL3fkOQmXb/aXGv3u2HdnRX8y7Jt6LpS7EL8JyH8hOx1wplpF6g/Zq3hiDRrwRiIS0GVYauiephdxTULSP3iTyFWzK0+OwTJUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Y4W5bhh/; arc=fail smtp.client-ip=52.101.61.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cdo4Pcjlr/B4o7T/YMW2kTck8lw7s2hPWMW8I3smCOKPaGVpQg90J2oq+nyAtLxgMC8M47GzBOJLup1tLgdlUCDUcFqJ/BzAqH+kkP20dCopEcEe8aAgsVvt+aUc7XRIFciWGHEBLFdGOZPeWjAg1JbjUL7SCBfyGdKjaK7QgtlKKivC9bLUL1RjsaIYyRcmyTI5Mb4Nb8Hb0EZXAVRAdpdrSq1Y9MqmxCs+UDivdjbt/YwZ0fgBKeZBGP2kMfYngEGKLDZlqClE/et/izYoSyBPW4m3rOfe6kM4+Ce4/XDW4+iVw2X1arWPseM0JTIK3tyrgtyXv4ovKA5HdZxS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvt6hslJVaU8PwrBoNOYRkH8NkE7dNifLSGX4lSsidw=;
 b=H6NWjksm5zw1zVEgLTMkkKfjc+o2yKfmQhF8PsSKCnJBLHO7n55UhpoZmJ8EPmdo/4K6ZXPEXZLRuPX8saA99HWeiv6nnokdeQi3pXSyEiZvddcgHj1OSjot0xj2nzI3/n/V0PDbtZL8Y2/1um5k3aa13BP6VArlhfJTKEP83LL5C+Hk7Dpwg+QRr5G1bXebBFVpIFPwHC7SaMd9YlkPe4IUv/zbTXvDgguWiOwgRq5OeV/4XWIot4k8sNbdSmsDhFprZflHADtcs0rmhvqHjZDbcXg/UtPzrI6PIEKhyZu4vQ2FMFRZxDXsS0bsBC+c5vkb7ChXLFimNj4YgP06lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvt6hslJVaU8PwrBoNOYRkH8NkE7dNifLSGX4lSsidw=;
 b=Y4W5bhh/vlhz5PfBO1uoJjK/wvpe4Fsp2T7XuT6qSY1J1SrtBEQmNvc19x6f/IRctf4vlOBbwXJQki38yiMC7k3V1WyGFpnznjjGOTCbP6TxYYloLWiNB70hfFaJbLreIQk3WIrxRvy7uBrh2UcrufsfbWpPvyJ8bGSYdAf6Iw0=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by BY1PR21MB4346.namprd21.prod.outlook.com (2603:10b6:a03:5bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 17:05:37 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb%4]) with mapi id 15.20.7544.019; Thu, 2 May 2024
 17:05:37 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 5/5] RDMA/mana_ib: implement uapi for
 creation of rnic cq
Thread-Topic: [PATCH rdma-next v2 5/5] RDMA/mana_ib: implement uapi for
 creation of rnic cq
Thread-Index: AQHal9t008XqsRzWOUiSmiSGonpoubF/kHbggALf4QCAAcWZoA==
Date: Thu, 2 May 2024 17:05:37 +0000
Message-ID:
 <SJ1PR21MB34579654E1F6E3AA2B553CFECE182@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1714137160-5222-1-git-send-email-kotaranov@linux.microsoft.com>
 <1714137160-5222-6-git-send-email-kotaranov@linux.microsoft.com>
 <SJ1PR21MB3457722A994F429FDE0C46FACE1B2@SJ1PR21MB3457.namprd21.prod.outlook.com>
 <PAXPR83MB05575B086E1580AFC3693267B4192@PAXPR83MB0557.EURPRD83.prod.outlook.com>
In-Reply-To:
 <PAXPR83MB05575B086E1580AFC3693267B4192@PAXPR83MB0557.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fad8713b-ecb4-44a8-9989-0b4ccf5bc06f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-29T18:07:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|BY1PR21MB4346:EE_
x-ms-office365-filtering-correlation-id: 56f4fd3d-fed8-4550-208f-08dc6aca166c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sHdGH4FKAw8DCS5mw3l6lbcB76gLM8AuGPRu7OmuMMdsmnXJHEYIb7Btx2Di?=
 =?us-ascii?Q?wxp+aziN2oFwPrr2n56R41wII1920eMXtojJ9OvyYhTjT5y1vQ9++O+bSAG+?=
 =?us-ascii?Q?kXqG+u6qqDVyZzcorIPiijKqEofbLI9n/A9hgTnTxgdgwrlm+r9bxkZeoDng?=
 =?us-ascii?Q?PoiAfePXkItocU/JqsPyWJGOIJhjd9pSRCoWpiUCa/moeDeNVZPBl88isEHp?=
 =?us-ascii?Q?YcqjYEqxtQ2NmZyx9yOH7ayUgay6H+QnUfIaYYbDC0pdkT2k3vwz27ZPA8Pl?=
 =?us-ascii?Q?huEY3JU/OtUD7ggJCuZGvy6VjcmD7IU+f/71l7ryEIKFpk0NvH5c0mRnFdQo?=
 =?us-ascii?Q?xXC4qUpYfKUSQZ00ls55VP61C/99HI2888b/gu7TnIBy9Lgm0tsxFKUHd5wi?=
 =?us-ascii?Q?d99SJA7Z8e/UiKc0UXThUCW3qCUlxuCHhWMXZfsMLvrDTZU7ZEXqhcsMmHIy?=
 =?us-ascii?Q?mW9TYw4cl6wsw9mg4mOOoYbL1CVwPSOZEuoUF2R7dFdkkzYK8eFHK5d3tmg/?=
 =?us-ascii?Q?Rll3oqny+rNQrEgse/Gz1kXV2tKtqaL6oizVhxGCAaZ7woxbO4TLjYA47ND+?=
 =?us-ascii?Q?z8qdRVKL8gYaC8EuaekBedaYoML9h5U0pnz3FhXZMdCZEYfNeDM24KIELaCc?=
 =?us-ascii?Q?R+qdb9ihdkJY9usXjHgJdP1WaHJgu5xfzhJkAtljGcjnMM1KdkjUX6N+1fs6?=
 =?us-ascii?Q?rIl8Upp3Xwg+PN0aRaDqx2BsY8KgNBTIpNLy3+zRbjD89oflJCQD427Qk1Y5?=
 =?us-ascii?Q?PHJJfkGlbFQ18dWPMwZRKvLeoKmgDv1VJLbd1kTQqeCm3oftUih51TbIiP9l?=
 =?us-ascii?Q?rMrTAOUyZ9RUe9XKwV4jOtcgSK26DCw0On50XNV8pQX3zfYWg85FxHC2eBce?=
 =?us-ascii?Q?z7K7t5L2ETDzldPu/huxCV3QlTYcjKpLj4bY/cwk+cFiuzz20bd2+uQRlsK7?=
 =?us-ascii?Q?nc+G13Iq+e3y0mEKOcK0loTGBQOP3D2D9qw0xx4IV+r2ejKmFLgPz3OKJeYq?=
 =?us-ascii?Q?gMgGw45oubWKYHqJHEjWBUozx7ane4MZTsc7BuzDOnf8Lk17c6NWEOj41blg?=
 =?us-ascii?Q?yDnSXgUb6CaTjs5ng4KmB6Mix6cFSDoAPU4npVfjyKAGMHXGG2LXQq3z3HZw?=
 =?us-ascii?Q?+tR+2XvYtkht3tRKTPqCMDW7xNI+rhrMLtkRHbUf4ZsDMrobS6IES++EMIoG?=
 =?us-ascii?Q?feXBqGHSGehq6TtSV8RZNVcjSCJmrGjtT2QNVa9M/+qd/ZN4nMnqQHOb/okH?=
 =?us-ascii?Q?jUQpuOEQjaDeTiac01Ee5Vin672OBnXTPnkHPml7Sg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O87TAKeAI4DqrD2KlN/Ixi298DRJAHskuTG4ENU3tKL+beKk8FsqDdi6jRUT?=
 =?us-ascii?Q?VhiwVL3rPo+t6U3MfXKJFrry7jzfiWpaIIKgdkrpsepp3123ru0NJ4uL6jyV?=
 =?us-ascii?Q?9BzA+bDHLoZBFvM7325X/M8ni/QAYDYuON/rtchM6PoZVlFSnccmA87uBfYY?=
 =?us-ascii?Q?ro+1Ahq4WDfwora8jPJ53w+tITQunMGtKQ7Ej0c1sQGetqnm36a88AiUsIwk?=
 =?us-ascii?Q?Bprg6QTciMv2Bx7bpEk9WHQkG4qGhGTPaplCU65kTBft+UciCj5ha/u9Zizd?=
 =?us-ascii?Q?LQwSEaZsBhsQ+ve55szlKs6i6GEt8UrfrM0X9uW7Qs0TyMPzH/c3Zpgr/Iot?=
 =?us-ascii?Q?STf0HrCN/iCxfFYRL/ej0xKqGAOeAlW9+efeD88iFS52RJRB0IHLtwMZnt0U?=
 =?us-ascii?Q?rWfKJAXVl8gBHU5Zx7uFVeyZJ4/W7X3VefeHjL/j9QSFcxSTR09DNT/DFH53?=
 =?us-ascii?Q?DBsVnSkHd13+9gtdErS7eKmpgn1ehwVgV3bkRirDFWltQTFCES2GqJyXKWmZ?=
 =?us-ascii?Q?Q18S1ScwOz6QsOZGiWezqnL9wTjUsDd5Xv+h+h/L2Q2CDmRgY6LLH5OweYht?=
 =?us-ascii?Q?2j5KyuuePFkViOMs7isI6o37fiWOmaZqnE8s+IZMLEEU3SEgU6eQzvG0oh+6?=
 =?us-ascii?Q?ALSKiyLbZLSUsSHL+FJC/EY2QpGItBTWg1VzJpDM8ek43I7zKblEmwpWhoOM?=
 =?us-ascii?Q?5XwLWd6f4zgbdlvYeLSssjULg+fIoQiTbEL5nG1hYy8ZxlkuYtHYG3fkTBxz?=
 =?us-ascii?Q?tTfU2DGvUDm8tlKDLswI+KpwHXLHO9MJEKfk2pgeiWEanmhQA/mz1a0nrumL?=
 =?us-ascii?Q?nV1/2cE5x6ng8Vi8SsGAivoMR/OWX9PC9EzzmNbd1HY4Do7giN9Lb5JrrhUx?=
 =?us-ascii?Q?6vXxIfq59FrwmBQR/gRNGSZrT5otCwH9+XsqHM/HskIcI9RXK+KDzFhM15TR?=
 =?us-ascii?Q?Fdrvxx2HW84Hkk4hxr5Draj5Nz2iYTYWoTGPOVRaMaU9286nKaJsZMToul2T?=
 =?us-ascii?Q?BrVdHsr16Nv5Eela+lEYCmfpjSw76PBIAvoXuiEV/jyQtNPXrG7TXJQjvsn1?=
 =?us-ascii?Q?YGr4Zo/0dbZyLNth2RMYZJHhaQb53K+JT4Ofq8hPWWmXFrMhWob4qqOqBds9?=
 =?us-ascii?Q?Rpg3Wm6PLfP9FuI6wduY8FKoYk6+4tHcjfO1CzLhUu+oV84fdjjgmh9qVd2d?=
 =?us-ascii?Q?+iVfPptZxnZI9Fp6Pq33OjYPDlgJi4T8Jw7KJhHdSjApQ/fLJfWeXhITWAEf?=
 =?us-ascii?Q?WTZo5SspMRApojLulMTBrMUUguRCRFbixXLrv+YEUea7qyEGe6CoZK9wz9px?=
 =?us-ascii?Q?eW8wW5tamV5247ZQYuGlsBKtZB2cNDOilvLLkTgIHMg4RC3DzfQWchXqvWsf?=
 =?us-ascii?Q?ozCMkhXCFW3baknUevfJV3EEVPSTpGCdASB0dIVcP5cveJBJWZSCED+267qo?=
 =?us-ascii?Q?Hd3gk6Bbdpi3NxlC7+Vt9sXBsZ+ReqQOvmX4VNxu0QuAxBZIYipChSRlmH2L?=
 =?us-ascii?Q?/Uuuk8lSxDX7j02sONku9I1cB8YEJnpj4V35K4SDVr9IZHamO3UA23rw/GJz?=
 =?us-ascii?Q?H4E25XWAoD90FbcAhnGDW4cV1Xtl6C308/zzQl2X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f4fd3d-fed8-4550-208f-08dc6aca166c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 17:05:37.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gjUxXnZnhJYoxFmC8nnNdKyvwIuJJftcQ6IXdNA/UImyhXN8tZM4hoGQc/1tY5SEvSoShnT4qmXTOwuf4mdL9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB4346

> Here is the PR to rdma-core with the changes:
> https://github.co/
> m%2Flinux-rdma%2Frdma-
> core%2Fpull%2F1455&data=3D05%7C02%7Clongli%40microsoft.com%7C15661647
> 58b54b0d382508dc69e72a37%7C72f988bf86f141af91ab2d7cd011db47%7C1%7
> C0%7C638501688834172236%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C
> &sdata=3DlZPsMJvU%2BeoVBajN5HZBNZaADKnwOfROv5OqXL52%2FF4%3D&reser
> ved=3D0
> The code was tested in 4 variations (old + new kernels against old + new =
rdma-
> cores) to confirm compatibility.
>
> Konstantin

There are minor issues with rdma-core change. This kernel patch looks good =
to me.

I have added "Reviewed-by" on this patch.

Long

