Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFE87A5B21
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 09:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjISHh1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 03:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjISHh0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 03:37:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A0EFC;
        Tue, 19 Sep 2023 00:37:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D3BC433C8;
        Tue, 19 Sep 2023 07:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695109039;
        bh=hw/PLJo9AvSjPNxvgMGEVejD6C36fUyBhR/MMoCVeHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k5fvtEl9ChBlrZltiFvYSvVqhoV5N98VV0GUTqYhl+AvKTkhh9KoDS08YDijtbFRo
         R7klitQxOPsdjFS3p7TDe+AuRrQDBYCb2bjnGzqQcRqtnZVF1JorofaSBXPGXW0/Fx
         wG7+KT858xTqrOWxUTPJxozZRehPW+XZHoLC10WY+nGVrMePO6gMWSjK33UuuXFOdy
         7DsVD2ijZqFZcUztIvCkUM/a71HrKdTUjqKv7TBpJoho6Usgx2kUh9KlN76/Nbsz1S
         vB40mIhP75HgoRahA4G++ii8Bg5XgRRvln6WOUfn6nU4XmjSviq+yqIuYOJ+/ACTBP
         CJhv9SdytzvyA==
Date:   Tue, 19 Sep 2023 10:37:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@mellanox.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] RDMA/core: Use size_{add,sub,mul}() in calls to
 struct_size()
Message-ID: <20230919073715.GC4494@unreal>
References: <ZQdt4NsJFwwOYxUR@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQdt4NsJFwwOYxUR@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 17, 2023 at 03:21:36PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,

The thing is that it doesn't.

> the protection that `struct_size()` provides against potential integer
> overflows is defeated. Fix this by hardening calls to `struct_size()`
> with `size_add()`, `size_sub()` and `size_mul()`.
> 
> Fixes: 467f432a521a ("RDMA/core: Split port and device counter sysfs attributes")
> Fixes: a4676388e2e2 ("RDMA/core: Simplify how the gid_attrs sysfs is created")
> Fixes: e9dd5daf884c ("IB/umad: Refactor code to use cdev_device_add()")
> Fixes: 324e227ea7c9 ("RDMA/device: Add ib_device_get_by_netdev()")
> Fixes: 5aad26a7eac5 ("IB/core: Use struct_size() in kzalloc()")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v3:
>  - Include changes to other files in drivers/infiniband/core/
>  - Update changelog text with a more descriptive argument for the
>    changes.
>  - Add more `Fixes:` tags.

I don't think that any of these Fixes are necessary, as nothing wrong
in the code you changed.

Thanks
