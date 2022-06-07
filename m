Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D226A53F896
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jun 2022 10:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbiFGItM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jun 2022 04:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbiFGIso (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jun 2022 04:48:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EFCB4BB
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jun 2022 01:48:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34EEA61751
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jun 2022 08:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2197CC3411C;
        Tue,  7 Jun 2022 08:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654591722;
        bh=Jkt7DuJcEncNw5QXHYu/cpSjvYy09FSeQds6udFyd9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VseXtVBtgaiDLGpddtPQAhbAl2XoJ3l0UTHSSPOQVIQ9nO4+Gm2gupLxL7u9MEmtA
         yESnZYZS8AqHug9XZ6xwsFtW+1cTEE8OFUKrMIOaIT2VGSuv5U9B3T01M3+XZoByYw
         bPd5MzbantoA1yvUVSj17vRcmzsOlnzEZ/QGAlkyf6n9dsI9KqjumI9YdoS9n2KtxN
         qFKeXSjvdLOGcoxgXqrr0bu3LPGuI9+JvYiurJvZhaiOxwzPnLKfh1e1r/bEqLYh2k
         VODvtb4ZVTn8ygj0Aoj/NY20COllsJOlSNcqi1RhYPez0I8xwfsczKbu6WuY0uZ2Qv
         yGqy/CFlTk2kw==
Date:   Tue, 7 Jun 2022 11:48:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next] RDMA/qedr: Fix reporting QP timeout attribute
Message-ID: <Yp8Q5hX40zbIaNlq@unreal>
References: <20220525132029.84813-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525132029.84813-1-kamalheib1@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 25, 2022 at 04:20:29PM +0300, Kamal Heib wrote:
> Make sure to save the passed QP timeout attribute when the QP gets modified,
> so when calling query QP the right value is reported and not the
> converted value that is required by the firmware. This issue was found
> while running the pyverbs tests.
> 
> Fixes: cecbcddf6461 ("qedr: Add support for QP verbs")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/qedr/qedr.h  | 1 +
>  drivers/infiniband/hw/qedr/verbs.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 

Thanks, applied to -rc.
