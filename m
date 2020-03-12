Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED25518344D
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 16:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgCLPRv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 11:17:51 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37978 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgCLPRv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Mar 2020 11:17:51 -0400
Received: by mail-qv1-f67.google.com with SMTP id p60so2785195qva.5
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2020 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ucB0jSYs7otvL+Roe4QFbncbHLIRwSx5DdcgmtIHpGI=;
        b=DZqs4TO/YQ1WXVFv4NNXH/1f3ChovaXoOleqUsNYg1faonPhV3acnKgRE9fakNAfQ+
         ojunQdZ18rtTzshYz8pc69vmqnTIrLJ/nAqGlbFAZAXa0oFo402XVNje7hc3PK9vBw6P
         bIGSwaNxXi/Xq5+7Ish4Ljnw1JIJlvJkO/jt+NGa3eAkA5CPprRXfXJZQ5b4JJL5ciw5
         XIuOGnQjX5HVPZ+v8/CuyttFyl6Z804UvSd1RwehT1BeFDPehqwsJAf5ydsT7CCqK9cz
         rKh/yd9Kogy7wrxs3oe8oi+Qxg+qjvwJ0O1wpIUXJ3davcOEOvvGHer0Nd2COT8NfLXb
         gPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ucB0jSYs7otvL+Roe4QFbncbHLIRwSx5DdcgmtIHpGI=;
        b=iiwwcy2QMIs59T8mf6FBlv948acJhBgsd0Vd7yjfQ6ePlUC2s2XqxAQtzZ/m9qQdp5
         bbvn+JQaJTPW6XnhAnrBPSYdU+dAEba0Q7Y8Gj+W+ObYDn+8xGMbd46kCvN0k+84fLdu
         1KEyH3gyk06Bj9TwNUb8GNT5Nf7bK/+jY73Jo1hjwbh5zDc08oTdthmTSAP9Wno5aMVl
         V57mGVaI5hUAvc4Eo8CF25Jyrj82Vm1LYtdGtStLqLYbKwYZ9Zc1x7Wmq8Kkv9FgjPE7
         9+5ZVXTo1+gGtpoHfteVQVT/cLswUvnnRa1+4cZfks2roUZ3odTge4VqDkGDRon68pNW
         H6jw==
X-Gm-Message-State: ANhLgQ3CznqfIUxsRfCPV0Z103j09kGfESCqHqc0l4hd9YDDBTyojCnh
        wMAe/KchbiM+5fYWT+J84KOp7Q==
X-Google-Smtp-Source: ADFU+vsie6w+TM81UO1bRct3BslZgyNzyOBijs1IZJ0N9tNY/N449Z2WBPij8ldirt/oZ1ctWF5yaA==
X-Received: by 2002:a05:6214:1351:: with SMTP id b17mr7980984qvw.251.1584026269849;
        Thu, 12 Mar 2020 08:17:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x188sm18344452qka.53.2020.03.12.08.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 08:17:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCPam-0007eN-LV; Thu, 12 Mar 2020 12:17:48 -0300
Date:   Thu, 12 Mar 2020 12:17:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+c3b8c2a85d37162cc6ab@syzkaller.appspotmail.com>
Cc:     dledford@redhat.com, kamalheib1@gmail.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: ODEBUG bug in remove_client_context
Message-ID: <20200312151748.GP31668@ziepe.ca>
References: <00000000000041c6a905a0a295ef@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000041c6a905a0a295ef@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 11, 2020 at 11:37:12PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    61a09258 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10a6d70de00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7aef917d2e37d731
> dashboard link: https://syzkaller.appspot.com/bug?extid=c3b8c2a85d37162cc6ab
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c3b8c2a85d37162cc6ab@syzkaller.appspotmail.com

#syz dup: WARNING: ODEBUG bug in smc_ib_remove_dev

Jason
