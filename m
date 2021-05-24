Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7787A38DFEB
	for <lists+linux-rdma@lfdr.de>; Mon, 24 May 2021 05:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhEXDm4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 May 2021 23:42:56 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:39797 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhEXDmz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 May 2021 23:42:55 -0400
Received: by mail-pl1-f171.google.com with SMTP id t9so5494322ply.6
        for <linux-rdma@vger.kernel.org>; Sun, 23 May 2021 20:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h/YVemGl5XKLbMVkfcP0PaFgibDcSE7vRxPa78Tv62M=;
        b=uXv3Bnp7oIovRGTA5T51MhMU9i1FXbXVwVHw0AG4WA+hLNFNp0S/EQ4phpGzu54M5a
         dd44zU60ZaZJMbkDJjD7ZV+CC+HBiIndlMDR3WBbFSOYMH8MdUOf05FNLklIRe82B7G+
         IN6HorZICOuJ+zw0eequM/UL6fraHYjJ0Kf4TW8iD4iLlkpABsl/lpcCZb8HPvyYq53R
         0Tp3yjcQAI1q695cIBjEkvYU3JYGHCHUWU9TC75/m65qiHWbdENvhCOfw0mdq9QfTY+U
         /9j9rfhz40k54zGjTfwoW5IQMwdfn+2LJN4pKXzCzYUxvJtux5qC0vLb+jRv4ahcfBjK
         ugYQ==
X-Gm-Message-State: AOAM530bQqXjoFBpzs8ReIA4dBjsaEFKo+cNqSEWz2Ehy8JK/Hlr3USP
        xu0mbFdQRUhiUyWcCkFdFB8=
X-Google-Smtp-Source: ABdhPJw2Odko+EgK2PPO6RbA66Z/CA3oMJAz8WHdgwZ96nVflMFn/4YVm3SmV3XiR31Mfh9HD169jw==
X-Received: by 2002:a17:902:f281:b029:f0:bdf2:2fe5 with SMTP id k1-20020a170902f281b02900f0bdf22fe5mr22925940plc.68.1621827687655;
        Sun, 23 May 2021 20:41:27 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id 25sm9558873pfh.39.2021.05.23.20.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 May 2021 20:41:26 -0700 (PDT)
Subject: Re: [PATCH 3/5] RDMA/srp: Apply the __packed attribute to members
 instead of structures
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
References: <20210512032752.16611-1-bvanassche@acm.org>
 <20210512032752.16611-4-bvanassche@acm.org>
 <20210520144856.GA2720258@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7a77c2ed-5336-11ea-162e-539b593a1ce7@acm.org>
Date:   Sun, 23 May 2021 20:41:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520144856.GA2720258@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/20/21 7:48 AM, Jason Gunthorpe wrote:
> On Tue, May 11, 2021 at 08:27:50PM -0700, Bart Van Assche wrote:
>> @@ -107,10 +107,10 @@ struct srp_direct_buf {
>>   * having the 20-byte structure padded to 24 bytes on 64-bit architectures.
>>   */
>>  struct srp_indirect_buf {
>> -	struct srp_direct_buf	table_desc;
>> +	struct srp_direct_buf	table_desc __packed;
>>  	__be32			len;
>> -	struct srp_direct_buf	desc_list[];
>> -} __attribute__((packed));
>> +	struct srp_direct_buf	desc_list[] __packed;
>> +};
>>  
>>  /* Immediate data buffer descriptor as defined in SRP2. */
>>  struct srp_imm_buf {
>> @@ -175,13 +175,13 @@ struct srp_login_rsp {
>>  	u8	opcode;
>>  	u8	reserved1[3];
>>  	__be32	req_lim_delta;
>> -	u64	tag;
>> +	u64	tag __packed;
> 
> What you really want is just something like this:
> 
> typedef u64 __attribute__((aligned(4))) compat_u64;
> 
> And then use that every place you have the u64 and forget about packed
> entirely.

Really? My understanding is that the aligned attribute can be used to
increase alignment of a structure member but not to decrease it. From
https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#Common-Variable-Attributes:
"When used on a struct, or struct member, the aligned attribute can only
increase the alignment; in order to decrease it, the packed attribute
must be specified as well."

Additionally, there is a recommendation in
Documentation/process/coding-style.rst not to introduce new typedefs.

> Except for a couple exceptions IBA mads are always aligned to 4 bytes,
> only the 64 bit quantities are unaligned.
> 
> But really this whole thing should be replaced with the IBA_FIELD
> macros like include/rdma/ibta_vol1_c12.h demos.
> 
> Then it would be sparse safe and obviously endian correct as well.

I prefer a structure over the IBA_FIELD macros so I will change __packed
into __packed __aligned(4).

Thanks,

Bart.
