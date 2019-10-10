Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F4D2086
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 07:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbfJJFt0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 01:49:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfJJFtZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Oct 2019 01:49:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 371DB2A09A3;
        Thu, 10 Oct 2019 05:49:25 +0000 (UTC)
Received: from [10.72.12.46] (ovpn-12-46.pek2.redhat.com [10.72.12.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69C6D600C4;
        Thu, 10 Oct 2019 05:49:18 +0000 (UTC)
Subject: Re: [PATCH 07/11] vhost: convert vhost_umem_interval_tree to half
 closed intervals
To:     Davidlohr Bueso <dave@stgolabs.net>, akpm@linux-foundation.org
Cc:     walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Davidlohr Bueso <dbueso@suse.de>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-8-dave@stgolabs.net>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <294467e3-5545-9a76-a975-4798f096ac4b@redhat.com>
Date:   Thu, 10 Oct 2019 13:49:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191003201858.11666-8-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 10 Oct 2019 05:49:25 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2019/10/4 上午4:18, Davidlohr Bueso wrote:
> The vhost_umem interval tree really wants [a, b) intervals,
> not fully closed as currently. As such convert it to use the
> new interval_tree_gen.h, and also rename the 'last' endpoint
> in the node to 'end', which both a more suitable name for
> the half closed interval and also reduces the chances of some
> caller being missed.
>
> Cc: Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>   drivers/vhost/vhost.c | 19 +++++++++----------
>   drivers/vhost/vhost.h |  4 ++--
>   2 files changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 36ca2cf419bf..80c3cca24dc7 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -28,7 +28,7 @@
>   #include <linux/sort.h>
>   #include <linux/sched/mm.h>
>   #include <linux/sched/signal.h>
> -#include <linux/interval_tree_generic.h>
> +#include <linux/interval_tree_gen.h>
>   #include <linux/nospec.h>
>   
>   #include "vhost.h"
> @@ -51,7 +51,7 @@ enum {
>   
>   INTERVAL_TREE_DEFINE(struct vhost_umem_node,
>   		     rb, __u64, __subtree_last,
> -		     START, LAST, static inline, vhost_umem_interval_tree);
> +		     START, END, static inline, vhost_umem_interval_tree);
>   
>   #ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
>   static void vhost_disable_cross_endian(struct vhost_virtqueue *vq)
> @@ -1034,7 +1034,7 @@ static int vhost_new_umem_range(struct vhost_umem *umem,
>   
>   	node->start = start;
>   	node->size = size;
> -	node->last = end;
> +	node->end = end;
>   	node->userspace_addr = userspace_addr;
>   	node->perm = perm;
>   	INIT_LIST_HEAD(&node->link);
> @@ -1112,7 +1112,7 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
>   		}
>   		vhost_vq_meta_reset(dev);
>   		if (vhost_new_umem_range(dev->iotlb, msg->iova, msg->size,
> -					 msg->iova + msg->size - 1,
> +					 msg->iova + msg->size,
>   					 msg->uaddr, msg->perm)) {
>   			ret = -ENOMEM;
>   			break;
> @@ -1126,7 +1126,7 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
>   		}
>   		vhost_vq_meta_reset(dev);
>   		vhost_del_umem_range(dev->iotlb, msg->iova,
> -				     msg->iova + msg->size - 1);
> +				     msg->iova + msg->size);
>   		break;
>   	default:
>   		ret = -EINVAL;
> @@ -1320,15 +1320,14 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
>   {
>   	const struct vhost_umem_node *node;
>   	struct vhost_umem *umem = vq->iotlb;
> -	u64 s = 0, size, orig_addr = addr, last = addr + len - 1;
> +	u64 s = 0, size, orig_addr = addr, last = addr + len;
>   
>   	if (vhost_vq_meta_fetch(vq, addr, len, type))
>   		return true;
>   
>   	while (len > s) {
>   		node = vhost_umem_interval_tree_iter_first(&umem->umem_tree,
> -							   addr,
> -							   last);
> +							   addr, last);
>   		if (node == NULL || node->start > addr) {
>   			vhost_iotlb_miss(vq, addr, access);
>   			return false;
> @@ -1455,7 +1454,7 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
>   					 region->guest_phys_addr,
>   					 region->memory_size,
>   					 region->guest_phys_addr +
> -					 region->memory_size - 1,
> +					 region->memory_size,
>   					 region->userspace_addr,
>   					 VHOST_ACCESS_RW))
>   			goto err;
> @@ -2055,7 +2054,7 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
>   		}
>   
>   		node = vhost_umem_interval_tree_iter_first(&umem->umem_tree,
> -							addr, addr + len - 1);
> +							   addr, addr + len);
>   		if (node == NULL || node->start > addr) {
>   			if (umem != dev->iotlb) {
>   				ret = -EFAULT;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index e9ed2722b633..bb36cb9ed5ec 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -53,13 +53,13 @@ struct vhost_log {
>   };
>   
>   #define START(node) ((node)->start)
> -#define LAST(node) ((node)->last)
> +#define END(node) ((node)->end)
>   
>   struct vhost_umem_node {
>   	struct rb_node rb;
>   	struct list_head link;
>   	__u64 start;
> -	__u64 last;
> +	__u64 end;
>   	__u64 size;
>   	__u64 userspace_addr;
>   	__u32 perm;


Reviewed-by: Jason Wang <jasowang@redhat.com>


