Return-Path: <linux-rdma+bounces-13782-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2A3BBD63B
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Oct 2025 10:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA5144E96C2
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Oct 2025 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A95C1E5215;
	Mon,  6 Oct 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JRhpZnLF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023090.outbound.protection.outlook.com [52.101.83.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6288020311
	for <linux-rdma@vger.kernel.org>; Mon,  6 Oct 2025 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759740710; cv=fail; b=fH0IDVzewJLDF4Kp+8+rhgm50zJ2DtO7QVrbibc+W2vJjScSWRYyUKUH6oj/Pmpq3gDSyBXQBy+tQGIlEU8faDxH8yPfsCJqqjLDmxf96S6FoS2CXJVTR63LVPrmXpY40vyRULpnNrPm5dEhGuNCpRdd7LYQAo4yKYjktHRqnq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759740710; c=relaxed/simple;
	bh=F+P1iZNf6Inp0n/HGz+fL52yyClVtSk8tvfhj//LZp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y6rgYrwmkrGEpRf/FQ8waRJIQKONzopsViEAYUZhcHaFRqKxoklCdkoRZrDyt9z9U2W8WlQlPJLtINMpI2pi57wH8gFeFyKy68pOgb4v3gOSOHChLcBDV9ui+Oyb0nJWEvCkngB8xUipmJ8VfHxFWpxHPMqGP9U/ps606GgeIWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=JRhpZnLF; arc=fail smtp.client-ip=52.101.83.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XawzsrckazPzDdB7u/PhAsBR570kESpuiJOu40TNARFj8+MhfVw/GrSz7b4bNdIzNHyp3AtZU3IaehX5+MB0nSXHYAZGtwTWohWas53yO86UaqNfPEzet0kE7kNBe3PrBv7qpBR3QdxlweeE1fmyL+e9Z/ht7O+yLcPojmZYQUWY6Qcrtb2+Yz4wF3/qAlKt8cQlxh4rKEBpSnZLXzAPeHjnq8xycxBOFsiuHbU6Fr4lKngflKMLvn1Ii5lrWaWWGcOZ05o+0BplYBrHRsZfv25LWSkqBpgXgE+xTyiXQNzqXMFfhA59g668TQTobkp0W3CTpAuyymz8eH3sODK+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+P1iZNf6Inp0n/HGz+fL52yyClVtSk8tvfhj//LZp4=;
 b=F3H25iRHRdJHPzJKqJy5oEbvCWq5nwPjub/kthcckLs7b/T+yOv5w18XLmfxfvRdIa7lNYdlTpZAz0zaW2SeNdnmWV/Xh8V8oKeiU8mQWTy4F5F2ko/9TY7JqAuOAPb5Bc5yJrAdlQBSX/OUvqbl9T2Nx//hzfqcScalWsNYpunFPkabcaPIL9yCUxksXyXvUDNgj5GByZtuxirSNRJNNFRlXYFkBH59ABfuX2BLegCtMEGZJR5kmXTmB2T/CQqMpgfw6fK73jxs1nUJCeC8WzuecmmQs0Yj2HvGSnJB4cZ0l1ZSKut6wDKPE8LdjFcmMD+2WphJETMzyMn9p30VWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+P1iZNf6Inp0n/HGz+fL52yyClVtSk8tvfhj//LZp4=;
 b=JRhpZnLF37mSEBBALWnOVdElqwthFqsEAo7jZHKLHHZkTQVTGYiIy6yU1AuptBla4FvtfTR3nUhJv6kbT6jkx+qZ2HPTbNJab+YrI1knRXEkuZDxTxr8BJbuNhmydf2bQXOpjCCVUBppSsXfU8AQQy0xchTv/g4OW6InudlC6e0=
Received: from PA1PR83MB0662.EURPRD83.prod.outlook.com (2603:10a6:102:44c::19)
 by GVXPR83MB0757.EURPRD83.prod.outlook.com (2603:10a6:150:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.13; Mon, 6 Oct
 2025 08:51:45 +0000
Received: from PA1PR83MB0662.EURPRD83.prod.outlook.com
 ([fe80::3c3d:5eeb:9d38:3fa4]) by PA1PR83MB0662.EURPRD83.prod.outlook.com
 ([fe80::3c3d:5eeb:9d38:3fa4%4]) with mapi id 15.20.9160.008; Mon, 6 Oct 2025
 08:51:45 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXTERNAL] [bug report] RDMA/mana_ib: create kernel-level CQs
Thread-Topic: [EXTERNAL] [bug report] RDMA/mana_ib: create kernel-level CQs
Thread-Index: AQHcMeo9hXEw/8pYYU+OG9CGXc8SsbS02K2g
Date: Mon, 6 Oct 2025 08:51:45 +0000
Message-ID:
 <PA1PR83MB0662B7F6FA7D858EE24A2E34B4E3A@PA1PR83MB0662.EURPRD83.prod.outlook.com>
References: <aNuexWJZvrpUsOki@stanley.mountain>
In-Reply-To: <aNuexWJZvrpUsOki@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a743f5c8-adb7-4033-a8a8-556e5669b334;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-10-06T08:50:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1PR83MB0662:EE_|GVXPR83MB0757:EE_
x-ms-office365-filtering-correlation-id: 0c650807-b6c3-4049-fcae-08de04b59439
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MURmY1JTTEpjejBVODRseEpzbEFBb2xYc1F1M21mcytJNWxiN0M5TzdPR0l6?=
 =?utf-8?B?ayt6WVcwLzgxb1JUVW9ncTZDVkl0MXp1d3R2TnhDLzVWSEZ1c2J4Z3I5R3p6?=
 =?utf-8?B?WVdsTU1sL3FOWUFtd0h4c1FBaU1nRnV4bWVFTGdrd3g3MW8yWHd3c2VjRmNM?=
 =?utf-8?B?a2FmWWtpQXJmaXlhVmNWME90dThKRzZDM1VwbFdHZk5JZng2UTl4T0UwWVhW?=
 =?utf-8?B?Y3JpTTVjOEUxS3RDY3pOekFzNnQ2ckkzOEtkR0hIa2M5cXhLdk1tZndpdVNi?=
 =?utf-8?B?c1BvYmhVNGN1UnJPL3FnM1l5VWhMNDFhZVd1STRzZVFVZy9lanQ2bkllUk42?=
 =?utf-8?B?aVQ0NkpKZWJDTWllQXY2S2xmQlR4YXBhbURFSS82QlNPNXVSRms3ZEFsU0Q2?=
 =?utf-8?B?SWZERVVwZlIyN2pCMzVXa1Q3cFp1cTd5MHZ0QjNkMVNNMm5RZk5xQUh0dlA4?=
 =?utf-8?B?RkVDY0M1OTg4UW1BWi9vQWRCNHlibkNJWHVWbnltNXF0Ymk4dFlpYTdUSmNr?=
 =?utf-8?B?bWF1RUw0U29GY21pKytjcngwRGFidnJXY3BRelF6OG9USy9qclFLWG8wMzVG?=
 =?utf-8?B?citQL1pCS0cwbXA4UTRNY1hlME5Yd2VJQUlVRHBXL0NFaGlGQkFjc3JJeEk4?=
 =?utf-8?B?VmxHb3ZmYnZkTGVkaytFNVhlRldvZmlPNXF3YU8yQmRVSm00b1daZGVFUWZz?=
 =?utf-8?B?S2dvN043MmFMSUg3NXB2OGdxNEJKSlNZaTR4TFUwa0U1Rm1lY2MyZU81ejl4?=
 =?utf-8?B?czJyalBvbFJNMTdyeVVSZXAwUysveUMveDc1dURlWkkrYkw3Tmd6ckkycld3?=
 =?utf-8?B?L2piQnhMWnNwa1pSZHpETWlEYm85dlFrVFZ4MnZMTytPUzdMRGJnSXlDWlhh?=
 =?utf-8?B?K3pPdTZPOVkyTlpIdXBCUzlvV1hpb1ljc0FLUGF0RmNBOS9nNFJNdEhlMkZ6?=
 =?utf-8?B?TGJKbXZUWjZrNk5mekJ5czErMklnWXJsNThtU2M5UWdKaUc5aGcxYVJwTStk?=
 =?utf-8?B?OS84c3M4Q0lxa1pkVTI0Tk9TMW8vNVlrR0xDSWtRNUwvaTBtV1VMcDlwV2Fa?=
 =?utf-8?B?TTlxMmFIMnhJSGZpMU8vQkRiSGZ6NTlDOU9JZzhiS1I1MkdRUzdBU3BuVTd5?=
 =?utf-8?B?bUZYWEs0SjJLaFlueUI2clpONVVUZ0wzcmczQTEzcHdKK2NXdm5BcldLMzZD?=
 =?utf-8?B?Q09XeHJ1NlhVNTNMRXRDRGx2cUxadnlLbndMRFExVUljQXArZFh6cVRFRk90?=
 =?utf-8?B?UERFMkJreUZjY2JDVEN3d1haNzc2Q1Z3RUlwTERRMlhNUFF3THRCc3J2VDhZ?=
 =?utf-8?B?Mld6eWlJT3NGSzdkdG5QeUVSTXE2L0R3N3NuYktpam5KRk80aUhXRWljUzA4?=
 =?utf-8?B?ZHFNdk9LbWlvdEdWN1NSNXozTlZ1VTJwMjdMWUR3dEh4UUdHc2o5TVQwZTBr?=
 =?utf-8?B?YzZ2ZHNPRlNldm1ucmMrODArbXpXUmlUSmwzbnBPN1ZiU3p3c2IwaEtKTktO?=
 =?utf-8?B?UGRJN3FYTWtRNEgrRXBmZ1hoeVNkVUJZZStQU3VWR013ZjF5eGxEa040c1Rs?=
 =?utf-8?B?b3BzL1JVbTBHc0FsZWdVTWFmQU9Gd3poYnlqSDU4blMzbU5vTmxscEx6dmtP?=
 =?utf-8?B?cGQ5U2JNaTEvQjJtL2t1OE5WMlJCZGRwYmY1dWxiTWR3Mm1nNFFkNVM2ZG1W?=
 =?utf-8?B?WjBWTXRKUnRzNWVyNEZSVFVIZ0VQQXVJSThWc2ZtMmV2SEJoWk1tdmtDYURL?=
 =?utf-8?B?blhhYjg0eS9DTndTV3lQSk13RWp0Y01LdU43VjZETVVqeTIwRHNFb0daNDVy?=
 =?utf-8?B?bkJTVnZRYUovUmpGMWJvNWdOV2dNL3dGRytrY0lLaFozNHp2ZmxSZEU0OVJo?=
 =?utf-8?B?VFQ1VmpNWnM3Z1R4aWQyZUNZeFVPOVdwRzU2Q0dwZkk4S1QwaFU1TmwyY0J5?=
 =?utf-8?B?Uk15VDJyWmc3S2U3SnJVQ3czWnc5c3dSZWZZemJmWTJVTlg2UEU1ZUVTS3lR?=
 =?utf-8?B?TlJtS1o4Rm9sOXV6Qm53SjkrVGZSVklPQTU2czhLMUdlSXlPMS9MY3VSZ3p1?=
 =?utf-8?Q?nBh67d?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR83MB0662.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1BUZDBGR2RhM2lGOVdDWDZyWGIxU1hpT0JwQjdMQmlIQmttQitjSFJmbkZ5?=
 =?utf-8?B?aGJxZWVjN0llSmt0R1BLcGpudEoxdExDdXNXWFdtRUFUV3ZESEFFK2hlVmRu?=
 =?utf-8?B?MU5USWZGV29Qdlh6VVh3TWdndmp6L1pNMEovTVRtTU9VY0pqS0pUZW1vUlBL?=
 =?utf-8?B?SUh6WFNhS1NJcFhlWXVEZllhVk4wbDUyWW1GRzNjcERaWUJpZVp1ZzNldS9a?=
 =?utf-8?B?MUNKV0ZaM01veVdrYzlCUktxcnFiU2lVZURuK0xNQnh1U2x1RVhPYk9hTTI2?=
 =?utf-8?B?Uks0RGIrRmRxUTgyckl4WXdxZk9nWklKQzZlZHd1b3ZpN25nVTJuQ21kcUhv?=
 =?utf-8?B?YnpSUC9kVnVMYmtIbzBWVGR3QkNEWFlxM1JzcnVSRGxicmt1UnFUYkVjM3Y0?=
 =?utf-8?B?UjhxbjY2cnhWcjVEWkNhazVGNHE5M0c4cnoyZEVDQ1VqaTdPVTc5eE5zWXls?=
 =?utf-8?B?VWMxS05iNWVvRjF2dDdtZGxHSGpzYlQ5bzRnQTNVb3l2Mi9kUjVNQU5EMnB3?=
 =?utf-8?B?MEhwUGs0TTlSUnNKRkxtY3NadU4wejdhSFFDSVV3dXFFYzlTN2gxU3JZZytL?=
 =?utf-8?B?ZmpTVVBGUnVFajRacGZweFU2eU5WdE9FYnZvVjRGYVk0TWc1eUJqWllTVmJC?=
 =?utf-8?B?QXUyT3Jvb05VSlYzZmFiLzFnQkdadTNWNWNCV3Z6bmJmeDVZN0MwQmhnWmc3?=
 =?utf-8?B?Q1EyVFR6a2ExZHByVlRBVlpBWTB5VXgxMldYVGluTEJsWkNzSjVnejZBajhH?=
 =?utf-8?B?a0t2UFlCckFtZG1idWxLS3dnZkVqRUZDYTBXNUFZT1k2OTdQKzRXVE5VMzVY?=
 =?utf-8?B?SFZ0N20zNDhJeDkzSjVHMkd2YSs2MnlvOG1ydXBJUUFiN01oYlNLOTZJZnAv?=
 =?utf-8?B?eXJmbkREeDY2bGRCQ21HTEJKZHJBU0czVGV3bldpUFJtQzJoUGE5eUp3NEg3?=
 =?utf-8?B?U1Y3L0FDSGowQmplczVrUDhkMUlwSnpDM0h3RjM3WmkvSTAvUHowZXJnRjdX?=
 =?utf-8?B?NGc4QlIxNjZXVCtjb3ZKakx4b3h6b0dacUc0dkJoam5CU3pSeDlUMkVvUGxa?=
 =?utf-8?B?ckQrK1p2T3psRE1sUHVMQ2ZHRlhrSTh4cnJkN2UzN0Q1MXFxWnFQUGxkRlN2?=
 =?utf-8?B?dEhWeHVDVnZpaEYwOEIyMm4vajhZc0VER0RrNUZOQnZ4ZExJbExEK2ZHKzZw?=
 =?utf-8?B?ZjlQdDRVdDB6d0pyOURrOE9pc0g3WTVvbWhBSTZMdm8zQnNQN3Z1b2FnTFcw?=
 =?utf-8?B?MzN2K0JIa3VPWDBQNXpHOTQ5VTd6a3dJRkFrdlRUdVFUZ09teUNlWWdqS2dI?=
 =?utf-8?B?Q00wQlBJaG01RlhXOWYxNDU1eEt2MW5SOFVvb3R3Y2JaZk9vcEEvQjJmNTNG?=
 =?utf-8?B?NXlibnJEaEIrMnFWRUlYdlZSQ1hMY3ZkcmxBMG9GMkxnUTcrbDNoZXpKMWcv?=
 =?utf-8?B?U3pwaXM2MitaZWlzaWlCNlQ2eHhUaGV2T3RrM1RXL25YRmNhZ2JPcWJtc0V2?=
 =?utf-8?B?aEZJQ0tNOVF0THAxT29vZm0yUzRlRVhxRGdzWUhibzB6VzBLSjNBOW9tZHBu?=
 =?utf-8?B?WWlITHBHSDU0MnQvMGk0L0Z5dTVOVGpycmdKY2lDd3AxVi8rZVZXMnZlbkdi?=
 =?utf-8?B?NWF2KzRMVTY0ODlNV3pYeWNFczlHUXZkb05LeXJqTDV3ZG83MG9JbGlNUGF2?=
 =?utf-8?B?Y1BOemZSb1dBY0lLYVNWbGp4dGVmMHd5bXorS3pIMjY3T2pwaGdnTmRRY2pP?=
 =?utf-8?B?YzBSRUxLRHZTNlI5UEJKWVY3RGY0UnRWQzhMRTBESUpmQ2c2NnZIN3N0VE5i?=
 =?utf-8?B?emx2cG05b09TU1ZNTEc2Tk44MzlJQTFBYjJxZmxubGJPUVBGWFRjWHk0QmxX?=
 =?utf-8?B?aHhjcUR1eXY4bUVacE9YcHNEYUpGaktCNnZ5Yzd4M1dsVTZNYStmV0lRNlBQ?=
 =?utf-8?B?NHVjSFVlTUhzV3JSUVlUcERMNTFsMWRTMDM0d2RzQytzdEN2L0JhS3M2T2pL?=
 =?utf-8?B?ZjhzajU1amtiOWtYazlvZnh1YjlCNExXZ3Q5MzRxNDFCRC8vdEYzdHhxcVl0?=
 =?utf-8?B?MzcrbVV1ZnRDeUJNN1RJS0drbkJLajJpODM1aVkrVWZScXQyanh4T2RNSEhT?=
 =?utf-8?Q?6BScJQIL91l2J++N0Tm3dVSSq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c650807-b6c3-4049-fcae-08de04b59439
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 08:51:45.5119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HumT0uUTSSd5Ni7oFfFz2EzqkmUxQj0HpET+K495BkqEa117yVsh9+prnub84JCsSvTNSiSSLG37f66zmsMh1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0757

PiBIZWxsbyBLb25zdGFudGluIFRhcmFub3YsDQo+IA0KPiBDb21taXQgYmVjMTI3ZTQ1ZDlmICgi
UkRNQS9tYW5hX2liOiBjcmVhdGUga2VybmVsLWxldmVsIENRcyIpIGZyb20gSmFuDQo+IDIwLCAy
MDI1IChsaW51eC1uZXh0KSwgbGVhZHMgdG8gdGhlIGZvbGxvd2luZyBTbWF0Y2ggc3RhdGljIGNo
ZWNrZXIgd2FybmluZzoNCj4gDQo+IAlkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9jcS5jOjU5
IG1hbmFfaWJfY3JlYXRlX2NxKCkNCj4gCXdhcm46IHBvdGVudGlhbCB1c2VyIGNvbnRyb2xsZWQg
c2l6ZW9mIG92ZXJmbG93ICdhdHRyLT5jcWUgKiA2NCcgJzAtDQo+IHUzMm1heCh1c2VyKSAqIDY0
Jw0KDQpUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMuIEkgd2lsbCBtYWtlIGEgZml4IHRoaXMgd2Vl
ay4NCg0KLSBLb25zdGFudGluDQo=

