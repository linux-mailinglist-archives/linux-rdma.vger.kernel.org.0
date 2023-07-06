Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67284749B4F
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jul 2023 14:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjGFMB4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jul 2023 08:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjGFMB4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jul 2023 08:01:56 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E6C10F7
        for <linux-rdma@vger.kernel.org>; Thu,  6 Jul 2023 05:01:54 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id F06F74136A
        for <linux-rdma@vger.kernel.org>; Thu,  6 Jul 2023 12:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1688644912;
        bh=Wc1pjAs4mqdVFpHQGy9kqseVikKKirnA14VBQZNbvnY=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=YaMC/63jMfTFY28jsBkAJUKfL/7lHbK4EZ/oGIgfP+N+1yWGnzUCqCuS1T8xrBPCf
         H+aFDgODEe5zInxO0R+A8fZSUgZDwLE2EzBU9xau0hp+QD6FEU6Gk1/wYPh18HciNa
         3AAfpZ/O1iwvUGxqq18S2WL+p6wpUSID0PMBBVLNQdG197L2HDyTJtpNBxWdZKjPpU
         P9rZ9aA+b4SrWz2cFpeiNCslX2myJUFoGrg8bEiNgxkaxKIp7zagnXPdVXONrWTYrj
         HoM4FRpsP6sap3OsForGIq3W7ah+h6e70Q4yCutz7BGN640U2SYp4MSdqXte5X4IST
         5zLRkNIrFEO6w==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id D0A7EC0C67
        for <linux-rdma@vger.kernel.org>; Thu,  6 Jul 2023 12:01:51 +0000 (UTC)
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
Subject: [recipe build #3569187] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168864491182.30041.15655331158514764712.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Thu, 06 Jul 2023 12:01:51 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="beda0e9dd2b131780db60fe479d4b43618b27243"; Instance="buildmaster"
X-Launchpad-Hash: 37f1640b78c27536e6dc83df45ec9430b7c4eff3
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
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3569187/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/bos03-amd64-025

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3569187
Your team Linux RDMA is the requester of the build.

