Return-Path: <linux-rdma+bounces-3295-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DEC90E51B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 10:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA411C22029
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 08:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37478C9C;
	Wed, 19 Jun 2024 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEz5JBLp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A124D78C7D;
	Wed, 19 Jun 2024 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784088; cv=fail; b=vF8hlDhHnZzOfZAwwfIMsY9hSrHtOqqpTfiJ/vY9uW5P9GKWg6TfcqFHFmeOJzCu5YStIdCeVltpvcV7dJmHAZxHUh1RG1aTsU1bL1cUPaYkugMyqquWVANpXYgCsOziilzGtX0fQ3sbLjpWma6+dDeepRYrK5n7j8afb2XLCsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784088; c=relaxed/simple;
	bh=kadJ2Kqx99nugocQt01yv//grNQNHu9XxObDDK74dxk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=riG9wtrlJP0eFlzcDuCgT6Zw5Mysy4O8VQpMSmXlLVA75tU6QcfaoJwSgX6dNehN8aq06HSPiNo12mz20rh+mbYstKTiWciWKxwysnVsm5SqnxtFRh8z+CgOgOhUQyuhJhxJ6HEDKdD6M+VG2kiYE2g8V2EgKfLEiKlsdBIDaFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEz5JBLp; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718784087; x=1750320087;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kadJ2Kqx99nugocQt01yv//grNQNHu9XxObDDK74dxk=;
  b=oEz5JBLpj/MZDwK1pE+VbemhNYwHdkzwIbIAFCeaMLHDlXx8JYZGaN62
   dCjzeaCzu4IzTeTUKx5XuOROwbsarrHJNBcLPH6fazaTQqTwXgwwyrxi6
   U6evePo1rlW5uZZiheT7Jp2j9v7jmjhow7CPnwOediEU7OzIe4Eda2HnE
   CG2LvFpwxUcEuY8qFWKWHrgxuCN3dImsjQoPGZ8r1Z2lN/DK2LJFsvlOb
   3QNWepbHB02B8cu12VFc1NLDxPE3NnIoYXzCMchs27ns1dPYUiFSnx+Bc
   +k74SevTE8dz3IteT1m6g0C3QP4V526vhvc4Xvv3j1dkz9mWERPwe6t+Q
   A==;
X-CSE-ConnectionGUID: pGEW5CIkScmhHCeqNsNmww==
X-CSE-MsgGUID: AOUPAXVITKu1sUxWS3ylww==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26300239"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="26300239"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 01:01:26 -0700
X-CSE-ConnectionGUID: nNFdFqRrRUam72kpaNo1wQ==
X-CSE-MsgGUID: BBFZS9VCSpC0Vb1xEmy40g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="46774803"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jun 2024 01:01:25 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 01:01:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 19 Jun 2024 01:01:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 01:01:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeV0Zvy0Wm0ub92DWXGh4rYHb/t3TEB8kUUBHF8RfbatNPvQmkQ04syw7fHtFidl5+RwAe3yJ7pOjZk1ZMeA5mXWaVqSrRAT8hJFDfsDm/SkZkQMXphZHyjXNYLEcszoFe76tp+FwdgwV5YBzIGal0Ry/IrURxaWjehay15ILGDz3LEackNVWxSWRCxBSpXBzgVe/Ytmrku+KWmTg4OZUx2rEZu7Rxk/OEMGp56pBBqs4N2RP2B133kxiqsGBhb03f7Nf/QxTLho5p2DXypWy4NqR24e2akD8HzrMG0Eslnka0d9GYHPQ7ZFtlqYjHe+/754+8aPczmIzhiF5QCq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk8lhTh+cQvurg+Uku9fvnM3SNrttcc7Vm2/HJJeLsk=;
 b=eO2dgKfNMOZn2vK8/yjDVHZp2zc5s2Nx2yJ+5is+7qiuam6fnNcyUrtIpBT2AjYY4Ji5cONC7R0/ZLtUa1EzGeD84WbV4UHDHOoEwOUKgeHxgZn1a+UJCtBc081DJl1OKuEJ0pbB2yZovHMdDQyOu+JEu7Vae3GZb2Rq8ik5tx/1wbF4VQ9i0kFhZnqvgYPGC44LJD8KDHtN5LTPB+qmKt22K8IaVBYrHFMlXm9lIX4RTMJI05VicH3v+VtlMfE1+q8E8ueqN/8u7Jp86l1ymyAzHPt5dWw9QFAP9VrJzEyCAgFn8/kPlGEKtXtZKbRVEhaYuLRUrNOVqvA+x3B2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB6478.namprd11.prod.outlook.com (2603:10b6:8:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 08:01:18 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 08:01:17 +0000
Message-ID: <95549a6e-b2db-42d9-af94-dbc5e5ddcf5d@intel.com>
Date: Wed, 19 Jun 2024 10:01:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] net: hbl_en: add habanalabs Ethernet driver
To: Omer Shpigelman <oshpigelman@habana.ai>, Andrew Lunn <andrew@lunn.ch>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>, Zvika Yehudai <zyehudai@habana.ai>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-10-oshpigelman@habana.ai>
 <10902044-fb02-4328-bf88-0b386ee51c78@lunn.ch>
 <bddb69c3-511b-4385-a67d-903e910a8b51@habana.ai>
 <621d4891-36d7-48c6-bdd8-2f3ca06a23f6@lunn.ch>
 <45e35940-c8fc-4f6c-8429-e6681a48b889@habana.ai>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <45e35940-c8fc-4f6c-8429-e6681a48b889@habana.ai>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0028.eurprd05.prod.outlook.com
 (2603:10a6:803:1::41) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: e3286c87-4d84-48c4-d613-08dc9035ffb7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVRLWUxUN0YxRHpSQ2JQQW0zT01mMWlrMjZZZVpDY01wZUNzd3dGK0x5d3F5?=
 =?utf-8?B?MEJHczFsT3hqWFFVMFFhb0x2TGEzQmpLUHl5TzA0djNZUGtlNS9tNE5kMExv?=
 =?utf-8?B?WUgxN1NGK3RNQXFFS1VLS3RkcFprTEVRTzcveFV6MmFyUHZGRVFFa0ZpOEtO?=
 =?utf-8?B?S1hubFRUeTA5SE9PTDN4b21UZytEVDkyblQxa2MrWjBtU1pnalJDSnBuTGRw?=
 =?utf-8?B?L3o5elJsZ0xCUFFxem1hS3gxcjVBaG5NbjQwS3Q4WWRXbU1NRTlMZVFzMTN5?=
 =?utf-8?B?SGVPWXhGak5nMTliWU8vY3BGQmphSExjNjNkWnlrSC9pYkFQaFpWcCs1ZjB2?=
 =?utf-8?B?QWs5M2crWkp1a1ZhMlU3UDhPTStubE1DV3BvVnBXVTJzVFl0L1JBUmJ4VFFS?=
 =?utf-8?B?WG9oak40bnFHMHFTK0xlaC9mQWtVR2x2ejZ3a0xwbkF2eW10ZGZQTDhBM05s?=
 =?utf-8?B?UDU5cTJWYVhkTkpka3MyOXpyOWRFOXNPMjNELzZpUVhGYlZlS3BpUGNSbENZ?=
 =?utf-8?B?VEFkVUVUbTB4MWNLZmI4TFZiUEdQNnQzeEpwWk96MU9NeFJyRGRuY00rYVFE?=
 =?utf-8?B?OURjTmw5VVNicDc5UEc1dmY1dFhPOWxCV1B1VS9LRnJLNTB0Q1lSY3ZoYzRt?=
 =?utf-8?B?LzBhU0RwdUNCVW93ZFJkMjdDUzUwYkM4dFdubU9FV3NXdHMzMzBWdUVybjRi?=
 =?utf-8?B?dWgvRkRYNW8vOHZXMW14SVo4bUdRNUFyVDZXbDFuVER6QTVqd2Y0RUNyK01C?=
 =?utf-8?B?OHlHZk82TXZDSVc5SWRGRmtTVWlDYXFibVB1R2M5NE9VQjJlRTc3aTN4QzF6?=
 =?utf-8?B?OC9sS0l0cWxWRE94V0dtZ01vakI5cVhiVEhMeUFtNTBrT2FZSWNzbTlkckN1?=
 =?utf-8?B?dFdqb1orZGtYVFlWeXl5MzExankrcjRxVFVhSWJQUGc0Q01BZWtGQlFQRGpu?=
 =?utf-8?B?QjZGQjZHMEJFaWp0NjR3Ym1qbXRTakMwTU5tZmJOQzNqRmNNNGYyRmEzNUNU?=
 =?utf-8?B?aDRLTXpORXN0dFNOZFllTHloWnhqOXhHb0NVMWVFTGZ3eGtJRm9YWE9GM2tl?=
 =?utf-8?B?V1ZsdE1aclNXRERyeFZveFhtTmVsWVlLeHZmMUdWanExOHlJMFJvbnlLNU9H?=
 =?utf-8?B?WWFuT25sRzQ4U1crNndzV3c2Szhvd3hhZHZZdm0vMlZwVlhEUEpKMnpOOWVh?=
 =?utf-8?B?eUpsbEJsOUw5aGQ5Um1PUXRuUjFvU0xvSG5mLzJUUklCeW9remU5NzZtTENF?=
 =?utf-8?B?Q240MnhEblRJaDRnaVAvWmpTMHJZMEswelBRbGRIQ0ZrY2FMVER1b2lEM21B?=
 =?utf-8?B?VEQ2anlRcG8vcVB2and2dUh4M2xraU9aU3YyMnhvZldMU2xrcXpMR0lKamJ0?=
 =?utf-8?B?N1ZORTFZQko2ZnRacXpHYi9JMklIOVdmRHQvRG5rWTdOSWZpOTNrbW81bmpu?=
 =?utf-8?B?dkJVcmpBSkoveHFZQXZMamVwclpnRTN2THJKb1cyZlJVbjRtZHRtQTdLY25B?=
 =?utf-8?B?QURhbTJDY0hUbFdXeEIzTzRwdmZFYnp2UkFXdHZmY2xOaFR3MnpDZGJWWlp1?=
 =?utf-8?B?RFRVWU9WWTZMN0xoWk0xUXJPQks5eWRXZ3ZyTDU0M2FaTUNZN24vaXNwMDA3?=
 =?utf-8?B?YUxTQjNCUjMyU2pBeFU4WGMzU1pjeXRTektLSmdwMzNwRkFtSTIxLzVaT3pu?=
 =?utf-8?B?MlVQWWEyR29teVlXajRHZitrTEYvWndoTGJCTExucUNRNmp2T0tvWGM4ODZu?=
 =?utf-8?Q?yzpv8QXaDIM53uyDE2HwG5EWUMjq9uGx9M20ppF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1RteUpDcFJrb1lsODcxWlp4cnJJcUlVRGliTGdURzhxdjBwVEQxMS9maEpp?=
 =?utf-8?B?eDZld3JkSCs5Q0IrcndYSjhqQ1lBd3pmUW1CNXhYWG03d0RQVnRJamdQaVpv?=
 =?utf-8?B?aFJaeXFHSVVXUTFCM09ROXlXSTVhQUkxbUxRSEtwWnNzRWhVQXUrK3lGYStC?=
 =?utf-8?B?d0tVSnFIQ3k0YVYyV2FYc2ZwY3NxUzJUUXA2am43NUQ3QnljYWUwSkpNajQ3?=
 =?utf-8?B?ZDBHY3MxOEpoTlA2WGxQVjQ0SEJiNUZzN09FY09JQ09FTU5GbkZpMzVjbVFu?=
 =?utf-8?B?Y1dtRkltK05vUlVrRHoxMGNkOHJVcHNGS0FTWVRnVkFNU25jbHlSWCs4aFMx?=
 =?utf-8?B?NnFVRU9VeHB0b0dsV0daWTJQRmp4TjhGa0oyeDFZYXNBWTRWTlI2ZDBJQ0U5?=
 =?utf-8?B?MDUxemZlaXlDRkR5QXVTUGYzcFMvaVdxVjRySlNSV2VkZEIwR2NiNk85ZzQ5?=
 =?utf-8?B?c05HbEtyNCtkMnpZeHB6ZDhTc3UxbjB1clRYMjI2T1ZMRVNuVU5jYTNreVQ5?=
 =?utf-8?B?clFhWVk0bWx1cUthOTc5YzB0MEx4NDdRRTlWdVF4NUthMGkrZkRXMTVsQU5E?=
 =?utf-8?B?ZzNqYjJpMUc2VnFSNThQb0M2amFkS25Wa1BNU3JseXhiOGEwZ1dVR3RGTUQy?=
 =?utf-8?B?cmFxV2dMU0dqc0oxMWROdXJRTXNSTjBEYnFHRjBodzNEQXV6a0NBdXRKQVgv?=
 =?utf-8?B?VkxHZktKSEtmTXFmMiszbUg4VjNKbk15VXBlT2NLRHBSanNSck41SzN4dkhU?=
 =?utf-8?B?eGFWUkNtSFVEUm1uQUk0RzJhdU0yTXg2UEdPakxSNko2ZmRuMlN2RGRYZ0Fu?=
 =?utf-8?B?cklNTEZUZWlLR0RiQU52Y2ZYYklMK0Q4azh5TnJwRmhoK2k3SG1vZjN1VzRJ?=
 =?utf-8?B?bXZ3WUZta2tpQTNFOGRNTkhaQ1h3NnNLbDlOZkZaOFZmQi9rRnBUNE9yWVEv?=
 =?utf-8?B?Mzh6Sld1VUpaTVNJT2VPTUJ2MVo5Z3NmSnUwejBqVWcwOE9JK2xhNEh1Q3Fu?=
 =?utf-8?B?WUNzdzZxa29MUFExUmMrd1BPdEU1R1hvNk9tRGZWTi9kVEl2MnMyQUhISlZS?=
 =?utf-8?B?Vk43Zk44WG5yQStNTUhFSiszcVg1QjgxckhJRkVHcDRQZWtGRzV0VlNsaWYr?=
 =?utf-8?B?MmN5OSsvTWk3WlFGRTF4VEZadE5BeTlUMk9EWWZPTDVyR05NQkpFUkszSGln?=
 =?utf-8?B?WHFzdDFqVWxFUjE2ZVhreUN5YXRQeHczeXJSY2MvWG1Rd3FCci9CN1BQckda?=
 =?utf-8?B?dEhsTS8raUEyL0xQeUNDNEZhdFZKWTEwSSt2SUNwVURrQy9OTEhoK1E1TDZ3?=
 =?utf-8?B?a1BIY0cxS3J2VElSVTVEclp1UXlPWlFKbXo4QmhGekZDSHFtNFJNYVo0T2Nu?=
 =?utf-8?B?YWZYYUpGRHRlLzRIb0dHMVdZYkdLQTFjTnh0TDBzSWlWRnlPMUZVZUdFQmdW?=
 =?utf-8?B?Nnp0YlU4NSsxN2FqM0Zidjdvbm82QXVOZFJESkpUcEtCUU5DcWZFVWJoQWtn?=
 =?utf-8?B?M1FUWFdnYlY2dklDRHBDZkxVOVlRN2Y4ZHNOaFA0V0xhUXBOZkpEWVhlZDFL?=
 =?utf-8?B?QXdpL1ZmU1YwK1EvTWc0ak1IZXE5WW9kT0VtY2lqa3gxZlc5TWZyQWNpWnY2?=
 =?utf-8?B?VEdUejVKZ3AvYll2andkSUJjdDhHQVRNdGpWNmNzbEl1SEhsWk1NSVA4TEcz?=
 =?utf-8?B?dTNtZENMaGxZbVRYbVZ5amZIeEV2bHlLRklOSVFkeHRkZm0xZUxpUyszd0hW?=
 =?utf-8?B?czFWemZEd2kyUlJhSG5IdmFTMk5SNHdHbU51NHkrRFdLZkZ4YU1LaEppaVRt?=
 =?utf-8?B?QmJ4OFZPa2xjRTcyc3k0RnMxS3Q3Y05UbTY3R093OEM1V0lUMGVqTVpJOGZn?=
 =?utf-8?B?RzM5b0QrSUVvU0YwTWxUc3NLMTNpWjdzaXdFVFpualk5eFZMVFVncGpPaUh5?=
 =?utf-8?B?T2R2R3VOUVFIYXloQ1F3WEdLY0FoWFdKVW91RGNzdm1mVVdiai8wb2dmN1A2?=
 =?utf-8?B?RVh4Q3FuSWZTU0NaNVJUWldVY1VmeHlZYnc2aVpBelR0UU5tOGZjbmkvd0tu?=
 =?utf-8?B?SjA4SFNCZUNkL1NYcXlZS1hlOUsrSXRUUGpSSGdyZTVOVTl4OW1MMExmdWlu?=
 =?utf-8?B?NDM4VzJXQkxCVUNEdUtIYlZXbkFTb25SNEhHWUJRdkxXZDdsOHN3OHFzc2JR?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3286c87-4d84-48c4-d613-08dc9035ffb7
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 08:01:17.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLMwASCIqL762kt20VZvxMGWSg7CpqbWr+Dz79VEOU8CnY+VemIgaqs8ESuQd+VpQVUiI6HiuQa1kD27JruDvqkKmuUiLzvJCLCTT2fSNJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6478
X-OriginatorOrg: intel.com

On 6/19/24 09:16, Omer Shpigelman wrote:
> On 6/18/24 17:19, Andrew Lunn wrote:

[...]

>>>>> +module_param(poll_enable, bool, 0444);
>>>>> +MODULE_PARM_DESC(poll_enable,
>>>>> +              "Enable Rx polling rather than IRQ + NAPI (0 = no, 1 = yes, default: no)");
>>>>
>>>> Module parameters are not liked. This probably needs to go away.
>>>>
>>>
>>> I see that various vendors under net/ethernet/* use module parameters.
>>> Can't we add another one?
>>
>> Look at the history of those module parameters. Do you see many added
>> in the last year? 5 years?
>>
> 
> I didn't check that prior to my submit. Regarding this "no new module
> parameters allowed" rule, is that documented anywhere? if not, is that the
> common practice? not to try to do something that was not done recently?
> how "recently" is defined?
> I just want to clarify this because it's hard to handle these submissions
> when we write some code based on existing examples but then we are
> rejected because "we don't do that here anymore".
> I want to avoid future cases of this mismatch.
> 

best way is to read netdev ML, that way you will learn what interfaces
are frowned upon and which are outright banned, sometimes you could
judge yourself knowing which interfaces are most developed recently

in this module params example - they were introduced to allow init phase
configuration of the device, that could not be postponed, what in the
general case sounds like a workaround; hardest cases include huge swaths
of (physical continuous) memory to be allocated, but for that there are
now device tree binding solutions; more typical cases for networking are
resolved via devlink reload

devlink parms are also the thing that should be used as a default for
new parameters, the best if given parameter is not driver specific quirk

poll_enable sounds like something that should be a common param,
but you have to better describe what you mean there
(see napi_poll(), "Enable Rx polling" would mean to use that as default,
do you mean busy polling or what?)

