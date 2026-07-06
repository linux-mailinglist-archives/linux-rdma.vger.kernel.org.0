Return-Path: <linux-rdma+bounces-22798-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3xyPEKacS2rNWwEAu9opvQ
	(envelope-from <linux-rdma+bounces-22798-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 14:16:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BAD71063B
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 14:16:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=UbUlZS3a;
	dkim=pass header.d=oracle.onmicrosoft.com header.s=selector2-oracle-onmicrosoft-com header.b=p0BmndwK;
	dmarc=pass (policy=reject) header.from=oracle.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22798-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22798-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BED6302A725
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2026 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA908423795;
	Mon,  6 Jul 2026 12:07:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482DA423790;
	Mon,  6 Jul 2026 12:07:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339641; cv=fail; b=LLQqjOQZ8wjEaqvwFFWBsg+mIn4IY1ZkpVQSaDSyAQXxFa4Q1n99qlGBuJ9fLs6eaqmv4xAmiJs0gNBXLw5oEVhxVqG6gFoWpXTPL39w5TvOwTLES6U5GeLf8fUlszhOkbwSwhHklnQK+qKHK/ZfcCchiPetWhsPiEYfLgZe6vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339641; c=relaxed/simple;
	bh=67CkVnj11Pd79eq4wgsQrv6PcEZ2bHA7TwCTTS6+KGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ekgG+PlmsvdkoDvc/yXpmCTtJ2BQfmhhYr0V0zHe/itTGMZQg0ZcGOJ4bIftdb4IuZGrnar3ETFH2/ZXj2koHAvup91SOGQFCLKY8AsofZHw1PTUTJBB0PaqId5Pz4187NjjT9J46vnpT82+8InQv+cS9j/UMqiN1nBDETPap3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UbUlZS3a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p0BmndwK; arc=fail smtp.client-ip=205.220.177.32
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6661WlnV1520821;
	Mon, 6 Jul 2026 12:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=q2AIFr2Dwfz4kLjsl0zB2sxVu3zO2jl5ebDb80WajYs=; b=
	UbUlZS3aamQzeYbLFvOAQwxEk0wEjxoLRZIZMxrAk9gkp0344mAmesUbYk1pvbKq
	Ha2jypRLZf39zR2oPnDyEfhJy2JxWip2G7opwHIdcocMkoNO3OqKfoUIdqopgJ/c
	XfXFDjlWjoxWRIrTit5CVwAyypdoSxZZHFUNb0nQbh47+k0eIw8kBLrsOTlrBV5d
	X3kfRcUzxu5h+V2KM8Wl4A9TQDWG83qwM1Fg3o4uJlSYxEKPdIih09dSskK5n8Aj
	qQDjsBCc0VaCDBu7Rj59fDQZLuaIAJiJR+0UJtNsmBHpKf6QbwH7IsHSkbj6q/JY
	pztDfZBvhnbHMrsac8dhSw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6t7ckgpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jul 2026 12:07:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 666C37Il026967;
	Mon, 6 Jul 2026 12:07:13 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f6rmc1g98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jul 2026 12:07:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRTEngZjeDVgAoucl0ckX9qMfl/f9fCumCDTYZWRSCIWthjjwR7VUw9vcmrSSAhN3PxtjVxSKQWzxUqV350Ue49h72hdxPx6vPXhdo9HxZrLKU2ohbdZzyENALWGneioT/fBDIg4K3yFxXSLHRbFAF5yujgPmf8jupARdBlfIlizK48KkD04FBYghDM4kcLDChoYTH5yIHop/xiCnBaw3wkCeu8GuCeLGDlxEuzkcgATHVFNbZzl6DOOLdCcK7679agnjI9OyVkPxhdmxSbAyk3ZVDU35FFmYLT5KmiBHvw4awnBdxjkAybHhjthOB2W5vddo3egCEYCaRl6gKUdHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2AIFr2Dwfz4kLjsl0zB2sxVu3zO2jl5ebDb80WajYs=;
 b=zFbZqczLbbFK2NMNPjy6hYxtoAQ74PsjV2VPKKZ2F1uOOhSxydqT39G8t0Yge1BrpOp0o2hCA1REx+M4EU87N3bd4kwBotEitdXbPjQQUrfJx8KD2sQulJpefr+q1jqC925tzfipz4m3WFIXMIIVW1xS+at9zovNXkkem6qNztcQOJgR+CARoCpnlj4SVtS1El9Wyunehq8o8+C+8yU6AeEUulcnsSpThG/Jld3mZDMhqj9YRBdon331JKf8wCWTm8bRJHRihB9adkoBhO8SB+em/TsUpig1Uh9dwoM5MgmiDxCiIzGAWYoYgGM85ZZ/Wm3K14GDWXAFcYdeNx4dWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2AIFr2Dwfz4kLjsl0zB2sxVu3zO2jl5ebDb80WajYs=;
 b=p0BmndwKY2EXv2o2oZTtxycxnaKQ9z+2SQ/5Egvo1HNhdZ3FAkA+ViztGbSHTkejmPLt8eZ+5HGwXVn7/PCy5IFDSSZhPY2+LNJG/cX39jyOVDn5ftVrqziEZCYPSbLkfX0sfYeiQO5qdGxG1nWsjbFsHJQxPulF4Wag+auHfTc=
Received: from BL0PR10MB2820.namprd10.prod.outlook.com (2603:10b6:208:75::10)
 by PH3PPF749D86B39.namprd10.prod.outlook.com (2603:10b6:518:1::7ac) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 12:07:07 +0000
Received: from BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260]) by BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260%5]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 12:07:07 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Praveen Kannoju <praveen.kannoju@oracle.com>,
        "yishaih@nvidia.com"
	<yishaih@nvidia.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Manjunath Patil <manjunath.b.patil@oracle.com>,
        Anand Khoje
	<anand.a.khoje@oracle.com>
Subject: RE: [PATCH v2] IB/mlx4: Fix stale CM id_map entries when RTU is never
 received
Thread-Topic: [PATCH v2] IB/mlx4: Fix stale CM id_map entries when RTU is
 never received
Thread-Index: AQHdDT902skfy2xlik+nmHUM+X9tALZgZPCQ
Date: Mon, 6 Jul 2026 12:07:06 +0000
Message-ID:
 <BL0PR10MB282074FA0D571F5072DFCB4B8CF12@BL0PR10MB2820.namprd10.prod.outlook.com>
References: <20260706120255.639985-1-praveen.kannoju@oracle.com>
In-Reply-To: <20260706120255.639985-1-praveen.kannoju@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-07-06T12:05:20.0000000Z;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR10MB2820:EE_|PH3PPF749D86B39:EE_
x-ms-office365-filtering-correlation-id: f4b4248c-d74f-433b-f88d-08dedb571993
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|5023799004|56012099006|18002099003|22082099003|6133799003|38070700021;
x-microsoft-antispam-message-info:
 jINZF1MS5vKPwWevr7BA9OW7+JMQ7cTeMxjj4ARDyrTNtzQgaeixIj9lyvWWGU0unbaxX2Mcm50fR+OL0tqkZixDNYBeByx+27kWKXnFn9ByCs5hYo2GpP2u3vGrbR/AYNYzpIRnFmEaHTYMhLzzna+fBTuaha4xWL/M/qQq4BWtoO8e1Ij+jAot7C4iH/uVXCUHwushNq0jeEVCs5j9Lzd4e6EjBH+wiszhVYYkmkExijZ6KFkR704XDo0sEy9g7bmTsWNXeiXER4jwO948XjDG5OOdJBMtkHZPfwm3TLioel0aSLNxwSS8vsmtV/TJgQAPIaFRBa9Ce8smoYMDtfmmkXq95ANTZ2dCDmOq8iLWe/Od60/km4FMpDLfwknqHHQBN3iZ3mdIeBvkbUV7oSOyql7CuNSVxWEABSwjVEF97nxHKvQnolr6GL5SN2DnPaFQOM7gd7mx7/+N1WqGoUtfiY6z62PSctwJt5tpKp2k95CmC5/HdEiY6pQGyBX25EPqd6/X7QXmxQg5BilKjEgVTp9ceIpQ04YRQJZC++wqOKBXNSYCRTk+keseI4AgIAwUuCmwl9LAJCPNmOg4m9mUJEqa7nzR7ZNBZU9tB3a4+Y2XwBq9+lA9Jwg8ujNXlAP5+X5L6VhFFKRvf9JjS1EkGsC0PoHV/X/bJ1qYiVAztUXN0wrAnbItm4SWstR49EA7CjDGMMLKGYhVN7Z2a2d8XJuoI6imz00nBw3K9gQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB2820.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(5023799004)(56012099006)(18002099003)(22082099003)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?VlNEeHZWdk1kaHNtaWdHUXlhZkFTdzRZaista1dZdG93eVUxcXVQVGZVb0Zj?=
 =?utf-7?B?SXN6OGozSWk0dDI0QWgrLUE3QS9JNWczZWMwRmpoeHp5T282VlM0WTVoVnhu?=
 =?utf-7?B?Q1RXTDVtZTAzKy1ONEdGWGJZOTV0Z3BMKy1mVHA4MDV6UllyajFVM1p5OHdO?=
 =?utf-7?B?QUhSTkFFKy1tbWlIUDNjVWVJZ1ovVnBkMDlsYURUMmgvVG1XUEJWYTB0dkc0?=
 =?utf-7?B?enNiV2dlWUJ5MmFndVhMMVg3azAvcGJ0RHlkU3ZNdWtuQXdCVEZyQnpjOEhy?=
 =?utf-7?B?cXNhUHJZQWgrLWJ1eVAzUGpHY3hnS0d4eldJVHZEb3R4VjE3eTZDZVcvSVRJ?=
 =?utf-7?B?YWplOUJEMVMxV1ByKy16dHpxaDlQQmRuTVRoREJ2cEhaV245UlpmdTVSdlBK?=
 =?utf-7?B?SGFLem80M2plNVhZYzAvN1dhL1cvN1piUFBKKy1RTVF4M202RmdQSkNDcWRi?=
 =?utf-7?B?MVBKYlFocTNzallmOUdBdjhTTVF6WjZjSWczemF3UDllZDB6V013N01HYzY4?=
 =?utf-7?B?eXlteG9sQistcGNUVlY3OVhUOS90bnd0cjRHSkh1LzduNTBVd1FLQkkxcXBJ?=
 =?utf-7?B?NUpWSGJwdEoxMVdza2JJdThrKy1vUnRCb2pXblpTL3NSQVAvcmtrV2xCWDNr?=
 =?utf-7?B?dzk2QVNkSDdRa2NPVEUyMWZ0M1BRZUd3amJpMFJJZEpsMW1Ld2ljTWcrLXZr?=
 =?utf-7?B?MkhsOHZJQjR1YkZYRkNXaElxNDFBbm9XY1NyQ0VlMUhPRVVKSGJTbzcrLVp6?=
 =?utf-7?B?TGxLeEYwd0dNOHV6THpaM2l5ajVyRVBKcTFTN0VQSUFUNW9Qd0hUNW42dCst?=
 =?utf-7?B?STdPNDhvaTJLQVEvNEFmaHFGVkNSclUyKy1LN21YTGU4bDZLZmEvZ2VHRlcy?=
 =?utf-7?B?VEhaRy9yVEdva3Bnc2JESkswUmVIS1lkeUUvdVVNeGpUU3hJWExEaTAwWG4w?=
 =?utf-7?B?NmpzY3dhWUNldTl3V3VXaXlxWlpVc1lnRVRDYzA5OUlOQk5PL0lZd1lOaGZw?=
 =?utf-7?B?eEcwRjBDc3NMTW0xY040SElnUDFDaUg5aVhqb3JCd3dRSk1hYk1uTTFCbUlh?=
 =?utf-7?B?Q0dIR1JPZGtZNXhKT3ZTRDRJcG9rKy12VVVMZXRoMEJnWlRXQnViQ2p2RTg2?=
 =?utf-7?B?a0hpdFZGeVBuMkZuUk5CR1g2Sm1RcUNhRkJoUWdmRGI5eU9HeWM3SzYxUFB1?=
 =?utf-7?B?Njd0aSstQk8ycmhQZXA2UEg4ZFd1U3I3YSstSEZDZzM0Z3VtdEtHd1Iyc2dU?=
 =?utf-7?B?MlhXbElSOWxvd3lESnZKWEFUTEUyUWFPek9WZW9PWUlvWk5JNlJUeUlkbGhE?=
 =?utf-7?B?WFBoU0RyZkIrLWtnQmpYRzE3eVpSb1BVdU5LdFd5T1RXT1VPRTdVcW05TWlQ?=
 =?utf-7?B?aGQ5RmZLR0RIMmFjcW9QTkxxRVBsUWpjdDhZVDFScUt5Rm4wS09PWWlnYWVU?=
 =?utf-7?B?TXlIL3RvYlUxUUQwNzNCTmVmeThkdEZSNzcydnpwOGVOVWlSKy1CL1E1R3pv?=
 =?utf-7?B?WUFrZ0IwSENNRnhXNkRhNWlrTGczRGJ2MzFObUJaSm5LYzJDRUpFZjdNKy1o?=
 =?utf-7?B?dEZGTkhJVzcvMFRXOFE3RTlmYkJRUTdEcXdnQ05PT2ZwU2dmY0NFTEYxbHJl?=
 =?utf-7?B?RC9saVpsMmVxMnRqdXRta0FNbW1SZXdwcG9OMWdoVGVlTHN4VzZHUmdHUTlT?=
 =?utf-7?B?TUEyR2dOd0w5UGRQVVRRN1JIL0phZEhsakovOWNqUWxSRUYyM25iSGJJbU10?=
 =?utf-7?B?TmY1dTRXVmlhS05Vczl2MVNXKy0zWFJoeExlQW5leHZobEIwU3BaVG40QmlK?=
 =?utf-7?B?VzY2Vks5OTV2SG5HSystaDlYN0t6S2tQbEdHSGgydkVBKy1vTnJvNHgydlBW?=
 =?utf-7?B?bFU4akJzMCsteXhvR2FrQTVmQ0VKa0pMREg4YystdVh0MHh2RmE1bFBXc2pO?=
 =?utf-7?B?eUQ4Q2dpVXhYUlhNNHdzWHFlUWJ3Z0F3OSstTnNlWDVqQ1BwWUNsMmhRYUNK?=
 =?utf-7?B?Z3N3QmZFODRPZHlOSCstKy1oS1hiYnEyTG1tajQzRHhFb05UbkV2blVONmRt?=
 =?utf-7?B?czYwdGRqVmMybmtteEh6YjRNRGsrLWRkNGhqSkxhQWlNWVFKaXhlcmEyRyst?=
 =?utf-7?B?VUlwc01rVXZ0dm91Q0RaNWdwbmZ1Zkhna0dYRnl1M1lOOFNRS2VvRFp1Vy9r?=
 =?utf-7?B?cGJXcDJFTHNMcWxycUxHam1nL2ZvSkV4VSstbU5HOENSU24vZG5sM2xDdUkx?=
 =?utf-7?B?aTBxdXEwYlVjZk04cnZmTXJONm1MNmJnYkIxUzU4RjNJRGlFTVZEdk0wKy0=?=
 =?utf-7?B?Ky1Tbm5wcVNEWThmSkEwWFVCQ1Vjc3U4bUhqMHN2UDFjMistQnVDVHE2Szlw?=
 =?utf-7?B?OERIMGgxYk9zNHpkOXExdlcxKy1nSGhVZ1YrLTIyeVErQUQwQVBRLQ==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Nvos9/MKjg69IWGSNlUlIgcKrUvFr3f+f94dJfC7Cwe5FMN0oOvR6VmP13bqWIcj+nuFj/TsqqWhAa5ybsfKx2D0ZlczzTmtjwuu+pIhrKZYoTkfZb9B9t1YzyhY0ZAY9IvDFKMPW6cN9SA+nh+j2iL9GBE+uKBKHlQX5gydXM2VXszoPs1lrrusTWBl+fuaG/ndjx20XI2fTcjFJIdsltfxeqewhAK97NOqIichcVZJzZDBfdtrjl85gdRDlOp4PcETJSTKzxU1VPCp6CJtTCr5+5Z3pMU9a6foUSncrnpt1Kh6RhMWpilR9V5Jcb2xGb/DNf9XjEd9jZaj1Vyc6w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HKMz3OJ6jXpKEyo3oAhKNHsmIW01JYxmFycaNTG5I033ws4TafZdOwLqm5xRp4vdVt/Ra/N9oc7n4Q5WPh3FY/yBca7oaFRRx8B+ps5OYT3AyWET4dkwhe5z+bQvFt1KNsXKvkwzpaSp3UNZUWbM1YyFrjpszGfbJ/Jk4OBREQ1bGG6Bu4IAr2OAZHHDeT0qlS9/Q6dTnHyxfoWl2hhhAJNUV7rxBPPb01qO2ejr6rcttPySLPRcC47lV4RRjQoXxtTJTVJ6DZFUqThLkYUcGNA9IjhWB8sU5fJMs7LiULy7rnSVsTXQcDJp1tMWZZdEBHE1Cod9bZA/VQ+XH7WTwT6oO+3lFSTDJUOT61aBG5YMMTUBrDGVI3IR1AY9mn4xwy4tPbNXGwgQxFQbyiOQNNFdW48lnzctchfaav71WFFIyzgxeEPtIuNijClokBf9nP5qcuayBWZ6iTZTAIjG5rksnF+0wO28VI67BsMQrPLLJgSsjudsQSOT3/Db3QSOFeqP+4Tr2s/gR9CqwOOYSPQ0GGHtggrgOwLjgkZhCeqbmsLF1mRC9pRngDfff6T9CwOZXbe3kUhgMneu1gaINazPVrs4qQ/VLTz3uzuC76I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB2820.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b4248c-d74f-433b-f88d-08dedb571993
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 12:07:07.0479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NSU2qTMS++Fa8Bvp2CrjhbFygbBHLAuOAHx8GBO9Dpv9/G70kddcwA6q1MA8ZH75qcnT/95Hj5X2qab7mC5Wd6eBITKcHmYxd/TtXi5HG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF749D86B39
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607060122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyMyBTYWx0ZWRfX6w4ha0d7DRHN
 9cjZOazg+NTwHTymUwIaVr8cZnBCXELApxWvh7e3xMLYDm6H/xmH5NGM2XsAZp+4mCbC2sxf+/b
 CjIQn+Wj1w7RMzoWCfDG/tHzJsVjffPCGFXXPvqDKvsBM9bopblufpSQiiKX2IugKrtgzTGodYY
 wIrTkcP5wFFY4D80GGsbwJCdRd3mfc5IOhau/n/GaGwy742Y059YyG0x0tmu4hzGLoybyDEOKNE
 9fj9hDNbyJP7uev8JtCsYTrdSb7y+w8sE2dQtiJFi9PZEtdGULw4ow/qPg8BvwHBqKwtIpP1UIm
 SfYHtjln6I97JaCXu62tG0Dt2aryokHUa/kFpk5DBJHusMg/bP/La0yRS0B1fPdX6s+vjx/Zzvm
 Aek7vfMBvMQMH3W7oAbnZSvpJ2G0DWiP9gLitpwwCrDBjELKDKwteW+spbF9E1KfeWx5nR1dSqq
 YuDlueJcnc2rfnkfNow==
X-Authority-Analysis: v=2.4 cv=P+QKQCAu c=1 sm=1 tr=0 ts=6a4b9a72 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10 a=YU3QZWNX-B8A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=9jRdOu3wAAAA:8 a=mQvHCebiAAAA:8 a=BXszkKfDAAAA:8 a=Fofg-9D3AAAA:8
 a=c1PdSmG1AAAA:8 a=9ChLSRsqvVNCNiDvsEoA:9 a=avxi3fN6y70A:10
 a=WmVTiCyuxqgg3mnwYu6p:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=wsrb8zZI_WQ3QAEBCXTy:22
 a=duu7wrcty9prphiCz_fF:22 a=Xbaoi9ZUBzzYp91LqZJF:22 a=4iM0TfZbaBQr0p37pvCp:22
X-Proofpoint-GUID: XCb0Ba6rgbJ7dL94wwIkCiMwkVtaYp0t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyMyBTYWx0ZWRfXwcd9k1LsaMrj
 li/1ZqRczGLgDYYKyeUW1ySHnt7re10AHTKJ0I2O/2yydUZGW7FOHhve8cujwL0rZQs+BpwDn4n
 fHFrT3eOTDz+p9XWOJhakUQ5KZlCVdvtwsgrWiYyDbpb1Ly+zBRZ
X-Proofpoint-ORIG-GUID: XCb0Ba6rgbJ7dL94wwIkCiMwkVtaYp0t
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22798-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oracle.com:from_mime,oracle.com:email,oracle.com:dkim,nvidia.com:email,oracle.onmicrosoft.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:praveen.kannoju@oracle.com,m:yishaih@nvidia.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:manjunath.b.patil@oracle.com,m:anand.a.khoje@oracle.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9BAD71063B

Oracle Confidential

+- Anand, Manjunath.


Oracle Confidential
+AD4- -----Original Message-----
+AD4- From: Praveen Kumar Kannoju +ADw-praveen.kannoju+AEA-oracle.com+AD4-
+AD4- Sent: Monday, July 6, 2026 5:33 PM
+AD4- To: yishaih+AEA-nvidia.com+ADs- jgg+AEA-ziepe.ca+ADs- leon+AEA-kernel=
.org+ADs- linux-
+AD4- rdma+AEA-vger.kernel.org+ADs- linux-kernel+AEA-vger.kernel.org
+AD4- Cc: Praveen Kannoju +ADw-praveen.kannoju+AEA-oracle.com+AD4-
+AD4- Subject: +AFs-PATCH v2+AF0- IB/mlx4: Fix stale CM id+AF8-map entries =
when RTU is never
+AD4- received
+AD4-
+AD4- mlx4+AF8-ib+AF8-multiplex+AF8-cm+AF8-handler() allocates an id+AF8-ma=
p+AF8-entry for CM
+AD4- transactions, but the entry is normally released only on DREQ or REJ
+AD4- flows.
+AD4-
+AD4- In the duplicate REP handling scenario, cm+AF8-dup+AF8-rep+AF8-handle=
r() may be
+AD4- invoked when the remote side receives a REP for which no matching
+AD4- cm+AF8-id+AF8-priv exists. In such cases the CM handshake never reach=
es RTU, and
+AD4- the sender side may never receive either DREQ or REJ cleanup events.
+AD4-
+AD4- As a result, the allocated id+AF8-map+AF8-entry remains indefinitely,=
 resulting in
+AD4- a stale mapping leak.
+AD4-
+AD4- Fix this by arming an RTU-abandon cleanup timeout when the id+AF8-map=
+AF8-entry is
+AD4- allocated. The timeout uses the mlx4 CM workqueue and the existing
+AD4- schedule+AF8-delayed() path, so later DREQ/REJ cleanup can shorten th=
e pending
+AD4- timeout with mod+AF8-delayed+AF8-work().
+AD4-
+AD4- Track whether a pending cleanup timeout is still waiting for RTU. RTU
+AD4- cancels only that initial timeout+ADs- if DREQ/REJ has already conver=
ted it to
+AD4- normal teardown cleanup, a late or duplicate RTU does not cancel the
+AD4- teardown timer. If the RTU timeout callback has already started, leav=
e the
+AD4- entry on the timeout path and make the RTU packet lose that race.
+AD4-
+AD4- Hold id+AF8-map+AF8-lock while looking up the entry, canceling the RT=
U timeout,
+AD4- scheduling teardown cleanup, and copying the id values needed by the =
CM
+AD4- handlers. The delayed-work callback rechecks scheduled+AF8-delete und=
er the
+AD4- same lock before removing and freeing the entry, avoiding use-after-f=
ree
+AD4- when RTU races with timeout execution.
+AD4-
+AD4- Signed-off-by: Praveen Kumar Kannoju +ADw-praveen.kannoju+AEA-oracle.=
com+AD4-
+AD4- ---
+AD4- v1: https://lore.kernel.org/linux-rdma/20260507154755.452008-1-
+AD4- praveen.kannoju+AEA-oracle.com/T/+ACM-u
+AD4-
+AD4- Changes in v2:
+AD4- - Queue the RTU-abandon timeout on the mlx4 CM workqueue through
+AD4-   schedule+AF8-delayed() and use mod+AF8-delayed+AF8-work() so DREQ/R=
EJ cleanup can
+AD4-   shorten a pending RTU timeout.
+AD4- - Track RTU-abandon cleanup separately from normal DREQ/REJ cleanup s=
o a
+AD4-   late or duplicate RTU does not cancel a teardown timer.
+AD4- - Hold id+AF8-map+AF8-lock while looking up id+AF8-map entries, cance=
ling or updating
+AD4-   delayed work, and copying CM IDs needed by the handlers.
+AD4- - Make RTU lose the race when the timeout callback has already starte=
d.
+AD4-
+AD4-  drivers/infiniband/hw/mlx4/cm.c +AHw- 101
+AD4- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+----------=
-
+AD4-  1 file changed, 76 insertions(+-), 25 deletions(-)
+AD4-
+AD4- diff --git a/drivers/infiniband/hw/mlx4/cm.c
+AD4- b/drivers/infiniband/hw/mlx4/cm.c
+AD4- index 63a868a..f7905df 100644
+AD4- --- a/drivers/infiniband/hw/mlx4/cm.c
+AD4- +-+-+- b/drivers/infiniband/hw/mlx4/cm.c
+AD4- +AEAAQA- -40,6 +-40,7 +AEAAQA-
+AD4-  +ACM-include +ACI-mlx4+AF8-ib.h+ACI-
+AD4-
+AD4-  +ACM-define CM+AF8-CLEANUP+AF8-CACHE+AF8-TIMEOUT  (30 +ACo- HZ)
+AD4- +-+ACM-define CM+AF8-RTU+AF8-TIMEOUT                 (60 +ACo- HZ)
+AD4-
+AD4-  struct id+AF8-map+AF8-entry +AHs-
+AD4-       struct rb+AF8-node node+ADs-
+AD4- +AEAAQA- -48,6 +-49,7 +AEAAQA- struct id+AF8-map+AF8-entry +AHs-
+AD4-       u32 pv+AF8-cm+AF8-id+ADs-
+AD4-       int slave+AF8-id+ADs-
+AD4-       int scheduled+AF8-delete+ADs-
+AD4- +-     bool rtu+AF8-timeout+ADs-
+AD4-       struct mlx4+AF8-ib+AF8-dev +ACo-dev+ADs-
+AD4-
+AD4-       struct list+AF8-head list+ADs-
+AD4- +AEAAQA- -184,6 +-186,10 +AEAAQA- static void id+AF8-map+AF8-ent+AF8-=
timeout(struct work+AF8-struct
+AD4- +ACo-work)
+AD4-       struct rb+AF8-root +ACo-sl+AF8-id+AF8-map +AD0- +ACY-sriov-+AD4=
-sl+AF8-id+AF8-map+ADs-
+AD4-
+AD4-       spin+AF8-lock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4- +-     if (+ACE-ent-+AD4-scheduled+AF8-delete) +AHs-
+AD4- +-             spin+AF8-unlock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+A=
Ds-
+AD4- +-             return+ADs-
+AD4- +-     +AH0-
+AD4-       if (+ACE-xa+AF8-erase(+ACY-sriov-+AD4-pv+AF8-id+AF8-table, ent-=
+AD4-pv+AF8-cm+AF8-id))
+AD4-               goto out+ADs-
+AD4-       found+AF8-ent +AD0- id+AF8-map+AF8-find+AF8-by+AF8-sl+AF8-id(+A=
CY-dev-+AD4-ib+AF8-dev, ent-+AD4-slave+AF8-id, ent-
+AD4- +AD4-sl+AF8-cm+AF8-id)+ADs-
+AD4- +AEAAQA- -228,8 +-234,12 +AEAAQA- static void sl+AF8-id+AF8-map+AF8-a=
dd(struct ib+AF8-device +ACo-ibdev,
+AD4- struct id+AF8-map+AF8-entry +ACo-new)
+AD4-       rb+AF8-insert+AF8-color(+ACY-new-+AD4-node, sl+AF8-id+AF8-map)+=
ADs-
+AD4-  +AH0-
+AD4-
+AD4- +-static void schedule+AF8-delayed(struct ib+AF8-device +ACo-ibdev, s=
truct id+AF8-map+AF8-entry
+AD4- +ACo-id,
+AD4- +-                          unsigned long timeout, bool rtu+AF8-timeo=
ut)+ADs-
+AD4- +-
+AD4-  static struct id+AF8-map+AF8-entry +ACo-
+AD4- -id+AF8-map+AF8-alloc(struct ib+AF8-device +ACo-ibdev, int slave+AF8-=
id, u32 sl+AF8-cm+AF8-id)
+AD4- +-id+AF8-map+AF8-alloc(struct ib+AF8-device +ACo-ibdev, int slave+AF8=
-id, u32 sl+AF8-cm+AF8-id,
+AD4- +-          u32 +ACo-pv+AF8-cm+AF8-id)
+AD4-  +AHs-
+AD4-       int ret+ADs-
+AD4-       struct id+AF8-map+AF8-entry +ACo-ent+ADs-
+AD4- +AEAAQA- -242,6 +-252,7 +AEAAQA- id+AF8-map+AF8-alloc(struct ib+AF8-d=
evice +ACo-ibdev, int slave+AF8-id,
+AD4- u32 sl+AF8-cm+AF8-id)
+AD4-       ent-+AD4-sl+AF8-cm+AF8-id +AD0- sl+AF8-cm+AF8-id+ADs-
+AD4-       ent-+AD4-slave+AF8-id +AD0- slave+AF8-id+ADs-
+AD4-       ent-+AD4-scheduled+AF8-delete +AD0- 0+ADs-
+AD4- +-     ent-+AD4-rtu+AF8-timeout +AD0- false+ADs-
+AD4-       ent-+AD4-dev +AD0- to+AF8-mdev(ibdev)+ADs-
+AD4-       INIT+AF8-DELAYED+AF8-WORK(+ACY-ent-+AD4-timeout, id+AF8-map+AF8=
-ent+AF8-timeout)+ADs-
+AD4-
+AD4- +AEAAQA- -251,6 +-262,8 +AEAAQA- id+AF8-map+AF8-alloc(struct ib+AF8-d=
evice +ACo-ibdev, int slave+AF8-id,
+AD4- u32 sl+AF8-cm+AF8-id)
+AD4-               spin+AF8-lock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4-               sl+AF8-id+AF8-map+AF8-add(ibdev, ent)+ADs-
+AD4-               list+AF8-add+AF8-tail(+ACY-ent-+AD4-list, +ACY-sriov-+A=
D4-cm+AF8-list)+ADs-
+AD4- +-             +ACo-pv+AF8-cm+AF8-id +AD0- ent-+AD4-pv+AF8-cm+AF8-id+=
ADs-
+AD4- +-             schedule+AF8-delayed(ibdev, ent, CM+AF8-RTU+AF8-TIMEOU=
T, true)+ADs-
+AD4-               spin+AF8-unlock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+AD=
s-
+AD4-               return ent+ADs-
+AD4-       +AH0-
+AD4- +AEAAQA- -261,48 +-274,46 +AEAAQA- id+AF8-map+AF8-alloc(struct ib+AF8=
-device +ACo-ibdev, int slave+AF8-id,
+AD4- u32 sl+AF8-cm+AF8-id)
+AD4-       return ERR+AF8-PTR(-ENOMEM)+ADs-
+AD4-  +AH0-
+AD4-
+AD4- +-/+ACo- Lock should be taken before called +ACo-/
+AD4-  static struct id+AF8-map+AF8-entry +ACo-
+AD4-  id+AF8-map+AF8-get(struct ib+AF8-device +ACo-ibdev, int +ACo-pv+AF8-=
cm+AF8-id, int slave+AF8-id, int sl+AF8-cm+AF8-id)
+AD4-  +AHs-
+AD4-       struct id+AF8-map+AF8-entry +ACo-ent+ADs-
+AD4- -     struct mlx4+AF8-ib+AF8-sriov +ACo-sriov +AD0- +ACY-to+AF8-mdev(=
ibdev)-+AD4-sriov+ADs-
+AD4-
+AD4- -     spin+AF8-lock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4-       if (+ACo-pv+AF8-cm+AF8-id +AD0APQ- -1) +AHs-
+AD4-               ent +AD0- id+AF8-map+AF8-find+AF8-by+AF8-sl+AF8-id(ibde=
v, slave+AF8-id, sl+AF8-cm+AF8-id)+ADs-
+AD4-               if (ent)
+AD4-                       +ACo-pv+AF8-cm+AF8-id +AD0- (int) ent-+AD4-pv+A=
F8-cm+AF8-id+ADs-
+AD4-       +AH0- else
+AD4- -             ent +AD0- xa+AF8-load(+ACY-sriov-+AD4-pv+AF8-id+AF8-tab=
le, +ACo-pv+AF8-cm+AF8-id)+ADs-
+AD4- -     spin+AF8-unlock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4- +-             ent +AD0- xa+AF8-load(+ACY-to+AF8-mdev(ibdev)-+AD4-sri=
ov.pv+AF8-id+AF8-table,
+AD4- +ACo-pv+AF8-cm+AF8-id)+ADs-
+AD4-
+AD4-       return ent+ADs-
+AD4-  +AH0-
+AD4-
+AD4- -static void schedule+AF8-delayed(struct ib+AF8-device +ACo-ibdev, st=
ruct id+AF8-map+AF8-entry
+AD4- +ACo-id)
+AD4- +-/+ACo- Lock should be taken before called +ACo-/
+AD4- +-static void schedule+AF8-delayed(struct ib+AF8-device +ACo-ibdev, s=
truct id+AF8-map+AF8-entry
+AD4- +ACo-id,
+AD4- +-                          unsigned long timeout, bool rtu+AF8-timeo=
ut)
+AD4-  +AHs-
+AD4-       struct mlx4+AF8-ib+AF8-sriov +ACo-sriov +AD0- +ACY-to+AF8-mdev(=
ibdev)-+AD4-sriov+ADs-
+AD4-       unsigned long flags+ADs-
+AD4-
+AD4- -     spin+AF8-lock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4-       spin+AF8-lock+AF8-irqsave(+ACY-sriov-+AD4-going+AF8-down+AF8-lo=
ck, flags)+ADs-
+AD4-       /+ACo-make sure that there is no schedule inside the scheduled =
work.+ACo-/
+AD4- -     if (+ACE-sriov-+AD4-is+AF8-going+AF8-down +ACYAJg- +ACE-id-+AD4=
-scheduled+AF8-delete) +AHs-
+AD4- +-     if (+ACE-sriov-+AD4-is+AF8-going+AF8-down +AHwAfA- id-+AD4-sch=
eduled+AF8-delete) +AHs-
+AD4-               id-+AD4-scheduled+AF8-delete +AD0- 1+ADs-
+AD4- -             queue+AF8-delayed+AF8-work(cm+AF8-wq, +ACY-id-+AD4-time=
out,
+AD4- CM+AF8-CLEANUP+AF8-CACHE+AF8-TIMEOUT)+ADs-
+AD4- -     +AH0- else if (id-+AD4-scheduled+AF8-delete) +AHs-
+AD4- -             /+ACo- Adjust timeout if already scheduled +ACo-/
+AD4- -             mod+AF8-delayed+AF8-work(cm+AF8-wq, +ACY-id-+AD4-timeou=
t,
+AD4- CM+AF8-CLEANUP+AF8-CACHE+AF8-TIMEOUT)+ADs-
+AD4- +-             id-+AD4-rtu+AF8-timeout +AD0- rtu+AF8-timeout+ADs-
+AD4- +-             mod+AF8-delayed+AF8-work(cm+AF8-wq, +ACY-id-+AD4-timeo=
ut, timeout)+ADs-
+AD4-       +AH0-
+AD4-       spin+AF8-unlock+AF8-irqrestore(+ACY-sriov-+AD4-going+AF8-down+A=
F8-lock, flags)+ADs-
+AD4- -     spin+AF8-unlock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4-  +AH0-
+AD4-
+AD4-  +ACM-define REJ+AF8-REASON(m) be16+AF8-to+AF8-cpu(((struct cm+AF8-ge=
neric+AF8-msg +ACo-)(m))-
+AD4- +AD4-rej+AF8-reason)
+AD4-  int mlx4+AF8-ib+AF8-multiplex+AF8-cm+AF8-handler(struct ib+AF8-devic=
e +ACo-ibdev, int port, int
+AD4- slave+AF8-id,
+AD4-               struct ib+AF8-mad +ACo-mad)
+AD4-  +AHs-
+AD4- +-     struct mlx4+AF8-ib+AF8-sriov +ACo-sriov +AD0- +ACY-to+AF8-mdev=
(ibdev)-+AD4-sriov+ADs-
+AD4-       struct id+AF8-map+AF8-entry +ACo-id+ADs-
+AD4- +-     u32 pv+AF8-cm+AF8-id+AF8-to+AF8-set +AD0- 0+ADs-
+AD4-       u32 sl+AF8-cm+AF8-id+ADs-
+AD4-       int pv+AF8-cm+AF8-id +AD0- -1+ADs-
+AD4-
+AD4- +AEAAQA- -312,10 +-323,15 +AEAAQA- int mlx4+AF8-ib+AF8-multiplex+AF8-=
cm+AF8-handler(struct ib+AF8-device
+AD4- +ACo-ibdev, int port, int slave+AF8-id
+AD4-           mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-SIDR+AF8-R=
EQ+AF8-ATTR+AF8-ID +AHwAfA-
+AD4-           (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-REJ+AF8-A=
TTR+AF8-ID +ACYAJg- REJ+AF8-REASON(mad)
+AD4- +AD0APQ- IB+AF8-CM+AF8-REJ+AF8-TIMEOUT)) +AHs-
+AD4-               sl+AF8-cm+AF8-id +AD0- get+AF8-local+AF8-comm+AF8-id(ma=
d)+ADs-
+AD4- +-             spin+AF8-lock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs=
-
+AD4-               id +AD0- id+AF8-map+AF8-get(ibdev, +ACY-pv+AF8-cm+AF8-i=
d, slave+AF8-id, sl+AF8-cm+AF8-id)+ADs-
+AD4- +-             if (id)
+AD4- +-                     pv+AF8-cm+AF8-id+AF8-to+AF8-set +AD0- id-+AD4-=
pv+AF8-cm+AF8-id+ADs-
+AD4- +-             spin+AF8-unlock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+A=
Ds-
+AD4-               if (id)
+AD4-                       goto cont+ADs-
+AD4- -             id +AD0- id+AF8-map+AF8-alloc(ibdev, slave+AF8-id, sl+A=
F8-cm+AF8-id)+ADs-
+AD4- +-             id +AD0- id+AF8-map+AF8-alloc(ibdev, slave+AF8-id, sl+=
AF8-cm+AF8-id,
+AD4- +-                               +ACY-pv+AF8-cm+AF8-id+AF8-to+AF8-set=
)+ADs-
+AD4-               if (IS+AF8-ERR(id)) +AHs-
+AD4-                       mlx4+AF8-ib+AF8-warn(ibdev, +ACIAJQ-s: id+AHs-s=
lave: +ACU-d, sl+AF8-cm+AF8-id:
+AD4- 0x+ACU-x+AH0- Failed to id+AF8-map+AF8-alloc+AFw-n+ACI-,
+AD4-                               +AF8AXw-func+AF8AXw-, slave+AF8-id, sl+=
AF8-cm+AF8-id)+ADs-
+AD4- +AEAAQA- -326,7 +-342,25 +AEAAQA- int mlx4+AF8-ib+AF8-multiplex+AF8-c=
m+AF8-handler(struct ib+AF8-device
+AD4- +ACo-ibdev, int port, int slave+AF8-id
+AD4-               return 0+ADs-
+AD4-       +AH0- else +AHs-
+AD4-               sl+AF8-cm+AF8-id +AD0- get+AF8-local+AF8-comm+AF8-id(ma=
d)+ADs-
+AD4- +-             spin+AF8-lock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs=
-
+AD4-               id +AD0- id+AF8-map+AF8-get(ibdev, +ACY-pv+AF8-cm+AF8-i=
d, slave+AF8-id, sl+AF8-cm+AF8-id)+ADs-
+AD4- +-             if (id) +AHs-
+AD4- +-                     if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- =
CM+AF8-RTU+AF8-ATTR+AF8-ID +ACYAJg-
+AD4- +-                         id-+AD4-rtu+AF8-timeout) +AHs-
+AD4- +-                             id-+AD4-rtu+AF8-timeout +AD0- false+AD=
s-
+AD4- +-                             if (cancel+AF8-delayed+AF8-work(+ACY-i=
d-+AD4-timeout))
+AD4- +-                                     id-+AD4-scheduled+AF8-delete +=
AD0- 0+ADs-
+AD4- +-                             else
+AD4- +-                                     id +AD0- NULL+ADs-
+AD4- +-                     +AH0-
+AD4- +-                     if (id)
+AD4- +-                             pv+AF8-cm+AF8-id+AF8-to+AF8-set +AD0- =
id-+AD4-pv+AF8-cm+AF8-id+ADs-
+AD4- +-                     if (id +ACYAJg- mad-+AD4-mad+AF8-hdr.attr+AF8-=
id +AD0APQ-
+AD4- CM+AF8-DREQ+AF8-ATTR+AF8-ID)
+AD4- +-                             schedule+AF8-delayed(ibdev, id,
+AD4- +-
+AD4- CM+AF8-CLEANUP+AF8-CACHE+AF8-TIMEOUT,
+AD4- +-                                              false)+ADs-
+AD4- +-             +AH0-
+AD4- +-             spin+AF8-unlock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+A=
Ds-
+AD4-       +AH0-
+AD4-
+AD4-       if (+ACE-id) +AHs-
+AD4- +AEAAQA- -336,10 +-370,7 +AEAAQA- int mlx4+AF8-ib+AF8-multiplex+AF8-c=
m+AF8-handler(struct ib+AF8-device
+AD4- +ACo-ibdev, int port, int slave+AF8-id
+AD4-       +AH0-
+AD4-
+AD4-  cont:
+AD4- -     set+AF8-local+AF8-comm+AF8-id(mad, id-+AD4-pv+AF8-cm+AF8-id)+AD=
s-
+AD4- -
+AD4- -     if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-DREQ+AF8-A=
TTR+AF8-ID)
+AD4- -             schedule+AF8-delayed(ibdev, id)+ADs-
+AD4- +-     set+AF8-local+AF8-comm+AF8-id(mad, pv+AF8-cm+AF8-id+AF8-to+AF8=
-set)+ADs-
+AD4-       return 0+ADs-
+AD4-  +AH0-
+AD4-
+AD4- +AEAAQA- -429,7 +-460,10 +AEAAQA- int mlx4+AF8-ib+AF8-demux+AF8-cm+AF=
8-handler(struct ib+AF8-device
+AD4- +ACo-ibdev, int port, int +ACo-slave,
+AD4-       struct mlx4+AF8-ib+AF8-sriov +ACo-sriov +AD0- +ACY-to+AF8-mdev(=
ibdev)-+AD4-sriov+ADs-
+AD4-       u32 rem+AF8-pv+AF8-cm+AF8-id +AD0- get+AF8-local+AF8-comm+AF8-i=
d(mad)+ADs-
+AD4-       u32 pv+AF8-cm+AF8-id+ADs-
+AD4- +-     u32 sl+AF8-cm+AF8-id +AD0- 0+ADs-
+AD4-       struct id+AF8-map+AF8-entry +ACo-id+ADs-
+AD4- +-     int pv+AF8-cm+AF8-id+AF8-int+ADs-
+AD4- +-     int slave+AF8-id +AD0- 0+ADs-
+AD4-       int sts+ADs-
+AD4-
+AD4-       if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-REQ+AF8-AT=
TR+AF8-ID +AHwAfA-
+AD4- +AEAAQA- -457,7 +-491,28 +AEAAQA- int mlx4+AF8-ib+AF8-demux+AF8-cm+AF=
8-handler(struct ib+AF8-device
+AD4- +ACo-ibdev, int port, int +ACo-slave,
+AD4-       +AH0-
+AD4-
+AD4-       pv+AF8-cm+AF8-id +AD0- get+AF8-remote+AF8-comm+AF8-id(mad)+ADs-
+AD4- -     id +AD0- id+AF8-map+AF8-get(ibdev, (int +ACo-)+ACY-pv+AF8-cm+AF=
8-id, -1, -1)+ADs-
+AD4- +-     pv+AF8-cm+AF8-id+AF8-int +AD0- pv+AF8-cm+AF8-id+ADs-
+AD4- +-     spin+AF8-lock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4- +-     id +AD0- id+AF8-map+AF8-get(ibdev, +ACY-pv+AF8-cm+AF8-id+AF8-i=
nt, -1, -1)+ADs-
+AD4- +-     if (id) +AHs-
+AD4- +-             if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-R=
TU+AF8-ATTR+AF8-ID +ACYAJg-
+AD4- +-                 id-+AD4-rtu+AF8-timeout) +AHs-
+AD4- +-                     id-+AD4-rtu+AF8-timeout +AD0- false+ADs-
+AD4- +-                     if (cancel+AF8-delayed+AF8-work(+ACY-id-+AD4-t=
imeout))
+AD4- +-                             id-+AD4-scheduled+AF8-delete +AD0- 0+A=
Ds-
+AD4- +-                     else
+AD4- +-                             id +AD0- NULL+ADs-
+AD4- +-             +AH0-
+AD4- +-             if (id +ACYAJg- slave)
+AD4- +-                     slave+AF8-id +AD0- id-+AD4-slave+AF8-id+ADs-
+AD4- +-             if (id)
+AD4- +-                     sl+AF8-cm+AF8-id +AD0- id-+AD4-sl+AF8-cm+AF8-i=
d+ADs-
+AD4- +-             if (id +ACYAJg- (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0=
APQ- CM+AF8-DREQ+AF8-ATTR+AF8-ID +AHwAfA-
+AD4- +-                        mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- C=
M+AF8-REJ+AF8-ATTR+AF8-ID))
+AD4- +-                     schedule+AF8-delayed(ibdev, id,
+AD4- +-                                      CM+AF8-CLEANUP+AF8-CACHE+AF8-=
TIMEOUT,
+AD4- false)+ADs-
+AD4- +-     +AH0-
+AD4- +-     spin+AF8-unlock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4-
+AD4-       if (+ACE-id) +AHs-
+AD4-               if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-RE=
J+AF8-ATTR+AF8-ID +ACYAJg-
+AD4- +AEAAQA- -472,12 +-527,8 +AEAAQA- int mlx4+AF8-ib+AF8-demux+AF8-cm+AF=
8-handler(struct ib+AF8-device
+AD4- +ACo-ibdev, int port, int +ACo-slave,
+AD4-       +AH0-
+AD4-
+AD4-       if (slave)
+AD4- -             +ACo-slave +AD0- id-+AD4-slave+AF8-id+ADs-
+AD4- -     set+AF8-remote+AF8-comm+AF8-id(mad, id-+AD4-sl+AF8-cm+AF8-id)+A=
Ds-
+AD4- -
+AD4- -     if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-DREQ+AF8-A=
TTR+AF8-ID +AHwAfA-
+AD4- -         mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-REJ+AF8-AT=
TR+AF8-ID)
+AD4- -             schedule+AF8-delayed(ibdev, id)+ADs-
+AD4- +-             +ACo-slave +AD0- slave+AF8-id+ADs-
+AD4- +-     set+AF8-remote+AF8-comm+AF8-id(mad, sl+AF8-cm+AF8-id)+ADs-
+AD4-
+AD4-       return 0+ADs-
+AD4-  +AH0-

