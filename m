Return-Path: <linux-rdma+bounces-10168-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12680AAFF08
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 17:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C267179586
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EFC278762;
	Thu,  8 May 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTxysUIO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3FC13635C;
	Thu,  8 May 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717638; cv=fail; b=LZomf0RtE2n+Wq2uCPDdN3ciq0r7vMhoRLSQCEGwDZc0GMlE1fW1tA8Cgv6kw9fV6aUQQUZrcN3FkjS8VEpqiqirRv5lGiUKepg0QvCyi4Av9AX8MPYR7qxfU9aqWAJKNcLdNsmT6N9Ga+C5qd5uYdfvEzHMIELQHaQC+LtHN+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717638; c=relaxed/simple;
	bh=llhGseGij4C5PD5e+IDPx7pFZGOXMkhakCqHYY+Jks0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qMGJSEFOGupUlOvpc1iAVQ7cnaYOt3KWLW1fVLP5K7gz1r2Y5eQYgJtNx4KFNU1+kAQniw7RRO7sAOJxVSwACq329gD+n8iToT6uGQG/97fxk8riNMhpQplo/b+seAy4vT1+JzV+gty4mU3Sagc3QKqptRTwZ0Bzm75njxWlf9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTxysUIO; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746717633; x=1778253633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=llhGseGij4C5PD5e+IDPx7pFZGOXMkhakCqHYY+Jks0=;
  b=QTxysUIOshzMFBZKpUjfB06FdG2lqgQao4+J+soJmy2DPEgIOBypc7vo
   rn6+GrAzT6+Y8d2aVcbFzvNbFIgK4j0FvYwTZAmux/TBDtAyOOrQzEcBf
   bVJF0QjBp8cS2kK12zGnvA8kND+5ZJoi8oQxgKofWTom16XDsz05hIFtk
   Erc3JV1yP+WetazGhNLiSZ+EyIy9+POSwFIZs18VTo8+lNc7PO07kZZBi
   ZePlM9wFuwtaNCmT9l+ccskvtq4qQXnu3i2D4nYsa/MGyVouClQWe4jc3
   Juo1XcJE8pfT6mFbWHw31gkY5RoPMf0p8RWFTX19wASptw7hpRL3dLHcI
   Q==;
X-CSE-ConnectionGUID: ygginUqqSjKVe4NWUGmRpw==
X-CSE-MsgGUID: LVgUW4lPQ1CKQFF51Y4b9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59505316"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="59505316"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 08:20:32 -0700
X-CSE-ConnectionGUID: IjFQiKd4TrmNCvVvhfQmmg==
X-CSE-MsgGUID: 9DLXHhSPTtSaqykTBJZUIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167419630"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 08:20:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 08:20:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 08:20:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 08:20:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsoyB55Xx23Q5cX0DiU2WtALGSMlcmpKMzLFWLRfaFUpBksaEinvG1fTA+s8wXfaGLrKG9IPhCRTWU65zQi59dkkBR9RTcK4xQBhRYTguS47vWicOI1boKZAs54HggxcMOxiov13tkDFVFP1/EJvAIB7JekmJO6j400oYMMP2w07a4rt5D8HBBveonAX+W/wCS85qJrkDgvp2KOJtsAECa6OOepjnsilfAsiAm4gIWfT+NwMPprwsLx/BdzE6Uwm2HiGltyTkBhg/ymmKEhASq5xTs5/0KN4igkqNO0QpZMLE+cpfPZxfwYowyn95f9I8AsIKeCOJNQgYbketRW5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGy2pmfAzN9TsJk1nrcCILNUEdXogdZcUajJLYZ3JFY=;
 b=QC0Q9wtxREN9z6S+ZI4zwC6VGOvX2xqR2fSQRlxgdhAVV3sbnYVAvuaj8Nt2uu7/QXGiDz/GrX8EMGxEXS/D9MhHE2m/S32A51nvWYOuCg6MzXCPsXGPZDPaYHeZS0RABY1kRT8uwITGm56NvDvFfTZi2oRRlGOdjHYX5aZwqIz8uyUp8u3G1S2fsvzeN47FXdlxiHD3QFtnqj8hkN2XVbjCOIGR+f8V2UWih4vjxtVZK3zejHQSJLVzGoLvaZaFbtu4O4iVeNIu2iMlRbhpQX/5r9SUlbT/GLH9XnpL3vWbtMYoLTGxbA0O4HT6EWFNSl5fo9sZVz8FJm1KPuFr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22)
 by CY5PR11MB6162.namprd11.prod.outlook.com (2603:10b6:930:29::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.33; Thu, 8 May
 2025 15:20:25 +0000
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38]) by SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 15:20:25 +0000
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
Thread-Index: AQHbwBSYBJ3EJ8z+B0iwWujbZDDvS7PIy2yAgAAKFQA=
Date: Thu, 8 May 2025 15:20:24 +0000
Message-ID: <SJ2PR11MB8452820F6BDF445F29D368C99B8BA@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250508122128.1216231-1-arkadiusz.kubalewski@intel.com>
 <20250508122128.1216231-3-arkadiusz.kubalewski@intel.com>
 <rwterkiyhdjcedboj773zc5s3d6purz6yaccfowco7m5zd7q3c@or4r33ay2dxh>
In-Reply-To: <rwterkiyhdjcedboj773zc5s3d6purz6yaccfowco7m5zd7q3c@or4r33ay2dxh>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8452:EE_|CY5PR11MB6162:EE_
x-ms-office365-filtering-correlation-id: 72d8932c-1295-4c4d-367d-08dd8e43db43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/CQVnUj8ZtqQUVh9Gbyoi6XwFtgjdiHUhWbMQo8Hom2PE1DQgsJ9JvYpYqoy?=
 =?us-ascii?Q?a1pcEdP13GWSBZBt0uqKkHKREwVQx2PDFb1gE/m4HjdYyiUOTTGhSeVD/bFx?=
 =?us-ascii?Q?9OxvgLW55UllhLatwqbQ+SgVmyEFHbs+FzoerODyazgo/fZbl9pe/MgkiMN2?=
 =?us-ascii?Q?uOhFicGotsYGjUnPh9MirJuqNAWxpufvu4g2OyqWpMnhxfR6NghQEkCXnv4N?=
 =?us-ascii?Q?podA+5WS1gL1W07kTXOinCdRoLUZ6HIPO92bq5Q1idcWjLf4WTa6bWyL2603?=
 =?us-ascii?Q?kytVpQh7oLyrT97uGnSeKvNpH64tSRvUnFxMDsE0JdRvBNOB6PtB+fL4kKn6?=
 =?us-ascii?Q?x9JqQEvK6FApzo8j9UkLlAP7tiShqBre7JrU5MYbF7Urs4VnnJ2p4fph/jzz?=
 =?us-ascii?Q?LEzvse2OBTQkDJy/5AKkM9nJSe8sbsb2MEeeKggs7ywH/tADJjlEdoG1h2LC?=
 =?us-ascii?Q?qquns8Kqq+ZklyHK/TNmDKMxHVzXIL6gVhTGmTMj6JNY5gQK+jIX5lCXReOH?=
 =?us-ascii?Q?7Y/cSeif5+P2uodJKtQRFy669XnLVOAMYvoi0s9K1/hWHZSSz1KDTdSLnRsM?=
 =?us-ascii?Q?MMDCNbkHnjY5h/74UbDoGX/AB5PU7y7kC4gsELh6EQgugGa3pcpFS19kG4fM?=
 =?us-ascii?Q?4NxHKTWQLf/9ZvxeLXAqGFq1pYaO9cr0MX0fGieLgmd7qGw/gN9O2+14WktD?=
 =?us-ascii?Q?dHuHRs1Ry7hD5lLnWefe9GjcAaaz6DOWYYZux0LqfXWbzsIQ2ROKJOccZSFs?=
 =?us-ascii?Q?EMJ/mnpfMqJipiTi6I65tGsE8r5fzuwC3TfJPUdezSmG5tsSvFaeNzaBz52m?=
 =?us-ascii?Q?hkKPMtczL1cVyUp2LLguvrcMM7WXPKADvvCHJaNWbFOa7DE4w+Tl79+9lq3c?=
 =?us-ascii?Q?5Br56P55+WAT4tJyi1TSBKmL17hjtmy0ctAnAawsQWU08ol3/prMtzhTqANg?=
 =?us-ascii?Q?BrYzvQYHZOqICPm0gBHdiLj4T/5Do6vd0GO1x0tEfLGDRJ1lXw/628J0LZsH?=
 =?us-ascii?Q?Wbsv3iVlwDtcFu2UKnVyogwQuspw2ZTAG+d8s0G3U9hhRFuhxxAccDlLx2tj?=
 =?us-ascii?Q?K0rToA8STi3UcvmwBFO3PLnAWyMN3tTtscnACu0uUg/+sWcWb6E4myA6ecdt?=
 =?us-ascii?Q?71rVXSTX/u9JC7yG2Ec1Qu609RW8GIZwUfKPj2ul4//Cs+rvjxirXov4g/mN?=
 =?us-ascii?Q?MsdKq9DkYc/i7qNljjcXk60adiLmAJRGdH4stWqf06TMYY6dIKF/2GXXWSrw?=
 =?us-ascii?Q?3e8dQYydlN2W6gKrbNZJcMn3T3y+roGfMDQL6ShrPM8NphRBqXWEch4zQDQ0?=
 =?us-ascii?Q?3rQ/v0YZLkRS3HMc/bmcT2QRtaiR05qTnXF7923AJsSR/QCacUr0xhLZXUxI?=
 =?us-ascii?Q?z6RBxR+haFmpXDFxEphKmqUftX+IWZrZ6paW0jYZ4vD3TGT5G2B/Gvnu75JD?=
 =?us-ascii?Q?3fw70A0QOzQvST/5pbjTlOvu2rACBxbJx7zxVOf2o5gRPt5qrd3cr5z60O5B?=
 =?us-ascii?Q?4BwijSHe6CHUTcU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8452.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8si/i2g6e5IRuRC61D/u8uqhS3844fGvvBzR8m8wR0+W0O2A9I1uE+r0dwys?=
 =?us-ascii?Q?Inv/eqiD8CeC2YunX+9PuF3G4ekx6zRY/C5ryeli52fj3i8YArKrdG/rh15o?=
 =?us-ascii?Q?qGBjO6vK6YjGVTZjjbyuqa4WUu9bftPxZa/l6KuK2eHaDi4IkiOe6PsOW+dj?=
 =?us-ascii?Q?gnu/JecHQs5obnyRVdM6OFou56uNfccfOxaL1lpQsHPUl5bHEcWueThmmKR1?=
 =?us-ascii?Q?L2Ju4Ilob34wZU9BbWxGqPtEf2KGlpnB1wDC6MGTyk6jzjnaeZjQQuzyYjU8?=
 =?us-ascii?Q?qF7rkzYdrMhoNGRMuwrz5vTqa7GzW1jVygzKGzrxsWlktGd1fA0QxTR0whKp?=
 =?us-ascii?Q?17QR7yZq4YNP0tvLGFPVGRE+/Vg67JKw3R5euODJCQM6I/A5ju/UUxSmciMU?=
 =?us-ascii?Q?9Qp2H7yCMALS6dx7auqFa71c2zfiFz350Ur6FUiUpLxZBNQRdJvkbVlAZKQU?=
 =?us-ascii?Q?iHqYn+sAFlbkoDQ34EC9595Ou4tH8rFtrnd2+iSeJ57xbcUetCdhL8hbF5r+?=
 =?us-ascii?Q?qZIqEApe2GKlQuE8O0aNThHpaG+d2A8LxfabRx2wV6SWA4H4Uk6sxwkx42IY?=
 =?us-ascii?Q?Pu45SHpQbhOcd5efxsd501qdER6wBQ9WZqpn54J4pLrIFWksjSi04qiTMfH9?=
 =?us-ascii?Q?+tEk+HnslPFQ6a5rT7D/60hLZr2MzDeprFcrRfYTORLDka+L9IrTfcz3Zh+8?=
 =?us-ascii?Q?WMK4yXqqZD994CoJAUg3YxMm6tlY5Wf2lZgXTMCAcO0K5q1yr4HfR/FOOekk?=
 =?us-ascii?Q?haQJpS3fV64AIPs9kO3mxtJftnNHxkn7osrIehh7aH0DSNgnaPu3WlsGkZYp?=
 =?us-ascii?Q?Z0jBWuqfgAxfXi7QnZnqEUBniyESmhV2pZBKhB0qYdFIiXe8UkkOER00iy7N?=
 =?us-ascii?Q?5C8XKL4acqLEaHcdaj93d9CvKaH13mXlYI7L9JHMNhK+curTfAt+F+eO59AY?=
 =?us-ascii?Q?Mn7trvQpuLuFMWpdq/6VKRPrqWl/roWjdtWQS0AGrLOE7PquqRrttCpbd2V/?=
 =?us-ascii?Q?TyJcc1NAL1xaf8hAvUodmlf+YA8PGuMdRcb8QMgruLxJbpyOorhQ1vI52AhU?=
 =?us-ascii?Q?5SYqPACvFBIcoKNrU4rPKx3+6F/nErr9aA4dSrJpUQTkKvRrV9nM2TeOkn5G?=
 =?us-ascii?Q?oDq1vhoYZlXU5NtjWV/hKZy5b8L6fTuimhxJViS5ZjC4ZZ2NwdZxOuMeDtG/?=
 =?us-ascii?Q?1iM4rQkPAg1MWGmgnCqbAAbq6dh2seeENC7GmcP1meg9yxhUQw9M74TOqWai?=
 =?us-ascii?Q?JEtdwPsQQBmhqbsJbCUW76ghereNRFACVsnBxYvR9qVz1ZquIP05eX7uOa7B?=
 =?us-ascii?Q?jAGwk5iFbYDWQ9uOUJz36k3cooEawehlsJRxolzXw305rHpo8lRHZ9RCqNht?=
 =?us-ascii?Q?NTcJD+s2HI03NmkMe98AnFOnZQ2TwLQIAQ0Qu/Vo8gsN1pnPMP1j7GnNcej8?=
 =?us-ascii?Q?GEtMv4kOMuq6JeZ8vSnxcLGz9sFx9NTLQts+bwSB+Wavy0eKcgLULNRWvSOX?=
 =?us-ascii?Q?jDX1xSMm4IY4C6Dj7MB+ExcuWk76rB/+VZW8TJdQ/f6H6t4NjgRjXT5ReOmL?=
 =?us-ascii?Q?vMojFi838loQ71l+rUd5uHKf8d2E7hI04f3T0tjYJoCbA+HnGDbRlCyrn9RF?=
 =?us-ascii?Q?Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8452.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d8932c-1295-4c4d-367d-08dd8e43db43
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 15:20:24.8919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCHYCuy2AGDzRM8YSiOBY1piLXgds859kCXlcTHXunYzoyRgXkI8vxGplWEHp4LfRLVKOamNZEJ2Y+4p6uLJKfswXCu2rfVAAC3pKByC1LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6162
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, May 8, 2025 4:31 PM
>
>Thu, May 08, 2025 at 02:21:27PM +0200, arkadiusz.kubalewski@intel.com
>wrote:
>>Add new callback operations for a dpll device:
>>- phase_offset_monitor_get(..) - to obtain current state of phase offset
>>  monitor feature from dpll device,
>>- phase_offset_monitor_set(..) - to allow feature configuration.
>>
>>Obtain the feature state value using the get callback and provide it to
>>the user if the device driver implements callbacks.
>>
>>Execute the set callback upon user requests.
>>
>>Reviewed-by: Milena Olech <milena.olech@intel.com>
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>---
>>v3:
>>- remove feature flags and capabilities,
>>- add separated (per feature) callback ops,
>>- use callback ops to determine feature availability.
>>---
>> drivers/dpll/dpll_netlink.c | 76 ++++++++++++++++++++++++++++++++++++-
>> include/linux/dpll.h        |  8 ++++
>> 2 files changed, 82 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>index c130f87147fa..6d2980455a46 100644
>>--- a/drivers/dpll/dpll_netlink.c
>>+++ b/drivers/dpll/dpll_netlink.c
>>@@ -126,6 +126,26 @@ dpll_msg_add_mode_supported(struct sk_buff *msg,
>>struct dpll_device *dpll,
>> 	return 0;
>> }
>>
>>+static int
>>+dpll_msg_add_phase_offset_monitor(struct sk_buff *msg, struct dpll_devic=
e
>>*dpll,
>>+				  struct netlink_ext_ack *extack)
>>+{
>>+	const struct dpll_device_ops *ops =3D dpll_device_ops(dpll);
>>+	enum dpll_feature_state state;
>>+	int ret;
>>+
>>+	if (ops->phase_offset_monitor_set && ops->phase_offset_monitor_get) {
>>+		ret =3D ops->phase_offset_monitor_get(dpll, dpll_priv(dpll),
>>+						    &state, extack);
>>+		if (ret)
>>+			return -EINVAL;
>
>Why you don't propagate "ret"?
>

My bad, will fix that.

>
>>+		if (nla_put_u32(msg, DPLL_A_PHASE_OFFSET_MONITOR, state))
>>+			return -EMSGSIZE;
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>> static int
>> dpll_msg_add_lock_status(struct sk_buff *msg, struct dpll_device *dpll,
>> 			 struct netlink_ext_ack *extack)
>>@@ -591,6 +611,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct
>>sk_buff *msg,
>> 		return ret;
>> 	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
>> 		return -EMSGSIZE;
>>+	ret =3D dpll_msg_add_phase_offset_monitor(msg, dpll, extack);
>>+	if (ret)
>>+		return ret;
>>
>> 	return 0;
>> }
>>@@ -746,6 +769,31 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
>> }
>> EXPORT_SYMBOL_GPL(dpll_pin_change_ntf);
>>
>>+static int
>>+dpll_phase_offset_monitor_set(struct dpll_device *dpll, struct nlattr *a=
,
>>+			      struct netlink_ext_ack *extack)
>>+{
>>+	const struct dpll_device_ops *ops =3D dpll_device_ops(dpll);
>>+	enum dpll_feature_state state =3D nla_get_u32(a), old_state;
>>+	int ret;
>>+
>>+	if (!(ops->phase_offset_monitor_set && ops-
>>phase_offset_monitor_get)) {
>>+		NL_SET_ERR_MSG_ATTR(extack, a, "dpll device not capable of
>>phase offset monitor");
>>+		return -EOPNOTSUPP;
>>+	}
>>+	ret =3D ops->phase_offset_monitor_get(dpll, dpll_priv(dpll),
>>&old_state,
>>+					    extack);
>>+	if (ret) {
>>+		NL_SET_ERR_MSG(extack, "unable to get current state of phase
>>offset monitor");
>>+		return -EINVAL;
>>+	}
>>+	if (state =3D=3D old_state)
>>+		return 0;
>>+
>>+	return ops->phase_offset_monitor_set(dpll, dpll_priv(dpll), state,
>>+					     extack);
>
>Why you need to do this get/set dance? I mean, just call the driver
>set() op and let it do what is needed there, no?
>

We did it this way from the beginning (during various pin-set related flows=
).

>
>>+}
>>+
>> static int
>> dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
>> 		  struct netlink_ext_ack *extack)
>>@@ -1533,10 +1581,34 @@ int dpll_nl_device_get_doit(struct sk_buff *skb,
>>struct genl_info *info)
>> 	return genlmsg_reply(msg, info);
>> }
>>
>>+static int
>>+dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info *info)
>>+{
>>+	struct nlattr *a;
>>+	int rem, ret;
>>+
>>+	nla_for_each_attr(a, genlmsg_data(info->genlhdr),
>>+			  genlmsg_len(info->genlhdr), rem) {
>
>Hmm, why you iterate? Why you just don't parse to attr array, as it is
>usually done?
>

Hmm, AFAIR there are issues when you parse nested stuff with the array
approach, here nothing is nested, but we already have the same approach on
parsing pin related stuff (dpll_pin_set_from_nlattr(..)), just did the same
here.

Thank you!
Arkadiusz

>
>>+		switch (nla_type(a)) {
>>+		case DPLL_A_PHASE_OFFSET_MONITOR:
>>+			ret =3D dpll_phase_offset_monitor_set(dpll, a,
>>+							    info->extack);
>>+			if (ret)
>>+				return ret;
>>+			break;
>>+		default:
>>+			break;
>>+		}
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>> int dpll_nl_device_set_doit(struct sk_buff *skb, struct genl_info *info)
>> {
>>-	/* placeholder for set command */
>>-	return 0;
>>+	struct dpll_device *dpll =3D info->user_ptr[0];
>>+
>>+	return dpll_set_from_nlattr(dpll, info);
>> }
>>
>> int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct
>>netlink_callback *cb)
>>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>>index 5e4f9ab1cf75..6ad6c2968a28 100644
>>--- a/include/linux/dpll.h
>>+++ b/include/linux/dpll.h
>>@@ -30,6 +30,14 @@ struct dpll_device_ops {
>> 				       void *dpll_priv,
>> 				       unsigned long *qls,
>> 				       struct netlink_ext_ack *extack);
>>+	int (*phase_offset_monitor_set)(const struct dpll_device *dpll,
>>+					void *dpll_priv,
>>+					enum dpll_feature_state state,
>>+					struct netlink_ext_ack *extack);
>>+	int (*phase_offset_monitor_get)(const struct dpll_device *dpll,
>>+					void *dpll_priv,
>>+					enum dpll_feature_state *state,
>>+					struct netlink_ext_ack *extack);
>> };
>>
>> struct dpll_pin_ops {
>>--
>>2.38.1
>>


