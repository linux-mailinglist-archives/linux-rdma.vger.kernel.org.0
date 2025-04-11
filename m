Return-Path: <linux-rdma+bounces-9369-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B29A8564B
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 10:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E64D8C4F5E
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 08:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CB9293453;
	Fri, 11 Apr 2025 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Fs0SMzby"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C131F151D
	for <linux-rdma@vger.kernel.org>; Fri, 11 Apr 2025 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744359322; cv=fail; b=OjfJRaVmtVVRbHSBZ4yKPCDLwqqQ7PT1khZmKGqk7mLay9HdHRppEAtTNYI4skndPUFKcNNMIWBnXOeOXjTOz10wfwFYzPqANXlXxLwNW9KzlCn+qdcFChfm+EaZ5tyP1LlZmiZeB5H+GXV65RkMkSCYM8EL9PXkU6I4eENax3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744359322; c=relaxed/simple;
	bh=2CnDfI8wPRAlfFXCOyljXpR9Eo5YU5FeSePzy8p7+cg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nBN5ptQ8cVDBQSQqwB1NBmqSFVeQchog9RysIZU1MrGoPngvsBW19vw7xJdopZPPCHvZFdrjED/mHkjYskb9Z63tzWkAsjQaUy1kvZmlvtR62UWDEUpffXr9VJ6SpLtsCDRgM8k8rfsUQV4lKblCwgEGcL+y2Qp5kIy+2Dw1DjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Fs0SMzby; arc=fail smtp.client-ip=216.71.158.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1744359320; x=1775895320;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=2CnDfI8wPRAlfFXCOyljXpR9Eo5YU5FeSePzy8p7+cg=;
  b=Fs0SMzbySn+mcM84A1dzyiiVn/mGg2y/dvYgKKfOwLPf0qQIlQQ4Uy2x
   tKrp6SRF57Ha6ZrKPbvvfMyUO6vbdgDmLdgbtmujmfAl/hcFni4zDh10a
   yqsl0Fn/EfJcUrvF/gn+eLUzaHF5JXby86E2BKfhSFD0Bz+EWWPkCPhsy
   JgpzT4cagqpP7C+JYcM+FslVwNb3GjJ/BdLmxyptrK952jGGjVGFspuZo
   WA01oIR8JJsZXOi3MT2t4bYimGMmTG7ew72bkcYrdkEWbbGuSZguk+Dn2
   Z8uIoKOmQo7E6kSxm/XZ0aEaHXayGa9/7JSIsiLTfytpHTq/yG1Dsz71/
   g==;
X-CSE-ConnectionGUID: kBotsIGRS3qjwW3CXvuBCg==
X-CSE-MsgGUID: Ovc79+NNS1uGdqM/4tashw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="159017319"
X-IronPort-AV: E=Sophos;i="6.15,203,1739804400"; 
   d="scan'208";a="159017319"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 17:14:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+yoI25+KuyF01USIE/9cd6yo/DrI9O+JBMiLAJsD626JyOwrZF/RbBcAVGbvtn6hfAgi37QW2tC7EGENlnonzRXQSWrN8qSZEM/9DbV0le8vhzWnTtp2ZhEyP1a7nky1BCS8y/AXqb58DdclNqa42INS7Bj49bKRlGlqmN/cbYHwY2U5jD8fS+ihVlr845qMaTOckDEF5ekgY5tmbbn4n9V/qxyba0m0TAkP+wXqc5M+4oZBIDP39zNK9Xa8yp6Oyz3nwvnzU/WmHsUvoxhMMteuGNKleRfy2jVO7+LFV4ISH3exPrdyDMyp30qyDl4BK23ANrdiLza6XvxPboxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8rIZsiRuHjcVcy9WHj8vjZZDlboomQrxDaQIYFgHr8=;
 b=pV68S4sNi/jRkG+bNpysF3KrPrUktyHY5E+iisw/QrtOX/+EfKXg0TKlZESTaVILMVmpa388CXKYAXHYXGrF25kT+RGJPTxp8Qvrrp0+xHdBcyNM0+lgu1ZL//vCPoqwRz6FvlAEab5TvDZcdi/DHX2z6EOyc1zSaAOZDJjW5Q6I911+bcXYAaIYMtU4SYKRMqnqdg4pJzt8WatYBhEnmDQJo25d/3/aAzJbxCoH+XvU5GGE6BRaAB2hV+oA0QoYg+PQ2XMCNYfAcU1HPjumEE1UaGGrYlpQmwJvwxCQBG+rOvG/NNC8XIkO2QhH7cDsTrqU67oMKTi8F+jVC3CIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by OSCPR01MB14503.jpnprd01.prod.outlook.com (2603:1096:604:3a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 08:14:01 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%6]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 08:14:00 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Leon Romanovsky' <leon@kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v3 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
Thread-Topic: [PATCH for-next v3 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
Thread-Index: AQHbnJJQp2nOjxjI7Uy0N2Ugx/pysbOZtPEAgAR6eKA=
Date: Fri, 11 Apr 2025 08:13:59 +0000
Message-ID:
 <OS3PR01MB986530139AE70B2D0BB6C111E5B62@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20250324075649.3313968-1-matsuda-daisuke@fujitsu.com>
 <174411071857.217309.12836295631004196048.b4-ty@kernel.org>
In-Reply-To: <174411071857.217309.12836295631004196048.b4-ty@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=5d36ca2f-02e1-41b5-be44-7a74fe4842e8;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-04-11T07:35:20Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|OSCPR01MB14503:EE_
x-ms-office365-filtering-correlation-id: 7a7a7b36-1653-4c0b-e23a-08dd78d0d045
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?Wm5kREpmNVF2RGdKWU1VeXlmekpocDNhZmQrN0RPK3R6d1hHT044K2xM?=
 =?iso-2022-jp?B?cVkxd0lrMXVTa3Zzb1NzQWs2NWw3TWxjK080a3lYUHNnSWdmT1U2bUQ5?=
 =?iso-2022-jp?B?SndXL2F3TmZDOVV6UTlKL1BkUFUrM3kzbWFON1ZuWUE5NnRQaDNsNG42?=
 =?iso-2022-jp?B?Qk1RR1NNcmVmVDlVKzF1QVViSCtoOXIrN1M2V2hwZ2Q0dkVaYVQ4dTQx?=
 =?iso-2022-jp?B?OUlMQjBWOUFYMGRLRmRKWG9UNlVSQ1U2WXpncFlvcnY1cnhRZlpFQ1VP?=
 =?iso-2022-jp?B?dTNVd1lubEhSQWhZTjdOTkphZUhBcGhZWW5IRFNOc1FwaFpCUmNLYTln?=
 =?iso-2022-jp?B?TjFYemQ1dDBETlRxWmpoeE9oWEhMU3hOMzh3MFRBUndvWnFhL1VwK0Rj?=
 =?iso-2022-jp?B?QVkzUkphRWV5UllheS9XNDc5S2VrZ21UcnVxaThNZFFUNlU0NkZpbmpE?=
 =?iso-2022-jp?B?WlkwbnJ4QnZLV0pCTTRqZHN1eGtKMVdZTmJOdjE4dDJ1OFM0ZVJYbFVo?=
 =?iso-2022-jp?B?QVVxUFk4SGs3eXhzR3B1b0R0RGVPZFFlaWNkMzIwK1VJalQyV0JJQlMy?=
 =?iso-2022-jp?B?em1iTGxGMzR0aTRWSmp1T1F3Q0JyWFUwdmdnUWc5QXdkdTgyNEMyS0g0?=
 =?iso-2022-jp?B?NmVNeWVveGhkeThqMmdYTEJ6MGU2M0xxOXR3cDdTSHhCZmVoMU1yTDFQ?=
 =?iso-2022-jp?B?OERhM0lOOTJXQXorUTZLTmdVbUZTWjJLOUphUjZWL2dmQ0hCcXowd0Ez?=
 =?iso-2022-jp?B?Q3pLZEgzN3diN1BJVmZjMmVrTDNpTHhtbE1kSXJFQUQ2UkthNlJRdzFJ?=
 =?iso-2022-jp?B?cURFUlJLUWd0ZTQ4OWlGVVk3OW1iTE0yS1NOMzJYQ3dhaW1Fa3BLbFFW?=
 =?iso-2022-jp?B?bVk5VGVTVm9xdWlrSHNoQ2d2K0Z3bUNMQmtGanRXcmtHMW9UV2lvMjZM?=
 =?iso-2022-jp?B?ck1TU1VNbEFpYUNmQ0ZtMjFaTEV1M0NuTE8xbHJSY25IUGNSbUdtbFkr?=
 =?iso-2022-jp?B?TVNHZ3ZsRncrNzFKOVBlakxScFFQVjI2M1ZnZm1FeU16UlkrSjVhcnhM?=
 =?iso-2022-jp?B?YWhuZEtnNU9IRFZvTWZGYk5LbjZVUU16OHNEOVp1Z1hLL0hlR1JDR3NQ?=
 =?iso-2022-jp?B?WUdTVkFZQXphZUFYbEVLRjZST3NFMm1XVUF6MW9wWGNnUjdrSnkxa21h?=
 =?iso-2022-jp?B?UW5KWkJyb1UyK1dGajl2b0FLYjNWZFpTQlM0b1E2cHZPMUhEV2ovdnBn?=
 =?iso-2022-jp?B?empmWHY5NkhlZFJ2YU5WNU1QTFlDOWxlSXlqQTRhL0tNNEI0L2F1bmpP?=
 =?iso-2022-jp?B?R0I3ZGlHdDRBb3JzVDBrYnc3WVg2ZzNMUXZJcStFd0pBUG1rTk5KR3I2?=
 =?iso-2022-jp?B?UExxb2VKYktnbVdUVGJxdVR6TDhQRGd3d3Y4U1ZLYWZ0UVZSSXREUno2?=
 =?iso-2022-jp?B?N2NWU0R0SnloUjBYaE0yazJ5QUR4L2xPWHovc1RKUU1za2lMci85dWNY?=
 =?iso-2022-jp?B?aDNyY0VBaG5HU2dCRm1CRWtGU1kzM1RJZHlyMXhSZFBqOXY4bi84NlEz?=
 =?iso-2022-jp?B?ZldVS2gvQ0pQVUhEcjE4TVUxNVhiRHpiR3hTU1lPdGVTWEIrNTcwUXVk?=
 =?iso-2022-jp?B?eFBxa3h5YWFMNWZucVdtUTRjTmtLZVZGaHpueFU4Rm40NlJpMWlDcW1T?=
 =?iso-2022-jp?B?MUZJNEdDMmJIMHNTVk02c2s5aER6a1AvY0JTejJ0NWJSZ2ErOFRGVnph?=
 =?iso-2022-jp?B?WnUzM2NYS1I1UjFSblhhT3RuZ3VycmtKZXB6NGMvdUQ5VkJYdm1veGRp?=
 =?iso-2022-jp?B?RE1QY0tvK0NGYlBYSHBnU2llNXBRRlFlTkMwTFlrT1JFZkpPN01tQzJ2?=
 =?iso-2022-jp?B?QXFhQVJUQUlzQzhvYnJNTzdZalhwemswTEhoaDNyU2FMaTBCYml6K3NC?=
 =?iso-2022-jp?B?Um1mMXUxdkFVazBjdkFvbEVxMGxHYkFmZ3BNdnVubHlqU2lGTXFib2tG?=
 =?iso-2022-jp?B?dlZyVnduM2N0SFVaQUJHVlFoa1dkVFNBSWlEc2ZpTzFsTHk5NmtZNHBF?=
 =?iso-2022-jp?B?S2cwWHEvN3ZqYU1TejcvdUJMU0RuTFlzdjFvZURpWUxUWG9hME92YnJn?=
 =?iso-2022-jp?B?YjIwNGV3RU81NjRHN1NuaG4zRWFpMXVPM2RaNVVWenZkT2JKcWRFUmUy?=
 =?iso-2022-jp?B?cy9KQ1RSVTN0di84a1JsZUlVZERiQmRT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?TGQ5Z3QyeWhRRzFWY0I1eXZWbCtPbjNPNFdkUmJrRzRPd3l1MXhma1dk?=
 =?iso-2022-jp?B?Qm9NZ2Q5dm92d2E5cks5Y0RJS3BacjFrZFFTbDdwVjZWSE9vNkVhUzBt?=
 =?iso-2022-jp?B?Wk91NW51L0VCdGFJcGdiK3hqdDZLUDdrQzYwSU9SUTE3TXc4cjAwWHBv?=
 =?iso-2022-jp?B?SEJNYlVCcXlha3pKWldqMzlhd3pZQ1hsU0haUGZzYUlLQURhUnhPMWRs?=
 =?iso-2022-jp?B?Uis2N3NsejB6QzJXbnMraWttSkUyYUs2b3dnNWFEODlLQVlXVGF2a1Ur?=
 =?iso-2022-jp?B?emtmNEV5L0svUEQ3b3o3OTU5Q0Q3dElIcVlnbXV5UkhlSEVLWXppZnBR?=
 =?iso-2022-jp?B?a3E4Y2ZRMUIzRUdsTTlRNXd3ZUZiVnlVa2UrWkF2Z3FhQzFIby9FZjRk?=
 =?iso-2022-jp?B?QlFBaDc0TmRZdFlJZDMycHR4TU8xS29YdlVRaUx0dTRGbStGaFl1MHJ6?=
 =?iso-2022-jp?B?ZnZvOGUwVWQ3c0lOT3l6ZExjTXZsbzVKK2p4UVc0TDQvdmhjQlBsTEtN?=
 =?iso-2022-jp?B?dVJBRmg1R0kxTUZJQ0JwcUx6T3FUR2czOGpzWmd4Uk5IOWIyK1FGS05t?=
 =?iso-2022-jp?B?Nldaa2phbFZsWmtlQ2JOWjdXZjdhQ0gzRHd4d2o3czZMRWRrbHRZODlv?=
 =?iso-2022-jp?B?aUdpVjRIbVJyZ2ZVNHl4WWtPd3pmRXBhcDNSTkNuV2l5eHJiMGYvQWhn?=
 =?iso-2022-jp?B?cjcwRy9sSnJIODhJaEdCUFQraitZaWhKdVZJdWphL0xGM0xjKzV4NWpB?=
 =?iso-2022-jp?B?S2UvYWJUanYyN041eFRHUXVzT0dsalNGQ3B3Uzg3ZUlYT29ZVS9Pa25E?=
 =?iso-2022-jp?B?anBoVVpEaGdsSjIva0ExdDI4ZmxRSHBXb3VpdjFRanJPdmxPa0ZpdnVk?=
 =?iso-2022-jp?B?RW5YalBvSE14b1A1NlRnOWJ1b011SzBJRE95dHhERUVZUVVsYTZBWU5r?=
 =?iso-2022-jp?B?Wm92WERrdkxaZmNUNzhObnpTUUhiSTBPRFJ3UTlibjFLcUd3Q1pTSWIx?=
 =?iso-2022-jp?B?QzJwK3hLM3F3VWNrNUh6Zy83S21pdkwwY0d0cDV4aTNraUFROXV3a0pr?=
 =?iso-2022-jp?B?T3VOMTdaVVNNOTVodW5wVGg1VkhxN1Mva0Z3NmRPWVhkejRiTWYxaWsv?=
 =?iso-2022-jp?B?YWZMUi9kMUhVUVAwUFVrYlo4bHFEQ1UrYmlRV3ZrTkowcjU5ZENOMUdv?=
 =?iso-2022-jp?B?T3hpTFY4eUR3MW1Tc25qZ0dQMTdvVkhoU1B0Y1V2TzVwLzFGYVFXZllo?=
 =?iso-2022-jp?B?dDZNSnNCUG1SMmlzWXR3UGs5TzZLeGRSajhrVTlleGMxWmdyWlRMQnox?=
 =?iso-2022-jp?B?bExxeDBaWDNzNjNteTBQOW9MWkp3R1F2MHJJRjd3Z1R0REFJNm5mRFZZ?=
 =?iso-2022-jp?B?ekdOT0tlSENkbkNyUXpOa204MDQzcTFWTUx6OWVOSHRDQ3BtaGpZMFFy?=
 =?iso-2022-jp?B?KzYvcHpnKzFaYittWGVTWSthWkpnbzl5Wmg5N0t5NHJjbU9sc2NVNFVp?=
 =?iso-2022-jp?B?T3hXS2NtVCt2L2JNdEYzL2lXemdaN2dWTWptNEY2dm9PK2dSQ3ZvcW91?=
 =?iso-2022-jp?B?VnJwa0ZFQUhJQWJMNENoRG5MQ053RDBsT2JBQitjM3V2N3YzbjJHQjhs?=
 =?iso-2022-jp?B?SFpUWHZ6eFVjSXEwSTI4MTZBWVJpWVM2TXd2cjNyN3NrU051UkRvU2tj?=
 =?iso-2022-jp?B?dzBjeEUzSDNvd3pCd0Z4czc3N3hVVzBZVnc3V2lBRnpycjc0NVNBR1ZR?=
 =?iso-2022-jp?B?MnI2NnB1eS93ejQxeC84SXlqQlJ3dnh3WXRTSk13T3c4Zkt6WE5hVmM4?=
 =?iso-2022-jp?B?cGlnVnpUS2sxcWpVeHEvS21nTVpuNm5GT3ZFcDlYRXhYcDczL1piU2Jx?=
 =?iso-2022-jp?B?R2NOWnhub2VOSk04RFRwVVVWbFNlbmI3NnRoMG0vNmk1WGc2Wi9rWmMy?=
 =?iso-2022-jp?B?OVpRcUQwUmdMTmVqTWVIZkFwWUYydnM1ZWRmbzJsdlc5TDR4S2M2NXRH?=
 =?iso-2022-jp?B?RXhSMHZUTEhtQjdEbDlhTkI4aEpULzY0eFU1KzlSWVhRNmJZWFppbHZ0?=
 =?iso-2022-jp?B?WHVjZU4renEvNi9PQXdJL0FTeVRtbG1wUUNjTWcwaUdIdHpTRVFJSnVr?=
 =?iso-2022-jp?B?QVdxbVRmVkhiNzJNUUJCZG15T1JPYi92S3lvSWljbjI2aGN5bnNvNVdw?=
 =?iso-2022-jp?B?WUhyQ0RNWmhHVkY5dUVnaHlvZ0tseFdZQm5UZFZDZk9xTUJqZk1LNjUr?=
 =?iso-2022-jp?B?clZyTmZPMktaeGtEa0hLWC9xckdlL3I3d2ZCVjd5U3dZVnk5RGlNZkJv?=
 =?iso-2022-jp?B?WUI1OFBGU2RWNFMyWXBJUk9IM1UreEt2NUE9PQ==?=
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
	jhEPD/pIzjXDUOvpvPSPtmvuHaHk0VjWpZ1FvPQK6jgOwnaWS+U7+/c5FCx4Jdma14tgVx0DdY8kp4IHQoJDnrlx/w/tY/lgUUIV/rUIM00bSbBNBb2BDf4NT3LYcHHZbdrlaRxEC5QfMsokZVMjtNNEmpGpNZOPsiuPZitZqvz9TlWTCBBSyFz4b/D+qM89BXHsGt2oj7NzvuNm9/sMC9c6pZoVT/Ym033mp6Ng/NhIeB+UNfc1yJntOeTyL3xXtmsp48BJAuqusTGwupG5w8mj+02ISnlaQytgh2bC0Ic6zf7mKAINxcbF+6mTVH0IWyR6aTHaFlOx2RhJhL7LUITmBOZ+rdykHk7W4jY7jrmy4RONBy5Dt0xIMigat9NkTY+iNy3EIpSrvx3CmSJIuAe8DTlxZs78rf2k+koOjtNqxwfLrf+uYYuj0Mm8qJPY2dUZ2X62GGLtwlzXnyIcHCdltj6SiiraZeJc2CKo7iEPgFFfcZzKpT1wdfyAoG2KJXUPYf++oWLkS/2ff8hpA9/TX6cgYWx7Au6DSh5lmPOY0/3vIb2ZgkeDjBCNrO+6ktozNHDtFGepZ0NHpzdTJGQ2sJDLQfLtQZyeVYsev4bzfAcdVMICGf4WQJwEMoUP
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7a7b36-1653-4c0b-e23a-08dd78d0d045
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 08:13:59.8709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aerbob4fTwv0ciTWr3v2TpJwAxw1Qz6Ij1nEb6WHP+qjpbaLTATneL7aM3naEdWOMZUp1uSkCRw6o0droRd08ve2s+H8V2qR97HPf2EqbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14503

Hi Leon,

I have noticed the 2nd patch caused "kernel test robot" error, and you
kindly amended the patch. However, another error has been detected by "the =
bot"
because of the remaining fundamental problem that ATOMIC WRITE cannot
be executed on non-64-bit architectures (at least on rxe).

I think applying the change below to the original patch(*1) will resolve th=
e issue.
(*1) https://lore.kernel.org/linux-rdma/20250324075649.3313968-3-matsuda-da=
isuke@fujitsu.com/
```
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rx=
e/rxe_odp.c
index 02de05d759c6..ac3b3039db22 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -380,6 +380,7 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova=
,
 }

 /* CONFIG_64BIT=3Dy */
+#ifdef CONFIG_64BIT
 enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 =
value)
 {
        struct ib_umem_odp *umem_odp =3D to_ib_umem_odp(mr->umem);
@@ -424,3 +425,4 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr =
*mr, u64 iova, u64 value)

        return RESPST_NONE;
 }
+#endif
```
The definition of rxe_odp_do_atomic_write() should have been guarded in #if=
def CONFIG_64BIT.
I believe this fix can address both:
  - the first error "error: redefinition of 'rxe_odp_do_atomic_write' " tha=
t could be caused when
    CONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy && CONFIG_64BIT=3Dn.
  - the second error caused by trying to compile 64-bit codes on 32-bit arc=
hitectures.

I am very sorry to bother you, but is it possible to make the modification?
If I should provide a replacement patch, I will do so.

Thanks,
Daisuke

On Tue, April 8, 2025 8:12 PM Leon Romanovsky wrote:
> On Mon, 24 Mar 2025 16:56:47 +0900, Daisuke Matsuda wrote:
> > RDMA FLUSH[1] and ATOMIC WRITE[2] were added to rxe, but they cannot ru=
n
> > in the ODP mode as of now. This series is for the kernel-side enablemen=
t.
> >
> > There are also minor changes in libibverbs and pyverbs. The rdma-core t=
ests
> > are also added so that people can test the features.
> > PR: https://github.com/linux-rdma/rdma-core/pull/1580
> >
> > [...]
>=20
> Applied, thanks!
>=20
> [1/2] RDMA/rxe: Enable ODP in RDMA FLUSH operation
>       https://git.kernel.org/rdma/rdma/c/32cad6aab9a699
> [2/2] RDMA/rxe: Enable ODP in ATOMIC WRITE operation
>       https://git.kernel.org/rdma/rdma/c/3e2746e0863f48
>=20
> Best regards,
> --
> Leon Romanovsky <leon@kernel.org>


