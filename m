Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 174962FBA4
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 14:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfE3Mh2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 08:37:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38441 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfE3Mh2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 08:37:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id a186so3189909pfa.5;
        Thu, 30 May 2019 05:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p+DG2d0FvxKbWywBMoCSOvRR/YJEudwxtMY2Mp3L0uA=;
        b=pSN84Nueu+mX5LVWf2d3ytDynzJ6AalNM7GRwoawN35iXT7uboqC26KRaN+2xnRfIQ
         8zmRE5PLKAQ1NlF31XZdFT2YG8daPtcQU67NvQzhoQw2rFliJ6Tewd6uUkMmf5RbOgtn
         dxaSsGXAdtKrGP42uTraxeodTJEsR8fZTWgB+r2xSChO/ZajN2F+ZbUcBXpibR2xnBBB
         UFERLjWPzXQ3vJZZ/wGnYwo4eGiKMmPvSaCuKuL0C+4bKB/gvew6xRlh4jnK4p3EXIF+
         tfd6Lx/zmXq/jC2JTnk9R2QR1zhtwZzyxLKDVzsP4xbb3R3lj1Vd80ilF39ZT8OeHwS0
         5Sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p+DG2d0FvxKbWywBMoCSOvRR/YJEudwxtMY2Mp3L0uA=;
        b=KyXG8Uv6rYHm9cpja427fjYQeU9Oq4cgl9RsH4c5xlNUgY4QzPxhimWL3NLoOO84vn
         CSoVbdDzGwTxJyffuDo9bTJXRJWsBJBWGksA8OtqCz+58aPdHA3l5ZCh3xgS4OMuaPhM
         647NZBOcuJuCL88XDdhTOQLikpMrCyGqodjCVuBelOLe+6OdQcBoiolAPlspNpmt8/PK
         cBYN4DkefzPunV3qq55Cfs+yiQ0Hr7uqPecyh8soBFdkjreDVIROJqvgl7IK2hYSKx2V
         gYmTETvG2TFsOZohT8UuzfZksbQv0KpUL6bfmsjSfqjP8R3KBX98F+yD0tmthnJAe6vR
         uE/A==
X-Gm-Message-State: APjAAAVMDCe3hIDa+weV2qZyxb3PpkuHL84faoTROvJdYTv3SoBFj+O5
        2sZfRpthN3o1LN4N/RPg49Y=
X-Google-Smtp-Source: APXvYqzCXnK5vZc38a1gg6xnBIWUu0AiECzfFdovLYSOjGz8ovpq8WBP+dm4jV/kz2CuxUB7Tw/cxg==
X-Received: by 2002:a62:4e0c:: with SMTP id c12mr3461676pfb.17.1559219847373;
        Thu, 30 May 2019 05:37:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q7sm2655251pjb.0.2019.05.30.05.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 05:37:26 -0700 (PDT)
Subject: Re: [PATCH] IB/mlx5: Limit to 64-bit builds
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ariel Levkovich <lariel@mellanox.com>
References: <1559216144-2085-1-git-send-email-linux@roeck-us.net>
 <20190530122251.GD6251@mtr-leonro.mtl.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2cfc38a3-33a9-5f22-6757-189ebbb93ce6@roeck-us.net>
Date:   Thu, 30 May 2019 05:37:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530122251.GD6251@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/30/19 5:22 AM, Leon Romanovsky wrote:
> On Thu, May 30, 2019 at 04:35:44AM -0700, Guenter Roeck wrote:
>> 32-bit builds fail with errors such as
>>
>> ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> 
> It is fixed in rdma-rc.
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-rc&id=37eb86c4507abcb14fc346863e83aa8751aa4675
> 

Excellent, and sorry for the noise.

Guenter

> Thanks
> 
>>
>> Fixes: 25c13324d03d ("IB/mlx5: Add steering SW ICM device memory type")
>> Cc: Ariel Levkovich <lariel@mellanox.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/infiniband/hw/mlx5/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/mlx5/Kconfig b/drivers/infiniband/hw/mlx5/Kconfig
>> index ea248def4556..574b97da7a43 100644
>> --- a/drivers/infiniband/hw/mlx5/Kconfig
>> +++ b/drivers/infiniband/hw/mlx5/Kconfig
>> @@ -1,7 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   config MLX5_INFINIBAND
>>   	tristate "Mellanox 5th generation network adapters (ConnectX series) support"
>> -	depends on NETDEVICES && ETHERNET && PCI && MLX5_CORE
>> +	depends on NETDEVICES && ETHERNET && PCI && MLX5_CORE && 64BIT
>>   	---help---
>>   	  This driver provides low-level InfiniBand support for
>>   	  Mellanox Connect-IB PCI Express host channel adapters (HCAs).
>> --
>> 2.7.4
>>
> 

