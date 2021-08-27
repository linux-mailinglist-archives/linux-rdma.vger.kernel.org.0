Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5CB3F946B
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 08:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhH0G3S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Aug 2021 02:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhH0G3R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Aug 2021 02:29:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE21AC061757
        for <linux-rdma@vger.kernel.org>; Thu, 26 Aug 2021 23:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P0izCZvyD7jn2xPyoAngwXbsg20f12urExvVKWFw0Vk=; b=fW454hexmlzUwTPpWQcBeWpot3
        tiSjEzvIK3ZjCYpQfiPPPAQKdygOqDkajVIumvh8bk4aw2wxjrtufW8y02I2IfEJ+qZtKG/ujj8j1
        9lA8IKXiqtuSF6ahWktenS9dyIsLAFhPMFeGDuzWXEMv4RspZKhj9RnW+ikcqfsoyc9p2NMsXN5Vh
        KY+FbCU7QQZj8FmNWhHS14DmGKlADukeWoOxWtTx7Hq/m3M0lcAjeayfbZxaX2tIDkuasQlIDxUm5
        7CHmAAGFAIn+nZO7g09xBjnHe4RvXhltqonHUXz3KfHLPf4Vnp1sgxZKT/XwEzukh99sh2ug/msbV
        SSs9J8jw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJVLG-00ECfl-2m; Fri, 27 Aug 2021 06:28:04 +0000
Date:   Fri, 27 Aug 2021 07:27:54 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
Subject: Re: IB_MR_TYPE_SG_GAPS support
Message-ID: <YSiF6iER1CXmjit1@infradead.org>
References: <D87B6648-A4C4-4D0B-A390-EA1F0A240C08@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D87B6648-A4C4-4D0B-A390-EA1F0A240C08@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 26, 2021 at 05:26:11PM +0000, Chuck Lever III wrote:
> Hi-
> 
> I have a report that net/sunrpc/xprtrdma/frwr_ops.c::frwr_map()
> is attempting to register a mix of GPU and CPU pages with a
> single MR during an NFSv4 READ.

What GPU pages?
