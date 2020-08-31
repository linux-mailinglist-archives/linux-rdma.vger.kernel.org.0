Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669E7257EC7
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 18:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgHaQaF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 12:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgHaQaF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 12:30:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18997C061573
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 09:30:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 7so862845pgm.11
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=OxeFq4wAfZtLr5NFICLEaHhPXWbG1LHeQAPOum3WDA0=;
        b=HmAv+UxnftZ461JkC5UzqouZNbFUAN6ugRitkAr/YNjXEMgKkSkY0kl9cRJa8Fun7T
         Y1XKldXDh40eEwbMrog8bievCZ9m2t+cmVNsOZp/Dvamvks2ZeSywBx23MBPjkRjDZbJ
         rv/sU5laMrZtzo+nafP9TAflUU9jsbK9BMo7BfyKlfFZvrsjfvNFO/FQdIZD2xU5BkP+
         B4+o1jn3XQ63zY8VEMnhLtwjitnaW1KXEVRtBllr/5Qk2wdQwHOhYMolfzjjdyQlnQUL
         2fxvwcJ4T3EwaPMP6GeKSzBddg90k9j2t+ZrfI7lcrDvB0HEpuzr9QJo8m1eT7XjyzhO
         cl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=OxeFq4wAfZtLr5NFICLEaHhPXWbG1LHeQAPOum3WDA0=;
        b=PhEaEHRZ1pvhThgDl+wqcG7tGXKVeXG00UH0MY43choppKsskzKTwKjiwenYbNkcw/
         Qm8qn/hX7TsK69PGZnEC3JPEcHXPH/P2s8oPAqsTywCAHqkOLRjp324hyK8Vb7Blao/g
         FON++fLryryZFcIzQJ3MDXax/UHAin3RV+HGg5Ll62U7xi4efWxIVYkKDoHTZblicSmO
         g18xxQB5pTwy5W8k7O4akcq3qccFP7ZeZYhHgBEAN9wU5T+zKeL+iUzFr2T818sBLgb5
         WO/DCzrL4mlNFPPVkJSk/ddzWT9aeVzbMoyCFfnAPwTGHLOhkeDjeELJQ5EevIEmel6J
         6v1g==
X-Gm-Message-State: AOAM531piUA6KGfHQhQRN37mk6sTKw5WcnVPaeVWZLr104T+QSypLuJS
        dIWrKWF3wq5rFP6nuQCM7wUTuIZ5h//zJUWiplQSqTyi
X-Google-Smtp-Source: ABdhPJz0JXrCmv0ka1eZgXxqSmksFgPeNdeYlqJJlenM7ixneC351VXIkNBL6qOg8DS1ND95SChbNizHwuUMD/T58IY=
X-Received: by 2002:a63:e157:: with SMTP id h23mr1910051pgk.239.1598891404483;
 Mon, 31 Aug 2020 09:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200830103209.378141-1-sagi@grimberg.me> <20200831121818.GZ24045@ziepe.ca>
In-Reply-To: <20200831121818.GZ24045@ziepe.ca>
Reply-To: doug@easyco.com
From:   Doug Dumitru <dougdumitruredirect@gmail.com>
Date:   Mon, 31 Aug 2020 09:29:38 -0700
Message-ID: <CAFx4rwSgr7F5+HMfdZ4KQkGOhbqX94mM7ykSKbbE3Xy1qYHsHQ@mail.gmail.com>
Subject: Re: [PATCH] IB/isert: fix unaligned immediate-data handling
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Rust <srust@blockbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 31, 2020 at 5:18 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sun, Aug 30, 2020 at 03:32:09AM -0700, Sagi Grimberg wrote:
> > Currently we allocate rx buffers in a single contiguous buffers
> > for headers (iser and iscsi) and data trailer. This means
> > that most likely the data starting offset is aligned to 76
> > bytes (size of both headers).
> >
> > This worked fine for years, but at some point this broke.
> > To fix this, we should avoid passing unaligned buffers for
> > I/O.
>
> That is a bit vauge - what suddenly broke it?

I will try some regression testing to see when it broke.  As this is
RDMA, it takes real hardware and the build/reboot cycle takes a lot
longer.  I should be able to get to this in the middle of the week.

If anyone has a guess of what version to "look around", please let me know.

Doug

>
> Jason



-- 
Doug Dumitru
EasyCo LLC
