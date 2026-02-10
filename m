Return-Path: <linux-rdma+bounces-16696-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEaHA/TbimngOQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16696-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 08:19:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A146A117D3F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 08:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CB10300D0F3
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 07:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D347333439;
	Tue, 10 Feb 2026 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCoDOQU+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05368126F3B;
	Tue, 10 Feb 2026 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770707953; cv=fail; b=TIBGk6tzb8Ji0YrF4shutAKX/GxyWAC2Xzz5GAEDFuvP5lmZHWOQKo6+2ciNNdmPoI+CIsbtu2jf/B4QO6KaQZ3BxMFksuDmmFz16sbu8snL95B9a0Dc94JqFTeSfHQfx3Uj1EmSsuNnC8tj/Cx8nCmEiNLzfkrVFBsAzDoEUOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770707953; c=relaxed/simple;
	bh=IU1EsInyFiXGKgUyBsEMBgR5ovGSGc1JYUes559WzNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A9pII9cPT0Wxy+llhmHv36nuhYLQpqUpGBJt4Sw6/lIsS+EiyrBG6i2l07ZtlOBlIcirA9aX/0DlUWkaba/+d+0CgRzFu3fj3i4rZ3LXzRZjNcpVCJ6LpShU81vmUDoTQ2JDkitfY5Q8rfMJ2qhTaxFIwLL8yu5Ymkg3u3JPbLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCoDOQU+; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770707952; x=1802243952;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IU1EsInyFiXGKgUyBsEMBgR5ovGSGc1JYUes559WzNs=;
  b=PCoDOQU+9vj5PGydMZVeqVxYk2ZB/j3z4Tidtle2TK5D/jW2qYtK6dQd
   76CkETfja84vp+Q2LjSEkFg5MFPsqNv+jJhItrRiwFcVyl5xAYomiE/Cb
   rYxiOSqOedIALEeCBdGSp5UDOSJZqfVbqRe1BbNumrnATQmkpicVPQvkH
   yqQtXDuXOSj4VcdWS5hGiUivfGCTk1QwkfBr8iHmnvHQJmQH0qOyMT8wB
   BYm5+nV6OUpiSrZjkyKMJh4ZLADwyl2qVhVfmMRKAc3uJBjRvxRVgt5fu
   yePbpfVB4dxLSNHJIMx9wTWKjDtJFwEh3DUYFJMRBKIbel6HSiUl1Afx8
   Q==;
X-CSE-ConnectionGUID: 1s9yl+0gRjmPWpfvggwbAw==
X-CSE-MsgGUID: Qq0vk9CiTSO6nL9QImffLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="72013465"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="72013465"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 23:19:11 -0800
X-CSE-ConnectionGUID: hPg1ap/VR3azg12+JxXNGg==
X-CSE-MsgGUID: pgHmUQKJRwmx/0kokkHQQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211672603"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 23:19:12 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 23:19:11 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 23:19:11 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 23:19:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPVT+cPPtiK83Tafnub6GSU/fQ4eowy50+xpTs0u2gd3fGMrEnz6gaILEXOEmxxeRAOhqRrTvMmSLyO9Q+X3tMAdbXWPI8RjeI/2oUvSBHDW8C81ShyiDv0o4sRgBkocsyexOyNtI3Aw4v40b9cPQsTDceOL/utJNDwnUccHo5Ch8n2pkMar1Vq4gA8jXplXhQMxWPfFVtq0IZCS5ik8BXt++LzDkgARNpx2Fvckcf97pcvjXekb8Vvn5PO42sU4H+f+xCVVLeob5mGGU85r87uKNwHzqxEnxjkVib8M3/njxoCPLguftNlY+187BzNUJ10e8aB0hLd+lN75v8SS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8YSCYIAQwe01A70B7fa+QAA68oGYX443Vjs6PyCMQo=;
 b=chfZ4lRuy0xAAGxEnePkCM5LEhP1IwTbkHpwKSHDqrOAgqvyv4QqQqlpkVUjwGauCqfSPo/J1YRnwyA36EwYBnru543Ss2pmDltbTqWnkZeN7oPKpaj7qGIw2S53yEzVPJKpkGj3rSnH+vyvcJfMLYGMZJXGEqfWqYerxtQSDNM6fFfdKWTp6GaNXHV9fAWLtkQ2+yVlYN4IfnnnjNS8oT8MNSd0wn0l5aziYlKqqdynvHH3sqdfJsYwqrXEuL8PPe+qhmtZz1bznvGPHQAGrmKBA0fPXEm7SDheyHre4n3sSIxdrP7yn57WruMUFZHr6FbxJdRbRLWFjoNkXV8C/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Tue, 10 Feb
 2026 07:19:05 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 07:19:05 +0000
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
	<jiri@resnulli.us>, Richard Cochran <richardcochran@gmail.com>, "Saravana
 Kannan" <saravanak@kernel.org>, Prathosh Satish
	<Prathosh.Satish@microchip.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mark Bloch <mbloch@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jonathan Lemon <jonathan.lemon@gmail.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 03/12] dpll: Add helpers to
 find DPLL pin fwnode
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 03/12] dpll: Add helpers to
 find DPLL pin fwnode
Thread-Index: AQHchxiP7wmqfXl5uUKlMU2tWQ3AT7V7rLWQ
Date: Tue, 10 Feb 2026 07:19:05 +0000
Message-ID: <IA3PR11MB89868F74CB8737AA5B67B1F7E562A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260116184610.147591-1-ivecera@redhat.com>
 <20260116184610.147591-4-ivecera@redhat.com>
In-Reply-To: <20260116184610.147591-4-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA2PR11MB4953:EE_
x-ms-office365-filtering-correlation-id: 85292f8f-e9dc-400b-026e-08de6874acbe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?AjKfCn7xUW7JINXMRcv5x7Sdg6R7a/1mYOk6MkDLytvlS1NdO70bWsW0fIlJ?=
 =?us-ascii?Q?4RxPv6Rkxb/AhfFgMtveVC/Mv+Iykk7gPMFWKWG4x9p5kfhts26AOn2gGlgI?=
 =?us-ascii?Q?1WAC5/mcREnGVH3ybcymSAVVmo4mbIkcWOIxcSVPuexAzlCTqBHB/nnKitMP?=
 =?us-ascii?Q?bQWO1XA/nU3Vezhxua6BsZSelSgoz7AHxDLXxYGdrSHy+k+CumKCUVdi5D2f?=
 =?us-ascii?Q?Oyzuzx6yo8a+OX3lu8kuFLcpK7ksjOEgR8b4kc2LjoCBLS8p+cAyDqh2uu+7?=
 =?us-ascii?Q?9ejPzCriMlKZ4EEUPQZqbQS12bHFMecx7mouNXSO5twiIIea/w9qzqlvmazW?=
 =?us-ascii?Q?ZxWJyGloJxsFz9oOW80jqmBYlxrn3MDfzw7FGbJ+pOd9T4lr/pna6ryRZoHu?=
 =?us-ascii?Q?cHOeyYdYCmI3LUr54gIdHgeA5liekrXjDv3kvaORN0tuthyOjB6Cf07VovFD?=
 =?us-ascii?Q?r9lvIaq/5nU6ArnYO7dBkUKDzL+y4sayFIwnSIXt13Nm6jUxiq9H5Or3zjO4?=
 =?us-ascii?Q?BscPG3EWyhUaeE0Ibt0ei5Gko9GuubI0q8TMcB+IHbzzzvm2EHHfP9sYvxQD?=
 =?us-ascii?Q?893sR4lNGSqKC2HtGckO0QCOKDsDk6DPeUIizUGXFgqMI7XH2tO3vwkaws4v?=
 =?us-ascii?Q?XAipeyzbG9JhaNEkxhL5XUqnwo9bxqT0ZuFTzR2HGDDVKkrlXuvutHnhkijV?=
 =?us-ascii?Q?c3Vr5YZlp/ibYrZkCj7tU2BUfcVqso8M3w/tYJnZZciF2KXKgZgz6McBd0QZ?=
 =?us-ascii?Q?CnFDCjJZzKwTRw1qTcjHGBeNhVW7u0juHnMCZPclwZyNl1uzz84aG5vsizfV?=
 =?us-ascii?Q?EtsPLMukAzFM+s6lcNdaEdbK5i3uYb80WZ5WS2ouKYqQ92+rumgcN59CctCr?=
 =?us-ascii?Q?F1F9ra7gJinBbm7NL/eZ0sg6H+MzkyAKG6ZoWAZ5qZ28ii5whHlxKrPaWiVi?=
 =?us-ascii?Q?uZOUmVjk9lJCwGE5H4DQmchn2llP9VW97qk+vzHA7ayf6QznX+s/ovfxqkG1?=
 =?us-ascii?Q?d8SF6WPoj4+oKN+jprM/qM94bQB7rPIvhrG2tUk7e+lqkPAlES3g1477IJbg?=
 =?us-ascii?Q?F8iNKZkF+hJ7bJKa2lxQSO9PKMSjubNoS/UmyBuUx0g7QT9DDJhRjN7d84Mv?=
 =?us-ascii?Q?+dhL2RgX2a0u1sc01TffDwW0nvSmI/o/LnWkV7glvbn09iNG5jWz+ZMAoXQZ?=
 =?us-ascii?Q?CxkiKEIEAAiLeO+pRYqCVFj4jb7d89lfFulsY3pUp1jioJbCJBAKfqNKAqdD?=
 =?us-ascii?Q?vYqFMH6TmO60II3kQqPStQ7HVOpecMa0xBnWJ1ug3pN+yK3rv52SMjUo67Zu?=
 =?us-ascii?Q?uClDOOfKF5Gsd+6y3Ur2//a2sxrEuPwv9cD6yDgzNxO8x+IBQG5Obk0gOtJ6?=
 =?us-ascii?Q?B28VI2WabW4slHg1Hmnubqb/Iib6XMXnAo8A9hCZdr3S9VLkX1E0txfPCW6w?=
 =?us-ascii?Q?p7y3LBtO+QdE/OIBTXwNumiTZvo+zHedRIwVMcsH1FaAOuuJEtXqJdcINGs9?=
 =?us-ascii?Q?NI1WveXJEfFdZZdf225XPdcwpWvFUf/7gT146wN9W3kW4/p349eSwllwzGOw?=
 =?us-ascii?Q?KM+J9nUVnSJkH2+0UbUKAF3bFLlb9bZ+PaU806+H/cJcjmAYdLBJxqor2rkz?=
 =?us-ascii?Q?bpJjPI3CcTO65b8/ENqXBm0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uRI0jhUAYJuQ0KNfrIqorrGjo2e4scyJaSF68oo7uM58n0LT5F3e/WoMDdik?=
 =?us-ascii?Q?Y86OgkpiBwWiBQGskt8DVI306qUU1Ua7FBa9dTP7RiyLlUoJMaIkFRTcLdCf?=
 =?us-ascii?Q?GCrtfB7WwaHPH96mvROytsfVqRgGILmhexKHBRvgr+0Dub2DzszT6zOC8Vq+?=
 =?us-ascii?Q?2P8fvbdS8lWye8cRCae9jJoMNUWtlzXHK/WHVjrsbgXgW3MYGaNIpCUfutRM?=
 =?us-ascii?Q?GPCjTQLtZXbmb/WWl+q6xmHl0Ig+8XAhGdcYyvXCta+46IEgLp/QHKUmaPV0?=
 =?us-ascii?Q?L5tbYzJI0RiNCbhMPGc0sjwgB2jyJgyM3dluNexbDBonZCiDJpp5obw04hkI?=
 =?us-ascii?Q?yNUYIZhGsQxphT+Zcn5qZSNBfhRMlYe9bREd9dL7sTEvY1lpIPvoVQYzrB7F?=
 =?us-ascii?Q?RPQfGmQI5KGA17DyZXMDzaWmR40+uPbHp8ysVdrenUB0I6E8KFJHwY0mCYyw?=
 =?us-ascii?Q?2GGuH14UobVBgS15C6xQH4f+85NyPtFklGsnHuyOp0aMIPH1w82bKH4rIP9+?=
 =?us-ascii?Q?AiDZBxYtUjbbKEqEilfwR/sN2mZ/Ia3DwXyK0NDBpcu7E3aZpgNNlHgLkOB3?=
 =?us-ascii?Q?yzGExh/k8Mne4wAkJCEsbZJlkCstzL1BWaRbvpuhektUo1I6hwDtDbjgUKOJ?=
 =?us-ascii?Q?gQf49zE918NQsHipAhWrt2OSpPRMPbvLmv+eriJJwgpH5CXWbeTOf1quBUOn?=
 =?us-ascii?Q?qqjACr3D2mFwx7cS19N+GQ3MOMjSJulpH5Vull2+hXX73IbYVKbwQMu/t6u7?=
 =?us-ascii?Q?kaiZxpKB0gy4BUsEpeMfsBdh1eUTPYFjV2fyEtZLcOg+khCuyRTfAaEAG1eM?=
 =?us-ascii?Q?kRxQgP1Fpt1EPGpF4IQN6eKs9O7NXE9/OiTuWJy6H9VE9L1Q2CYxFeYzTKGj?=
 =?us-ascii?Q?sfODw8DT6TXtRetlRctyhCFjnz4oFKeXUbKir+QxX8kwHiDZSdTDmPJN1FCb?=
 =?us-ascii?Q?sxVp+yCVof6cMeX7fbN4pECNTmBvaid0Pn2ETbUJayWUXq6p8xXAbZW+/53u?=
 =?us-ascii?Q?ztoxkE1OXb52AkYEjDgcvH5/89Q4lluR98A9QTcn/k8nbJZE02n3BccIgPTj?=
 =?us-ascii?Q?y2OTx+J02OSm46OgmfH3iHmFXlaRU0QL/GPQrfnR8sNrmpsW3DIs35G2TXGW?=
 =?us-ascii?Q?OizdvcsWQEdYkxTieFdFHyHD2IhXxoAZmHdy013kuhTUs5mzaa0HSqVoRSSa?=
 =?us-ascii?Q?iG1JkbOO5h8CrfuUMoW+Y9CbFdoR/a1vSHytR5eZWa5lLpwWVZTqfIFvVNkH?=
 =?us-ascii?Q?NOgvbhchJarxD2NIAFlnddDwvIDajRbMoSX8pnHextCxBsVzLa7MeWnaTFb7?=
 =?us-ascii?Q?NuFuqOdNuZic4HZbVPh2RaYQQPjChV+eMaXO87XKvvpiEAq06DElNMd3jeAK?=
 =?us-ascii?Q?LcebzCwYRprp7PdK5CRkEP40y5Njd6oEQt9NVaGOz6WF2RQS5S3fgZNuZOV+?=
 =?us-ascii?Q?G49xpKL/C2Qq/1wPrePOn6TQv4rgCtr7oHSLPtKBfNLanvSc+criVHPN8JL5?=
 =?us-ascii?Q?l5QUXyBDtj0KRJgd/qZUFWVeXabfAXVW6OR8fyR2QFjv79l185pBciSnSECp?=
 =?us-ascii?Q?28yPXOavjeUvh17CPc2Ok5BRcN8yDCa/hkHmT22ekmXoqx/KFZGu+0ExUKIR?=
 =?us-ascii?Q?kWmOOSfbhhFFIjuUgpPyYLZLjn7yRX6qTCpkNrTu1Xje0I7AWqucbFPmht9W?=
 =?us-ascii?Q?d5uTkr4jMLdsN7BBPGZQo0CUInxR/ixGAzpBW1QW8dUC5Wq+yggk2rLWNsH2?=
 =?us-ascii?Q?PH+x9PyIUa4yJkIjpjJm12VbDkVvFVI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85292f8f-e9dc-400b-026e-08de6874acbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 07:19:05.5954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLQpoqqaW3EC4BsJrHw0F1uH8kyq1oyx1GnlbfDW88zgAsKrfplqS/DWzQA3Gp4yeawPb8V2U9+oWT/LAwTmLSjvtL0IGTn3KSR2cKDvk0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4953
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-16696-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,intel.com,kernel.org,vger.kernel.org,lists.osuosl.org,redhat.com,resnulli.us,gmail.com,microchip.com,linux.dev,nvidia.com,lunn.ch,davemloft.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,dt,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A146A117D3F
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Ivan Vecera
> Sent: Friday, January 16, 2026 7:46 PM
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
> Saravana Kannan <saravanak@kernel.org>; Prathosh Satish
> <Prathosh.Satish@microchip.com>; Vadim Fedorenko
> <vadim.fedorenko@linux.dev>; Mark Bloch <mbloch@nvidia.com>; linux-
> kernel@vger.kernel.org; Tariq Toukan <tariqt@nvidia.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; Jonathan Lemon <jonathan.lemon@gmail.com>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Saeed Mahameed
> <saeedm@nvidia.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net-next v2 03/12] dpll: Add helpers
> to find DPLL pin fwnode
>=20
> dpll: core: add helpers to find DPLL pin fwnode
>=20
> Add helper functions to the DPLL core to retrieve a DPLL pin's
> firmware node handle based on the 'dpll-pins' and 'dpll-pin-names'
> properties.
>=20
> Unlike simple phandle arrays, 'dpll-pins' entries typically contain a
> pin specifier (index and direction) as defined by '#dpll-pin-cells'.
> The new helper fwnode_dpll_pin_node_get() parses these specifiers
> using fwnode_property_get_reference_args(). It resolves the target pin
> by:
> 1. Identifying the DPLL device node from the phandle.
> 2. Selecting the correct sub-node ('input-pins' or 'output-pins')
> based
>    on the direction argument.
> 3. Matching the pin index argument against the 'reg' property of
>    the child nodes.
>=20
> Additionally, register 'dpll-pins' in drivers/of/property.c to enable
> proper parsing of the supplier bindings by the OF core.
>=20
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
> v2:
> * added check for fwnode_property_match_string() return value
> * reworked searching for the pin using dpll device phandle and
>   pin specifier
> * added dpll-pins into OF core supplier_bindings
> ---
>  drivers/dpll/dpll_core.c | 74
> ++++++++++++++++++++++++++++++++++++++++
>  drivers/of/property.c    |  2 ++
>  include/linux/dpll.h     | 15 ++++++++
>  3 files changed, 91 insertions(+)
>=20
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c index
> fb68b5e19b480..b0083b5c10aa4 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -13,6 +13,7 @@
>  #include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <dt-bindings/dpll/dpll.h>
>=20
>  #include "dpll_core.h"
>  #include "dpll_netlink.h"
> @@ -654,6 +655,79 @@ struct dpll_pin *fwnode_dpll_pin_find(struct
> fwnode_handle *fwnode)  }  EXPORT_SYMBOL_GPL(fwnode_dpll_pin_find);
>=20
> +/**
> + * fwnode_dpll_pin_node_get - get dpll pin node from given fw node
> and
> +pin name
> + * @fwnode: firmware node that uses the dpll pin
> + * @name: dpll pin name from dpll-pin-names property
> + *
> + * Return: ERR_PTR() on error or a valid firmware node handle on
> success.
> + */
> +struct fwnode_handle *fwnode_dpll_pin_node_get(struct fwnode_handle
> *fwnode,
> +					       const char *name)

...

>=20
> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

