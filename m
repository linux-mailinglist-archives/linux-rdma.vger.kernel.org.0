Return-Path: <linux-rdma+bounces-16564-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJb+C9xghGng2gMAu9opvQ
	(envelope-from <linux-rdma+bounces-16564-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 10:20:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE43F08A1
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 10:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FD27310410D
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D030F38F23C;
	Thu,  5 Feb 2026 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3tdkPBI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E82BE053;
	Thu,  5 Feb 2026 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282099; cv=fail; b=EnEBRiyvL/Gp4c4AhClvFmBKFEjqRck0jC2sdYNoqRigqvkUgOHfKTYhx4EIBj1UorEHR/O4h05j9Y6RTNSLtMJ4TV8NwIOvXPt2ZucQVO1fo/afOkkFHpO8orszud6XmlTyZ+tucS4zHOxYwvcG5v4cH5Xpvq1VIBuuHXwVlJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282099; c=relaxed/simple;
	bh=TgC+Qtr/JhwCoW6RC+MlE5JoiNNtw9ywN+8On8sxrl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aPQ7Fkz2nL16KsUDCyrTC30cvwb/xIqHEX9IWvrOIW1Zhq2yJmhifNMn7UdgdSE+bGmWfU7g7VvV+b/437iLry2oYrFd9TLsroR5dqf8rtrc7+/xGDv/rJBjsRgiKyl6SYuR+rAfEIjikmPM7uv/aGso8Fq98+//Aa4mp6h47oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3tdkPBI; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770282099; x=1801818099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TgC+Qtr/JhwCoW6RC+MlE5JoiNNtw9ywN+8On8sxrl0=;
  b=g3tdkPBIwabXrV7cUzXIQFwX0eW3P8EhjJKXqP1A+FMid+3CLiElH+Dp
   s2sr/Xo91A53A6HbdFTcVimH5LSgDo6EsI2i83MYUEsj4ok7Vei0OLIbn
   hZ5bsRCA+iMahcIbbIm9ZLyrxXLn0OdpyBijEP8XO0T3FJLarCJNtEc6R
   H1aNVmjPJLAZ+P0IX7VcB9RtolRFddiUUIXoJD+v05B68gk5TX5N212Et
   6cw6I6Meya2H/jBucxzZemkM9BcowFPB7U5HTttzmJlz1Uw9nY0klTyIM
   p0J4jnJCbm4mSG9qf05Do/RY6LKQAu0yo3Hfz3Yic6RosJW7qPWVTzZAu
   g==;
X-CSE-ConnectionGUID: V73IKMurQSaYwogxF3BKIA==
X-CSE-MsgGUID: iyq32OZYTs+a2gJzsNymow==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="94126438"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="94126438"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 01:01:38 -0800
X-CSE-ConnectionGUID: goekc04iSXSl35PEXvNU3w==
X-CSE-MsgGUID: mRMTx6aeQLmzlGl2rtq1Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210527061"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 01:01:38 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 01:01:37 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 01:01:37 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 01:01:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1F0lMSbiBUvOMsdk+Wk4jB0OOMroqKxoHLHFjG0m6a1STPb+ty4tQ6KjAbiaoBeokhqdkybWNvVFAAMPs39V+OIz1MUEER20NpM7DHDHPtK2OSiuUaRUnrzuxBt8xOhsBTatkArwDAob5JeHK0SkqCLK/fpeWAM5mHEx4W+rPscGIdwON5g7OhhSZyHjK0wXcErgIi7iFuggc5O1xAiswAMekx9yiGgKQo/kNpBLPOgIuj8zmd6JwQ+1SD91nFbdyns5l/cdXHPTZwrDKEBB9XmbpOd86r6RHovTHrAR+zo2rFqF+eCdJ0kox7grfwQuMxPNpb3fhokkitBNIARwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhqOpg6UQmIf77URoWerRR4eRiBi5ot/1MQrscJUddo=;
 b=wrxevlYgnGLGwPF11XxOPrXF731HPvdRPku9g5kNyDOqXGC8HoDp4kPjmq7kbRv274vcyUE9w74y9/l7DUIYdg1MUrjboPeyw5jWt9dkXtuCa6GrMfAVCL3p37/SzoYYaxcCBuxHqaxHIldlrtbAM19OSQXPg/IkBs2TYbBLmkuGoaIG9nA11MYFrta8SC0iE6Y74IIelr6gAtuLrrQidOZlYekT6seUWkn6SXW1TLVDEbcfemOQX9L6MP1tVc61Pa/i9BDcR6dgxKsk50jkq0XEIeLExKjsPioa6yHTiuITgFfCNH8kW8qUkt2jlZw0kUmnUypgtFexEfycLwxgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14)
 by MW4PR11MB6887.namprd11.prod.outlook.com (2603:10b6:303:225::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 09:01:30 +0000
Received: from LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::6f0e:9ee3:9e98:1ed]) by LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::6f0e:9ee3:9e98:1ed%3]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 09:01:30 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Lemon <jonathan.lemon@gmail.com>, "Leon
 Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Paolo Abeni
	<pabeni@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Richard Cochran
	<richardcochran@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v5 4/9] dpll: Support dynamic pin index
 allocation
Thread-Topic: [PATCH net-next v5 4/9] dpll: Support dynamic pin index
 allocation
Thread-Index: AQHclTRJvDvb3vplVUWQ4ZEMM5k9sbVz0Oeg
Date: Thu, 5 Feb 2026 09:01:30 +0000
Message-ID: <LV4PR11MB9491F4542E5F9BA52D5A77309B99A@LV4PR11MB9491.namprd11.prod.outlook.com>
References: <20260203174002.705176-1-ivecera@redhat.com>
 <20260203174002.705176-5-ivecera@redhat.com>
In-Reply-To: <20260203174002.705176-5-ivecera@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV4PR11MB9491:EE_|MW4PR11MB6887:EE_
x-ms-office365-filtering-correlation-id: ec516441-b235-4d35-5a6d-08de6495270e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?ITz0aCeBGyEKp24CoH66P9W3OGY46CaMGTNH08thpeVHSRP6n60ibkK7kgM/?=
 =?us-ascii?Q?QzRkozkDlOGgzgdjbVGP52ZHQmcnjZ35Aoujz9BVQMOcIqdssXx1UEt6cpqs?=
 =?us-ascii?Q?Io6i1xPcRR1jcV9nQ8Qq2hLAP5tbpc+7PzT2bx9y1+kYnhUJnj2Q/GUAjVXi?=
 =?us-ascii?Q?xHCG355G3zxpnlJEWcNDT6YsxNjzGlUdaohaVQ4bFfbKveew2fWXQy+TkhuA?=
 =?us-ascii?Q?ARNMbxytHMfwPQewOhq60Nvt4nj2ea7FVkqGy7mP0Bx7u4PlzTo28rrxQs+P?=
 =?us-ascii?Q?F+mPUcft5e6jzl/kcpaFdf5fMRyKPW7BfUkM8rdp6boR9mT5pIbCRh6fCUDb?=
 =?us-ascii?Q?amQrEq/89CZln00RvhUXEwGZVA2RhpxYH8z8tr4HsvTXsWSrLGduKcBMe22B?=
 =?us-ascii?Q?TrLaUF4WzuhIRfollnWZqppiwUJG95xamSsU0WBb1Vd+npbc7A9EnW2gzxFm?=
 =?us-ascii?Q?2SHXd5mI7kHojlIfq7N3kIT8MypSb/TKp2WkPTq1KIRdlxtQbdoDU8DTWh0w?=
 =?us-ascii?Q?kB3SAc1hCzGr//lOfZGtUO6/7/LGsyjcVQKo/Tz8bzcykxaEfVYkeP6Zgwcp?=
 =?us-ascii?Q?9uCn84rUerkltr5hzIUycylnCrfmRemGhLlehLwLE4EeqrqVICgYNHm4BLc6?=
 =?us-ascii?Q?4BgK1f12o5stf1UjClQS/IXpTVh8fIHs2qFbNygMOK36Uq6xppM3wTqYO/Rm?=
 =?us-ascii?Q?tsnuYOR1h6PrYmY//UH4kSmbHtZnYgcwmwbFUEPmetvCBujPqKm47B8JNQie?=
 =?us-ascii?Q?vXl0IlN5P3I7q2ajTZtd4qKkqFio9cxC56biVWS0T69u1QkUCkYjOD/geMlx?=
 =?us-ascii?Q?vf9vbCLHRMFODb62A8Z+6qQ2boxij5c4A3JFhr2Xq5ejKO2edboNaTHFTJgV?=
 =?us-ascii?Q?NY810cR+nv5gbK6DR/yr4MgwbN1bd/L343EehskSxDzT1BlGywfbYkdwjG9y?=
 =?us-ascii?Q?MH725WQ+7NMCtBT91TCuDjlyjvjsAYjBeBQ4dbhhbhCb8nF4Pr36kdTBPSPa?=
 =?us-ascii?Q?tefe7uE/90YqkrM1oEkw0TgFouE6of4jbgHph8uio2iPzXhX7rUruu5yFspa?=
 =?us-ascii?Q?3w9EIPAIUOqDIwu01WoJf+tr/DY71QvYvosiDcJiRhY3HoR2igDqvKq9lock?=
 =?us-ascii?Q?jxAgRlW5BT3qE70VejzrFYsJ9TOAo//FtnkF+VZjCTy8jB0aptltwEARk2y3?=
 =?us-ascii?Q?GBIsFCXyWKZ/koeaNuIiCP8r1rhScsHVxrfhjKRAVe2XgKCVYf8G1YwjK+L1?=
 =?us-ascii?Q?loK31st3MLZIRWsk/c304125aTNxzLpwXSbWbItBpQbf7REH1dkvD1dQEVeh?=
 =?us-ascii?Q?0ZlqmwE+zZkrtu4EHC4wwWt6XabIAFRqkZFEoF4twLvdCVyXhEYCUnwartgY?=
 =?us-ascii?Q?zgvPNEQ4Aq43eB3Fuoyy5Ysb3EA002jpzn9O+Lyl8hgxRbVYsHV4eMOT9QnV?=
 =?us-ascii?Q?zHNnH84fvydhg/cJBuiDqiPNkke6hsvHy5wUeG124jzMMMaQMJgrKXiLb78D?=
 =?us-ascii?Q?ctNW0NwD+jS72LZQ7EYaO+wF6TsVjbAukUVVUBpGAlJ98ZdyStlokhXjy1cZ?=
 =?us-ascii?Q?2tipMOrgDucsANxqS1yWTNMtDiUGwOvPsb4zTHCL6571C+nznE4kJGvxVJ+X?=
 =?us-ascii?Q?QuSUEznXVaYmcBOmQ79PMhE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV4PR11MB9491.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8wz3x5aMG61+vIeCYBFV+mmb7hXpbzrNyf426LuQpzL06xMXrsroFz3I2lZn?=
 =?us-ascii?Q?qrCy2rjtTjQflbILRG7SbXARktyAeNMwkclH9ovExWBSfrYkWBeHlX4l2fzb?=
 =?us-ascii?Q?uHTixeGQvQ1X/lxz9vJULBlUPlh4Xw1oizBvEjdwHjMnF6Z8PtlXpuMFc6QY?=
 =?us-ascii?Q?IGhb+Kjyb78r04km3RxxbUj9z75pMUrYlo4O9tRhIOVItdGk3ljykWSzE2DG?=
 =?us-ascii?Q?ifENz78YSVz3pMvuOJxPK9EiRb/cMiDvmxxSMc4l5+rBObNLNxzEuiXhf6MV?=
 =?us-ascii?Q?nX6LFUjg8YkvioEMYfaaxwd4vm2HgcUnVnBpjFi/4bVcrDmBPldczG5iMNA3?=
 =?us-ascii?Q?quEyXs4D9Hy8RVLQRt51TBjD9FLP3/t7xVkjbe4Ikal8XD/O64V3P/s9w7+W?=
 =?us-ascii?Q?eu+UjNO7cdk9Dyl0HUcItc/aKo0cAcNCM/S50lRCxVwqsM3BtQTYsvRBE+S4?=
 =?us-ascii?Q?PwQN8A2E0BtAzdgs58mOnppZ2EpRmoDMYHpCPbZ7ISSbYfWc65lhsrREPGiS?=
 =?us-ascii?Q?082DlNQkOHTgIKskpyNsovPLzfMFZQbFHJyWXcHnaQ5YOAx3yaQdEHNOTLsO?=
 =?us-ascii?Q?hCqJW+cGbQUXH/r2WMq4K2pMmLt3bB3iK4plRoZbeBt74TW1u01cb9Ick8TE?=
 =?us-ascii?Q?dRW2C6f0NgSQmmCn5AT7BfpDHV6Meq6KwoeNg/4YC9QGTm0uq3PhITC6Mt9r?=
 =?us-ascii?Q?eltl6IRc7iRlX4pF3TTN0tjsO13xcasOSIzw/TveSIrL2fAIPjDXmuzJs86E?=
 =?us-ascii?Q?pQYQPU7oeB01xd/OcVy678m6PrmodcFJ/wk10pNzau7S9VP7JZwpC/6l7Lzm?=
 =?us-ascii?Q?Ak0R1DHIJpTtlPaTFd2985Mw65BUxChVHO6DDK73DFcQkPMVcqC1WlHrHtKp?=
 =?us-ascii?Q?u7o36p/FWgMdVVQs5QosjUU/JWgUl5+sfp/fINg/5IMjfURlj+R+KRo4X8Dl?=
 =?us-ascii?Q?hZloAIx3liI5na24fzeVmYISK/wqr7TugJ16XeHxRYcZyDgRvTXWWAnMWpdx?=
 =?us-ascii?Q?fjKDhtuMiYr+kmr0ug1LWksBsNaFTA6+/yDHsl8uKlvM0Ha/Y7tm68lokXTl?=
 =?us-ascii?Q?4V2bGMG9Has2jZvb/xFmJ808trCFN4KmfJT68ZJI0hDZjWRYnZxgcp/qo7+s?=
 =?us-ascii?Q?DzOPxLrMKpr+dFNfwi70iEHqOf16hSguBkoTtAeGFRoKTbQmwuzahAN9hZjE?=
 =?us-ascii?Q?ks1p9RwkDNKe8jUD+ijr7PTuHbAR4cs7OAh9KEsSF/kz9RjaAUHEN6yFG/U1?=
 =?us-ascii?Q?b8fZ+HNLvFJAesERLSZ2rELqfo09PopU0fy/F9FFgN5FrlhntfJgFCyXrLRK?=
 =?us-ascii?Q?KU0l0VddMBIjgT3VfbDb0qEWWb/dr0F6pbmYJ1NdcRK36QozV4557jiV9BSI?=
 =?us-ascii?Q?9NaV4cjylieIra1fjHgd6P9+pxm0ylMrA1ERubDwsV5cYYyvUABQv2zazKEF?=
 =?us-ascii?Q?nqDxpX3m+tYRr9P/yKVE/n6mhLfEkxV8EmeCgwf4TjsoXFuxPZC5iTxkIyf6?=
 =?us-ascii?Q?VuKt5TQ/FwZGR4Kq8QCEY/AgPqlFtYx/zRv4GrGr/cy2DfSCE2HSETisSJFr?=
 =?us-ascii?Q?ZCxKbzaoLpe2ecfdORRxwPf9CS/4b7r90a8lx3pdY3DBF8yazCOELfDHJkuQ?=
 =?us-ascii?Q?yEGonztE/5tF13TZaEg17Z3SrA5QdYAaDCIqrjgqEg2wMcZtv20OrgQf0JDX?=
 =?us-ascii?Q?zlAjUBnL+EQ9+7ZtdcvkVmRrnp/qrEooYgxjI4b4fswC2KXa3OI+zFcK9d17?=
 =?us-ascii?Q?kJK7mXfRCK8tVJrI+EQpOdDe4jDGLDI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec516441-b235-4d35-5a6d-08de6495270e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 09:01:30.0783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D35tjw8B3BrnmHcVpuvsYLoaggHsJeW1LIpCFk3THu5QV7JQU4R9EF5x+BtPZkw6X23nmMS8iP3Wd6XeCVuurspZXqWlEt0hQ9Y3Bx2qH4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6887
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-16564-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,redhat.com,microchip.com,linux.dev,lists.osuosl.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8CE43F08A1
X-Rspamd-Action: no action

>From: Ivan Vecera <ivecera@redhat.com>
>Sent: Tuesday, February 3, 2026 6:40 PM
>
>Allow drivers to register DPLL pins without manually specifying a pin
>index.
>
>Currently, drivers must provide a unique pin index when calling
>dpll_pin_get(). This works well for hardware-mapped pins but creates
>friction for drivers handling virtual pins or those without a strict
>hardware indexing scheme.
>
>Introduce DPLL_PIN_IDX_UNSPEC (U32_MAX). When a driver passes this
>value as the pin index:
>1. The core allocates a unique index using an IDA
>2. The allocated index is mapped to a range starting above `INT_MAX`
>
>This separation ensures that dynamically allocated indices never collide
>with standard driver-provided hardware indices, which are assumed to be
>within the `0` to `INT_MAX` range. The index is automatically freed when
>the pin is released in dpll_pin_put().
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

LGTM,
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>---
>v2:
>* fixed integer overflow in dpll_pin_idx_free()
>---
> drivers/dpll/dpll_core.c | 48 ++++++++++++++++++++++++++++++++++++++--
> include/linux/dpll.h     |  2 ++
> 2 files changed, 48 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index b05fe2ba46d91..59081cf2c73ae 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -10,6 +10,7 @@
>
> #include <linux/device.h>
> #include <linux/err.h>
>+#include <linux/idr.h>
> #include <linux/property.h>
> #include <linux/slab.h>
> #include <linux/string.h>
>@@ -24,6 +25,7 @@ DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
> DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
>
> static RAW_NOTIFIER_HEAD(dpll_notifier_chain);
>+static DEFINE_IDA(dpll_pin_idx_ida);
>
> static u32 dpll_device_xa_id;
> static u32 dpll_pin_xa_id;
>@@ -464,6 +466,36 @@ void dpll_device_unregister(struct dpll_device *dpll,
> }
> EXPORT_SYMBOL_GPL(dpll_device_unregister);
>
>+static int dpll_pin_idx_alloc(u32 *pin_idx)
>+{
>+	int ret;
>+
>+	if (!pin_idx)
>+		return -EINVAL;
>+
>+	/* Alloc unique number from IDA. Number belongs to <0, INT_MAX>
>range */
>+	ret =3D ida_alloc(&dpll_pin_idx_ida, GFP_KERNEL);
>+	if (ret < 0)
>+		return ret;
>+
>+	/* Map the value to dynamic pin index range <INT_MAX+1, U32_MAX> */
>+	*pin_idx =3D (u32)ret + INT_MAX + 1;
>+
>+	return 0;
>+}
>+
>+static void dpll_pin_idx_free(u32 pin_idx)
>+{
>+	if (pin_idx <=3D INT_MAX)
>+		return; /* Not a dynamic pin index */
>+
>+	/* Map the index value from dynamic pin index range to IDA range and
>+	 * free it.
>+	 */
>+	pin_idx -=3D (u32)INT_MAX + 1;
>+	ida_free(&dpll_pin_idx_ida, pin_idx);
>+}
>+
> static void dpll_pin_prop_free(struct dpll_pin_properties *prop)
> {
> 	kfree(prop->package_label);
>@@ -521,9 +553,18 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>module *module,
> 	struct dpll_pin *pin;
> 	int ret;
>
>+	if (pin_idx =3D=3D DPLL_PIN_IDX_UNSPEC) {
>+		ret =3D dpll_pin_idx_alloc(&pin_idx);
>+		if (ret)
>+			return ERR_PTR(ret);
>+	} else if (pin_idx > INT_MAX) {
>+		return ERR_PTR(-EINVAL);
>+	}
> 	pin =3D kzalloc(sizeof(*pin), GFP_KERNEL);
>-	if (!pin)
>-		return ERR_PTR(-ENOMEM);
>+	if (!pin) {
>+		ret =3D -ENOMEM;
>+		goto err_pin_alloc;
>+	}
> 	pin->pin_idx =3D pin_idx;
> 	pin->clock_id =3D clock_id;
> 	pin->module =3D module;
>@@ -551,6 +592,8 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>module *module,
> 	dpll_pin_prop_free(&pin->prop);
> err_pin_prop:
> 	kfree(pin);
>+err_pin_alloc:
>+	dpll_pin_idx_free(pin_idx);
> 	return ERR_PTR(ret);
> }
>
>@@ -654,6 +697,7 @@ void dpll_pin_put(struct dpll_pin *pin)
> 		xa_destroy(&pin->ref_sync_pins);
> 		dpll_pin_prop_free(&pin->prop);
> 		fwnode_handle_put(pin->fwnode);
>+		dpll_pin_idx_free(pin->pin_idx);
> 		kfree_rcu(pin, rcu);
> 	}
> 	mutex_unlock(&dpll_lock);
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index 8ed90dfc65f05..8fff048131f1d 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -240,6 +240,8 @@ int dpll_device_register(struct dpll_device *dpll,
>enum dpll_type type,
> void dpll_device_unregister(struct dpll_device *dpll,
> 			    const struct dpll_device_ops *ops, void *priv);
>
>+#define DPLL_PIN_IDX_UNSPEC	U32_MAX
>+
> struct dpll_pin *
> dpll_pin_get(u64 clock_id, u32 dev_driver_id, struct module *module,
> 	     const struct dpll_pin_properties *prop);
>--
>2.52.0


