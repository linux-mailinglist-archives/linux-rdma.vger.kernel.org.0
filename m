Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626484177E5
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Sep 2021 17:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347105AbhIXPgH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Sep 2021 11:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347129AbhIXPgG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Sep 2021 11:36:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5206A61212
        for <linux-rdma@vger.kernel.org>; Fri, 24 Sep 2021 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632497673;
        bh=yRcPK+u5pzR13GumAbwBpK52ZymMTQq2THizT4024Y4=;
        h=From:To:Subject:Date:From;
        b=UenNqg3k08MPooRFALvRXG+TqKKBhJ4sTEXpgOkNuCOEPunCgUo/N5DYKMtkYI7yu
         +n/jza+yOPqhhAwcGewHFjWM+QCzKmOagqm4NqkzPptp1qn2kOrnGFWtyrEgd4nCP7
         O3X/NykpfAzflXzDVDb88YLFf6x4wOyH2Gi65tiLVV2dp6OPU8Ydaggs9Hn98L3zMQ
         sc73oQv6CL7p84Zgxb7Z7K9Se6ndmHZJKvwuuMeL9uONv6tZXfqJ/UKaQnqxHYl8SD
         YOEG1lwwv1RR8uYw6ZcRMOy7IqQEc837MaYYHocDRN1NPoS/0XjROH5IVnYCB+YmzX
         wltn8wHBSqiPA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 449F460FE3; Fri, 24 Sep 2021 15:34:33 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-rdma@vger.kernel.org
Subject: [Bug 214523] New: RDMA Mellanox RoCE drivers are unresponsive to ARP
 updates during a reconnect
Date:   Fri, 24 Sep 2021 15:34:32 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo
 drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Infiniband/RDMA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kolga@netapp.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-214523-11804@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214523

            Bug ID: 214523
           Summary: RDMA Mellanox RoCE drivers are unresponsive to ARP
                    updates during a reconnect
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.14
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Infiniband/RDMA
          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
          Reporter: kolga@netapp.com
        Regression: No

RoCE RDMA connection uses CMA protocol to establish an RDMA connection. Dur=
ing
the setup the code uses hard coded timeout/retry values. These values are u=
sed
for when Connect Request is not being answered to to re-try the request. Du=
ring
the re-try attempts the ARP updates of the destination server are ignored.
Current timeout values lead to 4+minutes long attempt at connecting to a se=
rver
that no longer owns the IP since the ARP update happens.=20

The ask is to make the timeout/retry values configurable via procfs or sysf=
s.
This will allow for environments that use RoCE to reduce the timeouts to a =
more
reasonable values and be able to react to the ARP updates faster. Other CMA
users (eg IB or others) can continue to use existing values.

The problem exist in all kernel versions but bugzilla is filed for 5.14 ker=
nel.

The use case is (RoCE-based) NFSoRDMA where a server went down and another
server was brought up in its place. RDMA layer introduces 4+ minutes in bei=
ng
able to re-establish an RDMA connection and let IO resume, due to inability=
 to
react to the ARP update.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
