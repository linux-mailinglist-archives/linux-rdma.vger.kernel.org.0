Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3350042BD7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 18:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409437AbfFLQNW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 12:13:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43277 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409460AbfFLQNW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 12:13:22 -0400
Received: by mail-qt1-f195.google.com with SMTP id z24so5884311qtj.10
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5CI5dAUbbtRsnO5uk6nUcTR7hYc6exJ1mZNpf9Jsw5E=;
        b=cwV1KGtJTd5TlOhublIP1o1a4Xyb830RexAbXQFNJfrXGnVID/p1PibPHrJC+fua8U
         8NBRD1DcuuOuKrRDyTKNLoNUWW93tmDGOUuEFS8xxNjDJiRQib86DC3wQMpvTirMve08
         LkXZivIkwLdaY5Vj0rYPcum2YgW1CAHIQxy1bPbNW8QPgQiBxXdUnWbGotkgdXoJTxIH
         sna9Zq1sg8lSYOy4sKQNiZU9SObRZPtbSvn8FbuRUdl7tlrSFSYMd0THuIj9CzL13D6b
         5HVSXJ2togvZWJPFrf3VxkSNqGO7Hp/C/415o+LLl+ZS14jbBVX7KKtWLJLCmV69ZW/j
         ZWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5CI5dAUbbtRsnO5uk6nUcTR7hYc6exJ1mZNpf9Jsw5E=;
        b=rOaUZ6/zkkWbQAvm8hT2WL3IWs8GLwKTimC5R+wZZ8nddgH2XPPwiWJLxwMP8V65z4
         CFhy0QM+v30+c6X13I2wRzoIiJ83x2VJxsflCOXYh5n7X/7NeXzLRSHM4m10ik1BxVzc
         7Fa8YWjF+KXv4ZMhjvuHCjP0g7TpmpjVFhHuEv/IHyW2lCTVhtRcX0s9rEemIPCHgk4K
         cu04iM3eiGC4+doGdP49sj9OkiURXC1hy2R5T8lJnJSU9pAZiUU9OSqdVW4O0Udb6Y3Y
         XuTbUvNXCh/zhmJldjGyTTFZKwaY9l+WRcuMHssQ+zlgiGg9/qDvNRuKiMWNOjRDVEuc
         9mrA==
X-Gm-Message-State: APjAAAWuwXpjDuzVrWYQG+CJ1Uz6K5EWHrw4zI+qW1/W8SOfr60R++Qj
        ayLdJWenZy7H+jZGXwB/Oh7icw==
X-Google-Smtp-Source: APXvYqxBrORsPn41v6aJ9MPgJt+zsniQyCqjJijIL08x/AL9Yz0EaqvvQYU3MOfA4pkQios/OHudwg==
X-Received: by 2002:ac8:28bc:: with SMTP id i57mr39941671qti.288.1560356001022;
        Wed, 12 Jun 2019 09:13:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s44sm176275qtc.8.2019.06.12.09.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 09:13:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hb5sF-0004Ih-Lt; Wed, 12 Jun 2019 13:13:19 -0300
Date:   Wed, 12 Jun 2019 13:13:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Vladimir Sokolovsky <vlad@dev.mellanox.co.il>
Cc:     "ewg@lists.openfabrics.org" <ewg@lists.openfabrics.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [ANNOUNCE] OFED 4.17-1-rc2 release is available
Message-ID: <20190612161319.GJ3876@ziepe.ca>
References: <ca5463ac-150d-6313-9df2-db2fd60e7d54@dev.mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca5463ac-150d-6313-9df2-db2fd60e7d54@dev.mellanox.co.il>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 01:06:26AM +0300, Vladimir Sokolovsky wrote:
> Hi,
> OFED-4.17-1-rc2 is available at:
> http://openfabrics.org/downloads/OFED/ofed-4.17-1/OFED-4.17-1-rc2.tgz
> 
> Please report any issues in bugzilla
> https://bugs.openfabrics.org/ for OFED 4.17-1-rc2
> 
> Release notes:
> http://openfabrics.org/downloads/OFED/release_notes/OFED_4.17-1-rc2-release_notes
> 
> OFED-4.17-1-rc2 Main Changes from OFED-4.17-1-rc1
> 1. compat-rdma
> - Module.supported: Added new Mellanox kernel modules
> 
> 2. Updated packages
> - rdma-core v17.5
> - perftest-4.4-0.6.gba4bf6d
> - opensm-3.3.22

Uhm, this software is over a year old now.

In fact, this release is older than the software shiped in RHEL 7.7 and
maybe even RHEL 7.6...

It used to be that OFED contained new software, now it doesn't.

I really think OFA should stop producing this package, truely it has
lost its purpose.

Jason
