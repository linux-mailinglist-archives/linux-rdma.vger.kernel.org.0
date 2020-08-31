Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB2257918
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 14:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHaMS1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 08:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHaMSY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 08:18:24 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92997C061573
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 05:18:23 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n10so1893126qtv.3
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 05:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HGgAJuLRjvAN/s+HTfR79JjeJGaCnb377oN4qW7ybZA=;
        b=icWVEEWccfxuw0VZCkGtYuStRcRaqysvZ5cBbvpMQIIDAQy4oEMBB47ufiHRb+j7Hv
         iTONLAFO2wCuOki3m5haxTXqdhzz27W84C2SjTkedOgsQMghaY9sfBoLARY6EmehcJxH
         +QEqpRn6lBE7nDbQFjuksaWcmo/k6SmwoAOSBrg5aISoollKQeoOyvbRQkM4HYTIojB9
         oqrLHmW2plp+fETDWMO2Z0VFcJYnU7fV0epPtUdCcmivlnnP6qnEagNgWUqJnxVndfvX
         InYtQQGR6QY74UXL5g13d296VsvJFWuFYXj26bK2/6JKSjw40HsJ62KKR7MI9JoIwwHa
         ks0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HGgAJuLRjvAN/s+HTfR79JjeJGaCnb377oN4qW7ybZA=;
        b=nqpWypAmNGNkyUsJAyVvKYNDyyRSW1nuF+I0zkdVOqMBk+BCSRn2E5COIU9K/u4VF3
         u9Izwve3j9g9so88euerLP5SmG9jD9p++/AvsSx1ISAN8fAWK1gf6sY/b61yKSg4n8v5
         s40cDv9QHoMXEeylee2a4dw0RZyH4hAhqfRTk5WTQ5IlvGgiBEfJP/agm30Wci1G/xu2
         pcg6ib+kNXpgzBzw0eSzezUnL3DZbWZemuoZS23dLbwneVCyi3HVoraQmvo3o6RkgCSH
         BDQ8QvKgcRHQcCAIE+cFUY2Ju6CUp9pEreNZ3QZKnmNaNsz1Fh9LLrdl4dPhqkij/PgG
         Igmg==
X-Gm-Message-State: AOAM531ToVwh5ZT9TqRf9wb6E3NR/JRMYlF59yXgrEv762iJuxYvM1b5
        uTDPwyLkwQ+yKj+RvQy8pxS5IUKU+jwQXA==
X-Google-Smtp-Source: ABdhPJxtEgNVYFDl8JH+4QW0uzKAfEWHs96+y4WYfJVd91DUHOLfCsPr8a0fJfBtjoKiGuwlkKjuNQ==
X-Received: by 2002:ac8:6141:: with SMTP id d1mr949985qtm.170.1598876300247;
        Mon, 31 Aug 2020 05:18:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l1sm9819338qtp.96.2020.08.31.05.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 05:18:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kCilO-002N0P-IE; Mon, 31 Aug 2020 09:18:18 -0300
Date:   Mon, 31 Aug 2020 09:18:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-rdma@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Stephen Rust <srust@blockbridge.com>,
        Doug Dumitru <doug@dumitru.com>
Subject: Re: [PATCH] IB/isert: fix unaligned immediate-data handling
Message-ID: <20200831121818.GZ24045@ziepe.ca>
References: <20200830103209.378141-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830103209.378141-1-sagi@grimberg.me>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 30, 2020 at 03:32:09AM -0700, Sagi Grimberg wrote:
> Currently we allocate rx buffers in a single contiguous buffers
> for headers (iser and iscsi) and data trailer. This means
> that most likely the data starting offset is aligned to 76
> bytes (size of both headers).
> 
> This worked fine for years, but at some point this broke.
> To fix this, we should avoid passing unaligned buffers for
> I/O.

That is a bit vauge - what suddenly broke it?

Jason
