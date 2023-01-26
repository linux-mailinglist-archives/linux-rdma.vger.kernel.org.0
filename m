Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E6267D9ED
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jan 2023 00:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjAZXqw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Jan 2023 18:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjAZXqw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Jan 2023 18:46:52 -0500
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4279E166D9
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 15:46:40 -0800 (PST)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 81BF241045
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 23:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1674776798;
        bh=ZO05xq647FAO7nEihgVp0v5Iq6w7pKvprLk58tx0NqI=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=Pyh3KRgYt9K7kqnn1MGX0QYZrstPj3xMxZ7O0yRJvccYdM3RabeIiBNTKjsHz2/76
         k4mvIZ5M4Dw2VXwS794AqNjzhzgea49RIDWq9ZdglDRUtQUrVWFvI2lQEqGGk6fmIt
         ljLkHcve2nnRRIt21S4lZyCMv/WdB5m1F/wUqagLxoip3gD1tDhc/dyPppuAe4lFns
         sQBIKV3NsRRMxbMIDj5wlAhIYHWP5gL3dMHldVR4cReNE5mArtvTJ2lBe5xCOccY80
         RSC3K3JceNrF9hO5k20ELCyeQJ3LeEMgWEBSSIfR8ASnC/QlZfWjbl/FVvctjN7khc
         aTOmmzrsLzluw==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 67C5EC112F
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 23:46:37 +0000 (UTC)
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
Subject: [recipe build #3485453] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <167477679742.634.11512928036667965857.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Thu, 26 Jan 2023 23:46:37 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="20dbca4abd50eb567cd11c349e7e914443a145a1"; Instance="buildmaster"
X-Launchpad-Hash: d994c92a6a6499ba52652bd767254d658870d80c
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
aily/+recipebuild/3485453/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-039

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3485453
Your team Linux RDMA is the requester of the build.

