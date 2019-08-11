Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4651089296
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2019 18:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfHKQ3b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Aug 2019 12:29:31 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41691 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725837AbfHKQ33 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Aug 2019 12:29:29 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from haimbo@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 Aug 2019 19:29:27 +0300
Received: from r-ufm115.mtr.labs.mlnx (r-ufm115.mtr.labs.mlnx [10.209.36.210])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7BGTRR8008095;
        Sun, 11 Aug 2019 19:29:27 +0300
Received: from r-ufm115.mtr.labs.mlnx (localhost [127.0.0.1])
        by r-ufm115.mtr.labs.mlnx (8.14.7/8.14.7) with ESMTP id x7BGTR5v020236;
        Sun, 11 Aug 2019 16:29:27 GMT
Received: (from haimbo@localhost)
        by r-ufm115.mtr.labs.mlnx (8.14.7/8.14.7/Submit) id x7BGTQHj020235;
        Sun, 11 Aug 2019 16:29:26 GMT
From:   Haim Boozaglo <haimbo@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     Haim Boozaglo <haimbo@mellanox.com>
Subject: [PATCH rdma-core 0/3] get more than 32 available InfiniBand device names
Date:   Sun, 11 Aug 2019 16:29:19 +0000
Message-Id: <1565540962-20188-1-git-send-email-haimbo@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

This series from Vladimir Koushnir adds the ability to get
list of InfiniBand device names greater than 32.

Thanks

Vladimir Koushnir (3):
  libibumad: Support arbitrary number of IB devices
  libibumad: Redesign resolve_ca_name to support arbitrary number of IB
    devices
  ibdiags: Support arbitrary number of IB devices in ibstat

 debian/libibumad3.symbols             |   2 +
 infiniband-diags/ibstat.c             |  47 +++++++-----
 libibumad/CMakeLists.txt              |   2 +-
 libibumad/libibumad.map               |   6 ++
 libibumad/man/umad_free_ca_namelist.3 |  28 +++++++
 libibumad/man/umad_get_ca_namelist.3  |  34 ++++++++
 libibumad/umad.c                      | 141 +++++++++++++++++++++++++---------
 libibumad/umad.h                      |   2 +
 8 files changed, 204 insertions(+), 58 deletions(-)
 create mode 100644 libibumad/man/umad_free_ca_namelist.3
 create mode 100644 libibumad/man/umad_get_ca_namelist.3

-- 
1.8.3.1

