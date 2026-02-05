Return-Path: <linux-rdma+bounces-16563-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ge9BU9ehGnS2gMAu9opvQ
	(envelope-from <linux-rdma+bounces-16563-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 10:09:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B083BF0549
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 10:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D7083053677
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 09:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD5E3939D2;
	Thu,  5 Feb 2026 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrf3eKNZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4A392C54;
	Thu,  5 Feb 2026 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281952; cv=fail; b=jm79aQrJ+Rb97PX/bQFCbvrNIkH7Ha39UUXa/hrBPIdynfn9LyN/hyp6VaCPbt0TehsfwF2/MWcf4hRySVckohg2X7EnSxus5znTPpxOoYslhDj3wq50zeq3P5GVNG4z+lDzkgfTyMCbbkcoA/cNxJ8b70lyfrl8qXmLwt62GIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281952; c=relaxed/simple;
	bh=jutL1VfePvzFvqXniSwBb6dMvhiQGrBaZU8cKY1nm6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ghU3PtGXWCG9uFi37gwQocflPAenxyxTNNaBxzoIrqwSPGpJNuueAJeJ+Y0hIg7whR3oGvnsn+ej/piTPVzqBlDwcyaQYnU22zJRMMtDb1wwHN000mFjfHMGkiQx3IGNT1pkstpZxWU+srE9yviB4bqM5U8rujx7Ruyp1yMBXag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrf3eKNZ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770281953; x=1801817953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jutL1VfePvzFvqXniSwBb6dMvhiQGrBaZU8cKY1nm6Y=;
  b=jrf3eKNZ60ffTIRn31oVKdjyiwE8+TfFG0Mb5/T5RHnbMWhBfSWBrNwX
   zOCe5wFCSaqjiq0ZrCLwbI8KUdVJDh+DgQ96fn6o4/cSftH3kYEUkAS+0
   EldzRga3eDlTbQg+WK8+SFJFcPMPdHtfaveIegAGpK/xVjTrFG87CmmSo
   iHuVjls8vETvjCKTE+FggDsQVU6j2xF9f2TAYNQg/L7FkFhsS+mtgXzZc
   69BHbDlK0ygEZcMpS0pQm3736q2CuZWJJ98OEXXqpIL0k5q00HFjBBWBd
   fH4OF+9f39MkgenTM9tWX9T8sa0cLeXAO/e3xP17dlo/G9+P25b5kxBbK
   w==;
X-CSE-ConnectionGUID: VKDVz55CTKGQN23e6Wv4DQ==
X-CSE-MsgGUID: eAfghMfcTHO2+UIUdwOwHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71374476"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71374476"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:58:43 -0800
X-CSE-ConnectionGUID: Ro0VB2yaTpO1McMUyef0qQ==
X-CSE-MsgGUID: JqFMvbcIR/SrQ/K88KoSSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="214966439"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:58:42 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 00:58:41 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 00:58:41 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 00:58:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHoemrsyzpeC2lO0cPsYrJFrLH/CPi2KvuOPEAMG7YUDvnCn7Zoi0iNk7X4q/ytdeyW2MYGtn66AdShhZ2/hEbPpZDSVsQvSxQHeZo87eDZC1Zj5CW6CfyqaSRhatuRZV02sfPYhdr8phl/iBDisLuIs0U5cFt/yjvBxDYF8iUhisdJ2kLox4hV1eijI9ShBQWLNhpxEl76ejiWz7baSqmz5BI6GSpeQsk2bgPl6b/pxVtm6fA83Rh8XIYurn1xN5LC22TltxDJs9ElKHf5zmkbUVDaHiZ7hZD4DOb4P/EJEff5kQArWXUSrXcfzi/tMnyHg/2IZwMBgJCdCJpp51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCvmn4yb4w7YRcaSqlDJjhthiZvF7m0iMKSFXs2UwcQ=;
 b=o2PV8zbF1i18jk2Qfw96/9rP5KMa3e4XFSgu/cdMqWSeMznrjkw61Ew0hDflsmcrd29E/m3EA1ytUiAmAfWHQzxHAmQ539PjzSh1GR5/yOqe3/AC4qM9WexTozvgkloKsHUHle2IHw6bHQHFXcU+Ar7vTs040tDWYCHDnsKfo3HkNk6LWBsWpIePcGBAgtOdVdGRn88eYYWpKJd47QUMNjXIu6yC3WhY+QRjgO8qjRpQwPZsGMErToemmz68b/jF/pwpi4ZDpLwsHWWCiT2qDbgQMqpYkxnyudyC5Q4zsTQrBpmm64ydlSo1bWqq1/2gDqeNjSpNjigsMT+tyUC3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14)
 by SJ5PPF263E38237.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 08:58:36 +0000
Received: from LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::6f0e:9ee3:9e98:1ed]) by LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::6f0e:9ee3:9e98:1ed%3]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 08:58:36 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Leon Romanovsky <leon@kernel.org>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Richard Cochran
	<richardcochran@gmail.com>, Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Mark Bloch <mbloch@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next v5 7/9] dpll: Add reference
 count tracking support
Thread-Topic: [Intel-wired-lan] [PATCH net-next v5 7/9] dpll: Add reference
 count tracking support
Thread-Index: AQHclTRU3Iwjc5zq4EO6sqE+jcFpQLVz0CrA
Date: Thu, 5 Feb 2026 08:58:36 +0000
Message-ID: <LV4PR11MB949129F71F676FEC95C67CB89B99A@LV4PR11MB9491.namprd11.prod.outlook.com>
References: <20260203174002.705176-1-ivecera@redhat.com>
 <20260203174002.705176-8-ivecera@redhat.com>
In-Reply-To: <20260203174002.705176-8-ivecera@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV4PR11MB9491:EE_|SJ5PPF263E38237:EE_
x-ms-office365-filtering-correlation-id: 45c45561-5131-433e-e494-08de6494bfa9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?MgBmDTAOBfX/qRhY6WlL7E0kkZU+JshsWZPGFyVfzHyqvMKdO1MaJmJdqULL?=
 =?us-ascii?Q?IT1ghG/eaS/Y/2tBZv3Vlg+7FhPtzqfOcc1nknCdVIV6tMzIWt7/f+FUFPq9?=
 =?us-ascii?Q?w5OabBYRysR40Uf2JjMCf3EnvqdKi78VuGYuXcB9eKO4AR+EPxikIEFXeIbY?=
 =?us-ascii?Q?SqPFXq0BxJr9il2H0Mcmx23D8hyYbscmT0t0V/mIUEf4hKayKWxE5Z8Kon/o?=
 =?us-ascii?Q?XF1M39Gvi+Np++yQjF1QK9Ofq8LPu5gm/tc0tHOqisGfwjpBOuXTJoH8mPu/?=
 =?us-ascii?Q?eQu6USMVm8VqY8pVEjopQXSKQs2uwEVffH/eyLV8FfKTDzBBc1/ndQ4W7FnH?=
 =?us-ascii?Q?3TT1/MjTOj2yyphTbfwsyDkavZHbI7nxyGkAkTVA86YddMYQlFSdnI7+rmOM?=
 =?us-ascii?Q?R+jFEbHT97SrJy1KFKBiskNCa1HD4ME2NAF3k5QwtwMqVpOT5SgjlrKG5M74?=
 =?us-ascii?Q?9fHLtUrgX8e2ci9CsL/Uoimkr29NLws5H9R7lkw6jScQGwL7ToulFLdKjG+q?=
 =?us-ascii?Q?DbUpqw2+crt555V6uCuPBW30z62a7v9IWiIoL0oZdaK8P6ejmPX/IYFwBX0w?=
 =?us-ascii?Q?3ZFhp8m2r3QsflrLANduVw03WaT7obiPRVXVos+j2nymW3K1nDB29BAyNTo4?=
 =?us-ascii?Q?IZ8SbtCO5Ru+TLwQ+XiAJJevNzW6cYzHVMZsmJhUFOVqeQkEf1V1gT58ZTQe?=
 =?us-ascii?Q?2OIbmfu3J62+gMNWsHO8eQWwpkSZIri3IJkzB9CVmlciBCKacnr5I1wpbWNM?=
 =?us-ascii?Q?vuNFF6srni5FQeKo0SA63P4uXMXwAs/7Z3qKKnD61gnYjPqRmm89BF5nfYIO?=
 =?us-ascii?Q?p1JdabG99fuIz1AhZDiIIYlzomgx0kZ69xq07DhgSasjxP6BPUvGTeZEUbZs?=
 =?us-ascii?Q?n5rzhZZKyTXVbeLvhML2lNErmfG6plFXWY4n7GluY1vQtH1l4ftTlobO1l/K?=
 =?us-ascii?Q?Gt6/prSa11ERP3GvgYjPF7Mis1YT83t6atLZVpFKqg9dJVyoLornS61rTuEz?=
 =?us-ascii?Q?fKKChSqDLJ6gNi6BvT+rCA9hxziIxxgz18ps4Zs0RLWqDGBvYDfpd3/87pFd?=
 =?us-ascii?Q?XU+YCI7yuCkLFjZkaJTaBcK26/P92qDjYOfX6Up2J6ikxUCkFx8BuJGGTLNP?=
 =?us-ascii?Q?KN6TQFmc7RPZfiA5hex1nU78yzcXbiUblWkvZ3BwIkV5tSDMnsIy/VxYJzYc?=
 =?us-ascii?Q?/Sj0fxSsjoGebGkzTNgdSKXH+tFlp6w3fvIdClQdzFVf5gMT0NI+KE4oZjV3?=
 =?us-ascii?Q?TThwaLm0MxvoYUMB90rKJSMrtvOUqn3dIz615c4M0L9sffPcClAUVyAFC2IE?=
 =?us-ascii?Q?0uC+IhB/aFoJi/drIpDejn/dV+MkB67c3aJYqaGN0+pdfSq2ClJTD3s3tn+0?=
 =?us-ascii?Q?ElYHCUvRIaj+u1ZNsiqSB+g7AX9G5kD5fWRmmLRlmOYN4s46nRtrpYOyDXVd?=
 =?us-ascii?Q?eB9aKjwF1NVjRhF70qYESpxOfb5V3jXGEoKusWSEFKQozzzkcu2H1C0l8mIQ?=
 =?us-ascii?Q?yzGiVewUlB3ZotfF2R2YWxhtgzUGtmaTtDMTPciI8Wx+fpSHNpEwKNaeSEMH?=
 =?us-ascii?Q?YIgfFykoF2Gy5OXbGO2fU70pJyg6lVSBjINCT6F98raUB7jn1f6eTLySIvMm?=
 =?us-ascii?Q?DXPYV/6gin7p5VtFxhTAQHY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV4PR11MB9491.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PqUESnTLNLhvGuOdjciDedxuy8xnhrPysI6XPy56WY8rwDk2kwhDjbxJDpxu?=
 =?us-ascii?Q?brHWdbwG2Xf4vutOGIWXkF1F1QaQyD3PJAIa/cf35v/N2aV6yNotIjdR/0hP?=
 =?us-ascii?Q?fKFlhkpNpoMIRYaA+sUypk62ZrwAjbgTDyHmYEz4P77e5AUPEAd4TR5z1hjF?=
 =?us-ascii?Q?JukBwI6bzamMiAwNwl8xLHV4MAWV1bXGNNwkYKWhbQDtyKHFPm/upAY/ICO5?=
 =?us-ascii?Q?+Czpol9+zi5Qxh99nr+xYTD+F8Fz3n3jHNFCGho8wCSyXaXNNPACVVixpUDt?=
 =?us-ascii?Q?YjwiN/u31WO3396n6ZnhDLa3TCBSVmkuudovTPiI15fzYuX3SzG0Z5JoOKlv?=
 =?us-ascii?Q?8LRsMpKDCfe7kYDplZXD879CQMOgCgUSvf21uaIAynYAJTvdq2XaGxg82TH8?=
 =?us-ascii?Q?i20N8UKxrBDJCyT5oBXHreIHLUd/kd6OiOZtMhid+rf4RTFJUbpyR7JmCNwc?=
 =?us-ascii?Q?WFr7YONdFVqo98W4rCL0tDkz3if5iqlH275em8vTc1OuxFHOqfkUyOww6WM1?=
 =?us-ascii?Q?RXuOm74SQ70F6fHyeUrw+7R6ww/MLW5CXEPS2mvmI+n19VkG3VOEQAoiiPuI?=
 =?us-ascii?Q?3sRi7h80dPWvYU3rCfMwcHFdx5WZgJz742baGwVjqKwebJsJe74EsHwgMoP1?=
 =?us-ascii?Q?ayKsFCPg91RN9d+M+UzQUuIpreWqA17v6MgHUrOkwlWvjcLX0tZBSYrO0ohl?=
 =?us-ascii?Q?Xzj1b3nqhdVP6NpjpKVmxk76GDfcsn/DwtUtRQ6PUNea+D3ueUNerGKItclI?=
 =?us-ascii?Q?rNvEY4knwfoIpwXjK/wlGXLe9ElhIU4rlFjOyAVXjYuSUEbBhDXAiWIJBQ++?=
 =?us-ascii?Q?4qYXRFATpKphgfIKq12PAnXbLhWwmUHoX0BMPfnKU6S/sRNZhwbzsMdZ68YH?=
 =?us-ascii?Q?6znTsHfA+25HQadNlEz3XYU/6uX2an+FmCzpknSVleGFMzvvkmEvKMigOlaz?=
 =?us-ascii?Q?mVlbY9R/DKv0FgSMZrRoSP973fp7zdalWm5Tyqs9qsNX0d7f5kYrd4hIhhou?=
 =?us-ascii?Q?p7y77IfyMaHHAFFdZvqqUEo70mjukX8TWthR4BDVi/mRzm0DO1WRjhN6Oxv0?=
 =?us-ascii?Q?5b5s1dpgyIlFgsJ738BJPp3roMM9e1NoAyBeLuyygOwX0Xcl/oD+8FTCdjHl?=
 =?us-ascii?Q?+U76AGa4wGLhwjzT+OeXHkbfg0kHUQ9buxGzzadatxIpWP/FpE//JJ+KPeBi?=
 =?us-ascii?Q?V0IE3jWERsrZkDKoS4oVmta/w1XsfN53ch5jr+fMqWpgI4hIbQJqaq6HScVX?=
 =?us-ascii?Q?zo5jAvtChCdRtvxGQdQKyWftghrSz7CBYauQhful0E5SeSxSK9qBnYsIoNA1?=
 =?us-ascii?Q?Hc+s6w8CEXwE5Jj8ir94b64qmGhDgsnu7ivXeugEwzo0McLxUEBIXXv27hEr?=
 =?us-ascii?Q?hWu3EY2QdLpyUP0X6ru5uZewVHewqGvgpuQ14C0R4SYHG2ywc6Dri5oGMyfj?=
 =?us-ascii?Q?wTCOV5jR/ng7wkG64F8bX6SVAfx2nMdC8Zgglc2++/iaS1NChHgk24pz8wIP?=
 =?us-ascii?Q?G0tyjSMMR1m29CFuB/vR2svm21hDyW564HZ6mFEZOY/6VqNChB6WxZSS2quL?=
 =?us-ascii?Q?wAPmBCk2mvGtLxpFHsagpFg3UziUlrBPJ1ewIfsty7zi638J1yZYdyo4ATAn?=
 =?us-ascii?Q?B2uppOCwnT60tUZAgDwzfRFMs976CESa4OJVWW/NkI/DQzwxGNj29+7cxVkN?=
 =?us-ascii?Q?GwZfQNueVOkyYk+s6gmmGgzO6TglNQRO92jspYO+lW9670/TOotr+WtLmm1v?=
 =?us-ascii?Q?cE8h2WZIYdSz3Dee8EjT9eliuMbkkm8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c45561-5131-433e-e494-08de6494bfa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 08:58:36.6623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hom47jXmVtBuGG244cm3FmiZrX2Ud7okihO3xDz1oCI6q9aEPROzMNP12GIlAoq+cnZSX3QrIE/ihcxIypGpmJOWiZXKZOlQikr39PAOSxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF263E38237
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
	TAGGED_FROM(0.00)[bounces-16563-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,intel.com,kernel.org,vger.kernel.org,lists.osuosl.org,redhat.com,resnulli.us,gmail.com,microchip.com,linux.dev,nvidia.com,lunn.ch,davemloft.net];
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
X-Rspamd-Queue-Id: B083BF0549
X-Rspamd-Action: no action

>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Ivan Vecera
>Sent: Tuesday, February 3, 2026 6:40 PM
>
>Add support for the REF_TRACKER infrastructure to the DPLL subsystem.
>
>When enabled, this allows developers to track and debug reference counting
>leaks or imbalances for dpll_device and dpll_pin objects. It records stack
>traces for every get/put operation and exposes this information via
>debugfs at:
>  /sys/kernel/debug/ref_tracker/dpll_device_*
>  /sys/kernel/debug/ref_tracker/dpll_pin_*
>
>The following API changes are made to support this:
>1. dpll_device_get() / dpll_device_put() now accept a 'dpll_tracker *'
>   (which is a typedef to 'struct ref_tracker *' when enabled, or an empty
>   struct otherwise).
>2. dpll_pin_get() / dpll_pin_put() and fwnode_dpll_pin_find() similarly
>   accept the tracker argument.
>3. Internal registration structures now hold a tracker to associate the
>   reference held by the registration with the specific owner.
>
>All existing in-tree drivers (ice, mlx5, ptp_ocp, zl3073x) are updated
>to pass NULL for the new tracker argument, maintaining current behavior
>while enabling future debugging capabilities.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

LGTM,
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>Co-developed-by: Petr Oros <poros@redhat.com>
>Signed-off-by: Petr Oros <poros@redhat.com>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>---
>v5:
>* fixed typo
>v4:
>* added missing tracker parameter to fwnode_dpll_pin_find() stub
>v3:
>* added Kconfig dependency on STACKTRACE_SUPPORT and DEBUG_KERNEL
>---
> drivers/dpll/Kconfig                          | 15 +++
> drivers/dpll/dpll_core.c                      | 98 ++++++++++++++-----
> drivers/dpll/dpll_core.h                      |  5 +
> drivers/dpll/zl3073x/dpll.c                   | 12 +--
> drivers/net/ethernet/intel/ice/ice_dpll.c     | 14 +--
> .../net/ethernet/mellanox/mlx5/core/dpll.c    | 13 +--
> drivers/ptp/ptp_ocp.c                         | 15 +--
> include/linux/dpll.h                          | 21 ++--
> 8 files changed, 139 insertions(+), 54 deletions(-)
>
>diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig
>index ade872c915ac6..be98969f040ab 100644
>--- a/drivers/dpll/Kconfig
>+++ b/drivers/dpll/Kconfig
>@@ -8,6 +8,21 @@ menu "DPLL device support"
> config DPLL
> 	bool
>
>+config DPLL_REFCNT_TRACKER
>+	bool "DPLL reference count tracking"
>+	depends on DEBUG_KERNEL && STACKTRACE_SUPPORT && DPLL
>+	select REF_TRACKER
>+	help
>+	  Enable reference count tracking for DPLL devices and pins.
>+	  This helps debugging reference leaks and use-after-free bugs
>+	  by recording stack traces for each get/put operation.
>+
>+	  The tracking information is exposed via debugfs at:
>+	    /sys/kernel/debug/ref_tracker/dpll_device_*
>+	    /sys/kernel/debug/ref_tracker/dpll_pin_*
>+
>+	  If unsure, say N.
>+
> source "drivers/dpll/zl3073x/Kconfig"
>
> endmenu
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index f6ab4f0cad84d..627a5b39a0efd 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -41,6 +41,7 @@ struct dpll_device_registration {
> 	struct list_head list;
> 	const struct dpll_device_ops *ops;
> 	void *priv;
>+	dpll_tracker tracker;
> };
>
> struct dpll_pin_registration {
>@@ -48,6 +49,7 @@ struct dpll_pin_registration {
> 	const struct dpll_pin_ops *ops;
> 	void *priv;
> 	void *cookie;
>+	dpll_tracker tracker;
> };
>
> static int call_dpll_notifiers(unsigned long action, void *info)
>@@ -83,33 +85,68 @@ void dpll_pin_notify(struct dpll_pin *pin, unsigned
>long action)
> 	call_dpll_notifiers(action, &info);
> }
>
>-static void __dpll_device_hold(struct dpll_device *dpll)
>+static void dpll_device_tracker_alloc(struct dpll_device *dpll,
>+				      dpll_tracker *tracker)
> {
>+#ifdef CONFIG_DPLL_REFCNT_TRACKER
>+	ref_tracker_alloc(&dpll->refcnt_tracker, tracker, GFP_KERNEL);
>+#endif
>+}
>+
>+static void dpll_device_tracker_free(struct dpll_device *dpll,
>+				     dpll_tracker *tracker)
>+{
>+#ifdef CONFIG_DPLL_REFCNT_TRACKER
>+	ref_tracker_free(&dpll->refcnt_tracker, tracker);
>+#endif
>+}
>+
>+static void __dpll_device_hold(struct dpll_device *dpll, dpll_tracker
>*tracker)
>+{
>+	dpll_device_tracker_alloc(dpll, tracker);
> 	refcount_inc(&dpll->refcount);
> }
>
>-static void __dpll_device_put(struct dpll_device *dpll)
>+static void __dpll_device_put(struct dpll_device *dpll, dpll_tracker
>*tracker)
> {
>+	dpll_device_tracker_free(dpll, tracker);
> 	if (refcount_dec_and_test(&dpll->refcount)) {
> 		ASSERT_DPLL_NOT_REGISTERED(dpll);
> 		WARN_ON_ONCE(!xa_empty(&dpll->pin_refs));
> 		xa_destroy(&dpll->pin_refs);
> 		xa_erase(&dpll_device_xa, dpll->id);
> 		WARN_ON(!list_empty(&dpll->registration_list));
>+		ref_tracker_dir_exit(&dpll->refcnt_tracker);
> 		kfree(dpll);
> 	}
> }
>
>-static void __dpll_pin_hold(struct dpll_pin *pin)
>+static void dpll_pin_tracker_alloc(struct dpll_pin *pin, dpll_tracker
>*tracker)
> {
>+#ifdef CONFIG_DPLL_REFCNT_TRACKER
>+	ref_tracker_alloc(&pin->refcnt_tracker, tracker, GFP_KERNEL);
>+#endif
>+}
>+
>+static void dpll_pin_tracker_free(struct dpll_pin *pin, dpll_tracker
>*tracker)
>+{
>+#ifdef CONFIG_DPLL_REFCNT_TRACKER
>+	ref_tracker_free(&pin->refcnt_tracker, tracker);
>+#endif
>+}
>+
>+static void __dpll_pin_hold(struct dpll_pin *pin, dpll_tracker *tracker)
>+{
>+	dpll_pin_tracker_alloc(pin, tracker);
> 	refcount_inc(&pin->refcount);
> }
>
> static void dpll_pin_idx_free(u32 pin_idx);
> static void dpll_pin_prop_free(struct dpll_pin_properties *prop);
>
>-static void __dpll_pin_put(struct dpll_pin *pin)
>+static void __dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker)
> {
>+	dpll_pin_tracker_free(pin, tracker);
> 	if (refcount_dec_and_test(&pin->refcount)) {
> 		xa_erase(&dpll_pin_xa, pin->id);
> 		xa_destroy(&pin->dpll_refs);
>@@ -118,6 +155,7 @@ static void __dpll_pin_put(struct dpll_pin *pin)
> 		dpll_pin_prop_free(&pin->prop);
> 		fwnode_handle_put(pin->fwnode);
> 		dpll_pin_idx_free(pin->pin_idx);
>+		ref_tracker_dir_exit(&pin->refcnt_tracker);
> 		kfree_rcu(pin, rcu);
> 	}
> }
>@@ -191,7 +229,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct
>dpll_pin *pin,
> 	reg->ops =3D ops;
> 	reg->priv =3D priv;
> 	reg->cookie =3D cookie;
>-	__dpll_pin_hold(pin);
>+	__dpll_pin_hold(pin, &reg->tracker);
> 	if (ref_exists)
> 		refcount_inc(&ref->refcount);
> 	list_add_tail(&reg->list, &ref->registration_list);
>@@ -214,7 +252,7 @@ static int dpll_xa_ref_pin_del(struct xarray *xa_pins,
>struct dpll_pin *pin,
> 		if (WARN_ON(!reg))
> 			return -EINVAL;
> 		list_del(&reg->list);
>-		__dpll_pin_put(pin);
>+		__dpll_pin_put(pin, &reg->tracker);
> 		kfree(reg);
> 		if (refcount_dec_and_test(&ref->refcount)) {
> 			xa_erase(xa_pins, i);
>@@ -272,7 +310,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct
>dpll_device *dpll,
> 	reg->ops =3D ops;
> 	reg->priv =3D priv;
> 	reg->cookie =3D cookie;
>-	__dpll_device_hold(dpll);
>+	__dpll_device_hold(dpll, &reg->tracker);
> 	if (ref_exists)
> 		refcount_inc(&ref->refcount);
> 	list_add_tail(&reg->list, &ref->registration_list);
>@@ -295,7 +333,7 @@ dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct
>dpll_device *dpll,
> 		if (WARN_ON(!reg))
> 			return;
> 		list_del(&reg->list);
>-		__dpll_device_put(dpll);
>+		__dpll_device_put(dpll, &reg->tracker);
> 		kfree(reg);
> 		if (refcount_dec_and_test(&ref->refcount)) {
> 			xa_erase(xa_dplls, i);
>@@ -337,6 +375,7 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx,
>struct module *module)
> 		return ERR_PTR(ret);
> 	}
> 	xa_init_flags(&dpll->pin_refs, XA_FLAGS_ALLOC);
>+	ref_tracker_dir_init(&dpll->refcnt_tracker, 128, "dpll_device");
>
> 	return dpll;
> }
>@@ -346,6 +385,7 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx,
>struct module *module)
>  * @clock_id: clock_id of creator
>  * @device_idx: idx given by device driver
>  * @module: reference to registering module
>+ * @tracker: tracking object for the acquired reference
>  *
>  * Get existing object of a dpll device, unique for given arguments.
>  * Create new if doesn't exist yet.
>@@ -356,7 +396,8 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx,
>struct module *module)
>  * * ERR_PTR(X) - error
>  */
> struct dpll_device *
>-dpll_device_get(u64 clock_id, u32 device_idx, struct module *module)
>+dpll_device_get(u64 clock_id, u32 device_idx, struct module *module,
>+		dpll_tracker *tracker)
> {
> 	struct dpll_device *dpll, *ret =3D NULL;
> 	unsigned long index;
>@@ -366,13 +407,17 @@ dpll_device_get(u64 clock_id, u32 device_idx, struct
>module *module)
> 		if (dpll->clock_id =3D=3D clock_id &&
> 		    dpll->device_idx =3D=3D device_idx &&
> 		    dpll->module =3D=3D module) {
>-			__dpll_device_hold(dpll);
>+			__dpll_device_hold(dpll, tracker);
> 			ret =3D dpll;
> 			break;
> 		}
> 	}
>-	if (!ret)
>+	if (!ret) {
> 		ret =3D dpll_device_alloc(clock_id, device_idx, module);
>+		if (!IS_ERR(ret))
>+			dpll_device_tracker_alloc(ret, tracker);
>+	}
>+
> 	mutex_unlock(&dpll_lock);
>
> 	return ret;
>@@ -382,15 +427,16 @@ EXPORT_SYMBOL_GPL(dpll_device_get);
> /**
>  * dpll_device_put - decrease the refcount and free memory if possible
>  * @dpll: dpll_device struct pointer
>+ * @tracker: tracking object for the acquired reference
>  *
>  * Context: Acquires a lock (dpll_lock)
>  * Drop reference for a dpll device, if all references are gone, delete
>  * dpll device object.
>  */
>-void dpll_device_put(struct dpll_device *dpll)
>+void dpll_device_put(struct dpll_device *dpll, dpll_tracker *tracker)
> {
> 	mutex_lock(&dpll_lock);
>-	__dpll_device_put(dpll);
>+	__dpll_device_put(dpll, tracker);
> 	mutex_unlock(&dpll_lock);
> }
> EXPORT_SYMBOL_GPL(dpll_device_put);
>@@ -452,7 +498,7 @@ int dpll_device_register(struct dpll_device *dpll,
>enum dpll_type type,
> 	reg->ops =3D ops;
> 	reg->priv =3D priv;
> 	dpll->type =3D type;
>-	__dpll_device_hold(dpll);
>+	__dpll_device_hold(dpll, &reg->tracker);
> 	first_registration =3D list_empty(&dpll->registration_list);
> 	list_add_tail(&reg->list, &dpll->registration_list);
> 	if (!first_registration) {
>@@ -492,7 +538,7 @@ void dpll_device_unregister(struct dpll_device *dpll,
> 		return;
> 	}
> 	list_del(&reg->list);
>-	__dpll_device_put(dpll);
>+	__dpll_device_put(dpll, &reg->tracker);
> 	kfree(reg);
>
> 	if (!list_empty(&dpll->registration_list)) {
>@@ -622,6 +668,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>module *module,
> 			      &dpll_pin_xa_id, GFP_KERNEL);
> 	if (ret < 0)
> 		goto err_xa_alloc;
>+	ref_tracker_dir_init(&pin->refcnt_tracker, 128, "dpll_pin");
> 	return pin;
> err_xa_alloc:
> 	xa_destroy(&pin->dpll_refs);
>@@ -683,6 +730,7 @@ EXPORT_SYMBOL_GPL(unregister_dpll_notifier);
>  * @pin_idx: idx given by dev driver
>  * @module: reference to registering module
>  * @prop: dpll pin properties
>+ * @tracker: tracking object for the acquired reference
>  *
>  * Get existing object of a pin (unique for given arguments) or create
>new
>  * if doesn't exist yet.
>@@ -694,7 +742,7 @@ EXPORT_SYMBOL_GPL(unregister_dpll_notifier);
>  */
> struct dpll_pin *
> dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
>-	     const struct dpll_pin_properties *prop)
>+	     const struct dpll_pin_properties *prop, dpll_tracker *tracker)
> {
> 	struct dpll_pin *pos, *ret =3D NULL;
> 	unsigned long i;
>@@ -704,13 +752,16 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct
>module *module,
> 		if (pos->clock_id =3D=3D clock_id &&
> 		    pos->pin_idx =3D=3D pin_idx &&
> 		    pos->module =3D=3D module) {
>-			__dpll_pin_hold(pos);
>+			__dpll_pin_hold(pos, tracker);
> 			ret =3D pos;
> 			break;
> 		}
> 	}
>-	if (!ret)
>+	if (!ret) {
> 		ret =3D dpll_pin_alloc(clock_id, pin_idx, module, prop);
>+		if (!IS_ERR(ret))
>+			dpll_pin_tracker_alloc(ret, tracker);
>+	}
> 	mutex_unlock(&dpll_lock);
>
> 	return ret;
>@@ -720,15 +771,16 @@ EXPORT_SYMBOL_GPL(dpll_pin_get);
> /**
>  * dpll_pin_put - decrease the refcount and free memory if possible
>  * @pin: pointer to a pin to be put
>+ * @tracker: tracking object for the acquired reference
>  *
>  * Drop reference for a pin, if all references are gone, delete pin
>object.
>  *
>  * Context: Acquires a lock (dpll_lock)
>  */
>-void dpll_pin_put(struct dpll_pin *pin)
>+void dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker)
> {
> 	mutex_lock(&dpll_lock);
>-	__dpll_pin_put(pin);
>+	__dpll_pin_put(pin, tracker);
> 	mutex_unlock(&dpll_lock);
> }
> EXPORT_SYMBOL_GPL(dpll_pin_put);
>@@ -752,6 +804,7 @@ EXPORT_SYMBOL_GPL(dpll_pin_fwnode_set);
> /**
>  * fwnode_dpll_pin_find - find dpll pin by firmware node reference
>  * @fwnode: reference to firmware node
>+ * @tracker: tracking object for the acquired reference
>  *
>  * Get existing object of a pin that is associated with given firmware
>node
>  * reference.
>@@ -761,7 +814,8 @@ EXPORT_SYMBOL_GPL(dpll_pin_fwnode_set);
>  * * valid dpll_pin pointer on success
>  * * NULL when no such pin exists
>  */
>-struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
>+struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode,
>+				      dpll_tracker *tracker)
> {
> 	struct dpll_pin *pin, *ret =3D NULL;
> 	unsigned long index;
>@@ -769,7 +823,7 @@ struct dpll_pin *fwnode_dpll_pin_find(struct
>fwnode_handle *fwnode)
> 	mutex_lock(&dpll_lock);
> 	xa_for_each(&dpll_pin_xa, index, pin) {
> 		if (pin->fwnode =3D=3D fwnode) {
>-			__dpll_pin_hold(pin);
>+			__dpll_pin_hold(pin, tracker);
> 			ret =3D pin;
> 			break;
> 		}
>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>index b7b4bb251f739..71ac88ef20172 100644
>--- a/drivers/dpll/dpll_core.h
>+++ b/drivers/dpll/dpll_core.h
>@@ -10,6 +10,7 @@
> #include <linux/dpll.h>
> #include <linux/list.h>
> #include <linux/refcount.h>
>+#include <linux/ref_tracker.h>
> #include "dpll_nl.h"
>
> #define DPLL_REGISTERED		XA_MARK_1
>@@ -23,6 +24,7 @@
>  * @type:		type of a dpll
>  * @pin_refs:		stores pins registered within a dpll
>  * @refcount:		refcount
>+ * @refcnt_tracker:	ref_tracker directory for debugging reference
>leaks
>  * @registration_list:	list of registered ops and priv data of dpll
>owners
>  **/
> struct dpll_device {
>@@ -33,6 +35,7 @@ struct dpll_device {
> 	enum dpll_type type;
> 	struct xarray pin_refs;
> 	refcount_t refcount;
>+	struct ref_tracker_dir refcnt_tracker;
> 	struct list_head registration_list;
> };
>
>@@ -48,6 +51,7 @@ struct dpll_device {
>  * @ref_sync_pins:	hold references to pins for Reference SYNC feature
>  * @prop:		pin properties copied from the registerer
>  * @refcount:		refcount
>+ * @refcnt_tracker:	ref_tracker directory for debugging reference
>leaks
>  * @rcu:		rcu_head for kfree_rcu()
>  **/
> struct dpll_pin {
>@@ -61,6 +65,7 @@ struct dpll_pin {
> 	struct xarray ref_sync_pins;
> 	struct dpll_pin_properties prop;
> 	refcount_t refcount;
>+	struct ref_tracker_dir refcnt_tracker;
> 	struct rcu_head rcu;
> };
>
>diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>index 9eed21088adac..8788bcab7ec53 100644
>--- a/drivers/dpll/zl3073x/dpll.c
>+++ b/drivers/dpll/zl3073x/dpll.c
>@@ -1480,7 +1480,7 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin
>*pin, u32 index)
>
> 	/* Create or get existing DPLL pin */
> 	pin->dpll_pin =3D dpll_pin_get(zldpll->dev->clock_id, index,
>THIS_MODULE,
>-				     &props->dpll_props);
>+				     &props->dpll_props, NULL);
> 	if (IS_ERR(pin->dpll_pin)) {
> 		rc =3D PTR_ERR(pin->dpll_pin);
> 		goto err_pin_get;
>@@ -1503,7 +1503,7 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin
>*pin, u32 index)
> 	return 0;
>
> err_register:
>-	dpll_pin_put(pin->dpll_pin);
>+	dpll_pin_put(pin->dpll_pin, NULL);
> err_prio_get:
> 	pin->dpll_pin =3D NULL;
> err_pin_get:
>@@ -1534,7 +1534,7 @@ zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin
>*pin)
> 	/* Unregister the pin */
> 	dpll_pin_unregister(zldpll->dpll_dev, pin->dpll_pin, ops, pin);
>
>-	dpll_pin_put(pin->dpll_pin);
>+	dpll_pin_put(pin->dpll_pin, NULL);
> 	pin->dpll_pin =3D NULL;
> }
>
>@@ -1708,7 +1708,7 @@ zl3073x_dpll_device_register(struct zl3073x_dpll
>*zldpll)
> 				       dpll_mode_refsel);
>
> 	zldpll->dpll_dev =3D dpll_device_get(zldev->clock_id, zldpll->id,
>-					   THIS_MODULE);
>+					   THIS_MODULE, NULL);
> 	if (IS_ERR(zldpll->dpll_dev)) {
> 		rc =3D PTR_ERR(zldpll->dpll_dev);
> 		zldpll->dpll_dev =3D NULL;
>@@ -1720,7 +1720,7 @@ zl3073x_dpll_device_register(struct zl3073x_dpll
>*zldpll)
> 				  zl3073x_prop_dpll_type_get(zldev, zldpll->id),
> 				  &zl3073x_dpll_device_ops, zldpll);
> 	if (rc) {
>-		dpll_device_put(zldpll->dpll_dev);
>+		dpll_device_put(zldpll->dpll_dev, NULL);
> 		zldpll->dpll_dev =3D NULL;
> 	}
>
>@@ -1743,7 +1743,7 @@ zl3073x_dpll_device_unregister(struct zl3073x_dpll
>*zldpll)
>
> 	dpll_device_unregister(zldpll->dpll_dev, &zl3073x_dpll_device_ops,
> 			       zldpll);
>-	dpll_device_put(zldpll->dpll_dev);
>+	dpll_device_put(zldpll->dpll_dev, NULL);
> 	zldpll->dpll_dev =3D NULL;
> }
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
>b/drivers/net/ethernet/intel/ice/ice_dpll.c
>index 53b54e395a2ed..64b7b045ecd58 100644
>--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
>@@ -2814,7 +2814,7 @@ static void ice_dpll_release_pins(struct
>ice_dpll_pin *pins, int count)
> 	int i;
>
> 	for (i =3D 0; i < count; i++)
>-		dpll_pin_put(pins[i].pin);
>+		dpll_pin_put(pins[i].pin, NULL);
> }
>
> /**
>@@ -2840,7 +2840,7 @@ ice_dpll_get_pins(struct ice_pf *pf, struct
>ice_dpll_pin *pins,
>
> 	for (i =3D 0; i < count; i++) {
> 		pins[i].pin =3D dpll_pin_get(clock_id, i + start_idx,
>THIS_MODULE,
>-					   &pins[i].prop);
>+					   &pins[i].prop, NULL);
> 		if (IS_ERR(pins[i].pin)) {
> 			ret =3D PTR_ERR(pins[i].pin);
> 			goto release_pins;
>@@ -2851,7 +2851,7 @@ ice_dpll_get_pins(struct ice_pf *pf, struct
>ice_dpll_pin *pins,
>
> release_pins:
> 	while (--i >=3D 0)
>-		dpll_pin_put(pins[i].pin);
>+		dpll_pin_put(pins[i].pin, NULL);
> 	return ret;
> }
>
>@@ -3037,7 +3037,7 @@ static void ice_dpll_deinit_rclk_pin(struct ice_pf
>*pf)
> 	if (WARN_ON_ONCE(!vsi || !vsi->netdev))
> 		return;
> 	dpll_netdev_pin_clear(vsi->netdev);
>-	dpll_pin_put(rclk->pin);
>+	dpll_pin_put(rclk->pin, NULL);
> }
>
> /**
>@@ -3247,7 +3247,7 @@ ice_dpll_deinit_dpll(struct ice_pf *pf, struct
>ice_dpll *d, bool cgu)
> {
> 	if (cgu)
> 		dpll_device_unregister(d->dpll, d->ops, d);
>-	dpll_device_put(d->dpll);
>+	dpll_device_put(d->dpll, NULL);
> }
>
> /**
>@@ -3271,7 +3271,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct
>ice_dpll *d, bool cgu,
> 	u64 clock_id =3D pf->dplls.clock_id;
> 	int ret;
>
>-	d->dpll =3D dpll_device_get(clock_id, d->dpll_idx, THIS_MODULE);
>+	d->dpll =3D dpll_device_get(clock_id, d->dpll_idx, THIS_MODULE, NULL);
> 	if (IS_ERR(d->dpll)) {
> 		ret =3D PTR_ERR(d->dpll);
> 		dev_err(ice_pf_to_dev(pf),
>@@ -3287,7 +3287,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct
>ice_dpll *d, bool cgu,
> 		ice_dpll_update_state(pf, d, true);
> 		ret =3D dpll_device_register(d->dpll, type, ops, d);
> 		if (ret) {
>-			dpll_device_put(d->dpll);
>+			dpll_device_put(d->dpll, NULL);
> 			return ret;
> 		}
> 		d->ops =3D ops;
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>index 3ea8a1766ae28..541d83e5d7183 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>@@ -438,7 +438,7 @@ static int mlx5_dpll_probe(struct auxiliary_device
>*adev,
> 	auxiliary_set_drvdata(adev, mdpll);
>
> 	/* Multiple mdev instances might share one DPLL device. */
>-	mdpll->dpll =3D dpll_device_get(clock_id, 0, THIS_MODULE);
>+	mdpll->dpll =3D dpll_device_get(clock_id, 0, THIS_MODULE, NULL);
> 	if (IS_ERR(mdpll->dpll)) {
> 		err =3D PTR_ERR(mdpll->dpll);
> 		goto err_free_mdpll;
>@@ -451,7 +451,8 @@ static int mlx5_dpll_probe(struct auxiliary_device
>*adev,
>
> 	/* Multiple mdev instances might share one DPLL pin. */
> 	mdpll->dpll_pin =3D dpll_pin_get(clock_id, mlx5_get_dev_index(mdev),
>-				       THIS_MODULE, &mlx5_dpll_pin_properties);
>+				       THIS_MODULE, &mlx5_dpll_pin_properties,
>+				       NULL);
> 	if (IS_ERR(mdpll->dpll_pin)) {
> 		err =3D PTR_ERR(mdpll->dpll_pin);
> 		goto err_unregister_dpll_device;
>@@ -479,11 +480,11 @@ static int mlx5_dpll_probe(struct auxiliary_device
>*adev,
> 	dpll_pin_unregister(mdpll->dpll, mdpll->dpll_pin,
> 			    &mlx5_dpll_pins_ops, mdpll);
> err_put_dpll_pin:
>-	dpll_pin_put(mdpll->dpll_pin);
>+	dpll_pin_put(mdpll->dpll_pin, NULL);
> err_unregister_dpll_device:
> 	dpll_device_unregister(mdpll->dpll, &mlx5_dpll_device_ops, mdpll);
> err_put_dpll_device:
>-	dpll_device_put(mdpll->dpll);
>+	dpll_device_put(mdpll->dpll, NULL);
> err_free_mdpll:
> 	kfree(mdpll);
> 	return err;
>@@ -499,9 +500,9 @@ static void mlx5_dpll_remove(struct auxiliary_device
>*adev)
> 	destroy_workqueue(mdpll->wq);
> 	dpll_pin_unregister(mdpll->dpll, mdpll->dpll_pin,
> 			    &mlx5_dpll_pins_ops, mdpll);
>-	dpll_pin_put(mdpll->dpll_pin);
>+	dpll_pin_put(mdpll->dpll_pin, NULL);
> 	dpll_device_unregister(mdpll->dpll, &mlx5_dpll_device_ops, mdpll);
>-	dpll_device_put(mdpll->dpll);
>+	dpll_device_put(mdpll->dpll, NULL);
> 	kfree(mdpll);
>
> 	mlx5_dpll_synce_status_set(mdev,
>diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
>index 65fe05cac8c42..f39b3966b3e8c 100644
>--- a/drivers/ptp/ptp_ocp.c
>+++ b/drivers/ptp/ptp_ocp.c
>@@ -4788,7 +4788,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct
>pci_device_id *id)
> 	devlink_register(devlink);
>
> 	clkid =3D pci_get_dsn(pdev);
>-	bp->dpll =3D dpll_device_get(clkid, 0, THIS_MODULE);
>+	bp->dpll =3D dpll_device_get(clkid, 0, THIS_MODULE, NULL);
> 	if (IS_ERR(bp->dpll)) {
> 		err =3D PTR_ERR(bp->dpll);
> 		dev_err(&pdev->dev, "dpll_device_alloc failed\n");
>@@ -4800,7 +4800,8 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct
>pci_device_id *id)
> 		goto out;
>
> 	for (i =3D 0; i < OCP_SMA_NUM; i++) {
>-		bp->sma[i].dpll_pin =3D dpll_pin_get(clkid, i, THIS_MODULE, &bp-
>>sma[i].dpll_prop);
>+		bp->sma[i].dpll_pin =3D dpll_pin_get(clkid, i, THIS_MODULE,
>+						   &bp->sma[i].dpll_prop, NULL);
> 		if (IS_ERR(bp->sma[i].dpll_pin)) {
> 			err =3D PTR_ERR(bp->sma[i].dpll_pin);
> 			goto out_dpll;
>@@ -4809,7 +4810,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct
>pci_device_id *id)
> 		err =3D dpll_pin_register(bp->dpll, bp->sma[i].dpll_pin,
>&dpll_pins_ops,
> 					&bp->sma[i]);
> 		if (err) {
>-			dpll_pin_put(bp->sma[i].dpll_pin);
>+			dpll_pin_put(bp->sma[i].dpll_pin, NULL);
> 			goto out_dpll;
> 		}
> 	}
>@@ -4819,9 +4820,9 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct
>pci_device_id *id)
> out_dpll:
> 	while (i--) {
> 		dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin,
>&dpll_pins_ops, &bp->sma[i]);
>-		dpll_pin_put(bp->sma[i].dpll_pin);
>+		dpll_pin_put(bp->sma[i].dpll_pin, NULL);
> 	}
>-	dpll_device_put(bp->dpll);
>+	dpll_device_put(bp->dpll, NULL);
> out:
> 	ptp_ocp_detach(bp);
> out_disable:
>@@ -4842,11 +4843,11 @@ ptp_ocp_remove(struct pci_dev *pdev)
> 	for (i =3D 0; i < OCP_SMA_NUM; i++) {
> 		if (bp->sma[i].dpll_pin) {
> 			dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin,
>&dpll_pins_ops, &bp->sma[i]);
>-			dpll_pin_put(bp->sma[i].dpll_pin);
>+			dpll_pin_put(bp->sma[i].dpll_pin, NULL);
> 		}
> 	}
> 	dpll_device_unregister(bp->dpll, &dpll_ops, bp);
>-	dpll_device_put(bp->dpll);
>+	dpll_device_put(bp->dpll, NULL);
> 	devlink_unregister(devlink);
> 	ptp_ocp_detach(bp);
> 	pci_disable_device(pdev);
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index 8fff048131f1d..2ce295b46b8cd 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -18,6 +18,7 @@ struct dpll_device;
> struct dpll_pin;
> struct dpll_pin_esync;
> struct fwnode_handle;
>+struct ref_tracker;
>
> struct dpll_device_ops {
> 	int (*mode_get)(const struct dpll_device *dpll, void *dpll_priv,
>@@ -173,6 +174,12 @@ struct dpll_pin_properties {
> 	u32 phase_gran;
> };
>
>+#ifdef CONFIG_DPLL_REFCNT_TRACKER
>+typedef struct ref_tracker *dpll_tracker;
>+#else
>+typedef struct {} dpll_tracker;
>+#endif
>+
> #define DPLL_DEVICE_CREATED	1
> #define DPLL_DEVICE_DELETED	2
> #define DPLL_DEVICE_CHANGED	3
>@@ -205,7 +212,8 @@ size_t dpll_netdev_pin_handle_size(const struct
>net_device *dev);
> int dpll_netdev_add_pin_handle(struct sk_buff *msg,
> 			       const struct net_device *dev);
>
>-struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode);
>+struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode,
>+				      dpll_tracker *tracker);
> #else
> static inline void
> dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin) {
>}
>@@ -223,16 +231,17 @@ dpll_netdev_add_pin_handle(struct sk_buff *msg,
>const struct net_device *dev)
> }
>
> static inline struct dpll_pin *
>-fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
>+fwnode_dpll_pin_find(struct fwnode_handle *fwnode, dpll_tracker *tracker)
> {
> 	return NULL;
> }
> #endif
>
> struct dpll_device *
>-dpll_device_get(u64 clock_id, u32 dev_driver_id, struct module *module);
>+dpll_device_get(u64 clock_id, u32 dev_driver_id, struct module *module,
>+		dpll_tracker *tracker);
>
>-void dpll_device_put(struct dpll_device *dpll);
>+void dpll_device_put(struct dpll_device *dpll, dpll_tracker *tracker);
>
> int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
> 			 const struct dpll_device_ops *ops, void *priv);
>@@ -244,7 +253,7 @@ void dpll_device_unregister(struct dpll_device *dpll,
>
> struct dpll_pin *
> dpll_pin_get(u64 clock_id, u32 dev_driver_id, struct module *module,
>-	     const struct dpll_pin_properties *prop);
>+	     const struct dpll_pin_properties *prop, dpll_tracker *tracker);
>
> int dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
> 		      const struct dpll_pin_ops *ops, void *priv);
>@@ -252,7 +261,7 @@ int dpll_pin_register(struct dpll_device *dpll, struct
>dpll_pin *pin,
> void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
> 			 const struct dpll_pin_ops *ops, void *priv);
>
>-void dpll_pin_put(struct dpll_pin *pin);
>+void dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker);
>
> void dpll_pin_fwnode_set(struct dpll_pin *pin, struct fwnode_handle
>*fwnode);
>
>--
>2.52.0


