Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3194D153F
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 11:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346009AbiCHKzw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 05:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346002AbiCHKzw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 05:55:52 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7679241336
        for <linux-rdma@vger.kernel.org>; Tue,  8 Mar 2022 02:54:56 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id q4so14419344qki.11
        for <linux-rdma@vger.kernel.org>; Tue, 08 Mar 2022 02:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRR+AVYWXWHZ3LJetx4p/b2MhZGdxRgFOS3HSPgnmlw=;
        b=ERw0Dd443l73seaM9NQ1IJi+7UBohi5QoWq/KOr+0BovtNaYhiGfl+6m6cXuHZ5oB6
         8GxthoKxPngSCkzvlV8oo3TGBQ+Nh60BAACOaCBDtDG01VvEfhSgx+YHoOwWPUa3tzrb
         floywaTyRen4nZU4gvC4g/f4bPztpAMcTfbCUTfGiP+17vYbb8dcPUB4g0HlyQ09+d/y
         nnKWaNGsSDF+ChB1OYWtkhFuUQOeoaF1vRz5o/5jHpTHuFs8r8R4W+m0yx6RllL6Mcz6
         vtG7UzdONIDvjzh4C7unh+nC3egEw7HAdyVSYAhy8wKIR54awRRyX809xTOf57ayvv41
         CQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRR+AVYWXWHZ3LJetx4p/b2MhZGdxRgFOS3HSPgnmlw=;
        b=GvTh077R2c90Vm7RM/hLzzyC6Nv4Ej1FUPwMng7nXlHcS4zqKnBiEH64ziFHfRxWfv
         PrjPfE7jeoYwAIdQFhC8Ug5BcDb6d2cmc7ZJfpQg3YNKc7yAii2jg0cVXGcLKoRkHXTz
         ovoq+YStIWJc0LN2RlauayxxH3pJqfNFxFBtjwRsdWyD5lOIMqce3JHwCa/bD0ka6kMA
         vcBJt71cANddRSMz+DGOuR8itt706sHFxaRIcLdyaQNDoKT3ntCLfTYO2Yxav/xR4y6K
         TXbzPMEu6zepLswWaIw9kVzOQ6cVSEAGIZGOkWsCh/Rg6+IFdaPExo8sER71h2tAu9V0
         U55A==
X-Gm-Message-State: AOAM530RxIYkwLzbK8vjayh8NhvrUApYUulYeFgWLL4nfZBA6qeS9yzo
        FxzuqP25DndravphE/0hXNQ1cE0RMlndFl7cLvRPWQgn
X-Google-Smtp-Source: ABdhPJyi+k3Yj6eCX0Y8WH2LKRUeMKW4I7Fiy68EezLKzDaBVZzlZEKcRh2pxwrGiAkq2sGOmMHvkglYe4YHuPIhpKk=
X-Received: by 2002:a05:620a:1103:b0:60d:e5c8:a597 with SMTP id
 o3-20020a05620a110300b0060de5c8a597mr9599007qkk.513.1646736895486; Tue, 08
 Mar 2022 02:54:55 -0800 (PST)
MIME-Version: 1.0
References: <CAOrWFD8Kb3R0OZ8A04QF4fPdMM6Xa_-sze0tLHboAJnz3SLivw@mail.gmail.com>
 <b612cd5a-b3ad-c8fb-cb01-32aeafbb9e7a@nvidia.com>
In-Reply-To: <b612cd5a-b3ad-c8fb-cb01-32aeafbb9e7a@nvidia.com>
From:   Sylvain Didelot <didelot.sylvain@gmail.com>
Date:   Tue, 8 Mar 2022 11:54:44 +0100
Message-ID: <CAOrWFD_6dwzfjRJg7fh20B8K7_vbw7xQ+Lg7cGsAPwcOcevyoQ@mail.gmail.com>
Subject: Re: [Question] Is address format "gid" supported by RDMACM with RoCE?
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Does it mean that RoCE always requires the network interface to have
an IP address as it cannot use the GID to establish connections?

On Tue, Mar 8, 2022 at 11:49 AM Mark Zhang <markzhang@nvidia.com> wrote:
>
> On 3/7/2022 9:57 PM, Sylvain Didelot wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > Hi,
> >
> > I have configured one of my Mellanox network adapters for RoCE:
> > ---
> > CA 'roceP1p1s0f1'
> >      CA type: MT4123
> >      Number of ports: 1
> >      Firmware version: 20.32.1010
> >      Hardware version: 0
> >      Node GUID: 0xb8cef603002d1707
> >      System image GUID: 0xb8cef603002d1706
> >      Port 1:
> >          State: Active
> >          Physical state: LinkUp
> >          Rate: 100
> >          Base lid: 0
> >          LMC: 0
> >          SM lid: 0
> >          Capability mask: 0x00010000
> >          Port GUID: 0xbacef6fffe2d1707
> >          Link layer: Ethernet
> > ---
> >
> > The Infiniband stack was installed from the official Ubuntu repository
> > (20.04.4 LTS):
> > ---
> > $ apt search ibverbs
> > Sorting... Done
> > Full Text Search... Done
> > ibverbs-providers/focal,now 28.0-1ubuntu1 arm64 [installed]
> >    User space provider drivers for libibverbs
> >
> > ibverbs-utils/focal,now 28.0-1ubuntu1 arm64 [installed]
> >    Examples for the libibverbs library
> >
> > libibverbs-dev/focal,now 28.0-1ubuntu1 arm64 [installed]
> >    Development files for the libibverbs library
> >
> > libibverbs1/focal,now 28.0-1ubuntu1 arm64 [installed]
> >    Library for direct userspace use of RDMA (InfiniBand/iWARP)
> >
> > librdmacm-dev/focal,now 28.0-1ubuntu1 arm64 [installed]
> >    Development files for the librdmacm library
> >
> > librdmacm1/focal,now 28.0-1ubuntu1 arm64 [installed]
> >    Library for managing RDMA connections
> >
> > rdmacm-utils/focal,now 28.0-1ubuntu1 arm64 [installed]
> >    Examples for the librdmacm library
> > ---
> >
> > When I start the ucmatose server with the address format "gid", the
> > tool fails binding with the error "No such device"
> >
> > Here is an example of the output:
> > ---
> > $ cat /sys/class/infiniband/roceP1p1s0f1/ports/1/gids/0
> > fe80:0000:0000:0000:bace:f6ff:fe2d:1707
> >
> > $ ucmatose -b fe80:0000:0000:0000:bace:f6ff:fe2d:1707 -P ib -f gid
> > cmatose: starting server
> > cmatose: bind address failed: No such device
> > test complete
> > return status -1
> > ---
> >
> > Does rdmacm support connection establishment using GID with RoCE? Or
> > Is it a known limitation for RoCE?
> > FYI, the same experiment without RoCE (Link layer: Infiniband) works perfectly.
> >
> > Thanks for your help and your feedback.
> >
> > Sylvain Didelot
>
> I think ucmatose doesn't support RoCE when using "-f gid", as in this
> case ai_family is set to AF_IB.
