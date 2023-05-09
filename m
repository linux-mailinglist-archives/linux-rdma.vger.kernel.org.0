Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAED6FC5C6
	for <lists+linux-rdma@lfdr.de>; Tue,  9 May 2023 14:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjEIMEz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 May 2023 08:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjEIMEy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 May 2023 08:04:54 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AF2DC
        for <linux-rdma@vger.kernel.org>; Tue,  9 May 2023 05:04:52 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id F2A203FCE2
        for <linux-rdma@vger.kernel.org>; Tue,  9 May 2023 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1683633889;
        bh=1bKCaHtXqFSZQCS9noqLO9l9stsTgxBEfnjtRsjQ914=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=Lj0CGv4OfQ1NSJ2o9JRIf9e+8vKfynk5NdBbvtAHBHsZH1Jy2vyUDVX9i8JvaBU1u
         uv/6TdUMo/nBleckvloD79j4BaZyiJ2zkoC68w/FlZMATeatoOV18GMBai+z17U2R5
         8D7H38+l/+6NaTbh9ZU6GZhRMHS5CORce8i1TiNn1wrQzrykkHGY27JfX3p1W4P/Ik
         8/LBHIcQVQkLq1Zq0hWF4CfEcYONjiF8sFSQcn7Dvu0ruMe5ld+fpDnaZgP3xUgpqP
         NfpI3KEtmd1D3bGoJB4BRwR+zu5toxCwYcMjTjZCOSWdZooDa09sZfPMjv6tc4EsZk
         EKZK9+/k5PIBA==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 325D6C06EC
        for <linux-rdma@vger.kernel.org>; Tue,  9 May 2023 12:04:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Requester @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: recipe-build-status
X-Launchpad-Build-State: MANUALDEPWAIT
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
To:     Linux RDMA <linux-rdma@vger.kernel.org>
From:   noreply@launchpad.net
Subject: [recipe build #3537873] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168363388720.17883.10698421961453031851.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Tue, 09 May 2023 12:04:47 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="90e2150bef31b411d7bae5c4032c7e320fcaaec8"; Instance="buildmaster"
X-Launchpad-Hash: 4293a8697c743778b75a75ea89a0bdff977119cb
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3537873/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-036

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3537873
Your team Linux RDMA is the requester of the build.

