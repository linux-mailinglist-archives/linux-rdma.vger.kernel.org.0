Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961A141EEA9
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Oct 2021 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353457AbhJANgn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Oct 2021 09:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhJANgm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Oct 2021 09:36:42 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB35CC06177C
        for <linux-rdma@vger.kernel.org>; Fri,  1 Oct 2021 06:34:58 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 194so9070807qkj.11
        for <linux-rdma@vger.kernel.org>; Fri, 01 Oct 2021 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nREMf4tL4x0QCDrGbhB6naN2AlUQjiFQFd83vMWD2wU=;
        b=ZvPwcSGH7TJAox5tXqYlXVFyQaH8/UzRF+bt7ux4RjC1u+5MlvX/jY/f8j0Sbc0rLV
         Kfm2dDYY4NnPfH/P74Q0G4qt17F0x3Xdq8KD/dExKS5nlVRmx+f15B0KcWKyBmuBXpdA
         9L8PqBW+UstLmxAocyhHRZ5minLSzxtoudQryWq/G/ONEuVnM4UamOCJcv8cqapTxYJ1
         ZCCAxyE1cNwJuDiXRRvCq0ET6cZJ4cPPKbZuJ4La6g3N2rC+iXA788mWo5WbLEnI18jO
         IZsaz5+q6jVPNNXB5krYDyXaIM6cB4ng1HsSn76BCwWTiNXMLAMlfOQg1RxkR2wSKxWx
         px+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nREMf4tL4x0QCDrGbhB6naN2AlUQjiFQFd83vMWD2wU=;
        b=V657WObwcOfenNTb4AzoE2PVqrt2dwq+wnVHxvOgJWa3e6iWsHjpQTqa08Xga1rKWv
         fZVbDtPVq9woudQSjXh9ccSz9uxom3h6OqVrH0gVr3oSbwixA9nmVxwO4fNHOOlCyO0k
         0p9MaIHsIQohS9cJ2R8oZahrC+qV7XyhOpjgabc85nU+/UcvjPbJWJneJlZMg5i7YH/U
         OthzuwmcPEFkuFH7eqYs8MvdYdWMr8SJ3EWDiyUtZ17hS54Wcs3SN0HOgMbGdHWVro3o
         Cle2wWFfQZeW2QFMa4VELyQiro1QdPnh7IF7MmC1DUGJumQux/IQPVxSOSQLdH1kmkRK
         Z/Rw==
X-Gm-Message-State: AOAM532naAsr+x0NxQtoEUQ6D9W4+7SUBxxOAtlZcjZSET0nVFpVNDCl
        bUX0TMyUBvIuBmPDaFcr3ewdnRnjTwahig==
X-Google-Smtp-Source: ABdhPJygNLNWgV8/DSEupAw2+JBqgKBIQHsIhWkAlOb1yoFu5MSleY5IbdwvDUQmCLKhUqqC2nc6Ow==
X-Received: by 2002:a37:b45:: with SMTP id 66mr9537884qkl.78.1633095297356;
        Fri, 01 Oct 2021 06:34:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id j184sm3100677qkd.74.2021.10.01.06.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 06:34:56 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mWIgi-008Qq1-0w; Fri, 01 Oct 2021 10:34:56 -0300
Date:   Fri, 1 Oct 2021 10:34:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+ae4de2b6e34e89637fc2@syzkaller.appspotmail.com>
Cc:     avihaih@nvidia.com, dledford@redhat.com, haakon.bugge@oracle.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (5)
Message-ID: <20211001133456.GM3544071@ziepe.ca>
References: <00000000000073132c05cd496b83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000073132c05cd496b83@google.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 01, 2021 at 05:08:22AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5816b3e6577e Linux 5.15-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13519b5f300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9290a409049988d4
> dashboard link: https://syzkaller.appspot.com/bug?extid=ae4de2b6e34e89637fc2
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

#syz dup: KASAN: use-after-free Read in addr_handler (4)

Jason
