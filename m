Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D3764AB7
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 18:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfGJQZJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 12:25:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39772 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfGJQZJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 12:25:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id m202so2093157oig.6;
        Wed, 10 Jul 2019 09:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QNTjswAD4uM6lwJpp3a5IZRy8P0GbK3SU3K/eRFRl+s=;
        b=EB5OQDrQgxmI+2NDm2wRjcB2ez957VTtkLgP4LZpyz8fmNQZ3lI7TcxeJpv0x9JYqx
         34g1eU2mp2X+6ewveKzEBGff027R/cjsN9rohSiXcuWdShd0RxBpRL1dHeJQRXgvM5pY
         qshmLCbPqsG0LaOuymGnYgTcKZ7Wq9hN1FK33uJ+4Y86yP8JhmlR1bSusOCKrfFon9lt
         Nh6SVPYMDUvNXRf7xu16lYCCdk215KAQ7KwFfD+BOsQHIt1YukPZaD9XHdNskyt05QCX
         1i4YyUH469vyjlcuP4Ej6rsG29y1007XXTIyk7ebqZxAzZdWQNAM4Csi6GyfaqgLEi/5
         rAfg==
X-Gm-Message-State: APjAAAVwqu6DwAsaFoKMVuQJ+4+FKmcD7FWIv3odkznYfF5o/Hx1ksuP
        wj6/QXqNUZBhNz2s/JGiGpg=
X-Google-Smtp-Source: APXvYqzDui6s4X6XX/UeXR1QICTo9om5IMBBEHfMS8u056C3/x9UBwArXHKarwvZdheFEa0SD0fssw==
X-Received: by 2002:aca:aa93:: with SMTP id t141mr3845999oie.128.1562775907929;
        Wed, 10 Jul 2019 09:25:07 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id q11sm871474oij.16.2019.07.10.09.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 09:25:07 -0700 (PDT)
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, axboe@kernel.dk,
        Christoph Hellwig <hch@infradead.org>, bvanassche@acm.org,
        dledford@redhat.com, Roman Pen <r.peniaev@gmail.com>,
        gregkh@linuxfoundation.org
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <a8f2f1d2-b5d9-92fc-40c8-090af0487723@grimberg.me>
 <20190710135519.GA4051@ziepe.ca>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c49bf227-5274-9d13-deba-a405c75d1358@grimberg.me>
Date:   Wed, 10 Jul 2019 09:25:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710135519.GA4051@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> Another question, from what I understand from the code, the client
>> always rdma_writes data on writes (with imm) from a remote pool of
>> server buffers dedicated to it. Essentially all writes are immediate (no
>> rdma reads ever). How is that different than using send wrs to a set of
>> pre-posted recv buffers (like all others are doing)? Is it faster?
> 
> RDMA WRITE only is generally a bit faster, and if you use a buffer
> pool in a smart way it is possible to get very good data packing.

There is no packing, its used exactly as send/recv, but with a remote
buffer pool (pool of 512K buffers) and the client selects one and rdma
write with imm to it.

> With
> SEND the number of recvq entries dictates how big the rx buffer can
> be, or you waste even more memory by using partial send buffers..

This is exactly how it used here.

> A scheme like this seems like a high performance idea, but on the
> other side, I have no idea how you could possibly manage invalidations
> efficiently with a shared RX buffer pool...

There are no invalidations, this remote server pool is registered once
and long lived with the session.

> The RXer has to push out an invalidation for the shared buffer pool
> MR, but we don't have protocols for partial MR invalidation.
> 
> Which is back to my earlier thought that the main reason this perfoms
> better is because it doesn't have synchronous MR invalidation.

This issue only exists on the client side. The server never
invalidates any of its buffers.

> Maybe this is fine, but it needs to be made very clear that it uses
> this insecure operating model to get higher performance..

I still do not understand why this should give any notice-able
performance advantage.
