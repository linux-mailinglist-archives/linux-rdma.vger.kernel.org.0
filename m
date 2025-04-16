Return-Path: <linux-rdma+bounces-9468-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75373A8AE4B
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 04:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D974A3B949A
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 02:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC75A1FCFE2;
	Wed, 16 Apr 2025 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lnylGnI/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rI1lZz/q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2F2557C
	for <linux-rdma@vger.kernel.org>; Wed, 16 Apr 2025 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744771833; cv=fail; b=M5GGt1Uvgmq1tNX53o7EKS7J0F1xREJeRTe8ARTAgm7NzlHVYMzB+xVR3gndYpd5wigSbGZVGcJg2tEPVQaJPh+zjzcMlEyWcyLsgS88QPFZ1yk+P+8sECgEFBxTEa4kGrwyFWbPEfgEjudghXzFOsfKds/u0pXle1SxdU+OyKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744771833; c=relaxed/simple;
	bh=uHDJ56ihQxqzNduy7UQ7IhREGhJSFdDbRz7bXWR9lo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jJzXgfA865xlh35EyD8tpmJj2hf1SkptaoG3TccQvL3AUQERQL4h8tdHoFO2MDoDL5FMJP0bwpeX27AyEmmjYJnPoPNUxMBuJVS2NHpZ/vvfhBfqsWrQMoGaJ4z7v/o963m0XAlFEDFKEB4AzhXQg9ZJf3LNg4Y2ZZzMNJUXbeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lnylGnI/; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rI1lZz/q; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744771832; x=1776307832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uHDJ56ihQxqzNduy7UQ7IhREGhJSFdDbRz7bXWR9lo0=;
  b=lnylGnI/zf2NGcWBosvZ+SGg32jYhHXsf8XGNLwjd8R/rMdEJs7gx/xh
   SY/z6uao/CEszh1BmzB39Cdp8bd1QuV35PMwyXIu7zaEpX3hqZtCnyVOg
   T31ZOFEIGRjrTupeNfh1DINFDI/L+FrAKh3mlOFNHGQb0aITqJufO7rgv
   mYTpsv4xabryxjmZakPauekb4pLqj3Pty/kpo7kRTp2s7zSQAjQhYR3xK
   o5SQjADYsYvlsvLkFBmuaB/CyAHVX2AAptoeFSRkSKoohSdum5dPkJG7t
   H2LQ0wIV09TbYi74YLYQhpoUdRD1iYu9zRoBVOFiX5U1UlgktTyvzHJtC
   A==;
X-CSE-ConnectionGUID: m+ZZ1zd4SKWuriGJBXuDvQ==
X-CSE-MsgGUID: 5FcwXkpMSLOG3ssxQKIJEA==
X-IronPort-AV: E=Sophos;i="6.15,215,1739808000"; 
   d="scan'208";a="76892075"
Received: from mail-eastus2azlp17010018.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.18])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 10:50:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoqzaFU3wtHgJhGt8TMfAQlStlClMLbTtqG9/p2G2nAHaC++B/OxI8KFyu7X0v6ugdwfFnWeqbBWUEscoezB4qEpkQzZuNWnym2D3kMLja4ahBtgwfFbiN9jUARBcP44G00f/YeFOWH9awGAxoLFqHRPqMObt+mOADpZPMDls1efZJK2rq8vgPxqHggl1o+S78eK5qHpnVrqGLyaneXvrB+zjibeeX1VbbC8qdHDxtX/6LGiLoyONZQ7J47SThPgITXoc+/o3Vepj+ew0X47sKwzKt4kt9XL/Z9/pL91whv7oE3HaxL/cKPOQ9rV/4Pm1epmY9ecpWluufI5ostrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l67HlN2JhdWf+05hFcH8HPVmV3pzqTIRbgRO6NmOv0I=;
 b=dpOqdbOELRaPD6a7F/3lwayTJXOrfwlAtbeZMPPo3RM2a1tDvuhonXGNQmg7qmqdG4OpM96ynWUJ+FW7TtpZkty+LhqYIrL5AB8sq4wbNHnUsfPOqMlwi/vFzm1KWrenQjnLTQOgqTCu7rj3il+Cl1fxmwZ2CHF5MTDe/DAMr0Lxni/avhVBhGaDE47Nt10zYoX5NbH2KxkuWNIf9dtFyY65GV5ABEsLqTyrlvCmRCnIP+s8gN8NaOf7ZLiBfZVvbniLFn0gRDr7LEh9uuNE3AXfNJYvn+Fqmjb4RyCm/QYwa/fcPTBrRaiC8w2q5dkSJs4tk9lSwZDd8Hs81r8QjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l67HlN2JhdWf+05hFcH8HPVmV3pzqTIRbgRO6NmOv0I=;
 b=rI1lZz/qhXJnfGEPnKMGh6VlbBr6AbwbAxY1/KyNXi05XFfSGmTgX8ZapJFhU7567Sz6qZekoJPUjoFKz/lAUTmvMZsLWNLpC9QdFhGj1cuGJj8wdqQMOoU98r2kwOdTXXJpQ6p8MYZzZil1a7h7n3OuhQG0p+Y53+4zfSjRR20=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7708.namprd04.prod.outlook.com (2603:10b6:806:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Wed, 16 Apr
 2025 02:50:29 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 02:50:29 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
CC: Bernard Metzler <BMT@zurich.ibm.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Daniel Wagner <wagi@kernel.org>
Subject: Re: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Topic: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Index: AQHbrfdhJhGSraouF0ezotWmIGdrJbOksFwwgAAh6wCAAMZmAA==
Date: Wed, 16 Apr 2025 02:50:28 +0000
Message-ID: <mrdhqtchtzw5f7ypno6d5g4fwh7heoyx5nyjvfak46cneprdrm@o4q2olnuq4gg>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
 <BN8PR15MB2513CD2A5725F5A035AE905699B22@BN8PR15MB2513.namprd15.prod.outlook.com>
 <3cf845ac-fd87-4808-bb53-c4495b03e68e@linux.dev>
In-Reply-To: <3cf845ac-fd87-4808-bb53-c4495b03e68e@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA2PR04MB7708:EE_
x-ms-office365-filtering-correlation-id: 0fb4ce3f-2355-4131-058f-08dd7c91728a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?j+brmZKJOq72uJwZbYkMSpnNVdwC5fOJB164e3N3PP0KLfeRJpreWLAtl8hV?=
 =?us-ascii?Q?GAetEfE0MEv2tq11lVUvxgWl6+GQto1HqNNmk8mRGBkUocjg8BP5P6cgZWHq?=
 =?us-ascii?Q?I6l+x/QliaKKm7MJ5xRn822jP98W9CJE8D06PQb4clgCHbGWSdfba+FHir3c?=
 =?us-ascii?Q?eP0tqsKwjEWSscgtI+X4y8Pe6EFs6JPFxZkAqWtIOJx6jMurtHIR3fWl1DE0?=
 =?us-ascii?Q?rmsF3Fofn3L32KWMC5G4g7Qo+gFzlbEO10X7oUpNcE8Uw0SvPTfcYO0+MZhL?=
 =?us-ascii?Q?YIuh3F5bwKZK1ypZVSOzLszIGR1F0l1g/VOwWrWsJlKySKf4sm/nR3hzJV9D?=
 =?us-ascii?Q?1zuMmx5Vpf/Zv648ol1LqS0oKPDkdytOxZ9+FrAds5lrJ5lPgnccwabiqezy?=
 =?us-ascii?Q?knQttK1H5IF2jrcEytRrj09lhZ8bjvwLPagtw6Ep+SWABZqi2r9XVX687wQa?=
 =?us-ascii?Q?cWWrgD7hvAQi6Ory3tUYY7y68SNAIdDvHqOJkd7dtnl3v5aHtU9ENC4dxb53?=
 =?us-ascii?Q?QZBhysr6yLcDNAOOx/9utr30VJwOXh4Lb9ADEdksx5+ggZ4dy2K1+idMDGaj?=
 =?us-ascii?Q?dEs+lDt09QAKamL4wvYa2im2VsSbjpOOh/x3SC/D8BTfmg0OAh9v6r1YEZsY?=
 =?us-ascii?Q?5vF9byddqM6GuoMs7aHrQBqT1ADQv357/okG7DmROchhgxUQcA+qz6AGHYo3?=
 =?us-ascii?Q?fzYCkvvDXFmnMLSpeUGrmvP8XLlxIG2gL6e566N3qNW4gni4BXz6JlZsg7TC?=
 =?us-ascii?Q?vhyBts6L0+u1nikd8PpNUqJC1aETCpumwNsJ6Xlogg6sjk0RLpu93ZdPMVQ3?=
 =?us-ascii?Q?Ytz0v1njvb1T1UzWrHbvqKrsrxGxGsCWpFIOZDHK8/B37SmfGLzBAIIt1N3d?=
 =?us-ascii?Q?WIeVd2n6IroAHxAiPFmrDlWoOYHy/rH+QcpkELffs+/Ju12gU8bC/nwR4sMq?=
 =?us-ascii?Q?M2XoUmackT1dc2A0cAjknNL2rWK7mzfV2Oob02V0VmKpDEj3tBe7AkeUKYj9?=
 =?us-ascii?Q?ejsSx0zt0Vzi+pfyt9+K4L9GnSHiYsvELvb5SPk4wfiNvEmqp2j7Ly4cqyXZ?=
 =?us-ascii?Q?hhR8keENyEdv+aVSgwHHfZvmjNb3G3+WD5jgDZNIbYlyMXPMbGq5+JTmNloW?=
 =?us-ascii?Q?U+yTBhEgMnQHPmVBOyxwjUbDMrk6R8PusNdxrKAeHQsE4b9pT4F3D4xnIGcE?=
 =?us-ascii?Q?VLYhSmNwTF+NGy6hZofhKD/hw/dbxKRDb5OZ6nIG/t0hPKsJS55DDaCH/Fcg?=
 =?us-ascii?Q?hPwy4ow7YwbJ1/S6LG16pCY4yHDCZLf3YBMouJWAKh7zzaTo3YNWXhWuyn99?=
 =?us-ascii?Q?BE82qA3OOYNafbARS3XX7VFOOFPn9GX6k0N2pEmGGqR4dh+/Tmte3dbubFuF?=
 =?us-ascii?Q?HYnvMt84UJmd+gSpoQVMZULTVlQe2k76s6vLJbLz2p5Q9cDviGEqu/bxW8EU?=
 =?us-ascii?Q?my5kwVKoVaob6ykOH1qhwvzyWpOYElRsn+E6p/1VO1eXsOMDBXFO/PrxSl8D?=
 =?us-ascii?Q?elWpuw5VSQwBLZc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cotmweTLD9qwpjan50myF/4/qPZ0ZhytbPWP5cAA3aQ4RVwftdJzjgJADlsC?=
 =?us-ascii?Q?lqJXbuikXNhm6uwAGTTQmyHLauh3kmoTGDJq+mGi5ChYVcxmJXiXCnbkB6vB?=
 =?us-ascii?Q?+OKFym2DvAFMwcbAyvkcAEopwEukYt8zUKmecubhk1kAkU32OJFykitoyQow?=
 =?us-ascii?Q?yao8ym1BDeC2k323XiAxeGd5iAJfQQwm5RP2ZnEz5OcUnnC8MogNMVUi8AJQ?=
 =?us-ascii?Q?XN+za6NhqTGE8PMSaGK164rIby62cF+HZj/RbH9ot6bA7cgLTDmjO6Zft67b?=
 =?us-ascii?Q?m5xEVMXM9S25U9VFrOLdJcGr1bSfnAvkb7FW3QYnWmgjiEtYw/VQHS0V3PCd?=
 =?us-ascii?Q?FMWlm0MdGQBh2PYqDzhbHRirH0jj0GCZ0p8g1h4UEm8GX9RsZw3N7NDlBw4s?=
 =?us-ascii?Q?g9wm+Ly6oKN2vVTjiOr+8JowbAMD6NaWO0qhIEmzvL/b6xwsVjv00mHlskUr?=
 =?us-ascii?Q?A/TLU4RDsGUmK/kWJNE7spqOSat0zz1SLki1OHahBhGBbKQYzKVPO3XzokmT?=
 =?us-ascii?Q?sKlqIX/XUi5RSnZ7FSTNj+CKFNZVtcNtmAxWRMxVmnChkDipR8HGGCTS1GyA?=
 =?us-ascii?Q?7UQij4QpPNJ3UHOJBEsqXnSoEr2uvZ0ngNc7hyMm19vRRsKuaJMS8JZEqpW1?=
 =?us-ascii?Q?NJKT/0Wcmtcyk3Bj+V5Pvcji4zoGyGg52J9YvkNlk28goV+/SsKEyjAHjD+c?=
 =?us-ascii?Q?d7jcMBYoVkpz5B2ZTqoGto4abEsjuI5cquQCwUZbl3iz77Or6Begv5oLUAVZ?=
 =?us-ascii?Q?FdoAmQdTdzBTBQoGO/04L/1lPfDJC96pmtKVZD40UVBJpm0ObK8V97txIOtT?=
 =?us-ascii?Q?/9MVwXdfiiYWzB88VCAuVUar9WRrLnZZAk8GqHtjmeWO2hSRrzRrzcQyGiWG?=
 =?us-ascii?Q?rFTKBmu4563Zdmim+P00Lc+mL08t5oDTCvuLB5nhSE2/qMpR/HhqyS9aBsaM?=
 =?us-ascii?Q?74sC+2t4z1hbNG5+HiHBMliQ+PKI3N452lE1Tx3Qg4cOF696N0B3Au7XVICX?=
 =?us-ascii?Q?dtIfHsSxdm3QSSG1vJKdnHavyLa6CIa8gUNztVDOUyiS+Q65+MlusE66milI?=
 =?us-ascii?Q?F/kIjwxmfeyOQluhL4edALtBIerfWP7qmSqPFKQ/IXIqAeeGng8uGnL62m9P?=
 =?us-ascii?Q?sD9ctijhFqXAAZP86OTnIreQhZdq4okIWAY5vW1n8yfAjtPuyIIAdBPgfD8a?=
 =?us-ascii?Q?v6UQ9PFLjJmPsxsj+MdCQgB0hraMuVWBvRptl7liCkqIAFSfhokTzPJjdwEy?=
 =?us-ascii?Q?DnZhM6VZ7y8tD91FfKYqIlLIBtFmGbSOU+N2YEAAyrhnkqvANbou/ieKBBX5?=
 =?us-ascii?Q?MFlqy1OMVESsMSjNGAMv3Il8K/LwiZhHnUK3nd0xS28826oACdhhEz3MeT7S?=
 =?us-ascii?Q?msHr2cjtHQwcK1srvRfGNuC/6RDQFUE2mFSbsfiWGDIG28y7zYh3z3ytCYcw?=
 =?us-ascii?Q?FP6voigqaIR2/zjr1DMeqM6FfiVmcX/g+sQEW7oUXoMjWs1c6zEpL9dKG1nK?=
 =?us-ascii?Q?2RNkFA5fcOUTKsvMtOPjduzW3w/4pwaFoxmZJwq7leb/a+5EiSaABeeUO8Wc?=
 =?us-ascii?Q?3/CF1RS4u/XI1u3lNPt3WmG6WytnubgnHW8WVTtrgMg7J6Vo/awgMmaA4d7b?=
 =?us-ascii?Q?Dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65481BCD35B7F641A65E763F75D5CC2A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	08AVYbhjebghToQok0qcxmQl3fpB6ST3Pnx3CYV4LBWO5HztxLX+Wy1dzi4e6OzqCupnQ6/EbpVTiVrDmAqETTtBT5S0GuPeff9MpzfyJsuoTC/jPH0vPg2GTI19F0m30EdNJaKUrFXbW1NRccVSbGxW4duEg8L2wg/fpFD4xwARMSRo3gFt2SPz/nSR4AERBYIdo91eAFBOZ/AHqqazcHQWe3YGRfMPAbMI24Jo/UpTcPMAVtdahwXmWYDV6LJc9LyjZcNRAUYuIumZdkcLHp6lMATmwS2t5uZfO2YfpTLVagsBnClPeii1fXmyyjyRYzWIZ7gHaCcN2qE5DbyQBy6GBCSWNlL9QcL7ouoaWwy9P+CuwncRQTOaKadUlYE2n1lcjUcdZsPB7mJdsLpZOAekdzrKYQGAeyp9Yr/zod0PvUWILDBKy8D1/Bp5rT1Zc0/AtBw351KIHwB6OwpcUDBhoID0RR9ecb5pkw+f7JpLdZkcITjY+L2pueqzmxf5EU0YEzToTKUQtEf6CVZUwq5eYV8S8TtqUfkL2JNJRKS2pzgihXibhJ6WTQRyYS10dm/UZQ/y84M4eIvGiYv/4dYes1CDismcvf2+P2TEcpJSv82xft5muQQ084eqsQXO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb4ce3f-2355-4131-058f-08dd7c91728a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 02:50:28.9674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZwpyEfNfW98uajAmoNWOVsgGj10EAzzV86Q3m35PKOSZrNj0FDhFF+tcQDePY9nq2bSsG+5Dr1LQnyNV5uV5WTL0Cf8JolZRMSBV+VaP3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7708

On Apr 15, 2025 / 17:00, Zhu Yanjun wrote:
> On 15.04.25 15:09, Bernard Metzler wrote:
>=20
> > [  106.826346] rdma_rxe: loaded
> > [  106.832164] loop: module loaded
> > [  107.066868] run blktests nvme/061 at 2025-04-15 15:03:04
> > [  107.081270] infiniband eno1_rxe: set active
> > [  107.081274] infiniband eno1_rxe: added eno1
> > [  107.089683] infiniband enp4s0f4d1_rxe: set active
> > [  107.089687] infiniband enp4s0f4d1_rxe: added enp4s0f4d1
> > [  107.264770] loop0: detected capacity change from 0 to 2097152
> > [  107.267376] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [  107.271276] nvmet_rdma: enabling port 0 (10.0.0.2:4420)
> > [  107.312957] BUG: kernel NULL pointer dereference, address: 000000000=
0000028
> > [  107.312973] #PF: supervisor read access in kernel mode
> > [  107.312979] #PF: error_code(0x0000) - not-present page
> > [  107.312986] PGD 0 P4D 0
> > [  107.312992] Oops: Oops: 0000 [#1] SMP PTI
> > [  107.312999] CPU: 1 UID: 0 PID: 123 Comm: kworker/u32:4 Not tainted 6=
.15.0-rc2 #1 PREEMPT(undef)
> > [  107.313008] Hardware name: LENOVO 10A6S05601/SHARKBAY, BIOS FBKTD8AU=
S 09/17/2019
> > [  107.313016] Workqueue: rxe_wq do_work [rdma_rxe]
> > [  107.313030] RIP: 0010:rxe_mr_copy+0x58/0x230 [rdma_rxe]
>=20
> Hi, Bernard
>=20
> An interesting test. Can you find the line number of
> (rxe_mr_copy+0x58/0x230) with crash tool?
>=20
> Thus we can find what variable is becoming NULL pointer.

I observe the failure too, but I also observe the recent patch [1] avoids i=
t.
With the patch applied to the kernel v6.15-rc2, I no longer observe the fai=
lure
repeating the test case 100 times using rxe driver.

[1] https://lore.kernel.org/linux-rdma/20250402032657.1762800-1-lizhijian@f=
ujitsu.com/=

