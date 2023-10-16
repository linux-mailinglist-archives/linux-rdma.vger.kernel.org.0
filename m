Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887477CA800
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Oct 2023 14:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjJPMb5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Oct 2023 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPMb5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Oct 2023 08:31:57 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD44AD
        for <linux-rdma@vger.kernel.org>; Mon, 16 Oct 2023 05:31:55 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 0218241B14
        for <linux-rdma@vger.kernel.org>; Mon, 16 Oct 2023 12:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1697459513;
        bh=SD6t7jq+I/ArTr85FB4EMHZPm9wjGOTYg32fLUkiSvg=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=VfzPgVGUjHodu0tcGTV/Z25iVQfj/qgeYl+hCb09BsQEdT1mVAt8A3TKWll2+0lZ5
         9T2EFWB9KVVhgqQ/aCnd0MPjuKbpN8kOEN1l3sSSnzGS1R8pG3XH4y02qt/MKp9Teb
         6Op2iVQ6OtFis3Bx6MiUJ5r7BBRyzPvnNNsCefKLckdKxYp3q9d1MKewRERlnCD+e2
         l1vvXA7m4GJo/qKyccADZuxcxQuJLQDvBBIpUStsDwuuRTdRhiBg3e3DKC0vOpwvTX
         nDrY0xbcaoBv7N9/8A0gxChYn5ThBQ35cDoBqCigMrY6ba9kgV1By971eFwqgwIj8N
         fVVsUyPiV/FmA==
Received: from [10.131.215.202] (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 1D6DD7E6D5
        for <linux-rdma@vger.kernel.org>; Mon, 16 Oct 2023 12:31:46 +0000 (UTC)
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
Subject: [recipe build #3618394] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169745950607.3404761.10289933290537040338.launchpad@juju-98d295-prod-launchpad-15>
Date:   Mon, 16 Oct 2023 12:31:46 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="bd6cfd0cfc024dbe1dcd7d5d91165fb4f6a6c596"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: f2bac29d7eca7795435d7e834c5b47c16a860a8c
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
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3618394/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/bos03-amd64-028

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3618394
Your team Linux RDMA is the requester of the build.

