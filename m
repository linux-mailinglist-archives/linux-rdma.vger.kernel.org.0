Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8C31FCBB2
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 13:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgFQLE3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 07:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQLE2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 07:04:28 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E1CC061573
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 04:04:27 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z206so1027106lfc.6
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 04:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=92dP5bDd4DMLDtAElZCC+zyR1bMknOEMBXlUeB3qUHc=;
        b=TJGRTb/Sz4xkeOxooFOZzjqJXMelBFg5u8Cu7kkcMwI1OtevYLvjEn1QOdDy3YeEl5
         Ebi3yC/8JhCWJ3RR6v3ZQaF2M8QlYelUhJ7x1NTSarJ+QZHD5yjyuAQMs8M2BnSA8+Zz
         WD/3RGqLR+XdEanD8hvY3uLXa36mNCf5NAEEqRfsq8E1H9UsuQA9kqpKJhvhnr7kDfLD
         iDu4NTOFgvrIO+CGUCF5AuXeCjF45cN7tqm221wnyz3YPeLfD6Jo7LDUW8VGDGWuLJ1/
         vl8F0LlLZS22wIqLpyG+3XkZo7JobdFTzp+7T4PTVdBmu5cJJ7Qd3bOusF8UQzQVKM2q
         8usQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=92dP5bDd4DMLDtAElZCC+zyR1bMknOEMBXlUeB3qUHc=;
        b=GDWc4Jvn8ZedNt3Q0q4yr314eJT0S1POQqVeh2y20WAjbTtbwtmlx699S2KPYvbKow
         tFs+zEf0dcEvp2bpWwONd4X7Vhg+LdkeaSsg+nJZDGYznml8usCRCHke3hiSgVGdXaXS
         jmYWksBE/a01Tv0F3MMn2vNxnkCt2SxJGCzrdf7w22VzuiJhY5kDVOaU4Q0qMQhY/EJR
         NLt1dofWPrX2xZs3+T0JzlIdNuzTbGjrnJ9y7sTirRctxW5zTUvzgHEfvyI3TI/TMKbe
         MQoGlfViNAzeIJcyRZQaVl359Qg9v2KZXt8qzpESbjy4r9R+7We71KgjttLxFlUDI8SP
         aEEg==
X-Gm-Message-State: AOAM5302R14WIJmqAOG+U7NIYX/qjQZZnnfBpoa4t+LtixGV308pVtyG
        JBTxcE9DB4tBQ1AMF87e8O4HnMz+rdCuqdzHaqxeWneCcwQ=
X-Google-Smtp-Source: ABdhPJzYcjMfPdmD+LYbBOZal0mM8Y1fZ4+1uCt6IFvhqOobrb0VqL8XGnDSmHvw6CumuwoP29kcbNDklZecgVA4+PQ=
X-Received: by 2002:a19:d06:: with SMTP id 6mr4216984lfn.214.1592391866004;
 Wed, 17 Jun 2020 04:04:26 -0700 (PDT)
MIME-Version: 1.0
From:   Vladimir Chukov <vladimir.chukov@cloud.ionos.com>
Date:   Wed, 17 Jun 2020 13:04:15 +0200
Message-ID: <CAL94vcd2bHKHZaw7wsRMMyk1FCq+nRFR-XD2W0ueG_dgOyVFew@mail.gmail.com>
Subject: [BUG report] rdma-ndd: wrong NodeDescription for second device
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Description: rdma-ndd sets correct NodeDescription for device which
was initialised first; for the second device description in sysfs is
set correctly, but saquery  to that node  will return default
"NodeDescription.........MT4119 ConnectX5   Mellanox Technologies"

How to reproduce: initramfs-tools 0.130+ (default for buster) - loads
mlx5_core/mlx5_ib in initramfs, ports 1 and 2 are connected to
different fabrics (not to the same switch), as a result very close gap
between mlx5_0 and mlx5_1 netlink events. Then use saquery <lid of the
second port> -C mlx5_1

Workarounds: blacklist mlx5_core and mlx5_ib in initramfs OR connect
both ports to the same fabric OR restart OpenSM (will re-read sysfs)
Non-effective workarounds: systemd rdma-ndd.timer, systemd rdma-ndd
ExecStartPre sleep

Information about your system:
Linux distribution and version: Debian 10.1
Linux kernel and version: 4.19.118-2+deb10u1
InfiniBand hardware and firmware version: MT4119, 16.27.2008
OpenSM version: 3.3.20, 3.3.21

--
Vladimir
