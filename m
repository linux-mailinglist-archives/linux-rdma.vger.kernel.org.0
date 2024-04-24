Return-Path: <linux-rdma+bounces-2047-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188818B04C1
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 10:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C1D8B23E0C
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 08:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC76158A15;
	Wed, 24 Apr 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YWE//xss"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2133.outbound.protection.outlook.com [40.107.105.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD4157E9B;
	Wed, 24 Apr 2024 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948625; cv=fail; b=Jtd+lrNWCLYh3ajSrM3w8uGh7sz8BUVc3c+gedtmGGBDZ/j+XG5Jj1VN5kCUxXjUs8rOvrDOgzx5irHB8whirsDjtg49igUyB+8A93Ptsz5oWBa1+c9/UAf8LUEZcp5pWh09dihhqdU//qfJlgKUHunC3+lYLdw9V5SGbD/3GeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948625; c=relaxed/simple;
	bh=V23SUZLBrH/vCIn4dcyjJC3EniLWVrE09UiJw035wVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FQYMVKoa7ddRFe/KtwKpgWnewsTWsUv7oVLRFEol+nVrlvYfZMmB7X7tR/g9SJK8PST6LXGVRecYEIaOO+nEz32Y7dhZANmXA0bYgqRC0d4leQXxJkXLEllnTxg2W0uzaSl60M/3ybAWBTDXNMIJcqdT0h9b+McJIe3SXIYMxEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YWE//xss; arc=fail smtp.client-ip=40.107.105.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdbQFC5gtsDxp5PSnHHB6a3VnLPKxh54eb+YJ5Cc+peUIMpPG2y+IcARHD/qRnHPgFkzdwV0TPHIpIq/e/vEWKEOP3TLS7lt/YYpORqy6jymZ8+KUcCk1N/SBFm3Zz4X2J4sO1P3OTmaD1+g2dUJhlEheAf1UszWpDkutziwoDOQNb9jS3diCJGY/TFvX/yZBB++wXnfmBn3pkhpujwKlTdByqTPCdTmWn6un57TYSmqvIVvb/Pi9GWHHh0lGyt0azy6G/rDcyz1A1YF6s7Oy9rglZPawlIbCfIa0/dPLRndJJv6obmw2wqDNNhchYbF2qkMxc1BxTkESQkenZqsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V23SUZLBrH/vCIn4dcyjJC3EniLWVrE09UiJw035wVQ=;
 b=aTNsa11ITvudSUQemINHTiIgc8g/OjGb3ZlOtb0DVMAJxVjNHlLS4B3ZOY9EBI3gdayomGhE7IJLkqm5CFI6pEB2TSqgncD+s1mO6KU36VmBeo6plKR126OCqQKunAq7/vZMpsLqIvaA+Yxcdvvy60zgBvIv9Wv1C0+VlNW22e76ZjgEXtU1K6G9w6/2dWNSgNwro7hyorK/6QVRagyj7ONDIrK9scfTDqBcUiu2YH50vpzN4bOFScM6fdDasg1yWL0JfFN2sOpd+JA90Vvan5uzxLeeQZGyiasyXZi/+4Dq7BcC27I/bY45ImhLP7Z1yVwKciyssOPWUy5t4zsZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V23SUZLBrH/vCIn4dcyjJC3EniLWVrE09UiJw035wVQ=;
 b=YWE//xssgZR7EuEYU3/Ht2MRZOW69g9Vck14zGrfrlaSy3IQWeUe3rAnshDUUjN/ZDT9kVyjfrf/8ROfOIkatLguZH9eQRDryipmoMJWhVhKOOKiBFk+XCv2xPtoADfTQfxmTfIGfpkYr8gLWm+ACmWYKNKfgH34KbGeFlI4wVw=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by VI0PR83MB0657.EURPRD83.prod.outlook.com (2603:10a6:800:237::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.9; Wed, 24 Apr
 2024 08:50:19 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572%6]) with mapi id 15.20.7544.008; Wed, 24 Apr 2024
 08:50:19 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 4/6] RDMA/mana_ib: introduce a helper to remove
 cq callbacks
Thread-Topic: [PATCH rdma-next 4/6] RDMA/mana_ib: introduce a helper to remove
 cq callbacks
Thread-Index: AQHakbDJu1YsyuFwSEO5+QH/VC92P7F2jGyAgACXM8A=
Date: Wed, 24 Apr 2024 08:50:18 +0000
Message-ID:
 <PAXPR83MB05572E3DDF6D2AEC970A2CBAB4102@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713459125-14914-5-git-send-email-kotaranov@linux.microsoft.com>
 <SJ1PR21MB345799F95A00FE627B176598CE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
In-Reply-To:
 <SJ1PR21MB345799F95A00FE627B176598CE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a1642394-32de-4c1f-b152-92f2f14127fd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-23T23:39:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|VI0PR83MB0657:EE_
x-ms-office365-filtering-correlation-id: f41e500a-72b0-411e-ff79-08dc643b91b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZW53dVQ2NUJFYUlSUjNQd0hLVTZ1TG1KbjlnS0tkWjNXQmJZSzlRSjVzOWkz?=
 =?utf-8?B?am1ERDZOTWFWZVFUb0JJU01CTzdacW5yd2VVeVhMdGNsTnUwY0ZGNmZDbTVH?=
 =?utf-8?B?K0pRSnFZV09FTjR1dmhlR1NzWTFkSGovY01DclJpcGIwNWNCNUZMQmN2UERS?=
 =?utf-8?B?WWRRNk9jNUNpbFYzSFpXdWdxRktUay9aMjRneEVUUkM4anhhM29xSW9pRzlG?=
 =?utf-8?B?UENyWWdNdW9ZeW4xVGkrbEhIemo4b2JGaWZIdzlKVmFoRm1tV3ZyNXJEWUx1?=
 =?utf-8?B?VVpTbzJ2djl4dHY0Z2oveDVRWlFHMWZseDAxS01DQVptQ0o0NnVhVzVMZDlP?=
 =?utf-8?B?dUx6VmJTWmRzWkVTZWw2Vzc0dWVxaXJEcFJJZ1orSGl1aXJtbnJCMi95bHhS?=
 =?utf-8?B?QmZ2SU5CUFo4TVY0UXNiNDBiV3pFY0Ntbk53TjREUm9ZcDdEcGRzMUN3WnpL?=
 =?utf-8?B?KzFiTkdIK3VRMXdVL0hmdU1TRU1iamVRb2ozMDhpSXZUdTUyby9DSm92ZEw1?=
 =?utf-8?B?TDBjYjNMckxrWUQ2eFNVaXpHNW1rTllmWWJGSGEyT1FFMjExS012YnpyeXAy?=
 =?utf-8?B?MUt1emcxYldvS1V3bTFTOGhmd2J0K05oeXBsZUo4bmEyMitCZ2p1aU94eGdE?=
 =?utf-8?B?dlVIbkY1TDVCR2FzQXhTN21lOUZ1V2tJcU8yLzJUQzRhUndvQ0xWM0hvMUll?=
 =?utf-8?B?WHVVbGd5dHpuOUZBc3JBYmZtVm1STjQwQnhzaHdsZS8zaWxqNkw0d2loREh6?=
 =?utf-8?B?SEtuV1NhRDZLY1BadEhwN0tHYXVnbzNQZTJwamdGVTg4L25TZm14S25ZOSt1?=
 =?utf-8?B?ZG9jL0xHd1Yra0Q2MkFzNUtadndrdjVCSmxzNHBqelFRZ1JDZUgybStESHgx?=
 =?utf-8?B?M2RoRWRqcGNPRHVuTXBiZ3RWWTRwd2t4eHp3KzVDa1h0WVJkUGkycEVrR1dq?=
 =?utf-8?B?Q0Z6U2JSV2xVeHNOeUY0czNERHBRbnZOeVNVcWR3YmdBRm9QRUhieXFSU0tt?=
 =?utf-8?B?MDFyU2UvdEtMYjNzSzNaUklzeXlFRHFLT1pBdFlVUFRhZno5QjlaWEpGL2N1?=
 =?utf-8?B?QmQwNWlWREdCRjBDU21MT3MrQk04ZmoyVHhkL1RzRWZDRzJCS01ucFdXcTZE?=
 =?utf-8?B?TmFhTEJxVSs5Tm1oU3ZHbjVIdHJyZmZUUUE3UllDcHVSUWMvL1NoSFRvZnRY?=
 =?utf-8?B?WUpvNVZkMlZFR3BPYWRNYjEwWmpzazdQTHhxVEw5VStOb0xUeENxczZ0Y0tX?=
 =?utf-8?B?TG5uL1AxeDJaYlNScnlIRE9DL09OeWZEYncrL1MvcHFMTDNtZmRldUxtMnpM?=
 =?utf-8?B?Qk9HVEtKU3RGYW90SllWc3lVOWZVZ3VRQnJ5VWp6YnpFU0tDV1Y1eFEvZVpT?=
 =?utf-8?B?L1NuTmp4UHZwYzdyMFZLZUpiZUxabnY1OWFCR3lidzNFdU5wcGUvQlNiSVNH?=
 =?utf-8?B?bnFpS2lNWnZUc2dtdTgxRzFhYWNmN1Z3L0pjTXRjNVVJR2ZVbkJoNkU5Rk9D?=
 =?utf-8?B?RTVjSjF0UGlUSEJxOFRwb21lU09yR0RCZGdlTE1MSXNIWnN4c1RTUmxPWTdJ?=
 =?utf-8?B?QlNHNjVCYUZpcWJZRzFsSjJKR1dGTnFITm5TUjRhVzl1YzhhdEhBaXMrTzZS?=
 =?utf-8?B?ekdNbDcwOHRVWEpTTGNBSHR4WmswME5nQTJWNDZldVhrSDN5UWlBWHhkejFx?=
 =?utf-8?B?WktMR1pmd3UvZHJ0OUdsaWJLenFMWkV3SitRNHFRRGlFbXpQM3lINFkyTWl0?=
 =?utf-8?B?ZmU2UEp2Rm96cjN4bGN6TE1UUmNjOFFMaC9CTGtoTUdBcHl4bU04Zys4Y2g2?=
 =?utf-8?B?RzNtTWR3bGlBYnhqZDJPdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHEvQ2pIZVVoTFBweHRGTWR6L214NWFqSUxEbzEzSlNFRkVlWk51UlVrdXNF?=
 =?utf-8?B?NDRRcjNHZjVKbk0rTjhKOVBxc002bnp5bGhNcG9LZ0Q3dFVIcWFGOGpReURX?=
 =?utf-8?B?aXh1ZlRxK3BFMFZkZW9YeldoMkJlKzNhYU8wdy9UaWpUd0E0c1dlN20vNzlt?=
 =?utf-8?B?RlN1SjBkdndLYTBZeDJnTUwyemt6bHd1eE5DQTFhWUQ2U1E3ei9yajJrTFI4?=
 =?utf-8?B?SC9DYkM0SFlRaXBqT212Tlk2N0gxb240ek9SbE8vWSs3dEdJVnlVcVFqdmFL?=
 =?utf-8?B?aE9iclQzWkJVS0hxcTR6dEtOK01LMWRqQjBTaG9JZ0JPTGRQWjd5UUpGRm5O?=
 =?utf-8?B?Y3RRSjFxaU9WOTYxa0NDQ0srQksyeTlwdTB6dUlXVlNTMndnWXo0UjdZbFg3?=
 =?utf-8?B?ZlVIU0xZVGY3K29MYTJBUWtsUkxOaDQvenBwdytRaXpZWjJqSmtMMkVMZVkv?=
 =?utf-8?B?RWtHNVdid054dE9aaXdzY3FlZnoyZHgzcGRrYUpVb2JOTDdkcThFTkRwMlpW?=
 =?utf-8?B?UU1jNG5lL2Z1Yy9NWkhBYVRLZFV0NXhFTGV1enlDZEhJVmxZMUcxZzRlTDJ3?=
 =?utf-8?B?WDJiQUdhQTl4V3R2anR4M2Z1WEVoRTJEWkphSXE1aTE5ejlDWWhaL3VoTG81?=
 =?utf-8?B?ZGRyT212MExhYVpvdlhNSDhNd3RHL0dNcDNxZ29jYkcwTlp0UnBMOEVPc2dN?=
 =?utf-8?B?dmtta3VSRDcrb3R1eW51RXBVLzhtdXpVa0pyb090UjA0dW1TSjVzZ2pRR1Vn?=
 =?utf-8?B?NFhic0N6NjNydEwrMlJqOFY1RjdhWUNXb0pWbHg4ZDMxSnllT2RjL3hRMnNh?=
 =?utf-8?B?VWZ1cDFFVzZOcVBJQ1A1ZFV0M0UzbVlRZDBRalppNEp5U0luTFN3S1pqb3NO?=
 =?utf-8?B?VXdOSWRMQ3d1K282dkpCREFnWlFZZVIxU2VTSG9vMVdDdnlvTjhDVVdRaFQ5?=
 =?utf-8?B?SjFQQWFLZmk5UDBMQngyb1NrZ1ljVU9aajlPb0pielJUT1VUSW1KWGkzOGVs?=
 =?utf-8?B?R042VWJzVmsxY05ZbG5VWkJiZGN5YXFhZkNPQXBqa09lY0VyMFJERENieWRI?=
 =?utf-8?B?WnFCcXJuR0NNT09KY1F4S2lmSjlUMkdKOTF0U2NpT0x5VTJLSHZrajVvaWo5?=
 =?utf-8?B?RHl4d3Z1bWUrdHBJbW5COEVzRTlkWlVJWFB1Q2pLUVpUQ0tpRk1ZVlJaS3pt?=
 =?utf-8?B?cHY4dHJBSXJ1ejNVeis3Y1BuL0dwVnpGUDN2SGZkTUdmYmxWQ0R1VEdyVG9p?=
 =?utf-8?B?ckNzbzA5UnR3aXplaS9FbXU2YUZ4STZ5WkdGQmhMd1gwaGFKNCtjdGx3am05?=
 =?utf-8?B?REJKblo5Q2JHS1IzdGlqOGdBN1BZS1Zwc3Z2OVgyNmgrSXBZQXUwVmpPYVg4?=
 =?utf-8?B?eW1sVlFhRXRGS1pQTFRVa0N4UHZKSkpFMVBhN1V1elpDOHBDVGphMFRTUE1Q?=
 =?utf-8?B?L3J3dnpWdXlYNVJLdElEdVo1cXNLMnk4U0t5L0NYV1FBNnMwclQzWVJaaUc1?=
 =?utf-8?B?U3FyME8reXJaZGhBdU8vb2JSTkxqS2FlUHhWM0ZDZ1VQMkNRVjhQQlFVWUdm?=
 =?utf-8?B?Q1RjNXVzMEVZY3o4b2RGZm5Zb2Ixa1pSYkZ6RVozRjhaZ0FkbisvM1ZCcERL?=
 =?utf-8?B?MjlrVURWdG5iZTJVRS90VE5xZG1WL3N4dFNqZEh6VkQ1SlFINE1HeXE3MUYw?=
 =?utf-8?B?MC9KMldLTDJkZUhTUjZ2M3pqTStQdmhVVDZvOXdUeXJSUy9BSXN6eWZzTnBw?=
 =?utf-8?B?Z1RWL0tuQW5yNHZpSTIrNFNsaU1vMmNMS3dMWWFLZlFKS1JnMTc1b1hVQ2lq?=
 =?utf-8?B?UVpXTU1kNkdUUnZxREF4ZEJNSXpzR29DYjEzTC9HSVJnblA3Z25kNzI0SGJR?=
 =?utf-8?B?L3A2SzVVR3N2TG5TdkVhZGoxQlRtYVFuY2l4SWxRQnREaWhOTmRlaEYzNnlQ?=
 =?utf-8?B?Yi8wNk5RMWlSRm9nZ0lRYXZlazFMMGtkSFpMM2N0aE51VTZtM1FiNXJrZUNu?=
 =?utf-8?B?aytkTTVXaWRXZmpZbHduNG5xK0MrZHM2SUJQUXk1ejh0SlRZYWVCcWxkNUtX?=
 =?utf-8?Q?1to/Hs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0557.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41e500a-72b0-411e-ff79-08dc643b91b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 08:50:18.9476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DbzAw56BVE5mv5uSbmBFXIPTTuyEjRYUygDosiYbXlyTsvjYF+4myU2uEO5hrQskOl7wkd3laIkomHx/GoOFJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0657

PiA+ICt2b2lkIG1hbmFfaWJfcmVtb3ZlX2NxX2NiKHN0cnVjdCBtYW5hX2liX2RldiAqbWRldiwg
c3RydWN0DQo+ID4gbWFuYV9pYl9jcQ0KPiA+ICsqY3EpIHsNCj4gPiArCXN0cnVjdCBnZG1hX2Nv
bnRleHQgKmdjID0gbWRldl90b19nYyhtZGV2KTsNCj4gPiArDQo+ID4gKwlpZiAoY3EtPnF1ZXVl
LmlkID49IGdjLT5tYXhfbnVtX2NxcykNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiA+ICsJa2Zy
ZWUoZ2MtPmNxX3RhYmxlW2NxLT5xdWV1ZS5pZF0pOw0KPiA+ICsJZ2MtPmNxX3RhYmxlW2NxLT5x
dWV1ZS5pZF0gPSBOVUxMOw0KPiANCj4gV2h5IHRoZSBjaGVjayBmb3IgKGNxLT5xdWV1ZS5pZCAh
PSBJTlZBTElEX1FVRVVFX0lEKSBpcyByZW1vdmVkPw0KDQpBcyBtYXhfbnVtX2NxcyBpcyBhbHdh
eXMgbGVzcyB0aGFuIElOVkFMSURfUVVFVUVfSUQsIGl0IGlzIGluY2x1ZGVkIGluIHRoZSAiaWYi
Lg0KSSBjYW4gYWRkICIgfHwgY3EtPnF1ZXVlLmlkID09IElOVkFMSURfUVVFVUVfSUQgIiB0byB0
aGUgY29uZGl0aW9uIGlmIHlvdSB3YW50Lg0KDQo+ID4gQEAgLTE3MywxMyArMTcxLDYgQEAgc3Rh
dGljIGludCBtYW5hX2liX2NyZWF0ZV9xcF9yc3Moc3RydWN0IGliX3FwDQo+ID4gKmlicXAsIHN0
cnVjdCBpYl9wZCAqcGQsDQo+ID4gIAkJZ290byBmYWlsOw0KPiA+ICAJfQ0KPiA+DQo+ID4gLQln
ZG1hX2NxX2FsbG9jYXRlZCA9IGtjYWxsb2MoaW5kX3RibF9zaXplLA0KPiA+IHNpemVvZigqZ2Rt
YV9jcV9hbGxvY2F0ZWQpLA0KPiA+IC0JCQkJICAgIEdGUF9LRVJORUwpOw0KPiA+IC0JaWYgKCFn
ZG1hX2NxX2FsbG9jYXRlZCkgew0KPiA+IC0JCXJldCA9IC1FTk9NRU07DQo+ID4gLQkJZ290byBm
YWlsOw0KPiA+IC0JfQ0KPiA+IC0NCj4gDQo+IFdoeSB0aGUgYWxsb2NhdGlvbiBmb3IgQ1FzIGlz
IHJlbW92ZWQ/IFRoaXMgaXMgbm90IHJlbGF0ZWQgdG8gdGhpcyBwYXRjaC4NCg0KSXQgYmVjb21l
cyB0aGUgZGVhZCBjb2RlIGlmIEkgYWRkIHRoZSBoZWxwZXIuIFlvdSBhbGxvY2F0ZWQgZ2RtYV9j
cV9hbGxvY2F0ZWQgdG8NCnRlbXBvcmFyeSBzdG9yZSBnZG1hX3F1ZXVlIHRvIGJlIGFibGUgdG8g
ZGVhbGxvY2F0ZSB0aGVtLiBUaGUgaW50cm9kdWNlZCBoZWxwZXINCmZyZWVzIHBvaW50ZXJzIHRv
IGdkbWFfcXVldWUgZnJvbSBrZnJlZShnYy0+Y3FfdGFibGVbY3EtPnF1ZXVlLmlkXSksIG1ha2lu
Zw0KZ2RtYV9jcV9hbGxvY2F0ZWQgdW51c2VkLg0KDQo=

