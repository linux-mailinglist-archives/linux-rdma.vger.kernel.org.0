Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4110748C73F
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jan 2022 16:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243948AbiALPcz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jan 2022 10:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbiALPcz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jan 2022 10:32:55 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D90C06173F
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jan 2022 07:32:54 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id e81so3797843oia.6
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jan 2022 07:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cayk.ca; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=+YAk70CwM7atxd+JlZmi+eQG8v6x8b9XWTao+RgBzZo=;
        b=ddWkoU7NgXTK8PR8GyzhjJl4fzIghEUjtO95nNCRuAWS+mw1pJcg0q45aG9m34Nnf9
         OUCg8IwBduBzo24JK2gWEszNPmqtbNIaKa8iccDEER/zW2cqRcMjBKW1F7ie4Pholt5X
         1fAvVOpsYGDF9XRQ8iX3wjSWfNNyPi008zQWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+YAk70CwM7atxd+JlZmi+eQG8v6x8b9XWTao+RgBzZo=;
        b=1cG/pEyBDt9xsvd7a30CveXfn8yAAqyWfgks8IrPO87X712H90eBYaMJ8e5nvv+lsq
         uJqonOyff6/EHdrW7hbY/4RcF4mdfUBfea+9DT2L7J0/7vtIhYXuQrpmqsxw3Dm/i9eA
         b6qwEd8AQ/h3Np/e/5y5v86fBk8avgC1STuMwjXDXkkHnODpQ1/9VfDnHY42UwObnU5P
         1Uttvh2eHCUBWG+9l+22B+Dppq9EEme0M7dSQ/lDsqWLXMDjnZii31rEmAYIH2lUq6z2
         sgq2Q6Xs+SLMbOcTMYsWQKnqzK0iMvbqdCBcdjHLphZorzEvBSaEK/jskeW7XAKvW9t0
         rUNg==
X-Gm-Message-State: AOAM531hyAxJnsHY5yY/RMK1CSfGtreJJY0H5sXfVSez5+uYSbj2SaVc
        etgJvL7AhRLMS5Iv5M2+dRevuB15zGVpP/g=
X-Google-Smtp-Source: ABdhPJxayGOeZnD1NA6G93B+6HFVCGjQ74oSSNImD4yiljR5MmmVbkGTyUU1TeG/7RGrBV2HFO9b1w==
X-Received: by 2002:a05:6808:190c:: with SMTP id bf12mr29505oib.144.1642001574184;
        Wed, 12 Jan 2022 07:32:54 -0800 (PST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id i16sm32655ood.41.2022.01.12.07.32.53
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 07:32:53 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id i9so3820133oih.4
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jan 2022 07:32:53 -0800 (PST)
X-Received: by 2002:a05:6808:1b2b:: with SMTP id bx43mr46207oib.38.1642001573525;
 Wed, 12 Jan 2022 07:32:53 -0800 (PST)
MIME-Version: 1.0
From:   Joshua West <josh@cayk.ca>
Date:   Wed, 12 Jan 2022 08:32:17 -0700
X-Gmail-Original-Message-ID: <CAMCTd2kE7M3-ECU1oyz1ZHgiK1fmfkdvJsFssLV0h=bzexiRZQ@mail.gmail.com>
Message-ID: <CAMCTd2kE7M3-ECU1oyz1ZHgiK1fmfkdvJsFssLV0h=bzexiRZQ@mail.gmail.com>
Subject: RDMA Bridging? ("You don't know that you don't know")
To:     ceph-users <ceph-users@ceph.io>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey Folks,
 - For background, I am working with a small (home-lab) ceph cluster
on a proxmox cluster.
 - Proxmox uses a shared cluster storage to pass configuration files
around, including ceph.conf
 - All nodes are connected with Mellanox connectx-3 (mlx4_core) 56GbE
cards connected via qsfp switch.
 - I am experimenting with Mellanox connectx-4 (mlx5_core) 100GbE
cards between two nodes, primarily for fun and to learn, as I can't
afford a 100GbE switch for a hobby.
    -- (The two 100GbE cards are direct attached to one another)
 - Lastly, ceph is using the (unsupported?) rdma config
(`ms_async_transport_type = rdma`, `ms_bind_ipv4 = true`,
`ms_cluster_type = async+rdma`)

My question:
As each ceph osd is communicating with each other by specifically
naming the rdma device it should be reached at, for example:
```[osd.0]
ms_async_rdma_device_name = rocep8s0```

I am having trouble rationalizing how to allow the two nodes with
multiple RDMA devices to communicate with one another, without
disrupting the ability for the rest of the cluster to still
communicate with the lower throughput rdam device.

For example:
rdam dev
`0: rocep68s0: node_type ca fw 12.16.1020 node_guid
7cfe:9003:0026:88ac sys_image_guid 7cfe:9003:0026:88ac`
`1: rocep65s0: node_type ca fw 2.42.5000 node_guid 0002:c903:0042:dff0
sys_image_guid 0002:c903:0042:dff3`

If ms_async_rdma_device_name is set to either device, then
communication only partial connectivity can occur.

What is the correct method for "routing" rdma / RoCE ?



Josh
