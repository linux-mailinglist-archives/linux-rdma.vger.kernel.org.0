Return-Path: <linux-rdma+bounces-1985-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6341F8AAB1C
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Apr 2024 11:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF09B23EE6
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Apr 2024 09:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D79452F62;
	Fri, 19 Apr 2024 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bhomGKHH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2108.outbound.protection.outlook.com [40.107.20.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ACC65194;
	Fri, 19 Apr 2024 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713517367; cv=fail; b=nwe9gKmwSn1bljlRsQxZ9NtYjMjcFtPWG69Q7OjpDFyAaVF219RsXikVw/8Apatpzawcz47O581c3Sjb1a7gghgHOELTje2vHeuzIdsKhpZkhS2tC37critA9J8XK0Xjrfzje7F2Aal9Om7dHdNusoS3600D9duGHumnwoH6AUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713517367; c=relaxed/simple;
	bh=RWHBZDpNsQynAqF2NcfNKiRrqSOVkLe+/0nsWz0Mw/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VrfmoOHSsOHj9fyMH6rZO6ys80b4irJvXSHGOGGWeCCGtp0jhk8YWUNUfT7WRNvOh4vwG4/+IiEOPprsGs82QKAcLwoXIkg4A/HaW3dKZqoqjAyaA1tyDz00XF8rIlVWZNxwM48sKUjKOfJDw6VziyzVSkV6j/pzQ+//LJBckws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=bhomGKHH; arc=fail smtp.client-ip=40.107.20.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiwpvMvfeipWvDIptatMTpfoD3UxdlFfG8BOlz6+XKiEVgnJDJVSqiA4CQpQObdkcms/N5IZbLVLjlfOSpfJuEWCQRszZdxSByUHkmdPR7LBXGDDQuZZR9qH1ULNdKELRqa6xq5DzwB7vaMcpp2Gazv94gWI0s75kG2W1UzuZ83nSYgb4M44Gow0KxCQ7vxFoQ0krPLsjnf+Yaxy26HXex5Vjslyol6Fey/GuYGNx24GUXqC57x5DWUQAS6jaCImnL32EmxLmvlwfH2FbXBIInJTU4FeYbWSUFq52LAGnA4gRCba97Am/3xYmYam4ywl2aqbU9GzOmE1IviL+DjCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWHBZDpNsQynAqF2NcfNKiRrqSOVkLe+/0nsWz0Mw/8=;
 b=YC/VeIlmlVVPl2YDKBlVkb9F2avy575Iep7N4rEQZEY2nuuzVsfjWNcju/Sv9Zqyw3dAFOxFdGK9MGhc3T3S9TbdT75eEddB3r4FOqbg3SLzWLo+um37sdAngr7pPMe9/d9zF+oz7s/eJdSfxiDe/B3uwSMKfnWF/5WZS2O8ENJeMI2PE8LVx7h/7AxZJLeUFqOuoHGYmVdzmECmaV7TOqV5ze1twzzMEMWGH+fTikTAOLeyv/ZE3PRv7ndV1ZiMh1jJgfkUryOu50TyNzdDSolJSlrlQdjXHwpdnf9ksRE+zoXJYvRMH1BQC15z8ADg8tVU8ekJ8kp8l8KN/N6HcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWHBZDpNsQynAqF2NcfNKiRrqSOVkLe+/0nsWz0Mw/8=;
 b=bhomGKHHqgTUL2s3owU4bFNqKrWNkq/tangETIqE34f5RPTaHAdauwXJZvOYbRJBqwDoYD8xm6roXBQae+lLFuPwISDJ/MtPTs+TRGiMNoQII6e+S+ANlxr4usIromPVUDzlV2P0ynpbc9TjaNvY5LV1lqPKFhtq3TQrgPpufG4=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by DBAPR83MB0406.EURPRD83.prod.outlook.com (2603:10a6:10:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.16; Fri, 19 Apr
 2024 09:02:41 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572%6]) with mapi id 15.20.7519.014; Fri, 19 Apr 2024
 09:02:41 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, Long Li <longli@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 2/2] RDMA/mana_ib: Implement get_dma_mr
Thread-Topic: [PATCH rdma-next 2/2] RDMA/mana_ib: Implement get_dma_mr
Thread-Index: AQHakjhVgRfNYDUVK0a36DC0RZx0dg==
Date: Fri, 19 Apr 2024 09:02:40 +0000
Message-ID:
 <PAXPR83MB0557618C82B41CE8DDFFB926B40D2@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1713363659-30156-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713363659-30156-3-git-send-email-kotaranov@linux.microsoft.com>
 <4865def4-8c34-4719-b505-ffb9914d8b6c@linux.dev>
In-Reply-To: <4865def4-8c34-4719-b505-ffb9914d8b6c@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=40c719cf-7347-4aa6-827a-1a601f988f6a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-19T09:01:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|DBAPR83MB0406:EE_
x-ms-office365-filtering-correlation-id: 3b314d42-c7e7-4c51-e972-08dc604f77f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmZLaHIvL2YzQnN2Tk1hazJMdmo5aGRnYllvMkk0aHM2YTNSbElJNFZXdHYw?=
 =?utf-8?B?KzRxbzZMN0FBTmlUblduKzY2a3FHaUdVVEF0VlBIQitTcmFxWnp5cmNod0kz?=
 =?utf-8?B?MGVPVEQxS0p6NDJHQmNBTzBNbUoyUml6Z1hkWlNTRHRCVnlsSllITGJoUEY2?=
 =?utf-8?B?cS9TTURmS0c2UVF3bUhJc2RqeXB2WlM5VzVsb2M3UmxTT0JxeVZNQWUrdTI1?=
 =?utf-8?B?Qk42b2JiQUNObE1iUkpqM0xVbnQwWlNUK0gwYkFXSjI1MXFaS3M3eCtwVFJz?=
 =?utf-8?B?ckIxQTM2aCtWdDNnemppc1RrUkpmd1MxejVvTG1kRHRaZ0dPZ1ZWa3Nuc2R6?=
 =?utf-8?B?aDByTVdoVmlRalI0ZXRvM2RkQjV3dUozdTlEQ1J3QU9BeTFERVUwNlowMzFR?=
 =?utf-8?B?ZDNrVFA5dTczd1FWZVFVNmg3QVJWdEFhdjJzcEVhRzA5SzFZcXNvREp2REky?=
 =?utf-8?B?SWtWaXlZempPYytxS0NpeGJvVFhad1dYQmVTQ1BuMnV5NFZCakozOUZ2cytM?=
 =?utf-8?B?cE9OU0x2MkR2NWdQZjVvWTg5OThpYktIK0ZOMFQ0OVNnRFU4QURLaGV0ODkx?=
 =?utf-8?B?TmlGd3k2M0JRVkJNZXMxRVMzOEdObEJGTHIxRXh4RVhNamFKOVN6YndtVVdP?=
 =?utf-8?B?V0NOMHlaS2tRZEJTVzM0cnJaVGVTSGJyT2JhcE42ODFicUM0dVg4SnRhSHQ3?=
 =?utf-8?B?S1gxN3JsR1d2RG9kMXBnYWRDK3VKY2lRNWtiZzVWWHdkNWhRSlo3TDZtYTRG?=
 =?utf-8?B?MWQwU1N3cmVlWVh1TXJMWVFydWpzdFlJUk9QZmI2dGM2RjdrK2NoZFpQdUZ3?=
 =?utf-8?B?REh3eDRYd2xyMFloQUNpaHJjRk9hMWxDV2M5cHdNM1oydkV4SEc5M21wK0lK?=
 =?utf-8?B?bVdYSnIwK2xDRGFoV1hqcHFSanVsYjVXQWNoaE9Gamlzd1p0QUsyeDJjR1dy?=
 =?utf-8?B?R1NlTEpaMER5bUt0dGw5TlJvWkd4YWs3ZlZZSnRPTFFHaXVlZWpQb0lDYWRj?=
 =?utf-8?B?N0FFeVJNWEtHYzNzMVV4S013bEJaWjJFTlpnckhTb0t1dDNJYXFIOFpzb1lO?=
 =?utf-8?B?NXVoTlBCRXhIWXZPai9KVXpqZVZMbFlJaHBMRC9OaXAwclNWcFdyWGZPcVpk?=
 =?utf-8?B?WmQwVTh1aXdDV05MMzkxT2dRZk9PdFkyWndhWGdTUzZRY295by9VbGFScEcx?=
 =?utf-8?B?ZUh6ZGRCWWlKOEhJZm9GampXZEovUmZBTVdMUU9aZ1VqYkR6NnFraVBaUTh2?=
 =?utf-8?B?UU1FMERoQUZlZ1c0MXlkVituUkQvTlRPOUFaWHhCSjVRV3EvUnNoeFkxay9x?=
 =?utf-8?B?eFY2cjBKTjR5SWZ4a2NTUjhGcVFXeGJNVHVDVzFGVzJUeGw0OVBqQ1lvaXNS?=
 =?utf-8?B?ellGSm9OZ2FHZWE5dnFPR2JCY3BNODhJMmFMUHMrTGlFZFJQVkxLR3c2anVW?=
 =?utf-8?B?TVFsUkJVaDFSY0xJSllVcWZaQS9iRm9VcG9uVFZ0K0YwbXQzWndrbjlrUlk4?=
 =?utf-8?B?NzdPUVdENkRJZzk4VHpzVHlDREtMMERFT2ZCRE9ReWxWd2h6SU1wbXl2MHhV?=
 =?utf-8?B?TUR2VjhNeGVFeEw0bDlPSjd2NUJWdGp1dE5MUWdaczd1OXUrQVlualNMTHVE?=
 =?utf-8?B?ZHVISGkyRjhoZjEwOGNiaHMwRWc2Uk5jaGhiVUQ0RVA2Y3AzRW5od0VJT2dq?=
 =?utf-8?B?RndnZDgyYldCLzV0bzEzTHhrTGN3Q1dBdjVaZjRaL09qMEJTbkpNQ25BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0VaZFRDWU8zSzR3ekZPWUR5OFVHbGhaYmNheFlmdlVlMHNzUlo4bXVkNks3?=
 =?utf-8?B?WTlJZ3NzOFJhY3VvVnZCY3B5am1SaEt3VllTNHBDY0JpcmlsR2JoSE83aWcz?=
 =?utf-8?B?bVFQeldhU0s4TGloOG9UeWl3U1JhZktpbHRqMEhwWDFETHJMVElFQ1gxYzlB?=
 =?utf-8?B?bDBtcjVIbDU4N0tIK1NSVk0vZm5MQXA4VUcxbXIwZVJrWEhHWFNQZmUzdWJU?=
 =?utf-8?B?eE5BL1B0aElIMVYwdEUwMjdzdFpjUmVkN2RLSSsxejl4KzU1WjRkb1UwMWM5?=
 =?utf-8?B?OStsc3BEL1VvZFlzYitKVVZpNmpxZlJMcFFzMTlnUzhTT2hzSFhMdkdKN001?=
 =?utf-8?B?aXRGOUI3eGpKR2I5aHdDdlU2NkxIdldrZU5wWjhUejJVcU5qZ3ZsejJCaVFP?=
 =?utf-8?B?SmNTQ1RLVGNqZFZrc29MY0UybjVKZ1FsY1QvWGRmbnJJc3V4ME5US2FjeVh0?=
 =?utf-8?B?WjMyN1duWllqVXBGYkhSakFGanZJL3hRbldEQkZhZVFmc2VkRFFvTlJ1Nnk3?=
 =?utf-8?B?ZGNFeGV0SnBTV2J2RE8vSStxclAxSkloZjM0YVJzZmtMeGhaNXNEdUUyZnU5?=
 =?utf-8?B?TkZUYmNZUklUVlR2UER6U1VFK1JMTGxtRDhKMmo3ZjI2THhPYThLcEhDbDR6?=
 =?utf-8?B?ZnZEdmxNMHhtVkJ6a2NQVVcyK0llSkhWSlBzT2dKYXZDOHUxOUM0dmR2bUUy?=
 =?utf-8?B?UTM3Wk51TjdiNDYycjZWTk1lUVcxUVhnZFo0V01SQXdMTUp1S3liTFpZdEJv?=
 =?utf-8?B?UGFoWU9aTldsMDhTL1dvMGYxUm44a281Y1V3N0N0TUExV0tNRzNLazAxT04y?=
 =?utf-8?B?UCsvZlJSTUF5RXVMbThGcDBqMHBjUy9nbGhLTGZlaW1wNGtPOTJrNGhzRmxj?=
 =?utf-8?B?NllGaDl6cGsrVU5jSG4rMjV0NDhOOEJJL2J0NEcwM2haQ3FxbkRrb0RibUdR?=
 =?utf-8?B?Z1MzTzhJeWhoVFU3cWhDQkdDY0dxdC95a0M4ZVZEOXZmWTNHaU1BNGE1Qlpo?=
 =?utf-8?B?cjNUbkRwQk82WmtVU2EwYkZldzZsNTFoMzBsVzdwdEdXNG52OU41eG9kRllO?=
 =?utf-8?B?Q2J4UXRmcElvU1R2ZlBxOVYyeWVndFNKQm9HdkY3MmNUVHlacG9CL01GYVk5?=
 =?utf-8?B?YitXY3hsNTRVRUsrM2lybGw2ZGxvUWFpWSsybDJUL0dDS3RFUllzR1IyT1Rp?=
 =?utf-8?B?bnZaMGRaSTk2dm1FaUR4eVpaaDQ5RFo2TUtveVBheUFGeVczU1QwZUhBNnR0?=
 =?utf-8?B?V21xTVVYYllGUkVMKzNpTFR4ZjdFZ0hTWHFVQ1lKVVpvdFhaYnRSTjBaMnlU?=
 =?utf-8?B?VUdCTUxpMnJ3NjNHYnA5VUUxMUFYQlB0SlVjTE4zN3RZNjE5bEZrZFNtaVJZ?=
 =?utf-8?B?U1IrSFdaYUFJTXlIeDhhSnNDcnYrZ2JUSFlUeEpKbHlwSmZScVFXak5qWG5H?=
 =?utf-8?B?aDZhcHZFbmJIejU2UDVOc1MvckkrNU9GRzMvTzlTalRqak9QNGlXMU1ZYnlD?=
 =?utf-8?B?SGlUbEVVVzM1WVNnelI2dFhBUS96YUNvTVZQQk96Z1BLREVNY290MUhra2JS?=
 =?utf-8?B?dnpmbmxwRGw4S1hTbjRNTDc3Q0RSWFkxdktXMWVyZDFTMHU0a21pWGE4c2xH?=
 =?utf-8?B?bE9kVjJKMnRNMDFLWENFSCs4NnFiUjBySFJSSkx0QUVDKzMwemJ6aFRVZTJX?=
 =?utf-8?B?QjZpcTNPWXRta0NtSU9qNXB2Zkd6VDZldm1WVzFCeGFaSGM5QjIwSzNZVlF1?=
 =?utf-8?B?WXBWanVXNG1HazdhWnN3N2k1OTVmTmRMR2dKRzdQcUlWZFlRamljcituVUM2?=
 =?utf-8?B?SWhKcnhSVElBTE9FM2dwUlVoVWtQTWo5aUZnOWtUcGN0SGhEUm1hekFVV1h0?=
 =?utf-8?B?bE5uQVNQUmpta3pDZDR5aG5nVmFjcEl0Nmd0VUVtcW8rR0EzNUd3SE5SZU1L?=
 =?utf-8?B?SDZybzVXRHBPUzhCbkowQzVWOUkyQzRZSm5Jd3d4ZEVldkxVUVpRb3RrdnhN?=
 =?utf-8?B?bXJWd254ZHFON1ZqdlNINWVZQnlmbnhSMUwzT2ZEUll3dE5MOXJFbW9BaVJU?=
 =?utf-8?Q?nuPaIE?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0557.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b314d42-c7e7-4c51-e972-08dc604f77f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 09:02:41.0267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oOec2c2VHYlnT4X1u+gtTAU5bM9Fhg5wDUsC1aE6q6jvvuAF7xIrPpAslvHATeZmMkRwWzw/8r2CfPRHgWIBBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR83MB0406

PiBGcm9tOiBaaHUgWWFuanVuIDx6eWp6eWoyMDAwQGdtYWlsLmNvbT4NCj4gT24gMTcuMDQuMjQg
MTY6MjAsIEtvbnN0YW50aW4gVGFyYW5vdiB3cm90ZToNCj4gPiBGcm9tOiBLb25zdGFudGluIFRh
cmFub3YgPGtvdGFyYW5vdkBtaWNyb3NvZnQuY29tPg0KPiA+DQo+ID4gSW1wbGVtZW50IGFsbG9j
YXRpb24gb2YgRE1BLW1hcHBlZCBtZW1vcnkgcmVnaW9ucy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5jb20+DQo+ID4gLS0t
DQo+ID4gICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9kZXZpY2UuYyB8ICAxICsNCj4gPiAg
IGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21yLmMgICAgIHwgMzYNCj4gKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgIGluY2x1ZGUvbmV0L21hbmEvZ2RtYS5oICAgICAgICAg
ICAgIHwgIDUgKysrKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvZGV2aWNlLmMN
Cj4gPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2RldmljZS5jDQo+ID4gaW5kZXggNmZh
OTAyZWU4MGE2Li4wNDNjZWYwOWYxYzIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmli
YW5kL2h3L21hbmEvZGV2aWNlLmMNCj4gPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWFu
YS9kZXZpY2UuYw0KPiA+IEBAIC0yOSw2ICsyOSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWJf
ZGV2aWNlX29wcyBtYW5hX2liX2Rldl9vcHMgPQ0KPiB7DQo+ID4gICAgIC5kZXN0cm95X3J3cV9p
bmRfdGFibGUgPSBtYW5hX2liX2Rlc3Ryb3lfcndxX2luZF90YWJsZSwNCj4gPiAgICAgLmRlc3Ry
b3lfd3EgPSBtYW5hX2liX2Rlc3Ryb3lfd3EsDQo+ID4gICAgIC5kaXNhc3NvY2lhdGVfdWNvbnRl
eHQgPSBtYW5hX2liX2Rpc2Fzc29jaWF0ZV91Y29udGV4dCwNCj4gPiArICAgLmdldF9kbWFfbXIg
PSBtYW5hX2liX2dldF9kbWFfbXIsDQo+ID4gICAgIC5nZXRfcG9ydF9pbW11dGFibGUgPSBtYW5h
X2liX2dldF9wb3J0X2ltbXV0YWJsZSwNCj4gPiAgICAgLm1tYXAgPSBtYW5hX2liX21tYXAsDQo+
ID4gICAgIC5tb2RpZnlfcXAgPSBtYW5hX2liX21vZGlmeV9xcCwNCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbXIuYw0KPiA+IGIvZHJpdmVycy9pbmZpbmliYW5k
L2h3L21hbmEvbXIuYyBpbmRleCA0ZjEzNDIzZWNkYmQuLjdjOTM5NDkyNmExOA0KPiA+IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21yLmMNCj4gPiArKysgYi9k
cml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9tci5jDQo+ID4gQEAgLTgsNiArOCw4IEBADQo+ID4g
ICAjZGVmaW5lIFZBTElEX01SX0ZMQUdTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ICAgICAoSUJfQUNDRVNTX0xPQ0FMX1dSSVRF
IHwgSUJfQUNDRVNTX1JFTU9URV9XUklURSB8DQo+ID4gSUJfQUNDRVNTX1JFTU9URV9SRUFEKQ0K
PiA+DQo+ID4gKyNkZWZpbmUgVkFMSURfRE1BX01SX0ZMQUdTIElCX0FDQ0VTU19MT0NBTF9XUklU
RQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyBlbnVtIGdkbWFfbXJfYWNjZXNzX2ZsYWdzDQo+ID4gICBt
YW5hX2liX3ZlcmJzX3RvX2dkbWFfYWNjZXNzX2ZsYWdzKGludCBhY2Nlc3NfZmxhZ3MpDQo+ID4g
ICB7DQo+ID4gQEAgLTM5LDYgKzQxLDggQEAgc3RhdGljIGludCBtYW5hX2liX2dkX2NyZWF0ZV9t
cihzdHJ1Y3QgbWFuYV9pYl9kZXYNCj4gKmRldiwgc3RydWN0IG1hbmFfaWJfbXIgKm1yLA0KPiA+
ICAgICByZXEubXJfdHlwZSA9IG1yX3BhcmFtcy0+bXJfdHlwZTsNCj4gPg0KPiA+ICAgICBzd2l0
Y2ggKG1yX3BhcmFtcy0+bXJfdHlwZSkgew0KPiA+ICsgICBjYXNlIEdETUFfTVJfVFlQRV9HUEE6
DQo+ID4gKyAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgIGNhc2UgR0RNQV9NUl9UWVBFX0dWQToN
Cj4gPiAgICAgICAgICAgICByZXEuZ3ZhLmRtYV9yZWdpb25faGFuZGxlID0gbXJfcGFyYW1zLQ0K
PiA+Z3ZhLmRtYV9yZWdpb25faGFuZGxlOw0KPiA+ICAgICAgICAgICAgIHJlcS5ndmEudmlydHVh
bF9hZGRyZXNzID0gbXJfcGFyYW1zLT5ndmEudmlydHVhbF9hZGRyZXNzOw0KPiBAQA0KPiA+IC0x
NjgsNiArMTcyLDM4IEBAIHN0cnVjdCBpYl9tciAqbWFuYV9pYl9yZWdfdXNlcl9tcihzdHJ1Y3Qg
aWJfcGQNCj4gKmlicGQsIHU2NCBzdGFydCwgdTY0IGxlbmd0aCwNCj4gPiAgICAgcmV0dXJuIEVS
Ul9QVFIoZXJyKTsNCj4gPiAgIH0NCj4gPg0KPg0KPiBOb3Qgc3VyZSBpZiB0aGUgZm9sbG93aW5n
IGZ1bmN0aW9uIG5lZWRzIGNvbW1lbnRzIG9yIG5vdC4NCj4gSWYgeWVzLCB0aGUga2VybmVsIGRv
Yw0KPiBodHRwczovL2dpdC5rZS8NCj4gcm5lbC5vcmclMkZwdWIlMkZzY20lMkZsaW51eCUyRmtl
cm5lbCUyRmdpdCUyRnRvcnZhbGRzJTJGbGludXguZ2l0JTINCj4gRnRyZWUlMkZEb2N1bWVudGF0
aW9uJTJGZG9jLWd1aWRlJTJGa2VybmVsLWRvYy5yc3QlM0ZoJTNEdjYuOS0NCj4gcmM0JTIzbjY3
JmRhdGE9MDUlN0MwMiU3Q2tvdGFyYW5vdiU0MG1pY3Jvc29mdC5jb20lN0MyODE2NzE1OTM1DQo+
IDg1NDA1ZjI4MGUwOGRjNWY5MjUwMDclN0M3MmY5ODhiZjg2ZjE0MWFmOTFhYjJkN2NkMDExZGI0
NyU3QzElN0MNCj4gMCU3QzYzODQ5MDMyOTI1NzAwMTc1OCU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaU1DNHcNCj4gTGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3
aUxDSlhWQ0k2TW4wJTNEJTdDMCU3QyU3Qw0KPiAlN0Mmc2RhdGE9MU16dDBES3p0eTJqTUpZbTUy
Z1AlMkZhbG9ZbkZHVVR6TjdnekFQMDVSZG9RJTNEJnJlcw0KPiBlcnZlZD0wDQo+IGNhbiBwcm92
aWRlIGEgZ29vZCBleGFtcGxlLg0KPg0KDQpUaGFua3MhIEkgd2lsbCBoYXZlIGEgbG9vayBhbmQg
c2VlIGhvdyBJIGNhbiBpbXByb3ZlIGNvbW1lbnRzLg0KDQo+IEJlc3QgUmVnYXJkcywNCj4gWmh1
IFlhbmp1bg0KPg0KPiA+ICtzdHJ1Y3QgaWJfbXIgKm1hbmFfaWJfZ2V0X2RtYV9tcihzdHJ1Y3Qg
aWJfcGQgKmlicGQsIGludA0KPiA+ICthY2Nlc3NfZmxhZ3MpIHsNCj4gPiArICAgc3RydWN0IG1h
bmFfaWJfcGQgKnBkID0gY29udGFpbmVyX29mKGlicGQsIHN0cnVjdCBtYW5hX2liX3BkLA0KPiBp
YnBkKTsNCj4gPiArICAgc3RydWN0IGdkbWFfY3JlYXRlX21yX3BhcmFtcyBtcl9wYXJhbXMgPSB7
fTsNCj4gPiArICAgc3RydWN0IGliX2RldmljZSAqaWJkZXYgPSBpYnBkLT5kZXZpY2U7DQo+ID4g
KyAgIHN0cnVjdCBtYW5hX2liX2RldiAqZGV2Ow0KPiA+ICsgICBzdHJ1Y3QgbWFuYV9pYl9tciAq
bXI7DQo+ID4gKyAgIGludCBlcnI7DQo+ID4gKw0KPiA+ICsgICBkZXYgPSBjb250YWluZXJfb2Yo
aWJkZXYsIHN0cnVjdCBtYW5hX2liX2RldiwgaWJfZGV2KTsNCj4gPiArDQo+ID4gKyAgIGlmIChh
Y2Nlc3NfZmxhZ3MgJiB+VkFMSURfRE1BX01SX0ZMQUdTKQ0KPiA+ICsgICAgICAgICAgIHJldHVy
biBFUlJfUFRSKC1FSU5WQUwpOw0KPiA+ICsNCj4gPiArICAgbXIgPSBremFsbG9jKHNpemVvZigq
bXIpLCBHRlBfS0VSTkVMKTsNCj4gPiArICAgaWYgKCFtcikNCj4gPiArICAgICAgICAgICByZXR1
cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPiArDQo+ID4gKyAgIG1yX3BhcmFtcy5wZF9oYW5kbGUg
PSBwZC0+cGRfaGFuZGxlOw0KPiA+ICsgICBtcl9wYXJhbXMubXJfdHlwZSA9IEdETUFfTVJfVFlQ
RV9HUEE7DQo+ID4gKw0KPiA+ICsgICBlcnIgPSBtYW5hX2liX2dkX2NyZWF0ZV9tcihkZXYsIG1y
LCAmbXJfcGFyYW1zKTsNCj4gPiArICAgaWYgKGVycikNCj4gPiArICAgICAgICAgICBnb3RvIGVy
cl9mcmVlOw0KPiA+ICsNCj4gPiArICAgcmV0dXJuICZtci0+aWJtcjsNCj4gPiArDQo+ID4gK2Vy
cl9mcmVlOg0KPiA+ICsgICBrZnJlZShtcik7DQo+ID4gKyAgIHJldHVybiBFUlJfUFRSKGVycik7
DQo+ID4gK30NCj4gPiArDQo+ID4gICBpbnQgbWFuYV9pYl9kZXJlZ19tcihzdHJ1Y3QgaWJfbXIg
KmlibXIsIHN0cnVjdCBpYl91ZGF0YSAqdWRhdGEpDQo+ID4gICB7DQo+ID4gICAgIHN0cnVjdCBt
YW5hX2liX21yICptciA9IGNvbnRhaW5lcl9vZihpYm1yLCBzdHJ1Y3QgbWFuYV9pYl9tciwNCj4g
PiBpYm1yKTsgZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L21hbmEvZ2RtYS5oIGIvaW5jbHVkZS9u
ZXQvbWFuYS9nZG1hLmgNCj4gPiBpbmRleCA4ZDc5NmEzMGRkZGUuLmRjMTliNWNiMzNhNiAxMDA2
NDQNCj4gPiAtLS0gYS9pbmNsdWRlL25ldC9tYW5hL2dkbWEuaA0KPiA+ICsrKyBiL2luY2x1ZGUv
bmV0L21hbmEvZ2RtYS5oDQo+ID4gQEAgLTc4OCw2ICs3ODgsMTEgQEAgc3RydWN0IGdkbWFfZGVz
dG9yeV9wZF9yZXNwIHsNCj4gPiAgIH07LyogSFcgREFUQSAqLw0KPiA+DQo+ID4gICBlbnVtIGdk
bWFfbXJfdHlwZSB7DQo+ID4gKyAgIC8qDQo+ID4gKyAgICAqIEd1ZXN0IFBoeXNpY2FsIEFkZHJl
c3MgLSBNUnMgb2YgdGhpcyB0eXBlIGFsbG93IGFjY2Vzcw0KPiA+ICsgICAgKiB0byBhbnkgRE1B
LW1hcHBlZCBtZW1vcnkgdXNpbmcgYnVzLWxvZ2ljYWwgYWRkcmVzcw0KPiA+ICsgICAgKi8NCj4g
PiArICAgR0RNQV9NUl9UWVBFX0dQQSA9IDEsDQo+ID4gICAgIC8qIEd1ZXN0IFZpcnR1YWwgQWRk
cmVzcyAtIE1ScyBvZiB0aGlzIHR5cGUgYWxsb3cgYWNjZXNzDQo+ID4gICAgICAqIHRvIG1lbW9y
eSBtYXBwZWQgYnkgUFRFcyBhc3NvY2lhdGVkIHdpdGggdGhpcyBNUiB1c2luZyBhIHZpcnR1YWwN
Cj4gPiAgICAgICogYWRkcmVzcyB0aGF0IGlzIHNldCB1cCBpbiB0aGUgTVNUDQoNCg==

