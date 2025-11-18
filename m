Return-Path: <linux-rdma+bounces-14590-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F21C67F53
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 08:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95DB24F80DB
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 07:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0AE30101E;
	Tue, 18 Nov 2025 07:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2GntikN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACFD226D02;
	Tue, 18 Nov 2025 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450546; cv=fail; b=tvFK+HH+B9UDY1IvkT0A08Uu4v3foo/nuvMJAyPYGaEGQ+ojzeic2m33XgCFNrnu4eyEjpOj9C44buPGcqb2KsYoLOB6P2hjvvZyskj4vtZwqH9qmAag5322vSf43YuYgZUy2AXqdit26GvO2fikyYLdOtj8U+LsSsvbPoKn2EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450546; c=relaxed/simple;
	bh=27av1HWxYyyqGGsha2pmf2soaN4tB8FcJ3yqHsSb9g4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=flY+QJxI8JH5AAwbRu9Xe0MV0y4+Cp6LSE5OORuWOxPqDUGRGSppCrfv55CjiDukAzuZZbINGXri3Q/dononV2nuf3vYE/i8+DkCZBPk/T98HPzVTdqNgGR014tVVgC42GpBaHjVNE3hgH5zL9YrxdSbq+vGHcRHHcCouYWBB2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2GntikN; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763450545; x=1794986545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=27av1HWxYyyqGGsha2pmf2soaN4tB8FcJ3yqHsSb9g4=;
  b=T2GntikNM6d/IArteje3T7Ac8DtYwisgAvU9SkQ+AtSxD5cV7VOF+jqT
   h3E9Gz/ReQ36AtU7WfnI/Qc5Ttxyx+rwUjDzUfwQ40jL+YxRJVkRJLUgy
   GG2JV0JXYp6SvSVZTyQD2iTEc3DCYfB0W13kDmfpxxgxnIhDh1GEVWu99
   RV+LapEn5DhDUxI0qFlqjz2coAOgHvhKlXzFvQr2iJZJnCKDqQ2UeWGMO
   VltpPui4u8XUky1E83uZJAZXT95c47RATD1aClK8W83GyjNYI5x0pcbzD
   CQgR/3qYR142MM00OVFR16/LQYPsd2MnCUohiWh4yjgHeUDQVpIUjpBL4
   g==;
X-CSE-ConnectionGUID: S9CZFHkCTnWJz/XXZfql4Q==
X-CSE-MsgGUID: O//NjIjaQMWN32ngKHwTvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65620005"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65620005"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 23:22:24 -0800
X-CSE-ConnectionGUID: mgGaVsiMSdWL1NTG9jcg3w==
X-CSE-MsgGUID: kngwiEvWRmKQbnisLQqJfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="191456056"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 23:22:23 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 23:22:22 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 23:22:22 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 23:22:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO+2bwDa9yaq6XuimS6+C2xq6qEUnO0uFIuUaQAlqWw7BUsYDvwAu69yqH9hmUPzEFK8cYNylcJifejwpoCftYJghSCj2y7RvIKLtiAtwD4rVFYPp1drYasP9FYtuckM2lHsP6a87N1/cwUYo/Hzo1w8CYLBWTpa0Ll2/xmtke+NpGiRGyN8YooTIkxq2KZ5F03HCW7+B4fTcHCJw5lY9aGFd3mXakNSmrzz5t69gvj6Pm552PwJoF2XWLCNIt+g6pBKovRismFcUxUK5Q9Q377yku0Z2+N8wj0fuI1ZYkxNd2i/LPtYxykx5dxJqz44pDYUXAFkS69ydZu+VhNAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27av1HWxYyyqGGsha2pmf2soaN4tB8FcJ3yqHsSb9g4=;
 b=yRmyZNkHCscZIj1f2HN6dpsZNx/IIW2Z84Xp4yJnRdpV3jj/Xjj4fGFdVl+9acSYTae3uNhGJjeXT4LZVupALGeEDsUxrkm+cjZiZfpoKenvCRg2IIidD1ZQdI4/Qux2fvfpOpQNeklODtJTwtf7rogA3eEQnbcfqUp1IvYXui+a6c4XtRQpMg6ekJVeXxsQz4cpR8BXD0qnm2gQkQJPlGkOubgwhVWu2pSyguvQ+FjvOBdhTB/cd82IGfOYUu5FOzGz427tzaouSe5/+9aGArMxLVRyROi0teX1ta9RAl7amoo7hqW3tNMLNzLAFKj9i4Rsu0jk3ICIOt1+7gybdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 07:22:14 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 07:22:14 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Srujana Challa
	<schalla@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Brett Creeley <brett.creeley@amd.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Goutham, Sunil Kovvuri"
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Tariq Toukan
	<tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Manish Chopra
	<manishc@marvell.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Siddharth Vadapalli
	<s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Loic Poulain
	<loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean
	<olteanv@gmail.com>, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"Ertman, David M" <david.m.ertman@intel.com>, Vlad Dumitrescu
	<vdumitrescu@nvidia.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, Alexander Sverdlin
	<alexander.sverdlin@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v4 5/6] netdevsim: register a new devlink param
 with default value interface
Thread-Topic: [PATCH net-next v4 5/6] netdevsim: register a new devlink param
 with default value interface
Thread-Index: AQHcWCHNbycRZBXbEUmsqZbRGyCKqbT4BzqA
Date: Tue, 18 Nov 2025 07:22:14 +0000
Message-ID: <IA3PR11MB8986340B6CC3B163668C7024E5D6A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251118002433.332272-1-daniel.zahka@gmail.com>
 <20251118002433.332272-6-daniel.zahka@gmail.com>
In-Reply-To: <20251118002433.332272-6-daniel.zahka@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB4831:EE_
x-ms-office365-filtering-correlation-id: 44ab6533-45d4-43bf-cd7c-08de267332a9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?N1FaQnUvRzMwNTU4SFh2Q2ZYem9IZFhaaDVGSDFCUllpeHJsYmdPYW51M2hF?=
 =?utf-8?B?TzF3WlZKckkvamNMeEpRWS9pVjVBbFdWcDF1R3Y3UVFuU2lIV3N1c2NvU2dG?=
 =?utf-8?B?NVIxRXdyY2JlMG1ieVFxWUtad2pkN3QvbTQ1dm8xdGlSNG9xc3FvMjk3a2hC?=
 =?utf-8?B?U09yOFV0ZEtxMnhBVmw4SU5HcGh0dlpvSFZWN3hlZXMwR2xIbE9PVUo1YXow?=
 =?utf-8?B?WTNMNHVUSHBYZ3lvU2pGZlpMVWhpZEpSQ3BDc1pSZEowUXhMclZNNzhlN0gy?=
 =?utf-8?B?ZDFvalNBMUVYUU02U1FYT2tzQjFSQk00N2RyQ3l2cTZ6ODh4M3lOWnBSMitu?=
 =?utf-8?B?RnRIcHpZRU9xeS9vakh3YjlhcFFMd2piZDJNUldsODIrYldQQTdzY1VySmpa?=
 =?utf-8?B?Q2U3a3Y3eW54cWw3YzFlTmF5ZGsxNzhFWFJCYlRYMUcwdW5NZDZnZGhBTHZ4?=
 =?utf-8?B?S2JqellTNE5JZTlHb0l1Z2xtYVZ5SFNUUVQ0VGlmOWJ3cWx0OGM2QU5tQmZJ?=
 =?utf-8?B?bmFMQUgzb3RsbmJ5SDROeEZHMnREUjd6N2VVd2FodWNJNjZQekFvYXYrQ0dD?=
 =?utf-8?B?VzlLbEdWNnNkQTFST1V3eUVRbzJmNkxFMkpMN092RmlEbGp1L1ZoeGNTNnh0?=
 =?utf-8?B?Z1ZGYjU1T3RHcS9BUjhkamx2MlNjdlFDWnRxdDRva0k4aGRRK3l1L04rNGs5?=
 =?utf-8?B?MXcvZ2pXM2MxNWNQSFMyaGpqSVF3Q0h4akExT3FBK2VuYXNhZjh6UUgxTEpW?=
 =?utf-8?B?Y3lXODBCWFRLUGJaNlNyN1ZkN1ZUQThEdlpveElJM0d2QU81R2JZbEV6akpx?=
 =?utf-8?B?ZGtNa3ZqWlZYaURRZ3dRbzROdTJ0T2lTUmhvV09KbDRqUmVCdFMzcTZiRFZW?=
 =?utf-8?B?UmwrZjlTb3lMSVFvZlV1QU4yRE8wdTlQL20wOWtNeG9mam5BR3UvRXBoYVdS?=
 =?utf-8?B?UkVDL0daNTM5OWhQRmpTMHRMMTkwWTkraVo4ck5BL0NWOXFSbVgwOTVwbGty?=
 =?utf-8?B?RGFHWHBiNDlIRTBROHZiK2dBdnhkaG9DY0NjeXNndVAwaHZpc0RkUDdncnFB?=
 =?utf-8?B?TUVHbWlrbzNDdHpPcktZTTg4U2RiVFJNRWJFMVNzY0lDZ3pSOWE3QnNkQXpN?=
 =?utf-8?B?VmsxaGFHaWJGY3JqM0kxU3krQlArR1dmQmJlWVhzS1VFeElEV1dQcENkZWhi?=
 =?utf-8?B?ZmNOSVZvYlQwc3U0dG9wbUNOWkoxdjY0RXdFYmlxV1cwR1hhQmh0dE1IaGVw?=
 =?utf-8?B?czR6ckNPUG5RcVF1RitGUGFWcHJ5MmZDbGRHd0tudWJpU1p4MEdIbEFERVJa?=
 =?utf-8?B?Y2JGYnVxRzVkWi9XRFo0UUgvQ1ZiSksvNGVKRUhZbHZHMTY2azVxNHQ1UVNL?=
 =?utf-8?B?cTA5MlZ4azFzOERtZG9uMzA2aU1QZzZkTG1pOXdZTXR5NU1rdldmaEh4aGJj?=
 =?utf-8?B?N0I5SWpXYVo1THVyeXptQVVicm9sMkRvczNkSlBsYjBYdmI5Wk9nVEpUYzlS?=
 =?utf-8?B?OTM1eWRUZHBIMWtXS3hNTTYrbm1LZTEyZFRqWnhqbHdPWGg1bW43dHZtSnhL?=
 =?utf-8?B?L2pMQXpKazVuS0orNVN6Qkk5dnVIWFBoK2o4L3JsdTIrQ3FWNUJJb0hWWFR5?=
 =?utf-8?B?ZVlKWWFEMFByeTFnYklWTlhTcmU3WFU0TitPYTZuWFNTSkp2czdnRi91Qnly?=
 =?utf-8?B?K3RMYStvUUh5NHc0VFZoMFcyS1FCWW44RWQwd0o1YlpkeVB6QnpPYlhFR3N1?=
 =?utf-8?B?WHRDNUJ2SnZDb0VOQnN2VUhTY2lUWlB4cnZjalozbzNWcDY1VFM4SUhHcWlV?=
 =?utf-8?B?cFhHUzl3WGNFcTdkaXhnSE5uU0J1WS85eE1pbVJlQlI3T2grUFNIVUZxR3Vi?=
 =?utf-8?B?WGxlVzZNeTJ4dkpBMVJ6MHdtNlEyd1VULzBhMUxyOE1JNVpCY0c2K043bTYx?=
 =?utf-8?B?dzRiMFBSMkgxTkhuaGgxTFp2dURpczU5TUVUWmJCK0lGbjZ6VmMzOTEyOFIz?=
 =?utf-8?B?WVJ5UFdjUE5BS24zN2p5ajNUaHVoSnBzanQ5eWM1eXppTmJNVjBmeDZ1NTJJ?=
 =?utf-8?B?SzNaZ2l3ODU3SXludWJRcm9Jbk5GSHVjTmplZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cCt0SC8xdmgrWVg0RlBqTEV3d2k3STRaZzRCQnZTckdSb2ZqNEJMTVcvR1p0?=
 =?utf-8?B?OGliUVpZRzRnZGV5N0pkMU5sUmcvUHVsYndxL0VsUURjVENwbnplMjE1WFNK?=
 =?utf-8?B?dW9uZEhoaDAza2xnV3NxUVNUZmhlczlOM2hJNHMxMkVabnpUdXNzc3pqR3Fk?=
 =?utf-8?B?NHpvVk1PLzhhejBnRXkwWlpSeGhNS3AxZnE5aVJzbWxHeE5tOEJYYkR5dkQr?=
 =?utf-8?B?RGFHL2ttOCs2MUkveS82STJNcytEUlZtM2dPSkpsd2FpNHRSYThpTnJId2Nq?=
 =?utf-8?B?V05ta0MyUEVhWm14SEpubGhic0xEc0lYNmlsM2MyYmd5SW1EcUUwVkNwMmFO?=
 =?utf-8?B?dHJnOW9BN3d2aUkxY204dS9LdzRZd3JoRjcyNGsxMHZvTXg0OUFvZDU3RGcx?=
 =?utf-8?B?N1dHTWJuMk1JbUF0R2lsbUJlQkw0L3poWVcwTFVTTmJ4V2cxblNyQzJBUElF?=
 =?utf-8?B?YnhVaHlpOHhVQTVIRE9yYlRmZEkrcStxUUNFcTF1c2xqQTNrY3RJV0FSRHdr?=
 =?utf-8?B?Mm45Qzl3cysrZlVKdUpQNU43UUNsRHBDZjFVckM0d0FSdGlQSmFNTVo0U1cv?=
 =?utf-8?B?eXBld1VnazVYWHRZd0tPRkY1bnkvTngrMjNncVgrbUlpNnMzV1lwOHhHOHBR?=
 =?utf-8?B?TE5uVTBaOHJEdUxRZzhFREFqeTlBQVFKUFE4WnpGVDZkYk9IOGZnUS8xTDlx?=
 =?utf-8?B?djNTT0FiVFJtZFhaaXNHNHVuR0NuUGlINVNSc1hRYktsMTFxNWxzWU9GR1FB?=
 =?utf-8?B?b3JjeG9OMmJWTUNXMFJHenlxZW5RbGhJejVQV3RHUjExQXpxRTU2TGRnVlZ2?=
 =?utf-8?B?ZzZ6dDgwVTZwUmh0WFkxWGU0L0Y5YzNlOXB1c0xxdjhzMEVOWTY4ZnV6M1Qr?=
 =?utf-8?B?enRlYzg5empZQUY2NVpRM3lSeTRPdFZEdlpxaGJKR1g5bktubkExaG9tOVlO?=
 =?utf-8?B?a0RKOHF5NlVVNVFHTmkvdTh6dUNPc1VjU1ovM2lQMnFKbHVIL1JwZm1GRlRC?=
 =?utf-8?B?bUxodGlyTFliOW9pak83Ukt2SVZKT2NpZUphbmVYVkMrVERQVkRxWnBtbEFB?=
 =?utf-8?B?cjhEUTlTNDJrVGlrczA3WVVHUCtpSU5BL1pURlNncGdET0owUUtQQUJWd3VK?=
 =?utf-8?B?d2RRL0FOVktyd3dlUVFQaTcvM0hXdEFyS3lPMHRFbFZ1elVCRlBnU3VoRmpS?=
 =?utf-8?B?NERNek5YM2ZUbjExSXlBS3oyZFRiNzk2bi8yWnhwWmgzT1NjckFMZ1JDMTFL?=
 =?utf-8?B?U1NWa3pQRnJhZC80NGlCaGRzZVNBM1lsYTNyTzdtL2RCTnhGQnpmR3FJN0VU?=
 =?utf-8?B?WUZEdHVFMFBkcHh4Wkg4b1BTN0l3Vko3VzlYdFhBZ2R3VEc1TUpUQkhrOEpQ?=
 =?utf-8?B?d2x5NEVhMVQ2MWNnNDJEREx5NTY0SWlMRkZIR1ZVSlVJelZ4dkU1Wkx5ZnhW?=
 =?utf-8?B?YWRXZGwxa0xrS0NaN3hEWUpvd0RDQnJkMGg1Y3RWMUJWS0tPTEtjaVNUbVJh?=
 =?utf-8?B?NlQrNTBEb0xzUWp1KzJZa2xzU3FtOUhNRmtzS0p3QnU0N2p4NVJLQ3VaRFRi?=
 =?utf-8?B?VHk4NXlrYmRkV2dYLytLbUFQaWJISlR2cW9hY3Ezd05zQmxVMEsxTHF4dldH?=
 =?utf-8?B?L1g1ZlhnbXErTzBaSzU2YWtmN1EzcWU3bEdMUTAvM2ptclNUVVBZNm9mck9I?=
 =?utf-8?B?eFlBc3QzWExCTVAvT3FtK2YybGxjdVV6NE9tMHIzY2JrTlczYjQvTlRJU1pv?=
 =?utf-8?B?Uy9rcnBwNlZmbVJiRWR2SERvTEp0UXQ5YnBhUG5wV2ExLzVCanBtVEZJcW53?=
 =?utf-8?B?SHl2NkZvR1Z1ZTJlV2NlQnBvcFV5Uk1zUDV6d2FqMHBQL2pMRkd1VnBYdUZ5?=
 =?utf-8?B?NGxycFg4K1VyMVJ3QVZqWTRuU3ZaZm5YRXpXenZzSU9GaVFDM1FRZkJQK2Y4?=
 =?utf-8?B?VnhxWlEwNTRhUVpCWmFCeW9DYVBxT2MrMjBwUGZFUHY3MUVLTUxBRXJ0Q3Vr?=
 =?utf-8?B?RjBFcGdndlI1dlBXNjVudWcwQ2FyazFrL2xTQUcyQkZJTndDQWhBcUNqaWph?=
 =?utf-8?B?VlRQVkNWV1d6bVdpVEJMTGZsbThXM1cwMDc2cHpUSW1pNmxEbkNxamVCbmE4?=
 =?utf-8?B?amVKUXNOM2tJWmRrb2ZYVFRGbXhlbmRpaDVEVXlrR2lGVStXQ3E5U0NQWVhL?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ab6533-45d4-43bf-cd7c-08de267332a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 07:22:14.5828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDXCZW8si62C2BIAfIcBB2BmfSm1Qdl0C2vz/iud7LeAb+JYRTGs+qzQa6e1tNH5fDh1+g2dUqzi5k1zsQ8OEo85W9xAvvpi9X3IaZfpR6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4831
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIFphaGthIDxk
YW5pZWwuemFoa2FAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxOCwgMjAy
NSAxOjI1IEFNDQo+IFRvOiBKaXJpIFBpcmtvIDxqaXJpQHJlc251bGxpLnVzPjsgRGF2aWQgUy4g
TWlsbGVyDQo+IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBn
b29nbGUuY29tPjsgSmFrdWINCj4gS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFi
ZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IFNpbW9uDQo+IEhvcm1hbiA8aG9ybXNAa2VybmVsLm9y
Zz47IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+OyBTcnVqYW5hDQo+IENoYWxsYSA8
c2NoYWxsYUBtYXJ2ZWxsLmNvbT47IEJoYXJhdCBCaHVzaGFuIDxiYmh1c2hhbjJAbWFydmVsbC5j
b20+Ow0KPiBIZXJiZXJ0IFh1IDxoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU+OyBCcmV0dCBD
cmVlbGV5DQo+IDxicmV0dC5jcmVlbGV5QGFtZC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3K25l
dGRldkBsdW5uLmNoPjsgTWljaGFlbA0KPiBDaGFuIDxtaWNoYWVsLmNoYW5AYnJvYWRjb20uY29t
PjsgUGF2YW4gQ2hlYmJpDQo+IDxwYXZhbi5jaGViYmlAYnJvYWRjb20uY29tPjsgTmd1eWVuLCBB
bnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0c3plbCwgUHJ6ZW15
c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IEdvdXRoYW0sIFN1bmlsIEtv
dnZ1cmkNCj4gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgTGludSBDaGVyaWFuIDxsY2hlcmlhbkBt
YXJ2ZWxsLmNvbT47IEdlZXRoYQ0KPiBzb3dqYW55YSA8Z2FrdWxhQG1hcnZlbGwuY29tPjsgSmVy
aW4gSmFjb2IgPGplcmluakBtYXJ2ZWxsLmNvbT47DQo+IGhhcmlwcmFzYWQgPGhrZWxhbUBtYXJ2
ZWxsLmNvbT47IFN1YmJhcmF5YSBTdW5kZWVwDQo+IDxzYmhhdHRhQG1hcnZlbGwuY29tPjsgVGFy
aXEgVG91a2FuIDx0YXJpcXRAbnZpZGlhLmNvbT47IFNhZWVkDQo+IE1haGFtZWVkIDxzYWVlZG1A
bnZpZGlhLmNvbT47IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPjsgTWFyaw0KPiBC
bG9jaCA8bWJsb2NoQG52aWRpYS5jb20+OyBJZG8gU2NoaW1tZWwgPGlkb3NjaEBudmlkaWEuY29t
PjsgUGV0cg0KPiBNYWNoYXRhIDxwZXRybUBudmlkaWEuY29tPjsgTWFuaXNoIENob3ByYSA8bWFu
aXNoY0BtYXJ2ZWxsLmNvbT47DQo+IE1heGltZSBDb3F1ZWxpbiA8bWNvcXVlbGluLnN0bTMyQGdt
YWlsLmNvbT47IEFsZXhhbmRyZSBUb3JndWUNCj4gPGFsZXhhbmRyZS50b3JndWVAZm9zcy5zdC5j
b20+OyBTaWRkaGFydGggVmFkYXBhbGxpIDxzLQ0KPiB2YWRhcGFsbGlAdGkuY29tPjsgUm9nZXIg
UXVhZHJvcyA8cm9nZXJxQGtlcm5lbC5vcmc+OyBMb2ljIFBvdWxhaW4NCj4gPGxvaWMucG91bGFp
bkBvc3MucXVhbGNvbW0uY29tPjsgU2VyZ2V5IFJ5YXphbm92DQo+IDxyeWF6YW5vdi5zLmFAZ21h
aWwuY29tPjsgSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD47DQo+IFZs
YWRpbWlyIE9sdGVhbiA8b2x0ZWFudkBnbWFpbC5jb20+OyBNaWNoYWwgU3dpYXRrb3dza2kNCj4g
PG1pY2hhbC5zd2lhdGtvd3NraUBsaW51eC5pbnRlbC5jb20+OyBMb2t0aW9ub3YsIEFsZWtzYW5k
cg0KPiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+OyBFcnRtYW4sIERhdmlkIE0NCj4g
PGRhdmlkLm0uZXJ0bWFuQGludGVsLmNvbT47IFZsYWQgRHVtaXRyZXNjdSA8dmR1bWl0cmVzY3VA
bnZpZGlhLmNvbT47DQo+IFJ1c3NlbGwgS2luZyAoT3JhY2xlKSA8cm1rK2tlcm5lbEBhcm1saW51
eC5vcmcudWs+OyBBbGV4YW5kZXIgU3ZlcmRsaW4NCj4gPGFsZXhhbmRlci5zdmVyZGxpbkBnbWFp
bC5jb20+OyBMb3JlbnpvIEJpYW5jb25pIDxsb3JlbnpvQGtlcm5lbC5vcmc+DQo+IENjOiBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
cmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIG5ldC1uZXh0IHY0IDUvNl0g
bmV0ZGV2c2ltOiByZWdpc3RlciBhIG5ldyBkZXZsaW5rDQo+IHBhcmFtIHdpdGggZGVmYXVsdCB2
YWx1ZSBpbnRlcmZhY2UNCj4gDQo+IENyZWF0ZSBhIG5ldyBkZXZsaW5rIHBhcmFtLCB0ZXN0Miwg
dGhhdCBzdXBwb3J0cyBkZWZhdWx0IHBhcmFtIGFjdGlvbnMNCj4gdmlhIHRoZSBkZXZsaW5rX3Bh
cmFtOjpnZXRfZGVmYXVsdCgpIGFuZA0KPiBkZXZsaW5rX3BhcmFtOjpyZXNldF9kZWZhdWx0KCkg
ZnVuY3Rpb25zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFphaGthIDxkYW5pZWwuemFo
a2FAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L25ldGRldnNpbS9kZXYuYyAgICAg
ICB8IDU1DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvbmV0
L25ldGRldnNpbS9uZXRkZXZzaW0uaCB8ICAxICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNTYgaW5z
ZXJ0aW9ucygrKQ0KPiANCg0KDQouLi4NCg0KPiArc3RhdGljIGludA0KPiArbnNpbV9kZXZsaW5r
X3BhcmFtX3Rlc3QyX2dldF9kZWZhdWx0KHN0cnVjdCBkZXZsaW5rICpkZXZsaW5rLCB1MzIgaWQs
DQo+ICsJCQkJICAgICBzdHJ1Y3QgZGV2bGlua19wYXJhbV9nc2V0X2N0eCAqY3R4LA0KPiArCQkJ
CSAgICAgc3RydWN0IG5ldGxpbmtfZXh0X2FjayAqZXh0YWNrKSB7DQo+ICsJY3R4LT52YWwudnUz
MiA9IDEyMzQ7DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQNCj4gK25z
aW1fZGV2bGlua19wYXJhbV90ZXN0Ml9yZXNldF9kZWZhdWx0KHN0cnVjdCBkZXZsaW5rICpkZXZs
aW5rLCB1MzINCj4gaWQsDQo+ICsJCQkJICAgICAgIGVudW0gZGV2bGlua19wYXJhbV9jbW9kZSBj
bW9kZSwNCj4gKwkJCQkgICAgICAgc3RydWN0IG5ldGxpbmtfZXh0X2FjayAqZXh0YWNrKSB7DQo+
ICsJc3RydWN0IG5zaW1fZGV2ICpuc2ltX2RldiA9IGRldmxpbmtfcHJpdihkZXZsaW5rKTsNCj4g
Kw0KPiArCW5zaW1fZGV2LT50ZXN0MiA9IDEyMzQ7DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsN
CkR1cGxpY2F0ZWQgbWFnaWMgdmFsdWUgaW5zdGVhZCBvZiB0aGUgcHJvdmlkZWQgbWFjcm8uDQpU
aGUgZGVmYXVsdCB2YWx1ZSAxMjM0IGlzIGhhcmTigJFjb2RlZCBpbiB0d28gaGVscGVycyBldmVu
IHRob3VnaCBOU0lNX0RFVl9URVNUMl9ERUZBVUxUIGlzIGRlZmluZWQgYW5kIGFscmVhZHkgdXNl
ZCBmb3IgaW5pdGlhbGl6YXRpb24uDQpCZXR0ZXIgdXNlIHRoZSBzYW1lIGRlZmluZWQgY29uc3Rh
bnQgaW4gYm90aCBwbGFjZXMuDQoNCkV2ZXJ5dGhpbmcgZWxzZSBsb29rcyBnb29kDQpSZXZpZXdl
ZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+
DQoNCg0KPiAtLQ0KPiAyLjQ3LjMNCg0K

