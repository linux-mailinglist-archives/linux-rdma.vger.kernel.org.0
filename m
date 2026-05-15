Return-Path: <linux-rdma+bounces-20785-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKcwAvNZB2qzzwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20785-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:37:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FFC55554D
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 205DE30433AD
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 17:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C993F39FD;
	Fri, 15 May 2026 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ed0i15Za"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D413DCDBE;
	Fri, 15 May 2026 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866228; cv=fail; b=F3TjsJwZQ2Rsh8LoG/oaN8OvSFQR5pDs4bR4HjWotC+jOlO9S5w/0Lpb7+Mixazg6fDP5F9TQD7hwYmqSwJ83fZ5WkWa2YeoK2hg8i1obeUBty+1hiRgw9X+wmz9aYLAPKBuiKyNsbrMumBvoOMs1CbjYCFqDBRPnLnyARpXy8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866228; c=relaxed/simple;
	bh=QmjCSfVoUk5hRRdqnNZzgJrxcv5n7biQvllZNKDoEDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SrtXhwK4xcCJ1Ydvjbau34p3wauIIhFdrvAxFGQWUEtSB8Nf0Vqi2VlTUqouWtdW1gajKwDbYcSp5zV8j4msHaO1UOaU62M7s0aR4d+ofGMTipfFhfhwNmuMq7azfm/8lmJFWHJMWW1nCym+46wwhy+wTJZKX+N1LTagUbrR6qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ed0i15Za; arc=fail smtp.client-ip=40.107.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ln4bBjTqxRZgil8ZmoJnJL3IIWGCb1MbfjpZN7K7Fqq6PVFJZf3gtXtFlT9d2lDPtVriBvSsNzyLijDSfnPgRX/49F0P35uUpIbYuUGXHtDtZKPTgw8KHlGXSlbYLOx+4tvngKdEcxaLg/R5j61nueXGzX0itXMyqrXWEVIjNrl0r6QeY7mQ5c5ogokIf38+j0rTYmHTMovdFoonnxS8W0RrmXF7qiBIx/a6XUQC6Tch6jEpgMPJWCzqg+r7eH2pmGkSoHZeCo7eG9Jfvddt4r2gDX24XFGnaoifg7xUqHrO8PRZC7LmGyb04dwQQa36fmc91mtrrd+uclDB1paxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dC2puCbvKkFO8ET+NT3Jc/ENzg9D2JD9+hdhdsg1Gg=;
 b=i/ERchGscaRuLc8lxs6rcq05sQq9HIeKQnSyfhXo8+PAwX5mE7kRTL4XEIjoLKCO43HwMPSgIfQFvHITLCjrYwu8weHHex7dyEfQgCby7Z/2gDiRVTSUsmN3zJ1E7VqgsPULJzICzoEb2hnTKRIoBRWM/PT6+w10V1KsToVFh95h8e8B3p2kTadQU9ynccwHySdi0M+Ec1QV+tdmo0INEM00hI+loODMgsTQT8jcuTQEsLUr6iRk9iV/f7DTTkz7MqQDfX5mU+fe2HDGcq5n/XcYQDm7I7V6Uql8WdqLdOPBE5mhG5SjdhRacbCNSC5dJeXojKpOfqCfdTH01Ql/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dC2puCbvKkFO8ET+NT3Jc/ENzg9D2JD9+hdhdsg1Gg=;
 b=ed0i15Zad7/Af1hp/I4yFlY08SE3JD+dUpgFJimU2cg2W58tu+ex2m/Q24xpja6tjNdFsz3dSNko9bZQw9n5cK0ecsPtiEnBI/dFfFPRm44NY+Nl621ZDg+esM0N0+hkTJh4+efh3xOSOO35cqk8pv0oRTfgN2I8kNkT1PT3aqP1cegVAGpDmrs7B+2kcIeqevB9/EafUj45wbv0JXqER15ocaafoRyHNPQ4RFn8LI6F0e2/HFaO7qEsjFpZuLI2cDD6NOsmoYLL4cfaN0jknBlasyMxyxqmfAmMjgSXuCqs/iiKXNWUziiYVXl9VsFKpN2etd4+pQbsU2/9AHZPUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 17:30:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 17:30:15 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 11/11] vfio: selftests: mlx5 driver - add send_msi support
Date: Fri, 15 May 2026 14:30:08 -0300
Message-ID: <11-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
References:
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 523d4bc5-92b7-4f61-38b4-08deb2a79f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	NFbMzSoY+egsKscOnukddoq+DZreofHzlhuuthX2ToMUSYkfKoJjhbkCqAEvi6o+EpRDYEVqXK7DDNKohtMzJqWAOgp0JHGEe8R7VKfK3W8QeFmp71qiPprPlJFUySjpqKgrSJerum9H0WWg93SKj5IR7TiO0rUfRhF9DCc2SQFDcLf0C8quzKArxbNV7EELLfE+m4EAKei8jH3HHW3utQUb3w20nPbI+Q8eg8XdaMYptYppuzwV7la4vMefFdyPgP+Hk/8RKmuL0z6smmUp19yMi8UovlAZG27HqMTRmUiHgYHDTkpLRitzH1Su2Dp8PFGufjrxHiTskYlAqGC+dP+kvultQvrcXZe5C0C9ihPeut//NVBB6idBibvCJB0Z4emZUF5y3zEkB2uWa93zOgh4VrjbM0FYpURZin3vn0Qwp2usJgyyn5+vi/UYQ9l1p7a+eN6jnyi46pDKDEbgGiy5ZvWytL+M+WR0cJh8bY7yOZV5Fh2kBF8U/YbakeIvUQsyc+D2pF149ijEGr24qTFOfMaWxdSqm7ExYXmN+fsH2Anb3Fg+EHhJw9R30aND/EpzKpaQHhZ4x5QNQ3HXVbnJEv/6E3O1a/Bee/hd15LcqtkE8yNoVAN4x0aal/BWPxUwaVgW3sxQcXUtgcI/GOyDZKPtfO8iFL1EQPoGoqrrHq+/hDZgUaKfVKed89ul4Vaeu26eDhjmtqLpb/u5OhLWSmh0d/zyWNyIiTfRSfw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2xsenVHVC9idk5jaXF1UmhUQ2pJYXFqQjZaUEpkbXV1WHNrdzJmZjY0L2FV?=
 =?utf-8?B?U1VlOE5NT21zWWJ0RGJja1AycS9kOXZCWkE0UUZWNnF4SFdadkx3dk04NnZr?=
 =?utf-8?B?RVk0TWVtTUs4ZFB5Yk5oZlFxTlJBUDl3dDlLQTdZZEhrQitZeVhnc1djRWc0?=
 =?utf-8?B?TkFFTjdla1plTjZISWlwUjRwbStTaThjZVcxTzNIaHk2eDk1S1g5b1ptV0xl?=
 =?utf-8?B?b1ZWNGpzV2ZsTGd5ZUVVWmJxZzh6MEk2SGtOblRTclVEWDhNVHJ0bXZMamxK?=
 =?utf-8?B?YnBxQTZoY1B4RXAvNEVjRFNBbTlqVFNUNDhMM2VoN1FrT3diS01ld3hqMmZU?=
 =?utf-8?B?Qi9KcmczdGxCdThKWjVhdU9Td2p3MSt4UGNnTENaQVdVbkw3cGNnWlZ6RU1i?=
 =?utf-8?B?cVNLU2lJWnROQU1MdCtacG9nTnZHNmRMZmI5TmRGQlJJQml3RWlLYWdaRDlr?=
 =?utf-8?B?djNSSTJ1elNCcDRkdWJ0dGlSQkVnaHhOTGVOY2tsRkhZUHVKMDU3ZEZYaDlH?=
 =?utf-8?B?VXgzY2ZZNXJNVGpHUG11cHQxQS9XYldvNFZFWEVOaHNaT1pyZVlEQWxlQ0I5?=
 =?utf-8?B?dGdrR0RYQzAzZGpMdUs2Q2RoMDgxQ05DcXhhT1c2MXZLbmVKWVo0MkthY0hE?=
 =?utf-8?B?Ym5oSGFyNTAzSktoZWIvVmZVbEplMkZka0U3MUovUDk1OGtULzh0VDFKOFZW?=
 =?utf-8?B?T2xSV21YVTZHR3oyTlNDVkdJQUJLbjN2dUZQSTFjRTlYTGhGM3lzTU9nWXg1?=
 =?utf-8?B?MXR6OXNBbXdENVNzaTNPNm9lbWNvbk84S1F4bFFoRUtFUERhN2IvOFh5bEp3?=
 =?utf-8?B?cDJIRzBvckNYZ1MxaGFYRkd5LzhSVWxFYnk1ZGk3eDFFUHRvcHJoeXFiMVdo?=
 =?utf-8?B?TTQ0Y096QTBoR3hRdEdFY3FDd28velNwMGVwK25JZlNpR2MzZ1hxdlQ0d3Ri?=
 =?utf-8?B?R0xnZU9FM3RDM2ZzY3lvQ1JHd2c3YzhLcXBYWTdLNHhwd1loY0k0M1o1azFp?=
 =?utf-8?B?cWFGbTJEYWMvY3FBRGt0SG54MHF0NmZGZkQ0SnVYaWQ4SlJCMU5ucmFTTlZU?=
 =?utf-8?B?cm5MN0RtOThpUVMyZCtQOEw1NFpoamRNbkFaczhVVndMbHRKa2N2NlFIaEZI?=
 =?utf-8?B?Z0JTdUo1TFRkV1lzblZTeXhlVVkvYktWbDZWdWZNRWlnS2czSTVpMW9pQVBX?=
 =?utf-8?B?dFRTVzU4UXhyanFJbGhqVStrTUl2TC9EVTRKSE54WVF4RHFMTGNDalV5RjBG?=
 =?utf-8?B?R2J6ODhkemNhOWMrZU5hUjBtMVdWRVEwYlJFZXlqZSt6S056MHZ5NXBPQVdX?=
 =?utf-8?B?Z1o3L25HMFFaN3VJSk15TW9EZThVaXQvdlJnS1NwVW9zYW9wZmltZGI0U1l0?=
 =?utf-8?B?dHVkdVpaUlhFMzBsMnlubjRPUGtwcnhFbnBMSHJwY2k3ZHY0ZkQrTDAwRm5q?=
 =?utf-8?B?dDZtNjVnTk5JSTlabU9FRDg5L05Ha1MxWTRGSkdMc1lVMlV2MXc3VDVybEZj?=
 =?utf-8?B?Zk1SbW1vZlFwUjhGamh2eTRBUFJ5RlYxUDlhM3NLTDFHbUo0d3dRVmpqKzRP?=
 =?utf-8?B?QnhEWnV6VlBIbEx5N0loWFZadmdTM0l6VFYzZHRMT1VsV3JxZkFPQWd0dUx5?=
 =?utf-8?B?aWYybk44RFltdWh2RTF5cWJsS2ZsSUdGR1ZsTGVqRVRzWWpvTlJEcmh2ZGE1?=
 =?utf-8?B?L0gxYldSMmlKaEdvQnh1MEhsb2tSb1FISkkwM2RBWmk3WTE0S0RjUktOcHA4?=
 =?utf-8?B?YjhzTDlEamdTUHlNZDJIRVpqaWxXSFk0cmZQclN6S2doQzNzc05yR3RUMm1X?=
 =?utf-8?B?eEZnUTFvbXZKQ3VWMGFHYmtHZmk4UDBhVXZvbkFCT2pRSEUrUlJlSzZtUVVz?=
 =?utf-8?B?NDN6U2pqamNGbzM5SGtVNnJ1QlFsTmZWV01MQmhrTG9yRFY4TmExeFlsOGU2?=
 =?utf-8?B?UVduS2dKUnFRbWR5YjZ0bTJacEoxRUtPSzJHdEMvWVFuUDNzRnFVemhwcERO?=
 =?utf-8?B?SU8rYmNhY1FselhlQ2NJa045T3lpejl0bWlueXFENzlteTRLWHVtL2hrNkFs?=
 =?utf-8?B?UG43YkdKNUhqTnZVMmlFMkxtaUVvbVI1MVBidEZQZUJUd0FhOGhxMUo4ang5?=
 =?utf-8?B?cVhoOWxaYjV3R3MxZWVDOUFVcnpVaERIU1hMVFRSa1ZONlliZWxjMlNUa2dG?=
 =?utf-8?B?T1hGYi9pNCtHRVkyZG9JUWp5Z0VjU000K3N0eU4wc2pFZlRYL1c4V1JUdS9k?=
 =?utf-8?B?Rkt1STRPRlFrOWJodXZDTGREMjIyYm82TXM5MHV5VFJadVhCV01XblhaKzlH?=
 =?utf-8?Q?4mTw50Hrb7a3xvFsgB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523d4bc5-92b7-4f61-38b4-08deb2a79f1a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 17:30:13.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCS5VKcoucfb547Fh8uvDdIZIvcrR4cKzdBf7ZoeWyqKzEiQLxYED1yatXSEBYp7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
X-Rspamd-Queue-Id: B0FFC55554D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20785-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Action: no action

Wire an MSI-X vector to a dedicated EQ so the mlx5 driver supports
send_msi().

Each EQ can be linked to an MSI-X vector, and the CQ can be set up
to deliver an event to the EQ. Thus, when everything is armed, an
RDMA WRITE posted to the QP generates a CQE, which generates an
EQE, which generates an MSI-X.

To keep things simple this just re-uses all the existing QPs and
CQs, so they generate single MSIs during memcpy.

send_msi() drains any accumulated MSI EQ events from prior memcpy
completions, posts a small signaled RDMA Write, then polls the CQ to
consume the resulting CQE (avoiding stale completions on subsequent
test cycles).

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../selftests/vfio/lib/drivers/mlx5/mlx5.c    | 165 +++++++++++++++++-
 .../selftests/vfio/lib/drivers/mlx5/mlx5_hw.h |   6 +
 2 files changed, 168 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
index e5e75adb253166..c8388aabb8c672 100644
--- a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
+++ b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
@@ -57,17 +57,23 @@ struct mlx5st_device {
 	/* CQ */
 	u32 cqn;
 	u32 cq_ci;
+	u32 cq_arm_sn;
 
 	/* UAR */
 	u32 uar_page;
 	void __iomem *uar_base;
 	unsigned int uar_bf_offset;
 
-	/* EQ */
+	/* EQ (cmd/pages events — polled, not interrupt-driven) */
 	u32 eqn;
 	u32 eq_cons_index;
 	bool have_eq;
 
+	/* MSI EQ (CQ completion events — fires MSI-X) */
+	u32 msi_eqn;
+	u32 msi_eq_cons_index;
+	bool have_msi_eq;
+
 	/* Async pages slot state */
 	bool pages_slot_in_use;
 	bool pages_slot_is_reclaim;
@@ -91,6 +97,10 @@ struct mlx5st_device {
 	bool fl_supported;
 	u8 log_max_msg;
 
+	/* Buffers used by send_msi() to trigger an interrupt */
+	u64 send_msi_src;
+	u64 send_msi_dst;
+
 	/*
 	 * HW-visible DMA buffers below — device reads/writes via DMA.
 	 */
@@ -113,6 +123,9 @@ struct mlx5st_device {
 	/* EQ does not support page_offset */
 	struct mlx5st_eqe eq_buf[EQ_NENT] __aligned(MLX5_HW_PAGE_SIZE);
 
+	/* MSI EQ buffer — CQ completions generate EQEs here -> MSI-X */
+	struct mlx5st_eqe msi_eq_buf[MSI_EQ_NENT] __aligned(MLX5_HW_PAGE_SIZE);
+
 	u8 fw_pages[MAX_FW_PAGES][MLX5_HW_PAGE_SIZE]
 		__aligned(MLX5_HW_PAGE_SIZE);
 };
@@ -135,6 +148,9 @@ static_assert(offsetof(struct mlx5st_device, qp_dbrec) % 64 == 0,
 static_assert(offsetof(struct mlx5st_device, eq_buf) %
 			      MLX5_HW_PAGE_SIZE == 0,
 	      "eq_buf must be page-aligned");
+static_assert(offsetof(struct mlx5st_device, msi_eq_buf) %
+			      MLX5_HW_PAGE_SIZE == 0,
+	      "msi_eq_buf must be page-aligned");
 static_assert(offsetof(struct mlx5st_device, fw_pages) %
 			      MLX5_HW_PAGE_SIZE == 0,
 	      "fw_pages must be page-aligned");
@@ -1013,6 +1029,85 @@ static void mlx5st_process_events(struct mlx5st_device *dev)
 		mlx5st_eq_update_ci(dev, cc, 0);
 }
 
+/*
+ * MSI EQ — dedicated EQ for CQ completion events that fires MSI-X.
+ * Separate from the cmd/pages EQ so that only CQ completions (from
+ * send_msi or memcpy) trigger the interrupt vector.
+ */
+
+static void mlx5st_msi_eq_drain(struct mlx5st_device *dev)
+{
+	u32 cc = 0;
+	u32 val;
+
+	while (cc < MSI_EQ_NENT) {
+		u32 ci = dev->msi_eq_cons_index + cc;
+		struct mlx5st_eqe *eqe =
+			&dev->msi_eq_buf[ci % MSI_EQ_NENT];
+
+		if (MLX5_GET_ONCE(eqe, eqe, owner) != !!(ci & MSI_EQ_NENT))
+			break;
+		cc++;
+	}
+
+	/* Update consumer index and re-arm for next interrupt */
+	dev->msi_eq_cons_index += cc;
+	val = (dev->msi_eq_cons_index & 0xffffff) | (dev->msi_eqn << 24);
+	iowrite32be(val, (u8 __iomem *)dev->uar_base + MLX5_EQ_DOORBELL_OFFSET);
+}
+
+static void mlx5st_create_msi_eq(struct mlx5st_device *dev)
+{
+	struct vfio_pci_device *device = dev->device;
+	u64 in[MLX5_ST_SZ_QW(create_eq_in) + 1] = {};
+	u32 out[MLX5_ST_SZ_DW(create_eq_out)] = {};
+	struct mlx5_ifc_eqc_bits *eqc;
+	unsigned int i;
+	__be64 *pas;
+
+	/* Initialize EQE owner bits */
+	for (i = 0; i < MSI_EQ_NENT; i++) {
+		struct mlx5st_eqe *eqe = &dev->msi_eq_buf[i];
+
+		MLX5_SET_ONCE(eqe, eqe, owner, 1);
+	}
+
+	MLX5_SET(create_eq_in, in, opcode, MLX5_CMD_OP_CREATE_EQ);
+
+	/*
+	 * No event_bitmask — completion events are routed to this EQ via
+	 * the CQ's c_eqn field, not through CREATE_EQ subscription.
+	 */
+	eqc = MLX5_ADDR_OF(create_eq_in, in, eq_context_entry);
+	MLX5_SET(eqc, eqc, log_eq_size, LOG_MSI_EQ_SIZE);
+	MLX5_SET(eqc, eqc, uar_page, dev->uar_page);
+	MLX5_SET(eqc, eqc, intr, MSI_VECTOR);
+	pas = MLX5_ADDR_OF(create_eq_in, in, pas);
+	VFIO_ASSERT_EQ(mlx5st_fill_pas(device, dev->msi_eq_buf, pas), 0u);
+	MLX5_SET(eqc, eqc, log_page_size, 0);
+
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+
+	dev->msi_eqn = MLX5_GET(create_eq_out, out, eq_number);
+	dev->msi_eq_cons_index = 0;
+	dev->have_msi_eq = true;
+	mlx5st_msi_eq_drain(dev);
+
+	dev_dbg(device,
+		 "Created MSI EQ: eqn=%u, %d entries (COMP), vector=%d\n",
+		 dev->msi_eqn, MSI_EQ_NENT, MSI_VECTOR);
+}
+
+static void mlx5st_destroy_msi_eq(struct mlx5st_device *dev)
+{
+	u32 out[MLX5_ST_SZ_DW(destroy_eq_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(destroy_eq_in)] = {};
+
+	MLX5_SET(destroy_eq_in, in, opcode, MLX5_CMD_OP_DESTROY_EQ);
+	MLX5_SET(destroy_eq_in, in, eq_number, dev->msi_eqn);
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+}
+
 /*
  * HCA init / teardown
  */
@@ -1369,7 +1464,7 @@ static void mlx5st_create_cq(struct mlx5st_device *dev)
 	cqc = MLX5_ADDR_OF(create_cq_in, in, cq_context);
 	MLX5_SET(cqc, cqc, log_cq_size, LOG_CQ_SIZE);
 	MLX5_SET(cqc, cqc, uar_page, dev->uar_page);
-	MLX5_SET(cqc, cqc, c_eqn_or_apu_element, dev->eqn);
+	MLX5_SET(cqc, cqc, c_eqn_or_apu_element, dev->msi_eqn);
 	MLX5_SET(cqc, cqc, cqe_sz, 0);
 	pas = MLX5_ADDR_OF(create_cq_in, in, pas);
 	MLX5_SET(cqc, cqc, page_offset, mlx5st_fill_pas(device, dev->cq_buf, pas));
@@ -1394,6 +1489,30 @@ static void mlx5st_destroy_cq(struct mlx5st_device *dev)
 	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
 }
 
+/*
+ * Arm CQ for event generation.  The CQ event delivery state machine is
+ * single-shot: after generating one EQE the CQ enters "Fired" state and
+ * won't generate another until re-armed via ARM_NEXT.  Both the CQ doorbell
+ * record and the UAR CQ doorbell register must be written.
+ */
+static void mlx5st_arm_cq(struct mlx5st_device *dev)
+{
+	u32 sn = dev->cq_arm_sn & 3;
+	u32 ci = dev->cq_ci & 0xffffff;
+	u64 doorbell;
+
+	/* Update CQ doorbell record arm word */
+	WRITE_ONCE(dev->cq_dbrec.send_counter,
+		   cpu_to_be32(sn << 28 | ci));
+
+	/* Ring CQ doorbell register, iowrite has an internal dma_wmb() */
+	doorbell = ((u64)(sn << 28 | ci) << 32) | dev->cqn;
+	iowrite64be(doorbell,
+		    (u8 __iomem *)dev->uar_base + MLX5_CQ_DOORBELL_OFFSET);
+
+	dev->cq_arm_sn++;
+}
+
 /*
  * QP create/destroy
  */
@@ -1650,6 +1769,7 @@ static void mlx5st_teardown_datapath(struct mlx5st_device *dev)
 	}
 	dev->sq_pi = 0;
 	dev->sq_ci = 0;
+	dev->cq_arm_sn = 0;
 	memset(&dev->qp_dbrec, 0, sizeof(dev->qp_dbrec));
 	memset(&dev->cq_dbrec, 0, sizeof(dev->cq_dbrec));
 }
@@ -1691,6 +1811,34 @@ static int mlx5st_memcpy_wait(struct vfio_pci_device *device)
 	return ret;
 }
 
+/*
+ * send_msi callback — trigger CQE -> EQE -> MSI-X via a small RDMA Write.
+ *
+ * Both the CQ and MSI EQ use single-shot arming: the CQ must be armed so the
+ * CQE generates an EQE, and the MSI EQ must be armed so the EQE fires MSI-X.
+ */
+static void mlx5st_send_msi(struct vfio_pci_device *device)
+{
+	struct mlx5st_device *dev = to_mlx5st(device);
+
+	/* Drain accumulated MSI EQ events and re-arm for next interrupt */
+	mlx5st_msi_eq_drain(dev);
+
+	/* Arm CQ so the next CQE generates an EQE on the MSI EQ */
+	mlx5st_arm_cq(dev);
+
+	/* Post a signaled RDMA Write to trigger CQE -> EQE -> MSI-X */
+	mlx5st_post_rdma_write(dev,
+			       to_iova(device, &dev->send_msi_src),
+			       dev->global_lkey,
+			       to_iova(device, &dev->send_msi_dst),
+			       dev->global_rkey,
+			       sizeof(dev->send_msi_src), true);
+
+	/* Consume the CQE to avoid stale completions */
+	VFIO_ASSERT_EQ(mlx5st_poll_cq(dev, MLX5ST_MEMCPY_TIMEOUT_MS), 0);
+}
+
 /*
  * Driver ops callbacks
  */
@@ -1721,8 +1869,13 @@ static void mlx5st_init(struct vfio_pci_device *device)
 	mlx5st_alloc_pd(dev);
 	mlx5st_create_mkey(dev);
 
+	/* MSI EQ must be created before CQ so CQ can reference its eqn */
+	mlx5st_create_msi_eq(dev);
 	mlx5st_setup_datapath(dev);
 
+	vfio_pci_msix_enable(device, MSI_VECTOR, 1);
+	device->driver.msi = MSI_VECTOR;
+
 	device->driver.max_memcpy_size = 1ULL << dev->log_max_msg;
 	device->driver.max_memcpy_count = SQ_WQE_CNT - 1;
 
@@ -1733,8 +1886,14 @@ static void mlx5st_remove(struct vfio_pci_device *device)
 {
 	struct mlx5st_device *dev = to_mlx5st(device);
 
+	vfio_pci_msix_disable(device);
 	mlx5st_teardown_datapath(dev);
 
+	if (dev->have_msi_eq) {
+		mlx5st_destroy_msi_eq(dev);
+		dev->have_msi_eq = false;
+	}
+
 	dev_dbg(device, "teardown: destroy_mkey\n");
 	if (dev->mkey_index) {
 		mlx5st_destroy_mkey(dev);
@@ -1765,5 +1924,5 @@ struct vfio_pci_driver_ops mlx5st_ops = {
 	.remove = mlx5st_remove,
 	.memcpy_start = mlx5st_memcpy_start,
 	.memcpy_wait = mlx5st_memcpy_wait,
-	.send_msi = NULL,
+	.send_msi = mlx5st_send_msi,
 };
diff --git a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
index a2506ec8a19523..2c451e411ec13f 100644
--- a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
+++ b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
@@ -80,6 +80,9 @@ struct mlx5st_dbrec {
 #define MLX5_BF_OFFSET 0x800
 #define MLX5_BF_SIZE 0x100
 
+/* CQ doorbell offset within UAR page */
+#define MLX5_CQ_DOORBELL_OFFSET 0x20
+
 /* EQ doorbell offset within UAR page */
 #define MLX5_EQ_DOORBELL_OFFSET 0x40
 
@@ -94,6 +97,9 @@ struct mlx5st_dbrec {
 #define LOG_CQ_SIZE 4
 #define EQ_NENT 64
 #define LOG_EQ_SIZE 6
+#define MSI_EQ_NENT 16
+#define LOG_MSI_EQ_SIZE 4
+#define MSI_VECTOR 0
 
 #define MAX_FW_PAGES 8192
 #define MAX_FW_PAGES_PER_CMD 512
-- 
2.43.0


