Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3858D7A890
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 14:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfG3MdZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 08:33:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:63565 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfG3MdZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 08:33:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 05:33:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,326,1559545200"; 
   d="scan'208";a="162564110"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.201.104]) ([10.254.201.104])
  by orsmga007.jf.intel.com with ESMTP; 30 Jul 2019 05:33:22 -0700
Subject: Re: [PATCH for-next 00/13] Updates for 5.3-rc2
To:     Lijun Ou <oulijun@huawei.com>, dledford@redhat.com, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
References: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <648dafeb-1922-b1d0-a2da-dc2844a1b426@intel.com>
Date:   Tue, 30 Jul 2019 08:33:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/30/2019 4:56 AM, Lijun Ou wrote:
> Here are some updates for hns driver based 5.3-rc2, mainly
> include some codes optimization and comments style modification.
> 
> Lang Cheng (6):
>    RDMA/hns: Clean up unnecessary initial assignment
>    RDMA/hns: Update some comments style
>    RDMA/hns: Handling the error return value of hem function
>    RDMA/hns: Split bool statement and assign statement
>    RDMA/hns: Refactor irq request code
>    RDMA/hns: Remove unnecessary kzalloc
> 
> Lijun Ou (2):
>    RDMA/hns: Encapsulate some lines for setting sq size in user mode
>    RDMA/hns: Optimize hns_roce_modify_qp function
> 
> Weihang Li (2):
>    RDMA/hns: Remove redundant print in hns_roce_v2_ceq_int()
>    RDMA/hns: Disable alw_lcl_lpbk of SSU
> 
> Yangyang Li (1):
>    RDMA/hns: Refactor hns_roce_v2_set_hem for hip08
> 
> Yixian Liu (2):
>    RDMA/hns: Update the prompt message for creating and destroy qp
>    RDMA/hns: Remove unnessary init for cmq reg
> 
>   drivers/infiniband/hw/hns/hns_roce_device.h |  65 +++++----
>   drivers/infiniband/hw/hns/hns_roce_hem.c    |  15 +-
>   drivers/infiniband/hw/hns/hns_roce_hem.h    |   6 +-
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 210 ++++++++++++++--------------
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   2 -
>   drivers/infiniband/hw/hns/hns_roce_mr.c     |   1 -
>   drivers/infiniband/hw/hns/hns_roce_qp.c     | 150 +++++++++++++-------
>   7 files changed, 244 insertions(+), 205 deletions(-)
> 

A lot of this doesn't seem appropriate for an -rc does it?

-Denny
