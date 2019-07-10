Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0401C64F61
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 01:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfGJXyC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 19:54:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35066 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfGJXyC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 19:54:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so2027674plp.2
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2019 16:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gFYw+HMYMcy9WDWAf7lBOqFHKuuJ9aebWvblsMHgVuM=;
        b=XGpHipitrwxuJAmZlyG7V9JPyfM7owm246snIlqAPmAbAGT+TpB3cvC9uq4gTBgrkV
         54fTAwAckeuotsLh92QIwHqxvTZNNTPCZ0lmxln7WYBOTrxmrmQ3abMb5TH3hluGcp+S
         ZW0JmODXSrqZ2HPxVd2O3lOzgv/nYxYOxDG8oHV5FFvgn+Emb1SOCD9hhTKZa6xsSbJp
         thfo7s046j0jn5t7c+8rn3VyYLqq2Ly5TJcrpLWS11PBcE6Cj/jAXFb5YI5BsUiRu1HR
         H1JTxEpV93MAyHHghvXcZhh/I78XBRv0j5w7+vGTnMg8Deoz7yvSMnUhIgzRMRrT13mN
         fu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gFYw+HMYMcy9WDWAf7lBOqFHKuuJ9aebWvblsMHgVuM=;
        b=not/6KzvlFYZXRKsntJaRj88XlDlBWcWg0iRX2qtq1xWOf3R3SFZS0DvdsT6wjE1m9
         pjHG8z2DjWevulFgMgw4L1RiobDitCzXao3LFMdfNAuwJOEilgoNlLwqV9qietAD281q
         05Xip1I4Q97ThsqlbjtM3yQk2N9I5nJn/MjXOqBlExiPYKIdiul6rcP5H7VyYZbFyFaT
         IT34ghJNhjetANDyeyrQFn9+6yD6q+lTPtI2kAgg/fH68Q2/QEMNSxjcybvR9bSJWn3i
         aXSKUVR87GewLAkKv/2G57O6C8pei9gjQJ9EOM+XUTkzgbtfrZPOnbREEQrLn5IZuil5
         m5UA==
X-Gm-Message-State: APjAAAWNG86s50z38BXpyMjh26P1X6BmCZqC1GH/WobRlwAxEqcnr8Ze
        0Fg10xzY9Jf9UIdkEHfjrVW5XDtMBqCNLWyZiyW8xw==
X-Google-Smtp-Source: APXvYqzp1hs90Rwc0aIZR4yrq/LXA6p5+K72VfDeYJ0yPeISfrkbaXGgGHoaXuTZjUxbjZu9JiVnGVXwU9LrMXwKpk8=
X-Received: by 2002:a17:902:4aa3:: with SMTP id x32mr990493pld.119.1562802841570;
 Wed, 10 Jul 2019 16:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190710174800.34451-1-natechancellor@gmail.com> <20190710182624.GG4051@ziepe.ca>
In-Reply-To: <20190710182624.GG4051@ziepe.ca>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Jul 2019 16:53:50 -0700
Message-ID: <CAKwvOd=yJQgzjQBKW7=en_YnF6OCAg0MXy5c6c9tBLSjGgorPA@mail.gmail.com>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 10, 2019 at 11:26 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jul 10, 2019 at 10:48:00AM -0700, Nathan Chancellor wrote:
> > clang warns several times:
> >
> > drivers/infiniband/sw/siw/siw_cq.c:31:4: warning: implicit conversion
> > from enumeration type 'enum siw_wc_status' to different enumeration type
> > 'enum siw_opcode' [-Wenum-conversion]
> Weird that gcc doesn't warn on this by default..

Based on the sheer number of -Wenum-conversion that Nathan has fixed,
I don't think gcc has -Wenum-conversion (or it's somehow disabled just
for gcc).
-- 
Thanks,
~Nick Desaulniers
