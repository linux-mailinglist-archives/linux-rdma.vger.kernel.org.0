Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABC9758AF2
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 03:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjGSBlI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jul 2023 21:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGSBlH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jul 2023 21:41:07 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F04D1BCF
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 18:41:06 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-791b8500a21so2004033241.2
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 18:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google; t=1689730865; x=1690335665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QG48Q+0dbgI97UN+LgjcJ9WpymrROcP+nlqL6Em6t8=;
        b=eJhoG91nLYC3yKy1pi16ZOaGom4CPmals0wthjTM5W5d9oCqKWTAYFBK9UHXHH3NdF
         XlU8ArL9x7Q698QQ53fURLASN+Q71tKWKqagplwzR43XRaPCKPvQ/wtr6nRdht21Kjg9
         3d6EqR6a24A/4+IUDVkHQMQxyHoYogOyaAoPTlgroW/PRKDnYfN3iKqc2OS09SYh/msC
         rRqfx87LRtvE8GbRT2UtYjnVF+dZyBrZ2LT7ZHmS7baySp66MIRg0cg18WByGUnKM8Gx
         ZkK631sgaroyeESeatKFTFGrV2NkEmR62QSUdfYHd8AZVZYaPbbyR1xVVyJbR/9Z5SbW
         1XtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689730865; x=1690335665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QG48Q+0dbgI97UN+LgjcJ9WpymrROcP+nlqL6Em6t8=;
        b=Cbd+UF3kLVKYumgyjgNe8xQz+2YLnZfu5r0vUNtCA4pjLsw8VFR+K+5X+/tuaqlxe+
         9UvTftnZVa33t+EmfMdeAlwR0kFEogbiSUC3om/ACp5iEaHBmHnB8Yv5+Wg34Q/bwqH0
         UnIql7lSgy77/UsVWJDpCSe3gxXHtxRc8BQKS7FGCrmBiH3nFbEOSNr0qNUnbldXNicB
         But8indUsPIHMeeHWx4+/86MLax6udy/N1ghXiaqJDtNpiD37OFfb02IzaMVxjWrRU/u
         9yJNrNjAW02QgDJNmZ5t8dewinT4hqtndkW/vCPOWGjmZSLn9CN7HpvaF3v715C5WhUS
         /4Xg==
X-Gm-Message-State: ABy/qLa8LXf7OhTMdJPskkYZEJfUvHw0tBYEgmtu6xRld3FlJZbecs6J
        xid/jCWtB6mkeW8IiVlZ0Mn9BKjyWtgttEogDswapurwYQm3o/qr
X-Google-Smtp-Source: APBJJlFKiz4RnltZvBG9mfFXYdea1JevemMqmrIrZDGTs9J7o/ieH/BnJ/iZUvs1bG0te4pgnraLP4UNVYD5n5ARD5c=
X-Received: by 2002:a05:6102:408:b0:446:da54:19a7 with SMTP id
 d8-20020a056102040800b00446da5419a7mr1998182vsq.1.1689730865067; Tue, 18 Jul
 2023 18:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cr5NVCpERLfudrTk-rhHez0uodnkbj5fp5X58zh3DFvfg@mail.gmail.com>
 <64BDF3A9-86BB-4F55-8F28-161C7B92ECDD@oracle.com>
In-Reply-To: <64BDF3A9-86BB-4F55-8F28-161C7B92ECDD@oracle.com>
From:   Jonathan Nicklin <jnicklin@blockbridge.com>
Date:   Tue, 18 Jul 2023 21:40:28 -0400
Message-ID: <CAHex0cqHgjRuxjGX1=t-OFUv6=5nMuVJE+oC6w2FC2p-OQichg@mail.gmail.com>
Subject: Re: mlx5: set_roce_address() / GID add failure
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks for the reply and the link. I believe that is a different
failure mode involving __ib_cache_gid_add(). In my case, there is no
traffic (the link is completely idle). And, the failure mode is
persistent no matter how many times I "toggle the link."


-Jonathan

On Tue, Jul 18, 2023 at 9:28=E2=80=AFPM William Kucharski
<william.kucharski@oracle.com> wrote:
>
> Yes - it's NVIDIA issue 2326155:
>
> https://docs.nvidia.com/networking/display/MLNXOFEDv590560113/Known+Issue=
s
>
> William Kucharski
>
> On Jul 18, 2023, at 19:06, Jonathan Nicklin <jnicklin@blockbridge.com> wr=
ote:
>
> =EF=BB=BFHello,
>
> I've encountered an unexpected error configuring RDMA/ROCEV2 with one of =
our
> 200G ConnectX6 NICS. This issue reproduces consistently on 5.4.249 and 6.=
4.3.
>
> dmesg output:
>
> [    9.863871] mlx5_core 0000:01:00.0: mlx5_cmd_out_err:803:(pid
> 1440): SET_ROCE_ADDRESS(0x761) op_mod(0x0) failed, status bad
> parameter(0x3), syndrome (0x63c66), err(-22)
> [    9.881250] infiniband mlx5_2: add_roce_gid GID add failed port=3D1 in=
dex=3D0
> [    9.889095] __ib_cache_gid_add: unable to add gid
> fe80:0000:0000:0000:ad3e:e3ff:fe92:b31b error=3D-22
>
> Device Type:      ConnectX6
> Part Number:      MCX653105A-HDA_Ax
> Description:      ConnectX-6 VPI adapter card; HDR IB (200Gb/s) and 200Gb=
E ...
> PSID:             MT_0000000223
> PCI Device Name:  0000:01:00.0
>
> Firmware is up to date. LINK_TYPE is to ETH(2) and ROCE_CONTROL is
> ROCE_ENABLE(2).
>
> Has anyone seen this syndrome? Any advice or assistance is appreciated.
>
> Thanks,
> -Jonathan
