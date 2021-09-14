Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA79740B7C3
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 21:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhINTUH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 15:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhINTUG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 15:20:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6ADC061574
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 12:18:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i25so655318lfg.6
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 12:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YxCg+Ff5e18Lo5SLxz2RohY8wIeS7mnNr94SiNjtXE=;
        b=MAAULZ4URU5MTmtKRWymxurd+Zu6ETEEDIunC1m5EtPyL8I0MQlFAdKvzoK6qKJomw
         qw+saZ9NCqKKF9FlwDUGiOyvAmlXYwOF7O3XP4wRG7NSrfOZmJl87gAFOG1J81g9q+cH
         6RYe0cCAP/vNZGkM9eljVjR19I9Wsiig/vp+dlTY3kKRu6LBouisQGPCSZevvSD+j1Qm
         IMpSzG0iUHG2aS7hXlnBYZkL121q/rK08HRxTbmFHXzxag0mEdnq45lBKQTVY9k1hege
         j3iPe+iLBkLXELjnu+2QuWmJYHoxfj2wYKlz1JgJc8TN2fiasfHOhgBpaAzPDjrKMCHn
         CIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YxCg+Ff5e18Lo5SLxz2RohY8wIeS7mnNr94SiNjtXE=;
        b=Gcc47bYPym90izaSpEe4FiHIQfoJrPJY9pQZ7u98zIFNYvnkOT30CqtbJGc0wHfRNx
         2dYBYK3c9vBPFJLMhEjs1SW9o4+eNwM9Kq1HRQbZYW4Xtz7rMZMWLYnMfEZa8EhhNPLj
         1GmFDgOtvnLg4l3MG47ZE8JxLXuTVFw7KIJ9UiQnzXgKOO0UjLYTRS7jbFkm6zMo9aGF
         wIvbxvucUMXKTCRHCQcaQz5sZDvkytnv3WkWjSUoX/BBXWvzGPhZXt6ZLkReGF8qlrXH
         +0shUNjVPXaaD+g9y1un6pHnffCF1XWwdZ+xAbJWSgZdsYO707xUXZOD6tafzKzPaHNK
         OwaA==
X-Gm-Message-State: AOAM531K6kcUDvbpWEavEjjGND5x60t5Qm8MDNkE64jrX56hCByD+uLw
        L/5d3J0ffxJBna7Kfi5qNalMyzEy2kFamYtUXrO7sg==
X-Google-Smtp-Source: ABdhPJw16ccf80fVUt2Ftx18ZwpsavjrFkyaXZ38lNAQGEztzwddr/2uECAcEJCIiz5gjGcanzI2I0+0jH3Kicyx5S0=
X-Received: by 2002:a05:6512:318a:: with SMTP id i10mr14931868lfe.444.1631647126453;
 Tue, 14 Sep 2021 12:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <0-v1-1b789bd4dbd4+14b16-clang-fix_jgg@nvidia.com>
In-Reply-To: <0-v1-1b789bd4dbd4+14b16-clang-fix_jgg@nvidia.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 12:18:35 -0700
Message-ID: <CAKwvOd=Py3qAmn5e1gqWPe9bhzQ6pwmjRsRyqf+KBtwd7OQbyg@mail.gmail.com>
Subject: Re: [PATCH rc] IB/qib: Fix clang confusion of NULL pointer comparison
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 14, 2021 at 12:01 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> clang becomes confused due to the comparision to NULL in a contexpr context:

s/comparision/comparison/

s/contexpr/Integer Constant Expression/

I don't think constexpr is the equivalent to an ICE. We know what you
mean though. :^)

>
>  >> drivers/infiniband/hw/qib/qib_sysfs.c:413:1: error: static_assert expression is not an integral constant expression
>     QIB_DIAGC_ATTR(rc_resends);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/infiniband/hw/qib/qib_sysfs.c:406:16: note: expanded from macro 'QIB_DIAGC_ATTR'
>             static_assert(&((struct qib_ibport *)0)->rvp.n_##N != (u64 *)NULL);    \
>
> Nick found __same_type that solves this problem nicely, so use it instead.

Sorry, Nathan found that.  Should be:

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the patch.

>
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/qib/qib_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Hopefully third time is the charm here..

:^)

>
> diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
> index 452e2355d24eeb..0a3b28142c05b6 100644
> --- a/drivers/infiniband/hw/qib/qib_sysfs.c
> +++ b/drivers/infiniband/hw/qib/qib_sysfs.c

Consider explicitly including <linux/compiler_types.h> in this
translation unit.  I know it may compile today, and it might just be
our internal style guide talking here...

> @@ -403,7 +403,7 @@ static ssize_t diagc_attr_store(struct ib_device *ibdev, u32 port_num,
>  }
>
>  #define QIB_DIAGC_ATTR(N)                                                      \
> -       static_assert(&((struct qib_ibport *)0)->rvp.n_##N != (u64 *)NULL);    \
> +       static_assert(__same_type(((struct qib_ibport *)0)->rvp.n_##N, u64));  \
>         static struct qib_diagc_attr qib_diagc_attr_##N = {                    \
>                 .attr = __ATTR(N, 0664, diagc_attr_show, diagc_attr_store),    \
>                 .counter =                                                     \
>
> base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
