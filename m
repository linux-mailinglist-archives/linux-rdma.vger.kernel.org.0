Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DC11E13B9
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 19:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389056AbgEYR6P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 13:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388621AbgEYR6P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 13:58:15 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03973C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 10:58:14 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id z9so8302716qvi.12
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 10:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U/UDfcLT6vDz7pTR3v3gZEfqU5cQ92Hzitksv06ps7A=;
        b=S6ZWuNKHG4o6U/MGyadmPKI1ISRpV9ZCgLzYiHchSAealOgXW6aeCSAEugqkL/b/1g
         cyHzNSSGI5/G5zDIdlOsLLuTlqnws/VZp1RBqrjq3AKifzIXE5iiYaoFwMedb/nv3ROS
         HkQH1jD+danazKdGXFq1Me2EuYL2b9c8cFw/kNTSjCie8gHGO6gsPrejn8lRf40JdNXT
         MxPhbaAuU6Ya9kN3QLGandBnGIurIGuZ3XgF8YHZNj9EI6Vn9LCZq6oAV3Mt8uF9HxEa
         UN468pfIBnqHT/6jyjW6nYFgRKxcEch3dwZnfA5UNwDlNKWcFnAx6J3Vp/nhijLJ3T2s
         AoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U/UDfcLT6vDz7pTR3v3gZEfqU5cQ92Hzitksv06ps7A=;
        b=PtttIutRh5h5QKUaVZZJYSUU5CzC+JmF5/gBsr9mhVrIJHzjnXDgY7zOR6ZShVJgEE
         1MNYkHrsP0LzBCZOdbd07tw7vvB/mpbA8I4LEIINqVqveMVDZ2/ezqnCTpCycrpmV/D7
         I4eiegpOuuehrmKq6O1YHCBlGx9hOXDlvEuJb7bwaVtkl5t2loJ8drb8QP/S4Kdh/2yT
         BvMt6OZKbub4/ijJ+nsQsMvrk7Q4JmxarP/JAfPg9QzSoJ7ImBq21fI00urEEitpC4Sn
         cZitllFvxqIirA8WKtgOXQPHZxrzOJtNAG/NQDW6Ru2Oo9hx9zTXpcmoECgylSsGMhBj
         E+Xw==
X-Gm-Message-State: AOAM531LKRBNP3Jfe9QHgHrkn3rWuW31fOeDEUXtbp3kZIEBG1LENNnF
        uOvmJ/Fq1vvigcNIEaUJa5ejDg==
X-Google-Smtp-Source: ABdhPJypGQodIqm0k6HEPZRXBSPFjfWTH73dOEHtDP/wXJIKHSYaOZ44pstgWgio/VnmPwqMJTvJQQ==
X-Received: by 2002:a0c:a993:: with SMTP id a19mr16551381qvb.57.1590429493265;
        Mon, 25 May 2020 10:58:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x36sm2858227qtd.97.2020.05.25.10.58.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 10:58:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdHMa-0006ex-AW; Mon, 25 May 2020 14:58:12 -0300
Date:   Mon, 25 May 2020 14:58:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 5/7] RDMA/cm: Send and receive ECE parameter
 over the wire
Message-ID: <20200525175812.GB24366@ziepe.ca>
References: <20200413141538.935574-1-leon@kernel.org>
 <20200413141538.935574-6-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413141538.935574-6-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 13, 2020 at 05:15:36PM +0300, Leon Romanovsky wrote:
> @@ -2204,6 +2220,12 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
>  		IBA_SET(CM_REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg, param->qp_num);
>  	}
>  
> +	IBA_SET(CM_REP_VENDOR_ID_L, rep_msg, param->ece.vendor_id & 0xFF);
> +	IBA_SET(CM_REP_VENDOR_ID_M, rep_msg,
> +		(param->ece.vendor_id >> 8) & 0xFF);
> +	IBA_SET(CM_REP_VENDOR_ID_H, rep_msg,
> +		(param->ece.vendor_id >> 16) & 0xFF);

I'm pretty sure the & 0xFF isn't needed?

> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index ed2c17046ee1..b67cdd2ef187 100644
> +++ b/drivers/infiniband/core/ucma.c
> @@ -362,7 +362,6 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
>  
>  	uevent->resp.ece.vendor_id = event->ece.vendor_id;
>  	uevent->resp.ece.attr_mod = event->ece.attr_mod;
> -
>  	if (event->event == RDMA_CM_EVENT_CONNECT_REQUEST) {
>  		if (!ctx->backlog) {
>  			ret = -ENOMEM;

Extra hunk?

Jason
