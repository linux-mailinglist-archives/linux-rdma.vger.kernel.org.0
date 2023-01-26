Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785C267CC69
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jan 2023 14:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbjAZNky (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Jan 2023 08:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbjAZNkx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Jan 2023 08:40:53 -0500
Received: from out-167.mta0.migadu.com (out-167.mta0.migadu.com [91.218.175.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B796536D
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 05:40:41 -0800 (PST)
Message-ID: <70b06eec-56e0-7a1e-083b-c120d2b413f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674740439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYg0VvR9OtrQpZ5hHDTkdYJtsWOTQ6DquwrkI7nEM5s=;
        b=eKmkHVK+qHjQqX6Xf/uCRvW79hFLoiJPotOYS57v+B4kbYwpr70PaZ8DPIG/H5EtzzFPEj
        7WaYF/MjNV11NJMNuNQi28izSoD+Unp6g3m9fj8qnrg9/1VIpVALP1jH5Am4NFZ8V1DutG
        xyg3pPWQA+bSNPIHAMCNKf2ximOcsqg=
Date:   Thu, 26 Jan 2023 21:40:33 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv3 for-next 0/4] RDMA/irdma: Refactor irdma_reg_user_mr
 function
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20230116193502.66540-1-yanjun.zhu@intel.com>
 <e59c54bf-03f7-2e27-2162-91dc3f896123@linux.dev> <Y9JdF5b+dzIchpOg@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <Y9JdF5b+dzIchpOg@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/1/26 18:59, Leon Romanovsky 写道:
> On Thu, Jan 26, 2023 at 09:16:05AM +0800, Zhu Yanjun wrote:
>> 在 2023/1/17 3:34, Zhu Yanjun 写道:
>>> V2->V3: 1) Use netdev reverse Christmas tree rule;
>>> 	2) Return 0 instead of err;
>>> 	3) Remove unnecessary brackets;
>>> 	4) Add an error label in error handler;
>>> 	5) Initialize the structured variables;
>> Hi, Leon
>>
>> Follow your advice, I made this patches.
>> Please check it.
> Everything is applied, sorry for the delay.

Thanks a lot.

Zhu Yanjun

>
> Thanks
