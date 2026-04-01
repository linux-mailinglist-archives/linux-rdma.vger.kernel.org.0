Return-Path: <linux-rdma+bounces-18923-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMRZE0B+zWnqeAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18923-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 22:21:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC1138018F
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 22:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E364B304ADBE
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 20:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A773630AD;
	Wed,  1 Apr 2026 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yl/z8EI3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE133D6C0;
	Wed,  1 Apr 2026 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074705; cv=fail; b=sZKHIn2/4ru2T4gtbggQbUSvwIaFaDDRpAwqt8kkZ6bM0xutwCWB4C4haJo0arJvavJLPRFMoTuuuNH3Q6GYcYKgsnp7Fn65pC8A267hyb3ibL0bmnhZgelQiasTj+eUFEsESX2QBBJ005Ijd8g2t2tvjWID7A+eiQeRNX3gTBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074705; c=relaxed/simple;
	bh=s/akJPQ0YSZrzNs8mdetcgGfs3/SUh6R2YPmw1w/ro4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cBU9PXfQo/Hnwy1CWANJH/TGCt7U0T3EsulkE4tsnG1jwj3sKmsUNjZxNeQkwc28UcE5or1ma6ExVlEdwvoExkjlWLOkhLyuNoaE6X/2rSJEKHOa4/r1gme79JYf0T7vMTVA4GsVo/sXdLjJbeJ6TFEcg4MoIIMyfLqJ6DaokW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yl/z8EI3; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775074703; x=1806610703;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s/akJPQ0YSZrzNs8mdetcgGfs3/SUh6R2YPmw1w/ro4=;
  b=Yl/z8EI3i+BcV/KbzpRTmMJ4NzfdzQzk4XDy28eCfGVqZWsQkAx/rBX+
   1vYhYZNhu7bzmfAl377W+/xEzZbWpmqMYenetA0lCeqeokFApdqI0cbCV
   ibxlPB8tBRiP9BJeZWYkJyKjiccP3QSXGk6ibLqho4X5xFfHOIlgbNEcv
   cWZ4j+MLUAvMb+Msm3+UE6q90WZxTTtUG4nKH0HI+71FDeIlMX3lfmBGw
   LXF9ZGi5lldMwYvPLAupksyIl9ydkdZUBSvswmLj7m3qayuBGexELl+0r
   tww6+QyaBAHYGj3ywIbKmLz5YxgKHEqC/CIHPUtPJoCzqyZ2RSf4DYEw1
   Q==;
X-CSE-ConnectionGUID: DttnrKoTTM+fsB+FPDRQ5g==
X-CSE-MsgGUID: gXZZB2rhT8eEzAtvxH+48Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76008313"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76008313"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 13:18:22 -0700
X-CSE-ConnectionGUID: QHbGBTReQJKYdfVswznNkA==
X-CSE-MsgGUID: vFbv9/1SQZWFsPF8NZwjCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="249827046"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 13:18:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 13:18:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 13:18:19 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 13:18:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ga8IYKIfgbMNBP2kq5kT//RbmkSNpdvafJU60KBlgHYtA+GGxUO1z9ojdhsEBfjJwoB4VnweMnynNufDCRHm7wTUtR/Se/vKrFLEPg3EQ8odf7dZAcDad0XddzFwbCZqEDbNp7QfiPOYoafPF0rNkpwL8agXUuHAxbcspRZ3BTdx3V/w9s8vRsqJfaUYzH5o6uDKbCs3FRDUbCMhL+tRVZXEEsmqe5PkfVrtQgehn4hx9OmfJPrvxj0WMENoYTk1iOH1kL2UqR6+pqbXlT5ZZsHYwWfzWQmT6STKUL3bYYEmFpIhr4bS7MLwa/9nyiRQo298j8o/fX/S1O8N15VxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6xKOT9ffm9iMZiCMG+gANZLy/nhEFzDiODPLdiH2p8=;
 b=nZSKMtBdsBRb5js/LkfPkU9RmK2ek+/ATpeEOK01B/oddH8B0HMCUqnopANH8qoEDmhUiCvY6Qi5TDcSeClHbxhpJ/LGNRYRyYMtZUpJb5eeWBKBWLImJ43p4rmEF3AqCURxalDQCIn0B4Fjzf809uE4mJPCQLLH6Wp7qO8e0UrBiEDFK+n3+1pR5/2XZ6qGVRuPVQGKJcyYCVs6M4UZnufAMm3btngZeuE+MGAsHzLBu4uUzCKWkzYrSJLEmrhows8v1PqVXLsBUSpXhXud1YFMXi6TZ2ujKtoqlLCH4KZy6oUGKE6oV5gnGJ0npoDmGvxaytKD4DiLsLMdp0i6Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 SN7PR11MB7138.namprd11.prod.outlook.com (2603:10b6:806:2a1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.16; Wed, 1 Apr 2026 20:18:07 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 20:18:06 +0000
Message-ID: <71223320-4dde-4731-b3c1-9a2763259958@intel.com>
Date: Wed, 1 Apr 2026 13:18:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V9 02/14] devlink: Add helpers to lock nested-in
 instances
To: Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>
CC: "allison.henderson@oracle.com" <allison.henderson@oracle.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, Moshe Shemesh <moshe@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "daniel.zahka@gmail.com"
	<daniel.zahka@gmail.com>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"matttbe@kernel.org" <matttbe@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, Parav Pandit
	<parav@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>, "razor@blackwall.org"
	<razor@blackwall.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"willemb@google.com" <willemb@google.com>, Jiri Pirko <jiri@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>, Dan Jurgens
	<danielj@nvidia.com>, "leon@kernel.org" <leon@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	Saeed Mahameed <saeedm@nvidia.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, Mark Bloch
	<mbloch@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Nimrod Oren <noren@nvidia.com>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "minhquangbui99@gmail.com"
	<minhquangbui99@gmail.com>, "dw@davidwei.uk" <dw@davidwei.uk>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, Petr Machata
	<petrm@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
	"antonio@openvpn.net" <antonio@openvpn.net>, "mst@redhat.com"
	<mst@redhat.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Shay Drori <shayd@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>, Gal Pressman <gal@nvidia.com>, "joe@dama.to"
	<joe@dama.to>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20260326065949.44058-3-tariqt@nvidia.com>
 <20260331020807.3524811-1-kuba@kernel.org>
 <ff5b2ec46d6cb639872318bdde429c46cac77f5b.camel@nvidia.com>
 <c547be19-adaf-4442-be2b-debcbafa4191@intel.com>
 <4fcbf36799b5bfd5c0b68b0127f4f67aef00fdde.camel@nvidia.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <4fcbf36799b5bfd5c0b68b0127f4f67aef00fdde.camel@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::16) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|SN7PR11MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be45bb6-c707-451c-d8d6-08de902bc930
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: E1QFITfnOjdPReVR9o909PDuXXHe4UuSvKKwObXyxcU8dB7pzPU6+8DvjwZ1bf4smx8UPRBAPGDVehQmGc7kwPh4MNw4DZOVJ3+xSVHDBQq/PDrAdGXEYf08jXPx8isijCuvVlF2COw68V7ndQqGRahRZOyduxkw3sCrtKqfUIapiBvO3ainkKH29nMJHqw2x9Bte9ZvWbeSpkDqcU1dLX6waV8utH6JHB1zcvPQmcsKuEbnCWUCpFLMpsBJoV/R7lhmKlyu8a2UBHEAIOSiKnYmlmU3zNFGZ/erRdF7sMGHG7J8ganvc7Tsv/PPuhhZ0tIJHf1NIuRbFdAFm0fu7YRzyi19c3RHORmsprzvFDEK7TtCzDON6eVeJYv3503IV5Q62/Goq1+be8s6jl0eEssBaBhFBtDnom7qdBc35XrZOQ/qtwmwE+Uuhi4TSpnVLgIe4ccQH+PbXKcaYwbW6hDzGYW/m87HArB1afue/EcKpwE4hEub1qv42YaCYZZKQ235+7Ovx5JXW+FIu0aOP+prMyEsUk9BWfneSD9fG1xqiobMzD5xiiijGFPzYDufDytEiEK/gAUVt4JH42XvOjFvl8xyrBYK5WSKFer8zKvxHWQN9kvaOeh1OReE9TyrozEVvFSwysk6gPn6FVyeS3zvb96wN+6WrcaDzUxoXBYIIOO9vRph//8JnDU5QlX2O5ICxwPnRRuB3ao4xyGQB+saZT5urE98koE6LtzjWU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUtSUHJuOWRHd21pUmlkazJoaFc1NzQzdWhhaXJiME84Z1Y5bTNKNVJnUnNV?=
 =?utf-8?B?MTJ2bTFLSG16dzBKREhRU1hISm1PanNibkRwektLMTBCZjJnUVMrZnI2OGpm?=
 =?utf-8?B?MTlDTy85SCtWcDhrMzR0UHdmQlVwRkJlWStPQnV5WkdTUjBZZTJVcFNSb3l3?=
 =?utf-8?B?dFBWN1NhWEVqdUhTbG8yYVNZSVE4VnZBdFNWVnlmR29kNmc0V3JtVzRmaEtE?=
 =?utf-8?B?Z2ZzSkRvdWlOL0VSTnE3R0JSQUc4WXBvUzkzSE0zbHNDY3N5MG9xZnpiRFY3?=
 =?utf-8?B?aWUvc0l1YjZ6QnFLcnFKMlJTM00xL1FhcUU5NmdSWWZuTWdrdFlhSzZBUFBr?=
 =?utf-8?B?cGRqU0RTK2JJVnQ2MS9zZFo4ajNjNWlYMlJXeGNtKzRPN2tIbWR4am1ZSmdq?=
 =?utf-8?B?cnRGcjArcXpDNFY3UDNVTzlJQnRQenNZUE45MWUrMjVYZ0ZGbDY2S0xJT2pG?=
 =?utf-8?B?bVg1OFR5S3pFZFV5YUNSWHBwS1VCOUtJVUJPM05MMXdTamIxSHFmSmlnaFpW?=
 =?utf-8?B?a3lqS1lxVjdoNDg5V1kyWXN0N0p4a0lDdEtNQVlFMUxlb2d1T0l1cWU5c01Y?=
 =?utf-8?B?enRpQ1RWemtMcCtnQ2VaVU5XTG9qdXU4UjBqcGtDMEdQSVRwTjluZTlabE13?=
 =?utf-8?B?RDIvVEpaRXlnSGJVZHpzK1VrKzNwSzNWcWFRZk5VT1lremVRZHZ2V00zWUZK?=
 =?utf-8?B?WERxMlFxaDdSbXpWSGNlemM1aWFyalNwSXFuU1FIRnoweWE0V2lPbDV2enJk?=
 =?utf-8?B?Q3VWdDZuT0VEdi9tQUUzSHRhc051T1F5UFlaS3RDMFNGSkI4cmZEc0N5U0Jz?=
 =?utf-8?B?eW5OQmk4d2l0bkk0b3cxSWEwOW9oYVFDRHk1T3F2M05WWXNmdmYyV1FjQmxy?=
 =?utf-8?B?SFAvRXNpTlFUby9BVVprZ0ROSGxrQ3Q3YnhIZk5TS0Z2UktydlBYNGZIR3Fk?=
 =?utf-8?B?TUNpeHlMYUduNVF0d0dTTi9aV3ZRekZRNTdqQjk2N3dMem5ZcUd4S01FT1hq?=
 =?utf-8?B?VGZMbStjeFgyeVRiT2w3S0NINm5CL0JKbzkvMUlTSkdOQ0h2cmEvVDlRZThY?=
 =?utf-8?B?MW9BN3IxY01sWk94WG45YnNwRzRuMjZiYkt5RnVwNXhrcFNPZExJRXh1QjhV?=
 =?utf-8?B?QWFSVlU1UGRxcTkxcWVibnhZVUkwQTJJK253VFFuL3oveUVMMzAzdUNwdTBU?=
 =?utf-8?B?cjdWMzBrQ0xWdXl6Wlh6TjBjUmQ1RlF3WTJhUm9nenpVamRjQ2hWOFlYN2VE?=
 =?utf-8?B?NFZ1RFd3N25oNnpwSlJ1RWswRmtIR1NaVnBGTkRsSEZTa2tRTk9GcTJIQlFS?=
 =?utf-8?B?dGp4eXdzNmx2c3l0aDY0bG82V3V0emlPMW5HdFJJMHJFcTBQZTFodkZkOEtW?=
 =?utf-8?B?dU44Rlk2Z2pNWlN4UnQ0bFZMNHNyUWhRRmhPYmxGY2Evc3cwd0tVb3o3SDdO?=
 =?utf-8?B?VDNmQ0VkM0E0dzZEdWJ4VkFEdEUxcVdmZnEveGhrSUJwTUEwcDNSM1hkc0JX?=
 =?utf-8?B?WXh0RlJROEhXc2VYWDljL0wvQmJnUzdNQmlrVUpJWkdvUmZCbkQ3NEwyMFh3?=
 =?utf-8?B?OW9jQ0JJNWZoR1BYRlQrWEVWcXA2cEU1U05tSTVWZzJZdjdnK3VCby9ueWJX?=
 =?utf-8?B?RXliWVlLeVh3blc0MzVicjhTTXdhSG5TZmRZM2F5SHJtTStJU3NQeWlwTjVx?=
 =?utf-8?B?bTlPOXBzNjRqRkxlR3ZHQjZaYXA2QVVqVWxKbncvKzdkYnhXdE1jeTZYZkJ0?=
 =?utf-8?B?NldxZkxPV0lQSFpudVA5dms0SUtwRyt5QWhQUis3V3M2US9jejM2eXl0QTFn?=
 =?utf-8?B?dnU1LzJrM2lWdURaNHl1NFYrSWc3UmhCMU1ULzJEaGdiUFVpaDJCZ1RINXAr?=
 =?utf-8?B?OFZHY3RSUzZLSVh3YzNUZURwc1lKbEFlQ1pRMWttaXVhaDE5SG5aVkNjaEo3?=
 =?utf-8?B?UzhaMnFWTFJGc0pOMy9IaTNwWlMrMHNpNWVjN25FM1pKNTNpOFJEUnlLL1JO?=
 =?utf-8?B?VlFCbndMd1VSckJxcXhOQUpYZkRMRWY2QTRwQ0dhcytwOVZWR204N2F4MlUx?=
 =?utf-8?B?MUFRMW5HNXdUVURqMTZuaEZIeGtjRG1NVzVqTUhLMkxSVVQ5WlZRS1dVMGhm?=
 =?utf-8?B?SWJkdW90em1YNTRNbkpia2ErS1VHdDVvL2tZak1ldTMzaloxV2tzYUttU2dS?=
 =?utf-8?B?U3k5dHFWU2ZNdG5lUGxmK3htMjBqdzFVMlJTd3dra0xoY2V0dFZ5WVBSaVNh?=
 =?utf-8?B?NXJrQ2hDWVlIMllBb0NUUFMzdWxWeHB3dXVqNkorZi9iYUc0MTU2SEdMMHdE?=
 =?utf-8?B?a25hWmNndjd1cCthYnJHVjhUa3pqT0x0WkNPcFIrOWJyREQ1YjRZUFRzM2Jj?=
 =?utf-8?Q?5m6eTYt1QXhWRU3M=3D?=
X-Exchange-RoutingPolicyChecked: a+TW2BOccFUUH+rezFp2U1/4/LZ7UpaYARjewKhlBYOmxjcZwqdZMepaNEfWOV72rqtnJjOOJVGOroPKG6tOilXumRhXQkWZZs+nht++TSo4RSqA2or1f1baQOrkJ2RPgzBDgpLuQrLwpZHLiGuOHjpvn9gjhoioXDqPlITW5p7JrmvnNk1p9Vqq7QMmxmnUC5gAU8FJJsszQtxwGxwng/RyEHcguSjsrQixRDSs5EJQC1yVrjBndvxQhwpo145Z//Zpenfex3zQ35L0FHp2NspAMKP/FOlo1RDJ1tVudtweFO25PEM7GdGgqbCNE6Zzkir64haX1tyCUXk0BBu8ew==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be45bb6-c707-451c-d8d6-08de902bc930
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 20:18:06.8660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kw8sBKb3YxLgFeHz/MODObB48fp3UomltDLUuhZzlcKYux15/Wybap5Trl5DVWZhhzcWLYLCwTkEmQ2rCQySGf28oQajRXvP72V11g1uIcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7138
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[48];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18923-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[oracle.com,resnulli.us,nvidia.com,davemloft.net,gmail.com,vger.kernel.org,kernel.org,redhat.com,lwn.net,blackwall.org,google.com,linux.dev,lunn.ch,iogearbox.net,davidwei.uk,linuxfoundation.org,openvpn.net,fomichev.me,dama.to];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DDC1138018F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/2026 3:22 AM, Cosmin Ratiu wrote:
> On Tue, 2026-03-31 at 16:55 -0700, Jacob Keller wrote:
>> On 3/31/2026 5:20 AM, Cosmin Ratiu wrote:
>>> On Mon, 2026-03-30 at 19:08 -0700, Jakub Kicinski wrote:
>>>> This is an AI-generated review of your patch. The human sending
>>>> this
>>>> email has considered the AI review valid, or at least plausible.
>>>> ---
>>>> devlink: Add helpers to lock nested-in instances
>>>>
>>>> Upcoming code will need to obtain a reference to locked nested-in
>>>> devlink instances. Add helpers to lock, obtain an already locked
>>>> reference and unlock/unref the nested-in instance.
>>>>
>>>>> diff --git a/net/devlink/core.c b/net/devlink/core.c
>>>>> index eeb6a71f5f56e..db11248df7120 100644
>>>>> --- a/net/devlink/core.c
>>>>> +++ b/net/devlink/core.c
>>>>
>>>> [ ... ]
>>>>
>>>>> +/* Returns the nested in devlink object and validates its lock
>>>>> is
>>>>> held. */
>>>>> +struct devlink *devlink_nested_in_get_locked(struct
>>>>> devlink_rel
>>>>> *rel)
>>>>> +{
>>>>> +	struct devlink *devlink;
>>>>> +	unsigned long index;
>>>>> +
>>>>> +	if (!rel)
>>>>> +		return NULL;
>>>>> +	index = rel->nested_in.devlink_index;
>>>>> +	devlink = xa_find(&devlinks, &index, index,
>>>>> DEVLINK_REGISTERED);
>>>>> +	if (devlink)
>>>>> +		devl_assert_locked(devlink);
>>>>
>>>> Can this dereference a freed pointer if the lock is not actually
>>>> held?
>>>>
>>>> xa_find() acquires and releases the RCU read lock internally.
>>>> When it
>>>> returns,
>>>> the devlink pointer is no longer protected by RCU or a reference
>>>> count.
>>>>
>>>> If a caller invokes this helper without holding the devlink lock
>>>> (which is the
>>>> exact scenario the assertion is designed to detect), another
>>>> thread
>>>> could
>>>> concurrently unregister and free the devlink.
>>>>
>>>> If the RCU grace period expires before the assertion executes,
>>>> devl_assert_locked() would dereference freed memory. Should the
>>>> lookup and
>>>> assertion be enclosed within an explicit rcu_read_lock() block to
>>>> safely
>>>> assert the lock?
>>>
>>> This function is meant to be invoked by callers already holding all
>>> locks from a given instance up the nesting tree. Calling it outside
>>> this context could indeed lead to a race as described, where
>>> another
>>> entity unregisters a devlink about-to-be-asserted on.
>>>
>>
>> Hmm. I'm struggling to follow this. If you already expect the parent
>> to
>> hold the nested devlink's lock, it must have a pointer to this
>> devlink
>> instance. In that case, why would you even need
>> devlink_nested_in_get_locked in the first place?
> 
> After some more intense staring, I realized that intermediate instances
> don't actually need to be locked, only the ancestor needs to. With that
> in mind, the code get simplified:
> - devlink_nested_in_get_locked and devlink_nested_in_put_unlock can be
> removed.
> - recursive unlocking in devl_rate_unlock is gone.
> 
That seems like it would be better, as long as we can prove correctness
of every access. Thanks!

-Jake

