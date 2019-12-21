Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEC212865E
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2019 02:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfLUBdD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 20:33:03 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1856 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfLUBdD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 20:33:03 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dfd76430000>; Fri, 20 Dec 2019 17:32:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 20 Dec 2019 17:33:01 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 20 Dec 2019 17:33:01 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 21 Dec
 2019 01:33:01 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 21 Dec
 2019 01:32:57 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 21 Dec 2019 01:32:57 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dfd76490002>; Fri, 20 Dec 2019 17:32:57 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Noa Osherovich <noaos@mellanox.com>,
        <linux-rdma@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/1] pyverbs: fix speed_to_str(), to handle disabled links
Date:   Fri, 20 Dec 2019 17:32:55 -0800
Message-ID: <20191221013256.100409-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576891971; bh=7+j5Ua7VdVzF3bOTWeQmd5drlDWx7kbLh3NnwkZYYc4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=NrVT3saZX67xdMBtrONF1pm6OBVV4NAHG328fPN4RqnqYPKzDp9n/eTOcZOQ9C1Ua
         V0lENL/h1ryroTY2f0hTbC46NIGoHz/Tm/EDxSaCYq6bY4zDIeC4/KHv/VmlaXPKtQ
         7/kvy+UBbrmySi2YxQipr0yklfvZmw906GOzTXsip2vMvAH3rooLU6Dj3IKTEX8b24
         7mk9xL2YSRy9azrJqpTriFUI1U5zfA3esw/SYd9LIfu21O+kR2PSDGfvKtZQJCTAwo
         HpL0ylyWnQlESYYS7owsCk2lyWHhtVCxD5wbMuOkXvzr/72JZtRtdLHKgkwRq98trj
         MDSFaE6ZASdRA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

This came up when I was running rdma-core tests on a two-machine setup,
where each card had two ports, but there was only one cable. So only
one port on each end was connected.

The main thing I expect to be up for debate is, what string to return
for speed, when a port is disabled or down? I initially thought about
returning  '(Disabled/down)', but it seems more accurate to just report
'0.0 Gbps', so that's what I settled on.

Background: here's what I wrote when discussing this over on linux-mm
with Leon [1]:

It looks like this test suite assumes that every link is connected!
(Probably in most test systems, they are.) But in my setup, the ConnectX
cards each have two slots, and I only have (and only need) one cable. So
one link is up, and the other is disabled.

This leads to the other problem, which is that if a link is disabled,
the test suite finds a "0" token for attr.active_speed. That token is
not in the approved list, and so d.speed_to_str() asserts.

With some diagnostics added, I can see it checking each link: one
passes, and the other asserts:

diff --git a/tests/test_device.py b/tests/test_device.py
index 524e0e89..7b33d7db 100644
--- a/tests/test_device.py
+++ b/tests/test_device.py
@@ -110,6 +110,12 @@ class DeviceTest(unittest.TestCase):
         assert 'Invalid' not in d.translate_mtu(attr.max_mtu)
         assert 'Invalid' not in d.translate_mtu(attr.active_mtu)
         assert 'Invalid' not in d.width_to_str(attr.active_width)
+        print("")
+        print('Diagnostics =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D')
+        print('phys_state:    ', d.phys_state_to_str(attr.phys_state))
+        print('active_width): ', d.width_to_str(attr.active_width))
+        print('active_speed:  ',   d.speed_to_str(attr.active_speed))
+        print('END of Diagnostics =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D')
         assert 'Invalid' not in d.speed_to_str(attr.active_speed)
         assert 'Invalid' not in d.translate_link_layer(attr.link_layer)
         assert attr.max_msg_sz > 0x1000

         assert attr.max_msg_sz > 0x1000

...and the test run from that is:

# ./build/bin/run_tests.py --verbose tests.test_device.DeviceTest
test_dev_list (tests.test_device.DeviceTest) ... ok
test_open_dev (tests.test_device.DeviceTest) ... ok
test_query_device (tests.test_device.DeviceTest) ... ok
test_query_device_ex (tests.test_device.DeviceTest) ... ok
test_query_gid (tests.test_device.DeviceTest) ... ok
test_query_port (tests.test_device.DeviceTest) ...
Diagnostics =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
phys_state:     Link up (5)
active_width):  4X (2)
active_speed:   25.0 Gbps (32)
END of Diagnostics =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Diagnostics =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
phys_state:     Disabled (3)
active_width):  4X (2)
active_speed:   Invalid speed
END of Diagnostics =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
FAIL
test_query_port_bad_flow (tests.test_device.DeviceTest) ... ok

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
FAIL: test_query_port (tests.test_device.DeviceTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/kernel_work/rdma-core/tests/test_device.py", line 135, in test_que=
ry_port
    self.verify_port_attr(port_attr)
  File "/kernel_work/rdma-core/tests/test_device.py", line 119, in verify_p=
ort_attr
    assert 'Invalid' not in d.speed_to_str(attr.active_speed)
AssertionError

----------------------------------------------------------------------
Ran 7 tests in 0.055s

FAILED (failures=3D1)

[1] https://lore.kernel.org/r/b70ac328-2dc0-efe3-05c2-3e040b662256@nvidia.c=
om


John Hubbard (1):
  pyverbs: fix speed_to_str(), to handle disabled links

 pyverbs/device.pyx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
2.24.1

