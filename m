Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221F363F60A
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 18:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiLARPm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 12:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiLARPh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 12:15:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF921AD9BA;
        Thu,  1 Dec 2022 09:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i54LoHwqQzG0+w5GcsFXQBgG5XeIFAZjuM7cveu6s7Y=; b=5CCyHWZrh/Bwg8CC2fdyd9GYro
        c8MN4PU6tRGh55TUFF7+5RwzXoN9v6yCF7CvV/LUYOti6AtW76AbgP4f7DDnxCRHUTRRblRyL7d2u
        35QPcYoolFms7S/8pgSTfWpKT3Gl+q1QPnZbr/5ytAvgQKdaUdMnTcyjh56tRfwR7lJ7KL4MsQAO1
        IycZ/k2V/EjL8CYg7C30nLWmgvBM7Tb5gf5ysTts2HMp72cNqaobJGw8BrKvZtwPZjtaDP7gFYZnu
        rVEwW3bPEikEfbR2ZNU1GyzxyT7hbHr3pPTIDm9z4EKWc6ol176GiQRA5/QRdj4IgXMrUoWSviybq
        Zg3i6DRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p0n9n-008toA-1W; Thu, 01 Dec 2022 17:15:31 +0000
Date:   Thu, 1 Dec 2022 09:15:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH 1/2 v2] IB/qib: don't use qib_wc_x86_64 for UML
Message-ID: <Y4jhMwCox6RGI5FM@infradead.org>
References: <20221130200945.24459-1-rdunlap@infradead.org>
 <Y4hyPPzyQiI3i9jh@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4hyPPzyQiI3i9jh@unreal>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 01, 2022 at 11:22:04AM +0200, Leon Romanovsky wrote:
> I would advocate to add this line to whole drivers/infiniband.
> None of RDMA code makes sense for UML.

software iWarp and RoCE absolutely make sense on UML.
