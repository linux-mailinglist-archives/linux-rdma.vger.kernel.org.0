Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E64B182119
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2020 19:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgCKSpZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Mar 2020 14:45:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33249 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730715AbgCKSpZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Mar 2020 14:45:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id d22so2403868qtn.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2020 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T1iORqz7Rz2GqLkfrNyBvPHOv4t4QzJBOsi8bbupqhk=;
        b=hBNDkN+6XNzDazPEdHBidkHEN9Hq6Aw7HWDnLqGjkh92yrGoRRCtmWfgCpogqJQoIG
         lk7OY91PdkGo1VZTNocOlcn3+rc9L9+1EAuJMMhie4/uW0eE2Y+rLoFh/rvWHe0vws8w
         2ixqUtoMe8sLL6/6RL0X9EugsD94lynnCXy14/He0G6QBui6jn8Bt2sgt5rY7Zyfral8
         VGYkMwWIW3ks1shHj8Q/IkTR4zlZXmnn4AKO5zbXxSxdJ0vPEmQ81buKKAVjXDzeC7sm
         7OIkZ4WApfv8BrL7XQmESH0fPJBqVwaC1ijvyv4QUVBdAaWWCPtoboHzXpQJNTBsCboo
         quXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T1iORqz7Rz2GqLkfrNyBvPHOv4t4QzJBOsi8bbupqhk=;
        b=Can2WqACWz9XkqY/w11YfKr7Ie5hfZlpAacu+j3pVhPMd3TVU3SbZIO98hU15Cotey
         /yGjERynFFGn9L6oKAUtK5hPoGFt22ZSylzfaMYxLk09P28MZDD3vcQf76y5cbU2cNTq
         /RN6y25YcQRpJmvdwvTujlSgMJ+Lzc83NBtxsWhUBnA7CLo/b/beZ+HIgpNG6oPI/oW4
         v/supDgr46Wc6M1san9J4ZoANkRubDXnKFbksSXO+mVgkf5raiBhxrWbjV9s2U4VbmJ2
         i+1/tbIIAdi2YDqwRiz7kqKC8NQqb3+bDLg4CFEJfHHhgcicpP6kg8Jsub5D8yQIHxuC
         lUAg==
X-Gm-Message-State: ANhLgQ1KMpRI7YTWIQeN0XR/YWcxLh0K+7rBeO3609kkAMQlyuU0iRsr
        u2uBHeuXlKQDz8/G8vIEdOqqew==
X-Google-Smtp-Source: ADFU+vu5OsT+o+MGPfyeE+oPaf5QL86MVlUdTPJfR5q4z5/b6Nin0Mf2Dr2tJni8yo4Z36cZr93law==
X-Received: by 2002:ac8:718e:: with SMTP id w14mr3939550qto.266.1583952324002;
        Wed, 11 Mar 2020 11:45:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g49sm6810441qtk.1.2020.03.11.11.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 11:45:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jC6M6-0001Db-Sd; Wed, 11 Mar 2020 15:45:22 -0300
Date:   Wed, 11 Mar 2020 15:45:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v10 02/26] RDMA/rtrs: public interface header to
 establish RDMA connections
Message-ID: <20200311184522.GG31668@ziepe.ca>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
 <20200311161240.30190-3-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311161240.30190-3-jinpu.wang@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 11, 2020 at 05:12:16PM +0100, Jack Wang wrote:
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
> new file mode 100644
> index 000000000000..395d1112f155
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.h

> +
> +/**
> + * rtrs_clt_open() - Open a session to an RTRS server
> + * @ops: holds the link event callback and the private pointer.
> + * @sessname: name of the session
> + * @paths: Paths to be established defined by their src and dst addresses
> + * @path_cnt: Number of elements in the @paths array
> + * @port: port to be used by the RTRS session
> + * @pdu_sz: Size of extra payload which can be accessed after permit allocation.
> + * @max_inflight_msg: Max. number of parallel inflight messages for the session
> + * @max_segments: Max. number of segments per IO request
> + * @reconnect_delay_sec: time between reconnect tries
> + * @max_reconnect_attempts: Number of times to reconnect on error before giving
> + *			    up, 0 for * disabled, -1 for forever
> + *
> + * Starts session establishment with the rtrs_server. The function can block
> + * up to ~2000ms before it returns.
> + *
> + * Return a valid pointer on success otherwise PTR_ERR.
> + */

It is not so major, but the linux standard is for kdocs to be in the
.c files not the header - to make an index of kdocs for browsing I
think the sphinx stuff is supposed to be used.

Jason
