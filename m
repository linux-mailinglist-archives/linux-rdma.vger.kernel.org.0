Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA257E5EE6
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Nov 2023 20:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjKHT5v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Nov 2023 14:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHT5v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Nov 2023 14:57:51 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3B42118
        for <linux-rdma@vger.kernel.org>; Wed,  8 Nov 2023 11:57:49 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41e58a33ec9so674391cf.1
        for <linux-rdma@vger.kernel.org>; Wed, 08 Nov 2023 11:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699473468; x=1700078268; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nIpGpWSRn2va0ETJIZSoKs9DQ1ZQQkyUivfX1WlZvjw=;
        b=Kjr3J89pbV+bE+hy0l0WOlee2mz4UNuiIojouidDzQ9/pOB3cDKJY6Ny2KjntoL5v6
         QR0dpTwCdnimHytoXrn4oqSyANi0OinR5Np/0f3lyHyyGi6/XHAhT7jcCmzJVr/CSFh0
         EeBgdv9YNMABlX+p36uRYH7u1ls2vFboeruhB+NA0J/kkIFmhf4+5L9rTqZ0IS5cKEBv
         Bk1cbKsHHUmqEe6Frk7m2XSgax3TXk9xZ3hooLVZS+CE/YojytVhX59XpYNGXG4DFclb
         WokC3Zncgbn9dnmNoKcMc3dOPI6cLN4BT9VgsF1N/1VbAlLgBAGA6ke5AMCW0gkAHog2
         GG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699473468; x=1700078268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIpGpWSRn2va0ETJIZSoKs9DQ1ZQQkyUivfX1WlZvjw=;
        b=whrEfCsZ09wADpJrFe46BJEJzcNJ7KI336YiKe8U8tfD8qZANIJXtyJiThTBYCd3cE
         m1gFsMeS8JoacRr3GW1rx8eU+3ZZFv+iZMNwttR2lqdF0fcb/rQoda+lItBMKODd2b9E
         Akb5rFsDCt1JyUMzcaoAjZnN6t0PRa5Zmx1Pkb6Lp+4UnSWtcAhxNM3UUh556JA77nR3
         LNuhL8oAstE/jkZ5jUKMx2UW3N0r79Qi561RnqE5ciR4eXwUmPd5PQUG1d6u3X5BqGov
         4huAjj4KG6MRYNQGwfplnQrTqX1fh4v9y0WKWd1BKwZq3c2A+i2p7/X/4kvFwzQ06Rim
         ideA==
X-Gm-Message-State: AOJu0YzJeVHhNg+rCYfoLN+tPXaKU1xkUKTmiC4xOhSrshacEnnIeY90
        vzR8fmSl+dD0Pozg+vIXGfwwjqUCpi5Xua6n3cU=
X-Google-Smtp-Source: AGHT+IFAASH9IEYa+8f4nAX5ClZcK+1M6bIIwaJozSjr9bhnzEht9BZNlNZLaZ69i3eeLnV66t/V+XdEP8tY4/bwaIY=
X-Received: by 2002:a05:6214:f0b:b0:66f:bad6:dccd with SMTP id
 gw11-20020a0562140f0b00b0066fbad6dccdmr3584426qvb.12.1699473468156; Wed, 08
 Nov 2023 11:57:48 -0800 (PST)
MIME-Version: 1.0
References: <475a37e920badad12a0d71fff65e817979417594.camel@redhat.com>
In-Reply-To: <475a37e920badad12a0d71fff65e817979417594.camel@redhat.com>
From:   Mark Lehrer <lehrer@gmail.com>
Date:   Wed, 8 Nov 2023 12:57:37 -0700
Message-ID: <CADvaNzW1GYMDnD5ffTbB0wgbmWF1HNwgkikbL1=48=B2ouVGHw@mail.gmail.com>
Subject: Re: Mellanox CX6 and nvmet connectivity failure, happens on RHEL9.2
 kernels and latest 6.6 upstream
To:     Laurence Oberman <loberman@redhat.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        "busch, keith" <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> [  286.547112] nvme nvme4: Connect Invalid Data Parameter, cntlid: 1
> [  286.555181] nvme nvme4: failed to connect queue: 1 ret=16770

It looks like the admin queue pair (0) worked at least.  The code path
for the two is a bit different.

This error sounds familiar.  I wonder if there's an error code 16xxx
cheat sheet out there.

We recently had to downgrade a ConnectX firmware version to fix a
similar issue, but on a CX7.  I can't remember the firmware versions
involved but I could probably dig it up.

Have you tried TCP mode?  Whether TCP works or not will be useful
information for debugging.
