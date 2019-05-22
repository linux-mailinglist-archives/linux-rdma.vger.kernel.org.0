Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6591026A00
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 20:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfEVSoW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 14:44:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36124 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfEVSoW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 14:44:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id a17so3669284qth.3
        for <linux-rdma@vger.kernel.org>; Wed, 22 May 2019 11:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xpMrAoFaNcl2llUfBdykf40aZwpmDfAE45nrVfwItA8=;
        b=C2ydTS3pc6J8DY1wzN0YmmO0wmZv/2uZz6mj9rqIPyxszoaQ1acSbstf38Xr200782
         J6sZjQoJ+fWBTL0CSw3WafX8y7Obd9mnC+gGcZqCJdB12Vykd1BEUQduBXjiUumKI99l
         hrIcqumQ22zghAXNCb2s9DIRl+GA2JdmxAFL0CGDcc3OVtxGodDTNLV+f5kqQuD+nzOm
         xGKfKg1JLwLVWq7J9wCsDCS6vf8qpCdGUpKPFVDoYOUH4zeEh9wDTk2+WZpHiKSzm+F1
         ccdWOtvWuwKOLY8JviLKyslGZYUTBvXhwONiKtRp5BOj291SVYgahxce3b1DAI8L2MW2
         4jGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xpMrAoFaNcl2llUfBdykf40aZwpmDfAE45nrVfwItA8=;
        b=YlG1I84/EoC+zl8/sN6u/fjxhN32lPcMbjCxGtZIzZHR7bu4tPXl9LkErHDlagF772
         s7X3mACera0Zc+EjO65ylCyR615+j9hVgZ5BCc6n/TRPYilBFeZ36XI8MiKOzVsGUsrV
         ImXZUFbPDHxWvdiIRa2M5JIdT08sPoc8abRXAq2uQd3yX0IhF3GkNwCZN03GlQ8gdNiv
         YsQWrelPmJFiT0sqFrgg7IXn/zjGHzN6gcaQloUm1ngxW448ZWMjRGpMfs0jXd+zRduP
         xZpQseW19vcjI3XkO1urnD/94FP65d2se0BKSpEje+T/zyjQ5brENAOnAlGUY88QL1Mz
         qj/w==
X-Gm-Message-State: APjAAAW6LHiZzAiREP9cZJaGMZTE2zVwwQ1/nD1TY5R2jHZQMsSbWfKw
        8BmcFbiKRyr1dkrO4ejt+1IM8g==
X-Google-Smtp-Source: APXvYqy/8ZWQYwMqmbmDk70PTvBvoyAq+LUDr6HT41BG7RpIHN4GIJGQ0k6ZXLIDwsdf0oDk5Olidw==
X-Received: by 2002:aed:258a:: with SMTP id x10mr76020537qtc.380.1558550661218;
        Wed, 22 May 2019 11:44:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id 76sm11215421qkf.20.2019.05.22.11.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 11:44:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTWDs-0005Ox-7l; Wed, 22 May 2019 15:44:20 -0300
Date:   Wed, 22 May 2019 15:44:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>, Moni Shoua <monis@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>, Huy Nguyen <huyn@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Avoid second synchronize_srcu in
 dereg_mr
Message-ID: <20190522184420.GA17682@ziepe.ca>
References: <20190520060923.7987-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520060923.7987-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 09:09:23AM +0300, Leon Romanovsky wrote:
> From: Huy Nguyen <huyn@mellanox.com>
> 
> In dereg_mr, ODP mkey is synced for page fault handler completion.
> Therefore, there is no need for another synchronize_srcu in
> destroy_mkey (called by dereg_mr->clean_mr).

Nope. Now that we have advise_mr userspace can trigger any mkey at all
to hit the prefetch handler and we must still use proper RCU
protection on the write side of the radix tree, otherwise userspace
can trigger an access after destroy situation.

Jason
