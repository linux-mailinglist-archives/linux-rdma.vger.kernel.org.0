Return-Path: <linux-rdma+bounces-2550-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4048CAA54
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 10:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5517D2820B8
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 08:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34994CDE0;
	Tue, 21 May 2024 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QzCRJBjH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2127.outbound.protection.outlook.com [40.107.22.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4732E134DE;
	Tue, 21 May 2024 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281319; cv=fail; b=EdaQmZypqPpEw+A88x7WAxPZ98WNkQQSs+CZ/YbVC/OcPPDLekAyYctM1uC+vqSwkuWcON9Pg4Bc2PYO2fJ9t2SuPJwVMJ/+KqHBnMMvEz+fb80KAGC+05P3TCKoc2pz3J4ac9eAI9D11YkYXyw4g88SNZevHM2C/5GiZ3dhG4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281319; c=relaxed/simple;
	bh=0vifg2h6BMwMrjwWuzA9wiIaIOHLt7jPucpf/DgUKsA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ClcRqTah8li8dsXjokTcX88y2uDbDUZ6EFHd6N5NHoPDEHgW8IglxElqGN5LvwW4FKCfCxOWUCwLvp/rI4dsLSuGN2zbB737f0GwsM3Tt4KRJDwmbb1STMiBQmOknVglqMV9YJVmVIx2mDkdNo7XzAlxSzE/4bG9BCuKAe7AGls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=QzCRJBjH; arc=fail smtp.client-ip=40.107.22.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMLQawk1Ke7tZrqtyXxlwu9qXiIq/CjvB/0AOIHO5Fts8wN8Z2Q3gG+qZo1k/TqIThogx5Jg0F7VKo+sB6zB7fJ704UcRSlvMHlYTWqMrGGyz7q5T0/aPoOeF2USuhVCFNrmM6Nq2tZ7U71ur4SQOwKjAI/e42G5axQ3Bu50qX8u2ZYuMgarHSAFFSsb7td82RQzIddr2pCf/+mcl72l/19OZemkKqusmWJA9Yy8kKnfaoNTMUlBiAZ4HhYgPCoaxj5NoPFhEuRbGDmTfy3gsRDiXmXc9frkJudM85eji7KvRkk//mbc9coipv4aggzjsWHZGXoMeONnnk4LTo9J0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vifg2h6BMwMrjwWuzA9wiIaIOHLt7jPucpf/DgUKsA=;
 b=dUH4ltk/fCHyO7GXFiqqhMIrAr2bRyxWci0S2fLMnsZ+jw4/hELHK6SrQEpaet2rzqjptc9acm67E8bZnd/f82d/bTfD6ZFoLxlHGI7+a9JCX833k26dxcmENoTc/m74Rb5rhIr6cC6genr9xN0Y88ImZfcyLwdjAAh9CGBOyibgbxbU0s10bXdG6BfIxXNNeBVfe1Jna/wwrBPhMX4owbJDuIyoUhXjldX23CpHrUhF2SY49dA/z2+E7XF97+wO6ya+TI6MI5bKgysnz0WAdBE3xsctPUgvCZB/5CSOvARsUWcFsiJFhNdKGwWS2rW/2dKD+g/oTmoa3pg7mbpvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vifg2h6BMwMrjwWuzA9wiIaIOHLt7jPucpf/DgUKsA=;
 b=QzCRJBjH1Fh64ZHlfCY5AeVZyYDg7RNOq/jLFMx5x370B9SPq0yiPmtsoaYXljx0UptBMvtA9FxXd8NHbw3Q7TruB40nKqgfE5Fv34cEmVe3EMvv83rCM6g1HOQm6q3XPWGHhqQhFyKQjlq3hyf+/y/mR0YSDQjeOKnFOtlw/R0=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by AS4PR83MB0523.EURPRD83.prod.outlook.com (2603:10a6:20b:4f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.3; Tue, 21 May
 2024 08:48:35 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3521:3a54:afa1:339e]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3521:3a54:afa1:339e%4]) with mapi id 15.20.7633.001; Tue, 21 May 2024
 08:48:35 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 2/3] RDMA/mana_ib: Implement uapi to create and
 destroy RC QP
Thread-Topic: [PATCH rdma-next 2/3] RDMA/mana_ib: Implement uapi to create and
 destroy RC QP
Thread-Index: AQHaoGRoO235XiPReESDhj7S6JB3mrGgmZmAgADZ0vA=
Date: Tue, 21 May 2024 08:48:34 +0000
Message-ID:
 <PAXPR83MB05595340C0BD6AD3BD3789DFB4EA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1715075595-24470-1-git-send-email-kotaranov@linux.microsoft.com>
 <1715075595-24470-3-git-send-email-kotaranov@linux.microsoft.com>
 <PH7PR21MB3071EF8F3E4F9381C52225EECEE92@PH7PR21MB3071.namprd21.prod.outlook.com>
In-Reply-To:
 <PH7PR21MB3071EF8F3E4F9381C52225EECEE92@PH7PR21MB3071.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f547d5dd-f3e3-417f-9124-0981488d0d41;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-20T19:36:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|AS4PR83MB0523:EE_
x-ms-office365-filtering-correlation-id: 319c0321-934b-47bf-504c-08dc7972ccd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1haVzIybTJjbGNCLzBjY3BiVHpUc3hPSm1hRUJud1psRWtreWdzcjF1eUFi?=
 =?utf-8?B?Z0tKQmZ5aWVqTFdKeFp1bUhjMXZSVndTQW1Fbk5PSi8rV0xXaEt5WHd2eTJ6?=
 =?utf-8?B?NmdXWEJ5Tkk3Y3JVdU1XalFBaFZTREVyZ214VmdIWjFyNCtvWVlmVDVNb21m?=
 =?utf-8?B?Q1hZUkFIVGUyOElVbm9mYWt0MUczVklRcTE5QnpzRVorRGZDUEpEQzRUUEhE?=
 =?utf-8?B?VGhpMFZYUjhocU1lNGJJZHM0WEdTYVhkSzh1Z1B4a0tOTzVOMFB5Y3JZMjdK?=
 =?utf-8?B?M0VTakpjS0Fvd0lIODV3MG55dGMrWDF4V2Z2L3YwRDVTbHR6eC9aTHJiaU0x?=
 =?utf-8?B?Rm42UTh6ZGUzYVVKUEdoQ2s3M2JSWmJ0bXBCQ1VDWjVUZ29MK1hnSHI1Wm04?=
 =?utf-8?B?S0hEdGF6SzZSeUpZenQ1VnhqcE1NRVZzMjhDMkZaazQyZ2RZd1ZWbzM2ZFRn?=
 =?utf-8?B?K2RoYk5hVGdYbDFOOHpubVJ3MXRkdER6SFdvUStKLzNCTTdXNkhRcC9ibGh3?=
 =?utf-8?B?c2FZVG8yV3BRRGl3LytuZzFEdUpEL3dSR2psYk8xQnFrVHhUKzJIMHpGNWpM?=
 =?utf-8?B?Z0UwVjRUOEJUYTIwWVY1SXFTSmtlUWw5VHVLdnRXeGhvZ1NIRUZBczBacSta?=
 =?utf-8?B?WWxhNklnaFdEUDBtZDRGKzRqK0EwZFBwZGVYOTNBbHFnZlB1YWR2b05yeEQy?=
 =?utf-8?B?enZzRW1Oa2dHYURFeTkyZDk5NVp3L1o1amVUL2NNQnRUWnRwaUZYWFlneFhH?=
 =?utf-8?B?T0swSFRqUFVhOUFpc0cvdURWTHRrRHdNZVM3dVRucVYxZXBCWm9VTW8yUlB6?=
 =?utf-8?B?THFxYUFWbDBVbGpGekM4WWhBem5zZ1MweVk0czZDUXJIRkVNSmFKOWtzMkIw?=
 =?utf-8?B?QzJhVlpWNCtEQUcrbmliQVlyaXhmcU9BN295amJSelpqbFBPa0UyV1lwOCth?=
 =?utf-8?B?RWtseUZURXhtajBUMkY5WC9CL09iNnQ0WmJWYys0WitHU0lLVUJVU0kvMTVr?=
 =?utf-8?B?YVZPbHN1ODBkUXNZaTU4enFwTDF3V3hhZWtoQ1VSeDNhZ2NpUFBLSzJOeklY?=
 =?utf-8?B?dnBnVXdpZkRlUHBsdEpUMjNXUU8zL1liYnhyc1pzbFpLMGxnYWk4eEpPTzBC?=
 =?utf-8?B?SVpkQ3AwT3pQZFFYRkF5dksxVWpPMFZ2aE1zMnVXWnZHZDZJaXRYWE5rODVQ?=
 =?utf-8?B?aTlJNkd3VnJNN0dwaDh3cWF5ZmpXSXZpeHMvN0dYWm8wUUZSRTFzb1FwTllF?=
 =?utf-8?B?MVpvbU5uMnRBbXRsdkdrWVVISEUyN1BVZE9XdytYWDZKZHVoQWRRY2pvcGh5?=
 =?utf-8?B?TTRWN3VXZDdoQzFjbWIrKzBiT3FxZG5Ob3UwYUhDSHhqSzdNaEg2ZFVoWDRp?=
 =?utf-8?B?SHNJcE5PRFJBZEozMmFBR0ZlS054RmlPMlVQMlc0WEtKRmM2M2tEdkpsbVhx?=
 =?utf-8?B?WUpqTUdxeTRtYmtQbVFOWlBjNDdRWEROU1VLVHpxSVY5aTFvNjNoMERJQ282?=
 =?utf-8?B?VUUvZlJ0TkNGdjZCdXhxVmZ6ekVsWFNEM3hLNk14MmJabGZJeUlZR1hXbDJT?=
 =?utf-8?B?S3IyRWVCbThST3lJQkdUZ1h3VERQU1d2bEtZbm5oSmdWeUtmNWR2YVFaeVFF?=
 =?utf-8?B?Vlh3bkhkTDBTSkFCSmxMN09KUm9seW9TYjdyaDJTZFMxcURRZHNYOUhoeXVW?=
 =?utf-8?B?VUNLbDNHWUJmSzY5OXNYWERDR1RSTkllbDJXQ1N3YXZLb2ZkZGhCQUNsVXB3?=
 =?utf-8?Q?0mJrXCra156SJHpEbl52BDhBDcy4zDIm/s85J3Q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZkIyc05BRTlRaWtZTm1scHREYlJlRVZISnF0Si9jaUc4NnMrYWxLMDRHeVpI?=
 =?utf-8?B?a3puZ3RQZ1craUdjM0ZkZnc0dGUwVmVMVlJZdGxhMzI2YUUwa0d1eUxQYUpS?=
 =?utf-8?B?YXhNcjF1QjltaGZhdmovRkNlRHcwMmV0am5iVjF6dlU4dGZ1M3U3T0F1NzFr?=
 =?utf-8?B?d1diODgrY2FFODRjc0hYR2tjVzFqL25Ub0p4WTBvc3pIcTVaeEFyUVJVektD?=
 =?utf-8?B?TlU5a3pmUlJBbGk5QWIzbmJFRUFOdjVUYStpeTZRZmlVMk9UVXJsQWNsdlJ5?=
 =?utf-8?B?S1gwc0M3RVN2aEl1c05uS0RJWEM2L1hEYitVamthcndMVUhZc2RYVFlVbC8z?=
 =?utf-8?B?ekg0ZXpienFraGFyb1R3bld1OTZkM2h2VWQxbHRRbGhNUXZTTFMyejd1YkNI?=
 =?utf-8?B?SElKZWVJRUhnQ24zWFpESGZpdGdCRTByZnVvSzNBZDdJTFJRckR5STA4WVNl?=
 =?utf-8?B?YXdWKzZCUDVxM1JqZVZNN1V4SW1kZUZXR1hNUEUxYWI0UTY2am5uZzZHaWY5?=
 =?utf-8?B?OEh6TmhxRTJSK0lqejJUMjNxK09tbTQ4UDBoT2hhaUZNbzZYWjNYU0NYa3FE?=
 =?utf-8?B?bjU5Z3NuVTNzZmRMNW1ML2xJdzZROWxIbWlGL01VVFdUV25OcTlwZG96YndW?=
 =?utf-8?B?WC9zZ1Z4QkdwUkhvQUttVEN5T1FYaUQzOUhWNkFvaGdTWjZzMTVpUFlsTFB4?=
 =?utf-8?B?bkVnZ2Y0NW90YzVaVFZ6bS9vTythMXE4dnV2eFdZazB4VjFOQUtNNkJFcnZw?=
 =?utf-8?B?Um1PWmE2WWZrRlArZFdOMCt5OWsrSFVrNGJGd2ZiNksxU3ZVT1VNWWlQbFRi?=
 =?utf-8?B?R3lnTHBQMjIyZ1pQcStXWmNmL25mLzJjanlDWDlKRVVNbkdQb2l5a2F0bnVU?=
 =?utf-8?B?MWthWFJJSHBsQWNlZEcwSXRicDVLK2VVTmJjYm9EUjBnckpTQ2YzdG12VnJM?=
 =?utf-8?B?R2ZCaHc4Tjl5aVRTdUkvV2Z6d25GVVRqSkkvWGZrSnNFWmwyUWxEdENGd3gz?=
 =?utf-8?B?Ym5yQlZVWTAwSHVqYnhIdGJZRzZtand5STNzY3c0enEwNENvZmZwY2h2bU1P?=
 =?utf-8?B?TjlYZ2V2NlQ0dTNKQU54S1BDanpWV1FRSnRabSsvMXhNQTNGVytKMXR5S1By?=
 =?utf-8?B?ZVBWWUF1dWJneVJCTk5VWmtYSnZxZFJBL0NkUmptUlhiV1ZqcC9RMmFYWXVB?=
 =?utf-8?B?Yi81RE4wM0NZSVR0djJpVGNqcWFlbUJHcHV3V0s0L29RN3BqU0taWHZoaW11?=
 =?utf-8?B?TnJJK01TWmZJS01SVVdodm13cG1SdGV5TWtNbHhsNkJyWnd6dmx3bUpZZm1x?=
 =?utf-8?B?TW5pa1JYa3g3NGVJQmFnU3RHaDhFejlsUkpSeGpoSzBqOHZPRmMvR1JGbHhq?=
 =?utf-8?B?U3k1SldGeGl2UlFFVnd0aUltaHJxZVh5ZVJWcXF2dGVCellVTWdzV3VlQS9y?=
 =?utf-8?B?K25VRnhoQ0xiUmF1SWFuanhkTklQdTFaZ1pFeklidWVicGNGRkNmVDloK2ZY?=
 =?utf-8?B?YnhCSkNSZHgwYU9CRlNMMHBnWDZ6R0pHWU5JZ1BGWXAwOHY2SGg5ZUF3bHJI?=
 =?utf-8?B?VWMxajlCUGJZZHp5ekVXWTVBVnIwR1pwQTV2OVB5RFB6QWpaUGRQWlB3SDd3?=
 =?utf-8?B?L1dFSEZQK2MyYjBWK0d3RmFTMFdzNlhGcks2dDU0VCtOdnNCZ2gzbnJkYTZn?=
 =?utf-8?B?bzZWZU1tdmtmUkxSVnI4SkpxeTFlZ0hCMUh6UGhweStMTWo5L3hsTmdYQ1NI?=
 =?utf-8?B?WmZiYVdtZnFHQzEyeGFPaVJjTWNkUnQ4RFhwTzVNMjE1QU5PZkVwRWRvS2E5?=
 =?utf-8?B?VWQxOTlnZTdsL2tmQi8rQi94Sno0b1p2SWJXTWJWaE9OVnduNm1yWXNSc2pM?=
 =?utf-8?B?UWRNMWM1SCtQeDZ6ZGJyNG1SemRDWHFXdEtvMW1NRkM4ZHNXOCtWQ1FKaEpo?=
 =?utf-8?B?dXE0RDYvNGJZK2hwdUpLN2tEc2JzWEtYMTlXZHBHcTQ3UWxsM0ZKMnJTN3RD?=
 =?utf-8?B?UjJhcC9KMkc2VWplVVpZcHRHVmRDMGw3OTl1UjBVU0V2VG1TZ3h0RDQ4YmRE?=
 =?utf-8?Q?yYI6Z0?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319c0321-934b-47bf-504c-08dc7972ccd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 08:48:34.9018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +x76MUL5LxVKfVz+nIVHDSXn/nVyq+xx4dwixavmYY3bisA1J2RHor86EKvBVv6y1QpAt1EBbrDRz5BYOYuNqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR83MB0523

PiANCj4gTmVlZCB0byBjaGFuZ2UgdGhpcyBjb21tZW50IGFzIFJDIGlzIHN1cHBvcnRlZCBub3cu
DQo+IA0KDQpUaGFua3MsIGZpeGVkLg0KDQo+IA0KPiBZb3UgYXJlIGFkZGluZyBuZXcgVUFQSSB3
aXRob3V0IGNoYW5naW5nDQo+IE1BTkFfSUJfVVZFUkJTX0FCSV9WRVJTSU9OLg0KPiANCj4gRm9y
IHRoaXMgdXNlLWNhc2UsIEkgdGhpbmsgaXQncyBva2F5IGJlY2F1c2UgaXQgd2lsbCBmYWlsIHRv
IGNyZWF0ZSBDUSBiZWZvcmUgdGhpcy4NCj4gQnV0IGl0IG1heSBub3QgYmUgYSBnb29kIGN1c3Rv
bWVyIGV4cGVyaWVuY2UgZm9yIFJDIHVzYWdlLg0KDQpBQkkgdmVyc2lvbnMgYXJlIGZvciByZXNv
bHZpbmcgaW5jb21wYXRpYmlsaXRpZXMgaW4gQVBJLCBhbmQgbm90IGZvciB0cmFja2luZyBmZWF0
dXJlcy4NClNvIElmIGEgdXNlciBmYWlscyB0byBjcmVhdGUgYW4gUkMgUVAgaXQgbWVhbnMgdGhl
IGtlcm5lbCBpcyBvbGQgYW5kIGRvZXMgbm90IGhhdmUgdGhpcyBmZWF0dXJlLg0KVGhlIGN1c3Rv
bWVyIGV4cGVyaWVuY2UgaXMgbm90IGFmZmVjdGVkLg0KDQpJbmNyZWFzZSBpbiB0aGUgYWJpIHZl
cnNpb24gd291bGQgaW52YWxpZGF0ZSBhbGwgcHJldmlvdXMga2VybmVscywgcHJldmVudGluZyBj
bGllbnRzIHRvIHVzZSB0aGUNCm1hbnkgdmVyc2lvbnMgb2Yga2VybmVscyBhbmQgcmRtYS1jb3Jl
IHRvZ2V0aGVyLiBBcyBhIHJlc3VsdCwgYnJlYWtpbmcgdGhlIGN1c3RvbWVyIGV4cGVyaWVuY2Uu
DQoNCktvbnN0YW50aW4NCg==

