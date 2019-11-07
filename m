Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5933F2BE4
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2019 11:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfKGKLp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Nov 2019 05:11:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34730 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfKGKLp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Nov 2019 05:11:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id v3so4483318wmh.1
        for <linux-rdma@vger.kernel.org>; Thu, 07 Nov 2019 02:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qC7NL62biyzzrxZrsAxpwfOJvcnvnenKvBa/4Ebiicw=;
        b=Wzdv+VbqO5ZwQjh2/e1acUjRfog0dmAELNT+YaqN0Q04PG2H52266JG3xpfe0gOQCV
         mbCWXL6Y3Q4RogDL9gjmOhwv0liyHiSkhkqX1WJeX3wRuEVdBOkx3fPkmz0DmQxQnTpV
         XieiYqpE0X2x0SOehcJJak8kzZCWdzgrU1c1ve19uc2HKA6qBA5EwELAs85rvyUMUL8V
         hcq2lClmsUWXDDsCOqOPuaY9bS8rmUHTwGBIog2Hyq/+UcjOJIMe44ngCR5sQmJ8YOia
         vEYuLNeSddL+whkvqS657xaxL2cQJn/ya4/v3SdMoF2p1cF9n80BGs0Eb2YgmAeTZzy0
         UPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qC7NL62biyzzrxZrsAxpwfOJvcnvnenKvBa/4Ebiicw=;
        b=ZoDoOTUg5MX0sVtQfDvF4uGak8oU86ahEmDR65Xmp0JSK+kfYct/swMyfY1JjXLDgN
         sA6J0x5r6hcMbrwmq8454VZuoSqtTAbwqfXrq/OwjYCGEgXtyFk1iG2n8TL3cBm/5oPb
         qUHDAlNHus8gsq1cEe/mZWrx6gYBr1+vU5JFTqbfU0+QgAx5rd3rHZ75uWe8OcRXnPqj
         pMVzRNCzmiGUwDlRktPkLCdJZck5V6tdr7ptNs+tgpai4M3m2N11ebiMPblxjJ//FkDy
         F1fiOjiYCpmcDgOeL5Ar8izMJ3iHkMKfpSLo/4ArvUzf1xp+55ZuXpU0gekQQTcp2x8K
         Twew==
X-Gm-Message-State: APjAAAWO/qGIcQDsAlwoghc9afRnaZzykr1vfnoR46vSrftE8npQxBP9
        MOoPWiTM3DJJVitZSHUlgejN5g==
X-Google-Smtp-Source: APXvYqzgZL0TOeh3Rubyg4NQjzYzjkepTHNkC8vakGBXI0WHiPmxQyL1EEBE/X9RPJmZsKMbYzMGVQ==
X-Received: by 2002:a7b:c0da:: with SMTP id s26mr2035904wmh.6.1573121502034;
        Thu, 07 Nov 2019 02:11:42 -0800 (PST)
Received: from [10.80.2.221] ([193.47.165.251])
        by smtp.googlemail.com with ESMTPSA id j15sm2152931wrt.78.2019.11.07.02.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 02:11:41 -0800 (PST)
Subject: Re: [PATCH rdma-next v2] IB/mlx5: Support flow counters offset for
 bulk counters
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yevgeny Kliteynik <kliteyn@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
References: <20191103140723.77411-1-leon@kernel.org>
 <20191106202118.GA26024@ziepe.ca>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <f4814cd9-598d-2957-4aa3-5b12b1c54d25@dev.mellanox.co.il>
Date:   Thu, 7 Nov 2019 12:11:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106202118.GA26024@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/6/2019 10:21 PM, Jason Gunthorpe wrote:
> On Sun, Nov 03, 2019 at 04:07:23PM +0200, Leon Romanovsky wrote:
>> diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
>> index d0da070cf0ab..20d88307f75f 100644
>> +++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
>> @@ -198,6 +198,7 @@ enum mlx5_ib_create_flow_attrs {
>>   	MLX5_IB_ATTR_CREATE_FLOW_ARR_FLOW_ACTIONS,
>>   	MLX5_IB_ATTR_CREATE_FLOW_TAG,
>>   	MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX,
>> +	MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET,
>>   };
> 
> Where is the rdma-core PR consuming this new uapi?

Below is the matching PR for this in rdma-core:
https://github.com/linux-rdma/rdma-core/pull/611

Yishai
