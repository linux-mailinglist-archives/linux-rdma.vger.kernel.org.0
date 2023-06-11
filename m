Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51D672B1BA
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jun 2023 13:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjFKLqa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 07:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFKLqa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 07:46:30 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F61219BB
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 04:46:28 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id D65463F54C
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 11:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1686483985;
        bh=+YXuhSU2S0JQIQhdtvBhI3FoA/qt40zpy9VZMhukVHc=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=Y/lx80SVxTU+N3urgY89BtduwL74dL3OMxw2SQuCaRPHNmgYXiJAJjAzw6Gyhd/T1
         3cxLl1wab/uW8NdRivSO5tsXkUDuIDXPOlHhgk8MFLwjQdJ0BOI3lvlcyGGUjSO7nR
         C7Ij9cf+DYQFfkYrMXaYIyMEmDSrH3dtv66MTDAAzIPCPunZACKmzV3PXsZ7QMaRsV
         XAGp0a7fAhY3ZdhtkLrMqFi3SHZY/2C8VoSvMlqa8iXFqzf9m3lP47ehaQL0eImyuT
         lNCTEYrQaEfrI9drdxtfepbjr2oOAHYGQ1YYdXhqhYNjDKm07g3NNyb0xBWf0BMXPK
         5XwjrUtjWa1mA==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id B59C1C13E2
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 11:46:25 +0000 (UTC)
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
Subject: [recipe build #3555296] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168648398571.23180.17833681031814351853.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Sun, 11 Jun 2023 11:46:25 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="620cd5280e3a973662e263ebf9346837ed657a46"; Instance="buildmaster"
X-Launchpad-Hash: d937e98cbf8599be331cb3f51ba48718f4b3fc63
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
aily/+recipebuild/3555296/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-010

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3555296
Your team Linux RDMA is the requester of the build.

