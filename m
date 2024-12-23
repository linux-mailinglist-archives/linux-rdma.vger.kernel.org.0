Return-Path: <linux-rdma+bounces-6698-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FF79FA920
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 02:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A10E1885C39
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 01:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D13316419;
	Mon, 23 Dec 2024 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="S5ChATTi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ADA1FB4;
	Mon, 23 Dec 2024 01:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734918909; cv=fail; b=G17FtL5mylpFZAJo+tLQ3D5g4wfoIfwb9At9gTbxvLSZMN6J9GgFPDy7UXd5uV3DPRyb806h+xxcduEvG6uxWQdMIAiIzo3PKxru15etK1piykY3/OfuOWnCYp3YCXnvSufu2boPFH/iSGm28w4FxngMW9VOF/NEGZaDEOpsxeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734918909; c=relaxed/simple;
	bh=BiS1lOTQranBl4AL+5yGJrmfVAN0LXk1HSk8lwYded8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U/2jKvRnz4GnSCEF7RX/umd26DR4fAJDOH/eT1L4jCcgFcWmoh566Wg+WDiiPeQDE+ebbGvw222sbEwwmjv4AyJ/bGCC3YwWOW2kBJlkN8iMMiMOyLLZbIYUh9WkCIzFW18GUh3338zQs3oUyJi8QTirVOqIXAmBED15GdWVcTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=S5ChATTi; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1734918907; x=1766454907;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BiS1lOTQranBl4AL+5yGJrmfVAN0LXk1HSk8lwYded8=;
  b=S5ChATTij7Jg5yg/yDnUxtzvHyynduyw68EZZg9zOXysIdDvIdCUBAUA
   56H3voFoEyOaS+AwsyTUA0bfqXYhH06CMTHqu1w1F9PhVX8Jy9SinXfKF
   y+AAfxgwd/vAkfVTlAa4z9y0qRl9wbvB35+6J1J4kCKYF37jtHLZ41sdn
   Ri3+VRkk/t4C1GfzXqVIiOldO2Irwz5JazKiz2fJjMUZ4M86FNSDBsN4q
   23fNZAsXgnDMi176uYfd/oVxa95X04xIwVeG3EKuWH+rbwrG9OhC3GbU1
   jR1jyrSnhAgTRetR23wRxHJ1qA3BxiqjQbULBYtjScdppDJtPcKvtMs6Z
   Q==;
X-CSE-ConnectionGUID: fasnqGpoTUahd+arupPrAQ==
X-CSE-MsgGUID: gDp9b26UQt6VLkliwMSL6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="52068389"
X-IronPort-AV: E=Sophos;i="6.12,256,1728918000"; 
   d="scan'208";a="52068389"
Received: from mail-japaneastazlp17011028.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 10:54:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwZySN8Bon795k2tcr8fpl0oYF+RS4qeXrwKcX7+9qpoinCHP4d4u5QQejWDGY2oE6UkbzeoEQ6xwz4Ery/jpGR8m1EjEpCs7hxadU+BoH1DMIRQF5TS2z/QB5lAAILVaJuld91NlQCoMc+RM8mxcSyTq4hlyQ8zry50on0dXWmXyVqDBPzjpTLsfRwK6XwSWC2P40JEVQ5plaETTmPgZ3Wkz2a4Gb+7OBhq7T8hLz/ym6rF7zdukXhjK0BHVMnDgqyHcEAtigx1o86PPllQwMMqUCHVcIsYm1iQMutgouUqvS1qADCALCQMuH/Z/vgoW/ZdSLmTTG9GFXNxEFI/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiS1lOTQranBl4AL+5yGJrmfVAN0LXk1HSk8lwYded8=;
 b=sYvtl8HOSG+uqHj6O5KjKx1HD9UzlK9hIFC7rrL8/uCyoUrVxllE01LzQny6Qx45mQLhlDSk32/bc7NDwnDWutgPAbxUZhMRJFRqfhAMVbAaVCleb7bpWIICx4COybQpbtMo8ByMi31Cm/0vn/n0GakYz/P31Vl73u3HMAKGkI37T+P80X3iZnCepvBgkGxNk10hbwvOjcrxNOUUkmrt8lT8L80psev888RjuiyMxR/UehyXPDD2lhVCxjFPWXfdq+AWrPYA9eBmD74I2jtwXOk4PHtELClOphRXUDVDeuJ+odC8Kg4HRK5SztXGKGyd+McvVzk0GmtJ0+xaCN8Snw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by OS3PR01MB6289.jpnprd01.prod.outlook.com (2603:1096:604:f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Mon, 23 Dec
 2024 01:54:54 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%4]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 01:54:54 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Joe Klein' <joe.klein812@gmail.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rpearsonhpe@gmail.com"
	<rpearsonhpe@gmail.com>, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: RE: [PATCH for-next v9 0/5] On-Demand Paging on SoftRoCE
Thread-Topic: [PATCH for-next v9 0/5] On-Demand Paging on SoftRoCE
Thread-Index: AQHbUsdVttNAApocPUWbNvG68fDe4rLyh0MAgACNdPA=
Date: Mon, 23 Dec 2024 01:54:53 +0000
Message-ID:
 <OS3PR01MB98654FDD5E833D1C409B9C2CE5022@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
 <CAHjRaAeXCC+AAV+Ne0cJMpZJYxbD8ox28kp966wkdVJLJdSC_g@mail.gmail.com>
In-Reply-To:
 <CAHjRaAeXCC+AAV+Ne0cJMpZJYxbD8ox28kp966wkdVJLJdSC_g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NDc3NTljMDQtN2I4NS00OGM0LTljNjctZDRmYzEyOWEx?=
 =?utf-8?B?ZGVjO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjQtMTItMjNUMDE6NTE6MDlaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|OS3PR01MB6289:EE_
x-ms-office365-filtering-correlation-id: 3fcd8c07-f536-4e80-fb6e-08dd22f4cb9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3FaNWFPbnNzb1gwekk4SHFGd0xzb1JuR2p0UXIyeEtJZ2VTQkNRVWtJOWdu?=
 =?utf-8?B?aktzWHVtNUQ0ZjZFZTJIOUJNaHNadmRZMXhWTzlmTjJEa01UdDdLTEM0a0I5?=
 =?utf-8?B?a2w1WXBsZTJMeUt6SXdBeU1pZ0RoME9pVjFCeTRUS1diWUxZUFNFVlQwU0NJ?=
 =?utf-8?B?b2E5RjNMU1FnU1NpL3Z4YkJqM1VXc2NvZjhRNHF4KzJYdjB0YlMxZ3NkWVJm?=
 =?utf-8?B?eDJheWpQRExUMDUwdzRGRnFoaUpNL2NNTmxEb0pCRE54K2ViaHdHUTN1NUlG?=
 =?utf-8?B?Z3YwUG1xSnRwQTM4K2NmRVNnMkdhZnlXSXRsT291ZW53K1Q4Y2ZYd0l2eEwx?=
 =?utf-8?B?S3NjRXYyMmRTYzZLTnVZTmR6OWV0Z0VmR0xVYnEvODNCQUh4QVJnVlpjWGpM?=
 =?utf-8?B?WjlXWTRQNDNubGV5MjFTOU4wT2ZRU2xNOVNMK21pRWtFamlVMzBiNHpWTFdt?=
 =?utf-8?B?Ui81SUgyQUtDSjIrN2pSc0xRenIzV3FwNWo2M2dXNjNITTlqc3Y1Q202NE9z?=
 =?utf-8?B?MEd1enh3ODN4emNCVmtTR3ZJUnhHNWlweEV1bEkyVnNWRHA3ZVQxcFN6TFF2?=
 =?utf-8?B?c1d2cDUzUlVlTkVIOSsreWc3Yjl2ajYvcVNlMGtCM3IzT0VlU3paSmduOFhh?=
 =?utf-8?B?dFV3Q1pyVVovMXkwVFZnamwrRDlPVlZ1R0ljSW5ONVc4SDA0Z0F0NUkySW9D?=
 =?utf-8?B?NkIzNjdFWWJ1T3VyUzdoRHlJQ2llVzVoNWdDVGUzYTlOdjMxdUhCWGlqOU80?=
 =?utf-8?B?eStyY3VpLy95RUtYUXBiaE9ZRUZvUE5Sb3BZOTJDaVVBV2xVNTFQYlJPNytj?=
 =?utf-8?B?QW5JNUtPRzl5V0FvTlJaZHlLUnZEKzVVUkQ1ak9pdWpNSWFKcFZLcFRaN3pw?=
 =?utf-8?B?d1MxRnAvRjJlM0NJWWN4M0QrbU1QVU5aWmExTTJXcVoyQWtxN2Jqdy9mR2VO?=
 =?utf-8?B?bU16VkVvdnM0bm1DZTJZWHRTMktjNzdtSXNzZndod2tJdHJhaEZ1MGZvbTJr?=
 =?utf-8?B?YnY4QlRGazQ3aTcyTGhxaGJwQUo4bnlxWFNhazJzV3VtTThLdjZqYnhFT2tm?=
 =?utf-8?B?Qm1zWm8yaGhiaWdEN3NrMDJPbzlDZmFnUjMwYUVITllTQ2I4c21mYzdPdkF4?=
 =?utf-8?B?bVU0Z3Zidk9DZ0xOalVFeXNhL0lKQi9ENkJ0dUdubEttM1pDQWVTTmVod2Rj?=
 =?utf-8?B?Wlk1VVlZZ0hKSldOMDNqaXNtQXczOHppOVRYMjB4Ujc1WmZPVHo5RU9tVkZr?=
 =?utf-8?B?Y1o2Vm5XUjNFZE1JcEI5d3hnSEdWVG8wZVowL1Jrb29qM1p6SlNxaklETDFP?=
 =?utf-8?B?NVhXdENQNDQ4THVsSWl4cnVrdnpXaytjd1lhVDMxUXVQRTQ2QnNqQTkvNDMz?=
 =?utf-8?B?N1lPOGlWWlZibGo2d0EyWktFcCswODN6ZjEvcCs1c09FNjArais0MGhjakc0?=
 =?utf-8?B?dmJ2MHRrUHBvNVN2aUFlNnFnMkh4cDJ1ajludkJnZ1ZZa3dmdFk2UEplYmYw?=
 =?utf-8?B?eUlpTkc4bWF6NitPenh2WnNuZmg2bnIzZHBmbFBlMEpRWjFNbGx4UFA2eDBJ?=
 =?utf-8?B?dUhZNkw3SVVYUjR6elJ2dGdBTWRzTlRzZkhYM0t3S0xDQit5bWV3aVVKc1h5?=
 =?utf-8?B?QzR3d25hcVczQW1renlZRjVQMzlrTzM3ck1yRS93d3RMejk0QmRiTFlrRkNS?=
 =?utf-8?B?d08yaVRqR2V6MWJXbk91SnJOK1VXSHZ1L0tLeXR2b1RnMGxUZnJtaTZoblZQ?=
 =?utf-8?B?TTlqdEN0cTM5RFMyWjJXT0Y3bmVveDdFYVdhUlNpT3MvamZ0ME5yUlpLQVJx?=
 =?utf-8?B?QVpWQTdBS1NjdjRYUkcvWHZ1VlRKSzRDSWhSeHllVVc1SWN5QXduSFV0K0d4?=
 =?utf-8?B?TTBkYXpkeENiNXZvU21yKzU2L1Y3YnUxWDJLWXd1K0lXWUFhZml5MEJKTXIv?=
 =?utf-8?B?QlJ3N1k3VWhTS2ROL1c3cWswQ3pZRzJ1emRSN2ZkZGNQUlpJcnI0NkZRVlBI?=
 =?utf-8?B?elgybjNDUnlBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aktBeGpRclJpakQwTzl0WDlSQnZoblcwN1JTT0hRV1dqUjZTMmc3L3JMR3Q1?=
 =?utf-8?B?ZFJpUjk0K1cxamlMZUIxU0FaQ2s4dzJ4V2dVKzlHQ1ZJNENTN2trRXpZeE04?=
 =?utf-8?B?R3N4YjIwSUNaQXBxb1JqUzU1Y2h1SzY1TmYzdmRmTEY1WG16bFJwOE84MW41?=
 =?utf-8?B?NDBBYzBJTENHbHRXT2NBMWRpUVBWVGJ2OE0ya0xTWkFkQmV3aFNGS2hLVEJC?=
 =?utf-8?B?VDdjdXVEQTluL29NT2p4bTdsMXRTL3I1aysrRVdGWW9FTUtmSTNPUFB0RHJ5?=
 =?utf-8?B?bndKTUF3SGlHRG5BMmluUDJncTROZ3NLQm5VbVU2NW0vbVB5K1N0M0pMMHlt?=
 =?utf-8?B?OFUzT0ZIODgwbHFSenFZek5vdjhjZUo5bzdEWjZiNlFpbGxmcWFUQm5uaTNj?=
 =?utf-8?B?Y1o2Z0Z1aVBFRThCZVFHdTJWbXNJeE1DTlZXV2c1cncwWW1BOWNocFZrcTlW?=
 =?utf-8?B?OTYwK0J2VVd3WmZyaWYwa3R3MzFwbmhUcnJORW83ckFVN2E2YkQzMTV2eE01?=
 =?utf-8?B?Y0xUaTJBNk9IZ2JibUVGZWcxMHFwa3NyV2VyOWYvWllEMjBrYlFRN1RmbExK?=
 =?utf-8?B?R1FjSm1haGt6VUdSYjFUUmlNZjZqTWlNVUZUdGxHTTJ5TkNoL1MyQ1BWZG5p?=
 =?utf-8?B?a1plRDJjVlR5bXg4V0ZVYnMwdVduR2JXdm1PaG13dG0rcUhtMXptRHN1TFZ3?=
 =?utf-8?B?K2ZOSFdFaUEzdnR6ZytIdERTaFdjS0QwRXRhdzJSa1BoR0ozNzVDa1d2OUFi?=
 =?utf-8?B?ckZhY3BqdmpmbnBYUko3SDFFdVdiSFByTEVzKzJ1Y2xqc0p6MUlQVitSZlJk?=
 =?utf-8?B?b3JLSXNKYjdTc2c5dVJYTHNtL0IrR21zRmxIT0xlTytDTng2cmhHQVF6MWJS?=
 =?utf-8?B?UG9IVncvRW81bWlsSnZUS0tWRm5nSVAzY1dvbWxUVzlLQzY2Zy8zVmRxMzlQ?=
 =?utf-8?B?aFhpZmJCZGQrYmdYVDhKRDU4dHg4akpTYkFUVk4zSEM1ampTVlg0N3NNblN6?=
 =?utf-8?B?Z1dVci9UUW92bE1kcmZFc0dSUFRsSWZFU0sza3F6eFIwVUkvblJMc3lQYkYw?=
 =?utf-8?B?Mmp4KzdXV0pGR29pVEt2aG9sWHdROHJzeGVMVk5PaHQ2c0tZclV4aXJsSjdn?=
 =?utf-8?B?OTZWU0FQcm5GOURnL2VpRmtxWGcwK1I1dDJkeDNHL1VKRlFYZzRZMFZjZ2Ey?=
 =?utf-8?B?QzF3Mm9aMzAyM3lkaENRbFRDbDlVL0ozQmw1Sld0c3ZKN1A2L25zVUt6dGJK?=
 =?utf-8?B?eTZoazEweTZMOVpoSm00V3RQemtFT3ZZTWZKTlB2RkJVaDFKMllnY2htenBL?=
 =?utf-8?B?eTlKcFJMd1Y2dUprQWdOY2RnY3BkTmRoTHQ1eFFPSDVxZFJHTXlKdWpnc3Ex?=
 =?utf-8?B?SjV2eW5uSDh1WXZ1TGZNUkJuVDMzQTJrY2x2ZnV6aWFZSCtMbDcwZFVZaGp3?=
 =?utf-8?B?Y2IwZTdxczFmRG9zMjRjMjhRaVIrSUlNcFFGMmhWa2Z6cElFbTZkUHNuTnNW?=
 =?utf-8?B?WUM5UmlseUY4cTF3VVZyUGRqK3VQSk5wWnczZDA3VEVYVjd5WWptclUwREp4?=
 =?utf-8?B?K1VkQjNSaGd1SDhQV2ZSUXpqOXpDMFF5QWZXd2VBakZnNkdsSGluNXJFUnVZ?=
 =?utf-8?B?RGtOVXorODcxeDAxVk5sYmIxYzJUN25Ubkw1NXBBNGp0RU1DNXUzSndCdkdl?=
 =?utf-8?B?OTN5ZHhydjYwRDluWjMvYnAwdVQyc0h0ZVpCNEVtejV4QjBObllLV1BTaHhH?=
 =?utf-8?B?Q1ViclpwOENiOTVaaE56QlN6MWhoQlR1RGdFZTNKM0xzeEhkaGZoeXg2djQ3?=
 =?utf-8?B?QWMwYjYySmo1SmkyTlFwa25EVlY2U2NWcWYvQjkrOThDcXB4d0NQU0kzUDdl?=
 =?utf-8?B?WDUyNkxOaVVqckVBYUJyQ3FBWFhFZWVyTW9VcGJrLzZoYTBsMk14ZUlMQkZV?=
 =?utf-8?B?N0FPcWkyRU9hYThzYmMyOWlOWVhON0M5MllUVGpNbGdKTjZLVWtRYzc5TG8z?=
 =?utf-8?B?NTlhaWZ3d2xyWFM5b1dTSk9GYkloSEZsZHZJL0NJMnpsVHVhRm5ValdvM25T?=
 =?utf-8?B?TmY1ODBpWG90MVMzY2s5b3Rmb09rSVlaQ0hZMVBjcFJzc0dBejgySEhadEhu?=
 =?utf-8?B?Y0xrRG9OZDJ0YmE0VEd1ME11aERmODIraWpCOHNFREhScVhpbVpDQldCTmNi?=
 =?utf-8?B?c0E9PQ==?=
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
	tAOj4deaJmQSMhh3GLo5AuY0S8BudDPRZlf2xYpThjFHP022T7MRkmYHXXEKRII80XxVcE/7O/nXaFDAAvpQjU2XA6ERxq32/CWaTBCyRiwgfFuuzp9Fh9Cq0jCJN5M+0huTdSRtPT2wMFtbazi6SOa6fwkBgY9Jm9Auya2TmHinO6226EN4RpR3mBu6HAKRhTOc5BxwynQ3+p2SXbcoMshTfPNEO9ZujPobiHtbt8y5Whm+H/LmkGRECw3AwByKSb0r7wJAY/THR/t0I6VbtI9ey3cdUQlddEFtm6bEuZ8CYQjrlZ9VS9GeQhnlyr56dM0ge/5squTq8id0VdMVFDe6/7NyblOZGvk83ly4CegAN+EucrbxKcybbx7wcndRRTid+jcBz6WXNvoFfBYGG8RYMVGuB5SdpFsx07GSEBew4cfTTo25jLaSBcWoVJqoFutSEbe1EACa9a3HwDyTzvnUZcOdU3Zdvt6WCqdZuMWqPqfscjCn8BCTA5ZlNAYaXdpoJKCOptX+FoMy6OmVnHmnFOd6K6gaZKn9Tl9tI+JqEqygRQH7bvFP3E4kCNPBiv6YTzw5Zl7iJV9eSMQj4sK1d6E+/iZR7rKLHnz40k2GMRmOCC6eP2/gQFnSTb7F
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcd8c07-f536-4e80-fb6e-08dd22f4cb9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 01:54:53.9655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 750BXDiKeJctyrQig9yKHLGP8wHjbIfOX6RFAz3OkBnHOcz9Q/OZVjkXJMPI41rieEC5/2vULA+sikYghGgRHQg3zt3rXEkLY2yvVMIeGOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6289

T24gTW9uLCBEZWMgMjMsIDIwMjQgMjoyNSBBTSBKb2UgS2xlaW4gPGpvZS5rbGVpbjgxMkBnbWFp
bC5jb20+IHdyb3RlOg0KPiBXZSBoYXZlIHRlc3RlZCB0aGlzIHBhdGNoZXNldCBhbmQgaGFkIGEg
bG90IG9mIHByb2JsZW1zLCBldmVuIHdpdGhvdXQgdXNpbmcgdGhlIE9EUCBvcHRpb24gaW4gc29m
dHJvY2UuIEkgZG9uJ3Qga25vdyBpZiBvdGhlcnMgaGF2ZSBkb25lIHNpbWlsYXIgdGVzdHMuIElm
IHdlIGhhdmUgdG8gbWVyZ2UgdGhpcyBwYXRjaHNldCBpbnRvIHVwc3RyZWFtLCBpcyBpdCA+IHBv
c3NpYmxlIHRvIGFkZCBhIGtlcm5lbCBvcHRpb24gdG8gZW5hYmxlL2Rpc2FibGUgdGhpcyBwYXRj
aHNldD8NCg0KSGkgSm9lLA0KDQpDYW4geW91IGNsYXJpZnkgdGhlIHRlc3QgYW5kIHRoZSBwcm9i
bGVtcyB5b3Ugb2JzZXJ2ZWQ/DQpJIHdvbmRlciBpZiB5b3UgdHJpZWQgdGhlIHRlc3Qgd2l0aCB0
aGUgbGF0ZXN0IHRyZWUgV0lUSE9VVCBteSBwYXRjaGVzLg0KDQpBcyBmYXIgYXMgSSBrbm93LCB0
aGVyZSBpcyBzb21ldGhpbmcgd3Jvbmcgd2l0aCB0aGUgdXBzdHJlYW0gcmlnaHQgbm93Lg0KSXQg
ZG9lcyBub3QgY29tcGxldGUgdGhlIHJkbWEtY29yZSB0ZXN0Y2FzZXMsIGFuZCAnc2VnbWVudGF0
aW9uIGZhdWx0JyBpcyBvYnNlcnZlZA0KaW4gdGhlIG1pZGRsZSBvZiB0aGUgZnVsbCB0ZXN0IHJ1
biwgd2hpY2ggZGlkIG5vdCBoYXBwZW4gYmVmb3JlIE9jdG9iZXIgMjAyNC4NCg0KSGVyZSBhcmUg
dGhlIGRldGFpbHMgb2YgdGhlIGlzc3VlOg0KPT09PT0gdGVzdCBsb2cgPT09PT0NCnVidW50dUBy
ZG1hLWRldjp+JCBzdWRvIHJkbWEgbGluayBhZGQgcnhlX2VuczMgdHlwZSByeGUgbmV0ZGV2IGVu
czMNCnVidW50dUByZG1hLWRldjp+JCBjZCByZG1hLWNvcmUNCnVidW50dUByZG1hLWRldjp+L3Jk
bWEtY29yZSQgdW5hbWUgLXINCjYuMTMuMC1yYzErDQp1YnVudHVAcmRtYS1kZXY6fi9yZG1hLWNv
cmUkIHB3ZA0KL2hvbWUvdWJ1bnR1L3JkbWEtY29yZQ0KdWJ1bnR1QHJkbWEtZGV2On4vcmRtYS1j
b3JlJCAuL2J1aWxkL2Jpbi9ydW5fdGVzdHMucHkNCi4uLi4uLi4uLi5zcy4uLi91c3IvbGliL3B5
dGhvbjMuMTIvX3dlYWtyZWZzZXQucHk6Mzk6IFJlc291cmNlV2FybmluZzogdW5jbG9zZWQgZmls
ZSA8X2lvLkZpbGVJTyBuYW1lPScvdG1wL3RtcGU3bnNpdG92JyBtb2RlPSdyYisnIGNsb3NlZmQ9
VHJ1ZT4NCiAgZGVmIF9yZW1vdmUoaXRlbSwgc2VsZnJlZj1yZWYoc2VsZikpOg0KUmVzb3VyY2VX
YXJuaW5nOiBFbmFibGUgdHJhY2VtYWxsb2MgdG8gZ2V0IHRoZSBvYmplY3QgYWxsb2NhdGlvbiB0
cmFjZWJhY2sNCi91c3IvbGliL3B5dGhvbjMuMTIvX3dlYWtyZWZzZXQucHk6Mzk6IFJlc291cmNl
V2FybmluZzogdW5jbG9zZWQgZmlsZSA8X2lvLkZpbGVJTyBuYW1lPScvdG1wL3RtcGlkODVjYm91
JyBtb2RlPSdyYisnIGNsb3NlZmQ9VHJ1ZT4NCiAgZGVmIF9yZW1vdmUoaXRlbSwgc2VsZnJlZj1y
ZWYoc2VsZikpOg0KUmVzb3VyY2VXYXJuaW5nOiBFbmFibGUgdHJhY2VtYWxsb2MgdG8gZ2V0IHRo
ZSBvYmplY3QgYWxsb2NhdGlvbiB0cmFjZWJhY2sNCi4uLi4uLi5zc3Nzc3MvdXNyL2xpYi9weXRo
b24zLjEyL2NvbnRleHRsaWIucHk6MTQxOiBSZXNvdXJjZVdhcm5pbmc6IHVuY2xvc2VkIGZpbGUg
PF9pby5GaWxlSU8gbmFtZT0nL3RtcC90bXA5cGdiN3pvOCcgbW9kZT0ncmIrJyBjbG9zZWZkPVRy
dWU+DQogIGRlZiBfX2V4aXRfXyhzZWxmLCB0eXAsIHZhbHVlLCB0cmFjZWJhY2spOg0KUmVzb3Vy
Y2VXYXJuaW5nOiBFbmFibGUgdHJhY2VtYWxsb2MgdG8gZ2V0IHRoZSBvYmplY3QgYWxsb2NhdGlv
biB0cmFjZWJhY2sNCnNzc3MuLi4uLi4uLi4uLi4uLnNzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nz
LnNzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nz
c3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nz
c3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3NzLi4uLi4uLi5zc3Nzc3Nzc3Nzc3Nzc3Nzc3Mv
dXNyL2xpYi9weXRob24zLjEyL193ZWFrcmVmc2V0LnB5OjM5OiBSZXNvdXJjZVdhcm5pbmc6IHVu
Y2xvc2VkIGZpbGUgPF9pby5GaWxlSU8gbmFtZT0nL3RtcC90bXBhdGUxbG9jaScgbW9kZT0ncmIr
JyBjbG9zZWZkPVRydWU+DQogIGRlZiBfcmVtb3ZlKGl0ZW0sIHNlbGZyZWY9cmVmKHNlbGYpKToN
ClJlc291cmNlV2FybmluZzogRW5hYmxlIHRyYWNlbWFsbG9jIHRvIGdldCB0aGUgb2JqZWN0IGFs
bG9jYXRpb24gdHJhY2ViYWNrDQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6DQog
IEZpbGUgInBkLnB5eCIsIGxpbmUgMTIwLCBpbiBweXZlcmJzLnBkLlBELmNsb3NlDQpweXZlcmJz
LnB5dmVyYnNfZXJyb3IuUHl2ZXJic1JETUFFcnJvcjogRmFpbGVkIHRvIGRlYWxsb2MgUEQuIEVy
cm5vOiA5LCBCYWQgZmlsZSBkZXNjcmlwdG9yDQpFeGNlcHRpb24gaWdub3JlZCBpbjogJ3B5dmVy
YnMucGQuUEQuX19kZWFsbG9jX18nDQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6
DQogIEZpbGUgInBkLnB5eCIsIGxpbmUgMTIwLCBpbiBweXZlcmJzLnBkLlBELmNsb3NlDQpweXZl
cmJzLnB5dmVyYnNfZXJyb3IuUHl2ZXJic1JETUFFcnJvcjogRmFpbGVkIHRvIGRlYWxsb2MgUEQu
IEVycm5vOiA5LCBCYWQgZmlsZSBkZXNjcmlwdG9yDQpzc3NzVHJhY2ViYWNrIChtb3N0IHJlY2Vu
dCBjYWxsIGxhc3QpOg0KICBGaWxlICJwZC5weXgiLCBsaW5lIDEyMCwgaW4gcHl2ZXJicy5wZC5Q
RC5jbG9zZQ0KcHl2ZXJicy5weXZlcmJzX2Vycm9yLlB5dmVyYnNSRE1BRXJyb3I6IEZhaWxlZCB0
byBkZWFsbG9jIFBELiBFcnJubzogOSwgQmFkIGZpbGUgZGVzY3JpcHRvcg0KRXhjZXB0aW9uIGln
bm9yZWQgaW46ICdweXZlcmJzLnBkLlBELl9fZGVhbGxvY19fJw0KVHJhY2ViYWNrIChtb3N0IHJl
Y2VudCBjYWxsIGxhc3QpOg0KICBGaWxlICJwZC5weXgiLCBsaW5lIDEyMCwgaW4gcHl2ZXJicy5w
ZC5QRC5jbG9zZQ0KcHl2ZXJicy5weXZlcmJzX2Vycm9yLlB5dmVyYnNSRE1BRXJyb3I6IEZhaWxl
ZCB0byBkZWFsbG9jIFBELiBFcnJubzogOSwgQmFkIGZpbGUgZGVzY3JpcHRvcg0KVHJhY2ViYWNr
IChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOg0KICBGaWxlICJwZC5weXgiLCBsaW5lIDEyMCwgaW4g
cHl2ZXJicy5wZC5QRC5jbG9zZQ0KcHl2ZXJicy5weXZlcmJzX2Vycm9yLlB5dmVyYnNSRE1BRXJy
b3I6IEZhaWxlZCB0byBkZWFsbG9jIFBELiBFcnJubzogOSwgQmFkIGZpbGUgZGVzY3JpcHRvcg0K
RXhjZXB0aW9uIGlnbm9yZWQgaW46ICdweXZlcmJzLnBkLlBELl9fZGVhbGxvY19fJw0KVHJhY2Vi
YWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOg0KICBGaWxlICJwZC5weXgiLCBsaW5lIDEyMCwg
aW4gcHl2ZXJicy5wZC5QRC5jbG9zZQ0KcHl2ZXJicy5weXZlcmJzX2Vycm9yLlB5dmVyYnNSRE1B
RXJyb3I6IEZhaWxlZCB0byBkZWFsbG9jIFBELiBFcnJubzogOSwgQmFkIGZpbGUgZGVzY3JpcHRv
cg0KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOg0KICBGaWxlICJwZC5weXgiLCBs
aW5lIDEyMCwgaW4gcHl2ZXJicy5wZC5QRC5jbG9zZQ0KcHl2ZXJicy5weXZlcmJzX2Vycm9yLlB5
dmVyYnNSRE1BRXJyb3I6IEZhaWxlZCB0byBkZWFsbG9jIFBELiBFcnJubzogOSwgQmFkIGZpbGUg
ZGVzY3JpcHRvcg0KRXhjZXB0aW9uIGlnbm9yZWQgaW46ICdweXZlcmJzLnBkLlBELl9fZGVhbGxv
Y19fJw0KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOg0KICBGaWxlICJwZC5weXgi
LCBsaW5lIDEyMCwgaW4gcHl2ZXJicy5wZC5QRC5jbG9zZQ0KcHl2ZXJicy5weXZlcmJzX2Vycm9y
LlB5dmVyYnNSRE1BRXJyb3I6IEZhaWxlZCB0byBkZWFsbG9jIFBELiBFcnJubzogOSwgQmFkIGZp
bGUgZGVzY3JpcHRvcg0Kcy4uLi5zc1NlZ21lbnRhdGlvbiBmYXVsdCAoY29yZSBkdW1wZWQpDQo9
PT09PT09PT09PQ0KDQo9PT09PWRtZXNnPT09PT0NClsgIDE0Ny40NjQyNDNdIHJ4ZV9lbnMzOiBx
cCMyMSBtYWtlX3NlbmRfY3FlOiBub24tZmx1c2ggZXJyb3Igc3RhdHVzID0gNA0KWyAgMTQ3LjQ3
Mzg0M10gcnhlX2VuczM6IHFwIzIzIG1ha2Vfc2VuZF9jcWU6IG5vbi1mbHVzaCBlcnJvciBzdGF0
dXMgPSAxMA0KWyAgMTQ3LjQ4NDU0MF0gcnhlX2VuczM6IHFwIzI1IG1ha2Vfc2VuZF9jcWU6IG5v
bi1mbHVzaCBlcnJvciBzdGF0dXMgPSA5DQpbICAxNDcuNDk0NTQxXSByeGVfZW5zMzogcXAjMjcg
bWFrZV9zZW5kX2NxZTogbm9uLWZsdXNoIGVycm9yIHN0YXR1cyA9IDEwDQpbICAxNDcuNTI0MDgw
XSByeGVfZW5zMzogcnhlX2NyZWF0ZV9jcTogcmV0dXJuZWQgZXJyID0gLTIyDQpbICAxNDcuNTc0
MTk3XSByeGVfZW5zMzogY3EjMjYgcnhlX3Jlc2l6ZV9jcTogcmV0dXJuZWQgZXJyID0gLTIyDQpb
ICAxNDcuNjA1NzE5XSByeGVfZW5zMzogcnhlX2NyZWF0ZV9jcTogcmV0dXJuZWQgZXJyID0gLTk1
DQpbICAxNDcuNjA2NDU0XSByeGVfZW5zMzogcnhlX2NyZWF0ZV9jcTogcmV0dXJuZWQgZXJyID0g
LTIyDQpbICAxNDguODAzMTMxXSByeGVfZW5zMzogcXAjNTEgbWFrZV9zZW5kX2NxZTogbm9uLWZs
dXNoIGVycm9yIHN0YXR1cyA9IDEwDQpbICAxNDguODMxNTg3XSByeGVfZW5zMzogcXAjNTcgbWFr
ZV9zZW5kX2NxZTogbm9uLWZsdXNoIGVycm9yIHN0YXR1cyA9IDEwDQpbICAxNDguODQxNjI3XSBy
eGVfZW5zMzogcXAjNTkgbWFrZV9zZW5kX2NxZTogbm9uLWZsdXNoIGVycm9yIHN0YXR1cyA9IDEw
DQpbICAxNDguODUxNzE5XSByeGVfZW5zMzogcXAjNjEgbWFrZV9zZW5kX2NxZTogbm9uLWZsdXNo
IGVycm9yIHN0YXR1cyA9IDEwDQpbICAxNDkuMTA0MjIzXSBweXRob24zWzE3MDJdOiBzZWdmYXVs
dCBhdCBkMCBpcCAwMDAwN2ZmOTVjZWQxNmM3IHNwIDAwMDA3ZmZmNWU3NzVkZTAgZXJyb3IgNCBp
biBsaWJpYnZlcmJzLnNvLjEuMTQuNTYuMFtlNmM3LDdmZjk1Y2VjYTAwMCsxNDAwMF0gbGlrZWx5
IG9uIENQVSAyIChjb3JlIDAsIHNvY2tldCAyKQ0KWyAgMTQ5LjEwNDIzNV0gQ29kZTogMDAgMDAg
YzEgZTAgMDQgOGIgYmYgMDggMDEgMDAgMDAgNDggOGQgNTMgMjAgNDggYzcgNDMgMjggMDAgMDAg
MDAgMDAgODMgYzAgMTggYzcgNDMgMzQgMDAgMDAgMDAgMDAgYmUgMDEgMWIgMTggYzAgNjYgODkg
NDMgMjAgPDQ5PiA4YiA4MCBkMCAwMCAwMCAwMCA4YiA0MCAxMCA4OSA0MyAzMCAzMSBjMCBlOCAw
NSA5OSBmZiBmZiA0MSA4OQ0KPT09PT0NCg0KSWYgeW91IGVuY291bnRlciBhbnkgcHJvYmxlbXMg
dGhhdCBzdXJlbHkgY29tZXMgZnJvbSBteSBPRFAgcGF0Y2hlcywgcGxlYXNlIGxldCBtZSBrbm93
IHdoYXQgc3ltcHRvbXMgeW91IGFyZSBzZWVpbmcuDQpJIHdvdWxkIGFsc28gYXBwcmVjaWF0ZSBh
bnkgaGVscCB5b3UgY2FuIG9mZmVyIGluIGZpeGluZyB0aGUgdXBzdHJlYW0gaXNzdWUuDQoNClRo
YW5rcywNCkRhaXN1a2UNCg0K

