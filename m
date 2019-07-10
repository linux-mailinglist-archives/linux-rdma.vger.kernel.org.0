Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA7D647A8
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 15:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfGJNzV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 09:55:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38017 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfGJNzV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 09:55:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id a27so1928343qkk.5
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2019 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i4ZDIYYMpB4xI6JA/ZkqGYa48YuxcupLaiYzrYpkWgE=;
        b=HnF7coioS3LLcQQ0tjurgS0gTfwhOIoV/gglwo4ytxPOY/5BXXEVZFc1lw8GMb5iIb
         xHmvHXcBj355CsMazSyAuzO3dO6OOSuUiMc5B/YVDL1605H4nBBQP563jXc/dxxbZKId
         xvYYJ5ZxXMQmZZHrFkfgC4/5x4zJnhFSMXPDms/xU1x1mdYjG4pQzq1zmVRWxLqDeB3p
         VyXjA4Oq/FDR4InAQqsbe9Od20VwgaH6r/I+FYCu7UjwhIVjcPlrts7MV9WDG774FJSd
         LO0/XtgTm6mBO3l2lnm0l/EGT1T5xNYvqOodPYu0sDJR+W7RxqbQlIuZ+wpPu1hEcNiZ
         IRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i4ZDIYYMpB4xI6JA/ZkqGYa48YuxcupLaiYzrYpkWgE=;
        b=hrnoi1tJ5QQ35YCZSY6IxtRODJIWjyW6pPTLofOgu57mTFh9RLeuK1Lopw5gar1gSu
         jHxHIjuBpJ1uqRESU2YSfVfXkUNZF3otdVwvgYv6LIu9Pc5wYkbU/CZVaAA+ks/3Kk+2
         1C7AqrCNCIzJoJY186eE4fYtVpkHoLJDBS2YRGNQfm1Nk1SLizUBXxrpM0FzkUOU3wyZ
         MOTFCjaQHtmFpJIksHSdAqwWir3J7XJ27fFdpU+GnUeMxHpsEeDijaPVuGh7XulY7Tpf
         aGLq2XjIuVAm2TDXE8e5O1P/7t3ytf0VUw1g958yW+tofGSu2klIp81/kHhD4/6quPRo
         hTyg==
X-Gm-Message-State: APjAAAWkyhi9y0ckAS/adpBgurdWd2OVmNi7YDx8ngHEd+bqH2oowAoY
        ExopFI3sIEIyt8PsJA73QgAjIbQxfScozg==
X-Google-Smtp-Source: APXvYqxEsUY67bXs0nm8Rdn9s1J51pbL4D8MfdK1/zrb6tDJPB6XV1iPys5n79RzmSFIQWvAUuFJMw==
X-Received: by 2002:a37:474b:: with SMTP id u72mr24149105qka.470.1562766920522;
        Wed, 10 Jul 2019 06:55:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c82sm1198530qkb.112.2019.07.10.06.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 06:55:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlD43-00016H-IJ; Wed, 10 Jul 2019 10:55:19 -0300
Date:   Wed, 10 Jul 2019 10:55:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, axboe@kernel.dk,
        Christoph Hellwig <hch@infradead.org>, bvanassche@acm.org,
        dledford@redhat.com, Roman Pen <r.peniaev@gmail.com>,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
Message-ID: <20190710135519.GA4051@ziepe.ca>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <a8f2f1d2-b5d9-92fc-40c8-090af0487723@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8f2f1d2-b5d9-92fc-40c8-090af0487723@grimberg.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 09, 2019 at 12:45:57PM -0700, Sagi Grimberg wrote:

> Another question, from what I understand from the code, the client
> always rdma_writes data on writes (with imm) from a remote pool of
> server buffers dedicated to it. Essentially all writes are immediate (no
> rdma reads ever). How is that different than using send wrs to a set of
> pre-posted recv buffers (like all others are doing)? Is it faster?

RDMA WRITE only is generally a bit faster, and if you use a buffer
pool in a smart way it is possible to get very good data packing. With
SEND the number of recvq entries dictates how big the rx buffer can
be, or you waste even more memory by using partial send buffers..

A scheme like this seems like a high performance idea, but on the
other side, I have no idea how you could possibly manage invalidations
efficiently with a shared RX buffer pool...

The RXer has to push out an invalidation for the shared buffer pool
MR, but we don't have protocols for partial MR invalidation.

Which is back to my earlier thought that the main reason this perfoms
better is because it doesn't have synchronous MR invalidation.

Maybe this is fine, but it needs to be made very clear that it uses
this insecure operating model to get higher performance..

Jason
