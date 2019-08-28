Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE8BA002E
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 12:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfH1Krn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 06:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfH1Krn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Aug 2019 06:47:43 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 349CF206BB;
        Wed, 28 Aug 2019 10:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566989262;
        bh=wZqnEjQ2BISRZIRjtUl9KpB2MSMbu6xKcFiH84FZs58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0veXS8BNcEQ6bYurJ0KV8yzEs48+Y7/yWNiTir1tSYR9CnG8ZPuv2sWv2hSQq/tY
         lH5CANIdytUKLXXkjmvb0+bwlbwGw8mqWHIcj5E254d5L3hXtbBeb/gBuu4ai5Bh1+
         QlBdXxluObq+k2ySVv5eRm+WbUCDDkL6xr+HUXkI=
Date:   Wed, 28 Aug 2019 13:47:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca,
        dledford@redhat.com
Subject: Re: [PATCH v3] RDMA/siw: Fix IPv6 addr_list locking
Message-ID: <20190828104738.GF4725@mtr-leonro.mtl.com>
References: <20190828093841.21993-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828093841.21993-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 28, 2019 at 11:38:41AM +0200, Bernard Metzler wrote:
> Walking the address list of an inet6_dev requires
> appropriate locking. Since the called function
> siw_listen_address() may sleep, we have to use
> rtnl_lock() instead of read_lock_bh().
>
> Also introduces sanity checks if we got a device
> from in_dev_get() or in6_dev_get().
>
> Changes from v2:
> - Use plain version of list_for_each_entry
>   in exchange of list_for_each_entry_rcu.
>
> Changes from v1:
> - Remove rcu_read_lock()/_unlock().
> - Add check for IFA_F_TENTATIVE and
>   IFA_F_DEPRECATED flags.

You need to add changelogs after "---" line, they will be trimmed
automatically while applying to git.

Latest example:
https://lore.kernel.org/linux-rdma/26ae8c4006cb31ee8c26fb821451d43732c7a35a.camel@redhat.com/T/#m75d9725823fd3f437298528c427dcfc3a0fe9050

Thanks
