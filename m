Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6E667C11D
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jan 2023 00:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbjAYXqm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Jan 2023 18:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjAYXql (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Jan 2023 18:46:41 -0500
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9FADA
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jan 2023 15:46:39 -0800 (PST)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 9D4A33F298
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jan 2023 23:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1674690397;
        bh=lVmVofNoNDBd3r3TZOudkCiFQldxdd0rHwyYepnd3Xc=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=rehc82sHTLlLphiEmFy3/UNa1J3JZ57eTBCGaxkIK6JFLN/B3kK4pUETvrZGesyrB
         1lEX18RWKLQWgb63MB9AmTjg+GZOyoQI5KiWSNuHKufpaExiyVgorhd0na2pXgGB07
         OcUYz20qAso/cnxOKUgpDH7ZwEQdTtUSWIzqrfU4IY8hy4q18w+rfZlBbrYoEUzMan
         5rVEkk8v5i85Z0qj33G80jRWbH+fzz4sWAJJ0BFtUa6c1GnCfDrv0dprj9RHNQCWM1
         J4KWJXZDjVcnr1zCIpaPNsX83QNS3aFgLp9TJ6hRq4CCJomxCxLLujOsuhvbfIoUKG
         OFX7BJ0quPftg==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 8BE73BB817
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jan 2023 23:46:35 +0000 (UTC)
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
Subject: [recipe build #3484839] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <167469039556.31541.15616544041692563890.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 25 Jan 2023 23:46:35 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="d47ceee2cecc7e14911d9cfaf6b020457c646bb9"; Instance="buildmaster"
X-Launchpad-Hash: 8ec904b7ac951ff0d398068817d11ea9d7a2fb65
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
aily/+recipebuild/3484839/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-015

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3484839
Your team Linux RDMA is the requester of the build.

