Return-Path: <linux-rdma+bounces-8915-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46752A6D5DB
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 09:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1707B16D37F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 08:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE38F25C6E9;
	Mon, 24 Mar 2025 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="OQQOFaav"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804F21A29A
	for <linux-rdma@vger.kernel.org>; Mon, 24 Mar 2025 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742803580; cv=fail; b=hOtAv3Qhf1Ae1IAA25B5x4PKM1SSuxW+w8zJVJajlkAA3le7SznRDgMefG+dP7s9POzzKKxftV0B0cnG4zxh5niI/r9blpH6KPQNKalg5BwruzPhOGbFhWom/cTfjqk/EhJRebFBX2rxVlnCRrPY0Fhgt174fJXSr6vPWo2nuy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742803580; c=relaxed/simple;
	bh=oft2dLGr8cPPSOWaCKaNeEZZ0c73+Qx/A21eaUTJpeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CfYR24BadIVuJ/Q7myq/7g9Alag56YRVuClmaY2almMMLdooFm6aCQZ7QtLUF1Yj/GCXgG/o1Txsr4Ev4qov5Fp3nlrrDJnY+K7ygmWFxK4oe76CLASjLVmyMsfrVV53mPrm/+LlC1A40+mr/QYtFh1IVfSOIUSHlQH+KjQZr98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=OQQOFaav; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1742803578; x=1774339578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oft2dLGr8cPPSOWaCKaNeEZZ0c73+Qx/A21eaUTJpeY=;
  b=OQQOFaavSCo5iIOMMmGpn31nMNyL4Ab85GxFQI0fSPDhYhM0hjn0eeGc
   7HAImTF/1tcVu563LM/6gDMme95YaBjMGGkmBqGm1I/eAbmKSPOUb135t
   htSzzaxc5TwSp1Rz0R2Q0iwT1c66owsLKEuWtbFkoneQl/Vg5i6pc+VZw
   WjXq1OcFywGVWMKiBY/p67slfNWYLUwD/YefUFZRrkwkQXlgy/HJTTMRL
   SD86iXUVlBzciY4bOj2sSM25k0h8YRANvd/c/C9FuZ0Zaeh9IOjmZyEkM
   +9T7hZFAZ/19+qj5FdU7dXpLx2vxOcL2zgWcwZpN1scyTh/I0hZVF8WxW
   A==;
X-CSE-ConnectionGUID: DV3Sbxz+QBCsJm30/ISdnQ==
X-CSE-MsgGUID: +H/osl8PRbWH+CTJVmBfng==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="150965321"
X-IronPort-AV: E=Sophos;i="6.14,271,1736780400"; 
   d="scan'208";a="150965321"
Received: from mail-japanwestazlp17010001.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.1])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 17:05:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLc/9pN4rINggOBY9aklKd9qSR/KVIpOAbcvjCvtQelMF7Vg5y/J2nvB4y3TKihxmJV+AzCI1QgJBXcKNTJujxP5AFqGPyAOF2nnDOcb3giGJDhGOYwOwywEYuquqL5NSYTi1CjkLsmeHcIuhLlBmKuJ4LqP1pbijhD+oxataGHxFF5hv9/85oC11kWIt8o8Y/BUrr4a67o81/l3nGUZeypAIUahTpqeUViXvcu3Cb6MBD05y0+B1OC+nh64zsnG6DMHj/Jw6m9CMS0e9VLaY1qyoRjPwxhB7bibNBl7/zG8AbmzZNVR9dTrmko8GIXUT+zKlV+jTWYc2og2fnhAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oft2dLGr8cPPSOWaCKaNeEZZ0c73+Qx/A21eaUTJpeY=;
 b=VLldSDvYSPqPlAUw5+se3kSLgaRWqkf0amYQa33IrqvxYWbsGBaf+EvSgBEzF4eE8LxqrdmAElvL2OA/6/dXRnnTH4fsUzy4Lx7aZy8QMt4xTam86VJSrx1/P4tZ/s4Kizcmuw1DQ88JXrX8KrT5awBJepJ5A8L3qpqEXY5IAhXA5t+Ur1PbEF2jpskw32qRCVi4JQScYJW7nhK99WT3s8KOQG4i/SwZUAppnhzkctlFT4OBFAQNrqnha4lDf61EhpNeJ9RL/ecjSl5QaNNNVCv2jCQk7Ye1puwGNN1C4Q03gnmki+Ak/uixTpVKeO87bOv+IwJO9ru5pTnr7c/9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB9872.jpnprd01.prod.outlook.com (2603:1096:400:22c::7)
 by TYRPR01MB12302.jpnprd01.prod.outlook.com (2603:1096:405:fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:05:03 +0000
Received: from TY3PR01MB9872.jpnprd01.prod.outlook.com
 ([fe80::eeba:ef6c:641:7a88]) by TY3PR01MB9872.jpnprd01.prod.outlook.com
 ([fe80::eeba:ef6c:641:7a88%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:05:03 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Leon Romanovsky' <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "Zhijian Li
 (Fujitsu)" <lizhijian@fujitsu.com>
Subject: RE: [PATCH for-next v2 2/2] RDMA/rxe: Enable ODP in ATOMIC WRITE
 operation
Thread-Topic: [PATCH for-next v2 2/2] RDMA/rxe: Enable ODP in ATOMIC WRITE
 operation
Thread-Index: AQHbl+saVZM8g+C8M0SMkEkpiP8Bm7N4rAsAgAEJIpCAAHUigIAHyrwg
Date: Mon, 24 Mar 2025 08:05:03 +0000
Message-ID:
 <TY3PR01MB987258AFBDF155290A891F99E5A42@TY3PR01MB9872.jpnprd01.prod.outlook.com>
References: <20250318094932.2643614-1-matsuda-daisuke@fujitsu.com>
 <20250318094932.2643614-3-matsuda-daisuke@fujitsu.com>
 <20250318101014.GA1322339@unreal>
 <OS3PR01MB98651EE8E000B0682056B381E5D92@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20250319085825.GH1322339@unreal>
In-Reply-To: <20250319085825.GH1322339@unreal>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9Y2E1ZGMyYTMtYzVhMi00ZjM5LWE1OGUtNzU1MmUwZjg0?=
 =?utf-8?B?MWJiO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMDMtMjRUMDc6NTc6NTBaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB9872:EE_|TYRPR01MB12302:EE_
x-ms-office365-filtering-correlation-id: 53f11b37-fd5d-479b-d922-08dd6aaa9526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SERVaVVWV1ZaUUc1VWxHM2U4MThpeVBzbkhzalpqbXY0dERPWVFWNlI2NVU3?=
 =?utf-8?B?UUtEdmNQSjZ0cXNlQWZhRVdqUk8wYXVEZlArUkc2d1FJRTlZVzhzVEFzaDg0?=
 =?utf-8?B?QUZURzVXS2Z3OUN4RWJWaWI4eUlqYXdnTUpFdUd4UzNRWHRrSFpsK1JjT0l5?=
 =?utf-8?B?Sms2VzdiRHhVR1BYZkJaUlAzWmY5MVFicVRueDZwVTRPdWZlRHVNYXRYRnJP?=
 =?utf-8?B?ZzhyeU5SczdkYzM4c3ljZUF4KzZ0TXFzNVVBd3R3Z0xmSzR4TVQ1L0ErWXd0?=
 =?utf-8?B?bWZDRlJ1aTdOYnJmak9nSnJxekprV21wSzBLVGR3UGx2VXcvdWdTcWZlOE1N?=
 =?utf-8?B?VzYrTEdQNEhtaDZLekRUZCtJZS9lV3FhS2JxS3BYQkVVVHNNZEYzbVdnUlgv?=
 =?utf-8?B?c3lBZTlJMlZ3d2xCNDltSjhickxTcEN1aDNCNEU5WlcrbjlOTk4rdVoxWGtx?=
 =?utf-8?B?OFljYlo1TVV4dVpjYXM3aEVNUktGdllQSy85RjRmSkhDLzhtanlZYXBjbXpx?=
 =?utf-8?B?RGpzWW9wOThYcUxYUXkxTjlsdzdsb0JieFZQcTc3UzBXL1M4YlNnK1JyTUNL?=
 =?utf-8?B?T2lWZnJ5Q040Q29GMW1UU1dXTjRWN1cwZSt0Wmg5QnNxbTRNMDN2cWhYY3hj?=
 =?utf-8?B?TlErWGJLcG5xM0JTNkkxV2diSnJXcUc4OEF4TE5uZUVMQnhQNjA1ZU4wWW1C?=
 =?utf-8?B?NUJRVGlvSzRNUVpiakdENW5ERDh0WXdhOHRYNVJhNHBEb3ppVWNMSThBaU1x?=
 =?utf-8?B?ZjVSbHpqTVphY0Y0ekhoOXVXbWhvN0wvTTI3YkJIYmRtYlJyMnNVcUIyU0NG?=
 =?utf-8?B?RFlHY0hoamZxZm5VV2k1THJZdHVQeGJ3UjlZWDAybERrVHE5elRTdCs1dFBw?=
 =?utf-8?B?TXhIMjI5S0JnaXg4UUNZRkFJSXM0VWNjeTVXeFNXck4xeG1LZ3d3bFNORUVa?=
 =?utf-8?B?Yms4bFJaSUdTWUhqV3RoWFZvbnMwcU9SVzFnRmIwYXAyNlZRemNYSEhmQWhs?=
 =?utf-8?B?MGEwU0FWQzUxTVJzSjZjVTQ4akpxd3hvTk1qMStqeHg4bTlkeDFPMDIvbk1n?=
 =?utf-8?B?Y2ppVVpmbEQ2ckhocW90R2tCRXNiK2xhRExxcnBJWWNLTWJtMHo5ZHJ0WS9k?=
 =?utf-8?B?dkx3Vk1KVlV5T2w4L0JRaCtIY2c5Z2hCOWRKcmRkZ0FoV3NRSHhweXIyMCtp?=
 =?utf-8?B?cUxvelcvNVEzMU11bVE4a1hZcjhIOERyNHpaYjFMN05aUnFNNXZiVjJ4WXdy?=
 =?utf-8?B?YW9NMnBwcEJjZG80a3duMktFY3N1R0ZBMWVUQ0d3OE9XY2c0WDJJU0haNXZj?=
 =?utf-8?B?SWhSc215Z29OckVqOW11c0ZqNVgxL24za1ZwMG9zSExaQld0ejZkbnY2Z1B1?=
 =?utf-8?B?Sm5saVNXTUdKK1I5eEVqMk9BLytZRHNqeURiMDNOTHk4Qzg5akRPd3FEUE0v?=
 =?utf-8?B?aXVodFVPUjNMWTZzeVJ3ejlkbWhsNEtiaEtETlNMOU9VVENOamtESzN4akhi?=
 =?utf-8?B?aXVMWXJXWWtaYk5GY1ZUN2QvclQzTXIrUVZoMGkwRTdaZUpVbjJEa3ZJY0xP?=
 =?utf-8?B?ZUZsTVRvRW5YR1pPY3JjRGZvQkRCZUErbWlKTUo2bzd3bmZyUjhUcFFjaUk0?=
 =?utf-8?B?V2tnVXV1TVF6b2cyeVFEWEZNUFJlUVRZUGtWTnR2UDJQSDhoNnEwY0kyVXJJ?=
 =?utf-8?B?V0NIQjVPNW5FaTRjcGdGVUdNSzJuNVJicSt3eDFod0NodnRERVFTWXN6Qktn?=
 =?utf-8?B?VERuRlB0U1FIY1NsOGZ2WmR0ZEZEK3EyRkJacGJObjZMMjZyUDVWSXFrc2tK?=
 =?utf-8?B?Sm40aDFSKzQ0UksyVFRJN0dTREM3RTlxMWxlcHRXWFFkbG1qVzlzczVqemhq?=
 =?utf-8?B?YkZzV3VpV0lTS2Zhci9CY2xLVkhrTUFJVzUrSHU1WHphRUlzS0cvd3Q3TEk5?=
 =?utf-8?B?UHA4MVBseDhFSWVFTHZiZGRocjdtVHViSVdjRVkwVGExUlpHZzBtR0ZpUm13?=
 =?utf-8?B?eXFkbHZrNzZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB9872.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2lCWDZReDZiVDhFbjBFanJicHNpTENrVUNoZW5qVkVjUE1ZTld6Z044MWla?=
 =?utf-8?B?OEpqYzNXeDhNL2V4b2FNT3hHL05rcUV5Y014TWRrZHJLK0pxUnZXdlFheldQ?=
 =?utf-8?B?TEE1bFlpa3FIL090NUxEYTA4cXhLMElpcnRBVEVkSENvdkhXdE9UdHJKV1Ex?=
 =?utf-8?B?K2pscndRZk5oNkFDbmNiTEVZcnZITDhFVGtmeGpFcnh0U2FNY2RGTUdlNGVu?=
 =?utf-8?B?SGJNR2ZHWHdVVGNIUkQ0SVZUVVJVdGlCZGd1MEt3aUNxejJZeWhXdGJMakZ3?=
 =?utf-8?B?K2R4bmR2eFkwYXNab2p1RlgyVFJLQ3YvSFlaSXV2ZktpVmxCbHFXbW9EQVR3?=
 =?utf-8?B?c3lkbDhBL0lDSCtqQ3MzcVhzUXh6azJDZENnQ09ITWw1MlMzRVIyUU1pTDBi?=
 =?utf-8?B?Q2pZalIzc2FoV2J0cW14TllPYXNYQnVpNFZReFlRTWQycDlFeWltWi81clU3?=
 =?utf-8?B?cHRTL0tWeTdBcU9ONDVpb1ZkNnZaazdPQU1Ld2hVb0FZc01VS1BFT3drRHND?=
 =?utf-8?B?dHRWZ3QzOVNMQ2xrR2RPYWlxdWpTV3JpaDZYWjNlOUVyYTNqRWlsTFpJRnR6?=
 =?utf-8?B?cjc2VXBsUWFDV25JWlBBQzI5dEZCSHI1RTdZMERHeWFBNjI5d0VRcG1pWlRk?=
 =?utf-8?B?QXhoS1RidlVyRk11K2czRDFTb2tjWFhaMyt2Q3dvZ0FuaE1UOHQ2ZElvb3FU?=
 =?utf-8?B?VDFudVMxekdid0JDVjNWcUNnenBRRFI2dEVtV3VXaGErb28xdG1GdHZJWlZ2?=
 =?utf-8?B?THZHdjlGQ0VtYmZIVGpqc2NtMmIzOU9XQml3VlprcVl3amNQbEdkOE45ellN?=
 =?utf-8?B?NWZLODVTUjRzb0k0NVRkM21BS1RaekZOTkdhakYvcnk3QzBZdE5vTXF1Y1FE?=
 =?utf-8?B?YUpERjFMSDNyNHNKVHRLSytzUVMwUmxwNGNrZXFWcDdtMy8zRkdwckd0UUF1?=
 =?utf-8?B?YVVIRzlleUc1TllRaUIyVWRqdWp0aksyUUMxbnZNSjd0aTBYMGxxamZIR0dT?=
 =?utf-8?B?OERGdHBoSFFDdEtqWHJCMkRkWjhLUi8wNEJvZHhTSkJHSXM4K21aVXRnMXcx?=
 =?utf-8?B?QXorRWx5NFN1U3BKWUJLTHFYL2t1bVA3R3Jqd1J1NVgrdGpxeXVwajQxOVVq?=
 =?utf-8?B?U3IvRWtxVk5QWkNHZE9oOW5YUEdIUWNPTU1jUFZTeCtvNHZMazNhMTExRTEx?=
 =?utf-8?B?enFub0Fpb0pVNlorSkJ1Vmx5WFpJbFNBd3dvZUdGb1B3WElLYU91aWQ0M2U0?=
 =?utf-8?B?Mmxab285dEpzQXhLZzU4OGpoRDFIUW8zOGFPQ3hWVmhPTUQxVEtja011VW53?=
 =?utf-8?B?TVJTOE55UHpyZG9TczFMa2FsaGdwMTFQOXlWM0JpWjRrUGVCQVlwZFBpOUU0?=
 =?utf-8?B?OGZ6dFRUMzV1WUxhN3Z5ZmlvbEJBRlNVU1BseHhwNTdpbmJReXdDYmRTRER1?=
 =?utf-8?B?L2tObFhaN2g1bEFkTGw5TkRJWlliV0FncnYwNGtpU0hBMURWQVUxSUVWM1JN?=
 =?utf-8?B?ZkpKVjFSOFdTVmlxZHJZVVprdmlyQkk5WlJoTGtxQ3FkWTgvZEQwKzg1VWti?=
 =?utf-8?B?c1BscXg3YzQ1RXRZMHhjL3l3b1ZpZ3NEMEg0WGxVYUpoTUFoNEltVkVvcENo?=
 =?utf-8?B?NjVqYytGSXk2SG5DS1NJV3RaaFVTZEJIMFhMWkhud2ZBQzV1MlJyanUyeXdn?=
 =?utf-8?B?VDNsTG5Lc0puZG9xSXNjWXkrUFlIT0E3em1peGk2TG9vWU1lN0Yra1l2WFNB?=
 =?utf-8?B?aExzbFZBeXVDcHVqQlQ2b1JUVmlEVFg0aEFVNTZ3K2pRdGRLMkJDc2dUZngr?=
 =?utf-8?B?MDdRbTdQM2o2M1ZhRFNRamtqc3hkZk1PQU1jMzRSdzN3aFBUQlh6c0I1UjU2?=
 =?utf-8?B?dDQ5cjVKcUhjdGFzTVhSWjFQT0pVYkpFZUlJMzFleTN4bzBjWlNxR1NFeStS?=
 =?utf-8?B?RTY5dnNSMGd4bUdjbFZOVW1KTWlrYXlDenZzSG4veTBHTDhFNEJ6c2NzQTVu?=
 =?utf-8?B?UFliN2UwWHZLclZqTHIzMWFxR0dsR0ViVjk0T3U0ME5mOHo4WEtPYVFqeTND?=
 =?utf-8?B?c2RyRHhjSGF6NVBiUERzc1Rva3hIcHBic3RBYi9mUG1RRFZTODVBLzEyTFR6?=
 =?utf-8?B?WmFJaXp4QWdNWmRyTG5mdU0wVElIRi80K3N2ZGwzOVRaKzZISnU4UHFnSktr?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JIcJWUscrP9gBAK0BL8FDVx3cOXgxBCxSvGWXbWx6OR671eXgqEFsX3w9jgmtUG92wPPYUx9OJhK4UGl79umIOy34wTdfKQmS2m7moRSM1QLLLmdTQpENPQiHtElV0+e1rIVmBaXax9wP+NacJ+1DudNfMFPRDq3mnuIBwo1/Ix4rRr0Ql2JKuSjqfMM6fvTlIEcqnevx4LGa6Dn3y56VNipEfKBzwmKtZG+zI9xKL/xzNhqjeXASjGgsizr1QOI9hfoUVkXWspfgVJFdw+gStnz/BvB7fK6nVx71szrorJrXJjb7yB+Nu3eWTyYgL2+s4MR9S5k3DAXQ2+bg43+tIRKH2VJuStMtxWsbb4n/n/x2WAAVAWrpnUcIo1Fwpw7vmP6Arw+x4BV3NyWqO1CidJuR0NPYsHzGXwkSQSafWIRbbSrCKHM+lWDutGHVFwigyxnPo4CNQ+1z14cvX8DFZMRUZccoJ1tVpt0sXsM3JMsoFNwuu1NPfqi+P1JVyYOsrh7Bd2zlplQcEYbDK0EfJMLfjLMIWt4uMVldV8ZPcrTOCdEQht5LdM6qcb8ykbRDhcLR/U/gb9hQ4fsbx6gvttY9NNQFjTIXn+aHrp4mEnpz0I95fxuqH6wn2ahWGxj
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9872.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f11b37-fd5d-479b-d922-08dd6aaa9526
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 08:05:03.5791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7QAkDA7oMzDdWbC2qMZn0VRNi4v27+emIiGmhS9rorR7oDKrYIhWSf1eZL3XvmzQFv0EvCOTD9BXw5MLfIdKKuPP7Lbn0dnI36qksp4UcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12302

SGkgTGVvbiwNCg0KVGhhbmsgeW91IGZvciB0YWtpbmcgYSBsb29rLg0KSSd2ZSBzdWJtaXR0ZWQg
djMgcGF0Y2hlcyB0byBhZGRyZXNzIHlvdXIgY29tbWVudC4NCg0KSSB3aWxsIGFsc28gd29yayBv
biByZWNoZWNraW5nIHRoZSBpbmNvbnNpc3RlbmN5IGluIHdob2xlIHJ4ZSBkcml2ZXINCmFmdGVy
IHRoZSBwYXRjaGVzIGFyZSBtZXJnZWQgYW5kIGZvci1uZXh0IGlzIHJlYmFzZWQuDQoNClRoYW5r
cywNCkRhaXN1a2UNCg0KT24gV2VkLCBNYXIgMTksIDIwMjUgNTo1OCBQTSBMZW9uIFJvbWFub3Zz
a3kgd3JvdGU6DQo+IE9uIFdlZCwgTWFyIDE5LCAyMDI1IGF0IDAyOjU4OjUxQU0gKzAwMDAsIERh
aXN1a2UgTWF0c3VkYSAoRnVqaXRzdSkgd3JvdGU6DQo+ID4gT24gVHVlLCBNYXIgMTgsIDIwMjUg
NzoxMCBQTSBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIE1hciAxOCwgMjAy
NSBhdCAwNjo0OTozMlBNICswOTAwLCBEYWlzdWtlIE1hdHN1ZGEgd3JvdGU6DQo+ID4gPg0KPiA+
ID4gPC4uLj4NCj4gPiA+DQo+ID4gPiA+ICtzdGF0aWMgaW5saW5lIGludCByeGVfb2RwX2RvX2F0
b21pY193cml0ZShzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIHU2NCB2YWx1ZSkNCj4gPiA+
ID4gK3sNCj4gPiA+ID4gKwlyZXR1cm4gUkVTUFNUX0VSUl9VTlNVUFBPUlRFRF9PUENPREU7DQo+
ID4gPiA+ICt9DQo+ID4gPiA+ICAjZW5kaWYgLyogQ09ORklHX0lORklOSUJBTkRfT05fREVNQU5E
X1BBR0lORyAqLw0KPiA+ID4NCj4gPiA+IFlvdSBhcmUgcmV0dXJuaW5nICJlbnVtIHJlc3Bfc3Rh
dGVzIiwgd2hpbGUgZnVuY3Rpb24gZXhwZWN0cyB0byByZXR1cm4gImludCIuIFlvdSBzaG91bGQg
cmV0dXJuIC1FT1BOT1RTVVBQLg0KPiA+DQo+ID4gT3RoZXIgdGhhbiBteSBwYXRjaGVzLCB0aGVy
ZSBhcmUgc29tZSBmdW5jdGlvbnMgdGhhdCBkbyB0aGUgc2FtZSB0aGluZy4NCj4gDQo+IFllcywg
YnV0IHlvdSBhcmUgYWRkaW5nIG5ldyBjb2RlIGFuZCBpbiB0aGUgbmV3IGNvZGUgeW91IHNob3Vs
ZCB0cnkgdG8NCj4gaGF2ZSBjb3JyZWxhdGVkIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIGFuZCByZXR1
cm5lZCB2YWx1ZXMuDQo+IA0KPiA+IEkgd291bGQgbGlrZSB0byBwb3N0IGEgcGF0Y2ggdG8gbWFr
ZSB0aGVtIGNvbnNpc3RlbnQsIGJ1dCBJIHRoaW5rIHdlIG5lZWQNCj4gPiByZWFjaCBhbiBhZ3Jl
ZW1lbnQgb24gdGhlIGRlc2lnbiBvZiByeGUgcmVzcG9uZGVyIGJlZm9yZSB0YWtpbmcgdXAuDQo+
ID4gUGxlYXNlIHNlZSBteSBvcGluaW9uIGJlbG93Lg0KPiA+DQo+ID4gPg0KPiA+ID4gPg0KPiA+
ID4gPiAgI2VuZGlmIC8qIFJYRV9MT0NfSCAqLw0KPiA+DQo+ID4gPC4uLj4NCj4gPg0KPiA+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfb2RwLmMgYi9kcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9vZHAuYw0KPiA+ID4gPiBpbmRleCA5YTlhYWU5Njc0
ODYuLmYzNDQzYzYwNGE3ZiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfb2RwLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfb2RwLmMNCj4gPiA+ID4gQEAgLTM3OCwzICszNzgsNTYgQEAgaW50IHJ4ZV9vZHBfZmx1
c2hfcG1lbV9pb3ZhKHN0cnVjdCByeGVfbXIgKm1yLCB1NjQgaW92YSwNCj4gPiA+ID4NCj4gPiA+
ID4gIAlyZXR1cm4gMDsNCj4gPiA+ID4gIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiArI2lmIGRlZmlu
ZWQgQ09ORklHXzY0QklUDQo+ID4gPiA+ICsvKiBvbmx5IGltcGxlbWVudGVkIG9yIGNhbGxlZCBm
b3IgNjQgYml0IGFyY2hpdGVjdHVyZXMgKi8NCj4gPiA+ID4gK2ludCByeGVfb2RwX2RvX2F0b21p
Y193cml0ZShzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIHU2NCB2YWx1ZSkNCj4gPiA+ID4g
K3sNCj4gPiA+ID4gKwlzdHJ1Y3QgaWJfdW1lbV9vZHAgKnVtZW1fb2RwID0gdG9faWJfdW1lbV9v
ZHAobXItPnVtZW0pOw0KPiA+ID4gPiArCXVuc2lnbmVkIGludCBwYWdlX29mZnNldDsNCj4gPiA+
ID4gKwl1bnNpZ25lZCBsb25nIGluZGV4Ow0KPiA+ID4gPiArCXN0cnVjdCBwYWdlICpwYWdlOw0K
PiA+ID4gPiArCWludCBlcnI7DQo+ID4gPiA+ICsJdTY0ICp2YTsNCj4gPiA+ID4gKw0KPiA+ID4g
PiArCS8qIFNlZSBJQkEgb0ExOS0yOCAqLw0KPiA+ID4gPiArCWVyciA9IG1yX2NoZWNrX3Jhbmdl
KG1yLCBpb3ZhLCBzaXplb2YodmFsdWUpKTsNCj4gPiA+ID4gKwlpZiAodW5saWtlbHkoZXJyKSkg
ew0KPiA+ID4gPiArCQlyeGVfZGJnX21yKG1yLCAiaW92YSBvdXQgb2YgcmFuZ2VcbiIpOw0KPiA+
ID4gPiArCQlyZXR1cm4gUkVTUFNUX0VSUl9SS0VZX1ZJT0xBVElPTjsNCj4gPiA+DQo+ID4gPiBQ
bGVhc2UgZG9uJ3QgcmVkZWZpbmUgcmV0dXJuZWQgZXJyb3JzLg0KPiA+DQo+ID4gQXMgYSBnZW5l
cmFsIHByaW5jaXBsZSwgSSB0aGluayB5b3VyIGNvbW1lbnQgaXMgdG90YWxseSBjb3JyZWN0Lg0K
PiA+IFRoZSBwcm9ibGVtIGlzIHRoYXQgcnhlX3JlY2VpdmVyKCksIHRoZSByZXNwb25kZXIgb2Yg
cnhlLCBpcyBvcmlnaW5hbGx5IGRlc2lnbmVkDQo+ID4gYXMgYSBzdGF0ZSBtYWNoaW5lLCBhbmQg
dGhlIHJldHVybmVkIHZhbHVlcyBvZiAiZW51bSByZXNwX3N0YXRlcyIgYXJlIHVzZWQNCj4gPiB0
byBzcGVjaWZ5IHRoZSBuZXh0IHN0YXRlLg0KPiA+DQo+ID4gT25lIHRoaW5nIHRvIG5vdGUgaXMg
dGhhdCByeGVfcmVjZWl2ZXIoKSBydW4gc29sZWx5IGluIHdvcmtxdWV1ZSwgc28gdGhlIGVycm9y
cw0KPiA+IGdlbmVyYXRlZCBpbiB0aGUgYm90dG9tIGhhbGYgY29udGV4dCBhcmUgbmV2ZXIgcmV0
dXJuZWQgdG8gdXNlcnNwYWNlLiBJbiB0aGF0IHJlZ2FyZCwNCj4gPiBJIHRoaW5rIHJlZGVmaW5p
bmcgdGhlIGVycm9yIGNvZGVzIHdpdGggZGlmZmVyZW50IGVudW0gdmFsdWVzIGNhbiBiZSBqdXN0
aWZpZWQuDQo+IA0KPiBJbiBwbGFjZXMgd2hlcmUgcnhlX29kcF9kb19hdG9taWNfd3JpdGUoKSBy
ZXNwb25kIGlzIGltcG9ydGFudCwgeW91IGNhbg0KPiB3cml0ZSBzb21ldGhpbmcgbGlrZToNCj4g
ZXJyID0gcnhlX29kcF9kb19hdG9taWNfd3JpdGUoLi4uKQ0KPiBpZiAoZXJyID09IC1FUEVSTSkN
Cj4gICAgc3RhdGUgPSBSRVNQU1RfRVJSX1JLRVlfVklPTEFUSU9ODQo+IC4uLg0KPiANCj4gb3Ig
ZGVjbGFyZSByeGVfb2RwX2RvX2F0b21pY193cml0ZSgpIHRvIHJldHVybiBlbnVtIHJlc3Bfc3Rh
dGUuDQo+IA0KPiBUaGFua3MNCg==

