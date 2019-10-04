Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88CECBA02
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 14:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfJDMK0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 08:10:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36513 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfJDMK0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 08:10:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so3806820pfr.3
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 05:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MONUV9NdASv4E/jp3PLYS1e/RNBJIzL7dOLdp6xf/uE=;
        b=iTtWj+7gGfp6+mPyUyPcmc1lJtdr2PP7Q3oDWr3dme3JCqXTvoY85yKuWWZDqr+5m/
         +JsDgV07ki6BMM0hU84es+Tsw9fZruvIti3HHf1SF5iMPnonCoT+VpH54rRIFPHHNVmP
         7DslUK3E2axvE6afKEKJW1kJNT76E15ro9GIccWL4y+3c9/AAyvVo/KJypKH8SRfU1WS
         n5QWt42Atech8fFN7rbGUdWkMprEE3+0ugj2RMeBAK9W1tUJt2muS7tnFG2UFyeVsfyf
         Qoi6nT5m3WKRNmvn2e0mSyjBD/qHKKVmQMalcby/BF/ww13W9PJX10Y3d9xIyoMIa2cD
         AEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MONUV9NdASv4E/jp3PLYS1e/RNBJIzL7dOLdp6xf/uE=;
        b=fy/34sf+uMV0zdCooU+3NRmCX3GzcsW4ha6RrFu3HMKMdm2TDmES0qVlVcvWJk2OCx
         28LULgVmTTkk6bz0Go1kZTEgNT93JfmmNxcX8stGDcdBVQmR6qzcUj3umaAZCnTGjkml
         axrYj0ce2gJ62gywIYymYIUry2fpbsRugYzai6PXR87XuXdTYj/0+52slu9CSf9co+6K
         Aw238XyX9eynmyUjtW1cSKA/lIF9cCN4fLmjvu/9W+yUw/jbf3nlrdBa93cDyk5ciMuQ
         G4XaBAeWGB8dVFCpSUszZhKSP60Ov4C29r4MkZWeiTp9NNzVgPaxzhEGbTNnMPgmN5iD
         XD4Q==
X-Gm-Message-State: APjAAAXzlh6tYvvJdsLmZDYZnxJrxIYxsjtoY34vRflS8Ashqo9hWYKz
        7S5g7KftVAq8WfuVRhU/KSJVxg==
X-Google-Smtp-Source: APXvYqzNdLXB1er8H0c7Slwc2yYDYsLUGzWgSjwx36DZdnfkq/ZCVMhUzLC1HtyaiP0lxIoZTRVcSQ==
X-Received: by 2002:a63:2154:: with SMTP id s20mr14813025pgm.379.1570191024502;
        Fri, 04 Oct 2019 05:10:24 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:668d:6035:b425:3a3a])
        by smtp.gmail.com with ESMTPSA id x72sm6836120pfc.89.2019.10.04.05.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 05:10:23 -0700 (PDT)
Date:   Fri, 4 Oct 2019 05:10:21 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Michael@google.com, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 07/11] vhost: convert vhost_umem_interval_tree to half
 closed intervals
Message-ID: <20191004121021.GA4541@google.com>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-8-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003201858.11666-8-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 03, 2019 at 01:18:54PM -0700, Davidlohr Bueso wrote:
> @@ -1320,15 +1320,14 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
>  {
>  	const struct vhost_umem_node *node;
>  	struct vhost_umem *umem = vq->iotlb;
> -	u64 s = 0, size, orig_addr = addr, last = addr + len - 1;
> +	u64 s = 0, size, orig_addr = addr, last = addr + len;

maybe "end" or "end_addr" instead of "last".

> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index e9ed2722b633..bb36cb9ed5ec 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -53,13 +53,13 @@ struct vhost_log {
>  };
>  
>  #define START(node) ((node)->start)
> -#define LAST(node) ((node)->last)
> +#define END(node) ((node)->end)
>  
>  struct vhost_umem_node {
>  	struct rb_node rb;
>  	struct list_head link;
>  	__u64 start;
> -	__u64 last;
> +	__u64 end;
>  	__u64 size;
>  	__u64 userspace_addr;
>  	__u32 perm;

Preferably also rename __subtree_last to __subtree_end

Looks good to me otherwise.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
