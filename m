Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C0E1FC89E
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 10:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgFQI3Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 04:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFQI3W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 04:29:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE569C061573;
        Wed, 17 Jun 2020 01:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n02mO7xJSYvfLc+31B2gbfttpsS1oFP+auLBuWniO58=; b=tSaAQX4rXrSse33BYOEY+4/dhK
        yqeQtJf1zT48/1t97M70iR3+SiO+gTkEnCwdbXAMkoAUxDtUM5KGcdgYXhR1KIhK3G8KCcCirJwKg
        qzpFofQkzbdYNP+LJiMhJIqm/VCn26L60vvyJ4QBq8CvDaXYDTDJrTwW9kvRZT+v5syzyV2nJSRix
        t3YqWZrCx5/z/Ul14ZgILY27noQ6u03wzsWk2fJT+Z9ACdqtn9v/x63OOjw97LW2VB7UHI2K/XE2I
        Kq5oRweuCGTw/Glk1br5uaAQKrYaR4ii1tJ7a5cxikK0Tv/NSCBHKlCR1lvD9HnN/G84evIMGiiAo
        bQ3OQFPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlTRc-0003bj-8n; Wed, 17 Jun 2020 08:29:16 +0000
Date:   Wed, 17 Jun 2020 01:29:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next 0/7] Introduce KABIs to query UCONTEXT, PD and
 MR properties
Message-ID: <20200617082916.GA13188@infradead.org>
References: <20200616105531.2428010-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616105531.2428010-1-leon@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I think you are talking about UABIs (which in linux we actually call
uapis).

