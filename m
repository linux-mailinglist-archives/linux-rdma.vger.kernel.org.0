Return-Path: <linux-rdma+bounces-8243-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAA4A4B71E
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 05:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E39D3AC1D7
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 04:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C504156C6F;
	Mon,  3 Mar 2025 04:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="SYoomA2b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAE1126C05
	for <linux-rdma@vger.kernel.org>; Mon,  3 Mar 2025 04:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975725; cv=fail; b=NPCe9y7+wbHk3fDdtvQDk87Pv+s4IJL4RnZDOyNgaYEoajtgpE+WVPDVFOcNkONferOu2pT+tVmUSCyg5yYpF4k2rL/FjOXsyS+RR1P/FjrHWp1Mv+92ZIXJJVuol7WVE1TOY2dooXRePsLWEZMx7H+/W7eUfnSjPqhNoiwyfgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975725; c=relaxed/simple;
	bh=j5WxauVcdjIoZoSL/CCdX2bRkzw6bHViggme5zABHlM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f8btYgqcERB48LWhdyhwoyXc4aQ/vUpMoJ3g228DGIB5LCucQnT1WD8DNnFguJ0E32onQqewQbz55p+y4/2+2npqi4IFkJvIX/0LRm8ib3yjqoSHZndaxf9OzA9eYtiG8hmTdJbtKPf7SsGbMl+4GUVPX1L8wnlqA50XdD3E36U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=SYoomA2b; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1740975722; x=1772511722;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=j5WxauVcdjIoZoSL/CCdX2bRkzw6bHViggme5zABHlM=;
  b=SYoomA2b6V0Qxs5jp/f72JfbbWpo3wAGD1KwR9YWAXK2Ikwla2I2JEXy
   d9CAgvStJl7M/447L5harjCV24a5TX/UybsxtGoergCWQilDEQmaRsUIF
   uOPDdAztFi1Cwrwfl4tbdFeEVEfpxFNhvrByuMODDX1WEYu/6+IaswmW8
   VFLkEr+ITM/3GnLtuNfDw34rjuD5fZCXANyDgwGy1Fi7O4nFc/GEuKSlL
   Foy5286H0fp1JLfimnbjtWBIPVLvt8ZXUi8o2x/a/1GbHsMiKSiw4jREC
   7Whv/MDh5jIixskC0Qvg3+Au0WldW9UP3WbM6vCtoBoMMVCmMZXFCuMTc
   A==;
X-CSE-ConnectionGUID: NghXsFHmQvmrYvaNGYZ+gA==
X-CSE-MsgGUID: bDzp/iBvTyutaezSYUuJmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="61064006"
X-IronPort-AV: E=Sophos;i="6.13,328,1732546800"; 
   d="scan'208";a="61064006"
Received: from mail-japaneastazlp17011028.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:21:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLDO1az6EaySxYtajcneYrfn2dlm+yCQjvQZkbRXW8Qqwu2CB94jejbOF25a2gE3H8Pcq1qqHGtcQdSEdQRX8e2CPgdDhNF2J2FEKyOaX4Eq4pZ40+C0ObXX1UqYvBH3l8gMjqghl8iXA3s49esFhOl/rle/bTMf0RKUOKXDKsV+/jBDQQGqfLo/liIwkJK81yB9MgrGt4OD5KugtW5gKplgSiuEDp1HLFkNtWKx3hbFQpFsMVdOKjdzMI73iuwcYjMXj2OzfqwTu2EPdH2qgE63FlolcJcjH+w5/iJ9j0QFCOdnZAToxjhAKo7Fn/11ZkaEm5OoUicDmxx1Eq7RVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DfFycbmfd//O1OIqnvvnQadRFP4j9mYxsLsvptPz6g=;
 b=FjgJTQc6yaIyxUHujiiD3ZdKvm+oiTySIf1ydQxffMbJ9SFoWROcJgOaJIjb/svI8sTfd/IeRwFWmZ/hn9xf6Du2VcL7BOOw5E5LDwJFfvFY4euMwxywfoCaFSVjxAnsnlrNpPmSLH6L5JyIwSxgbGDifMEAgwzp9/5R5y55nyR/fn9/+IsZ4+EbDBkPcaZuRpR0drZISnSBcAcws27Ps0KCI0B7JCeABflIX6qkSrSo4/HKQgoF3lRblzMUhAzgmbKHPh1VDzC0ESTI2W36leYt95UVQXKxX/6JNyReHrJ3UW9kiiY8Uoe/9yd11O6/BWO5mqfmWIIVTOh3dhaPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by OS3PR01MB5942.jpnprd01.prod.outlook.com (2603:1096:604:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 04:21:48 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%3]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 04:21:47 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Zhu Yanjun' <yanjun.zhu@linux.dev>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-rc 1/1] RDMA/rxe: Fix the failure of
 ibv_query_device() and ibv_query_device_ex() tests
Thread-Topic: [PATCH rdma-rc 1/1] RDMA/rxe: Fix the failure of
 ibv_query_device() and ibv_query_device_ex() tests
Thread-Index: AQHbi73O48ogFeWUlkOWfwVlL0aE87NgzcBg
Date: Mon, 3 Mar 2025 04:21:47 +0000
Message-ID:
 <OS3PR01MB98654DABDD313E46C2727774E5C92@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20250302215444.3742072-1-yanjun.zhu@linux.dev>
In-Reply-To: <20250302215444.3742072-1-yanjun.zhu@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=a73388fd-6e03-4846-a237-ce3645be14c9;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-03-03T04:13:28Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|OS3PR01MB5942:EE_
x-ms-office365-filtering-correlation-id: 03e655d8-64fa-4f97-893b-08dd5a0ae9ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?NUNZMTJNeFFvSFd2ME50Ri9xby9yUWQwYWtIYm1pTDdxZ3FDTG04ZXF5?=
 =?iso-2022-jp?B?enZkbkI5cU9rd0dYSUkwQkhrbEx3ZlpvdHRuQXFrd3dyMFRId0RQdUJh?=
 =?iso-2022-jp?B?UkYyQUJPTjEvSG5iWDBVWFUvZzlRWmhYNU5NYkg1NlFNY3dZbmNYYmtz?=
 =?iso-2022-jp?B?dmRMbkZuMk9lWGxNTmdRVFZaTVRZcFhGRnFOTWsrbWVuaG1BLzMvNTk1?=
 =?iso-2022-jp?B?OUhFM05ScVl5RlptdHJoeTlqYkpUb0VlVldzbWdnRy8wanIvVS9yMzNU?=
 =?iso-2022-jp?B?VzZQVk5UdXVTRHBxWUVQcFFWaTJlM0xvMlFsb0VhS0Y2KzZDTFpETWpw?=
 =?iso-2022-jp?B?c1dWc0x5WWw1MVdhKzZId08zUjlreU9TZnM5akhUZGwzdjZRbmI5MHZJ?=
 =?iso-2022-jp?B?cmRDeDk2T290WDZiZU9LcDhNVmZMN3FPN0JuUzhFWVlYYWl4N2JEeWV5?=
 =?iso-2022-jp?B?WVY5dkltdWVRbThZUFhUYTVZVHJCTStGc3JxVXRMMnRJd3FqaWRGL0hV?=
 =?iso-2022-jp?B?RXk0SkdLM2dvU1NGL2YxT2dSR3RrL1BBOUMwSEoydTNZdU5JVUthQjVH?=
 =?iso-2022-jp?B?RHB4KytYZ1BsMWZ5bmJjNC9iMTAyZzlJTVBLSkJ2NXBWSTNoNnJRVm0r?=
 =?iso-2022-jp?B?dWV2NHVDOHU0UkRhSmNtNmpTRHNoeDBkencrekdsczBzZ1l3c2lQRlhm?=
 =?iso-2022-jp?B?K3VZUktXSlYrZ0VjcmZzUjBMUEZGeS9DSGhEZm1yTEdvdENocHIxeHJu?=
 =?iso-2022-jp?B?eW56YnlnVm9IRHJEdEhRNUJSQU5CckEwZjhjWmpEWWJoY2hZVW1WdXpl?=
 =?iso-2022-jp?B?N1JtUjdMckVIS2EzRmtabzBVN1dXYzF1Z3Rra3NZYXh4NTJjM3hhUDFT?=
 =?iso-2022-jp?B?bndTWDQ5aGEwbmpmMXh6TklxakYyd3pJRmF3ZUUvV1lNUFNEbGdJTGZ4?=
 =?iso-2022-jp?B?ZXlxSlp0d2Zra1VJc2ZaTngwTVBYOUEwWVgycWJXNEo4QnE4d3daSmJR?=
 =?iso-2022-jp?B?aWEzb0F0cFp0cGZtb2p5L0JGaFVDWlhUUVRMY2tMbm1BZHNUaTdNNDRh?=
 =?iso-2022-jp?B?NGZrdTh5RGNiRlZGQUVuVmtoeHVrbmh0dSsyaUxiSld1b2tLSmJxUmNQ?=
 =?iso-2022-jp?B?eStoSEU4S29jaytDaXkydTNPWUltZUhVd2xJTDZZZ2c0RE82dEtCTkhP?=
 =?iso-2022-jp?B?ZkQ4Q3gydzNNZllZY1gwbjVGVHNXSVdmN1dqOUhMZWRWUWxWY044ZVhY?=
 =?iso-2022-jp?B?R09UTEU1MEEwY0V1ei9ScjFxamxUak5HdHVJc3JKRURSeC8wbTF1YTdN?=
 =?iso-2022-jp?B?N2tZWVY3bEd1aWxLNjRQYWNiR0V3aGl6MFNjVzRoQTRnMlBLM0dSVmQ5?=
 =?iso-2022-jp?B?UjRQTzA4dlhTc1Q3bHk0TXo5KzlUandka0hnRmRGaWZXblhmT1hkMVBN?=
 =?iso-2022-jp?B?T0FXNDVtSnUxOHlIaTk5S1MrNkx4OXFPQnQ4MTVhQmVwY0JvN09nNGxK?=
 =?iso-2022-jp?B?aXhNWmg4RUx3bE82UFRtT1BzV2o4TnFHeTFieEh6NFY2bWF3c09VOGZC?=
 =?iso-2022-jp?B?MnQxcEdSOG5CamlIaU03a3puK09EMGV1VGpaOGIxWHIwQXMweHl1elhw?=
 =?iso-2022-jp?B?SnF4dWlGUGtjQWZNVFZ0ZWxBbE9BTnp2TFlQL3Vvbkx4NmF3NWFBTmxu?=
 =?iso-2022-jp?B?SWw5OC9NZXhrMmZEd29MMXZZUVV5cDFxeGVYNU40S1lLQXd6TTVrbHhC?=
 =?iso-2022-jp?B?VldvVFJHU0xid0FhWnNLbS9IOEpRY1Nmc0lhL2hsOGxqWC9QU2pzMzN5?=
 =?iso-2022-jp?B?ak4va0luMTUrbGtnbklrc1NwbWRBdGl5cTlBZDI1YmNoVWltNlAyU3R4?=
 =?iso-2022-jp?B?Qm9aUVZaTmF3SDV5UVZ5dzhYNlpGZ3NrUWV6TXNlZGdVbHdGZEFwZ0gr?=
 =?iso-2022-jp?B?KzE5M1I2aFpsaUlsOGhJc252UVpjUWZMQXA5UVR0bTc0RytKbUVnck5Z?=
 =?iso-2022-jp?B?TmtTdU9sTnZvTVJJZURCcG9pUXllVXU2aUhZNCtza2VUaDJrRDIvRzZ3?=
 =?iso-2022-jp?B?cUc4TWNBa1pxOWFmVHkxTFZCQ2dOaWtONDF3RWlEdWxWbjdEVXg4dHE2?=
 =?iso-2022-jp?B?RUNycDVTWEJCZVJhNDhFUXd2UW9yVG9BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Y0o3QUV0NmJIcE5tU2JoY3BGN0g4Q3l2Z0N1NHhuZDNUT0R3YlhLMGFV?=
 =?iso-2022-jp?B?ejAwYmptSEtGTHY1bldOOGZlN1JOMnlldTEwRGpxZzM5ZnFJblBpcURX?=
 =?iso-2022-jp?B?a3VkSXdxYytjYTV6TXU2RTBQTVBQYW83WEo4M3ROc0xkbFhEbncrUDlr?=
 =?iso-2022-jp?B?emUrTUFmcXJkbXJtdE01djVIZzd5K041RlJsQ3VjUHlOc0dYYW9NTzhD?=
 =?iso-2022-jp?B?cW5SN040eFJBdTBkdzVsb1FvRURtTm4xR2xkdFBUVVRTWm5SaFcyZTVJ?=
 =?iso-2022-jp?B?aUhJMGxrRnRmZkZDRmNJVGNCNTdGVUs1STRpc1V6a0pOemVKbjV0ekNw?=
 =?iso-2022-jp?B?S051U0JBRUhyWnJyR3ZQcE5Vd0hoZXAzN05jNm1Td1dRS3daYVptajRV?=
 =?iso-2022-jp?B?YUpvSUVscE04dG5WbVZZSEVuVDc1Ni8reWxQMUZCajhSdkZiL2JsZm13?=
 =?iso-2022-jp?B?UnMvUzIyM3ZSTFdTVzlyM0pORUlxbGwxSm5VcmZFcGw4WXI3NDNaK253?=
 =?iso-2022-jp?B?bmoyd2FLbWJIS3RTTytXUENQMVkzQy9tN2VaR3FSRGJlVXp4QUdQc2JG?=
 =?iso-2022-jp?B?YW9aV2NjWlFSaWhsNHkwMzl5LzNSTloyUHNHOSt4MzN4UmNBd1R6Q1Ry?=
 =?iso-2022-jp?B?eUk0MS9YQnVDSFlCSnlhQ1hmQVMwWWhuZFlKakQyMnFyTkhHN01vRjJR?=
 =?iso-2022-jp?B?UUdsbDVDaGdRRFFJamZzTFZpMysyQS9UUWFDdE9WSkl3RThSVWQ0Q3Rv?=
 =?iso-2022-jp?B?ck8wQlFIbzJMV085RDI4WktEN2d6Nzg2djlRbXIwQ2hXdlNkOXUxbVZK?=
 =?iso-2022-jp?B?VW5VZjNqRVhWM0E1cFRQdlErV0JUVVhPbUZFS2lvZU5Fc2c2TkM0NEdp?=
 =?iso-2022-jp?B?M0s2VEFRS2ZLSS9mNkZKVEhvZDlJQjViYlovQmIwRHIyWmN2dUFrc0FN?=
 =?iso-2022-jp?B?S0JFM1VhcjJzTEhDdUZ4Wk1rL2FYTTZnYnl0dHNuR0JhTFJwc0UxTDAr?=
 =?iso-2022-jp?B?aGU1MWV2MjNWMTd1SXI3RnNkSVZtK0hHek1FTTVESzlMVm5hQUM0ZnN4?=
 =?iso-2022-jp?B?NGhpa3J2amROUzgrS010allJdVBNbHNqV2E1L3BLcURvRWZQSTJqeU5q?=
 =?iso-2022-jp?B?dEY5bnJpK1RaR2tXUXZOSnJCSkNKOWdtWURQNktENitIOWUycVl6bTdR?=
 =?iso-2022-jp?B?Q0tpdXBkT2xaL2NpNzBDbnZWL2F6R25TTVpKR1pLUkp1aUptK1JuY09V?=
 =?iso-2022-jp?B?MC9vMFBVa2JRT0h6a1I1d1UyMUpCR0FyVFV5cGloUEVPbXk1cFpHOHB6?=
 =?iso-2022-jp?B?TUdzemtYdE9wRzV3S3lJYVZBKy9ORUdOTXR1bGdhWXVzTlZyMXpvT3FS?=
 =?iso-2022-jp?B?RFYreGxISmp1NkZKbURtaTAzTUxuaGZMc0ZkRTE3THg1bzgvQU5lUFdD?=
 =?iso-2022-jp?B?OHRxaFhxa0owNXV2bUZ5V3R2eWNPNUNsS0pNY0IyZ0lva2VnZ0Ivb3Bw?=
 =?iso-2022-jp?B?dG5kVmJyM0Y5MkNBcnVudkNEN0FqQkZkR21aa25tVkw3Rm5ac2p1ejRV?=
 =?iso-2022-jp?B?L21XV1c0VlcrT3BjREYzRGlBaU1wRDI4OFBXQm5haDVzTlNteDh5ZHo1?=
 =?iso-2022-jp?B?aU1vYzNPQXpDWFM0NkRMWThsdm1vaW82bkt5VUxZTWhJQTM1Qk11ZTRL?=
 =?iso-2022-jp?B?YzdJYVRxL1kxdWhXRGRKV0l4dnpDMGdxUFVOZXNEQTQ1MTRnUEowMVJT?=
 =?iso-2022-jp?B?aDZUZldKckNNYm5wdVN2Ny9TWjd6Zy9ZTng5eE9qNHpiZ3hpTlhocVNI?=
 =?iso-2022-jp?B?YnZ1bCtQVDBsUmpCWm1kSHJIZWF2aG1IMlhZWXFTL1kxZ053VVlBVG9B?=
 =?iso-2022-jp?B?Wm1qVDVnaXo1Y1VleStKc05aMlJmYVBBQis0Z1Y4NmNUdDJzZjNhMGNK?=
 =?iso-2022-jp?B?UjJVTVp0UTNUVUZZMjArNHZDek56UFVtVDBwemZHT2dGaWFQYUs1Ynlq?=
 =?iso-2022-jp?B?NUpUZEpZcmxsbjRuR1loNTNpbVVpSThzSFIzVEkrQ1ZTRmVpbGI1YVhU?=
 =?iso-2022-jp?B?ZUxCMmp4K1pOV1VXV2xQQUlEaWxZdkJhTThsVGdZYTVINWZzYkl6eHpo?=
 =?iso-2022-jp?B?Z2pTaVRzV0laWURxb0xuYXMwZXQ4YTZuRkg3ZURjTTg4T2cyTHZPQ25D?=
 =?iso-2022-jp?B?Nm5OY1djdHpRaGtDeG8vNkEzaFpWSXl1UVc3OXhHZ3NRRllWeEVHMTFm?=
 =?iso-2022-jp?B?Wm1uSmNZZXRSMkxZRVhrOGNJeU4wZXR1bE95QTRKUTluVEU1S3VLVlJj?=
 =?iso-2022-jp?B?K1daZWJoOS9leCt1RkNxWWVkWVlBZ1FxekE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uj09kgl2mxWRwozM/sYh0X7E8r9jLc8gAO6qd3bQHXx6wsFQs0Iqkyqb390NEFSdfxPN45sgEF1feMClmQI5htFzd1AbyFTE3hPQghEVVCXkMZa31WXRCw/w9yj9NBek4LTrOyFEmLw4ciwaQK3kxiBanK3ysmKAQ5WyUtZw4C0BfwKGmU2E8BTffuU0dJ+hRj4EJBLzKoOgExYJOjWctK4O797LWz6DIh+a2GROu5e80zppmRM5i23mpQP97nbeH2wdbkDNWH6d3+eQc7+apmqfUIsO+NpgR6UdGfYs4zLUdH96e1GHA2ATDLWb2NGFqLCjT66Q+stG6V/qiBN6bKg6wnSZNOOXJUyVlADVCdAzRpuvSi5nypNgh/MFHJWB8JIftL3c4BFRcQisBaQ3e9njoB2axS7fr+CCLs46RaMt4Q/DNq759qkaXXhy1YO2+JZovYyRBM5hID5M5ki07Y0tBBd4FNe/ZEsfsAPJbs8Qj41kmq0VL4jSsQQSz/WmfsUkaNyFUbvA7MXjteRmh0uXYwpIpMVvW39fjZlN1WZ3W7zTWU9cVDKzfG8HM93JobABpFnXP2mfT5lCC6uLuZwUCI9kuCX4lmIl+vcSbrZYwxME9MInKTPtHTkT89I3
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e655d8-64fa-4f97-893b-08dd5a0ae9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 04:21:47.2532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4NblPQ3JBBPE3gaXyyReKzjT+nyjLk8XvY3o63fnmfRmq5m5VwyPMZMUvMRlqLvUJLTPk8YzS+psfekDPghRYsPb6v6/fSRZBt0//C/Zrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5942

On Mon, March 3, 2025 6:55 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>=20
> In rdma-core, the following failures appear.
>=20
> "
> $ ./build/bin/run_tests.py -k device
> ssssssss....FF........s
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> FAIL: test_query_device (tests.test_device.DeviceTest.test_query_device)
> Test ibv_query_device()
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>    File "/home/ubuntu/rdma-core/tests/test_device.py", line 63, in
>    test_query_device
>      self.verify_device_attr(attr, dev)
>    File "/home/ubuntu/rdma-core/tests/test_device.py", line 200, in
>    verify_device_attr
>      assert attr.sys_image_guid !=3D 0
>             ^^^^^^^^^^^^^^^^^^^^^^^^
> AssertionError
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> FAIL: test_query_device_ex (tests.test_device.DeviceTest.test_query_devic=
e_ex)
> Test ibv_query_device_ex()
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>    File "/home/ubuntu/rdma-core/tests/test_device.py", line 222, in
>    test_query_device_ex
>      self.verify_device_attr(attr_ex.orig_attr, dev)
>    File "/home/ubuntu/rdma-core/tests/test_device.py", line 200, in
>    verify_device_attr
>      assert attr.sys_image_guid !=3D 0
>             ^^^^^^^^^^^^^^^^^^^^^^^^
> AssertionError
> "
>=20
> The root cause is: before a net device is set with rxe, this net device
> is used to generate a sys_image_guid.

I have tested this patch, and the problem I reported last week is now gone.
The fix looks good. Thanks!

Tested-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>

>=20
> Fixes: 2ac5415022d1 ("RDMA/rxe: Remove the direct link to net_device")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/=
rxe.c
> index 1ba4a0c8726a..e27478fe9456 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -38,10 +38,8 @@ void rxe_dealloc(struct ib_device *ib_dev)
>  }
>=20
>  /* initialize rxe device parameters */
> -static void rxe_init_device_param(struct rxe_dev *rxe)
> +static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device=
 *ndev)
>  {
> -	struct net_device *ndev;
> -
>  	rxe->max_inline_data			=3D RXE_MAX_INLINE_DATA;
>=20
>  	rxe->attr.vendor_id			=3D RXE_VENDOR_ID;
> @@ -74,15 +72,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>  	rxe->attr.max_pkeys			=3D RXE_MAX_PKEYS;
>  	rxe->attr.local_ca_ack_delay		=3D RXE_LOCAL_CA_ACK_DELAY;
>=20
> -	ndev =3D rxe_ib_device_get_netdev(&rxe->ib_dev);
> -	if (!ndev)
> -		return;
> -
>  	addrconf_addr_eui48((unsigned char *)&rxe->attr.sys_image_guid,
>  			ndev->dev_addr);
>=20
> -	dev_put(ndev);
> -
>  	rxe->max_ucontext			=3D RXE_MAX_UCONTEXT;
>  }
>=20
> @@ -115,18 +107,13 @@ static void rxe_init_port_param(struct rxe_port *po=
rt)
>  /* initialize port state, note IB convention that HCA ports are always
>   * numbered from 1
>   */
> -static void rxe_init_ports(struct rxe_dev *rxe)
> +static void rxe_init_ports(struct rxe_dev *rxe, struct net_device *ndev)
>  {
>  	struct rxe_port *port =3D &rxe->port;
> -	struct net_device *ndev;
>=20
>  	rxe_init_port_param(port);
> -	ndev =3D rxe_ib_device_get_netdev(&rxe->ib_dev);
> -	if (!ndev)
> -		return;
>  	addrconf_addr_eui48((unsigned char *)&port->port_guid,
>  			    ndev->dev_addr);
> -	dev_put(ndev);
>  	spin_lock_init(&port->port_lock);
>  }
>=20
> @@ -144,12 +131,12 @@ static void rxe_init_pools(struct rxe_dev *rxe)
>  }
>=20
>  /* initialize rxe device state */
> -static void rxe_init(struct rxe_dev *rxe)
> +static void rxe_init(struct rxe_dev *rxe, struct net_device *ndev)
>  {
>  	/* init default device parameters */
> -	rxe_init_device_param(rxe);
> +	rxe_init_device_param(rxe, ndev);
>=20
> -	rxe_init_ports(rxe);
> +	rxe_init_ports(rxe, ndev);
>  	rxe_init_pools(rxe);
>=20
>  	/* init pending mmap list */
> @@ -184,7 +171,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int nd=
ev_mtu)
>  int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_nam=
e,
>  			struct net_device *ndev)
>  {
> -	rxe_init(rxe);
> +	rxe_init(rxe, ndev);
>  	rxe_set_mtu(rxe, mtu);
>=20
>  	return rxe_register_device(rxe, ibdev_name, ndev);
> --
> 2.34.1
>=20


