Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307815620B0
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 18:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiF3Q6o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 12:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiF3Q6n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 12:58:43 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9724D205ED
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 09:58:42 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w193so42931oie.5
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RrckwD/xAcIrZgjC1yjZ4/5LF8AaOkJvAtZDgkPeBVo=;
        b=iglvhEBiQWUm2tFhXl0s9Pauxv/jjGTlU2kFvDLQX8DWT+85EA9BI7TFkgHzmM9z2r
         bH7R+R5aANq+Z7PYCAZZB5u6PCF9tavrmoGs0CuyT4YYmH/DCftyxN2pLYqdRl9JLUrC
         xrUFJ/FtQMnspQ4dWUV/p8Jn23P0XsIr8UW3tirpV17ZofNAlLgDJ0sGDdOPYeuAQ0yy
         kWl0pPDgYWeQgrRN5FwDyH0ipXDrmJXr7yRuzb+fkftTqZuftuhT0gNuTDTRNjGGpUkr
         P0V1SEJPYGIv+EGYVgYrqobLGmnJg+j0y2XnBOd2bAXwzs+jSxmBF2GEdtjcRquGFzEI
         49ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RrckwD/xAcIrZgjC1yjZ4/5LF8AaOkJvAtZDgkPeBVo=;
        b=CkKL3CDzz5NAuBD0dInnBImKMiAvCS8lazghHxQtpgB0jT5k2Fbje9C9KNr/syqdpc
         vz0ijtyOdKD+tduZ1lDTfhFziB9wPTiOodwbxPR2+NwcHLKLLEOydyBpnVEdi3vlY4GB
         eb+Uw828luRFpDNi1c9YIIIvIAKn8tHY/tjczeCrK6cwPuK/TTbx0hbC11GyvWiExrKu
         9qFZORDumfZmnKwaB0ZxAoHvyReQDquoXnTaI1Qx5iqyYa3uOfaEWzU6wldpap0OWNw0
         UW60R0TumJ7/953+q3RWCIUzSHEigiZfN3VqMmaC+/ihT/Nzohm0gfzkGpYJHzwSiwTx
         fogQ==
X-Gm-Message-State: AJIora/H4VBzhtXfdXdxmQqNO4YXGpsCU6uG0KLOcNEcicecInmOxwf/
        ewgffXVRWOdrooynoR8Ba1I=
X-Google-Smtp-Source: AGRyM1vz6sZULWzdVyl3Aq5dDzvFimsg7MNsnNNOCNta/yLJq3Ffjm6Fqg5LZ4hlBxmktFaDeei2qA==
X-Received: by 2002:aca:bb56:0:b0:32e:c8b6:31e with SMTP id l83-20020acabb56000000b0032ec8b6031emr6890192oif.137.1656608321939;
        Thu, 30 Jun 2022 09:58:41 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e895:24ff:51a7:a632? (2603-8081-140c-1a00-e895-24ff-51a7-a632.res6.spectrum.com. [2603:8081:140c:1a00:e895:24ff:51a7:a632])
        by smtp.gmail.com with ESMTPSA id eh40-20020a056870f5a800b000f342d078fasm13726972oab.52.2022.06.30.09.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 09:58:41 -0700 (PDT)
Message-ID: <d5cf014c-1ed2-2a6d-82b0-5f61857ea74d@gmail.com>
Date:   Thu, 30 Jun 2022 11:58:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next v16 0/2] Fix race conditions in rxe_pool
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, frank.zago@hpe.com, ian.ziemba@hpe.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
References: <20220612223434.31462-1-rpearsonhpe@gmail.com>
 <20220630135817.GA982692@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220630135817.GA982692@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/30/22 08:58, Jason Gunthorpe wrote:
> On Sun, Jun 12, 2022 at 05:34:33PM -0500, Bob Pearson wrote:
>> There are several race conditions discovered in the current rdma_rxe
>> driver.  They mostly relate to races between normal operations and
>> destroying objects.  This patch series includes the remaining two
>> patches of the original series.
>>
>> Applies cleanly to current for-next after the two oneline patches
>> submitted by Dongliang Mu that fixed an error in the error checking
>> code from xa_alloc_cyclic().
> 
> Applied to for-next, thanks
> 
> I moved the might_sleep hunk from the last patch to the first though
> 
> Jason
thanks. Been a long time coming. Glad we're there.

Bob
