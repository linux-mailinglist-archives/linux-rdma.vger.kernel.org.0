Return-Path: <linux-rdma+bounces-21700-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wLofAL5sIGoR3QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21700-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 20:04:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F8A63A62A
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 20:04:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ZT7Hbzrq;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21700-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21700-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F163130A55AA
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 17:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741543803DE;
	Wed,  3 Jun 2026 17:59:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E3237EFF4;
	Wed,  3 Jun 2026 17:59:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509564; cv=fail; b=cUh1lcPlBZAkaUQftSf9D2FbmBZQyk/s7239ln3st0sfMSmtQVswqWj0koq6uOQBp0BFxjLDl+1hUf8y9rptsIZbVz0QZi5zYuPP18EZcym32eV0J3iHF+FLl9AklAXebX4mrwKZIZTe5NH45ZhFrUoC5uJg50bgjtHrzBGFlMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509564; c=relaxed/simple;
	bh=JOOloDcCbjls5QJ3qKrV2lLIC+rpacgKs01Cx/SDxJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cf3ItEaa9BCpBmD6/lax8tm8nwMykEa3gSwyIyCpgGX0jVC/7pAzXkah0Re6aGl2r5ju1Z0XtlSkCVIYG2nhe+vAggT75dGOO4fXoSrCKmRts00y4xA/+a+cT/nqxc5DBonD3g22X5vlhn7ieti9V2EYYHbEKm2vBEvA0DZr7MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZT7Hbzrq; arc=fail smtp.client-ip=40.107.200.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wn0A/XP2GQn0+FiYWbrsuYx1FYvhceNOwAVPcJNa3P6PhN2B20a2NV6fpsOZoHgghwgoKY5R2MxvbtzTfvFX4WtmIIYcN+oLTLELgA2UcnIuPxGWWuUIS7oWRtqsV/nMjgH7i7Dv/bVrHZbJa2zMemBq9tbOSGcq5TW6q9JlaiUNkPck6oEloC6iprnmVqgOqit6A8xQsilCLbnqeNJhrRXy7q7vV4rfPhy7O7AwrAHsV7L6Na7cbFpi3JVeiVwaN3VbRjbRDJrh6oee2gUYLFU+8qy7NGDkB1gaTejGHKkZu+qoq+1+FIplVal9vefhiE9h8yH9urnGeoAe6gs+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHltff4wwti48oc0xuW/KL7h7i5WPzzYroVnEcF2l58=;
 b=yks2fMLnKcUbgApx1H1P3OdZJ1wU8HjU27YFO9CvRAn2LXc4oBksqtl21GM19tCoQgcvBNiJeVspOJsCvRhL5XPftMdbAUN9qEqbYeDy4Swb/PM5J0KA+OU4BqLwrc6wbvvaB8e3t7xS/7OJY978y/+UDlnWEF0vszBgIM7CJMsH1nv3R66UWEdEBdBKYFnkUrPmzNjkFWHKBbie2POFucOvEM4atpSCddOT41fC2MoiAXhkmEScbUIr4g4Sg2EweZEtgSU6xRCAPupKxqNBLMh/MMmIS/FdMugB6kxC2c7BMwGk+qUtWFQWpiqkd9FO0kr6mMUWW8+hfXC+/BM09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHltff4wwti48oc0xuW/KL7h7i5WPzzYroVnEcF2l58=;
 b=ZT7HbzrqAUpq1SSHo421gxgyBAvvieJSxttXV+7S6d2g+OumZuzIBziZ+81PiguvZQq5v5/NSe7rUTEYQaNwxc4UVZ8xzbiAy/kcRFZiblIAoUHb/kNusOfl4b+KPsjEygFFI7hP4Tr/VmrkTi6hoiUmfpAH4OA9A++cdZx15zfB6BTMpNpb5ojAtL9/iXxt+oGQY6Qm8vxhFwk8UFIzJXXBOwt8wOwoClkX85HV3SKCFS5kBEgUtRp2tc8x4VgBgKkPl5rRsbwGneyB8SfGNfwE2Xk4iKZGqvJfpVYfnuz4M7X7Rj/luG0zPsqj/Bs+fsn3tsm/iPy9jjJ/nQZM2g==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 17:59:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 17:59:17 +0000
Date: Wed, 3 Jun 2026 14:59:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: leonro@nvidia.com, linux-rdma@vger.kernel.org, maorg@nvidia.com,
	error27@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Validate cpu_id against nr_cpu_ids in DMAH
 alloc
Message-ID: <20260603175916.GA1558131@nvidia.com>
References: <20260525142136.28165-1-yishaih@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525142136.28165-1-yishaih@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:208:32d::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f81f660-0ee3-4ac7-2e72-08dec199d47a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	kfpIh41KdguSt0fo+l+xt8iANFfUjbfyBBBFju2gqc91/iMYS2BKgyxMEUv55cbP/yG96/cIiNCRPCZobKZ0M5k1jj68J2nMyhzBLQmrxxeimAZZuxrIlT4VymzWKuP8Y0HaRfFOlTrOzWByYSdfk33z9npKO9pxJWz0HxsbfJpxZDokdWEfAw7W+Cx1KA6ZhHaBqpMO0JlM4esWFfR8E7ZgOfnwDttOoqMOZFPPypSWtivvHIjoJ2hIwq5f2DRqBEjca5WlLiLM5uDhwvh3fkgRQu+kvOT71HFJHGrpxfDAmwba98E7ffrB+qIFx4qJyFwiCL5uEQJkZoPoR8R8QeALaq/q/srgAjmnfnCjvnDL4okX5P7jEi+cP4kMLbiPDPBYacDE7KWybFRsLRIm1UkJkgJBha4R46Q/UDVlwUAV1CsParKmKi7BE8uZwP+Wyp77+fpzH+xOwO/44B4i5bFmYdvYw9I6J9AwVKFAEZWyR6Pxdyt2NTAIH8qWqQLgQILc0R+nJpXiQW6vzftD+9DN4ZR6v+3zon/ODmTPp8KeRTLxy6BEXMEmZ/l3nbr9gDJO10GNwQcDlSQUerDyAB3jPhPTft0HXAZJgM4ozkpePCmk0fYUyFYNhV/iIAT14v9XnBbMUo1ImuPvJQ5CsGiCLFM7zJN0CY0Ckh+hRzsh3+G3d/mn9ob1rYQ+/y/wISvhT62rEELmYg/qbDvM2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CJ2JuRJhfTYjRbnvOQFeMCKleu2xaIQ4tiA8f2hk3bWZiGJioeR8I3devPJg?=
 =?us-ascii?Q?kmkMKFN/nfb2moygv0xSnwgA97xASsgktMcavBiVTwFHODwFA0BDeCBiGSwC?=
 =?us-ascii?Q?l02Hv3lR0XZ1bjxbhlpcW/8SYsabd3CNVHJNQIjYUZqk0kXhiAQn/80hs6o3?=
 =?us-ascii?Q?qjUNozG9uqDm85ylQ4esuhUKEnrLobd2xHgSh2vpohJ2Y5H5krzHR53eG2Y8?=
 =?us-ascii?Q?gofGesUjOjiMonNSy6015MwfwKsCDyNna+6UhbFCCsbANTkVUeBiRhG400IS?=
 =?us-ascii?Q?MT+OafNW+sj0TdbvWp3NK1gC5sDKv8imgOSh4K/MsM8EkyCx1vBGnjq8XZul?=
 =?us-ascii?Q?LhaxcJ+I7n3Df1DFZ22P4dUA4JLO5SCBAmAeg2JIaIpp0bHUIWa2bWEHKx3V?=
 =?us-ascii?Q?pECn2p8SKr7xPZn80KlchylRdcRhsYZU4noYvh/tbp4zi05HiKMc6BZavecf?=
 =?us-ascii?Q?P8ihLQ0qvRUwP4aOcEEg875B+P1CxvXlclgALzGjoZgw5Vt93lXXh7fl1GHn?=
 =?us-ascii?Q?ImVT5axhcNCA1spZ1BbCh8eq4W7enMuYHlmQzWZi8LiGHkEWI93+kiXUQ85V?=
 =?us-ascii?Q?zl1NVFx1hUE11nI6iBADqLejlpTPK7aO+NsTfefa05UlrWfMKLdCyzWcNxhQ?=
 =?us-ascii?Q?lWc/7AzNJuggT+2b+8myaZlnQSLn0OAF5m5qE7EJyQRKOm0PLJroewtT4Dn5?=
 =?us-ascii?Q?Run4gseauCGd2Ok75rp4igQ/MUnZxfQmLAV30GxxTBX7SXzdGUj1mAe2q771?=
 =?us-ascii?Q?Dpw8jA79SlqyFungdPBab57//a2nN6zfEVjP242h+1OKn/dQCp/o9HMq0a2F?=
 =?us-ascii?Q?g5CR7cPuEG3szz5aeHk3lT069rI/HJWluUMZZDdEaiMmJQa/CjTvdpyUN7D4?=
 =?us-ascii?Q?g2sJeTbEj6sJWnB5xNHvoMMwzz6fExwRXpG8LRt1nbhP24xjalSwejYPvEZV?=
 =?us-ascii?Q?BR03oR8ipQbMjPFOZIZ/w8m+SPviKBLz6CJ4BxOJCVPA0H+l42jqyOkWTi7m?=
 =?us-ascii?Q?4E2ku7oS5BUl8DRl7WTmI8s+9w6wGjclu9SlloTjp6yiMn5l+ciRPlyiIFvt?=
 =?us-ascii?Q?PPWGo8RBf7o7P+cNz8/V2TchmOTjBRY0DysCOkhBFe6pDyNw9odZMlr+Ub3N?=
 =?us-ascii?Q?JLE3KJ/JbgkU6pt3vPAKxD441wf0DnEwFLyWaVobgsUGvVPZxergU+Hkq8en?=
 =?us-ascii?Q?EVL8AIoX384nGAkeOopmQc8UOow4J8TPge/KjyF+AhFOTK8BZJeEZr0ap9YS?=
 =?us-ascii?Q?PzE2Kqd46yFoC9skO7jTEZYWhwRqV83dVdEwriZwamXZaRVjlC9Cp3P3l4gp?=
 =?us-ascii?Q?h63xJCzL2jqu0SraoJlv4Xnzt3FeUyQP8hM1NC5HPeycLMWXYlGvjAhSDFRb?=
 =?us-ascii?Q?OO/88+gS8pSixUnmy985xod3H8xIxOp1psVRPs8dQ1gBaPqFVefqUbV/iYAR?=
 =?us-ascii?Q?KNsrp71MpbTBl4xc35OBK4GW5hJFXIMBbxFHMhDegiJQSv259HeI2dCaEelH?=
 =?us-ascii?Q?+tb2oN9/UVKDBMAjfrb9ROr1UNctS1ALfpcmn+NQfOrj8TZi3cJA5dr04e89?=
 =?us-ascii?Q?by01pymbC/z+q/VJmNuP3D+SDjE6SKwVQ8Y4rqwyvIAxtBNpJQukQFX1QG1a?=
 =?us-ascii?Q?HEuQMKqDwwzA16O5WD56/iRz5ExpekjZ2EjClKtMSeB9VKy8hmhUbnpUbLbD?=
 =?us-ascii?Q?f581srvucmx/I0RsoCGTIWlIjQz6oOman7Dgtn9BDreV9CTD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f81f660-0ee3-4ac7-2e72-08dec199d47a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 17:59:17.4367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rs5zUAIQWZVht2dA48fas9jZnkR92/mBcQUsTaZgjA6pW/NzKAovpij0ryXV9j/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21700-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yishaih@nvidia.com,m:leonro@nvidia.com,m:linux-rdma@vger.kernel.org,m:maorg@nvidia.com,m:error27@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63F8A63A62A

On Mon, May 25, 2026 at 05:21:36PM +0300, Yishai Hadas wrote:
> The cpu_id attribute supplied by user space through
> UVERBS_ATTR_ALLOC_DMAH_CPU_ID is passed directly to cpumask_test_cpu()
> without first verifying that the value is within the valid CPU range.
> 
> Passing such untrusted data to cpumask_test_cpu() may lead to an
> out-of-bounds read of the underlying cpumask bitmap: the helper expands
> to a test_bit() that indexes the bitmap by cpu_id / BITS_PER_LONG with
> no bound check.
> 
> In addition, on kernels built with CONFIG_DEBUG_PER_CPU_MAPS it trips
> the WARN_ON_ONCE() in cpumask_check(); combined with panic_on_warn this
> turns a bad user input into a machine reboot.
> 
> Reject any cpu_id that is not smaller than nr_cpu_ids with -EINVAL
> before it is used.
> 
> Reported by Smatch.
> 
> Fixes: d83edab562a4 ("RDMA/core: Introduce a DMAH object and its alloc/free APIs")
> Cc: stable@vger.kernel.org
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/ag68qoAW3P04J7pT@stanley.mountain/
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  drivers/infiniband/core/uverbs_std_types_dmah.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied to for-rc

Thanks,
Jason

