Return-Path: <linux-rdma+bounces-22550-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HvQ9N4gbQmpf0QkAu9opvQ
	(envelope-from <linux-rdma+bounces-22550-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 09:15:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 339C86D6DB3
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 09:15:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Dv3LYKJx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22550-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22550-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E003C304972E
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 07:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BF53B8D6D;
	Mon, 29 Jun 2026 07:11:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013043.outbound.protection.outlook.com [40.93.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EC5394780;
	Mon, 29 Jun 2026 07:11:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717089; cv=fail; b=UWwyYbXfzbeAsXS8tOt0IfpG0nRoWffpPBRzOeSdnOCW5d3K4jErUCDkIjkNICswne7CpUW++p4rwvhwHTYI1NA5S+SrTmyjpvAIRbVLNkhxIRv31rV+KDPwEAKom+RFThrcimmpHDvVlO3lagaRcHu0OsjpkU6tALxS2SFvWWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717089; c=relaxed/simple;
	bh=Hb/WyueBHSFZj9sMZ1EmGlKghv5yvbuvrkPUN/1BMsc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XSzBQi2yKq7bL0yjemGbILKRJrzcppwqQ71TqQIS5E42A+TXxqP0ZYpytP8Khr9xEDQ2n6OQ8KMDLkvdgUKfsVfOO4r8P3Xd3rM95+djrCmS/YBcdXVZhUnhT4fh4n+W0TgmvQCnOJpdUofVECcDtUq/e2AQdF9BNGtAtO4FpDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dv3LYKJx; arc=fail smtp.client-ip=40.93.201.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1r75b1QksrsTW0XAjGbHZo5GhVql/sTTLCkLje85wuL3oTct0/5D/RSHN8GKY/EW6EIrjZ36PYQoem9N6nf9XYX0Fu4SouqGhfJCLyB/74Fv3bs8NLNIpbb9CjPnjrJ51H0WxX/h/sOI63ALSsTQuj4RB7bK17rFo1HvE9yHni/EZsXks+n1zrPdT2nD8iiyErIflDMPn2aqZQYZHGsUgdUl0uRG/bwZAxhc+/trJu1MzC/6RBSBJiFf2CkT1aZmyg/lwLYfWRZyjUc80XjDBN7nWS6OL1JQx9ZW9DnwEE54mZa1VSr0hynpfk4CldSpjZ0CurJGoZi057r0GCBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/0/NgjkaMia3QTW+qkNK5ke4L7au4ARbOZ9HYaM0iM=;
 b=MaLuylYm4WOvkGIBCXjCkf777pqO8Vo/YYVIjW0cM9pCcUy7rejawVpYib1xt//r/RhvgcV2eVISVC4wVcai5/Jeo/5FkABlWyQx4StXu7GiQcKIJ87C2lAGeaedhrxJYSp/CxmdssyWU3eRfg77a7f5qgAkI/4/DNnnPXzUwmBondFVrnBeH2SXKurjNOnBEzd41JmM1D64XYniWamMvoGbEdzTsik3STkQZb9mnGiwlm4GapQCyafH4B2vAUwWVyJp8Eiq7uyAtMp+CBINW3HhHvIi7eMZFxosTBm56nE4bOHg05z3HJtAvvqIdQt2+NIBF9hOEdneeKzt9LEDsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/0/NgjkaMia3QTW+qkNK5ke4L7au4ARbOZ9HYaM0iM=;
 b=Dv3LYKJxSWHmQdKPOlzSC0nBNSp0DnIiVc8hVzYwdqL552RAtkNOMIiEfDppAGzaXWZwFeWKyCyO4OUfnHD2hvjSZmgvEMN29T8UypnzeLjuwolJs/lMWRJoczUx1chpO61iOmtbX7igus4iRPKbD0aUkhzFDo+US6+/my7mfVA48K7BHAEycSAP1xNOrEIsQs8mj2WfZbb+pvkdjKUlPjCpi8ZScxK1WI02WC/6ovR9Gp9U2CXwIM5bsqHSTqaWYDAVd4Ak5T1Sn6udNN7bR0aAzD9Pca93ELY30J245gmaRQXd6Csu/sfnwQjXj4M8ZwN0/0oIFf0j5FZUJKzY9Q==
Received: from CY3PR12MB9702.namprd12.prod.outlook.com (2603:10b6:930:103::10)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:11:22 +0000
Received: from CY3PR12MB9702.namprd12.prod.outlook.com
 ([fe80::6998:f12b:ebf5:492d]) by CY3PR12MB9702.namprd12.prod.outlook.com
 ([fe80::6998:f12b:ebf5:492d%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:11:22 +0000
Message-ID: <b4c98f5a-b3a4-4dff-96ea-be2aa33cd1e8@nvidia.com>
Date: Mon, 29 Jun 2026 10:11:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260622184211.2229399-1-zhipingz@meta.com>
 <20260622184211.2229399-5-zhipingz@meta.com>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <20260622184211.2229399-5-zhipingz@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::12) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9702:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3c3426-ce0e-4c3f-93e9-08ded5ad9f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|4143699003|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8wHIJuhyXC5WlScyZcv44USo3R2Ilvj4J7v8xrSGHecGhdrLHClY6lT9cXEQyxOAx12yKif4mr3ZZ1V8Yqv7zObrl2JF2xCxsBjJTngF5pmIvjA+Hgj79RmWW0IjyBztbo0fDf9diScCRlJUsIoF66jq+OC2frjvSaOBUH3LW4ClAmAcZHvCjPjZDuZRtdCMnwU3P926jv6yqJnw0K82ZJCxKYQOeD09yX//bBUrdprjCi7401iHXT8fx5EUCnki+GD5P58VtTKoxtJj4QEsG+SU83Uvc7yToTEDE4Nc0AzWtuOprFXOPkz7N88O7AJ4TPm4M28utHxMdh5LPvs+OmjYWm6avUHKvz6qwaLA4ulZ/Pgta0ETtQ9sc+DRi32BXta4hZqOLYcAqKLn79SBgfBgiThyfrkiBW5LQbFncZh19L/xtKjwq5ycHVNCXRzewdkXxUM1hGFRGpnaMDJlb6M1GtsyfmQHQ5ZcDHXrHcHWhDhmEuH3FJbsGuSuT2prfH6qgK5hWQPW3CwnrOZj1JR2+sWla/eRZiYEvR6T52OsBvdAEHRb4/1/oGz4lUJf83ReyQjNnul2bgvlDt63rEcqAHRY225K2lSYlG75ZTkagTMrlQ103k9n1YqDMYE6ID3duK4qWgrZxTqSRHSUkeB/Aty9PY5sczGQag5INR0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR12MB9702.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(4143699003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlIxaEpUakZOV3BDa3JnMlJ1UlZlOUw3VGRaZnpIWG9lNVVJY0hUWjhtM3hQ?=
 =?utf-8?B?amZtWEpkM1hwSUhqRmdLd1RRdHRraHFGTUNEVmZBdlRUTWZuOUJPdEZKcVU3?=
 =?utf-8?B?MWR6NndzOFpNRmp3bEdLQ2x3aUlOOHhwM295VGdlN2JHYmdqYWk3QWtZSmM4?=
 =?utf-8?B?VFZvOFBMdXpBeGx2ZlVlV3ZSMDBKVk1Ya0lWYS9VazNtanNPVHdGbUI4bUhE?=
 =?utf-8?B?enFGQUVEcFN4QmlUN2grdUg1U1dlbDVrQUZKa2E1MzdhY1ZmZlA4S3JYSFd3?=
 =?utf-8?B?L1FHSWV5eS9uMlNRdnlaQTE0T2w2YUpla1JPZjBBOUhLd282eG9hemY5ank2?=
 =?utf-8?B?V1FWVGlFSWNCVy8wTE5jWURDbUNHdlNZQ2lXTk51NzE0R21RZDhHUzhJRW1s?=
 =?utf-8?B?OERGdjcvWHVMNGR2c0xwdmZmVVcyZEVpdXZuQitwUFVWT2NsN0JDOXFPZjBw?=
 =?utf-8?B?VldMTk55Qk43bm9lNThVZXZCKzZyYUZvOVpUQUJ0VHNwNDQyU0VtRnBJU2M5?=
 =?utf-8?B?Sng3eVF4NStsVGROTkwwcUhOTG5CUHRIRnhVZisvNjFjeUE1V0RVU0tQY3I3?=
 =?utf-8?B?VkxRZzU2Q21GaWVGQkdlR29la3Z1T1MvWWliZ21vN1VwcWNSV2tlRjRqUjBN?=
 =?utf-8?B?ampsQVN2NStCSGg4cjNNUGVmUmh6YmRVdUZNR0M4a241eXFZQkppRzBSQnc4?=
 =?utf-8?B?UE1pSWRzUnhJWXBxcG9ialFvSDVWd2ozUm5na2JDS0p2NFg5bXJDZmhKVFNw?=
 =?utf-8?B?NjRzSHdBbHFJRzM3VUtZZEM0SXdLaTBTK0dZRUlRYlVENEE2UnF4Qlh2amdn?=
 =?utf-8?B?aU1QZ2JHSXp4eVhhbE54ZHFnUXlGckRFVjRFNjluWFJ0QTA0eW5sSmgyOU1r?=
 =?utf-8?B?NEVTNk1EaWtKTnhJRWZ5UkhZWTRqcmN2M1o3eFNmSmlwcTdycDlZbDhDN0l3?=
 =?utf-8?B?d1JyclJCUnpVNk1zRlZRK1MzTzQzUkVCbHdCZGVscUdMRlFtNmV2SGhDTlNl?=
 =?utf-8?B?ZVJ5c2tXQU5weE9PTXEvNythZGRuK1VDVXFrUENBWExmNm94S2wrcW9lYy9k?=
 =?utf-8?B?cXpHQXByZ3FVUVpZK0toa1VUcVVaZ3pibDduODJPZ0xDQ2c2WVBzSFBXMHBn?=
 =?utf-8?B?cEcwdjExZHVVcXJoTnpzaDNYVFJOZm1RLzgwcmo3dyt1ZHpxVjZMU0o3dkxh?=
 =?utf-8?B?ZEZONmdsWitFV2IwYjMrbERNNFl4dUJpV1Rqb0hFT01lVXNQeHpwM0V3RU8v?=
 =?utf-8?B?djVlZzc2RGYvODQvL1FzSjFqNVZEbldNZ2g1NXI0alhYNnF0V0k3OTlmRE5Z?=
 =?utf-8?B?TXhBNGlEakMxUDZjY2s3TjdVa1hPNmgxOVN5bFY3aDhWZFpXclhkMUJiL1FO?=
 =?utf-8?B?Y1h1UnRTTlE5cUVoUU5UU0VoSnlWKzZqN2xkMDNtRlh3RXZTV0hEbm1GVkZT?=
 =?utf-8?B?c2dUdjkzaFVaWVFIWEp6RWVnUmNjZzR5MVd1R2NxTk1WbXF3ZWxjT0ZFSHFm?=
 =?utf-8?B?U0QvSlk2SnVJQWNVbFY2OHlJRVIySFNQWStjVFRvalhZVGRMSnZGZWlWS25B?=
 =?utf-8?B?MWxZa2RNdTczTlNmNjdIUWZKY3o5SGkvYWlMRm9iYXRxekNmUUlSYjBnTVJJ?=
 =?utf-8?B?UlFPZmE2SVdoc1ZLODlKYmR6bmYvTi8rMXliTDVEeitvdEVVMDQ2ZXNKc2E1?=
 =?utf-8?B?Q2libVNCWDVMMVdBSnB3TDNaYlp1aERoNDZwalpzZFBoTEg5aDFOYWxNV090?=
 =?utf-8?B?akZMaVZwd0oyUzRWeGFaZUtwM1RiZml3ZkJIODhZcFgwVHMrM0xGRFhoaFVh?=
 =?utf-8?B?bVNHQzArb1U0V3BQQ1ZxMVMwN1N1VnVlWnIrSlhtR3B0SFA5UjRTSlFRYzJz?=
 =?utf-8?B?YXpzTWdVL1lKczdvbWFiTkRZU3B1ZGh3WVR2MGRhd3I3M3pZL2lwVmRIRXEw?=
 =?utf-8?B?U2xGSnphcmczcjR6K1YreUx3MHVYQ0swa0cxNC9hY2VIMHl6Q1hlZ0Y2amNR?=
 =?utf-8?B?SUlPSTVuQW51Nyt4NDlFYWhESitVSHhYU1loWWRGV21VNzUvNHdLL09DUlIw?=
 =?utf-8?B?SldtR1RZSll5aEF5cnJXdUNrTXdramVicFJhUzZ3dTRmTmRxWmlsVUgwSkov?=
 =?utf-8?B?NXF6c3RvWmJYd2hxbHArc1VxaWtkd1RKYjNNVnI4Mjdmdm1pZVFNUDVxZnkx?=
 =?utf-8?B?ZTlkRmVWYk85TjZjRG9MZG9kODBuQnFsN2JTOWlqb2gzU1FKbEVGN3NVakZx?=
 =?utf-8?B?K1RpNHFjbTJRa0dTNmJoSHl1TVJxbnl0SmlBZEZxckRyanRQa3o4L2ZJNnZm?=
 =?utf-8?B?NkVINmZ2Skg5UEJhMVdob2M3STZZbDVTVGYzYVo5QmdKa2ZUd3lTQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3c3426-ce0e-4c3f-93e9-08ded5ad9f6b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:11:22.5060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cNMLVqpOzblMyKu05JbDrRDkSUaAJCaV+BATtV6LOx17BXfLKcmYfj0UzLMRFMhi7XHgIRRrAHM5R+4gf2sqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22550-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:alex@shazbot.org,m:bhelgaas@google.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,meta.com:email,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 339C86D6DB3


On 6/22/2026 9:41 PM, Zhiping Zhang wrote:
> External email: Use caution opening links or attachments
>
>
> Peer-to-peer DMA between a mlx5 NIC and a foreign PCIe endpoint
> (typically a GPU or a vfio-pci passthrough device) traverses the host
> PCIe fabric. The endpoint exporting the dma-buf knows which PCIe TLP
> Processing Hint (TPH) Steering Tag yields the best placement for the
> traffic it will sink: per-endpoint hint selection lets the root complex
> or switch direct DMA to a specific cache slice / NUMA node, cutting
> cross-socket snoop traffic and DRAM pressure under sustained p2p
> workloads.
>
> Until now the mlx5 importer had no way to learn the exporter's chosen
> ST tag, so dma-buf MRs were registered without TPH and ran with the
> default (no-hint) routing. With dma_buf_get_pci_tph() in place this
> patch wires up mlx5_ib to query that metadata at MR registration time
> for p2p access and use it to program requester-side TPH on the outbound
> mkey. If the exporter has no metadata, fall back to the existing
> no-TPH path so behavior for non-TPH-aware exporters is unchanged.
>
> Use mlx5_st_alloc_index_by_tag() to translate exporter-provided
> steering tags into local ST entries when table mode is active, and add
> mlx5_st_get_index() for DMAH-backed flows that already carry an ST
> index.
>
> For TPH-backed FRMRs, keep the extra ST-table reference tied to MR
> lifetime rather than pooled mkey lifetime. Acquire the ref before MR
> creation and release it again when the MR is returned to the pool or
> the backing mkey is destroyed, while leaving the generic FRMR pool
> core unchanged.
>
> Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
> modular mlx5_ib builds link cleanly.
>
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>   drivers/infiniband/hw/mlx5/main.c             |   1 +
>   drivers/infiniband/hw/mlx5/mr.c               | 103 +++++++++++++++++-
>   .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 +++++++--
>   include/linux/mlx5/driver.h                   |  13 ++
>   4 files changed, 157 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 02809114fc79..a2b497f6b16b 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -60,6 +60,7 @@
>   MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
>   MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) IB driver");
>   MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_IMPORT_NS("DMA_BUF");
>
>   struct mlx5_ib_event_work {
>          struct work_struct      work;
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index e6b74955d95d..7aced3f55456 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -39,6 +39,7 @@
>   #include <linux/delay.h>
>   #include <linux/dma-buf.h>
>   #include <linux/dma-resv.h>
> +#include <linux/pci-tph.h>
>   #include <rdma/frmr_pools.h>
>   #include <rdma/ib_umem_odp.h>
>   #include "dm.h"
> @@ -167,6 +168,32 @@ static int get_unchangeable_access_flags(struct mlx5_ib_dev *dev,
>   #define MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK GENMASK_ULL(23, 16)
>   #define MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK GENMASK_ULL(15, 0)
>
> +static int mlx5_ib_get_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
> +                                         u16 st_index)
> +{
> +       if (st_index == MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> +               return 0;
> +
> +       return mlx5_st_get_index(dev->mdev, st_index);
> +}
> +
> +static void mlx5_ib_put_st_index_ref(struct mlx5_ib_dev *dev, u16 st_index)
> +{
> +       if (st_index == MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> +               return;
> +
> +       mlx5_st_dealloc_index(dev->mdev, st_index);
> +}
> +
> +static void mlx5_ib_put_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
> +                                          u64 kernel_vendor_key)
> +{
> +       u16 st_index = FIELD_GET(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK,
> +                                kernel_vendor_key);
> +
> +       mlx5_ib_put_st_index_ref(dev, st_index);
> +}
> +

Please remove the _frmr_ from the functions naming.
This is now unrelated to the frmr and is strictly tight to MRs.

....

> @@ -335,6 +364,7 @@ static int mlx5r_build_frmr_key(struct ib_device *device,
>                  get_unchangeable_access_flags(dev, in->access_flags);
>          out->vendor_key = in->vendor_key;
>          out->num_dma_blocks = in->num_dma_blocks;
> +       out->kernel_vendor_key = in->kernel_vendor_key;

This path is used to translate an frmr key passed from user-space to the 
right values, enforced and masked by the drivers.
kernel_vendor_key is not allowed in this path as user-space is not 
allowed to control those.
Please drop this line.

Thanks,
Michael



