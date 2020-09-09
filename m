Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E2A262E0D
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgIILnn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 07:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbgIILnh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Sep 2020 07:43:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727AC061786
        for <linux-rdma@vger.kernel.org>; Wed,  9 Sep 2020 04:43:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so2610760wrm.2
        for <linux-rdma@vger.kernel.org>; Wed, 09 Sep 2020 04:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IoOwfF+G1FhxX5cbjmmLGfMHMYzBv9TU48vhKftxc4E=;
        b=DOpEExo5OekREeixjcSIiA4XaYFDzY4R5rQVYK7Yr3+aRN49fKpEnlSQn1p3NL2szo
         jJl9XLfdxe6ZtZ7o+2zglk5PkyocqIXdOfMz2yFObqPab392C+AtYgOSXQufb+LCfJRs
         cH1IMgxzKfteJy63eRcUtTn4xx0b6VGOomM714xvPCKb6b3JYwwN2qfXNOR9dPZQIfoe
         hJp8uFXVxFGgmpPTmTzqie2dcHgMqpqO2HEBUt4EzxgrYpp87b2byLdAxwNqDG/PyL3s
         Wy6/kOGt/1vl9SSBaGRqunmiclb7e3XOUTL9YiseNP2HRlQJps/neAjQjVpv2eewDDJx
         7Ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IoOwfF+G1FhxX5cbjmmLGfMHMYzBv9TU48vhKftxc4E=;
        b=EamYRy/nK1VxsfIyJ0NNXvW0h26zCtYoxXG6cJ6js5xcmI7jhMnijWdcXlE5OwYrMW
         HZEd2ipWDE4P5mYJjFbnk2RDh7HtBIm+9r2BtB9DCsaSyY/hSDPnxARfhbS4gxpSTR61
         IovNkUMD99ZcbEF5c3k4Cy7laxQnS0FyPtON1lVyzfvcKfSR5RXKsp4XrAARHk9CzLEd
         RV/V7xjVbxrMy9auu0hCd99fqqXUQAtyTAFZoK3MS31Htx88fN+LifBMYSe+Ekz3EXWN
         lUeQmdwsoDPHhRumstFtvTZeVG9dlS9SqMyBjt99MkmSHXmrJ1N30orNvQzfs6+hXSWS
         j5lA==
X-Gm-Message-State: AOAM531Qcc6cH2y5i3aMbii38nHK/ZzJXdDWhzfVIVxrp1W3WF6568y1
        3ZK4YzjPEXSd13Iyant5DkrPyaFCwXgxEAS556U/zCEdYNtI
X-Google-Smtp-Source: ABdhPJxoVFaBjvxkgoCd8gkWhxu1oRIRDUlJoJokVKR9f7iE4SskInZ+QaVYiFzUBkT0z331yEU5ggJyNx3ZC+udIvA=
X-Received: by 2002:adf:81e6:: with SMTP id 93mr3473456wra.412.1599651785016;
 Wed, 09 Sep 2020 04:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
 <3b2f6267-e7a0-4266-867d-b0109d5a7cb4@acm.org> <CAHg0HuyGr8BfgBvXUG7N5WYyXKEzyh3i7eA=2XZxbW3zyXLTsA@mail.gmail.com>
 <cc14aa58-254e-5c33-89ab-6f3900143164@acm.org>
In-Reply-To: <cc14aa58-254e-5c33-89ab-6f3900143164@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 9 Sep 2020 13:42:54 +0200
Message-ID: <CAHg0HuxJ-v7WgqbU62zkihquN9Kyc9nPzGhcung+UyFOG7LECQ@mail.gmail.com>
Subject: Re: [RFC] Reliable Multicast on top of RTRS
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 4, 2020 at 5:33 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-09-04 04:35, Danil Kipnis wrote:
> > On Thu, Sep 3, 2020 at 1:07 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >> How will it be guaranteed that the resulting software does
> >> not suffer from the problems that have been solved by the introduction
> >> of the DRBD activity log
> >> (https://www.linbit.com/drbd-user-guide/users-guide-drbd-8-4/#s-activity-log)?
> >
> > The above would require some kind of activity log also, I'm afraid.
>
> How about collaborating with the DRBD team? My concern is that otherwise
> we will end up with two drivers in the kernel that implement block device
> replication between servers connected over a network.

I have two general understanding questions:
- What is the conceptual difference between DRBD and an md-raid1 with
one local leg and one remote (imported over srp/nvmeof/rnbd)?
- Is this possible to setup an md-raid1 on a client sitting on top of
two remote DRBD devices, which are configured in "active-active" mode?

Does anybody know?

>
> Thanks,
>
> Bart.
