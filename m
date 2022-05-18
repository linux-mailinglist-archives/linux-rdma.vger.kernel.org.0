Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C0652B043
	for <lists+linux-rdma@lfdr.de>; Wed, 18 May 2022 03:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiERBzq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 21:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiERBzp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 21:55:45 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0C638D;
        Tue, 17 May 2022 18:55:40 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 18 May
 2022 09:55:38 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 18 May
 2022 09:55:38 +0800
Message-ID: <bf354eb3-2149-5faa-8ada-baa4b2f4ad09@meizu.com>
Date:   Wed, 18 May 2022 09:55:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] RDMA: remove null check after call container_of()
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1652751208-23211-1-git-send-email-baihaowen@meizu.com>
 <20220517121646.GE63055@ziepe.ca>
 <142a9c03-574f-adcf-bc4d-bb2a25c01e88@wanadoo.fr>
 <20220517180303.GK63055@ziepe.ca>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <20220517180303.GK63055@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/5/18 上午2:03, Jason Gunthorpe 写道:
> On Tue, May 17, 2022 at 07:54:38PM +0200, Christophe JAILLET wrote:
>> Le 17/05/2022 à 14:16, Jason Gunthorpe a écrit :
>>> On Tue, May 17, 2022 at 09:33:28AM +0800, Haowen Bai wrote:
>>>> container_of() will never return NULL, so remove useless code.
>>> It is confusing here, but it can be null.
>> Hi,
>>
>> out of curiosity, can you elaborate how it can be NULL?
> It is guarented/required that that container_of is a 0 offset. The
> normal usage of the ib_alloc_device macro:
>
> #define ib_alloc_device(drv_struct, member)                                    \
> 	container_of(_ib_alloc_device(sizeof(struct drv_struct) +              \
> 				      BUILD_BUG_ON_ZERO(offsetof(              \
> 					      struct drv_struct, member))),    \
> 		     struct drv_struct, member)
>
> Enforces this property with a BUILD_BUG_ON
>
> So, if the input pointer to container_of is reliably NULL or ERR_PTR
> then the output pointer will be the same.
>
> The rvt code here open codes the call because it is a mid-layer and
> the sizeof() calculation above is not correct for it.
>
> Jason
Thank you for the explanation.   : )

-- 
Haowen Bai

