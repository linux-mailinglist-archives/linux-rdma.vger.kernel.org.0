Return-Path: <linux-rdma+bounces-22288-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C+pnFvKeMWrcoQUAu9opvQ
	(envelope-from <linux-rdma+bounces-22288-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 21:07:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2630694C2E
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 21:07:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=lLxAb94o;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22288-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22288-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3865630377AC
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DD53DE425;
	Tue, 16 Jun 2026 19:07:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1158C318EDA;
	Tue, 16 Jun 2026 19:07:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636845; cv=fail; b=AOh4dadC6m2kg/Or64mjRoH7fSvbr16Ee2wy6atgKpllA8xmAX2XkddcprWezKCtlGNlFBACdam1bHmGvBItoeRcJmEc3uLEZoYeYkapwWrLVlXqoZBmOC3q828RlXSLbH7FUMXS+Q9zvYe7y7IXvx0cmfNlKW7Da3lVOl7KLT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636845; c=relaxed/simple;
	bh=Ht0c5wzMNQ1I05js+7k/8fnRA0/vPRVGrsd0a3kJW3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aBAs+ELEnWP398Z7uI/Z+qDy3GQp9zvWzYCP4uw6MAZIyxaeUD5p6fZvYbhLJBlepH3awbhm4+Az9guDo+MREfZaX2gf58NhgvcJCqMToCTBGleGlpkaV3F3lYOkV5mQ/92K5A2aF4Vxmtw47R/zTYzC00jCy6n6TaGFAeFfW/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lLxAb94o; arc=fail smtp.client-ip=52.101.48.71
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGk3zuL4lw2Rwf7iCnvlRfQpW4CrT6CVtV8XkFxv2DHQvdjy94xZLxYjPGwCX3XAbqfS3dKusJhd458hf6S98UavwPqvIFuR4eWjlLRPM5qNw2rr2vhKI0OXqi5L4MaOtyyV+ldBDXt79cMUKjFLpuILEcIoefH2g5vxAMiYqDZi7XKw92510P8BmCs3E4uwu70lO6SLYPMh4VPgpjoaicKfS8IO0n/VcA6R8LIySb4swxncbA/PLfBfP2zQ+NY3Q1yqt/d+djcO5Z+RD/+97K1SkYoGC6DBm/SRotMBLlj9GPF7t8yiuCm8Q18EbRcQzE5j0laVN4Llo6KKNlwF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6q7oRLOmMmVIuKFuP0SGu/L24Bss80w8q8ZnMxOJ08=;
 b=Qu+KgSbTeA44uyFgjDWPD7S+TZEy7AYcc537sD49O8zWnnCx0HC1/NP+By8d5YgIcpuJL8q7O3j1DxIZws/HivxSSUKPdDT6y521fvl8+ZGtJqh0U+EXCwIuZeLbj+fgOOJYeDrTaUcjO7XLrlLeCjyEsBcHAcSCD5sUBwDPM7X6q+bj8dgkkqtwlWtCRKd9Yk0rN7V+lXROUC54u7UY/B9odwBNzFb6xqN1BZWPSYaA2bvALz8qT+Zj5S6RUfmaA2GNcZJ/tct70Dh9DXWPfA/tywy80QYXucYT7xL6LVTzulOYf3IejQo+7hcGkbLMU1TV2BtKl8fq2oWzRCcV3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6q7oRLOmMmVIuKFuP0SGu/L24Bss80w8q8ZnMxOJ08=;
 b=lLxAb94ogGQCU24i0O0AA5lmiaED13gMc7f+hcOmTKQORLubMzWQGnNMdtgQ4ZNTDdJ/gUDb7+N+lrjksCGgQ/bto+BVQq1MFvPlaS3ML+5vvcpYGDZeteB+RTiUcFHOnBzscKE/vG2l8ZQCrT6NEWRe0YRrmtcoUWtWyEqXC1KugwDBbBJKKLy+p+TDMfPubfjpVxNDM7fNB8dEbXjTjFbncirGoJJCqvsqAIPATTPGpruXRZyomR/C8gIvqKqGJJc/x147aKxDMNmtTQd11+Pc74WijR/laYJNXjbpa8iyxH4Pssd+xYfOlLRMPQcUhrmFZap2gc8nGnRKMb0VnQ==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 16 Jun 2026 19:07:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 19:07:19 +0000
Date: Tue, 16 Jun 2026 16:07:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhenhao Wan <whi4ed0g@gmail.com>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Leon Romanovsky <leon@kernel.org>,
	Danil Kipnis <danil.kipnis@cloud.ionos.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/rtrs-srv: Bound RDMA-Write length to chunk size in
 rdma_write_sg
Message-ID: <20260616190718.GA3986358@nvidia.com>
References: <20260612-master-v1-1-70cde5c6fdc9@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-master-v1-1-70cde5c6fdc9@gmail.com>
X-ClientProxiedBy: BN0PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:408:e7::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 5666d81b-9244-4f2d-5737-08decbda7cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|56012099006|11063799006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xPWmxpI5srT6sQ2AJxljI2NA/cQISB67CoFUQjumirvEoWhysI+V65wfBOJ0H7cO2PjU8cpTf/gOiHGzLhy51dpUTmoWi8uQdw24xdJuZO0fU8lt10tf/agzC9Y7gYsd+3vcS+6XF72zCG6XZ4gkWcXxFPycCEyQUyfBq7o2nuPcyxq14ATxd4FN8ca0DTN2LaPzOZoFKvKr+gIymO80VBdGxCznFZzAHeOZCwJDPtX1yMV0m2zfLyZeaILHNz28faV2gnvjvj3om68h2CX1mNO+8tiGgZGiY59E8KzhSEea/oMz18DuBSOHuZy6XCT2RPIpUGD8Ra58juJBscB5zEFoetTf04lh8uuUS1V9Q2RRekQbNjoZJwGXpp6O11Pftss3xMuMVmwz3uctmAy/ZYevXTRslZSMf+N0lxS8mUd/33IR233e5Z3dezNW4s6gEi95bkKuRq4nOsRI0aJUnNe9ncVrojRG724JM90kwSvdnDsN0IA7iqbd6ZOXH3+l7oHrGxwdxUP3/91Cihq3V6FTmdcMkcGaj6mtNo1U/l4FDeghqEgkduLkDqf3JLmWXZvRwdMQwJpbqU1ikwwzQYojS0FPPM9rvF6dNTwsicQoKvlPDqfPr5iA4uDyVSpj2Zgs7IjIrBJK+j1sg8raNb+wy+zHgLBqBhtgtp0e3e6XydwUOQzpqKnubEMoFf9o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bAyzyGbqHLzwdvFlJhCZQBneaeRvA6MWcu+KBFt9dnkZRrDiWg/zUKrgFb8j?=
 =?us-ascii?Q?vjk1bq9ORNp4EdDjPoGoRDbE2yagbuRJfAFkor4lU1g6eYXk5favvDis0HBj?=
 =?us-ascii?Q?HuaCXTWsT56Xavzuy8yERdAk7SR6UnEOILCXSV27X+c9Qe6MgMK980K3363a?=
 =?us-ascii?Q?UssKs915dbhiNH8iwCp7sGIA4mvHMIa6gGGziwCPrMbqPdQJ14L8UX3DONb4?=
 =?us-ascii?Q?15jEA1SHMl5UwgttA6060MhUSJug++63RdgHh9qMH7c9r0SxM2Sji44RONEY?=
 =?us-ascii?Q?bTBHygTEbMo4W7nyHlUsIrwOvkeBGwHnGwRbn3pAq7mqaSa4PRbkxBlkGeJr?=
 =?us-ascii?Q?TFq44KdoGNvJdGNEeUMb24zbDqL7awmUVkVop7eoWgy3xeEZPYgQ6nlPwdPl?=
 =?us-ascii?Q?SStYTN8V1tuh1NYafhpfoUxXoODfmslyK2Jhcukx/nM8GPpTmIln3JWbKzre?=
 =?us-ascii?Q?GatfDP0sWE/Ll3plkKo74cL8SGGz2iO6m99msbAenZu27A125rzNZ55mvnqc?=
 =?us-ascii?Q?JALq2eO/62NZPbNlLgh0jpP1Vdkvz4ONouo6gJBe0xo95ovOeAQsEmNIJumH?=
 =?us-ascii?Q?GVEJvKwiDTbRlbOXTPyCGZqvO2wdyGdYcGX/GbQ9wPars3uiv+szq7cMC1tB?=
 =?us-ascii?Q?bxuqa1uZZCiOHz89SvQ2fXq0GkQiFfopJKuiS3dCd+I5zqhAkiAixOIYeGZt?=
 =?us-ascii?Q?EemAXxF8El2DbkXzmozEvQclJRRKk//y9z/at3wSCrE4yPBeH1ILe5jm2jZv?=
 =?us-ascii?Q?yySKO8Q9TI73wCb16TsbemqsLz3Ru4E6CIs56wsLP9j2N0iG7lQl8FgEgoJy?=
 =?us-ascii?Q?kOYbzWlYHOXy7dWfGka4VgtoZFge0xQeOgDPHja7+pCQqBz610WrFw6322+A?=
 =?us-ascii?Q?5HTNA2xLuokiTBAgx/9Rg+gQ6HFI7AshQf9Sh8qzCkLm+GcreAE4fNHQesTz?=
 =?us-ascii?Q?XWJc+JAyOkI3vWhZxYb6vk5lpK+JT8g9XHYL1/CNLh9WfBDvm9rcSjDL8+Bx?=
 =?us-ascii?Q?ANA7OsyYBrs1Va8/NOa2eCwiIPB7VIfdqU3TJpxeSLsc2+UqQsvUWRUaJ7gq?=
 =?us-ascii?Q?zHjuFCMFCXz2tji6OUR35jAhKp3bUSVwyKUzsAZr+PUluPiry3i1URbhtuUE?=
 =?us-ascii?Q?2ZLuw9M85RzO+EzRJHcI9k78pfBoxG7nb9dan9Aus05DbYPigIt5aVJTjHWO?=
 =?us-ascii?Q?aIcibuLuS9isPxbwQzolJKC9cQ9vFulD90Rck4bjkqpF/t+1UaTo3RK3AtZa?=
 =?us-ascii?Q?AmowDFyqsfC/JYMriWNLPxTer4CTHukLo2cRIHcYAtjXuKnAXd4RZFJ73IFi?=
 =?us-ascii?Q?2yA6pqGyiVPtnn53dPZBVNfWwHqsuDtlyl0pgEksOXvD351pRq7JjnFRcM97?=
 =?us-ascii?Q?gnPbwwF1Owjs3Brwnt/d8lBSOOkSFgOyCFuRNb/LNnZGuXh082vjoLhKLfsd?=
 =?us-ascii?Q?Z0b6Qt9BIF72fQDBlEDi74H1Qz1haxDGoT7XFVbqlqfzxqbv+dyNEhyG3j0B?=
 =?us-ascii?Q?WBwgS/VebytnR4aNyjLz7YZVnnpLUNyPHQbl6n5UU4+ooyNQBBjPBDo5Atuq?=
 =?us-ascii?Q?NUjALQHoiiC0PcNitym8PPTqw5nq3dVss53JSjY68/3LnqequYQs9MtQQGn9?=
 =?us-ascii?Q?Z6vynw+WJcU9hc9w8kqAeEEkZNxwHqDZWNGl7JZFPEvNeV/vPtfUkR1ddFaH?=
 =?us-ascii?Q?7EKpaBrCGm0UKwcRnuabvDmaq4/pFHTmD93Sl3fsHfjvDcGI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5666d81b-9244-4f2d-5737-08decbda7cc9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 19:07:19.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5WJzSHzqqNdET7fnLgnh9Q8avKsXy0Zbnozf1CqdsbzRFPC0VL065HjViw1rwDE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ionos.com,kernel.org,cloud.ionos.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-22288-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:whi4ed0g@gmail.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:leon@kernel.org,m:danil.kipnis@cloud.ionos.com,m:jinpu.wang@cloud.ionos.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,vger.kernel.org:from_smtp,ionos.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2630694C2E

On Fri, Jun 12, 2026 at 01:15:54AM +0800, Zhenhao Wan wrote:
> When the server answers an RTRS READ, rdma_write_sg() builds the source
> scatter/gather entry for the IB_WR_RDMA_WRITE that returns data to the
> peer. Its length is taken directly from the wire descriptor:
> 
>   plist->length = le32_to_cpu(id->rd_msg->desc[0].len);
> 
> rd_msg points into the chunk buffer that the remote peer filled via
> RDMA-WRITE-WITH-IMM (rtrs_srv_rdma_done() -> process_io_req() ->
> process_read()), so desc[0].len is attacker-controlled and, before this
> change, was only rejected when zero. The source address is the fixed
> chunk start (dma_addr[msg_id]) and the source lkey is the PD-wide
> local_dma_lkey, which is not tied to the chunk's MR mapping, so the verbs
> layer does not constrain the transfer length to max_chunk_size. msg_id
> and off are bounded against queue_depth and max_chunk_size in
> rtrs_srv_rdma_done(), but desc[0].len is a separate field that was not
> checked against the chunk size.
> 
> A peer that advertises desc[0].len larger than max_chunk_size can make
> the posted RDMA write read past the chunk's mapped region. The resulting
> behaviour depends on the IOMMU configuration: with no IOMMU or in
> passthrough mode the read may extend into memory adjacent to the chunk
> and be returned to the peer, which can disclose host memory; with a
> translating IOMMU the out-of-range access is expected to fault and abort
> the connection. In either case the transfer exceeds what the protocol
> permits and is driven by a remote peer.
> 
> Reject a descriptor length above max_chunk_size, mirroring the existing
> off >= max_chunk_size bound in rtrs_srv_rdma_done(). Legitimate clients
> do not exceed it: the client sets desc[0].len to its MR length, which is
> capped at the negotiated max_io_size (max_chunk_size - MAX_HDR_SIZE).
> 
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

