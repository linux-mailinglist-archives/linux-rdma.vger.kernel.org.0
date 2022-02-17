Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E9B4B9988
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 08:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiBQHDV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 02:03:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiBQHDU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 02:03:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 263DC193D3
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 23:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645081385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XAcM5qWp9LOu57crXYeSSJOc+RWnSl1IKBihSIbkX8Y=;
        b=fsOhLuR74jeSLSx5yDyRHYZZ0aynGrNBl3NNtAJ7yu0lm4aflqCitIIktr3+rMwMkkjbS2
        ICfL9xVpFdSQ7s7mIFQQnlIrgLUTHaiV4G5JW0870rQjl9r/VcWEYexUzXh4uRDQ9cEmmm
        4ZDpMawL7UpEdQ/PrJQjObjyTbGfkSc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-yCgxEDyhNYKKRwa7o1oE3w-1; Thu, 17 Feb 2022 02:03:03 -0500
X-MC-Unique: yCgxEDyhNYKKRwa7o1oE3w-1
Received: by mail-lf1-f72.google.com with SMTP id a5-20020ac25205000000b00443a34a9472so343213lfl.15
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 23:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XAcM5qWp9LOu57crXYeSSJOc+RWnSl1IKBihSIbkX8Y=;
        b=5ayvgUK2qRpgQxxgcRO9QZm6f5P0eqZAay0GPoxFO72b+ODOj5AONI3oe6Sm4L3R+w
         nt5yiku0CMtcX0/0+pOSMO+sIBQnlplc12Xj6z4J2rLckVCfMh2uV3KS5awMjoOy2wlk
         nKHWYf47wBgzwx33kVPJsTwzPjt9kn57ajyR6OQRZbA/oOmBDUMh1mze8HgZZLuBzNoa
         1STwfbhKTbf8gEj0i7CuGBqc7pqqxkIIg0Z8yhp2bVWyL9zZ0yzquS59QmO5pZpyk0sV
         QEEhZejBu4rdUt2BAJYPHQZHAywKeu/3TH2Pk0UwmfPQ1CtAExmbQGEJWxYWnzXO8TgS
         U+tg==
X-Gm-Message-State: AOAM532ax0fuHTzqMoD/MQ6OB+V30B47UIObU3ZJ28nY7LOP4F88yatt
        dHdPA5DnTaWWERiob3Wo73LBVG6SClN+gpLMk3nlxrUrdGNClswECVaL7tv8KFHaO1l60o3f7c+
        Ri+n9fwK6ditE2sgHrXC4iI8GsYOTSMdlMbVEOQ==
X-Received: by 2002:ac2:4194:0:b0:442:ed9e:4a25 with SMTP id z20-20020ac24194000000b00442ed9e4a25mr1118111lfh.629.1645081382010;
        Wed, 16 Feb 2022 23:03:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHa7S25ZxFjABQe3t0iQo2koLuC8ai8HQ2vdaDJd+2cket1pYmfkSy7zJYXUbbbt/1mMF9E4yFhbF6SO3vsfU=
X-Received: by 2002:ac2:4194:0:b0:442:ed9e:4a25 with SMTP id
 z20-20020ac24194000000b00442ed9e4a25mr1118100lfh.629.1645081381829; Wed, 16
 Feb 2022 23:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20220215081353.10351-1-weijunji@bytedance.com>
 <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com> <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com> <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com> <YgynQGK/xog1ugEd@unreal>
 <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com>
In-Reply-To: <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 17 Feb 2022 15:02:50 +0800
Message-ID: <CACGkMEvP1dJv81Jy9aQV3GyrAFiYqt_y8rhz2O15wP9SWMeing@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [RFC] Virtio RDMA
To:     Junji Wei <weijunji@bytedance.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, mst <mst@redhat.com>,
        yuval.shaia.ml@gmail.com,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Virtio-Dev <virtio-dev@lists.oasis-open.org>,
        Yongji Xie <xieyongji@bytedance.com>,
        =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 16, 2022 at 4:01 PM Junji Wei <weijunji@bytedance.com> wrote:
>
>
> > On Feb 16, 2022, at 3:26 PM, Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Feb 16, 2022 at 03:13:11PM +0800, Junji Wei wrote:
> >>
> >
> > <...>
> >
> >>>> We can't. So do you mean we can implement virtio-rdma only for IB in=
 the future?
> >>>
> >>> It's probably virtio-IB but we need to listen to others.
> >>
> >> Agreed, one problem is that there might be some duplicated works.
> >
> > Once it will be needed, the code can be refactored. IB and RoCE are
> > different from user perspective, so combining them into one virtio-rdma
> > module doesn't give too much advantage.
>
> Yes, code would be fine. But there maybe some duplicated contents in spec=
.

We can carefully design the interfaces in order to eliminate the
duplication in the spec.

Thanks

>
> >
> >>
> >>>
> >>>>
> >>>>>> And currently virtio-rdma doesn't have a strong dependency on
> >>>>>> virtio-net (except for gid and ah stuffs). Is it OK to mix them up=
?
> >>>>>
> >>>>> There are a bunch of hardware vendors that ship a converged Etherne=
t
> >>>>> adapter. It simplifies the management and deployment.
> >>>>
> >>>> Virtio-rdma is not depend on virtio-net, we can bind it to another e=
thernet device
> >>>> via mac address in the future. And is it too mass to mix up two diff=
erent device
> >>>> in one spec?
> >>>
> >>> So either should be fine, we just need to figure out which one is
> >>> better. What I meant is to extend the virtio-net to be capable of
> >>> converged ethernet.
> >>
> >> Got it. One question is whether there will be some cases that user wan=
t
> >> to use virtio-rdma binding to other types of ethernet device such as
> >> passthroughed net device. In this case, we don=E2=80=99t need a virtio=
-net
> >> device actually.
> >
> > What is the use case for this virtio-rdma? Especially in context of RXE=
.
>
> Hmm... yes, we didn=E2=80=99t find one. In passthrough case we can use RX=
E directly.
>
> Thanks.
>

