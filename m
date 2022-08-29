Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590865A4AF6
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 14:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiH2ME4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 08:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiH2MEb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 08:04:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0368BD4
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 04:49:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gb36so15110279ejc.10
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 04:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yuHdVt0/eo9ZST6J7H4oWl3nRFDUlOktmfCexGEC3Vk=;
        b=SVn0jn695/IQMfX2BtfxLOVQ8Y7pakyvV+4srnNkCKBYoAyH5T0HsIImchR8s+IzLT
         MlkI3FekLG4p66s9SKKbJM8hsbFs0buGOFovO3To8OYc8HB1AIVedPZINIWqBvQkO2jr
         MeLi1YChRNQMgKLZzWJBz87c/wPks1WR/SIazNTei8vq676tqO2VSoiSwbrp9Y1LViAY
         vqcneFJUoKNyLs/1Atn6RqzLdhZSJ341j+trxCPlTLX8bBesTHUEvTXxEVgfDm748TF2
         mVjudU6KRF7JeGtKMEXGfOqW3ZOqY+iwlIV7j+uqaZvqrLKNpN0UVyH2UtwaRRKqmNcb
         x2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yuHdVt0/eo9ZST6J7H4oWl3nRFDUlOktmfCexGEC3Vk=;
        b=iJ7Qlknj+rgySNXTThKwrBOBsSEsH70zx7Wu+1dr+i6sKCDId2zFcGdNNt27pEwy5m
         CYGG9AzFkGNWvF0TcQKGJf8CwhczvgrG2xk/Q0b+l/zHKLGuqXd32fAUtbJdxZyeKJq+
         llZL1cWvrkTG+BmJo4LE6c1/Ztctu/RdwvqWYUkrJCvnpyIHc7Y23VDPSUc6eVaak6Jz
         IyiEe2yyDGcZcLeCEh+pkNQiQVpLskH5XRWuYIBPvBjBgKsMN6jWNrOb0AdnJIeqQ2aJ
         4f1oF4p8Fcri2FGg1LMryWlbIxpeJAg6UXcDFmH8+wAdzgO528ajRf4sP3PybttP3+sj
         9fcg==
X-Gm-Message-State: ACgBeo0q+lWOa9eX1xXDbF8AO0Q9LDEMXGppFW8vZbXoMrUdKsx2lNYM
        6r62RuinbYTPKpElLy1r2LL8/LQgCX7w18BB0Kk5PuO6h7Y=
X-Google-Smtp-Source: AA6agR4rFvN/HFYBxKgvh5InjZkk/uG8RWVmM8EPYr7XL1XqXc3hzMaYwMooJflvjwGn4sqk6i0xL9VnhWwE+Mfero0=
X-Received: by 2002:a17:907:75ec:b0:741:484b:3ca4 with SMTP id
 jz12-20020a17090775ec00b00741484b3ca4mr6916830ejc.316.1661771588049; Mon, 29
 Aug 2022 04:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220826081117.21687-1-guoqing.jiang@linux.dev>
 <CAMGffEku8H3RubkQGq1Cjy8pP8B+95coT+b2J6VxSAQx-kKmmg@mail.gmail.com>
 <aa3a4d50-2e71-a185-09ac-79bd34f9c8e6@linux.dev> <CAMGffEkRo104Cp6+KX8NtS0ud+DHM6ftjmHyxjiQa=zJ7tFzog@mail.gmail.com>
 <c4fb6007-91f9-6d2c-4888-d49a08dd297e@linux.dev> <CAMGffEkAYOJPAPaHDspk-JfJNNF96pHWnrCwYzROFZxPBBO+Fw@mail.gmail.com>
 <09317a03-4e29-0f8b-4d7e-a2024c9364f6@linux.dev>
In-Reply-To: <09317a03-4e29-0f8b-4d7e-a2024c9364f6@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 29 Aug 2022 13:12:57 +0200
Message-ID: <CAMGffE=kUGmntpJSmtd_hTSTXPQxRfKquBsggBRn6TyrCKyiGA@mail.gmail.com>
Subject: Re: [PATCH] rnbd-srv: remove 'dir' argument from rnbd_srv_rdma_ev
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, jgg@ziepe.ca,
        leon@kernel.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 26, 2022 at 4:02 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
>
>
> On 8/26/22 7:58 PM, Jinpu Wang wrote:
> >> And I guess we can just pass parameters with register after remove an
> >> argument,
> >> otherwise need to push/pop stack with more than six parameters for x64.
> > I doubt it makes any notable performance change.
>
> I think it is called in the IO path (process_read and process_write) ...
>
> BTW, do you agree if the 'usr' can be dropped from rdma_ev given it is
> always
> same as 'data + data_len'?
in the current form, yes, usr  can be dropped. we can add later if
there is a need.
>
> Thanks,
> Guoqing
Thx!
