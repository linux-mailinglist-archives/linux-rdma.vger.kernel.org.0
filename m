Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE58F189012
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 22:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCQVIM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 17:08:12 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:45483 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQVIM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 17:08:12 -0400
Received: by mail-wr1-f51.google.com with SMTP id t2so17542023wrx.12
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 14:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=photodiagnostic-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=zOd0Vk6bPujnTjI7jkPIPFvRGQvugCSWRic0dUQTHvA=;
        b=D0Z59AbodbPcYWuKXEuyJWwlUuiDMSmw0FSX+3HFFZRArvuSyL+TSJpbRXbW2rDUBK
         gCNhLnxhBX/UfEPf0kaFX4y06fxr4hT7RKOXH7rNkgbKWkAoJWjcYFbEl7Mn9jTLpCpY
         KAPQoQ34fEwX55tr4flzoS5JVUZc3KJaZ1u7BgWkBYr7WlhwjQmvTICk6mwCaUNKte0l
         9eKUUqpDiVvMNc520Z+4v+yNlvGWGVgiKt/veA4YO2dL2L8OEihF58ODIoOQSkxMoyDL
         VH/uvq5uolRtb5N0s75Bb0vequzRNC/eHNRmXdE4lU/NU+iHzoxrbnCV2CB1dghxLhXy
         +BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zOd0Vk6bPujnTjI7jkPIPFvRGQvugCSWRic0dUQTHvA=;
        b=iu1wy6kVQjW9hlVokD4BsIRXXjTl0emU+j4BLHyIgT4qGRwlUWwR+ajK+hV8pHvfdj
         r0KQQdo2pdzzyQUsVjNo7a6I1twMCb8SeKThEwFc7rFNHh8OP/hdLJ9ve91TmMTuOPzC
         txET53ZNs1me6zV+hSUED+TS1zllPccjTkV4nW5hOxIWAqatFVhnomleKI23UdfRV7ms
         y4iAonl0r+K2jP9hE9IP7l4UgQLB7R9TO7XbLCsxeJWs3Cxr80B0jHqHJfN9F6HtKcTc
         potFp0RsMI36BGXoPbCw6ks6iHwn4Cu0wLUkNta4TiPOlrxsMOS1QkmL7xEhM8kXtH3b
         /goA==
X-Gm-Message-State: ANhLgQ36i3MTM1INuUviZDbb09B5sTw30LUQH7TJnj1RyvQGBWUSbQZt
        cAYj5rgvajiJpsQZVa08Dj5YBLH5lz+m40XVOd0X17vKRMxt+Q==
X-Google-Smtp-Source: ADFU+vsKx8gr7VmytGCVyvaIm2lndweUUxv3CHj0RxBicuUC6VGoiB9LQgcSQ0kxGxJE3fL3O5QlbI82q2U2tnqF6U0=
X-Received: by 2002:a5d:6910:: with SMTP id t16mr888547wru.209.1584479289349;
 Tue, 17 Mar 2020 14:08:09 -0700 (PDT)
MIME-Version: 1.0
From:   Terry Toole <toole@photodiagnostic.com>
Date:   Tue, 17 Mar 2020 17:07:58 -0400
Message-ID: <CADw-U9C9vh5rU1o4uSmw=EzMqOvXFqSm-ff-7UbLCKd2CUxT4A@mail.gmail.com>
Subject: Should I expect lower bandwidth when using IBV_QPT_RAW_PACKET and
 steering rule?
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,
I am trying to understand if I should expect lower bandwidth from a
setup when using IBV_QPT_RAW_PACKET and a steering rule which looks at
the MAC addresses of
the source and destination NICs. I am trying out an example program
from the Mellanox community website which uses these features. For the
code example, please see

https://community.mellanox.com/s/article/raw-ethernet-programming--basic-introduction---code-example

In my test setup, I am using two Mellanox MCX515A-CCAT NICs, which have a
maximum bandwidth of 100 Gbps. They are installed in two linux computers which
are connected by a single cable (no switch or router). Previously,
when I was running
tests like ib_send_bw or ib_write_bw and using UD, UC, or RC transport
mode, I was seeing bandwidths ~90Gbps or higher. With the example in
Raw Ethernet Programming: Basic introduction, after adding some code
to count packets and measure time, I am seeing bandwidths around 10
Gbps. I have been playing with different parameters such as MTU,
packet size, or IBV_SEND_INLINE. I am wondering if the reduction in
bandwidth is due to the packet filtering being done by the steering
rule? Or should I expect to see similar bandwidths (~90 Gbps) as in my
earlier tests and the problem is one of lack of optimization of my
setup?

Thanks for any help you can provide.
