Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D4F13FC4E
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 23:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbgAPWnv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 17:43:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43554 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbgAPWnv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 17:43:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so10642129pga.10
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 14:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=StK6mCQeojQYfSNaCJiF94BEEGS98R/vhelyaxbgu6A=;
        b=iyzctcpZOh/cD8+hWHpgOyJgJ9WaMDWVR76GWjSPpjwICJ3JOcnEwnDu0eOTqsR7e4
         YfiFzRzZvX6ndf4128+vfXwwJ0AVn5fyTbNg8BtWH95iYbxGEgDUP/nODhSMFB1qdJcA
         cU5PRjJfDR0XahEozX2qNAdCrNKm0qHIS5ooq4iG88lOa3SA4RpnrsJ10X+ufq5E80LM
         dkWQl1dimcnEpTVVHCoy7vxBiciZPr+rlfgpD3G4meAgm3g0V0h5h5DAkXumDdxXn0ra
         8p0MWwFxceE9z7mm/SdI4JTyeKO9X+Hf/V6/Hn1H8DOt8kHhaaSx4/i35PehzLAMMca8
         pR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=StK6mCQeojQYfSNaCJiF94BEEGS98R/vhelyaxbgu6A=;
        b=pcJnhXZwJqbAgqoOfBFYo0tjofXZPHS9IvsDPbR/h/JJPCYtG8rSMEodYJVIYDmG40
         wXEaa9Gpkp4dznBxVhqG1UqX9E8Ve7kj/Fmqp6OvbM6DEbrTtDqpM9PlXgMGCLJsb+Ue
         cLtn2lKe/KTcKWwJoyHBDz6dQDzFT0N1TQtySVY1Ni1TwPpYC7uTtkZj4eYXw/axbV5u
         upT0Y2pmNf+SSD51+n8dl1x+HizX9w7jgoqaChNEwWOq8FwzQznFMiHcyFeWcI7iAvgY
         AUsJ2niNlNCV4vI++PGNeqHESchAnNt0gYtCEaCFKnzw5IC8p7LdyD6vRRkbr6LCnRfK
         akhw==
X-Gm-Message-State: APjAAAXFXWFR/g/Sj/FmYXswhIXaDZiWU2qE4YCGW5gS77phCdhwrMBQ
        A0/III/8Y7juZmhPt0yX0DtraqZ6lh+Kc/HxLyIaH8qp
X-Google-Smtp-Source: APXvYqxJ07At8EtQYJ8dkKsBLN+K3Hk8+6I4E0D4nFyqeQvCfgv7ZHY8Es4Q3Gk+4BZkAmSX3Vdq8t9UjHXT36v1B7A=
X-Received: by 2002:a62:e215:: with SMTP id a21mr40193966pfi.3.1579214630106;
 Thu, 16 Jan 2020 14:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20200116222658.5285-1-natechancellor@gmail.com>
In-Reply-To: <20200116222658.5285-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 16 Jan 2020 14:43:39 -0800
Message-ID: <CAKwvOdmFbojiubviQYqwJLLpCLky_bpOH4jYjy4WCbOinPRYuA@mail.gmail.com>
Subject: Re: [PATCH] IB/hfi1: Fix logical condition in msix_request_irq
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 2:27 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/infiniband/hw/hfi1/msix.c:136:22: warning: overlapping
> comparisons always evaluate to false [-Wtautological-overlap-compare]
>         if (type < IRQ_SDMA && type >= IRQ_OTHER)
>             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
>
> It is impossible for something to be less than 0 (IRQ_SDMA) and greater
> than or equal to 3 (IRQ_OTHER) at the same time. A logical OR should
> have been used to keep the same logic as before.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/841
> Fixes: 13d2a8384bd9 ("IB/hfi1: Decouple IRQ name from type")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch. LGTM.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/infiniband/hw/hfi1/msix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/hfi1/msix.c b/drivers/infiniband/hw/hfi1/msix.c
> index 4a620cf80588..db82db497b2c 100644
> --- a/drivers/infiniband/hw/hfi1/msix.c
> +++ b/drivers/infiniband/hw/hfi1/msix.c
> @@ -133,7 +133,7 @@ static int msix_request_irq(struct hfi1_devdata *dd, void *arg,
>         if (nr == dd->msix_info.max_requested)
>                 return -ENOSPC;
>
> -       if (type < IRQ_SDMA && type >= IRQ_OTHER)
> +       if (type < IRQ_SDMA || type >= IRQ_OTHER)

-- 
Thanks,
~Nick Desaulniers
