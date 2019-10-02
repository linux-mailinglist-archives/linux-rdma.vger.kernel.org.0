Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251D8C8AAB
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfJBOOy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 10:14:54 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35773 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfJBOOx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Oct 2019 10:14:53 -0400
Received: by mail-qk1-f195.google.com with SMTP id w2so15133024qkf.2
        for <linux-rdma@vger.kernel.org>; Wed, 02 Oct 2019 07:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=od02w21zGmcxSDiiBE3+RmwgoeYQ8ap+pXkewByuoTg=;
        b=CR2EqhPmJQEY+FDmCWoyL+Z1Nv0qFAmssGcJtCisgQVHpLBzXGvbYaKRk99mOI5BdL
         K3AqQjR4wT9c5N1tK0MCGnbxzszpAoehlXwi/J7ZwQ3AoU4ErLfvB8jGM4CMr1Xcg8G1
         g+G5w/2TThrpfeXD9hMFvF/tvGPlMIkEXc/h/EfWWD3AMT641Z2QRl6rjoumvhy7WszG
         H0wwJIZdLBIEaExQXnqvN7s6y/VJLmOfqiLe8i/rdnosGOfIH9g+13Xdirt7nm2i2o8A
         u6gEPj82fcB6jrSt+P+Ov8+gBksX9R7LzEKXBIqY1CE96yf/Lp9/N6WpXU4mGZnCuPZe
         R15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=od02w21zGmcxSDiiBE3+RmwgoeYQ8ap+pXkewByuoTg=;
        b=GYImbmtczjh+T+DDYcpu+P3lDPeTpuMSqT4ytrSzB1sxnqTbnaaHsuaXrHdXgjWzAW
         TiFOerb14wdSYvMih7iCI2ToaWHqA6J28K3goyZdrX9zNmPHjLCkHTbhx+MlKI/zYSN4
         W27CpcKlQqisAKIx6jv3iUz4iq27Pjew+KArA5niiFXTSNLHYE7ksWbs1wNuFEfTC8YO
         Tg22sGzaA3TfMuESgg3qVyt0ZbsloTdWfkCZOOpDeQtl2wdJFKCf6IQs2SiEYQE7aVP/
         kWoRTT2psQKyMmu6gTXIw5ebluApntJT8G13lRFelhzLKZXovr/haxGJflXbKNoOgVaP
         5LnQ==
X-Gm-Message-State: APjAAAUprNiLLCzjGg/1FUSNTFUGT03j+xR9Z6uN3NvyCyo74+ccEPkF
        2txN2v7gFiJL9LVaiQiXCztr6Q==
X-Google-Smtp-Source: APXvYqwUty+RaBC8aTJNcMOpwLEuChkaP5ZJnwZOhrajMnCfum3079bN6VyzF7QNJAuxbX2g4S46XA==
X-Received: by 2002:a37:65c7:: with SMTP id z190mr3829415qkb.483.1570025692905;
        Wed, 02 Oct 2019 07:14:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id j2sm9632109qki.15.2019.10.02.07.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 07:14:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFfP1-0006eY-OK; Wed, 02 Oct 2019 11:14:51 -0300
Date:   Wed, 2 Oct 2019 11:14:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH 09/15] RDMA/srpt: Fix handling of SR-IOV and iWARP ports
Message-ID: <20191002141451.GA17152@ziepe.ca>
References: <20190930231707.48259-1-bvanassche@acm.org>
 <20190930231707.48259-10-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930231707.48259-10-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 30, 2019 at 04:17:01PM -0700, Bart Van Assche wrote:
> Management datagrams (MADs) are not supported by SR-IOV VFs nor by
> iWARP

Really? This seems surprising to me..

Jason
