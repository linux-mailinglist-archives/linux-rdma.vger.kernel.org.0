Return-Path: <linux-rdma+bounces-18278-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFu8LkCruWkhLwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18278-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 20:28:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9742B18A7
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 20:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02CAE304B834
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC72533BBCC;
	Tue, 17 Mar 2026 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+C6dtxq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6315E5DC
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775675; cv=fail; b=jCzDX5AcdKkKjR2N5OZehNEVcQNcNLBtVlsDuqOZ3buKjDpbHLrWtqwVZzwAxYLqH8+giEngrDGWHixO4DYVLgjMEOOED6sqWUOEXpTukoet0QYYJ4hfXlKo8H2HTmaMM0IUxPG6hhhKVUKGKA+ixSpzwONiH2+RK4taSO11QhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775675; c=relaxed/simple;
	bh=efa9OoyhN+CbLLDu3bYjXIYqJ8Ooo7NwYHp1LglqNOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QTG3vaZTQdYX3qkj37iE+FsRC9Hbi1KoHGMY/I7Q1HDZoIaEx8ncC5NTnsjhPUZo6PB0w5m22BJSx0mu+xs2q+mC1pH6T77ucDMzmUalbPCrdxGSF/uFRHDjlBGhKfpbut3zQF7SJthPnbanL+hWO/CgdSrCWd6iAf0s5CnPJPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+C6dtxq; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773775674; x=1805311674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=efa9OoyhN+CbLLDu3bYjXIYqJ8Ooo7NwYHp1LglqNOk=;
  b=W+C6dtxqJz2F5EPRX+Cje8iah5ATZrB5cITWyk+Jb4d0Onzb+EYt+Kes
   hhUB7ZJwP/QstFTJ8Wuhi1g47utGUmv/qu7+/i2zKwGWQmMfm1woPYkLJ
   WhbStU6iIjBkGEzWv3lxuOVSTSUZlGGG+R1HoPcectac/rfowJgpJKXwL
   BGaLoAjNjIkLgvhWkMbScjx5lH4CFLFCgT++e1BiS6UvXM54YL+XAAk1G
   KQjzNqbHIaL+TjyvWusym7LLalfrYQtPbgvFKOVz5VyOir9fH3GKxD5Ik
   67zI4iYo8KFEZUn4e+usmmBkWukJ9SxiRwJyGRdCey4cqETpNP9i524NM
   w==;
X-CSE-ConnectionGUID: QbG7n9XzQWudQlpKDOQmwA==
X-CSE-MsgGUID: lqxpzhtWRq2dKbZIBDNhxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85516428"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="85516428"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 12:27:53 -0700
X-CSE-ConnectionGUID: W+6lkV/aQbyIUmV9/9fpRw==
X-CSE-MsgGUID: Y4rsOuiMQt2ot8NRDb+tHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="218024221"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 12:27:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 12:27:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 12:27:52 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.37) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 12:27:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXs7Uo8eyLrf94jL9iOwxGE3leLZfbPie0f6JlxDUhqvX2jsHn9qA4J9N7MklhAMnuc1Nj4vMuez/SgWlTmUZi+kyJ0hKh58bzM4dnVzaAM4HJ83Er8IF+Ii02vJid6e/P5ArnFMD451hc076D+lseJA/F0GWEMGVvrjh8h9ftwCBeV4DTmvCCZ+CqWk70veSkUo6yLCy3oMHi41wPHoxycOLOJBKtwkW7laATBSmwKfspAfFvyv8NM21vlq0hCxrA9xxKRjDrz5E3cDD+aUW3+mt6qk1lOLv49ov/EC08CbT2yHqFs6WspeoZaN9YL31SZI4DWVuTmY1r0r4bnhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtQ09MilFSvh6E3bUqxfIeoKMBu/pVg2Zs/IRFI2bKs=;
 b=ggS9IWgoAWmCu2nuHHOoQDuztmwg/6Oo76/aGweY1QOLjYVlfoqCtDSBi988isCq4hktWCFyewcAy0MFXlr6827dA/dCVnjOYBLi+QxNcWDlp82ORp3vv7SIe8g0k0etQw0XcKHwEKQzawuWSG/DZHMyAvAoBgKYW6NO9HIwqfYVTnANbOKz2vMo4id+dVt0uSpDMWi3BJ9/RN0w/apetS+Ivq3GkIKW8dfCm1241qXPS0CgEVUcKHPk4ZBONzEQeSkWazsjr5tICT2fbRbIOzxzneMuCU4217oOTYpBeoQv3H+kRalnkED+NwsV4VEimRe2r+3rgR9BrNHNgtA3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) by
 CY5PR11MB6390.namprd11.prod.outlook.com (2603:10b6:930:39::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Tue, 17 Mar 2026 19:27:49 +0000
Received: from DS7PR11MB7740.namprd11.prod.outlook.com
 ([fe80::ef15:dd09:86c1:9979]) by DS7PR11MB7740.namprd11.prod.outlook.com
 ([fe80::ef15:dd09:86c1:9979%2]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 19:27:47 +0000
From: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To: Leon Romanovsky <leon@kernel.org>, "Czurylo, Krzysztof"
	<krzysztof.czurylo@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [for-next 02/12] RDMA/irdma: Fix data race on
 cqp_request->request_done
Thread-Topic: [for-next 02/12] RDMA/irdma: Fix data race on
 cqp_request->request_done
Thread-Index: AQHctXRtxKL21nQkEEaI4cjbI8Kv4bWykvsAgAARR4CAABMmgIAAY13Q
Date: Tue, 17 Mar 2026 19:27:47 +0000
Message-ID: <DS7PR11MB7740083B561AB5756A48DB6FCB41A@DS7PR11MB7740.namprd11.prod.outlook.com>
References: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
 <20260316183949.261-3-tatyana.e.nikolova@intel.com>
 <20260317111230.GW61385@unreal>
 <DS0PR11MB7736961A569FE56FDB09631EEB41A@DS0PR11MB7736.namprd11.prod.outlook.com>
 <20260317132253.GX61385@unreal>
In-Reply-To: <20260317132253.GX61385@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB7740:EE_|CY5PR11MB6390:EE_
x-ms-office365-filtering-correlation-id: 04f22514-0745-473e-6673-08de845b4590
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: aSQE9lCQEdYHuLpcBbPjNyKBxGlqMR6W1aU3WvO2uQRo1f9+XrDO7QSmE5TPWha9fMSevTd6kOHWCmi4Basxh3vEgkeihIkRgxcQKF9AJOcyTDSIg1CubMIp+ybwdcb7wkSg1npmST4BxTGE1QUTOcDNT2Img4J0xizqRZw/7knlIi0wYmtUtdItlZdRWk4ZxenhX9TsOWuc2z4wfJ9D2i7Dv5zGZCthPqoI6POdEjg+rgDr2fcT/j3uwuIsWThVqoSXb4JVOwo54zoHC2EF3oARMRwWehZRoaDtgd31qrSFtOfsZ3n8EptG4oY8wNmExVRE+nEjq7WrfeoHO19w/eqnNjJyet3P1Ur14LS1cPkxlhP2WpMM5U3N5j2rCgf6D8FvjOfcZwi1ld9JNVEyVC+XxWESthjZpUIaVkTGKDHf9lvGxaiZMP9rzzJgXIHXRY4DqzoSSByl74jH4G1y6wHyDT2xxVfdpSF+rYBECJJd5G30EfTw1ILsEPraQtVE5s1fe658W/pC9B93Ma94fJzpaWI8RJxY6AL4897FDYOaRlNWeBHPX/ldcmN3PhfT+9npye2BKNRtuReH9tdTIZG/AQGsYAsqksnteqHPtPn6wTeEhIza7P+11OIUczoy8CIJ8VM/2TnyTZ/9NsDGGOr1eI7aNE6Q6hkLc8cIq5uMjkNLs9nUD+PrViXS6EI6XFklepvydqPHowLWiQTfiGL8jXV/L0vugIGQXD4awdPJOiMCBxKtZsvoyfHYs1qDIZWF0/FnPJHg8v6vncjwDgtROP+K/X6mAG3cUN3HqfI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB7740.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sSHdNacaCK6eAGGdbRjAqqcloIj13x2KgMBpv42ZJzCUPheqzg7CE2b/9vNL?=
 =?us-ascii?Q?yo50KlGuaT6l4c14zqfx80Wb/2nvdBE1HpYw3hACmirzdV3HdfphdxcMva/+?=
 =?us-ascii?Q?WAQpFrXHzAOY9lUJGOKhIFi7+hBL0Tnr28tD/X+1fXxfA9l9kEI6caJCMygX?=
 =?us-ascii?Q?U1dXAAYPwEpwavfCxbPJ6CVu6GEDl0DYaTdUn1JXM8qVKcybjHgLxCJvaTQD?=
 =?us-ascii?Q?XqNX2/cO+sPHr6s9RRJC83cZFtxWB2xAF0JJ2GocMKNgXnnYrNN8VBk1Zfp7?=
 =?us-ascii?Q?ytA30VD+1iNR42nvmSlqy7K1QMVdDGCtOlBYQcm4nrs+sVRbm/s46rT2ErVs?=
 =?us-ascii?Q?b6WtEuZqsmVHKqPe/7dI71QGMcKJFPx4eDYGtCdaIuAm1FrOpKMy5jv9inzC?=
 =?us-ascii?Q?HR9F6UVd3LOUJIEci+kpfA1v36lLeOZGrW0pzfn2VkWBFhIOj71RNFkLfGT0?=
 =?us-ascii?Q?W0e+zwAkvH0Kml9IrNMnrFVkKEwDwUSigisMXuVh58/VXltWUDQxuK3EoMRB?=
 =?us-ascii?Q?PLFLpe39IYrSSsjhtMaRD9enO7LUPziq2+wpaYe6IfL0FaDTxkNw9Yp/z8Db?=
 =?us-ascii?Q?jNqEcCl/BvKke1x/ruStIun3TbhXApJRpRzgc4NjkifNYUtVKshzeBORQONt?=
 =?us-ascii?Q?T1kpBz60FoZi6VKFsqdVZhIJURIaRkwxR/f2Bv/u+PYulDaYqVRIXK/TjG36?=
 =?us-ascii?Q?nFaRxzOZW007xdIxELaq/YWdrzanxbP6IQJwwD6pDyP6cPqgtgoAibi2G7BO?=
 =?us-ascii?Q?SRQW8Iq9nLoIDWBIH9w4SPaXwTw/8q+3O8O5ExjQg3ZgEIZJ0BlGImkhzkeE?=
 =?us-ascii?Q?4neGoYoKeXRxf9vkrqR+R9QcwMtfhQqdBxjBMg6N1sOdIkW1iFgigz41JGkn?=
 =?us-ascii?Q?0X176EpSX9mVsVpelo7ARbZ5qPMNVAaIKiNOulW6vwFCKyhfO/Sz0I4kEiTx?=
 =?us-ascii?Q?inrSsp+BIwD9Rmz2fcbDH2ClTvuG24rNrOWL8MFQvaK/qJ4ErElg9C6sVLpg?=
 =?us-ascii?Q?0IEGJ789bC3yvGa4oFwkODvzXE3KiZDGelxcWespSMVSS+4zPkRrz7gzYtqn?=
 =?us-ascii?Q?KA1LYhTn4gMrnzhs1F1EA5dI8PIteJh6X+BIDQ+r0k7lvzQq03+27zuMzU7s?=
 =?us-ascii?Q?Q1Js7jTiMTDYto0IWKz85J4sS4wJmF+w8Z2SvH16kef10IXio7OXIa/0nMet?=
 =?us-ascii?Q?UwlTvd2cClKlMezogfBaMtDn5qFDx5HjyySq3TGRUvJUDk8z5aTdR42AeoqC?=
 =?us-ascii?Q?PTMEUZCDc1PbcszPIpxmxCMglCUHpts+9TCC6/ULF2LecJx866dIi8rNVT0Z?=
 =?us-ascii?Q?cvw4Y3BkNhjcdtvq2GGfGQ5IyWuoAC2gN0W4yuWXVmjsAu/hmkKVH2FrLnUg?=
 =?us-ascii?Q?fjCMwnLS/vUJTNJULa718qp8X6I7s8c6XJ/wJhdtbDOpuu8gIJGU2B94LzQG?=
 =?us-ascii?Q?c65h/sf68ggguWGq+B1/Z//chC6+YgFugwtpi7dcp1Q6SbzlePS15Z1idyFG?=
 =?us-ascii?Q?JaTRGbjqt83L2S5d83IElCFnOPw3z+aNfLqV4Equ+vkOb5bxR4hxNO/8r+Zr?=
 =?us-ascii?Q?xw7oZkg7v5jC3dHawc/9N36Iz3qpLCgtFGCCRLeWv7dPSwGxDsXjzbvrorK6?=
 =?us-ascii?Q?CzEI5SqUMTuJnUvlE3JpnLLYWwYribKv0Xse/D7SAY8cgO1ElhFQD/p6JZoW?=
 =?us-ascii?Q?WCCn4QKWFpqgMHqLYCBC8ym7IttAjA+jmudXu6DsjWjHJlJC3X5JsYJuD2rm?=
 =?us-ascii?Q?ZFmDxVu8mA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ejeL9lJywd94N7+3/bbj+xH56HT+0jEuCOxQ9KrR3JqmdjnnAUM3o29Nsb3xM9VK6/KI7v5haZuy+euXCCL4mBp0qFB3qqeIu2T8cZ+cvIJbUlXz/0I6RGhhxQ4PsB3JsEeXjL7DqWFWD1PXgEhIujzeZ+Pwzmn93OYCqFJt1Tp7ABbWs8PCHfCR3NzTOic6FfEs+Xi1UADArIHLGT5pmBvQwtFYRjSmbVUYI1xVDfAaUD5g6aZKsU99lt+Izu1eJmJQsKHF0I4DLSx0BI+rVhlO1TwRzNMj9mpujI28YWsbkJFo3kECSljCYvcJIKCB9fzLktcI5kQTnXdM8KTUoA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB7740.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f22514-0745-473e-6673-08de845b4590
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 19:27:47.6926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6oV5rJG8VpeOfI5rY1J1O27VV83gsErAl4QMxW3+frcC9juKdtVm0uSCdnDRHvQwmnlUprZgWLR5Oprcm7LkjH+Jnm0XR9SvSUl7+ioJNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6390
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18278-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tatyana.e.nikolova@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0C9742B18A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Tuesday, March 17, 2026 8:23 AM
> To: Czurylo, Krzysztof <krzysztof.czurylo@intel.com>
> Cc: jgg@nvidia.com; linux-rdma@vger.kernel.org; Nikolova, Tatyana E
> <tatyana.e.nikolova@intel.com>
> Subject: Re: [for-next 02/12] RDMA/irdma: Fix data race on cqp_request-
> >request_done
>=20
> On Tue, Mar 17, 2026 at 12:14:21PM +0000, Czurylo, Krzysztof wrote:
> >
> >
> > > -----Original Message-----
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: 17 March, 2026 12:13
> > > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > > Cc: jgg@nvidia.com; linux-rdma@vger.kernel.org; Czurylo, Krzysztof
> > > <krzysztof.czurylo@intel.com>
> > > Subject: Re: [for-next 02/12] RDMA/irdma: Fix data race on cqp_reques=
t-
> > > >request_done
> > >
> > > On Mon, Mar 16, 2026 at 01:39:39PM -0500, Tatyana Nikolova wrote:
> > > > From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
> > > >
> > > > Changes type of request_done flag from bool to atomic_t to fix
> > > > data race in irdma_complete_cqp_request / irdma_wait_event
> > > > reported by KCSAN:
> > >
> > > Again, this fix is wrong too.
> >
> > Could you please elaborate on what is wrong with this fix?
> > And/or suggest how to fix it properly?
> >
> > Please note 'request_done' is _not_ a bitfield and we only do simple
> > load/store operations on it.  There is no RMW.
> > Despite this, KCSAN still reports a data race on it.
> >
> > Honestly, the original idea was just to change the type from
> > 'bool' to 'u8'.  This is enough to silence KCSAN, but it is
> > not clear why.  Perhaps it indicates a bug in KCSAN?
>=20
> Yes, both u8 and atomic_t behave the same, they can't be interrupted
> during read/write. This is why KCSAN doesn't warn you.
>=20
> > I mean, maybe the report below is a false positive?
>=20
> Sounds like that.

Leon,

Are you okay taking the rest of the patches in the series (they apply witho=
ut the two KCSAN related patches) or you prefer that I resubmit the series?

For this specific patch, are you okay with dropping all atomic changes, but=
 making request_done u8 (currently bool) to silence the KCSAN warning?

Thank you,
Tatyana

>=20
> >
> > Thanks
> >
> > >
> > > Thanks
> > >
> > > >
> > > > BUG: KCSAN: data-race in irdma_complete_cqp_request [irdma] /
> > > irdma_wait_event [irdma]
> > > >
> > > > write (marked) to 0xffffa0bef390ad5c of 1 bytes by task 7761 on cpu=
 0:
> > > >  irdma_complete_cqp_request+0x19/0x90 [irdma]
> > > >  irdma_cqp_ce_handler+0x22d/0x290 [irdma]
> > > >  cqp_compl_worker+0x1f/0x30 [irdma]
> > > >  process_one_work+0x3dc/0x7c0
> > > >  worker_thread+0xa6/0x6c0
> > > >  kthread+0x17f/0x1c0
> > > >  ret_from_fork+0x2c/0x50
> > > >
> > > > read to 0xffffa0bef390ad5c of 1 bytes by task 28566 on cpu 3:
> > > >  irdma_wait_event+0x242/0x390 [irdma]
> > > >  irdma_handle_cqp_op+0x93/0x210 [irdma]
> > > >  irdma_hw_modify_qp+0xe3/0x2f0 [irdma]
> > > >  irdma_modify_qp_roce+0x13df/0x1630 [irdma]
> > > >  ib_security_modify_qp+0x34a/0x640 [ib_core]
> > > >  _ib_modify_qp+0x16b/0x620 [ib_core]
> > > >  ib_modify_qp_with_udata+0x3c/0x50 [ib_core]
> > > >  modify_qp+0x6e1/0x920 [ib_uverbs]
> > > >  ib_uverbs_ex_modify_qp+0xa6/0xf0 [ib_uverbs]
> > > >  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x16c/0x200
> [ib_uverbs]
> > > >  ib_uverbs_run_method+0x342/0x380 [ib_uverbs]
> > > >  ib_uverbs_cmd_verbs+0x365/0x440 [ib_uverbs]
> > > >  ib_uverbs_ioctl+0x111/0x190 [ib_uverbs]
> > > >  __x64_sys_ioctl+0xc3/0x100
> > > >  do_syscall_64+0x3f/0x90
> > > >  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > > >
> > > > value changed: 0x00 -> 0x01
> > > >
> > > > Fixes: f0842bb3d388 ("RDMA/irdma: Fix data race on CQP request
> done")
> > > > Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
> > > > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> > > > ---
> > > >  drivers/infiniband/hw/irdma/hw.c    | 2 +-
> > > >  drivers/infiniband/hw/irdma/main.h  | 2 +-
> > > >  drivers/infiniband/hw/irdma/utils.c | 6 +++---
> > > >  3 files changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/hw/irdma/hw.c
> > > b/drivers/infiniband/hw/irdma/hw.c
> > > > index 6e0466ce83d1..3ba4809bc1ef 100644
> > > > --- a/drivers/infiniband/hw/irdma/hw.c
> > > > +++ b/drivers/infiniband/hw/irdma/hw.c
> > > > @@ -235,7 +235,7 @@ static void irdma_complete_cqp_request(struct
> > > irdma_cqp *cqp,
> > > >  				       struct irdma_cqp_request *cqp_request)
> > > >  {
> > > >  	if (cqp_request->waiting) {
> > > > -		WRITE_ONCE(cqp_request->request_done, true);
> > > > +		atomic_set(&cqp_request->request_done, true);
> > > >  		wake_up(&cqp_request->waitq);
> > > >  	} else if (cqp_request->callback_fcn) {
> > > >  		cqp_request->callback_fcn(cqp_request);
> > > > diff --git a/drivers/infiniband/hw/irdma/main.h
> > > b/drivers/infiniband/hw/irdma/main.h
> > > > index 3d49bd57bae7..e22160e2ba33 100644
> > > > --- a/drivers/infiniband/hw/irdma/main.h
> > > > +++ b/drivers/infiniband/hw/irdma/main.h
> > > > @@ -167,7 +167,7 @@ struct irdma_cqp_request {
> > > >  	void (*callback_fcn)(struct irdma_cqp_request *cqp_request);
> > > >  	void *param;
> > > >  	struct irdma_cqp_compl_info compl_info;
> > > > -	bool request_done; /* READ/WRITE_ONCE macros operate on it */
> > > > +	atomic_t request_done;
> > > >  	bool waiting:1;
> > > >  	bool dynamic:1;
> > > >  	bool pending:1;
> > > > diff --git a/drivers/infiniband/hw/irdma/utils.c
> > > b/drivers/infiniband/hw/irdma/utils.c
> > > > index ab8c5284d4be..f9c99c216a2c 100644
> > > > --- a/drivers/infiniband/hw/irdma/utils.c
> > > > +++ b/drivers/infiniband/hw/irdma/utils.c
> > > > @@ -480,7 +480,7 @@ void irdma_free_cqp_request(struct irdma_cqp
> *cqp,
> > > >  	if (cqp_request->dynamic) {
> > > >  		kfree(cqp_request);
> > > >  	} else {
> > > > -		WRITE_ONCE(cqp_request->request_done, false);
> > > > +		atomic_set(&cqp_request->request_done, false);
> > > >  		cqp_request->callback_fcn =3D NULL;
> > > >  		cqp_request->waiting =3D false;
> > > >  		cqp_request->pending =3D false;
> > > > @@ -515,7 +515,7 @@ irdma_free_pending_cqp_request(struct
> irdma_cqp
> > > *cqp,
> > > >  {
> > > >  	if (cqp_request->waiting) {
> > > >  		cqp_request->compl_info.error =3D true;
> > > > -		WRITE_ONCE(cqp_request->request_done, true);
> > > > +		atomic_set(&cqp_request->request_done, true);
> > > >  		wake_up(&cqp_request->waitq);
> > > >  	}
> > > >  	wait_event_timeout(cqp->remove_wq,
> > > > @@ -610,7 +610,7 @@ static int irdma_wait_event(struct irdma_pci_f
> *rf,
> > > >  	do {
> > > >  		irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
> > > >  		if (wait_event_timeout(cqp_request->waitq,
> > > > -				       READ_ONCE(cqp_request-
> >request_done),
> > > > +				       atomic_read(&cqp_request-
> >request_done),
> > > >
> msecs_to_jiffies(CQP_COMPL_WAIT_TIME_MS)))
> > > >  			break;
> > > >
> > > > --
> > > > 2.31.1
> > > >
> >

