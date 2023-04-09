Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4FF6DBF89
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Apr 2023 12:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjDIKrB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Apr 2023 06:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDIKrB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Apr 2023 06:47:01 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF64681
        for <linux-rdma@vger.kernel.org>; Sun,  9 Apr 2023 03:46:59 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 560B63F061
        for <linux-rdma@vger.kernel.org>; Sun,  9 Apr 2023 10:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1681037217;
        bh=JnyJG2tPSCMVc228R8gz8LTSDfQHPTlg3Z4MPQTdnI4=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=EEMrPUTxz7doI8mSPJeeyoypp1cn6DVjbmBKCQ5WT4Q3MqkYtws/URqFAxfEVY5y0
         QKL9dkmxOGHY0J8juIFNgUDSbIvBg/xAR6pJGJ6c0E38BVuldL9I+tdsMo/N0UkbUE
         L1XsrmHyQPm2GmbRiTBPqQliujO0P5sSMBiafE3zNXJTnNCxOZvmnZRh5e3WqnH8te
         l2nY/BvrnaZRFdYXOckNoeBEh7/IqobxYQM+llmRt3mpasWTyVEiQIXecmKbs7VQrw
         8Yio+vGkbrcNInRihpqbAknp7SWRTJg7dczxhX5YaSYZpBQP7Y7VQxpvMEdt4HBggj
         1WeEO7KAzKs/w==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 4C3C1BC30C
        for <linux-rdma@vger.kernel.org>; Sun,  9 Apr 2023 10:46:57 +0000 (UTC)
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
Subject: [recipe build #3523606] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168103721730.12454.5885043108583395516.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Sun, 09 Apr 2023 10:46:57 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="ce6856af661dea2cdabcc7883eecafbc1fccc4ad"; Instance="buildmaster"
X-Launchpad-Hash: 5fa3e788579602a6b161c418521882a2d3edd16a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3523606/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-096

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3523606
Your team Linux RDMA is the requester of the build.

