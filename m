Return-Path: <linux-rdma+bounces-11900-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF11AF9523
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 16:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE37B1892E25
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 14:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E128417AE11;
	Fri,  4 Jul 2025 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WUg8WgFf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CAC182BC
	for <linux-rdma@vger.kernel.org>; Fri,  4 Jul 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638409; cv=fail; b=OI/C1aXnmpDmTjBi/ugCQ7GbuQrFjuLF8zSM565zw4zGKLTakCsNYBLv9p4q67mnm5O2NbK/ixtAZdsFMjmVQ2mOU3CsSXgjA8J1w3uuhHLK7h4sT9TAeW+LYnZenFI9oOlTYC10xvAhcBC6BOcZga5SMwTTiYnUHRO06stpoT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638409; c=relaxed/simple;
	bh=J4QfWvuIr0NLtpvUKMztJsJKe+5fEYBUhH/Hoddf+Zk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=XUHiAMl9nIoG0KtPg/uCJYZyimm1bec6XaHHYefCu88mCOVM8OvfAHmCulqAthD83qEiW9JmdxHzG9IJtftigNTY0UGn1z16P2G4UOV2jgUxGAgqdoDhefnQQFPNqnvhGVFWrstor5K5sBTNW+KLvY8UnTcAI2IDjVSov1YlI6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WUg8WgFf; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5648ZK54032739;
	Fri, 4 Jul 2025 14:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J4QfWv
	uIr0NLtpvUKMztJsJKe+5fEYBUhH/Hoddf+Zk=; b=WUg8WgFfIY8vy1q//LPzqY
	USLH0PigxAXtNRGyASaLw8Zen6esqX8ScbwcfnP8+m5J5364jIo790Tvp/xd2Dn/
	JIss7DO+fViZUiXC8BB9U8PkniBuPEysWjqB9YrMLJp7iaQ2PpU+rwJPXKVjIIU9
	HHZzCIXbQyExcFefdWmZbNDiT0CA25GwnzVxUc5dqgoRDF3Z2QuGeiXz75hDd4Y3
	yFY43M1x0r8odZ/mpOK/XxXkErDlMEaEqhx2p8AJ6wRxXP7ClCH+0A/hZ6TFHOi3
	UcgvCdI7jJtN+gWDM/9g1PF91ym4NN5rJPXWpdT9Ad4CxJ4EnxmtMgjLHKPNZU0g
	==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dt7sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 14:13:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlRHn6D/mIWZWxLZpUQXIutMeBuiN6V3qTOBLNrKdUmeddTiT/ZwCmcVm/SXGqRHvAWhmA9oouOqwkGUAj32wfRKKDmkl3I8LhFsmpnCCquASbdRRjlCoqHk6Y5sBoC3Dh70yhQwDYx8ZpLhJ0d7aEgRMf4v4YgbWhad6aPMDc2j94Qjbuj/Ufd3sPMIaFCK76C4hMoRBOz+HzB928+s+l5Rs8CkHdQAkfkBqBY2fQc5aefGJCtPWR/aYGOdek7N3GjEO75dNW0/6qUXAPClmEkj/KdcQXMuNQAWjDOucJwxmNowtKS0wNaWjcYz/z1ksN7e+8/MBmgu/F9qLipM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4QfWvuIr0NLtpvUKMztJsJKe+5fEYBUhH/Hoddf+Zk=;
 b=r3aWKUHq5f5gRojqsGoRsCh2PdLmzuy/QoHkPL6svhtxJvib0tUhueXeDCFqlk+QvEKSuwV65zB+dp4Mj7eRx9cM78/oY1E2wbdRm9dqPnn2F9ogr7iNuJ+ZahufE9yihH8ABagA8TzJ79JDdSYVFiX1h+WYQJkqrrWequoOv2cn6STHG/XjI1vvTiWs5Py3dr6TXzD/60q36+mQ1hUWyOyEGMBMqRJfsD0F+XxYuQscF6+QmXDNtrPcRhGB5F6ellOMqqo5w13scQlK8P6SAEBotOYyz33TZ5fqtWlaaXt3BF/ZDxXqQ3ovtOT/7b6EJKFLecdpNuAWGFa3U5dUig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by IA0PR15MB5908.namprd15.prod.outlook.com (2603:10b6:208:3dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 14:13:13 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::4349:d5ca:1d09:1e40]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::4349:d5ca:1d09:1e40%6]) with mapi id 15.20.8857.038; Fri, 4 Jul 2025
 14:13:13 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Chuck Lever <chuck.lever@oracle.com>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Stefan Metzmacher <metze@samba.org>
Thread-Topic: [EXTERNAL] Re: [PATCH 0/8] RDMA/siw: [re-]introduce module
 parameters and add MPA V1
Thread-Index: AQHb7E8NexRlRPvKjUqIJR0dlGlBM7Qh9I9g
Date: Fri, 4 Jul 2025 14:13:13 +0000
Message-ID:
 <BN8PR15MB2513C2F2B9C73A1AC715E19F9942A@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <cover.1751561826.git.metze@samba.org>
 <4eacb709-4508-49cb-a672-c49e9d7fa902@oracle.com>
In-Reply-To: <4eacb709-4508-49cb-a672-c49e9d7fa902@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|IA0PR15MB5908:EE_
x-ms-office365-filtering-correlation-id: cb9da5ea-847c-431c-0778-08ddbb04e9f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WEJFNHRraHJ1eWVvYlZ5bTdWWk9PUDUyU2tqVFRMNHkvb011L1dicDZrUTkz?=
 =?utf-8?B?NForaFlhdU5yMHFyOEp3UkUyTXNYOVhmTmZJRVBGVHplaVJyOU5tOTFsenpM?=
 =?utf-8?B?Zmg4UktTMEozTnQvOHB5VXFFemV0ZnFaQmI1MFRJRmFORUlJUlRZWGpKRHZm?=
 =?utf-8?B?R0dBdncrRFdNbG5YUXgvVXdpaXBYdzVIekkrR3JxNzZqSTF3WjBXSk55cmVX?=
 =?utf-8?B?cmszYVphRW5SbXlPNUJhOForRi9EeHVieXhjTmxlK1piSHdUZlJSZ1FlVmhJ?=
 =?utf-8?B?d0lhMkZVMnJWZmRZdTExd3JSa0JYWlI4RU04byswb0VPcllYL255eHp4dndL?=
 =?utf-8?B?TFRuUkNQaC9jNDAzblQvOUlSS1Mvb3NTcG0rNVFnMmJ6VzQ3a2pZRENKTFA2?=
 =?utf-8?B?alBOWEtrdXEzMTBtK2ZwTTgyUzVTc1Axc1hDaFl0dTBBOW05UHBQSTJFV20r?=
 =?utf-8?B?V3lnT2t1aTNXKy8vWlRHS0NVRmtQQ0ZIWUx5UmhheTl1b3dQTStIdU9HcTF2?=
 =?utf-8?B?MzkybmdlRi9weUEzK3hQbUNpQWV3Nk81aFMrd0lacVJuWVZ4VjNjaXNHZUpw?=
 =?utf-8?B?Sk9BUGlKTWwwNit0VDROSklLeDdVNjU5aktIZFZjQ1VMMlRZRVVpU0czQk5m?=
 =?utf-8?B?TmJUcEtEZnhudXR6emNLTUxTaWhkRzh0bUZIclF4Z0dzSHltME1iQVpmemZu?=
 =?utf-8?B?WGpobkFqTGU5bnVMaVRqRVdobnJZY2J5d1FwemhQQkI5UDdpaXpBbnpSVm1J?=
 =?utf-8?B?WG1kSlFDamRnbUQwenpIQTQ5dWQzVVNYU2MrSnZNM3hqWDV1cjBQYlBmVVQw?=
 =?utf-8?B?WUN2WkZuV1M5ZXZzUEZHUnQ2OHBMTFFlZFhnUHhKK2VkNngwdFdBYTZScHNK?=
 =?utf-8?B?RjR6Z0xkTDhkbVJ2dHY3WXZwMUVmTElzUE1mckxTTDdoY3pvZWllZ1l3dUI5?=
 =?utf-8?B?YnI5UjBGUmg3OWUvNHB3WXlPTUFhN1Z6eHVoTzhYNk5ocHdiTk16UUtlcC8r?=
 =?utf-8?B?bDM0SE5UN1pFc2pyU3RxTGRtdHdZK0hOVkhTNkdEcWR3Zy9seXI2c3Z4R2RH?=
 =?utf-8?B?VmYrMlA4dVVFNEFJU1VuYXpJUVlpOW1lc05wamhldDJzT0lrZ3cvNnpqcDVH?=
 =?utf-8?B?WSt2c2VINHEwR0NGejZSdHdnRmRVVWdPYVk5dXcyMXUvcjNINHJvZXdEVFVy?=
 =?utf-8?B?VU0rOVNXK3ZtRWNaYnYwdE5uZVp2QjdyTjFOZEY3bk9RcUNkTWVWc2hhVkJT?=
 =?utf-8?B?bjM4dGJnTkZQd2x4RDNFWEJFUkk5bFh4RjQ3ZlBGczZaVTJMcWl6dXhwSGtL?=
 =?utf-8?B?NmFHNlB4NytpSVJmOG9DejEwWGVNMjJHOHNNK3Bvd3VyM0Q4b29nL2plT2da?=
 =?utf-8?B?WmhHZ1Fma29IblJJYkFrbUtKN3ZORUwxRmFDTHVNZ01lcnUvWHd4eGN2RXdy?=
 =?utf-8?B?dkRSZG51T08zVDV1RFJ6RkNEcU14SUd5MFJwenVRWmRaalBQUERCakx3U2di?=
 =?utf-8?B?RW9XN1hQdkdXY3VtVmFxck9oOENxTC9OMy9OL1dIWkQ2MitON0k2c05hVXhh?=
 =?utf-8?B?NGFwMHFxWVhBaHdvVlhNVEYyTFlsdlY1QzF6dnNZT3dWd2NxV1NXNHVYQnRj?=
 =?utf-8?B?SXNGVlp4Q1RCdyt2NUFRV2cxQXhnbkQwVGRLc201aEdDdlNRTWZLejFUU3Fz?=
 =?utf-8?B?dHhOYlJsTHVFalNMSDFsVGhwOE9LNldKLzNxM3AwMFl4MzVIRXRwdXVDUnpv?=
 =?utf-8?B?QmpkRHB0S0pZY3dOSk4vc2hNTzNGcDdGRjhXbitiMS9wYnZIOUEybitNcEtO?=
 =?utf-8?B?M0tRaHVEUXZCWmE0NVZBVmpuWmJFb2NCb1NBRjkzcEZ0RTdYVEtHVThUREZx?=
 =?utf-8?B?YWNNM1FVNkNVdUZTZFpPUGVhMjZuT2kyeHQxY1VJSUxydmdzL0IvTzh0MFdx?=
 =?utf-8?B?NmVCWG05QnlFRGJrZFZJRmdmSHJMZ3krdDVvbXZYRGxvYnd5QnpyQnlSUElZ?=
 =?utf-8?B?ZmRYUGVndStBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yy9NMG5PamRxQjJYeGVGWjVJRis3WmUyWmhadEtkSG5uR3Z0c2dkQjVCN1Rx?=
 =?utf-8?B?TjJiYWRVREhwaE53K3N5RXU0UkdEYVZJRCtZZXpiZGgzdnlFMm4wOXpEZVNm?=
 =?utf-8?B?TndvcGVuMWd4RTEvVkJLUDliU0NyMDZFU2NCVlIvOWNkQzFTSFBqcENzNFpt?=
 =?utf-8?B?YU5yUVZxUlh3aC9JS2puL2dsMlIrWFgvN3lDdmh1bkN3VEY2SnFrNXNWQitM?=
 =?utf-8?B?U0kyMTBPVXFJcUREa1F6S2ZKQmtabXdXTWl6cDF3ZGh1dG9kWVRyejJMb05Z?=
 =?utf-8?B?V3BhenR6RmhWcG4vUnpHR25sVVFuWThiaGRrM0RMejV4T2E3bjNtVGRQQ2J4?=
 =?utf-8?B?VUxxQlZpNHp3UmwxTGdqTXJySGFNY3Nwblh2aWFGalhqa0IxNEVLSnIxbFlD?=
 =?utf-8?B?WWNYcE5uMGdaSHlTVkNyamE4YXVlN2tKMGdRTENGYnpSanB0RXVyTnFlWmdw?=
 =?utf-8?B?QndmNzYxZi81RUVHL2hRUFJJcS9zQkZBNWNnOWZxRG1td1JhaU1xNUxwVUF3?=
 =?utf-8?B?Q0lFeGFBdlVjYkZzVDY5d2dkbGREellJaVNOVnRoUE9YYngweEIvcVpnUFVV?=
 =?utf-8?B?NDkwSUwrOXRLZlhCY2pLempCMWRKVWI1ZEN6Rzh5eUNoU05yTTRqMm9RZzBp?=
 =?utf-8?B?NVBWQXVaMVlxaGY3N1RUR2JQa2pEOURqSVJrdkY2aTdMQ3NCVno0aHhRZC95?=
 =?utf-8?B?VU9KajBPeW1pNmE4elM3ZUdVUGFDRFBSWGlzUktFNHQzZWtCdE5RL1VlMCtv?=
 =?utf-8?B?Q1FPZThZdExFSFpHL1lnRkRrd2UyK1MzTVBPcERvWkhqV0FwRVhkZXhtUXFJ?=
 =?utf-8?B?U0tlbERQL1RrL2hIeEtWRWRDbmxhK0hJT1BIZ2hmejRqTHBiTi9wUkVmWUFw?=
 =?utf-8?B?WkZuamFOcUh2S1hBRlIwMnllTlpqVDBtZXNSN0E0V0xVQU9YY1FPNzVBbnRY?=
 =?utf-8?B?NU80Vm1xM0ZzZ3BqRi9hV3ovSEtwOHJRb0lnL1l2NjBOelFJVVM3WkU3cG5u?=
 =?utf-8?B?ZWZ1eUpoajVQWDAwU2tUV2JHMHc0cVo1Z1NUMHVhbWxpUnJBWXBNVmw3UDRH?=
 =?utf-8?B?M0RTM1MraXpqdDBYYWF0MWZNTS84UWR1SDlDMTFuV25GM3RlamRhMEdMMjVl?=
 =?utf-8?B?T0c0eElkOTdOSnpmLzdLQXE4bzlOTDlNblVvQklnTEgvRTVUVTIveDV0VHhJ?=
 =?utf-8?B?ZE9JSHhVWlZJUmtxYk50S3Bsckx1VS9mWWlURUF2aDFKMDAzeTlMV2NieEVo?=
 =?utf-8?B?KzA1bUVrWkhKd09CSWM4YlowMW9Db2orQ0p1Vk9KcnBFeFZERnN0QW9JclY4?=
 =?utf-8?B?a2dGRG82YjYrOTBRaDZqaXdkTjZxWmNkdE9MZnk5OE1CQkxsbUY2N0swKzli?=
 =?utf-8?B?aWhCeGl3Zk01eUZDZy9lQ0oxODNtREo3U09Xd1BvVkQvTEtmbDJ3WWhVemc4?=
 =?utf-8?B?NkZ6V2J6S2ZRMG9PSXhJSExzL2g0aGIrRDNsenIyeW80NWpwRXVpWmtuak9w?=
 =?utf-8?B?UHUrQ1pJY1dxZ2Z1R0c5eEtCaU1oNHcvTnJkZkRBeVJGZ25zSmRvNlQ4Vmxa?=
 =?utf-8?B?S0FJb0dROVlHVUVEbG9JdDA3UFI2endldjZEVHBOQWV1Ymhhb0p1bTdzb2tH?=
 =?utf-8?B?WHlreEs4NlQxRmtjTXNuTG5ERXlGbWJsdlRLWFMvL3U2biswTjJwV3BQajVW?=
 =?utf-8?B?Nm9rUnE1eFZneHBDNEZVV1hsZTgxZVp5Q3NUb2REMjZUVzN4aFF3c0Y2MU1w?=
 =?utf-8?B?ZXZmS283WUZ2d0lXV01YbmRkRS9icVk4eXBuRjZrSDN2b0ZYSkZuWW9mVTFZ?=
 =?utf-8?B?czJESzlTN0NvbmkrVS9sak5XRHVTZml6TlNibUFGWkhLS3c0OElMZFo2NG41?=
 =?utf-8?B?OUZaZ2VDYit0bm1UVitXZWlkNU1VRG1IcnRiRks5VWcxbWFMcmJEb2FhT0d5?=
 =?utf-8?B?MnIyTEprdFdMUkNmU3lzazRXVDNodXR2KzJ4Y280ZTYyaTNoVjRDSHpOelg3?=
 =?utf-8?B?MGx6Sm9LT1NrZDVtdytLTDdFM1VrMVJPNHN6aUtQYnNsRG9OQklRaC9SR1VW?=
 =?utf-8?B?K3ZvN2JSUnE1MWtSa1VxYlhUK2ZQOWRIdndjcGQweFJNeEdjSWNMd2pEMlpD?=
 =?utf-8?B?WUNVNHJzM2dyaEt4VnV2UURSVjVuWGZRbnJTdWNRaG1HaS9wSTc0dDBPTWMv?=
 =?utf-8?Q?iDXmqzQTtbrwBwvsmB+jt90=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9da5ea-847c-431c-0778-08ddbb04e9f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 14:13:13.5767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCFdh3vPlasWD0AIu3yhHbiFwYsipgHl32Nxc0CBi0AiaYdCaID38pkTtS5buJlC9XWX/XF0A75vBDh5Fa94Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB5908
X-Proofpoint-ORIG-GUID: zyJUyFJi-MpWLyVRdEns7LhhJ-jio8Oa
X-Proofpoint-GUID: zyJUyFJi-MpWLyVRdEns7LhhJ-jio8Oa
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=6867e17c cx=c_pps a=q+NZZ7aF8eLthFK4Etd3cQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=hGzw-44bAAAA:8 a=Ft_8diLxWbHtO7YSlLMA:9 a=QEXdDO2ut3YA:10 a=HvKuF1_PTVFglORKqfwH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNSBTYWx0ZWRfX66l6/B9opeWq tFwghrfqTx8S/zccMCq8kFuD/ShlB1vE8F2xMBMmjo1JzKKcahpDuUXYBVOW2pQKnpbU++PoMN4 +WOP0eLLA1LyEWUCZJBY/xNLHlSB3Y9jrixHcFKnUumbESz4674XAY9JXREJvy+P448Zox9RBbU
 2cMIeBxZUZsKj9Rn2yJrVY9nlAIyBk7kTskrlCUKd79il7ejqUIbT3XRAigW2s4tqqj2Pp2xfQD ygLxX4YqPwOZvb5JuWhCay1JcAC0MBCPXB7lwwheFegOrNes/HV9s7t+1f9uW2FXfH+Max69pL7 NQ3OS8dE0Kkgxd91rIQlsYeP/yM6iHLbjSkUxPjpslTcguUixBwyHCvp8JlOKKxxi/CGfqM2ET6
 BydUcsyzBGMsZUr05H0l/Ih/BiugpfdY8L72sdDdaQhIJtTtPlKg+uwNlMsqiHCjnQWHgU/n
Subject: RE: [PATCH 0/8] RDMA/siw: [re-]introduce module parameters and add MPA V1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507040105

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2h1Y2sgTGV2ZXIgPGNo
dWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDMsIDIwMjUgOTox
NyBQTQ0KPiBUbzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEJlcm5hcmQgTWV0
emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsgU3RlZmFuIE1ldHptYWNoZXINCj4gPG1ldHplQHNh
bWJhLm9yZz4NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIIDAvOF0gUkRNQS9zaXc6
IFtyZS1daW50cm9kdWNlIG1vZHVsZQ0KPiBwYXJhbWV0ZXJzIGFuZCBhZGQgTVBBIFYxDQo+IA0K
PiBPbiA3LzMvMjUgMToyNiBQTSwgU3RlZmFuIE1ldHptYWNoZXIgd3JvdGU6DQo+ID4gV2hpbGUg
d29ya2luZyBvbiBzbWJkaXJlY3QgY2xlYW51cCBJJ20gdXNpbmcgc2l3LmtvIGZvcg0KPiA+IHRl
c3RpbmcgYWdhaW5zdCBXaW5kb3dzIHVzaW5nIENoZWxzaW8gVDQwNC1CVCAob25seSBzdXBwb3J0
aW5nIE1QQSBWMSkNCj4gPiBhbmQgVDUyMC1CVCAoc3VwcG9ydGluZyBNUEEgVjIpIGNhcmRzLg0K
PiA+DQo+ID4gVXAgdG8gbm93IEkgdXNlZCBvbGQgcGF0Y2hlcyB0byBhZGQgTVBBIFYxIHN1cHBv
cnQNCj4gPiB0byBzaXcua28gYW5kIGNvbXBpbGVkIGFnYWluc3QgdGhlIHJ1bm5pbmcga2VybmVs
DQo+ID4gZWFjaCB0aW1lLiBJIGRvbid0IHdhbnQgdG8gZG8gdGhhdCBmb3JldmVyLCBzbw0KPiA+
IEkgcmUtaW50cm9kdWNlZCBtb2R1bGUgcGFyYW1ldGVycyBpbiBvcmRlciB0bw0KPiA+IGF2b2lk
IHBhdGNoaW5nIGFuZCBjb21waWxpbmcuDQo+ID4NCg0KVXNpbmcgc2l3IGZvciB0ZXN0aW5nIHVw
cGVyIGxheWVyIFJETUENCnByb3RvY29scy9hcHBsaWNhdGlvbnMgYW5kIGludm9sdmluZyAncmVh
bCcgUkRNQQ0KaGFyZHdhcmUgYXQgcGVlciBzaWRlIGlzIG9uZSBvZiB0aGUgbWFqb3IgcHVycG9z
ZXMNCnNpdyB3YXMgb3JpZ2luYWxseSBkb25lIGZvci4gU28gSSBhcHByZWNpYXRlIGl0DQppcyBi
ZWluZyB1c2VkIHRoYXQgd2F5IGFuZCBjYW4gZm9sbG93IHRoZSBhcmd1bWVudHMuDQoNCkhvd2V2
ZXIsIHdlIHNoYWxsIHRha2UgY2FyZSBub3QgdG8gaW5jb3Jwb3JhdGUgdGhlDQpzaW1wbGlmaWNh
dGlvbiBvZiBhIHNpbmdsZSB1cHBlciBsYXllciB0ZXN0IGNhc2UNCmxpa2Ugc21iZGlyZWN0IGlu
dG8gYSBrZXJuZWwgZHJpdmVyLiBFc3BlY2lhbGx5LCBJDQphbSByZWFsbHkgbm90IGNvbnZpbmNl
ZCBzbWJkaXJlY3QgcGFja2V0IGhlYWRlcg0Kc3ludGF4IHRvIGFwcGVhciB3aXRoaW4gc2l3LiBU
aGlzIGlzIGFuIHVwcGVyIGxheWVyDQpwcm90b2NvbCBhbmQgaXRzIHNlbWFudGljcyBhcmUgdm9p
ZCBmb3IgaVdhcnAuDQoNCkkgYWdyZWUgd2l0aCBDaHVjayB0aGF0IGV4cG9ydGluZyBtb2R1bGUg
cGFyYW1ldGVycw0KaXMgYW4gb3V0ZGF0ZWQgc29sdXRpb24uIFRoZSBwcm9wb3NlZCBhbHRlcm5h
dGl2ZSAtDQp0aGUgYWRkaXRpb24gb2YgY29udHJvbCBtZWNoYW5pY3MgdG8gdGhlICdyZG1hIHRv
b2wnDQpzb3VuZHMgcHJvbWlzaW5nIHRvIG1lLiBXZSBtaWdodCBpbnZlbnQgd2lyZSBwcm90b2Nv
bA0Kc3BlY2lmaWMgb3B0aW9ucyBmb3IgUm9DRSwgaVdhcnAsIC4uLiBkZXZpY2VzLg0KTG9va2lu
ZyBjbG9zZXIsIGhvd2V2ZXIsIGZvciBzaXcgKGFuZCBJIHRoaW5rIGZvciByeGUgYXMNCndlbGwp
LCBvcHRpb25zIGNvdWxkIGJlIGV2ZW4gc2V0IHBlciBlbmRwb2ludC4gVGhpcw0Kd291bGQgZnVy
dGhlciBpbXByb3ZlIHRoZSBiZW5lZml0cyBvZiB1c2luZyB0aG9zZSBzb2Z0d2FyZQ0KUkRNQSBk
cml2ZXJzIGZvciB0ZXN0aW5nLg0KSSBhbSBub3Qgc3VyZSBpZiBpdCBpcyBhIGdvb2QgaWRlYSB0
byBhZGQgUVBzIGFzDQpjb25maWd1cmFibGUgcmVzb3VyY2VzIHRvIHRoZSByZG1hIHRvb2wsIG9y
IGlmIHdlIG1pZ2h0DQpjb25zaWRlciB1c2luZyBzdHJ1Y3QgaWJfcXBfYXR0cnt9LCB3aGljaCBo
YXMNCnRvbnMgb2YgcGFyYW1ldGVycyB1c2VsZXNzIGZvciBpV2FycCwgb3IgZXh0ZW5kaW5nIHJk
bWFfY20NCihyZG1hX3NldF9vcHRpb24oKSksIG9yIGlmIHdlIGJldHRlciBmb3JnZXQgYWJvdXQN
CnBlci1jb25uZWN0aW9uIGNvbmZpZ3VyYXRpb24uDQoNCldoYXQgZG8gb3RoZXJzIHRoaW5rPw0K
IA0KDQpGdXJ0aGVyIGNvbW1lbnQgYWZ0ZXIgcXVpY2tseSBsb29raW5nIHRocm91Z2ggdGhlIHBh
dGNoOg0KUGxlYXNlIG5vIHVwcGVyIGNhc2UgY2hhcmFjdGVycyBpbiB2YXJpYWJsZSBvciBmdW5j
dGlvbg0KbmFtZXMgKHNpd19jZXBfbXBhX3ZYX2N0cmxfbGVuIG9yIHZYX2N0cmwsIGV0Yy4pDQpX
ZSBoYXZlIHJlc2VydmVkIGNhcGl0YWwgbGV0dGVycyBmb3IgbWFjcm9zIGFuZCBjb25zdGFudHM7
DQp3ZSBsaXZlIGEgc3BhcnRhbiBsaWZlLiDwn5iKDQoNCg0KTWFueSB0aGFua3MsDQpCZXJuYXJk
Lg0KDQoNCj4gPiBGb3IgbXkgdGVzdGluZyBJJ20gdXNpbmcgc29tZXRoaW5nIGxpa2UgdGhpczoN
Cj4gPg0KPiA+ICAgZWNobyAxID4gL3N5cy9tb2R1bGUvc2l3L3BhcmFtZXRlcnMvbXBhX2NyY19y
ZXF1aXJlZA0KPiA+ICAgZWNobyAxID4gL3N5cy9tb2R1bGUvc2l3L3BhcmFtZXRlcnMvbXBhX2Ny
Y19zdHJpY3QNCj4gPiAgIGVjaG8gMCA+IC9zeXMvbW9kdWxlL3Npdy9wYXJhbWV0ZXJzL21wYV9y
ZG1hX3dyaXRlX3J0cg0KPiA+ICAgZWNobyAxID4gL3N5cy9tb2R1bGUvc2l3L3BhcmFtZXRlcnMv
bXBhX3BlZXJfdG9fcGVlcg0KPiA+DQo+ID4gICBlY2hvIDEgPiAvc3lzL21vZHVsZS9zaXcvcGFy
YW1ldGVycy9tcGFfdmVyc2lvbg0KPiA+ICAgcmRtYSBsaW5rIGFkZCBzaXdfdjFfZXRoMCB0eXBl
IHNpdyBuZXRkZXYgZXRoMA0KPiA+DQo+ID4gICBlY2hvIDIgPiAvc3lzL21vZHVsZS9zaXcvcGFy
YW1ldGVycy9tcGFfdmVyc2lvbg0KPiA+ICAgcmRtYSBsaW5rIGFkZCBzaXdfdjJfZXRoMSB0eXBl
IHNpdyBuZXRkZXYgZXRoMQ0KPiA+DQo+ID4gVGhlIGdsb2JhbCBwYXJhbWV0ZXJzIGFyZSBjb3Bp
ZWQgYXQgJ3JkbWEgbGluayBhZGQnIHRpbWUNCj4gPiBhbmQgd2lsbCBzdGF5IGFzIGlzIGZvciB0
aGUgbGlmZXRpbWUgb2YgdGhlIHNwZWNpZmljIGRldmljZS4NCj4gPg0KPiA+IFNvIEkgY2FuIHRl
c3RpbmcgYWdhaW5zdCB0aGUgVDUyMC1CVCBjYXJkIHVzaW5nIHNpd192Ml9ldGgxDQo+ID4gYW5k
IGFnYWluc3QgdGhlIFQ0MDQtQlQgY2FyZCB1c2luZyBzaXdfdjFfZXRoMC4NCj4gPg0KPiA+IEl0
IHdvdWxkIGJlIGdyZWF0IGlmIHRoaXMgY2FuIGdvIHVwc3RyZWFtLg0KPiA+DQo+ID4gU3RlZmFu
IE1ldHptYWNoZXIgKDgpOg0KPiA+ICAgUkRNQS9zaXc6IG1ha2UgbXBhX3ZlcnNpb24gPSBNUEFf
UkVWSVNJT05fMiBjb25zdA0KPiA+ICAgUkRNQS9zaXc6IHJlbW92ZSB1bnVzZWQgbG9vcGJhY2tf
ZW5hYmxlZCA9IHRydWUNCj4gPiAgIFJETUEvc2l3OiBhZGQgYW5kIHJlbWVtYmVyIHNpd19kZXZp
Y2Vfb3B0aW9ucyBwZXIgZGV2aWNlLg0KPiA+ICAgUkRNQS9zaXc6IG1ha2UgdXNlIG9mIHNkZXYt
Pm9wdGlvbnMuKiBhbmQgYXZvaWQgZ2xvYmFscw0KPiA+ICAgUkRNQS9zaXc6IGNvbWJpbmUgZ2xv
YmFsIG9wdGlvbnMgaW50byBzaXdfZGVmYXVsdF9vcHRpb25zDQo+ID4gICBSRE1BL3NpdzogbW92
ZSBydHJfdHlwZSB0byBzaXdfZGV2aWNlX29wdGlvbnMNCj4gPiAgIFJETUEvc2l3OiBbcmUtXWlu
dHJvZHVjZSBtb2R1bGUgcGFyYW1ldGVycyB0byBhbHRlciB0aGUgYmVoYXZpb3IgYXQNCj4gPiAg
ICAgcnVudGltZQ0KPiA+ICAgUkRNQS9zaXc6IGFkZCBzdXBwb3J0IGZvciBNUEEgVjEgYW5kIElS
RC9PUkQgbmVnb3RpYXRpb24gYmFzZWQgb24NCj4gPiAgICAgW01TLVNNQkRdDQo+ID4NCj4gPiAg
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9pd2FycC5oICAgICB8ICAgOCArDQo+ID4gIGRyaXZl
cnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3LmggICAgICAgfCAgMjEgKy0NCj4gPiAgZHJpdmVycy9p
bmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYyAgICB8IDI2OCArKysrKysrKysrKysrKysrKysrKyst
LS0tLQ0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5oICAgIHwgICAyICsN
Cj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWFpbi5jICB8IDE3MyArKysrKysr
KysrKysrKy0tLQ0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jIHwg
ICAzICstDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMgfCAgIDIg
Ky0NCj4gPiAgNyBmaWxlcyBjaGFuZ2VkLCAzOTUgaW5zZXJ0aW9ucygrKSwgODIgZGVsZXRpb25z
KC0pDQo+ID4NCj4gDQo+IFdpdGhvdXQgYWRkcmVzc2luZyB0aGUgcXVlc3Rpb24gb2Ygd2hldGhl
ciBzaXcgc2hvdWxkIGltcGxlbWVudCBNUEF2MSwgSQ0KPiB3b3VsZCBsaWtlIHRvIHJlcXVlc3Qg
YSB1c2VyIGludGVyZmFjZSB0aGF0IGlzIG1vcmUgZnJpZW5kbHkgdG8NCj4gY29udGFpbmVycyBh
bmQgdG8gYXV0b21hdGlvbiAoQ0kpLiBJIGtub3cgdGhlcmUgaXMgcGxlbnR5IG9mIHByZWNlZGVu
dA0KPiBmb3IgInB1bGwgaW4gdGhlIGN1cnJlbnQgc2V0dGluZyBvZiBzb21lIHJhbmRvbSBnbG9i
YWwgbW9kdWxlDQo+IHBhcmFtZXRlciIsIGJ1dCBJIGRvbid0IHRoaW5rIHRoYXQgaXMgdXAgdG8g
dG9kYXkncyBtb3N0IGNvbW1vbg0KPiBkZXBsb3ltZW50IHNjZW5hcmlvcy4NCj4gDQo+IFN1cmVs
eSByeGUgd2lsbCBhbHNvIG5lZWQgdG8gaGF2ZSBhIHNpbWlsYXIgc3dpdGNoIGJldHdlZW4gUm9D
RXYxIGFuZA0KPiBSb0NFdjI/IENvdWxkIHNvbWV0aGluZyBiZSBhZGRlZCBpbiB0aGUgInJkbWEi
IHRvb2wgdG8gbWFrZSB0aGlzIGEgcGVyLQ0KPiBkZXZpY2UgcHJvdG9jb2wgdmVyc2lvbiBzZXR0
aW5nPw0KPiANCj4gDQo+IC0tDQo+IENodWNrIExldmVyDQo=

