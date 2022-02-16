Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0024B8534
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Feb 2022 11:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiBPKDu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 05:03:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiBPKDt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 05:03:49 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E63226AF1
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 02:03:38 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g1so1762888pfv.1
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 02:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kv7H7LrWZACFblR73VAfpTs7HQGOfysnm1FR9j+yBDM=;
        b=abe7Ovyd2fApvbo3JHuN6BQ3f8oLDJJnPzskH8AXnwnfsSCQVfW+VV7Joz+MmF/lvv
         7+l3OPoMqS+Zz+PGxIHG0jkKvVsdxbJzw05BwCPc/X6DtfiUWAZlSZ/dgBHyhVdIfn9J
         8mNgZcHCIBSgIDGvsVOXaJ4GqWYOlk6wf4z+KbK015czmYqwPtPEw2buwzDxy/2ciF+L
         cQvySGxsPvKHeV7wOnKYNpSK7+A/8Vdt759UunxPtbz67DnDYmijMi0P9k1lfowndBbj
         +4jsGfl4phUs3JbQHal2bw8gpB36NLNnQd+3ECzMFtN97rtF5iWZGqUqCqmRkADE6ibB
         rMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kv7H7LrWZACFblR73VAfpTs7HQGOfysnm1FR9j+yBDM=;
        b=dRoYL4hcoru819inXD7CH/mX1D3JdzybrHXyhLAxjqSmWWMfK6gb0WwtgS5nlBviYU
         u1qphiwBIVWYzvxCMSC/1Z6Vph9dJq7yqbugfiLLRx2Acvo8nJUb+VuA3F4J2WJ34nl3
         lafOfObVxz9tUCg2DKADBtY5yrknE5q9IBKyPGkt9Ssp+gqUy/sADXv0cCRiw6xhWC8C
         0OuqKJ6JzSIktxnr0yP/e917Q590ZDBox0b2IVnnnQt9mEQzOyHSwLFL1Y0CNbo5Sfgf
         S9d42Vf86ao09blrgxU8K2PL5ytEubDj4ZRkzFtwTHYKEB0BOuZ2MzAU97MuNvHuy3Jh
         9j7w==
X-Gm-Message-State: AOAM5317PH2jvKPTyQ+90wi+G3N+peeTkcDk5Ztfe8ZaWfCkTCt2ezIS
        8R5abmDqFBVHIoWEjwZu766OWg==
X-Google-Smtp-Source: ABdhPJymTsIR4LllEc6brbhpJJaOx0ldCp3601HbmELJn4S+vDeml/c1veG0l4fzTv3M+gmQ/0kYRw==
X-Received: by 2002:aa7:8d42:0:b0:4bd:265:def4 with SMTP id s2-20020aa78d42000000b004bd0265def4mr2362466pfe.24.1645005817615;
        Wed, 16 Feb 2022 02:03:37 -0800 (PST)
Received: from smtpclient.apple ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id ck20sm18349726pjb.27.2022.02.16.02.03.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Feb 2022 02:03:37 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [virtio-dev] Re: [RFC] Virtio RDMA
From:   Junji Wei <weijunji@bytedance.com>
In-Reply-To: <YgzIfyx7WyGb39mV@unreal>
Date:   Wed, 16 Feb 2022 18:03:29 +0800
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
Message-Id: <38D3D312-E507-426F-BB3E-211AC273593B@bytedance.com>
References: <20220215081353.10351-1-weijunji@bytedance.com>
 <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com>
 <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com>
 <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com>
 <YgynQGK/xog1ugEd@unreal>
 <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com>
 <YgzIfyx7WyGb39mV@unreal>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Feb 16, 2022, at 5:48 PM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Wed, Feb 16, 2022 at 04:00:53PM +0800, Junji Wei wrote:
>=20
> <...>
>=20
>>>=20
>>> What is the use case for this virtio-rdma? Especially in context of =
RXE.
>>=20
>> Hmm... yes, we didn=E2=80=99t find one. In passthrough case we can =
use RXE directly.
>=20
> It doesn't sound like a good sales pitch.

Maybe I misunderstanded what you mean. We mean we didn=E2=80=99t find a =
user case=20
for virtio-rdma with passthrough net device. Do you want to know the =
user
case for our virtio-rdma(RoCE) proposal?

Thanks.

