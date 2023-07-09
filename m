Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A65B74C6E9
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jul 2023 20:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjGISBb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Jul 2023 14:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGISBa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Jul 2023 14:01:30 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC51C107
        for <linux-rdma@vger.kernel.org>; Sun,  9 Jul 2023 11:01:28 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 4FB6E3F06C
        for <linux-rdma@vger.kernel.org>; Sun,  9 Jul 2023 18:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1688925687;
        bh=0ZQJBCkyYygCasU6AcECDq7M1LZOSB2Fy1A5mt8h2qQ=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=MFu9m0V2Xq58bGXkNTpC8sfgsW8klm2FEgJHoE4BFKB+5ppt99FjeCgKAD5VWiSBY
         wSZ8eFYfZO0bp1bo6fh7/cpYlQqaaXBANzyOqgLeZ7bVcZ18Ez2xMpcIRhdwqZnBh7
         QLzK+ezY5rZOQ827Kh9bMe80JTv37XJZnTyCjaX/4+15y1NOsV6We6gegoa7VhHw4v
         L1B9JhWytxICs/5MgbQnl6TE47JqnhDPP+KgakSnnwFgZLS+DQOcQsqgn/Nxxg5b6O
         xEnfuxOzoN7el4m69QG6mP6Zf7bqw20jVPgsWepNedd+lUppq+TN3Z8UorpSV4jVsP
         pAv+dpNHYSUxg==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id D9B14BDE6A
        for <linux-rdma@vger.kernel.org>; Sun,  9 Jul 2023 18:01:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Requester @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: recipe-build-status
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: MANUALDEPWAIT
To:     Linux RDMA <linux-rdma@vger.kernel.org>
From:   noreply@launchpad.net
Subject: [recipe build #3570849] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168892568686.8219.14460372023025607577.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Sun, 09 Jul 2023 18:01:26 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="2ac9e3bf4ab511504f8fc651371e24a6a047ba12"; Instance="buildmaster"
X-Launchpad-Hash: d5451c170915a71c3d8b2cfd0768d5dd34ed0d80
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3570849/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-013

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3570849
Your team Linux RDMA is the requester of the build.

