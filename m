Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C9251BDE9
	for <lists+linux-rdma@lfdr.de>; Thu,  5 May 2022 13:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbiEELYP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 May 2022 07:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbiEELYO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 May 2022 07:24:14 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5501D316
        for <linux-rdma@vger.kernel.org>; Thu,  5 May 2022 04:20:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h29so6935102lfj.2
        for <linux-rdma@vger.kernel.org>; Thu, 05 May 2022 04:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcLxY3KOpEADc3Fq1eYuhV2/3wlmnYPzVGhpjxaJJZs=;
        b=L4B3EXBYoWmDDvN4L/JtengLraqf+W03dpc25pjwrlVEuzwudbyT0Ksm2kft70CW7j
         POf2cQF9mzPYvTqeyHUnXQxZmX88Kyu32jGiJITnrSfNwPwqnf3+59QafQKmlm9zTax/
         bzfbOXW/yZUd5SSZj4xncagRRVuF2IY+y2zOCc/NeUuvboBmL6BllF9B8w4fEwXjUP+1
         8rwSLxmikylUqlu6R5/7wjQ3H6xlLVVQWds2OQ9116aiTOeAbb0cjEPnu0BVr9qATYdr
         T5TNN2iOcT/4t6UrwuyiUq79sMK1ltuOY3cT4iLI0qYmZzr5USrZu1YdCRePU7H6HwLw
         T5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcLxY3KOpEADc3Fq1eYuhV2/3wlmnYPzVGhpjxaJJZs=;
        b=T8IRTIjftbwo/MhbxPPnmNtehrIjUPp/7T/1NJJs/bvYAkx+MtdEEpJliQ03tDHOQs
         wMSU9DALsq7LLTmrXGLP7QGOIJy1gOxVKoWj9fT/Lr9Rm91eSmcdDKXZLbfm42773Wgx
         uGUhTasozP55OP1pUesGfy2X3Mtc1w7aQCaLLb+D2uu82wALefUuSJ8b6NM5xmrRILoW
         I/vneIv8aWhrJ4lMhOE1ZuXpY9JjXcdnrJ0bojHwuHIvqEgP8xLSt8tKXE4tCWMrDhdz
         v8OpXEcz5g+GH5kpVy+pXcsa+GfhIb1FrvSUq1IOAvZXpNag5lq+7Jv7uNdNxBX/pjRr
         30OQ==
X-Gm-Message-State: AOAM531bnGMPgdxAwRW3TEuefT0zQHoWQxaLLqsKwSeZ9id+MlxVCgmk
        qPC0N+GUm15Ar3jOB0dyuVy06tTrL4vxwnrH7s4VtBxS5xmJhg==
X-Google-Smtp-Source: ABdhPJx83zpKdlUULeabhMKH3sZ8zBqroKPijhgIGysVEnchf+dEe7I6+VT+Gg0oZ/qqKnsDZ0rTvSo7dbIod6/54JM=
X-Received: by 2002:ac2:5fa9:0:b0:46b:c39e:7034 with SMTP id
 s9-20020ac25fa9000000b0046bc39e7034mr17075888lfe.608.1651749633267; Thu, 05
 May 2022 04:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJpMwygqY4qwXfHd88wYs+KdKDEB=z=CzFd7jTVos-S3XNT5Yg@mail.gmail.com>
 <95d12c5b-83bb-dce6-750a-3827118b9aaf@linux.dev> <CAJpMwyhuOOgub4xxd6nB64c37yC82ogZCX4LB6WkUb721odLjQ@mail.gmail.com>
 <df08efe8-5914-e64b-3c18-4b5f906fcea1@linux.dev>
In-Reply-To: <df08efe8-5914-e64b-3c18-4b5f906fcea1@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Thu, 5 May 2022 13:20:22 +0200
Message-ID: <CAJpMwyhijokVN-JqaNWd9DxWJyFsgUHOLigYf7=OGy_bobE9+g@mail.gmail.com>
Subject: Re: Encountering errors while using RNBD over rxe for v5.14
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        yanjun.zhu@linux.dev, Jinpu Wang <jinpu.wang@ionos.com>
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

On Thu, May 5, 2022 at 5:46 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
>
>
> On 5/4/22 10:22 PM, Haris Iqbal wrote:
> >
> >>> We observe the following error,
> >>>
> >>> [Fri Mar 25 19:08:03 2022] rtrs_client L353: <blya>: Failed
> >>> IB_WR_LOCAL_INV: WR flushed
> >>> [Fri Mar 25 19:08:03 2022] rtrs_client L333: <blya>: Failed
> >>> IB_WR_REG_MR: WR flushed
> >>> [Fri Mar 25 19:08:03 2022] rtrs_client L333: <blya>: Failed
> >>> IB_WR_REG_MR: WR flushed
> >>> [Fri Mar 25 19:08:34 2022] rtrs_client L353: <blya>: Failed
> >>> IB_WR_LOCAL_INV: WR flushed
> >>> [Fri Mar 25 19:08:34 2022] rtrs_client L353: <blya>:*Failed IB_WR_LOCAL_INV: WR flushed*
> >> I got similar message but I am not certain it is the same one, pls see
> >> the previous report,
> >>
> >> https://lore.kernel.org/linux-rdma/20220210073655.42281-1-guoqing.jiang@linux.dev/
> > I went through the emails, and the error looks similar but I am not
> > sure if its related. The change to write_lock_bh was done after v5.14
> > I think, and the code where I am seeing this error still has irq
> > versions of those lock (e.g. write_lock_irqsave).
>
> The lock is irrelevant, pls check
>
> https://lore.kernel.org/linux-rdma/473a53b6-9ab2-0d48-a9cf-c84b8dc4c3f3@linux.dev/
>
> and
>
> https://lore.kernel.org/linux-rdma/3b6ddb23-6dfa-29e2-27fd-741c1e3e576d@linux.dev/

I tried with always_invalidate off, and it still fails. Also, I
thought to try your small patch, but it turns out the commit
647bf13ce944 ("RDMA/rxe:
Create duplicate mapping tables for FMRs") is not present in the
version I am running.


>
> But I am not certain it is the same issue.
>
> Thanks,
> Guoqing
