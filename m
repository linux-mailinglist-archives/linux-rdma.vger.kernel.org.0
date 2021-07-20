Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6D33CF609
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhGTHiG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:38:06 -0400
Received: from mail-mw2nam10on2083.outbound.protection.outlook.com ([40.107.94.83]:38400
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234547AbhGTHiB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:38:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyUHSFTSeIzDxGFFosZOodSPz3MsTc+6EdBClZZmK5i3ucuBfj1Hx9lwfpQwh4aDo/NlJmZuu7n9dK81ONzMFEOi7SJeqmo66uyKVB7JRHdD2tqOK9FEyVwivLEQZitSCoXHTzJXvjC72oB1UaWGNxUpg00DDda5pzqefCfczUW3vy3fuR8xs70yELOLZZzTmqWWpnUp9R5cUS7FEruMNS/LtDfhIivneT6B7em4qlKtGZGSqDt5NyNeE1udrnwfImTFyPg1JgivkoaKDf4QGBIIT4rrNVXOUtqV3/n93ttBeO8VAdiVxsSsv1+E/oWpDXH3mB0mgOxf/cbPsTLntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnABq8MW7kXXWm0J/McchiTJ2Bmfiuhy5yCdAl5fIUM=;
 b=ZdfYrHHO1GOlobwFJ7AN+0tzkYrhwBD+Pc6re1AZ5GTUXhb4jruovrkiVKzzWJFf6vHpjYFSiKUWqWk9a1ZB2TSJwSvDEraddtg7zMNPBIseQEh05G59tdy4laR0HanGvtAtXU3DrFOTZ7epQX2MW7nIpdxD7iSEFI2e3YzpPJfZDSn5Jxf/Qm1pYvI199BCDuik0cP5jAavN4EpDOhZXTPek8YvM6yCP6mJhNPCbjKbHnDU4lGOh5J5qGDuOFTjKdih4Bji8C1iFnav16WPf5LhTMOyQdN1CBh3YfhjlHVOHzYLUD6ve3N1Al3/r5X+PffE7+h0/OYPwQPsLrB7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnABq8MW7kXXWm0J/McchiTJ2Bmfiuhy5yCdAl5fIUM=;
 b=HBMJR/xmt4m8iXleKkGyJq33lp2O47OZ0D08IPDCg6azymoS6XO9Ey3hHwG4kKGDDkqoeGklGGDxDuYz6VBtFx3cNQ64df0r4pGYQUiDMVgXDpSm2HZwpH8OW7BzIzAgzqUM0hT1MJT2h8pTYZ52WXExllRZL34Hkj+rlalLTvIXo1bAe4O5vtJzME3Ch/ptvJNjnkOGSZ1KWznc7wd4ocjKggyXcp/ygUkAdiT4f+MkRxV8N0snhV0haEI+gO3G7oopXkYn9ISDbLuJyiktAMygKtJXCH/Mvb5HeyfqHXiz/t09k5xYaFIDw43abbXchGeDYjIcSox1Y9h4auPs8Q==
Received: from BN6PR22CA0054.namprd22.prod.outlook.com (2603:10b6:404:ca::16)
 by SN6PR12MB2749.namprd12.prod.outlook.com (2603:10b6:805:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 08:18:38 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::a7) by BN6PR22CA0054.outlook.office365.com
 (2603:10b6:404:ca::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 08:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:18:38 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 01:18:37 -0700
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:18:35 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>,
        Ido Kalir <idok@nvidia.com>
Subject: [PATCH rdma-core 27/27] tests: Add a test for mlx5 over VFIO
Date:   Tue, 20 Jul 2021 11:16:47 +0300
Message-ID: <20210720081647.1980-28-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9743609e-56e3-4378-8b0f-08d94b56fa56
X-MS-TrafficTypeDiagnostic: SN6PR12MB2749:
X-Microsoft-Antispam-PRVS: <SN6PR12MB274992628DF0CEA04A23CF7FC3E29@SN6PR12MB2749.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ok6hSUM0MKTlF97LU3ZX7N7CX4BnkXLboE6JQniy60uDDEUjjLxI05xkuou0ogLW7I8GQyLNKUfauyYbX/A4OwuNfefc7xX/H611DpJI/eVtVyVJBgDJAHopktNh7vm6NUEH7FVs7VcnS8+r3GkCgxtWiwp4p92ukeN1XyVHh5XNjK9lFMzdNOM94BPnaGEDZu9QZfsfylqwvZsw5TrdzcahFZM2W+fJ+JMzwoyw/sngLARrnl8oGj7MGHC/x1mnsPxkfSazOjk3hwOE4V+1Wa0Yts/JwDWRp2FWndm6epmdnYz/pXbNPR4WuNWlSSjW+wBSyYZbBa1cWGd9Rg10gnAvrY3qNne/9PrfVVPzijqIbIkYiaUWBXU3BeiQQRVyb3g/QHLzy62O0wrHSuLDLBl0rpDPOHjvEZQGLqNC2CnMWH3rsd5T3ZRCt2IcT7CpcpbWF8dqp+NBDLUi0qcFZSBkeu+qICKQo/6T4VA//QbJ2nBw4Ld/gznS8/Url8ymu+EZ+Y8a3e/s3TweID/K6+VGGjxa5kxAfmk/GXRJrTTbT6jTtmEozXvzeisDEhdnxSZrnCG8coy9yKwNb1pCSYrxkpLMJNWWXkAUoT2ev3fgL0limAPS8TB5zYUTC2CDfdZFl4JYozuhDNYf30R7lwBQba3pr0+oUIcWxGtgfrz31zQkWGcKhSvyF0lPfbCwEDoXd4wEIyIJvXar+rcZYw==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(46966006)(4326008)(82740400003)(7636003)(26005)(186003)(47076005)(1076003)(6666004)(316002)(426003)(8936002)(86362001)(54906003)(19627235002)(356005)(336012)(6916009)(2906002)(2616005)(70206006)(70586007)(82310400003)(8676002)(5660300002)(478600001)(7696005)(36756003)(107886003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:18:38.7233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9743609e-56e3-4378-8b0f-08d94b56fa56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2749
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@nvidia.com>

Add a test that opens an mlx5 vfio context, creates two DevX QPs on
it, and modifies them to RTS state. Then performs traffic with SEND_IMM.
An additional cmd line argument was added for the tests, to allow users
to pass a PCI device instead of an RDMA device for this test.

Reviewed-by: Ido Kalir <idok@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 tests/CMakeLists.txt    |   1 +
 tests/args_parser.py    |   5 +++
 tests/test_mlx5_vfio.py | 104 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 tests/test_mlx5_vfio.py

diff --git a/tests/CMakeLists.txt b/tests/CMakeLists.txt
index 7b079d8..cabeba0 100644
--- a/tests/CMakeLists.txt
+++ b/tests/CMakeLists.txt
@@ -36,6 +36,7 @@ rdma_python_test(tests
   test_mlx5_uar.py
   test_mlx5_udp_sport.py
   test_mlx5_var.py
+  test_mlx5_vfio.py
   test_mr.py
   test_odp.py
   test_pd.py
diff --git a/tests/args_parser.py b/tests/args_parser.py
index 5bc53b0..4312121 100644
--- a/tests/args_parser.py
+++ b/tests/args_parser.py
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2020 Kamal Heib <kamalheib1@gmail.com>, All rights reserved.  See COPYING file
+# Copyright (c) 2021 Nvidia, Inc. All rights reserved. See COPYING file
 
 import argparse
 import sys
@@ -16,6 +17,10 @@ class ArgsParser(object):
         parser = argparse.ArgumentParser()
         parser.add_argument('--dev',
                             help='RDMA device to run the tests on')
+        parser.add_argument('--pci-dev',
+                            help='PCI device to run the tests on, which is '
+                                 'needed by some tests where the RDMA device is '
+                                 'not available (e.g. VFIO)')
         parser.add_argument('--port',
                             help='Use port <port> of RDMA device', type=int,
                             default=1)
diff --git a/tests/test_mlx5_vfio.py b/tests/test_mlx5_vfio.py
new file mode 100644
index 0000000..06da8dd
--- /dev/null
+++ b/tests/test_mlx5_vfio.py
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2021 Nvidia, Inc. All rights reserved. See COPYING file
+"""
+Test module for pyverbs' mlx5_vfio module.
+"""
+
+from threading import Thread
+import unittest
+import select
+import errno
+
+from pyverbs.providers.mlx5.mlx5_vfio import Mlx5VfioAttr, Mlx5VfioContext
+from tests.mlx5_base import Mlx5DevxRcResources, Mlx5DevxTrafficBase
+from pyverbs.pyverbs_error import PyverbsRDMAError
+
+
+class Mlx5VfioResources(Mlx5DevxRcResources):
+    def __init__(self, ib_port, pci_name, gid_index=None, ctx=None):
+        self.pci_name = pci_name
+        self.ctx = ctx
+        super().__init__(None, ib_port, gid_index)
+
+    def create_context(self):
+        """
+        Opens an mlx5 VFIO context.
+        Since only one context is allowed to be opened on a VFIO, the user must
+        pass that context for the remaining resources, which in that case, the
+        same context would be used.
+        :return: None
+        """
+        if self.ctx:
+            return
+        try:
+            vfio_attr = Mlx5VfioAttr(pci_name=self.pci_name)
+            vfio_attr.pci_name = self.pci_name
+            self.ctx = Mlx5VfioContext(attr=vfio_attr)
+        except PyverbsRDMAError as ex:
+            if ex.error_code == errno.EOPNOTSUPP:
+                raise unittest.SkipTest(f'Mlx5 VFIO is not supported ({ex})')
+            raise ex
+
+    def query_gid(self):
+        """
+        Currently Mlx5VfioResources does not support Eth port type.
+        Query GID would just be skipped.
+        """
+        pass
+
+
+class Mlx5VfioTrafficTest(Mlx5DevxTrafficBase):
+    """
+    Test various functionality of an mlx5-vfio device.
+    """
+    def setUp(self):
+        """
+        Verifies that the user has passed a PCI device name to work with.
+        """
+        self.pci_dev = self.config['pci_dev']
+        if not self.pci_dev:
+            raise unittest.SkipTest('PCI device must be passed by the user')
+
+    def create_players(self):
+        self.server = Mlx5VfioResources(ib_port=self.ib_port, pci_name=self.pci_dev)
+        self.client = Mlx5VfioResources(ib_port=self.ib_port, pci_name=self.pci_dev,
+                                        ctx=self.server.ctx)
+
+    def vfio_processs_events(self):
+        """
+        Processes mlx5 vfio device events.
+        This method should run from application thread to maintain the events.
+        """
+        # Server and client use the same context
+        events_fd = self.server.ctx.get_events_fd()
+        with select.epoll() as epoll_events:
+            epoll_events.register(events_fd, select.EPOLLIN)
+            while self.proc_events:
+                for fd, event in epoll_events.poll(timeout=0.1):
+                    if fd == events_fd:
+                        if not (event & select.EPOLLIN):
+                            self.event_ex.append(PyverbsRDMAError(f'Unexpected vfio event: {event}'))
+                        self.server.ctx.process_events()
+
+    def test_mlx5vfio_rc_qp_send_imm_traffic(self):
+        """
+        Opens one mlx5 vfio context, creates two DevX RC QPs on it, and modifies
+        them to RTS state.
+        Then does SEND_IMM traffic.
+        """
+        self.create_players()
+        if self.server.is_eth():
+            raise unittest.SkipTest(f'{self.__class__.__name__} is currently supported over IB only')
+        self.event_ex = []
+        self.proc_events = True
+        proc_events = Thread(target=self.vfio_processs_events)
+        proc_events.start()
+        # Move the DevX QPs ro RTS state
+        self.pre_run()
+        # Send traffic
+        self.send_imm_traffic()
+        # Stop listening to events
+        self.proc_events = False
+        proc_events.join()
+        if self.event_ex:
+            raise PyverbsRDMAError(f'Received unexpected vfio events: {self.event_ex}')
-- 
1.8.3.1

