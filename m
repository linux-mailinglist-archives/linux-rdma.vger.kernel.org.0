Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE43143E2FE
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 16:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhJ1OE5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 10:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhJ1OE4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Oct 2021 10:04:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF66DC061570;
        Thu, 28 Oct 2021 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UfjsYhiRcSank6A2IzO7XbDBsmDmgHLyZsbz7vn8sLM=; b=fUFmybLY7f6WY/JhhuB+aexrhV
        T165OYZ533+3TQ5VqYkmnuBtjNDrNium/Mi87aKx91ScvSFYd16VBIv8AGBa/8GniomDMzPcZ7QXT
        blrO3YcP7WZ/DGASnnCxJTyjqDtTqQVbk6H14yA23EtMphWxyGnzspThSm9Yt6Dvg3Tn2vbYSA4D+
        3vRpT46Tuk6hKi1WW6ubezrM3+FzE2vmUI/xM+z3yMMqAUXFr/V/zlY4aFOgMyeeDyLSKtjdOpERo
        C0iP3Q8XPQbqvI284JGPEv9MAKw9iI0IFI+twG8M5RdjJXHKgb2KZdNCKlrA2LufBhHu3/rxOVH0j
        scWCcpew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mg5z8-0083Lk-8P; Thu, 28 Oct 2021 14:02:26 +0000
Date:   Thu, 28 Oct 2021 07:02:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Rely on vendors to set right IOVA
Message-ID: <YXqtci47xMYVZz4Y@infradead.org>
References: <4b0a31bbc372842613286a10d7a8cbb0ee6069c7.1635400472.git.leonro@nvidia.com>
 <YXpXvh0sxP8r9r7R@infradead.org>
 <YXp0XSpXsarxrGqS@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXp0XSpXsarxrGqS@unreal>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 28, 2021 at 12:58:53PM +0300, Leon Romanovsky wrote:
> "vendor" is wrong word here.
> 
> I wanted to say that all drivers which support ".rereg_user_mr()"
> callback and return new_mr should set everything. In case of IB_MR_REREG_TRANS
> flow, it is IOVA which is not cmd.hca_va, but mr->iova.

Thanks, that makes a lot more sense.
