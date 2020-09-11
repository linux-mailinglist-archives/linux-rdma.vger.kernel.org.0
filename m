Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCBD266710
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Sep 2020 19:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgIKRhH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Sep 2020 13:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIKMuA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Sep 2020 08:50:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0470C061757
        for <linux-rdma@vger.kernel.org>; Fri, 11 Sep 2020 05:49:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m6so11404018wrn.0
        for <linux-rdma@vger.kernel.org>; Fri, 11 Sep 2020 05:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nWbc4yMI9H7bl97CVcSxQv/EwnVj0ipCdrn8uq6XpTE=;
        b=ZhF6FLOxM6x7I7r0tgZIcmqTW3FgLmQpAWreu6Oijs+tt1JDiTN4xtO7gS09FKoB6s
         EEYVj7HbEIGTUtbiNnMv+MJFArYQN2vqI69IYqhzMjQCcikIpz3g7KdgI4fJ7czvczEa
         Z23sitHp3PUt/TfvriiI8vSjX1VBgfLlnLZ9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nWbc4yMI9H7bl97CVcSxQv/EwnVj0ipCdrn8uq6XpTE=;
        b=EOAr63EmebTjgw7kvdIwZknyEb2GoUkjDCJQP2MOGgK0kpZJPK68eG/SxmhVcKv5Pz
         eGyssdIy3myns2IGmJPtUrB8UjtLDnUQMyENkGQdYurk3VBx57imVCNFU1djKYZabNQp
         +cq4iRAGdaGSiTdS+FQd+TCq1v4a1iCAyLq+DXVAO7zaji+95LSRJFf/Y3gC72zY9gf5
         Fy9XrpXNsPS/q+h/OpDpGPxnj8YxkMpJ8DXinuT5eysL+D6PB+UbfQWW8S+8fFai4WQw
         X5VNu0HdEiji70m4u6/aWdZIhEYChfWMXSu1F8EGTGdPbdAtCOGch70R6vRRNDO0x44k
         Fn+Q==
X-Gm-Message-State: AOAM532ZqVulA0YWXl+MT4RxlD3HpDWxr06RNZtZknQwS13L82EqoeYf
        /qHVo4u+p8gReGjI+Kdcjl3dGkr6mZUR6i+Kf5B9Wg==
X-Google-Smtp-Source: ABdhPJzU5HHpYZ8aksLleECyLkPPJqWQEXktBFbiMMFXDO29AEh31KF19A1HSjNHai2b4blpPhdazL9YED11Fp9K+Y0=
X-Received: by 2002:a5d:4bcf:: with SMTP id l15mr1918848wrt.384.1599828598125;
 Fri, 11 Sep 2020 05:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <f79159af-4408-dc2f-6efa-45c5b45cf2d9@web.de> <CAEYrHj=pfGB7OuHt90t2aaawr31W9XZCHeHJurt3o0rK44jZ+A@mail.gmail.com>
 <59440849-23b1-9c69-ecf6-78f8a0b82c7a@web.de>
In-Reply-To: <59440849-23b1-9c69-ecf6-78f8a0b82c7a@web.de>
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Date:   Fri, 11 Sep 2020 21:49:46 +0900
Message-ID: <CAEYrHjmsd4Sp2R54y55pVL3CXr1KXedoBnTEczCBkpE9+SsFNg@mail.gmail.com>
Subject: Re: [PATCH] qedr: fix resource leak in qedr_create_qp
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-rdma@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Takafumi Kubota <takafumi@sslab.ics.keio.ac.jp>,
        Yuval Bason <yuval.bason@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,
thank you for the comment.
I will fix the line break and re-post the patch

Thanks,
Keita

2020=E5=B9=B49=E6=9C=8811=E6=97=A5(=E9=87=91) 4:48 Markus Elfring <Markus.E=
lfring@web.de>:
>
> > I will re-label the goto statements and post the patch as version 2.
>
> Thanks for such a positive feedback.
>
>
> Another suggestion:
>
> > > Fixes: 1212767e23bb ("qedr: Add wrapping generic structure for qpidr =
and
> > > adjust idr routines.")
>
> Please omit a line break for this tag.
>
> Regards,
> Markus
