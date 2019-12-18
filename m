Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7646B12474A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 13:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfLRMxA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 07:53:00 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35695 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfLRMw7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Dec 2019 07:52:59 -0500
Received: by mail-qk1-f194.google.com with SMTP id z76so1802193qka.2
        for <linux-rdma@vger.kernel.org>; Wed, 18 Dec 2019 04:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b+CCGksXD0vuDKfmVp0tkHiA2uWnVRsyUsg9W47Em0w=;
        b=V4cUClr1kHNL9cE/3hnbLIPHpTlNhp+WtY4uxMwUV+5JpJW2ZkRU/U2kLhqFzz1Cb7
         /6jIEZjMyCvlYCe4JbT1Mh6uH4++6hoygmRC5fDbvFGRZ05jI+NWTdo/u6g5O8Q6zBqL
         FycUbuQdsTBjDLiDIwi1aSJaUvU9OUxVZaLUftubjgFli8Hxx04lNuXEjWrTYvHBgQDu
         +CeDQJIlzU1f5VErJatobGIzIy5/kPrwvGC8+B/zoYX+60m+ukJ5fG22X5JIKmfL8WpS
         IdI54cOJmFZ/47PZih3TuNKxgQ8S+JlYPvFqHCpBcp6oSFw7YFK2nxGgZ1NqAJH2dBpG
         OWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b+CCGksXD0vuDKfmVp0tkHiA2uWnVRsyUsg9W47Em0w=;
        b=pOgffNV/niF5yH41MsfN0Di304QHHUTpmxSBbbzHX3TaLyQs9vmpjtYGzFVSn/9qlK
         4X6KjuQQQctEmR5gZiX/jiKb0wt2KILKl5wiKqwfe21Eu9pYHdyPwTV+cQ66AjCnxaVS
         HTAMlXMZilGdKUgLJegEWNMSJOTB8WNsr6+O2ovN619axQzhnvmenmfyzpOonkJ7WAW0
         sCge9ppVPVARCiqUEGrh8paN2keHcRgSQedOjbY2XJ3uzDdVpis3pQK2Ntj/WILRdAkD
         uj465ict2tMLy/gMmOcxajCIKUYWrij20TmkMkBd2EX6Osi8YmzVh9CpuKYGxecUkhBh
         UGiw==
X-Gm-Message-State: APjAAAWYicUsuWsOwNZz1rBQLpTE0C5RAmI2yYkt64mTtjF5rmdfFImg
        OMw1JMewgnzgTRYbpeahtlu0Zg==
X-Google-Smtp-Source: APXvYqwXxvLIXwbnaU0pbtUaahmQsTY4WJgvs7cvIfEp9WJEolUF/3Lr4p9rKDGIxgul5lRhDBUKSg==
X-Received: by 2002:a05:620a:109c:: with SMTP id g28mr2275683qkk.0.1576673578884;
        Wed, 18 Dec 2019 04:52:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l49sm709602qtk.7.2019.12.18.04.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Dec 2019 04:52:58 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ihYoz-0006wl-U1; Wed, 18 Dec 2019 08:52:57 -0400
Date:   Wed, 18 Dec 2019 08:52:57 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Max Hirsch <max.hirsch@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Steve Wise <swise@opengridcomputing.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Danit Goldberg <danitg@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dag Moxnes <dag.moxnes@oracle.com>,
        Myungho Jung <mhjungk@gmail.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/cma: Fix checkpatch error
Message-ID: <20191218125257.GD17227@ziepe.ca>
References: <20191211111628.2955-1-max.hirsch@gmail.com>
 <20191211162654.GD6622@ziepe.ca>
 <CADgTo880aSn++fcf_rt0+8DCE4Y=xgXtZxFx9B0nzM_M1HdWPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADgTo880aSn++fcf_rt0+8DCE4Y=xgXtZxFx9B0nzM_M1HdWPw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 11, 2019 at 08:33:10PM -0500, Max Hirsch wrote:
> Thanks for the quick response. This is my first patch, so I want to
> follow the correct protocol. I reran checkpatch after making the
> changes and there were no errors or warnings in the region I changed.

You are supposed to run the patch itself through checkpatch:

$ git format-patch HEAD^!
0001-RDMA-cma-Fix-checkpatch-error.patch
$ scripts/checkpatch.pl 0001-RDMA-cma-Fix-checkpatch-error.patch
WARNING: A patch subject line should describe the change not the tool that found it
#4: 
Subject: [PATCH] RDMA/cma: Fix checkpatch error

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#12: 
This patch moves the assignment of ret to the previous line. The if statement then checks the value of ret assigned on the previous line. The assigned value of ret is not changed. Testing involved recompiling and loading the kernel. After the changes checkpatch does not report this the error in cma.c.

total: 0 errors, 2 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0001-RDMA-cma-Fix-checkpatch-error.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Jason
