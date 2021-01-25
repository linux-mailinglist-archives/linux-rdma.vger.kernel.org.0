Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E18E3048E8
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 20:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbhAZFhT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 00:37:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbhAYMP2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Jan 2021 07:15:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E4FA22E03;
        Mon, 25 Jan 2021 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611576825;
        bh=KR+Gvuyb4FgDBSUYKTomBM6PTJsiLT9lAX/sI8Z9mmo=;
        h=From:To:Cc:Subject:Date:From;
        b=ni6ZTlt6OB+vnB4QbUJgFcmeZnWJhaKPudU2AnhqnZ8IQ/D8YDvBsCIfZVEj1YlWZ
         HrnYVQuHHppuvRHW4VrghVPV+CRP6ldGASta90BPKFwFXCw/6btQ5794cn6v5Gf4OD
         dV8PAgSfvquZJTBrV8ej3TI3JDNSvy9kT9n0tNYT9TAMwsQtZZUYM6Z1tV1M5v22Aw
         eoPtliadCk2Unu3tZkY2Wvz/6R6vjGvAHIqVSC/g5pWmFhMpJB0c4ycLqRqyTr8fa0
         9q2u+4UDnfORhiesPIGU00FU0U1c4fM1ZrWNDxs1NxMI/9XM+YfmQjgw7x6hbGcUGl
         ywXEZ1HfEQ/Ew==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-next v1 0/2] Fixes to v5.11
Date:   Mon, 25 Jan 2021 14:13:37 +0200
Message-Id: <20210125121339.837518-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

v1:
 * Improved grammar and add wake call to ib_umad_kill_port()
v0: https://lore.kernel.org/linux-rdma/20201213132940.345554-1-leon@kernel.org/

Shay Drory (2):
  IB/umad: Return EIO in case of when device disassociated
  IB/umad: Return EPOLLERR in case of when device disassociated

 drivers/infiniband/core/user_mad.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--
2.29.2

