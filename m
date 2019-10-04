Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA2BACC3AF
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 21:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfJDTmW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 15:42:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:50378 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727978AbfJDTmW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Oct 2019 15:42:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF892AD4F;
        Fri,  4 Oct 2019 19:42:20 +0000 (UTC)
Date:   Fri, 4 Oct 2019 12:41:11 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 05/11] IB/hfi1: convert __mmu_int_rb to half closed
 intervals
Message-ID: <20191004194111.2ntsr5kus5dgnnt4@linux-p48b>
Mail-Followup-To: Michel Lespinasse <walken@google.com>,
        akpm@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-6-dave@stgolabs.net>
 <20191004115057.GA2371@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191004115057.GA2371@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 04 Oct 2019, Michel Lespinasse wrote:

>On Thu, Oct 03, 2019 at 01:18:52PM -0700, Davidlohr Bueso wrote:
>> diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
>> index 14d2a90964c3..fb6382b2d44e 100644
>> --- a/drivers/infiniband/hw/hfi1/mmu_rb.c
>> +++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
>> @@ -47,7 +47,7 @@
>>  #include <linux/list.h>
>>  #include <linux/rculist.h>
>>  #include <linux/mmu_notifier.h>
>> -#include <linux/interval_tree_generic.h>
>> +#include <linux/interval_tree_gen.h>
>>
>>  #include "mmu_rb.h"
>>  #include "trace.h"
>> @@ -89,7 +89,7 @@ static unsigned long mmu_node_start(struct mmu_rb_node *node)
>>
>>  static unsigned long mmu_node_last(struct mmu_rb_node *node)
>>  {
>> -	return PAGE_ALIGN(node->addr + node->len) - 1;
>> +	return PAGE_ALIGN(node->addr + node->len);
>>  }
>
>May as well rename the function mmu_node_end(). I was worried if it
>was used anywhere else, but it turned out it's only used when defining
>the interval tree.

Right.

In general I tried not to rename everything to end because I wanted to
avoid bloating the diffstat, albeit having naming discrepancies within
the code (which isn't new either fwiw).

>
>I would also suggest moving this function (as well as mmu_node_first)
>right before its use, rather than just after, which would allow you to
>also remove the function prototype a few lines earlier.

Indeed, but again I don't want to unnecessarily grow the patch. I have
several notes to come back to once/if this series is settled.

>
>Looks good to me otherwise.
>
>Reviewed-by: Michel Lespinasse <walken@google.com>

Thanks,
Davidlohr
