Return-Path: <linux-rdma+bounces-4556-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1F295DB1D
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 05:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61086B21B34
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 03:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77C31BDDB;
	Sat, 24 Aug 2024 03:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/AMYVuS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC61D2D60C
	for <linux-rdma@vger.kernel.org>; Sat, 24 Aug 2024 03:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724470836; cv=fail; b=igJchuA6HyXg2klyLCAeXwPZTLSRaJuo+Ago/583DNmcLF20SpEhCMj7rx9yidx89uoSuCoF/vBA9fnDBF+WuB5QGXiXXhPEhfplGxtamMuk3sgAj5wgW5+wawCoYPKg5eYbRA0PINtJOArrlfgLj5nlEH+QfboRWo8KXdCJSPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724470836; c=relaxed/simple;
	bh=uOMYyRMMC1dzOtxD7K5ItLDVTmiB//5JJboifd/HuRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YxUmIVCxt/rM++NsamNn6ZSBO302DP2RR9b07U6Q+9hpv4Nyj1/GWo5qa51+P5xWhnCUJ9OKyZVMLIDnQ2nMzf7e6Z/7ry3vfp2QOOPUtEqjO/lVMr6j8aT3xxqQ7jDacN0LrXbsabGjQfm6PGhg+cWEwnSp2xZkl3pS4Kis3o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/AMYVuS; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724470835; x=1756006835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uOMYyRMMC1dzOtxD7K5ItLDVTmiB//5JJboifd/HuRw=;
  b=K/AMYVuSvncjzDjArIkKZ+u3z+EenddR5T1ZGsDXeTaXu9ATPgQSm3bP
   Z1lWIv6DHN4WdoLn4XDdZZOAePIwdEeSVrMGorJ/Ej083Au3+jfEhETK+
   ANJL04WHdLd2IcjoDXXb8LKJOvfPM0e4VLypQ5FY+6GUwy0xjIVt2QPn2
   3zHQblPY9xPbaV60MRR0YYBq7nGatHMD0c2i3QMiKjbUzei38cAzZZRLn
   2zahvTVwfGCsUqbWnqYgpi30hzm949WUzwSVr+fCe6U+d/ST608hWBRvN
   cc/l6BsNALzKAHj5KDUyQHB8gDIS0WAfYR4ngho2Z1QB5VedFCdxrFby0
   w==;
X-CSE-ConnectionGUID: Is9msT9GSdK9f8EqhJAOPw==
X-CSE-MsgGUID: zNy6SR+JTIyo84Z+6ZgZkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="33631598"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="33631598"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:40:35 -0700
X-CSE-ConnectionGUID: D8FlE93mQqCbKNjoBr+acw==
X-CSE-MsgGUID: tDQd6x3NT12WHIV6KX+vdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="62293323"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 20:40:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 20:40:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 20:40:33 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 20:40:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dA9FPwwlcb/ZkGLdFn9m/8bffH2Hui2yUwK83wwdTY/OG+Msv+nHaTbOUoJZqe+rtV4WfgxY2kLuJwFgKeRl5xnLFB5ASXasthk9f5pOtRCvQ3co+nqMFLH9YTx8tSDkBEFS6wRUd/Td6P2NWvgxAyngS+B7vlbVVvoSlLFJpBwuOl0R5ka9+oudxkxdL7mkUHl0tOZSBWVLeKcHEd7iv7UijBRSNsXvhnIUmPNGSls13bKXlsk2haR9d7EcdZpjVPn6jz1DOBa66n3aDBOP48evVOCewn7qqyr5mkUqevNsPIdvpj3TZQ2754oZbBx1hXs7c8+7YqbqAjgUwOhz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOMYyRMMC1dzOtxD7K5ItLDVTmiB//5JJboifd/HuRw=;
 b=Q/jrsX/HN5/DCnj2MSrLgiznrT6+ZIjonARSly742B4c7Bnlrj7+WGRDoq81f9VSgug77N1Lj8MCXqaZaaaT/FIRa2bsF9jZ+CEzvKQrvFingXhGRlwz8zTp3YJSxV/weO2tLzds+lou8AmCM1CD4A2ke713ewhHgTiz7dqbJTb3oXl0nsz0b+96ApREnLPo/yOstGkYwnZJ/jitcIS/5Skon1TywrmhIzKc7JC3BEP9O9Z7RIkQRbI00B0gaHPpzJsmpWF0TOaqSyVjHhtJ1rgmm7Xn/yhJOAjek2hCkJTECzjbwccWTMMKYD7GAc9cne49EYqayu2pvfrcd7349A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17)
 by IA0PR11MB8356.namprd11.prod.outlook.com (2603:10b6:208:486::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Sat, 24 Aug
 2024 03:40:31 +0000
Received: from IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::763d:a756:a0e4:2ff7]) by IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::763d:a756:a0e4:2ff7%3]) with mapi id 15.20.7897.021; Sat, 24 Aug 2024
 03:40:29 +0000
From: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Hay, Joshua A"
	<joshua.a.hay@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Ismail, Mustafa"
	<mustafa.ismail@intel.com>
Subject: RE: [RFC PATCH 09/25] idpf: implement get lan mmio memory regions
Thread-Topic: [RFC PATCH 09/25] idpf: implement get lan mmio memory regions
Thread-Index: AQHa3iLse86vrIMog0y3Vblaiz5O77IHd2gAgC53nGA=
Date: Sat, 24 Aug 2024 03:40:29 +0000
Message-ID: <IA1PR11MB772760DA48CF337E85C97D20CB892@IA1PR11MB7727.namprd11.prod.outlook.com>
References: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
 <20240724233917.704-10-tatyana.e.nikolova@intel.com>
 <004c46e4-b308-40d3-a3f6-ec00545dca4f@intel.com>
In-Reply-To: <004c46e4-b308-40d3-a3f6-ec00545dca4f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7727:EE_|IA0PR11MB8356:EE_
x-ms-office365-filtering-correlation-id: f9585818-9e56-4b22-3d35-08dcc3ee7fe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TlJWbTFRSldsRHV4TjBSOFNnS00ybmZFV0g4UmN3TWhtMmRnS3hDakxkQVdK?=
 =?utf-8?B?OTUyTVNLV1NyK0haUWFMeDNNRGVubjR6cnVKWEVHK01Wb05FQldGM2VRM0lP?=
 =?utf-8?B?QXFTcEpCWmxlZ2JpVWRKMUdxTjJuRUZRSmVTR3pYU01HWGwrU212R3R2Um9t?=
 =?utf-8?B?YkhTYWtOeWRURE81cHBYenY2Wml2Zzk5dDVob29VVXJmdnc4QkZZQ09kc21U?=
 =?utf-8?B?VW1BbHdOMUVUS29CZHBGQTFGZ05SMUhvZ0tNTk1LbUdBWENQeHl5MGxhSWd0?=
 =?utf-8?B?THZsSlV5R21hZWx3dUVCYWF5OFN2cUNodHc2UWJ6V3VrTk80NWVzdU1zWnBL?=
 =?utf-8?B?M0RybEc4V3ZoamQ1cllha0ZvL05aVUhSR0UrQXUyRitqZG5pMnV6KzJNYnVM?=
 =?utf-8?B?QlQ0Ri8vbnJsU09Ka2x2VFdIdUtVQjBZSGhyZXJ4VnFGWHgvZjZDN0Z3UUkz?=
 =?utf-8?B?aG8yUmlpamUxMEFhSzRSY056UENVRTRoSjVYYlh1S2NrQzA4UzlxUkt3VHRr?=
 =?utf-8?B?UjRlYlFYYjlzZUlmdFF3TkkrZ0I5RVNSSUhHMGJVQzlhYnlIRlkzN1drMFJ5?=
 =?utf-8?B?Qkp6dlhXSlJTMkJBUFJrZVZnYUdCUlEvRDRMSThCcWdaTklZM0lxYUI5bWp6?=
 =?utf-8?B?UGxpaVBQTkNHR2dRWUdLMWxlQkJnSk5wdUNJYi9XMjdmdWFSVlM3Nlg2VERt?=
 =?utf-8?B?R05iV1hYczlma3dZUmN6NWoyOWI1UGIya2o2ZWNkS0s4YnN6ZWdzNTFXOGhT?=
 =?utf-8?B?NE1SY1pSc2wzSVhOQnFxZjFWMCtvdC8yRkdsUml5YStXMTJDODcrQ0FEbFRR?=
 =?utf-8?B?Q24vaTMrK2RwbjVUTmEyUnJqbGFhdXpaSjdmb29jZXF6V0xXakxBL04wYjZS?=
 =?utf-8?B?Y1FYN1B4TVpaRS9kaTNITUlqQTMvczVkd2s5UUNHVDR3ZVduWlBJY25QRWRj?=
 =?utf-8?B?K2dzVnlTUUxjU3VpU2VUb201TmNmK2FVMVV3L011Wm9jWFd1WUtCeW8xTHJu?=
 =?utf-8?B?a2NROE5KVlZBdmREOHVpMzg0TGtyYjNCVXk4cld6eE9WT21IQVVpNlF1cGtC?=
 =?utf-8?B?NTFabkFYd3ovRnZsanBZbXdENlh3bEhiK1Z2WFp0R2N6ZFU2N0VkNlJNTnBB?=
 =?utf-8?B?SVNTUkRMeUw2eFFkQysyT2xWY2QwOENnbWRFMlJoUXB2NW9uY1A1bGRjUnlP?=
 =?utf-8?B?bzZCcjVnYkpKNkNrR2VDejFSUHFCblU4cDhwR3lBTFYrS0ZNb0VNaldiM01I?=
 =?utf-8?B?M2RwUDgrKy8veUZxOU5JNExETUszL0xJMkk3RFZ3VmR5SEFNQ1doeWlyNTU5?=
 =?utf-8?B?c3RtcGc0TDAyTjZFOXNkaDNtb29YSk1Sekg4K2JmOG1HQVBHMVNud092TFBp?=
 =?utf-8?B?UzMyeXc2b0lnOVpzTnN2Q0ZESmVLT1pHSllYTEhFZFpvUm5MeGNFWEppdmxr?=
 =?utf-8?B?bkRyMWtPckJRTHRVT0xZTXhkN2JlVVNMTHJsZjVEb2t5NUt1TXpUbGVFNndt?=
 =?utf-8?B?eWMzSWFOZytHNWt3ZnduNzNCOU1FRnJ6WHRYSUhWaWttdVl2WnFEMzd4c0JS?=
 =?utf-8?B?N2FjNVlQa2sxM1JnYVczdUY2VTNtSWQ2ME5HUEdxQUpUNURtbk8rUkdCTTJM?=
 =?utf-8?B?SUtnSjdGTzhTN2pKdUlPYkIzYnRxa2srQUpuUjZTcUw2YzFpdU1VWWxwN2J3?=
 =?utf-8?B?aWZCNHR5U093czQwYUdPb3VRSVlzYzlKQVFpSVRKb0dYU1ViVHFYeC84eEps?=
 =?utf-8?B?WDkraHVaWDFCUEN2NGtWTmdrYnR3NXRDdWpZVGdWZ3V5ejc1cHlDKy9UTitZ?=
 =?utf-8?B?blpnSCt2eUJTWTRuWkRhM1BDSGFlVCtycHRFbDVENzBWbm5lN1ArcEEvRTFw?=
 =?utf-8?B?cVU0SGVFNXAxQnExQUoveE9vdWZhSVdkUWMraE96RTNacHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDg1Y3lOUE1iVWVMd0FFOWc2dU1KWlJ2M0lEUG84QW1Ib0ZKMkR1bmVSSm5p?=
 =?utf-8?B?amNVSmRqeEprZnBqRi9TSURYSWg0YkVyNUZTM3JkL0JweTd5UTF6Y2dPWHBw?=
 =?utf-8?B?N1d6WjduaWZqbWJRd0gyUFNZaTdmQmtMMlN0Y3NReEIyTGExNDFaaHRobGpv?=
 =?utf-8?B?aktvUVZrUTFQYktON1NKNTgrb3ovdzRDMWJwUFB2cVZoam5YeHZRNU9rTDE4?=
 =?utf-8?B?c2VFcWcyYk8xaU8rU05hd1dwd2tQdUhpcmZDblIwQXpwb0lkUGV4eWZUTGVh?=
 =?utf-8?B?NWlRK0lGdHBMMlpvdHZXNVFZbHA1UDI3Rm5nYVpYZWNHejdITEVzczFwUlly?=
 =?utf-8?B?T3ZjMVZNak1CSjZDVFJBcE1id01pR082NzI4V3VCeGR4WGpOWmx0elBSYTZU?=
 =?utf-8?B?b2tVTThtUGcwTDl1Z3dpbitrbjVxQ1RvTmlyU214eWJUMlI4dkVGcU1Wb3Vq?=
 =?utf-8?B?dUFUeXU0bVdMNnlsa00zQkhPRnZXM1ExYmVTSVFXdFMwZXQvc1lhZGRDWExT?=
 =?utf-8?B?VXVsODBJdERGNW8xc0RXMWNKRlhMQk9VcGpvU0pSMmNjeHNYbkxSTVdXNnBI?=
 =?utf-8?B?Z04wS2xhZ3g1c3k5NlNEZkJhTGt4MXBoSXUwRGVRaHlZYmR5dmUwdWNTL2wr?=
 =?utf-8?B?K2kxaE10TTVnaUtrMk1Hb21nTm5tWEJYZGdrbmxqeEEyQVlXNVJaR3RjTUpM?=
 =?utf-8?B?RWY3TDVCemlmWlZVZjd3M1FUQzY3SVNEOFBvUGhvczhKYUZmOTdnd3B1NGNC?=
 =?utf-8?B?eitxQnBMMVBDMTRIb2drdC9GMkR6VVdrR2txRmJEd2tIVFJZTDdOc2VTQVNZ?=
 =?utf-8?B?VHBVbHBsYTJuUjd4aUFXaWovOUJibncyYVdualhydUtZaE5wZTNQRGlkdU4y?=
 =?utf-8?B?bEdWdHhIMzk0WE5WdlREWTVGK2NtemdSSWF3R0FDYzU4TnR1WjBJSnNYaHZv?=
 =?utf-8?B?Q2lsTFhxdThUenUzYyswdzI5OGd6QWEzR0prSktOekRYQUZTWUhSSjFNSndU?=
 =?utf-8?B?L2hiSTg5SEovdnVNUk1ZVStWdXpGN3g2TTk2amRQMDB0ZzBwR01lNnVGWHhi?=
 =?utf-8?B?WU9ZZDkwOVp2SUJLejdMVmxaZUt6Zmw1bS9rR0VjWUp1NXk2N1pFWThoSTVw?=
 =?utf-8?B?YzczSW9PejBsZ0Z3NVE3dlJOajgzUkJkK1ovOFdRK3EycTNsaXZpdXpnVTlJ?=
 =?utf-8?B?NFgyTnpxUkxsZGJ0RFNkNDkvOHl4N1RGQXdUVllnc3N1YnVYZFdweE5mdGo1?=
 =?utf-8?B?bEg2dE5QSktQWW83dGl3YjY3VVYwZDN1SC81aU55Q3VJTmlLQTV3WDUvUmZm?=
 =?utf-8?B?K2RaQnMyMm5neE9mU0pUdVg5QUNadjNSWGttTjE5RnJFd1Fud1VTSWVsMkpk?=
 =?utf-8?B?MlFyV3dxdXVGL3pkY1E3Zjh0WXZwQmg2MGUwWlIzbkZzVDRmS1EzMkEzbDJJ?=
 =?utf-8?B?MmRBc25HaFBjWXp2NjdHZ3dRekJPUHlHRDE0RUVwVkpIL1lBelZVNi9XdkhH?=
 =?utf-8?B?cmIzNkdXV2orWERrOU0xMmZjRGFTZk9LUEhOcE5EL1hyL3ptUXBaMzZuU2s4?=
 =?utf-8?B?UG5OZ1IrU3VBZ2szRzkzVlh6V09FTEJJdUE5VjUza3dRN08zQWhObmFLS3RR?=
 =?utf-8?B?cm9ya2szeDFpNmNNRjFBd083OUhlcnlFckozSHlQQnRjV05YNzhqcmkwcGN3?=
 =?utf-8?B?M3FtenQrelF3ZmxYZUhGNDZreC9PQ1o5VG82RzdGcVo3SmFFaUxFTVI4Y3hh?=
 =?utf-8?B?Y0RZOHB0cHRCUEl6cXZMQktURlMvdXd6WEtUTGVWU2RQaWZNQUV5cXM1MHds?=
 =?utf-8?B?Y29uOG85V09hdTRzSXl6cTBCS3lHc3JIaWxIdEtwQWU1S1FEKzFEZ0ZJMTNL?=
 =?utf-8?B?eFBGY1Fab09zVDUvejVNbmYzbnYrWXh1RHduQzZiYlFhREsrb0NxNitnNVo3?=
 =?utf-8?B?UW5ZMDV6VE9sNmFuMDlsb254RVZ0YmEvVENWQUVVSHlNNlhlZzVaeGttZkZN?=
 =?utf-8?B?dnY5cHVzeU42OFdaUVdUTVRQcXk3M3ZsK3FsRTFHZ2QxNTV5QnZHZ0FBaER4?=
 =?utf-8?B?VisvNTZhWDVldXdOTGp6K1A1YWhuMnhaOEU5SExvaFo3OHBieHc4cFJrcjB4?=
 =?utf-8?B?OHZ3VXU1R0JoTFVhV25oSjBnZndSTHBaN2Q2NnIySFZRaXY0ZVRXUGNOL2VN?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9585818-9e56-4b22-3d35-08dcc3ee7fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2024 03:40:29.4596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+qvtEyYoPBWoGObPBVjsuK/vyJRljqBIQlXge5chZ8morAJUIzT/uoBXRy0AJxSMN+HtN/MMWgm4wM3rpo4zPCaBdWfmTkp0KG1wir7n5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8356
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTG9iYWtpbiwgQWxla3Nh
bmRlciA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEp1
bHkgMjUsIDIwMjQgODo1MiBBTQ0KPiBUbzogSGF5LCBKb3NodWEgQSA8am9zaHVhLmEuaGF5QGlu
dGVsLmNvbT47IE5pa29sb3ZhLCBUYXR5YW5hIEUNCj4gPHRhdHlhbmEuZS5uaWtvbG92YUBpbnRl
bC5jb20+DQo+IENjOiBqZ2dAbnZpZGlhLmNvbTsgbGVvbkBrZXJuZWwub3JnOyBsaW51eC1yZG1h
QHZnZXIua2VybmVsLm9yZzsgSXNtYWlsLA0KPiBNdXN0YWZhIDxtdXN0YWZhLmlzbWFpbEBpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDA5LzI1XSBpZHBmOiBpbXBsZW1lbnQg
Z2V0IGxhbiBtbWlvIG1lbW9yeSByZWdpb25zDQo+IA0KPiBGcm9tOiBUYXR5YW5hIE5pa29sb3Zh
IDx0YXR5YW5hLmUubmlrb2xvdmFAaW50ZWwuY29tPg0KPiBEYXRlOiBXZWQsIDI0IEp1bCAyMDI0
IDE4OjM5OjAxIC0wNTAwDQo+IA0KPiA+IEZyb206IEpvc2h1YSBIYXkgPGpvc2h1YS5hLmhheUBp
bnRlbC5jb20+DQo+ID4NCj4gPiBUaGUgcmRtYSBkcml2ZXIgbmVlZHMgdG8gbWFwIGl0cyBvd24g
bW1pbyByZWdpb25zIGZvciB0aGUgc2FrZSBvZg0KPiA+IHBlcmZvcm1hbmNlLCBtZWFuaW5nIHRo
ZSBpZHBmIG5lZWRzIHRvIGF2b2lkIG1hcHBpbmcgcG9ydGlvbnMgb2YgdGhlDQo+ID4gYmFyIHNw
YWNlLiBIb3dldmVyLCB0byBiZSB2ZW5kb3IgYWdub3N0aWMsIHRoZSBpZHBmIGNhbm5vdCBhc3N1
bWUNCj4gPiB3aGVyZSB0aGVzZSBhcmUgYW5kIG11c3QgYXZvaWQgbWFwcGluZyBoYXJkIGNvZGVk
IHJlZ2lvbnMuICBJbnN0ZWFkLA0KPiA+IHRoZSBpZHBmIHdpbGwgbWFwIHRoZSBiYXJlIG1pbmlt
dW0gdG8gbG9hZCBhbmQgY29tbXVuaWNhdGUgd2l0aCB0aGUNCj4gPiBjb250cm9sIHBsYW5lLCBp
LmUuIHRoZSBtYWlsYm94IHJlZ2lzdGVycyBhbmQgdGhlIHJlc2V0IHN0YXRlDQo+ID4gcmVnaXN0
ZXJzLiBUaGUgaWRwZiB3aWxsIHRoZW4gY2FsbCBhIG5ldyB2aXJ0Y2hubCBvcCB0byBmZXRjaCBh
IGxpc3QNCj4gPiBvZiBtbWlvIHJlZ2lvbnMgdGhhdCBpdCBzaG91bGQgbWFwLiBBbGwgb3RoZXIg
cmVnaXN0ZXJzIHdpbGwgY2FsY3VsYXRlDQo+ID4gd2hpY2ggcmVnaW9uIHRoZXkgc2hvdWxkIHN0
b3JlIHRoZWlyIGFkZHJlc3MgZnJvbS4NCj4gDQo+IFBscyBDYyBuZXRkZXYgYW5kIElXTCBuZXh0
IHRpbWUuDQpbVGF0eWFuYQ==

