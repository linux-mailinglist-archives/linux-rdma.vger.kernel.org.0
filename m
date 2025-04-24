Return-Path: <linux-rdma+bounces-9770-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDA0A9A76D
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 11:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77E97A3E34
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 09:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E944B214801;
	Thu, 24 Apr 2025 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="obZGDj0f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33691EFF88;
	Thu, 24 Apr 2025 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485703; cv=fail; b=kYiGcFsp5M4vpKA2r0/BDhTkkGsZdZ9lsLkK8Ym7BQAJC3dikSDYSckrcatk4jaZ5XLGyvjx4cEAsaZkxgHFWWmGRNvgAE6sz13y3iPhH4+/PyRAUbXSe+klBDfdgFOgeXr4qr3LbbbNmeKwx3xM4yk02kcFsCuoWSDf1vzTgKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485703; c=relaxed/simple;
	bh=gTeQ6N2Jkzf7VHw+E8OBcAGhpXPvZ9I//SfWu+GHVHM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H0I8J2sZSxHv/ricZ0dd7XbsmXSrZ1B2pyXYMXZAHEGU6UAQEG/URIYYLoDw8Fpo7oS+3ZmmJ1fwdEByDTxsFKemGmraqK5xSRDrRWtfgXQ2MM2BZC+8Wi0B0sD3atF61nQ8OkuURav6lq0A+Tt9JyGhJT9GuZa5aeuM+2ETrlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=obZGDj0f; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftOR+e0e2C3Rj/r7ye2OJknp0lfI40hLH9AW425x0WXD5M18AeeBgrAh9gkXsRaY7xEiE6ji2B+K/mhHbmtsgfG9E6B9KzxzNlMkf4whZ6Fx7mgyDrc05GPvgf2EXTNY70jh+kvcrdHT36Tkk21j2TaemlMVTGiRTsx/f2zUe1iPl4F5o7er++N41zFXR2WwBLqTqdLzbsDbAJf7IRX7CW2qEntpYgwDihgnUA/0aTcNze/2+vRa5ZS/XPQdxCf/n4P5JZPgZ4JMH6HlUJ/xeHDFc7pAP7WSyyPU4+k5IBhkR7WmU3MwwiLLD2Vv289Y/FYmkiEAy3yx+383W+ICsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUiBCDAgUz6QNh87h+zH34jzdOJ8gklEQVP5Vxgxs88=;
 b=hcPjaeFVD2y2Ig6iiBVij/6Rm8k4aG4I4+duGcQt5tZAJq7V1d1pFdVv9KPTZSgVb91XqzP3b1p3QnT3N3DSI4RSGxc3t3B/WyKGsen18fneFqWU1Ke+mvhmZh9uFEO3wMC4VjmHkdcNOBa7F63oxx8GBG5PSwkYZ8br/lV7DFSfL6xZqJ4+NiN7xJ1+HlNDhk4+4cswWxYMFRSlpykiFVfmZQ7snAEpgHmWk59/utA8fS26r8E/0pweol3t3v/taVCuwVotDaMVkmAu/mRoCf7EpskAuSSv+9vBAdKnRVg8xAV4QpwQ5q3hr7ZwnALrQFM9ZAqiyrrBcCf5xWjlzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUiBCDAgUz6QNh87h+zH34jzdOJ8gklEQVP5Vxgxs88=;
 b=obZGDj0f+afA6l/r0xPNqLbsat3V8FTN200pIiUKu3w3gC89dlnxjDUinw0NCE1p5cg8uezBFdC0PHK84pJ5lQnqjkh1Iv3vA+Q7VOKT01oxRTTeCWcD9/xvl3XWoT267IN0X9nWF+rioPs6aqFAH3snd4pMImHS8bIXY4c0LorwfSO2lkI4GDUzp3ENNiFMjeXtyiyb67jnmvPkJwe9r5S7vwJFRldmAXQ0Jk64ygYgfuUerCmATR4tb6A4RtYxyR5buLmQXe4x3OBgbK06oEjL5sz3tVDwopfKaXDq1l/JcchMmm2BXJXA0ccV0dsG/kBakpPv5sDhsgtfUwbvPg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Thu, 24 Apr
 2025 09:08:17 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 09:08:17 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, "Serge E. Hallyn"
	<serge@hallyn.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAZ+iMAgACAGGCAACPuAIAAA3qQgABFyACAAUU9AIAAB8qAgAAxbYCAAAUbgIABS0ZQgAAqToCAABIpe4AAAEUAgAAOzYCAAQq5sA==
Date: Thu, 24 Apr 2025 09:08:17 +0000
Message-ID:
 <CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <CY8PR12MB71955204622F18B2C3437BCBDCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421172236.GA583385@mail.hallyn.com>
 <20250422124640.GI823903@nvidia.com>
 <20250422131433.GA588503@mail.hallyn.com>
 <20250422161127.GO823903@nvidia.com>
 <20250422162943.GA589534@mail.hallyn.com>
 <CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423144649.GA1743270@nvidia.com>
 <87msc6khn7.fsf@email.froward.int.ebiederm.org>
 <CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423164545.GM1648741@nvidia.com>
In-Reply-To: <20250423164545.GM1648741@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DM4PR12MB5819:EE_
x-ms-office365-filtering-correlation-id: f0739175-a78a-4312-c403-08dd830f8d12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+le99wWCXpq1VBGKMhWXeE0fGGJ+zbDV3USzg/0HewqLa23GupFWf9RVj6yY?=
 =?us-ascii?Q?TeVTxVcnZGFpa7YYnyfiere7Og2LPLjD0Pkujl2+rnlTriUvaViS0jd4gXoP?=
 =?us-ascii?Q?iQ7XQQi23oO/dlNXeydX4AJaC52X2pYPc1AS51yqgnG6ziC7XAXUegh0QQOQ?=
 =?us-ascii?Q?XbPF2SoZxhUOHqb/JynZggb9MuoemsDzhXQi7GHMuNLJdiBY+jjvpqYMTHTV?=
 =?us-ascii?Q?VW/z9/ei23O8RW4LxGWzwXpssULzrVNzPbHHAbyabDQ4cEjndyabpxC+t3u+?=
 =?us-ascii?Q?r6kwyXC58sRqGWUZWSA3jeTlNoQHRcoPvMmWN1JBOBH7k1zwM15yl6O/C1mx?=
 =?us-ascii?Q?EjAXmH/6nOMEFKiEU2hMkSnd6da1AJmwnG0zMHz1Ky6RoK9KhWsfwmQdMNqs?=
 =?us-ascii?Q?R4dtVF0yM5jvnw5u+Y3kwXcRpnYxy24EkJgPM0++5fovDVvT738BtNLY15Pz?=
 =?us-ascii?Q?99pVFAdsI5WgZ5ZpG/4KQz9WT3/KbqOutXf76PK9O2h00+s7dO/pzeQ8g773?=
 =?us-ascii?Q?WRlPOUMNb0IyljLxSglLxfscokVAU+HlJvlJUE/kIx46U0Pk90K4ZKBYFkm+?=
 =?us-ascii?Q?2jGUc+EuQHZ0JFrUzIC5NZuNArp3+y0xB316BoP3eIvgxX5vg3sbXzpKdFWI?=
 =?us-ascii?Q?vMHM0PjrPjV5k6oZ5Mv5QrnvzW9L3aEGt2jEpe9eTafyQFfZI7mWpwOFKKtn?=
 =?us-ascii?Q?dp4zWwhrtBo9Pmkr7BqWH0WnD2R9R3ghfrRvw0+E+CNhC0d+0QuTyRjfju8n?=
 =?us-ascii?Q?GzIzkxfKAOIr6Sj/nW3Rg9nna8fbPczyiUI6cx6YtoXF+pbYo/srMiOBV6W+?=
 =?us-ascii?Q?6dfcjDCr++8ODtZZtInAN3ziYEjrvVIKhKPnS42iGaTK3GkxBVgowM9N10uj?=
 =?us-ascii?Q?FEJLaJKTOXCEPXb2fRIO8wJfU6pz/dmcvf1wm8GolvpgzoxJ3FtH0B6MxEi8?=
 =?us-ascii?Q?arVFZqz9HndF49DnD/FY45m8CeTibhcKl5gBp8mDfvWGr/xRKZ3qiuDB2WM9?=
 =?us-ascii?Q?542dSHzVpV4buM0F1RbHD/YlDZ8XdRtqX11WCXwikV5l9XfT+sUm3A8Jk2Rb?=
 =?us-ascii?Q?WJLjFwbduBenc4EuVBbD50J0vcwBRKRsy7NG9CbCdVXGYQObVTlu0uV1rR7I?=
 =?us-ascii?Q?hKF8hXLYsSzuj077GPc/f7/Pl3YR4N07A3jDk0xJ86eVGY3LnFxUg73wZzbp?=
 =?us-ascii?Q?LiTdOXQmxZ+/zVXrwELNVGKea7/oOwkIFrop2Gbp98rZOBCDqj9U3icEOuK2?=
 =?us-ascii?Q?RuF2tH/regpuwAvCN8bChhxcsJFAZQ6Byolb4Ixj1Ms0l/kfAeRmwKlwbGzo?=
 =?us-ascii?Q?QTozdsINLzgdCrhIQo5+zRuPld6b1cfq3HPSexhA9eWjbhvsZOF+YKm5xmmB?=
 =?us-ascii?Q?uK+dXqCIIcwKa99+r7fk4BAXru0VNbuuw0oeb7DD4d+3plVYKQKmg83rO9Ow?=
 =?us-ascii?Q?Ok94MrWXviljs8KP3OnXaFr7XtHmnBGIitkwstXxzOZ1T2/d5C203/F/ahFo?=
 =?us-ascii?Q?w/2zN6npseEWDCU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SmPfxiVvyBR7rZTMOANqOYbttn5oWrEQA4Npb8fOOpjiRvobfoWUhxVg8+Ty?=
 =?us-ascii?Q?0E+DTkG5/iLvihd20PL6nG5K3KnzlqXfXQejB+ZB7zxT/EI7lNroOGlvTLjy?=
 =?us-ascii?Q?KCkk2X2xSLMklBrSEn0wZFkb2bP4dVY5I2ib9JdSqVWdu6ibZDevvR6Njvkh?=
 =?us-ascii?Q?gzB5w/JtP+DxnDVRzPFr/eSpxo8Z9TDd59ih+rMR6W2PTH/gbK6e7J6uY485?=
 =?us-ascii?Q?I+//r6xuFbaPmfJON8RJVfFccwS+RrbbG8lpuBMho2eDvBHw1KJypM50q7Fj?=
 =?us-ascii?Q?OfHLuXj8vj9YeMFqSNky8RBPHOy7ASmP7blzy7wdeOUKAx+jdwbZyc65HGuO?=
 =?us-ascii?Q?129V15mJsZ9pkuN9+//XBgrDqfzzyVx2DJjx0ZESDw/LIjAccM6JwvaK22/J?=
 =?us-ascii?Q?G2eRY682hPgoo58fDp0Yzd4jsEQGt3Y4nozijsekvjVNADEEzIgC2WWTYLJv?=
 =?us-ascii?Q?pp/cxC8XxcFMLUbORCghkJUhtu8TCtBdtRskxZeLacGl9C+5zcr3aEh1d7Er?=
 =?us-ascii?Q?+ceBnrOab0QXmEmBWk5IuT1kXy1sedTywQHYVSnjoX1K09p7btmh2Ax2SqEt?=
 =?us-ascii?Q?1Ev81Coxho1U2wv0+/2K7iYgL6RaUR1n28QbqhdOIohiTNOzZD41/fj1g9a+?=
 =?us-ascii?Q?jxRqpCuWWw6KtDq18uYbjCdn7cHrUBHY5l7mKaE7/zJH8Df/HE96RuR4nrLg?=
 =?us-ascii?Q?01PNjMuzcqke2AZXj3AG2FoVbG0+dqGbVELTRKGXNbZ3EErZo0hK9BlCcD+E?=
 =?us-ascii?Q?GFuSWtZzwK+A4E+idL5rvc8vjYH9fajIqeCjPeax56WVOoQGvyWV4ikI1vMV?=
 =?us-ascii?Q?gZFyLsTiD46GPQDEvC5/UtgqhS1tvBE8QAQJaJ40hNJVb1onchtyzCCI29IN?=
 =?us-ascii?Q?7dJAvZbXNd4Op+GWZ4Tmg/iLreZ4XrdJL+69fvDC8hJn1obm+WhiZXeOE382?=
 =?us-ascii?Q?qbcTmLAIMdfYB8Vc9V/pf92PRGxv0hCBzP9E5UelYqemwRQbirTQG1wWiFcx?=
 =?us-ascii?Q?yPrZ1mV6cbzIXdGQOG9e2JV1dfUapIWZFanNwqeHcjbVL9qg8FZOVpswLgCz?=
 =?us-ascii?Q?EpDvXtbTRTpD2ZR6AB4G5UQ7CdNwDMANXYkCZBHfV5XHz7jQF7Hl3jbC1d6W?=
 =?us-ascii?Q?zR2aMFDe6W2yCk2bynfFwptTjJegCm41pY29vMH7DfImmqPbY9pN7jbvLrfm?=
 =?us-ascii?Q?Au/3ssG2mV9rJFF9L7qxxF0Io/lzF0vrW0kxIlL/G4ugvMxc3Jj092rz9lBl?=
 =?us-ascii?Q?a5oC/JyPyeWXpVexbdJXpBOyDA+q+PAU6XWG84eJQ/hlEBDjtR/F8RRVK1h3?=
 =?us-ascii?Q?XOkadr4hBGdm5/008CzPtPJbWUbiYwfxq+nWlI/TiZ7OBAH0vNLPNFobir/j?=
 =?us-ascii?Q?Jckb4rev1zt+DJWUdzTL2cjXRyVYgWG5GZjyvxy/svgOiTfgo9xOCN2kqZc9?=
 =?us-ascii?Q?iyhI5tgxGmk1wcPLyJc8C8IC7litmHegAprLDQDYjMDYYFRiK5ZfwKu92Toi?=
 =?us-ascii?Q?MjlM24nhhy/ln3Du7bmfIVYfu7+xJ8krBi6qWzi2jJ2gY+l6aEqafw9CzBmz?=
 =?us-ascii?Q?oq46OpzpMXHd6Zo3nR9BWy4oHqjUNt4Fgi4gZbEt5mXzyKZsMTUCnmblFM0t?=
 =?us-ascii?Q?zDq9K7/vvqcc2jGogWUFZa0YaLWNwH/d9PEKUlR3ch/Q?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0739175-a78a-4312-c403-08dd830f8d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 09:08:17.0449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6k32Eee7PLOrmrGc69g+kBJS4omxInVTNjdFDHow6HV2J9637/SHIrCbepz7DmzeSndlyha/Ljj9D0+xijb9RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819


> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 23, 2025 10:16 PM
>=20
> On Wed, Apr 23, 2025 at 03:56:39PM +0000, Parav Pandit wrote:
> > > > And I wonder if using the uobjects affiliated netdev's namespace
> > > > is OK?
> > >
> > We don't refer to the netdev of the rdma. Because netdev is not there i=
n
> many cases.
> > Its just rdma device.
>=20
> The ib_device itself also has a net namespace these days.
>=20
> I really worry that a single uobject has too many choices for the namespa=
ce:
>=20
>  1) The one provided by current during a system call
>  2) The one that was active in current when the uobject was created
>  3) The one that is linked to a netdev associated with the uobject when i=
t was
> created
>  4) The one that is linked to the ufile's underlying ib_device
>  5) The one that was active in current when the ufile was opened.
>=20
> In all practical cases we expect that all of the above are the same thing=
, so this
> is looking at fringe cases where userspace is changing the namespaces dur=
ing
> the lifecycle of the FD.
>=20
> So.. Some basic questions.
>=20
> Since ib_device has a namespace and ufile is tied to a ib_device, can we =
ever
> have a situation where the ib_device has a different namespace than the
> ufile's? This would mean we changed the namespace of the ib_device, and
> IIRC, that means we revoked/disassociated the ufile? So the answer is no?
> This means #4 and #5 are the same thing.
>
Right.
=20
> Can a uobject affiliated netdev have a different namespace than the
> ib_device?=20
When a uobject when created, it is not affiliated to netdev.
In many cases, a rdma device does not even have netdev at all.
Some examples of it are, IB device without ipoib, efa, an SF rdma device.
So uboject does not need to worry about netdev at all.
At best it is the net ns of #1 or #2.

> The netdevs arise from the gid table, and the gid table population
> should strictly follow the ib_device namespace, yes?=20
I wish it this way, but unfortunately, rdma still have ancient shared mode =
for example single rdma device + macvlan.
Until that is deprecated, let the gid table entry's netdev drives the QP mo=
dify as done today.

> So, I think the answer is
> generally no, but there are going to be transient cases where a gid table=
 entry
> is in progress to delete while a netdev is moving to another namespace? T=
his
> means #3/#4/#5 are the same thing.
>
True.=20
=20
> Can current have a different namespace than the ib_device? I guess yes, t=
he
> FD can be passed around. However this would mean that the FD caller shoul=
d
> not be able to get any gid table handles as none of its ifindexes will wo=
rk. So
> #1 is !=3D #3/#4/#5
>=20
Well, it can pass the fd after the ifindex is resolved (i.e. after modify_q=
p).
If fd is passed before modify qp in different net ns, its can get access to=
o because rdma device got shared.
But that is the case with raw socket too.
The difference is, every send() call checks the ifindex, vs here its checke=
d when raw qp is created.

We can add the additional check in the sysfs and in modify qp, but very lon=
g ago (2019), we envisioned that users should use only the exclusive mode.
And hence, those checks were not added.

> And finally the FD can be passed around after the uobject is created so #=
2 !=3D
> #1.
>
Right. So the optimal place to attach to user_ns seems #2.
=20
> So, I would say the correct namespace path to use depends entirely on wha=
t it
> is you are checking.
>
When the uobject is created, that's where the enforcement should happen aga=
inst the current process.
=20
> 1) During uobject creation CAP_NET_RAW is checked against current.
>    Perhaps we should further insist that current =3D=3D ib_device's NS
>    as well?
This can be done when we are in exclusive mode which is not the default to =
avoid breaking backward compatibility.

> 2) During gid_table lookup for any reason. Use current to translate
>    the ifindex to a netdevice. Match the netdevice against the gid
>    table.
We always use the ifindex and net_ns of the netdev of the GID. So this is o=
k.

> Effectively fails if current !=3D ib_device's NS.
Only possible when in exclusive mode.

> 3) Routing lookups/etc should use the namespace of the netdevice of
>    the gid index being looked up.
>=20
This is already done.

> What other NS users are there?
Incoming rx IB mad packets are looked up in the GID's attached netdev's net=
 ns.
In-kernel ulps (nfs, smc) do not seem to have the interest, but they do not=
 created uobjects nor they access any uverbs fd.
So they will be protected differently anyway.
I had patches in 2019 time where kernel caller passes the net_ns as they ho=
ld the reference to it.
But no interest in users of it, so skipped it.
Last time someone from Western Digital reached out for nvme fabrics but no_=
show after that.

Regardless, those users are unrelated to user_ns uobjects.
>=20
> > > Going back to the original proposal I don't know how ready the code
> > > is to handle callers that are not root.  This is both a question of
> > > semantics (is it safe in theory) and a question of implementation
> > > (are there unfixed bugs that no one cares about because only root has
> been using the code).
>=20
> We need to look at each change, but I think most of it is fine.
>=20
> Jason

