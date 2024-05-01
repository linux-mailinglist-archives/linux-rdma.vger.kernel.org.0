Return-Path: <linux-rdma+bounces-2200-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FECA8B8B99
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2024 16:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C8B1F234EE
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2024 14:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE150433D4;
	Wed,  1 May 2024 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NpGwr2wI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2135.outbound.protection.outlook.com [40.107.6.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F7F12DDBD;
	Wed,  1 May 2024 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572079; cv=fail; b=FGzDk5ZLmW46uon9YVoMkD130u13117bWuufWRO4KSf13XgKhEaGshgu2vtkIkSrcqZNhDXiHG15LsVFPI9CBuOq+fRzJ28YgiMzybhEfISZVKAm8wmXo2CAB7NjhJ18C8KKLYtoafK3/yPQaAWIc9LhB8VaZ6WKjUiS42oJILU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572079; c=relaxed/simple;
	bh=N70qIaa+dTwlITvfdNeokkxBtSCkraTQYlWIbbr0dUk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pnsE/wkApD33FqFsCE48RMpmNRDwI/BpMmbHTK8tBf5zuWV+V4IntarPz9FW1SxHb7qCnXGjcfJN6n/Pz/QMz/Eyi0bbcISS01YgpMvVT5YmEN1G9KxBssdPsddrLzfMcdh0zUzuqOxhf7BSdlLFyNACBEHbYDji71ev5CPc6SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NpGwr2wI; arc=fail smtp.client-ip=40.107.6.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5bSlooCcV84VzZFSdFp1EQv3q8QfZQJgNR3N0FVUilri2dW0fENp6bzWJ5MXKAr0LaJrdnDHZfiQVUV9MSIPTLeMb7TdirceGA9/WXunV7lv7AozGOaiVZzThp4lHEAnoS+5ft5LEc+yfIvDcHnVwQf1+wA+NQLffMDgBaiojZ9zrsFMsn2n15LhXdLJtMAzm+tKgW7RgG94ub9t4hYe0aXfJtQy/VimtifQV4VF3rpNHUg3Whs/eStKTIkI6EmLvdjvTyMoxk3II04ptVz81tefsBveqEa3Po1SqJna5soWPd24DFm/Pi7NYtD6TSz1qJT225+S2boEU0rMpbq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N70qIaa+dTwlITvfdNeokkxBtSCkraTQYlWIbbr0dUk=;
 b=W0c515mGuhkraYKt33MXv1//08Nu0B6V+keNvsBu0/bbHb2H5Ee93tGB7a6yWw5Lpi5Q6BrwAkGJX7X2vakdjNGMmJB2jFFcZ0mw19sDKt+qoD7O+6qOlBJpfXj29Zw3w/qy4SZ6zjDMHmwY4s/sHesVXud5+vAeG6gcUFPeOd5YNg5Jkj67NNqZhrf7GIt5wEfpVMA3euUXB+PwOh9kDsXsN10vO37VlSF00p91NJ9UMUEe6Uw2VbXSNqcBQUpaFKMXJtVYzPIdWlYEAiG/hnKds5jV4R0tce9QUWS0+fSUnXyCn+r/dGZs5JwhwyyMrcZpvol08epqrikL7tylAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N70qIaa+dTwlITvfdNeokkxBtSCkraTQYlWIbbr0dUk=;
 b=NpGwr2wIqnxvsy8X3Zm9EGPBspIaXltMaErJmioZl4A5N2E7jvOZCQwGZTY67jRyMEEg0muD7vn4rteb3jZ8OPl/SFBCxJwZljZgBCIopQVpmCjjgf39BVt9GonslZlQAWEyucaj8W6dEFfNNH3fv4XgpQDI2H+8yXJ41U/zork=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by DBAPR83MB0423.EURPRD83.prod.outlook.com (2603:10a6:10:197::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.23; Wed, 1 May
 2024 14:01:14 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::ccdf:58ce:ac06:6660]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::ccdf:58ce:ac06:6660%5]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 14:01:14 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 5/5] RDMA/mana_ib: implement uapi for
 creation of rnic cq
Thread-Topic: [PATCH rdma-next v2 5/5] RDMA/mana_ib: implement uapi for
 creation of rnic cq
Thread-Index: AQHal9t0Kz8i+FFT2UeywLo/R6moMLF/kL8AgALe5LA=
Date: Wed, 1 May 2024 14:01:14 +0000
Message-ID:
 <PAXPR83MB05575B086E1580AFC3693267B4192@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1714137160-5222-1-git-send-email-kotaranov@linux.microsoft.com>
 <1714137160-5222-6-git-send-email-kotaranov@linux.microsoft.com>
 <SJ1PR21MB3457722A994F429FDE0C46FACE1B2@SJ1PR21MB3457.namprd21.prod.outlook.com>
In-Reply-To:
 <SJ1PR21MB3457722A994F429FDE0C46FACE1B2@SJ1PR21MB3457.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fad8713b-ecb4-44a8-9989-0b4ccf5bc06f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-29T18:07:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|DBAPR83MB0423:EE_
x-ms-office365-filtering-correlation-id: 15661647-58b5-4b0d-3825-08dc69e72a37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVlVK1lUTFMvdEZ3NWJOMzJ6am56ZzA1N0NOL0ZVSGpGblQ0Q1RyNDJpMjlZ?=
 =?utf-8?B?WEZHUkR5QXJtSng4UDJYM2pNclpYMHVRTW1lRW9DVkJZR1hISFVRU3BqSmJK?=
 =?utf-8?B?cVY3OFI1LzV3UVA4QkhlUUE1S0ZrUmNpaWNiNjFCVlZDeDlCcFZWN0VGRUtu?=
 =?utf-8?B?cVBCQmFKU0N5Z3lEbkdNekh1anV6ZUhLa1NEa21LVkRZQ0hoY1c2aHozck00?=
 =?utf-8?B?ZEpDREZZT3I0bWlueGdXUTNSdHAxSDBNODB6Q3V2cW5UZ3FpeVJuYmFFWjcr?=
 =?utf-8?B?NHUybFVpV0RYYXMwT3d3dFE1ZFJ6QlYvWkhRcWxSVm9EV29CRUhxbG5vaFpG?=
 =?utf-8?B?WTNHZ3llYmhNbUxEa1Nyckk0R25xWldvSjFPOGtPWEFXQXRkOFM0blY2K3Fa?=
 =?utf-8?B?NDlIeTFkK0pibzdHRUl4WnA0bncxRWlhZ1I2NmVSUWFRVFBBL1lHZnpsZ0NC?=
 =?utf-8?B?dytRU2tsVmFjQVN3bmVURE9vdGo5Q3BIMHdSaHI5WlFxUWdqOTVVOTA2L0Z0?=
 =?utf-8?B?Z0Y1Yk52V3FoTVdmSWRVTnE4REVaTjYza3hDeWM3SEtWb3diYnZuT1ZYMFkv?=
 =?utf-8?B?NVY0UmxSaTBwcWlweXFEclNpV1V0RWx6ZW42WHJScTN5WEltcU1YVEtaTW9q?=
 =?utf-8?B?VWt4VzB5NzQ1WVo5NStDdytKVlNJMlBQSWVmOW9qT2NLaUhMVGtHa2JtTExx?=
 =?utf-8?B?NUxzcmtvUHlINkVHVTFUV0h5bEZaV1BVa2pwZ01xVHJ2TDI5L3JxeTNwYXFE?=
 =?utf-8?B?TnhjcnlZVzl6MDA2OEQyNFhGYm9lMlhmTWhRbVFkMFBLVU5yL2hSeWllb3kz?=
 =?utf-8?B?UHlFVEdEMFM3YnJzREdBRUVpRFFEN0FWRVJxQUNjV0JHN1VHejhkQVRzNVJx?=
 =?utf-8?B?Q3lpNWV4Q1MvK1d0dTRPOSttRzlhdUJ5V25SMHYwRUFwUkRNYlpqRXBreXlD?=
 =?utf-8?B?c2RLL3VCVklMclRzRFhWem43Nk5JckpvaTVEZ01DS21NMlhtSWlZTldkWFNr?=
 =?utf-8?B?cFpWTmFtcjVJK0xjdVlTbVZkSS9ac2VmbXV5QWtJeXlQdnVsci9sTmp5MWp6?=
 =?utf-8?B?T01RMEhPdlJPQTFhMHl4MExYYVpPWm9xc0VyNUZieDJpNnJlNXpJRlVKRU9P?=
 =?utf-8?B?VngzU0ZBNXBIckkrbDNkcmcxbmJKOU1NTWVoTTh4YnRQVUJPcVZIekliNXZi?=
 =?utf-8?B?T3RqNCtFTVRQbjFYWktJTXpybThIdDBIUUlvV0lJbGJnZTMxM3cwWWV5Y3du?=
 =?utf-8?B?L010aGljUlpOd2xESzNWcSt1WFRCaGVvSkhFa1lNZ2gwUDFtaytiYTBKamlH?=
 =?utf-8?B?WmVVY3VhaWE3aWUwT0F4VmFQcXhucWhxbTd3Q1d6SzNoT2RMWmhpOGNXdjI5?=
 =?utf-8?B?QmxiWHFEUVBTSXZyM0lHdDFUZzdtQm91dDg2Ym9qSWdBVGlYR3FlZmJNRkZu?=
 =?utf-8?B?MkVmVEJQRGorRkhiUzRpb0Yxd3FBeVFUeUxNaW5IK1hVV0R0bEZMWklvaklo?=
 =?utf-8?B?Z3puczlGNmRaeUlaRHZaRURjcHZ3QXMvZGNWcHhoaUxqTE5ZaGtpTDhyVEZT?=
 =?utf-8?B?NjNudVBqdmlwdFJIOU9Da2dHSGc1T21LdDFQMDZnczlmZitSUEtHcWFiK2Vt?=
 =?utf-8?B?d0JZNlNtM3dXK3d3c0ZqbHJzcUFUTmxqRnNuY0MvQiswRkRiMlpiVHY4NHhR?=
 =?utf-8?B?QWJFOEswZzNGSDlEVWtRelNuM0hRd29lczV4TzVNSmx6S3g1aG00NmVRVU0w?=
 =?utf-8?B?NTI0U3NneW9qcWt6Ni9TNkIxVjVhYUhadnMyVUlXUy93bDFnNldVMGdEMWc3?=
 =?utf-8?B?Y25yR2cycGwyZnRrVlk0dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjdQM2pic1ZDbTNLa0s0OHNyK01SZVV4RVh2Yys3dmdaUm83S3NJbFBWM1dp?=
 =?utf-8?B?bVdjN0NUaHU0RHJFV3FrT3FzMHFDUDhzQ3hVNC9zcHMzTldoRlF1eG5KOXFh?=
 =?utf-8?B?MGJlcEFBQjJ4cmFtcytZVTd4Q3YvTGRQa2ZqYUNZbVJJMEg2QXNtYlhveEhX?=
 =?utf-8?B?Y2pWMlN4VkJwamtZMlowd3R3cjhUYU1NZURXY3B0SmtiZlFudmRuSUI1b1d3?=
 =?utf-8?B?YkdqZGpFOTYwTUNDOXArLzBDbEpPVE96Z0RRSmlRb09MQ3B6MS9nb2dHdGxk?=
 =?utf-8?B?Ykh3TWI0bXdvTEp2ZEhlMmVCRk44bmVFV0JzaVQvS0g4RG1FOXVnTzNSa1RW?=
 =?utf-8?B?ZGxDbzBGSzY0UVlLZ0ZodE1Nb1hHRlp5MVJPNDhpL2JseEZIdTNad01pTHJN?=
 =?utf-8?B?RDFWMnhMQmVqcDBSUUtFUGhiQUZtMnRiekhqenQ4a1ovMkx5V2p5TDFsSGhL?=
 =?utf-8?B?aVZtV2VKS2xESUNIOHFhdnVwNXk0cGZGYUtnblo1OXlOV09NMkNqZ21FZjBK?=
 =?utf-8?B?Mk1ZOGhPNUhWZjhGRFFiZm04MjE5N0RlR0dBbnBLeTJEQzBUUWx4dFBWTlFn?=
 =?utf-8?B?NFUwMWpuWEN1OTJBdDY4L2oxZFd5YndyUU8vaGlUVlJVZ2xlQ1NXaUR0d3lH?=
 =?utf-8?B?ZmVqUWJHalZja291c0sxVkRNVDcyYUZsUTZLT2M4UVZmcm9HV1V5QWNhMVJ4?=
 =?utf-8?B?QTZWekZtNDBIM2VGNWxzVFF3cW1OWUtnclRSNWpOa3ZDekJlRktlVWtySDZp?=
 =?utf-8?B?ZFU2WWRKKzdieUZoRE1YN014SXduSmpnRk1qbnR0cW5xUk9RMFVuRHU0QWFh?=
 =?utf-8?B?T3pmMXkxaDlZaGdLdWpwbHZWL2kvK2xoM1hpYUh5dkc1aHU4VHB3RTM2ZEhV?=
 =?utf-8?B?WWhQenJURWxlZWY0RVQ0WDBXV243aVNCWFJuSTJVM01temF5bkpzUzlIYk94?=
 =?utf-8?B?YTFGc0c3SVBMUzRLaW9oR1dvTUdjNUxOdCthMVpHMHFZMGxhcUlDMU5qRWVC?=
 =?utf-8?B?UU92cDVxY0VkU2gyV0p6RVo3TkpLbGNUR2MwWjg4WHdzOHdRTC9yUFhzSGht?=
 =?utf-8?B?ejNIK0NQWnhSQk15U1pIRlV2Wkw4WEdKelZGdVFmNDFRVVdnMGpCbE1YQjNy?=
 =?utf-8?B?YllIOUZOeU9hSlYySkRTU1kyTzlGdEZTeGlta05aRFRIcy9RUjdCNWdzQWFM?=
 =?utf-8?B?VjZtNmZQZFF3cXpjRjRLTkNFcG5qdmNyMkFlWXhQOUlmTndDdGF3T250RzU0?=
 =?utf-8?B?TGl0Z05oVjBhYjhTcUFFSldsQmhadm0yZysxVFgrdGpKazcyc3hBUFRDMDJ0?=
 =?utf-8?B?UC9Xb0w2V2lDUVB0MEZOd0I0MHVuMHZvRlY3cVJST1UyVk5hWWhSWEpPOC9u?=
 =?utf-8?B?cXlqdVZGQ0xWcDZseW9nZm5UdGUxS0pVTXg5dmszMk5SYjhjK2ZoelV0VlI0?=
 =?utf-8?B?bjFScUozWE9EbEpVUFRTNnpGVDBtdmhGQU5RajQrczZuUko1T2VnQjN6dEJu?=
 =?utf-8?B?eVFPeGlGeG5saFFIdVg3Rm41MWRVLzk0bmVvNWdTSXZUQ2MxU3A5YUFmOTR4?=
 =?utf-8?B?ZnBsVjR6VDRzbzcrSjhMYmZ2R0JJak1vQ0xsU1FxVkFJZy9QQjcyUjM3ZnpC?=
 =?utf-8?B?eitvY3BQYjVha01JQzg1Tjl4WmVZY1V2RkttNkRBQ09WMFBIN3lBRCtmbHFV?=
 =?utf-8?B?SjZjUUhJNUkyUUROYzY2R09IVkVXUVQ0OWtWTnd6TjZmM0hpTG5TSHNadk4v?=
 =?utf-8?B?VzFMUDhhbU1ZSmpXR0huZEVRYWRBNVFFNWJxUUFDQi9rT0xYaHk4a3kxYzkv?=
 =?utf-8?B?T1g3TjU3ekUwWlhhT2FqcHJZMENSRHdRTnVGamJPNmxnWFVEMWVrVS9TYyti?=
 =?utf-8?B?TUdNbUZ3aEpHV285TmNodTVzaWV0M0dSSDBkRzd6Szd3NWZFeVdUeFZMUCt2?=
 =?utf-8?B?NmR6S0lxU3ZvcFhFVzZ0ZW9kenNIdy90LzgrWjAyYTlHUWJvQm5OaHBiRDV3?=
 =?utf-8?B?aHowKzdOQ3ArcndoalhKdmplamJ2eUJXTDBLbFhVaFdlcGl2T2FoVmJqVmFG?=
 =?utf-8?Q?vPhYy+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 15661647-58b5-4b0d-3825-08dc69e72a37
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 14:01:14.5802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iH+/ho/wMB7cEnBF3Pi11nFyCQOKsM1NI0jkcQJfqX6kImJFBonom68FhCFaxnEGNkZontu+JjxUqQ+xJfjDMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR83MB0423

PiANCj4gRm9yIHRoaXMgcmV2aWV3LCBpdCB3aWxsIGJlIGhlbHBmdWwgaWYgeW91IGNhbiBhbHNv
IHBvc3QgYSBsaW5rIHRvIHRoZSByZG1hLWNvcmUNCj4gY2hhbmdlcy4NCj4gDQo+IExvbmcNCg0K
SGVyZSBpcyB0aGUgUFIgdG8gcmRtYS1jb3JlIHdpdGggdGhlIGNoYW5nZXM6IGh0dHBzOi8vZ2l0
aHViLmNvbS9saW51eC1yZG1hL3JkbWEtY29yZS9wdWxsLzE0NTUNClRoZSBjb2RlIHdhcyB0ZXN0
ZWQgaW4gNCB2YXJpYXRpb25zIChvbGQgKyBuZXcga2VybmVscyBhZ2FpbnN0IG9sZCArIG5ldyBy
ZG1hLWNvcmVzKSB0byBjb25maXJtIGNvbXBhdGliaWxpdHkuDQoNCktvbnN0YW50aW4NCg==

