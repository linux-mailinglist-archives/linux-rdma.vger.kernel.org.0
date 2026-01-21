Return-Path: <linux-rdma+bounces-15839-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJSKBavtcGk+awAAu9opvQ
	(envelope-from <linux-rdma+bounces-15839-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 16:15:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D43E15905A
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 16:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A72EC54BF0D
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027B53C00AA;
	Wed, 21 Jan 2026 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6V3dZpF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD93B5306;
	Wed, 21 Jan 2026 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005216; cv=fail; b=FedmozwlMqZZ+/No1XnjB0kLP5s0f+9BH35l4KJDXPT9NGixpAfBgIxiefglmYNOgrmuTwWghEY3f6kxLRJlKwiSWXsAAWt+68t4TfQFbbbCc8djTCLDZ2bLGaG64AiOMy824z7gwj4BTpkbdL3nMYZxdFJreeYvrINgtDyImmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005216; c=relaxed/simple;
	bh=hnWO8AUgEpm9FToZUap3Ab23nztvoxspdXO9as0Fy8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cTxi1fBeRPcw1rxWTIxyaomBBAsoxF6+X4sWKbqPkSYzjBsbEKajnx9lyVRG4mILrgyZoaCcHStw6moSmrCsmpkvNX0PqAk/04mGDrNvhQREW6lbjPyBKs5AqAxXFnikhqfsoI4AJn7fbcrGvRfH3xf1vSlSqeDW+ZwgN2/X90k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6V3dZpF; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769005215; x=1800541215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hnWO8AUgEpm9FToZUap3Ab23nztvoxspdXO9as0Fy8c=;
  b=I6V3dZpFORXGl+n75D06fqG8/SFZ53Z/N/61olewNdGqupap78O1m6/W
   VUQnuOKCUeT1lXovU85qvysVKZdobv63Ht1q/EEFoMpfW4bc/Cuvf4jDe
   bA99qQoorf9w4GddkYorrf5zHEypRV29PTzBskx8jmY9ZOExHNVoW4AIE
   1faUvILidhlTqVBjbwpf0k9co8f+vgUeyfYSA98oBpHbcZIJIeCJz2V7Y
   JW+y7bt93SR8D7Pmusy5B1KMBdAr8kRBcK+1bbfXp9Rx5BGXMsOsbUTIH
   4tnu8MDp1pSY/yBsbL1FF8+XsX8qBiVTZjgEMzIH+nVLtDBTBdCPsE9qC
   w==;
X-CSE-ConnectionGUID: vloSww6wTAKmpl+PvgD71g==
X-CSE-MsgGUID: UwUkORyKRxCAZZL6AuxuWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70136560"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70136560"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 06:20:14 -0800
X-CSE-ConnectionGUID: BCjQaanOSjG7PvY0nnFyZg==
X-CSE-MsgGUID: 4YQp8IpESSaooBRSyBb5ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="237121851"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 06:20:13 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 06:20:11 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 06:20:11 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 06:20:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKhujT2Qjpu1DXiZM1YcG7m89v9a+1JamacrKfMNZYeboaewIGqb9aPBtn4QTNNrrp6gQcBNaN+kkU1VZ+vWX3byZDT9Fqbw8FPhYPy93aBcqly4A4+rLmG5vmIJUD57fueHE+u2uqivJjQ/33zbhyyUPObvnGPSMABu6LtjgywNtmsHPbwaj1uCAmqJssF4/+Opl6o4TDGRpzmzk4/Mm8o4Rvkols+ygCLS2fc0CjbNL5FKQTM/K2fFXFt5zCeIsm6i8dBUtVhL8gTHjPua5mvEJehxg1vkdi+3leXIaGAI0Xoai7FjmcdDp38pyW8dUAhPXBoZa+HvyGKN7rkxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZtPqMqkqL2dBdjZ4zgEw9tCMtZEjaK9exUHM0cj5/8=;
 b=wX7LT1lPEakQzQ/HojJBQjSZFm91gcl8SbomfNetJjfWlaqFhASfn8cPOWqTVc9d5aTAtT6ZjIaLqKSqhjwtpwWYJF0X0Wpo/jfrhZ0iN9dakALqlgbuHB7CfjWrh4+rP67tCyVF077pl+kaaeK8lJ9kh2GrBW/x0PhZ7jTKpVBVWzJ6yxD3CnOZQ0JBpWZCXS1BKVYVjyiFR/oX9aTDctIhsUOSK0J3uxh8avidWUgaOZOOIIvjy2Mv3bpPJ/Z5Exx9nKzPaLwBscsqs+g1MLJqqKmFRkfq+eAqTXn0o6YnHsyDSoPOGvfy0GL2ja7unuUWrLEB3OHM2JTAgsZV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by IA4PR11MB9034.namprd11.prod.outlook.com (2603:10b6:208:567::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 21 Jan
 2026 14:20:08 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 14:20:08 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Vecera, Ivan" <ivecera@redhat.com>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "Oros, Petr"
	<poros@redhat.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "robh@kernel.org" <robh@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "mbloch@nvidia.com"
	<mbloch@nvidia.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "saeedm@nvidia.com"
	<saeedm@nvidia.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "saravanak@kernel.org" <saravanak@kernel.org>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Schmidt, Michal"
	<mschmidt@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
	"leon@kernel.org" <leon@kernel.org>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
Subject: RE: [net-next,v2,12/12] ice: dpll: Support E825-C SyncE and dynamic
 pin discovery
Thread-Topic: [net-next,v2,12/12] ice: dpll: Support E825-C SyncE and dynamic
 pin discovery
Thread-Index: AQHcimuQa1dgZZN6uk+CqES7dUttlrVcqyFQ
Date: Wed, 21 Jan 2026 14:20:07 +0000
Message-ID: <IA1PR11MB621916FD8AB1FE45D1BDCC209296A@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260116184610.147591-13-ivecera@redhat.com>
 <20260121001854.1905391-1-kuba@kernel.org>
In-Reply-To: <20260121001854.1905391-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|IA4PR11MB9034:EE_
x-ms-office365-filtering-correlation-id: b178f6d0-84bb-4647-172c-08de58f82e0d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?kgl7dpbCJUkJ+CTroDZFuLTAORmwnQU3azu4RKvcXjmbQCZLX8TvEqq/RjH1?=
 =?us-ascii?Q?/Ir6f0WaSHAyGSUKrwlmNoKNKqZ4yWSzLM6a9soHyXoaMy7j3jz+uHgLCo2p?=
 =?us-ascii?Q?2rzS32Ykvndm2kbqCIEQBBVWISsmLS+FgGBFy7F3bKyaSFPDRib51EzjwyGq?=
 =?us-ascii?Q?InqDTCCN2Tk1agup5RBPegeEUZh8JZCWV859AY+8uqxnvhHVAncdQZGGC4ga?=
 =?us-ascii?Q?rnlAyrqX6NigG2TVNnKcn7roPLkitvEK90KMr0OH0xmEjpzFrzsRZSLajm0k?=
 =?us-ascii?Q?GwHy99C1FM8ZYQrkAQ5Pcm+aZZSXsxwirx0HQ3ZacckVnxLuZF84OA/Ec/1M?=
 =?us-ascii?Q?MP9R9Mbr11HqNbwxyXit1JYf8CTQXuXnlZvtAKuqLm5FI/CS/LcDoufhJY+h?=
 =?us-ascii?Q?UE+5JEp+2vYPh4WT2DFuL5RT6sjcVf9GFgEPaPrxT+GTJ8S6XfigSe28UEic?=
 =?us-ascii?Q?hxx9Dd16vZrb8k62xVwhD5HsutxY1hNCuyYRPeSlPUFP/vCk9UDbmhyj/Tj3?=
 =?us-ascii?Q?VzcvHQDx7fo1ZqZhiKEl/+Gx/IV4b56/4cpkdZlnsPksVXUXBLuYk7H8ReW8?=
 =?us-ascii?Q?+W0mdiDTYJ2YF3qjEjDXiGdxujhddywmFP91ybkiX3CKwVTd67bpAtcpij+T?=
 =?us-ascii?Q?XMWfWUe6a8XTjPsQ/HU5EV0aTRfZujcTBwLm9S2sa0dusLjNSxix9NLE6+NC?=
 =?us-ascii?Q?/+0fUyWAfRTKip3Cf+pukvMf7jP8uqxDpLMaQF9k51mEWQfoJ06KV8mm/aeK?=
 =?us-ascii?Q?x9RzxW0bG33JQjxjxEiOuYnlOPHkSgf4mjT39vprl+KGhgoYUu9HnvFz9JXM?=
 =?us-ascii?Q?KiwJo09ZriYDKjfE0/taXu01L7yKG5EBmyHLKQk51x69RU2TmX14eoEeSOsB?=
 =?us-ascii?Q?GS/tJ0ShVQOdrJg4pc8CCLxh4vscol6N8PMQ9H+4ri7yLavP9dchx22lmR1S?=
 =?us-ascii?Q?syrc8O+C7+p6pHOc9aKpOVnWSMQCU4k9DGqewDvC7UB6FRYRgmWklKLAFkK3?=
 =?us-ascii?Q?IxhiEUvS+/2FhewQ5lx21wS2UfvkruHJW46Fl84y5btVQbpZXm4waL5mk16Y?=
 =?us-ascii?Q?bHBJ9O4rJbrnO6xGuPoMrrYjZxaVewu3lTs2Ef7e1dLZSB+M2ARDD/rWAqgs?=
 =?us-ascii?Q?3fQNrxkUwhLjpE+u1jI+aKWXBDzhPJuJN6Lgwyc/XARNaGlOZqHaheazG9Bq?=
 =?us-ascii?Q?kEnMFlMnSyacsKvBFntQHZ9clwpJ2f9dJwb+J3Lt45CDIHYmvAy3xOlbIIFY?=
 =?us-ascii?Q?GKab6AYVodj1t8ZiyKnCsXM2cIUofhqTfw1efbtK/hd7MqoBSlDCS4G12qZI?=
 =?us-ascii?Q?H4sXbX/tCfr/HwSHipAqrVtBaL+eB90E6JDYgW6XGgLGz6obzVbMyb52ywSh?=
 =?us-ascii?Q?Sz+oWnobFXL1I9NmrfkihZZb8iKYEIKBJPripNW2dByNKrZgFjkGQZ6i+I3j?=
 =?us-ascii?Q?J8yuxLCY+9eCBV2g/2b0Xm74+IP9ZdIkoPamk8YPPjDHe8K69JBLTu98KJzW?=
 =?us-ascii?Q?Ia6jg9Z+5fRFk+Rl7ZR1jYKdILMA4Th4YDz7dzbMgAuNmGFPWtYTD/Mki4la?=
 =?us-ascii?Q?Ihawoc3y04PVUntxubePC5w3OH03HRp7k0GASC8vlc3jWZuyeS+ciYdrXiPx?=
 =?us-ascii?Q?DT1flaMflYf61H2MgoGYJ18=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0x7o4n1M5l5fdac4TwICmhhF9PE32DKMfqKg1uttfsc4scFU7kDOuvUSprUF?=
 =?us-ascii?Q?OUcVWZytrkgFa2/+232oAFOfYdurTyS4TdHzp86suX0kgiq0iPBGXEzls9vg?=
 =?us-ascii?Q?TtSrBKlZzoyTAgYG8dAxnFxnaP1/fl0qYiI7hTFFl3hMAz95ec73BGurnB4S?=
 =?us-ascii?Q?RqsC95TnySPxGAZS7v1mD3XHPPky0D3OFV/vlb68nKWcGTuFKWtThB9wGA5q?=
 =?us-ascii?Q?xNkxb9g3+3KCKb9DA5Arn9ROiZtno1xa9aY7edgPIYx2Kfv/Z79WM6sPNi5E?=
 =?us-ascii?Q?i+TlSiHA6Ue6H5GRNFhkd8yv+q+Qeqy+KOSYe6n6Iu4obixV6d6SLogjx2fa?=
 =?us-ascii?Q?QJf4BLKoCFktfUHC5A9XANNHdzyhA/A+uOhHM9W4jY89ylNJRfSt5tTs7zXD?=
 =?us-ascii?Q?5Jarg/jMdN1gPMcIuL5u2YxDklZ8+KSL+aBEfMQEXQSz2YqdnYxOY19gBGBN?=
 =?us-ascii?Q?+lavwbcf5LqcUgr7eJ97a7xAOcpL1LvkCAO8/bAPn40y/ew3Fq5TM2aY2orz?=
 =?us-ascii?Q?D3SwOncIJknif4UgJmpw7+KCqDPjUG+2IeKALOolkKKqdyJL3AIt4eyf5yB2?=
 =?us-ascii?Q?9xj6eq7bIprXQbHeZIGLGDd/latlkGRfEoem1IzM+KEkwtyYyrjiV8USvW/s?=
 =?us-ascii?Q?1nRC5UyfutSysErH5rXVf1Q5w+JGw+tbutM38AhdmY+nhK0SFx2nIHVnjcHw?=
 =?us-ascii?Q?FIaqyp0Xkv+++GErcYnDt9qOJOy8ZK/FoXSgNhZfEpGcdpZYI457ORp0kDos?=
 =?us-ascii?Q?9qNJgdaTqraxHrv13VESIT+DIVjMagvNhb02qUpwqD2T3cw8SnWZpI9VwaKV?=
 =?us-ascii?Q?MOszJkx869fs/Sik418kbWUezof2vdbxC3ATo6lIdTgylO/8Gk0Z7uU6VXT+?=
 =?us-ascii?Q?mwy7UDPOd8UfiiGyA1x2Az/ScKDwVuaiYhUkr2aBmtpzdjlNy74sLW3YxWIB?=
 =?us-ascii?Q?jAN6MQ8xXfCzBiwbsGfmj6D6gMt5hWjDJfRfxjyxyyVNwTy6XNIo2T9sinV1?=
 =?us-ascii?Q?xHGWSP0higMCpNDFdbGO9z1OAZzdhw3Zm6QA0so2CQnKkpHn0E6jUggWbYrC?=
 =?us-ascii?Q?9FndAmnG8lxuCgVaw2SC2czZoD416WUiv40dZgmLrYjk+p84/jcEHSGGcVMO?=
 =?us-ascii?Q?QmGxYwujDJDY9a9+jtQ80eL3uQ/R200doAB5uKBOTHgMYlss4IWB/uWbAAPv?=
 =?us-ascii?Q?MM7z1dz08Aydofc8r+sRSjI46/8mGaEe4U1xtF6zd9I5v+W17pm3Lwvp1pPt?=
 =?us-ascii?Q?JzDYEF7uJVqhvsYrBWcuJwqfQRLs8Rpu6jHnc0ExtdDy16vJ7yRov+75zYP5?=
 =?us-ascii?Q?61DfL+tbWVa44gAOTDN4ZiZkTqdQNyRhKh/jRVVvdamRsZBY2+qn11IXQ+lr?=
 =?us-ascii?Q?N1y2pDMRBf0lz3DLN6hC8rBQGuegNmagWl7nwK17E+i+qiaHo2I+3KVEGLpb?=
 =?us-ascii?Q?4tlAcJmax6+8pFc3FigXBwz1M/bp0KpL8kEa1o8Uy7j9euKeTHoWvAMVSl+0?=
 =?us-ascii?Q?e8lk6O+xUnghNL5g1FRWy3a0Of/vfgadUyBnbvjPnk1cTtJ1q11YP8Nzax7m?=
 =?us-ascii?Q?svWxH9ZN5eAs3Fgt8XgB0WZT5/uahmUJEsEc4/GfKQDPQRpvM51akzK4JSrR?=
 =?us-ascii?Q?ijjH67FuhP++tKCA8fwUgGBur6eP1hrQC8qDsu3kvTg0eSwGGXFZVSywlnIh?=
 =?us-ascii?Q?xlK3gX9tKeZ8JpRDlLRR+JZzliz5hhVyb9StEysx6ArTxwS19c5uncuFVszl?=
 =?us-ascii?Q?VZ6m3Txtyg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b178f6d0-84bb-4647-172c-08de58f82e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 14:20:08.0587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/LrNy0ynCxrPqtZIrQxCw3zAr09ZRN1Qw9VEgcEKmXpuxGVnQcFy4kSMzqJDN/e46yn/ae1Ok+CHJaaLnoTPqYPQylg69rXerQciF5luUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9034
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15839-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,intel.com,vger.kernel.org,nvidia.com,resnulli.us,microchip.com,davemloft.net,gmail.com,google.com,linux.dev,lists.osuosl.org,lunn.ch];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-rdma,dt,netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D43E15905A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, January 21, 2026 1:19 AM
> To: Vecera, Ivan <ivecera@redhat.com>
> Cc: Jakub Kicinski <kuba@kernel.org>; conor+dt@kernel.org; Oros, Petr
> <poros@redhat.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> linux-rdma@vger.kernel.org; tariqt@nvidia.com; robh@kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; mbloch@nvidia.com; jiri@resnulli.us;
> Prathosh.Satish@microchip.com; krzk+dt@kernel.org; saeedm@nvidia.com;
> devicetree@vger.kernel.org; davem@davemloft.net; pabeni@redhat.com;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; jonathan.lemon@gmail.com;
> saravanak@kernel.org; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Schmidt, Michal
> <mschmidt@redhat.com>; edumazet@google.com; leon@kernel.org;
> vadim.fedorenko@linux.dev; Nitka, Grzegorz <grzegorz.nitka@intel.com>;
> intel-wired-lan@lists.osuosl.org; richardcochran@gmail.com;
> andrew+netdev@lunn.ch
> Subject: Re: [net-next,v2,12/12] ice: dpll: Support E825-C SyncE and dyna=
mic
> pin discovery
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-
> local.html
> ---
> ice: dpll: Support E825-C SyncE and dynamic pin discovery
>=20
> This patch adds DPLL support for the Intel E825-C Ethernet controller.
> It implements dynamic pin discovery via firmware nodes, asynchronous
> registration using a DPLL notifier chain, and hardware configuration
> for CGU registers.
>=20
> > diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
> b/drivers/net/ethernet/intel/ice/ice_dpll.c
> > index 4eca62688d83..9d82748810a3 100644
>=20
> [ ... ]
>=20
> > +static void ice_dpll_pin_notify_work(struct work_struct *work)
> > +{
> > +	struct ice_dpll_pin_work *w =3D container_of(work,
> > +						   struct ice_dpll_pin_work,
> > +						   work);
> > +	struct ice_dpll_pin *pin, *parent =3D w->pin;
> > +	struct ice_pf *pf =3D parent->pf;
> > +	int ret;
> > +
> > +	switch (w->action) {
> > +	case DPLL_PIN_CREATED:
> > +		if (!IS_ERR_OR_NULL(parent->pin)) {
> > +			/* We have already our pin registered */
> > +			goto out;
> > +		}
> > +
> > +		/* Grab reference on fwnode pin */
> > +		parent->pin =3D fwnode_dpll_pin_find(parent->fwnode,
> > +						   &parent->tracker);
> > +		if (IS_ERR_OR_NULL(parent->pin)) {
> > +			dev_err(ice_pf_to_dev(pf),
> > +				"Cannot get fwnode pin reference\n");
> > +			goto out;
> > +		}
> > +
> > +		/* Register rclk pin */
> > +		pin =3D &pf->dplls.rclk;
> > +		ret =3D dpll_pin_on_pin_register(parent->pin, pin->pin,
> > +					       &ice_dpll_rclk_ops, pin);
>=20
> Can pin->pin (pf->dplls.rclk.pin) be NULL here? Looking at the init
> order in ice_dpll_init_pins_e825():
>=20
>     ret =3D ice_dpll_init_fwnode_pins(pf, pf->dplls.inputs, 0);
>     ...
>     ret =3D ice_dpll_init_rclk_pin(pf, DPLL_PIN_IDX_UNSPEC, ...);
>=20
> The fwnode pins are initialized first, which registers notifiers. If a
> DPLL_PIN_CREATED notification fires before ice_dpll_init_rclk_pin()
> completes, this work handler will run while pf->dplls.rclk.pin is still
> NULL (the structure is zeroed by kcalloc). Passing NULL to
> dpll_pin_on_pin_register() causes a NULL dereference in
> dpll_xa_ref_pin_add() when it accesses pin->parent_refs.
>=20
This is a good catch! Yes, it's possible to go with the flow described abov=
e.
And this can lead to NULL pointer dereference.
To be fixed in the next iteration.
I believe, NULL checker and/or acquiring dpll mutex in notifier callback is=
 needed=20
to let the driver complete DPLL initialization.

> > +		if (ret) {
> > +			dev_err(ice_pf_to_dev(pf),
> > +				"Failed to register pin: %pe\n",
> ERR_PTR(ret));
> > +			dpll_pin_put(parent->pin, &parent->tracker);
> > +			parent->pin =3D NULL;
> > +			goto out;
> > +		}
> > +		break;
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c
> b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > index 4c8d20f2d2c0..0eb8a9e29a52 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > @@ -1341,6 +1341,35 @@ void ice_ptp_link_change(struct ice_pf *pf, bool
> linkup)
> >  	if (pf->hw.reset_ongoing)
> >  		return;
> >
> > +	if (hw->mac_type =3D=3D ICE_MAC_GENERIC_3K_E825) {
> > +		int pin, err;
> > +
> > +		mutex_lock(&pf->dplls.lock);
>=20
> Should this check ICE_FLAG_DPLL before using pf->dplls.lock? Looking at
> ice_dpll_init_e825(), if initialization fails the mutex is destroyed:
>=20
>     err =3D ice_dpll_init_info_e825c(pf);
>     if (err)
>         goto err_exit;
>     ...
>     err_exit:
>         mutex_destroy(&d->lock);
>=20
> But ICE_FLAG_DPLL is only set on success. If DPLL init fails and a link
> change event occurs, this code will use a destroyed mutex.
>=20

This is also a valid comment. Yes, using dpll mutex should be conditioned b=
y
mentioned flag.

> > +		for (pin =3D 0; pin < ICE_SYNCE_CLK_NUM; pin++) {
> > +			enum ice_synce_clk clk_pin;
> > +			bool active;
> > +			u8 port_num;
> > +
> > +			port_num =3D ptp_port->port_num;
> > +			clk_pin =3D (enum ice_synce_clk)pin;
> > +			err =3D ice_tspll_bypass_mux_active_e825c(hw,
> > +								port_num,
> > +								&active,
> > +								clk_pin);
> > +			if (WARN_ON_ONCE(err)) {
> > +				mutex_unlock(&pf->dplls.lock);
> > +				return;
> > +			}
> > +
> > +			err =3D ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
> > +			if (active && WARN_ON_ONCE(err)) {
> > +				mutex_unlock(&pf->dplls.lock);
> > +				return;
> > +			}
> > +		}
> > +		mutex_unlock(&pf->dplls.lock);
> > +	}

