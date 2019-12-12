Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8DF11CD26
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 13:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfLLM23 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 07:28:29 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40097 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbfLLM22 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Dec 2019 07:28:28 -0500
Received: by mail-oi1-f194.google.com with SMTP id 6so291256oix.7;
        Thu, 12 Dec 2019 04:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Y9iHDYGIFVGjHT5t86r21P03HUM56r+DzbAOwdCIy0=;
        b=DPJQrSypuwzJDFhhvWXFStMNHtDK4kRMnhohRqhhatDVu9ZRXwM9/nQYrdW0mL2KzZ
         VUXVsBWblyD4X7mfsXhoKHR6c84+0fUc43IevkvAgFsE63KeEbBzHzeh65kZavFfpHDa
         Rs7HDhqV97tQTXQ03MP7757pq6cqcVGmQul9g1XOJgBta4Zy2BlZvinSeZSTQiKXbahp
         A0ikDora4rH7jVEyZFiEUHo65KK3iK+qwwAiOS52bh3HCtGTXUEi8WNsse5XHhttHd2J
         3zrJW06o4wXd1wY8f1xmJhMaI8pRcHU1vYBJpndhclVw++Gx6tt5qg1gzhj2s3XwM06w
         C56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Y9iHDYGIFVGjHT5t86r21P03HUM56r+DzbAOwdCIy0=;
        b=WqWpkyZAZULDQzKhhyCaGGBslYLzKRt0sxNpci955O89UB2U1uJ5367Pu68kS4iVLZ
         PFJpk+sMxe7gi6vcH21RcwLsSUK7U8mkFiAIUWAsDThErU0hcecJu19QbB9Kptj2q7xQ
         /oJr8HbXca/weFBWSJG3w1Yv8FXo+3PQG4GkssmVmiLMfphkl8ynI3EBFRgYMSVhTH70
         FywWkegkgqicIabV+cxQPmHeKgNFlPsZedM6ldJnqX1dEIe4bSNNQ+G6ofPPmc7x0FUM
         6tZo+mLZ9qA87cFXzBYNy+RQ+VBcZJ5l9kbhwhh2eJvojvz1aavhJih4LPu55fx8rgy6
         +NDw==
X-Gm-Message-State: APjAAAXIttvs21RdUchcJDnBzkDclvPxCh6TmTHNRC44aBYkcvTFkPAl
        a6rMcq76LK0umsqkoaPni8KBb0nN3X/ChRHbrXg=
X-Google-Smtp-Source: APXvYqwaEQwiecwpvxxqqhQAiSr5hflX5ePMX5oN5FvbSb4Y/nShYsYdSRVg1zBpGo5ZeTc04K0P1SRIsSeQTdK1BEE=
X-Received: by 2002:aca:b04:: with SMTP id 4mr4598119oil.151.1576153707873;
 Thu, 12 Dec 2019 04:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20191211111628.2955-1-max.hirsch@gmail.com> <20191211162654.GD6622@ziepe.ca>
 <20191212084907.GU67461@unreal> <e5123cbb-9871-d9c3-62e9-5b3172d1adf8@amazon.com>
In-Reply-To: <e5123cbb-9871-d9c3-62e9-5b3172d1adf8@amazon.com>
From:   Max Hirsch <max.hirsch@gmail.com>
Date:   Thu, 12 Dec 2019 07:28:19 -0500
Message-ID: <CADgTo8_mD6Z7WuA7wdEwh+7AR8YOy8nfJeaa2RbEAeftLGod7g@mail.gmail.com>
Subject: Re: [PATCH] RDMA/cma: Fix checkpatch error
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Danit Goldberg <danitg@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dag Moxnes <dag.moxnes@oracle.com>,
        Myungho Jung <mhjungk@gmail.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I am happy to make a larger/functional change. From what I read,
desired patch scope is proportional to linux community involvement but
if that not how you guys do the infiniband driver that fine. Whats a
feature you guys want but no one is working on yet, or rather where is
such a list kept?

On Thu, Dec 12, 2019 at 7:10 AM Gal Pressman <galpress@amazon.com> wrote:
>
> On 12/12/2019 10:49, Leon Romanovsky wrote:
> > On Wed, Dec 11, 2019 at 12:26:54PM -0400, Jason Gunthorpe wrote:
> >> On Wed, Dec 11, 2019 at 11:16:26AM +0000, Max Hirsch wrote:
> >>> When running checkpatch on cma.c the following error was found:
> >>
> >> I think checkpatch will complain about your patch, did you run it?
> >
> > Jason, Doug
> >
> > I would like to ask to refrain from accepting checkpatch.pl patches
> > which are not part of other large submission. Such standalone cleanups
> > do more harm than actual benefit from them for old and more or less
> > stable code (e.g. RDMA-CM).
>
> Sounds like a great approach to prevent new developers from contributing code.
> You have to start somewhere and checkpatch patches are a good entry point for
> such developers, discouraging them will only hurt us in the long term.
>
> Linus had an interesting post on the subject:
> https://lkml.org/lkml/2004/12/20/255
