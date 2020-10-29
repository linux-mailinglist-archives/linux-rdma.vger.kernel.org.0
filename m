Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09ECC29F6E6
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 22:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgJ2Vcg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 17:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgJ2Vcf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Oct 2020 17:32:35 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0F7C0613CF
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 14:32:06 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o14so3708944otj.6
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 14:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9+PkNIQ9pKYk0IRicnX0IIJRXXDKhXvJtmYAvg8iH9k=;
        b=eKBYIxS5nmGIgGnoIdk98lakDwMX6lng9kMU3inA0Eh+fLZIlbOgbPTZvC/+539Y/S
         AYbo4q6MCWDra3ygUDdGXL7S5KKI0QWdHtyfQxLFopaNQeaAMPAUU0rcSQPl5DtxyGms
         05knYLYAemmOJ7/jaTKRV4D40exxrfAUZOqh7N6E/DhYV/Bb/TMz9X6w6MY55Af5HDpd
         EP5RKghs/NojFXtEqLAYFGVU7m9TBHmvUEIvdb4pO6EWPFIClsFk/sBuKEzoMZsn1v19
         K6q56VzpnJIUc6GpBuCyjrlf9oEkaaerhwxKz+Mher8R1IJhYwVz/kBT8caUV3Afdh7m
         O+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9+PkNIQ9pKYk0IRicnX0IIJRXXDKhXvJtmYAvg8iH9k=;
        b=rlf3z4aXM+7hsRR9G2qL9RlfL2L5k0Q2P2DoY9OwWFSwLJL59mo+/CXHuDLUJUc3FP
         +7f/tAMhV4EyD1nj7z5fpkbzpBYDE/z4MGSBxw939HRLBYe8uXtLkxAiO8mmnZSADuoz
         wj4SskC6RmbmZAQnpDp+Up7CXovi+Z1ekVrF0K+DA5S0AP4JPE1DoOFk9vDukpeYPi08
         47G6e10gmA9/tuGYPJnbUIYBKdGPSflgxL+/kBdzFPr3TneDG48AosTfH2ccf9TDfek7
         i0R7AGlZmQkXH1dW75TAS0eKI/sEDQtCDHdzjgPz2qxtU2pdOm9nw26ru0kn+MPprPR5
         upzw==
X-Gm-Message-State: AOAM5339OiS4Uu+Gqil2haC7XPiPc3EkD9lHIQh4wuCXtzWoqvHhd5Zb
        7mRDKUVi4Ltv0tU5D6tjjT4e2x6I6NA=
X-Google-Smtp-Source: ABdhPJzAgt4kYCrqkQU8JhYON/267lY6D2d4PX1mAT5yQbZsIZ0OVLUHykQN5z2HW/NAN/x/OY3YJw==
X-Received: by 2002:a9d:2905:: with SMTP id d5mr4581881otb.343.1604007125304;
        Thu, 29 Oct 2020 14:32:05 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:5ec3:3713:23e4:7cdc? (2603-8081-140c-1a00-5ec3-3713-23e4-7cdc.res6.spectrum.com. [2603:8081:140c:1a00:5ec3:3713:23e4:7cdc])
        by smtp.gmail.com with ESMTPSA id f142sm878605oib.10.2020.10.29.14.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 14:32:04 -0700 (PDT)
Subject: Re: 5.10 breaks rxe
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <405e252c-7229-c116-f1e7-8f02387bc53c@gmail.com>
 <DM6PR12MB3834AFC509E07D1711308DBDC2140@DM6PR12MB3834.namprd12.prod.outlook.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <fe4f7fa9-e988-ff82-ef35-05be8ee9c143@gmail.com>
Date:   Thu, 29 Oct 2020 16:32:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB3834AFC509E07D1711308DBDC2140@DM6PR12MB3834.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/29/20 4:08 PM, Jason Gunthorpe wrote:
> Parav will fix it, see the note from Christoph about using dma coerce and mask
> 
> Get Outlook for Android<https://aka.ms/ghei36>
> 

I went ahead and submitted a one line patch that fixes it in rxe. Could do same thing in core.

> ________________________________
> From: Bob Pearson <rpearsonhpe@gmail.com>
> Sent: Thursday, October 29, 2020 5:37:10 PM
> To: Jason Gunthorpe <jgg@nvidia.com>
> Cc: linux-rdma@vger.kernel.org <linux-rdma@vger.kernel.org>
> Subject: 5.10 breaks rxe
> 
> Jason,
> 
> Looking at the current tree post 5.10.0-rc1 rxe is pretty broken.
> 
> The first problem I have run into is caused by the following recent patch:
> 
>    commit f959dcd6ddfd29235030e8026471ac1b022ad2b0
>    Author: Thomas Tai <thomas.tai@oracle.com>
>    Date:   Thu Sep 17 18:43:03 2020 +0200
> 
>        dma-direct: Fix potential NULL pointer dereference
> 
>        When booting the kernel v5.9-rc4 on a VM, the kernel would panic when
>        printing a warning message in swiotlb_map(). The dev->dma_mask must not
>        be a NULL pointer when calling the dma mapping layer. A NULL pointer
>        check can potentially avoid the panic.
> 
>        Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
>        Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>        Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> which causes a warning if ib_device->dma_device->dma_mask is NULL which it is at the moment for rxe.
> 
> But, rxe never does any DMA. It only copies data in software. It does however sometimes do this copy at interrupt level and will fail badly if the users memory is paged out. Rxe just follows the HW rdma model and pins MRs which solves this problem. The original rxe code does packet processing in tasklets which are software interrupts or on the NAPI thread which is also an interrupt.
> 
> Rxe calls ib_register_device() with a NULL 3rd argument which is supported. But in this case, ib_register_device just sets dma_device to point at &ib_device->dev which is sort of a dummy device and never sets dma_mask to anything. This now fails because of the above patch.
> 
> I can think of three approaches to fixing this problem:
> 
> 1. Fix ib_register_device to correctly handle a NULL dma_device argument (if anyone besides rxe uses it)
> 2. Fix rxe to provide a valid dma_device. Currently rxe assumes that ib_device->dev will be it and sets dev.parent to point at the dma_device behind the network device that has rxe installed on it.
> 3. (Much harder) Strip out all the memory pinning and DMA support and perform the copies in work queues which can sleep. The problem is that rdma code basically assumes that DMA is always there.
> 
> This may be easier than I am seeing. Let me know what you suggest.
> 
> Thanks,
> 
> Bob
> 

