Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF21E6C037F
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Mar 2023 18:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCSRhZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Mar 2023 13:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCSRhY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Mar 2023 13:37:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830E230D6;
        Sun, 19 Mar 2023 10:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F047B80AB6;
        Sun, 19 Mar 2023 17:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAEDC433EF;
        Sun, 19 Mar 2023 17:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679247441;
        bh=upZcKMU7+DARFBX3E6Uc9RmcizJx5/0XM13Bn3C1u9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gp/UY7wUWiE4dCNZuyDu9CYQLvVeAZa+RMcv8KH65JfRJYu5Z3gk6DI+YPaOsv6De
         dHHJYNxXZyzifWfhoMdIVD7m2YMlCiYI1mq4LogR/Qpcv/bcfyl0/I3N6hzcfb+mgv
         keBDBWXYbTCtucguhuUu2Ggm2cLX86+hp3OMGHJaatBuYXL6XwyGqj4zU68+tfvG3I
         loR48IuuM1Z+G05ivUGgy/trf+m8zJeSZRn/P7yPZNqKbhKK7QNfG7XrutUdI30dBN
         03V2Ze7mxH/T2i+3fGakoVjNvuD1kIezWUHYWR3YE+xkrkdQ/Msvv7Pc41PNfSxyAg
         mXAuL253DwA0w==
Date:   Sun, 19 Mar 2023 19:37:16 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RDMA/siw: Fix exception handling in siw_accept_newconn()
Message-ID: <20230319173716.GF36557@unreal>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <afe30fc6-04c9-528c-f84a-67902b5a6ed8@web.de>
 <20230319114048.GB36557@unreal>
 <1c06e86d-1468-c11a-8344-9563ad6047b5@web.de>
 <20230319141145.GE36557@unreal>
 <a03c1d04-a41e-7722-c36a-bd6f61094702@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a03c1d04-a41e-7722-c36a-bd6f61094702@web.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 19, 2023 at 04:40:17PM +0100, Markus Elfring wrote:
> >>>> Date: Sat, 18 Mar 2023 20:30:12 +0100
> >>>>
> >>>> The label “error” was used to jump to another pointer check despite of
> >>>> the detail in the implementation of the function “siw_accept_newconn”
> >>>> that it was determined already that corresponding variables contained
> >>>> still null pointers.
> >>>>
> >>>> 1. Use more appropriate labels instead.
> >>>>
> >>>> 2. Delete two questionable checks.
> >>>>
> >>>> 3. Omit extra initialisations (for the variables “new_cep” and “new_s”)
> >>>>    which became unnecessary with this refactoring.
> >>>>
> >>>> This issue was detected by using the Coccinelle software.
> >>>>
> >>>> Fixes: 6c52fdc244b5ccc468006fd65a504d4ee33743c7 ("rdma/siw: connection management")
> >>>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> >>>> ---
> >>>>  drivers/infiniband/sw/siw/siw_cm.c | 32 ++++++++++++++----------------
> >>>>  1 file changed, 15 insertions(+), 17 deletions(-)
> >>> Please read Documentation/process/submitting-patches.rst and resubmit.
> >>> Your patch is not valid.
> >>
> >> What do you find improvable here?
> > Did you read the guide above?
> 
> Yes, of course (several times before).

ok, I'm taking my request to resubmit back.
Please retain from posting to RDMA ML. I'm not going to apply any of
your patches.

Thanks
