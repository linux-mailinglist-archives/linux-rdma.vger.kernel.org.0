Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A755E55CB2E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 14:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbiF1GTE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jun 2022 02:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiF1GTD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jun 2022 02:19:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E28959C;
        Mon, 27 Jun 2022 23:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z1yFOr0iIA6911uUhXzco1TiUIJCZff2uznubHIMo7s=; b=r/RfHWSB/0MKBEC/d/vsTKzuh+
        nlfM7Ad6/6WsVUbcyGXvClYAsJztYlPGtxAw6mkVscmZBBWqb7QPPb3ttfqDdLw9O5dPK1/cCG5/W
        1FEvUFHPA1wL+S67RHEmx82tIHVhCKCpzeJB1ODhYT/n9xiaVL+Y7FcnuiFBtt/HXdS6AGjhiCpym
        9hVQuMgzZF/SEy8sJ8YBKGFbhl5rwACAsLE9FcOBC9x/i+4Ylh7v13LxBmoF8evvjyY55keps59YR
        nANS1tcIuIzHsSjgAQZox420v1BuZSRW72eSoCgqPd7/efvMR/uG1rJvv22aP3rRKJLP5kun8FtO0
        ovb7vxvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o64Ys-004fMa-72; Tue, 28 Jun 2022 06:18:58 +0000
Date:   Mon, 27 Jun 2022 23:18:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [bug report from blktests nvme/032] WARNING: possible circular
 locking dependency detected
Message-ID: <YrqdUpLVbLF7WNGs@infradead.org>
References: <4ed3028b-2d2f-8755-fec2-0b9cb5ad42d2@fujitsu.com>
 <YrqauCHdcieF5+C7@kroah.com>
 <YrqbNfF9uYMSwZ4V@infradead.org>
 <Yrqb47ozk5IWTnWp@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrqb47ozk5IWTnWp@kroah.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 28, 2022 at 08:12:51AM +0200, Greg Kroah-Hartman wrote:
> Ah, so it's a fake PCI device, or is it a real one?

Whatever the blktests configuration points to.  But even if it is
"fake" that fake would come from the hypervisor.
