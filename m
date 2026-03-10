Return-Path: <linux-rdma+bounces-17875-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFPXFLovsGlHgwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17875-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 15:50:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B89282527D6
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 15:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7840534B49E8
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 14:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA59F391E50;
	Tue, 10 Mar 2026 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="VFJ5bmjo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020075.outbound.protection.outlook.com [40.93.198.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C973838B7B2
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152103; cv=fail; b=e9v/HbCn6ptW7c6F1866qY5qgD0fWqCASYW9MHzmCIP8BA8oTWf+aPjqhGXYS2QMa0xLYCB/tBlXr6rxeH6oHJ2brB+hx6sB7Cs+/PSAQ962gjWhzb7qI/ItkI2B/ySMY6OS/5dlxJs67Crc7GZRcGFJ4TYK4f2x/gT5BbdBK28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152103; c=relaxed/simple;
	bh=3K8+/waaPAaABa67/hPIw5EwTrwW7LKvv0ViL/0XZLo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rE7+Le4DtGSMFwFKroQ9IknnZXzMYQa1/kwALzNcTVCI5vopiDiaqieLtvi1Z1mWXJSB3nFFem+YLsAC+Ab7qRj8khHp9wJfw7HimMtZatVOzab7kBzzSMy5WJbQnJtc7imcpI2qQma8Jfp+sbEChINjnhUnwvl1KLzdH8AfwbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=VFJ5bmjo; arc=fail smtp.client-ip=40.93.198.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnAO+fDdsLV2g5PyeYxGCq4TADK1WSJU3Wp+9aHIw3/pK/7EHF83ktCftL8Ib5hTN/03zt7cOjURC7WjrGFstO6MFFq1kQvRuK0gNzXJ9Z6J4PO6q2i+tnkuZWOEQnGF512DOu+E8T3JObFvglm//IEBdPacB6Z5LqNBQT07pLp+fdblswrRAygptgGNQT+5XGxzuP35iLSsUrd/L0X2soS/uCtSCUoKJvyx5CXLzY/XtuNcDqWLK3SmflOOM6QqwBMyociLI562DjhHorK/k7DljZKNN+gMrz0y9IawtEARV5eu2dwg9quL3OPmOH+VZyMOwOj0NN5PRCUUs0Ohcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgbrJIXKEsJ/IKGThbkob2EuGdfBAjgAtb01c0HN5zI=;
 b=TSemgd9dNxGG1V6wx0dOXONLwf3h0ZJYuV2OJRMNhpmAiP7Z1SIQTpOOg4d+q3Q0ZdjWbXH6jciu9tPRiHY5P9K9dflxWXwch+DZJ3Tm7VYKjKq8oZjKE9z7O+GLSpgHbKAwW1KomAlvJuyH2UZECMI69FtMisdQf6oxPteCJSPxKUMtqLeXVm5gUHtiVyy74IFQV0+7fBbjaxvyOG2DzoHo2G8Rt6Zn1DyrekNij29Ga3hg7fYsh53xVY+9yvRJccVMLBIYvd/M0RuU43bBhf/nmMwFzRzYamDhJ9vISZQnxW0Ekhq7Dtn1fIP+gpAIeBZH1DpxACLT68ht9tJ/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgbrJIXKEsJ/IKGThbkob2EuGdfBAjgAtb01c0HN5zI=;
 b=VFJ5bmjo7YzLizHnFP31ue48aCuZjU9WW9NwsA8LPUQA5n70+jo+w6PPytsIrfMbwCrfp9FdIkOYbBIHtXUZ58Qub1s/R87UtYscBhFRwPJXhLW/QL7hPWz+ORRYNYX3aJTCjMGeGdK8qBY19V1lfI4EY/q7kRiCTEdsDWy/em4ML571KBDD6CttaWQf4V5Nk6tPdSNs40nygkSKCOjY2XY8aHqhfAtx9LD/VZqPzgm7/PvSXoZLUQ7bgi5+65RqDpHWMFXHeSfCqYkcJ6/K+03z+xT9cMOxLEYAZoQcoyJwms78cwQ72fheTEPGoAlV5UA9Sx37ngiKlEasfT7Mpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SA1PR01MB7248.prod.exchangelabs.com (2603:10b6:806:1f3::14) by
 DS4PR01MB994136.prod.exchangelabs.com (2603:10b6:8:328::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.25; Tue, 10 Mar 2026 14:14:58 +0000
Received: from SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be]) by SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be%6]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 14:14:58 +0000
Message-ID: <9c9ffd7b-0124-4d72-a894-4498b7c44f96@cornelisnetworks.com>
Date: Tue, 10 Mar 2026 10:14:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 0/4] Prepare for hfi2 submission
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
References: <177308892140.1279894.3475429390519673020.stgit@awdrv-04.cornelisnetworks.com>
 <20260310110806.GC12611@unreal>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20260310110806.GC12611@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:610:4e::27) To SA1PR01MB7248.prod.exchangelabs.com
 (2603:10b6:806:1f3::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB7248:EE_|DS4PR01MB994136:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a6ee6d-a146-4492-1cd5-08de7eaf6941
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EyE0lDYMlJ6wQuut5Inm7fwh1c5QbfRazYBOMHeswu+nGXqy1Qbm42RYBoeWp2GS3Q7bjXY0jJpkJwSYR4h2GQxnmxbhEd+8+G8Xszy649vyToB6BKG05gCjDUhQ3E/jOoIyN+YsND7nB9YPxtF+M7mmzycc2CBDHvYK2vRg7rPX8JRNAo0k+MsKHhZ0J4tPf/qjto7e/vX15CNT3BMd1Y4vDD+H1RoE8ZM4xHFLFfdEy5Iqi825ZIKq80xvv8A2fvuZ82gjl86OV78lQLuLEaOwth4qt1OSk9gMu5EO70TyCxRSKPtzwHWNDqF864xLqGt74nXLR9Jryd9PzjJ/fZ9ddx4BmLnuJVzTFq2oB5HXXnB5XvHitSOb/PJcm92/glgWcXygjnH0lGHctAp0rWmdspHkPw8hpFmu15GnjWocbgKg5FnxVqVWUvoGytrePPqV+C1FyK11gASDAGI7av97QovdvCcJk3HSlGpNO1AAGXQDMrATBDJO36XkMlHtwoo5rmUOXmIwdqSKKGu9ygNObGanRPO+ymo370HnRfnPcvO6G1dFMo48GECiFEj1EDuWOYoVfT1b5A76I1yb+fqSN6hmgn+FYg/npFDrzokiwLGuuA7RB8LWHOiRp/IPki66tr0YQuzl3zvk3vOD9cll0PvAXn7zgchs8SZi5vgYlLkSZWd0YrF3ILVBXnKXbM+YorACFhy7wIZXMX7ZdEV/MObKXtNQTkDjatFUsH8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB7248.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVZ3WkVXeTQ4NXpOalcvdDVSUVpxYTI0RUNvblBwVjN0dVRCajlybUZPNzR0?=
 =?utf-8?B?ODRnOUlQTEE1QUVoR3lvN2hWTTBXREg4NXFRby9BcHR5TitUQXBaM0dUZTYv?=
 =?utf-8?B?ekcyQjNwR3BuL1UwWUNxa25ReHJjQlNHbk5QM3FCdVlMTTZtc0RHbTJ4NDNC?=
 =?utf-8?B?cEdzY2tiRkZxNC9STUxRL3VTZTNmTVFCb0tqdXovRnQ1em9rUy9Odis3blBi?=
 =?utf-8?B?RER1eUppeFdqYVlSUEl3RVAxQjdXekF1Wk03dHQ0V0FaRE1oYnJzYjIySEJ3?=
 =?utf-8?B?T1EwTjJzWFBiRnhhT3U1RFk5QmVENXRWZno3emM3TGpBUEM5L3N3ZFdyejQy?=
 =?utf-8?B?aUxuYk5QQ0o3QjYwMzVqSDczWUFjREhyUFpnZjRxM05meng4TWcraFFyR2kr?=
 =?utf-8?B?RzE3ZlFpbzgvZVMyQjZYeitiRnNFeE1HMzIzcjd1RjF0V1lDRGFpQVhQcmhu?=
 =?utf-8?B?bTh5NC9tZUJBVnRXS1V4ZlpyNnU0L2JBNU9nRDV3ZU56UWlESmYyVnJiWnJR?=
 =?utf-8?B?cTZMeEMvQnNiNEJodDlYWDZ1V0ZMQVNRRE1jWTNpWEdEMEl5WUxLTTRBSkto?=
 =?utf-8?B?TjRNQ2hZczZqZ21mUlI2Lzh4cGY0ZEpLdmI1RXJkMTV1ZUVNRTF0d2JTMHF4?=
 =?utf-8?B?RHBmNjBDdUtiWlNwbDlnbUU1U1g4UEh6RmpCdmhwLzZIUHFPNW5maWJ4WGUx?=
 =?utf-8?B?dW9yaHFHRWpVZjZnOEJoMEU0K24wQUh2bFdWbEpLZUhPOTJOZzMvQS9scTkv?=
 =?utf-8?B?Yzgzd2FTWEtIOFRoZ2hwbzVuWG5uaDVYNU9pV0FGOStqNVc2UjcrTHV1N2Yz?=
 =?utf-8?B?Wm93eGRCWjRXb1hpL05yZVBPQVA3RXpmV1l5NmxZZ3VDZ0p6cS9xR2RGVjY1?=
 =?utf-8?B?aTVDdXN1ZWJHOEtqWHlLaUpaR3RMTGgrVktzSTJzVEhjV2RzTitlTDg4NHll?=
 =?utf-8?B?UnpUQjFyd0NSMlhGdko1dmNxMGtyYmRvd3c1MDFZc1k3Wm1qZG9pRXhFRGxh?=
 =?utf-8?B?dW1wVTNWVXgvbUV1aVdER2pXeGI1YVgvNVc1emZVS0t1dTJ3MSs0YnhRTFVp?=
 =?utf-8?B?N0FEYSt3NDdoK1ZqM3E2bjdrS2MxalByemMyWWdjaGQ5bEFsRnFIeVgrZGp4?=
 =?utf-8?B?VnpTZ21hTGlNUU9LOUVSbC96TGNzVnJweXNtM1BCNGE1UEluc1F3OC9yeGZJ?=
 =?utf-8?B?UmJhRGg2MUdjSGNiUGJVdkJlQlVIeS9rTkdrTGUwck9SQ3MxWEwyZXFTZDFn?=
 =?utf-8?B?eDhkSG94VjRXclF2Q01Sd1hXT2R1T29XRnJ5LzRQVCtQcEx4RncyejFtL2w3?=
 =?utf-8?B?ZXd2WHJvRXZpQnM5NVpXTVQ2SEV1N0pXOU1najg2T3FsUTVNUkw4REEyTDhJ?=
 =?utf-8?B?U21nT3Q3YnlIR0hMa3J3OXR0Ym1aUmZ4YjVJd1N2NG9yWTdvSGhvbXBITklC?=
 =?utf-8?B?UXN2RkFjTTJYRUZ3N3hoTmRSSjNVMzMzZDZCVW8rTmx0czMxeldkK0RBeEdP?=
 =?utf-8?B?cSszYTdiWWtoTlFGYjl0eXFzODRlK1Rua05qRkdHSkJrWnd3bm1pWG8xMzNB?=
 =?utf-8?B?MWZWZEZzUW5wSFBFQ25DVCtpUDRDYStpeWNJR2pUaWt2Z0xKR040WGtUS1lp?=
 =?utf-8?B?eXJIK1IwK0hIbUdYbUtuVW9HODBhR1JrUEZTcko3TmFqQWdvQmlaaUNiTStl?=
 =?utf-8?B?Umhqajdzc2lHRTVqSHdEa0djM0xRUFRpWXBvK2lKUG03WUJ0MTBFYU9nUjNR?=
 =?utf-8?B?aTFxZXJoV1FET0ZHR0QxcmdkUjNpQXNaOGs3VnFjbWRxb0h6UG9UM1hvUXgr?=
 =?utf-8?B?bmZIU2U4dXpYR2k5cW01UjlNOTRRTWp4Vm5VaWZLUVNZTk9qdmZNNUlEMDY2?=
 =?utf-8?B?TXNXYnlGSDlTTkkvTUZPMGU5STUvd1VnbFlVbUpqenJqaHM1UndKQUJUYity?=
 =?utf-8?B?S1JQWjREbFdsYngvRWY1QXJYNG01TFRZRFdOYW9XaUJiRnpTcnJNcUkvVmxv?=
 =?utf-8?B?QXNnQTN0NGdLaUFFTVAvS1NuVzhyd0lpdXJRamZnV0YyYjZTRzVpNk9jSERo?=
 =?utf-8?B?T0I2V0IxZzZObXBOamlzRS9rdlBmWklWczBkMUJKUC9vRjdzNzFwN3dXS0J2?=
 =?utf-8?B?ZHpHMnI1QzlSY3B2V29iTWVnbmdJK1RjNmZKR0lDUDc5Nk5oeHhLc0pXRE1E?=
 =?utf-8?B?QWZLNTNkQ1M2Zm0xYlpvWm5USXlZUlFzTDVtTWpiNTArMWRvM2RwSmNPQW84?=
 =?utf-8?B?eWJiZDM1czlTZ1lWbldRSngwS1gxOHZxaXJlRlNBZjRHSkdra3dTWE1BcVE3?=
 =?utf-8?B?d2JDaWhUTHpxelJlZm9KVmcvaklyZkhPVWw1Y3FXMXR3SFBkQXR0cFI4WWFY?=
 =?utf-8?Q?cTk50VeQhrI5Qv3FL7MoZjR88W+3pUQMkIdcb?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a6ee6d-a146-4492-1cd5-08de7eaf6941
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB7248.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 14:14:58.5728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0/ZU6+HuxOJg5X1SwEKClo0dh5NAeR8QI83GsR8SvSCGwC1PFC1KC1y1fxj7tkAhDCytadiXsQBTWY3JXv9Iq4ri4gLgJDUmak6WCvDuZPiznc37f5QfHAxTzoAzx6g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR01MB994136
X-Rspamd-Queue-Id: B89282527D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	TAGGED_FROM(0.00)[bounces-17875-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cornelisnetworks.com:dkim,cornelisnetworks.com:mid]
X-Rspamd-Action: no action

On 3/10/26 7:08 AM, Leon Romanovsky wrote:
> On Mon, Mar 09, 2026 at 04:44:39PM -0400, Dennis Dalessandro wrote:
>> These 4 patches get rdmavt ready for hfi2 support. This is being split out
>> from the previous patch submission [1].
>>
>> [1] https://lore.kernel.org/linux-rdma/175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com/
>>
>> ---
>>
>> Dean Luick (4):
>>        RDMA/OPA: Update OPA link speed list
>>        RDMA/rdmavt: Add ucontext alloc/dealloc passthrough
>>        RDMA/rdmavt: Correct multi-port QP iteration
>>        RDMA/rdmavt: Add driver mmap callback
> 
> Something went wrong, second patch didn't arrive.
> https://lore.kernel.org/all/177308892140.1279894.3475429390519673020.stgit@awdrv-04.cornelisnetworks.com/

Sorry about that, I'm working the problem with our IT dept right now. 
The mailserver decided to eat half of my patches.

-Denny

