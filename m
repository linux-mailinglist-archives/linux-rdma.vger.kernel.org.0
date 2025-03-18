Return-Path: <linux-rdma+bounces-8794-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A51A67D40
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 20:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA794229FD
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 19:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D22B1EEA20;
	Tue, 18 Mar 2025 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tp4/RvMf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7E225D7;
	Tue, 18 Mar 2025 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327157; cv=fail; b=Xzi3EtM8dA+8L/uIHPUPcKmlTMnlPdIl1x3bfn4UG2IqgjCSzMewx6FyaD8w2SVgHGYozgVdDiBvbA705uU7E+/WIZYdGuAsjjWSGFS+mj6wny1lpSw3kM6XVMjHylvLQBEG0LnDAsKJRvBwGS6mQ7CP+/JP8bieMan9HulUqCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327157; c=relaxed/simple;
	bh=kTEmGlissPVhXR1t1jO42W3l8Llc9vAI+UX2Iek7IMg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u0MiiD3eo2ejpxMjNPY3Zyg+DRP+/COtVWllHnQ5b8fYTIKCjRXYUtsezbnMKweD7ussJUyrhhvZU2lX4MxPUEUgrZ6am8Do5yF3/cPDB0f8WKcwscuOgdBAbSUmK8RVJWS57ytakNhDXBYgoxS7VIWM826U5wINTQyQPPG20PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tp4/RvMf; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742327156; x=1773863156;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kTEmGlissPVhXR1t1jO42W3l8Llc9vAI+UX2Iek7IMg=;
  b=Tp4/RvMfnkIO2kUGHThuzZ6vH/det1uUBC4LlInb0D2xfZTfkRskQYHH
   S3X0J+Cq5GwKltrTYMUeXhEXPgXgAaBoPGEqlZJts/d5q7xCIxTn5txDn
   +c3MyG3XqmPXNuHW8nZ6BlcOaNCPvAgs0QG/39eF9QK1C+XRgsnRSOvzW
   smJGXZ+H9PoImk7JdS52NW77vYOyAYlqqWelc/+lICYNY0RTfU67CyuDs
   dVIIx53Yb1NA/o8iw4JOLNKrSvI0iLanesZ7luqizT1gL4KKW1LNAklHL
   1UU2TDqFC0o7P+mlGFrO9CIHsyDX/b3ri3RI/iuEO4dGH1gCtItrhiyoc
   w==;
X-CSE-ConnectionGUID: NkV2PfPjT1OwDb9NaJK1Lg==
X-CSE-MsgGUID: 2HltIorgQ2m4iyUV7eoYFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42738265"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="42738265"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 12:45:55 -0700
X-CSE-ConnectionGUID: ebFY0OpARxOdVpjAlKJp4A==
X-CSE-MsgGUID: Dn3nk765R8uTJlGmIQOxuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="127406184"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 12:45:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 12:45:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 12:45:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 12:45:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDVNcPeXpglDHyArPUWFBa9WeyB4bDotSCuRFKeYU9vZWeg1kCKWIZmwANKQVXhIHF5TL29y+0CGwtGnji5EQrMjS1jJWN6ar5Y+NW9X33Inb7XkDUNMtBdbONNAhM3R4e/W8iOb/LB+y4+/lceFnqgvpGxJI7zalx5Qu2RA6qbbBh6QqCCpUl2eUZ6T9mXOJbF50YhkpO+/Uf/DyGVvFVKMMvc01vAPwRG79K41xvl3ht31idLf4pOWgJynyaQuY82hTwTCHLEZ27z9m8CVHkGYKIHmOx/DL7CVLqSB3K4j07K1Z1QF/QRyFDeF75ImcyE1Y2NymUGSvJXY4FVU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/Gny9Zw9NuEWtN1cVbI6/mWfLrapBzRX6AmL6Ys38w=;
 b=FKAq1RZYXquCzoVNXfF0m+OGDPuEs4fFo/EesExqLbk9PoCdCEMIggnAtzwNO+sZ058tzi+f6hwZQNV0ZtrOB7Tf7uIeqe9gr1P7P8dk7y+nvEucHXJny7KoHlFKNULXwmtCyOgAGJc5JMcEZCwH2j1fQ3/+7/UsZWMGITcwADL8E4GvlYgGi5Ml93+4OS5EX/WNbuQv+4zYqdVhiiHXLMt1N7/Jrj31wKB4CWPWgW7rKxmQdO2na9KtXmA8jY8iCKEsaDmfG5v97FYy5dhYGY5jjPIltMfTGt81viaSVETkRxUyuTEsPguElUqFtFFc3+xjrqT4MwhEy73dfqGDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by CY5PR11MB6343.namprd11.prod.outlook.com (2603:10b6:930:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 19:45:51 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 19:45:51 +0000
Message-ID: <2e29a3f3-1c74-461a-a7ae-efe6c429fa1f@intel.com>
Date: Tue, 18 Mar 2025 12:45:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to
 support multiple consumers
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Leon Romanovsky <leon@kernel.org>, "Ertman, David M"
	<david.m.ertman@intel.com>, Jakub Kicinski <kuba@kernel.org>, "Nikolova,
 Tatyana E" <tatyana.e.nikolova@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
References: <20250225075530.GD53094@unreal>
 <IA1PR11MB61944C74491DECA111E84021DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>
 <20250226185022.GM53094@unreal>
 <IA1PR11MB6194C8F265D13FE65EA006C2DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>
 <20250302082623.GN53094@unreal>
 <07e75573-9fd0-4de1-ac44-1f6a5461a6b8@intel.com>
 <20250314181230.GP1322339@unreal>
 <8b4868dd-f615-4049-a885-f2f95a3e7a54@intel.com>
 <20250317115728.GT1322339@unreal>
 <dc96e73c-391a-4d54-84db-ece96939d45d@intel.com>
 <20250318172026.GA9311@nvidia.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20250318172026.GA9311@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|CY5PR11MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 21885440-0d8d-47fb-91bf-08dd66557cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEhzdTE2VFhpbk1jN3UwdkROd0ZwcDdLLzc2R1EvbjYwS1o4eGhKR3VZaVRY?=
 =?utf-8?B?T3Z3V1M4bnBxZXVUbnpxYWhGS1lWNVpyNC95VFBVZzI5eFFBTmNkaWMvVVFh?=
 =?utf-8?B?MzJaUDdNSjhCM1V1NXVBODB3NEhuRGdadkhrbkN3ZjRhZy9LVXdsOVZvS1F2?=
 =?utf-8?B?U1VkaENSSFBxTU8xRlh3eEdXNmJZODVPR3J0blBtcUU0RlVJNitrUWZHYTlp?=
 =?utf-8?B?N3poU3RPd3JFR2ZhK09CN0NObDU2eEdQb3BvV0o2VXJ0RFBPTHJJOE0zanNl?=
 =?utf-8?B?K2NiS0FMVEpWNG9WaHEwcnVQTStBYncreDhOZ3dGSU1mWGJhUGJlT3cvcktm?=
 =?utf-8?B?ZjVoL3cxMTJHdkdpQ1FQa2F0RnJ1QTRwZ0lNTzFxMVlib3VPKzlodHpZTnZD?=
 =?utf-8?B?eXNPRmlrbkxBNUZ2d05QNUhiRHIwOTZ4ckpoU3VGK3NkWkc2RUljaEdjc24w?=
 =?utf-8?B?a2w1ZWJRTWpqZ0RJK003Sk44TTlHV0RyR3ByYmhRNmh5Vm9uTDV4RndvSnNJ?=
 =?utf-8?B?QlZGdXh0M2g4dXFGWng1MDQzanptZkcvUnhLR3Fad3FTNXZIWmxncGM2c3ZC?=
 =?utf-8?B?YjhlK1BxYWtDSVdDbHFZYklsbzgyUVA5YjBXU09BOHpITXp4NG0vMkZiRGZC?=
 =?utf-8?B?d29lRGN4VFR3UU5WamUzS3cvdkxEWnRuc1BoQjl5aTNGUnRJeldvMFhDKzNE?=
 =?utf-8?B?ZDd0VUYxSEZTRlpmdlpBQlNpQ0pVN0hBSUN1RVQ0SjJTalJzMFZVeVdJK3JJ?=
 =?utf-8?B?STJuS01QQ1JJeThVcFJPd1VpTlRHS3JOTm9BODZBU0o0SXFDR09UTEI1MWNG?=
 =?utf-8?B?UURxV2RMQ2djT2lpekFRVHh1M0wrQisvOUM2Z1lsMm0xTGVLL2dpb3phNEE3?=
 =?utf-8?B?WE1WeDdsSzEydjBhdG5IZ1JlT1dzcG5zbEMwQWpSWG5wK0N1QkFCS3ZYRi92?=
 =?utf-8?B?RzFtUGpMWkJuak5tL3JzcU1veXFPOXJOSEtLVXFqbU5IUStWejJiNGhuL0NL?=
 =?utf-8?B?OG1FV3hoeXB6MS9ZR0liV2dKVmFuN21YbUYzYyt0OC91ZmliUGxwODkzcm1V?=
 =?utf-8?B?MDJRMTFiWnJ2MU9oUktReXgyRVA3MUtaUlA5UXhoSGxyQ2YrMnk5VGRZSHJR?=
 =?utf-8?B?OE9JRzFmVWdMajZRbGs4Q2N5SUI1NDUzalNhcm1qaHJBUnJFLzR1dVJJUnpJ?=
 =?utf-8?B?UUV2WUREUXJJNXprOWRWUXc2R093MUdsZlRJancxVnd3b0hFSGZkZzZMNit2?=
 =?utf-8?B?ZEE5ZzBrZURwL1ZmR25BWFl3NE54UEdEbWluVk1YUFllMzBtaVh6Zy80Qis2?=
 =?utf-8?B?eS8rSm12RkJrTFZWbnlhL0laNnFIOS9sdUF1eVZiTTQvTzZNNTRlTFVoWVpr?=
 =?utf-8?B?Yzh4bWZ3dytyVitGOEhKNU5EVEpxMDdBemZhRzdDZ09QMEliYkduNWdaVDdk?=
 =?utf-8?B?eEZSTnNuQkhyRHFzYXZOc2NFNzkvTmdPcHN5L2E4K1BWdU0xR1NrN1VROUFq?=
 =?utf-8?B?ZGZNdk1JcWd4NUxEZ0xTeXhvODRrdk5BZG9WV0pJS280TjdheXZuY2hIazRS?=
 =?utf-8?B?TEhNR01wVldvdlh3M1RFdEVPSGloNE9Wb0Fwc1FWbFNWUXpBRVZXMy9yWWZh?=
 =?utf-8?B?UiswSmdjdlVKZVcxVUI3SVNnQ1ZMckQvQmpmS3VWbEhwazNSWllRMnB4QUVu?=
 =?utf-8?B?cG9IU0VYV2MwN2M0VG5WNmxTK0RXWS9zMEF5N1MrekNoRTl4MHdobCtrZkpF?=
 =?utf-8?B?bjZWa0xOMFZVQkJiK2J6T0xTSUU5blNBWTAzYU9GbEFBYkpEUDR6eEt6MS9l?=
 =?utf-8?B?b21Gb3BZelBYVExrY2JEUXFZd0EwOG50N2tlN05aamtlWGI5WUJuZ1dyajAx?=
 =?utf-8?Q?tdMkpwRE0yl8a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUJqNWhGeS9GYU0zSVhRdCtlOUxtaXBDR3poTnJIUTQwVU52RnQ5Uk5jQTR1?=
 =?utf-8?B?UHhteXJzWXdXK3gvdVhvTFFwU0dPZmpLVlNEeHZuemZQdFJFUzU3U0ZSMTJl?=
 =?utf-8?B?Tk5hdU9uQ2pxSnIwNk1hbUtpdXFYV1BXZ2NxV2tOa2xyTXVuaVVWY1JnaFpo?=
 =?utf-8?B?SDNIY2NhVkpPU1J6RkJxWkFIWDRxZGV4T3RuTW9yRE1rZU91ei80MHBTek5U?=
 =?utf-8?B?MnZDaGI3cTRZTFNldFJudWtIUHRMWXphRklCMzZWOUpRV2FGaFpWdlgyeEtp?=
 =?utf-8?B?Rk9DeWxVbE1ZaWVETmQrS2J1Z0dJclpRRENDUWdDYzFHMTl0OGpJMUMxMThN?=
 =?utf-8?B?bngwZk03b0xGMG5scXp3dUdFK0puTVgzZmFtRkJsY3pGdGhkU0t2WFNSVHNu?=
 =?utf-8?B?cTliOXhhMGcvQlBvNHptVmd1WFg5N2x5enQycEdxQ3RXS3IvKzZRcGZBWklY?=
 =?utf-8?B?OG1POGVYNkFUa3l6QUtSZWZpeWRRUlZ5OCs0dHdHOUNFdlZYc29tSnhwZVlj?=
 =?utf-8?B?eUFCcDNCbTE3ZStWYUNNejdoMEF5eVB0bzdtRWpxdnNJcW1uTE9sM1FZYUtB?=
 =?utf-8?B?NjV4NUducVN1T3NqZWtGZGNLYUw1WFViWmhYWDEwV1NrQ0F4U2cxckswODN0?=
 =?utf-8?B?eGMvWmFrL01ET2d3U2lscFZXNmFSYWhYN1oraUdhR3J2U29sRHhXL1pEdEpn?=
 =?utf-8?B?N3haSkJzcDFBVnp5TDBQYVNQOEd2V2lVK01TT3VKWFdURjlxNDNOWkthYVNl?=
 =?utf-8?B?d1NiUDNEWkJPZzdObnM3ZUZ0a1BWT3BKRG5GUlZhWm9BdVk0bjFBa0VBaUhi?=
 =?utf-8?B?VTZ2UFo3dmZVVjRkTko4ZWdjVS9ZQnRvMnRQUkR6MmkxSDNxVlBtaXN0bUZV?=
 =?utf-8?B?Tmg5bFdtZmtFRy9ocFZFcStuR0xOOWtMaU5DRy9WWHI4MGE3U0tlZ3k3ZUxI?=
 =?utf-8?B?ekg4ZExQN1lPNlRTb2tySFhNcFAxaEhheXVQTXFrRWp0OEpGL2F1NzhjbTVj?=
 =?utf-8?B?bXZVOThrZ3A3ek53dUJNV3RxY0g5Tlc1WFU2YVVPVFZKRThwTzhIU2l5T0tG?=
 =?utf-8?B?ZTc2QW9mWUJjdkdxQXFBaUZ0cWgvK0x5RjRMZVdPVjRXQmNwWlJ0b1hYUGVp?=
 =?utf-8?B?aXo5b3h4cyt4UlBWc0tRVU5RbVZJNWx2OHU1RnNTWHFXMGdoK0hyMTdoQ0ZR?=
 =?utf-8?B?Q2x1bjlyMFJQSTRLU25uQU5tS2xtQnZ1TXVyWEJ4QVZFRDBVSkdYSzQ2MHhi?=
 =?utf-8?B?VnJyditFQkZmZHpOeHFEZXUwbjF1UkpNbEs2blAzZ2pSdEpSTm9KeGJVV1Qz?=
 =?utf-8?B?bXRENlpaSWNVZ1c0cEJtcWRJdFd3dEZzQnV2RHZFZjJVMmJjZnVWanZTazR5?=
 =?utf-8?B?cEFGc1dWY05uYVRJbzYwN0tIV1BXaUQ4bGxDbENHV1U5QzVZcVA0bE5Bcytr?=
 =?utf-8?B?dFN4N2pNQmliNkFxNkdYRklxTTE3L2FzZ3RpdStyQmc2M3o4K1dSMXRidUJy?=
 =?utf-8?B?aFV5bHZPblVsVGFZRjQxM0lZb2FkNVgrdEVRRDI1Z2JkK0MyUkRnMFJPdkZp?=
 =?utf-8?B?MWFaekZUcEYwWTVHU3V1T1JNUzBKeUduR0RaM05ONjVuaVJBMzEvcmFQOTFl?=
 =?utf-8?B?SjRnVlVCbk9wZE93c3lzK25nOFR4aTZ1c1RYUDZOZk9qVmtzeUtDZHA0N0JQ?=
 =?utf-8?B?VTZtL3pRMW5oRk1DUlN1UXB0a0hlQlpNZmVPQ1JTNmh3dnBOSlZZaTVaNlVF?=
 =?utf-8?B?bzJsTE93cXM1SkxSRVlyNEladUgzNHdwYldqMEhqOXJhOHpFZTRvY05yNGtZ?=
 =?utf-8?B?OXdQNmVqbHdmaFJRYmFETmdSaUNuemkyVFcwOS9UWG1CRTFxL3p3cmVoeExs?=
 =?utf-8?B?VHJKUXh6MVY1SUtQdVljcmoxbVBQSWhTcG9NbzN6RlFLNno0cE5tcThvOFlE?=
 =?utf-8?B?dUxJaEo2cVdmUHRjQkNkTStlVlI4V2xEOGZWWWxsbHYvVWlNVkE4M2NiSFlT?=
 =?utf-8?B?RnFKR3o5SFZGSUVPN1pYQnMvSE11S1pIL2pGRERsSEFPRVJEVmpnOTZTNlFw?=
 =?utf-8?B?TWR2ZHFtMkVLZGdDcjJNUUY3RU1yWEwybkNHNHZvSTBJNHIxbEJjUGNScDJV?=
 =?utf-8?B?SG1SU0dHaFR5RkQvSzgzRnY5Q3BoWS9qTjdyaDVGMGwzZXpRclhGTzJZZ29q?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21885440-0d8d-47fb-91bf-08dd66557cf3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 19:45:51.2593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QaXr3AvFWYPjE8vaHQ/EFRC41Y+KEsaC3u1RwoF2860B6nU8eGHSG8h+r6d493ibt8A1ccjDswsUeKtdGYHoKECwZwvvjVTHsv0gjlnvw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6343
X-OriginatorOrg: intel.com



On 3/18/2025 10:20 AM, Jason Gunthorpe wrote:
> On Tue, Mar 18, 2025 at 10:01:36AM -0700, Samudrala, Sridhar wrote:
> 
>> Yes. Today irdma uses exported symbols from i40e and ice and loading irdma
>> results in both modules to be loaded even when only type of NIC is present
>> on a system. This series is trying to remove that dependency by using
>> callbacks.
> 
> If you really have two different core drivers that can provide the
> same API then I think you are stuck with function pointers :\
> 
> It is really weird though, why are their two core drivers that can
> provide the same API? Is this because intel keeps rewriting their
> driver stack every few years?

This is a known issue due to HW/FW interface changes across multiple 
generations of the NICs forcing us to go with separate core drivers.

We are working with HW/FW teams to avoid this in future and going 
forward we expect to have idpf/ixd as the 2 drivers (idpf providing the 
data path functionality and ixd as the control/data/switchdev port-rep 
driver) for all our future FNICs/IPUs.

Leon, Could you approve the callbacks approach considering that irdma 
needs to support multiple intel nic core drivers. We would really 
appreciate it.

-SridharW

