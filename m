Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D16F527BFD
	for <lists+linux-rdma@lfdr.de>; Mon, 16 May 2022 04:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbiEPCe2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 May 2022 22:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiEPCe1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 May 2022 22:34:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4191BE86
        for <linux-rdma@vger.kernel.org>; Sun, 15 May 2022 19:34:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05CDC60907
        for <linux-rdma@vger.kernel.org>; Mon, 16 May 2022 02:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67B55C34115
        for <linux-rdma@vger.kernel.org>; Mon, 16 May 2022 02:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652668465;
        bh=idpnQ7VAuayEEs71jrleirs1Zgb8lYfExa5iN1BffSM=;
        h=From:To:Subject:Date:From;
        b=CHa4qbZ9zg7tmrYJFJIZtHnGlxBhGp/P2CiZxJDlnDLEbdbHRJ0NXdrggBSr8IOkK
         ldGydf0nk84xuj+DcGi28yYTPKHRSBWnMOkKjQTVoPegjWkV+K13NKUQNDZltj31m9
         /rm6pzR5JHZFktUplVYWDfzvz5ZrN2ZfeND22GHLSZ/cVP0KZwNsh2/Gp2fR4O8X42
         jUezs0vHAq+lKyYJ50Nn2k4srJL///OCYBxoyTMHNziIJFDD7iIJi/j1gTjt9+zjeP
         6X/OLLJTPFevsU1h939TxdN2YxotgiMQJN4RVVuNP5e+bHAl+QXML93AW2Czj5yDHn
         1O8PxNDnn3BTw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 507B1C05FD5; Mon, 16 May 2022 02:34:25 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-rdma@vger.kernel.org
Subject: [Bug 215982] New: ifdown vlan port which have nvmf target listener
 on it, kernel print "unregister_netdevice: waiting for enp5s0f0.55 to become
 free. Usage count = 1" repeatedly
Date:   Mon, 16 May 2022 02:34:25 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo
 drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Infiniband/RDMA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: yuanyangliu258@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-215982-11804@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215982

            Bug ID: 215982
           Summary: ifdown vlan port which have nvmf target listener on
                    it, kernel print "unregister_netdevice: waiting for
                    enp5s0f0.55 to become free. Usage count =3D 1"
                    repeatedly
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.19.0-4.19.241
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Infiniband/RDMA
          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
          Reporter: yuanyangliu258@gmail.com
        Regression: No

Created attachment 300965
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300965&action=3Dedit
Operation and messages

Enable a nvmf target listener on a VLAN port, and ifdown the VLAN port, ker=
nel
will print "kernel:unregister_netdevice: waiting for enp5s0f0.55 to become
free. Usage count =3D 1" repeatedly

Operation as follows:
1. insmod

        modprobe 8021q;  modprobe qed;  modprobe qede;  modprobe qedr;=20
modprobe nvmet-rdma

2. create a vlan port based on network-scripts; ifup enp5s0f0.55

        [root@redhat-10 network-scripts]# cat ifcfg-enp5s0f0.55
        BOOTPROTO=3Dnone
        IPV4_FAILURE_FATAL=3Dno
        NAME=3Denp5s0f0.55
        DEVICE=3Denp5s0f0.55
        ONBOOT=3Dno
        MTU=3D9000
        VLAN=3Dyes
        IPADDR=3D192.168.55.250
        NETMASK=3D255.255.255.0
        VLAN_EGRESS_PRIORITY_MAP=3D"0:3,1:3,2:3,3:3,4:3,5:3,6:3,7:3"

3. add a nvmf target listenner on the vlan port

        mkdir /sys/kernel/config/nvmet/ports/100
        cd /sys/kernel/config/nvmet/ports/100

        echo -n "192.168.55.250" > addr_traddr
        echo rdma > addr_trtype
        echo -n 4420 > addr_trsvcid
        echo ipv4 > addr_adrfam

        mkdir /sys/kernel/config/nvmet/subsystems/abc.nqn
        cd /sys/kernel/config/nvmet/subsystems/abc.nqn
        echo 1 > attr_allow_any_host

        ln -s /sys/kernel/config/nvmet/subsystems/abc.nqn=20
/sys/kernel/config/nvmet/ports/100/subsystems/abc.nqn

4. ifdown the vlan port

        ifdown enp5s0f0.55

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
