Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9233148D1AE
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jan 2022 05:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiAMEhQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jan 2022 23:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiAMEhP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jan 2022 23:37:15 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E53C06173F;
        Wed, 12 Jan 2022 20:37:14 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so9194691pji.3;
        Wed, 12 Jan 2022 20:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic
         :mime-version:content-transfer-encoding;
        bh=ReiPRdKbAYAz8Wc20+YlwwNALS1tww0ehBQWUS0whF8=;
        b=bY7wLtla31MrkOvjjur337QduwBukT7caLe3dbp7PphL6nCRu89nqr+Ru++uRDlMA7
         1xWOej8F4poERw0ZxR/i7A1CriafC/8W4vdsiIcCOJGLEWPf4czlgQxBYcA8sUa+D0D8
         Bp6sY3Wf1WoGKlVPLDOKnkgXlUDMDDV16Ss1eMhffzrGAGbbN+57HAtrEdSuhmcvjFpZ
         r2f0xsfdcD8VhT+CV+jIeocw0ZJUdv8EJ1zuDSqUJMAW3KqIX1BfetoaIgyt151vvt7F
         AWIBmDG5aM02gLg2PzLZK5s2FZzIKQ31Q7EMoCuJ6p9v7Vqo32g1uH+qmtMBCa6m7G+X
         oq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:user-agent:date:subject:from:to:cc:message-id
         :thread-topic:mime-version:content-transfer-encoding;
        bh=ReiPRdKbAYAz8Wc20+YlwwNALS1tww0ehBQWUS0whF8=;
        b=lUsMXHK5usag27fU2QEGye4itVgBD9qbdb+9SnpcyoLB7cuS7eg72WqwLwBXshqjAf
         b0Go8AW3wjKczV/O5JjaHMUNx7b/H0jRE1wtTH3Fe1v4ToPP+zK9v8r8fn7XWKjdVqTc
         WzAKInD+Xo94rn3aApFeoJ44sFqdnUo2nq8CUZdqAPB9YJSuwKlEfiHzVOJV9VsTKvOG
         0jnIVOrWqoOHCPAulEA8UbE1612KSZoHbjXCk0uEXaFbv1/343A7UFcvGrbpc2l7xalE
         /nVkJJVz9GIhIYUIXqHT6twYg6rRh8TEIpKlZDD978HUUWNs2iX4DrG9VE3/W2Tayuyt
         O1Ng==
X-Gm-Message-State: AOAM533NpRyz3CJj8Qo/NbQRyLqC1cUQ1gcUHDK4hc48GV3ryevUh9CB
        XGJwLPdQjAkpv5Ic0lNXKQ9FbSIHmPcDkgQV
X-Google-Smtp-Source: ABdhPJwnFXHDphKTT3j0Pa1yPv0kR/uHBrwOVCIJNMHKVOXfmuphY3aLf5qyULHOOQngZ8XeXPV1tw==
X-Received: by 2002:a17:903:1110:b0:149:a428:19f1 with SMTP id n16-20020a170903111000b00149a42819f1mr2735333plh.120.1642048634371;
        Wed, 12 Jan 2022 20:37:14 -0800 (PST)
Received: from [30.135.82.253] ([8.218.232.85])
        by smtp.gmail.com with ESMTPSA id b4sm7137900pjh.44.2022.01.12.20.37.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 20:37:13 -0800 (PST)
User-Agent: Microsoft-MacOutlook/16.56.21121100
Date:   Thu, 13 Jan 2022 12:37:10 +0800
Subject: mlx5: memory leaks
From:   Ryan Cai <ryancaicse@gmail.com>
To:     <leon@kernel.org>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-ID: <76193B8E-6A8B-4FF9-B6BB-A3A17FB74A61@gmail.com>
Thread-Topic: mlx5: memory leaks
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, Kernel Maintainers,

    In method mlx5_ib_destroy_gsi of gsi.c, there are memory leaks when ret = ib_destroy_qp(gsi->rx_qp); returns true? I think, ib_free_cq(gsi->cq); kfree(gsi->outstanding_wrs); kfree(gsi->tx_qps); should also be put before return ret before Line 180. If this is a real bug, I can send a patch. Thanks!



Locations: https://github.com/torvalds/linux/blob/master/drivers/infiniband/hw/mlx5/gsi.c#L168-L197

Best,
Ryan



