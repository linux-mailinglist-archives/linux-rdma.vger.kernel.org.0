Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E193D7D8397
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 15:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjJZN2p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 09:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjJZN2o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 09:28:44 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662D5E5
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 06:28:42 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-27ff83feb29so461512a91.3
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 06:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698326921; x=1698931721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uftckbyEhLboLwEvCAgFzLEYYXDGR1rRtObzjIOVrmg=;
        b=bBNnP/LvUYu7/86ta0GMSf2ydGCqsMmC2JTYP+MRb3J/ZLSkbP0ASzs9Ow8ZhcVQkG
         XPJn0n8uTUt5R4xhkt//hdNfvHfi6+dMHURJE0ZawhPTaD5Hxr2aQhWj+DsSV3S4Y1Sm
         YegVV5LwWFe6m6+DQy3u68/PyjEg4XcTUDymPwyD3yWKfuPfdTi+0fHCSH9fgZ0SyMtQ
         Oku8ITO34l/uDv5/OZD1g6x+/iSLXCOBMT8l6WnPAN0bCsxsMAJ4/ZnuwgKlSO5S6XCg
         jjtPahXiRdX6N9RyfDKPLcK+rtjWROyBy1EgafkUESDFEVAvKT0WEfi0KYKZDDRsPyvX
         HK7g==
X-Gm-Message-State: AOJu0YylxDq9bQwnHnxYKYRY9jomd9fjKqDc7yWUwhqgF2xAeNRrJXXn
        qixD6fZi0HU77+VRBL4Eqx8=
X-Google-Smtp-Source: AGHT+IE1iALoi4ZJow9WesJsYFXa0Ku/S+y2iuiwRitPTC8kQSXk3y3N5ycwH4JuleU2CnVszRV98w==
X-Received: by 2002:a17:90a:bd84:b0:27f:fe16:247a with SMTP id z4-20020a17090abd8400b0027ffe16247amr1186389pjr.17.1698326921348;
        Thu, 26 Oct 2023 06:28:41 -0700 (PDT)
Received: from ?IPV6:2601:642:4c01:85c4:7084:77a7:ee23:1fd3? ([2601:642:4c01:85c4:7084:77a7:ee23:1fd3])
        by smtp.gmail.com with ESMTPSA id ms19-20020a17090b235300b00267d9f4d340sm1636203pjb.44.2023.10.26.06.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 06:28:40 -0700 (PDT)
Message-ID: <143f03b7-08ba-411c-a7ad-580141c06cfe@acm.org>
Date:   Thu, 26 Oct 2023 06:28:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
Content-Language: en-US
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Yi Zhang <yi.zhang@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
 <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
 <1ffaeaa4-4ac2-4531-8e0c-586e13c14c97@fujitsu.com>
 <366da960-6036-49c5-ad47-3ae3f4e55452@fujitsu.com>
 <8f705223-6fde-4b29-880b-570349f40db8@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8f705223-6fde-4b29-880b-570349f40db8@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/26/23 02:05, Zhijian Li (Fujitsu) wrote:
> The root cause is that
> 
> rxe:rxe_set_page() gets wrong when mr.page_size != PAGE_SIZE where it only stores the *page to xarray.
> So the offset will get lost.
> 
> For example,
> store process:
> page_size = 0x1000;
> PAGE_SIZE = 0x10000;
> va0 = 0xffff000020651000;
> page_offset = 0 = va & (page_size - 1);
> page = va_to_page(va);
> xa_store(&mr->page_list, mr->nbuf, page, GFP_KERNEL);
> 
> load_process:
> page = xa_load(&mr->page_list, index);
> page_va = kmap_local_page(page) --> it must be a PAGE_SIZE align value, assume it as 0xffff000020650000
> va1 = page_va + page_offset = 0xffff000020650000 + 0 = 0xffff000020650000;
> 
> Obviously, *va0 != va1*, page_offset get lost.
> 
> 
> How to fix:
> - revert 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c")
> - don't allow ulp registering mr.page_size != PAGE_SIZE ?

Thank you Zhijian for this root-cause analysis.

Hardware RDMA adapters may not support the host page size (PAGE_SIZE)
so disallowing mr.page_size != PAGE_SIZE would be wrong.

If the rxe driver only supports mr.page_size == PAGE_SIZE, does this
mean that RXE_PAGE_SIZE_CAP should be changed from
0xfffff000 into PAGE_SHIFT?

Thanks,

Bart.
