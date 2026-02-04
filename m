Return-Path: <linux-rdma+bounces-16553-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEoDK8nOg2kFugMAu9opvQ
	(envelope-from <linux-rdma+bounces-16553-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 23:57:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E00ED220
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 23:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1697D3013865
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 22:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AA039902A;
	Wed,  4 Feb 2026 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpepKXUC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD62F25EB;
	Wed,  4 Feb 2026 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245830; cv=fail; b=C2Uj3gPjifC8XS6RklL2l/DeSG3xt18eLclZbOwCAZg9jefkGb3uRChIvsA6kKcJsDVv9+O8o6FM0nN0WIlN8QxS8QO1iwZGOyIU/IoNYWIfeM7HKXrfGpYYAP84vZy8v+7C7lrZeLp4RQ2Vyhiw43JIrcXQtstBaREYY6bu4QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245830; c=relaxed/simple;
	bh=/9GXltYuhmyDeEVloyToggrqFrR+a1/Kf1/26XtMzD4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F0YYoNsBMuB+0sao+PlgjcV6omIPGriALfpktL2iQ/KsorIGVsHZrXFTiq/xzwY2EVDHIlWW/6Hg+mjFZdz795P+w4qo3juNrOWCsg3d0Wdrup8RKC5LXs/33M2IyRM+hAnSiR+9fAwkhgYHKYptkisuySTsQgI7sJ0LWfdfjpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpepKXUC; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770245829; x=1801781829;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/9GXltYuhmyDeEVloyToggrqFrR+a1/Kf1/26XtMzD4=;
  b=hpepKXUCn1ON59cSo4ASHfLgsgxyqFjqnGxYbRwk613qiKXM8QZ3hiG+
   gKVN3ha7hBwqrszE235oExIPHeyCHcINE8XlGuO3imYK4pQaNX3efY6ES
   KD0RVfbQ3UTmCvCAbt9R3B86F0kO04KLArDpAOazTtyt5nLY7o9rxVwa3
   oVToVYd2rUZrrc6vPYIOH/OHRRi+Q93/fEkmCdjNQ5zb3YZqhYnjrufdH
   M6T94lVM0Ydz1Prnb/LGIQSqFQQCsblMxdmvDwe/WTzy0aO9p5YpEbK3V
   3UR2SRsREmOkg0bu0i/hKE/8ujaLQzEwp6eqb2gA2W/usYhdqMQ/jXItP
   g==;
X-CSE-ConnectionGUID: GA9SjdikTtyHEBNgkDqV3w==
X-CSE-MsgGUID: YavAczadSqysBGi+qmOeGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96897860"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="96897860"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 14:57:08 -0800
X-CSE-ConnectionGUID: /iz9lsj8SbmKd2Ns9GZ2lw==
X-CSE-MsgGUID: H36L/kDiTk+O1R/jWYrrJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="214795229"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 14:57:08 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 14:57:07 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 14:57:07 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 14:57:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9zQWX2ghWh23zQ6BCu8F8tdf2TWOQhjHJgZkg7iUYXLF/QIcLFxFVMMgWmjEwcMc8au1jXMQ8XY4YFkQim+cpVjqQ/9CPGXtXNFxlQYb5ccRn8wPWotWbZ0j90re1albsFHQ/NAEqSkhUMtrCAk9F8lAFJHoB+uTI8fSgIGJaFXamZlvuGmTRRJDpZM4guYaPAvWJbXZPRZCCf1AVX3OqUlNfaqsD1ozz9igXB7WOFuuZnHX8FxlSQPyftwYi9G3mBsfStK0z3/1a1bGHmOaFzkmBPLTtB377PLN3HP6ie1Y7ex6L42Skr+FVriUu+x8kCqnAr0gkydGytZALtGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/0rlhO660jHmWE7hHpnfIUDFp5zkHaErYoR7tjUI2A=;
 b=nurb4ZXiN3FF/GUA+twDbE0FLhDl695+Qqv6/n76dTMn2+ngXN7kCwoc0rNjNNBQQ4yBfP29vCWmJJJ0BDZmXsx89EiRxT2rQzSvTIVO9vjeL2rWALRKfB60/wYnZ8iWo6f5FrOfYuzKb3/5LY7xmt9MCLtBf9tPU9TF74LmaytLUYAyT2T5FPbD5iTEV1TfoBToPW60Utpy8r723NicatKCXw7SarI0rJ07H3SwBg9IboaVMVXd2pbH+G63XYk15UymtkM7p74hFe7LuM5d7VKZVGteC33hA2nrCt6QosQ+0EidJN3tenqMoOAFCYAPtRIlJWaHTkMB4sPRxms5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 PH3PPF1BAF94C4A.namprd11.prod.outlook.com (2603:10b6:518:1::d0d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 22:57:05 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 22:57:05 +0000
Message-ID: <25a26f19-7f8b-40fc-8528-64ad61e9fe25@intel.com>
Date: Wed, 4 Feb 2026 14:57:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 2/2] net/mlx5e: SHAMPO, Improve allocation
 recovery
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
References: <20260203072130.1710255-1-tariqt@nvidia.com>
 <20260203072130.1710255-3-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260203072130.1710255-3-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:303:83::7) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|PH3PPF1BAF94C4A:EE_
X-MS-Office365-Filtering-Correlation-Id: ca803f6c-76f9-4fb0-c14a-08de6440b769
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFRVa040WU1YNnZscG9Za0liOFhCUmQ2QUZOb1NuekNyLzBzQ3VVbnEzUmEy?=
 =?utf-8?B?QUhxM0VmbEZMSGpMNDcvdlYrSHg2d21jTmU2eGNFRG0zdDVGV212dndPamlC?=
 =?utf-8?B?OGhWc0d5alVPWUFocjJraHp6SmtMNytiaEVKODZKVG5IbzBpdis5QVRhOXVr?=
 =?utf-8?B?dUc4bWxZRVpHeXVXSVgxUG9BU1RRamZvSyt2S3ZhRmxHR3FWV3JTSGsrNzM0?=
 =?utf-8?B?L2I5V1kxYmc5ZmFoM2lmSTVwRnhzN0tudFBkU0ZEN1VOTXlTWXhvZnVUeFll?=
 =?utf-8?B?NlZld0NHSkdlOUFPVWJoNkZMOEdWS3h3ejVqR3R1dnIrS0k1aVlQa2VMSXZS?=
 =?utf-8?B?U0pPZVNudXI5YS93TWJnRFJJeU5OaDU5YjhkT21EQlo0T1dIeEJwb09NZm5p?=
 =?utf-8?B?YVZhMjF4T0E4ZHo3Z2xoUWxvcVlWaDlTY3cvRHNRU1BHeHNNYkxKY0x1cTkx?=
 =?utf-8?B?WGdyMXFESVZGQ29seVBwaFNEajYvNTZoSTYvY1A0dWZINkpYMWZrVnVpYWxN?=
 =?utf-8?B?a0J4aXdINWtBT1Y5YnFFU3dUUzJsTmVDc2dQVWtXOTZWcEVoZlFsOEFUQm15?=
 =?utf-8?B?Sm0rZStqb0xZWGw3RktHcXFlQXVDSWVzemllcnVLVG5ScDVpb3BZc3BrZVhu?=
 =?utf-8?B?V2E1VXlaT2w5eVBPdytseWMyd3FyQmxNMXVBSmtiTkErVG1Od2xqS0F6QzNo?=
 =?utf-8?B?OGNsZ013SUcvVngvblQ3eGNoVlpyNDIreFQyUmd4YVpTN3ZZR2VLQ0Z0ZDdx?=
 =?utf-8?B?a0hoSnNxK1RHNU1UL0xIcG9PT3h1a2xkbVVWQnNKcTdsM1V1VHA1bFl6RTUy?=
 =?utf-8?B?MWZHWkloZndiU05EK0c5aFU3c3NpYkQ3alhRYXp1bzZ2WmV1UEZtZ3VOSzZr?=
 =?utf-8?B?S1N6bVQ0b2dQdVFCZmgzenFGUlBqUGxrbi9aaHBLMEdEbnVDeUs3b1VOWlFX?=
 =?utf-8?B?cC9EcUliUnZLaTloYVNuaEJLaEQvMmVaNUEyaldMU09HUmRpSFVwaGpqU3RP?=
 =?utf-8?B?dFlTT0UrRThaQWxQcjVMOEdGdFlMbXY3cU1QQitBaWJJNG43ajVaN2o1K3o2?=
 =?utf-8?B?V20rc1RNSXFORXVEMkVETFBaUzJpYU13blM5cGtybXQ4aVd5UXhkZW5xMjkx?=
 =?utf-8?B?SEVjc0RvZUhWanV2SUMvd0xPc1RjVjNBOXdYem5MVVJzVXJmNXVkMzlzZVEy?=
 =?utf-8?B?V3dydW5mWHRJSE5VajdqcUFwaFdiZ2JlNTBGT1RDazJpRmZ1M1Z0R1UvY3FS?=
 =?utf-8?B?K28wWGJBa21tbTZvMzZrWkQ0cTJrOGI3eVp5MlVHbWREekF3RTZacWRqSDVU?=
 =?utf-8?B?SXFmUmUxZS8wTmlnSEcvc3V3TmlsN2lxTUtvUzl0ZklTY1JKdDgyQVhRSHJw?=
 =?utf-8?B?SXVjQUZzeWZ5ZkRwc3doZTA5OHhDeUZUenI3dDlPclZ3cmdIS3l3NGNscjBO?=
 =?utf-8?B?S2pNb1p6U2JmeHdFNUZDR0lmS3hBOGU4d0Y3TVk3a1JLeUsvSWpFTHNFSXpJ?=
 =?utf-8?B?YzNzeUM4UmRRSFRMQzBJN1RpVk9ZMkJiNmpVQm4xMlJmY09GRDFwaG9MTnM3?=
 =?utf-8?B?ZDNRY2NrcTJ6TEpZa0c5cmdlZ1dzbnNsbmEvZ3lHSjhJczFKYlNvLytmSGoy?=
 =?utf-8?B?UWcyRDBkZ3J3M3RMMmlmWlVrczRmZUcwVytaRTdsRUxaOVpzTXRad1l5SUJX?=
 =?utf-8?B?RkJMV3JtZ1dNSFhZcDBsbytLUWpkV25XbThSNzB0QW8zYVVMbU5vOGp3SERs?=
 =?utf-8?B?eXNwYXdEdjRhVHpkbmIvTFV5YmQxdG9NK2FabkE5VEdVcXMyMGZCejNwZGlm?=
 =?utf-8?B?Y29FOGlDdFMrT0VqOStqRWFSVDNCQnZhOWxzeXJFOGFRdlZnZ3k1WEM0M1Rq?=
 =?utf-8?B?S3BwZS9XZ2FTTWc0MVYyQ0ltRmU3SmN0elFkUks4bGRsQ05sTXFhbENYOVB1?=
 =?utf-8?B?eFQvWmVCeUJUaFAyQTRHMkgzMFkzN3g3L1FGWTg5bjZpU0pucmEwbVFQTkZs?=
 =?utf-8?B?T3poR1NYUWpkMGpjWlZLKytYTmR4MnVHem5rcVFmMEVXYlZPMDU3Q3ZoaHpj?=
 =?utf-8?B?YlhzOVRiV3JIUG4wNVhZVmpZOFdXNkx6RmFiZmlkenhGMnhRa2VZcU8zNWM1?=
 =?utf-8?Q?LK3o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2NYbGM2SkljVkgweDlMdlVFNWIxbjZlMDU1MWZtdXZlSHJjRVAxaEdnVjZP?=
 =?utf-8?B?SURkUHlrSmFyNUJjQmUyUGE1T0h0aXJMdE1oeFd1emo3V2NjYVVWL1V3TWZq?=
 =?utf-8?B?aVJKUitGeFJxNzVLTk1GbmlZTUdwbXdlajdydlEzVzVUQ3lVUTFrUTROeThL?=
 =?utf-8?B?MG1GUjB1SzRKZVM0VUNvdTJNYzdNVVJiSERIWGozZ01WVjlpeWkxdHJjd21v?=
 =?utf-8?B?N01xcEpqSXlGNGVJQnVTQnFQWGZ3eHpSeHhLb2E4TTBPbytrbGplNDRwYVVl?=
 =?utf-8?B?TkdFMXlsYWs2RjkzK0Fqem81TndGMDJwcFgrUlBQRmt0dmY1TDM1djNtanNB?=
 =?utf-8?B?SnVmeFRlR0JDQXg1MUtkVCtSUEJ5aEpoaTBRUDhsd3EvblJMa2dYcm5FakFj?=
 =?utf-8?B?a2lZMGpJa3ErSkFiaEp1Tnc5cEdpTlZyaWkyc0VMOTVBMkFhWUZTOTR5bitT?=
 =?utf-8?B?SlJSd1JHQjloT3VXM2Z4NUZxRmNaNGo5VnRubG5TZVFVVnpLM2pBdDdPdm1L?=
 =?utf-8?B?WDFoWUxCaXBIcTlaSUZYV2cvMVN0M24vQWtqZXZnL2h6QktmSkhBek5aNG1s?=
 =?utf-8?B?Yzl6KzFnVlZNVy9vWUM0dWVFSE5Fd2VJamIrR0pYK1lhYW94RURlRTg5VXdu?=
 =?utf-8?B?UENNZWVZU2MwMTdodFpTaVRoTHNyTFpObDNwSHlWWG5maVI2Si95SnNjRTBo?=
 =?utf-8?B?NkNYVCtKcXZlM0dXSjlPMUxxVTJZdlZ6Szk2SmFITmhpZzVuTXY3NEcxdDJL?=
 =?utf-8?B?R1AzT0RWaXVrYXVVVTBlTGlEUlc2eEFrdE5vVWh5emxOcmI5ZHpaakxheGNP?=
 =?utf-8?B?VDVOSHk0OGdWVXZoT0t3NmNyTWxOZ2NwYTBlaUNwVXV6ODBuOStqdzFPTkNz?=
 =?utf-8?B?aU9yRVhna2JYVGU1TjVtSXNmNUZKM09LMEpTRUNKZzBVSlV5WVBPMUJ6dVBX?=
 =?utf-8?B?TVV4SkZaSnlmd29wd0hyVWVjOTRBb3dVQ1BnV215R2JobDJmc2tUclovWS90?=
 =?utf-8?B?MTlVd3BMWE9sSUJxMFE2K3UzeTFvc1ovbVNHVGZiUm1ZRlBranRHbXRHdFV2?=
 =?utf-8?B?eXB6S0t3Z055UjhjSFB1YWRqenVvUWZ6OUxMOFdzM21QVTlMVkcwSkR0MS9t?=
 =?utf-8?B?c015akc4amFqZDZvYW5SdzZYYjl0VnpOcTZNNWt4aUVyM0NxKzFlaVFXaDhJ?=
 =?utf-8?B?TGxkdi8wME10RVRCZVg3NnpJcSs4cmQxT0NZbkRuYTFxMldFNmhSYTRPajNh?=
 =?utf-8?B?bUQ1U2xyTmFpdjh5WmtvdStaOCtiUnBHaEpiQjFJcjk4S0Y0aExyTnAvVmc1?=
 =?utf-8?B?azBqSjVyTzIzR1pmeEN4SWxqTExITXVWOEphS0l1NU9pNEUvTFZoemg4SUdF?=
 =?utf-8?B?UUZBZk5JOGJwL0xsenRSN0h6aHE3OHNkUkZoVlh2ZWlpYUp4KzVhZmJ3Qmsr?=
 =?utf-8?B?a2F1NjY4cXNhSUtYbXlOUFdoK216SkczTEFydFI2cVMzWnF6NVgrcXdSMjlM?=
 =?utf-8?B?UjR4VzR3QTNxRDJOdFZBTU5WRG94UVdIZmJHZVVOS2FPVklNSjAzL2orWFc2?=
 =?utf-8?B?T2h3TFRuNk9uVm80bG1Ib0dWUVR4QW13U3BBaDVpOUJGQlFyV3YxMGNUWW9Y?=
 =?utf-8?B?NnU5aGtnQy9GbjdTeTBGeEwwMzlnbFZ2QjJEelNXWndOWW5jMWdyeTBCYXk2?=
 =?utf-8?B?SGluaXBWbTFwRGFjL2cyakNoaStycTA2QXZabUNqYWhMVGdaTGFLcTVTdHpi?=
 =?utf-8?B?WFVrQmcyY3pnYkJONmRobWNFTk41QmpqKzI4Ry8yNURMNk1JSDRSb2NPV2hQ?=
 =?utf-8?B?VTlJNDJqeGlqbEhGaStKWVN4REFCVFJHOXFRY3ZJbkR4dlJiS0JnakVWQ0Jk?=
 =?utf-8?B?eG5rRlVpbEppS1JEWUVLbUlpMVhCZEE2Zy9rcm9TUTMvYzNBeWxBSUE5blB5?=
 =?utf-8?B?dldDa2g4N1A0RER5RnZETSs0YWFGMGVBejZYeVVNZ2VNTFpSTXpWdGE1VGQ5?=
 =?utf-8?B?RDZaV29IZzJiZWFEZzZRSFc3VzFmQ0N3QlR6T0Juc0RYZEdDTEFSYi91eUhu?=
 =?utf-8?B?cXNzUStuNlpZZWtRSW9wWm1oeVV6RWZZeDBkakxjK0dzZ2pmbmtQZ1dYeGp4?=
 =?utf-8?B?OHB3b2lFYjYvZjBleGo3NEErRjJES0hsTVJha3R1QWJNS3E4cmYwOFgvWEJN?=
 =?utf-8?B?OENBN0M1aDhVRXdCRHRmQlFhL3FQbXRBK3ZyNWk5RzZ6M3c5bnBhS2J6K0Vk?=
 =?utf-8?B?TmRtamtlSGRWelJPSDlqZGZOQ25ZazB1Tm56Wk4wN1FERE9TKzNOcFhRNjFP?=
 =?utf-8?B?MXZXVHB2L1pFZWVlczF5eW5yOHYycjh1aU54enNrSEdnTUhNWE9Pd0lBN3Uy?=
 =?utf-8?Q?j2j6fUxtslJvr0JE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca803f6c-76f9-4fb0-c14a-08de6440b769
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:57:05.3691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFwZidQ3IL31gn1PcCMacwLjV7sGmN5F/YUmFdXSyoWu7LziY+8X5lMFG+wVw8iNXBrTDiRdF5GJ2xRrBqW4iKRJEaPlpQv4oHvD6FuoER8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1BAF94C4A
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-16553-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 28E00ED220
X-Rspamd-Action: no action



On 2/2/2026 11:21 PM, Tariq Toukan wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> When memory providers are used, there is a disconnect between the
> page_pool size and the available memory in the provider. This means
> that the page_pool can run out of memory if the user didn't provision
> a large enough buffer.
> 
> Under these conditions, mlx5 gets stuck trying to allocate new
> buffers without being able to release existing buffers. This happens due
> to the optimization introduced in commit 4c2a13236807
> ("net/mlx5e: RX, Defer page release in striding rq for better recycling")
> which delays WQE releases to increase the chance of page_pool direct
> recycling. The optimization was developed before memory providers
> existed and this circumstance was not considered.
> 
> This patch unblocks the queue by reclaiming pages from WQEs that can be
> freed and doing a one-shot retry. A WQE can be freed when:
> 1) All its strides have been consumed (WQE is no longer in linked list).
> 2) The WQE pages/netmems have not been previously released.
> 
> This reclaim mechanism is useful for regular pages as well.
> 
> Note that provisioning memory that can't fill even one MPWQE (64
> 4K pages) will still render the queue unusable. Same when
> the application doesn't release its buffers for various reasons.
> Or a combination of the two: a very small buffer is provisioned,
> application releases buffers in bulk, bulk size never reached
> => queue is stuck.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

