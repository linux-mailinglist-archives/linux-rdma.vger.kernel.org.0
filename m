Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3906076E834
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Aug 2023 14:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjHCMbn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Aug 2023 08:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjHCMbm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Aug 2023 08:31:42 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC622708
        for <linux-rdma@vger.kernel.org>; Thu,  3 Aug 2023 05:31:37 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 6C4D23F723
        for <linux-rdma@vger.kernel.org>; Thu,  3 Aug 2023 12:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1691065895;
        bh=YVHz2r9r6Ru2ri3e9OkWt6cZdkeVPn+M70MPa3eS9sg=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=Qqird8Gyo6kluqqeJ7VXBYMrlRC4Odzz1xiwJrOq8y6eZKPLNIIpQFW8RgI8W7jaG
         J2hLpJ19mHpopaf4h/GZ9J3lvgb8SFynv3dyHDoUI6Eu25VgHfPB8EMjur5g9QdJkB
         TFKLZIHlcTgV77OGQCbpjG/yzLLuPWOCpowBdTgc6aPFj91bISF7049cQBDuAlE4nP
         mQ9DBCW3agnCfQpKwPGdWKHb7BzS19hZFtBENnsXBWMu0mTVebp6ptj9CzKsLrLwCk
         ZzMLaGtxUrmjGDHk+ma1yuQKz9r9EilRYQxBDUFfN+Q8vyq9/s+BI/r1/wFquHTXOL
         9ZQmOoFW725HQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 4CECE7E005
        for <linux-rdma@vger.kernel.org>; Thu,  3 Aug 2023 12:31:35 +0000 (UTC)
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
Subject: [recipe build #3583493] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169106589528.473079.9397608111833371330.launchpad@buildd-manager.lp.internal>
Date:   Thu, 03 Aug 2023 12:31:35 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="d80dbb5bdc9110f3a64cc968928033472d5e0509"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: ac1434cda5dd184b57ed3653d74e551195710b10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
aily/+recipebuild/3583493/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-116

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3583493
Your team Linux RDMA is the requester of the build.

