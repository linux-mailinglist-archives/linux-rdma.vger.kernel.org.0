Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7015B221AB3
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 05:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgGPDRY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 23:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgGPDRV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jul 2020 23:17:21 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306DCC061755
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 20:17:21 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id z23so895928ood.8
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 20:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q9hafAxEjk6rEnna83lY+NBYWUYpgRANPcT5Pje35fQ=;
        b=eejAuz35chIwXF914mHlBzh+ztVokSFXD2da9jQ2RtdeMI3/Q60GMkGACgnJ+AP/W8
         MgGqBum7tOU1CVGAYYTIjGuycbhs0WdE82yN+1HXr2GK1gc4Z+y+fCttdQ78cL/g21Np
         KFsR05UFffkNRaKc1ajBTigKtbGFMt5uk5ocWfrr3Gvifoxahmgc6YwCqJ97AVm7+iut
         Sj5viDlKDlZq7UzTXiKmObJtLCqQPsShzjX6npw3avLvXA2cAtefqjewGLXKGj7epCiw
         +XHryzWvtP5gr+LIoY/h8WPSO2lROoLIPcUgIKIPsHQ538xbcJTMRWWhEZKm4xW261Nc
         dU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q9hafAxEjk6rEnna83lY+NBYWUYpgRANPcT5Pje35fQ=;
        b=GKJBhd1MpNLrRJ8xfOGfJ9mvualZkgNn/wuL21QWjOi3QgiKCZgg8sdHsnBHUrV3XD
         LzMey7fJR0HrH5j0hIpnht9HRstDt+Ut0g45LPQBU7lqbNCLn3X1E3Uj+X+w+w/ufELZ
         NgikCaLTCK4aMh1LS8YHx/dyaW8oxhHEna9I5LyKLTCtkuq35mwyb+gLUw6rSM372P1F
         rRFLy1/5n9KFe6R3VsTWuwxgIiNbQFZZ12xT1oIvXU216vMi2pjv4/qu82vQLN8EgFz+
         LDgVbI+Zal3UWmMxHQ+jWGQpSn/VBRFeVNNZrCPGjUg6YYFzyLiP8PInwaThQIyDgnDg
         lRCQ==
X-Gm-Message-State: AOAM533X1HNlFzxE4FP7EjtamGSMDIe1mFYnxSv5PUHa96hzZBEPk2A5
        nb8PBHxC7He7AqobIcUzX9SqXMaUGKj/80znGwI=
X-Google-Smtp-Source: ABdhPJxHDDUCVC6P08T8Z1UWSRkycP5GjhzUmGT0Cd3TazoBUCx3wr5RrAD6fEXpUMCJsZQQQpTJXEPgUpSbXwoHmg0=
X-Received: by 2002:a4a:b006:: with SMTP id f6mr2312010oon.13.1594869440660;
 Wed, 15 Jul 2020 20:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <A9F28BA8-EAB3-48AC-99C0-09E93D7B9DE0@yadro.com>
 <20200715113743.GC2021234@nvidia.com> <6370C3FE-966D-4C6E-AAA1-179F39D382BB@yadro.com>
In-Reply-To: <6370C3FE-966D-4C6E-AAA1-179F39D382BB@yadro.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 16 Jul 2020 11:17:09 +0800
Message-ID: <CAD=hENdB-hVZr-ivU9FhVqEiF4WJZmjuY3iFBpuEJqRD548zkQ@mail.gmail.com>
Subject: Re: [PATCH] rdma_rxe: Prevent access to wr->next ptr afrer wr is
 posted to send queue
To:     Mikhail Malygin <m.malygin@yadro.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sergey Kojushev <S.Kojushev@yadro.com>,
        "linux@yadro.com" <linux@yadro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 15, 2020 at 8:39 PM Mikhail Malygin <m.malygin@yadro.com> wrote=
:
>
> Thanks, I=E2=80=99ll post an updated version.
>
> Mikhail
>
> > On 15 Jul 2020, at 14:37, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > The spinock in post_one_send() guarantees no reordering across

How about spin_lock_irqsave?

Zhu Yanjun

> > post_one_send()
> >
> > Jason
>
