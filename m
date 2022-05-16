Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6798527C20
	for <lists+linux-rdma@lfdr.de>; Mon, 16 May 2022 04:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbiEPCqM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 May 2022 22:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiEPCqE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 May 2022 22:46:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5D713E8B
        for <linux-rdma@vger.kernel.org>; Sun, 15 May 2022 19:46:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5916AB80E3D
        for <linux-rdma@vger.kernel.org>; Mon, 16 May 2022 02:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D5F4C34115
        for <linux-rdma@vger.kernel.org>; Mon, 16 May 2022 02:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652669159;
        bh=zQF2alVn/QqHqwQVN4Q9ezB7chvYsX6x3K79Tkd4OPg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YZAZUC8oWEvICXR/zjpOSgAdAsi85RagVKyAueowEypNTqdUxiHXVWu554oju+I48
         Fo7pHhcqY53sAF6cEz8rq7X24NPyLol/7N/fAkEp75v1xDpCAXMwh+0APLM3rqq3oU
         aSHn+tcBeGl7IpgPDrjdDc9HuOtxyB2LPuL1e7fP5EyjiofSSX6hgBcETVz7dPl3n2
         eGHVlo0/GATeT9dbjrIXPBGfI9IMYYaMRcu3W2x6FMOHodXzh2m6hZH+H0hwfundY6
         l1seLjkiROYXLiFcPgKrFaDpDDSVcjIICTx94XwOyHYwHnDdb/xZ0ytDoxka9dG2L7
         c6fj78qXoZrUw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 01754CC13AF; Mon, 16 May 2022 02:45:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-rdma@vger.kernel.org
Subject: [Bug 215982] ifdown vlan port which have nvmf target listener on it,
 kernel print "unregister_netdevice: waiting for enp5s0f0.55 to become free.
 Usage count = 1" repeatedly
Date:   Mon, 16 May 2022 02:45:58 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo
 drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Infiniband/RDMA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yuanyangliu258@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215982-11804-AQ3Geoued7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215982-11804@https.bugzilla.kernel.org/>
References: <bug-215982-11804@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215982

3null (yuanyangliu258@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |linux-rdma@vger.kernel.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are watching the assignee of the bug.=
