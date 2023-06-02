Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FF972047A
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 16:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjFBO3g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 10:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjFBO3f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 10:29:35 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C19E57
        for <linux-rdma@vger.kernel.org>; Fri,  2 Jun 2023 07:29:26 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75b1219506fso201132585a.1
        for <linux-rdma@vger.kernel.org>; Fri, 02 Jun 2023 07:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685716165; x=1688308165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hR4cfRO52K19EaWIBnrpEm4Q5CC06YOFcLL4jhPlEBk=;
        b=BBYNmuHPhOzCvfMF36eNi+aDUZZa1x6vDdpD0TUIuW3+SUQ9FI7eJWxYscbLKqZzbw
         9lzj6CAAsAD/TJ/t8UofaoYLqVA+PF4zaowiZf6mg40pn0PU3wtKSwQeCw+dWf7TN0ip
         c3XaJS19FEVWVEbuo6SDimPZsP2GvYc7U6SR2/2I7xLAAN/lPKM7A+snOoztxQUx1iPR
         e+GL8revbu/ZnjOnPRIzXY0tBQUIMWGUSj5YNXn9B9s8h0jIeMb2WCpCUI2cygAV2GD9
         4O17wtQMbvb204v9ZqcXrH46FEZFScPJ2+1JyAuRjlktf+FR3/ul0J2tDKMewSxcBpil
         dZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716165; x=1688308165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hR4cfRO52K19EaWIBnrpEm4Q5CC06YOFcLL4jhPlEBk=;
        b=KHNX2ZQzvjzGgJleNyu+mhV0DFA7yW3nGa3RdpBhePKjTFxHQweQ4N2m6Fh1mNyV51
         CWT/oeqY58jyRSu9b36CaIzk+W6hJ+vj98RJpFgqcvVFPi4TIDdyviJT/yjct3E9KeUQ
         pSudypZqaE0Adaggo1vQtrRHCJZ/dWVYaHQGRL1lKHDsQXgnONfUVLJvnvPkkq7YNryM
         +v6gve2kXuUw73ZBQxFOA1EgU3pyB0u4Z3+Ksl0Cn//rKWUmHp222MqRTbnaBIO4M50C
         qt6yVM2UWa2zyZ7FsMH2sY2DMO8WAavkcF+xKwK1WfUnp9V0CUgCJOt8nbBWK6sMf936
         syGw==
X-Gm-Message-State: AC+VfDx5YRyfttQw08+kkD6d4B3+34I4M+QBk8zdUVQfB5p0nnRTTymA
        6cDTq6xmH0JA5/4ayyTcd75Lyw==
X-Google-Smtp-Source: ACHHUZ56MEkeH5Zo1tXDtmMTp0+mZ8Ne4ufF6avETdOTCToxjO9N+oqb5AbfO1rRUEIIe3xcJl8rCw==
X-Received: by 2002:a05:620a:208c:b0:75b:23a1:8e30 with SMTP id e12-20020a05620a208c00b0075b23a18e30mr11561210qka.1.1685716165465;
        Fri, 02 Jun 2023 07:29:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w8-20020ae9e508000000b0075ce3d29be5sm694399qkf.44.2023.06.02.07.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:29:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q55mO-001veh-8c;
        Fri, 02 Jun 2023 11:29:24 -0300
Date:   Fri, 2 Jun 2023 11:29:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        "elic@nvidia.com" <elic@nvidia.com>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: system hang on start-up (mlx5?)
Message-ID: <ZHn8xALvQ/wKER1t@ziepe.ca>
References: <A1E5B427-897B-409E-B8E3-E417678E81F6@oracle.com>
 <bf2594bb-94e0-5c89-88ad-935dee2ac95c@leemhuis.info>
 <5b235e0f-cd4c-a453-d648-5a4e9080ac19@leemhuis.info>
 <AAFDF38A-E59A-4D6A-8EC2-113861C8B5DB@oracle.com>
 <bb2df75d-05be-3f7b-693a-84be195dc2f1@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb2df75d-05be-3f7b-693a-84be195dc2f1@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 02, 2023 at 03:55:43PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 02.06.23 15:38, Chuck Lever III wrote:
> > 
> >> On Jun 2, 2023, at 7:05 AM, Linux regression tracking #update (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
> >>
> >> [TLDR: This mail in primarily relevant for Linux regression tracking. A
> >> change or fix related to the regression discussed in this thread was
> >> posted or applied, but it did not use a Link: tag to point to the
> >> report, as Linus and the documentation call for.
> > 
> > Linus recently stated he did not like Link: tags pointing to an
> > email thread on lore.
> 
> Afaik he strongly dislikes them when a Link: tag just points to the
> submission of the patch being applied;

He has said that, but AFAICT enough maintainers disagree that we are
still adding Link tags to the submission as a glorified Change-Id

When done well these do provide information because the cover letter
should back link to all prior version of the series and you can then
capture the entire discussion, although manually.

> at the same time he *really wants* those links if they tell the
> backstory how a fix came into being, which definitely includes the
> report about the issue being fixed (side note: without those links
> regression tracking becomes so hard that it's basically no
> feasible).

Yes, but this started to get a bit redundant as we now have

 Reported-by:  xx@syzkaller

Which does identify the original bug and all its places, and now
people are adding links to the syzkaller email too because checkpatch
is complaining.

> > Also, checkpatch.pl is now complaining about Closes: tags instead
> > of Link: tags. A bug was never opened for this issue.
> 
> That was a change by somebody else, but FWIW, just use Closes: (instead
> of Link:) with a link to the report on lore, that tag is not reserved
> for bugs.
> 
> /me will go and update his boilerplate text used above

And now you say they should be closes not link?

Oy it makes my head hurt all these rules.

Jason
