Return-Path: <linux-rdma+bounces-12629-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2B6B1EDA4
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Aug 2025 19:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE7A564258
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Aug 2025 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA0627F728;
	Fri,  8 Aug 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCX3DVaT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71188182D3;
	Fri,  8 Aug 2025 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754672823; cv=fail; b=NVrD3YliIstqK3ScRlnG4JqHlfeWEwFSr9zbRXw2msGCcXpXRRtwmpRxfQ24SxyzpvHpSle6hbkxAcH957G7b2AntTwkHQBjO51KzLJWPB7jHp3JrB6aYqQXZwcbi8yrhSUCevKs+mYHvGImcCopk2qSRP9O7Frei4HP9brVbOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754672823; c=relaxed/simple;
	bh=/uj2oafcj2ZbD1RxzFlls+MFiItgk5fvpjMk3FBiHss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O4F0B3pDRlgeDpSvBcS8RSxyp6/lFWnL1c8zrdOAwPO1PL88+QXjrskjecxET069Cq+JwvwBUZ/bnjtV1Nwep5WoL2IN9qpCHQeTnanixOqPmS95T38sE9Mw9AQlu4I8Rb3XZWq9f3s8v1U7K8SL62zNRd9xH1p0T0lE1FfsLCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCX3DVaT; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754672821; x=1786208821;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/uj2oafcj2ZbD1RxzFlls+MFiItgk5fvpjMk3FBiHss=;
  b=SCX3DVaTI5KV/y72eS/7P5xsmMlVQJ3wku0lXxmgdaU5OmMO5XYQTnEG
   cFNvennbu45DDf7TPrKaDxWG0GXKqdsF/7/K3YZRNTJJXUqqZwaWi/xDX
   mSZJcEKP5BJTuGKA5PAD9IKEDnF4jq9hngP4o2LBRHruBMEWGzdF4oYzw
   tCfuq8NaZ3b0xqsN2f5NM4saCIy3hWATE+TekIVVXhJ2JyfZ+ML1jwmeb
   2U9RRzvufLhqrKY/TdqR5yO+jvSD37LSe2mAvri5K1872HSBmgJRoG25l
   zKvh+BFNyU4+yqocKOj/fgo8BtuQMhuan5ZGoJmao1e+2fbZDnlqJCSii
   g==;
X-CSE-ConnectionGUID: QvF/DykDRTKsAK0ojxLYUg==
X-CSE-MsgGUID: 0I6EMbMARvSShyViUURPqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="60870662"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="60870662"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:07:00 -0700
X-CSE-ConnectionGUID: 7rrv15q7TIWo9uZKk5Z1tQ==
X-CSE-MsgGUID: Xd8P2b/1SJy/KhhRKgGhQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="165744049"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:07:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 10:06:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 10:06:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.59)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 10:06:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHxp36Q7PDagY8S7gUodv2fBYaVCkmyAZgkFnWzpCT1PmYAOK9UpEvKFFV7iXA56zf3kavseqqDPqbqKrEd/oeJ9jdXkefEvrAI4n3YF8IBBBUHeaJTKhc33cxNdXaPOw08hgi9OsuloMuynLY3Z1zqu1mVeTNpTNxzGp9QsjE11pUSFdBtwSlVZNBLePinA8yUEF3TYGQHByCYpMZfjiLlfH5fuKXkOkL8UFLwUlF+39e4UGkQ2A+juvWy9Ii57FmVxBlzMkw7ua8CpkOuTrJOSdK3Pb+Q8FO7dS6pu4mBRBgExzZHvUfXqgDm0nNsBLz5SlNl1Biy7UcM+PkNzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmyafdgCA5wCgEUNuGAJVsL1EOTalL/PAmRIcx3L6oE=;
 b=sb79Hat4ybyIlPnF9bOGUXB1r2tr/NXZTSPpntQ48wwYSSR6ghs7WnNEOn2pTO915ensi2F+J9GA47SWEB5xw199IWBvkzKMDeXAH4mHcXgLGlwBnTkKfIYOkr8P1gYF6e3/1M0N/XAx1JEQ2v8MW2ih4SBIOCwXco+hLO/Ze+f6/hFrl9EFApcx9gaeq5aXsIrZ/abFaRmKolDIfZ6wmWcl1hlKwaVJsspX2tRBdwueJ9x52mK1SbuupAzBsFIc5V6SYiO8hPLV79dqmrm/Z5rgmz0ccA7AclxkFBMnQeQa8LdImT4RRGM5LTFliIx3WLJFJ/VR5aWYmuQHZvW43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 8 Aug
 2025 17:06:57 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 17:06:56 +0000
From: "Hay, Joshua A" <joshua.a.hay@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>, "Nikolova, Tatyana E"
	<tatyana.e.nikolova@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>
Subject: RE: [iwl-next v2 2/6] idpf: implement core RDMA auxiliary dev create,
 init, and destroy
Thread-Topic: [iwl-next v2 2/6] idpf: implement core RDMA auxiliary dev
 create, init, and destroy
Thread-Index: AQHb2+V36p1LiWKqbUK3rjzP0CyrdbRV3DYAgAI7ArA=
Date: Fri, 8 Aug 2025 17:06:52 +0000
Deferred-Delivery: Fri, 8 Aug 2025 17:06:09 +0000
Message-ID: <DM4PR11MB6502BFF373E38654B83E658DD42FA@DM4PR11MB6502.namprd11.prod.outlook.com>
References: <20250612220002.1120-1-tatyana.e.nikolova@intel.com>
 <20250612220002.1120-3-tatyana.e.nikolova@intel.com>
 <aJNEXjmbpTryJiBJ@soc-5CG4396X81.clients.intel.com>
In-Reply-To: <aJNEXjmbpTryJiBJ@soc-5CG4396X81.clients.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6502:EE_|PH7PR11MB6722:EE_
x-ms-office365-filtering-correlation-id: e823c875-3e85-4806-7c1c-08ddd69dfb26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jaiVzxLSSpZA2Qu5MhzerTW2Y8GRwnp3LRlFBnpyexbKpDnm8+kecuvxUqH4?=
 =?us-ascii?Q?xnCGqiAZIwZr11Z9IwQmis8bHoTVeuVNa3eUQv060ThVgTMAtIf/toEjnWKK?=
 =?us-ascii?Q?5mGjdYWA28uZIZeExYdwRaUr33kYvv7oFi7OD4C467/QzENpPJIPzO5FGd+Y?=
 =?us-ascii?Q?s5Jt/G4igRqU7BowA2C6PkazVmtMdSLRq0OEWDfwwG7vSFM6hUM9fEmmb8Ou?=
 =?us-ascii?Q?uayfPRoMLKmm/3IYQVX5uCwuNj8LKzyA7YJBNqVHox0x+bOQahmNEzh6q5Jt?=
 =?us-ascii?Q?vDaAEDc2DD+Gxqq34ok45S47dF6MydPfC1X5IzYK7bnZ6aNrdyk+l27aK0Hr?=
 =?us-ascii?Q?faLCwme9fV+pEirGaBK0L5TfWZA1AmQr4AmXrCP0nobJ2zV8YrSJ7e+sydBr?=
 =?us-ascii?Q?E/1GqBJJnmyFbWvXH1vFRt7RjOmJK93RQ8NbEkYDdqY3Z8Oe0e2TZKsb1KwN?=
 =?us-ascii?Q?ZuOtm6e/fjlLx0y84Vm4SRGG6T39UytdTP16rJeeFukO6t+7rKzD0/px7lvx?=
 =?us-ascii?Q?A3tK6STyzmpSfmS4x2uEq41jZXtGvxrgrwwIhOSVinX4BdA/I7aCCIB3U1ma?=
 =?us-ascii?Q?AXvzIMNhxvsEZsuZHFgJbF2j32Zc9dPdCQZx+qroLiWWTuEUnsqJqOnl2Laz?=
 =?us-ascii?Q?jm8CtHN0DNoenJveelDPjCdkJ+76in9MI/WRarNykgcUvyqsDhbo9Evt4hHT?=
 =?us-ascii?Q?tyZ2EVA7SnfviOGjf8ArVMPYQD3PzRIfyFlUveLwtqi05uOcogoLo6Wge5SI?=
 =?us-ascii?Q?hIv+RUbZa0XcDOytFrR/xU7Sc0m8KO95deiNIc3DNDPPCS25Y6cM/SEl3SB0?=
 =?us-ascii?Q?ZpdsvpeKg3bOVlDAr80zGd3e7ppeKdJ8ryTq/jjJEtQum9fHMKAj78OPKuC/?=
 =?us-ascii?Q?C4MWOn4oGE1RqAuSGBjxxEI7WjG3kpM80RS17rxUtocBVVH86rabk4p34JlY?=
 =?us-ascii?Q?Nj8IxswMP4dc4fQiZBEZh/1Mo+0feRHFvvFBITIWr/M1ZxOgD6ZW09FlksT7?=
 =?us-ascii?Q?BuarwBr98IZ0FD/42I377wR15+irISDsGiqse4dKWl+DO7nW1s3dD3zj8h0j?=
 =?us-ascii?Q?KfWrpnBEKPEo7xm6YZD+zlbwbgFvDbocG1Gz6lhAjFbCUCTp0zHQz2c0sT7p?=
 =?us-ascii?Q?VopeDjS0QENX5rKnO4shNTyl7Ees41WZ5HYWKxPUvWAbzBRbaBZZ9JAK8wiR?=
 =?us-ascii?Q?0OjWSZW0bQ+03hOsC/E3rAqZVy7xlFF244BPGobG42JtiOnMh5jhGw2AUul6?=
 =?us-ascii?Q?2MfRIonT7xU5v3Gk4nvjJg1OR97uBL47DqW8WXP0zEUR+d6KWWeGM2vf1Zhx?=
 =?us-ascii?Q?QhN7S1YdUdPq4e7xLaDRHTdJdOPBbqyuXGhNyV2cxWYIMpj9FBWW6427RPIb?=
 =?us-ascii?Q?NbXjk4v470bPZN4eCXVcFH8EE3YHTvC/6+WLamXcFU4QvdTAw4caQZ8Uy1Ya?=
 =?us-ascii?Q?2/lhIPNcrlRO2GaflVEPubBG6KpzjI14lGtwWThHDYVO6HuiKTnMFdr5Q4IL?=
 =?us-ascii?Q?iz0CHJXXLRq51pA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6502.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3OYpS4Y70DOnFPZSfexxIlcauh42HxMTrrOr8toAxVB7y2CpS0QNpOyd2KJT?=
 =?us-ascii?Q?hZ2BQDk+YbaRvd0nkKeD2qxSIDE4r71PO/i86JjeT+zuZEisYKQ7lV6MRWgC?=
 =?us-ascii?Q?mKHWh0n/InbbZmIBuQrfxf7XT/JYbl7WyvBHkSVm0jShXsvWF2KsH+d6WWAv?=
 =?us-ascii?Q?LOiNoKBu0Kg8+rIQ4FU0UHbuPw3evHOK85FvYUv6lT0sbUs5Z0JU+AegwLR/?=
 =?us-ascii?Q?aa+keu0pDwMhs3oX50cMDHJc07v/q5VJ+QdQzVPJe+LhLdnRab81RSeJ+hlP?=
 =?us-ascii?Q?0O9Kai4bIkGy8Ka7ztnK7DZVpriNjLvdiUBfx6z0FrdeLLr1BPjaKijIX27m?=
 =?us-ascii?Q?QScqPLSkkH6MjjIRpkzF6NyafO9mpRrQsTz1RQ7BnByIJ9j4HhbRiwOnycaU?=
 =?us-ascii?Q?D2VV3TUzeozUi+hi8iKHt705jf3oZBAvjLFCo/NT1PYO2Mb39TKunHA+22UH?=
 =?us-ascii?Q?u1ceylUxQpXPziSOb8gr+TXB5ASyFY92zFCAzAR52tz5vL8WSD2q2hIQNZd+?=
 =?us-ascii?Q?D2oM7MAh2uXzt8FvYCxbyws+7kIzQwYGMDquIjzAZz83fFVlGdkI0UJUJpts?=
 =?us-ascii?Q?1pzpE+V1DMflp/8geG763NPb9YU39T27VUvQURHbJiUqdXCndVzSqO+xPIRe?=
 =?us-ascii?Q?jdbijWEwYr325PcnGaBF4n9gDcvJmmBNH077XJp7NcviMDokZfF+p1oqrIw8?=
 =?us-ascii?Q?9nJ1bZv33hkwVfan1hm4Eu7Ex5VS5wo77d/NXexFt+gtjDqLIdCX/azMs8S9?=
 =?us-ascii?Q?a+Hw4XHPy7cNlQUalGF05HUXDwo10SF+lkqpW7bFzuvSuI9vz7UnyFq9cqty?=
 =?us-ascii?Q?CYukLYeeT2P+POnuSCELjTSvnd2bbFS+HUMXYfWv8eiw4JdrQnebHCO7JYH1?=
 =?us-ascii?Q?v43cml/2SN/zdViD1Kyu/ndP4IPE08OV78EavNyrE7qJIPBCKqoyaLmp54GV?=
 =?us-ascii?Q?gLNqOAdLrRldpX7Nu2/ko9QmQxdnebRrPGvdVxfQWY7MK/VbzENRUmO8nVdv?=
 =?us-ascii?Q?jAxIzdUlJuvBMiBf20GMY6AnBrUsgDaCYVUGTAMSKHGwWidU8GfHwG6QSrIt?=
 =?us-ascii?Q?kzp7i14j9K7HIXEOBt79uo+nAOUjm6HqREhmrcmqlbN95kYKwT5p1YEXRkHy?=
 =?us-ascii?Q?k9ZSprnyYLAwB/i7zM+9LSK45G3kUz+d4rcQOyKvf79AYuoB9a5lFxyU7B5g?=
 =?us-ascii?Q?DlPV0u2/9ZN7KrUGVmxOPnwE3rNjzPGniFhAnUZyIvoHpemCc0RU7Km2vmYS?=
 =?us-ascii?Q?bxytAr9pviXB4TalSgZF33he5BJOPTDBZSCD0bJG9P8PfMiTGYoyZ1KRkBJd?=
 =?us-ascii?Q?GfheXgjzB8W1xxthraX3d4LNHaAvTLZXuqrcb0RltEZQDVx2qIcSjsxUIJ0o?=
 =?us-ascii?Q?4I4l6KIcSgak7fCPUTTBbeTeOtYaHX2k0P0xSb4M87kGR4KDn73p+zi7E6sC?=
 =?us-ascii?Q?WQr+79b2zOjzM0pw4YjiXANa0KK6PwE0G8/sSuG/0oweIKD/lFRE8ATzgIo8?=
 =?us-ascii?Q?uQQ9jtMBPxx9kEZaTmQ+Zzx/pR1ZtpSAxMOMP1GNKe1M+hef3P0xe6Vn1qK4?=
 =?us-ascii?Q?5UVk1kI5XiLjWI5mgUMrGSaKspcgWFgGRZ+62hKh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e823c875-3e85-4806-7c1c-08ddd69dfb26
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 17:06:56.7973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ll+flRCeyDvKvoo2Iz7ZkQ+5+jKOR916zcGMiOteIfg3nbWaarygqFsI+EQez//SIDtYxGvea7GsdF9KAB/Dgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6722
X-OriginatorOrg: intel.com

> Hello,
>=20
> I am developing some changes using the current dev-queue and have noticed
> the
> following KASAN warning when doing rmmod idpf without any of my changes
> on top.

Hi Larysa,

Thanks for finding this. I have a fix and will send it out as soon as it pa=
sses internal review.

Josh=20
>=20
> [  +6.231036]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  +0.000065] BUG: KASAN: slab-use-after-free in
> idpf_idc_deinit_core_aux_device+0xf5/0x110 [idpf]
> [  +0.000059] Read of size 4 at addr ff11001086758ae8 by task rmmod/2025
>=20
> [  +0.000046] CPU: 40 UID: 0 PID: 2025 Comm: rmmod Not tainted 6.16.0-
> korg-netnext-standard+ #30 PREEMPT(full)
> [  +0.000010] Hardware name: Intel Corporation
> M50CYP2SBSTD/M50CYP2SBSTD, BIOS
> SE5C620.86B.01.01.0008.2305172341 05/17/2023
> [  +0.000005] Call Trace:
> [  +0.000003]  <TASK>
> [  +0.000003]  dump_stack_lvl+0x5f/0x80
> [  +0.000016]  print_report+0xd1/0x640
> [  +0.000014]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  +0.000012]  ? kasan_complete_mode_report_info+0x64/0x200
> [  +0.000009]  kasan_report+0xe5/0x120
> [  +0.000007]  ? idpf_idc_deinit_core_aux_device+0xf5/0x110 [idpf]
> [  +0.000017]  ? idpf_idc_deinit_core_aux_device+0xf5/0x110 [idpf]
> [  +0.000016]  __asan_report_load4_noabort+0x18/0x20
> [  +0.000010]  idpf_idc_deinit_core_aux_device+0xf5/0x110 [idpf]
> [  +0.000014]  idpf_vc_core_deinit+0xbf/0x3a0 [idpf]
> [  +0.000019]  idpf_remove+0xb0/0x7f0 [idpf]
> [  +0.000017]  ? __kasan_check_write+0x18/0x20
> [  +0.000009]  pci_device_remove+0xad/0x1d0
> [  +0.000013]  device_remove+0xc4/0x170
> [  +0.000012]  device_release_driver_internal+0x37e/0x540
> [  +0.000011]  driver_detach+0xc7/0x1a0
> [  +0.000008]  bus_remove_driver+0x127/0x2a0
> [  +0.000008]  driver_unregister+0x71/0xa0
> [  +0.000008]  pci_unregister_driver+0x2d/0x250
> [  +0.000009]  idpf_driver_exit+0x14/0xe60 [idpf]
> [  +0.000014]  __do_sys_delete_module.isra.0+0x2b7/0x500
> [  +0.000012]  ? __pfx___do_sys_delete_module.isra.0+0x10/0x10
> [  +0.000011]  __x64_sys_delete_module+0x35/0x50
> [  +0.000008]  x64_sys_call+0x5c3/0x20d0
> [  +0.000011]  do_syscall_64+0x7a/0x320
> [  +0.000008]  ? clear_bhb_loop+0x60/0xb0
> [  +0.000006]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000006] RIP: 0033:0x7f6c41b34abb
> [  +0.000015] Code: 73 01 c3 48 8b 0d 55 13 0c 00 f7 d8 64 89 01 48 83 c8=
 ff
> c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48>=
 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d 25 13 0c 00 f7 d8 64 89 01 48
> [  +0.000006] RSP: 002b:00007ffe4797b118 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000b0
> [  +0.000010] RAX: ffffffffffffffda RBX: 000055cbd564f700 RCX:
> 00007f6c41b34abb
> [  +0.000005] RDX: 0000000000000000 RSI: 0000000000000800 RDI:
> 000055cbd564f768
> [  +0.000004] RBP: 00007ffe4797b140 R08: 1999999999999999 R09:
> 0000000000000000
> [  +0.000005] R10: 00007f6c41ba5ac0 R11: 0000000000000206 R12:
> 0000000000000000
> [  +0.000004] R13: 00007ffe4797b3a0 R14: 000055cbd564f700 R15:
> 0000000000000000
> [  +0.000007]  </TASK>
>=20
> [  +0.008179] Allocated by task 416:
> [  +0.001205]  kasan_save_stack+0x3d/0x60
> [  +0.000021]  kasan_save_track+0x18/0x40
> [  +0.000011]  kasan_save_alloc_info+0x3b/0x50
> [  +0.000013]  __kasan_kmalloc+0xb7/0xc0
> [  +0.000010]  __kmalloc_cache_noprof+0x1ca/0x450
> [  +0.000016]  idpf_idc_init_aux_core_dev+0x4f9/0xc80 [idpf]
> [  +0.000027]  idpf_idc_register+0x14/0x20 [idpf]
> [  +0.000025]  idpf_idc_init+0x5c/0xd0 [idpf]
> [  +0.000025]  idpf_vc_event_task+0x658/0xdd0 [idpf]
> [  +0.000026]  process_one_work+0x67b/0x1030
> [  +0.000014]  worker_thread+0x65b/0xf40
> [  +0.000009]  kthread+0x3a3/0x860
> [  +0.000010]  ret_from_fork+0x24c/0x420
> [  +0.000016]  ret_from_fork_asm+0x1a/0x30
>=20
> [  +0.001183] Freed by task 2025:
> [  +0.001070]  kasan_save_stack+0x3d/0x60
> [  +0.000010]  kasan_save_track+0x18/0x40
> [  +0.000007]  kasan_save_free_info+0x3f/0x60
> [  +0.000008]  __kasan_slab_free+0x56/0x70
> [  +0.000007]  kfree+0x12a/0x3d0
> [  +0.000010]  idpf_core_adev_release+0x12/0x20 [idpf]
> [  +0.000017]  device_release+0xa1/0x220
> [  +0.000010]  kobject_put+0x18e/0x4f0
> [  +0.000013]  put_device+0x17/0x30
> [  +0.000006]  idpf_idc_deinit_core_aux_device+0x54/0x110 [idpf]
> [  +0.000016]  idpf_vc_core_deinit+0xbf/0x3a0 [idpf]
> [  +0.000018]  idpf_remove+0xb0/0x7f0 [idpf]
> [  +0.000017]  pci_device_remove+0xad/0x1d0
> [  +0.000011]  device_remove+0xc4/0x170
> [  +0.000010]  device_release_driver_internal+0x37e/0x540
> [  +0.000009]  driver_detach+0xc7/0x1a0
> [  +0.000007]  bus_remove_driver+0x127/0x2a0
> [  +0.000007]  driver_unregister+0x71/0xa0
> [  +0.000008]  pci_unregister_driver+0x2d/0x250
> [  +0.000008]  idpf_driver_exit+0x14/0xe60 [idpf]
> [  +0.000017]  __do_sys_delete_module.isra.0+0x2b7/0x500
> [  +0.000012]  __x64_sys_delete_module+0x35/0x50
> [  +0.000008]  x64_sys_call+0x5c3/0x20d0
> [  +0.000010]  do_syscall_64+0x7a/0x320
> [  +0.000010]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> [  +0.000749] The buggy address belongs to the object at ff11001086758800
>                which belongs to the cache kmalloc-1k of size 1024
> [  +0.001509] The buggy address is located 744 bytes inside of
>                freed 1024-byte region [ff11001086758800, ff11001086758c00=
)
>=20
> [  +0.002163] The buggy address belongs to the physical page:
> [  +0.000739] page: refcount:0 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x1086758
> [  +0.000010] head: order:3 mapcount:0 entire_mapcount:0
> nr_pages_mapped:0 pincount:0
> [  +0.000006] flags:
> 0x6fffc0000000040(head|node=3D1|zone=3D2|lastcpupid=3D0x3fff)
> [  +0.000009] page_type: f5(slab)
> [  +0.000009] raw: 06fffc0000000040 ff11000100038dc0
> dead000000000122 0000000000000000
> [  +0.000007] raw: 0000000000000000 0000000080100010
> 00000000f5000000 0000000000000000
> [  +0.000006] head: 06fffc0000000040 ff11000100038dc0
> dead000000000122 0000000000000000
> [  +0.000006] head: 0000000000000000 0000000080100010
> 00000000f5000000 0000000000000000
> [  +0.000006] head: 06fffc0000000003 ffd400004219d601 00000000ffffffff
> 00000000ffffffff
> [  +0.000006] head: ffffffffffffffff 0000000000000000 00000000ffffffff
> 0000000000000008
> [  +0.000004] page dumped because: kasan: bad access detected
>=20
> [  +0.000732] Memory state around the buggy address:
> [  +0.000744]  ff11001086758980: fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> [  +0.000764]  ff11001086758a00: fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> [  +0.000750] >ff11001086758a80: fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> [  +0.000735]                                                           ^
> [  +0.000756]  ff11001086758b00: fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> [  +0.000641]  ff11001086758b80: fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> [  +0.000513]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  +0.001104] Disabling lock debugging due to kernel taint
>=20
> >
> > Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> > Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> > ---
> >
> > v2:
> > - initialize cdev_info earlier to properly free it in error path
> >
> > Changes since split (v1):
> > - replace core dev_ops with exported symbols
> > - align with new header split scheme (idc_rdma->iidc_rdma and
> >   iidc_rdma_idpf specific header)
> >
> > [3]:
> > - use signed ret value from ida_alloc and only assign
> >   unsigned id if no err
> > - capitalize some abbreviations
> > - add missing field descriptions
> >
> >  drivers/net/ethernet/intel/idpf/Makefile      |   1 +
> >  drivers/net/ethernet/intel/idpf/idpf.h        |  11 +
> >  drivers/net/ethernet/intel/idpf/idpf_dev.c    |  13 +
> >  drivers/net/ethernet/intel/idpf/idpf_idc.c    | 223 ++++++++++++++++++
> >  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   4 +
> >  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  13 +
> >  .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  20 ++
> >  .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   3 +
> >  include/linux/net/intel/iidc_rdma_idpf.h      |  28 +++
> >  9 files changed, 316 insertions(+)
> >  create mode 100644 drivers/net/ethernet/intel/idpf/idpf_idc.c
> >  create mode 100644 include/linux/net/intel/iidc_rdma_idpf.h
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/Makefile
> b/drivers/net/ethernet/intel/idpf/Makefile
> > index 83ac5e296382..4ef4b2b5e37a 100644
> > --- a/drivers/net/ethernet/intel/idpf/Makefile
> > +++ b/drivers/net/ethernet/intel/idpf/Makefile
> > @@ -10,6 +10,7 @@ idpf-y :=3D \
> >  	idpf_controlq_setup.o	\
> >  	idpf_dev.o		\
> >  	idpf_ethtool.o		\
> > +	idpf_idc.o		\
> >  	idpf_lib.o		\
> >  	idpf_main.o		\
> >  	idpf_txrx.o		\
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> > index d9f06764aba0..6b1cc55e34a3 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf.h
> > +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> > @@ -17,6 +17,8 @@ struct idpf_vport_max_q;
> >  #include <linux/sctp.h>
> >  #include <linux/ethtool_netlink.h>
> >  #include <net/gro.h>
> > +#include <linux/net/intel/iidc_rdma.h>
> > +#include <linux/net/intel/iidc_rdma_idpf.h>
> >
> >  #include "virtchnl2.h"
> >  #include "idpf_txrx.h"
> > @@ -206,9 +208,12 @@ struct idpf_reg_ops {
> >  /**
> >   * struct idpf_dev_ops - Device specific operations
> >   * @reg_ops: Register operations
> > + * @idc_init: IDC initialization
> >   */
> >  struct idpf_dev_ops {
> >  	struct idpf_reg_ops reg_ops;
> > +
> > +	int (*idc_init)(struct idpf_adapter *adapter);
> >  };
> >
> >  /**
> > @@ -540,6 +545,7 @@ struct idpf_vc_xn_manager;
> >   * @caps: Negotiated capabilities with device
> >   * @vcxn_mngr: Virtchnl transaction manager
> >   * @dev_ops: See idpf_dev_ops
> > + * @cdev_info: IDC core device info pointer
> >   * @num_vfs: Number of allocated VFs through sysfs. PF does not direct=
ly
> talk
> >   *	     to VFs but is used to initialize them
> >   * @crc_enable: Enable CRC insertion offload
> > @@ -599,6 +605,7 @@ struct idpf_adapter {
> >  	struct idpf_vc_xn_manager *vcxn_mngr;
> >
> >  	struct idpf_dev_ops dev_ops;
> > +	struct iidc_rdma_core_dev_info *cdev_info;
> >  	int num_vfs;
> >  	bool crc_enable;
> >  	bool req_tx_splitq;
> > @@ -877,5 +884,9 @@ int idpf_sriov_configure(struct pci_dev *pdev, int
> num_vfs);
> >
> >  u8 idpf_vport_get_hsplit(const struct idpf_vport *vport);
> >  bool idpf_vport_set_hsplit(const struct idpf_vport *vport, u8 val);
> > +int idpf_idc_init(struct idpf_adapter *adapter);
> > +int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
> > +			       enum iidc_function_type ftype);
> > +void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info
> *cdev_info);
> >
> >  #endif /* !_IDPF_H_ */
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c
> b/drivers/net/ethernet/intel/idpf/idpf_dev.c
> > index 3fae81f1f988..dd227a4368fb 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
> > @@ -161,6 +161,17 @@ static void idpf_ptp_reg_init(const struct
> idpf_adapter *adapter)
> >  	adapter->ptp->cmd.exec_cmd_mask =3D
> PF_GLTSYN_CMD_SYNC_EXEC_CMD_M;
> >  }
> >
> > +/**
> > + * idpf_idc_register - register for IDC callbacks
> > + * @adapter: Driver specific private structure
> > + *
> > + * Return: 0 on success or error code on failure.
> > + */
> > +static int idpf_idc_register(struct idpf_adapter *adapter)
> > +{
> > +	return idpf_idc_init_aux_core_dev(adapter,
> IIDC_FUNCTION_TYPE_PF);
> > +}
> > +
> >  /**
> >   * idpf_reg_ops_init - Initialize register API function pointers
> >   * @adapter: Driver specific private structure
> > @@ -182,4 +193,6 @@ static void idpf_reg_ops_init(struct idpf_adapter
> *adapter)
> >  void idpf_dev_ops_init(struct idpf_adapter *adapter)
> >  {
> >  	idpf_reg_ops_init(adapter);
> > +
> > +	adapter->dev_ops.idc_init =3D idpf_idc_register;
> >  }
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> > new file mode 100644
> > index 000000000000..5550802a3a7d
> > --- /dev/null
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> > @@ -0,0 +1,223 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (C) 2025 Intel Corporation */
> > +
> > +#include "idpf.h"
> > +#include "idpf_virtchnl.h"
> > +
> > +static DEFINE_IDA(idpf_idc_ida);
> > +
> > +#define IDPF_IDC_MAX_ADEV_NAME_LEN	15
> > +
> > +/**
> > + * idpf_idc_init - Called to initialize IDC
> > + * @adapter: driver private data structure
> > + *
> > + * Return: 0 on success or cap not enabled, error code on failure.
> > + */
> > +int idpf_idc_init(struct idpf_adapter *adapter)
> > +{
> > +	int err;
> > +
> > +	if (!idpf_is_rdma_cap_ena(adapter) ||
> > +	    !adapter->dev_ops.idc_init)
> > +		return 0;
> > +
> > +	err =3D adapter->dev_ops.idc_init(adapter);
> > +	if (err)
> > +		dev_err(&adapter->pdev->dev, "failed to initialize idc: %d\n",
> > +			err);
> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * idpf_core_adev_release - function to be mapped to aux dev's release=
 op
> > + * @dev: pointer to device to free
> > + */
> > +static void idpf_core_adev_release(struct device *dev)
> > +{
> > +	struct iidc_rdma_core_auxiliary_dev *iadev;
> > +
> > +	iadev =3D container_of(dev, struct iidc_rdma_core_auxiliary_dev,
> adev.dev);
> > +	kfree(iadev);
> > +	iadev =3D NULL;
> > +}
> > +
> > +/* idpf_plug_core_aux_dev - allocate and register an Auxiliary device
> > + * @cdev_info: IDC core device info pointer
> > + *
> > + * Return: 0 on success or error code on failure.
> > + */
> > +static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info
> *cdev_info)
> > +{
> > +	struct iidc_rdma_core_auxiliary_dev *iadev;
> > +	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
> > +	struct auxiliary_device *adev;
> > +	int ret;
> > +
> > +	iadev =3D kzalloc(sizeof(*iadev), GFP_KERNEL);
> > +	if (!iadev)
> > +		return -ENOMEM;
> > +
> > +	adev =3D &iadev->adev;
> > +	cdev_info->adev =3D adev;
> > +	iadev->cdev_info =3D cdev_info;
> > +
> > +	ret =3D ida_alloc(&idpf_idc_ida, GFP_KERNEL);
> > +	if (ret < 0) {
> > +		pr_err("failed to allocate unique device ID for Auxiliary
> driver\n");
> > +		goto err_ida_alloc;
> > +	}
> > +	adev->id =3D ret;
> > +	adev->dev.release =3D idpf_core_adev_release;
> > +	adev->dev.parent =3D &cdev_info->pdev->dev;
> > +	sprintf(name, "%04x.rdma.core", cdev_info->pdev->vendor);
> > +	adev->name =3D name;
> > +
> > +	ret =3D auxiliary_device_init(adev);
> > +	if (ret)
> > +		goto err_aux_dev_init;
> > +
> > +	ret =3D auxiliary_device_add(adev);
> > +	if (ret)
> > +		goto err_aux_dev_add;
> > +
> > +	return 0;
> > +
> > +err_aux_dev_add:
> > +	cdev_info->adev =3D NULL;
> > +	auxiliary_device_uninit(adev);
> > +err_aux_dev_init:
> > +	ida_free(&idpf_idc_ida, adev->id);
> > +err_ida_alloc:
> > +	kfree(iadev);
> > +
> > +	return ret;
> > +}
> > +
> > +/* idpf_unplug_aux_dev - unregister and free an Auxiliary device
> > + * @adev: auxiliary device struct
> > + */
> > +static void idpf_unplug_aux_dev(struct auxiliary_device *adev)
> > +{
> > +	auxiliary_device_delete(adev);
> > +	auxiliary_device_uninit(adev);
> > +
> > +	ida_free(&idpf_idc_ida, adev->id);
> > +}
> > +
> > +/**
> > + * idpf_idc_vport_dev_ctrl - Called by an Auxiliary Driver
> > + * @cdev_info: IDC core device info pointer
> > + * @up: RDMA core driver status
> > + *
> > + * This callback function is accessed by an Auxiliary Driver to indica=
te
> > + * whether core driver is ready to support vport driver load or if vpo=
rt
> > + * drivers need to be taken down.
> > + *
> > + * Return: 0 on success or error code on failure.
> > + */
> > +int idpf_idc_vport_dev_ctrl(struct iidc_rdma_core_dev_info *cdev_info,
> bool up)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +EXPORT_SYMBOL_GPL(idpf_idc_vport_dev_ctrl);
> > +
> > +/**
> > + * idpf_idc_request_reset - Called by an Auxiliary Driver
> > + * @cdev_info: IDC core device info pointer
> > + * @reset_type: function, core or other
> > + *
> > + * This callback function is accessed by an Auxiliary Driver to reques=
t a reset
> > + * on the Auxiliary Device.
> > + *
> > + * Return: 0 on success or error code on failure.
> > + */
> > +int idpf_idc_request_reset(struct iidc_rdma_core_dev_info *cdev_info,
> > +			   enum iidc_rdma_reset_type __always_unused
> reset_type)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +EXPORT_SYMBOL_GPL(idpf_idc_request_reset);
> > +
> > +/**
> > + * idpf_idc_init_msix_data - initialize MSIX data for the cdev_info st=
ructure
> > + * @adapter: driver private data structure
> > + */
> > +static void
> > +idpf_idc_init_msix_data(struct idpf_adapter *adapter)
> > +{
> > +	struct iidc_rdma_core_dev_info *cdev_info;
> > +	struct iidc_rdma_priv_dev_info *privd;
> > +
> > +	if (!adapter->rdma_msix_entries)
> > +		return;
> > +
> > +	cdev_info =3D adapter->cdev_info;
> > +	privd =3D cdev_info->iidc_priv;
> > +
> > +	privd->msix_entries =3D adapter->rdma_msix_entries;
> > +	privd->msix_count =3D adapter->num_rdma_msix_entries;
> > +}
> > +
> > +/**
> > + * idpf_idc_init_aux_core_dev - initialize Auxiliary Device(s)
> > + * @adapter: driver private data structure
> > + * @ftype: PF or VF
> > + *
> > + * Return: 0 on success or error code on failure.
> > + */
> > +int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
> > +			       enum iidc_function_type ftype)
> > +{
> > +	struct iidc_rdma_core_dev_info *cdev_info;
> > +	struct iidc_rdma_priv_dev_info *privd;
> > +	int err;
> > +
> > +	adapter->cdev_info =3D kzalloc(sizeof(*cdev_info), GFP_KERNEL);
> > +	if (!adapter->cdev_info)
> > +		return -ENOMEM;
> > +	cdev_info =3D adapter->cdev_info;
> > +
> > +	privd =3D kzalloc(sizeof(*privd), GFP_KERNEL);
> > +	if (!privd) {
> > +		err =3D -ENOMEM;
> > +		goto err_privd_alloc;
> > +	}
> > +
> > +	cdev_info->iidc_priv =3D privd;
> > +	cdev_info->pdev =3D adapter->pdev;
> > +	cdev_info->rdma_protocol =3D IIDC_RDMA_PROTOCOL_ROCEV2;
> > +	privd->ftype =3D ftype;
> > +
> > +	idpf_idc_init_msix_data(adapter);
> > +
> > +	err =3D idpf_plug_core_aux_dev(cdev_info);
> > +	if (err)
> > +		goto err_plug_aux_dev;
> > +
> > +	return 0;
> > +
> > +err_plug_aux_dev:
> > +	kfree(privd);
> > +err_privd_alloc:
> > +	kfree(cdev_info);
> > +	adapter->cdev_info =3D NULL;
> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * idpf_idc_deinit_core_aux_device - de-initialize Auxiliary Device(s)
> > + * @cdev_info: IDC core device info pointer
> > + */
> > +void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info
> *cdev_info)
> > +{
> > +	if (!cdev_info)
> > +		return;
> > +
> > +	idpf_unplug_aux_dev(cdev_info->adev);
> > +
> > +	kfree(cdev_info->iidc_priv);
> > +	kfree(cdev_info);
> > +}
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > index 71d1577ca9e4..2c9fda5783f8 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > @@ -1834,6 +1834,10 @@ static int idpf_init_hard_reset(struct
> idpf_adapter *adapter)
> >  unlock_mutex:
> >  	mutex_unlock(&adapter->vport_ctrl_lock);
> >
> > +	/* Wait until all vports are created to init RDMA CORE AUX */
> > +	if (!err)
> > +		err =3D idpf_idc_init(adapter);
> > +
> >  	return err;
> >  }
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
> b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
> > index aba828abcb17..2f84bd596ae4 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
> > @@ -147,6 +147,17 @@ static void idpf_vf_trigger_reset(struct
> idpf_adapter *adapter,
> >  		idpf_send_mb_msg(adapter, VIRTCHNL2_OP_RESET_VF, 0,
> NULL, 0);
> >  }
> >
> > +/**
> > + * idpf_idc_vf_register - register for IDC callbacks
> > + * @adapter: Driver specific private structure
> > + *
> > + * Return: 0 on success or error code on failure.
> > + */
> > +static int idpf_idc_vf_register(struct idpf_adapter *adapter)
> > +{
> > +	return idpf_idc_init_aux_core_dev(adapter,
> IIDC_FUNCTION_TYPE_VF);
> > +}
> > +
> >  /**
> >   * idpf_vf_reg_ops_init - Initialize register API function pointers
> >   * @adapter: Driver specific private structure
> > @@ -167,4 +178,6 @@ static void idpf_vf_reg_ops_init(struct idpf_adapte=
r
> *adapter)
> >  void idpf_vf_dev_ops_init(struct idpf_adapter *adapter)
> >  {
> >  	idpf_vf_reg_ops_init(adapter);
> > +
> > +	adapter->dev_ops.idc_init =3D idpf_idc_vf_register;
> >  }
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > index 24febaaa8fbb..c6fa4644fd3c 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > @@ -868,6 +868,7 @@ static int idpf_send_get_caps_msg(struct
> idpf_adapter *adapter)
> >
> >  	caps.other_caps =3D
> >  		cpu_to_le64(VIRTCHNL2_CAP_SRIOV			|
> > +			    VIRTCHNL2_CAP_RDMA                  |
> >  			    VIRTCHNL2_CAP_MACFILTER		|
> >  			    VIRTCHNL2_CAP_SPLITQ_QSCHED		|
> >  			    VIRTCHNL2_CAP_PROMISC		|
> > @@ -3070,6 +3071,7 @@ void idpf_vc_core_deinit(struct idpf_adapter
> *adapter)
> >
> >  	idpf_ptp_release(adapter);
> >  	idpf_deinit_task(adapter);
> > +	idpf_idc_deinit_core_aux_device(adapter->cdev_info);
> >  	idpf_intr_rel(adapter);
> >
> >  	if (remove_in_prog)
> > @@ -3728,3 +3730,21 @@ int idpf_set_promiscuous(struct idpf_adapter
> *adapter,
> >
> >  	return reply_sz < 0 ? reply_sz : 0;
> >  }
> > +
> > +/**
> > + * idpf_idc_rdma_vc_send_sync - virtchnl send callback for IDC registe=
red
> drivers
> > + * @cdev_info: IDC core device info pointer
> > + * @send_msg: message to send
> > + * @msg_size: size of message to send
> > + * @recv_msg: message to populate on reception of response
> > + * @recv_len: length of message copied into recv_msg or 0 on error
> > + *
> > + * Return: 0 on success or error code on failure.
> > + */
> > +int idpf_idc_rdma_vc_send_sync(struct iidc_rdma_core_dev_info
> *cdev_info,
> > +			       u8 *send_msg, u16 msg_size,
> > +			       u8 *recv_msg, u16 *recv_len)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +EXPORT_SYMBOL_GPL(idpf_idc_rdma_vc_send_sync);
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> > index 77578206bada..7bae09483aed 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> > @@ -151,5 +151,8 @@ int idpf_send_set_sriov_vfs_msg(struct
> idpf_adapter *adapter, u16 num_vfs);
> >  int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get);
> >  int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get);
> >  void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr);
> > +int idpf_idc_rdma_vc_send_sync(struct iidc_rdma_core_dev_info
> *cdev_info,
> > +			       u8 *send_msg, u16 msg_size,
> > +			       u8 *recv_msg, u16 *recv_len);
> >
> >  #endif /* _IDPF_VIRTCHNL_H_ */
> > diff --git a/include/linux/net/intel/iidc_rdma_idpf.h
> b/include/linux/net/intel/iidc_rdma_idpf.h
> > new file mode 100644
> > index 000000000000..f2fe1844f660
> > --- /dev/null
> > +++ b/include/linux/net/intel/iidc_rdma_idpf.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (C) 2025 Intel Corporation. */
> > +
> > +#ifndef _IIDC_RDMA_IDPF_H_
> > +#define _IIDC_RDMA_IDPF_H_
> > +
> > +#include <linux/auxiliary_bus.h>
> > +
> > +/* struct to be populated by core LAN PCI driver */
> > +enum iidc_function_type {
> > +	IIDC_FUNCTION_TYPE_PF,
> > +	IIDC_FUNCTION_TYPE_VF,
> > +};
> > +
> > +struct iidc_rdma_priv_dev_info {
> > +	struct msix_entry *msix_entries;
> > +	u16 msix_count; /* How many vectors are reserved for this device */
> > +	enum iidc_function_type ftype;
> > +};
> > +
> > +int idpf_idc_vport_dev_ctrl(struct iidc_rdma_core_dev_info *cdev_info,
> bool up);
> > +int idpf_idc_request_reset(struct iidc_rdma_core_dev_info *cdev_info,
> > +			   enum iidc_rdma_reset_type __always_unused
> reset_type);
> > +int idpf_idc_rdma_vc_send_sync(struct iidc_rdma_core_dev_info
> *cdev_info,
> > +			       u8 *send_msg, u16 msg_size,
> > +			       u8 *recv_msg, u16 *recv_len);
> > +
> > +#endif /* _IIDC_RDMA_IDPF_H_ */
> > --
> > 2.31.1
> >
> >

