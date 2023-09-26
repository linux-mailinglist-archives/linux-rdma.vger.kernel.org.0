Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387FA7AEFCD
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbjIZPh5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 11:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjIZPh5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 11:37:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004A5120;
        Tue, 26 Sep 2023 08:37:49 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso61333935e9.3;
        Tue, 26 Sep 2023 08:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695742668; x=1696347468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTYvK9pH/EJXRHP3ak9Ne9342oDswZw6qnzE3IYoQUw=;
        b=T+ZCMMeG5dwEoCr0UfBL43NshlTQN7hXNrykwx+eZS89urOTwA5qgRu2ZBCdAERfJt
         T6VRQ7KFFBBXYVBLwO3OpDU7dCAdXxH2pUcZcApfOGlZaCjfSVjgafmDIDIL0xoUh1V6
         cIogswGhWBAV03+RFCFnndyuBZmXPV5wRgvRRsTgfOfmU30HJ9oyfezmiY0bGC5lCrzy
         rlde2hGJ8k8BQp5lB2eK+qDdEoe9/IBrsjhcalbhus7qJb1k8vMkfXHM1duAfRhqjp32
         B76WAWwAyd6P9YgSY1yjPFOik98dVrh9na04KCTG+HGxNcrp26lpXLer+FikQrfTLlDQ
         Ut0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695742668; x=1696347468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTYvK9pH/EJXRHP3ak9Ne9342oDswZw6qnzE3IYoQUw=;
        b=v1wNVPqE/anuWDXeMl1w454YfERh3gQpec89cHOlPYAyTOeLuz0Q+ctu6jOd/NI9gl
         1o9dncYPQzQ8fOXaJGY7Godx3KL4rUCOHvgpUGCFgN0B3oJGFOfuA1h+4YbIzVk/+gkw
         jDfWhHkJqDwDNwOwvwoYA98Dprzq+JgAhmODahjyXyBxB/O0TXom8BxaGrEPNPsVdPeG
         r+aMgeUzMCPyTrCfuWjNcFMgpc/kTxXxHqbF7rQRgK7MNJhbcpPL3JCAOFv/vpA9Z3ee
         AXMevE2Vwka/PwenK3U1s791vVAfVmAxVVUlOYl2BokO0duLsbcwuAJV8CpNTLqSSmAs
         HmEg==
X-Gm-Message-State: AOJu0YxL2bPDKowVhv4PIolu6vgpJ6Jj3Yo5e9wdMjSAe8DtWt4wThBP
        ub+jPe2rUo1PXz+aXM/c/vIEAaD7rg+sdWmqoqE=
X-Google-Smtp-Source: AGHT+IGIvAA9vf46tqgTuoSwI1yLVXfkOJL2ScPNS/SeN+QUpnNWwvD2vjAwoCJfV3eo1gCrvU4e1nJi6newv0RbXNg=
X-Received: by 2002:a05:600c:895:b0:405:95ae:4aa7 with SMTP id
 l21-20020a05600c089500b0040595ae4aa7mr4333702wmp.10.1695742668157; Tue, 26
 Sep 2023 08:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev> <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
 <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev> <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
 <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev> <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
 <6fc3b524-af7d-43ce-aa05-5c44ec850b9b@acm.org> <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
 <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org> <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
 <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com> <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com> <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org> <114ecd0b-42b0-4c1d-8b58-280e670550be@gmail.com>
In-Reply-To: <114ecd0b-42b0-4c1d-8b58-280e670550be@gmail.com>
From:   Rain River <rain.1986.08.12@gmail.com>
Date:   Tue, 26 Sep 2023 23:36:57 +0800
Message-ID: <CAJr_XRBFnrtSGeVbybthd80Ro5ykki6NsNYbQ93hLJfCWcnJrQ@mail.gmail.com>
Subject: Re: [bug report] blktests srp/002 hang
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 26, 2023 at 3:57=E2=80=AFAM Bob Pearson <rpearsonhpe@gmail.com>=
 wrote:
>
> On 9/25/23 10:00, Bart Van Assche wrote:
> > On 9/24/23 21:47, Daisuke Matsuda (Fujitsu) wrote:
> >> As Bob wrote above, nobody has found any logical failure in rxe
> >> driver.
> >
> > That's wrong. In case you would not yet have noticed my latest email in
> > this thread, please take a look at
> > https://lore.kernel.org/linux-rdma/e8b76fae-780a-470e-8ec4-c6b650793d10=
@leemhuis.info/T/#m0fd8ea8a4cbc27b37b042ae4f8e9b024f1871a73. I think the re=
port in that email is a 100% proof that there is a use-after-free issue in =
the rdma_rxe driver. Use-after-free issues have security implications and a=
lso can cause data corruption. I propose to revert the commit that introduc=
ed the rdma_rxe use-after-rpearson:src$ git clone git://git.kernel.org/pub/=
scm/linux/git/rafael/linux-pm
> Cloning into 'linux-pm'...
> fatal: remote error: access denied or repository not exported: /pub/scm/l=
inux/git/rafael/linux-pm
> free unless someone comes up with a fix for the rdma_rxe driver.
> >
> > Bart.
>
> Bart,
>
> Having trouble following your recipe. The git repo you mention does not s=
eem to be available. E.g.
>
> rpearson:src$ git clone git://git.kernel.org/pub/scm/linux/git/rafael/lin=
ux-pm
> Cloning into 'linux-pm'...
> fatal: remote error: access denied or repository not exported: /pub/scm/l=
inux/git/rafael/linux-pm
>
> I am not sure how to obtain the tag if I cannot see the repo.
>
> If I just try to enable KASAN by setting CONFIG_KASAN=3Dy in .config for =
the current linux-rdma repo
> and compile the kernel the kernel won't boot and is caught in some kind o=
f SRSO hell. If I checkout
> Linus' v6.4 tag and add CONFIG_KASAN=3Dy to a fresh .config file the kern=
el builds OK but when I
> try to boot it, it is unable to chroot to the root file system in boot.

Bob,

Suggested by a friend who is an expert in process schedule and
workqueue, I made a test as below.
On each CPU, a cpu-intensive process runs with high priority. Then run
rxe with the commit, the rping almost can not work well.
Without this commit, rping can work with rxe in the same scenario.
When you fix this problem, consider the above.

>
> Any hints would be appreciated.
>
> Bob
>
