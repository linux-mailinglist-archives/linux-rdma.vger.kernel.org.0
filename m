Return-Path: <linux-rdma+bounces-10863-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD9CAC72D5
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 23:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4C94E3873
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 21:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7F92116E9;
	Wed, 28 May 2025 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1q1A0ic"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A8A13790B;
	Wed, 28 May 2025 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748468129; cv=fail; b=Iif5guJrOlCizsQI1jzn+q8r5K0fmSgg2x+IiqQkBVblkqR3Ny+AXsN+eURn6hraxuhvaYvJ/clDNpS0VKM/w+pUJ6h2+8CnKzJsBvSys+fgh4CLPkIdtgGDu29/wZTN70CGBwPj9Rwrw4364BiuGX3rGNk0dsj4OG+gpfEZvOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748468129; c=relaxed/simple;
	bh=AcMYXIH3EcUTuAR+faZ7deCE+GJXr3wze11Wzo3bnKU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CTmGfWJUMObOWIPDx43XpEhA88/wMeRH3ybr21g8A6gjRW2oILufA8tIRFTswIJVKR7tRpp7q0H/JYVetnVW5O0w5Jq33KHQ0xNQCtujn5ZFHAPGk6JMb4AXAeZ81yoBhh0B2nMBzJpL4fXgt1/TWBZ9ijOO67iAcXYIminh4rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1q1A0ic; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748468128; x=1780004128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AcMYXIH3EcUTuAR+faZ7deCE+GJXr3wze11Wzo3bnKU=;
  b=m1q1A0icuBiYQhqGIBFai/rM8paoHe//fY5vRG2nXv1HJguVpBjOaCtW
   t5lnqAiXeVWsLsJWdSZGm0S18KfPln5IVMYMdzJaJx9cw47hqGtQFvfTY
   Zy3ag4hnzopLIRH+4mOzGzp17/Nhlbn2VLtlhAo4Ry4dr6EoO7cij2ZGH
   Qw0lBbYHzVmZGC1Worzc+V1DGvts5YgQleXtEO9C8pHLmaXqV+HgC6F4k
   G2eaeXGdlLEudsPtMjQek/96P5dH9k53cV1j1KCpJmSrg77zctY03wqED
   HDxlWUB7S4emWPTNHpXhWxbhMM8hXpNV8hvlAcJCmT16D/xm+DTT2IbcI
   Q==;
X-CSE-ConnectionGUID: 1BNeb/XtQfiWoi73pDlfCg==
X-CSE-MsgGUID: 6WgYuCjZT3yAVfIXDfNwoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61865539"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="61865539"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 14:35:27 -0700
X-CSE-ConnectionGUID: ah2GE3X5T/i6nj656hN9Dg==
X-CSE-MsgGUID: Gb70OydKQxeffRvbhhQMpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="166521983"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 14:35:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 14:35:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 14:35:26 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.87)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 14:35:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXZfzGXIdpiF5c+uPJjJRMMAL7aLzE39q593eNuceNstylZBb7fVHk56+1ZH14+65+lH2LColw7RjecMUces11wu+5QnAKavezDW0jpC43geuojOFTehFDlAnXjlj6N1xQlfuynuZ+rFrEB8MUUBX6XpQoIe1G0iEzSJ2NdPDpcdaLzRYaj9KoDVfB2YzvxvQbRC9yf5wPoiUnqfu9ERsXQieC6dFMiXh9Y/IlUMK0irixRXBPzdY6MidFMbwkG+WEHQutATCOrXfK4AOSHj/VjJZ/NDD7C33tX03uX2Z1jhMYqQ4c1ZdnnxBICVpoVjTdakRM8GPI2tdUTvq2GA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cxAd8Rhv4kJTdbj+JOnulXp4ULfzY4XhV2yIsps3l4=;
 b=JFuhRptipxgjFk3lnqA+r7CzXLQECfsAFrLLCtUxNuEMsYMZJnxprJJX1di8KI4nkbYgG7r1riySkpC/R21PomT6RuqarAj4Hz8+0JKn3VFTf7NUYnMP1HO/iHFSTg6G9Y1oTmmXbzRGclRUajVSfOOIyv8gG9YEM1P03AQLaAe0ukb/czmDsFKO+yKAFZMBahl5lCWwFBtodkNEdIU8FAPvV8P7P3qMHFVgQf71YvhAPfKyCij86OPyZCPc+JlzpKVzJpgXmv5IS0SRHtL/4C0/V0MjQKnGMYSf0NoQvSwrmsw/V3BVj0LCFryzvjXPJVWAE9DpFnoEGT+XEhbRMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB6055.namprd11.prod.outlook.com (2603:10b6:510:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 21:35:20 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 21:35:20 +0000
From: "Hay, Joshua A" <joshua.a.hay@intel.com>
To: Simon Horman <horms@kernel.org>, "Nikolova, Tatyana E"
	<tatyana.e.nikolova@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: RE: [iwl-next 2/6] idpf: implement core RDMA auxiliary dev create,
 init, and destroy
Thread-Topic: [iwl-next 2/6] idpf: implement core RDMA auxiliary dev create,
 init, and destroy
Thread-Index: AQHbzAT9oQ0FnkjS1E+x90Vh8lYZTrPn4eKAgACsHPA=
Date: Wed, 28 May 2025 21:35:03 +0000
Deferred-Delivery: Wed, 28 May 2025 21:32:32 +0000
Message-ID: <DM4PR11MB6502B815D05CE9A6A39C0968D467A@DM4PR11MB6502.namprd11.prod.outlook.com>
References: <20250523170435.668-1-tatyana.e.nikolova@intel.com>
 <20250523170435.668-3-tatyana.e.nikolova@intel.com>
 <20250528104043.GA365796@horms.kernel.org>
In-Reply-To: <20250528104043.GA365796@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6502:EE_|PH7PR11MB6055:EE_
x-ms-office365-filtering-correlation-id: 191a68ce-9cc3-4431-f33f-08dd9e2f8bdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?D2mldwn4Ra96Uuj6uqj25OmgYe3g/3N/9vH1/ruXJUkR5OVh+kK9F252EP7w?=
 =?us-ascii?Q?15mNoSFlWBT0KIv8eBrPsD95UWDw3U/nsg2n9aZfvJAFrBpVHoUwqU2btMOs?=
 =?us-ascii?Q?UN/pNy19Y26C3TwxUtgluecfzJlyVOd86pp8IJ731SZnrqn10XEGCPxhXw6q?=
 =?us-ascii?Q?6LBusdlQVdOBBrJJOAGqcfCa7V41QKbT/Ha3C/afs4HGEWM2/Irq/tXVDb2L?=
 =?us-ascii?Q?tjeRRybA1en5x/SYya33SEzbW1YJoplT+5c8yE+OV5jLkWBBbp5735aQTgGo?=
 =?us-ascii?Q?TM7lBw06ifuohYRPbaD9nECm+fG/1K0WqAfgQnFoHIoAMejjtalSGyAGGDO4?=
 =?us-ascii?Q?U5rFnq0Zi0dlxJn8tPXibAR4cMWL9nw8SpY9wu2FzSV/Z2C6KxhrsIzuKfyd?=
 =?us-ascii?Q?yGZA0KkraBOfLE14heibj/wvGLojMtE6RxVpH0v201tYbYzRjdmS2qXgxXBx?=
 =?us-ascii?Q?4WnfGQCD1jZoTbDZ6clSvsGN07HgORaJBcE8fayG9CqqdZhJR2sqB5FL7WyE?=
 =?us-ascii?Q?rBLAiJvP+OzScVtgen0KP6D3ns3hAktaQ12XP7au+IAvDnyFtErDTMnuy9Xe?=
 =?us-ascii?Q?fPgL9uIVg/eDSAT1R6o1bxp/+GWJNGyoDnbuKlJdlfXlfT6iBDd9o0D42R9T?=
 =?us-ascii?Q?c03qb8KnEQGNNImrdAgQhexI5CfetZ3+5v/AMLlWvg7TB0bGeVTJPD/P0AGf?=
 =?us-ascii?Q?b27z6EyiNS8bAlbfyed5M9nbHmsfL+z3ZXY4chNFRguL03eQkIpjTCmtvKLR?=
 =?us-ascii?Q?sPPwW9wsW5Hgj55vQ0vtW3jrN7nmdLaBsmtlqKm9F/nMyYRkpz1Pe3+9cpD8?=
 =?us-ascii?Q?XoSPGOiU1L+TPdLUAFgbodApfem3GMqPZ7nII8FcMURZ2Z+UX6E0PkrN8SZL?=
 =?us-ascii?Q?Zez4PonJv7bNhxtO9MrQKd0uK1gdlkz+vjs6ZBjwcxa85H2Ts6ayirlwzqK2?=
 =?us-ascii?Q?zGwvCjrzK3RMPJTOkI8u7ZhRes3MwuamQpQdfoqJniP0LgbPtRwgFzzxOhxE?=
 =?us-ascii?Q?80ZI3dqjoR/6mDsULXrHETLFciVbCq3Acjq9YT99Ub9fSNR2SZU9ytH09lmU?=
 =?us-ascii?Q?qGNmufyP1niZh2fY7jarU1Ha8dlQz50rz1pRJA/Pq06IGOJrqaFOLfN650rN?=
 =?us-ascii?Q?5dPf3O1J9q861FwewB3IkX06KDS8jWFQBmZqa3XggyIRYQAeTyozo468C9Vo?=
 =?us-ascii?Q?OspxAIurID9NN+VkjIeY9shXXDRKqzhktNpu4A9QZQBmYP0nlLmvADP2TbLH?=
 =?us-ascii?Q?4ttxaxOQozImFYqzCdXtJM0+b36OE7XRJwAUmwxJKasUgln23uUdPo95EIuu?=
 =?us-ascii?Q?PHNGobF1/UJeAJpBYuluQrU6kOyjPN8eq25Y913qm5znbRkuRruCYNn/uV3Z?=
 =?us-ascii?Q?Q9OT036i+KvVnwoHLoBcgcvfZHRX/Byiu+4A3vUJzdXBsnO0O3e6SIINtV70?=
 =?us-ascii?Q?pWToGt9/lBbc3BoWC1/A6Ov6DKznqlnMQWupLW1Z6boP85H9FGS3iOkiVK+e?=
 =?us-ascii?Q?+abYlKaRYvAaW3M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6502.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jPgFwtBYVYrV+lUao3KKnp9o2qI54lk2wbjV6CdNIJjL0Fm1AbwWM6axj+qH?=
 =?us-ascii?Q?2T8iXE0HZ3FyLKkWWKF+MJxxWVRF4Sf1Dw3ntunnpWPp+d2uiqO2qFc8HBsC?=
 =?us-ascii?Q?dRuoXsTtEHbMnPkkaT5aF850UkSg1KJ8MD+tbWNfWPTDfZBY1IUKL4uYUAAI?=
 =?us-ascii?Q?JQ4km1fTDBp1UZ8EvsTUVyJAAcQ83W0NEJEANPq1M0bCOgOui0EU1+qd9sx6?=
 =?us-ascii?Q?KxP4EDZVlcpAGMsBbWjq8uGMbwlA0AAd+qO6WEdaHVWIQ4wSBxBd4h9Lnf7W?=
 =?us-ascii?Q?/Wn6AZbIgcN11iBgGgzEUHNfTNMKRkLEL9T89VBmuY1uVYDt6bqUWC435s8/?=
 =?us-ascii?Q?L+vSy4AP6WRagA7qseHiPaWNz4kJ5EJ8GTS7+j5JQZf/ZaF7NVRTD/UoJ8JK?=
 =?us-ascii?Q?qZHzeK8Owzr1JCOkWirPDiQL+Np9t6fv40PuEVWCzugjOW4ftBDzSefj2vun?=
 =?us-ascii?Q?1nDIWyMHYkiP4wkuY2vGiwBai9Ogn1eA27pcQev/KjqEg2ViFWjFUiSHxsAZ?=
 =?us-ascii?Q?gyrjArIEZ1+/cd95rkUv60Pev3QDSNS8n+eUOJVjS9gKlOUTjlowj6lskMl2?=
 =?us-ascii?Q?pWySSeXRitzBYC1rTK6oy6eJfxQr3KT/kUsxuGBLTEoTlwV4NE3jv6V6fWvA?=
 =?us-ascii?Q?2fmTMBPrlZLsOjAPBC/w2MyvjNGVrtYrrXLC1qhhudp0me7Imo6EZssheN0i?=
 =?us-ascii?Q?zQiLw4nlG2SemMsbQeJeUaNX250kVoqWqL0v1nnuLnFkMY30LxlQ5wSbcmpW?=
 =?us-ascii?Q?CopwCZ5V/ngL/jdGYS7qvhnEdC+kQlP9tRdvTmEYBouF+yglvBuBliFEWOwm?=
 =?us-ascii?Q?w4HFA+7cKc8q5/PQCKQKZL4Kz+UraL83btoNAUN9TEMdRLvyRqtrj8jMfHp7?=
 =?us-ascii?Q?L8uhuXQA9aEBczBXW/zsJjYVPf4TC6EcVmfWglWdoGrsdbk3jyxBBKSQtwmP?=
 =?us-ascii?Q?Cxdjq7LFgR61zvi2qhqNAVkQrwVE/aDcXMxmBNTkjB+BNjRbGdJmocABuxle?=
 =?us-ascii?Q?0ROIujIipUbLyWR4Jm7dm7bDtQkEjuDOZ4Z2ei30IdLm0FG+rffT7W1H3zw4?=
 =?us-ascii?Q?IZmCVGFR8Fg6l2yYgwZh9uK6+B0ygRrsmmK+CoPaGA4joPBP7WynDKoYDdx5?=
 =?us-ascii?Q?TlnVrW9273OT4ttfr8PtAux5VWQxO/mKjRQR8G2jZ39sXU4GYfZ2SEoD6tuU?=
 =?us-ascii?Q?Bb1eRxQFsB86ATZTaoCF1ZAxwQsCw+bAK+2R2urWXr1Gql1O0jb4L1nrEkvx?=
 =?us-ascii?Q?rL5vtyCS9DvRX/JtvMSN2GGrLLsuGCvP20OWsa4IU68Xr63DYf5c+LKkEH6y?=
 =?us-ascii?Q?S1coPCANO3DjBsmkZthIyqW8R4nyvoxBjtaAzr0iZnUZRo54ZPsk6yBZNSrG?=
 =?us-ascii?Q?fF2BLbst0bBTXdmq66oqBFUZtf10WS2aeqhLgRA8TN/XJYhBuAuV9GAYL9Jd?=
 =?us-ascii?Q?ayXPuUQnBRmil/w3k9gD6UJGz3RKCfQtdJLQW1DCZMD/+bQB08DUjnzxpIDo?=
 =?us-ascii?Q?AjluGB1iRWnaLotDM4cpQ7Qf/zPQdPn6iN4J9JmfBAhoyOs65SaQUOfRTycn?=
 =?us-ascii?Q?Zj6+Czys3ASz5Oj+1+QcKwQ8nMGkh40IZWhvHgyb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191a68ce-9cc3-4431-f33f-08dd9e2f8bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 21:35:19.7179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2F7XzMBd3aYAFXk0ok2/SBVVSyTq5EzUh5doTH/ZvWqPKqQdPUKWdc+u1F3W3mOBnKy8E5WXXnCHmJpvdMuaMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6055
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Wednesday, May 28, 2025 3:41 AM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; jgg@nvidia.com; leon@kernel.org; li=
nux-
> rdma@vger.kernel.org; netdev@vger.kernel.org; kuba@kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>
> Subject: Re: [iwl-next 2/6] idpf: implement core RDMA auxiliary dev creat=
e,
> init, and destroy
>=20
> On Fri, May 23, 2025 at 12:04:31PM -0500, Tatyana Nikolova wrote:
> > From: Joshua Hay <joshua.a.hay@intel.com>
> >
> > Add the initial idpf_idc.c file with the functions to kick off the IDC
> > initialization, create and initialize a core RDMA auxiliary device, and
> > destroy said device.
> >
> > The RDMA core has a dependency on the vports being created by the
> > control plane before it can be initialized. Therefore, once all the
> > vports are up after a hard reset (either during driver load or a functi=
on
> > level reset), the core RDMA device info will be created. It is populate=
d
> > with the function type (as distinguished by the IDC initialization
> > function pointer), the core idc_ops function points (just stubs for
> > now), the reserved RDMA MSIX table, and various other info the core RDM=
A
> > auxiliary driver will need. It is then plugged on to the bus.
> >
> > During a function level reset or driver unload, the device will be
> > unplugged from the bus and destroyed.
> >
> > Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> > Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> b/drivers/net/ethernet/intel/idpf/idpf_idc.c
>=20
> ...
>=20
> > +/**
> > + * idpf_idc_init_aux_core_dev - initialize Auxiliary Device(s)
> > + * @adapter: driver private data structure
> > + * @ftype: PF or VF
> > + *
> > + * Return: 0 on success or error code on failure.
> > + */
> > +int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
> > +			       enum iidc_function_type ftype)
> > +{
> > +	struct iidc_rdma_core_dev_info *cdev_info;
> > +	struct iidc_rdma_priv_dev_info *privd;
> > +	int err;
> > +
> > +	adapter->cdev_info =3D kzalloc(sizeof(*cdev_info), GFP_KERNEL);
> > +	if (!adapter->cdev_info)
> > +		return -ENOMEM;
> > +
> > +	privd =3D kzalloc(sizeof(*privd), GFP_KERNEL);
> > +	if (!privd) {
> > +		err =3D -ENOMEM;
> > +		goto err_privd_alloc;
>=20
> Hi Joshua, Tatyana, all,
>=20
> Jumping to err_privd_alloc will free cdev_info.
> However cdev_info isn't initialised until a few lines
> further down.
>=20
> Flagged by Smatch.

Ah, right. Will fix in v2.

Thanks,
Josh

>=20
> > +	}
> > +
> > +	cdev_info =3D adapter->cdev_info;
> > +	cdev_info->iidc_priv =3D privd;
> > +	cdev_info->pdev =3D adapter->pdev;
> > +	cdev_info->rdma_protocol =3D IIDC_RDMA_PROTOCOL_ROCEV2;
> > +	privd->ftype =3D ftype;
> > +
> > +	idpf_idc_init_msix_data(adapter);
> > +
> > +	err =3D idpf_plug_core_aux_dev(cdev_info);
> > +	if (err)
> > +		goto err_plug_aux_dev;
> > +
> > +	return 0;
> > +
> > +err_plug_aux_dev:
> > +	kfree(privd);
> > +err_privd_alloc:
> > +	kfree(cdev_info);
> > +	adapter->cdev_info =3D NULL;
> > +
> > +	return err;
> > +}
>=20
> ...


