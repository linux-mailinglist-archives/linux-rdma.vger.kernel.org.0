Return-Path: <linux-rdma+bounces-1823-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C5589B772
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 08:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577E71F2173C
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 06:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF6579F0;
	Mon,  8 Apr 2024 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuVRc2gz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F41BC31
	for <linux-rdma@vger.kernel.org>; Mon,  8 Apr 2024 06:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712556252; cv=none; b=Yl7nUileeKXh3RFIhN0p8uLL311R7FmQWMcPRZJqm0XoexUFLmsWvOOw8KVMF1dtrwwT/5gLqqnZZ0VcRWRzAb4mC5zVLpOG1bSeC9KHVzNCUxA1qi/MScWFajfqVxXeBaVSiEIHTvn22JOAhs81qzsvbSqT5TBDts+F6OICLD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712556252; c=relaxed/simple;
	bh=z3VKM8ifEz1OYxd9ScJ+qSOMAQizdORgVeNjdf04wic=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FouCnXpEUOtAPFmZLNiH/P0moTfrLnA4PBfvxZkCZhjF5KBgkUfrFv7pZKCTe0syVVyZ8/RTX6OG7jV9DuG2lfvoxLZWk8/+djHAvqll8vSN3xaepSHLdSj3n6Hfp+19aCRxk2isnZRdyJsIaoeBG9vRGkAd3cu6b8N8XOsmX2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GuVRc2gz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712556249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wdfrx2ti+7KT1+Xx3Ua+Avfc5gHDz9AsrT99YKhBbZs=;
	b=GuVRc2gzc7B6EBM2l79pAGWe0rRIkCOd/zVnkfUH71PS1NcSTv7OaUucJazlsUFdzxOLFh
	dbaQ0vudm9S+xDVHNLdoI9tkLU7VSRGXlpmYOFNQHdiWC7u05zQsZhPJqAVAyiSBGUGDpI
	7PMlmkaVUkkBQg1PpwaYWgQzZHiJG9o=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-Anu8xjKFOLu-qyeoNnMMIg-1; Mon, 08 Apr 2024 02:04:06 -0400
X-MC-Unique: Anu8xjKFOLu-qyeoNnMMIg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a49440f7b5so1847415a91.1
        for <linux-rdma@vger.kernel.org>; Sun, 07 Apr 2024 23:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712556243; x=1713161043;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdfrx2ti+7KT1+Xx3Ua+Avfc5gHDz9AsrT99YKhBbZs=;
        b=nL5ElHJFJiGFOma6rl5BVQC4kMXXR9xytUZnCc4pW+kXzXW+HzoO0klnViR15Y8ihg
         rAbH1cpiEuh/9vh16QLTaRCVokhMSZ9jwyA6vYr6QO4aHxQv901dEHswYtIIgmYonlX5
         KRPdUUxF+TDhMCAg7NthIKSo6Hi66iB5xkULc5yE9+bFf39OkMGRX0CeQvt4Lt3a+P5U
         5vzI26a8isghclub6VvvW3XJQ8L/WGvLJA4Br3EYxu2vHYAvF8iiSnrPlK/EcX1FL7/0
         tBx0zERtv2yNEPEpE6Am7bH+f3fR27023htCemkpIbaukb+FdQgdW7F05uINnzNG8tqu
         +Lcw==
X-Gm-Message-State: AOJu0YyoyyRsj68INiNnjsX8AF2++ZquyfmEQCFvuvhFHNZ2yubTaEWL
	NPkYlxTWmxIlRxEra/F5JBR4sIdNCQxLtb+Vg8dx/kDKFEPSk+Vup9nGZJwbK5ZeKHcShj4SrCU
	BLnxGXNjn0niNGTn82vnnLI5/4Fye710m/P+citGIUl/ONjh0JknbpI7D3QHeAbQaHTaPNVwH8C
	ZgWR/Y2afzswclWNSdM0hfc3L0Z1iTIm1NtO5qICDQXo544dVw7g==
X-Received: by 2002:a17:90a:c08c:b0:2a4:a87c:b907 with SMTP id o12-20020a17090ac08c00b002a4a87cb907mr2943416pjs.4.1712556243584;
        Sun, 07 Apr 2024 23:04:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH4MmXQRAwIqD3IjY29U13hfoIEOpCDqe6B4UhYmfFhgbDLBetr2uDzoa2G2CgYVtFR9uF3foIHFbetKVP39Y=
X-Received: by 2002:a17:90a:c08c:b0:2a4:a87c:b907 with SMTP id
 o12-20020a17090ac08c00b002a4a87cb907mr2943406pjs.4.1712556243268; Sun, 07 Apr
 2024 23:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 8 Apr 2024 14:03:51 +0800
Message-ID: <CAHj4cs9uQduBHjcsmOGHa8RaNGNMw8k8bBhZdGgdeEKPFeB8qQ@mail.gmail.com>
Subject: [bug report] kmemleak in rdma_core observed during blktests nvme/rdma
 use siw
To: RDMA mailing list <linux-rdma@vger.kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Jason Gunthorpe <jgg@nvidia.com>, leonro@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hi
I found the below kmemleak issue during blktests nvme/rdma on the
latest linux-rdma/for-next, please help check it and let me know if
you need any info/testing for it, thanks.

# dmesg | grep kmemleak
[   67.130652] kmemleak: Kernel memory leak detector initialized (mem
pool available: 36041)
[   67.130728] kmemleak: Automatic memory scanning thread started
[ 1051.771867] kmemleak: 2 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
[ 1832.796189] kmemleak: 8 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
[ 2578.189075] kmemleak: 17 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
[ 3330.710984] kmemleak: 4 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)

unreferenced object 0xffff88855da53400 (size 192):
  comm "rdma", pid 10630, jiffies 4296575922
  hex dump (first 32 bytes):
    37 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  7...............
    10 34 a5 5d 85 88 ff ff 10 34 a5 5d 85 88 ff ff  .4.].....4.]....
  backtrace (crc 47f66721):
    [<ffffffff911251bd>] kmalloc_trace+0x30d/0x3b0
    [<ffffffffc2640ff7>] alloc_gid_entry+0x47/0x380 [ib_core]
    [<ffffffffc2642206>] add_modify_gid+0x166/0x930 [ib_core]
    [<ffffffffc2643468>] ib_cache_update.part.0+0x6d8/0x910 [ib_core]
    [<ffffffffc2644e1a>] ib_cache_setup_one+0x24a/0x350 [ib_core]
    [<ffffffffc263949e>] ib_register_device+0x9e/0x3a0 [ib_core]
    [<ffffffffc2a3d389>] 0xffffffffc2a3d389
    [<ffffffffc2688cd8>] nldev_newlink+0x2b8/0x520 [ib_core]
    [<ffffffffc2645fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core]
    [<ffffffffc264648c>]
rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
    [<ffffffff9270e7b5>] netlink_unicast+0x445/0x710
    [<ffffffff9270f1f1>] netlink_sendmsg+0x761/0xc40
    [<ffffffff9249db29>] __sys_sendto+0x3a9/0x420
    [<ffffffff9249dc8c>] __x64_sys_sendto+0xdc/0x1b0
    [<ffffffff92db0ad3>] do_syscall_64+0x93/0x180
    [<ffffffff92e00126>] entry_SYSCALL_64_after_hwframe+0x71/0x79

-- 
Best Regards,
  Yi Zhang


