Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A88569BAF
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jul 2022 09:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiGGHco (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jul 2022 03:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbiGGHcn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jul 2022 03:32:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD231926
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 00:32:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t19so29040616lfl.5
        for <linux-rdma@vger.kernel.org>; Thu, 07 Jul 2022 00:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=14t5OpcwAyMwCVGRWQ2ZSoPC8T1U9tJCkeBIA5bhXzg=;
        b=Y8mKMKNZaOnq6KmEDgzJMITOZgHjpM2QZla6EAS4J6kofpkBLM/0vKaRAGY5wieRUm
         wbSCtn5lCkfmOAKWA72ZXZ5TTQoNSuxz+jepFb2qRK5l/HQ2rXSyGMdmmVQwR8zND53J
         f7nwZOyNr2Yyz6NjXS1y7FHB9ptpG5IHhaVq48yiwkjL+AEjxAxD4TulH3FL6vdIRxwT
         qfLYDfXhDKy+f+6FDHhLdNg+bmzVMmvcexciMQ3ldFHWnRy3H4tNXkN6kTsqk9LtxeVJ
         14VzuaO9nDW5VCDJRUiYUcNIB82zAdx7xgn06zjYOEljEFEp4Sovf4UoQv9T1FHorFzD
         s1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=14t5OpcwAyMwCVGRWQ2ZSoPC8T1U9tJCkeBIA5bhXzg=;
        b=hB00vydbHKHd/avemW+ylGXqB4F83gBLBhKaPmPY3pOcrwjoMRm1I9ie/+pqrj6qKv
         CxtC0Jl+pONk99a7MewQUbUg/qy6zKi+queCPSuUSh+H+pOHCsGTVihjk5unEyVgF3yX
         k85AlIn1bMmgNn3sHAubCJCR/hE8kaITWuLe9gWkkslGU9U6504dRoIqkjvUb64c3+wW
         oVJ5DI0uDXA6EWQAesV8uaFuudMThfrlXrItzN2KOlAiyTq40MJRVm/AVyGwC34ZrzJv
         rttk2H/iRaEl7wwBP/pO9Wgdph02keUYxJpBVoqzswr2a+gT3+6KJde1CeM/j8LMNDUo
         Ni6Q==
X-Gm-Message-State: AJIora9icThsN+4hMQ2NShJKVpGBT/4KlYoecl+0gA4Jhx7eIxByjCo2
        q+jT1qfrq4TQBYvTFvBKaJBcnzjuMZU+lDjPhTzw5VYcMfPgs5KaQLI=
X-Google-Smtp-Source: AGRyM1toFDe3y7oc7u6Kt68audZ5WZhcnt28GabqB8+k1skgRASTsgqbSLot78PNIubg1wk3WpDaXoJNGEt27I8rJs0=
X-Received: by 2002:a05:6512:2088:b0:47f:6c7e:bb68 with SMTP id
 t8-20020a056512208800b0047f6c7ebb68mr30016482lfr.271.1657179160082; Thu, 07
 Jul 2022 00:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220629164946.521293-1-haris.phnx@gmail.com> <20220629183445.GV23621@ziepe.ca>
 <MW4PR84MB2307EB091065A95A6972C41FBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <20220629184432.GW23621@ziepe.ca> <MW4PR84MB23074C9D7F136278F37FD7FEBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <CAE_WKMzMi7A5qYp71ez=4E1BxcUNYCDeYq4DmFjxWMoHYRusAA@mail.gmail.com>
 <20220705135959.GG23621@ziepe.ca> <CAE_WKMxGZqa-GDxLQ1fG9icCjGyXK=cvu8xtrLym2oxPuo559Q@mail.gmail.com>
 <20220706163948.GL23621@ziepe.ca>
In-Reply-To: <20220706163948.GL23621@ziepe.ca>
From:   haris iqbal <haris.phnx@gmail.com>
Date:   Thu, 7 Jul 2022 09:32:14 +0200
Message-ID: <CAE_WKMz0u43YjoFs=QTpLAOdb_LEEf5es6UL4eWbU9U+OYQUNA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: For invalidate compare keys according to the MR access
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aleksei.marov@ionos.com" <aleksei.marov@ionos.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 6, 2022 at 6:39 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jul 06, 2022 at 05:41:08AM +0200, haris iqbal wrote:
> > On Tue, Jul 5, 2022 at 4:00 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Jul 05, 2022 at 11:28:59AM +0200, haris iqbal wrote:
> > > > On Wed, Jun 29, 2022 at 8:48 PM Pearson, Robert B
> > > > <robert.pearson2@hpe.com> wrote:
> > > > >
> > > > > > > > If the rkey's and lkeys are always the same why do we store=
 them twice in the mr ?
> > > > > > >
> > > > > > > They are not always the same currently. If you request remote=
 access they are the same if you don't rkey is set to zero.
> > > > > > > You could, of course, check both the keys and the access bits=
 but that is not the way it is written currently.
> > > > >
> > > > > > Storing the rkey instead of checking the flags seems like a wei=
rd obfuscation to me..
> > > > >
> > > > > > Jason
> > > > >
> > > > > One always has the choice to always just use the lkey and check t=
he flags. But referring the rkey just uses one memory reference =F0=9F=98=
=8A
> > > >
> > > > Have we reached a consensus here as to how to solve this?
> > > >
> > > > This (and the issue created by dual map) has basically caused a
> > > > regression in RTRS since the 5.15. And we would appreciate it a lot=
 if
> > > > the fix goes in and is backported.
> > >
> > > I think your patch is close, it should just be tweaked a bit.
> >
> > I couldn't conclude from the conversation above what that tweak should
> > be, if a conclusion has been reached. If not, then I'll wait.
>
> The 'rkey' input can be an lkey or rkey, and in rxe the lkey or rkey
> have the same value, including the variant bits.
>
> So, don't check based on the flags, if the rkey is not 0 check it,
> otherwise check the lkey
>
> Since we already did a lookup on the non-varient bits to get this far,
> the check's only purpose is to confirm that the wqe has the correct
> variant bits.

Thanks Jason. I sent the patch with the changes suggested. Also, I
stole your comment and used it as commit message, since that described
the changes accurately. :)

>
> Jason
