Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69DC7207F5
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 18:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjFBQyM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 12:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbjFBQyL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 12:54:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1F91A5
        for <linux-rdma@vger.kernel.org>; Fri,  2 Jun 2023 09:54:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6975565266
        for <linux-rdma@vger.kernel.org>; Fri,  2 Jun 2023 16:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BABC433D2;
        Fri,  2 Jun 2023 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685724848;
        bh=cn8PP+KjC0WdCEavBUy1xLwsTmD3K1c7Pp/44YdagUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MLYFWvjvPLphpN5Mb3iQJwqqIMW3Dm2kYlBVp41Lqw8WsAX2cMaz15LCUGAYUrfO8
         dEl/ZeJ8RVHSiktRjhv531xztCw8MXvkribL1MhTA1BeWUVMGJQh+DrDWJQ88s5R/s
         FzTdeVacX2FN2l3W+NxvYwMjE504jwU5c9EHrT6DrAS5f0Lj8UQAtSdBS+g1+UmhLR
         M/9Hymur+J7mDh+QCGUl/WKTGzPKwjB5enIcpbdfXxUeqyeUbbwLYPHJdHZqFILDSH
         rpvL7Fa8sXCxdtMMEPeVKT+v7dmT98RsUDzG458g99hy6fLAaoeljHz8v0Spw48SXf
         XAwm/r7XfSyKA==
Date:   Fri, 2 Jun 2023 09:54:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "elic@nvidia.com" <elic@nvidia.com>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: system hang on start-up (mlx5?)
Message-ID: <20230602095407.109bdffc@kernel.org>
In-Reply-To: <ZHn8xALvQ/wKER1t@ziepe.ca>
References: <A1E5B427-897B-409E-B8E3-E417678E81F6@oracle.com>
        <bf2594bb-94e0-5c89-88ad-935dee2ac95c@leemhuis.info>
        <5b235e0f-cd4c-a453-d648-5a4e9080ac19@leemhuis.info>
        <AAFDF38A-E59A-4D6A-8EC2-113861C8B5DB@oracle.com>
        <bb2df75d-05be-3f7b-693a-84be195dc2f1@leemhuis.info>
        <ZHn8xALvQ/wKER1t@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 2 Jun 2023 11:29:24 -0300 Jason Gunthorpe wrote:
> > > Also, checkpatch.pl is now complaining about Closes: tags instead
> > > of Link: tags. A bug was never opened for this issue.  
> > 
> > That was a change by somebody else, but FWIW, just use Closes: (instead
> > of Link:) with a link to the report on lore, that tag is not reserved
> > for bugs.
> > 
> > /me will go and update his boilerplate text used above  
> 
> And now you say they should be closes not link?
> 
> Oy it makes my head hurt all these rules.

+1

I don't understand why the Closes tag were accepted. 
I may be misremembering but I thought Linus wanted Link tags:

Link: https://bla/bla

optionally with a trailer:

Link: https://bla/bla # closes

The checkpatch warning is just adding an annoying amount of noise
for all of use who don't use Closes tags.
