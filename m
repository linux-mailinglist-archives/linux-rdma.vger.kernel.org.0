Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843CC4951CD
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 16:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376515AbiATPwO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jan 2022 10:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376802AbiATPwN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jan 2022 10:52:13 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F2EC061574
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jan 2022 07:52:12 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m3so23523384lfu.0
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jan 2022 07:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23N8DNBO9UGt9YdIGtiyw2ndgsL8WHLXK1qy+LNDw+c=;
        b=eTr9fcf+LGBgl64W0gCsrP8agnh/cQLm3KLGqS0QNROGHgJfVHNAT2buOD28NqEZO2
         VIloy+ST1n8kabIFPfgX+HiknwW3m9HE8DflVMp3oO4EtEnvH3Fwvhxia2Dvy1HHeWg8
         z1Mm5hDssbBy+/1NzyiaD6VXNVE66WIJXq5rfgV2ZfK+G/ENSAPCSdbOkHbVWHEWqE9W
         Rij2Q4saWu7xK4kFxzBeUKMgH9zSgZeihtS386aSEc3X9vtuNQF4oxemyiyzXxvo9xRo
         /6CdJjsC2+e7PLhgqwp/8dceg2x5kYXLMaGq5NcbnOaPT1ShYuuQkSGbyK9zhG4zdYjx
         bNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23N8DNBO9UGt9YdIGtiyw2ndgsL8WHLXK1qy+LNDw+c=;
        b=Dr1OWB/I5swmOauHGVKaYjH5dR3geQV5gCUFgW2dElA13WwtoI+2hRu0Zrb+MBs7L7
         9wbtlrRk22/cjdBtOG7JQJeyKaRPPmCu/Ob+JoPtPgATLVs+hWh9UQWJ1KDM1spqzaa6
         0bOOBo6We3T9dYlCFVv/R7Obz71D3wLd3gHOERjuoKJV/fBs6qtP6hayNkX4oEMaL20J
         04ZgfUgTKEuo4hiwCumPjNERBHIMWles75WNsgZm0Cbs1rs4N3Vl0r1NrQqeH2Cryayu
         bdqIJsR7q5HOlSxsf+paHXsgfUfZfjpoV2XbeiS6E4BH/4qiKsT4GgGkmlucWOksh187
         F/oA==
X-Gm-Message-State: AOAM533G1Nvd/iaewW33AyWB0Yc5GREHXW2GlNDivr+TXTBoI0zyeSOR
        jT77gJfMPIjWDXAx4PTaTToScQNNopY346KnPEG6JH3AdLOSzA==
X-Google-Smtp-Source: ABdhPJw0K1gnNRobGFC3xyAWW5NyzXK5NJanxOp9/QVOHouEEpShXupZttepFz8j55VTgV4grqegL/jfiD5LsX7KEGc=
X-Received: by 2002:ac2:4193:: with SMTP id z19mr21892313lfh.358.1642693931121;
 Thu, 20 Jan 2022 07:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20220120143237.63374-1-jinpu.wang@ionos.com>
In-Reply-To: <20220120143237.63374-1-jinpu.wang@ionos.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Thu, 20 Jan 2022 16:51:59 +0100
Message-ID: <CAJpMwygoxcXLrSgKDL7EJDzvNieEVFvTCyxLPZHvTu0prEEkcA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs-clt: Fix possible double free in error case
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        jgg@ziepe.ca, Miaoqian Lin <linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 20, 2022 at 3:32 PM Jack Wang <jinpu.wang@ionos.com> wrote:
>
> Callback function rtrs_clt_dev_release() for put_device()
> calls kfree(clt) to free memory. We shouldn't call kfree(clt) again,
> and we can't use the clt after kfree too.
>
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Reported-by: Miaoqian Lin <linmq006@gmail.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index b159471a8959..fbce9cb87d08 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -2680,6 +2680,7 @@ static void rtrs_clt_dev_release(struct device *dev)
>         struct rtrs_clt_sess *clt = container_of(dev, struct rtrs_clt_sess,
>                                                  dev);
>
> +       free_percpu(clt->pcpu_path);
>         kfree(clt);
>  }
>
> @@ -2760,8 +2761,6 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
>  err_dev:
>         device_unregister(&clt->dev);
>  err:
> -       free_percpu(clt->pcpu_path);
> -       kfree(clt);

If dev_set_name fails, it would end up not calling the release
function since device_register has not been called yet, hence
pcpu_path, clt wont be freed.

Sending another patch in sometime

>         return ERR_PTR(err);
>  }
>
> --
> 2.25.1
>
