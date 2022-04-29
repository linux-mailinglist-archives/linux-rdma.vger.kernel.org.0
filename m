Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D37515067
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Apr 2022 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352266AbiD2QKy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Apr 2022 12:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378952AbiD2QKn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Apr 2022 12:10:43 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EA5D5EB5;
        Fri, 29 Apr 2022 09:07:22 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l18so16299566ejc.7;
        Fri, 29 Apr 2022 09:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBDYChJz4muZwramvZwvxYrD6iAdG1yVc/7dYwu9fgc=;
        b=r7+eZg0H9QFpXTQzII642l9ABEDD4XPFhrjVTg1nboFCf2Uov7cDoEKyd3TC1fXhMo
         eJRYldvbFCWvJrxk468UHNFK8agEq8yfc98844gIGx7e5Gfd0Bg2qa0ulAiSb0H5B3To
         IvW/20n3c78OALFQNuyPHmWOLvRuvOjamS2ppGK0mpH2fVc6csFDza7qq6yNVzZJYTWi
         7hhzj7LYCk/X3IxdzUWc1P8+vY2wYZy3oNeQ+ArhcU0M1geRzEp9MRQXWgEpJzT60IFP
         E7+TpOWQ3R20uizxjMhVhE0NQuOXqfXnP0hOBgG1YS4L40Y+Yy7vHlft/ybI1yIb1Iue
         b2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBDYChJz4muZwramvZwvxYrD6iAdG1yVc/7dYwu9fgc=;
        b=3LfKSmCvAejPnYeg5Ovun/6ID+WZIqv5B6kJYkkLql27qod3dNcmuVv5gKOuGYrJJ2
         /4JZv4b6jlB+Ol+qzVmkKtg+g7Z9rPtGVY5pFD4O+YgarCH+glbjq5+vLfpNC2hgdwO+
         3VLaw3G2ReaV0o1S1AAgfkfhbHpPu1ssdflyQNldSHLKW+xdxwmPbSL4rtwhH1On7b/S
         ZR+JliBADFRw/FxsnF0F9ySrmahD195s3rU71bldscym2pTFLcNiOX5dnEIe7Sdd183M
         hQ9VQw/VOxGbhM9myKiO6ttlcVqB0PooaA1cmkrcvDrTWm+IGDOagpFkpi3ADNgg6GsJ
         BzYA==
X-Gm-Message-State: AOAM533izQIADeNwMfZgqMueCkYIHZljDzvkp/kspzGCa0L2RxEN1WO7
        eGTN7cqRXq0ojjDvH2JWQOTDHxkhs6AkW5UyjWk=
X-Google-Smtp-Source: ABdhPJxGUVnyOQ/YbEGPBLSpK1sE/ajSWypseQaQF9vQONhV3matHSP1Gc0bxZmDX1TACi57vnjyHN3ik3SGnr90+eU=
X-Received: by 2002:a17:907:1b26:b0:6ef:eaca:d2d8 with SMTP id
 mp38-20020a1709071b2600b006efeacad2d8mr43204ejc.604.1651248440734; Fri, 29
 Apr 2022 09:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649075034.git.leonro@nvidia.com>
In-Reply-To: <cover.1649075034.git.leonro@nvidia.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 29 Apr 2022 12:07:09 -0400
Message-ID: <CAN-5tyGeGya5dW9h1uvBd6uKW-AgY1q8-UkR1kpi9Z2k6PY7jw@mail.gmail.com>
Subject: Re: [PATCH rdma-next 0/2] Add gratuitous ARP support to RDMA-CM
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Mark Zhang <markzhang@nvidia.com>,
        Patrisious Haddad <phaddad@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

Are these the 2 patches that are supposed to fix: [Bug 214523] New:
RDMA Mellanox RoCE drivers are unresponsive to ARP updates during a
reconnect?

I could be wrong but I don't think they made it into the 5.18 pull, correct?

Thank you.

On Mon, Apr 4, 2022 at 8:36 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> In this series, Patrisious adds gratuitous ARP support to RDMA-CM, in
> order to speed up migration failover from one node to another.
>
> Thanks
>
> Patrisious Haddad (2):
>   RDMA/core: Add an rb_tree that stores cm_ids sorted by ifindex and
>     remote IP
>   RDMA/core: Add a netevent notifier to cma
>
>  drivers/infiniband/core/cma.c      | 260 +++++++++++++++++++++++++++--
>  drivers/infiniband/core/cma_priv.h |   1 +
>  2 files changed, 249 insertions(+), 12 deletions(-)
>
> --
> 2.35.1
>
