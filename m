Return-Path: <linux-rdma+bounces-629-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A59882D15F
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jan 2024 17:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3516C1F215F4
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jan 2024 16:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ACC290F;
	Sun, 14 Jan 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8HIQtm0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DA3C29
	for <linux-rdma@vger.kernel.org>; Sun, 14 Jan 2024 16:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE916C433F1
	for <linux-rdma@vger.kernel.org>; Sun, 14 Jan 2024 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705248623;
	bh=0cKO/gR1spLD1ykgwKmF4o+Gvj7hG3NZkasE/E1oBw4=;
	h=From:To:Subject:Date:From;
	b=Y8HIQtm0nQWSYhTKSrnUPVKfL0s51NwIhnsZVqAoP3uaisf0Es+gO1jQC2MzYH0oJ
	 OJd5SyCgxoqBKEMvPaOP6xlsSuTk8lQAjA8bKe1wvhmkz4BAusww+/XmLC8ufJvZBn
	 lsjRSOatTDAyZFumvpqOa472lD8RnZ1m+tSYhgsF2QKCXrvelB6PLWvtWnW1GPTL2P
	 YZUB9vYDg9usN1zfEoVRQ3gWBDV9CIA6oHiXnkNwxr3+lQ/VWjVKbPwwJc39gzfyir
	 gGIIN03zblUJLqLndFGL4a6aseO4U040Fq2GOHK0ZNmahZ6zMzXg1mcZxcmIresRLi
	 6lmVEqtDjF1gA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A7C0AC53BC6; Sun, 14 Jan 2024 16:10:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-rdma@vger.kernel.org
Subject: [Bug 218375] New: warning compiling siw_tx_hdt:  the frame size of
 1040 bytes is larger than 1024 bytes
Date: Sun, 14 Jan 2024 16:10:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo
 drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Infiniband/RDMA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218375-11804@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218375

            Bug ID: 218375
           Summary: warning compiling siw_tx_hdt:  the frame size of 1040
                    bytes is larger than 1024 bytes
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Infiniband/RDMA
          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
          Reporter: ionut_n2001@yahoo.com
        Regression: No

Hi Kernel Team,

I notice today this:
drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_tx_hdt':=20
drivers/infiniband/sw/siw/siw_qp_tx.c:677:1: warning: the frame size of 1040
bytes is larger than 1024 bytes [-Wframe-larger-than=3D]=20
 677 | }=20
     |=20

I use latest kernel 6.7 and this is happened when compiling kernel with GCC=
 -
gcc (Debian 13.2.0-9) 13.2.0.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

