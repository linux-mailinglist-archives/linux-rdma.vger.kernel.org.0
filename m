Return-Path: <linux-rdma+bounces-2979-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E268FFD6D
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 09:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1EC1F22D9B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 07:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B888156C40;
	Fri,  7 Jun 2024 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M+Y6KMf8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2105.outbound.protection.outlook.com [40.107.6.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D2156985;
	Fri,  7 Jun 2024 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746281; cv=fail; b=pzQG9JtS/kQD6U98AguOpR2AYvata6QZEaTRlP94VyYsIpHLu95+cWcHVDNf1K7LkAijjrQd+EztdHhihjAA/hSRUx+elkHFudiaGDjtK7sY+bVkR6UT2HDOOvgmMvUyGf5LdeaptTNSMss5fUVSQSiJZ34FBy0LwrYMqS9P+IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746281; c=relaxed/simple;
	bh=fKI0LteNR+OBTaF3AYirkAgcfo6k6rr2xDWa9B0z3Os=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FU6fihOC7LWkyAGWQLLhWXVRtDXS4fEEphBznXJH12/OOtj3528TdEQ9Ijm092qitUl1H6We+srBD0qEjrKvCQOu7a2wNaIsqP7YO1fnJR6A7gCUEEy1xnkG9yRzmiU2gSNoMOi3vVV+h3GMQttNacgX8pZumBEfXW6j8mj9qDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=M+Y6KMf8; arc=fail smtp.client-ip=40.107.6.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSNgCbNCO9EvVd8x0Z0NS+TWkfPyHGRpAYxG4KlFcD3KErThifjRjSesr7WDq3O0QQo/IUAsez3H6HolhHzRgGX+3YquZu3XpK74FUdRgYDqZ9OPnQ44KRMTI2PrsSGoj5akFLbGu4kpA3tRrC737IfyB2OnXdoABwPkX360P/8XmyVn+SbgaEbV4BbDE9A98xBaaqB+ottGkpf+pDhQ0sWzrl9eVlwWlM0AglC0aBirxP7GnEMgDOGTdjoaFuF5N4J9JsFZQY9cDocRObwvgD7zUhCCMpSOemmswIMEeL66AfAz2Tkj27bVcb1B5WxXc9t+zBopcf/EI5/snU23rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKI0LteNR+OBTaF3AYirkAgcfo6k6rr2xDWa9B0z3Os=;
 b=XXzfVzaGkhl90BNnN0nHIU/fAaGv+0rylh2jrrRwc/qHkzuyQr6k2/Cjve+uAUpboV1lLfulaSFdvvR748yNCRPLPA6rQnohAxkjUD6Op25ugpMocgMGiY2LRyL1KcX4FRS3C9SbKJUTBFNBHA7Xwdc2p2+iyIHs4tKj9oyI9MmgmMutPOB844NE3TGiIJLnthUuDx/VrDdKbRXRBLqC4Zmj8aa7usJExLTGUbabtbEJ8lOVysJiNv2W2pmAKvl1k3JisAPMjmj5rAK5+ZA1U9HoN0MjXcOYDipDWLngSuik6y5BOgK/Bkr6KyhQVXbPxkXA0DfnM0XTE+H38xnWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKI0LteNR+OBTaF3AYirkAgcfo6k6rr2xDWa9B0z3Os=;
 b=M+Y6KMf84QsVb+tp9qsUaYBRUkh4MBHpywkiS4jwHgZ94hQUFqC9m7L3uFZq6y4rgCIGROm3TtyQPmREINrxt9uraZ6+BeBsxzvUcWzQ8rYPjFtO4kHBBetQjQrQBBCgHyyRtXc0I480jRXx7n2qhdbJj1BR/cbg/z+f73StBvI=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by GV1PR83MB0754.EURPRD83.prod.outlook.com (2603:10a6:150:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.7; Fri, 7 Jun
 2024 07:44:35 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7677.007; Fri, 7 Jun 2024
 07:44:35 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Thread-Index: AQHatnNpjWIYJv5iZk27b1TMYgszmLG5xnoAgACkJiCAATHxgIAAUJRw
Date: Fri, 7 Jun 2024 07:44:35 +0000
Message-ID:
 <PAXPR83MB055961DB3A684BAB81B18218B4FB2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1717500963-1108-1-git-send-email-kotaranov@linux.microsoft.com>
 <PH7PR21MB307195C7DD870A5716E1CA92CEF92@PH7PR21MB3071.namprd21.prod.outlook.com>
 <PAXPR83MB0559360D3C2E3D0B02E9C059B4FA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <PH7PR21MB30716CC511AAC603DF1FEDE2CEFB2@PH7PR21MB3071.namprd21.prod.outlook.com>
In-Reply-To:
 <PH7PR21MB30716CC511AAC603DF1FEDE2CEFB2@PH7PR21MB3071.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7b9f9122-27a4-4ad5-b04b-3479404d893d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-05T22:23:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|GV1PR83MB0754:EE_
x-ms-office365-filtering-correlation-id: baf2879c-8715-4ece-0658-08dc86c5ad2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?T01MQzBWSEVSeXJGMklPY0lQTnBXdkZNU3NCbWtZUnNZZjN6MUlCeWJoU1FM?=
 =?utf-8?B?aGNpcmMxMlpLdFVzNG1QVnVHczZWdHRMOXREK2RsQnQrM3orSXJsQXNCYlRx?=
 =?utf-8?B?WEtramVaNlYzK0llM0hNU3l4MHU5b2hVbGNVYkFEMGVUVVZoVFBxUytwSDgv?=
 =?utf-8?B?NVRMZk9wNHBZS25XdWVMM3lxK0xIL0EyRVBrVzJCZ05YRG5sMlhFdVV6bVdv?=
 =?utf-8?B?SFlaYmFhTXVjZFBQenJ2SU12S0JseTRpOFZDcEdBaUgrSDNEelVuSThZRjdp?=
 =?utf-8?B?a3VpOHFjQlJHNjlzUDNSaWhjajA2VUlJUFM5cG9EcjhXeU1aenhNVVk4UmdZ?=
 =?utf-8?B?UkxnbkZOaWI1VER0M3lFVERpK1hQSUFzdTlBRnlmNmdRdXdoUXRueUdHUXJ5?=
 =?utf-8?B?L1hEaVU2Wnd6dndzaHZ1WEpRRzBRMDMyMVZlMFdNbGdBbWtPdStZMjdrdzZh?=
 =?utf-8?B?eUp6RFRSWjJxWTRxd0QwdTJlcFpJUmxwNUdlZmhUckdLOW5OOVQybS9QblVL?=
 =?utf-8?B?VklIZTcyMUpjblFwN3dkZVdDekxnU3Z2OFlBMTM4L0tpZnA4YmN3dUovWUha?=
 =?utf-8?B?WndZbnQ4N0d4cmFKMW1TMUNHem8xbThENjhqbVNUaGNpS1ArYTdWY2ZXRnRB?=
 =?utf-8?B?UHhzQTE4eXFDeElQTEdjWXZpSXhydGxMcGh1c0JXcjlQNUtlSFl2Q3pJYmtG?=
 =?utf-8?B?VEtvNkIxT1VORHErTENIKzJTSStVOHcydXVKVU1zQjR3VDFxSCtBK0xCMVZP?=
 =?utf-8?B?cFJ1bHpUbWNuOENEc2xoSTdpUGhkZG5PMnFYQUdQdjRtRFNNNWlIZXdKeWt2?=
 =?utf-8?B?aDFRRHh0QmFhdjVSMUhrTzN3dTMyM0xXeFV5TWpDallpNjVrQlZDc3BjWjVV?=
 =?utf-8?B?cTJZQW5ZQkpMRWFwNzI5Ym9leHc0b2VwVHk0Y2l1V2JpWUJicGl0VmUwUVc0?=
 =?utf-8?B?b2xsSmhuL0YzaGE2ZmZTV3I0bDlJV0ZyT056cm5LY1g0QnZUd3FaL2Fmc3Rx?=
 =?utf-8?B?YjQxSzdJNlFYZ0hUcUZOeW00d2R4NWo2RVdGQ3o0WXFyZk9wNjlSVU5DZWdx?=
 =?utf-8?B?ZkRLcWJWVTFPK2p5NTFDM0orZWp0cUZvQTFwZGVCUi90bUFPMklEQUZ0M3Zm?=
 =?utf-8?B?T1Z1bUNJU3hSUnkvSmU2L2syOWFSYWVHZitvQUJsRTVZbWo0WDVGVkJTb1c2?=
 =?utf-8?B?OHZBK2tkU1IxVkltM1ZZVEw0RFpBMDJRMmJaQ0FOUDgxRlpJL0FOellWVDkw?=
 =?utf-8?B?eURwUVhUMDJuS2w2OGZQenliN2E3V2lJZVRIaWorN0tvZTZXWnlvSUovZUpF?=
 =?utf-8?B?MVRRa1BoTWh4Ty9jUGpGbTVvRldqNE9tOUF5Y051SEZEWEhBMFJxVXNHYmdx?=
 =?utf-8?B?NnM4cnpjK290elJvMGQrTGkvODArd25mZVZWeFBoU3hUSkl6b1BqKzJOUjgz?=
 =?utf-8?B?ZWIrV2dxUitEWmpXS3BNV2N1a1VQcDI2a1Q1UUtYV0YvcER2V0l4NnN1bktI?=
 =?utf-8?B?eEJseFVkc2VVY0RyTEJERzQxMW9DdksrSnB2RVh4NHBnOU9CZlI1QXVVNEoz?=
 =?utf-8?B?UzRKeXJiR2RVSkFrc0V3Zk1QVXlKVlRDb1pGVndXcXRXYkZELzEwOHRQWkpO?=
 =?utf-8?B?S3ZURmhFT281cUtXcklNRlYvZTVKcWlScWpxaXcrc25Oa2JYQlZvWDRLNUhI?=
 =?utf-8?B?eXI4WThIOWtyU3NrRWUwa21MVzc0eVVMOHJpcXFYYlBubm9IeS96RHN5a2p4?=
 =?utf-8?B?cW9CbWVVK1hIdzlVQXJYYTFpT1pYUkhJTUxHZmpTeVpsTzNtR1E5aVEzejhU?=
 =?utf-8?Q?sHwDe1/jys+hnCKR8U2DxLUCKBuxdEvLyibIE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVhvMytZWW81K0pFQUlhZjdVKzAxQ01qNVBhQnRRRlA1NDZoZDQ0ZmZDdThS?=
 =?utf-8?B?OTJEZTh1NTF6Q2pVUStXVGVzVUd2OGJOQ0piSkxwUCtiSjl0cEh2SjFQaEhV?=
 =?utf-8?B?K0hrUWltVUZNWmgvcjlSWVY3YUxmL2pWbGx0Y2YwTU91YWZpenRmNWpkc2NI?=
 =?utf-8?B?akpCbVpQZGlwcFVSUEVyc3hIditKR2ZOT1pvSHZTcVhzTU9aaW9hMm1VUjAy?=
 =?utf-8?B?MVhNeHhJb1VFYUZubnBLMThuZEY0a1J2NUxpRFI5bWtOcjVmWHZpcEo4QVRY?=
 =?utf-8?B?eldIOFo0UmlGWHluZGFERzNTbXIxcmk3enh4eGNLSlRGZ0FoeWlhOTB3aTBZ?=
 =?utf-8?B?eDM4VFZHZ1I3ZEIwMUh4ZFEzc1JEbElOTXhtVDl1c2lhNHV2ZkRLM0N4ZXgx?=
 =?utf-8?B?ZXprM0ZLOWVQQThaQ1AwV3oxK3hONWhZd3lyTTcyRy9hVUM3Qm9PdUx2MFZN?=
 =?utf-8?B?UGNET2lERTcwUVU0ajYvQjFJaTlnMjU4TTQwTDdYNG9XdUlWdlhWWUlYR1FC?=
 =?utf-8?B?WXJNOE9kZ3FPN0M0Z0FGR2t4MHNrYXhDZTkvMHczU1dybEVnbW1CNldSYmtN?=
 =?utf-8?B?WllOU3Z3bklyZWw1VEwvTEVxUXI2QjEzMmNBTEkxV01sMnR0VXRMYUdydG1H?=
 =?utf-8?B?cmxydGtoQTBVc2FhakNyWEsrVUVYK0lZSng3MFpmOEhPWW1paFFUR2VCZkxK?=
 =?utf-8?B?Y0tROFFVTVJkNDdZSG1iQ3dOWHlUQnRLR240aW1GZnAvLy9zd2xOeFNVNjRp?=
 =?utf-8?B?VmJTbkdNOVRHd1ZUK2dSakNkZmVmTmJuYjdFTHdXVnNNaFBod1cwZnl5emFi?=
 =?utf-8?B?Umo4d3hGN1ZRUElOb1dxTmlpZ1U5Slp5dXVJOG10ZUt2SWhHN1RoQTliN21Q?=
 =?utf-8?B?UWF1aXNDS0c0VG8wc1pCQWlqM0M1T1RQVGRncmMyS0pGRUV2bCttaXk2WS9p?=
 =?utf-8?B?VEN2NFA4bDQrTlRzRTMwOElvUEFhL0V5WklsSlZrRDJHVGR3dno1R0xHRmgv?=
 =?utf-8?B?ZzJlSnN3ODJ0Rm5OU3lqV2lZWmxQUkVhWGI3MGpaL1p3WUpjMnRyMjlmL3hD?=
 =?utf-8?B?ajlQOUVqZzYzYllyWERPV21BL293aDhZYW0rTUpJODJnMHRwZFhCdklnQ1FJ?=
 =?utf-8?B?WlZ4MURDc1o1V3haWlpPeUt2cTBYT2drQ0x0ZHZMK01IQnRYT29Sc092UmNU?=
 =?utf-8?B?STMyQmZxVHhwbVFDMm5uY1FoRGdDTkx4THFpcTA0YlI1THc0V2U0Ui9FeUFV?=
 =?utf-8?B?bWZHUjMzcWZpcTZoMlpqMTRZeTRQUERneXpaTHVhZlp0eTVXcWJDQUFwVjdy?=
 =?utf-8?B?bDdtUWVNalM0aGVtVUhkVXUrZHAvUWNJUENHaVRaTmk3elVsNkhDak4vZGln?=
 =?utf-8?B?Zi9LdFZBbnF4MmJJZWxIc2dzRHl6T1FReXRtTDFublMxS24zdGVxeTg4dngx?=
 =?utf-8?B?U29IWEZWMDMrS0JpSUdGWGdOcDBZTTlQU2ZBNWxISWtJWWtVWEhCWXpFSUtQ?=
 =?utf-8?B?NXBLWU9hRW9Dc3VJcm5SbFFwdVdmTmlMQ081bVg1SUdlcVhEMUphQUpQMU5o?=
 =?utf-8?B?S25WUGx4S2JGU0xFekczd0dxamVyNEg1Y3lWQkJyelRqTmd6NWhNYUU0dFhs?=
 =?utf-8?B?eWZtbklGbjRHRHZLa01WTmxSQjlaa3hRWEd4RkxwaVJoZStYODYxSGRoekUy?=
 =?utf-8?B?NFJXUE43ZGQwUzJua1ZHVXUvbXhTNnVCM25KcUFNdmxmRkt2Vmx4UnFuR2tI?=
 =?utf-8?B?RnhzTDV1RFVZOHYzWjk5Wk95NlhWMEh5TEsyVTFaZkNDTGV3RXBJM2hsYWVV?=
 =?utf-8?B?TzlJWnlRVkQ1RlMyeXNCbk9hTWtNUS8xQVo2OHI3U0VrM21WQ1V0aHdKQWhX?=
 =?utf-8?B?aFA1bWFpWEdETkpyUXZhUm1GZFZVV1M1aHE3L0RjL1BlNGdPZXQ0bmNyNHNK?=
 =?utf-8?B?Q2FPSFpDUHhPSGlHOUlsVXdjZmFLbGMvMkcvZ2JXUUtmYitKVWNyWGNuM0pu?=
 =?utf-8?B?UGFncnJyL0FYbWZEUStYcXk0M083Uy9mdW1ZZ3hMKy9qSUNnR3d4aVRlWXBr?=
 =?utf-8?Q?+bKkDS?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf2879c-8715-4ece-0658-08dc86c5ad2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 07:44:35.1529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8NSdtH6AsxnDN/DcTYjjbX7LTXDMK6x0q5wsjunfK6RGmZQlzz7iHdDnTqzy+foa9bBzSaUCNADtDVSl9OX4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0754

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTG9uZyBMaSA8bG9uZ2xp
QG1pY3Jvc29mdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgNyBKdW5lIDIwMjQgMDQ6NDUNCj4gVG86
IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5jb20+OyBLb25zdGFudGlu
IFRhcmFub3YNCj4gPGtvdGFyYW5vdkBsaW51eC5taWNyb3NvZnQuY29tPjsgV2VpIEh1IDx3ZWhA
bWljcm9zb2Z0LmNvbT47DQo+IHNoYXJtYWFqYXlAbWljcm9zb2Z0LmNvbTsgamdnQHppZXBlLmNh
OyBsZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggcmRtYS1uZXh0
IDEvMV0gUkRNQS9tYW5hX2liOiBwcm9jZXNzIFFQIGVycm9yIGV2ZW50cw0KPiANCj4gPiA+IFN0
cmFuZ2UgbG9naWMuIFdoeSBub3QgZG86DQo+ID4gPiBpZiAoIXJlZmNvdW50X2RlY19hbmRfdGVz
dCgmcXAtPnJlZmNvdW50KSkNCj4gPiA+IAl3YWl0X2Zvcl9jb21wbGV0aW9uKCZxcC0+ZnJlZSk7
DQo+ID4gPg0KPiA+DQo+ID4gSXQgbWlnaHQgd29yaywgYnV0IHRoZSBsb2dpYyB3aWxsIGJlIGV2
ZW4gc3RyYW5nZXIgYW5kIGl0IHdpbGwgcHJldmVudA0KPiA+IHNvbWUgZGVidWdnaW5nLg0KPiA+
IFdpdGggdGhlIHByb3Bvc2VkIGNoYW5nZSwgcXAtPmZyZWUgbWF5IG5vdCBiZSBjb21wbGV0ZWQg
ZXZlbiB0aG91Z2gNCj4gPiB0aGUgY291bnRlciBpcyAwLg0KPiANCj4gV2h5IHRoaXMgaXMgYSBw
cm9ibGVtPyBtYW5hX2liX2Rlc3Ryb3lfcmNfcXAoKSBpcyB0aGUgb25seSBvbmUgd2FpdGluZyBv
bg0KPiBpdD8NCg0KU3VyZSwgaXQgaXMgbm90IGEgcHJvYmxlbSBpZiB5b3UgZG8gbm90IGhhdmUg
YSBidWcuIFRoZSBjb2RlIGlzIHN1YmplY3QgdG8gY2hhbmdlIGFuZCBidWdzDQpjb3VsZCBhcHBl
YXIuDQoNCj4gDQo+ID4gQXMgYSByZXN1bHQsIHRoZSBjaGFuZ2UgbWFrZXMgYW4gaW5jb3JyZWN0
IHN0YXRlIHRvIGJlIGFuIGV4cGVjdGVkDQo+ID4gc3RhdGUsIHRoZXJlYnkgbWFraW5nIGJ1Z3Mg
d2l0aCB0aGF0IHNpZGUgZWZmZWN0IHVuZGV0ZWN0YWJsZS4NCj4gPiBFLmcuLCB3ZSBoYXZlIGEg
YnVnICJ1c2UgYWZ0ZXIgZnJlZSIgYW5kIHRoZW4gd2UgdHJ5IHRvIHRyYWNlIHdoZXRoZXINCj4g
PiBxcCB3YXMgaW4gdXNlLg0KPiANCj4gSSBkb24ndCBnZXQgaXQuIENhbiB5b3UgZXhwbGFpbiB3
aHk/DQoNClBsZWFzZSByZS1yZWFkIG15IGV4cGxhbmF0aW9uIGFnYWluLiBBbHNvIHBsZWFzZSBj
aGVjayB0aGUga2VybmVsIGNvZGUgb2Ygb3RoZXINCmRyaXZlcnMgdGhhdCB1c2Ugd2FpdF9mb3Jf
Y29tcGxldGlvbi4gTWFueSBvZiB0aGVtIGRvIHRoZSBzYW1lIHRocmVlIGxpbmVzIGFzIEkgZG8N
CmluIHRoaXMgcGF0Y2guDQoNCj4gDQo+ID4gUGx1cywgaXQgaXMgYSBnb29kIHByYWN0aWNlIGRl
aW5pdCBldmVyeXRoaW5nIHRoYXQgd2FzIGluaXRlZC4gV2l0aA0KPiA+IHRoZSBwcm9wb3NlZCBj
aGFuZ2UgaXQgaXMgdmlvbGF0ZWQuDQo+IA0KPiBZb3Ugc2hvdWxkbid0IGNhbGwgd2FpdF9mb3Jf
Y29tcGxldGlvbiBpZiBpdCdzIG5vdCBuZWVkZWQuIFRoaXMgaXMgbm90IGENCj4gImRlaW5pdCIu
DQoNClNlZSB5b3VyIG1lc3NhZ2UsIHlvdSBwcm9wb3NlZCB0byByZW1vdmUgY29tcGxldGUgYXMg
d2VsbC4NCg==

