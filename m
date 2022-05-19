Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FD152C9F4
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 04:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiESC7b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 May 2022 22:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiESC7a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 May 2022 22:59:30 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EE0D80BD
        for <linux-rdma@vger.kernel.org>; Wed, 18 May 2022 19:59:29 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id v8so4846124lfd.8
        for <linux-rdma@vger.kernel.org>; Wed, 18 May 2022 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVF01/8xWouKqEqbME+Ea6nBUPZYz8Wohfnv43vZEpc=;
        b=VLADBNxEGqY+ci1nqq6k4FlynpwKlKrzfW9eWUzz8YqEU5EAEKpqE+AT9/g/gdClEj
         OUvYhTC4W4hfU7l3RBalaJ86GPJsnt9+7LRTCjFjuIWkuKVfI8JwXn8Z3tfnL0ohTEQR
         60sy9FMrs0nyyxLKP+qWXhND/ZRZbuhh0UgPJLDKT0Kvnxrm1N4gbt3qOs7YwjE7AAZF
         I4vWNVIj1HnXTb9YBjrVVEBdMIRdkOkUX8ipBq3NmCyYcxTfdYggibucW8QfpxMvYN/K
         vC/Tua0lnlSz7ltHNJuTduCR74S3cQqSt5pITE3Ho8U+m7a1ePknsDh18aJaXtZGQVWC
         kanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVF01/8xWouKqEqbME+Ea6nBUPZYz8Wohfnv43vZEpc=;
        b=XopLYFOzkdg6Ss2Zv4+4GRsncuS1iveVhSC6exgZF4V03ryTllo6h2YPt14OzQJtCz
         ODLSS83iAYcnjG0a1c4U3hdIpbTk1jrU3ueHA3ZPB5oTaZVKPi6Gr27tusfumRqePGpE
         Qxe7lzGbX52SpfbQ1d74E4PjkEyu33cwWPV2tgrOeyyr4iqEoniUm06ezQfPdh6MkAe+
         K5QQRt04UiM7IuLGOPuD0+SLJKV2UTV/2vvX0hdRK8OT/MJ6M4aQ0Jyxkpk9yQvt95XO
         VidCUBOkjuKMvOH8hw68JNX4dBokslnRnzk+ydDkBryMNNDhPlvIq/FRJHYvuO8ujq+s
         Uf8A==
X-Gm-Message-State: AOAM531xL7xpEnVlD9wgdIEDf3nhJ5kcQtOdHq7sO0K+W6Mu4U2QW4Lf
        0jvFqmwuUEgnrVdJR7ry6lV0mjMkIOViPfmBL4Q=
X-Google-Smtp-Source: ABdhPJy4jO0motMPE6JhK9jGFJN83IW9MTZtgL93QUPpNhAwgDtKaycrovCQFgl7fOsdbnkQEL33wYjbtyEnvBgaXjc=
X-Received: by 2002:a05:6512:34cc:b0:472:5c4e:34cb with SMTP id
 w12-20020a05651234cc00b004725c4e34cbmr1767244lfr.94.1652929167935; Wed, 18
 May 2022 19:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2205131542300.2577@gentwo.de> <CAGbH50sExgSNfgcaaa_s1DWbOu88Rr1=qYmh1A9Ynpo7TMj5SA@mail.gmail.com>
In-Reply-To: <CAGbH50sExgSNfgcaaa_s1DWbOu88Rr1=qYmh1A9Ynpo7TMj5SA@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 19 May 2022 10:59:16 +0800
Message-ID: <CAD=hENd9ODbRTouQOfQeOpZcCEjWv8s1JGeLeR4_7N0++QqbGw@mail.gmail.com>
Subject: Re: Redhat 9 removes RXE (SoftROCE) support
To:     Doug Ledford <dledford@redhat.com>
Cc:     Christoph Lameter <cl@gentwo.de>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
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

On Thu, May 19, 2022 at 7:24 AM Doug Ledford <dledford@redhat.com> wrote:
>
> We had too many issues with it in the past.  It might be getting better, I haven't been watching closely, but it had issues before.

Yes. Recently several patch series are merged into SoftRoCE. We will
do more work to make it better.

Zhu Yanjun

>
> On Fri, May 13, 2022 at 9:51 AM Christoph Lameter <cl@gentwo.de> wrote:
>>
>> I was surprised to find that RHEL 9 removes ROCE support after it was a
>> "tech preview" in Redhat 8. Its a good feature with many use cases here
>> and there for development, testing and production issues.
>>
>> Any idea why Redhat would not support RXE? Could we get a campaign going
>> to convince Redhat to include RXE?
>>
>>
>> From:
>> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9-beta/pdf/considerations_in_adopting_rhel_9/red_hat_enterprise_linux-9-beta-considerations_in_adopting_rhel_9-en-us.pdf
>>
>>
>> 11.2. REMOVED HARDWARE SUPPORT
>>
>> This section lists devices (drivers, adapters) that have been removed from RHEL 9.
>> PCI device IDs are in the format of vendor:device:subvendor:subdevice. If no device ID is listed, all
>> devices associated with the corresponding driver are unmaintained. To  check the PCI IDs of the
>> hardware on your system, run the lspci -nn command.
>>
>> Device ID Driver Device name
>> Soft-RoCE (rdma_rxe)
>> HNS-RoCE HNS GE/10GE/25GE/50GE/100GE RDMA Network
>> Contro
>>
>
>
> --
> Doug Ledford <dledford@redhat.com>
> GPG KeyID: B826A3330E572FDD
> Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
