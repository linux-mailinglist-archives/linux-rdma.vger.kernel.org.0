Return-Path: <linux-rdma+bounces-20320-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJd1B2fiAGoQOAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20320-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 21:54:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F097506180
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 21:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3E643001A75
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 19:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AFE2253EE;
	Sun, 10 May 2026 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nQ9jUiDM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12124196C7C
	for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778442849; cv=fail; b=DdvzK7lVocL8+vDqyskZ2cfFIqxlk/q2+pkTOgRnlObouC1nfOr2EHtPoyjyVxNb4PAQYddEzmITDTRRzbsYIFQTwmf1rSwzwsDYGl3vfeqNmxwGVZP58iPKIRRvkQvjNf7XJRujFVMXpu0IxY2mdno+0BD3Wll6NIMSD6le+TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778442849; c=relaxed/simple;
	bh=UfxyC5qFSFaezbEDgB2tSy+Ku7NA6CDQr0E0Spdf+Bo=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=mregC4d1oSb8LPfOow/aEw05eVw/zRzCpY53w48VCoImQMaufYnkwuYkkfj5/nbsHxEm2FzcfnmOipvnxSQCwsQg5DfeuyAYLIo+nPTdqULuZ1DYVsTfZ9IzthgA/H1a+sUvjMqPFUDDG+oWL65EPkAfSU4McPqMGXd6EZuEaWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nQ9jUiDM; arc=fail smtp.client-ip=40.107.209.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzGYtmcT9Bg9X+eMIVZ7+iUJJ4MqeIPB8cmuCqT+NHX0mendp0R4l6bi5IEW6TnUh1y6uLILTGnUXgQG4a+SnvoBbf56Z4iMhR8GC4jqA937Clf9Rp0wU//lHhx15vjDNdbbv8JPKrh5nSw65lKPT09Lyz6uYXMP0cx4CBZK8gRQRCBC+IR25z1v9wWANTetYJvNeHm1DG1xcMjmfo4Z1jWQfzqf9OF/5oSafBHRpDMBVDo+53kQspq2Bm+Hlp+WL/Ij6o6+JcNVp85FoRCsLeMwyvSAcX/C2+DJQcsU51GNctXu6b5yOAVwX8OjFBJMBTgAEcAYYQwsyF8KUA28Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9PollUylCpY+V2WKQYZyQzKvPjgwt1hGU4EgxI10kQ=;
 b=OLfGhRdWLSkMHKEFYaVgkf5/jWhPsbuy4WI9En2d70EnlT7VJRGr+jsPQB1suJtTVWq4AuRypEgeZ0d8ANprbPOzyRPji7hy6+2UC09sCMZDBqhBi4i7yIiGhNG9MDXaS5FhjH4oAqOyMvnLEJkMkFvXGHhOJbX6w5l6Gs+0I0gJ6c6SlQSoLwxPUHfraXYMDpKmsI1jJUN05rxlHlzNG5VolS+AHrNGRQXZTAuks2k19fsM76XYqW7n+WXpNZtX/457YnOuhN5h1zqNWvVUwY05itDq+8P//VrKWaoB6xA4kNCl75qyci0efez3SeaxEkoXBVzVEG2AyZ1TRTwqHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9PollUylCpY+V2WKQYZyQzKvPjgwt1hGU4EgxI10kQ=;
 b=nQ9jUiDMtzLyyP+SzKqUk2PFXSvd3MJIBkAYkmF1+qYxiK8XeAXGH0T8ucAp4FHgqLm8d/B0htDw3/9d8caWKYrVEDnJAjkDVVHM0urD4aDtq+UhSoTUCIcLwyg3lp7NwvVzEZhwJUyDuFTpPXTcOgqoXZXAfbPosBw/LhID6N/go1jllL1NFXKeTEE4d9Idue3Waj+g6xu8lrZUXqFPVd10rauv80CvMsG4oRZ6KRjZOMNdXFiGeTL7V4q3uxdhLON87d5JgYdX4VKFXCj+/4MffvuhOcZiHF9LRdLr0rbfh/VO8u2cvVHQWyPQPYCrzir4ZcO1Vu7rW1/j7YJ5Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by CH3PR12MB8996.namprd12.prod.outlook.com (2603:10b6:610:170::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 19:54:04 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::1532:a957:cff0:9ca4]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::1532:a957:cff0:9ca4%6]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 19:54:04 +0000
Message-ID: <94d9d929-7fed-4558-8c66-05232ff5eee3@nvidia.com>
Date: Sun, 10 May 2026 22:53:59 +0300
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-rdma@vger.kernel.org
From: Jared Holzman <jholzman@nvidia.com>
Subject: iwcm: CONNECT_REQUEST events silently dropped in cm_work_handler when
 listener is being destroyed
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|CH3PR12MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: de241170-72f4-4792-1c04-08deaecde3a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5hF7CCb0/McIG9BPbymG7N4beJt4FBCih3/zQoVsfXshP1w6Q5Dfs67XOD/5L+S1HeVNfKP+XY340NoaTl/SqWV0psI4bVH38ZkdGSYoChlV/IktrBPKUMnmmOmf0aZgFlIGFBJbvKbvY50fix9nLYhFPXenETuPhhsSzyUUp4DXIlE2+smjuauqvJecEoufW5oV+IiON3FDRA56sJl5es4MRueehsWHR4YH2WLoaWN9qVdk3BRrAE+8CNdAcicLqsBjHGoJBgdN1r90RPwCJ8gih437gJHyzONwpxTafd7P4B1eLwXKSaAoBIdXsA1OqnNyIlWXSoQfxd5xq7SLCcAl8iJK0KpX9ogi5hpxTQjx7WPhFHnUfjxhTQvmvvwR3gkfuQTAiAhzjEDS9cGha/mUEj4ZOSFShGiopc6YyTiAWjsbU71gHU+AMGRm2ox+ddPJA/PvbxEivzdkqB5aJ7kwVuahC4cQCh/FQ66dbSs2yEWNzUzRF0DnBQRPI0BvlXZKbq/Mb3USGiHDxBbgEPhfxKEbXdlFQMt3sj+7A7BRWQLW/hH7vuPv5ZGYT8gJuWAmxrXthLKPJL8ct9vVLBZyGynY2BjfbHeQIrndmCTTGLhrAdQwj6Si9bU4CHCcPAADfVpecI0QXOZa6bMoUDUPOp+Lo8Oe9kjwWHf9O4FlMO9MWUPu4SDECE+UMUGe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU0xRGhRRmJsQVYvSXN0cEM4cklidm95U0FldGtLRkpXeFVsT0pTUy81blEy?=
 =?utf-8?B?aVFLcnJmS3BnS1EvSmNQVGRoSjR6bzVUQUMzazNyMHNmWHRpdWQ2cElRVldP?=
 =?utf-8?B?bEdwaURjblNpcFpDcml5M2p5dUtVSzNRLzRZenpHYWNiMjJ4Qk1sTXZtYUc4?=
 =?utf-8?B?YW5wTklkSjN2ZlBsZHhidXBtNjVYY3I3b2FJM0lBNlJJeG14eE42eHZQLzNy?=
 =?utf-8?B?ZWIxWUVXMjNDS09ocDgyRm5EUmZrdVUrNFZ1TFp1VVRlZWoxSFVVazAzWHl1?=
 =?utf-8?B?enYrNndnbG5JcithbE84UVJnTGhWQ0UyNW1EWnB5OG1BU3dSTTRvYThCano5?=
 =?utf-8?B?dkVIK3pIYk03bnUrajJIWFpvS0o5cWFyYnFxM0crUDN4VW1hdWpvZ0hwSnRi?=
 =?utf-8?B?aHZEbzE5UmRMa3ZwYVQzODZKL095dGt6bFVqN0dyVGlDOGZVYkpiRlFScWtq?=
 =?utf-8?B?ckNTVytMN1hmU3RsVU82T1d0TGl5RFBzWXBZRXZ5REtiVlFWV21oK2EvRE1Y?=
 =?utf-8?B?Y21ZemRoVlFHejBxRjd3ZU4zZktkM29SWXRqamp0K3FCY0VuYmV0eFhxT25B?=
 =?utf-8?B?d1gvd2FjblF1LzYvZlEzNTkybG5vSndhMHA4b0l5eTBSaFZobHZ0V0h1a1Fx?=
 =?utf-8?B?R1FyWDdWR0Rtb0JFUU1EdDRMU3JJOEp1SzFFdXJNZ2h2WjFZUTFJY0dZaktu?=
 =?utf-8?B?TVhDNE9jalBqbG0xc0lnSWMzWUp4eW50VEtGTG40bUVjR21yZ2ZRQ3pOSXR3?=
 =?utf-8?B?emFPU2hSY2pmSnNFSU04dWc0MTFVZnZyeFIzc2pJdW1yT0wyaHdBM0I3NjNv?=
 =?utf-8?B?WDY4S3orNDhudmFaL0hHYlZyd3FpbHpPdEZpRUlMM1lTR3hQQi9BTHJqUEhC?=
 =?utf-8?B?S0FMVWRkLzFiMmptOVE5REh1bHVjUWNhdHNBTUdsRjd6MSt1S0MyY2J6UzRJ?=
 =?utf-8?B?OXl5ZUhyeFpBWTJ2VkJlU2hvalNZRUVRMk1CczJQUFpQN0lyc2tpZUdVOXdq?=
 =?utf-8?B?bk9NeEtDc1pNMVVjUkdlOGQ2ak1yb0x5Tk10NmpXSitlYUlaRG1ETFJnRGJC?=
 =?utf-8?B?ZEZaTFpxeis0aDl3bGhsS3llajQ5akZyUzJRVWhCQTVHelkydUtCMFJJYy9V?=
 =?utf-8?B?NjZNanQ4czYyNzZkakRCOHJiODdHaXVSQmFzTDRCeGRKN21uRXRiVUwyU3J3?=
 =?utf-8?B?dlNNNFhGL0lSM0ptSXF4bnpGWnNtWS80bkxtNnAyK21qTjBGTGpVTlNhczN0?=
 =?utf-8?B?ZUJSeUpuY1EwUjUrWTZtNERKRStzV0tmU3dzN3BpTlJFK0hMTFVtZ2dDSCti?=
 =?utf-8?B?eTNaRC9BWS84MXZrOUJiSEhycGNMYjBBMVJzeGZlUmpreHVYRHNOQTJIQlVC?=
 =?utf-8?B?djRUWFdsRzlqQTlzRzJiTXpmcFVKbGdtZUVXYlQxMHpiQkRCOHA1cXJnMVlL?=
 =?utf-8?B?UDJlTmpVeTFPTlVTeWU5cnZIZWtZZ0ZHclhNbi9KakFBUVh5VC9rUHBGVytm?=
 =?utf-8?B?Z1M2SHJFOXYza1pYdlYxY05QcGpNbGZ6cDU4VVQwdjRDNFRCTWV4N1RZejZk?=
 =?utf-8?B?WlJwaW5RNk9UbTV0YTNiT1huSm4wTXZvU2sxMXY5cU81bnNBc2hrY1B6Q05V?=
 =?utf-8?B?cVR2Q1lmQWlTZmhQTmVQakMxOGxqdTUyeFlVMUQ4Sy9iNEphUVErbEJ2RHRB?=
 =?utf-8?B?emJJbFJBNkJ6NVlpM3JtMDh1dWJVWEpIVFcvUVdZMHo4aDl0dm9OMXhPQ1pW?=
 =?utf-8?B?ckt6dEF2TjZQRVhaTmZ2ZWlSNzV2YnU1Qm9KMEZKMjdxR3psVTArMFM1ekp5?=
 =?utf-8?B?RFNadGJJYmV2SXZCa2NlY2F3ai9hd1hhQWJRZzZ4VmVRNEQ5c3N4UFN0aEk3?=
 =?utf-8?B?YVgvRVExR1pGMEZteEdIOFFlL0wzTmhodGJKbTFDTVI3RXdtUThIdFlLWEJ2?=
 =?utf-8?B?TW1RZ1hxSURhNEhJOHVUY3lJNFhhc1NPMHNDV1didlpTalF6d0x0dFB4amhK?=
 =?utf-8?B?SWRNM1hJRXFlQ2FwSlUwSjIxa2tEdStRMHpYRnpFMS82cUJXeTEvN290anhF?=
 =?utf-8?B?T2JHbGV1Q2lQeTRNcTk2SEV1SlhBUjhhZExiWUhFNWhtbjY5a3YrOEhOaHhu?=
 =?utf-8?B?UVlJUlQ1U3JabU5hVndpNHMyNXhlYlVUMENmSWJ4azVMQlQ1VUxJd0JvczVS?=
 =?utf-8?B?UGpNZW96amxkTmc2L29RUGprcGJhTC83bVZnYWZGSGRVMFlKczY3cUVlaXBj?=
 =?utf-8?B?Y0E2MEJDL1B0UnNzTlpoQ2RwWkpsam14czgyYTdrOStJV1BnOE5hZTBTbExU?=
 =?utf-8?B?RXY3NG5vRDl3YnBXR0lrREwzS3N1Sm1PMVdVZ2MvK2E5T1lzbnJ1SDNuaHF4?=
 =?utf-8?Q?DyANd8BH3MvPLC/Bwwc0Jk7nHbVUWf6rj4L3uIMG4JhMr?=
X-MS-Exchange-AntiSpam-MessageData-1: PbwFDPZ40Rl5dA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de241170-72f4-4792-1c04-08deaecde3a0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 19:54:04.4972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRi0t4YCFLsjyWBGnWNTrlpHHpYmGqSmHRoLpf1xaUXL5l7LM25kOWceVhYHoOzWJo1lx5lt5UFkpqgE52pqTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8996
X-Rspamd-Queue-Id: 1F097506180
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20320-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jholzman@nvidia.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi all,

Heads-up while debugging a rare module-unload BUG on an older siw — 
flagging this for the record in case it bites a future iWARP provider.

In drivers/infiniband/core/iwcm.c::cm_work_handler(), when 
IWCM_F_DROP_EVENTS is set on a listener cm_id (set unconditionally by 
destroy_cm_id()), any in-flight CONNECT_REQUEST work item is silently 
dropped:

         if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
                 ret = process_event(cm_id_priv, &levent);
                 ...
         } else
                 pr_debug("dropping event %d\n", levent.event);


For non-CONNECT_REQUEST events that's fine — the consumer is also 
tearing down. For CONNECT_REQUEST, however, the event carries 
provider_data = <provider's per-connection state> (e.g. siw's CEP that 
took the wait-for-CM ref via siw_cep_get() in siw_proc_mpareq()), and 
there is no other release path: cm_conn_req_handler() is the only place 
that turns a queued CONNECT_REQUEST into the call to iw_cm_reject() / 
iw_destroy_cm_id() that gets back to the provider's iw_reject op.

Race: peer opens TCP, sends MPA REQ, immediately closes; the CEP defers 
cleanup of the wait-for-CM ref because it's still expecting the consumer 
to accept/reject; consumer module unload runs while that CONNECT_REQUEST 
work is still queued on iwcm_wq; destroy_cm_id() sets IWCM_F_DROP_EVENTS 
before iw_destroy_listen() and the subsequent flush_workqueue() runs the 
work item through the silent drop branch. Provider state leaks; from the 
provider's side there is no signal it could have hooked into.

A second instance of the same shape exists in cm_conn_req_handler() when 
iw_create_cm_id() fails — goto out with an "ignore the request" comment, 
again no provider notification.

I noticed upstream siw no longer carries the num_cep counter and 
WARN_MEMBER_ATOMIC_NZ() that originally surfaced this for me, so the 
leak is invisible there today. We hit it on an older siw that still 
tracks num_cep and WARN_ONs in siw_device_deregister() if it isn't zero, 
which is what made it observable. The underlying iwcm leak still exists 
regardless; upstream siw just no longer notices.

Probably the smallest correct fix is to let cm_conn_req_handler() run 
even when IWCM_F_DROP_EVENTS is set — it already has a clean code path 
for listen_id_priv->state != IW_CM_STATE_LISTEN that calls 
iw_cm_reject() + iw_destroy_cm_id() and never invokes the consumer's 
cm_handler, so the only behavior change is that the provider gets the 
iw_reject callback it was waiting for.

Happy to send a patch if there's interest, otherwise we will just accept 
the leak and mask the WARN ourselves.

Thanks,

Jared Holzman

jholzman@nvidia.com


