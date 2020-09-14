Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBBA2684F7
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 08:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgINGf5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 02:35:57 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6843 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgINGf4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Sep 2020 02:35:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5f0f1d0000>; Sun, 13 Sep 2020 23:35:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 13 Sep 2020 23:35:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 13 Sep 2020 23:35:55 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 06:35:55 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 14 Sep 2020 06:35:55 +0000
Received: from mtl-vdi-864.wap.labs.mlnx. (Not Verified[10.228.136.155]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f5f0f4a0000>; Sun, 13 Sep 2020 23:35:55 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>
Subject: [PATCH rdma-core 0/8] verbs: Query GID table API
Date:   Mon, 14 Sep 2020 09:34:55 +0300
Message-ID: <20200914063503.192997-1-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600065309; bh=6SzPJRWtFggQ8r8SY/3X6sL77ToIMIZJAcZMT0oogAA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=bjy6FeQFm598sYnkCbV4+whH0DlHO9bY53fTReB1NvJFf+BwmW3xgyVCIHkZD5QHz
         cYbzHpuZF7a/Tfs66kjX3AVZhUzQEt1K6A50072smk0fT7MjKhHx8hDGOndCeU99NX
         zawSrhsCxOZdqZh++POwjzH+WlK0cRoiXIwRijkyf9CXM3g45drG7eisbGH30hWjon
         KE0yUT6zRaRqTuXq87egZKCBdj60U7+OZhNL623K0neI2UqJwOB7HIv7qE1AxNQ7a8
         ZQ4pd8+fASwHMvvmcqA7NAFQvQFscTsnl45b6rPSyC6Klpq8IBLiaoQrGxkIHuZXZ9
         N+uI7cxC+aAqw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When an application is not using RDMA CM and if it is using multiple RDMA
devices with one or more RoCE ports, finding the right GID table entry is a
long process.

For example, with two RoCE dual-port devices in a system, when IP failover =
is
used between two RoCE ports, searching a suitable GID entry for a given sou=
rce
IP, matching netdevice of given RoCEv1/v2 type requires iterating over all =
4
ports * 256 entry GID table.

Even though the best first match GID table for given criteria is used, when=
 the
matching entry is on the 4th port, it requires reading 3 ports * 256 entrie=
s *
3 files (GID, netdev, type) =3D 2304 files.  The GID table needs to be refe=
rred
on every QP creation during IP failover on other netdevice of an RDMA devic=
e.

We introduce this series of patches, which introduces an API to query the
complete GID tables of an RDMA device, that returns all valid GID table
entries.

This is done through single ioctl, eliminating 2304 read, 2304 open and 230=
4
close system calls to just a total of 2 calls (one for each device).

While at it, we also introduce an API to query an individual GID entry over
ioctl interface, which provides all GID attributes information.

The APIs are based on the below RFC [1], the matching kernel part was sent =
to
rdma-next.

PR was sent as well [2].

[1] https://www.spinics.net/lists/linux-rdma/msg91825.html
[2] https://github.com/linux-rdma/rdma-core/pull/828

Avihai Horon (7):
  verbs: Change the name of enum ibv_gid_type
  verbs: Introduce a new query GID entry API
  verbs: Implement ibv_query_gid and ibv_query_gid_type over ioctl
  verbs: Optimize ibv_query_gid and ibv_query_gid_type
  verbs: Introduce a new query GID table API
  pyverbs: Add query_gid_table and query_gid_ex methods
  tests: Add tests for ibv_query_gid_table and ibv_query_gid_ex

Yishai Hadas (1):
  Update kernel headers

 debian/libibverbs1.symbols                |   3 +
 kernel-headers/rdma/ib_user_ioctl_cmds.h  |  16 +++
 kernel-headers/rdma/ib_user_ioctl_verbs.h |  14 ++
 kernel-headers/rdma/ib_user_verbs.h       |  11 ++
 kernel-headers/rdma/rdma_user_rxe.h       |   6 +-
 libibverbs/CMakeLists.txt                 |   2 +-
 libibverbs/cmd_device.c                   | 215 ++++++++++++++++++++++++++=
++++
 libibverbs/driver.h                       |  29 +++-
 libibverbs/examples/devinfo.c             |  14 +-
 libibverbs/libibverbs.map.in              |   6 +
 libibverbs/man/CMakeLists.txt             |   2 +
 libibverbs/man/ibv_query_gid_ex.3.md      |  93 +++++++++++++
 libibverbs/man/ibv_query_gid_table.3.md   |  73 ++++++++++
 libibverbs/verbs.c                        |  95 ++++++++++---
 libibverbs/verbs.h                        |  45 +++++++
 providers/mlx5/verbs.c                    |   2 +-
 pyverbs/device.pxd                        |   3 +
 pyverbs/device.pyx                        | 108 ++++++++++++++-
 pyverbs/libibverbs.pxd                    |  15 ++-
 pyverbs/libibverbs_enums.pxd              |  11 +-
 tests/base.py                             |   3 +-
 tests/test_device.py                      |  32 +++++
 22 files changed, 761 insertions(+), 37 deletions(-)
 create mode 100644 libibverbs/man/ibv_query_gid_ex.3.md
 create mode 100644 libibverbs/man/ibv_query_gid_table.3.md

--=20
1.8.3.1

