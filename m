Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0BB4B96BF
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 04:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiBQDjG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 22:39:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiBQDjF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 22:39:05 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A4929C134
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 19:38:51 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z22so7316193edd.1
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 19:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uBUCt8Tflxu+ixBoYMG/T3H5mAGJQRqahsGMwny2PYM=;
        b=DD3/SMk9eqzqhTY1FvaG6hFNHRf7ssIvvH8gWt0OEJh4ks0tPhV5UVfbdzpu0yglVg
         l+nNGqzPYzSHXF38IZhO53bPbCfCdLrbKKAU90BFMtWg9h8jjE9sKc9PhjZ0rzY14Lng
         Ogbu3OWOF9BrPE0xl35Fqf4Rm6IrUY+YmyRSinK3AaFKIvF1zKG6QqwmPqyiXk9V/XG6
         JOGc9NpAGH6hoizdFi9/BMD4xmsKoQGkSZdAoJRmhhQRa7I+FSR7UjS435X+H/kZdZEr
         uguYULNXdG6uLEsiTBpoAgiiYrjepZhXnYoELJ+wlTqxcU+BVMh+cQdhi/vnXg6rmCAa
         5nIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uBUCt8Tflxu+ixBoYMG/T3H5mAGJQRqahsGMwny2PYM=;
        b=XutEvbpUYiljWvGEsHaSUGhDO/Nm9/MnVNiCmp7iHyMT13JI6HO8H6QOAoiAlbhjsh
         kE+8wL1n0dc7FmFAkknnLPsCPEiraiLfLx6Dj5SA2EOwHgPqRZCRNX9MA38QQt5Yasok
         6amEwfjH+toWF8CtKzZ4526JTvPIghu8OK08vfaNFF+4mC5oJ5UIi51uZ7Bwh0lXAD0K
         2NRw6q5IWuUBHQ4LeWC92iAIWH2LV9xsdvNM8hthb1bqkLr3jHY9FTY0gX5a7T+ZmWYm
         kR2i7xxG64GWDh7RSry4/Gx5A+OMUAZkzlQXvMtDOsxoLv9GGtYCA6HbEsmgAsEe1SqH
         XAYw==
X-Gm-Message-State: AOAM533VStKwJ9VcSHvL3BicG7I3/c9Dg+faSgNDAevmu6qEYYIfOgBJ
        64tCAe90gNXZeCOIvsgeDFCphEnAuJdaGSnF/qIL
X-Google-Smtp-Source: ABdhPJxiiAMXlK3Z9GMwpv1yusL2WhnipVM0wCUpVcFTiGRTr9Hnn6orZK8JuZ8eW7zbX2rftAfAR1/818VZcRQ9heE=
X-Received: by 2002:a05:6402:5248:b0:410:a105:49 with SMTP id
 t8-20020a056402524800b00410a1050049mr752223edd.214.1645069130533; Wed, 16 Feb
 2022 19:38:50 -0800 (PST)
MIME-Version: 1.0
References: <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com> <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com> <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com> <YgynQGK/xog1ugEd@unreal>
 <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com> <YgzIfyx7WyGb39mV@unreal>
 <38D3D312-E507-426F-BB3E-211AC273593B@bytedance.com> <Ygzo2nMVicb3jkAn@unreal>
 <CACycT3vr8QgjR8SS7bbOGOurV5jKP9bh90jiPnekEZhqHPwtcg@mail.gmail.com> <e7e530c8-5764-bfa6-b433-82ad590730ec@suse.de>
In-Reply-To: <e7e530c8-5764-bfa6-b433-82ad590730ec@suse.de>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 17 Feb 2022 11:38:39 +0800
Message-ID: <CACycT3utkPe3pUh1x+jNe53bWMR+=EiR4W6mC28RLXA22ZF12A@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [RFC] Virtio RDMA
To:     Hannes Reinecke <hare@suse.de>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Junji Wei <weijunji@bytedance.com>,
        Jason Wang <jasowang@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, mst <mst@redhat.com>,
        yuval.shaia.ml@gmail.com,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Virtio-Dev <virtio-dev@lists.oasis-open.org>,
        =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 16, 2022 at 10:21 PM Hannes Reinecke <hare@suse.de> wrote:
>
> On 2/16/22 15:08, Yongji Xie wrote:
> > On Wed, Feb 16, 2022 at 8:06 PM Leon Romanovsky <leon@kernel.org> wrote=
:
> >>
> >> On Wed, Feb 16, 2022 at 06:03:29PM +0800, Junji Wei wrote:
> >>>
> >>>> On Feb 16, 2022, at 5:48 PM, Leon Romanovsky <leon@kernel.org> wrote=
:
> >>>>
> >>>> On Wed, Feb 16, 2022 at 04:00:53PM +0800, Junji Wei wrote:
> >>>>
> >>>> <...>
> >>>>
> >>>>>>
> >>>>>> What is the use case for this virtio-rdma? Especially in context o=
f RXE.
> >>>>>
> >>>>> Hmm... yes, we didn=E2=80=99t find one. In passthrough case we can =
use RXE directly.
> >>>>
> >>>> It doesn't sound like a good sales pitch.
> >>>
> >>> Maybe I misunderstanded what you mean. We mean we didn=E2=80=99t find=
 a user case
> >>> for virtio-rdma with passthrough net device. Do you want to know the =
user
> >>> case for our virtio-rdma(RoCE) proposal?
> >>
> >> Yes, please.
> >>
> >
> > I think one point is: when running RDMA accelerated applications in
> > VM, the virtio-rdma solution should get better performance than RXE
> > since it has a shorter data path (guest app -> host dpdk, bypass guest
> > kernel).
> >
> And you can (potentially) implement RDMA functionality in the hypervisor
> by 'simply' to a memcpy between guests.
> (I know it's not simple. But you don't actually need RDMA hardware here
> and still should be able to provide RDMA functionality to guests.)
>

Yes, and I think we're able to achieve that with virtio-rdma when one
DPDK serves multiple VMs.

> And if you look at the current RoCE CNAs they operate in exactly the
> same way; there's a network interface, and _additionally_ an rdma
> device. So for the OS both will be detected as distinct devices, who
> just happen to run on the same PCI device.
>

Got it.

Thanks,
Yongji
