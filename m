Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440907D8C2F
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 01:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjJZXXe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 19:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJZXXd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 19:23:33 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A941BE
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 16:23:29 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-49dd647a477so638530e0c.3
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 16:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698362609; x=1698967409; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2VvQ+IajNTfApebnBzg4Te4ZQTGsRwCYDrMPlnvFPPw=;
        b=dBg/WIPJUgd550mE5VUynQWtLbbs6XDSTWSRWovCrgrjCBjkt73yegzIlfif5LkthW
         kQ1Sh5C1CN/rea3BzSfxf32GQkNbf6meXwJHXVxbF7m7uRHC8+SUkCw+RuQdvioUEUOY
         he3I2t23w7TR0ZzTisWXDPMZ9Wm4KKbKH7RHbJz03U4HB1HKWS0Xh8wqM2byxlKss6cQ
         VL1xqEBPXVwFvpACM69rFIUPP0f7mREnnvyBTG0K+hf23O2wLDdQcx3bAlhdzYQr1wlH
         YcZVDUY+y4qTVS0VpMvcxU/P/BB1FG0B5L7gKXUkFsjTbtXut/E2zeAtxI2KYnlRR679
         vpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698362609; x=1698967409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VvQ+IajNTfApebnBzg4Te4ZQTGsRwCYDrMPlnvFPPw=;
        b=stfXawlprHpTtFTut574M4NtjVoL5iBQ48NrXbdLaY1TH1WKnZQUJHY1tzfirN9j/2
         RJYSf4Tsp8WR3VazY82cid5rEZF/HU0Mx8LxCsgSwla4eEMMagXqM0M+gcVTXaE1tnhR
         7120PmGGd/t9laVDuANdQi41lLHICLx8BAs2Ujwvk+NUMXaUK9cbtB8pI0+qGFepG0rS
         8WMjFbCMMsWb1coDEbJ2FdIR9KCNr2WuLMo/6ScN4T3ntIBCyCWTW2Cs3D3v4e9tE6p+
         nX7jRAUEf47jsoWiN3DtIX4MKU9CkRE/g2ab4r6D7zttF++026pKPQhP9EyOYbuFk/xW
         YEKA==
X-Gm-Message-State: AOJu0YzjbmLoJPTcx+TgyZBFeZfOsJfqGrKAWBJXF8PsO+eawJIx+fRI
        SNezxxtq1YX6IcANDbMkJ139gg==
X-Google-Smtp-Source: AGHT+IEJE+G+TXNWljoKsRYbt4Osshwb+nR+NhYBunCs8RCEhaX1it7S8gTTp5LmIOnAe1XhWNiHWA==
X-Received: by 2002:a1f:a114:0:b0:49d:d91:8b27 with SMTP id k20-20020a1fa114000000b0049d0d918b27mr1498288vke.2.1698362608866;
        Thu, 26 Oct 2023 16:23:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id m14-20020a819c0e000000b0059b17647dcbsm156034ywa.69.2023.10.26.16.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 16:23:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qw9hH-005Z0h-Gc;
        Thu, 26 Oct 2023 20:23:27 -0300
Date:   Thu, 26 Oct 2023 20:23:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with
 64k page size
Message-ID: <20231026232327.GZ691768@ziepe.ca>
References: <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
 <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
 <1ffaeaa4-4ac2-4531-8e0c-586e13c14c97@fujitsu.com>
 <366da960-6036-49c5-ad47-3ae3f4e55452@fujitsu.com>
 <8f705223-6fde-4b29-880b-570349f40db8@fujitsu.com>
 <20231026114221.GT691768@ziepe.ca>
 <2374eb54-6a7e-4a56-b7e9-3aa5c9048fa1@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2374eb54-6a7e-4a56-b7e9-3aa5c9048fa1@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 26, 2023 at 08:59:34PM +0800, Zhu Yanjun wrote:
> 在 2023/10/26 19:42, Jason Gunthorpe 写道:
> > On Thu, Oct 26, 2023 at 09:05:52AM +0000, Zhijian Li (Fujitsu) wrote:
> > > The root cause is that
> > > 
> > > rxe:rxe_set_page() gets wrong when mr.page_size != PAGE_SIZE where it only stores the *page to xarray.
> > > So the offset will get lost.
> > > 
> > > For example,
> > > store process:
> > > page_size = 0x1000;
> > > PAGE_SIZE = 0x10000;
> > > va0 = 0xffff000020651000;
> > > page_offset = 0 = va & (page_size - 1);
> > > page = va_to_page(va);
> > > xa_store(&mr->page_list, mr->nbuf, page, GFP_KERNEL);
> > > 
> > > load_process:
> > > page = xa_load(&mr->page_list, index);
> > > page_va = kmap_local_page(page) --> it must be a PAGE_SIZE align value, assume it as 0xffff000020650000
> > > va1 = page_va + page_offset = 0xffff000020650000 + 0 = 0xffff000020650000;
> > > 
> > > Obviously, *va0 != va1*, page_offset get lost.
> > > 
> > > 
> > > How to fix:
> > > - revert 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c")
> > > - don't allow ulp registering mr.page_size != PAGE_SIZE ?
> > 
> > Lets do the second one please. Most devices only support PAGE_SIZE anyhow.
> 
> Normally page_size is PAGE_SIZE or the size of the whole compound page (in
> the latest kernel version, it is the size of folio). When compound page or
> folio is taken into account, the page_size is not equal to
> PAGE_SIZE.

folios are always multiples of PAGE_SIZE. rxe splits everything into
PAGE_SIZE units in the xarray.

> If the ULP uses the compound page or folio, the similar problem will occur
> again. 

No, it won't. We never store folios in the xarray.

Jason
