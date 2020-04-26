Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721DF1B91A7
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2020 18:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgDZQXY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Apr 2020 12:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726146AbgDZQXX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Apr 2020 12:23:23 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925BEC061A0F
        for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2020 09:23:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z6so17590033wml.2
        for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2020 09:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YKamrB0C22aNJfSqVoHJLm7gH95Tt42/hdFe5rK2cHU=;
        b=sKEVH5Hgz9yWKfTbXQ+KSVxJ9I5zV71xGIIj5F0MGM880xbBcNrbfmUFKysNj0Lss7
         6xfL1D0oY6wPJm14O0Mk6AZ5zt7FrtnP/6cGOV121n3LGd5/DFtzLWgiV3IKNkEtq1ov
         KBi/yAO4hdvWzs9LASunSEMkm1Jd8EaEucK6SvcbmArYHnMXRDvszTqoBQUiuF4A3HLw
         6tb/vODTs5jkGap3yYbBImdFfNzuh4m5PRrmEMMsrC3xSwh87oejAQpCSd0NI14Mc19Q
         zRZ01BZ801JS07Znll/kFoLf55hQeUHfQ3O1Clmr1uLW3f09h9nKxWtKltUdryH9gl0r
         Zcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YKamrB0C22aNJfSqVoHJLm7gH95Tt42/hdFe5rK2cHU=;
        b=Y9wQZ4tyxADtXh818uN2/qlj9CdTeRMjlrpIopUXW0+DwL5s07HGFdK25q3cLEN448
         oUl0sdMWeC9s8Hcx0sEQNWXoQEw8fv+RzI5PlwXlqAsYudT4w0x42DhQzCg0cszq50zK
         1C/nVIxJflyApMryAsLK4AM6owb7emhzjH8UbeTfjthgCDn2A/A58yfhcQWe5gl90gXO
         SoVNMdzm4WZr0+QXvbOQkeSB4c2owNRaFPgNeoK0DKXYUAfQoLpBsSxu7baKrMVjezUw
         PzgoBUMDhG2sxQ+BZiqyOygj4s4VC3WbUxlEP1my7qcjF+ANabFTHpit2/aoThAE3ODT
         6UIg==
X-Gm-Message-State: AGi0PubfZcuWVhCcLnx7Tt2BoEwlRv/pfBeEYSJMOOUEvuJIDX6gyJrL
        p7YUUyhscleqhooRAro4QW7FXA==
X-Google-Smtp-Source: APiQypJIgLJXY9yQyd8vMdjVjXxCGLv8cMw+ZMrdMaWkL/cLtwMeUnBClX6pBBusAxNfAryGw9Rzhg==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr22674760wma.78.1587918202290;
        Sun, 26 Apr 2020 09:23:22 -0700 (PDT)
Received: from [10.0.0.57] ([141.226.210.29])
        by smtp.googlemail.com with ESMTPSA id f8sm17344073wrm.14.2020.04.26.09.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 09:23:21 -0700 (PDT)
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Add support for drop action in DV
 steering
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Daria Velikovsky <daria@mellanox.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>, valex@mellanox.com
References: <20200413135328.934419-1-leon@kernel.org>
 <20200422192647.GA12235@ziepe.ca>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <9217f043-d4ad-7b1b-a10c-712be26be082@dev.mellanox.co.il>
Date:   Sun, 26 Apr 2020 19:23:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422192647.GA12235@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/22/2020 10:26 PM, Jason Gunthorpe wrote:
> On Mon, Apr 13, 2020 at 04:53:28PM +0300, Leon Romanovsky wrote:
>> From: Daria Velikovsky <daria@mellanox.com>
>>
>> When drop action is used the matching packet will stop
>> processing in steering and will be dropped. This functionality
>> will allow users to drop matching packets.
>>
>> Signed-off-by: Daria Velikovsky <daria@mellanox.com>
>> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>> ---
>>   drivers/infiniband/hw/mlx5/flow.c        | 37 +++++++++++++++---------
>>   include/uapi/rdma/mlx5_user_ioctl_cmds.h |  1 +
>>   2 files changed, 24 insertions(+), 14 deletions(-)
> 
> Where is the rdma-core part of this?
> 

I have just sent the matching PR for the rdma-core part [1].
[1] https://github.com/linux-rdma/rdma-core/pull/748

Yishai
