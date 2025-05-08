Return-Path: <linux-rdma+bounces-10161-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A7FAAFA02
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 14:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6214F981DF6
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 12:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A22F2222DD;
	Thu,  8 May 2025 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iH3nXZSj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF626AEE;
	Thu,  8 May 2025 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707491; cv=fail; b=qGOm7VMy1NxHzMMAwg2iCY4gx6LDDFUoGtNV0mAHg/bratO3WbAwPBlFhK8y47ZDajEyb/AEeOLyISqPaV7TDkjYBt3Gk/Y5qNvWuc/fJj+Fs+qDIlNNegnqRcvvMvaftsKLsf17i2wbwoiWn6s9Zho3FPB9m1/Hmayu8TCClAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707491; c=relaxed/simple;
	bh=8fcms3EzzIsFsUzLY4MboKMzBaH0L9fFwUlb+iT0Hzg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EaW1ouEDqGInlA1/Q6micTAS1cE2SknZo7IYT37H6FepGe8zWKWWHAV5DJLIu0dqBHPrc0Mq+M1hllo34oOmfcThdMQYkA8Gn7iz4DeGOfNzYzSJEE4qYrMsMTj7eoiGULCA9K0z2PMn9IZgCoF3Zs7d5OWqeP44lEx0stOYc1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iH3nXZSj; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746707490; x=1778243490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8fcms3EzzIsFsUzLY4MboKMzBaH0L9fFwUlb+iT0Hzg=;
  b=iH3nXZSjA3g6DlX7rWi4bJhZtmT8PIo6b3a+QT90MK+KsmmxZv7G0rt7
   fCMR7mDIQRhruLd8wh+xawA/8RyXBhSuM92mjUrtqvci+ghcH3D02HdN0
   lxn5sUlC1ToSVjQ3bfpiG77AFd6zaxoUl+HdN66U0G+9JFpnlYONp/9+T
   gQmaGCGtSSWhJZ77ZlDNFR8gQvX0ye8wfRwac+jqPlQCRYox2QlOMEDnN
   Q80m3UJe0aZs2kfx8eoore/v1Jg1OHrG5A5xRIiOiHzgThb9wcfJanKlO
   r2pf8fbLzidBlMoZNNf70NXTPiIXtb98AZ1bRXLtUra8L3epsymi5YQn5
   w==;
X-CSE-ConnectionGUID: apTrSYwBR6yh6U5XyCJuog==
X-CSE-MsgGUID: C4cuwTwLTum1ibB8T9RorA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52139030"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="52139030"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:31:26 -0700
X-CSE-ConnectionGUID: wVro4+QATr2KzxjfeJfJGg==
X-CSE-MsgGUID: 4XNUwDOPRMKlkRULabND+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="137267629"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:31:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 05:31:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 05:31:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 05:31:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEVZ5YODm0a4e32M/+v8gIOyr9pwDgyBdvGG/QiIYtFDCi5TP9caLAB4tEx020D11MnwJuhGGYSeIIEJFfZGjLM+3CzeedujFIGcJxCqGVPPzMRbqF1+xtT89yVpyMMCr2HQ8hLZiHkPtDIGgGNivV46EdyBOaQMGc+AYDRzLwuov/obuRHGNdT2uB1fE+1d3QHd7e8GBohbjar15y74W+qNm37XTDR+KS9eYsKve4DBwLceJv/zEmjxhSR6cLltxP4GzlrUedHGcKNZS0I/nzvd2Q/HEeg8qTB4aqoxq9j+U8ZftydH2MmTc8ITTI19hMkWyN+4dIgOKq3UiceO/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ldcNozLHshRiaglLO8xok2BV+v7kCkfVrzknNjoesI=;
 b=D5H+LL11nGwAhP7ceW4xsM6LOKZVZ4bUhfGR4dNzlRxx8hym+RI0MN3Y+Rv115Tha1jO8gZtN5X201LbxxyQxWTghbeeykdE3sOesscsz0b3NBJ0xCbJ61/YiTnexd4wrvUfkLtG5dNrg1ltI0+XnVvzNBvfy+BxuoYS/QV6JYurGoJLPMYcgUJ7ptXnZZH8wSrkT1EqtfcwzUt0nYRzck+bMeI7HSJnRR5ocFbWkPr6njtzovcM3IsRRiCGhNfeFwuXdjxTlhpKCS3TXX9ZfIjeAhPwZiVt5niX4mmhdMbRCXuCdHSQSr1p00RRD7JdvTfjASp74NmeRlMPG0sQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22)
 by SA1PR11MB7038.namprd11.prod.outlook.com (2603:10b6:806:2b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Thu, 8 May
 2025 12:30:50 +0000
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38]) by SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 12:30:50 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "donald.hunter@gmail.com" <donald.hunter@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "Dumazet,
 Eric" <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "Nguyen, Anthony L"
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
Subject: RE: [PATCH net-next v2 3/4] dpll: features_get/set callbacks
Thread-Topic: [PATCH net-next v2 3/4] dpll: features_get/set callbacks
Thread-Index: AQHbrjN1g9R91USWQEWl7IeAkKUAtbOmNNOAgAFYDYCAABV/AIAhKtdQ
Date: Thu, 8 May 2025 12:30:50 +0000
Message-ID: <SJ2PR11MB8452FFB39384B1671D5D5A809B8BA@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250415181543.1072342-1-arkadiusz.kubalewski@intel.com>
 <20250415181543.1072342-4-arkadiusz.kubalewski@intel.com>
 <lljouuqzmhcb2esfrxrviohrwgweee6632ntfoca5fqho736il@auarfibpahpf>
 <SJ2PR11MB84521AE1C30176E2A31C4F709BBC2@SJ2PR11MB8452.namprd11.prod.outlook.com>
 <y5d6hkhdgwprncbnfmznuk5otluqz3vqi6fof6cyr4dc673cqx@5kr6ys6g53ev>
In-Reply-To: <y5d6hkhdgwprncbnfmznuk5otluqz3vqi6fof6cyr4dc673cqx@5kr6ys6g53ev>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8452:EE_|SA1PR11MB7038:EE_
x-ms-office365-filtering-correlation-id: 1edd7fa3-faf5-4dd2-3691-08dd8e2c2ae0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TeHzQIcL0LB086nk7ykbS2weHoOlNJmGaDcU1Kq71Fd2+l5XHetPZB5ZFMze?=
 =?us-ascii?Q?R70eSuqEqlaqMU4LVKwUoqu/4Rah6EHT4bfBG0Yr5xRZKEp3Yzk5jVcWX7+3?=
 =?us-ascii?Q?KQxWjv4FjUbH/v7xNpEBo1l5/ZAM2jFHIQ+aeFyFb1R+dbEvibtNTpxSzhBC?=
 =?us-ascii?Q?APiKeDeXjKbTofzRAJNtGB5fNxgJPgwQjDWFr39WuPUSyM50S6DsYfNInfUZ?=
 =?us-ascii?Q?8D1Wv2u/fp5+WT4UFACULfiE4MAWDoXRyKzInc8IYVxN/fvk6AEBI3iMmKpD?=
 =?us-ascii?Q?IfLgGxo7cV7AQyzxa3U4qBNXvnG58kfEmJ0QFBAj9Hk0kLHDnVOKncD5RsXL?=
 =?us-ascii?Q?LlxcqijE3U3H5NVUm0MrbHQi9MVlhl2a3G9F9VQqp8LiOQv+zdRULqcl3h9C?=
 =?us-ascii?Q?rgYJEwzwpCoW5aonM/gwuwQvSlZDCg3IjPBlpJHIj8Ax9E9cF8Zmhl5cMmSG?=
 =?us-ascii?Q?m8M7fMSseT6lbB7Q0CJoWU5OkK4EchMrEtn3okgh+NGSD4hAUJ9tiw2RPDBe?=
 =?us-ascii?Q?eDA99oUEHpXseAROd6JAjLWDS601K5SgC2X8wxaLaeFgCQPuBsZEHoermnFZ?=
 =?us-ascii?Q?xGihdeKiW3DbNEs0nTCuZAH3UBM8DUVQaB5uP5kikCyv3gIY0hWHJrJdiSsW?=
 =?us-ascii?Q?IUzLZfVJXEBzFLCVBpsNd1DnVxU7hwvwNqsnHAJfrKkXBbkoxCX7PqfmYZwT?=
 =?us-ascii?Q?6p/0WDARxmE4Nxz+YtsXBEi6UDOmboVmIugQwxrJk9kQZOmSZ7eFESHk7GcD?=
 =?us-ascii?Q?rMmG7vnYu/N0S+tuzRLGr3xUGJpaV3ZwoPeqXZMiBzlyWQ8L3Qw/zhvtn6oC?=
 =?us-ascii?Q?lK8bPD+LplDRtHhHHi7CrrSVVQ3qLqbbvHY3hGAQdKN79KlACxsjm3uLvSTk?=
 =?us-ascii?Q?9DYqMZM81lOyztfp6uSfXixfut0+7FMG4T8Q1lawE4sK2hMHP7XkS6+M+NZA?=
 =?us-ascii?Q?o7KXslWmvILUII5UKP1uzTufJaaLCkgFg6UCeJAc8FWdpws+R4bnANALDkF7?=
 =?us-ascii?Q?x0qQpp8zprbwgrkJfh3JlgDv9LJvb8nFTlm4S5mMLBGcbGwwWsCeAZrotf1s?=
 =?us-ascii?Q?O8IhBuG3O2ge2zoT7LR3Fmmwki4RDemQY/ixGMedNg/YfCfttj5E76MPwmF1?=
 =?us-ascii?Q?U8dL+Srxwc2cdR2JOyGUMhPqYVBxmHk4IPJbZY2Ni4xKlupDkCMtGIULI4uJ?=
 =?us-ascii?Q?3p6a4jZ/AW7U7ZQtii+mHgWSChlpSKkjlPVpqjq6SweZSqbejLgpnsbziovO?=
 =?us-ascii?Q?K5KxfH8/D7AkbE4lm3DDVNNzSwMzAPdH9JCZ7fBhedwlaO0tYBJL9b9HiG37?=
 =?us-ascii?Q?qneu1Jnre9L6Sr5oeMKLkRH0reKlrzeWMawZkXOkrfzZWqF59SxmD958oNUI?=
 =?us-ascii?Q?XVPJKqOIqAscGTx/q3s+TZcEoGSGSuDTk7fe2QIb2FBFo2ykqcFGNPCKm4YB?=
 =?us-ascii?Q?7jOLz5yE9wOvV5pRxZpKp7vy26IwKvEph/NMMOlxgtM98PqBj0xVvykrWgMZ?=
 =?us-ascii?Q?9ixYrmPOyTev0Yg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8452.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oos+kSgGIH2PnpW7r3kOBPN/PBGwR0ldfVNC96+pO7Mn/0spT9bmtW3fi1b+?=
 =?us-ascii?Q?2Rfj+2W1Ktk90H3SySBcIQBR7SzH6OxRGuC6Yt2jCZK3ni+ztX9/KClrxqKL?=
 =?us-ascii?Q?GGCnpSmdwiCtQFvTuJFY9DH0XafwGBAQFrFn4x7gLLQqYrj66tnqoc13i7xW?=
 =?us-ascii?Q?4lCWNtlrUJUgWfvnXh4UWqh3jHC6TjQJeH/L54IOYH/Ngy+bajBZRIESgCAF?=
 =?us-ascii?Q?Jy1dORC9ue1b/gR9EOLLaFly5LPw0bbj4J9iM9TueNWsrjJ3g/AfT/fnCxXG?=
 =?us-ascii?Q?WEACokWfvouqbQS2tmj3GIkKXqP5wDm/rvqULOV5jDgddS6sBge3MA7nMXAp?=
 =?us-ascii?Q?RoZiavT5nJEwkpD5y1h+3+DvpLpRMg+1o89socUmx4gk4KCItZ+HejDWvmqU?=
 =?us-ascii?Q?9Z7vUreDSFykGEn0snzvgmyrnRbS6tHArqqDJ+mrOXi3fUhfN+CCzb6Lw/+B?=
 =?us-ascii?Q?ZZrIIgKBbS2zkkAvxEbv1Mqd/4uN2APsznQvmeyizJPVCtK/U44st6cB7cpH?=
 =?us-ascii?Q?bKs7PY7pcJPP4mqtZOatUwnJgth2ywzHdTn6MWKHUT55PwbLS6Bg0AIHwv8P?=
 =?us-ascii?Q?cArNXWcyRCbMr0eUXR8SWkxsOaj6buKvxxhA31hi/jfsEzvYHM8u8DSKHKBP?=
 =?us-ascii?Q?t6y92XLpWG31Z8Il18TDBmwc5syPstz96j7DeEQ/dePlql7DhCuGpYt2DfJo?=
 =?us-ascii?Q?ccM5Z9Gsu7wjwCLH8EFjWEdyzc2+JqQgNQdirBUPKQGfeF7r7QmNMOoEWWEd?=
 =?us-ascii?Q?6b4mPHY9KNP10MxNgNeeihcXO1n19rM7hLxlGti0wEDIUI/vbjxI42QPRWTR?=
 =?us-ascii?Q?t0graoQ8frTrfIs9oexBfe2kBGslWziwzioy8gLRzs0lfal7MX1gdBI2MrPX?=
 =?us-ascii?Q?M4xluOEcFvS2JvgB5TN11mV8L31JXacCQKPVGHtYVYMrHRrLTAMHGC5z5RL9?=
 =?us-ascii?Q?tV6ikOFM9hOt95z7+UYvPEsquGRCdyvsK26WpGv8Sa/4Xt37rFaL3K+6kBGk?=
 =?us-ascii?Q?5pYYO88ni+DMs6iAe+4OegEpTusYz3UAC3wu/C4FsosLG9QlOXoxHOnxZG3G?=
 =?us-ascii?Q?TKgTrLiHnmEFFoJk9dhiXbbwQuW2pk5C4tvSxlaURZ0PU8Q1SPu9fsNl87cB?=
 =?us-ascii?Q?XVCcREAZT09bm53xkPdp4SaZn/gdGM14fGJwKal/1ioOryxzpGR0IKKTMatq?=
 =?us-ascii?Q?tKdUVL+GL0D6SHMcqevvlBL7+dGc3A5EhokZm4j/+SchVwif4leIP/afJ3pp?=
 =?us-ascii?Q?GczicsN8kkYkGYRQNVMHhYDd3V5P81NTDP68EfIsqHvKMKtdXFevYp9BiDEE?=
 =?us-ascii?Q?wu4OHH2EuWJC/lsFdpst/86jaZDNc+nANZu1j63k7wrfNvEbuEr1usxf4dcg?=
 =?us-ascii?Q?t/B3Wr2wNjEB4DwgSKoRXnXS6zBC81kWWL2jsS2sV6Mn7zxmRpptBm08w4Q3?=
 =?us-ascii?Q?531zy45FLl7jV+u+DDL4y3NNMruS17SHJHFJWnyevsSjesBWkhi3xGuVmGvG?=
 =?us-ascii?Q?QJax6ZyBdtQH2w2gk+pQg7iZC2lW9UCblMM4/dRwxuII8q6mvvQHetur5sgZ?=
 =?us-ascii?Q?168BOwybNG1LK/A9idWtiA77tbgGnvzDX1wSX32aIy0k7wdNi6OSZSN2jyS2?=
 =?us-ascii?Q?lg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edd7fa3-faf5-4dd2-3691-08dd8e2c2ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 12:30:50.5081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hhag3D/QVv9K9aCBkHi+0jy1XXy/S95ZjXXyXAhoTzUlNqkKWqau5hVDkeDYmSTUToofCh8psmIdz0MuxrYxillrSuFYA9k/oS+i1Oi61K4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7038
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, April 17, 2025 11:59 AM

[...]

>>>>+static int
>>>>+dpll_features_set(struct dpll_device *dpll, struct nlattr *a,
>>>>+		  struct netlink_ext_ack *extack)
>>>>+{
>>>>+	const struct dpll_device_info *info =3D dpll_device_info(dpll);
>>>>+	const struct dpll_device_ops *ops =3D dpll_device_ops(dpll);
>>>>+	u32 features =3D nla_get_u32(a), old_features;
>>>>+	int ret;
>>>>+
>>>>+	if (features && !(info->capabilities & features)) {
>>>>+		NL_SET_ERR_MSG_ATTR(extack, a, "dpll device not capable of this
>>>>features");
>>>>+		return -EOPNOTSUPP;
>>>>+	}
>>>>+	if (!ops->features_get || !ops->features_set) {
>>>>+		NL_SET_ERR_MSG(extack, "dpll device not supporting any
>>>>features");
>>>>+		return -EOPNOTSUPP;
>>>>+	}
>>>>+	ret =3D ops->features_get(dpll, dpll_priv(dpll), &old_features,
>>>>extack);
>>>>+	if (ret) {
>>>>+		NL_SET_ERR_MSG(extack, "unable to get old features value");
>>>>+		return ret;
>>>>+	}
>>>>+	if (old_features =3D=3D features)
>>>>+		return -EINVAL;
>>>>+
>>>>+	return ops->features_set(dpll, dpll_priv(dpll), features, extack);
>>>
>>>So you allow to enable/disable them all in once. What if user want to
>>>enable feature A and does not care about feature B that may of may not
>>>be previously set?
>>
>>Assumed that user would always request full set.
>
>Ugh.
>
>
>>
>>>How many of the features do you expect to appear in the future. I'm
>>>asking because this could be just a bool attr with a separate op to the
>>>driver. If we have 3, no problem. Benefit is, you may also extend it
>>>easily to pass some non-bool configuration. My point is, what is the
>>>benefit of features bitset here?
>>>
>>
>>Not much, at least right now..
>>Maybe one similar in nearest feature. Sure, we can go that way.
>>
>>But you mean uAPI part also have this enabled somehow per feature or
>>leave the feature bits there?
>
>I don't see reason for u32/bitfield32 bits here. Just have attr per
>feature to enable/disable it, no problem. It will be easier to work with.
>
>

OK. Fixed in v3.

Thank you!
Arkadiusz

[...]

