Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312DD52AC28
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 21:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiEQTmu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 15:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiEQTms (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 15:42:48 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4E22655D
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 12:42:46 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id r35enso0WEMbDr35enGE51; Tue, 17 May 2022 21:42:44 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 17 May 2022 21:42:44 +0200
X-ME-IP: 86.243.180.246
Message-ID: <301a1d0a-971b-5b27-c5a9-86390358de9a@wanadoo.fr>
Date:   Tue, 17 May 2022 21:42:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] RDMA: remove null check after call container_of()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haowen Bai <baihaowen@meizu.com>
Newsgroups: gmane.linux.drivers.rdma,gmane.linux.kernel
References: <1652751208-23211-1-git-send-email-baihaowen@meizu.com>
 <20220517121646.GE63055@ziepe.ca>
 <142a9c03-574f-adcf-bc4d-bb2a25c01e88@wanadoo.fr>
 <20220517180303.GK63055@ziepe.ca>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220517180303.GK63055@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Le 17/05/2022 à 20:03, Jason Gunthorpe a écrit :
> On Tue, May 17, 2022 at 07:54:38PM +0200, Christophe JAILLET wrote:
>> Le 17/05/2022 à 14:16, Jason Gunthorpe a écrit :
>>> On Tue, May 17, 2022 at 09:33:28AM +0800, Haowen Bai wrote:
>>>> container_of() will never return NULL, so remove useless code.
>>>
>>> It is confusing here, but it can be null.
>>
>> Hi,
>>
>> out of curiosity, can you elaborate how it can be NULL?
> 
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
> 

Crystal clear.
Thank you for the explanation.

CJ
