Return-Path: <linux-rdma+bounces-21686-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TX+jCPY3IGrdygAAu9opvQ
	(envelope-from <linux-rdma+bounces-21686-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 16:19:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B15B66387C6
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 16:19:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KNLXfHBg;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21686-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21686-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FA2430DF40C
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DF3481652;
	Wed,  3 Jun 2026 14:11:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8FA48165B;
	Wed,  3 Jun 2026 14:11:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495865; cv=fail; b=qnNwXoIP5ekxrxCT5LNzs7nwpKqc1cdh8pRpgQOXLLHlxv+mBLjaXlkvk1SpzK9X3VbNayfcargkGIcOjsMxjaX2IvCyGacA/1o7cqxx6hOo5OxJ1p1+cpfY/dt50G9LppK929WxMBw2uTa8OXyz0kPcjEFR7zULccqAd2xaPno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495865; c=relaxed/simple;
	bh=ZYIrcOr0nvxeFdguupG91EsG9UDrcIo0MQuwFNiM2Q4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vCgf5VGjsF+sp6LLp29AJb5+93AIPsRikNMtH0SZ2pk/tOLmZvHUDZvoHQ9G3iij1uBjexmre7agPZ9nmGEGKNwrYrJmZZBPtPPfta564F64QRUgryiPRCj0IiObc5yxnSpjz5uXbrkW0eWLW7xFzrpnhLl2hPsrSYj/FZ191xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNLXfHBg; arc=fail smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780495863; x=1812031863;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZYIrcOr0nvxeFdguupG91EsG9UDrcIo0MQuwFNiM2Q4=;
  b=KNLXfHBgaTSMZwLAxWRTxaoGolw6IQ7K9WfR8lhceuUk9D3S4BLvsy5q
   HCwdPpKBLkDakgslDK6cXTRYIrSU5AFdcrCokDp1+gz9IbGgwmnxRD8B9
   CJ4ep0prnpGSTAwBKGYJj+iiPwBZkluH5bwZ22ORwzRt1e9oTrguFMkja
   JXR/vgeljZOu4pfHyPMdIblbQJZx+fyEZ4I6LcbqNgUv/c/s+rQ4lOknz
   EBRFW49xKtic7oRn1O+stxYXEHHt1Wws3UzJFSaPMb5rEzeXHSIVB054t
   6jfZAP0qVGVSntuqKw66jCoNWlTvLj9eo4WgBUUovxAuZqYOjK46RSd3e
   g==;
X-CSE-ConnectionGUID: FJ1TN8QRQ3aibR1y7ok0SA==
X-CSE-MsgGUID: xCp/qW1eRdWYmTEJXNL55w==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81164165"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81164165"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:11:02 -0700
X-CSE-ConnectionGUID: 7WfXerH4Qb+U1DqvkI61ew==
X-CSE-MsgGUID: wlVbw4lyRw2N7M0oLUQACw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="237908515"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:11:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:11:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 07:11:01 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:11:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aD+GrPJ0V4biXePrGD/jFamP7P7guvznkZnsVe5ZX/SEg9XiQ9uJ++OSX03yIcfP24yLaOj1tFiJRAZKNUgYOzTDSZhF6qwaAH0RR0Cr7/k9a8UcTsnEih0F1xEM69N9GKA9G96P8FuRu0jePi16qNwaTK+iwzD+GITOIHl8WNYzGTUdzB7ByKtNd2eGDc3MqmH33NeU2wl+m7b/0ugPqxrgsg21bJit/Zq1iKrHaIgRySHAX+H4Lix7D02njFB2GnqWo8wewivxBPQgv8w0Jkzr5aIVKzq8WrIB5CWfXSX2beMk7fcWAlQbbriXVAenET7HO7RqZ2kU1jnAWD6qmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+AujP2xZDFcnrRjlE1FzPMcRBDn5sLHj9Ypwt0Bn7k=;
 b=sQ6p5cSFZshR1QpApFBvF+Ftcbgsg0n/WcDbB8hQXAT6YfmlTpqlPGXuejSu16vlAqVX9Br+YwotS6cTQdVBsskvv+LEpgJ/fKZUq+d2FUz8ci9Qcj48pDj8NYgsGgpOiS/n46lCWowcywZG8E/lDBILI/gYLCWNRAwuphCwemRKLkOnKPLn+XWFID32vQ6YFXNWf+jR/MwjeJcHBTuT/+yEBWt0eSCyolqioMF8TnQAv1DbSBNw8lI/egZtKdbOtu8C1fNo3WYM4vjrSsjHKmNFC35LxZ8GrGNdsU/kbGkPwH3SVRldXwyuR9w8lj9ng67xwS5jdrvrMXnooyXFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB8420.namprd11.prod.outlook.com (2603:10b6:208:482::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 14:10:57 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:10:55 +0000
Message-ID: <b41436ac-5d4e-44f4-a60a-a9c8d8f67ee7@intel.com>
Date: Wed, 3 Jun 2026 16:10:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 0/2] devlink: add generic device max_sfs
 parameter
To: Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Vlad
 Dumitrescu <vdumitrescu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>,
	"Aleksandr Loktionov" <aleksandr.loktionov@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Arthur Kiyanovski <akiyano@amazon.com>, "Petr
 Machata" <petrm@nvidia.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, David Ahern
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Amery Hung <ameryhung@gmail.com>
References: <20260603102646.404797-1-tariqt@nvidia.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260603102646.404797-1-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bae7312-750e-4e1a-4102-08dec179ed9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: s8Du5OU5BVegL0lC4CC3h6s5wBWkaQhRjTLqt6uvt56WzJvur24YLuKZlYXQrcYM0tnuyTdW4SsBOZsSRfBjf0LQySci3mqQRaWQwjl1qDkSBw3q7NQRDTKrWgmPzk/bOIpUeOofTVI4suRjrynTJS/z77OGAD82aO5WUcBdS5RaTaNrp8SCzDp4yCmtxdpL7Fw+4ctjXptLwUnqSuntpv4Nu32aV3GrhcgQQUO7uCk9J536iCfsuWXZlKWUfd3Jyjda0nL5z1ZXW4oaOzEHEaAmk8jYLdvR1na1nQR6vDvGlMi2oI30txm6IQlrJdr73NGzl7k39YjpUJ9ZWcEhAiJWtUIpigKKjOLZVgsFop6OYHJ4qyc0zEoAzz1S4a/sjT29bN4UW3el6MIdW//8bU20A7tXs7+K+LxGPx+ZLtu19wPXanu4MRtN5hftrXqD+IDMRGnG/OBa0ZuHj5xlXIXSqZERFhWw6HLfIGIH9KGzX3eCj2WJLWHaPwaFIPPEbIkSKkNvkMmkG/HsqtexRNBYj4dr28dpVBsd0FxbIiP2uGOIwIWMORVabfJ1X227XghADyjzL+TgA9dYfm1Rvys6q+BzgcRXZ6sJYR22gISr7ycQwGbzu+VAwZ3LlBm8wuTyaqplf8pUZDXo5A40MxTNIGgC8xl/TwRc9FOXaKri5ujc8u3d6BezjNFL4xUr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDBKZkRzOXFjNDFBbDREQzlyVmZTZjg5V205SllkcVR5ajF1ZjkwTlVDYm45?=
 =?utf-8?B?ZWtsRUY2ZDhtYUUveHczRXMxcllTVTNPY0Q0MFlYbjRHQmZiY2szWDdIUi9m?=
 =?utf-8?B?THVrUnRQRUtldmNVOUVROFhhbUZXQ3RJNjBWTmExcGlZWmI5cnM4UTM4KzlZ?=
 =?utf-8?B?RFI3azduRTJWdFFHaVlxRGFmVFRabUsyTENNQzZVRFFXVk4yTTBpYnFndGJ3?=
 =?utf-8?B?aDJ1NUFsb2Q1LzJxd1dPcTIwUlNTUlVKcDFSNWMzZklFUXBmZCs3ODlXd0l4?=
 =?utf-8?B?VnowMUQ3T1FuZWQ1R2JuWVpnVVI2bXQrNFMwNzhraEFkTjRFby80VklVekVt?=
 =?utf-8?B?TUZmTlRIV2NJVXpyV1FUR01taFplWkx0M3d2bnloSytqVGh5d3RnK2lQWlVn?=
 =?utf-8?B?U1NJM1g5cTZnRlhjM3BZNDR3NFdyZjdLMzJPZXRpZTNCZ3UwWjkxbVo5WUpE?=
 =?utf-8?B?a1RBRmpzWUV4UUtCWnA3MCtpNkJwSzEza2J5MWkxM3VEelY2YU11MklLNnNP?=
 =?utf-8?B?Mnd5dlhxQ0RhVmRzMFRFeC93d2JwdkJoSWYzQ2ZxemcwNkVYUVl1ak1uR2oz?=
 =?utf-8?B?L3ZKN3p2bzhmR0FIbnJ1MHlSR0pJQ1lOQ3Z1TmJWRncvYmViT25Vak04OVJv?=
 =?utf-8?B?ZUNRRHZtYVVqVTZmdnJRd0IwV21mRkRyRldYVTRRME44cGlhL1lqWFVIUWVh?=
 =?utf-8?B?V1F3TGhYNExCUTZUb3k2eGw3THlhclJGMktreHlGUXBNMGhKR2g1MHhSWlZ5?=
 =?utf-8?B?bEpzZ0NyU1lkU0dSakdXZmNXbkdQR00vdE0xd1VnVWFFejRtQWpLR2o5Rjc2?=
 =?utf-8?B?UWJ4cGhsVEs3cWk4Tzh5YW9Da0k4Qll6eWFJM3JjYkRVTlcvN0xPMlNwdXlH?=
 =?utf-8?B?VEppd3Nhci9xaXphU1FzVTJIbDRpcldsa2drWGMwWHhkWjMwVGdYa2FpZk9i?=
 =?utf-8?B?K3doVDVhZEJWOUVGR1ZSYlUxNnJwaElVZkJ2NHl5SDV3dmYwd0RFTDlOZDlM?=
 =?utf-8?B?OVN6RWxZRVM4MEZBb20ySDh5U3NyUm9DQlIzZnFZdDRuQ1ZtcGVTR21PN2Vk?=
 =?utf-8?B?RjNFNUw0QnpaenlJbFJldGN0VUtIQXdsVXhJbDB1VFQybEFTU2tJakg3dUE4?=
 =?utf-8?B?VjE3UHBTV2tGVWRMM2RZWWVsYlgvbjVhbUtQQjBoMHpaOXRPOGIvUXNPcHZK?=
 =?utf-8?B?MkhhWHo5VGlveUlDQ1Yya29pV0ZSRVA4d1JYcS9BT2dpZWl2cWVudGJDK0My?=
 =?utf-8?B?dTlKREEzZnFBQ2MrWWNEeE91TzFoUDJpYWtkcWtaL20rV0JYZkVoVGx6WFAv?=
 =?utf-8?B?dTIvZDZibC9TTmlMci9LZDhmZkxvQkMrQUpFa1VvV0tvd3cvaEZQdVBqUXJN?=
 =?utf-8?B?QW94NlVkeiszblNwdjN2RWZmL0JwdnE3NDlQTEZ0blpTb0tTWStDNkQxeDNq?=
 =?utf-8?B?RUFUT1JCRkQyUU9oYnhhelVwZ0RpcU5JNEtmOGJZcDBzTFU4SEk1L1ZOV2ph?=
 =?utf-8?B?VFp3TC95ZTVyZFBrYTNjS285T241SXdsdDQ5ZVBoSlUvZjQ4S1pXenRvNUps?=
 =?utf-8?B?UkRtMDVxc1dqblEvM0JPM2g0RnFNNWVRRklJOXRPRGozU3grNldHQWN6NkJj?=
 =?utf-8?B?RHQ3TEd4YjZLd2I0OHV5OWJVY053TjI2MTYrajNmM2NFMkU2YVNaUTl5cDRM?=
 =?utf-8?B?UXp4MWFEMGFGckpFZDBxNXgxWTBZcG1SV3NwNzgreERNb1VqVWwwcVVndEk1?=
 =?utf-8?B?eUxSY3hkQmE1cjRKbHUxMlBVdnpaUi9WdG9YbVRkYVh4VjRXazlDSGZQa0hj?=
 =?utf-8?B?andnb3FGK21zR0taaVdMNnh4UXJ3alFOUkpJSmQ0K1pzOTRTYmxnVFlPMURC?=
 =?utf-8?B?L012UTl6dlU2OTFvcloycUczK1NEMHA2QUJ3YTlremZiRGJ2L1ZLZDdHWXo0?=
 =?utf-8?B?dFR4aFJQYVp5L3ptNkVxY09mZXR2Ti9icXlyR0Zzb0FnU1hFZHIxSzlqemcw?=
 =?utf-8?B?ZlBibldUL3FtWmVhbVR2R2FoYkZ5cUptZmNzalU2bktBc2w2RHpWRktMTzhG?=
 =?utf-8?B?N2R3YiswOG8rRkxmb2VoSlUycVVHYzBYeUNnMTgxTUZ3NkdOcVl3WmtnVTc1?=
 =?utf-8?B?RWFuc0Yva0VENnlhNkJGaGpyOVNxbFFJbDY1b2VXMy9NSXhRd0lGU3J5M3Jr?=
 =?utf-8?B?YjRVUHNXeXlRRnN3bG9Vc3VvaU9mMTM3dElSRXNIOWVHdXdWQlc3bmp4NWZt?=
 =?utf-8?B?eHNQcC8veGF2MGc4amZ5RHA4bXBpLytFejVRbzYxdHFiMWttNkRFZnJBRkNi?=
 =?utf-8?B?Wnd0OG9wb3dWVTA2V2JMMi9zUjREK0t5QjllSkV2MWRXLzBkOVNYM0hadVBz?=
 =?utf-8?Q?natnM0WMOFPKN2DA=3D?=
X-Exchange-RoutingPolicyChecked: lBYId6bom+TT2sA+mDtFbhCJKr0B64yH5Y+AW74jGWi4V2KJZI3dtueISZo4l6+/uAIOOGeUgsjquUwzW7XQLwoS57Q238rjhZ3ujW0F2m+JyKMglIJNvNGZifhP8aWoCC1wRQl6rVyU/XMKiaB3gbVaVUIMupHID3NfdBPP/ugxLiu7CRprdAfEtoDoiEv43NW6cN/b3+Nw8WUa4VScy/eAhj3rnnnlik8Nqqebgl06Z5IAR1E0ndSSWXcyLZZmuE0JlELxUBF/JJzoLzY1fqEwsG7PAN6tw5CKPFnYw+aiT23qMOr1rXxNr/nI4hTNRxXK5KGW8TrC0P1SgOIg0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bae7312-750e-4e1a-4102-08dec179ed9a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:10:55.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4UCanIC7eptzczTmO7k6F50KbaeHj63CLwpjBtOycFpaMr+CvztDaZNJfg9J49hQh9YnedDhO8uWiuTsSr+Sp7633STkaDDiP4Iw9A/65k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8420
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21686-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email];
	FORGED_SENDER(0.00)[aleksander.lobakin@intel.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:vdumitrescu@nvidia.com,m:daniel.zahka@gmail.com,m:aleksandr.loktionov@intel.com,m:przemyslaw.kitszel@intel.com,m:akiyano@amazon.com,m:petrm@nvidia.com,m:rkannoth@marvell.com,m:razor@blackwall.org,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:gal@nvidia.com,m:ameryhung@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,gmail.com,intel.com,amazon.com,marvell.com,blackwall.org,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B15B66387C6

From: Tariq Toukan <tariqt@nvidia.com>
Date: Wed, 3 Jun 2026 13:26:44 +0300

> Hi,
> 
> This series by Nikolay introduces a new generic devlink device
> parameter, max_sfs, to control the number of light-weight NIC
> subfunctions (SFs) that can be created on a device.
> 
> The first patch adds the generic devlink parameter and infrastructure
> support.
> The second patch implements support for the parameter in the mlx5
> driver.
> 
> With this addition, users can enable or disable SF creation directly via
> devlink, without relying on external vendor-specific tools.

For the series:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> 
> Regards,
> Tariq

Thanks,
Olek

