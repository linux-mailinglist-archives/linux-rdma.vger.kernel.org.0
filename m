Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8999D43E26F
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 15:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhJ1Nno (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 09:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229887AbhJ1Nno (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Oct 2021 09:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635428475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KTap5c0RlCXKDd94JTC8HpgkQNk11wNAD/33vXdtLtc=;
        b=filDkizFhiahLASwmUXG44A84qRd46zC7DlFfnwZzhsMADfLTUu5BfF9w2I9WBQPey4e3L
        hI3cSsKTGjq0ztD6D3lt5LmxflTAED2xRHlgSpf8wgqggdR7KNyWWPUfIrvjlYTdHN3gvr
        7KZTnCOtx65viDnpwXB7+KeTrgQEplY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-X58hadwEO02Dv_Z0mAu_7w-1; Thu, 28 Oct 2021 09:41:14 -0400
X-MC-Unique: X58hadwEO02Dv_Z0mAu_7w-1
Received: by mail-lj1-f200.google.com with SMTP id f6-20020a2e9e86000000b00211349f9ce3so1646360ljk.3
        for <linux-rdma@vger.kernel.org>; Thu, 28 Oct 2021 06:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTap5c0RlCXKDd94JTC8HpgkQNk11wNAD/33vXdtLtc=;
        b=ipGDgFfbUuu8NLIp7nhhEiC76z+mM26XkoENWSKB9lLVfxnf33j99UFRWPZ+hJMLVf
         btpd5Yyya2kppJ+n1LrXtgwlOrcSt2oWIl9fHMAg9w6W2/rl1lEhHDzpbNIYmrRwLlBC
         nyOlkwJFYdjaHc1TfIqn583MTAXnNLuDYJq31WFOHghHKdzRs2uWaUZMbWSUOZCHMJbM
         BPvdUgPDkt3JL28yv7AS0lklqQzmculI4Ow0v0xSg5Zo9KPoLt42VW38E0uBDUmwF3zl
         LYXYYKyeBFLc2uR6omE81SCzu/3k0jIC0e84MXb8lvZpUSdEaZJkZvFf0yZkskk2/wXN
         QJ1Q==
X-Gm-Message-State: AOAM533BzvWtzFAP91Iw1vlZY7LF3/qWwD0KfleG0r6AUsz19IGaC3Hw
        CHdBCIeJNiUxjkgEvOLoh1+FEBzkmXIdI24A/wfhLFz6fwv0Lw5RjSbioTXH6ODkQQEz2Y67TIb
        hZmEP8RsZ/Amrb7wk0fKxDbvCsNEocXmMDJOXrQ==
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr2607639lji.287.1635428472672;
        Thu, 28 Oct 2021 06:41:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8CCERc8H8IxastE0C7FToorTH18uco0hFJp9Dq9g0ZQuIJcK4UNh3gCDz4l/h7eS0R61SExgQ0k2nToymf8w=
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr2607623lji.287.1635428472481;
 Thu, 28 Oct 2021 06:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211028124426.26694.48584.stgit@awfm-01.cornelisnetworks.com>
 <20211028124606.26694.71567.stgit@awfm-01.cornelisnetworks.com>
 <CAGbH50to=YUHUsaVZAvw_+_AWNnNVaJtEmMFco417jqVGNg5_Q@mail.gmail.com> <111e9799-0319-59b6-0920-1a3349f4523f@cornelisnetworks.com>
In-Reply-To: <111e9799-0319-59b6-0920-1a3349f4523f@cornelisnetworks.com>
From:   Doug Ledford <dledford@redhat.com>
Date:   Thu, 28 Oct 2021 09:40:32 -0400
Message-ID: <CAGbH50vd8eCDj-fei4A_GHKMS=AZ1Sw3EAr4GybOBF=egLPSgg@mail.gmail.com>
Subject: Re: [PATCH for-next 2/3] IB/qib: Rebranding of qib driver to Cornelis Networks
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Scott Breyer <scott.breyer@cornelisnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Ok.  Was just curious ;-)

On Thu, Oct 28, 2021 at 9:26 AM Dennis Dalessandro
<dennis.dalessandro@cornelisnetworks.com> wrote:
>
> On 10/28/21 8:53 AM, Doug Ledford wrote:
> > Do you guys actually still support the qib driver and/or hardware?
> > That's old 40gig stuff. Is it still in use?
>
> As long as it's in the kernel we support it from an open source perspective.
> Meaning we'll make sure it keeps on building and fix problems that people
> encounter. There actually are people out there still using it.
>
> -Denny
>


-- 
Doug Ledford <dledford@redhat.com>
GPG KeyID: B826A3330E572FDD
Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

