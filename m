Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A692B9D9
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 20:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfE0SHA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 14:07:00 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42218 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0SHA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 14:07:00 -0400
Received: by mail-vk1-f196.google.com with SMTP id x196so3862245vkd.9
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 11:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7JHsActq1wgr2+7jFK3lURoMeWqHD+FT9ZeLZy+r/1E=;
        b=mytDEAbFV3HKg9u7AggBaeBKBbxzqCYEZNA1oo5i+ZJNN7/NaTVQob3OdFhryplh3j
         BfRcHiyNMeoUIhjQLc6ebEDXENr6/uRhyj/J597jQqvtzU9Ivo//xq1qZc0HZ0gM3UWX
         x12LYfpr9E95TXiNt/3ff6k2UZhO6Mue43kDuMeCJTKLaUtD0nCCiaqyqSQ2SVZvw32j
         blgqiAQBu3nQLzGkput+oG4UMGjTtBcP2bkVvxoQHAW/NqyEQjU+61wgIiqqGLMoQVbg
         12rAK/mIl5tI82P28AfJ2YRknAMGJnOyR8h+X4Amp7Z5RHdg2QJsFD93/6MXnfduERs/
         mkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7JHsActq1wgr2+7jFK3lURoMeWqHD+FT9ZeLZy+r/1E=;
        b=oMpiACrCqgODaMEi/esu++ynvrNRsAvWT2CAfXe1VuNpCutZIA3+U2uidL6G7z4SKR
         MzE+m4qhIdBmPqXBjN74TsLS3qp6NPu6ab/UPcJI9BmdM0g/cu2EOjo2Xpk5bE4ZSN3b
         ZZlh/qOh+8k3NIVS28sXCXPYL8uY0NUVYvaZzqI7j8cVCfAnsbQWbjjyKCL2ga2MEQkX
         8D7hLUAfSKLA9vU81VE6Ga7mBQ7BbNndwuNBBLMGDN4/MtgN2GwsKX5QscyNYolCn7ck
         PbLukYRxxF5krSMQ2GM7pKgOI8krlk+BiVGShIl9Yu6MFunxuDHZx+Af3kbuqhBPoDUf
         4h3w==
X-Gm-Message-State: APjAAAWroC2EEyMFGMy9u3kQI1t4np+bf2QZYQmUkVmIDKR+RebTawef
        2LntCT77hAd0a6X5Wyd31fG0TYQNfBM=
X-Google-Smtp-Source: APXvYqyI/4Q7FNn007ENZZJl6FG/Ok6/6eVOUJHjaZIArdg3CrP7QGOGdv5u5LSJN/4gAOJIhkjUrg==
X-Received: by 2002:a1f:a097:: with SMTP id j145mr21092752vke.18.1558980418933;
        Mon, 27 May 2019 11:06:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a123sm7925383vka.22.2019.05.27.11.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 11:06:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVK1R-0002WY-OF; Mon, 27 May 2019 15:06:57 -0300
Date:   Mon, 27 May 2019 15:06:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Honggang Li <honli@redhat.com>
Cc:     haakon.bugge@oracle.com, linux-rdma@vger.kernel.org
Subject: Re: [rdma-core patch] ibacm: only open InfiniBand port
Message-ID: <20190527180657.GD18100@ziepe.ca>
References: <20190522124528.5688-1-honli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522124528.5688-1-honli@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 08:45:28AM -0400, Honggang Li wrote:
> The low 64 bits of cxgb3 and cxgb4 devices' GID are zeros. If the
> "provider" was set in the option file, ibacm will failed with
> segment fault.
> 
> $ sed -i -e 's/# provider ibacmp 0xFE80000000000000/provider ibacmp 0xFE80000000000000/g' /etc/rdma/ibacm_opts.cfg
> $ /usr/sbin/ibacm --systemd
> Segmentation fault (core dumped)
> 
> acm_open_dev function should not open port for IWARP or ROCE devices.
> 
> Signed-off-by: Honggang Li <honli@redhat.com>
> ---
>  ibacm/src/acm.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Haakon, this is where you do the maintainer thing and approve
Honggang's patch :)
