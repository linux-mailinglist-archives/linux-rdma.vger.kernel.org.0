Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D29E7631
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 17:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbfJ1QcD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 12:32:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35083 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730703AbfJ1QcD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 12:32:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id l3so4912850qtp.2
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uF2pu9XWnwmONON2hl33O+cxRvyMii1B18j+PKIqqpU=;
        b=gfhWeV+DFukyRi8FJyl/VNfwgTjyRok0rYIW1c1vtu0AkdgphPvht5aqOgupMDjhNK
         ZoJZc62flun4/pgIvHAsL8xSmBdZjdoUyYuYXRNLU+MxXMXXhN5+6rHCOQWlmm9o90kU
         s4crxh6TGbGgbAY+BpZGDhehZZ+imTPdI90yK2lB+YHZOus9HyBHMg3+8lZPL5qkHh/u
         UB5G5bqJuKZQcHPJrS0XfrzEyKEVdTH4awyZYX9s/Dxphj0NJdq4GebWFcpHBdOignmg
         BUDW3HneYJZ/DoKaq3S2K1yCtPvFPxwVAntLg+OKIlX5RLTCtVtC7l0Nym/557si0Qgp
         nNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uF2pu9XWnwmONON2hl33O+cxRvyMii1B18j+PKIqqpU=;
        b=hfYjidmmHwP6H7JlbgnmL8ooQJrWpqcqlo7kAQ8Q1XWjPjNTPmm+S5lM2Vi6bQRBSn
         yajtQKdQ0eUk4TiAbugM9zFecW0U3GBGdZ6ODKnzX15bNYzD1IFBwbkiTKB8ZwR5cnzu
         uSwEcY4msLF7CNByk96A1GlxMFGqbhtdEtopnhNay3z30SOMf5enWtt6PAUCSEqvYjTF
         srYOn3/70pIbapZPymlHxoNslMV8xMdd4IDhxOKDUeXT11JIk+0MLHtZ+OqtZiJYCxao
         a+4jyJ2Gai+Y2udo4pY0rZ3UuSayZI+Hx+T55uj6qOrmxSIO0SUgFJMzFw8JNLVuppjc
         fAfA==
X-Gm-Message-State: APjAAAVoF6UwmfxkVXUrsUX0H8mym6kcEOFhoxjVZNRV79vXhXUsCIyc
        /mKz5bgR21bRI3zAuZqI/1Ykvw==
X-Google-Smtp-Source: APXvYqyrjLdhUxrJcHu2a3X8DVNN7eDYADDkjbctJKHgGluWGxyr+QcHIRf2jLPbENNPCJtmH+c/vA==
X-Received: by 2002:aed:255c:: with SMTP id w28mr18425338qtc.185.1572280322037;
        Mon, 28 Oct 2019 09:32:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id y33sm10046280qta.18.2019.10.28.09.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 09:32:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP7w0-0007lL-V4; Mon, 28 Oct 2019 13:32:00 -0300
Date:   Mon, 28 Oct 2019 13:32:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Honggang LI <honli@redhat.com>
Subject: Re: [PATCH] RDMA/srpt: Fix TPG creation
Message-ID: <20191028163200.GA29812@ziepe.ca>
References: <20191023204106.23326-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023204106.23326-1-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 01:41:06PM -0700, Bart Van Assche wrote:
> Unlike the iSCSI target driver, for the SRP target driver it is sufficient
> if a single TPG can be associated with each RDMA port name. However, users
> started associating multiple TPGs with RDMA port names. Support this by
> converting the single TPG in struct srpt_port_id into a list. This patch
> fixes the following list corruption issue:
> 
> list_add corruption. prev->next should be next (ffffffffc0a080c0), but was ffffa08a994ce6f0. (prev=ffffa08a994ce6f0).
> WARNING: CPU: 2 PID: 2597 at lib/list_debug.c:28 __list_add_valid+0x6a/0x70
> CPU: 2 PID: 2597 Comm: targetcli Not tainted 5.4.0-rc1.3bfa3c9602a7 #1
> RIP: 0010:__list_add_valid+0x6a/0x70
> Call Trace:
>  core_tpg_register+0x116/0x200 [target_core_mod]
>  srpt_make_tpg+0x3f/0x60 [ib_srpt]
>  target_fabric_make_tpg+0x41/0x290 [target_core_mod]
>  configfs_mkdir+0x158/0x3e0
>  vfs_mkdir+0x108/0x1a0
>  do_mkdirat+0x77/0xe0
>  do_syscall_64+0x55/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Cc: Honggang LI <honli@redhat.com>
> Reported-by: Honggang LI <honli@redhat.com>
> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Acked-by: Honggang Li <honli@redhat.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 77 ++++++++++++++++++---------
>  drivers/infiniband/ulp/srpt/ib_srpt.h | 25 +++++++--
>  2 files changed, 73 insertions(+), 29 deletions(-)

Applied to for-next, thanks

Jason
