Return-Path: <linux-rdma+bounces-9419-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B34A88878
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 18:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D627A54C3
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 16:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A37289379;
	Mon, 14 Apr 2025 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjNDF1CS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5377288C81;
	Mon, 14 Apr 2025 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647490; cv=fail; b=YXeuOdjOv0QByOl4hfUYHKXRqOfXnmrJrfnItkt0xluk7Z1Cu1MCmFnu6I5m0VHQIg1oEvHia/l1qZk4xevmTTGDAq9w+PX7s7DiIxbyiIcZ09N8XC3I2yu79gXKEcUh8r+Bqc5UgAeXFFmpCtoKQkneR4jabN5OFas1coQV0TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647490; c=relaxed/simple;
	bh=dHqanLRDVZ/Lqq30QZ412JhELwstBl1/BSQZwWMdZmE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bR1BT/xAh1i7Y2wCEi8YwxvYbWLrxtXkvqJhxNI0gWUnkaS07Vu3MFqF36aC7x/QZILgt5zXbsLHxtew4bBSNK/DNWQkILC+TUHA/PZQ+06yDIg92O77bx/tVocT3f/RdPBT/RTPOctytjkFi6HOTSqIOzFdqZU+Sg5bSEJ+A5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BjNDF1CS; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744647488; x=1776183488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dHqanLRDVZ/Lqq30QZ412JhELwstBl1/BSQZwWMdZmE=;
  b=BjNDF1CSi/RqbWfxuWWlHiy+M/bm5r5gxFEVWM9it6CuQow4fN8T54Ky
   HZN0JcqHwNTIgbH6XIOJu0b9hTGiTK6LHoQOKFL5D0ZrsmDVEPElGDexQ
   Wd1yQbKwgwnhRnv7+hJ25VB8Ete/T8Zspv8fG8sBRVIAvanXy69hCvb9a
   kPvQ2MixhVEbe2ZLU/+R46UfDTUTXCaQOvIfvBCNMK3U6I8cuvraSx5L/
   WuGPX0E65z/FyOu3KaCduGzUvCVHLLc6BLQ7T8ZUcpAbu5g8eQiQgHfP7
   GRWR89CQbup17nQgzZwVh3ITudJBkvZ5GizlPQFGM6dBp/C7WqG1N4K3Z
   g==;
X-CSE-ConnectionGUID: rQHki9ADSGqlW9ukjc+Xgg==
X-CSE-MsgGUID: DBh0zTQvSwugFddO/xqOCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="71515629"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="71515629"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 09:17:53 -0700
X-CSE-ConnectionGUID: mSZV+hqJTmiwEASlvcuphQ==
X-CSE-MsgGUID: rh9gb+mKRwaCVnR0x8VD3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="160825196"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 09:17:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 09:17:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 09:17:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 09:17:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxuG19sD2/c7o4m9J5YLoQ2XHBWzEYQbEcPJpWDFg5q+rpDU8HXLzAJw9dViDHyW6SxZS6qSRiNg5e2ObPOeZ40qLp4puvn06B5u4ligvjwlo/lUq6piOmWUvac6PqQpSqrBvk+FGecUcnFJ+tq04pZoIMDnmyC7bKHQxlYyFTY/TzoqHRBXBl9hvRV/vExISbCMXrtaW9tWJu7XhhUAEzbflbEuuFozk1uERj2yxbtcLd2FByLrgn9OUyR0a1GXvEDMRckC77LI4RkBkjeCDR3bnr80RS1LHcaY0v3yUH/g1XS145qcd0E5Zlkmv8K3QiZK/Bf6DEYVYSImIlifsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHqanLRDVZ/Lqq30QZ412JhELwstBl1/BSQZwWMdZmE=;
 b=Yn9xk1IfkfVVU7vutw13pcKqF6ctnDBYfzKTenulpbFBsnr2scRdFhw/iBJJtUxGSlNvsrV1VaBAsX6BMVFZf1luuV92Oj1D/9Tfw1Ogq15+nwNMV6yyCrcREUQKK4arwi/42/xMD7E3FrsWfGMsXY1RLRx1jj4BVn10eHw6Hj0RgHHfBZ1/7+DqoEWBJ6y8DNfGLm0F2pK4f5s34GrCpEANjKtzJyrExXcw5YtYMN0Fu5FK98U2LlbKHOUnPMDpHSuiv64Ubl7R0ge8vFDerYz8NQl3Gck3WJwMz0dAtgBGLC6LubQ3qqj8ppUGwr22UnbyQEDKI5ViBLwem34H9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by CY8PR11MB7394.namprd11.prod.outlook.com (2603:10b6:930:85::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 16:17:49 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%3]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 16:17:49 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>,
	Jeff Johnson <jjohnson@kernel.org>, Loic Poulain <loic.poulain@linaro.org>,
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini
	<francesco@dolcini.it>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Dumazet,
 Eric" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
CC: "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
	"wcn36xx@lists.infradead.org" <wcn36xx@lists.infradead.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next 7/7] net/mlx5: Don't use %pK
 through tracepoints
Thread-Topic: [Intel-wired-lan] [PATCH net-next 7/7] net/mlx5: Don't use %pK
 through tracepoints
Thread-Index: AQHbrVDf9IbbgXfiQ0+0G+yfe2tnV7OjVtLQ
Date: Mon, 14 Apr 2025 16:17:49 +0000
Message-ID: <SJ0PR11MB586686DC91E86402285CB8ABE5B32@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
 <20250414-restricted-pointers-net-v1-7-12af0ce46cdd@linutronix.de>
In-Reply-To: <20250414-restricted-pointers-net-v1-7-12af0ce46cdd@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|CY8PR11MB7394:EE_
x-ms-office365-filtering-correlation-id: a42ee9fe-55bf-43b3-eff5-08dd7b6fe645
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NlBIQWdxTHhkUi9kTDZMS2VyMFNuL2V5Vjdzb0hsMFBLSWo5ZE9ZMDJ0SDk2?=
 =?utf-8?B?dzlGakxTSjZyeDBZVEUxVHFIZmNZditkUUZpblFodzkxcFd6ZFlGVlRTOS9i?=
 =?utf-8?B?aFlYNkxza0tSRjNza2I1dUtlQXVRd0l2b09zVFVFMU9TZk5EcVAyS3JIcjhG?=
 =?utf-8?B?ZzBpbHZzM2xMSTdmT25jNUFFUGRrc2UzTTZ3T1FBWldteVZhN2xSMzliYWpu?=
 =?utf-8?B?V21ldjg1Y2tPR1BYQjl6ZGJsUlpUVXNxVTBhMGRUUmQ2U3F3UHFURkZMUVgx?=
 =?utf-8?B?TjFQVWhqcGMwTlhCdXdDNnBzQ1JRWFh3Wld1bnNYZnBwOXBJaVZaVWJHK0hp?=
 =?utf-8?B?RUNCUWI3d0lYbXYyWmk2S2NOU3VIajJlSXYxd0ppbTR5ZFFQSVZEcFJLcWlP?=
 =?utf-8?B?TXM0Zzl0Y2hDclV2RWUrend6VnNHL01Kb08wRTBkL3c1MmZjNkVlRG9SL3lE?=
 =?utf-8?B?WDlEMTZzNVNjSFZ4RnAzNFpLUTVyaVBoS1VkdTk2TEowSG9hRzJTZFNpNDl6?=
 =?utf-8?B?YWFaRXlBcTdtZXFrQTkrOEJrc2xuYXdNQjNmcjh2dDh6eWUxMWx3LzgxdjVr?=
 =?utf-8?B?eXZZYm5TbVk1OEJBSFZGU2lSeGhwY3FEWiszRElkM0ttQmYvNTQ1cUhpWDZn?=
 =?utf-8?B?VjhWMU9VVTFHZkRvYSsrQndMaDU4U0pLV3dNS2toM3dpT2k5cHcyWE1BeFRt?=
 =?utf-8?B?MDFEeUhleUZCdm5BWHZZUEtYV0xJMzUwc3pPMklXSTNaVytoRGMyT2VNWnEy?=
 =?utf-8?B?RTVlbFpEOW1yRWs2MUNJSFIyUWtZU2RZeFVYZ2hvbGhGV01CSitKVHVzVDNo?=
 =?utf-8?B?dXVOdk9RUjBDQmNFRFBoU0UzcG94enVZZGtEUWZXRUtTOFN0eDBCZU5lOXk5?=
 =?utf-8?B?RVpzTGMyWkoxRzRIbm4xYlZDR2hVKzN1ZkIyMTVEQytxdGViMU9XUFpQWHBz?=
 =?utf-8?B?dUtIRlhNNUVLZXJYWWVGZFY3aEZlT2NTWkFjSUxoZmMybzYrWFZMWU5GbXky?=
 =?utf-8?B?T3BOckl0Y0xxZ2I3eUovdVRuc0ljV1ZRenpRTnBSM3pFRU5waTJGUHBxVlJP?=
 =?utf-8?B?MUpmT1A4ZHJadEdmSFNNNWF2QjAvQlFNTlJWUnlOYytYVmtudThVY0l3dzFN?=
 =?utf-8?B?Y216WGRBa0VXZ0NOUEZZb05QVWg5dm5QZ0hYM1U1aUNraFBLd244am1Zbm1E?=
 =?utf-8?B?VGs2SFVnSnpZUlFEZzFIVHVpY1lpaENIU0RYL2FYeEZUbWlLQVd3L0F5bGtC?=
 =?utf-8?B?S2pSMy9lYlJoSmxIcytIazhFZkg5c3pVZEp5aHc3djBQN05ra3I3WktUYXB5?=
 =?utf-8?B?WnkrVHpCcU0wN2lOcGEvdm01SXpsN0lodWNZWjVtVGZwb1ZuWjhCQlVqQUp6?=
 =?utf-8?B?VUlQeitGZ1ZOMWUweTdvZkRwQW5scnBLeDVTbDF5NzJ3NHFLZTh5OS9RZ1Yv?=
 =?utf-8?B?eVBBNCtEa2U2bU5TMXgvekQ4Mjh6QU5PUk9US0Y2N09IUjZzY05WeDNNTkgr?=
 =?utf-8?B?T21hSWdJV3h5UGN3bnNueVVXTVEvNCtQQWJZTkppTVlXM08xWTk5aDVMRUpy?=
 =?utf-8?B?Q1N1V2tId0EyNW9ySDJkNkd1bXMvYlJHNzI2L2VGRG14blQ1RGxqUlA4VjZv?=
 =?utf-8?B?TktVMEFkbjQ2NnRRZCtGVGozVE5LUll4YjB3SGpXRWVOeTdIMDRWYWJJY2NT?=
 =?utf-8?B?bXVMZWdSSjkva2xMSXhSMWorb3U1MzltRnkzUXZjaXZEVUJCcDU2RTlGWGt2?=
 =?utf-8?B?Zjg5L0VTUTBiVFp5ZFExeHh4WWpLRVBwalFCSHo2V2txdTg0Q1djNGQrMm5W?=
 =?utf-8?B?MW9NM0NGcnM5dTUwOC8yRWNoM3ppd3U5bHpwRmtPLzhyM2FCdWI5cUdlY28r?=
 =?utf-8?B?aCtPN0xzTEZXM3JCTXl1QVJMT21tWVFWajZhSkxHbUZTWEV4UlkydGZUNHQy?=
 =?utf-8?B?YWhRQVB4aXNlUnplM2tYc1dGVy9FdXpwZjFDK1RIT05iQWEwbnVpRCtNYStT?=
 =?utf-8?Q?C1jd04EvX2NiCDpwvXPjZN3A6s7HBM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NE1zck9jUUcyYk5EVmdnUFhoaU1SSzExUG9zZzhmVWcyeGJJV1JEcVFXVjhk?=
 =?utf-8?B?NnNHZWc5VHIzVFBGaWx0b3ZtY29NZndiQ0FQYzFDZEZUNzdRTEYrOEZ4QWFL?=
 =?utf-8?B?ZDBCOTYyblNaWHovc25rR0tYbmw3aUNYblhRRG8rcUhodmhnWUxEcERxWHRR?=
 =?utf-8?B?UUpQUXZ2TnRnNXkyU2FHRDk2RktWUzVUWHl1WE02MDd4eDFQa0xPamZrV3M0?=
 =?utf-8?B?SzJlSnh2MDQzVm9USjJmekZEYVljNUhvY0lLc1VDMHFVUW8xS0RGMGNaL0Nq?=
 =?utf-8?B?NXBTcG5jYVlNanZGeVU0ajcwSmZyMXFldUpUYVo2dEZ3SHN3aHZGTzFJZmpr?=
 =?utf-8?B?YWlWLytYKzNyVzJPelhGTDJJYUtkeExOVDVyd21UT3M3bjByUXErUXNjd2k3?=
 =?utf-8?B?RjZzdk1oejJnTnBiZzFNc1E0aEVobUtVd1Nnc0dBWVhsMkNjMjBqMEdUSTZl?=
 =?utf-8?B?NVl3TlpWVk4zS09tZ2lvWk1nUHlNLzB2VU1aM2tqRndYK012RU1URW5Zb1di?=
 =?utf-8?B?b05mTFhjUUhiL0E5cjNDYmY0NUNVdXE3YlN1SHcxcDkxcndCUk04c0ZBeFF1?=
 =?utf-8?B?ME5pV21IdUJrb0p4UGlmSC9Kb25yQnlPNStQT0s2SThXbEZDKzZHeUZYRWpy?=
 =?utf-8?B?WFVxUlBwS1pzVkVBcXFPd2Y2UkJxQVRpUUZNLzRlOTMvNmlTbWp0RGJ0bDFk?=
 =?utf-8?B?VjdGMUpPZmRoRVRZTk5OL1RCRmZhdWtSWjVvZ1IxN3piUnBwOSsrRFNYdWdK?=
 =?utf-8?B?NE1nT0ljMlFCV1ZOdEQrRlkramFtUTQvbG1kcVd5djM2OXk4SzF0SCs0dDJi?=
 =?utf-8?B?eElPSEJWOGlyUzJDelh3T3FpVURHRm9JMG1mYVY2ZGRXSTVYU2pveEkvYzc4?=
 =?utf-8?B?UjMyWUpuSUE5cDRZM3dLWHEySEgzU3ZmYlgvUWRYbTdiRmpVSWlxLzlCL3dL?=
 =?utf-8?B?ZTM1bi85T2dmS1VpWEVuMXRKcm9Oc1VTdzlDczZYNnF3OXk1R1dKa1hjQzky?=
 =?utf-8?B?TEFZOUVaSUhVZzJ0cnFzOENxVlhFRm5FQmJhSDFVNTVlTHp3b3E3QjdnK0k0?=
 =?utf-8?B?dlNsYXIxRVY2dXFaejBVa0l3NnNmbFZkMnJjUFMyOEc2ODlIUi9JazJtYkJx?=
 =?utf-8?B?R20vZ0JWK2RvZjQ2VytVcEw3TURlN3M5LzFML0k0Q20zUEN5bFJIdVh3aysw?=
 =?utf-8?B?RHpLQzdlWThNWnRDb1RYN3VyekIzTDNWT2lsSkNza1lKaHM1Y3NleUlrNGNt?=
 =?utf-8?B?dmVxK0tPUXZjLzl0alB0QXQ3emNUNFNZcDVQTlZzWXpDWlBrNTNtL2ZMamIw?=
 =?utf-8?B?NjdCOU81NmFsMmhiaHBUbVdJNWZ6QWVNTTNVVG92enFHK1U1K0grL25iTk04?=
 =?utf-8?B?OWQyR1BUWjRqVnVpSzh0QzQ1RmNNUGw0Zkd3cUo1QTRsQ2k3T0l5bytSQXdh?=
 =?utf-8?B?OFdDcGRZMDJZNlh1eU5EYXB2K09XSkNadFBRVm93eUp6bzMwdzNkQk9VNzhy?=
 =?utf-8?B?cDhMbHZlQUhGWHdXTm80MzBRT3RDTUNLa3ZpamdLMEhtYXFRZE1NQ2E5bTFz?=
 =?utf-8?B?K3Zoc1h6UTdGMFJabmQ5ZVYrR0tlQVBnb01mNlRGTVdUZFAxejA5eW5BbFRR?=
 =?utf-8?B?K1dTSFA5YkNNMXpmaVRaYUhsdWJBWTcwdCsrZW9paGtlZEZ4M1J4V1kzQVM2?=
 =?utf-8?B?RHZEZVh6TE56V1ZkSFNHaFRYZmpuTUhJMW9aQXIwbHA3T2c1NHYyWmZnRXRK?=
 =?utf-8?B?b094NEVmdXVBQ3AyYzNNTnlYR2xuZzhDMEQwbi9yT3FqNlFNZnRGbnhoWFBa?=
 =?utf-8?B?OEZVM1NjWWtnUWNUeUx1OVdXVnAvOGloaytDS0FKcEZvNUpPYWJWRlM5Z090?=
 =?utf-8?B?MWNPN0JzdU5XZnc2dERRZDMwNmFXOGVheFEvZXJyaW93Njd0Mm04QnVvMHN6?=
 =?utf-8?B?N3g3Wml3VmVLQ1VCTFM2bGVpWDE3NHl1Z09yMXptUGdxWCtidzJzWEM1d2l1?=
 =?utf-8?B?UVdQVWMxSnZDTlZOeVNKRUdrSjQ0Q2haWWNIcXEzTUxXQWxKZXQ1cHZ2VWVm?=
 =?utf-8?B?UnBaYklZOTJhTHdIWnc3b2xiblRzdVFHSVRQb1hFTHZVVXd0U25kUUpwZFZE?=
 =?utf-8?B?TUZuQ1YybzNIdHluWUh0ckQrS2lMejR4M3ZuTjgvbzJMbjFhdjVtM2hxZEhr?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42ee9fe-55bf-43b3-eff5-08dd7b6fe645
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 16:17:49.1028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOxxYeOkL15GJSIf0inNJV2O5USz1aYq5920FU0V6Y0hkMf/7Q251CUfsISxnso1t5Xy94DGxNAD6dPFtc3R3YYPAMIwuf1r9poEkp+saWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7394
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYgT2YNCj4gVGhv
bWFzIFdlacOfc2NodWgNCj4gU2VudDogTW9uZGF5LCBBcHJpbCAxNCwgMjAyNSAxMDoyNiBBTQ0K
PiBUbzogSmVmZiBKb2huc29uIDxqam9obnNvbkBrZXJuZWwub3JnPjsgTG9pYyBQb3VsYWluDQo+
IDxsb2ljLnBvdWxhaW5AbGluYXJvLm9yZz47IEJyaWFuIE5vcnJpcyA8YnJpYW5ub3JyaXNAY2hy
b21pdW0ub3JnPjsNCj4gRnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjb0Bkb2xjaW5pLml0Pjsg
Tmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0c3pl
bCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IEFuZHJldyBM
dW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+Ow0KPiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRh
dmVtbG9mdC5uZXQ+OyBEdW1hemV0LCBFcmljDQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFr
dWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVk
aGF0LmNvbT47IFNhZWVkIE1haGFtZWVkIDxzYWVlZG1AbnZpZGlhLmNvbT47IExlb24NCj4gUm9t
YW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPjsgVGFyaXEgVG91a2FuIDx0YXJpcXRAbnZpZGlhLmNv
bT4NCj4gQ2M6IGF0aDEwa0BsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBhdGgxMWtAbGlzdHMuaW5mcmFkZWFkLm9yZzsgYXRoMTJrQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+IHdjbjM2eHhAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtd2lyZWxl
c3NAdmdlci5rZXJuZWwub3JnOyBpbnRlbC13aXJlZC0NCj4gbGFuQGxpc3RzLm9zdW9zbC5vcmc7
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOw0KPiBU
aG9tYXMgV2Vpw59zY2h1aCA8dGhvbWFzLndlaXNzc2NodWhAbGludXRyb25peC5kZT4NCj4gU3Vi
amVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IDcvN10gbmV0L21seDU6IERv
bid0IHVzZSAlcEsNCj4gdGhyb3VnaCB0cmFjZXBvaW50cw0KPiANCj4gSW4gdGhlIHBhc3QgJXBL
IHdhcyBwcmVmZXJhYmxlIHRvICVwIGFzIGl0IHdvdWxkIG5vdCBsZWFrIHJhdyBwb2ludGVyIHZh
bHVlcw0KPiBpbnRvIHRoZSBrZXJuZWwgbG9nLg0KPiBTaW5jZSBjb21taXQgYWQ2N2I3NGQyNDY5
ICgicHJpbnRrOiBoYXNoIGFkZHJlc3NlcyBwcmludGVkIHdpdGggJXAiKSB0aGUNCj4gcmVndWxh
ciAlcCBoYXMgYmVlbiBpbXByb3ZlZCB0byBhdm9pZCB0aGlzIGlzc3VlLg0KPiBGdXJ0aGVybW9y
ZSwgcmVzdHJpY3RlZCBwb2ludGVycyAoIiVwSyIpIHdlcmUgbmV2ZXIgbWVhbnQgdG8gYmUgdXNl
ZA0KPiB0aHJvdWdoIHRyYWNlcG9pbnRzLiBUaGV5IGNhbiBzdGlsbCB1bmludGVudGlvbmFsbHkg
bGVhayByYXcgcG9pbnRlcnMgb3IgYWNxdWlyZQ0KPiBzbGVlcGluZyBsb29rcyBpbiBhdG9taWMg
Y29udGV4dHMuDQo+IA0KPiBTd2l0Y2ggdG8gdGhlIHJlZ3VsYXIgcG9pbnRlciBmb3JtYXR0aW5n
IHdoaWNoIGlzIHNhZmVyIGFuZCBlYXNpZXIgdG8gcmVhc29uDQo+IGFib3V0Lg0KPiBUaGVyZSBh
cmUgc3RpbGwgYSBmZXcgdXNlcnMgb2YgJXBLIGxlZnQsIGJ1dCB0aGVzZSB1c2UgaXQgdGhyb3Vn
aCBzZXFfZmlsZSwgZm9yDQo+IHdoaWNoIGl0cyB1c2FnZSBpcyBzYWZlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogVGhvbWFzIFdlacOfc2NodWggPHRob21hcy53ZWlzc3NjaHVoQGxpbnV0cm9uaXgu
ZGU+DQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25v
dkBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4
NS9jb3JlL3NmL2Rldi9kaWFnL2Rldl90cmFjZXBvaW50LmggfCAyDQo+ICstDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQN
Cj4gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvc2YvZGV2L2RpYWcv
ZGV2X3RyYWNlcG9pbnQuaA0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUv
Y29yZS9zZi9kZXYvZGlhZy9kZXZfdHJhY2Vwb2ludC5oDQo+IGluZGV4DQo+IDA1MzdkZTg2Zjk4
MTdkYzgwYmQ4OTc2ODhjNTM5MTM1YjFhZDM3YWMuLjliMGY0NDI1M2YzMzJhYTYwMmE4DQo+IDRh
MWY2ZDc1MzJhNTAwZGQ0ZjU1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
ZWxsYW5veC9tbHg1L2NvcmUvc2YvZGV2L2RpYWcvZGV2X3RyYWNlcG9pbnQuaA0KPiArKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvc2YvZGV2L2RpYWcvZGV2X3Ry
YWNlcG9pbnQNCj4gKysrIC5oDQo+IEBAIC0yOCw3ICsyOCw3IEBAIERFQ0xBUkVfRVZFTlRfQ0xB
U1MobWx4NV9zZl9kZXZfdGVtcGxhdGUsDQo+ICAJCQkJICAgX19lbnRyeS0+aHdfZm5faWQgPSBz
ZmRldi0+Zm5faWQ7DQo+ICAJCQkJICAgX19lbnRyeS0+c2ZudW0gPSBzZmRldi0+c2ZudW07DQo+
ICAJCSAgICApLA0KPiAtCQkgICAgVFBfcHJpbnRrKCIoJXMpIHNmZGV2PSVwSyBhdXhfaWQ9JWQg
aHdfaWQ9MHgleA0KPiBzZm51bT0ldVxuIiwNCj4gKwkJICAgIFRQX3ByaW50aygiKCVzKSBzZmRl
dj0lcCBhdXhfaWQ9JWQgaHdfaWQ9MHgleA0KPiBzZm51bT0ldVxuIiwNCj4gIAkJCSAgICAgIF9f
Z2V0X3N0cihkZXZuYW1lKSwgX19lbnRyeS0+c2ZkZXYsDQo+ICAJCQkgICAgICBfX2VudHJ5LT5h
dXhfaWQsIF9fZW50cnktPmh3X2ZuX2lkLA0KPiAgCQkJICAgICAgX19lbnRyeS0+c2ZudW0pDQo+
IA0KPiAtLQ0KPiAyLjQ5LjANCg0K

