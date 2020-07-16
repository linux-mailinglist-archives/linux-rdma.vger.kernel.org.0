Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29265222663
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 17:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGPPCD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 11:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGPPCD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jul 2020 11:02:03 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A461C061755
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jul 2020 08:02:03 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v6so6335370iob.4
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jul 2020 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvJRUI4EdQBGHqv7T5GE8IRK1vRZhXERWcmFcI8zdd0=;
        b=bGjEQoiMwX6d1WgKfqqi53rTv+b7V+F19aOG0lp6pZH6GinugxJP7aeaKfwQuJcSAk
         w9d8/jnsr4iQ0/y3d6Ams6tT+eftq8kHHSsMF3Av7mWFV2Dac/0viNzeHySkOVYGBQuG
         HrH1CGE5YgbreRDlfu7zv8kRzi24BU+jYH0Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvJRUI4EdQBGHqv7T5GE8IRK1vRZhXERWcmFcI8zdd0=;
        b=Lu6QPXrSjuHEuoS0sKLtctAaWZLz5D4YqIg+dgvWpPjDH4q/zZkLWU936nA1Z0uYIc
         rNC8oS+jLpqIAZjP8R2eSAYJOXThkNa9kIiUYVwhs4nd00l1e93uYBCo8cd4GobDVIEg
         gCfh8TjI6zqzG1Lh5GpFVikl/YDc33vzGPXLER1/tB39b9RWWS1Zxx6XBRoxc8S2vicd
         O5a2KGbBN9cx37o4ZcpA+qR1VXOXjQffKwJFhp0Q4ixUL0vlOJfLKs9fA7XEjzjJIn7r
         uCueeJ4trotqAVqorjqWI2swHZQq221uHwikYAMB90y3hTu7w75qOLIQ/3I/7r9qAmY+
         K+kw==
X-Gm-Message-State: AOAM533ppWCtmL5VJ4uT30qFC+zblPDhH23vjXWrfAX1bZwG+/IQVH/e
        XRjhqajO5uVKUrqW3OffF8uqtKw7VLrzptpnjLkhYA==
X-Google-Smtp-Source: ABdhPJxihcoKlhITGEUKegwsmBhXQ+mRs6VbawAs6pandUmWUXoK903VD3c3S4ste/gRZ667VEYV1/VerXwJsXEaUuM=
X-Received: by 2002:a02:70d6:: with SMTP id f205mr5606209jac.5.1594911722507;
 Thu, 16 Jul 2020 08:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
 <1594822619-4098-7-git-send-email-devesh.sharma@broadcom.com> <20200715144649.GD813631@unreal>
In-Reply-To: <20200715144649.GD813631@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Thu, 16 Jul 2020 20:31:26 +0530
Message-ID: <CANjDDBhcKbMCu1LEnmaJTNFNH_jWupSAqdzQXf5GsJLM2KfA1Q@mail.gmail.com>
Subject: Re: [PATCH V2 for-next 6/6] RDMA/bnxt_re: Update maintainers for
 Broadcom rdma driver
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 15, 2020 at 8:16 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Jul 15, 2020 at 10:16:59AM -0400, Devesh Sharma wrote:
> > Adding a new co-maintainer for Broadcom's RDMA driver.
> >
> > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7b5ffd6..96d6405 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3582,6 +3582,7 @@ M:      Selvin Xavier <selvin.xavier@broadcom.com>
> >  M:   Devesh Sharma <devesh.sharma@broadcom.com>
> >  M:   Somnath Kotur <somnath.kotur@broadcom.com>
> >  M:   Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
> > +M:   Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
>
> Are other three still relevant?
Selvin is still an active maintainer while other two are less active for now.
>
> >  L:   linux-rdma@vger.kernel.org
> >  S:   Supported
> >  W:   http://www.broadcom.com
> > --
> > 1.8.3.1
> >
