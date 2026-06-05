Return-Path: <linux-rdma+bounces-21858-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xOc9IyMHI2oUgwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21858-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:28:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 151E764A286
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:28:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ZpKSUYcY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21858-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21858-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2B8230696E1
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FA72BE03C;
	Fri,  5 Jun 2026 17:21:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4982E1C4E;
	Fri,  5 Jun 2026 17:21:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680076; cv=fail; b=uaJvsnOXB9S0Es16H/wSqUy/hjHHgy2g8/MkxvamDgKZNwrO8Zd/cSGEk+MoqaBL27NXbXTucaqAR/gtlYRFquSzRkYyH4iYxXuR/YnTE/hrZtQG0Yj2gLjra3EjqdHNh1h+idmtjVcFfXGq/m6pK8CcgqI2pD124SyV4EwW91c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680076; c=relaxed/simple;
	bh=Bh/gDaBmcirHMWFfOTHQopmevDjHay2m99KrlyoDp/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EeUvM4jAJpNzn1NNen59WPQy1fEwjWMCr6VD1DL7wB7vK/GAl7/kEJgeUB5+rzVlvGRvDcxAMQVdfH2RkQM9y4XQMm9gLDearTHb12nZRtD19b8tsSQbC+upMfM1+ygXHK834Ayqhctxh4TVhpZAHpw0lTeCN9BwKC29Y++8C4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZpKSUYcY; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bC7YfkrvK/Sw57x/Ve56ZJM53zJQEP0diIY5yhJJQ+sJFBh+HxTlvzORNCV7n6lCash8tHcaRmlB0Utqvay7jjZ+DjTC7qidpwir2vWnmJ3iB337WT1YTm6qk29nCxh+En2c0rNvWD9rMD3AWy3IgnYQMIlQwOLKBSl2VYg8agniRsmHJu5vUAGmnE53f7BapuXcbQJCFTGWXOxWzYAVxIO1mJOPivW4xHNVJyfePAjoSCiB33zN7aSP/CdkgmGYufUwWyQuhzmAJHmtnRhbHiBx3GSNnCNO1r9yrYNbJqYEy259dt1nQ/TV4iRU23Ju8F1+VD+HTZL4LoV+qvcaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9bsiAXvdRM47HUaFH8OKP4Q1N3hR0PbMC/Fh7DEo9A=;
 b=j2AK2+EUW8kqcGIrZ0EsuB6XL6qG0SzaAzRbqKafRQVLsSgPdqL1tyWznTSmVwuMUvbXu+au9rkB2e5EhLScUD59enqvZsB4Bvb0BDplY8W3jLRfij9Ifm5Md+pZMZZMy6CoRZYVTIOWSuhlWm/akCJkZzrksHNtlhIc7XWYBVXFVzEmeFLwLRN7dXH7PSaqmRH2usA8gfmzkfJAxMQ7AhZymtHxzjrRLwh/sacGZQ2xuxATWYFtd2aUSMO4zf8qQlKUTLoiOvz0tDDUq0brNHLgcof/GPhNF7IcZr63pG8iTPOZtEwEAmqD8z+8h1R+ChpESTPJlHtdgt4rPGMOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9bsiAXvdRM47HUaFH8OKP4Q1N3hR0PbMC/Fh7DEo9A=;
 b=ZpKSUYcY6YJJytKo+nto9pgz/yJ4+sCttHyyNzJXMaG4y4mqHN71ofbMb6adxbcyp1RNDU+FaNHw3iIs2Kzvv/IQEdTh6H12DAZA8qdjcj5LMVfjp1Om8LizrPkyFmeYHdxUAv7RLzROqsVJDFWoRM6/mRSVnMNPr5/RtAnVdGhqD98vATmAdHaaZxgCNvHhUDIIe7o67r9JO3PN5qRwuDZ5XWUb0Uf/opUGCXS8j4gHLcywBJ1isLT1HK6oV+a2U6sqcUaqAaDV/uAuiAYVtGHM+DgNUrznOzwdgae6L8tK/33UtPaWsD3tzEcX7ocmswcbb6uux7l5ey3U6Pc47A==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 17:21:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 17:21:12 +0000
Date: Fri, 5 Jun 2026 14:21:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/srp: bound SRP_RSP sense copy by the received
 length
Message-ID: <20260605172111.GA2779759@nvidia.com>
References: <20260602220457.2542840-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602220457.2542840-1-michael.bommarito@gmail.com>
X-ClientProxiedBy: YT4PR01CA0467.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d8f421-658a-400e-1a4e-08dec326d72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11063799006|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Zw9/1+BzetrnMvb8b22CVPuGJeIRAKI4sQgYGjzoQyJe1pBv+jRu58f5yksjzOw4BO6fflUmekfchLkRo7ZApGrC32Xx5mS6Ix0xEUy1ihYJbCIDg4Jro7w3pzmQcQfHZkcFAosDpnJxqB50+5u394csu6tSMnyyvvcY0FM5USuXGayHLJMxm/RZAv8dEUoSLmXRsueG3Rws/OWxYo+tTw6UMBp/kPSKyEN7nQKMY+ribsoyC5sm4Ce4dY0Ubyv6zgba5LTsHoMkRDROjX1Px4B4dUAdD8OmqTHb8jK+EOGqFvzbr9s60dkog0EDhkQN2+iDaOUzGoYuRZuYwp/fsvP8QfRnNdl++/l+AOcq3fmvdwBClvY1f1rfSWjrRGS71VugDEDq33oj4HyDTO8qnLqdfW1qgzrQo7rIVOt1Igli7RGGqDOum3owxsx93OKg9J9mLHmk+y94obVt8AQrp4AkCSwRGtg2mC9RHeLAvqjLDWLRpFgcUAQOraO92XGfLzhfh2ysp94dii3ikmqJJfji8DqjVSPm2ueroqQGKN8Pix1DaQaxHcf7L/mAXr/eTw5y6RiJSDzVK0ik6ff9/xpeKCMpgGg+Cvpwl4tDDrD3H/fiuCyjcxnZjwA9AV36At3LMoVj6Vkt8WyWVNiFT7mqhs3HxQm4RHhKHLFYm0wjL2e1tyy5rNRRD7h21zkC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ujRtbpzG/zMDuUSfmXHolzUXf4lPnx4+Wm1jsWtBcS3VKtF5luQs8/ArzKn4?=
 =?us-ascii?Q?wwl/dLWfOrsh+yRwzjwLzl14rfu0jBRVijP8O5t2cS5fd2r5FG5Ej9gzJuYx?=
 =?us-ascii?Q?VP3OlA9ANKNCRmsKlqbNds4mP3un8x3jtv6sr9meRSA9gAhd0f0zGVNIbmUJ?=
 =?us-ascii?Q?80524oD4TiPEDBz4ZOTPQslrl2mRmczYSjKsyNz4tYWRHxsl4YLbZuDlugcl?=
 =?us-ascii?Q?l5AGM/xXKpDZubJiVGR03oiNEKn4jhXX83oxx3/CjF2neV5b4MEXbdbjD1zY?=
 =?us-ascii?Q?2rvTfJ7lf6xitaQd5UVC13AyfCd7AoYKZ8DQA75Fck8Qe8S4xkvM43/D3YjN?=
 =?us-ascii?Q?Wvr0TaaO3VDOADk++yJhT2LeqaZW/KYrerEGO/lL/AJNbgfzLOFZlhKzTDw0?=
 =?us-ascii?Q?3X+N1+GWnFgrk6UtngTy8rWuNRlt2MPZkDXKoUWxO8/CegGMsoZA75KsRoXT?=
 =?us-ascii?Q?EtWqow08A0V3uecGJ2rJSF1J2C1UEekONO+/yupPSt/tT04s0JXhi82A6AfH?=
 =?us-ascii?Q?2NE9f84GkIlGisXSCU74LABr1lUekeglN9JQ8BnAO5CVgA315PxTmMN8/h/j?=
 =?us-ascii?Q?E8LyvLJMt+txnjy8ZiXvPbNzcGwAnVHIRB2TVRagBM1LIp3q0blRG558DzWK?=
 =?us-ascii?Q?4MwFq0N09lzveFo3RQFKz8hqK0S4xCBCzkiINCiGd+dqvv2EMobpf4s2oe2C?=
 =?us-ascii?Q?brrI76SHfJBleQ1uDQffzEm4SzdJBohBHPrtx1jk9qVVtrFEwESxrRlpLBEp?=
 =?us-ascii?Q?yMB3ok9TSetuqGljUm+4FYQCeIyVmu0jkH87lMdgEdg2DXpTyLIVPG+m17lU?=
 =?us-ascii?Q?STAqKQzj2HSpXQQMiB6JEojw7LL7gW3hSSG9Ixz2mI5gi8JMPNp9rCXZpNQo?=
 =?us-ascii?Q?AjRgcokMF36eTR/TRrn6FNSFq1uAEn4uAtwebym0Z6Z4Dzaape5HutVRUX2b?=
 =?us-ascii?Q?372ifXaRggzH45aV/4YLplKM+pLPOLs3goA+DvBnOnfEM2M+w7FFTOCNJMJJ?=
 =?us-ascii?Q?OYsqnse94NEOY+g/aDt/Xzwl9rs8Vj5PJ7zIh6VYLmNWr44eX9Tq4xoW39SI?=
 =?us-ascii?Q?pfZpTsdm0KPVSqE0h+db+b9qzLTnOsosAxAMajvUQ2A4bzZsUBRc9LKdjrN2?=
 =?us-ascii?Q?z+hkr0TSl1Yy7a7JuMspPlS5DB3akvBec9w61SR9RIe9Yf5C7wwgDBOmrw/6?=
 =?us-ascii?Q?clvd2vM0IqVVj5MmyuXn6Wq/TC8hDpjHJyEkSV4dny1dTpX1XRyF24lae2O/?=
 =?us-ascii?Q?AYxag1mVTaAntNbqRQmub6n9RhacYd+rI7EdvPVzTA8H3DpTBz791UDCt9cw?=
 =?us-ascii?Q?h2eaM8ewJvptyHfAiszkNOlKx5Um5GX7725XxltrA96e56lWa6eM7sZcdFFx?=
 =?us-ascii?Q?hRxeg0DqNPP48ZFcZlPXdDP7wrUt7iyAvYOfFLEi8Hdy9XRIFnVDkbog8G+X?=
 =?us-ascii?Q?5+mGuj9c43JVkTbrzUa7+o9d/4denJmLkHcggs7L3UNxJ9PVe/2R8ytVdAaS?=
 =?us-ascii?Q?uBVNTCg/Gf0J00Av+ARsY9Ee+3/RdbrwizeOLV2rS035ZWyUoBE350a/4DNP?=
 =?us-ascii?Q?n2LJhqam7RmigU7rmTB5LyWmHewOJUTz4xFSZSUc4fn2Vy6pU9Jd/k6eG5xU?=
 =?us-ascii?Q?GJG1HH7kXEHlqm3AC6QiNNt6vjrEoiO9/vcOtZsVPrFHXyxg6p7tPyF3sf/r?=
 =?us-ascii?Q?wmOXQ/i9EqomBw4kq0iHovE6ceyicRSQXDnVM79Gm8BZhYH9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d8f421-658a-400e-1a4e-08dec326d72e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 17:21:12.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLMuxLlM6+qPJia6y+S4k2wtSqfRjYL2rCPEQ2hGTqYqbFav7r0bgQjWpvatsLwH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21858-lists,linux-rdma=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:bvanassche@acm.org,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:mid,Nvidia.com:dkim,acm.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 151E764A286

On Tue, Jun 02, 2026 at 06:04:57PM -0400, Michael Bommarito wrote:
> srp_process_rsp() copies sense data from rsp->data + resp_data_len,
> where resp_data_len is the full 32-bit value supplied by the SRP target
> and is never checked against the number of bytes actually received
> (wc->byte_len). The copy length is bounded to SCSI_SENSE_BUFFERSIZE, so
> at most 96 bytes are copied, but the source offset is not bounded.
> 
> A malicious or compromised SRP target on the InfiniBand/RoCE fabric that
> the initiator has logged into can return an SRP_RSP with
> SRP_RSP_FLAG_SNSVALID set and a large resp_data_len. The receive buffer
> is allocated at the target-chosen max_ti_iu_len, so the source of the
> sense copy lands past the bytes actually received; with resp_data_len
> near 0xFFFFFFFF it is gigabytes past the buffer and the read faults.
> 
> Copy the sense data only if it has not been truncated, that is, only if
> the response header, the response data, and the sense region fit within
> the bytes actually received; otherwise drop the sense and log. The
> in-tree iSER and NVMe-RDMA receive paths already bound their parse by
> wc->byte_len; this brings ib_srp into line with them.
> 
> Fixes: aef9ec39c40c ("IB: Add SCSI RDMA Protocol (SRP) initiator")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Applied with Bart's request

In future please be careful, maybe your AI hallucinated the fixes
line, it should be:

Fixes: aef9ec39c47f ("IB: Add SCSI RDMA Protocol (SRP) initiator")

Jason

