Return-Path: <linux-rdma+bounces-9509-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD75A917B3
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 11:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3E319E037A
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 09:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F40922A4D8;
	Thu, 17 Apr 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3L06hrW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF5227EB1;
	Thu, 17 Apr 2025 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744881799; cv=fail; b=TGK8qqaUl4TvOPDW8QKCU8pI240vLP+YmzOg/9wZ2BL6aE2AhCPv1MHxMd1VPoKLfWj4SnPGshs5SdMb+mXkU70/3MUNQzEri9gNNkkutsgVbQF1wfnzT8XY7ytDjGRL5T3U0pvEEiNhnRoSlhMupvoZXkRjFVlEYMJnv3XZOqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744881799; c=relaxed/simple;
	bh=xsU5HNGeOtRvFHrksudXOb41gQ8T7N1eQVXdvX6dbVk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YiUcGMom76XTeQLLnr5cVFojAPDs/w++8MYHq/qURMbi95R++Wlgtr/uSrthrNv4gtjpTuS0XOGelVTiPF28XnGyGjTm95C8C/UhN5o05Mniy7gaMLVS0uzo47uyg+lG9aEFLj3CKVPb3J+ZBTcZDu5KoAmStb5B8xntzrJ6g+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3L06hrW; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744881797; x=1776417797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xsU5HNGeOtRvFHrksudXOb41gQ8T7N1eQVXdvX6dbVk=;
  b=l3L06hrWRQ85e1UINTUTs5Bj3ND56imUTQbCGbdQ4XPaj+BQtqkgyqOy
   d3VTfEobzBIHT74PxdocQnjCVnWLQBtIN6BQu3w5iUhyqa3Qe5XupXi28
   HgzuhFlOQS/hFvzprkfAQ3CQpp5ceLGLcS+9uu6E6lNv8dC6OZJxOJDi/
   BeoMIsWi3HabYKT3AQabCCs3P0Ehtfrni5LsWityRkfOjJniEox7Q8iHq
   nVOIxyDJJgW5dkrFWIS5dOjZq/m5WeVw8isjb04V+ckIf84Y7rVW93EO7
   FoZYHWc+rrYHRT1utukXH1yU5daja1YFdKyA6xq7jCPDkltGgkf+6THmf
   A==;
X-CSE-ConnectionGUID: flYu1uIgRqy0AxwR6qw7fA==
X-CSE-MsgGUID: 0IzVH1jlTju42coruFPnAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="50268711"
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="50268711"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 02:23:14 -0700
X-CSE-ConnectionGUID: WXGIoKVZS0i5gVCbAXG3eg==
X-CSE-MsgGUID: WgAOE+j5Tfuf0d+aa18FgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="135717426"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 02:23:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 02:23:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 02:23:13 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 02:23:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdDCPuAO8C5hAn0oKc0jwAaQHISOQR8OpHdKUJWjf2yziAiDdNOHIwlNzFhtlBSDv1iloOg0JIMi6nH1MscpfPcJ6sngw+yixjRAab4N7xg34VFLjZ/jS3UhML11af+tf9FI7pRqQsUJRdCqW2U6xJNNw26dlPzgMUj9/VNNupcy1sKfr4m72+FE7zcxym75IClXAzSw9wV3JhmPJlnjr2YSE4cIEB+lQg0ReVAPbzGUzxjJPO+eigEIuwpb2GOzVJkJQONaacIXPQUBzmRcd6riA12IkMdq6f9Ol3aiBdMTK9PgTZVkuWvIDSwvZMnZBlmM5WWduoxijZ7mZDpCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipzjqGqPCqBCpgMYv3Y/fosaXRmY2KuO5l2kFE8hOZM=;
 b=k2EiwxJSsY/PCLgNf4ZGeLtfg9N+x4kva8VfvXBp/MJ8WYw8G8RJ26EehPunxDQ4MF4IbUuH23I6g31FKHpG7L87fYn4j/aigZ30JE+oUluM7w8zHqK6qqw6qBvGut6kbIe9IwEv/BzUE/jfH4yZptqwy0vulz8IK4yPOT5GQs5Zj3pqSSDqRveZL5aRRYqZJKEYlUPPpdZdLFZaGu678qrLlHXhZFaSW6YV1JvUWEuP5lKLvS9dqzHoUgkJrv2E8G16YoFyiiJaRzca1SOFmfG1YJNhlYZL01iMGoJVpTXNc6OM+AtXy5yUzkIcX5gvjgapePF44ChEClIGYkSUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22)
 by SA1PR11MB8254.namprd11.prod.outlook.com (2603:10b6:806:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Thu, 17 Apr
 2025 09:23:09 +0000
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38]) by SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 09:23:09 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "donald.hunter@gmail.com" <donald.hunter@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "Dumazet,
 Eric" <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v2 3/4] dpll: features_get/set callbacks
Thread-Topic: [PATCH net-next v2 3/4] dpll: features_get/set callbacks
Thread-Index: AQHbrjN1g9R91USWQEWl7IeAkKUAtbOmNNOAgAFYDYA=
Date: Thu, 17 Apr 2025 09:23:09 +0000
Message-ID: <SJ2PR11MB84521AE1C30176E2A31C4F709BBC2@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250415181543.1072342-1-arkadiusz.kubalewski@intel.com>
 <20250415181543.1072342-4-arkadiusz.kubalewski@intel.com>
 <lljouuqzmhcb2esfrxrviohrwgweee6632ntfoca5fqho736il@auarfibpahpf>
In-Reply-To: <lljouuqzmhcb2esfrxrviohrwgweee6632ntfoca5fqho736il@auarfibpahpf>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8452:EE_|SA1PR11MB8254:EE_
x-ms-office365-filtering-correlation-id: 3afe6314-b55c-4709-620e-08dd7d917806
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TKv0UU1jEqGIKDL7UtFjzSOKWEw3dRwQ8A9GzykouEKHBC0NbbWim7jIwH0K?=
 =?us-ascii?Q?xnZS21vcNlU46DB5QxULF1SahBDc0okTRw3eUAw0nXtipLiA3U/HMQ9hSDRn?=
 =?us-ascii?Q?CrfBegridevqhDWM3j0DFaIB5szGKRjSmm7+2X3zTdNKqSqF/wTsi8MI4mzv?=
 =?us-ascii?Q?O2rPN3Fk1/Xef1jjISSlaxmiun5FYu+JJFg9x8dB3oehtXYnHgFucP/xMSND?=
 =?us-ascii?Q?TZxH5QesClLmtRXdyt8h3GJrLvFcpzEt5YAt4D6Sd3Tu20k8xx302KqJJg3q?=
 =?us-ascii?Q?oeFlFu+EgBn/2p5pireO1g0cPCmhySLQKDZlvOlPngZMAcU/4L7jrj0Qve/B?=
 =?us-ascii?Q?Qz7DP01RGJMMaL/HVA8pAww5cPfUu8j5CK3er0EQaZ4oDLnjj2y231SikVh1?=
 =?us-ascii?Q?hsk/O7R0R1Mue1OyFe/MLAOP47dHAwnBWmd0dqlEV7ApKe3SUs5k+QZOuMbs?=
 =?us-ascii?Q?lPiK1vdkWw/qCdu54BzzXnsfxxpjtmblp46Z0JrNEa6pOenTBmnu+Ej+PnST?=
 =?us-ascii?Q?UQRO2paAyoCJOWRnEKoOfPx00JqdHB74aB0H2FgRM1lRsWNu5GI59VRdh4PQ?=
 =?us-ascii?Q?Ph32jnmI3xlebuQmFtoL6DIr3Bczv39UWzIYseY7zrUx5exocOsn7uEos1LX?=
 =?us-ascii?Q?58EZEuRdP0I7gLC1X0JSTTVUcAYa8hfJBqHjpafjRBiuL6UvIS9CfKVkrMo9?=
 =?us-ascii?Q?Ks0wBljtoSt1zC7BwTsKv+NC+tzUWWHLFLeQ/OJ3TXsb7NNz9x6g5XSSKL1T?=
 =?us-ascii?Q?YTRwp5IZ+RdUwIO2CO80lT5hqjUJUznYM4RWLRAouflEqcCytXaFrMdbCHlO?=
 =?us-ascii?Q?f9mT4m9xB+ReOLTuWeFDs918mCf2+R7c/XEt8EAhs34+7lD0EYmMD5/RirEe?=
 =?us-ascii?Q?grRjJaB3aywPwWODBgLg71q2eVEVlahwkDDsXoYn42HUu45IpyKxN7G0KUaX?=
 =?us-ascii?Q?2UiCGbJzSHjRYdbEJY99jCwAdL4Z9raK9IQ0VD8iZLaVl3nSo9g8qMlQ7nmI?=
 =?us-ascii?Q?PIImiRlYdsl5kEjGBrRR9hwKlzz8J0jDIJ/KFfpFLVaKt3SeRO01HFFJmkZM?=
 =?us-ascii?Q?AMHwb9YMcthKOrnR1ZfzTmgLtxSWVlGbrgBIdv9mQOD8wEvUQBHxBsrYjsMC?=
 =?us-ascii?Q?y4YD95tPEMiKGiqextW6KDXrtIPgy5uKoX75KWbdV4s+rrnQ6IXCwtVxoqXK?=
 =?us-ascii?Q?pVn91k00Yu1LIsuI+jyzL/Ps3r9RPbJcc65++KQtUc5tKr/caCFMbzwVXZ5f?=
 =?us-ascii?Q?L6Mtsrl2Wg/uuJFtdngpJZsEFjWaezagkqKXDwhz94cybOKtO0LnyrEo65r+?=
 =?us-ascii?Q?lTTd1fkJpMcAC5KFWGFzILucieYmjTJpkFiJqJksvnqxk7UrMH7y8P0E6vE2?=
 =?us-ascii?Q?3grypbPhKv72yS8B9Da9mQoUEtNPclwED61Xwx+YbnVRPL0bxB98mLApxPSq?=
 =?us-ascii?Q?gEIuKggxk5Uy7iYbNFly2+Rkamd4ugy9B+o2oamRLMTWF2hQJt+q5A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8452.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qLHTEsuBQd0R9YF4ArdgwapP7d1a19a3etC+pWAsAZSQ3e5PMv169cq+nCU9?=
 =?us-ascii?Q?nDanlJVIn2C7rEvWfpZhfnkNswXifRkFIGre1um+dRCtdx4AB8qNX0hmfldR?=
 =?us-ascii?Q?Sr/Md5wXREIQAfvYOp0XO9yltmX3kzJi7F9pNQs9fZ3rn/yUkqwvoqInjBFY?=
 =?us-ascii?Q?RAJrFNIh8ExlUL4h0yik8/wmG9tXOnoJ+b+ED+PcwJsqVcvC1pjeysBV8TpB?=
 =?us-ascii?Q?LScKu+kc6Kc6KBZ9m4gQMg5sp1SeBHhgSi6brpAiWQ1rmdEd1F1T8i7Nz26/?=
 =?us-ascii?Q?vSCK7REeGIl8CZZY01aFMebzoR0owS5UokR/UNBSsnJmFGy/kPK03hvMCzUG?=
 =?us-ascii?Q?y8hXqp71hFPNbbNtdEtvQ3TwwGDPux3PE4ELslUvyNTF/qyOe7mdfhEl3q5W?=
 =?us-ascii?Q?Ct9edqE1uBf8Yx7NjZQAXr7sWKKnFiapJ35tIHr0yZzOZAEGLrWf57s130Cb?=
 =?us-ascii?Q?Z9yettO11vXr5tm/oHAntiBZUyiMozJ5/cI2f/N/jexvdVWsV6FXfmKVjWKe?=
 =?us-ascii?Q?mqBSPJaXfiEMEJKeKe3dNJttl3utf7yUYVzNuJpOqY5JidElsQlya3nJqzmf?=
 =?us-ascii?Q?7WSwlSohNF0OZDGfaXWOUbI8ikqojHPLpiFw7DmPrjVcA0yo4PkIps/6dPSq?=
 =?us-ascii?Q?1naTbIstNDcDQh+FZu0XFlsHF21TxRj7iZEeOnTalqUxwi9IUV7ub+82kaY1?=
 =?us-ascii?Q?FijUtTlwcSWlneTfXpJxCfFZz4fIindvGA8bwzd54xDmkMgtfKuCKBx3lZ6l?=
 =?us-ascii?Q?OrMPdWSD1a67ZdtBywFpY5fKiu5ccVPlRNBmmZmwTf92CVrRzJWK78ijM85D?=
 =?us-ascii?Q?lGLlrqEi6DrFhN2WpabvD5oN3AHVyh8kPgb8/BdJKXPSrasXfYbI7EUyxhuJ?=
 =?us-ascii?Q?Li0tpIPRtESYFmH5jdDS4OY9gMGJIOrkw6mAn8Et1hXdnqftaeaNPxF7R+Lw?=
 =?us-ascii?Q?GK1JlZzn6Iw5iSmQgUINyQT/FFuzJCCRdc2c4Qd6etJPm8D0cKS6h2kbtPHH?=
 =?us-ascii?Q?3Nfq40rqDlqLg42OUQmlbdYX0ITJfOFUIc/0bHB2DWuRhyEuE3r5YMmBQ4zS?=
 =?us-ascii?Q?xRJrZfyg4Gs1z5fTydJvJQ6HhAV10VNx89x/TiUVpotqn7QZIFD027mFgMNL?=
 =?us-ascii?Q?Nv4tI6GWBKQkQlW1pmde77zJrU+ZzdQt8isfKHzTHu4c9Y6pAJ77r2T1kii2?=
 =?us-ascii?Q?sjYg2U3zqmuDYHQZg9YpSOstngLT+JBo3DCN0PVCwwllcBrK6BSBQK6ysWHy?=
 =?us-ascii?Q?vw6sMPX3NNQtoZxQD7k/YSVM/u/xv0AwpzOgtdFOeyn8VPDzzl5tfIkYl7BZ?=
 =?us-ascii?Q?LPiwV622PG98TTNaxhFJz70BSyIXL8cKN7gIHQfpZQUo/60njMjClh0D+956?=
 =?us-ascii?Q?zp40he33WbqoS45V0ikPkPVGga2FAU+tqoaf3ePxQZi+axVg9yDq6tpfmwaW?=
 =?us-ascii?Q?MCuLpkJ8kcsjGNpdliQeI5+2b1RPEBVJD3Yzmiio/pPBsQkvKV/zTizYZNA1?=
 =?us-ascii?Q?WMSu5gA9dnHLvu5sVxizVKTEzeftc8AZ0tciGIEsbJJDgbaKlVI66Xva1+F/?=
 =?us-ascii?Q?b2gyj69Q9sFKwb/k5ePa/YFoI+zixvU8FBsPqqbjFvSFDSiv+5YI8cCA9H6E?=
 =?us-ascii?Q?3Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8452.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afe6314-b55c-4709-620e-08dd7d917806
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 09:23:09.3388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwV+9hxSdSH10EyFNPVNzSHFJk/5zE562t+kusJUUR4o4FMnXaOZ12VChgTmvUjdu0ijta8Y8sh82VY7+YVZG2SV2M8WoOoBTFTM002BqiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8254
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, April 16, 2025 2:11 PM
>
>Tue, Apr 15, 2025 at 08:15:42PM +0200, arkadiusz.kubalewski@intel.com
>wrote:
>>Add new callback ops for a dpll device.
>>- features_get(..) - to obtain currently configured features from dpll
>>  device,
>>- feature_set(..) - to allow dpll device features configuration.
>>Provide features attribute and allow control over it to the users if
>>device driver implements callbacks.
>>
>>Reviewed-by: Milena Olech <milena.olech@intel.com>
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>---
>>v2:
>>- adapt changes and align wiht new dpll_device_info struct
>>---
>> drivers/dpll/dpll_netlink.c | 79 ++++++++++++++++++++++++++++++++++++-
>> include/linux/dpll.h        |  5 +++
>> 2 files changed, 82 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>index 2de9ec08d551..acfdd87fcffe 100644
>>--- a/drivers/dpll/dpll_netlink.c
>>+++ b/drivers/dpll/dpll_netlink.c
>>@@ -126,6 +126,25 @@ dpll_msg_add_mode_supported(struct sk_buff *msg,
>>struct dpll_device *dpll,
>> 	return 0;
>> }
>>
>>+static int
>>+dpll_msg_add_features(struct sk_buff *msg, struct dpll_device *dpll,
>>+		      struct netlink_ext_ack *extack)
>>+{
>>+	const struct dpll_device_ops *ops =3D dpll_device_ops(dpll);
>>+	u32 features;
>>+	int ret;
>>+
>>+	if (!ops->features_get)
>>+		return 0;
>>+	ret =3D ops->features_get(dpll, dpll_priv(dpll), &features, extack);
>>+	if (ret)
>>+		return ret;
>>+	if (nla_put_u32(msg, DPLL_A_FEATURES, features))
>>+		return -EMSGSIZE;
>>+
>>+	return 0;
>>+}
>>+
>> static int
>> dpll_msg_add_lock_status(struct sk_buff *msg, struct dpll_device *dpll,
>> 			 struct netlink_ext_ack *extack)
>>@@ -592,6 +611,11 @@ dpll_device_get_one(struct dpll_device *dpll, struct
>>sk_buff *msg,
>> 		return ret;
>> 	if (nla_put_u32(msg, DPLL_A_TYPE, info->type))
>> 		return -EMSGSIZE;
>>+	if (nla_put_u32(msg, DPLL_A_CAPABILITIES, info->capabilities))
>>+		return -EMSGSIZE;
>>+	ret =3D dpll_msg_add_features(msg, dpll, extack);
>>+	if (ret)
>>+		return ret;
>>
>> 	return 0;
>> }
>>@@ -747,6 +771,34 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
>> }
>> EXPORT_SYMBOL_GPL(dpll_pin_change_ntf);
>>
>>+static int
>>+dpll_features_set(struct dpll_device *dpll, struct nlattr *a,
>>+		  struct netlink_ext_ack *extack)
>>+{
>>+	const struct dpll_device_info *info =3D dpll_device_info(dpll);
>>+	const struct dpll_device_ops *ops =3D dpll_device_ops(dpll);
>>+	u32 features =3D nla_get_u32(a), old_features;
>>+	int ret;
>>+
>>+	if (features && !(info->capabilities & features)) {
>>+		NL_SET_ERR_MSG_ATTR(extack, a, "dpll device not capable of this
>>features");
>>+		return -EOPNOTSUPP;
>>+	}
>>+	if (!ops->features_get || !ops->features_set) {
>>+		NL_SET_ERR_MSG(extack, "dpll device not supporting any
>>features");
>>+		return -EOPNOTSUPP;
>>+	}
>>+	ret =3D ops->features_get(dpll, dpll_priv(dpll), &old_features,
>>extack);
>>+	if (ret) {
>>+		NL_SET_ERR_MSG(extack, "unable to get old features value");
>>+		return ret;
>>+	}
>>+	if (old_features =3D=3D features)
>>+		return -EINVAL;
>>+
>>+	return ops->features_set(dpll, dpll_priv(dpll), features, extack);
>
>So you allow to enable/disable them all in once. What if user want to
>enable feature A and does not care about feature B that may of may not
>be previously set?

Assumed that user would always request full set.

>How many of the features do you expect to appear in the future. I'm
>asking because this could be just a bool attr with a separate op to the
>driver. If we have 3, no problem. Benefit is, you may also extend it
>easily to pass some non-bool configuration. My point is, what is the
>benefit of features bitset here?
>

Not much, at least right now..
Maybe one similar in nearest feature. Sure, we can go that way.

But you mean uAPI part also have this enabled somehow per feature or
leave the feature bits there?

Thank you!
Arkadiusz

>
>
>>+}
>>+
>> static int
>> dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
>> 		  struct netlink_ext_ack *extack)
>>@@ -1536,10 +1588,33 @@ int dpll_nl_device_get_doit(struct sk_buff *skb,
>struct genl_info *info)
>> 	return genlmsg_reply(msg, info);
>> }
>>
>>+static int
>>+dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info *info)
>>+{
>>+	struct nlattr *a;
>>+	int rem, ret;
>>+
>>+	nla_for_each_attr(a, genlmsg_data(info->genlhdr),
>>+			  genlmsg_len(info->genlhdr), rem) {
>>+		switch (nla_type(a)) {
>>+		case DPLL_A_FEATURES:
>>+			ret =3D dpll_features_set(dpll, a, info->extack);
>>+			if (ret)
>>+				return ret;
>>+			break;
>>+		default:
>>+			break;
>>+		}
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>> int dpll_nl_device_set_doit(struct sk_buff *skb, struct genl_info *info)
>> {
>>-	/* placeholder for set command */
>>-	return 0;
>>+	struct dpll_device *dpll =3D info->user_ptr[0];
>>+
>>+	return dpll_set_from_nlattr(dpll, info);
>> }
>>
>> int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct
>>netlink_callback *cb)
>>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>>index 0489464af958..90c743daf64b 100644
>>--- a/include/linux/dpll.h
>>+++ b/include/linux/dpll.h
>>@@ -30,6 +30,10 @@ struct dpll_device_ops {
>> 				       void *dpll_priv,
>> 				       unsigned long *qls,
>> 				       struct netlink_ext_ack *extack);
>>+	int (*features_set)(const struct dpll_device *dpll, void *dpll_priv,
>>+			    u32 features, struct netlink_ext_ack *extack);
>>+	int (*features_get)(const struct dpll_device *dpll, void *dpll_priv,
>>+			    u32 *features, struct netlink_ext_ack *extack);
>> };
>>
>> struct dpll_pin_ops {
>>@@ -99,6 +103,7 @@ struct dpll_pin_ops {
>>
>> struct dpll_device_info {
>> 	enum dpll_type type;
>>+	u32 capabilities;
>> 	const struct dpll_device_ops *ops;
>> };
>>
>>--
>>2.38.1
>>

