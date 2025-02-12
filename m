Return-Path: <linux-rdma+bounces-7670-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F6DA32324
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 11:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874733A133F
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1D22066FA;
	Wed, 12 Feb 2025 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=keysight.com header.i=@keysight.com header.b="d6bYF4ZC";
	dkim=pass (1024-bit key) header.d=keysight.com header.i=@keysight.com header.b="NV6L8411"
X-Original-To: linux-rdma+owner@vger.kernel.org
Received: from mx0a-003cac01.pphosted.com (mx0a-003cac01.pphosted.com [205.220.161.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA01FC102;
	Wed, 12 Feb 2025 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.161.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354629; cv=fail; b=XQ+qBytrqeN9FAuNirdYg6h5dFTfo1I0ySvfvpSH4Rvq2U/WxrUxFa1YxV0OpicZv9/LWCLrw+S1AUzm899BlWq2YPLz/02xzDjgd/N1s56YL6iKPD6GQTGjqs85Jpb25Eymm4tRfO0plqQHOS+vZitVAOtehk8xJG/bitzyleM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354629; c=relaxed/simple;
	bh=hPlkGltt7+g9Kif32M/k6widfQ/0g2/qlywuCQo0y9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kLM9gmbXVp+pzK2wI29ryfrrtBFA4IN7S5dRNeg1ddwl6fxiRnTxkcYjKp4M+HJTBahxnpSn2n+Euboe+UidYUwSpw3bIuE0iOFTQ6gqRjGbFLJbbHOAPtFrYZ054szsD3MnNoXKQykSwPnaHMHqw7jV3oUKcUgCS27hQfdR2ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=keysight.com; spf=pass smtp.mailfrom=keysight.com; dkim=pass (2048-bit key) header.d=keysight.com header.i=@keysight.com header.b=d6bYF4ZC; dkim=pass (1024-bit key) header.d=keysight.com header.i=@keysight.com header.b=NV6L8411; arc=fail smtp.client-ip=205.220.161.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=keysight.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=keysight.com
Received: from pps.filterd (m0187214.ppops.net [127.0.0.1])
	by mx0b-003cac01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C4O54n004393;
	Wed, 12 Feb 2025 02:03:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=ppfeb2020; bh=
	hPlkGltt7+g9Kif32M/k6widfQ/0g2/qlywuCQo0y9k=; b=d6bYF4ZCqHMCUfRh
	83UihltdPqy83D+7L18+7/RqCiOaxSDkcsEsU5hW9z47Pxbbk86uiwLoBwC50fhN
	TK7G8rwM74FyA/mQ7zlWq9PJHrgI2JdADf3FH0X15bq+Hny3V3v4jAeagRTZy1su
	YE1H75O3WN07ocem6D94foIotjcpKC5ZTtrJovIV51MyhtpBGBBvnw7FH992wGsc
	GC/k1ileY7oxX9pgNo+yoOcXoVGmEdm8tMWnUmRchwmqjBeKppqKAeWAG1U0+c7X
	nlI77QLC4SMZfT0kpw5UCOR/gYlzp/8iwKxt9Qc03J33pUBvixTKo4UeurBSO58N
	gjauYQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by mx0b-003cac01.pphosted.com (PPS) with ESMTPS id 44p5exrapf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 02:03:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4DjiPoBAVXdMTFE9iULajTRrffasuJubPqzF1PbNrVfeCnEWKhK8xWpr95c4oYrWh7OPoHaHbJUxDI4KXRGF5OFYRi02SamdIhStY6/N7OFI0etNQ8D8Q4soC6eV+XYufcyAMgPAlhcQeuuuZyadFiEBwY2mYuuB+oCmiofx/80zkHKWY70Om32fZ50/HF0WFaAHU4i+dZkRZutF54kQcAh4zSRPVTlPf/Sno/35ybteBpuHtiq3VXfh16Irbl9d7e47MMs1EQekkTu5Pwod2H0ggZ2w1FGTKeu/uIpT4Qss9P6wb0dg8mLQWwYZwBwbcajEj3rjYuByUAtQB04Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPlkGltt7+g9Kif32M/k6widfQ/0g2/qlywuCQo0y9k=;
 b=I//5/WjWcN5hrwOXUpxwyn58xlYpaFEKmoT7BLTlM3W1stJ3EADUUpXSn9h6y1qhyy+H21JRSL8TgVDweFbwF5J1Fbx3K3671qSoSlKVU4aKmI+g5HCrD9M8P20KCeno0smY7Z0jFx/GkeUpuzqhiC9EKh602IUMcWA51cCm3cEcVxeuOdmUNn3PvUJNjluR34jMtIeIFmHWUe4zLoeJ7vWb5EFZSx1lBs7EQxYvmgD/hkxlNB56nNTS0E9vKimlIAmOXptO6lwe6uwka8p85Y0y87M55kmoxKjTzFZCXTtqG7rVzkXH7/Gh9Z4Sa1ki+MG+fA+5ucCXNOFCHLdvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keysight.com; dmarc=pass action=none header.from=keysight.com;
 dkim=pass header.d=keysight.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPlkGltt7+g9Kif32M/k6widfQ/0g2/qlywuCQo0y9k=;
 b=NV6L8411X/o24VdmZhWjRdQOVY+kjDzkQQrH+sxHEntSA1fTd8UOxsdZ3S2qjSDQc5zqtxRff5AJLwg+mDLBZRJ3XNxpap+59o1G+nMPpnEkDvbmDZ1bDafddMzk3obtFbkNmWoH51uNeCS5K2LQJHuLnwj3lKcuvywEMpFB0nc=
Received: from SJ0PR17MB4581.namprd17.prod.outlook.com (2603:10b6:a03:35a::21)
 by DM4PR17MB6245.namprd17.prod.outlook.com (2603:10b6:8:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 10:03:45 +0000
Received: from SJ0PR17MB4581.namprd17.prod.outlook.com
 ([fe80::7f8e:cef4:46d:b3d7]) by SJ0PR17MB4581.namprd17.prod.outlook.com
 ([fe80::7f8e:cef4:46d:b3d7%6]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 10:03:45 +0000
From: Andrei Sin <andrei.sin@keysight.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "linux-rdma+owner@vger.kernel.org" <linux-rdma+owner@vger.kernel.org>
Subject: BUG: RDMA IPv6 loopback uses MAC source address for destination MAC
Thread-Topic: BUG: RDMA IPv6 loopback uses MAC source address for destination
 MAC
Thread-Index: AQHbfTOKnshNc7YQvEGsvJTT7sF1cbNDcBO0
Date: Wed, 12 Feb 2025 10:03:45 +0000
Message-ID:
 <SJ0PR17MB4581AF63984DE71DB6182906ECFC2@SJ0PR17MB4581.namprd17.prod.outlook.com>
References:
 <SJ0PR17MB45817B76451A84002F01E681ECFC2@SJ0PR17MB4581.namprd17.prod.outlook.com>
In-Reply-To:
 <SJ0PR17MB45817B76451A84002F01E681ECFC2@SJ0PR17MB4581.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR17MB4581:EE_|DM4PR17MB6245:EE_
x-ms-office365-filtering-correlation-id: 807c0d1b-db09-4a6d-2db3-08dd4b4c897d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?OAyeC5RrUNdqapjsrk+FJkR7jsruuD93zwCdqY3CUeas9FDk8h1m0KWAyk?=
 =?iso-8859-1?Q?9BNo4c0FW7lKQB+twxhtbpNmtROF2pC2Vz3S88wlHjq8JYcfl/0q0hLNHu?=
 =?iso-8859-1?Q?iNRHuKt3FMcXuArByehufZ37QoXFCFMbD7PrHG5ooXEbrnI4ncicHSEq2j?=
 =?iso-8859-1?Q?t0gyvYjLi2efVYrLtQgvj7J9D/oMM89wOp9z0nijoEeyHbvAP2uBl4Tqqm?=
 =?iso-8859-1?Q?dam4A815fGjeTgMCuzXPQg4GmBLwytIdJYc8x6WdMMgsteO9FdWBasRBgQ?=
 =?iso-8859-1?Q?tnKhMEdAhSarTiNZ1jld34JydcMoyeQH2LJChekBYDJCTVAMPZIHMkDYnS?=
 =?iso-8859-1?Q?m1+J3V42gtbmQKwzhYekj07Kv9Z+240gzgcyWlIaRF5BCYHpn6/cPhFPr7?=
 =?iso-8859-1?Q?aXVeck5PhrMPqM1kAuRe5dxeIOMF27RpLIPfBEB15FUpGw9BoeRNCo777U?=
 =?iso-8859-1?Q?/+H+WsmfQj2x+Zk0zVwnwOLKhge1BT8nsDLw1xEfYeRrdVolJxnEnombEY?=
 =?iso-8859-1?Q?pwEBVD3fjKdKrlQRI3dFK5oTcz39z+2Lm0c41+KewXtoNICuUYWIEPSL5v?=
 =?iso-8859-1?Q?659VvhgAMt/z90X9P7CXYJs0tJlcyerrp4QN0jasoln3numAmCUXlttwoF?=
 =?iso-8859-1?Q?9BTVN+W/Mqudx98WC5EgxnoCCxtT/5z+9oWLFtxarIiU6ThntTyAbQkQNI?=
 =?iso-8859-1?Q?nx4dOU0H/B/tjbm8InNA+AqG3mriHGssuUZNYWlCsHdZx7AF4aC9vrynjx?=
 =?iso-8859-1?Q?YIHuLN5PBLPHc9uzcV8dqijDUS3GgY9EtAmjidhmPcUhvKZ6JWdfpTD7Mx?=
 =?iso-8859-1?Q?n6yBzykZR+c9F0ITu0fnBaHtmUbMv+RSJwwIiCXcq0UUA4YRuL67RRnTCA?=
 =?iso-8859-1?Q?gP6Pf5cG4rgyikYVFVyfmPSgk1lCSS7ioRPcBoZNsdiPvN/SOzGhEaosPD?=
 =?iso-8859-1?Q?8nfxKaX2gI51lf+OjY31hjtyzh33OlkfYrr3/fauHOU7ZDgijJVaw81FOo?=
 =?iso-8859-1?Q?UKXk9oRIml4t2q5MlCD4OYAD/yxQvLiUcsfLe77/8/feLIfxq0XWyUSAVm?=
 =?iso-8859-1?Q?WEkzY8/65QKqEZ/morT7aYUDbqg4T/lfEev80WPPiEqhDgSiYpN1lu6QvL?=
 =?iso-8859-1?Q?5GYwQ7bxs0Xuxq8FeYcnjw8Hh+qzVyo8NxTY7jyClJlROQ+MstU3Q/lJ50?=
 =?iso-8859-1?Q?Y5fPCdudWfZ3ISUPn0XVl+eeCkKSTSoodq8Mxv0Z1/d9gzmMuJmoKFWlfd?=
 =?iso-8859-1?Q?rJlXknGWTIvRFFZCqxqbyoep3L7dbDY1hufbkd16ZqdElS4/MMtJNO2tIp?=
 =?iso-8859-1?Q?27uJ2ZFdjl0VdGwh8nQLhiWrD1z+3qX/g/E42mVlPczTGvSCkNvnbg9tTw?=
 =?iso-8859-1?Q?MAcddD7lAHZglJnGkyHY+tQcz7QzE8aaqNt1Jy+4U53S2/CSc683Pw6LPk?=
 =?iso-8859-1?Q?/0I2fSrWlIkXTt2c?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB4581.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hKfEtiiYxp5ejhNLJGBHUegjcoDhH+UKApBhUSz7kuy0VE2NieSW+9VazK?=
 =?iso-8859-1?Q?b676IkMCYrAlssQbNU59ClbzaRnY+n9VzbdI1OBxQQTVpvF/MJ0C6t/er2?=
 =?iso-8859-1?Q?Hq/vT0Zrnjfk11TlGY5LHv5l8jpbGBAgMx/+/v/PcCGJzDKQSVHRFlKOsx?=
 =?iso-8859-1?Q?d0po8a4gwqIgoITEzzKXJRN5dCfrLhaKHwdj/4oTFJ7AKD8HZLc88plAPF?=
 =?iso-8859-1?Q?punVU90JH8o4szbVc+lo7zIe2MRuxGFbQlSZcNU+i5kMmfXH4kQwXp8bLg?=
 =?iso-8859-1?Q?ebqBIvOGZ2scRhr7wDBan0eyVMclNSCbEkrd6uT2VQBLy7blJKSiwFErk0?=
 =?iso-8859-1?Q?WQe/cW6PC+CtWRXiuBgVbhg7ejv5bxFEUNDrGl+AeuBVp2MGkltiT5sSQO?=
 =?iso-8859-1?Q?xSarotNwFLj0C9QFc2Nr5411G+//3gk2kRaF1EopJiJQ6iFZNChP6Zil5D?=
 =?iso-8859-1?Q?y4bHMc6RIJ9U4p+ypASEOUnpalItGYwXDe8sVip+jCWYsM99adKI4MSwy/?=
 =?iso-8859-1?Q?q8vNH4yt186eFhEJQWF9no/epxZCXthRPQ9rhwgh8ZzQRKMcPg8338/i+b?=
 =?iso-8859-1?Q?m3QPtC66+uTiIDQHLr6M8cPiMNWwC+hBY4pCWSmLEB09pSnRO2ruxkRNln?=
 =?iso-8859-1?Q?wWKwesW0xgdPVgqiL9TPFpKO7XobTTQvy+0TawMHfGfsHp8CVSm4pnDM/i?=
 =?iso-8859-1?Q?7uhJ9qxX1hT096KHOV2D2ZtQSE7deBGa9otZKnQOAy/a3vcIgUfpmG6tXs?=
 =?iso-8859-1?Q?f+BS+yNvjeDNrh/yL/UNiMu/HgVF+3bKNfZs3BfJ/yq59CNC8inFePJRp6?=
 =?iso-8859-1?Q?Xb201TUVdUALtwEY0ec4X87PBb+oAzLpCBZ/p6U3kCiaEjuE+9o5ndp2th?=
 =?iso-8859-1?Q?cyd8FCOD5JE5/cc9loHY8b3V33qy/1bb9tO/89Uhf1uRXb0PI3oR3S/k7w?=
 =?iso-8859-1?Q?L4kH0E5GIQuTHC/5QFUnvS8snLBeCGoWb+uKRpAzSZdaa5FFYgZWT5un/4?=
 =?iso-8859-1?Q?cKdw792qVDEeLQp41uaZv4Bxy91yp41ZG+HwLBNC6mYZEFAmdA/WtxRAbz?=
 =?iso-8859-1?Q?/iZBOkbwFDpzZhUSCeeUPBp81XQDeWHDddC1l23kS1HS1H2K3ANInuhdrc?=
 =?iso-8859-1?Q?mDvf4/X0r3qDcPpDgyOdzJfAMJPnI7BKM4h6rYU1hidcjEXu9bc1CLbC6P?=
 =?iso-8859-1?Q?bhN+YYPaEIjcy3Vl/ooukXEFUwFlcJ1ckIfJFWZyvI6jNJTRjPWPU7kw7O?=
 =?iso-8859-1?Q?M/ZQmhddWxBcThbVMB0XHhKU8S0Xa9FNPoBrhBPZPRoz6xy+s6wDS7VbP5?=
 =?iso-8859-1?Q?+/xktfqVij+icvz+Oh5M3YKTV/aMdfO9C5o87s0zeWXAKIz2zh8kDgD0Uw?=
 =?iso-8859-1?Q?j6bAEIIiZPCSXWTe+qer5k30EJWc4yY6JcQ1AoE1ufX6h5NEKeAlT68eV3?=
 =?iso-8859-1?Q?TV2lGP7LwZ8Dx8/dPF6UD6cYNxn1I+XZhp6t1heQs7RgP+xkYJS9DjNe8N?=
 =?iso-8859-1?Q?/YYdjzQydie1cuxFNuJdtERVVn65lS8hmUDCnz7T1plBTsY6mxTtvf+NBN?=
 =?iso-8859-1?Q?YKbdNs0I5TK4YRNOstwvZHmw3ibcMJv+9WyLHaON89+bKVvMVhZDdzsYbZ?=
 =?iso-8859-1?Q?eic1SSuCNb50uD89F/EOSItMjzzd7gWwu5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NAfbVyKNtdliHw6rCMaA7QtvChE1qyho/VS7ptYRDmdNuWP+gpqX0a6w6S6AvrH84ABKk48zOMm/M42Qckry8g6LGyDGVTGpwpzwuxaDkpGRi1W0h4AscFMjKw0FDTlOGo4spvQ4FgwBkpN2Jx/b765qg909H1DMpvNmVcvgY5hGEKetdA+3W6gG6EnsbqA6MxADXKifoT9zFEGXcEtD/Vu9ZqfMSEgt3K+aaY9CTEfDzcPDvt/WZMEbrEpVmmLhthPYNbebS4FL0Zyd4ryz654oKK09R47p4nF2FPGvR6FUb0/5BNG7ci4BjsjA+O2CYTt5Jpuab4S4IGBvFl/4XeVspaP2lyUe50H+gPLAIDp/2t4KeSq2ZDpte1Kn166s89QP8c/5g6/vZxAwDoMu1+9Cs73XJrO14ehf4oUwnrRvHB2bD+zVz7/h5Lkm2NGgjq/rAZTAvf21qIPsFqelVB3ISQpvZkG6fqXSoThZf5eNme/rxoDoRLnwwuLPWkas+uuyj3tDX2d8VyU0v4Q4Ps1pvxpwxvPH82+ZmNYRCHHXsZFNNHReqGH7hsmNsLQ94XT0g1OnTeX+Al1z6lJE0mdQsfzeg+UpR+voJHaIpvgXucGRVQ8Gf1OI2vvhFKZB
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB4581.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807c0d1b-db09-4a6d-2db3-08dd4b4c897d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 10:03:45.2155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XEVQ3aI1rgd5JfEVgWJ9U2FS28Gx6fBA37/Rihz5AKK+Qs5dDYcBdQgKzxMrHJEJ8EmfidTMgz5XTo5IJZpi5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB6245
X-Proofpoint-ORIG-GUID: hAtQiQljfhnQ-NtgukQQ-c4igwduTK8S
X-Proofpoint-GUID: hAtQiQljfhnQ-NtgukQQ-c4igwduTK8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_03,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxlogscore=863 clxscore=1011 phishscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120077

Hello,=0A=
=0A=
I have a server with 2 NICs RDMA capable with IPv6. I've tried to rping one=
 interface from the other but it does work.=0A=
After some kernel debugging and some TCP dump I've noticed that packets lea=
ve interface with destination MAC equal to source MAC!=0A=
=0A=
This happens here in kernel: https://elixir.bootlin.com/linux/v6.8/source/d=
rivers/infiniband/core/addr.c#L464=0A=
=0A=
Let me know if this is the appropriate mailing list or if you want more det=
ails how to reproduce it.=0A=
=0A=
Thank you,=0A=
Andrei=

