Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6E03A9E79
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 17:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhFPPFI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 11:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhFPPFI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Jun 2021 11:05:08 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0CAC061574
        for <linux-rdma@vger.kernel.org>; Wed, 16 Jun 2021 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Date:Message-ID:From:Cc:To;
        bh=uKBlRJ7ES/51u1y4tRd7tSxIzq7coiUgU/ox3RFAAio=; b=1ATnlLJHwT7b5AyKzOzT7RGnUV
        Zjvzq9hymJZD1fbzgcJiRj6b49/PzLBsPV/eM3sS5k6FWng/9Rx7odBOr1EPZTsXreD8qpigeGRZh
        eThlNkLe10gB0DHS8N0S3aPCqnJQPSrylNTx2cA4Njz2hGslXptzIwVYGv2Zzo6lDfhXkRdyTd4U7
        AKFr/zTni5qdLIgJdHzfwHi5Kiv9Oyuf+sM6mzq1ElcbjAp9+VbDH8EMw10o/QujF+o1/nr088YIq
        I9BU+ZcOYJBLNp7rjH3dj5fxF7O97Heyf4FKBa+kFRTPQce1JXoG3c4jJCkcPBJHJv2Y6xlyeZLLW
        nunv7mWr/HLw1SeThpfa7qofq1W2w5xevIt5lyY3zdBeInVHBO0+kN0oYUYyVdgDEzym8Epal9ZmR
        FBKLj7dwM8Z80yy+5XUgr6D9md9vK9OKM/c53/Vlg9QgGjafprvLlj0GRxXRgWVNVQUZTu4SDWebN
        BIGp4hNoiqhkwf+CC1BWYxp6;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1ltX4E-00034q-0v; Wed, 16 Jun 2021 15:02:58 +0000
Subject: Re: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
To:     =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
References: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
From:   Stefan Metzmacher <metze@samba.org>
Message-ID: <70403927-7cd3-a9e2-6e97-d1bb35571db6@samba.org>
Date:   Wed, 16 Jun 2021 17:02:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Håkon,

> +#define BIT_ACCESS_FUNCTIONS(b)							\
> +	static inline void set_##b(unsigned long flags)				\
> +	{									\
> +		/* set_bit() does not imply a memory barrier */			\
> +		smp_mb__before_atomic();					\
> +		set_bit(b, &flags);						\
> +		/* set_bit() does not imply a memory barrier */			\
> +		smp_mb__after_atomic();						\
> +	}									\

Don't you need to pass flags by reference to the inline function?
As far as I can see set_bit() operates on a temporary variable.

In order to check if inline functions are special I wrote this little check:

$ cat inline_arg.c
#include <stdio.h>

static inline void func(unsigned s, unsigned *p)
{
        printf("&s=%p p=%p\n", &s, p);
}

int main(void)
{
        unsigned flags = 0;

        func(flags, &flags);
        return 0;
}

$ gcc -O0 -o inline_arg inline_arg.c
$ ./inline_arg
&s=0x7ffd3a71616c p=0x7ffd3a716184

$ gcc -O6 -o inline_arg inline_arg.c
$ ./inline_arg
&s=0x7ffd87781064 p=0x7ffd87781060

It means s doesn't magically become 'flags' of the caller...

I'm I missing something?

metze
