Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57D62702C0
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 19:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIRRAZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 13:00:25 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18332 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRRAY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 13:00:24 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f64e77c0003>; Fri, 18 Sep 2020 09:59:40 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 17:00:24 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 17:00:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVz2RPe3zdX/JoPyWmWVU5er4/q0UdwxPk0KSJJLTsPwrQ+QGsxG32Km8hpSA99KcGexClrAM0ms9GBzGRKr50myQG93Bb68RwDNPHXJQHCuJ7meziXUSknfAnkWLJQBbHi0wd1l/zLYfUtCzIX0v2losOCxKCCYGPTDQoMDV7Y0drsLj0azD/i6WtvQHmKX1aJ4+3jbtH62ofqAdTnslWhw83OrdAECqh+2b087+ihOY57UqIM+ggmWYwKT0pwv0/5wx4OGKnOT6EvC192vgNY4KgYb49ICVDxzXWJ5DB2kaLuGNgYdxCP1fCXisd/+HDK+ft0Zx+ocO967TYA5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz8M5P4rKdnnikpOF6IhLjIAwj/Kc782f9oENHqSBVM=;
 b=WdUq7VU6mCI3dH1KnyoCnieRAdOiGUzgcX3j9fuftANPKUS9MagiVOIPSGCd3nTxJgHwg75KH1OpZ/FZKsrxqHjsgSOux1QXRk2QW/C0fwxVJ+XrOnrunuUEDGlQixYXhzNeJc3gepXnfP1KrZKO4DUFy3Q10xtMv+6bavVglP8m1wGKaroYcVSoDw9KlSJbEWy3ufs6uzjsZJ6SoHHIRicLUG96t6AJ2aZ3YZfuB2XcK+GwiE19g+NF3qDUd8tAaazedyEumxdt1lpQcJ9Ee/ooQaBcBz1gsZXGXoOJKeqVDBfWExK9snHYcdnrjbMq27RrROnFguULi/kWall+Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 17:00:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 17:00:22 +0000
Date:   Fri, 18 Sep 2020 14:00:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 04/14] RDMA/restrack: Count references to
 the verbs objects
Message-ID: <20200918170020.GD3699@nvidia.com>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-5-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907122156.478360-5-leon@kernel.org>
X-ClientProxiedBy: BL0PR1501CA0009.namprd15.prod.outlook.com
 (2603:10b6:207:17::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR1501CA0009.namprd15.prod.outlook.com (2603:10b6:207:17::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Fri, 18 Sep 2020 17:00:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJJkC-001V4U-JD; Fri, 18 Sep 2020 14:00:20 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 199445f7-a901-4ed9-0f6d-08d85bf45451
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34030B3A76D8DC856ADBA8C0C23F0@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uuwbLiGx09YCI14Oo0IigFtfR5KNwy8mMP/W8/39t2oy864nwZuClJUmYtKwozXpYaaYKme5HRSHAoo5WWp8ZqjY2YoXUuQ5gzNNY/PYm4zxQ/FWyZbJ8i2BiJQ+uB5DWR6FIv7s1MOuCUIrSbo6aiwLMdI8xMeRW/KzMAL2duSZh1n4OcGblFzM5wh2Ma6N9OHiSDkMUS/bZW1KieuLNQJ5xOZSakob1So9vjOHMnH4hC7MFFouTMqbF51kAunpZoZ9tKTrfFNL+Ff2rX/T8QTXCxhazbh2x6ykoUtjC/0FjamVU1H7demwfiNo3LtpONd/adIO5lkxgeompNdDqRQTZzFULKLM6EwppENP92RVf7RnhcDW/REpXNMB4Zvp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(86362001)(33656002)(426003)(66946007)(5660300002)(36756003)(478600001)(4326008)(316002)(8676002)(54906003)(6916009)(26005)(2906002)(1076003)(186003)(8936002)(9746002)(66556008)(9786002)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: S7/GFJzzdwoT7JWj+sovX57JJx7og+HhlWvbJEOb5X8KP9KLwPp50j3WqUTpzoMfVV4N/Inr9fMiD8Wy9RQYlglMxz5RalCRRSGDiPZKuD4ztcVUStaHHBJC7dqwbSUPyqr7SW7YCzm/Zy94DsW28gpTmRb3KMXiOvFq8T9iT0WJ91IiVv0nzcrJBWfdVwyFaQBseNsOcSmwKx9Kb92O3VZ1rTWWtc/wbLzqxIw8dPpXazGxgszGESRkep+24fQWTX6AbssZeSTJUmwBIjw+nwmbNLEDtIePNayGOxQEpBLUh4SF6hbOXtqKjc4+D/i2i0WcrWfUNFLSvH5fgjS0z8TQMpEQTLFxpapgLkTBSS9t5v3H4V+1ejgY/gHrZVjNjDMYKiKhvI4hoPkiZDkv6r75+rSQYUCHlPFSiCEQlbe6qD0DGDR5Xu+Rdt/6JRDUoaXvxFAsN95AZ2tANMp+ZNP1/AUD4id83G4doEa9H7jhX1RUiU0v8KAJgdF9wYypWc/zHZpcbUd90kjSyLF0ET26iuIuEh3gMY2lfna1zERqWVoos1NAQcPeGBb+ztpjqUSymh8lMsOLTk6MGx9TZwGamBjQGfK2usAIOByBhjQyoXb6nCg5Z2XuozXK1rKREYR8Ep9OiPKZV6Yc8KJYtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 199445f7-a901-4ed9-0f6d-08d85bf45451
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 17:00:22.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40L+Q6Vd7rjbUlKlwRVyoQKeiUjzkdSg9mu/GrLYDHIxNqOO9RQgK29TyM0j7boh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600448380; bh=Oz8M5P4rKdnnikpOF6IhLjIAwj/Kc782f9oENHqSBVM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=jMYAY5IWvQjXPoPNF06SsZhwyPr0Vq2T/nlTOGIS+ODWhRt3p2CEVhIgHDlJuTkde
         j5JlGzOov9XDQ6lHvpt+/OQIWTFOGSu2azEVopjXRXYrY2SNEhIXLz9Gk1gqbTCJvo
         ukdbakztKxNm21VpKPH9tHPaLdr4HvQ9WqTGBolun4Qg+hubuKU6k3ukP0vIUbIYg2
         6I4RhUAiQAI5Z7s0/rfhlNELjLuM8RsE1f6Uo5LUXhC/nTmxm7HpuQh+btc8QTNRKl
         mywjYuf+NthbLV1Qn+NhgkKjTUSdnu9S6+t02rSC68IKDI4MfXfKMEkdff4E3c1hp1
         fvWQPo6o6pQ2A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 03:21:46PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Refactor the restrack code to make sure that kref inside restrack entry
> properly kref the object in which it is embedded. This slight change is
> needed for future conversions of MR and QP which are refcounted before
> the release and kfree.
> 
> The ideal flow from ib_core perspective as follows:
> * Allocate ib_* structure with rdma_zalloc_*.

Given how things are going it would be good to eventually include the
kref initialization in the allocation:

struct rdma_restrack_entry *_rdma_zalloc_drv_obj_gfp(struct ib_device *ibdev,
						     size_t size,
						     size_t res_offset,
						     gfp_t flags);
{
    struct rdma_restrack_entry res = kzalloc(size, flags) + res_offset;
[..]
    return res;
}

#define rdma_zalloc_drv_obj_gfp(ib_dev, ib_type, gfp)                          \
	container_of(_rdma_zalloc_drv_obj_gfp(                                 \
			     ib_dev, (ib_dev)->ops.size_##ib_type,             \
			     offsetof(struct ib_type, res), gfp),              \
		     struct ib_type, res)

As the idea is every drv_obj will have the kref

The patch looks OK, the rdma_restrack_new calls are all near their
matching allocations

Jason
