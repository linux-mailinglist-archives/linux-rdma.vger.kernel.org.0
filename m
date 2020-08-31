Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E4825847E
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Sep 2020 01:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgHaXpf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 19:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgHaXpe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 19:45:34 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4A3C061573
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 16:45:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id v12so8723346ljc.10
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 16:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0QADmPJ3pJP8sMkX/yxajyr3yYhJMC3qgwVyMYQIlHQ=;
        b=vKLyRZ+kyD3hvbezSyIUNTPucb7tWIMc43/UVGnBPUV/E4JwjaVvULaadbtwOBddJm
         OVaDPl/rnn1JzQZJu1Glzg1fT7rFx72ne4wYM4gzy2kXp99F3uUs303Z4WppLkYCMf4d
         6TaldNzGVLJSmlsjJdTJLIJ9IV9a+vCAqYEH7BhskBJpDW68N0K+COjvZpqF7OTDYhc2
         qAbHxupiHpQgGrvvd0o5Zez/MC/8n+pFNrxHQnk8gRmDiHKAhnTiMSxl7C9lOErymYJG
         UTKgAe38kd7Ed8OL9KTktCxQtOwoARZkphT63DFyHNl/Fr0AmDN5ptERpefbbhgr8dXj
         kosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0QADmPJ3pJP8sMkX/yxajyr3yYhJMC3qgwVyMYQIlHQ=;
        b=aSQ98HtyVEJT3lZ2vSMvo7Fux6WCXWvkwIGJbsw+zME1CoXtOO2O1+Go4MOrPxF52U
         JZY0HG6JFtjxEThspGu5zfjOnahSaQ/8bWL8n9sXxPNbxjDyRSUVK/VopKbb+9bng8D3
         2YAxlexHnDK78/Y8Dsb8v1M4P3cbr4jHV1k21GkOKCvb7Wo/5v1ZKWHRu1jCE1u7mJfk
         YasmlIyJGtSppbKdGXOdpKTQUVFeJXtoc2+NaX1mxF+EHcY62MzER9HNt7Z/gOrflY1C
         F/8bNSJlVMmATMHertT5BXEXBgXulq3XoBiQYHC3S4ZSBelpAjXD33DAwV3PZ4k9jvaY
         eSpA==
X-Gm-Message-State: AOAM531kXFUodb/iYmR07IRsieOag5c0ZoVFpe/6hysR8D5pqvAbAqyj
        PtrbZqxNXp0iLH7uQXqsAKv8tt5DRlGe0fgfKRzmTw==
X-Google-Smtp-Source: ABdhPJyN1IfSCTBMZo7erN2+t4wlBEpfwhLLPeP5dUh6Nb6oD9HqhzG19gbpNo6rkTk1cpXNObdD4O89/VgN8YlMf4c=
X-Received: by 2002:a2e:9617:: with SMTP id v23mr1756141ljh.365.1598917532171;
 Mon, 31 Aug 2020 16:45:32 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Tue, 1 Sep 2020 01:45:06 +0200
Message-ID: <CAG48ez2EFXnDEue=bOs6n01FHGa4rUnwET6hBVNjcKoMjR9Y_Q@mail.gmail.com>
Subject: buggy-looking mm_struct refcounting in HFI1 infiniband driver
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Linux-MM <linux-mm@kvack.org>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Dean Luick <dean.luick@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi!

mm_struct has two refcounts: ->mm_users for references that pin
everything (including page tables, VMAs, ...) and ->mm_count (just
protects the mm_struct itself and the pgd, but not the page tables or
VMAs).

struct hfi1_filedata has a member ->mm that holds a ->mm_count reference:

static int hfi1_file_open(struct inode *inode, struct file *fp)
{
        struct hfi1_filedata *fd;
[...]
        fd->mm = current->mm;
        mmgrab(fd->mm); // increments ->mm_count
[...]
}

It looks like that's from commit
e0cf75deab8155334c8228eb7f097b15127d0a49 ("IB/hfi1: Fix mm_struct use
after free").

However, e.g. the call chain hfi1_file_ioctl() -> user_exp_rcv_setup()
-> hfi1_user_exp_rcv_setup() -> pin_rcv_pages() ->
hfi1_acquire_user_pages() -> pin_user_pages_fast() can end up
traversing VMAs without holding any ->mm_users reference, as far as I
can tell. That will probably result in kernel memory corruption if
that races the wrong way with an exiting task (with the ioctl() call
coming from a task whose ->mm is different from fd->mm).

Disclaimer: I haven't actually tested this - I just stumbled over it
while working on some other stuff, and I don't have any infiniband
hardware to test with. So it might well be that I just missed an
mmget_not_zero() somewhere, or something like that.


AFAICS the three options to fix this, if it indeed is a real bug, would be:

1) use mmget_not_zero() around any operations that need the VMAs
and/or pagetables to be stable (if the mm_struct's virtual memory
should disappear once all tasks that were using it have gone away)
2) take a long-term ->mm_users reference (generally frowned upon, but
may be reasonable if you explicitly want to preserve mm contents even
if all tasks that were using the mm have gone away)
3) bail out early on any operation where `current->mm != fd->mm` and
declare that using the hfi1 fd from another process is not supported
(but I haven't checked whether you might still have some code paths
that will have to remotely operate on the mm_struct)
