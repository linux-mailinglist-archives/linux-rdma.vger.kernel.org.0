Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D43434198
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Oct 2021 00:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhJSWuh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 18:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhJSWuh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Oct 2021 18:50:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04FAC06161C
        for <linux-rdma@vger.kernel.org>; Tue, 19 Oct 2021 15:48:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y30so16876258edi.0
        for <linux-rdma@vger.kernel.org>; Tue, 19 Oct 2021 15:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=GkhhNYn/r887xj4Na+y/doa2OuGV4q1++broONJrqV8=;
        b=bk1zHpxnFihnWIi61bxkvSX9+d0Zs4MUBUhXIz50kP1tKeq+MirBkEkbKFAAYBaOXN
         JG1hJZIsZNQNS3IQy82edvOiCA3s0e88yoKD7Ff7G5WFtYzREyphBn787Vw+97tGjJws
         v2ta95mudqlGBLpn79mpbqEBn2TXE8rIOW53pv/t+o2bXAmq+G2Cl3gQ+Tc6CbkGEcKU
         a6t8spJGwrq92YwPeJ4AMNSHF8NiXRkbGJC0ph0jURL8LAJ35A2jTW8FEZ7ZzV5iJMdG
         lrdysqXgFT3NFUk8YpIAUPXnClrYcj3iH2ZA2PyMFzynxg3inyyqwI51eEpSmoVIsYBG
         +osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GkhhNYn/r887xj4Na+y/doa2OuGV4q1++broONJrqV8=;
        b=F5KcX9DYPbPWiydiZ55YYaq6yR8HnZcHzVkXc5VqYJ6jarki1PtAXB2qYASyqQ6dR/
         K2XQzz7p0iv74AqPZBw6ULQiUrZG7H/khw3UBOBqPFXmhzOHzi0p39RMlFrE3hRJeSrn
         SET32Icc+7+SAscv+nanviHrH70EuaweSXnafkBXNVY1vd9KF/yt/CBa3hjnyFLHT8Xh
         +1p09+JXf3meWgRuTa6urIPjtM9ZZShDdoOLcwa6XSer9T0GhyvbA5vN5jufjUK1NCfa
         ykSm3vfUsdo5cyC5Epsigec/ogDssc3B+TCfzLP7jiF3rDnFY2JuF8N3lIExR63m/4O9
         oCGQ==
X-Gm-Message-State: AOAM531BEH2XiEaqwzcpvyocalmS/PLVCwtIrEoDolT81sNQbvSJwe9f
        cK1jWfFsP3QG4U6QSlpJ4Yqa3TtFXL6wUC/2Cq3tP2OI5smJIQ==
X-Google-Smtp-Source: ABdhPJzAAaRPMJ222w4f2HVId1nVSL4R/UII3zx0sxN9CLdTUXR/9t3yvn6lh82dvyYn21JbeWMzTsHrbkRUqB+u/Hg=
X-Received: by 2002:a17:907:20ec:: with SMTP id rh12mr42295397ejb.15.1634683702032;
 Tue, 19 Oct 2021 15:48:22 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 19 Oct 2021 18:48:10 -0400
Message-ID: <CAN-5tyENSpchN3UYz6_whVQ13ZFobw63=gLjGWdVR0MbJvsEuQ@mail.gmail.com>
Subject: help debugging/understanding the use of rdma-core's rdma_get_send_comp()
To:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi folks,

I'm looking to see if somebody can help explain why
rdma_get_send_comp() would fail with EAGAIN (after what looks like a
successful send) and how to either not get into that state or recover
from that state?

Just like in librdmacma/example/rdma_client.c the code does
creates ep.
registers memory for send/receive
rdma_post_recv()
rdma_post_send()
rdma_get_send_comp()
rdma_get_recv_comp()
On the network trace the send generates correct bytes and the server
acknowledges that with a good ACK. Yet, rdma_get_send_comp() seems to
say there is a problem? Furthermore, once in that state, doing a
disconnect, destroying ep, doesn't seem to get the client unstuck from
that state and on the next creation of ep, connect, 1st send generates
a send_completion problem again. This state isn't hit every time from
the start. It takes a while for this to trigger and the code works
normally in sending, receiving rdma messages. But once it gets into
that state, only a reboot seems to get the code working again until
this state is reached.

I'm aware that alternatively, we can create our own event_handler and
do the ibv_poll_cq() but I'm curious if there is something inherently
problematic in doing rdma_post_send(), rdma_get_send_comp() that leads
to issues?

In general, it's unclear to me how a send completion can fail after it
looks like that the message was successfully sent.

Thank you.
