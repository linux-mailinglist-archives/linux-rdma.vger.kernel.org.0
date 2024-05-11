Return-Path: <linux-rdma+bounces-2408-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E18E8C2DF1
	for <lists+linux-rdma@lfdr.de>; Sat, 11 May 2024 02:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A2D1C21487
	for <lists+linux-rdma@lfdr.de>; Sat, 11 May 2024 00:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91BCBE5E;
	Sat, 11 May 2024 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7Dl+/15"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530FD8BFF;
	Sat, 11 May 2024 00:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715387545; cv=fail; b=D9xtv+guV46HXLFkcLLPBq21TAwSWmKJUZf6sLPw8W/dijmCBr1MBd2H7IszOnoxrN6TropGrYzkgL2a66VC5lFSZVGtDY8hxtJBwi7eb45q8X/G1inJhHVyDSpgz+LH6eEP4udbyfkLr/qUaUG/eIuCx0V+ihPxVzoALxFKsCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715387545; c=relaxed/simple;
	bh=t9LLYLC+b9Qi953G8TaZ56cpgfYE+oC9vGR2U24YPis=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qN8Xuq1KjQZH0lTpZ7dIK1mSxAbkGTZD3Hz3Wdr2P93Q9RZ047wem1WNQNOKlfwZv7FQFCaVlTmU9mBcGAt7B3yPxUOEnO1c5HIXg8Sbzu1G03Vb212yi6DCrIxT7laLjatZtPmZB+Z/d20Lnfz0GbQQGBx4S2ZkIWtY+ThzEls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7Dl+/15; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715387543; x=1746923543;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t9LLYLC+b9Qi953G8TaZ56cpgfYE+oC9vGR2U24YPis=;
  b=K7Dl+/15TO3ZEOcM2EZTu49tdr6/imxm+lQkFPCcfzZncUx3G/bwOrPL
   eoiUZnWwiw21wmCKBq+1J6Sk1j/WcT3/N72/egRexZ9F2JzhQCg87TNbl
   3IZ80jvfhBEFhr52l39v0wteM8R0Kk53X1v/mHbhKYephDR8Xt+QHNp6S
   uE5YCq3zOWdR4IE7jF8INQT7cN3F+KCMIe3xq8vFtp6mfIEmAXE9exlcF
   jqFDfdcsXvqjnYJdtwO3SZkSc/M8cU9EUtlxZB86NOG4YaJUq3hEFuK/d
   Ve9oGjnTiMTr5mxFYTUacwko1Mj3Qx+NrVWqqCXXWKVAPvncPF0jFQoBm
   g==;
X-CSE-ConnectionGUID: eoYZsN6tQoqiZqakS4i4wg==
X-CSE-MsgGUID: TfhN6fd1RQOdXgJPyWoriw==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11524856"
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="11524856"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 17:32:22 -0700
X-CSE-ConnectionGUID: 1bw0RyZdQeukICrnO6vcaA==
X-CSE-MsgGUID: lk0Th5/6T8iGEUBLBlF/Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="29882305"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 17:32:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 17:32:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 17:32:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 17:32:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK0v7oSakrnkKBIY2y2NvAecRc33Ipbp+zV1GZMxT8QxcfvwUDqwBE6uacHZj/2t3oYHBjXkQeaIsG7+3YC7J0Neu/KpMHD6Tt2KbEHit3Sj4yyZQiKGZK3yV82Fgoy+FS5f76eHhInYQeW8HOV7+h3pNpZSuY9oJOCIdshCoy4WTBYaiypeJYaHktf048x/viqBsIJHKyTa6ptsPLUWoVnVM3kKhWTXcThGXYdH0nE0AORIe5hAYB8KWYyaex3P4TmoZjc+offXhaAZjNmaLJM4I1EwNUrGjWqx6ZUe1ONDc9XiJ333Z50IQUTpe/pdanO0Hq8YjJpkg5sN5eaAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9LLYLC+b9Qi953G8TaZ56cpgfYE+oC9vGR2U24YPis=;
 b=jm061akdX44S+ZZn+/966YuOFAnNoVmou6Zwcv2pDrCLejL9iwGlZ+UyctoQg1wNvoIOZWyKxIo+GY7O6eZjCcuZN7boNOIBR9R1Nmu0QopJgBLnmRiZ/QJyZi/jl+pX3wfEt4DU0Svu1ZAS1vV/WnmtBti9n+fbnTxOJI/4Wpcx6JDhx9eWrI09i2uuR76nrFOpPzJnlBWHrjoVWm86IhZzJvkOSJ2OQxD7F+ClXDaqIbrp2WZMzHH6lLqMCkwB5NTZmir1bhS6c9ig5iuEGrcbgYFmwd4125fY6QDtlcnONn1ePG7+lLtaZXjOCxpKE2BTh2iQoQ5bdsuSYFU7GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51; Sat, 11 May
 2024 00:32:19 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.7544.049; Sat, 11 May 2024
 00:32:19 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>
CC: Christoph Hellwig <hch@infradead.org>, LKML
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Marciniszyn, Mike" <mike.marciniszyn@intel.com>, Leon Romanovsky
	<leon@kernel.org>, Artemy Kovalyov <artemyko@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>, Pak Markthub <pmarkthub@nvidia.com>
Subject: RE: [RFC] RDMA/umem: pin_user_pages*() can temporarily fail due to
 migration glitches
Thread-Topic: [RFC] RDMA/umem: pin_user_pages*() can temporarily fail due to
 migration glitches
Thread-Index: AQHam17yJhY7Ox7lSE6fjj1R8qzVJrGB1ReAgAB1SwCAANiZAIAAYfwAgAC8NYCAC+adAIABEiww
Date: Sat, 11 May 2024 00:32:19 +0000
Message-ID: <IA0PR11MB7185E9238489E5AE829E587FF8E02@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20240501003117.257735-1-jhubbard@nvidia.com>
 <ZjHO04Rb75TIlmkA@infradead.org> <20240501121032.GA941030@nvidia.com>
 <87r0el3tfi.fsf@nvdebian.thelocal>
 <92289167-5655-4c51-8dfc-df7ae53fdb7b@redhat.com>
 <a2032a79-744d-4c00-a286-7d6fed3a1bdb@nvidia.com>
 <f7511bd9-edc7-4ad7-ba1f-2920d7d94517@redhat.com>
In-Reply-To: <f7511bd9-edc7-4ad7-ba1f-2920d7d94517@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|MW3PR11MB4681:EE_
x-ms-office365-filtering-correlation-id: 5342772d-8623-46b3-23bf-08dc7151d120
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aXFOMFVoRjdTVmt0U3FOcUV6VW80TjFIOFNzS243TDNzQ2dVVmt2YjZMS3dD?=
 =?utf-8?B?TDR0am8rODI1Q05IQkk4L2tNTzdrTFZPUEp2aENacjBIZ1JFaFIxYmVtRVBq?=
 =?utf-8?B?dTFWRzRES3Z1MldBcFRERzZYSUtHWmI1Y0NDTXAweTFUR2piRlBSWkRTNzN5?=
 =?utf-8?B?UDFZTVBsUk04cmhsdW0reWw5U2NtbThza0pOOFRGcWR3VEF4TUNOaXZKZ1cv?=
 =?utf-8?B?Yzc2VjdRSzRBdHE4TERDNHZuNWp0aWZSYWNYYzkyeEhPNTdkQXFzVVhkckt2?=
 =?utf-8?B?WklWd3BpaWVDQmtxc2J3VWpNMElvZ3kwR0toS2k0dzA0OXJzamxHa3Nkb0NY?=
 =?utf-8?B?R0N5cE02cVRBYWtITkRNTVJSRW9ybGNhbCtvVERYeUNTbHIzem8xQXVWbUoy?=
 =?utf-8?B?QzlpUEg5Y2pEYTdDcG41cTRCTURub3VIY2hiN3d1R1VZTENnNlp2K0d2L2xF?=
 =?utf-8?B?cUp6MzVHdmFsN3l6aERPYzcra21EelArTUNzNXFHenQvTTVlcmtJa3dISVdl?=
 =?utf-8?B?ZThadmdxR0h4c1g2MU5KVVFkY1MvaE04RVJMaXZyN010ZE9NT0VVYWRrdEVY?=
 =?utf-8?B?dXpxbFhWaVdmS0lGR2VjczBzdXZ5NEw3WWFlbDNaR3lXMUpjV1BBVU9GS2RE?=
 =?utf-8?B?V2dHSXZDb3ZIdGF4TU9VSldMY2ZpZFgzVXFrSW5OcEkzL25RVmhsVWdBbEcr?=
 =?utf-8?B?WkZRdG5XQ2ZDQWtMRHdoOTlXemdVV1pRaFpXS0lsN291NWE5a0gzZEdhdWJ0?=
 =?utf-8?B?YVQ0dDk1RG1WNmNRL1ZyNTBUT1VHcUFzSGVDRXJvK0FJM0tHUVJERmduc1hB?=
 =?utf-8?B?QUxZQ2hHK2NTWDFwM0FwOGlzejhnODlVSWtPV3VpSWRTZDA2cTAySDlVS1E4?=
 =?utf-8?B?anUzUk5mTnNqL2ZJMzRIV3RGTnVycTNSQzBEdVJkNDZzRGlqenZiVUtqRUhv?=
 =?utf-8?B?WHV4Vk1RZGlMcUZ6alZxYWp2c0FlQmp0VHR2alFoWWV0aHZ6Rzlwejc3SVgv?=
 =?utf-8?B?WHR4dGhQV1d0a1NRYldBcXU3OVg5cWFZQm5aVCtxTEJFS0QrRENydXdtNWxN?=
 =?utf-8?B?NnBURHZGQmh0TE1ZeDQ0Yk40THlIelRLV21PWTZYanhVYkdHWEszZ2RLU0o0?=
 =?utf-8?B?cm9uTURncGM2cktWMzVpcWgyVjlSNEQxUHM0M3hVT1Y4UUVocWlvbTBWS0xj?=
 =?utf-8?B?Q0NmRTVKV2ZzOEowZEhFL1VFVENYd3RhbS81dWYxb2tzVXF4ZHptTFZNMUR1?=
 =?utf-8?B?WXBFS0JhK2dQVFlDV2ZmTEh6NDlKOTdPMDVyUWJxd3Y2YUpYbndIQTJtMTh6?=
 =?utf-8?B?M1J4eDR0clc4NStHNUZGOEZuWUNUSW1FeElza0h4MC90TUVQRXg2dDFvdDZa?=
 =?utf-8?B?MWZMdTgwZHlXTXZqWEtiakd5MTdza2xTWUd6ZC81YndPMmlXTWRkUTNaYnJT?=
 =?utf-8?B?dzMxd1J3eDcvcXY3ZDMrOXJuc1FPSTRmRzZhdmFqazEwOWlSWFdxQzZJREsy?=
 =?utf-8?B?dnhyL2pmdzBGZmkvVXhianhxWHZvZHhDWm1Uam0xeWc4YU1lOUdBeHI2UVBy?=
 =?utf-8?B?RHFOVHVyM1NjTkJuYkZud09nUzBJdWpVaVVZRkhBQVE1ejYxUFJ5RU00eUFu?=
 =?utf-8?B?TGpTTU9raGpick42ejZvZGEvZndKdmVYbTc4UzcxL29tcVRmMXRjQXRaYS9W?=
 =?utf-8?B?c2lSczdsNkV4WXU3cW5LSlJ0RjM4RGpaZnQ4VUdMRDZjTzBualZ5eGx3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1ZnOERhZ2hWVEdGaHkzbTRmUGxkd3Q1dWx2TWhDTi94V2lUY0hHZzNka2pF?=
 =?utf-8?B?RytBeEQ3bjQrTlVKSW5IVkt3VGV6SUt3enJhUXUzUUJISkE4dzFoSURIWTY4?=
 =?utf-8?B?bGxpM2E3aXhSOUI5cnIvdjRJQW5zUStYRFM0RlBQenU5RisvaE8xZGRQVXZC?=
 =?utf-8?B?ZkM3YXYxT3JLMDZ4SW5YM0ZGUWR2NTRQMmxMNk1NY0hvekpIN0dQY2RJTW5m?=
 =?utf-8?B?RlVJQmxONFI4cUZwcVlnNHpjYTZmV3FQc1E4cjRRTlYvaSt1TlZ5UnlqZSs5?=
 =?utf-8?B?WDVyZ0tYU0lCUU9BRDJpbmxuREh6MUV4UEh1YUw3MC9aeEhmTXZyZ3g0clA3?=
 =?utf-8?B?WE9xZktiZUM0MUczc1FuaTBWdXBaVnhIUlVDL2R4eXlrc1ZhSERTNVBmSjJK?=
 =?utf-8?B?Q3RlSitWb3N4SFNVbUkxTlVKWlNLdEtYaXc3S2ZVQURRMFEzSitPb2Z1TFo4?=
 =?utf-8?B?SU1NYy9SVVkzSHJqRy9RdVdlNFRXUTZiUG5UbkVvejBXdlo5Q1dDRjBUZXZ4?=
 =?utf-8?B?TzZWeWV0eDhaNHlxYS9Vb29zSzlyM3JJUE5UNjFHQW0vTVJkdFZGVzhMdlp4?=
 =?utf-8?B?dkc4OVpsd2taN2VNUEVpNndBaS9pbnh3UkZydk1obzVqdHlZREJRcVZZdUNC?=
 =?utf-8?B?U2JGMndkMUEwRDMwblU5Rk1SY1JhMVY0RHBEN2VuOUNQK0RRWG85UXhSVDlO?=
 =?utf-8?B?bnAzVWJyT3UzaTdDMmhEb3FGdjhxeGFieE9aWkZndEVOM3dRWTI5eVpHeDZr?=
 =?utf-8?B?YVQzaTdvN205SDBPL040S0V3K1liWENxd1dWamh6U1ZiQkx0QUl1dDFOQ0xH?=
 =?utf-8?B?K1pWNk81Y2VJOWZwYTZ2YlR5SUhmZ0ozeEVFekQ2U09SbXM2Y0pFV0h3VmVr?=
 =?utf-8?B?dkNuZThZRkxNSCtLM3VOV0NPdVJnb05qQWZlRHh3MVc5dEoyM09mRGJGanM3?=
 =?utf-8?B?M2ZRSGRKeEdLWUVsSFVhRDFjTitjcXoyQ0JYV2p3TlZnOE5RcFc0c3orQnJa?=
 =?utf-8?B?K05xU1pxY04vR2R1ck1aVFE2R0EzdndZSy9iOWhKeDNrZmxvbzJXRjBHSURP?=
 =?utf-8?B?NUlWQjZMTllmdW1FcEFwU0JYS2J5TURQTkdMenU5cTBSUGZWZHdRWUw4RE9x?=
 =?utf-8?B?cXVxcldnalpkRmttYUhEdzFyUXFDK0hwWjVqN2xBOWxQRXUzY3k2ZUdJakw1?=
 =?utf-8?B?d08wUHRDTURaS2NOVEZJM1F5L0RUWERFclc2dzB0bXd4SWVSeVI5RXZWblor?=
 =?utf-8?B?T3hGdFN4Lzl2aUE0cERBK2NLZldNQmF3ZTk0QWh1WkhhTGdGQ2RraG9ocExR?=
 =?utf-8?B?N29CMldyTS81U1QxalZ6VWw0dXE5blZVM1RyMFoyU3hJczhwanNMaEV0ZWds?=
 =?utf-8?B?T1hVY3JzeURjd2JEMlJmZ29OVlRDZ2NETHpMUlFkenNrMEk5SGRDTkJDYXVs?=
 =?utf-8?B?VFhZd21tT1Z6QnRMOTRVQXViQnpScTdKZlMxd1Q3OGRRWUVpVVJhdWdqZVB1?=
 =?utf-8?B?SnFORFYwdjNHdmt3Z1YvYUtvMFVvMFp1SVA5Y1A4bWJqWGxCcHBNV0pCVzAr?=
 =?utf-8?B?SWNSTGxOQnd0VjFtV1EwUzNmYjlSYkFhM0kwd2RINXRTVmt6c21GdExaK2Qw?=
 =?utf-8?B?UURFa2tMK0Y5b0QxOFVTWHZUeVFzY2F4WmllaEd3WFRXOG1QcEFLVXZUU0NE?=
 =?utf-8?B?dUZnSitGa2NEZkw2U3JHa2hYUnU4dTNyaWZTc041RzhKVFdrUURpZ0o1WnJE?=
 =?utf-8?B?NTdpRDZYeWxsYXYvb2NzUVZWSHpYRmFJbUIwN3RjVXhmcjNrV09sZTR2RllW?=
 =?utf-8?B?QTI5WEUxRFFhZ0NtRnlTTUs5MHNtcEowWWxSSUp2Q3l2eTN1aExwd0VmSTE2?=
 =?utf-8?B?MUR2T0RtK0pDcUpZdnJoSmY0YWtKS1J1Wkhqd3VzLzhzRk5WRGozbDJBSG9w?=
 =?utf-8?B?WGtKc0o0aGxsc3VRSHNvQlIvMlUvWlNFSW5HSUlJMzNIZGx1TVI0S2JlWnVD?=
 =?utf-8?B?ZlVIVlpCdThySmNiNEs3d3E3N3BYSjVSWkUwOEpHN3NPUGJNRUtTOUxvRE1T?=
 =?utf-8?B?MlF6UVp0N0NmTlhBcFptTnBXdDlpdUp6bUtiL1Q1T0NFTmJpd0NSQ2hMNXli?=
 =?utf-8?Q?CnILpHt66FGze4KJb2AhH+WpF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5342772d-8623-46b3-23bf-08dc7151d120
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 00:32:19.4280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnJ0nh3K8cdxbWGG1dT84wp9jJr4fI+I5YNgRR4d+2NA9qAt/rl3E4Wxltt6CoCQDB6IS+ecti5qXYKpVJIPPBbo/c8YWI1ILH61rPmQAkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
X-OriginatorOrg: intel.com

SGkgRGF2aWQsDQoNCj4gDQo+IE9uIDAyLjA1LjI0IDIwOjEwLCBKb2huIEh1YmJhcmQgd3JvdGU6
DQo+ID4gT24gNS8xLzI0IDExOjU2IFBNLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4gPj4g
T24gMDIuMDUuMjQgMDM6MDUsIEFsaXN0YWlyIFBvcHBsZSB3cm90ZToNCj4gPj4+IEphc29uIEd1
bnRob3JwZSA8amdnQG52aWRpYS5jb20+IHdyaXRlczoNCj4gPiAuLi4NCj4gPj4+Pj4gVGhpcyBk
b2Vzbid0IG1ha2Ugc2Vuc2UuwqAgSUZGIGEgYmxpbmQgcmV0cnkgaXMgYWxsIHRoYXQgaXMgbmVl
ZGVkDQo+ID4+Pj4+IGl0IHNob3VsZCBiZSBkb25lIGluIHRoZSBjb3JlIGZ1bmN0aW9uYWxpdHku
wqAgSSBmZWFyIGl0J3Mgbm90IHRoYXQNCj4gPj4+Pj4gZWFzeSwgdGhvdWdoLg0KPiA+Pj4+DQo+
ID4+Pj4gKzENCj4gPj4+Pg0KPiA+Pj4+IFRoaXMgbWlncmF0aW9uIHJldHJ5IHdlaXJkbmVzcyBp
cyBhIEdVUCBpc3N1ZSwgaXQgbmVlZHMgdG8gYmUNCj4gPj4+PiBzb2x2ZWQgaW4gdGhlIG1tIG5v
dCBleHBvc2VkIHRvIGV2ZXJ5IHBpbl91c2VyX3BhZ2VzIGNhbGxlci4NCj4gPj4+Pg0KPiA+Pj4+
IElmIGl0IHR1cm5zIG91dCBaT05FX01PVkVBQkxFIHBhZ2VzIGNhbid0IGFjdHVhbGx5IGJlIHJl
bGlhYmx5DQo+ID4+Pj4gbW92ZWQgdGhlbiBpdCBpcyBwcmV0dHkgYnJva2VuLi4NCj4gPj4+DQo+
ID4+PiBJIHdvbmRlciBpZiB3ZSBzaG91bGQgcmVtb3ZlIHRoZSBhcmJpdHJhcnkgcmV0cnkgbGlt
aXQgaW4NCj4gPj4+IG1pZ3JhdGVfcGFnZXMoKSBlbnRpcmVseSBmb3IgWk9ORV9NT1ZFQUJMRSBw
YWdlcyBhbmQganVzdCBsb29wIHVudGlsDQo+ID4+PiB0aGV5IG1pZ3JhdGU/IEJ5IGRlZmluaXRp
b24gdGhlcmUgc2hvdWxkIG9ubHkgYmUgdHJhbnNpZW50DQo+ID4+PiByZWZlcmVuY2VzIG9uIHRo
ZXNlIHBhZ2VzIHNvIHdoeSBkbyB3ZSBuZWVkIHRvIGxpbWl0IHRoZSBudW1iZXIgb2YNCj4gPj4+
IHJldHJpZXMgaW4gdGhlIGZpcnN0IHBsYWNlPw0KPiA+Pg0KPiA+PiBUaGVyZSBhcmUgc29tZSB3
ZWlyZCB0aGluZ3MgdGhhdCBzdGlsbCBuZWVkcyBmaXhpbmc6IHZtc3BsaWNlKCkgaXMNCj4gPj4g
dGhlIGV4YW1wbGUgdGhhdCBkb2Vzbid0IHVzZSBGT0xMX0xPTkdURVJNLg0KPiA+Pg0KPiA+DQo+
ID4gSGkgRGF2aWQhDQo+ID4NCj4gDQo+IFNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseSENCj4gDQo+
ID4gRG8geW91IGhhdmUgYW55IG90aGVyIGNhbGwgc2l0ZXMgaW4gbWluZD8gSXQgc291bmRzIGxp
a2Ugb25lIHdheQ0KPiA+IGZvcndhcmQgaXMgdG8gZml4IGVhY2ggY2FsbCBzaXRlLi4uDQo+IA0K
PiBXZSBhbHNvIGhhdmUgdWRtYWJ1ZiwgdGhhdCBpcyBjdXJyZW50bHkgZ2V0dGluZyBmaXhlZCBb
MV0gc2ltaWxhcmx5IHRvIGhvdyB3ZQ0KPiBoYW5kbGUgR1VQLiBDb3VsZCB5b3UgYW5kL29yIEph
c29uIGFsc28gaGF2ZSBhIGxvb2sgYXQgdGhlIEdVUC1yZWxhdGVkDQo+IGJpdHM/IEkgYWNrZWQg
aXQgYnV0IHRoZSBwYXRjaCBzZXQgZG9lcyBub3Qgc2VlbSB0byBtYWtlIHByb2dyZXNzLg0KPiAN
Cj4gaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDI0MDQxMTA3MDE1Ny4zMzE4NDI1LTEtdml2
ZWsua2FzaXJlZGR5QGludGVsLmNvbQ0KSSBhbSBob3BpbmcgQW5kcmV3IHdvdWxkIHBpY2sgdGhp
cyBzZXJpZXMgdXAgZm9yIHRoZSB1cGNvbWluZyA2LjEwIGN5Y2xlIGdpdmVuDQp0aGF0IG1vc3Qg
cGF0Y2hlcyBoYXZlIEFja3MgYW5kIEkgd2FzIHBsYW5uaW5nIHRvIG1haW50YWluIHRoZSB1ZG1h
YnVmIGJpdHMuDQoNClRoYW5rcywNClZpdmVrDQoNCj4gDQo+IFRoZSBzYWQgc3RvcnkgaXM6DQo+
IA0KPiAoYSkgdm1zcGxpY2UoKSBpcyBoYXJkZXIgdG8gZml4IChpZGVudGlmeSBhbGwgcHV0X3Bh
Z2UoKSBhbmQgcmVwbGFjZSB0aGVtIGJ5DQo+IHVucGluX3VzZXJfcGFnZSgpKSwgYnV0IHdpbGwg
Z2V0IGZpeGVkIGF0IHNvbWUgcG9pbnQuDQo+IA0KPiAoYikgZXZlbiAhbG9uZ3Rlcm0gRE1BIGNh
biB0YWtlIGRvdWJsZS1kaWdpdCBzZWNvbmRzDQo+IA0KPiAoYykgb3RoZXIgd3JvbmcgY29kZSBp
cyBsaWtlbHkgdG8gZXhpc3Qgb3IgdG8gYXBwZWFyIGFnYWluIGFuZCBpdCdzDQo+ICAgICAgcmF0
aGVyIGhhcmQgdG8gaWRlbnRpZnkrcHJldmVudCByZWxpYWJseQ0KPiANCj4gSU1ITyB3ZSBzaG91
bGQgZXhwZWN0IG1pZ3JhdGlvbiB0byB0YWtlIGEgbG9uZ2VyIHRpbWUgYW5kIG1heWJlIG5ldmVy
DQo+IGhhcHBlbmluZyBpbiBzb21lIGNhc2VzLg0KPiANCj4gTWVtb3J5IG9mZmxpbmluZyAoZS5n
LiwgZWNobyAib2ZmbGluZSIgPg0KPiBzeXMvZGV2aWNlcy9zeXN0ZW0vbWVtb3J5L21lbW9yeTAv
c3RhdGUpIGN1cnJlbnRseSB0cmllcyBmb3JldmVyIHRvDQo+IG1pZ3JhdGUgcGFnZXMgYW5kIGNh
biBiZSBraWxsZWQgaWYgc3RhcnRlZCBmcm9tIHVzZXIgc3BhY2UgdXNpbmcgYSBmYXRhbCBzaWdu
YWwuDQo+IElmIG1lbW9yeSBvZmZsaW5pbmcgaGFwcGVucyBmcm9tIGtlcm5lbCBjb250ZXh0ICh1
bnBsdWdnaW5nIERJTU0sIEFDUEkNCj4gY29kZSB0cmlnZ2VycyBvZmZsaW5pbmcpLCB3ZSdkIG11
Y2ggcmF0aGVyIHdhbnQgdG8gZmFpbCBhdCBzb21lIHBvaW50IGluc3RlYWQNCj4gb2YgbG9vcGlu
ZyBmb3JldmVyLCBidXQgaXQgaGFzbid0IHJlYWxseSBwb3BwZWQgdXAgYXMgYSBwcm9ibGVtIHNv
IGZhci4NCj4gDQo+IHZpcnRpby1tZW0gdXNlcyBhbGxvY19jb250aWdfcmFuZ2UoKSBmb3IgYmVz
dC1lZmZvcnQgYWxsb2NhdGlvbiBhbmQgd2lsbCBza2lwDQo+IHN1Y2ggdGVtcG9yYXJpbHkgdW5t
b3ZhYmxlIHJhbmdlcyB0byB0cnkgYWdhaW4gbGF0ZXIuIEhlcmUsIHdlIHJlYWxseSBkb24ndA0K
PiB3YW50IHRvIGxvb3AgZm9yZXZlciBpbiBtaWdyYXRpb24gY29kZSBidXQgcmF0aGVyIGZhaWwg
ZWFybGllciBhbmQgdHJ5IHVucGx1Zw0KPiBvZiBhbm90aGVyIG1lbW9yeSBibG9jay4NCj4gDQo+
IFNvIGFzIGxvbmcgYXMgcGFnZSBwaW5uaW5nIGlzIHRyaWdnZXJlZCBmcm9tIHVzZXIgY29udGV4
dCB3aGVyZSB0aGUgdXNlciBjYW4NCj4gc2ltcGx5IGFib3J0IHRoZSBwcm9jZXNzIChlLmcuLCBr
aWxsIHRoZSBwcm9jZXNzKSwgc2xlZXArcmV0cnkgb24NCj4gWk9ORV9NT1ZBQkxFICsgTUlHUkFU
RV9DTUEgc291bmRzIHJlYXNvbmFibGUuDQo+IA0KPiA+DQo+ID4gVGhpcyBpcyBhbiB1bmhhcHB5
IHN0b3J5IHJpZ2h0IG5vdzogdGhlIHBpbl91c2VyX3BhZ2VzKigpIEFQSXMgYXJlDQo+ID4gc2ln
bmlmaWNhbnRseSB3b3JzZSB0aGFuIGJlZm9yZSB0aGUgIm1pZ3JhdGUgcGFnZXMgYXdheSBhdXRv
bWF0aWNhbGx5Ig0KPiA+IHVwZ3JhZGUsIGZyb20gYSB1c2VyIHBvaW50IG9mIHZpZXcuIEJlY2F1
c2Ugbm93LCB0aGUgQVBJcyBmYWlsDQo+ID4gaW50ZXJtaXR0ZW50bHkgZm9yIGNhbGxlcnMgd2hv
IGZvbGxvdyB0aGUgcnVsZXMtLWJlY2F1c2UNCj4gPiBwaW5fdXNlcl9wYWdlcygpIGlzIG5vdCBm
dWxseSB3b3JraW5nIHlldCwgYmFzaWNhbGx5Lg0KPiA+DQo+ID4gT3RoZXIgaWRlYXMsIGxhcmdl
IG9yIHNtYWxsLCBhYm91dCBob3cgdG8gYXBwcm9hY2ggYSBmaXg/DQo+IA0KPiBXaGF0IEphc29u
IHNheXMgbWFrZXMgc2Vuc2UgdG8gbWU6IHNsZWVwK3JldHJ5LiBNeSBvbmx5IGNvbmNlcm4gaXMg
d2hlbg0KPiBwaW5fdXNlcl9wYWdlc18qKCkgaXMgY2FsbGVkIGZyb20gbm9uLWtpbGxhYmxlIGNv
bnRleHQgd2hlcmUgZmFpbGluZyBhdCBzb21lDQo+IHBvaW50IG1pZ2h0IGJlIG1vcmUgcmVhc29u
YWJsZS4gQnV0IG1heWJlIHRoYXQgdXNlIGNhc2UgZG9lc24ndCByZWFsbHkNCj4gZXhpc3Q/DQo+
IA0KPiAtLQ0KPiBDaGVlcnMsDQo+IA0KPiBEYXZpZCAvIGRoaWxkZW5iDQoNCg==

