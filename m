Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AE028B61E
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgJLNZo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgJLNZo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:25:44 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E033C0613D0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:25:43 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id c22so23196369ejx.0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BTRKoDykAFzbZsRB1ZvBZjzR34QM9xnl7IX+p+cxnpI=;
        b=Z+cprnYGTsz2dJ3uNVrlytwU2WdZ0I3vKyd126cGnIT6e9AQ5siSFBRHiT9QCoM3Rp
         aEW1BkmW7rZeelwGPi1griQooY4hrgsscL/oIkzD4KYibSVtQVXRm3JjG91nqDASTugB
         43ZuhtLDAsnmtnpBrrGsi6JpxE9Cm9aH/wXeB6HZh/eJ0CSnW8lF1fc+JoWqzywMQFGH
         a+16cUkQlGbJdOellCq/9uvoluHAL6BFtLHJk6SyLOYkJXtT4ZdZUF+dApM6XYEbE5ld
         8hJOf3XhRYzM7mZG36Tdx4HngAvlazbn0Bvl5QJ9A+kT+iiedP2uR71SqVGoMLNAALSf
         utqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BTRKoDykAFzbZsRB1ZvBZjzR34QM9xnl7IX+p+cxnpI=;
        b=Id9jrIcSc9aMDszIzKlytX1MxOnNhVI9w6FAai8ooNz/I5P5RyrLAa8q7m1uD38zM1
         qvDob3uhKkfEnK9lxCMnKJsTFxSU2UFi573Eb1+UMFJkOXvFBaMJJhyziJcDlnTB07XQ
         UvZZRVef4sux2coIHum5wr/NM5hY8/BCqZmZpgsHjInjrag0RJMty3MdRKpyRs1RFqEt
         jBwRZSED6ZFG9UdEZ0m+IFwi17swFLrAH9Ii/eLLHmjMcyWwQTrb24nG/N2g5STU7AYI
         kuvlOLNr37ObX8iOvS3tybFi3YF1rsXqaUO3NM2AsU9iU+QHL5PgKw/D+0O2nRhbf7V/
         Nuhw==
X-Gm-Message-State: AOAM533trdRIMKHTe+TR8VDG9ven7cbHasZP1nTqs/d1ilwoHz0tPx3l
        nZYl2awjdrLaQJDSDIc48gv1uBGIuJuedfGf3ElBiO5s43k=
X-Google-Smtp-Source: ABdhPJwshOfmo3hfyu7QLtbByMZNrsduA4TQeUm9kL6DFQxbAV/hrzuWHCKcLOfxH5boeQCURbsqZdGVDBSVf+khPzM=
X-Received: by 2002:a17:906:c78a:: with SMTP id cw10mr29068400ejb.478.1602509141669;
 Mon, 12 Oct 2020 06:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com> <20201012131814.121096-6-jinpu.wang@cloud.ionos.com>
In-Reply-To: <20201012131814.121096-6-jinpu.wang@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 12 Oct 2020 15:25:29 +0200
Message-ID: <CAMGffEnKHqfypoZAKWXOhCW9X9QjnQ_Wo4hMw2R6R3ncXeaZkw@mail.gmail.com>
Subject: Re: [PATCH for-next 05/13] RDMA/rtrs: removed unused filed list of rtrs_iu
To:     linux-rdma@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 12, 2020 at 3:18 PM Jack Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
>
> list filed is not used anywhere
>
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
sorry, this one is already in Jason's tree, please ignore.
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> index 287ff78921c7..7821ac4e827b 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> @@ -114,7 +114,6 @@ struct rtrs_sess {
>
>  /* rtrs information unit */
>  struct rtrs_iu {
> -       struct list_head        list;
>         struct ib_cqe           cqe;
>         dma_addr_t              dma_addr;
>         void                    *buf;
> --
> 2.25.1
>
