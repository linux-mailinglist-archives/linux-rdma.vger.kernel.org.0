Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C441A7C013E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Oct 2023 18:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjJJQJ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Oct 2023 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjJJQJY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Oct 2023 12:09:24 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A970511C
        for <linux-rdma@vger.kernel.org>; Tue, 10 Oct 2023 09:09:21 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7740cedd4baso416528285a.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Oct 2023 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696954161; x=1697558961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OiAlf9gBzYDPaYB8SATXz3ECA8Y+U3rkEiCG6k7hY7U=;
        b=jL8TyecFk4adqqRlMWPaE/Vsl83Xh+2dy/xDYRDbtdSHxPJjbaG3/b7T+4rWONgWKu
         VxPYpZSXqGqKvKikGyCqcEPlOguw8sIqWF8wU0KQoOAUOhNHcWCWRHhyHkzVDcvdRAZV
         /Ed3T+xZfHKTZ9ojjCBA+qvQX4o+Ph8XzrZPibcN4oCBc+cQCTK3kwUBqZfeIrVBRlqa
         CNBJXbV4nVli0kmt6i8Hy5lmm8mtaAnX1DmZ+G/1DyFhBWTLwcN68CGNowXic7XWPegf
         yCPoQYRLa00Xmg/3fTzCvV41izJ8NTEIKUir2RTZLTUjsJnJxSx/A8bfGAN4dKWt1J38
         h7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696954161; x=1697558961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiAlf9gBzYDPaYB8SATXz3ECA8Y+U3rkEiCG6k7hY7U=;
        b=pMfcRdNYDiulBh5dzhxzReFiaJGa9xTxxmqguTZyyYVbuA/vRfqJ0QNi+f3iyWDqcE
         Ah3GiJvG4vF6b0ot+X7DJmC62tTeMjGSovjuw5FnZ3unN/Vs3sLcdtUzo62gKrAiCG+1
         AgMfD+XKsXLFI3SlW7bl2lWaENhHUWAroD/cg7jxBugnTtN/hWcjh0MsE14YrBgSCdh3
         64xrli+HqK8J3BzEAjAaAVYMMwFGnr35JVMx1wpaZQx012FLERZwIcWSIfxexQw4P9s9
         h4gfdblZ972G/BBGV7GJBHFrZNDCtWgxcNn0ZAOX6yrJI06dvXRnhIiK3sZ5UXTL/ru/
         Gh0Q==
X-Gm-Message-State: AOJu0Yy28MUfzyUrcgdyBw2MfpFY014gqDe7+6Z+WAL0RH/j0U3E3xYE
        5q/NLze1G8a73dCCJiccpjkGQQ==
X-Google-Smtp-Source: AGHT+IFVSKaZDkjJDOygGp52/9+gheHAN8uCUgBS17Ps6w+7G66L4F/nVSSofwIXb+gkE22yxNuEUA==
X-Received: by 2002:a05:620a:b87:b0:774:13e4:1f7e with SMTP id k7-20020a05620a0b8700b0077413e41f7emr16870286qkh.38.1696954160783;
        Tue, 10 Oct 2023 09:09:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id c2-20020a05620a134200b00767c961eb47sm4446339qkl.43.2023.10.10.09.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 09:09:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qqFIN-000F7A-50;
        Tue, 10 Oct 2023 13:09:19 -0300
Date:   Tue, 10 Oct 2023 13:09:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc:     'Zhu Yanjun' <yanjun.zhu@linux.dev>,
        Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Message-ID: <20231010160919.GC55194@ziepe.ca>
References: <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
 <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
 <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
 <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
 <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
 <20231005142148.GA970053@ziepe.ca>
 <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
 <a8453889-3f5f-49ff-89f2-ec0ef929d915@linux.dev>
 <OS3PR01MB9865F9BEB1A90DDCAEEBFC8BE5CDA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB9865F9BEB1A90DDCAEEBFC8BE5CDA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 10, 2023 at 04:53:55AM +0000, Daisuke Matsuda (Fujitsu) wrote:

> Solution 1: Reverting "RDMA/rxe: Add workqueue support for rxe tasks"
> I see this is supported by Zhu, Bart and approved by Leon.
> 
> Solution 2: Serializing execution of work items
> > -       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
> > +       rxe_wq = alloc_workqueue("rxe_wq", WQ_HIGHPRI | WQ_UNBOUND, 1);
> 
> Solution 3: Merging requester and completer (not yet submitted/tested)
> https://lore.kernel.org/all/93c8ad67-f008-4352-8887-099723c2f4ec@gmail.com/
> Not clear to me if we should call this a new feature or a fix.
> If it can eliminate the hang issue, it could be an ultimate solution.
> 
> It is understandable some people do not want to wait for solution 3 to be submitted and verified.
> Is there any problem if we adopt solution 2?
> If so, then I agree to going with solution 1.
> If not, solution 2 is better to me.

I also do not want to go backwards, I don't believe the locking is
magically correct under tasklets. 2 is painful enough to continue to
motivate people to fix this while unbreaking block tests.

I'm still puzzled why Bob can't reproduce the things Bart has seen.

Jason
