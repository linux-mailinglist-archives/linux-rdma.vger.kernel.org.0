Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D642C3C0
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 16:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbhJMOpd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhJMOpd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Oct 2021 10:45:33 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB8BC061570
        for <linux-rdma@vger.kernel.org>; Wed, 13 Oct 2021 07:43:30 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t4so4115185oie.5
        for <linux-rdma@vger.kernel.org>; Wed, 13 Oct 2021 07:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=H8ylmruZ49Tt8MlZIbYSBH6a2la1e/gkOCXRPw+0XDc=;
        b=dBcabcIU4o2YYElPkvOIwfC3Xi77IIsqUQJG+Ye0eb4Ry7bJvsjOoeh8ZCnEdguInk
         rwFs6HdawtpXHQxf4Zh6qjMY6B0EEm2oTuKlvw/UUNQiENT7Z4dzsB+r8ZWDX6AMrDT2
         OWOt1GLQL0dCrw392kLHTk43UIRAh+j8eW3eldJByeKC1OMaWleZfKRLhuMZxj5dByaN
         4MrXNCvc6gInmQ9z7vsceBo0EoPItu8LdwXoYpiOO6iFH3g3QMCeQ00Uv99MlZNe5Zyd
         PkRq8JgGXoa4RBXsFho2UtY/LmsD4NPdTbZIPPKs2jUY0n1tH1RkOeEslf7PbpV+Dw1f
         CtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=H8ylmruZ49Tt8MlZIbYSBH6a2la1e/gkOCXRPw+0XDc=;
        b=4Y4YB8v2OHfMKTmxMDUasJ7QBegeNxNvrbDRlsDmGiEwNCpbSUsyOnQ8YcX7Wp3WVT
         ZIhTLxtUES5rzM/hCjDI48YXm0CnM50mH6763C8RSi+JZb2t7GdRwnFYR9fwvzvAGWrs
         en3brhf3FSRWKlmrCbA9OooFMlyq/JGYUvNpa+ND/u17l6M5rCEKL5cVDtohZynUzaJu
         G48YMUKKRvXPwSa5wny9zWZfGtEvNiFdv0/s58KM+3krBPt6lNeS3mCvfSU8/fndDf1O
         xvxQQoU7wzbPw0IJo9uvPnkSZC1kGjtzrsaPHg7QOyrz25oMMVWEu3NgLzALGjZhp9dQ
         g7/g==
X-Gm-Message-State: AOAM533YTbI9Atze/XVtn4Q83t2WPV6o52yf3mbDSL9hACWkcExOAXP6
        Be64/w0f4S6HcLcvT0vtTPPu7JXrBIs=
X-Google-Smtp-Source: ABdhPJwCb4s/Ct7y2Y1cVz2BTnJYbRMP47KbqzFCCaWTf4BENHXfqzqRN/TRtC5mR9YF2WOOdxOr2A==
X-Received: by 2002:aca:f0c3:: with SMTP id o186mr8755375oih.37.1634136209179;
        Wed, 13 Oct 2021 07:43:29 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:d3c6:f8df:4041:d902? (2603-8081-140c-1a00-d3c6-f8df-4041-d902.res6.spectrum.com. [2603:8081:140c:1a00:d3c6:f8df:4041:d902])
        by smtp.gmail.com with ESMTPSA id l19sm348920otr.22.2021.10.13.07.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 07:43:28 -0700 (PDT)
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: 10 more python test cases for rxe
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Message-ID: <34a9a53f-1f1f-bddb-0c8e-63ec5fbcd28e@gmail.com>
Date:   Wed, 13 Oct 2021 09:43:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Zhu,

There are about 10 test cases in the python suite that do not run for rxe because

	... skipped "Device rxe0 doesn't have net interface"

Clearly this is wrong and I don't know how to address the root cause yet but the following
hack where enp0s3 is the actual net device that rxe0 is based on in my case enables these
test cases to run and it appears they all do.

diff --git a/tests/base.py b/tests/base.py

index 3460c546..d6fd29b8 100644

--- a/tests/base.py

+++ b/tests/base.py

@@ -240,10 +240,11 @@ class RDMATestCase(unittest.TestCase):

             if self.gid_type is not None and ctx.query_gid_type(port, idx) != \

                     self.gid_type:

                 continue

-            if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):

-                self.args.append([dev, port, idx, None, None])

-                continue

-            net_name = self.get_net_name(dev)

+            #if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):

+                #self.args.append([dev, port, idx, None, None])

+                #continue

+            #net_name = self.get_net_name(dev)

+            net_name = "enp0s3"

             try:

                 ip_addr, mac_addr = self.get_ip_mac_address(net_name)

             except (KeyError, IndexError):


Apparently base.py expects there to be a directory /sys/class/infiniband/rxe0/device/net
that contains another directory with the same name as enp0s3. When rdma-core builds the
kobj tree 'device/net' is not added to rxe0. There is a 'parent' plain file in rxe0 with
the contents enp0s3 so there should be an easy work around in base.py but I don't know if
there are other places where the 'device/net' branch is expected.

If you know the best approach to fixing this please let me know. In the mean time this
gives you a way to run the rdmacm test cases.

Bob
