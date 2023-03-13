Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F13D6B784E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Mar 2023 14:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCMNCD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Mar 2023 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCMNBx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Mar 2023 09:01:53 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E619F222EC
        for <linux-rdma@vger.kernel.org>; Mon, 13 Mar 2023 06:01:50 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 1FF613F6D3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Mar 2023 13:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1678712509;
        bh=tX6JDGJDhd9f5W7Sf7mCz8MRTpwCGcsgp8WQDVJuZzY=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=mBVxnxJBk2kDSEgrqVs8FuYobm90jzdmzL7oAJtJEvTwRFTUDPhd8QrpbGiPb+ktI
         Kn1Cbg1JOlDgpWVgBWXgw561gCyrOIwPT3tJt8+fBiemaM3O+rQplTMB9tYniapP9U
         VpalDnfCI8Pq8/9Q9pbIXhhSUjKr5Fg3O6nn8PEaOuA7fYCC8sJ68MRJ/2NoC7lOL3
         RNtLjEeVDUrMOG72G94VYPpKjebkht8HAzPQN6hsaSyAPEk9CVH6ES+aPKCiaUIQ8I
         LedG+P5+hgtu/ecVOe3mjmcuqFO7uZeLJAtfFaWty+4H3/NeugaylST4/OSz1+VlBA
         9kaDdlWkDW/6Q==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 5298BBDEE6
        for <linux-rdma@vger.kernel.org>; Mon, 13 Mar 2023 13:01:46 +0000 (UTC)
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
Subject: [recipe build #3509473] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <167871250630.7405.2483401991937109784.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Mon, 13 Mar 2023 13:01:46 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="997ba17554f0ee82f56d9282fce82d3e09a43780"; Instance="buildmaster"
X-Launchpad-Hash: 94c9a2222106d7842f88c35a765259316012207f
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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
aily/+recipebuild/3509473/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-111

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3509473
Your team Linux RDMA is the requester of the build.

