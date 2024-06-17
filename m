Return-Path: <linux-rdma+bounces-3196-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D0490AA5C
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 11:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0864D1F214BA
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B46A1946C6;
	Mon, 17 Jun 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWbmkTQg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE59E19149E;
	Mon, 17 Jun 2024 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617993; cv=fail; b=eNZD3YaipQns/Tu0Wwq+eV8RKbNcg4ZtecV3dThfMXATWx/l1IqBVgfoFChjVDYHDkP/k8O/1yAkRHkG/scTcf6MAEiffFI03vImxj9dwadrb6A7c/QMWLhB0gvjvHS22aGVIBNMMDknteQ4vS9Ir8mJtj+fwBMi11i52Myo8SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617993; c=relaxed/simple;
	bh=1+cZNTQ54d71UsBcaU+sp0AGSjCifFa1cLdKTXnTHFs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JY+viq4fU+G1GcEIBnXc4/A9G0S4iGi0ZwH9fhXLYfHt60CCeiH2ZQp/K05lqk9I7MiKloPasyJ4RwhaEc1B/3e0lgY80rH+VA+W+5koEb6B8n4/f+BCnreOHj8YucMcrA45fMbTYVSvvCyIJwSnj2PBP3SRzFmafmv8CRmR/+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWbmkTQg; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718617991; x=1750153991;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1+cZNTQ54d71UsBcaU+sp0AGSjCifFa1cLdKTXnTHFs=;
  b=dWbmkTQgWll32Vh43Ku4/p6ZILhyqkWHBVVx/j3nbCRwqGTlF/PHikEU
   JFiwvMbtwhgzz4qgrqNd0/8y1LlbUZnB61WzF9zi8vqxn3LbWdHBYYONw
   BaztmUzPa5behhi+3sO4MO413BqnT09Ybn5vPuDv2OMUA1TOEEAQ53Tlp
   TZx+5uur5FJa6lVVA2q5Zt0KRzBXW6bAbbWErCDd+/vxpvt9MLHgGaRnc
   /Cbc9G2NPNMXLlmGocsCepg03vFDHd3IJ3vcqEpk8LkYzh6SwPwwA6eeA
   WEz56NS/AfKPpKXEJOJV8QR1lbvWeWUhMKpyLFJYe8wttbRkq2+GYKcCh
   g==;
X-CSE-ConnectionGUID: Rs95FqlvSiW61AIKiyphgg==
X-CSE-MsgGUID: I7G5ISUwThGd1puxV8QkIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15207051"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15207051"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:52:37 -0700
X-CSE-ConnectionGUID: bo50TA03S9+g3jGnriuf2w==
X-CSE-MsgGUID: x912x4feTCietXpeACp2jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="46076290"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 02:52:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 02:52:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 02:52:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 02:52:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5mJ45/Uwu/4dIbeM+SHLWpYlBsNkV9TQO/H+9ViXQbA+iXV9lmY773e64ATaqDVw1ouZdL+4UGw81QPXZFi0rQ4GjFl6pVjfJKeA/hjvp9VpDEsYDCzGqkW7d87j6xapIN82ElGv7xp5e8dbCr0UgaWXgFHHFNjUdT4cce7VFM29XEMVILwjZ8EBqbCKMc9TFP6aKtuRuD0tZ2fk0mf5YSOr3r9ujznlhqCx496rYslFWKGoxf+cOkSTrocI8E677KpqLaeJyAswdGjSEB+OmFeKatOccKU3T78AOLqWt/nci9bVw0qrt3493QAmlGLBAL9Rd8k2KdaXnr7AyMgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VJ2kltynbVEc30d1JB3JhkWW7DyWLdcwfRb/K4W5+k=;
 b=NFZ7o/scMq3dCZ8DGsdNCYuKPFCKYXZtpWC5PBmDyQsOMxkq095uGMECaGrsxUq6b9kwM0tuc4NKZR4Zr3sxOl7eplhnrjScivq5tjki12FWSNbAUvZ03TI0HapmpMo7XPmmlkm7XZCUmvnaVcVgDv7eHOUFjuiCKhmngZjooRgeaLMI+lB3rXULa0TpUzB/6TJJ9FqzKdT78vZCE9Lxv/s2nPv9zJ/0sm974Kpzrylz+8yIyRsZqDZaxa9K+3+8puSjPvSBUvqDr2IdmusNclsIxFA4sONTQOxVr7zDbFOwoj3du5FdcfaXOCogMqLru+V02XbBDstOQEWkq2R3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA3PR11MB7612.namprd11.prod.outlook.com (2603:10b6:806:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Mon, 17 Jun
 2024 09:52:34 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 09:52:34 +0000
Message-ID: <d51d74da-9a0e-4602-bf6b-fa314a3a7e8b@intel.com>
Date: Mon, 17 Jun 2024 11:52:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Shay Drori <shayd@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <david.m.ertman@intel.com>,
	<rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240613161912.300785-1-shayd@nvidia.com>
 <20240613161912.300785-2-shayd@nvidia.com>
 <2024061306-from-equal-e2fc@gregkh>
 <42af42b6-ccdd-4d0d-8e5a-306c74f330f4@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <42af42b6-ccdd-4d0d-8e5a-306c74f330f4@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0107.eurprd04.prod.outlook.com
 (2603:10a6:803:64::42) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA3PR11MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: a678c877-4a66-40e1-33a1-08dc8eb33637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDRlcGExdnJwbFE2aXk4OTVvNHprbXdhZngvdTdwWmZ6OEZkd093THIzQTlk?=
 =?utf-8?B?amc5VXh3aGV4SXRXRW9rOGtQZy9scFJQQ1MzOGFyTTVzeW5YeDNPNFhYamEw?=
 =?utf-8?B?TDFvRXkxcXZqdWZVWE1ydWozd2JaOW1zaWJySWdoYUpTQ0VDSURDTDk2bzBR?=
 =?utf-8?B?eXBPUzhDZUNVNTF6cXF0NEZGeUJUV21teWI5ME1pc3N1TFhHNStQT1RTTm9Q?=
 =?utf-8?B?OU42dzR5Zi9OVTQ2N0JiRWJndVNjc0YzSnBqWW1zazRaMUJBVXhzcUZCMXh5?=
 =?utf-8?B?eVgxYjIvaHgwRmtaenI5eFdGM2VuZGlNaTBsTm1XZ1dLR2ZjZ1U2Tkhqb3BD?=
 =?utf-8?B?aloxQWFHdUNkaWhLY3ovZWRHY1FFcXFHYkpVZ0tMOWREbUlDZmwrMTJMd0gx?=
 =?utf-8?B?cDRpRDM1bFBuTjAyVFlINzdvRVFuYm4vN3VtU2RzSnNqWFVEQkY3ejBEZGtp?=
 =?utf-8?B?K0pqZWUzNGFpM1R0Rkk2WDUvdkYzay9RZ0lydTdrMzc4OEljWmFsSEozZ3pN?=
 =?utf-8?B?azRyNlBHZmR5OTA4bGZoR3FTWEtCR250NW5KeUpYbWw1OUdnWWgzeWNGQkc0?=
 =?utf-8?B?TG1SdWI4ME9EZndhMEhrcC9ZcktvUVFEUmJVSmV4Nk9RRDhCczU5a2prc0tr?=
 =?utf-8?B?ZndOWTU4dWl3SmdDOUZVaUVRSnZvYURQZlpZSW0yVm56MEJHYlRlRTVMMnBk?=
 =?utf-8?B?aG55Tml3QUF3alVQa1FMWmUzYmh2MWhBa0tjVlhEa2VmdVlnbHRWNjBFQmEv?=
 =?utf-8?B?WW8wWGJjT2NmTHVZOUExU3ExTkNTdW50ZFNBYVZ6RElQcjFiUE02WlJEYjgx?=
 =?utf-8?B?cjErbGxCeFowbmpWNUFqSlhpNkFBaXlNV25lNDY3QzB6Nm1rSVRCY3pBdUVP?=
 =?utf-8?B?N3RIQThCYktNOEZLakh5cmhXUjVLdVpvRkIwYzN1NzJ1ZTEvNW9DRllmVlJk?=
 =?utf-8?B?YVhFdE5CMi9uZjFPVkgxbDRmb1R4Z3R0TEpXZ1FJVFVZVGZFcTZVWkJBemdn?=
 =?utf-8?B?UnY1Z1paNExHeWNLYzJIZUx3Z0JqUlRONDZxRlZodmtTckhucEhJK2VlUzNM?=
 =?utf-8?B?bW9FZTlXNzFoTWYzcnlYSFAxYkErMWdqWDQzRDY0d1R6TEU1NmU2M1duU1pK?=
 =?utf-8?B?cWFkUnZFcTJYR3lCZjdYWFl5QktkWU9NNTU2YXMySkRwWHowMmlUQlFCRHJI?=
 =?utf-8?B?cU1vRmozY3lWdDJPcDN0SWtZTkZhcE5tR1JOZ2k3WHFiUUhUb0s0a2ExMSth?=
 =?utf-8?B?bnF6M0xWV1Z6Vm1uZFpFTUtDcXhWa0hwRTZNeW55cWhFU0pBbmY4RmhFNUF2?=
 =?utf-8?B?SlIyTWFadHpWOVIwTTlSM211L2RBZWhrcVAwSVRKSXpZM1N5RGsxdVhsZm9x?=
 =?utf-8?B?M25TNnI3U0NFS2t6L0d2L1RlZSs3bU0rRElEUk8rdENyd0JpK1ZPNmZXd3F2?=
 =?utf-8?B?cHE5NSt5cFl2Z2d2bmQxamVvS1Z0Y1N4d0VSNkJjYytyK05qNk02eXRMb0FI?=
 =?utf-8?B?N2piOVdQUzhzdCtkRzF4Yi8wZXVhOVAxSUNoaHNBRSs4TnNUT0RkWnl4ZTBQ?=
 =?utf-8?B?MzU1M3h0Y3F1cHNkMGxIcUU3d28vMVowSFZKcjJoakxyYlNOdk5OeEIvU3NL?=
 =?utf-8?B?bmRhUjN5MXpjc1JISFR1NEo2bDRvT3Y0NXB0UWdmcVVSQ293RC92aWx6OVpq?=
 =?utf-8?B?aDNzem9nRjVKYlduR0gwaWRMQzBueDIzYkJ2SDg4Nmd5b0tyVTdBSDMvbmto?=
 =?utf-8?Q?Nli+mcjo7FmYJNy6Ss=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlRBTVBmeks4dXNlNzg3VVVOU2xvTkYwRTN1dFRoL2l1bG1vQnNsWTJnZWVq?=
 =?utf-8?B?REZJS2NHL3UyNVltekNYTEJLTzAxVVozSDdEWFh2cEdxMWcxeGZreThhZjdv?=
 =?utf-8?B?dWxQZlBnVURhUHo1cTN2TW1rSEdmbHJ5Z2did0J3TCtUVkN0a09uajY2VUdZ?=
 =?utf-8?B?d3UwTDRaRklSTWRZZGJCTFQ5MmpyeGhPL0JzWitqUXhJR3RLQWxGbGczSDJ4?=
 =?utf-8?B?dGd0WVZxcDQzTTFieWJmNlNxQXBaQXdOS0RzNTY3QWpTeHVVd2N1VkgxTy9V?=
 =?utf-8?B?MmpLNFozelVLV3ZHdUUyQWhYRU1WSkNiUlZxQ3pGTkNRM0R6NnZkTnA0WmlX?=
 =?utf-8?B?Y0RseW1TM2MwS3AxU0FZNTQyenR3S09XWitLaXF0dnZMMUo2T0tYMzkwNUxy?=
 =?utf-8?B?bmk1cmowQVhRV3hWRVRGM1VYZGdzbTliaHBma2tiQi9ZNjRRRTRtOWdVdnk2?=
 =?utf-8?B?RnI3ZVdUS3NmWE5RNVFHTkk4aktHTXBybXY5NTE4Snh4dUwrMHlkeWJRcmFk?=
 =?utf-8?B?dldoZkswaVpiZW4yQ2RoZlBDMncvTTFHZDU5SEdvSlo3TUhTb3pyTGxLTFVr?=
 =?utf-8?B?aXJpRTY0RitoNkRwSGxXcExZNDhFWm80bS95QytSc3cvMlF5SDkyVFF2KzA0?=
 =?utf-8?B?dTVBQmh3NGI3NVFXeWZiYmlKRzFEWktyRzMyRm5YR1VFamxIQ2RUYXZBQ3NP?=
 =?utf-8?B?U2JiUERlUGxwQkl3ZG8wamljODRCZm5FTW9rWEEwZmMyb0pTeHA4Rm0yMjd2?=
 =?utf-8?B?TEVFMENEd25uMUZ1aWE2NHhqaGtyK3MrUS9BZm8wUzA0dkNhOUs0MUJHZlQx?=
 =?utf-8?B?VHA0RXJ5bzkrWlhjaVNQTVVhNjI5MUE4RUJmc1BuYmYxU25DdFNQTjlIbHZT?=
 =?utf-8?B?UWpRVHh6a0JSSXNXN0VpeisyMkxrYStMZ2p2NUMvMDdlWmc0RlZnM1l1eVFZ?=
 =?utf-8?B?LzZ4cStVbTd2cHlMZjk4RU9LWUxOOTJvdC9HU3Z6WmdtRnUzaXo5RytWYVVQ?=
 =?utf-8?B?R05pbS80V1o2RDVDbVprbEpKZjBRVW95RDdwTGVtN3Q0bFhJSm0zSmxIRnNI?=
 =?utf-8?B?dWp6dUJlOERqTnZrYWRZR3VMcWc0Z3YyK3YwUTl2eVVzSG01Ry9IVGR1UWhC?=
 =?utf-8?B?dWdpTVh3UHlycUFTUnhnT0x3VTd2QVEwQTFTdm13NllFeFNGaUtFUnNWY2xY?=
 =?utf-8?B?SkFCOWlmejF5YjEzS2tTWnVDTmppejZpT2wvSmhaN3NUbkdkVmdkaG9Ubi9p?=
 =?utf-8?B?Z2hoVFdOc2Qra3g5WVB3bTY4OXkzenNBZGpMQWpVbnlhOVB5RnBlQkdSZ1Nu?=
 =?utf-8?B?N0VVakhNcEVVdTAyN1JzT0cvQXBhTG5iMjAwZDU0M3M3WHpIbUtjbHRKdzQy?=
 =?utf-8?B?UlVzcDhiV2JaeVp4Z1BMTGx4REh0UklaTUhiQmRHYmdScGlUQklmZUtKb3NL?=
 =?utf-8?B?N2hybk1oc1NNbVhaaDRib0ZuakRHZEpYNmVqNmRoZWttcFFLdUhLRnh0ci9S?=
 =?utf-8?B?TGVOMS9yS0VFYXhtcys3N2FrYkNGQjc0YUM2NldnU1A2bHZ1R0huck8xRDBI?=
 =?utf-8?B?Y3JCNE02a3JTWUwzZFpVUmd1R0EwaEU0ZWxmZG5zaldSeTR2aXRIa0YxQjlo?=
 =?utf-8?B?NFRlN2RTa2hrRjFtVC9GQUwwSWlzVkh6MmJEdzYxS1A2dURSZEFiVlptMjFX?=
 =?utf-8?B?MXhXc1MxVHZNcHoxZWYxMXJIajJNWVdrTmxaQjE3THAvdk5nRzltcC9DNWsv?=
 =?utf-8?B?WG9GVk9xVkxQdnhEK3ZMOWphUWFqakpNTUROR2s5T2hlTzZRUFVIbnNMRnQw?=
 =?utf-8?B?aXpJZ3NXL0w1T0RYY2paRWYyNFQyUTlDWDZ1bjc3eDlVY1IrTlo2R1YwOXMz?=
 =?utf-8?B?eWRLWFk5ZkIraFV1YXlJMzFHWFpvUGo1Y1JCRXdYWFQvWjdJMTd3NDhRSzdm?=
 =?utf-8?B?OGF3ZFJyT0VoZzU3L3BpdTJUSi9tRnBHcXJPamlyaXh0aWNMaEZlK2w0b3U4?=
 =?utf-8?B?T3AvaE9Lc0xwQVRzbUN1cHFva3VWRWR3UW5NUUNZdUczbzAxMTlXUHM4RGdF?=
 =?utf-8?B?UGxCNkFETEdFMytuZ1JLVVRqc2pSMndNcE1EUXhkTkdSWUgyQjVTK0ZMa000?=
 =?utf-8?B?YmJFc3JXT05WS084Yi82NVBKTW5RSGs5a2g5Y2NKbjdtM1BUQWJ2U0FxNHV1?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a678c877-4a66-40e1-33a1-08dc8eb33637
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 09:52:34.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGsp6gx8Pc7TQoZsksCVrjUdo6edJNN66yTFI0FlqFBEJfnUIw42iAKqwNCra682YWqpOt/IUSfEBOT08hwiLgiuQBHCTbZhYva59wyAlNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7612
X-OriginatorOrg: intel.com

On 6/17/24 08:38, Shay Drori wrote:
> 
> 
> On 13/06/2024 19:33, Greg KH wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Thu, Jun 13, 2024 at 07:19:11PM +0300, Shay Drory wrote:
>>> PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
>>> and virtual functions are anchored on the PCI bus. The irq information
>>> of each such function is visible to users via sysfs directory "msi_irqs"
>>> containing files for each irq entry. However, for PCI SFs such
>>> information is unavailable. Due to this users have no visibility on IRQs
>>> used by the SFs.
>>> Secondly, an SF can be multi function device supporting rdma, netdevice
>>> and more. Without irq information at the bus level, the user is unable
>>> to view or use the affinity of the SF IRQs.
>>>
>>> Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
>>> for supporting auxiliary devices, containing file for each irq entry.
>>>
>>> For example:
>>> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
>>> 50  51  52  53  54  55  56  57  58
>>>
>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>> Signed-off-by: Shay Drory <shayd@nvidia.com>
>>>
>>> ---
>>> v5-v6:
>>> - removed concept of shared and exclusive and hence global xarray (Greg)
>>> v4-v5:
>>> - restore global mutex and replace refcount_t with simple integer (Greg)
>>> v3->4:
>>> - remove global mutex (Przemek)
>>> v2->v3:
>>> - fix function declaration in case SYSFS isn't defined
>>> v1->v2:
>>> - move #ifdefs from drivers/base/auxiliary.c to
>>>    include/linux/auxiliary_bus.h (Greg)
>>> - use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
>>> - Fix kzalloc(ref) to kzalloc(*ref) (Simon)
>>> - Add return description in auxiliary_device_sysfs_irq_add() kdoc 
>>> (Simon)
>>> - Fix auxiliary_irq_mode_show doc (kernel test boot)
>>> ---
>>>   Documentation/ABI/testing/sysfs-bus-auxiliary |  7 ++
>>>   drivers/base/auxiliary.c                      | 96 ++++++++++++++++++-
>>>   include/linux/auxiliary_bus.h                 | 24 ++++-
>>>   3 files changed, 124 insertions(+), 3 deletions(-)
>>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary 
>>> b/Documentation/ABI/testing/sysfs-bus-auxiliary
>>> new file mode 100644
>>> index 000000000000..e8752c2354bc
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
>>> @@ -0,0 +1,7 @@
>>> +What:                /sys/bus/auxiliary/devices/.../irqs/
>>> +Date:                April, 2024
>>> +Contact:     Shay Drory <shayd@nvidia.com>
>>> +Description:
>>> +             The /sys/devices/.../irqs directory contains a variable 
>>> set of
>>> +             files, with each file is named as irq number similar to 
>>> PCI PF
>>> +             or VF's irq number located in msi_irqs directory.
>>> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
>>> index d3a2c40c2f12..fcd7dbf20f88 100644
>>> --- a/drivers/base/auxiliary.c
>>> +++ b/drivers/base/auxiliary.c
>>> @@ -158,6 +158,94 @@
>>>    *   };
>>>    */
>>>
>>> +#ifdef CONFIG_SYSFS
>>
>> People really build boxes without sysfs?  Ok :(
>>
>> But if so, why not move this to a whole new file?  That would make it
>> simpler to maintain.
> 
> sounds good. Will move them to new sysfs.c

your proposed name combined with the directory would suggest that this
is base sysfs for drivers - drivers/base/sysfs.c
please add aux_ prefix, or similar

> 
>>
>>> +struct auxiliary_irq_info {
>>> +     struct device_attribute sysfs_attr;
>>> +};
>>> +
>>> +static struct attribute *auxiliary_irq_attrs[] = {
>>> +     NULL
>>> +};
>>> +
>>> +static const struct attribute_group auxiliary_irqs_group = {
>>> +     .name = "irqs",
>>> +     .attrs = auxiliary_irq_attrs,
>>> +};
>>> +
>>> +static const struct attribute_group *auxiliary_irqs_groups[] = {
>>> +     &auxiliary_irqs_group,
>>> +     NULL
>>> +};
>>> +
>>> +/**
>>> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
>>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>>> + * @irq: The associated interrupt number.
>>> + *
>>> + * This function should be called after auxiliary device have 
>>> successfully
>>> + * received the irq.
>>> + *
>>> + * Return: zero on success or an error code on failure.
>>> + */
>>> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, 
>>> int irq)
>>> +{
>>> +     struct device *dev = &auxdev->dev;
>>> +     struct auxiliary_irq_info *info;
>>> +     int ret;
>>> +
>>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>>> +     if (!info)
>>> +             return -ENOMEM;
>>> +
>>> +     sysfs_attr_init(&info->sysfs_attr.attr);
>>> +     info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
>>> +     if (!info->sysfs_attr.attr.name) {
>>> +             ret = -ENOMEM;
>>> +             goto name_err;
>>> +     }
>>> +
>>> +     ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
>>> +     if (ret)
>>> +             goto auxdev_xa_err;
>>> +
>>> +     ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
>>> +                                   auxiliary_irqs_group.name);
>>
>> Dynamic attributes are rough, because:
> 
> Your response after "because" is missing.
> Can you please elaborate?

you have "complicated" (compared to "nothing" for static attrs)
unwinding/error path

> 
>>
>>
>>> +     if (ret)
>>> +             goto sysfs_add_err;
>>> +
>>> +     return 0;
>>> +
>>> +sysfs_add_err:
>>> +     xa_erase(&auxdev->irqs, irq);
>>> +auxdev_xa_err:
>>> +     kfree(info->sysfs_attr.attr.name);
>>> +name_err:
>>> +     kfree(info);
>>> +     return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
>>> +
>>> +/**
>>> + * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the 
>>> given IRQ
>>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>>> + * @irq: the IRQ to remove.
>>> + *
>>> + * This function should be called to remove an IRQ sysfs entry.
>>> + */
>>> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device 
>>> *auxdev, int irq)
>>> +{
>>> +     struct auxiliary_irq_info *info = xa_load(&auxdev->irqs, irq);
>>> +     struct device *dev = &auxdev->dev;
>>> +
>>> +     sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
>>> +                                  auxiliary_irqs_group.name);
>>> +     xa_erase(&auxdev->irqs, irq);
>>> +     kfree(info->sysfs_attr.attr.name);
>>> +     kfree(info);
>>> +}
>>> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
>>
>> What is forcing you to remove the irqs after a device is removed from
>> the system?
> 
> We are removing the irqs _before_ removing the device.
> Irqs removal is following the exact mirror of add flow.
> 
>>
>> Why not just remove them all automatically?  Why would you ever want to
>> remove them after they were added, will they ever actually change over
>> the lifespan of a device?
> 
> IRQs of the SFs are allocated and removed when the resources are
> created.
> for example, devlink reload flow that re-initialize the whole device by
> releasing and re-allocating new set of IRQs.
> Certain driver internal health recovery flow can also trigger similar
> re-initialize.

I read it as "removing all is what we use 'remove-one' for",
I'm correct?

> 
>>
>>>   int auxiliary_device_init(struct auxiliary_device *auxdev);
>>> -int __auxiliary_device_add(struct auxiliary_device *auxdev, const 
>>> char *modname);
>>> -#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, 
>>> KBUILD_MODNAME)
>>> +int __auxiliary_device_add(struct auxiliary_device *auxdev, const 
>>> char *modname,
>>> +                        bool irqs_sysfs_enable);
>>> +#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, 
>>> KBUILD_MODNAME, false)
>>> +#define auxiliary_device_add_with_irqs(auxdev) \
>>> +     __auxiliary_device_add(auxdev, KBUILD_MODNAME, true)
>>
>> Ick, no, that way lies madness.
>>
>> Just keep the original function:
>>          auxiliary_device_add()
>> as is.
>>
>> Then, if someone DOES call auxiliary_device_sysfs_irq_add() then add the
>> irq directory and file as needed then.
>>
>> That way no "norml" paths are messed up and over time, we don't keep
>> having an explosion of combinations of function calls to create an aux
>> device (as we all know, this is NOT going to be the last feature ever
>> added to them...)
> 
> Thanks for the suggestion, will change in next version.
> 
>>
>> thanks,
>>
>> greg k-h
> 


