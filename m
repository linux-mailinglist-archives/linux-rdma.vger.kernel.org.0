Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0BD9CC3B9
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 21:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbfJDTp5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 15:45:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:51634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729586AbfJDTp5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Oct 2019 15:45:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95809AC2E;
        Fri,  4 Oct 2019 19:45:55 +0000 (UTC)
Date:   Fri, 4 Oct 2019 12:44:46 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Michael@google.com, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 07/11] vhost: convert vhost_umem_interval_tree to half
 closed intervals
Message-ID: <20191004194446.tomd55ll4nlkelb6@linux-p48b>
Mail-Followup-To: Michel Lespinasse <walken@google.com>,
        akpm@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Michael@google.com, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Davidlohr Bueso <dbueso@suse.de>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-8-dave@stgolabs.net>
 <20191004121021.GA4541@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191004121021.GA4541@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 04 Oct 2019, Michel Lespinasse wrote:

>On Thu, Oct 03, 2019 at 01:18:54PM -0700, Davidlohr Bueso wrote:
>> @@ -1320,15 +1320,14 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
>>  {
>>  	const struct vhost_umem_node *node;
>>  	struct vhost_umem *umem = vq->iotlb;
>> -	u64 s = 0, size, orig_addr = addr, last = addr + len - 1;
>> +	u64 s = 0, size, orig_addr = addr, last = addr + len;
>
>maybe "end" or "end_addr" instead of "last".
>
>> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>> index e9ed2722b633..bb36cb9ed5ec 100644
>> --- a/drivers/vhost/vhost.h
>> +++ b/drivers/vhost/vhost.h
>> @@ -53,13 +53,13 @@ struct vhost_log {
>>  };
>>
>>  #define START(node) ((node)->start)
>> -#define LAST(node) ((node)->last)
>> +#define END(node) ((node)->end)
>>
>>  struct vhost_umem_node {
>>  	struct rb_node rb;
>>  	struct list_head link;
>>  	__u64 start;
>> -	__u64 last;
>> +	__u64 end;
>>  	__u64 size;
>>  	__u64 userspace_addr;
>>  	__u32 perm;
>
>Preferably also rename __subtree_last to __subtree_end

Yes, this was was another one that I had in mind renaming, but
didn't want to grow the series -- all custom interval trees
name _last for the subtree iirc. Like my previous reply, I'd
rather leave this stuff for a followup series.

Thanks,
Davidlohr
