Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92C1C12F851
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 13:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgACMjk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 07:39:40 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43879 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbgACMjk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 07:39:40 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so39636484ioo.10
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 04:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cAe5HcMa95ZS+hogq0Ch8E/KQ7+bOnNlPN6CHTvuwVc=;
        b=ehY6ksngLD2Alabqsy7PAjXpgPvGNIqTto5LLJyk/an47FZX1K+1cMUNrvDBbCWmZG
         CoG0bAeR13drjgQ8PU8Bk2Ml2ZgQqNVVofB+88+ORb4GtqRJ5og/TphzQknZ0ZkDqShA
         BuewhbiTHIOZ+CUNlGyDWUGCLwPjC0tTGuJTeQ3ayrO0oMoET+/dyP3wyLjk+XzBSn2Q
         IMpst+i2G3qZ6BKg7Z0H16Itds45wjtYppREzXf9TkPrc55tmE8fdNzY8NyLFmhemxK+
         nwM+9ijpkLwwCh+WBHBl6pLBmQgQ9RaDhzUMsQJNLlk5WZpypa1nWcxinkp+nhBzlB11
         SuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAe5HcMa95ZS+hogq0Ch8E/KQ7+bOnNlPN6CHTvuwVc=;
        b=Ixz+a6e3T51e+DK21G12pAQdtOyBul0DrMOmJTFSmNKss4cTdXYCpwA20BwhcOEGPh
         KPDscGdj001AcQ05IMk1LB+MVkEylQ2hIRpmtgileVwWUdp90BohFaBejdsR8wI7GdAZ
         HBTpqvEQMgeSmcXBCld9IF+KgPP1+niyNtPJ+BOVs9akVuup77tf8FlQzRaAjBY2vral
         jsd21rIMECxrFfejhzAlpth0UC6ZDmDQycHgrOmJd6XPZNkMfL75hWvCEOAmHsmANdmU
         yvlD/4V/Q5sBW4LDDHDHGS19SaMhBpA52SUZdnh0ISyEH+K/JnRcN8EkgxAIxCBfwrgo
         RSWw==
X-Gm-Message-State: APjAAAXOddNDGPfHIor/FdCo8Yi08t3j30ScnQYcVhZ2wAWUttqJkB5S
        vBfpcRXM7pXKi4HM+cjCD1N3iXyx/WjjzVt9aSA4dg==
X-Google-Smtp-Source: APXvYqw9gUHKrjfDdiAi42fotiG2xzcc+wApMPhqxzYw3KcG/z9y36HbKX9/ogOj21lxFmI9dCVtjZ63vbDTrvpk8YI=
X-Received: by 2002:a5d:84d6:: with SMTP id z22mr55730403ior.54.1578055179696;
 Fri, 03 Jan 2020 04:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20191220155109.8959-1-jinpuwang@gmail.com> <20200102181859.GC9282@ziepe.ca>
In-Reply-To: <20200102181859.GC9282@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 3 Jan 2020 13:39:29 +0100
Message-ID: <CAMGffE=h24jmi0RnYks_rur71qrXCxJnPB5+cCACR50hKF6QRA@mail.gmail.com>
Subject: Re: [PATCH v5 00/25] RTRS (former IBTRS) rdma transport library and
 the corresponding RNBD (former IBNBD) rdma network block device
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 2, 2020 at 7:19 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Dec 20, 2019 at 04:50:44PM +0100, Jack Wang wrote:
> > Hi all,
> >
> > here is V5 of the RTRS (former IBTRS) rdma transport library and the
> > corresponding RNBD (former IBNBD) rdma network block device.
> >
> > Main changes are the following:
> > 1. Fix the security problem pointed out by Jason
> > 2. Implement code-style/readability/API/etc suggestions by Bart van Assche
> > 3. Rename IBTRS and IBNBD to RTRS and RNBD accordingly
> > 4. Fileio mode support in rnbd-srv has been removed.
> >
> > The main functional change is a fix for the security problem pointed out by
> > Jason and discussed both on the mailing list and during the last LPC RDMA MC 2019.
> > On the server side we now invalidate in RTRS each rdma buffer before we hand it
> > over to RNBD server and in turn to the block layer. A new rkey is generated and
> > registered for the buffer after it returns back from the block layer and RNBD
> > server. The new rkey is sent back to the client along with the IO result.
> > The procedure is the default behaviour of the driver. This invalidation and
> > registration on each IO causes performance drop of up to 20%. A user of the
> > driver may choose to load the modules with this mechanism switched
> > off
>
> So, how does this compare now to nvme over fabrics?
>
> I recall there were questiosn why we needed yet another RDMA block
> transport?
>
> Jason
Performance results for the v5.5-rc1 kernel are here:
  link: https://github.com/ionos-enterprise/ibnbd/tree/develop/performance/v5-v5.5-rc1

Some workloads RNBD are faster, some workloads NVMeoF are faster.
