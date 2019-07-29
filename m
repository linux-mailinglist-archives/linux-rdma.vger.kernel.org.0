Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D5378D86
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfG2OLo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 10:11:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37862 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfG2OLn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Jul 2019 10:11:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so59789128qto.4
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jul 2019 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PsPDSb+DoW3u43zya3GiTnOJ6HaiQ4dl4ZawUa34njM=;
        b=mqbMtcNlpqUJwY0P+K1+JIC+dj5szUVllgsR5ZkCew4PvzNTl6r1482z5UzsVy19VS
         Eb489kblJC3GJOP3vesEbAXRGvUAv1FlGFAi6r+HvOESOWmfUyXjfS52+AxgJ5PZgt4s
         9pJ8k6jRIzTx7kcT4Wjta2biZwrVbf+eelpSbzuaMKGoR8UH81Z+V0i/9i6/Or8yccff
         QOi1tysAyCk3KuFQz0JvejSjcW1z0OGANHHaPk3YjdzbTPRKWZJgpEKJJAXj/YMjT7lJ
         53ZZpabUQLoWQgitMj50IHYERweSjnx08yIC5DQZYZQxGeBsdZ8Ya75g1clyHWezLxQY
         86yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PsPDSb+DoW3u43zya3GiTnOJ6HaiQ4dl4ZawUa34njM=;
        b=NY8Kap226Rpuiy+t0ICOG9XkqzqM+YlMK8d/oRsUvDtMkFU2mjpzVRkuL1UC1dwiAI
         Tw+k7hG0zpJfj3ca/PEWuhKE38+oWOP/ezovzOgT/zBnkVUC2DIORUrVolJbsQe5epD/
         K265ZW9uxv5TC4KffuHIcJz3gWnLYHDQ3q9scSyyPBycJy+xCBsk2GI2jURYU7QYfgkn
         c+0oIBRLdMoVUrSeljLXD05GuALviV2Vn0o0A2A6GZK2NvDMX0Ia5bLUMbZjLBGhfhto
         eyXRtDW9hBMlCLsMp7a787Lmv1lg3/eu8Qr/Gj3GhFaiC3H30l46P88A0tqM1edHNypk
         nD6g==
X-Gm-Message-State: APjAAAW5jA4dfs0eLrqE01cGwPEMYjL48phgked7WEtSWmRf6y7neWFC
        /7vXz0/owbgHhDYSH85Nlb39M4zUUzrYew==
X-Google-Smtp-Source: APXvYqy3TjMKvhup091pqqRhQYwtyDyHn+0QcPM1UqudRdbpqDLZu7FJ2F3QCIxtgvq5+Aamwv+Zwg==
X-Received: by 2002:a0c:bd86:: with SMTP id n6mr80527285qvg.183.1564409502811;
        Mon, 29 Jul 2019 07:11:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l63sm26425544qkb.124.2019.07.29.07.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 07:11:42 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hs6NK-000772-1m; Mon, 29 Jul 2019 11:11:42 -0300
Date:   Mon, 29 Jul 2019 11:11:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     Michal Kalderon <michal.kalderon@marvell.com>,
        ariel.elior@marvell.com, dledford@redhat.com, galpress@amazon.com,
        linux-rdma@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org
Subject: Re: [PATCH v6 rdma-next 1/6] RDMA/core: Create mmap database and
 cookie helper functions
Message-ID: <20190729141142.GD17990@ziepe.ca>
References: <20190709141735.19193-1-michal.kalderon@marvell.com>
 <20190709141735.19193-2-michal.kalderon@marvell.com>
 <20190725175540.GA18757@ziepe.ca>
 <20190728093051.GB5250@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728093051.GB5250@kheib-workstation>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 28, 2019 at 12:30:51PM +0300, Kamal Heib wrote:
> > Maybe put this in ib_core_uverbs.c ?
> > 
> > Kamal, you've been tackling various cleanups, maybe making ib_uverbs
> > unloadable again is something you'd be keen on?
> >
> 
> Yes, Could you please give some background on that?

Most of it is my fault from being too careless, but the general notion
is that all of these

$ grep EXPORT_SYMBOL uverbs_main.c uverbs_cmd.c  uverbs_marshall.c  rdma_core.c uverbs_std_types*.c uverbs_uapi.c 
uverbs_main.c:EXPORT_SYMBOL(ib_uverbs_get_ucontext_file);
uverbs_main.c:EXPORT_SYMBOL(rdma_user_mmap_io);
uverbs_cmd.c:EXPORT_SYMBOL(flow_resources_alloc);
uverbs_cmd.c:EXPORT_SYMBOL(ib_uverbs_flow_resources_free);
uverbs_cmd.c:EXPORT_SYMBOL(flow_resources_add);
uverbs_marshall.c:EXPORT_SYMBOL(ib_copy_ah_attr_to_user);
uverbs_marshall.c:EXPORT_SYMBOL(ib_copy_qp_attr_to_user);
uverbs_marshall.c:EXPORT_SYMBOL(ib_copy_path_rec_to_user);
uverbs_marshall.c:EXPORT_SYMBOL(ib_copy_path_rec_from_user);
rdma_core.c:EXPORT_SYMBOL(uverbs_idr_class);
rdma_core.c:EXPORT_SYMBOL(uverbs_close_fd);
rdma_core.c:EXPORT_SYMBOL(uverbs_fd_class);
uverbs_std_types.c:EXPORT_SYMBOL(uverbs_destroy_def_handler);

Need to go into some 'ib_core uverbs support' .c file in the ib_core,
be moved to a header inline, or moved otherwise

Maybe it is now unrealistic that the uapi is so complicated, ie
uverbs_close_fd is just not easy to fixup..

Maybe the only ones that need fixing are ib_uverbs_get_ucontext_file
rdma_user_mmap_io as alot of drivers are entangled on those now.

The other stuff is much harder..

Jason
