Return-Path: <linux-rdma+bounces-16271-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJzAKufvfGndPQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16271-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 18:52:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B48BD7DD
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 18:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 799DE3028330
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 17:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD64344056;
	Fri, 30 Jan 2026 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpT8/e9u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36CC2DAFBA;
	Fri, 30 Jan 2026 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795461; cv=fail; b=CKwllY/VYDTv6qB4vNNl/5dWJyx3kK8oHWmZjvgCBL9Gr3YDW97XRrpsV+qHgkuM7764cwnYuD6aT66nV97S63yjCdIuE8+vKXPdSZ5tAwxqTmaPGIiuLWhK/AbPy7NUwPZVTKbkl03B2JW+vcLuERawbfLsgbkXxHZ8Zcmu9Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795461; c=relaxed/simple;
	bh=pgAgs7CSQLNUldAWS7obzI6Jb9rZyU9r9o1d6tmTSYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PktU8WnFBMc1eiHJdJa1yIEtGxWgMM33zQWxCrIwjhUWbm0QbQw6jjBzLksuzyYUVyPjdaE1hE4QIbqE4iHkhcm/t5WzP8HI+RvOxc1NF4k0pAIWHw4xueerpZ60gUjYMPl3KgBn0WvKp7t8AfWMDFzI7tMOTj2podZVPYOgsGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpT8/e9u; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769795460; x=1801331460;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pgAgs7CSQLNUldAWS7obzI6Jb9rZyU9r9o1d6tmTSYY=;
  b=kpT8/e9uZo0De3xJaXWXiC71602G64a+bqaTtsSFXjWxe4IooDC2iyNw
   JvAHHnUkGp8Y4zOIFgSSJAoRCa37DlJSY/VP/zOqWoPxcC1DRXrfCS00+
   EwkRlN1vgRNMj+RH5hgER1R52rXSKCauhXeYcmtMli0OLYxuv2ikxY3eG
   bWeH5sh6Cw52gfl3xrARRQNz1v/JSCD2AgTfon+Ij2pSZmcOILqgnRkZ5
   osad499XvFIxr6ihxbgJYVVYK5cCerHfMfnK0yuF9XdQyFZzmh2N3+EJC
   9nw8kuMFkIMGJIte3ZlB9vN8gT3sQpnikQlEyamMpakcOqCRBMHkYSn8v
   A==;
X-CSE-ConnectionGUID: fiC4pD24RDyeYFNFkNQBuw==
X-CSE-MsgGUID: 508vi3v/TdOGxuvW+1aTTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="82474569"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="82474569"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 09:50:59 -0800
X-CSE-ConnectionGUID: iVDXjHyQQYeFnQO8bn1PQw==
X-CSE-MsgGUID: Hi8TSSadT7Sb97qoFs87uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="239635105"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 09:50:58 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 09:50:57 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 09:50:57 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 09:50:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q63Tx/kouXWjS4zAyheSRHOdvaiiT9y6nY54PzNhEoqebpUxQWayQymaRupyyEHw2joJ+yYRwbJp7pLi2EsDoF+7LCx3kHtChIWrqmFfIvXM1mGob6XoMPVIVyXei3aymwAS3labqDoPiZwRwD3z9LlXpAFOw2Mx0WMltt+2E+WezBJeVHhKFDD1C4/0bvefSKTtrGYu1IkU5QsVInEPO3SSauSX7qYeFJJD7ddEjmeZFPjHdCVKUjQpnL4LE7fpmnJ+ph2MnrtRewotOIrdUVrRWjKkQWnUFB0FQkozxmh3y0qI9lBIeJvQFkUc8jZGER5k9nvV2+J68y4jxXw+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1fzs5dpzgjjPdb2jtBh4ORCKPtx2XytCYXg35p8X7Y=;
 b=iqPXSRNAhO7WXSMEEm/aXHUFUFNT+RkevBdEoAiUab46EtiMU/L3+RdPpQazxGJ7btwrm/u7UxiUPSjOnZNoU8Wc/stzo09bf2q5IpQLNBiExehpDAkLVzo+YLnEFUbWk7HpNs1H2+XtrywPk2uAAfZmTe47NzX/9ntTLECSAjix+90COeooYFjM1DRyQoxldMkOoAXlTv9EywE+VSZxva9mwhEXorMjVqlNfw7zYEIB25aBXtayLuI3XLzxAc3dJUlLzQW9MLZSONJsdu3m6zt97bb1BpOq+kIheqsB2Ha3n0NkJ+n9Ild0c6JD2z4su/UXerRSUNunFLY0IO2DCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 (2603:10b6:518:1::d32) by CH3PR11MB8344.namprd11.prod.outlook.com
 (2603:10b6:610:17f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 17:50:54 +0000
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::f7b3:4461:b4f9:1a0]) by PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::f7b3:4461:b4f9:1a0%5]) with mapi id 15.20.9564.007; Fri, 30 Jan 2026
 17:50:54 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH net-next v3 4/9] dpll: Support dynamic
 pin index allocation
Thread-Topic: [Intel-wired-lan] [PATCH net-next v3 4/9] dpll: Support dynamic
 pin index allocation
Thread-Index: AQHckgkh0ckIojTtSUip01MtbmccKrVq/cgg
Date: Fri, 30 Jan 2026 17:50:54 +0000
Message-ID: <PH3PPF7A88A980A3B69C3F4AAE8DFE1CFDFE59FA@PH3PPF7A88A980A.namprd11.prod.outlook.com>
References: <20260130165338.101860-1-ivecera@redhat.com>
 <20260130165338.101860-5-ivecera@redhat.com>
In-Reply-To: <20260130165338.101860-5-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF7A88A980A:EE_|CH3PR11MB8344:EE_
x-ms-office365-filtering-correlation-id: 6c5c3829-b2df-4676-5ad0-08de60281d7b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?vAPJdtjkQ7ypZlUatkYC3l6W/PFsYgLeEMsHaTLHNhmOd9m084nvJ8E0NM+E?=
 =?us-ascii?Q?x7jTliEGdxeF431MXr6FaXwwmHsWWU1kNO2S02Wg79qt3xLFWSGSQ00CD3rj?=
 =?us-ascii?Q?lEKvw/gISVqecoXRNBtp0gdTvuzLpEsOgJufBiVtJrdmRxe8SFQj6CgMdeJ5?=
 =?us-ascii?Q?DiCp9YEl5UYeyvBI3ZBZ0O3n7BDSv0Ic0hpCG70Yi2job82HTJs/2ptwC85X?=
 =?us-ascii?Q?xOx4X3Ijms7X1214890CWnkwPLyIiQBxspIS55FUQlpz0A330UfIs1uoMGIu?=
 =?us-ascii?Q?kGv1NrU51cAvIRI0foGtqgitVq9bHg2L2fE6cLHdXme+hxDjkMtCD/fWTUrb?=
 =?us-ascii?Q?98gECbVfLQoRQghF1ycpOcAwKKbPHgmJZgLTob6BHS/R1Kqr3FgPIMgx3Prk?=
 =?us-ascii?Q?9ZuumSqlzUUUEZBHPkNv0ERDBRvd07ppxPv5qoKxB/LxqmrErvVKy/YXmIBo?=
 =?us-ascii?Q?tHChtxdryaPSSuQ+SJ++wbRJz8x4Bd4ii4VetTZBw9YGaUj+BQL3RDTONqrg?=
 =?us-ascii?Q?XikdPhhzH5/DkdN1OJZ3o4L6MmtfupV0tCNVULyVXX7HHUfpI+9jtBZ0fD3M?=
 =?us-ascii?Q?RXQn210PIUe/fN4Zj973xFaanSAGpGPx5tigqgIPdNg2r6aK2HZfKK3d22cU?=
 =?us-ascii?Q?I6YHGeuBraQbUFKQ3Te37MoPPTyrIFvflDaej2ysCZprli6UB6eCDX6NDx/S?=
 =?us-ascii?Q?0cIFxuu/UvVigafO74lEmywOvmdwIGTmJto22oOl4KU9ksp4FiN+FuXNoEp2?=
 =?us-ascii?Q?ZYA3Yk4ThbXq/M7aJy3aS+6EHgks4Du2217gkKLZtgLBzNXdGWGl8IjJX2Ey?=
 =?us-ascii?Q?J8oZLCUSXRzyCAGbPU+0lb35IvMVw7dBTIFe2mrkBDZo91Un2sh8YZBQntBz?=
 =?us-ascii?Q?Ur7VWTqiWNrhcv6yKCZofa57u7NG7jyRfIizngoTJ2VmfakLdbLlQJJbo0Qr?=
 =?us-ascii?Q?hPvKEUm+mii6Taf1swfncsfB4IYi2jeFWUqZTbegh+0Uc5dDzsHvgczth505?=
 =?us-ascii?Q?dbSC/YELzuztGZBvTt8SKNGGK+dT+Db0i5hHXKYcPC+c+pis4+hKcSF8hN2b?=
 =?us-ascii?Q?3KaFRWQpNcUrDSLB0nI4BZsnaLJUlMtYFsN6xtbyHvtZa25gjzvECm13RvYj?=
 =?us-ascii?Q?N9JzNE5QzJLpGNB4JFQrK0evXrtpvR1yvpHdahKZGfBk/XUTtVKOiCNeoZ9g?=
 =?us-ascii?Q?sLzezkCfaDP8EhwljGYtMSG1567WasyZme1A64hkUq+lLk4FogC99IkkdaB/?=
 =?us-ascii?Q?OOTabGyjNVR6lKBu/RDTfGJBLk6xC62zzNy/I5PTF1hEYu6j/8kaouLbIYei?=
 =?us-ascii?Q?Buw24AV87o5mSYTJ6iJjlTP7eTfSfF15kvKwGchxjYECUheXgerSYN/YsZbW?=
 =?us-ascii?Q?asOOjIwiPUcFSum0wVQyhVSEf4+XOoQvsP4QlFa4dW263gNmt4gJkzR6sL8V?=
 =?us-ascii?Q?GrECsgXRCOBVpBqYO+reKIuNw5UqU0ATS6WkcSEicFNCMJZ89Bf3jlK9JxSq?=
 =?us-ascii?Q?y011MD1hpfnr3Hnae7HQn5FP/G6q0uzRAU2zXSf+4Z8uDmBduRJNP+gGTz6G?=
 =?us-ascii?Q?yCYUB5WJZVX8fZH/p/zKwBaFQ+R1BuP9Z2c4ssPAMfXgN+1ealbzZuwojif1?=
 =?us-ascii?Q?pczwp4LmYBOg9bBZCfPDAls=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF7A88A980A.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mx5Rn8+QzpRGEDwyVEyzPVmOS0neHrJI6l+KrV47W3IXZFr0jKMrVr9EZxGC?=
 =?us-ascii?Q?tR88IMsBBK0Na6UXEalxoqKBdupJaOlo7ikJxWTgt/wAB5YZm3kThtSXGYdf?=
 =?us-ascii?Q?et/ILEK5qxxP8Fexd8qud5DUYUCMhW5kHJljv1or6aZSYGNMtB9TrixH7lVe?=
 =?us-ascii?Q?U7nmyBOIQIC4Aatrw75v8AlRFrx2FkpAhGXJNkw1E2+8An7Y5XU34M0zw/M/?=
 =?us-ascii?Q?0HkEOLELQIOToASqtOarqQmobjq/4P5esR+9pRm0WCdNT4M/y8dznG71USJf?=
 =?us-ascii?Q?JfIYpf0WBB/1OsJAfmpqmzhNm1I+FiqJfsEWHzb91xImT2HBSZLRGqRB9DdO?=
 =?us-ascii?Q?9b06uGAplgqJcvDI7Hm8dvekobWLr2cNcMMTy+NAh7pTe9sinqrYmnflvq+C?=
 =?us-ascii?Q?uWcpZlSJtrYhFQ4letEcyq6GnMO485bt5lKriSmo3oM1nuZNg/7EPeuuAAoY?=
 =?us-ascii?Q?d2ZosWQqw3jAyFy95I9R5/54xux6w9rRwnYpjXd0Xvo+Uvh4HbKbg+D1jzHm?=
 =?us-ascii?Q?6HOmugrooknHo26UVpfmdUHXvytLoMGLXjCEqyheCeIUhejaidenWKSfvBiR?=
 =?us-ascii?Q?qFNUHn7X8eNqz58hT89vtjo71r54oFMtKnJ/2aw9/gBeenSwyotlQbvaZy0T?=
 =?us-ascii?Q?VAhg0ktJ21jJ9+Fi2Ol67AOGuCwYkDItYlXzFluql3vgds8sOsd/JR/muFOv?=
 =?us-ascii?Q?vjqbvv+CSn0O3ki8pBfhSjb7y5kEl7fL5sUMz8q+IvRV7eZmH0N9YsICZlEo?=
 =?us-ascii?Q?GUCeq9HL9UU4mbqt8wPSDI9PUOVzifY4MgcvP79iaGuVAYc4CprmDHaEN6il?=
 =?us-ascii?Q?W5psj7czXZCrPx6JtyMeJajoM9odCQJq6AlvDrJSOZUkWaRc99i9BW1NhvD3?=
 =?us-ascii?Q?AaYeckOV+CjNetjowCcD52mwgOqgHQQKMREOuVLm10VVeATgN9FsVLEk0PZD?=
 =?us-ascii?Q?F0k7tHBHlloWs8FrcYLfozb10e+oydJx3p0V3FDdjgub5hLAYRI/xjE8HT57?=
 =?us-ascii?Q?/nPvevq/icUPPnrrlJCZCptKpVhBNIjvY0MPBnuhpFojVOpH023XrPe6PKRR?=
 =?us-ascii?Q?JuctUEziklD5oB3Ip0cEssbnILyLqFCerkcJ2QUViTRpHWjTBKt3qSIwQrcl?=
 =?us-ascii?Q?IEQ5RYP1i8Jl66DavsLMwsXgBnZsB/7zdWIT8i6WeX7GEWCpViPgUruuCCNL?=
 =?us-ascii?Q?fOz4ogEbV85sm+uocPY3RXRMi0y39DWgY+s+6zWJCgPTvZ3NpVXwDw9LSkWY?=
 =?us-ascii?Q?QHVkYBifWobbpP/sm7SdXabGVXy0s3ZhoSuFskhrUjC1KdGLVFPSmNRcr18p?=
 =?us-ascii?Q?YVN7qo4QvtVsHez80HkMgXJvSmEZucUq5YwFV0Edq/XYnZjZFCxGoZpyhb36?=
 =?us-ascii?Q?FLhvBY7pYPSMXZhOEThwvmtZr7l16RLIZ8i2mGPfIFvFfrzZ/3ueengIbK4G?=
 =?us-ascii?Q?yVC+ArOOgLsM2wo/6jRsff56o+mgFIqdbnpEKG/4but32toKWRjkKy1jSrVR?=
 =?us-ascii?Q?G4Rs8yg5PkkcCWlqYeYVumnSAuhWuQ/qnz1g0FUMWcp6lAXKfFCwTiY5onGA?=
 =?us-ascii?Q?BTcOyleHY22JxtbH6v1Ozd/oPi9M4ht9zF0lAUeErC1mqqOOTyg4Pz4VEXNj?=
 =?us-ascii?Q?S9CqoZpUUsRGBt4zmvSoTnei3EgDIk8S+vcNAY60npboQbZk5nNATNCa58Ya?=
 =?us-ascii?Q?H2Edu6wkZv2OODNg3//IC+PFtrsV80E919Xg2lwNtyxCtO7yQ/XYnk0H6QKb?=
 =?us-ascii?Q?Lwh8IOLhNQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5c3829-b2df-4676-5ad0-08de60281d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 17:50:54.2520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBkXy0xo9HTt+eN2zg5Kay5asWiMjFBi/Qfw7IkW/63YjVKNFNlwi0W95I3sx1Vu8U2u5ti+43eMCi2EXK27a4HQ0WKPmR6u7v2EL1XdM6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8344
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16271-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,redhat.com,microchip.com,linux.dev,lists.osuosl.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,resnulli.us:email,linux.dev:email,intel.com:email,intel.com:dkim,osuosl.org:email,microchip.com:email,PH3PPF7A88A980A.namprd11.prod.outlook.com:mid,nvidia.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D1B48BD7DD
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
> Subject: [Intel-wired-lan] [PATCH net-next v3 4/9] dpll: Support
> dynamic pin index allocation
>=20
> Allow drivers to register DPLL pins without manually specifying a pin
> index.
>=20
> Currently, drivers must provide a unique pin index when calling
> dpll_pin_get(). This works well for hardware-mapped pins but creates
> friction for drivers handling virtual pins or those without a strict
> hardware indexing scheme.
>=20
> Introduce DPLL_PIN_IDX_UNSPEC (U32_MAX). When a driver passes this
> value as the pin index:
> 1. The core allocates a unique index using an IDA 2. The allocated
> index is mapped to a range starting above `INT_MAX`
>=20
> This separation ensures that dynamically allocated indices never
> collide with standard driver-provided hardware indices, which are
> assumed to be within the `0` to `INT_MAX` range. The index is
> automatically freed when the pin is released in dpll_pin_put().
>=20
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
> v2:
> * fixed integer overflow in dpll_pin_idx_free()
> ---
>  drivers/dpll/dpll_core.c | 48 ++++++++++++++++++++++++++++++++++++++-
> -
>  include/linux/dpll.h     |  2 ++
>  2 files changed, 48 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c index
> 4bcffe3507cd7..b91f4dc6bb972 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -10,6 +10,7 @@
>=20
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/idr.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -24,6 +25,7 @@ DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
> DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
>=20
>  static RAW_NOTIFIER_HEAD(dpll_notifier_chain);
> +static DEFINE_IDA(dpll_pin_idx_ida);
>=20
>  static u32 dpll_device_xa_id;
>  static u32 dpll_pin_xa_id;
> @@ -464,6 +466,36 @@ void dpll_device_unregister(struct dpll_device
> *dpll,  }  EXPORT_SYMBOL_GPL(dpll_device_unregister);
>=20


...

> --
> 2.52.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

