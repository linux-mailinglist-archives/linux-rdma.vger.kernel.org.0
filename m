Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08276F860B
	for <lists+linux-rdma@lfdr.de>; Fri,  5 May 2023 17:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjEEPm7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 May 2023 11:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjEEPm6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 May 2023 11:42:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D440516081
        for <linux-rdma@vger.kernel.org>; Fri,  5 May 2023 08:42:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC9A60AD1
        for <linux-rdma@vger.kernel.org>; Fri,  5 May 2023 15:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3E5C433D2;
        Fri,  5 May 2023 15:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683301375;
        bh=ztAAxEXfo/rYglxTcfa78z1zwxaUdLDHkCAM9kwLHJQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cJWlz6HXtyTppL41PMB8QUzObB0HOfM7vtTwotWCxF3JpS0BpC2oczT8lOgozXHxp
         nx6ynh0tjYsHjEKnNjheNxoeqvZ+u/wM+O30k3VDQuQnXoritq5O21cbhPYSccgcki
         byvG4osUZNpwMFZgfq1ReLSgos3zKYbmXVfXe2GjeZM8SqkxlgtzLAAD8wfPEnatU+
         l27hpxvsluUQsQcBvRa+FsvrTWkiRKdB+ourrPBdcvfI8MVxf3lB6NrHf42k1+Xjbp
         tnvedYMIOsvUCebn7SELbwA4kyoCO194LTvaTwZlLF4LoPfiY2IxEZN4Qz73EYDNLx
         ONCeVTY33CKGg==
Subject: [PATCH RFC 2/3] net/lo: Ensure lo devices have a MAC address
From:   Chuck Lever <cel@kernel.org>
To:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     BMT@zurich.ibm.com, tom@talpey.com
Date:   Fri, 05 May 2023 11:42:44 -0400
Message-ID: <168330135435.5953.3471584034284499194.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168330051600.5953.11366152375575299483.stgit@oracle-102.nfsv4bat.org>
References: <168330051600.5953.11366152375575299483.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

A non-zero MAC address enables a network device to be assigned as
the underlying device for a virtual RDMA device. Without a non-
zero MAC address, cma_acquire_dev_by_src_ip() is unable to find the
underlying egress device that corresponds to a source IP address,
and rdma_resolve_address() fails.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/net/loopback.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index f6d53e63ef4e..1ce4f19d8065 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -192,6 +192,8 @@ static void gen_lo_setup(struct net_device *dev,
 	dev->needs_free_netdev	= true;
 	dev->priv_destructor	= dev_destructor;
 
+	eth_hw_addr_random(dev);
+
 	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
 }
 


