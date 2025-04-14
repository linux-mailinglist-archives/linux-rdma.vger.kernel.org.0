Return-Path: <linux-rdma+bounces-9402-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF32A87BA5
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 11:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E30188E776
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 09:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA47525DCFF;
	Mon, 14 Apr 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LvL51nKZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2131.outbound.protection.outlook.com [40.107.21.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B084F1A8401;
	Mon, 14 Apr 2025 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744622142; cv=fail; b=gM/371Xp79vCEsAoN5TAAxjjQX3q745bKQ7yuAvwexmlJw3lpnM+skmZtF3wXfoj9RdLLUnLlmeF9fiXS8g3fW9YCxUZcu18Y1gNbWcRNFUFAfccB2/UbWHU9OIElMdTyqST7X7ZByQdoYppb0+/QKJ73mU5FsprPg/NfsWSG4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744622142; c=relaxed/simple;
	bh=QzEJqVv34hZJyk9kWZlN6BP6RFEoiCI/pEMz3nUguF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VfSqDxp/5w+A8Qz133tSVsK0oJWi+iZFi/2GKBvHkWR0/72GFKcMa5W67nEQshk/xUvhzFMmoDWGlq9xyIViQiFMv2or9N3/zwdjElFhyyvixJ6jIZ33cdvPLyW9ODc+6mnCfmY14sS3GtYSKsVXi8h/66wKMuvQVFXay9DlxJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=LvL51nKZ; arc=fail smtp.client-ip=40.107.21.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIYW0NTfh5GpT3fzjPpSKSwSA7GkBlb6Nc9nuxfbjNAMBF5dAdhtGN4HwU/Ejv+jOwUwNrUfGBxrQT8vI9Gf9nZsEN+99EPUlVgN32DroD+SeIzDiHz2O+25Pd4M/1Lc9X+Wc+sMCMHPTGc3vnuQPee+ebk4J0AJP1ZPzgDYqydzI3mZq7ekWBl0F8Imsh8OFJEzXZa5/hCfs2j6oRBi+AEVGFVeoWAxs5VBDa+e7S6vZWuqEcFQSL2nf85rc0P1qoITWHD/f1fndpZsMudlo5YDDYPpgCCncwIxsO+hgjHNt5AbJzE1wkUrpWT3q/ol+L0IZC6bdYD13tdBOhupew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzEJqVv34hZJyk9kWZlN6BP6RFEoiCI/pEMz3nUguF0=;
 b=BddgF0oIrAHlvW3gf0kuse5VGDW/RnB7u8BgncOBPc5WxqzO8GIwsz3OceP7fVc2QZPyIX17rKxt7jJZ1OjXL/+1b3pdKxNwEvBB0Y02MLb8NW3t5mBDxuZtRB5mmW0esHpkLX8A4IMaZDQ11z2TlslqFIlKRVDheeZiQsK/UR3snUFVjUzu6NUPTcHL2xSNy1EOgAQ8d1r7V9jyoYW7jliLtmWBxLhPArcsEUZtnqG+ZQK2sacqTsVRCF1g6tDSFR3To7dvmZ1a+hj7e75dO6Rrj/h0G01qpb2+6Vajh8Di2seC0n2gBHMKl8a5HdqppEat7FqI0Kj1cvGPRBvSEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzEJqVv34hZJyk9kWZlN6BP6RFEoiCI/pEMz3nUguF0=;
 b=LvL51nKZcPHfaYNx0UbIgBOPgkrw0wpBTmjR3/oWCZi43h452xXvDkAb5v/IS9b51xEsjjjUreQ6JCZZ16GBTrBrQ/qk3YUpTkwQiDOni4RDlaNEwbSiTP7xi9LOpEdxvqw3Do5Nm1kLvLahVYUnRvL49F87mA6+0beOd8D0jcs=
Received: from PA1PR83MB0662.EURPRD83.prod.outlook.com (2603:10a6:102:44c::19)
 by PA1PR83MB0728.EURPRD83.prod.outlook.com (2603:10a6:102:48c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.14; Mon, 14 Apr
 2025 09:15:37 +0000
Received: from PA1PR83MB0662.EURPRD83.prod.outlook.com
 ([fe80::3c3d:5eeb:9d38:3fa4]) by PA1PR83MB0662.EURPRD83.prod.outlook.com
 ([fe80::3c3d:5eeb:9d38:3fa4%6]) with mapi id 15.20.8678.002; Mon, 14 Apr 2025
 09:15:37 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, Dexuan Cui <decui@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next 1/3] RDMA/mana_ib: Access remote
 atomic for MRs
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 1/3] RDMA/mana_ib: Access remote
 atomic for MRs
Thread-Index: AQHbpXBNINhh0Kyq2kyjM0FKnySZg7ObSwYAgAGktFCAAAWTAIAF+kog
Date: Mon, 14 Apr 2025 09:15:36 +0000
Message-ID:
 <PA1PR83MB0662DF877BC5277C04A06CD7B4B32@PA1PR83MB0662.EURPRD83.prod.outlook.com>
References: <1743777955-2316-1-git-send-email-kotaranov@linux.microsoft.com>
 <1743777955-2316-2-git-send-email-kotaranov@linux.microsoft.com>
 <20250409122852.GL199604@unreal>
 <PA1PR83MB0662535F57D8F09C1C99DDDAB4B72@PA1PR83MB0662.EURPRD83.prod.outlook.com>
 <20250410135434.GT199604@unreal>
In-Reply-To: <20250410135434.GT199604@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=935948f0-14e6-4590-8ceb-79b35f257289;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-14T09:11:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1PR83MB0662:EE_|PA1PR83MB0728:EE_
x-ms-office365-filtering-correlation-id: d9ae266e-fbbe-4d1c-db04-08dd7b34eb0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFhsTkpaSlMycjRNMGd5eVlEVjhFdldCVHNFcFY2Y05xQVNZZjBKcU9nblJF?=
 =?utf-8?B?VCszY3hJbWlHWmlHMUJ2aTlrMjRSLzZlWjFuN2d4MjJBOUJaRFQ3L054alg1?=
 =?utf-8?B?WEhaUnJXV3dRZjdhSWxkV01Eck1yWUphbGt3b0dSajdRYWhUMDFYMWZ1TFlm?=
 =?utf-8?B?WjVrNnN6TDZmVGZ3azFZQjcwOFJQSW11WXJQZWZwbkFVZkNrc1JYVzdydnh2?=
 =?utf-8?B?TzZ6SWFxRXFoUFcySG5sZEl3eGIreTZMZlJWUUJmWXZGbm5BV24vdUFGOUVv?=
 =?utf-8?B?dmloRDFpSXRRRTBPWW1MeFZIY1R3T0VmM2Mxa1BrNnA0Z2NTMTZYOTZsNStn?=
 =?utf-8?B?NDRSMVA1TVd0N1BqMGlUckVmbHEzN1hTMENJRW1wZncrcllleGZ5NWNma2Fj?=
 =?utf-8?B?aUpIcllobmxWdEVpK3VBSnVUR1RXZ2NibzJCYU5TN2hKb1JNeU9ETUUwWHhy?=
 =?utf-8?B?MWFEZmJKSlRPbnA3dloyWi9TV3NzdmZWdURCK3F3azNVQ0FhTk51MkhhRTd6?=
 =?utf-8?B?d3JUVllaT1ZaVXNweEpyazVzQ24xMDJPOVlPdGRKQUxCZlZnZkhibkU5YTVQ?=
 =?utf-8?B?RXVoZGZFLzlYU240eFVIc3IwRjJyNmcxeU9wK08vRTlJeXBxc2RhcWRsVkVJ?=
 =?utf-8?B?c3dxT2R4UE4wcTUrK2hHNmg4WkRqVkYwelN5U3orRllraFFhK2dkQWxiemMv?=
 =?utf-8?B?K2VzVUVPSHdSeC8zc1kvdVNCczVJaEFVM3ppelBxeEU2QmREdVhmQzBtMkUx?=
 =?utf-8?B?YWYvTStFd2VoNmRQdUlmcjZqWnJiVTF5WWtlSWJYblhVSWl6eTIvS3d4NUc3?=
 =?utf-8?B?bFE0NENzNnBTQ05NQXhPUXYwaDdlRnJTazFtQWpTUkI3ME1JL08wN3krdlBw?=
 =?utf-8?B?elFQQkZmc3o2Z2JURk84NlozamJMbXduR0RWRUw3clVqV1puem5BcHlQUnQ1?=
 =?utf-8?B?U1hXNlk2RnNENExVbU9YUVFya2pZZHcxdXpVd1dOU2pmNWZ6bDVET3ZZMWNL?=
 =?utf-8?B?NEkrdXc3Y1luRldsVDBWRVlWbVdZbnRSTmJnTC8vM0dtbE12ejJySUJPNXRx?=
 =?utf-8?B?SkZNM0dJQVBQeStadHVYaUdaZ1YrWVVPWHNZMUxyMkVGMmFBOC9vTS9iVUo2?=
 =?utf-8?B?ajVFZTF4WXhuWUdTWlQ5TkpaSFZLR1dTaDlGQmIzQkZrME5QYzZDbHo3SmdY?=
 =?utf-8?B?L05LeDR3b2ZrUzhpOFk2Q0JUdUgvdGZlMzJ4VkIzU1NieHhkKzR5aUo0ZFFy?=
 =?utf-8?B?c1dkak5Ud3lkYnRjcjVrRkV1MUxicmlsWGt6cnAwcVBrYnZDdlNuUTJWYmcr?=
 =?utf-8?B?WWc1UlZ5bFVSTXI4Ny9KRUptWEc4aEI2SUIyd2dKZzhIOTVwc2wwVndmM0pu?=
 =?utf-8?B?RUdaSGxGRTZEMVhMcHJndU5WRXdaWU03RjFRd3k3amtKbGRnbWFOakpEei9x?=
 =?utf-8?B?Wk5GT1Q5N3hGcG9IMWplc0dRSVVEOGNmQ2d3UU5ZeWtFVFA5ZXVvQXJaTVlI?=
 =?utf-8?B?OFBQaDFhV0VFRkpBZWFubVhjYm1VUGxQd011bS9tN3RxU2tPQ3RCOEV3Q3la?=
 =?utf-8?B?U2ptZHBPZzJ6Z1h2OGV0YW11cE5rZTdDUDU3Ym11TnhnUEFkQmwwZENycjlu?=
 =?utf-8?B?akhUNFFRK3pvMTI2NUh2aEN6MlRlSmpEWmJEeVpsOVQwSHpYdEtobW1RMUp0?=
 =?utf-8?B?VWxPU1A1Y2JTSFpTL05SK2pNTjJuQW1tM21WN21jOVQxajIrRHByRGlWbkVz?=
 =?utf-8?B?ZUdIU3hpL1hURFl0WmV0K0RHTDI5MTNHbVZpUG80RTZmcythT1FUWkxKYWlB?=
 =?utf-8?B?QUt3a2FoOHMvdDZnekxzcW93OGlUWDVkcEhTUUE4MmU1UnkzL0JjS2cxSmJn?=
 =?utf-8?B?b0YrdjZtRWxzUGljclMwWEFJbUtZL3UvbXVGZU1Yd2VRR0JINWFqd2xPckRr?=
 =?utf-8?B?N1lkQmJBcWdkOTV4MWJMSThpR3dSbWpoRkxnUlRxNzJCeDdzNnJMQzJxbHI1?=
 =?utf-8?B?dlEzVXRjc053PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR83MB0662.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2lFYk1Sd0IvUFkxWUVCZ1F6cFY1bDlFNGkyT3dhU1VNYk9RRFR4dWRtZysz?=
 =?utf-8?B?OEdUMVprMlAreXhRZGRidzUwMjd1YnBYUzdoM2dPSVEvUTJRQXZqdkhLZ0sw?=
 =?utf-8?B?T3MyQTRFNDVwTThNcitFelhYdmh6T1g4NzhLV0Fhem1lSE9zc25nL0o3Z2dq?=
 =?utf-8?B?UjlaUUpMd0Focktkd3JDKzZRUVZCaWxsSTVISWhMNUxpOFJTTVBBK2tieExX?=
 =?utf-8?B?RmpiVlJTbWd0aFJLaGlzbmhkZEtvRFJydG1hMHNDdTg1cW91WUk2LytkSVg2?=
 =?utf-8?B?czVzd1d2ZkVoRStTUENxbC9nMmkwOHp4MjVYa3ZNalgwY3pTeE1XY2xYczND?=
 =?utf-8?B?ZHFjNmtENDRnc3RjQWd0UE9DQ3lmUkM4aDdPcDNaZWw3bXdTbk0rYWk3T0Vy?=
 =?utf-8?B?MzdkU3R0MktLTldCcUZaY3F0TmQ4czhVR2dtUXhXdVpDZ1VTeXZxdExBeGRz?=
 =?utf-8?B?M3Vhc0syWnR6cUM1aFRtdlRZSklTVm9WU0t4Q1dlYTN2VFlvTmc3bVBjZm5L?=
 =?utf-8?B?TkMrQ0ZkcDFtanEycXlodE9Rc1o4cTM3ZTFZY0RCRm5RYnBScHBBUDAvUmpo?=
 =?utf-8?B?U1JMdmlnYnd1YTdwTkd4SXdSWHRtVEdPZWhFeWpBSmZHa3Q5VnVhbHRkVFgv?=
 =?utf-8?B?V3JqekRzSnN1UzVQSHAxOXF6UVFTcytJYzBZY2ZEeWJzOHNZV3JsbS80Z3ZR?=
 =?utf-8?B?aWFSSmZCVHhzRGtkQ29qVnMrQTRIdEZWb1JYM1V2bmVnVjFqVmZzSitKbkVP?=
 =?utf-8?B?eWQ0c1V2NjZJcnN6dUMwd1M3cFd0bUJnanFBSllua08rS0poY3ByM2Fwd2c1?=
 =?utf-8?B?Y3UrZ3I0TG9LcmtlTlFwTzV0VUc3ek5pTEZBTHF5QnhQQStXcXRyaldmRG9L?=
 =?utf-8?B?ZiswdXRpbnA0dzhlM2dacjdNTGNwTGlvN1U1cVdXY1IzSENRckoydDErMXJG?=
 =?utf-8?B?V3JBNHJGOG9zQ2hieDl1VzFMVnViZ3hYK29FVFJ6WjRLY3M4ZUx0VzNEaXpw?=
 =?utf-8?B?SkhDaVVpdWcxSVNJZmlxUHJ5TThtdXpNWVgrK09qTE9sSFB6eDg0SnpGMGpm?=
 =?utf-8?B?eldDTmQ1Tisyb09ZNU5hdzFQQzNoR214ZmxZL2tJa2Z5WUxndVFLNFJKT1hl?=
 =?utf-8?B?Z3RiN1VDeUk2V2doYjlueEJsanNzdEo3cTBoOVZuU2FOWlJHMTZhNzhxTG1l?=
 =?utf-8?B?Ykw4N25GNHRmNlFYdXN2a2FraHlDZGxjVVYrSFhQVFJKd3Q5QTV4YXRpV2l1?=
 =?utf-8?B?bWQ3ZlRoMTRaVEVNYlBaV011cmhobzJUaDc2QzlXZldxQ1ZxRVgwemlxejBW?=
 =?utf-8?B?NlpubjhhL2RwUU1xRGtqR1F5UzF1cmtNQ3Q2Y0NlUUNtWjM0dzZtZ2MzVlIw?=
 =?utf-8?B?dFlVWE0yTWQrSjJNd2tidFp5akJWUGZ0S2pMdDdkUHIvdXdhN1FMdEc4ZWtv?=
 =?utf-8?B?NzhoL0lEazdYaXZDSjdsOU1CaUFDRm9iYUdWS1RJSEJUcllCVEhkeXhvdkM4?=
 =?utf-8?B?TSt0Z1FROENGYndYeDRVQUxFTFJEOFpvdnBBQlM3YmFwNnM4Z3ZJL1Q4TjNO?=
 =?utf-8?B?UFRNNkxSYndHM05tVlpvOVR3SE95SllIYmg1Zm0vK2ptLzVaQmlsdC80WjBC?=
 =?utf-8?B?dTZnNy9YWEV0S2lvTi9LYzRNK0hGM2ZxQ05rMFZpWlltVDY3ZXBwK0VMY2d1?=
 =?utf-8?B?Z3ROOW90VEVXYVBRNHJJVlA1LzBwTzRFRTBvbWlYVHVaTVJiQUxnZFlUR0xa?=
 =?utf-8?B?RHIwWUM0dDgvUWx1Z2cvNksxRWN6Tlp3Nm4rQjJycnM5UG85akMrWkY0QXdF?=
 =?utf-8?B?RllJRDNpWjhVbjY0N092eTZ4YXovSWRmeFJaY09BdU15UWRjNEhsblA0VFhw?=
 =?utf-8?B?RTNaVW9CZjFGN2d3RHVrMFF2MG5XZ21JTGR6WWxES2RiT2M4ODB1RXhBYnRV?=
 =?utf-8?B?ZzZzN0UxdEtSTEJCdngzdlF1aHhIOTAveDJ3Z3NpVjhtb2ZpS0lDQXBuY3Jq?=
 =?utf-8?B?TWV3T1B4VWxFSmRCZ0ZybmYzaG5kUWFIaU44TzBuekpnZTgzdGpQcDRYR1h4?=
 =?utf-8?Q?yMxK07?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ae266e-fbbe-4d1c-db04-08dd7b34eb0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 09:15:36.8457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xD/+qo2HJLMfiddqbRfOZgLqSBEMMjgCO/TUIGfNDlWkn7ker+ucvoi0U+a2ubUlT0s7Qkovn4X6id3olYHXuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR83MB0728

PiBPbiBUaHUsIEFwciAxMCwgMjAyNSBhdCAwMTozNzowMFBNICswMDAwLCBLb25zdGFudGluIFRh
cmFub3Ygd3JvdGU6DQo+ID4gPiA+IEBAIC0yNCw2ICsyNCw5IEBAIG1hbmFfaWJfdmVyYnNfdG9f
Z2RtYV9hY2Nlc3NfZmxhZ3MoaW50DQo+ID4gPiBhY2Nlc3NfZmxhZ3MpDQo+ID4gPiA+ICAJaWYg
KGFjY2Vzc19mbGFncyAmIElCX0FDQ0VTU19SRU1PVEVfUkVBRCkNCj4gPiA+ID4gIAkJZmxhZ3Mg
fD0gR0RNQV9BQ0NFU1NfRkxBR19SRU1PVEVfUkVBRDsNCj4gPiA+ID4NCj4gPiA+ID4gKwlpZiAo
YWNjZXNzX2ZsYWdzICYgSUJfQUNDRVNTX1JFTU9URV9BVE9NSUMpDQo+ID4gPiA+ICsJCWZsYWdz
IHw9IEdETUFfQUNDRVNTX0ZMQUdfUkVNT1RFX0FUT01JQzsNCj4gPiA+DQo+ID4gPiBDYW4geW91
IGVuYWJsZSB0aGlzIGZsYWcgdW5jb25kaXRpb25hbGx5IHdpdGhvdXQgcmVsYXRpb24gdG8gcnVu
bmluZyBSVz8NCj4gPg0KPiA+IFllcywgQVRPTUlDIGFjY2VzcyBkb2VzIG5vdCBkZXBlbmQgb24g
UmVtb3RlIFJlYWQgYW5kIFJlbW90ZSBXcml0ZS4NCj4gDQo+IFRoZSBxdWVzdGlvbiBpcyAiZG8g
eW91IGhhdmUgRlcgd2hpY2ggZG9lc24ndCBzdXBwb3J0DQo+IEdETUFfQUNDRVNTX0ZMQUdfUkVN
T1RFX0FUT01JQz8gYW5kIHdoYXQgd2lsbCBoYXBwZW4gaWYgc3VjaCBmbGFnDQo+IHVzZWQgZm9y
IHN1Y2ggRlc/Ig0KDQpBcyBmYXIgYXMgSSBhbSBhd2FyZSwgYWxsIEZXIHN1cHBvcnQgdGhpcyBm
bGFnLg0KTm9uZXRoZWxlc3MsIGlmIEZXIGRvZXMgbm90IHN1cHBvcnQgaXQsIHRoZSBIVyByZXF1
ZXN0IHRvIGNyZWF0ZSBNUiB3aWxsIGZhaWwuDQoNCj4gDQo+ID4gSSBhbHNvIGRvIG5vdCBzZWUg
YW55IGNvbmRpdGlvbnMgaW4gb3RoZXIgZHJpdmVycy4NCj4gDQo+IEF0IGxlYXN0IGZvciBtbHg1
LCB3ZSBhcmUgY2hlY2tpbmcgRlcgY2FwYWJpbGl0eSBpZiBpdCBpcyBzdXBwb3J0ZWQuDQo+IFNl
ZSBnZXRfdW5jaGFuZ2VhYmxlX2FjY2Vzc19mbGFncygpLg0KPiANCj4gPg0KPiA+IC0gS29uc3Rh
bnRpbg0KPiA+DQo+ID4gPg0KPiA+ID4gVGhhbmtzDQo+ID4gPg0KPiA+ID4gPiArDQo+ID4gPiA+
ICAJcmV0dXJuIGZsYWdzOw0KPiA+ID4gPiAgfQ0KPiA+ID4gPg0KPiA+ID4gPiAtLQ0KPiA+ID4g
PiAyLjQzLjANCj4gPiA+ID4NCg==

