Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14C51D1E76
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 21:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390388AbgEMTCc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 15:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732218AbgEMTCc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 15:02:32 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417FDC061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 12:02:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g185so372629qke.7
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KTAwyyBmHKwGUx/aLvSswRW7Toie5z/AytneZI6XMvM=;
        b=AHLfD4vlfByLIhbvF4VTh8Yz6nYFtkYHxQkqmWJ2CcRFM8R7a2PyWTS3jqifxshzmC
         +SaARIFbS4Wqtfr26zi5OV9N1tigE3uYDkNjWujTBU0pLChhJt3XtsnbxSr77gMAPaUd
         aLcUzfhzqf/wHAJpkdSBnv5+oKz3fQAk8jNG+ttLAkqLzxcbK748HEuKQg9Wtj/AU5LK
         urvG6jU7B2LiJUw5vNn1YP2A5p/BZX8zudrHyoMibiOE7Q5nPw7pjtjVNPV3lWVO2XfZ
         n9oveiA8WfwEUUbYnjfO31q1R7/Rr6E8kc9/0IirPnFNmwHkA6ni6ZPZDU6KTLP3q6hK
         v1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KTAwyyBmHKwGUx/aLvSswRW7Toie5z/AytneZI6XMvM=;
        b=P4y1q/g8gKGkUDG3bcyKG5r8rwbzhId7yLhzREVuHUQrV2k4ybl61kl37pekVGHX06
         iWPGcomx+0Xw9e+DgVAF9v0jOP0Q8W6vBNP5uvwCxyc3bkQ6Hrcg6zHk3qEPtG2X8kWP
         qTkOSyytgFfMkP3UtRWrH1aTuBwI5DUePcvPx1BN3nuK72E/03Vps2sqQjNknN3XmDcv
         xpRs/eYnVQ50i5x8vSK90WBarNhRsa9Ezk+GYSPC3vwfk8PyvpGGaSLCpNZV+Xwx7IHj
         BrXtXX3aTSLZZBQNc7r0M0Z7dYvBJHfXA3Ju4eYOApwY/wXVWva3Lz+e/I8XCGCucQES
         BSHg==
X-Gm-Message-State: AOAM531OEqud/wL+mNkg8BBrsS/89jHnLu1ZnI3i/PkskIcADK8ttXoR
        rEn429eoGfUijjxKyfHQyDni7Q==
X-Google-Smtp-Source: ABdhPJylggR/aqiiPbWPemNu/6XSFLNpoStkI3QaX8+oFx5ZbhiWqj7NnxeRP/XYMmr9Znd2EEyB/Q==
X-Received: by 2002:a05:620a:6d4:: with SMTP id 20mr1192163qky.58.1589396551553;
        Wed, 13 May 2020 12:02:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s56sm479896qtk.45.2020.05.13.12.02.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 12:02:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYweE-00009M-Jy; Wed, 13 May 2020 16:02:30 -0300
Date:   Wed, 13 May 2020 16:02:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Fix query_srq_cmd() function
Message-ID: <20200513190230.GA508@ziepe.ca>
References: <20200513100809.246315-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513100809.246315-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 01:08:09PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The output buffer used in mlx5_cmd_exec_inout() was wrongly changed
> from pre-allocated srq_out pointer to an input "out" point. That
> leads to unpredictable results in the get_srqc() call later.
> 
> Fixes: 31578defe4eb ("RDMA/mlx5: Update mlx5_ib to use new cmd interface")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/srq_cmd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
