Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881484BA479
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 16:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbiBQPgM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 10:36:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiBQPgL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 10:36:11 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888B02B2E09
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 07:35:57 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id j12so13812883ybh.8
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 07:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6x6WLHULWBbfUO+BIRf7o1DPYLj3VUuhlPV1lV6G8YQ=;
        b=D7i9Aernma5p+p/FOnAsvoivIA3egoQvK4jMD3IqGXjsOrjqVQMnS2ihCxOxSS1/gg
         SUYPK/n3yIb8uUW91y4OKtwgku1BsnA5Leb0dRj/QBYYGZPKXu6BgZOMWZNI+8091xBu
         NoESanm6YmKJcu5Wkqng7IqRVV6TJhLb5q8XVd5gLIAruS1b9IKBTZmpjyyL+OS15SSx
         RnK/Sh0FFAZx1Z3Rdm8pQXwJV9C3Hpd6cPIdc0Hn5pCs0vg2jsa5kxRuKPqbI8G9FxAz
         SNnPJe/HamePUcU4fFyfyNrxB5jejY6RGHW0Qr4cFuejAwZSX5E5MuJKPxgFnfi6tnvw
         aXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6x6WLHULWBbfUO+BIRf7o1DPYLj3VUuhlPV1lV6G8YQ=;
        b=B1Cvp8htddBl8L50XZsLhjRNYYsfc+stQYDPHP6UMnR7oN4t5fShg4F24j3873gbK8
         rMVihhbCyNQ7wIm6qQ4+mSEWU8kxKgSCR3UytFk+nHzvpkcNQ8ei7W6bWyuT5uCd7ndZ
         we9dx3h0qr+Se+7HtXFXX45X8kP2Q9vbgAPEADJmFQs86t02MtdBrbNO83MccBKGcw9X
         8IY43gdPEY/PtDHeVlQ8ni0q1l34h4SZnRg6ciZfcM+JzaNJ1fidVzFwUHmVFHinlUQS
         ElVsJ77AB8ngeDYxn37hkNxsm5Q5yhNZCnRqnAY5okbcU0j7V+Q+ItE31W9jo8DTjsp3
         l/Zw==
X-Gm-Message-State: AOAM530j7VFAr30INFt7sMpgbaB5AY9iN+KX0gmCdCT1pG00nojzBvg2
        eQtPyGoRbjlST4xJ462r5W5C2cmZK3H6mgUNFt0=
X-Google-Smtp-Source: ABdhPJzEwxokQNH0MUCJ0oa3yAHADeJub7fZFOdfmINiVbXotA5ijwvTS1jEUWcux+viyq/w4S1ED0Fj3xKhkCWgICw=
X-Received: by 2002:a25:850b:0:b0:623:ae50:9d7d with SMTP id
 w11-20020a25850b000000b00623ae509d7dmr2931256ybk.326.1645112156669; Thu, 17
 Feb 2022 07:35:56 -0800 (PST)
MIME-Version: 1.0
References: <20220214180833.GA525064@ziepe.ca> <b6c38f40-cbed-9ba7-7184-801ee7c5ab3a@cornelisnetworks.com>
 <PH7PR01MB780099726A47C7335036661BF2369@PH7PR01MB7800.prod.exchangelabs.com>
In-Reply-To: <PH7PR01MB780099726A47C7335036661BF2369@PH7PR01MB7800.prod.exchangelabs.com>
From:   Robin Peiremans <rpeiremans@gmail.com>
Date:   Thu, 17 Feb 2022 16:35:46 +0100
Message-ID: <CAJt3DjAEjZbM9uQSAq1LTdNz=XGGsNT225a5YPzHEqZdHDcHJw@mail.gmail.com>
Subject: Re: sysfs: cannot create duplicate filename
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
Cc:     "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
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

Tested on 5.17 and my ports are back. I can confirm the patch works.

Thanks a lot for the quick fix!

Robin

On Thu, Feb 17, 2022 at 3:29 PM Marciniszyn, Mike
<mike.marciniszyn@cornelisnetworks.com> wrote:
>
> > >
> > > Don't know, Mike tested this patch on qib, maybe he knows
> >
> > A patch to fix the issue should be posted soon.
> >
> > -Denny
>
> See https://lore.kernel.org/linux-rdma/1645106372-23004-1-git-send-email-mike.marciniszyn@cornelisnetworks.com/T/#u.
>
> Mike
