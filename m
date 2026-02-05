Return-Path: <linux-rdma+bounces-16569-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE4LHGZhhGng2gMAu9opvQ
	(envelope-from <linux-rdma+bounces-16569-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 10:22:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA392F095F
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 10:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F340E305AAD6
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 09:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840F438F23A;
	Thu,  5 Feb 2026 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1IZbMB4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A803921CC;
	Thu,  5 Feb 2026 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283172; cv=fail; b=kvUCX2lT1HazbzpEPEA5xVUZTKCpIrOZHhj8b1zNYuu8keKfw8rFWOwRk2UiItrEGcqFks8TBjh8XpksHEgFxU0IFKO84dXuQtRIyZ1iRiB9iFMqdByU6HvfjAlg1Z1DtZcJNqtaQ2yD/8vtPnLbQmHmA+mw25cM/w8rQtstgf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283172; c=relaxed/simple;
	bh=t9/aIMCmu+ocy0GzOifrHfk7mgSUxYYjY4dWzwrrTiw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G/KJYVNaO3Uv76uiqz3qZGekdDR8bm/jq4EuNOwcVeg14frgxs+ylWSkw9jW5bis6h2E2P6yderlYib5LZF918dpbK5EOGYyFMopewB+ZJGjNEsUnOvgS55jd9sx0P4GkICn0rHlpvwfslF/xA7o1slazdvaNbiH3GUKgU8MlqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1IZbMB4; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770283172; x=1801819172;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t9/aIMCmu+ocy0GzOifrHfk7mgSUxYYjY4dWzwrrTiw=;
  b=V1IZbMB44sCaQ5L9fQFZcTYQom4+0Px1eIh9EgVY4MociU7k3oIYylvd
   8nDyoVS1dl2T9Tc4t+7aGu3dbWcQu/OewmjT5akx6iJSujeJ8MAg5ZNqx
   lVQPtv3ShPr9VQQkbLmSpiVvYqjI2zLXGAZumvzViRrCJKlPUQQu65UvP
   3DsfFQQtPp6RneKhS/MszddLg4gsb83fHarEqxOnQddh1+xO5s1GrsTcO
   WFr5tWhXbSSjGTgrBr9gJTr4SsODBvLFArarbdvlM64jR+NN9gaBpgjzH
   7k7y/MqGsTWUC7RTa/+iQjQiTkjGbcpueQja9ZfO2cxi9D/PuTFNGEO5t
   w==;
X-CSE-ConnectionGUID: pXtQcxWaTnS/tWmdCf6jHg==
X-CSE-MsgGUID: vsZ9SBYSQwu0V6mH0srYdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71653711"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71653711"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 01:19:31 -0800
X-CSE-ConnectionGUID: g4914OmFSBiylNIcFuUQjQ==
X-CSE-MsgGUID: 74Ej0fWRR6eserRepemKIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="241124327"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 01:19:31 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 01:19:30 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 01:19:30 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 01:19:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fw4alaSQfIw3REkTTnk3+l3btuz6Hqeackotm/vDKRwTHDVmLveDqY8MXa2HizdS1CS28fUXk7iAOKKOOZPDnzBVhNKFjwCoZSiLio1SaJx6agSFhx93V8ZjMG4rLxaCyJQEF4oMTiPxpnSoqIH5kQb1CF0YQqG+wZkUHD3F9jHmYp7x0BYXuLgWusXf8nE6/GtExahXGnUeMBIdkDVx4447Z+zGzef/SIp60Sd2rnW4kMMLF2sTY3l9fNqH44MQ7UdQXOLG4UwRb/hjJV9Jk2dKGQF+0yY/3EmK3dv2JlZqwElsqJcspySvg0EtYViG3tSxJ4HBc4VjLfy2wL6SsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZmTlfr7HUjvQTgg48PSyQtF0VHJucEaI9zJPa1ZP/U=;
 b=Yb+pIeJCULFI5KRcAefzCH96jh4paDLI62kbRzKBg2HClm7rDDid2qK/6lKrKh5rKNWUoHxErOzDXUN2dCuJbjE4JwepY5l5xGMguo0jhxK2EHafOqqX//5eF0NbzLbv58Z3HveuaWypS7o9H/TI1yRO3876O+VjG3Tn6cFFw2wGPYnvDlizWowq26gslvrhk+dIneyXJICikz6A9tv1r9g2z3QiGO/C6+Ohmkd/8zZ+qpZjhzeLN9sfFKvYEOniq8UdgAHCREPTBoLSpLAbLiSOyjFM/Ds4k0SE2/Ek7aQdNDiYmtuAmC+tyDVSkgm0M8wtLBG7iyESaymOf48uPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14)
 by CH3PR11MB7866.namprd11.prod.outlook.com (2603:10b6:610:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 09:19:27 +0000
Received: from LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::6f0e:9ee3:9e98:1ed]) by LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::6f0e:9ee3:9e98:1ed%3]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 09:19:27 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Lemon <jonathan.lemon@gmail.com>, "Leon
 Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Paolo Abeni
	<pabeni@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Richard Cochran
	<richardcochran@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v5 2/9] dpll: zl3073x:
 Associate pin with fwnode handle
Thread-Topic: [Intel-wired-lan] [PATCH net-next v5 2/9] dpll: zl3073x:
 Associate pin with fwnode handle
Thread-Index: AQHclTRDvFh0jcwHJEKpUXWDZ5CO4bVz0fKg
Date: Thu, 5 Feb 2026 09:19:27 +0000
Message-ID: <LV4PR11MB94913C3EABBD02E6DFFD0B679B99A@LV4PR11MB9491.namprd11.prod.outlook.com>
References: <20260203174002.705176-1-ivecera@redhat.com>
 <20260203174002.705176-3-ivecera@redhat.com>
In-Reply-To: <20260203174002.705176-3-ivecera@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV4PR11MB9491:EE_|CH3PR11MB7866:EE_
x-ms-office365-filtering-correlation-id: 0a6506e8-7ee0-4f09-6970-08de6497a92f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?uKHLM+VDOWWAGQjwbFC+oSMcyIWItXcEnsWro4vfud9wl/lstUJoNLWi+Flg?=
 =?us-ascii?Q?Zxi02xTMTK19ADmCtV3hinCgONn+zQ1BizjsGs1/70pwn8Ci7fN76OGglVBH?=
 =?us-ascii?Q?H4g75qeymthnmgG8qZsxlvfsuh8PZapqrVk48OzYCccMLFZs58y0GHlMjNwc?=
 =?us-ascii?Q?0FU39O/JdGluMxj7PfIcZx7QjquLRjmM2q62G929C7UM/GvFnBxZgnHmb7re?=
 =?us-ascii?Q?QYiepa9h98DXB959UclUVGdtZv/7mlxzj84NjPKvSCtjAWvXcinP4BOxQwTa?=
 =?us-ascii?Q?khZLmBmj1XbfE7Q0rmT2yy5xWIIvvb7fWyKpiid+iuYHJxoffoPWUPDaLWIr?=
 =?us-ascii?Q?/ItxmEpy06o1YsSIjQ8z5QNwVaTZlTH+Kdpf4G6k4m1AzgiTtf+2/b4eKbMj?=
 =?us-ascii?Q?8mqj7V9a4BgbYdTZV3mxnmj42ZuTIAtoGwh4uaUg2nbKLLmut8IO27iDyrlU?=
 =?us-ascii?Q?DYW497MRJg7smejVhJguQDB5oFjo4Xitcea+cTNFf5YDlk+7CFIWlUkleACf?=
 =?us-ascii?Q?kVgqZalDKAq1gRb7xVw7u9je414m2Uqc81K/Gwzy1vCWD7u9/ddIc1onNlp6?=
 =?us-ascii?Q?1Ao8gSAey4BpnrIAXcj5trh1mhvcVQ6rtV9GX5PlOJvXb+BtS9TPz+meGICg?=
 =?us-ascii?Q?/Fl8ct4DS5bH+y2ulTeqQUKF/esPR9rKw9EvfAHJB2ddlwUm0h32mzhwwqHy?=
 =?us-ascii?Q?3cuOJ5zil7gLnlbcx+5OwjMpNFkWnBQnbXCMYQ2oNjavb71rPCBB48eWZ5yG?=
 =?us-ascii?Q?5U0p4iB9H/Bzn4N6uMl66Ul16TuZKCbvYNz7B21g9gWVSm3eqZZwtqbbk52/?=
 =?us-ascii?Q?or/pxOlMgpB4eemehlEFZcJftJd331VEnrI3M75pkY8tO5Q0L9t3vERieU6J?=
 =?us-ascii?Q?n6fPVKuNeQWzpQyAYQ/xPXRhe3Zz09b0lmnM2Rp9y9QjqZLKeVjmTA8i0Max?=
 =?us-ascii?Q?CtjmPGsj8tRJY77A0BCOJf0VgeP9QjDDmEjRajaLFLvuf5R+e50LRP3I8CjW?=
 =?us-ascii?Q?6EbmmF6u+dDFBp3MukB25G/KP/8R9+Kx75JumphJuk2K/A0mF2rxvWmnOlCr?=
 =?us-ascii?Q?t9O1+866wBVj8PCAuIMfKrMrLFjRJgnBrGQSf0d2HS728fsdEXZZ/WYG2Ck4?=
 =?us-ascii?Q?C9vATeExz4MQoYEURTcFzo2+YAJZ85HD+6Fs4UN5fpORQeyFzvqT7l6rkByQ?=
 =?us-ascii?Q?RbDXrURfe5liUi82oCgX4DrhTQDebMLGTe4pVVuy05d5lwth4rmSi6+g8tHU?=
 =?us-ascii?Q?D186wXrrCe81jAtewquVaaUmTlRfCBsNxl82P+VPDoFA72TRGCgb7hFte5nY?=
 =?us-ascii?Q?yUGHF7d4Loztu0XB/T8hwU7uwIDG16JetigE1rWfHIW/h59Az9Kt9tLngrdo?=
 =?us-ascii?Q?sc1NgsS/unYx0EbUAsMYHF3+xeUI2f2mR9Dshwi0ZIX/KmDQh+y92hrAc/uV?=
 =?us-ascii?Q?1b8ARYbm+GmS3rEhubz78OtPkBPqn+nn749jv0aiKsMKFFrXlf36ScP4eOnF?=
 =?us-ascii?Q?4GCG3s+zaQpO+AHKr16Z/MUBE38CTM6FSXcCIzP/PmcMTe8bflLeDtDjAniP?=
 =?us-ascii?Q?pa5plUKG04cac7FrjYupZePcWMWZwo9BXi7ogQxhkvPsETXJsGwcApufBctG?=
 =?us-ascii?Q?8As3YBMxCUKJO9qIpHXPqWg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV4PR11MB9491.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7xun//B7ymySc/xCg508GHIaP8KGPN5QALTVYEQ8D+EJY7RlKriUZfuMYL7p?=
 =?us-ascii?Q?Lz8DacssRfjSjiAir5MP6qgb8ZfKCJ80YugLbNKtYPd5RZSKdbYzFnCd47NA?=
 =?us-ascii?Q?pzc4wuioIw5rn2s8a7y20OnwlP6mUhWwGMXtfJa+WTgPcp1rekCGe0RW35P2?=
 =?us-ascii?Q?3bKYWEwcEu5dh8I46BMhlaICvMsryTrABbaRv89KgvhI8OqH5Rfgjom+gFNW?=
 =?us-ascii?Q?jXENq21Rmve9phE1qPvj5R50I8gGWJQlKjxPGZR9SPydRTxgTM4vVesZSbuK?=
 =?us-ascii?Q?rHd1wiikGRNNx33/scwAUbz1p+Vvn6TaPgSlvt/JGxFb4byK9Y1N5lrN5Wqa?=
 =?us-ascii?Q?rdmQ22UEA+uO9ExqSEk5lAoZCn2Y+cQChV0vterOalN0HUCurRqtLoBb0JyT?=
 =?us-ascii?Q?YBD78CHjGFUj9UII6agA/97ek3WoYJ6sQkjZn+KSb6pt4OrLqwCOV1pOfXPG?=
 =?us-ascii?Q?zGCqSqYxg/r4p56XUypzQ0BEqsPGXEXNvd2fohwz4Sfj6FMOlN/ftPX0RTz3?=
 =?us-ascii?Q?HoQDf4j9TlgAbnrclQIiJKrgvXOzgXCoOghs1nqR0jtkmnJKTb6ALonzP85d?=
 =?us-ascii?Q?qkUILo11loe7vpD1Pmzm2S+4+FAycBC9pMEaCPuC/GIThxCTAkzWNZBJU/8m?=
 =?us-ascii?Q?VrqRYT3mG6uTvrT47+1UWfVndHpDJc6fT6uGUD8c+8wWArZC9wtsGK9J5fTH?=
 =?us-ascii?Q?7UIi1iNSkTPLkjDgya5uWTFHG9kSmuCTLRYy0IhUtn+FtgWIjPtZrHJDpaHM?=
 =?us-ascii?Q?sNnhZE4HBKSv00EFYpWb9okRhwIL4uA43/qdMoAXbukgW0TME3v/9o+cs4Rn?=
 =?us-ascii?Q?pmh5rxvCqeVC+D1Qr8pcCUiKJK+ao3jryDD4SmVFhbH0lyvfS916ThBnNHsa?=
 =?us-ascii?Q?hX7kcf7TSIsiLDambWwAzSxpEhQSrxvX9wkXKALLSo+FeE20oy9Ig/LMgsO3?=
 =?us-ascii?Q?ulmA2xsMuRbK2Co/NHDq0Nh/RCXKDyZjLviXUAO40Xnc6vKWJ2bnh89uuLll?=
 =?us-ascii?Q?ynjERoGbrKkNIWlBMKFEtDaHSm1xllSORGVaXgmb88w/9dDi6JMx9Gtp6Sn+?=
 =?us-ascii?Q?2dMRJ8K20IePPKSj+u3eCWkXm9Eoph1o/ZkDHyV+2dGRr7mcsH0hBkuqlUco?=
 =?us-ascii?Q?FH89HDjNvqKI4Yn736clQFVHlRRZo1jvsPH4Yf0GvVVzPzi/dABk58wPeWON?=
 =?us-ascii?Q?MEOCF+pe6PeBZ0kq0w/m9yA8AQPJZAa/UMm4+TZCTKMN88EC1XDux/rfXz13?=
 =?us-ascii?Q?eRm1Ktru8g53yYvuoyUZUzmiUyJvsnRt+GxEoNdlZJXOIzvzeAyupOWx7QLE?=
 =?us-ascii?Q?gij42bFAwyohcIox5z4chyHE58X1qOBjFbziDWH+0571QZAxKGq6NQ1v9d1H?=
 =?us-ascii?Q?IDfLJUGtwglK9iFwjb9JJexs/aHmnvff8+OhRK4cUrwgI4g7H8KPc078tl//?=
 =?us-ascii?Q?EVoSiu3pN/myOlQLRgywBN80P8kXV6nK1hLg/NFEG3XACUd49iMSw9+cDuEp?=
 =?us-ascii?Q?+lT9EW00nRSsgdBP+jNd0CvsZujyxBez/vQenLH4L5WFzzckaVwCwlzc1XEq?=
 =?us-ascii?Q?47PDgC9luJSh9Vm4n+XVA6hSs+P690sWErtXei+aSZ3W3Xpc420D05o6o6RQ?=
 =?us-ascii?Q?E0ks4mdwW0+2ky7wUeoC6c4yePQfZTsWecVvkQZzR+vSenfyAP5jARtg+F43?=
 =?us-ascii?Q?uuY5LQcvbUl4+2lrffXJIQqaVyM2oUJqNiCJwwKquOpiWpODhP4SptuWDIMa?=
 =?us-ascii?Q?jCssPi08CKu73YOqe6aoEzgOqXvkUhc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV4PR11MB9491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6506e8-7ee0-4f09-6970-08de6497a92f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 09:19:27.4177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5f6QKuAE01LoZYGIaISiD0l1RO+pQY/Hg0dwBB7vy4q06ZSCeIZrudq4KrfQNn8zr8k7MLmsPAc1oXc8uEO3RoXUBcbVrbzfFiIBgau5ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7866
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16569-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,redhat.com,microchip.com,linux.dev,lists.osuosl.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,LV4PR11MB9491.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DA392F095F
X-Rspamd-Action: no action

>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Ivan Vecera
>Sent: Tuesday, February 3, 2026 6:40 PM
>
>Associate the registered DPLL pin with its firmware node by calling
>dpll_pin_fwnode_set().
>
>This links the created pin object to its corresponding DT/ACPI node
>in the DPLL core. Consequently, this enables consumer drivers (such as
>network drivers) to locate and request this specific pin using the
>fwnode_dpll_pin_find() helper.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

LGTM,
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>---
> drivers/dpll/zl3073x/dpll.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>index 7d8ed948b9706..9eed21088adac 100644
>--- a/drivers/dpll/zl3073x/dpll.c
>+++ b/drivers/dpll/zl3073x/dpll.c
>@@ -1485,6 +1485,7 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin
>*pin, u32 index)
> 		rc =3D PTR_ERR(pin->dpll_pin);
> 		goto err_pin_get;
> 	}
>+	dpll_pin_fwnode_set(pin->dpll_pin, props->fwnode);
>
> 	if (zl3073x_dpll_is_input_pin(pin))
> 		ops =3D &zl3073x_dpll_input_pin_ops;
>--
>2.52.0


