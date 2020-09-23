Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9903B275649
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 12:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIWK1N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 06:27:13 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13507 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIWK1N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Sep 2020 06:27:13 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6b22f40001>; Wed, 23 Sep 2020 03:27:00 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Sep
 2020 10:27:12 +0000
Received: from dev-l-vrt-092.mtl.labs.mlnx (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 23 Sep 2020 10:27:11 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>
Subject: [PATCH V1 rdma-core 0/8] verbs: Query GID table API
Date:   Wed, 23 Sep 2020 13:26:54 +0300
Message-ID: <20200923102702.590008-1-yishaih@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600856820; bh=YnqwE96Y4NneaYQVJj10/zGHm8O5LZd6BptMLVmkU44=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Transfer-Encoding:Content-Type;
        b=AJEvY1m2UBHu5sK+zXfBRKVeB1hP9MGgdMnFd4zQilIuMzdDBAnyN5jYDVXL1xuL/
         +5EuThzkOSp3yji1a77Kat1BJbqFXU6Zy6Br/NezNkHR+VYJGLXlolsd3CMwz+ntRn
         WVwWOOsYwWTWp/Ce4BKZ3JFDuqik1+PbLRRXJJoYwGV7aZzBYDDtq8f++znMQoq9Fv
         B9ACQBxV+EGHROXF80auSWEbVqS0Tc3oGOrbusORiI/NxM7j3INLRSyz4JuzET7CjT
         tWG4ezBDmYWMZQ+P/SE/a00kJtmKCrVYhmHiHKP4AEjsRK9IYre1nrIw8OlcBCiepO
         JkY2j+5KsWqJA==
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

Changelog:
v1:
* Move some GIDs stuff to cmd_device.c with better function's names.
* Cleanup in few places.

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
 kernel-headers/rdma/ib_user_ioctl_cmds.h  |  16 ++
 kernel-headers/rdma/ib_user_ioctl_verbs.h |  14 ++
 kernel-headers/rdma/ib_user_verbs.h       |  11 ++
 kernel-headers/rdma/rdma_user_rxe.h       |   6 +-
 libibverbs/CMakeLists.txt                 |   2 +-
 libibverbs/cmd_device.c                   | 314 ++++++++++++++++++++++++++=
++++
 libibverbs/driver.h                       |  19 +-
 libibverbs/examples/devinfo.c             |  14 +-
 libibverbs/libibverbs.map.in              |   6 +
 libibverbs/man/CMakeLists.txt             |   2 +
 libibverbs/man/ibv_query_gid_ex.3.md      |  93 +++++++++
 libibverbs/man/ibv_query_gid_table.3.md   |  73 +++++++
 libibverbs/verbs.c                        | 105 ++++------
 libibverbs/verbs.h                        |  45 +++++
 providers/mlx5/verbs.c                    |   2 +-
 pyverbs/device.pxd                        |   3 +
 pyverbs/device.pyx                        | 108 +++++++++-
 pyverbs/libibverbs.pxd                    |  15 +-
 pyverbs/libibverbs_enums.pxd              |  11 +-
 tests/base.py                             |   3 +-
 tests/test_device.py                      |  32 +++
 22 files changed, 804 insertions(+), 93 deletions(-)
 create mode 100644 libibverbs/man/ibv_query_gid_ex.3.md
 create mode 100644 libibverbs/man/ibv_query_gid_table.3.md

--=20
1.8.3.1

