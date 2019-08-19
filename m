Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4340C91D8C
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 09:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbfHSHHw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 19 Aug 2019 03:07:52 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:50084 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbfHSHHw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 03:07:52 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 608A0284DB
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 07:07:51 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 550AF285A7; Mon, 19 Aug 2019 07:07:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=ham version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-rdma@vger.kernel.org
Subject: [Bug 204617] drivers/infiniband/sw/siw not 32-bit clean - cast from
 pointer to integer warnings on i686
Date:   Mon, 19 Aug 2019 07:07:49 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo
 drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Infiniband/RDMA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hramrach@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-204617-11804-wzIeCzHQzq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204617-11804@https.bugzilla.kernel.org/>
References: <bug-204617-11804@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204617

Michal Suchanek (hramrach@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |linux-rdma@vger.kernel.org

-- 
You are receiving this mail because:
You are on the CC list for the bug.
You are watching the assignee of the bug.
