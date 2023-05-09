Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6726FBC22
	for <lists+linux-rdma@lfdr.de>; Tue,  9 May 2023 02:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjEIAvM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 May 2023 20:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEIAvL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 May 2023 20:51:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BE24C02;
        Mon,  8 May 2023 17:51:09 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QFfh404RszpWF8;
        Tue,  9 May 2023 08:49:56 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 9 May
 2023 08:51:07 +0800
Subject: Re: [PATCH RFC 2/2] net: remove __skb_frag_set_page()
To:     Simon Horman <simon.horman@corigine.com>
CC:     <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <xen-devel@lists.xenproject.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <alexanderduyck@fb.com>, <jbrouer@redhat.com>,
        <ilias.apalodimas@linaro.org>
References: <20230508123922.39284-1-linyunsheng@huawei.com>
 <20230508123922.39284-3-linyunsheng@huawei.com>
 <ZFkHulUs7d1xWKSa@corigine.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <ca5dabb4-d875-7845-553f-915b3ce85be1@huawei.com>
Date:   Tue, 9 May 2023 08:51:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <ZFkHulUs7d1xWKSa@corigine.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/5/8 22:31, Simon Horman wrote:
> On Mon, May 08, 2023 at 08:39:22PM +0800, Yunsheng Lin wrote:
>> The remaining users calling __skb_frag_set_page() with
>> page being NULL seems to doing defensive programming, as
>> shinfo->nr_frags is already decremented, so remove them.
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index efaff5018af8..f3f08660ec30 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -1105,7 +1105,6 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
>>  			unsigned int nr_frags;
>>  
>>  			nr_frags = --shinfo->nr_frags;
> 
> Hi Yunsheng,
> 
> nr_frags is now  unused, other than being set on the line above.
> Probably this local variable can be removed.

Yes, will remove that.
Thanks.
