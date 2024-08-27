Return-Path: <linux-rdma+bounces-4582-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB95B960AA3
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 14:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E911F2390C
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 12:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D541BA87F;
	Tue, 27 Aug 2024 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iadtKOI4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9419DF60
	for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762363; cv=none; b=KPvHix3++uj/hFcSqk+ESxShNiRPvii3X1QaU+37GFNOUsDe1STaN1EcFcONnWYXpUw/Zwa+nH96Ygc38Ti0WZ3ZedfqNq/F2s7TkGmc5HcAcWrTDU/cOG17NZ6nzZ2L5/B69C6UC58WXBwcwSyH6w5zwiUS5mAgMaWoKTme4HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762363; c=relaxed/simple;
	bh=KAlCCpmT/9t8oaYMlyhDD85zHlBN7V+nnG/N1J53hko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBHFkYupvsVdDol0GYaCSH2fNWvQwlOeguN6AP+LQwKru6OweTkXwi4PoQ+FPnuR7i05eN4+cl8+nx9+5LQm37Bp/Kc4W0h0we/T+d64TgWChexoA5iES1Mx7zjAL/JfOODzdNa+Ceur5aguZY5j3RYon15QeYbhqfKpJ0T1OwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iadtKOI4; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a66b813745so306495285a.3
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2024 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724762361; x=1725367161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PkUwxkFlrf57Mj6zwExkro79TTn594WgUNdEIuEKE4U=;
        b=iadtKOI4KP70TEUEyPr5TBLWtmKarS1R2jfQ2iK57Ej+9wGg/qLmp8yoo3KDitBi4N
         YRQ72EjhMEzmF+x+m5LrZRiPd8pa7PfC7tx/85AjuWeEeuXGBeCoyAiArkWoePQXibmP
         hgluVPoiFbIj0Ij20X4lfvOVHdXAfCytgEgAMuSwTMwUlFDSZLCnUgIg0rrHUMnjNqim
         ywD44gyJbFVPrzeGImuPt/RN65nkioL4OSaVcoqFmHtbqyaUne9FETEikAvr+2/hMz8y
         /oNVYpqL7qkZPv9FE2CzPtH+iMSp1V1Hy2CobCX2FtXqDMFVMF2ov5rpeXIcoEBmwEQ3
         NykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724762361; x=1725367161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkUwxkFlrf57Mj6zwExkro79TTn594WgUNdEIuEKE4U=;
        b=oF1F3qT8GhdUQhMPa0mGe3xclrStxrseMPLTeGmWmSDxmAi1/SgnZAJDtQUuxZevBT
         HDQp5I8ELfF8aPl9XlppVH4f2nmblZ3xnc/UwfcQkVd5l0/9j+gO/rXJnmU5Fjjx1P4g
         k/OOws2HtKlY5na3uIfrz8APz63Oh1w9oJ9uF/6kRi+vdk6vGCMofi8YIGJ+ZE6irCbj
         STtkUJAZhZ3Rlys7l/EIDl5rwBBVhR+Y1yK2Ytxkf9rhHCKsR+9j91ypvI+gdgBWrbh+
         OXUibhVaxe6Kl61g6Jo2AG+uu2indF6gUQ2kORKlUJUWSlBRcnH3D8yVWe37kn1XSszf
         RveQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMtz4juSmDoKh8Jil+POGzerJTU2SiX5dR/6vkDZP9StLcieX4ExxsCLzfDg45SYV/uMSMsaILGjSX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiv5QzTAEK3IlcOZN2MNoWNos6fImt16hKOXmDkhp0B9TE2kW7
	8KJtUkkBUtkcKy3VP6Kd7nZu08SADbsTbiwfg8aYnxS72VNmy33Ck6mYjGqshzwgHpXqH1+dNo4
	P
X-Google-Smtp-Source: AGHT+IFzTI+Ku3mQCS8VTwCw2rVwJMbFYj9UyJ06icNcECO9N8JN6KnBhVOKQ4ZSK7KlQorLkBuv8A==
X-Received: by 2002:a05:620a:1a83:b0:79f:1d:c48a with SMTP id af79cd13be357-7a6897a8851mr1468459685a.59.1724762360743;
        Tue, 27 Aug 2024 05:39:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41cdbcsm542698285a.133.2024.08.27.05.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:39:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sivTj-000fgI-Sy;
	Tue, 27 Aug 2024 09:39:19 -0300
Date: Tue, 27 Aug 2024 09:39:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: syzbot <syzbot+4d0c396361b5dc5d610f@syzkaller.appspotmail.com>
Cc: leon@kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] INFO: task hung in disable_device
Message-ID: <20240827123919.GN3468552@ziepe.ca>
References: <000000000000cc73830620a1d540@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000cc73830620a1d540@google.com>

On Mon, Aug 26, 2024 at 08:28:29PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    872cf28b8df9 Merge tag 'platform-drivers-x86-v6.11-4' of g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=138e4ff5980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
> dashboard link: https://syzkaller.appspot.com/bug?extid=4d0c396361b5dc5d610f
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.

And the console output is really hard to understand how we got here.

There are no syz commands that seem to have anything to do with rdma
or ib at all, yet somehow a rdma device (rxe/siw?) was created and
destroyed.

The console output format has changed, has something gone wrong with
this? Usually I would expect the last "executing program" to be a
netlink operation triggering device unregister...

> Workqueue: ib-unreg-wq ib_unregister_work
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5188 [inline]
>  __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
>  __schedule_loop kernel/sched/core.c:6606 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6621
>  schedule_timeout+0xb0/0x310 kernel/time/timer.c:2557
>  do_wait_for_common kernel/sched/completion.c:95 [inline]
>  __wait_for_common kernel/sched/completion.c:116 [inline]
>  wait_for_common kernel/sched/completion.c:127 [inline]
>  wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
>  disable_device+0x1c7/0x360 drivers/infiniband/core/device.c:1295
>  __ib_unregister_device+0x2ac/0x3c0 drivers/infiniband/core/device.c:1493
>  ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1604
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
>  worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
>  kthread+0x2f2/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>

This trace is almost certainly a refcount leak. Presumably on some
error path.

Without a reproducer, or some kind of clue what syzkaller was doing it
doesn't seem like any progress is possible.

Jason

