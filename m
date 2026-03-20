Return-Path: <linux-rdma+bounces-18430-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEgCHq3zvGms4wIAu9opvQ
	(envelope-from <linux-rdma+bounces-18430-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 08:13:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3302E2D672C
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 08:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E76B63037F23
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 07:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699A135A380;
	Fri, 20 Mar 2026 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXShgbPN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0DF3563F6;
	Fri, 20 Mar 2026 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990821; cv=fail; b=mj8FzB8oswsiTmEAmjC7EGqBYwmUjf2AxfVlti8ptxRHb9vc8YgBS3NMVSRbV+rEI4wdnT3CnMjV46ZW8n5zcHRsxO15oyiuj5mem/Zv5bX7N6111vFX+Vvc1iGl/02MkM5+rnOR+9WvEnX8ONttOQQpcR4Qz00tisvrWWXITrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990821; c=relaxed/simple;
	bh=GGgrAvBZk8RJDuschHNoVe8XsrEz3JhmeosKPIwHD1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LyRwwjnpscReLvuGYyEdKWdeuSAzz/5Aq72oELSgy1RKE+WoNKtQaVTR8eR+KjCCo4TtggSqjIjK95ukuIWt6RIoIomIldMDMygskviTzWBkX0Z5m0zNjBZzU/JqA6GwDmFLpauOfIx8+o6SqFjLSvo+Pq1CDuQTANKzC2J/YR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXShgbPN; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773990818; x=1805526818;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GGgrAvBZk8RJDuschHNoVe8XsrEz3JhmeosKPIwHD1w=;
  b=ZXShgbPN1PFjhOPQSd+oAjAI6FCn/1/7GIiBerp6zQ1LHExsJVoG4ipv
   yHI6aR5RIQOf9Ect+4Hzsx7tNKnk+rnM430V+RF27IlMODQri+iMgrqvs
   cXAle0V2lDNVMg11bUyJoTOZdlI5BQBSD0g7IOZi5lVXX375OJgifpzq7
   f3JWG5HIBuKUmQ1MO1Z9CfMtlxgxGlhh1nm9E9Esa/5vxsSY3bFO5xAj3
   j3qXAqZpcg/WErQP7rjdZ8aLmqY44CgA7qK2sngZOft0IBmK/4fvq2IdB
   hgZCzxo8bVXzhpDPwHTkQIcm4QhHzQYPz2i+c9K2ZNFd0j95FNgV3X7Vg
   g==;
X-CSE-ConnectionGUID: L4/SolMIR2+RWbEW34f9kg==
X-CSE-MsgGUID: viez3wAuRLSRX4LJ/HOVCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100529537"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="100529537"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:13:37 -0700
X-CSE-ConnectionGUID: 8iiwvLNoT76sVUVHdSGOCg==
X-CSE-MsgGUID: E0zgf4MpTdi9S0X9/rz7Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="228148551"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:13:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 00:13:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 00:13:36 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 00:13:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leJfDTPm/15rDHWLIGnd5FuS0rW8bcBTNKY+wv4KMiIP1qrPZWoy+TbuAEfB5b7XgA1s6NWpy0eSnnl9DJumPu3Dr2ViYjMt+2UvzH69gL6ciCFsESKsps2HmePmpjGmq0mYUFT2XHyTaImWJhdTJayrzhCwsRP1nFAwNzBep5hZJUGyh4HJbxiHI5SlPRi3AEUhi1ZHmvNIVWRWvxwtU7Irk8xmHKrEawqdx+r3h6zm5yDLtMtbAnqRY1i5VBYnA3stZWnXyeuCJVZ1ZUkr9l2MUfI4pL/p7pG6fVq4bBdQZeRzSh6x4eaRlyKO6rzGI5aMXL7bWXv7bUFK36tbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsnQunviNNrWVKqfeU+fQXguaER4zZ1GkircTTykDE0=;
 b=Z+Wed+WkU5ibEWJ9si5/LbY/bc2z7PNRsYEOsBvaxFrwJcqAThQSsZpm44sQKUyrQ1XeSNg1DjepAfMZN4jwlpNKmfoa1ErZkBVLk67qOS4yuJ3ZaIvF2K5/6kQD2rZ6RMRaz27gsfoQSkKnhH9KlRS8JgCE2QmwKRMvkAIZdp3xVaCRcSEfGHYu3wa6A/+AZJYKrrU4E98HvWoJ+y/+AAL/cgqHeFmiZWAYNf5icmV3BFxRxc0JXnM2vkEnt3jUYNzJJZ8AzteBWMZQRiNwgoIr881P8GFiEtxx2xrE4VwIZKk5OxKjNmSf0dQJQ/C3vvjAydj+saf7sjj0+Y9y4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB8738.namprd11.prod.outlook.com (2603:10b6:8:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 07:13:32 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Fri, 20 Mar 2026
 07:13:32 +0000
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
	"bestswngs@gmail.com" <bestswngs@gmail.com>, "kees@kernel.org"
	<kees@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v3 03/13] net: introduce
 ndo_set_rx_mode_async and dev_rx_mode_work
Thread-Topic: [Intel-wired-lan] [PATCH net-next v3 03/13] net: introduce
 ndo_set_rx_mode_async and dev_rx_mode_work
Thread-Index: AQHcuAh2f0kbuGf0mU2yP7KpcECYabW3ANhA
Date: Fri, 20 Mar 2026 07:13:32 +0000
Message-ID: <IA3PR11MB89865C96824F6518F4A01B9CE54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-4-sdf@fomichev.me>
In-Reply-To: <20260320012501.2033548-4-sdf@fomichev.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB8738:EE_
x-ms-office365-filtering-correlation-id: 62157889-4b78-48c5-2c81-08de86503199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099003|22082099003|18002099003|7053199007;
x-microsoft-antispam-message-info: /K80FlDeiYCNBsUqrdMoOwi80K192DKjGHCCynRtdXSRBRrOyNYNaiD8cZ8A9DDTKQLuSrsEuEtbRgMPpvLVElKQ9b1HeHkm/iz2KA9S3xg2LoBhuM1fIGyWl93eRptc88A0fGXqrSaqVUieZgpN25sMCUx2hCfkxeoyxyJl7/Kwnrgr4//AoszjWlPiiz6Vb5uY6WCyoOe9Qx1KIrDr73G6lxE3KoVBTvjgOSInKrpIC2Os0usy/YCFwaLrrygGgiqxNGH861anHTQ7LO4K81HJlK7iO6JsSzkHGU+UNXMP6bQlv5UltMC6nB6aWX3cc1ZBPWmcRlvlM9XidHbfiXJpVkzesP5b6x6E6sChiRLO8DfUX9aOPjM5c+X374Cp0eXroqiRIpasgWUXUdfhQDgB0FcfKPisr4MVLLU+ALeIq+sOGjklHz/hjVKdyYYIDBKo9EsNSBpKUoE4eQr1gxElOG/80LskW81p4+rCpHjRHdSZTF49DqxkG2MzXSOH/aX5DMzkWCDB/n2j5oVI5lfOMQ1Q/VlXLUIG0TJGzFPzR+VcX3lcqKCjK8N91bm9f1x829DLdXjjXBinKWUdi76ziePAECB5kdDuhbzKSjeMs/hDo1xAeknivBZXNW/9mDx191eKCtqFLbgSthOrhCdN+io9BBLPKfIbN0yv64zOz8IIPCVSnTzJ0hhU4gXB57CE4sg12PtLlr5kJgt3B0qZjw2RWYDk6/r2qMKXu11172cQwBRQP5QJkJx5Hb7dY1fSQhgfmvc1iaUcNI2UuB5i8kGoaCX/RoEff2ztbNw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1m0Y8lTTor4qy5n/3ysUNPb7ZsOOd1aLCg+kWq/uh5sL/wDq+GecKq17q1qh?=
 =?us-ascii?Q?EXjEkaDy4LPua0AM0tqAv+Bf/cRZmEtDPJGw0nTUVTg5smFxgOnil5iMf84i?=
 =?us-ascii?Q?O4tGfYuEzRoweIsag0znsGE1uktBF7JJyxgjQtPJAgHqKKmuxibw3PXbqguz?=
 =?us-ascii?Q?Li2NQkx2rbRJdFPJzIEbSa8ZluQeXEzi2gyvCaFU9WnPB8EZjXlERbLafE0L?=
 =?us-ascii?Q?vDeYKkT3YUaCcm3Z+48JIrJusSwqjl5HNsAOTU0x9EzgAblgKBNMn3d3WlNM?=
 =?us-ascii?Q?3pmS33xIoeNqwcfU1ftvLcTwNeUtP6AT+G9ApZzxRgU1ValtTyf9IfeaR8k5?=
 =?us-ascii?Q?pYfUFqxLo//HsHg5GTqyV7b4iSwffqs0BtPKzGgXFIXrsjQAtACs7kkfKoeg?=
 =?us-ascii?Q?gSnT7xJ75KJ1zRT7kVwZns9UXQ9lilkro9vXQn+XzXlre5byFVKS9ryDgX0W?=
 =?us-ascii?Q?mGywyHB2Jg102PnNVmJq5On9Y4O7HatEllQGf+pOhT6NDjD/RBgeo7bNQuka?=
 =?us-ascii?Q?LqZOD90Je8gf7KUqGBf7VYcsGNLFtH/Aml84OhkkxL6a0bVGtAGpW5WkDSc8?=
 =?us-ascii?Q?WmtjSlqK+9pUjWgdllxn6hATLhAI/LUllTK9eUJ4SqmFIiJZ4QvtVGwS1yns?=
 =?us-ascii?Q?gcwm54DJhmro6awlI4rPEHFi4o6QS3ikbIU32gXHqMsKr+T9maA77WFfSMv7?=
 =?us-ascii?Q?x1jkoYcspbBVcHgqx8ANJ6grJwq4lRPG6rJaoIZ2nVIy7HbHI5kITzrJ6bic?=
 =?us-ascii?Q?1/RzClvAq+sVLbAueUxIeFdtyXkRSoFrd0vme4jo9mz0DKDmO5TbAJ21+F1o?=
 =?us-ascii?Q?dzhE5WBxt5MhdmHu/dWubBwpz/4rCE4NrvI9h5+Ob0jVYkJ0HaTy0Mz6o/d9?=
 =?us-ascii?Q?/qBzpwCN2V5Q5fXfPU0ROijLMej3GC3+rDWr/HBKFMeOmBF09UP8/mSpePIF?=
 =?us-ascii?Q?xZyaGWQpqgOce0m3+I+mTzloE/Bb9BsIoFrm2P48kJnIENdT3QhI+K5GyM61?=
 =?us-ascii?Q?1FCgWneTzZbzqLHrNCnVapJljDC/bgFCGDRsl6zYyNWTS/fNkwf7JL8ZJCbR?=
 =?us-ascii?Q?rmv+pyuqKCWeU2e6tIqjXG5//wKVdJZQxdg5M3Ws12VjOJEu1C5J9oyYZ+Xh?=
 =?us-ascii?Q?RwJ58PozK24vvR0IhNXAGHd3fgkssSutSogNaCBJV/3jCRPEtgePvk0Q8uys?=
 =?us-ascii?Q?oG1q52hAeUo/hqAMkQQSzFwOAJO7CyBPUxF9Wd3ZK16hpvm9V1xJ/wMkwPKb?=
 =?us-ascii?Q?CunxunH4WcfUuUvFh6U5rPFltYaJgaE3a7s+HWkoUTLmtX4ixVZpTvxIIVnY?=
 =?us-ascii?Q?9juwFHhP4eZWjxEsAhvLwzVd89GI1qP8nLi3HcXaCrp4aBWTzsez97FyptvK?=
 =?us-ascii?Q?uQQcmKLVsA7XtJcn+5n9wNLMsb+mn1EHCFGqZMBQNkC9mnxy5TiHa5AKiZ4j?=
 =?us-ascii?Q?z62L5o7qGajJ8KycvLb2vwQCaUHeZYZTgW0yqNFoolTLamei36RRyw859DKk?=
 =?us-ascii?Q?GdEnN6GxU3e8TGcmo7hPsxdSxMCPSW1i7X9qXq6MClYblrz1Hxi4ThqmtoxM?=
 =?us-ascii?Q?WYgQtARWp6Iabq+P9p5RdMgQ3iNN7vsDiAqQSrTj5GhI5zPhh3nptaxu4o9j?=
 =?us-ascii?Q?My3B3tgf3nJvYgyWHMHgJYsqbF+ANH3XzzK454DYAItOFsQmFncNTcQlLPOQ?=
 =?us-ascii?Q?GecyBazqmZZtRCdUNdGre0FMCLPXpTo9bxWRKYMIelzFp4i1qKq8teBKY2Xa?=
 =?us-ascii?Q?76uKCpRkoVsyGnljlGu8wJQ8+ciyc98=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eVk8/qQGDQ3yw9lUtofPkdfk8cd21Yx/kLQQUlpL/E5d0X7OnGGN2MfFKI3cGTNaaTN4dDDF3UEir72j7CIIzgUg+NNmNuj2kFMN65UytC8WU7eLkIgQOSqjHo8py15KNObW18Csqaor1iecCGUEnMdxXJxp0TmoyH4txVAaQzbpLkjkvZgEFR9eqqytyCLbScqPJJJ6CEseQr2c4VrCQg+OPfunwf97C7wFlns03jMTrsBLI8qZMxxD2vfNwD6RQcZl1gKWoCjJwivBwceknaOgGJMytVuTu214fNccPqlVDYEhXzIZly3ymPOBDOmJKv7MAv3M2BRICk8TwxSKDw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62157889-4b78-48c5-2c81-08de86503199
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 07:13:32.0704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9EwuzPDNjrf+KnudmKhEUfOl9npP1y0mLuMS6AwxA6VyeNJ3DWMhkT54aVriBcrB3hGACM78lLUpuowggc3tsK0lIEZhxJX6vOQtxJwtMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8738
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[36];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18430-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.943];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3302E2D672C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Stanislav Fomichev
> Sent: Friday, March 20, 2026 2:25 AM
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
> skhawaja@google.com; bestswngs@gmail.com; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; kees@kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-rdma@vger.kernel.org; linux-
> wireless@vger.kernel.org; linux-kselftest@vger.kernel.org;
> leon@kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 03/13] net: introduce
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
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  Documentation/networking/netdevices.rst |  8 +++
>  include/linux/netdevice.h               | 20 ++++++
>  net/core/dev.c                          | 95 +++++++++++++++++++++++-
> -
>  3 files changed, 116 insertions(+), 7 deletions(-)
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

> to
> +device
> + * and configure RX filtering.
> + * @dev: device
> + *
> + * When the device doesn't support unicast filtering it is put in
> +promiscuous
> + * mode while unicast addresses are present.
>   */
>  void __dev_set_rx_mode(struct net_device *dev)  {
>  	const struct net_device_ops *ops =3D dev->netdev_ops;
>=20
>  	/* dev_open will call this function so the list will stay sane.
> */
> -	if (!(dev->flags&IFF_UP))
> +	if (!netif_up_and_present(dev))
>  		return;
>=20
> -	if (!netif_device_present(dev))
> +	if (ops->ndo_set_rx_mode_async) {
> +		queue_work(rx_mode_wq, &dev->rx_mode_work);
>  		return;
This early return skips the legacy core fallback below.
Before this patch, __dev_set_rx_mode() continued into the
existing unicast-filter handling when the device did not
advertise IFF_UNICAST_FLT.

After this patch, any driver that implements
ndo_set_rx_mode_async but does not set IFF_UNICAST_FLT
will never hit that fallback path.

+	}
>=20
>  	if (!(dev->priv_flags & IFF_UNICAST_FLT)) {
>  		/* Unicast addresses changes may only happen under the
> rtnl, @@ -11708,6 +11772,16 @@ void netdev_run_todo(void)
>=20
>  	__rtnl_unlock();
>=20

...

>  	open_softirq(NET_TX_SOFTIRQ, net_tx_action);
>  	open_softirq(NET_RX_SOFTIRQ, net_rx_action);
>=20
> --
> 2.53.0


