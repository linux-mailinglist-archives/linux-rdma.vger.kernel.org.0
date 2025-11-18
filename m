Return-Path: <linux-rdma+bounces-14589-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDD4C67E72
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 08:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A96EA36770B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 07:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082732FF655;
	Tue, 18 Nov 2025 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JziSsWD+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B25225A633;
	Tue, 18 Nov 2025 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450329; cv=fail; b=pbjyunwHpBXw9vVGxETsw9QmxBs+hkbhOEdu57adQ3j8mRNadPG2x2JkNv1j+NDfLIZ6FwfYJmY5itE2uqhTUHR05rEWiL2mukyF4CsICpq9R6bioWhDEptLMp5bqIKbh4Re5Ixv5qXtlc8vIdvQEHDf4isdGnuKCTRy9aVxTPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450329; c=relaxed/simple;
	bh=1VrxGA17/TbG52wWdSFR3lMmVO4fpc+8XSxr6TC0X2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=avF6qy+WL4QOwZ4cn+Ni6ohVPRfZuIIbqGf8Xwauxs789JtLcH3ABcTHsOHd/FPuzcT2K1iayS3iZqoDiUAnppr6+6W2z6xYHctHqg96Dd17QHFnZ8jtIjJZYBtaUjpCWyYEp4g+bSO97QHZIie066vYYvQ/MDZcciUTtnLGnno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JziSsWD+; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763450327; x=1794986327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1VrxGA17/TbG52wWdSFR3lMmVO4fpc+8XSxr6TC0X2k=;
  b=JziSsWD+NMrnR6vIk4DrLtIRtscuVEtKnHUx0Wb4T5VA+9TIPb5hKG+h
   VJA37IZxw6gvqtES4QZUeFqX9zK8l4WSBGUEC/K9fScWy98uYdFRgdi7Y
   +8CUUVHnxKVeM5Y/oLbE9JPeZsmlZSJrgmqKeqC3YynrYp146bld3g75o
   wlQ8DcXpcUeiwcnwObxgA9jJM0vswI0fAImRXe74SqIlhCWUAMsSQ2/WS
   EW5bukOWkzyz8iRHyD1TXLEtEnNWAcwNMNgCiOFiXAQLEbZVZIbXjKIQE
   qkLScBYZeP3TGl8vWYjMv2LRfa5/qM/e7U0oT1qTzj5cLxtWLBpERW91/
   Q==;
X-CSE-ConnectionGUID: 82lshgfDSEew7gyYUQcFJA==
X-CSE-MsgGUID: Qn1TVtJIQvmLEzaySFBDQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65401589"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65401589"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 23:18:46 -0800
X-CSE-ConnectionGUID: H+Aqa+XETHS5MAylwGwrVw==
X-CSE-MsgGUID: MJgobiDNTeSj6X3Xd8KM9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="214074954"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 23:18:45 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 23:18:45 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 23:18:45 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 23:18:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+ZDLbdr037xXwN5ICmEWXi5/W+u/SuXsWqGUWQe0RH9wsbe8Ppejk54y1biuki+vTNlOmWRQmosDTSLh9v53SBMV2pO2t0BVQSM1wyN34YKxQ0d4ENTBG9GoQAHnk4VB0g3lOPW1tXWbWYr1HnLIWdVWSTFNSeIcG6YD9O1C9iGVaLWK6IVJsQ4CGufxmHfAc22RABOBzUSlFH8celTTywZq5uQq56qj4xDiwtEW52nIXXs3HkvrBZ/tu6fjCq2QJXF/QOk9mYrv85Xq7by6ICM2PWXZtdAaMGyRGsYoE95LhdlVbZVX9Qfwd2rZx3DR9H3N18xxhh98S+uYcSS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tm45qo6xG77sFmNIsl7lY/VA3ei1GPJFTq7+5/kk/wU=;
 b=KyscssAatHX2nEhTGH547rBKSMBeR03B9llE1Yb/mTgPekJE5me9DJUVdjwsw6xDrId5r/qXI6UIm/atxAe8DrTsYoYm5CgG+tLHDUwt7QR3eW9Or1sh/e32deMFLg/Ct66kwuF+zV8xrjSfijmKktK1UBS7uqce09ALOTd1WRc5QcxORtiTAzf95XQru82SGg60z5IeAx2d6miPhIdZOOvq5bzZIahg8wBYogFBJuJGKt5w0mzxkVMaOIRbcD7sVN5Dfd1mu7RqcOemlG6aUKqHEreYeea7q8fiEKLjKbMepXoc2BjSAgzo8HFjl1lSebgS+Gf6nRmZFoUkjqcs+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 07:18:36 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 07:18:36 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Srujana Challa
	<schalla@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Brett Creeley <brett.creeley@amd.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Goutham, Sunil Kovvuri"
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Tariq Toukan
	<tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Manish Chopra
	<manishc@marvell.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Siddharth Vadapalli
	<s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Loic Poulain
	<loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean
	<olteanv@gmail.com>, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"Ertman, David M" <david.m.ertman@intel.com>, Vlad Dumitrescu
	<vdumitrescu@nvidia.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, Alexander Sverdlin
	<alexander.sverdlin@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v4 4/6] net/mlx5: implement swp_l4_csum_mode via
 devlink params
Thread-Topic: [PATCH net-next v4 4/6] net/mlx5: implement swp_l4_csum_mode via
 devlink params
Thread-Index: AQHcWCHLTfKYBaudQUOjXzdA+ktbibT4BsGw
Date: Tue, 18 Nov 2025 07:18:36 +0000
Message-ID: <IA3PR11MB89866089785E69139A5D12EDE5D6A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251118002433.332272-1-daniel.zahka@gmail.com>
 <20251118002433.332272-5-daniel.zahka@gmail.com>
In-Reply-To: <20251118002433.332272-5-daniel.zahka@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB4831:EE_
x-ms-office365-filtering-correlation-id: 1978c954-34cd-4ac8-ca7e-08de2672b0ae
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?1vd8mQy1GDaW4bSatAyBbXd2Au02fXfBk6aq/2HxLIHLsLYxHb5jV7InHgLt?=
 =?us-ascii?Q?PG94sioOcPe2JsbMwnyWdapvljZ9h8uHwR4u7I6cBfR664OBcwFh2DNRLOi3?=
 =?us-ascii?Q?IeZjI6KZ1vPGYaL4Iujh2y37emWad4u6zXaOGr06X+C071IHiTvCxH83mUA6?=
 =?us-ascii?Q?CsWLtXMVLbTCSS2tYDQGB+OMVCNphed/j2Wj5ke9LJqxz1YS8jjOUgqRJ71+?=
 =?us-ascii?Q?qc0YsziEj0INfaBP2AedJUgaCoBQehEDQ0OgorWKlbYFOkdBkMWsHg4p6QNM?=
 =?us-ascii?Q?1h1iK/HKJFEgIa2EyVUr/OgftC1lQiMDSMVAssLOHsoHLE8vgHBkjBujwclo?=
 =?us-ascii?Q?Snv3iggHzt0/HjCkmsU34uTsr+62QvZpYHqE70Ynda8Gkf9XbsrwgwiGjBph?=
 =?us-ascii?Q?qM0GlyU7OEcSGl3WwBYg6+9DHrfoE+jnf72UWL/AbAVVWhvJ3vPWK29Q6Ewz?=
 =?us-ascii?Q?7vAwnpM/B2wBlKvYrJUqYvhvnzL/1dc7W9f/dl5NLrHJOfeImOl5nR6cwzsb?=
 =?us-ascii?Q?SFPedhJjUXkjPsrQS31ZcDieiTDE6tWRnvPgitGzetuN1MqT/JSx0YRN8b4h?=
 =?us-ascii?Q?HlGyVVtwfFEcI73JsMuTn/+Ok60jJI01fe2j82TI4LR2pPbKTYGQ0teAOgJq?=
 =?us-ascii?Q?gGsJ4g/2J0rBLqoTOjhO3dnmuSwd80cH01YIZep0VW1E6+/IDEF6O61IhR4e?=
 =?us-ascii?Q?0jaRmIHFMqIaae39cH2YeDD4GL4ByvYW5lBOPN6GlMILzbz1TwPavHljpR2i?=
 =?us-ascii?Q?nKpr9VY9qOw/GsRUrRj4XJZTM75LI5yutwQWCzTdtgzJ2nq+mHtEmuqNtDP4?=
 =?us-ascii?Q?j7ZFTpFoxf03abDEkjQrjLgXTq0r89fCoj06rDaAWgN5bL7iOpvgSuo7pw70?=
 =?us-ascii?Q?TcWPFIJURjwmw/o5chMef90MEPTd0ixY5dqW759PqQyyrJjhLfEaTrK47KUb?=
 =?us-ascii?Q?tzHSdCqn9jSUjBrEFlRkNsEkw1XS4USaFUTKSrhndL0jr/4ZHb5qV0fyQ8lE?=
 =?us-ascii?Q?JVGuRZcE60/ldfhRY0N6ny7tmztM82J/E23CTtBhhz/ClbGU/E9Q6wVh3NMM?=
 =?us-ascii?Q?5pAhcvUTEsSSc1zBisBIUTCe77VnBnbnnXMjZI3HKWN0YBG4uJV1ABUl0Hhd?=
 =?us-ascii?Q?we/+xwrAkdbAvJhihnKoVv1Pxn6I0XSRpmkEQGPs0rKh67mmWFv08vq5xNdE?=
 =?us-ascii?Q?ECQkZ0reL72VeVaSC6qNvMi+roFKyhUvwoWMYmR/nijX8UyK4/d/hgVhbFJd?=
 =?us-ascii?Q?LtqS74qnoSilg2YrauciwBfrKpknRMf69uNtHq7b3z0vwLOw1PRpA4UnMEYt?=
 =?us-ascii?Q?/0Pvwg9m5nCYHZfifXWtlctzuv39YaaZAuNzQKOamLa3j9urb0/vWYGq+M/L?=
 =?us-ascii?Q?pFrkl11VRhQ4whU9ox7+YoTzSsh9kTkwNttvOuRIPVZZMsjn219C/n3NDHJJ?=
 =?us-ascii?Q?5Pvf9zHR5Zp4nCQyFnxyhnfBzkz9K4RPNKvMHw+cwPSWrwmtKK7F04nMXQax?=
 =?us-ascii?Q?tTVa45Y8Pfw/43H/dsT0ldg6fByzNRxIGcbyplYda9GRqYxMMRwka3vIOw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tt6mwTw5demo56W4mAdMScE6OY8aUy6GuVq4ZAtFTpnz6zd/5EQVd4ecSWXq?=
 =?us-ascii?Q?nyAAKONoc9XJ660v6AwsK6GiJEpjaopewxXVIGouweimOpsmTf+IEd6dT4C1?=
 =?us-ascii?Q?jHG+jX1+oAlwfhwx8TKAHS1Y7zaDvkCDlK9aNDJ3F70dlaFC/H+AbIL6N/5e?=
 =?us-ascii?Q?QL09j72LXmXymcdGV8R2yDd47XDte/zbL1vRjINaavwwxClBpq5tDchF2A/8?=
 =?us-ascii?Q?jMkC0+sTLV+tE7EBYmJAEewf7aVIwA5RfvUPe2ah+GdoSAZeAbFbERcxdAvE?=
 =?us-ascii?Q?bzkk172k7qECGwc3HvqoSxTNPCgx4lhLKskIHwtxVM10Bi92sFfNaZT2Pee/?=
 =?us-ascii?Q?KuumU8DtBPNXP2CHW8DSE6ATxBdfv9GruAG21PFDl4ISHz5ppdqcildBbi/W?=
 =?us-ascii?Q?C+udzspjSQEgU7+8+toePsTmYmbcDEUzNKVZPsYpHzm0qa8QPrG4JBDurt9k?=
 =?us-ascii?Q?deQPHcPWHUgIhmQl3a/nNFzQbdkP63JCYVY6p9qEAeloZlvwKNq67no+FGdD?=
 =?us-ascii?Q?pEBqvG6cfHGd9gPS6TnPytveuYcDlxJIibEqnDmkyitg5TqezX/VYWxvxNyv?=
 =?us-ascii?Q?S6/4+HjPuEUnCdsK08Bt9GZEiENDyk9aBYjeJXp3HhMwwM+jWpdiBVoZJMKZ?=
 =?us-ascii?Q?msZeaQ2fSxkfjHtScNSuVG9v+xQorIkfHzCo3D8BJ4n9NMWIiJgHVp5iWnyB?=
 =?us-ascii?Q?d9858kjPhoPR1f15oms4HS7qzSYUMA9Pt7KtfjSEDCsMRekoXYa0CVHulXWd?=
 =?us-ascii?Q?Pqvbh3b0f81N4DVsNqXtrqzwTmsqQz7o8DNAhqO11fVyHD1DR+DHQmQ+1pdZ?=
 =?us-ascii?Q?mJ4pmQk7k7HV1VYup5Llj6XOgLVcEFZMhy3EyRaozanWqr3VRZ2vVia3vt67?=
 =?us-ascii?Q?bdX6hAtRNroxZElHa98nFCxhyOCTpN0tnPsfz8F6S42eGX0DMbm8XGmXZF36?=
 =?us-ascii?Q?XzrAtJcpBAIoRZCFk2eyMi5/5+I+S9tL1/cViNqLuFOk0Ga08vkUXZsbn+me?=
 =?us-ascii?Q?AxSseGR0A5qgLJYZALhEIJNxKKTsHn766G/qLmibJVRQWjqTXDfEIDFnchSB?=
 =?us-ascii?Q?0AQOS4drLDSySCsiQxfEMHADTZ6Dafdm1LkiTu0YiP13xp9jDcH+jYn7S99B?=
 =?us-ascii?Q?xxw/5uomgspc0+ZrvqxFfFjWoIcCVIGcoabUvjsA8p4y1UysKrLKGT/zqCgH?=
 =?us-ascii?Q?Y6ZyJ72fEAQ5701ppYZ/etlFlBfQ6/0KfB5cH1HGpjG4OCEly4VzRjb3QVJW?=
 =?us-ascii?Q?C9qR2sB0M+F3EeS/zitS2DBSXGcaXz+/ULyww+/PCYnHr+AJEQ2OGwxzDT2R?=
 =?us-ascii?Q?jwORSYRfm7DZ88inM5KOTQzMNNa3El7YXHVPs3nYmuTYNL2/I8IFdjau3R9n?=
 =?us-ascii?Q?mbXX/sQyNDfHHOuAN4+2OMJtly3abdQ2JXmZPYE03SluPHNy0fed98xq0POr?=
 =?us-ascii?Q?vUcANGqTGRFDtzPwG35F9RtOz0NYbqzgT9/ggmF+H7o1gre1BR7oKC5cN8+Y?=
 =?us-ascii?Q?sstkXmRi7LsSGjYKHXYFJ3ducKdLMvO1MUkey+AUHCF3ImKeQTFhLmfLAFnT?=
 =?us-ascii?Q?Un7stDygiGaLPlIjGp/1elQzlftTGlmFFKUPDeEJlw/iUyB5q1GRIYXKaGL5?=
 =?us-ascii?Q?PA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1978c954-34cd-4ac8-ca7e-08de2672b0ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 07:18:36.5297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /tGM9oUXT2VDrp2SNsR/4lfgVvL5jG3wTYrllxgpZQ3WXwlD2WqZ3VEyK8h0q4yL+6O1uheEI3GrzGsFSYSIZ4AtcuxnwL7cavhSLaSpjK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4831
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Daniel Zahka <daniel.zahka@gmail.com>
> Sent: Tuesday, November 18, 2025 1:25 AM
> To: Jiri Pirko <jiri@resnulli.us>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon
> Horman <horms@kernel.org>; Jonathan Corbet <corbet@lwn.net>; Srujana
> Challa <schalla@marvell.com>; Bharat Bhushan <bbhushan2@marvell.com>;
> Herbert Xu <herbert@gondor.apana.org.au>; Brett Creeley
> <brett.creeley@amd.com>; Andrew Lunn <andrew+netdev@lunn.ch>; Michael
> Chan <michael.chan@broadcom.com>; Pavan Chebbi
> <pavan.chebbi@broadcom.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Goutham, Sunil Kovvuri
> <sgoutham@marvell.com>; Linu Cherian <lcherian@marvell.com>; Geetha
> sowjanya <gakula@marvell.com>; Jerin Jacob <jerinj@marvell.com>;
> hariprasad <hkelam@marvell.com>; Subbaraya Sundeep
> <sbhatta@marvell.com>; Tariq Toukan <tariqt@nvidia.com>; Saeed
> Mahameed <saeedm@nvidia.com>; Leon Romanovsky <leon@kernel.org>; Mark
> Bloch <mbloch@nvidia.com>; Ido Schimmel <idosch@nvidia.com>; Petr
> Machata <petrm@nvidia.com>; Manish Chopra <manishc@marvell.com>;
> Maxime Coquelin <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Siddharth Vadapalli <s-
> vadapalli@ti.com>; Roger Quadros <rogerq@kernel.org>; Loic Poulain
> <loic.poulain@oss.qualcomm.com>; Sergey Ryazanov
> <ryazanov.s.a@gmail.com>; Johannes Berg <johannes@sipsolutions.net>;
> Vladimir Oltean <olteanv@gmail.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Ertman, David M
> <david.m.ertman@intel.com>; Vlad Dumitrescu <vdumitrescu@nvidia.com>;
> Russell King (Oracle) <rmk+kernel@armlinux.org.uk>; Alexander Sverdlin
> <alexander.sverdlin@gmail.com>; Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: netdev@vger.kernel.org; linux-doc@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Subject: [PATCH net-next v4 4/6] net/mlx5: implement swp_l4_csum_mode
> via devlink params
>=20
> swp_l4_csum_mode controls how L4 transmit checksums are computed when
> using Software Parser (SWP) hints for header locations.
>=20
> Supported values:
>   1. default: device will choose between full_csum or l4_only. Driver
>      will discover the device's choice during initialization.
>   2. full_csum: calculate L4 checksum with the pseudo-header.
>   3. l4_only: calculate L4 checksum without the pseudo-header. Only
>      available when swp_l4_csum_mode_l4_only is set in
>      mlx5_ifc_nv_sw_offload_cap_bits.
>=20
> Note that 'default' might be returned from the device and passed to
> userspace, and it might also be set during a
> devlink_param::reset_default() call, but attempts to set a value of
> default directly with param-set will be rejected.
>=20
> The l4_only setting is a dependency for PSP initialization in
> mlx5e_psp_init().
>=20
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>=20
> Notes:
>     v4:
>     - rename device_default to default
>     - implement get_default and reset_default handlers
>     - don't allow user to request "default" in set cmd
>     v2:
>     - use extack in mlx5_nv_param_devlink_swp_l4_csum_mode_get()
>     - fix indentation issue in mlx5.rst entry
>=20
>  Documentation/networking/devlink/mlx5.rst     |  14 ++
>  .../net/ethernet/mellanox/mlx5/core/devlink.h |   3 +-
>  .../mellanox/mlx5/core/lib/nv_param.c         | 229
> ++++++++++++++++++
>  3 files changed, 245 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/networking/devlink/mlx5.rst
> b/Documentation/networking/devlink/mlx5.rst
> index 0e5f9c76e514..4bba4d780a4a 100644
> --- a/Documentation/networking/devlink/mlx5.rst
> +++ b/Documentation/networking/devlink/mlx5.rst
> @@ -218,6 +218,20 @@ parameters.
>         * ``balanced`` : Merges fewer CQEs, resulting in a moderate
> compression ratio but maintaining a balance between bandwidth savings
> and performance
>         * ``aggressive`` : Merges more CQEs into a single entry,
> achieving a higher compression rate and maximizing performance,
> particularly under high traffic loads
>=20
> +   * - ``swp_l4_csum_mode``
> +     - string
> +     - permanent
> +     - Configure how the L4 checksum is calculated by the device when
> using
> +       Software Parser (SWP) hints for header locations.
> +
> +       * ``default`` : Use the device's default checksum calculation
> +         mode. The driver will discover during init whether or
> +         full_csum or l4_only is in use. Setting this value
> explicitly
> +         from userspace is not allowed, but some firmware versions
> may
> +         return this value on param read.
> +       * ``full_csum`` : Calculate full checksum including the
> pseudo-header
> +       * ``l4_only`` : Calculate L4-only checksum, excluding the
> + pseudo-header
> +
>  The ``mlx5`` driver supports reloading via ``DEVLINK_CMD_RELOAD``
>=20
>  Info versions
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
> b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
> index c9555119a661..43b9bf8829cf 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
> @@ -26,7 +26,8 @@ enum mlx5_devlink_param_id {

...

> --
> 2.47.3


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

