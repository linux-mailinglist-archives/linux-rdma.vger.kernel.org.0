Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB07CE786
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 21:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjJRTRn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Oct 2023 15:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRTRm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Oct 2023 15:17:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0C0109
        for <linux-rdma@vger.kernel.org>; Wed, 18 Oct 2023 12:17:39 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so3580926b3a.3
        for <linux-rdma@vger.kernel.org>; Wed, 18 Oct 2023 12:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697656659; x=1698261459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCVCpbE6AjuOuFwgWOOlvJrVuUbiKbl64ibgg65WkNE=;
        b=fy+UAGAnf9wlxkgI3GI9h3Ruq+WjkxCSn6ECr9QFM4mWuQ+Zu2WNsate/2Hpc1FFHd
         dMBgkV497wndqdMgRy4zhve99j/lb9/tADeFfTAYpY92/yrRiooqUsjKrJEq5CQnJBL7
         4s7N6GkILWI67SLpaB5BQtnDn9eL67HZshI+ZjoBafxWc5yJTv/QiPM4bmNuoehZJvZG
         BEEgNxh1ZXxsmmP0FJIAlrrUUw/z2IIz3AavFdf7sZfPFUnHdJRsYibQRRqWrgdB5kIT
         rC4yZb3svAVvzWLPrWXXFS0JwPeggPkMIyEMLjmxFaEjlYF6zahF5lmZN8zseFMxLPPx
         /kuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697656659; x=1698261459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCVCpbE6AjuOuFwgWOOlvJrVuUbiKbl64ibgg65WkNE=;
        b=JRsh6x8H9eBJuS1BX58JBMPksJnCQfAtQQLZ84wIAw5lQ52g5VngGER94MFkFilYPR
         ERdEipPH8OROpO51hkuLvKOkm1+Oroea2Ok3d1Ye/dLqtq6V0GKJ9oVUcG6k5AiU1eLo
         NdWZ74ZmYrCQj9pwkXlZzGtjZQzgL9BoqMsoMQC+X9/vhhaKDJvFE1IyavkXgn3sHm0o
         /xSeBwim4ap6xqIX9t99z7lNFEaisx3wjelioRzzw/8hmxPhtdJZgfEAxa613HkB1/uS
         dmhF4C1GU4tkCgs7ovTQXDFaom9DRzT3ludcKFcptMmmY5dFt4qUENHbcLG9sTcw1c9q
         Zp2g==
X-Gm-Message-State: AOJu0YyuWJ4OmnmUMyEFwFLTZLdZ3auvaq2/5T8IP3lRGV+6kqcEeL+d
        RBpuLAX6Zw8wDzJkA5owJiYvkg==
X-Google-Smtp-Source: AGHT+IGdLt0zytza8oSmlSUzt41XQsW5miK5tfUjcl01YyOtO3hnGG4/byaK2BXFgeWRUO+AeV2svg==
X-Received: by 2002:a05:6a00:2345:b0:691:1eb:7dda with SMTP id j5-20020a056a00234500b0069101eb7ddamr19795pfj.7.1697656658809;
        Wed, 18 Oct 2023 12:17:38 -0700 (PDT)
Received: from ziepe.ca ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d7-20020aa797a7000000b0068fadc9226dsm3678120pfq.33.2023.10.18.12.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 12:17:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qtC2x-0031hR-E1;
        Wed, 18 Oct 2023 16:17:35 -0300
Date:   Wed, 18 Oct 2023 16:17:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [bug report] blktests srp/002 hang
Message-ID: <20231018191735.GC691768@ziepe.ca>
References: <20231017185139.GA691768@ziepe.ca>
 <c65f92b2-9821-4349-b1f5-7dc2a287946a@gmail.com>
 <08a8d947-25b5-434c-9ba3-282d298b5bfd@acm.org>
 <e3d91c4f-b124-4031-9f92-fcb61973a645@gmail.com>
 <02cd10fd-fd4a-4ad7-9b1d-6d37b070aacf@acm.org>
 <5c6e69b3-f83b-461d-a08a-37bfbd82f995@gmail.com>
 <cad2fee4-9359-4614-b36b-c2599dc12358@acm.org>
 <bf2705ff-716a-45b5-bcc4-8710ea0fb98e@gmail.com>
 <65b871ef-dd93-4bfb-bae9-c147a87c64d0@acm.org>
 <dbd9f019-693f-476c-aa4c-739746753d2b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd9f019-693f-476c-aa4c-739746753d2b@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 18, 2023 at 01:29:16PM -0500, Bob Pearson wrote:
> On 10/17/23 17:42, Bart Van Assche wrote:
> > On 10/17/23 14:39, Bob Pearson wrote:
> >> On 10/17/23 16:30, Bart Van Assche wrote:
> >>>
> >>> On 10/17/23 14:23, Bob Pearson wrote:
> >>>> Not really, but stuck could mean it died (no threads active) or it is
> >>>> in a loop or waiting to be scheduled. It looks dead. The lower layers are
> >>>> waiting to get kicked into action by some event but it hasn't happened.
> >>>> This is conjecture on my part though.
> >>>
> >>> This call stack means that I/O has been submitted by the block layer and
> >>> that it did not get completed. Which I/O request got stuck can be
> >>> verified by e.g. running the list-pending-block-requests script that I
> >>> posted some time ago. See also
> >>> https://lore.kernel.org/all/55c0fe61-a091-b351-11b4-fa7f668e49d7@acm.org/.
> >>
> >> Thanks. Would this run on the side of a hung blktests or would I need to
> >> setup an srp-srpt file system?
> > 
> > I propose to analyze the source code of the component(s) that you
> > suspect of causing the hang. The output of the list-pending-block-
> > requests script is not sufficient to reveal which of the following
> > drivers is causing the hang: ib_srp, rdma_rxe, ib_srpt, ...
> > 
> > Thanks,
> > 
> > Bart.
> > 
> 
> Bart,
> 
> Another data point. I had seen (months ago) that both the rxe and
> siw drivers could cause blktests srp hangs. More recently when I
> configure my kernel to run lots of tests (lockdep, memory leaks,
> kasan, ubsan, etc.), which definitely slows performance and adds
> delays, the % of srp/002 runs which hang on the rxe driver has gone
> from 10%+- to a solid 100%. This suggested retrying the siw driver
> on the debug kernel since it has the reputation of always running
> successfully. I now find that siw also hangs solidly on srp/002.
> This is another hint that we are seeing a timing issue.

If siw hangs as well, I definitely comfortable continuing to debug and
leaving the work queues in-tree for now.

Jason
