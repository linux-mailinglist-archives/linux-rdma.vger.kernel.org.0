Return-Path: <linux-rdma+bounces-9621-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4F9A949F8
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 01:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF343A878E
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 23:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695E31C3308;
	Sun, 20 Apr 2025 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="qey7Z4DS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8815184
	for <linux-rdma@vger.kernel.org>; Sun, 20 Apr 2025 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745191953; cv=fail; b=nvNsV/2gTv7ptEZWxc9lZ1mH7pLDUT8D83d2O0u6yDDNaoWL8QEP26yJSX7aiWJZuY893COvZeu8Vev77uth/l3AVdH/9dviVjWdtUVFu9QEzAGOmVjxVgY5Zxb0K6hsbqebDwcsxCsyBV99EK9zhBGe0p/nPOmMQJIqSfs18NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745191953; c=relaxed/simple;
	bh=T6S0Gpf13bgzYXo2hmvgrJ8Ke+Pn8CIpTSObXyOmdmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=id8EqEu6yhVYLGlVICvuEoAmUNMM3su9vaeJsn2AnqC/Nf6Py71BNDfxPHOAtMqYNCqnypmnFY59al7rkyvZMzDrcpjvZXw3BgQmWkXa0P/3GHqijTqWO1pfdyXlolOHDPK5QBUFzD8RpBP/vYznZKAcanZysjyPfb2PoJOB0lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=qey7Z4DS; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1745191950; x=1776727950;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T6S0Gpf13bgzYXo2hmvgrJ8Ke+Pn8CIpTSObXyOmdmk=;
  b=qey7Z4DSX27kHCsNrMEqTqgHUV3uO8MDAqU0ZOXhch55ZH6F5OnMAPw8
   kHgObcco8GgD2k+r9KLOfPvdAWB+Nn8IsGkFCw7tABoh2e4iHJytvbV+Y
   X2Eno5qXqqaWZal+2eEVLnCfi90t2RFs+gV5lM8fdlEFs3Ez3zTn4GcCj
   WqQiaxzvVmAl2ADLK1iJJ376MbYX+lvNtX5x7vo0b512k8S9AtXaGdgqm
   TqXAc2oTJgdt77gyWzczhvajamh/+cUVUVcTY1Ajru1C70DWO6qXM4+S2
   jgTCSclNETczABRR8AD4vsTsAGF5ww+TLekv4r/7mP52iFpjyH0W3RKZs
   w==;
X-CSE-ConnectionGUID: E5weT+JpT0mhCbKTbJIQkQ==
X-CSE-MsgGUID: igTUBJFLTLWGmxjgIMCc8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="153379871"
X-IronPort-AV: E=Sophos;i="6.15,225,1739804400"; 
   d="scan'208";a="153379871"
Received: from mail-japanwestazlp17010000.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 08:31:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cITnH7lBbwcaILs/Za2es6R+4b/EqYhR3d6YlHoQ87KKmAKRA+D5Z4xpxjx3Be0gOzt6Ee8NIlZkLKKRjWGlC1cMzq1tguF6rwrwOjyENc/PPRbDGw8aMOlW1rxNufA0FWcVZ8zwnBcmVZw2z1IoOuCbYXbg8kh1NqXriQ4qt9tme4izZFrBv8dQ3vBtYx/LY9tzX7zUQ/T6Lno+GpcAgeuFooLACuCk2p5DmqgjM66ae948whCPKYiUIvqIjjWBoWOQPi7psOaEE4QIsXSI2lmEZ+CH2Xmq0blwytssGeljRZ3SVfVfxti341FqYhonecxAUQKBGpKLO6zcpmOrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6S0Gpf13bgzYXo2hmvgrJ8Ke+Pn8CIpTSObXyOmdmk=;
 b=Y1vuoVXxnofTxnWTYgSP8nc5dFTP+zKM3eu8wt0op0V6wkitHdx1DuU+hiJGR3wQeTyGW8L/VDLRYa5BsdNYHSydW3zcfWsc5cmA23kD4GI5Zj7yyoMHNl5zntjf7Kddr6s0wUrYYM68AXf+zmHJdRxFt10B8JqNCzjH0bWuH9hELzI+StelLVFc4WH3zGFUCgXAy2sVPg5yn++Rx5E9fALUvUJmUgNFK8NPz9Wk4PJPvDJXK/TF7Tb8JYkYqJlE7dd8ohPicteNO7kGHw1KvsAN6PaN9QE95TckSPH4hA+1yJVgnXgiLRVhCPIDInuCv0l869Hl2hutVsMJ22Gdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TYYPR01MB15691.jpnprd01.prod.outlook.com (2603:1096:405:299::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Sun, 20 Apr
 2025 23:31:11 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%7]) with mapi id 15.20.8632.030; Sun, 20 Apr 2025
 23:31:10 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Leon Romanovsky' <leon@kernel.org>
CC: Zhu Yanjun <yanjun.zhu@linux.dev>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v3 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
Thread-Topic: [PATCH for-next v3 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
Thread-Index:
 AQHbnJJQp2nOjxjI7Uy0N2Ugx/pysbOZtPEAgAR6eKCAAK1DAIAELPswgAA2lYCAA2gzAIACKAPAgACc0ICAA/ErIA==
Date: Sun, 20 Apr 2025 23:31:10 +0000
Message-ID:
 <OS3PR01MB9865F07351CC313086C7EF3CE5B92@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20250324075649.3313968-1-matsuda-daisuke@fujitsu.com>
 <174411071857.217309.12836295631004196048.b4-ty@kernel.org>
 <OS3PR01MB986530139AE70B2D0BB6C111E5B62@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20250411175528.GX199604@unreal>
 <OS3PR01MB9865CBFAA8DAA73AA42C6D95E5B32@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <8304bc38-7c3b-4e24-ad15-7dcf0eb40fa2@linux.dev>
 <20250416165834.GZ199604@unreal>
 <OS3PR01MB9865FB15CEDD78D9FE339DBBE5BF2@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20250418111533.GA199604@unreal>
In-Reply-To: <20250418111533.GA199604@unreal>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=fda873ed-1767-4925-bd0e-efa2623fbcac;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-04-20T23:27:30Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TYYPR01MB15691:EE_
x-ms-office365-filtering-correlation-id: d9f77a6a-5101-4176-0b85-08dd80636ee6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?Qy92SjdyS2lpblNZaE40cmRDVFFIaVlCTlg2VXFCZXNmSlNxaVVQQStJ?=
 =?iso-2022-jp?B?ZGM5MGtvQkRMNUV2R0Fqc3hxeGNCVEZDYlExanhMUStKWHJFVzFOWUZS?=
 =?iso-2022-jp?B?YXdWR2tHa3c0U3U3UCs2OGtoaWJ0MjZDa0lOWEFXL2t5RjVxRHdsT1hq?=
 =?iso-2022-jp?B?TXYrN0xHdkpGOGFuMW83MzNrYWFZQmpTNERUaXpmVkdZVzdaV1FpYndn?=
 =?iso-2022-jp?B?QWJseHRzeitGY2JnQWttMTN3anlndGllSXNyT1lzRVhGS1FPT2ZKMXcx?=
 =?iso-2022-jp?B?VFhpeU04Zk1wUVFCUzJ2RjBZY0pWSC9meEx5cmxmMlBhUlFkVU5qRklO?=
 =?iso-2022-jp?B?VjB3NGw0aDhXay9HRGVxdGFFVWMzM3dTS0JhU3pZN0ozYnFIc1hsdWU5?=
 =?iso-2022-jp?B?S2Yyc1lvd3IxdVJaaWl5b1JoWmgrWjQ2UXA1QmpWWk1Rb2xobVp5bFpa?=
 =?iso-2022-jp?B?aWxLcEZxa0VKNnc2aWxsM3QrNkgva3FUb2pVcE03ZmxyNWdyMVVZdFNM?=
 =?iso-2022-jp?B?RTlLdnBUMnpXSzl6dEhDQWMrYmtCakdud200TEpEZlVnZktEY2VBTFhL?=
 =?iso-2022-jp?B?cVhFMGZkYjduK3ZXTDhPM0I1NGkvL2tvaytaay9ncGJBbzBRem95NGg2?=
 =?iso-2022-jp?B?OGI1UXRRSzlZeDhQeTVIbjB2cEx2Y2lHQm92MlNNVXM0b2RtZjRtbXUz?=
 =?iso-2022-jp?B?NEJjYkdxWEZrbG0ydk1zbjVHN01LZ3VZc3hlRnp4d2x0M1N5ekhua0M5?=
 =?iso-2022-jp?B?SjlyWlZabVJRTkhGSmN5c25icU03dmlzbmFUdzN6elA0M2RUeEtqdXRj?=
 =?iso-2022-jp?B?SEwyT1NTWEFTdVp6ZEVONEVraU1WOUpoN1NEQzdaT0EwWFRqVnhkeEhy?=
 =?iso-2022-jp?B?cEhMOWVZMnNjYkd5TVN6WC9jVG9RV3pNSFptOGQrVmQwd2dMQ3Z3d3Rl?=
 =?iso-2022-jp?B?U1VTVm5ZNmIxWVBhWmdRMGZKdG81bzJ5dC9PNmFLUm9wQnhvazR2RHNx?=
 =?iso-2022-jp?B?YnZlUTYrQ0FJcFpHT2JkSFVqNkYxWUlIUGRxYmFuSUdDM2JlOVQ3QitT?=
 =?iso-2022-jp?B?aDZvODFGSkgzYmI0SUpFM3FRK0ZSWFFqeU9vNEljRkYxdjNZWmFrUkhC?=
 =?iso-2022-jp?B?eUNUdkZROFptZlN0ajlwNVlvRTlVSVVMeFcvbmxFRUlFYlJoR3B0UjdL?=
 =?iso-2022-jp?B?bzdxQlEvT0pESU4zVWF4aXZsUHo0NWIzelhaY1RZcUdTbFpWYy9XamtT?=
 =?iso-2022-jp?B?QU5RbTlSempsU1NyWVpQWXVXUEtndW9kT3VHSHE3djJOVUJ1RDZqVDNW?=
 =?iso-2022-jp?B?clQvcmxyeHNHVWNDTXJOZTJXNFU1ZGVEVlRFZW5tQmRPUjhWditPSkJv?=
 =?iso-2022-jp?B?enp4dkx5WWVzZTlSdXF2VCtrZlJPWE11cGNsd3lGVDdIUmxQdXJpemto?=
 =?iso-2022-jp?B?Y203ZWdSQ3hYckpoRmMzWlN3SXd2czlNZTlSWlNGcHhKcjlCbVRXMmRU?=
 =?iso-2022-jp?B?ZHY4ay9XWkp4Q3EwODZxUlZ5M1pIblNIVGhwNFBESVdydHVjNDBRR3BL?=
 =?iso-2022-jp?B?NXVZNXcza045a0Y2cCt6REM3YlVYVi83VmpIWTF1am5UWk1Jckp0NFk2?=
 =?iso-2022-jp?B?SFF5V3h0Nmc2eHlkNUlqeFJKRGt3eEl2ZDI4WTlyVzdyakxua1JEajNO?=
 =?iso-2022-jp?B?WFIwd1pBMmw2aFJIc1RNTWlRMkZJQ3prU3h3cnFUSGswSGMyUlZGVXVh?=
 =?iso-2022-jp?B?eXBsWE91cGIybjVvbmNkSXF1cUJYOHY2dWNyaXdabWNDS1BzMGRDMm80?=
 =?iso-2022-jp?B?Y21hRldmZ2M2WFhlcUZBVWx6MUtpcVhnYUswQXllRklEZkFpanFIZXlM?=
 =?iso-2022-jp?B?MUV1QVJuUTUxV3I1Q1J1aDJMa0ZrOGtERDFVVDFIRVBwQmNhZEY2UDIx?=
 =?iso-2022-jp?B?cGZ1Vk5iTjBqbTkwemIxZFM4T1NZN2U1ZXQ1ZzZUWnYzUUxvcnNYVlpm?=
 =?iso-2022-jp?B?MnBTWThKQUxEeU5RbXYvMGs0TmZsUDVzRjVDYk5MZEE5UllwTUg4Q1Na?=
 =?iso-2022-jp?B?ZDhuajNIOUh0UXF2SDNRUGxkTk15VE9ocmR3QTd1QVYrbG9HYUc3RTRk?=
 =?iso-2022-jp?B?dUt1L3NaUlRRL0ZPeTlXeEdFTWdGNERwZDBPd1hqdm84ekhGSm56elV3?=
 =?iso-2022-jp?B?V05ib2haeERxNHRybzNLMURCR29GSG5X?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?cFJ6eW9DN09acStOS2NZaW41T0tBcXhCODlIR3dMdGUwNWlreFk4b3hB?=
 =?iso-2022-jp?B?K2lKZ09PQ0xiTUhvRkE3N2RhR0JhdFQ2YWNXVEswbGlhOTdlbWoyQXhZ?=
 =?iso-2022-jp?B?bnIyVjJqT2tOdmNkdU9sdkR4OWZFWkhYbWY0ditaYjdZTTFkZFpyUmJy?=
 =?iso-2022-jp?B?NmlzbHNLUXJtNHVzanAwdFg1T1BydHIrMDRGU3drVFJsTzA2bDY4clpq?=
 =?iso-2022-jp?B?Um5sQXd3VjI0aW9BZzQ0Ni9iTGlVLzNWVkEzQzBYY0JIUGhLL1BoMEdt?=
 =?iso-2022-jp?B?djRBT1VOaXV0TGhZQVBXbFk1ODNZa0xib2hXREhFMDc3N1U3ajRudUVD?=
 =?iso-2022-jp?B?T0p2UlJBQnIwRmdYanRVZGI4cGNscklwdEZ0VVArVDVjeCsreVErRTJm?=
 =?iso-2022-jp?B?UlFVeXhWZ2NrcWx5ZkhnbnhyS2ZqbVJJbFNXR0NnaERGc3RNZnJXQWYw?=
 =?iso-2022-jp?B?NVZzdUVJS2RVS0tScGVhdVR2NFM5c0oxbHVTU3YzRXNDcGRGenk2NjRZ?=
 =?iso-2022-jp?B?YXJSSW81VEU3ckZTZTFEOW93MUxycWFNUEJrK01KYjZseEM1RG8yVmJC?=
 =?iso-2022-jp?B?ZTE3Vi80czVUUHFFcHR6WkpxYVpZNDRRYUFQaFAxa1g3MzkydkprOURw?=
 =?iso-2022-jp?B?TVB5RTY2VVFsNVNKODBYaTgwVUxyZHE0RU93a05mMXBDWXc3K3B3WUlx?=
 =?iso-2022-jp?B?T29ZRE1RNmVqczR4TWdUSXkvWjZ0c1JHUGZYVE9ETWg4bEJTUG9WSGtR?=
 =?iso-2022-jp?B?MzJiNUtrTlBSTlNVOHl0M21UR3Z0VUFudkZheDhidCtNcmc2MkZqdzJx?=
 =?iso-2022-jp?B?UXF5NHRlZjA1VFRud0RTS0ZSSE5xaU1lQmNWY2RsR0I5aTVxc0kxSi9r?=
 =?iso-2022-jp?B?SVBpdndIRy9FWjB4dTluN1FITEtpZndheW12aURKT0NsaXlUYkE2VmZw?=
 =?iso-2022-jp?B?TUY2ZTZUWlk1K3lEK2NiMzdwVjg4cXdUWG1tZnNzYytEUzR1dG00bFlL?=
 =?iso-2022-jp?B?SWxCSGdUL0JFMmN0RWthTzNwZlh2dHd3NW43OVQ2L09IRUQxbWV0MjNU?=
 =?iso-2022-jp?B?UGNhbXRnb1NlWlBOQ20xMTNDUWtkaGVEWXdZOU9adGdQNGRCU2NWQjFu?=
 =?iso-2022-jp?B?Uzk0OE44d1VCZkFqenQzeXhyVFBNMWlCTmJ1MFNpR3lhQnk0b0dNTE1m?=
 =?iso-2022-jp?B?dHZ2a0lnTXBMZ0lxWnpFN0hDRHhhYnFMMWtscktYLy9nZDFMNFJ0ZFo1?=
 =?iso-2022-jp?B?bXFBTVh3bDhwdjRXQjRlUGpXNjRjWVQ2amNLSktlay9tK0tmV2lBZS9Z?=
 =?iso-2022-jp?B?UW9adzVZZ21KTUZMMTRIV1BZUmRLN0NmSzFzZlV3N2lWdE1tRk9KRlRs?=
 =?iso-2022-jp?B?ZTJuTjk3MzlLbDd6QmI2WUNqOHNyODdxMlRxMERRd3dZYm54NW9aN2tY?=
 =?iso-2022-jp?B?SW9YVlFZbmFuUTZ6N2k3TGVabUt1ZVZlazl5ekMyYjVMMnNhYkJZa2xM?=
 =?iso-2022-jp?B?ZWh0WEJkZ05zWHgzRDhNeTlYSFVGWlR4eGZYVWJlOUV4VGh2bGlMSURE?=
 =?iso-2022-jp?B?bWw5a0JwZE1vZEdVT09wR0RsMFg5ekJlN3BkQ0E5UHh1UWZmZmVzYzQy?=
 =?iso-2022-jp?B?SUpCbDl3aVd5eVdwaHpIQ1ZqZ01QU1c3cUlxVGdBNlFEeURzRnI3aXpy?=
 =?iso-2022-jp?B?blF6WFFlOFAwRXBMZEdWMUEwNDBhSU1WN3VEREZYWE9vVmZYMGRMRitJ?=
 =?iso-2022-jp?B?dnJuOW9rK285ai9ZUHFrY291Rk82emw4RDlCK0FnTkRlSHVBR1RRbTlz?=
 =?iso-2022-jp?B?SXNpd3hTbmxObUZzSzVxVEhnb20wdjZaSXluc3NlQ3h2K21sb2tMM0Ur?=
 =?iso-2022-jp?B?azk3bWlLMFpLRlpTZHp1MDRtRVJ6eHhDZTJUYjFMQzFJMExaa1grZGg2?=
 =?iso-2022-jp?B?aUpGbllSaThVcE9EUy9xYkQvUWY5UHZGbXRtMUIwdmZqbjVwM1hFRnFD?=
 =?iso-2022-jp?B?dFlobTlvdnVCMmwzK2hRV3o5VDV5UVFKdWc0NEtmOVExUHVMWXl3ZmRx?=
 =?iso-2022-jp?B?WUg5UFlmWW1TRWZBL0pFK3hXY2F3NGFMU2hlRWV4czVCb1AwWEZiR1d4?=
 =?iso-2022-jp?B?TFpsU1RKc1dXeDVYQTVpNXYrQkpjdk9DSmI2S3dmUDRpTmR2THZ6S2J2?=
 =?iso-2022-jp?B?VHFKWEdBMC84RWd0Y2lwdERGanlHMFRjcVdlMWtMV1d3MFdid0VHeUJ5?=
 =?iso-2022-jp?B?Y1dOZUFLWHZVZitrYjNaNjVVQ21YdmhhYUs2bWpVWnRFY3M4aW1tdm1M?=
 =?iso-2022-jp?B?SFVtRlhtZ25oN3NpQUVGRlFxN1BRbXVOdnc9PQ==?=
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
	txIJe/lbb9CMYyXkellPebdrW3Jfh9P52lPxapD9UJ425hs8j2FxZthIBPnh26/dbJaTBDaaV+7zXsdePcTsOKbUrunDtg92k7Yh9x6ej0PMmjk1MG3/c1J24sibbek7RuH4O8vhg4uBt0C//Fwz4dVGhN87bjkaKx1iDEuKjvGG+rXNhcjG9KWIHPEjoB4RdOyKS+QMKYpzCJYKmcbDB5uWUWpet3wE2vlXjmuDp43PoQeGXU0PAwLoDGPnoHzwT+dtLEkkghR2oP6oT1I7MSOWZACYe8X07I2SI9ObNO0yEDl8Nlhcys428CfgHGXQK1jwQLzfJmBN/NfdHCYnT27ew1QcbjJmGvbWv6TLLZu+NAcCtsR7yzDzyrwu5xzrmwIBPaZAoR4JZEmntDWnkco5WNhzrwxZg2L/nb0UD4f1iL67Na4pM2de/PRbvmtNEpS2WQQM18XX1mtBI/lvXrww36vU49XhpXQOTFUuc0lM+EhzI6aG1ios9svRobVcM2DDHSygTQObMnEXNCtjOpIPDYZUBlex8iYvNJkS0543V9xHt6WTGu1/3LL3WH1/YRHB280UE9LYpfLrctyhUIG69sfBdmGIFReC/iUecc5Ttdusf1HwRuJEz3zLRalC
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f77a6a-5101-4176-0b85-08dd80636ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2025 23:31:10.6561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xI8fXMMzrLCo1AREeQ3K5A6mnB4dO7aYse1dA7Ee+Bz590YnK12k9x79sk9NBYW49gr58vRDIbbpLy0yI107ubt5LKObf9m8J/HnVsAQYlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15691

On Fri, April 18, 2025 8:16 PM Leon Romanovsky wrote:
> On Fri, Apr 18, 2025 at 02:07:49AM +0000, Daisuke Matsuda (Fujitsu) wrote=
:
> > On Thu, April 17, 2025 1:59 AM Leon Romanovsky wrote:
> > > On Mon, Apr 14, 2025 at 02:56:51PM +0200, Zhu Yanjun wrote:
> > > > On 14.04.25 12:16, Daisuke Matsuda (Fujitsu) wrote:
> > > > > On Sat, April 12, 2025 2:55 AM Leon Romanovsky wrote:

<...>

> > > At the end RXE is for development, testing and early prototyping. I c=
an't
> > > believe that we have developers who are using 32bits machines for suc=
h type
> > > of work in RDMA domain.
> >
> > Agreed.
> > Could you modify "RDMA/rxe: Enable ODP in ATOMIC WRITE operation"
> > in the tree and change Kconfig as you suggested?
>=20
> Just send separate patch, please.

Roger that.


