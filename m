Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B84F4B96A1
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 04:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiBQDY7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 22:24:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiBQDY6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 22:24:58 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3EE2804FB
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 19:24:44 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p14so3781245ejf.11
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 19:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3t7JedNkFfGZQFN+BBQu302a3o6+jsSS6A8so9gaUAs=;
        b=QSfRgqWILuOIp2B9AhKsERE0grgqohVdHEvelVzFV48tttJiMwCNf6vZFsDSJvDQKV
         0v9OVm3y5BpntBAL2aey+bQqOoqMBD8Se+rJa+/sa5nc8Rsm8/TvPCa4K751md66JH/u
         JvCWN/x6myA7iXlGPRME/vRAxJmDfdZilT8r5rmq6IaEo+FQIGkquWkNkrX46Vi5ATZx
         TvRb/urrdV3ROFXsVH0uTO+u84cfHGPxbyquvs7dACtcJTiRtLbXSuDo6FvLvOOagL4x
         ds9bLROa7pOK/5xBalDslo1sPy7vQ0ZK1H3mCA5VOFSaMY0BY1vU7+232Hau4fa7rWYv
         vY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3t7JedNkFfGZQFN+BBQu302a3o6+jsSS6A8so9gaUAs=;
        b=Xxtcr+TfWGks5sUvCI5Tk/lZnf1aLcOM4JhOV/nhT3R2OVruHq8CAx7iwLIX2Y5f+i
         vGFSQurORUUFTfT1XiQ4LSK0BWtnUEComZXM9GAOo6UQ2PbyspYjJLKeGyjiTPsxrChY
         kHzDcj7+m/uwmkawEuiflj2YDyKd+ARqWIivObvwI66aNU0/Ulx6rmzaKeBaoNxIjDsA
         q/Vxp1Yp3zXzrXfaUV0/VrlvJohGY9mtqQ9cxkSQFiajtZ2yHcb0rPCdI/DBpVgtzJsj
         auSYte1b6caF7dwy5F499jLOJ8LMPQc6KDbFrnnRdNaVWptAa/fiMP+LkfZMepW9eIW5
         6fTA==
X-Gm-Message-State: AOAM5335gZep+0VR5Hodr3tnqkhiRBffKCwOUed8NQJP6gzKNeMm7mVi
        CFWw5mHLGCUAjn6Gmrcuy/Q5+ivlLjXXuLzNIL4y
X-Google-Smtp-Source: ABdhPJwBPnD4CZRNzFhVSAIw4ch260REzrCF+QWED0z9DbknoJf+2gMVUpqMpHJqi2goPHD/dmijgT+A4BnumCDwstw=
X-Received: by 2002:a17:906:974e:b0:6bb:4f90:a6ae with SMTP id
 o14-20020a170906974e00b006bb4f90a6aemr830015ejy.452.1645068283536; Wed, 16
 Feb 2022 19:24:43 -0800 (PST)
MIME-Version: 1.0
References: <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com> <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com> <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com> <YgynQGK/xog1ugEd@unreal>
 <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com> <YgzIfyx7WyGb39mV@unreal>
 <38D3D312-E507-426F-BB3E-211AC273593B@bytedance.com> <Ygzo2nMVicb3jkAn@unreal>
 <CACycT3vr8QgjR8SS7bbOGOurV5jKP9bh90jiPnekEZhqHPwtcg@mail.gmail.com> <CAGbH50s1oPDRZ5VqCOkaQHvsw_OvhHMmt0UVBsmeNjhX-Xqquw@mail.gmail.com>
In-Reply-To: <CAGbH50s1oPDRZ5VqCOkaQHvsw_OvhHMmt0UVBsmeNjhX-Xqquw@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 17 Feb 2022 11:24:32 +0800
Message-ID: <CACycT3ugx+pRAYRpLq-KCiEWMJP8GLv7HRYKF3TMNHFSQXBXfw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [RFC] Virtio RDMA
To:     Doug Ledford <dledford@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Junji Wei <weijunji@bytedance.com>,
        Jason Wang <jasowang@redhat.com>,
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

On Wed, Feb 16, 2022 at 11:42 PM Doug Ledford <dledford@redhat.com> wrote:
>
> On Wed, Feb 16, 2022 at 9:08 AM Yongji Xie <xieyongji@bytedance.com> wrot=
e:
>>
>> On Wed, Feb 16, 2022 at 8:06 PM Leon Romanovsky <leon@kernel.org> wrote:
>> >
>> > On Wed, Feb 16, 2022 at 06:03:29PM +0800, Junji Wei wrote:
>> > >
>> > > > On Feb 16, 2022, at 5:48 PM, Leon Romanovsky <leon@kernel.org> wro=
te:
>> > > >
>> > > > On Wed, Feb 16, 2022 at 04:00:53PM +0800, Junji Wei wrote:
>> > > >
>> > > > <...>
>> > > >
>> > > >>>
>> > > >>> What is the use case for this virtio-rdma? Especially in context=
 of RXE.
>> > > >>
>> > > >> Hmm... yes, we didn=E2=80=99t find one. In passthrough case we ca=
n use RXE directly.
>> > > >
>> > > > It doesn't sound like a good sales pitch.
>> > >
>> > > Maybe I misunderstanded what you mean. We mean we didn=E2=80=99t fin=
d a user case
>> > > for virtio-rdma with passthrough net device. Do you want to know the=
 user
>> > > case for our virtio-rdma(RoCE) proposal?
>> >
>> > Yes, please.
>> >
>>
>> I think one point is: when running RDMA accelerated applications in
>> VM, the virtio-rdma solution should get better performance than RXE
>> since it has a shorter data path (guest app -> host dpdk, bypass guest
>> kernel).
>
>
> What's the security model?  Native RDMA has security on a per QP basis.  =
DPDK requires root/CAP_NET_RAW access and allows anything.  How are you ens=
uring that rogue apps can't do bad things with this?
>

Should this be already protected at the virtio level? I think
virtio-net would meet the same problem if we have a malicious guest.
And DPDK is under our control, I think we can do some validation if
the app violates the RDMA semantics.

Thanks,
Yongji
