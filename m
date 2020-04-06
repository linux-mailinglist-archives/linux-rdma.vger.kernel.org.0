Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 131B419FBF5
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2020 19:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDFRp6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Apr 2020 13:45:58 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:34947 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgDFRp5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Apr 2020 13:45:57 -0400
Received: by mail-qv1-f66.google.com with SMTP id q73so405899qvq.2
        for <linux-rdma@vger.kernel.org>; Mon, 06 Apr 2020 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J/J6AHUyotnIiFmQX9OTUP014Taxxd2jE+7ne4baBAw=;
        b=B0sqhiR6bWDAECtMqwojYOVwfMBg6dX+8dXSIsMET5K7BRv0vApJFrFGbNxLUvhNRU
         HjwuyKEXUu6qTiW3EKTo9Eou64P2YZYMyfkX0LDiwbUADDnvPZ4fOi6Gqp0LF220cteu
         8emOVtm9Y4SY6SDffIef3UWYaZyhFDVYfYkW+Tg0VKgi/9SLgSnOpKsJBl+b+7E1YHY3
         7BXGsU3S2KHDR4BKpEkrxOKeu8uqWZox9/qWOEPYQPB+UV69P7cjdHZLmVU++3Oxk1OR
         dwl2k8yUUhk2jNEKZLIdqivqNcxGVr3p3JY9GTm+FT9Nfg0baSe8cC/L1edBhpuyvXgg
         DA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J/J6AHUyotnIiFmQX9OTUP014Taxxd2jE+7ne4baBAw=;
        b=oUqB99FekHdaUmODPqp9tMABfEiYJcxIoVqlL4JgbXdeH5XrI5+/8uWILH1q1gGkOG
         BTWk8NuKYxseQQdPusteohxLCinrHp6+hmJjMxGv1I+yw1hi8CqnqoKC6wQONRnEAWEa
         jpExm51ujvbFI5LlfCdd3uBq1RtfpByMRCjbP6Xktr0vTBvBvTHEG5qNBEqgoXgAcCtA
         r02nqw2haKSUAmyoqQLp+pyG3APwCnDu+Nn0nhjy3MrYayD2IapcMwu8OKmBusKfsCKs
         SggZAe4qP/DVC5WKKGPwyAdklGMu8RAhW+Y/dHNrfxx172LCs11R9o62yVbwAItGozpv
         Mj8w==
X-Gm-Message-State: AGi0PubWr8ROJuF34eIIR9NHfIVBFyGs8hGfoNBjA0aBoI6xFMEnyMwd
        WUKZaw/Ylcy6nB6yTmS+XHQ3FA==
X-Google-Smtp-Source: APiQypIwD55oZJ9yG/cWVwdPgiYEb8WpcO0zcXRREV/5YLHm2a0n+vnWFVbCVBc73QujVxowZGllkw==
X-Received: by 2002:a0c:f701:: with SMTP id w1mr883519qvn.126.1586195156991;
        Mon, 06 Apr 2020 10:45:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 125sm4380861qkn.38.2020.04.06.10.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 10:45:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jLVoq-0008U3-3g; Mon, 06 Apr 2020 14:45:56 -0300
Date:   Mon, 6 Apr 2020 14:45:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/cm: Fix missing RDMA_CM_EVENT_REJECTED
 event after receiving REJ message
Message-ID: <20200406174556.GS20941@ziepe.ca>
References: <20200406173242.1465911-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406173242.1465911-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 06, 2020 at 08:32:42PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The cm_reset_to_idle() call before formatting event changed the CM_ID
> state from IB_CM_REQ_RCVD to be IB_CM_IDLE. It caused to wrong value
> of CM_REJ_MESSAGE_REJECTED field.
> 
> The result of that was that rdma_reject() calls in the passive side
> didn't generate RDMA_CM_EVENT_REJECTED event in the active side.
> 
> Fixes: 81ddb41f876d ("RDMA/cm: Allow ib_send_cm_rej() to be done under lock")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/cm.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index bbbfa77dbce7..06f8eeba423a 100644
> +++ b/drivers/infiniband/core/cm.c
> @@ -1843,11 +1843,9 @@ static void cm_format_mra(struct cm_mra_msg *mra_msg,
> 
>  static void cm_format_rej(struct cm_rej_msg *rej_msg,
>  			  struct cm_id_private *cm_id_priv,
> -			  enum ib_cm_rej_reason reason,
> -			  void *ari,
> -			  u8 ari_length,
> -			  const void *private_data,
> -			  u8 private_data_len)
> +			  enum ib_cm_rej_reason reason, void *ari,
> +			  u8 ari_length, const void *private_data,
> +			  u8 private_data_len, enum ib_cm_state state)
>  {
>  	lockdep_assert_held(&cm_id_priv->lock);
> 
> @@ -1855,7 +1853,7 @@ static void cm_format_rej(struct cm_rej_msg *rej_msg,
>  	IBA_SET(CM_REJ_REMOTE_COMM_ID, rej_msg,
>  		be32_to_cpu(cm_id_priv->id.remote_id));
> 
> -	switch(cm_id_priv->id.state) {
> +	switch (state) {
>  	case IB_CM_REQ_RCVD:
>  		IBA_SET(CM_REJ_LOCAL_COMM_ID, rej_msg, be32_to_cpu(0));
>  		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REQ);
> @@ -1920,8 +1918,9 @@ static void cm_dup_req_handler(struct cm_work *work,
>  			      cm_id_priv->private_data_len);
>  		break;
>  	case IB_CM_TIMEWAIT:
> -		cm_format_rej((struct cm_rej_msg *) msg->mad, cm_id_priv,
> -			      IB_CM_REJ_STALE_CONN, NULL, 0, NULL, 0);
> +		cm_format_rej((struct cm_rej_msg *)msg->mad, cm_id_priv,
> +			      IB_CM_REJ_STALE_CONN, NULL, 0, NULL, 0,
> +			      cm_id_priv->id.state);

This can just be IB_CM_TIMEWAIT instead of cm_id_priv->id.state

Jason
