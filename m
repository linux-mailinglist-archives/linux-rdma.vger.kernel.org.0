Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8B2BC6C2
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Nov 2020 17:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgKVQQr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Nov 2020 11:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgKVQQr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Nov 2020 11:16:47 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11F2C0613D3
        for <linux-rdma@vger.kernel.org>; Sun, 22 Nov 2020 08:16:46 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id d20so4523833lfe.11
        for <linux-rdma@vger.kernel.org>; Sun, 22 Nov 2020 08:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9qAYYU7qLTqNGo8meREqfnSUbV871EDhNHo/cPoPy0=;
        b=JOJBa8yNjePop47L7cV+OC01ssZuHPnNFJld0CgcBFPCtRLRKQCAAIqxiZd3X3Mq3x
         ZJxhVnqFNeBAOK92EV2XPKknvp46I1QFjWWd16nru3bOmtX+gDl8zwUzEWFW0s+M/6Ff
         vfCfjTe0Kq8a5+Nn9iuYScYXwuiA0aLJ8YBk3Q3ALy7ehtC7mGfYb0ZZriH/5CxF7NKD
         UZJgEXfTssgs6mAubTzC4pCYj+Yt+tBhsWUD6MVGh9hIJJshM6UbvYwGJMY9QG6Fk1rz
         fMBcj6V3piRj3WE3Rw/LWZX2QnbyJIW/L9CL2LMY+xDRE6EXma83OEVE9gDX6LctXa7A
         NF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9qAYYU7qLTqNGo8meREqfnSUbV871EDhNHo/cPoPy0=;
        b=QwvqAc21GmoCuI8x1vEle7Ym6xenGxV444JMNmPRPBuBKfZDAc8E2Cv8TNV8w4Ud7D
         rDqVBilmnKUgvxk1dLYQnCBpXJM3l4ZoOYfClZXGdYcoVbhGg2zJSq1ML2SNWLayYwor
         FP6YK69g5q6PPm7oeKVXGrzPaNbGg/FDz4OvKj1rIYi4FIowOJ9FY/+5cxhtEByVVwZT
         RV+G8sP+KOYsaBexW0jfZuFKnCTKUe0vtpE6XZ0nQxZoM3od0R0bIjBHYjAIAPr0D6PX
         sxPAP3+M9abFevgN33paMvnXEoyuzB0uZaCTF2nCs/98X0rEGBU1NrM/PoIrgyQZDivO
         CvPg==
X-Gm-Message-State: AOAM531R9MyUWxeXtLv2dsHnv4mufIR8p7WxgNpV7+lkSdV0QInmYfU0
        Fm/eWdPhCF0se9gWLkdJGf8JN1m3/YOzFQlZpHb58xyJMSMxflg=
X-Google-Smtp-Source: ABdhPJx0pPbNmP1x9mLEZheeiCp0mfGIwihnljTToQL9L3KLjTYS0c1anSmYXet3/3dncIFTArKJAjMplhgmP9VN6sM=
X-Received: by 2002:a19:f207:: with SMTP id q7mr11121546lfh.588.1606061805283;
 Sun, 22 Nov 2020 08:16:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
 <3b2f6267-e7a0-4266-867d-b0109d5a7cb4@acm.org> <CAHg0HuyGr8BfgBvXUG7N5WYyXKEzyh3i7eA=2XZxbW3zyXLTsA@mail.gmail.com>
 <cc14aa58-254e-5c33-89ab-6f3900143164@acm.org>
In-Reply-To: <cc14aa58-254e-5c33-89ab-6f3900143164@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Sun, 22 Nov 2020 17:16:34 +0100
Message-ID: <CAHg0Huw35m_WiwFqcTEHpCz94=JhaKZdEuV-F=aetQ_SEQgauA@mail.gmail.com>
Subject: Re: [RFC] Reliable Multicast on top of RTRS
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Will take a closer look at drbd,

Thank you,
Danil.

>
> Thanks,
>
> Bart.
