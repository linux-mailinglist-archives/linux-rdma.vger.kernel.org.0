Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC1A1642A
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfEGNDQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:03:16 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:33816 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfEGNDP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 09:03:15 -0400
Received: by mail-io1-f47.google.com with SMTP id g84so6148587ioa.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESLrU4PvRDJRUfJELFvf3RsJ4NXEEun+8VbUWowJgeY=;
        b=md6uFQlgv9tsZBhsa0CK5AgO6lN32MO4G/NzUR57v0dlunAz25oaV0iEbe07pMDGRp
         Q7VnUort+Lu/oyUcxo6v5dfplcTrm7iy1EL1rjiHFjkqZj3qCDRnrFIwIyN8CW5zAeYd
         BdqpEtphUE4jF9lGAmr7n0NNxzO7DlKLnhYnW0Q68BnLrH21QZw+BNpQty2C6hJXvYhK
         xt5Ahp/jz9Yjhfv9mtniPYa938gY5H9q7PXAIy60my+AYzTzJhFnQmNJmqNskI4SZlRf
         hHT50+TLGlRYqQyOUYcHuehS9rMiUwN5zbXbuSx/w7uRywdpr9jkU3AmpP70xf6BnHUV
         e0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESLrU4PvRDJRUfJELFvf3RsJ4NXEEun+8VbUWowJgeY=;
        b=XvEYewD7EwWGFCxQywVHcAw4Iw3qQRl/fae/mrcaTtvWZhCQvUW+8hk8pvgTI5P8ca
         zGh3vShHTIyNtj0UncjXCbUM4ajp1Aj8+dosWe/uKiWug/tup4cIT10/VicPFabXxYRY
         5dV1uTwHmjTYrO6eVs+cc/CrA05ICqoGJFazUYQodIeMo0/xTVjsN6zkZV45DXP0ktB7
         g2x836fJCxZzmS1/3kY0UECdJV6vLzSKpc7ucViDxA7FCwlO3FesfabqQuU6iKYOsQ+E
         Sr2agS2U1DcCzdnSkJ5Yp9NKdUX+zXRRX/QaaJFxHoZY7iMO/o4hwFXIwQzxHa8pRaiA
         RGsg==
X-Gm-Message-State: APjAAAUHDcbqWQEq94XqUy/Xrjfj9SIDXZRIG9ArNcppFn4TnPYA9CJL
        pLWp+boaGytb20y3EZ6xPH5FlAmMDxJQu8UEuMOJFC9h
X-Google-Smtp-Source: APXvYqyz5FrBEknltsqYl0B8/hD5V54A2gRnx7w1akhXofMQhkQLpnfzKL0PL0OBhgmxNTBuWcBNGgxiTND4kuMG6RQ=
X-Received: by 2002:a6b:4102:: with SMTP id n2mr18745449ioa.256.1557234194651;
 Tue, 07 May 2019 06:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
In-Reply-To: <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
From:   Steve Wise <larrystevenwise@gmail.com>
Date:   Tue, 7 May 2019 08:03:03 -0500
Message-ID: <CADmRdJd44FYgYAvN8njcJcs5LwUiAcE89_vNXvqgp+cgOzcdVw@mail.gmail.com>
Subject: Re: iWARP and soft-iWARP interop testing
To:     Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>,
        Bernard Metzler <BMT@zurich.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 6, 2019 at 3:39 PM Doug Ledford <dledford@redhat.com> wrote:
>
> So, Jason and I were discussing the soft-iWARP driver submission, and he
> thought it would be good to know if it even works with the various iWARP
> hardware devices.  I happen to have most of them on hand in one form or
> another, so I set down to test it.  In the process, I ran across some
> issues just with the hardware versions themselves, let alone with soft-
> iWARP.  So, here's the results of my matrix of tests.  These aren't
> performance tests, just basic "does it work" smoke tests...
>
> Hardware:
> i40iw = Intel x722
> qed1 = QLogic FastLinQ QL45000
> qed2 = QLogic FastLinQ QL41000
> cxgb4 = Chelsio T520-CR
>
>
>
> Test 1:
> rping -s -S 40 -C 20 -a $local
> rping -c -S 40 -C 20 -I $local -a $remote
>
>                     Server Side
>         i40iw           qed1            qed2            cxgb4           siw
> i40iw   FAIL[1]         FAIL[1]         FAIL[1]         FAIL[1]         FAIL[1]
> qed1    FAIL[1]         FAIL[1]         FAIL[1]         FAIL[1]         FAIL[1]
> qed2    FAIL[1]         FAIL[1]         FAIL[1]         FAIL[1]         FAIL[1]
> cxgb4   FAIL[1]         FAIL[1]         FAIL[1]         FAIL[1]         FAIL[1]
> siw     FAIL[2]         FAIL[1]         FAIL[1]         FAIL[1]         Untested
>
> Failure 1:
> Client side shows:
> client DISCONNECT EVENT...
> Server side shows:
> server DISCONNECT EVENT...
> wait for RDMA_READ_ADV state 10
>

Hey Doug,

Try adding -Vv to display the ping data..  The log message you cite
are normal, not indicative of an error.


> Failure 2:
> Client side shows:
> cma event RDMA_CM_EVENT_REJECTED, error -104
> wait for CONNECTED state 4
> connect error -1
> Server side show:
> Nothing, server didn't indicate anything had happened
>
> Obviously, rping appears to be busted on iWARP (which surprises me to be
> honest...it's part of the rdmacm-utils and should be using the rdmacm
> connection manager, which is what's required to work on iWARP, but maybe
> it just has some simple bug that needs fixed).
>
> Test 2:
> ib_read_bw -d $device -R
> ib_read_bw -d $device -R $remote
>
>                     Server Side
>         i40iw           qed1            qed2            cxgb4           siw
> i40iw   PASS            PASS            PASS            PASS            PASS
> qed1    PASS            PASS            PASS            PASS            PASS[1]
> qed2    PASS            PASS            PASS            PASS            PASS[1]
> cxgb4   PASS            PASS            PASS            PASS            PASS
> siw     FAIL[1]         PASS            PASS            PASS            untested
>
> Pass 1:
> These tests passed, but show pretty much worst case performance
> behavior.  While I got 600MB/sec on one test, and 175MB/sec on another,
> the two that I marked were only at the 1 or 2MB/sec level.  I thought
> they has hung initially.
>
> Test 3:
> qperf
> qperf -cm1 -v $remote rc_bw
>
>                     Server Side
>         i40iw           qed1            qed2            cxgb4           siw
> i40iw   PASS[1]         PASS            PASS[1]         PASS[1]         PASS
> qed1    PASS[1]         PASS            PASS[1]         PASS[1]         PASS
> qed2    PASS[1]         PASS            PASS[1]         PASS            PASS
> cxgb4   FAIL[2]         FAIL[2]         FAIL[2]         FAIL[2]         FAIL[2]
> siw     FAIL[3]         PASS            PASS            PASS            untested
>
> Pass 1:
> These passed, but only with some help.  After each client ran, the qperf
> server had to be restarted or else the client would show this error:
> rc_bw:
> failed to receive RDMA CM TCP IPv4 server port: timed out
>
> Fail 2:
> Whenever cxgb4 was the client side, the test would appear to run
> (including there was a delay appropriate for the test to run), but when
> it should have printed out results, it printed this instead:
> rc_bw:
> rdma_disconnect failed: Invalid argument
>
> Fail 3:
> Server side showed no output
> Client side showed:
> rc_bw:
> rdma_connect failed
>
> So, there you go, it looks like siw actually does a reasonable job of
> working, at least at the functionality level, and in some cases even has
> modestly decent performance.  I'm impressed.  Well done Bernard.
>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
