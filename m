Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576377D833C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 15:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjJZNAO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 09:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjJZNAN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 09:00:13 -0400
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [IPv6:2001:41d0:203:375::b3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B431AC
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 06:00:11 -0700 (PDT)
Message-ID: <2374eb54-6a7e-4a56-b7e9-3aa5c9048fa1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698325209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iF1cKsYu9LJGMSYOQ5rbb6yhpn9lPA3eM1FZUAhqqWI=;
        b=entDI0FxvukNJgjhuGRbvWtmJ1PVG0sHYFWTiZog8Zrko9XEnoXAycW1HU14mnj3jXOwQh
        M3gZ5pqqyGogtN01y9PnBu+36RcPSSaSg8un0VCdc/Uqy99EyXSnf9g+3mXi0gZscqVGsp
        1Sr5MqK2mrwMzIQ3tDiP7gDXfUTJJ1E=
Date:   Thu, 26 Oct 2023 20:59:34 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
 <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
 <1ffaeaa4-4ac2-4531-8e0c-586e13c14c97@fujitsu.com>
 <366da960-6036-49c5-ad47-3ae3f4e55452@fujitsu.com>
 <8f705223-6fde-4b29-880b-570349f40db8@fujitsu.com>
 <20231026114221.GT691768@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231026114221.GT691768@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/10/26 19:42, Jason Gunthorpe 写道:
> On Thu, Oct 26, 2023 at 09:05:52AM +0000, Zhijian Li (Fujitsu) wrote:
>> The root cause is that
>>
>> rxe:rxe_set_page() gets wrong when mr.page_size != PAGE_SIZE where it only stores the *page to xarray.
>> So the offset will get lost.
>>
>> For example,
>> store process:
>> page_size = 0x1000;
>> PAGE_SIZE = 0x10000;
>> va0 = 0xffff000020651000;
>> page_offset = 0 = va & (page_size - 1);
>> page = va_to_page(va);
>> xa_store(&mr->page_list, mr->nbuf, page, GFP_KERNEL);
>>
>> load_process:
>> page = xa_load(&mr->page_list, index);
>> page_va = kmap_local_page(page) --> it must be a PAGE_SIZE align value, assume it as 0xffff000020650000
>> va1 = page_va + page_offset = 0xffff000020650000 + 0 = 0xffff000020650000;
>>
>> Obviously, *va0 != va1*, page_offset get lost.
>>
>>
>> How to fix:
>> - revert 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c")
>> - don't allow ulp registering mr.page_size != PAGE_SIZE ?
> 
> Lets do the second one please. Most devices only support PAGE_SIZE anyhow.

Normally page_size is PAGE_SIZE or the size of the whole compound page 
(in the latest kernel version, it is the size of folio). When compound 
page or folio is taken into account, the page_size is not equal to 
PAGE_SIZE.

If the ULP uses the compound page or folio, the similar problem will 
occur again. Since this problem is involved with RDMA and block, it will 
cost a lot of time and efforts to debug. If we fix it now, it will save 
a lot of time and efforts for the future ULP with folio.

Because folio has a lot of benefits, sooner or later, folio or other 
similar MMU technology will be popular in the kernel. At that time, this 
problem will appear again. We can do something for the future folio ^_^

Zhu Yanjun

> 
> Jason

