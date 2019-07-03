Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D8B5ED60
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 22:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfGCUSn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 16:18:43 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45058 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGCUSn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 16:18:43 -0400
Received: by mail-qk1-f194.google.com with SMTP id s22so3851720qkj.12
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jul 2019 13:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bkikyEsPp/F/lyGTUMYkhINszh6ssHACtXvD7E7R8r0=;
        b=iMtFvdN/HLQUVN2/izzHHh77KwximeFqU/BT9eVWVDqXcyM4ZpubaPk0Q4FlF6iGxa
         s3buYLskL9gE8ojKQPoHgqWptw9wAWoMp8SLIvXqzzcAmEb9jpEt/nr8808MmvfFFegp
         qQ83BN34LORm1e8VlXqQWnK+3oxp5ovi96oTMEiJ9+tEuVCSUNx+mVgFGBYpZ6kqrpie
         5dfkEvgV7kqdUAAG22YYJv0Lcc2Dynyr1HN5HNM4POjceXTFtq+32q+xNV0N/2ogSugS
         BzSKaeGxE6Jkd37bsz0uB/NfwbTGwmzpfF4QfzaRpmQjSNvYSynnJ7RrSp24Ez6TiTTq
         mjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bkikyEsPp/F/lyGTUMYkhINszh6ssHACtXvD7E7R8r0=;
        b=iOCsw2wIuS/sDvm0hAYooQf/x2GHCLthhP6kATeHIT1bZ4zSd83J1hHWYqAoYnegz0
         mGTpmXSfpTtiGQ/RUELvFfcHUUSzm6XMSk3u91DdY03Jk2Dl6RXclYD7jcZokbJIHx1g
         QWY3WhBqgP5E/rOtV1CDoOUR7WqT5oY1+KlZTw0idY6DAm8mQVLsetf0vAym4NVYGB1K
         4A27pjCAqxUOet2Ao6wHAFKOeeXJxlm+4fGBYenjguUEOKn4mLDLlnCfOKSC3fwlhtW+
         xcO4GbFzRXx3e4s933+T4i54S1e2audls8APo04Ercl61/kfR8FnDRrBIejJ2vZXJwDw
         i/7w==
X-Gm-Message-State: APjAAAWOO/AImRACj046kLnLUB57w8/eH6sKYjHVsCEWOAckE+Zo1syR
        DQ7aPkRmKV0jl13Wkb3HEfWVGg==
X-Google-Smtp-Source: APXvYqx5L3IJiCJXtOOcMAtf3QcBzfoutHFawXK/gtVmcoc5gUhnOz7mQExGxwqmiHHoDosSMczpyQ==
X-Received: by 2002:a37:9cc2:: with SMTP id f185mr1989999qke.172.1562185121606;
        Wed, 03 Jul 2019 13:18:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y6sm1277932qki.67.2019.07.03.13.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 13:18:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hiliC-0007Gr-Nm; Wed, 03 Jul 2019 17:18:40 -0300
Date:   Wed, 3 Jul 2019 17:18:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 10/13] IB/mlx5: Enable subscription for
 device events over DEVX
Message-ID: <20190703201840.GA27910@ziepe.ca>
References: <20190630162334.22135-1-leon@kernel.org>
 <20190630162334.22135-11-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630162334.22135-11-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 30, 2019 at 07:23:31PM +0300, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@mellanox.com>
> 
> Enable subscription for device events over DEVX.
> 
> Each subscription is added to the two level XA data structure according
> to its event number and the DEVX object information in case was given
> with the given target fd.
> 
> Those events will be reported over the given fd once will occur.
> Downstream patches will mange the dispatching to any subscription.

BTW Matt,

Here is another vote for a 64 bit indexing xarray in the kernel.. Any
further thought on doing that?

Jason
