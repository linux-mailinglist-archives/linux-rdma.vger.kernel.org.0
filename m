Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7536E7599AA
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 17:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjGSP0j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 11:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjGSP0g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 11:26:36 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643B410D4
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 08:26:27 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-44358c019ddso2498599137.1
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google; t=1689780386; x=1690385186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JukgVsbDHKr1MqAolgv3lVT+a4db5PmVajsRBUO6KK0=;
        b=KSjSFaBpKK2Zgp90kdVd/YE66ezqbFWLOFuUZheTN/Sz/OAyJ8V5MuoXUBp9VzuNmh
         rWdqbb1LWLPrS40qAXa3jjJ+aGMvr4ZkgcPtHHGHFszMBNuKdiI2MYwcWgSfAfFVy+AE
         715y+j5L1T74MRQ2OqrhrA+eGSnQtebfhRWG7G5PfOEldwcBtQu2GwPJBRTx+RJZtfKZ
         sjoVKYELsiLZ5m+BeHm4KiIYSiopBnXH0VhlX4Djiz27WKOkfgpINz8/cZ61LdxsASW8
         rLbGe2FdoklKsTBbPjbpsv9MHfJSUfvaTBrx4QieGbC9qCPCEqbVzLdaFO3vrl9IRFIR
         YJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689780386; x=1690385186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JukgVsbDHKr1MqAolgv3lVT+a4db5PmVajsRBUO6KK0=;
        b=h6VoZY4IebsiSpmUZcvFagni/G/6Ql7RMiLyLt8xPu/glrzZVueLioxt8TQ36KPdqB
         CYgwilpWMEBaVrD2v6sHo0ziTGUqHit1pkDF1uLJ4WIUmMizQz+TmYTOa3HnIjlnCTvU
         qnK91tm/tdooh6i0VXPhtNUMn7LKMaov4XyHZs5W0Gev1U0GIWOMTmSVKUsgztHQ4TkZ
         r7U8YquQOQGdZe2MOdZJ8tmUka3yUfHaw51nll/sOcn8i4Ox77WkpRRCXuwMHxjEkd0Y
         BUxmmI8eWt5YzANYTyNGcku3Li1g1zUZZGuZF6ETRpH7W0mWhggBuBCriPm4zn4DAzB9
         Ff5g==
X-Gm-Message-State: ABy/qLab6+mMMaK7mmywk0DlkR3UnwYerBkBj/31gspZV0KPZhXoxPt0
        xd8XYMa8vV8eFqtT8Q6PzCsfHmZRjC+r8FO04tuM1utHh0uEMLZJN5I=
X-Google-Smtp-Source: APBJJlHJjStUvS+vXXtBW2VhvEJKiPh6u0hvC/pcRo1CzJb1Sd66LN+lE0TXFfzxFjqJR2bG4hq3VaGB0K+cmSh7D8w=
X-Received: by 2002:a67:ef89:0:b0:446:afff:90ce with SMTP id
 r9-20020a67ef89000000b00446afff90cemr8545600vsp.34.1689780386448; Wed, 19 Jul
 2023 08:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cr5NVCpERLfudrTk-rhHez0uodnkbj5fp5X58zh3DFvfg@mail.gmail.com>
 <64BDF3A9-86BB-4F55-8F28-161C7B92ECDD@oracle.com> <CAHex0cqHgjRuxjGX1=t-OFUv6=5nMuVJE+oC6w2FC2p-OQichg@mail.gmail.com>
 <7256cf0a-4a4e-2c28-b74a-21026769d43f@nvidia.com>
In-Reply-To: <7256cf0a-4a4e-2c28-b74a-21026769d43f@nvidia.com>
From:   Jonathan Nicklin <jnicklin@blockbridge.com>
Date:   Wed, 19 Jul 2023 11:25:50 -0400
Message-ID: <CAHex0cpt_0zU7A1h3scMuZp97faYV5uKi_U06D_GYCe7zHaqxw@mail.gmail.com>
Subject: Re: mlx5: set_roce_address() / GID add failure
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     William Kucharski <william.kucharski@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks a ton, Mark. That's precisely what the issue was.

-Jonathan

On Tue, Jul 18, 2023 at 10:08=E2=80=AFPM Mark Zhang <markzhang@nvidia.com> =
wrote:
>
> On 7/19/2023 9:40 AM, Jonathan Nicklin wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > Thanks for the reply and the link. I believe that is a different
> > failure mode involving __ib_cache_gid_add(). In my case, there is no
> > traffic (the link is completely idle). And, the failure mode is
> > persistent no matter how many times I "toggle the link."
> >
> >
> > -Jonathan
> >
> > On Tue, Jul 18, 2023 at 9:28=E2=80=AFPM William Kucharski
> > <william.kucharski@oracle.com> wrote:
> >>
> >> Yes - it's NVIDIA issue 2326155:
> >>
> >> https://docs.nvidia.com/networking/display/MLNXOFEDv590560113/Known+Is=
sues
> >>
> >> William Kucharski
> >>
> >> On Jul 18, 2023, at 19:06, Jonathan Nicklin <jnicklin@blockbridge.com>=
 wrote:
> >>
> >> =EF=BB=BFHello,
> >>
> >> I've encountered an unexpected error configuring RDMA/ROCEV2 with one =
of our
> >> 200G ConnectX6 NICS. This issue reproduces consistently on 5.4.249 and=
 6.4.3.
> >>
> >> dmesg output:
> >>
> >> [    9.863871] mlx5_core 0000:01:00.0: mlx5_cmd_out_err:803:(pid
> >> 1440): SET_ROCE_ADDRESS(0x761) op_mod(0x0) failed, status bad
> >> parameter(0x3), syndrome (0x63c66), err(-22)
> >> [    9.881250] infiniband mlx5_2: add_roce_gid GID add failed port=3D1=
 index=3D0
> >> [    9.889095] __ib_cache_gid_add: unable to add gid
> >> fe80:0000:0000:0000:ad3e:e3ff:fe92:b31b error=3D-22
> >>
>
> Seems this syndrome indicates it's a multicast source_mac which is not
> allowed. For more information please contact your Nvidia support
> representative, thanks.
>
> >> Device Type:      ConnectX6
> >> Part Number:      MCX653105A-HDA_Ax
> >> Description:      ConnectX-6 VPI adapter card; HDR IB (200Gb/s) and 20=
0GbE ...
> >> PSID:             MT_0000000223
> >> PCI Device Name:  0000:01:00.0
> >>
> >> Firmware is up to date. LINK_TYPE is to ETH(2) and ROCE_CONTROL is
> >> ROCE_ENABLE(2).
> >>
> >> Has anyone seen this syndrome? Any advice or assistance is appreciated=
.
> >>
> >> Thanks,
> >> -Jonathan
>
