Return-Path: <linux-rdma+bounces-5696-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2339B9026
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 12:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4932282811
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 11:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EB81991AA;
	Fri,  1 Nov 2024 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bot5WbuF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0094016F8E5
	for <linux-rdma@vger.kernel.org>; Fri,  1 Nov 2024 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730460103; cv=none; b=UM22QNUqYF35IhepOn/iU5RXG6ql5tZ9OuvrqvNO3ezvwn7eYwKrvBn5XN6z+Ml1o/MRtbLtPGWUok1f7ZxtURa5jG7pMCcAuWKpdhU+rjtpYMSjRyd/kNWxoPwa2C2rkL6RG6kbQyqGBotQAUSM7vbCCGqmRaSZJOiXPdPh4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730460103; c=relaxed/simple;
	bh=LDhNDfUtdZUkTg5JgMRwM75f0mrq88GAhFzAqSt0AzI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XxTo24LnLRXIeUZDhBB2vdVNW/MnlPoJ3oj8WlXKEgjpscx1wAfQyi6UJPijrHeDyHA1uarqX4dhFu/5rZEVL9HaQpkxXDqphQqQ6P1A661eOMHgoOC6Fx8xt11RzhdXkqz6oTuhwafkq8oNkQoLBUpADj93ChKSg+btMvuxYpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bot5WbuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C40FC4CECD
	for <linux-rdma@vger.kernel.org>; Fri,  1 Nov 2024 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730460102;
	bh=LDhNDfUtdZUkTg5JgMRwM75f0mrq88GAhFzAqSt0AzI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Bot5WbuF3BrxQOjPb9Y1+gezRAdDTZnMf4KZx6nzL9TBwx4+rNzUBcExIz1SgZVat
	 55ae0yGlKwy33YIgsOB/EvYgHXLoCSx95t4NjvIcr3IoV9RA9noby6+o/ez5UHWIKt
	 g8RRNpzg1DfS8ZqMhd/xZSniGAZcUBQ+pdKrvsyojzEH2cLcYCEQuDKW/LSfIe9je/
	 30PpVluX3deF9Lu3KyCTn0kABHPsIwMvL99ZMkfYFMktrGwUklqSH1osUFWb+Xojni
	 Ds4xmGfwPvvq9VytYQaDC4xk0RnXssAJbIROUiRlzwLN5vtpK5xBEmRCfDMTHEOos1
	 IL1GVWGD6lkYA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 629E4C53BC5; Fri,  1 Nov 2024 11:21:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-rdma@vger.kernel.org
Subject: [Bug 219453] BCM57416 error in bnxt_re
Date: Fri, 01 Nov 2024 11:21:42 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219453-11804-CVzbql3gpV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219453-11804@https.bugzilla.kernel.org/>
References: <bug-219453-11804@https.bugzilla.kernel.org/>
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

Pengyu Ma (mapengyu@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |linux-rdma@vger.kernel.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are watching the assignee of the bug.=

