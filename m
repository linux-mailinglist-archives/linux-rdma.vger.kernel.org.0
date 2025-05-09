Return-Path: <linux-rdma+bounces-10204-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026A7AB13E7
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 14:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C74917E639
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 12:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB029114A;
	Fri,  9 May 2025 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvYZnUIi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ACC2900B5;
	Fri,  9 May 2025 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795278; cv=fail; b=e06atdw2/q5hATHld//xRC5DzWhNRvooK2yl0tVOTrS5MynBAFOSV9i4VC4mxa1W02bYtVlNbzONduc/XWEykSguYaH+fVhg3dC6VCOqs6QduzV/G5f0YXcPzhpod1TT1jbJwOydfFaoIr8/dBl37HzGApGZ0CSSHR7xG1JDv3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795278; c=relaxed/simple;
	bh=cIjKV23cLU+gwpXuoSwybyjTBwwrzjXK6uvB5gL6MSk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IT10gk9CLarW50wgS6vlTPdwHbzJEh86EZs1H9iYtMa9WvLOKevRQjpfbGxynsZr0u7/F2AreaCjoO1DU2AI1PgAIJdn6VrZT1Nl2tYp1LI/3Pu+mKcZ1KIfm3grIkB0bkEL77c/sfBrFirRl2pFtZLxWszBwsfvo30M5sHwWHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvYZnUIi; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746795277; x=1778331277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cIjKV23cLU+gwpXuoSwybyjTBwwrzjXK6uvB5gL6MSk=;
  b=MvYZnUIi6IOEhd9XxxP2buGKQwX7GBRCVfTeqnB0rDX9p90fSuYzUUsh
   kDHlBEHr2V1LinA7blL+XxjDM7+oh2zvZOXhNO5lMifoFpTTaQlZDIGH6
   jhDQ1OZdU8+p0b/Qb5MYuaifhTC/YLWYLEi1a1i3OE9iI3A5ic96puAfb
   PZUjjYpdTYu6n/IsVWdNY9UAPo/HbSyhtMqQWB7RagrG1HSfCddKd36P7
   b0yk7xIMNES9qCJOIfuKOJ+CdFcCBSGQCZLjr+99B5x7JtlRjD6H5xv+H
   Ohy5Uj9i8TtvMyocnyhdFhIChZnkHA/rH8qoodMUXMS+HOfGTyBJHgqri
   w==;
X-CSE-ConnectionGUID: zBxymOx4SPWWf9NoRVtWPA==
X-CSE-MsgGUID: FnkH/oKhQrO/lttI1+A1Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="47734789"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="47734789"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 05:54:28 -0700
X-CSE-ConnectionGUID: Qr5OyFnWQA6N8MBoplH1EA==
X-CSE-MsgGUID: F8fOK+zBT0yPZiDZyy4eIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="137606394"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 05:54:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 05:54:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 05:54:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 05:54:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6KR4ApF/R3JZK9Toteajcbmy5xjGloHSjf2t++T+aQcAEm00ilBv+X0eJ11Njuy3zC8sbv3AqOKuXfxQ1mIbYz0LceTxYgzCq6a2H85RkMSD6bPnavA/o2kLknMhyUArh7jM1zFAtvtZOVDoF7fVA/tvR4/o4iPGd5gkfUfJVtjBlQFjfd+SwJDyB3PSIIT+tw/mzyKV6aITRUzD3qZmXK7bYPXF2d1OZlkOEK5W0aAbRgDey3pwkfdRadNy4cW5cV95XBXcCK9ojZOxN9slbBBvEon+FYwh5H2FTRKhruY5HCjTTWVFHvADr76A97E0iFqhZc4AJhkFQ9hSKOB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOa+LuoSWc6j8wo5OjYajRdp7h2DB7B8z4UXIjpr0RE=;
 b=KdijbA7n04Qy7y0ebGIfV/FX6wrqQQ0a6mM8yslgT2TPY+r0YClml/DMP5qzWTq0jTcugRERtWD4kUNsfRZQmCJT/Ah4o39LOCBnZ03pme1sRY6O6Ikjk7X00cF3mUcruRu16icSWmgSCEW1IWOVcoo+vLxlUl/jjQCnLtyTg29FKBbgv1BhwvlfxUbaUUTt+dkgVCif02PLwfTkH98+Sxgy71p0b5aX/O5xJWGv6BYFfk4DxMjsX01kZ7Uu/HiT/d2KUKKR4R2gsz4WE98w9qtAhDlNwOqCi//auFJJUiCD3kw40DNkMW3qyOR70AXqxyXgZ9v4ZYaSt5lSNJLO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22)
 by PH0PR11MB4984.namprd11.prod.outlook.com (2603:10b6:510:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 12:54:05 +0000
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38]) by SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38%5]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 12:54:05 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "donald.hunter@gmail.com" <donald.hunter@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "Dumazet,
 Eric" <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "Olech, Milena" <milena.olech@intel.com>
Subject: RE: [PATCH net-next v1 2/3] dpll: add reference sync get/set
Thread-Topic: [PATCH net-next v1 2/3] dpll: add reference sync get/set
Thread-Index: AQHbri/dMvB2hhuzzUOgHfy3C3HefrOuJH0AgBxBwtA=
Date: Fri, 9 May 2025 12:54:04 +0000
Message-ID: <SJ2PR11MB845242A2D576433DE5252F2C9B8AA@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250415175115.1066641-1-arkadiusz.kubalewski@intel.com>
 <20250415175115.1066641-3-arkadiusz.kubalewski@intel.com>
 <20250421132230.GE2789685@horms.kernel.org>
In-Reply-To: <20250421132230.GE2789685@horms.kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8452:EE_|PH0PR11MB4984:EE_
x-ms-office365-filtering-correlation-id: 854fa766-3221-4472-7b14-08dd8ef8947b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2iYfq1NPB94x81+RN93UrX/qfGzHEKnPyZYtxhVsu2ZueZFI4k/hNV+rbG0b?=
 =?us-ascii?Q?q+mK3h3IcMCRCn7/MX05iCxPdvDphEdoxfNE3uE5nGLi2FTdqZOMr9PvPocX?=
 =?us-ascii?Q?0WaT/0F4wOSFUv/U/RwSc/i/8b93wFmVaUvJQXQOQWp+2aHKvxY/wvFUuEc9?=
 =?us-ascii?Q?9X+mk7zXJrfcUfmTJTro9kMPevmtzEB5iWxUEe8wlwJ9oHqLBZsus5ucOaWb?=
 =?us-ascii?Q?HMjTwzY9I6kDw/N9zvbsSyXlwId34rfN8nFZyYfmgGGfU9DWQVz2cNCnHexo?=
 =?us-ascii?Q?d6k3m8WUQW5DwhgBjg/lcUNjnpVuo3AxZdGVlnr0xYcY9KL1Cn4qySKOO9YO?=
 =?us-ascii?Q?kxs3lvyIoKfdjMWotKtS/Jv5VGTk+RNf1qj1x98M5AWwFYRqk1ITOLujIPQN?=
 =?us-ascii?Q?dIR/yml5yP0isLwVh4kwscTM4rwtfAMgzvq53k5AfxZUh7M6tRdDn+PyhOuW?=
 =?us-ascii?Q?2sv3617B7vxshOJVvNKBiMaECnezGV9VHZO/UW+bZ0XVq0nSEEcdwyoP9HXu?=
 =?us-ascii?Q?isW/Pd3n0IGWO7nm5dctbeaCz7noeDc7OXbvTch//L9EcXOVqpATqu1jzXCf?=
 =?us-ascii?Q?r3LISeCyuPejTdiDRsYV6WXRTqbhlGTHIOe/+MGa30JpymAof8ercU1L4L1B?=
 =?us-ascii?Q?gsKP/3wil3uRVJPC+vSrSsxspPV379Z6DmF6s4BYZYdS0ZFT3b9dkdSmYo5O?=
 =?us-ascii?Q?SxjpG9chpLcHgOrJ9DTYFZVaUib+DyBGlJ42HYuJM2bj51A1heJMVbSXXmnl?=
 =?us-ascii?Q?HoxGxjinOXjkU/h2t8qem7v5i6oUSlRJ5r8gcH9N6b/iByRWuXZtwwO6w2H/?=
 =?us-ascii?Q?BQHh8Ut0Ox0RLd9tmeBorPvqGAKem72Xu23hVo7wCgUS1qQTVYoNzxjHBRUw?=
 =?us-ascii?Q?drPVGQA4Huazbd3h2cb6q43dfReNOQ7OcZ/9co9uu7xfCu+D9Th1wNMb9e14?=
 =?us-ascii?Q?L/e8z+GFAeZ+nffehC6zJXmYtEwWUS5pHCzYkx+FVluP8yW1V31j9g34bvaB?=
 =?us-ascii?Q?C8c/qT/wsvptCtWS+bdyvwnVNfNNRKud2cZ7TDc2AlG+Q07qvrp8TBGtd4x+?=
 =?us-ascii?Q?JM6DGGLz1Myp2KLVDoC/sSFjWPd2cETXgvsRpaC3U5dZUayED5TyWGyj7sNf?=
 =?us-ascii?Q?kW4fYLk3hXR2qGTng+nejeKYW3TLhSJrtKNgqqN7mvdgotDuZbOuxxvWWjRy?=
 =?us-ascii?Q?7ygg72vQdY8dg7+iu75C0oAJd5l718EJE909e/ymkrQT3A1ZUE47i5b3mTyh?=
 =?us-ascii?Q?3csWo4F+Zs7DfDjH8MsBeB1f3EpeMTH7NhIfHMLuKbTEHxDAJiiiUuEBS1z9?=
 =?us-ascii?Q?aBKk+AsOAAolbl1Yc2HI88QSW0SHe7FiKmqycHU021LcVigHLl+QRCH/QHdo?=
 =?us-ascii?Q?rzmdC/fOOFUfI3B6EmDYuzI8pJ+wmBEYlMAu6GTD2uOUbt3MtGNuUiSaeTxl?=
 =?us-ascii?Q?+DZUEDM11/0xkgX8h+SV6CqtCqJRT+73k0R2gsKqC1Z9wjeSfZ46EA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8452.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QsSybKW8kALWi8jN28Wket/H7VRpSFNCzOmLe+fGTUZ3/H9zpk+ltohpP9h8?=
 =?us-ascii?Q?HqLGByXRCviTPl9cxOFjdIed0dKRhzK0O1kvY4vVZQEOCm/x7ta1vev5sROE?=
 =?us-ascii?Q?HB8N5RPzw/DtvxYll4PRNjfYgBaZkeT+sZvRldurFHpFdtkYb3sMQOcbAolZ?=
 =?us-ascii?Q?U1+0yZ6RC3a5cSOE6DnGvyWqWEHPd1VZgxLJIle9EsjICLVYTJP/PnvI07cc?=
 =?us-ascii?Q?uKHplNDXqHBjk1joARP09iRHepg0ccG8e0sO3/70nm9QLsD7JgsYgs7O3zX6?=
 =?us-ascii?Q?ankE+LMXEaL0zbOzVZQgchLKvvJ5H4+cM9iha5rK84OnrVSmAEMrWHgc+9Zx?=
 =?us-ascii?Q?w/wpX33jilLZERBX28okYxOZPD9Gh2hZtXGqtlp0BzjDNS3Y0Yp8qGW4ofD+?=
 =?us-ascii?Q?drkLEIc+t9+PZfyb8x9j5DW++ckJ8FNQRDmqTUple43HW7dqC/imo9IVh8hh?=
 =?us-ascii?Q?9+R3HrGKoxGwxNmq8orXJ4HzcCe+d7bMuQIHM5VxX8/B+5RlIPdozvcIw3Jt?=
 =?us-ascii?Q?gwbRwjk7GnaSXnmtKAEx63U361mV0amZQJal40GiMA/2pBEw/mfiH6CN5DOU?=
 =?us-ascii?Q?HVTcsDPC/QErEavs+N0UiNtXEEYmOY/aOZ7j9T6tOFTddrzPhcrmLaAzwMUM?=
 =?us-ascii?Q?RXTwiQaMrSQMtII9CsMNOXYIznAZzcm/uX4+6yZvPBNPJ1z3Tt8BO+TewqkI?=
 =?us-ascii?Q?5n2cwPEaNsWwwSGTQm9oGMuXlM95Kn0doXQZmKd6L+yNUKurBKDLJzk9T8r0?=
 =?us-ascii?Q?aEdWZYhRjNye+2+uJUdAti9GNHG9UcxyNYs4fASE245Vg6yvCiINfgVbcv/3?=
 =?us-ascii?Q?A5F/Kss5gwLtr1Mnvwk45Hg02ogRvCcpKsun4SBMaUHFLRvc/yykmhbY5GX1?=
 =?us-ascii?Q?ayX6LzfmDjm1UlkHHN2/dhw1blEecF4NNCVd2EelGM2GakzPdsQ8V8/rHj+I?=
 =?us-ascii?Q?IL424bJScGc3/PTu0R/m/BIdXolk88zpWHislW960rw7vtHgQLfq6+R4rMHy?=
 =?us-ascii?Q?K+E+rrg14VI8JfrpWIb6Yhsgx3lq7wmJ6JwKMS4f7+w7huEegdNxrrD6bsi6?=
 =?us-ascii?Q?Ib4hhxVYuO6i3VYSNQkNfZ4Wb8KP9KI9ChBHraP/1R5wFnPAsSM8xnAMiPHk?=
 =?us-ascii?Q?TcOtR929CEcptB1xP9talKiFqOaR/LmXFfcLUHd7Pd0eDakJh0gSt0petmdw?=
 =?us-ascii?Q?Dt36O3ICPSc7jcGb+n52GHGy257s7akfI+3BrldVupcdkj+dURXby5WQiG1j?=
 =?us-ascii?Q?ITV1nucjay+kYbi4pNQfHNt7ZQzRf5kA4PDfXdtt+dLy9cGAXECluA32pdTJ?=
 =?us-ascii?Q?zGLj/zGJZS6UBIDf1K+nzwg9I+Y8a5H5NaTTewPd1kSv7afyA+Buf8XHH0SK?=
 =?us-ascii?Q?mAUM4Hb4LhT9TBCglUyiAqE/E0sotKT+zYsn8Uw2njCDRMVtdrvbCSHaLN+l?=
 =?us-ascii?Q?cxsxavYDoG4kbA6RT+NAAFNTNQtaakWEDVZzqBdZXj9H/RbdDYxhmXJbPb20?=
 =?us-ascii?Q?Rwf0RIq6YQL36GWxy85PK0Uovu265A9ZyRBDFK1DbgEGRcyYaZsT4I2SaclR?=
 =?us-ascii?Q?3lspvm/Ajy/zZd8uTclqNo5t4peWDjcsEdY7wuFbFf9a9a/iXWtrya0pDzOO?=
 =?us-ascii?Q?EA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 854fa766-3221-4472-7b14-08dd8ef8947b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 12:54:05.0094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: miEMNuQnhZ6jKNKe78v6UlEg/2/ld11v1iJK0bR7UCOEgr2z54x2RoEZYqq0fnnGTMsnbQsXnvdQnJy7Q/TxNAMe6yVGfTpQu/ZwK+Moz4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4984
X-OriginatorOrg: intel.com

>From: Simon Horman <horms@kernel.org>
>Sent: Monday, April 21, 2025 3:23 PM
>
>On Tue, Apr 15, 2025 at 07:51:14PM +0200, Arkadiusz Kubalewski wrote:
>> Define function for reference sync pin registration and callback ops to
>> set/get current feature state.
>>
>> Implement netlink handler to fill netlink messages with reference sync
>> pin configuration of capable pins (pin-get).
>>
>> Implement netlink handler to call proper ops and configure reference
>> sync pin state (pin-set).
>>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Reviewed-by: Milena Olech <milena.olech@intel.com>
>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>
>...
>
>> diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>> index 2b6d8ef1cdf3..b77e021356ca 100644
>> --- a/drivers/dpll/dpll_core.h
>> +++ b/drivers/dpll/dpll_core.h
>> @@ -56,6 +56,7 @@ struct dpll_pin {
>>  	struct module *module;
>>  	struct xarray dpll_refs;
>>  	struct xarray parent_refs;
>> +	struct xarray sync_pins;
>
>nit: Please add sync_pins to the Kernel doc for struct dpll_pin.
>

True, fixed in v2.

>     And, separately, it would be quite nice if documentation
>     of the non-existent rclk_dev_name member removed too.

Sure will try to submit separated commit for this.

Thank you!
Arkadiusz

>
>>  	struct dpll_pin_properties prop;
>>  	refcount_t refcount;
>>  	struct rcu_head rcu;
>
>...

