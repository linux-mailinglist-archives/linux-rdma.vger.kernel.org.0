Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF7F6C0DC0
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 10:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjCTJzI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Mar 2023 05:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjCTJzG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Mar 2023 05:55:06 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7D2706
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 02:55:00 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 06A1D406D4
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 09:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1679305630;
        bh=pr90rsyVGt7gN7/qeQ1SZFwbO8BRygfXP5TtsX10wdw=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=FwYCisegZn2bK4crsI3H9pyQvGkU3I535PuT3VJBaHD+5eJXZCUpVmmf3K7KPqXdM
         8F3gpZWBAlSGddJMG/jF/M7breevpOtYH6x+CIl1Uahfqrj31p1w7O85LAuStFFpGI
         gddq3OSoL4oyXv4l/5JBWT+g/xa6iGvSJcISu0aR9FhN9GhxyStQ/JHdLxTT+biWtZ
         pCuelsvAsLvGVU+b0IlCHs4fE/hSAASG/Ti2u/p4wJIDO2zTCkpkDMyJgplK54lPNn
         nSJG8bKJHU/ZpEVVlgH7niuc7DPitBIccz7YjcTtEZ4EDFuRApWIU4x8N5kCZYt+EI
         8tG4T8LLuudYA==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id BA703BDEE6
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 09:46:57 +0000 (UTC)
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
Subject: [recipe build #3513090] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <167930561773.23548.5885952154526916791.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Mon, 20 Mar 2023 09:46:57 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="997ba17554f0ee82f56d9282fce82d3e09a43780"; Instance="buildmaster"
X-Launchpad-Hash: 57e37499c319a87ce3f1a35621a8114b0d4179ed
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
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3513090/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-030

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3513090
Your team Linux RDMA is the requester of the build.

