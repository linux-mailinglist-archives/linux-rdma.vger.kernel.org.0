Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E983F6D98
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 05:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbhHYDDT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Aug 2021 23:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhHYDDL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Aug 2021 23:03:11 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA1BC061757;
        Tue, 24 Aug 2021 20:02:26 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id x10-20020a056830408a00b004f26cead745so51800824ott.10;
        Tue, 24 Aug 2021 20:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CJu4ryWmmhPfIqi+5GEQZx1ws6z7aiz7H2DyEgUiD0=;
        b=bUvX0Wqsi/ScMzguDUhCOkuCSpWbyqEGIiW5GtyHdwfL5MHC/2miqSVPyWG+siNH7F
         5vyszzE+XRlzUOffljQPGW1VkU1pNwbqJYF6anFXFpYOFXiL1db4XRAgFtqZtJlc0O6i
         NYMoQj4Nf8/UpPZbIBsK0RYIJCMAT1t5+kv/f12M8lVfvyWP4OZBqB4uzuJEcZVr5W65
         g3Rr89f5u8fKcDK7fKMtvjOXTdEFtBWv8ft81gHOm7W5fzLqi1iW5rrRZOLE4ZcZkYbG
         CmnPaTVglo8Yxgu9G+AFAanjXg/+pehgAvvZdU/nUh+mdf/q16dFNhQGQNGv3TN7A1q7
         1VPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CJu4ryWmmhPfIqi+5GEQZx1ws6z7aiz7H2DyEgUiD0=;
        b=cLV+hOjKUyJmUjq6sYzp3O470WoO27HWPx5EG6Z9+UYlMStdhAZzNBxPNrY4efgNpL
         cgsaKlBWa+NMu+cG0rbjLwwWoVXF7R8G5/TPV0Ns1gRO2AB0bkFxl/1FrUnrisRw0E38
         9+pf35s9KcHCJ1qiuBpfWo+qeroUIY495NDXQxL0gFG9JxssgONEB/0zmUP93AKlfhub
         Igv/++k109E7uTcjou3kTC1OBA8WdNw8oQmsLjS9WNxsYRklFUApNfINUadaptTf04xe
         563M5PgRTCBxruXMs+xWRkeCIwPUzyiHtfytOk4XN+o3qPyN9NFggAwu6FWgAvysqAb4
         iidw==
X-Gm-Message-State: AOAM532P4CPrKVFOeYJzUpuz5E1c8ii4O7M8b3Qzm/3alNpNWOHYyLC6
        SVhsxqksdBm5aU7k6tjeT6HO2v3M9Qx1hW7OqyI=
X-Google-Smtp-Source: ABdhPJy1p5I+xDIjsqcsw/BcyZ4dbCp03S8J7YhMHmQiCaFw4hOvoBf0h5jHc05iRp3zejVLPtCv/GLcEnnYlagLtZs=
X-Received: by 2002:aca:2216:: with SMTP id b22mr5005428oic.163.1629860545872;
 Tue, 24 Aug 2021 20:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <c3d1a966-b9b0-d015-38ec-86270b5045fc@acm.org>
In-Reply-To: <c3d1a966-b9b0-d015-38ec-86270b5045fc@acm.org>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 25 Aug 2021 11:02:14 +0800
Message-ID: <CAD=hENcriq-mwnvzY3UdowuGpKb=Uekvk-v8Lj0G=QB-qK0kJg@mail.gmail.com>
Subject: Re: v5.14 RXE driver broken?
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 24, 2021 at 11:02 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> Hi Bob,
>
> If I run the following test against Linus' master branch then that test
> passes (commit d5ae8d7f85b7 ("Revert "media: dvb header files: move some
> headers to staging"")):
>
> # export use_siw=1 && modprobe brd && (cd blktests && ./check -q srp/002)
> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [passed]
>     runtime    ...  48.849s
>
> The following test fails:
>
> # export use_siw= && modprobe brd && (cd blktests && ./check -q srp/002)
> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
>     runtime  48.849s  ...  15.024s
>     --- tests/srp/002.out       2018-09-08 19:43:42.291664821 -0700
>     +++ /home/bart/software/blktests/results/nodev/srp/002.out.bad      2021-08-23 19:51:05.182958728 -0700
>     @@ -1,2 +1 @@
>      Configured SRP target driver
>     -Passed

Can this commit "RDMA/rxe: Zero out index member of struct rxe_queue"
in the link https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-rc
fix this problem?

And the commit will be merged into linux upstream very soon.

Zhu Yanjun

>
> The only difference between these two tests is that test (1) use the siw
> (soft-iWARP) driver while test (2) uses the rdma_rxe driver (soft-RoCE).
> Both tests run reliably against previous Linux kernel versions, e.g.
> v5.13. Can you take a look at this? The blktests software is available at
> https://github.com/osandov/blktests/.
>
> Thanks,
>
> Bart.
