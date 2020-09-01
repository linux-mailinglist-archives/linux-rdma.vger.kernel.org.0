Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867AF2587AC
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Sep 2020 07:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIAF44 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 01:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgIAF44 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 01:56:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4F4C0612A3
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 22:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n0EZzbxDIclSRtwYwSZ9ASal2xohIaidhm9aIvcb1uk=; b=LXGUT2GxWNtpVZV/YKlMetvt+7
        gS5T0yoVMrII8euNQNJ1qlWFivOnm5eNxzeIU49pzmK4vC7oPjy+6LQf4zhOEm3BkPtxdlIq/NwLN
        b/36HWVvtp4OHAF+TPnMsAF+E0kYzoKDddRqiS+imoQ2Ot41HlbQNOxucKyiMSty3ZrBhQZftUpu9
        RFPl1ye2BYcnn4AtJo5cQl6GA9byCdr6CIAbgd61eTYJd4wG19vGdFtxy2D9rDCdqc8SKWkWK86XU
        EKpNnzt7g0nFy9W0hRxhkGeLPPAQWPFwkYPTOYHPqN/0TSE+ObmIeVndSTnYa7S4/vNvtEUz8uicO
        N6lY38Uw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCzHl-0008W2-8G; Tue, 01 Sep 2020 05:56:49 +0000
Date:   Tue, 1 Sep 2020 06:56:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     doug@easyco.com, Sagi Grimberg <sagi@grimberg.me>,
        linux-rdma@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Stephen Rust <srust@blockbridge.com>,
        ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] IB/isert: fix unaligned immediate-data handling
Message-ID: <20200901055649.GB31408@infradead.org>
References: <20200830103209.378141-1-sagi@grimberg.me>
 <20200831121818.GZ24045@ziepe.ca>
 <8bc2755b-e7d6-5d9c-f5e0-e8036b28beb6@grimberg.me>
 <CAFx4rwRQ7z+sATpKuYNwTWqnepcWQeinxFjsZEEDAQobeSVACQ@mail.gmail.com>
 <20200831175931.GC24045@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831175931.GC24045@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 31, 2020 at 02:59:31PM -0300, Jason Gunthorpe wrote:
> Can we put all this info in the commit message please?

Yes, please.  Note that the block layer actually reports the
required dma alignment.  The worst case is the logical block size,
but many devices require less alignment.
