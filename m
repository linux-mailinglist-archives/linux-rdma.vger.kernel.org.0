Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8F06FF839
	for <lists+linux-rdma@lfdr.de>; Thu, 11 May 2023 19:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbjEKRQu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 May 2023 13:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbjEKRQt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 May 2023 13:16:49 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3987A83
        for <linux-rdma@vger.kernel.org>; Thu, 11 May 2023 10:16:46 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 6AD5A42829
        for <linux-rdma@vger.kernel.org>; Thu, 11 May 2023 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1683825398;
        bh=ickHjptWhelRB57eZi/+oRsi3b0Xn/gg57FEj/emXzg=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=F0VvzEl1owJcP49aX8IurbJWTXmgd0jNUtej+VYMs5BItNTnl24ChwjrjgtWglccT
         7i7un8pH9vpaJL+cTezzbZZ83i8JvY0QUI45YCppGPxFcmP8gYOqTaXJ+M/lDQTx7p
         uEQrd67NqFSwB3m45iqGC1vzK7BKXiVwuNPNWVZ5TfS3fuh2/n+015rlQB6F3j33Ee
         risa2aKhcudM+YUAjRriT37qHm//U/fN83/Ot+RYiFO05HTa5VHtSxnemwl2hxaOep
         tlcNopkAXU8DQcVwSDgGWcx7hXTy/CxUXDNQTM0T+QmU+jX/2sxcpyREVRHKgCHxFK
         KrgvB2HShPSgA==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 4CB69C0712
        for <linux-rdma@vger.kernel.org>; Thu, 11 May 2023 17:16:24 +0000 (UTC)
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
Subject: [recipe build #3539139] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168382538427.32450.11231259162569383524.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Thu, 11 May 2023 17:16:24 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="90e2150bef31b411d7bae5c4032c7e320fcaaec8"; Instance="buildmaster"
X-Launchpad-Hash: ae85daa15ef062614009d949da1b5318485f4dc6
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
aily/+recipebuild/3539139/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-031

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3539139
Your team Linux RDMA is the requester of the build.

