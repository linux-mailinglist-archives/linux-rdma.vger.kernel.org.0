Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16B94DE6BC
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Mar 2022 08:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242391AbiCSHat (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Mar 2022 03:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbiCSHar (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Mar 2022 03:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8147E92D0F
        for <linux-rdma@vger.kernel.org>; Sat, 19 Mar 2022 00:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647674965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MtnQkQQa4FWyZNWbj9JSTFrxAsO52s5iMepRv7LRB74=;
        b=JDR6R1UxDv6QNFJIXX4Ecog0KHdMiXniurTPkUb8cK+NVCeCbK0qJRoEe63l/LcD1Nj5Bd
        wNJMIq5lL1/+NH2/g1lyvZD9ePO/t+8E2pUlrVmPQV8hLR36rHB98ql41vqCFHkYbRqzPF
        +hGrBGnkQfwC+CasYYqeK8YZl/TPa4o=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-rDhA2pe7PhqFp4Z8E7okiQ-1; Sat, 19 Mar 2022 03:29:23 -0400
X-MC-Unique: rDhA2pe7PhqFp4Z8E7okiQ-1
Received: by mail-pg1-f199.google.com with SMTP id q13-20020a638c4d000000b003821725ad66so3181304pgn.23
        for <linux-rdma@vger.kernel.org>; Sat, 19 Mar 2022 00:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtnQkQQa4FWyZNWbj9JSTFrxAsO52s5iMepRv7LRB74=;
        b=GFKaUyhZWhh+AKdJDY523a6yF6rCmzuaU+fKxhXSr5Bnz55H/RWI6z6r5AigxkNUVU
         9xLurmtiTDJUN4bWYU5+7O36tBuDItWUoAy6Isr186BQtwFGMPcD5c/fxPMLwxqzEs6G
         16ye55xUgl49Ecz0YjOp4AiSfRGfeuepvJos0HOI40Chz4qBGy5vrw0JqgCtRUllnci7
         kKXfhKs4+Zl32/5Py78hssTZweYjdU4rloDWma/CsKtpDbx7RdWNO2x7b6LXv1cxieOW
         0ZPlJzDSEareQMqOBEna+Sg4u8AsXCUtul5yhochhlDl4QAh8LKqa05kU5ejlqASbgP4
         IE6w==
X-Gm-Message-State: AOAM533xTo8j/0IRJPdeQlfbs040Q6azbAkv8LUtM3E2CavDHTaYyza8
        5HPFFqGDjNny0drwbsDwRzLzbkwCtNYE7+R07vyC9lfHwZ3A++GmvVpybVDED/MXxIeBj0zKvBy
        LUO6fq/ejOoe+9CHYmVX3U9HCAFeBbVqMQFtI/w==
X-Received: by 2002:a17:90b:33cc:b0:1c6:6012:5647 with SMTP id lk12-20020a17090b33cc00b001c660125647mr17714280pjb.165.1647674962735;
        Sat, 19 Mar 2022 00:29:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZBiajyKjPniL5vHn8R/XlXmGH8c65aXx12XtgM9iLtUtANOiWcGdnCRQ0iTevi4kj7fYK59f8qsckAchB6F8=
X-Received: by 2002:a17:90b:33cc:b0:1c6:6012:5647 with SMTP id
 lk12-20020a17090b33cc00b001c660125647mr17714271pjb.165.1647674962480; Sat, 19
 Mar 2022 00:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com> <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com> <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com> <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com> <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
 <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me> <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
 <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com>
 <fe9842f1-e5c7-7569-426e-9029662bb4f3@nvidia.com> <CAHj4cs8fNmj2Mn7Srs547ji51x7mQ8ZWKzFOuJaENe=vKpBJ-A@mail.gmail.com>
 <6347079f-ec3b-c2e5-bb3b-43b539d6d3f1@nvidia.com> <CAHj4cs_ir917u7Up5PBfwWpZtnVLey69pXXNjFNAjbqQ5vwU0w@mail.gmail.com>
 <6d8f4525-f663-18cc-8644-bfddd7d86bd0@grimberg.me>
In-Reply-To: <6d8f4525-f663-18cc-8644-bfddd7d86bd0@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 19 Mar 2022 15:29:10 +0800
Message-ID: <CAHj4cs_ff3TGnD2QJSzx3QJQKc1HkF=TJkh_MokqGK3n8NWyQQ@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 16, 2022 at 11:16 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> Hi Yi Zhang,
> >>
> >> thanks for testing the patches.
> >>
> >> Can you provide more info on the time it took with both kernels ?
> >
> > Hi Max
> > Sorry for the late response, here are the test results/dmesg on
> > debug/non-debug kernel with your patch:
> > debug kernel: timeout
> > # time nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testnqn
> > real    0m16.956s
> > user    0m0.000s
> > sys     0m0.237s
> > # time nvme reset /dev/nvme0
> > real    1m33.623s
> > user    0m0.000s
> > sys     0m0.024s
> > # time nvme disconnect-all
> > real    1m26.640s
> > user    0m0.000s
> > sys     0m9.969s
> >
> > host dmesg:
> > https://pastebin.com/8T3Lqtkn
> > target dmesg:
> > https://pastebin.com/KpFP7xG2
> >
> > non-debug kernel: no timeout issue, but still 12s for reset, and 8s
> > for disconnect
> > host:
> > # time nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testnqn
> >
> > real    0m4.579s
> > user    0m0.000s
> > sys     0m0.004s
> > # time nvme reset /dev/nvme0
> >
> > real    0m12.778s
> > user    0m0.000s
> > sys     0m0.006s
> > # time nvme reset /dev/nvme0
> >
> > real    0m12.793s
> > user    0m0.000s
> > sys     0m0.006s
> > # time nvme reset /dev/nvme0
> >
> > real    0m12.808s
> > user    0m0.000s
> > sys     0m0.006s
> > # time nvme disconnect-all
> >
> > real    0m8.348s
> > user    0m0.000s
> > sys     0m0.189s
>
> These are very long times for a non-debug kernel...
> Max, do you see the root cause for this?
>
> Yi, does this happen with rxe/siw as well?

Hi Sagi

rxe/siw will take less than 1s
with rdma_rxe
# time nvme reset /dev/nvme0
real 0m0.094s
user 0m0.000s
sys 0m0.006s

with siw
# time nvme reset /dev/nvme0
real 0m0.097s
user 0m0.000s
sys 0m0.006s

This is only reproducible with mlx IB card, as I mentioned before, the
reset operation time changed from 3s to 12s after the below commit,
could you check this commit?

commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc
Author: Max Gurtovoy <maxg@mellanox.com>
Date:   Tue May 19 17:05:56 2020 +0300

    nvme-rdma: add metadata/T10-PI support


>


-- 
Best Regards,
  Yi Zhang

