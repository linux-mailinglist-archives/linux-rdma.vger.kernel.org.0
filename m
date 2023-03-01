Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B706A64C6
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Mar 2023 02:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCAB0l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 20:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCAB0l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 20:26:41 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009E936FFD;
        Tue, 28 Feb 2023 17:26:39 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PRGjB0PFHznWFN;
        Wed,  1 Mar 2023 09:23:58 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 09:26:36 +0800
Message-ID: <419d45a3-f106-a6f4-4f91-347af7be4f82@huawei.com>
Date:   Wed, 1 Mar 2023 09:26:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 4.19 v3 0/6] Backport handling -ESTALE policy update
 failure to 4.19
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>, <jgg@ziepe.ca>
References: <20230228080630.52370-1-guozihua@huawei.com>
 <CAHC9VhR1UxGQnsWU1bhG1_XMVfdt_j-cVZkKnQ+rjzqcEP_NHw@mail.gmail.com>
 <57ebd18a95caa0a8df9ad542478d5dca3ff5760c.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <57ebd18a95caa0a8df9ad542478d5dca3ff5760c.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/3/1 3:45, Mimi Zohar wrote:
> On Tue, 2023-02-28 at 11:25 -0500, Paul Moore wrote:
>> On Tue, Feb 28, 2023 at 3:09 AM GUO Zihua <guozihua@huawei.com> wrote:
>>>
>>> This series backports patches in order to resolve the issue discussed here:
>>> https://lore.kernel.org/selinux/389334fe-6e12-96b2-6ce9-9f0e8fcb85bf@huawei.com/
>>>
>>> This required backporting the non-blocking LSM policy update mechanism
>>> prerequisite patches. As well as bugfixes that follows:
>>>
>>> c66f67414c1f ("IB/core: Don't register each MAD agent for LSM notifier")
>>> 42df744c4166 ("LSM: switch to blocking policy update notifiers")
>>> b16942455193 ("ima: use the lsm policy update notifier")
>>> 483ec26eed42 ("ima: ima/lsm policy rule loading logic bug fixes")
>>> e144d6b26541 ("ima: Evaluate error in init_ima()")
>>> c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
>>>
>>> c66f67414c1f ("IB/core: Don't register each MAD agent for LSM notifier")
>>> is merged as the prerequisite of 42df744c4166 ("LSM: switch to blocking
>>> policy update notifiers"). e144d6b26541 ("ima: Evaluate error in
>>> init_ima()"), 483ec26eed42 ("ima: ima/lsm policy rule loading logic bug
>>> fixes") and 9ff8a616dfab ("ima: Have the LSM free its audit rule") are
>>> merged as a follow up bugfix for b16942455193 ("ima: use the lsm policy
>>> update notifier").
> 
> Scott, there's no need to duplicate the list of commits like this. 
> Having an unordered list would have been fine.
> 
>>>
>>> I've tested the patches against said issue and can confirm that the
>>> issue is fixed.
>>>
>>> Link to the original maillist discussion:
>>> https://lore.kernel.org/all/389334fe-6e12-96b2-6ce9-9f0e8fcb85bf@huawei.com/
>>>
>>> Change log:
>>>   v2: Fixed build issue and backport bugfix commits for backported
>>> patches.
>>
>> Is there a quick summary of the changes in v3 of this patchset?
> 
> v3:  Backport commit 483ec26eed42b ("ima: ima/lsm policy rule loading
> logic bug fixes")  as well.
> 
Oh Shoot! Totally forgot about it. Sorry.

The change is as Mimi said, backporting an additional IMA bugfix commit.
-- 
Best
GUO Zihua

