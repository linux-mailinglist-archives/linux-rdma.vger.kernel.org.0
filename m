Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962793B6733
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jun 2021 19:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhF1RF0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 13:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhF1RF0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Jun 2021 13:05:26 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2F1C061574
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 10:03:00 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id j184so28159221qkd.6
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l2biafiss9BBHd7k9NtviXn2L7h+FuR+Y1QggEGLz5U=;
        b=YTFj++LWjpfANHTFDoiuzF33MH0SygYF4hrrKMUCi12buIdK2VGAETtTuQff03Wisw
         fAbMynLG93xc6TZUSxcE3xbR8lFGaGp1/TibTimGKty/4YMopXSIXYUwbY/CmuWwt0Hm
         iTFiNIobAmeXXbDNydZB7bUOMK7fkiPHoTxbBhyEjKE5be23kfs04HcvhLc9V79ZLhxz
         ttnYH3f/SRTHhbSDb3+4xYwhJm6rWez1GkV6Te2GkxzYtyoQUCFaDSf9Kj1Vgmmfqdev
         MbNUq6krZ9swoy61dO3ynpPfPLvrgqCA4g8C57CjEdC4ee2tA4C5+N5/3WW4kI40Znum
         ag9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l2biafiss9BBHd7k9NtviXn2L7h+FuR+Y1QggEGLz5U=;
        b=m5SG3anc/qZ0Js8TxDyYREDXqg3zv6hj+dbdT6n1RpZIoHsGXLUlsvAhRYFRWJxes9
         VSXzpzboZVWPB7clS0p8OmI9osMMipvkFH32i6pfsIJAuCSberT2b8fa2zj38wMJAeFB
         MjPIQSFqbovEj2h86bxv/b9oNwO+G5hFFc86C6Il5n3jzw+ytDD7A51GQ/lh5OSmehBe
         xdfoR6FP9FbEYq5B8knQDfTomWra3ydiGOiClqYiVPqJB3SgmhMD++BJbhjriZzVHhXi
         7AyuJpczP3XEqtsceUMsH+XEyvtdQdAXr3qdgSqDTaUwyd7cj9ZJjmgnVoLFzRxTqdWA
         VCag==
X-Gm-Message-State: AOAM533Axlu7yF5j7Z07iglm6442c1ahTcapM9UV8hkzffLGKVSBnoxw
        Lu6uLsq2MDZQ826gg/wyrNRKow==
X-Google-Smtp-Source: ABdhPJxFNUT87DB1AwYwdXjC4/VjS4Cc78YfiZqIK07/DC1ZxKM7Bgify7U+VhCFarhy7jSWX/rNxA==
X-Received: by 2002:a05:620a:5ed:: with SMTP id z13mr8918649qkg.422.1624899779716;
        Mon, 28 Jun 2021 10:02:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id p64sm4245461qka.114.2021.06.28.10.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 10:02:58 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lxuew-000gKn-37; Mon, 28 Jun 2021 14:02:58 -0300
Date:   Mon, 28 Jun 2021 14:02:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH v6 for-next 0/2] IB/core: Obtaining subnet_prefix from
 cache in
Message-ID: <20210628170258.GD4604@ziepe.ca>
References: <20210627064753.1012-1-anand.a.khoje@oracle.com>
 <YNhThN0tiA5v5Q4v@unreal>
 <19EE4BE9-063D-4820-A1F7-5E1D0016A51D@oracle.com>
 <YNhiC45Si+XHP87i@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNhiC45Si+XHP87i@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 27, 2021 at 02:33:31PM +0300, Leon Romanovsky wrote:
> On Sun, Jun 27, 2021 at 10:40:43AM +0000, Haakon Bugge wrote:
> > 
> > 
> > > On 27 Jun 2021, at 12:31, Leon Romanovsky <leon@kernel.org> wrote:
> > > 
> > > On Sun, Jun 27, 2021 at 12:17:51PM +0530, Anand Khoje wrote:
> > >> This v6 patch series is used to read the port_attribute subnet_prefix
> > >> from a valid cache entry instead of having to call
> > >> device->ops.query_gid() for Infiniband link-layer devices in
> > >> __ib_query_port().
> > >> 
> > >> In the event of a cache update, the value for subnet_prefix gets read
> > >> using device->ops.query_gid() in config_non_roce_gid_cache().
> > >> 
> > >> Anand Khoje (2):
> > >>  IB/core: Updating cache for subnet_prefix in
> > >>    config_non_roce_gid_cache()
> > >>  IB/core: Read subnet_prefix in ib_query_port via cache.
> > > 
> > > This series breaks mlx4/mlx5. You forgot to call to lock_init or
> > > something like that.
> > 
> > Thanks for catching!
> > 
> > Sure, in ib_register_device(), setup_device() (which ends up calling __ib_query_port()) is called before ib_cache_setup_one(). Can these two calls have their order swapped?
> 
> I don't think so, if I didn't miss anything, we are relying in gid_table_setup_one()
> on some properties from setup_device().

Just reorder things enough so that the cache_lock is setup earlier, it
has no business being in cache_setup_one anyhow.

Jason
