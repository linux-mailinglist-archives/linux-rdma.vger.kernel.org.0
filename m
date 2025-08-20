Return-Path: <linux-rdma+bounces-12841-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD792B2DFEF
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 16:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9175D7A7D16
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB2431CA60;
	Wed, 20 Aug 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDsD3OjF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30A7277CBD;
	Wed, 20 Aug 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701423; cv=fail; b=HkeajV+RBgIZIG0RxQPY37WusUW7rgsV3NvCyUQeRFANDnR2DbQkFKOLIiTRdZ85grf9rkzA0yqEDOJuI1yidSc7If+GB1anmfQls/efOFl7lr2z6HgooyTJTuwxarZxJrTpJQVyMOxlYo1ILj8xWivebRRduy5W8EKSazvXV5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701423; c=relaxed/simple;
	bh=5xxgDFXkMwPowLNH6JHMJDMAvTvV65wEJYrBJ1QPoOw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CkocNP5pwBXhvGFl938BWBU7AZJ9ANa1fwl0Z/scaE53PTK0SsXyUK2xICyi+fuumCYWUq4ZV0Lgc94odhAHI1fuO8Py+BnhtXpPYo4AwY3dgAseHEDSZn+Lq6bPCtvaDlaHqK91xpiHuOPXHAtswCiOkzi3qppryfrL+sVpxAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDsD3OjF; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755701422; x=1787237422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5xxgDFXkMwPowLNH6JHMJDMAvTvV65wEJYrBJ1QPoOw=;
  b=HDsD3OjFqUhIStQ0Lx6WCI0bc/jM92AamaJm/q4w4ZPbYe6PEks8n0Q5
   glEKpiRKMNhLt3XsYURzR59RGlyRTZnURaieqDTGfcrIYqvZ7XMdn4/3i
   RuV44UoELjROSzoLpMZLj2kiaavxvli6uhzaj6ioNH2m/BFpF5ZQ1HoCk
   abD2JI+O9Maq5nkIdZLJPMZjDJy9i4RdspEk1C/Qx7nRZ5UzRI/7pVrtz
   eNhiJKBwuqA5T766zC3xHSmNXtnBx6oCx5g0LJHZDu8XmTdfRHQm2HrUs
   Sz2sHSjI2QO/kcRkUpGbGc+gB4Z0fJmIf/gSLsPqz5JpREceeQchlZrnD
   A==;
X-CSE-ConnectionGUID: n+wNiRkSTKeW9585IrRUOg==
X-CSE-MsgGUID: 6o+wFwYfQXq/k0v5oOLkxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69067755"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="69067755"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:50:19 -0700
X-CSE-ConnectionGUID: S50LJ/IARV6D+HkeNhuUhw==
X-CSE-MsgGUID: NswVT+DiTBOUjtT8P5Siag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="199017305"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:50:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 07:50:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 07:50:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.86)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 07:50:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Il4ZAXsQyO5JXqCx1aUQnU3bZQg0ieJu3dHhZwzBQY5u7FmWq3DSpGoP7VPU4yMpFmURFv3cGaZsfXby7yLpAXbc59NKqKZZYKutnCEQJEUgNUStPoxICW81LXuT6fkGr+1bbZzD3sMMAVKAquY5+0v35PviFvDCvjmqk36w3OUzDyT2soE6j7GDUyhkrg74fT0kEpWM1+JqUt0T0BmYAYEq8P0RMFWBD1E+WKR9gF1+fJBEuLPluaQeVK78cyQwrQxDVCv6pxjwV+kaMqDHgwKt9Q3qjMYc/AzZDFKK0JuEb4W7Qf9ZX1Rf8P/7B8v+/5925RceeE9RFooDOfLkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCfdVawadJuaZyDAnUlc5wH0IY0fvk2Waas0Ej4sKdk=;
 b=HWzpg3xdbbavUjL9sbrf9be4GL8VlDBDVSB/GktlH+TNa7IXklTmLAsUYYCRqYLacz0Iwb5eEeLh5Cp6MI3nRClx94MrNIXDf7DpBAOyYFv7DxwJCRtq/D1q3iqUz3riZG/x7QkRAhqgX4muROlLdx2LjfPXlznrXcMAelJuFBosYDh9lAsFpiOnKU1itx0Am5By05rZYE+hEQfJq7rVVvIBwBZETngy/N0Ob4yH9YnyXZdYXmBnQmvYMSHhwr3aJieXR6VLRvUenmfT1AYS8CyqayzWV1NAu8rNYQRCiK3hBzKAzGiigXuDSUDtVXSS+yoIX/zTNH4vbkrkcBOQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY8PR11MB7107.namprd11.prod.outlook.com (2603:10b6:930:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Wed, 20 Aug
 2025 14:50:14 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 14:50:14 +0000
Message-ID: <39e6aa50-5efa-425d-96ec-2146a0005441@intel.com>
Date: Wed, 20 Aug 2025 16:50:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net 8/8] net/mlx5e: Preserve shared buffer capacity
 during headroom updates
To: Armen Ratner <armeng@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Maher Sanalla
	<msanalla@nvidia.com>, Alexei Lazar <alazar@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
References: <20250820133209.389065-1-mbloch@nvidia.com>
 <20250820133209.389065-9-mbloch@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250820133209.389065-9-mbloch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0037.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::9) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY8PR11MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f1c6d2-531c-461c-b160-08dddff8df1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1BXZ0RvNnBscTlkTjBIekgrTGY1WmxhR1I4ZVE0eUVxd3RhSDVWaW54Y0J0?=
 =?utf-8?B?MlhiLzZYdTFIUDh3VURCYzVMSmtIVmVWbmw2ZGFNQ2RFYVhBeGoxaXNreHZH?=
 =?utf-8?B?ckdGOEFOZkphMVVWekVTNzdtbkp0V044TWVQalpycmFjVnBST0NRTmRHMlRI?=
 =?utf-8?B?K3k1R3JFRlFMbzIrQ1o3b0MrTFhndHd0WGFkV1lUOUdIWXZlV2ZSTERnM1cw?=
 =?utf-8?B?SFpPVzBPZmhpa0RsRGcrYTJ4NWZHbFhwaTRva2RjZWZZQnZ2dEJ3SlVHdmY4?=
 =?utf-8?B?WkhnWGRUVnpIWE8zclJETWptNm10a1ByeXkwMzJPK3R1RDRzL0xTVzF4aUc2?=
 =?utf-8?B?Qm5Ia0FqYmRhQ1JVdEV2Q2xUUmhEMHVzbUNxRmtqUmM4eURGQUNVUWRITnVN?=
 =?utf-8?B?dzZ3N3NVRk5mYWtPVWI1a2wzcUZCeFVlVW9iZmw0NGlxSHRHYVJhdzNqQVVl?=
 =?utf-8?B?ZEdWeFRVeTN3THFrVlFwYlZGZWsvTkNqcWZ2MGlwRnRRckFuUlkxb0VvQ2RB?=
 =?utf-8?B?dXl4SXU4ZzJSSkNXaUMrcm9XSXdmMHg3TUlNTytGdmZnN2RvVkM5ZVBsSHlr?=
 =?utf-8?B?SS9xa0p0cHE4TTcxUGsyaGRkUUxnU2hKV29JM3Q4ZStjVkhzUElyS3pweWdr?=
 =?utf-8?B?N2pma0FjSVdvYmpoRlU4ZTUvVUZ0cXBHRi90ZXdnRVRZTERGUmNkSmFVWGFi?=
 =?utf-8?B?QXRmeGxnNmc2Wm8yWmk0MlNvZHoyN1FBcWh4amRTWjQ0ZzN0TXRRVzJoZVAy?=
 =?utf-8?B?dklHVDQ2TWxoeDVsRHFpZlpVRjFyZVNVWmFCSVdpNU92NE8xVXlyRER3b3A4?=
 =?utf-8?B?TGY3QWY3aWpBSGMwZFlOVEJMU25tNEw1RVhTL0dqV1FaWHVPRk84RWZhM09I?=
 =?utf-8?B?UUxCV1N4ZXMzQTZXb1RzTjJRMWRQMXVPZGF5UmllWjhVQ2FTZVlSaEx5cWIz?=
 =?utf-8?B?OUdPR3pXdlhJY2VGbEdJY2dYaHgwVmZFOXp1bkJ3eTNwSkNpMFQ4VEMwK1M2?=
 =?utf-8?B?aVZDVUNtbmZ4MExwSXB3YkZibEw2YVlvb1VKcWFVVGFHWXpoaGljZm5UTDMw?=
 =?utf-8?B?a1dTMVlMdFlYaVBlS3d2MHd6UFhGMU9vVWE1ck02S1lkRmJCenpTT29TYTNy?=
 =?utf-8?B?NXo5SUJWRk9hYktvdmlPbnFWRWJMdkpxb2w1aVFtY2ZVaTRMaDB3QWQvOEx1?=
 =?utf-8?B?dzdFNHV6dG9GeEJPODlhTFkwR2NwVFpjUzBuQ1BqTjhGRnJtd0R6MXR4S3B0?=
 =?utf-8?B?MTlwUkdSaW1tVWtFR0Y0UDFWMmRnUHZKeUJXa3F0aHE3anhGWlNiTFZObmJF?=
 =?utf-8?B?dmgxd1JZYXJXWmxLajVPbG8zdkZYSkJEMWV3QWY1VVI3WTNrVzJZUDNoQXVD?=
 =?utf-8?B?R3R6V2dTeVdtbzVmeHpaUkRuQ0RmcEpLZnViak41Zjh1SytHcVN2eHpNK3NZ?=
 =?utf-8?B?Rk91eEcvT3VobVU1bzFKalpNbnBrZ0tTLythdjhuY1VMUENHSm84RVBPVnRP?=
 =?utf-8?B?c0paMUFZMDlBWnJHYVVXQTJOdGxnRHQ5eHMyNG1YOHAzRTJqVndwblI1MGN4?=
 =?utf-8?B?TDBTcjR2WjJjbVF0Wi9Fdk1pMGppbXNHMklIbFhqNU5lZjBiMWJmTGpkSngy?=
 =?utf-8?B?QU1abVFNalNGSkRTOUlDakxmcUdTSGVyVm9pb2lIdUhaL0pjV3plbzBkb25G?=
 =?utf-8?B?bkgwbTF4QTlNMmFWdHRxbFNESzl1WkE0aGNWOXNZOGd1YTR1YXFaazZkSHJK?=
 =?utf-8?B?WUJ5Q2dHaFJWWUNEZTVwaytFQ2R3dXIzRHdwTG0xSCs2OUwxcUZtM2hRM0xs?=
 =?utf-8?B?ZzFSS2xkSXZWSkFmNDF3R1ExYk5nS0FxdjkybDdXa0NFQTlEblBHcG1SS3B0?=
 =?utf-8?B?RGtSclJDVk90WmtDNWxSbE0vOUpad2VEMkNuWnVLYkkwWVJ2U1FrS0MwQmdm?=
 =?utf-8?Q?Uzy17Wesxrs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXU5RmFsM2swekZmejBZdGFRMldMQVNTMklQcGtGRUwxUVZza2g2eVpnWmMw?=
 =?utf-8?B?K2puOFJIUnlDTG9sMVFvSTRvY01CWTR5d1k0QkNzTUZiR05XQldQYzJzdEZF?=
 =?utf-8?B?MnR1U1ZHSSs4Wm1hUVB2MWcyNGFqREY1d2dFWWZSbmo0VGQxMDloSUZtV2k5?=
 =?utf-8?B?ZjJCMnRGUjhldzFmS2lJaDBBdVNRUmNzbThkdmNJSmo0S0twUWVZN2JwWnVy?=
 =?utf-8?B?blV0RjBnOCtMTVdYTm1oUWVmbnE2RHhDaHZyc1FWQ25keklEV3Qxelppb0t1?=
 =?utf-8?B?Z3k4ODhWZE8zeFNHK0ZhMU1pY0J3UDhDa0pjVlQ5VmFLN0I2YnZCQ3RvUytp?=
 =?utf-8?B?R0Jtb2pnMEx4MXVkdEZ2clhwTlNvbGZyZi92bWpEQXc1VzFPdXg0dVVwdHBD?=
 =?utf-8?B?RVV2Q2NvUDRhRWtCaFU3aVVIK0dGeHhCcXVTUHRRQThDeGpaTWhGSEtLR29G?=
 =?utf-8?B?RnV6cTVoaHR1RUxrNkM5a0FqK0Y2ZDRyVklFRG9kTlVRRnFGMytNQnFGOVNO?=
 =?utf-8?B?dHlHbmhabThiNGRVU0Q2SUU0ODVvOTdoeWxtZnE4OHdVZ05zTE11SDBhdWI3?=
 =?utf-8?B?YTczajc1R1ZIYkV2TXlCZFV5dldaUVZUV3UxUDFacTE2MytjWWNTSlJ5V2h1?=
 =?utf-8?B?S2hkT3pydjVSTy9nZEQ4VmJNcnV1d1NQVkxVcXZnTDFsTzZnTWRyaDRBNktU?=
 =?utf-8?B?ZXp4Z2lIRnRBWW43ZnVnWWlWUlpqNUlVcm9kNDl0WkxwNk5IZkU4elhlTU8w?=
 =?utf-8?B?V0syT0diRzYxck5jV3dOSUlGMkRkaVZmS3lpb3lYQlBpTlB5cHVPbU9OTEwv?=
 =?utf-8?B?dyt2NjN0SFBlakR5RS96UnlDRUxwNEpLajVqYmxJUHVRaUxvbHV4aGtidHpH?=
 =?utf-8?B?YkdHTGF5WnVZSmlFZTRpWU9Udk9DRXdwdTRvekRaTE5tTDIrWXlkaHBKT3FJ?=
 =?utf-8?B?a3o4a3VFMktHN2Z4MEJ0L0NnNU5zMXZ1MG1VMGRnUUdZZGpKaURrUnpWbG95?=
 =?utf-8?B?a1VEZ293SFJGbmNZN1puZm5pUkcrZ1NaSWVmWGl4bFN2NU9YclJqa216UjM2?=
 =?utf-8?B?N2t0L2xIOFdrMVoveVlXWVFJVGZkUWRwS1dkWE9uUUVtUy95cEVxeVViVm05?=
 =?utf-8?B?R25lTC84REJDM2xqMVZpY3l5eENDWVZCSmdlZ1RoYnZ0STUrb0hjUGQzendN?=
 =?utf-8?B?VHhadm1yUkwzY09jdVZ4eFdxT1ZrQlJlWEJUZ0JyWDdBZU55RkFHZlpSNml3?=
 =?utf-8?B?TVZvMDFRYVN2dUdhTlovWXlUNlpUQUJoNmJ1NDlIVEtZNGZzcjhBbGRpMVIy?=
 =?utf-8?B?Z0o5akVlSDNIdFhvYXJYU0EzUzVlRnZsRms1cW9tZFNYRjZVQ1psMlBCS0Q0?=
 =?utf-8?B?aDUvS2thT2grOWZrQ2U4ZW0vNnVGYlIvK1I4RFNWK2dKeGxkWDYwNkp4bGlj?=
 =?utf-8?B?Y01kVXYwaC9tTVVDQXdheXRaVXZHWE1hMjhyT0NhVnJoN1YzT3Zsa2YrclJt?=
 =?utf-8?B?R04vVHhia1hPUWVDaEljOUUzL0hiRCttN25yTFpLYXgyb3VDZGM5VlZicEt4?=
 =?utf-8?B?d3daSUJSQ1NXU0Y1b05LOEp1S2NubXBpTEI0NENUQXpjVlFDaWUyNndvdktJ?=
 =?utf-8?B?eDQycmVQWE9OUEhPL1F6bDU2SnJOeXBhTm5wWTVNNWpOYlp0alB5dkkrOTI2?=
 =?utf-8?B?czIvdU1pdWVURUVEZHdMY2ZmaEduMUpTN0cvS0ttWXBNVExyUkUxdSt2MXUx?=
 =?utf-8?B?THVwaG1qRURGbjd3Y3QwMDdtM2pGV0lOQndHclpkdjc1Y0orZ2JLMzBsb1N1?=
 =?utf-8?B?QmJlZXVONDhLdURqbitWSUtBMjF1WDQxQWtzaVRVZmZOTTFqU3VWcE9hTk5y?=
 =?utf-8?B?dGU0WXhwZWRGS2EwZVI0ZHNlM1lCSjRoOFdoTWVLNENYVkJjUnNuN0p2UWZ2?=
 =?utf-8?B?cTJaWE1SREJzcnZqYm9lY0JMamdYQ1R1bjJwM3lsdkNubXRqZUN5SHQvQVVu?=
 =?utf-8?B?UGR2bHZTUzlZbmFjVVdFL256REdxN2I4R05vdHI5WnZVcDNneDJBVVBsSWJR?=
 =?utf-8?B?eEFkblNMMTN1QjUvRDdXVGlHdXdrcms2N1NYOU9OWEFCVjlVMlhjdnovZG9T?=
 =?utf-8?B?UjU4TUFPT0F4K1BySEx1SnlLVS92d0lmTWlCTGw3anVOa0dHdk9qQ05KZTRC?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f1c6d2-531c-461c-b160-08dddff8df1d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:50:14.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKspHmzHWpxFJV3FrVg04x8IJ31UKe88LS7up3kPUDwbAXtY2EbcCzOl2ZpGYOLBHi3wifHec6xRUsecqyCXNpFMds6bWr3NMPM8/ZzP37g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7107
X-OriginatorOrg: intel.com

On 8/20/25 15:32, Mark Bloch wrote:
> From: Armen Ratner <armeng@nvidia.com>
> 
> When port buffer headroom changes, port_update_shared_buffer()
> recalculates the shared buffer size and splits it in a 3:1 ratio
> (lossy:lossless) - Currently, the calculation is:
> lossless = shared / 4;
> lossy = (shared / 4) * 3;
> 
> Meaning, the calculation dropped the remainder of shared % 4 due to
> integer division, unintentionally reducing the total shared buffer
> by up to three cells on each update. Over time, this could shrink
> the buffer below usable size.
> 
> Fix it by changing the calculation to:
> lossless = shared / 4;
> lossy = shared - lossless;
> 
> This retains all buffer cells while still approximating the
> intended 3:1 split, preventing capacity loss over time.

very nice fix and a good story :)
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> 
> While at it, perform headroom calculations in units of cells rather than
> in bytes for more accurate calculations avoiding extra divisions.

nit: next time I would split that into two commits

