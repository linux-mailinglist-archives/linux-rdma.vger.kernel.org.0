Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17DD6D0DAD
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 20:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjC3SYt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 14:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjC3SYt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 14:24:49 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38965D517
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 11:24:48 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5456249756bso370287737b3.5
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 11:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680200687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmR7pbNbG03fs19b/It7+D3GkB6GRXuwZRqKLb7dAzM=;
        b=apWUUUA07+XdbCfuuNUvu/6dzN1plKrdYJZrD1YlZHRW6XkMa55DX4fJSsjlEsJk3j
         NekpBF0gGwiLT8TVevAfMoHFXLeOZ/RmpFA8YNgNXQvpwggRcVyvNbYKVnqp9akjDfUX
         Z7UrHFAmTVHcKFI/YBGNXzp+NPQnYwwtjmHm39rJHXwZnQRIC1CB+BoYP4Hah+sITYrH
         3vD3VMu+V1cr6J5kfMCBTG4XCuneCiN1hIUAd7nwx73DG0bbjPTQwkd0TvQwBEhMNKGA
         Q5g4il/AqAj8nVHbwcEEkEUfPWb4uRJ9HBEukervEDhkteP9nDZLXmxBEHxTmIw6hugA
         tGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680200687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmR7pbNbG03fs19b/It7+D3GkB6GRXuwZRqKLb7dAzM=;
        b=7eKbqAm1l2Ca95wRqSgyBL247bUzdt1rPC/FUb0FYllCEGUkEol7L2sXKgciLLaxih
         Guwe++9SGER9JRD8aMOPt4Kr3vsz1GBTKsSQszcqGaBdKirRw2ux3409+WFoCKEc19Tc
         ftDZJ1RKDyTztMqMj1APL0VtxtDPAWAznSAkYJJGBzb6FJI7ZN6d8sCWZ1ETtXntKMhb
         M77craJh20FSoEYVrTGdRtI78z4OmT0v+q8BllmvGbPxWfwVGtXSrgbFadC2IVgFt26l
         8Q3/ZbP39Qp2GW6+FRQzQqw240Sd78CXMr86iAxDIq6gw8WZ+5olybxuMsMGWJa0iSLf
         7tvA==
X-Gm-Message-State: AAQBX9f1Ypi9OVX5hrKUd1AwtTFyMVBOdGDIQdAttgzvX0qCpPPB5a+E
        N3Bjag7LNAC85PFCJcIMHGS61Zch2qsK8zKScFPIeA==
X-Google-Smtp-Source: AKy350ZkTPPsxtQXGbsr6/uZu/T4vGgt5Fnb0QbsdijrgGtf+q5hi1H6DPEhUtPPQh0q6Tzg8hCAZMpMFUn6vHBDjI0=
X-Received: by 2002:a81:b388:0:b0:545:8202:bbcf with SMTP id
 r130-20020a81b388000000b005458202bbcfmr11439795ywh.9.1680200687351; Thu, 30
 Mar 2023 11:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <0-v1-789ba72d2950+2e-ib_virt_page_jgg@nvidia.com>
In-Reply-To: <0-v1-789ba72d2950+2e-ib_virt_page_jgg@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 30 Mar 2023 20:24:35 +0200
Message-ID: <CACRpkdYE79qxFCUWY5VCsvDqq-TvqbDgYMUAqsTP6NZHxaFYsQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA: Add ib_virt_dma_to_page()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 30, 2023 at 4:26=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:

> Make it clearer what is going on by adding a function to go back from the
> "virtual" dma_addr to a struct page. This is used in the
> ib_uses_virt_dma() style drivers (siw, rxe, hfi, qib).
>
> Call it instead of a naked virt_to_page() when working with dma_addr
> values encoded by the various ib_map functions.
>
> This also fixes the vir_to_page() casting problem Linus Walleij has been
> chasing.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Excellent, thanks Jason!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
