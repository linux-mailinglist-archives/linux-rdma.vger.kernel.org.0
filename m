Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836E96F8127
	for <lists+linux-rdma@lfdr.de>; Fri,  5 May 2023 13:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjEELCB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 May 2023 07:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEELCA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 May 2023 07:02:00 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBA819938
        for <linux-rdma@vger.kernel.org>; Fri,  5 May 2023 04:01:57 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id A7F923F778
        for <linux-rdma@vger.kernel.org>; Fri,  5 May 2023 11:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1683284515;
        bh=L30iJZkPGnloQpquHt3Mfm/G0IJA/lVYId+yANnd0qY=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=guD8GXc+emOAx1kxAvOWCpV3W5VP3sN0KzR2ggtC5lgdPbyD82lTrzEBGhHbl/zVV
         jgXfbuOw1jGziy83wB9hTGwdsjv4ZhO7BQ6GatcWglzoZ4t/CSjKnlq4tvlP16HM6j
         XbNshYE27aNocSa1fUOhZVL1Ki0M6/CMJ+n6BY4nlhd1sp+miX5ax7qwgRD+VveZim
         YXh54nbIMryejjDwZk2MwgXLAiYcZd35yxRzMOGWztc7i/zHAgaCuBp0CH+q6rKqy6
         KkKEwjedwvZ7lMSfiMLLRRyAsJdFXCWk/D2e/4PiUNfoaADrj6S/ItWpgXWheCUQ0r
         b62f8iB6QjxUw==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 09C36C06E1
        for <linux-rdma@vger.kernel.org>; Fri,  5 May 2023 11:01:55 +0000 (UTC)
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
Subject: [recipe build #3536121] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168328451503.5418.8389268479264993790.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Fri, 05 May 2023 11:01:55 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="90e2150bef31b411d7bae5c4032c7e320fcaaec8"; Instance="buildmaster"
X-Launchpad-Hash: f9ec4a56efd6884c23aad7545e08b14b5c78b248
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
aily/+recipebuild/3536121/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-026

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3536121
Your team Linux RDMA is the requester of the build.

