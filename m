Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E492F7C588B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 17:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346938AbjJKPvK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 11:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346937AbjJKPvI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 11:51:08 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0969B7
        for <linux-rdma@vger.kernel.org>; Wed, 11 Oct 2023 08:51:06 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7cc03dee5so21442247b3.3
        for <linux-rdma@vger.kernel.org>; Wed, 11 Oct 2023 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697039466; x=1697644266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgcAwPpGflvmi9WCtQQxqQtojLLfUAZnyJlHIKQ5SQM=;
        b=Zp8PAWPaP9210FGYjUSUBbJua24lF+xM6qjBJi+NyIiRGl3p5tBo9DAb317FhMuSGV
         1WPh3qvW+7Ve0HmesQ2btRNJqgj7ml2MbRsWUSXopFZyHJPFV9jHrjrfT3sv5XhRA+Ve
         QviRJVtwEw1767utITJxyDdziIIIVMSyvEN1PcUoUBSK1kMGzUYs3FWUTr9nOnrg8UBi
         B1hmKse9BzSeVgAto8mMQ0ASHPvcLEASJoywYy5wXOfHrgpkE5MBDbPgmhVg6St9R4VQ
         uFSU4NTSar7vQ9Bejve65OoLLEhY9w+5t8v6FyJCDKr5uyykJrrYGDUGLoOMN1OT4SEm
         LosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039466; x=1697644266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgcAwPpGflvmi9WCtQQxqQtojLLfUAZnyJlHIKQ5SQM=;
        b=Ey36iPw5HzQ+8VIVoSDhexkSaNOYvT+xKf6TIFtKxPdRxzvED1hLKBH8YR+uusWLNn
         0YWaEV4q/buV1Dh6l57/glDKEtBtyooZ+eCkMS4WcWXxgxvgUvVCW8wm2XieLY1TgUUW
         MlISo2w83JW83EkbDXcwo+A5ZSkYvMIzmEIx4YpayBZvpwqDYpYMuOLsjdc/AJ3BTKeJ
         DrTL0009WvDNVYusWpWtc6DjkK/ExAtonZTQBFbf5GwrxIQJlj2vIJ4NB2cAs0Pqp6KW
         76tDwy556jTKDFBlsIZDZ0rl0Vzn80pkbxjywy5sE7LU0Y1XOtmLUm4Vu1R8w/ORFLrk
         00XA==
X-Gm-Message-State: AOJu0YxFJS8LFQGx0V9ThMS+Th/3ArbzB9ub4TjJ4zHSf5epvqc7rF+m
        5DcrWor+c42W/SO7N5h/zD+J4A==
X-Google-Smtp-Source: AGHT+IExCLOrDbvUCQHHyRtGD33zPEyYOMQtEdS2uMpns4tw/aL9bNEKOSkZehzFBhECNWfYvF/2MA==
X-Received: by 2002:a0d:d802:0:b0:5a7:be29:19ac with SMTP id a2-20020a0dd802000000b005a7be2919acmr5927670ywe.12.1697039466164;
        Wed, 11 Oct 2023 08:51:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id v11-20020a05620a122b00b0076f1d8b1c2dsm5312568qkj.12.2023.10.11.08.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:51:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qqbUG-000hJ7-TJ;
        Wed, 11 Oct 2023 12:51:04 -0300
Date:   Wed, 11 Oct 2023 12:51:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Zhu Yanjun' <yanjun.zhu@linux.dev>,
        Leon Romanovsky <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Message-ID: <20231011155104.GF55194@ziepe.ca>
References: <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
 <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
 <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
 <20231005142148.GA970053@ziepe.ca>
 <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
 <a8453889-3f5f-49ff-89f2-ec0ef929d915@linux.dev>
 <OS3PR01MB9865F9BEB1A90DDCAEEBFC8BE5CDA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20231010160919.GC55194@ziepe.ca>
 <a4808fa6-5bd5-4a64-a437-6a7e89ca7e9f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4808fa6-5bd5-4a64-a437-6a7e89ca7e9f@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 10, 2023 at 02:29:19PM -0700, Bart Van Assche wrote:
> On 10/10/23 09:09, Jason Gunthorpe wrote:
> > On Tue, Oct 10, 2023 at 04:53:55AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> > 
> > > Solution 1: Reverting "RDMA/rxe: Add workqueue support for rxe tasks"
> > > I see this is supported by Zhu, Bart and approved by Leon.
> > > 
> > > Solution 2: Serializing execution of work items
> > > > -       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
> > > > +       rxe_wq = alloc_workqueue("rxe_wq", WQ_HIGHPRI | WQ_UNBOUND, 1);
> > > 
> > > Solution 3: Merging requester and completer (not yet submitted/tested)
> > > https://lore.kernel.org/all/93c8ad67-f008-4352-8887-099723c2f4ec@gmail.com/
> > > Not clear to me if we should call this a new feature or a fix.
> > > If it can eliminate the hang issue, it could be an ultimate solution.
> > > 
> > > It is understandable some people do not want to wait for solution 3 to be submitted and verified.
> > > Is there any problem if we adopt solution 2?
> > > If so, then I agree to going with solution 1.
> > > If not, solution 2 is better to me.
> > 
> > I also do not want to go backwards, I don't believe the locking is
> > magically correct under tasklets. 2 is painful enough to continue to
> > motivate people to fix this while unbreaking block tests.
> 
> In my opinion (2) is not a solution. Zhu Yanjun reported test failures with
> rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, 1). Adding WQ_HIGHPRI probably
> made it less likely to trigger any race conditions but I don't believe that
> this is sufficient as a solution.

I've been going on the assumption that rxe has always been full of
bugs. I don't believe the work queue change added new bugs, it just
made the existing bugs easier to hit.

It is hard to be sure until someon can find out what is going wrong.

If we revert it then rxe will probably just stop development
entirely. Daisuke's ODP work will be blocked and if Bob was able to
fix it he would have done so already. Which mean's Bobs ongoing work
is lost too.

I *vastly* prefer we root cause and fix it properly. Rxe was finally
starting to get a reasonable set of people interested in it, I do not
want to kill that off.

Again, I'm troubled that this doesn't seem to be reproducing for other
people.

> > I'm still puzzled why Bob can't reproduce the things Bart has seen.
> 
> Is this necessary?

It is always easier to debug something you can change than to try and
guess what an oops is trying to say..

> The KASAN complaint that I reported should be more than enough for
> someone who is familiar with the RXE driver to identify and fix the
> root cause. I can help with testing candidate fixes.

Bob?

Jason
