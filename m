Return-Path: <linux-rdma+bounces-18479-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF29G1HVvWm1CgMAu9opvQ
	(envelope-from <linux-rdma+bounces-18479-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 00:16:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FD02E23E4
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 00:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E52C3044B70
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 23:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5050F3803E0;
	Fri, 20 Mar 2026 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="Wj10q0s/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023096.outbound.protection.outlook.com [40.107.201.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C87230BB8C;
	Fri, 20 Mar 2026 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774048590; cv=fail; b=EBvVTl+y2w8qCmQNOl3IpyfyHzZgQReQO6GBrbCzu+jFWHl26Q/kOt3WoZT0nrzuqI0kEFqkmXQziKK2S6fGNrAVPl6iqlec6w6Dd4HY65Y4kFbeSA6V4kvnHjIofXRlV+H7V3UTqJiwCivdx/hzeibeiRaPP8EIOnvl88qN9g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774048590; c=relaxed/simple;
	bh=5Cj/wW3p24To/xwt74Z112dsszACYmew9O1bR7TSbrY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m5qOa6qagKEsExiBAwRm0rharkLUsmCXnEY4bxDb78lLdZaIkc8R6+f+uckr4prS5pdBTtDnYCRQLDL/TBDajzzMWWFelKysoOVU1Qcp0YO8NGE4aHagpFspZYFt3YdkHeZmdiLBZ0ekwR3ZtrhCERwUvyL2c6sSUvfwQlK974w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=Wj10q0s/ reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.201.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEfWCl5DMQ62GBgcPVUGyraHxRRk9vqhj8rAWwNHOhKA3RwM+epKWj+i4iJUO38frOlOfLFq5AfFBqbsBesss+sbVog/Nlc+sDyy1RD2khcfbYY4u0roPvF3tSWx4VOVbDo7Jo281qQv2WOXGep2OI+zpAllRLU+yS4UIWai2JXZsF95A/K70YZL21WsJsUpGbUEh5C7+vQJTQ8uhkuj0Yv8atIv+3wVYILsV9VfTNFYd7t/Aoi77qI3Op6FJ14dJkIuFy++wRAEfbVtILfspdd6keamCJU6sT3leuSJxKCYgseZPd+GZ/PH78NX2OvqL+rhd3Ngc4kbmen81nw7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzRU99qMoIc5PxhSED3MJoQ1jUCZNLwWlQ9QtcBGOP8=;
 b=W0pwGDmVpj7ynULeHfYHyv3Gib4maJUSSC0Nigjfc4VLs8HXLcqlBkq9xvPbuDigLSR93Mv+lRAWRdRR3yncBkDLONJGKI5cYeRYUY8WnpgHE6/xBXIEDjj0lIxk04UrfuYNhxUyZG8O5FIMWaQwEkJOOUrXtWE77Y7J0yo0/hgdiLXbHxWUDB4s9/zLVYtDBfDm0a4WxYBgpHM91KSNeFdRFniNpXqXlzM52MXjtLYUXwwzrrUbvpACUSezb9xLFyEx2YPF7iXRHvOwU5mdmZUL8Zzn60w6hIiETusOUt5qssdy4ykOFiZHVKcDXLZCHQTIHHFhaYTWzuvpK3tjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzRU99qMoIc5PxhSED3MJoQ1jUCZNLwWlQ9QtcBGOP8=;
 b=Wj10q0s/2VcdomJc4iF+fS5wcq0FHDAG42Y7x9Off8svYCHL4Ax5q4ch5wLR2S7dA53mMQLbXmRpL4KgLuDoKCaQkifvlEOMXGVwYkM1HHJK3cbX7hR7Z/WPdsqNtgwAZnfp+AQH/YHK/J9U7izBmJRV47PZC23yni3fDmXHJbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BN5PR01MB9128.prod.exchangelabs.com (2603:10b6:408:2ab::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Fri, 20 Mar 2026 23:16:24 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 23:16:24 +0000
Message-ID: <bab5b6bc-aa42-4af1-80d1-e56bcef06bc2@amperemail.onmicrosoft.com>
Date: Fri, 20 Mar 2026 19:16:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 13/13] net/mlx5: Add a shared devlink instance
 for PFs on same chip
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com,
 corbet@lwn.net, skhan@linuxfoundation.org, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 przemyslaw.kitszel@intel.com, mschmidt@redhat.com, andrew+netdev@lunn.ch,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com,
 daniel.zahka@gmail.com, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260312100407.551173-1-jiri@resnulli.us>
 <20260312100407.551173-14-jiri@resnulli.us>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260312100407.551173-14-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:930:4d::7) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BN5PR01MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: c59ea8eb-d429-43bb-077e-08de86d6b439
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|22082099003|55112099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/iHNnv/gE2P5qDZ6AVVTchDPDGNr8+lI0bP8XF3rQWxlzVPN1297UuNZXVl6tR9KnIfy/6muxZhFFeGMKK3lBSAO1VRVoG+9xKdzkFFUAJY/bimuGHI4MpGc6eXGYBmZyxxGwjGyPCMOE1ecBsyGXZFIG+QUQr4V1B+qA3CkEBCjzK4yH1KfdCTD1D57U0pgY2Oa8s7bMLuFvgmgwVM9BuI4IDf5X5Uk8V5V0MLBOH9OcsZdPTM0/qgvql6nXjL2TXf88JWnKjEsO3WzGjRPJTL1tDcvNk2cuOm0lIlRidOkrZGpKfN+EFocAtyyC5yKpALiGoV2BR5k3jOF2BXyHgwMNTJMKsEFYg6VHIZfoXD2VPYotDqXH+c2qw09igQx+5kT+xhnB6LcaspPPvnxk1OGs4y0pNrivjBPqTvu1s53fAMDVI0lhmx72lleGIfv6NAxIF4D5O1SWIbMXZVqUSfpDsOcsq273+Q3tnnxPkE4hmCbYc8IjId6LDoKq2QUufewjOPKYesrHGeC42IzsIFSCTyfEilxgxeh3wnmrAM9rgVqV1CBLgQmhvWAliOgnZvBr1R1gog+w8IrtfoK+l8w9C00XPmUhUX0cU8l6N0YTU/jC0sqOB3xYAOzMR7MbYpoxI6vHlqzpmpNLKvkZ+5ZG4nhuLg7L/9fxN7B1+Yfz0iaizlgX2jcOvyf19GpDXU68ITcqKDMi4ahub4wW5Venedwk6Nc1B3sr2wvrsI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(22082099003)(55112099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkcwQzlBd29HSFc0N2Z5NTF5VDYwZ0VUV0FPSWdHdkkyU3kwMUZkQU02ajZR?=
 =?utf-8?B?NFVOV0ZDeEZ5NW9KUVo1a1hvbzJFbHJSakJaeGZwVmxSckpMUVFZYVFoUURD?=
 =?utf-8?B?aWZGVFY0ZWMrUFdpanh1UitsMkUxTE5yN3ROWnk3THZzVzFVRDJDWktPSWN6?=
 =?utf-8?B?WXlITldwbFpadjRDbzB6R3czL3FRM0xEYlZhUnVCVllCeFVwUkFSaW5ScmN5?=
 =?utf-8?B?NXR0OVRpSDhlcitTL215OWRlSFpXbzF0VTZmWjk1TGVRNm4rYm5FTVN6Q3J3?=
 =?utf-8?B?WHpGV1lLR1IyVWZoMUJYZEJQZ1dNN3NkWFRpN29IMzJ1cjQzRkdBb2xSVnh1?=
 =?utf-8?B?dVJPSGN0QzUzdW43a3ZPRHlPaHV3SUZic3lXdTAvL0tvM3ByVjRZOHQxTktV?=
 =?utf-8?B?a3FqTDFWYzByL1ZLeWRhTzlrRjdBL1RWK2FCZFYySFJPN0MweEFiNTR2R1hh?=
 =?utf-8?B?S3BxTnA3eGFCRUFpbmo4T0RrSitrREZoR05xdEpydWtkNHB3TkErZmZ4YnNv?=
 =?utf-8?B?YmdldkdwcWhWT3FSWnpyWTJFaUF6N1haWlJpL3dNVW9YWTdMbWh4OWxjL1VF?=
 =?utf-8?B?N3B4TzY2OWdQejNvL0lTVnZLdlJ2YTB5N0Ura2F3ZnBrdjh0RXJaN1d0ckdo?=
 =?utf-8?B?ZFZGcjBWdk91YThJQkEzaEo3dWxIQjdiQjVHREcvd1k5RHRLK1dQVExJTGNt?=
 =?utf-8?B?RE8yTlRkZ2MvSjduT05CMFprZ1BJNVpPUGxGMlMybEsyOFBzZWdsaFIrVHM1?=
 =?utf-8?B?UXZsWHIxalJSMS8xeTQzekhFQ1JOR21YUWU0a0NoclYvMFdoVFBMWjh4bHMz?=
 =?utf-8?B?ZElqSjRIeUtGK0xmd1hUMDhqQ0J5VWpmaHJmR3RoK3pNcVNFRjdWWlMrTTFQ?=
 =?utf-8?B?LzkxWDA3dStBRWdNRDRONjh0TnJoSVFGaWo5VU4wdmsvRjIvalZhWUxGZVFK?=
 =?utf-8?B?RVBzQWNMNWN6SG9qdXpYZFFEdkJpUzVGQW0zVVJVNW4waHY5UWttUVBqcGxZ?=
 =?utf-8?B?SHNnL1lSSitvYno3MW94UTZEdVgySHcwUytKTFNPQ3libHhnWlRLaGJQTzhY?=
 =?utf-8?B?KytSL2ptMVFTSnVDRmFIcitGMHR2anJ4WVAzTEY0bjdVME5FSEZwZDRFOHk5?=
 =?utf-8?B?Sit6TXVSTkw0ay9UMUdMUEJJOSs0MENJVCtZcVAyUEpOc25CWGNXaEc0Qm1y?=
 =?utf-8?B?eExSdC9BdktLSVgybzF0dDIzSXRRYkw3M3I4Nm5xRitqYzl6bnBaaHNyeFk0?=
 =?utf-8?B?RGNKSTBLMnVDU3VCRlJaVDlubkcyRUNaVkJzU1ZEMVoyT2tWbFJuWStIUVVs?=
 =?utf-8?B?RjIySnFaRXNZSmpnU0NhWGZEeENyQjVuOWtmcWwxRkxoOVVFcndyTmlhZlYw?=
 =?utf-8?B?WFVjM3BsM0ZEZkVrbkJ5OEhNN1NOSEVJUk1EaTVlaFVDcjBjSEV4NlBwSzI2?=
 =?utf-8?B?RjU3blBnekJtR3NoZmI5d1NQUHZJcklFOXFOZE93TXpUNEd0SDRpaEhad0cy?=
 =?utf-8?B?V2QrVzh0amNIajRWTUVBUlF6Q1BTempkNHUyRmZtaElsVlYxRVJYMGV4amN3?=
 =?utf-8?B?R0VsYXF4V2dIMDMzNHlUd1JCS1NjNzdpNEJEa2RTOTBwWUR2WWE2cHlqbnZY?=
 =?utf-8?B?WU9RNE1LSVFDU0ZtTDV4QnhDVW5Ya2RxaG9uQ1d2QUtGak5FTGlnb2c1Z3cw?=
 =?utf-8?B?aHVVekx1WVBQS1RPbnlVYVFlWG1DOTU5b2ZKMXZURWovK2RqUFJZMGdRajFR?=
 =?utf-8?B?YXJPK2s2ayt1dE5QclA4aUFTbmlDVjIwc0RyS2NGQzA1ZC9ScXV5dHNMTXNU?=
 =?utf-8?B?cFdsTXZWWUVhdjlpWS9ubGU2N3l6TExHanhRekk1cVlNU1FLcFc3d21kRWVv?=
 =?utf-8?B?bzRxNWluZE16TlYyY1ptN2xKQXdaM0pYaWc4THlCUG9HVlRYait0dUpHV0x2?=
 =?utf-8?B?Y3hDK3BENFArVHNHSDJjRTU2eFhVV2VFTlhIcytIUTNLV0w4Wkc5UzlSZ3BP?=
 =?utf-8?B?K3FqNDI5bFBDN3JZci9QczZvOHcxVFhjZ25mL1NLcTdKUkhhZmZ2M1htbVZz?=
 =?utf-8?B?dzZDRjd2TlFrL3pBWHplMUY3NmNhMzhaQ3VBcnBBNiszcWdoNkNUcG1vNnNZ?=
 =?utf-8?B?VnlHeUczVnBRZlNidi9wQkdzZnZ2TmJ4bWRIWVl3bjRoWkt6cTJHR1Nibi9W?=
 =?utf-8?B?WVlFdGFUR2tFUzlQazdsNzdEUklLR25qdSs4VzhZallHWjhGdks3d2w1Q0kz?=
 =?utf-8?B?VUJVTkszTE1EK1RxZ2hFcitNVWdsaXpyeEV5eksxUzVaejlTcGcvYkpHVklw?=
 =?utf-8?B?Zmx0SlpmMEtic0Zra2tnc0kzN0RPblVoK0NIa2t2U0VCb0N1WENOM1RFbDhp?=
 =?utf-8?Q?rU+LJT7G6hbQ/5IwxzofO3bLVDA1nSkaiVCFqWORGlFT1?=
X-MS-Exchange-AntiSpam-MessageData-1:
	9S8VojPnbqE5v1q9NrNpk4JjnYxpnVbtwI5VT265Ht1vpo86iUUS/pmR
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59ea8eb-d429-43bb-077e-08de86d6b439
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 23:16:23.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+7jfo1FYdIVWdFxpZJLBGNZs3sPtQDDybb0kQq2R0m4+WeMESWHPq5M48/DNJb4hyrfZseDcj51vDptAv2YyLh3NmzpfNzdexgX/WAZG6/KUsi7iVkiRIEE4bqmXmlM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR01MB9128
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18479-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[1.000];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,amperemail.onmicrosoft.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27FD02E23E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This breaks on my system:

On 7.0.0 It boots fine.  With net-next/main currently at this commit


commit 8737d7194d6d5947c3d7d8813895b44a25b84477 (net-next/main, 
net-next/HEAD)
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Fri Mar 13 17:28:36 2026 +0100

I get:

[   21.859081] mlx5_core 0005:01:00.0: probe_one:2017:(pid 10): 
mlx5_shd_init failed with error code -2
[   21.863266] mlx5_core 0005:01:00.0: probe with driver mlx5_core 
failed with error -2
[   21.866360] mlx5_core 0005:01:00.1: probe_one:2017:(pid 10): 
mlx5_shd_init failed with error code -2
[   21.869937] mlx5_core 0005:01:00.1: probe with driver mlx5_core 
failed with error -2


I am happy to help debug:   what do you need from me?


On 3/12/26 06:04, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>
> Use the previously introduced shared devlink infrastructure to create
> a shared devlink instance for mlx5 PFs that reside on the same physical
> chip. The shared instance is identified by the chip's serial number
> extracted from PCI VPD (V3 keyword, with fallback to serial number
> for older devices).
>
> Each PF that probes calls mlx5_shd_init() which extracts the chip serial
> number and uses devlink_shd_get() to get or create the shared instance.
> When a PF is removed, mlx5_shd_uninit() calls devlink_shd_put()
> to release the reference. The shared instance is automatically destroyed
> when the last PF is removed.
>
> Make the PF devlink instances nested in this shared devlink instance,
> allowing userspace to identify which PFs belong to the same physical
> chip.
>
> Example:
>
> pci/0000:08:00.0: index 0
>    nested_devlink:
>      auxiliary/mlx5_core.eth.0
> devlink_index/1: index 1
>    nested_devlink:
>      pci/0000:08:00.0
>      pci/0000:08:00.1
> auxiliary/mlx5_core.eth.0: index 2
> pci/0000:08:00.1: index 3
>    nested_devlink:
>      auxiliary/mlx5_core.eth.1
> auxiliary/mlx5_core.eth.1: index 4
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v2->v3:
> - removed "const" from "sn"
> - passing driver pointer to devlink_shd_get()
> ---
>   .../net/ethernet/mellanox/mlx5/core/Makefile  |  5 +-
>   .../net/ethernet/mellanox/mlx5/core/main.c    | 17 ++++++
>   .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 61 +++++++++++++++++++
>   .../ethernet/mellanox/mlx5/core/sh_devlink.h  | 12 ++++
>   include/linux/mlx5/driver.h                   |  1 +
>   5 files changed, 94 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> index 8ffa286a18f5..d39fe9c4a87c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> @@ -16,8 +16,9 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
>   		transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
>   		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o events.o wq.o lib/gid.o \
>   		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o diag/fs_tracepoint.o \
> -		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o diag/reporter_vnic.o \
> -		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o lib/nv_param.o
> +		diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o diag/rsc_dump.o \
> +		diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o \
> +		lib/nv_param.o
>   
>   #
>   # Netdev basic
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index fdc3ba20912e..1c35c3fc3bb3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -74,6 +74,7 @@
>   #include "mlx5_irq.h"
>   #include "hwmon.h"
>   #include "lag/lag.h"
> +#include "sh_devlink.h"
>   
>   MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
>   MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
> @@ -1520,10 +1521,16 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
>   	int err;
>   
>   	devl_lock(devlink);
> +	if (dev->shd) {
> +		err = devl_nested_devlink_set(dev->shd, devlink);
> +		if (err)
> +			goto unlock;
> +	}
>   	devl_register(devlink);
>   	err = mlx5_init_one_devl_locked(dev);
>   	if (err)
>   		devl_unregister(devlink);
> +unlock:
>   	devl_unlock(devlink);
>   	return err;
>   }
> @@ -2005,6 +2012,13 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
>   		goto pci_init_err;
>   	}
>   
> +	err = mlx5_shd_init(dev);
> +	if (err) {
> +		mlx5_core_err(dev, "mlx5_shd_init failed with error code %d\n",
> +			      err);
> +		goto shd_init_err;
> +	}
> +
>   	err = mlx5_init_one(dev);
>   	if (err) {
>   		mlx5_core_err(dev, "mlx5_init_one failed with error code %d\n",
> @@ -2018,6 +2032,8 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
>   	return 0;
>   
>   err_init_one:
> +	mlx5_shd_uninit(dev);
> +shd_init_err:
>   	mlx5_pci_close(dev);
>   pci_init_err:
>   	mlx5_mdev_uninit(dev);
> @@ -2039,6 +2055,7 @@ static void remove_one(struct pci_dev *pdev)
>   	mlx5_drain_health_wq(dev);
>   	mlx5_sriov_disable(pdev, false);
>   	mlx5_uninit_one(dev);
> +	mlx5_shd_uninit(dev);
>   	mlx5_pci_close(dev);
>   	mlx5_mdev_uninit(dev);
>   	mlx5_adev_idx_free(dev->priv.adev_idx);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
> new file mode 100644
> index 000000000000..bc33f95302df
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
> +
> +#include <linux/mlx5/driver.h>
> +#include <net/devlink.h>
> +
> +#include "sh_devlink.h"
> +
> +static const struct devlink_ops mlx5_shd_ops = {
> +};
> +
> +int mlx5_shd_init(struct mlx5_core_dev *dev)
> +{
> +	u8 *vpd_data __free(kfree) = NULL;
> +	struct pci_dev *pdev = dev->pdev;
> +	unsigned int vpd_size, kw_len;
> +	struct devlink *devlink;
> +	char *sn, *end;
> +	int start;
> +	int err;
> +
> +	if (!mlx5_core_is_pf(dev))
> +		return 0;
> +
> +	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
> +	if (IS_ERR(vpd_data)) {
> +		err = PTR_ERR(vpd_data);
> +		return err == -ENODEV ? 0 : err;
> +	}
> +	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3", &kw_len);
> +	if (start < 0) {
> +		/* Fall-back to SN for older devices. */
> +		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
> +						     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
> +		if (start < 0)
> +			return -ENOENT;
> +	}
> +	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
> +	if (!sn)
> +		return -ENOMEM;
> +	/* Firmware may return spaces at the end of the string, strip it. */
> +	end = strchrnul(sn, ' ');
> +	*end = '\0';
> +
> +	/* Get or create shared devlink instance */
> +	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, pdev->dev.driver);
> +	kfree(sn);
> +	if (!devlink)
> +		return -ENOMEM;
> +
> +	dev->shd = devlink;
> +	return 0;
> +}
> +
> +void mlx5_shd_uninit(struct mlx5_core_dev *dev)
> +{
> +	if (!dev->shd)
> +		return;
> +
> +	devlink_shd_put(dev->shd);
> +}
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
> new file mode 100644
> index 000000000000..8ab8d6940227
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
> +
> +#ifndef __MLX5_SH_DEVLINK_H__
> +#define __MLX5_SH_DEVLINK_H__
> +
> +#include <linux/mlx5/driver.h>
> +
> +int mlx5_shd_init(struct mlx5_core_dev *dev);
> +void mlx5_shd_uninit(struct mlx5_core_dev *dev);
> +
> +#endif /* __MLX5_SH_DEVLINK_H__ */
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index 04dcd09f7517..1268fcf35ec7 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -798,6 +798,7 @@ struct mlx5_core_dev {
>   	enum mlx5_wc_state wc_state;
>   	/* sync write combining state */
>   	struct mutex wc_state_lock;
> +	struct devlink *shd;
>   };
>   
>   struct mlx5_db {

