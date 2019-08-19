Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD3B92447
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 15:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfHSNHl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 09:07:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:56483 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHSNHl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 09:07:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 06:07:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="168744924"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.207.195]) ([10.254.207.195])
  by orsmga007.jf.intel.com with ESMTP; 19 Aug 2019 06:07:38 -0700
Subject: Re: [PATCH] infiniband: hfi1: fix a memory leak bug
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1566156571-4335-1-git-send-email-wenwen@cs.uga.edu>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <463bb1cb-d132-2f5f-6e94-e0115228c3cb@intel.com>
Date:   Mon, 19 Aug 2019 09:07:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566156571-4335-1-git-send-email-wenwen@cs.uga.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/18/2019 3:29 PM, Wenwen Wang wrote:
> In fault_opcodes_read(), 'data' is not deallocated if debugfs_file_get()
> fails, leading to a memory leak. To fix this bug, introduce the 'free_data'
> label to free 'data' before returning the error.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

