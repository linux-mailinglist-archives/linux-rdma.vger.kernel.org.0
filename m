Return-Path: <linux-rdma+bounces-15119-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B510CD3C32
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 07:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5750B3006AAC
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 06:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997721F12E0;
	Sun, 21 Dec 2025 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AOemkTDE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012031.outbound.protection.outlook.com [40.93.195.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65AB2745E;
	Sun, 21 Dec 2025 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766297832; cv=fail; b=HR6WVYB5Nl/CsE7z2Rapf6Xh73YYaIn4CvPkSCLE53IGFORRXZNVWqjMaD33h3oqy6KhtS4fddp1Yws4dhmVuusV+YizO4t0hOC1dgDg7kEAcIaljIId1DPVp10S/5s/av8JyFpcpxwA9SrL+HLnCVCKZYx3BcTESqDvkHsAaEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766297832; c=relaxed/simple;
	bh=gG5AWoEzILR4f72ZlnwFnrrnvCMBLAUpkuEPAgCIAYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ihU42cfMRu68Vz2JiSr7tETtomqFefk6NggPbC6WEFN68X5o1tenzM20nqwid2X1TyUjJZ66wS4KHsTZMRLmMCarpF1dj4jjipf+6eb5+t3NmG62UFrDpQKlwT9Hw2kXeh6FxGiwu8s+SW1X7MZK0YPnZ1hQIOS6ZiORKK+WiiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AOemkTDE; arc=fail smtp.client-ip=40.93.195.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIz7upptqw1QFaWJbw2JKHS0Fmgo8cuU70zQtf7XPDZ4Fmx3T1plVaNz59k//8gTb3RljgltbMmK1w4N7BC6YC3oTlFZ7E8xCGIMZJ0Wp9Ir4aD2Xfc1HwLJclvBaSVobpaJxfTVBePOrbOF+S5MfN2SZJlS1I3ZmHxQbh6PFw0z89SwFm6Yh73HQQx+lh5JXQPhwAjPDT1aozMHvERGIgivnL3BgFDMS/NqAihGJzoZlprw800FpuzHzRfduzrd2mJC+2IMnDfNdUh1VWsfpZTd9o1KOLFHmTDrwP4sVdtrtUzyYjHVlnB566zjNuqS+tBXjugxGPsuYSg/BvLY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gG5AWoEzILR4f72ZlnwFnrrnvCMBLAUpkuEPAgCIAYs=;
 b=NX8AluDZMEKejD6/zXvLgu4P40s4XB5istGXbgBdUILMe6OQalZ2yQFOevamrUc1mGn1wssSVALhI4KUwfe89P6nJ+3/TlvRYnZJ7PjWp9WOVGWZNEdpe5VNwZZsO7dpzwRhwr/B8Ivm0eVmT1ywsciQwMIp+4UZB/rVIJijzGjnXt++YfLy3b2Yg4hrUPBJaDINAzw0Zbg5/OigDuAwox1uOHMpu3QGfYlmcQTlz/JrGbT5GPGkUvQhqH+IzOPepKNYYMX4leY+hOG6W6IjzfHY3wJQ6i0hpo+mTjH/g3F4o56hbqiDbfiyeN7OsE5uXpHtW44QJn7nH7O+tAk8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG5AWoEzILR4f72ZlnwFnrrnvCMBLAUpkuEPAgCIAYs=;
 b=AOemkTDEqmzkLMfOpehjd4lWGUfBPRabk2WUs5PJwm29AcbQZkulAe1wYWygjkvK5qbYx3AxdjzHUO4HmS3NxBfjn0Xk4VPZwwhvors2FghhrtPASrXcnpxOdM0Svx9yvRRvZ+2ngadKPmEnD2Z0cjsxI+GqyMCkAXZPh9jlOWQ2US3U/sChdoRgY9FWvGtjf13nWIF/OvRrQUifcP6eYOPkfxLD3FrMVI7jxngf2rX+xWxT97w5g11fadlP62TuO3Y80sHmCBF2qDenihW3cmKWiUG9FPa4zgNm/ioWlntXaqNJr99pbrRpOXM6Pp+RqYcluEAPISYkOk2b+khnBQ==
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sun, 21 Dec
 2025 06:17:05 +0000
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::99df:c2ad:bede:3eec]) by SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::99df:c2ad:bede:3eec%4]) with mapi id 15.20.9434.009; Sun, 21 Dec 2025
 06:17:05 +0000
From: Parav Pandit <parav@nvidia.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Mark Zhang
	<markzhang@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>
CC: OFED mailing list <linux-rdma@vger.kernel.org>, Network Development
	<netdev@vger.kernel.org>, Majd Dibbiny <majd@nvidia.com>, Doug Ledford
	<dledford@redhat.com>, Yuval Shaia <yshaia@marvell.com>, Bernard Metzler
	<bernard.metzler@linux.dev>
Subject: RE: [PATCH] RDMA/core: always drop device refcount in
 ib_del_sub_device_and_put()
Thread-Topic: [PATCH] RDMA/core: always drop device refcount in
 ib_del_sub_device_and_put()
Thread-Index: AQHccVYGCeEA+w8NOkWyq9zr3Dj5erUrn5kg
Date: Sun, 21 Dec 2025 06:17:05 +0000
Message-ID:
 <SJ0PR12MB6806ACBA1F41F8726F689AABDCB7A@SJ0PR12MB6806.namprd12.prod.outlook.com>
References: <30ec01df-6c32-490c-aa26-c41653f5a257@I-love.SAKURA.ne.jp>
 <8f90fba8-60b9-46e2-8990-45311c7b1540@I-love.SAKURA.ne.jp>
 <1722eff3-14c1-408b-999b-1be3e8fbfe5a@I-love.SAKURA.ne.jp>
 <9b4ce0df-1fbf-4052-9eb9-1f3d6ad6a685@I-love.SAKURA.ne.jp>
 <13f54775-7a36-48f2-b9cd-62ab9f15a82b@I-love.SAKURA.ne.jp>
 <ace1ebe4-4fdb-49f4-a3fa-bbf11e1b40ed@I-love.SAKURA.ne.jp>
 <20251216140512.GC6079@nvidia.com>
 <10caea5b-9ad1-44ce-9eaf-a0f4023f2017@I-love.SAKURA.ne.jp>
 <b4457da3-be2e-4de3-ae16-5580e1fb625c@I-love.SAKURA.ne.jp>
 <98907ad9-2f85-49ff-9baf-cff7fcbc3cbf@I-love.SAKURA.ne.jp>
 <80749a85-cbe2-460c-8451-42516013f9fa@I-love.SAKURA.ne.jp>
In-Reply-To: <80749a85-cbe2-460c-8451-42516013f9fa@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6806:EE_|PH7PR12MB5594:EE_
x-ms-office365-filtering-correlation-id: 47a7ce24-7ff8-472c-8544-08de40589051
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzFYU1JnTm5iZDd1MCtlQzNtdUJ4ZUp1YTg2T0dQbG5FMUY1MjB3VmtUSkht?=
 =?utf-8?B?S0Z5a0FIWElCdW1Ub1ZvSzV5SmdLTXN2dTkyTzV6c0c4YTdpVlh2RVJXdStW?=
 =?utf-8?B?VXhZdWNKOGhMaG4yTGZNVnBFTFhSQ3JpSDkvVkIvNEtSYVE1UkI4a1JNY0RJ?=
 =?utf-8?B?Ry95VlZMNGMwbFhUdmErZWEvVC9HY0V6M2JMd3RNLzhwMlg4VWI0WlFqK2E2?=
 =?utf-8?B?T0k2VTQzaE5jREVGc1lnQ00zeThiWjJHb3hxaG9ZekUrSjNUbzFXTWxnbkdV?=
 =?utf-8?B?NE1DVFlzNzlrZWxrZGFsTVNGQXo3M1ZmQTNKdGVSa1ZxbmRjOEMxKzc0dnFQ?=
 =?utf-8?B?Uy9UbUpsTTZoRk4zNVpEeEl5Q2RXK2l6U3d0T2o2Q25UY2p5TXVjdEMxaU1F?=
 =?utf-8?B?TmJOYVkzbGRCc0R4dElIN2V5TmlOay9wZytzOFVmOXhlSG8xNUN0S2g2Uytv?=
 =?utf-8?B?cDFIS3Z2MHJVRW5TNGN1LzBjWVFGWnZiYUNPMHR2dktNZ2srbmVORjZaakpx?=
 =?utf-8?B?cHJFNVoxRkRUZk5JZHFhdmRZY28zaVJSOGNQZ2w4R3pVam9TWG8wcFJkSjY5?=
 =?utf-8?B?YlQ2SEE0TFZrK3hJR3Z1d1FIRTBoeUp3b1J0b21kMTJrRWVjMG93emozTU1F?=
 =?utf-8?B?bnpLYWdIcGE3SHpDdzladFZrYnh5K0t3Y1FPTENjSzRCT05PWmYrc1Btd0NU?=
 =?utf-8?B?Mk9IRkJLcUxqam5hMXJWNEN0eVJEYm1lWU5SRmsyeUNuRitPUG11a3EreFRY?=
 =?utf-8?B?TDduZi9jQ1RKSVJGVVdnd1dGTmtLbDdrMkk4d0ZjUG9VSDFhL05JTzZYOVBK?=
 =?utf-8?B?RWUvVU9LZGN3SDZSM3djOWt6eVIycFY2YTlubG1vTGFOdVRacHQ0c0dlMnRm?=
 =?utf-8?B?aEovcmdqWTQ2ZG5IaEZvUDVCcUorM3FYMUUxQkpHQTRna3RDUVpVRmpWMytj?=
 =?utf-8?B?KzhjN1FFU09EQnI4RFdtVEpGNXhOd2ZzTk0vZEdQVGt2TkhKem1VMEkzUEor?=
 =?utf-8?B?VGhIWm1DWlVxQXBYczJFZ09WdytVai9kK203aGd2SkVqNHIrWTkzWlhWQlhr?=
 =?utf-8?B?RDErMzZMc1RRWmI0SzExMEQ3M1VhWDNYOUZqSFN6ZjZHb3p6emZiWXJrbkt2?=
 =?utf-8?B?cGRUQzQwWHBpOHRTd01rNWY0NjJSNDF3dnN6c0MzeGpka01ORHRLalNHdTZK?=
 =?utf-8?B?d1R2VzJMTEx3ckVjVkNnWE56eTZJbGdsQjQ3RFlGUGVIOG50Um1mRy9acVc5?=
 =?utf-8?B?VXQxODVOM1Yram1MblBPa21Kc2lobFpZQ05YeWY3b0k4NWEzU0ljbUJSWTVN?=
 =?utf-8?B?RnBWNEtRZnlTb294NjBOdHRISFF6eml6ay9xdE8xbyttamxyaUpUYzhFT0pH?=
 =?utf-8?B?WDJMbzlrYnNqSEJ4SXBMQkRzeS9UazVaOVAycEpZVzllOVFhbVcwRi8zVC95?=
 =?utf-8?B?L0NpWVRmNUJaRTBtVTJDL3M0dzlHWHM3My9keldadWx4TGRHbWpqL09pdjE5?=
 =?utf-8?B?YzdPZldUU1o1Nkh6KzN3amM1RXlVSnRRZno0NlhUNDY0SngwUHhENDFob2NC?=
 =?utf-8?B?eU1NQVJnaEE1NXF5bkdoaUQ2TWowcHVYVEtwMWZjak45QW13aTZoRVV4SWd4?=
 =?utf-8?B?S1I1OTlYSzZRZ0krcnBRSmxUd1JQMSt5NjFTbzlaUDgrOUNSTVBqUFpJa2V6?=
 =?utf-8?B?V21WM0NSV2k1WDcwdy85RGw3a3owQTVnZHEzL2kyOGpJcUxqMnphMGZSQ01o?=
 =?utf-8?B?Z1BRaCtobDBTZk8yYlpQN2FlMVdnOExadWV6SWR6UldwZ0NaSFBrbmQ5aWFX?=
 =?utf-8?B?ZmFZam0yNGhIbjBwL2JsQWg5MFRad00xVGxzcGM1cFNjRWd4S0ZqQlVvS2V5?=
 =?utf-8?B?TVJQL3BsRXhMZmpnbVBwUk94eWlQRGlqcE5ZV0hHUlRsZ3YwaWlUZGxTQ0Vo?=
 =?utf-8?B?aDhkQzg2ajZLMFkrTkF5TUNRL3JqdFNOZXJIajkvdm5Rb09Cc1k1UFA4VGhF?=
 =?utf-8?B?NEpiUEtiamRxd2pySGFDczI5TUhIM3FER3BoQTJUVmdsOTlIdkFCNXY3R0N1?=
 =?utf-8?Q?8r6vxQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6806.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXJGU0lMSXNkbjJUbGY0RTlTa3BsYUN3ZkFYMk9kRk02dE5FZE4rRGlhejVI?=
 =?utf-8?B?U3RpRnVvbGdnS08yVG1zL1gxTUhvd1Q0MVY2dTJ4VEhySklQQ1R2UHoxU2NC?=
 =?utf-8?B?RXl5ZHJFMG4yWmxzcnlQTjNsZkEybTZNTzRBdi82aGQzMU1tUkxpQU12MWgz?=
 =?utf-8?B?dXNFbjFoYTRuS3pSSlB6UkUzSHVJUWFGOCt1NE9FRFRBYS9meVlIT21Ydjdi?=
 =?utf-8?B?am5saG5OdDNaWTJwNTdKa0c0SG82UVpSQzVEMFBUTURieW4wMW1FNDZEYmN4?=
 =?utf-8?B?VS8rWjhMNGIycCsybGpYZ2J2cGZ6cE9uVWl0ZktuQVB2TStqcFh3dERzZjVF?=
 =?utf-8?B?QnlSVFJqY0hUSEJ3Sk5rUWxKTCtlVmxWUEdsbjRzSE0rRCtTZjdKcnJGdFgx?=
 =?utf-8?B?ZmdqakhFYXJwS0JkNjdjc01XYXRacmM3a1JXWjI3QmhvOGdyeUdMeGpqM1NP?=
 =?utf-8?B?b3ROMGIvNnZ6L0RuN1hTNkZUZ3RDdk5ha0ptZUV4MktqK05OMlRVekZZOWlQ?=
 =?utf-8?B?Sm9TUGhWdkZvSXF5YWRFWEtSbXhaQURwNm5CSWVuZmlTbVE5Vm83RkVrZkJF?=
 =?utf-8?B?U0VsT016S0FLVmFncDloUkYvNlJEMWo1S0ZHZ2N0Qmk3Y1l0MUd2a1I4SUZG?=
 =?utf-8?B?cWRMY2Z6bTJxeFFQaURVTGJYOXM1aVNRVDZsbGxPR0tiTUJLUnFrYUJNYmtN?=
 =?utf-8?B?QlVIYWVieGdqOWZqWjFrUTJXcmlUSTkzMmIwK0RibXlXTG5Lb3ZDWFpSeGFX?=
 =?utf-8?B?WEpCTkdiTk16MCtWK21tMmRIVm9Oazh4MXZWQmFtQXhBUnhFQVZZYm5KeDJk?=
 =?utf-8?B?ZkxpUjR5ek5IZTQ0REFpczRyR3BnRDV2N1VKWkZIMjdsaERCamM5b3o1dXlz?=
 =?utf-8?B?NG5yTFR6WUxiRGNXcjNYSDF1R2V5YXdHMlEzV2Z1aFAzcmpmanliS2FkV1ZQ?=
 =?utf-8?B?c0FoUHNUYnM4cEFkcndUMSt2aVFZSkpWYVRtb0lLTDdVbVpvdVJaWDN4Yk9D?=
 =?utf-8?B?emJuTy93NVg3ZUJLVk8zMWRiYVNmQWZKQ0VueXQyekxIK2lOUzJOY1pMZnFY?=
 =?utf-8?B?aXUzbkNXeEVUdEEySTlic2VuRjZ4SFQ2MWNPR0dEZ0RvNEx6M2hMNDZnb1pT?=
 =?utf-8?B?Mms4akVNSkUvN0ZSOFBWL0JuQ1VIRVZBWUVUbHdYa2RwUkwxdDMzaVZDOURo?=
 =?utf-8?B?OGxKTkxudUNNL1BHV1RNT3lSSUw1U0ptbXo5MHVUTDRaU1JFcXBFblAzd0FV?=
 =?utf-8?B?aEJ1eGd5NXBob0Vzemc2dmdvR1MrWlRCQVBCczVmdk1JNUxwbElpWis1Tzl6?=
 =?utf-8?B?amZyMkovM2tRTmtBOWZXVldBOThwY2Y0RGRQQzIyU3VYc0dzYzBFdXhNSkRn?=
 =?utf-8?B?SnNxODJuUDdwakxxc3I0ZTJJeVBrOFpHRUdiS0N0UWJoL295dDVhdmVBRXRz?=
 =?utf-8?B?c25SZXJWaFpKMmNaKzJFOVh6UktyTjhVcm1vQjAvMUV0UTllZEIxajhTckRC?=
 =?utf-8?B?ZmczQ1JYaE1XN3ZXTm9zZVlxYzdhcUMxMkxUajR1RVVIYVZDcEJ5VmQ2NXFR?=
 =?utf-8?B?TnpocG5ZQUd3SUxER1lGMkw2eEdWL1IzK0toQUh4a095RFZjNVUxMEpublNn?=
 =?utf-8?B?SFcvcnJla1pweGxhc004TWttcllLQ0xVYlJtRGxQN3Q0bTRVVStEdFVoNkRC?=
 =?utf-8?B?SXJqcG1DN21kVFQ5MTBrNUVVeFY1TlFDd2JYNXppSWJpMHFzTVdLY1FwUnBF?=
 =?utf-8?B?WWV5Q3grS2ZCZGVGbFRVYXFFUCtFMzNGUFhmNUJIRnI2RDRiZFgwRVZNU2pv?=
 =?utf-8?B?QUw1MFRPa01ZL2FURHZVNVhzTmFpdG5za1o4STR0b0VOQTZ0MFVBRE9xeHht?=
 =?utf-8?B?elk3QVBmT05BdkRaVlFnSmJwbUNKNkRnTlRnRDdqTDRKbWo1TGpsV3NGRTBN?=
 =?utf-8?B?NjhoSjRZUXZwQWlzeEgwL1pGeXhpaFI0S3RRa3IrMk9TOTBXdDRGYnFMUFBE?=
 =?utf-8?B?dFFZR3E5d3p0dTQ3eUtrTjlJbCt1NEY5ZUxmS3h5S2VCcnlRaGp6aTN2R1B5?=
 =?utf-8?B?dU12Wjg4WmgwRWtmazNSbUNjTmVnaXRFWVBBU1lPbHZBdThISXd4dmt4SkFM?=
 =?utf-8?B?dW4xZC9VNFFTRDZyU01pNkxwTTdiYlZ2dys1MzNUSC9wWCt4dW9YdVp1bTQv?=
 =?utf-8?B?dGhqSUdIWW9BUUlxL3dJZkxhNkpYQnh0c29JNlFObURGdFQ4dTk1VWI2cmp1?=
 =?utf-8?B?SVNVSWcyV0JHd1NrdmFVTXpsMjV2b3FscUFublFFTHpjL2dld1gzUnZEUVZT?=
 =?utf-8?Q?4r6t5c/39/zJK0Z+F3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6806.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a7ce24-7ff8-472c-8544-08de40589051
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2025 06:17:05.5273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wvjv5G17mFG6zs6TDh2RVjntZlz0B4AUXhCMviM8px9inVrCjy8MIsuBa+abgh5ECHbO1NGx5ZVqryKI4AumDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594

DQoNCj4gRnJvbTogVGV0c3VvIEhhbmRhIDxwZW5ndWluLWtlcm5lbEBJLWxvdmUuU0FLVVJBLm5l
LmpwPg0KPiBTZW50OiAyMCBEZWNlbWJlciAyMDI1IDA3OjQyIEFNDQo+IA0KPiBTaW5jZSBubGRl
dl9kZWxkZXYoKSAoaW50cm9kdWNlZCBieSBjb21taXQgMDYwYzY0MmIyYWI4ICgiUkRNQS9ubGRl
djogQWRkDQo+IHN1cHBvcnQgdG8gYWRkL2RlbGV0ZSBhIHN1YiBJQiBkZXZpY2UgdGhyb3VnaCBu
ZXRsaW5rIikgZ3JhYnMgYSByZWZlcmVuY2UNCj4gdXNpbmcgaWJfZGV2aWNlX2dldF9ieV9pbmRl
eCgpIGJlZm9yZSBjYWxsaW5nIGliX2RlbF9zdWJfZGV2aWNlX2FuZF9wdXQoKSwNCj4gd2UgbmVl
ZCB0byBkcm9wIHRoYXQgcmVmZXJlbmNlIGJlZm9yZSByZXR1cm5pbmcgLUVPUE5PVFNVUFAgZXJy
b3IuDQo+IA0KPiBSZXBvcnRlZC1ieTogc3l6Ym90Kzg4MWQ2NTIyOWNhNGY5YWU4Yzg0QHN5emth
bGxlci5hcHBzcG90bWFpbC5jb20NCj4gQ2xvc2VzOiBodHRwczovL3N5emthbGxlci5hcHBzcG90
LmNvbS9idWc/ZXh0aWQ9ODgxZDY1MjI5Y2E0ZjlhZThjODQNCj4gRml4ZXM6IGJjYTUxMTk3NjIw
YSAoIlJETUEvY29yZTogU3VwcG9ydCBJQiBzdWIgZGV2aWNlIHdpdGggdHlwZSAiU01JIiIpDQo+
IFNpZ25lZC1vZmYtYnk6IFRldHN1byBIYW5kYSA8cGVuZ3Vpbi1rZXJuZWxASS1sb3ZlLlNBS1VS
QS5uZS5qcD4NCj4gLS0tDQo+IFRoZSByZXByb2R1Y2VyIHN5emJvdCBmaW5hbGx5IGZvdW5kIHdh
cyBub3QgZm9yIHdoYXQgSSB3YXMgaW52ZXN0aWdhdGluZywNCj4gYnV0IHRoaXMgaXMgYSBidWcg
d2hpY2ggSSBjYW4gcmVwcm9kdWNlIGFuZCB0ZXN0IHVzaW5nIHRoZSByZXByb2R1Y2VyLg0KPiAN
Cj4gZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvZGV2aWNlLmMgfCA0ICsrKy0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9kZXZpY2UuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9j
b3JlL2RldmljZS5jDQo+IGluZGV4IDEzZThhMTcxNGJiZC4uMTE3NGFiN2RhNjI5IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9kZXZpY2UuYw0KPiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvY29yZS9kZXZpY2UuYw0KPiBAQCAtMjg4MSw4ICsyODgxLDEwIEBAIGludCBp
Yl9kZWxfc3ViX2RldmljZV9hbmRfcHV0KHN0cnVjdCBpYl9kZXZpY2UgKnN1YikNCj4gIHsNCj4g
IAlzdHJ1Y3QgaWJfZGV2aWNlICpwYXJlbnQgPSBzdWItPnBhcmVudDsNCj4gDQo+IC0JaWYgKCFw
YXJlbnQpDQo+ICsJaWYgKCFwYXJlbnQpIHsNCj4gKwkJaWJfZGV2aWNlX3B1dChzdWIpOw0KPiAg
CQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICsJfQ0KPiANCj4gIAltdXRleF9sb2NrKCZwYXJlbnQt
PnN1YmRldl9sb2NrKTsNCj4gIAlsaXN0X2RlbCgmc3ViLT5zdWJkZXZfbGlzdCk7DQo+IC0tDQo+
IDIuNDcuMw0KPiANCj4gDQoNClJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRp
YS5jb20+DQo=

