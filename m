Return-Path: <linux-rdma+bounces-18280-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJTiBF+zuWnJMQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18280-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 21:02:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A52D2B1F36
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 21:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20192307A6C8
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 19:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2F833F8DC;
	Tue, 17 Mar 2026 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="bM9Wgieb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021107.outbound.protection.outlook.com [52.101.57.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009332F757
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777351; cv=fail; b=RQmPx6pISs4OaSmKq7qE60RvAA1tRUhOLB2Q7s14Zu17FidPsN3vf2uoTUuXulyFMovfpBZ+hKlscMmHc9vJbmAjZjDQRT1GmeOkLmz5oveLPNKGJmvIAMH51GoD+wzJxoHHDUDp/7WVEG2CPBjYsvmbiwJlpX6FvC/ZikA4Ap8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777351; c=relaxed/simple;
	bh=FxutsHkyJr8Ln9QNCc4iDAy/qsOep4fswxKb7Io2pqQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gl+Az5fGKtv6vt80h7kUAmPgy9WOw3OhYJEqAy9Oofy4CGQXjVzULMNsXOWxWXFLZk33fOZ1r/b9lanipTEF8etReFH+LWS3tw7WsBlHHsv+EUgYIX5EZPTAOlT0Ynw8H1wKvPSXFWlObuQTqHyTJYoQ6kFA/90Hs/ZXHu95PXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=bM9Wgieb; arc=fail smtp.client-ip=52.101.57.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5awahoA0WVsLBAPaf7C3QUPsKPBxmnzvE9Pbak8tTxOssMSVHzFBphOpnXFz3kLe3eAAagqrhb2jEjyx2YpCXBxHlctzuGD5LM2rNa7s8BXs/Qp6igEfp/fyK3kXWB7XKoeyN/1uThrq7oVWb03laNre5q9qy6VhXIsulIUs/ngCKsAoHVvB1IPmHu4yFTMkRrHIeShISLrGME2xkGT7UZ2FUpNpWoMEkxBdP2iGKsCy6p9nK9adaIYgmqO0Kmgj2skmJCcKP0HPui1eH+zkMPE+tULwaRQWgZA4SiATOW2orRS4rUf6vExglI0pcRNUfepfXFx/Djw1JTAzRrx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yvU5KnzB+83EEbOdcyLE6bYhuCnYiNhKDeLK8297m0=;
 b=Lu7vmz/wC4NxoA3dI0gviGdv5LDm3JRiE6txsxpBVAWUuSidDP0EW3FYiRaU/TdJG8C5wCHIBCk3BOzz1atdMoRLAVI2487eQW9c1rzVaCvgimCn7b4LsvXpOE/Ash9H/Xfk9MLgPH16T226guTzb3+VzmcH8EHwzy4Hv18hBshtAqaFHGICF6MxiSrz4dQIAfMjKscI+gPpunRC+JreIekS4d8lmHUOweBW/JBOvdMpIUuOACwqmdx3dpa8QOPRAS0lAmN8LzEiUB9lzD9uxObEetvoB0gYKpPEjhdmDQmKiXiNLj5xv52k4nb1X2PpzuFckEkYIRNDc6BFwoefeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yvU5KnzB+83EEbOdcyLE6bYhuCnYiNhKDeLK8297m0=;
 b=bM9WgiebqqmPVRMPQ4cKaRI649jsmZKP1ka0eYzTA53alWxYo9aopjjnxA/USLdktuaoOrxKu+Oi8fW5Makt3dQrgnsSkTzRluLuoPZ81K1nXBzgfYrjOBk0uFTg+CVYIH/zu948WidlI7k+fLx+QEiWFL053xlgfm92+DjD6LbK5akILTEEF79IXYTnygHiYiu+AJaaJZY2NJyqXHZeerThFYcpwdLO4mjF2nlu5y4hAZ/rxlkgkcT8D6zLKSzMM8m6u3R59Y+kKhFUK9zpGQLcD1AOyu2tTT6rLf2XHr5PU4Kse4sZYNmdO1N8oFuoqwRo4fzR0+IhHpr5EUCTIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SA1PR01MB7248.prod.exchangelabs.com (2603:10b6:806:1f3::14) by
 CH5PR01MB8839.prod.exchangelabs.com (2603:10b6:610:216::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Tue, 17 Mar 2026 19:55:40 +0000
Received: from SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be]) by SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 19:55:43 +0000
Message-ID: <50979d29-31cc-4cba-9aef-8d88d31a2382@cornelisnetworks.com>
Date: Tue, 17 Mar 2026 15:55:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next] RDMA/hfi2: Consolidate ABI files and setup
 uverbs access
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
References: <177325043749.53056.7110333022279342594.stgit@awdrv-04.cornelisnetworks.com>
 <20260316142738.GB61385@unreal>
 <2ce72f8e-3a7d-46c6-9b1e-68f99c91a6d2@cornelisnetworks.com>
 <20260317095148.GS61385@unreal>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20260317095148.GS61385@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::26) To SA1PR01MB7248.prod.exchangelabs.com
 (2603:10b6:806:1f3::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB7248:EE_|CH5PR01MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: a085e474-2615-4d8a-83c9-08de845f2ba9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	ji7m/h++v0VE0TEEce3/t1cFffgSHrh26wHjlu79RhLYa4sOI+gVqcIzQs3evQ1/v463pswjmYVEMt7z4ttRYQsnJFahPRpF2ey1peyuiU0bbmHOEJUFhKuRez7DVfHet89ERqgHSD+GUoekfmnVbj8WINEdtjhHWd3HmabVNLdy6FJLk4WBqIAXfB5f3Gt3ndvjwbOOPcOU5CEQACdzjWrcsmEUhI6V4loY15ua7Hy6VCLv5GjnTl07iqAIx2uHJKSbsb9ALOUOWHjTKvauAr+mNe+lzLPMV1xzIcHnw55SKS73JlSWnEpHLiPmgHek9duks/BY1aAKs+RpAsl/8rrge2q2PQXc147Sd0JtG0om9VS46OdxV+B54OvoHsSuOi2Gn5PGcLFJAiVCTK7FqlAm7SvB5STaw7FWBjixsP3M1oBvk7NukCu1CFi721SdYHG3n5MclXN6nw2K5riS264F6WLVg+hpQI9o7XNzph9FR8fergRxY+gkboH5U2UjDj+qlcdRD/h9o3hyPM+IneJHL88PYJEUTrPOEo3Ox6wUDFqTZDPUE/7Pe30BiDHbzUl5DpkaLox0a/EamaBp6BuRM7/E7coFY90yYXHmtT5NwzLYECGjOA08gtfgsuEGGrs4ZwCjkqSP2aGYYV2FkfkuDf4WiqQvUJguhjYrWCA6EF1Gy61eQnM/Ngl4pEc994hxc/Kg4E5+oXcVMl5l2rJ1A2upU+dSk8ccLCOO6ek=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB7248.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGE0RmpienNPSmNzNXNFS3BSZ3NWbXQ1ME1hSjVhVHhhUm1ycTgxODNrelBj?=
 =?utf-8?B?NGJ2WGhVU2YzMUJINkpHYzFoN2JsZ1g0VU4vWU81akxCU2UyK3RkM2pWY2Rn?=
 =?utf-8?B?aVJaa1VUTzVnS1dWUVRxd2p4a2xNaFpBbHBEVDVjUUhYM043U2hKRTBpUUNa?=
 =?utf-8?B?TTJrL0t6aWpVMG4vRVZhaldFMlk1WERXMWE4R3pDOC9mMlpPZTBndUZES3Bj?=
 =?utf-8?B?TEp1Q3RSQWxTZUtIVzVTdlFpY3pCTlNYUE1yMENXd1RjOERvOExZSTh0c3ZS?=
 =?utf-8?B?QzlIYXJQTEVhZDhGVENiK2tLeE0vT2JwcDBjbVF4OGljNm14azdMUEU2TFhS?=
 =?utf-8?B?T1NueW1aYzc3VzY3UjY3SVZkMlk3T05ld2R6S1Q2T3VTN0k3Mm0zMzBmT3pv?=
 =?utf-8?B?QTYrZmNocjdLUmpMcWtGRThMS1l4TnZJclBaeUtKQVRVeEZNRmVZeTlBYXRG?=
 =?utf-8?B?T1QrWGdBVGo4OHBoeHRYYmlLYm13V3g5aDFFOTRtUnBDbk5HbDZEU2tXdlUr?=
 =?utf-8?B?ZllnVEJzTytOek5pMnlvd3BXQTRYaUh4N21BcldFOG9BYjZxb2lSNWd2Wmx3?=
 =?utf-8?B?S3FGTTE4WVl1d1phUUF2eklKUXdnY3RRaVlUdDE0dFU3LzQ1VWNrSStwanRR?=
 =?utf-8?B?SGgwSXBrcGhvM3dwNHdtUk1QM2dwRmdwRmgyS05QazVNOUNzamFlTnJYeW1H?=
 =?utf-8?B?VHhlemtvNXFQa3NaK0NILzdkZFdaeXJoQTdkOHlZQVpYSU41U3NWWHBnajJC?=
 =?utf-8?B?WS9leWxqVTJ0bFZHV2Ridm5qajdtWG5mU2RHcmw1Wkp5V3FVaXh0NU8vc0Zk?=
 =?utf-8?B?djcwNjhka2Z5SjhIWVJ6cENucXhCK0hNMzJhMFVidXg1SFYvSkhveEVDR3dp?=
 =?utf-8?B?bDVOdXVOTkhkTnM4NUQ5YmlOdlE2azRxOGl5VGFKT2UwaURjZmU0NFZ2MVNQ?=
 =?utf-8?B?VjdDSmFSUXlCc3Q3UEZ0dGZYMm9xWmYxWXhSeGtVZHdXWHhwM3lpb3VVeDZY?=
 =?utf-8?B?RlpneUNLUXo3T2c1QUlEKzZYT0d6QmwzVnRhdzJ5eFNqT2syaDJlVzZ5ZHhq?=
 =?utf-8?B?dy9yNzhaMGhSS1M3S1FNaTB4YTNTNTgvYm9QNHBrYUVTM2VGZC9QSXQvK3E2?=
 =?utf-8?B?c0hxeXJuSDFDVXVjb2taWHo5b1hWb2RTMS83SFlodC9JSExrbmtsSzhqN0J1?=
 =?utf-8?B?OHJXMUdIdGFJSW5VM285Rm9VUTZaMGYyOTEzMEVCZ1N2ZGdiWk5aZkxIcXAw?=
 =?utf-8?B?UjZOcVNDMHNvTk1pRDdJMUtwaTlsSGVjNTIwUFlDdnhWcEhIYkpLdGFPekFq?=
 =?utf-8?B?NndhL09IeGR1UlZwOFhQaWRLQ0tVOWVCdEwrTmRrMVVabGw5Z0dwdUF3L0w1?=
 =?utf-8?B?Vjd0V1p6NzZuSE41dlE2Z1J4QU53bzFOSmgzM2Rhamp5N1FkTklhWDQwOHZi?=
 =?utf-8?B?dUtYZkVOZWNySTlwQnJMa1FMVFB6TDh6dVBiT3gwbVducDYxSERsSXdjYVRk?=
 =?utf-8?B?MTVYZnUzdW8xWEt6NnVGSWZGTVUxMmhlWWI4V3RlclpEZzhOaThZS0pDNzQ4?=
 =?utf-8?B?VldzcWdyTnFScFBwazBEZDZ6SExYYUtFTmpQMGJqMHVCYkdiZVhMK3VSNE0z?=
 =?utf-8?B?dU5YeUxVWjA4dndHR0tCNzVLTVQ4SWI4OWl0cFZyYVhWVGZ1aTY0K09ITUQ4?=
 =?utf-8?B?Zm1ERDQ1bDZxT3hRWUxVZVZ6OUxIZUlJbFNtQ3hOcGdjT0tuVTV3dEdGdUdh?=
 =?utf-8?B?YkY5T0dZNnVycjM5NndrSHhqYlM4Q1ZCWjZSKzJFK2VEK0h0RnVkUnl0cE93?=
 =?utf-8?B?a1NoZzRSY25lUFlKSVRpb2pOdkNWd2ViZFc5TEJiaURFZWU1Z3ZVNzZ1cldh?=
 =?utf-8?B?UWZUU2NUSXJLMmt5NTV3a1JXQVRONDU3K3NqWFZGejRYdFBoY2cyZm0zU09k?=
 =?utf-8?B?Z1k4QWUvaGVnQjA4RDJEOStIaUlBMmNHL2RrMjVrWjBWejRYSis3ZFU3M08r?=
 =?utf-8?B?NTFNYnBvajN2a2pXaW1aMEw3M3lHTTR5YXpuZmdVakxPQjZ3UW9xQnlRa3h4?=
 =?utf-8?B?SWJkZTc5a25ncmpvdUZPVVNDd0JmL0JyTTZBdXpwaHZsVUtnLzFvM1pJRk9R?=
 =?utf-8?B?MGViendoN3JCRDZ0TU1DMG9JSGZtclB2c2VDekQxeTFnOC9RalpJd1JNZ0Jv?=
 =?utf-8?B?MVN0ZXp1b1p5Uk9aQ0VUcDkwT3RVa2lMbVluRjZRUTN4eURMZ1JBMnpoU0Vn?=
 =?utf-8?B?R29oQWN5RWlOOXU4TTFKaks5VkNnandmV0l4VXIwMGZ2eTU3djRjS2xsRUhq?=
 =?utf-8?B?VWFhaXRYUXR6SGpyOEpweUVjajA2TzZvSk1yMUNtQ0V1U0MyMi8zZ3pycU9a?=
 =?utf-8?Q?q0ohLKYtZM3gGweBtA/VeTpgFh+PRdUpkQz10?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a085e474-2615-4d8a-83c9-08de845f2ba9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB7248.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 19:55:42.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wvd/+UAPFGaWSj60hibTWmRScgfxeyPCvU/ybAtj+6Q6u95xkdtx+NRbRyBhPKipqz2df2VhXctDgOey1KqcZ9YdYs1PENi2/XN51DIi5NlhaM5lwTXpZnd4+R6Utw8g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB8839
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18280-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cornelisnetworks.com:dkim,cornelisnetworks.com:mid]
X-Rspamd-Queue-Id: 1A52D2B1F36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 5:51 AM, Leon Romanovsky wrote:
> On Mon, Mar 16, 2026 at 05:31:40PM -0400, Dennis Dalessandro wrote:
>> On 3/16/26 10:27 AM, Leon Romanovsky wrote:
>>> On Wed, Mar 11, 2026 at 01:33:57PM -0400, Dennis Dalessandro wrote:
>>>> hfi1 driver is being replaced eventually with an hfi2 driver. Until that
>>>> happens rather than have all the duplicated code in header files, make hfi1
>>>> use hfi2 variants where it can. When compatibility breaks we'll keep a
>>>> separate hfi1 version.
>>>>
>>>> This is the case for the <dev>_status struture. The hfi1 varaint is single
>>>> port and uses a freezemsg char array while the new hfi2 chip provides
>>>> multiple ports and thus needs and array of ports.
>>>>
>>>> Likewise the tid info struct is expanded for hfi2 so we include both an
>>>> hfi1 and hfi2 vaiant.
>>>>
>>>> There is a naming conflict with the trace_hfi1_ctxt_info() call. It has been
>>>> renamed to remove the 1 from the function name to keep the code readable
>>>> but allow it to compile due to the #define in hfi1_ioctl.h.
>>>>
>>>> The big departure from hfi1 is that we are no longer supporting access from
>>>> users through a private character device. Instead we define two custom
>>>> verbs ojects. dv0/1, which proivdes methods for what in hfi1 are individual
>>>> IOCTLs. We have added an additional method to get stats related to page
>>>> pinning done by the driver.
>>>>
>>>> The reason we are not removing the hfi1_ioctl.h and hfi1_user.h header
>>>> files is user application compatibility. User apps depend on having these
>>>> files available. Once user apps have converted and hfi1 is removed these
>>>> files will be deleted as well.
>>>
>>> What are the applications that use include/uapi/rdma/hfi/hfi1_* directly?
>>> I have hard time to find any application on github which includes them.
>>>
>>
>> rdma-core (submitted PR but have some checkpatch type stuff to fix that was
>> missed), psm2, and libfabric (opx) all use these.
> 
> At least in rdma-core, the include/uapi/rdma files are copied rather than
> used directly. You will probably need to apply the same approach in the
> other libraries.
> 
> My point is that you most likely do not need to keep the old
> include/uapi/rdma/hfi/hfi1_* files.

I'm with you now. Yes, they make a copy of the header file already. The 
ABI doesn't change so existing libraries would be OK. I can remove these 
then and change hfi1 to handle the new hfi2-abi.h.

-Denny


