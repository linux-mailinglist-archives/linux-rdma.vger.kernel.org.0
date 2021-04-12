Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAA835D08F
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 20:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhDLSqt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 14:46:49 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:36857 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhDLSqt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Apr 2021 14:46:49 -0400
Received: by mail-pl1-f182.google.com with SMTP id z22so1736421plo.3;
        Mon, 12 Apr 2021 11:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vcItvP+D3zSStRplIFNHtMhB1YUVoDKJ32Fpdqg9L38=;
        b=KWycIMvRDimy2On2YYi1yq8GnsC7GedEDJCqBb/yVWr8M0PWSkOOAf12CEdGXbbyfw
         FTyNP4BjNTs2JqxhQ++Zyd03i5fsL5Pfrp1HaFST9pnj6MXIz0aaLUUoexqqiIpjmkPO
         3od8aIqIH51MIMtzj4AGv6Gz87ghdHgoWIVf9Or6d+oZl5iOtGN9c6siwZD7pYTAA7/P
         fPoYRucObGgTkG8taFLK/Xz8ZUDtxI30SdLDBvdPw5+Xr5dkBW/GPHLK1N6VxGeuKGVn
         qF+W9tNIoaaMnSVFKCuw8JSyRLTKvzcKFSOL1PSDjUfbLRDTxN567lEv5jExKN+PG7le
         X7Bg==
X-Gm-Message-State: AOAM533XLIf0dxLby+Z4iaFHR/2bcLjT6M+WXsknNDKB/lxgMnqV5vMI
        E60ZNQ1C4DC2Vt4G93Ig/1c=
X-Google-Smtp-Source: ABdhPJxKXrfS3Fw4UAVYiiQCh0lgOugJIw2p/QnehBlfiw0EWZsC8abs2bSJQfKosNM4L1bNX+RYNA==
X-Received: by 2002:a17:90b:1bcc:: with SMTP id oa12mr592191pjb.77.1618253189069;
        Mon, 12 Apr 2021 11:46:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:5f68:b2bd:8704:6a68? ([2601:647:4000:d7:5f68:b2bd:8704:6a68])
        by smtp.gmail.com with ESMTPSA id x12sm132375pjk.53.2021.04.12.11.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 11:46:28 -0700 (PDT)
Subject: Re: [PATCH -next] RDMA/srpt: Fix error return code in
 srpt_cm_req_recv()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Wang Wensheng <wangwensheng4@huawei.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.xiang@huawei.com
References: <20210408113132.87250-1-wangwensheng4@huawei.com>
 <241d391f-2f18-18e5-9e3f-3cf214a30b38@acm.org>
 <20210412180904.GA1152997@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <966eef91-0eee-beea-b927-7a4aa1b8fbd4@acm.org>
Date:   Mon, 12 Apr 2021 11:46:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210412180904.GA1152997@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/12/21 11:09 AM, Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 09:50:30AM -0700, Bart Van Assche wrote:
>> On 4/8/21 4:31 AM, Wang Wensheng wrote:
>>> Fix to return a negative error code from the error handling
>>> case instead of 0, as done elsewhere in this function.
>>>
>>> Fixes: db7683d7deb2 ("IB/srpt: Fix login-related race conditions")
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
>>>  drivers/infiniband/ulp/srpt/ib_srpt.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>> index 98a393d..ea44780 100644
>>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>> @@ -2382,6 +2382,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>>>  		pr_info("rejected SRP_LOGIN_REQ because target %s_%d is not enabled\n",
>>>  			dev_name(&sdev->device->dev), port_num);
>>>  		mutex_unlock(&sport->mutex);
>>> +		ret = -EINVAL;
>>>  		goto reject;
>>>  	}
>>
>> Please fix the Hulk Robot. The following code occurs three lines above
>> the modified code:
>>
>> 	ret = -EINVAL;
> 
> That is a different if.
> 
> The patch looks correct to me, please check again:
> 
> 	ret = srpt_create_ch_ib(ch);
> 	if (ret) {
> 	// Ret is proven to be 0
> 	
> 	[..]
> 
> 	if (!sport->enabled) {
> 		rej->reason = cpu_to_be32(
> 				SRP_LOGIN_REJ_INSUFFICIENT_RESOURCES);
> 		pr_info("rejected SRP_LOGIN_REQ because target %s_%d is not enabled\n",
> 			dev_name(&sdev->device->dev), port_num);
> 		goto reject; // Ret is 0
> 
> If there is an assignment to ret between those two blocks it is hidden..

Right, I was looking at another if-statement in the same function.

Bart.

