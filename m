Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A85B37B7A6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 10:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhELIQX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 04:16:23 -0400
Received: from mail-bn7nam10on2081.outbound.protection.outlook.com ([40.107.92.81]:53024
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229968AbhELIQX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 May 2021 04:16:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8XBcX+dIHfkrFS21FhB4tSbk+ByEURmxhysyFnehS4owvsNsUKAqCpN1pV4gmUbPOztc8k+Y0ccsdp4UqJzQUROd5m526oelamJUm4JPAmWQUNeZGk6mdTO79Su7/iJHlSdI85mxGeTHnjcKpD0+JLkUAxArNxixxQfhq3QJ2ItAmtzDWO+6CP49mEXRcpHht9Q9gfsvUMbiYIpXU3zmmGt78xAalOiNzyigLM4LbaNg2P6Pt9jxeGfLyUjXf1TdycAhsc698RKICirpwpIv1G6N50duRRmk6PO7V82PpgVmLDmzN2sliwKRr2ao7SsNT5vN2jOsKkh8l2C/VHjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liyueecP1iNNW4qgLsQYpfRaVTtkBGp39rDHFvG640o=;
 b=cFWAvcp6cCsRYWnPZ2WXnLvzGYCNpfxO/mZ883zbVhKpSqZQtrG/7hoQO65BfY50788sea6t4adWAAghCpWzgVQ82QM4mluJBuKgElSV5b8ddnUx8WCOGIMfrzTQaGCQkET8NQplt+tqEj57mZjtUffDWFnNktUV03bvXJiENaUzprQ7H0NTU/SszM90sz9ZH7iWudmdsmM1A3JUI7FDEoEl8UMogaxesJbij+fU5N8Uq8SPLiG87PmT2TAAQ3mdWSRCMAcG+GJRBIoCRu80m6riyrD62aY4EuoauWpqBlm49+AD0Y6dF4/XQzTyK/Rd8nBd9KCvv44xENKFhR2RgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liyueecP1iNNW4qgLsQYpfRaVTtkBGp39rDHFvG640o=;
 b=VrcHcQMP7a0oTAzLrOUpACkyzsY4a0f8hqUjaMGqzQFL/fw8TQuimg6NPzkTV+fQyD5kQ0pVbaCsLez35mGIZ3xRq0F1vavNAEGS02sEiBZWfSlvulGU9T3afTO8EdSW+MtI8gUPURM3O5T507anQYDyTRwrjXx2gm4G5TNFrdXp2O7fqG1+rXTsyoF1b5XOk6PCpKpGT8+OCXyYqHjszMv6UsbZAGwzCCPD5jaD8i47atBbWUZNdaTjfG4f0kmuhtpKQ7onUONm70/QwRmBeEajiyr81JK6vR6UI4xtppmzjK9pR9t4daLC4drA8FgzjK/8D44Kh0szLmYzeVTx9g==
Received: from MWHPR18CA0071.namprd18.prod.outlook.com (2603:10b6:300:39::33)
 by MN2PR12MB3165.namprd12.prod.outlook.com (2603:10b6:208:ac::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 08:15:14 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::45) by MWHPR18CA0071.outlook.office365.com
 (2603:10b6:300:39::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Wed, 12 May 2021 08:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 12 May 2021 08:15:13 +0000
Received: from [172.27.15.174] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 May
 2021 08:15:10 +0000
Subject: Re: [PATCH 4/5] RDMA/srp: Fix a recently introduced memory leak
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
        "Nicolas Morey-Chaisemartin" <nmoreychaisemartin@suse.com>
References: <20210512032752.16611-1-bvanassche@acm.org>
 <20210512032752.16611-5-bvanassche@acm.org>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <e7e0bb73-4bcc-61f7-1db8-67a676150a26@nvidia.com>
Date:   Wed, 12 May 2021 11:15:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210512032752.16611-5-bvanassche@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25449ecb-2a08-4c00-2fe9-08d9151e1153
X-MS-TrafficTypeDiagnostic: MN2PR12MB3165:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3165DB64FC5E35BE35A6E099DE529@MN2PR12MB3165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sgdruumP51rrumHaaY1V+Xu8/Hg7G7+IAPdxVmUUeaMdLOLXpDhubAMJHQjNXnrcy9QAzSetFjSY3ova3oTWzfydOnzwyGN7+OjXF3Bn4tPnTNiPvhdwvxjVVNDZvWQSd/94B4PtXYdW9iA89OizPBrRduQ0OjJ+FqQ6XFoPndDaSJm4mW1E02LlBnwx5XG5myMFJBlhbx+1nytfkHqUp6sBoIU+DvQ3ai4m+ziYtBQfckvIrVHfbv3LUCUpclEzKB0wPJENy0RtaY5Yp+QAYV6I8VvcYdxXXyLd1xoXZL9WBrBIzNGWVZmyM1a6NOtDkS0YMXJSezjtWhMNv5TM5u99+teE4qdoPdvR0ui31GTq84xAY7EfuiASxvJIYDoSlvF6XThzC48+mDa52kagm2bfmvceX/z+Vbed0B/Kofbbj9ZuaOaTyWgoFHuVFBTc7kZX3qLlBWOBCLnFCegVzHAJ6TCoyD09kyeiAxlhVgoLYyF8199w5Dxqhu78h0QpMCspTlsp2RcboA8gAN+9l5AMFZyqYexYzldKz7sgZ3aUmAXuduANQ+Rt/YHu4Hj8S6q1idb2YP3JbQpsmcHFYjVSmXJhBqhk2Fv0Vm058mJ4p4O42xOwpD8dUSMdN8LYgMc8xhTmL0Ht2IYtmWq1sSRSZoxpO/ues2BCw5OH5kBShDy5Pd9lzkuRAXlFPPq/
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(70206006)(36860700001)(86362001)(70586007)(16576012)(4326008)(8676002)(36906005)(54906003)(31696002)(36756003)(47076005)(26005)(478600001)(16526019)(316002)(2906002)(6666004)(31686004)(110136005)(5660300002)(82310400003)(7636003)(426003)(336012)(83380400001)(8936002)(82740400003)(53546011)(186003)(2616005)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 08:15:13.1223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25449ecb-2a08-4c00-2fe9-08d9151e1153
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3165
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/12/2021 6:27 AM, Bart Van Assche wrote:
> Only allocate an mr_list if it will be used and if it will be freed.
>
> Cc: Max Gurtovoy <maxg@mellanox.com>
> Cc: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
> Fixes: f273ad4f8d90 ("RDMA/srp: Remove support for FMR memory registration")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/infiniband/ulp/srp/ib_srp.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index 0f66bf015db6..52db42af421b 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -1009,12 +1009,13 @@ static int srp_alloc_req_data(struct srp_rdma_ch *ch)
>   
>   	for (i = 0; i < target->req_ring_size; ++i) {
>   		req = &ch->req_ring[i];
> -		mr_list = kmalloc_array(target->mr_per_cmd, sizeof(void *),
> -					GFP_KERNEL);
> -		if (!mr_list)
> -			goto out;
> -		if (srp_dev->use_fast_reg)
> +		if (srp_dev->use_fast_reg) {
> +			mr_list = kmalloc_array(target->mr_per_cmd,
> +						sizeof(void *), GFP_KERNEL);
> +			if (!mr_list)
> +				goto out;
>   			req->fr_list = mr_list;
> +		}
>   		req->indirect_desc = kmalloc(target->indirect_size, GFP_KERNEL);
>   		if (!req->indirect_desc)
>   			goto out;

Looks good,

maybe we can remove the local mr_list variable while we're here ?

otherwise,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

