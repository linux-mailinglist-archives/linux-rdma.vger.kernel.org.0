Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88769262C64
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 11:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgIIJri (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 05:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIIJrh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Sep 2020 05:47:37 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3454FC061573
        for <linux-rdma@vger.kernel.org>; Wed,  9 Sep 2020 02:47:37 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id h206so1352709ybc.11
        for <linux-rdma@vger.kernel.org>; Wed, 09 Sep 2020 02:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ska-ac-za.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=gYB9LqR/14ONneTOJHQU3l0lF8vgy7tCXRHR3vagiSU=;
        b=WUMPFYnkps3lL4pVd0wJohRk2R/O4B8Ob/CjV+/USIlqjUbaPHL8bgH+YeQgV1vwE1
         XD7GzTvblJHygPVXF3YRIHYhd8pjx1PWF71vYJqT0823SrV/b/hcGWrdNqC8CbhkT6FT
         8ckvOEg3+XJZBKsbDW+L5LeB1OhsNgn3jTw0zcC1Huu9PBBqjwCKSd7kAeDDAC/uVTV2
         DafRbwx+8B/9c7F9RtQGtrfroY1zxIiJywrH1nAjdeUGdOxZGfFOiC9PodKhtYiTlZSw
         xrtbe/L6hgYFo9w3HRKDadeijaZcMFai5geY+hBRkNY0xqsOCsImPBIPC+Q3YG4WAFQq
         ov0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gYB9LqR/14ONneTOJHQU3l0lF8vgy7tCXRHR3vagiSU=;
        b=L5EL2ErEJoo6T7WRV120JjnDiDrHySRFugtS3Wo+D7Ib685KDfmZkXd9FPTTvzWTpp
         TBZR3D1EFon5b86b4q7mXexviTURPgctVFs0UUeGa4swl6lRPoqbBT+zvfnrqGRvGduy
         44vjYX+xLwksZgMy4lDSJslId49Q8TB73iISLHJODJvoEzQky8xhj4FpYUbMqMv8ACry
         2OzS/9kOZZkCCsFQLKtq0Qhu0+59giA6/w4LdcalUp/tM+HpoAXqN7ZyX761gQPQkLht
         CWy6afHGQvbDlaGc5Tiec8nzmd8olBzoQEb4JKGHa86SninClSQEgLDlA2ZdPR9fca7v
         nLBQ==
X-Gm-Message-State: AOAM530qY5RXVEGhWcNOchdYGT2cigp8/ZZemeij8e151rxXFzTCkT39
        G85jqG4eJFJGFaqN0aY6178IOES81hgWiWeftpbszq6b0hGRdkGT
X-Google-Smtp-Source: ABdhPJwN69L5M4t63KtA36E0eelKbHB7ZFxp5MqZrQ8pzTUyHkiG2M9Bp3PC83YXImCTb6bDwTAO2uQ1bcEu4cwySPE=
X-Received: by 2002:a25:4843:: with SMTP id v64mr4680619yba.187.1599644855027;
 Wed, 09 Sep 2020 02:47:35 -0700 (PDT)
MIME-Version: 1.0
From:   Bruce Merry <bmerry@ska.ac.za>
Date:   Wed, 9 Sep 2020 11:47:24 +0200
Message-ID: <CAOm-9apwANddPcn4BYZwjV9Rd=f+Y6WRuwBwBxMM+aapOAwbXw@mail.gmail.com>
Subject: Bug report: in-place build exposes fixup headers, breaking static_assert
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When building with the recommended build.sh script, it seems that some
header files that override system headers get installed into the
build/include directory. I'm guessing these are intended to be used
while building rdma-core itself, but have the effect of interfering
with other software that is specifying this include directory to build
against rdma-core libraries.

The case I ran into is that an assert.h file is added that #defines
static_assert to an empty macro. Apart from silently disabling the
static assertions in users' code, this breaks compilation of C++11
code, because the arguments to static_assert may contain a comma (such
as in a list of template arguments), leading to errors because the
preprocessor splits on the comma and sees more than two arguments to
the macro.

To reproduce, try building this Dockerfile:

FROM quay.io/pypa/manylinux2010_x86_64

RUN yum install -y \
        wget cmake3 ninja-build libnl3-devel

RUN wget https://github.com/linux-rdma/rdma-core/releases/download/v31.0/rdma-core-31.0.tar.gz
-O /tmp/rdma-core-31.0.tar.gz
RUN tar -C /tmp -zxf /tmp/rdma-core-31.0.tar.gz
RUN cd /tmp/rdma-core-31.0 && ./build.sh

RUN echo -e "#include <cassert>\n#include <vector>" > simple.cpp
RUN g++ -std=c++11 -c simple.cpp -I /tmp/rdma-core-31.0/build/include


The compiler output starts with:

In file included from
/opt/rh/devtoolset-8/root/usr/include/c++/8/bits/stl_iterator.h:66,
                 from
/opt/rh/devtoolset-8/root/usr/include/c++/8/bits/stl_algobase.h:67,
                 from /opt/rh/devtoolset-8/root/usr/include/c++/8/vector:60,
                 from simple.cpp:2:
/opt/rh/devtoolset-8/root/usr/include/c++/8/bits/ptr_traits.h:115:71:
error: macro "static_assert" passed 3 arguments, but takes just 2
    "pointer type defines element_type or is like SomePointer<T, Args>");

When I changed my build process to do an out-of-place install the
problem went away.

Regards
Bruce
-- 
Bruce Merry
Senior Science Processing Developer
SARAO
