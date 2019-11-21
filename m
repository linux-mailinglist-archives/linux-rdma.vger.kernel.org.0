Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC62105C21
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 22:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfKUViZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 16:38:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:1852 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfKUViZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 16:38:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 13:38:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,227,1571727600"; 
   d="scan'208";a="407351522"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga005.fm.intel.com with ESMTP; 21 Nov 2019 13:38:25 -0800
Date:   Thu, 21 Nov 2019 13:38:24 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next v1 03/48] RDMA/ucma: Mask QPN to be 24 bits
 according to IBTA
Message-ID: <20191121213824.GA13840@iweiny-DESK2.sc.intel.com>
References: <20191121181313.129430-1-leon@kernel.org>
 <20191121181313.129430-4-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121181313.129430-4-leon@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index 0274e9b704be..57e68491a2fd 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -1045,7 +1045,7 @@ static void ucma_copy_conn_param(struct rdma_cm_id *id,
>  	dst->retry_count = src->retry_count;
>  	dst->rnr_retry_count = src->rnr_retry_count;
>  	dst->srq = src->srq;
> -	dst->qp_num = src->qp_num;
> +	dst->qp_num = src->qp_num & 0xFFFFFF;

Isn't src->qp_num coming from userspace?  Why not return -EINVAL in such a
case?

Ira

