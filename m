Return-Path: <linux-rdma+bounces-20509-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA72IyJ2A2pY6AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20509-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:49:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBC95281EB
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA88330836A4
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2693137C93E;
	Tue, 12 May 2026 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qjqhUx5j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A673655D0
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609893; cv=fail; b=d1HGAlc2+Jw63c26bmkU8E5LJdcnEHbkXBCdgA8/s3mrOjyP7NtnwQAiwlLlAATWsj7+mK430HFUV+Z53jA1F2PpTXX4KusPmIXKI7N4zpLEXvDm7bFqyFi4UTN+ZAQsCOfFvuAMew2oViIjvxiaJHmBsaFduosHjE/M5szwbBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609893; c=relaxed/simple;
	bh=jTkIjEGQBMM+wMPVTwrFwcvCDOUsXBab0OzL3z9F23c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jkzAxi472j8roYNAzyNjDAnLd0H652FufUQiGFnnTi4SSqw34uihnH0OFOItL7oUZvMD0WLCE3SsMnm9GiO/LO+ec5YEnxu5vrzMxPU3VC+fIQL315L6sNq8NA6BKEeQQMUIsnBu0g6OjviiVOm6nxskdmiWV4d2yQ/DYFRwWac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qjqhUx5j; arc=fail smtp.client-ip=40.93.196.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnYxAF5uBCMq+Gmj2iy520HWmGA5SvexZkzU68I1pn3UL2s/3djWwaO9Mb0rq4biigitUpdxJN2zd0asYGOq+wAdFn70BdSSn1VMV9Soeh5kOFHUvQVnVcr0p5eZTTIJS4Dh1wS6KKfLXQF4sgCNTWc9TTHtQJYsJOJ8pzUjOnI5SqdHFmQHsBT1bb4sQq/oGYWsnpj9AB5P03sg0RdXQVNgUlI2rqqd4kGLzC9FOff369vomWcbkWD95N3BlV4nRKzlS8bAHcdU68sBX5pWR7UE3RRjmGb3JifT0HiUyRPxhv57Vg1tsc241NL9wbjPh/RsKT0pOqoT468ar7t88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2AjKfUCxSNObgIkneoThILwpnMYLu0iSvW7v+kBVPY=;
 b=VbmGgUTq+4/wAHC0/2apIMEaZdERl+23zCkwje++h5Ad6ss/2jrmC/P9wopdGAOUO0nVJXb7/zxBPfuyKpCpRIRjcwwTP+bniGaDUm0XPULYo0URSnZsKWzbez/qMFEtVBFj9GQJOra9w1nduE+wxFl/V4XcvS4i7oudmxnU2Z+5jtrKqAFIWzsDFHGL2IGG/sUqDdzWd7Y1SVbv/1RvzGtaIjEXrHFbgsdIkeSYQsb/XX9tOCqbctWLqQGkUHpcG/RuL5Sqs4Ei1J1+Ut6AgkIB/HXKXGUKHXl9PWtJmO/LlUY9nQl+j6yeb3Cx3JJ7aD62AmR2FVzIzS49qJ26XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2AjKfUCxSNObgIkneoThILwpnMYLu0iSvW7v+kBVPY=;
 b=qjqhUx5jnJGeJP3SslRNCc6gIxeVbz6yDUsxM+TJhRfUJ3AKJ2hDs6GgnE1/hwL2ZlGVpr6YVtfg2LXkg3WIjZTHM8JbsVMFmugE4M+Y2+2z4CM1YsvtUtQ5y/hmz37d+0ZXvRZW1atWxoTActRJeTAqc6UZSDfORb6Xxyt2Snf5BNiLsCIMqWVErQBT5FnS3eoEr+SQwF80zkcUhj0+ASz1WhrYKYhZ2TWKfABPDwSydUi3JV9ZiNzCwSHevLJGOH9/Luo7Sz1XDQnBnCADwqwnmT5yDPPywANS6BTj3h4NvkH3ESkcmABAvI3VUY6GXHxqzXF+VezRcM2zGH8vKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by MW9PR12MB999207.namprd12.prod.outlook.com (2603:10b6:303:301::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 12 May
 2026 18:18:09 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 18:18:08 +0000
Date: Tue, 12 May 2026 15:18:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v3 08/17] RDMA/efa: Use ib_umem_get_cq_buf()
 for user CQ buffer
Message-ID: <20260512181806.GA173952@nvidia.com>
References: <20260504135731.2345383-1-jiri@resnulli.us>
 <20260504135731.2345383-9-jiri@resnulli.us>
 <aftHa2trKKlO2c3v@ziepe.ca>
 <aftP2M52w-9k7ck9@FV6GYCPJ69>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aftP2M52w-9k7ck9@FV6GYCPJ69>
X-ClientProxiedBy: MN2PR15CA0045.namprd15.prod.outlook.com
 (2603:10b6:208:237::14) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|MW9PR12MB999207:EE_
X-MS-Office365-Filtering-Correlation-Id: d13b3170-76b5-4861-6cb7-08deb052d165
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	HpoCQ1ie17OqjW+ROnGBrTWIvvLMNZCw4meUqwRMsrAs+iH9M7C4mV33xw7qDWUvYGeY/Xtbi+S/H3zG9z9c9PXN/jujgN/yDJ8frxDHFRbL9sc6HDXexDiWYBlOKk3z3v7h8a7iW1XTdzB8g6dVFh34ZQ50TBa8Yn/0pz9wkoavFavhpB+6hHHeD6mVRsbOnZPXok2Z95m/ZDxXtrCg1RuMcKdD3JoVy6cuiI3PfehnLjeSYtxp/zForeoz7FZFhlFb0Su80CaclQwHfvHmRTjcEdeR9Egklcsu1wyUtZK28oeI0oZHfMMvu5Y4FbqJRMIPNtCdkjIUTs9Ifr+i94WPjMW9rrfcfeiGl+6Qw+X5lzuRBsbO7MgDUon25kxcZaCBntvLsxBL5dvTRzVopdHFH0wW+FPorauLv5aaFK18ULPveslZBEd9Rc9biRbDc2qgikIFVOlXjtnXM67QdVxLPeR+oA+cyY5AgGS30/n/jZ+QUivmHqnnc8fPI/xxR6vOKaOkHdJ4jOVl36fEHACF59N0MsdkS1hvmoPfBHmU9QDeFOTWXe6vqYGZL6ruP6yDJzxH6hPVN9JHZe7NDQiSXoKeb2TErZl/6/U75V7TqpGFFMIR6JO54OzVHjSIvD8F1oSF6EEF9G+jWu+TfTY9pu4uHYJd661n/B9/Sss/a8BjlP8Dcx126EV0L2FL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c5G0neBFb9cyuuxUFjucDBBP1Fj7XK5BmxZSiT+AkWwq4qhO9MEFl+nQBsj9?=
 =?us-ascii?Q?TNOiMrR8+/Pqb8fvxWmYFDd/duMyZUNGPtNDxeMI9tF0cNL5sKIZ6YZuxv3X?=
 =?us-ascii?Q?BpCQWCq0i0tFU3WoJYk/iDFsyOxQw1il7nmoJ7cgKn7ZKDmF0Od1ZocpKKtZ?=
 =?us-ascii?Q?xydbAoEecAzztbpARevdnWy4HZkrYY/cIQ7ii440fwEbO0rGknh7c9bwBAOU?=
 =?us-ascii?Q?Woj91dePv7lvENSlE3qExJhUeirqdPWHqsPMlqrC/GjVsrGKg+0KMNSuEOFi?=
 =?us-ascii?Q?ziLugFGZDpUPrcg8oyPWzBxbTWY4kc2pYQzr3M/m8lI/NCdYKdbySBus/SOZ?=
 =?us-ascii?Q?Rcc3GbqTSh8Q9R32Xre/qaO6lUgiR6K2m8IxQUgfe/w5+Kyz1f3vuJ6ydpXV?=
 =?us-ascii?Q?p+B7snjd61GcuqO+p6aZ/++WGXiZ02+F8D19rUvtZ4ffqliV16ALISZNL3Ax?=
 =?us-ascii?Q?fMTpNsbyxZvm9wg1UXyZXp9sKJsK/laZo77XDqxXbosEL/KYXsNwN6eOail3?=
 =?us-ascii?Q?MmRhBN3naM6RLIMETrXMXWqySrbeH9tll2gZajgyer/raiafRI9bX1G+K8uj?=
 =?us-ascii?Q?yK05H2jB7ENLnzZPXb6cWEbMFZtmvr5n7ccFc4sbexTX/7JjbSBQ1vdJkF3F?=
 =?us-ascii?Q?Tni/U6AlI04SZdSUtyffuKrb7NY+m4d5ZmSbHzYgYGNHHaRd1UsEpRt3AWza?=
 =?us-ascii?Q?MF43YHfQvNVr6j/c9j6pmLmalYOUMu3tIlYwmUrPRPI9cc3EIJzJPG17+m1a?=
 =?us-ascii?Q?m+42GRZ/acAfTB0MJ6q934MSW3vSHr+wYsADWWX3wNGssqxUb4AD+JG6ubKt?=
 =?us-ascii?Q?aABiHnEuV7v3QReOmxyiLxmWV5IAiYMO/YHkkTiHs/GPyElai1DAYL+0vMWT?=
 =?us-ascii?Q?Gjbk2kD3ZRGcx3vx/1tzI7MSbyPsqUmAzRx7pFKfmE41fuLFvZzXnwPgraqb?=
 =?us-ascii?Q?zdlmebCeTGbAxZicEoOyNPKwIT5eSMXfEVpotHQ2MGSVIx0MGqmjfMRBowyW?=
 =?us-ascii?Q?HFnS7uubdmCpPcsVihSzx7pZh6Kdju4u3BAgqkEd84jHK9+nxixLBFudfioz?=
 =?us-ascii?Q?scyUEFCXVZD76KhtUoUqLsZLuvO3RuQY4chMtnoJW+gl9fbv2D5SP8yaYqj1?=
 =?us-ascii?Q?CcYPH/UaTEdDUNNUdqUiBbvjWi4RGcT+VPXQS/VrlW+nlWt2kxN7N8MrBXQe?=
 =?us-ascii?Q?f2unDcwh2kwnQshWOWhwMR0f7SuqF+bgldTqpzDbPPv3YPBUREf5U9CWhYo4?=
 =?us-ascii?Q?tmRbE6PjFRuQ0xd0m1LF2GS7k3Q/2os5Jrkl7D9aC7VKGm0mQQEUguehQzux?=
 =?us-ascii?Q?bIjHUFxjHfd9DOZx9lZOkUNpe36xLPgSp34U6JdSw1FGNTHX8VYO40pbnEnQ?=
 =?us-ascii?Q?z/LKZNx0TaUu3nMogXqkPodSDwgSclRIwnBIxGa036jfjQoH0xxxKtpmmX29?=
 =?us-ascii?Q?LtFqsbAkyOmSX/Xn3V9FA1J+Zdz0uOzDL86LBdkUIkaaoUsH4yYOoIYdBAZe?=
 =?us-ascii?Q?ZBz3H0ogt28hsdiVofK/tYiZayQrw/ySTu3SKbbjqrS+TJxoH1ELACIait7E?=
 =?us-ascii?Q?4u69I632OD7iU5MxSxfBJvwxIIUZWh448GCPFDoovQF6MEqaQA2nM/GC5LXR?=
 =?us-ascii?Q?IAyE7Vti1anYgwIXaRxZrOo6FHGlVcH5S4wh7cwkdoYXiInHffL0956snQNQ?=
 =?us-ascii?Q?6A71VNUBLjD2YKnba73rrHqVnUe9jUbkI0Y+U6Qa7boIMmoz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13b3170-76b5-4861-6cb7-08deb052d165
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 18:18:08.5488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeD0GS3q8LsI3mjvtxbj+Obb6CdGwzFq+mrv7zT6YgdChgcZx1LTwt1Ye1h1tObE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999207
X-Rspamd-Queue-Id: DCBC95281EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20509-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,ziepe.ca:email,nvidia.com:mid]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 04:32:29PM +0200, Jiri Pirko wrote:
> Wed, May 06, 2026 at 03:51:39PM +0200, jgg@ziepe.ca wrote:
> >On Mon, May 04, 2026 at 03:57:22PM +0200, Jiri Pirko wrote:
> >
> >> @@ -1172,26 +1174,29 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> >>  	cq->ucontext = ucontext;
> >>  	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
> >>  
> >> -	if (ibcq->umem) {
> >> -		if (ibcq->umem->length < cq->size) {
> >> -			ibdev_dbg(&dev->ibdev, "External memory too small\n");
> >> -			err = -EINVAL;
> >> -			goto err_out;
> >> -		}
> >> +	umem = ib_umem_get_cq_buf(ibcq->device, udata, cq->size,
> >> +				  IB_ACCESS_LOCAL_WRITE);
> >> +	if (IS_ERR(umem)) {
> >> +		err = PTR_ERR(umem);
> >> +		goto err_out;
> >> +	}
> >> +
> >> +	cq->umem = umem;
> >>  
> >> -		if (!ib_umem_is_contiguous(ibcq->umem)) {
> >> +	if (umem) {
> >> +		if (!ib_umem_is_contiguous(umem)) {
> >
> >This is a little funny, I think umem should not be NULL?
> 
> Yes it is null when there are no CQ umem attrs present. That is
> perfectly fine flow.

Oh, it sets up a kernel created page, how unusual.

> I was thinking about the ib_umem_get() return value scheme and went back
> and forth multiple times, I converged to PTR_ERR in case of something
> went wrong and null in case of attrs missing, which I believe is the
> best option. It is documented in ib_umem_get kdoc.

Hmm, it makes the function tricky to use but as long as it is only
this function and only efa is using it things should be fine

Jason

