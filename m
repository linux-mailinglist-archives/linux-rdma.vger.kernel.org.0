Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A021F24245D
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Aug 2020 05:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgHLDlE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Aug 2020 23:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgHLDlE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Aug 2020 23:41:04 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6C1C06174A
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 20:41:04 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id l84so610875oig.10
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 20:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SF4iuQCCcU6o6Na1D9BAvSPgWl0SIFYxA2Jcscu/+JM=;
        b=Rw4ChUjBBfdLLagN1VeA8OBlJVBv7f/dn4m0nCuMcpuyDZOtFUSRFFm2lWRLaWKULd
         4WidiwmJKRHtM+vH4MClRnvI6QAuM5eTPV8iYvrjE3bAfxyHjGjybBTUUQwFxzpz9/oe
         x+iUUwhw48DR0SJCisNjZuc6yT0P6QbxacWpt+Nfc377pCZeQTo1tNAFL3ON61ChN8SI
         pfLt0+R0egb5WUK7mdkhMaFQMJflbJy1+TA2NrWbmA5cA5cldj99KmAwByQZVSiO4kn0
         TEUYwKdIjGLcegiLuxx/1yv17YFwWi5M8+RM/NMWMjo6yfxr9i0Qmsl80oudVcJuNkl3
         vVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SF4iuQCCcU6o6Na1D9BAvSPgWl0SIFYxA2Jcscu/+JM=;
        b=gKk6OYSU9Ws0QBJtZgfnP37ssowtoEJU7Ssxh2VUM/hSgNh0kn5ptASm8axMdfansX
         SxbdzbuQ/SHDt90OCr33hdoA0TJq/qCj6do7wkyUQYOGIqYmyxtyKaGZk/qmZ+9lpZze
         yUu8pSniA/hZhltG8/2jM+uh2YYSK7xDWzeNm7J4V7DfggmW6U2AJqWH8ole4R+mu692
         aZKXzUi7524QuJg1l0fefgATJxlSiBEAXurfVW6Aezal0NoNHPlKLiVEQQ/GYzLotqmb
         lskJFdfzUjm7MChz5KUp/7i+LO+DwT6kztPSKPpp/5XzIyknkr55g3BnHWNzz/ka7rvb
         Qt+g==
X-Gm-Message-State: AOAM533zfT0EGn9HncHvVwy7Rmndp6o4AvEQXDM5c2MKAS5lN0K1oREB
        hnYrHWHYAHcVqJJ4tTDogzr1clxy66I=
X-Google-Smtp-Source: ABdhPJz0U/Cq7VBsfW13kS/mSEYqxS6OfNvqRYLYtHnp51B2qdGyghecS8vr2hnbVANkFNQ1CleRoA==
X-Received: by 2002:aca:cd05:: with SMTP id d5mr5730055oig.138.1597203663612;
        Tue, 11 Aug 2020 20:41:03 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:581e:50ac:ae30:b7b6? ([2605:6000:8b03:f000:581e:50ac:ae30:b7b6])
        by smtp.gmail.com with ESMTPSA id e5sm189095otb.81.2020.08.11.20.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 20:41:03 -0700 (PDT)
To:     linux-rdma@vger.kernel.org, jgg@nvidia.com
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: Is there a simple way to install rdma-core other than making a
 package?
Message-ID: <75bbc81e-cde9-c8ac-0ba3-04bf17b8d5fa@gmail.com>
Date:   Tue, 11 Aug 2020 22:41:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There doesn't seem to be a documented way to make install rdma-core, at least in the README file. However trying the obvious

$ bash build.sh
$ cd build
$ sudo make install

seems to work, almost. After a few 100 lines of promising output I get

CMake Error at librdmacm/cmake_install.cmake:76 (file):
  file INSTALL cannot find
  "/home/rpearson/src/rdma-core-git/build/lib/librdmacm.so.1.3.31.0": No such
  file or directory.

Looking I see

# ls -l build/lib

....

-rwxrwxr-x 1 rpearson rpearson  263384 Aug 10 12:31 libqedr-rdmav25.so
lrwxrwxrwx 1 rpearson rpearson      14 Aug 10 12:31 librdmacm.so -> librdmacm.so.1
lrwxrwxrwx 1 rpearson rpearson      21 Aug 10 12:31 librdmacm.so.1 -> librdmacm.so.1.3.31.0
-rwxrwxr-x 1 rpearson rpearson  138536 Aug 10 12:31 librspreload.so
-rwxrwxr-x 1 rpearson rpearson  112488 Aug 10 12:32 librxe-rdmav25.so

....

with no librdmacm.so.1.3.31.0 as advertised. On the other hand if you stop after bash build.sh and before make install you get:

-rwxrwxr-x 1 rpearson rpearson  263384 Aug 10 12:31 libqedr-rdmav25.so
lrwxrwxrwx 1 rpearson rpearson      14 Aug 10 12:31 librdmacm.so -> librdmacm.so.1
lrwxrwxrwx 1 rpearson rpearson      21 Aug 10 12:31 librdmacm.so.1 -> librdmacm.so.1.3.31.0
-rwxrwxr-x 1 rpearson rpearson  608632 Aug 10 12:31 librdmacm.so.1.3.31.0
-rwxrwxr-x 1 rpearson rpearson  138536 Aug 10 12:31 librspreload.so

So the make install seems to be deleting the .so file. Nothing like this is happening to the other libraries. 

Any help would be appreciated. I would like to be able to install this version of rdma-core on the system.

Bob Pearson
