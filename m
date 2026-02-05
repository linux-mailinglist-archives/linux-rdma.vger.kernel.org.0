Return-Path: <linux-rdma+bounces-16566-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDA0JEdfhGng2gMAu9opvQ
	(envelope-from <linux-rdma+bounces-16566-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 10:13:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB57F06B3
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 10:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC33C308921C
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 09:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB1D3A9D86;
	Thu,  5 Feb 2026 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2gPaum0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF536EA97;
	Thu,  5 Feb 2026 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282359; cv=fail; b=alPriKOUgJfSnxS75N2VKuOJ0TJowyl4J2l8GWg83hKj6oE2yAZvhvtutmfsBJsJcR2foGTYSsq4WSLO0GjzwIo9bUAoMIMcJShwR7a6wOxKFfcixf6hlgl6DuwHgSrus5KaDH1aX2v2NL6r2Yg9POZoQ1yRN4FUKshWvp95cpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282359; c=relaxed/simple;
	bh=6zT++3nqLM2ts+ya8cw/q8v2vIUULPc8qc8fDF45bow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9DzC43dBJQC0dBqnSg3OlRdbW4uf9blMujWp/bPyMGrI1oEwEPaUsU0f0VZy0PhGFmtmdTWCHFD6Kscm4YnrA7wOZ2s7rsGwlWG8DMIgQ93HOqbCJ/+JQu6oJE0Q6SSSlVRvBAAi/DtMerbzzOT/xN9BaSyWTFp9PXRYfeqEVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2gPaum0; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770282360; x=1801818360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6zT++3nqLM2ts+ya8cw/q8v2vIUULPc8qc8fDF45bow=;
  b=C2gPaum0dJ2Ba0A2T1YxB3YQzt5nORYRpG/wzFrSF8VqsNQ/hB85FJ3A
   0EUxHrZuaY79xT4riFEYQJTn+WiaQlNQLNnIpgHvqEB5FatYRe/LGwC99
   KRGPapGa3B/HW8tLl+J0iDLFpZTQLQKGJ430MMTAvxHaaEYpil3JyURhc
   PLCw7HCH3ZGotHdHFAauUkfO8w8qQjxcb9e/tgr8hZEXi708Nd2quPX2/
   aHY9EAn58v/UVNprpkfX0H5G5D0rQXwGSTNdLdEh3ZwBiyuimSPCdpdpH
   sgvjjwi0mFvZ+i9N021hAiXSkmCWjnq9ekmEtHmSE1ynOPv3XjNQBwQri
   A==;
X-CSE-ConnectionGUID: f/vGbKgIS3CQR3fh678ing==
X-CSE-MsgGUID: uFuX2au3QsyJmlhzFwYKqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71379746"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71379746"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 01:06:00 -0800
X-CSE-ConnectionGUID: nlDkV82AQHujJmRJSXYsYw==
X-CSE-MsgGUID: sqCGA2xXROajcEXyDKJzzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="233387664"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 01:05:58 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 01:05:57 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 01:05:57 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.14)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 01:05:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVqNH/tYw4uJuUb8YNdDweU5ha2q5BsIzdjdCJphsRgL6NuwQidMv0kUvfVzCtLLvMxqvrzLzaU8YcciEvrh1pywUJ5e+zNQaavrp0wMVuiPRpPZeKgoulHaW1UqlhH3DRH8xPnxtevpQI6Wp5L9Onsc4vIJjctJ7f13cbJfX3+L7wEw1eMHBk0uPq0wkLdCfRKhIJW7Uq9f2cG4Tn+7YEgZfoXYlTlMWuI8Ii1QwxYAf/WAfNp6/x9BvlFGSUierY88VNh9yMOEsa3IKvm9uPbkJgtZ+mkEKRSOKTIoe1XIWvrFxqeFSC6V6gt7w0pUGQbbtIzGNIkZgEXIy8v6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdFyxdL/kY9nsJLCkC7fu6jYnDuigD7JGqNXqcyrd7s=;
 b=d6FQqJgwT5pyS0GwLR9atx1fbBInx5N54IRao6GJgjZdita/pe9tm2mDEUucIhsed2sWHTZxGF+oj3sQUkkjDt0Y8mYy50m2N1wWYriu7hH+zrUCWvL+18fILEwRw4zVUKJLS4TNeN/GRRgf1wqPpQi/dQukFrMNkGGAc6nIbg7eohb9RaFXNVUZN4z3UTNSEUu/KQwuNCV46asZz5ZC8BPEY9Lf6CM2wbXqbW13j1EQDCCeK/JJyVhBvevzvwi6a8T57zwZEX3dOrvYwlBhfPorZQbdLrNMtP5gZ8nEsfzYtXF9NR/mqQoHLQBxLKj7bARTiWdcfVYZmKezyn5/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14)
 by MW4PR11MB6887.namprd11.prod.outlook.com (2603:10b6:303:225::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 09:05:53 +0000
Received: from LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::6f0e:9ee3:9e98:1ed]) by LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::6f0e:9ee3:9e98:1ed%3]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 09:05:52 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Prathosh Satish
	<Prathosh.Satish@microchip.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v5 1/9] dpll: Allow associating dpll pin with a
 firmware node
Thread-Topic: [PATCH net-next v5 1/9] dpll: Allow associating dpll pin with a
 firmware node
Thread-Index: AQHclTQ9uJHso/MzFE6GHlgvyKN567Vz0cJg
Date: Thu, 5 Feb 2026 09:05:52 +0000
Message-ID: <LV4PR11MB94911F5FE73C10AD4F06D1109B99A@LV4PR11MB9491.namprd11.prod.outlook.com>
References: <20260203174002.705176-1-ivecera@redhat.com>
 <20260203174002.705176-2-ivecera@redhat.com>
In-Reply-To: <20260203174002.705176-2-ivecera@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV4PR11MB9491:EE_|MW4PR11MB6887:EE_
x-ms-office365-filtering-correlation-id: 7d38955f-1387-4425-bf62-08de6495c3b2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?IyW5815YYH639m+U8eimQEyljOzjnUnG3hHhmUtCpfe6q1atr7CdwFhM1fBK?=
 =?us-ascii?Q?ZH2K5Nea38mkfmQVzX3j6wENXUP36c/i+rqQ+SKY/sU7qzFNVjpeiO1djO58?=
 =?us-ascii?Q?t8TUdbAj285h9MJlMpQhkVKbPkxo4qRGVZNuT7QktTQqYO795W/F00vLkOcC?=
 =?us-ascii?Q?0XwK6Fyef1FEB3lD0y0a4v8avgqZEcWWxVfCQF5z3tam5wmxkO/IHtQXPMqL?=
 =?us-ascii?Q?h8FD23yZTkjhDPKlWejsDbJX4P+BNZshhsnYN3F5Mw8Ss+sQzK0504cO/xBs?=
 =?us-ascii?Q?j20OvquS/Z8muxo5XjPGfk2lmGuhtwCaOUz3ft0H0QhXXmF1+XuCpkQt1NAS?=
 =?us-ascii?Q?N3Wh6AHtpu6JcOh4W9kuEOBwZFklcwjCC1hsSQ0Vkz1PEfV3fbIdHgqnvwww?=
 =?us-ascii?Q?naLcXNHj6AOlCCAMQOrB2Jq3mJ4vzBRQRLRixh2u3XwmcuWivJtxVCTovNgR?=
 =?us-ascii?Q?1W2P9RuM645arYHEgH33Cz6R2WPmyYQTjV0/S8uYtkBvgVNtsfNv03hVCDd/?=
 =?us-ascii?Q?1o9oEJ3soxBg5jlsVeulzrMda/h+iJCp2nobUXxbm5lFwAnVwAO+1pwmZZty?=
 =?us-ascii?Q?58gTeogsqqsh8CiB+k93SZUB/1685+NtatppHTkpfYKinK1DGTMwO4Gv9WdZ?=
 =?us-ascii?Q?sUoq6jkDY8OU/B/+Q5mksL7zZSC0yb9/BxcRs91H3aFRJArsWS0tUclmjshR?=
 =?us-ascii?Q?9atUprIgZIjUiuFh8ObY3K0dY/pw46Jfryy7iszIon32W3xDauR2MQrXb3sE?=
 =?us-ascii?Q?r5i91Mcx166K3ZU6n+cLVA7N4DbJbVkxjvVUZ9vXaaumYQ9fsmIJzvOm1KR3?=
 =?us-ascii?Q?hdzfVZqSjIRKX0hLg0nEo9gRB0B03ITM35jAseOzyrbrdPvoXKyIy5E81bTt?=
 =?us-ascii?Q?VnLXqbB6UV2j8ThWFyBNEpYaig69n+p4nFayEx8nnONzY0zW/6ctJu57D0wu?=
 =?us-ascii?Q?og+YQF/vn4oxnXorpQ9molnTiR0Jmiezd4lCjsOUH9/xAQwoOSZHn6aMSbEd?=
 =?us-ascii?Q?+mJWq0NSbm8lw8khhiKV0p/Dk8qPr+hE3cQrgfEDiH2PwPK6pZgLxIveWoWy?=
 =?us-ascii?Q?nIh6uYCm3m5C4J3PGplp/iHG+Ylsw/nGYgupX3dEFxp0RwxfHvxdzE+XVg1l?=
 =?us-ascii?Q?QCQMQTnwef2v1mcpYyuRJ+rKejc6CuRNvJryAH23mL/9Gg3ZVplBtpRd1gGE?=
 =?us-ascii?Q?+LUIF9NnDWLgtLOLRnJqtc3w7KaJWZA1lKjMlBc2PSc9a7vx3R0kGgcrzaH+?=
 =?us-ascii?Q?1i3gBeCu8x7VjjpXsA627fcUeRfePgzHQ2y0PNZvmJoUjpEIyevH901f73vb?=
 =?us-ascii?Q?nOkbNz3fQ4cTiO7NthZPuuU9Q5UPOr0m+n6XB5kM2hlrO4sILMEvefGHn3cx?=
 =?us-ascii?Q?0KsEjPT47BWPA1jixGRdh08bWNE+KLaay+mNv2ivxfHP6NCsBJ5PIqzgggwf?=
 =?us-ascii?Q?+nEjp+jfdlQCYmbBFA8uIor0asORkylAZHcnvmJ3bXAeXqAXbC2are/xw4DA?=
 =?us-ascii?Q?sXzZBAflq/tnbR+OQE6xd2fdqZTsqcED4hTRrZ4/R/Nn62VKiHe7HQrM51xw?=
 =?us-ascii?Q?bPUi6XPR333I9cuJSAlwFSGxu6TvZ8l5di6RFDesDvjE+eEMfw94A/w7w9Br?=
 =?us-ascii?Q?tpB53HnmgzbxoFvEMSErpos=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV4PR11MB9491.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?etFh1xBb+OMUvDD+wpLYkTWM5q5GqV+9gclLG9hBblqBaL5NDHyrIIqhZZPH?=
 =?us-ascii?Q?YtMey9m8Dho5oNy17aSOatl9RM5i1esEshpNOBt9qWZh/5nK/quNYZ2GHlE2?=
 =?us-ascii?Q?+K1HeJM40XF9oUtEMhdWN5oSWRLvzD2JL4Mo43yEpfiLQ4AWk/jsaD67jjKe?=
 =?us-ascii?Q?vkXBhVm3UVwCeDoECvGlJsBMJeE6Mt4d+KpquP4Jl0mvWJQSZ+2D5dczJN+J?=
 =?us-ascii?Q?wjvTdFDmhzpb9ckj+2Ty+MRl9ve/nxa0XRY51ys++40PTcRsxVzLUvYaqHO0?=
 =?us-ascii?Q?dnJfL+zQg4DTQCw1wQJWrUisIdFqgWxRoIkm0CFqiNwdC5gpoU21gGdy4i3D?=
 =?us-ascii?Q?NAWiNaDo+btBwt3XzXA24cuOeMXeo8/H5ozIBLyBCT23TpNlga7NrwzMGEY5?=
 =?us-ascii?Q?Q9DDxjQ3aQJ2KvFCvHLghgVMVfwHMvdIydQKOeK/B1unrvDIR+yyiBFpgaDD?=
 =?us-ascii?Q?1RBPcxtfPhGuFYZgx+Kj8mMsGNIkRLNASLYhZjBSleJPQRZ0YEpUgp5QXiTW?=
 =?us-ascii?Q?W0l9FSFnrPTKYOwFLS8vchc73YdEq+0NK0Tjnv4a1YU5wADjA+cSGfunZlIU?=
 =?us-ascii?Q?qm8Rx5am/iyKgnLJIsPeL4iLsLiyWb6t1ifpOxKcoMuYQRRCul7HvTivRldC?=
 =?us-ascii?Q?boxyfVNMviJAnz9FpVIouN/q4QAQZNy9Zrpz0FvKG5KBSSIBNeV/FhooS5hn?=
 =?us-ascii?Q?ZbQOCjOLoLc5kvxk6d5yj95/FworxL8XOS8NDgaJ2jDV/XoKVlK+z0V/N3qM?=
 =?us-ascii?Q?Gfge5yTdzKv3CQ7s/xCe1Jcr3oCMkeUGr50jUzpXy7qjStvKGXNv9uQnQAu0?=
 =?us-ascii?Q?2GfI067maklcn4lkzLuNn9gM+1HgCA5l2LHmfvydipu+z3KLeZ/V8FXFR0Sf?=
 =?us-ascii?Q?UgdsJa7UEgMBiceznj6beP8Mu5btVjh2xQ2MslpQqH0lYvrB0W4MK6PNlueP?=
 =?us-ascii?Q?B/7xMze2TCCq0J2vjotYJcb9KUkr0ZgOKYsLfj1rPfOMxX2BumgpqAt8Py2V?=
 =?us-ascii?Q?rbwdo23iB9R6wkGK+bdBPX+dBuvTjFxvC/KGeQwWY9EbhZGezwaCHW34OLiX?=
 =?us-ascii?Q?9sXViM/peLA4/Yb3n+f1df0NIYyCz3u8g4zMNk3Da7RuZrqtCm2EqFdYZeSg?=
 =?us-ascii?Q?FBEbFcagZIXTGD+iCVo8F4VX8f7VoOppW/RDl3E91FQK1piQ4iMvgQYextQi?=
 =?us-ascii?Q?lMNGkHScH3W6IUlSkeSNsf8cI9BGNOUBiQnDBDjhe/HxNpSxjpKQp0MQN1Bg?=
 =?us-ascii?Q?BnDs+HoQFjMnK1AfCngsiYY18e73ia5OGqLcVV8pgXZflKGc2kgm3ndYyxRW?=
 =?us-ascii?Q?eKrnJSARmu0YBZA+wuyRHoc+/o5A2ZPlb3tcxZTVyDKQtwjedwSFTyq9RI2R?=
 =?us-ascii?Q?z8uSpb/DUxvY9Gsi1erlnzHRlGnG+B8zScPrP3mXeLJs69ESI/n3L8Gada1z?=
 =?us-ascii?Q?+NdqquM/TAWdJKwa9Touw9jS0HcC8lx1Ok3GQjfXbX/SuG6032HQAmsXFYEz?=
 =?us-ascii?Q?SsZ7AqwMnHNGRtzdUbONkFVylHTxUfEVjngA2zGWOcmoEg7RS/UU6zJ3tttz?=
 =?us-ascii?Q?vrPYsL8T9G9+u7LD1xn/RF67OVNRcU5iIqxp3KLO4jnr7NtrK0+tpxf8P6Y6?=
 =?us-ascii?Q?LGmeaVr2S6ONYJaNxwgNMcOYiTyjfmZ0T+CRmpNHAIRs/Mbyetkxj06oHNqe?=
 =?us-ascii?Q?iyB31EA2YYPCCoUMCEtnrwY79ah2sG9NA3nKPO1Zd/DyLhhuL1rvhXEFHai5?=
 =?us-ascii?Q?BEBcvNLzqF0jnQKCQYGacPmgK4dUxco=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d38955f-1387-4425-bf62-08de6495c3b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 09:05:52.9278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kuxlRMA8vKQanNc5UblNFHkd2EY9AH+xkv8piUI7YtQtVARTLqqpuD6Lu3/Ne/QwelkCgggmW7d3EbGAuvsO6Mqjgvtl4abQ6IawhSY2MME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6887
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
	TAGGED_FROM(0.00)[bounces-16566-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,redhat.com,microchip.com,lists.osuosl.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BCB57F06B3
X-Rspamd-Action: no action

>From: Ivan Vecera <ivecera@redhat.com>
>Sent: Tuesday, February 3, 2026 6:40 PM
>
>Extend the DPLL core to support associating a DPLL pin with a firmware
>node. This association is required to allow other subsystems (such as
>network drivers) to locate and request specific DPLL pins defined in
>the Device Tree or ACPI.
>
>* Add a .fwnode field to the struct dpll_pin
>* Introduce dpll_pin_fwnode_set() helper to allow the provider driver
>  to associate a pin with a fwnode after the pin has been allocated
>* Introduce fwnode_dpll_pin_find() helper to allow consumers to search
>  for a registered DPLL pin using its associated fwnode handle
>* Ensure the fwnode reference is properly released in dpll_pin_put()
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

LGTM,
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>---
>v4:
>* fixed fwnode_dpll_pin_find() return value description
>---
> drivers/dpll/dpll_core.c | 49 ++++++++++++++++++++++++++++++++++++++++
> drivers/dpll/dpll_core.h |  2 ++
> include/linux/dpll.h     | 11 +++++++++
> 3 files changed, 62 insertions(+)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 8879a72351561..f04ed7195cadd 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -10,6 +10,7 @@
>
> #include <linux/device.h>
> #include <linux/err.h>
>+#include <linux/property.h>
> #include <linux/slab.h>
> #include <linux/string.h>
>
>@@ -595,12 +596,60 @@ void dpll_pin_put(struct dpll_pin *pin)
> 		xa_destroy(&pin->parent_refs);
> 		xa_destroy(&pin->ref_sync_pins);
> 		dpll_pin_prop_free(&pin->prop);
>+		fwnode_handle_put(pin->fwnode);
> 		kfree_rcu(pin, rcu);
> 	}
> 	mutex_unlock(&dpll_lock);
> }
> EXPORT_SYMBOL_GPL(dpll_pin_put);
>
>+/**
>+ * dpll_pin_fwnode_set - set dpll pin firmware node reference
>+ * @pin: pointer to a dpll pin
>+ * @fwnode: firmware node handle
>+ *
>+ * Set firmware node handle for the given dpll pin.
>+ */
>+void dpll_pin_fwnode_set(struct dpll_pin *pin, struct fwnode_handle
>*fwnode)
>+{
>+	mutex_lock(&dpll_lock);
>+	fwnode_handle_put(pin->fwnode); /* Drop fwnode previously set */
>+	pin->fwnode =3D fwnode_handle_get(fwnode);
>+	mutex_unlock(&dpll_lock);
>+}
>+EXPORT_SYMBOL_GPL(dpll_pin_fwnode_set);
>+
>+/**
>+ * fwnode_dpll_pin_find - find dpll pin by firmware node reference
>+ * @fwnode: reference to firmware node
>+ *
>+ * Get existing object of a pin that is associated with given firmware
>node
>+ * reference.
>+ *
>+ * Context: Acquires a lock (dpll_lock)
>+ * Return:
>+ * * valid dpll_pin pointer on success
>+ * * NULL when no such pin exists
>+ */
>+struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
>+{
>+	struct dpll_pin *pin, *ret =3D NULL;
>+	unsigned long index;
>+
>+	mutex_lock(&dpll_lock);
>+	xa_for_each(&dpll_pin_xa, index, pin) {
>+		if (pin->fwnode =3D=3D fwnode) {
>+			ret =3D pin;
>+			refcount_inc(&ret->refcount);
>+			break;
>+		}
>+	}
>+	mutex_unlock(&dpll_lock);
>+
>+	return ret;
>+}
>+EXPORT_SYMBOL_GPL(fwnode_dpll_pin_find);
>+
> static int
> __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
> 		    const struct dpll_pin_ops *ops, void *priv, void *cookie)
>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>index 8ce969bbeb64e..d3e17ff0ecef0 100644
>--- a/drivers/dpll/dpll_core.h
>+++ b/drivers/dpll/dpll_core.h
>@@ -42,6 +42,7 @@ struct dpll_device {
>  * @pin_idx:		index of a pin given by dev driver
>  * @clock_id:		clock_id of creator
>  * @module:		module of creator
>+ * @fwnode:		optional reference to firmware node
>  * @dpll_refs:		hold referencees to dplls pin was registered with
>  * @parent_refs:	hold references to parent pins pin was registered with
>  * @ref_sync_pins:	hold references to pins for Reference SYNC feature
>@@ -54,6 +55,7 @@ struct dpll_pin {
> 	u32 pin_idx;
> 	u64 clock_id;
> 	struct module *module;
>+	struct fwnode_handle *fwnode;
> 	struct xarray dpll_refs;
> 	struct xarray parent_refs;
> 	struct xarray ref_sync_pins;
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index c6d0248fa5273..f2e8660e90cdf 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -16,6 +16,7 @@
> struct dpll_device;
> struct dpll_pin;
> struct dpll_pin_esync;
>+struct fwnode_handle;
>
> struct dpll_device_ops {
> 	int (*mode_get)(const struct dpll_device *dpll, void *dpll_priv,
>@@ -178,6 +179,8 @@ void dpll_netdev_pin_clear(struct net_device *dev);
> size_t dpll_netdev_pin_handle_size(const struct net_device *dev);
> int dpll_netdev_add_pin_handle(struct sk_buff *msg,
> 			       const struct net_device *dev);
>+
>+struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode);
> #else
> static inline void
> dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin) {
>}
>@@ -193,6 +196,12 @@ dpll_netdev_add_pin_handle(struct sk_buff *msg, const
>struct net_device *dev)
> {
> 	return 0;
> }
>+
>+static inline struct dpll_pin *
>+fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
>+{
>+	return NULL;
>+}
> #endif
>
> struct dpll_device *
>@@ -218,6 +227,8 @@ void dpll_pin_unregister(struct dpll_device *dpll,
>struct dpll_pin *pin,
>
> void dpll_pin_put(struct dpll_pin *pin);
>
>+void dpll_pin_fwnode_set(struct dpll_pin *pin, struct fwnode_handle
>*fwnode);
>+
> int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin
>*pin,
> 			     const struct dpll_pin_ops *ops, void *priv);
>
>--
>2.52.0


