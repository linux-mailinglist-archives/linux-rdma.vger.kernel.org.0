Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CC1286CE8
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 04:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgJHCq7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 22:46:59 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:60818 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726400AbgJHCq7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 22:46:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 6B73618029128;
        Thu,  8 Oct 2020 02:46:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1538:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3876:3877:4321:4699:5007:6114:6642:7809:10004:10400:10848:11232:11658:11914:12043:12297:12555:12760:13069:13311:13357:13439:14181:14659:14721:14777:21060:21080:21433:21451:21627:21819:30022:30064,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wax25_0e0e3ab271d4
X-Filterd-Recvd-Size: 1308
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Oct 2020 02:46:56 +0000 (UTC)
Message-ID: <f7726a1873f14972f137f64a4d6cd35e530c6c95.camel@perches.com>
Subject: [likely PATCH] MAINTAINERS: CISCO VIC LOW LATENCY NIC DRIVER
From:   Joe Perches <joe@perches.com>
To:     Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 07 Oct 2020 19:46:54 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Parvi Kaustubhi's email bounces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ecb727f0a8f..3647500be78f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4275,7 +4275,6 @@ F:	drivers/net/ethernet/cisco/enic/
 CISCO VIC LOW LATENCY NIC DRIVER
 M:	Christian Benvenuti <benve@cisco.com>
 M:	Nelson Escobar <neescoba@cisco.com>
-M:	Parvi Kaustubhi <pkaustub@cisco.com>
 S:	Supported
 F:	drivers/infiniband/hw/usnic/
 

