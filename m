Return-Path: <linux-rdma+bounces-18517-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N3iHMguwWmbRAQAu9opvQ
	(envelope-from <linux-rdma+bounces-18517-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 13:15:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BABC2F1BE2
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 13:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61E493069E59
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 12:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C165371CF3;
	Mon, 23 Mar 2026 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+BbcvSO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0CC39A047;
	Mon, 23 Mar 2026 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267797; cv=fail; b=Y7RMD39mNeX9e4i+Aio3DT+A6xN5BGmfIu7VhxdhAHbg6xoo/QenkSYWFFw0mnutw/Hxyjn9kI0/JNzgt2fc3ykeENyjtApjC2yqUxk12MpGu0gYc2SQI/vWZkpwfju9SbpvM/FYz76iSREnTDKyCkO3zI48HqiPLqWXbBz9fNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267797; c=relaxed/simple;
	bh=rnDKU82b2spcPpuDijtkce+QFidSHe/UfcTR8JdyGaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ufPczQHXiERDTfXgJBICYtqpESZEbAKBEJZIsdrtEFea2M9zhJ8pnLjHnV7m64fVST0GBv4RbJGr9Age+BG9aXYrpGD7ttZiY4QuzNwsYOSiJgMNC1dJKp+5NLIzQkejM9p4Qm3SpA8NQRjnjqxWk/NYy4rNXy7N15YCHAL1ozw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+BbcvSO; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774267797; x=1805803797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rnDKU82b2spcPpuDijtkce+QFidSHe/UfcTR8JdyGaU=;
  b=I+BbcvSOzbcocSEC5ZQsb4YPh7X5ODPTtCM+wNqXOUPrCVXbZIIiKNgB
   55Om20Vf8fWmfJUbqkaJHbuWj7yWgzwNhNiIaE6aHrJAA9wCgALrNwW4z
   wGV8/zs48xRUFaCisMiJEa1LdJ+vneWoT3HeVnK6A1dN1GSYCz11Mk4H3
   IOucVN3ZddLMj5mtIPKAQv+6TLTPJJmuNIBPToztJXRY5V0THzj4Gq6LN
   /V18mzcsCZgh9cZvSg7jZF5bQ4tkwgsjRXH8LSRZke7qzP4AyPgnrbK48
   dz+oB+N6r0AvD1riKiqkXDa3K9/aXyI4Cli6ssetD54qsPNlmrFbujoxc
   w==;
X-CSE-ConnectionGUID: 58ww7pbMSTWN3TIDCsow7g==
X-CSE-MsgGUID: jMAFrnhzQXiSOoYgRiM0Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75232200"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75232200"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 05:09:56 -0700
X-CSE-ConnectionGUID: x9fhiXCPTaqrVWG4O8dJQw==
X-CSE-MsgGUID: +/Jje1HvRwWCScTZN45zcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224023693"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 05:09:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 05:09:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 05:09:52 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 05:09:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njPdjujNKqbrV/B1tJmbywGnbyaggoQAxjSMnvrbGi8P/VFkQ7La0Cgq2edERvmSQVtY5vV22M1c8XL7XLThZY08DPZg2qk7uEBQYJeFxP/5Y7v2WnVmg8ViKx6WxbV5Ufn2GWI7j3E+O2Lsys0/Uu6w+hjXBOAb5Xa+/xCnwCK3ivgYVxAeLoKDlESwbMFIkEWoITMpBecbrcUW8vsujW5le3nRUIMQs1gB5WIJ+BMxBkhzrB0ulSmwuVQB+jZKJ/ZoXQ3zMMSuO68krKUXsh/tCOzjytjDdDQZwhtEeTeBU/QynXCMcVk+iyM7y27k8G6pCQ8wZfnjx70o1TGQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31YXfd9NPndSl9wmD87geKN/Mr87Pk+ueS2W4D8Q8M8=;
 b=Ivf2BGhqMe2x3a10B4xFbIxU6KORq/j/M8fALHGhzX5FXRogxxDbXvEcSOIr61eugQRxMiUTN3smwR6FEneP9CyQlPyzJAP8AYUl3oZFk/r7q8tDAUcHO2arS8o0nDn1qeA9vNwdGhsmO3jYl5ti03iLs9z5qAWxDD3u9ZH+oIi/yThnjAeYXXYEd8WEsSdU8uYP/yr4ND9uERhhROek3TvuXicCIxEsM8k2ZGtQRmZJciE14yFsAcgh39aKbHSUhihNDdWfKHk/TOQAOwqjvzUlEQ1toqyAMZHLyL/rLwiuF+PxxtKdRwoJ0RcLugbJPv0N8xXlPtxCBwjDBzqyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SAWPR11MB9733.namprd11.prod.outlook.com (2603:10b6:806:4ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 12:09:50 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 12:09:50 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "michael.chan@broadcom.com"
	<michael.chan@broadcom.com>, "pavan.chebbi@broadcom.com"
	<pavan.chebbi@broadcom.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "mbloch@nvidia.com"
	<mbloch@nvidia.com>, "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "sd@queasysnail.net" <sd@queasysnail.net>,
	"jianbol@nvidia.com" <jianbol@nvidia.com>, "dtatulea@nvidia.com"
	<dtatulea@nvidia.com>, "mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "willemb@google.com"
	<willemb@google.com>, "skhawaja@google.com" <skhawaja@google.com>,
	"bestswngs@gmail.com" <bestswngs@gmail.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "leon@kernel.org" <leon@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 03/13] net: introduce
 ndo_set_rx_mode_async and dev_rx_mode_work
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 03/13] net: introduce
 ndo_set_rx_mode_async and dev_rx_mode_work
Thread-Index: AQHctuhwc+65en+LXkW7/ZJyOjrTuLW8DZqw
Date: Mon, 23 Mar 2026 12:09:49 +0000
Message-ID: <IA3PR11MB89864D233E1C90E5E5A26606E54BA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260318150305.123900-1-sdf@fomichev.me>
 <20260318150305.123900-4-sdf@fomichev.me>
In-Reply-To: <20260318150305.123900-4-sdf@fomichev.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SAWPR11MB9733:EE_
x-ms-office365-filtering-correlation-id: cd84c15c-84a1-42b9-281f-08de88d5155a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|18002099003|22082099003|56012099003|7053199007|38070700021;
x-microsoft-antispam-message-info: groKjJgV6lsSivjU9CPIIC3+vobQtolv92PuFcISmjGCjlfPzALAutPdDX+DB+W2sHx4vvxaG85ZiQBanETmFd4RU+uzPa+LxTrOmk5hOGA8un9h9BZKv+uE3ifOFkcyZLjnFuz5XmkOFQeHVhZWLxCrJ/ifPenqMiuxHe4qN8ol75tedEf6gCRCC0TrktsIxIbGWLBIpkO7SzoEDeOicVTRjjoRdFmyU4LKaeuHKAdpP+LNobr6mJU9rB/yLQmG/CUGlaxSeLchqiLvQwMCSYhndHr7aUqwIM8fdaiqlJ9hqjWf0bfS9orsf78ziCW6qOnnNaMnyn2vKbhckTh5iqDfsM4SQnOIlXz5bGRIhmXpFXYLFMEULHQZxq5yTGGvbh8dY1KvEVuKt/kNBoPKejpSmK2eY0Hu+IUDG1z6kemwoGRuD5b0Fphc3N10fWB2F9xCACNvIEFA5N8WOS8thpVkkXDgevZ2TkCbzawJZv2+QRDqXuHA5/yZ2+potziqP01VK5WWQdeuA8RR49fRSl0NCawCeRogNorKgYy40X5tu2YdJbZJRev23aFi31zlNf6q3l+8sHitgKp+VyKN6KRH7sZ6ZnsiONruI35eqW30dGybjx6Fij9B0hUzTm4AcGK5kPtJEyFgalOWJa3QH60GbCjcrxafNCfxb3SykIpZPYzkcsGLLjCU9k2rhZ43FJEzr1ZXmauywk8GU/ioiS3oKwpzLm2RB9wsvSusrn+aaSTFnLpWcJiEcRepAh8hj2ZsK3fDktUGiZuRri8DGFami6v5z4S2Ur8wSbRnr6s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NyQJSJTxxiC3UAv+nOHYY3wATQmalzp5KT9VHjEcFHdjyf8Om+5zxSVD8pco?=
 =?us-ascii?Q?kSLL3RfWWNtU/zqPCb3xN+nwtctOTX0ZXJcRYJ1GbWoCTOwsoO7V9Iu/OCXc?=
 =?us-ascii?Q?bWMFZNYnbyJMN2HoUqhemiJTtDTFgEH1XlcG+0aQREe48RhguiaHUzDd+aPb?=
 =?us-ascii?Q?p2vnDv1u2PN+GefvaWX6mrdfXwNqAkpONAZ+M8QuccgqI8gDTn++2NlENrBf?=
 =?us-ascii?Q?78wVBU63cgBfs7KZRpcF+m4cdBHUgYAQTtMBOrBlBVCTpdb2EBlL8MogiAgO?=
 =?us-ascii?Q?aTDj3QxObYTnCFtpyln6U9aTzJ7Owi3BOqJrydQ8U9gIObHDVfKcwMbXL52M?=
 =?us-ascii?Q?Nea+kuhyMp4rHTuP5SKergetBbyufogoUX5J6JdLb79b1895w7sgyyJ2FpkI?=
 =?us-ascii?Q?3/qFdG0nPVHUAAZwLhDh17W5HK6O1g74+jbf5TgEPRL5+iOKPJVOW71iA+6q?=
 =?us-ascii?Q?LPYfZYB6ExAiB6vK24BqRn5sK3+RbjeF899wMroIxBYZxxWMsgNQrm9bO7LW?=
 =?us-ascii?Q?3UeFX+ZaQ6j3iLsUY2gkbbVj9aaivbcKn4q/DMGI3mI+htJVIFtgvbyLqUtr?=
 =?us-ascii?Q?FVkn6awhDoZl9qyMabtVivzaZv23vHAm7aYVnXzYJDWsgmGHr18rceUSA50D?=
 =?us-ascii?Q?gur35HZf/Zv12vb7JIOLCOUsA33N5EfzLa40N59SskCMfSGnCZ1K1H5W4fkE?=
 =?us-ascii?Q?c8FJCYNq8GNAiLvZfN3hQYitvICwaawbR8skE+l9eiMe/l2b38QpS93ghoqq?=
 =?us-ascii?Q?zYjQ3tODC+1oSQmnKMY0COCticugtcH16f/smm60Cj4h2OPUVRlCLLCFSr1F?=
 =?us-ascii?Q?1Qg8W4I7sqDfz1talX5fMSLRhFxSU6rICI/06HXDPTkzasnlwtJNaY1iliSS?=
 =?us-ascii?Q?/xtHC9S7Cfb1fx98CoUOCISMfZblfZc5lLRtUflEy5PUxssDWf89QyALslDN?=
 =?us-ascii?Q?NntXhFgbnUuec8Sa6Ts2lBFBpFXzobJcFvI+DsyLkloU7r0oV6Z97D7i6fBY?=
 =?us-ascii?Q?GIvMWCPwRZvBCYm/FG04bcjr+2sIKac6FUr/Ixn8IxgfOnlEakiLNGrG3kh5?=
 =?us-ascii?Q?oCYXLOCY33J4EYFnqqgS/4tWDjyOO2vczy0uNOf0T0G5syFjG869Yljb+beU?=
 =?us-ascii?Q?WL4NwBPP4mTur752x/gv5ZmznVZcyUKrW5JQAtQpStGJLUOxLw8mrIRbmXiO?=
 =?us-ascii?Q?Oi+xFlFa50Jwh7UAGgMptXBQle4VA3UfoRwtapWS8KqRfczJvUszyHBvYiHS?=
 =?us-ascii?Q?xqVGAH9frbLNDbMTtTuzyj6iwQsVeRRGw4w+GrIKXtz6WSxEI0yKYNLhxfVY?=
 =?us-ascii?Q?j3VEpRMfEszKEDsjOwAMvCRJU3ZQ6DMZUvHnNNY93+ahQBX1VDv5z0YWlSOp?=
 =?us-ascii?Q?kBQCoM3VnrJY7blNf4vd8nreWqxVmMawSR/FSMrxmm9Ioch0QBdhIjRhm8gX?=
 =?us-ascii?Q?GpqsqdotNN1nQVbd4kX6KvqYXR0tlSsKre57K4gY+YSWq4KrdxG813yXT7gr?=
 =?us-ascii?Q?rD18MV7VpQtT8MiAB/nAoe58yunmh/Eb2ta6HiQE/1TYXOnT+gHZEy+Wqo7S?=
 =?us-ascii?Q?+zw/cUOPqI/ODrTjFcWoOmkELLs8o6EtfSjxrOHreiSTBP/NH3dp7h3t87yr?=
 =?us-ascii?Q?l5MWcM6tXX42eZfv9TLIybCoEfPtopYkDH8gsk6bXHrDUfpAZGIZ4qh040Hc?=
 =?us-ascii?Q?9+wV899I8xj4NXFSk6UTfGZaLMa2TJ1XZFzKA8UsM0cz49SJIgr4xSwp2+H6?=
 =?us-ascii?Q?8ogi8tTrYtUbgndOVEg0OvhAxXAm4oI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YA+edPw/4TducWFsC6Q2xkuLdQfPKni1Cf0/WZtEzujsqMy42H0M3FSrV1laS3FXP7JG85Vy4YOqVclfZSCi1XJbOwmOq+eLpF4tiONgknYezd2/1OVnTtkJqSZVGjNMB8xGd0FFrkWOZPwdL9dg7jk/3GZD10CpTgTgGurxoYmFYSkMqFO1GsJo/BwFpIgm+F7b+O85Dyej2UkEIosdTYOv6IV4/4V+yI+7ygxPr0fuH6s41+ZtXewlDBZJfIM7hJB6lSayCT8VMhnBXNbvBDgq2zuSx7bREXSiHT1iSYceYiZ/jjIdxo+nfeULD+x76KkWs8VT+c7PL44kNZEn/Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd84c15c-84a1-42b9-281f-08de88d5155a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 12:09:50.0211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdIDHjIhKNyurO848MQxdBxPkyOrr1TYxtiP3J2QKGSrb3GkkovQPpflpEd/Z5ZCyNdgFlO+vlkEGDBwk0UBhcs53wFiZe6t1tWHMkqBu8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9733
X-OriginatorOrg: intel.com
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
	RCPT_COUNT_TWELVE(0.00)[35];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18517-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,vger.kernel.org,lists.osuosl.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2BABC2F1BE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Stanislav Fomichev
> Sent: Wednesday, March 18, 2026 4:03 PM
> To: netdev@vger.kernel.org
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; horms@kernel.org; corbet@lwn.net;
> skhan@linuxfoundation.org; andrew+netdev@lunn.ch;
> michael.chan@broadcom.com; pavan.chebbi@broadcom.com; Nguyen, Anthony
> L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; saeedm@nvidia.com; tariqt@nvidia.com;
> mbloch@nvidia.com; alexanderduyck@fb.com; kernel-team@meta.com;
> johannes@sipsolutions.net; sd@queasysnail.net; jianbol@nvidia.com;
> dtatulea@nvidia.com; sdf@fomichev.me; mohsin.bashr@gmail.com; Keller,
> Jacob E <jacob.e.keller@intel.com>; willemb@google.com;
> skhawaja@google.com; bestswngs@gmail.com; linux-doc@vger.kernel.org;
> linux-kernel@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> rdma@vger.kernel.org; linux-wireless@vger.kernel.org; linux-
> kselftest@vger.kernel.org; leon@kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 03/13] net: introduce
> ndo_set_rx_mode_async and dev_rx_mode_work
>=20
> Add ndo_set_rx_mode_async callback that drivers can implement instead
> of the legacy ndo_set_rx_mode. The legacy callback runs under the
> netif_addr_lock spinlock with BHs disabled, preventing drivers from
> sleeping. The async variant runs from a work queue with rtnl_lock and
> netdev_lock_ops held, in fully sleepable context.
>=20
> When __dev_set_rx_mode() sees ndo_set_rx_mode_async, it schedules
> dev_rx_mode_work instead of calling the driver inline. The work
> function takes two snapshots of each address list (uc/mc) under the
> addr_lock, then drops the lock and calls the driver with the work
> copies. After the driver returns, it reconciles the snapshots back to
> the real lists under the lock.
>=20
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  Documentation/networking/netdevices.rst |  8 +++
>  include/linux/netdevice.h               | 20 ++++++
>  net/core/dev.c                          | 94 +++++++++++++++++++++++-
> -
>  3 files changed, 115 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/networking/netdevices.rst
> b/Documentation/networking/netdevices.rst
> index 35704d115312..dc83d78d3b27 100644
> --- a/Documentation/networking/netdevices.rst
> +++ b/Documentation/networking/netdevices.rst
> @@ -289,6 +289,14 @@ struct net_device synchronization rules
>  ndo_set_rx_mode:
>  	Synchronization: netif_addr_lock spinlock.
>  	Context: BHs disabled


...

>=20
> -/*
> - *	Upload unicast and multicast address lists to device and
> - *	configure RX filtering. When the device doesn't support unicast
> - *	filtering it is put in promiscuous mode while unicast addresses
> - *	are present.
> +static void dev_rx_mode_work(struct work_struct *work) {
> +	struct net_device *dev =3D container_of(work, struct net_device,
> +					      rx_mode_work);
> +	struct netdev_hw_addr_list uc_snap, mc_snap, uc_ref, mc_ref;
> +	const struct net_device_ops *ops =3D dev->netdev_ops;
> +	int err;
> +
> +	__hw_addr_init(&uc_snap);
> +	__hw_addr_init(&mc_snap);
> +	__hw_addr_init(&uc_ref);
> +	__hw_addr_init(&mc_ref);
> +
> +	rtnl_lock();
> +	netdev_lock_ops(dev);
> +
> +	if (!netif_up_and_present(dev))
> +		goto out;
> +
> +	if (ops->ndo_set_rx_mode_async) {
> +		netif_addr_lock_bh(dev);
> +
> +		err =3D __hw_addr_list_snapshot(&uc_snap, &dev->uc,
> +					      dev->addr_len);
> +		if (!err)
> +			err =3D __hw_addr_list_snapshot(&uc_ref, &dev->uc,
> +						      dev->addr_len);
> +		if (!err)
> +			err =3D __hw_addr_list_snapshot(&mc_snap, &dev->mc,
> +						      dev->addr_len);
> +		if (!err)
> +			err =3D __hw_addr_list_snapshot(&mc_ref, &dev->mc,
> +						      dev->addr_len);
> +		netif_addr_unlock_bh(dev);
> +
> +		if (err) {
> +			__hw_addr_flush(&uc_snap);
> +			__hw_addr_flush(&uc_ref);
> +			__hw_addr_flush(&mc_snap);
Shouldn't here go cleanup for symmetry?=20
			__hw_addr_flush(&mc_ref);

> +			goto out;
> +		}
> +
> +		ops->ndo_set_rx_mode_async(dev, &uc_snap, &mc_snap);
> +
> +		netif_addr_lock_bh(dev);
> +		__hw_addr_list_reconcile(&dev->uc, &uc_snap,
> +					 &uc_ref, dev->addr_len);
> +		__hw_addr_list_reconcile(&dev->mc, &mc_snap,
> +					 &mc_ref, dev->addr_len);
> +		netif_addr_unlock_bh(dev);
> +	}
> +
> +out:
> +	netdev_unlock_ops(dev);
> +	rtnl_unlock();
> +}

...

> --
> 2.53.0


