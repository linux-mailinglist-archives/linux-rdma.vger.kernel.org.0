Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905C93B3C5C
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 07:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhFYFvj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 01:51:39 -0400
Received: from mail-mw2nam12on2062.outbound.protection.outlook.com ([40.107.244.62]:41377
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230097AbhFYFvi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 01:51:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwAac1KT+UlK2EEnmHss44KsQssWgrv76oc2tA4ERvKapzyueMGDTQLr3UUXRIWzi+9g4qMvaskCwBekU3GosdbmWIW2Xr/qG+4UQcecf3XBgZIVwhBu+gi6Qf3f6xImuYCuI5nZyTc8fBiOgpHzbRJVQZIzJCOYFYAGjz/wgUoJvduvWBczYmNmknQrgmmAmFgkO2zf1yTLvf58VVHXl/l5TeV9T+GOOSct9T1br1SOkC04NwujVS6KS9JKG2l7Bc8+NhIQmvNCWouHK0hKeoApKCyefEPvTDGX4yZTK68axa/htJG014CjrJPA25eucUJvEr8+tIsG68f/WvznTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glQBqfFn5e0hJMren1onhreOyLiWZ38qVt3L81oo7RQ=;
 b=Ou4G8puOqZDUEfyyYSQDrIrNq8UjVKj+v0LWFyUPxha64vTNqbjUuj/16D7CGBog5zjTGyUh3H6Fzo7tUPo1HfRWTmVfAlG0Dy4V4ohWtxyy5qLuo0gZjIj0IJW20noREI6pAsTamKg7lsL5u+4I2xlxiMTkS1Nb2cqTwJW0IHTY5t4FqZJwvI3lh5af6IaIW01We16XWHW4iq78nlGs0kEOyDLZQu5aNUf8NpdrIKo7SWw0NiP/IlgBCx1h937IXrgCV0dbN5DvL06A3pBhHZc/qs6EO2GO12r8h0hEkwJLwlksqT0xEGd6j+vGW6HiJn/4YCOAt+AmKqZVw4TvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glQBqfFn5e0hJMren1onhreOyLiWZ38qVt3L81oo7RQ=;
 b=WIzh7tAJ83QEfwg64vjc6ZrOnbaCmghyEtT4+nFQqwUow0Ic3ifsTGEa0KPsYF+/1SJBBULZ9nO2yzrcBHUVg6RPkVPeruZgXdWJy6PXSer4OiZ/k84ubaNLY3Y2raemh63GEmSAYflliGnbRkTmzliK1YhLk4sS/kseB7MVMOs7Ee+8qkWunCoQDcViPDOEgrTocVXJvtJXacPyyXdfiXwsC+O2SKlqXaRybMNut/RSzy9GeRNJojzSXZEliqZrhHqAXckFFisUygimaPMj08H1/rsdPs0dN2u2ZWK9R8Mywa7BXZMjYD5KjDt2eE09NqyE22u6a6H/UPzFNyAEww==
Received: from MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::9) by
 DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.20; Fri, 25 Jun 2021 05:49:16 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::e7) by MW4P223CA0004.outlook.office365.com
 (2603:10b6:303:80::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Fri, 25 Jun 2021 05:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 05:49:15 +0000
Received: from [172.27.8.104] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 25 Jun
 2021 05:49:13 +0000
Subject: Re: [PATCH 1/1] RDMA/cma: Fix rdma_resolve_route memory leak
To:     Gerd Rausch <gerd.rausch@oracle.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <f6662b7b-bdb7-2706-1e12-47c61d3474b6@oracle.com>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <27a35a75-813d-ef1e-c9ca-d4ecbc5a95d2@nvidia.com>
Date:   Fri, 25 Jun 2021 13:49:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f6662b7b-bdb7-2706-1e12-47c61d3474b6@oracle.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f7d3e5e-fb4d-4335-62b9-08d9379cf7a7
X-MS-TrafficTypeDiagnostic: DM8PR12MB5429:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5429B8E6524E1D3094CA44CAC7069@DM8PR12MB5429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zlCxEhiezojSA+8nfXEg0kFWo5QrgDL8HefavOTPuJgFeSYICpb8d9g3QWVpTV0azYOI76MKizWKHTudd66XnU9aZbK9NZLgg/2gibbas9mwbn7b3ngQjJfEGZY7xh1lE5lZPrAvMP0u7lFWf1vYvW478xe1eGsYYX7F4tzDWc+8HPKaTyZCe3W3YpEHdzIrBaz29UxDJtbsFMM7piAD0405m/YWIiQurVS4QPttPo0K1mn5YwkzLTADlji3BnckkDW0ARW4MOCzCfD9mB3uiwPjDKAii6+qUEvMMo3a7M3lZ1e0HydD8G+o/6x9syTyMAs+ejoba/Y8x+z6R2qJS09vEFXq9ybwCJvwHuxch5VYwTDyzWYCrZ7qLqtgCnVHdZC8eWFwYdUlTb/IOay4xPeev+1lSWPs7R6qMMKF9ko8U/kQizRj1udz53dPO9Rg5n4TwQhYlapzLJ8TOYcDhVg604l13yUp+dTVvtsa1+SKX0iXMqJaYdz3VkJqXH3etjYxShb9jYgWxFf8YlszYX7/qjEk9i1HH0jUb9mYkp0qZaWxnIbMBQ6hgG654dbkrkC/dH1t2JH5wPn4Xe2zTkIYXo4CJbheUQGchvMfLfsztaaQouPK8uauzewHdRuR3lprBCKpbSZCpnbagQ33Zrf1qje/ogwkKoXUFXzxq4E4z9tLIpor9bDtPismYvx
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(2616005)(16576012)(47076005)(7636003)(82740400003)(316002)(426003)(356005)(336012)(478600001)(36756003)(4744005)(5660300002)(36860700001)(86362001)(26005)(8936002)(82310400003)(31686004)(110136005)(31696002)(8676002)(70586007)(53546011)(186003)(70206006)(83380400001)(16526019)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 05:49:15.7584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7d3e5e-fb4d-4335-62b9-08d9379cf7a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/25/2021 2:55 AM, Gerd Rausch wrote:
> Fix a memory leak when "rmda_resolve_route" is called
> more than once on the same "rdma_cm_id".
> 
> Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
> ---
>   drivers/infiniband/core/cma.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index ab148a696c0c..4a76d5b4163e 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -2819,7 +2819,8 @@ static int cma_resolve_ib_route(struct rdma_id_private *id_priv,
>   
>   	cma_init_resolve_route_work(work, id_priv);
>   
> -	route->path_rec = kmalloc(sizeof *route->path_rec, GFP_KERNEL);
> +	if (!route->path_rec)
> +		route->path_rec = kmalloc(sizeof *route->path_rec, GFP_KERNEL);
>   	if (!route->path_rec) {
>   		ret = -ENOMEM;
>   		goto err1;

If route->path_rec does exist (meaning this is not the first time 
called), then it would be freed if cma_query_ib_route() below is failed, 
is it good?
