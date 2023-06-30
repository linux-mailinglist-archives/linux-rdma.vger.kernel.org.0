Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE93743365
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jun 2023 06:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjF3EKk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jun 2023 00:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjF3EKi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jun 2023 00:10:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962AD19A6
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 21:10:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so173518366b.2
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 21:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688098236; x=1690690236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YlumTE1/VZOp3prH/yZnB1tVVLT1aI0qSCA6eRI/6cc=;
        b=MDPWonVdDbLGjO5nFel2fNZPZlszb1qoMKvC7RQBlHoQpT0iF9wRkdHrSQ3Wyf4TuR
         FAh7TrO5HmUHvfrvZ/nVH+PZiAtmUOCuMZURf9L43M6ig/niLVyCYWIiVhon6IrvNWgN
         P4d1z3eVeV2/hFarFR8/2ZoBGP2lhcmNO1HSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688098236; x=1690690236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlumTE1/VZOp3prH/yZnB1tVVLT1aI0qSCA6eRI/6cc=;
        b=adCID6nQ+zjbnOGR5SJiUJKxd2wQbhK4fYwyN6NKNDLcWubRqJsUtZJWoGrgV1KEKE
         BawYNDBID1ID2NB0Mxa+GJXDpAZui8YIcFPjBnv1DHaHXlfLSxjB7End/u22QJp4H1Pt
         SX2M2G6ljwPXCcpZsHu4Ru+XF9LBAg5qVUB0jo6VRqeEPomBdP6WCImehXm72/WU33Xm
         gHQ7BXJ8R14NjnqH+iuaezb6D5selssNtpO1zPvSJjPxp8Kb3NhiOPC2S1aaKeWuLnhS
         ZKNL0xyyV3lx/hEx++K/zH86Ak5mrhBHTXodE5vO1rCtoBzjDbvONuqP+I5TcLBhacfp
         s04g==
X-Gm-Message-State: ABy/qLbpUF0ieQmyq0NEgL+S8SrC8QtuHJjDDBoSh2rLUOm9e5aSLOwc
        8EWISuQf0TDhAZ7uIavEyN0v1dO3BAb9MO+D1vcEDRnT
X-Google-Smtp-Source: APBJJlF+efsugovud5H1eRhAnp8ADqgLIQ0u5EgbmZBcdWxOj7+hfMXysKVCJ6X0h5VrkY+nMLAYow==
X-Received: by 2002:a17:906:4f0a:b0:992:ba2c:2e0c with SMTP id t10-20020a1709064f0a00b00992ba2c2e0cmr1101567eju.36.1688098236021;
        Thu, 29 Jun 2023 21:10:36 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id l16-20020a1709065a9000b00988be3c1d87sm7596851ejq.116.2023.06.29.21.10.34
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 21:10:34 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51de841a727so808466a12.3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 21:10:34 -0700 (PDT)
X-Received: by 2002:aa7:c703:0:b0:51b:e4b4:8bb0 with SMTP id
 i3-20020aa7c703000000b0051be4b48bb0mr755246edq.2.1688098234320; Thu, 29 Jun
 2023 21:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <ZJzUeFT7lLqEjMJn@nvidia.com>
In-Reply-To: <ZJzUeFT7lLqEjMJn@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 21:10:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjiSW52tf=xaBe0LrFJrRbSnA=E1ziKBEioMT9cMJPM1A@mail.gmail.com>
Message-ID: <CAHk-=wjiSW52tf=xaBe0LrFJrRbSnA=E1ziKBEioMT9cMJPM1A@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 28 Jun 2023 at 17:46, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> Here are the changes for RDMA for this cycle, there was a small rxe
> conflict with v6.4 that I resolved in the usual way.

Please just don't. I'd rather know about the conflicts. See

   Documentation/maintainer/rebasing-and-merging.rst

and about gazillion emails on the issue.

> - Lots of small cleanups and rework in bnxt_re
>    * Use the common mmap functions
>    * Support disassociation
>    * Improve FW command flow
>
> - bnxt_re support for "low latency push", this allows a packet

This allows a packet WHAT?

On a positive note, I see that you have a blue checkmark by google
now, and Google says

  "The sender of this email has verified that
    they own nvidia.com and the logo in the
    profile image. Learn more"

which is lovely. I expect great things from nvidia now that you
apparently own it. Congratulations! Champagne all around!

             Linus
