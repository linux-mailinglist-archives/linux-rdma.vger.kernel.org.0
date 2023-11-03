Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697697E0826
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 19:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjKCScS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 14:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjKCScR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 14:32:17 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC07CD4B
        for <linux-rdma@vger.kernel.org>; Fri,  3 Nov 2023 11:32:08 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 82EAB42A7F
        for <linux-rdma@vger.kernel.org>; Fri,  3 Nov 2023 18:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1699036326;
        bh=0Y9EZY/6aWGuOQ205Y2vtVvlncoLd2h+uDCyCiNyGvY=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=kWBNIUPcLGqipldTjS8gUiDFHtXukMQenoBxGZ2K8izcBlA9/OX3MM3DbaB0AspKJ
         HPWOlYUYHCX8yscs36CNbw7S9Xnk5BHMTCZPeqBW2vccPC9myDx9v9wguObvVHWpCw
         QA2c+LKUtg1SvzsBfrzRHzXIjAh6+AyxDbd6CRc/IwBPe9lD2MDScPzWpg5+M4Qkmu
         osxeSDgNB9aQtaVAzz2Cknbqca7rJu5gcAQ3Wv3BiLbEs9zpvKIytBPIFeEmd6Wbep
         vcAziQkj8WH6KvZM6hmcDcqpO9k2E68ShGcLEy2oWg45nX3p4CYEESlZyEe7Hqnvww
         QzfP1wpvDZYkw==
Received: from [10.131.215.202] (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 083317F05C
        for <linux-rdma@vger.kernel.org>; Fri,  3 Nov 2023 18:32:06 +0000 (UTC)
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
Subject: [recipe build #3627829] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169903632601.2858600.2379435498676512292.launchpad@juju-98d295-prod-launchpad-15>
Date:   Fri, 03 Nov 2023 18:32:06 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="9412a8042fac354f9c42815196ef31c1d9358917"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 2297d3212ee195e9cfbedd96b03e7da681bc711b
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
aily/+recipebuild/3627829/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-116

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3627829
Your team Linux RDMA is the requester of the build.

