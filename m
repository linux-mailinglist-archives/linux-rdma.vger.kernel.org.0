Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83672770046
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 14:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjHDMbx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Aug 2023 08:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHDMbw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Aug 2023 08:31:52 -0400
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8150146A8
        for <linux-rdma@vger.kernel.org>; Fri,  4 Aug 2023 05:31:51 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id E95013F1FA
        for <linux-rdma@vger.kernel.org>; Fri,  4 Aug 2023 12:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1691152309;
        bh=mctJbc0566/HuMeQGyFS3P2imOiyPPujpkYAl44DJeY=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=BWqCj+3DQmhXjev176+Cf9Ymx5fGKlMaVaO11Z0DEGea+GAbbAORB/pyBmYxFlR18
         Ypuu4yVlVkk4A4xaBCMM5YB68d5pPxZqEjppVn9OFgLLFkAUlSUW8k221IUy/x7CqI
         8df+fLQVxoJaBPyuM4OKYSLiOdcLOX1Cpvq1ynM15BxieyIFDyFMzFu/Jg7In1glGx
         b/T4p57Tt5Y+vZrKlWF4V/f6Vcpy5q5KaIAwS5xuiu6YQHRrwbFeZdzgfe2rpcFdwr
         JBdBHiP6IjRueJhpZrGuSVSDoOCGHotcMkm5z1sO33igkZeJzJPIs62e2BMxQnuV/E
         96i4S1qzsFRrw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id E9BF57E036
        for <linux-rdma@vger.kernel.org>; Fri,  4 Aug 2023 12:31:48 +0000 (UTC)
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
Subject: [recipe build #3584058] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169115230893.2513737.7788097414421340972.launchpad@buildd-manager.lp.internal>
Date:   Fri, 04 Aug 2023 12:31:48 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="6a25791a70c738891354c9239ccb07c6c99f87b3"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: aebb6c35a3626496b85906aa1552a8c516cd9528
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
aily/+recipebuild/3584058/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-039

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3584058
Your team Linux RDMA is the requester of the build.

