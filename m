Return-Path: <linux-rdma+bounces-19724-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHQXKYDO8WlrkgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19724-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 11:25:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C630491D69
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 11:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07E2B3031AFA
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96A33BED42;
	Wed, 29 Apr 2026 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YuZIFRnX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0783BE62A;
	Wed, 29 Apr 2026 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454423; cv=fail; b=Y/wP5SiH7pl5xkDA/QpU3lkUGkdnH9YSjh1FXNuCeJWZvKFLAgbFWiHgyF2cxB5qATfncpo9RGHmgylhBbHattNatJiS7trngdah0/ZT+xntHmhrvY54E66M0s3oC2w1YsbdKbh/kae+ggAutTvbaPXUC77yzxP9IFzSwVIrrjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454423; c=relaxed/simple;
	bh=wzfIv71eN7a6m7j1q7rPMBCfjKUCimXHoWZkX4EMv7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nGYl8oY3+4GNlCDeq8ra4IjxFlv6HU9H54jtdtMNemwcPGTo+2vVKIX5ylTZDTtVHVVFQG64NOy8tGOvXrAnYqcmpwOjjRZN0y9IgiaY5/TqoePWL6HVjgBuBnvzVeXTs695k+8IGZPa7KIXcPd2I6bQzErEMx7EbOLvjN6yFS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YuZIFRnX; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777454422; x=1808990422;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wzfIv71eN7a6m7j1q7rPMBCfjKUCimXHoWZkX4EMv7I=;
  b=YuZIFRnXGS/8HPPOtRtJ7s+d6aj3a3QCJ5IR2n0WI7d8x53hSKREcxWn
   H1e4Vwwu7PrYAEfJw/6UjWU931+GY0UkdrPXPlOzCmDkEhh6nivumA5gf
   Hqd6hJ6pBoHjcLCTYXr4Kb5Px1bJic5KyUurMIWl5/6HyVo4zrNBAKmOw
   m+UJqw+f/2ZLlPkfvU+PU2ZCwzGtR7AGFg8qUzXixa17k8LcDf53dCCmI
   1vS14AsJIVsEpNFIUwkyOr3RN6xw6G8XRlrCBYMmmypVRtmGaJ9MYd8wz
   fJFe2qQwDCjnHPWgQHetnCG5Ec9DODIfoJOKuR1pwjI2V+LcGMsvMbjUG
   g==;
X-CSE-ConnectionGUID: vB3IVy0jSR+PdBXVzJMEcQ==
X-CSE-MsgGUID: UIyHO0ASRV+ZYTj76wb2oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78489807"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="78489807"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:20:19 -0700
X-CSE-ConnectionGUID: fJO2qXc1TiC6H9J3/ZkLuA==
X-CSE-MsgGUID: q2sH5kANRa2vVSGLvrpA4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="227706890"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:19:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 02:19:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 02:19:58 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 02:19:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INU2rCe+N8iiyhEXaxBev4qCLYb1mxRAgDIlhkYAeA5xdrZ1l1ZAPVxrq1kL5uB8IeYfjQTDRhVWXtrghUX5Bz+skZRNBQsLBBxc352l/tcTC6+V4hrN0LoiAix4ILGlu+zLiu2KPXqcVqjNktbLJuxbPIBvrMOGKoXTMMDFmUWdwKpIiZ0p8KLf7O1ZeUORXh04K6axpj7dHo7FKsliSA4wXKkt9C8En2Inp5NKTq6Uk9fTb9B1WpYCGju3Lu3lroMC3KQT5QpDYU9AyjUW0tnLqrcsgpI409H0+fsSdsxHSeuVrwY9wtDYQZrigVH8xs0q+xhN323kCKYL2Y1ojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzfIv71eN7a6m7j1q7rPMBCfjKUCimXHoWZkX4EMv7I=;
 b=iQdBoHYheDv5T2XME4HouYRGUGgNyjbeSe5QCttyiyzl36ds/mX/7joLdM17IjdBAbp5uTK0QqZv4Sn8ghEPrPLkh1sWWMuaMRHT6YMJI9N54yC4eZ3H2RB3jTjk/fpExyIfxl1c3vc5mE9+a6jCCeKLS6jQx1LBd5KQgxVCmZZ6UlGJ+2J8Idq93Yx/1dHnpD+wzk/JMl0e9SLipcfS3E4gidRlInFwmctdvsW89FlbvHGn4niTie1BSL8mtIDX/OORJ1UjeZ+Zthg8jxsMW5cuMnl+jCXT6aZemIbegxVWAXiIN2QkUy9ZckMe3nXgwQec/OQJ8I7to4XcmbThGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 09:19:55 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 09:19:55 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
	<u.kleine-koenig@baylibre.com>, Michael Grzeschik
	<m.grzeschik@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>,
	Krzysztof Halasa <khc@pm.waw.pl>, Johannes Berg <johannes@sipsolutions.net>
CC: Richard Cochran <richardcochran@gmail.com>, Yonglong Liu
	<liuyonglong@huawei.com>, Kees Cook <kees@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Zaremba,
 Larysa" <larysa.zaremba@intel.com>, "brcm80211@lists.linux.dev"
	<brcm80211@lists.linux.dev>, Daniele Venzano <venza@brownhat.org>,
	"oss-drivers@corigine.com" <oss-drivers@corigine.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, MD Danish Anwar <danishanwar@ti.com>, "Samuel
 Chessman" <chessman@tux.org>, Fan Gong <gongfan1@huawei.com>, "Marco
 Crivellari" <marco.crivellari@suse.com>, Kevin Curtis
	<kevin.curtis@farsite.co.uk>, Ingo Molnar <mingo@kernel.org>, Ion Badulescu
	<ionut@badula.org>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, Colin Ian King <colin.i.king@gmail.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Peiyang Wang
	<wangpeiyang1@huawei.com>, Thomas Fourier <fourier.thomas@gmail.com>, "Sai
 Krishna" <saikrishnag@marvell.com>, Denis Kirjanov <kirjanov@gmail.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "Keller, Jacob
 E" <jacob.e.keller@intel.com>, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Steffen Klassert <klassert@kernel.org>, Stanislav Yakovlev
	<stas.yakovlev@gmail.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>, Jiri Pirko <jiri@resnulli.us>, Philipp Stanner
	<phasta@kernel.org>, Chi-hsien Lin <chi-hsien.lin@cypress.com>, Ido Schimmel
	<idosch@nvidia.com>, Potnuri Bharat Teja <bharat@chelsio.com>, Double Lo
	<double.lo@cypress.com>, Markus Schneider-Pargmann <msp@baylibre.com>, Nathan
 Chancellor <nathan@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>, Cai
 Huoqing <cai.huoqing@linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, Zilin
 Guan <zilin@seu.edu.cn>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Yibo Dong <dong100@mucse.com>, Joe Damato
	<joe@dama.to>, Petr Machata <petrm@nvidia.com>, Kory Maincent
	<kory.maincent@bootlin.com>, "brcm80211-dev-list.pdl@broadcom.com"
	<brcm80211-dev-list.pdl@broadcom.com>, "GR-Linux-NIC-Dev@marvell.com"
	<GR-Linux-NIC-Dev@marvell.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Manish Chopra <manishc@marvell.com>, Denis Benato <benato.denis96@gmail.com>,
	Rasesh Mody <rmody@marvell.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Mark Bloch
	<mbloch@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Jian Shen
	<shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>, Yeounsu Moon
	<yyyynoom@gmail.com>, Thomas Gleixner <tglx@kernel.org>, Simon Horman
	<horms@kernel.org>, Yicong Hui <yiconghui@gmail.com>, Mark Einon
	<mark.einon@gmail.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Sudarsana Kalluru <skalluru@marvell.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next] net: Consistently define
 pci_device_ids using named initializers
Thread-Topic: [Intel-wired-lan] [PATCH net-next] net: Consistently define
 pci_device_ids using named initializers
Thread-Index: AQHc1zMQAKJ/Vudce0mULqlYLnCnGbX1xA9g
Date: Wed, 29 Apr 2026 09:19:55 +0000
Message-ID: <IA3PR11MB89861D0A2ADD6A857708B0C9E5342@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL1PR11MB5303:EE_
x-ms-office365-filtering-correlation-id: b534d277-fb4f-4519-4491-08dea5d07a3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: dcVuEUzjOqDQZ4WnfWr+4TTLkgtPC5WXbIv45bkfZC21sTzVUq/sf793/0/d4LDcPSE8BrfDKFfn7AU3yiDLRqt6mcIcDBPC0IlUTWCBoup/O6ski+EsvEoCMfAqrD4+4lM3Xq1ayM4v70PYvhDtf1DjhALWf9fBttKVHr40x4nhNV8nkcWv+5O2QcC4EyZ7slHGMaSMgrXG5D4OrpjZcP5ouSgcwe3KmqZYUdwkbCScR1mjcwnkx+TGWYP+XS+kN80/o7jQ9v3e/V0SBAd154ZZnNzQEzGsPuClM4sPobu8H2kPthWVY93kKqinbIsej9kf1dz8k58OxgcfgFe06eHA6cmWFwk5wugO/4ArIKHyL1U32dMH1olGwVDKK6MJ51nJPyZbwetumqw0XgNHbU8qnH/wgPrDqixSEe7tMLoSLGIM5sZVyi3UiaMytgxKQITnCoYgvvEsdXvqFUqb+78/ExsFnHbG9G7LrPfL71lOg79fGocq7A8QsN/e8jYakdIxFxcvk5gmAyv3RWo7/BgWRemXx0vJBVqE0GjveAJL62v6Jdty94ncGQOvInJFXKXoVIifSFIi7xuWpIMZnw+DKXuP4eCXOauka5ODnKe3UqfCvzgLqznrh9bL1j84D6tA319iTJ0SsN66N1qMq4hrK1jgnuamVE27mFEEpLRFMss14GJ+eC6g0Smm+tWL6G5QEDvgKhnVROVBf1vM5VqN3NvYqGBDA2h40QQEdyHR3aXxsxv854LDpwtnXOIXpDpUpWClKNN1vMbHz2zP9rgjGhJt7ChKiogHV0xZ05U2dSV0mZGSQFU7dS51qeil
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1I1RDdFVncwRHdDM1dJVFlENlIrZTM4cldsU0VXYkZWZ1BMZEdadHJKQldo?=
 =?utf-8?B?Slhnd05LMUVTQ3M3U2FjU1NPNzR1djZKY3A5QXRxRElXYjdDS3ZZa1UzUXJq?=
 =?utf-8?B?Qk5ZbXhiWXkvckFZM3hUQ0xyV3Z0bEFCYUk0SWZMV1JxVlY4SFVlL0liamxt?=
 =?utf-8?B?L2Q0N0RnOTJkZmFvbWd2QWFkazdXWm9ScHI5dWdmQVZvdEdsNlBnMVZXU1lh?=
 =?utf-8?B?N1RtTkVvbWphd2xJNjZwUXgrSXdqSU1XK3ZPdjc4b0RlNXZjY3VkY09XOHV4?=
 =?utf-8?B?SDdPdS9HZEl2bUZXNlJ6Z2UrbC9QVEoycTVVLzFNQ0NHL0JReStTdVo5UWxZ?=
 =?utf-8?B?YTMyRlRsWXRHbkdDaXAzaXdHYzdLZHBwN0MreTkwRmhmRElXeFZ2ejRWZ3RV?=
 =?utf-8?B?emFUOTdrUFgxZUk3UG5CTHBNNDhtSXhYUktaSEdNaGNGYUVzMytLb1pVejE1?=
 =?utf-8?B?dlpqcHJ2N2l1aytVZ0dYaEw5blprczg1WGVzSjZsZXBKOXRobktUNlZmSCtV?=
 =?utf-8?B?OHBWbnpYOXNqa0pEMVF2bWlaNHhNTUVGcjRpNC9yUHNqclVlMjBBazVsUXdZ?=
 =?utf-8?B?LzRKNmNPL05Hd3VFdWFyakFyNEFjM3NTRWFUbGtlUUV5ckJVWWMvWGFiQWNo?=
 =?utf-8?B?T3QwMzhpbmovYjl6bUI1N2JyUW15dnJublRwVURzVEZIVjI4OGQxTktTcTNi?=
 =?utf-8?B?Tzl0Q0VGNXBZUGE4dlNPUnhPUkpTemZyK3JyU1dqRWVFV05DV0U3UXozN1Fk?=
 =?utf-8?B?YVRhYmhRYXhhbHhIY25CV083ek5LVVZQaVVxbE5aYXRHWmxxL0ZqRmVRTlBO?=
 =?utf-8?B?WGt2Z2w1UmNVcGVoeWpzRFIyYTVkc0JvMUNaemFZeFZ1QWhoQlhwb09PSktw?=
 =?utf-8?B?WGxOTTdtQzhoakx2WDFqMGpqYlFqbUFsWEQveFgwdkJIY3h3ZEMrZnRXUmVs?=
 =?utf-8?B?YnVqTklsQStxMnRrc0VEbjZqQXZHSG5hWDFwcUN0K05jNFoyYUR2RnRmQTJt?=
 =?utf-8?B?Y0E0QVJYSWo1WW5aWmZ4WExQZEdrai94QVVQaDZjU1FoTnJUSEc4YmFCbnRl?=
 =?utf-8?B?L08rU3VFN1ZnTFgyUVVwb2p1bTU4VjRkcWtkTWFjZVJsMnhrN0FaeUw2bktQ?=
 =?utf-8?B?bEhxTjBHY3ExcUJFdGNJbzhHRGV1TkpxNzcvUTU4WWM4cTVoN2hEQlhGa1hi?=
 =?utf-8?B?YUZSbVN2S08zYkxWdENWcGJFZEpNc1ZUUDFCWGplQkVWdXpsNmNQVG5SMUh2?=
 =?utf-8?B?UDhyMkFzZHZCQ2JVMFlWNCs3VGlPTUZtME1wckFNZFpPZDBnRmx3S2kvUkZY?=
 =?utf-8?B?bm9DZnpvNjRVaUNXclFFUTkvL1RXeklneURKVlh5ZWFrV05kaTZGWWZ4MXV0?=
 =?utf-8?B?dUxKWmpRUVgyejVqNDB4VDJzRE42TnlydWdTVjBlUm5XZENETE5Mdks1MHJE?=
 =?utf-8?B?QkdnRkdpZHRkUVl3RnNiOFdYWDRFVGYzbVlvTmVucjdGMnNVNU1jTXpvbnk5?=
 =?utf-8?B?eFhJeXpyaXB2Y2VTR1JDczkwa29JWmZ0a1d0bkxRUHI0WHFjS24zQ3pUbmVU?=
 =?utf-8?B?aitPVDBCelc1RTNTc0lXRHdhMTY2NDdNc2J1cTM1bXVCU0NwQzB0ZmJqUU10?=
 =?utf-8?B?SnBWYjhQbCtldWRYWGk0ZXJPcjM1NXFUNjFBMzFEcEZKbmQzaHpSM1R1Vmp6?=
 =?utf-8?B?VEVTU0JKWHNjdlV0d3NpT1pXc1RKMHNBbHpUcnRtNzVoSnZ0QzgwVlUyV3JM?=
 =?utf-8?B?aUhQazFtRTZzRXJ2VVZaRERIUlkvU2luR1d2NVZpbDNnNnoxT3krTDVsZjdi?=
 =?utf-8?B?bW56ODFkaFlYWEF2V3ZOcG01Q2FOMFAvaGh6bitnNlNRUXM1WFdtOWcvU2Np?=
 =?utf-8?B?djRVamJhRkhmUTdZbktUaDV4RVZqU1dvMHB4YmE5dFFRRGFHNTlhY3B2SDBP?=
 =?utf-8?B?OUI5V3QvWDZGS1k5RjRvUCtabUpGMnJlaENDZkRiN3pSSkNYRWpEaGdvOTQy?=
 =?utf-8?B?Ym02eGRQaXFpQnBUOHc2eWRzV3EybHhCNGQzZ1llcHNZUDBEdlFtYytZMFpY?=
 =?utf-8?B?U3F2S0lwUm9MWFNJOGhYNGlsekpCR0dDaHU1aVN6QndJcWpYT21qcU9YK1Vt?=
 =?utf-8?B?RFFDMlU3bER0eVpWQjhzZklVMlJGR0RXT0EyWUE5ZTRpazBFUThiMFMvckFG?=
 =?utf-8?B?bERIR1dpUGpxYzgwUnhjaXE1YzI4UVoxbGxDZUM4RjVjV1pBUkl6Z0tUbXoz?=
 =?utf-8?B?czhtTnNDcmVmZnJ1Z1EwQi8yNTB6U21mWHFSZWMwYU0wcmFmeVljOVUvcnBE?=
 =?utf-8?B?Q2lDcDMzYlJpZ2xLVHo3b0NOdGFNcnp5MkVad1RjMTRHWTFOY1JhenNyYk1x?=
 =?utf-8?Q?esWJZPDcwL27+wOo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P7pQoNAe+Fb+wA5snOWErXT680QtKNM4RMNSLlHR0SIbUcGtiJ5M8qhWrGmgl3YU+jxdIAgBekGAOJ1PXDo5M6dl6JLHOr775J6hSAKZhcUG1UyiKMat6H3bK3hFktFjYLk3RKYBy/TLlkVSwXIDzXrs72Dzq5iEbjHyc5MG6M9ayCHp9m3T51HJTSVvtAFreyIp81LTOPHTkMB7RILglt6Z2D4YWyXi8jC/5VDg58/BUFlaTXOUaJAv807m7UPN9Ot5wbdJSMO7Lc9m7md6d3I07P5/SEOk0dJ9zDLLCJF+RFTaU8fWnCXKm9su3pr6EvR37UzW/CJmne0qcp1YVA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b534d277-fb4f-4519-4491-08dea5d07a3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 09:19:55.5056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pr+0C6O7tNlSV/LZfe9oMCgwB7D3a58R0R3TkMmTiQM2FQdV1pPnFTQWyDq78I0aBEzQodzxfwHgFenIn10P6ZtwkwFUdZhU0qXBlKgtwc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 4C630491D69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-19724-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,kernel.org,vger.kernel.org,intel.com,lists.linux.dev,brownhat.org,corigine.com,ti.com,tux.org,suse.com,farsite.co.uk,badula.org,marvell.com,lists.osuosl.org,net-swift.com,broadcom.com,realtek.com,resnulli.us,cypress.com,nvidia.com,chelsio.com,baylibre.com,trustnetic.com,linux.dev,google.com,seu.edu.cn,mucse.com,dama.to,bootlin.com,infradead.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_GT_50(0.00)[83];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgVXdl
IEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1YikNCj4gU2VudDogVHVlc2RheSwgQXByaWwg
MjgsIDIwMjYgNzoxOSBQTQ0KPiBUbzogTWljaGFlbCBHcnplc2NoaWsgPG0uZ3J6ZXNjaGlrQHBl
bmd1dHJvbml4LmRlPjsgQW5kcmV3IEx1bm4NCj4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IERh
dmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMNCj4gRHVtYXpldCA8ZWR1
bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9s
bw0KPiBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBl
bmd1dHJvbml4LmRlPjsNCj4gVmluY2VudCBNYWlsaG9sIDxtYWlsaG9sQGtlcm5lbC5vcmc+OyBL
cnp5c3p0b2YgSGFsYXNhDQo+IDxraGNAcG0ud2F3LnBsPjsgSm9oYW5uZXMgQmVyZyA8am9oYW5u
ZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gQ2M6IFJpY2hhcmQgQ29jaHJhbiA8cmljaGFyZGNvY2hy
YW5AZ21haWwuY29tPjsgWW9uZ2xvbmcgTGl1DQo+IDxsaXV5b25nbG9uZ0BodWF3ZWkuY29tPjsg
S2VlcyBDb29rIDxrZWVzQGtlcm5lbC5vcmc+OyBsaW51eC0NCj4gd2lyZWxlc3NAdmdlci5rZXJu
ZWwub3JnOyBaYXJlbWJhLCBMYXJ5c2EgPGxhcnlzYS56YXJlbWJhQGludGVsLmNvbT47DQo+IGJy
Y204MDIxMUBsaXN0cy5saW51eC5kZXY7IERhbmllbGUgVmVuemFubyA8dmVuemFAYnJvd25oYXQu
b3JnPjsgb3NzLQ0KPiBkcml2ZXJzQGNvcmlnaW5lLmNvbTsgTmd1eWVuLCBBbnRob255IEwgPGFu
dGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsNCj4gTUQgRGFuaXNoIEFud2FyIDxkYW5pc2hhbndh
ckB0aS5jb20+OyBTYW11ZWwgQ2hlc3NtYW4NCj4gPGNoZXNzbWFuQHR1eC5vcmc+OyBGYW4gR29u
ZyA8Z29uZ2ZhbjFAaHVhd2VpLmNvbT47IE1hcmNvIENyaXZlbGxhcmkNCj4gPG1hcmNvLmNyaXZl
bGxhcmlAc3VzZS5jb20+OyBLZXZpbiBDdXJ0aXMNCj4gPGtldmluLmN1cnRpc0BmYXJzaXRlLmNv
LnVrPjsgSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+OyBJb24NCj4gQmFkdWxlc2N1IDxp
b251dEBiYWR1bGEub3JnPjsgU2hldmNoZW5rbywgQW5kcml5DQo+IDxhbmRyaXkuc2hldmNoZW5r
b0BpbnRlbC5jb20+OyBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz47DQo+IENvbGlu
IElhbiBLaW5nIDxjb2xpbi5pLmtpbmdAZ21haWwuY29tPjsgS2l0c3plbCwgUHJ6ZW15c2xhdw0K
PiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IFBlaXlhbmcgV2FuZw0KPiA8d2FuZ3Bl
aXlhbmcxQGh1YXdlaS5jb20+OyBUaG9tYXMgRm91cmllciA8Zm91cmllci50aG9tYXNAZ21haWwu
Y29tPjsNCj4gU2FpIEtyaXNobmEgPHNhaWtyaXNobmFnQG1hcnZlbGwuY29tPjsgRGVuaXMgS2ly
amFub3YNCj4gPGtpcmphbm92QGdtYWlsLmNvbT47IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vv
c2wub3JnOyBsaW51eC0NCj4gcGFyaXNjQHZnZXIua2VybmVsLm9yZzsgS2VsbGVyLCBKYWNvYiBF
IDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+Ow0KPiBNZW5neXVhbiBMb3UgPG1lbmd5dWFubG91
QG5ldC1zd2lmdC5jb20+OyBTdGVmZmVuIEtsYXNzZXJ0DQo+IDxrbGFzc2VydEBrZXJuZWwub3Jn
PjsgU3RhbmlzbGF2IFlha292bGV2IDxzdGFzLnlha292bGV2QGdtYWlsLmNvbT47DQo+IGxpbnV4
LXJkbWFAdmdlci5rZXJuZWwub3JnOyBBcmVuZCB2YW4gU3ByaWVsDQo+IDxhcmVuZC52YW5zcHJp
ZWxAYnJvYWRjb20uY29tPjsgbmljX3N3c2RAcmVhbHRlay5jb207IEppcmkgUGlya28NCj4gPGpp
cmlAcmVzbnVsbGkudXM+OyBQaGlsaXBwIFN0YW5uZXIgPHBoYXN0YUBrZXJuZWwub3JnPjsgQ2hp
LWhzaWVuIExpbg0KPiA8Y2hpLWhzaWVuLmxpbkBjeXByZXNzLmNvbT47IElkbyBTY2hpbW1lbCA8
aWRvc2NoQG52aWRpYS5jb20+OyBQb3RudXJpDQo+IEJoYXJhdCBUZWphIDxiaGFyYXRAY2hlbHNp
by5jb20+OyBEb3VibGUgTG8gPGRvdWJsZS5sb0BjeXByZXNzLmNvbT47DQo+IE1hcmt1cyBTY2hu
ZWlkZXItUGFyZ21hbm4gPG1zcEBiYXlsaWJyZS5jb20+OyBOYXRoYW4gQ2hhbmNlbGxvcg0KPiA8
bmF0aGFuQGtlcm5lbC5vcmc+OyBKaWF3ZW4gV3UgPGppYXdlbnd1QHRydXN0bmV0aWMuY29tPjsg
Q2FpIEh1b3FpbmcNCj4gPGNhaS5odW9xaW5nQGxpbnV4LmRldj47IEJqb3JuIEhlbGdhYXMgPGJo
ZWxnYWFzQGdvb2dsZS5jb20+OyBaaWxpbg0KPiBHdWFuIDx6aWxpbkBzZXUuZWR1LmNuPjsgbGlu
dXgtY2FuQHZnZXIua2VybmVsLm9yZzsgWWlibyBEb25nDQo+IDxkb25nMTAwQG11Y3NlLmNvbT47
IEpvZSBEYW1hdG8gPGpvZUBkYW1hLnRvPjsgUGV0ciBNYWNoYXRhDQo+IDxwZXRybUBudmlkaWEu
Y29tPjsgS29yeSBNYWluY2VudCA8a29yeS5tYWluY2VudEBib290bGluLmNvbT47DQo+IGJyY204
MDIxMS1kZXYtbGlzdC5wZGxAYnJvYWRjb20uY29tOyBHUi1MaW51eC1OSUMtRGV2QG1hcnZlbGwu
Y29tOw0KPiBWYWRpbSBGZWRvcmVua28gPHZhZGltLmZlZG9yZW5rb0BsaW51eC5kZXY+OyBNYW5p
c2ggQ2hvcHJhDQo+IDxtYW5pc2hjQG1hcnZlbGwuY29tPjsgRGVuaXMgQmVuYXRvIDxiZW5hdG8u
ZGVuaXM5NkBnbWFpbC5jb20+OyBSYXNlc2gNCj4gTW9keSA8cm1vZHlAbWFydmVsbC5jb20+OyBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBSYW5keSBEdW5sYXANCj4gPHJkdW5sYXBAaW5mcmFkZWFk
Lm9yZz47IE1hcmsgQmxvY2ggPG1ibG9jaEBudmlkaWEuY29tPjsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IFRhcmlxIFRvdWthbiA8dGFyaXF0QG52aWRpYS5jb20+OyBKaWFuIFNo
ZW4NCj4gPHNoZW5qaWFuMTVAaHVhd2VpLmNvbT47IEppamllIFNoYW8gPHNoYW9qaWppZUBodWF3
ZWkuY29tPjsgWWVvdW5zdQ0KPiBNb29uIDx5eXl5bm9vbUBnbWFpbC5jb20+OyBUaG9tYXMgR2xl
aXhuZXIgPHRnbHhAa2VybmVsLm9yZz47IFNpbW9uDQo+IEhvcm1hbiA8aG9ybXNAa2VybmVsLm9y
Zz47IFlpY29uZyBIdWkgPHlpY29uZ2h1aUBnbWFpbC5jb20+OyBNYXJrDQo+IEVpbm9uIDxtYXJr
LmVpbm9uQGdtYWlsLmNvbT47IEV0aGFuIE5lbHNvbi1Nb29yZQ0KPiA8ZW5lbHNvbm1vb3JlQGdt
YWlsLmNvbT47IFNhZWVkIE1haGFtZWVkIDxzYWVlZG1AbnZpZGlhLmNvbT47DQo+IFN1ZGFyc2Fu
YSBLYWxsdXJ1IDxza2FsbHVydUBtYXJ2ZWxsLmNvbT47IEhlaW5lciBLYWxsd2VpdA0KPiA8aGth
bGx3ZWl0MUBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBu
ZXQtbmV4dF0gbmV0OiBDb25zaXN0ZW50bHkgZGVmaW5lDQo+IHBjaV9kZXZpY2VfaWRzIHVzaW5n
IG5hbWVkIGluaXRpYWxpemVycw0KPiANCj4gLi4uIGFuZCBQQ0kgZGV2aWNlIGhlbHBlcnMuDQo+
IA0KPiBUaGUgdmFyaW91cyBzdHJ1Y3QgcGNpX2RldmljZV9pZCBhcnJheXMgd2VyZSBpbml0aWFs
aXplZCBtb3N0bHkgYnkgb25lDQo+IHRoZSBQQ0lfREVWSUNFIG1hY3JvcyBhbmQgdGhlbiBsaXN0
IGV4cHJlc3Npb25zLiBUaGUgbGF0dGVyIGlzbid0DQo+IGVhc2lseQ0KPiByZWFkYWJsZSBpZiB5
b3UncmUgbm90IGludG8gUENJLiBVc2luZyBuYW1lZCBpbml0aWFsaXplcnMgaXMgbW9yZQ0KPiBl
eHBsaWNpdCBhbmQgdGh1cyBlYXNpZXIgdG8gcGFyc2UuDQo+IA0KPiBBbHNvIHVzZSBQQ0lfREVW
SUNFKiBoZWxwZXIgbWFjcm9zIHRvIGFzc2lnbiAudmVuZG9yLCAuZGV2aWNlLA0KPiAuc3VidmVu
ZG9yIGFuZCAuc3ViZGV2aWNlIHdoZXJlIGFwcHJvcHJpYXRlIGFuZCBza2lwIGV4cGxpY2l0DQo+
IGFzc2lnbm1lbnRzIG9mIDAgKHdoaWNoIHRoZSBjb21waWxlciB0YWtlcyBjYXJlIG9mKS4NCj4g
DQo+IFRoZSBzZWNyZXQgcGxhbiBpcyB0byBtYWtlIHN0cnVjdCBwY2lfZGV2aWNlX2lkOjpkcml2
ZXJfZGF0YSBhbg0KPiBhbm9ueW1vdXMgdW5pb24gKHNpbWlsYXIgdG8NCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsL2NvdmVyLjE3NzY1NzkzMDQuZ2l0LnUua2xlaW5lLQ0KPiBrb2VuaWdA
YmF5bGlicmUuY29tLykNCj4gYW5kIHRoYXQgcmVxdWlyZXMgbmFtZWQgaW5pdGlhbGl6ZXJzLiBC
dXQgaXQncyBhbHNvIGEgbmljZSBjbGVhbnVwIG9uDQo+IGl0cyBvd24uDQo+IA0KPiBUaGlzIGNo
YW5nZSBkb2Vzbid0IGludHJvZHVjZSBjaGFuZ2VzIHRvIHRoZSBjb21waWxlZCBwY2lfZGV2aWNl
X2lkDQo+IGFycmF5cy4gVGVzdGVkIG9uIHg4NiBhbmQgYXJtNjQuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyAoVGhlIENhcGFibGUgSHViKSA8dS5rbGVpbmUtDQo+IGtv
ZW5pZ0BiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiBIZWxsbywNCj4gDQo+IHRoZSBtZW50aW9uZWQg
Zm9sbG93LXVwIHF1ZXN0IGFsbG93cyB0byBkbw0KPiANCj4gCQkJUENJX0RFVklDRSgweDE1NzEs
IDB4YTIwMyksDQo+IAkrCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpJmNhcmRfaW5m
b18xMG1iaXQsDQo+IAktCQkuZHJpdmVyX2RhdGFfcHRyID0gJmNhcmRfaW5mb18xMG1iaXQsDQo+
IA0KPiB3aGljaCBnZXRzIHJpZCBvZiBhIGJ1bmNoIG9mIGNhc3RzIGFuZCBzbyBicmluZ3MgYSBs
aXR0bGUgYml0IG1vcmUNCj4gdHlwZQ0KPiBzYWZldHkuIFRoaXMgcGF0Y2ggaXMgYSBwcmVwYXJh
dGlvbiBmb3IgdGhhdC4NCj4gDQo+IEkgaGFuZGxlZCBhbGwgb2YgZHJpdmVycy9uZXQvIGluIGEg
c2luZ2xlIHBhdGNoLCBwbGVhc2UgdGVsbCBtZSBpZiBJDQo+IHNob3VsZCBzcGxpdCBieSBzdWJz
eXN0ZW0uDQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4gVXdlDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQv
YXJjbmV0L2NvbTIwMDIwLXBjaS5jICAgICAgICAgICAgIHwgMjQyICsrKy0tLS0tLQ0KPiAgZHJp
dmVycy9uZXQvY2FuL21fY2FuL21fY2FuX3BjaS5jICAgICAgICAgICAgIHwgICA2ICstDQo+ICBk
cml2ZXJzL25ldC9jYW4vc2phMTAwMC9wbHhfcGNpLmMgICAgICAgICAgICAgfCAxNjcgKysrLS0t
LQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvM2NvbS8zYzU5eC5jICAgICAgICAgICAgIHwgIDgw
ICstLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvM2NvbS90eXBob29uLmMgICAgICAgICAgIHwg
IDc1ICsrLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvODM5MC9uZTJrLXBjaS5jICAgICAgICAg
IHwgIDI0ICstDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9hZGFwdGVjL3N0YXJmaXJlLmMgICAg
ICAgfCAgIDQgKy0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2FnZXJlL2V0MTMxeC5jICAgICAg
ICAgICB8ICAgNiArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vYm54Mi5jICAg
ICAgICAgIHwgIDYyICsrLQ0KPiAgLi4uL25ldC9ldGhlcm5ldC9icm9hZGNvbS9ibngyeC9ibngy
eF9tYWluLmMgIHwgIDUwICstDQo+ICAuLi4vbmV0L2V0aGVybmV0L2Nhdml1bS9saXF1aWRpby9s
aW9fbWFpbi5jICAgfCAgMTAgKy0NCj4gIC4uLi9ldGhlcm5ldC9jYXZpdW0vbGlxdWlkaW8vbGlv
X3ZmX21haW4uYyAgICB8ICAgNyArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvY2hlbHNpby9j
eGdiL2NvbW1vbi5oICAgIHwgICAyICstDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9jaGVsc2lv
L2N4Z2Ivc3Vici5jICAgICAgfCAgIDIgKy0NCj4gIC4uLi9uZXQvZXRoZXJuZXQvY2hlbHNpby9j
eGdiMy9jeGdiM19tYWluLmMgICB8ICAgNCArLQ0KPiAgLi4uL25ldC9ldGhlcm5ldC9jaGVsc2lv
L2N4Z2I0L2N4Z2I0X21haW4uYyAgIHwgICA0ICstDQo+ICAuLi4vZXRoZXJuZXQvY2hlbHNpby9j
eGdiNHZmL2N4Z2I0dmZfbWFpbi5jICAgfCAgIDQgKy0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2RlYy90dWxpcC9kZTIxMDR4LmMgICAgICB8ICAgNiArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvZGVjL3R1bGlwL2RtZmUuYyAgICAgICAgIHwgIDEyICstDQo+ICBkcml2ZXJzL25ldC9ldGhl
cm5ldC9kZWMvdHVsaXAvdHVsaXBfY29yZS5jICAgfCAgNzggKy0tDQo+ICBkcml2ZXJzL25ldC9l
dGhlcm5ldC9kZWMvdHVsaXAvdWxpNTI2eC5jICAgICAgfCAgIDYgKy0NCj4gIGRyaXZlcnMvbmV0
L2V0aGVybmV0L2RlYy90dWxpcC93aW5ib25kLTg0MC5jICB8ICAxMyArLQ0KPiAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZGxpbmsvZGwyay5oICAgICAgICAgICAgIHwgIDEyICstDQo+ICBkcml2ZXJz
L25ldC9ldGhlcm5ldC9kbGluay9zdW5kYW5jZS5jICAgICAgICAgfCAgMTQgKy0NCj4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2ZlYWxueC5jICAgICAgICAgICAgICAgICB8ICAgOCArLQ0KPiAgLi4u
L25ldC9ldGhlcm5ldC9oaXNpbGljb24vaGlibWNnZS9oYmdfbWFpbi5jIHwgICAyICstDQo+ICAu
Li4vbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZW5ldC5jICAgfCAgNTAgKy0NCj4g
IC4uLi9oaXNpbGljb24vaG5zMy9obnMzcGYvaGNsZ2VfbWFpbi5jICAgICAgICB8ICAxOCArLQ0K
PiAgLi4uL2hpc2lsaWNvbi9obnMzL2huczN2Zi9oY2xnZXZmX21haW4uYyAgICAgIHwgIDEyICst
DQo+ICAuLi4vbmV0L2V0aGVybmV0L2h1YXdlaS9oaW5pYy9oaW5pY19tYWluLmMgICAgfCAgMTIg
Ky0NCj4gIC4uLi9uZXQvZXRoZXJuZXQvaHVhd2VpL2hpbmljMy9oaW5pYzNfbGxkLmMgICB8ICAg
NyArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvZTEwMC5jICAgICAgICAgICAgIHwg
ICA0ICstDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwMGUvbmV0ZGV2LmMgICAg
fCA0NzEgKysrKysrKysrKysrKy0tLS0NCj4gLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvZm0xMGsvZm0xMGtfcGNpLmMgIHwgIDEwICstDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pNDBlL2k0MGVfbWFpbi5jICAgfCAgNTkgKy0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pYXZmL2lhdmZfbWFpbi5jICAgfCAgMTAgKy0NCj4gIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jICAgICB8ICA2NiArLS0NCj4gIGRyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2lnYnZmL25ldGRldi5jICAgICB8ICAgNCArLQ0KPiAgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMgICAgIHwgIDM0ICstDQo+ICBkcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZV9tYWluLmMgfCAxMDYgKystLQ0KPiAgLi4uL25l
dC9ldGhlcm5ldC9pbnRlbC9peGdiZXZmL2l4Z2JldmZfbWFpbi5jIHwgIDQ5ICstDQo+ICBkcml2
ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg0L21haW4uYyAgICAgfCAgIDYgKy0NCj4gIC4u
Li9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL21haW4uYyAgICB8ICAyNiArLQ0KPiAg
Li4uL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHhzdy9zcGVjdHJ1bS5jICAgIHwgIDE2ICstDQo+
ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyZWwva3N6ODg0eC5jICAgICAgICAgfCAgIDggKy0N
Cj4gIC4uLi9uZXQvZXRoZXJuZXQvbXVjc2Uvcm5wZ2JlL3JucGdiZV9tYWluLmMgICB8ICAxMCAr
LQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbmF0c2VtaS9uYXRzZW1pLmMgICAgICAgIHwgICA0
ICstDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9uZXRyb25vbWUvbmZwL25mcF9tYWluLmMgfCAg
ODEgKy0tDQo+ICAuLi4vZXRoZXJuZXQvbmV0cm9ub21lL25mcC9uZnBfbmV0dmZfbWFpbi5jICAg
fCAgNDEgKy0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWRlL3FlZGVfbWFpbi5j
ICB8ICAyMCArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay84MTM5dG9vLmMgICAg
ICAgIHwgIDUyICstDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4u
YyAgICAgfCAgIDggKy0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3JvY2tlci9yb2NrZXJfbWFp
bi5jICAgICB8ICAgNCArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvc2lzL3NpczE5MC5jICAg
ICAgICAgICAgIHwgICA2ICstDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9zaXMvc2lzOTAwLmMg
ICAgICAgICAgICAgfCAgMTAgKy0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Ntc2MvZXBpYzEw
MC5jICAgICAgICAgICB8ICAxOCArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvc3VuL2Nhc3Np
bmkuYyAgICAgICAgICAgIHwgICA4ICstDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9zdW4vc3Vu
Z2VtLmMgICAgICAgICAgICAgfCAgMjYgKy0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3RpL3Rs
YW4uYyAgICAgICAgICAgICAgICB8ICA0MSArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvd2Fu
Z3h1bi9uZ2JlL25nYmVfbWFpbi5jIHwgIDI2ICstDQo+ICAuLi4vbmV0L2V0aGVybmV0L3dhbmd4
dW4vbmdiZXZmL25nYmV2Zl9tYWluLmMgfCAgMjYgKy0NCj4gIC4uLi9uZXQvZXRoZXJuZXQvd2Fu
Z3h1bi90eGdiZS90eGdiZV9tYWluLmMgICB8ICAxOCArLQ0KPiAgLi4uL2V0aGVybmV0L3dhbmd4
dW4vdHhnYmV2Zi90eGdiZXZmX21haW4uYyAgIHwgIDE4ICstDQo+ICBkcml2ZXJzL25ldC93YW4v
ZmFyc3luYy5jICAgICAgICAgICAgICAgICAgICAgfCAgMjQgKy0NCj4gIGRyaXZlcnMvbmV0L3dh
bi9wYzMwMHRvby5jICAgICAgICAgICAgICAgICAgICB8ICAxNCArLQ0KPiAgZHJpdmVycy9uZXQv
d2FuL3BjaTIwMHN5bi5jICAgICAgICAgICAgICAgICAgIHwgICA2ICstDQo+ICBkcml2ZXJzL25l
dC93YW4vd2FueGwuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgMTEgKy0NCj4gIC4uLi9icm9h
ZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvcGNpZS5jICAgICAgICB8ICAxNyArLQ0KPiAgZHJpdmVy
cy9uZXQvd2lyZWxlc3MvaW50ZWwvaXB3MngwMC9pcHcyMjAwLmMgIHwgIDUyICstDQo+ICA2OSBm
aWxlcyBjaGFuZ2VkLCAxMzA4IGluc2VydGlvbnMoKyksIDExMDEgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvYXJjbmV0L2NvbTIwMDIwLXBjaS5jDQo+IGIvZHJp
dmVycy9uZXQvYXJjbmV0L2NvbTIwMDIwLXBjaS5jDQo+IGluZGV4IGRiYWRkYTA4ZGNlMi4uNjQ3
NGM3YmUyOTkyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9hcmNuZXQvY29tMjAwMjAtcGNp
LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvYXJjbmV0L2NvbTIwMDIwLXBjaS5jDQo+IEBAIC00NTks
MTY4ICs0NTksODggQEAgc3RhdGljIHN0cnVjdCBjb20yMDAyMF9wY2lfY2FyZF9pbmZvDQo+IGNh
cmRfaW5mb19lYWVfZmIyID0gew0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2Rldmlj
ZV9pZCBjb20yMDAyMHBjaV9pZF90YWJsZVtdID0gew0KPiAgCXsNCg0KLi4uDQoNCj4gIH07DQo+
IA0KPiAgTU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIGNhcmRfaWRzKTsNCj4gDQo+IGJhc2UtY29t
bWl0OiAyNTRmNDk2MzRlZTE2YTczMTE3NGQyYWUzNGJjNTBiZDVmNDVlNzMxDQo+IC0tDQo+IDIu
NDcuMw0KDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9r
dGlvbm92QGludGVsLmNvbT4NCg==

