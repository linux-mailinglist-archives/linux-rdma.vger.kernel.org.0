Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52EE747049
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jul 2023 14:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGDMCA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jul 2023 08:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjGDMB7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jul 2023 08:01:59 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5611B7
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jul 2023 05:01:58 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 823573F353
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jul 2023 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1688472116;
        bh=FbTmfh3UX4N7gzMCt+9rhToPaYJixDkUKL05e3T90rA=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=Pj+0HkXZumgLAgZ1gVCLDcBRX2FG11WkG8XXCtuQ1Au8Xfa3ML58vIlpuk7xEVdWu
         3qsbKFFMGkxUoxg9JCoDvaezxgCYJD7KfqQVlVMPb0mR4bGwreUBRIUk+pMllFZ6ou
         FlhzNIjOuCnCr0/nVu2scUvaDm4UgAf1af8RcOWJvLj/tfwNC6GX4iWiU7dbt3qrUr
         CydEVpuVnlzymPBHSgAs1QPfDOVfFdNT+leP8xmPaHmjyen+tnF9A/Jl71902jlRHP
         jJ+6082Mdz7qcDy8PgPa0TRW/QX89c451+Ke3U1+qNGtWvQZ7iI80S2Mo/cz+b/cqf
         Z2NT9lYTwa5VQ==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 5A1EDBDE6A
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jul 2023 12:01:56 +0000 (UTC)
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
Subject: [recipe build #3568250] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <168847211633.790.2008314784190377892.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Tue, 04 Jul 2023 12:01:56 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="0574793d91fb0560c250e5488455be37b7fc4914"; Instance="buildmaster"
X-Launchpad-Hash: d28f606057c766f5f7394b66c1c9fbe8f6a570a2
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
aily/+recipebuild/3568250/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-061

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3568250
Your team Linux RDMA is the requester of the build.

