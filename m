Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D59FDAFA6B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 12:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfIKKd0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Sep 2019 06:33:26 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36171 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfIKKd0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Sep 2019 06:33:26 -0400
Received: by mail-wm1-f42.google.com with SMTP id p13so2875564wmh.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2019 03:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7knEBOdxE/Oatmmrq71GMKaans71qotvn/Hbk/+PLd4=;
        b=tt5Sde1cZSfY1cFfQ9+QRi0l1LcYve1jQH80UGmL2BNfzVokUlnHpXqPkcONfsCs+k
         zME0fHMHi1bsQ+/sufOFByj1BfFGe+m+GCfDtLeEkEMLib/ldMLk0cxl2X5gOs5bEpkS
         Ca5YDAbNk2wzx9XFh2bwjKbMPts68g8qUyt6sIIXVZ6Ft+GHITRI9TmmCzfFJO621BzX
         uEndz+c+bSdPS0GFTl5H11n2B1g3KnO0ZXjMnX9oKnKk+TvoA6pvF5tlyPyd5KdI9uu6
         +7Y4LcgrOu64pMe3vYtjzlMCAG1n3K/x6SDHU0BfkZxQGE4TUvb+XO2kjepy77baz1vW
         0RJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7knEBOdxE/Oatmmrq71GMKaans71qotvn/Hbk/+PLd4=;
        b=lsFrMVbzdgr+IUrQTBU0dZMP8G5ngXB6Q5gJWrOwwfXZF+PK5J2olaNPipiOty1Sbn
         8o8ZtssYHeh88S69MuPTNKbOJSE0RmzKFrk96TnenElz3PbZU/TY8m4lDjsJsdiyw5vL
         L/O/tEZsq0gHITel/K277TwrmS7epK6GGTo3F6OLn7yTVfdj/bfhdCtEzkS+bmmDDJZS
         6nVHr6+qEnNCem59bk/c+oHrxd1JkHH5AgArnzT+SpnjK3O01pNETslzdW254oyd/Ltx
         +KIg0gq5V9zI45/TZMaHEk3SjF7czYEVn8LhQ+BztLmhqbmGXdhcXL8Ht2gVZuxwS28Z
         di2A==
X-Gm-Message-State: APjAAAXAs5PVmc8iFm1qdhqalwRTQFZNc/R68IrET4GFsefAU+zMyVpG
        fa6UUnNc/PHcPlAQkkNoYjGjtw==
X-Google-Smtp-Source: APXvYqy9BruRnefYmX/F2YOPhyjDjIT5rJDHY6qmuBR0Vvugbil9mBHJREIYI6zWwpIgWsw6Bbld9w==
X-Received: by 2002:a1c:3904:: with SMTP id g4mr3527789wma.116.1568198003068;
        Wed, 11 Sep 2019 03:33:23 -0700 (PDT)
Received: from [10.80.0.217] ([193.47.165.251])
        by smtp.googlemail.com with ESMTPSA id f66sm3489008wmg.2.2019.09.11.03.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 03:33:22 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOOAkEJ1Z1JlcG9ydOOAkWlidl9zcnFfcGluZ3BvbmcgdGVzdCBi?=
 =?UTF-8?Q?ug?=
To:     oulijun <oulijun@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "roland@topspin.com" <roland@topspin.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
References: <36d848a6254b46c097b94046e3569fac@huawei.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <11ddbfb0-cefb-623a-a0bd-a1fa14cf7c96@dev.mellanox.co.il>
Date:   Wed, 11 Sep 2019 13:33:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <36d848a6254b46c097b94046e3569fac@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/11/2019 10:26 AM, oulijun wrote:
> Hi, Roland Dreier and others
> 
>            I am using ibv_srq_pingpong to test based on hip08. The test 
> result as follows:
> 
>            local address:  LID 0x0000, QPN 0x0000ff, PSN 0xdca3b1, GID ::
> 
>            local address:  LID 0x0000, QPN 0x000100, PSN 0xf62247, GID ::
> 
>            local address:  LID 0x0000, QPN 0x000101, PSN 0x7de385, GID ::
> 
>            local address:  LID 0x0000, QPN 0x000102, PSN 0xc5fcf0, GID ::
> 
>           local address:  LID 0x0000, QPN 0x000103, PSN 0x3e0843, GID ::
> 
>            local address:  LID 0x0000, QPN 0x000104, PSN 0x320be9, GID ::
> 
>            local address:  LID 0x0000, QPN 0x000105, PSN 0xb82994, GID ::
> 
>            local address:  LID 0x0000, QPN 0x000106, PSN 0xf9e7fd, GID ::
> 
>            local address:  LID 0x0000, QPN 0x000107, PSN 0xdfee5d, GID ::
> 
>            local address:  LID 0x0000, QPN 0x000108, PSN 0x02891b, GID ::
> 
>            local address:  LID 0x0000, QPN 0x000109, PSN 0x37d823, GID ::
> 
>            local address:  LID 0x0000, QPN 0x00010a, PSN 0x75397a, GID ::
> 
>            local address:  LID 0x0000, QPN 0x00010b, PSN 0x0e02de, GID ::
> 
>            local address:  LID 0x0000, QPN 0x00010c, PSN 0x7e9633, GID ::
> 
>            local address:  LID 0x0000, QPN 0x00010d, PSN 0x5b4a75, GID ::
> 
>            local address:  LID 0x0000, QPN 0x00010e, PSN 0xe9a195, GID ::
> 
> Failed to modify QP[0] to RTR
>

As of the below trace it looks as you are using RoCE, correct ? if so, 
you need to supply a gid in the command line (e.g -g 0).

> Couldn't connect to remote QP
> 
>            I am targeting as follows:
> 
>            When called the ibv_modify_qp run and it will trace as follows:
> 
> static int rdma_check_ah_attr(struct ib_device *device,
> 
> 409                               struct rdma_ah_attr *ah_attr)
> 
> 410 {
> 
> 411         if (!rdma_is_port_valid(device, ah_attr->port_num))
> 
> 412                 return -EINVAL;
> 
> 413         printk("[%s, %d] point!\n", __func__, __LINE__);
> 
> 414         printk("[%s, %d] rdma_is_grh_required(device, 
> ah_attr->port_num) = %d\n",
> 
> 415                 __func__, __LINE__, rdma_is_grh_required(device, 
> ah_attr->port_num));
> 
> 416         printk("[%s, %d] ah_attr->type = %d!\n", __func__, __LINE__, 
> ah_attr->type);
> 
> 417         printk("[%s, %d] ah_attr->ah_flags = %d!\n", __func__, 
> __LINE__, ah_attr->ah_flags);
> 
> 418         if ((rdma_is_grh_required(device, ah_attr->port_num) ||
> 
> 419              ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE) &&
> 
> 420             !(ah_attr->ah_flags & IB_AH_GRH))
> 
> 421                 return -EINVAL;
> 
> 422         printk("[%s, %d] point!\n", __func__, __LINE__);
> 
> 423         if (ah_attr->grh.sgid_attr) {
> 
> 424                 /*
> 
> 425                  * Make sure the passed sgid_attr is consistent with the
> 
> 426                  * parameters
> 
> 427                  */
> 
> 428                 if (ah_attr->grh.sgid_attr->index != 
> ah_attr->grh.sgid_index ||
> 
> 429                     ah_attr->grh.sgid_attr->port_num != 
> ah_attr->port_num)
> 
> 430                         return -EINVAL;
> 
> 431         }
> 
> 432         printk("[%s, %d] point!\n", __func__, __LINE__);
> 
> 433         return 0;
> 
> When trace at 420 lines, it will return fail.  I don’t understand the 
> lines. Because it should be right  when run roce mode.
> 
> The ah_attr->ah_flags is RDMA_AH_ATTR_TYPE_ROCE and ah_attr->ah_flags 
> should be IB_AH_GRH
> 
> However the value of ah_attr->ah_flags is 2.  I think that the value of 
> attr->ah_flags should have a protocol layer guarantee
> 
> So, I doubt that the protocol layer or ibv_srq_pingpong have an achieve 
> defects
> 
> At the same time I used ibv_srq_pingpong to test on cx5,  the result is 
> the same:
> 
> root@ubuntu-51-7:~# ibv_srq_pingpong -d mlx5_0 -p 10002
> 
>    local address:  LID 0x0000, QPN 0x0000ff, PSN 0xdca3b1, GID ::
> 
>    local address:  LID 0x0000, QPN 0x000100, PSN 0xf62247, GID ::
> 
>    local address:  LID 0x0000, QPN 0x000101, PSN 0x7de385, GID ::
> 
>    local address:  LID 0x0000, QPN 0x000102, PSN 0xc5fcf0, GID ::
> 
>    local address:  LID 0x0000, QPN 0x000103, PSN 0x3e0843, GID ::
> 
>    local address:  LID 0x0000, QPN 0x000104, PSN 0x320be9, GID ::
> 
>    local address:  LID 0x0000, QPN 0x000105, PSN 0xb82994, GID ::
> 
>    local address:  LID 0x0000, QPN 0x000106, PSN 0xf9e7fd, GID ::
> 
>    local address:  LID 0x0000, QPN 0x000107, PSN 0xdfee5d, GID ::
> 
>    local address:  LID 0x0000, QPN 0x000108, PSN 0x02891b, GID ::
> 
>    local address:  LID 0x0000, QPN 0x000109, PSN 0x37d823, GID ::
> 
>    local address:  LID 0x0000, QPN 0x00010a, PSN 0x75397a, GID ::
> 
>    local address:  LID 0x0000, QPN 0x00010b, PSN 0x0e02de, GID ::
> 
>    local address:  LID 0x0000, QPN 0x00010c, PSN 0x7e9633, GID ::
> 
>    local address:  LID 0x0000, QPN 0x00010d, PSN 0x5b4a75, GID ::
> 
>    local address:  LID 0x0000, QPN 0x00010e, PSN 0xe9a195, GID ::
> 
> Failed to modify QP[0] to RTR
> 
> Couldn't connect to remote QP
> 
> Thanks
> 
> Lijun Ou
> 

