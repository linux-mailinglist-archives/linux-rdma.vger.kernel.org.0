Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF0B683111
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Jan 2023 16:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjAaPPA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Jan 2023 10:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjAaPOr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Jan 2023 10:14:47 -0500
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B37959F4
        for <linux-rdma@vger.kernel.org>; Tue, 31 Jan 2023 07:12:57 -0800 (PST)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 901123F159
        for <linux-rdma@vger.kernel.org>; Tue, 31 Jan 2023 15:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1675177302;
        bh=RH99SN0VCCPvi3HT4Zr5rqu+F3tM0MzEuk/umr85beY=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=Zba9AU+heQyXAu5IcZzwKo5FHWfMExYRFUlT4WlqfP9OwXvUF3j2MDsrF755hii/O
         tXfC3qHtu1bGd5H4jKAYpAxgv/EDMYS8bCbYjUY3W/UwcilxM9XfT7R8OwNt1LqI/z
         qD8tbPQgctJuhaw702whjIn1E52tA6LP0Vx7cgbjZd1AjBFKZZqE11bqwG1+LLWfpS
         Bsn7dGChEX01hK924C7JbooNUX/NPExXOn8DG8f6QrM80OuHAluWIbNH3J86fOeC7M
         KJ8h1NYi0ma0j9bSes2JTZgvUpblDk9FIB4Y0xTlTzj+pXQuVxbW4CKptSBgf0JgVO
         H//OtVVZfkkDA==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 7C5B9BB827
        for <linux-rdma@vger.kernel.org>; Tue, 31 Jan 2023 15:01:42 +0000 (UTC)
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
Subject: [recipe build #3487906] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <167517730250.12043.13973267063733960983.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Tue, 31 Jan 2023 15:01:42 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="37f563e5839786fe8704ac9cf25657dfd53c73fd"; Instance="buildmaster"
X-Launchpad-Hash: 7aaaea8b957a98511be1aa66b624784e02b67739
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
aily/+recipebuild/3487906/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-002

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3487906
Your team Linux RDMA is the requester of the build.

