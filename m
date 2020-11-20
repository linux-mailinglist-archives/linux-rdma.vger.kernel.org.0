Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CFA2BB355
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 19:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbgKTScr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 13:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730723AbgKTSco (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Nov 2020 13:32:44 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91DCC0613CF
        for <linux-rdma@vger.kernel.org>; Fri, 20 Nov 2020 10:32:44 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id z17so5110567qvy.11
        for <linux-rdma@vger.kernel.org>; Fri, 20 Nov 2020 10:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iWqrZShOD+kRcre329kKVLGBiUFIo9BUZTpNDUEM+ic=;
        b=V+M+ohGOZ4Vys/bIL+F/am2Z09M0O/OjVX62sCjm0xlNyRUUTZcDFeWXP66tqIj143
         TXbGk0c5xLXXgTTMMfQzsOldHOJNi2TNxA1S/WOgHEeoBHKCL+mwk3GYOOwZ08D7GULj
         aRPrtYvMSuHm6eG/P2PQwHr+atBnSQwVPnAWUwYhMUagBvNOkcQpSBpwCDdJQkXZ9yyK
         XJ7lFP29cx+xJSKbVqwOiteimNYTAE9tBrYBrBG0kxMrBhpu1akQV0kS+ajRCRfsFUbO
         pSgCaPdFAIbDVEbHVkqnyCqKVqDol4cAPp9rXiJKi9/ODsd6ZWL+65eGu1FcVFal2IV2
         arVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iWqrZShOD+kRcre329kKVLGBiUFIo9BUZTpNDUEM+ic=;
        b=c82HSMwo3y6HRwdWCWss4q+ooNqIbBJEi1gSCtewU2ecKKvVNyCTpiA9N4bfy6BHAF
         X/i2ilQq47bT2+nrfon4N4uw22RxZobn69QBozNhZLolGsMqITrnl832ULXlnXb7BGcW
         h3WDPNTdqnwTDjPkaLMlgqtLV55V1riXjw0EWplh3zggKXa3vdQzGjvaERmHGeg7d81e
         Vac5AIOpURB0WLmDL00blJlqigiWSKJoJUYE2Qj9PwDaQVk8SFqNsqb7nmuHDbyaAg3F
         0GgT26mI/spge967kdx/4GyjUQPxq/Ur41s+j7Hf21jNTCl7V/cYkij0La4J5SWIYL6K
         sltQ==
X-Gm-Message-State: AOAM533Q683IL3GppxnNVbqT0sJ14GlFH5w5W/VYuOnuN8cJbd5+36+w
        Z1J/4byPADXjMQ7Nm5UoMGJXBA==
X-Google-Smtp-Source: ABdhPJyRRjRCoFGRFb7jaVk+jooMV/sXva+uftYeveZslt+PAcJG3pQJq4SW9oIhiR+Ru8ji9TDGmw==
X-Received: by 2002:a0c:df0f:: with SMTP id g15mr18206883qvl.19.1605897163961;
        Fri, 20 Nov 2020 10:32:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w30sm2568810qkw.24.2020.11.20.10.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 10:32:43 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kgBD8-008upw-RH; Fri, 20 Nov 2020 14:32:42 -0400
Date:   Fri, 20 Nov 2020 14:32:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+76c931ae5fdee51fff5b@syzkaller.appspotmail.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in rdma_destroy_id
Message-ID: <20201120183242.GR244516@ziepe.ca>
References: <0000000000002653f805b48b50f5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002653f805b48b50f5@google.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 20, 2020 at 07:15:21AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    20529233 Add linux-next specific files for 20201118
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=124ae36e500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4fb58b6526b3c1
> dashboard link: https://syzkaller.appspot.com/bug?extid=76c931ae5fdee51fff5b
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+76c931ae5fdee51fff5b@syzkaller.appspotmail.com

#syz dup: possible deadlock in _destroy_id

