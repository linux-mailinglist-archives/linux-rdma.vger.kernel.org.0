Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747C0698443
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Feb 2023 20:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBOTQl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Feb 2023 14:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBOTQl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Feb 2023 14:16:41 -0500
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B1139BB5
        for <linux-rdma@vger.kernel.org>; Wed, 15 Feb 2023 11:16:39 -0800 (PST)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 5D4773F199
        for <linux-rdma@vger.kernel.org>; Wed, 15 Feb 2023 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1676488597;
        bh=X+y7bUiYHUSKisi2DCFhlotkOxHl8MLd7lJ9p5iRzxw=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=Wga2+/NaGdixt2QHWvhOy6ma2hq3wvKPNEROceyo1XN/8/uXMQuJqc4+Anb+BZ32j
         X1yUhVmbR5SsbJOUKX/R/08USfSsq7Cg0DhZRDuuzr2tjBLFlsEcktIxs2/F/CNfZq
         b5HYch2/8snMbj4i9rIvjhy9P6i6jwe855LE88XpPGaNhLRn2qcWkfJkpiLbDFBjP5
         OqGv9C1LIGiQws82TE5HiiirL33a3nGgZdYTLzAei+pNBPlvzLI9ILXwI6ZTNtfI5F
         99Zvf6VQl4al8INmr9VIRVHTYm1Wkg60dWG9o2CjJ0K22cdeUAj3LAgcRxQZF/nGlc
         wVPPXXTR0vVKA==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 2AEA8BDE6C
        for <linux-rdma@vger.kernel.org>; Wed, 15 Feb 2023 19:16:37 +0000 (UTC)
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
Subject: [recipe build #3495862] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <167648859717.29248.7535672102563488569.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 15 Feb 2023 19:16:37 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="611eba1e393fbca1b432f5f94117b070ac88176b"; Instance="buildmaster"
X-Launchpad-Hash: b21314bac41a85c28b24a0fba73b374204ca76c3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3495862/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-089

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3495862
Your team Linux RDMA is the requester of the build.

