Return-Path: <linux-rdma+bounces-5695-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 403BB9B901A
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 12:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF05C1F21E93
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 11:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DE7322B;
	Fri,  1 Nov 2024 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXhRSjYc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE514A62B
	for <linux-rdma@vger.kernel.org>; Fri,  1 Nov 2024 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459822; cv=none; b=OE6UzKH4s6/ezrxjxj8+nDuc3I9pfgYeQPVVariHRKetqaoniYkUKVl0lqGX0dcFtjGp55fXQ0ub3wlPYhh2OcfJ9vA2ISfkkhozmMD7dLjD0yS6rDxKRRuifS2JbHCIxRTEemboChM656iDekVDzrxghEH3aV6tZM2maL44ICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459822; c=relaxed/simple;
	bh=g/+U5hDYnADQU2rStqCRtTeF70iuUHqXi9A0Ce5nGv4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Mx6X6MR4XX0O8AZbg066Av5Lrw1LMYUGyMNs9UpCBIdCuVMfIj0so34jje7KqObPNg9lbB7Jlp9niKDJwY61+ZY9jVW93TkmV0hm/cpO31hZLsTsXO7aACeFioLrRZn8nwcMFBTIhHpHjtk39Je8gqZ1pKX1GT4HqL26qxsaQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXhRSjYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81D89C4CECF
	for <linux-rdma@vger.kernel.org>; Fri,  1 Nov 2024 11:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730459821;
	bh=g/+U5hDYnADQU2rStqCRtTeF70iuUHqXi9A0Ce5nGv4=;
	h=From:To:Subject:Date:From;
	b=CXhRSjYcd3Vt9iaUxkt2gvh09mWG2tkVDWG7CdZiYY1DhAfxKlDzM/YITrK4ID8+G
	 VvjgIUrQHm4MMpDcif8YgVFafx4fqBNL67UCU97hb6dgxnBbYN212qlt/0FQMpXxRI
	 C3ofDMfrkASRMTJRluY3ufctU3PqqE5gl9cfxzQCrNw6Jn0de4yMfO3gS9wTPLzr9X
	 gGU2EIlPvE0Yf6kRjzK4tjWksDzcAFe6bwlwCmjNAZ8jQ04W83/uolaJ6x5ExMdPAN
	 glZynhOKLJuXAX0nTlZ5Mb2Cxq4XwuINAEx70F2EHOqbWvmr80Pt+DgJA1cNF9zDT1
	 6HrmaCA8DX0WQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6DF25C53BC5; Fri,  1 Nov 2024 11:17:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-rdma@vger.kernel.org
Subject: [Bug 219453] New: BCM57416 error in bnxt_re
Date: Fri, 01 Nov 2024 11:17:01 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo
 drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Infiniband/RDMA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mapengyu@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219453-11804@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219453

            Bug ID: 219453
           Summary: BCM57416 error in bnxt_re
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Infiniband/RDMA
          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
          Reporter: mapengyu@gmail.com
        Regression: No

Created attachment 307113
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307113&action=3Dedit
bnxt_re cmd error

After 6.3 kernel include bnxt_re driver for bnxt_en.
The kernel show CallTrace when bootup:

Tested on 6.12-rc5 today, there is still some error, but CallTrace is gone.
[    5.531490] bnxt_en 0000:82:00.0: QPLIB: cmdq[0x8]=3D0xf status 0x3
[    5.531497] bnxt_en 0000:82:00.0 bnxt_re0: Failed to register fence-MR
[    5.531615] bnxt_en 0000:82:00.0 bnxt_re0: Failed to create Fence-MR
[    5.531694] bnxt_en 0000:82:00.0: QPLIB: cmdq[0xa]=3D0x9 status 0x3
[    5.531702] bnxt_en 0000:82:00.0 bnxt_re0: Failed to create HW CQ
[    5.531706] infiniband bnxt_re0: Couldn't create ib_mad CQ
[    5.531709] infiniband bnxt_re0: Couldn't open port 1
[    5.531872] infiniband bnxt_re0: Device registered with IB successfully

It could be related to firmware.

Log attached.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

