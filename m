Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CD75EEDCC
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 08:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiI2GVo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 02:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiI2GVe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 02:21:34 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A3812E433;
        Wed, 28 Sep 2022 23:21:30 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="78367777"
X-IronPort-AV: E=Sophos;i="5.93,354,1654527600"; 
   d="scan'208";a="78367777"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 29 Sep 2022 15:21:27 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 01E1ED6188;
        Thu, 29 Sep 2022 15:21:27 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1892614428;
        Thu, 29 Sep 2022 15:21:26 +0900 (JST)
Received: from [10.167.226.45] (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id BB0632340193;
        Thu, 29 Sep 2022 15:21:24 +0900 (JST)
Message-ID: <942fdca3-2cd4-88d2-033c-6bd3f7bb258a@fujitsu.com>
Date:   Thu, 29 Sep 2022 14:21:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [for-next PATCH v5 03/11] RDMA: Extend RDMA kernel verbs ABI to
 support flush
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <20220927055337.22630-4-lizhijian@fujitsu.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <20220927055337.22630-4-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27170.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27170.005
X-TMASE-Result: 10--20.671100-10.000000
X-TMASE-MatchedRID: 6Yvl3or3fgqPvrMjLFD6eK5i3jK3KDOoC/ExpXrHizyOVdQAiMmbZ9E0
        8LKMDwXN0tx5yJ6Gw/oT8ltSZlOY+c2IoAvAG8CyqdwbW9Wx9tDdKRNjzo2IOExqTmWcX8+mPf4
        Utpl5n+5+oRU2JbGSkcs9w9Jzk12Mdi55gM/Zl20D2WXLXdz+ARgff28UuvITZ8i/MdLSpTt8Uw
        gzqe5YiFbNzmg4PDkRbT4Iw1SEvyXZOqUR+8hSwBmiTJb38WResk61leL8Ml/cOLFESLah/bTLc
        NrcH2Gr585VzGMOFzABi3kqJOK62b+/RSFMoL2cxEHRux+uk8jpP8tMOyYmaA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Leon, Jason


On 27/09/2022 13:53, Li Zhijian wrote:
>   /*
> @@ -4321,6 +4330,8 @@ int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata);
>   static inline int ib_check_mr_access(struct ib_device *ib_dev,
>   				     unsigned int flags)
>   {
> +	u64 device_cap = ib_dev->attrs.device_cap_flags;
> +
>   	/*
>   	 * Local write permission is required if remote write or
>   	 * remote atomic permission is also requested.
> @@ -4335,6 +4346,13 @@ static inline int ib_check_mr_access(struct ib_device *ib_dev,
>   	if (flags & IB_ACCESS_ON_DEMAND &&
>   	    !(ib_dev->attrs.kernel_cap_flags & IBK_ON_DEMAND_PAGING))
>   		return -EINVAL;
> +
> +	if ((flags & IB_ACCESS_FLUSH_GLOBAL &&
> +	    !(device_cap & IB_DEVICE_FLUSH_GLOBAL)) ||
> +	    (flags & IB_ACCESS_FLUSH_PERSISTENT &&
> +	    !(device_cap & IB_DEVICE_FLUSH_PERSISTENT)))
> +		return -EINVAL;
> +
Regarding of the return value of ib_check_mr_access. While updating the man page of ibv_reg_mr(3) of rdma-core,
```
        IBV_ACCESS_REMOTE_READ Enable Remote Read Access
        IBV_ACCESS_REMOTE_ATOMIC Enable Remote Atomic Operation Access (if supported)
        IBV_ACCESS_MW_BIND Enable Memory Window Binding
        IBV_ACCESS_ZERO_BASED  Use  byte offset from beginning of MR to access this MR, instead of a pointer address
        IBV_ACCESS_ON_DEMAND Create an on-demand paging MR (if supported)
...
RETURN VALUE
        ibv_reg_mr() / ibv_reg_mr_iova() / ibv_reg_dmabuf_mr() returns a pointer to the registered MR, or NULL if the request fails.  The local key (L_Key) field lkey is used as the lkey field of struct  ibv_sge  when  posting
        buffers  with  ibv_post_* verbs, and the the remote key (R_Key) field rkey is used by remote processes to perform Atomic and RDMA operations.  The remote process places this rkey as the rkey field of struct ibv_send_wr
        passed to the ibv_post_send function.
```
we can see, IBV_ACCESS_REMOTE_ATOMIC and IBV_ACCESS_ON_DEMAND are tagged "if supported" . but currently kernel
just returns EINVAL when user registers a MR with IB_ACCESS_ON_DEMAND to RXE.

I wonder we should return -EOPNOTSUPP if the device doesn't support requested capabilities

Thanks
Li


>   	return 0;
>   }
>   

