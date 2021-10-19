Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D27434239
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Oct 2021 01:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJSXmz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 19:42:55 -0400
Received: from out2.migadu.com ([188.165.223.204]:13071 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhJSXmy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 19:42:54 -0400
Subject: Re: [PATCH 1/1] RDMA/irdma: remove the check to the returned value of
 irdma_uk_cq_init
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634686838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RGjjXEQNunWwDKG1oMMm2GipE8FeN9jnI8fKjqUBOe4=;
        b=XL+2gITDa2aBO+IT/WC5I0cUmFeaauv/lDrc1xHYZeOXd7tBnllNWjQoGrAtGo3Twhh7Dv
        B4VIvmYpe74VkRZyNSz5bOvRvauCCPGucMHpUCDwTJd7j04GqnJA/HgkBRj2nW4Dn98n/g
        yk0O3QbzbeQ70kH3vF/C5T1TSTGxSX4=
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>
References: <20211019153717.3836-1-yanjun.zhu@linux.dev>
 <f6a7d200d1f94c7abe8f2524a1d3acd7@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
Message-ID: <e8521bb9-bed5-eacb-bca3-a89d5bd8937d@linux.dev>
Date:   Wed, 20 Oct 2021 07:40:32 +0800
MIME-Version: 1.0
In-Reply-To: <f6a7d200d1f94c7abe8f2524a1d3acd7@intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yanjun.zhu@linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ÔÚ 2021/10/19 23:36, Saleem, Shiraz Ð´µÀ:
>> Subject: [PATCH 1/1] RDMA/irdma: remove the check to the returned value of
>> irdma_uk_cq_init
> 
> Maybe you can condense this to --
> 
> RDMA/irdma: Make irdma_uk_cq_init return a void
> 
> 
>>
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Since the function irdma_uk_cq_init always returns 0, so remove the check to the
>> returned value of the function irdma_uk_cq_init.
> 
> Maybe --
> 
> irdma_uk_cq_init always returns 0, so make it a void.
> 
> 
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/hw/irdma/ctrl.c | 5 +----
>>   drivers/infiniband/hw/irdma/uk.c   | 6 ++----
>>   drivers/infiniband/hw/irdma/user.h | 4 ++--
>>   3 files changed, 5 insertions(+), 10 deletions(-)
>>
> 
> Thanks for this!
> 
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> 
Thanks, Shiraz

Zhu Yanjun
