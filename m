Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872AD2F879A
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jan 2021 22:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbhAOVYo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jan 2021 16:24:44 -0500
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:54972 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbhAOVYn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 Jan 2021 16:24:43 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6EAE58378163;
        Fri, 15 Jan 2021 21:24:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3865:3866:3867:3868:3870:3871:3872:5007:7652:8660:8957:10004:10400:10848:11026:11657:11658:11914:12043:12048:12296:12297:12555:12679:12760:13019:13069:13148:13161:13221:13229:13230:13311:13357:13439:14181:14394:14659:14721:21080:21433:21450:21451:21627:21939:21990:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sand31_0516eba27532
X-Filterd-Recvd-Size: 1966
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 Jan 2021 21:24:00 +0000 (UTC)
Message-ID: <f4ce30f297be4678634b5be4917401767ee6ebc5.camel@perches.com>
Subject: [PATCH] RDMA: usnic: Fix misuse of sysfs_emit_at
From:   Joe Perches <joe@perches.com>
To:     Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Greg KH <greg@kroah.com>
Date:   Fri, 15 Jan 2021 13:23:59 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In commit e28bf1f03b01 ("RDMA: Convert various random sprintf sysfs _show
uses to sysfs_emit") I mistakenly used len = sysfs_emit_at to overwrite
the last trailing space of potentially multiple entry output.

The length of the last sysfs_emit_at call is 1 and it should instead be
ignored.  Do so.

Fixes: e28bf1f03b01 ("RDMA: Convert various random sprintf sysfs _show uses to sysfs_emit")

Reported-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
index e59615a4c9d9..fc077855b46c 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
@@ -231,7 +231,7 @@ static ssize_t summary_show(struct usnic_ib_qp_grp *qp_grp, char *buf)
 		}
 	}
 
-	len = sysfs_emit_at(buf, len, "\n");
+	sysfs_emit_at(buf, len, "\n");	/* Overwrite the last trailing space */
 
 	return len;
 }



