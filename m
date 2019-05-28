Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23B292C540
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 13:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfE1LRL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 07:17:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:8313 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfE1LRK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 07:17:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 04:17:10 -0700
X-ExtLoop1: 1
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.206.128]) ([10.254.206.128])
  by orsmga007.jf.intel.com with ESMTP; 28 May 2019 04:17:08 -0700
Subject: Re: [PATCH rdma-next 00/15] Convert CQ allocations
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
References: <20190520065433.8734-1-leon@kernel.org>
 <20190521185443.GA23445@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <1dcd9e36-8eda-2a10-5b69-cc76677366ed@intel.com>
Date:   Tue, 28 May 2019 07:20:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190521185443.GA23445@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/21/2019 2:54 PM, Jason Gunthorpe wrote:
> On Mon, May 20, 2019 at 09:54:18AM +0300, Leon Romanovsky wrote:
>> From: Leon Romanovsky <leonro@mellanox.com>
>>
>> Hi,
>>
>> This is my next series of allocation conversion patches.
>>
>> Thanks
>>
>> Leon Romanovsky (15):
>>    rds: Don't check return value from destroy CQ
>>    RDMA/ipoib: Remove check of destroy CQ
>>    RDMA/core: Make ib_destroy_cq() void
>>    RDMA/nes: Remove useless NULL checks
>>    RDMA/i40iw: Remove useless NULL checks
>>    RDMA/nes: Remove second wait queue initialization call
> 
> These trivial ones all applied to for-rc, thanks

rc or next?

-Denny
