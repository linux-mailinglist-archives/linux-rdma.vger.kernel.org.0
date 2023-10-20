Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A537D13E7
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Oct 2023 18:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjJTQV1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Oct 2023 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJTQV0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Oct 2023 12:21:26 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7E1A3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Oct 2023 09:21:24 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1cab2c24ecdso7564535ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 20 Oct 2023 09:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697818884; x=1698423684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3a4RN4Z/Wt/jU6mM5J34FuRRyWBiwJxVniTfDs7XXg=;
        b=RemkNrQgpfo30eJOyhR64DBv8YqhhNpPLC5dtPAMm0FW4No+1vxF70wg2i+pLO+nY6
         03x6yuI342cVydgzSq1yZBCmS9ld1RjG7bjm/b3yMeRtziiD/viecjzVHCW+OdOU7Fk8
         hSIt8UwJ5c8p1sBoEqSx7rAXYlE+YikEHDtRu7CFGcv8OeR9nGBnsf7h9UCDstA+oOSL
         klYCNseX35SoTa+LpLVFSUBrGd1EqqHeP6m7WeItQByBromfKpGQl/9UPmGv1COL0h5k
         hyf0n4PR9kALjraqJADKTYRgUJdm0VGoa/XYxMV6j7YB+5vFuxfYTHiBvm9rexcHM9EC
         Jksg==
X-Gm-Message-State: AOJu0YyBcyihyiulX4sUDJcOJ+nErjmWdKOKhdPduQ3qOCqcKkXzp0GU
        zmX24VV8oIm+PED5pHFWj6OEtgSKDsY=
X-Google-Smtp-Source: AGHT+IFYnyYInl1bxHOaPzDy3E2KOGuozPv6zUhwBaKcJWxlZsQZmOaNZCFvM8+LYDwlSP3RL9Cv8g==
X-Received: by 2002:a17:903:493:b0:1ca:344f:46e6 with SMTP id jj19-20020a170903049300b001ca344f46e6mr2028016plb.33.1697818883724;
        Fri, 20 Oct 2023 09:21:23 -0700 (PDT)
Received: from ?IPV6:2601:642:4c08:4945:85f8:4610:95c3:168a? ([2601:642:4c08:4945:85f8:4610:95c3:168a])
        by smtp.gmail.com with ESMTPSA id ix21-20020a170902f81500b001c0a414695dsm1723963plb.62.2023.10.20.09.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 09:21:23 -0700 (PDT)
Message-ID: <e60407d2-13c2-477c-b663-102e6094c551@acm.org>
Date:   Fri, 20 Oct 2023 09:21:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
Content-Language: en-US
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Zhu Yanjun' <yanjun.zhu@intel.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <e628d470-507d-41a2-92ee-c32b8a8d4791@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e628d470-507d-41a2-92ee-c32b8a8d4791@fujitsu.com>
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

On 10/19/23 23:54, Zhijian Li (Fujitsu) wrote:
> Add and Hi Bart,
> 
> Yi reported a crash[1] when PAGE_SIZE is 64K
> [1]https://lore.kernel.org/all/CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=1znaBEnu1usLOciD+g@mail.gmail.com/T/
> 
> The root cause is unknown so far, but I notice that SRP over RXE always uses MR with page_size
> 4K = MAX(4K, min(device_support_page_size)) even though the device supports 64K page size.
> * RXE device support 4K ~ 2G page size
> 
> 
> 4024         /*
> 4025          * Use the smallest page size supported by the HCA, down to a
> 4026          * minimum of 4096 bytes. We're unlikely to build large sglists
> 4027          * out of smaller entries.
> 4028          */
> 4029         mr_page_shift           = max(12, ffs(attr->page_size_cap) - 1);
> 4030         srp_dev->mr_page_size   = 1 << mr_page_shift;
> 4031         srp_dev->mr_page_mask   = ~((u64) srp_dev->mr_page_size - 1);
> 4032         max_pages_per_mr        = attr->max_mr_size;
> 
> 
> I doubt if we can use PAGE_SIZE MR if the device supports it.

Hi Zhijian,

Thank you for having Cc-ed me. How about changing "12" in the above code
into PAGE_SHIFT?

Thanks,

Bart.
