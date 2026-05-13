Return-Path: <linux-rdma+bounces-20546-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBwCAywRBGoMDAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20546-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 07:50:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E00052DC5B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 07:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCC2B304D5EE
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 05:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8253AE190;
	Wed, 13 May 2026 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aR5OuYE6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011006.outbound.protection.outlook.com [40.93.194.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEB23ABD96;
	Wed, 13 May 2026 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651420; cv=fail; b=hkucEjUsfH7TCUlgF16q6x69xELhZPhKJuLCCXVHbnXaIqZ+2HqCWQTFmNaM+c+ozCTFgn6S+zwJ0cXLclQVEKqDNztMNUPThtszIKAFFkin+YEhRrwKL3dSLno0zKG+Yky0B7d2IpR34npo/svSCcOfnUriw+EaO4sd4iIuhCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651420; c=relaxed/simple;
	bh=34FhUSXtnZgWf9pvlAtWbtjj6DJgrJ9sPByKpy8K08U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqPvv+xdqwP39ePVmmSNm3EBkP31FZpaDXMX8X/xH+ODOb+JqqC0ZJHXszjZehl1whPF/JdxLTZ7I3vLt9lyZ3wSxJ2OlVLhtUTK9Od+Qb4qidololenTk01QVe/lHQpY/i6EdKefx4FoYEPSxpkMNQQKMeOANJwViMzch3XwCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aR5OuYE6; arc=fail smtp.client-ip=40.93.194.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRdDWNAS4UTsvm0WqbQCh6f636iIZLoMt4mnEvqfVo9CSLRw5+iX+jy/etEeqG6T6pBuV9G/EOPJYppEzOvlX1F4W2KXafHpensCdCxmqWqoXKOUUhS/baZsO92Ligqfa/eFhnld9YkbRLpRbvEv5sjBJ3kUKja4dmSs772oFWppJ7rsIjyGBQ72ELdJktKLd//c9xOihEkd6+WmTTrvopyDmS6/xHXAArvCAfeK3AygVja5EyUuAP+AeV4otKXqPHmsl3BlcUN5Oh8ftgoDQqv4erj1Ls/2DZBE8BkT3H6kuzWKkcxLqGdwApB++9+vcOyr/p2EoAkZfCetlhRR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chVLqjfjlcQbO0/H8HyvDGqc/TbYFM2IJk0Elp9ds0s=;
 b=tJnXRaq/Slk7N+aB0cKkZ8D3ZWo0lxReCeM9WD20trZRH3XhjEmv1TflDgFxSogIG0FsJUxuC8CJe+j9t8PAw0tEHWXI2Vfop2CCT2Y4eNAEB3GOos8o35CAdfA+0YurmPRCE6phhflHwW0x4HPmSvwlbtKjJ2RgAXHZHDkVToKSdFLvEaVFj06nFRUtcggxm2Pj2ln0TDeu4yU9J8pgvbybBoAUC03nEwKGlPFupM4EjGC4XFZN1NlBjkQevJJT9L4ToYwZr1HzCoDbgPTEB6mg0aOjMrKbRbufXuN9NgIDhOwDUaR1U3p9hMnCcOkOXJHo0mu/jVJn0rYcwi4McQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chVLqjfjlcQbO0/H8HyvDGqc/TbYFM2IJk0Elp9ds0s=;
 b=aR5OuYE60ja4OGaHzwC0A3a4+L1eQqyaE7FleXQrEGUOboUp18yrRDcFbj8KQMZT7wXyARpD7cQyrb11+lyw4uJBZ1U0cZjsMCSgwJZP6uGFYX6lrMLst6dyTQOUUJVE94VP3qGhqdpNt7LpTC6h9GZJrR6mN5C+4ryP/7MPaa7BZ71W4YOkLwKUaeJ3SSQinxYriGho+qaDkIPVnq0RTibys2J8BrRoTMWxB7YIEb6lygGc8TRWgeVAr5SyFstc9junPhiu25f2InUsQ2WlkjovOqCIRj9YKBQcGf3Ay5b00WBi07Qg6+7R1Xe5Gm3qTFkV+Td2+7HZ/CjYeJZDuw==
Received: from CY5PR15CA0193.namprd15.prod.outlook.com (2603:10b6:930:82::21)
 by CH3PR12MB9023.namprd12.prod.outlook.com (2603:10b6:610:17b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 05:50:14 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:930:82:cafe::64) by CY5PR15CA0193.outlook.office365.com
 (2603:10b6:930:82::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 05:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 05:50:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 22:49:58 -0700
Received: from localhost (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 22:49:57 -0700
Date: Wed, 13 May 2026 08:49:51 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: David Ahern <dsahern@kernel.org>
CC: <stephen@networkplumber.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, David Ahern <dahern@nvidia.com>
Subject: Re: [PATCH iproute2-next v2 3/4] rdma: Allow netns to be specified
 by pid
Message-ID: <20260513054951.GB15586@unreal>
References: <20260512193412.32019-1-dsahern@kernel.org>
 <20260512193412.32019-4-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260512193412.32019-4-dsahern@kernel.org>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: 2570133b-74d4-4f8c-f06a-08deb0b380f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	FF7XW0LWurDBulo909kiU14/K3+KGt82MI40KK1M3TU+5GvIoRr9AaYFe8noK9LYqGl4+INZ+W0JUpKufXXvztl8Xipz1+4nGxlfqzzoI6if7EcvNJzmsv7ii0y5hr1ZVaICPQ4MT7tNPGhq3OFEOKRtTkM3taVG7O21eRs1NqdyWuozoHyDlkt/9isK/OzQEzjWsG4zaVMpmMwH0jd+44Th1VbmiYvYy82XevLiPwSHw9ulFHKY0jy6f3QEghq2+1C28UEbI2bP5EG+kUZDV3VmRDFx1INFawDQXK+Q19X6CT7yux0uT9fyKJazD73xB4H7rY8ytahRozcWy8BQOXoIITf8pciIafYrzdVvEqCsaREm/A/6isLYk0zgjOoV41INgTSWRkkwf7fhyp2wg1JDS0+UTo4MJ/U3O+ebbYwMxT7Ccx4NVMNm2EhshriY1RzheveAhxf+gwtsvhIJB97VRl4xssbI/+/HRHviu7+Hd8swqaJ5cKNQRypouDWYScVhwt7JTsd3dO9lFao7Z8lo7ei2Nvpvbty8uPazVYNLSsrwoNazR7K2REcBCkdfJ4n3jfm8gD/bbYsIJMUifMSl05qxHcQ9wvYP6d2CMYacILUomD8z0qVdkg/66zhNMkeX8jQD5GJLIS8pSsuRt69hAJ+JUUQYAO6BSMLe2/E6mT28k5gla0m8HMfUIKT3Upb1DFKEqMYJlC2mplvGhzISb7ZvwqGYciP+H9UCFRk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	14smuNG1wZ2k4TOWe+S630Xjl/xPKh4hwKCctO1T3ReEghA5lt8K2cTe6PWH78G/e9arGDoZKF75Kki3BFfMmCqcO0bl+KvYwTASJ85gdr3XrvpLjhaEuKi25JTDiE4Zm5w3jOm1+kir+6JjBjASbuBuD7rvBihE+PeoBgptSqb60k7Wit58147vtPfMEE1Iwu4sKdKaVWCJDc1zCc5Sdg3xLaaPcHFmIq8es93dP2l2eHM+d1/sSja8sodIyossicKBjScfZwNZheVXERKQ0MpKyLZZcd6BXoo3u0Wz8i08mBbKtA9/UcMEFKzHcNcqFzhD9rum0Jc/F9giMar4OsXYhuQ++bIv/k22H1Ip3frA0drZeqpPSIzv3yceYD1DyLcDMY+K4oVWlONPC9tmsw8JZcJFr5onpVI4ZdpTsZbq67iMqSObY89hrx3nEcGI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:50:14.0818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2570133b-74d4-4f8c-f06a-08deb0b380f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023
X-Rspamd-Queue-Id: 7E00052DC5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20546-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonro@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:34:06PM -0600, David Ahern wrote:
> From: David Ahern <dahern@nvidia.com>
> 
> Update rdma dev to work like ip link where the netns can be a
> name or a pid by using netns_get_fd. Update man page and help
> accordingly.
> 
> Signed-off-by: David Ahern <dahern@nvidia.com>
> ---
>  man/man8/rdma-dev.8 |  3 ++-
>  rdma/dev.c          | 11 ++++-------
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/man/man8/rdma-dev.8 b/man/man8/rdma-dev.8
> index abc9f405ede5..34ea1c614ca4 100644
> --- a/man/man8/rdma-dev.8
> +++ b/man/man8/rdma-dev.8
> @@ -32,7 +32,7 @@ rdma-dev \- RDMA device configuration
>  .B rdma dev set
>  .RI "[ " DEV " ]"
>  .BR netns
> -.BR NSNAME
> +.BR { NSNAME | PID }
>  

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

