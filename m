Return-Path: <linux-rdma+bounces-8122-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E394FA45BE3
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 11:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9623A12DF
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 10:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6D013C9A3;
	Wed, 26 Feb 2025 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="NoboxSL5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9F42459FE
	for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566031; cv=fail; b=MFGgqOH/IqGBwsk1Eh3izWUUi09bOZih2SkMNEM4BuoluW2YeECYWt8mDJbJiMyXXknjCn/dilneIxxxrokaWt4AjXE3GkwnJGtnAo727cBS+GTg+LuRgt8qm0b4zhS0GO138PHSRo5d77cqzKQBaizhgXqWaK837AcnrqhcKac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566031; c=relaxed/simple;
	bh=RK6G2zDZQOcxJg5DKs8ebA7YytEo4QTaq2S/lxCZFU4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mzrDQqCDyEUWz0+rLOHmkt30QItDPvB/kyNhy49zDKgE3WGaHZdxaxCGnDhIVxhCOFG+oRu1SQGs+yACNO0HV1tVpHho3qUdxJ/OxHeynjCzd59b+IaWKGapXJchb0aAkca0KSKqUTdI78rWxJR+bzB5idKxaDeKUjNLChp7G50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=NoboxSL5; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1740566030; x=1772102030;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=RK6G2zDZQOcxJg5DKs8ebA7YytEo4QTaq2S/lxCZFU4=;
  b=NoboxSL5ISJXzyUMqR/L9RdRZB9ryBNt4JZWblMxRWaBi28nTdh6jJRG
   wXGj9TUrCJZ2/tYd+Fy+uPxDcRfiHbKkIR/ZXsMHqTn7uJ7h7vfPvZ4U5
   0X6wo4fFVyDoMv104AMBVGeu/lsapVCXs1+cPN7a7j0drlc4/qtfEKl3O
   ff1rbbJ5Rw8EA8OVEL+JQHeuJeHEMhuw04R2GHcJqaDS5/Id2jwWjsCEA
   +WToQMlVJcNSugcMcyLvYGmm6fDjoTX1lI/Nce7A3R6Ijocv5QmZTMhOm
   WjnOTXu17eCy04FHhzh67PHSAt/cSus6B2OsQ0BLOAFqJGyyFJfFctPeq
   Q==;
X-CSE-ConnectionGUID: /3GC9y33SwCdJ8hYjMqCQA==
X-CSE-MsgGUID: n3l1WELrTxiK+qaZa3WdfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="147650016"
X-IronPort-AV: E=Sophos;i="6.13,316,1732546800"; 
   d="scan'208";a="147650016"
Received: from mail-japanwestazlp17010001.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.1])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:32:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBsDTPctn4bAoETK07nkjq08fSIKOWUWzxZ172IAGTJs/0vm0gdkRZq6N//XcuKpzpVHW5cwEbKozVazykck5BkgiisjNJTeNKo1NQFg0FzSobp6ENeJb++8HhWNT4OGRrOyUqwlKKniYs4P76lx85KBAz+BynSqKZ0l0IXlIVixd0LLcBmY4flOUe/CvtN88Hz8Hz1wWdoBpZ1eruHwPye+Cq9FH6R2eG64A1aOISI8tkAR9BAIfI7dOJeTmdC0/2ySnOZCGjabGVI1Z3JGEwSj2WJLSu5ioXdvUKl4UFGJHPfEvz7kre5z9cIn1v5RuZC6StEPcM8zzpBV1YQ5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8EQ5idLO9q0JoSY0hyn592N1MzrblxrQsGYkhwfr2o=;
 b=Lha+UGzkctzCIVASL4eAsqmaKkQroYj8Xlx+pn4AZbW4j4EyBJuZydLvQ3n1EyGVDm/PbSZDYMwMUKusny94DNn4sw8ZiNgMa64pbmRnvyhC3NcDJiExvhJ6aR34WzbFymCIG8XypJRo6SUy28wU6yNNi485dmazzFKpnAZmsTGlDGLIflZZ943crSeKQ11wl+8vxXgLfEtYA0JhgEOacJO9+bSeCXhhPPhoQdcaEAvZl162jHz/+IuY4c+pVlEbjBBsjPgtIG0BspCic9Ud3OCI/Uz5p9M2yMK6WMQLeMGmkTySvhvY347nSTPKwelhuPI42trG30bJZssi6QE7QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TYYPR01MB13021.jpnprd01.prod.outlook.com (2603:1096:405:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 10:32:34 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%3]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 10:32:34 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: "'yanjun.zhu@linux.dev'" <yanjun.zhu@linux.dev>, "'zyjzyj2000@gmail.com'"
	<zyjzyj2000@gmail.com>
CC: "'linux-rdma@vger.kernel.org'" <linux-rdma@vger.kernel.org>,
	"'jgg@ziepe.ca'" <jgg@ziepe.ca>, "'leon@kernel.org'" <leon@kernel.org>
Subject: [bug report] RDMA/rxe: Failure of ibv_query_device() and
 ibv_query_device_ex() tests in rdma-core
Thread-Topic: [bug report] RDMA/rxe: Failure of ibv_query_device() and
 ibv_query_device_ex() tests in rdma-core
Thread-Index: AduINhC6z8CIndfCSQ+JehITUDRBTA==
Date: Wed, 26 Feb 2025 10:32:34 +0000
Message-ID:
 <OS3PR01MB98657565E6FAB0184E7B72B8E5C22@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=3a7da3c0-eff3-4be5-9de0-a7ce6ac8d339;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-02-26T09:54:23Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TYYPR01MB13021:EE_
x-ms-office365-filtering-correlation-id: 732733bb-4043-4da2-5bc5-08dd5650e204
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?OUJmbGk4alU3bWJGbjQrRDlDSEFRQ29CQnNjbnhVV1pwOUpRbEFHMTFN?=
 =?iso-2022-jp?B?U2Q0ODhFSVFPalFBTWFJRTk0alhKdTUrb0cxSExrcGFBUk9nWXF1UWxE?=
 =?iso-2022-jp?B?aWlYcDdKWDFPMlp1dkd2SkkrcjJabVhBTUN4YzBGVzdVQVowbjBGUzFz?=
 =?iso-2022-jp?B?OVBqNzVwVzV5Y1BrN2wwSVRwQ1pvdDF4aXZ5MitKemJCUVJUS3pBQlhN?=
 =?iso-2022-jp?B?SUpjbVErRnpkazFTQWMyeHZCYUlaMnVXTHB2R1ZERW5nVm9vN0loalhC?=
 =?iso-2022-jp?B?K0dSY0N0RDdBNndTNmFQWHkxd3RVTk5TcU9YNVNjMEVFQjA4UHNvWVlM?=
 =?iso-2022-jp?B?NXp2M1RLdUpMaXdDTzdhRllWT21ud2hsMGFIaTV3NkN2cUp4NzVkOFdG?=
 =?iso-2022-jp?B?QkI1SzFSUm1TRlg4YVZvRkcxeVVPM1hsZmtlWVFWVWR3dUExaXJFaHJ5?=
 =?iso-2022-jp?B?TW92dFNDS01XK200MDBaeC8wdXcwR1pDS2EyMDlUQTlRRnBYNWtpUmZZ?=
 =?iso-2022-jp?B?TVhoVEJlcU9lMFlUWFR1NW1tUUk2akIyRkhRbGFUK0Y4b1RVKzRuN2Ft?=
 =?iso-2022-jp?B?QTZtRFZ0UXBYbGErd25uV3RqNUluSGVMNThMMHVUZjIvTHhERitxUDh6?=
 =?iso-2022-jp?B?dnVxM3JwSXBWV1J3RGNiNDUxVjZ4TzBSZG9FSWNFZWZIZDVwNG9HRUJ5?=
 =?iso-2022-jp?B?K1VzbStJUnk4ZG5Wb0FHZ1RoMnQ4SU5NTHRnY0JBSG0xdXgyOUlkUHBI?=
 =?iso-2022-jp?B?dHpaTE1pUHo2RGFyYjlkaC92V0ZpUkMxREpWcmp1aWFyeEU4d3N2UmIy?=
 =?iso-2022-jp?B?djJPdDFnbGlTVDNxbGdVSFlpUXlONDU4RTZUbWdVaW1ZU3p1NHpKT3p3?=
 =?iso-2022-jp?B?Mk9ZMkVnS0dUeHNxcXl3ZndJVm5PbXdjNDZ6ZlhNeG1rN2puVUlncFV6?=
 =?iso-2022-jp?B?VkU2V1drTWtHSDhMY3JjL09Sa0NReStzRXJTS3o3S1ljZytvV3hYSjNh?=
 =?iso-2022-jp?B?akhZVkVISHIvVDFHQmhLVVJqK0VPUmVrSnIxbFY1MFQwUE9KZEd0aWxL?=
 =?iso-2022-jp?B?bXYzN2xabzJhajlWRExwWHBIc1RvOURGSS9XUWp2VkVBSmhkWGc1TTh4?=
 =?iso-2022-jp?B?Q3QwVk9MaC8wL244dzg0OWZNMW5HZStGcmwweEVnak9LY3E4dS9vRTRR?=
 =?iso-2022-jp?B?eVJvbzdjQiszYmllVmxnOXhCTy85M0gxM2lQcVFhWWx6T1piU3BMdVgr?=
 =?iso-2022-jp?B?YkY2eGRSdm9vSXNVMkwvekRxZ1lHWGw5M1hBYlJvN0ovNTJoczR3NTJH?=
 =?iso-2022-jp?B?bW02L3QvV2lrbmo3bkJHSlpsWnAyMUV5V1RUSVZYMVdoc2hTUEpTajBi?=
 =?iso-2022-jp?B?UUp4M1NwWk1rK1YwNXgxZmp5U2pJOWcyTXA3UWRnUEV5dS9rNDcwYUlt?=
 =?iso-2022-jp?B?aXdGMUFObE9nOGFMaDVxSU1HbFZ5cm4wa1JyYmxQZ1dRaHdtbzkwR0Ez?=
 =?iso-2022-jp?B?eFIvSEZsblRmanBrRk94VXIvVW1FRWVGZDdzNThYNjVGTEsvRlk5Vkds?=
 =?iso-2022-jp?B?NnZuT0hPZU1yQTBPdEplNk43Q1diaDhXSDBTS2JKV01YMGtDdWF0YWVF?=
 =?iso-2022-jp?B?ak1mS2IrU2xKTWJlWVVJR3V3NmlyK0Z3Yk84Rklha244OWVMSE82R3V3?=
 =?iso-2022-jp?B?UnIxRlV6aFRIS09LYlN2OFN4QktDekc3RSs5Z0NUWm5WdnplcGxBbUN3?=
 =?iso-2022-jp?B?YXhKazJXUjFGcU44U0p2VWFjN2twaTNTMUJ3M3A1RGxGZEVTRVdDMEFI?=
 =?iso-2022-jp?B?SWZ6TmNSZEtyOFBXRkF4QlNwUzczZCtRaWpKK0M2ZmRXN1dUcGVmN2kz?=
 =?iso-2022-jp?B?eWZoU3ZqL2xyM1dFWnVteGRxVERFNWtha1FPMWxkVFFaZzBYeHpmNVU5?=
 =?iso-2022-jp?B?SGFnWXRxZGI0cEJ6UGJOV2ttTWRHTERZSW9LbmpNNngyaHZreFBTRG41?=
 =?iso-2022-jp?B?K2FnTHFaVGxtOFdSTW81akVJM2tqbE9VZEtHK1Z6bVJuRFBMSHNTOGt3?=
 =?iso-2022-jp?B?VHZVaFZBN01MYks0VkNmMnFWS2w1cUk9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?cWQ0SHg2S01xdGhzUTI4SmZ3czdsYnVSOTV1bzBxcWx3NGF1WTQrZlFy?=
 =?iso-2022-jp?B?em1lcU8xS1BhT1pTWUd2MnF4dmxwWGloYmk0RERXWGw4SXpEUmRuY1VL?=
 =?iso-2022-jp?B?ZGxBZHZXOTlFZ29vNU1UQ1RtL3RSTldROVlLUExaYWJTTTFLRnM0TWFC?=
 =?iso-2022-jp?B?QXlKV1hFNGdoSWpDR2UxTEVlRUtJcnlVWEVnZ3dyVDVxZk9zVC9wSDEv?=
 =?iso-2022-jp?B?TjFYZXJnRVJFQUhHZHBSTDhpY3JNYUpPSXRFMHp0Qk9tS0k0WW00SHdN?=
 =?iso-2022-jp?B?TFVuWG5hclVlUDZJQlpOTDM3L2VZZWFVSjVybGpmcXVCdFhPVXBXRll2?=
 =?iso-2022-jp?B?TU82NUlBU0Y5VzRSRGtVRzZ0cXBRK21zRTNIYyt0WjRNNHNuSXJ0aThn?=
 =?iso-2022-jp?B?cFhNOHdwVldpRFIzc0JwdFVnWHU4eVRmMkxwNUF5UmV4ZTdNZVN1d1U2?=
 =?iso-2022-jp?B?b0FhcnJuQUJMRCtaa2t6RUhhUkZkT1kvbktoc0oxcFBWTDAxM0Y2UkhB?=
 =?iso-2022-jp?B?N2VFaUR2SDVDendycklTRlhhY0Yxa1RLNlpVcndqVlB3VDlnQktldWdM?=
 =?iso-2022-jp?B?U204LzhUMDJiZUNobXlCU1pLN2g5UmV2UERBMW5lMG5yaWp6S041ZHhn?=
 =?iso-2022-jp?B?bm00ZmNwYXpHamEzbHZHM1Y4UEVVZ1JCaXB5NlNINFFnUG5qc3EyUGlX?=
 =?iso-2022-jp?B?SkpwQVcwNVFIdUZzVFpJWW05bjd4OE4wNzdNbHg3clNxdjR2d2lQQUFW?=
 =?iso-2022-jp?B?MWEwVHBqYjBwRTJsUEhCRTI3cjVMU1haWWYrMXpNQkRvWjl1Kyt3UWhn?=
 =?iso-2022-jp?B?WlNNbGJaZjNlM2MvN2lhMU5DSlJ2UXRMVVR6ZzU4VGFrYTFjT202Y01p?=
 =?iso-2022-jp?B?eTBLWjR0YWZIQkVFVkxHWENIYXFPN3dGdmlqSEg3cTVSVmNyNVQ2bWRP?=
 =?iso-2022-jp?B?bExVdWpaUys0c3FkWDg4bGorNWdBYWEwNmVwOHBsRXg0bXVoZHl6SVlO?=
 =?iso-2022-jp?B?MmhnVFlabzJ1THdiL3NzaUhmRTVnQlNOY2FJL25QZjVBeFdkbFhvSmdl?=
 =?iso-2022-jp?B?VEZHcnZNUHdQTmlMejBiSkdabDVNbThvTSs4dUxjTDRoZzhMdmVKbHh1?=
 =?iso-2022-jp?B?NVg1cWliSGNrcG13TzQwbkxlUjFrc0pmc1VTemwvT2pNSVhkd25ac0pP?=
 =?iso-2022-jp?B?bkx4OFRuSnBsME01M2oyNzF6UjhBcDk2RmdYTk9EY0g3OGNPcUZOV1Bn?=
 =?iso-2022-jp?B?aUtiRkNVdW5WR09DQWRmaEoxRWxWUXBOTXNORGdFZGhNVGxHanBVU1Q2?=
 =?iso-2022-jp?B?Qyt0VGQ2VVhvbmlUY0R2U0RodDB2UHNMbVpZQU81S0lzbytBVXlOUFhi?=
 =?iso-2022-jp?B?UlpUamJaSnMwVGp3QUs4OVBLSWhNTXo0UkJBQmdWNkxQV3ZzeG9lWHFG?=
 =?iso-2022-jp?B?OWJIcWYrQnpuUTJ2UGh1SFhkMzRtbmM4MGNPbzZVRWlnQXUyRkVaNG9D?=
 =?iso-2022-jp?B?dXgxOUxzQWRsd0xiMGRSS1Z2cWdFQmI3bDd4MUx5dkhZcXZ4cEhTYWtT?=
 =?iso-2022-jp?B?Y0llNzZuZVRMUnJEWW15c3RQLzlUZk0vS0duQ0UrMEwzSjkwSERGcGNN?=
 =?iso-2022-jp?B?ajNSNFNxdUNVUWlFSlJyQ3U0ckNmTmJ6Wm1adnFrL01nRS9SVnFJYm5v?=
 =?iso-2022-jp?B?S0tGUlllTDRjbDNyd1VONU9WbWJuTFIrbElLUngvVndIZjFGNXAyNkYx?=
 =?iso-2022-jp?B?UkNVWjAzTk40RTloaVFmUytiZVM5Q0xOcFRjS2NmZi91ekdYN0gySEkv?=
 =?iso-2022-jp?B?RXQwV2lqa3ZvS0xsUWZDZXM2V3VQNEVtQjdXU1krYUp0dHhNSjlKTnha?=
 =?iso-2022-jp?B?bW11S0FjZk9JK0RUTDBmMzA1WjA0bjNCVXVVRExxcnJiUWRkVWZYbWNk?=
 =?iso-2022-jp?B?VVlRMjJBSnlibWVsaTNHRXhTUUMxK1JGK0RIOEZuMnN4a2hITCtncGpa?=
 =?iso-2022-jp?B?Vmhsdm96amgvY3FZeXl1RWw5SE8zeFFtRDMwOG1vUEdsVXVocjFqN3Fi?=
 =?iso-2022-jp?B?eE9MQkxqY1pmOEpSRWRoTGhnazJZTUQ2VFJWMkVSL2VIZktSRlhWWVBs?=
 =?iso-2022-jp?B?S3o0a1ZsM1MyaExjNmNzSGFXMGRxaExOZ1ZwcHdpVDZuL2h2WTB0dzkr?=
 =?iso-2022-jp?B?c2hMdmNBRnZLdWhZYkpQMENUK1VXWWZ6TGVKSDkzbm1XeDgvNjFtSmZ4?=
 =?iso-2022-jp?B?WlhWQW1CWm4wYXV5V1l2Z2JaMnRyRFptL2FxTzlCZ2dhb0pNWlBuN3FD?=
 =?iso-2022-jp?B?RnZDa1VUeDhORUM1YmV2U1J0V05uZzZDdHc9PQ==?=
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
	mbHcULnOOiFoLDKF7Ig4oU57wvYvipcTQeC/NN3gSjkQ/2mRfb/rNBth+vTGcZRFZzQlTwLFHyH5N5plMlodqOLawHT5zBZ2mi5eTIurNhUuzHXN8Nw6afNuMUUoiQc2THz6Zzd6zW+S4Knfvy4FPrAphjSBe8+eulx/a1p3ZECZI2NJ9UoEwILSd8GN9Z1pyPJW04eb6KlY5jU3uy8aa2ZN33kaB6uvb4q3ylIMlV7+I6Mf14OHYSIayLTxDonFn9/k8Rpi3xmrsiXxJ1V2cQKlzv0n6j6B8HMEJoYB4CxWSYIn4ECTKlZ0l/6fiU83HDOX+MGjhs8ZGPiHp70SATRQ1HZchHt10iAsXwk1YOMx87gwXtlJoGOvoZZwAqqTFdMys0RExr5mZOeUEj56WilVomKFoYr3j28GN3MnDxagwoas1VrNqcLXLXBne5XvHyMnKF+kvKbCkzCW5xaXE3IDRhg5C2YL3SltPBzCsVs9Li0HV9+ZtA6mit/mGA8whyFW/xsCRXihbdosrsqWBuYvrVS6TNnvGznxWGC/AiBk+Uj7Jkh/aUeXdCdM/gf/BjKvCR4escbShYkiEvUlgCcg7VEgTjXTbyyzVPSDqbrjMxqRKT/Wa72hnX9ltuVE
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732733bb-4043-4da2-5bc5-08dd5650e204
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 10:32:34.5265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cRu15/FVOBZ8iYX8sTqOXt9fjJZtJxeD4fPry022iiPGEr+iJAcl1Ja6tG50lFZzJsrYBdfvJ8UrJtgAQPiV25Ce+kRm9pNJwkHUZyb68HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13021

Currently, two testcases in rdma-core fail with the latest kernel, leaving =
the console log below.
=3D=3D=3D=3D=3D
$ ./build/bin/run_tests.py -k device
ssssssss....FF........s
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
FAIL: test_query_device (tests.test_device.DeviceTest.test_query_device)
Test ibv_query_device()
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/ubuntu/rdma-core/tests/test_device.py", line 63, in test_quer=
y_device
    self.verify_device_attr(attr, dev)
  File "/home/ubuntu/rdma-core/tests/test_device.py", line 200, in verify_d=
evice_attr
    assert attr.sys_image_guid !=3D 0
           ^^^^^^^^^^^^^^^^^^^^^^^^
AssertionError

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
FAIL: test_query_device_ex (tests.test_device.DeviceTest.test_query_device_=
ex)
Test ibv_query_device_ex()
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/ubuntu/rdma-core/tests/test_device.py", line 222, in test_que=
ry_device_ex
    self.verify_device_attr(attr_ex.orig_attr, dev)
  File "/home/ubuntu/rdma-core/tests/test_device.py", line 200, in verify_d=
evice_attr
    assert attr.sys_image_guid !=3D 0
           ^^^^^^^^^^^^^^^^^^^^^^^^
AssertionError

----------------------------------------------------------------------
Ran 23 tests in 0.007s

FAILED (failures=3D2, skipped=3D9)
=3D=3D=3D=3D=3D

It seems sys_image_guid is set here:
https://github.com/torvalds/linux/blob/2ac5415022d16d63d912a39a06f32f1f5114=
0261/drivers/infiniband/sw/rxe/rxe.c#L82

I tried rolling back to commit 57a7138d0627, just before this patch was app=
lied, and found the error resolved.
[PATCH 1/1] RDMA/rxe: Remove the direct link to net_device
https://lore.kernel.org/all/20241220222325.2487767-1-yanjun.zhu@linux.dev/

I think the root cause lies in ndev patches applied in the past two months,
but I am not very sure if it is good idea to revert them. I would like opin=
ions
from Zhu and other developers.

Thanks,
Daisuke Matsuda


