Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B355BBC3EB
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 10:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392102AbfIXILe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Sep 2019 04:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390364AbfIXILe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Sep 2019 04:11:34 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87C3B2146E;
        Tue, 24 Sep 2019 08:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569312694;
        bh=3+ItoLaCm4L9Rf47iTVEBmiA2l2JdyWbet+zC1Po5sY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pO+ehgBnRyAeMN35UE8LNmOYRArRsqnX1sND30gUIG7OlRSvA3Zm7FXNH9sejsG4h
         DBVDYqFx7Vo3uUkhhrtETO/kwobiNH7pS8VafxcT9LdpqJYyvcHOCq1emW3J/pydg7
         Jjo3o97PemuwfdIDguRYjSiqMbR4wAPaIY17jbdc=
Date:   Tue, 24 Sep 2019 11:11:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Honggang LI <honli@redhat.com>
Cc:     bvanassche@acm.org, linux-rdma@vger.kernel.org
Subject: Re: [rdma-core patch] srp_daemon: fix a double free segment fault
 for ibsrpdm
Message-ID: <20190924081130.GR14368@unreal>
References: <20190919064045.23193-1-honli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919064045.23193-1-honli@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 19, 2019 at 02:40:45PM +0800, Honggang LI wrote:
> From: Honggang Li <honli@redhat.com>
>
> Command: ./ibsrpdm -d /dev/infiniband/umadX
>
> Invalid free() / delete / delete[] / realloc()
>    at 0x4C320DC: free (vg_replace_malloc.c:540)
>    by 0x403BBB: free_config (srp_daemon.c:1811)
>    by 0x4031BE: ibsrpdm (srp_daemon.c:2113)
>    by 0x4031BE: main (srp_daemon.c:2153)
>  Address 0x5ee5fd0 is 0 bytes inside a block of size 16 free'd
>    at 0x4C320DC: free (vg_replace_malloc.c:540)
>    by 0x404851: translate_umad_to_ibdev_and_port (srp_daemon.c:729)
>    by 0x404851: set_conf_dev_and_port (srp_daemon.c:1586)
>    by 0x403171: ibsrpdm (srp_daemon.c:2092)
>    by 0x403171: main (srp_daemon.c:2153)
>  Block was alloc'd at
>    at 0x4C30EDB: malloc (vg_replace_malloc.c:309)
>    by 0x40478D: translate_umad_to_ibdev_and_port (srp_daemon.c:698)
>    by 0x40478D: set_conf_dev_and_port (srp_daemon.c:1586)
>    by 0x403171: ibsrpdm (srp_daemon.c:2092)
>    by 0x403171: main (srp_daemon.c:2153)
>
> Signed-off-by: Honggang Li <honli@redhat.com>
> ---
>  srp_daemon/srp_daemon.c | 1 +
>  1 file changed, 1 insertion(+)

Queued, https://github.com/linux-rdma/rdma-core/pull/585

Thanks
