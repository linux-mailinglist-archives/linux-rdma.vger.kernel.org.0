Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 163AF42AD2
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 17:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbfFLPVS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 11:21:18 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:44916 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbfFLPVS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 11:21:18 -0400
Received: by mail-qt1-f181.google.com with SMTP id x47so18882419qtk.11
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=br3Dgq+VTX+7z5eFvu3q2TRFjCt3/1Il29EPHrTuO8g=;
        b=QlofXmiLoP7WGIY03maGIckh1VCqY1kMp1bwo+b3XW5ydNd5ZpDFQPSsHYQAk92UyS
         l1CYcVyMJHQNemtnLXCdqGE7EBd4GxHCbaCZwOVdxgYapcmiDfuQ9bZtw95MQphiD5Rm
         qZc46FOQKPBvdrprQy3MrJNt14NYUISsY1stYMrfck9cWINEzCTIosfeewuEv9zVo72F
         xuM7PsCnpfx57MSOOpK/nE17HFfQiDGGAX4qtNJiDXxMmft/4JJGWtSsKTCg3crKw+uF
         rdrNb7kwJ6VoTZhcG12XBBp3niWuMspa6eZm+8Mm4tNvn6bWvnvGNXyWaOxVxgWeGp1K
         tigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=br3Dgq+VTX+7z5eFvu3q2TRFjCt3/1Il29EPHrTuO8g=;
        b=cUx4CHN2rVFOBZVTWF5nm2b0O7GjqCwePO1PtwlaS54lzXZvG+FbXytyqUjlq0luIZ
         CBwu2lRgkT/efd8XFFht0GPi8lGnvB+J0SfqqYjDS/Fe4WB14GQmNrvV1GzjGBLFyeXv
         5OKR5KN+UJs/pkZqdMLfGg2OnwQT8kxH+QRMOCWF85XFm4NdLSJp1z7NylpyGG7+ouOu
         ZAHF5PxDSZX1NZRn3CyfGQB89uqdG01zDobOmbSeuLMMUaD/nNBeUyXqz1tdT2PDVtNP
         b0iy8VnnsVLbL+G9V4+DKx7gl/egCNoPLErhgd74VHqF7IWUoKDV9w7HGSQGq3sd9dSN
         uO1A==
X-Gm-Message-State: APjAAAXlj11mG6H9K3SubRIvXCxrIjsn9OOeNHn4y6S2YbeweduleV7C
        1nHbIWuRa66mh3wOc6dH8e/EgQ==
X-Google-Smtp-Source: APXvYqwelt5fhP5NEJQNaHxeykfWvTpB6pPlRIYk22RHUewHclw8mGnh2gUTjzamb+Yki4P5bnOGKQ==
X-Received: by 2002:ac8:8dd:: with SMTP id y29mr5929563qth.304.1560352877077;
        Wed, 12 Jun 2019 08:21:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h185sm9038315qkd.11.2019.06.12.08.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 08:21:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hb53s-0003vS-78; Wed, 12 Jun 2019 12:21:16 -0300
Date:   Wed, 12 Jun 2019 12:21:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>, linux-rdma@vger.kernel.org
Subject: Re: receive side CRC computation in siw.
Message-ID: <20190612152116.GI3876@ziepe.ca>
References: <OFBD80408B.8C25683E-ON00258416.0047A63B-00258416.00495B83@notes.na.collabserv.com>
 <a84cd017-fe4c-fecf-6414-db6a3f98c09c@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a84cd017-fe4c-fecf-6414-db6a3f98c09c@talpey.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 11, 2019 at 11:11:08AM -0400, Tom Talpey wrote:
> On 6/11/2019 9:21 AM, Bernard Metzler wrote:
> > Hi all,
> > 
> > If enabled for siw, during receive operation, a crc32c over
> > header and data is being generated and checked. So far, siw
> > was generating that CRC from the content of the just written
> > target buffer. What kept me busy last weekend were spurious
> > CRC errors, if running qperf. I finally found the application
> > is constantly writing the target buffer while data are placed
> > concurrently, which sometimes races with the CRC computation
> > for that buffer, and yields a broken CRC.
> 
> Well, that's a clear bug in the application, assuming siw has
> not yet delivered a send completion for the operation using
> the buffer. This is a basic Verbs API contract.

May be so, but a kernel driver must not make any assumptions about the
content of memory controlled by user. So it is clearly wrong to write
data to a user buffer and then read it again to compute a CRC.

All the applications touching buffers without waiting for a completion
are relying on some extended behavior outside the specification, but
they cannot cause the kernel to malfunction and report bogus data
integrity errors.

Jason
