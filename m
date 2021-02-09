Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B59F315723
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 20:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbhBITrL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Feb 2021 14:47:11 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16345 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbhBITpD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Feb 2021 14:45:03 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6022e6040001>; Tue, 09 Feb 2021 11:44:04 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 19:44:03 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 19:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO8I+bwqJFrh9NsqhJFdHd10uo9en5iP9BnSUeAn6j+f3URNwDaYgQXc2NYn3ZTLvUifAvg3lVZx/EGM3/NYTPi5PrrHls/fAcLNYj0s4kNcicfEq//GOXS3UJpFhtl/eiJVfJGyUCgM7LqEFybsz7sYQUL6k4MHUwc7nvPzOiZDhSlGQcMU1nA1jC6kpmQBcFmTGfCr5qx58tMKcZpuYZXR+SBepLhTIOlehrcwvDX4WLBH7I7UHpYeFrJfSWN4GM99sN8BcRt3uvM2iXYxkYTJRC1E1/pghu/B46EHP+4gb2fqXSGgNCsKloDifop+6QuQUG5tZCwA5xTLHaWyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qUysj96tkoRFlgyEFs6EJOpWdHhGSL2D6ciZBE9NWI=;
 b=LnhlopBL0LnDve3he+DLBQKryKRl3REBuI1PBn/IuY2ZqmFzXf6nlxhzuEbUr2uNCsW22FBr11LuyEGA6eau6e3Z7KbVIOnwVjmFiwKhn6OF9mksfUAgAUy3Qdv83J63j+kqzheMyRys3JghQ4vqGW4w6a1FAMjOF4ZMmveBCWEbSYkQE68kWbV3tMAGKXz7WT70sChX6WDlWDWSsqJ9Bf48SHXIIP7UDZHOv91GIz17dQHQZqpQSqm6RxiaZlglZrU36PNVFJabXAfocmx0B4lz2ebXNx8sLjcNjIEKFx12G+qBdTUvLHS3gm7FkAZebXGvd2DMVMVUIhS2cLNd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Tue, 9 Feb
 2021 19:44:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 19:44:02 +0000
Date:   Tue, 9 Feb 2021 15:44:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <leon@kernel.org>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH RFC rdma-core 2/5] libhns: Introduce DCA for RC QP
Message-ID: <20210209194400.GS4247@nvidia.com>
References: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
 <1612667574-56673-3-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1612667574-56673-3-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0368.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0368.namprd13.prod.outlook.com (2603:10b6:208:2c0::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Tue, 9 Feb 2021 19:44:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9YvY-005cU4-W8; Tue, 09 Feb 2021 15:44:01 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612899844; bh=4qUysj96tkoRFlgyEFs6EJOpWdHhGSL2D6ciZBE9NWI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=pS2XNbyjnVkXDG3mlHEud+7JfyPVaulFoJfA6LMIIZDq3zhQjinI7NrqfMwn37YLL
         dVl8ptBx+cdU0aLXiOjYWtHdofk26/T++DVFZZkO2OkY4OJVItB7gBHfHxQpr7FhFT
         zFAmaPPa2kEBjwz8UFO/Gn8dECIvDAZNl7Ti14DOFXWdnQBkM7eu2alpXfwdPKVxUs
         2YHkKA8kmpRo52QTz6OmhYwFOhGCZlbAN3da06kFFWK2Mn7V3UJ3uU1K+SBWQBZkcb
         deyf8uuUFErHe9EZ1oou9j098bSrE+6FUWZuBZV/Vu76OA2zBOJI8z9I6ILT9PTo1w
         KBeDMdr+knS+Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 07, 2021 at 11:12:51AM +0800, Weihang Li wrote:

> +static int register_dca_mem(struct hns_roce_context *ctx, uint64_t key,
> +			    void *addr, uint32_t size, uint32_t *handle)
> +{
> +	struct ib_uverbs_attr *attr;
> +	int ret;
> +
> +	DECLARE_COMMAND_BUFFER(cmd, HNS_IB_OBJECT_DCA_MEM,
> +			       HNS_IB_METHOD_DCA_MEM_REG, 4);
> +	fill_attr_in_uint32(cmd, HNS_IB_ATTR_DCA_MEM_REG_LEN, size);
> +	fill_attr_in_uint64(cmd, HNS_IB_ATTR_DCA_MEM_REG_ADDR, (intptr_t)addr);

This should use ioctl_ptr_to_u64(), the place this was copied from
should also be fixed


> +	fill_attr_in_uint64(cmd, HNS_IB_ATTR_DCA_MEM_REG_KEY, key);
> +	attr = fill_attr_out_obj(cmd, HNS_IB_ATTR_DCA_MEM_REG_HANDLE);
> +
> +	ret = execute_ioctl(&ctx->ibv_ctx.context, cmd);
> +	if (!ret)
> +		*handle = read_attr_obj(HNS_IB_ATTR_DCA_MEM_REG_HANDLE, attr);

Success oriented flow everywhere please

Jason
