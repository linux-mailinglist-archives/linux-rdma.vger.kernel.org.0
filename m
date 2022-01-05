Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B51B484E92
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 08:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiAEHCl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 02:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiAEHCl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 02:02:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF383C061761;
        Tue,  4 Jan 2022 23:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PSx7P029DHEH6YRU70k09ibE+97CxrGvx2xhLycV65A=; b=UVBjtd1nIrCCYVmoi4azHpGot5
        ezt+JCcCfTN05Z4eA2BDFQj/plz303G2MzaYxHIZP0tjyKh4THybGvFRuEKI5g0EwPde9BobWaoC7
        xSScmH66qSlKu6GbR4Zy2V8Qgs4q7ODMGrPIPwIhha7QG+DESFL+3PmAQFbV1JAnpwZEV5sHx6oMk
        4BkYv6wpdtfze1k7X0X2dZ5MAM3qM2akkD4ng8jVZNMRn+WfPtE92+bLZo/0pTqaDP372K+xqDW/m
        /oLjO2xyqqe1zjAqFp3RyY53rF15C/lxCGvF9GpnuZqg/rydwdzb+LzhWjFa3jOJat/tI15JysCeJ
        9qvS1+GA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n50Ji-00DyzG-8X; Wed, 05 Jan 2022 07:02:38 +0000
Date:   Tue, 4 Jan 2022 23:02:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, hch@infradead.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        leon@kernel.org
Subject: Re: [PATCH v3] RDMA/rxe: Fix indentations and operators sytle
Message-ID: <YdVCjt/QiLUQftRu@infradead.org>
References: <20220105042605.14343-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105042605.14343-1-lizhijian@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 12:26:04PM +0800, Li Zhijian wrote:
> * Fix these up to always have the '+', and '|' on the continuing line which
>   is the normal kernel style.
> * Fix indentations correspondingly
> 
> NOTE: this patch also remove the 2 redundant plus in IB_OPCODE_RD_FETCH_ADD
> and IB_OPCODE_RD_COMPARE_SWAP
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
