Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D62687A814
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 14:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfG3MTL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 08:19:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43988 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfG3MTL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jul 2019 08:19:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so18427342qto.10
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jul 2019 05:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oo83r67k+J65BgUsPoNqo+u2Vox/G0/Ts5zYh5IoGSQ=;
        b=iK/uhchsqlYoWqDmi+YXU35Boim5Z5cIp8BGsgeMocSvrcUvr3wrK3CCHFkatt2yvm
         75eyepo0sfA9CXrSOFsaeuP74HYD/h3X2ds+NFvzdjZ8stNawZHZ62B95iK6LJ4xNAvL
         gKmnmywZo/IwGctS/kGKVpcQhYt33YTRn9eJILrIrUyyo+mtxeVWIBHZQ+kHYSnscx8W
         GD7xJ3aRPxx7F22SUHEXteo+GHlEmCf4rtWMJLejSqL7WFaVrRmqPMU0/j/zkTiVVs5E
         sSzZHh9G1ptvZaA6tp8ucwvJTDDZsFJa8377g0VXR6kPtjpmjgt4+E1tJyc+pxVG/ujc
         XEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oo83r67k+J65BgUsPoNqo+u2Vox/G0/Ts5zYh5IoGSQ=;
        b=cKRsrqe1hXlAdl57nmkhp4HLtf6hLQarp80IHkbtuTYB5xACEbriJ7x0TNW5fXWtjl
         9TT40Ghxg9rwRv2xxVTMJ4RaZWlV/nNzMUYEqsGP3ukkMdIvp2Elv5KBARI9r0QYPRDJ
         fWZ2Yj5HE+BMyGGuG0DiWiugpgBCxtZ9Cx1+CBOqHYcMz79LCOo0iyomiW1TVFalWoBP
         USvJOVW+thl3NN+nU4/QJkVvofrfCGhNvWPcg/Mg6eX2l8ChJpMQNSQzKSnW4tX205BS
         hs/AWexH16WUVMd/0bpp8/bW3fMkFCDKAxD5fbJTa3QWBNtqwv+FeD03F7GmiuvNhRTj
         QLQA==
X-Gm-Message-State: APjAAAUrH/bVhhQHggrI1ZmI3/L3AkVHyzpPOjc0kZcrpSHULCWxSF/U
        FxYCFnzBgazSE12n0A3JTyc7PA==
X-Google-Smtp-Source: APXvYqwUrmGgRP+16lfBiZVj6UGisP6lLmIMyyHIVWO8GM7j8ZE1HLdropQNX/zQNW4CWQOw8fSMsA==
X-Received: by 2002:a0c:81e2:: with SMTP id 31mr83499567qve.56.1564489150214;
        Tue, 30 Jul 2019 05:19:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p23sm25719155qkm.55.2019.07.30.05.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jul 2019 05:19:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hsR5x-0006HX-BD; Tue, 30 Jul 2019 09:19:09 -0300
Date:   Tue, 30 Jul 2019 09:19:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] RDMA/restrack: Track driver QP types in resource
 tracker
Message-ID: <20190730121909.GB13921@ziepe.ca>
References: <20190730110137.37826-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730110137.37826-1-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 30, 2019 at 02:01:37PM +0300, Gal Pressman wrote:
> The check for QP type different than XRC has wrongly excluded driver QP
> types from the resource tracker.

-rc commit messages need to describe the problem this is fixing from
the users perspective.

Jason
