Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDF93C2490
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jul 2021 15:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhGINXz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jul 2021 09:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbhGINXx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jul 2021 09:23:53 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C98CC0613E9
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jul 2021 06:21:07 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id s6so6379261qkc.8
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jul 2021 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7IzGLjKVrrwjN0uTt13PXB3jJvt8l9fcKIkCTP7vqaM=;
        b=ilZvJqekdiaNoyDUelqtd1Mr2MELdhK7NOPy97RgyCP0M/65g1uZgZ9UQ2c12JIUS0
         Zj/nHUdDAdpCHCqhwHVYPL4uV0Jql3W8XsheURr1cyp13JMkeq9mm5KjdmWiKiGit3f+
         e0jmeXNXHV3MDibDZkmtB+pzf3RgYofJMCgUIahjknN+uBmf92VM6L/OBpMjH7ROIO2p
         vlK5A8BNbzwXIftIyjqVSfvCZ+l3lOQ18bMKdfJE7WujGTNFEwK8Y/Bq4V6iamP3vbFc
         d1trFDgWRAxIT25wKPE8EfJecY99+N9NwYsBihnhuwz8URVrE3pU8OKf8l6PcTYMTAYR
         UQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7IzGLjKVrrwjN0uTt13PXB3jJvt8l9fcKIkCTP7vqaM=;
        b=Qtqa6WMBkGervpJ/lAP2CZoWLXyA9+vCmw1dk37KTzrGD8IXRyBytr3DCgEbTf++oO
         PTDO4iaqQCyTnZbvAkm6Q3DUBJ4HY+rocG+bnJC/wDhEY/XKrKE8x4qVBRLsiJizpX7y
         An5K0EVKcT5kN9u/S3fZ/QXoyx6XdrHFkAvdBeUlfpM35jXRX9sI08+ldXfB+3mu9uvg
         Xb2/rdRcKwFmV2y6TOWFfiiTNfATb0639IUBNrpY6GYVDzrgfTJJNXzcT/f9LNIGoCCO
         1gnV1Be9yj2/nG44MnUgRJZacZhU+6ecOktCGagX0PS/7teaJ6xwLBpeS+1noJIG/2nM
         dTZw==
X-Gm-Message-State: AOAM5308DXwCy9L/FQPlMT5ua3RvQtSluDOXxzfePVxuu1Zenpml71FN
        b7UB7M6NRz1i7LFZvpLbjuGncg==
X-Google-Smtp-Source: ABdhPJznSn3h0MnwLX5ELC2apWnAD6ffHhakwHbcf/hDcrFHnP0g5lW4SvaTIjZo+RvkTwaQr/P99A==
X-Received: by 2002:a05:620a:1996:: with SMTP id bm22mr2618839qkb.262.1625836866657;
        Fri, 09 Jul 2021 06:21:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id u4sm2132747qtw.86.2021.07.09.06.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 06:21:05 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1m1qRE-0075Wj-Qt; Fri, 09 Jul 2021 10:21:04 -0300
Date:   Fri, 9 Jul 2021 10:21:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, haakon.bugge@oracle.com, leon@kernel.org
Subject: Re: [PATCH v7 for-next 0/3] IB/core: Obtaining subnet_prefix from
 cache in
Message-ID: <20210709132104.GA1582827@ziepe.ca>
References: <20210630094615.808-1-anand.a.khoje@oracle.com>
 <309d7800-73a3-41c6-542f-cdcb5a72e969@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <309d7800-73a3-41c6-542f-cdcb5a72e969@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 06, 2021 at 12:55:48PM +0530, Anand Khoje wrote:
> On 6/30/2021 3:16 PM, Anand Khoje wrote:
> > This v7 of patch series is used to read the port_attribute subnet_prefix
> > from a valid cache entry instead of having to call
> > device->ops.query_gid() for Infiniband link-layer devices in
> > __ib_query_port().
> > 
> > In the event of a cache update, the value for subnet_prefix gets read
> > using device->ops.query_gid() in config_non_roce_gid_cache().
> > 
> > Anand Khoje (3):
> >    IB/core: Updating cache for subnet_prefix in
> >      config_non_roce_gid_cache()
> >    IB/core: Shifting initialization of device->cache_lock.
> >    IB/core: Read subnet_prefix in ib_query_port via cache.
> > v1 -> v2:
> >      -   Split the v1 patch in 3 patches as per Leon's suggestion.
> > 
> > v2 -> v3:
> >      -   Added changes as per Mark Zhang's suggestion of clearing
> >          flags in git_table_cleanup_one().
> > v3 -> v4:
> >      -   Removed the enum ib_port_data_flags and 8 byte flags from
> >          struct ib_port_data, and the set_bit()/clear_bit() API
> >          used to update this flag as that was not necessary.
> >          Done to keep the code simple.
> >      -   Added code to read subnet_prefix from updated GID cache in the
> >          event of cache update. Prior to this change, ib_cache_update
> >          was reading the value for subnet_prefix via ib_query_port(),
> >          due to this patch, we ended up reading a stale cached value of
> >          subnet_prefix.
> > v4 -> v5:
> >      -   Removed the code to reset cache_is_initialised bit from cleanup
> >          as per Leon's suggestion.
> >      -   Removed ib_cache_is_initialised() function.
> > 
> > v5 -> v6:
> >      -   Added changes as per Jason's suggestion of updating subnet_prefix
> >          in config_non_roce_gid_cache() and removing the flag
> >          cache_is_initialized in __ib_query_port().
> > 
> > v6 -> v7:
> >      -	Reordering the initialization of cache_lock, as the previous
> > 	version caused an access to uninitialized cache_lock.
> > 
> >   drivers/infiniband/core/cache.c  | 10 +++++-----
> >   drivers/infiniband/core/device.c | 10 ++++------
> >   2 files changed, 9 insertions(+), 11 deletions(-)
> > 
> 
> Hi,
> 
> This is just a reminder note requesting review for this patch-set.

You'll probably have to resend it after the merge window closed on
Monday, rebased on the new rc1

Jason
