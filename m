Return-Path: <linux-rdma+bounces-12213-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F7B074F9
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 13:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C2B581B53
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 11:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B918222127C;
	Wed, 16 Jul 2025 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZuFFiba"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F82AD0C;
	Wed, 16 Jul 2025 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666341; cv=fail; b=LqnpKxgSDTQKIpIhHI5X1Y+OzHARlCvM/YXI1GVfk/hCSQnfsJBoU9AfU0WV6+0YY2kklgef5vOmruYbTAYVJNnzHY+HwSpWfbAV3XI/tBAz7BcNU6c/s8qkDxktGcqz9PfkMXXCznldm+gIUX75gxpqfnYYEg93xucCmZBpT68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666341; c=relaxed/simple;
	bh=X8d/qSVLOonOowLS0xBffyCqLAk1Y4w/ABuOvMNSQSY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S4sLcUJwM6HPIMFmW5/iQiQJzAGC+ZckCSyJ3AgLcfaOUjms1OsDzZntGcGA1UIenBq2BFMQQQ6l12kZoMOw7LSBOeCl+GE/oQNlkmK7cBQI3VD5phE4++TApCUN6H8/1IPVziu8DRh12QTO6DHB7kc0NKUXOOj+MvqLK4uOTHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZuFFiba; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752666339; x=1784202339;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X8d/qSVLOonOowLS0xBffyCqLAk1Y4w/ABuOvMNSQSY=;
  b=XZuFFibaN7eHTQrKNCvTn01gciYuZ+o90wMH6t6NzfiiW28BPBG0j+Bz
   FBU1mq6hKmezeOBGq0zN7Xsi+o2h4ySTpefyEzpNENNRocvmn6T1KFgXS
   QcmTbZgqiyZM0S5OmOmplX92w8spgakiPpIdN2MwlxHN0iJIS34o9J1+n
   XZL+TYFPqjz3oveje+mmIWNPYX/rOEs6BVOLN4BsLKFzVrhTrdT+msg9I
   mHJ3+rr4IM2h7w75GuqrtQ2KQRKUi2YfcmFBnieP9BZ9IawHgz2j/Oo1k
   OyBeRbfG6wMkJMk+H+MhL9GqSoDjeDKwpjFZdoN+S8MCfBmHi0QBYtyh8
   g==;
X-CSE-ConnectionGUID: Jzh2WCd4Sxu8f5EJr+mGLA==
X-CSE-MsgGUID: N8CbJUCcStmtDQoIR1HGyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54879302"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="54879302"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 04:45:28 -0700
X-CSE-ConnectionGUID: vmTn46rITMSZyYlklvwkHw==
X-CSE-MsgGUID: VhNfrL1iTniK7Hp6QUMNGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="157579011"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 04:45:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 04:45:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 04:45:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.66)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 04:45:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSpfmRYbEDXm2u7Pm9GHBiXA9BobdFBaMv5iJjAoizWrVDKcaFuBN6VFrvuAx+k1zP67q/5/jzKEsIuAluYGs38Ik7GC54ZU4tOe2ITnk2UuIKdP9RXNwPNU8b463muYaRl5b5oCV+z9kv8W736qWiOj9LeCtCYPz+Ht6DFSgaUch5pULr08u4S48CfLh7ezocOv246RNVOkuBWCWpQjEyvWYfBkHECzg3y89Py4FDwX9AaQqh2efXQGmR1jMD9xdczdbNNC/QLb+BmoIR2z925WabgovIRJWsl4hD7SM8LDD0S4TWKl58JHgZltENX21ySirsmTmw1li+0saL1ypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dUS6RHDhRKeyAoh8BZfJj+Nupw/vNiu/N7VNKZKNNg=;
 b=K6K/QEcTTuM9qoGwzoni9rsDi2rrqFPuJIY/Zb3f265wJiQlV7jyFUXJEZPo/UCS70A7AO7v++34LEYH7L9RosKJ9WTnhbywQDqkt17LjrzbsAUFwv41jYOIERTxuWX0PmtwN2jgFo1ZE7Vokz59ECyrFwibE54aBYG9Amw4wUl3KlXhYAQV+utLG3vYwst2V14/6P+2BS/tI1TkGyHoFrTjDlmkxBn516HDnfh+vIoYX9R4E+srY9ftZObm99JjF3nUmPIJDqFgj4luR0iPEX3NuuLsvbLJgfHlr4MaL+DHBtt0F9rrRucf/NhSwGhXS6IKcTxyRfNtPY0AL9TvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB9449.namprd11.prod.outlook.com (2603:10b6:8:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 11:44:56 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 11:44:56 +0000
Message-ID: <bac466e9-c18c-4cc6-a143-4139a3395305@intel.com>
Date: Wed, 16 Jul 2025 13:42:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net/mlx5: Avoid copying payload to the skb's
 linear part
To: Christoph Paasch <cpaasch@openai.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-0-ecaed8c2844e@openai.com>
 <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-2-ecaed8c2844e@openai.com>
 <98c8c7d7-4b1a-474f-86b6-884d79ea4e41@intel.com>
 <CADg4-L-YRbFeDsmeREZKJpe2aZ4g+LXbxNTPe_nCJ=7v3jgTgg@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CADg4-L-YRbFeDsmeREZKJpe2aZ4g+LXbxNTPe_nCJ=7v3jgTgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 772a4863-0925-4fd0-1021-08ddc45e2fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cktZaWZTaXk3MnFsS1ZmOVBlaTdXdk9KZkVJRUFlNnJmS0JDMDJUU3hsaEpx?=
 =?utf-8?B?b3drMzkwalhPUm53UFg0K3I1RXdUbFY5Y1ZOWmhwNHJOb3cwY0VzUmkvSUZv?=
 =?utf-8?B?WnNVSy82S0VFdjJLT0xRb0lmSzFxdnZRZThscS9JNmZKUFpBN0Q3K0JEUXVv?=
 =?utf-8?B?bzVxaU8za3RhZWlyOFpIdHc3VWxzUDl1WjlEV29lYnE1ZS9WejNLeDdjZzU2?=
 =?utf-8?B?bkJZQUZrR251cjkwbmJ4c0tqdlYwUGFRQkJFUHVBbUhyNHU4ajYwV29GbEtl?=
 =?utf-8?B?N3pqVmFQVmJCU0xkK3FIVGVJL3NQNElEOWFMUy9nOGlzbXBENVR4bVRvbWI3?=
 =?utf-8?B?SDd2eTdHcGp0OXZEaEtaaHRoWHRWUmNHT214eTlBdkZQemVqOVp4NGkyS1My?=
 =?utf-8?B?U0tpYnZsMXhCOHQxb0x5UFNJekM5YXpJRGlFTGRuNDhpeFhBMnlKY1Bra0l2?=
 =?utf-8?B?RXdkNHlGd0hZV0xaRUZpUEc2LzdScWprN1l5SmZrVWREblQ1UHc1VERzTVhS?=
 =?utf-8?B?bXBHREVGTkNydWRJeW1lcGtHOFM2ZnUrc284NVRtRytvK2UrcGhXT21XQ05Z?=
 =?utf-8?B?TG1kL1pmVUJXMFRETW9na0xmR1NtUERVcTRiUFZwc0ZzdkRwa1hNWTUwM0ts?=
 =?utf-8?B?NEN4OHpIU3hydXRSZDAzN0JOZzRVd29zRFg0UWxINDhocHR4TkFIeGRCSEhR?=
 =?utf-8?B?V2YvblZOeVFtL0ZtdDNoYXlVcmR1NkcySXluME9xdEYxbEZPMmhrUUp0azdZ?=
 =?utf-8?B?Tkk0Zlk4aFpmbm5INVcyVmJ6c2xNU1JqY0V0YWY3bHZmRnhzSllJV3BIUSt3?=
 =?utf-8?B?SXhhOVVsR0cyTGN4M1RzcGh0dFJHby9qMk16VXVpQkxsc2VNTTJYM1p1VTM1?=
 =?utf-8?B?OTBUK0l5eGdmQU0zcFVFZnNvNmpwNitRb1ZsUzcxTjRldGJQeStqS3c2TUIx?=
 =?utf-8?B?bGVURGxpcHdHYmppN25pTjh2T3JJWWUzbzhTS1dobVJWU0NlRCtnMnN6bGpi?=
 =?utf-8?B?ODNpWW0zZHpVdi9xdWFjNFJVZ2xCR211bGFrNFlJM1EyeDBhbGl6UG51QjhM?=
 =?utf-8?B?c1pNVWpMaXpUdHBMejNmRkJ5MVpmVEk5YjRRNGVCNkU5by9HdGQ0ckZtSUx2?=
 =?utf-8?B?cUYrQmNkQUVxK29qV2JGNzB3WmdyOWRkMUVVUnM5VUpLVzBHMU8rQ0pDcFhQ?=
 =?utf-8?B?d0h0aFEvZjVmNnk0ZU9yeGJySGZXRjRRWlFwZEFXQysxYVRCMDVJekVaMldO?=
 =?utf-8?B?SHlBL3JSUXo1VXN1K0E1MjROT2FqNDJLOXFjNDk1Ym10Qk5wbE10MWtGcSt5?=
 =?utf-8?B?VW1IdWxvY2lvS1ZhRDEzMDcxYlN1VGdBVEdKRUdmVXpjdy9Gc3YwMmE5REUx?=
 =?utf-8?B?eVI1emJ2azVScHBrUVJhdFBxa0Y5c09CWHQ4NFZGQmJ3YkR1eVQwNU1KNU85?=
 =?utf-8?B?bkNJRHVQZ3RBdUpZZlJvbjBuSlVxQzZBWlNBWGF1M3V2VG1jU3Y2bjJLVFRS?=
 =?utf-8?B?WHBrWEtRZnFDbUpUSHJPaEFvUEdwaGNqendQS254R1V2ZnJLMm5CWU5iOEpO?=
 =?utf-8?B?bTF5Y2FjZk14OWVMdXI2MmozQWZ4R0czRWYrOC9Bb00wbFNMaStmR1pzVkVq?=
 =?utf-8?B?MXczRnJxdWNKYkFhQnJYTm5UbHdzWjdGQ25RdUZPMU1JOFloUmNDT01NdVFv?=
 =?utf-8?B?WlIraVYxSDFNV1ZZUVNIRUUzK01PV21BZ1JJR0dYSUpLZ3VUalFqUWJNQ3VG?=
 =?utf-8?B?czFmNXJqQUNybUMxMlk1UEtrM2w3NXN1cm84T3FPQ2U3RE5DUEtOWk83S3RL?=
 =?utf-8?B?ZEVSc1lvUzU1V0IvODREUkllTWpPeE5zWnhtVTBXRzlVNktQZmVxU2hUUzZk?=
 =?utf-8?B?cm9nejBhUVUxM0ppUkQ4WXEyVDgxbnd5YkozSldETUFrNUM2NzVBUHoxSDRJ?=
 =?utf-8?Q?NEm/y6YaGsA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkJXMnJhWTlhMUc3ejkrdmptR1pwWWdZbWppb2FBdXhOQnlDMGpWcEthZFJr?=
 =?utf-8?B?WnFMRWRWckZ1aU53SlV1WmJUMk9wcklvUWFJVHRERld0dTVkazc5SkZWR0pw?=
 =?utf-8?B?OENNdGQrUjY4OVpmcTFNdmhYQk44T1Bmd2plaFh4Nm8rZkh3YTlrUFhXMnNT?=
 =?utf-8?B?aE8wNmNyQmxkcGFYQzRpMCtDL3B2UVJBUVQxNWM0dlVDaEhVSGZQR1JGU0ly?=
 =?utf-8?B?NmVBeU9FTDlFdW0wZmdCUHBoOEh4Ukx0bFV0WWpKTjFheHd5SGNJVnhHODBE?=
 =?utf-8?B?d1VTb1g2OXQvdTZFdHZWOUdFelZNTHoxd3NZMlFGWksySWxFQVVYb1h3VzVz?=
 =?utf-8?B?VXRWRmwyOE10bjNCSUpMSXc2WExJeEt4QXg0VWVVM2JNSS9VSkpPeVMxZHNE?=
 =?utf-8?B?Y1RrMmRUb1dRMVJ6QnRvNWpZZU5CUGRwWTZ6TERKczZHQlo2ZHdKcFliazlo?=
 =?utf-8?B?Rk5MZXFiL215SHczbVZPZjRsTjUyemJQUVZZZkF5bWprMXVlZ2pCZmVDdlYv?=
 =?utf-8?B?UC9EVTdWRU9zRnVMRFZDYktzSVNyT296VXBpd1NMWHV0SUcwd2NUQ1VxSkhL?=
 =?utf-8?B?emQ4YjNCandac0Exd3ovajFYdlNzSE1MQ21Cb0c2dmFpM2swaU93a2JXTFA1?=
 =?utf-8?B?V1lhY3Yza0trOUd3OTdoT0pCQ255b2h2WHdEUXBKUVdacEhHSkg3ZmlRdDFH?=
 =?utf-8?B?VW1GbDd3aTIyQkFyK3BNdEo3STEyMWcvSW9LaDV4cVEwKythMmZJdi9RWjkr?=
 =?utf-8?B?QXR6QjU3OUhrbWxqcGcxcm1Md25zaDczekpYUFRCSFIyd09OUHRBS1Q0ZFBG?=
 =?utf-8?B?SHJWSWNVc04rSUgxK3RHQW8xNzlmM2RwTWpNSTJxaXVrQTJ3ZFgyRlNoV0hW?=
 =?utf-8?B?WDdtYWhDNUY4Z3g3YlVoWjdwUmNBRk1TaHRyZDlxUzRSV0JwQTVLRGRSWGZu?=
 =?utf-8?B?ejY5S2ZBTUFlVXNGc3RkZWV4R3Z4bDhXUjZnTnRkejUxdmt4TFU4OWN5R0xD?=
 =?utf-8?B?Vzk3MUlpQTk5aEFTZGJacmw4MnI0bHJpZUhvMzRLS1JKbDErOTUya2xpdXJo?=
 =?utf-8?B?ckZXelFqdnJhZk0wZjRtT1haN0d5VjU1a1ZLQTg3WjJwR3M4NmFMU250NzRn?=
 =?utf-8?B?MkJVMzd1UHJPNy9CTmEvQTdYMHN0Sm1PWXZJNC9GemI5akFGdWpTRndIcmNK?=
 =?utf-8?B?U3pwUGt3RWFWVkNPWHRtZWloTHc3NWtXalFZZ0VLU3FIcC9CSFZtL2F0ek1q?=
 =?utf-8?B?SG1kQjNwZ3pnTTFjbVBybXRvTm0zUlFCTkhGMjJwenJmaG84TUM0SU5aZGN6?=
 =?utf-8?B?RzU4elNkVjM4RWtMWUxsUnQ4c0dBN2FqMUVYWkNNOWR6MUhMdk85b1pZR294?=
 =?utf-8?B?Z2QwYkxXSm1lRm1mdEcyemc0dWF0MVBkSjRHbUJySVNPc3dsdHVPSWlnVlBn?=
 =?utf-8?B?aWozMGw3TUxvRjJvOXJOU3lhcktOVm5aaGpGMGVDUm1kdGowSHh2c05ma1Fr?=
 =?utf-8?B?dFVVSFlwVFlqMW13QkdHTzlFSXh6a3IyajRRWUk2Vmc0R2VyQXdLQ3V4L3Vw?=
 =?utf-8?B?OXM0M0htdTdhSVppRm1teWVHbTFmVjB3NWRaenp4dTZBODlUMmxmMGJTUWpu?=
 =?utf-8?B?VHJPajJ1MHBBSzVrSVlmMDVvcmN3eVBJNWk4YjE4UzVHWWxtaDUzbjArdDFP?=
 =?utf-8?B?MndHNjhFL3RsVm92SDF3SGhueHpFeFNkZktTWVVUNUxIYmhyeVduaFpZRGJT?=
 =?utf-8?B?SEw5RkxSc0E3bklkcG5ESktpNFViaC8zcW1RTVZaTDR4b0lnVi8vVVFpNU8x?=
 =?utf-8?B?WmRmZWpZQ2NVcFpTdis4Y3RZT25yWm5jdVd4bHdrYjlwYmZNamdLM1dEZmxz?=
 =?utf-8?B?bGwvNUNVa2N4NXFHWVZwUG9odzU4RGpxbWQ5Tnh3MHR4cXNPdjN4MzF2cm0x?=
 =?utf-8?B?ZmNqZnc0OG43N2F1NmtiU0JiRVVOVmxjemtuREo2V2h2TmVKS01RcExMbUQ2?=
 =?utf-8?B?ejVtTytHMmdGNEdORmg0QnlGbVA4eXBsdlNSZW12QjdXMXZOTTk5S2NwMVR1?=
 =?utf-8?B?T3ZEN1dnTDJ5YzhLSVJ6Sy9PNnZiTncrNkJYY3dteExWanU2SGJxRnFwd2t3?=
 =?utf-8?B?UEFZVWtQbVBRSlpQbTdVV0JZWHpXWXF1VWdxd3c2YWZxNkY0VzFDVGVNajZy?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 772a4863-0925-4fd0-1021-08ddc45e2fac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:44:56.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgI7HAsT4DalGxxIgA/JmQsfpZxRfP8w5E+LZVZDMVH7074PZ6xuMt07gGclCT/fvZBhR+MsH7RE5eb13g2JEDYcFJdqtVA5k/9dKVgqe3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9449
X-OriginatorOrg: intel.com

From: Christoph Paasch <cpaasch@openai.com>
Date: Mon, 14 Jul 2025 15:22:34 -0700

> On Mon, Jul 14, 2025 at 7:23 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Christoph Paasch Via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
>> Date: Sun, 13 Jul 2025 16:33:07 -0700
>>
>>> From: Christoph Paasch <cpaasch@openai.com>
>>>
>>> mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
>>> bytes from the page-pool to the skb's linear part. Those 256 bytes
>>> include part of the payload.
>>>
>>> When attempting to do GRO in skb_gro_receive, if headlen > data_offset
>>> (and skb->head_frag is not set), we end up aggregating packets in the
>>
>> How did you end up with ->head_frag not set? IIRC mlx5 uses
>> napi_build_skb(), which explicitly sets ->head_frag to true.
>> It should be false only for kmalloced linear parts.
> 
> This particular code-path calls napi_alloc_skb() which ends up calling
> __alloc_skb() and won't set head_frag to 1.

Hmmm. I haven't looked deep into mlx5 HW GRO internals, but
napi_alloc_skb() falls back to __alloc_skb() only in certain cases; in
most common cases, it should go "the Eric route" with allocating a small
frag for its payload.

[...]

>> (the above was correct for 2020 when I last time played with router
>>  drivers, but I hope nothing's been broken since then)
> 
> Yes, as you correctly point out, it is all about avoiding to copy any
> payload to have fast GRO.
> 
> I can give it a shot of just copying eth_hlen. And see what perf I
> get. You are probably right that it won't matter much. I just thought
> that as I have the bits in the cqe that give me some hints on what
> headers are present, I can just be slightly more efficient.

Yeah it just depends on the results. On some setups and workloads, just
copying ETH_HLEN might perform better than trying to calculate the
precise payload offset (but not always).
If you really want precise numbers, then eth_get_headlen() would do that
for you, but it introduces overhead related to Flow Dissector, so again,
only test comparison will show you.

> 
> Thanks,
> Christoph
> 
>>
>>> +
>>>       if (prog) {
>>>               /* area for bpf_xdp_[store|load]_bytes */
>>>               net_prefetchw(netmem_address(frag_page->netmem) + frag_offset);
>>
>> Thanks,
>> Olek

Thanks,
Olek

