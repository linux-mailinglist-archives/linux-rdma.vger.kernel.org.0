Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AAC543C7D
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jun 2022 21:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbiFHTJC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 15:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbiFHTI5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 15:08:57 -0400
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6BB15FCA
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 12:08:55 -0700 (PDT)
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id AE3233F07A
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 19:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
        s=20210803; t=1654715334;
        bh=jiSH8oYJXz1on+qKTyQV3sQjKZYFntMPmfooja3XikA=;
        h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
         Reply-To;
        b=oA0MvtLx68NQYMHLeSTd8J7R14rX3to7Agf6aq4ePR1ll2rGy7b740L0owvbwAqr7
         vyeB9q/JRmeL6KECmN0OfJvx41H7/NHBFJ9dmVJcizMTFpUgnMrZAKA9RxWWnSNpXq
         4uP4Vmcetp7w/fJxkT5nvceQAMJhtTGIdT+ZAvz8MEQo2+1y3AlU8rTRDVcTovciFx
         U22ofROsEPFiFxULD1BPDex1koArzKCLh8+DJSr4c8rwEi4n0jWhmGksFY+vhvJBin
         EATk+7LuiXNnsMEApbEyzog2j1CnfTNLu3oKw/ZjfPZ11VdpUulcbXkqZdDi2aL+YP
         zMlbYOwKIPmAQ==
Received: from juju-4112d9-prod-launchpad-manual-servers-4.lp.internal (localhost [127.0.0.1])
        by buildd-manager.lp.internal (Postfix) with ESMTP id 9D559C0718
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 19:08:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Creator @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: package-build-status
X-Launchpad-Build-Arch: s390x
X-Creator-Recipient: linux-rdma@vger.kernel.org
X-Launchpad-Build-Component: main
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: FAILEDTOUPLOAD
X-Launchpad-PPA: linux-rdma-rdma-core-daily
To:     Linux RDMA <linux-rdma@vger.kernel.org>
From:   Launchpad Buildd System <noreply@launchpad.net>
Subject: [Build #23830712] s390x build of rdma-core 42.0~202206080810+gitc590cbd5~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <165471533464.22589.11753381356346263238.launchpad@juju-4112d9-prod-launchpad-manual-servers-4.lp.internal>
Date:   Wed, 08 Jun 2022 19:08:54 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
X-Generated-By: Launchpad (canonical.com); Revision="0f209dcba08bdd5fd387de120244a7b387be6615"; Instance="buildmaster"
X-Launchpad-Hash: a5b8421b2073e9539e4d061801e47e4fde3f30ac
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
 * Version: 42.0~202206080810+gitc590cbd5~ubuntu20.04.1
 * Architecture: s390x
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to upload
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/23830712/+files/buildlog_ubuntu-focal-s390x.rdma-core_42.0~2022=
06080810+gitc590cbd5~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-s390x-015
 * Source: not available

Upload log:
Uploading build 20220608-190729-PACKAGEBUILD-23830712 failed.

If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
s390x build of rdma-core 42.0~202206080810+gitc590cbd5~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/23=
830712

You are receiving this email because you created this version of this
package.

