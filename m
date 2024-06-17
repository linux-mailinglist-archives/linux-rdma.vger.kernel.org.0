Return-Path: <linux-rdma+bounces-3208-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE08590B1F4
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 16:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EFD1C23184
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 14:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D301B1413;
	Mon, 17 Jun 2024 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WaqkEhXY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAE81946C5
	for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2024 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631857; cv=fail; b=lm/MpPBJfKo4wa3TbXZcnw8ITgqdb0+hJUW0JFOz5g89/ZFeiX4ozkHgYiIvpCWpgmNluyWOlAvGpvekvNLoqxgV5ydg0sbQ/KuxriskTNvz2CK9f6sFAVyXKwVajUbAgFbDgFJFRd0NEuE5mhVAQ4y9N05zxM4oWyCRJzPmzqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631857; c=relaxed/simple;
	bh=jE4v+48hS3QnGMxUw2QghB5NQIKaJjUH/XNWe6pOEy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DCVosyqXQHNdC35qw4ywUyfm78xt7O1p9DrJniuggL0ApHEXoZg2OOaY25jHPXqk502JI4xPQe6UE4iNMZN7dOMcU3O1CsqYxTRxgwNsv1rfEeIQrMJzbwXuMlc6hKZmH64Nuuma0PXcsbpnRwBGcvG1VZi6Tp+wLVYjFUKoPVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WaqkEhXY; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huKi2bZmB+vGJFurPVt+HI0dS+kX18aOFsbwesLVa1ycFj3SmQSf1sGoVLF/Z5vTIw7GKKnqn9XOaRVcMe961DFmyjb5UTEY9L9tFEWTSO6dCkDTqX74qATAqQX/F1wEN2Q7Lc96PoP3VzeEC06qobEZvJkZKVlYOmKGnSJkhIGJ4BWPa0o1VaPFKgeZMQ8QEdG9twH3Ak0IjVBR6toOegR2/lHAiMLVEbWGn8hJxHtIpSQh7sFKku3wE2YPm1FCRuMS+SEQbjPs43JCTWkX6swe5UYZD4x/dPO2yraAfktzwu2wEV77SmSc4B+DthuDZZrBxJXnLwtHFNDziIemWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIvrLPd1GoJb+zEt2MK31jzoX0Y7sFT9ecV9gGgOHDs=;
 b=fwvJ0/br+fdx/CIoVMuVuYVmF0jfLA7fcBj0sy2OrWO8ooRp9L3bQwz6mImgtCCvw71/hZ18eEAyhtMIKF5XrWx16wVo9TqXJbaZxhBBNC74svOy1qtChuGZGsHRdiUwH3xeqRdey5wCgqKjfVu/l2j3dWIbnXwvibqerQe9YhYWhWnQ6vbvlSvZrW6pUiRQ6snhntHBJZCj/JcmNgAsZ0oksYmTiODmVxUsDS18612N/MePqUwjfdfudh/Zaa94sRM9YEjJxvfQ+LAgq5tKdkO88RKchiPGCH3DtzoTg6/fJid4u6yL9HmtsG8g0J/ezii1ZnaNiiYhxdZONG0UgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIvrLPd1GoJb+zEt2MK31jzoX0Y7sFT9ecV9gGgOHDs=;
 b=WaqkEhXYrIDQCXBvROOZ4/AD79yNWQ6HuMQUub838vZYTz0fQryuuYzQcJqMIW6X5CByOE5Poj+xyt2hb5qpS02xbdXBnZbmTw6u61cycwUdQhBMaacxi98ug3RikobQDiW6vt9UMmbEHM/gFgJBWbtQZsuftSOwYUB9LeYelyA4pa19gp3hONL4DN7T0LOJRcoHpIAA6ICv/iIuN6yBpY+UqUCqHQqvipRqVycOqm6xQYmK4ovyVgI7Wz7GToMEkTuLORzdcFhY45DV0qbich89ML6P2OvTmZCXLcFZP+cD/LT84ueablJXtIF1+dFTkl59EhgYxnhsDd5dSU2myw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 13:44:11 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 13:44:11 +0000
Date: Mon, 17 Jun 2024 10:44:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Akiva Goldberger <agoldberger@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA: Pass entire uverbs attr bundle to
 create cq function
Message-ID: <20240617134409.GK19897@nvidia.com>
References: <cover.1718554263.git.leon@kernel.org>
 <7d0deae3798c9314ea41f4eb7a211d1b8b05a7fd.1718554263.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d0deae3798c9314ea41f4eb7a211d1b8b05a7fd.1718554263.git.leon@kernel.org>
X-ClientProxiedBy: MN2PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:208:23e::35) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: bebbb26c-25f6-4184-3f6a-08dc8ed3919b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lMVDHSyV1hLE6Vz2p4+Ac4j9c2roumI+Ck95m1WcsuJn63Bn9f+zgTwo2B6E?=
 =?us-ascii?Q?frC5WEsHlXUhN4/AbtFlrT0giJrtIZDVIO3av2uI/jXkYbz2cbdCyo3U9W4A?=
 =?us-ascii?Q?8povy7HShWo9QlDFyuiY77YTZUB9TSNg1D/jFn6LCNGM6oO4QXVXt6Teb+Ng?=
 =?us-ascii?Q?Yhglg6t0eirC1PZgS0WFKVMxeLeR6z8xaRqueWweZKlhkevUmlRbQQUHL8Fp?=
 =?us-ascii?Q?EDJnKkFaNtSIuUdmcVIZQ01NEBN9WXrwPm2Wh4bBDEdGCojJlUlSCxzDVplB?=
 =?us-ascii?Q?kIADj93nHLk2No7K8zDhyH1ANODRPOYO5yhh2GxUgn7F/rmD63A7Ws5I51jb?=
 =?us-ascii?Q?Dp7SSGbDVUvbkNAValBSDfixMtYdDXVvrgsvqLfuw79gvFlIaEQGgQT/fjDD?=
 =?us-ascii?Q?sp/6xdhFiaygV2sJTNN9Vv4rRr2/H95RSjzLf1dXy4NfOksuSNChUhXMkegE?=
 =?us-ascii?Q?V0gHSiAQeogs/S2irMmtvZA7bqvySi1idbgNJIacCq/qTHT2pf8FBAUELhwQ?=
 =?us-ascii?Q?1m9sZu1avPoImAPUCtQSeSg8rEi3ad3UM6Ey1BrUCxyxC7QdT+YBrxH5PfjE?=
 =?us-ascii?Q?lwnBz7zg6MPcaQI/IbnGHzo6Z7wR6WhYez1t4oBFjTLt8P/DeIqBVRCeXyHe?=
 =?us-ascii?Q?N1ycOYN7JKYauTlpsyX+kkOkWXxInmF+tasqd4pKjTfCEbOe9/xDx/LkLxkh?=
 =?us-ascii?Q?t2PwN40efjeHu2m9uGEfOUBSdMEZpZduIBsZEuCqzmapBkT9DpBFdVAFmOE+?=
 =?us-ascii?Q?lWU/OJeKymd/F+/QxM2Y7nDPk8jJr9WBwFi3Eu/6WZwOkCXve01/M5G29+iz?=
 =?us-ascii?Q?vqpVWj1CcVf5ALIZoJGXydANuFcd/ZNE1uyZuJvByDJ+V8i3OLfQDVx5hNs7?=
 =?us-ascii?Q?PO8/ZYnzh6EUSc6teGqHEWptPq4KDZZ+eK4htNjDncbimBhpUCO6uxqJfpqX?=
 =?us-ascii?Q?ZD5WGQm++JM+vVaS8B75I6NFdfEe6WrcbWIbV8PhSctu1pPU76xiHqNakwMM?=
 =?us-ascii?Q?+Ah1STeaHm625hPxiyij6GKNCqD30uwwmMppfIUChFgtilS3OJyUjm9aBuJn?=
 =?us-ascii?Q?8R4QfNlIR56ocxOwQ+CpvBFqFFDplz/kmwuzqYXblgsPcq1uWtTvZmKlrJlD?=
 =?us-ascii?Q?RayYFh9GHYwE6PrE2rDKAzEkAuCz9jdOiAc9AnW1alTYceE4qZlcvl4UHLMk?=
 =?us-ascii?Q?EeU1XPa4k0xTV9e1f7flluQ6SlaAMa+lzEqL8Zr994ulWr8N/Ekh588mK0Lg?=
 =?us-ascii?Q?HIS1ZFlDZDmePiXo9K4kDnJMFKWwmb+U/GrSO4l3u4V7WwojDJ4bbGjvI0h7?=
 =?us-ascii?Q?K4G8aD3tqpRRyI7k2JOs6g9A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CvviyzUkl4u8Do21oyydm2PYeCldwEOQBMd0gZJ9qanOKCC6lm35VCcrhSOW?=
 =?us-ascii?Q?rLjfNb8+8g5wmK45iaTmM+9wN6TZgoWv35dLK0DnqjqrYdKDmh1FwGBZMX4+?=
 =?us-ascii?Q?gKqLvQ154r1LEqelrz1atQYXp/U4gJom0iwbRc6lHdJVR8kmrCfOcSJXXv0Q?=
 =?us-ascii?Q?BSdXJFC1dqTs+kprzYdJE/M99bQNmv6pp2w1CRuhR5E7eCqAxN896fcOMRyZ?=
 =?us-ascii?Q?yUiOQUX0WFKdV8eV+oUZ++wMK8nUkZV61ZD92tRonVhvEK5ABVfYlGZMvHZp?=
 =?us-ascii?Q?3iN3i+yCcGuWf2zOnAEkzLh4dXvlpwU8kQg4ll7sf+wO/Rn7dzTSr2frxSQ+?=
 =?us-ascii?Q?bIyKOzs/gVrzHo5sEPSbgRBwK8mTKtMDjTjPzTEh9hNLWil2wor8tzPrtvpG?=
 =?us-ascii?Q?iZFw/40y4c+mX0yM+N0eRI/m3wf+/ybY9yGkQOEjHthbRvcYEHdIJxcUmi7M?=
 =?us-ascii?Q?vjZEDGGuqnVvcgRiPyw+laC6ys5mi8ISMOvz6aZ2PSvMBk9wfiFRVTWtzNhG?=
 =?us-ascii?Q?+HnToifmvVXWqAVUqyixSm/awVkKvYRJODjH12bKd/GwMdXasZ7qERnyusir?=
 =?us-ascii?Q?SMbkiVLkFFxH8NEO87AJJFEZcphXiDFSRNidcrgaulfSK08a4F4dOewafAXR?=
 =?us-ascii?Q?c1sjMiJvFI8JWvjsMjYdj+FrgH9NVF1bzvCdp4Cf1FY8dX4uRHxc2uRDHMXd?=
 =?us-ascii?Q?9kE04JQQNz80O4fZy1aLw6Yk22Y79obHHd4e1R/FzfuPk3n3tOo7lqeeJLB8?=
 =?us-ascii?Q?lXnAw4/AUfYkzj99N+EM9hZWv4lCocVk8iKvfl19W8T8v3fnTiv0O/hf0dsM?=
 =?us-ascii?Q?/QJGOmUUD0Dmv9aTuMgkQB+Hg2yxa3/6HlBpcxzd6oraBm+AiJ+mlNhgpbDg?=
 =?us-ascii?Q?EYuzKr0GQZDKNjLZG2iFkuqkQRu4qKtOBOcaW5Bj6kXzg4BBiOo2YO+QVzK1?=
 =?us-ascii?Q?fa0aX/q+gnI6huE+hY6LwIP25wkdJNEEQL9QREn+Ng5jY8gNEWfcH4zu4cUU?=
 =?us-ascii?Q?3cvDb8PrTpTbG9nNurg0EzoaxiphlQz9uJlzGOo9o1OJkMM2q9gvd+BiHCcD?=
 =?us-ascii?Q?HhhrisiJiDww8KVCIcCyz7NBbHi8a2DSymoUjTAXa7bIg2pkPstg9G/p9Zu1?=
 =?us-ascii?Q?nMgV/bQT7Yab1m9lWrk/2xsWVu0uPo8gHfBfWATP0sXfiFtUa2+LS4FZwLoT?=
 =?us-ascii?Q?LJyHF7b9BNIfL7+6L3B0CQbnecI7CJRjsRABq1f9N1k/rCVBeQO/TuKnufMT?=
 =?us-ascii?Q?EdKIyi3pmAzgNkFJjZgV3E5LSWq+jSzQ69eLLdRzyXQYyt0ZlpV4xkOQhlCK?=
 =?us-ascii?Q?tk5BpfU9By6L7WutSwgEwKVfgO6rNlYgw9iBjHZ+8xT0frEagqxKyMLRsiHW?=
 =?us-ascii?Q?LvRtagFaInIz4BDs8jSTHzC8MMFUEe+4FALngzUnB8p10cx8MpfdpK7PvXru?=
 =?us-ascii?Q?8oxfUxJlsCDmmoFq5ILGt9jViWrS/1SLoWfhkU/bUdMnI6ITaNyXoo8Hs3BK?=
 =?us-ascii?Q?1PTfyqvTVR+I0oqlzeiRAZtBXPLyZ+yN5eL2yc3U+fLx+uF/ZcwLTmEPZCN9?=
 =?us-ascii?Q?sXIqIUfQy09W9QGlMkfIZ1/XwcSFMSyPqv7LGJNR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebbb26c-25f6-4184-3f6a-08dc8ed3919b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 13:44:11.4068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dlrn6EIHHWTRCuCYkIy7O6MFPok6NwR3DTMgt4ld9oBY39OiMJtM+ozr3jduKWF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071

On Sun, Jun 16, 2024 at 07:15:57PM +0300, Leon Romanovsky wrote:

> @@ -63,6 +63,7 @@ enum uverbs_default_objects {
>  enum {
>  	UVERBS_ATTR_UHW_IN = UVERBS_UDATA_DRIVER_DATA_FLAG,
>  	UVERBS_ATTR_UHW_OUT,
> +	UVERBS_ATTR_UHW_DRIVER_DATA,

The start of the driver's attributes is not a "UHW", the UHW is only
the old structs.

Something like UVERBS_ATTR_DRIVER_NS_WITH_UHW

Jason

