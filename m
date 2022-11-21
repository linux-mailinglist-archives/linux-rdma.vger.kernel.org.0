Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38CA63248D
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Nov 2022 14:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiKUN7b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Nov 2022 08:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiKUN7F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Nov 2022 08:59:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A0E17072
        for <linux-rdma@vger.kernel.org>; Mon, 21 Nov 2022 05:57:43 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bs21so19984382wrb.4
        for <linux-rdma@vger.kernel.org>; Mon, 21 Nov 2022 05:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iF/t8apUyWuhDIryZyYBVw69J04guPwa/Q1m0PGtgj4=;
        b=NTH1gFTQhD35MwNnKxHma+Dne19TTBr9hsuIMfgWyipYlc+hQpXP0YHxMy7h8Gc9/P
         0f25YPA/9D37uxZ1XTs2rIwDzIlXHO27c7qFKIEdA4pT2otaDRECGXrh0ynhMkm/7lQI
         NlLhp7csumAx4/4Dt0zetWAyTt+6qhR2oVrm9cmLg85/agpLojhCQA+M/Sybnh5wdfSE
         5Bo0BIxNpf6aGi0bv2Q+oF14l67NmrgFMkRtwD81OXBwkpAC819yFFFUwy2dIZlilt47
         VlmoWs5ZGzAxPsLy958luCizhuz0UKuMOh7xZynKuj11VHOVWbrDj+uwE4LRi8DQewCd
         VmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iF/t8apUyWuhDIryZyYBVw69J04guPwa/Q1m0PGtgj4=;
        b=rBLQqKADK2piX/vlwFDdlr3rYLGIMCjr9ocL5xFCLJDq0wip2LlNH0VKU89GQXGlvq
         x/JudOCG2Y4P4luGeTu+EtwO9f4opA6yvZb7ap8ZJamp1MbTTT1nWT3/niypCe5PNLzf
         DICCAlNclUsaemnX64GCwl//V97dUemZazW1Fs/jkKBeHCNJ9hgxH1ojdOWhg7lISrq/
         hSv/92LGO5Vvhz1iQLkkVqfX0ROwnu62+jorhATRexFnr5PmGVTow8SdEKwUpn+cTBXx
         4DRue6q/lbzFcXJPcg/wCmhzxUDIhTw2nA7UWrwMpiarGG/sxO7/bkjJx78ygAWvGr8u
         eiBQ==
X-Gm-Message-State: ANoB5pmRTA1QyVRo1NqIrmDSXg8LncCzpM/+w9Al+HG0+o5F+srmIWZC
        nYNcboJe32v6esSSjc/DXlR6am/5caVjwACD85nNGQ==
X-Google-Smtp-Source: AA0mqf61vjT7gCdQcTsAcZAYE1/8Ro4EWqaK2HE4/5KcS+UqmBGZszawiFOhM+JSqSfT37FAFwbLoGXKdjqDAzCV9K0=
X-Received: by 2002:a5d:4247:0:b0:241:a82b:5dee with SMTP id
 s7-20020a5d4247000000b00241a82b5deemr533360wrr.425.1669039062122; Mon, 21 Nov
 2022 05:57:42 -0800 (PST)
MIME-Version: 1.0
References: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
 <3b2f6267-e7a0-4266-867d-b0109d5a7cb4@acm.org> <CAHg0HuyGr8BfgBvXUG7N5WYyXKEzyh3i7eA=2XZxbW3zyXLTsA@mail.gmail.com>
 <cc14aa58-254e-5c33-89ab-6f3900143164@acm.org> <CAHg0Huw35m_WiwFqcTEHpCz94=JhaKZdEuV-F=aetQ_SEQgauA@mail.gmail.com>
In-Reply-To: <CAHg0Huw35m_WiwFqcTEHpCz94=JhaKZdEuV-F=aetQ_SEQgauA@mail.gmail.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 21 Nov 2022 14:57:31 +0100
Message-ID: <CAJpMwyh-cihwNyMyTFE-f2HQqOnLydNB+TiGcq5UTMkgwU0yNA@mail.gmail.com>
Subject: Re: [RFC] Reliable Multicast on top of RTRS
To:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org,
        linux-block@vger.kernel.org, Aleksei Marov <alexv.marov@gmail.com>
Cc:     danil.kipnis@posteo.net, Jinpu Wang <jinpu.wang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey there,

We've got a prototype version working in-house. We've also implemented
a block device client and server. Another client and server could
probably be rbd and dm-thin. Will update as soon as we have a github
link.

Some technical details

- Ability to perform sync across storage nodes without the involvement
of the client.

- This helps performing sync, extending/adding legs/members without
the help of the client.

Candidate users

- We've implemented a stand-alone replicating block device. The client
is similar to the rnbd-clt and our own corresponding "store"/server
does linear mapping on the server side.

- rbd could be a client of rmr-clt. The rmr-srv (store) would talk to
lvm. rbd would provide the block device (over multiple objects) on the
client side. Lvm would function as the store on the server side. One
object would be stored on one dm-thin volume. rmr would provide for
the replication in the network.

Setups: RMR vs MD-RAID vs DRBD

- Active-active

- RMR as means of replication over network differs from the md-raid
configuration because sync traffic goes directly between servers. The
difference to the drbd setup is that the IO traffic goes to both legs
in a single hop.

How does RMR solve the activity log issue

- Synchronous replication; much like Protocol C of DRBD.

- RMR tracks all successful queue_depth (max number of IOs that can be
inflight at any moment) worth of last IOs on each storage node.

Best,
Haris

Signed-off: alexv.marov@gmail.com
Reviewed-by: danil.kipnis@posteo.net

On Sun, Nov 22, 2020 at 5:20 PM Danil Kipnis
<danil.kipnis@cloud.ionos.com> wrote:
>
> On Fri, Sep 4, 2020 at 5:33 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 2020-09-04 04:35, Danil Kipnis wrote:
> > > On Thu, Sep 3, 2020 at 1:07 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > >> How will it be guaranteed that the resulting software does
> > >> not suffer from the problems that have been solved by the introduction
> > >> of the DRBD activity log
> > >> (https://www.linbit.com/drbd-user-guide/users-guide-drbd-8-4/#s-activity-log)?
> > >
> > > The above would require some kind of activity log also, I'm afraid.
> >
> > How about collaborating with the DRBD team? My concern is that otherwise
> > we will end up with two drivers in the kernel that implement block device
> > replication between servers connected over a network.
>
> Will take a closer look at drbd,
>
> Thank you,
> Danil.
>
> >
> > Thanks,
> >
> > Bart.
