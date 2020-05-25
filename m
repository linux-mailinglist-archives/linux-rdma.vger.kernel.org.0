Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF7F1E137D
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 19:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389192AbgEYRlp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 13:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbgEYRlo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 13:41:44 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A329C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 10:41:44 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v79so8008532qkb.10
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8UcWD5D1wwxzhfsGEBGm49XhuXL3H0Ykhk4NPXLLAKg=;
        b=B61ra54F8UBIJzgd9KT+hDQMzQXyizF3Z+XTC4pAWDOtqX+TZNUBT04S/Y/IHNd+3j
         QnXXQ5Y4VViUKrqc6VFN6Wl1Q9vTITVoJIBTh1lBmMtzOo3VMhEZRaHggzJocK/J5aYf
         vz94rbyE0frajcG4ZuROji6KFT6bc0tOY1g8ZdFHUyJA7e6wo/FFZPc7xlRGgU18lcVr
         3aq8fdopB/vwInhYpKvScbGpyXhMeIMmwEAcwD6XDbN+3yR7Xm3PUSgRHgdxvGLPvptB
         fHLFZCNJ9DqqeICFRNdDcSJTPjkAIokp3ASesqJWvJP1u+zi2xgKWkD+XReDyA6dmMc/
         RAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8UcWD5D1wwxzhfsGEBGm49XhuXL3H0Ykhk4NPXLLAKg=;
        b=tUuami8CgHhXh9GjIhQfeKxyFcPRcTbxG++c1sflRY5hm9BhI9YLt5EaVg/R7PuQGc
         YVn1YbEPNH+fPCUbk9AqdhpnLz696ZUyMCTxj44y9F6DTxdTqeYuS37gbTBjdkEQ5ZU8
         eevHtSg3gbnw0Jm6W5uSZ4vQ+xm6bsFfmdFz6+uak5IDSepsDfnn4pDKWRHDE+TL3jDK
         OUjuPwRi6J2LAth29YTGyZEhDBGQNIrnYNxddr21lNOKMMR/bKVSPYD1R02WHfXBuorc
         GIZ+wV7Mooh2+RXSPIYRqbYMpUHvHkRB0vrHx4bzBtQDSu7lJaoUvYAlAVaJdxyAwpOk
         95Hw==
X-Gm-Message-State: AOAM531YyZWHyuGfZL1o04/padaPOskzN+wFU/SHWMVNSPLJpTsppwke
        T1Qt/YkEwa66qQnK3Yi12LRc6w==
X-Google-Smtp-Source: ABdhPJzDpNS+f0a7ecYz7FbirK735U26rAt/LJHSSAd8IZuQZxrGOvzy09uoUN1QYSmFT/SXIHR/Qg==
X-Received: by 2002:ae9:ed0f:: with SMTP id c15mr4312785qkg.55.1590428503349;
        Mon, 25 May 2020 10:41:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id e22sm14575865qts.2.2020.05.25.10.41.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 10:41:42 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdH6b-0006MK-Tx; Mon, 25 May 2020 14:41:41 -0300
Date:   Mon, 25 May 2020 14:41:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 3/7] RDMA/ucma: Extend ucma_connect to
 receive ECE parameters
Message-ID: <20200525174141.GA24366@ziepe.ca>
References: <20200413141538.935574-1-leon@kernel.org>
 <20200413141538.935574-4-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413141538.935574-4-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 13, 2020 at 05:15:34PM +0300, Leon Romanovsky wrote:

> -	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
> +	in_size = min_t(size_t, in_len, sizeof(cmd));
> +	if (copy_from_user(&cmd, inbuf, in_size))
>  		return -EFAULT;
>  
>  	if (!cmd.conn_param.valid)
> @@ -1086,8 +1089,13 @@ static ssize_t ucma_connect(struct ucma_file *file, const char __user *inbuf,
>  		return PTR_ERR(ctx);
>  
>  	ucma_copy_conn_param(ctx->cm_id, &conn_param, &cmd.conn_param);
> +	if (offsetofend(typeof(cmd), ece) <= in_size) {
> +		ece.vendor_id = cmd.ece.vendor_id;
> +		ece.attr_mod = cmd.ece.attr_mod;
> +	}

The uapi changes in the prior patch should be placed in the patches
that actually implement them, eg one here..

> diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
> index 71f48cfdc24c..86a849214c84 100644
> --- a/include/rdma/rdma_cm.h
> +++ b/include/rdma/rdma_cm.h
> @@ -264,6 +264,17 @@ int rdma_init_qp_attr(struct rdma_cm_id *id, struct ib_qp_attr *qp_attr,
>   */
>  int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param);
>  
> +/**
> + * rdma_connect_ece - Initiate an active connection request with ECE data.
> + * @id: Connection identifier to connect.
> + * @conn_param: Connection information used for connected QPs.
> + * @ece: ECE parameters
> + *
> + * See rdma_connect() explanation.
> + */
> +int rdma_connect_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
> +		     struct rdma_ucm_ece *ece);

kdoc's go in the C files

Jason
