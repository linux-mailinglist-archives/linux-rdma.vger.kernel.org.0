Return-Path: <linux-rdma+bounces-22836-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jRSXGnQRTWo9ugEAu9opvQ
	(envelope-from <linux-rdma+bounces-22836-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 16:47:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA1771CD0C
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 16:47:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=e5fJy7H2;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22836-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22836-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4759131657A2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567863F39FB;
	Tue,  7 Jul 2026 14:14:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078B3ACA7E;
	Tue,  7 Jul 2026 14:14:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433662; cv=fail; b=pIgKPrE4rmrcNv8ga9n9Yy4ihOKC0WOSu4nw/0UPXwC0TYlviym4m/ZcOxJn6nTmc4I1jscZ6sZO7LLWGejbRcCoku9sKHdpw3jwU0/+kx2JD3qNNcHOcX986+T9nW34gU97854qqZtMHss6UDfzuiup/Xx8S61z21LtWOIqtmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433662; c=relaxed/simple;
	bh=NoxdM6rZ81AVnpGYSyv1PLsiqf7X6exY2Epmrzy3OaA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HzGocvAtOYVceFrKw8kvzQXaoQ+GQ2znt8KQV1tDxZg2gUJ//vtE3ATsi+hM5jpvepdbmhPS3iOMcrVaboc+rv7UHqfh1mIxPZRXmIwHup5TpE0a/KJdizwolOWJt6SHwTpY8kyJ9PfhDqZ7SvOKJ2kyoDrKKRlVKRRFooJaJv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5fJy7H2; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783433660; x=1814969660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NoxdM6rZ81AVnpGYSyv1PLsiqf7X6exY2Epmrzy3OaA=;
  b=e5fJy7H2j6vG2ZK6vJC8IRIBpTtz9hgAb0hslsLDXuFD/Suebm6vBUr+
   L73/MDZ5EjM//wDilJbSCbWQ5XdNY4ScXriWKgl4F9xY63+mdUF3FFmjT
   uMHZYag3ttlom56eizVP8P8yDjjyX7uZhAcR4uUwLMV4pbm+oGPEhoXlG
   p7yZtG5npuA3Jao8Yk9qLAzD3Nl8A/baSOWb9tw4U0rFhGLl9cLPXUJ4f
   6mUEvNke0UqAEz+aaLzik6mw5OlBZd9HKRG3bu0CJI9W5N+fupsCHOqP2
   IMSXLV9UFxTzy5stSc4afR8botXRMVofEv0mRUns0Ctk7wtWOmyn3xM6u
   g==;
X-CSE-ConnectionGUID: DBRbU78NStKdgM6gbDgfPg==
X-CSE-MsgGUID: lj2aP/nZS3GDKo1TAjBFEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="106880346"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="106880346"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 07:14:19 -0700
X-CSE-ConnectionGUID: L5m7y4STTnu11IZN27b4qQ==
X-CSE-MsgGUID: VEH5E6u5TAWFsd21AIQqkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="278373839"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 07:14:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 07:14:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 07:14:18 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 07:14:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StshBXCPlhBz/1kmgH6AZccwCsaCtS1d2F8LhmBpS4e8o8JHFxvVBF36rmcdzG9sEcBaxh+/uEc5BRUZpdGEEHRNeAt7/EoL0bgYorS4VOhVLhHcGAbbro3nuwgKq/+5eQPSaCCSzyWuIyvCWikWmsIRaEr870wHg9GWK5IWCiNY1D1XcrBL7Q8XlU3Hlbzyl4YWMdZYZVfKr+Ntin1tRmxDxeH+d738AB7ncZDE+Tdb+ACxprdS6TeU6GitF1k2+nXTZP0IDldmHJRgIPVvjtnDWFFbRcW3Y8TZOmAP1Jl8HwlhWJLbmg1Mfu10S7gDvqaBKhwbFE7U7ypTSxlSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1YRTR0EBmwJFNh2nqZoMPLDL92evVhUiDEWS7+DqSI=;
 b=aY0XCcBVBAe8rHfF0zOWU+5QXcrqSl2QRKUzNKj4dNWOVZmxug63C5qKf0HegRiQz62zNde1fjURz70lqh7KLcsRwC+M62cw4U6wCV8h7s7eNF6jNswh9LrJjdnZhyBPUtOF08eEnzSbVFYFn06JuUZtY1veeh1sxJ166ThV9eCqHiJP/L7010O3N1DfnDIxt8sPr3LoR6BtVU41OTkdfjG1s52drr2khn0u/mOETmRY/iBM3eCbrOCOu0D8tgAFQu8tu5/U/TEqte6KQ472xPl0kqS162MJeNrTyGtw0sW5VC87wpRDuhosks0gYugtzOQefnXO3/iu5tv+xSp3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ5PPFA0B9CD929.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::84a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 14:14:14 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 14:14:14 +0000
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
Subject: RE: [PATCH net-next 02/15] net/mlx5e: psp: Remove PSP steering
 mutexes
Thread-Topic: [PATCH net-next 02/15] net/mlx5e: psp: Remove PSP steering
 mutexes
Thread-Index: AQHdDhISEKun8QybJkOIxK7TfVPtFLZiGZUw
Date: Tue, 7 Jul 2026 14:14:13 +0000
Message-ID: <IA3PR11MB8986DECFCB21C51BA8A4E96AE5F02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260707130858.969928-1-tariqt@nvidia.com>
 <20260707130858.969928-3-tariqt@nvidia.com>
In-Reply-To: <20260707130858.969928-3-tariqt@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ5PPFA0B9CD929:EE_
x-ms-office365-filtering-correlation-id: 1ae28b4f-fc5c-4216-e94b-08dedc3205ff
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|38070700021|18002099003|22082099003|3023799007|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: cZxFVoNKk9OpluoSSt4Ey0d9K0yzya4Mb66+mrFMPGjRkt8ePb4zhcQD4S+gcLAgWgdJIbdLmFQhgirgrdSA+yAh1LctWQg0niudVt/LAAecxN4l/LIjLqy9btapysumTvrqKmDuT59WovNAUGZ8v+I59lHpPCrMp5iO7jUJthcYAH1aQvBBcss29ixyazg/Z7VbPDgOhMub/NQBxW+ZIcfYRkDEpWijyYITW5EtJKF8gqFjBnrGq4dkVuY5kGjCuFq90CJUbgw+UMUkLsU2v+JEpgzHZeOwL0VElwoK4qe7e/Nd9UbFNfB5oNJQ9UCZeABLf/PalVXbTkde8sdEZir+6cDsm7vz/dcfiAqGOSgBeNv6eQ//gsKgpl3xFJYLiNGAJck5q4V1Neqg3qb9akek171xQzdFZZBKPwRFE7m5B6+ws2du9yU1gBHpxWXWrV3dg19cxFFXjkjSDIcwnB/jgJXu7uBNOvda2464t2fyOGaSk7dW6tVxGXv7wlGhJmOyJMBXfQ8Y+cGCiCooRD2HEZA3HzxFEqhQKxH++zH6/1dlqRDBrLkQb/OJqFodfw8ZfGafGr6OjpCqVGEsgy+c/TWBKUTrAV0cV9Mly6lCgrxzhJZV4xEhSfnyp3SI+/TyPRdhY+GjYYoQxv8TEowuGT4m8JTF0osss2nvA1v3RdaSBBm+p1DK0A8U7jWsQ8b8XEeL/FmXI3uW5/TLeFI+93q8u4ENMIGM+tJZyng=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(38070700021)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zhcR6Bj2sEzCOdai6JEp3vJmk8nQ2tSdDnh9DsLCc4t+wjRYt9UMmVqs0/NN?=
 =?us-ascii?Q?F3r3yfyCp5jE/dHa2rQPbM2yUjQhHeIVEDywsosfL0htM63anlzycfrNXHPk?=
 =?us-ascii?Q?Is8h7k7htnhfnUIIU1fBeVzbIOQf5LL9s8h6me0TOgF5sl6zI1Iq2DOpwpwr?=
 =?us-ascii?Q?41HzVGuyaE0N39MZGRmsPhdq92jB7F4RewqBx5H2NqK3y5mXVfsYxfFprlOI?=
 =?us-ascii?Q?dYFvChq7RYzer1q8Al94L01geRXMVI9VMMHMpM253RGIcnqfGNmZmg16dqhE?=
 =?us-ascii?Q?emNoj6jRAC60/PJhKUzzsy7H5H/KwAjjIlh3Tw3SFtMYkekgftThOy+0p15/?=
 =?us-ascii?Q?2sS8EcJ1vCdX2/9n7ZZ2Y1mqdakhU0BxT7+PtxmzJiqSqVjDwo8R2jtHSl0l?=
 =?us-ascii?Q?xYhsEa4Z4ANCsHiXOl8s2GR9/nk53JO/guFthMjUYIo13eq5FviMe5V7JhfO?=
 =?us-ascii?Q?a+u5R6irOUxLlt0nhVJxJcusWqelr6ZqIdiMb88ekuZNAVbT6py+YqV5LuOV?=
 =?us-ascii?Q?PjZChG8oJMrYQBJFdie4bb4aiF2r25dtrFc6PxlrftwsRKk31gl1/cjb/r/Z?=
 =?us-ascii?Q?hO3DFpD1my5j3R5qfaWSAsF9oQHQXWRJMALZCRT9Gr6D1xr4Syqcc3iVbKaZ?=
 =?us-ascii?Q?tTNrAdSqzZWeQbT3hiZSZTZzNNvZb+FpKjdhbsQ2lkZQenwOUK+rrXUf3ZLJ?=
 =?us-ascii?Q?OmL6SM1OfqdUNe1BNUy+MNZmwt7HsPFMyWo7uJNvPP3wLcjRuGw2n0WodQ9m?=
 =?us-ascii?Q?teHq2DVh0+rq9ifTmKKJe9b/8vvxM4n5i+0G1qmAJCbHJS/BtVnZumGnA9nT?=
 =?us-ascii?Q?un5G+yMCrzYg9qEymLz1IzmndmWbOmzuCwpgqi4MPoWn7vPhPr25syVkqObL?=
 =?us-ascii?Q?URHvf0NwjVu0MODVw7A1AiOIp4wQ1klG8ev/flDTmHCDqmtmRrvmq1y115ci?=
 =?us-ascii?Q?ig+2F2k+OEk9WDIolnLUOSjQQ85oPa7Td0xmFlNZgNDBpQaw7EXMCyYVhatU?=
 =?us-ascii?Q?Um3bS7pT6TaoGzCmywUCsWABmEyObSONkBKHKLOfahmOZoLPztkiNj1DW69/?=
 =?us-ascii?Q?1n5nkrhIUgX9fnFZM/aXV8h3dJt8CPFrtHIZuRorWzsqVPbBHwzUJBjXuUP4?=
 =?us-ascii?Q?Z+n/IomfO3PjygIfxicSedYiWs9F5JOR4PAd22lXuX++jOF+6iH5gU8KgMvy?=
 =?us-ascii?Q?yoCZ4M7MO6WGTjsFk2/BkCLhDuWQJn2c6F7ZuZVjt6H9PL2IaoC1I+iIY61m?=
 =?us-ascii?Q?f7WY1SFDdGqYX/dQvLUgHXN+lqmqeDWvFzYT83E9yVqrKxlJ+iTpJT3JjyQ7?=
 =?us-ascii?Q?vhwUQnxFCYQ4L9YgAfD1RtEqjvsSCzjQVikxOQIl+EZBAVJBOWH++IRSowF6?=
 =?us-ascii?Q?oyHKxXxoNL8QSTrqhORdzH6M+iLs3Sh8wyN0UXd/iFtjTjPTLah2oCP/N+lL?=
 =?us-ascii?Q?uk/7refNnVE5kKnmNlW3F+oRNMnfEmYjZGTpvno967x0piBIB3LaKSZUfbuk?=
 =?us-ascii?Q?n/VHW/Zm6ym48l2f7zUmY07uZaeqfnU1LtI7svf82lSpep6BUMhPELnLP/rb?=
 =?us-ascii?Q?8rhAyC9654KY1ozhfm+XKZzzW6kh1vJ5u+bfDQHxHmNEMws3G4UgUY22dKzo?=
 =?us-ascii?Q?aGkI9t6YQ0JWTuV1R8lmX1hdZVNub9ns1FYSkq9I8SAwVggIZcurXqz/OvDO?=
 =?us-ascii?Q?K1vrln0vT3cYyYApPfZDzGIByxL6ZyUDjqRi3RX6Kd4GuL/AzKnTexL7m6Fi?=
 =?us-ascii?Q?6JlgDTsuh1YEbaKRp26kHbo2ay7puOs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P7Pj7hPU0lIpswu01oFRhplbkhp+RGPxa/TTxwe/SHcduK9hUHrlkcQEk1FLtFXSAX6O0BD4Y/aLWz7dhVXqBqDNiOK4/xfv3/LqoOcA4sJjsBXcEt3G9cpEtzJEjCP2VxEsh9oe2JE5H/nBAAwIzyFT3oe/4BQK0NBlVKb/FnWKCvOaQQQC+6TH3oNVRH+Jly1FliukjRFxODGn7jd3InqFHIsVIRj1k6znsh40U1/oJ9uWYVeU0yCNUcYS4+9Fjtk6NZc5tOSWMLA3W8yKHKHwmhHcad/1PQeOiXR4ZVeuZQXtjl5zoom36LzfawQZZRF7PMp/4FAJYC2UDEJiTw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae28b4f-fc5c-4216-e94b-08dedc3205ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 14:14:14.0059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sI8cysZtZ32SoDBeKYKnfoNM47d3ZkxfSPfxtokcG/U7ZoQlRtLNq5CeYnHXsazzNZAgXK04A3kaLnnzTPGm2b+VElEsmaLfNVehfyTXfhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA0B9CD929
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22836-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFA1771CD0C



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
> Subject: [PATCH net-next 02/15] net/mlx5e: psp: Remove PSP steering
> mutexes
>=20
> From: Cosmin Ratiu <cratiu@nvidia.com>
>=20
> PSP steering uses three mutexes to serialize steering rule
> init/cleanup.
> But init/cleanup are already serialized with the higher level devlink
> lock (for both device init and esw mode changes), so there's no need
> for multiple additional mutexes.
>=20
> Remove them to make room for the new changes.
> Later in the series, the netdev lock will be used to serialize PSP
> steering changes from multiple sources, so don't bother adding
> assertions now only for them to be overwritten later.
>=20
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../mellanox/mlx5/core/en_accel/psp.c         | 43 +++---------------
> -
>  1 file changed, 7 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
> b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
> index 4f2fa6756b82..d4686b5af776 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
> @@ -26,7 +26,6 @@ struct mlx5e_psp_tx {
>  	struct mlx5_flow_table *ft;
>  	struct mlx5_flow_group *fg;
>  	struct mlx5_flow_handle *rule;
> -	struct mutex mutex; /* Protect PSP TX steering */
>  	u32 refcnt;
>  	struct mlx5_fc *tx_counter;
>  };
> @@ -48,7 +47,6 @@ struct mlx5e_accel_fs_psp_prot {
>  	struct mlx5_flow_destination default_dest;
>  	struct mlx5e_psp_rx_err rx_err;
>  	u32 refcnt;
> -	struct mutex prot_mutex; /* protect ESP4/ESP6 protocol */
>  	struct mlx5_flow_handle *def_rule;
>  };
>=20
> @@ -485,15 +483,14 @@ static int accel_psp_fs_rx_ft_get(struct
> mlx5e_psp_fs *fs, enum accel_fs_psp_typ
>  	ttc =3D mlx5e_fs_get_ttc(fs->fs, false);
>  	accel_psp =3D fs->rx_fs;
>  	fs_prot =3D &accel_psp->fs_prot[type];
> -	mutex_lock(&fs_prot->prot_mutex);
>  	if (fs_prot->refcnt++)
> -		goto out;
> +		return 0;
>=20
>  	/* create FT */
>  	err =3D accel_psp_fs_rx_create(fs, type);
>  	if (err) {
>  		fs_prot->refcnt--;
> -		goto out;
> +		return err;
>  	}
>=20
>  	/* connect */
> @@ -501,9 +498,7 @@ static int accel_psp_fs_rx_ft_get(struct
> mlx5e_psp_fs *fs, enum accel_fs_psp_typ
>  	dest.ft =3D fs_prot->ft;
>  	mlx5_ttc_fwd_dest(ttc, fs_psp2tt(type), &dest);
>=20
> -out:
> -	mutex_unlock(&fs_prot->prot_mutex);
> -	return err;
> +	return 0;
>  }
>=20
>  static void accel_psp_fs_rx_ft_put(struct mlx5e_psp_fs *fs, enum
> accel_fs_psp_type type) @@ -514,18 +509,14 @@ static void
> accel_psp_fs_rx_ft_put(struct mlx5e_psp_fs *fs, enum accel_fs_psp_ty
>=20
>  	accel_psp =3D fs->rx_fs;
>  	fs_prot =3D &accel_psp->fs_prot[type];
> -	mutex_lock(&fs_prot->prot_mutex);
>  	if (--fs_prot->refcnt)
> -		goto out;
> +		return;
>=20
>  	/* disconnect */
>  	mlx5_ttc_fwd_default_dest(ttc, fs_psp2tt(type));
>=20
>  	/* remove FT */
>  	accel_psp_fs_rx_destroy(fs, type);
> -
> -out:
> -	mutex_unlock(&fs_prot->prot_mutex);
>  }
>=20
>  static void accel_psp_fs_cleanup_rx(struct mlx5e_psp_fs *fs) @@ -
> 544,7 +535,6 @@ static void accel_psp_fs_cleanup_rx(struct
> mlx5e_psp_fs *fs)
>  	mlx5_fc_destroy(fs->mdev, accel_psp->rx_counter);
>  	for (i =3D 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
>  		fs_prot =3D &accel_psp->fs_prot[i];
> -		mutex_destroy(&fs_prot->prot_mutex);
>  		WARN_ON(fs_prot->refcnt);
>  	}
>  	kfree(fs->rx_fs);
> @@ -553,22 +543,15 @@ static void accel_psp_fs_cleanup_rx(struct
> mlx5e_psp_fs *fs)
>=20
>  static int accel_psp_fs_init_rx(struct mlx5e_psp_fs *fs)  {
> -	struct mlx5e_accel_fs_psp_prot *fs_prot;
>  	struct mlx5e_accel_fs_psp *accel_psp;
>  	struct mlx5_core_dev *mdev =3D fs->mdev;
>  	struct mlx5_fc *flow_counter;
> -	enum accel_fs_psp_type i;
>  	int err;
>=20
>  	accel_psp =3D kzalloc_obj(*accel_psp);
>  	if (!accel_psp)
>  		return -ENOMEM;
>=20
> -	for (i =3D 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
> -		fs_prot =3D &accel_psp->fs_prot[i];
> -		mutex_init(&fs_prot->prot_mutex);
> -	}
> -
>  	flow_counter =3D mlx5_fc_create(mdev, false);
>  	if (IS_ERR(flow_counter)) {
>  		mlx5_core_warn(mdev,
> @@ -623,10 +606,6 @@ static int accel_psp_fs_init_rx(struct
> mlx5e_psp_fs *fs)
>  	mlx5_fc_destroy(mdev, accel_psp->rx_counter);
>  	accel_psp->rx_counter =3D NULL;
>  out_err:
> -	for (i =3D 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
> -		fs_prot =3D &accel_psp->fs_prot[i];
> -		mutex_destroy(&fs_prot->prot_mutex);
> -	}
>  	kfree(accel_psp);
>  	fs->rx_fs =3D NULL;
>=20
> @@ -763,17 +742,14 @@ static void accel_psp_fs_tx_destroy(struct
> mlx5e_psp_tx *tx_fs)  static int accel_psp_fs_tx_ft_get(struct
> mlx5e_psp_fs *fs)  {
>  	struct mlx5e_psp_tx *tx_fs =3D fs->tx_fs;
> -	int err =3D 0;
> +	int err;
>=20
> -	mutex_lock(&tx_fs->mutex);
>  	if (tx_fs->refcnt++)
> -		goto out;
> +		return 0;
>=20
>  	err =3D accel_psp_fs_tx_create_ft_table(fs);
>  	if (err)
>  		tx_fs->refcnt--;
> -out:
> -	mutex_unlock(&tx_fs->mutex);
>  	return err;
>  }
>=20
> @@ -781,13 +757,10 @@ static void accel_psp_fs_tx_ft_put(struct
> mlx5e_psp_fs *fs)  {
>  	struct mlx5e_psp_tx *tx_fs =3D fs->tx_fs;
>=20
> -	mutex_lock(&tx_fs->mutex);
>  	if (--tx_fs->refcnt)
> -		goto out;
> +		return;
>=20
>  	accel_psp_fs_tx_destroy(tx_fs);
> -out:
> -	mutex_unlock(&tx_fs->mutex);
>  }
>=20
>  static void accel_psp_fs_cleanup_tx(struct mlx5e_psp_fs *fs) @@ -
> 798,7 +771,6 @@ static void accel_psp_fs_cleanup_tx(struct
> mlx5e_psp_fs *fs)
>  		return;
>=20
>  	mlx5_fc_destroy(fs->mdev, tx_fs->tx_counter);
> -	mutex_destroy(&tx_fs->mutex);
>  	WARN_ON(tx_fs->refcnt);
>  	kfree(tx_fs);
>  	fs->tx_fs =3D NULL;
> @@ -828,7 +800,6 @@ static int accel_psp_fs_init_tx(struct
> mlx5e_psp_fs *fs)
>  		return PTR_ERR(flow_counter);
>  	}
>  	tx_fs->tx_counter =3D flow_counter;
> -	mutex_init(&tx_fs->mutex);
>  	tx_fs->ns =3D ns;
>  	fs->tx_fs =3D tx_fs;
>  	return 0;
> --
> 2.44.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

