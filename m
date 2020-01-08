Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B1F134827
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 17:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgAHQjy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 11:39:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36659 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgAHQjy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 11:39:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so1900212pfb.3;
        Wed, 08 Jan 2020 08:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qh5UFCl66QVsOLddD6mSC/CJRGvg3WC1RlR2XftSxG0=;
        b=IL2DXEqQjHvLIvdER5dHFZz6+4AGq/+RA7iJ1NOdzPO629dW0uunACVnQbsL6REtvs
         Lzznwtr1wkcJaGa0HGFt/9w8DxhwQw8QuQGRbjDAP2mQhRNgG9sH5eaFboc+keo45CDN
         ellOAF8W0WBLDvszHtidRihOhnq8Sj3q5C8BoISdkmUs9KUzbqseDeI/twS5EuTyiVm3
         jAe3xiXRwj0z7sExcFxQREv3QtMDKojdad5/HXUuDdDBY3z9EUYSsNp5FXxur0/dHUkz
         piV1ZLCrpcvi8YLDpEyTg+qUbl4zesKol1saMWhUz16/M8SH4xvVIxYvl2HXyVxNlzdo
         hsCw==
X-Gm-Message-State: APjAAAVH5vFHwJO/vbeucGb/sqpxob/NB/igLmXDUNZ+V/8ia9y9DO+h
        KGb2YBDJDtsUItjz6WU185s=
X-Google-Smtp-Source: APXvYqy8YWl4R52TKa8Qu1KW69wefmI+DDam/dSeMxhBwm6EB5HrOqhDri+mzC1MfbnSmhLfKg0bVA==
X-Received: by 2002:a65:644b:: with SMTP id s11mr6177561pgv.332.1578501593198;
        Wed, 08 Jan 2020 08:39:53 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g18sm4293123pfi.80.2020.01.08.08.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 08:39:52 -0800 (PST)
Subject: Re: [PATCH v6 18/25] rnbd: client: sysfs interface functions
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-19-jinpuwang@gmail.com>
 <e0816733-89c0-87a5-bc86-6013a6c96df2@acm.org>
 <CAMGffEmRF+2SZ5Nf3at9SohZXTT3siakBYoZpErN=Tr_PCA9uw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a2748915-b88e-cc91-2ab8-1a95f678e444@acm.org>
Date:   Wed, 8 Jan 2020 08:39:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAMGffEmRF+2SZ5Nf3at9SohZXTT3siakBYoZpErN=Tr_PCA9uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/8/20 5:06 AM, Jinpu Wang wrote:
> On Fri, Jan 3, 2020 at 1:03 AM Bart Van Assche <bvanassche@acm.org> wrote:
>> On 12/30/19 2:29 AM, Jack Wang wrote:
>>> +/* remove new line from string */
>>> +static void strip(char *s)
>>> +{
>>> +     char *p = s;
>>> +
>>> +     while (*s != '\0') {
>>> +             if (*s != '\n')
>>> +                     *p++ = *s++;
>>> +             else
>>> +                     ++s;
>>> +     }
>>> +     *p = '\0';
>>> +}
>>
>> Does this function change a multiline string into a single line? I'm not
>> sure that is how sysfs input should be processed ... Is this perhaps
>> what you want?
>>
>> static inline void kill_final_newline(char *str)
>> {
>>          char *newline = strrchr(str, '\n');
>>
>>          if (newline && !newline[1])
>>                  *newline = 0;
> probably you meant "*newline = '\0'"
> 
> Your version only removes the last newline, our version removes all
> the newlines in the string.

Removing all newlines seems dubious to me. I am not aware of any other 
sysfs code that does that.

Thanks,

Bart.
