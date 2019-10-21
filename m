Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A3DDEE68
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 15:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfJUNxd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 21 Oct 2019 09:53:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40903 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbfJUNxc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 09:53:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so8482187pfb.7
        for <linux-rdma@vger.kernel.org>; Mon, 21 Oct 2019 06:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OwM8pKQBGSrGbldVCPidRz0G6Pk8Can5ICGIjPtCWZ4=;
        b=fh3/PWnZuXZezNAH1a3WABrapvs8gPioFwkDKDO5ZEs895lLklr3LHcy93MgYL9xJM
         ay06nfcJGD8yS3+cL7VIWvPbywBtitGsYedNAZ/q3C6qNfPrmSl2tLreird0qIK48MF1
         5tPMppTcRymTwpEGD8eRCf2owVNAy1zSxuArAS1PAeSRllp+jsftZ9UB2+xchgU8AitS
         tUjo6AkBoKrOD3Gz18LUHWEVytbzXX6WXthG/l1u1W9+IGv9ksaNWfKi6iFVKyFA6bWm
         GdkExUSLFHR4QrG7U8L1y5c/WCsr3dqBZM8mk8D9FTKl2g5YoLQvRb7Yif3Wdtu5qDd+
         tJVA==
X-Gm-Message-State: APjAAAUuINySLny87X/fpZIaXbSFT8p8Xt16JO7Y63F4aHf2iq2AtKVq
        fugpolUEgfIeC3eyGFXMo/NJzpd/mIs=
X-Google-Smtp-Source: APXvYqxDkwrIUtcE6dBIfcrL9rduUFqWYZUE5CQI0sTZbzIJF3Y+3D1kIHGB0OrJgRUI0iTfaULzBw==
X-Received: by 2002:a17:90a:a407:: with SMTP id y7mr29005118pjp.124.1571666011899;
        Mon, 21 Oct 2019 06:53:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:ce:e1dd:ac50:4a18:2864? ([2601:647:4000:ce:e1dd:ac50:4a18:2864])
        by smtp.gmail.com with ESMTPSA id 22sm13983406pfj.139.2019.10.21.06.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:53:31 -0700 (PDT)
Subject: Re: [PATCH 4/4] siw: Increase DMA max_segment_size parameter
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20191021021030.1037-5-bvanassche@acm.org>
 <20191021021030.1037-1-bvanassche@acm.org>
 <OF471AECA2.EB2C94E3-ON0025849A.0033B64B-0025849A.0034BC19@notes.na.collabserv.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2afaa09e-48a8-5189-026d-577b0f5d8ac9@acm.org>
Date:   Mon, 21 Oct 2019 06:53:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <OF471AECA2.EB2C94E3-ON0025849A.0033B64B-0025849A.0034BC19@notes.na.collabserv.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/21/19 2:36 AM, Bernard Metzler wrote:
> Why don't we make device_dma_parameters siw_dma_params 
> just a const in siw_main.c? Having it per siw_device suggests
> more flexibility than we actually need and support? Probably
> true as well for rxe driver. This is all driver specific.
> 
> Independent of this current patch, probably even true for
> siw_device.attrs. We do not have those capabilities siw
> device specific, but just siw driver specific.

Hi Bernard,

The dma_parms pointer in struct device has not been declared const.
Assigning a pointer to a const structure to the dma_parms member of
struct device would trigger a compiler warning. I think everyone wants
to keep the RDMA code free from compiler warnings.

Thanks,

Bart.

