Return-Path: <linux-rdma+bounces-15896-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIk5HVOOcmmHmAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15896-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 21:53:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A15F56D8E6
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 21:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEDCE3013A59
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 20:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A93397ADA;
	Thu, 22 Jan 2026 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRvKVUP0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1838A73B;
	Thu, 22 Jan 2026 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769115211; cv=fail; b=CSDV7P29BKEDpWhiw83kEnOQgRXDWxDdpRPEjtSz4j2xrMTp3lglDVR1kaPej1viBIHPKzHWBGyVM83tZcLPLm3GwhDLkAIufPsSfX+wPnZN4BjM9Mt6VixI4Z4gkwDgpnc4Ez5mrAdyVc5fFg455UOaTLEyxJA9mje/WIiZpN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769115211; c=relaxed/simple;
	bh=l7oJVOzQRtKsKlrGzNXmbYOYIfK7fZ3ds/FRgE6sZFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uV3MVxoVW0SPHj3XvJal+/SrpMqBk0F7/ip/X+ZrGmcTw5PMQ0VFZ2W7PojCLrKH1j5suduOIHoTjJDqFtuMKn+vs9iudM6oJxkSNi6huu7oRvhFVjfVpdcDYajAPCNvYwUC1OBExOtTqWByoKC/XYNY2ueBnQd9zFPV++B8bh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRvKVUP0; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769115208; x=1800651208;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l7oJVOzQRtKsKlrGzNXmbYOYIfK7fZ3ds/FRgE6sZFc=;
  b=QRvKVUP0RcCdVZGrK8S2jMZWNDdb9jRrSNayOkrPboB9LhOCNaA2UThK
   w/aSRJQ3hg8F7ZyiVY5NuILifSOeOQ9Qo2gbxt6HAK138kibrtSEjgdC7
   XGCulUFSlAL9MIKnKw28fE30pAvyCwvi8wdKVC8J4xTcBe1of67+PcvPq
   3NTaJN4E+gmvw/x43J49NXlH5qWpJ3BFCxqgKJcpRQMAV0s1Wn2VbDfNQ
   fUezpPbZjYpiby4FJ6whD04fidz9jKX8aUXbxRIR55FAFTo03dCKnG970
   nh19DGzLVDs8SFLcGmMhepVgHvphSxPpgaddC7uzuAqCOmKyvSpvhKRmX
   g==;
X-CSE-ConnectionGUID: eiXVKknaRaSZdPxyk4tM7w==
X-CSE-MsgGUID: cgTDCp6AT8OKcbmRbfmavw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70089427"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70089427"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 12:53:20 -0800
X-CSE-ConnectionGUID: AsD0deCTR7u/2dx73NIivQ==
X-CSE-MsgGUID: OHjRPj09T2WpnYoKYVszhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="207262519"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 12:53:19 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 12:53:19 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 12:53:19 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 12:53:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBWdm6L4TySzvQETv4jf58F6ZNnsfdC/kNKLgZm+qobgsMJ2Xj7IIOlmozctVz2v4X76/T7b9j9sWNXCHb44SWt5xkqkVkMFNY7l5306a9w4SgU4CFrgH8NHB87bPrQwu/KYsLVfU0f7vOpeYoKx5iK0XqRPTRO/VGI0wDalGbaYHkW2IcK9VRT0adWx848gDcMvX/XUVh5eV5SGUjltwYK0mRxHIYKw87VWCeC9mklfqgv2DVNnk2VGSthJKqC6FKUnRaKfhFSyzQQ+FYBRk0D4ooYq2MyMFtFGkTJI/v9qNoDDwcHncKhTrsQRsRD/cD/UicqlVp2DIwBQVU8f9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7oJVOzQRtKsKlrGzNXmbYOYIfK7fZ3ds/FRgE6sZFc=;
 b=WayB/rjnKAXDUuHqfjrt3NYm3ys8h1YsRrcjDwVA1xPUr3Gu35PQ1UVx7iUBK15lKoYuLvJ6aDvdk/nRmgHhOoDWr1/OwvapkzojTI1YUzvcoHAudWoVza4xsb4DdS5MVuSBk9347hb+3hAo5DL4+vrCbx4SPeEGQ536/lfsfzK3XfQ9dEXsX3IoDfI8rsCnls4YYJ0x49oXbQuOgHGOwMgtU0rMzqga5337pI78Ygd/RcLH4fQoLFoKWlcGfFOrCorwYydb5+Np9/kSM6wpKY1OybmAvctqqtEJNzpig2vgv/Ls6+4YR4mrjDsfVKL9QFni8Xei6gxVWDfmwWI/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17)
 by LV1PR11MB8792.namprd11.prod.outlook.com (2603:10b6:408:2b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 20:53:16 +0000
Received: from IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::a99c:3219:bf01:5875]) by IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::a99c:3219:bf01:5875%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 20:53:16 +0000
From: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To: Carlos Bilbao <carlos.bilbao@lambdal.com>, "mustafa.ismail@intel.com"
	<mustafa.ismail@intel.com>, "shiraz.saleem@intel.com"
	<shiraz.saleem@intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "bilbao@vt.edu" <bilbao@vt.edu>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "carlos.bilbao@kernel.org"
	<carlos.bilbao@kernel.org>
Subject: RE: [PATCH] RDMA/irdma: Use kvzalloc for paged memory DMA address
 array
Thread-Topic: [PATCH] RDMA/irdma: Use kvzalloc for paged memory DMA address
 array
Thread-Index: AQHciwdj2nafon5eI0COs9l6J6vBNLVeqQxA
Date: Thu, 22 Jan 2026 20:53:15 +0000
Message-ID: <IA1PR11MB7727D411D88140BF45740D65CB97A@IA1PR11MB7727.namprd11.prod.outlook.com>
References: <70f5170f-70eb-4244-9049-a994ec503ac6@lambdal.com>
In-Reply-To: <70f5170f-70eb-4244-9049-a994ec503ac6@lambdal.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7727:EE_|LV1PR11MB8792:EE_
x-ms-office365-filtering-correlation-id: 0541df0a-a1f8-4ddf-3404-08de59f8440f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VUVuQ2lTclg2dFFkcTVkV1dLMTBwb21RZkRCdHdBZ2FOR3lnRmg1NzZkbW40?=
 =?utf-8?B?ams2SUU3OUZnWmJDbDFROUQwc2xBb0dscG9XbERwWmNiQnpDbktRUFR4Vmwz?=
 =?utf-8?B?YURxdzJ3OFNTYlJzNm00ZHROSk9SVUhVbmVDc1hYbWZVZ2czQUhOR3YzU3Jz?=
 =?utf-8?B?WWNGT3BVakdOM1BiREpxK3Z5NmkyVXZvakZzdW9Fa09EdEpQSmhra1JDdjc2?=
 =?utf-8?B?ZmNORk9GMzZjNDgzbTV4bWFvdGh1Y0FMQ3RrQ1BPNnF6VXhSU1JsMVhubEdP?=
 =?utf-8?B?V21NK3BXZkNEaEdYVW1qZWxUdFlmYU8rMTBTeld2S3pyZnJRb3hHNlU4TWI5?=
 =?utf-8?B?Q01HNW9mYW9NUXRNdFYrMDE2YjdsU2M1OWk3M3p6ZnJuclIvRVY0RmVwTjBH?=
 =?utf-8?B?aFFZdDhFSUJsdk80dExqS0w4djc4QllEUHE3bkpKYWdaYlNBNmZTTXlybEVV?=
 =?utf-8?B?Q3F3OXQxQnlnb3pJeFdWbWl6ZDFkK2krb1FLS3lDbkpDMksxTHhRc1RDTU1t?=
 =?utf-8?B?MXpqYk5ibExyaVR4ZmVGZlorNGRoSkJzZzhXNzdENW1xcXhNTFQrUmVTK0xV?=
 =?utf-8?B?a3pGNjVpVllqdlRBRk9hY0ZoWkNTZGZCTXFRbXlNejFleTdmeUlEb3VlZ1g4?=
 =?utf-8?B?dXE2cU1JYlZ1QlFHcHFCcVNBc2hvbjVpNUxKbHljT2M0cEdJSFpxekNrSHJq?=
 =?utf-8?B?RjZkSVJXSlpTMm1GQUE3WHBVYjlLZ3NKYXJMTTJkTTlDVEYrUE9ieEJWWmFy?=
 =?utf-8?B?UDVTa1BCQXJFcGdGNHZkeDVqYWlNcW9DaUZieXBzWjlPWE5Od0xiSTMxZlVJ?=
 =?utf-8?B?a28yM1FFaXltQjg1ZlJFNkNvOFRHZmlsWXJnWTQzaERTN094bUFHT1BRRTVm?=
 =?utf-8?B?cG44TkpYUjFjWElDWmEwelhsSWYvbXdmVDZGRlJCcjROd1B6UGQ3MGtQWFZQ?=
 =?utf-8?B?dUJhZndBaElkRzV5Z0dNVDJJMWh1MkNFYWlQa0ZvWDNVZmlkSyt6b0Fqekxy?=
 =?utf-8?B?R0NxWWpiaFozODZJYVB3eGJMWGt0SEx0UHpIbkxUeGg1N3pPbURabGpqM3Av?=
 =?utf-8?B?dXlMejQyOHIwSzNaUEZHbHhDa2t5Q1dTVFRyZG1JVGR1VXFCNm1VOXAya0lL?=
 =?utf-8?B?UGFNTnZTNXRJUWh4TENZYUU3TkRIdlpHcC9abzJIQlBFZnZaL1gzbk8vZlh0?=
 =?utf-8?B?aWdZaWRRTjVxUVZXUThjT2ZRdDh6dU1mWEZQejZWZ1QyZnd6b2J4YkNuYmgr?=
 =?utf-8?B?aFlBUHJHckNNaG1qaE9WY2I1N2V2R056QjRjUzZNYVBoU24vbGFKT3ZNbkht?=
 =?utf-8?B?TnpkTjN1ZTZ1UkJBNmZtWDR1UkRvT2NEVHl1UnJkQTNuUDRyRXhYUkdteTJC?=
 =?utf-8?B?OElnUjFHdkVKY0x1RSt6V09KK05jUm90cGk2azZhaDFyK09nQUVhdlF1c21t?=
 =?utf-8?B?ejJ0Mi81L2p2S0RBd3U3SEQ1SUlBSmxnRkdpT2JYVWhDNDVSQ0NZa1dxSmxF?=
 =?utf-8?B?T1JzOWtFdlFKN0tHVWpwa1FUYkI0V2JMQ01YQ0Z5Vy85MWJncDY2QTkzSkVI?=
 =?utf-8?B?d2lLSjZzc3lRM1FOTlBVVzNxMFFlZUhwV0o1VGN5T2RYOTdya0o0cG5aWHRq?=
 =?utf-8?B?WExQcVpGZG82YWJCcThCQTU3YmZkSVZZQmRHWFpaeEZkdm5vdkV6cTFEdkFU?=
 =?utf-8?B?NlNXcXdXZE9iekx0S3psRWFINnN0MUNKaHdOUisvbHZwdW9MT2VoUEl2c1hY?=
 =?utf-8?B?VEljbEpZaWcydXo4R2NtSlgrNjB5N2hhRnFCY0orb29MdndNOEFVVEFMQmRk?=
 =?utf-8?B?bnJOcWMwZmplVDIzZ0x0Y1B1SHAzSjVTUFpGdDBDSGVEL2xEb0hDdnRycHFY?=
 =?utf-8?B?Umx2bE1HWnROVjh0SmNPME9iWjVXZ3VGc2pyL2tGMWlHVUVReEpkMzJYbDk3?=
 =?utf-8?B?RXNvUnRmUE9oRW5YQkpuQSsyaXBJajVVVDVsbFVJNnNJNDRtV0NSZE1zQzdZ?=
 =?utf-8?B?UFFBWkl5a2pWSVQ2VXhMMktBRkV0MUhjY2drdUpRZ1A1VDlhNmdsWC9SdTd1?=
 =?utf-8?B?bnE1dnRDMHJRcHVYOEhoUWRKWmFTdlRFNTYvVTFyRG5HVGxidXhmcDFPQXlR?=
 =?utf-8?B?UXRRRTBxNjFNQTB4alo5a2JHWVRYNlgyZnorRStpTm4xczJCemVPc1hHd3BU?=
 =?utf-8?Q?bFxVILAoxPuCjU1pt4FiXWA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWxzZFZjVTE1MGFycHFyNkJrdU9mNEx4eTkzVnBibldFTDd1aS95QXZtTTBQ?=
 =?utf-8?B?M2pxMmdjZi85aU0xb05XT1VkdmdqVnBJQVhMazN4ZUhibnVnRTROOFdFTkpM?=
 =?utf-8?B?SmRzQnlVL2RHZFlYWGxOdk4wZ0xkdncwajRoVGxtRFp4clo5UU11T3Y1Y1FS?=
 =?utf-8?B?T1dlNmJqMVBkZzVXQ1Q5VmZXbUZ3cVdPcEl0VFJkVlU2N0tSKzFEcDBwY041?=
 =?utf-8?B?cXBqUkxRYjY4cy9TWENDaERRVEZoNlZCTVd6b1VsSTRFdzdTWGdHTEFoNlh5?=
 =?utf-8?B?UG1jaVV0dlVXQSt1MWsrRE92VFYzZHpOcXFiTlZDODhyWjd2WXdqb05heUha?=
 =?utf-8?B?c09PSFVqVG9yeEVvOUpvQ1hxckVqRjl2aDNja2xHdDVqYkd1OE1UYlQ0eFha?=
 =?utf-8?B?azRTRjhOQWU3UWVGU1RwSW4xMDFaQVp2bFVDOVNhUGEwWDlON2FueXNDaEx2?=
 =?utf-8?B?OVN6VW41bjNGdXY5T0hXRkVwUWUwUU9IUE1hYWxIUnVxNXRlblVwK3l6ckxV?=
 =?utf-8?B?OElmdzArRVV0Vnc5NGtrNnNsNTdNM2FHTUY3cktodzJxWHErZUtHSW9FUzZI?=
 =?utf-8?B?anJ4djIrNGZyOE9CM25ONkd1RnNYYldna1pON1NBYmJadVBTdGNMZzU4blh1?=
 =?utf-8?B?dnV2OEpDOGkzVmRCM2xOVkMwVFlsOWNIVWxmM3YvQzBCaCswOUg3K1h6YVd6?=
 =?utf-8?B?QjVKNi82YVBVMG5tMEh3d25GZGVmSlY3K2M3UC9jUEtyeGxJckVpS1VOTkRX?=
 =?utf-8?B?WWpMZUMzSTRnRlovUDhTUnJJK3BhZk5Gc0JyMzBnTGt1Z0gzSWNWM1NXOEt3?=
 =?utf-8?B?RE04cTJRNjNrWm1qV2RIS1pqVXk2MUtUblZneHNSUGlDdnlLWHpjV0JoalIx?=
 =?utf-8?B?eHhuc2tYWTZIaEJqcTF2WWQyMGc1cG5sQXlrUnlaSnNzWUU2c05LTVBjNW1D?=
 =?utf-8?B?ZlpuWkF5VWtwanFmUUI4RkRQTFYwY1BNVzFhQTB3RnY2RzI5OWZ3NDFiYVY3?=
 =?utf-8?B?cUNURjhlWElPNkRmQUtydXJoSlhpLyt4YUtRZ0I3cFBjc2Z1aS85bk80WG9n?=
 =?utf-8?B?VXkwYzVYM2tXYTR3d1hjK1ZxQWxGR2paYktUV2xSUUN2UnhtMzZpM1ZpVEUv?=
 =?utf-8?B?QlpzYXBHZXp5bzg4aWdYTXpzUzcvaVBjcEtHaVYxRkRnd0ZjYTZKWVhHYUpK?=
 =?utf-8?B?dTIzQmdYY1ZaL3VHcGYvaEdQVVl1WlhCZkNyZHI5dXRMRElnNUYvYVJEcDdr?=
 =?utf-8?B?RTNhYllGbStuYnY5ZE1VSlJOQXQ0T3BhbjdMZmgrMmFnR0ZBZHBrWm5kZXM2?=
 =?utf-8?B?NC9aY2NvcEVHL3BOQUUrS3lWeGxxejBWTDNXU0FselVvc3BnUDRFMWxRTjVw?=
 =?utf-8?B?U3VPL0dnOXpNUWx5cHN2ZktMMFJzQWd4QU9tT09HYkVrU01UNXpYNFVCS01C?=
 =?utf-8?B?cUZFYS9wL2V2L3Z1UC9aZzVmY2UvdjVudUJ0emlmekZ6bktYZ01MMUoxR3lP?=
 =?utf-8?B?NFVEN1pDcERQUTJrOWhHQk9tekUrZ3d3TFZ0aVE0Vk4rNk9NTGM3UXZyUHk4?=
 =?utf-8?B?ekEyMFZxRCtzTS9tdDNMRjVLaUtLZ1ZYdjJmUFBnRzFQNzNwelo2cHJ0aHA2?=
 =?utf-8?B?WUNBT2tOUVBhemROdmlxdnI5S21jYTEwRzRQNjVSU3Nnb1k3UEFsT29mSldV?=
 =?utf-8?B?dDgrdUczcGZwaVRWYW1ZbGdldnZmaUk2OXRBZDJ3Q2xtU1l0dkRjMGFhZHFk?=
 =?utf-8?B?K3BpS0prQ3ZhNHdDNVhBeXFTazI1ZzMrajhGSVVHSjJqUnlvaDJKekprMUIx?=
 =?utf-8?B?bmppbS9HRmxmNFBzQ3RMZ1p5bUdGTnZKOUFndjYwcm5jVVNESGgxR3RQdWZs?=
 =?utf-8?B?R0NtelFUeGtSclJ2MTlrYlZ5TWJ6N2ZOOUl2NEpQbndob0pWSUNkSWFpNndC?=
 =?utf-8?B?MUZCRmxrNHNMN3dxWEJRQzBHOStEOUxhM0NmaU1TUW0wZHdtdEd2aW42NmxK?=
 =?utf-8?B?MmJvNVdTaVdVUzlTQW1qR0c5VjVKS0s5SGdzWFRFVGJQVFVuS0JaYUk3N2wr?=
 =?utf-8?B?WGhNQjIrbWZqUDhyU3ZQbmYxTk5ac1lqKy9SRVAxZ2pJdzJLK2VvR01HZlJa?=
 =?utf-8?B?c0RNUkVlZkpWS2d0NmFnQTdlRTJRY1dQVnFWVlY2TklEaE1XbE9MOHVib3F1?=
 =?utf-8?B?bzZod3dIV1lmeVlVQmV3MDZuWkVTZzJrY3YrUmZnQjhzQ1o4N0U1T1JKbTQ4?=
 =?utf-8?B?RnY3aHcrK3BQMm5WWTl2VW9UTDFoS0Fsc2hmUnplc0x3UEZQMnRiZTN0Mml6?=
 =?utf-8?B?eWZDaXIxTGdYNVhuWkw3eWFDMjg0MlJDVjRBa0JiTXNtakJJY045UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0541df0a-a1f8-4ddf-3404-08de59f8440f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 20:53:16.0773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQZf+miSC5KtlFeAqAtdrRHNxNZIUpy8RfwxXYQdLlbxXAxs5YPy6nxlc36aFHsh8lWLhKHyNTUAZcDwTqOcPEywzayWXBR+zglEt/Z2s9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8792
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15896-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,ziepe.ca:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tatyana.e.nikolova@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A15F56D8E6
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2FybG9zIEJpbGJhbyA8
Y2FybG9zLmJpbGJhb0BsYW1iZGFsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDIx
LCAyMDI2IDEyOjU1IFBNDQo+IFRvOiBtdXN0YWZhLmlzbWFpbEBpbnRlbC5jb207IHNoaXJhei5z
YWxlZW1AaW50ZWwuY29tOyBqZ2dAemllcGUuY2E7DQo+IGxlb25Aa2VybmVsLm9yZw0KPiBDYzog
YmlsYmFvQHZ0LmVkdTsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IGNhcmxvcy5iaWxiYW9Aa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBb
UEFUQ0hdIFJETUEvaXJkbWE6IFVzZSBrdnphbGxvYyBmb3IgcGFnZWQgbWVtb3J5IERNQSBhZGRy
ZXNzDQo+IGFycmF5DQo+IA0KPiBBbGxvY2F0ZSBhcnJheSBjaHVuay0+ZG1haW5mby5kbWFhZGRy
cyB1c2luZyBrdnphbGxvYygpIHRvIGFsbG93IHRoZQ0KPiBhbGxvY2F0aW9uIHRvIGZhbGwgYmFj
ayB0byB2bWFsbG9jIHdoZW4gY29udGlndW91cyBtZW1vcnkgaXMgdW5hdmFpbGFibGUNCj4gKGlu
c3RlYWQgb2YgZmFpbGluZyBhbmQgbG9nZ2luZyBwYWdlIGFsbG9jYXRpb24gd2FybmluZ3MpLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQ2FybG9zIEJpbGJhbyAoTGFtYmRhKSA8Y2FybG9zLmJpbGJh
b0BrZXJuZWwub3JnPg0KDQpBY2tlZC1ieTogVGF0eWFuYSBOaWtvbG92YSA8dGF0eWFuYS5lLm5p
a29sb3ZhQGludGVsLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRt
YS91dGlscy5jIHwgNiArKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3
L2lyZG1hL3V0aWxzLmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvaXJkbWEvdXRpbHMuYw0K
PiBpbmRleCAwNDIyNzg3NTkyZDguLjU5ZWY5ODU2ZmQyNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9pbmZpbmliYW5kL2h3L2lyZG1hL3V0aWxzLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5k
L2h3L2lyZG1hL3V0aWxzLmMNCj4gQEAgLTIyNTcsNyArMjI1Nyw3IEBAIHZvaWQgaXJkbWFfcGJs
ZV9mcmVlX3BhZ2VkX21lbShzdHJ1Y3QNCj4gaXJkbWFfY2h1bmsNCj4gKmNodW5rKQ0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaHVuay0+cGdfY250KTsNCj4gDQo+ICBkb25l
Og0KPiAtICAgICAgIGtmcmVlKGNodW5rLT5kbWFpbmZvLmRtYWFkZHJzKTsNCj4gKyAgICAgICBr
dmZyZWUoY2h1bmstPmRtYWluZm8uZG1hYWRkcnMpOw0KPiAgICAgICAgIGNodW5rLT5kbWFpbmZv
LmRtYWFkZHJzID0gTlVMTDsNCj4gICAgICAgICB2ZnJlZShjaHVuay0+dmFkZHIpOw0KPiAgICAg
ICAgIGNodW5rLT52YWRkciA9IE5VTEw7DQo+IEBAIC0yMjc0LDcgKzIyNzQsNyBAQCBpbnQgaXJk
bWFfcGJsZV9nZXRfcGFnZWRfbWVtKHN0cnVjdA0KPiBpcmRtYV9jaHVuaw0KPiAqY2h1bmssIHUz
MiBwZ19jbnQpDQo+ICAgICAgICAgdTMyIHNpemU7DQo+ICAgICAgICAgdm9pZCAqdmE7DQo+IA0K
PiAtICAgICAgIGNodW5rLT5kbWFpbmZvLmRtYWFkZHJzID0ga3phbGxvYyhwZ19jbnQgPDwgMywg
R0ZQX0tFUk5FTCk7DQo+ICsgICAgICAgY2h1bmstPmRtYWluZm8uZG1hYWRkcnMgPSBrdnphbGxv
YyhwZ19jbnQgPDwgMywgR0ZQX0tFUk5FTCk7DQo+ICAgICAgICAgaWYgKCFjaHVuay0+ZG1haW5m
by5kbWFhZGRycykNCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiANCj4gQEAg
LTIyOTUsNyArMjI5NSw3IEBAIGludCBpcmRtYV9wYmxlX2dldF9wYWdlZF9tZW0oc3RydWN0DQo+
IGlyZG1hX2NodW5rDQo+ICpjaHVuaywgdTMyIHBnX2NudCkNCj4gDQo+ICAgICAgICAgcmV0dXJu
IDA7DQo+ICBlcnI6DQo+IC0gICAgICAga2ZyZWUoY2h1bmstPmRtYWluZm8uZG1hYWRkcnMpOw0K
PiArICAgICAgIGt2ZnJlZShjaHVuay0+ZG1haW5mby5kbWFhZGRycyk7DQo+ICAgICAgICAgY2h1
bmstPmRtYWluZm8uZG1hYWRkcnMgPSBOVUxMOw0KPiANCj4gICAgICAgICByZXR1cm4gLUVOT01F
TTsNCj4gLS0gMi41MC4xIChBcHBsZSBHaXQtMTU1KQ0KPiANCj4gDQoNCg==

