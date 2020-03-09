Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E473D17E0B3
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2020 13:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCIM5v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Mar 2020 08:57:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43877 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgCIM5v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Mar 2020 08:57:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id l13so1754019qtv.10
        for <linux-rdma@vger.kernel.org>; Mon, 09 Mar 2020 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=miMLkBCmq91TU9yIA6m0qBL/sLuRcI7EOPQvuCnK0ME=;
        b=PND02V6c5mkNsAkLk07pOXpP9XvnX4Sdm+ABzlZ1nv0JPQ/kAsdlU0JofrwLRESoPH
         CJSDhAOJfPNqAeooa7Z4BlQjtvBloG7P9L7W4NK7c3icW41EFX4lohMbM/6TEwtXZQi1
         SolkrNZGusb9a+Qt2Lk0k+QzLeMnnkBC61PKKgbKW/zug4QUS1Fg00KOrX5Lo2odMTeT
         3wGJmYZFTq12k2X4iAQMIM9Ca5WBn2xilTCI9Bu8nVxSp+u6jQo2iw0/cjMLoQf0Jt1K
         /OZGS+ljIeMI1n3j/DJkgTkS7k5+x5pgW+36xpoiPA+zcoZ/w9XChkMf/9rhpcITFlSE
         l7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=miMLkBCmq91TU9yIA6m0qBL/sLuRcI7EOPQvuCnK0ME=;
        b=okgn7Y3owqrt0r3CKgzifnpPUXZeZCEBOtzNa5TSO3pJymparm7ddkH2rCLuspZaKv
         +3sg3vs1ja6Ak/9IO3TUtHU99LGAqUQXgejOh0sP8wO4bUgUe/w7CBgKvz3M0k7QDUiq
         hsRGd3vSFPcu7A9L9QTArypYId0lLCcQCiyj3863PNxPwl/mVzhRHzWfjKkidEwUoc0J
         L7uaYPiWs8Za/9KVRRXaPOB3OEt461B/AN3My0cW9sFhRjN5dDn+rihKVGWhH4JAtgmt
         PDMzPPs0vWSLz+yswtQjO79TEykjN400+Gi0oCupCRZhPN9W9rVxs1znPaohOfTXrYVU
         FJBw==
X-Gm-Message-State: ANhLgQ0ALPRamHrGIqxBozTtOGLwNGw9yLYxYpsQaWwrTy0MTB5Gw4G5
        3oB5CAbI2SKpgAvXdUzp0gE4cw==
X-Google-Smtp-Source: ADFU+vu6bvfxesOU9AguoQQ2yTyNVmKJCW8oR4oSVQnin4fkXmnK8mlGS93WLKLIinDLJYbIQny60Q==
X-Received: by 2002:ac8:4659:: with SMTP id f25mr14091414qto.273.1583758668881;
        Mon, 09 Mar 2020 05:57:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x22sm870587qki.54.2020.03.09.05.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 05:57:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBHyd-00087L-Pc; Mon, 09 Mar 2020 09:57:47 -0300
Date:   Mon, 9 Mar 2020 09:57:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+3fbea977bd382a4e6140@syzkaller.appspotmail.com>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in siw_create_listen
Message-ID: <20200309125747.GP31668@ziepe.ca>
References: <000000000000161ee805a039a49e@google.com>
 <000000000000002a8c05a0600814@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000002a8c05a0600814@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 08, 2020 at 04:13:15PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    425c075d Merge branch 'tun-debug'
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1531a0b1e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=598678fc6e800071
> dashboard link: https://syzkaller.appspot.com/bug?extid=3fbea977bd382a4e6140
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e3df31e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163d0439e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3fbea977bd382a4e6140@syzkaller.appspotmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next

Jason
