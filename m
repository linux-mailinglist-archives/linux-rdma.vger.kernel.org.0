Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87C02BB305
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 19:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbgKTS2w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 13:28:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbgKTS2v (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Nov 2020 13:28:51 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DAF52224C;
        Fri, 20 Nov 2020 18:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896931;
        bh=wUUrySqSMPWdRnThf5O0yJ5ZiJ507CYSUK16UOmr1kI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPb37dHkVTNro9t/smUmA730yq9m0mc05+W/sAJoUOdLPIJZijtuAm1OAGsW4BDMy
         rz0Us0zB9IkGo9UI53jOb0asqiXM1fu9Rd0mC6arA7QV89+ErEtq++L26gikNuIEuV
         PG5GqlPvmDMHMt1agCEmvZLqSe/SjlFHDhdJjytY=
Date:   Fri, 20 Nov 2020 12:28:56 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 035/141] IB/qedr: Fix fall-through warnings for Clang
Message-ID: <8d7cf00ec3a4b27a895534e02077c2c9ed8a5f8e.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of just letting the code
fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/infiniband/hw/qedr/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 967641662b24..10707b451ab8 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -796,6 +796,7 @@ static void qedr_affiliated_event(void *context, u8 e_code, void *fw_handle)
 		}
 		xa_unlock_irqrestore(&dev->srqs, flags);
 		DP_NOTICE(dev, "SRQ event %d on handle %p\n", e_code, srq);
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

