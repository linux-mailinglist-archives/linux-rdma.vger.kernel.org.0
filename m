Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016917F062B
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Nov 2023 13:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjKSMcB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Nov 2023 07:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjKSMcA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Nov 2023 07:32:00 -0500
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A00D5
        for <linux-rdma@vger.kernel.org>; Sun, 19 Nov 2023 04:31:56 -0800 (PST)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id AEA3B3F658
        for <linux-rdma@vger.kernel.org>; Sun, 19 Nov 2023 12:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1700397114;
        bh=3zN5lB75C2toULCDv0uClmRDgFfgZ5IVvFMru2ZyGx4=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=HSUh9XPqBTKQCQ4nfDRW1VuNrpkZV9eRveUdtqJl5JDlhpM7ea9WYSI6dyKXm+SJE
         ZZlhuEnKdQj3WqL4tVw3MltqAFg+MTztHa+2t5vWMXpsq3MnoPbyg6GuZB3hDUVHIa
         O6dtEenDRrmjDoabq3vdA2FyXFHtSEwaQJ5DRLzXE0vsfpPBqA7AXsgh0eSgD/eK9P
         dZVpyI1MYegUeWNGMl3K7uzDFW9HB7srNeYZYqFyWk+DoeguFhxpB2CzkjMD6GKO8g
         62UfGG4vyfq3o0lmbSjE7a+E5ozCqUeO6zgOxuo8I+QmVlMsPsDjxYAylPwlw+Do7P
         WJ26BSdZs5xNQ==
Received: from [10.131.215.202] (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 977047E6D5
        for <linux-rdma@vger.kernel.org>; Sun, 19 Nov 2023 12:31:54 +0000 (UTC)
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
Subject: [recipe build #3636039] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <170039711458.4153404.1936045889348981136.launchpad@juju-98d295-prod-launchpad-15>
Date:   Sun, 19 Nov 2023 12:31:54 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="f1e537f62ee3967c2b3f24dd10eacf1696334fe6"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: b363f419c3c8555ba17775fe6ba9b0ce2c1b1c46
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3636039/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-015

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3636039
Your team Linux RDMA is the requester of the build.

