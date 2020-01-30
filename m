Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDEE414DE67
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 17:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgA3QIf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 11:08:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:41069 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbgA3QIe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jan 2020 11:08:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 08:08:34 -0800
X-IronPort-AV: E=Sophos;i="5.70,382,1574150400"; 
   d="scan'208";a="222833785"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.205.187]) ([10.254.205.187])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jan 2020 08:08:33 -0800
Subject: Re: [PATCH for-next] RDMA/providers: Fix return value when QP type
 isn't supported
To:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20200130082049.463-1-kamalheib1@gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <e3e1faaa-eb9d-69f8-1752-8d3acfe547e3@intel.com>
Date:   Thu, 30 Jan 2020 11:08:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130082049.463-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/30/2020 3:20 AM, Kamal Heib wrote:
> The proper return code is "-EOPNOTSUPP" when the requested QP type is
> not supported by the provider.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>   drivers/infiniband/hw/bnxt_re/ib_verbs.c     | 2 +-
>   drivers/infiniband/hw/cxgb4/qp.c             | 2 +-
>   drivers/infiniband/hw/hns/hns_roce_qp.c      | 2 +-
>   drivers/infiniband/hw/i40iw/i40iw_verbs.c    | 2 +-
>   drivers/infiniband/hw/mlx4/qp.c              | 2 +-
>   drivers/infiniband/hw/mlx5/qp.c              | 2 +-
>   drivers/infiniband/hw/mthca/mthca_provider.c | 2 +-
>   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  | 2 +-
>   drivers/infiniband/hw/qedr/verbs.c           | 2 +-
>   drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 +-
>   drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c | 2 +-
>   drivers/infiniband/sw/rdmavt/qp.c            | 2 +-
>   drivers/infiniband/sw/siw/siw_verbs.c        | 2 +-
>   13 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

