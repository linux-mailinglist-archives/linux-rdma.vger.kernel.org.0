Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A627B8DCA
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 22:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243561AbjJDUCu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Oct 2023 16:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjJDUCt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Oct 2023 16:02:49 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCC5AB
        for <linux-rdma@vger.kernel.org>; Wed,  4 Oct 2023 13:02:45 -0700 (PDT)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 4607B3F03A
        for <linux-rdma@vger.kernel.org>; Wed,  4 Oct 2023 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1696449764;
        bh=f+yUzVlfKVvCH8Xuuxoi/VHo2uxadX1MlH2/bCqPS1s=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=wWiJUq2VNbGAdN4zFcN5hUREuNVhk8HGiYVllFl3F8w+L+l1o5INIz6PASiW89B9L
         cH9x5AfZEjoo9NrTVOqoFoggWwjTFO4joHMwm1NriSMNx0d3lsMzZRrazzqaUTF/TT
         w5YSwLq4Mhu3TSVp3wzcoWkkdG1vko5xNfoXBOOn0p6rZxG4yDwkZNJ6+Nbl3LMkxw
         fe7HeKv1M7MoQn/FAPc5aYq4aJfppnYg2BPbT7fpz3fYvh4AXHR/jwcS1pUkZbRJmr
         T6fH6VyNKCF4x2gJWyH+MVO8ueGEWf0hjyLypRFgW1OU2MJ+SoTEu/IqVYKuGey6j7
         ZIZw5Ncxfwi/w==
Received: from [10.131.215.202] (localhost [127.0.0.1])
        by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id F29A37E706
        for <linux-rdma@vger.kernel.org>; Wed,  4 Oct 2023 20:02:43 +0000 (UTC)
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
Subject: [recipe build #3613078] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <169644976398.2566601.764581633595174772.launchpad@juju-98d295-prod-launchpad-15>
Date:   Wed, 04 Oct 2023 20:02:43 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="bd6cfd0cfc024dbe1dcd7d5d91165fb4f6a6c596"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 7bd9081e489a6a5258d58bec966f707e1e3a2170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
aily/+recipebuild/3613078/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-097

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3613078
Your team Linux RDMA is the requester of the build.

