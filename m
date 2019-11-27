Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2949210B72C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2019 21:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfK0UHx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Nov 2019 15:07:53 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41940 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0UHx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Nov 2019 15:07:53 -0500
Received: by mail-qt1-f196.google.com with SMTP id 59so21115268qtg.8
        for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2019 12:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k3Mr6ePYO4D5uqrlWweRlMB600tP71Y7imzqeQh6Acg=;
        b=fn2XgRJsS0klqpSuSayLqz3QECB77j5ijo/HKOYBlrcUyazzA1npoGZCZka/uVFvPa
         wCdKJamlJaxneEg2pF3gJXBQxqqRQD+AaEBUN9x9d934v9nMLSugDEfzDNioWqjmQQ0G
         XSzQXE2RRQHsM1gb8ZXa58FeFitHXswcyTyetFGzW3GgJQ+Uvy4jQxQHWvjBPO9pqV1O
         FxZfdHe/7bGL7Lkw2GgXPHS7VyW94tLn5FAHUAPaPNet2LFm27XVzvU4tchKMaVWxip+
         agVM08S2sasWGgdyNgRhB8irh4+CxRQ4Dl0CwKKz5krGICWlixSOmOC/RXk0gSYT3nuZ
         sWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k3Mr6ePYO4D5uqrlWweRlMB600tP71Y7imzqeQh6Acg=;
        b=RO5gWCtlxrrrJ6+LmRXfIl+8PXo4hkBw4xm7JoRQb9xDCz6wjf//eF+YYB08OIjUlM
         G7qNA7QiD4dwrUqBp+yuH5ZFpKJigyJxcvoFD8WWwMB2ONLiHXi6yZDuK6ksj1kxuAmm
         +reoLsNLryabhoXHAlgJHX+2Yt3rRUz/zwjHvIbQ6A+G4BWUQ3yy6tkowNMzVuZrHuie
         AYXtNHmWPvzfU/n3cjIwoJdvhgglAyLQASX9SO4DOKolU04DrRSUkyqxkxaX3FqcIz+U
         4zZZREEA3yxuTyQZQ5Q1J11LHK6swfVjv+RfLcMguAmVMxjf3NAvbqaaOaUqbF/q03Gz
         xhDw==
X-Gm-Message-State: APjAAAXASOIL43r+b3xZQqmTVbLCCVNPCHXoTXRiD3v0wrtVff/578/E
        8TKLWlhjmV4HGAoqyP58jNR2uA==
X-Google-Smtp-Source: APXvYqzO54dvmWtACXgYBNSBxPb8VZRvb7c7WUBeU+i2yutUkG7oHylWk8obB/LHP8305EFBLvJnsA==
X-Received: by 2002:aed:2fc3:: with SMTP id m61mr29700602qtd.47.1574885272172;
        Wed, 27 Nov 2019 12:07:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id m6sm7284882qke.80.2019.11.27.12.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Nov 2019 12:07:51 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ia3bL-0002O3-2n; Wed, 27 Nov 2019 16:07:51 -0400
Date:   Wed, 27 Nov 2019 16:07:51 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhu Yanjun <yanjun.zhu@oracle.com>
Cc:     dledford@redhat.com, michael.j.ruhl@intel.com, ira.weiny@intel.com,
        rostedt@goodmis.org, leon@kernel.org, kamalheib1@gmail.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCHv2 1/1] RDMA/core: avoid kernel NULL pointer error
Message-ID: <20191127200751.GB23284@ziepe.ca>
References: <1574655875-3475-1-git-send-email-yanjun.zhu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574655875-3475-1-git-send-email-yanjun.zhu@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 24, 2019 at 11:24:35PM -0500, Zhu Yanjun wrote:
> When the interface related with IB device is set to down/up over and
> over again, the following call trace will pop out.
> "
>  Call Trace:
>   [<ffffffffa039ff8d>] ib_mad_completion_handler+0x7d/0xa0 [ib_mad]
>   [<ffffffff810a1a41>] process_one_work+0x151/0x4b0
>   [<ffffffff810a1ec0>] worker_thread+0x120/0x480
>   [<ffffffff810a709e>] kthread+0xce/0xf0
>   [<ffffffff816e9962>] ret_from_fork+0x42/0x70
> 
>  RIP  [<ffffffffa039f926>] ib_mad_recv_done_handler+0x26/0x610 [ib_mad]
> "
> From vmcore, we can find the following:
> "
> crash7lates> struct ib_mad_list_head ffff881fb3713400
> struct ib_mad_list_head {
>   list = {
>     next = 0xffff881fb3713800,
>     prev = 0xffff881fe01395c0
>   },
>   mad_queue = 0x0
> }
> "
> 
> Before the call trace, a lot of ib_cancel_mad is sent to the sender.
> So it is necessary to check mad_queue in struct ib_mad_list_head to avoid
> "kernel NULL pointer" error.
> 
> From the new customer report, when there is something wrong with IB HW/FW,
> the above call trace will appear. It seems that bad IB HW/FW will cause
> this problem.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@oracle.com>
> V1->V2: Add new bug symptoms.
>  drivers/infiniband/core/mad.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
> index 9947d16..43f596c 100644
> +++ b/drivers/infiniband/core/mad.c
> @@ -2279,6 +2279,17 @@ static void ib_mad_recv_done(struct ib_cq *cq, struct ib_wc *wc)
>  		return;
>  	}
>  
> +	if (unlikely(!mad_list->mad_queue)) {
> +		/*
> +		 * When the interface related with IB device is set to down/up,
> +		 * a lot of ib_cancel_mad packets are sent to the sender. In
> +		 * sender, the mad packets are cancelled.  The receiver will
> +		 * find mad_queue NULL. If the receiver does not test mad_queue,
> +		 * the receiver will crash with "kernel NULL pointer" error.
> +		 */
> +		return;
> +	}

I feel like this patch was sent already? 

It is not possible for mad_queue to be NULL here without another bug,
so this can't be the right fix.

This is because:

		mad_priv->header.mad_list.mad_queue = recv_queue;
		mad_priv->header.mad_list.cqe.done = ib_mad_recv_done;
		recv_wr.wr_cqe = &mad_priv->header.mad_list.cqe;

And then we do

	struct ib_mad_list_head *mad_list =
		container_of(wc->wr_cqe, struct ib_mad_list_head, cqe);

So there is no point where the mad_list could be legimiately NULL'd
before getting here, something else must be happening, you must figure
out and describe how the NULL is happening.

Jason
