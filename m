Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC94013132F
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 14:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgAFNoe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 08:44:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:37384 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgAFNoe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jan 2020 08:44:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 05:44:33 -0800
X-IronPort-AV: E=Sophos;i="5.69,402,1571727600"; 
   d="scan'208";a="210788456"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.200.155]) ([10.254.200.155])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Jan 2020 05:44:31 -0800
Subject: Re: [PATCH for-next 0/9] Clean ups, refactror, additions
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
References: <20200106133845.119356.20115.stgit@awfm-01.aw.intel.com>
Message-ID: <b0fd4d9c-af68-9d8c-29df-aa371344c006@intel.com>
Date:   Mon, 6 Jan 2020 08:44:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106133845.119356.20115.stgit@awfm-01.aw.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/6/2020 8:41 AM, Dennis Dalessandro wrote:
> These patches add some recactoring and code clean ups to make things more
> organized. There is a performance optimization and new counter/debugging stats
> added as well. The new "API" that is added is a driver internal API not an
> actual "API" that is exposed to the outside.
> 
> ---
> 
> Grzegorz Andrejczuk (3):
>        IB/hfi1: Move common receive IRQ code to function
>        IB/hfi1: Decouple IRQ name from type
>        IB/hfi1: Return void in packet receiving functions
> 
> Mike Marciniszyn (6):
>        IB/hfi1: Move chip specific functions to chip.c
>        IB/hfi1: Add fast and slow handlers for receive context
>        IB/hfi1: IB/hfi1: Add an API to handle special case drop
>        IB/hfi1: Create API for auto activate
>        IB/hfi1: Add software counter for ctxt0 seq drop
>        IB/hfi1: Add RcvShortLengthErrCnt to hfi1stats
> 
> 
>   drivers/infiniband/hw/hfi1/chip.c           |  171 ++++++++++++++++++++++-----
>   drivers/infiniband/hw/hfi1/chip.h           |    8 +
>   drivers/infiniband/hw/hfi1/chip_registers.h |    1
>   drivers/infiniband/hw/hfi1/driver.c         |  151 +++++++++---------------
>   drivers/infiniband/hw/hfi1/hfi.h            |   66 ++++++++++
>   drivers/infiniband/hw/hfi1/init.c           |   81 ++-----------
>   drivers/infiniband/hw/hfi1/msix.c           |  106 +++++++++--------
>   drivers/infiniband/hw/hfi1/msix.h           |    1
>   drivers/infiniband/hw/hfi1/trace_rx.h       |    6 -
>   9 files changed, 337 insertions(+), 254 deletions(-)
> 
> --
> -Denny
> 

Forgot to mention these apply on top of the: wip/jgg-for-next branch.

-Denny
