Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1FF4B8274
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Feb 2022 09:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiBPIBP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 03:01:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiBPIBO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 03:01:14 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F2920ADAD
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 00:01:02 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id i10so1424928plr.2
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 00:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Nu0iKpvVpU3TLTFN9/bspcyTA+gIBuiqFpp3d1lmigA=;
        b=3v2zeUEnPvcWoA7+601wElo4fB/OAs4jm5wwIBTu58uVg5ASiKd6AOZ3Si5Xfewm11
         dY4UlcRw3BtK6jPXiSUzdmeuloj2OuxN561XAyn+leC6M2ea/7auH4iFc3ozM2MRazVf
         9ehTxKpVmsq8HIbDD+ru4y73M1lWgG8fihifc/ZqGg3V9S+Itk/jFJm9ex+dmrFlEazu
         /h8joPd/OOnWIvPLpjpVzrBHYxQDXuLxx/ZoFSpJ/4hFf/llgtxD+HOz6aLZcxkseJ9s
         pPhYMo3gYzV6GQN0AbAI1E+CnIkaILX3rEhGaNnk8U/zidnL9l2DUPVLVWSb9eBtdhzZ
         yqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Nu0iKpvVpU3TLTFN9/bspcyTA+gIBuiqFpp3d1lmigA=;
        b=kAh1O2qXuLu53a9wnZHs5UM4Duy2EXNn4n0EeIgA3yi5NKoG0yTEOOfzWuq2Y0qri1
         /1Lr+Ro7aPBmZhjmgpMANiSqP4xCWwDLmOhA9JoK33wXT2UQRzhtsCimCplYZgcTHJ8P
         SUuINJuTEMBXTwzRWAUJp/4+Oo7605Uz/zdCbH+QCTX5s9kxlAh4LNJiTY2V4I55y11u
         UrKI6haYuk9jCm+/4161bPoJrL92z4YzPeUJ5uyZiV8c6X+v3CJUj/Nfi2ck+6xdQLYv
         9M+EyalwX02pYmBGkAeP1uy03WyPdfnB9jEwlg8Qqvp6Rd5D2k6mAQGo5mqSWpiZ3KAl
         PSfA==
X-Gm-Message-State: AOAM5303T+0y1GN1yLF2E5nPztZQ03Dl/tnXio9RPIiBsH6nksI1hewf
        0MLoCZE9dhLdFPBbsSYYjPIgTw==
X-Google-Smtp-Source: ABdhPJyxQSWMPldV+7+9w3z/XcIbcgqF4SqFUBwyhlMZKQ37N1Pr623/3IGZhXXmTeN4cNF6pDUTng==
X-Received: by 2002:a17:90a:e7c3:b0:1b9:c189:bc3 with SMTP id kb3-20020a17090ae7c300b001b9c1890bc3mr387650pjb.202.1644998462213;
        Wed, 16 Feb 2022 00:01:02 -0800 (PST)
Received: from smtpclient.apple ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id e3sm4665366pgc.41.2022.02.16.00.00.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Feb 2022 00:01:01 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [virtio-dev] Re: [RFC] Virtio RDMA
From:   Junji Wei <weijunji@bytedance.com>
In-Reply-To: <YgynQGK/xog1ugEd@unreal>
Date:   Wed, 16 Feb 2022 16:00:53 +0800
Cc:     Jason Wang <jasowang@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, mst <mst@redhat.com>,
        yuval.shaia.ml@gmail.com,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Virtio-Dev <virtio-dev@lists.oasis-open.org>,
        Yongji Xie <xieyongji@bytedance.com>,
        =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com>
References: <20220215081353.10351-1-weijunji@bytedance.com>
 <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com>
 <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com>
 <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com>
 <YgynQGK/xog1ugEd@unreal>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Feb 16, 2022, at 3:26 PM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Wed, Feb 16, 2022 at 03:13:11PM +0800, Junji Wei wrote:
>>=20
>=20
> <...>
>=20
>>>> We can't. So do you mean we can implement virtio-rdma only for IB =
in the future?
>>>=20
>>> It's probably virtio-IB but we need to listen to others.
>>=20
>> Agreed, one problem is that there might be some duplicated works.
>=20
> Once it will be needed, the code can be refactored. IB and RoCE are
> different from user perspective, so combining them into one =
virtio-rdma
> module doesn't give too much advantage.

Yes, code would be fine. But there maybe some duplicated contents in =
spec.

>=20
>>=20
>>>=20
>>>>=20
>>>>>> And currently virtio-rdma doesn't have a strong dependency on
>>>>>> virtio-net (except for gid and ah stuffs). Is it OK to mix them =
up?
>>>>>=20
>>>>> There are a bunch of hardware vendors that ship a converged =
Ethernet
>>>>> adapter. It simplifies the management and deployment.
>>>>=20
>>>> Virtio-rdma is not depend on virtio-net, we can bind it to another =
ethernet device
>>>> via mac address in the future. And is it too mass to mix up two =
different device
>>>> in one spec?
>>>=20
>>> So either should be fine, we just need to figure out which one is
>>> better. What I meant is to extend the virtio-net to be capable of
>>> converged ethernet.
>>=20
>> Got it. One question is whether there will be some cases that user =
want
>> to use virtio-rdma binding to other types of ethernet device such as
>> passthroughed net device. In this case, we don=E2=80=99t need a =
virtio-net
>> device actually.
>=20
> What is the use case for this virtio-rdma? Especially in context of =
RXE.

Hmm... yes, we didn=E2=80=99t find one. In passthrough case we can use =
RXE directly.

Thanks.=
