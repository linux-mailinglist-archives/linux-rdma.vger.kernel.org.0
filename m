Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 276E9EE45C
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 17:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfKDQB3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 11:01:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44307 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDQB3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Nov 2019 11:01:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id q26so12443386pfn.11
        for <linux-rdma@vger.kernel.org>; Mon, 04 Nov 2019 08:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FGRE69HJLJ5sOxkaX5jFXWyvH+YsnLjTexSkOMG8en4=;
        b=BOcc24ld3mLlj3eyBdpJLoOrLOn3FYUsO+sWIekZb3STENjYU4sRJKkX3QNjbjlzAZ
         OBhK/lLdzJGm3yjdY+97IYkdB6YB7z6poZv6Wzkc0f3q9f6D4kIuqxJJGrhSLjg+TKqY
         0Q9n4J5q8PUntlckSM6Hyf7wAmgWmQ09jgbLgbtbIZr3+20tD74YRNnBkSCusos6se4f
         md+atxs2ULWrRb62xkPEoxxv6A6im5dQ8Q2rMi/jDiqPpsEjVeIxhbnR8oVnfGXx/fPB
         e7B7oZuSfS7yUeFAMHSdSALLUhdaHCqxUUR7ChS5r3PyXgc6r0BkA6KxThi4NDMHkWKt
         yjWA==
X-Gm-Message-State: APjAAAX+T4+FPGyhfFayYb0TlttwLZvcy7TE6mZZUdCjvTzPBZiUtjqj
        +yM3GXIgV3wc/xd3EJzgRBhtxj6a
X-Google-Smtp-Source: APXvYqyM8KSbQctIn7MCKKYpZsXK7DLmfbTZ9UMP1wqd8b62egVmqu9eZdqkEcR56XCyigByT+p1Nw==
X-Received: by 2002:a62:4e96:: with SMTP id c144mr31773284pfb.45.1572883288417;
        Mon, 04 Nov 2019 08:01:28 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id x10sm11920435pfn.36.2019.11.04.08.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 08:01:27 -0800 (PST)
Subject: Re: [PATCH] RDMA/srpt: Report the SCSI residual to the initiator
To:     Honggang LI <honli@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>
References: <20191029230257.210897-1-bvanassche@acm.org>
 <20191104111024.GA31820@dhcp-128-227.nay.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <489e72c9-dc15-f5af-81e6-b4f448323947@acm.org>
Date:   Mon, 4 Nov 2019 08:01:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104111024.GA31820@dhcp-128-227.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/4/19 3:10 AM, Honggang LI wrote:
> On Tue, Oct 29, 2019 at 04:02:57PM -0700, Bart Van Assche wrote:
>> The code added by this patch is similar to the code that already exists
>> in ibmvscsis_determine_resid(). This patch has been tested by running
>> the following command:
>>
>> strace -f sg_raw -r 1k /dev/sdb 12 00 00 00 60 00 -o inquiry.bin |&
>>      grep resid=
>>
>> Cc: Honggang LI <honli@redhat.com>
>> Cc: Laurence Oberman <loberman@redhat.com>
>> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   drivers/infiniband/ulp/srpt/ib_srpt.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> index a278e76b9e02..c9972b686c27 100644
>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> @@ -1362,9 +1362,11 @@ static int srpt_build_cmd_rsp(struct srpt_rdma_ch *ch,
>>   			      struct srpt_send_ioctx *ioctx, u64 tag,
>>   			      int status)
>>   {
>> +	struct se_cmd *cmd = &ioctx->cmd;
>>   	struct srp_rsp *srp_rsp;
>>   	const u8 *sense_data;
>>   	int sense_data_len, max_sense_len;
>> +	int resid = cmd->residual_count;
>          ^^^
> Should be u32?	

Since se_cmd.residual_count has been declared as u32 it's probably 
better to declare this variable as u32 too. I will make that change and 
post a v2.

Thanks,

Bart.


