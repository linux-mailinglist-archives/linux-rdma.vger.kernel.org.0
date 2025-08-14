Return-Path: <linux-rdma+bounces-12751-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21522B261A7
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 11:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C769E248C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 09:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D942F83C0;
	Thu, 14 Aug 2025 09:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSm9x8L9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630522EB5AC;
	Thu, 14 Aug 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165316; cv=fail; b=IGKKCr8+Pv9srOJyA7I1mvRHO234xOg7ZvGDXV2K/YMqSWS/x+smV0azlna/tjt64EQW0+TVmhvzprC72SizLBDyE+A5WNOI7qn8e1sAqYs2YcJD7B4+wbjmlEf3FeNxIfa7vM7a3Du+IOmYGxO0LIYuJQen0Teo4Sokgo35C/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165316; c=relaxed/simple;
	bh=k+NmIXg6VC2TdVlKEwmdPlj1VTiaFo3/eHqxS5g1CQc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xi7wSRlyvZh1YemgqNsCJfZuy53uhs2ZrBVMTznGLXCu3of55SC/hOxQf7Zpjrt8qT37+4sqP10RDJ2qF+UPH+fK4+p+G/QINeXlFvUOr7a+PM4jJNKJKwp7t49Xn8Sou6HyNmK+ciuroy4mOSadeWofk/mhzKq3/NCXdKxxQjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSm9x8L9; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755165314; x=1786701314;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k+NmIXg6VC2TdVlKEwmdPlj1VTiaFo3/eHqxS5g1CQc=;
  b=XSm9x8L9hn1+UDYbZiik3romVtFj0Za4AoSs7Za7YWp2Pv8fpaErVw5A
   za4kWdAswVGIDkp8b9EGl4g2cEzK+umxYcKqodAjxVPwWr6H1SNeZvlS2
   NQ9yDdWvHS/X5DS5nPZyPmBta2kbu03mULhNyqWt0B79ZJ03KxkqM/fpG
   VXzwTRUXyuJRmFqQaZTsjQOi45MLwGeSWBFF3KcOctvezxB72WBLo/SPz
   AcjRWZ+JwSMp2mcoy5wEm1mf8PdFgVqI7QVIQreDjYh3rHCeGxYKHTEzO
   NOkcGKVC4hqq7neXadvzWaKAe2i8cQyCMrji4eIgzntnKLK2NBkTt0jrS
   A==;
X-CSE-ConnectionGUID: 9lFBJEzMQ2yGlDIx9S5N+g==
X-CSE-MsgGUID: 0Lj8T3KfQA2SBsgsM6HIpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="80053255"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="80053255"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 02:55:13 -0700
X-CSE-ConnectionGUID: Dw+3nrqKSceJNCdNYu7U7g==
X-CSE-MsgGUID: ktfVwPrHQamFTLb1zNnt3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="197713485"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 02:55:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 02:55:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 02:55:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 02:55:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAMeu7akRoyy1YqRvCjikBH2N6ywWj6Nxlm42wRWEb+KAVdZN3db6d5N0NOiKa8Iqs+AOthc4Lgsp0B13qYD5iMlmzlhNApyWNaQtd9cqipkcptcGMAY9Do5bwfn9VHvvt+U13pdkSiKTQ5/NzQyAg//QTtaD5qb6x4tykq26PHL0hYxAvytFoArSPdgipvhEREdU3NTLKp51K/QMUxUpO/I3J+SRva9DR4JdJVeXnbk8erk9gr7TRnQjrQt5skgFcQqkaPGnU7RF1Uidn52F1wTdm54PMCwHLk9W2j/gSwCA3//5/JfHka/awdRKesK5jEGE+qxCFq/2afVxa0ZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Blm0kKeZmFBWPN7TxnWXw3Mb4YL0Z3Tuez3OTW0X3qc=;
 b=mM9ZnEdmvFv0RyKDwo4ypIMfIoEjiuI2wANCYQJJELt1l2l77WUFD8wfRe5OmLoxWFlGhR1dnyNvk2LcRZCg7WaOpnNorOBZ3S0IVM46oaULFKbYkKsIQ5YOheiDo4xYJzNhKGVp1lynWBIAJVShTJdX6x/7iuG2ocAOM9oabFfnwOPxQvfMAMerEZ8S3vU30DZIBjL3Amd403zZwOfZXana+abdhhcDaWQUL3k8OJwZNXvBBMIC0Shzx0ok4Dg/BgDqhHbS8sIO4kwC5zMnjuDaj5usE52R5yspL/83jQ3I1/KNa4z1ORcyYtGDvoqqvQRP91SviifgcS8ZKq3Uig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM3PPF7468F7991.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Thu, 14 Aug
 2025 09:55:11 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 09:55:10 +0000
Message-ID: <51908ab2-6184-405a-b723-8b030267e7c1@intel.com>
Date: Thu, 14 Aug 2025 11:55:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/6] net/mlx5: Destroy vport QoS element when no
 configuration remains
To: Tariq Toukan <tariqt@nvidia.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
References: <1755095476-414026-1-git-send-email-tariqt@nvidia.com>
 <1755095476-414026-5-git-send-email-tariqt@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <1755095476-414026-5-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::14) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM3PPF7468F7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 6974164e-52d7-477f-7781-08dddb18a86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUhCOUJuLzU5dUFCTWpUd2VyNnh5bEt0TkNHeHFNUmNtRi9pK2RXTkNwMk5t?=
 =?utf-8?B?Q0JxRWlSV244REgrVTlTM1BkNVhDRXZPTks5VTg3VVh2S0dxRnh3UitXSTk2?=
 =?utf-8?B?V1lLd2pPYnJDejRiUTRCWElqdTRBdzcvdVVZbVNvUXpIN1J2M0VrdFA3dUVj?=
 =?utf-8?B?WHhFaVVUS0xtdThZUmR4VHZHKys3amd3SVJJaUZWTEJMSXhqbWUwZ1Y5MGJy?=
 =?utf-8?B?dkR0bzZBQmVhOWExTG1YQUgwbnNMK2xaOUE1K1FPNko4MExpUTZvb05Nb2dX?=
 =?utf-8?B?S3o5STJTY2FaTHVKbUdmWmw1RHIxbmVrM3NjZGNSN2NDOUdWL2hpeVRlVGh4?=
 =?utf-8?B?Q2xzZkwvQnlBbWZHS2dqdnlpbmd0OERobHg5TXU2RzRIYjlIMnF4aHZUMFlN?=
 =?utf-8?B?ZkF1UFAyWEVEcUtlR2JpbzF0WkNUZnVpUGJNNTZHdjl4dFEvb1cyZVNLYnYx?=
 =?utf-8?B?cEhjRnVlenk2U0xiTW1GVzNHajBMbExXbHZuZ3ZWR2RsSy9xdEJBWTZtY1c0?=
 =?utf-8?B?VUZQWFpWN2dYMVpoYXI2cnB0c3J0ZTlVTW1Rc09EcHlTbEhKNjZHay9VZ2ZF?=
 =?utf-8?B?Nm81U2pEQ1gvdnNIYTJnQnNJeEdXVmpaZWd2cUZTd0dRMVRRakdnaTJkVWM4?=
 =?utf-8?B?UFQ4aXRjcnpPOERlNkdrMkNMVmt6K0t0Nm9OaWhIMFlCNzYvU25HaEtjZkhP?=
 =?utf-8?B?bzMzbnpBNGdQMTRsMmFLTk9PZDY0Tzl1S2tyMHdSalFQcHNrREFNZVRMcjll?=
 =?utf-8?B?SFZjTndXelJMRXZnZHdFWkhBazJUZEt1aHB0ek9taW50QkljMUpqR0Vwbldi?=
 =?utf-8?B?KzAzSnIrbHM2SDBUeUpRRlJIeDJKZXlNRlQ2V2dNZlVRNXNhaHRYN3hKYVVR?=
 =?utf-8?B?S1lOdUNZcy9FWGN1NERsVWlvL3ZwYStCL21Wb2tYUDJOUUVoQ2NWdlVvcEQ1?=
 =?utf-8?B?VGZNd09zcTNMNWF6VlNBb3VYa0x1VStLblA1YWdhMVVqa2Y3U01pMnFiUHBq?=
 =?utf-8?B?TWIyYUgwNjJvbFZzMWEwL21jWVJKS3ZlSEI5eGZLbTNXK1lWTGVLV1NHdng1?=
 =?utf-8?B?TnN1ZHhuazZOa0Vra2J6RUVLRytSa05RVUNXOGFnV1RxMm4zM1Exb01OWmtq?=
 =?utf-8?B?djhiYnk4U2NiUkwwRWVadE54NDh0OUk2Q01ybTFJRjRESXZYYXRXTkNyTUh4?=
 =?utf-8?B?ZjhCM1lTVnExYUo0YzlQaU96NTVoMXJxckxkakM5Y0tndy9qd1RHbFlFZXNy?=
 =?utf-8?B?WmU1MzNkOUlvSlkwVVNoSFFrNTNVc2h5SlZIQUhyN0ZsT3g2M2FZMk1xL1V2?=
 =?utf-8?B?SkhYQlZrQzlwT3hLSlFKcFkxVzFtbi9VT2VBd0FINllHWXN4cjFIUFhyQWc5?=
 =?utf-8?B?ZnIyVW1BMWkwVGZGZlAwWHFWenM2MllRRmNnUjRxMUNMT1N2ZnE5Q3cyRk9K?=
 =?utf-8?B?ZW5hT3VqRWdLQnI0Wmk5UEdGeEhuVDVvWHpHS2FPQitDdFZhekhNRDJGKzdM?=
 =?utf-8?B?dFordHAvWWpUcmJzSEhaRnFZVjFFa05OckFtRUF4ZHVsWUozWkJ4WFJOOXp3?=
 =?utf-8?B?VWkyd3A0c3loTzdYSHJNRDkybXYxdG5BTS9xTEpkY1h2Qjc3b3d5Q3RpNmNN?=
 =?utf-8?B?UVQ2UWFtK2dQdlNhV1NHQUlpQ1l1YVI2aWV5aU55Tk1QT2dmZFY3bHdLT2ho?=
 =?utf-8?B?ZjhuT2RwVnNXdkgvNDVrbGRqRG93YWJnWGtqZE1KcjlmaDRMYnBRZXhuSUs3?=
 =?utf-8?B?QXdWMzhJQnQ2cUpMUnJPMUxFV2pVSmRBNFR6YkJSazRHSExidUZKQmptNlNP?=
 =?utf-8?B?RlE5UlFVVHhMWlBJNGl6b2h6Sis3aTVCNlNTeXRpNEVINnJpZ0ErZVRZRkI1?=
 =?utf-8?B?cndyQmw2K1crUWxJY0FHcmdYY1phVVVBSExaQkJ0aDNqVldieVU1cDBOT2Vv?=
 =?utf-8?Q?9okUVsYCfiQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak1hTXRJZVdBOHVYT3B5MUdQc3ZDUTlwcXA5NnpEOHZhaTM1dnhoTWNJaXBY?=
 =?utf-8?B?c3RjeXRDd0R6V2l4YnFqRjYxMnZraWJlbmo4UzlNUXk1LzhacThvcW5NV1lp?=
 =?utf-8?B?R1RnWW11UUV2WDV0Ym9zdGkydXFEL281bkJ1SWVpQ0lCZGVOL21rOFBDS05l?=
 =?utf-8?B?SExCSHdTdXZVV0t5RXRjQndrMG9MY1hSRmx2SFJManhCQ2d6dG5mR1NObzRI?=
 =?utf-8?B?ekZ5WStCZkZlcFdtZS9zb0dyWFdEaEp4b2JmZGZhRmhoN2NqOTQ2bEtpRkZT?=
 =?utf-8?B?bkg5QzUvZ2t0aDJUeXJGRkRCQzVhZGk4eGh4V3JUZkxvc0tNL1BES25qMTlL?=
 =?utf-8?B?eHN3VFFuZE1GRWRRdTh6QlVrWSs0L0QxUVQvSHp5VEZFV1JIU0JVWjh4UHFk?=
 =?utf-8?B?V2t4SG1jWS9mMm9ERzkvMkoyVm9hSjNKcFQvTk4zODVnMXFMOWlqQ1I2Rklv?=
 =?utf-8?B?RVRHZXJhS3RocTZ4eDJIL0s3VUh1Z3VORWpveGdnaGQzbFhmWEpYN1kzVWVz?=
 =?utf-8?B?YitSdW1YL0duQzU4dnJIMjIzV01TUHRXNTh6ZHBUbXQ3TitDai85a3Z4RTEz?=
 =?utf-8?B?L1pDK3BqMjNFVEVGYnNrbUVVTGduU2pKbjEyOUVSRXAxeFN6TWNLNFcyVFp4?=
 =?utf-8?B?eHpWdjNiNURERVNIK05VZ21sc29kRHQ1WDJjRHdFbk1LbXViYUJHZnNkUnFH?=
 =?utf-8?B?Ylo0ZjVwQlVKQ2piRCtNZlZZQTlmZkdoNXVnSkJwQkttMnRTR2F2V05jSkx4?=
 =?utf-8?B?OTlRNEVQaHpxamljQXlqMTZwUU95d2pRdENQajJkVjVnckNsOWdTQVlINFYv?=
 =?utf-8?B?WWtRZjk2cjBwTXp5MkFLdTRYZnVKSHpvUDBlUHEvUnZOZU1ndWtrS1BJTnhp?=
 =?utf-8?B?TTNkUC8rY3VzekhLWHJUR0FxTXhJbEJma3N1K1lhYzEzaDRYcGJ3MFJ5bDVl?=
 =?utf-8?B?RGtSTjZGb0V4RXcrQzlDT1U1NEFsYUNCVzRoYzAxTXpkS1RISGRZTWhRdms5?=
 =?utf-8?B?Wlo5U3JRRHJlcUw3am40dHIvZUdVT0pVM1dqbTRPZkpEL3RETExLRDZwWnJD?=
 =?utf-8?B?UkkvWi9WejJUSllSSFJhSUthMW9wR3lKUU51TVZ3RFhMbUZscStxNzNKNTk3?=
 =?utf-8?B?ZGtueWVBMVFlRFYwS2k0VkNXNkVRcW5oU0NiMFlOY3FHUFQydzBPSFo0TytP?=
 =?utf-8?B?SlZ1emdCU0dFSjVUWlJpaXVEa2wrYk93TVN3OFhjbzRsSG0vcnVlRTkyQTJK?=
 =?utf-8?B?NXl5cjV4dm5TSS91QWZxaGVybjJBWU9jL0ZiRGRBQ2RKYWNTRHR1ZXdTZm16?=
 =?utf-8?B?aVZSMEQ5WHQ2ZmlFRkUreng5T0E2eTc5bkNpZHc3VVJQSUZTZjJyZllyelFo?=
 =?utf-8?B?RDI1YVlESXNEd2VFY29pUEoyaXNveUQyNytWUmJyM2owSUtBWGZlbm9UNm5p?=
 =?utf-8?B?aUk5WXNmeWtBaHN2T3J0Z1Y0aHJuREwwbEgzR24yRTdYbUVtT2s1dG5XTEQr?=
 =?utf-8?B?ZzNBZ0NaQ3M2ck8wS0kwZVpNZFRvNEZvZmY3eE02UzN4bGNjeEVUYVNGM3Ur?=
 =?utf-8?B?aTFWQVk1WS9yczhqMVRZSURqSWJwcEg2ZmVWZnEwcVovOWZ3SW83cllPWW5J?=
 =?utf-8?B?cysxNE1VS08xaDBwaDdWZDcxK3ZsWGdqREdvbnFtNVd2T0lDWUtFTS83WHQz?=
 =?utf-8?B?QUpLbkVtTEVjMEdzMU1zTUNadEtqcHpGWEx0ZCtBOWtPcy9yY3o3UmoyczBC?=
 =?utf-8?B?a2xINW5MTDhZZmtLVGZCeFNDYVpjRGdQZGt0NUU3QWtJeVA2Q0JqOUFaVkVK?=
 =?utf-8?B?Y3FaVnlFNXRvaUpDMHdybW45a3JpOHQxVlc5eXpnc0ZkNk1Dam8raVlUNS92?=
 =?utf-8?B?anFLQmh1dFdiQUg4cUptT0ltV0RLT2o2c1AySXA1UGRzUmM1MFZXYWxFTnBa?=
 =?utf-8?B?YXc5VnZZeUFTcnE4TkVYYVBhV0VPYmxPZzN4U1d5VCtsVmVXdnN5MDRqT0ZK?=
 =?utf-8?B?aEc0S2pQRU1UckdYNDhKVnBYemNleVZ4L094aS9Yd0NFWnJWZU5yWHZrQ2o0?=
 =?utf-8?B?bkl3Yy9XRGVxVklFWTE3Y05zTzFpSnhpajhVaUgralVGY1c1UTVjdkNVUnRB?=
 =?utf-8?B?RkNmd1lUZ3lEdmhwbUNjNStIbklVeFU0MEw1UE84TXE4ZFduem9aZk5DNUY5?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6974164e-52d7-477f-7781-08dddb18a86d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 09:55:10.8835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20a8J8kD6oJMYi2/Ns0TW/3ouO3ifV1Wvz9esS+fDw5Yvoi+eGsGDz9NjU3XYZDneFIQM62bBQ8ZiiSWIFYZu+OPZFJIaGGGl4HuJx3noUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7468F7991
X-OriginatorOrg: intel.com

On 8/13/25 16:31, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> If a VF has been configured and the user later clears all QoS settings,
> the vport element remains in the firmware QoS tree. This leads to
> inconsistent behavior compared to VFs that were never configured, since
> the FW assumes that unconfigured VFs are outside the QoS hierarchy.
> As a result, the bandwidth share across VFs may differ, even though
> none of them appear to have any configuration.
> 
> Align the driver behavior with the FW expectation by destroying the
> vport QoS element when all configurations are removed.
> 
> Fixes: c9497c98901c ("net/mlx5: Add support for setting VF min rate")
> Fixes: cf7e73770d1b ("net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 54 +++++++++++++++++--
>   1 file changed, 51 insertions(+), 3 deletions(-)


> +static bool esw_vport_qos_check_and_disable(struct mlx5_vport *vport,
> +					    struct devlink_rate *parent,
> +					    u64 tx_max, u64 tx_share,
> +					    u32 *tc_bw)
> +{
> +	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
> +
> +	if (parent || tx_max || tx_share || !esw_qos_tc_bw_disabled(tc_bw))
> +		return false;
> +
> +	esw_qos_lock(esw);
> +	mlx5_esw_qos_vport_disable_locked(vport);
> +	esw_qos_unlock(esw);
> +
> +	return true;
> +}
> +
>   int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
>   {
>   	if (esw->qos.domain)
> @@ -1703,6 +1731,11 @@ int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void
>   	if (!mlx5_esw_allowed(esw))
>   		return -EPERM;
>   
> +	if (esw_vport_qos_check_and_disable(vport, rate_leaf->parent,
> +					    rate_leaf->tx_max, tx_share,
> +					    rate_leaf->tc_bw))
> +		return 0;
> +

I would rather keep executing the code that "sets tx_share to 0 and
propagates the info", and only then prune all-0 nodes.
Same for other params (tx_max, ...)

That would be less risky and more future-proof, and also would let your
check&disable function to take less params.

Finally, the name is poor, what about:?
	esw_vport_qos_prune_empty(vport, rate_leaf);
(after applying my prev suggestion the above line will be at the
bottom of function).

Also a note, that if you apply the above, it would be also good to
keep the "esw_qos_lock() just once" (as it is now)

>   	err = esw_qos_devlink_rate_to_mbps(vport->dev, "tx_share", &tx_share, extack);
>   	if (err)
>   		return err;
> @@ -1724,6 +1757,11 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
>   	if (!mlx5_esw_allowed(esw))
>   		return -EPERM;
>   
> +	if (esw_vport_qos_check_and_disable(vport, rate_leaf->parent, tx_max,
> +					    rate_leaf->tx_share,
> +					    rate_leaf->tc_bw))
> +		return 0;
> +
>   	err = esw_qos_devlink_rate_to_mbps(vport->dev, "tx_max", &tx_max, extack);
>   	if (err)
>   		return err;
> @@ -1749,6 +1787,11 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
>   	if (!mlx5_esw_allowed(esw))
>   		return -EPERM;
>   
> +	if (esw_vport_qos_check_and_disable(vport, rate_leaf->parent,
> +					    rate_leaf->tx_max,
> +					    rate_leaf->tx_share, tc_bw))
> +		return 0;
> +
>   	disable = esw_qos_tc_bw_disabled(tc_bw);
>   	esw_qos_lock(esw);
>   
> @@ -1930,6 +1973,11 @@ int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
>   	struct mlx5_esw_sched_node *node;
>   	struct mlx5_vport *vport = priv;
>   
> +	if (esw_vport_qos_check_and_disable(vport, parent, devlink_rate->tx_max,
> +					    devlink_rate->tx_share,
> +					    devlink_rate->tc_bw))
> +		return 0;
> +
>   	if (!parent)
>   		return mlx5_esw_qos_vport_update_parent(vport, NULL, extack);
>   


