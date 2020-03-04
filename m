Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDEE1791CD
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 14:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgCDN4x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 08:56:53 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:37265 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgCDN4x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 08:56:53 -0500
Received: by mail-qv1-f66.google.com with SMTP id c19so801165qvv.4
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 05:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rhip11nFmECovpT8lVmLzpPD3W/d2rlBg3mYVPTEngc=;
        b=AkyYdyS8nPkSQXKZ597tNqH6yb1SpRkXmJHVHxqVbM5fXqWPTLgiXZJ3zXtK4pSVAZ
         UPFlP20GJMn3HxihX5oIqnYZ6IaPCfYm950jychfRYSv+PwRaJxWif7QD3xgm7qWa2Uy
         uFJAxC4d73bNdcNwBOEOZl3RARtwcJAZEoUOcoh4DAzF/4yzM3GXSs18t08pn79cVE8M
         QsAeQmvhfW4jVZqcn5YI3kB41XAlQdDW6cF7b5WZCOqrAI0r+aHMrqZfuimI6zrmPqg8
         E5KtDlY1q+Y+kBRM42S2u73yhX0o+fyzcqOcnnghBDoQIN60UyIvb7Rn6O+dlg2yr0dn
         g3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rhip11nFmECovpT8lVmLzpPD3W/d2rlBg3mYVPTEngc=;
        b=LNWjtwCBnn5+O6DzQjYTPtZhC0wN0mMo1FNCYH+TLCAGGVeiuvmIHjCSAKGLlQb/wL
         pHHmx6O2IJuA272gM01h++jcUfI0TCs2Im/i15H0lqkKNV7oel1FouLg+IcAUHb5F48l
         UpFBopVSV7ujiV+pNoSr4mt62K6wIkiXS8Eqqw6REaZAgUHesM0m/3yiioolPRBSJM8B
         cf8fwzebAluJh+paSDBLZAlz/E4xu6xfq4H2bpOuA7OkuAPyVSyHhlkOi10vkjCJ2vFY
         eOS0vH5TJp0EYM1Q1AZ91miliF+fMfjWsegx1ppfoHfN13RQPqv/cnp9mfF9w7BQsB3V
         x+ug==
X-Gm-Message-State: ANhLgQ3B8Jh7TBdrRrEJdEOF3jKQL8/UOrw7uRVbTXILmdZxEzkC2Qqu
        vSg38VpPuEbY+nyhHslddbEK7whEO2i69A==
X-Google-Smtp-Source: ADFU+vtecS5RrQ+sxl8h3ySuGL8wlLaGGPNxYxgbTg1P8ayAf6WqAVpCIwyGNMIOM2Za30TvZrOI1w==
X-Received: by 2002:ad4:58b3:: with SMTP id ea19mr2220940qvb.80.1583330210441;
        Wed, 04 Mar 2020 05:56:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id a6sm12453365qkn.104.2020.03.04.05.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 05:56:49 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9UW1-0008CZ-3g; Wed, 04 Mar 2020 09:56:49 -0400
Date:   Wed, 4 Mar 2020 09:56:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+2b10b240fbbed30f10fb@syzkaller.appspotmail.com>
Cc:     chuck.lever@oracle.com, dledford@redhat.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: BUG: corrupted list in cma_listen_on_dev
Message-ID: <20200304135649.GE31668@ziepe.ca>
References: <00000000000020c5d205a001c308@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000020c5d205a001c308@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 03, 2020 at 10:45:12PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11123e65e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
> dashboard link: https://syzkaller.appspot.com/bug?extid=2b10b240fbbed30f10fb
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d3b329e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16291291e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2b10b240fbbed30f10fb@syzkaller.appspotmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
