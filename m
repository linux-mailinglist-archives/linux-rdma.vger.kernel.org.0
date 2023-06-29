Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7380C74253A
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 14:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjF2MCW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 08:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjF2MCV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jun 2023 08:02:21 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DDA30E5
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 05:02:18 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 31A503F27F
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 12:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1688040137;
        bh=oK9Wpw24mutaIeH4fkDeuX5k8BH4ocvPRrB6L014yFk=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=plvnl0nNj4Kkt4+Jm0oCjHoSTai+uOmxHqrWnf1HiBAHf+9V6bvpMKdPoTiUrH5dn
         lFiEfmZEz7kcbFuA7dsqCrINxthpE8Vrt2GX57vAMgVzV1nnfZY8Esa6TXAqXq02s2
         u2Qt1wSgaHY2sI7hRelVFZOVjtObIyI1ZyvXZ3xUlj+4cCl48pQnNCnjZniNhP4190
         HuLg9bYVj7WYzdDwxhhGcgy7U5ACtotU7cxyg9QE2pqvc7Yhx4C2OwjAkh4hc3MsEO
         fm1O9LpvEgGNfoHk1j6D6xyIlgLgILorN8WLxAf1I4MjJ0/jREoJs8LOmsgH54oY4M
         +4KacXNQ9GpCA==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 582F1BDE6A
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 12:02:16 +0000 (UTC)
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
Subject: [recipe build #3565435] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168804013633.18761.17252561458004932839.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Thu, 29 Jun 2023 12:02:16 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="d6e3bf1b1b4849a91befd7dad9268049d9a506ae"; Instance="buildmaster"
X-Launchpad-Hash: d7be7297c41f8a52c2229819d70174f1ec0997e5
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
aily/+recipebuild/3565435/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-056

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3565435
Your team Linux RDMA is the requester of the build.

