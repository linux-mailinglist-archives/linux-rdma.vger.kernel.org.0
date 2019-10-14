Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C35DAD62D1
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2019 14:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbfJNMlt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Oct 2019 08:41:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:51284 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730908AbfJNMlt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Oct 2019 08:41:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 05:41:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,295,1566889200"; 
   d="scan'208";a="194213080"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.171])
  by fmsmga008.fm.intel.com with ESMTP; 14 Oct 2019 05:41:47 -0700
Date:   Mon, 14 Oct 2019 20:39:11 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     linux-rdma@vger.kernel.org
Subject: MCX516A-CCAT failed to set ip
Message-ID: <20191014123911.GA711781@jerryopenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,
   I’m using MCX516A-CCAT in RHEL-7.6 with kernel 4.19.45.
   The network script always failed to configure the NIC with static ip. There was no problem when using CX314A to get the ip address with the simliar network script.
   Could anyone give me some info to check why the network script failed to set the ip address?

   Detail:
     Network script:
       [rdma@rdmarhel0 network-scripts]$ cat ifcfg-ens801f0
       DEVICE=ens801f0
       BOOTPROTO=static
       HWADDR=24:8a:07:60:90:e1
       IPADDR=192.168.100.101
       NETMASK=255.255.255.0
       ONBOOT=yes

       [rdma@rdmarhel0 network-scripts]$ cat ifcfg-ens801f1
       DEVICE=ens801f1
       BOOTPROTO=static
       HWADDR=24:8a:07:60:90:e0
       IPADDR=173.168.100.101
       NETMASK=255.255.255.0
       ONBOOT=yes

     Restart network command:
       [rdma@rdmarhel0 ~]$ sudo service network restart

     Error output:
       Restarting network (via systemctl):  Job for network.service failed because the control process exited with error code.
       See "systemctl status network.service" and "journalctl -xe" for details.

    Further check:
       [rdma@rdmarhel0 ~]$ systemctl status network.service
       network.service - LSB: Bring up/down networking
          Loaded: loaded (/etc/rc.d/init.d/network; bad; vendor preset: disabled)
          Active: failed (Result: exit-code) since Mon 2019-10-14 16:43:38 CST; 5min ago
            Docs: man:systemd-sysv-generator(8)
         Process: 20373 ExecStop=/etc/rc.d/init.d/network stop (code=exited, status=0/SUCCESS)
         Process: 26051 ExecStart=/etc/rc.d/init.d/network start (code=exited, status=1/FAILURE)

       Oct 14 16:43:38 rdmarhel0 network[26051]: RTNETLINK answers: File exists
       Oct 14 16:43:38 rdmarhel0 network[26051]: RTNETLINK answers: File exists
       Oct 14 16:43:38 rdmarhel0 network[26051]: RTNETLINK answers: File exists
       Oct 14 16:43:38 rdmarhel0 network[26051]: RTNETLINK answers: File exists
       Oct 14 16:43:38 rdmarhel0 network[26051]: RTNETLINK answers: File exists
       Oct 14 16:43:38 rdmarhel0 network[26051]: RTNETLINK answers: File exists
       Oct 14 16:43:38 rdmarhel0 systemd[1]: network.service: control process exited, code=exited status=1
       Oct 14 16:43:38 rdmarhel0 systemd[1]: Failed to start LSB: Bring up/down networking.
       Oct 14 16:43:38 rdmarhel0 systemd[1]: Unit network.service entered failed state.
       Oct 14 16:43:38 rdmarhel0 systemd[1]: network.service failed.

    [rdma@rdmarhel0 ~]$ journalctl -xe
       -- Unit network.service has begun starting up.
       Oct 14 16:43:37 rdmarhel0 network[26051]: Bringing up loopback interface:  [  OK  ]
       Oct 14 16:43:37 rdmarhel0 network[26051]: Bringing up interface eno1:  [  OK  ]
       Oct 14 16:43:37 rdmarhel0 network[26051]: Bringing up interface ens785f0:  [  OK  ]
       Oct 14 16:43:37 rdmarhel0 network[26051]: Bringing up interface ens785f1:  [  OK  ]
       Oct 14 16:43:38 rdmarhel0 NetworkManager[14879]: <info>  [1571042618.1158] audit: op="connection-activate" uuid="e9345cc8-be74-0dd5-85a4-8260e310b66b" name="System ens801f0" result="fail" reason="No suitable d
       Oct 14 16:43:38 rdmarhel0 network[26051]: Bringing up interface ens801f0:  Error: Connection activation failed: No suitable device found for this connection.
       Oct 14 16:43:38 rdmarhel0 network[26051]: [FAILED]
       Oct 14 16:43:38 rdmarhel0 network[26051]: Bringing up interface ens801f1:  [  OK  ]
       Oct 14 16:43:38 rdmarhel0 network[26051]: RTNETLINK answers: File exists
       Oct 14 16:43:38 rdmarhel0 network[26051]: RTNETLINK answers: File exists
       Oct 14 16:43:38 rdmarhel0 systemd[1]: network.service: control process exited, code=exited status=1
       Oct 14 16:43:38 rdmarhel0 systemd[1]: Failed to start LSB: Bring up/down networking.
       -- Subject: Unit network.service has failed
       -- Defined-By: systemd
       -- Support: http://lists.freedesktop.org/mailman/listinfo/systemd-devel
       -- 
       -- Unit network.service has failed.
       -- 
       -- The result is failed.
       Oct 14 16:43:38 rdmarhel0 systemd[1]: Unit network.service entered failed state.
       Oct 14 16:43:38 rdmarhel0 systemd[1]: network.service failed.
       Oct 14 16:43:38 rdmarhel0 polkitd[14826]: Unregistered Authentication Agent for unix-process:26045:493383 (system bus name :1.338, object path /org/freedesktop/PolicyKit1/AuthenticationAgent, locale en_US.UTF-
       Oct 14 16:43:38 rdmarhel0 sudo[26025]: pam_unix(sudo:session): session closed for user root

Regards,
Changcheng
