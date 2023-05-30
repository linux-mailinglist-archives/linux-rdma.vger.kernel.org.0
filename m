Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8C4715D47
	for <lists+linux-rdma@lfdr.de>; Tue, 30 May 2023 13:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjE3Lb5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 May 2023 07:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjE3Lb4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 May 2023 07:31:56 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B403B0
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 04:31:53 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 1EB483F1FD
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1685446310;
        bh=3GWUl3v3OLFb181dIawR/uMQRAbUygVT6N1C0ILuCWw=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=wSvIq/8fdCj1diYty9RsHxU+qihmKZoHXr4vyQ28pb2qhS85pMuaMLRmqFiH16xAH
         YmctOq8Gi/JysqDld2a9W+rRrdq7P1c+BpBJke+dIKKbqLFpV/9HlUlYVyqa7fjIkR
         MylpsP2L2rAGAj32Pdz4a95vkMfXEhXdrH5npuMv3YPcWh8oAnlm0HLa03eV129Owq
         5GNgvecTQnQ5SdjawmWRF3vU8UraoejM+slQvZMbL2IsVl7gkF0Pj906mNxp3cPwgU
         Czlw9kkGRtV15FukfqX94YRgOCUW4YKJpb6N6CqQBKBniOZ8+rKA6AMakMMLm4FKhd
         9hFneH6crGxYQ==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 040DBC08AB
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 11:31:49 +0000 (UTC)
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
Subject: [recipe build #3548507] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168544630898.20635.17025878356695975675.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Tue, 30 May 2023 11:31:48 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="060234aa1273238f7880ac19de947f3512a7e11c"; Instance="buildmaster"
X-Launchpad-Hash: eddd88cf63352dc459ac43132cccd077ede4953b
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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
aily/+recipebuild/3548507/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-031

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3548507
Your team Linux RDMA is the requester of the build.

