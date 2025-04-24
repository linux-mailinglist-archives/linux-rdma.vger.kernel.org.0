Return-Path: <linux-rdma+bounces-9777-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100D5A9B331
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 17:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD5C1BA3F61
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 15:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DAA27F73B;
	Thu, 24 Apr 2025 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XB/e8suM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E41805B;
	Thu, 24 Apr 2025 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510344; cv=fail; b=YIi6dnJQ3ta89il6bhJQdhXKdl/3ABBj0CyUlVqa2a+s2Krt0rihtlbGKEPqbtBF5rY8HHSD3WHFyfxqXIyZZJhg4JNmhLLiKG0y3Z+oQbj5ZmZ0uAoYR6RboYmFel7ScEluyJOHWn26UmeXQmwc42CL/QwKdjwz9ixgCsJKrUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510344; c=relaxed/simple;
	bh=z2pf/QzUOKCDmPe/U9FeqgnBYjGsvV5ovlhTuGolU5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hcr+vNO4NZ4PK6/+0X1Uy81l8r/xyQ02+Ca7JTRa7HX240LP3PZYswDOJxuuJN4PUPF9/QnSwIzTGV8pHHGONqjM6dnyzf++ZZtAl5QYS7DNTaBOO+pYqVvurV5K55JsgmVLzuavyG1BrDzHIGKO9W8dby5WH1H8nJDo9UhDVgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XB/e8suM; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745510343; x=1777046343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z2pf/QzUOKCDmPe/U9FeqgnBYjGsvV5ovlhTuGolU5E=;
  b=XB/e8suMolM83LJHzffXdBW28MpZT2PodbhOpQr0UpOPPTvNjmlNCRUk
   aLER5g+5L9s0XS1D1Mnmz3jq9SMybWqWXWLNtPJt0tVCUaGvAkLfuiXRA
   KZfpLxxJBGb+rJ+FC16YnCBMYiRjH0Nj3epRkRXjnFOn+7eaMECf82MeW
   goQgPm3UPwrwFUBzM5AhxNGXN2NAn8TDmE4UyX16BADhNiByJK6SkuVjC
   qRmi89jELogqWW/VR+tI+qZVB8TNGpUZ4er40Y7Te2QYLyGU8BtikFBAI
   aoLBinPf28J7/or1FHtc4z63t1Fi2v6VgYvKUn60ODDZZdNjRvlXeJhya
   w==;
X-CSE-ConnectionGUID: pZA1XVkPRyKeKAISY7AO/A==
X-CSE-MsgGUID: 7ZVPrUGdSri7UaOqZlfDoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="69641541"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="69641541"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:59:02 -0700
X-CSE-ConnectionGUID: d7QgvLBNTwSGEuZBqZcqvg==
X-CSE-MsgGUID: e3+3FJjgStWk2lXN+6pSzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="169873466"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:59:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:59:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:59:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:59:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBqBC/7Nd6u1rxES6s2Siojs2MX6mXmgf8v1Akm573O2ACIJmEOeVB28bfYYkx2lPhilYxJOJfA7fJkrFqnJK6gCfDywTnZCIdMQlM4ynrlye9GgEmn7eJ7ZU53lTGvy9fDH9UUsyGBEvOkrVz1PB8gKPmc6lpFLq5ZONXHK5HtIhbP1q1uym+Vm65dHRH9YOe8m6vdg4zCNhBE9bK8Ai2D8S3yEmLr1BfLJfsBcgVelvVibRk+3UITLz6NrweiJlvPfbOOnGL6SklLphtbYjpZwqpFleuCONA82D+b6Xja9ldf54+9JYcfjy8C5o8ndzIYEDgTNpHLMBqTGaPdZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjze+5mfvMwLLbQ+sJCqe93y1ny66qHSszpHM+kdWbI=;
 b=XVgkAcvrEoe2NivQ5uKiR3JbDBd2mP3TRpguFtiFyXdPU+dzk0fpGyjV/0eYmQOgPSnm0ltlugSHEoiWSW/A2I1X793oL3nbEAU7NC4Ftb2s/jpyncLhXizYy/KiVaa50lfOaO+vRSqDBP+K6y/ajZ34pwXyvz9Mx89iaebPKGax400HNSfdH0KPgW5PsbrDDxPl2DeGRURNNuhgu6BvxrevLoK7AHubZcJXMn2YTG5P8aXicpomXw0TmZntLXuYOzuGxmOqrPcSl+Z798HF89ThA1+cw68wYkdGZiu3I3C3rWJMP8ttcu1/07PRvTbqVy8JXbQqrXMh3wd6N48cgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17)
 by SJ5PPF3F833FA49.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::823) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 15:58:57 +0000
Received: from IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::763d:a756:a0e4:2ff7]) by IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::763d:a756:a0e4:2ff7%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 15:58:57 +0000
From: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To: "jgg@nvidia.com" <jgg@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nikolova, Tatyana E"
	<tatyana.e.nikolova@intel.com>
Subject: RE: [iwl-next v5 0/5] Refactor to prepare for Intel IPU E2000 (GEN3)
Thread-Topic: [iwl-next v5 0/5] Refactor to prepare for Intel IPU E2000 (GEN3)
Thread-Index: AQHbrnWQAkoDi3xS7UqJfkGEHBC617OzA3eA
Date: Thu, 24 Apr 2025 15:58:56 +0000
Message-ID: <IA1PR11MB7727AF19E37851E3A4964C77CB852@IA1PR11MB7727.namprd11.prod.outlook.com>
References: <20250416021549.606-1-tatyana.e.nikolova@intel.com>
In-Reply-To: <20250416021549.606-1-tatyana.e.nikolova@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7727:EE_|SJ5PPF3F833FA49:EE_
x-ms-office365-filtering-correlation-id: a9b98fcf-ac2a-4f11-d34f-08dd8348eb9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?TpRAZIWjSwpqYA/VcF5VUF/NoQr+5eQI/qZWUOUmF/R+YD4h0+rcOfHPny+n?=
 =?us-ascii?Q?VJr9oC5QJ4veGrjUm8toIrgR0IMWE3li8qVQnpJ8pPg0ZyDR8NSB05qGuhix?=
 =?us-ascii?Q?s8AtsP4vABmZP/xVLEieXxizCzVorB7s5EH6+5EDM92P17qEPwBFYZLalaYB?=
 =?us-ascii?Q?+y7LgWGFgMtK9EMxnftZABXVLA6XRL3Q3J/KD1nm1YArBM4Yu22eKrlQFSO1?=
 =?us-ascii?Q?t4Oqjqr45WMRH6FKdXgKjGGsL+6TzvKO4lNzdDMqEqwF6RoTscLFwmyKt6nz?=
 =?us-ascii?Q?l8RUy8pYpSpj0efqWZDxhe5auZBDSyic7omWohEofVcAh/xcnaRtJn0qcV9o?=
 =?us-ascii?Q?pndRBbXdTY0C2Fy3TrKDPJvSIKaBQEBOLEjGHLNgFsJGD+7AKCQTHBeE+egM?=
 =?us-ascii?Q?+R0hAS7AvRHFbw3uEpwjqW5tSItiyKnov4IHo5jwsn3iSvHdLxV88t38aZ0+?=
 =?us-ascii?Q?NyvgQYwJ4IdtYDhycHQYqqJESR8wpHKZmPYnO4WumF2+PszX1sUvCXVpXVWr?=
 =?us-ascii?Q?/hsdYtz6KG7s0sOU/3fTDtiE60eneFnrU4JFXlpvnU6G5nownu3C7PMMy3ku?=
 =?us-ascii?Q?If9bH2u5WDLMnWgjzuYDmqQAGNi1o3MWRJha7aBUFcd/0oA2/BE2pyhXJWB/?=
 =?us-ascii?Q?uNV8FYsUiLLSOCoAVOQY3xZreQBol6SDF2O4Y1iT9FhvWPHjyfN5zCKaUkWG?=
 =?us-ascii?Q?BJZboo8CckjrTPzbXMhPL8cS52FzHUZQ76sVGYDtJOW1w3qhqmk8sGBFXpLp?=
 =?us-ascii?Q?i7hI3TGtEb899QwlOS6IHP8XR/seY6qKzxpAWyTHRnRlijHay6RkbgF6170u?=
 =?us-ascii?Q?gubw4QJUpvYCnrxQIU+Y/TkM/yBrcyDhWUgXTcj9r8hAZraPraQBXwjoSbzP?=
 =?us-ascii?Q?MtppCbQ2a9wmZ7C3YgxiSQ3aVsiHcQDTZB6z4TKo8R9Vo6sCGklhAsLDNXZ3?=
 =?us-ascii?Q?LQApPQVdCjaOaPl/Gdl5QSm/D/DtwqVm2mbSrVDQaaJFAioFzQYvIlAkISKV?=
 =?us-ascii?Q?WfXPchGdRtZNazYQJL8kb4VaR1OACuLXlRZJ83gcTCMq9+St6/9UOtXw4Dv+?=
 =?us-ascii?Q?RHCTvtaW19BqoGzT0UrEA/+4/G+INXy4HwcZj9kSzsKF+4ZDt+LZzs/5/0Fu?=
 =?us-ascii?Q?fIcXl/vd7Mw7J02JlK/iru918hHxEOtT8KKbfKziojsaW7qJCY9pLMwxAGP8?=
 =?us-ascii?Q?+EmQMRs8VyWpHO1ZxPSY8gP7k24mmxSmN7Fh8rlBR/pznwUndV2nhTfUioEv?=
 =?us-ascii?Q?JxabVe+5Gbes+d3KF+xFIlOnzz8No7Kdg63CoJC/QrpMe0SXthDpBfYA2Cmg?=
 =?us-ascii?Q?W2/bkoAiGvYam+fIchTmvE3fJ16Tv721AfAVrcNRiU13jieozPcPAirXouuf?=
 =?us-ascii?Q?JZeGW+GHSFjNNy+muBk+OC/cx/rAJ6B6Npdcl0I0n85YNwzofyO1JAyGrIp+?=
 =?us-ascii?Q?yPDEdbYgepJosPfLeMeWCuM9RzIAdwFaAjnF7IKHaYRrjfZv2L1OkX+1Gw1z?=
 =?us-ascii?Q?W1y1HwFirgkMpQM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9VvhaGm7Yg9MO8ZEz/M2RsqJUgg5/R6pVgwhtZPu070KWVk65H7TYIysp/tH?=
 =?us-ascii?Q?7P++DdT0KYElXqR9tp72Pun1K2E9z472B5zQPPqefabL4lIxpon0sR5+D+up?=
 =?us-ascii?Q?txg+Sh/ijKWGdMnvoS4WbFOCHkAy2pPSymxXeNDmja72ntpXa0byc0Zity3b?=
 =?us-ascii?Q?LNBXiU1QZuBKicmE6ce5wnodc5OQxABiE/bgG91CZSmqmMG6F/Ksh99VG+eK?=
 =?us-ascii?Q?+AYyBvQybyrvtOEudZoJCbxZ93yQIAeUTw1LrM/O0yQQmtwGR8LKvCKU3NbF?=
 =?us-ascii?Q?UD/5yJM3cUeJMlJofLa6uCnNAHndBXCr3hCaUwLSmRlv8L6GeKbk2tynvNAs?=
 =?us-ascii?Q?LcxSmncfWWDAb8JV8R+ePXQp1Cv0U/Ggwr6ZoO9J6hBd9G0DEx7Qcxdgn6e8?=
 =?us-ascii?Q?zErKQYY/FpI9pAYIohTEDVFrtaVA25HaXVrAhyxf89BP2n6eM0pUGCWIWcbe?=
 =?us-ascii?Q?Fs909e7tJqvxjSEznZ12GdRWX/Q6runnZUbmaA40icz7mhIzAgPXfvex2CxX?=
 =?us-ascii?Q?ibvz8zppbJ2YedVWPdm1ty0gNa6QKqASSkm5j2FJREZv0MwflP6t6z+rqiPd?=
 =?us-ascii?Q?jah9LKw3VI3A6co3Njp79wZDzFNb0/dbddW16DqmHXSxAfSkdAM589G5VaBE?=
 =?us-ascii?Q?jEThAyBsxeWzdJRs63iTKdnbkkIFWRdM3OkFEIUYDNm09TfuqKWMzBYCCB/j?=
 =?us-ascii?Q?yke79I+u5dWBJ+zHdNzwaMcnn7Geoof14z3TOjboZO1Grj6dwbUWjVjFIl1Z?=
 =?us-ascii?Q?4rHgfFQXPCFMJULS4X3leAHvOG/ogg1AqlLPF9LQVKf7khfD2ivPReZ+Nb76?=
 =?us-ascii?Q?kRvQaH3vd8SL4lR9HwCaR7lKr2V+nCBwrIfjm3nOz3vLIbdBnpwQagYbr7o0?=
 =?us-ascii?Q?V5kud+kYDW5P9H21eu987c39zfgV4Y1Tgx87lQW+ifocTNmKkzB/GET9Y1FA?=
 =?us-ascii?Q?tQNMguwROVj0ujvfsXdZljkbMNUAGa9HCCjLmZfgqCFU52K+NrESweCdpssv?=
 =?us-ascii?Q?4K1Wl9C6ULAR4ub1Pajvd127p7tm5aRXTqwxOrBcEwH97286Rud/5IN6FAYB?=
 =?us-ascii?Q?6A/SROYAzrjaEy8y5MlKG0DfExioGigYH8n6ruFXpEqGbgphgjazpCw/czXV?=
 =?us-ascii?Q?e4B9xZ2q8nAkkrQEG3ulNkil7WwXplZSu6XyPSLAM0Y2VJjpZDzWBRLNetKG?=
 =?us-ascii?Q?0fEsVpe32q3IcmasGhUZH3HxmZxKtmKGM01NKl2qPC44t4AYTihRaeVSH2RO?=
 =?us-ascii?Q?yxWDFepmOhgAshU+LFQ2TMHrzR67bxLXAhXk7L8EtqfdUMtKIECInEzC8uQh?=
 =?us-ascii?Q?PyROfA/ygqRM+5eJgJzdHODgbFZY9c4gJvULvWsstaSLGkSYF1Ff/1gaadZp?=
 =?us-ascii?Q?sGVtAESpNZXhvuCbU3gW4RDrabhdpDAzA7BdO88ZX9CPIzubC2keU2+sU46w?=
 =?us-ascii?Q?S/qiekx/Wx35lmP+jksMxdRD9rK5Q5DUHLbYwY9a69U33ZNyiLAoKBQHIZMB?=
 =?us-ascii?Q?qC9TQ7bBftSKk2DXJWtB84C1AGNyz0P9JAqE7O1MspgwztBBLSWvpT5fhHXm?=
 =?us-ascii?Q?k5wcFl/xbaCmMdqHBWaeOvQy9I5whoMYSlw9aPir1Crp+W3D+ke9Jqyw13YN?=
 =?us-ascii?Q?rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b98fcf-ac2a-4f11-d34f-08dd8348eb9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 15:58:57.0164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d2l13VAjpseCTFB2vJhVoUhF7SDwLcqkZJL5WeAiCT0uPNSeCsFQb+PeCsZVvsz0dCg0UuRN5O0qGPETfwY4vyC8L4LCOiXSvtnNf7WhTKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3F833FA49
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> Sent: Tuesday, April 15, 2025 9:16 PM
> To: jgg@nvidia.com; leon@kernel.org; intel-wired-lan@lists.osuosl.org
> Cc: linux-rdma@vger.kernel.org; netdev@vger.kernel.org
> Subject: [iwl-next v5 0/5] Refactor to prepare for Intel IPU E2000 (GEN3)
>=20
> To align with review comments, the patch series [v1] introducing RDMA
> RoCEv2 support for the Intel Infrastructure Processing Unit (IPU) E2000 l=
ine of
> products is going to be submitted in three parts:
>=20
> 1. Modify ice to use specific and common IIDC definitions and
>    pass a core device info to irdma.
>=20
> 2. Add RDMA support to idpf and modify idpf to use specific and
>    common IIDC definitions and pass a core device info to irdma.
>=20
> 3. Add RDMA RoCEv2 support for the E2000 products, referred to as
>    GEN3 to irdma.
>=20
> This first part is a 5 patch series based on the original
> "iidc/ice/irdma: Update IDC to support multiple consumers" patch to allow
> for multiple CORE PCI drivers, using the auxbus.

Hi Leon,

Would you be able to review this updated patch series?

Netdev maintainers,

Based on Leon's previous comment https://lore.kernel.org/all/20250216111800=
.GV17863@unreal/, he would like to get acks on the netdev portion before cr=
eating a shared branch. Would you be able to review the series?

Thank you,
Tatyana

>=20
> Patches:
> 1) Move header file to new name for clarity and replace ice
>    specific DSCP define with a kernel equivalent one in irdma
> 2) Unify naming convention
> 3) Separate header file into common and driver specific info
> 4) Replace ice specific DSCP define with a kernel equivalent
>    one in ice
> 5) Implement core device info struct and update drivers to use it
>=20
> This patch series is based on v6.15-rc1.
>=20
> Changelog:
>=20
> V4 to V5 changes:
>=20
> - Use exported symbols instead of a device ops struct
> - Rename the IDC header file iidc.h to iidc_rdma.h
> - Move ice specific functionality to iidc_rdma_ice.h
> - Use iidc_* naming convention
> - Replace ice specific DSCP define with a kernel equivalent one
>=20
> V3 to V4 changes:
>=20
> - Split up the patch series [v3] into three parts and
>   send out independently the ice/iidc related changes patch -
>   "iidc/ice/irdma: Update IDC to support multiple consumers"
>=20
> [v4] https://lore.kernel.org/all/20250225050428.2166-1-
> tatyana.e.nikolova@intel.com/
> [v3] https://lore.kernel.org/all/20250207194931.1569-1-
> tatyana.e.nikolova@intel.com/
> [v2] https://lore.kernel.org/all/20240824031924.421-1-
> tatyana.e.nikolova@intel.com/
> [v1] https://lore.kernel.org/all/20240724233917.704-1-
> tatyana.e.nikolova@intel.com/
>=20
> Dave Ertman (4):
>   iidc/ice/irdma: Rename IDC header file
>   iidc/ice/irdma: Rename to iidc_* convention
>   iidc/ice/irdma: Break iidc.h into two headers
>   iidc/ice/irdma: Update IDC to support multiple consumers
>=20
> Tatyana Nikolova (1):
>   ice: Replace ice specific DSCP mapping num with a kernel define
>=20
>  MAINTAINERS                                   |   2 +-
>  drivers/infiniband/hw/irdma/main.c            | 125 ++++++-----
>  drivers/infiniband/hw/irdma/main.h            |   3 +-
>  drivers/infiniband/hw/irdma/osdep.h           |   2 +-
>  drivers/infiniband/hw/irdma/type.h            |   4 +-
>  .../net/ethernet/intel/ice/devlink/devlink.c  |  45 +++-
>  drivers/net/ethernet/intel/ice/ice.h          |   6 +-
>  drivers/net/ethernet/intel/ice/ice_dcb.c      |   2 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  47 +++-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |   9 +
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c   |   4 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   8 +-
>  drivers/net/ethernet/intel/ice/ice_idc.c      | 204 +++++++++++-------
>  drivers/net/ethernet/intel/ice/ice_idc_int.h  |   5 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  18 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   6 +-
>  include/linux/net/intel/iidc.h                | 109 ----------
>  include/linux/net/intel/iidc_rdma.h           |  68 ++++++
>  include/linux/net/intel/iidc_rdma_ice.h       |  70 ++++++
>  19 files changed, 449 insertions(+), 288 deletions(-)  delete mode 10064=
4
> include/linux/net/intel/iidc.h  create mode 100644
> include/linux/net/intel/iidc_rdma.h
>  create mode 100644 include/linux/net/intel/iidc_rdma_ice.h
>=20
> --
> 2.37.3
>=20


