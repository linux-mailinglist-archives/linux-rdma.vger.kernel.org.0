Return-Path: <linux-rdma+bounces-21662-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ptBNHsqCH2qgmgAAu9opvQ
	(envelope-from <linux-rdma+bounces-21662-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 03:26:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1D5633683
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 03:26:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=s2hKYEDi;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21662-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21662-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83921303DD13
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 01:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949EA346AF1;
	Wed,  3 Jun 2026 01:25:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FAB325701
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2026 01:25:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449941; cv=fail; b=UmOxYP7JBVrooOPKbyspg1kR6PaouuvsjMFsHhWC8uKLp45IyU8CQZINzLGJbX8jp8YLaU+DJ/+SbovE96QYVohGCjgUMVr1H5S90dSMPcOH5dVpiRDv4MfGWMU/xC3Fj8i4UtAZLE30BiCSYTsGb8VdOstkVaKZl0btxpjzW48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449941; c=relaxed/simple;
	bh=jHB7CywJ+Oc9CLjKIRkHRQhtEvyquxoOJzU2u4FxSjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PLXWhyx0Ud3TCR/2uldGNWa+COJx9hithcNm5nTERrvzLOMdZ//ZPWOwA7EMxHjZrtunYmHF9BQWgJv8ePUsh+liY4ws6yPU8WDwW7KCaNiNyMR7J4peTRv79N8fv7VWa80ajfUUPCI3UwiL7wSR4R2v6lovKpkvIh+/RxcbwvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s2hKYEDi; arc=fail smtp.client-ip=52.101.201.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zyd9KN1NxWJ9/kObDNKZTj7tlL+ygVwkirrBalIF7bm+z3jXuDYhdYcOSExD7jzJIZtUtWfOR/yURTqKHvhocpvfof8d5hL4tRHjxjdT7NjumTnBxRJL/nGQ9IQi69HMvOs9gurVg0lasLYzYfrE7Mlub0j+t3hw0YAfSY3/8b6V6BdwS1yXfAkDJ6TmRz99FysXI2oA4C+n+F5t/ocCfJvbyqxeH0Bd1eKq8rarrSDbTOeXFYVqVYd0jQxQ0N9GAtxrsRR/nPOjpsRh9nA96Lo/unePKGQcBV0z0EJJqOEn4VadmEMvXFX6JRjIda0u5f0ORY17vb15bfaX2VwYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izaEzzhNK5bEKUI5Co2aD64ojuil2BWEcbqhzi+Lye0=;
 b=L4f7TWd3P26rqwLubkYw+Jm36stjwWCA5aNOQywmMAYN4ROKYLId33rVL3AM6OVeEbSfxdodeNjQ6JUWtpgWTE8xc9oLj0Y1+AfNgtmp1VoKqZSnLzQGsU0HfoP29cSsdH9V7V2JJ4O+hRFoeSl2u8U0pF2j0n7uBXuleliOodw6Md8n0cgXXt+q1/INannqBtnYbJB5zqxpEhmAuIAlbr+pp8h5EyydG8ToOUqSXHY+ODW5qqVLdaRh81Yk5i7B6NJmGiRBbkh0CnlNKlC+llXjrmY5B71WbgIWddB94oyaLvQQOA8PrwK9QEb76oLkujajSHVzUnU5VUChGv/zqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izaEzzhNK5bEKUI5Co2aD64ojuil2BWEcbqhzi+Lye0=;
 b=s2hKYEDiijyy5hhNIF6J3tMNaUX3i8OjvWAGyOviURfo2MhsS4fMs9Ej0lycszDFwoBPwDLGOHFcEzSkL/cU5VjcVXjfeEi0GzHNU8smYb7sLmm3p4WuF+uZ/cIkRDJbyHFo+bB/WyYDB1GiVS9buylUHjkeFx4XYCDdAHTPQmHQykl6YxLbcHhgo4gcvCOm9PKrTd8nd8SIlbAlJ4J/iV1RwN6dbZumLzsERTdUO0WjM+bHHFCYEpR/TT4UFuX9j/Ndgm+LRcnNlr9ivOtdBjInqkMKXMAbbJHSD6JkSc9sKwI+95oShHdB31aVpZ1JIqGJiPCpbaBlUIDYd71/AA==
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 01:25:34 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.21.0071.014; Wed, 3 Jun 2026
 01:25:34 +0000
Date: Tue, 2 Jun 2026 22:25:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/1] RDMA/rxe: Fix Use-After-Free problem in
 rxe_net_del
Message-ID: <20260603012532.GA1188713@nvidia.com>
References: <20260519023541.8594-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519023541.8594-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: BLAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:32b::10) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b43fbd-07e1-445b-5a9c-08dec10f0230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	sHkH9JbiWJTCSeBO2WynEITT+eaU96dQ609ZEhkP0pvw42Wm0K88mivGdpY09AMdMhrYjNDET09mcahNTJqSpYXhC48I58zjkjuDHzpAbzVQsDZ/OgtZqhpbZsnq+omcS70YWM+YugFy2eq54GCEyU6NXs/a5JGiYgwzPgRqs6Rc9XrRG89OulL7GL0OSINutJYfUfoGLHdkeW38l94TkvDh5oYzFnGC+yUeoF9g5RH/swONkEkncFnzbBTgB2kVonar1W0+AitOOpu7WrrAiyCvWNkrjMwKlitJJxyyjBFMP9aMeXUqQOW73vyFdedmhATDSy/opGFeiR+N/vl3weTnTVIgKu5y5ADuOoCOzbFKX8J7eIVB6EhoXYA31r/BTIndQBc/ri2lvBfYODgyJPEs3l4DuVstoHIZtgeGdGUit1r7dFtjWgSpOCpzBB49xQKjM+QR2ZndijgUchCgCZUyBW+yTztu+qyQyndGJVGWQexY4GLjoQmOasGpyP3307JMj8Here781fzrffqhqCUQ5Rv/xamUwjF4uR41zHv5x1Xv7NJD09F78KF+74Wl5wL54mYSPXIf9Sg03imzyGIXKfdOKp36buNNKEBt/UBeh1LvRWdvRydjfNOrX+Qavc0ANidxVqWeMh4EspitHSfQS8ZC8BSN1mpNdeisLG47pInfKpuKiTmOym5uPBcm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qcflP8ZduduhLalpWP5zZukB43vt+IzmC6rlepfsCV/vnR2vq5tWfisib3Ag?=
 =?us-ascii?Q?++M/d+WOt7gDIYrzAks/iyA+8O5N5+zqqd+br8eBmHxzZQsVlpKhFDTlJdE8?=
 =?us-ascii?Q?EzUnHhS8+kI7HfV5O8t12Z9mzmplxMCb9l9U6VaU2nl5jhY/aIs9DOA8cUDm?=
 =?us-ascii?Q?4A+12SQgWZcs8hUoSGoLTCuWdPvXlD4FBVYHFXbsKlcFla/QEmBEteOmFADL?=
 =?us-ascii?Q?QY4li67iZaKRT+4EeIdjYaxk2wUS1s6bO4atmjuDO/MchSNBPOqGKgyihQWT?=
 =?us-ascii?Q?QTtAICanjfv3Ki+v/lW2gDnRtv8axkQ7JmcufiO91tkooeXYWvzfV29x/HgO?=
 =?us-ascii?Q?5uNoWUBQOhaX8sNpWfZuCZdffAirYdKLRXU+vxUOUp+mGJWV/A2lOIcl4SBG?=
 =?us-ascii?Q?/WyTIf40cCnoKfiU+jytC70g64qsXQkrGjO5TDIJLcBIw7IsEfGB2IRo9cRI?=
 =?us-ascii?Q?uroPYB3qU9FqX4RKxX2+tKFpRvoP/c8UITubCVYwiPun59bUIqJBvjtU4sDN?=
 =?us-ascii?Q?dzfrApfu7RFBtpygm2WuHIzsDgeORGuDJRjy9AXPrdAkeNADKJDmTSKnM+7Y?=
 =?us-ascii?Q?8TVlyFAPrL8LnU08F5MWg3u3t5ZxRMhxDkZIJqDZghJOwAPZ2Njh5DLryPIn?=
 =?us-ascii?Q?Gp1DPiZecWxv/r6VVHnZYJfO/ABQY2AGyEKemNH3uDQkpuQOJEDA/maWxlpk?=
 =?us-ascii?Q?xCW0uB1UULVDK4l18T50lIzcbCiElqNF+i1bRzM6UbL4YVda3xMz68pDPcpZ?=
 =?us-ascii?Q?PuuGW5mmPWw01ueKpSqCyy5HLHuGq/zdju3sNHtNIDWMIm9xa5Bi5LKd2UPE?=
 =?us-ascii?Q?s5+6H7RQSNgRqfKWWjjdOBeZx8NkvBqdCoiujig8WY5FcqWEdy85xlN3Oo0W?=
 =?us-ascii?Q?iUsBNZpufhNziMvbAMCohhaBTgr0bgd449C7vFy7uDEeQkFHZ+JgJer4QzfL?=
 =?us-ascii?Q?FooSeBCiauB8vDh/ypb7vqpGrCS/+oWU9s7rH6CORgdmiomD28V3yWD8EG16?=
 =?us-ascii?Q?NfufglTutw4MKxu4hX9biiTgip9YVDTv4A0SyAjdasr4CpkSOoVN8mWYK4+P?=
 =?us-ascii?Q?WKsxarsThUUMQpD7NjEWes3W+uHqCd6O7TvLW1Uj7XyB2pEDSD2aj5LQ6C8S?=
 =?us-ascii?Q?v82fowj2oi3IMjXnsTqEzAH4A2mKx9VbOc3y1WeSfTXCYczP/BTTvffwpxrY?=
 =?us-ascii?Q?GUmIfu6Qb+tt9IZ4VBYWMaDgmASpmFaZczmh651sqXZJWSGg1vRrdGN2towG?=
 =?us-ascii?Q?5wcpcJu3tvO5wTyWwy3+znTMEvs1mZKb7mEcZ8h5NKKEb1vIxrZP1okmPHri?=
 =?us-ascii?Q?jvtI2df1/T8sVbWd+Yf+Ci3yBeQLmXR+tNhbvau+WS017mih7XyJ3y5GapwH?=
 =?us-ascii?Q?JXi5u35bFzGuqMN9ojmRLWBVRLax2rmZdfe6lhJ4f5Vgh6jXlJshrLlO2M6E?=
 =?us-ascii?Q?x6B4LIy1j2bx5OlaGwkQfaaJukE5F5wCzpXXISVrgvxXptUU4q1WhfD57HLc?=
 =?us-ascii?Q?mnf3XATwcqqxVnjaTCcxVpHunxNwAp5sOvAnmAhBvFhd+tOotRHNuQGU9gxZ?=
 =?us-ascii?Q?8yJxrLDpHKgIqB6O96n+QPnV43R7ILHQDBswam7tMXeMmrwisjgt9yfeWwom?=
 =?us-ascii?Q?55QHtTbYmn118ci0po+9lFiOJE3POc93InDNuIDSAu5kdsnO5bhjkZqEBo9g?=
 =?us-ascii?Q?m4Ou+TftmVrW3gXMXQCdGAqJ3omkC809N7fyFSzCDaP87rk2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b43fbd-07e1-445b-5a9c-08dec10f0230
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 01:25:34.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brqXWFxf+InbQqvNoTmbJ4tWEw3bU9aOxU1F6QX3KYTLgl7FsJMoVHZG/F6fce6m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21662-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:zyjzyj2000@gmail.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF1D5633683

On Tue, May 19, 2026 at 04:35:41AM +0200, Zhu Yanjun wrote:

> index 50a2cb5405e2..0bf5b0eabc7b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -135,13 +135,21 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
>  {
>  	struct dst_entry *ndst;
>  	struct flowi6 fl6 = {};
> +	struct sock *sk;
>  
>  	fl6.flowi6_oif = ndev->ifindex;
>  	memcpy(&fl6.saddr, saddr, sizeof(*saddr));
>  	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
>  	fl6.flowi6_proto = IPPROTO_UDP;
>  
> -	ndst = ip6_dst_lookup_flow(net, rxe_ns_pernet_sk6(net), &fl6, NULL);
> +	rxe_ns_lock(net);
> +	sk = rxe_ns_pernet_sk6(net);
> +	if (sk)
> +		sock_hold(sk);
> +	rxe_ns_unlock(net);
> +
> +	ndst = ip6_dst_lookup_flow(net, sk, &fl6, NULL);
> +	sock_put(sk);

Sashiko says this crashes when sk is null, which it can be.

But this really seems weird, the rxe can be in only one namespace, why
not reach the listening sks associated with the ib_dev through
qp->pd->dev and not do net lookups?

I would expect net lookups to only exist in the add/del link paths?

Jason

