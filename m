Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37130300C7B
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 20:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbhAVTW7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jan 2021 14:22:59 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2255 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbhAVS6T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jan 2021 13:58:19 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600b20170001>; Fri, 22 Jan 2021 10:57:27 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Jan
 2021 18:57:21 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 22 Jan 2021 18:57:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZN4AqDMxAGH6RPDzE9w2HYOBAVlh1aNnDgaejNK5+dw4lE5F9u2V6W1hBj0gva7ZcPUVpAiIf2i4AmI2ach3xwsp1YXcsMPmHF6WCxldpzjs0rrpvlV8WNynJaqqejb5vpgkXN7oDR9h5QTdlmYEWzeaBf8BGAJ7PimtD+Tx82H0Qf29gXZo2hz+10AgcOUp0V7ePrAXwGF0HC1AN9cjgYCeryyDKjXvnddhJ/KjpgBZAn43LPOVfSuCyzALxjNjRR0fInxWX7XUYXD72fJjAk0Y5KObYzQcXHD1iXldB2rnxKt2pI6d7oH0xk+eW2DwFnsMyQgziLu/FcxubXWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sf5dhX/C5DT4ULabu3uJ8qk3toVopqtGgKx32Qm2tw=;
 b=G/RlXyAClQ/7nnJ7zTZKDUl6Eot4ACRR1+oSpZsWbCK+yuUtn0FKB285oTChWeQHn/HBhkrTVwXxTA5d20x632KNQbYKwAx7UVxJM0rHwtgD71VAP5+TT/vtW2uJhWQAH5BbC0VO3xRCTSIPaA6DL16NVIVg+Xlbj+/Ee6Fhhmv+ZCJU/o9WdvCE4nY739SRPhgSVUdNCFnPtedAeJkWyBBwNKTBbOjuQpmJkyy24NnfDL45RMnLenu2ryObOcB7hUvSWJAmGi8SrKr/QzaQFqBtLCiyMVfC8McnLUoAOYH4M/VGW6IpmTHpvESW+mo7mLwbLHJCYS2C7uxwfngjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3929.namprd12.prod.outlook.com (2603:10b6:5:148::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 18:57:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Fri, 22 Jan 2021
 18:57:19 +0000
Date:   Fri, 22 Jan 2021 14:57:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        Intel <ibsupport@intel.com>, Leon Romanovsky <leon@kernel.org>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Nenglong Zhao <zhaonenglong@hisilicon.com>,
        Weihang Li <liweihang@huawei.com>,
        Wei Hu <xavier.huwei@huawei.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH 00/30] [Set 2] Rid W=1 warnings from Infiniband
Message-ID: <20210122185718.GA1331430@nvidia.com>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
X-ClientProxiedBy: MN2PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:208:15e::48) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR17CA0035.namprd17.prod.outlook.com (2603:10b6:208:15e::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Fri, 22 Jan 2021 18:57:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l31cU-005bMf-0l; Fri, 22 Jan 2021 14:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611341848; bh=1sf5dhX/C5DT4ULabu3uJ8qk3toVopqtGgKx32Qm2tw=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=YbBAnVfT9YiU6TcCE1LZ1CNNyFtOE7fA/1NAes+hYDFJzr+b4v23+d+FOQOp3WPuf
         Vc6h7jsIhkW6JfCc/Wz04HPfOtlFSclzmHmCuBar/7Ti9TRUyy4UicVSS8vBsb3+tZ
         /ll2gh+3PKWe2Wc4wo4YvsNzx3wo/CKAsvjkUo+EZn7Nx623UfrpSsyJNQM9TkB6XV
         YFQcYZYYWyH7yEmNxIUyXCWJwukJ4LbfVsFRyqH45XRt7uLZbVC7SQFI5PRjX+23sy
         1HvWH+WpqQZKGue8IgMfhEiKzMG+w1AtFAlHrJFRCdfTPru33Hb7xe97tLOsrgFSUI
         RIkJA5j5Mq/Kg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 21, 2021 at 09:44:49AM +0000, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> This is set 2 of 3 (hopefully) sets required to fully clean-up.
> 
> Lee Jones (30):
>   RDMA/hw/mlx5/odp: Fix formatting and add missing descriptions in
>     'pagefault_data_segments()'
>   RDMA/hw/mlx5/qp: Demote non-conformant kernel-doc header
>   RDMA/hw/efa/efa_com: Stop using param description notation for
>     non-params
>   RDMA/hw/hns/hns_roce_hw_v1: Fix doc-rot issue relating to 'rereset'
>   RDMA/hw/hns/hns_roce_mr: Add missing description for 'hr_dev' param
>   RDMA/hw/qib/qib_driver: Fix misspelling in 'ppd's param description
>   RDMA/sw/rdmavt/vt: Fix formatting issue and update description for
>     'context'
>   RDMA/hw/qib/qib_eeprom: Fix misspelling of 'buff' in
>     'qib_eeprom_{read,write}()'
>   RDMA/hw/qib/qib_mad: Fix a few misspellings and supply missing
>     descriptions
>   RDMA/hw/qib/qib_intr: Fix a bunch of formatting issues
>   RDMA/hw/qib/qib_pcie: Demote obvious kernel-doc abuse
>   RDMA/hw/qib/qib_qp: Fix some issues in worthy kernel-doc headers and
>     demote another
>   RDMA/sw/rdmavt/cq: Demote hardly complete kernel-doc header
>   RDMA/hw/qib/qib_rc: Fix some worthy kernel-docs demote hardly complete
>     one
>   RDMA/hw/hfi1/chip: Fix a bunch of kernel-doc formatting and spelling
>     issues
>   RDMA/hw/qib/qib_twsi: Provide description for missing param 'last'
>   RDMA/hw/qib/qib_tx: Provide description for
>     'qib_chg_pioavailkernel()'s 'rcd' param
>   RDMA/hw/qib/qib_uc: Provide description for missing 'flags' param
>   RDMA/hw/qib/qib_ud: Provide description for 'qib_make_ud_req's 'flags'
>     param
>   RDMA/sw/rdmavt/mad: Fix 'rvt_process_mad()'s documentation header
>   RDMA/hw/qib/qib_user_pages: Demote non-conformant documentation header
>   RDMA/sw/rdmavt/mcast: Demote incomplete kernel-doc header
>   RDMA/hw/hfi1/exp_rcv: Fix some kernel-doc formatting issues
>   RDMA/hw/qib/qib_iba7220: Fix some kernel-doc issues
>   RDMA/hw/hfi1/file_ops: Fix' manage_rcvq()'s 'arg' param
>   RDMA/sw/rdmavt/mr: Fix some issues related to formatting and missing
>     descriptions
>   RDMA/hw/qib/qib_iba7322: Fix a bunch of copy/paste issues
>   RDMA/hw/qib/qib_verbs: Repair some formatting problems
>   RDMA/hw/qib/qib_iba6120: Fix some repeated (copy/paste) kernel-doc
>     issues
>   RDMA/sw/rdmavt/qp: Fix a bunch of kernel-doc misdemeanours

Applied to for-next, thanks

Jason
