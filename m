Return-Path: <linux-rdma+bounces-9107-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750ACA78783
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 07:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A53D3AF9A1
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 05:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CFC2135C3;
	Wed,  2 Apr 2025 05:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="RWVKZ1C8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F201CC8E0;
	Wed,  2 Apr 2025 05:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743570774; cv=fail; b=AKQf4ecZ8Qu+N/UFmKT7rLQfk9tWU3QjZaqcRFZFgRuB3O9TsgLuiDEVZkBCW0c3du9ibk5SU7CVGYqxtLgSInYBUU/MkmxBC3ta5uHjsJlDBtiJK56mFE1PBie3h9R1yz6tq7qmEV3616/NyjXKNCEgkNc24TX3DucfVoq1UuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743570774; c=relaxed/simple;
	bh=F6eQqjt5SZp9r40/R9vTA3QnNp+3qVvqwgr91tRVe2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vDyOIZVdtyabjc3gw0YF5aPKfr6tHxvbLGzMpAji0sbVPMzmm9RNoVQ3YPJAKo5672qyagpOCob1C5nRgDok7Vp6L3DFNi10SqEIphwdG8KDKjdjyb02t0vTwWQG2w4TA7/eUDePO/I2IjMFXYJk87ifyhP7TrYgpK/C10HuCQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=RWVKZ1C8; arc=fail smtp.client-ip=216.71.158.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1743570772; x=1775106772;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F6eQqjt5SZp9r40/R9vTA3QnNp+3qVvqwgr91tRVe2s=;
  b=RWVKZ1C87Z7iVaT8OHt+OebDzKVezXPym3+IbazjZext1hUl5UEyx/1w
   Wy9iHv3PEzVsRNhRCGnodZavAlLxGINWIS///L4NfSj6QEkgiqmN9dMd4
   BuMETwutZrS58w6duT6YYcjKOfTnjDPYtFUI9cQVZo8SOqyBh6gqdxFET
   tyoZdpMe1VzyQxjjclTbzWhpw1QDp+aOdQWy/pbP83B4RiPLBQjii/0eW
   1vE4KZ1y6oihMIgY2NSFgQs9SVrI9g48FNy0s+I1PPzHPLhCiZF9py9Wk
   Br167MaFgFjyBa1gdRcKkqhbYD//Tmn0Uph+rs+hZtk4i+lBpOMbCaBII
   g==;
X-CSE-ConnectionGUID: xfCJYizbSa6wRPSYEYFUjg==
X-CSE-MsgGUID: 5zVAiS8XRfWSFHfRrO0L9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="151460879"
X-IronPort-AV: E=Sophos;i="6.14,295,1736780400"; 
   d="scan'208";a="151460879"
Received: from mail-japaneastazlp17011027.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.27])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 14:11:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYRReWCpU/w5ag8rQo+XdJoiyd4sibJIRO16H6Abri1hRdjcX0Fp8y3nhjhx75CQUZminqnLePkw22LgDmv3a/aJPtF7VxDxMgI2xFzsp1PfSS4P9ZzydikVsY5+kFEZ/GZjtnmF90DzYIjDun+OosID9Kl54n5LNHonp+WJAPBCUKAkio0EJW9YlQCc4PhXd3cCQxOTEgwMKMoTqlSYiRK8q2LdNqkDGwWG/OV0+2OlGzgQAjwTGj6Ad6GpYTbyYcTPMbwisgL5Pdcyqm8w7sXD8M+npijUHB2++R9jWa6H7md8SylZrKP5YVqwNRgtXsg/XnZl54e5a4wUzQ7opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6eQqjt5SZp9r40/R9vTA3QnNp+3qVvqwgr91tRVe2s=;
 b=UIXmJ1G7B9KhdFI0L4AJALZA/uvs12qIdtQkJaUtmmqe2gFJ0oz8/ds65eFbUUIWGXFCxVPUokbqJY6K0phCikrjg6OyNWO5WcuuF3ToUiZDvXTfq3u/3XsUJT3VIRoAeCBwz5soBJYEKhiVt4dEhSnET8IkdFumBxgLEXey8gsB/raMahqTrkYUgC0ESq8S6h/PLGIbQLWQJSRG+pBsSAufWGXnUtHtEKNx+wDOoEB+Q/bV6Ts2G1VTd735vZPAgbVRHGEuRsWyz3vSXdJn2LaYj07X1hDNTUdnMhNZdpy21NocE88NRUyQDbuGq13D7NSiDevsxhSNa9aK8DXixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TYVPR01MB10783.jpnprd01.prod.outlook.com (2603:1096:400:298::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Wed, 2 Apr
 2025 05:11:32 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%3]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 05:11:31 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"leon@kernel.org" <leon@kernel.org>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: RE: [PATCH] RDMA/rxe: Fix null pointer dereference in ODP MR check
Thread-Topic: [PATCH] RDMA/rxe: Fix null pointer dereference in ODP MR check
Thread-Index: AQHbo38g6UTkzbmsQkidtCQCM4B+1LOP0eIg
Date: Wed, 2 Apr 2025 05:11:31 +0000
Message-ID:
 <OS3PR01MB98653E59736B707B4F7C2636E5AF2@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20250402032657.1762800-1-lizhijian@fujitsu.com>
In-Reply-To: <20250402032657.1762800-1-lizhijian@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YWU2ODE1NWQtNzhjZS00MGJmLWE0ZDUtYTAwNzgxMWM3?=
 =?utf-8?B?MTEyO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMDQtMDJUMDU6MDI6MzBaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TYVPR01MB10783:EE_
x-ms-office365-filtering-correlation-id: acd515e5-b233-40dc-6dbc-08dd71a4d4af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?QklWeDBDbVV0bEtjaTJDSUljazlGaDBSTjIzMDIzZDkrV3p6aVpIeHAxK21n?=
 =?utf-8?B?ZzJMZlF5K2J2d3dpMUoyS0VHZEgzUHJLUk95dDg5Qi9xVUpXaHpEV1NRNlZ0?=
 =?utf-8?B?RGp4WjNoRXkwVTdyMlRzK0ZpZ1B2dEJXU2RoZ2FwUTlwYW1qTWNkNG1ZMFg5?=
 =?utf-8?B?WVY2ckMzVnMrTkxldHFMT3ZTVWlmdGhJZExlREVCUmdQTXNCRDl1R080bGVw?=
 =?utf-8?B?bVlINDJvMHVmL3Y2SnprZnZDdmtsdm5JTFdhelJaOXA0UHN6bXY2WkVQbFJs?=
 =?utf-8?B?OWtlbXdxdTdMTThiZ3ZYVXBjQ3I4THBVQzJoYVBpaTdTbjFDbVVLWk40UWlQ?=
 =?utf-8?B?aElsTS85dzhuYWw1S2trT1BJdS90b3dUMnFqc1Y2Rm1BZTlBMDlWdHRub1N1?=
 =?utf-8?B?RDVtSXNKUWlwNGhOVjdiNmRZcU8yS2hMRUwyMDY4NVlocEl0bVVlTmc5Vkdz?=
 =?utf-8?B?MW1UUjVmUlVqWDMzcVNkbUpPcDZNQzk2K2w2V0gyV3R0d3hrZVZGMHpCZVlM?=
 =?utf-8?B?dDZISGtqaUE5akROZ0R0ZVNxaTluL2xCd2YzNElZbXUxc0crRHVsa0VhR1pm?=
 =?utf-8?B?dng1YU9DUlpVcU1sT0N0VHlqcVZseUk1YlJBTTdlY0ViK09Tbm43SHZ5VWtW?=
 =?utf-8?B?OHUvMXVETU1raUVvZksrdnpwRytiNGdQS25zNmo0cEFCbWJOUGNBUC9Xcmoy?=
 =?utf-8?B?aU90dDN3UTh0M2lQd1o3YUQ3WXZON1VqQ2hoaW9TRHRtZktlUUYycWIrcHNO?=
 =?utf-8?B?ZFZQSGFKcEF2TmRzd3R4NlBRSWRlcXR6UC9pZ3dVSXFSbzQwaFd2QVR4S2FE?=
 =?utf-8?B?QlU0S0ZMQ3NUVWJtb0g5Y2FNaXhaRmJHSENiMkhTRTBqT0pTMlNuVlVoYlNQ?=
 =?utf-8?B?VnNyKzZxUVFmclhGTXhDc01sWDBtYnhlMGwyVERiRWJrQUxOS3pFYlJGbXB6?=
 =?utf-8?B?TzdpdWV3eUJmSWdxbVVsT3dTNUMveE56SFAxNDk4bXdQOHZWQkNlbXE3YUx6?=
 =?utf-8?B?VExYTU9tZUlkcFNybzdVaFNEaWthSXpNOUlsb2xsNmszTm9KYTdHa1I5Y0d0?=
 =?utf-8?B?SzI0VkdxUjVkb0VvU1ovMUFDc2tEUWhCMHcrVTU5SzNHd1ZlQ21jZEY0RHlq?=
 =?utf-8?B?YXlFQVVydUM3WnlXc3pOYWxGay9XQkVSdWNMNTQ4SGVOWlF1bWhHMTlnZWR0?=
 =?utf-8?B?K2lka3VpUHhCd0lkUldJT2VnZVRnMnlnNm5TUHgxWU1GR09ySkFqOTFtMTZH?=
 =?utf-8?B?bVZZbjkyb3JUMUZvQVM2SWpCYnpsdzlaeHp2VkJ3T3BobzRZaS8xdDdCREox?=
 =?utf-8?B?SlRXNnE3OVlwK1hlTDZIMUJVVVNDRFNadGVyYkFVczNHL25lREVIbVdaQmVM?=
 =?utf-8?B?MEFxNStaZjNuWnZiRUk0TFBBZDJvVEFpUytBKy9RaU01Yk5tRm1uam9SdzB0?=
 =?utf-8?B?bHB4TStCc3RWOXlZWkkzRm54d2E0TFpFYm02RVUwQVFtaGR1UkVXaGFRSkxG?=
 =?utf-8?B?akdoRElmMEVpSHRGeVNMN1BGTlJoaFF1TURGVzZ3SG1veGVhN3krL3RCVjN6?=
 =?utf-8?B?R2t2ajhwM0xUVWIzSEdSbGxNWDJ0RzYybWV3VEJWK21OVjVCUmdpMUwyTUwr?=
 =?utf-8?B?UG8wUkovUkpCbjlra1hET2NLRHpaazRWbnhMUy8xY0I0M0cxZFJqY0VjM1dD?=
 =?utf-8?B?ekJ0TjVSUkNLNFgzRlpZYWlGVVF0YXhhK0Vxb3RPS2tOVzZsUzVGM0VtRGtY?=
 =?utf-8?B?V1hoVFF2NjVKK2ZPRDllVFBaTkxiMWtDdFFYQU9BV1dVYU5peGsxbnM3T1Np?=
 =?utf-8?B?ZzRPZVcrTEpldDVCaytUUE90VXBIUXlNeEdkTGd2YUg1MVZ0STZ0d3hOS3Vl?=
 =?utf-8?B?emM0ckxZTHlsU2g1VlVRbnB0TjZZeitxNVpFRnZXaWo1ZFhxU04yMzlYS0cv?=
 =?utf-8?B?bHV3SnlJV3N4Z1Ura2VvQk5WR1IxdGJsazY1RjN5SmFwSUlTNGNGQmoxalNi?=
 =?utf-8?B?K1FCQVpXLzZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVlNbncwbkFZZHVPNnJzRHh3S250dlVPMXN3aVNSZ1Vzc0VDdHJTUXlKUkVz?=
 =?utf-8?B?dUI2MHg3YnhMOVdLMUVkMFhUS3AvdGtSOWFWRHVVeVBRMW9iNHNoek14OHU5?=
 =?utf-8?B?akhsanBQWnB5UmR4MVMvczFKTVpnT2VjaTBJUGljemtTc2NxTVFRVXJGQSto?=
 =?utf-8?B?cjdaOGNNRCtkZ0ZlOG51L244amFqM2dkWXFZZ1JyYkljSVhZdUdxT3JyYTA5?=
 =?utf-8?B?bFpqM0o0cDZNYkQ0QmUwNzhDcHF6SzNJbVJRVXA4bVRaOHl0NWd5NmNFS0li?=
 =?utf-8?B?WEZUaHdiVjArbWlCczl0M0xvd3pYVksvZUZMZnErWUhUSHZHY0hKSUh2eXdj?=
 =?utf-8?B?b29qMjBXWjhMR1prMTFzbUwyZUt6RE16b2hycTRDMWZ0akJ4d05ZVXNQUkFR?=
 =?utf-8?B?bi94UGtOMVU5dUN2TWdic21lb2czZUtZMFpIcWQ4K0tqNEM5WlFWRWtUcENG?=
 =?utf-8?B?ejF2dUZubXVndzJ0dFNPZk12RkplU1JYcENEUGZQR0JaR290V2lTSGJha1Jp?=
 =?utf-8?B?Nzc5RUhnOGFsWjdLZHBsL0xCMHgrVWZXY29XNEExZFN2VFpQdlcvQUFXL3BC?=
 =?utf-8?B?VSs4WCt5S29IM2FSOGlhSVNzdVNWN2R4TTFneTZjQS83SjFveXBwcmJaRnc0?=
 =?utf-8?B?dXErWGYwRi9XTVFtQXhieHZ5UjduYUJNM2NRemlYUXRyZHVPbWZoc2cvWVNq?=
 =?utf-8?B?OUxORTZTSm9IWnVqOHJ5M0VPNXpwNVFPUjJEWnNuUExlUjNSbDlsYy9FNmty?=
 =?utf-8?B?aFVYc1R2QmdoSHF5Sm43VHN2c0YwUFBrMXhudEoxQ1hPZm9GUHp0ejVmdXg5?=
 =?utf-8?B?YW15UUNuYytBZGlLcjZ2TTRkRDNNZWt3YVdXemFzVlo4QTBNQW0xT3kvc1lI?=
 =?utf-8?B?ak1US0dqU0wzYVZDWW1saU9yQ0lhbjVheHVHUFM4UnA1M1FCNDZYdC81Skli?=
 =?utf-8?B?OFlPTzhLV3lkRWNYQUNaSWhGZk5pQThBM1BOT1RMOTgwZWNWbTl4cml2T2tK?=
 =?utf-8?B?NGJOMzFqc0p4alBxckEyNWg1N2ZCa2FrNStWYytaZEtVS3VsWlUwYWg4ZmVH?=
 =?utf-8?B?UjkwYlFqendCelhaVW5DQkRxbjg5OUtuVndpRndBN0tMTUhmN21iUWNpRGtS?=
 =?utf-8?B?UktqVWFsUlJsRnFFK0F1TEhnMEUyeE54REtjM0tKc00rK1YxSkpXOTY0Y0Ev?=
 =?utf-8?B?WnFGMnlaeW9GK1RCY0g1NUNsRjZqYmVkT090Z3phZUdwcTloT0M2bkE2dEJ0?=
 =?utf-8?B?T1RzUFJoelM1L1hsZVNrRU15Z2JuM280RXVDb3BkVjI5YWoveG9pZkRERVlD?=
 =?utf-8?B?bTRSWFdxSzBpeHVwT0QvTkxPcDk5dkx2MFM2SFgzUkdvSW5kQUkrRzZZU1Q0?=
 =?utf-8?B?RjhkM3VObElmK1lGWFU0Z08zdnUxa1BmSzNkeXBVQkt5SU9qZkNOZUZqMEdR?=
 =?utf-8?B?QXYxZGYzcXlIVjh1M3pvREg3VmV1eUx2Z3hGcmlnZzJPZW9MdTl6VnRCZDFR?=
 =?utf-8?B?TTFuakFYSXBqSlFCVWJIaU1uMkhNWDVXV1VNYzROY3g5T3JIWUZDZ1JSWVhj?=
 =?utf-8?B?NXoyT3M5UjgvU05QNk9rbVBBQW9Qd2RZNW9Hc2pCMnJXUFNHeFV5cDRiaW1x?=
 =?utf-8?B?cHd4S0pJblUzV0RqVnF6U0ZMVk9lSXY2UHFSZ1JIbzF4MWF1VTViWmV4bkdz?=
 =?utf-8?B?UzN2N1VXLzNtUGlzYkxPZERIenBDODJkeVF2UW9ncTNWOUpKSm5XSTV4VXN4?=
 =?utf-8?B?UjIzRVBQcjBIQjlOdElCT1FJNlBaOWF3OXdnYkNxendENmxYSndNell5T1Nv?=
 =?utf-8?B?bi9NUmIrbUh2VCtlMXcvaHpRZ0NEN2djR0hZQnVHc21Sak1uZzVxMjhjaEpK?=
 =?utf-8?B?aURzVTV5bWwwdnZqNjB6MjVmWVg5Mi83b1ZFb3lVZWh0SG4zSFNYdzM5QUt2?=
 =?utf-8?B?TTdnT2lHRUVHaVdBbDdzMUZjeDd3N0VaMld1YjN1alhnVU5Cc1Y1ektBZWxl?=
 =?utf-8?B?OE5lQThuVVVlcGJGb0RIQVZYeWxQLzlxOGpveEhzL21tWnByNzRudXJjZ1pC?=
 =?utf-8?B?M2hGQmtCWTcxaWY1V2ZFeUIrSmY2dktJVXlBaUd2MjlPMzV2WFNORGN3Mmxw?=
 =?utf-8?B?T3FNTFdvc3ZpUXZ1bEc2YVZ5akw1TmtpS1BDYXhESHJWc2FXUW16b0xJYUVn?=
 =?utf-8?B?TVE9PQ==?=
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
	+pKUi7upXE2jkru8JLgQxlSFscXscQxPVixMKy9ybtuO+vqCPD17jLS244zQX4dQKBbtWcGyIVmtAiVamHLGlUurKHXvQKJ1gsBB4fiLTr7xn4UARtHXOkueBzVl2sHxUTiq0V5iYriTCskCjovyay8gjz+89WsZDVncCd5+PJDr18KEQzKlcT6wrF5HulbyL5ODYO+W5EweoIjpuVBmkY0gkJZ8a6jA4ZfWHqG48eU0sV0MVHRaduAlEaBt0cDYbNEZpyRy+g1GFkGDUZuiyoPMM+yXV5PdG/2CFmGwCIfUiHU2TkD04Xya+K5paYZRAxt9T6duNSo797pztdwxzONtX4BHSBW+h9orAmuSHzTMMtThGRUHU9whWsF5OB1gQqU56GfgqzjwBNI+kP4D7Uli1RA+1wJj7bLXzeUUVszSVomn2pF5uzPhW/PtgB3uunPRf6IFNGOPpsqtbH3Sm5K3iZoQ67NDU8AT4l5tFqeFobjJlGYvala/0FdwgdHv3RoMbB6F2gRZo0DDpSmbgZiZbkb/2AgkxXB6B9AYb5UVwlRavGaIOH4elY/HCynTXXJUm1nKHd7iwkse1kvtGfsNLqsY/CzlG+IcPCInEXXSlDZ8bOa8Gk6DJmlY19vZ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd515e5-b233-40dc-6dbc-08dd71a4d4af
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 05:11:31.2893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXWCP2GHTLF9dNF2xY1DiUTg2SDKPYmtTV6qZ54caLU7I5ZwjgBkOkxckKMksbQA5GE36Az9vZ4+vDlG8Sl1Psct/mBjlzHKM9pDAO6QNHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10783

T24gV2VkLCBBcHJpbCAyLCAyMDI1IDEyOjI3IFBNIExpIFpoaWppYW4gd3JvdGU6DQo+IA0KPiBU
aGUgYmxrdGVzdHMvcm5iZCByZXBvcnRlZCBhIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZSBhcyBm
b2xsb3dpbmcuDQo+IFNpbWlsYXIgdG8gdGhlIG14bDUsIGludHJvZHVjZSBhIGlzX29kcF9tcigp
IHRvIGNoZWNrIGlmIHRoZSBvZHANCg0KVHlwbzogbXhsNQ0KQ2FuIHRoaXMgYmUgYW1lbmRlZCB3
aGVuIG1lcmdpbmc/DQoNCj4gaXMgZW5hYmxlZCBpbiB0aGlzIG1yLg0KPiANCg0KVGhhbmsgeW91
IGZvciB0aGUgZml4IQ0KSWYgbXIgdHlwZSBpcyBvdGhlciB0aGFuIElCX01SX1RZUEVfVVNFUiwg
dGhlIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZSBjYW4gb2NjdXINCnNpbmNlIG1yLT51bWVtIGlz
IG5vdCBzZXQgaW4gdGhhdCBjYXNlLiBUaGUgZml4IGxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5
OiBEYWlzdWtlIE1hdHN1ZGEgPG1hdHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNvbT4NCg0K

