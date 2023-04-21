Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FF46EB54E
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Apr 2023 01:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjDUXBs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Apr 2023 19:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjDUXBr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Apr 2023 19:01:47 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDC71984
        for <linux-rdma@vger.kernel.org>; Fri, 21 Apr 2023 16:01:45 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 8716943F4D
        for <linux-rdma@vger.kernel.org>; Fri, 21 Apr 2023 23:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1682118101;
        bh=KURrcY8Iwank3CqxjGbxYWUnyk6Iw+1drYTGmiynSiM=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=kEiBu4vwZ+rSuiAV+ucWkNHbV/QuNnU6pDNDsKRvYu+gnpT9RZweWOMC6jHCmEebK
         NJr+1Cli1lMRiEk+9k0wp6P9gP3sVirRA+0oDmXX0Q60xYU8iH83bNS86qSlr4yXhu
         7MRsaKa2NWE8TXMfhccwtcFM2sxY+rVMrMNf7qtJXcu4unyYm0MvRvypMe5jNB18bT
         QUEPIMXCNzZHaHVNwHsBKfOXWe5+hvcnBoNIvDqX6BrABkP6F///pRq1TYPkxP8Oh4
         K1eQ/PC5DcrKz8I7lLNRUFtVJxgF8KrS+XaCHBTPMETVv7xYel2sgZh4lotx+jTAq5
         6/8yER6EOBtJg==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 28B91BDE56
        for <linux-rdma@vger.kernel.org>; Fri, 21 Apr 2023 23:01:41 +0000 (UTC)
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
Subject: [recipe build #3529976] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168211810113.14905.17835915874436752168.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Fri, 21 Apr 2023 23:01:41 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="bf5eabb05277c9923772b58708dbfa8079a89d1b"; Instance="buildmaster"
X-Launchpad-Hash: 871c5b617919b87262543afe21f914be941162b3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
aily/+recipebuild/3529976/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-009

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3529976
Your team Linux RDMA is the requester of the build.

