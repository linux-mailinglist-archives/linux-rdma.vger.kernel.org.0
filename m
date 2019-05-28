Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A872C8DC
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 16:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfE1Oeq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 10:34:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:61781 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfE1Oeq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 10:34:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 07:34:45 -0700
X-ExtLoop1: 1
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.206.128]) ([10.254.206.128])
  by orsmga007.jf.intel.com with ESMTP; 28 May 2019 07:34:44 -0700
Subject: Re: [PATCH rdma-next v1 2/3] RDMA: Clean destroy CQ in drivers do not
 return errors
To:     Leon Romanovsky <leon@kernel.org>,
        Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20190528113729.13314-1-leon@kernel.org>
 <20190528113729.13314-3-leon@kernel.org>
 <1934b1ce-d700-2cd1-d4eb-a30d8d13770d@amazon.com>
 <20190528130901.GL4633@mtr-leonro.mtl.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <426cc597-65b9-3fbe-753f-31338ffac79b@intel.com>
Date:   Tue, 28 May 2019 10:34:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528130901.GL4633@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/28/2019 9:09 AM, Leon Romanovsky wrote:
> On Tue, May 28, 2019 at 04:03:42PM +0300, Gal Pressman wrote:
>> On 28/05/2019 14:37, Leon Romanovsky wrote:
>>> From: Leon Romanovsky <leonro@mellanox.com>
>>>
>>> Like all other destroy commands, .destroy_cq() call is not supposed
>>> to fail. In all flows, the attempt to return earlier caused to memory
>>> leaks.
>>>
>>> This patch converts .destroy_cq() to do not return any errors.
>>>
>>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>>
>> This patch doesn't apply to my tree for some reason.
> 
> I rebased it on top of rdma/wip/jgg-for-next branch.

Can you provide the SHA? I pulled: ea996974 and still get conflicts 
applying 2/3.

-Denny
