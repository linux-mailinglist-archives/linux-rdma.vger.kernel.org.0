Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C09C712440F
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 11:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfLRKPF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 05:15:05 -0500
Received: from smtp56.i.mail.ru ([217.69.128.36]:34276 "EHLO smtp56.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfLRKPF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Dec 2019 05:15:05 -0500
X-Greylist: delayed 5140 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Dec 2019 05:15:03 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:From:To; bh=E8N9P+OFAwA0+JGvQbtCmfl+sIDkAgxdssD7mBzAlWw=;
        b=rwJ4OkJXjJgzkmfrCJWQAkL6wybd0ZGqC1kZyY7sWP1i6p7S8a5iQPk+Ite5/HekhueODXYJnEv1AMvrlg2mBcm/xJQ9SZmNR/d88pmVa+2dIPBE4rKv0dZVBeHRbaSr4PQCcEoOVJtwEB3QjkPQMWTamtyJDZ7XCi3YJLlIYoM=;
Received: by smtp56.i.mail.ru with esmtpa (envelope-from <6ax@mail.ru>)
        id 1ihWMA-0006yJ-3l
        for linux-rdma@vger.kernel.org; Wed, 18 Dec 2019 13:15:02 +0300
To:     linux-rdma@vger.kernel.org
From:   =?UTF-8?B?0KHQtdGA0LPQtdC5INChLiDQmNCz0L7RiNC60LjQvQ==?= 
        <6ax@mail.ru>
Subject: bug when working with the LAG interface. (bonding)
Message-ID: <29d399ba-696b-3e96-37ef-6fcc868c26ab@mail.ru>
Date:   Wed, 18 Dec 2019 13:15:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: ru
Authentication-Results: smtp56.i.mail.ru; auth=pass smtp.auth=6ax@mail.ru smtp.mailfrom=6ax@mail.ru
X-7564579A: 646B95376F6C166E
X-77F55803: 0A44E481635329DB0E1AA8A03B3923177A2A728850F00CFA73C14FAFA54B165C0692F7C3A22934DAF688BCB05C26794D7071740998BDA682440EFDCD17049B815D807779A4B662C34C855CF868C0B04F
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE729508FF2E8683A3EB287FD4696A6DC2FA8DF7F3B2552694A4E2F5AFA99E116B42401471946AA11AF855697CD6E926167AC83A81C8FD4AD23D82A6BABE6F325ACE7DDDDC251EA7DAB1B59CA4C82EFA6585F6761126049B72FFEEF38DE3786ADE8F6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249042F1592492B88C6CC7F00164DA146DAFE8445B8C89999725571747095F342E8C26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE74601F13E4625331C9FA2833FD35BB23DF004C906525384303BDABC7E18AA350CD8FC6C240DEA76428AA50765F7900637224F82CDA6A39718D81D268191BDAD3DBD4B6F7A4D31EC0B291844D9D418CE69D81D268191BDAD3D78DA827A17800CE72AD5C920F2753418EC76A7562686271ED187B4DA314F1B5535872C767BF85DA227C277FBC8AE2E8BE9E2ED79D3AF902F8AD3058B3B2BA07F35872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C99B0B8D173C204012BD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-Sender: EC4C7D74DBFAC2FBDE12C530951EB8CC718CA5EBE01A29473B3636DAE75C4E6F8818783B3234F304CD5CD1582D869527FB559BB5D741EB96CF1F2746847450F4B93E98C39DA16A030DA7A0AF5A3A8387
X-Mras: OK
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello. I apologize for my English. Apparently there is a bug when 
working with the LAG interface. (bonding)

root@server:~# cat /proc/net/bonding/bond0
Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)

Bonding Mode: load balancing (xor)
Transmit Hash Policy: layer2 (0)
MII Status: up
MII Polling Interval (ms): 100
Up Delay (ms): 200
Down Delay (ms): 200

Slave Interface: enp1s0f1
MII Status: up
Speed: 10000 Mbps
Duplex: full
Link Failure Count: 0
Permanent HW addr: 00:1b:21:bc:6e:7d
Slave queue ID: 0

Slave Interface: enp1s0f0
MII Status: up
Speed: 10000 Mbps
Duplex: full
Link Failure Count: 0
Permanent HW addr: 00:1b:21:bc:6e:7c
Slave queue ID: 0

Linux distribution and version: Ubuntu 18.04 LTS and  Arch Linux 
(2019-11-01)

Linux kernel and version: Linux server 4.15.0-72-generic #81-Ubuntu SMP 
and  Linux Arch 4.19.88-1-lts

InfiniBand hardware and firmware version: 10-Gigabit SFI/SFP+ Network 
Connection (Ethernet Server Adapter X520-2) 
https://ark.intel.com/content/www/us/en/ark/products/39776/intel-ethernet-converged-network-adapter-x520-da2.html

Configuring Soft-RoCE.

Reproduce the bug:

root@server:~# rxe_cfg add bond0

   Name        Link  Driver   Speed  NMTU  IPv4_addr      RDEV RMTU
   bond0       yes   bonding         9000  192.168.90.1   rxe0  (?)
   eno1        yes   e1000e          1500  192.168.5.208
   enp1s0f0    yes   ixgbe           9000
   enp1s0f1    yes   ixgbe           9000
   virbr0      no    bridge          1500  192.168.122.1

root@server:~# rxe_cfg status

IB device 'rxe0' wasn't found
   Name        Link  Driver   Speed  NMTU  IPv4_addr      RDEV RMTU
   bond0       yes   bonding         9000  192.168.90.1   rxe0 (?)
   eno1        yes   e1000e          1500  192.168.5.208
   enp1s0f0    yes   ixgbe           9000
   enp1s0f1    yes   ixgbe           9000
   virbr0      no    bridge          1500  192.168.122.1
   virbr0-nic  no    tun             1500

root@server:~# ibv_devices
     device                 node GUID
     ------              ----------------
root@server:~# ibv_devinfo
No IB devices found

root@server:~# ibstat rxe0
ibpanic: [1715] main: 'rxe0' IB device can't be found: Success

Also have problems with:
[root@test ~]# rdma link add rxe0 type rxe netdev bond1
error: Invalid argument
[root@test ~]# rdma link add rxe0 type rxe netdev enp0s3
error: Invalid argument

Tnx.

