Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD4A123759
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2019 21:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfLQUer (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Dec 2019 15:34:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47057 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfLQUer (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Dec 2019 15:34:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id y14so8190454pfm.13;
        Tue, 17 Dec 2019 12:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wSq9UbcGgrIcyy3/grTcN0ygIwYk8X1gs2WW24q9oC0=;
        b=lMD0ScupWcjKNnbYN13LhCm9VscP5bWyv7WXGD6i+z065FfB1RJhNegwwViuIKtoup
         gvhWKL5RmgvLNUtFGmK4zJi0tQxyF/m8XvP2sR8jKHUTnEznqP+BxIaNN9oQcq6ihm0p
         c4k3Us7VrVkvoZ6YimESfmbwnT4XGejbVsFRTj7FY4grn25eJlpjZNMq3zjyBXTv3BXR
         /eE6V0OsvsOGlCyhdGaBgorcHrsbMHHsCFUWm0R1XUN4VkRs/nxI+3+Rexws9e+ZkrlP
         vgjP8okFGFYMckVcO0lne2myenOYUB/CL7CdtRRxEtBSEQNY3+0uas0ddzPhwQnEKciM
         FB0Q==
X-Gm-Message-State: APjAAAV8oPW23w0stumBM3uJEz9IEG28Mqc2HM7Rvp1FwdXyd7Tph8wa
        7gyTlVo0Pgv/OIQSGZfxQ1aMDK/e
X-Google-Smtp-Source: APXvYqyj04KjYuMr2anPYYyDvo+WXIBzNftZyx76p4OnHJyZYgCmLdczh5pSK40fCAxyDOkQqY/R4w==
X-Received: by 2002:a62:3045:: with SMTP id w66mr25058374pfw.122.1576614886243;
        Tue, 17 Dec 2019 12:34:46 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id v29sm27184456pgl.88.2019.12.17.12.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 12:34:45 -0800 (PST)
Subject: Re: [PATCH v2] scsi: RDMA/srpt: remove unnecessary assertion in
 srpt_queue_response
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191217194437.25568-1-pakki001@umn.edu>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d497d620-9aff-616c-67ae-bfb93f39b926@acm.org>
Date:   Tue, 17 Dec 2019 12:34:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217194437.25568-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/17/19 11:44 AM, Aditya Pakki wrote:
> Currently, BUG_ON in srpt_queue_response, is used as an assertion for
> empty rdma channel. However, if the channel is NULL, the call trace
> on console is sufficient for diagnosis.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
> v1: Avoid potential NULL pointer derefernce of ch. Current fix
> suggested by Bart Van Assche
> ---
>   drivers/infiniband/ulp/srpt/ib_srpt.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 23c782e3d49a..98552749d71c 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2810,8 +2810,6 @@ static void srpt_queue_response(struct se_cmd *cmd)
>   	int resp_len, ret, i;
>   	u8 srp_tm_status;
>   
> -	BUG_ON(!ch);
> -
>   	state = ioctx->state;
>   	switch (state) {
>   	case SRPT_STATE_NEW:

I think the description of this patch should also mention that this 
patch removes a check of a pointer after it has already been 
dereferenced. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
