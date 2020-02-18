Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C7916339A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 21:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgBRU6T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 15:58:19 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]:46609 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgBRU6T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 15:58:19 -0500
Received: by mail-qv1-f48.google.com with SMTP id y2so9784309qvu.13
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 12:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rHduJubXF26+Q0H39K1gulcRCZSEnF6YmRI6k7vB/n4=;
        b=BWytjXHmiZKuFyD25mew1FxYqcgLY9StrYh8KE+ic/fbB4uUkEodprAtcgizXucsSQ
         x0E+jsFOZjW64Ff14LMPDclxfdW9b+toGe1/ziMzsGBaqGe5kyaB2jTwuf5A3rdECoDu
         eQzXC7KHggDA26UbgNCVVSbAlYS6P5Qj+vgXR0W3dOAZ5onvFpGdGAQcnR+nL9WdmIdS
         W9rP90bBwfB77bhnajtduSOyIOCDC+MiQeSwoYdUyBB5DhfserdU0pXV9JP94phdIOwa
         RJA7ButSQ0geJGehmuUO4bloWSFwTSz+rUeTQbPNFTOqakH6PzCbmRlPvotSvi9Wz5QC
         dK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rHduJubXF26+Q0H39K1gulcRCZSEnF6YmRI6k7vB/n4=;
        b=sSOaqIkwbpA6qpJFnc2jUXNKR7kk4Eab/iH9XLyvSpkNqMBGKI+LkPEU3ehSzDQ4sm
         lUarEgIrK8F3aXUhoCVnQyMmSvL6S/EwGadsoyB2Ug7M75TVIg8V6KmE8flbkN3qQnIJ
         4SxdEhxKKtidrnlCRt+ind3otKt4XYYPUY/x/i0pQGMZ+aZjy8wWQuMFyLTS5BlPnkwb
         WXrzzWmCJG9zMeHXWpk3wMxA5tVw2UJcQnEU5hj1CqPCKupUee79yWrfk8Xd7QRNhK6k
         NX1dB/dHLvGnATkHktZ+BL7IKsoXAQ9FR00sbuN8xdYPy638TIwefuQ2go9p0A6GxjqP
         w/Ow==
X-Gm-Message-State: APjAAAX6klyQCj8ydg3tm/vAfOEpfs6rVeWIfPuzah3+x4hnfXrpOJ6j
        ZedeTueRe2pB6i8z63gaN/unwA==
X-Google-Smtp-Source: APXvYqz6oH6ldeY0BNfrG8ODg7+EdlV9h8nSbkuJKBMSIgchNMDrHgL+MiXZk9DJdq/yrQn3jfgkjw==
X-Received: by 2002:a05:6214:927:: with SMTP id dk7mr18664435qvb.200.1582059498471;
        Tue, 18 Feb 2020 12:58:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p8sm2387667qtn.71.2020.02.18.12.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 12:58:18 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j49wf-0008JF-JS; Tue, 18 Feb 2020 16:58:17 -0400
Date:   Tue, 18 Feb 2020 16:58:17 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrew Boyer <aboyer@pensando.io>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: May we create roce_ud_header_unpack()?
Message-ID: <20200218205817.GI31668@ziepe.ca>
References: <ABA12A9D-D4F4-405C-BEAA-BDBF33D50488@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ABA12A9D-D4F4-405C-BEAA-BDBF33D50488@pensando.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 03:53:45PM -0500, Andrew Boyer wrote:
> There is an ib_ud_header_unpack() in core/ud_header.c, but it has no consumers.
> 
> Would I be allowed to add a roce version alongside it?

Why? Personally I loath these accessors

I have been thinking of dropping all of them in favour of the stuff in
include/rdma/iba.h, which has really been a good improvement to the cm

> May I do that now or must it wait until a consumer is ready to be checked in?

New stuff always needs in-tree users.

You can send a patch to delete ib_ud_header_unpack() though

Jason
