Return-Path: <linux-rdma+bounces-2079-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972828B29D2
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 22:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D141C21545
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 20:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FAB15350E;
	Thu, 25 Apr 2024 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="P6BflU4G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR05CU006.outbound.protection.outlook.com (mail-eastusazon11023015.outbound.protection.outlook.com [52.101.51.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D115253A;
	Thu, 25 Apr 2024 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076990; cv=fail; b=iv7gfGU5E6JMgqLjCPvgTCyTjHlnvs2sNpJzqcYfwfVNMT+Btx1MIOff3DT3jZYsrbjbUmIwv5q3oVcvxfxMCh6JeUG+2s/ZvDuseu+dJWo3y9NVSXCq1HlHSJGKDbDrFjtWoHeItA399xdo7guQha6kog+EtoqkQGFbHvX+DLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076990; c=relaxed/simple;
	bh=Lnb6SHOQApcR6d/nuyyeUJe3w6BY95EpcX7JrWH4Hvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ah5Kk54JEMN/AHbBGV1rM+S0ingUgGKI1Zd6rq3nca+TELhsV18XJjF62mMsk3lt5Aih2S9LtUAIYj85Q0ClUgXme2XkajXKpWGLRFZcIabVJSeUvZYk3asm58tlAypEjDVesjhcQNgF31ZtnNWPtkMO/n6U9OLywh3cDjKiDB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=P6BflU4G; arc=fail smtp.client-ip=52.101.51.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TM5B4aIpJcwIUHD0Zi6hBRtD1FYUO0JQAecYhUpy9DH0jycW9FheNpX2W9ZUCrTc4X5ySEwF6+JCfYhANq5bPnDFNy7vdcHt22Ckeyt/XeH3n8HLg826vQL+p/72K/Plp/DtZxycWm5avqW2F3wAMxLgPZKUhiE0pFGOWav71QS7Y/DQp+JFP5okFNIUXTWFf0gs6U8pQk5UpUrZsWHcJoKdAyezpC+w13i1wY0bx9aovXifgEK1Yr6BmFOtaGXjrZs6LQHOWyiaaFx0g4CehShi4912qaAkSUg1Sr73qQi77efSyUZZUqdaX6VkG/5nnrwDeuUekFrLTcsWnecBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lnb6SHOQApcR6d/nuyyeUJe3w6BY95EpcX7JrWH4Hvs=;
 b=dUFPCaO3HsP5UeFckRTx4HIB9Sc5QQK3coYm8sIyLlF6rFi5q3Kw88l+moNnUIMTV4h6PKCHTUhKC5GaxAAzyd4XVD6Pmg0oymghHAkRKeM7q2e2Qlw3uQHELra9Xq3xMxejnd709/hx7iH8fFaPu9g/iRaXSIYEkIQbyupV1/haHFXlIWHdOUpu/Hd9XLVxEqnr5CqXDkJhbZuNyNRXTUgyCUZmavboTeRne4Tu3b0vYikaaJbTw7bEZ+IJ9LBQ3SU2WOexPt8tJaAbrVEygSdz3ZbPL/Q59u7775j0hGj9av8INqz73wFF0Ra9n20k+Sewy1i5bzt5GoQFqisFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lnb6SHOQApcR6d/nuyyeUJe3w6BY95EpcX7JrWH4Hvs=;
 b=P6BflU4GvUz55wGdceML/hx+iDDBeC4opQN0v6jKCNkUEeFlRfi7i2QFrofDiIQ0YDkrAkWU/GQkZSxxE3x3IItCItcroFTLrhxqIzQTYRTTJRUA7a205KQVzceb1+Ck02jMDgiC5PaSZaLHrTGdigcdzrxKa1W0BmA+MepBu94=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by MW1PEPF0000E7B2.namprd21.prod.outlook.com (2603:10b6:329:400:0:2:0:17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.11; Thu, 25 Apr
 2024 20:29:45 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb%4]) with mapi id 15.20.7544.010; Thu, 25 Apr 2024
 20:29:45 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 4/6] RDMA/mana_ib: introduce a helper to remove
 cq callbacks
Thread-Topic: [PATCH rdma-next 4/6] RDMA/mana_ib: introduce a helper to remove
 cq callbacks
Thread-Index: AQHakbDF9CkxsQavdkOVNDu9IJalsrF2i3jQgACaAwCAAlWCMA==
Date: Thu, 25 Apr 2024 20:29:45 +0000
Message-ID:
 <SJ1PR21MB3457C82002C9F8F1E3F04EC7CE172@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713459125-14914-5-git-send-email-kotaranov@linux.microsoft.com>
 <SJ1PR21MB345799F95A00FE627B176598CE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
 <PAXPR83MB05572E3DDF6D2AEC970A2CBAB4102@PAXPR83MB0557.EURPRD83.prod.outlook.com>
In-Reply-To:
 <PAXPR83MB05572E3DDF6D2AEC970A2CBAB4102@PAXPR83MB0557.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a1642394-32de-4c1f-b152-92f2f14127fd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-23T23:39:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|MW1PEPF0000E7B2:EE_
x-ms-office365-filtering-correlation-id: 3cb22524-8078-4344-394e-08dc656671f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?UlBKaTB6aHRYOFMydE12QkI4WWdJbDBaMzN1MUduRTFiTFowcE1ZTDBvRGt3?=
 =?utf-8?B?SklDQkkzc1ZraVpGYVlRYzZtckdTREo0TEZYci9xRFowOThOTEh3MmlPaUsz?=
 =?utf-8?B?NkpMeHcrSldBaGxkUHI1dms3blVBTFBEYktzeGZjWWVJMER1S0hFdng2MTdJ?=
 =?utf-8?B?WDZMVEFkR0gxOXJIMm1ldjVuakdnS2JnU1owbDd2SDMwZ2dmemxPeWxmazNo?=
 =?utf-8?B?d2lHK0RtNy9BL2NzMlFQeWxYRjFyN21MMUNyRTNscEhUYjNFRXZhdEkrVzRw?=
 =?utf-8?B?a0hjMXBDK0tYSHo0VlJvdXJtcFljKzJrczJTeEVWTzM5TjlCWTZhSmtEUFhF?=
 =?utf-8?B?K29pNXFtc0pocXo1b1poTXNHOTUzRmFhRTdhTjlwZm5qWXgraWlPamt4WkZv?=
 =?utf-8?B?Qzh5d3RnaWZQcTRqeVdYS255ZWM3RjFNa0JyYzRVRDA1RE5SeGdQSWdDWlow?=
 =?utf-8?B?R3pXK1kxMVRPNCsyR1RHMWtuYlhKRjFYMjhlcUVBK3hkMytaeFhTSmhuRUZm?=
 =?utf-8?B?MlNUQjlMMFYvb205UTBWK3djbnhOWExkNlZ1NFNBcEdneUNWNmpraGJSOUVl?=
 =?utf-8?B?ZUpXRGRheWhMNFhXOWFFTVNTUWZ5UnNBQ2lpZ2pJeXNiTjJ3UmxrMU90cU5U?=
 =?utf-8?B?Lzh6M1dTQVpRT0pQb3AweGR3MzNHd0ZxKytJRklSMUcvZGk1NzNKN3RFQTZG?=
 =?utf-8?B?a21WMmpxcjRLa2Zoc3MyemhyU1lvTlJpd0d2UXZGSklyV1MzQVIxUGNndk44?=
 =?utf-8?B?Z0NEbU5wc1l2YTNmc0JNMzljWnFtc0dobC96SUM0dzBPTDM3Y0lFMTZ0L0ZJ?=
 =?utf-8?B?M1Rjb0tPV2k5dW9Qd0dla3BVRGpoTXI0SVRURzNlenZ0aURDeWdualFKZ0g5?=
 =?utf-8?B?eFdoVlMxZjVoVmpZTWY3NmZmdzc3VnJncm9RNXlqemcxdzJKTTRGVVBvMmU2?=
 =?utf-8?B?cTcvckxKL29zTzJGMm1DYTRFNnhxWUZrRyt0M09la1VXdkkrWWM5RWRYdFdW?=
 =?utf-8?B?TUd0SlhpcFg4bGxJRVdkYlkrNC9aUS9JeGxQd3V0ZG1icG5zQlBPZDc1SU9S?=
 =?utf-8?B?VnBGb25EczY3eU41cmErKzErM0JrS0ZkQnNDNU8vUmR5T3pFZEFOcVV4SjZq?=
 =?utf-8?B?c0ZENDFxTkVRSHVxdDI0eWVvYUtvOGI4RHNuU0FnREdHdkRzWUV2YW1xb0py?=
 =?utf-8?B?VTdFbUVoV2FxTmdCbU5IMVdkc1pQVTdBdHZsTktMazlKemNsTHBXNTdxMlJl?=
 =?utf-8?B?UitwVkYyMTFkOERvTlJ0NWtNaDlseWZnWmRjZGZCS2tvQnk5T3ZaYkhzaUpN?=
 =?utf-8?B?aURPeFVwYWFaMjdhY0trcXJjUk9uSzJ2RmovMnJzMHhmSFdHM2xGT1Irdmpt?=
 =?utf-8?B?MUpRSWdLMXRIMVNzakhvL05LT0VPUElNajduNkh0MzRlUEM3SE8vNGpPL3kz?=
 =?utf-8?B?bzc3d3ZLTGQwSmo3T3BKOXhaTUM2ZGlhSEdjd21EM1l6VHBkVVhsMXhCTjVG?=
 =?utf-8?B?NmtUMWQ1aVlSVzhTR2xFUDE0Wmd4bXgxYU5BdGRKbWJHYnVLKzllandsc0gy?=
 =?utf-8?B?RWJ5T2o5dzROMUZMNEE4dTZ2dlB5MGJpbXhYQkxnTzRXSnNzOTVncFVqZVhh?=
 =?utf-8?B?RU9MTXJ2MUtQK1l2S3lmWnZaMEZVbmNiTHlwTXVYTWxLQ2wwSnU3R25KSGpR?=
 =?utf-8?B?MUhLZnhoekpVRzl3SmU2bkFRZjVVZWh5L0ZhRFhRb3hubUFSQURSTEpkQTdR?=
 =?utf-8?B?TFY3aC9MM0JrblVDemVGaTBTR2VXNWsrYS9YamRlQmVLQWs4NTdPTEZYY2dO?=
 =?utf-8?B?Z3hST2VtejlOVklwKzBZZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2ZkTzRCNDJ0bkVZeU9UUUpzaVdEclpLbzdmcXI1NiszajdIZUdNRUh2NlVD?=
 =?utf-8?B?ellMMU9xa3I3MWh1MGYvNmI4ODllc0htN3F0dG5jd29YelowZ3Z5bi9yWnBL?=
 =?utf-8?B?d1hGa0RCY0I0K1BLTk9kaDkwNUZDZnBlREFKNDRLMmRub3VzZkY2RHJET0pT?=
 =?utf-8?B?ZXFNaXpBb01aSElNUTBodWF5Z3o5Z25ONTZkTWFDbWkxc0ppdnp0dEE1N0xB?=
 =?utf-8?B?bHZOcUpOdGhHdjFKcno0UUs5K0w2dkVVNGphTnR5c2RIQzlqTW1LN3ZaYmo2?=
 =?utf-8?B?N0s5ZGlmOWpMMWltckVUUjNQa3hvM1ZUaVFXaEZ5RmxxREFIUlV4Q25HclZ0?=
 =?utf-8?B?RHcrQTA4NFNub2dyNDF4aGYyUXUwa0p4U0tKS3pveHYyUktmSkFYVHZlc2w2?=
 =?utf-8?B?ZzFuRFA0bVQxNHUzcEdEQ1gxMVJNaEpxclVQV25OYXpUKytVUVBuSjRCbHdI?=
 =?utf-8?B?dks5ekhFeVYxWlRuWEJwM2lMUDRncS95dDJmcEhJYk5EdlBxNzdsNmQ2K1ZX?=
 =?utf-8?B?Z1U1YkUvQWJHeTZSNW00VXRWVWUwM1dTeU5MYXZYTzN3VUFQZEl3QnNjYU4r?=
 =?utf-8?B?RXArZHU4RFpVb3dQSW1nZlI5d3hTa2hwb254WkRVdWx1aStuaExOWEYwblVZ?=
 =?utf-8?B?bTJSamQ4dnduYWF3QllvSG1ZMjFoSWpyNDQyejFCWGJYb0JIbXlqUnYrTXk4?=
 =?utf-8?B?V0pLRkFQNWRDVUEyMFNpZGp4VEpUM0VHNWlKemxacnNXbWtNMG8yV0lUSHcz?=
 =?utf-8?B?OFJNRDkvbmEySFFTK0pTa25xS1p5MjAyZXM5eU5FVkZsNTRMNVl5RkZhTk0v?=
 =?utf-8?B?Y0cyTFZIdHRabHBrZzI2SFl6ZlJjNGFNcDFrWExlT0YvZEpVMS83Qk8xcklR?=
 =?utf-8?B?UFpZOURnRCtnZjN6QW03Z0VOWlo4bU96WG5yUHNIRmxqR1ZxdnFYUE5GVUhw?=
 =?utf-8?B?SWw1cGR0SVZJazNVaGlzRUF1SkpMUVJlRFRVUWw1QkI1ZFRVckkrbENMWjJN?=
 =?utf-8?B?SjRFNW1iZFcrdTZranFvOU9tUUY5R2N1dGlzYTVxMHNJSERtS1NtclBPbjBi?=
 =?utf-8?B?Q0piUnBudzFsWjlaNnB3RlJ6SjYwempXeXRXOERtL0YzQkhUOW9wSTdvczVo?=
 =?utf-8?B?RzNlN214WFhLTDlnWWQ3ODB6b042YlNHQjI5M05xOHJDSFZZRkZxcm1NeThO?=
 =?utf-8?B?elpmalFNWDV5WVhHWmFzdmdqUXl4S2lDclYvODcyRnE2cHpuOEQxVHcvcWdK?=
 =?utf-8?B?UVFVMjlSYzJsVytQd0dFSG1LTFZuNHc5NG9uQkhlemR5ZUQrTzVQa0UxNm4w?=
 =?utf-8?B?bUFoSWFYeHZORktqRTVVWTZxcXhIS2lHMUdreW9yL2tpbXQ2OFhqUFRVN0hU?=
 =?utf-8?B?RmcyZjg0ZE9McFl2MURPSEV1YXFVdU1kV09Vd2svd3NycmhFUUZQY3o1Wml2?=
 =?utf-8?B?RG44RlEwOGFhMkN6L2QxQ1NsbFMxdmVzRGhpSlptNkJ2YTlVbjl4Sk83Z0Nv?=
 =?utf-8?B?Qm4ycFJYdGxsQ0Y1aXd3aDZTWGdCTFN3bjZ5dW5HdnBzYThBdElsMVloMU9r?=
 =?utf-8?B?OWJIZEw2dEplRno0ZEVkaWlxK0NlRDZ6L25iUTdDam1nWmROVU5CQU9SUnJM?=
 =?utf-8?B?by9nTCsyS3A1ZWk5bkhDbGdFQ0N4aGZmRHFjbjBDdTBxQlI5RkEvOTlPaEph?=
 =?utf-8?B?c1I3TzZGS3BEN3NLNFY3dXhmUUxQR1c5Q29GbmMyUnNQbTdMNmE2UWhRWVpz?=
 =?utf-8?B?UlFVTENUTU9uM09Iek1UdGUzaG9NRGkycHRreE51Vm56dXAzZG10ZUpGV1hP?=
 =?utf-8?B?cUkyV09MUzFmQkxwdUtEalZpQnhvZTVDNmZwWExrYkE4dmxwdDN2eVQ1SUtV?=
 =?utf-8?B?WTBablk2S1dwejNONk83N2tJQUZMSTNxWVhaa0puSVpUR1VkQ09iY2lLZlNL?=
 =?utf-8?B?ZWZ6dGE2UzF4RVZSQ0l3Y2x0aVZHYi82SGJreWpkWFJxaU83dmh5TGhJTG1M?=
 =?utf-8?B?aURLRU1tRUFLOGNmOU11bzlrRHJocjdOdlRmT1ZkTnBpcWduYVMrTnE4b1Y5?=
 =?utf-8?B?R1NpeWtsZkF3YnlUQ0ZNcm93bzVDTnBUTVJGNmMvakx1a3FwSTFSa3AvdzdF?=
 =?utf-8?Q?w6VLOo0QzNuZU/2FWJlEtnuNn?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb22524-8078-4344-394e-08dc656671f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 20:29:45.2155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkMtWyoziAePQktgh2MowQOAzRzBQrtKaSmffsItImFvizcs8kf6aJ6+14L7TOcS8YT1vOu3HO8aaPvGfKPmRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW1PEPF0000E7B2

PiA+ID4gK3ZvaWQgbWFuYV9pYl9yZW1vdmVfY3FfY2Ioc3RydWN0IG1hbmFfaWJfZGV2ICptZGV2
LCBzdHJ1Y3QNCj4gPiA+IG1hbmFfaWJfY3ENCj4gPiA+ICsqY3EpIHsNCj4gPiA+ICsJc3RydWN0
IGdkbWFfY29udGV4dCAqZ2MgPSBtZGV2X3RvX2djKG1kZXYpOw0KPiA+ID4gKw0KPiA+ID4gKwlp
ZiAoY3EtPnF1ZXVlLmlkID49IGdjLT5tYXhfbnVtX2NxcykNCj4gPiA+ICsJCXJldHVybjsNCj4g
PiA+ICsNCj4gPiA+ICsJa2ZyZWUoZ2MtPmNxX3RhYmxlW2NxLT5xdWV1ZS5pZF0pOw0KPiA+ID4g
KwlnYy0+Y3FfdGFibGVbY3EtPnF1ZXVlLmlkXSA9IE5VTEw7DQo+ID4NCj4gPiBXaHkgdGhlIGNo
ZWNrIGZvciAoY3EtPnF1ZXVlLmlkICE9IElOVkFMSURfUVVFVUVfSUQpIGlzIHJlbW92ZWQ/DQo+
IA0KPiBBcyBtYXhfbnVtX2NxcyBpcyBhbHdheXMgbGVzcyB0aGFuIElOVkFMSURfUVVFVUVfSUQs
IGl0IGlzIGluY2x1ZGVkIGluIHRoZSAiaWYiLg0KPiBJIGNhbiBhZGQgIiB8fCBjcS0+cXVldWUu
aWQgPT0gSU5WQUxJRF9RVUVVRV9JRCAiIHRvIHRoZSBjb25kaXRpb24gaWYgeW91IHdhbnQuDQoN
Ck9rYXksIGNhbiB5b3UgYWRkIGEgY29tbWVudCBiZWZvcmUgaWYgKGNxLT5xdWV1ZS5pZCA+PSBn
Yy0+bWF4X251bV9jcXMpIHNheWluZyBpdCBhbHNvIHdvcmtzIHdpdGggSU5WQUxJRF9RVUVVRV9J
RD8NCg==

