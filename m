Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91332009C3
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgFSNRL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 09:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgFSNRK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Jun 2020 09:17:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C95C06174E
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 06:17:09 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dr13so10162326ejc.3
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wOjmdghDgCr0CVW/w+ANaHsM9R02N+bI2f+Qakkg04=;
        b=AdMIDDOm48JzlgAbMfmdT7CMIHIeIBvHJyz7mPGtN6zJk4LwqgxpN/hZGdVo0VASAt
         Lyw5m3PubCEZ+10hrq5KRfJX+fVs3MMW8GT4hHjcTe00VvX7WXAvB/G5cJfB+LXHAIGd
         3122mSxKPYSxh37gtVhMYpuVAfPn6lcGEM2sgOE9gdVa0zSKXwwbwypwKkFYGd38UjIL
         fg4a0/oV1LuvsP4jJwib7V3BXTCwIsOP2GvedZQw10ii3DEtcC/andJeIqgYz9O+nbah
         mqJ0BBHzsja5eM9n1nypxvL8hTTxM4/cJRLCCvUeVE8VfFnEJ5rnD/4xpsZXAptDK1aI
         W0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wOjmdghDgCr0CVW/w+ANaHsM9R02N+bI2f+Qakkg04=;
        b=a2T8o8sMXjQZ77rr82IbPYz8uHRTNg7EtN8fGYj848HbJYh3VN6EOBPOYGX8U8DRn+
         9S9+txn90heeSVp90EmC6hLMeRhqur9piUWEak013EUkEWFZtkFLCfhjTL9GYWBr7nAv
         PU9IPDOq8bZfTWChQTl+qg+S+HUclyUo/Pex1n0sR9gfc6rZKiC+ptT4ymzDJeH4Av5G
         7xGpEz/kdtmLXXgl5C0RzNInd490X7lflw9mgoYv+NZqJDCd9mZEN6vjs0vzSlcHuifl
         xpRRIgpDD3XY6gaR3JFuqqKerc7A/YXnw73t8rKL1QeHzzKzoElUdGJHTVCD1WoZf5rQ
         +cnA==
X-Gm-Message-State: AOAM5304LuKIee50cqZNFgG0kgYyMyoPVcPrr+/Pyg+TxrqfBaGgCvFM
        szbegMHgqpBJ668N+YijdNn//Kc2ZhivKTO/fI4edRaeGZA=
X-Google-Smtp-Source: ABdhPJxcJ/168e4c4toRNAYbOlSZtqzl1xPYGZjvMPOjLLgjxFymZskBfiH8Awgduu4mn5iXcuuVMzfkSuTwlK9Vlgw=
X-Received: by 2002:a17:906:fc13:: with SMTP id ov19mr3575299ejb.212.1592572627815;
 Fri, 19 Jun 2020 06:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200619131017.pr7eoca2bzdtlbk4@debian.debian-2>
In-Reply-To: <20200619131017.pr7eoca2bzdtlbk4@debian.debian-2>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 19 Jun 2020 15:16:57 +0200
Message-ID: <CAMGffEntL4XkF6bCuhUDP+AOBO4mpKK1pTe3NgPUW86ySyy7Wg@mail.gmail.com>
Subject: Re: [PATCH -next] RDMA/rtrs: fix potential resources leaks
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>, ledford@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, Bo,
On Fri, Jun 19, 2020 at 3:10 PM Bo YU <tsu.yubo@gmail.com> wrote:
>
> Dev is returned from allocation function kzalloc but it does not
> free it in out_err path.
If allocation failed, kzalloc return NULL, nothing to free.
>
> Detected by CoverityScan, CID# 1464569: (Resource leak)
>
> Fixes: c0894b3ea69d3("RDMA/rtrs: core: lib functions shared between client and server modules")
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> index ff1093d6e4bc..03bdab92fa49 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> @@ -607,6 +607,7 @@ rtrs_ib_dev_find_or_add(struct ib_device *ib_dev,
>         else
>                 kfree(dev);
>  out_err:
> +       kfree(dev);
>         return NULL;
>  }
>  EXPORT_SYMBOL(rtrs_ib_dev_find_or_add);
> --
> 2.11.0
>
