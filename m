Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04069263480
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 19:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgIIRV0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 9 Sep 2020 13:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730030AbgIIRVY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Sep 2020 13:21:24 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-rdma@vger.kernel.org
Subject: [Bug 209213] New: ib_srp: Already connected to target port with
Date:   Wed, 09 Sep 2020 17:21:22 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo
 drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Infiniband/RDMA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yuri@deepunix.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-209213-11804@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209213

            Bug ID: 209213
           Summary: ib_srp: Already connected to target port with
           Product: Drivers
           Version: 2.5
    Kernel Version: 3.10.0-1127.19.1.el7.x86_64
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Infiniband/RDMA
          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
          Reporter: yuri@deepunix.net
        Regression: No

Hi.

Not sure where to report this, but I'm being annoyed by these messages in my
dmesg/kernel log:

[88003.088015] scsi host1425: ib_srp: Already connected to target port with
id_ext=c0fec0fec0fec0fe;ioc_guid=c0fec0fec0fec0fe;initiator_ext=0000000000000000
[88065.090095] scsi host1426: ib_srp: Already connected to target port with
id_ext=c0fec0fec0fec0fe;ioc_guid=c0fec0fec0fec0fe;initiator_ext=0000000000000000
[88127.148561] scsi host1427: ib_srp: Already connected to target port with
id_ext=c0fec0fec0fec0fe;ioc_guid=c0fec0fec0fec0fe;initiator_ext=0000000000000000
and so on.

No idea why it's trying to connect over to c0fe again and again. I'm running
EL7, but I guess SRP development is so old and staleble that it doesn't matter
at this point. As you've noticed, I had changed the `srpt_service_guid` on
target to be more fun.

This is what SRP daemon args look like:
/usr/sbin/srp_daemon --systemd -e -c -j mlx4_0:1 -R 60

# ibsrpdm -v
Using device mlx4_0 port 1
Device mlx4_0 was found
CQ was created with 10 CQEs
CQ was created with 1 CQEs
MR was created with addr=0xa7db50, lkey=0x18010300,
QP was created, QP number=0x22e
QPs were modified to RTS
Advanced SM, performing a capability query
discover Targets for P_key ffff (index 0)
enter do_port
IO Unit Info:
    port LID:        0005
    port GID:        fe800000000000000002c90300fb9c31
    change ID:       0001
    max controllers: 0x10

    controller[  1]
        GUID:      c0fec0fec0fec0fe
        vendor ID: 000002
        device ID: 001003
        IO class : 0100
        ID:        Linux SRP target
        service entries: 1
            service[  0]: c0fec0fec0fec0fe / SRP.T10:c0fec0fec0fec0fe
Found an SRP target with id_ext c0fec0fec0fec0fe - check if it is already
connected

discover Targets for P_key ffff (index 0)
enter do_port
IO Unit Info:
    port LID:        0003
    port GID:        fe8000000000000024be05ffffb2a031
    change ID:       0001
    max controllers: 0x10

    controller[  1]
        GUID:      c0fec0fec0fec0fe
        vendor ID: 000002
        device ID: 001003
        IO class : 0100
        ID:        Linux SRP target
        service entries: 1
            service[  0]: c0fec0fec0fec0fe / SRP.T10:c0fec0fec0fec0fe
Found an SRP target with id_ext c0fec0fec0fec0fe - check if it is already
connected

discover Targets for P_key ffff (index 0)
enter do_port
IO Unit Info:
    port LID:        0013
    port GID:        fe80000000000000e0071bffff81f7c1
    change ID:       0001
    max controllers: 0x10

    controller[  1]
        GUID:      e0071bffff81f7c0
        vendor ID: 000002
        device ID: 001007
        IO class : 0100
        ID:        Linux SRP target
        service entries: 1
            service[  0]: e0071bffff81f7c0 / SRP.T10:e0071bffff81f7c0
Found an SRP target with id_ext e0071bffff81f7c0 - check if it is already
connected

--
Thanks.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
