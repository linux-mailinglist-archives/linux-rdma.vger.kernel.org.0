Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4C73D139A
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 18:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhGUPdr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 11:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhGUPdr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 11:33:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E7AC061575;
        Wed, 21 Jul 2021 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=jVN2rGIXZgIBjf/g3bXTJgYHqy
        ZvTUfOGJlxzr77aMAG/ZVHGUtmuUIULW2CBI/XOMnIm1aQSQI7MKZP8UhlCLQdKe/adQpwkGNePf3
        UZ10hk+56jQd3Xal8sTyzkEsV4XnQ26YvVD5CIftpkviQ0x/S1F2WKMflf7s8TlS2iRZSvElF5Zre
        YYM+599T6px1kopQ8NGDFz9pEVcwHTn2p2iCg5RT+DKW9egBhVxSsDYXnRynKDsg+e37xtCMszZIE
        C3ZyBOF5IhXmrjSzhK5sqVPKLFPcXjFI9E1O8aG/2vQBDRKPP9v9FeH+aTneEEydz+pXL07TDt7I7
        zH6SpTdw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6EqI-009NOH-Sv; Wed, 21 Jul 2021 16:13:25 +0000
Date:   Wed, 21 Jul 2021 17:13:06 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zack Rusin <zackr@vmware.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v2 1/2] lib/scatterlist: Fix wrong update of
 orig_nents
Message-ID: <YPhHkp6r8sSMejSf@infradead.org>
References: <cover.1626605893.git.leonro@nvidia.com>
 <36d655a0ff45f4c86762358c7b6a7b58939313fb.1626605893.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36d655a0ff45f4c86762358c7b6a7b58939313fb.1626605893.git.leonro@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
