Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D652B543CB2
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jun 2022 21:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbiFHTWC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 15:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiFHTWA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 15:22:00 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382261BD7CB
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 12:21:59 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id D31153FC5A
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 19:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1654716117;
        bh=eCLgpOp+tVGeyTj3wO3/YFW2vmWvioz3XEcgdBTJibs=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=EhWCAldK7CE5bHXObdxosnxut0LGWew3htT1yQM9KD9280hnbewP7OBGCuf1hTUVC
         1ObvfPTPtpjvw6A/BS/b2J4cbIBq6dgSMc0+jffOHO0aCbjHlgUTtQGylnWTeu1Xou
         swLdoH5O65H7gFAbdPj2HyXbF0vHVZiaSTIvZjemRJvMMIsfcb4Pk9Awv2nNAqRVSk
         AtIqXiwvkj8KMrS3if1vwn0QwdGXSelWSEZro/lbRRIWWe0fbEqVsbDfc84ksweWvH
         DjQvCc+J+0L+NmZ4qOJ7BnoZDTLk0wuoCjjxNdjkNG3c8wbxll3vKipInRma0XDyhk
         6NEY/x8hTFVOg==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id BCBADC0719
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 19:21:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Creator @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: package-build-status
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: FAILEDTOUPLOAD
X-Creator-Recipient: linux-rdma@vger.kernel.org
X-Launchpad-Build-Component: main
X-Launchpad-Build-Arch: arm64
X-Launchpad-PPA: linux-rdma-rdma-core-daily
To:     Linux RDMA <linux-rdma@vger.kernel.org>
From:   Launchpad Buildd System <noreply@launchpad.net>
Subject: [Build #23830714] arm64 build of rdma-core 42.0~202206080810+gitc590cbd5~ubuntu21.10.1 in ubuntu impish RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <165471611777.26180.17451092254467787772.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 08 Jun 2022 19:21:57 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="0f209dcba08bdd5fd387de120244a7b387be6615"; Instance="buildmaster"
X-Launchpad-Hash: 52d846f3ef20be9bd4928aa3b8e09f75cdf51f98
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


 * Source Package: rdma-core
 * Version: 42.0~202206080810+gitc590cbd5~ubuntu21.10.1
 * Architecture: arm64
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to upload
 * Duration: 12 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/23830714/+files/buildlog_ubuntu-impish-arm64.rdma-core_42.0~202=
206080810+gitc590cbd5~ubuntu21.10.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-069
 * Source: not available

Upload log:
Uploading build 20220608-192055-PACKAGEBUILD-23830714 failed.

If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
arm64 build of rdma-core 42.0~202206080810+gitc590cbd5~ubuntu21.10.1 in ubu=
ntu impish RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/23=
830714

You are receiving this email because you created this version of this
package.

