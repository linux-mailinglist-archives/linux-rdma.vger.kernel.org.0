Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA8D828AE5
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 21:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbfEWTtq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 15:49:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41367 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387903AbfEWTKk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 15:10:40 -0400
Received: by mail-qk1-f194.google.com with SMTP id m18so4499278qki.8
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 12:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ghkOAlfJKu4tMoQKys/1EHqRxAiTe4oOiX6IKeo2jBc=;
        b=CStJflZDRmQsaJAW4LdEdIgLN08TdeV6wfXiFQVetGvvLwGR78wlPTdu3Y1rnSUP2z
         PAdqF6JW8oZyONTN6ZJAK/owBJKO5ZdBZN4letqRLItdPhUvAPD44UBf4mdPEuvvfl9m
         jQu+i+rHGzgN5b9nt83NlNqp9sm4osT9bZ2JSg+rcNZfu24HiPbA/IvSv8NNAlI3gpny
         UdpW+yXapIINK+p+9EMp7a3udWtaLUtEXQgU9RBmoU47E9VDVODLv2J4/RKajH+FwK//
         Luh2IQjW7wfZctKpOvPkEJ1SafhIIKBlPNhORqpfr9ACctHprx1sexCgWxJrclZRsgF+
         +1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ghkOAlfJKu4tMoQKys/1EHqRxAiTe4oOiX6IKeo2jBc=;
        b=LgtL/MvI56ko7Yz9SEkWMs4loTTglVs1SJiEL3IiVZbyyO1Y8ERL21ATnLKrxzOi6E
         px0I6CnUiO/KhqN4am/+KsEqeA319WnRUm7w4UDuennuCb5p/61BzTrHBRjgZJXnUnSx
         pE73wW7krRKp0knxWhs7HSzfpr5NeBLWBzKlEqgkTsq0rGTc8xAj5BM+C9NZPQHsmAu/
         1pqXTWydVWqjhjBTTQ4/KwWZz/LwC0Ti/BXO7ajdbW9otZHBncZzc9YDCt4WDRxCK/nZ
         39KbB2Cf2ALgtjfY793VXVrtKQ9hVT1oHMEIFiMJZyRsh6RiSVkbX2BKvnb0xNhcJlX+
         6WsA==
X-Gm-Message-State: APjAAAUhQI70gpqZkc5sX7DNfFtexsPMB7FihM6RDRZELItN41xkOafy
        OtYWBPF60RIFF2hnbxWx+ATBRQ==
X-Google-Smtp-Source: APXvYqy/wYrbpFnHYbhiKL987tF9J8OP2PBwu2icZP7tr48Sjo+bfXBS/A5sIwuRti5XspgHsz+C5A==
X-Received: by 2002:a37:a1d0:: with SMTP id k199mr76164698qke.116.1558638640113;
        Thu, 23 May 2019 12:10:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id f33sm122704qtf.64.2019.05.23.12.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 12:10:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTt6t-0000gd-0V; Thu, 23 May 2019 16:10:39 -0300
Date:   Thu, 23 May 2019 16:10:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190523191038.GG12159@ziepe.ca>
References: <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
 <20190522235737.GD15389@ziepe.ca>
 <20190523150432.GA5104@redhat.com>
 <20190523154149.GB12159@ziepe.ca>
 <20190523155207.GC5104@redhat.com>
 <20190523163429.GC12159@ziepe.ca>
 <20190523173302.GD5104@redhat.com>
 <20190523175546.GE12159@ziepe.ca>
 <20190523182458.GA3571@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523182458.GA3571@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Thu, May 23, 2019 at 02:24:58PM -0400, Jerome Glisse wrote:
> I can not take mmap_sem in range_register, the READ_ONCE is fine and
> they are no race as we do take a reference on the hmm struct thus

Of course there are use after free races with a READ_ONCE scheme, I
shouldn't have to explain this.

If you cannot take the read mmap sem (why not?), then please use my
version and push the update to the driver through -mm..

Jason
