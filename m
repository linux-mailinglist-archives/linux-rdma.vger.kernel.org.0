Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446346DC0DA
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Apr 2023 19:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjDIRVy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Apr 2023 13:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjDIRVx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Apr 2023 13:21:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963AF2D5E
        for <linux-rdma@vger.kernel.org>; Sun,  9 Apr 2023 10:21:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A42060C1A
        for <linux-rdma@vger.kernel.org>; Sun,  9 Apr 2023 17:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CF7C433EF;
        Sun,  9 Apr 2023 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681060910;
        bh=d8VsXScA9GVYaAABa5ASQUE/vS7zkV4K/l9/sBA9JrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lM/I1nRnkjcOz3bzt1SEN87Ryz2oFLvRQOCdYI3TsfQuHFsv6/IPgISmWiYp91l9B
         2OYg3jWriPJQtAvToXJ0KLn95ZULXykSVVwk/M6VMmGeUwIc81ZQX2G5tXo+/govaJ
         6HN6XgJEInxZGIPr4rD5ScRGCL+uJlfdZ5dGFA62UYtR1v2v+cEEcFhd3gnz21whHD
         94e950/WmmwHTwB+iiZ9e4WgriJp2UHS5VH6knwyb5f3kxzuVUBpsvLyKG9Alr5P6K
         HV4XOxmiIxtkXQyVEbTjhkvJd163+F3YiOcIovuwjoUmzDnDoO2i/51q4H52oKBlZg
         GrzPU/yftmB2Q==
Date:   Sun, 9 Apr 2023 20:21:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Nachum, Yonatan" <ynachum@amazon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
        matua@amazon.com, mrgolin@amazon.com,
        Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH] RDMA/efa: Add rdma write capability to device caps
Message-ID: <20230409172146.GJ182481@unreal>
References: <20230404154313.35194-1-ynachum@amazon.com>
 <20230409073228.GA14869@unreal>
 <f738b558-f0d9-e69e-0939-a80594063d4c@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f738b558-f0d9-e69e-0939-a80594063d4c@amazon.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 09, 2023 at 02:28:04PM +0300, Nachum, Yonatan wrote:
> 
> >>
> >>       access_flags &= ~IB_ACCESS_OPTIONAL;
> >>       if (access_flags & ~supp_access_flags) {
> >> diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
> >> index 74406b4817ce..d94c32f28804 100644
> >> --- a/include/uapi/rdma/efa-abi.h
> >> +++ b/include/uapi/rdma/efa-abi.h
> >> @@ -121,6 +121,7 @@ enum {
> >>       EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS = 1 << 2,
> >>       EFA_QUERY_DEVICE_CAPS_CQ_WITH_SGID     = 1 << 3,
> >>       EFA_QUERY_DEVICE_CAPS_DATA_POLLING_128 = 1 << 4,
> >> +     EFA_QUERY_DEVICE_CAPS_RDMA_WRITE = 1 << 5,
> > 
> > Why do you need special device capability while all rdma-core users
> > set IBV_ACCESS_REMOTE_WRITE anyway without relying on anything from
> > providers?
> > 
> > Thanks
> 
> We need to query the device because not every device supprort the same RDMA capabilities. Upper layers in the SW stack needs this supported flags to indicate which flows they can use. In addition this is identical to the existing RDMA read support in our code.

Nice, but it doesn't answer my question. Please pay attention to the
second part of my question "while all rdma-core ....".

Thanks

> 
> Thanks.
