Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A71266931
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Sep 2020 21:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgIKTw1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Sep 2020 15:52:27 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8692 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgIKTwZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Sep 2020 15:52:25 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5bd56c0000>; Fri, 11 Sep 2020 12:52:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 11 Sep 2020 12:52:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 11 Sep 2020 12:52:25 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Sep
 2020 19:52:24 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 11 Sep 2020 19:52:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNRAYT52CDDTNqSV4hYpvuScHtcL6vmQMIB8HcCAI/yIwC8Rq40dwTe1FhUCbjAza2caJS5UOFBi/XLQwGMmKwnONB2cM365/Jj8XQKHM9RLUfC7rqHQdItTMrluJbz2HRfZpmPeji2OQyxzFhc87Z0Qu6nO+6A/EfWuf/xz0aspvRueYuZhpj6xcbs8C7JT4FwJWVkuTMfMg48/fNt41yLdmyCbDP19hrhkyVFnJ9ttuM4rrOwYNNzlveKT0bRqFfI5pe2dToNpq4zpgYaXPIR/3RH/UFb1KT2i0kJj1lBHtEPMNwsZr8FZZ7F3lTCPKn1dxMURpCR+uI1pVrKrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuvmNcjGJnjAwwH2h+aTVXgSADstCPrupKjvmYY1ITs=;
 b=jD1uU9Bp5I1MN01e1FJSkcZAtesOUswicQQZg97XxKVdoYinWMLxqiIx8g1UCSJVoR33GLYG/GbbelEn4QSHcrxBc6yadUs8APWcwyQCsqmuBQVeeH906pAnyqcx1/xt8AxF8DzTtezidA6sVfE9SaiQGn6+vrnBVSt2tGa1hKNggJPr/fYFhW6sJixzQC2ZgXc15v30f2FjvRfmKyhUbUj3l0Q9DEf1kl0Qr5kaZxdHjMLW1ZJnrGQyoYJmsdYuYCHEIds5VkynBgzqV0yxWg/YdabOUscVDUw9qj6qBtEcQKiboA/ajWX3gRJHlVaLiZqiDquqYQ6BcD+QmX0LrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 19:52:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 19:52:23 +0000
Date:   Fri, 11 Sep 2020 16:52:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 3/4] RDMA/core: Introduce new GID table query
 API
Message-ID: <20200911195221.GS904879@nvidia.com>
References: <20200910142204.1309061-1-leon@kernel.org>
 <20200910142204.1309061-4-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200910142204.1309061-4-leon@kernel.org>
X-ClientProxiedBy: MN2PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:208:15e::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0015.namprd17.prod.outlook.com (2603:10b6:208:15e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 19:52:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kGp5p-0059zN-BL; Fri, 11 Sep 2020 16:52:21 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb28b715-3425-48ad-20b4-08d8568c332a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3739:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3739D80F2C41DA30E86906BCC2240@DM6PR12MB3739.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbvmZxqqbNpexNZbDGSXBF8ZMa3P1t395ki7VtyblDxZh+cDeJpGmsg72af9DfJ2hI+5rSlF7lIDf19Z2NI855pMLn5IpeKjLRx1g8lHKoc8+clQycd7/lxhTCx6z+6zRUVVAp0kg9TeQrlK67aIb6nao9rNlF9TmmEhviPdq2PGntc9dNJYRD+iT1i1EBEzpr/EWJoQNnWEcyu+ztaGlKGyNDFphvpPoUupXevfI61i847Xrvcx/I6udzjW2tWh4UuLmapI+rVbAf1a8lxmOc2QvbgixLdlpHzMZOi/S8B0mRzaOiwC0xBuUY4QWQnw5ahD5yFr1FqI6W7f2LkGtkAXbJWBQkk9M11NlQrChinIhzeInS8wdFkBMiIdUXXj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(186003)(9746002)(5660300002)(1076003)(66556008)(8936002)(9786002)(66946007)(66476007)(83380400001)(4326008)(33656002)(26005)(316002)(478600001)(426003)(36756003)(6916009)(54906003)(2906002)(86362001)(8676002)(2616005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zGi9BknHsyWRdqHgEZjGs22is4Kh8WyKOSrII3Xy3atRyq8Z9CFNi9EPI3jZbGhJz+Q5dTacskYIH4QaxneDUE0ZEInbYnreSJXOcy6h5Yu5DN+p/YEGsxVXL8eadIwNqyvbmwBseCzeo13fDJjlH0rVTw8lJC6BWL44OBci9fkIu+eQRCQrRJ68i2LPO5tgIbnhWMA40c1HzEyF4lCzdvuD36fMGr0uttifcCtnkngi0kxhEwPeDZXTepojMt/j73j16fX4bP9bIPOQlPOv7OctqGeLa7/T/Ph0RGWQeUDMBOEZgIEcmkZYxrnUeTzX+OBFAmBmwc9Y4CCR9PmH2J04tTFOKE67kS2bVjWKKutpsdERzUgQ/E8zhLADnmLUcz2E1T/0gAuGYhTJZ9Wf5UPpwihogwXZYO8K8845NqkyhnDigJcDev08rUVJARs/XMzDmRHbJWKpFiu7zHAV2umhqLNfKMc84GoxBGwCLM+2rkFAmU1Fx/w4ATby1Tp5enrhYiVYGgB7dowMjb4IPExFy0Ed0Nq3TfmV2a0PsDbCRgTah8yqwgdBLhbhm6FtBhbhm5E+xmioCG+qPBKsMzzRFzaGfa6X8Auo8EAvNYkbsCRmLvnLjALzom2JdSVAeaou3fH1r1RQMGbVHRUHww==
X-MS-Exchange-CrossTenant-Network-Message-Id: eb28b715-3425-48ad-20b4-08d8568c332a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 19:52:22.9372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7HdkEULJSlcSQqL5BESsSeVB88nfHSVfO8HDTH0D9B0xbieJwbcnIURPLxgObmG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3739
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599853932; bh=KuvmNcjGJnjAwwH2h+aTVXgSADstCPrupKjvmYY1ITs=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
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
        b=H80fgu0eTRBwkMrF6T/Q7HT3a4qmRgu6pTfdadqvMgQtu83Ym4jf+YX7oAFljZJWa
         7/bH7AprUP0WfCIhv8J4FPok7FFJnpxl8Ozgi1bnGJIwFNGzw2pwNLt01XAJ0pzvgq
         qqI5GOtNNl6gTZbPosmF5g2XcE2yDlm9bzh+iiNRl0VQraQtTON3g59PjWbpgfSF0r
         9nL2Yr5If2ZJJea7YSksdEyg5GP6kut2g/f6rwwP6D/cnlsKH9m3Ws0UMPU03+Ka33
         OdedtIdUG6uQBlTpUtbHFpv8LD/M9HMCNJivn+FEgNCnbA/0XxxCqHJPAcVKBXVhMH
         pcWnnen3nubXw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 10, 2020 at 05:22:03PM +0300, Leon Romanovsky wrote:
> From: Avihai Horon <avihaih@nvidia.com>
> 
> Introduce rdma_query_gid_table which enables querying all the GID tables
> of a given device and copying the attributes of all valid GID entries to
> a provided buffer.
> 
> This API provides a faster way to query a GID table using single call and
> will be used in libibverbs to improve current approach that requires
> multiple calls to open, close and read multiple sysfs files for a single
> GID table entry.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/core/cache.c         | 93 +++++++++++++++++++++++++
>  include/rdma/ib_cache.h                 |  5 ++
>  include/uapi/rdma/ib_user_ioctl_verbs.h |  8 +++
>  3 files changed, 106 insertions(+)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index cf49ac0b0aa6..175e229eccd3 100644
> +++ b/drivers/infiniband/core/cache.c
> @@ -1247,6 +1247,99 @@ rdma_get_gid_attr(struct ib_device *device, u8 port_num, int index)
>  }
>  EXPORT_SYMBOL(rdma_get_gid_attr);
>  
> +/**
> + * rdma_get_ndev_ifindex - Reads ndev ifindex of the given gid attr.
> + * @gid_attr: Pointer to the GID attribute.
> + * @ndev_ifindex: Pointer through which the ndev ifindex is returned.
> + *
> + * Returns 0 on success or appropriate error code. The netdevice must be in UP
> + * state.
> + */
> +int rdma_get_ndev_ifindex(const struct ib_gid_attr *gid_attr, u32 *ndev_ifindex)
> +{
> +	struct net_device *ndev;
> +	int ret = 0;
> +
> +	if (rdma_protocol_ib(gid_attr->device, gid_attr->port_num)) {
> +		*ndev_ifindex = 0;
> +		return 0;
> +	}
> +
> +	rcu_read_lock();
> +	ndev = rcu_dereference(gid_attr->ndev);
> +	if (!ndev || (READ_ONCE(ndev->flags) & IFF_UP) == 0) {
> +		ret = -ENODEV;
> +		goto out;
> +	}

None of this is necessary to read the ifindex, especially since the
read_lock is being held.

> +/**
> + * rdma_query_gid_table - Reads GID table entries of all the ports of a device up to max_entries.
> + * @device: The device to query.
> + * @entries: Entries where GID entries are returned.
> + * @max_entries: Maximum number of entries that can be returned.
> + * Entries array must be allocated to hold max_entries number of entries.
> + * @num_entries: Updated to the number of entries that were successfully read.
> + *
> + * Returns 0 on success or appropriate error code.
> + */
> +int rdma_query_gid_table(struct ib_device *device,
> +			 struct ib_uverbs_gid_entry *entries,
> +			 size_t max_entries, size_t *num_entries)

return ssize_t instead of the output pointer

> +{
> +	const struct ib_gid_attr *gid_attr;
> +	struct ib_gid_table *table;
> +	unsigned int port_num;
> +	unsigned long flags;
> +	int ret;
> +	int i;

i is unsigned

Jason
