Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068D72029C6
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 11:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgFUJJD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 05:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbgFUJJD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Jun 2020 05:09:03 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C09C061794
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2020 02:09:01 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w7so11214386edt.1
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2020 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q5nmP3qhCQVqf3nCVxQQKK4ZwzCgGYv5aI2qqhF/+iw=;
        b=rpCZfTZsCStjIhzByfbBpm5De+56pEfxzPGrh5JFZq1RuT9bw4UhIX//KUbZzi3wIw
         6/7xzzhwex/MVRGRSGKuOOgejeEFBCcaI+vpX9c20vLgvUUx3dHOZ6cZsByUehrLrXPH
         S8RiyHRKymmGbkdN2o+L1P7hnpFWehuSZ6w0XXHV7PV4OZXZyPxkkhpzojMDJBDgQJ6O
         YO2DjZg+VfPj4BkMRNoJ+JV1D7DjF2QZyvPghmJLxZRZbFzOzjriXICPAiGCvpjnTWnc
         wNCCwpDGAC9kISRjRzpYulLjG4AaUlPJ65jpmYLltKXSzy/EGrPuIytR2SBbULVus/yf
         jbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q5nmP3qhCQVqf3nCVxQQKK4ZwzCgGYv5aI2qqhF/+iw=;
        b=MYt/xa34A6PxgT85mDHeRVnWi793r1gSx+XkTw9hFigsYT5fziICVyoKVZHQQJ6i97
         bftp8Sfs6kFsCpnxabPQH66qw3isD+nYmTWcFrKJj4xj4eZSIl2WuUvZyIplVT1D2oR1
         i7s9O0D13ZodvqNcIHtk/0aMX/+fYQvsKzZ5E2d0pCXCP8jl8iZPSTJryAJsskUpxzv/
         t2kSgyEbj/x47vUKBBrBAhHZNmQN3raZnTQ04fElPVUr2OlvAv7hC3nrYa/Iwwt4fS+o
         OMAGa6UaW2z6jzl350mNfHvd2sucpFONX7UgvidU6QXePpghxpX8oqCnMRpZpEBJFm8+
         71UA==
X-Gm-Message-State: AOAM5307E4AE+aTXg8/aSVZtDcdyVRy2n4tAsHPRSze+I8K3wyqVj9P8
        JMA5ei6ijEeX3CJsj8jUEkQm002QwOU=
X-Google-Smtp-Source: ABdhPJynHBLlSPhmPRmVPAuHYbF1+b9oKooHkAsW/vdr60Xwd1OHK5mN1Nn9EubiVzghXRTiTU7j7w==
X-Received: by 2002:aa7:d9c6:: with SMTP id v6mr11699316eds.29.1592730539519;
        Sun, 21 Jun 2020 02:08:59 -0700 (PDT)
Received: from [10.0.0.57] ([5.22.133.189])
        by smtp.googlemail.com with ESMTPSA id l12sm4634516edj.6.2020.06.21.02.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2020 02:08:59 -0700 (PDT)
Subject: Re: [PATCH rdma-core 04/13] verbs: Handle async FD on an imported
 device
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        maorg@mellanox.com
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
 <1592379956-7043-5-git-send-email-yishaih@mellanox.com>
 <20200619123332.GU65026@mellanox.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <778c127c-00c9-9b2d-6c81-a96e51029324@dev.mellanox.co.il>
Date:   Sun, 21 Jun 2020 12:08:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619123332.GU65026@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/19/2020 3:33 PM, Jason Gunthorpe wrote:
> On Wed, Jun 17, 2020 at 10:45:47AM +0300, Yishai Hadas wrote:
>> @@ -418,7 +427,13 @@ static struct ibv_context *verbs_import_device(int cmd_fd)
>>   
>>   	set_lib_ops(context_ex);
>>   
>> +	context_ex->priv->imported = true;
>>   	ctx = &context_ex->context;
>> +	ret = ibv_cmd_alloc_async_fd(ctx);
>> +	if (ret) {
>> +		ibv_close_device(ctx);
>> +		ctx = NULL;
>> +	}
>>   out:
>>   	ibv_free_device_list(dev_list);
>>   	return ctx;
> 
> This hunk should probably be in the prior patch, or ideally the order
> of these two patches should be swapped.
> 

I can swap the order of those two patches as you suggested.
However, in this case, the first one will be some preparation to force 
the ioctl mode upon an 'imported' flow and only then the second one will 
introduce the 'imported' flow as part of adding ibv_import_device().
If you are fine with that let's go by that approach.

Yishai
