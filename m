Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CE278F655
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Sep 2023 02:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjIAAQ6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Aug 2023 20:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjIAAQ6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Aug 2023 20:16:58 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B58E6A
        for <linux-rdma@vger.kernel.org>; Thu, 31 Aug 2023 17:16:55 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 524883F053
        for <linux-rdma@vger.kernel.org>; Fri,  1 Sep 2023 00:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1693527413;
        bh=DE0JVLzWJgIuVTakNM6VNKJeWeNlu6MEgc8PSatTANE=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=PLQtrw0Gp4IzkQcd9y2mGozQaqy9IAMRJpRJs9/eDacgNdw1tw83x7n+DAMhnCR1n
         OHDaEdjioC6an8vzgYzDDdavNvJ8MW79NYkcdjHXLZE2uctpKEb301HNTNNvynhyfI
         nPG2NvuFYUvvENkQuCM+fvilCs0X8QWtYhOD/sfR2EdHoVAYSCSg18DNWBL3AWzqKg
         /stmDwcJV62uUICaejaRnwQ+2Z6jOkjdPEd4tKQGUaduRBjCZlk+BZ4AUyNYb2se9q
         eurmbsuz//Ykvm1pdqNzBqhbxIBx8Bfu9WJrqYI6zT3u1SJeN0f0d2daL/MV2oydk2
         +EOLOD2qD4U7A==
Received: from [10.131.215.202] (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 36E707EC26
        for <linux-rdma@vger.kernel.org>; Fri,  1 Sep 2023 00:16:53 +0000 (UTC)
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
Subject: [recipe build #3596874] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169352741316.304741.5712113204861989529.launchpad@juju-98d295-prod-launchpad-15>
Date:   Fri, 01 Sep 2023 00:16:53 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="be364c6994371b9f0c5e1babf97a84112b90f8a8"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: edb1d8557370109a53e3b35c94601434741933a0
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
aily/+recipebuild/3596874/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-032

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3596874
Your team Linux RDMA is the requester of the build.

