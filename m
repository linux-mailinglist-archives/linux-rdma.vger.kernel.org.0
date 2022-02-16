Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704644B8B0F
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Feb 2022 15:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiBPOIq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 09:08:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiBPOIp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 09:08:45 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810771019C3
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 06:08:32 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p9so4873531ejd.6
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 06:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Fl9maozPcwtbF9cd8ZWcxyr7pPC4HEwZm9Mf49Id+k=;
        b=t5GpnN/xkI8zOcda/Q+x7aOS4OTiBKdRrU5zpshXNkdsY6OUHPvrEXdkGkOdHQoa2r
         H4a99JjcsZiEyeq40PQkI+wpDMLRGFftDb7D97705+dzYkib1coA+lW/Bv3I74Ccq68s
         Q9sqIl/RF7kGf1Y7KNSV/eTQyxtQQ+9HjERh2Qjma27uKKCIXQxwtUJexF5rExyDbeH6
         8Q62BG8dArUJFjtsKG4oA6py1BZCIm1cxh084/WgKbPGSAXmV/3oItVE0fuQKX8VMGwU
         1C6QLPMNMesdAGOi2vGgKJLosX81ewZcx/eKjsjxN8BTNTHIIstGEdgxcr7VlwFf4kab
         j4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Fl9maozPcwtbF9cd8ZWcxyr7pPC4HEwZm9Mf49Id+k=;
        b=h881utfWpbdESQH6Y3knM/NJIHhOcqnH3ZbvXXkoXK3F3V1tynbDSM2t6CpHIbKVpq
         BX7/D3ohq/MNXjAeOEodImeTle+/OD8Y5weFbfZg/esqeJ/+84tcOLgVAbvNbKrEUaXB
         hLTX0ryHUjsqA5aP3fetj4uFkaywO3N8nDZ7Yib+nnBy+hoy/57qST6fAkwK5/VQhym6
         gZP18aNvqZzcPUxxZvnfIRe6Cnl0f9xT+Z5Yjr/iftFiceFWLAkBuKImGYGyD2hSvVo6
         ZYouaTKY5OToXdjqZPtj2h1kPPyksjqs/9QXZq5T5kpBHDtISMpsevbQWljSCxiEnURG
         h/yg==
X-Gm-Message-State: AOAM531rXz8d5BLB/GhvoK6usH0PkLYQld7cFIz+fbu7fAR6nWYXlf+V
        stoFRq2p5SUtz3R3slRWChX+00UOIFNIu0kPbofd
X-Google-Smtp-Source: ABdhPJyYC7WfaCGxiJT96l8qTVcjpEyp3V+Zlerl2yFK4TFp+Qe5jyFL6cL1EbT76Iefy38+AtZDj5rcdU7l0AVLtc8=
X-Received: by 2002:a17:906:a19a:b0:6cc:7ef8:475a with SMTP id
 s26-20020a170906a19a00b006cc7ef8475amr2635582ejy.490.1645020511075; Wed, 16
 Feb 2022 06:08:31 -0800 (PST)
MIME-Version: 1.0
References: <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com> <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com> <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com> <YgynQGK/xog1ugEd@unreal>
 <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com> <YgzIfyx7WyGb39mV@unreal>
 <38D3D312-E507-426F-BB3E-211AC273593B@bytedance.com> <Ygzo2nMVicb3jkAn@unreal>
In-Reply-To: <Ygzo2nMVicb3jkAn@unreal>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 16 Feb 2022 22:08:19 +0800
Message-ID: <CACycT3vr8QgjR8SS7bbOGOurV5jKP9bh90jiPnekEZhqHPwtcg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [RFC] Virtio RDMA
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Junji Wei <weijunji@bytedance.com>,
        Jason Wang <jasowang@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, mst <mst@redhat.com>,
        yuval.shaia.ml@gmail.com,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
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

On Wed, Feb 16, 2022 at 8:06 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Feb 16, 2022 at 06:03:29PM +0800, Junji Wei wrote:
> >
> > > On Feb 16, 2022, at 5:48 PM, Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Wed, Feb 16, 2022 at 04:00:53PM +0800, Junji Wei wrote:
> > >
> > > <...>
> > >
> > >>>
> > >>> What is the use case for this virtio-rdma? Especially in context of=
 RXE.
> > >>
> > >> Hmm... yes, we didn=E2=80=99t find one. In passthrough case we can u=
se RXE directly.
> > >
> > > It doesn't sound like a good sales pitch.
> >
> > Maybe I misunderstanded what you mean. We mean we didn=E2=80=99t find a=
 user case
> > for virtio-rdma with passthrough net device. Do you want to know the us=
er
> > case for our virtio-rdma(RoCE) proposal?
>
> Yes, please.
>

I think one point is: when running RDMA accelerated applications in
VM, the virtio-rdma solution should get better performance than RXE
since it has a shorter data path (guest app -> host dpdk, bypass guest
kernel).

Thanks,
Yongji
