Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D777B3FFB3A
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Sep 2021 09:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhICHnF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Sep 2021 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhICHnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Sep 2021 03:43:04 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C642AC061575
        for <linux-rdma@vger.kernel.org>; Fri,  3 Sep 2021 00:42:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so3343840pjx.5
        for <linux-rdma@vger.kernel.org>; Fri, 03 Sep 2021 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nXREGH7UcssxsGls4TpqN/3My2ILjgwwjSnTKo7Ckl4=;
        b=KiXEQsXdfuZJShCri4LUNWJ9o+nCGc+6qCDmPFb67nPxAkxIsZ/yUP1bHvd6wnlSEv
         rTozjTwxXQHPdTlHIYLC2ZFsdmdCTCzktNnQ7aXNdDi5978cszU/V78KWGnYsk/b5WlE
         fHmJcxv/sXp5/rtlqW8K5VOg+uXnmWmkBVpRgU1OmlsUUu5BEBNIiWwKxOmJ2/DN45xN
         lvb3bpM8pVjWIAhf+PIuwiWQ1M5HI0AGpyU0yrFCB7Lmf8sL+ywxZLuKL/Zb0xxSQboT
         wh6Oa0M9LM/zi2RzjgzLTdU4TokBi1SL9YQKFYmSIMkDKELGEhw/XZz3yiIVkjrYv0DS
         dveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nXREGH7UcssxsGls4TpqN/3My2ILjgwwjSnTKo7Ckl4=;
        b=UzOc+4mThic4RRq68wsUt+TpEx+olh49aRLaw3gJbS4sm7gNJUOM2p95QfonabUJOv
         BGXof6ZyQWaFkcCc27J7qtxkFSi4GztSw42Zb2Hnmm/qMx+ea+TOtWdIuvVp0MNWAff8
         H5Rdd+vsdJoWHDOSeX05FnSzeOl9zQvVtSdyjAn/j7ko07R/dXlUnXRWYGnW1nngQhKo
         RIOlThUZ7rkYYJT23Th7d0xvka+pV0afEQAxG1pXVhmX3qTnmPLMnegVT4X3pCMmcoJ/
         A0FdbZI3dUTo6EUSl43891NDxkhouUGnMWRKWs1kz9oK5BCJ3JrJXhIAGMtj9f2b3bqd
         jt9A==
X-Gm-Message-State: AOAM532V/bys/4pKSXkMfRwD2IjcqCf93aNzTJoGhPecILE0hUN+0Uj7
        hp7JsTqEIfIYGPsrZS2KF17JDg==
X-Google-Smtp-Source: ABdhPJx9jFfBu+nlD8vhSJGr3W8ucdz7n747tSwepSc5EQ6/yAYK1sNLaqT1nRm3XypVmOJ/vRgOqQ==
X-Received: by 2002:a17:90a:c89:: with SMTP id v9mr2482459pja.175.1630654924349;
        Fri, 03 Sep 2021 00:42:04 -0700 (PDT)
Received: from smtpclient.apple ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id u24sm4656287pfm.81.2021.09.03.00.41.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Sep 2021 00:42:03 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [RFC 0/5] VirtIO RDMA
From:   =?utf-8?B?6a2P5L+K5ZCJ?= <weijunji@bytedance.com>
In-Reply-To: <CACGkMEsz4HQKpaw3P=ODXvN2AuqO+_YE0UHpzOFk5GbzX13V4A@mail.gmail.com>
Date:   Fri, 3 Sep 2021 15:41:57 +0800
Cc:     dledford@redhat.com, jgg@ziepe.ca, mst <mst@redhat.com>,
        yuval.shaia.ml@gmail.com, marcel.apfelbaum@gmail.com,
        Cornelia Huck <cohuck@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Yongji Xie <xieyongji@bytedance.com>,
        =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
        linux-rdma@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: 7bit
Message-Id: <4ED3B57F-A9D1-4A61-AA1D-94D14A932012@bytedance.com>
References: <20210902130625.25277-1-weijunji@bytedance.com>
 <CACGkMEsz4HQKpaw3P=ODXvN2AuqO+_YE0UHpzOFk5GbzX13V4A@mail.gmail.com>
To:     Jason Wang <jasowang@redhat.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Sep 3, 2021, at 8:57 AM, Jason Wang <jasowang@redhat.com> wrote:
> 
> On Thu, Sep 2, 2021 at 9:07 PM Junji Wei <weijunji@bytedance.com> wrote:
>> 
>> Hi all,
>> 
>> This RFC aims to reopen the discussion of Virtio RDMA.
>> Now this is based on Yuval Shaia's RFC "VirtIO RDMA"
>> which implemented a frame for Virtio RDMA and a simple
>> control path (Not sure if Yuval Shaia has any further
>> plan for it).
>> 
>> We try to extend this work and implement a simple
>> data-path and a completed control path. Now this can
>> work with SEND, RECV and REG_MR in kernel. There is a
>> simple test module in this patch that can communicate
>> with ibv_rc_pingpong in rdma-core.
>> 
>> During doing this work, we have found some problems and
>> would like to ask for some suggestions from community:
> 
> I think it would be beneficial if you can post a spec patch.

Ok, I will do it.

Thanks

