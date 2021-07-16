Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3DD3CBB6F
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jul 2021 19:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhGPR6E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jul 2021 13:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhGPR6E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Jul 2021 13:58:04 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FBCC06175F
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jul 2021 10:55:09 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10723223otl.3
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jul 2021 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DrrXx6R/BY+Jug6RiwwjSFurweew52Oknz7NofLTN98=;
        b=GrJckgdCTfHtbfmKI6nkFHLc0arexJL03b9jz606F3MWVAFN5ENB1WvvoVoqAE7L7m
         ZUMIyHYUmQfk2MJ7GJNU4wGFQ6GZxGHLL2A9u08putzkHF88zl49F8Nvi/jTKISrbWzT
         YlxC2E7hm3Pr0rhMzsOhmaLwr8ZHCUiP/Wls8QTF5cQJd2djcq8+CVrgRSGq2yH7IVBD
         cE6ia0Mcj1h+V5Z+MaYpK8LAGwuM0U7NKbj7LIalG+NflUswwgGv14/n8NsMLFXIJoRK
         1m4ouuLB7FytfnVlvsWz6TMbc5RINY2svuBiKwAZ0N48Losz6XrEGH2s9RmknaVRAPoa
         ljcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DrrXx6R/BY+Jug6RiwwjSFurweew52Oknz7NofLTN98=;
        b=l26PX2rTY98qu5hu+1Sz0t9iM0kUBzNbplvPsF8eq6mVLAVabvAE/76iXVDw9lqf+R
         c8DeP0noAvk/MWxE7RuOL/ve7W6kCI4CAWHXczGk0J7DmfkChbYcy8WHaHIlCD0khT+A
         kBYLGjSNErw7IBB7MXFnpXXZu3eGZ8Rh3a5hWxQjitEr00UBlaHsfZTjdIEhUPRZZ5Om
         Sd5BQrnjPbada4BRlENO0tSiGdMc/V95D8SMoPTPTbwqXvQst/InlDACkEBAnmogcaHF
         CYtzuEUhAEid8ni77FVOWuegrH/M3idQCKk+0QENRU28wbnZpW65Z7CNwcGrj9kg72IZ
         +vvg==
X-Gm-Message-State: AOAM530H1BEkSAZ51ytF+1jMab3nDVYLWolWRCMXmagtz5YrEfXoS/WA
        AjHH3GB+4b/mmRE3ubNnOqWJ2YJ5uUQ=
X-Google-Smtp-Source: ABdhPJxkjTAso+z778la6c+rBh7IR5UnEkP0syBZq69VzmrrEXoGofK/pUcDZVA23twZKir3idgKuw==
X-Received: by 2002:a05:6830:2316:: with SMTP id u22mr9168432ote.90.1626458108463;
        Fri, 16 Jul 2021 10:55:08 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:19e7:5eff:7934:fbda? (2603-8081-140c-1a00-19e7-5eff-7934-fbda.res6.spectrum.com. [2603:8081:140c:1a00:19e7:5eff:7934:fbda])
        by smtp.gmail.com with ESMTPSA id l196sm784620oib.14.2021.07.16.10.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 10:55:08 -0700 (PDT)
Subject: Re: [PATCH 1/5] RDMA/rxe: Change user/kernel API to allow indexing AH
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20210628220043.9851-1-rpearsonhpe@gmail.com>
 <20210628220043.9851-2-rpearsonhpe@gmail.com>
 <20210716174412.GA768036@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <ede35d21-2af7-92c3-7289-ba14c8a6bb5a@gmail.com>
Date:   Fri, 16 Jul 2021 12:55:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716174412.GA768036@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/16/21 12:44 PM, Jason Gunthorpe wrote:
> On Mon, Jun 28, 2021 at 05:00:40PM -0500, Bob Pearson wrote:
>> Make changes to rdma_user_rxe.h to allow indexing AH objects, passing
>> the index in UD send WRs to the driver and returning the index to the rxe
>> provider. This change will allow removing handling of the AV in the user
>> space provider. This change is backwards compatible with the current API
>> so new or old providers and drivers can work together.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>  include/uapi/rdma/rdma_user_rxe.h | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
>> index e283c2220aba..e544832ed073 100644
>> +++ b/include/uapi/rdma/rdma_user_rxe.h
>> @@ -98,6 +98,8 @@ struct rxe_send_wr {
>>  			__u32	remote_qpn;
>>  			__u32	remote_qkey;
>>  			__u16	pkey_index;
>> +			__u16	reserved;
>> +			__u32	ah_num;
>>  		} ud;
>>  		struct {
>>  			__aligned_u64	addr;
>> @@ -148,7 +150,12 @@ struct rxe_dma_info {
>>  
>>  struct rxe_send_wqe {
>>  	struct rxe_send_wr	wr;
>> -	struct rxe_av		av;
>> +	union {
>> +		struct rxe_av av;
>> +		struct {
>> +			__u32		reserved[0];
>> +		} ex;
>> +	};
> 
> What is this for? I didn't notice a usage?
> 
> Jason
> 

Nothing yet. Was just pointing out that this is where we can extend the wqe without breaking ABI.
I came back to this issue because I started working on implementing XRC and realized that I had to find someplace to put the xrc extended header info (the srq number) and the wqe was full up. Being dense
I didn't figure out until later that the AV is only used for UD so this space is free anyway.
Never the less this the patch set is still useful because IMO.

Bob
