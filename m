Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617AF290F99
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Oct 2020 07:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436558AbgJQFsh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 17 Oct 2020 01:48:37 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5654 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411849AbgJQFsh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 17 Oct 2020 01:48:37 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8a3a500000>; Fri, 16 Oct 2020 17:26:56 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 17 Oct
 2020 00:28:20 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 17 Oct 2020 00:28:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCO6hP5KbCBWx1NJlV8ZJnW+tL9fXgPjrvqQJTrnAS16dX41nQ3uHXsQ6ymCYaApyLAX/Wba57+u1LTCJqLTjbFcl3xzVOcr7lIhxbPwtBElTQi2AJohYECvlIu4pAfgaK08WyySNdenhhNhev1yUdUdB5A+4DsC4jp8jNAZZ6Kc+rNJa4r+ouqSq2gMTK5SYD27fiANAmaxX5ueerKIfEj7cgRI3A0VQZpqqoZPWySYmAAJ2ZZhONxvh1mh5XAYn/tc5TxfVgd+bxwvoxuh97be+HwayZ5nukbQCw4YOSR6XOnkeUJGHaBcRbTGagCnC/9RVMVoe1BUCLbhumf21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVE1fw1NI1nwsmeN/2prcO99rO8jINgr985drAaXQ1Q=;
 b=frzAfHPHGkUCet+ArUfPUPVYHZVzmWUdnzQ0iEcf4TvY6A3BqivXyxzEVpIXe0UnLWAJodLBC2NTBaqUkaoRkECdQNxXkeQuax4JDeTkpCHE8CWw7JlwULM3QDF+p4JoXwvPZZTQQjuSbfvMcJhHbl+Wx+NJCu0EExPXjvmOtoHn87miiW+Pc0cBvMVBXvuIvHJKcd8HgTkOCu321epHraH6s1FBpqL6FYgkxrsVQA/OQ5u2NTQ0NAjp/ZoZesptvKTvVq/V50ECwMvWUxxcs4njhMBWgu7t8ZKos+SK65RZbWknqx0ngAOMHRWxkOA8AWChpTs7GdS4PueZGGZAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2857.namprd12.prod.outlook.com (2603:10b6:5:184::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.27; Sat, 17 Oct
 2020 00:28:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.027; Sat, 17 Oct 2020
 00:28:18 +0000
Date:   Fri, 16 Oct 2020 21:28:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
CC:     <linux-rdma@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        "Doug Ledford" <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Sumit Semwal" <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v5 1/5] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201017002816.GA334909@nvidia.com>
References: <1602799365-138199-1-git-send-email-jianxin.xiong@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1602799365-138199-1-git-send-email-jianxin.xiong@intel.com>
X-ClientProxiedBy: MN2PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:208:234::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:208:234::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23 via Frontend Transport; Sat, 17 Oct 2020 00:28:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kTa52-001PEr-Lz; Fri, 16 Oct 2020 21:28:16 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602894416; bh=iVE1fw1NI1nwsmeN/2prcO99rO8jINgr985drAaXQ1Q=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=SKeGzT4j5o/zTDon5qq8GsoUb5KfMblmN/zeQDD+OhmVKEQHpdxAoDeOYDkonRgIX
         0P8SEUNrmszeVvPzf0HAoA8MSI/9+G5XDYDS1s3AHy9sG3vvMfhI2tcRX1frTkLXIc
         52USzEkEqlwNCT/SnVm30CG1kLhgrhOS/8yTbcxCherqLkeRLpZQlno20Dy4VuB9pa
         o7af+/s/Gx1GDrw4HKVe0hi3I73Hhqq8dzU3IXfHbbuCcugMmyX5SBZBXVtVMJf07t
         Q6GyhSX+pvEtCQQPaJokuvudAtHRRClTUJkiDHvpOR4lhNbjYh/DsBrWdHp8h8apmp
         2tMLRZgi3ZUGw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 15, 2020 at 03:02:45PM -0700, Jianxin Xiong wrote:
> +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> +				   unsigned long addr, size_t size,
> +				   int dmabuf_fd, int access,
> +				   const struct ib_umem_dmabuf_ops *ops)
> +{
> +	struct dma_buf *dmabuf;
> +	struct ib_umem_dmabuf *umem_dmabuf;
> +	struct ib_umem *umem;
> +	unsigned long end;
> +	long ret;
> +
> +	if (check_add_overflow(addr, (unsigned long)size, &end))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (unlikely(PAGE_ALIGN(end) < PAGE_SIZE))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (unlikely(!ops || !ops->invalidate || !ops->update))
> +		return ERR_PTR(-EINVAL);
> +
> +	umem_dmabuf = kzalloc(sizeof(*umem_dmabuf), GFP_KERNEL);
> +	if (!umem_dmabuf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	umem_dmabuf->ops = ops;
> +	INIT_WORK(&umem_dmabuf->work, ib_umem_dmabuf_work);
> +
> +	umem = &umem_dmabuf->umem;
> +	umem->ibdev = device;
> +	umem->length = size;
> +	umem->address = addr;

addr here is offset within the dma buf, but this code does nothing
with it.

dma_buf_map_attachment gives a complete SGL for the entire DMA buf,
but offset/length select a subset.

You need to edit the sgls to make them properly span the sub-range and
follow the peculiar rules for how SGLs in ib_umem's have to be
constructed.

Who validates that the total dma length of the SGL is exactly equal to
length? That is really important too.

Also, dma_buf_map_attachment() does not do the correct dma mapping for
RDMA, eg it does not use ib_dma_map(). This is not a problem for mlx5
but it is troublesome to put in the core code.

Jason
