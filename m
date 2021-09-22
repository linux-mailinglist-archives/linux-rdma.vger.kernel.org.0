Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4824741487A
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 14:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhIVMKX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 08:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbhIVMKW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Sep 2021 08:10:22 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5855C061574
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:08:52 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g14so2569972pfm.1
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lCLhWfKxcbszqzc7oQk+utveO/inesSB2yNmkLK60Rk=;
        b=OCkUFJV/8JT3t6/UDUPnnOx2ABvf26fAQQhNuluDLsZsiHog5SjXsk2eBS/AmzxG4P
         XFTj+vkTdTvNolmP87qiTuAZkbuwFe8bVu5Pp3+ql8t6KVEQqBwJSSlJOWrKLRjOxh95
         AFSiOtyyfM3w4ON26dQBsDH/gR7tu/qM1V2kMsf7EpcQ7aQt7Zp8NL1plgoNmZd6s9Ye
         PeRnaVBYA/ioIDnU6QeQNXUSygVDx/KVcmiqZ+EadamiLpKHp3SjVz+xGrSMBBWiebp7
         0A/b2so4h95myPrE9iLpm1gZnAXzCpNtJWraWq1kdHl9CfezDHFvXYPfV2lxF2jVCTV9
         sC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lCLhWfKxcbszqzc7oQk+utveO/inesSB2yNmkLK60Rk=;
        b=JlCckma+ITzPFmS56d0PClmZJ3SrF/eD0QuJLXlvQt6ewrUkjaq29jMN0dZUhGTfb5
         38/ea7po1y5Qu2l2YdeO9cn2u7mBRr5cvE3+NF90796vhAi1C+KxbKaQbnqK/qD3kjAi
         fL2XPXBLlPRJ5Phe4ukWAEv/SZBCg5hOboTFX9g9Rg5cxwCEySJC/e1iSECFx7hIMEpv
         fRZ3lpuKcSEkCrumI0yh94nwyU7hF53tTVnogv7xQsg2NqftYQPPFijILQC40izbis/1
         xS/EBRs2QyvLFLLSGc2kTRBHciwA/r2shsTkOdmqmiB9U7SYM+2cCLXplGW1MLW/cJwB
         hoHw==
X-Gm-Message-State: AOAM532oYX3YZqPfehA29kqnAJIGeuY5WcgCnNxEYyJUHxenK0mzfVaq
        edtn7CILSPXXsGcJs64rc/J82A==
X-Google-Smtp-Source: ABdhPJwMsNBO/mIhyJx2SCpRm+/aiBSwo7IruX11zjKVrc/RomyeLppBKHkJnxV9+3c+yIXn1fR2Cw==
X-Received: by 2002:aa7:93c9:0:b0:43c:f4f5:aac2 with SMTP id y9-20020aa793c9000000b0043cf4f5aac2mr34779616pff.11.1632312532313;
        Wed, 22 Sep 2021 05:08:52 -0700 (PDT)
Received: from smtpclient.apple ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id mv6sm2234606pjb.16.2021.09.22.05.08.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Sep 2021 05:08:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [RFC 0/5] VirtIO RDMA
From:   Junji Wei <weijunji@bytedance.com>
In-Reply-To: <20210915134301.GA211485@nvidia.com>
Date:   Wed, 22 Sep 2021 20:08:44 +0800
Cc:     Doug Ledford <dledford@redhat.com>, mst <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, yuval.shaia.ml@gmail.com,
        marcel.apfelbaum@gmail.com, Cornelia Huck <cohuck@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Yongji Xie <xieyongji@bytedance.com>,
        =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: 7bit
Message-Id: <E8353F66-4F9E-4A6A-8AB2-2A7F84DF4104@bytedance.com>
References: <20210902130625.25277-1-weijunji@bytedance.com>
 <20210915134301.GA211485@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> On Sep 15, 2021, at 9:43 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> On Thu, Sep 02, 2021 at 09:06:20PM +0800, Junji Wei wrote:
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
> These seem like serious problems! Shouldn't these be solved before
> sending patches?
> 
>> 1. Each qp need two VQ, but qemu default only support 1024 VQ.
>>   I think it is possible to multiplex the VQ, since the
>>   cmd_post_send carry the qpn in request.
> 
> QPs and CQs need to have predictable fixed WQE sizes, I don't know how
> you can reasonably expect to map them to a shared queue.

Yes, it is a bad idea to multiplex the VQ. If we need more VQ,
we can extend QEMU and virtio spec.

>> 2. The virtio-rdma device's gid should equal to host rdma
>>   device's gid. This means that we cannot use gid cache in
>>   rdma subsystem. And theoretically the gid should also equal
>>   to the device's netdev's ip address, how can we deal with
>>   this conflict.
> 
> You have to follow the correct semantics, the GID flows from the guest
> into the host and updates the hosts GID table, not the other way
> around.

Sure, this is my misunderstanding.

>> 3. How to support DMA mr? The verbs in host cannot support it.
>>   And it seems hard to ping whole guest physical memory in qemu.
> 
> Either you have to trap the FRWR in the hypervisor and pin the memory,
> remap the MR, etc or you have to pin the entire guest and rely on
> something like memory windows to emulate FRWR.

We want to implement an emulated RDMA device in userspace. Since
we can directly access guest's physical memory in QEMU, it will be
easy to support DMA mr.

>> 4. The FRMR api need to set key of MR through IB_WR_REG_MR.
>>   But it is impossible to change a key of mr using uverbs.
> 
> FRMR is more like memory windows in user space, you can't support it
> using just regular MRs.

It is hard to support this using uverbs, but it is easy to support
with uRDMA that we can get full control of mrs.

>> 5. The GSI is not supported now. And we think it's a problem that
>>   when the host receive a GSI package, it doesn't know which
>>   device it belongs to.
> 
> Of course, GSI packets are not virtualized. You need to somehow
> capture GSI messages for the entire GID that the guest is using. We
> don't have any API to do this in userspace.

If we implement uRDMA device in QEMU, there is no need to distinguish
which device it belongs to, because there is only one device.

Thanks.

Junji
