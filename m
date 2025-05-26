Return-Path: <linux-rdma+bounces-10735-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B64AC43E9
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 20:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6093717A262
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 18:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079EF1E5B72;
	Mon, 26 May 2025 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tYNe5OVW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A772607
	for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748285130; cv=fail; b=PIRhd4AVZ2Vv4BgHGu6yLfg/MmCIrdSHLW12bfNcFnbABrO55MOhedNfdxEHOFl2ENyyVO6p9oblhbUmVryDfl1a8ZlDOhpLNtyRJVy8atnQaOqLxZE4zZmzRsPV6iaA4t8YyYvi6BIKkuzbjS5lQ0TNu145CjeXBszeC2UnAbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748285130; c=relaxed/simple;
	bh=bEFf2RCYM0oLdJoee3xCmimHEmSK2jZzXY3FYn8Qt8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y8ZXpNUJaemei+kbbVet+/Hoj72XeSdKjz9IIHe0alvS9sd69j6i7apFUxv06LD4PCjr2dwkKJ+mZQo79QQMGqQ0aRzf6rVUh9jR2bQT2ywNLyNpMU0HM7Cqi+Lrjs0bI4Wr5OGjq2lso7J8FcSRV+m0x8aMV2O7j1MeXZyFAcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tYNe5OVW; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KS5GX8RN/g7yYThg83pkGOd9WCKFPgFIJBbcYrYnjtaBOzSE2eOsa5XhOPLZEi2WJLv34TQeUJiSprKGlAnliksav2+RidzZ/EfSWepmRYtAFQs4YqYB826+wwJ5loqC9GFk5sTyf9dPnU7XOwgDodW9NYIGVFknDht72CTJ0AadnGVDWshdG9wGh5yvDScqZFoXkfXr/m7EpCm9GXZVI5QGXEDPYM73pTEjwLSyVmMbW+7z8VHtdiJYUjpkRMs7Yh1hS0XjD4eUeRpsXY+DO93la37U1DK99loqc9H4Tnnvr/rPgfJ27qgKiOmyO+tfVQahUiMdp/HmnlQ85fKk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/rZdmFJOBb2HFDZflTBD+iWOv69rYTmKe+psUuTHkA=;
 b=RZARseLKWeNt2xeB0Tc5xS/3wwuDjN0xTVME8BshLTFd8EaUe6/0rUaYu3xRqxh7jAGlfdAUWB8Vr7nvspTEIQVrGVcjH/5IN5GjG6ABUUOL6vDyz2wSKoeah4iDblUMaa2QMn4TD76a9k6SomAy5hetn/iGdD6qEafRZZdV9fokicdU4IyYM4HSYl+64gqqi7lhfiucB19SXw+nPW5dVf0oW2P85Aag5jd3a73GBrG9f+x44h6pOASj38s5GmHRjeL9zGc1pXqe3yq2SJxasSeiZ96A76/yJfxt1wjGhDzxYGlBJE70dJaxHjKxajyibGIyiB0SNWH71T8owv6M9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/rZdmFJOBb2HFDZflTBD+iWOv69rYTmKe+psUuTHkA=;
 b=tYNe5OVWJstbMfArBZcu824sG99PjcBQ9vFw0zD5VJvo2d6RyY+Lx89MkCbWtdv51mZTiKy/axL0TdJtFdkQXhZf0ckdKiNm91IkuaNMOiFm79alJQFyucVfuv4okgs2kNwSNbzSznEtETsnWZe9BGhP61dnA1k1RRzWFnUH6mT+C16wUBd8ZDS3cMA4GcbIlTel4/YnHr93JYfL2Ro73C5ZvjnKrl+UusOTrj3tDe5KJfHa10n6MCBO+glgn1rqlXZsMbkI6w+cmJxPu6ne5/O6k5IRqIUE7f2Gq/SnJ3OFi5iM0K2pxr/rWRyI+9gNnRwTqAuRzlB0IbOhC5MQBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Mon, 26 May
 2025 18:45:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 18:45:25 +0000
Date: Mon, 26 May 2025 15:45:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jack Morgenstein <jackm@nvidia.com>, Feng Liu <feliu@nvidia.com>,
	=?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
	linux-rdma@vger.kernel.org, Patrisious Haddad <phaddad@nvidia.com>,
	Sharath Srinivasan <sharath.srinivasan@oracle.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/cma: Fix hang when cma_netevent_callback
 fails to queue_work
Message-ID: <20250526184524.GA114945@nvidia.com>
References: <4f3640b501e48d0166f312a64fdadf72b059bd04.1747827103.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f3640b501e48d0166f312a64fdadf72b059bd04.1747827103.git.leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0133.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d750d8b-73e5-426c-cc65-08dd9c857a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qzQoBNt08378nXB6O8Rfji9N3mgaA/3ni81buJyWzNjRtP8AOe3JJB1FSgSq?=
 =?us-ascii?Q?7V9diEqiFRnSApIbbDUf2buGWwrTKwNCW5U8s9SaVLxZ39tldYNA/jH+Vhem?=
 =?us-ascii?Q?Wg2I84a0f7b+faNFgO+BYTuENHqgTPeOTwQNwHo/mq94mfWYH7fNobaXSjLg?=
 =?us-ascii?Q?OMgGVF9GtDvcWRH26tNrDbgKQUpYcd5Cc65xwRZghTqlQdJSS6NPhomr0IVT?=
 =?us-ascii?Q?10p0NjF0y7dvE7+GBDGpDXXWABUTk8ePHmMTEQ/3DO+F4dJ4zoSk9+CbyG6V?=
 =?us-ascii?Q?HU19qVRfDVOZVyI9HOWQgkONUVZh4j2wbysezNYqXcQ7uwXOYl6ZCoH3Eipy?=
 =?us-ascii?Q?6lByRO4vMXwM7NPucRw5tky7bF8S2zWCcnCYURvu8i+mbpTXlZc0YH11bh4I?=
 =?us-ascii?Q?o6Vsk9xbjyxfP03J3jZ4SIgLtkh1at8YpFStY43BhIfUALjRyBmODH7YxPxU?=
 =?us-ascii?Q?9Jreo5t1SsGY8dy9cCtfLq26/YmlVjXaDNQG5caQf9/M4M3blzFksYlxIDCy?=
 =?us-ascii?Q?EYXTuZ4mqmNNvufmi5RmznL9illWQ/wr/feJ3ir2ViQNwpX4wsvBByfxasgI?=
 =?us-ascii?Q?yXA3WrhTsck6DJjikdCDlHLMcZepSn09faEp9SVnKaKkM5p3ZcZ9/sj0H5hV?=
 =?us-ascii?Q?TWc/BEESHasbZHVEgBfJcQPBw7Q3S88uNidtgKcO0EMGCBxEqosygO3dDZ4w?=
 =?us-ascii?Q?XbV7d26t0QBpiyxr0jNBOQZq2RlBnTB0syV6YSUImRTztzNERK5+Kt9a4HLm?=
 =?us-ascii?Q?Od0QWjkvm1IC+RuGHlXxwjFg572CcHV3JFFt3GYc1XkuK+Lp1JI7E1Thq4ct?=
 =?us-ascii?Q?NHzogt3wmAivFeiLsbki/iWZ3S799tZgltxnHE/DtlmuSzKqLDjLuvY0sVVj?=
 =?us-ascii?Q?cTX+Hdt77gec6ZAYOkI9nv1/RcPv0Nhd1CVphGfqEnzdYwOwjTEMLGwbS/Em?=
 =?us-ascii?Q?or35khyajxhqXkoPWEhljNG0FnUi54tDnP99zt/nNrkvfxATuH/rWKCOiVEo?=
 =?us-ascii?Q?Nn3oZiw57MowANiyhhnO6O3Z69Tcj2EXtpG4OCR+c5F8iuByjnlQz9kC/zGm?=
 =?us-ascii?Q?PBTFm7pqxtiLKQSxsJpF/56WC4hZULC4CO1u2MECj1vKWFI141I17X9lSiWt?=
 =?us-ascii?Q?rA/yKCtoBl647xhPNHBvaIbxDpiKWJVB04hjilEUwrfbpDtd2uQve7a+ZTMO?=
 =?us-ascii?Q?EFJJTadGO7QvM4pXSfb2n+azETDCam0Hyev8tnz4XujmZL2Sjhgbu92hOrOk?=
 =?us-ascii?Q?xppZwry1MKaJO6R879c2Ekdw+k9qZf+5V3tBk50wZEdABDMtZ1fpoiuNFtpF?=
 =?us-ascii?Q?fleDOBnnl4+sRWy2tYzAd3whOx+KRJcPOJP4+U5exXCsk9tyDmCFgqg+tDbK?=
 =?us-ascii?Q?gitYeOp7w593bScbEdmynM8mA/ZT0adHtDNQm+7sEmBEkUYEHwbGJ+qdhgrR?=
 =?us-ascii?Q?JynmAyuD6NU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IUefXnZOlLuFVvJhe4tazTahISP6ftrmkuRZU+w4BZMUA5i1HdaF5NHG1D9V?=
 =?us-ascii?Q?rXTTfw+7VHeJmNhyGUy/UqaIgibfraNeNxU2AmVIGgbHoDaqJnVjv7oE+sbK?=
 =?us-ascii?Q?0VClKLz2WzPyHXMXJVCtjWZQLK/zjazaXZ+lA3eVGrrez+xOVzr6qQcuzuzw?=
 =?us-ascii?Q?ZtSrCrjAMldvuH9UblnXt1Zo4ABQHftbhmH85nL7+uLQ7wDwDSUuZFEFA0yM?=
 =?us-ascii?Q?h1B6qDQ1ayLooUyHs7kU3PtpA+gAviekIDTNCDxQpuNsKqNbDHqw8iNkmBlT?=
 =?us-ascii?Q?OGKrbAjS2Wlt9zmLc7uuYcyCNTCX0XxbE0wUzYsxP4WkPWzY6V9jUJ8MEQdV?=
 =?us-ascii?Q?Nrkx0jIL0F8gv62Q4XMTUBUhZUw+qc89FiEJotqYcbdPotnkgrBbl3hjkJPN?=
 =?us-ascii?Q?oQP0GU90e84MLSIOi0S6zZZz7LbpTKNoOcP0vJXyEewhLPYecVjhCpe55qOs?=
 =?us-ascii?Q?cfO5+B6eACBi2VcuLSFsR/qSxhlYO51ju+ApceIFNfvHeq7KOMNE4/ehx+vL?=
 =?us-ascii?Q?QMrJvHt5V2zndar9ArI0UfZEn5TQKUvZJ4tgaZSg1c2D+g+s+CSveSFK1BGk?=
 =?us-ascii?Q?0G2Nuss/q2lkmfVL3HCfyczHs9t4Af/at0WwfhkHE+rJocL3ylHSQjB093uV?=
 =?us-ascii?Q?8hgNYPZ7lJU5OFgOqTsbaRrfbkmDRqZW0oy3jjLjNrGzlA9FLrs1BFxEsBHE?=
 =?us-ascii?Q?nhhc/UYKaxYICI4AvmaigwiwSrhImt0lV74jcpVMfh4mbaxYWe8eA7gzuIZN?=
 =?us-ascii?Q?hVL6STXia+9Z+GxXReB6EY0IHcu+gkEYvXyxedtriLmmoNWAbjqH2jUCfxnG?=
 =?us-ascii?Q?bGK1z+mwj9MuY00qaO92ubcDjyH8pzJK2YFdJh3WV3dO+J0vpWrWbO5M4JVr?=
 =?us-ascii?Q?NQykfRBDVLJ8lxB/BgyTnj9SvyMgLDyZ8UFZ/MOaYfoVbnsUqw/cgQkjowj5?=
 =?us-ascii?Q?dNkxAKwWAxlro0l6Hsh1JppZS7SNIj2csrxwgiKlLZX1N667y/ORooNIQm3v?=
 =?us-ascii?Q?UOf/09eqHNyOBt+NYXQwY4o379EiKHpeAE4hri2jsW5mKHOTvV0CVjtXU0Pn?=
 =?us-ascii?Q?XHa2SOI1L+XhLd7SdBtysZcx21ZUdlXq8vqTk2DOsDxpFPimAMOFXtwu+Dr2?=
 =?us-ascii?Q?T+YaLME/SYJN8UVNC3RqQvoYYMCymKV8hwgO3CoKzpGYruCaaWtKT6gp57DB?=
 =?us-ascii?Q?BHOMdusd4yoMYuTPbJoO0WaNKUezPx33a52/AJKsUaKj9QM15n5/Q/Q7yLiX?=
 =?us-ascii?Q?3walj0kD5FpF887xNIKfkQIh1iwnIHt9UZXDsbvSQWm403i6e4VIyDVXRn5U?=
 =?us-ascii?Q?rH1MjOjINsmSaF3EjUL1qrQtLuhoY8he1/fGu8hL1/1td5oATAJ0VEY9MzoB?=
 =?us-ascii?Q?ZIe8i0601j9d1jYsbCQduXjUStx1pIsfmZJE6lOHvxoyR06WQT/dwptNxV6m?=
 =?us-ascii?Q?mHL+ErEIY6WupGWC4iRXHVwQ9zxgpWsnnjqnR5qilq40pyIElN/hOwc0lLS8?=
 =?us-ascii?Q?TDZFq45xn3E0FT+4uJtI7hQGXsn4e9U/B9Y5lQweMzn+9Y+izeFJttusLaBQ?=
 =?us-ascii?Q?fanMJK8hF5nurVclxk1vNUcS9OZ0969dYqyVkD4s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d750d8b-73e5-426c-cc65-08dd9c857a50
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 18:45:25.5067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpeUbdNI0Ec3hET5eOgJnAKRbvNW3CmBR6+C0Si6c6vzJwFKMF11uhz/+riJUtOl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091

On Wed, May 21, 2025 at 02:36:02PM +0300, Leon Romanovsky wrote:
> From: Jack Morgenstein <jackm@nvidia.com>
> 
> The cited commit fixed a crash when cma_netevent_callback was called for
> a cma_id while work on that id from a previous call had not yet started.
> The work item was re-initialized in the second call, which corrupted the
> work item currently in the work queue.
> 
> However, it left a problem when queue_work fails (because the item is
> still pending in the work queue from a previous call). In this case,
> cma_id_put (which is called in the work handler) is therefore not
> called. This results in a userspace process hang (zombie process).
> 
> Fix this by calling cma_id_put() if queue_work fails.
> 
> Fixes: 45f5dcdd0497 ("RDMA/cma: Fix workqueue crash in cma_netevent_work_handler")
> Signed-off-by: Jack Morgenstein <jackm@nvidia.com>
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Sharath Srinivasan <sharath.srinivasan@oracle.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  drivers/infiniband/core/cma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason

