Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3601B7DCDB2
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Oct 2023 14:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344461AbjJaNTi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Oct 2023 09:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344452AbjJaNTh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Oct 2023 09:19:37 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB55DF
        for <linux-rdma@vger.kernel.org>; Tue, 31 Oct 2023 06:19:31 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-58686e94ad7so3387552eaf.3
        for <linux-rdma@vger.kernel.org>; Tue, 31 Oct 2023 06:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698758371; x=1699363171; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BtWJYaqzVCuAB1FYlsIzdtoi66Ke7zjmsu4PHOZOvs0=;
        b=IHbMVC6ElDtO7R2fV01G91I7ZOlm1MSIfM4+uEkHkvFEvLgAoen2hOtnOsV3mg8uKN
         xYR/22ygfO93Ir4T+qMle+MQ0V7SIR6Etdv4STyBXVlcRqHgTxlwa4wqM1yUi7UlmrGo
         iNkTEmR2QgKtsDEO/VdQZVbkyTvroF+wtI/V4TPUB1PKFGpsZAzyCKVYD0E2TucMox6v
         tUhXMe6WBUfCX5VyPo4/vdwHQkC0xVR/epOS7VbkLGoVu9mXZ9S0cJ/ySoiU6KNxDaFf
         a+Jlowhcf4ixBjzEXOgAR1xfAw86f8L9LbVQa8oyPj+sdykC9K45IlIW+UIzljZFiFOx
         Uk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698758371; x=1699363171;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtWJYaqzVCuAB1FYlsIzdtoi66Ke7zjmsu4PHOZOvs0=;
        b=YoBQgj9Ymv7ptJhcO1w9L9Jt3JIVujgbSCR443TIepRIoKKbsCTnKl2Zbo//7lXTZV
         K1iip/gf5Ytb74n1/Ph8vCyu0WbvS9CMepj9upZX5IQ9nNsjTSW6uoI3ElIpEMf0XoOx
         oK1yWZtlYc8AqHKXfB7PME4BGHyqrQHexbF5szJhlPl7YNc5oXlf2LxrfxBEwWrR/Sd+
         EAVl/kVw2Yx/kIjuEB+qaxfRQBEj5Cm15mhjPcfHPhHI1VxehBYKrMUer2CN3YE3TTMX
         hx9AXRQok6VVPgUO2QPModJ7WK28mlj25tOA7rBND/pKPTSTrt8xrPqwT5LpJva24j/H
         vedg==
X-Gm-Message-State: AOJu0YynzZNh8Pe3P3aop6hRRsk57TAyxaRJObR5TmALr4aMCv5E+wJK
        Wygt0qXOtmMgoyJEI7zFe90ldw==
X-Google-Smtp-Source: AGHT+IGobMzcpmUVEatZpnPLLSMhma3hu4rk+HEtm3dT5rrB5fQjHHicvBPXnBa6d9YXWfbq6fOjUQ==
X-Received: by 2002:a05:6870:78b:b0:1d6:439d:d03e with SMTP id en11-20020a056870078b00b001d6439dd03emr15262386oab.18.1698758371098;
        Tue, 31 Oct 2023 06:19:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id ml19-20020a056214585300b00671b009412asm500861qvb.141.2023.10.31.06.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 06:19:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qxoeW-007cYl-IU;
        Tue, 31 Oct 2023 10:19:28 -0300
Date:   Tue, 31 Oct 2023 10:19:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
Message-ID: <20231031131928.GH691768@ziepe.ca>
References: <20231027054154.2935054-1-lizhijian@fujitsu.com>
 <4da48f85-a72f-4f6b-900f-fc293d63b5ae@fujitsu.com>
 <20231030124041.GE691768@ziepe.ca>
 <7c5dd149-395a-46a2-96a0-89c182105eaf@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c5dd149-395a-46a2-96a0-89c182105eaf@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 31, 2023 at 04:52:23PM +0800, Zhu Yanjun wrote:
> 在 2023/10/30 20:40, Jason Gunthorpe 写道:
> > On Mon, Oct 30, 2023 at 07:51:41AM +0000, Zhijian Li (Fujitsu) wrote:
> > > 
> > > 
> > > On 27/10/2023 13:41, Li Zhijian wrote:
> > > > mr->page_list only encodes *page without page offset, when
> > > > page_size != PAGE_SIZE, we cannot restore the address with a wrong
> > > > page_offset.
> > > > 
> > > > Note that this patch will break some ULPs that try to register 4K
> > > > MR when PAGE_SIZE is not 4K.
> > > > SRP and nvme over RXE is known to be impacted.
> > > > 
> > > > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > > > ---
> > > >    drivers/infiniband/sw/rxe/rxe_mr.c | 6 ++++++
> > > >    1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> > > > index f54042e9aeb2..61a136ea1d91 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > > > @@ -234,6 +234,12 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
> > > >    	struct rxe_mr *mr = to_rmr(ibmr);
> > > >    	unsigned int page_size = mr_page_size(mr);
> > > > +	if (page_size != PAGE_SIZE) {
> > > 
> > > It seems this condition is too strict, it should be:
> > > 	if (!IS_ALIGNED(page_size, PAGE_SIZE))
> > > 
> > > So that, page_size with (N * PAGE_SIZE) can work as previously.
> > > Because the offset(mr.iova & page_mask) will get lost only when !IS_ALIGNED(page_size, PAGE_SIZE)
> > 
> > That makes sense
> 
> I read all the discussions very carefully.
> 
> Thanks, Greg.
> 
> Because RXE only supports PAGE_SIZE, when CONFIG_ARM64_64K_PAGES is enabled,
> the PAGE_SIZE is 64K, when CONFIG_ARM64_64K_PAGES is disabled, PAGE_SIZE is
> 4K.
> 
> But NVMe calls ib_map_mr_sg with a fixed size SZ_4K. When
> CONFIG_ARM64_64K_PAGES is enabled, it is still 4K. This is not a problem in
> RXE. This problem is in NVMe.

Maybe, but no real RDMA devices don't support 4K.

The xarray conversion may need revision to use physical addresses
instead of storing struct pages so it can handle this kind of
segmentation.

Certainly in the mean time it should be rejected.

Jason
