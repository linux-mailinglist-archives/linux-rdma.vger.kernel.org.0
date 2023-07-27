Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E07652D8
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 13:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjG0Lrt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 07:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjG0Lrt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 07:47:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49231271F;
        Thu, 27 Jul 2023 04:47:40 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RBTTT4RSGzLnsJ;
        Thu, 27 Jul 2023 19:45:01 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 19:47:37 +0800
Subject: Re: [PATCH net-next v2] page_pool: split types and declarations from
 page_pool.h
To:     Jakub Kicinski <kuba@kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
CC:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20230725131258.31306-1-linyunsheng@huawei.com>
 <ZL/fVF7WetuLgB0l@hera> <20230725141223.19c1c34c@kernel.org>
 <a5d91458-d494-6000-7607-0f17c4461b6e@intel.com>
 <20230726084742.7dc67c79@kernel.org>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <d6dd7cb3-5d06-cc1d-ff0d-6933cb9994b9@huawei.com>
Date:   Thu, 27 Jul 2023 19:47:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230726084742.7dc67c79@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/7/26 23:47, Jakub Kicinski wrote:
> On Wed, 26 Jul 2023 12:48:05 +0200 Alexander Lobakin wrote:
>>> I prefer the more systematic approach of creating a separate types.h
>>> file, so I don't have to keep chasing people or cleaning up the include
>>> hell myself. I think it should be adopted more widely going forward,
>>> it's not just about the page pool.  
>>
>> I have this patch reworked to introduce
>> include/net/page_pool/{types,helpers}.h in my tree, maybe someone could
>> take a quick look[0] and say if this works while I'm preparing the next
>> version for sending? Not the most MLish way, I know :s
>>
>> [0]
>> https://github.com/alobakin/linux/commit/19741ee072c32eb1d30033cd4fcb236d1c00bfbf
> 
> LGTM!

Hi, Alexander
It seems you have taken it and adjust it accordingly, do you mind sending
the next version along with your patchset, so that there is less patch
conflict for both of us:)

> 
> .
> 
