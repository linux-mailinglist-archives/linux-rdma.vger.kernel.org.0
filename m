Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E223C3802
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 16:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389278AbfJAOr1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 10:47:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33613 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389216AbfJAOr1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 10:47:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id x134so11508780qkb.0
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=77UPRizKzszHVGLYJvHjHkCV0Pc/l5BZHHrokuA5NqA=;
        b=G0NUZ6XXwsiJC8F8a7pAXhxYpL1tU4lIR1R3eCDwnVcEriNUarc4YlEUei/pRAcmuZ
         HieXZqfexD3FaDK+b/Z7YuY/6TYXixEvFvpK7eqPz6uS/QIvnEIKQ+c5QeRicYK5M5S1
         S54nnHVnbP/3D6LiBNJIP4KYWAxv7UGBsnumD0/J3Nd0WqluEO/6ICEzY4uenEbJ1kSx
         Wk9UZVxI8eD7flvDyYtYakA7K9U1NqJMl0/0aXEmqwgll9vrJpEcCJ9yiu8X1u7NV5Hz
         TrtJ1WFfohW+Kqdxq4uCtBMqBTKxBfsr9xo4c9oeTLrls5gcPFBe2vRGgezHAfYsnt3i
         QQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=77UPRizKzszHVGLYJvHjHkCV0Pc/l5BZHHrokuA5NqA=;
        b=AUgjUqiHEGaoOvtTyFTRxLmkNaLwSxWYpjjFVfoRQYCLGbSOMsGpniIh71OYWrv5qi
         Va2p8fq34yFqbyzL+9faldE0nOV3oTtGLrKAj9RmHInQvx3orycgCXM8abvmN4BXtZec
         Y1M5cPPvJKTwaZH5yN3xi8ERf6sLjFx4MrFr/HwMevnA5AeLiG0sQoH2sMYBwzpb/EeC
         563nsVRL7ItIDBSuO33q7q31zatw/Ti+cYvH/ovy2uTMZ9tDC/M4gqfm7D02PDqd5pSq
         48t8V/OyuR8WVlWj1BYpujS2QTG4kz6n8aynpxJPxtz76BG7L3ARlNwPIa1wfRdQ1nR0
         pqpg==
X-Gm-Message-State: APjAAAViOPZkgTmLMxWMF97irssEtYtmEQzHDg8kBdjY7dlEkd76omiX
        XZbUs3sdrQkjlXds7uRL9r3Z5K7DByU=
X-Google-Smtp-Source: APXvYqzttCI1y4IErEO+O5Rng8Yizj26UdzrYcuOmYk5MaZFNPdju7lHmB1x4sD4j2G0cU1ut77ozg==
X-Received: by 2002:a05:620a:55c:: with SMTP id o28mr5943226qko.13.1569941246339;
        Tue, 01 Oct 2019 07:47:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id w85sm7759640qkb.57.2019.10.01.07.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 07:47:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFJQz-0003QG-Hp; Tue, 01 Oct 2019 11:47:25 -0300
Date:   Tue, 1 Oct 2019 11:47:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        nirranjan@chelsio.com
Subject: Re: [PATCH for-rc] iw_cxgb4: fix ECN check on the passive accept
Message-ID: <20191001144725.GA13087@ziepe.ca>
References: <20190930074048.19995-1-bharat@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930074048.19995-1-bharat@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 30, 2019 at 01:10:48PM +0530, Potnuri Bharat Teja wrote:
> pass_accept_req() is using the same skb for handling accept request and
> sending accept reply to HW. Here req and rpl structures are pointing to
> same skb->data which is over written by INIT_TP_WR() and leads to
> accessing corrupt req fields in accept_cr() while checking for ECN flags.
> Reordered code in accept_cr() to fetch correct req fields.
> 
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>

This needs a fixes line

Jason
