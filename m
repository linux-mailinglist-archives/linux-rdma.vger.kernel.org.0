Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA68F57C548
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 09:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiGUH1b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 03:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGUH1a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 03:27:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBED7C18F;
        Thu, 21 Jul 2022 00:27:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B15CE61E1E;
        Thu, 21 Jul 2022 07:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EA4C3411E;
        Thu, 21 Jul 2022 07:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658388447;
        bh=E86sEscD6n6MV3EJ+eMBIPzwz8N7mGyl3gJcNS5o4qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMsgaZvA9OzBQVa8Y1PrOISNc5G4qb8fuY93pILVCU7xEm33Y1m3mQR230WSGrJNw
         QjClB4bR/Ea5SpTrpmWfue53Vu49whzZTdUmjGMavifvp/PjTZE35oYnoOWVnOGAIx
         McUiSRCeiDxwF63XdWWMqxFN/b47m3zfrkfSy9QeABWKnlwr/C9pUbzjBKs++0xgI4
         cn5iwQT2G+dIq19e24dBVvcXQtQeIedaSqE2B6zfPWC6bcDRoyBkFV24Qw5F3u5DYe
         UfvG9CM8PBQ3lSs9opSn+gZGbJ49NOyW+MqRj7mzJrCQ3AywChfJa56FnjmawSKZHR
         dijjGUtm7gfdA==
Date:   Thu, 21 Jul 2022 10:27:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/2] RDMA/erdma: Use the bitmap API to allocate bitmaps
Message-ID: <Ytj/27UCySaronBO@unreal>
References: <2764b6e204b32ef8c198a5efaf6c6bc4119f7665.1657301795.git.christophe.jaillet@wanadoo.fr>
 <670c57a2-6432-80c9-cdc0-496d836d7bf0@linux.alibaba.com>
 <20220712090110.GL2338@kadam>
 <20220719125434.GG5049@ziepe.ca>
 <20220719130125.GB2316@kadam>
 <7075158a-64c1-8f69-7de1-9a60ee914f05@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7075158a-64c1-8f69-7de1-9a60ee914f05@wanadoo.fr>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 19, 2022 at 05:36:36PM +0200, Christophe JAILLET wrote:
> Le 19/07/2022 à 15:01, Dan Carpenter a écrit :
> > On Tue, Jul 19, 2022 at 09:54:34AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jul 12, 2022 at 12:01:10PM +0300, Dan Carpenter wrote:
> > > 
> > > > Best not to use any auto-formatting tools.  They are all bad.
> > > 
> > > Have you tried clang-format? I wouldn't call it bad..
> > 
> > I prefered Christophe's formatting to clang's.  ;)
> > 
> > regards,
> > dan carpenter
> > 
> > 
> 
> Hi,
> 
> checkpatch.pl only gives hints and should not blindly be taken as THE
> reference, but:
> 
>   ./scripts/checkpatch.pl -f --strict
> drivers/infiniband/hw/erdma/erdma_cmdq.c
> 
> gives:
>   CHECK: Lines should not end with a '('
>   #81: FILE: drivers/infiniband/hw/erdma/erdma_cmdq.c:81:
>   +	cmdq->comp_wait_bitmap = devm_bitmap_zalloc(
> 
>   total: 0 errors, 0 warnings, 1 checks, 493 lines checked
> 
> (some other files in the same directory also have some checkpatch
> warning/error)
> 
> 
> 
> Don't know if it may be an issue for maintainers.

We don't run with --strict. It is indeed very subjective.

Thanks

> 
> CJ
