Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082A1761814
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 14:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjGYMQl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 08:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjGYMQl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 08:16:41 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411AAE47
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jul 2023 05:16:38 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 84C493F1A6
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jul 2023 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1690287396;
        bh=hZeffsJ8B7SEkhTVmgVYiGW/5Uqslz5oUyiW3hQa/KM=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=wlQ9f6CJ5kZMRkcXKML8R2W+DWHZqnPPZlpxOoWgDcDdVm76kMSYctyUTjLsy/rOd
         ui6aHatzyxdsNmziix7TJYXNmSQrrNtuirWppqD50rLdzRk0oAfgILbmSP110iqc7z
         AMGyVE3pYkPeC5+tEJvNiISZRdF5RXxw/tlwCPmxhQH6b3z6BcNjb59kqk8wrHEw7S
         UrDGI5NS1R2n439CSp2gT/2nPWyApG+pXcs56qCpB4bP14jX/t3Vpc/5fbP0GUXX66
         Ra32i0iWO9fCPqtuOmxm/dy0gfB55uecBt9aKMkqp7K451f8lrbQO328VziYfISc1h
         Ep/I5b0tajSvQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 6214D7E00C
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jul 2023 12:16:36 +0000 (UTC)
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
Subject: [recipe build #3578359] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169028739638.2729469.16153029173855904841.launchpad@buildd-manager.lp.internal>
Date:   Tue, 25 Jul 2023 12:16:36 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="e60c4611c46d594185bc417b3c1e1aadd6bb3034"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 85a16181e857f566fb364d9453ee0edfce58a5f6
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
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3578359/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/bos03-amd64-035

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3578359
Your team Linux RDMA is the requester of the build.

