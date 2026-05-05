Return-Path: <linux-rdma+bounces-20029-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KYFGo4b+mkJJgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20029-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 18:32:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D16C14D1577
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 18:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60A9A308654F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 16:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9033EE1C4;
	Tue,  5 May 2026 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYZnOUYe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D738BF7A;
	Tue,  5 May 2026 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998464; cv=fail; b=atN7uE/N2dLrlieZJdkZ+1lFCmWL+t7oPJYrTotdBGfk4FUMVLDTKaymaVcfQc6eLzkn1CJmmYeIMejklob2jt2S/Ty/GwGV71vJblGagB7kY1wkGi/pbJHobu/2DM3h19myOWOWWOrWiY0ch85L7RvmxPzDUceb7iZ+9mr26MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998464; c=relaxed/simple;
	bh=LHvMu3FvvWSSModtfE9oQHwkGJtEQZ8cmpYaVZ35ALM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=psk9iYOtOS5G0gW6pSvrT+ivNRe5CQvp5+Ug1jTrldzaBE3MCKQn7dIbe7YbWpBQPNe3kiNS1VFhFaBDDhnI2ZBX2u9BzNslgJB51qpjiswpaEXlIqDanqnsNFAshMUJx/LpWo59hUDsx33KuO3mGhxPBO4DR9b9PEkKi5cO9OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYZnOUYe; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777998463; x=1809534463;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LHvMu3FvvWSSModtfE9oQHwkGJtEQZ8cmpYaVZ35ALM=;
  b=OYZnOUYevJfla5/BfY2XWcWMZeY/4Mt6pKX8JfG4ieLyzhogvli4fjAC
   SDTbZ2I4P9wjrOfAOEo0GWlFGJ/G1eo/7jNeys2AfyRiYYroTIk6v28+a
   nF1d3gYEqcvUssbKbK17jJJEOKTDUk8eqyJdJZcuAZlIsbp+DAqRTvLBa
   NqjJj0Y5RoTKIAX1KkGD7LlLM3m5z47CxryubxKolDIBfS2zEX62VduUN
   JbOoTgj3TqVORm6YN/Sf4i35LRDY8O6cqKPM9YRJbAxv4tqefaBBw3Eyu
   GO00A2pN2wcz+cDqINl4kPLIzyjhgBrbgNvtFCj/ir5LTlBfNzAjwpMv7
   w==;
X-CSE-ConnectionGUID: 7nwbZWcfTquysJ6AMVXskQ==
X-CSE-MsgGUID: +QG6IHGTTMKRdxA6RJdKgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82743655"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="82743655"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:27:43 -0700
X-CSE-ConnectionGUID: a1XHV0yzQ3aoaMc1K4I8zw==
X-CSE-MsgGUID: asvdJdFxSPuGgql2evEtdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="237634912"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:27:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:27:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 09:27:41 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:27:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azjArq7QBb7XIID/5uzy7sNs690gw3D2VnqbPrx7JVDVdF2senDG5bLlOIw/HPCSi+D9tQPcr7I7uNBoh9ka+n24+3LGMBeEL2mS4+VmxbhYV8xUigDI49Nfg1rGy7MlkB+rtdDTLUi2H0qgWgZLhbECdgcRXWCFEH/VfRCU2LkgAdK2jh3WrDKvNXh9OeO8udZKvdhKq7fiI8j6zSlo4faFD5UrEl+EjK6CDGupJ0b9aFc5rEVA6dYvkyECYJAgPD3uUNcE5/NalzayeQi1hLwchhzDlT8Bm4ag/sjMUIZjgrDs+VsWs1TA3rzuzaoudwKpSl85kkR/pso7ZSD0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2JVYfUyd3iXxs2AwXgnTPdM8dE8RvkwojBfJjwalAY=;
 b=a0mj6Mp/sWZky2F87+H60uQ+20QiGaQSkoHjW6OEbDO8LP/rl2paEZaVZtHwiBLf2/dQmMTJY7DFKgL2TvggaIs+N5zSpj+lNk/qNvHovOtIgwdCWhfGMfSU1a5HxAxzy5G9lJfCWPVikNpMYcSg1NLYfRNino59rE+jnZys0wn2fn630+/TdBjv2DYwkZrWAYlv0ZzAmggV3j0Nf6HpGea7IjBunAuf8X35i7WfV9HFXmbP4zVVCLPhO7od2aV6wHIn3g/AZCjnPU7Pr45IMaWaww2e0PoMKcURu4jEBcQAyPesvswRXBtwfIa+HDygoXn1fQT+bTsr6LPsk3aKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB7387.namprd11.prod.outlook.com (2603:10b6:208:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:27:39 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9891.008; Tue, 5 May 2026
 16:27:39 +0000
Message-ID: <1ecb87f1-fcae-47bb-ad83-7bf2ec807463@intel.com>
Date: Tue, 5 May 2026 18:26:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net/mlx5: Fix HWS L2-to-L3 tunnel reformat release
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "Jakub
 Kicinski" <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260504221920.48685-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260504221920.48685-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0157.eurprd09.prod.outlook.com
 (2603:10a6:800:120::11) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: f5751d04-b32e-4a41-a5c3-08deaac338c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: GcQQAkJsOV5FtjFYNhtF/yh9ZEjk/uYBVtwW8wC/RN0N6ppVCR6FanTrioth8x7+g8D3vcBvQNwIXtFpRAHCiqCvWtKkLFGAsIcAQ9MUTd+q1AN6zB/GqoAX5O81BaMYymi/6p9uO31kwp5QRsnjH4XK0UJ9VxYmaICT6UsiRzdgDquIlHY9XuJg8BVf+0nV2Blo9EwGizuobE0YHykMjXJp5WMi1kvk91yaGAGrmDRdPTPyenFaeng8ozfO3i1QMKDyldkmlukpfh9FiipFt2oyOzF1zYEGiVx4LvWOhxX053e4KxWyveE88FkygLRxa52zxnmM+7D1exIYTEwcn5aSmbiocACsoUJ9V0gMfbCaIk9wE52TfRvX6ieQW7d/Nnyo1fViP74HGJVK99+2+ObhUADu4LHjBoajZlkaG+7SPNzomMnJKENdaQlYMaUvJgRuPxx03JbeVghvyGfsVgKvDr7vwr4JZJ0uldyXu395rEn3nPAfpUrE4Z5UEYSwsjPCTE+ioTTPV85CVNP3JVujdRgsDKu0ML9B1nIe+sNo/anzp07Ri6BCiqXmfUnXXyfkZQrHmBsdtcj2nGTPxuQAoor97WZZBxHnwHhTHlEcUXYtbSmJx3OX1Gj23bbWUAd11SQHYrjHUAy24jphs8DS09q2/E0NTSk/WBspDT+5ZpGW8sX+BZ+qhl+pWO1s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXZNR2VoWHhDeTY1cXo3dnJsVGVRV0hkSjNrZ1pPQzYwRzN4SlNycmR1N3Bj?=
 =?utf-8?B?dXZBd00xVWM2eGl0L0I3dlVjZnA4NEZxbWdkUGphbFJFMFFoUlFaWi9XeXBi?=
 =?utf-8?B?QWkrMTJyR1VUaEFJOUVqVTFidURnSlAxdHVOempUZXNvMXZJWTBmZ1ZKblZk?=
 =?utf-8?B?TXpkeXppd3BudmlaRElGcmd2ZVNjNjhzQnpHS1ZaK2w1V3N6ekRPMWlZdWc4?=
 =?utf-8?B?SWtGTHpWWFlWaFpNaGRjdTlZSkRMazFDNmRzak5ISE84bXNKYW5WNnJGVDhN?=
 =?utf-8?B?REZoVjNEOEN5RXJ4V1g3NXdZTG13Z0FHdXpHYmROUVdvUnlYV1RKQm1JRjJY?=
 =?utf-8?B?Q0UyWFhlVUZJV3Zza3pXUkFKRElXZkppVDNZejV5OEtGdzJLbjlBN2lTSDVw?=
 =?utf-8?B?TzN0Q005SFJ3YW5nN0RPZGwyUUZWc0FUemE3VEVBNzJtaUxZbi90UlFUTnJW?=
 =?utf-8?B?WnIvenpERlhNeWdrOGYzVytmWldLdE1mYmxldHBtWjJweVNnYXJZMHdJeFhR?=
 =?utf-8?B?R0F0WW1vMDZBb0w0OGI2ODhQY2M3WEg0dStLV2ZxaDBBaFhGWmxuWFVGUDJ5?=
 =?utf-8?B?Vm04SFp3U25KLzNzNDhsZ3o2blBWdnRGaVhyNUNCdms3ZkxTSUF1OTFiUktX?=
 =?utf-8?B?Mk5OczFFSlprODQxSE1qNkpwdGdScklYbmhUenRtV0tFWVU5OGNmN0FZQW55?=
 =?utf-8?B?Z1k1TTl0Z25lTEdYVnc0T015N2Y0cytWWU42eXpiMlFBYlM1STN0NDloZ21w?=
 =?utf-8?B?ZUowa3FjZjUySCtYbjlzRXhZY1NMZm1CWE1JR3k4SWN1THVkR2gxNFNiMk90?=
 =?utf-8?B?aSthYVJ1RDJkMGJlOGgrVzkvalNzMitITklQaFBBYXByYmpteUhFTURvSDFV?=
 =?utf-8?B?bTZkNjJYdTdodVlLN0d5OU5tb0YwS2JkNno0eHF1Mm92WVdjRTl2UlEwU3RU?=
 =?utf-8?B?dXVZSVNmdXNOWnFDR0JuWFJ5Vjl5Qlg4K095UWk4dzhONG11WjkrcWxrWitF?=
 =?utf-8?B?RlB1a2E5K1lCR2UwVG9NdzJDNXc5VFZZOFc5RldpbW8rWDYyVDA4S3dBUGdk?=
 =?utf-8?B?ajA1RHYyck80OWlYSjU4cEhZeStSbVNpaUREb0NGMlRBV1V4c0J0OHhRem5E?=
 =?utf-8?B?ZlNPS2wwc1FSNEJJeWVYTXFmM1IyV1VkN2l5SWxzTU96ZktBY1Z1Q09FbGhR?=
 =?utf-8?B?N2lid3E1VWEwM0JGYkhmZ1hnMDRwWWVQaG0wTG5vbHJnbHRJL0RjeFlXSkV1?=
 =?utf-8?B?YVJ3U3E5eldzQmZ3d21vOXZQZzJCZkh4OTh3d1MyZTNTL2x5VlZEb2cxL0Yz?=
 =?utf-8?B?VDVPeWl0K3c3L1M3QnBJTUp1SGE1Znh6d2E4N0ZpNEdmbjliaEFlUnV0YVdB?=
 =?utf-8?B?R3d0TWZVdUtmS0Jnd0IrczVmam4vZlNJRHIzbXZEcGkvU1JvQzlqVzV1TVpT?=
 =?utf-8?B?RzNFMlVGbWxKWHlTcHlaMEF5Sm1SMlBhQ2NMVUQyeFNORGI0VVdwZkJvSWxm?=
 =?utf-8?B?UkE3S053K09pQkdNR2xPWDV1dEFUT0ltaDF3VGtTSUdLejRwK0Vqd0YvUDg2?=
 =?utf-8?B?bjB0MEtMNk1XVit6T00xeHM0Q0xrYVc3QlhxMHV5djUrYnlLSmNhcVVGb3BW?=
 =?utf-8?B?UVNPZXMvQTVVelZyd2h6U24xRWhvM1lob1N5dW1id0F0Q1NxZVRoTG5QczVr?=
 =?utf-8?B?UHB5K1ZESjlGZFQvWElxT2htd0hVclR6bFlZVmREa2FEVUlsK2lyMjhvcXIr?=
 =?utf-8?B?WGJPYjMyekpNcTNiSzlFU0hvWnpuM2hJWGdwWmgxVFMyL3lXRFNPNkFicU5h?=
 =?utf-8?B?cXpTTkswcWppSE43ODZGVFRBS3kyYkZWSEVoYWVBaGwvWE1uZ3oxTmhHU1ZP?=
 =?utf-8?B?T2FVTVhTQSt5dC81elFpNTcrMEltMVZDYVRIYUwwV0Qyd0N1M25HK2luVnlo?=
 =?utf-8?B?Z2NpeW5nTTAzeWVvMEF2YXZCamVyd0o5dGNBOC93OCtFT2tNUnRJN0dwZkRP?=
 =?utf-8?B?YVl1cEl6a056dFIvK0xnaDRvUU42L3hvaHc5OFpoUUhSaHJnL3J4TFQ2ZkdY?=
 =?utf-8?B?NDNPeHI0V3NVRmgvNkY1U0ZPUkUxa0tvUklxRFBnU0lCNjJCbjlLT3FNSlYx?=
 =?utf-8?B?bU9sbEhWNHl6bDI3ajkyNDd1MUVqaGFPdGRyczRLL3ZEaS9hMzVvNENTZitt?=
 =?utf-8?B?aHhBbXhCSVA1MkJFVXJNR0ZZY1gxYWlrZTVmVW81a254NjU4ekg1SE9sUG5z?=
 =?utf-8?B?QmIrS1FRaFJyNkVUbGk1NjlkZFJxTWRtYUt1OFJ2cm15U3FkS3VtajhVcThl?=
 =?utf-8?B?c0pIWk1jcFlXcjc4Qlo1Z0txWGdPU05CeHZVck1SVFljalZod3Z0L0l6alk3?=
 =?utf-8?Q?k2WfJkjqmz4Gl2ng=3D?=
X-Exchange-RoutingPolicyChecked: lwgpe8Z0bxVShqYevSPxqK0SXaqaOcRyG9j3BxIdfAr6OcuoJjpUBA/nFzzUG3/TcD2qFeeDbl9dsUdYZsyaxVs/8uANolMlNmVVPcOYB3zCVHOW5wX6chxqMv6FwQ36Js0NCq2bucHc3i6iykEhtkH/LG/DWd8frbpuEJos3EEnpNUxZVR1I7nc7P2M7G5HoJJFyHqE5yVhMMBvTgIbk+ULXRBUyoPqxZRWXM0y3v0uTs9iRIujZL5F5j6jz1625ZM8UoBX1cuklBq3Ohf+M76vzm4FlJ8CptZAu+iZfSRx02fa0Rf74XUdSqis8LALvuUd59meGq7Z6F+jTbIEoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f5751d04-b32e-4a41-a5c3-08deaac338c4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:27:39.2939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BT+9Ucjueyt4iDvZC7F74rxoZUix+yMSKY0H4+qbue0wvCtvIfHwLUjaooZS1MMYj7puNyLHO9VVo4R95bYtO5CQEzzyk4b2xGxcVgJm+J8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7387
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: D16C14D1577
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20029-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[10]

From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Date: Mon,  4 May 2026 23:19:17 +0100

> mlx5_cmd_hws_packet_reformat_alloc() allocates
> MLX5_REFORMAT_TYPE_L2_TO_L3_TUNNEL objects from el2tol3tnl_pools with
> MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L3.
> 
> The deallocation path uses el2tol2tnl_pools with
> MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L2 instead. This releases the
> packet-reformat entry through the wrong pool, corrupting pool accounting
> and potentially moving the bulk entry onto the wrong pool list.
> 
> Use the matching L2-to-L3 tunnel pool and action type when releasing the
> object.
> 
> Fixes: aecd9d1020e3 ("net/mlx5: fs, add HWS packet reformat API function")
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks,
Olek

