Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D1629F7A5
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 23:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgJ2WRs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 18:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2WRs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Oct 2020 18:17:48 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AD5C0613CF
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 15:17:48 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id x7so3863074ota.0
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 15:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zsPgarxWAkuEj2/yQH2YT1NQn5hI3ayGJBKBKSg1DOU=;
        b=ei0EaPUrj/2x8NYmzQJsaIozAydzlVAt+KWPIXghy2mfLU5+9mMbFk0+pEN6D1xqR0
         YmFQhBNTe2GXx6qeAY3IT6L9OO3LDM9XsYwF1n47tFUs9cVnkCTNF2GZXRxTJx4asnA9
         5dPCZnAm514EZXhE9czCIvo7GjlOvqWESPU2nK6Xe8L5n9zT+chak3imbHgZ2cHvtrPW
         LrDmgJJ2YVNBiRIyPqJ0e0hNBWWsCvYLuYL0AolBxaesLk8bj9L6dPIzZcsvDSWSvdge
         pJlXVed80TIyQC/Gri2giD5t5S7MtDVvqTXrqXiuXcNT6JC7yIgx57nnQ7WEk1Y7xQZi
         oSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zsPgarxWAkuEj2/yQH2YT1NQn5hI3ayGJBKBKSg1DOU=;
        b=dMctV5cwHiDwHJv53t/Pfv5KHbx97UvbtSXy4g0IMKp2EGxnGxOfHcc1GMrUS/knuS
         6Di5W5TdaXLCBsswSMkwDEgQ2Kas4zl4pqjmeSgxl9kHmSaO6Hn/NKn+KnnzjXgXgomy
         QM9m3z4Hg2C0s+wwoQWUw9YXUaaVNBn3KXhb4KRMQkrR69JbRwdcZeaMFZoUrYj5zw3I
         hS/A3M4tOLCnxjMYtKMFm1f+3Y2LtrrXYJN/590FjAm3EVoGTTsqPBEeYvAGhBEGABh5
         XX4djoBvEeAYF+2VulVGwwrFOcR8Jr76i0rmyIZ/ULrX4LnY8cgnnI3Iq00C7I5WMsYp
         uK+g==
X-Gm-Message-State: AOAM5318xxzZamS2yvc44UhMQ1bjWCfKxLV5j4CvKPXacKrN/BhbuwLv
        D3HPUJ2OipXjcNjQu+9LqgylQ2qHdCE=
X-Google-Smtp-Source: ABdhPJxHuC/+kTdyb0VgHS2XT7PxCXfR64+htOP77OsFYnDISj3DjlayigA9RA5c+DtaW4BOOntYkg==
X-Received: by 2002:a9d:289:: with SMTP id 9mr4708904otl.359.1604009867363;
        Thu, 29 Oct 2020 15:17:47 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:5ec3:3713:23e4:7cdc? (2603-8081-140c-1a00-5ec3-3713-23e4-7cdc.res6.spectrum.com. [2603:8081:140c:1a00:5ec3:3713:23e4:7cdc])
        by smtp.gmail.com with ESMTPSA id f2sm927345ots.64.2020.10.29.15.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 15:17:46 -0700 (PDT)
Subject: Re: hfi1 broken due to dma_device changes in ib_register
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <ad690c34-4260-91a1-d64a-2954a8ae1c54@cornelisnetworks.com>
 <20201029220125.GZ36674@ziepe.ca>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <de2291bb-bf8a-4d07-960c-2bf93bbbdcbc@gmail.com>
Date:   Thu, 29 Oct 2020 17:17:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201029220125.GZ36674@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/29/20 5:01 PM, Jason Gunthorpe wrote:
> On Thu, Oct 29, 2020 at 05:54:22PM -0400, Dennis Dalessandro wrote:
>> Just a heads up, 5.10-rc1 is broken for rdmavt/hfi1 after:
>>
>> e0477b34d9d11 "(RDMA: Explicitly pass in the dma_device to
>> ib_register_device)"
>>
>> Running with that change causes the call trace below. Reverting the patch
>> works around the problem.  I haven't yet had a chance to look at what the
>> actual cause is, but will and follow up with a proposed patch hopefully
>> soon.
> 
> Test this:
> 
> https://lore.kernel.org/linux-rdma/20201028173108.GA10135@lst.de/T/#mde105a810fb9d2bf734554f3a9875468184dd96c
> 
> Jason
> 
This the same issue I found. I ended up just using DMA_BIT_MASK(64) as was suggested.
