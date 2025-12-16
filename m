Return-Path: <linux-rdma+bounces-15027-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EA8CC345C
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 14:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80C27302B164
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2579355033;
	Tue, 16 Dec 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iohnn4b/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42F35503B;
	Tue, 16 Dec 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891737; cv=fail; b=X9zOpG8q67+Y7EgLKf96U2FFbaF58M2QsLeAf4V9V5ipM+nfzJblt4cDMDnhO1e4gEZVs7KI/uhu3F7OMaGxZUWCOQnYYEqhBPJlSrcGqbn4O9ABKgp9ZBTBD0J5C5nh0ROi5XJu5h4uY8RclhEd71+I/paGHF5RtWYe/+Ms760=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891737; c=relaxed/simple;
	bh=JEsqCt7ekgW5nJljUl1QCympSBWgWwRNFvOV2b6a0yk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QPGU0kKKI1HmktjDTSKUqxAXr7pOa8kXDemsBGdm/0H5sFX10OKWbrWOdXjggF4IJrvVWLxA48h3YnENkD4FpGNTu/M2nu/Qry46ZK+1VZ+nqSB/AeV87p3yoOVu6Gg/QOHwzU1LloaKBGSdoWQjDs7AKggIWyKIUwEMq5UL5aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iohnn4b/; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765891734; x=1797427734;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JEsqCt7ekgW5nJljUl1QCympSBWgWwRNFvOV2b6a0yk=;
  b=Iohnn4b/LWBLAVXvS5epg1sneVIUAvAEE+HezrCmyoWQlKPJ1wQsSJ6V
   9OAzDNxk67DAiPezAL4Dj6v5rzzI2IJBTO5vjXDY49hGbBU1cdQ5r9qtY
   paMEr39AqJ1b4KxjbIMBfvrgsGQgaZkaPAQn2fXJZDUhza7m0w4agREL4
   XtEx1NyEWY3rWvK78KQVyVE5aFWiZ1XCquP8jRN0Zay1IUCd42tB0jKCr
   G6pfJIc2W60jkKEYdlMnW2qARBjEJv7DKBvS7hb+UC/zsZOVjIZ++USM9
   iDeBvpMAVrs6B9qddRdU3sjgPdHrlGeH5Ou2euXATSEkf+BmF6/8STLMl
   w==;
X-CSE-ConnectionGUID: l7L8XOykSBWXyvq7ijKTxw==
X-CSE-MsgGUID: ykdpeS8pQTWsaVQkn9VcCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="78521577"
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="78521577"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 05:28:53 -0800
X-CSE-ConnectionGUID: I8Fk90dCTyy7OMahYcGsQg==
X-CSE-MsgGUID: b/DR6UdGRVW8LPOQrSVgAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="202515419"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 05:28:52 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 05:28:51 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 16 Dec 2025 05:28:51 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 05:28:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeIqE87eCg7thByRFvZOnTZf3xVFaGfvUkVG0M30709amKIc1SOxLhljkIFvzTVl3G1BKXyUx/ClZpgqOuqdjEqXd4jMmqSmWas5aSjc/sW8vnWalgN3eXL2TCKLXLRUniPVzPY4/ZpXrJtVkEy07ISVI4FnSbq4yqdrj5mwP0A7aUAfELmZEcbqgfB/uQdmCKdqRx9nqr6jSQGtWbxul3czk936duk4NWGhgnEUnVq9uvoSNYpl8EFIR2KgUXd9jS2QW4uNYMN5A5l4GG5muFE0GzNJDcHXYHY1mS9AiNF5NYeHUcp0wolfEeuV2b9gkJ0756H7vTT0sWK90GQwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yQKXimWXuWi8SDgiynh+NVf/5oEuqAIHXzHXdAvuKo=;
 b=RhTQsfpeoopAxNk+tLF7yYLZWPHgQNedulwNRcH6PbnGVJjeB2mmR2MUy7dFmNQFnAn4Wtesbmp8r0wblqHWsvhqTQcPEVdBSVW9tSvvpYpvzZUxOGW19JF42n5yDZK01vu/6N6H2ZzVaKwzcBXAlyj0yH0mWKGenGxNiNGF0M8XIRiqKHK2+B1t5AJam789z449+Q0xXLJWrIwNqlVXT4VgiRt0qSN4KZuapUe20ba9k2ljYjNgt6dcobu5Im7LFpX0MEIQ/pQcQr+cInDr34FTKZWwLr16m2EKmJAghJ10YxbVsDlhiyk7DAikNyKOcl23I89tap+M6dY7JV+L7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB8318.namprd11.prod.outlook.com (2603:10b6:806:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 13:28:44 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 13:28:44 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Rob Herring <robh@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Richard Cochran <richardcochran@gmail.com>, "Prathosh
 Satish" <Prathosh.Satish@microchip.com>, Willem de Bruijn
	<willemb@google.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Mark Bloch
	<mbloch@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Stefan Wahren <wahrenst@gmx.net>, Simon Horman
	<horms@kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "David
 S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH RFC net-next v2 12/12] ice: dpll:
 Support E825-C SyncE and dynamic pin discovery
Thread-Topic: [Intel-wired-lan] [PATCH RFC net-next v2 12/12] ice: dpll:
 Support E825-C SyncE and dynamic pin discovery
Thread-Index: AQHcbgIQ4WK/cp1AO0OgohJw2lzmWLUkQeYg
Date: Tue, 16 Dec 2025 13:28:44 +0000
Message-ID: <IA3PR11MB8986B2F4DBD3CDBAE5753C8AE5AAA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251215203037.1324945-1-ivecera@redhat.com>
 <20251215203037.1324945-13-ivecera@redhat.com>
In-Reply-To: <20251215203037.1324945-13-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB8318:EE_
x-ms-office365-filtering-correlation-id: c4252a54-c691-44f6-95cd-08de3ca70965
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?paXJCxWHFBtetYAC1ctqnqKehcuPO3yWQ42lXB9lajrJ3OmV3WolGSjZdz0S?=
 =?us-ascii?Q?HP+lg7VCFwpdP+wfZ2xPdFJUZj2PzNE//P9f29TwvEI/kuMrmhwiaE54Lot3?=
 =?us-ascii?Q?UPtT3Ps4ZNoE+POqkPVu4peecFEizsQLEE8jWRj9Dj7JMOsdiDoNIVznKyC9?=
 =?us-ascii?Q?hICHw+5CeNVE83Qh6OyinxGMMEryZA0nXWNSMm1br26nnMNIQ5OM8XhyjhwY?=
 =?us-ascii?Q?w+m+dv2Aq5uD93dfX0fHlDK7TaZI8rRM0U8xM6vm+X/vC6DGvhz4MQCpYymJ?=
 =?us-ascii?Q?8TJF5ejJVVoY7FTdH3MDNhhUCS9fES289nrBvdXf+oCNToz6URgWkwmcARwi?=
 =?us-ascii?Q?/lqc6rQWOrectzcYlj1LXH0MKkUCKiO9B9ieRry8YY1IIG34dCzpfwxwZW+L?=
 =?us-ascii?Q?8lpbc677q8/YpC/CRVmB73dwMSoVHHnjRW4vPTcHh0UYi5F5RfGv4MiuBegv?=
 =?us-ascii?Q?PV3nbzF1J7rNId4lcESrWhVp/YvCAG0WnAJFaCN86i/2BDicyIZK7aaPUSIu?=
 =?us-ascii?Q?msERO5WDF++gFa40wpCfyFOEAm8EhyTG/T0MqAQNvvi/fqlC5hMt/Veiuq3L?=
 =?us-ascii?Q?PNmsey3dlGzcczO5tmvEOEFgqlrk2umPOwcn3GA6KRi80JFUz8vGgtTrFRyt?=
 =?us-ascii?Q?BMD7SRfSyOMB3mxndpgeXSoCJuQmfvTTWPrE0DTfLeG8K4hwd4BMT1pjussN?=
 =?us-ascii?Q?L3L/UavRJsFyU1SkBSAUxzlvETeuk5GIctj0vl0Im5QG1sBdnAcaUCoBTc9Q?=
 =?us-ascii?Q?D+yXSr3AEuCkm50parkoLsJOI50c5Uc4cfm7eW6sBdHDU0il/JCbrg/1YXQT?=
 =?us-ascii?Q?/GO/6MiypOGgi9qzT5wrB0mYoMFmdGnK1aXkqAPH9xE+7nwdJGnojhgkisao?=
 =?us-ascii?Q?93V4U4Bhb7xtaqCsfEPp2k7WbsZEag7X2NIEmztQ8jXMataXVCev0xkkqpx+?=
 =?us-ascii?Q?3W+k5Lg8YP7XbTfNEr1NYWhGsq0qjy5Ks2v7aNr2Q0/I+xIOoRGnCzSuwS2R?=
 =?us-ascii?Q?TsVxymDuKXp2YclUSpCwV4d6bKqs+PsAXpFdiVC7ZVPxKs4WNcmzT14hew9S?=
 =?us-ascii?Q?gHHM4ou+AanlmiD/FqBmqQag6w8H/gub2D1eeAWQC0IkwIZszpqmoENYocAJ?=
 =?us-ascii?Q?aP1QQ7FrKl9FrhZEKE1eIsANh/wUNxjyL8fbEug7yeIaeRwIAd73gTkvvDa8?=
 =?us-ascii?Q?HG1xNYRX20yBhV5kvof5ThNX+htDdlomU0p480WL1ovUVykgJM5F9qYEINrr?=
 =?us-ascii?Q?YMdCeM/bunoM7W3JQqowVZ3pQJJsXeqMrC7oIaaz6Y5N7OKLwj0CoabLMTHs?=
 =?us-ascii?Q?MjQ0/GClw4NmXcbragQowxe63i8Zh7+avob1m4CF9WEPwj8f87CBHtgytNvP?=
 =?us-ascii?Q?B8pnqejQzBSq8vtfLgRovEJ3rG2ceWYZ19IIN2hCoOHt5Hc8sL3YTE2+Gylx?=
 =?us-ascii?Q?vv9O5bEBJyPyTWgrGAMWBWuAh8n7Ml7J//63bT4Mw1/UPLxX8TNryY5KA0sG?=
 =?us-ascii?Q?AOJ29WJseqEbRHbGyxKgiZig5y2i7YElNP+B?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L9xfvbvvZ2F55UhBgcbN+D/MMXsFiuwNc7tFEzW7YDwlZ9gUSYLOkf5qtmSI?=
 =?us-ascii?Q?Y6KIYlBjM6RJtIJURkf8iQpXELE7I1pHGJWu9XkAx5a7XExpfbBmnkGMJkQ+?=
 =?us-ascii?Q?/aqJZfk7riJMaYlij2/vXLF6vTEh6RUIsDc69R59BUkNzPEg5DxyLqtdGl+C?=
 =?us-ascii?Q?tby37M1hpKjXcrW6eijlwvfhUurGBHHnjFSpWm0S5oEouUYbLsuUBO469e9s?=
 =?us-ascii?Q?CKH/5l0vwLCJPUqRocb8TlzcTP4tC8qoSCYXMmvLmSMOcSKkYcIknXrxKERN?=
 =?us-ascii?Q?ODoJgUZaYEjD5l0cXK8WfgJVt/g6czSvW54DrpLHxcBf8zSNAQTQjPLAu5SA?=
 =?us-ascii?Q?z4Gn5liurewX5OC3BgAB9K9YjHrA3ylmJnlwrNSzSk2/d1vGvHhwmHLxhmKC?=
 =?us-ascii?Q?MRjFmRvuuqhGr0mw2rwqUAB20ZKco5xJi1vfnDxvNXWMrJnCxC5b/QZkOsRb?=
 =?us-ascii?Q?HuIhLiOfAszlC7oE4vBNuzvxApkKIT4OfyW3s1S6rCwcKDjD1mvTxq7BInN4?=
 =?us-ascii?Q?1g4H7F0jjv+0TwlUB0u4ReI7tO+VeFOlxYhowPqurDfyuGxGqpqXflWuWHfD?=
 =?us-ascii?Q?q5YevZrwrkRj/wXbjnJznkNYSrM/f2UxNi5CXkts5El7DNuYZj2tiGA+9nog?=
 =?us-ascii?Q?lxoP+wUKQYdSPJ53BRiSg0tdDlGodbAX3jgLwYA56i2irLHfuLkAYwHVBSV3?=
 =?us-ascii?Q?87PFTZ00zMLoVud+iysZDzc4XACrsLuNOnjKZeCW6xX1DnWkK0crWOUnc1gc?=
 =?us-ascii?Q?i22prCzhOrlfPrvJ/0OujEToZtr4WMmfk3axwdBSyghC8zvuU46962SgHawd?=
 =?us-ascii?Q?ysXbsWuIF4CvrCJnZBp6bcupvCom/FksAyaZncvOEb7vVcEx30voHRZLjcfQ?=
 =?us-ascii?Q?srAKFVaw6UnnaVuaxCH9+OrgupjqgpixuzZlpRL/PJZC5GBpLEWyfRx8YUYn?=
 =?us-ascii?Q?xOz4Tg16sqp1wz+OfbNtHh9B2VAXBBqCxVGXHqt/3ubT7Dks6g8L3swfL13U?=
 =?us-ascii?Q?9NIoSgL9zSlC4d/YHMp6y9bqqKTTwlPOhI3z0q53rjOXXY7NBKxPN1Kgr7cr?=
 =?us-ascii?Q?c5gr7axcyB1yF55a2C/UqFFnzm7JCJruM3k12EHjdc+MqOil9gK1RXPMCLeJ?=
 =?us-ascii?Q?FZfRn0mizPmz1Ga6EK5oxHhim6XjDspC7PLcY+rNFAZ6Z7+c7QthnXBAdmGO?=
 =?us-ascii?Q?7vha2iZCqqoCbGNxgFOAN9F3bs0GUqmGX/Ds0DTIWmS2HYOepuXgocNefhPi?=
 =?us-ascii?Q?NCOt5aDckPNZ2zmm866mbbza9MVeoucrcZAPCKl8v+M3UjB5rORo1qSxT86B?=
 =?us-ascii?Q?lpnnb24lep7SR4akuaZeppyI1bwMKq2nvhwBAoPW6NRlDY0QcjWkSv4spN9Y?=
 =?us-ascii?Q?3Gdj7jQtigRsUVdriDwA2vBYMszLAYx9Qg7tfx6VQrsZwMG21YxIQQdfXlJM?=
 =?us-ascii?Q?XqKg5jepxAYfbAU6vgKh7Z/IzUhBDTM9M/Sh+OGmW0CQ+86IKIq60s16qn9/?=
 =?us-ascii?Q?/tU8DmtnlKqQH9NuOHGCo4Upk7E83SPzr+IjTbKUwZN77qrevO6CHJHBeIek?=
 =?us-ascii?Q?50dgRfF1GM8XhZGO3Ji1VgQws12aKWkk8f3rUTLcr+/SUDX5ZxwAanYJGIs8?=
 =?us-ascii?Q?bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4252a54-c691-44f6-95cd-08de3ca70965
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 13:28:44.7421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vwuzu6dRUfzSUOFqEjxepn7bjTHO6eDzUwPD4p/AAzvllrZ3I2q3hYS0gJVMtN9KU//CADDk2b7iWjlystjng6vct2nnXXzObMl6gl6T834=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8318
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Ivan Vecera
> Sent: Monday, December 15, 2025 9:31 PM
> To: netdev@vger.kernel.org
> Cc: Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Rob Herring <robh@kernel.org>; Leon
> Romanovsky <leon@kernel.org>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; linux-rdma@vger.kernel.org; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; intel-wired-lan@lists.osuosl.org;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> devicetree@vger.kernel.org; Conor Dooley <conor+dt@kernel.org>; Jiri
> Pirko <jiri@resnulli.us>; Richard Cochran <richardcochran@gmail.com>;
> Prathosh Satish <Prathosh.Satish@microchip.com>; Willem de Bruijn
> <willemb@google.com>; Vadim Fedorenko <vadim.fedorenko@linux.dev>;
> Mark Bloch <mbloch@nvidia.com>; linux-kernel@vger.kernel.org; Tariq
> Toukan <tariqt@nvidia.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> Stefan Wahren <wahrenst@gmx.net>; Simon Horman <horms@kernel.org>;
> Jonathan Lemon <jonathan.lemon@gmail.com>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Saeed Mahameed <saeedm@nvidia.com>; David S.
> Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH RFC net-next v2 12/12] ice: dpll:
> Support E825-C SyncE and dynamic pin discovery
>=20
> From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>=20
> Add DPLL support for the Intel E825-C Ethernet controller. Unlike
> previous
> generations (E810), the E825-C connects to the platform's DPLL
> subsystem
> via MUX pins defined in the system firmware (Device Tree/ACPI).
>=20
> Implement the following mechanisms to support this architecture:
>=20
> 1. Dynamic Pin Discovery: Use the fwnode_dpll_pin_find() helper to
>    locate the parent MUX pins defined in the firmware.
>=20
> 2. Asynchronous Registration: Since the platform DPLL driver may probe
>    independently of the network driver, utilize the DPLL notifier
> chain
>    (register_dpll_notifier). The driver listens for DPLL_PIN_CREATED
>    events to detect when the parent MUX pins become available, then
>    registers its own Recovered Clock (RCLK) and PTP (1588) pins as
> children
>    of those parents.
>=20
> 3. Hardware Configuration: Implement the specific register access
> logic
>    for E825-C CGU (Clock Generation Unit) registers (R10, R11). This
>    includes configuring the bypass MUXes and clock dividers required
> to
>    drive SyncE and PTP signals.
>=20
> 4. Split Initialization: Refactor `ice_dpll_init()` to separate the
>    static initialization path of E810 from the dynamic, firmware-
> driven
>    path required for E825-C.
>=20
> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
> Changes:
> RFC v2:
> * Fixed infinite loop in ice_dpll_pin_get_parent_num()
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c   | 961 ++++++++++++++++++-
> -
>  drivers/net/ethernet/intel/ice/ice_dpll.h   |  29 +
>  drivers/net/ethernet/intel/ice/ice_lib.c    |   3 +
>  drivers/net/ethernet/intel/ice/ice_ptp.c    |  29 +
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c |   9 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   1 +
>  drivers/net/ethernet/intel/ice/ice_tspll.c  | 223 +++++
>  drivers/net/ethernet/intel/ice/ice_tspll.h  |  14 +-
>  drivers/net/ethernet/intel/ice/ice_type.h   |   6 +
>  9 files changed, 1185 insertions(+), 90 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
> b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 4eca62688d834..443294a9bd4b3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -5,6 +5,7 @@
>  #include "ice_lib.h"
>  #include "ice_trace.h"
>  #include <linux/dpll.h>
> +#include <linux/property.h>
>=20
>  #define ICE_CGU_STATE_ACQ_ERR_THRESHOLD		50
>  #define ICE_DPLL_PIN_IDX_INVALID		0xff
> @@ -74,6 +75,7 @@ static const char * const pin_type_name[] =3D {
>=20
>  static const char * const ice_dpll_sw_pin_sma[] =3D { "SMA1", "SMA2" };
>  static const char * const ice_dpll_sw_pin_ufl[] =3D { "U.FL1", "U.FL2"
> };
> +static const char ice_dpll_pin_1588[] =3D "pin_1588";
>=20
>  static const struct dpll_pin_frequency ice_esync_range[] =3D {
>  	DPLL_PIN_FREQUENCY_RANGE(0, DPLL_PIN_FREQUENCY_1_HZ),
> @@ -528,6 +530,130 @@ ice_dpll_pin_disable(struct ice_hw *hw, struct
> ice_dpll_pin *pin,
>  	return ret;
>  }
>=20
> +/**
> + * ice_dpll_pin_store_state - updates the state of pin in SW
> bookkeeping
> + * @pin: pointer to a pin
> + * @parent: parent pin index
> + * @state: pin state (connected or disconnected)
> + */
> +static inline void
> +ice_dpll_pin_store_state(struct ice_dpll_pin *pin, int parent, bool
> state)
> +{
> +	pin->state[parent] =3D state ? DPLL_PIN_STATE_CONNECTED :
> +					DPLL_PIN_STATE_DISCONNECTED;
> +}
> +
> +/**
> + * ice_dpll_rclk_update_e825c - updates the state of rclk pin on
> e825c device
> + * @pf: private board struct
> + * @pin: pointer to a pin
> + *
> + * Update struct holding pin states info, states are separate for
> each parent
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - OK
> + * * negative - error
> + */
> +static int ice_dpll_rclk_update_e825c(struct ice_pf *pf,
> +				      struct ice_dpll_pin *pin)
> +{
> +	u8 rclk_bits;
> +	int err;
> +	u32 reg;
> +
> +	if (pf->dplls.rclk.num_parents > ICE_SYNCE_CLK_NUM)
> +		return -EINVAL;
> +
> +	err =3D ice_read_cgu_reg(&pf->hw, ICE_CGU_R10, &reg);
> +	if (err)
> +		return err;
> +	rclk_bits =3D FIELD_GET(ICE_CGU_R10_SYNCE_S_REF_CLK, reg);
> +	ice_dpll_pin_store_state(pin, ICE_SYNCE_CLK0, rclk_bits =3D=3D
> +		(pf->ptp.port.port_num +
> ICE_CGU_BYPASS_MUX_OFFSET_E825C));
> +
> +	err =3D ice_read_cgu_reg(&pf->hw, ICE_CGU_R11, &reg);
> +	if (err)
> +		return err;
> +	rclk_bits =3D FIELD_GET(ICE_CGU_R11_SYNCE_S_BYP_CLK, reg);
> +	ice_dpll_pin_store_state(pin, ICE_SYNCE_CLK1, rclk_bits =3D=3D
> +		(pf->ptp.port.port_num +
> ICE_CGU_BYPASS_MUX_OFFSET_E825C));
> +	return 0;
> +}
> +
> +/**
> + * ice_dpll_rclk_update - updates the state of rclk pin on a device
> + * @pf: private board struct
> + * @pin: pointer to a pin
> + * @port_num: port number
> + *
> + * Update struct holding pin states info, states are separate for
> each parent
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - OK
> + * * negative - error
> + */
> +static int ice_dpll_rclk_update(struct ice_pf *pf, struct
> ice_dpll_pin *pin,
> +				u8 port_num)
> +{
> +	int ret;
> +
> +	for (u8 parent =3D 0; parent < pf->dplls.rclk.num_parents;
> parent++) {
> +		ret =3D ice_aq_get_phy_rec_clk_out(&pf->hw, &parent,
> &port_num,
> +						 &pin->flags[parent], NULL);
> +		if (ret)
> +			return ret;
> +		ice_dpll_pin_store_state(pin, parent,
> +					 ICE_AQC_GET_PHY_REC_CLK_OUT_OUT_EN
> &
> +					 pin->flags[parent]);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_dpll_update_pin_1588_e825c - updates the state of clock 1588
> pin
> + * @hw: board private hw structure
> + * @pin: pointer to a pin
> + * @parent: clock source identifier
> + *
> + * Update struct holding pin states info, states are separate for
> each parent
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - OK
> + * * negative - error
> + */
> +static int ice_dpll_update_pin_1588_e825c(struct ice_hw *hw,
> +					  struct ice_dpll_pin *pin,
> +					  enum ice_synce_clk parent)
> +{
> +	u8 bits_clk;
> +	int err;
> +	u32 reg;
> +
> +	switch (parent) {
> +	case ICE_SYNCE_CLK0:
> +		err =3D ice_read_cgu_reg(hw, ICE_CGU_R10, &reg);
> +		if (err)
> +			return err;
> +		bits_clk =3D FIELD_GET(ICE_CGU_R10_SYNCE_S_REF_CLK, reg);
> +		break;
> +	case ICE_SYNCE_CLK1:
> +		err =3D ice_read_cgu_reg(hw, ICE_CGU_R11, &reg);
> +		if (err)
> +			return err;
> +		bits_clk =3D FIELD_GET(ICE_CGU_R11_SYNCE_S_BYP_CLK, reg);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	ice_dpll_pin_store_state(pin, parent, bits_clk =3D=3D
> ICE_CGU_NCOCLK);
> +
> +	return 0;
> +}
> +
>  /**
>   * ice_dpll_sw_pins_update - update status of all SW pins
>   * @pf: private board struct
> @@ -668,22 +794,14 @@ ice_dpll_pin_state_update(struct ice_pf *pf,
> struct ice_dpll_pin *pin,
>  		}
>  		break;
>  	case ICE_DPLL_PIN_TYPE_RCLK_INPUT:
> -		for (parent =3D 0; parent < pf->dplls.rclk.num_parents;
> -		     parent++) {
> -			u8 p =3D parent;
> -
> -			ret =3D ice_aq_get_phy_rec_clk_out(&pf->hw, &p,
> -							 &port_num,
> -							 &pin->flags[parent],
> -							 NULL);
> +		if (pf->hw.mac_type =3D=3D ICE_MAC_GENERIC_3K_E825) {
> +			ret =3D ice_dpll_rclk_update_e825c(pf, pin);
> +			if (ret)
> +				goto err;
> +		} else {
> +			ret =3D ice_dpll_rclk_update(pf, pin, port_num);
>  			if (ret)
>  				goto err;
> -			if (ICE_AQC_GET_PHY_REC_CLK_OUT_OUT_EN &
> -			    pin->flags[parent])
> -				pin->state[parent] =3D
> DPLL_PIN_STATE_CONNECTED;
> -			else
> -				pin->state[parent] =3D
> -					DPLL_PIN_STATE_DISCONNECTED;
>  		}
>  		break;
>  	case ICE_DPLL_PIN_TYPE_SOFTWARE:
> @@ -1842,6 +1960,40 @@ ice_dpll_phase_offset_get(const struct dpll_pin
> *pin, void *pin_priv,
>  	return 0;
>  }
>=20
> +/**
> + * ice_dpll_synce_update_e825c - setting PHY recovered clock pins on
> e825c
> + * @hw: Pointer to the HW struct
> + * @ena: true if enable, false in disable
> + * @port_num: port number
> + * @output: output pin, we have two in E825C
> + *
> + * DPLL subsystem callback. Set proper signals to recover clock from
> port.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error
> + */
> +static int ice_dpll_synce_update_e825c(struct ice_hw *hw, bool ena,
> +				       u32 port_num, enum ice_synce_clk
> output)
> +{
> +	int err;
> +
> +	/* configure the mux to deliver proper signal to DPLL from the
> MUX */
> +	err =3D ice_tspll_cfg_bypass_mux_e825c(hw, ena, port_num, output,
> false);
> +	if (err)
> +		return err;
> +
> +	err =3D ice_tspll_cfg_synce_ethdiv_e825c(hw, output);
> +	if (err)
> +		return err;
> +
> +	dev_dbg(ice_hw_to_dev(hw), "CLK_SYNCE%u recovered clock: pin
> %s\n",
> +		output, str_enabled_disabled(ena));
> +
> +	return 0;
> +}
> +
>  /**
>   * ice_dpll_output_esync_set - callback for setting embedded sync
>   * @pin: pointer to a pin
> @@ -2263,6 +2415,28 @@ ice_dpll_sw_input_ref_sync_get(const struct
> dpll_pin *pin, void *pin_priv,
>  					   state, extack);
>  }
>=20
> +static int
> +ice_dpll_pin_get_parent_num(struct ice_dpll_pin *pin,
> +			    const struct dpll_pin *parent)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < pin->num_parents; i++)
> +		if (pin->pf->dplls.inputs[pin->parent_idx[i]].pin =3D=3D
> parent)
> +			return i;
> +
> +	return -ENOENT;
> +}
> +
> +static int
> +ice_dpll_pin_get_parent_idx(struct ice_dpll_pin *pin,
> +			    const struct dpll_pin *parent)
> +{
> +	int num =3D ice_dpll_pin_get_parent_num(pin, parent);
> +
> +	return num < 0 ? num : pin->parent_idx[num];
> +}
> +
>  /**
>   * ice_dpll_rclk_state_on_pin_set - set a state on rclk pin
>   * @pin: pointer to a pin
> @@ -2286,35 +2460,97 @@ ice_dpll_rclk_state_on_pin_set(const struct
> dpll_pin *pin, void *pin_priv,
>  			       enum dpll_pin_state state,
>  			       struct netlink_ext_ack *extack)
>  {
> -	struct ice_dpll_pin *p =3D pin_priv, *parent =3D parent_pin_priv;
>  	bool enable =3D state =3D=3D DPLL_PIN_STATE_CONNECTED;
> +	struct ice_dpll_pin *p =3D pin_priv;
>  	struct ice_pf *pf =3D p->pf;
> +	struct ice_hw *hw;
>  	int ret =3D -EINVAL;
> -	u32 hw_idx;
> +	int hw_idx;
> +
> +	hw =3D &pf->hw;
>=20
>  	if (ice_dpll_is_reset(pf, extack))
>  		return -EBUSY;
>=20
>  	mutex_lock(&pf->dplls.lock);
> -	hw_idx =3D parent->idx - pf->dplls.base_rclk_idx;
> -	if (hw_idx >=3D pf->dplls.num_inputs)
> +	hw_idx =3D ice_dpll_pin_get_parent_idx(p, parent_pin);
> +	if (hw_idx < 0)
>  		goto unlock;
>=20
>  	if ((enable && p->state[hw_idx] =3D=3D DPLL_PIN_STATE_CONNECTED) ||
>  	    (!enable && p->state[hw_idx] =3D=3D
> DPLL_PIN_STATE_DISCONNECTED)) {
>  		NL_SET_ERR_MSG_FMT(extack,
>  				   "pin:%u state:%u on parent:%u already
> set",
> -				   p->idx, state, parent->idx);
> +				   p->idx, state,
> +				   ice_dpll_pin_get_parent_num(p,
> parent_pin));
>  		goto unlock;
>  	}
> -	ret =3D ice_aq_set_phy_rec_clk_out(&pf->hw, hw_idx, enable,
> -					 &p->freq);
> +
> +	ret =3D hw->mac_type =3D=3D ICE_MAC_GENERIC_3K_E825 ?
> +		ice_dpll_synce_update_e825c(hw, enable,
> +					    pf->ptp.port.port_num,
> +					    (enum ice_synce_clk)hw_idx) :
> +		ice_aq_set_phy_rec_clk_out(hw, hw_idx, enable, &p-
> >freq);
>  	if (ret)
>  		NL_SET_ERR_MSG_FMT(extack,
>  				   "err:%d %s failed to set pin state:%u
> for pin:%u on parent:%u",
>  				   ret,
> -				   libie_aq_str(pf-
> >hw.adminq.sq_last_status),
> -				   state, p->idx, parent->idx);
> +				   libie_aq_str(hw->adminq.sq_last_status),
> +				   state, p->idx,
> +				   ice_dpll_pin_get_parent_num(p,
> parent_pin));
> +unlock:
> +	mutex_unlock(&pf->dplls.lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * ice_dpll_pin_1588_state_on_pin_set - set a state on a clock 1588
> pin
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @parent_pin: pin parent pointer
> + * @parent_pin_priv: parent private data pointer passed on pin
> registration
> + * @state: state to be set on pin
> + * @extack: error reporting
> + *
> + * DPLL subsystem callback. Set a state of a clock 1588 pin on a
> parent pin
> + *
> + * Context: Acquires pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - failure
> + */
> +static int ice_dpll_pin_1588_state_on_pin_set(const struct dpll_pin
> *pin,
> +					      void *pin_priv,
> +					      const struct dpll_pin
> *parent_pin,
> +					      void *parent_pin_priv,
> +					      enum dpll_pin_state state,
> +					      struct netlink_ext_ack
> *extack)
> +{
> +	bool ena =3D state =3D=3D DPLL_PIN_STATE_CONNECTED;
> +	struct ice_dpll_pin *p =3D pin_priv;
> +	struct ice_pf *pf =3D p->pf;
> +	int ret =3D -EINVAL;
> +	int hw_idx;
> +
> +	if (ice_dpll_is_reset(pf, extack))
> +		return -EBUSY;
> +
> +	mutex_lock(&pf->dplls.lock);
> +	hw_idx =3D ice_dpll_pin_get_parent_idx(p, parent_pin);
> +	if (hw_idx < 0)
> +		goto unlock;
> +
> +	if ((ena && p->state[hw_idx] =3D=3D DPLL_PIN_STATE_CONNECTED) ||
> +	    (!ena && p->state[hw_idx] =3D=3D DPLL_PIN_STATE_DISCONNECTED))
> {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "Pin %d state on parent is already set",
> +				   ice_dpll_pin_get_parent_num(p,
> parent_pin));
> +		goto unlock;
> +	}
> +	ret =3D ice_tspll_cfg_bypass_mux_e825c(&pf->hw, ena,
> +					     pf->ptp.port.port_num,
> +					     hw_idx, true);
>  unlock:
>  	mutex_unlock(&pf->dplls.lock);
>=20
> @@ -2344,17 +2580,17 @@ ice_dpll_rclk_state_on_pin_get(const struct
> dpll_pin *pin, void *pin_priv,
>  			       enum dpll_pin_state *state,
>  			       struct netlink_ext_ack *extack)
>  {
> -	struct ice_dpll_pin *p =3D pin_priv, *parent =3D parent_pin_priv;
> +	struct ice_dpll_pin *p =3D pin_priv;
>  	struct ice_pf *pf =3D p->pf;
>  	int ret =3D -EINVAL;
> -	u32 hw_idx;
> +	int hw_idx;
>=20
>  	if (ice_dpll_is_reset(pf, extack))
>  		return -EBUSY;
>=20
>  	mutex_lock(&pf->dplls.lock);
> -	hw_idx =3D parent->idx - pf->dplls.base_rclk_idx;
> -	if (hw_idx >=3D pf->dplls.num_inputs)
> +	hw_idx =3D ice_dpll_pin_get_parent_idx(p, parent_pin);
> +	if (hw_idx < 0)
>  		goto unlock;
>=20
>  	ret =3D ice_dpll_pin_state_update(pf, p,
> ICE_DPLL_PIN_TYPE_RCLK_INPUT,
> @@ -2370,12 +2606,65 @@ ice_dpll_rclk_state_on_pin_get(const struct
> dpll_pin *pin, void *pin_priv,
>  	return ret;
>  }
>=20
> +/**
> + * ice_dpll_pin_1588_state_on_pin_get - get a state of a 1588 clock
> pin
> + * @pin: pointer to a pin
> + * @pin_priv: private data pointer passed on pin registration
> + * @parent_pin: pin parent pointer
> + * @parent_pin_priv: pin parent priv data pointer passed on pin
> registration
> + * @state: on success holds pin state on parent pin
> + * @extack: error reporting
> + *
> + * DPLL subsystem callback, get a state of a 1588 clock pin.
> + *
> + * Context: Acquires pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - failure
> + */
> +static int
> +ice_dpll_pin_1588_state_on_pin_get(const struct dpll_pin *pin, void
> *pin_priv,
> +				   const struct dpll_pin *parent_pin,
> +				   void *parent_pin_priv,
> +				   enum dpll_pin_state *state,
> +				   struct netlink_ext_ack *extack)
> +{
> +	struct ice_dpll_pin *p =3D pin_priv;
> +	struct ice_pf *pf =3D p->pf;
> +	int ret =3D -EINVAL;
> +	int hw_idx;
> +
> +	if (ice_dpll_is_reset(pf, extack))
> +		return -EBUSY;
> +
> +	mutex_lock(&pf->dplls.lock);
> +	hw_idx =3D ice_dpll_pin_get_parent_idx(p, parent_pin);
> +	if (hw_idx < 0)
> +		goto unlock;
> +
> +	ret =3D ice_dpll_update_pin_1588_e825c(&pf->hw, p,
> +					     (enum ice_synce_clk)hw_idx);
> +	if (ret)
> +		goto unlock;
> +	*state =3D p->state[hw_idx];
> +unlock:
> +	mutex_unlock(&pf->dplls.lock);
> +
> +	return ret;
> +}
> +
>  static const struct dpll_pin_ops ice_dpll_rclk_ops =3D {
>  	.state_on_pin_set =3D ice_dpll_rclk_state_on_pin_set,
>  	.state_on_pin_get =3D ice_dpll_rclk_state_on_pin_get,
>  	.direction_get =3D ice_dpll_input_direction,
>  };
>=20
> +static const struct dpll_pin_ops ice_dpll_pin_1588_ops =3D {
> +	.direction_get =3D ice_dpll_input_direction,
> +	.state_on_pin_get =3D ice_dpll_pin_1588_state_on_pin_get,
> +	.state_on_pin_set =3D ice_dpll_pin_1588_state_on_pin_set,
> +};
> +
>  static const struct dpll_pin_ops ice_dpll_pin_sma_ops =3D {
>  	.state_on_dpll_set =3D ice_dpll_sma_pin_state_set,
>  	.state_on_dpll_get =3D ice_dpll_sw_pin_state_get,
> @@ -2814,7 +3103,8 @@ static void ice_dpll_release_pins(struct
> ice_dpll_pin *pins, int count)
>  	int i;
>=20
>  	for (i =3D 0; i < count; i++)
> -		dpll_pin_put(pins[i].pin, &pins[i].tracker);
> +		if (!IS_ERR_OR_NULL(pins[i].pin))
> +			dpll_pin_put(pins[i].pin, &pins[i].tracker);
>  }
>=20
>  /**
> @@ -2836,10 +3126,14 @@ static int
>  ice_dpll_get_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
>  		  int start_idx, int count, u64 clock_id)
>  {
> +	u32 pin_index;
>  	int i, ret;
>=20
>  	for (i =3D 0; i < count; i++) {
> -		pins[i].pin =3D dpll_pin_get(clock_id, i + start_idx,
> THIS_MODULE,
> +		pin_index =3D start_idx;
> +		if (start_idx !=3D DPLL_PIN_IDX_UNSPEC)
> +			pin_index +=3D i;
> +		pins[i].pin =3D dpll_pin_get(clock_id, pin_index,
> THIS_MODULE,
>  					   &pins[i].prop, &pins[i].tracker);
>  		if (IS_ERR(pins[i].pin)) {
>  			ret =3D PTR_ERR(pins[i].pin);
> @@ -2944,6 +3238,7 @@ ice_dpll_register_pins(struct dpll_device *dpll,
> struct ice_dpll_pin *pins,
>=20
>  /**
>   * ice_dpll_deinit_direct_pins - deinitialize direct pins
> + * @pf: board private structure
>   * @cgu: if cgu is present and controlled by this NIC
>   * @pins: pointer to pins array
>   * @count: number of pins
> @@ -2955,7 +3250,8 @@ ice_dpll_register_pins(struct dpll_device *dpll,
> struct ice_dpll_pin *pins,
>   * Release pins resources to the dpll subsystem.
>   */
>  static void
> -ice_dpll_deinit_direct_pins(bool cgu, struct ice_dpll_pin *pins, int
> count,
> +ice_dpll_deinit_direct_pins(struct ice_pf *pf, bool cgu,
> +			    struct ice_dpll_pin *pins, int count,
>  			    const struct dpll_pin_ops *ops,
>  			    struct dpll_device *first,
>  			    struct dpll_device *second)
> @@ -3014,6 +3310,30 @@ ice_dpll_init_direct_pins(struct ice_pf *pf,
> bool cgu,
>  	return ret;
>  }
>=20
> +/**
> + * ice_dpll_deinit_pin_1588 - release 1588 pin resources
> + * @pf: board private structure
> + *
> + * Deregister 1588 pin from parent pins and release resources in DPLL
> + * subsystem.
> + */
> +static void ice_dpll_deinit_pin_1588(struct ice_pf *pf)
> +{
> +	struct ice_dpll_pin *pin_1588 =3D &pf->dplls.pin_1588;
> +	struct ice_dpll_pin *parent;
> +	int i;
> +
> +	for (i =3D 0; i < pin_1588->num_parents; i++) {
> +		parent =3D &pf->dplls.inputs[pin_1588->parent_idx[i]];
> +		if (IS_ERR_OR_NULL(parent->pin))
> +			continue;
> +		dpll_pin_on_pin_unregister(parent->pin, pin_1588->pin,
> +					   &ice_dpll_pin_1588_ops,
> +					   pin_1588);
> +	}
> +
> +	dpll_pin_put(pin_1588->pin, &pin_1588->tracker);
> +}
>  /**
>   * ice_dpll_deinit_rclk_pin - release rclk pin resources
>   * @pf: board private structure
> @@ -3024,14 +3344,18 @@ static void ice_dpll_deinit_rclk_pin(struct
> ice_pf *pf)
>  {
>  	struct ice_dpll_pin *rclk =3D &pf->dplls.rclk;
>  	struct ice_vsi *vsi =3D ice_get_main_vsi(pf);
> -	struct dpll_pin *parent;
> +	struct ice_dpll_pin *parent;
>  	int i;
>=20
> +	if (pf->hw.mac_type =3D=3D ICE_MAC_GENERIC_3K_E825 &&
> +	    ice_pf_src_tmr_owned(pf))
> +		ice_dpll_deinit_pin_1588(pf);
> +
>  	for (i =3D 0; i < rclk->num_parents; i++) {
> -		parent =3D pf->dplls.inputs[rclk->parent_idx[i]].pin;
> -		if (!parent)
> +		parent =3D &pf->dplls.inputs[rclk->parent_idx[i]];
> +		if (IS_ERR_OR_NULL(parent->pin))
>  			continue;
> -		dpll_pin_on_pin_unregister(parent, rclk->pin,
> +		dpll_pin_on_pin_unregister(parent->pin, rclk->pin,
>  					   &ice_dpll_rclk_ops, rclk);
>  	}
>  	if (WARN_ON_ONCE(!vsi || !vsi->netdev))
> @@ -3040,60 +3364,262 @@ static void ice_dpll_deinit_rclk_pin(struct
> ice_pf *pf)
>  	dpll_pin_put(rclk->pin, &rclk->tracker);
>  }
>=20
> +static bool ice_dpll_is_fwnode_pin(struct ice_dpll_pin *pin)
> +{
> +	return !IS_ERR_OR_NULL(pin->fwnode);
> +}
> +
> +static void ice_dpll_pin_notify_work(struct work_struct *work)
> +{
> +	struct ice_dpll_pin_work *w =3D container_of(work,
> +						   struct ice_dpll_pin_work,
> +						   work);
> +	struct ice_dpll_pin *pin, *parent =3D w->pin;
> +	struct ice_pf *pf =3D parent->pf;
> +	int ret;
> +
> +	switch (w->action) {
> +	case DPLL_PIN_CREATED:
> +		if (!IS_ERR_OR_NULL(parent->pin)) {
> +			/* We have already our pin registered */
> +			goto out;
> +		}
> +
> +		/* Grab reference on fwnode pin */
> +		parent->pin =3D fwnode_dpll_pin_find(parent->fwnode,
> +						   &parent->tracker);
> +		if (IS_ERR_OR_NULL(parent->pin)) {
> +			dev_err(ice_pf_to_dev(pf),
> +				"Cannot get fwnode pin reference\n");
> +			goto out;
> +		}
> +
> +		/* Register 1588 pin */
> +		if (ice_pf_src_tmr_owned(pf)) {
> +			pin =3D &pf->dplls.pin_1588;
> +			ret =3D dpll_pin_on_pin_register(parent->pin, pin-
> >pin,
> +
> &ice_dpll_pin_1588_ops,
> +						       pin);
> +			if (ret) {
> +				dev_err(ice_pf_to_dev(pf),
> +					"Failed to register pin: %pe\n",
> +					ERR_PTR(ret));
> +				dpll_pin_put(parent->pin, &parent-
> >tracker);
> +				parent->pin =3D NULL;
> +				goto out;
> +			}
> +		}
> +
> +		/* Register rclk pin */
> +		pin =3D &pf->dplls.rclk;
> +		ret =3D dpll_pin_on_pin_register(parent->pin, pin->pin,
> +					       &ice_dpll_rclk_ops, pin);
> +		if (ret) {
> +			dev_err(ice_pf_to_dev(pf),
> +				"Failed to register pin: %pe\n",
> ERR_PTR(ret));
> +			dpll_pin_on_pin_unregister(parent->pin,
> +						   pf->dplls.pin_1588.pin,
> +						   &ice_dpll_pin_1588_ops,
> +						   &pf->dplls.pin_1588);
> +			dpll_pin_put(parent->pin, &parent->tracker);
> +			parent->pin =3D NULL;
> +			goto out;
> +		}
> +		break;
> +	case DPLL_PIN_DELETED:
> +		if (IS_ERR_OR_NULL(parent->pin)) {
> +			/* We have already our pin unregistered */
> +			goto out;
> +		}
> +
> +		/* Unregister 1588 pin */
> +		if (ice_pf_src_tmr_owned(pf)) {
> +			pin =3D &pf->dplls.pin_1588;
> +
> +			dpll_pin_on_pin_unregister(parent->pin, pin->pin,
> +						   &ice_dpll_pin_1588_ops,
> pin);
> +		}
> +
> +		/* Register rclk pin */
> +		pin =3D &pf->dplls.rclk;
> +		dpll_pin_on_pin_unregister(parent->pin, pin->pin,
> +					   &ice_dpll_rclk_ops, pin);
> +
> +		/* Drop fwnode pin reference */
> +		dpll_pin_put(parent->pin, &parent->tracker);
> +		parent->pin =3D NULL;
> +		break;
> +	default:
> +		break;
> +	}
> +out:
> +	kfree(work);
It looks like you free the embedded work_struct pointer instead of the allo=
cated ice_dpll_pin_work container @ice_dpll_pin_notify().
Isn't it?

> +}
> +
> +static int ice_dpll_pin_notify(struct notifier_block *nb, unsigned
> long action,
> +			       void *data)
> +{
> +	struct ice_dpll_pin *pin =3D container_of(nb, struct
> ice_dpll_pin, nb);
> +	struct dpll_pin_notifier_info *info =3D data;
> +	struct ice_dpll_pin_work *work;
> +
> +	if (action !=3D DPLL_PIN_CREATED && action !=3D DPLL_PIN_DELETED)
> +		return NOTIFY_DONE;
> +
> +	/* Check if the reported pin is this one */
> +	if (pin->fwnode !=3D info->fwnode)
> +		return NOTIFY_DONE; /* Not this pin */
> +
> +	work =3D kzalloc(sizeof(*work), GFP_KERNEL);
> +	if (!work)
> +		return NOTIFY_DONE;
> +
> +	INIT_WORK(&work->work, ice_dpll_pin_notify_work);
> +	work->action =3D action;
> +	work->pin =3D pin;
> +
> +	queue_work(pin->pf->dplls.wq, &work->work);
> +
> +	return NOTIFY_OK;
> +}
> +
>  /**
> - * ice_dpll_init_rclk_pins - initialize recovered clock pin
> + * ice_dpll_init_pin_common - initialize pin
>   * @pf: board private structure
>   * @pin: pin to register
>   * @start_idx: on which index shall allocation start in dpll
> subsystem
>   * @ops: callback ops registered with the pins
>   *
> - * Allocate resource for recovered clock pin in dpll subsystem.
> Register the
> - * pin with the parents it has in the info. Register pin with the
> pf's main vsi
> - * netdev.
> + * Allocate resource for given pin in dpll subsystem. Register the
> pin with
> + * the parents it has in the info.
>   *
>   * Return:
>   * * 0 - success
>   * * negative - registration failure reason
>   */
>  static int
> -ice_dpll_init_rclk_pins(struct ice_pf *pf, struct ice_dpll_pin *pin,
> -			int start_idx, const struct dpll_pin_ops *ops)
> +ice_dpll_init_pin_common(struct ice_pf *pf, struct ice_dpll_pin *pin,
> +			 int start_idx, const struct dpll_pin_ops *ops)
>  {
>  	struct ice_vsi *vsi =3D ice_get_main_vsi(pf);
> -	struct dpll_pin *parent;
> +	struct ice_dpll_pin *parent;
>  	int ret, i;
>=20
>  	if (WARN_ON((!vsi || !vsi->netdev)))
>  		return -EINVAL;
> -	ret =3D ice_dpll_get_pins(pf, pin, start_idx,
> ICE_DPLL_RCLK_NUM_PER_PF,
> -				pf->dplls.clock_id);
> +
> +	ret =3D ice_dpll_get_pins(pf, pin, start_idx, 1, pf-
> >dplls.clock_id);
>  	if (ret)
>  		return ret;
> -	for (i =3D 0; i < pf->dplls.rclk.num_parents; i++) {
> -		parent =3D pf->dplls.inputs[pf-
> >dplls.rclk.parent_idx[i]].pin;
> -		if (!parent) {
> -			ret =3D -ENODEV;
> -			goto unregister_pins;
> +
> +	for (i =3D 0; i < pin->num_parents; i++) {
> +		parent =3D &pf->dplls.inputs[pin->parent_idx[i]];
> +		if (IS_ERR_OR_NULL(parent->pin)) {
> +			if (!ice_dpll_is_fwnode_pin(parent)) {
> +				ret =3D -ENODEV;
> +				goto unregister_pins;
> +			}
> +			parent->pin =3D fwnode_dpll_pin_find(parent-
> >fwnode,
> +							   &parent->tracker);
> +			if (IS_ERR_OR_NULL(parent->pin)) {
> +				dev_info(ice_pf_to_dev(pf),
> +					 "Mux pin not registered yet\n");
> +				continue;
> +			}
>  		}
> -		ret =3D dpll_pin_on_pin_register(parent, pf-
> >dplls.rclk.pin,
> -					       ops, &pf->dplls.rclk);
> +		ret =3D dpll_pin_on_pin_register(parent->pin, pin->pin,
> ops, pin);
>  		if (ret)
>  			goto unregister_pins;
>  	}
> -	dpll_netdev_pin_set(vsi->netdev, pf->dplls.rclk.pin);
>=20
>  	return 0;
>=20
>  unregister_pins:
>  	while (i) {
> -		parent =3D pf->dplls.inputs[pf->dplls.rclk.parent_idx[--
> i]].pin;
> -		dpll_pin_on_pin_unregister(parent, pf->dplls.rclk.pin,
> -					   &ice_dpll_rclk_ops, &pf-
> >dplls.rclk);
> +		parent =3D &pf->dplls.inputs[pin->parent_idx[--i]];
> +		if (IS_ERR_OR_NULL(parent->pin))
> +			continue;
> +		dpll_pin_on_pin_unregister(parent->pin, pin->pin, ops,
> pin);
>  	}
> -	ice_dpll_release_pins(pin, ICE_DPLL_RCLK_NUM_PER_PF);
> +	ice_dpll_release_pins(pin, 1);
> +
>  	return ret;
>  }
>=20
> +/**
> + * ice_dpll_init_rclk_pin - initialize recovered clock pin
> + * @pf: board private structure
> + * @start_idx: on which index shall allocation start in dpll
> subsystem
> + * @ops: callback ops registered with the pins
> + *
> + * Allocate resource for recovered clock pin in dpll subsystem.
> Register the
> + * pin with the parents it has in the info.
> + *
> + * Return:
> + * * 0 - success
> + * * negative - registration failure reason
> + */
> +static int
> +ice_dpll_init_rclk_pin(struct ice_pf *pf, int start_idx,
> +		       const struct dpll_pin_ops *ops)
> +{
> +	struct ice_vsi *vsi =3D ice_get_main_vsi(pf);
> +	int ret;
> +
> +	ret =3D ice_dpll_init_pin_common(pf, &pf->dplls.rclk, start_idx,
> ops);
> +	if (ret)
> +		return ret;
> +
> +	dpll_netdev_pin_set(vsi->netdev, pf->dplls.rclk.pin);
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_dpll_init_pin_1588 - initialize pin to control clock 1588
> + * @pf: board private structure
> + * @start_idx: on which index shall allocation start in dpll
> subsystem
> + * @ops: callback ops registered with the pins
> + *
> + * Allocate resource for clock 1588 pin in DPLL subsystem. Register
> the
> + * pin with the parents it has in the info.
> + *
> + * Return:
> + * * 0 - success
> + * * negative - registration failure reason
> + */
> +static int
> +ice_dpll_init_pin_1588(struct ice_pf *pf, int start_idx,
> +		       const struct dpll_pin_ops *ops)
> +{
> +	return ice_dpll_init_pin_common(pf, &pf->dplls.pin_1588,
> start_idx,
> +					ops);
> +}
> +
> +static void
> +ice_dpll_deinit_fwnode_pin(struct ice_dpll_pin *pin)
> +{
> +	unregister_dpll_notifier(&pin->nb);
> +	flush_workqueue(pin->pf->dplls.wq);
> +	if (!IS_ERR_OR_NULL(pin->pin)) {
> +		dpll_pin_put(pin->pin, &pin->tracker);
> +		pin->pin =3D NULL;
> +	}
> +	fwnode_handle_put(pin->fwnode);
> +	pin->fwnode =3D NULL;
> +}
> +
> +static void
> +ice_dpll_deinit_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin
> *pins,
> +			    int start_idx)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < pf->dplls.rclk.num_parents; i++)
> +		ice_dpll_deinit_fwnode_pin(&pins[start_idx + i]);
> +	destroy_workqueue(pf->dplls.wq);
> +}
> +
>  /**
>   * ice_dpll_deinit_pins - deinitialize direct pins
>   * @pf: board private structure
> @@ -3113,6 +3639,8 @@ static void ice_dpll_deinit_pins(struct ice_pf
> *pf, bool cgu)
>  	struct ice_dpll *dp =3D &d->pps;
>=20
>  	ice_dpll_deinit_rclk_pin(pf);
> +	if (pf->hw.mac_type =3D=3D ICE_MAC_GENERIC_3K_E825)
> +		ice_dpll_deinit_fwnode_pins(pf, pf->dplls.inputs, 0);
>  	if (cgu) {
>  		ice_dpll_unregister_pins(dp->dpll, inputs,
> &ice_dpll_input_ops,
>  					 num_inputs);
> @@ -3127,12 +3655,12 @@ static void ice_dpll_deinit_pins(struct ice_pf
> *pf, bool cgu)
>  					 &ice_dpll_output_ops, num_outputs);
>  		ice_dpll_release_pins(outputs, num_outputs);
>  		if (!pf->dplls.generic) {
> -			ice_dpll_deinit_direct_pins(cgu, pf->dplls.ufl,
> +			ice_dpll_deinit_direct_pins(pf, cgu, pf-
> >dplls.ufl,
>  						    ICE_DPLL_PIN_SW_NUM,
>  						    &ice_dpll_pin_ufl_ops,
>  						    pf->dplls.pps.dpll,
>  						    pf->dplls.eec.dpll);
> -			ice_dpll_deinit_direct_pins(cgu, pf->dplls.sma,
> +			ice_dpll_deinit_direct_pins(pf, cgu, pf-
> >dplls.sma,
>  						    ICE_DPLL_PIN_SW_NUM,
>  						    &ice_dpll_pin_sma_ops,
>  						    pf->dplls.pps.dpll,
> @@ -3141,6 +3669,133 @@ static void ice_dpll_deinit_pins(struct ice_pf
> *pf, bool cgu)
>  	}
>  }
>=20
> +static int
> +ice_dpll_init_fwnode_pin(struct ice_dpll_pin *pin, const char *name)
> +{
> +	struct ice_pf *pf =3D pin->pf;
> +	int ret;
> +
> +	pin->fwnode =3D device_get_dpll_pin_node(&pf->pdev->dev, name);
> +	if (IS_ERR(pin->fwnode)) {
> +		dev_err(ice_pf_to_dev(pf),
> +			"Failed to find %s firmware node: %pe\n", name,
> +			pin->fwnode);
> +		pin->fwnode =3D NULL;
> +		return -ENODEV;
> +	}
> +
> +	dev_dbg(ice_pf_to_dev(pf), "Found fwnode node for %s\n", name);
> +
> +	pin->pin =3D fwnode_dpll_pin_find(pin->fwnode, &pin->tracker);
> +	if (IS_ERR_OR_NULL(pin->pin)) {
> +		dev_info(ice_pf_to_dev(pf),
> +			 "DPLL pin for %pfwp not registered yet\n",
> +			 pin->fwnode);
> +		pin->pin =3D NULL;
> +	}
> +
> +	pin->nb.notifier_call =3D ice_dpll_pin_notify;
> +	ret =3D register_dpll_notifier(&pin->nb);
> +	if (ret) {
> +		dev_err(ice_pf_to_dev(pf),
> +			"Failed to subscribe for DPLL notifications\n");
> +
> +		if (!IS_ERR_OR_NULL(pin->pin)) {
> +			dpll_pin_put(pin->pin, &pin->tracker);
> +			pin->pin =3D NULL;
> +		}
> +		fwnode_handle_put(pin->fwnode);
> +		pin->fwnode =3D NULL;
> +
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * ice_dpll_init_fwnode_pins - initialize pins from device tree
> + * @pf: board private structure
> + * @pins: pointer to pins array
> + * @start_idx: starting index for pins
> + * @count: number of pins to initialize
> + *
> + * Initialize input pins for E825 RCLK support. The parent pins
> (rclk0, rclk1)
> + * are expected to be defined in the device tree (ACPI). This
> function allocates
> + * them in the dpll subsystem and stores their indices for later
> registration
> + * with the rclk pin.
> + *
> + * Return:
> + * * 0 - success
> + * * negative - initialization failure reason
> + */
> +static int
> +ice_dpll_init_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin
> *pins,
> +			  int start_idx)
> +{
> +	char pin_name[8];
> +	int i, ret;
> +
> +	pf->dplls.wq =3D create_singlethread_workqueue("ice_dpll_wq");
> +	if (!pf->dplls.wq)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < pf->dplls.rclk.num_parents; i++) {
> +		pins[start_idx + i].pf =3D pf;
> +		snprintf(pin_name, sizeof(pin_name), "rclk%u", i);
> +		ret =3D ice_dpll_init_fwnode_pin(&pins[start_idx + i],
> pin_name);
> +		if (ret)
> +			goto error;
> +	}
> +
> +	return 0;
> +error:
> +	while (i--)
> +		ice_dpll_deinit_fwnode_pin(&pins[start_idx + i]);
> +
> +	destroy_workqueue(pf->dplls.wq);
> +
> +	return ret;
> +}
> +
> +/**
> + * ice_dpll_init_pins_e825 - init pins and register pins with a dplls
> + * @pf: board private structure
> + * @cgu: if cgu is present and controlled by this NIC
> + *
> + * Initialize directly connected pf's pins within pf's dplls in a
> Linux dpll
> + * subsystem.
> + *
> + * Return:
> + * * 0 - success
> + * * negative - initialization failure reason
> + */
> +static int ice_dpll_init_pins_e825(struct ice_pf *pf)
> +{
> +	int ret;
> +
> +	pf->dplls.num_inputs =3D pf->dplls.rclk.num_parents;
> +	ret =3D ice_dpll_init_fwnode_pins(pf, pf->dplls.inputs, 0);
> +	if (ret)
> +		return ret;
> +	if (ice_pf_src_tmr_owned(pf)) {
> +		ret =3D ice_dpll_init_pin_1588(pf, DPLL_PIN_IDX_UNSPEC,
> +					     &ice_dpll_pin_1588_ops);
> +		if (ret)
> +			return ret;
> +	}
> +	ret =3D ice_dpll_init_rclk_pin(pf, DPLL_PIN_IDX_UNSPEC,
> +				     &ice_dpll_rclk_ops);
> +	if (ret)
> +		goto deinit_1588;
> +
> +	return 0;
> +deinit_1588:
> +	if (ice_pf_src_tmr_owned(pf))
> +		ice_dpll_deinit_pin_1588(pf);
> +	return ret;
> +}
> +
>  /**
>   * ice_dpll_init_pins - init pins and register pins with a dplls
>   * @pf: board private structure
> @@ -3155,21 +3810,24 @@ static void ice_dpll_deinit_pins(struct ice_pf
> *pf, bool cgu)
>   */
>  static int ice_dpll_init_pins(struct ice_pf *pf, bool cgu)
>  {
> +	const struct dpll_pin_ops *output_ops;
> +	const struct dpll_pin_ops *input_ops;
>  	int ret, count;
>=20
> +	input_ops =3D &ice_dpll_input_ops;
> +	output_ops =3D &ice_dpll_output_ops;
> +
>  	ret =3D ice_dpll_init_direct_pins(pf, cgu, pf->dplls.inputs, 0,
> -					pf->dplls.num_inputs,
> -					&ice_dpll_input_ops,
> -					pf->dplls.eec.dpll, pf-
> >dplls.pps.dpll);
> +					pf->dplls.num_inputs, input_ops,
> +					pf->dplls.eec.dpll,
> +					pf->dplls.pps.dpll);
>  	if (ret)
>  		return ret;
>  	count =3D pf->dplls.num_inputs;
>  	if (cgu) {
>  		ret =3D ice_dpll_init_direct_pins(pf, cgu, pf-
> >dplls.outputs,
> -						count,
> -						pf->dplls.num_outputs,
> -						&ice_dpll_output_ops,
> -						pf->dplls.eec.dpll,
> +						count, pf->dplls.num_outputs,
> +						output_ops, pf-
> >dplls.eec.dpll,
>  						pf->dplls.pps.dpll);
>  		if (ret)
>  			goto deinit_inputs;
> @@ -3205,30 +3863,30 @@ static int ice_dpll_init_pins(struct ice_pf
> *pf, bool cgu)
>  	} else {
>  		count +=3D pf->dplls.num_outputs + 2 *
> ICE_DPLL_PIN_SW_NUM;
>  	}
> -	ret =3D ice_dpll_init_rclk_pins(pf, &pf->dplls.rclk, count + pf-
> >hw.pf_id,
> -				      &ice_dpll_rclk_ops);
> +
> +	ret =3D ice_dpll_init_rclk_pin(pf, count + pf->ptp.port.port_num,
> +				     &ice_dpll_rclk_ops);
>  	if (ret)
>  		goto deinit_ufl;
>=20
>  	return 0;
>  deinit_ufl:
> -	ice_dpll_deinit_direct_pins(cgu, pf->dplls.ufl,
> -				    ICE_DPLL_PIN_SW_NUM,
> -				    &ice_dpll_pin_ufl_ops,
> -				    pf->dplls.pps.dpll, pf-
> >dplls.eec.dpll);
> +	ice_dpll_deinit_direct_pins(pf, cgu, pf->dplls.ufl,
> ICE_DPLL_PIN_SW_NUM,
> +				    &ice_dpll_pin_ufl_ops, pf-
> >dplls.pps.dpll,
> +				    pf->dplls.eec.dpll);
>  deinit_sma:
> -	ice_dpll_deinit_direct_pins(cgu, pf->dplls.sma,
> -				    ICE_DPLL_PIN_SW_NUM,
> -				    &ice_dpll_pin_sma_ops,
> -				    pf->dplls.pps.dpll, pf-
> >dplls.eec.dpll);
> +	ice_dpll_deinit_direct_pins(pf, cgu, pf->dplls.sma,
> ICE_DPLL_PIN_SW_NUM,
> +				    &ice_dpll_pin_sma_ops, pf-
> >dplls.pps.dpll,
> +				    pf->dplls.eec.dpll);
>  deinit_outputs:
> -	ice_dpll_deinit_direct_pins(cgu, pf->dplls.outputs,
> +	ice_dpll_deinit_direct_pins(pf, cgu, pf->dplls.outputs,
>  				    pf->dplls.num_outputs,
> -				    &ice_dpll_output_ops, pf-
> >dplls.pps.dpll,
> +				    output_ops, pf->dplls.pps.dpll,
>  				    pf->dplls.eec.dpll);
>  deinit_inputs:
> -	ice_dpll_deinit_direct_pins(cgu, pf->dplls.inputs, pf-
> >dplls.num_inputs,
> -				    &ice_dpll_input_ops, pf-
> >dplls.pps.dpll,
> +	ice_dpll_deinit_direct_pins(pf, cgu, pf->dplls.inputs,
> +				    pf->dplls.num_inputs,
> +				    input_ops, pf->dplls.pps.dpll,
>  				    pf->dplls.eec.dpll);
>  	return ret;
>  }
> @@ -3239,8 +3897,8 @@ static int ice_dpll_init_pins(struct ice_pf *pf,
> bool cgu)
>   * @d: pointer to ice_dpll
>   * @cgu: if cgu is present and controlled by this NIC
>   *
> - * If cgu is owned unregister the dpll from dpll subsystem.
> - * Release resources of dpll device from dpll subsystem.
> + * If cgu is owned, unregister the DPL from DPLL subsystem.
> + * Release resources of DPLL device from DPLL subsystem.
>   */
>  static void
>  ice_dpll_deinit_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
> @@ -3257,8 +3915,8 @@ ice_dpll_deinit_dpll(struct ice_pf *pf, struct
> ice_dpll *d, bool cgu)
>   * @cgu: if cgu is present and controlled by this NIC
>   * @type: type of dpll being initialized
>   *
> - * Allocate dpll instance for this board in dpll subsystem, if cgu is
> controlled
> - * by this NIC, register dpll with the callback ops.
> + * Allocate DPLL instance for this board in dpll subsystem, if cgu is
> controlled
> + * by this NIC, register DPLL with the callback ops.
>   *
>   * Return:
>   * * 0 - success
> @@ -3289,6 +3947,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct
> ice_dpll *d, bool cgu,
>  		ret =3D dpll_device_register(d->dpll, type, ops, d);
>  		if (ret) {
>  			dpll_device_put(d->dpll, &d->tracker);
> +			d->dpll =3D NULL;
>  			return ret;
>  		}
>  		d->ops =3D ops;
> @@ -3506,6 +4165,32 @@ ice_dpll_init_info_direct_pins(struct ice_pf
> *pf,
>  	return ret;
>  }
>=20
> +/**
> + * ice_dpll_init_info_pin_on_pin_e825c - initializes rclk pin
> information
> + * @pf: board private structure
> + *
> + * Init information for rclk pin, cache them in pf->dplls.rclk and
> + * pf->dplls.pin_1588.
> + *
> + * Return:
> + * * 0 - success
> + */
> +static int ice_dpll_init_info_pin_on_pin_e825c(struct ice_pf *pf)
> +{
> +	struct ice_dpll_pin *pin_1588 =3D &pf->dplls.pin_1588;
> +	struct ice_dpll_pin *rclk_pin =3D &pf->dplls.rclk;
> +
> +	rclk_pin->prop.type =3D DPLL_PIN_TYPE_SYNCE_ETH_PORT;
> +	rclk_pin->prop.capabilities |=3D
> DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
> +	rclk_pin->pf =3D pf;
> +	pin_1588->prop.type =3D DPLL_PIN_TYPE_EXT;
> +	pin_1588->prop.capabilities |=3D
> DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
> +	pin_1588->prop.board_label =3D ice_dpll_pin_1588;
> +	pin_1588->pf =3D pf;
> +
> +	return 0;
> +}
> +
>  /**
>   * ice_dpll_init_info_rclk_pin - initializes rclk pin information
>   * @pf: board private structure
> @@ -3632,7 +4317,10 @@ ice_dpll_init_pins_info(struct ice_pf *pf, enum
> ice_dpll_pin_type pin_type)
>  	case ICE_DPLL_PIN_TYPE_OUTPUT:
>  		return ice_dpll_init_info_direct_pins(pf, pin_type);
>  	case ICE_DPLL_PIN_TYPE_RCLK_INPUT:
> -		return ice_dpll_init_info_rclk_pin(pf);
> +		if (pf->hw.mac_type =3D=3D ICE_MAC_GENERIC_3K_E825)
> +			return ice_dpll_init_info_pin_on_pin_e825c(pf);
> +		else
> +			return ice_dpll_init_info_rclk_pin(pf);
>  	case ICE_DPLL_PIN_TYPE_SOFTWARE:
>  		return ice_dpll_init_info_sw_pins(pf);
>  	default:
> @@ -3654,6 +4342,54 @@ static void ice_dpll_deinit_info(struct ice_pf
> *pf)
>  	kfree(pf->dplls.pps.input_prio);
>  }
>=20
> +/**
> + * ice_dpll_init_info_e825c - prepare pf's dpll information structure
> for e825c
> + * device
> + * @pf: board private structure
> + *
> + * Acquire (from HW) and set basic DPLL information (on pf->dplls
> struct).
> + *
> + * Return:
> + * * 0 - success
> + * * negative - init failure reason
> + */
> +static int ice_dpll_init_info_e825c(struct ice_pf *pf)
> +{
> +	struct ice_dplls *d =3D &pf->dplls;
> +	int ret =3D 0;
> +	int i;
> +
> +	d->clock_id =3D ice_generate_clock_id(pf);
> +	d->num_inputs =3D ICE_SYNCE_CLK_NUM;
> +
> +	d->inputs =3D kcalloc(d->num_inputs, sizeof(*d->inputs),
> GFP_KERNEL);
It looks like for E825-C the allocated pin info (d->inputs and related fiel=
ds) is never freed:
error paths in ice_dpll_init_info_e825c() return after kcalloc() without cl=
eanup, and ice_dpll_deinit() explicitly skips ice_dpll_deinit_info() for th=
is MAC.

With the best regards
Alex

> +	if (!d->inputs)
> +		return -ENOMEM;
> +
> +	ret =3D ice_get_cgu_rclk_pin_info(&pf->hw, &d->base_rclk_idx,
> +					&pf->dplls.rclk.num_parents);
> +	if (ret)
> +		return ret;
> +
> +	for (i =3D 0; i < pf->dplls.rclk.num_parents; i++)
> +		pf->dplls.rclk.parent_idx[i] =3D d->base_rclk_idx + i;
> +
> +	if (ice_pf_src_tmr_owned(pf)) {
> +		d->base_1588_idx =3D ICE_E825_1588_BASE_IDX;
> +		pf->dplls.pin_1588.num_parents =3D pf-
> >dplls.rclk.num_parents;
> +		for (i =3D 0; i < pf->dplls.pin_1588.num_parents; i++)
> +			pf->dplls.pin_1588.parent_idx[i] =3D d-
> >base_1588_idx + i;
> +	}
> +	ret =3D ice_dpll_init_pins_info(pf,
> ICE_DPLL_PIN_TYPE_RCLK_INPUT);
> +	if (ret)
> +		return ret;
> +	dev_dbg(ice_pf_to_dev(pf),
> +		"%s - success, inputs: %u, outputs: %u, rclk-parents:
> %u, pin_1588-parents: %u\n",
> +		 __func__, d->num_inputs, d->num_outputs, d-
> >rclk.num_parents,
> +		 d->pin_1588.num_parents);
> +	return 0;
> +}
> +
>  /**
>   * ice_dpll_init_info - prepare pf's dpll information structure
>   * @pf: board private structure
> @@ -3773,14 +4509,17 @@ void ice_dpll_deinit(struct ice_pf *pf)
>  		ice_dpll_deinit_worker(pf);
>=20
>  	ice_dpll_deinit_pins(pf, cgu);
> -	ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
> -	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
> -	ice_dpll_deinit_info(pf);
> +	if (!IS_ERR_OR_NULL(pf->dplls.pps.dpll))
> +		ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
> +	if (!IS_ERR_OR_NULL(pf->dplls.eec.dpll))
> +		ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
> +	if (pf->hw.mac_type !=3D ICE_MAC_GENERIC_3K_E825)
> +		ice_dpll_deinit_info(pf);
>  	mutex_destroy(&pf->dplls.lock);
>  }
>=20
>  /**
> - * ice_dpll_init - initialize support for dpll subsystem
> + * ice_dpll_init_e825 - initialize support for dpll subsystem
>   * @pf: board private structure
>   *
>   * Set up the device dplls, register them and pins connected within
> Linux dpll
> @@ -3789,7 +4528,41 @@ void ice_dpll_deinit(struct ice_pf *pf)
>   *
>   * Context: Initializes pf->dplls.lock mutex.
>   */
> -void ice_dpll_init(struct ice_pf *pf)
> +static void ice_dpll_init_e825(struct ice_pf *pf)
> +{
> +	struct ice_dplls *d =3D &pf->dplls;
> +	int err;
> +
> +	mutex_init(&d->lock);
> +
> +	err =3D ice_dpll_init_info_e825c(pf);
> +	if (err)
> +		goto err_exit;
> +	err =3D ice_dpll_init_pins_e825(pf);
> +	if (err)
> +		goto deinit_info;
> +	set_bit(ICE_FLAG_DPLL, pf->flags);
> +
> +	return;
> +
> +deinit_info:
> +	ice_dpll_deinit_info(pf);
> +err_exit:
> +	mutex_destroy(&d->lock);
> +	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n",
> err);
> +}
> +
> +/**
> + * ice_dpll_init_e810 - initialize support for dpll subsystem
> + * @pf: board private structure
> + *
> + * Set up the device dplls, register them and pins connected within
> Linux dpll
> + * subsystem. Allow userspace to obtain state of DPLL and handling of
> DPLL
> + * configuration requests.
> + *
> + * Context: Initializes pf->dplls.lock mutex.
> + */
> +static void ice_dpll_init_e810(struct ice_pf *pf)
>  {
>  	bool cgu =3D ice_is_feature_supported(pf, ICE_F_CGU);
>  	struct ice_dplls *d =3D &pf->dplls;
> @@ -3829,3 +4602,15 @@ void ice_dpll_init(struct ice_pf *pf)
>  	mutex_destroy(&d->lock);
>  	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n",
> err);
>  }
> +
> +void ice_dpll_init(struct ice_pf *pf)
> +{
> +	switch (pf->hw.mac_type) {
> +	case ICE_MAC_GENERIC_3K_E825:
> +		ice_dpll_init_e825(pf);
> +		break;
> +	default:
> +		ice_dpll_init_e810(pf);
> +		break;
> +	}
> +}
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h
> b/drivers/net/ethernet/intel/ice/ice_dpll.h
> index 63fac6510df6e..73755d0d30ed2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.h
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
> @@ -20,6 +20,12 @@ enum ice_dpll_pin_sw {
>  	ICE_DPLL_PIN_SW_NUM
>  };
>=20
> +struct ice_dpll_pin_work {
> +	struct work_struct work;
> +	unsigned long action;
> +	struct ice_dpll_pin *pin;
> +};
> +
>  /** ice_dpll_pin - store info about pins
>   * @pin: dpll pin structure
>   * @pf: pointer to pf, which has registered the dpll_pin
> @@ -39,6 +45,8 @@ struct ice_dpll_pin {
>  	struct dpll_pin *pin;
>  	struct ice_pf *pf;
>  	dpll_tracker tracker;
> +	struct fwnode_handle *fwnode;
> +	struct notifier_block nb;
>  	u8 idx;
>  	u8 num_parents;
>  	u8 parent_idx[ICE_DPLL_RCLK_NUM_MAX];
> @@ -105,11 +113,13 @@ struct ice_dpll {
>   * @pps: pointer to PPS dpll dev
>   * @inputs: input pins pointer
>   * @outputs: output pins pointer
> + * @pin_1588: pin controlling clock 1588 pointer
>   * @rclk: recovered pins pointer
>   * @num_inputs: number of input pins available on dpll
>   * @num_outputs: number of output pins available on dpll
>   * @cgu_state_acq_err_num: number of errors returned during periodic
> work
>   * @base_rclk_idx: idx of first pin used for clock revocery pins
> + * @base_1588_idx: idx of first pin used for 1588 clock control pin
>   * @clock_id: clock_id of dplls
>   * @input_phase_adj_max: max phase adjust value for an input pins
>   * @output_phase_adj_max: max phase adjust value for an output pins
> @@ -118,11 +128,13 @@ struct ice_dpll {
>  struct ice_dplls {
>  	struct kthread_worker *kworker;
>  	struct kthread_delayed_work work;
> +	struct workqueue_struct *wq;
>  	struct mutex lock;
>  	struct ice_dpll eec;
>  	struct ice_dpll pps;
>  	struct ice_dpll_pin *inputs;
>  	struct ice_dpll_pin *outputs;
> +	struct ice_dpll_pin pin_1588;
>  	struct ice_dpll_pin sma[ICE_DPLL_PIN_SW_NUM];
>  	struct ice_dpll_pin ufl[ICE_DPLL_PIN_SW_NUM];
>  	struct ice_dpll_pin rclk;
> @@ -130,6 +142,7 @@ struct ice_dplls {
>  	u8 num_outputs;
>  	u8 sma_data;
>  	u8 base_rclk_idx;
> +	u8 base_1588_idx;
>  	int cgu_state_acq_err_num;
>  	u64 clock_id;
>  	s32 input_phase_adj_max;
> @@ -147,3 +160,19 @@ static inline void ice_dpll_deinit(struct ice_pf
> *pf) { }
>  #endif
>=20
>  #endif
> +
> +#define ICE_CGU_R10				0x28
> +#define ICE_CGU_R10_SYNCE_CLKO_SEL		GENMASK(8, 5)
> +#define ICE_CGU_R10_SYNCE_CLKODIV_M1		GENMASK(13, 9)
> +#define ICE_CGU_R10_SYNCE_CLKODIV_LOAD		BIT(14)
> +#define ICE_CGU_R10_SYNCE_DCK_RST		BIT(15)
> +#define ICE_CGU_R10_SYNCE_ETHCLKO_SEL		GENMASK(18, 16)
> +#define ICE_CGU_R10_SYNCE_ETHDIV_M1		GENMASK(23, 19)
> +#define ICE_CGU_R10_SYNCE_ETHDIV_LOAD		BIT(24)
> +#define ICE_CGU_R10_SYNCE_DCK2_RST		BIT(25)
> +#define ICE_CGU_R10_SYNCE_S_REF_CLK		GENMASK(31, 27)
> +
> +#define ICE_CGU_R11				0x2C
> +#define ICE_CGU_R11_SYNCE_S_BYP_CLK		GENMASK(6, 1)
> +
> +#define ICE_CGU_BYPASS_MUX_OFFSET_E825C		3
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 15621707fbf81..bac481e8140d2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3946,6 +3946,9 @@ void ice_init_feature_support(struct ice_pf *pf)
>  		break;
>  	}
>=20
> +	if (pf->hw.mac_type =3D=3D ICE_MAC_GENERIC_3K_E825)
> +		ice_set_feature_support(pf, ICE_F_PHY_RCLK);
> +
>  	if (pf->hw.mac_type =3D=3D ICE_MAC_E830) {
>  		ice_set_feature_support(pf, ICE_F_MBX_LIMIT);
>  		ice_set_feature_support(pf, ICE_F_GCS);
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c
> b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 4c8d20f2d2c0a..0eb8a9e29a521 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1341,6 +1341,35 @@ void ice_ptp_link_change(struct ice_pf *pf,
> bool linkup)
>  	if (pf->hw.reset_ongoing)
>  		return;
>=20
> +	if (hw->mac_type =3D=3D ICE_MAC_GENERIC_3K_E825) {
> +		int pin, err;
> +
> +		mutex_lock(&pf->dplls.lock);
> +		for (pin =3D 0; pin < ICE_SYNCE_CLK_NUM; pin++) {
> +			enum ice_synce_clk clk_pin;
> +			bool active;
> +			u8 port_num;
> +
> +			port_num =3D ptp_port->port_num;
> +			clk_pin =3D (enum ice_synce_clk)pin;
> +			err =3D ice_tspll_bypass_mux_active_e825c(hw,
> +								port_num,
> +								&active,
> +								clk_pin);
> +			if (WARN_ON_ONCE(err)) {
> +				mutex_unlock(&pf->dplls.lock);
> +				return;
> +			}
> +
> +			err =3D ice_tspll_cfg_synce_ethdiv_e825c(hw,
> clk_pin);
> +			if (active && WARN_ON_ONCE(err)) {
> +				mutex_unlock(&pf->dplls.lock);
> +				return;
> +			}
> +		}
> +		mutex_unlock(&pf->dplls.lock);
> +	}
> +
>  	switch (hw->mac_type) {
>  	case ICE_MAC_E810:
>  	case ICE_MAC_E830:
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 35680dbe4a7f7..61c0a0d93ea89 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -5903,7 +5903,14 @@ int ice_get_cgu_rclk_pin_info(struct ice_hw
> *hw, u8 *base_idx, u8 *pin_num)
>  			*base_idx =3D SI_REF1P;
>  		else
>  			ret =3D -ENODEV;
> -
> +		break;
> +	case ICE_DEV_ID_E825C_BACKPLANE:
> +	case ICE_DEV_ID_E825C_QSFP:
> +	case ICE_DEV_ID_E825C_SFP:
> +	case ICE_DEV_ID_E825C_SGMII:
> +		*pin_num =3D ICE_SYNCE_CLK_NUM;
> +		*base_idx =3D 0;
> +		ret =3D 0;
>  		break;
>  	default:
>  		ret =3D -ENODEV;
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> index 5896b346e5790..2c2fa1e73ee0b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> @@ -210,6 +210,7 @@ enum ice_phy_rclk_pins {
>  #define ICE_E82X_RCLK_PINS_NUM		(ICE_RCLKA_PIN + 1)
>  #define E810T_CGU_INPUT_C827(_phy, _pin) ((_phy) *
> ICE_E810_RCLK_PINS_NUM + \
>  					  (_pin) + ZL_REF1P)
> +#define ICE_E825_1588_BASE_IDX		0
>=20
>  enum ice_zl_cgu_in_pins {
>  	ZL_REF0P =3D 0,
> diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c
> b/drivers/net/ethernet/intel/ice/ice_tspll.c
> index 66320a4ab86fd..78d74fb0d94b0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tspll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
> @@ -624,3 +624,226 @@ int ice_tspll_init(struct ice_hw *hw)
>=20
>  	return err;
>  }
> +
> +/**
> + * ice_tspll_bypass_mux_active_e825c - check if the given port is set
> active
> + * @hw: Pointer to the HW struct
> + * @port: Number of the port
> + * @active: Output flag showing if port is active
> + * @output: Output pin, we have two in E825C
> + *
> + * Check if given port is selected as recovered clock source for
> given output.
> + *
> + * Return:
> + * * 0 - success
> + * * negative - error
> + */
> +int ice_tspll_bypass_mux_active_e825c(struct ice_hw *hw, u8 port,
> bool *active,
> +				      enum ice_synce_clk output)
> +{
> +	u8 active_clk;
> +	u32 val;
> +
> +	switch (output) {
> +	case ICE_SYNCE_CLK0:
> +		ice_read_cgu_reg(hw, ICE_CGU_R10, &val);
> +		active_clk =3D FIELD_GET(ICE_CGU_R10_SYNCE_S_REF_CLK,
> val);
> +		break;
> +	case ICE_SYNCE_CLK1:
> +		ice_read_cgu_reg(hw, ICE_CGU_R11, &val);
> +		active_clk =3D FIELD_GET(ICE_CGU_R11_SYNCE_S_BYP_CLK,
> val);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
ice_read_cgu_reg() return codes are ignored, can you explain why?


> +
> +	if (active_clk =3D=3D port % hw->ptp.ports_per_phy +
> +			  ICE_CGU_BYPASS_MUX_OFFSET_E825C)
> +		*active =3D true;
> +	else
> +		*active =3D false;
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_tspll_cfg_bypass_mux_e825c - configure reference clock mux
> + * @hw: Pointer to the HW struct
> + * @ena: true to enable the reference, false if disable
> + * @port_num: Number of the port
> + * @output: Output pin, we have two in E825C
> + * @clock_1588: true to enable 1588 reference, false to recover from
> port
> + *
> + * Set reference clock source and output clock selection.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error
> + */
> +int ice_tspll_cfg_bypass_mux_e825c(struct ice_hw *hw, bool ena, u32
> port_num,
> +				   enum ice_synce_clk output, bool
> clock_1588)
> +{
> +	u8 first_mux;
> +	int err;
> +	u32 r10;
> +
> +	err =3D ice_read_cgu_reg(hw, ICE_CGU_R10, &r10);
> +	if (err)
> +		return err;
> +
> +	if (!ena)
> +		first_mux =3D ICE_CGU_NET_REF_CLK0;
> +	else if (clock_1588)
> +		first_mux =3D ICE_CGU_NCOCLK;
> +	else
> +		first_mux =3D port_num + ICE_CGU_BYPASS_MUX_OFFSET_E825C;
> +
> +	r10 &=3D ~(ICE_CGU_R10_SYNCE_DCK_RST |
> ICE_CGU_R10_SYNCE_DCK2_RST);
> +
> +	switch (output) {
> +	case ICE_SYNCE_CLK0:
> +		r10 &=3D ~(ICE_CGU_R10_SYNCE_ETHCLKO_SEL |
> +			 ICE_CGU_R10_SYNCE_ETHDIV_LOAD |
> +			 ICE_CGU_R10_SYNCE_S_REF_CLK);
> +		r10 |=3D FIELD_PREP(ICE_CGU_R10_SYNCE_S_REF_CLK,
> first_mux);
> +		if (clock_1588)
> +			r10 |=3D FIELD_PREP(ICE_CGU_R10_SYNCE_ETHCLKO_SEL,
> +					  ICE_CGU_REF_CLK_BYP0);
> +		else
> +			r10 |=3D FIELD_PREP(ICE_CGU_R10_SYNCE_ETHCLKO_SEL,
> +					  ICE_CGU_REF_CLK_BYP0_DIV);
> +		break;
> +	case ICE_SYNCE_CLK1:
> +	{
> +		u32 val;
> +
> +		err =3D ice_read_cgu_reg(hw, ICE_CGU_R11, &val);
> +		if (err)
> +			return err;
> +		val &=3D ~ICE_CGU_R11_SYNCE_S_BYP_CLK;
> +		val |=3D FIELD_PREP(ICE_CGU_R11_SYNCE_S_BYP_CLK,
> first_mux);
> +		err =3D ice_write_cgu_reg(hw, ICE_CGU_R11, val);
> +		if (err)
> +			return err;
> +		r10 &=3D ~(ICE_CGU_R10_SYNCE_CLKODIV_LOAD |
> +			 ICE_CGU_R10_SYNCE_CLKO_SEL);
> +		if (clock_1588)
> +			r10 |=3D FIELD_PREP(ICE_CGU_R10_SYNCE_CLKO_SEL,
> +					  ICE_CGU_REF_CLK_BYP1);
> +		else
> +			r10 |=3D FIELD_PREP(ICE_CGU_R10_SYNCE_CLKO_SEL,
> +					  ICE_CGU_REF_CLK_BYP1_DIV);
> +		break;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	err =3D ice_write_cgu_reg(hw, ICE_CGU_R10, r10);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_tspll_get_div_e825c - get the divider for the given speed
> + * @link_speed: link speed of the port
> + * @divider: output value, calculated divider
> + *
> + * Get CGU divider value based on the link speed.
> + *
> + * Return:
> + * * 0 - success
> + * * negative - error
> + */
> +static int ice_tspll_get_div_e825c(u16 link_speed, unsigned int
> *divider)
> +{
> +	switch (link_speed) {
> +	case ICE_AQ_LINK_SPEED_100GB:
> +	case ICE_AQ_LINK_SPEED_50GB:
> +	case ICE_AQ_LINK_SPEED_25GB:
> +		*divider =3D 10;
> +		break;
> +	case ICE_AQ_LINK_SPEED_40GB:
> +	case ICE_AQ_LINK_SPEED_10GB:
> +		*divider =3D 4;
> +		break;
> +	case ICE_AQ_LINK_SPEED_5GB:
> +	case ICE_AQ_LINK_SPEED_2500MB:
> +	case ICE_AQ_LINK_SPEED_1000MB:
> +		*divider =3D 2;
> +		break;
> +	case ICE_AQ_LINK_SPEED_100MB:
> +		*divider =3D 1;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_tspll_cfg_synce_ethdiv_e825c - set the divider on the mux
> + * @hw: Pointer to the HW struct
> + * @output: Output pin, we have two in E825C
> + *
> + * Set the correct CGU divider for RCLKA or RCLKB.
> + *
> + * Context: Called under pf->dplls.lock
> + * Return:
> + * * 0 - success
> + * * negative - error
> + */
> +int ice_tspll_cfg_synce_ethdiv_e825c(struct ice_hw *hw,
> +				     enum ice_synce_clk output)
> +{
> +	unsigned int divider;
> +	u16 link_speed;
> +	u32 val;
> +	int err;
> +
> +	link_speed =3D hw->port_info->phy.link_info.link_speed;
> +	if (!link_speed)
> +		return 0;
> +
> +	err =3D ice_tspll_get_div_e825c(link_speed, &divider);
> +	if (err)
> +		return err;
> +
> +	err =3D ice_read_cgu_reg(hw, ICE_CGU_R10, &val);
> +	if (err)
> +		return err;
> +
> +	/* programmable divider value (from 2 to 16) minus 1 for
> ETHCLKOUT */
> +	switch (output) {
> +	case ICE_SYNCE_CLK0:
> +		val &=3D ~(ICE_CGU_R10_SYNCE_ETHDIV_M1 |
> +			 ICE_CGU_R10_SYNCE_ETHDIV_LOAD);
> +		val |=3D FIELD_PREP(ICE_CGU_R10_SYNCE_ETHDIV_M1, divider -
> 1);
> +		err =3D ice_write_cgu_reg(hw, ICE_CGU_R10, val);
> +		if (err)
> +			return err;
> +		val |=3D ICE_CGU_R10_SYNCE_ETHDIV_LOAD;
> +		break;
> +	case ICE_SYNCE_CLK1:
> +		val &=3D ~(ICE_CGU_R10_SYNCE_CLKODIV_M1 |
> +			 ICE_CGU_R10_SYNCE_CLKODIV_LOAD);
> +		val |=3D FIELD_PREP(ICE_CGU_R10_SYNCE_CLKODIV_M1, divider
> - 1);
> +		err =3D ice_write_cgu_reg(hw, ICE_CGU_R10, val);
> +		if (err)
> +			return err;
> +		val |=3D ICE_CGU_R10_SYNCE_CLKODIV_LOAD;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	err =3D ice_write_cgu_reg(hw, ICE_CGU_R10, val);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.h
> b/drivers/net/ethernet/intel/ice/ice_tspll.h
> index c0b1232cc07c3..cf5581f152e78 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tspll.h
> +++ b/drivers/net/ethernet/intel/ice/ice_tspll.h
> @@ -21,11 +21,23 @@ struct ice_tspll_params_e82x {
>  	u32 frac_n_div;
>  };
>=20
> +#define ICE_CGU_NET_REF_CLK0		0x0
> +#define ICE_CGU_NCOCLK			0x2
> +#define ICE_CGU_REF_CLK_BYP0		0x5
> +#define ICE_CGU_REF_CLK_BYP0_DIV	0x0
> +#define ICE_CGU_REF_CLK_BYP1		0x4
> +#define ICE_CGU_REF_CLK_BYP1_DIV	0x1
> +
>  #define ICE_TSPLL_CK_REFCLKFREQ_E825		0x1F
>  #define ICE_TSPLL_NDIVRATIO_E825		5
>  #define ICE_TSPLL_FBDIV_INTGR_E825		256
>=20
>  int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable);
>  int ice_tspll_init(struct ice_hw *hw);
> -
> +int ice_tspll_bypass_mux_active_e825c(struct ice_hw *hw, u8 port,
> bool *active,
> +				      enum ice_synce_clk output);
> +int ice_tspll_cfg_bypass_mux_e825c(struct ice_hw *hw, bool ena, u32
> port_num,
> +				   enum ice_synce_clk output, bool
> clock_1588);
> +int ice_tspll_cfg_synce_ethdiv_e825c(struct ice_hw *hw,
> +				     enum ice_synce_clk output);
>  #endif /* _ICE_TSPLL_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_type.h
> b/drivers/net/ethernet/intel/ice/ice_type.h
> index 6a2ec8389a8f3..1e82f4c40b326 100644
> --- a/drivers/net/ethernet/intel/ice/ice_type.h
> +++ b/drivers/net/ethernet/intel/ice/ice_type.h
> @@ -349,6 +349,12 @@ enum ice_clk_src {
>  	NUM_ICE_CLK_SRC
>  };
>=20
> +enum ice_synce_clk {
> +	ICE_SYNCE_CLK0,
> +	ICE_SYNCE_CLK1,
> +	ICE_SYNCE_CLK_NUM
> +};
> +
>  struct ice_ts_func_info {
>  	/* Function specific info */
>  	enum ice_tspll_freq time_ref;
> --
> 2.51.2


