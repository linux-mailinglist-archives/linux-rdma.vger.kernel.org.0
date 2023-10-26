Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B35A7D81F3
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 13:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjJZLm0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 07:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJZLmZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 07:42:25 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5501A6
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 04:42:23 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b2e22a4004so473854b6e.3
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 04:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698320543; x=1698925343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Je6lxo5GIoHyl2nLlDyQL/iCnGCSUwx+8KDqcSFZH7I=;
        b=cJFaiW9eE5VPSx3Y9yw0uJjClYjAFIALbbP/3YYjHnpY8JO7UnRuDat8tjeaQvwvug
         JKUoca6N/VA2S9+9vIRPi7nERGs/H2OE5jBTkSMYf+zY6VGbcFafNDvY2Pj6RbUSgMn6
         d+6WPKUtZXGUlPG3wM+i8QZ80SxXL3WGO65a95Yx4T2S203kL9iKY7s4Tjv+dukTniPV
         GsRo7SSffloLx2V1PNN7O7Y+gRBSxbX4SuMpWJpLPaWtH2tYzDn/4ee0fpdo/xBf1Z69
         zTYEAWVgotXat4Hj1ywO9yOpzMlTRoYbKJomlihULWlfiEhbdFx5j6vAOIvV76GoCLOU
         /VPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698320543; x=1698925343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Je6lxo5GIoHyl2nLlDyQL/iCnGCSUwx+8KDqcSFZH7I=;
        b=RNJP+m+6kBOziWudvFHR630EfndpUekNIRyUtkLLxj4C5diJTyPHIKhJVnqFdZE+IM
         BEs2YrrWHmaBCO2VpeFU8F0H7cUTf++r56b6fvPpKd/Vd1V8Q2bXMN8g3vU5JRvjV97l
         S/aKihz0g1F1+IvYhBuApJNUXmlEYVFslwasvfgShgLEhOZ8DhUmeLgoxfm7ZuNZp8HJ
         XCuOrZP2MkEms6h77Zvf/dDGHyaAepSMmixY+Vl8/Or6K+CtiuGVmRxMsJrCHqd+Qlh/
         jSDDWrjh2YwJAB6L46DHAVc6fePZ3IPwR62GZit7RWlq8m+LOwWlzUbtf7hZDMBYou1X
         R+OQ==
X-Gm-Message-State: AOJu0YwrE+NoW8s+/b//oMrOq+h45qZkxGB814IcUBOlBxDaj8SUzult
        S9Kp7q5uoNz4FiuZ5myLIILuTQ==
X-Google-Smtp-Source: AGHT+IFGzs9eMXKN4PUgFEghdtuVPRk9D2gkT3GmUGUJmrjkvHjkhzRw3lJLYe38iJ/bHuLwJKOOyg==
X-Received: by 2002:a54:441a:0:b0:3ad:ff3e:d25c with SMTP id k26-20020a54441a000000b003adff3ed25cmr20376843oiw.53.1698320542872;
        Thu, 26 Oct 2023 04:42:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id b25-20020aca1b19000000b003a99bb60815sm2728383oib.22.2023.10.26.04.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 04:42:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qvykn-004zhy-M3;
        Thu, 26 Oct 2023 08:42:21 -0300
Date:   Thu, 26 Oct 2023 08:42:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with
 64k page size
Message-ID: <20231026114221.GT691768@ziepe.ca>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
 <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
 <1ffaeaa4-4ac2-4531-8e0c-586e13c14c97@fujitsu.com>
 <366da960-6036-49c5-ad47-3ae3f4e55452@fujitsu.com>
 <8f705223-6fde-4b29-880b-570349f40db8@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f705223-6fde-4b29-880b-570349f40db8@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 26, 2023 at 09:05:52AM +0000, Zhijian Li (Fujitsu) wrote:
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

Lets do the second one please. Most devices only support PAGE_SIZE anyhow.

Jason
