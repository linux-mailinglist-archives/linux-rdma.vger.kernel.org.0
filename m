Return-Path: <linux-rdma+bounces-18347-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBcqMbHSummfcAIAu9opvQ
	(envelope-from <linux-rdma+bounces-18347-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 17:28:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B312BF495
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 17:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3AE03128BC8
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B32C3E5ECB;
	Wed, 18 Mar 2026 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfAfv4bR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEBD31F9AD;
	Wed, 18 Mar 2026 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848599; cv=fail; b=uGreyKqyxul02EmGpa8QBmqcHzsTojchTUzX2xdgwfaj+JEk7NvMW+OA6RMDGyUM+QZqiP8VR1vJWEVXxCEXT4fYZnEvesdwwRH5pgKscQ8VsFJsWehc942wj3BCw8iqcBq4ZbHQT93boVJ8pqrefmBflGTHgtC6YGN3Uvh1Ojw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848599; c=relaxed/simple;
	bh=D8xxxXA3Fx9ZNLVhJ13ArlD9aj7iCElKgmIVOo/UD44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rkPXBIy4e0494OAuBbi0ls7qE1pTt7H43cYNDxKEhN8XGepuWhQOn26iex36ZuCuYhu0N1qJyv7lKSTmu3VW6RFk8K7tOkQSzYEAN/IfAXCvafrXTkP6sc1sk0qxmioYC/rVRW33rc7X6c3KxKCThJXBKhP6yI2ncEp8M5ZFr8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VfAfv4bR; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773848593; x=1805384593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D8xxxXA3Fx9ZNLVhJ13ArlD9aj7iCElKgmIVOo/UD44=;
  b=VfAfv4bRIwYmv4CZUKdmUVKdm1j/8J/vLYXM8y6sNlq6scE2hyjZ+lCw
   up/49f0wFugzodn4WjHcHJ4FSIfzQ+bF0tCB4PjU5NsYO7OfpxSaWoaIh
   5i0w81SG1To2OJWWYyoKVTYD30uwK5g5N2oRcksu6AKB/N4T516LoA1xq
   CU3L6cCi8Jy2dumxIxgNaAgatSNrD4e0STgyXI5k8jNyldUYP7upGhkpH
   EeIrlPVMYUsPC6OfXhIgkFJlraeXknTUWWOrs5KcPYE14P/S1dSpenG0D
   pYXcsOilxdgWZi7XGh+36j38Z3W34UBLidMdzTuxMIriio2z0e74B61/D
   g==;
X-CSE-ConnectionGUID: CiJcOPVARMWdqIzo+AgmKg==
X-CSE-MsgGUID: bvv0Pf9xQrqTkZQvURyBRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75087455"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="75087455"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:43:12 -0700
X-CSE-ConnectionGUID: XhEnq/z7T/+sqaABf/GGRw==
X-CSE-MsgGUID: 0WrKjBusT2On/R0Ln1bGaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="220099855"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:43:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:43:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 08:43:10 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.57)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:43:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjahJmASiQ5F8SgGtKqZKfYVmovzbPMxZ+q40eXiT4LxEl+qoICLXXQ6ouGUWaeNEfLqnRNsSc/p2lqD1592hBh96hG51gRHiH0aZjToh+WrQ7XHblFGF9mul/606fIEz1+hFe9KOpU2/JcG/O1cEIXfkmv70O7VyTw+D2m24I/2Xyr1DadzUc2RF7w2LUR63vIaBoaB+TFGV8tEP6xnxz1kYaj6XZcNi6mIr57QmFuoQcgWlK3XIFXuNFvU2VIgZ5dT+KSJeK+jf67KxfL5An+GXuxlBQ0/ur3e+EUhSTWuhlUQW4alyjlv+fJvqEgZhT+GlyABPf5Fr5r3dFOs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG/CgnBsth2cJ9rdUzJNGfr83U8c1ywCqvGqudeDdfY=;
 b=cqQ5CxHT7F1jD0jPNXKGohGUlT7HDTNZO4wBvmwtbzX3Da016l1y+rT1/jH08EJhBcbD3MjcGJmKMSNH83w40LEPSgWGEcH/keKLIb59d3/WZE2xJtTqtuY8TayNKoHGzEimnOxECdsHLDQl8K7SINomMMSBd/1kVtn0KqzAZfAVzG6a7IIg8PKHAstzuSUg3WQzrG2D9Lehk8BKi32rkHe1rHe0pNepAVg6SsRmUbKEZHTol3+Bk1fMr1g2gliaHiU1d68AXR0yzw2rgt+bV2Ea81nPsdO/PRkh/yzzaw+sMzISbBjL9wAz5drUBigaLjUqajH2/GucF3KHSw+ejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6549.namprd11.prod.outlook.com (2603:10b6:8:8e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Wed, 18 Mar 2026 15:43:01 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Wed, 18 Mar 2026
 15:43:00 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "michael.chan@broadcom.com"
	<michael.chan@broadcom.com>, "pavan.chebbi@broadcom.com"
	<pavan.chebbi@broadcom.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "mbloch@nvidia.com"
	<mbloch@nvidia.com>, "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "sd@queasysnail.net" <sd@queasysnail.net>,
	"jianbol@nvidia.com" <jianbol@nvidia.com>, "dtatulea@nvidia.com"
	<dtatulea@nvidia.com>, "mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "willemb@google.com"
	<willemb@google.com>, "skhawaja@google.com" <skhawaja@google.com>,
	"bestswngs@gmail.com" <bestswngs@gmail.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "leon@kernel.org" <leon@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 04/13] net: move promiscuity
 handling into dev_rx_mode_work
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 04/13] net: move
 promiscuity handling into dev_rx_mode_work
Thread-Index: AQHctuhtemkEIJZWuki+VCylWh0HkbW0bd7w
Date: Wed, 18 Mar 2026 15:43:00 +0000
Message-ID: <IA3PR11MB898696ADD96959930056D25BE54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260318150305.123900-1-sdf@fomichev.me>
 <20260318150305.123900-5-sdf@fomichev.me>
In-Reply-To: <20260318150305.123900-5-sdf@fomichev.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6549:EE_
x-ms-office365-filtering-correlation-id: b123dbf2-4ff2-42d6-30ae-08de85050936
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: egErSePj4xLnkzSyGc4wUTJ72ePUYorE/5Wg0zQszW87GHwiGdDpgH6WO1bqx8KgRZVjJUftHVEmFebtj2g2salc6GeczFlcMYONEE0L6AGTrkXkLnwZvzAM91LU5fSu3O3EG+4ihAEEQycj3+nceP52Xj1gvuDweXaFQSL6V5Gbxgch9cs5FRIwvBFCXDbG4QJLVtxFNK9YRJHZnqFt84gMEdMutSPaxl32ldM/gQeKBtPrljz7dQL6F8NtFChAndhjI4LQfEE+ibLNfYxs1nU2Q6DDDzzaqfnsi7wxt4C9ZTDP44Yrk8nEhJzCX+zolWfiZLClvtQRSbiTyvT1N4CE0HS1nfnvQ/Q3+XnAjJSSKkQTWMSCi+5kRiUa9JDmiTFDEgnx9LPPmUoTtQ2+5/Sl2r0Cq5CxjSPsZSKNbu+lRBjh2Cn/rQ8JJnDWmBJMqt5wVVmn/SDeMW91ETjFfuqpABRWiRUofnkRlJQNzTLBqyDhTnUvMFPnPBCqH1h4udR2qapaMJa8a+/PZPkfIlksQ+Guicz9couf25y3EKoPD1dyIfn5YU7jI/3XrMPzbCI22H5eHc2ng/MJ+lPYz9cS/rN5nwVL+eD+QMINDi5UhYLw/VI4cLP4B8CtK8U2FOT4gi7F2r9as+VDhUynXKdk/UxGSQ/mPkI1Hd/X4ilGMSd91qWDJ9LOarYmF39p/3tb9EgSl+tQMmn2fX7FrReYbFurljXjE6iNPMgTPMlkfFANAuEReTD7WyrChhxMjFY+4R+YzFFrK7EujdsTjZgOuT6hUSBgmDXiAGRfmq8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wKn0KzalnNfEyV2A8yApTJFx4QmEqchc3KrR19csDtQrZlNdgvpLTpWPiaBn?=
 =?us-ascii?Q?MJ8/U4bl5aHxhSptCDUY0YR4GWlrUshdobCmOmUKjYLO3myKt2o6ap84RIbm?=
 =?us-ascii?Q?xF4RpMc5d2bJXj8KPte65AUo+pY4HT1XEnT41zWK4A538nBpXtX6So8IAdzs?=
 =?us-ascii?Q?QQ4jKewUPRZ4/BR7icPpH+DJhMmV9n4aPiY8C5qXGsnVkneN90QRPSpNqDHG?=
 =?us-ascii?Q?f1MMvQUlwicHG7aZAu06tu8mEgVifEtIoAzy03DA3YPHTlrv7R6oD2GNBBy3?=
 =?us-ascii?Q?DhhN8GH1kB+9kgDBRCfaov2sMnCOZmEphkETS/QaMGHPlzG3JY6VIXJM9sT8?=
 =?us-ascii?Q?aofkNICEZP+mqb/x4n2NQtevAqgcdLEVNB7wC8/hV1iIzEGkknexRKb/j+kp?=
 =?us-ascii?Q?2SajoXgHlziBulYXhCMMwRCrWEbjlhKOgHpghr+mT+Ypv5WTLeDicIDoW2E5?=
 =?us-ascii?Q?UeTXVfn4APmlpbpNJ7NAupJC23RvMKy2iRMM1tDRyAkzWuNcf8OSSB+/IqVP?=
 =?us-ascii?Q?ptqPtkL5YE3iws1zf7Dq4oXZd5YjBp/MX6m8NleJo1WSU5kM2yCedQZTRgf6?=
 =?us-ascii?Q?K9rjskSvr/hFUwKR69fMWbR2guf4SSn3MduEgetBgcSv7Fj5sRmC1E04SQU9?=
 =?us-ascii?Q?lGIs+AQ7IJAyvpVrVFWHfPkfPO+hDjR+udH4LdKIxZcnnVRMEIXsVDXQkayb?=
 =?us-ascii?Q?SmsM8ni5Z8dRQPLUmyy/KsQbd0vpYyJUg3GxFaI98w4as8vCNL0RgQfbmWm6?=
 =?us-ascii?Q?d7XAyJf1vM6pr8LddH3wOG2Wp2PDPZlBiTHOE/BkzJ3/piscl22nUG4UtR1+?=
 =?us-ascii?Q?3S9DSYnbaN1DBd2LEFGvqEFb4qN7r+eV+UdeHRj3I/HGHP1G1d1jko0BhH1m?=
 =?us-ascii?Q?xSl5kfHLERET+IIHVk1caufGwK1dLLS3Mvog4NhjgL3512FzHefXj6W5KpoP?=
 =?us-ascii?Q?AVzv+6q6CakP1VUqK/yTgEPVPHBevK4IvrG6VBQQGdosCpdiv4pce+BlR65m?=
 =?us-ascii?Q?JMICDSSuBQ8tMLsiEvhGiSQSp1sBERuSL5X1X7AWNAiK2dcEmghOse4S0GSd?=
 =?us-ascii?Q?E9209ZGlsDeDB9dxf/UC4gAFgktnpOLBdXJEHA6KjpdQLMJcflGS/m//4yP2?=
 =?us-ascii?Q?qZgsggXNbWE4qDMY8Yf7B9zDbeWOV4K5qTghVcul5Cf9hMlINMIjrV8Xfutb?=
 =?us-ascii?Q?m0t+Av2S0dKS2U3mJp2ibwG4eckH3a7ZZLJn+z2UknV/VqyvGR59U9OiPYea?=
 =?us-ascii?Q?4GxDqZHBMDCAwBjkFafKa/QJ++49Y4BhoDlOb1iMg34mWs5t3aisHGwjGA8I?=
 =?us-ascii?Q?k9T9MFhBo5LbS9/XqrdU8WU4S17xwUMOIwuWfTYH3v5EgB9dubW2jg0WQTmj?=
 =?us-ascii?Q?XG8TS1hKbNUtlJnlQ/n7iNLgQYfDgl2KHHGXbJYnxvNrNdAoUj5b/YGCE8RL?=
 =?us-ascii?Q?BZpk9VRqS0WlGNaIhT5dvvM8TR91HoU69BR8WTRBx5jnQgUFMaB9ESd4xNfy?=
 =?us-ascii?Q?eBGm1MxGm0aNCjsn5CpJUnvDzTaycowbE+iZPP+RSHasbPjH1VJA5waLpUqf?=
 =?us-ascii?Q?2wMazfMKQmOz67b8rB8PVnW7LmwQlQfxv7G20BDwj8ULxk1O9KkH2yCser6X?=
 =?us-ascii?Q?+tTMTwYPP7Q/yvsxbVzYBdoq6kNsSkAEFEHSaJ0Uo949oSehJJmGdgH/1dog?=
 =?us-ascii?Q?F62oe5F+6Ai6NwSVio3sVqucoqQNVSb9b6JQs9LntLzdKGMMsbHigDBUTjtR?=
 =?us-ascii?Q?/R46fj6OOiaXHOC9wmG3E9muruq9Bwg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dSsQGwkGePjNFGJAlkZMkHipmJbDTcosz3A14tzM8E0/iBWRyzC11f8B8w4/0T+o1TFvUL9OeCkKx8NcELq8QaoX/EsdybDrOAE1ISQyXI6Q9y0Wc7qJdBDxUgT8KU8Jgb/w4zt9eM3MLB2UbgXCcZ3AM0Cn8w551DeOBJNu6iRsXy85lqt9b7sF0wwvg77NFiqek3SzlaW009pctcdBBKlGFWPGfmBkgIJZof6SZYkdMBV7GdDQtpA7mYWzyRWC6ROToQWYvI6KYQHPY6O9+XfJtZfkIBjAyyRZ4gduc7S0EqHMTnPjRq9vYkyDWayzqKR5JYrK8A/SdhVHRQ3Jkw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b123dbf2-4ff2-42d6-30ae-08de85050936
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 15:43:00.8558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDkOR0huHxfjJ1se/G5mzP2rY7VxkqKauSdN0bVLrXingnWsf85/pDaOiGeYMt7F4a4989JY602QuC/Qb6iyP2mL1eyEfY/qKhk0+VILlxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6549
X-OriginatorOrg: intel.com
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
	RCPT_COUNT_TWELVE(0.00)[35];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18347-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,vger.kernel.org,lists.osuosl.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.957];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 11B312BF495
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Stanislav Fomichev
> Sent: Wednesday, March 18, 2026 4:03 PM
> To: netdev@vger.kernel.org
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; horms@kernel.org; corbet@lwn.net;
> skhan@linuxfoundation.org; andrew+netdev@lunn.ch;
> michael.chan@broadcom.com; pavan.chebbi@broadcom.com; Nguyen, Anthony
> L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; saeedm@nvidia.com; tariqt@nvidia.com;
> mbloch@nvidia.com; alexanderduyck@fb.com; kernel-team@meta.com;
> johannes@sipsolutions.net; sd@queasysnail.net; jianbol@nvidia.com;
> dtatulea@nvidia.com; sdf@fomichev.me; mohsin.bashr@gmail.com; Keller,
> Jacob E <jacob.e.keller@intel.com>; willemb@google.com;
> skhawaja@google.com; bestswngs@gmail.com; linux-doc@vger.kernel.org;
> linux-kernel@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> rdma@vger.kernel.org; linux-wireless@vger.kernel.org; linux-
> kselftest@vger.kernel.org; leon@kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 04/13] net: move
> promiscuity handling into dev_rx_mode_work
>=20
> Move unicast promiscuity tracking into dev_rx_mode_work so it runs
> under netdev_ops_lock instead of under the addr_lock spinlock. This is
> required because __dev_set_promiscuity calls dev_change_rx_flags and
> __dev_notify_flags, both of which may need to sleep.
>=20
> Change ASSERT_RTNL() to netdev_ops_assert_locked() in
> __dev_set_promiscuity, netif_set_allmulti and __dev_change_flags since
> these are now called from the work queue under the ops lock.
>=20
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  Documentation/networking/netdevices.rst |  4 ++
>  net/core/dev.c                          | 79 +++++++++++++++++-------
> -
>  2 files changed, 57 insertions(+), 26 deletions(-)
>=20
> diff --git a/Documentation/networking/netdevices.rst
> b/Documentation/networking/netdevices.rst
> index dc83d78d3b27..5cdaa1a3dcc8 100644
> --- a/Documentation/networking/netdevices.rst
> +++ b/Documentation/networking/netdevices.rst
> @@ -298,6 +298,10 @@ struct net_device synchronization rules
>  	Notes: Sleepable version of ndo_set_rx_mode. Receives snapshots
>  	of the unicast and multicast address lists.
>=20

...

>=20
>  	/*
>  	 *	Set the flags on our device.
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

