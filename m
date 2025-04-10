Return-Path: <linux-rdma+bounces-9333-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B538A84524
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 15:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF5A9A5512
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3406A2857F5;
	Thu, 10 Apr 2025 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ivzj+SgS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2119.outbound.protection.outlook.com [40.107.21.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2D2853F2;
	Thu, 10 Apr 2025 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292326; cv=fail; b=t30esoYU+xAW8sG4GwrTHWHk8s30ZsJy9HsGp18B79ukYM6Kp+n1ntf3uZ8QW+0LqbQkZC8tCapusUXUqCK9VjbSu3hkevr/ofeAtxpKX0RfOVuaMwF+wzm9QLULoSFYzHtAjMiab+apZVe9KVN+mwiLw1IwzbykKOVyzWUrJYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292326; c=relaxed/simple;
	bh=DJUWdX2jJtClLrdOlmyC7XSOEg5hJRkPccWwkPtQ3r8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cdJgLcdfGaBVGv4lupy0B+ErVeHvkkrz0/yS4iERLdjgTw06CMfB6t+LH8nRIXGO5DtA6Ij2lGIBjGTERrVNWwZ951sMfIe/hU6Do0n0N7IorUr30PYMfHbJ+kXNHIapjbyGtDGkCA+CgheTD0b0EtrnmRHpm9iRS/85uFbvy/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Ivzj+SgS; arc=fail smtp.client-ip=40.107.21.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTCMOb8dbFgPg+xDVvR9V69iumNMf78j7fvFd6/QhAIbeU0CEQnlwmhIh02UGSp7L/X9wSMMZo56QTU1jpbBzL2i/aU5qHX52j4NGbZ0Gly3MtTSNkFKrzTaP1tIwSTDeHo3s/zaMy8mBhWicICB+/83JmH2fFyAZn/cK451zBwzqUdnviCOZ+bXW7pZifFB6y4ERWfQBU48JY9JdNqBWn4QhmdKIylV9pO3HTcRqEmwpl4mE/B/E4AnJ3ULJqEXun2j91laZPGcxWVPxT0PX8yU/i9OsmC5pTI7awBHfbrd4mmdTL8uF9ppViNECMqGfQKq0Pf1U8U5pyiQdZG+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJUWdX2jJtClLrdOlmyC7XSOEg5hJRkPccWwkPtQ3r8=;
 b=JYRF9ZjX+U4kOcpZwP2rg6fwtf9jDf+QIWU4qvXMEBYi4IzIPVVKtOGQShGfKqxmMj+eY6PFbe3QAIt/uSVRFSTTOdWQQeBBJo4kOAjlXJyK+0z9jcrk+F7id39FyUZ7YIyBIigfcZYRexq3nOmzOkRum69LY7NJM9R7TtQ2+xtSrJRU6/ta7xDT5d9Lm0dvw3pMequlnCfSMyHA7wXvvbt5YNg8hgOq7KigjGKFE6n5FkFT+3tyI93Scru7LGbNPNlkQvhP/V/u/IKH4f6wfuLMLUnOkQLK/e7vNhtV6mh6f28BFQ/7008EGhmIOOIgsWWcgcbNTo9gc+LsSGCY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJUWdX2jJtClLrdOlmyC7XSOEg5hJRkPccWwkPtQ3r8=;
 b=Ivzj+SgS0b3La1k6wWSii+FaW5wtEvEdhPM0Qrg/ApTq0eUL4/kvjnvz7Lizo8FhAENDeqcGqROIMiEHv7uA4iqu7cUJSp0N/N46H9NagJbrQQKrpcywjeNwdhgxBZsVSKaUjZ5BnbrFflelE2NhLLXtQvfGHhMar4gbneMVZnw=
Received: from PA1PR83MB0662.EURPRD83.prod.outlook.com (2603:10a6:102:44c::19)
 by GV1PR83MB0756.EURPRD83.prod.outlook.com (2603:10a6:150:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 13:38:39 +0000
Received: from PA1PR83MB0662.EURPRD83.prod.outlook.com
 ([fe80::3c3d:5eeb:9d38:3fa4]) by PA1PR83MB0662.EURPRD83.prod.outlook.com
 ([fe80::3c3d:5eeb:9d38:3fa4%6]) with mapi id 15.20.8655.011; Thu, 10 Apr 2025
 13:38:39 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next 3/3] RDMA/mana_ib: Add support of
 4M, 1G, and 2G pages
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 3/3] RDMA/mana_ib: Add support
 of 4M, 1G, and 2G pages
Thread-Index: AQHbpXBMe6lzlJmRb0OIKSOsZnv+J7ObSrSAgAGl0XA=
Date: Thu, 10 Apr 2025 13:38:39 +0000
Message-ID:
 <PA1PR83MB0662BB595EEA7FE39B97422EB4B72@PA1PR83MB0662.EURPRD83.prod.outlook.com>
References: <1743777955-2316-1-git-send-email-kotaranov@linux.microsoft.com>
 <1743777955-2316-4-git-send-email-kotaranov@linux.microsoft.com>
 <20250409122743.GK199604@unreal>
In-Reply-To: <20250409122743.GK199604@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=48f80eb3-73cc-4084-b3b8-d5bb6c9c0326;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-10T13:37:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1PR83MB0662:EE_|GV1PR83MB0756:EE_
x-ms-office365-filtering-correlation-id: caa746b8-03fc-43d6-d787-08dd783500c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aGt0OTdBUGdPa0lHRlJXaHZ4UG9JZ09ERkl4RXNwM2ZkTnREYnZxMUY5VlVX?=
 =?utf-8?B?Tzd2UlBkNGM2TDdvWVk2d3FMdnE5VFVmblVtaDBmMWg4WnhlTlhmVGR5eEpy?=
 =?utf-8?B?djFGMDZHTElnTXBZaXlFT0J4NExqK3Qwemdhaitrb3BEckl6T1NWaEJUZUZm?=
 =?utf-8?B?b0ZSUDJTeGptcS93Y3h5SVhQSXZqai9CcFIrVmJiOFJ2VVkvcXd3djNiVGJt?=
 =?utf-8?B?eFBTZ3F1ZjJtY2ZDRFRTVDZXOVJQdWJ1dUlRMWhDUkVLY1FBaU9yU2NEYUFG?=
 =?utf-8?B?MStVRytGMnFyNmlrTnlOVDZyL0Izd3lVWU1QaEtyVkVqYnN4STBSUHk3Z0Jo?=
 =?utf-8?B?Sk5IcGo0UDZUYVZMY0tWaG51WEt5VWtMUmY2V3JRbWpEMW9iSVE0cVVqR1lQ?=
 =?utf-8?B?U0dTRDZabUcwOGJoa3Rqd3ZMajJnOXBMVDcyUHpOcHRkVDhDNEpZaFdnSDht?=
 =?utf-8?B?RTgzT250ZHZHVzBLS0ZnNklJYmZXWDlCOWU4UVZOQXhqNVpONlNQUFl4M05k?=
 =?utf-8?B?WkJVOXpJdmJhd2NPREVuYmhCMHl6SjNLUXFjbU5FVFYwTDJQOTdCOW5DOGlW?=
 =?utf-8?B?VE5na0JaZ3p1M1ozdlFOZzZlMkpMRjRRQjJyZ3NiREZhcU94UVNRM1UvSWE5?=
 =?utf-8?B?N3lPWWdMVnRUeXhUZnQ0aHdyZ0tkMmsxU2hnVzJ4NlRJMTJoL2xJVWROd0cy?=
 =?utf-8?B?ek8xVnFyTlAwTmkzQi8wRTE0Sm1zakhFdHgxYjdVU2psOE5YUVRuQWZnaFZm?=
 =?utf-8?B?cDlQckd4ZEZsejNjb0dEZkZBZDZzKzU2UnpUcXRPVmh1SFpEQ1ljd05RTDVK?=
 =?utf-8?B?Q1RwU2ZwTGZZc0pxMmN4dWdRNE5VL2FCVEd0dDdtQ0VPd2M4K3ppK2h5bUI0?=
 =?utf-8?B?Ymx3YnJjR0VUTUhrVlZUektVRlpxQXBMZ2ZjWUVUZkNUYUFDaGFBdXFiUEd3?=
 =?utf-8?B?NThnV2E4NXRoNkluRHNLcUZmSVEyWWwyS1JWRHQ2Y1RrYm5oeVNUR2wrNzN2?=
 =?utf-8?B?OVl3NzNTRjlwNmhNcmxvOW4yTU0rSzJ3TFRGRnFGb3FXdU1uVG9XSTBob1pi?=
 =?utf-8?B?Q1dZbkdnVXdRWTY0U0NPeXNnYVJzNnVHbENLRWs2YkNaYUgrenU3SElENGhq?=
 =?utf-8?B?bjRjVzk2cDJibDFVbXpqN0lzU3FBNFBZUk4rL1ZRTjM1b3h6UVlxRDFCR0xi?=
 =?utf-8?B?eStCNGFnUnVac3U4M2p5bjlPZldYd0U2M3hjTmVkWWJYWkZEbTJEZ3l6eDdB?=
 =?utf-8?B?SWxiZlVlRTl1aS9YM0NSMHpZVFFVMHU3QUN5dW9RVzIzTDVJRUtYRXFXcW94?=
 =?utf-8?B?QlFGcWRwa0RBRlZLSEk2MTRGdnVqWEx4UFV0ZTFnMUJRRVROZ0t5T0FZcWJx?=
 =?utf-8?B?d1NtUlZnWi84WVlKOXRpb1FJQVUyR20zRFp1a3VBYzJBQ1hOdVdTcmRRM3dm?=
 =?utf-8?B?dlRNZVVUVHVMOHlWLzI3RXRDblQ3Z2FSTHV4em5ROThGK0QwUUhDb3RpY292?=
 =?utf-8?B?NWt3aTRveS9DazQxNlJJdjFnVHUzeWVhMlVwMUdZMWh5K0w0SlduMXNCc2pz?=
 =?utf-8?B?eWhITmRXSlZTVkIvOGhtc1hWOFZneU4rSUM2cjlVakh6TjJMSUtOWnloYTE4?=
 =?utf-8?B?QjFkUDU0enh2VEppbUttYU5LbFVOWWpudHVSUVBFOHRudEpCUFlvNmFUWXFt?=
 =?utf-8?B?Rk0wcVNOVGhOUk04ZzFGeXFmRHZvZ0hQZ3Q4NE5CblByejhYbmkxaFU3Skpt?=
 =?utf-8?B?Z1l0NldlK1lKNURDdGJtSnNpdE5BMmhjaVZpM0JUbmpPektQSjlHc21BWHhF?=
 =?utf-8?B?emRaSUxOZlY1bC9qVkd0RnQ4OUJ6NHdZcXJpVXU1MVZ0NjliTnVVUzU2Q1VJ?=
 =?utf-8?B?ckNNNVAwV1NxZzViNTF1Q2tuY1JmVjQ5N0pnYmlYTXd2MGJEQU9sSmVGbnRG?=
 =?utf-8?B?MVlpdGRTMEVUMHFyYTBEekxPRWthR2lPSG9jYXFPZzI4MzVLR21JWXJJakc0?=
 =?utf-8?B?ajJ1K01YVStBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR83MB0662.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2c4clFCak1jem1RWjlXUVBMNmRjem55NW9rNnBrWjMzSWlrc054cjhkVHIv?=
 =?utf-8?B?R2xPcS95UVNDK09QUTVJa0VFSWhNMFNYZ1ZkV1N0ajRNM2NGOTRxNFJxOVZQ?=
 =?utf-8?B?djVzMHR5TW5PSUt2VHdodXo4dDJ5MUNkNkdqWDNLQTg5MzN3VVYzbmV0TS9H?=
 =?utf-8?B?TVBQM2pzM3VvMm1tQjlZUURMQjhpSnEvOGtJekl2NGdZbmh0MFAvU0VrZkEz?=
 =?utf-8?B?N1RKeXVJWGxUUEoyRWxiT0VtRzdWZ0liaFlQbzRPRGo5bVVMSFFKVmE2MFp1?=
 =?utf-8?B?dXV6d2F1UVZjZ3BCbGJWaEpQSHhmQkxPTEpobW5MdUxKY1I4aUk2Z3ZuQUE0?=
 =?utf-8?B?SnVxdkZqait0ZGx2aHRYWDVlZkFMWFdubWEzWDNYVnlkbkFWZzVrekdDUm02?=
 =?utf-8?B?dXhWbXAzcjJ0MGhKUjNzb0IrVExCdzJVWW5qTFlQZFdQVzBMN054QmU5aUhj?=
 =?utf-8?B?emN4Zmx5UlFFbkpjRUZQOThvYW5vd21GMytMR3ZKaDBEdGRabXU1U2FXdjQy?=
 =?utf-8?B?N3NMbU1kQU9HNGNhUStmUzdWdWg4SzJ0ZmcvSnVkL3BEczc0cFM0NThXdWpW?=
 =?utf-8?B?VVJkNWlxcjJ4alIyYmJDd1ErMXpMWG9kdE1YNVQ2RXdJL0JMWFFvUCt3Mzdw?=
 =?utf-8?B?ZWE5ZEU1aG9YTDA3bXlEUjhTZW9aWElpNjlqdnliWHpMeGVuS0FSU2hGK2xW?=
 =?utf-8?B?bnVQbHloV2FBRmNwOFhvOE1Ob1hoc2JXZktySWZtNWNLSFFtWENpMTVLeGY2?=
 =?utf-8?B?OVRRUTNiR3RtR0QxZUpvU1MrdGRSSk83NDBXQXg0TjRHS0o1UmdTR2tXUTY3?=
 =?utf-8?B?aFR0OWZrNy82UTZhdFNCQ1NscGJ5WUpwNVFkaU9YWmpGZW9ETWo5SjN0Z3JJ?=
 =?utf-8?B?bTdaQnAyUkp6OThLR0cxNlVVUnVpMXBoZm1RaFRaZFFGQWt4Q25SejdRZVN2?=
 =?utf-8?B?VnVaWWdzS0tjTEZ3bS9VRlAwV3ZsL0VKOXcwc3dWT0tIUUUxbnJJeXZPdXZW?=
 =?utf-8?B?Wk9La1BZd1Q5ZVpBeFlTelNKcHI0a1hjOWFzL1NTMXA2Q3V0UVRpVEdkajdZ?=
 =?utf-8?B?UkxCc1g3R0ExeUlSUXFEWUg2NGg5ZHk4cnlrTDVlWDFlSUs3RDJQNHNZRkpa?=
 =?utf-8?B?YlArSGVpVUJmdHdiOFpIc0tPNnlUeS9ta3FtZ3QrVS8rdUQyc2RhN2Nua1Fo?=
 =?utf-8?B?Rmx6RStLM2tBYWtYbXJaU1dsZTZzcFdGNHA3UEk2MC9GakJ0aVI2MnlSZnFw?=
 =?utf-8?B?TU5JZFlKM1pockRteDRWczBENk9jVWRzSzBIU0FQdFZWR1FRVG5YdHdRWTgx?=
 =?utf-8?B?QzZ6c3BlZU9aUzBVdWpOajlpUHJ4ak4xbzdPaFdnWHVJbisxSHVvNzR0UUw3?=
 =?utf-8?B?OEEwNEl5ZDBNWGkvY1E1bWFxeWRURHVjR2NNTXNTK3EzZUNJRW5XVk1rU1dS?=
 =?utf-8?B?RVJxRVJ5cHRYVENIak10d0NIK2FqS21SUDBjT1ZmOElkQTVla0JUdFl4V3Aw?=
 =?utf-8?B?cmdjd2N4UzRmVUNyZ3pMM1FPWW8wZ2hDTTJtRjNwY2I0V0hCdS84Wm1vT0tR?=
 =?utf-8?B?Ukt4TFNjRDc1QWtqWmtuNVdJOHJZK1VZV1JBK1ZpRGlvZlJBQk1pT0o5alhl?=
 =?utf-8?B?b2dwOTBaZ0pGaFFtSnIxTHFnNlFFZlQrTmo2OVJRVnNBMmJPV0ZzMFhGdnEy?=
 =?utf-8?B?WHR3TTFpcGhicWZleGdhL0lDaHJKQ3JiVVFVeFdUSk9QNmFoMlJBNW4yclgx?=
 =?utf-8?B?RGF1V2o5SFhtMlB1Yzc4cFYyUnU4dk83bjd1Uk9VZnpmYmh4SXdRYktNMGZm?=
 =?utf-8?B?L0xuVjJ6a0c3dGVuMFlDL281MGFnRHZJUzAvRkVkRDJlN1czVjlNbytQUFlh?=
 =?utf-8?B?MEZ1S1FHNzdmcTIyZ0h5SjlxdHlaVkkydkhYTndLOXhNYXhTb25iM0NSbVAr?=
 =?utf-8?B?Q1Z2UFZUNStLMmhyWVhBcmQ2N2NZNHlHeEFjWkFRV0dGdjN3WXJLaFBueEpl?=
 =?utf-8?B?ck84MG9zVGtQMWxYRjBiU3pyUEZKWEZqQzdDNjFYLzlUVGcwR3dlRjcvNE41?=
 =?utf-8?Q?y5diMK?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA1PR83MB0662.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa746b8-03fc-43d6-d787-08dd783500c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 13:38:39.7687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqZoqyHviYakevIFaG6mJ6qFl+6ftSlAFaIHSinjYPm/gWHqIY9jnu3g3OwwHLOeo+7M0wvXFBJIWwUb6OtLfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0756

PiANCj4gPiAgZW51bSBnZG1hX3BhZ2VfdHlwZSB7DQo+ID4gIAlHRE1BX1BBR0VfVFlQRV80SywN
Cj4gPiArCUdETUFfUEFHRV9TSVpFXzhLLA0KPiA+ICsJR0RNQV9QQUdFX1NJWkVfMTZLLA0KPiA+
ICsJR0RNQV9QQUdFX1NJWkVfMzJLLA0KPiA+ICsJR0RNQV9QQUdFX1NJWkVfNjRLLA0KPiA+ICsJ
R0RNQV9QQUdFX1NJWkVfMTI4SywNCj4gPiArCUdETUFfUEFHRV9TSVpFXzI1NkssDQo+ID4gKwlH
RE1BX1BBR0VfU0laRV81MTJLLA0KPiA+ICsJR0RNQV9QQUdFX1NJWkVfMU0sDQo+ID4gKwlHRE1B
X1BBR0VfU0laRV8yTSwNCj4gPiArCS8qIE9ubHkgd2hlbg0KPiBHRE1BX0RSVl9DQVBfRkxBR18x
X0dETUFfUEFHRVNfNE1CXzFHQl8yR0IgaXMgc2V0ICovDQo+ID4gKwlHRE1BX1BBR0VfU0laRV80
TSwNCj4gPiArCUdETUFfUEFHRV9TSVpFXzFHID0gMTgsDQo+ID4gKwlHRE1BX1BBR0VfU0laRV8y
Rw0KPiANCj4gV2hlcmUgYXJlIGFsbCB0aGVzZSBkZWZpbmVzIHVzZWQ/DQoNClRoZXJlIGFyZSBu
b3QgdXNlZCBleHBsaWNpdGx5IGluIHRoaXMgcGF0Y2gsIGJ1dCB0aGV5IGNhbiBiZSB1c2VkIGlu
IHRoZW9yeS4NCkkgY2FuIHJlbW92ZSB1bnVzZWQgZGVmaW5lcyBpbiBWMi4NCg0KPiANCj4gVGhh
bmtzDQo=

