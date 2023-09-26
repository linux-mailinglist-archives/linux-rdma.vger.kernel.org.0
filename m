Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4CE7AECE8
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 14:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbjIZMdR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 08:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjIZMdR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 08:33:17 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69173FB
        for <linux-rdma@vger.kernel.org>; Tue, 26 Sep 2023 05:33:09 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 9B92442301
        for <linux-rdma@vger.kernel.org>; Tue, 26 Sep 2023 12:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1695731566;
        bh=HxkIZM0+5/DMY/CB92GtpfbI9ulHvLMDyuGWC412x/k=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=N5KZJB2PTac9KqumfU/fc/0xEXkQXG7DabZXVx7UBBnglHvRzgKQHQ/I3n5HzbJI9
         DrAJeaxFC4pgeywLceBfgIR2x2hQ+fnaPRvCTWQML7PV7M/Rq5R8eA2Bl9KHBhT+Gl
         wKuqEuJu7zobKLLeNvkRL0i6wVqt2gEUR/In9LNZEzTNYmIRNw8IN1qsU3TFIfzu3G
         xs0S+E4D7DQbrlsuUH5ZJPfDTg/UwM8h+WJsIBY+Nh6G0xn6ziKPZP/Py8w3M3vz84
         zltELVNCUKV4YxFooU0p9JBOzSXUxTtj1JdmMKubismdEQnUV84klVxm2MpzPHogWJ
         1cYoNIoKjZ3Bg==
Received: from [10.131.215.202] (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id A76157E01A
        for <linux-rdma@vger.kernel.org>; Tue, 26 Sep 2023 12:32:36 +0000 (UTC)
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
Subject: [recipe build #3608236] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169573155667.3355308.18433114899117967694.launchpad@juju-98d295-prod-launchpad-15>
Date:   Tue, 26 Sep 2023 12:32:36 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="d47b73632f1fccdd9fdd4e6145a4784874303779"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 848678f55ccb467a3ed0a849fc00afbffa6cdcc9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
aily/+recipebuild/3608236/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-100

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3608236
Your team Linux RDMA is the requester of the build.

