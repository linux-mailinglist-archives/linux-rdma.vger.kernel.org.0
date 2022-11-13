Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BA1626E03
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Nov 2022 08:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiKMHUN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Nov 2022 02:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMHUM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Nov 2022 02:20:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B487E0C5
        for <linux-rdma@vger.kernel.org>; Sat, 12 Nov 2022 23:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C07F7B80B24
        for <linux-rdma@vger.kernel.org>; Sun, 13 Nov 2022 07:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5F2C433C1;
        Sun, 13 Nov 2022 07:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668324009;
        bh=juTSLcTYjA/u+mc0SKYX0NzkffwVLkYGAJagellVniY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQfTvB4c/8S99QbG1dYAgWMdC/39sU5ri8ahht3+whxrswszt4hewmxWbkLipPBcU
         g0RjPpbR9VGkaZHx3/WGf/E+magVGka8TmqsNkWy8H1kkLHKRLwOpdVMCWoJz+sDRs
         tP5N8/7z7Q1+BvWbEZ4eY3+C1o8goMLZ249mLF2RcIcWp8lAlgDzuBuDqpyDczi+PJ
         rv4lmLwvB1J2Upop3DB9p0CVS/MM0sVJXt9vcsClmfqwmEGXMeLEX0cHbh/wmJSp9H
         R21gEAiw5xi7wbI1IaMaWCsDIdbL0diZUaCmh5WHqCssbidLulvfNo81SAT/vEGKNI
         SQ9Sa6fdNnfDQ==
Date:   Sun, 13 Nov 2022 09:19:59 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Or Har-Toov <ohartoov@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 1/4] RDMA/nldev: Use __nlmsg_put instead
 nlmsg_put
Message-ID: <Y3Cany776/OrEpbY@unreal>
References: <cover.1667810736.git.leonro@nvidia.com>
 <3d8fb9edbd41f122fda680158a80bac44e55e847.1667810736.git.leonro@nvidia.com>
 <Y2v8UsT015iiRuob@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2v8UsT015iiRuob@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 09, 2022 at 03:15:30PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 07, 2022 at 10:51:33AM +0200, Leon Romanovsky wrote:
> > From: Or Har-Toov <ohartoov@nvidia.com>
> > 
> > Using nlmsg_put causes static analysis tools to many
> > false positives of not checking the return value of nlmsg_put.
> > 
> > In all uses in nldev.c, payload parameter is 0 so NULL will never
> > be returned. So let's use __nlmsg_put function to silence the
> > warnings.
> 
> I'd rather just add useless checks for the errors than call a private
> function like this. Or add some nlmsg_put_no_payload() that can't fail

This is exactly what __nlmsg_put() means. Function that can't fail.

Thanks

> 
> Jason
