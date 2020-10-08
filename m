Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C16287723
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 17:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbgJHP3c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 11:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgJHP3c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 11:29:32 -0400
X-Greylist: delayed 326 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Oct 2020 08:29:31 PDT
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BEEC061755;
        Thu,  8 Oct 2020 08:29:31 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id E3B3358758003; Thu,  8 Oct 2020 17:24:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id DFDF360E1940A;
        Thu,  8 Oct 2020 17:24:03 +0200 (CEST)
Date:   Thu, 8 Oct 2020 17:24:03 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: remaining flexible-array conversions
In-Reply-To: <20200424121553.GE26002@ziepe.ca>
Message-ID: <36r41qn8-87o3-2pr1-856p-040167pq097@vanv.qr>
References: <6342c465-e34b-3e18-cc31-1d989926aebd@embeddedor.com> <20200424034704.GA12320@ubuntu-s3-xlarge-x86> <20200424121553.GE26002@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Friday 2020-04-24 14:15, Jason Gunthorpe wrote:
>> ./usr/include/rdma/ib_user_verbs.h:436:34: warning: field 'base' with
>> variable sized type 'struct ib_uverbs_create_cq_resp' not at the end of
>> a struct or class is a GNU extension
>> [-Wgnu-variable-sized-type-not-at-end]
>>         struct ib_uverbs_create_cq_resp base;
>>                                         ^
>> I presume this is part of the point of the conversion since you mention
>> a compiler warning when the flexible member is not at the end of a
>> struct. How should they be fixed? That should probably happen before the
>> patch gets merged.
>
>The flexible member IS at the end of the struct and is often intended
>to cover the memory in the enclosing struct.

There is no guarantee for the presence of such a struct.

In the case of the RDMA headers, even if we assume best conditions --
a block of malloc(sizeof(struct ib_uverbs_create_cq_resp) +
sizeof(u64)*N) and not some struct -- it smells a lot like undefined
behavior, because ib_uverbs_create_cq_resp::driver_data accesses data
as u64 while ib_uverbs_ex_create_cq_resp::comp_mask and friends are
u32.

There has got to be some aliasing rule in C that causes RDMA's
purported use-case to be UB.
