Return-Path: <linux-rdma+bounces-7033-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664A4A13184
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 03:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1E5160D90
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 02:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C75E6A009;
	Thu, 16 Jan 2025 02:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XQc0SlDa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MboYrnEL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770224A7EE;
	Thu, 16 Jan 2025 02:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736995493; cv=fail; b=W8TSYdYnAw8K6442022cJRNt6grirhXtgzVtZnigMkgpm2gQ1GqO/LDjBfKk5JME52d91HcJiQIdnfDhPm7E6GHcf2KGWP8izjdUtgibwNbeVd7Sc2+XPE6dE1UBsgaBlyETvn3Zbv5uZpilWRGHfSUHFtfm+OuvJju+yhgGP7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736995493; c=relaxed/simple;
	bh=7TrzfyqbMmULm0hAdNHGSyPCyyg0f4PGSwQi2mfJLvI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pkqh68yI/8w0nSZ+3FMaMVeEOkZCF3K3+mE+C2lrzw5QMwfHbcTKRcCkSUzdiH4TeFwzowsIYkdNpSgBkQ3CDutrUQokn+6PZTrMK94VrmkvEBjnDl/XDK7t2EOJyqbqsiMpKRZ15utd0hM1WmwVfhkrQKTJgCcrppUSm9hc/Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XQc0SlDa; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=MboYrnEL; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736995492; x=1768531492;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7TrzfyqbMmULm0hAdNHGSyPCyyg0f4PGSwQi2mfJLvI=;
  b=XQc0SlDaMtu+t1yKmztUCIg6opzZr9zby+KvStTHMACnSW/Nl6pWcucw
   9eIjwDSohlcaHv6zIu5Ceb2bHDYnkfpFKHTGQaPiV731wkNotF2VycbXb
   08JW0ELr7cQIQOZvEsm0L6fIECyCUr8ukxsukSiQZVVN93m+YQRlSC9Eo
   cQxs2qZp8b+vCfiqAiR/leEb5zXV32Nu+7BEkn4tnnmYTp5b7ck1OTiuA
   nmuP+WuOsT227fuU3QQH8qu9N7Nv3xQZ4eFXqHpmo5xkO/sYzR/o98fpp
   J+zOcWmiwf7guxh5XakYm4cqZp9CudsNa2nmWTK1czCMmmMTG+kG/I1qM
   g==;
X-CSE-ConnectionGUID: U4drXSr9RaWXXB3/gLtPRw==
X-CSE-MsgGUID: wAdxHQbvQtCTtTqwcQNi7g==
X-IronPort-AV: E=Sophos;i="6.13,208,1732550400"; 
   d="scan'208";a="36042769"
Received: from mail-westcentralusazlp17013079.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.6.79])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2025 10:44:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3KoYSnHrNccnSPMUcow8y/21F2WjlXTTx06p6SSyX21NIGDkeTnl3Tz1IKAACZm/tpXicjiVppHZtq+ygP91CFGa/LVjYb/l9MS447F8Uucy3TBo1Qq4H9utZRajTHImchqMTw1RqFg3BL/gxgX/LuPl4WSchx9M5w8CZUH0jJeiwpjUfZpQy1OkjQlErb6waEARa6hV8IludritJPbbBNDEhgrXG0AKJ55az43AyKe+6ZSHx1DwlQiJqdhBH6cgZz5hT6NZGvhVESfNOTpcqul3jmxbYW1h+maMZwY4+ZWl6nmFsrkx1qZbfK2cnX3zg8gDuieDLFprSaZ2R9WGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkZOUc/u5Ex4Fz3TKmbcFTds02yU4KL7Fhx0lRZiIbQ=;
 b=jvHBfxHlodehuIttIXz52hi61Gur7Yvkb7fSSN7jiSMV4usi6X+iKhdVX58+p3M37KXrqX6+WRWgSVJDzg9H5XwutdbgJ5hJDSBJU/f+lsHnChI7NIIriWw/swe8HiZFCXVjr6yAv4BWwRYW1DGawKr51B8CSDwCmfp1jhB1cDSdGS2gsy7DeV0zYlg2zLWqtbW+/MQMY48TIhiz3+4Hu0QU1qD75wG3YqqAjBl5rfWSMgtPRiO37tWLP7HAeEzezhij7Ljbo8VPtPyOw4d+zvyKnt1Ykw5Mh0fdLxiDTxW3NwaQFATQylOtCios0JfzFm02r6FOa7cla0jcPFe3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkZOUc/u5Ex4Fz3TKmbcFTds02yU4KL7Fhx0lRZiIbQ=;
 b=MboYrnELnc3jO0mECAIcWwH5yO/7UemhbteERFjf784sLO6E0Dd9teLxmF4QHk5d3Tqo/zVXWzhX+4dHNBSDqDBp5wStbtcX7FZ5iykTWeJCBN16Izt8LmeIaD8tpj9bwyUuXAC/dt682sx+T5xv8HJXNyz9DIUfdx1Hbuw7Fgk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ2PR04MB8897.namprd04.prod.outlook.com (2603:10b6:a03:547::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Thu, 16 Jan 2025 02:44:43 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 02:44:43 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH blktests 0/4] Cleanup and Optimization in requires()
Thread-Topic: [PATCH blktests 0/4] Cleanup and Optimization in requires()
Thread-Index: AQHbYMwdQi/Bh9TKr0yWiA0ZmTxkdrMYv5aA
Date: Thu, 16 Jan 2025 02:44:43 +0000
Message-ID: <qoovskakj5mskbemth7cerl36b4pfbq3jneqfshwll5kaj2s5k@ocolgzcqx4mo>
References: <20250107061905.91316-1-lizhijian@fujitsu.com>
In-Reply-To: <20250107061905.91316-1-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ2PR04MB8897:EE_
x-ms-office365-filtering-correlation-id: ecffcf7c-9990-4771-8eab-08dd35d7bb46
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uf5Ea3ul7DX+MzWCWxfzHgI/OlzrVGca6e159RyCHYEqg3toy93CiHfw1a6e?=
 =?us-ascii?Q?y+klFrd6ClMjz+SIXo4HVDbInTQnu65GxA2D+YivB6brfP2ALa9/h+V0ii9U?=
 =?us-ascii?Q?lLS21cxt83ZEWgS27Alx7gURcvJy73KikY3toedOYy+hIt5CbpNh4he3DYSH?=
 =?us-ascii?Q?Jjy6U3SzIHv5YhXUNK6fRBGN+1WzTc6q1Ujkdl/MQQx1zgMgL4Wb/bOTYZQh?=
 =?us-ascii?Q?z6Rv5d4YnOy1bhNND2dAu6iNnBqvgv+4sCNV1Ivwe9VFbKBQTs55FNRQLlOt?=
 =?us-ascii?Q?GQIzq/nWLLrzWZqqLWxxh/pewW6nBz5LnmVWsKaz6dQ8E0zu9zsAzxrf8rBK?=
 =?us-ascii?Q?NScbGg1+E6B/wvFdjqSJ8m9FeJ6YuJmMlwBs5e2BqR/oGZ8rUbrVDdO2nv8M?=
 =?us-ascii?Q?WDv69nleDhk366454K0c0659xE5ENGIXoQzPC8Xsr7LRzEfgxv8UXc+m+jOL?=
 =?us-ascii?Q?gz1NhX2GKXO8c9SLlDVkHy4yttgp4ZHRhYWw5hgESmDu6aKuMztqULHJprYz?=
 =?us-ascii?Q?RYwLgpk0iDErhY3bbZxPK/zBEBnKn04CK05vASVV14yk4OX2zvxFWD/1c4J6?=
 =?us-ascii?Q?UP53CXRG/jIXn4icVGKdGbB9MHS9KbJfVwSEt6F8hZ/bGOeSU/EaF8cV8aOp?=
 =?us-ascii?Q?Cx7n+RJl3Rjrze2R2xi64tQk27npapRKXDkChlDIeWvXsZlSj+5AbYbqYAmy?=
 =?us-ascii?Q?hH7ddt9f4MYXuP1VnbT3o0jvD4Ypc9d+5stbXFmM9UIMW7ME6Z6Qre3Uq3uX?=
 =?us-ascii?Q?+Fp3MmktuEzZl8x9iI4uy9X2M8NkoOXCWxqDn8T9Isa+fx+T1XMnjzTwECV1?=
 =?us-ascii?Q?oB7mAcOFaaZWgP+MdIw/wKNk0MwoQoJZoTe96DG963gj6xMVkkpmS7/ZjTyM?=
 =?us-ascii?Q?tfKuAlZyKujfJxi7yXUCDS70DVz0zENyyBNd8aSMxVlrUWicrXFW/atwIRpW?=
 =?us-ascii?Q?SGEX7HWLa9qX72cqANn4usuo9dmPYxpfi/Do6tmRxT26KNdXWk+R1Bu2rvLv?=
 =?us-ascii?Q?gFnpypVswpt0qbXd/6louLJzKobvxfkzolUJRLcC6rJNkrK1TSWbaIHa1gln?=
 =?us-ascii?Q?1mw3Ygamw1jWgDSCkYb9GYsmZm+ismrq0lF77I6eJOIB+QIObPohArvCVvPZ?=
 =?us-ascii?Q?tY1axX20KzKABl32sr52KZPtN3i8UEygUBRT2xpQvpZyJroJdHRPs4IS8jBD?=
 =?us-ascii?Q?tcOLl4v4k/kiWvRLWwEm87HicQOquOkKpOz3XzZEf5lcHrq6bFlAN3CW67WY?=
 =?us-ascii?Q?Ta13MofxzYZPfK+LTHJlpMpBvyskyj6UenfbunzT0fvpKA4HDV0fV8NsCSni?=
 =?us-ascii?Q?QgjMd1qzv47VhQbrtCP9s4idOM5US5pCb5vT8IJMwEfAZhmBe+Lg3igOI6Rc?=
 =?us-ascii?Q?nn6hX+SSSZqyF+Z5slGvL30bBcodLEBCoIVqksh7QQf4w8ydqvdeHk2rQEFC?=
 =?us-ascii?Q?XCt6Gyt+mTfw6utMkCHE9UhA2cgszW+A?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SGEBV5VJenebAmYf1lGVWjok3tvT3l4CFp8Sb6EamO9+h9b8no+EPLgeD9DN?=
 =?us-ascii?Q?ZcA5FJ0WjqIslQfouLzRGtw8S1tUd6jmfSdkvGOljHKqXJKoMWLtn/DwkRmV?=
 =?us-ascii?Q?fPFG41ZTQvmfXFVWW17Hb30r/jwI9Yq3aUnBHuN9IOocs9JOhw4SMXX6cvJC?=
 =?us-ascii?Q?/hWhFFZU1OBC4ARui69+59Ov+Ez/QO8UgE3DTD7KFecHoiZ9QZLKsj2olDCB?=
 =?us-ascii?Q?kZkE0agzD8L+8znI90Uow52VqNEnfEIlapNm7Ryt64QTRmiFdEkZyOktZeXA?=
 =?us-ascii?Q?u1p/9ZJxqgeXKKq8luWOwqbecnBM/0C/wkRuuUpQqca7+JYYJtmof0wk7jlY?=
 =?us-ascii?Q?pJHFwVqlqKTBlB6/rcdBQdtR+6W9XaoPe1o99A9JdJOLKH478Do78+5wppVQ?=
 =?us-ascii?Q?V17m4P7ZmJIrJsvWPsrfFp5U5e4sGX/5tU2Zsdwt/hV8Bx++r23fWxUfRZb7?=
 =?us-ascii?Q?Pss4Rl226z+Txu1hx8/zhYK2lhh4XkncXYlxgg9/eEkYh+j+yUIBr/cEHHVZ?=
 =?us-ascii?Q?2+aMq379p7ZuGlJGSRACQ5i+XFCV0PVYcLCYpQRPFJn4CVeXvZGrveegFebR?=
 =?us-ascii?Q?sxLLbUXYGIWswmo3OuI1BZUdzexB7DOpNJoXI3aP7QIxsvOUsqTPcM/belJh?=
 =?us-ascii?Q?JDwYd5R8EI7fcklyryYNXK2k4e+zMJD1WGt/MAwFSk2wZjBf/TMGRiz/G9pN?=
 =?us-ascii?Q?KmPI59LMSKi91QZ6WLPMrKdpgdtLD7w29y8jx7V6JVOniFj3BIduyoWo/rRR?=
 =?us-ascii?Q?azFtBbzaQzodzY3OLqEJ6m/q1L/YraK0UiPi1lepKCurnmLr9DuLDxQhp+cK?=
 =?us-ascii?Q?PPq+vSWl4E1Cs7SVnAK5QeTwxlRoN7dTTBfZ/64w65uCfM4m2Zmt0ERQhE4z?=
 =?us-ascii?Q?zePwO92ppYDbrXfhXPAyWcjtr6Ws8XdS/M9rnZ/y84rK9fTp9kHNIMK9ZrAc?=
 =?us-ascii?Q?/VoumQ3A8o8gwvfbg2+ZDIqbkanrYyIVRuCOOABHjElwDpBXsys7kxw61mlz?=
 =?us-ascii?Q?DE19NHM1TvUyLTMu8vf2VbXfaj0DKbFr6X5m36LD05v6wnOzR8nhJO4TRfLm?=
 =?us-ascii?Q?rNCrCxsTaLKtEADTRJ/+j+aRvoSPEX+FibPBpxP6O7h5EwJfkGFoE/DlOfJF?=
 =?us-ascii?Q?o9aH2PXdr7iR/iRRYZq1PvgMuH0XqvKDCQ1keXGdcCVWeqeXx40mgcj8ZfaS?=
 =?us-ascii?Q?8fvUBHoUcWKaeDG/tUHNKYlz2JQ7sozja4NVF5rrX9MQLLnYgRL8HppJ6+hs?=
 =?us-ascii?Q?GoxKNwJlxI5gu3v1Wydn4n15T6KCiYZAs0Yhge1eEtuBwwjLee5GDwjX13DV?=
 =?us-ascii?Q?irMcSgqS0XrT+iM9xQXJEtvPSi9rO3/rAfA96HSE64zXHwAUl4Aj87c5uqFt?=
 =?us-ascii?Q?xGAVcw+2PLYTGubzeqcf+xSYCvw6mkukKbB/RyV5TqKGlW4y4qqewPhlaGzC?=
 =?us-ascii?Q?68zlVlyRvag6FxpCf4NF97ixinpub0psQoTLaLp7gOPNMVDOuVtBBezws6A7?=
 =?us-ascii?Q?+dmuNicIGzpFPw00pwvmAxdFFdQXTyfka2FbwHb1szok3H/yam+z3IsSc4EI?=
 =?us-ascii?Q?WYYOGhF82gc7/RGb6EaT9ZgB/IzTy7/hlKlNODpr8Ivq5fbKNkUKZKhy93Rp?=
 =?us-ascii?Q?DUsDz/OrnedMupJHn8una9E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2554EFECDA9B694E96857E270BFC05F8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H83wnFeIF4xtB1tQumVZPIHxuEouSckLi38bEPbVkZRItMV6CboUI189EOh/oMB1MJZVVHHJIq1Vz3NmsN01dAS2DPt/dxXGmxRvOHwaF2laHNZjSgrKM3+ZqfTd5H0ytY6uAuBUaBUNeJpR8coFzrFDvKYM/dXE8Xa4GrWxyGqAxDylLw4PBwcjjkdgFkz//mDl5QLzhlsYH/LMKAIaMX1lURM63Li0wfgPicRJD2a36UFOkQxpJHCwfPGLho+Eu82cdBwDfZ6ZWJvDYY6BJ37EzFXXIDtWvGA2apwWYWq0QEQOiqhp3QYILCmZdB34OrzvggudNP5coy9tVKkQSkPIacCBcf0BUvCseb86K6oUstGxYUAPt7+8wji9Y3nqfdkTUIbd489GPArFxrBWUwwi14tmluQuEKHhGdBaoS4FV/WhWdKc6ByN2Yp/ohlIlZ6tcNsYjYAgqeTmIA5jPSrRXMWA6sZyXGU6qhf0GRIX0XlUQ5HFvnFhBKlpW8xQlWSSLLmcwmqDDPI6WfADJmQBPO5IP7F+diLXACUtQTpesI+gBAWxfrb9OYKklY/BlJZEC4YSedeOLnsIDYFDJ0M7kAzsuY15zcNnkCA2hYDZoEOHqJHH2OBdN3sf9aX3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecffcf7c-9990-4771-8eab-08dd35d7bb46
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 02:44:43.2407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xhns7IoJYXy/NWd1DXXMFINXut0n/dsUT02f7AR7pDLPyHmv8ZXnluk6nZAjzxwKQ9vgJp/lGk3GkoaJFTq+JIMuiXyffkornaoHN6S4fxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8897

On Jan 07, 2025 / 14:19, Li Zhijian wrote:
> (Most of the this cover letter was generated by the chatgpt)
> Hello,
>=20
> This patch series aims to enhance the efficiency and clarity of the
> requires() by optimizing the way module driver and remove unnecessary '&&=
'
>=20
> Here's a brief summary of each patch included in this series:
>=20
> 1. **Patch 1/4: common/rc: Test `have_driver` before checking its driver =
parameter**
>    - This patch optimizes the `_have_module_param()` function by first
> verifying the presence of a driver with `_have_driver()`. This change red=
uces
> unnecessary checks and error logs when a driver is not available, improvi=
ng
> test efficiency.
>=20
> 2. **Patch 2/4: tests, common: Get rid of `_have_null_blk`**
>    - The `_have_null_blk` function has been removed since it duplicates t=
he
> functionality of `_have_driver null_blk`. This helps streamline the
> codebase by eliminating redundancy.
>=20
> 3. **Patch 3/4: common, new, tests: Get rid of `_have_scsi_debug`**
>    - Similar to the previous patch, `_have_scsi_debug` was also redundant=
.
> This patch removes it to ensure consistency and reduce code complexity.
>=20
> 4. **Patch 4/4: tests: Remove unnecessary '&&' in `requires()` functions*=
*
>    - This patch refactors `requires()` functions to evaluate conditions
> independently. The change aims to improve diagnostic clarity by displayin=
g
> all unmet conditions and their respective skip reasons.
>=20
> These changes should collectively improve the test scripts' readability
> and efficiency, making module checks faster and less error-prone.
> Please review the patches and provide feedback.

Hi Li, thanks for the patches. I'm all for the 1st and 4th patches, but rat=
her
reluctant to agree with the 2nd and 3rd patches. IMO, "_have_null_blk" and
"_have_scsi_debug" are not so bad since they need less types, and a bit mor=
e
comfortable to read than "_have_driver scsi_debug/null_blk".

I already applied the 1st patch (thanks!). If you agree with my comment abo=
ve,
rework for the 4th patch will be appreciated.

