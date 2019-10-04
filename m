Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9476CC46E
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 22:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbfJDUv3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 16:51:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:4996 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfJDUv3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Oct 2019 16:51:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 13:51:28 -0700
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="186370662"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.65]) ([10.254.204.65])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 04 Oct 2019 13:51:27 -0700
Subject: Re: [PATCH for-rc 2/2] IB/hfi1: Use a common pad buffer for 9B and
 16B packets
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kaike Wan <kaike.wan@intel.com>
References: <20191004203739.26542.57060.stgit@awfm-01.aw.intel.com>
 <20191004204934.26838.13099.stgit@awfm-01.aw.intel.com>
Message-ID: <21590759-2a49-737f-1edf-0778a9586d6c@intel.com>
Date:   Fri, 4 Oct 2019 16:51:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191004204934.26838.13099.stgit@awfm-01.aw.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/4/2019 4:49 PM, Dennis Dalessandro wrote:
> From: Mike Marciniszyn <mike.marciniszyn@intel.com>
> 
> There is no reason for a different pad buffer for the two
> packet types.
> 
> Expand the current buffer allocation to allow for both
> packet types.
> 
> Fixes: f8195f3b14a0 ("IB/hfi1: Eliminate allocation while atomic")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Kaike Wan <kaike.wan@intel.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

Should also have had:

Cc: <stable@vger.kernel.org> # 4.14+

-Denny
