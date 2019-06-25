Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F22A554DFE
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2019 13:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfFYLxt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jun 2019 07:53:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36696 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbfFYLxt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jun 2019 07:53:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id p15so18014927qtl.3
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2019 04:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zkrv2aAGcMsPuin/HGy6ihg8vLH/kJtiKBk6sVUyC+s=;
        b=Kpkj+ABuR3WL17w0cUrZ9S38dvVDF3H+ihWsXMklg6cK7BimzGsFkZA3MRpZlOznS/
         W2f4369E1MqUak9PeJ9QxDFv26IwV78XxvOjcE7F6+QuY18M0f1KGhkn1NEBPy5O+owF
         tbr+IXtbDUkCNc7Cn7uGn/iPTwikmRAanjsdCN9OnC2ZHjeAA/f5vd+JJhEWOpc+ivdV
         kBnq/IfNJVfmd+jG2ELFYj2YS6oE5LZ8Jt5K0p22m19vU16O8DiwLiTXGpiTP5HuOUWK
         TGpmirGTPbBnmr/pZnSmvzG3D9DDVU1VoN3zwPwXNqZRLuZVx6QtCGXxp6RZnIcyYoDO
         HiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zkrv2aAGcMsPuin/HGy6ihg8vLH/kJtiKBk6sVUyC+s=;
        b=FcLH5WnzB6kH06JB8gvCob3Z6cNVyoy6H7bov0L2OLQ9pLBhi51loPklPizjd3sh+a
         wpSRPgxBqEkHKuOo2QOCmsLk/FPHPH96u2gaWXoS7y7oM4nSasl78FvI/pcX+I/hI8hh
         Fc3sO1ZQJfcufcR8MFAYiqivmZSQA7SaXPHh+Casi1yzzdxpGOvuSDxdJV8Xni1hT3oj
         /VPCLy3ZAnwOBEov394/pcf20r6vWETDkmk82g7ufJsfUDwLdsSrrgdulEDPX/Zu5GYH
         yhlSiDVGSUmqCS7qNYRJDXFQug4M3eBuXakhdcSiY/LppBZ5VtD/EQwCi5tCZT9eumQ/
         Wy9g==
X-Gm-Message-State: APjAAAUaj3peYXHliNZhBv3vONKOIK2RMT7Y2dWr3Yjn4vVhxYoe8Muc
        VVjvgfhJJ0bTO6xyuIZR/jzQ9xzADtaykQ==
X-Google-Smtp-Source: APXvYqzqu6B17zsu5AzAUEHxhOAkta6zISRZXJszmd/ZazN+3T5gqnZZNijRQxzXPYq2DtymH0I/yw==
X-Received: by 2002:a0c:bd1f:: with SMTP id m31mr62515179qvg.54.1561463628156;
        Tue, 25 Jun 2019 04:53:48 -0700 (PDT)
Received: from ziepe.ca (209-213-91-242.bos.ma.meganet.net. [209.213.91.242])
        by smtp.gmail.com with ESMTPSA id o71sm6604950qke.18.2019.06.25.04.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Jun 2019 04:53:47 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfk1D-0000yY-3c; Tue, 25 Jun 2019 08:53:47 -0300
Date:   Tue, 25 Jun 2019 08:53:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org, yuval.shaia@oracle.com
Subject: Re: [RFC rdma-core] verbs: add ibv_export_to_fd man page
Message-ID: <20190625115347.GA3711@ziepe.ca>
References: <20190625092113.19099-1-shamir.rabinovitch@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625092113.19099-1-shamir.rabinovitch@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 25, 2019 at 12:21:13PM +0300, Shamir Rabinovitch wrote:
> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>  libibverbs/man/ibv_export_to_fd.3 | 99 +++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 libibverbs/man/ibv_export_to_fd.3

all new man pages must be in markdown.

Jason
