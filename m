Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD097D83C3
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 15:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjJZNnF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 09:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJZNnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 09:43:04 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780ECBD
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 06:43:02 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2e4107f47so540411b6e.2
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 06:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698327781; x=1698932581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l68tyCTKPN1Gi5Su5vTm0Xs6gRwYnazCMT+XZmNkmmQ=;
        b=onMkxbukXE3XhgRVAJqJgVvz5TEyMVqg5TLIXgZSSZH7MQ2OAprR8SV1Qgi6BoePUd
         g3rlKCvlvZOMuhwVNonLsqb3UBun0TJDsRupHtiJj9fPmdeKhg7wsB0697icypb05ufd
         sMXXwBIlp5HWx4gh3ofcrsv1j3m8AHm6z7JOg+1c95bHADP9T9tSZcprqxhtIo1cO7iD
         kwR3mlZigIkwBuK89EwFzJyh4bN+MdzWJY1d3DkLWF0LMJd42KGJX3ZlapPOevbIS6ij
         rxwx1ydWtZwt6Se486I94534u0Vki4UwtD/srDEcVN+oiQCqTHM5r/BjfPDydZ0eqdI+
         /Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698327781; x=1698932581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l68tyCTKPN1Gi5Su5vTm0Xs6gRwYnazCMT+XZmNkmmQ=;
        b=naMqvNO33Nl/2ApVxOlFhPMCfZTQpKrvHfyDsBuv5Zc/Ea8/SFwUgS3Jc2NrecdqEZ
         Bgf9nRK38ZuQeTWz2QMaXEt/3/ZC+LuTukymudu4dhD+lZ3umVj/fMRNVr1cjLJE/M6h
         BgU3V8sWynr/vH+LveDLlxx/In9JC22v9KWMvqxNF+Lxr16Vi0EYinYn8tTt1Tt/JoSw
         EspCADT3lFnVwxBS1JjoxlP+bWNvT6bJr7YcyQFQadTv8y4s9QJ9/f3fNs2YNyL/URHd
         EymzKttt0hLFUmAiJ9xUJhV6as2UJ96xMQB5PTnWItABbNSxpQ+U1YZ6LsYKkCPKZXY8
         GccQ==
X-Gm-Message-State: AOJu0Ywis3wNrPOjvUl/qiOv77JudqppqWEfxPjpUvfD+ejRpme5C5g+
        B0FhuUOhnFkZ4Btce0cNJzpuQRXBCxfxiyvfk5g=
X-Google-Smtp-Source: AGHT+IG04WA2bl3JDAbr2LdmOHLSkq0c/jVfure/gFWNeWLZSZ4OtLcm7OQqv0M72Y19Im7TGs86OA==
X-Received: by 2002:a05:6808:1b0f:b0:3ab:8956:ad95 with SMTP id bx15-20020a0568081b0f00b003ab8956ad95mr24383698oib.9.1698327781715;
        Thu, 26 Oct 2023 06:43:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id b25-20020aca1b19000000b003a99bb60815sm2760143oib.22.2023.10.26.06.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 06:43:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qw0dY-0058AA-BF;
        Thu, 26 Oct 2023 10:43:00 -0300
Date:   Thu, 26 Oct 2023 10:43:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with
 64k page size
Message-ID: <20231026134300.GV691768@ziepe.ca>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
 <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
 <1ffaeaa4-4ac2-4531-8e0c-586e13c14c97@fujitsu.com>
 <366da960-6036-49c5-ad47-3ae3f4e55452@fujitsu.com>
 <8f705223-6fde-4b29-880b-570349f40db8@fujitsu.com>
 <143f03b7-08ba-411c-a7ad-580141c06cfe@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <143f03b7-08ba-411c-a7ad-580141c06cfe@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 26, 2023 at 06:28:37AM -0700, Bart Van Assche wrote:
> On 10/26/23 02:05, Zhijian Li (Fujitsu) wrote:
> > The root cause is that
> > 
> > rxe:rxe_set_page() gets wrong when mr.page_size != PAGE_SIZE where it only stores the *page to xarray.
> > So the offset will get lost.
> > 
> > For example,
> > store process:
> > page_size = 0x1000;
> > PAGE_SIZE = 0x10000;
> > va0 = 0xffff000020651000;
> > page_offset = 0 = va & (page_size - 1);
> > page = va_to_page(va);
> > xa_store(&mr->page_list, mr->nbuf, page, GFP_KERNEL);
> > 
> > load_process:
> > page = xa_load(&mr->page_list, index);
> > page_va = kmap_local_page(page) --> it must be a PAGE_SIZE align value, assume it as 0xffff000020650000
> > va1 = page_va + page_offset = 0xffff000020650000 + 0 = 0xffff000020650000;
> > 
> > Obviously, *va0 != va1*, page_offset get lost.
> > 
> > 
> > How to fix:
> > - revert 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c")
> > - don't allow ulp registering mr.page_size != PAGE_SIZE ?
> 
> Thank you Zhijian for this root-cause analysis.
> 
> Hardware RDMA adapters may not support the host page size (PAGE_SIZE)
> so disallowing mr.page_size != PAGE_SIZE would be wrong.

PAGE_SIZE must always be a valid way to construct a MR. We have code
in all the DMA drivers to break PAGE_SIZE chunks to something smaller
when building MRs.

rxe is missing this now with the xarray stuff since we can't encode
the struct page offset and a struct page in a single xarray entry. It
would have to go back to encoding pfns and doing pfn to page.

> If the rxe driver only supports mr.page_size == PAGE_SIZE, does this
> mean that RXE_PAGE_SIZE_CAP should be changed from
> 0xfffff000 into PAGE_SHIFT?

Yes

Jason
