Return-Path: <linux-rdma+bounces-10612-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58656AC1DDF
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 09:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 587BC7B7129
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 07:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6E228031B;
	Fri, 23 May 2025 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moGt4aTl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD4B17ADF8;
	Fri, 23 May 2025 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986346; cv=fail; b=SnmjRFhdDAPB9IHcPnZ/hBPhb0474zKTtqP9/lf9zR7h+nMBl5PnQDHUburgQRqjo/8gCDw9Q6MObwsg0FiU1xERk8lRw5263g3Lcyfx078xoF8/QGhCy0HA6Lsk6Y88jMfRn9kHm4fiTQEFkwfAI9CbdukwpJpVyECkA5jqT6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986346; c=relaxed/simple;
	bh=Z03D1aDCCA5dWw0c/YDbC/y6cEIXsnEUqQA3cSWdIWs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BgNxgVjmgZlggTukwLIv4LDgGzXgaqXsmtX+IOfGNOTehc4V6jxkySApPc7XLRcdv3Ay8jA7zN7OtBPGpV36ZVya4YMFy4SVorAOTcwAR3Brx3iKQqHx0Ad1l2DYwY32SIDMwMUYy83w9E8aatiZW6l5foZ1oZQnLtMBIaZzRxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moGt4aTl; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747986344; x=1779522344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z03D1aDCCA5dWw0c/YDbC/y6cEIXsnEUqQA3cSWdIWs=;
  b=moGt4aTlCP1mSptMeKWSKMg+mK82fYjJvS0KO2ivuxDXsisUZ8YsKfKa
   z8Jh9TB3fejagWbp3OVRWK65in1Z8wG9a37mJv4A5AYMvDXk6I9AFwx06
   /dmsl3zJ6rLib8D1+B0VPbEIYv3ey0PCflKi1uPkjsgyPpJwLfP4jxjSS
   msSI2+1wE77tqZvEq+S0ypWpAgVlMallSPLIm7f7NSYI06AlfcHJIacov
   GsxrbfFSoUnZUR/5Yq4fun2sMtfXAbSBd6i8NUJaHQLpEH7fqXMn/aDOF
   VDPiYBIVI9p/5mlQQDxurTD7wr8l2zuRVg8rYvKiLs2L4ZtM6vK8Fuefj
   Q==;
X-CSE-ConnectionGUID: 5ltY45zKS56gmBsdxKsrnQ==
X-CSE-MsgGUID: n9fxRabJSm+i+Ip3ncPLsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49914101"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="49914101"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 00:45:38 -0700
X-CSE-ConnectionGUID: tSkglklMRm+SoNDnb6Tdew==
X-CSE-MsgGUID: EFFdXE1dQqmGZ+w6atIZIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="140856521"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 00:45:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 00:45:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 00:45:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.52)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 00:45:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9zbMkZeYW2RYT2Ue22rpUIuKboTKnJLEAmqtwZ8HBZ/zo4LX65JlgOeAUUhsyc7ESg+7o+gczQM+A+U9ANBgSapIwNWRnN4Ci+179ejyWyQTIWWKgs+DR1fHp0eihfETcdAVCthL+SDF5aFGIzkwV1uOaU7jrAazt7TPnr7jHzEXZ22NKf5CvKnHbpw97Npe0xp214+Abk4XzwG2m5n6Ny7S0KmfFGttXp8Fv4lgFbqDDvjapFw/ZRWAhqNAosadQI/2dHeOFY9KSiqQb5QotL1bcZzxZBMBbN0LxzLYtqqY8DA0quphsfc9KVoJRjkxtOHbhENhH2jxWU1meamIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0MFCpO20/7vzj9La1Nk261Js9gIsWdH4piyNinkjEM=;
 b=ob7qhEJaSF6YsUHZ0yFSJyf2K0sTwTAQ/HHJ5qwPBWXJJHH2EapWpNpOmTppAszyCZdP8mfP6c2/DR20vj8Cr9p5dil4dJ8Lc9f6/Lgl50EAdJzpwPWU2frGHklYJvQaABf9GFNiZCALcf8hVKyXf886QOOpHF5giAsVroRO/pIyYmEZC+JMSqyzznH8fgi3oBD9DvDr8PorTo35Cg8SMc1VmXbtjhKiCAXotNcJHxRgcUJs6jIfxUevTbC9vrO9oOmc1hC9n5nhWxXybG83CdLHIW96i4e1pZ3qgX4k8uaPz7M/SeK1HRrJqw0aM8KXWmGYOUaPmhevxDoHyJ0KvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8446.namprd11.prod.outlook.com (2603:10b6:806:3a7::5)
 by CH0PR11MB8165.namprd11.prod.outlook.com (2603:10b6:610:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 07:45:30 +0000
Received: from SA1PR11MB8446.namprd11.prod.outlook.com
 ([fe80::789f:41c7:7151:23fb]) by SA1PR11MB8446.namprd11.prod.outlook.com
 ([fe80::789f:41c7:7151:23fb%6]) with mapi id 15.20.8746.032; Fri, 23 May 2025
 07:45:30 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "donald.hunter@gmail.com" <donald.hunter@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v3 2/3] dpll: add phase_offset_monitor_get/set
 callback ops
Thread-Topic: [PATCH net-next v3 2/3] dpll: add phase_offset_monitor_get/set
 callback ops
Thread-Index: AQHbwBSYBJ3EJ8z+B0iwWujbZDDvS7PIy2yAgAAKFQCAAP29AIAWF0Ng
Date: Fri, 23 May 2025 07:45:29 +0000
Message-ID: <SA1PR11MB84468A82953226F3C16D9CCB9B98A@SA1PR11MB8446.namprd11.prod.outlook.com>
References: <20250508122128.1216231-1-arkadiusz.kubalewski@intel.com>
 <20250508122128.1216231-3-arkadiusz.kubalewski@intel.com>
 <rwterkiyhdjcedboj773zc5s3d6purz6yaccfowco7m5zd7q3c@or4r33ay2dxh>
 <SJ2PR11MB8452820F6BDF445F29D368C99B8BA@SJ2PR11MB8452.namprd11.prod.outlook.com>
 <we7ev4qegycbn6vp2epoeq45kulkpurdh2dga7zgmx6xq5hy2e@nkjmo3njtwo7>
In-Reply-To: <we7ev4qegycbn6vp2epoeq45kulkpurdh2dga7zgmx6xq5hy2e@nkjmo3njtwo7>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8446:EE_|CH0PR11MB8165:EE_
x-ms-office365-filtering-correlation-id: 4505b71a-472f-4afe-04a4-08dd99cdca68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hB8EZK1U5JA3iWTMzpE+AmDxV0/TcxtfoZ1CckSpkSgBuU+8871Tjb1Hled2?=
 =?us-ascii?Q?/BrkzBAbnBvEyVuCACx36RMKuqePzf/fBYk+AeOGZQK35WvQUcQgbcK/nTp7?=
 =?us-ascii?Q?bKKUKbPAZ3TPUz70Pg0v77x4oVQ7gpisTpahZg83nB2QLO9N5dB/lPwO1F/+?=
 =?us-ascii?Q?O+D5aziHfZeYDbpUK6XTQN91GH7zXKEjfoPD22XGGkKCWDpwjj0JP67YwVI6?=
 =?us-ascii?Q?wGkR1dGakdrY352VqhWSnSMzAxXE0BucYUmtqWmr5e0FK0egcNMOiwEjXmyv?=
 =?us-ascii?Q?5ATpcTrSsb7iwVmWqTVfdkrdWYgB9MIfufWuj152bSAXUYSUsFIgbrFV8SEo?=
 =?us-ascii?Q?xTIRCvSbkxCpzndOw69Oz4gk3IJqBOmSz/dQtsSCiQxPswrZcwNsG13uEJyd?=
 =?us-ascii?Q?LdGA8NAPpFNxlGH/qjq1YjwKEoB3ISdJe8XW79vaJcDU9yYPRuTrbsVjauvo?=
 =?us-ascii?Q?pJBI9F7G85IjpA8GomSFKQGfJyPZawkaN7A6P5VxjPLcUJjfr76oHCBpZAOh?=
 =?us-ascii?Q?23WLTXoVqHDLf/FfNWWEbM31IRwIfd7LR6bHa09Vhi5mCeNdT4NgQ/XyCLV4?=
 =?us-ascii?Q?AWSAR8KFswjfsx+Tf7aO73QvRYT0BxLtJlR1CSkeJPEaBdPljIPt2kwC4oNY?=
 =?us-ascii?Q?857ywOYgc2/wl9B4/qNIVCqwmBsk2Kc6M3L444zALCCO6sFzZT/CQgAblz0V?=
 =?us-ascii?Q?MDq1Nxm/OinBv2hSPqvvFdiTjqTgJaCwnT9o3fbL4/ZEkpmdJptStn+VZ36A?=
 =?us-ascii?Q?OLo0pQn7jCOYhWbXikXheiRRqRtDcLPw2uixE1MlJv10qKmfZg4ZOOHcz2ow?=
 =?us-ascii?Q?Vb09D9xwvx0sJS57frqpig+LJmwIlWuQPrvJcT7mFiK0PGZEV3vFQ7F69IRz?=
 =?us-ascii?Q?bT4G26J4w4A85d4dLZKrXHH9LepbFWCca9g5Z90NEe5j3ec0QkVXWCeQdch0?=
 =?us-ascii?Q?K9iuS5rMFiOctnjnBPcLEvfADTacE8RZ8orv/W/tvgcawgolGDuUD7Ngawsl?=
 =?us-ascii?Q?gz1o92xrJW30bjn4ZPgO1z0ADEVw+F4RrLynVCecXU9Ym8xLeJ18r9PU6x9h?=
 =?us-ascii?Q?WpsuImD3t4sqaUnz/cOU5bQCYk1CFkY8LIkssS0Gsj/Qzs2VV/NYfoj16Tgt?=
 =?us-ascii?Q?T+MAsV/o+3Ne3Vs2rI/xYiT47NifdgBbZMdj3P2WOm1joCcbhfarOLKUVVzm?=
 =?us-ascii?Q?UxjJUe9qFo2iou+Vjr9Vwn8cKuth8h4sIcNmle8cY0FZ6GxL+dO2sn2jsNcS?=
 =?us-ascii?Q?C8+nvOgQbPuJVQ2tmKFhdVQn3F2+yliTBvzfpJaSwvfyUeLZg6CajctoWBjx?=
 =?us-ascii?Q?u3CU69I4Te+e99uzCp6YT779NIQvdvKZwoMAR/8k/Gcvjq7Kdc8R6vYbBDkB?=
 =?us-ascii?Q?3S52cks2JGUXF44tVGuV1DgLR3Dmb1s/4++H3Nx2stgkEgm6QvAcCuHf6zcr?=
 =?us-ascii?Q?O1fXzGpj/NChfjOUDsqEug3Ol+55v4yc4OE7QX+7UNqxrDCQu8Ae3A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8446.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jWWQ5oEQqIS4Vs95Z/cSZO2MzJQ+3dBOGxrBp/ZQVOpGC2s2SMB2Qe/8zwGo?=
 =?us-ascii?Q?8HgJfdJIDsUM2s8Dsd1lmCrGzgn8mUEG4EWaMQg2jd2d2l7VBAYVNjxzLdKy?=
 =?us-ascii?Q?YFmVhXuapGDdkZpvAYZWNvnE1jDigFpvUjcuXKUT3x/ilGI7K8aD5QE5V/eK?=
 =?us-ascii?Q?HpFm+1qXHAJYI6juYBF2+Z24EmrKhn2Gq2ZJFPwSpnJKYkmzE/+9oyVRZjJ1?=
 =?us-ascii?Q?aCjUfNKPU2t5wwrQTLjfsQYKBCq8oJno7vpjzdgbnBCWwnE/OcKEJLtZuKYq?=
 =?us-ascii?Q?DSDSehnT9FkB+lY4GN/OUAhR5BgFu4atY7rOdwVgqN1hPEwDE5Sss0Sp+E3q?=
 =?us-ascii?Q?xrYI6AhW/bbvLf7zGLdDhIVV6DcKhLzD9SLhuo58oq/HiHIyGk/YSAs4kNsZ?=
 =?us-ascii?Q?O16rpBfS7Mco8wJERFVgw0wK6DLShLnUx1xvyh5mgFe9fmvZanETuVqDF7kF?=
 =?us-ascii?Q?1daiaEKbZq04egyqw3uglwSCCIwOCQOMzVCAZhT0smMb6DH+Qo/6hEPCJh3o?=
 =?us-ascii?Q?rtfEH4wMqG8s+w3+ZhuG1CiKOImFa43K54BjH5IC+16sYFaxwxcPasanMpUH?=
 =?us-ascii?Q?8pqLH/PgeLyvWmwDiJeHesIgCW/eHVafJpNZZ5gqV4KNJAByaSBv+RxPN38W?=
 =?us-ascii?Q?7NpqxvKYFwSKYsp1q5fqFKbbGZJ1Q/s4PnGhKBQCOe84IhY6poGLRDK86DAn?=
 =?us-ascii?Q?yTgGInSJOIZEhKELh3153oPf5KAip1ZnwrkNJCJH2mIF/lSBS0GryvSo7OPn?=
 =?us-ascii?Q?XGE8fdAN9yrh0cmXmnnjN2nOShrB9fC2yZss3wBwxVMro1iQRkkrPci9u2rR?=
 =?us-ascii?Q?qYOu4COQEHY7TgqcL6Lre41qlosM4PVaY2AgD4taX/ZJ/aRDU1IiRNyAafFy?=
 =?us-ascii?Q?i0Q1oipgQYRhrJS7m8/28A8zBm6G4D+izLj+Hg9KmTb0S+C9VatdunNxWJs2?=
 =?us-ascii?Q?0fe6RmdBHlApE7+ERWY5oP73easUYQfPVFzUxII4cYZUgCsbg73ZbOftr5td?=
 =?us-ascii?Q?80OAFKZ3MFXzxYQazNj5A75tgHLmyA48sGtFiwPFmMfdRLuZR+zqkCI9zkOl?=
 =?us-ascii?Q?bItMLLk4hMx+bzD49WvcspMtqAJq/LFW56LMluaEMVJLlcv9P0z1BmRLhCEg?=
 =?us-ascii?Q?q0PYE4D0wzTveYYHMp3Y0ubTczWTBlvcTht3FZD2WZP0vVtHX0n6h4rSeH06?=
 =?us-ascii?Q?yEbltV1tXQo5rPaagYDMsqW9QWp64voVnXDEnYlMZRgvitLdyIixkBqArQme?=
 =?us-ascii?Q?xxCcH3CJD8OC+SRdnrlg7diRBUbiZYFlPHdM5naa6Di69kG9ytckHpW9bp8X?=
 =?us-ascii?Q?UBZJFiSH3RupUOaz5RrbGXWwB64zIfAdEkCKp2Lli1kxEuc/qiRjkzHeDGPr?=
 =?us-ascii?Q?47gQq6e59cbOlRWKrQPPIN6P3hdIpAETqgwsRZf4gjxeJQerpuz3GfqeMGYs?=
 =?us-ascii?Q?EqCzmmihimKWopZLMrG/Na5HnxBekakV2SEGofn58ZAfHh2/IrBzQ7T6rihb?=
 =?us-ascii?Q?Eo4mj5z8tZj6v677kYT6z+EXknWH00f0BXjUBDdJgbF/2mI3hDAgRJVkWJeB?=
 =?us-ascii?Q?4IelcRgY8gRwYWd7JRds4y8Eo+CtyYiybHIMlk7BJ/RUBUzrpIyFq+vZcia1?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8446.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4505b71a-472f-4afe-04a4-08dd99cdca68
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 07:45:29.9450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlageH8FMDmSIb1w5nqQ8NCxt7NELUE/CSQt4E2pPXBOHt8skxuCxivOQ5Uik0QqZXDL/pfIa5tskYDAyhnKPkiBWX109IRZCvwjrr+MGeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8165
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, May 9, 2025 8:15 AM
>
>Thu, May 08, 2025 at 05:20:24PM +0200, arkadiusz.kubalewski@intel.com
>wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Thursday, May 8, 2025 4:31 PM
>>>
>>>Thu, May 08, 2025 at 02:21:27PM +0200, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>Add new callback operations for a dpll device:
>>>>- phase_offset_monitor_get(..) - to obtain current state of phase offse=
t
>>>>  monitor feature from dpll device,
>>>>- phase_offset_monitor_set(..) - to allow feature configuration.
>>>>
>>>>Obtain the feature state value using the get callback and provide it to
>>>>the user if the device driver implements callbacks.
>>>>
>>>>Execute the set callback upon user requests.
>>>>
>>>>Reviewed-by: Milena Olech <milena.olech@intel.com>
>>>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>---
>>>>v3:
>>>>- remove feature flags and capabilities,
>>>>- add separated (per feature) callback ops,
>>>>- use callback ops to determine feature availability.
>>>>---
>>>> drivers/dpll/dpll_netlink.c | 76 ++++++++++++++++++++++++++++++++++++-
>>>> include/linux/dpll.h        |  8 ++++
>>>> 2 files changed, 82 insertions(+), 2 deletions(-)
>>>>
>>>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>>>index c130f87147fa..6d2980455a46 100644
>>>>--- a/drivers/dpll/dpll_netlink.c
>>>>+++ b/drivers/dpll/dpll_netlink.c
>>>>@@ -126,6 +126,26 @@ dpll_msg_add_mode_supported(struct sk_buff *msg,
>>>>struct dpll_device *dpll,
>>>> 	return 0;
>>>> }
>>>>
>>>>+static int
>>>>+dpll_msg_add_phase_offset_monitor(struct sk_buff *msg, struct
>>>>dpll_device
>>>>*dpll,
>>>>+				  struct netlink_ext_ack *extack)
>>>>+{
>>>>+	const struct dpll_device_ops *ops =3D dpll_device_ops(dpll);
>>>>+	enum dpll_feature_state state;
>>>>+	int ret;
>>>>+
>>>>+	if (ops->phase_offset_monitor_set && ops->phase_offset_monitor_get) {
>>>>+		ret =3D ops->phase_offset_monitor_get(dpll, dpll_priv(dpll),
>>>>+						    &state, extack);
>>>>+		if (ret)
>>>>+			return -EINVAL;
>>>
>>>Why you don't propagate "ret"?
>>>
>>
>>My bad, will fix that.
>>
>>>
>>>>+		if (nla_put_u32(msg, DPLL_A_PHASE_OFFSET_MONITOR, state))
>>>>+			return -EMSGSIZE;
>>>>+	}
>>>>+
>>>>+	return 0;
>>>>+}
>>>>+
>>>> static int
>>>> dpll_msg_add_lock_status(struct sk_buff *msg, struct dpll_device *dpll=
,
>>>> 			 struct netlink_ext_ack *extack)
>>>>@@ -591,6 +611,9 @@ dpll_device_get_one(struct dpll_device *dpll, struc=
t
>>>>sk_buff *msg,
>>>> 		return ret;
>>>> 	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
>>>> 		return -EMSGSIZE;
>>>>+	ret =3D dpll_msg_add_phase_offset_monitor(msg, dpll, extack);
>>>>+	if (ret)
>>>>+		return ret;
>>>>
>>>> 	return 0;
>>>> }
>>>>@@ -746,6 +769,31 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
>>>> }
>>>> EXPORT_SYMBOL_GPL(dpll_pin_change_ntf);
>>>>
>>>>+static int
>>>>+dpll_phase_offset_monitor_set(struct dpll_device *dpll, struct nlattr
>>>>*a,
>>>>+			      struct netlink_ext_ack *extack)
>>>>+{
>>>>+	const struct dpll_device_ops *ops =3D dpll_device_ops(dpll);
>>>>+	enum dpll_feature_state state =3D nla_get_u32(a), old_state;
>>>>+	int ret;
>>>>+
>>>>+	if (!(ops->phase_offset_monitor_set && ops-
>>>>phase_offset_monitor_get)) {
>>>>+		NL_SET_ERR_MSG_ATTR(extack, a, "dpll device not capable of
>>>>phase offset monitor");
>>>>+		return -EOPNOTSUPP;
>>>>+	}
>>>>+	ret =3D ops->phase_offset_monitor_get(dpll, dpll_priv(dpll),
>>>>&old_state,
>>>>+					    extack);
>>>>+	if (ret) {
>>>>+		NL_SET_ERR_MSG(extack, "unable to get current state of phase
>>>>offset monitor");
>>>>+		return -EINVAL;
>
>Propagate ret.
>

Sure, will do.

>
>>>>+	}
>>>>+	if (state =3D=3D old_state)
>>>>+		return 0;
>>>>+
>>>>+	return ops->phase_offset_monitor_set(dpll, dpll_priv(dpll), state,
>>>>+					     extack);
>>>
>>>Why you need to do this get/set dance? I mean, just call the driver
>>>set() op and let it do what is needed there, no?
>>>
>>
>>We did it this way from the beginning (during various pin-set related
>>flows).
>
>Hmm, idk if it is absolutelly necessary to stick with this pattern all
>the time. I mean, what's the benefit here? I don't see any.
>

Driver implementing callback could do that, or can be done here. Here is
earlier/better, right?

Why would we remove this pattern for one flow, and use different for
other flows? Doesn't make much sense to me, we could change for all to
make it consistent.

>
>>
>>>
>>>>+}
>>>>+
>>>> static int
>>>> dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
>>>> 		  struct netlink_ext_ack *extack)
>>>>@@ -1533,10 +1581,34 @@ int dpll_nl_device_get_doit(struct sk_buff *skb=
,
>>>>struct genl_info *info)
>>>> 	return genlmsg_reply(msg, info);
>>>> }
>>>>
>>>>+static int
>>>>+dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info *info)
>>>>+{
>>>>+	struct nlattr *a;
>>>>+	int rem, ret;
>>>>+
>>>>+	nla_for_each_attr(a, genlmsg_data(info->genlhdr),
>>>>+			  genlmsg_len(info->genlhdr), rem) {
>>>
>>>Hmm, why you iterate? Why you just don't parse to attr array, as it is
>>>usually done?
>>>
>>
>>Hmm, AFAIR there are issues when you parse nested stuff with the array
>>approach, here nothing is nested, but we already have the same approach o=
n
>>parsing pin related stuff (dpll_pin_set_from_nlattr(..)), just did the
>>same
>>here.
>
>The only reason to iterate over attrs is then you have multiattr. Is
>ever attr is there only once, no need for iteration.
>

Ok, will do.

Thank you!
Arkadiusz

[...]

