Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D464AC556
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Feb 2022 17:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiBGQTV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Feb 2022 11:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbiBGQHZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Feb 2022 11:07:25 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC87C0401CC
        for <linux-rdma@vger.kernel.org>; Mon,  7 Feb 2022 08:07:24 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id e17so20331086ljk.5
        for <linux-rdma@vger.kernel.org>; Mon, 07 Feb 2022 08:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9AFhJt5f2apdvymNol44VOAj1BO0+NPKUfSLYE/kwQ=;
        b=A3sZygi+AdwDJ74kFdH8tBgsFEvQipuJSotB1BHCmscE4ChEZgV0T48T1o/5dXixYy
         X51GZsoNMLAwm7qLImZjw44A0ne2JbGpMoqk2WuNGFwVCrrDo1/b1TKe5ummZ9u3LvmP
         Oj1I7YoFBw92oKtpMqeA5CaSNTEVDsgC7H/OIOonSiRE7YZodV4rC5fqVYQqTIgG30lF
         OagwtV/zT7tZy4SJFvfcrueLv18Jw1goNvc8wgW5RrorupMmiitVkLFD4SfPX9eIacLW
         erjzV39e3yRsAw+SiNKtM8VjBEjKqP8krUXi/8fvUFePCtz4gkHN9f5hmYM0WWr9vlpz
         h32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9AFhJt5f2apdvymNol44VOAj1BO0+NPKUfSLYE/kwQ=;
        b=AwJXm7ICV1gVVH93mxWsB9ojUr8upQ8go+USRhjR57C89P3A6g4DrgN8YxHlzlDLOr
         I4UK0ClYJ0oMr4g5Fb4PhzUn1gH0jyi87bIbnsXLlO8fTDrZEvxwfdzpMg6ghntQCyI3
         AYvBNTRKjIXYSq31+TFvTMsXw9d3k+Fp2eg5OdAYf6HPqpTOlOUzQ/nueQP/wu8rNx2t
         QVSlnwQ4POwTZumJW/fDTJk9IfDQ26CXgNY7KIiLzJpypcY+o6lVJszypLAdPYW6XNnz
         09zfmAvIXr3JHZBVMF1lflQg+1ZGdMOWpAL/6xBHuf3sdTUDL9AQmIPHN9us+Gu6zlFq
         YnLw==
X-Gm-Message-State: AOAM532P3laHxAcsS+vaiFo+NVYja3ae7l0PHeeMsvBaHDJqmjtKbkMC
        T4gIwA/7GaGdDPb6N+v6RzJxo0MVamonbbAIQL/u7g==
X-Google-Smtp-Source: ABdhPJztvn1OXVqyWcu0TF7c9kfOzEoingPzabtywTs1jMynncJDjlBjOLr4SVOIGQrGCKwjZFAT+dx/Ex8Cfpz0TdA=
X-Received: by 2002:a2e:9003:: with SMTP id h3mr95902ljg.111.1644250042983;
 Mon, 07 Feb 2022 08:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20220114154753.983568-1-haris.iqbal@ionos.com>
 <20220114154753.983568-3-haris.iqbal@ionos.com> <20220128145510.GA1792599@nvidia.com>
In-Reply-To: <20220128145510.GA1792599@nvidia.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 7 Feb 2022 17:07:12 +0100
Message-ID: <CAJpMwyhBZj0ugLd7gud7O422OE6cHgkkOGheXcjDxGbNXA_1kg@mail.gmail.com>
Subject: Re: [PATCH for-next 2/5] RDMA/rtrs-clt: fix CHECK type warnings
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 28, 2022 at 3:55 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Fri, Jan 14, 2022 at 04:47:50PM +0100, Md Haris Iqbal wrote:
>
> > -/**
> > - * list_next_or_null_rr_rcu - get next list element in round-robin fashion.
> > - * @head:    the head for the list.
> > - * @ptr:        the list head to take the next element from.
> > - * @type:       the type of the struct this is embedded in.
> > - * @memb:       the name of the list_head within the struct.
> > - *
> > - * Next element returned in round-robin fashion, i.e. head will be skipped,
> > - * but if list is observed as empty, NULL will be returned.
> > - *
> > - * This primitive may safely run concurrently with the _rcu list-mutation
> > - * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
> > - */
> > -#define list_next_or_null_rr_rcu(head, ptr, type, memb) \
> > -({ \
> > -     list_next_or_null_rcu(head, ptr, type, memb) ?: \
> > -             list_next_or_null_rcu(head, READ_ONCE((ptr)->next), \
> > -                                   type, memb); \
> > -})
>
> Why not put this in a static inline instead of open coding it? Type is
> always the same for both usages, right?

Yes. Makes sense. I will send this change along with the next patchset.

Thanks for the review and comment.

>
> Jason
