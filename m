Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BC546521
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 18:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfFNQzf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 12:55:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:50969 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfFNQze (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 12:55:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 09:55:34 -0700
X-ExtLoop1: 1
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.201.194]) ([10.254.201.194])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2019 09:55:33 -0700
Subject: Re: [PATCH for-next 0/9] IB/hfi1: Updates for 5.3
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
References: <20190614162724.44714.22604.stgit@awfm-01.aw.intel.com>
Message-ID: <b1fbc081-4647-9759-c730-71aa20f03e01@intel.com>
Date:   Fri, 14 Jun 2019 12:55:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614162724.44714.22604.stgit@awfm-01.aw.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/14/2019 12:27 PM, Dennis Dalessandro wrote:
> This is the first round of fixes and updates for 5.3. There are some bugs but
> nothing that really warranted making its way to RC. So this can all go to
> next. Of note there is a patch for a fix Jason requested.
> 
> ---
> 
> Dennis Dalessandro (1):
>        IB/hfi1: No need to use try_module_get for debugfs
> 
> Kamenee Arumugam (1):
>        IB/{hfi1,qib,rdmavt}: Put qp in error state when cq is full
> 
> Michael J. Ruhl (4):
>        IB/rdmavt: Set QP allowed opcodes after QP allocation
>        IB/{rdmavt, hfi1, qib}: Remove AH refcount for UD QPs
>        IB/{rdmavt, hfi1, qib}: Add helpers to hide SWQE WR details
>        IB/hfi1: Reduce excessive aspm inlines
> 
> Mike Marciniszyn (3):
>        IB/hfi1: Add missing INVALIDATE opcodes for trace
>        IB/rdmavt: Enhance trace information for FRWR debug
>        IB/rdmavt: Add trace for map_mr_sg
> 
> 
>   drivers/infiniband/hw/hfi1/Makefile       |    1
>   drivers/infiniband/hw/hfi1/aspm.c         |  270 +++++++++++++++++++++++++++++
>   drivers/infiniband/hw/hfi1/aspm.h         |  262 +---------------------------
>   drivers/infiniband/hw/hfi1/debugfs.c      |    5 -
>   drivers/infiniband/hw/hfi1/pcie.c         |    6 -
>   drivers/infiniband/hw/hfi1/qp.c           |    4
>   drivers/infiniband/hw/hfi1/rc.c           |    3
>   drivers/infiniband/hw/hfi1/trace_ibhdrs.h |    2
>   drivers/infiniband/hw/hfi1/uc.c           |    3
>   drivers/infiniband/hw/hfi1/ud.c           |   36 ++--
>   drivers/infiniband/hw/qib/qib_qp.c        |    4
>   drivers/infiniband/hw/qib/qib_rc.c        |    3
>   drivers/infiniband/hw/qib/qib_uc.c        |    3
>   drivers/infiniband/hw/qib/qib_ud.c        |   28 ++-
>   drivers/infiniband/sw/rdmavt/ah.c         |    6 -
>   drivers/infiniband/sw/rdmavt/cq.c         |   15 +-
>   drivers/infiniband/sw/rdmavt/mr.c         |    3
>   drivers/infiniband/sw/rdmavt/qp.c         |   96 +++++++---
>   drivers/infiniband/sw/rdmavt/trace_mr.h   |   56 ++++++
>   drivers/infiniband/sw/rdmavt/vt.h         |    9 +
>   include/rdma/rdma_vt.h                    |    3
>   include/rdma/rdmavt_cq.h                  |    3
>   include/rdma/rdmavt_qp.h                  |  119 ++++++++++++-
>   23 files changed, 584 insertions(+), 356 deletions(-)
>   create mode 100644 drivers/infiniband/hw/hfi1/aspm.c

Note this needs the Completion rework patches to avoid conflicts.

https://patchwork.kernel.org/patch/10992251/
https://patchwork.kernel.org/patch/10992247/

-Denny


