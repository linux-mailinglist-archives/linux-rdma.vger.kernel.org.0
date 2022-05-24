Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F36D532B5E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiEXNeI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 09:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbiEXNeG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 09:34:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907599AE7B
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 06:34:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gh17so22352107ejc.6
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 06:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRQNi94LqcusrvgCFkNRkPqgAhh/dvrRsWbtCZXQCJ0=;
        b=MDCZs7CKTUghu9QtJJcaHfSZGRVRKCCdQgKY1qWLmQ1IUxt73H/AcNJ0/hTtDXy1mo
         PdnPjNGGhOdd9eU0ZcQubSBkZbF+zySkDvIUBgw+RBQxlu8uoHDsQbtbFouqwQ2yOi+q
         ukhebd7iBGSr58X8lVZichZ0OYsAG7QGwcOKBYkxi3id7KAnQHoeAGI7Xx6W2BpE8ltU
         061egMBPScK8iamjcJZ6l0+Mgt2xd14e8717hhhxn+4rFs86uyoizFxxZgX8dk2dQKl3
         1j6ejrYSju3qXJNxv7hAzJ0t7bFAha2S1yQV2H0BFLPOqW/4kQ65pygHCJ6eY3ZrJfGN
         Ml6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRQNi94LqcusrvgCFkNRkPqgAhh/dvrRsWbtCZXQCJ0=;
        b=rs8SMSKdaC8bNQSWCsmJ3hboPj3R35a1P5R3bfbiIQ5+jH5+XzvNVMDiyXTjH3UnsL
         l6sotzp5fm/crEM4UNqoKDXEPBvClmOXx9nPq6v4ZpvnteMblbO6iXCq7VcT2GOTr8HD
         lCyvKmoqC8fyrCBM4AJ99ooO3c8uUe5z2Wud1B8vyX6i9WHmZc6AZShD+q+blB5oobwV
         BquVOLlalTJJf61WlPyyRvhf1LyqNgGoz6PGm9D1cAqmOAHTWXcas2I01vSnErkHE8q1
         ufBjwSD9rVj8xqA1o0u8mMQhTAh1jTfohNy9Ph0aQy7BK6JQ9Jo9cacN9yfUCW4tcLxB
         DmRg==
X-Gm-Message-State: AOAM531yMm9JmnpLuwX9DJcujyVKsgetAlPkPpf8rS5NmCA3yDUw1Qdk
        1QNRbMzsa24PLQABHvvavrxSt+Z7jLwBeNunuJG2Vj3LOdM=
X-Google-Smtp-Source: ABdhPJw36nZKyNKRG/AOTiNCbikWU3yUkWcRwnrnVCoislz9aFX5bi2vIHARAqGTY3gskOdx4Q5NdqR3oWNxSc1yudI=
X-Received: by 2002:a17:907:6d8e:b0:6fe:c382:1fab with SMTP id
 sb14-20020a1709076d8e00b006fec3821fabmr12843899ejc.483.1653399243947; Tue, 24
 May 2022 06:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAFMmRNyHUSg6_+af9W39e36aCx2a=_9WC8MB08W9XfnMKoYXAQ@mail.gmail.com>
 <YoyEPnFpd7/mI1Mm@unreal>
In-Reply-To: <YoyEPnFpd7/mI1Mm@unreal>
From:   Ryan Stone <rysto32@gmail.com>
Date:   Tue, 24 May 2022 09:33:52 -0400
Message-ID: <CAFMmRNxS56xWoZ_-Sz4yBrZvK95vdpQR9xrxjDhkAAGi3krK=A@mail.gmail.com>
Subject: Re: Possible bug in ipoib_reap_dead_ahs in datagram mode
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 24, 2022 at 3:07 AM Leon Romanovsky <leon@kernel.org> wrote:
> IPoIB in mlx5 is HW offloaded version of ulp/ipoib one. AFAIK, it doesn't
> change "tx_tail" and we won't enter into this if (...).
>
> Thanks

I don't quite follow this response.  Is this the if statement that you
mean that we won't fall into?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/infiniband/ulp/ipoib/ipoib_ib.c#n682
