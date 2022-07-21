Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D431F57C555
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 09:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiGUHbz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 03:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGUHby (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 03:31:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB9940BCB;
        Thu, 21 Jul 2022 00:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93C13B82295;
        Thu, 21 Jul 2022 07:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30CBC341C0;
        Thu, 21 Jul 2022 07:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658388711;
        bh=D/EwxG48+usgRTXxqf6kit86Em4c5TWk/ao44/6iDaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1p5Nr7ZODMqDdhsmoYYxS0kZTkKG7dakrbNgEqjrv6kE+hthnls1UCEm5yZLg6sk
         pCw5Lu6yeBLoy7bgKGpW6JEdEmgkgaJcndr3Czbo71zxCQ4Mb/PG9AOKOVL+yTaXpq
         +nKkeor1aeM1XBBsmkaVv2wxpkFC2aziiPlY2+3xPikS6dNLQ7etiV3rS3Z7jsbcBS
         lqwvyzp561bSI1OpG2n4VSAENmi7S3S3xiBlrWcW0h0Sr1BwG4fgj8flR1WdiSKg/5
         83eDaLeqvZHjThlhFj47EEaLnDWsqxggQSxMPQeKScx3po/g5X/JPgCvCJRd+gJyba
         JH6iqBF8G/6bw==
Date:   Thu, 21 Jul 2022 10:31:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/2] RDMA/erdma: Use the bitmap API to allocate bitmaps
Message-ID: <YtkA4tBhlSHX76JM@unreal>
References: <2764b6e204b32ef8c198a5efaf6c6bc4119f7665.1657301795.git.christophe.jaillet@wanadoo.fr>
 <670c57a2-6432-80c9-cdc0-496d836d7bf0@linux.alibaba.com>
 <20220712090110.GL2338@kadam>
 <20220719125434.GG5049@ziepe.ca>
 <20220719130125.GB2316@kadam>
 <7075158a-64c1-8f69-7de1-9a60ee914f05@wanadoo.fr>
 <5bcd437f-92a4-1c04-796c-41559dd2823a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bcd437f-92a4-1c04-796c-41559dd2823a@linux.alibaba.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 20, 2022 at 09:58:24AM +0800, Cheng Xu wrote:
> 
> 
> On 7/19/22 11:36 PM, Christophe JAILLET wrote:
> > Le 19/07/2022 à 15:01, Dan Carpenter a écrit :
> >> On Tue, Jul 19, 2022 at 09:54:34AM -0300, Jason Gunthorpe wrote:
> >>> On Tue, Jul 12, 2022 at 12:01:10PM +0300, Dan Carpenter wrote:
> >>>
> >>>> Best not to use any auto-formatting tools.  They are all bad.
> >>>
> >>> Have you tried clang-format? I wouldn't call it bad..
> >>
> >> I prefered Christophe's formatting to clang's.  ;)
> >>
> >> regards,
> >> dan carpenter
> >>
> >>
> > 
> > Hi,
> > 
> > (some other files in the same directory also have some checkpatch warning/error)
> 
> I just double checked the checkpatch results, Two type warnings reported:
> 
>  - WARNING: Missing commit description - Add an appropriate one (for patch 0001)
>  - WARNING: added, moved or deleted file(s), does MAINTAINERS need updating? (for almost all patches except 0001/0011)
> 
> For the first warning, the change is very simple: add erdma's
> rdma_driver_id definition, I think the commit title can describe
> all things, and is enough.

To be clear, our preference is to have commit message in any case, even
for simple changes.

Thanks
