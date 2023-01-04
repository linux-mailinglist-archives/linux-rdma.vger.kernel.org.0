Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7703D65D159
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 12:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbjADLZL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Jan 2023 06:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjADLZI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Jan 2023 06:25:08 -0500
X-Greylist: delayed 391 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 03:25:06 PST
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4E91AA3C
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 03:25:06 -0800 (PST)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id E663E40C7B
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 11:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1672831112;
        bh=VeTy5vNoS5UlAlWubclGKlwWX9XGmqDW+tTxCyyHIMM=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=LCrZp0U9B2Us707v1h+rAk9Rn22mtEzaWbSaPnT1BaiA+QFc0zFhhwk4+Kb5haSmc
         weqM5OYWFzICiG/xXKUYW+J+XA1531nq4wd1UuOowghFStxl9jVeEn+m39W4ath8u6
         RHDMlI/Rh6UOZ0RdRcfRgiQRl5FmNAiHRAoyzJqrxNDrjNKJUTJH3Vs/kjOhWGyZjl
         Xt8RjuUX+Mp5Gt6G/1FEpZ+ma635nswQ9GzHX+FjwphwUhpM/EIas7KC4cX6ZmyYt8
         sLF+2629uKbG+tU4MCKAyja37s8i1ge8fZ/ZD3/Tt7e9V5vejjDQZsEKzgy6Pok25P
         TCnshMFvfOXQg==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id D39B6BB816
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 11:18:32 +0000 (UTC)
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
Subject: [recipe build #3474100] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <167283111286.23122.5704298615491148277.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 04 Jan 2023 11:18:32 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="31c78762a8046acf7ab47372e5d588ebb3759d2e"; Instance="buildmaster"
X-Launchpad-Hash: 51fbe912b33793d40c2444782b956f1a7c92d19d
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
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3474100/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-116

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3474100
Your team Linux RDMA is the requester of the build.

