Return-Path: <linux-rdma+bounces-22835-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xY8/Kr0JTWr5twEAu9opvQ
	(envelope-from <linux-rdma+bounces-22835-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 16:14:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 823F071C6BD
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 16:14:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=lSQ8WJKg;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22835-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22835-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 394E93066A23
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 14:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A83246F4;
	Tue,  7 Jul 2026 14:11:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015073DD875;
	Tue,  7 Jul 2026 14:11:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433503; cv=fail; b=Cy2eu3RBEyY3XbAKtYos67iH2D+GKX3svs73a0eLROIGM7OuXsz6+9ZUEC3/yzsv1RXm0+TkYrF5A/C63CRsoMVYeaivN4PE0xUhssf6uuzzcznVoXx1zaGW3uj7hSHTZJ7kiAPK3TIPqVRh3l1FOK5Vcwov7yMRHV1PVdLDf6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433503; c=relaxed/simple;
	bh=YFqGF7JcvJ77kEKAE0ck89Fs/i4iIgCMRRiE1D9O11k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jj65Mh8Nu1wBnqj6vvtbgXYJs+V9Oa3z/bWIbEn9jmaQ9Lon+63AyPcMfZyczGTQXEc89Jbx2wsfJjsSWkI6AetsN3DWWYUu3a/BV2rXpab9utduQ9emT9XSJXx07NT3laJS7mAfMdJQ0LcpETZLURfPLDHCfJLUQ3dKftiHwbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSQ8WJKg; arc=fail smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783433500; x=1814969500;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YFqGF7JcvJ77kEKAE0ck89Fs/i4iIgCMRRiE1D9O11k=;
  b=lSQ8WJKguK0xxj5nKKHF7mueW964MPocyiFu3d31iXYx1MpHbbXUQYnf
   KdrM4pqonFI3WZPbrnF2KMFVvtLOtV7L+3+hjv0u4ljgDIqqwsCZ/zqa5
   3np1YgYX9a+LZwR7fA9wk9Hf7DlF03s+sLoRdzZe4BxVSMUtfqR9xZ6mF
   UrEhNtL1Y5we2Igk0zKwQ2ikdzxhhKyiFBWqfWrEbPQCfd///295OEZHp
   ssBc9H1WOhkzycT5njxGAbqMQRC3C9gMUZR/ggFSPUz5T0RiuSMXREvYK
   Hfcd8//oUVo7CLFXoKLBdWPCUi3nZav44kqGj480Vvu4idok2xadS46IV
   w==;
X-CSE-ConnectionGUID: ISXfmKfGSpG5k218542NDA==
X-CSE-MsgGUID: S+lLfKSJTQSGZa9+gIXM7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="101626788"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="101626788"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 07:11:37 -0700
X-CSE-ConnectionGUID: LmAFDvFLRkWmIIHdtCy7NQ==
X-CSE-MsgGUID: 07jlqmS/RCOziXsDLdwQow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="278373367"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 07:11:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 07:11:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 07:11:36 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 07:11:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CihS/HRiRqsEY+08zGDHrPs0XS2QEWN6wQTpvubyGiONNYOiTOY/FdQfAOIpIUW6fwiVsr1vC+BgsLzg6euXW4VkyZKml5YcV3QqjrxKk634gTQUKHxvUdIHTl9iKzH0iz/9RwyoOaGz+JEPJdry/gbPps/PWrYdK+FQc6ZgKR7UXlG3wTVQ/efZseBjDe2JNfOS7hRdPJTyuhZleb+7WWkF6gspZqFnQzyXoUoERkgNbhTgtR/Va/X4x48E2bjvtbGwetzuhh3tfFDsG/2lZhE7O+/syUtFT2otovCrrChhH87odEWAMf8vD8fKBGthcJH4qkxNOrJQwm2W+Fe5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytdbCEIATY/P5qP2T9TYOoX66RZ7qrclljKzstIFL14=;
 b=HJ27LSHurxK20aSgIIEPWS7Z1PrvnQt6NTtPxdBF2OINwcX1/nLIU4upAlgbNCtnmOxFDvHntLde4bxQHDjD4ishiwb85RUl3wl+gCVdk7MPgMqttptCc9bFbJgam681rMTk7beW4PG7sEx7VS6BcNzKcFNIogPQxd3WQFvMBUGtSvgj8SAOmBNKPxXYGcWh/JNIiWvO7u+TZdhGnMuuLQQ2Afw/c6QcvCzg7mpguT0mpLo1t6uIZkgIwJP5ZBf1l9EJpdilJ9JfjzM1/9AZzyhlp0xZhxnBLtTwa2qkoDT7h6WX59XydsBHHBWruVDZ/ioXWHHCMYiVQWt3cUhoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM6PR11MB4753.namprd11.prod.outlook.com (2603:10b6:5:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 14:11:32 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 14:11:32 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Boris Pismenny <borisp@nvidia.com>, Chris Mi <cmi@nvidia.com>, "Cosmin,
 Ratiu" <cratiu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Keller, Jacob
 E" <jacob.e.keller@intel.com>, Jianbo Liu <jianbol@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Stanislav Fomichev <sdf.kernel@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: RE: [PATCH net-next 01/15] net/mlx5e: psp: Rename the saved psp_dev
 to 'psd'
Thread-Topic: [PATCH net-next 01/15] net/mlx5e: psp: Rename the saved psp_dev
 to 'psd'
Thread-Index: AQHdDhIU5f5ht9cp7E2adXxx+pvOJ7ZiGMMw
Date: Tue, 7 Jul 2026 14:11:32 +0000
Message-ID: <IA3PR11MB8986E9B13FB2F4B3530E7D8CE5F02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260707130858.969928-1-tariqt@nvidia.com>
 <20260707130858.969928-2-tariqt@nvidia.com>
In-Reply-To: <20260707130858.969928-2-tariqt@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM6PR11MB4753:EE_
x-ms-office365-filtering-correlation-id: 537fbdfc-39a9-4ec4-44b7-08dedc31a581
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: L5nBYNe/p3BV0qPwMevClCKd2zz0yqNzRn+eULLhRb+LO2i4/Ch6ILG0+ZtT2260NUgJsf688nB8zvIgA/7lJ+YrJaIhBvr7XPkjypVAAuGV1D2Ht5YhjZ/3B0Z/0nj4PsNWawZ0DYZQba2LbjHvBPR+YY7RyHlohLllJVaZmc6IUTyKp/hLSRArYg/NpRV3OBKO5eIWUl7aXWYxKg2lDIm18nhmlr/9s3VhcjoLOY8j5A4VW5FscCMWXUNFGcm0pV7aG8EFWbhjyuNUBlsbxxGTzN2Ty3uoBFCHkR1yijU5TI70wR7pIOsWCINrd0inUt4dqxHdARUQp8Tz3j1zDEP+yuCm9n4kQwA2vk3crAbpX3Cq/dEa/6Rx5bTPyq1KaUbzFsFbf6742EiHUCjNm4hkUB6lcefosa14DQBf2JlL0x9Vy8gFngUzgpL9byM+cd4EewOzV+GCcFXT7kBfTWEUEP82ZsULcP8gQni+z8p6/cNIKs0RKoD9RsBZ/BDSJqI49QC00WaWKqS7vdEpoiYgBTj8s/NoDd68SeD9MJgKZDUxoaeaEQ25PT131cOrB0C6+dhkv1XMWZf3peLeN1vBSHRcNzvJkkaefQyAKLGBG3SXL2uMvvKAMRzF6Fd49MBIfE0bbyT53ctjBeqDSsM8C6odKu4iDBg9AD+qAgnyWoKdrKQbuetX+XPC9qQdyZPbacRDLzKD4DoUif2d87jTdSsvLEsr2KkVj6DPkvI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8wN+4rmcM0buQXKh5CwkR4sDuQUUEu5MgoeIqlwhb4AGd1tgX0FiooSHJW29?=
 =?us-ascii?Q?F+yLy25TNJ2nJzqS1qdcQRBKMk0m7S1eAecUzuNK0VIaSBxCvpIPav+enGv6?=
 =?us-ascii?Q?vtHqQ8aoByl8dnoOvMvEXW+t7uZefYY9BKZmb3oU0+amGDFMm436DBTB4Iz7?=
 =?us-ascii?Q?XJwOsiLSbJy/4WJ0PC9MNFEu1289lFoNC5Pgt4griM8+fg87XVc3llGphaVq?=
 =?us-ascii?Q?Xm/Nm196vjKZif28oRYw4oYlZtIIWkjwGIlISOmfieDT9DLUrz6cy/zUsMdM?=
 =?us-ascii?Q?Nf4w3494/+7dWx5UwKsBK82XAkDE0oah8q1c1E8hlfhLKE6YuRjcIKY15LKj?=
 =?us-ascii?Q?fsiskdnbnSqDP0cr37/M8NPVs7hc3bl/lDyO5Dj0yohbraztcx33PIYemx3d?=
 =?us-ascii?Q?FSYj2OVv4HyKz24ghtRhbkzJt7JFbx8YpjjKH8mwgvUA1e6OsMmNPfzomvd5?=
 =?us-ascii?Q?kEfPNqsK0wyByjbdcG58Wrt8UVb9xREANUYf+Hn/H4L3qhCRnSOAOdKYyVoC?=
 =?us-ascii?Q?TfU00HGTXhg8l7boO7mzya9t0CJemxy3TK5VWw18RqFmor0Eisy6HXF6S4mn?=
 =?us-ascii?Q?12B/LtBGMSyrZSoomVq/43smU80xDY6nFyMVNUvB/bY56fSln7S1vj/dg/RH?=
 =?us-ascii?Q?6LleItqkbzoLefh26+YMPkLvE4iZRefylS0AXQVS8tHsOF9+W3J8wi4wPJWA?=
 =?us-ascii?Q?Yt8jmEwz2+SBxxf9DIjyvVwF4Xi7dfo/nBZ4LVagcym1E8EB5lEpb6LsPN4x?=
 =?us-ascii?Q?pPyP7qY84lp03kAXCE83//yqmizw2JlmwSXK3ekplHa3IIiTypMefSp4r931?=
 =?us-ascii?Q?tupE9LdtI34I0/tI3wKwL68jwac63Ie/W7r9XxLHq3QPiv5pzj5FxinlYU1f?=
 =?us-ascii?Q?f4n/QoLhy7Dn+l5mvCnxyyyGBKDw4SpQTCpC1VFVRMZL0cxV+LcBZfv/2O6j?=
 =?us-ascii?Q?ecLO88qKGb/0LwBTcomZ7H7IKLsoZ1ZOKKsDwW9m+UzHONWnocbVT0e2kbt+?=
 =?us-ascii?Q?mVJml+fuHAdQda0ZAfpzFtySeJ5ZgAbRa/WXL5l5rUJae4a10o3y8VGG/okG?=
 =?us-ascii?Q?7h2hE6OMo3rImEQ4fgIeMSAnW3wFaCTPaqttYfMtyLY+wkNhDZNhJYJqR+1Q?=
 =?us-ascii?Q?Q/fcyJMnj3hODH5C//Sc1YJpIUop0C8iPIrkWXDeU9ZRgeINboN0GZ8s+3tk?=
 =?us-ascii?Q?gqkKmWACqhsiP8OcsDKhG63lKVqTBHEqUExujXyjeU3oV4GgZPnJaF7scNOW?=
 =?us-ascii?Q?e9hpU2gztLXbV3W4ewJtNiaQu2+PAmx+ywylx+9kGRrTB7g1XRM7P85eEAge?=
 =?us-ascii?Q?ZWP7MCqYUw1ufpxurARoigvbNZIkmXhpbARPeHPUkxtnlLS6z0xMdCR15uNN?=
 =?us-ascii?Q?kk1haUtYIOYZcn4OWHMFkqyDS03q2qSnoK6fY82NsSQNHUq6qZ9fSoodSkEQ?=
 =?us-ascii?Q?e/W+XWvmEL+MbwsgdT4zIpq4GoHnQnCeTf1s3LKLPdI0G3FQg7/tFtoUrS8Y?=
 =?us-ascii?Q?RfjyqWkLgkCC5BnM3j+i88RZdrrZkgC4WXjSAogB6ulpU0dyXkHKZN9ta0u6?=
 =?us-ascii?Q?IlkW5UHgZ4C4XouMRzZ24z2Li/hwOQ96OUbPQuroHzNi9s8aUYnhvFrDXDPz?=
 =?us-ascii?Q?JxQb9C5kdxypGmDKB+1e+a0GWwcIVnLbKE+5Ke6b9FzNCV7/qR7T9P+wRV84?=
 =?us-ascii?Q?sZ0DsOlN/V6NyKYebz3YV8x9vglTsGLJkzTDDYOOjRlIqL2sfoFoTXallwMw?=
 =?us-ascii?Q?/IX7EqmXSnXijrAiAbIns7NB80CY2T4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OeIhUbk++09oP8hD/BdQ9bdABs1RDe260csTHmhTWkhfKEsmPKJ1GcFkOeIfCSxjn/ePm7/qSiaYD1hUcL+07i60l+qvxK21S8kACmcVUPNL95UFcHpX3aO26mnqUma1967k2Htno8MKjNUErRUlqib/HhsV+Ql+3BXP5NUV4euB+yFBAxo8k3ln+5mohGGhEHY/5pt6DDJibwMZexiQEHRQiZW5Zq1GyT80u7FNDw5fdN3dIo31pjtajqKosXubGyz8eGgGemhY+J3k8HgrvNjkJzHSm95eBDRVi09tV8WUO/vLqwO0f74yBONJn6tJFSvOOPQcoq5nrH0s+Y6h+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537fbdfc-39a9-4ec4-44b7-08dedc31a581
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 14:11:32.0824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EIKakJQrNC6xHRL6VQlwj3wd3INqLKGmmgyo66kfE7TaF7MAJBbDmbzyttdDmiyE1iQWdguI7k8stSaU/YNK1iOp0pl88+j9kRVQnx+7zCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4753
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22835-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,intel.com,kernel.org,vger.kernel.org,fomichev.me];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 823F071C6BD



> -----Original Message-----
> From: Tariq Toukan <tariqt@nvidia.com>
> Sent: Tuesday, July 7, 2026 3:09 PM
> To: Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; netdev@vger.kernel.org; Paolo Abeni
> <pabeni@redhat.com>
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Boris
> Pismenny <borisp@nvidia.com>; Chris Mi <cmi@nvidia.com>; Cosmin, Ratiu
> <cratiu@nvidia.com>; Daniel Zahka <daniel.zahka@gmail.com>; Dragos
> Tatulea <dtatulea@nvidia.com>; Gal Pressman <gal@nvidia.com>; Keller,
> Jacob E <jacob.e.keller@intel.com>; Jianbo Liu <jianbol@nvidia.com>;
> Lama Kayal <lkayal@nvidia.com>; Leon Romanovsky <leon@kernel.org>;
> linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Mark Bloch
> <mbloch@nvidia.com>; Raed Salem <raeds@nvidia.com>; Rahul Rameshbabu
> <rrameshbabu@nvidia.com>; Saeed Mahameed <saeedm@nvidia.com>;
> Stanislav Fomichev <sdf@fomichev.me>; Stanislav Fomichev
> <sdf.kernel@gmail.com>; Tariq Toukan <tariqt@nvidia.com>; Willem de
> Bruijn <willemdebruijn.kernel@gmail.com>
> Subject: [PATCH net-next 01/15] net/mlx5e: psp: Rename the saved
> psp_dev to 'psd'
>=20
> From: Cosmin Ratiu <cratiu@nvidia.com>
>=20
> This is the canonical name used in the core, so try to be consistent.
> No-op change.
>=20
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c    | 8 ++++---
> -
>  drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h    | 2 +-
>  .../net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c   | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
> b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
> index d9adb993e64d..4f2fa6756b82 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
> @@ -1072,11 +1072,11 @@ void mlx5e_psp_unregister(struct mlx5e_priv
> *priv)  {
>  	struct mlx5e_psp *psp =3D priv->psp;
>=20
> -	if (!psp || !psp->psp)
> +	if (!psp || !psp->psd)
>  		return;
>=20
> -	psp_dev_unregister(psp->psp);
> -	psp->psp =3D NULL;
> +	psp_dev_unregister(psp->psd);
> +	psp->psd =3D NULL;
>  }
>=20
>  void mlx5e_psp_register(struct mlx5e_priv *priv) @@ -1100,7 +1100,7
> @@ void mlx5e_psp_register(struct mlx5e_priv *priv)
>  			      psd);
>  		return;
>  	}
> -	psp->psp =3D psd;
> +	psp->psd =3D psd;
>  }
>=20
>  int mlx5e_psp_init(struct mlx5e_priv *priv) diff --git
> a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
> b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
> index 6b62fef0d9a7..a53f90f7c341 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
> @@ -23,7 +23,7 @@ struct mlx5e_psp_stats {  };
>=20
>  struct mlx5e_psp {
> -	struct psp_dev *psp;
> +	struct psp_dev *psd;
>  	struct psp_dev_caps caps;
>  	struct mlx5e_psp_fs *fs;
>  	atomic_t tx_key_cnt;
> diff --git
> a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
> b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
> index ef7f5338540f..c2f9899d23a5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
> @@ -124,7 +124,7 @@ bool mlx5e_psp_offload_handle_rx_skb(struct
> net_device *netdev, struct sk_buff *  {
>  	u32 psp_meta_data =3D be32_to_cpu(cqe->ft_metadata);
>  	struct mlx5e_priv *priv =3D netdev_priv(netdev);
> -	u16 dev_id =3D priv->psp->psp->id;
> +	u16 dev_id =3D priv->psp->psd->id;
>  	bool strip_icv =3D true;
>  	u8 generation =3D 0;
>=20
> --
> 2.44.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

