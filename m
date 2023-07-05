Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5AF7483B4
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jul 2023 14:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGEMCN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 08:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjGEMCN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 08:02:13 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA12E7B
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jul 2023 05:02:11 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id A5D7D40FEE
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jul 2023 12:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1688558527;
        bh=752qeq9bGAZOcqfwjnsQNRw1oFT8Q/sQKwGMhMS+8cA=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=DeGDI1E1559Zn6xE+DN1oLsT8MYcIEvEWyexSQnskNpmdEUwM4VV1XlaX57mz9bUa
         MDvpAkyzgF3RPCrwgwU6IjeS4H4I4fKfVMCNIuleueI0ENhOOkJD85y3iEFe8/Z++U
         J8ZtDNepujtnwGe9DPPOGZow3G/xbmCWbawzhhLdKj7ZaG/drv655ir8IuQt615JKF
         zdtfDfdWTbzZdk0aJI67rnzDL/axNRF0yNL7HhtlBjrYCsRO4kMz5ZfodCA8z9+GU6
         xPQ/UGEGYryma0amGqgZeZXP/+bJZRFgP4hCZ6KPDgmaX23eaCIaqMfE18NgWMdDK3
         u/+t0JfsAKfgg==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 202FEBDE6A
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jul 2023 12:02:07 +0000 (UTC)
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
Subject: [recipe build #3568739] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168855852712.30395.6949139979323975062.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 05 Jul 2023 12:02:07 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="beda0e9dd2b131780db60fe479d4b43618b27243"; Instance="buildmaster"
X-Launchpad-Hash: 0026c55a581e36f29c9b76f140fc1780c372ae99
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
aily/+recipebuild/3568739/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-111

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3568739
Your team Linux RDMA is the requester of the build.

