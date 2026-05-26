Return-Path: <linux-rdma+bounces-21333-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKvrGBUTFmojhQcAu9opvQ
	(envelope-from <linux-rdma+bounces-21333-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 23:39:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF535DCD17
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 23:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E98A300FEDF
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 21:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A07D3C2797;
	Tue, 26 May 2026 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnBFAOir"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE153491C4;
	Tue, 26 May 2026 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831429; cv=fail; b=DNJp/utYGI7rlePHNpoTfhJIdAFF+E6hjFR1WrW5vVAUUupoTQpus/LQEHAkhmAOAuG8hL0LHm7wlQEeodL5O8o9om4BYkMI/G20ImQJM+8UjM+eToVOTXkq35VuIrtWyd8s/2UKYF6Or/ayPP5jwyKPhpMqH6FVtZCrlNchN4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831429; c=relaxed/simple;
	bh=EFDQ4aLv3BaRudtjlZMHsabpKt8E5Kf8RUio5jJG2xo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NfR39zLt4CLSHAayaQzUK9ARCTz/7TkC64I0jmtWxrIU3zjJQpuhCYOO6zqw1FqxNuz67GbTo68VVuiYWyTpDUHoPM97GavPahzzxLQGzItlImqj0yNuPkHWULh878ZBfCg7SARL5Y+P/VZB6l09Zq7PK9xwnPq8CnemJq7blq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnBFAOir; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779831428; x=1811367428;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EFDQ4aLv3BaRudtjlZMHsabpKt8E5Kf8RUio5jJG2xo=;
  b=WnBFAOirZk+8ZIepDXSJI8+JmFQyovyU7Y8t/J6cmk9taOqCj8s3f/jo
   zg3HZMpn0LYhJxH8ln1x6+2iAtTklZwTNdHmXXP7IjezMKJAd23FjKxvG
   CWrGVzqcCCDJPK90MAmuAcvUjFBq1iIQ5rcFwJNxUcjCFzEbBBNJfwcDS
   XjALK96n3qgfBPt6WjvwmzIPfWnRyq857lRFxJfUrdhDzHFRiFUqI4dCe
   uI4DdJ64yJBl0VprcAyLlWqUkuv5LaOG7bv/EBTzNeHEbF854lOS2ZxEK
   wuimlaW45zKAbpuE9M2UOYHyXhaoU1+JNJE2naiSRHMhz8j/GeJBCmxtw
   Q==;
X-CSE-ConnectionGUID: aCebsOULRHKadFRVeTZHkw==
X-CSE-MsgGUID: deMsOxmGTGyFOoEZ1Snklw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="92130215"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="92130215"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:37:07 -0700
X-CSE-ConnectionGUID: QdYy0Gw2TWCToxrnImmOdQ==
X-CSE-MsgGUID: NwrNNUsnTGKDSqpOS0WiYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="246991077"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:37:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 14:37:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 14:37:06 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 14:37:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzIkHzo+alLnfDGYCIZGuyW5VOzGQzZ2Ozf1XheUhWDAYsw1Jf3d693gyamkOhJZXjbjhrY1R4aA2yZz0jWKQwbxL3BEToSwOMtjtwuja7RoOEQh9AMzYR4Q/8UVLq8kok/MNDDJqlTF9+QfWGY1U/XnMbw1sgxwqzujLXmgKq/JJGCmXkdMXs7/PoPMsRq0ijYrR9nOrjE+RmZogK8Z6dN7hvK2J8JcDVw4w9oCMkoU70xMpXAcv6bJ6yZz4UFdL4toFcwOmGxAxthQwLySpWOl0Ibgeo9bi26+BhPWwrxmLVBGMErgMJtr8d5dOXNXKV8yGEOTc848BsC65MH4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yZPka27ZJ+fvD8KjVUrSsR5e8644bW4Otuloer+WNw=;
 b=b5WCCw7/1WgckXAfuYKcchyGtSQlykjFwpULw32nrnp77juJ46ugvdIf1dxVEMgwBoh06TC95KtU4Z17n1C+WS+CSxxb9dQ/HNYXC+DpwvE9vTOzb+rzCZVa5geQRpLuf+0h0g0ITw50GwZuUtNux5svKTpVb6h23ybUihFQIUL90qz/5JJlnIs11ywnfr9Ueek5EqyfnEtI8T9XPYuSBTtCogebwoOtwPqhgc5HPxjJJ/q69Im/VpDzx7R0jWvNP1ZTyUGSJdl472oIFoT+/3q2K85glxRFv2RI49OnkB+EGWkGOCRj/t4nZC8OsEyCg6aZPr8AFw05K8MglGQYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DM4PR11MB7349.namprd11.prod.outlook.com (2603:10b6:8:106::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 21:37:03 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 21:37:03 +0000
Message-ID: <079fdc7a-086d-4f99-a97a-b95cb19af322@intel.com>
Date: Tue, 26 May 2026 14:36:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/14] virtchnl: create 'include/linux/intel'
 and move necessary header files
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
CC: Larysa Zaremba <larysa.zaremba@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <sridhar.samudrala@intel.com>,
	<anjali.singhai@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
	<tatyana.e.nikolova@intel.com>, <krzysztof.czurylo@intel.com>,
	<jgg@ziepe.ca>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>, Samuel Salin
	<Samuel.salin@intel.com>, NXNE CNSE OSDT ITP Upstreaming
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, Jakub Kicinski <kuba@kernel.org>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
 <20260515224443.2772147-2-anthony.l.nguyen@intel.com>
 <20260520175201.72f83c4a@kernel.org>
 <ag7QUgfpM5UAAE2z@soc-5CG4396X81.clients.intel.com>
 <20260521065609.248c7009@kernel.org>
 <5426379b-1201-4707-8d18-21dca3d1424e@intel.com>
 <20260522084050.5ba31f38@kernel.org>
 <d3191a29-0ce8-4338-80b8-a49c53c1a472@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <d3191a29-0ce8-4338-80b8-a49c53c1a472@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:303:87::27) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DM4PR11MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 24482fb9-c4a8-4ee9-4416-08debb6eecc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uvErtOiVlqFx/Gc8mDj8a9eZPwreDBiv/HZHzqA+d+K4fVDa9PKub3OmXxckrxDCn+pa8T9HOq28D1kxkvUqUrLbxhVnpFs9vBPMvuVKK4zaZJCPtuQz2hugkm/1xqpVTr+D0LglL2S2gCnj0CsOb1yjfaHixUOn/lIS3LQd3NMamUlmSA166Y6TUT5zAGam2yfkOv5vs24sorYtrPklOTTjcYr8lBy3IwBxwq+pLg1jB4uZ+YcfTOYboPGcwzIW98bBv4uhqnSC03nITJ9FzD6Lb14toPLQyjFhE6dUNCCTupRu1K88MehuJc3PP4lx4Y1wb4NGNYHg06HJMnWkPrhkcrhIhvYe+q6RXOyevtpNCxWWQAmeQUC86MbAQsN51y7ZqzXXPA1c7RVd+9KhLaQEZqUCZYiYnSYzrB90sUrwRU2E3hr0nogLiNN5xsdgVxDADLNqHQa1gzeUVcXk42kmMSVf/pY8GSnU7kqLybpwOm6LTtvDwwCsauCFwuM/m8YZZcrQLaYxcTGAwk0R2FlWyXACeC53D8hmyhOESbBg9zLSnz+eSukUdYRFUipIy1x5gW2zuLHXslhhOrQO6h7vIEIuMD9Wf1+m6T827qWTotYYQag5J1Rol8a0JyYVJfY21bg+84uQrgkIwxjrsRRouvXzXUVyiHj7EuYnqAtJemnFaaDjXTTIMHes20rC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUgyeWVwOFVJcXZNS0RuNUxCMjI0MlpKNjQ0bi85TFA1cHpCUnpRTG9McUZ1?=
 =?utf-8?B?QTNiREhQYUFJVzNwVGkrd2o4LytEUlVlZENoSTR6RDhOTU9JaTg2ckV5Q0pJ?=
 =?utf-8?B?M0JMWDhHOENqUGZVUHhTcjBVT2JoZElIK3E1em44N2xjOUkzenpDeDlaZWI0?=
 =?utf-8?B?MDlaVjQ4QTJMZlFvM2FReXUwWXpDQTlhM1pZeWkvVWFLRGZRM3YwT3g2TkZj?=
 =?utf-8?B?TlNRcTVWTXdtZGJ3NFBOMm9ybEo4cSt1NFZRV3FqVjNsaFhPL0FpUGJWZ2pS?=
 =?utf-8?B?cGpSNk9Hd0cyRGNxTkwvTFM1WjUyRkhJUjI5cFlNTytIcUpWWGF0a2QveE1m?=
 =?utf-8?B?c0d2WHp4cm5CSCt2eHdkSEJCSU00TGpTdWVXYzV0K2xRcGl5OE94MW9vTExt?=
 =?utf-8?B?ZzJjM2YxVEJkNVJsVm4yYXVFNzA0N2JtdHJFN0NLTXYrK0tyOTBsSUZuN3JF?=
 =?utf-8?B?cCtiajhjalVpN3R6aUY3bVJTOUdybnZjb0l0Q1hEUzBiSTZmZW1ZZGVZaks4?=
 =?utf-8?B?U2trSkdnS3dhNWpzdzVoUDhzVzBQZ2NEeDNpcjVja3NpeEdVN0FJZzRudWdt?=
 =?utf-8?B?V0c2R0NWT0RjZi9TOGVTZVc2eXJhMjVTMmdiQlZJNU1mdGNBdWxTcHE1Y1BN?=
 =?utf-8?B?dWFaK2c3YXRvTXBXZ2tSL1pqYU55WmRjTGdJYTBGOExDSmpqS1N5MjdBSVYz?=
 =?utf-8?B?eEJ4UzR4a2l4dW84UkVnMFN4SnpNVGlSa0NhUC9zQUxJQmpaNnovUm1aUGEv?=
 =?utf-8?B?emRXWXNEV1BDZFVYQnpDK2tDaXlhSzd6ZXhQSWRnRjByaFlSYnF4ckZBMU9V?=
 =?utf-8?B?Ym5paHoxaDVaUGtxVEJkaitiYm05cDg5UWlFd2VMV09kRkZaUStsR0YvdjVG?=
 =?utf-8?B?RXhzcklidDBaOWh3NlNNMUFyMWxobUxEODN1ODJ0clpNWU8xbWVQcFo1bE5Z?=
 =?utf-8?B?cVRCb0p3RjROcmNDYWZvRGUyeldSZ2szSDJXTW9Va3VLUGlMQ2ZtVlk2K3VB?=
 =?utf-8?B?VUsvMkR2WGd3QmRDSFFkWVdZdk1oZGpIT2xCKzd3QWVYV2d6ZTlJaCtLZ0FT?=
 =?utf-8?B?SlJOSmwzK3NuT3Zmem5hZDFhK1JlT3hiSU9OdlVQRG92Ujh2QVV5RDVNQ0JL?=
 =?utf-8?B?a1EzWDFwWEc5V0JsK1R3ckUxL2Jxc2R0aGszYVJaSW9uNU9Oa2I4WTluQTdY?=
 =?utf-8?B?MWI0bURybmNoRnNlbmdQU2w5Zk95U0wwdCtzdFRJdHdOSUF0cFgranJPZzAv?=
 =?utf-8?B?a2xtbHNqWUtaQlZTZjdQa1RkcUNIaGJXRklVRTVTaVpjaVpUUWplalArd3R5?=
 =?utf-8?B?aTBsSGVORzBTOWVJMEgvYTdNSE5abFRYVVVEeDM1bE9KMUNrS0M0TEtEejRU?=
 =?utf-8?B?VnFmZnhVN3hzSDQrQkZkd3Fmc1d1RFptWXVJTTVhbWI1NThuR09BdXB3SVpt?=
 =?utf-8?B?dmRyZitZT0phY3BST3l1Y3lCUUVzbFZxVjB1VnFtV2MrN0I1MFIvczZSRFQr?=
 =?utf-8?B?aFFCSEtrRzQ5b2g3Y0d4bkZxTGcyZUJaY0VNeG5sOENuKzYwWG5yck5ZeDB1?=
 =?utf-8?B?enpGSVZDV0VUMjgxUVA2M2hqdnBHMUlzQ2g4SVRDTWdrTVZNV0RybHlxVlhU?=
 =?utf-8?B?b2E5YWNZNjU2L2VBYzYyOFNKSWVEWG16VmRXQWhWUWhZd0JMSUxTWGdkK2lt?=
 =?utf-8?B?U285NEtFSjJlb2xEdXl6UW1UalFhd3lOSXVONzhwRVYyTk53NTZTOG5SWXBU?=
 =?utf-8?B?LzRxZ0Z3NWRVZnlpc01pdmFDUEU4K1BYTmtuSUd6dS90WWUxTnNKdWtyMktV?=
 =?utf-8?B?NzFrbXdmRkNPYzNwUDJnMDlrOEtYNVArbXJTakgwN04yLzluK2tIQXZxZXkx?=
 =?utf-8?B?SU10REZEYWg1aDhSd05iVHM2emU0UTRrSndmUXF6dVZ6ZWRHYy8zeW9saFpq?=
 =?utf-8?B?U1FLTSthanlKVklsU1FaTnNyR281TktZK0dFWDA2Tkdpa3FzMEFYQzdETXU2?=
 =?utf-8?B?TFEwTGkyN01Pd1h5bTcvTS9rTDlFcHpweERLMSthWU9SWisvWUU5MjR1d3ly?=
 =?utf-8?B?aUxyMHdRTlhDcUtRUWFqd3hJejRMNXByRTllZHRudGtkTVZpL2pHMHlkeCs2?=
 =?utf-8?B?aXBoYjNKMXA1VGR5d3hjNExET3dBOGlrLzZHSVhkd3RxazBoVDZEVVVzNGs0?=
 =?utf-8?B?QVd4T3YwRkFHSzZVWVNLMnUzdkpHTkk3T2ZCd0VZVTdPSW5FaGhvMnNwWVl0?=
 =?utf-8?B?OUZDS3I4OGE2d2hVMXUySlVHejd2RkcrV3czdlZsV0N5WnhSTDh3ckwvdkxU?=
 =?utf-8?B?NGFGMktORVZvTWZuVXllV1h2dnJQdHF2MFo2VHhsclUwcmZ2QmhXUT09?=
X-Exchange-RoutingPolicyChecked: eMaysa87+msFIC0wK44U73KnGCO2pGD3T5cnu9O1UCbwnz/dOSgXCraxoyBSFrrbNNPaDYe7QUTYcBLqkqINDNmlYNrDHWXM5HxHDOYUoic9UMDIwMyGjhU2V2+NI4HZbaMF0s7a8JcV81WfkBVPMvaTmeXiRPUJZL9rRQbDFuopoNHd5HBt6K258ETOKWVLynZA44MbGmSt1H62TOZK2eXpAD8nKKB2lOKl/D9uNtALlhfDKN1/31z8cwEGF/NyroPhJe5JpiwGv0Mc+Fcc36D8MkOOcJI/Z7KTjxNo7r77kmWAa0lfu7s6/NT+IsYbNxrMnAvyaQLKDLflJe6U/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 24482fb9-c4a8-4ee9-4416-08debb6eecc8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 21:37:02.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkVlMn4ePFjI4oPIIByReUMw2zrxHscA036+OsgKOES2TiCwzofgWhJDwtwYhV93R0Q9NCB0UiNLkY+u013hyBTfLAQJsiza/V/sMLritHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7349
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21333-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BAF535DCD17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/2026 7:45 AM, Alexander Lobakin wrote:
> Re review score -- I noticed that as well and have been focusing on
> reviews more than sending patches, *but*:
> 
> To Aleksandr:
> 
> Please *stop* spamming IWL/netdev with patches. This doesn't help at all.
> Or at least do minimum 1 review per each patch you send.
> 

+1. I was actually thinking about some sort of limit on outstanding
patches/series in the Intel Wired LAN patchwork. I was noticing that we
have a lot of minor cleanups sitting in IWL queue for months while I was
covering for Tony.

> The imbalance you (not only, but mostly) create will only lead to that
> we won't be able to send anything at all.
> 
> To you and sorta everyone from Intel:
> 
> Please focus more on reviews and wait with sending stuff until Intel is
> back to the top 10 reviewers and has at least +/- neutral score.
> 

I know I've been a bit lacking in review last few months, with a lot on
my plate. I'm hoping to improve over the next release.

> Most of stuff coming from Intel right now is not critical for customers
> and users, by doing that you paralyze really important series.
> 
> Thanks,
> Olek


