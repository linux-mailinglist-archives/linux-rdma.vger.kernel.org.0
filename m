Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB662254593
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 15:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgH0NAf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 09:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgH0NA0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 09:00:26 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34532C061232
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 06:00:25 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n18so4429791qtw.0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 06:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vWEIxr1yyDaXyO/h8L1exQZ5P2hNn96DwFYGGcqMcI0=;
        b=cU/J7hH0qgLxkl7sMjwL7YO8RR/nLz+Agy4owvpBRLz35u3Fr0USS2Sap5hr+ml5LS
         i35URqkvmzKa6CU2ksvny/ogz1LZLsG2C9XG6GDM5Y7dft8qrQJ9ePZOjBRlUJYRxnPW
         qeqVyh5MR6IC91nebW1b5cLd9kKm2JSizLxV6mS6dBHZ6LpIYSjk66os2wei2+fRx4tf
         JVyxwBXmxAbx6yBbVFRr4yi04DiLyhCfzaTgzUpJF+ZXSxjiqJbwA9mYZc450prEOLgc
         U2d1L3H1cp/OVO2z5W7ZTxCVcN3QelV2zd91rsfgkFh9CoHdK9DyMiL90dVLvktpYO3X
         Q2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vWEIxr1yyDaXyO/h8L1exQZ5P2hNn96DwFYGGcqMcI0=;
        b=LD/W/6PIdLTjeosgEuDpazGBtOeVaEzqnE69wxRjp/eeZx0LqhDR4inNUJ/rVHWKMz
         9k69TavOUoYPiznxDexW5ZNhmQYgMba1IuGpR0bSL6k5qMjk/azTV7TiMKMHI0j4EVbQ
         r41E8HTimjlamGp1xbE/9NGda3uW7vKYSlLvxK1g5mx8MyalhKscIxpCqg93TClRnDX1
         jFog2AffNQPsDMyyQZWrsNUAFI8WBK8ieg/Xdoq2KPwYykKXiEha6VsPRWTPMBoOiZ8Y
         6nLb6wTFtt3BK2NFtO23La2iIch0carFnIaeOQMNeIWHXLAHGxv2bPgpl7VIBC/0sJp2
         mhtg==
X-Gm-Message-State: AOAM5314mSZcgz/hUY18M1Lbtk2ZorD1H3bgb1iMj0/MA1No42D2YCep
        UhpnZUH+1mdOeD1mkRjGrljt+A==
X-Google-Smtp-Source: ABdhPJyP0TWivawcDZLwmWe4xj46gozl2tGqmnve3nw2pFU6KSe6gOEOBPxxqHdMRJMTvndmFoOhOg==
X-Received: by 2002:aed:2041:: with SMTP id 59mr19205050qta.225.1598533224488;
        Thu, 27 Aug 2020 06:00:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id u41sm1755264qth.42.2020.08.27.06.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 06:00:23 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBHVv-00GtIo-7z; Thu, 27 Aug 2020 10:00:23 -0300
Date:   Thu, 27 Aug 2020 10:00:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH v3 17/17] rdma_rxe: minor cleanups
Message-ID: <20200827130023.GR24045@ziepe.ca>
References: <20200820224638.3212-1-rpearson@hpe.com>
 <20200820224638.3212-18-rpearson@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820224638.3212-18-rpearson@hpe.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 20, 2020 at 05:46:38PM -0500, Bob Pearson wrote:
> Added vendor_part_id
> Fixed bug in rxe_resp.c at RKEY_VIOLATION: failed to ack bad rkeys
> Fixed failure to init mr in rxe_resp.c at check_rkey
> Fixed failure to allow invalidation of invalid MWs

Split this up as appropriate and send it independently if your MW
series, same with the SPDX, etc

Jason
