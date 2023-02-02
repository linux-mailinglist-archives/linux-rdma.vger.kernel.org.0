Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A414687C0C
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 12:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBBLR3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 06:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjBBLR0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 06:17:26 -0500
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EECF8AC1C
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 03:16:53 -0800 (PST)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 396673F621
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1675336596;
        bh=nsxx48p+aHTup89v6/wqnz9wBvBgWCywZ4rtdGyOY1Y=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=K11WFHPV3lS00ck7Pzi4tyIYS+H48VEK8rp6HKzvNzblaMZ0xXo0tJx8+aSPczYEb
         K39e2Q4A2Dm3bMTxqpk8A3CP/6KReNtixiXzEIPQ3Wb4fbSDkRHdxmSoPo9/MIpr7X
         ASlPkbf7HJlszhaP+pAzzw+nfj0aQS48vrxn/1h1OBGqAc0+8k7PXdARFLUF7JsBY0
         Nwh+3TNcV8QvZw7g6FTRIqs3Mb9QP2UwbYOMvk4/LkIe9iFweK4KaRCUlQDcRFQt+V
         ANIbbqWkCXMS6d0A4RSmpD8Yg9u++AiGVRWRLO5jRZtvMVnS5H1mV4mjj2TBuel5+A
         nrScZNY646GBA==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 1CB64BB81C
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 11:16:36 +0000 (UTC)
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
Subject: [recipe build #3488986] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <167533659609.27579.9283823041069923615.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Thu, 02 Feb 2023 11:16:36 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="33dc2e2ab7f8e563f52b8c81cbdf9e3946d2097e"; Instance="buildmaster"
X-Launchpad-Hash: e7f5989ea3b2a5c95bd873ad43c3e1ec5876ca90
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
aily/+recipebuild/3488986/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-107

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3488986
Your team Linux RDMA is the requester of the build.

