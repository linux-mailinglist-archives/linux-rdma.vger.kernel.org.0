Return-Path: <linux-rdma+bounces-13634-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AC4B9B727
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 20:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84743AB73E
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 18:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D78031B809;
	Wed, 24 Sep 2025 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GG5iivU/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C93314A90;
	Wed, 24 Sep 2025 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737688; cv=fail; b=f/Obl5B3M2dZn8O2p9SQv48D8xdgQ6zsLx98xVJPWIwYWI/Sw0Tckv5rTyLweSxFugUlUYRU+JBkUW3sOfI6AF8z9enX6L3AbwppLVybJa2xIt+ofFqGmXx1+5E10WgvQg1ktWTEn6OvWbGsRzkoskqrYkwIbURzE+fHLLmBvq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737688; c=relaxed/simple;
	bh=llLxRqnggtJevLRBTrNfmM52OPi+iNy5j/L9VK1Lx0w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AXBttWpL1BcfTdGHqb0kEVBxRkWDWYbqiiX90CLubVyGD8OAlDl/G94N4QrgWNJKF6cNXOuAyID3qzUjto/PuBmuu9rj0c+SxHduD/E6vKz+zr9iwgWV8lhOEAzlX7aAxnuQcjWoMhjW5dGge/CZot6BcAUYekx9a19CGlVH2GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GG5iivU/; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758737687; x=1790273687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=llLxRqnggtJevLRBTrNfmM52OPi+iNy5j/L9VK1Lx0w=;
  b=GG5iivU/+QyhT/OaEsCSDjyXX08zfP781owZCr60s4cSKgjwymxQQJ5C
   khXKfxgEIxPVKepprwsr2QLdaKY034Gam+Wr181LpwdOXWcbtJeCON49k
   26E1OvdIboDfAnyWq2NcPmzj06Dw/eiETSe+ihXOa3KnkOiWQEWiqcH7U
   USQ72Oazs6MRoirL40LiLA6/kDpzQGZp4e5D/7umb/7IARauO3XTxUqdb
   foQWEh1E0uukQn4S4pxWWVjEuHnx6U9LVw9bSziiPC0kUOGNZCRGrqP0t
   JljvIsUhaLSxNM96f2HYVS5FtPI9NXpzHahteSJaGGkrR+R/RqX5vZ995
   w==;
X-CSE-ConnectionGUID: HoXtW6yJRLmuJjYBNGmZXQ==
X-CSE-MsgGUID: HrUcgioDREWiWrIE7BUjBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="71289572"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="71289572"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 11:14:46 -0700
X-CSE-ConnectionGUID: WpSkar2SSSOHg/IKX8Q2Ig==
X-CSE-MsgGUID: tfH9yu+1Sz+vhTvaLcgfhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="182383125"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 11:14:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 11:14:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 11:14:44 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 11:14:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOElA54Wf9uZ2w1clI2V6DxOY7ChofPa8f10Od/niYLWo+XtuJBx2jtMDzq6qsJCOwyx2gzJ3tUdnRi+EwHFovsLGSprNm6uG5PKRqNec5UggiyoxDoSuWt4Z8RW7JuGkJ1kO3R81SGiAkW+hwGLiHCT0Ys2+waHscS5G5oPhchASFzKpEOiMM4acHuiJMPmtwU0Tdk9bZ9LJNaDNzTa34wVmY5DN3Z/hjHbaB0B0psZarxbmhghrld7NIFPvRLFDOlCThFiTBCJQDRu4ItiaeenuqG7ZTBLATYWoGz+qYQe5zQBSFjgbLcLi8gx6P6DZGlCf8+hWzehSvErStJucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ducpsFG3URKp1w1HKoIqP5/5tNynNl42ft7q3d9moMA=;
 b=SWQuauu4d2eLKRHeWsfRu8PD+fSSmad0vL6S8/LtRe31JvPPKLm20yAnbI0pr+HTiGvMoR4aTyhOXy3T6jk6Wb+RVjWAFpluGqIA0k0YTmF4qXjzQBUjgrOyiUGbrfme2EDtf5iDiC/DjvtISCWdof24qjZ3KVMnN6gs1c+KCM8FIkXkZO/mVIgl41vVCjNzhRc+uyTFxelFX+940pP135OkjK0xkipnh91NpNu/JN1WRQSH27yjqVpSuxMkRFpkoo8a4pGoQwrt3gldF+PHWT/BlDd0HwXHemo7xMFf7ePrueBLLfiHOC4wPbfrUKJ3Vh0Fp9R090P9wJRJL8q0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB4946.namprd11.prod.outlook.com (2603:10b6:303:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 18:14:35 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 18:14:35 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Pradyumn Rahar <pradyumn.rahar@oracle.com>, "shayd@nvidia.com"
	<shayd@nvidia.com>
CC: "anand.a.khoje@oracle.com" <anand.a.khoje@oracle.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"elic@nvidia.com" <elic@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"leon@kernel.org" <leon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "manjunath.b.patil@oracle.com"
	<manjunath.b.patil@oracle.com>, "mbloch@nvidia.com" <mbloch@nvidia.com>,
	"moshe@nvidia.com" <moshe@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"qing.huang@oracle.com" <qing.huang@oracle.com>,
	"rajesh.sivaramasubramaniom@oracle.com"
	<rajesh.sivaramasubramaniom@oracle.com>, "rama.nichanamatlu@oracle.com"
	<rama.nichanamatlu@oracle.com>, "rohit.sajan.kumar@oracle.com"
	<rohit.sajan.kumar@oracle.com>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>
Subject: RE: [PATCH net v2 1/1] net/mlx5: Clean up only new IRQ glue on
 request_irq() failure
Thread-Topic: [PATCH net v2 1/1] net/mlx5: Clean up only new IRQ glue on
 request_irq() failure
Thread-Index: AQHcLFNf5x+4xq6rakeBGx5GJ2ze67SipSsw
Date: Wed, 24 Sep 2025 18:14:35 +0000
Message-ID: <CO1PR11MB50894ACC6EF0DB09FA557188D61CA@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <d9bea817-279c-4024-9bff-c258371b3de7@nvidia.com>
 <20250923062823.89874-1-pradyumn.rahar@oracle.com>
In-Reply-To: <20250923062823.89874-1-pradyumn.rahar@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|CO1PR11MB4946:EE_
x-ms-office365-filtering-correlation-id: 8bfcbfe3-0326-4178-7962-08ddfb9637bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?e3UZZrY1J9B2KxeEXaPAaRe02VV/WtBMPhwLW3oSTorhY33soWCkjKFctZeJ?=
 =?us-ascii?Q?QXoQ5Bd+kv01eLlmsu5OExBSanCD40WBAvPj3cy5a5NKxkWfW+ag4ogtXsta?=
 =?us-ascii?Q?KneUW68NVSXAIwwQ2+I20g3gbPGInlPCDZYMqS8674qWI82MjOqXXzR6Adgb?=
 =?us-ascii?Q?oOMxOemIOEK30k3LZxVS5eZQwv/lUgHCGbwpOUSPtXG/N5jUQIbr3fgZ9xa5?=
 =?us-ascii?Q?Diy1XZhrJ9dDay47dtfEBIjQ7ztOiGeFlo2TD64Lwppqn8IWCQwtEocnFulc?=
 =?us-ascii?Q?XOdX1y3H/NmjmvxC/xIWXVJHFc4nzgmvyGGLPxyrz0V+RnfxGjvKrKNyif8V?=
 =?us-ascii?Q?sVUCddo9fxMmWm04xMgQX02JZ6nn3gONoyqNGlKfLb1H0eJqNPqHAXU9Kzpk?=
 =?us-ascii?Q?ZHjhRWEMJ8J8Gmo6MsdqT05hEDzwBeyLxBT59vAu4ycayl9SmRTpD/wBAhfC?=
 =?us-ascii?Q?4tu2Y8noSixikjaLGA5fu4TBotMALMgplI1W5rqjocuTrnG4DdoOQO+HqJfa?=
 =?us-ascii?Q?qXqSuc95N1yG0DP+qK/U0TY57CHRG8zLgCtyV0Bq9t9n/E3jnbwbn5khJJ57?=
 =?us-ascii?Q?kVl3VuluMYANbrcu1lwfluIA0gyLmtUgzIpjN1CHwfemTiTXQO5PS3fWlTu4?=
 =?us-ascii?Q?+trTI0WWuTzR31GNK7e7PtFKachRFL+u8wPY/jX3NU9RpRGDWgu2BUE4xAKY?=
 =?us-ascii?Q?CdSceNQTQwlIM1jbwgCUurJhuWQRMWyy1og97dSSQvZOhnIINVBfL+VW9OaD?=
 =?us-ascii?Q?N/aqTh/LQYJ0YALjvQImisYxSxr0njqMDjL4QapP7wfUen7/wjwPE3ob/AGf?=
 =?us-ascii?Q?Fvvr/MEy1ZVOfsHdTNlFACEbDb+AdOR1L2H7KjjG7FZVxcoMJJo4UoyO/JLC?=
 =?us-ascii?Q?5kOLaEOuR7YFHlUDLNtKCf7wQLf1QAAXq7LRsgkAqWE1t2NGH0LPsk1VaGAy?=
 =?us-ascii?Q?79IzEEPQXNLPJ5g/s/T09XoWXAqAP7CbvCkjwQHzTZKxFpe9Vi5B+wCVsjj4?=
 =?us-ascii?Q?Hy9N25ndBDs2/tz+DkiwFOeDCmoMBz1i3DCV1HK6AvMmC5YGIuNhu/iXEdP0?=
 =?us-ascii?Q?cTPfv8oM2stztYVRa2IhLvTxdB31CjePgbCNLnw+h4HCPVL9txBVvC21ad+c?=
 =?us-ascii?Q?4qH3xS1mY0trpJu8L59QdjV3HyWCh0jnTEuGHwwmo8eMCLJj84Eb0DjdfiCq?=
 =?us-ascii?Q?p+xjfQkc6J19nvWHZU4JWoAaE05m8YT7poyFIIX7sSs4eEwlyLz/YQ6nzvyk?=
 =?us-ascii?Q?mAtvrR2k2ljWXRbmAuHTIHg0JLEUiE1up3M/DC7D8BSNAYlHrQCcvz2PKab7?=
 =?us-ascii?Q?Ht81zbq+DK+LsVy+dj37Ge9Ga/FyD2ViLLMuK3IaCzk0zqnJaWChtjpBvhxE?=
 =?us-ascii?Q?BK6xhARC/j9BY6QrF51IL4p/gC2M+OPmFUXr6h9X10sYSjIkZgVcvSTuFXOa?=
 =?us-ascii?Q?kure4rcnrAJreV28cnKY0CUxPmohI+iJa0mbLpmvOGE4Uy3VqZrTCYVguEcs?=
 =?us-ascii?Q?yZmTPWPDTNG/hR0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FiD6MVDnEKuxEdvb520HAXkfQwbXQOG05FMS75LzNO0yxe/reAkshAyyk10z?=
 =?us-ascii?Q?RAq5kavHEGzpSja2m2VqASm/Sd89Saa886K3vYKk2kl3oU9Du3J5wEs6Qmz7?=
 =?us-ascii?Q?v5RR2dLckYKyKAYb1Eb58c034+u8oYXIaxAPYiFjliEpav3m1rVbNXbcnFKd?=
 =?us-ascii?Q?JMt+lrOTwms8Vtg4glyohdteB2EAWLAwEAZngDwUfFB8is74Dnn8SjLf9Gvz?=
 =?us-ascii?Q?U8bLZcQ9twrxq/CAf84NP/XugG8VwydSFPup9qrEswOH5qpC7GBlRuNvFl7r?=
 =?us-ascii?Q?a4yOIeOtJaRRzfZYvEkZM6+51Eu+iiaHp01yEidWalaoSxSPpRKPpmhxXACF?=
 =?us-ascii?Q?fwesXFGFYhS6jj4x1OjnxMTBRXXhhFiV4mh9Sl3E6rQ8JofnKhttWxN09v7m?=
 =?us-ascii?Q?rKOTjLxjXEPKE1aMVdKx99AuUm+qqruUa+JgFdBpvppbrdbL2do2b1sHGnfM?=
 =?us-ascii?Q?pnFniKpzRD5GbMn8UvbbOWlVSEiBkaWhsM3pfQoUY+2yuDofS20DNgyqHqNM?=
 =?us-ascii?Q?RFTtNm2zbwR9PjJErenUVp5zhFVt/HzBuAnWNbAGIvp8NlfIPRHS7TEi2rb6?=
 =?us-ascii?Q?FTrewjDonIAnaIxJQBifK0SyjiLM2x6TfRzv5M3Q2YPi5N3vU6P7N2QQU7T0?=
 =?us-ascii?Q?EBalZgOoeApqLvsIZQGu9VzeBoTzRocgOtJuM6LFwAx4umMCHSwKeNHmpjBb?=
 =?us-ascii?Q?oYyKO8cBjYsQaLHsthon33HiMVg+G9djS42ZDCTHp5abY44yznTreYDTD15D?=
 =?us-ascii?Q?8rkBQcADhfYbRm0FflFdBphTswsirZ0OVEb/YdToTv1X8kAV4KO/28oQQ6tj?=
 =?us-ascii?Q?Qit/+aTRtS24GyMi55ykg4AhAU461jW+OhB1R2+SnU1fqxwCslpKnergJOOE?=
 =?us-ascii?Q?qn2RicV/yMrk8UNEVlJH6I+pGvoSHVImQ4JTKkkCigCP9WxBQTqXB6f4nkxX?=
 =?us-ascii?Q?5AhV9MZmmKnAcI4KV7MHp7xb/KytbSaltFPfm0P4DnMF8mcFd5Givj57frNc?=
 =?us-ascii?Q?sttQMD5wpcVXR8juo2MNx1utTqJOcQ2/wVyW4Nr1EqC4bd9HBQiMFc1WStbH?=
 =?us-ascii?Q?pELSI7hcsHMuExqIJ9Xb4vLLobcLAnoRUWmtnDYx4LgqRn7iL0bK39jsAh0s?=
 =?us-ascii?Q?kjGrGmzxwrOWdmldmliv5mHEXZLJA/dFcKFthRrZ0y0dGvy92alQTL7FfUG3?=
 =?us-ascii?Q?RhJlOXlBcOS25FYEbnJs2HYrIBgg7UBf74bPDQEeXMZnWDorT2JzbhjhiY+d?=
 =?us-ascii?Q?NCWj7560WdWiCj0KhU2MOVf+yEbAu8qvvEf1+g2iRjzowl3jgqfUqwc/sP6k?=
 =?us-ascii?Q?qt7yBTNt0BSisO1YPjplgAKA/0a/Eonfq0lDXp2jIdVh8iNfFcuYdmvhxIV7?=
 =?us-ascii?Q?WusypIEh7kqTZlApIdF0GF3H8GirsP8qPPdtQP6tL03Ke9uiaWULJyCBUgRN?=
 =?us-ascii?Q?TvxfBNokHJTKsUVs928UNfYpJCXU1BBAjvQpNIu05YuF6nb291/QnywqYbQ3?=
 =?us-ascii?Q?w9SwB2w3pdvEt8pyXcklIgFMUxLopS/jOOprHCXFAQjQ7uf7CYu+0G4Ob8Ec?=
 =?us-ascii?Q?P2kTuYmKCMMC9hYslWMeN0FxM17j4PGVP4G1gXBi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfcbfe3-0326-4178-7962-08ddfb9637bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 18:14:35.4333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSbAuvQYtQr6M3Gn3Qnis3sHOXAqJSG0975kY0ozoUCc0YOgdrCotqtT4wXEM/6FdV+b/KT4HbutqCizuZrQlCbI1iy7fupDbTo8414A8PY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4946
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Pradyumn Rahar <pradyumn.rahar@oracle.com>
> Sent: Monday, September 22, 2025 11:28 PM
> To: shayd@nvidia.com
> Cc: anand.a.khoje@oracle.com; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; elic@nvidia.com; Keller, Jacob =
E
> <jacob.e.keller@intel.com>; kuba@kernel.org; leon@kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org;
> manjunath.b.patil@oracle.com; mbloch@nvidia.com;
> pradyumn.rahar@oracle.com; moshe@nvidia.com; netdev@vger.kernel.org;
> pabeni@redhat.com; qing.huang@oracle.com;
> rajesh.sivaramasubramaniom@oracle.com; rama.nichanamatlu@oracle.com;
> rohit.sajan.kumar@oracle.com; saeedm@nvidia.com; tariqt@nvidia.com
> Subject: [PATCH net v2 1/1] net/mlx5: Clean up only new IRQ glue on reque=
st_irq()
> failure
>=20
> The mlx5_irq_alloc() function can inadvertently free the entire rmap
> and end up in a crash[1] when the other threads tries to access this,
> when request_irq() fails due to exhausted IRQ vectors. This commit
> modifies the cleanup to remove only the specific IRQ mapping that was
> just added.
>=20
> This prevents removal of other valid mappings and ensures precise
> cleanup of the failed IRQ allocation's associated glue object.
>=20
> Note: This error is observed when both fwctl and rds configs are enabled.
>=20
> [1]
> mlx5_core 0000:05:00.0: Successfully registered panic handler for port 1
> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to
> request irq. err =3D -28
> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while
> trying to test write-combining support
> mlx5_core 0000:05:00.0: Successfully unregistered panic handler for port =
1
> mlx5_core 0000:06:00.0: Successfully registered panic handler for port 1
> mlx5_core 0000:06:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to
> request irq. err =3D -28
> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while
> trying to test write-combining support
> mlx5_core 0000:06:00.0: Successfully unregistered panic handler for port =
1
> mlx5_core 0000:03:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to
> request irq. err =3D -28
> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to
> request irq. err =3D -28
> general protection fault, probably for non-canonical address
> 0xe277a58fde16f291: 0000 [#1] SMP NOPTI
>=20
> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
> Call Trace:
>    <TASK>
>    ? show_trace_log_lvl+0x1d6/0x2f9
>    ? show_trace_log_lvl+0x1d6/0x2f9
>    ? mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>    ? __die_body.cold+0x8/0xa
>    ? die_addr+0x39/0x53
>    ? exc_general_protection+0x1c4/0x3e9
>    ? dev_vprintk_emit+0x5f/0x90
>    ? asm_exc_general_protection+0x22/0x27
>    ? free_irq_cpu_rmap+0x23/0x7d
>    mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>    irq_pool_request_vector+0x7d/0x90 [mlx5_core]
>    mlx5_irq_request+0x2e/0xe0 [mlx5_core]
>    mlx5_irq_request_vector+0xad/0xf7 [mlx5_core]
>    comp_irq_request_pci+0x64/0xf0 [mlx5_core]
>    create_comp_eq+0x71/0x385 [mlx5_core]
>    ? mlx5e_open_xdpsq+0x11c/0x230 [mlx5_core]
>    mlx5_comp_eqn_get+0x72/0x90 [mlx5_core]
>    ? xas_load+0x8/0x91
>    mlx5_comp_irqn_get+0x40/0x90 [mlx5_core]
>    mlx5e_open_channel+0x7d/0x3c7 [mlx5_core]
>    mlx5e_open_channels+0xad/0x250 [mlx5_core]
>    mlx5e_open_locked+0x3e/0x110 [mlx5_core]
>    mlx5e_open+0x23/0x70 [mlx5_core]
>    __dev_open+0xf1/0x1a5
>    __dev_change_flags+0x1e1/0x249
>    dev_change_flags+0x21/0x5c
>    do_setlink+0x28b/0xcc4
>    ? __nla_parse+0x22/0x3d
>    ? inet6_validate_link_af+0x6b/0x108
>    ? cpumask_next+0x1f/0x35
>    ? __snmp6_fill_stats64.constprop.0+0x66/0x107
>    ? __nla_validate_parse+0x48/0x1e6
>    __rtnl_newlink+0x5ff/0xa57
>    ? kmem_cache_alloc_trace+0x164/0x2ce
>    rtnl_newlink+0x44/0x6e
>    rtnetlink_rcv_msg+0x2bb/0x362
>    ? __netlink_sendskb+0x4c/0x6c
>    ? netlink_unicast+0x28f/0x2ce
>    ? rtnl_calcit.isra.0+0x150/0x146
>    netlink_rcv_skb+0x5f/0x112
>    netlink_unicast+0x213/0x2ce
>    netlink_sendmsg+0x24f/0x4d9
>    __sock_sendmsg+0x65/0x6a
>    ____sys_sendmsg+0x28f/0x2c9
>    ? import_iovec+0x17/0x2b
>    ___sys_sendmsg+0x97/0xe0
>    __sys_sendmsg+0x81/0xd8
>    do_syscall_64+0x35/0x87
>    entry_SYSCALL_64_after_hwframe+0x6e/0x0
> RIP: 0033:0x7fc328603727
> Code: c3 66 90 41 54 41 89 d4 55 48 89 f5 53 89 fb 48 83 ec 10 e8 0b ed
> ff ff 44 89 e2 48 89 ee 89 df 41 89 c0 b8 2e 00 00 00 0f 05 <48> 3d 00
> f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 44 ed ff ff 48
> RSP: 002b:00007ffe8eb3f1a0 EFLAGS: 00000293 ORIG_RAX:
> 000000000000002e
> RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fc328603727
> RDX: 0000000000000000 RSI: 00007ffe8eb3f1f0 RDI: 000000000000000d
> RBP: 00007ffe8eb3f1f0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007ffe8eb3f3c8 R15: 00007ffe8eb3f3bc
>    </TASK>
> ---[ end trace f43ce73c3c2b13a2 ]---
> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
> Code: 0f 1f 80 00 00 00 00 48 85 ff 74 6b 55 48 89 fd 53 66 83 7f 06 00
> 74 24 31 db 48 8b 55 08 0f b7 c3 48 8b 04 c2 48 85 c0 74 09 <8b> 38 31
> f6 e8 c4 0a b8 ff 83 c3 01 66 3b 5d 06 72 de b8 ff ff ff
> RSP: 0018:ff384881640eaca0 EFLAGS: 00010282
> RAX: e277a58fde16f291 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ff2335e2e20b3600 RSI: 0000000000000000 RDI: ff2335e2e20b3400
> RBP: ff2335e2e20b3400 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 00000000ffffffe4 R12: ff384881640ead88
> R13: ff2335c3760751e0 R14: ff2335e2e1672200 R15: ff2335c3760751f8
> FS:  00007fc32ac22480(0000) GS:ff2335e2d6e00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f651ab54000 CR3: 00000029f1206003 CR4: 0000000000771ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: 0x1dc00000 from 0xffffffff81000000 (relocation range:
> 0xffffffff80000000-0xffffffffbfffffff)
> kvm-guest: disable async PF for cpu 0
>=20
> Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
> Signed-off-by: Mohith Kumar
> Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
> Tested-by: Mohith Kumar
> Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
> Reviewed-by: Moshe Shemesh<moshe@nvidia.com>
> Signed-off-by: Pradyumn Rahar <pradyumn.rahar@oracle.com>
> ---
> v1->v2: removed unnecessary braces from if conditon.
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> index 692ef9c2f729..82ada674f8e2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> @@ -324,10 +324,8 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool
> *pool, int i,
>  	free_irq(irq->map.virq, &irq->nh);
>  err_req_irq:
>  #ifdef CONFIG_RFS_ACCEL
> -	if (i && rmap && *rmap) {
> -		free_irq_cpu_rmap(*rmap);
> -		*rmap =3D NULL;
> -	}
> +	if (i && rmap && *rmap)
> +		irq_cpu_rmap_remove(*rmap, irq->map.virq);

Presumably if this fails during initialization, the caller of mlx5_irq_allo=
c which allocates multiple IRQs would be responsible for cleaning up anythi=
ng it allocated before failing. Makes sense. Cleaning up only what this fun=
ction did makes more sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  err_irq_rmap:
>  #endif
>  	if (i && pci_msix_can_alloc_dyn(dev->pdev))
> --
> 2.43.7


