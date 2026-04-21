Return-Path: <linux-rdma+bounces-19457-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPT9Eny152lU/wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19457-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 19:35:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C001243E0D8
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 19:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00F1E307ABFF
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 17:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7582431A07B;
	Tue, 21 Apr 2026 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iaSS+zvF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43078314D0D
	for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2026 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792839; cv=fail; b=bXHB8F+SiCeKECAmPCSqlHZPSQ3QjH5iVz8A8nk4+x/ez36+Lcz/XJ3rkSeEBWYfRUm1hc3Fp+pji1VTES1RpuO/w+KuBBbe/+57Mpg1Hk53c/nNJj3vkFBUMTzB5FUsGkRyCzatBP0oPlpFEMQSprwNYDaSyOxtrcEaVCHdqsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792839; c=relaxed/simple;
	bh=dh2HtzE5X7kOjgE7hSpdextEDZ08Xsp1SRRZNbOzeX0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=W/m2dZixeCD4NmuoYmbxwtDBz40uGlVpOxJSKOW9y0hkTLMiX+wxo7uyXlPoDR/pKYXbkI+WjrH2KSkwHVF95RWBHb404l82ShhnpU3nLAC97LlW7oBmAEU3sYFveJ3RH/igxTcpwUhZqCS6n3kh48lhikYY5LYeIqgz+uYL0a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iaSS+zvF; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776792837; x=1808328837;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=dh2HtzE5X7kOjgE7hSpdextEDZ08Xsp1SRRZNbOzeX0=;
  b=iaSS+zvFQf7jisnCDSnCg9tRftNRyTN/OO9CZdBmGF6MW4ShJOy2T5IF
   PzRhRWecGTEjWtWLk0BOosCUBr9ag4ly7l8eWduuml8UMyQjzYUMaV1tB
   B/+RPyaKrzV6KfCNAWfO0sHCvbgFBcrmia9EgCt4tNmh81bMwCFeaKHaN
   Q3/lPhcfyFKmrvOeB6kzmVjhx7ZZKW2HHg7KLhERQCjEk+3szEjz2zrg6
   nNoMXg5V8neSWPnt3HqDiqQaMZYNo8UXULS2f8ueyx3PnXkQ4E0egzdZt
   elJ7obsXM/PcEqdWiOKlgsHX+ZtvbeHr6ZUywxtkHtE5CaOHkSMW+21CH
   A==;
X-CSE-ConnectionGUID: z/8/QNnXTXmv+sVwJo1Jhg==
X-CSE-MsgGUID: 1Up0qM/VS+6GkXJyTxI2iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77856954"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77856954"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 10:33:01 -0700
X-CSE-ConnectionGUID: aIj5x5wQS0qt719MWcyaOQ==
X-CSE-MsgGUID: k8NhO/qSTTu+3JxgPzjTZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232392387"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 10:33:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 10:33:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 10:33:00 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 10:32:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPx7oI8cbz9YvmNAOobIuD72bLejiAj+WFrR/uoj4gHdoEeYC4X2B7TNH66pWYHBJYUYZNlNP+kCxsQnE8VuT3ZYadJsDkWsl4AHtXNkpPSFz4aaH2RfOaOEsh4LvOrb2yPBjg5YA5c6U73dN7xIHw9sLkcN2AXaGVtymnFXKXnDst+zpAnwWfBxD4Ey1yEMLEeQYcA70OyumXSOFatbyGPTJb0tF2ARB2UjERVOjVg0swt55RCQjn3bjA4GmRNOf0xlLtjAGkHQRWaoLRmkiQFS0gh6tv5UfPsc9N8BpHWMl3JOCCgPXbXxUg1ZXM+Sm+9ED9IHFGHAEj0YlR7U/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dh2HtzE5X7kOjgE7hSpdextEDZ08Xsp1SRRZNbOzeX0=;
 b=DR5lEMCxV3OcWLP0MW0At7ZhGEy9f61l1DL/aQdMdIfrsiuRzik5M4xKYN6gCSFoye2DD9dWXppDoaJE0APcScdXSxi/xdgVNMSUkhMsC2m4sPOqqssImbuAS4eOse0KKjn7VbLCvSA1M7bvQaXhnnb2Zbaf1niCNG4+73sCeo7FANBz2v4JtRBUqRb1UoK9F4U0inUdMIMIX1L47we3aduoYxDye3w78UMH8ZvnNAj/AUe7cnrPn1+AGCBjcDF4kzbktMMPyjn0J8FUBhVmQCkNAKQVS46KHtQ1sWbKldSfTK1aM7utqu6OOizh8ZuQBBVhP5rgFBVvNYEFkHnvBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17)
 by DSWPR11MB9559.namprd11.prod.outlook.com (2603:10b6:8:36d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 17:32:50 +0000
Received: from IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::a99c:3219:bf01:5875]) by IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::a99c:3219:bf01:5875%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 17:32:50 +0000
From: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Jacob Moroni
	<jmoroni@google.com>
Subject: rdma-core user space irdma
Thread-Topic: rdma-core user space irdma
Thread-Index: AdzRtFOnr3MtxlquT7qKWQvP2MogiA==
Date: Tue, 21 Apr 2026 17:32:50 +0000
Message-ID: <IA1PR11MB7727AFB5228A90E1C7115C21CB2C2@IA1PR11MB7727.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7727:EE_|DSWPR11MB9559:EE_
x-ms-office365-filtering-correlation-id: 2728f967-fc3e-4a30-c2fe-08de9fcc031e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info: gmZQgJd+VuhyITszwVGIab/Kzko+l2ibP9i4lm4lvEzI1Rh9OhRTLsaQgx76MLxHhLvZWKcnypbBVSVd8bsQKLsKYM2oO2qDkF0rKWWCzvB5s747+meG8+MERGY+wsJxksaPCAGgR2jkI0v1h00iVEKFXORf9OSILoGbf3Zwwg0L0fWwwqiwHvr/N62FYglBPAxnjPKFWLIbcFocdffbd0/HWmMDS35UqTJlQkNrXoI7Y6uLcqhQ44Qi24M7UUTEpBGBpe4sTOBQGASKLi7JVpRtl1UlRxvhGAHFcg12t0zcOIuvfxjeACaTOowWAQ7ghks/iQUHamFa+LT+bfks0N7yFvT3JAls2WSn3DcNgaDPMZB7qX04vKR1Gw0hQO787nDr3DRyG/9qxxvYlnVms2O1GtrTtWEKsjAE5pTUH6fCKOgYr/9HooyU0fJ9p0Aex/lurrngNSSACYduwjyKIzzq0Q2jgd0j6UGJS/fgmK8sI3jWN0IWaitLPJ3mCY4tLGDFAK5LX0HCHjMqHghbcEtuzCQxPrtmYcpCESBE4OxWI1UnVUDiX+iFajqPV0ovU54qsSQRQ0bWVJ+UdEuYOJTGAcACBm7Oq23LWCzydBteDtzLZfDAiO+TUmN8GDMt1GQz4dKG6MUnfBOZWAfAwqnmM+VYX97kAYZ4h48NfHjkFGacUz8KndSeXEZzB09LLPcfTiNFrzT7j5OTMkHNq+i9+B0qKr8lkxxSrOgreEc8Y9cvMbf7ATwDERSR6IN8aB5HDUgq1UbvXw2iFzX856bPdyaI/NJulegtfcLWyJU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KkPUHy1Vsqstx4UxUU0c/HcJHoqAz2bLDN3S8/HsuazvCZggZvW6KlNNx1yb?=
 =?us-ascii?Q?0muP0WxrXKR52gOw9KwLbssQ07vvETPjSFCfiocU3j3gZCtGf1O/GQbirB/n?=
 =?us-ascii?Q?AvmDmbKaWH6BrhXJcBRdCbMrC4WijHxv2JqOhdGYKT//nz/NS4OmSEv7QYZj?=
 =?us-ascii?Q?C7yRauQLiJYqNOZP+Y1I4beKSJWKEcdz5//mGVggeUmazyXn4ya3Jd0qpyFz?=
 =?us-ascii?Q?1lhX2T6MjlDY/KWsGbivM7UGRTDqrM+wNlsqJWWINpJlFDU3/3crI84MmlxM?=
 =?us-ascii?Q?12kREif+tfvEfvcKz+s8fxEoj6LfCv2eZO6Fan+jZlC70ZuG+PGszIFoXZfe?=
 =?us-ascii?Q?JcSpZKeLXXxBzdKRPcKRtdQmyJHVDeN2wOptBdFM0UChHFwu4lzEh5BW9XVY?=
 =?us-ascii?Q?lSOm7nrxHoj85aC25lIXi3hgBsfWOlNzX8zoR0XuYhkATD1XBRV4Nx/hbsx1?=
 =?us-ascii?Q?2wVI03K87nsQ1ZxR6HmCfyxTNzHFVs3OneXZQn41LeOraaxISA0oKlVWta0T?=
 =?us-ascii?Q?NHqB2tpJGSRLrPR4Y36LdpWBMLf03MLvx43uXyGVqFO/nTQpXt/ctN1d7b6E?=
 =?us-ascii?Q?cPM8I90mDfgJzpyMqL2pYb+Xv5bHKXYeqf6jhvxc1zk1HUeQvHCG7c5MDLGs?=
 =?us-ascii?Q?zT/LLe9du3ftGlP/iklbaNh94ZEWGgR9TGwkUzgCdHoLJx9xz4Wys4+uR6cb?=
 =?us-ascii?Q?gRA99w9Y6Uzum8AnC4baVYyoClUaAO0H6la9bgRz1ANZWiws4vGjDb4UHpi5?=
 =?us-ascii?Q?LeYECuIDbaNEZo+nIb9kqz+UCDnpG/yPKgG6YlxsGSSF8XDvZ3NR4CS92szJ?=
 =?us-ascii?Q?NeLbwhZn9z+300dHVVQKIgP2zGchqwU2jPnie6uwVoJTFLSzU/keSlqs7Tfc?=
 =?us-ascii?Q?RY6rKq5Jyg6Ouc1yW7D9nQCW4zrUGoyK9q7xLMJ4NTbBmk617GJA6yk8Mj+E?=
 =?us-ascii?Q?80B1FEGGeNcMsv3bLzg2DxQY/AWLmJ/HPK7D97KBTm9EAf6gz8IwQK3qkPFW?=
 =?us-ascii?Q?gLBXgIh3FB5JO61+r2/44pGEYTfAOaG10UiyY5R1BXzFXiq6qbxY4uATXr69?=
 =?us-ascii?Q?ct4g1WutJFLK1Khz0iFEkHSegX0YN1fJ5Fq/x1LJi18re5gcJzFqaav/AFvz?=
 =?us-ascii?Q?10l37r1bzZeeaie3EQPm3Ozr1v76ihxvZebtTMsGQrOA70NgCs3o/T8ebeSC?=
 =?us-ascii?Q?5sRydW/hixXHzCWiVGcGoyTt4wM67xbZBhSDWYJcPbpMyW6mWMCwPFOr01Wj?=
 =?us-ascii?Q?gMFr8diJXAhJ8Uv8UqvQQTFlcl9LYOYnM+f0itIH9C4/Jt60C+XC0CIiMYpM?=
 =?us-ascii?Q?ax1g3Vbxz/RKzlbppunpEdJjqxeQCp18OZmNfy895CGZsW2liYm+ZBmXlZho?=
 =?us-ascii?Q?ENkROAL2r/b2zSrct+3wc7w5G4ktyBkFODX31PlsClobMyFF62F5+rjMQuWT?=
 =?us-ascii?Q?d9HCz9Xr5WyDMnzlKQKx7grt4lWClfCMrv/7qj2Tpswwipfp/ei51TUGuxg1?=
 =?us-ascii?Q?DPUybfbP3oQRQdz+/2miyuVBqa12ltZxB2qJ+Dc4WKjBa62aMozFrnyjN0x9?=
 =?us-ascii?Q?YR7KoA+eD8hAr1KIIcbDg5S2WTeMrrbPFav/AxPyKUTo5IkO6zAyz6H773TM?=
 =?us-ascii?Q?hB/Kv/FvviEn19CWdrfDNnABTaiRaXfQecdxfk+ec6ZDM9NoJYEWdGfE2X9N?=
 =?us-ascii?Q?u0sEvpbyGrtZ0hhto8NuAbFGSqKyV1GnebaMmND5nKPYF6FrZGjh8c3cI/jj?=
 =?us-ascii?Q?Sjx5+5T64g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IEzkq8JaDep3BTsM6ie0Zbj3AvHAfYcLRGA4zY5cw0Qb8lUFIc8f+bDfh14G0tvDZcKK3yMq8TIHgGtS9I07oCedfD6Z8/XQr3JIGzMjbPPf8F6uDVRFkryKrpk2DgGxbxUirQIriEmKRa9+fLCxTq0PsfUpCVkuNLPwFaoZc8KePHW/zGK5R5zkG0VZSHi9Wbay2nmu8ayZA7Td0HtRZhmW0GyTHPpA6ozJQCZ4CjX9YZrsw52BLBZzE+V5T2S/RyfDPxTjEmsKHCjF++PJ1A2WN2ORy1riozHRNBhDWwcDtYL3qDHLgZGbqVyqVqDAnmJ0OwWjSZC9RBWBOIBGXg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2728f967-fc3e-4a30-c2fe-08de9fcc031e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 17:32:50.7158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QS04s/NJhp8tsrUzBNCtYeN5V88W/xJmBWurvh6MhMSteDJpXwXg5MJFfroDcPltOmln9MrpUS0e7U/wHRKV+EP+JAsqByNrgYPdH4rUn1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9559
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19457-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tatyana.e.nikolova@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C001243E0D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jason and Leon,

Could you please review the irdma user space PR at https://github.com/linux=
-rdma/rdma-core/pull/1640 and provide guidance on how to proceed with it?
I have rebased it and the required kernel patches have been merged.=20

Regards,
Tatyana


