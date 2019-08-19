Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 209E59246A
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfHSNLc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 09:11:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:21677 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbfHSNLb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 09:11:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 06:11:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="168746706"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.207.195]) ([10.254.207.195])
  by orsmga007.jf.intel.com with ESMTP; 19 Aug 2019 06:11:29 -0700
Subject: Re: [PATCH] infiniband: hfi1: fix memory leaks
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1566154486-3713-1-git-send-email-wenwen@cs.uga.edu>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <da3f6be9-68e1-0db0-ee9d-55f10fc60bfb@intel.com>
Date:   Mon, 19 Aug 2019 09:11:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566154486-3713-1-git-send-email-wenwen@cs.uga.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/18/2019 2:54 PM, Wenwen Wang wrote:
> In fault_opcodes_write(), 'data' is allocated through kcalloc(). However,
> it is not deallocated in the following execution if an error occurs,
> leading to memory leaks. To fix this issue, introduce the 'free_data' label
> to free 'data' before returning the error.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

