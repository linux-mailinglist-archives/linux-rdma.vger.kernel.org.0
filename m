Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFA151A21F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 May 2022 16:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbiEDO0o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 10:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345746AbiEDO0n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 10:26:43 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2498E20BC8
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 07:23:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id m20so3177349ejj.10
        for <linux-rdma@vger.kernel.org>; Wed, 04 May 2022 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0Mh/4vD/HhXdudQtlv1YaXpno59uauwKU4lLwLj6YU=;
        b=J4IfaD3aMlIRgPPZaA3poT8u9E96+wKyj829XyOeudIZHMPLFv9PA8mch70pWAo6w0
         CIQ0IsNGtApEtMbMUkTnd9/E9Obm92xb7UbJXwImPo5NxF3tlDujXm6ECcSviOEb29U4
         YdiyoHjuxo9h1Jf2CR7BQkwDNmod0zr08d0Hxee/+f6yfaFKc198g/Tfh7FrrxfjaDFI
         I5kgU7dJHBXv53/wuUX5emQgLNUIIkBKmwZITiDDKrX1vkizWN2YByg2U5FIAd8+n4c/
         2//ojLiHMDfUa5JzBaIfsBSJJl/7/5ci64mnwaE3gX5gB6uX5D74yheV0C77HXm8zEWu
         T8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0Mh/4vD/HhXdudQtlv1YaXpno59uauwKU4lLwLj6YU=;
        b=XnmLaU65j0YRml6hUEHDt2ZkDKzpIUVFow94KQHCljrvchLLkIPDLFGqQfEy2dLu4p
         lZRAZqnj2ERGOrD2+jiHYCE14fxQvEKBeT9zkJAzN/ui8D/XeTsPGpbrm29QTU9wUcsj
         iN7CC5Fl4F/9ZROAljxFGurjOxl5Pif+155jhXlT7eij8EALWvCkQJqmlbGH8V6WMpkS
         e5B+TerFnprCX4bIeUKSMI+vchHz6qtSRpScHLyudUKnp9+EiNKYLJBKuoctUY69bDFl
         GP1FBTDKX1GnrSA+wQ2jqHLHDpBdEIOmwQeeOy1Vor71PgrgnbOVU962fEzvpm/71XI4
         mJHg==
X-Gm-Message-State: AOAM5319j98RP577SAIOHy0CcGzC44+xrZReytXs+u/zhotEZRQh3/xE
        lnEcmD7E31kxafUBlF1maAh8rr7Vzaakw0RzdZxNLQ==
X-Google-Smtp-Source: ABdhPJwZ482rrvgpYw43COylJwoQv+dlEaGyCpt0VR79txRzH4n//eVCcoFxoOQ0UNc6rykvFI2wRzADg7gHo4qFspk=
X-Received: by 2002:a17:907:a420:b0:6f4:a22e:e27d with SMTP id
 sg32-20020a170907a42000b006f4a22ee27dmr6157606ejc.525.1651674185703; Wed, 04
 May 2022 07:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJpMwygqY4qwXfHd88wYs+KdKDEB=z=CzFd7jTVos-S3XNT5Yg@mail.gmail.com>
 <95d12c5b-83bb-dce6-750a-3827118b9aaf@linux.dev>
In-Reply-To: <95d12c5b-83bb-dce6-750a-3827118b9aaf@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 4 May 2022 16:22:54 +0200
Message-ID: <CAJpMwyhuOOgub4xxd6nB64c37yC82ogZCX4LB6WkUb721odLjQ@mail.gmail.com>
Subject: Re: Encountering errors while using RNBD over rxe for v5.14
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        yanjun.zhu@linux.dev, Jinpu Wang <jinpu.wang@ionos.com>
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

Hi Guoqing,

On Fri, Apr 29, 2022 at 10:26 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> Hi Haris,
>
> On 4/20/22 6:28 PM, Haris Iqbal wrote:
> > Hello,
> >
> > We are facing some issues with the rxe driver in v5.14 (tested with 5.14.21)
> >
> > After mapping a single RNBD device with 2 rxe interfaces, and with the
> > below fio config,
> >
> > [global]
> > description=Emulation of Storage Server Access Pattern
> > bssplit=512/20:1k/16:2k/9:4k/12:8k/19:16k/10:32k/8:64k/4
> > fadvise_hint=0
> > rw=randrw:2
> > direct=1
> > random_distribution=zipf:1.2
> > time_based=1
> > runtime=60
> > ramp_time=1
> > ioengine=libaio
> > iodepth=128
> > iodepth_batch_submit=128
> > iodepth_batch_complete_min=1
> > iodepth_batch_complete_max=128
> > numjobs=1
> > group_reporting
> >
> > [job1]
> > filename=/dev/rnbd0
> >
> >
> > We observe the following error,
> >
> > [Fri Mar 25 19:08:03 2022] rtrs_client L353: <blya>: Failed
> > IB_WR_LOCAL_INV: WR flushed
> > [Fri Mar 25 19:08:03 2022] rtrs_client L333: <blya>: Failed
> > IB_WR_REG_MR: WR flushed
> > [Fri Mar 25 19:08:03 2022] rtrs_client L333: <blya>: Failed
> > IB_WR_REG_MR: WR flushed
> > [Fri Mar 25 19:08:34 2022] rtrs_client L353: <blya>: Failed
> > IB_WR_LOCAL_INV: WR flushed
> > [Fri Mar 25 19:08:34 2022] rtrs_client L353: <blya>:*Failed IB_WR_LOCAL_INV: WR flushed*
>
> I got similar message but I am not certain it is the same one, pls see
> the previous report,
>
> https://lore.kernel.org/linux-rdma/20220210073655.42281-1-guoqing.jiang@linux.dev/

I went through the emails, and the error looks similar but I am not
sure if its related. The change to write_lock_bh was done after v5.14
I think, and the code where I am seeing this error still has irq
versions of those lock (e.g. write_lock_irqsave).

I don't have much knowledge of rxe code, hence I cannot really say for sure.

Thanks for the response.

>
> Thanks,
> Guoqing
