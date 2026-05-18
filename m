Return-Path: <linux-rdma+bounces-20889-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDk1NzHYCmqc8gQAu9opvQ
	(envelope-from <linux-rdma+bounces-20889-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:13:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E352456973B
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4337D3001196
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21C03E3DB6;
	Mon, 18 May 2026 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvHObEX8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943003E3169;
	Mon, 18 May 2026 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095164; cv=fail; b=aH9Ha9EBja1vz1jyLuY4RhHRCi9X72p2otqrvwcq+KEtku/GAaYXcdumOVHA0sf0jaNKwCDeIzTD3nYm4xbSbZr70ftLe4W/FuhCjtBV3bj5w5dt9EjeJJIzvI+tZPsCm7mbODjUuZp5MSoPeUD8Jv6GYjXFM9McglVi80hELz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095164; c=relaxed/simple;
	bh=qZ3cUZ5rbx2a8gWkw6Q3qSuDbAqAEjnH4Ek0hH+sRqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ExpZYlx4fGB+KozXs8T8iphCR1w6hM7hs/GapepibEJVZViR/VMdvERd0ao9+0CMTB2SnTqAbjBfHbNSAqGS4PoLVp9f3Ohd9TBD9MUVyosZd8ErHX/FJ+Fi384GFJmBmySLW/z/z6YTA47vuUenZ4U6/xEw1y5q99DJD7eYFus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvHObEX8; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779095162; x=1810631162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qZ3cUZ5rbx2a8gWkw6Q3qSuDbAqAEjnH4Ek0hH+sRqI=;
  b=RvHObEX8MZFeLhhlecPgN/QqCA7B3wERMoMfwh8TlVujTGGvfZ3vbCfR
   MTEvwGCeo8rEm7lhdbXLYGlZhb0K8inUYY8oXZUou6RvMyfbaW5chK86R
   zJU+Gac2pnZfDa32v0y1HLSilGgyU57RmU1yGe+App9w2DpbtVDFpcPI7
   Gr9/BtMW7YzhS+Q9juWHLxfXHVLKUtcFOxQl/vZhN/ePeP6p14qLJRpWY
   npqF3e+QJPqSVy47YEamcGqHySLQyOkT/mhCDLTnpmb/yljZzuGkHFIZR
   oQD/06L/nNcCFV9k9F37DYljZu8E4BRQwQ89/82Y+fyMEw+ONO0fFFb+J
   A==;
X-CSE-ConnectionGUID: Jv4uhhaqRiijpieDhA5jwg==
X-CSE-MsgGUID: m0m2kEYESRSr1kh9UOkxGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="91334287"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="91334287"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 02:06:01 -0700
X-CSE-ConnectionGUID: 5GqGIBx3TneBH6+4h0aUOg==
X-CSE-MsgGUID: 7cpdV2ZnToWYQc8tXbPKHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="239449748"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 02:06:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 02:06:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 02:06:01 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 02:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLJ4yyaJSF7VtazKylzTgSp5rjOq8xydBk9sHzLo9qOa2WvLmQy/jOOMmbk6YxXVxlrnnQKw+h9JfBv3pRqOEjT3PDSnl1Ju9B6FbdokrMGkc35CLMddKBg1UusvbSglzBqutwAMpVzNQ8bwOMwgm+uK4FWXk4/FppIgl0QDxhkNwtILMUGsCVMCki0iZCIT2NG2mFHRoEDo9AO11C2tTtCqM1HG0CAZtsF5fr1zqbrWjhg1WbW1ZVO2iGKLMSmqlub0+LLsD0EOboxx/KKhTJUjxu5VAzBrA4ZFmdsF0XCSWoxX3FwJXlDJeGajd4BcS/6myGG0cJRF71fDo6eZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDOWd3A6VXxQzaTToh2940CSb0h8zuc8/U1rhBqPEWg=;
 b=TbvzoWPTqvGnCYRoFcDO6iKJWSPSwyv61Njwws91zMJeRcJ45ho0brAzxIB5KNg7ATXS9gsopUAQVYZJUUPQ82df99V0tqYRZYQrwAnlXZMq9v4mz7V/QjC0gx2AlFddfm25USD9jBFoTyxYHM24SpI3QaHZuyHs5vXyHu4vqwQhm6kZgierXAC97tttHwUVZ2wHfWuwqXxzohzXmMVRE7ZnAcCbK42N2e9/826Y5cZkHEKVlPoGDuHto99WWLXERf8X2KNHOiei1ktQdnUVgLy9c4Ch+kRT230nTUeo6bk7NkA+FrldE7uNFrnaQV5dJTQLPduDcl2iImbOvmCeFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW4PR11MB6934.namprd11.prod.outlook.com (2603:10b6:303:229::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Mon, 18 May
 2026 09:05:52 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 09:05:52 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Vlad Dumitrescu <vdumitrescu@nvidia.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, David Ahern <dsahern@kernel.org>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Nikolay Aleksandrov
	<nikolay@nvidia.com>
Subject: RE: [PATCH net-next 2/2] net/mlx5: implement max_sfs parameter
Thread-Topic: [PATCH net-next 2/2] net/mlx5: implement max_sfs parameter
Thread-Index: AQHc5fAyHVenqgoAmk22MlC9qPQf0LYTfs9A
Date: Mon, 18 May 2026 09:05:52 +0000
Message-ID: <IA3PR11MB8986745A7DF8DFE5EDE7D6F5E5032@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260517112700.343575-1-tariqt@nvidia.com>
 <20260517112700.343575-3-tariqt@nvidia.com>
In-Reply-To: <20260517112700.343575-3-tariqt@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW4PR11MB6934:EE_
x-ms-office365-filtering-correlation-id: 310d8999-82ea-48b1-940e-08deb4bca97a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|18002099003|22082099003|56012099003|11063799003|3023799003|4143699003;
x-microsoft-antispam-message-info: mNoAWw7g8ydoLeM14qLZnUky07XjX1HkPVUK62SIoZU2PRFjfVq2qLuIvZPK41QglPQ8fjv3MgCq/N9G61sz0xNaBjqdUh1YuX3MKwVnU6x0vfymgeJmJgPLCC4ABkYzc68KGdZRKjmU68BKnF/+To6aeK1DA9ulQRi8uBtYnSzbI7FHgZ3nzFQIpqNGfELeh7/ZYeuAT/gpp7dn4O9dU/xkoUNLPq0nM1grAQ5f98pJPwyT2Lss2iSN97xk1MCGVPa7TLihqkr/Yjs/VcRnJgkS4S1de6H35lPX+fqY93VcBgc33FfWv3j77wNuQxVGz9iNtvFV50lAY0Yum8f8W+nDoE08BccigrzwhiaQJ/7wF6mbZPY4sERSUVNmNCfHM8lM1HcxtyOOhqEQS/XjgJBASy1zVsSntXZthueHZRlvY+Hgktmqacbc4+OjeX4uaOPp+xgQN5p29fguN7oWuipJKxZCQMDxvEP7AStvFj+tq4z9Ttt2WMwWFalP16cDUTuxcWwYQWBZzpDbWdG9gV5hKu8MmHtAf0L745espS32Yd55Rl45RKU9Tv/hbcr0soipQ3ucmgym+xuOenLjwqzGH9iZvGuhJ+yhXSy86xtX2RvIJ1ggVvHbp9WeV7m35C/gWZdXu7cDv7HE9cV6kusg8SYHmYOHBIpllqVRIvYjsSYBr+P5qNTRZidDylZZrxW0Hi79QcF8OyjEBNfXtsLYHTfqhw19Gp/xEQ20ufrry1viIzFRFRWPeF4NskgT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003)(11063799003)(3023799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XO2kCKoOf039Z9t5uI5QZj9VKTqFik3/3CTKZ9XWimoW3DLvKqzu/hIW4cWM?=
 =?us-ascii?Q?cj8iAaHkxZeF6UNOGEU8B9xR48yEjrzCIbNPFWUr3oKOZt3YAu3tYQ5LFKeC?=
 =?us-ascii?Q?nYI+o8SaDQgLmvBiwTbjVUScolkkPxr+aOjb/do8rKvIAZnY/Pnj4PIVNUXM?=
 =?us-ascii?Q?TwohLZbdN5KSTsiAQtwZR51vT8+I3IgNmlVynPCzl6wrrvvCJyBOHjVi2SJk?=
 =?us-ascii?Q?V7uppM1PJvwcj2ZF6h0gD3vnYHsLzd9H2UkoCTpR8mXQPsJk9mSbg/K8MrvK?=
 =?us-ascii?Q?Jtmy8hqhNwwxV3SpcgEff1Xpu1XeLKanctA7nmKR+9auCgHfXXtEoEbdKGnd?=
 =?us-ascii?Q?8XxCqelj2/82FvnEc+fnXNRPI2d3NcwWPt9VU6uuliXa790aJcYDkPU0lcgK?=
 =?us-ascii?Q?qnkxoDaDnoCgwMd2P1QAykD51l1Knt/ldP/EkxPqKeWlKpt5urptvCKcQC6y?=
 =?us-ascii?Q?h6hA6+VGfLzoCYtBKRpZto1SViLjutzmNEuIrOrYnho42sMPCtbBE/RSRPxh?=
 =?us-ascii?Q?4TB7nH/WhUwWn5uxdIxjZgcJlyfMwR8fAfil9uTH/BctBY/gBNfioynpo479?=
 =?us-ascii?Q?EYBuhS8SbPsceyBEy2Pw3FBtzEhe688uFe+/OddbGrcCewNM1RBi9QcYUjMj?=
 =?us-ascii?Q?p5Gyb3jMLLmCMx+c/YG3R0EHvaRsGzWCjQxDYjbBqNbQKiSim//kVu0ZcOc6?=
 =?us-ascii?Q?Jr0gHv0eC2qj479LzP0fXHp+n8/YaidNnqa93PFPJ8ZFRIhtsR73UzD6CaBk?=
 =?us-ascii?Q?4WMR4mC7XIl5RkJQJ2Hlhf+k9vaRX6MMtZHsYfdjsBcQmKNvdYkg+EZjKUlP?=
 =?us-ascii?Q?OD6O5ia2FybhypE2HDlC2CNwvN0cDufxnRsl1r1Xw4shx/IjMawse25qqdFl?=
 =?us-ascii?Q?tdvEdQm5oVGaIDjA0urLSyjnv5ZQGZO1VTT8g+UKP/rcDgUBpY642YkJzq9T?=
 =?us-ascii?Q?2GSLcbe8nUY0Mo1q5BaeqaqVrfWZ92iD5QyL/G8EFN0INC6yntxOJhOwanlS?=
 =?us-ascii?Q?EiTdA2akKandqmRxnbwn7q9n1UHwM5rCgNhKMFWDa6/8zYmZiK77TmuSCBvh?=
 =?us-ascii?Q?vp7DQBdBtsGcxHzD5WQYkGU4mqGNkkdLaaik5S8hzE08NQEcu0KL/b4nwWT5?=
 =?us-ascii?Q?BY2L/T/W1UU3h0vOXsE+g3KUp7XEdo9sY28fx6fztN+yruypyu7jJQBopj8g?=
 =?us-ascii?Q?ovmjwefOtSOyFrqXxDTBELeN5gj/2uR4APKcsuQN6pIWuV/L85j5I2pTPHeR?=
 =?us-ascii?Q?+zG+bMbm+Ivpyta8ZDtfJryVDIXRyt0jxYZTqd4cqj8w7LaiRgk8uEC+vPn8?=
 =?us-ascii?Q?GWHeUh2VTqGL3aDiDJAoEfSYybOReFVcbt+dK0EUP5NmV6Xf0bW9DVfaJi1Q?=
 =?us-ascii?Q?yKxKb5u2cDDj7oQDHNTF/BkSjDTG3/JapMzGL/fUhsUdmt6Hi8/vWunun1Ep?=
 =?us-ascii?Q?ufxJ5PxJ69uDOQx0SdyaXZx3e7tx8x3E7h+6lPjPt2kYtkSjLT1GHR3zW4Tc?=
 =?us-ascii?Q?PhMAJxln8ZQrcJIRYzcJcyyQ4ZD2r/3+wF+3eRC62y6VJ2QUytvJWGRxSGW1?=
 =?us-ascii?Q?r7lnehWRGeDF+T+Gyw07jegOjBbEaGEV5GfkAHiTT0v4u5iK97kh+sgeKy2H?=
 =?us-ascii?Q?5Qle0my8OAPunuFHbhb/jv8O9sRQqsrHKlsudK12RQXUoir4x756kP2eX16N?=
 =?us-ascii?Q?t2kST4OvFRYfLRgiYqyHylM/A7Qlgz4RQUtj7DJHctVAGjcxRRZposlJ+Oi4?=
 =?us-ascii?Q?413CjFkM+atyrBd49sJhm4GwlYJpz/Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SH/w9CkSgvmqwX+D2ofSlYtAVb60XvlOzv51ohrEkbE0XBsHyqKVSZa/y1O3775ShEUs5w7b4TqL36u7cW32/kNuZCdUvbDzYEbSVyTRcxZbCSakMKEqM5rlgUTaTShrpPw2Vn8UyWgtHT4SN7Bsz2wDR3wkZETiZBFxtPqxLPqYUE54GYmZzTardiRmMs+gZQkq4qlrg40gl0CptRZP3s3rGM4ebvqA4/myod4dFYokEUTuLQQhr0vzHwCFL5KR3T0auhQhvUFSdbNGqDr5FJ9z5Lz/sEcvBpIJdH/ltZTRBPOcVBakIAuWf4UN/P2l7L6f2sJ5F+VOXkodSuP2KQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310d8999-82ea-48b1-940e-08deb4bca97a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 09:05:52.3127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSBbvlk08e/VeAJPmChIh6HmQKiYiqY4UA5u93pqQvfpE5kzscGn7d/macEX80o+enBZiXKv09NqY/QKH57Fo7vVaABTc/lgdHvThsKr2/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6934
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: E352456973B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20889-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[resnulli.us,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,gmail.com,blackwall.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Tariq Toukan <tariqt@nvidia.com>
> Sent: Sunday, May 17, 2026 1:27 PM
> To: Eric Dumazet <edumazet@google.com>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>
> Cc: Jiri Pirko <jiri@resnulli.us>; Simon Horman <horms@kernel.org>;
> Jonathan Corbet <corbet@lwn.net>; Shuah Khan
> <skhan@linuxfoundation.org>; Saeed Mahameed <saeedm@nvidia.com>; Leon
> Romanovsky <leon@kernel.org>; Tariq Toukan <tariqt@nvidia.com>; Mark
> Bloch <mbloch@nvidia.com>; Vlad Dumitrescu <vdumitrescu@nvidia.com>;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Daniel Zahka
> <daniel.zahka@gmail.com>; David Ahern <dsahern@kernel.org>; Nikolay
> Aleksandrov <razor@blackwall.org>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Gal Pressman <gal@nvidia.com>; Dragos Tatulea
> <dtatulea@nvidia.com>; Jiri Pirko <jiri@nvidia.com>; Nikolay
> Aleksandrov <nikolay@nvidia.com>
> Subject: [PATCH net-next 2/2] net/mlx5: implement max_sfs parameter
>=20
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
>=20
> Implement max_sfs generic parameter to allow users to control the
> total light-weight NIC subfunctions that can be created using devlink
> instead of external vendor tools. A value of 0 will effectively
> disable creation of new subfunction devices. A warning is sent to
> user-space via extack (returning extack without error code is
> interpreted as a warning by user-space tools).
>=20
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  Documentation/networking/devlink/mlx5.rst     |  7 +-
>  .../mellanox/mlx5/core/lib/nv_param.c         | 83
> ++++++++++++++++++-
>  2 files changed, 86 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/networking/devlink/mlx5.rst
> b/Documentation/networking/devlink/mlx5.rst
> index 4bba4d780a4a..283b93d16861 100644
> --- a/Documentation/networking/devlink/mlx5.rst
> +++ b/Documentation/networking/devlink/mlx5.rst
> @@ -45,8 +45,13 @@ Parameters
>       - The range is between 1 and a device-specific max.
>       - Applies to each physical function (PF) independently, if the
> device
>         supports it. Otherwise, it applies symmetrically to all PFs.
> +   * - ``max_sfs``
> +     - permanent
> +     - The range is between 0 and a device-specific max.
> +     - Applies to each physical function (PF) independently.
>=20
> -Note: permanent parameters such as ``enable_sriov`` and ``total_vfs``
> require FW reset to take effect
> +Note: permanent parameters such as ``enable_sriov``, ``total_vfs` and
> ``max_sfs``
I think one ` is missed after the ``total_vfs` ?


...

>=20
> 	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE
> ,
>  			     "cqe_compress_type",
> DEVLINK_PARAM_TYPE_STRING,
>  			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
> --
> 2.44.0


