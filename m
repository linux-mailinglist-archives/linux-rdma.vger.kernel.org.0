Return-Path: <linux-rdma+bounces-16274-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IMUFRzwfGndPQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16274-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 18:53:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BC2BD820
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 18:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DA59300DF53
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 17:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50976366544;
	Fri, 30 Jan 2026 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mO5faH+L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0E3542FF;
	Fri, 30 Jan 2026 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795566; cv=fail; b=BgQefZFj2GgZ9Nz8bb5mAbPXfi3wX6BsAcuMmfyIoDXdBgQXIIiKCN3HlXcwSSNK1quiMaujDhkCCHNlduw6XQdXkGZ2DjfL88y0GiAaurCMOT99dyqS010uzjUlf4GYuWXe1mlhvN4zdDuI7vpvCoGxrax1BLticMv5GA86qS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795566; c=relaxed/simple;
	bh=Hm+y0E0cKrZmc8lYrRYhYFnbEhZiDDWphh61DbtIh9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gasD9X5Cbx+JHd23+y0946ydOETz1gJ95nXLWRDiCTHVyjMCH6yGu9LOMj9SSmcQBLOTh39GCWI+c/pyX2jpu8PeadXqHP/DNwVg2AM3nt/rF184J2Db/O0fOPvlGkvIc/Dv6symklrvzCeTlgLrCURHXVWXP0p+WtE4LzgBSUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mO5faH+L; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769795565; x=1801331565;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hm+y0E0cKrZmc8lYrRYhYFnbEhZiDDWphh61DbtIh9Y=;
  b=mO5faH+Lmn/7UT6Q2NZm+Q5Mj86+Cm5PST0qvd/LCZx0ddgMaL4O2Vfp
   628PeAU5E+uhTd9snyc+EnZLQrwD0bmLrAKwKRvYKzcD+TKdLvwoYPprd
   lezcheisT7qdqQZaj3EaoW6hzWZS7fU+QbND6xk932PtE37iG452xIQWU
   ICrCjzeY1LRbpkVVFvJ2uKVLJYKNf5Z/qpf9g05HNsjR8utQ4FaZxlXfy
   Sp57s5Jqt4Hi8+oMibxhoEsnNTdzG8CrJ6DGUjpb6gsjlhw7sE+L2c6g6
   2NBSKYFo8LPKvxi0+6bb0fcKAamHa8/Oo0Ef7wmvv2NuFuShKAeSBH9d3
   Q==;
X-CSE-ConnectionGUID: TYnQcCnBRTqqqhDKm8zNWg==
X-CSE-MsgGUID: Jxbekmg4T5CStl0DEmocwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71086755"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="71086755"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 09:52:44 -0800
X-CSE-ConnectionGUID: 4DR/xqBWRsCDJgMsx6xE/A==
X-CSE-MsgGUID: MBCi4KpCQduiQUijK6kH/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="208820248"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 09:52:43 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 09:52:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 09:52:43 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 09:52:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYB6ptFmAErD+tM2tBGVV71ycJ+5nhPUDTpeVsDJVEv8TaRY+W1aoBmamoVqxmVjxfYutCW5hhp6jS15JP75E9z6c9e8JlJh9aDgF0xCSF5wOOzeWgM+gEUojKFkdgraSF/9rk5TIpnHFs0Jwg0l/zGRZakl/ZTGA00rCloSSJFuHTaHMt3KuZvr84ENLBdxEjny48z2wFfBE1M9llmQFUWcf4AMRB93m91CZKOOeizT2/1Gnb7aa+6a93W5jR96vEhABdOWGCtAI8JdzSXvNdOoNCHVCLuPm66VOeck4Dav+/FBqf2BqUPoziD5df3zn2s7hx8xO7zkVUTLvVhGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhSJlBXZBxtBnGMul8baYkQYF2qRe5u6P1mwg0y7WSg=;
 b=mYel188TZDKvVx/axI/uc9NnQg1bB46q2bbaPNSlnp9hN57Dt3WUcedFSwAxa4lsNwua3PO19O/B9Tl1DfoGFjiK5FpsLnj6CSixwOVt1f6aqoxbfdTmXpA45aKS0iXGrknk2r3rtY7lhYkEEGiCvHVgsZg4j6DnL1IisEY6wb3NxPqjm2D19pDgPe35vKkMGfDhvSnrTVmLJl7FyTaqKNQt7lwbvFj63PtLDBkHIuwjNnG0C/PTFamg6fc6CwkOhnSBNYE5Ww+HSaStqZX16l1pxlfMA6whhQFA9LtVhllnXYD2OfC4c9tvugO21r1PsRP1lFe1jId4E9HVyqFQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 (2603:10b6:518:1::d32) by DM4PR11MB7277.namprd11.prod.outlook.com
 (2603:10b6:8:10b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 17:52:38 +0000
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::f7b3:4461:b4f9:1a0]) by PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::f7b3:4461:b4f9:1a0%5]) with mapi id 15.20.9564.007; Fri, 30 Jan 2026
 17:52:37 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Jiri
 Pirko" <jiri@resnulli.us>, Jonathan Lemon <jonathan.lemon@gmail.com>, "Leon
 Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Paolo Abeni
	<pabeni@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Richard Cochran
	<richardcochran@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v3 8/9] drivers: Add support
 for DPLL reference count tracking
Thread-Topic: [Intel-wired-lan] [PATCH net-next v3 8/9] drivers: Add support
 for DPLL reference count tracking
Thread-Index: AQHckgkvgqtkoqZx7kiz4M+bBu1FrrVq/kHw
Date: Fri, 30 Jan 2026 17:52:37 +0000
Message-ID: <PH3PPF7A88A980A191EB58AD297491FCC18E59FA@PH3PPF7A88A980A.namprd11.prod.outlook.com>
References: <20260130165338.101860-1-ivecera@redhat.com>
 <20260130165338.101860-9-ivecera@redhat.com>
In-Reply-To: <20260130165338.101860-9-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF7A88A980A:EE_|DM4PR11MB7277:EE_
x-ms-office365-filtering-correlation-id: 8b58fe07-087f-4abe-c093-08de60285acb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?GePM7VeQDkuJnsjW5I67oK/HQpheRjUe42SmZetZsF+ERMBCIafCIBLTpNCs?=
 =?us-ascii?Q?IL3+S79TtmeVIZEgeyGREVjHpQmS91nKd7GfQ7oTTx+VbWQ8d1nn4dVv398w?=
 =?us-ascii?Q?bTXJnlx2Muyyq/J1lQIFftDGVftwOSt2FiDXbW1gZO2VXt2NyapE6OjEX3xM?=
 =?us-ascii?Q?fLhpHt+Tg4nPPunIqSSsK8JgF0XJ+hmieVmXuQSnlx+rCZksqQVqXNXLADej?=
 =?us-ascii?Q?PTi6rY4Ucjj776ejaTw0Y48P2H/Jci5zwOdpg47i945iR/yrSyWC3RauwhIB?=
 =?us-ascii?Q?TegCp21rITWrAAJOzTsWIk/DDlC8B5bPeFt0OT2zRe2bm2t35PMRZAicLC3C?=
 =?us-ascii?Q?2CQcO4CuhV1KxGAfbMwRDG9u2H2wjyzjf1Z7oAnc/Cdlay7VLkz2NX3Qmpby?=
 =?us-ascii?Q?AajEamqZAWTQcahaNfaOa8E6UB3RYXBPA1RZ5rOrKPDcrZeYLrZm+rqDzZOu?=
 =?us-ascii?Q?UOtiyUQpoXqTnYCQavqzqlxtaLZJeTq0whLOIt2hQ6Ndt9F/oceSHfIFebuL?=
 =?us-ascii?Q?488P1wK0DEcu8T5sGQc1M3a+mqOUSAsoXkT8k+kqQtL5dZ/yTHF9JN4D/V0P?=
 =?us-ascii?Q?ewLHDYJ/lSlPSE+zQsADbuYKtCFloPE61Hy03IjXRzILKy9CQCsCefauAPKp?=
 =?us-ascii?Q?N0RYhYefGNBQ+G0GUTXqoPbcusBz/PElzdAJE1PFhxsucbWhTfH/46ZF/0Yv?=
 =?us-ascii?Q?kgRc5s+PR6c3ONBPfc68gWtIWvia0MFOv8HrzJqzzPjCxaTHwFWAc4eJf+yb?=
 =?us-ascii?Q?KVUgESIxC4juP227mFDyLivgX5SKpAF2oXhOF9SpIfN8FxkJPLR23KnWJk3X?=
 =?us-ascii?Q?JK1BzyQKvVe0F08ZnwFWRdHAO8b59WftMgSgusNVRXKiXvUKuQlSG8KrIC3L?=
 =?us-ascii?Q?cJxtzy5PeVUt+QhgABAMTo49fwTAIiyX1MuiwW7PUiuyJE9STgMsUy0zNThu?=
 =?us-ascii?Q?Egcd0/qCQv44vqvn1pWXb2OYkOR7YOudOrGLoFT2uE8yQnGMz5yIg5ijGB3y?=
 =?us-ascii?Q?qb1kuf266sUY48cejWkb94IVkkud46WMoytSbzGN76Xj1eqknY+Co8hOIukp?=
 =?us-ascii?Q?eBvJn2DbrACTjknpuPuDC/x0wBwickjoXXCwvRunR5MOEUnpGyksyNLKbRbA?=
 =?us-ascii?Q?+r0Ax2wmE5+kBd46Yu79plcghOOhQww/ugae5FphOC/jnUCZIHI9hf3iJbU4?=
 =?us-ascii?Q?5n52+rt1sXU2YqprBD2BpYh2oRYkbALAAk4IUwpuoswl44ZLwQMtbndLFB5M?=
 =?us-ascii?Q?BQKVs4Y4Aod+A+gwMZ9jADuoanTcr5lyVXmsPUQOBeakARKt/COrP+gonKQp?=
 =?us-ascii?Q?ZN+Nx6LI6OCSjTNp4jXPOShcnojs2qYMpL8POqV1PRylSAnUqzCIEvLPGIx6?=
 =?us-ascii?Q?47WJBSiY9X/x+zPjB26U8LznP78xHqNROcaRIAPDLuGolxXXKLPruZ1XDrOz?=
 =?us-ascii?Q?PQqoGkKz6rO2kPvyZwQPGIXUbMPf1EiD+EXaLptqvotpNa7vF41tTGo/SxZ5?=
 =?us-ascii?Q?y2Q9iyX2O7jnbv47FUihoDgOK6Vy+g51MFl72PIzFjME2VUqbSW88s+0MgF8?=
 =?us-ascii?Q?bXGrPJnrBfcGGeOeO19ODd4kGWUbc89D4JZ6ZW+taXqdXazFpcgrmQaEhEf1?=
 =?us-ascii?Q?4W9uGmLcxRSupzdO30oyucM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF7A88A980A.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fBWwxp81auth46T20ewAwW6o+B3va1lcnEIUcWMusI2vWZerjpuW6pv8zqTg?=
 =?us-ascii?Q?y/iqdJr9Dz5bZF5EuksyBKThuYa/W0qeYLkDssc/IY5BqKT9AqIeOtzccg9b?=
 =?us-ascii?Q?nAHF1fIesA4i4hhe4DbP62dnb+dhZrsfC8u16ZjH58ztKgxP6xhM/eExjQQb?=
 =?us-ascii?Q?GO2EFXSZX25wA9HPpUldeA0Oq2IlDLsY/Yt0XQlBmBKFVxofUUDU7uMf+LtD?=
 =?us-ascii?Q?6nE4oHxyUlUXiHozWlLELDtLpWJdZuia2jWINoU3NTawTFfz+q5Gdk+gp80g?=
 =?us-ascii?Q?/NaM3GYwPK9yuj0n0j5wHcUc3q6PlL1SYWq0r3j57GZxtJRciLNL0xXDg08y?=
 =?us-ascii?Q?xyP8h9CfyUS7xUo/fMW7QS+pe9YqVUoxrht6Fvt2BN6k/Ot9BawnsSUEVamC?=
 =?us-ascii?Q?aoSfrDBIaE0m7wLMOHyDuTDMNFOQkTe5vEf+tMljJxQIfLkZTyjM1VpIIINo?=
 =?us-ascii?Q?zjxa9M9mrebBie1PayKdktebrKlICqLvxGvE/Hn4T6STUgDDtkFi0ta1sAtm?=
 =?us-ascii?Q?+O/y6M4+vyoPf8TqfKjslZNn7SbMvQrv4Z6rdWpnuuRnsrg4goVIeDa8R4lb?=
 =?us-ascii?Q?vrW7ILp7iY2QOFfsow5Dk33XD+GFpuYuUmU1o545uucesRyR0M1GYYvTiMBe?=
 =?us-ascii?Q?XcuB5qN7tpKofkN3mTsYkYiltGI5q46bviDpKG8XH4huW32iAGtml8oY6kGT?=
 =?us-ascii?Q?ya4PTfQZGVafZ6YTHQBkX6stWn7s5fwqBvBv/zEz6fp18k9OtYWePOv8wL1g?=
 =?us-ascii?Q?IuZ63cQAyaREbSxRmaJfQ5vP8iaOCxD76IDUEmFEvgi0kUQk1YBVtK4Z/5uh?=
 =?us-ascii?Q?Hv+4HR2R9bHtOt0eS1+vkwsRjpfniMJAxMMb1ykcml4eBjPi+aX8VyWQ9tLl?=
 =?us-ascii?Q?Y4xv2U1HRBioaBEjfpwO0NP0XeANtH+Q/Od+BNl3rKAbsZ5peSb9t3+rwmis?=
 =?us-ascii?Q?qsKXttasyu47rhrSI8Vut1q6vWp6R0vRhY9mnDz04EGZtr9QOyMdJmE5Vf1Q?=
 =?us-ascii?Q?kAUAEGtto7/oNP3cdIuvIE0UHFf4qU/r9MM3+92C0FuBUf2wjSpJ99OW7UVb?=
 =?us-ascii?Q?7P3Z7qY+ilNtOGPvdmkQbgGInJMM4xWUJZMGpFYsMUDmJoL1jrmr5UxK2n6h?=
 =?us-ascii?Q?VvdW4nPKsgUqSSourckrqKWdu108+x7NDLtrZct550IOgT/HMwkiyUcH8Kua?=
 =?us-ascii?Q?HgKj+kTNIjVDVy55dEhUq/Mmrfe3VCPthaI4fQGTLyNL5p2BMPkjGSnk7ANP?=
 =?us-ascii?Q?aZW+hibLx3sXjhsgjV9WQMY/vjlf+9bpS+y1OUeWYCQpiOmw64Q+LdS3giAn?=
 =?us-ascii?Q?CmX/2iLe9de42w/Va/lk48zr1Bs0UM2rnyqhmGNrSymKH54j/lIuRAo4AAoB?=
 =?us-ascii?Q?hZNDdLNNlnhZg9S1SL2SyyPHH/27LsgbcW6GJhDzXpLQVBruxRLvQnoKu+D0?=
 =?us-ascii?Q?hS9mJiIq3AwQztSa9zvgrSbiXXQq0/dcSEOTqhG1Q8OOxa0YTEOgITKWfjzm?=
 =?us-ascii?Q?AFDfGNyimmI+mthH/7eEktt+L4oZY+B6iES83dWeivyPWLtDm/kCQOOmCgCj?=
 =?us-ascii?Q?rxKX0M2B36jdzKIzXoYumBWa/YbxpcnQ/g3thVIHraGwZL8RxL+0DqtkMakT?=
 =?us-ascii?Q?Nv4YfeAT9EstDGa5D5H41O6KUIfpRUIUx21DvG+7eRPgwNd5l1prYi/stz/N?=
 =?us-ascii?Q?/iBPKsmuoal4TZ1jiRBvd3/lieLESYUfUDO4fbc6cnas5ePTw9VnQEVlFC/l?=
 =?us-ascii?Q?j04Xb6oPug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF7A88A980A.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b58fe07-087f-4abe-c093-08de60285acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 17:52:37.1084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +11pgpFjlgxi91ICGnogO/eIgbgko384/5q5A9ZmMXpIHHJ6FNn4ckxEEI0sCRyoc4B8bOZ3KzbVCWRJZEQa0yUQqsprPZY8sr7ZmLK2l78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7277
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16274-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,redhat.com,microchip.com,linux.dev,lists.osuosl.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:email,nvidia.com:email,lunn.ch:email,osuosl.org:email,microchip.com:email,PH3PPF7A88A980A.namprd11.prod.outlook.com:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C7BC2BD820
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Ivan Vecera
> Sent: Friday, January 30, 2026 5:54 PM
> To: netdev@vger.kernel.org
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Jiri Pirko <jiri@resnulli.us>; Jonathan
> Lemon <jonathan.lemon@gmail.com>; Leon Romanovsky <leon@kernel.org>;
> Mark Bloch <mbloch@nvidia.com>; Paolo Abeni <pabeni@redhat.com>;
> Prathosh Satish <Prathosh.Satish@microchip.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Richard Cochran
> <richardcochran@gmail.com>; Saeed Mahameed <saeedm@nvidia.com>; Tariq
> Toukan <tariqt@nvidia.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Vadim Fedorenko
> <vadim.fedorenko@linux.dev>; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 8/9] drivers: Add
> support for DPLL reference count tracking
>=20
> Update existing DPLL drivers to utilize the DPLL reference count
> tracking infrastructure.
>=20
> Add dpll_tracker fields to the drivers' internal device and pin
> structures. Pass pointers to these trackers when calling
> dpll_device_get/put() and dpll_pin_get/put().
>=20
> This allows developers to inspect the specific references held by this
> driver via debugfs when CONFIG_DPLL_REFCNT_TRACKER is enabled, aiding
> in the debugging of resource leaks.
>=20
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/dpll/zl3073x/dpll.c                    | 14 ++++++++------
>  drivers/dpll/zl3073x/dpll.h                    |  2 ++
>  drivers/net/ethernet/intel/ice/ice_dpll.c      | 15 ++++++++-------
>  drivers/net/ethernet/intel/ice/ice_dpll.h      |  4 ++++
>  drivers/net/ethernet/mellanox/mlx5/core/dpll.c | 15 +++++++++------
>  drivers/ptp/ptp_ocp.c                          | 17 ++++++++++-------
>  6 files changed, 41 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 8788bcab7ec53..a99d143a7acde 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -29,6 +29,7 @@
>   * @list: this DPLL pin list entry

...

> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


