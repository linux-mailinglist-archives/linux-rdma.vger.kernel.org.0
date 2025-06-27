Return-Path: <linux-rdma+bounces-11717-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F31AEB37E
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 11:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB16F17817F
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 09:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2543A295DB4;
	Fri, 27 Jun 2025 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h69V2CTb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DB8295534
	for <linux-rdma@vger.kernel.org>; Fri, 27 Jun 2025 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751018291; cv=none; b=UHQLxXmOFM2a/isGvGa4rZx3fBncQjwmuhAMc2y4r3e9fF9GqkONKNL9WRncee3wzacTnZjp7oI+Y4s740qKEOPlSvARmeCQGu1Yv77zMbWTOKsvDk+rPIwMl5JyUQVglJH6YIxA2EIL+hOleZDUVPjyo/4bh0LX/lr73wNsGMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751018291; c=relaxed/simple;
	bh=3vlgiX38lKQ/gUQOExBi5RO09HaLS3LRTfZmoF6qjK4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PbYlTwltA8h+HgRotL6tbQrREpPehpx+MEAljddBf7dtJotI9caWQIkFX+GQWU1VXZoJ+C/Q5wtAIdz1+DqXy71mC1XOwSWex532hWkqUWndtwhzWL9DNFFimMKXe0p7eILDzIbutcijO6NjSOtr9iVwcnYxNM656/aK8jLndh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h69V2CTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EC86C4CEED
	for <linux-rdma@vger.kernel.org>; Fri, 27 Jun 2025 09:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751018291;
	bh=3vlgiX38lKQ/gUQOExBi5RO09HaLS3LRTfZmoF6qjK4=;
	h=From:To:Subject:Date:From;
	b=h69V2CTbnTPI4EMoid+YyZPEDQsrvsYlvPQtTLnuFylLCmHMGpmwMTYsH2jjAffPd
	 nyPob5Sx+uOw47yMnQbmiimC6/01cf7qTXUarl0ge2iIh1W/QwbkIExarBB1qQIBMp
	 Zl4GFZ6MFGY75gipf/k+hdIHPpVTxQKo5qjV2gFGgitu6ZynI15jEVpChSFlLAE9mg
	 UfhGeDQpDNYZ15gU8duaRfBQeekQUGSQjkp3veg62+Dt+Y9IiOxFF9tnGeNlTO23Dz
	 P0JDl+fAJ/wHk4xSfa0RVX267pDAuluhaqjgtpToNp5gDbKNoofUtNvbtbXHxjJicC
	 UquMrOmKuyRvA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5140DC41612; Fri, 27 Jun 2025 09:58:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-rdma@vger.kernel.org
Subject: [Bug 220280] New: mlx5 VF node_guid stays 0 in host
Date: Fri, 27 Jun 2025 09:58:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo
 drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Infiniband/RDMA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: axel@gembe.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220280-11804@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220280

            Bug ID: 220280
           Summary: mlx5 VF node_guid stays 0 in host
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Infiniband/RDMA
          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
          Reporter: axel@gembe.net
        Regression: No

I have a mlx5 setup with switchdev and SR-IOV and I want to make RDMA work
using a VF in the host. VFs attached to a VM work fine, but using the same =
VF
in the host works for networking but not for RDMA. It seems that this does =
not
work because the node GUID as shown in `ibv_devices` stays zero. I found a
workaround for this using the following:


> devlink port # find your VF in the list here and copy the id
> devlink port function set pci/0000:10:00.1/65537 hw_addr 72:e4:64:e0:87:a0
> rmmod mlx5_ib
> modprobe mlx5_ib
> ibv_devices # should show a non-zero node_guid for the VF now

https://forums.developer.nvidia.com/t/how-to-use-vf-on-host/277750/4?u=3Dde=
rago

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

