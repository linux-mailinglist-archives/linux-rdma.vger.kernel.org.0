Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC34F1B6C15
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 05:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDXDrH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 23:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726027AbgDXDrH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 23:47:07 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE342C09B044;
        Thu, 23 Apr 2020 20:47:06 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id e18so1826445oot.9;
        Thu, 23 Apr 2020 20:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VMlZsZaFfxNa0cf7p8pZP+Z+Omdw/uMd+UOr6VK2CIo=;
        b=Ltbf/q0uPwUn1CYXwQ8Cf2zfO0h6CzV8r7pwjK248IxDj6st4i5bcP+ACE156OuI5d
         KFQ4g9Vnq9vRBxm0IRoTkSZzfsX2lQNRl/OqBv9Rxfz+SsVYdYQiK90IqoAt32qUIogI
         ruz2d7c/nwjpPEHCvT+6hPbY2JOVkb1jRORDClD2BqckzNeeVt9uJR0aM1gIB3D5NV18
         riah0c+gQUL1TiSPmNSDrELZ9B0Eqg68C8V6bqD93sttz5SXqumDGGo9Ir7OK3wc+b6P
         mhx3Q5kd9bKY8z8Nx+tNnxvjNLKjPu1fi4vykdCi/3SLPpVo7e7APo6iXgnGjDAPwWRp
         r4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VMlZsZaFfxNa0cf7p8pZP+Z+Omdw/uMd+UOr6VK2CIo=;
        b=SMYR3p1NhQu31cI9EpuHOXHbcTq7W7e31paPZbCZNHIpR85NO/ZMjqWku0LxxkQ8a8
         RYYBcfLEl4sy8P/+GKkeKHOYarNK0axy+R3HGb/y35WF+3jCCqYEyXlt6cOmWH2NUQfG
         nvcwBFB99HY1M2RKst2AcQVVKmK/eNmmMh/AOEDf3tQW8ojycicR2wIjVxuOOH7NaOF8
         BSmfZNtVE3J0Y+Ps1jPmWylnQzWVE2q3LoUhNnedCw98TLJwgiZEQbT6cJzluGmjTAbh
         x9KvvKP9cpIay2UVRtGzz3JbGRmDM5/x3b5b9Hb1Y08PCC4mn0t4gcwE5n06pFPeuinK
         M4+A==
X-Gm-Message-State: AGi0Pubp/7BpABUfNrbG8MvT1n79BtsLJKeNO6Bk8qkwc73n0n4TlyJZ
        Mzw/+3eU2aUEUach/W0xw0cs+fCpaHo=
X-Google-Smtp-Source: APiQypJ6Rj/X+KndpeCiCjuowm+6u8o1RfDude6ez6QxAJsUl4Mz9YvaiRM8AAE4x1xIsofEG7FFwA==
X-Received: by 2002:a4a:6743:: with SMTP id j3mr6339357oof.82.1587700026114;
        Thu, 23 Apr 2020 20:47:06 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id x88sm1159008ota.44.2020.04.23.20.47.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 20:47:05 -0700 (PDT)
Date:   Thu, 23 Apr 2020 20:47:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: remaining flexible-array conversions
Message-ID: <20200424034704.GA12320@ubuntu-s3-xlarge-x86>
References: <6342c465-e34b-3e18-cc31-1d989926aebd@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6342c465-e34b-3e18-cc31-1d989926aebd@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Gustavo,

On Wed, Apr 22, 2020 at 01:26:02PM -0500, Gustavo A. R. Silva wrote:
> Hi Linus,
> 
> Just wanted to ask you if you would agree on pulling the remaining
> flexible-array conversions all at once, after they bake for a couple
> of weeks in linux-next[1]
> 
> This is not a disruptive change and there are no code generation
> differences. So, I think it would make better use of everyone's time
> if you pull this treewide patch[2] from my tree (after sending you a
> proper pull-request, of course) sometime in the next couple of weeks.
> 
> Notice that the treewide patch I mention here has been successfully
> built (on top of v5.7-rc1) for multiple architectures (arm, arm64,
> sparc, powerpc, ia64, s390, i386, nios2, c6x, xtensa, openrisc, mips,
> parisc, x86_64, riscv, sh, sparc64) and 82 different configurations
> with the help of the 0-day CI guys[3].
> 
> What do you think?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d496496793ff69c4a6b1262a0001eb5cd0a56544
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=for-next/kspp&id=d783301058f3d3605f9ad34f0192692ef572d663
> [3] https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/kernel-ci/kspp-fam0-20200420.md
> 
> Thanks
> --
> Gustavo

That patch in -next appears to introduce some warnings with clang when
CONFIG_UAPI_HEADER_TEST is enabled (allyesconfig/allmodconfig exposed it
for us with KernelCI [1]):

./usr/include/rdma/ib_user_verbs.h:436:34: warning: field 'base' with
variable sized type 'struct ib_uverbs_create_cq_resp' not at the end of
a struct or class is a GNU extension
[-Wgnu-variable-sized-type-not-at-end]
        struct ib_uverbs_create_cq_resp base;
                                        ^
./usr/include/rdma/ib_user_verbs.h:647:34: warning: field 'base' with
variable sized type 'struct ib_uverbs_create_qp_resp' not at the end of
a struct or class is a GNU extension
[-Wgnu-variable-sized-type-not-at-end]
        struct ib_uverbs_create_qp_resp base;
                                        ^
./usr/include/rdma/ib_user_verbs.h:743:29: warning: field 'base' with
variable sized type 'struct ib_uverbs_modify_qp' not at the end of a
struct or class is a GNU extension
[-Wgnu-variable-sized-type-not-at-end]
        struct ib_uverbs_modify_qp base;
                                   ^
3 warnings generated.

I presume this is part of the point of the conversion since you mention
a compiler warning when the flexible member is not at the end of a
struct. How should they be fixed? That should probably happen before the
patch gets merged.

[1]: https://kernelci.org/build/id/5ea17b1b77113098348ec6db/logs/

Cheers,
Nathan
