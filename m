Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9903FF888
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Sep 2021 02:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbhICA7L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 20:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234290AbhICA7L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 20:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630630692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dweDyOYjcmK69myJXjFnVZ/WQ447Q7GxQ0zWDd/1fFI=;
        b=BeBOEe6BK/egvYZju1heTP/MSRWakmziaTzNOKXjTfWUHxtWU7rjb6q+EY6ZUEc7vxPbWa
        dhtM1ZCZgLuADq5ClmuHvcytaKdLWtGO0wyq+QF2eq2rVxKgXZlRRRamZaBlwboYYhZbfZ
        58oTdQXUc/NqREd1wIJB2bBICebrPMk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-5bKNRDHLNzWAKC_LdYj4ow-1; Thu, 02 Sep 2021 20:58:10 -0400
X-MC-Unique: 5bKNRDHLNzWAKC_LdYj4ow-1
Received: by mail-lj1-f199.google.com with SMTP id w11-20020a2e998b000000b001c071349c96so1610929lji.15
        for <linux-rdma@vger.kernel.org>; Thu, 02 Sep 2021 17:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dweDyOYjcmK69myJXjFnVZ/WQ447Q7GxQ0zWDd/1fFI=;
        b=qadTzmYlhzv2s8OcvZefrtIf1QAuCQhZkD5ahDw7xathtD/lnjcjlmm4SrPxkolr43
         H+sWVp03byjsAn0yu8NDARDUPEZ4KaGq+Va4GL09cRyEGZ1DkrVSm51hPZGUmqbbTUz1
         lD/E7y2OiWOD36+j47+QXXkw0paD3PmfsgfWUP1IrhjsJGrkMoDqBVQAUmoVU972ukCW
         H6PS+s7rWpzdyfCgcsphobXq7RuV+mLtAGwZqgEu7/PGH5LCpMneIQ2CNcNfiM6gzoqD
         M+kzsbNP510M5zeZW0EHS91QBhBl8mfhrHXKoAFPk6XHzx9buqXsw5s8XSqGVfNa3VMJ
         umAQ==
X-Gm-Message-State: AOAM531TyyXRlWfiZI+SpEV13kclbeYeYfsUddiyAmYGvveAUEbfab0E
        4CJWOzl7K3T2pDQn7D4F6qBcLH1uCyuuzWazqZAjPhgpHSJzq+5RJXyf6vY99L7t6480Tqk2G77
        pjAKlnxoIdzy7jfITv4NhzM4AknOE7j3ewGKK3Q==
X-Received: by 2002:a2e:801a:: with SMTP id j26mr822117ljg.385.1630630689438;
        Thu, 02 Sep 2021 17:58:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxv+cC/51MDemLJlyzI1/sE33ac9c6oU7NLMZ7/q8qpYz09PPl+mZKp6gK057IgTiCC/j+wiUqVqDbsh2Yb5aA=
X-Received: by 2002:a2e:801a:: with SMTP id j26mr822105ljg.385.1630630689270;
 Thu, 02 Sep 2021 17:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210902130625.25277-1-weijunji@bytedance.com>
In-Reply-To: <20210902130625.25277-1-weijunji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 3 Sep 2021 08:57:57 +0800
Message-ID: <CACGkMEsz4HQKpaw3P=ODXvN2AuqO+_YE0UHpzOFk5GbzX13V4A@mail.gmail.com>
Subject: Re: [RFC 0/5] VirtIO RDMA
To:     Junji Wei <weijunji@bytedance.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, mst <mst@redhat.com>,
        yuval.shaia.ml@gmail.com, marcel.apfelbaum@gmail.com,
        Cornelia Huck <cohuck@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Yongji Xie <xieyongji@bytedance.com>,
        =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
        linux-rdma@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 2, 2021 at 9:07 PM Junji Wei <weijunji@bytedance.com> wrote:
>
> Hi all,
>
> This RFC aims to reopen the discussion of Virtio RDMA.
> Now this is based on Yuval Shaia's RFC "VirtIO RDMA"
> which implemented a frame for Virtio RDMA and a simple
> control path (Not sure if Yuval Shaia has any further
> plan for it).
>
> We try to extend this work and implement a simple
> data-path and a completed control path. Now this can
> work with SEND, RECV and REG_MR in kernel. There is a
> simple test module in this patch that can communicate
> with ibv_rc_pingpong in rdma-core.
>
> During doing this work, we have found some problems and
> would like to ask for some suggestions from community:

I think it would be beneficial if you can post a spec patch.

Thanks

