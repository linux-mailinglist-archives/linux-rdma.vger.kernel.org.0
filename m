Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD56E0BA8
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 12:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjDMKqw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 06:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDMKqw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 06:46:52 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBFC12A
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 03:46:49 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 21E1842656
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 10:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1681382805;
        bh=gMT8o8Bd2Xek2ntvA3mk8hFVALYcJmSiZozaC94TdQI=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=R+U1ROhSyHDijpfc/JnNeoPllYeuUL6pPwg7pVeTQWi0IhIdaK2g0I7mTew38yUUq
         zDUVIj3OffTCwP361YexLbYXfg4s0DJczYmzEV5Sxi9h03/y7atffkkq0JTtOYWH5o
         JS8ofXBKPfCc9R1n/38zmfxgwRbltx2ifmlsNN8GJMfhVJeGqP+0DWw+refRcbrSJ7
         3VKZvEF4eidOInLDVnqKJSIrpJ2T/SqGlygglej61FVc6QNjEroawPy9RSE1kIgv2H
         i8sd9HvCIAr3hIy/1NAkFaCuX16JvEL6d7hNKPC65jNGXsfz7fkjOZmBvoEniCVSe1
         dVI1wt3vP13IA==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 0E05ABDE6D
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 10:46:43 +0000 (UTC)
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
Subject: [recipe build #3525740] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168138280302.22458.7383284197221252008.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Thu, 13 Apr 2023 10:46:43 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="ce6856af661dea2cdabcc7883eecafbc1fccc4ad"; Instance="buildmaster"
X-Launchpad-Hash: 50a9caffd196ae6cdf7e0f0c0cd28c3a0e479065
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
aily/+recipebuild/3525740/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-047

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3525740
Your team Linux RDMA is the requester of the build.

