Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DCB25E145
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Sep 2020 20:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgIDSDq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 14:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgIDSDo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Sep 2020 14:03:44 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B356C061244
        for <linux-rdma@vger.kernel.org>; Fri,  4 Sep 2020 11:03:44 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id i17so7310267oig.10
        for <linux-rdma@vger.kernel.org>; Fri, 04 Sep 2020 11:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0nxUyARL8BkN1Ry0UoonH9NJx9ySoft5LsZm3cDw8UU=;
        b=HwSBABCWRSAMybo3qkc9FohiuFApmEX4ZJBwkfb/piJSK19R8gZAvFQ7nu4xrk1uLI
         SkKEeMnVqi7U2eu8gP3OTv1NTApDWrvf1wQKhlU2fiJYO9KAMta795CHeta46y+Snl3j
         BZcBX0YpCOsJuFcHXH/927leIUxUvqn1KzpIH2wBe97FaLv1rmSg7vcMfTtFg41n63dV
         pFhLEN39Vz2ES1QKE7AXPAkYFFaEbaxkiFR7VMhV2P78UqVcbSLPq2P5Tv1tk40hdZfs
         ChKQ78xkEYADhGI3is3R1YrHuIhtk+CheTvKtDafqY2NlAYAprUUbOvO9Fzs67LwSw+d
         UQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0nxUyARL8BkN1Ry0UoonH9NJx9ySoft5LsZm3cDw8UU=;
        b=g2ScEjngT+zabOpCO4CvO/c+bsLyG+dCEqSUiqaWGMnjC6sLgZm9LQ6YbOFMzDxw0V
         0+t5KKKyj3Y147QCdDVTsmwAXTY9//MkY3kS7qVeXA5eEeo5wstoiAJjbFbngYrXky2W
         SNRExc8CL2MCd4D8YmT8AW36Nhf0d3pkdTeBfLOWq1O1684GEQsYcKyeoukPCJVUJd8i
         iWcFtCO8ecVRU8lOKOFTDKR0ouhcOTKKe8dhjcErlBORAkK/G/L9K/teZKcWXq0TXAjA
         fInNaNWpTpJxEo0uYQetD5ahsOyoNBGd2TWyAhOJ06xNfAc9uedjIqKo4rTppgl4P8Oa
         s7LA==
X-Gm-Message-State: AOAM530WbMaGomE2AbkLaoZMnKBk6t4sUbJiVwgnJDBb///jGjkRdmmB
        jeAf35xIZtKJFAm+HqibM5u6WYT68UpsUg==
X-Google-Smtp-Source: ABdhPJypFel8DCoThQol6cUSodqihnw7yM7H2roj56a0zf9FaVHEisjAMkNN9OSry1I3DdUtti7M+Q==
X-Received: by 2002:aca:aa85:: with SMTP id t127mr5755180oie.46.1599242621812;
        Fri, 04 Sep 2020 11:03:41 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:cd83:1070:d266:9e27? ([2605:6000:8b03:f000:cd83:1070:d266:9e27])
        by smtp.gmail.com with ESMTPSA id v25sm1334489ota.39.2020.09.04.11.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 11:03:41 -0700 (PDT)
To:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: pyverbs testing on rxe
Message-ID: <96da1311-18a6-f6a6-be18-9ca034ae1d7b@gmail.com>
Date:   Fri, 4 Sep 2020 13:03:40 -0500
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

Jason,

I am down to two errors and about 30 skips in run_test.py. device_ex, cq_ex and qp_ex verbs are working.

The two errors are from the same source and occur for async multicast rdmacm. The immediate cause of the problem is the test harness is setting up an IPv4 multicast address and then two end points start sending traffic to that address. These packets are delivered to the driver and received by rxe_rcv which tries to resolve a gid table entry for them and fails.

The unicast IPv4 address is 192.168.0.21 which does have a gid table entry. The multicast address is 230.168.0.21 which does not. Presumably the driver wants the gid table entry so it can use it to provide a source address for return traffic but that would just be the unicast address I think. The network stack knows which interface the traffic was received on but rdma/core is trying to solve the problem with just the IP address and doesn't seem to recognize it as a multicast address or have any clever idea what to do besides searching the gid table.

This seems to be a rdma/core issue more than a rxe issue. But it must have come up in the past somewhere.

BTW I got around the other addressing problem I was having by just adding the eui48 IPV5 address by hand with ip addr add.

Bob
