Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F11229F648
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 21:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgJ2UhN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 16:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgJ2UhM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Oct 2020 16:37:12 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C45C0613D4
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 13:37:12 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id m26so3542845otk.11
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=U2rJcXUBEKEC1ADdGhHo/lYRFPkFVe+jjiDBSjjnydY=;
        b=UXkX/OBK62KG3agSWAyIxqOsyO3Pq1PknnGYjP0MKmnpAr2du8SgOgjtbgVSrGF2Sk
         rRx+zuqcM+3FQKEUguPdsvWqHWU97crUjYMA4i1sadaBWayeXFEIhiFXLJ9DIjDwRIcP
         /CYoPvqv3kmgiES7UeIoYMA/BBXqjSzHFSYrON3Fj2e5hgUDAq6/nlyqhTNCJoHRpDV2
         12fobdCsBoGZR60r1Fjash3h30N7qJvjdaCcPFPxB5HFFRSMvEiTzyoHw4r6F98q/m0/
         /VJ7KDVaUGbTrBpn/N2ttrJZoqkgR9YJRnsj2aNnZ4d3Y/A6/AYqYgydECGPgcHC1UF9
         eQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=U2rJcXUBEKEC1ADdGhHo/lYRFPkFVe+jjiDBSjjnydY=;
        b=j1LAiHNLJE0JWbCwOQIr78uha++3hKKo6A6otOrSHeseTXQaMJUWbnYqnDQHISzFQF
         KvsUmaKnT8Yaqqq7AsQ2iVUZNbN9wYI/yGRXsHXXhcv9NR5eWRRS/PEwGj5Wgc1nr71R
         1aLPutGoc5N8AVNtKW0tIbwf+oK1u4YFx6fmsvaBk/IPEbuT9ky9euDeQUQXwVwL0nMg
         zz94Xxiv+KS3MsmQChHSm/bfYRl1yh/QuGMNQ9DJWD/PL/OdzXEOCPNpQi6mukR8mWP/
         uERcVaeaKbC40DPJLrUT5ZtTnAsMTxmLFGZHi0UQ+RJI4csuvc4TeF9EZjTTG4AJM/Jp
         hTWw==
X-Gm-Message-State: AOAM5320Kdd/8cgzCvW1uGdRbZe7dj2vQLfrOPLu07t6RLuF5/fO7duU
        726EBToi0U0szC02FP3AJQsOvcKl8fw=
X-Google-Smtp-Source: ABdhPJwgIzmaOPyENzNZPajPE05x9fnIafwfMSY/M1FOVmdp7UxalfU3CKKSS+SQMzvWQyjzJLykTg==
X-Received: by 2002:a05:6830:1e02:: with SMTP id s2mr4563693otr.178.1604003831610;
        Thu, 29 Oct 2020 13:37:11 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:5ec3:3713:23e4:7cdc? (2603-8081-140c-1a00-5ec3-3713-23e4-7cdc.res6.spectrum.com. [2603:8081:140c:1a00:5ec3:3713:23e4:7cdc])
        by smtp.gmail.com with ESMTPSA id v21sm851117oto.65.2020.10.29.13.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 13:37:11 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: 5.10 breaks rxe
Message-ID: <405e252c-7229-c116-f1e7-8f02387bc53c@gmail.com>
Date:   Thu, 29 Oct 2020 15:37:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason,

Looking at the current tree post 5.10.0-rc1 rxe is pretty broken.

The first problem I have run into is caused by the following recent patch:

   commit f959dcd6ddfd29235030e8026471ac1b022ad2b0
   Author: Thomas Tai <thomas.tai@oracle.com>
   Date:   Thu Sep 17 18:43:03 2020 +0200

       dma-direct: Fix potential NULL pointer dereference
    
       When booting the kernel v5.9-rc4 on a VM, the kernel would panic when
       printing a warning message in swiotlb_map(). The dev->dma_mask must not
       be a NULL pointer when calling the dma mapping layer. A NULL pointer
       check can potentially avoid the panic.
    
       Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
       Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
       Signed-off-by: Christoph Hellwig <hch@lst.de>

which causes a warning if ib_device->dma_device->dma_mask is NULL which it is at the moment for rxe.

But, rxe never does any DMA. It only copies data in software. It does however sometimes do this copy at interrupt level and will fail badly if the users memory is paged out. Rxe just follows the HW rdma model and pins MRs which solves this problem. The original rxe code does packet processing in tasklets which are software interrupts or on the NAPI thread which is also an interrupt.

Rxe calls ib_register_device() with a NULL 3rd argument which is supported. But in this case, ib_register_device just sets dma_device to point at &ib_device->dev which is sort of a dummy device and never sets dma_mask to anything. This now fails because of the above patch.

I can think of three approaches to fixing this problem:

1. Fix ib_register_device to correctly handle a NULL dma_device argument (if anyone besides rxe uses it)
2. Fix rxe to provide a valid dma_device. Currently rxe assumes that ib_device->dev will be it and sets dev.parent to point at the dma_device behind the network device that has rxe installed on it.
3. (Much harder) Strip out all the memory pinning and DMA support and perform the copies in work queues which can sleep. The problem is that rdma code basically assumes that DMA is always there.

This may be easier than I am seeing. Let me know what you suggest.

Thanks,

Bob
